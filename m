Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53E2751DDF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 11:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjGMJyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 05:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbjGMJy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 05:54:29 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5602E2699
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:54:25 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-794b8fe8cc4so1224283241.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 02:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689242064; x=1691834064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ez7jO3FwSNuyNsnYNkkVbBkbWTziZ+QozPC9B1QClXc=;
        b=TwWySFX65K4Kk5BaFFcJGCBnpYrBPYSB55nVGuUvT/7/6WOOFdDxXv5/qrBHW6mDkz
         iykBZ1oenDPsmZYWVD5U5/2y6TEv3r9cpW+Bz3uL+saGdI+0RNnZ5e90TpsvuLTt8znN
         FFTjM2QbiT74BVpbVut07WDKRZH4mVHRyEoOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689242064; x=1691834064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ez7jO3FwSNuyNsnYNkkVbBkbWTziZ+QozPC9B1QClXc=;
        b=cmbtOy2YEduiJb7EO06kWMdLDVg2JYniIVy6arKgZ36n2iXlfTyjfCLcHsMTLRrbZ/
         vF6Gzx2xmLBuR7OClNYfzC1sbRLShK76HgTL9G5SlAj+fxOzLh+nINEiGOujTlwlIaAd
         b+hSq223MlSrqMkx8S++9+kPLGqPdqb/VhPl5vL+RzPxYD4Sniy/VqnL43UHUuL56MWL
         r2TDRJQEjMeiq1YCu279TSRfCN6fjq/y+cKgBYw2PXGbuiSaF3k9VUxUvwS8rEwKHcf6
         44NPAzYfoPGwtODaVDPRVkFXQMYc9lrtJV6EHLb73Ts95D0ZoUYvVB/WqPp8wUGPhbfW
         AuvA==
X-Gm-Message-State: ABy/qLaUZMuRhUztLpgAh6RX+Lpcb8RyEL2y9nNce6dDKs6uOdN+jMZz
        ywYkAWU7uAkTFABcAlAY+i6mMlVdyRncKycGqQpxeGZwVZGm057XfOE=
X-Google-Smtp-Source: APBJJlG0g9o4LrYXn9i6KRU1GfTejJ2FCgLiKAmk2lqQULqSb0JVk97uYqtYXThV3P31Unv3MseiH1FrhSYUrYFZ+z0=
X-Received: by 2002:a1f:a10a:0:b0:481:588d:90e4 with SMTP id
 k10-20020a1fa10a000000b00481588d90e4mr188535vke.7.1689242064326; Thu, 13 Jul
 2023 02:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230713090152.140060-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230713090152.140060-1-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 13 Jul 2023 17:54:13 +0800
Message-ID: <CAGXv+5FFO3pDM=2eDscGnRVj34+8t6L02nt7OvPEO_FV8_POVQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] MediaTek DisplayPort: support eDP and aux-bus
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@gmail.com,
        daniel@ffwll.ch, matthias.bgg@gmail.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 5:01=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Changes in v5:
>  - Added .wait_hpd_asserted() callback for aux-bus
>  - Avoid enabling and registering HPD interrupt + handlers for
>    eDP case only (keeps HPD interrupts enabled for full DP case)
>  - Support not always-on eDP panels (boot with regulator off,
>    suspend with regulator off) for power saving in PM suspend.

This still doesn't work when the DRM driver is builtin, and the panel
driver is a module. This is still with regulator-always-on.

From what I can tell from the kernel logs, the DRM driver is not waiting
for eDP panel to probe (which sort of makes sense?), and simply uses
the default EDID. When the panel does probe, nothing triggers the DRM
driver to update its connector.

