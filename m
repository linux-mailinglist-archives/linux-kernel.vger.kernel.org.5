Return-Path: <linux-kernel+bounces-150253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A24A8A9C53
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA66D281A1A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1F4165FD1;
	Thu, 18 Apr 2024 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VEopHl0I"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B61D165FBC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449468; cv=none; b=T8LJc7QD46T0lVTFYqsE1zBiHi8sz1tnf8qkLduTzZkbtZ7Of7OiaQknDkbc5GM2MW6wIL0DaZEt1htjKc6RITrLvtM+a3jgZlJf2nyxtg0aamSvFNOI2Q68PtQEKVbQi86seNySsdJtoNzR+scdXYc8IXRUKAih74C/63+/u7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449468; c=relaxed/simple;
	bh=jKALt9KU/3y3wSFJZ2ycSc2VQe6xOqIlYBfJCm88MNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtVksdEXKPHtDfExUTFxSeoiorz2Rapy0v1c/Pp8z3rD7J5jzD4tak7u7nquuNU48Vl4uLtG7fOBa2B4O/AFY9/gMP/oPYUT85Sbo9BSrhmH7wQcJ0z654LCH7RR4h8llkgZu3whzPU9zEB/0jIpCXVC3sQFSx9pjvCDb8X9RuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VEopHl0I; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d8a2cbe1baso12417441fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 07:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713449464; x=1714054264; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LNtnra4jIvx0MSD1gfimaj73u3w4g6I0rnPlaCiirlk=;
        b=VEopHl0InSjaQIJ62V7YRn3gCHa8nC1i2S63q1C0HKCHpP6nHI17VII7ifpsDektq+
         Skh6VHK7tdGUCdpFDdfUaoanOcB59HpCkjPEGM5utzg9idIapJOKkCljHxBsv5I+u+oA
         rSmw9Nhx6t+9RZPDuFu+R1S3QOM0bL/nNmolGZMun4/ZgGKKYDdjbW4yzUKU4KLvwkdd
         ow2nI6u5avM+jWduPRiGqtiK4haP4U8TPXuAI7oAvBB4v9++uC0FuPBt5dIb91cas+5A
         XhgiSY4SUzdzbu+a1YPpzLKpXU053Cqg8oUGNwdaZCwk3ck7s3fwWA1W5RsM8U5GGoeB
         sXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713449464; x=1714054264;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LNtnra4jIvx0MSD1gfimaj73u3w4g6I0rnPlaCiirlk=;
        b=O29SxlGS83ElTqv3DdD/9wPV3b51zx9HqLhoaZFmklvgGdYAqxR5g7Qsgnv1hhtDsM
         e/Dl0U2OgQTwyeJ1lTxoi5FWdE9FZgITB6EqMN3+UeMoJwwg/qNfMDqTTCw+YG1SHJ33
         4r9EtR/0Z39Cmn10cOvX9V4dxafl6nxHIFObFadMfBU8aIZ8uOhvELfi4vlPOvHOFHul
         FEFraM4m1bnwiKV9Pc1kFE3r6YCbfn177MrmuXCLP6I0Ifrms2GdJKaaowtyka9AGtEi
         Ddk39t1gL1uAoM9hAqbHQp1z5NWV3dBEZAhp1en3LjlbMUFzaHoP6S/RKPQID2481H24
         C13g==
X-Forwarded-Encrypted: i=1; AJvYcCU2fo2/SHxGOaEJ4vx+49YdthxDIby2Jl/CgiFxpKh0xAjhTL3m/OntLgz8mwBqMGUoZxAj7p1NqBxc1f0a38r8V+ZEVnUQQXjHcgoS
X-Gm-Message-State: AOJu0YypD9s4EznAfqfkjLiVJ0+KoEu3+Z7tQ0jIVhvp1RxnnQ8PiJp7
	GLHXmpIKh9Bkex/6TShBktYZH+St2IsLqD0viRudu3mCk2mvp4Yq0VJCZLe2b1A=
X-Google-Smtp-Source: AGHT+IFdCUq3VqS+paDye/Ke7ewPYXel2f5bzxTKTI331K5OcS+VUSO1hNgDYfa3ldwMDWUI512s/Q==
X-Received: by 2002:a2e:9789:0:b0:2da:5f41:10c8 with SMTP id y9-20020a2e9789000000b002da5f4110c8mr2170989lji.3.1713449464276;
        Thu, 18 Apr 2024 07:11:04 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id z28-20020a2eb53c000000b002d6c88b9addsm213024ljm.50.2024.04.18.07.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 07:11:03 -0700 (PDT)
