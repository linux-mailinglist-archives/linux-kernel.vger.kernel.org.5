Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24377F4038
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 09:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343510AbjKVIgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 03:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbjKVIgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 03:36:36 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7331E1A8;
        Wed, 22 Nov 2023 00:36:26 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5441ba3e53cso8865752a12.1;
        Wed, 22 Nov 2023 00:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700642185; x=1701246985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2FundEFYPWyA8iI02W9oOe2neQR1kP664ROU1OiaZSI=;
        b=Yi571QzvkB4MYlqRAi/f5dLy8lINoQ3iJpvT/Y9XxNd5eepGVV2Fdkv2PG2YjhVWWF
         SjllYql4ZHFuz+6SwJQyvyM6BzgfwkcDi3kD5WDKQ/OINDXAsd9yC3nm1XWzvzbwywNr
         ql8u4LmPgAN39LSWUnDG9qdQMznCungN/jCUD1E+MIyVE+Fd7Cn/p4/IyTpSPpH2vO0M
         giLgWoCEkMJ/T3CnxtL17SlkK9DKzrep8zFbWP4H91QhfdFxvXm61asYazzoFMNbVawQ
         zsno7oCkQ9EnT8NUp43HQszMTJfkNPjRLeXLas1T5rgiCmzpsCaQBXodmsoeb15kx79N
         CLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700642185; x=1701246985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FundEFYPWyA8iI02W9oOe2neQR1kP664ROU1OiaZSI=;
        b=bYGIOgp0QXDrum7KDY0SHgT3xcOZOetgotdFRkZKiwk0PO59HUezaZfA327J+Di5C2
         Nj+0Hw3ez/3Rg/vCi0OdVzEgC4jKOqrUyhCbJa6Rq0ZHfbI7rVW1OBlC6FziAW3nClen
         frOzYBfw16hKpdHY+yf0VRW0QpC5yf3rkNaQK6xe7jWEu3qm4WAcf9HCjxIdprCfj1uv
         X6Gftex88DsHs231IHybABCXYFisT7wJw9aAHUzE7IfGj945z2ln9MA5IqJYWDfqlJp1
         wr5mmWNaZASHs++pzfWE++bpQoPs6KyaTpNls2nElKf2fVns9aPCjnmjg0qK861Ge+zq
         xlPw==
X-Gm-Message-State: AOJu0YwVP4cN+t6kkQZpVjQBDijkpSahoyNT0hcKcs3kt8JN7xaFu4q0
        9LSoJMvq3meqSwwvKQBKC0ItGInjWJ8=
X-Google-Smtp-Source: AGHT+IFmFw8CYhjwOWr2K4yzB7kWFX3rvG4gBo2Qniwapx9j64j8gWeLa2hyRXRETf28pM62mSH1Bw==
X-Received: by 2002:a05:6402:514e:b0:543:65ab:2f09 with SMTP id n14-20020a056402514e00b0054365ab2f09mr976413edd.34.1700642184338;
        Wed, 22 Nov 2023 00:36:24 -0800 (PST)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-2-39-142-131.cust.vodafonedsl.it. [2.39.142.131])
        by smtp.gmail.com with ESMTPSA id f6-20020a056402068600b00548a57d4f7bsm3796000edy.36.2023.11.22.00.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 00:36:23 -0800 (PST)
Date:   Wed, 22 Nov 2023 09:36:21 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     martin.hecht@avnet.eu, michael.roeder@avnet.eu, mhecht73@gmail.com,
        linuxfancy@googlegroups.com, laurent.pinchart@ideasonboard.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v13 3/3] media: i2c: Add support for alvium camera
Message-ID: <ZV29hSWiQuM/fSZD@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20231106082102.368937-1-tomm.merciai@gmail.com>
 <20231106082102.368937-4-tomm.merciai@gmail.com>
 <ZUynbIgak0mu7ff_@kekkonen.localdomain>
 <ZVXNX3G9ntWeqBur@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <ZVXxzVzXfNiJPQqh@kekkonen.localdomain>
 <ZVyPySW32I0WgepA@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <ZV2wPAmRqCbPMYrf@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV2wPAmRqCbPMYrf@kekkonen.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,
Thanks for your comments.

