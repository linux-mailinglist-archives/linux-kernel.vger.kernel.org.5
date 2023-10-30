Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13607DBBD6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:32:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbjJ3Ocu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbjJ3Oct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:32:49 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0157C6;
        Mon, 30 Oct 2023 07:32:45 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53f6ccea1eeso7762386a12.3;
        Mon, 30 Oct 2023 07:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698676364; x=1699281164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nuRY0ZqBCSsSiuHkQjZv0YNP5eXHSp7/EKCMIVqUMqs=;
        b=Z6gBCs6hvWR003Vg71BYLk5I8dVX/0yBNb1p8hEBQH5R6hJKwaS6aiPT+BNG2CNMhx
         YkmvY321xofKTt4JiDRtL8N62UYJ0BIP5W0/0HrPkQwxMWD28oMEOpg/lY5fTzciSg6b
         TYqFmBAQyCnHskhMffI6N/xPy4KilrpCNjhENXivIj2571E8AJagMHBX2ifV0noKbOJ+
         umegIwEYo1ClPpRrnzeqyKkDr3ZIZBuma7TspALl3jNiJunoLy+RDC8cybNV48WEcUpH
         6dul6gWatIiQ8Y8Akow7TeFtW92KPLJZzueSOLSsayxU3rxO1m/JFEuMdbGpxnT5PG+x
         afDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698676364; x=1699281164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuRY0ZqBCSsSiuHkQjZv0YNP5eXHSp7/EKCMIVqUMqs=;
        b=tGmk1sper+Y1BGrfCR+8O3bPf9jgdrlPm32wG/G0ZAWlgPA7qh8SekPiKBDc/dn0Ju
         9P/OPzTamf6QF3uxMraVnYBtC03Hrc9dGP8XczdXULk3P8YECHG/vvhaAvc4PsXIUYFp
         ww3JOv7xkh/NVM2/F2lE3y1iE+itmY57VY8lTmLhKIrdAlbriN+7JSzO2uy0Fxu5rNbl
         qW7p/GlVKFBN0gj7pQzMg3MmkPN5x5uuXtupoTdGrsZ3sDYx2BmUuOblxxJlVqE7TX4X
         PQiJ1Q6rzwgHWi1Xz5rawCDWBfNDMYTvkTfr5otLv/y9julGZxh9QU3UYZgggyEMxO7a
         hLNA==
X-Gm-Message-State: AOJu0YwLx5+ZW0ZzPAfmnQ1pmSDt/tvTzs0jx1QlvB5Z4B5FPWrJBsKE
        8OfBUl099vfM2FG4hhKB9mU=
X-Google-Smtp-Source: AGHT+IGXLSQI6Pf6DwP8hTkoX0s7g1FL0R4TQ7r/KAJPK1Jhp4kBqxx2stfbTPMF5dY4XQqt2A1OTA==
X-Received: by 2002:aa7:d806:0:b0:522:38cb:d8cb with SMTP id v6-20020aa7d806000000b0052238cbd8cbmr8231026edq.20.1698676363710;
        Mon, 30 Oct 2023 07:32:43 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-59-109.cust.vodafonedsl.it. [188.217.59.109])
        by smtp.gmail.com with ESMTPSA id 26-20020a508e1a000000b0053df23511b0sm6240403edw.29.2023.10.30.07.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 07:32:43 -0700 (PDT)
Date:   Mon, 30 Oct 2023 15:32:40 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>, martin.hecht@avnet.eu,
        michael.roeder@avnet.eu, mhecht73@gmail.com,
        linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Scally <djrscally@gmail.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v10 3/3] media: i2c: Add support for alvium camera
Message-ID: <ZT++iI3DWAqbUr4s@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20231020141354.2500602-1-tomm.merciai@gmail.com>
 <20231020141354.2500602-4-tomm.merciai@gmail.com>
 <ZTpnHdpTgRNll3TC@kekkonen.localdomain>
 <ZT+hEg7WqkQBnLV5@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <20231030123703.GK12144@pendragon.ideasonboard.com>
 <ZT+vwJImu5qS4GyU@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <20231030133739.GL12144@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030133739.GL12144@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,
Thanks for the clear clarification :)