Date: Thu, 18 Apr 2024 17:11:02 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Hsin-Yi Wang <hsinyi@google.com>
Cc: lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>, 
	mripard@kernel.org, airlied@gmail.com, daniel@ffwll.ch, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, dianders@google.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] drm/panel: kd101ne3: add new panel driver
Message-ID: <vbt2nxddw2dc7hkreq4iybv5zv5xyp32oajybeqsphgfrhzmn7@tskvckljmxpe>
References: <20240418081548.12160-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240418081548.12160-3-lvzhaoxiong@huaqin.corp-partner.google.com>
 <zanx5y3obqmewnbooovf52hx6vh7tpi4zsbse2dyzcqzddmzhw@kewxoa6n3mja>
 <CACb=7PURWtS8bwT5EcAFHhu7deHd2Y8cNOattfdwyEYpOUcbnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACb=7PURWtS8bwT5EcAFHhu7deHd2Y8cNOattfdwyEYpOUcbnQ@mail.gmail.com>

On Thu, Apr 18, 2024 at 09:11:37PM +0800, Hsin-Yi Wang wrote:
> On Thu, Apr 18, 2024 at 7:46 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Thu, Apr 18, 2024 at 04:15:48PM +0800, lvzhaoxiong wrote:
> > > The kingdisplay panel is based on JD9365DA controller.
> > > Add a driver for it.
> > >
> > > Signed-off-by: lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
> > > ---
> > >  drivers/gpu/drm/panel/Kconfig                 |   9 +
> > >  drivers/gpu/drm/panel/Makefile                |   1 +
> > >  .../drm/panel/panel-kingdisplay-kd101ne3.c    | 607 ++++++++++++++++++
> > >  3 files changed, 617 insertions(+)
> > >  create mode 100644 drivers/gpu/drm/panel/panel-kingdisplay-kd101ne3.c
> > >
> > > diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
> > > index 154f5bf82980..2c73086cf102 100644
> > > --- a/drivers/gpu/drm/panel/Kconfig
> > > +++ b/drivers/gpu/drm/panel/Kconfig
> > > @@ -297,6 +297,15 @@ config DRM_PANEL_KINGDISPLAY_KD097D04
> > >         24 bit RGB per pixel. It provides a MIPI DSI interface to
> > >         the host and has a built-in LED backlight.
> > >
> > > +config DRM_PANEL_KINGDISPLAY_KD101NE3
> > > +     tristate "Kingdisplay kd101ne3 panel"
> > > +     depends on OF
> > > +     depends on DRM_MIPI_DSI
> > > +     depends on BACKLIGHT_CLASS_DEVICE
> > > +     help
> > > +       Say Y if you want to enable support for panels based on the
> > > +       Kingdisplay kd101ne3 controller.
> > > +
> > >  config DRM_PANEL_LEADTEK_LTK050H3146W
> > >       tristate "Leadtek LTK050H3146W panel"
> > >       depends on OF
> > > diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
> > > index 24a02655d726..cbd414b98bb0 100644
> > > --- a/drivers/gpu/drm/panel/Makefile
> > > +++ b/drivers/gpu/drm/panel/Makefile
> > > @@ -30,6 +30,7 @@ obj-$(CONFIG_DRM_PANEL_JDI_LPM102A188A) += panel-jdi-lpm102a188a.o
> > >  obj-$(CONFIG_DRM_PANEL_JDI_R63452) += panel-jdi-fhd-r63452.o
> > >  obj-$(CONFIG_DRM_PANEL_KHADAS_TS050) += panel-khadas-ts050.o
> > >  obj-$(CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04) += panel-kingdisplay-kd097d04.o
> > > +obj-$(CONFIG_DRM_PANEL_KINGDISPLAY_KD101NE3) += panel-kingdisplay-kd101ne3.o
> > >  obj-$(CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W) += panel-leadtek-ltk050h3146w.o
> > >  obj-$(CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829) += panel-leadtek-ltk500hd1829.o
> > >  obj-$(CONFIG_DRM_PANEL_LG_LB035Q02) += panel-lg-lb035q02.o
> > > diff --git a/drivers/gpu/drm/panel/panel-kingdisplay-kd101ne3.c b/drivers/gpu/drm/panel/panel-kingdisplay-kd101ne3.c
> > > new file mode 100644
> > > index 000000000000..dbf0992f8b81
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/panel/panel-kingdisplay-kd101ne3.c
> > > @@ -0,0 +1,607 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Panels based on the JD9365DA display controller.
> > > + * Author: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> > > + */
> > > +
> > > +#include <linux/delay.h>
> > > +#include <linux/gpio/consumer.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/regulator/consumer.h>
> > > +
> > > +#include <drm/drm_connector.h>
> > > +#include <drm/drm_crtc.h>
> > > +#include <drm/drm_mipi_dsi.h>
> > > +#include <drm/drm_panel.h>
> > > +
> > > +#include <video/mipi_display.h>
> > > +
> > > +struct panel_desc {
> > > +     const struct drm_display_mode *modes;
> > > +     unsigned int bpc;
> > > +
> > > +     /**
> > > +      * @width_mm: width of the panel's active display area
> > > +      * @height_mm: height of the panel's active display area
> > > +      */
> > > +     struct {
> > > +             unsigned int width_mm;
> > > +             unsigned int height_mm;
> >
> > Please move to the declared mode;
> >
> > > +     } size;
> > > +
> > > +     unsigned long mode_flags;
> > > +     enum mipi_dsi_pixel_format format;
> > > +     const struct panel_init_cmd *init_cmds;
> > > +     unsigned int lanes;
> > > +     bool discharge_on_disable;
> > > +     bool lp11_before_reset;
> > > +};
> > > +
> > > +struct kingdisplay_panel {
> > > +     struct drm_panel base;
> > > +     struct mipi_dsi_device *dsi;
> > > +
> > > +     const struct panel_desc *desc;
> > > +
> > > +     enum drm_panel_orientation orientation;
> > > +     struct regulator *pp3300;
> > > +     struct gpio_desc *enable_gpio;
> > > +};
> > > +
> > > +enum dsi_cmd_type {
> > > +     INIT_DCS_CMD,
> > > +     DELAY_CMD,
> > > +};
> > > +
> > > +struct panel_init_cmd {
> > > +     enum dsi_cmd_type type;
> > > +     size_t len;
> > > +     const char *data;
> > > +};
> > > +
> > > +#define _INIT_DCS_CMD(...) { \
> > > +     .type = INIT_DCS_CMD, \
> > > +     .len = sizeof((char[]){__VA_ARGS__}), \
> > > +     .data = (char[]){__VA_ARGS__} }
> > > +
> > > +#define _INIT_DELAY_CMD(...) { \
> > > +     .type = DELAY_CMD,\
> > > +     .len = sizeof((char[]){__VA_ARGS__}), \
> > > +     .data = (char[]){__VA_ARGS__} }
> >
> > This is the third panel driver using the same appoach. Can you use
> > mipi_dsi_generic_write_seq() instead of the huge table? Or if you prefer
> > the table, we should extract this framework to a common helper.
> > (my preference is shifted towards mipi_dsi_generic_write_seq()).
> >
> The drawback of mipi_dsi_generic_write_seq() is that it can cause the
> kernel size grows a lot since every sequence will be expanded.
> 
> Similar discussion in here:
> https://lore.kernel.org/dri-devel/CAD=FV=Wju3WS45=EpXMUg7FjYDh3-=mvm_jS7TF1tsaAzbb4Uw@mail.gmail.com/
> 
> This patch would increase the module size from 157K to 572K.
> scripts/bloat-o-meter shows chg +235.95%.
> 
> So maybe the common helper is better regarding the kernel module size?

