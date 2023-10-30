Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5912F7DC296
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 23:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjJ3Wn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 18:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjJ3Wn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 18:43:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA82CDD;
        Mon, 30 Oct 2023 15:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698705834; x=1730241834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XG7coGZzFRldwW+IF/F2D/I9/JstEOKy7alKE54kPdM=;
  b=aMwzcDo13qoZNli8wrOk9YFOvrFWlOBR66zaBGBedSxYgEnXAxgMW3Js
   Zymd/qn+yuaBXPtX6p2v3xrOpZtWDiKfbHRPbm5ipbU8Yl+/LLg1pXIvw
   1war8qtdDd1fWzY8ZOaiRfpcl9OZKjiYxd9V3wO215hCeZbJAucL72E9H
   dMvXp+L/7n7swKq8O7v4BLlIyGO7VSt94OrpoxgvlwN/b4ZjHbCzQJDP3
   eXE2JUYCuObsiM5gtblPVrHRuVwiEW3NWKKiD13siXozjlfnaxhAm64Kd
   5OB8XnO/yxvO2nh6I3/3l1wAZ684WOU1aesZT8bSKQAOrZPMh/zzymEO8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="367521512"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="367521512"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 15:43:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="764058297"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="764058297"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 15:43:49 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 3A8F711F894;
        Tue, 31 Oct 2023 00:43:47 +0200 (EET)
Date:   Mon, 30 Oct 2023 22:43:47 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     martin.hecht@avnet.eu, michael.roeder@avnet.eu, mhecht73@gmail.com,
        linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
Message-ID: <ZUAxoy2cRR6Rm9ig@kekkonen.localdomain>
References: <20231020141354.2500602-1-tomm.merciai@gmail.com>
 <20231020141354.2500602-4-tomm.merciai@gmail.com>
 <ZTpnHdpTgRNll3TC@kekkonen.localdomain>
 <ZT+hEg7WqkQBnLV5@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZT+hEg7WqkQBnLV5@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

On Mon, Oct 30, 2023 at 01:26:58PM +0100, Tommaso Merciai wrote:

...

