Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FB67DBC04
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbjJ3Oo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjJ3Oo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:44:28 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18FCD3;
        Mon, 30 Oct 2023 07:44:24 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 36213AE;
        Mon, 30 Oct 2023 15:44:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1698677045;
        bh=ItlgZwp4s+ZZDdiXASmlW1RRDyMSK1CZN5RrFgXwfFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tvrjnn7Pp3fISQdBFuh64MNOQTLhyv8HwxC32bHj/y69MsO+ikwcWLBEdXhSiJrzZ
         YcPxZJFg1aKijW97oj2Wt7DcQvSst6eZrNyzQEaBGifJEnyZiCUnCDeV1k1ZEd7+O+
         fB6FJ5QMZZDOQ4f+DKtytRLpg2zaJIq9pbIOYn3I=
Date:   Mon, 30 Oct 2023 16:44:27 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
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
Message-ID: <20231030144427.GA12764@pendragon.ideasonboard.com>
References: <20231020141354.2500602-1-tomm.merciai@gmail.com>
 <20231020141354.2500602-4-tomm.merciai@gmail.com>
 <ZTpnHdpTgRNll3TC@kekkonen.localdomain>
 <ZT+hEg7WqkQBnLV5@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <20231030123703.GK12144@pendragon.ideasonboard.com>
 <ZT+vwJImu5qS4GyU@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <20231030133739.GL12144@pendragon.ideasonboard.com>
 <ZT++iI3DWAqbUr4s@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZT++iI3DWAqbUr4s@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

