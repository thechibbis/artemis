{ pkgs, ... }:
let
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    recommendedEnvironment = true;
    extraConfig = ''
        env = QT_QPA_PLATFORM,wayland
        env = GDK_BACKEND=wayland,x11
        env = QT_QPA_PLATFORM="wayland;xcb"
        env = SDL_VIDEODRIVER=wayland
        env = CLUTTER_BACKEND=wayland
        env = XDG_CURRENT_DESKTOP=Hyprland
        env = XDG_SESSION_TYPE=wayland
        env = XDG_SESSION_DESKTOP=Hyprland
        env = QT_QPA_PLATFORM=wayland;xcb
        env = QT_WAYLAND_DISABLE_WINDOWDECORATION=1
        env = QT_QPA_PLATFORMTHEME=qt5ct
        env = GBM_BACKEND=nvidia-drm
        env = __GLX_VENDOR_LIBRARY_NAME=nvidia
        env = LIBVA_DRIVER_NAME=nvidia
        env = WLR_NO_HARDWARE_CURSORS,1

        exec-once = swaybg -m fill -i ~/Pictures/wallpaper_artemis.jpg
        exec-once = eww open bar

        input {
            kb_layout = us
            kb_variant =
            kb_model =
            kb_options =
            kb_rules =
        
            follow_mouse = 1
        
            touchpad {
                natural_scroll = false
            }
        
            sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
        }
        
        general {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more
        
            gaps_in = 5
            gaps_out = 14
            border_size = 1.5
            col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
            col.inactive_border = rgba(595959aa)
        
            layout = dwindle
        }
        
        decoration {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more
        
            rounding = 5
            blur = true
            blur_size = 3
            blur_passes = 1
            blur_new_optimizations = true
        
            drop_shadow = true
            shadow_range = 4
            shadow_render_power = 3
            col.shadow = rgba(1a1a1aee)
        }
        
        animations {
            enabled = true
        
            # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        
            bezier = myBezier, 0.05, 0.9, 0.1, 1.05
        
            animation = windows, 1, 7, myBezier
            animation = windowsOut, 1, 7, default, popin 80%
            animation = border, 1, 10, default
            animation = borderangle, 1, 8, default
            animation = fade, 1, 7, default
            animation = workspaces, 1, 6, default
        }
        
        dwindle {
            # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
            pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
            preserve_split = true # you probably want this
        }
        
        master {
            # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
            new_is_master = true
        }
        
        gestures {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more
            workspace_swipe = false
        }
        
        # Example per-device config
        # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
        device:epic-mouse-v1 {
            sensitivity = -0.5
        }
        
        # Example windowrule v1
        # windowrule = float, ^(kitty)$
        # Example windowrule v2
        # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
        # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

        windowrulev2 = opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$
        windowrulev2 = noanim,class:^(xwaylandvideobridge)$
        windowrulev2 = nofocus,class:^(xwaylandvideobridge)$
        windowrulev2 = noinitialfocus,class:^(xwaylandvideobridge)$
                
        # See https://wiki.hyprland.org/Configuring/Keywords/ for more
        $mainMod = SUPER
        
        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        bind = $mainMod, RETURN, exec, kitty
        bind = SUPER_SHIFT, Q, killactive,
        bind = $mainMod, M, exit,
        bind = $mainMod, E, exec, dolphin
        bind = $mainMod, F, togglefloating,
        bind = $mainMod, D, exec, ${pkgs.wofi}/bin/wofi --show drun
        bind = SUPER_SHIFT, S, exec, top
        bind = $mainMod, P, pseudo, # dwindle
        bind = $mainMod, J, togglesplit, # dwindle
        
        # Move focus with mainMod + arrow keys
        bind = $mainMod, left, movefocus, l
        bind = $mainMod, right, movefocus, r
        bind = $mainMod, up, movefocus, u
        bind = $mainMod, down, movefocus, d
        
        # Switch workspaces with mainMod + [0-9]
        bind = $mainMod, 1, workspace, 1
        bind = $mainMod, 2, workspace, 2
        bind = $mainMod, 3, workspace, 3
        bind = $mainMod, 4, workspace, 4
        bind = $mainMod, 5, workspace, 5
        bind = $mainMod, 6, workspace, 6
        bind = $mainMod, 7, workspace, 7
        bind = $mainMod, 8, workspace, 8
        bind = $mainMod, 9, workspace, 9
        bind = $mainMod, 0, workspace, 10
        
        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        bind = $mainMod SHIFT, 1, movetoworkspace, 1
        bind = $mainMod SHIFT, 2, movetoworkspace, 2
        bind = $mainMod SHIFT, 3, movetoworkspace, 3
        bind = $mainMod SHIFT, 4, movetoworkspace, 4
        bind = $mainMod SHIFT, 5, movetoworkspace, 5
        bind = $mainMod SHIFT, 6, movetoworkspace, 6
        bind = $mainMod SHIFT, 7, movetoworkspace, 7
        bind = $mainMod SHIFT, 8, movetoworkspace, 8
        bind = $mainMod SHIFT, 9, movetoworkspace, 9
        bind = $mainMod SHIFT, 0, movetoworkspace, 10
        
        # Scroll through existing workspaces with mainMod + scroll
        bind = $mainMod, mouse_down, workspace, e+1
        bind = $mainMod, mouse_up, workspace, e-1
        
        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = $mainMod, mouse:272, movewindow
        bindm = $mainMod, mouse:273, resizewindow
    '';
  };
}