Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A3A7EB91F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 23:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjKNWAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 17:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjKNWAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 17:00:11 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91C6D8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 14:00:07 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5b3b17d36d5so2272507b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 14:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699999207; x=1700604007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4tkp0pNhREDkznZ6REwT+kycEKvkr58P94bq5ze7hk=;
        b=mMYEfE0bPBvGTFiBcNxZvyCc/xpzdaB99u2z/9jdgl3ywCd4aazG7fBjeptHf9z3q9
         uzuh+jfL7PM8b5DId7zctO+5bpWEbIDWRV6h75cJVrq2iiZkeH2KKgJYKVRnuvE4PHHd
         25sY2TIcHmVjhAlPt2lGgqSsW2j4VLkj3SaDLs/HTC/POeJCiaUCA+32HOnO2qeIMDS+
         Jck0T7DqqxEfPgP9vQ6l06/+3a/uECX6S3+FRCcjS+OvsyldD9zpRNwD2Rk57X7pMmDL
         86yng3LKytS7tg45D8Ad5Pge58wRTPA9u3n4SExQzZv0NCXx+UmwHEPwPrh5YjZ3GZH7
         xGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699999207; x=1700604007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4tkp0pNhREDkznZ6REwT+kycEKvkr58P94bq5ze7hk=;
        b=Z02fM5VCsQ5y3945UgZo0FmrhaPj9cCscmdDwroHfEoZ7H9YvcxhkyBPdTwURCqvux
         Wd5+YTsSLZh2co+wR6Xb88BXGIXRM6GUqlJpwzWwzl+rq4m1bAuFvupvjG+OWQlTFom7
         gJqlPcAgVe4DgOZnBhFxtW7jT4MbQaxHAjRTAJbxH03GuE9X9He1rUWZq0QFAu6x9mSI
         80/MfyS/GO8RQnm69Vyr5+sfh5+3WkD/2LVkGAinppFa4v7YmfgKRH+TscpRJVGgqAq0
         ll5pxTCJQVIT2b/OwkOU39G3JRjU4ongDB4ejFKbMNeP12YB190Zy+uQuvBoEJfQQwLr
         AKug==
X-Gm-Message-State: AOJu0Ywt7umCOE1MWEcmsN9O/gUGv7bMi4mJPO6tgs35xWGc2W+wbP19
        z/3yJQpsZljO5TgyHWbHx8MOCTygn3GPW+C0/CGYAQ==
X-Google-Smtp-Source: AGHT+IGPsFwqqRTI0aqsrhjnA4TAmnocjov5GP3o72Xb59wx2ikBIV1+52m8as7ZQP2KQjhxAKk8LG/atur+80vWxjc=
X-Received: by 2002:a81:8005:0:b0:5c0:2166:2861 with SMTP id
 q5-20020a818005000000b005c021662861mr2580531ywf.22.1699999206806; Tue, 14 Nov
 2023 14:00:06 -0800 (PST)
MIME-Version: 1.0
References: <20230807061115.3244501-1-victor.liu@nxp.com>
In-Reply-To: <20230807061115.3244501-1-victor.liu@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Nov 2023 22:59:54 +0100
Message-ID: <CACRpkdaGzXD6HbiX7mVUNJAJtMEPG00Pp6+nJ1P0JrfJ-ArMvQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/bridge: panel: Add a device link between drm
 device and panel device
To:     Liu Ying <victor.liu@nxp.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 8:06=E2=80=AFAM Liu Ying <victor.liu@nxp.com> wrote:

> Add the device link when panel bridge is attached and delete the link
> when panel bridge is detached.  The drm device is the consumer while
> the panel device is the supplier.  This makes sure that the drm device
> suspends eariler and resumes later than the panel device, hence resolves
> problems where the order is reversed, like the problematic case mentioned
> in the below link.
>
> Link: https://lore.kernel.org/lkml/CAPDyKFr0XjrU_udKoUKQ_q8RWaUkyqL+8fV-7=
s1CTMqi7u3-Rg@mail.gmail.com/T/
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v2->v3:
> * Improve commit message s/swapped/reversed/.