On Mon, Oct 30, 2023 at 03:32:40PM +0100, Tommaso Merciai wrote:
> On Mon, Oct 30, 2023 at 03:37:39PM +0200, Laurent Pinchart wrote:
> > On Mon, Oct 30, 2023 at 02:29:36PM +0100, Tommaso Merciai wrote:
> > > On Mon, Oct 30, 2023 at 02:37:03PM +0200, Laurent Pinchart wrote:
> > > > On Mon, Oct 30, 2023 at 01:26:58PM +0100, Tommaso Merciai wrote:
> > > > > On Thu, Oct 26, 2023 at 01:18:21PM +0000, Sakari Ailus wrote:
> > > > > > Hi Tommaso,
> > > > > > 
> > > > > > Thanks for the update.
> > > > > > 
> > > > > > There's still quite a bit to do in this driver. Feel free to ask further
> > > > > > questions regarding the comments.
> > > > > > 
> > > > > > On Fri, Oct 20, 2023 at 04:13:51PM +0200, Tommaso Merciai wrote:
> > > > > > > The Alvium camera is shipped with sensor + isp in the same housing.
> > > > > > > The camera can be equipped with one out of various sensor and abstract
> > > > > > > the user from this. Camera is connected via MIPI CSI-2.
> > > > > > > 
> > > > > > > Most of the camera module features are supported, with the main exception
> > > > > > > being fw update.
> > > > > > > 
> > > > > > > The driver provides all mandatory, optional and recommended V4L2 controls
> > > > > > > for maximum compatibility with libcamera
> > > > > > > 
> > > > > > > References:
> > > > > > >  - https://www.alliedvision.com/en/products/embedded-vision-solutions
> > > > > > > 
> > > > > > > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > > > > > > ---
> > > > > > > Changes since v2:
> > > > > > >  - Removed gpios/clock handling as suggested by LPinchart
> > > > > > >  - Added vcc-ext-in supply support as suggested by LPinchart
> > > > > > >  - Fixed alvium_setup_mipi_fmt funct as suggested by CJAILLET
> > > > > > >  - Removed upside_down/hshake_bit priv data as suggested by CJAILLET
> > > > > > >  - Fixed commit body as suggested by LPinchart
> > > > > > >  - Mv alvium_set_streamon_delay to yalvium_set_lp2hs_delay
> > > > > > >  - Fixed comment on lp2hs prop as suggested by LPinchart
> > > > > > >  - Added pm resume/suspend functs as suggested by LPinchart
> > > > > > >  - Dropped alvium_link_setup/alvium_s_power as suggested by LPinchart
> > > > > > >  - Fixed regs defines as suggested by LPinchart
> > > > > > >  - Fixed typedef as suggested by LPinchart
> > > > > > >  - Dropped bcrm_v/fw_v from priv data as suggested by LPinchart
> > > > > > >  - Now driver use the subdev active state to store the active format and crop
> > > > > > >    as suggested by LPinchart
> > > > > > >  - Dropped alvium_is_csi2/i2c_to_alvium as suggested by LPinchart
> > > > > > > 
> > > > > > > Changes since v3:
> > > > > > >  - Fixed warnings Reported-by: kernel test robot <lkp@intel.com>
> > > > > > > 
> > > > > > > Changes since v4:
> > > > > > >  - Removed print into alvium_get_dt_data for alliedvision,lp2hs-delay-us as
> > > > > > >    suggested by CDooley
> > > > > > > 
> > > > > > > Changes since v5:
> > > > > > >  - Used tab instead of space in .h as suggested by SAilus
> > > > > > >  - Added support for new CCI API from HDeGoede as suggested by SAilus
> > > > > > >  - Fixed alvium_write/alvium_read, functions now using the new CCI api, suggested by LPinchart
> > > > > > >  - Fixed alvium_get_feat_inq func as suggested by SAilus
> > > > > > >  - Fixed indentation/var-order/includes-order as suggested by SAilus
> > > > > > >  - Fixed alvium_csi2_fmts with MIPI_CSI2_DT_ defines as suggested by SAilus
> > > > > > >  - Fixed alvium_is_alive as suggested by SAilus
> > > > > > >  - Fixed alvium_code_to_pixfmt funct as suggested by SAilus
> > > > > > >  - Fixed alvium_get_dt_data function, now use only fwnode as suggested by SAilus
> > > > > > >  - Fixed autosuspend into the probe, is disable as default as suggested by SAilus
> > > > > > >  - Fixed alvium_get_dt_data function, assigned bus type before parsing the ep
> > > > > > >    as suggested by SAilus
> > > > > > >  - Fixed alvium_power_off, removed wrong print as suggested by SAilus
> > > > > > > 
> > > > > > > Changes since v6:
> > > > > > >  - Fixed .h indentation
> > > > > > >  - Fixed function params indentation
> > > > > > >  - Added int *err params for alvium_read/alvium_write as suggested by LPinchart
> > > > > > >  - Removed dbg print from the driver, driver is now using dbg/err prints that comes from
> > > > > > >    new cci API as suggested by LPinchart. This, fits SAilus suggestion on common pattern function.
> > > > > > >  - Fixed alvium_write_hshake, now use read_poll_timeout as suggested by LPinchart
> > > > > > >  - Removed useless includes
> > > > > > >  - Added maintainers file entries
> > > > > > > 
> > > > > > > Changes since v7:
> > > > > > >  - Fix company legal entity from Inc. to GmbH
> > > > > > >  - Fix warnings given from HVerkuil build-scripts in alvium_get_bcrm_vers,
> > > > > > >    alvium_get_fw_version and probe functions using __le16/__le32. Fixed also
> > > > > > >    probe function warning alvium-csi2.c:2665 alvium_probe() warn: missing error code? 'ret'
> > > > > > > 
> > > > > > > Changes since v8:
> > > > > > >  - Fixed alvium_i2c_driver struct, use probe istead of probe_new
> > > > > > >  - Fixed Kconfig description taking as reference new mt9m114 driver
> > > > > > >  - Fixed Kconfig just select V4L2_CCI_I2C taking as reference new mt9m114 driver
> > > > > > > 
> > > > > > > Changes since v9:
> > > > > > >  - Fixed Y8_1X8 mipi_fmt_regval
> > > > > > >  - Removed alliedvision,lp2hs-delay-us property we set now a default safe value as discussed with SAilus
> > > > > > >  - Added dft property for ctrls initialization, we first read dft values from the camera and set this into ctrls
> > > > > > >  - Fixed indentation as suggested by SAilus
> > > > > > >  - Fixed bit field definitions alignment into .h as suggested by SAilus
> > > > > > >  - Fixed Heartbeat reg from R -> RW
> > > > > > >  - Fixed adjusting values in format/crop changes as suggested by SAilus
> > > > > > >  - Removed unnecessary brcm_addr checks as suggested by SAilus
> > > > > > >  - Merged poweron/poweroff functions as suggested by SAilus
> > > > > > >  - Added poweroff path during probe as suggested by SAilus
> > > > > > >  - Fixed module license type as suggested by SAilus
> > > > > > >  - Removed unnecessary MODULE_DEVICE_TABLE as suggested by SAilus
> > > > > > >  - Fixed pm support in s_ctrl and s_stream functions
> > > > > > >  - Removed unnecessary local variables  as suggested by SAilus
> > > > > > >  - Added ret values checks as suggested by SAilus
> > > > > > > 
> > > > > > >  MAINTAINERS                     |    9 +
> > > > > > >  drivers/media/i2c/Kconfig       |   10 +
> > > > > > >  drivers/media/i2c/Makefile      |    1 +
> > > > > > >  drivers/media/i2c/alvium-csi2.c | 2666 +++++++++++++++++++++++++++++++
> > > > > > >  drivers/media/i2c/alvium-csi2.h |  489 ++++++
> > > > > > >  5 files changed, 3175 insertions(+)
> > > > > > >  create mode 100644 drivers/media/i2c/alvium-csi2.c
> > > > > > >  create mode 100644 drivers/media/i2c/alvium-csi2.h
> > > > 
> > > > [snip]
> > > > 
> > > > > > > diff --git a/drivers/media/i2c/alvium-csi2.c b/drivers/media/i2c/alvium-csi2.c
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..2c40804655cd
> > > > > > > --- /dev/null
> > > > > > > +++ b/drivers/media/i2c/alvium-csi2.c
> > > > > > > @@ -0,0 +1,2666 @@
> > > > 
> > > > [snip]
> > > > 
> > > > > > > +static int alvium_get_host_supp_csi_lanes(struct alvium_dev *alvium)
> > > > > > > +{
> > > > > > > +	u64 val;
> > > > > > > +	int ret = 0;
> > > > > > > +
> > > > > > > +	alvium_read(alvium, REG_BCRM_CSI2_LANE_COUNT_RW, &val, &ret);
> > > > > > 
> > > > > > Missing error checking before the use of the value. The same pattern
> > > > > > remains prevalent throughout the driver.
> > > > > > 
> > > > > > I think it'd be easier if you didn't use a temporary variable for reading,
> > > > > > but instead had a register width specific access function. You could even
> > > > > > introduce a helper macro to read this information as I suggested in an
> > > > > > earlier review.
> > > > > 
> > > > > oks.
> > > > > We are moving to use the following macros:
> > > > > 
> > > > > #define alvium_read_check(alvium, reg, value) \
> > > > > { \
> > > > > 	int ret = alvium_read(alvium, reg, value, NULL); \
> > > > > 	if (ret) \
> > > > > 		return ret; \
> > > > > }
> > > > 
> > > > Please don't. Embedding a return in a macro is very confusing for the
> > > > reader, and very very frowned upon in the kernel.
> > > 
> > > I'm a bit confused :)
> > > Sorry.
> > > 
> > > Plan is to replace a common pattern.
> > > First I switch to alvium_read(alvium, reg, value, err); implementation.
> > > Then I switch to this macro that is not really safe :)
> > > 
> > > Do you have some hint? :)
> > > Thanks in advance.
> > > 
> > > Maybe I haven't catch completely your comments.
> > 
> > In this specific case, the right pattern is either
> > 
> > 	u64 val;
> > 	int ret;
> > 
> > 	ret = alvium_read(alvium, REG_BCRM_CSI2_LANE_COUNT_RW, &val, NULL);
> > 	if (ret)
> > 		return ret;
> > 
> > 	alvium->h_sup_csi_lanes = val;
> > 
> > 	return 0;
> > 
> > or
> > 
> > 	u64 val;
> > 	int ret = 0;
> > 
> > 	alvium_read(alvium, REG_BCRM_CSI2_LANE_COUNT_RW, &val, &ret);
> > 	if (ret)
> > 		return ret;
> > 
> > 	alvium->h_sup_csi_lanes = val;
> > 
> > 	return 0;
> > 
> > I personally prefer the former.
> 
> Now it's clear to me.
> Thanks, Let's follow this way then :)
> 
> > If the function was *writing* multiple registers, the right pattern
> > would be
> > 
> > 	int ret = 0;
> > 
> > 	alvium_write(alvium, REG_BCRM_REG_1, foo, &ret);
> > 	alvium_write(alvium, REG_BCRM_REG_2, bar, &ret);
> > 	alvium_write(alvium, REG_BCRM_REG_3, baz, &ret);
> > 
> > 	if (ret)
> > 		return ret;
> > 
> > 	...
> > 
> > 	return 0;
> > 
> > If you have to read multiple registers, you can also do
> > 
> > 	u64 mul, div;
> > 	int ret = 0;
> > 
> > 	alvium_read(alvium, REG_BCRM_MULTIPLER, &mul, &ret);
> > 	alvium_read(alvium, REG_BCRM_DIVIDER, &div, &ret);
> > 
> > 	if (ret)
> > 		return ret;
> > 
> > 	alvium->value = mul / div;
> > 
> > 	return 0;
> 
> I'm going for example to switch to:
> 
> static int alvium_get_offy_params(struct alvium_dev *alvium)
> {
> 	u64 offy_min, offy_max, offy_inc;
> 	int ret = 0;
> 
> 	alvium_read_check(alvium, REG_BCRM_IMG_OFFSET_Y_MIN_R, &offy_min, &ret);
> 	alvium_read_check(alvium, REG_BCRM_IMG_OFFSET_Y_MAX_R, &offy_max, &ret);
> 	alvium_read_check(alvium, REG_BCRM_IMG_OFFSET_Y_INC_R, &offy_inc, &ret);
> 	if (ret)
> 		return ret;
> 
> 	alvium->min_offy = offy_min;
> 	alvium->max_offy = offy_max;
> 	alvium->inc_offy = offy_inc;
> 
> 	return 0;
> }
> 
> What do you think about?
> Same for similar pattern.

Looks fine to me.

> > I hope this is clearer.
> 
> Many thanks.
> 
> > > > > > > +	alvium->h_sup_csi_lanes = val;
> > > > > > > +
> > > > > > > +	return ret;
> > > > > > > +}
> > > > 
> > > > [snip]

-- 
Regards,

Laurent Pinchart