[drm:drm_helper_probe_single_connector_modes] [CONNECTOR:32:eDP-1]
[drm:drm_helper_probe_single_connector_modes] [CONNECTOR:32:eDP-1]
status updated from unknown to connected
[drm:drm_mode_debug_printmodeline] Modeline "640x480": 60 25175 640
656 752 800 480 490 492 525 0x40 0xa
[drm:drm_mode_prune_invalid] Not using 640x480 mode: CLOCK_HIGH
[drm:drm_mode_debug_printmodeline] Modeline "800x600": 56 36000 800
824 896 1024 600 601 603 625 0x40 0x5
[drm:drm_mode_prune_invalid] Not using 800x600 mode: CLOCK_HIGH
[drm:drm_mode_debug_printmodeline] Modeline "800x600": 60 40000 800
840 968 1056 600 601 605 628 0x40 0x5
[drm:drm_mode_prune_invalid] Not using 800x600 mode: CLOCK_HIGH
[drm:drm_mode_debug_printmodeline] Modeline "848x480": 60 33750 848
864 976 1088 480 486 494 517 0x40 0x5
[drm:drm_mode_prune_invalid] Not using 848x480 mode: CLOCK_HIGH
[drm:drm_mode_debug_printmodeline] Modeline "1024x768": 60 65000 1024
1048 1184 1344 768 771 777 806 0x40 0xa
[drm:drm_mode_prune_invalid] Not using 1024x768 mode: CLOCK_HIGH
[drm:drm_helper_probe_single_connector_modes] [CONNECTOR:34:DP-1]
[drm:drm_helper_probe_single_connector_modes] [CONNECTOR:34:DP-1]
status updated from unknown to disconnected
[drm:drm_helper_probe_single_connector_modes] [CONNECTOR:34:DP-1] disconnec=
ted
[drm:drm_client_modeset_probe] No connectors reported connected with modes
[drm:drm_client_modeset_probe] connector 32 enabled? yes
[drm:drm_client_modeset_probe] connector 34 enabled? no
[drm:drm_client_firmware_config.constprop.0.isra.0] Not using firmware
configuration
[drm:drm_client_modeset_probe] looking for cmdline mode on connector 32
[drm:drm_client_modeset_probe] looking for preferred mode on connector 32 0
[drm:drm_client_modeset_probe] found mode none
[drm:drm_client_modeset_probe] picking CRTCs for 4096x4096 config
mediatek-drm mediatek-drm.12.auto:
[drm:__drm_fb_helper_initial_config_and_unlock] test CRTC 0 primary
plane
mediatek-drm mediatek-drm.12.auto: [drm] Cannot find any crtc or sizes
mediatek-drm mediatek-drm.12.auto: [drm:drm_dp_dpcd_probe] aux_mtk_dp:
0x00000 AUX -> (ret=3D  1) 14
mediatek-drm mediatek-drm.12.auto: [drm:drm_dp_dpcd_read] aux_mtk_dp:
0x00000 AUX -> (ret=3D 15) 14 0a 84 41 00 00 01 80 02 00 00 00 0f 09 80
mediatek-drm mediatek-drm.12.auto: [drm:drm_dp_dpcd_probe] aux_mtk_dp:
0x00000 AUX -> (ret=3D  1) 14
mediatek-drm mediatek-drm.12.auto: [drm:drm_dp_dpcd_read] aux_mtk_dp:
0x02200 AUX -> (ret=3D 15) 14 0a 84 41 00 00 01 80 02 00 00 00 0f 01 80
mediatek-drm mediatek-drm.12.auto: [drm:drm_dp_read_dpcd_caps]
aux_mtk_dp: Base DPCD: 14 0a 84 41 00 00 01 80 02 00 00 00 0f 09 80
mediatek-drm mediatek-drm.12.auto: [drm:drm_dp_read_dpcd_caps]
aux_mtk_dp: DPCD: 14 0a 84 41 00 00 01 80 02 00 00 00 0f 01 80
mediatek-drm mediatek-drm.12.auto: [drm:drm_dp_dpcd_probe] aux_mtk_dp:
0x00000 AUX -> (ret=3D  1) 14
mediatek-drm mediatek-drm.12.auto: [drm:drm_dp_dpcd_read] aux_mtk_dp:
0x00021 AUX -> (ret=3D  1) 00
panel-simple-dp-aux aux-1c500000.edp-tx: Detected BOE NE135FBM-N41 v8.1 (0x=
095f)

If the panel is also built-in, then the eDP panel probe happens between
the drm driver adding components and binding to them, and everything seems
to work OK.


ChenYu