Yes, let's get a framework done in a useful way.
I'd say, drop the _INIT_DELAY_CMD. msleep() and usleep_range() should be
used instead (and it's up to the developer to select correct delay
function).

> 
> > > +
> > > +static const struct panel_init_cmd kingdisplay_kd101ne3_init_cmd[] = {
> > > +     _INIT_DELAY_CMD(50),
> > > +     _INIT_DCS_CMD(0xE0, 0x00),

[skipped the body of the table]

> > > +     _INIT_DCS_CMD(0x0E, 0x48),
> > > +
> > > +     _INIT_DCS_CMD(0xE0, 0x00),

> > > +     _INIT_DCS_CMD(0X11),

Also, at least this is mipi_dsi_dcs_exit_sleep_mode().

> > > +     /* T6: 120ms */
> > > +     _INIT_DELAY_CMD(120),
> > > +     _INIT_DCS_CMD(0X29),

And this is mipi_dsi_dcs_set_display_on().

Having a single table enourages people to put known commands into the
table, the practice that must be frowned upon and forbidden.

We have functions for some of the standard DCS commands. So, maybe
instead of adding a single-table based approach we can improve
mipi_dsi_generic_write_seq() to reduce the bloat. E.g. by moving the
error handling to a common part of enable() / prepare() function.

> > > +     _INIT_DELAY_CMD(20),
> > > +     {},
> > > +};

-- 
With best wishes
Dmitry

