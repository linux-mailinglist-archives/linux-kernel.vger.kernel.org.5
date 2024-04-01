Return-Path: <linux-kernel+bounces-126595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5DD893A2F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9361F223B4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0129C1757D;
	Mon,  1 Apr 2024 10:29:54 +0000 (UTC)
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42631171A;
	Mon,  1 Apr 2024 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711967393; cv=none; b=sD8iA8NXW4+Yki4eRfYvoLgpF76jJ1zNGPzW1n1JhZeYHSp9Jjcs0Q+dRlFj5sYx0hkx1OT8vhCL4VWgig28u2sCoH4kUxSS6OAXWKqhTonb89vaies8nXz3W57MTBWDmhBjblJIAvvVKrsFIsgEJWhQY0kCeQHqZV33JZpUJbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711967393; c=relaxed/simple;
	bh=E2wylmEub0/+aLi/zFFLJj9ZtgqpNAZ2P2Pfi8wm4qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=heTIr9mlNI06PHHE3EeJHr/rD5qRP6OlLDPv7DB5rTwZIEe4iCq75sIvE9ZN7gCgfi9qomXpFnHQiTE51G5MQCl/w2MZqIQDF+JXstPRKeQMP5IF9VZH+tzL39pU6rl7Ey0tlq0SYqY4wGDQ7MwzIFDjTgt+ghm1LO2Uw0Nvvpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from SoMainline.org (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id D945F1FAC1;
	Mon,  1 Apr 2024 12:29:40 +0200 (CEST)
Date: Mon, 1 Apr 2024 12:29:39 +0200
From: Marijn Suijten <marijn.suijten@somainline.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
	Caleb Connolly <caleb.connolly@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH 3/3] drm: panel: Add LG sw43408 panel driver
Message-ID: <fn3r4ykwxvgf4ujmpevpsrcwmwzpjl5bhcp6ekyebowgf4rpz3@fyxcwjgn6abg>
References: <20240330-lg-sw43408-panel-v1-0-f5580fc9f2da@linaro.org>
 <20240330-lg-sw43408-panel-v1-3-f5580fc9f2da@linaro.org>
 <554zkisebym7gbbom3657ws7kqvyidggfmcvetjm6vrnwts3gl@l53hejt72b5q>
 <CAA8EJpowdjcN8KzGRVLrGx8L8Fi5Drs-C62VZKd5VbmDHsCg+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpowdjcN8KzGRVLrGx8L8Fi5Drs-C62VZKd5VbmDHsCg+Q@mail.gmail.com>