This patch causes a regression in the Ux500 MCDE
drivers/gpu/drm/mcde/* driver with the nt35510 panel
drivers/gpu/drm/panel/panel-novatek-nt35510.c
my dmesg looks like this:

[    1.678680] mcde a0350000.mcde: MCDE clk rate 199680000 Hz
[    1.684448] mcde a0350000.mcde: found MCDE HW revision 3.0 (dev 8,
metal fix 0)
[    1.692840] mcde-dsi a0351000.dsi: HW revision 0x02327457
[    1.699310] mcde-dsi a0351000.dsi: attached DSI device with 2 lanes
[    1.705627] mcde-dsi a0351000.dsi: format 00000000, 24bpp
[    1.711059] mcde-dsi a0351000.dsi: mode flags: 00000400
[    1.716400] mcde-dsi a0351000.dsi: registered DSI host
[    1.722473] mcde-dsi a0352000.dsi: HW revision 0x02327457
[    1.727874] mcde-dsi a0352000.dsi: registered DSI host
[    1.733734] mcde-dsi a0353000.dsi: HW revision 0x02327457
[    1.739135] mcde-dsi a0353000.dsi: registered DSI host
[    1.814971] mcde-dsi a0351000.dsi: connected to panel
[    1.820037] mcde-dsi a0351000.dsi: initialized MCDE DSI bridge
[    1.825958] mcde a0350000.mcde: bound a0351000.dsi (ops
mcde_dsi_component_ops)
[    1.833312] mcde-dsi a0352000.dsi: unused DSI interface
[    1.838531] mcde a0350000.mcde: bound a0352000.dsi (ops
mcde_dsi_component_ops)
[    1.845886] mcde-dsi a0353000.dsi: unused DSI interface
[    1.851135] mcde a0350000.mcde: bound a0353000.dsi (ops
mcde_dsi_component_ops)
[    1.858917] [drm:panel_bridge_attach] *ERROR* Failed to add device
link between a0350000.mcde and a0351000.dsi.0
[    1.869171] [drm:drm_bridge_attach] *ERROR* failed to attach bridge
/soc/mcde@a0350000/dsi@a0351000/panel to encoder None-34: -22
[    1.880920] [drm:drm_bridge_attach] *ERROR* failed to attach bridge
/soc/mcde@a0350000/dsi@a0351000 to encoder None-34: -22
[    1.892120] mcde a0350000.mcde: failed to attach display output bridge
[    1.898773] mcde a0350000.mcde: adev bind failed: -22
[    1.903991] mcde a0350000.mcde: failed to add component master
[    1.909912] mcde: probe of a0350000.mcde failed with error -22
[    1.916656] ------------[ cut here ]------------
[    1.921295] WARNING: CPU: 1 PID: 1 at drivers/regulator/core.c:2996
_regulator_disable+0x130/0x190
[    1.930297] unbalanced disables for AUX6
[    1.934265] Modules linked in:
[    1.937347] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
6.6.0-08649-g7d461b291e65 #3
[    1.944915] Hardware name: ST-Ericsson Ux5x0 platform (Device Tree Suppo=
rt)
[    1.951873]  unwind_backtrace from show_stack+0x10/0x14
[    1.957122]  show_stack from dump_stack_lvl+0x40/0x4c
[    1.962188]  dump_stack_lvl from __warn+0x84/0xc8
[    1.966918]  __warn from warn_slowpath_fmt+0x124/0x190
[    1.972076]  warn_slowpath_fmt from _regulator_disable+0x130/0x190
[    1.978271]  _regulator_disable from regulator_bulk_disable+0x5c/0x100
[    1.984802]  regulator_bulk_disable from nt35510_remove+0x1c/0x58
[    1.990905]  nt35510_remove from mipi_dsi_drv_remove+0x18/0x20
[    1.996765]  mipi_dsi_drv_remove from
device_release_driver_internal+0x184/0x1f8
[    2.004180]  device_release_driver_internal from bus_remove_device+0xc0/=
0xe4
[    2.011230]  bus_remove_device from device_del+0x14c/0x464
[    2.016723]  device_del from device_unregister+0xc/0x20
[    2.021972]  device_unregister from mipi_dsi_remove_device_fn+0x34/0x3c
[    2.028594]  mipi_dsi_remove_device_fn from device_for_each_child+0x64/0=
xa4
[    2.035583]  device_for_each_child from mipi_dsi_host_unregister+0x24/0x=
50
[    2.042480]  mipi_dsi_host_unregister from platform_remove+0x20/0x5c
[    2.048858]  platform_remove from device_release_driver_internal+0x184/0=
x1f8
[    2.055908]  device_release_driver_internal from bus_remove_device+0xc0/=
0xe4
[    2.062957]  bus_remove_device from device_del+0x14c/0x464
[    2.068450]  device_del from platform_device_del.part.0+0x10/0x74
[    2.074554]  platform_device_del.part.0 from
platform_device_unregister+0x18/0x24
[    2.082061]  platform_device_unregister from
of_platform_device_destroy+0x9c/0xac
[    2.089569]  of_platform_device_destroy from
device_for_each_child_reverse+0x78/0xbc
[    2.097320]  device_for_each_child_reverse from
devm_of_platform_populate_release+0x34/0x48
[    2.105682]  devm_of_platform_populate_release from
devres_release_all+0x94/0xf8
[    2.113098]  devres_release_all from device_unbind_cleanup+0xc/0x60
[    2.119384]  device_unbind_cleanup from really_probe+0x1a0/0x2d8
[    2.125396]  really_probe from __driver_probe_device+0x84/0xd4
[    2.131225]  __driver_probe_device from driver_probe_device+0x30/0x104
[    2.137756]  driver_probe_device from __driver_attach+0x90/0x178
[    2.143768]  __driver_attach from bus_for_each_dev+0x7c/0xcc
[    2.149444]  bus_for_each_dev from bus_add_driver+0xcc/0x1cc
[    2.155120]  bus_add_driver from driver_register+0x7c/0x114
[    2.160705]  driver_register from do_one_initcall+0x5c/0x190
[    2.166381]  do_one_initcall from kernel_init_freeable+0x1f8/0x250
[    2.172576]  kernel_init_freeable from kernel_init+0x18/0x12c
[    2.178344]  kernel_init from ret_from_fork+0x14/0x28
[    2.183410] Exception stack(0xf08c5fb0 to 0xf08c5ff8)
[    2.188446] 5fa0:                                     00000000
00000000 00000000 00000000
[    2.196624] 5fc0: 00000000 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    2.204803] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    2.211486] ---[ end trace 0000000000000000 ]---
[    2.216125] Failed to disable vddi: -EIO
[    2.220062] panel-novatek-nt35510 a0351000.dsi.0: Failed to power off

Reverting the patch solves the problem.

See device tree at e.g.:
arch/arm/boot/dts/st/ste-ux500-samsung-skomer.dts

The usual problems with patches like this is that our DSI panel
is attached in the DT without any graph:

                mcde@a0350000 {
                        status =3D "okay";
                        pinctrl-names =3D "default";
                        pinctrl-0 =3D <&dsi_default_mode>;

                        dsi@a0351000 {
                                panel {
                                        /* NT35510-based Hydis HVA40WV1 */
                                        compatible =3D "hydis,hva40wv1",
"novatek,nt35510";
                                        reg =3D <0>;
                                        /* v_lcd_3v0 2.3-4.8V */
                                        vdd-supply =3D <&ab8500_ldo_aux4_re=
g>;
                                        /* v_lcd_1v8 1.65-3.3V */
                                        vddi-supply =3D <&ab8500_ldo_aux6_r=
eg>;
                                        /* GPIO 139 */
                                        reset-gpios =3D <&gpio4 11
GPIO_ACTIVE_LOW>;
                                        pinctrl-names =3D "default";
                                        pinctrl-0 =3D <&display_default_mod=
e>;
                                        backlight =3D <&ktd253>;
                                };
                        };
                };

The DSI bridge is inside the display controller (MCDE) and the panel is
right inside the DSI bridge.

Suggestions welcome, I'm clueless why this happens.

Yours,
Linus Walleij
