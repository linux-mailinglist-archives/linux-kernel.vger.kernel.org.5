Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E9F758C45
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 06:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjGSEAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 00:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjGSEAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 00:00:40 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCCFA4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 21:00:38 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-48142b4134eso2250466e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 21:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689739237; x=1690344037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7EJ5zB5DOPvJ7pK4sEWpXxfhIszgBiKWP88tK+1U1M=;
        b=H9cVKb4xASnM0ZBO8Q2P2hPb6slM+GucaAOC9zWZVjD1XCoEoicK+BN2Fn5hrejFvj
         JPPjsduw+5sAYOg14bbZTzdjxaTa9hgTFzCP8g+gDt6DGG+9jqZYiNXwOzt8YltQ4QOP
         ikZP47dJLFdjANN4H84g27D2K/iIJEqK1+X1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689739237; x=1690344037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7EJ5zB5DOPvJ7pK4sEWpXxfhIszgBiKWP88tK+1U1M=;
        b=FTaZhOzTMGSYXFK6XFwCLLGGJmI95L2p3Z4dOsaioGmZzS4UsyKLBU8IJrt1kuM+vS
         plN6lTDwe8ofjofF9GV7SoH7RvQXeGhApEoehd0aZdd5YERULhTto9d4qbyTeRP5v+Hm
         hKNr6N12LuKVAcexvrX+k9fqEfSFvx6Wka/fMkyKvKD43Et3lTwGjqoSjypVb6G5eUAW
         JwC/dCsR3fCwa9LXt6VPFoodqsSgEWssVJFgZkXElVDCDkSmyTdxGxqSqGB57ofQRuI5
         y6qRxzEMZuz9Pfow+L7hJrjfV7kTwEkV9h0uA28+VUgil9RNu/fsOtRcBnsx6wOnw0IK
         VjLQ==
X-Gm-Message-State: ABy/qLbZRypgOuGk8bG0v5Ik82qlFcY2bDo9PZBCTLP8SIQqAYZ4NpWY
        3ivDNgECPSrrkpDkO0P7l5REYqMnX29JntMVYtD3HQ==
X-Google-Smtp-Source: APBJJlGmgLbuE5tXVlJwO1VEp9w9K8+5jjuSCaRiBo1+1Bjo4mDvAyE8GnkC+Q0tNXncMQoiIW9BBSCNnkUSAyxqC5w=
X-Received: by 2002:a1f:3d44:0:b0:465:fa30:d633 with SMTP id
 k65-20020a1f3d44000000b00465fa30d633mr1058808vka.0.1689739237275; Tue, 18 Jul
 2023 21:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230717141438.274419-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230717141438.274419-1-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 19 Jul 2023 12:00:25 +0800
Message-ID: <CAGXv+5E89K9UcSsF1p5Ni=J4CBsqF-p+dXJJ6xjgFCWWAm2OVg@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] MediaTek DisplayPort: support eDP and aux-bus
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 10:14=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Changes in v6:
>  - Added some previously missing error checking (patch [01/11])
>  - Added error checks for devm_drm_bridge_add()
>  - Made sure that cable_plugged_in is set to false if HPD assertion
>    polling fails (timeout)
>  - Support panel as module (tested with panel-edp on MT8195 Tomato)
>  - Rebased over next-20230717

Whole series is

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

With panel-edp builtin & as a module, and tested external display,
all on MT8195 Tomato.

Thanks!

> Changes in v5:
>  - Added .wait_hpd_asserted() callback for aux-bus
>  - Avoid enabling and registering HPD interrupt + handlers for
>    eDP case only (keeps HPD interrupts enabled for full DP case)
>  - Support not always-on eDP panels (boot with regulator off,
>    suspend with regulator off) for power saving in PM suspend.
>
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
> AngeloGioacchino Del Regno (11):
>   drm/mediatek: dp: Add missing error checks in
>     mtk_dp_parse_capabilities
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
>  drivers/gpu/drm/mediatek/mtk_dp.c | 360 ++++++++++++++++++++----------
>  2 files changed, 242 insertions(+), 119 deletions(-)
>
> --
> 2.40.1
>