On 2024-03-30 16:37:08, Dmitry Baryshkov wrote:
> On Sat, 30 Mar 2024 at 12:27, Marijn Suijten
> <marijn.suijten@somainline.org> wrote:
> >
> > On 2024-03-30 05:59:30, Dmitry Baryshkov wrote:
> > > From: Sumit Semwal <sumit.semwal@linaro.org>
> > >
> > > LG SW43408 is 1080x2160, 4-lane MIPI-DSI panel, used in some Pixel3
> > > phones.
> > >
> > > Whatever init sequence we have for this panel isn't capable of
> > > initialising it completely, toggling the reset gpio ever causes the
> > > panel to die. Until this is resolved we avoid resetting the panel. The
> >
> > Are you sure it is avoided?  This patch seems to be toggling reset_gpio in
> > sw43408_prepare()?
> >
> > > disable/unprepare functions only put the panel to sleep mode and
> > > disable the backlight.
> > >
> > > Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
> > > [vinod: Add DSC support]
> > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > [caleb: cleanup and support turning off the panel]
> > > Signed-off-by: Caleb Connolly <caleb@connolly.tech>
> > > [DB: partially rewrote the driver and fixed DSC programming]
> > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > ---
> > >  MAINTAINERS                              |   8 +
> > >  drivers/gpu/drm/panel/Kconfig            |  11 ++
> > >  drivers/gpu/drm/panel/Makefile           |   1 +
> > >  drivers/gpu/drm/panel/panel-lg-sw43408.c | 322 +++++++++++++++++++++++++++++++
> > >  4 files changed, 342 insertions(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 4b511a55101c..f4cf7ee97376 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -6755,6 +6755,14 @@ S:     Maintained
> > >  F:   Documentation/devicetree/bindings/display/panel/jadard,jd9365da-h3.yaml
> > >  F:   drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> > >
> > > +DRM DRIVER FOR LG SW43408 PANELS
> > > +M:   Sumit Semwal <sumit.semwal@linaro.org>
> > > +M:   Caleb Connolly <caleb.connolly@linaro.org>
> > > +S:   Maintained
> > > +T:   git git://anongit.freedesktop.org/drm/drm-misc
> > > +F:   Documentation/devicetree/bindings/display/panel/lg,sw43408.yaml
> > > +F:   drivers/gpu/drm/panel/panel-lg-sw43408.c
> > > +
> > >  DRM DRIVER FOR LOGICVC DISPLAY CONTROLLER
> > >  M:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > >  S:   Supported
> > > diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> > > index d037b3b8b999..f94c702735cb 100644
> > > --- a/drivers/gpu/drm/panel/Kconfig
> > > +++ b/drivers/gpu/drm/panel/Kconfig
> > > @@ -335,6 +335,17 @@ config DRM_PANEL_LG_LG4573
> > >         Say Y here if you want to enable support for LG4573 RGB panel.
> > >         To compile this driver as a module, choose M here.
> > >
> > > +config DRM_PANEL_LG_SW43408
> > > +     tristate "LG SW43408 panel"
> > > +     depends on OF
> > > +     depends on DRM_MIPI_DSI
> > > +     depends on BACKLIGHT_CLASS_DEVICE
> > > +     help
> > > +       Say Y here if you want to enable support for LG sw43408 panel.
> > > +       The panel has a 1080x2160 resolution and uses
> > > +       24 bit RGB per pixel. It provides a MIPI DSI interface to
> > > +       the host and has a built-in LED backlight.
> > > +
> > >  config DRM_PANEL_MAGNACHIP_D53E6EA8966
> > >       tristate "Magnachip D53E6EA8966 DSI panel"
> > >       depends on OF && SPI
> > > diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> > > index f156d7fa0bcc..a75687d13caf 100644
> > > --- a/drivers/gpu/drm/panel/Makefile
> > > +++ b/drivers/gpu/drm/panel/Makefile
> > > @@ -34,6 +34,7 @@ obj-$(CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W) += panel-leadtek-ltk050h3146w.o
> > >  obj-$(CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829) += panel-leadtek-ltk500hd1829.o
> > >  obj-$(CONFIG_DRM_PANEL_LG_LB035Q02) += panel-lg-lb035q02.o
> > >  obj-$(CONFIG_DRM_PANEL_LG_LG4573) += panel-lg-lg4573.o
> > > +obj-$(CONFIG_DRM_PANEL_LG_SW43408) += panel-lg-sw43408.o
> > >  obj-$(CONFIG_DRM_PANEL_MAGNACHIP_D53E6EA8966) += panel-magnachip-d53e6ea8966.o
> > >  obj-$(CONFIG_DRM_PANEL_NEC_NL8048HL11) += panel-nec-nl8048hl11.o
> > >  obj-$(CONFIG_DRM_PANEL_NEWVISION_NV3051D) += panel-newvision-nv3051d.o
> > > diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
> > > new file mode 100644
> > > index 000000000000..365d25e14d54
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
> > > @@ -0,0 +1,322 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * Copyright (C) 2019-2024 Linaro Ltd
> > > + * Author: Sumit Semwal <sumit.semwal@linaro.org>
> > > + *    Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > + */
> > > +
> > > +#include <linux/backlight.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/regulator/consumer.h>
> > > +
> > > +#include <video/mipi_display.h>
> > > +
> > > +#include <drm/drm_mipi_dsi.h>
> > > +#include <drm/drm_panel.h>
> > > +#include <drm/drm_probe_helper.h>
> > > +#include <drm/display/drm_dsc.h>
> > > +#include <drm/display/drm_dsc_helper.h>
> > > +
> > > +#define NUM_SUPPLIES 2
> > > +
> > > +struct sw43408_panel {
> > > +     struct drm_panel base;
> > > +     struct mipi_dsi_device *link;
> > > +
> > > +     const struct drm_display_mode *mode;
> > > +
> > > +     struct regulator_bulk_data supplies[NUM_SUPPLIES];
> > > +
> > > +     struct gpio_desc *reset_gpio;
> > > +};
> > > +
> > > +static inline struct sw43408_panel *to_panel_info(struct drm_panel *panel)
> > > +{
> > > +     return container_of(panel, struct sw43408_panel, base);
> > > +}
> > > +
> > > +static int sw43408_unprepare(struct drm_panel *panel)
> > > +{
> > > +     struct sw43408_panel *ctx = to_panel_info(panel);
> > > +     int ret;
> > > +
> > > +     ret = mipi_dsi_dcs_set_display_off(ctx->link);
> > > +     if (ret < 0)
> > > +             dev_err(panel->dev, "set_display_off cmd failed ret = %d\n", ret);
> > > +
> > > +     ret = mipi_dsi_dcs_enter_sleep_mode(ctx->link);
> > > +     if (ret < 0)
> > > +             dev_err(panel->dev, "enter_sleep cmd failed ret = %d\n", ret);
> > > +
> > > +     msleep(100);
> > > +
> > > +     gpiod_set_value(ctx->reset_gpio, 1);
> > > +
> > > +     return regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> > > +}
> > > +
> > > +static int sw43408_program(struct drm_panel *panel)
> > > +{
> > > +     struct sw43408_panel *ctx = to_panel_info(panel);
> > > +     struct drm_dsc_picture_parameter_set pps;
> > > +     u8 dsc_en = 0x11;
> >
> > Yeah, this is completely strange. Bit 0, 0x1, is to enable DSC which is
> > normal. 0x10 however, which is bit 4, selects PPS table 2.  Do you ever set
> > pps_identifier in struct drm_dsc_picture_parameter_set to 2?  Or is the table
> > that you send below bogus and/or not used?  Maybe the Driver IC on the other
> > end of the DSI link has a default PPS table with identifier 2 that works out of
> > the box?
> 
> Note, MIPI standard also requires two bytes argument. I suspect that
> LG didn't fully follow the standard here.

Have you read this command from downstream DTS, or have you tried sending 2
bytes and seen the panel breaking?  The second byte is marked as reserved and
should be equal to 0; if the Driver IC is okay with sending either 1 or 2 bytes
I'd strive to stick with the defined length of 2 bytes for this DCS.

Have you played around with the PPS table?  What if you change
drm_dsc_picture_paremeter_set::pps_identifier to the second table, will the
panel stop working as expected again?  This could indicate that the PPS that is
sent is incorrect (even though the information in the original DSC config was
enough to set up the DPU and DSI correctly).

According to the DSI spec it is allowed to have a pre-stored/pre-programmed
PPS table, which could be used here making the current call to
mipi_dsi_picture_parameter_set() useless and "confusing"?

> Basically that's the reason why I went for the _raw function instead
> of adding PPS and codec arguments to the existing function.
> 
> >
> > > +     mipi_dsi_dcs_write_seq(ctx->link, MIPI_DCS_SET_GAMMA_CURVE, 0x02);
> > > +
> > > +     mipi_dsi_dcs_set_tear_on(ctx->link, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
> > > +
> > > +     mipi_dsi_dcs_write_seq(ctx->link, 0x53, 0x0c, 0x30);
> > > +     mipi_dsi_dcs_write_seq(ctx->link, 0x55, 0x00, 0x70, 0xdf, 0x00, 0x70, 0xdf);
> > > +     mipi_dsi_dcs_write_seq(ctx->link, 0xf7, 0x01, 0x49, 0x0c);
> > > +
> > > +     mipi_dsi_dcs_exit_sleep_mode(ctx->link);
> > > +
> > > +     msleep(135);
> > > +
> > > +     mipi_dsi_compression_mode_raw(ctx->link, &dsc_en, 1);
> >
> > Even though I think we should change this function to describe the known
> > bit layout of command 0x7 per the VESA DSI spec, for now replace 1 with
> > sizeof(dsc_en)?
> 
> If dsc_en were an array, it would have been a proper thing. Maybe I
> should change it to the array to remove confusion.

It should work even with a single byte, just to clarify to readers that the 3rd
argument is the byte-size of the input.

> > > +     mipi_dsi_dcs_write_seq(ctx->link, 0xb0, 0xac);
> > > +     mipi_dsi_dcs_write_seq(ctx->link, 0xe5,
> > > +                            0x00, 0x3a, 0x00, 0x3a, 0x00, 0x0e, 0x10);
> > > +     mipi_dsi_dcs_write_seq(ctx->link, 0xb5,
> > > +                            0x75, 0x60, 0x2d, 0x5d, 0x80, 0x00, 0x0a, 0x0b,
> > > +                            0x00, 0x05, 0x0b, 0x00, 0x80, 0x0d, 0x0e, 0x40,
> > > +                            0x00, 0x0c, 0x00, 0x16, 0x00, 0xb8, 0x00, 0x80,
> > > +                            0x0d, 0x0e, 0x40, 0x00, 0x0c, 0x00, 0x16, 0x00,
> > > +                            0xb8, 0x00, 0x81, 0x00, 0x03, 0x03, 0x03, 0x01,
> > > +                            0x01);
> > > +     msleep(85);
> > > +     mipi_dsi_dcs_write_seq(ctx->link, 0xcd,
> > > +                            0x00, 0x00, 0x00, 0x19, 0x19, 0x19, 0x19, 0x19,
> > > +                            0x19, 0x19, 0x19, 0x19, 0x19, 0x19, 0x19, 0x19,
> > > +                            0x16, 0x16);
> > > +     mipi_dsi_dcs_write_seq(ctx->link, 0xcb, 0x80, 0x5c, 0x07, 0x03, 0x28);
> > > +     mipi_dsi_dcs_write_seq(ctx->link, 0xc0, 0x02, 0x02, 0x0f);
> > > +     mipi_dsi_dcs_write_seq(ctx->link, 0x55, 0x04, 0x61, 0xdb, 0x04, 0x70, 0xdb);
> > > +     mipi_dsi_dcs_write_seq(ctx->link, 0xb0, 0xca);
> > > +
> > > +     mipi_dsi_dcs_set_display_on(ctx->link);
> >
> > Any specific reason to not have the (un)blanking sequence in the enable/disable
> > callbacks and leaving display configuration in (un)prepare?
> 
> We are back to the question on when it's fine to send the commands. I
> think the current agreement is to send everything in the
> prepare/unprepare, because of some strange hosts.

For my panel drivers I'm sticking with having `post-on` commands (from
downstream) in `enable/disable`, which is typically only `set_display_on`.  In
hopes of proposing a `prepare_atomic()` some time to allow mode selection.

In a short test on recent -next I am once again allowed to send DSI commands in
both .disable and .unprepare, making both functions a "clean" inverse of .enable
and .prepare respectively.

> > > +     msleep(50);
> > > +
> > > +     ctx->link->mode_flags &= ~MIPI_DSI_MODE_LPM;
> > > +
> > > +     drm_dsc_pps_payload_pack(&pps, ctx->link->dsc);
> > > +     mipi_dsi_picture_parameter_set(ctx->link, &pps);
> >
> > I'm always surprised why this is sent _after_ turning the display on (unblanking
> > it).  Wouldn't that cause unnecessary corruption?
> 
> No idea. I followed the dowsntream command sequences here. Most likely
> the panel is not fully on until it receives the full frame to be
> displayed.

According to the DSI spec a PPS update is allowed to happen every frame, and
(for cmdmode panels) will take effect after the next TE trigger.  Unsure if a TE
event happens before the first frame, otherwise this may start taking effect
on the second frame onwards only.

If there's no corruption on the first frame there might be a pre-programmed PPS
table in slot 2, supporting the theory above.

- Marijn