> Changes in v4:
>  - Set data lanes to idle to prevent stalls if bootloader didn't
>    properly close the eDP port
>  - Now using the .done_probing() callback for AUX bus to prevent
>    probe deferral loops in case the panel-edp driver is a module
>    as previously seen with another bridge driver (ANX7625) on
>    some other SoCs (MT8192 and others)
>  - Rebased over next-20230706
>  - Dropped Chen-Yu's T-b tag on last patch as some logic changed
>    (before, I wasn't using the .done_probing() callback).
>
> Changes in v3:
>  - Added DPTX AUX block initialization before trying to communicate
>    to stop relying on the bootloader keeping it initialized before
>    booting Linux.
>  - Fixed commit description for patch [09/09] and removed commented
>    out code (that slipped from dev phase.. sorry!).
>
> This series adds "real" support for eDP in the mtk-dp DisplayPort driver.
>
> Explaining the "real":
> Before this change, the DisplayPort driver did support eDP to some
> extent, but it was treating it entirely like a regular DP interface
> which is partially fine, after all, embedded DisplayPort *is* actually
> DisplayPort, but there might be some differences to account for... and
> this is for both small performance improvements and, more importantly,
> for correct functionality in some systems.
>
> Functionality first:
>
> One of the common differences found in various boards implementing eDP
> and machines using an eDP panel is that many times the HPD line is not
> connected. This *must* be accounted for: at startup, this specific IP
> will raise a HPD interrupt (which should maybe be ignored... as it does
> not appear to be a "real" event...) that will make the eDP panel to be
> detected and to actually work but, after a suspend-resume cycle, there
> will be no HPD interrupt (as there's no HPD line in my case!) producing
> a functionality issue - specifically, the DP Link Training fails because
> the panel doesn't get powered up, then it stays black and won't work
> until rebooting the machine (or removing and reinserting the module I
> think, but I haven't tried that).
>
> Now for.. both:
> eDP panels are *e*DP because they are *not* removable (in the sense that
> you can't unplug the cable without disassembling the machine, in which
> case, the machine shall be powered down..!): this (correct) assumption
> makes us able to solve some issues and to also gain a little performance
> during PM operations.
>
> What was done here is:
>  - Caching the EDID if the panel is eDP: we're always going to read the
>    same data everytime, so we can just cache that (as it's small enough)
>    shortening PM resume times for the eDP driver instance;
>  - Always return connector_status_connected if it's eDP: non-removable
>    means connector_status_disconnected can't happen during runtime...
>    this also saves us some time and even power, as we won't have to
>    perform yet another power cycle of the HW;
>  - Added aux-bus support!
>    This makes us able to rely on panel autodetection from the EDID,
>    avoiding to add more and more panel timings to panel-edp and, even
>    better, allowing to use one panel node in devicetrees for multiple
>    variants of the same machine since, at that point, it's not important
>    to "preventively know" what panel we have (eh, it's autodetected...!).
>
> This was tested on a MT8195 Cherry Tomato Chromebook (panel-edp on aux-bu=
s)
>
>
> P.S.: For your own testing commodity, here's a reference devicetree:
>
> pp3300_disp_x: regulator-pp3300-disp-x {
>         compatible =3D "regulator-fixed";
>         regulator-name =3D "pp3300_disp_x";
>         regulator-min-microvolt =3D <3300000>;
>         regulator-max-microvolt =3D <3300000>;
>         enable-active-high;
>         gpio =3D <&pio 55 GPIO_ACTIVE_HIGH>;
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&panel_fixed_pins>;
> };
>
> &edp_tx {
>         status =3D "okay";
>
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&edptx_pins_default>;
>
>         ports {
>                 #address-cells =3D <1>;
>                 #size-cells =3D <0>;
>
>                 port@0 {
>                         reg =3D <0>;
>                         edp_in: endpoint {
>                                 remote-endpoint =3D <&dp_intf0_out>;
>                         };
>                 };
>
>                 port@1 {
>                         reg =3D <1>;
>                         edp_out: endpoint {
>                                 data-lanes =3D <0 1 2 3>;
>                                 remote-endpoint =3D <&panel_in>;
>                         };
>                 };
>         };
>
>         aux-bus {
>                 panel: panel {
>                         compatible =3D "edp-panel";
>                         power-supply =3D <&pp3300_disp_x>;
>                         backlight =3D <&backlight_lcd0>;
>                         port {
>                                 panel_in: endpoint {
>                                         remote-endpoint =3D <&edp_out>;
>                                 };
>                         };
>                 };
>         };
> };
>
> AngeloGioacchino Del Regno (10):
>   drm/mediatek: dp: Move AUX and panel poweron/off sequence to function
>   drm/mediatek: dp: Change logging to dev for mtk_dp_aux_transfer()
>   drm/mediatek: dp: Use devm variant of drm_bridge_add()
>   drm/mediatek: dp: Move AUX_P0 setting to
>     mtk_dp_initialize_aux_settings()
>   drm/mediatek: dp: Enable event interrupt only when bridge attached
>   drm/mediatek: dp: Avoid mutex locks if audio is not supported/enabled
>   drm/mediatek: dp: Move PHY registration to new function
>   drm/mediatek: dp: Add support for embedded DisplayPort aux-bus
>   drm/mediatek: dp: Add .wait_hpd_asserted() for AUX bus
>   drm/mediatek: dp: Don't register HPD interrupt handler for eDP case
>
>  drivers/gpu/drm/mediatek/Kconfig  |   1 +
>  drivers/gpu/drm/mediatek/mtk_dp.c | 335 ++++++++++++++++++++----------
>  2 files changed, 224 insertions(+), 112 deletions(-)
>
> --
> 2.40.1
>