On Wed, Nov 22, 2023 at 07:39:40AM +0000, Sakari Ailus wrote:
> Hi Tommaso,
> 
> On Tue, Nov 21, 2023 at 12:08:57PM +0100, Tommaso Merciai wrote:
> > Hi Sakari,
> > Thanks for your comments.
> > 
> > On Thu, Nov 16, 2023 at 10:41:17AM +0000, Sakari Ailus wrote:
> > > Hi Tommaso,
> > > 
> > > On Thu, Nov 16, 2023 at 09:05:51AM +0100, Tommaso Merciai wrote:
> > > > Hi Sakari,
> > > > Thanks for your review!
> > > > Some comments on my side :)
> > > 
> > > Thanks. Please also see my comment on releasing alvium->ep.
> > > 
> > > > 
> > > > On Thu, Nov 09, 2023 at 09:33:32AM +0000, Sakari Ailus wrote:
> > > > > Hi Tommaso,
> > > > > 
> > > > > Reviewed again. There are quite a few matters remaining I've commented on
> > > > > previously --- please address all comments before posting a new version of
> > > > > the set. There are a few new findings, too, some related to spots that have
> > > > > been now cleaned up a bit.
> > > > > 
> > > > > That being said, the remaining issues are fairly localised. The big picture
> > > > > starts to look better already.
> > > > > 
> > > > > On Mon, Nov 06, 2023 at 09:20:58AM +0100, Tommaso Merciai wrote:
> > > > > > The Alvium camera is shipped with sensor + isp in the same housing.
> > > > > > The camera can be equipped with one out of various sensor and abstract
> > > > > > the user from this. Camera is connected via MIPI CSI-2.
> > > > > > 
> > > > > > Most of the camera module features are supported, with the main exception
> > > > > > being fw update.
> > > > > > 
> > > > > > The driver provides all mandatory, optional and recommended V4L2 controls
> > > > > > for maximum compatibility with libcamera
> > > > > > 
> > > > > > References:
> > > > > >  - https://www.alliedvision.com/en/products/embedded-vision-solutions
> > > > > > 
> > > > > > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > > > > > ---
> > > > > > Changes since v2:
> > > > > >  - Removed gpios/clock handling as suggested by LPinchart
> > > > > >  - Added vcc-ext-in supply support as suggested by LPinchart
> > > > > >  - Fixed alvium_setup_mipi_fmt funct as suggested by CJAILLET
> > > > > >  - Removed upside_down/hshake_bit priv data as suggested by CJAILLET
> > > > > >  - Fixed commit body as suggested by LPinchart
> > > > > >  - Mv alvium_set_streamon_delay to yalvium_set_lp2hs_delay
> > > > > >  - Fixed comment on lp2hs prop as suggested by LPinchart
> > > > > >  - Added pm resume/suspend functs as suggested by LPinchart
> > > > > >  - Dropped alvium_link_setup/alvium_s_power as suggested by LPinchart
> > > > > >  - Fixed regs defines as suggested by LPinchart
> > > > > >  - Fixed typedef as suggested by LPinchart
> > > > > >  - Dropped bcrm_v/fw_v from priv data as suggested by LPinchart
> > > > > >  - Now driver use the subdev active state to store the active format and crop
> > > > > >    as suggested by LPinchart
> > > > > >  - Dropped alvium_is_csi2/i2c_to_alvium as suggested by LPinchart
> > > > > > 
> > > > > > Changes since v3:
> > > > > >  - Fixed warnings Reported-by: kernel test robot <lkp@intel.com>
> > > > > > 
> > > > > > Changes since v4:
> > > > > >  - Removed print into alvium_get_dt_data for alliedvision,lp2hs-delay-us as
> > > > > >    suggested by CDooley
> > > > > > 
> > > > > > Changes since v5:
> > > > > >  - Used tab instead of space in .h as suggested by SAilus
> > > > > >  - Added support for new CCI API from HDeGoede as suggested by SAilus
> > > > > >  - Fixed alvium_write/alvium_read, functions now using the new CCI api, suggested by LPinchart
> > > > > >  - Fixed alvium_get_feat_inq func as suggested by SAilus
> > > > > >  - Fixed indentation/var-order/includes-order as suggested by SAilus
> > > > > >  - Fixed alvium_csi2_fmts with MIPI_CSI2_DT_ defines as suggested by SAilus
> > > > > >  - Fixed alvium_is_alive as suggested by SAilus
> > > > > >  - Fixed alvium_code_to_pixfmt funct as suggested by SAilus
> > > > > >  - Fixed alvium_get_dt_data function, now use only fwnode as suggested by SAilus
> > > > > >  - Fixed autosuspend into the probe, is disable as default as suggested by SAilus
> > > > > >  - Fixed alvium_get_dt_data function, assigned bus type before parsing the ep
> > > > > >    as suggested by SAilus
> > > > > >  - Fixed alvium_power_off, removed wrong print as suggested by SAilus
> > > > > > 
> > > > > > Changes since v6:
> > > > > >  - Fixed .h indentation
> > > > > >  - Fixed function params indentation
> > > > > >  - Added int *err params for alvium_read/alvium_write as suggested by LPinchart
> > > > > >  - Removed dbg print from the driver, driver is now using dbg/err prints that comes from
> > > > > >    new cci API as suggested by LPinchart. This, fits SAilus suggestion on common pattern function.
> > > > > >  - Fixed alvium_write_hshake, now use read_poll_timeout as suggested by LPinchart
> > > > > >  - Removed useless includes
> > > > > >  - Added maintainers file entries
> > > > > > 
> > > > > > Changes since v7:
> > > > > >  - Fix company legal entity from Inc. to GmbH
> > > > > >  - Fix warnings given from HVerkuil build-scripts in alvium_get_bcrm_vers,
> > > > > >    alvium_get_fw_version and probe functions using __le16/__le32. Fixed also
> > > > > >    probe function warning alvium-csi2.c:2665 alvium_probe() warn: missing error code? 'ret'
> > > > > > 
> > > > > > Changes since v8:
> > > > > >  - Fixed alvium_i2c_driver struct, use probe istead of probe_new
> > > > > >  - Fixed Kconfig description taking as reference new mt9m114 driver
> > > > > >  - Fixed Kconfig just select V4L2_CCI_I2C taking as reference new mt9m114 driver
> > > > > > 
> > > > > > Changes since v9:
> > > > > >  - Fixed Y8_1X8 mipi_fmt_regval
> > > > > >  - Removed alliedvision,lp2hs-delay-us property we set now a default safe value as discussed with SAilus
> > > > > >  - Added dft property for ctrls initialization, we first read dft values from the camera and set this into ctrls
> > > > > >  - Fixed indentation as suggested by SAilus
> > > > > >  - Fixed bit field definitions alignment into .h as suggested by SAilus
> > > > > >  - Fixed Heartbeat reg from R -> RW
> > > > > >  - Fixed adjusting values in format/crop changes as suggested by SAilus
> > > > > >  - Removed unnecessary brcm_addr checks as suggested by SAilus
> > > > > >  - Merged poweron/poweroff functions as suggested by SAilus
> > > > > >  - Added poweroff path during probe as suggested by SAilus
> > > > > >  - Fixed module license type as suggested by SAilus
> > > > > >  - Removed unnecessary MODULE_DEVICE_TABLE as suggested by SAilus
> > > > > >  - Fixed pm support in s_ctrl and s_stream functions
> > > > > >  - Removed unnecessary local variables  as suggested by SAilus
> > > > > >  - Added ret values checks as suggested by SAilus
> > > > > > 
> > > > > > Changes since v10:
> > > > > >  - Fixed alignment as suggested by SAilus
> > > > > >  - Fixed alvium_read pattern over the driver as suggested by LPinchart
> > > > > >  - Fixed alvium_set_csi_clk
> > > > > >  - Fixed counters types of alvium_setup_mipi_fmt as suggested by SAilus
> > > > > >  - Fixed alvium_set_frame_rate now don't use local var as suggested by SAilus
> > > > > >  - Added pm_runtime_put into alvium_s_stream as suggested by SAilus
> > > > > >  - Fixed alvium_g_volatile_ctrl as suggested by SAilus
> > > > > > 
> > > > > > Changes since v11:
> > > > > >  - Fixed kmalloc_array alignment in alvium_setup_mipi_fmt as suggested by CJAILLET
> > > > > >  - Fixed alvium_s_frame_interval: return ret instead of -EIO as suggested by CJAILLET
> > > > > >  - Fixed alvium_power_on: useless init ret var as suggested by CJAILLET
> > > > > >  - Fixed missing space in alvium_power_on function as suggested by CJAILLET
> > > > > >  - Fixed probe function print, from now driver use dev_err_probe as suggested by CJAILLET
> > > > > >  - Add missing alvium_subdev_cleanup into alvium_remove function as suggested by CJAILLET
> > > > > > 
> > > > > > Changes since v12:
> > > > > >  - Fixed alvium_remove function as suggested by CJAILLET/SAilus
> > > > > > 
> > > > > >  MAINTAINERS                     |    9 +
> > > > > >  drivers/media/i2c/Kconfig       |   10 +
> > > > > >  drivers/media/i2c/Makefile      |    1 +
> > > > > >  drivers/media/i2c/alvium-csi2.c | 2637 +++++++++++++++++++++++++++++++
> > > > > >  drivers/media/i2c/alvium-csi2.h |  488 ++++++
> > > > > >  5 files changed, 3145 insertions(+)
> > > > > >  create mode 100644 drivers/media/i2c/alvium-csi2.c
> > > > > >  create mode 100644 drivers/media/i2c/alvium-csi2.h
> > > > > > 
> > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > index f3e6dbbbbccb..98d322880c96 100644
> > > > > > --- a/MAINTAINERS
> > > > > > +++ b/MAINTAINERS
> > > > > > @@ -709,6 +709,15 @@ S:	Maintained
> > > > > >  F:	Documentation/devicetree/bindings/media/allegro,al5e.yaml
> > > > > >  F:	drivers/media/platform/allegro-dvt/
> > > > > >  
> > > > > > +ALLIED VISION ALVIUM CAMERA DRIVER
> > > > > > +M:	Tommaso Merciai <tomm.merciai@gmail.com>
> > > > > > +M:	Martin Hecht <martin.hecht@avnet.eu>
> > > > > > +L:	linux-media@vger.kernel.org
> > > > > > +S:	Maintained
> > > > > > +F:	Documentation/devicetree/bindings/media/i2c/alliedvision,alvium-csi2.yaml
> > > > > > +F:	drivers/media/i2c/alvium-csi2.c
> > > > > > +F:	drivers/media/i2c/alvium-csi2.h
> > > > > > +
> > > > > >  ALLWINNER A10 CSI DRIVER
> > > > > >  M:	Maxime Ripard <mripard@kernel.org>
> > > > > >  L:	linux-media@vger.kernel.org
> > > > > > diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
> > > > > > index d182c3514fb5..8525cfde26ba 100644
> > > > > > --- a/drivers/media/i2c/Kconfig
> > > > > > +++ b/drivers/media/i2c/Kconfig
> > > > > > @@ -41,6 +41,16 @@ config VIDEO_APTINA_PLL
> > > > > >  config VIDEO_CCS_PLL
> > > > > >  	tristate
> > > > > >  
> > > > > > +config VIDEO_ALVIUM_CSI2
> > > > > > +	tristate "Allied Vision ALVIUM MIPI CSI-2 camera support"
> > > > > > +	select V4L2_CCI_I2C
> > > > > > +	help
> > > > > > +	  This is a Video4Linux2 sensor-level driver for the Allied Vision
> > > > > > +	  ALVIUM camera connected via MIPI CSI-2 interface.
> > > > > > +
> > > > > > +	  To compile this driver as a module, choose M here: the
> > > > > > +	  module will be called alvium-csi2.
> > > > > > +
> > > > > >  config VIDEO_AR0521
> > > > > >  	tristate "ON Semiconductor AR0521 sensor support"
> > > > > >  	help
> > > > > > diff --git a/drivers/media/i2c/Makefile b/drivers/media/i2c/Makefile
> > > > > > index f5010f80a21f..d75aa7f74315 100644
> > > > > > --- a/drivers/media/i2c/Makefile
> > > > > > +++ b/drivers/media/i2c/Makefile
> > > > > > @@ -17,6 +17,7 @@ obj-$(CONFIG_VIDEO_ADV7604) += adv7604.o
> > > > > >  obj-$(CONFIG_VIDEO_ADV7842) += adv7842.o
> > > > > >  obj-$(CONFIG_VIDEO_AK7375) += ak7375.o
> > > > > >  obj-$(CONFIG_VIDEO_AK881X) += ak881x.o
> > > > > > +obj-$(CONFIG_VIDEO_ALVIUM_CSI2) += alvium-csi2.o
> > > > > >  obj-$(CONFIG_VIDEO_APTINA_PLL) += aptina-pll.o
> > > > > >  obj-$(CONFIG_VIDEO_AR0521) += ar0521.o
> > > > > >  obj-$(CONFIG_VIDEO_BT819) += bt819.o
> > > > > > diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..b089673d6ef4
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/media/i2c/alvium-csi2.c
> > > > > > @@ -0,0 +1,2637 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > +/*
> > > > > > + * Allied Vision Technologies GmbH Alvium camera driver
> > > > > > + *
> > > > > > + * Copyright (C) 2023 Tommaso Merciai
> > > > > > + * Copyright (C) 2023 Martin Hecht
> > > > > > + * Copyright (C) 2023 Avnet EMG GmbH
> > > > > > + */
> > > > > > +
> > > > > > +#include <linux/i2c.h>
> > > > > > +#include <linux/module.h>
> > > > > > +#include <linux/pm_runtime.h>
> > > > > > +#include <linux/regmap.h>
> > > > > > +#include <linux/regulator/consumer.h>
> > > > > > +#include <media/mipi-csi2.h>
> > > > > > +#include <media/v4l2-async.h>
> > > > > > +#include <media/v4l2-ctrls.h>
> > > > > > +#include <media/v4l2-device.h>
> > > > > > +#include <media/v4l2-event.h>
> > > > > > +#include <media/v4l2-fwnode.h>
> > > > > > +#include <media/v4l2-subdev.h>
> > > > > > +
> > > > > > +#include "alvium-csi2.h"
> > > > > > +
> > > > > > +static const struct v4l2_mbus_framefmt alvium_csi2_default_fmt = {
> > > > > > +	.code = MEDIA_BUS_FMT_UYVY8_1X16,
> > > > > > +	.width = 640,
> > > > > > +	.height = 480,
> > > > > > +	.colorspace = V4L2_COLORSPACE_SRGB,
> > > > > > +	.ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(V4L2_COLORSPACE_SRGB),
> > > > > > +	.quantization = V4L2_QUANTIZATION_FULL_RANGE,
> > > > > > +	.xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(V4L2_COLORSPACE_SRGB),
> > > > > > +	.field = V4L2_FIELD_NONE,
> > > > > > +};
> > > > > > +
> > > > > > +static const struct alvium_pixfmt alvium_csi2_fmts[] = {
> > > > > > +	{
> > > > > > +		/* UYVY8_2X8 */
> > > > > > +		.id = ALVIUM_FMT_UYVY8_2X8,
> > > > > > +		.code = MEDIA_BUS_FMT_UYVY8_2X8,
> > > > > > +		.colorspace = V4L2_COLORSPACE_SRGB,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_YUV422_8,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_YUV422_8B,
> > > > > > +		.bay_fmt_regval = -1,
> > > > > > +		.is_raw = 0,
> > > > > > +	}, {
> > > > > > +		/* UYVY8_1X16 */
> > > > > > +		.id = ALVIUM_FMT_UYVY8_1X16,
> > > > > > +		.code = MEDIA_BUS_FMT_UYVY8_1X16,
> > > > > > +		.colorspace = V4L2_COLORSPACE_SRGB,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_YUV422_8,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_YUV422_8B,
> > > > > > +		.bay_fmt_regval = -1,
> > > > > > +		.is_raw = 0,
> > > > > > +	}, {
> > > > > > +		/* YUYV8_1X16 */
> > > > > > +		.id = ALVIUM_FMT_YUYV8_1X16,
> > > > > > +		.code = MEDIA_BUS_FMT_YUYV8_1X16,
> > > > > > +		.colorspace = V4L2_COLORSPACE_SRGB,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_YUV422_8,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_YUV422_8B,
> > > > > > +		.bay_fmt_regval = -1,
> > > > > > +		.is_raw = 0,
> > > > > > +	}, {
> > > > > > +		/* YUYV8_2X8 */
> > > > > > +		.id = ALVIUM_FMT_YUYV8_2X8,
> > > > > > +		.code = MEDIA_BUS_FMT_YUYV8_2X8,
> > > > > > +		.colorspace = V4L2_COLORSPACE_SRGB,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_YUV422_8,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_YUV422_8B,
> > > > > > +		.bay_fmt_regval = -1,
> > > > > > +		.is_raw = 0,
> > > > > > +	}, {
> > > > > > +		/* YUYV10_1X20 */
> > > > > > +		.id = ALVIUM_FMT_YUYV10_1X20,
> > > > > > +		.code = MEDIA_BUS_FMT_YUYV10_1X20,
> > > > > > +		.colorspace = V4L2_COLORSPACE_SRGB,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_YUV422_10,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_YUV422_10B,
> > > > > > +		.bay_fmt_regval = -1,
> > > > > > +		.is_raw = 0,
> > > > > > +	}, {
> > > > > > +		/* RGB888_1X24 */
> > > > > > +		.id = ALVIUM_FMT_RGB888_1X24,
> > > > > > +		.code = MEDIA_BUS_FMT_RGB888_1X24,
> > > > > > +		.colorspace = V4L2_COLORSPACE_SRGB,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_RGB888,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_RGB888,
> > > > > > +		.bay_fmt_regval = -1,
> > > > > > +		.is_raw = 0,
> > > > > > +	}, {
> > > > > > +		/* RBG888_1X24 */
> > > > > > +		.id = ALVIUM_FMT_RBG888_1X24,
> > > > > > +		.code = MEDIA_BUS_FMT_RBG888_1X24,
> > > > > > +		.colorspace = V4L2_COLORSPACE_SRGB,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_RGB888,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_RGB888,
> > > > > > +		.bay_fmt_regval = -1,
> > > > > > +		.is_raw = 0,
> > > > > > +	}, {
> > > > > > +		/* BGR888_1X24 */
> > > > > > +		.id = ALVIUM_FMT_BGR888_1X24,
> > > > > > +		.code = MEDIA_BUS_FMT_BGR888_1X24,
> > > > > > +		.colorspace = V4L2_COLORSPACE_SRGB,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_RGB888,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_RGB888,
> > > > > > +		.bay_fmt_regval = -1,
> > > > > > +		.is_raw = 0,
> > > > > > +	}, {
> > > > > > +		/* RGB888_3X8 */
> > > > > > +		.id = ALVIUM_FMT_RGB888_3X8,
> > > > > > +		.code = MEDIA_BUS_FMT_RGB888_3X8,
> > > > > > +		.colorspace = V4L2_COLORSPACE_SRGB,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_RGB888,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_NONE,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_RGB888,
> > > > > > +		.bay_fmt_regval = -1,
> > > > > > +		.is_raw = 0,
> > > > > > +	}, {
> > > > > > +		/* Y8_1X8 */
> > > > > > +		.id = ALVIUM_FMT_Y8_1X8,
> > > > > > +		.code = MEDIA_BUS_FMT_Y8_1X8,
> > > > > > +		.colorspace = V4L2_COLORSPACE_RAW,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_RAW8,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_MONO,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_RAW8,
> > > > > > +		.bay_fmt_regval = 0x00,
> > > > > > +		.is_raw = 1,
> > > > > > +	}, {
> > > > > > +		/* SGRBG8_1X8 */
> > > > > > +		.id = ALVIUM_FMT_SGRBG8_1X8,
> > > > > > +		.code = MEDIA_BUS_FMT_SGRBG8_1X8,
> > > > > > +		.colorspace = V4L2_COLORSPACE_RAW,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_RAW8,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_GR,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_RAW8,
> > > > > > +		.bay_fmt_regval = 0x01,
> > > > > > +		.is_raw = 1,
> > > > > > +	}, {
> > > > > > +		/* SRGGB8_1X8 */
> > > > > > +		.id = ALVIUM_FMT_SRGGB8_1X8,
> > > > > > +		.code = MEDIA_BUS_FMT_SRGGB8_1X8,
> > > > > > +		.colorspace = V4L2_COLORSPACE_RAW,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_RAW8,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_RG,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_RAW8,
> > > > > > +		.bay_fmt_regval = 0x02,
> > > > > > +		.is_raw = 1,
> > > > > > +	}, {
> > > > > > +		/* SGBRG8_1X8 */
> > > > > > +		.id = ALVIUM_FMT_SGBRG8_1X8,
> > > > > > +		.code = MEDIA_BUS_FMT_SGBRG8_1X8,
> > > > > > +		.colorspace = V4L2_COLORSPACE_RAW,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_RAW8,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_GB,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_RAW8,
> > > > > > +		.bay_fmt_regval = 0x03,
> > > > > > +		.is_raw = 1,
> > > > > > +	}, {
> > > > > > +		/* SBGGR8_1X8 */
> > > > > > +		.id = ALVIUM_FMT_SBGGR8_1X8,
> > > > > > +		.code = MEDIA_BUS_FMT_SBGGR8_1X8,
> > > > > > +		.colorspace = V4L2_COLORSPACE_RAW,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_RAW8,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_BG,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_RAW8,
> > > > > > +		.bay_fmt_regval = 0x04,
> > > > > > +		.is_raw = 1,
> > > > > > +	}, {
> > > > > > +		/* Y10_1X10 */
> > > > > > +		.id = ALVIUM_FMT_Y10_1X10,
> > > > > > +		.code = MEDIA_BUS_FMT_Y10_1X10,
> > > > > > +		.colorspace = V4L2_COLORSPACE_RAW,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_RAW10,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_MONO,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_RAW10,
> > > > > > +		.bay_fmt_regval = 0x00,
> > > > > > +		.is_raw = 1,
> > > > > > +	}, {
> > > > > > +		/* SGRBG10_1X10 */
> > > > > > +		.id = ALVIUM_FMT_SGRBG10_1X10,
> > > > > > +		.code = MEDIA_BUS_FMT_SGRBG10_1X10,
> > > > > > +		.colorspace = V4L2_COLORSPACE_RAW,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_RAW10,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_GR,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_RAW10,
> > > > > > +		.bay_fmt_regval = 0x01,
> > > > > > +		.is_raw = 1,
> > > > > > +	}, {
> > > > > > +		/* SRGGB10_1X10 */
> > > > > > +		.id = ALVIUM_FMT_SRGGB10_1X10,
> > > > > > +		.code = MEDIA_BUS_FMT_SRGGB10_1X10,
> > > > > > +		.colorspace = V4L2_COLORSPACE_RAW,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_RAW10,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_RG,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_RAW10,
> > > > > > +		.bay_fmt_regval = 0x02,
> > > > > > +		.is_raw = 1,
> > > > > > +	}, {
> > > > > > +		/* SGBRG10_1X10 */
> > > > > > +		.id = ALVIUM_FMT_SGBRG10_1X10,
> > > > > > +		.code = MEDIA_BUS_FMT_SGBRG10_1X10,
> > > > > > +		.colorspace = V4L2_COLORSPACE_RAW,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_RAW10,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_GB,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_RAW10,
> > > > > > +		.bay_fmt_regval = 0x03,
> > > > > > +		.is_raw = 1,
> > > > > > +	}, {
> > > > > > +		/* SBGGR10_1X10 */
> > > > > > +		.id = ALVIUM_FMT_SBGGR10_1X10,
> > > > > > +		.code = MEDIA_BUS_FMT_SBGGR10_1X10,
> > > > > > +		.colorspace = V4L2_COLORSPACE_RAW,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_RAW10,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_BG,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_RAW10,
> > > > > > +		.bay_fmt_regval = 0x04,
> > > > > > +		.is_raw = 1,
> > > > > > +	}, {
> > > > > > +		/* Y12_1X12 */
> > > > > > +		.id = ALVIUM_FMT_Y12_1X12,
> > > > > > +		.code = MEDIA_BUS_FMT_Y12_1X12,
> > > > > > +		.colorspace = V4L2_COLORSPACE_RAW,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_RAW12,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_MONO,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_RAW12,
> > > > > > +		.bay_fmt_regval = 0x00,
> > > > > > +		.is_raw = 1,
> > > > > > +	}, {
> > > > > > +		/* SGRBG12_1X12 */
> > > > > > +		.id = ALVIUM_FMT_SGRBG12_1X12,
> > > > > > +		.code = MEDIA_BUS_FMT_SGRBG12_1X12,
> > > > > > +		.colorspace = V4L2_COLORSPACE_RAW,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_RAW12,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_GR,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_RAW12,
> > > > > > +		.bay_fmt_regval = 0x01,
> > > > > > +		.is_raw = 1,
> > > > > > +	}, {
> > > > > > +		/* SRGGB12_1X12 */
> > > > > > +		.id = ALVIUM_FMT_SRGGB12_1X12,
> > > > > > +		.code = MEDIA_BUS_FMT_SRGGB12_1X12,
> > > > > > +		.colorspace = V4L2_COLORSPACE_RAW,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_RAW12,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_RG,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_RAW12,
> > > > > > +		.bay_fmt_regval = 0x02,
> > > > > > +		.is_raw = 1,
> > > > > > +	}, {
> > > > > > +		/* SGBRG12_1X12 */
> > > > > > +		.id = ALVIUM_FMT_SGBRG12_1X12,
> > > > > > +		.code = MEDIA_BUS_FMT_SGBRG12_1X12,
> > > > > > +		.colorspace = V4L2_COLORSPACE_RAW,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_RAW12,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_GB,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_RAW12,
> > > > > > +		.bay_fmt_regval = 0x03,
> > > > > > +		.is_raw = 1,
> > > > > > +	}, {
> > > > > > +		/* SBGGR12_1X12 */
> > > > > > +		.id = ALVIUM_FMT_SBGGR12_1X12,
> > > > > > +		.code = MEDIA_BUS_FMT_SBGGR12_1X12,
> > > > > > +		.colorspace = V4L2_COLORSPACE_RAW,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_RAW12,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_BG,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_RAW12,
> > > > > > +		.bay_fmt_regval = 0x04,
> > > > > > +		.is_raw = 1,
> > > > > > +	}, {
> > > > > > +		/* SBGGR14_1X14 */
> > > > > > +		.id = ALVIUM_FMT_SBGGR14_1X14,
> > > > > > +		.code = MEDIA_BUS_FMT_SBGGR14_1X14,
> > > > > > +		.colorspace = V4L2_COLORSPACE_RAW,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_RAW14,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_GR,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_RAW14,
> > > > > > +		.bay_fmt_regval = 0x01,
> > > > > > +		.is_raw = 1,
> > > > > > +	}, {
> > > > > > +		/* SGBRG14_1X14 */
> > > > > > +		.id = ALVIUM_FMT_SGBRG14_1X14,
> > > > > > +		.code = MEDIA_BUS_FMT_SGBRG14_1X14,
> > > > > > +		.colorspace = V4L2_COLORSPACE_RAW,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_RAW14,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_RG,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_RAW14,
> > > > > > +		.bay_fmt_regval = 0x02,
> > > > > > +		.is_raw = 1,
> > > > > > +	}, {
> > > > > > +		/* SRGGB14_1X14 */
> > > > > > +		.id = ALVIUM_FMT_SRGGB14_1X14,
> > > > > > +		.code = MEDIA_BUS_FMT_SRGGB14_1X14,
> > > > > > +		.colorspace = V4L2_COLORSPACE_RAW,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_RAW14,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_GB,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_RAW14,
> > > > > > +		.bay_fmt_regval = 0x03,
> > > > > > +		.is_raw = 1,
> > > > > > +	}, {
> > > > > > +		/* SGRBG14_1X14 */
> > > > > > +		.id = ALVIUM_FMT_SGRBG14_1X14,
> > > > > > +		.code = MEDIA_BUS_FMT_SGRBG14_1X14,
> > > > > > +		.colorspace = V4L2_COLORSPACE_RAW,
> > > > > > +		.fmt_av_bit = ALVIUM_BIT_RAW14,
> > > > > > +		.bay_av_bit = ALVIUM_BIT_BAY_BG,
> > > > > > +		.mipi_fmt_regval = MIPI_CSI2_DT_RAW14,
> > > > > > +		.bay_fmt_regval = 0x04,
> > > > > > +		.is_raw = 1,
> > > > > > +	},
> > > > > > +	{ /* sentinel */ }
> > > > > > +};
> > > > > > +
> > > > > > +static int alvium_read(struct alvium_dev *alvium, u32 reg, u64 *val, int *err)
> > > > > > +{
> > > > > > +	if (reg & REG_BCRM_V4L2) {
> > > > > > +		reg &= ~REG_BCRM_V4L2;
> > > > > > +		reg += alvium->bcrm_addr;
> > > > > > +	}
> > > > > > +
> > > > > > +	return cci_read(alvium->regmap, reg, val, err);
> > > > > > +}
> > > > > > +
> > > > > > +static int alvium_write(struct alvium_dev *alvium, u32 reg, u64 val, int *err)
> > > > > > +{
> > > > > > +	if (reg & REG_BCRM_V4L2) {
> > > > > > +		reg &= ~REG_BCRM_V4L2;
> > > > > > +		reg += alvium->bcrm_addr;
> > > > > > +	}
> > > > > > +
> > > > > > +	return cci_write(alvium->regmap, reg, val, err);
> > > > > > +}
> > > > > > +
> > > > > > +static int alvium_write_hshake(struct alvium_dev *alvium, u32 reg, u64 val)
> > > > > > +{
> > > > > > +	struct device *dev = &alvium->i2c_client->dev;
> > > > > > +	u64 hshake_bit;
> > > > > > +	int ret = 0;
> > > > > > +
> > > > > > +	/* reset handshake bit and write alvium reg */
> > > > > > +	alvium_write(alvium, REG_BCRM_WRITE_HANDSHAKE_RW, 0, &ret);
> > > > > > +	alvium_write(alvium, reg, val, &ret);
> > > > > > +	if (ret) {
> > > > > > +		dev_err(dev, "Fail to write reg\n");
> > > > > > +		return ret;
> > > > > > +	}
> > > > > > +
> > > > > > +	/* poll handshake bit since bit0 = 1 */
> > > > > > +	read_poll_timeout(alvium_read, hshake_bit,
> > > > > > +			  ((hshake_bit & BCRM_HANDSHAKE_W_DONE_EN_BIT) == 1),
> > > > > > +			  15000, 45000, true,
> > > > > > +			  alvium, REG_BCRM_WRITE_HANDSHAKE_RW, &hshake_bit, &ret);
> > > > > > +	if (ret) {
> > > > > > +		dev_err(dev, "poll bit[0] = 1, hshake reg fail\n");
> > > > > > +		return ret;
> > > > > > +	}
> > > > > > +
> > > > > > +	/* reset handshake bit, write 0 to bit0 */
> > > > > > +	alvium_write(alvium, REG_BCRM_WRITE_HANDSHAKE_RW, 0, &ret);
> > > > > > +	if (ret) {
> > > > > > +		dev_err(dev, "Fail to reset hshake reg\n");
> > > > > > +		return ret;
> > > > > > +	}
> > > > > > +
> > > > > > +	/* poll handshake bit since bit0 = 0 */
> > > > > > +	read_poll_timeout(alvium_read, hshake_bit,
> > > > > > +			  ((hshake_bit & BCRM_HANDSHAKE_W_DONE_EN_BIT) == 0),
> > > > > > +			  15000, 45000, true,
> > > > > > +			  alvium, REG_BCRM_WRITE_HANDSHAKE_RW, &hshake_bit, &ret);
> > > > > > +	if (ret) {
> > > > > > +		dev_err(dev, "poll bit[0] = 0, hshake reg fail\n");
> > > > > > +		return ret;
> > > > > > +	}
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int alvium_get_bcrm_vers(struct alvium_dev *alvium)
> > > > > > +{
> > > > > > +	struct device *dev = &alvium->i2c_client->dev;
> > > > > > +	struct alvium_bcrm_vers *v;
> > > > > > +	u64 val;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	ret = alvium_read(alvium, REG_BCRM_VERSION_R, &val, NULL);
> > > > > > +	if (ret)
> > > > > > +		return ret;
> > > > > > +
> > > > > > +	v = (struct alvium_bcrm_vers *) &val;
> > > > > 
> > > > > No space before "&" in type cast, please. The same elsewhere.
> > > > > 
> > > > > As you cast a single value to a struct, I think the struct field values
> > > > > will be swapped on BE systems. You'll need to convert each value
> > > > > separately. Same for struct alvium_fw_vers below.
> > > > 
> > > > What about:
> > > > 
> > > >  v->minor = le16_to_cpu(v->minor);
> > > >  v->major = le16_to_cpu(v->major);
> > > > 
> > > > here. I posted this solution in some previous v :)
> > > 
> > > You shouldn't assign it to a field marked little endian. Instead, use
> > > le16_to_cpu() when you access the data below.
> > > 
> > > If you want to access the struct in the driver without using the conversion
> > > macros, you should read the data one field at a time (and use u16 instead
> > > of __le16 type for the fields).
> > 
> > It's fine with your suggestion thanks.
> > I'm moving to use the following to prints those values:
> > 
> > 	v = (struct alvium_bcrm_vers *)&val;
> > 
> > 	dev_info(dev, "bcrm version: %u.%u\n",
> > 		 le16_to_cpu(v->minor), le16_to_cpu(v->major));
> > 
> > thanks for the hint.
> 
> Sorry, I forgot alvium_read(), via cci_read(), already does endianness
> conversion here, from big endian to CPU endianness. Is there a need to do
> further conversion here? Noting that le16_to_cpu() does nothing on little
> endian systems, is it necessary here?
> 
> The options here are either changing the struct fields to CPU endianness
> and reading them individually or accessing the register as a single 32-bit
> value.
> 
> I'd do the former, it's easier to access them that way in the driver.
> 
> The same applies to BCRM version below.
> 
> struct alvium_bcrm_vers {
> 	u16 minor;
> 	u16 major;
> };

Understood, thanks.

Then to resume just compared to v13 I just need to
revert the alvium_bcrm_vers/alvium_fw_vers struct
to:

struct alvium_bcrm_vers {
	u16 minor;
	u16 major;
};

struct alvium_fw_vers {
	u8 special;
	u8 major;
	u16 minor;
	u16 patch;
};

> 
> > 
> > 
> > > 
> > > > 
> > > > > 
> > > > > > +	dev_info(dev, "bcrm version: %u.%u\n", v->minor, v->major);
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int alvium_get_fw_version(struct alvium_dev *alvium)
> > > > > > +{
> > > > > > +	struct device *dev = &alvium->i2c_client->dev;
> > > > > > +	struct alvium_fw_vers *fw_v;
> > > > > > +	u64 val;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	ret = alvium_read(alvium, REG_BCRM_DEVICE_FIRMWARE_VERSION_R, &val, NULL);
> > > > > > +	if (ret)
> > > > > > +		return ret;
> > > > > > +
> > > > > > +	fw_v = (struct alvium_fw_vers *) &val;
> > > > > > +	dev_info(dev, "fw version: %u.%u.%u.%u\n", fw_v->special, fw_v->major,
> > > > > > +		 fw_v->minor, fw_v->patch);
> > > > > 
> > > > > Ditto.
> > > > 
> > > > Same here:
> > > > 
> > > >  I think we just need:
> > > > 
> > > >  fw_v->minor = le16_to_cpu(fw_v->minor);
> > > >  fw_v->patch = le32_to_cpu(fw_v->patch);
> > > 
> > > Same as earlier.
> > 
> > Same here:
> > 
> > 	fw_v = (struct alvium_fw_vers *)&val;
> > 
> > 	dev_info(dev, "fw version: %u.%u.%u.%u\n",
> > 		 fw_v->special, fw_v->major,
> > 		 le16_to_cpu(fw_v->minor), le32_to_cpu(fw_v->patch));
> ...
> 
> > > > > > +			if ((!alvium_csi2_fmts[fmt].is_raw) ||
> > > > > > +			    (alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit]))
> > > > > > +				sz++;
> > > > > > +	}
> > > > > > +
> > > > > > +	/* init alvium_csi2_fmt array */
> > > > > > +	alvium->alvium_csi2_fmt_n = sz;
> > > > > > +	alvium->alvium_csi2_fmt = kmalloc_array(sz, sizeof(struct alvium_pixfmt),
> > > > > 
> > > > > Wrap after "=".
> > > > > 
> > > > > 						    sizeof(*alvium->alvium_csi2_fmt)
> > > > > 
> > > > > > +						GFP_KERNEL);
> > > > 
> > > > alvium->alvium_csi2_fmt =
> > > > 			 kmalloc_array(sz, sizeof(struct alvium_pixfmt), GFP_KERNEL);
> > > 
> > > One tab stop is enough here, meaning the line will be less than 80
> > > characters.
> > > 
> > > > ?
> > > > 
> > > > > 
> > > > > Where is this released?
> > > > 
> > > > You are completely right actually is missing.
> > > > I think I need to add kfree into the probe function:
> > > > 
> > > > ret = alvium_setup_mipi_fmt(alvium);
> > > > if (ret) {
> > > > 	dev_err_probe(dev, ret, "setup_mipi_fmt fail\n");
> > > > 	kfree(alvium->alvium_csi2_fmt);
> > > 
> > > Don't do this here but in error handling, under an appropriate label. Note
> > > that kfree(NULL) is a nop.
> > > 
> > > I think it'd be less error-prone to do this under whatever label that you
> > > use next, rather than putting it to alvium_subdev_cleanup().
> > > 
> > > Ideally alvium_setup_mipi_fmt() would release it by itself in error case.
> > > 
> > > > 	goto err_powerdown;
> > > > }
> > > > 
> > > > and at the end of the alvium_subdev_cleanup function
> > 
> > Some comments on alvium_setup_mipi_fmt:
> > 
> > alvium_setup_mipi_fmt can't fail right now don't need to check the return
> > value my plan is to add the following pointer check:
> > 
> > 	alvium->alvium_csi2_fmt =
> > 		kmalloc_array(sz, sizeof(struct alvium_pixfmt), GFP_KERNEL);
> > 	if (!alvium->alvium_csi2_fmt)
> > 		return -ENOMEM;
> > 
> > Then the call will be:
> > 
> > 	ret = alvium_setup_mipi_fmt(alvium);
> > 	if (ret) {
> > 		dev_err_probe(dev, ret, "setup_mipi_fmt fail\n");
> > 		goto err_powerdown;
> > 	}
> > 
> > For freeing this what about adding kfree into err_pm label of probe
> > function. This is the clean way that jump in my mind right now.
> > 
> > err_subdev:
> > 	alvium_subdev_cleanup(alvium);
> > err_pm:
> > 	pm_runtime_disable(dev);
> > 	pm_runtime_put_noidle(dev);
> > 	kfree(alvium->alvium_csi2_fmt);
> > err_powerdown:
> > 	alvium_set_power(alvium, false);
> > 
> > 	return ret;
> > 
> > 
> > I think also kfree(alvium->alvium_csi2_fmt);
> > at the end of the alvium_subdev_cleanup is the only way that we have no?
> 
> You can't put it there as you're already freeing it under err_pm label
> above.