> > > +static int alvium_get_host_supp_csi_lanes(struct alvium_dev *alvium)
> > > +{
> > > +	u64 val;
> > > +	int ret = 0;
> > > +
> > > +	alvium_read(alvium, REG_BCRM_CSI2_LANE_COUNT_RW, &val, &ret);
> > 
> > Missing error checking before the use of the value. The same pattern
> > remains prevalent throughout the driver.
> > 
> > I think it'd be easier if you didn't use a temporary variable for reading,
> > but instead had a register width specific access function. You could even
> > introduce a helper macro to read this information as I suggested in an
> > earlier review.
> 
> oks.
> We are moving to use the following macros:
> 
> #define alvium_read_check(alvium, reg, value) \
> { \
> 	int ret = alvium_read(alvium, reg, value, NULL); \
> 	if (ret) \
> 		return ret; \
> }
> 

You could do something like (entirely untested):

#define ALVIUM_DECLARE_READ(sign, bits) \
	static int
	alvium_read_ ## sign ## bits(struct alvium_dev *alvium, u32 reg, \
				     sign ## bits *val, int *err) \
	{ \
		u64 val64; \
		int ret; \
			\
		if (err && *err < 0) \
			return *err; \
			\
		alvium_read(alvium, reg, &val64, &ret); \
		if (ret < 0) { \
			if (err) \
				*err = ret; \
			return ret; \
		}	\
			\
		*val = val64; \
			\
		return 0; \
	}

ALVIUM_DECLARE_READ(u, 32);

And then, e.g. instead of (and failing to check ret):

	u64 val;

	alvium_read(alvium, REG_BCRM_CONTRAST_VALUE_RW, &val, &ret);
	alvium->dft_contrast = val;

you'd have a single call:

	alvium_read_u32(alvium, REG_BCRM_CONTRAST_VALUE_RW,
		        &alvium->dft_contrast, &ret);

And so on.

You can drop sign if you don't need signed reads but some of the struct
fields you're writing something appear to be signed.

It'd be good to check the register size matches with the size of *val, too.
Maybe something like:

WARN_ON((CCI_REG ## bits(0) && CCI_REG_WIDTH_MASK) >> CCI_REG_WIDTH_SHIFT
	!= sizeof(sign ## bits));

> > > +static int alvium_get_csi_clk_params(struct alvium_dev *alvium)
> > > +{
> > > +	u64 val;
> > > +	int ret = 0;
> > > +
> > > +	alvium_read(alvium, REG_BCRM_CSI2_CLOCK_MIN_R, &val, &ret);
> > > +	alvium->min_csi_clk = val;
> > > +
> > > +	alvium_read(alvium, REG_BCRM_CSI2_CLOCK_MAX_R, &val, &ret);
> > > +	alvium->max_csi_clk = val;
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int alvium_set_csi_clk(struct alvium_dev *alvium)
> > > +{
> > > +	struct device *dev = &alvium->i2c_client->dev;
> > > +	u64 csi_clk;
> > > +	int ret;
> > > +
> > > +	csi_clk = (u32)alvium->ep.link_frequencies[0];
> > 
> > Why casting to u32? Shouldn't csi_clk be u32 instead?
> 
> Ok we fix this in v11.
> Change to use u64 for calculation because type of ep.link_frequencies[0]
> Plan is to clamp csi_clk between min/max instead of returning error.

I think I would keep it as-is: this isn't V4L2 UAPI.

> 
> > 
> > > +
> > > +	if (csi_clk < alvium->min_csi_clk || csi_clk > alvium->max_csi_clk)
> > > +		return -EINVAL;
> > > +
> > > +	ret = alvium_write_hshake(alvium, REG_BCRM_CSI2_CLOCK_RW, csi_clk);
> > > +	if (ret) {
> > > +		dev_err(dev, "Fail to set csi lanes reg\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	alvium->link_freq = alvium->ep.link_frequencies[0];
> > > +
> > > +	return 0;
> > > +}

...

> > > +			goto out;
> > > +
> > > +		ret = alvium_set_mode(alvium, state);
> > > +		if (ret)
> > > +			goto out;
> > > +
> > > +		fmt = v4l2_subdev_get_pad_format(sd, state, 0);
> > > +		ret = alvium_set_framefmt(alvium, fmt);
> > > +		if (ret)
> > > +			goto out;
> > > +
> > > +		ret = alvium_set_stream_mipi(alvium, enable);
> > > +		if (ret)
> > > +			goto out;
> > > +
> > > +	} else {
> > > +		alvium_set_stream_mipi(alvium, enable);
> > > +		pm_runtime_mark_last_busy(&client->dev);
> > > +		pm_runtime_put_autosuspend(&client->dev);
> > 
> > pm_runtime_put() here, too.
> 
> Here is not needed we already have pm_runtime_put_autosuspend.
> I'm missing something?

Ah, I missed that while reviewing. Please ignore that comment then.

> 
> > 
> > > +	}
> > > +
> > > +	alvium->streaming = !!enable;
> > > +	v4l2_subdev_unlock_state(state);
> > > +
> > > +	return 0;
> > > +
> > > +out:
> > > +	v4l2_subdev_unlock_state(state);
> > > +	return ret;
> > > +}
> > > +
> > > +static int alvium_init_cfg(struct v4l2_subdev *sd,
> > > +			   struct v4l2_subdev_state *state)
> > > +{
> > > +	struct alvium_dev *alvium = sd_to_alvium(sd);
> > > +	struct alvium_mode *mode = &alvium->mode;
> > 
> > Init_cfg() is expected to be configuration independent (as much as
> > possible). Therefore you should use defaults here, not current mode.
> 
> Defaults alvium mode already used here.

Ah, indeed. Please ignore.

-- 
Kind regards,

Sakari Ailus