On Mon, Oct 30, 2023 at 03:37:39PM +0200, Laurent Pinchart wrote:
> Hi Tommaso,
> 
> On Mon, Oct 30, 2023 at 02:29:36PM +0100, Tommaso Merciai wrote:
> > On Mon, Oct 30, 2023 at 02:37:03PM +0200, Laurent Pinchart wrote:
> > > On Mon, Oct 30, 2023 at 01:26:58PM +0100, Tommaso Merciai wrote:
> > > > On Thu, Oct 26, 2023 at 01:18:21PM +0000, Sakari Ailus wrote:
> > > > > Hi Tommaso,
> > > > > 
> > > > > Thanks for the update.
> > > > > 
> > > > > There's still quite a bit to do in this driver. Feel free to ask further
> > > > > questions regarding the comments.
> > > > > 
> > > > > On Fri, Oct 20, 2023 at 04:13:51PM +0200, Tommaso Merciai wrote:
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
> > > > > >  MAINTAINERS                     |    9 +
> > > > > >  drivers/media/i2c/Kconfig       |   10 +
> > > > > >  drivers/media/i2c/Makefile      |    1 +
> > > > > >  drivers/media/i2c/alvium-csi2.c | 2666 +++++++++++++++++++++++++++++++
> > > > > >  drivers/media/i2c/alvium-csi2.h |  489 ++++++
> > > > > >  5 files changed, 3175 insertions(+)
> > > > > >  create mode 100644 drivers/media/i2c/alvium-csi2.c
> > > > > >  create mode 100644 drivers/media/i2c/alvium-csi2.h
> > > 
> > > [snip]
> > > 
> > > > > > diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..2c40804655cd
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/media/i2c/alvium-csi2.c
> > > > > > @@ -0,0 +1,2666 @@
> > > 
> > > [snip]
> > > 
> > > > > > +static int alvium_get_host_supp_csi_lanes(struct alvium_dev *alvium)
> > > > > > +{
> > > > > > +	u64 val;
> > > > > > +	int ret = 0;
> > > > > > +
> > > > > > +	alvium_read(alvium, REG_BCRM_CSI2_LANE_COUNT_RW, &val, &ret);
> > > > > 
> > > > > Missing error checking before the use of the value. The same pattern
> > > > > remains prevalent throughout the driver.
> > > > > 
> > > > > I think it'd be easier if you didn't use a temporary variable for reading,
> > > > > but instead had a register width specific access function. You could even
> > > > > introduce a helper macro to read this information as I suggested in an
> > > > > earlier review.
> > > > 
> > > > oks.
> > > > We are moving to use the following macros:
> > > > 
> > > > #define alvium_read_check(alvium, reg, value) \
> > > > { \
> > > > 	int ret = alvium_read(alvium, reg, value, NULL); \
> > > > 	if (ret) \
> > > > 		return ret; \
> > > > }
> > > 
> > > Please don't. Embedding a return in a macro is very confusing for the
> > > reader, and very very frowned upon in the kernel.
> > 
> > I'm a bit confused :)
> > Sorry.
> > 
> > Plan is to replace a common pattern.
> > First I switch to alvium_read(alvium, reg, value, err); implementation.
> > Then I switch to this macro that is not really safe :)
> > 
> > Do you have some hint? :)
> > Thanks in advance.
> > 
> > Maybe I haven't catch completely your comments.
> 
> In this specific case, the right pattern is either
> 
> 	u64 val;
> 	int ret;
> 
> 	ret = alvium_read(alvium, REG_BCRM_CSI2_LANE_COUNT_RW, &val, NULL);
> 	if (ret)
> 		return ret;
> 
> 	alvium->h_sup_csi_lanes = val;
> 
> 	return 0;
> 
> or
> 
> 	u64 val;
> 	int ret = 0;
> 
> 	alvium_read(alvium, REG_BCRM_CSI2_LANE_COUNT_RW, &val, &ret);
> 	if (ret)
> 		return ret;
> 
> 	alvium->h_sup_csi_lanes = val;
> 
> 	return 0;
> 
> I personally prefer the former.

Now it's clear to me.
Thanks, Let's follow this way then :)

> 
> If the function was *writing* multiple registers, the right pattern
> would be
> 
> 	int ret = 0;
> 
> 	alvium_write(alvium, REG_BCRM_REG_1, foo, &ret);
> 	alvium_write(alvium, REG_BCRM_REG_2, bar, &ret);
> 	alvium_write(alvium, REG_BCRM_REG_3, baz, &ret);
> 
> 	if (ret)
> 		return ret;
> 
> 	...
> 
> 	return 0;
> 
> If you have to read multiple registers, you can also do
> 
> 	u64 mul, div;
> 	int ret = 0;
> 
> 	alvium_read(alvium, REG_BCRM_MULTIPLER, &mul, &ret);
> 	alvium_read(alvium, REG_BCRM_DIVIDER, &div, &ret);
> 
> 	if (ret)
> 		return ret;
> 
> 	alvium->value = mul / div;
> 
> 	return 0;

I'm going for example to switch to:

static int alvium_get_offy_params(struct alvium_dev *alvium)
{
	u64 offy_min, offy_max, offy_inc;
	int ret = 0;

	alvium_read_check(alvium, REG_BCRM_IMG_OFFSET_Y_MIN_R, &offy_min, &ret);
	alvium_read_check(alvium, REG_BCRM_IMG_OFFSET_Y_MAX_R, &offy_max, &ret);
	alvium_read_check(alvium, REG_BCRM_IMG_OFFSET_Y_INC_R, &offy_inc, &ret);
	if (ret)
		return ret;

	alvium->min_offy = offy_min;
	alvium->max_offy = offy_max;
	alvium->inc_offy = offy_inc;

	return 0;
}

What do you think about?
Same for similar pattern.

> 
> I hope this is clearer.

Many thanks.

Regards,
Tommaso

> 
> > > > > > +	alvium->h_sup_csi_lanes = val;
> > > > > > +
> > > > > > +	return ret;
> > > > > > +}
> > > 
> > > [snip]
> 
> -- 
> Regards,
> 
> Laurent Pinchart