Damn, yep. Thanks.

> 
> Otherwise this seems good to me.

Perfect.

> 
> > 
> > Here I plan to free also to clean the alvium->ep as you suggested.
> > 
> > static void alvium_subdev_cleanup(struct alvium_dev *alvium)
> > {
> > 	v4l2_fwnode_endpoint_free(&alvium->ep);
> > 	v4l2_subdev_cleanup(&alvium->sd);
> > 	media_entity_cleanup(&alvium->sd.entity);
> > 	v4l2_ctrl_handler_free(&alvium->ctrls.handler);
> > 	kfree(alvium->alvium_csi2_fmt);
> > }
> > 
> > Right now I haven't find a way to put an err_free label as you
> > suggested. :'(
> > 
> > What do you think?
> > 
> > > > 
> > > > static void alvium_subdev_cleanup(struct alvium_dev *alvium)
> > > > {
> > > > 	v4l2_subdev_cleanup(&alvium->sd);
> > > > 	media_entity_cleanup(&alvium->sd.entity);
> > > > 	v4l2_ctrl_handler_free(&alvium->ctrls.handler);
> > > > 	kfree(alvium->alvium_csi2_fmt);
> > > > }
> > > >  What do you think?
> > > > 
> 
> ...
> 
> > > > > > +static int alvium_init_cfg(struct v4l2_subdev *sd,
> > > > > > +			   struct v4l2_subdev_state *state)
> > > > > > +{
> > > > > > +	struct alvium_dev *alvium = sd_to_alvium(sd);
> > > > > > +	struct alvium_mode *mode = &alvium->mode;
> > > > > > +	struct v4l2_subdev_format sd_fmt = {
> > > > > > +		.which = V4L2_SUBDEV_FORMAT_TRY,
> > > > > > +		.format = alvium_csi2_default_fmt,
> > > > > > +	};
> > > > > > +	struct v4l2_subdev_crop sd_crop = {
> > > > > > +		.which = V4L2_SUBDEV_FORMAT_TRY,
> > > > > > +		.rect = {
> > > > > > +			.left = mode->crop.left,
> > > > > > +			.top = mode->crop.top,
> > > > > > +			.width = mode->crop.width,
> > > > > > +			.height = mode->crop.height,
> > > > > > +		},
> > > > > > +	};
> > > > > > +
> > > > > > +	*v4l2_subdev_get_pad_crop(sd, state, 0) = sd_crop.rect;
> > > > > > +	*v4l2_subdev_get_pad_format(sd, state, 0) = sd_fmt.format;
> > > > > 
> > > > > Shouldn't the format have same width and height as crop? What about the
> > > > > mbus code?
> > 
> > Can you clarify to me this comment pls :)
> 
> The purpose of the init_cfg operation is to initialise the sub-device
> state, including format and crop rectangle (if applicable). The width and
> height fields of the format are not initialised above, leaving them zeros.

Mmmmm.
Why zeros?

.format = alvium_csi2_default_fmt

where:

static const struct v4l2_mbus_framefmt alvium_csi2_default_fmt = {
	.code = MEDIA_BUS_FMT_UYVY8_1X16,
	.width = 640,
	.height = 480,
	.colorspace = V4L2_COLORSPACE_SRGB,
	.ycbcr_enc = V4L2_MAP_YCBCR_ENC_DEFAULT(V4L2_COLORSPACE_SRGB),
	.quantization = V4L2_QUANTIZATION_FULL_RANGE,
	.xfer_func = V4L2_MAP_XFER_FUNC_DEFAULT(V4L2_COLORSPACE_SRGB),
	.field = V4L2_FIELD_NONE,
};

> That doesn't seem to be a valid configuration, given that the crop
> rectangle is initiliased with different values.

Why different values?
crop is initialized into subdev_init

static int alvium_subdev_init(struct alvium_dev *alvium)
{
	struct i2c_client *client = alvium->i2c_client;
	struct device *dev = &alvium->i2c_client->dev;
	struct v4l2_subdev *sd = &alvium->sd;
	int ret;

	/* Setup initial frame interval*/
	alvium->frame_interval.numerator = 1;
	alvium->frame_interval.denominator = ALVIUM_DEFAULT_FR_HZ;
	alvium->fr = ALVIUM_DEFAULT_FR_HZ;

	/* Setup the initial mode */
	alvium->mode.fmt = alvium_csi2_default_fmt;
	alvium->mode.width = alvium_csi2_default_fmt.width;
	alvium->mode.height = alvium_csi2_default_fmt.height;
	alvium->mode.crop.left = alvium->min_offx;
	alvium->mode.crop.top = alvium->min_offy;
	alvium->mode.crop.width = alvium_csi2_default_fmt.width;
	alvium->mode.crop.height = alvium_csi2_default_fmt.height;
...

Then:

static int alvium_init_cfg(struct v4l2_subdev *sd,
			   struct v4l2_subdev_state *state)
{
	struct alvium_dev *alvium = sd_to_alvium(sd);
	struct alvium_mode *mode = &alvium->mode;
	struct v4l2_subdev_format sd_fmt = {
		.which = V4L2_SUBDEV_FORMAT_TRY,
		.format = alvium_csi2_default_fmt,
	};
	struct v4l2_subdev_crop sd_crop = {
		.which = V4L2_SUBDEV_FORMAT_TRY,
		.rect = {
			.left = mode->crop.left,
			.top = mode->crop.top,
			.width = mode->crop.width,
			.height = mode->crop.height,
		},
	};
...

Seems that crop and format are using the same init values
or I'm wrong?
Mmm.. maybe I'm missing something?

Let me know

> 
> > 
> > > > > 
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int alvium_set_fmt(struct v4l2_subdev *sd,
> > > > > > +			  struct v4l2_subdev_state *sd_state,
> > > > > > +			  struct v4l2_subdev_format *format)
> > > > > > +{
> > > > > > +	struct alvium_dev *alvium = sd_to_alvium(sd);
> > > > > > +	const struct alvium_pixfmt *alvium_csi2_fmt;
> > > > > > +	struct v4l2_mbus_framefmt *fmt;
> > > > > > +	struct v4l2_rect *crop;
> > > > > > +
> > > > > > +	fmt = v4l2_subdev_get_pad_format(sd, sd_state, 0);
> > > > > > +	crop = v4l2_subdev_get_pad_crop(sd, sd_state, 0);
> > > > > > +
> > > > > > +	fmt->width = clamp(format->format.width, alvium->img_min_width,
> > > > > > +			   alvium->img_max_width);
> > > > > > +	fmt->height = clamp(format->format.height, alvium->img_min_height,
> > > > > > +			    alvium->img_max_height);
> > > > > > +
> > > > > > +	/* Adjust left and top to prevent roll over sensor area */
> > > > > > +	crop->left = clamp((u32)crop->left, (u32)0,
> > > > > > +			   (alvium->img_max_width - fmt->width));
> > > > > > +	crop->top = clamp((u32)crop->top, (u32)0,
> > > > > > +			  (alvium->img_max_height - fmt->height));
> > > > > > +
> > > > > > +	/* Set also the crop width and height when set a new fmt */
> > > > > > +	crop->width = fmt->width;
> > > > > > +	crop->height = fmt->height;
> > > > > > +
> > > > > > +	alvium_csi2_fmt = alvium_code_to_pixfmt(alvium, format->format.code);
> > > > > > +	fmt->code = alvium_csi2_fmt->code;
> > > > > > +
> > > > > > +	*fmt = format->format;
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int alvium_set_selection(struct v4l2_subdev *sd,
> > > > > > +				struct v4l2_subdev_state *sd_state,
> > > > > > +				struct v4l2_subdev_selection *sel)
> > > > > > +{
> > > > > > +	struct alvium_dev *alvium = sd_to_alvium(sd);
> > > > > > +	struct v4l2_mbus_framefmt *fmt;
> > > > > > +	struct v4l2_rect *crop;
> > > > > > +
> > > > > > +	crop = v4l2_subdev_get_pad_crop(sd, sd_state, 0);
> > > > > > +	fmt = v4l2_subdev_get_pad_format(sd, sd_state, 0);
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Alvium can only shift the origin of the img
> > > > > > +	 * then we accept only value with the same value of the actual fmt
> > > > > > +	 */
> > > > > > +	if (sel->r.width != fmt->width)
> > > > > > +		sel->r.width = fmt->width;
> > > > > > +
> > > > > > +	if (sel->r.height != fmt->height)
> > > > > > +		sel->r.height = fmt->height;
> > > > > > +
> > > > > > +	if (sel->target != V4L2_SEL_TGT_CROP)
> > > > > > +		return -EINVAL;
> > > > > 
> > > > > This should be the first thing to test.
> > > > 
> > > > Oks
> > > > 
> > > > > 
> > > > > > +
> > > > > > +	/* alvium don't accept negative crop left/top */
> > > > > > +	crop->left = clamp((u32)max(0, sel->r.left), alvium->min_offx,
> > > > > > +			   alvium->img_max_width - sel->r.width);
> > > > > > +	crop->top = clamp((u32)max(0, sel->r.top), alvium->min_offy,
> > > > > > +			  alvium->img_max_height - sel->r.height);
> > > > > > +
> > > > > > +	sel->r = *crop;
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int alvium_get_selection(struct v4l2_subdev *sd,
> > > > > > +				struct v4l2_subdev_state *sd_state,
> > > > > > +				struct v4l2_subdev_selection *sel)
> > > > > > +{
> > > > > > +	struct alvium_dev *alvium = sd_to_alvium(sd);
> > > > > > +
> > > > > > +	switch (sel->target) {
> > > > > > +	/* Current cropping area */
> > > > > > +	case V4L2_SEL_TGT_CROP:
> > > > > > +		sel->r = *v4l2_subdev_get_pad_crop(sd, sd_state, 0);
> > > > > > +		break;
> > > > > > +	/* Cropping bounds */
> > > > > > +	case V4L2_SEL_TGT_NATIVE_SIZE:
> > > > > > +		sel->r.top = 0;
> > > > > > +		sel->r.left = 0;
> > > > > > +		sel->r.width = alvium->img_max_width;
> > > > > > +		sel->r.height = alvium->img_max_height;
> > > > > > +		break;
> > > > > > +	/* Default cropping area */
> > > > > > +	case V4L2_SEL_TGT_CROP_BOUNDS:
> > > > > > +	case V4L2_SEL_TGT_CROP_DEFAULT:
> > > > > > +		sel->r.top = alvium->min_offy;
> > > > > > +		sel->r.left = alvium->min_offx;
> > > > > > +		sel->r.width = alvium->img_max_width;
> > > > > > +		sel->r.height = alvium->img_max_height;
> > > > > > +		break;
> > > > > > +	default:
> > > > > > +		return -EINVAL;
> > > > > > +	}
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int alvium_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
> > > > > > +{
> > > > > > +	struct v4l2_subdev *sd = ctrl_to_sd(ctrl);
> > > > > > +	struct alvium_dev *alvium = sd_to_alvium(sd);
> > > > > > +	int val;
> > > > > > +
> > > > > > +	switch (ctrl->id) {
> > > > > > +	case V4L2_CID_GAIN:
> > > > > > +		val = alvium_get_gain(alvium);
> > > > > > +		if (val < 0)
> > > > > > +			return val;
> > > > > > +		alvium->ctrls.gain->val = val;
> > > > > > +		break;
> > > > > > +	case V4L2_CID_EXPOSURE:
> > > > > > +		val = alvium_get_exposure(alvium);
> > > > > > +		if (val < 0)
> > > > > > +			return val;
> > > > > > +		alvium->ctrls.exposure->val = val;
> > > > > > +		break;
> > > > > > +	}
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static int alvium_s_ctrl(struct v4l2_ctrl *ctrl)
> > > > > > +{
> > > > > > +	struct v4l2_subdev *sd = ctrl_to_sd(ctrl);
> > > > > > +	struct alvium_dev *alvium = sd_to_alvium(sd);
> > > > > > +	struct i2c_client *client = v4l2_get_subdevdata(&alvium->sd);
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Applying V4L2 control value only happens
> > > > > > +	 * when power is up for streaming
> > > > > > +	 */
> > > > > > +	if (!pm_runtime_get_if_in_use(&client->dev))
> > > > > > +		return 0;
> > > > > > +
> > > > > > +	switch (ctrl->id) {
> > > > > > +	case V4L2_CID_AUTOGAIN:
> > > > > > +		ret = alvium_set_ctrl_gain(alvium, ctrl->val);
> > > > > 
> > > > > 		ret = alvium_set_autogain(alvium, ctrl->val);
> > > > > 
> > > > 
> > > > Pls check [1]
> > > > 
> > > > > Where do you set the manual gain value? What about the manual exposure
> > > > > value? Both appear to be missing here.
> > > > > 
> > > > > How have you tested this?
> > > > > 
> > > > > > +		break;
> > > > > > +	case V4L2_CID_EXPOSURE_AUTO:
> > > > > > +		ret = alvium_set_ctrl_exposure(alvium, ctrl->val);
> > > > > 
> > > > > 		ret = alvium_set_autoexposure(alvium, ctrl->val);
> > > > > 
> > > > > You're still missing grabbing the manual controls when the corresponding
> > > > > automatic control is enabled. I've commented on the same matter previously.
> > > > 
> > > > Same comment in [1]
> > > > 
> > > > > 
> > > > > > +		break;
> > > > > > +	case V4L2_CID_AUTO_WHITE_BALANCE:
> > > > > > +		ret = alvium_set_ctrl_white_balance(alvium, ctrl->val);
> > > > > > +		break;
> > > > > > +	case V4L2_CID_HUE:
> > > > > > +		ret = alvium_set_ctrl_hue(alvium, ctrl->val);
> > > > > > +		break;
> > > > > > +	case V4L2_CID_CONTRAST:
> > > > > > +		ret = alvium_set_ctrl_contrast(alvium, ctrl->val);
> > > > > > +		break;
> > > > > > +	case V4L2_CID_SATURATION:
> > > > > > +		ret = alvium_set_ctrl_saturation(alvium, ctrl->val);
> > > > > > +		break;
> > > > > > +	case V4L2_CID_GAMMA:
> > > > > > +		ret = alvium_set_ctrl_gamma(alvium, ctrl->val);
> > > > > > +		break;
> > > > > > +	case V4L2_CID_SHARPNESS:
> > > > > > +		ret = alvium_set_ctrl_sharpness(alvium, ctrl->val);
> > > > > > +		break;
> > > > > > +	case V4L2_CID_HFLIP:
> > > > > > +		ret = alvium_set_ctrl_hflip(alvium, ctrl->val);
> > > > > > +		break;
> > > > > > +	case V4L2_CID_VFLIP:
> > > > > > +		ret = alvium_set_ctrl_vflip(alvium, ctrl->val);
> > > > > > +		break;
> > > > > > +	default:
> > > > > > +		ret = -EINVAL;
> > > > > > +		break;
> > > > > > +	}
> > > > > > +
> > > > > > +	pm_runtime_put(&client->dev);
> > > > > > +
> > > > > > +	return ret;
> > > > > > +}

Here I plan to switch to:

static int alvium_s_ctrl(struct v4l2_ctrl *ctrl)
{
	struct v4l2_subdev *sd = ctrl_to_sd(ctrl);
	struct alvium_dev *alvium = sd_to_alvium(sd);
	struct i2c_client *client = v4l2_get_subdevdata(&alvium->sd);
	int ret;

	/*
	 * Applying V4L2 control value only happens
	 * when power is up for streaming
	 */
	if (!pm_runtime_get_if_in_use(&client->dev))
		return 0;

	switch (ctrl->id) {
	case V4L2_CID_GAIN:
		ret = alvium_set_ctrl_gain(alvium, ctrl->val);
		break;
	case V4L2_CID_AUTOGAIN:
		ret = alvium_set_ctrl_auto_gain(alvium, ctrl->val);
		break;
	case V4L2_CID_EXPOSURE:
		ret = alvium_set_ctrl_exposure(alvium, ctrl->val);
		break;
	case V4L2_CID_EXPOSURE_AUTO:
		ret = alvium_set_ctrl_auto_exposure(alvium, ctrl->val);
		break;
	case V4L2_CID_RED_BALANCE:
		ret = alvium_set_ctrl_red_balance_ratio(alvium, ctrl->val);
		break;
	case V4L2_CID_BLUE_BALANCE:
		ret = alvium_set_ctrl_blue_balance_ratio(alvium, ctrl->val);
		break;
	case V4L2_CID_AUTO_WHITE_BALANCE:
		ret = alvium_set_ctrl_awb(alvium, ctrl->val);
		break;
	case V4L2_CID_HUE:
		ret = alvium_set_ctrl_hue(alvium, ctrl->val);
		break;
	case V4L2_CID_CONTRAST:
		ret = alvium_set_ctrl_contrast(alvium, ctrl->val);
		break;
	case V4L2_CID_SATURATION:
		ret = alvium_set_ctrl_saturation(alvium, ctrl->val);
		break;
	case V4L2_CID_GAMMA:
		ret = alvium_set_ctrl_gamma(alvium, ctrl->val);
		break;
	case V4L2_CID_SHARPNESS:
		ret = alvium_set_ctrl_sharpness(alvium, ctrl->val);
		break;
	case V4L2_CID_HFLIP:
		ret = alvium_set_ctrl_hflip(alvium, ctrl->val);
		break;
	case V4L2_CID_VFLIP:
		ret = alvium_set_ctrl_vflip(alvium, ctrl->val);
		break;
	default:
		ret = -EINVAL;
		break;
	}

	pm_runtime_put(&client->dev);

	return ret;
}

Like you suggested.
I think is more clean/understandable.
Thanks for your comment.


> > > > > > +
> > > > > > +static const struct v4l2_ctrl_ops alvium_ctrl_ops = {
> > > > > > +	.g_volatile_ctrl = alvium_g_volatile_ctrl,
> > > > > > +	.s_ctrl = alvium_s_ctrl,
> > > > > > +};
> > > > > > +
> > > > > > +static int alvium_ctrl_init(struct alvium_dev *alvium)
> > > > > > +{
> > > > > > +	const struct v4l2_ctrl_ops *ops = &alvium_ctrl_ops;
> > > > > > +	struct alvium_ctrls *ctrls = &alvium->ctrls;
> > > > > > +	struct v4l2_ctrl_handler *hdl = &ctrls->handler;
> > > > > > +	struct v4l2_fwnode_device_properties props;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	v4l2_ctrl_handler_init(hdl, 32);
> > > > > > +
> > > > > > +	/* Pixel rate is fixed */
> > > > > > +	ctrls->pixel_rate = v4l2_ctrl_new_std(hdl, ops,
> > > > > > +					      V4L2_CID_PIXEL_RATE, 0,
> > > > > > +					      ALVIUM_DEFAULT_PIXEL_RATE_MHZ, 1,
> > > > > > +					      ALVIUM_DEFAULT_PIXEL_RATE_MHZ);
> > > > > > +
> > > > > > +	/* Link freq is fixed */
> > > > > > +	ctrls->link_freq = v4l2_ctrl_new_int_menu(hdl, ops,
> > > > > > +						  V4L2_CID_LINK_FREQ,
> > > > > > +					          0, 0, &alvium->link_freq);
> > > > > > +
> > > > > > +	/* Auto/manual white balance */
> > > > > > +	ctrls->auto_wb = v4l2_ctrl_new_std(hdl, ops,
> > > > > > +					   V4L2_CID_AUTO_WHITE_BALANCE,
> > > > > > +					   0, 1, 1,
> > > > > > +					   alvium->avail_ft.auto_whiteb ? 1 : 0);
> > > > > > +
> > > > > > +	ctrls->blue_balance = v4l2_ctrl_new_std(hdl, ops,
> > > > > > +						V4L2_CID_BLUE_BALANCE,
> > > > > > +						alvium->min_bbalance,
> > > > > > +						alvium->max_bbalance,
> > > > > > +						alvium->inc_bbalance,
> > > > > > +						alvium->dft_bbalance);
> > > > > > +	ctrls->red_balance = v4l2_ctrl_new_std(hdl, ops,
> > > > > > +					       V4L2_CID_RED_BALANCE,
> > > > > > +					       alvium->min_rbalance,
> > > > > > +					       alvium->max_rbalance,
> > > > > > +					       alvium->inc_rbalance,
> > > > > > +					       alvium->dft_rbalance);
> > > > > > +
> > > > > > +	/* Auto/manual exposure */
> > > > > > +	ctrls->auto_exp = v4l2_ctrl_new_std_menu(hdl, ops,
> > > > > > +						 V4L2_CID_EXPOSURE_AUTO,
> > > > > > +						 V4L2_EXPOSURE_MANUAL, 0,
> > > > > > +						 alvium->avail_ft.auto_exp ?
> > > > > > +						 V4L2_EXPOSURE_AUTO : V4L2_EXPOSURE_MANUAL);
> > > > > > +
> > > > > > +	ctrls->exposure = v4l2_ctrl_new_std(hdl, ops,
> > > > > > +					    V4L2_CID_EXPOSURE,
> > > > > > +					    alvium->min_exp,
> > > > > > +					    alvium->max_exp,
> > > > > > +					    alvium->inc_exp,
> > > > > > +					    alvium->dft_exp);
> > > > > > +
> > > > > > +	/* Auto/manual gain */
> > > > > > +	ctrls->auto_gain = v4l2_ctrl_new_std(hdl, ops,
> > > > > > +					     V4L2_CID_AUTOGAIN,
> > > > > > +					     0, 1, 1,
> > > > > > +					     alvium->avail_ft.auto_gain ? 1 : 0);
> > > > > > +
> > > > > > +	if (alvium->avail_ft.gain)
> > > > > > +		ctrls->gain = v4l2_ctrl_new_std(hdl, ops,
> > > > > > +						V4L2_CID_GAIN,
> > > > > > +						alvium->min_gain,
> > > > > > +						alvium->max_gain,
> > > > > > +						alvium->inc_gain,
> > > > > > +						alvium->dft_gain);
> > > > > > +
> > > > > > +	if (alvium->avail_ft.sat)
> > > > > > +		ctrls->saturation = v4l2_ctrl_new_std(hdl, ops,
> > > > > > +						      V4L2_CID_SATURATION,
> > > > > > +					              alvium->min_sat,
> > > > > > +					              alvium->max_sat,
> > > > > > +					              alvium->inc_sat,
> > > > > > +					              alvium->dft_sat);
> > > > > > +
> > > > > > +	if (alvium->avail_ft.hue)
> > > > > > +		ctrls->hue = v4l2_ctrl_new_std(hdl, ops,
> > > > > > +					       V4L2_CID_HUE,
> > > > > > +					       alvium->min_hue,
> > > > > > +					       alvium->max_hue,
> > > > > > +					       alvium->inc_hue,
> > > > > > +					       alvium->dft_hue);
> > > > > > +
> > > > > > +	if (alvium->avail_ft.contrast)
> > > > > > +		ctrls->contrast = v4l2_ctrl_new_std(hdl, ops,
> > > > > > +						    V4L2_CID_CONTRAST,
> > > > > > +					            alvium->min_contrast,
> > > > > > +					            alvium->max_contrast,
> > > > > > +					            alvium->inc_contrast,
> > > > > > +					            alvium->dft_contrast);
> > > > > > +
> > > > > > +	if (alvium->avail_ft.gamma)
> > > > > > +		ctrls->gamma = v4l2_ctrl_new_std(hdl, ops,
> > > > > > +						 V4L2_CID_GAMMA,
> > > > > > +						 alvium->min_gamma,
> > > > > > +						 alvium->max_gamma,
> > > > > > +						 alvium->inc_gamma,
> > > > > > +						 alvium->dft_gamma);
> > > > > > +
> > > > > > +	if (alvium->avail_ft.sharp)
> > > > > > +		ctrls->sharpness = v4l2_ctrl_new_std(hdl, ops,
> > > > > > +						     V4L2_CID_SHARPNESS,
> > > > > > +						     alvium->min_sharp,
> > > > > > +						     alvium->max_sharp,
> > > > > > +						     alvium->inc_sharp,
> > > > > > +						     alvium->dft_sharp);
> > > > > > +
> > > > > > +	if (alvium->avail_ft.rev_x)
> > > > > > +		ctrls->hflip = v4l2_ctrl_new_std(hdl, ops,
> > > > > > +						 V4L2_CID_HFLIP,
> > > > > 
> > > > > Fits on previous line.
> > > > > 
> > > > > > +						 0, 1, 1, 0);
> > > > > > +
> > > > > > +	if (alvium->avail_ft.rev_y)
> > > > > > +		ctrls->vflip = v4l2_ctrl_new_std(hdl, ops,
> > > > > > +						 V4L2_CID_VFLIP,
> > > > > 
> > > > > Ditto.
> > > > > 
> > > > > > +						 0, 1, 1, 0);
> > > > > > +
> > > > 
> > > > Oks
> > > > > > +	if (hdl->error) {
> > > > > > +		ret = hdl->error;
> > > > > > +		goto free_ctrls;
> > > > > > +	}
> > > > > > +
> > > > > > +	ret = v4l2_fwnode_device_parse(&alvium->i2c_client->dev, &props);
> > > > > > +	if (ret)
> > > > > > +		goto free_ctrls;
> > > > > > +
> > > > > > +	ret = v4l2_ctrl_new_fwnode_properties(hdl, ops, &props);
> > > > > > +	if (ret)
> > > > > > +		goto free_ctrls;
> > > > > > +
> > > > > > +	ctrls->pixel_rate->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> > > > > > +	ctrls->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> > > > > > +	ctrls->gain->flags |= V4L2_CTRL_FLAG_VOLATILE;
> > > > > > +	ctrls->exposure->flags |= V4L2_CTRL_FLAG_VOLATILE;
> > > > > > +
> > > > > > +	v4l2_ctrl_auto_cluster(3, &ctrls->auto_wb, 0, false);
> > > > > > +	v4l2_ctrl_auto_cluster(2, &ctrls->auto_gain, 0, true);
> > > > > > +	v4l2_ctrl_auto_cluster(2, &ctrls->auto_exp, 1, true);
> > > > > > +
> > > > > > +	alvium->sd.ctrl_handler = hdl;
> > > > > > +	return 0;
> > > > > > +
> > > > > > +free_ctrls:
> > > > > > +	v4l2_ctrl_handler_free(hdl);
> > > > > > +	return ret;
> > > > > > +}
> > > > > > +
> > > > > > +static const struct v4l2_subdev_core_ops alvium_core_ops = {
> > > > > > +	.log_status = v4l2_ctrl_subdev_log_status,
> > > > > > +	.subscribe_event = v4l2_ctrl_subdev_subscribe_event,
> > > > > > +	.unsubscribe_event = v4l2_event_subdev_unsubscribe,
> > > > > > +};
> > > > > > +
> > > > > > +static const struct v4l2_subdev_video_ops alvium_video_ops = {
> > > > > > +	.g_frame_interval	= alvium_g_frame_interval,
> > > > > > +	.s_frame_interval	= alvium_s_frame_interval,
> > > > > > +	.s_stream		= alvium_s_stream,
> > > > > > +};
> > > > > > +
> > > > > > +static const struct v4l2_subdev_pad_ops alvium_pad_ops = {
> > > > > > +	.init_cfg = alvium_init_cfg,
> > > > > > +	.enum_mbus_code = alvium_enum_mbus_code,
> > > > > > +	.get_fmt = v4l2_subdev_get_fmt,
> > > > > > +	.set_fmt = alvium_set_fmt,
> > > > > > +	.get_selection = alvium_get_selection,
> > > > > > +	.set_selection = alvium_set_selection,
> > > > > > +};
> > > > > > +
> > > > > > +static const struct v4l2_subdev_ops alvium_subdev_ops = {
> > > > > > +	.core	= &alvium_core_ops,
> > > > > > +	.pad	= &alvium_pad_ops,
> > > > > > +	.video	= &alvium_video_ops,
> > > > > > +};
> > > > > > +
> > > > > > +static int alvium_subdev_init(struct alvium_dev *alvium)
> > > > > > +{
> > > > > > +	struct i2c_client *client = alvium->i2c_client;
> > > > > > +	struct device *dev = &alvium->i2c_client->dev;
> > > > > > +	struct v4l2_subdev *sd = &alvium->sd;
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	/* Setup initial frame interval*/
> > > > > > +	alvium->frame_interval.numerator = 1;
> > > > > > +	alvium->frame_interval.denominator = ALVIUM_DEFAULT_FR_HZ;
> > > > > > +	alvium->fr = ALVIUM_DEFAULT_FR_HZ;
> > > > > > +
> > > > > > +	/* Setup the initial mode */
> > > > > > +	alvium->mode.fmt = alvium_csi2_default_fmt;
> > > > > > +	alvium->mode.width = alvium_csi2_default_fmt.width;
> > > > > > +	alvium->mode.height = alvium_csi2_default_fmt.height;
> > > > > > +	alvium->mode.crop.left = alvium->min_offx;
> > > > > > +	alvium->mode.crop.top = alvium->min_offy;
> > > > > > +	alvium->mode.crop.width = alvium_csi2_default_fmt.width;
> > > > > > +	alvium->mode.crop.height = alvium_csi2_default_fmt.height;
> > > > > > +
> > > > > > +	/* init alvium sd */
> > > > > > +	v4l2_i2c_subdev_init(sd, client, &alvium_subdev_ops);
> > > > > > +
> > > > > > +	sd->flags |= V4L2_SUBDEV_FL_HAS_EVENTS | V4L2_SUBDEV_FL_HAS_DEVNODE;
> > > > > > +	alvium->pad.flags = MEDIA_PAD_FL_SOURCE;
> > > > > > +	sd->entity.function = MEDIA_ENT_F_CAM_SENSOR;
> > > > > > +
> > > > > > +	ret = media_entity_pads_init(&sd->entity, 1, &alvium->pad);
> > > > > > +	if (ret) {
> > > > > > +		dev_err(dev, "Could not register media entity\n");
> > > > > > +		return ret;
> > > > > > +	}
> > > > > > +
> > > > > > +	ret = alvium_ctrl_init(alvium);
> > > > > > +	if (ret) {
> > > > > > +		dev_err(dev, "Control initialization error %d\n", ret);
> > > > > > +		goto entity_cleanup;
> > > > > > +	}
> > > > > > +
> > > > > > +	alvium->sd.state_lock = alvium->ctrls.handler.lock;
> > > > > > +
> > > > > > +	ret = v4l2_subdev_init_finalize(sd);
> > > > > > +	if (ret < 0) {
> > > > > > +		dev_err(dev, "subdev initialization error %d\n", ret);
> > > > > > +		goto err_ctrls;
> > > > > > +	}
> > > > > > +
> > > > > > +	return 0;
> > > > > > +
> > > > > > +err_ctrls:
> > > > > > +	v4l2_ctrl_handler_free(&alvium->ctrls.handler);
> > > > > > +entity_cleanup:
> > > > > > +	media_entity_cleanup(&alvium->sd.entity);
> > > > > > +	return ret;
> > > > > > +}
> > > > > > +
> > > > > > +static void alvium_subdev_cleanup(struct alvium_dev *alvium)
> > > > > > +{
> > > > > > +	v4l2_subdev_cleanup(&alvium->sd);
> > > > > > +	media_entity_cleanup(&alvium->sd.entity);
> > > > > > +	v4l2_ctrl_handler_free(&alvium->ctrls.handler);
> > > > > > +}
> > > > > > +
> > > > > > +static int alvium_get_dt_data(struct alvium_dev *alvium)
> > > > > > +{
> > > > > > +	struct device *dev = &alvium->i2c_client->dev;
> > > > > > +	struct fwnode_handle *fwnode = dev_fwnode(dev);
> > > > > > +	struct fwnode_handle *endpoint;
> > > > > > +
> > > > > > +	if (!fwnode)
> > > > > > +		return -EINVAL;
> > > > > > +
> > > > > > +	/* Only CSI2 is supported for now: */
> > > > > > +	alvium->ep.bus_type = V4L2_MBUS_CSI2_DPHY;
> > > > > > +
> > > > > > +	endpoint = fwnode_graph_get_endpoint_by_id(fwnode, 0, 0, 0);
> > > > > > +	if (!endpoint) {
> > > > > > +		dev_err(dev, "endpoint node not found\n");
> > > > > > +		return -EINVAL;
> > > > > > +	}
> > > > > > +
> > > > > > +	if (v4l2_fwnode_endpoint_alloc_parse(endpoint, &alvium->ep)) {
> > > > > > +		dev_err(dev, "could not parse endpoint\n");
> > > > > > +		goto error_out;
> > > > > > +	}
> > > > > > +
> > > > > > +	if (!alvium->ep.nr_of_link_frequencies) {
> > > > > > +		dev_err(dev, "no link frequencies defined");
> > > > > > +		goto error_out;
> > > > > > +	}
> > > > > > +
> > > > > > +	return 0;
> > > > > > +
> > > > > > +error_out:
> > > > > > +	v4l2_fwnode_endpoint_free(&alvium->ep);
> > > 
> > > You're missing a call to release this in successful case.
> > 
> > As written before what about freeing this into?
> > 
> > static void alvium_subdev_cleanup(struct alvium_dev *alvium)
> > {
> > 	v4l2_fwnode_endpoint_free(&alvium->ep);
> > 	v4l2_subdev_cleanup(&alvium->sd);
> > 	media_entity_cleanup(&alvium->sd.entity);
> > 	v4l2_ctrl_handler_free(&alvium->ctrls.handler);
> > 	kfree(alvium->alvium_csi2_fmt);
> > }
> 
> I think putting v4l2_fwnode_endpoint_free() there should be fine, as long
> as alvium_subdev_cleanup() is called late enough in probe error handling to
> qualify.

Perfect, thanks.
I saw also others drivers that are using this way.

> 
> -- 
> Regards,
> 
> Sakari Ailus

Thanks & regards,
Tommaso
