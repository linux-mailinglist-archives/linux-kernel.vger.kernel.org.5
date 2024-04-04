Return-Path: <linux-kernel+bounces-131074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D39E88982C2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4389C1F21B4B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489705FBBA;
	Thu,  4 Apr 2024 08:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZyAJOz6W"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189545D73A;
	Thu,  4 Apr 2024 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217848; cv=none; b=LGEOFVnXfcLTpYdy8Nd/kjmXkLcLzElXeh3NXmKUpv+S6+mtVn6z0/cNgZ9lJ1wcJSqjMlA38m3O5XdRnVOvPRrkelfWhea75Aetyb9IG2Mh5sT0nX5NO+VPvXkUz55xF5fn3ic4+0khFifhAAWT2/7/nXEaiRS3HgnRkpQrrXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217848; c=relaxed/simple;
	bh=jOkqW2E7hIrpQcS2etNxADrH9Qc++Sk6dDKBF1O+XXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6NROvwEMug5ReUz2C4dE5/60Y4NOjLMwxTAYCDC9vE5+QnMr46E4llAacs1PLjQHVgIy+IiM1O6PHW7HkZzq/yapNSX/usPP3kL+qGseLN9BbCI4IiVq+Yo7npSK0V619vRi2/NSNqD7BTn1nP3/E1lBtl3bkdIxbNVXBaOBEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZyAJOz6W; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712217846; x=1743753846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jOkqW2E7hIrpQcS2etNxADrH9Qc++Sk6dDKBF1O+XXw=;
  b=ZyAJOz6W7kOMGMl/pC7h6yNcx/z0Enhl80Dvwyfvh2oZz160+pSyxSNr
   vSAPhwgl337LtKzL/nnZHfjCXyM84dghFdAfngn52AxpAuoxyMXXp4zgT
   tO1Xf+A1hO0zgUGK5FQMHGvQmkfBWckRfAnJyo7l8xFcf6XqpNnr7HLuK
   vZwuNULFUZSyUWcQhp6gS3ilY+8U3EUuvNV7J82mW5bo9i1+GRjjrUeGS
   UULgw+pJySFokpIYhXK5DN462THJxoMOfX+HBrrnpwTYrXjR33FzZbpbD
   A7d+M/rdDqamSoOKzCLt19Kb0+3N77Z7uAvuhpp/pOj1NVtknrhfGG2YX
   A==;
X-CSE-ConnectionGUID: Esmn/59FTX6M2kis8ztoRA==
X-CSE-MsgGUID: tiVBZby8QNOTll1AGSPzRg==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="8063233"
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="8063233"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 01:04:05 -0700
X-CSE-ConnectionGUID: HhBK4V/wTBG1ubej6USvBg==
X-CSE-MsgGUID: ZtpcSPjFQjq6uyK9CGSKXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,178,1708416000"; 
   d="scan'208";a="56154819"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 01:04:02 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 9091111F82F;
	Thu,  4 Apr 2024 11:03:58 +0300 (EEST)
Date: Thu, 4 Apr 2024 08:03:58 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Luigi311 <personal@luigi311.com>
Cc: git@luigi311.com, linux-media@vger.kernel.org,
	dave.stevenson@raspberrypi.com, jacopo.mondi@ideasonboard.com,
	mchehab@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/23] media: i2c: imx258: Add support for 24MHz clock
Message-ID: <Zg5e7teCn2LDfUZt@kekkonen.localdomain>
References: <20240327231710.53188-1-git@luigi311.com>
 <20240327231710.53188-9-git@luigi311.com>
 <ZgUlzCfUN-PnF8Yy@kekkonen.localdomain>
 <11f2e7d8-fd4c-4e14-81d8-cbc2cd2442fa@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11f2e7d8-fd4c-4e14-81d8-cbc2cd2442fa@luigi311.com>

Hi Luigi311,

On Thu, Mar 28, 2024 at 11:55:24AM -0600, Luigi311 wrote:
> On 3/28/24 02:09, Sakari Ailus wrote:
> > Hi Luigi311,
> > 
> > Thank you for the patchset.
> > 
> > On Wed, Mar 27, 2024 at 05:16:54PM -0600, git@luigi311.com wrote:
> >> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> >>
> >> There's no reason why only a clock of 19.2MHz is supported.
> >> Indeed this isn't even a frequency listed in the datasheet.
> >>
> >> Add support for 24MHz as well.
> >> The PLL settings result in slightly different link frequencies,
> >> so parameterise those.
> >>
> >> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> >> Signed-off-by: Luigi311 <git@luigi311.com>
> > 
> > Is Luigi311 your real name? As per
> > Documentation/process/submitting-patches.rst, anonymous (or pseudonym I'd
> > say as well) contributions are not an option.
> 
> Luigi311 is not my real name but it would be a lot easier to find me if
> it was. My real name is Luis Garcia which is a super common name so its
> actually way easier to find me and all my work using my online name of
> Luigi311. I can go ahead and swap over to Luis Garcia if required but a
> name like that would provide no value in contacting/finding me since I'm
> not famous like all the other Luis Garcia's that appear on google.

Thanks. E-mail addresses are still unique, presumably, so that helps.

> 
> > 
> >> ---
> >>  drivers/media/i2c/imx258.c | 133 +++++++++++++++++++++++++++++--------
> >>  1 file changed, 107 insertions(+), 26 deletions(-)
> >>
> >> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
> >> index 351add1bc5d5..6ee7de079454 100644
> >> --- a/drivers/media/i2c/imx258.c
> >> +++ b/drivers/media/i2c/imx258.c
> >> @@ -76,9 +76,6 @@
> >>  #define REG_CONFIG_MIRROR_FLIP		0x03
> >>  #define REG_CONFIG_FLIP_TEST_PATTERN	0x02
> >>  
> >> -/* Input clock frequency in Hz */
> >> -#define IMX258_INPUT_CLOCK_FREQ		19200000
> >> -
> >>  struct imx258_reg {
> >>  	u16 address;
> >>  	u8 val;
> >> @@ -115,7 +112,9 @@ struct imx258_mode {
> >>  };
> >>  
> >>  /* 4208x3120 needs 1267Mbps/lane, 4 lanes */
> >> -static const struct imx258_reg mipi_data_rate_1267mbps[] = {
> >> +static const struct imx258_reg mipi_1267mbps_19_2mhz[] = {
> >> +	{ 0x0136, 0x13 },
> >> +	{ 0x0137, 0x33 },
> >>  	{ 0x0301, 0x05 },
> >>  	{ 0x0303, 0x02 },
> >>  	{ 0x0305, 0x03 },
> >> @@ -133,7 +132,29 @@ static const struct imx258_reg mipi_data_rate_1267mbps[] = {
> >>  	{ 0x0823, 0xCC },
> >>  };
> >>  
> >> -static const struct imx258_reg mipi_data_rate_640mbps[] = {
> >> +static const struct imx258_reg mipi_1272mbps_24mhz[] = {
> >> +	{ 0x0136, 0x18 },
> >> +	{ 0x0137, 0x00 },
> >> +	{ 0x0301, 0x05 },
> >> +	{ 0x0303, 0x02 },
> >> +	{ 0x0305, 0x04 },
> >> +	{ 0x0306, 0x00 },
> >> +	{ 0x0307, 0xD4 },
> >> +	{ 0x0309, 0x0A },
> >> +	{ 0x030B, 0x01 },
> >> +	{ 0x030D, 0x02 },
> >> +	{ 0x030E, 0x00 },
> >> +	{ 0x030F, 0xD8 },
> >> +	{ 0x0310, 0x00 },
> >> +	{ 0x0820, 0x13 },
> >> +	{ 0x0821, 0x4C },
> >> +	{ 0x0822, 0xCC },
> >> +	{ 0x0823, 0xCC },
> >> +};
> >> +
> >> +static const struct imx258_reg mipi_640mbps_19_2mhz[] = {
> >> +	{ 0x0136, 0x13 },
> >> +	{ 0x0137, 0x33 },
> >>  	{ 0x0301, 0x05 },
> >>  	{ 0x0303, 0x02 },
> >>  	{ 0x0305, 0x03 },
> >> @@ -151,9 +172,27 @@ static const struct imx258_reg mipi_data_rate_640mbps[] = {
> >>  	{ 0x0823, 0x00 },
> >>  };
> >>  
> >> +static const struct imx258_reg mipi_642mbps_24mhz[] = {
> >> +	{ 0x0136, 0x18 },
> >> +	{ 0x0137, 0x00 },
> >> +	{ 0x0301, 0x05 },
> >> +	{ 0x0303, 0x02 },
> >> +	{ 0x0305, 0x04 },
> >> +	{ 0x0306, 0x00 },
> >> +	{ 0x0307, 0x6B },
> >> +	{ 0x0309, 0x0A },
> >> +	{ 0x030B, 0x01 },
> >> +	{ 0x030D, 0x02 },
> >> +	{ 0x030E, 0x00 },
> >> +	{ 0x030F, 0xD8 },
> >> +	{ 0x0310, 0x00 },
> >> +	{ 0x0820, 0x0A },
> >> +	{ 0x0821, 0x00 },
> >> +	{ 0x0822, 0x00 },
> >> +	{ 0x0823, 0x00 },
> >> +};
> >> +
> >>  static const struct imx258_reg mode_common_regs[] = {
> >> -	{ 0x0136, 0x13 },
> >> -	{ 0x0137, 0x33 },
> >>  	{ 0x3051, 0x00 },
> >>  	{ 0x3052, 0x00 },
> >>  	{ 0x4E21, 0x14 },
> >> @@ -313,10 +352,6 @@ static const char * const imx258_supply_name[] = {
> >>  
> >>  #define IMX258_NUM_SUPPLIES ARRAY_SIZE(imx258_supply_name)
> >>  
> >> -/* Configurations for supported link frequencies */
> >> -#define IMX258_LINK_FREQ_634MHZ	633600000ULL
> >> -#define IMX258_LINK_FREQ_320MHZ	320000000ULL
> >> -
> >>  enum {
> >>  	IMX258_LINK_FREQ_1267MBPS,
> >>  	IMX258_LINK_FREQ_640MBPS,
> >> @@ -335,25 +370,55 @@ static u64 link_freq_to_pixel_rate(u64 f)
> >>  }
> >>  
> >>  /* Menu items for LINK_FREQ V4L2 control */
> >> -static const s64 link_freq_menu_items[] = {
> >> +/* Configurations for supported link frequencies */
> >> +#define IMX258_LINK_FREQ_634MHZ	633600000ULL
> >> +#define IMX258_LINK_FREQ_320MHZ	320000000ULL
> >> +
> >> +static const s64 link_freq_menu_items_19_2[] = {
> >>  	IMX258_LINK_FREQ_634MHZ,
> >>  	IMX258_LINK_FREQ_320MHZ,
> >>  };
> >>  
> >> +/* Configurations for supported link frequencies */
> >> +#define IMX258_LINK_FREQ_636MHZ	636000000ULL
> >> +#define IMX258_LINK_FREQ_321MHZ	321000000ULL
> > 
> > These values aren't used outside the array below and the macro names are
> > imprecise anyway. Could you put the numerical values to the array instead?
> 
> Ok I've removed the defines and just threw the values into the array instead.
> 
> > 
> >> +
> >> +static const s64 link_freq_menu_items_24[] = {
> >> +	IMX258_LINK_FREQ_636MHZ,
> >> +	IMX258_LINK_FREQ_321MHZ,
> >> +};
> >> +
> >>  /* Link frequency configs */
> >> -static const struct imx258_link_freq_config link_freq_configs[] = {
> >> +static const struct imx258_link_freq_config link_freq_configs_19_2[] = {
> >>  	[IMX258_LINK_FREQ_1267MBPS] = {
> >>  		.pixels_per_line = IMX258_PPL_DEFAULT,
> >>  		.reg_list = {
> >> -			.num_of_regs = ARRAY_SIZE(mipi_data_rate_1267mbps),
> >> -			.regs = mipi_data_rate_1267mbps,
> >> +			.num_of_regs = ARRAY_SIZE(mipi_1267mbps_19_2mhz),
> >> +			.regs = mipi_1267mbps_19_2mhz,
> >>  		}
> >>  	},
> >>  	[IMX258_LINK_FREQ_640MBPS] = {
> >>  		.pixels_per_line = IMX258_PPL_DEFAULT,
> >>  		.reg_list = {
> >> -			.num_of_regs = ARRAY_SIZE(mipi_data_rate_640mbps),
> >> -			.regs = mipi_data_rate_640mbps,
> >> +			.num_of_regs = ARRAY_SIZE(mipi_640mbps_19_2mhz),
> >> +			.regs = mipi_640mbps_19_2mhz,
> >> +		}
> >> +	},
> >> +};
> >> +
> >> +static const struct imx258_link_freq_config link_freq_configs_24[] = {
> >> +	[IMX258_LINK_FREQ_1267MBPS] = {
> >> +		.pixels_per_line = IMX258_PPL_DEFAULT,
> >> +		.reg_list = {
> >> +			.num_of_regs = ARRAY_SIZE(mipi_1272mbps_24mhz),
> >> +			.regs = mipi_1272mbps_24mhz,
> >> +		}
> >> +	},
> >> +	[IMX258_LINK_FREQ_640MBPS] = {
> >> +		.pixels_per_line = IMX258_PPL_DEFAULT,
> >> +		.reg_list = {
> >> +			.num_of_regs = ARRAY_SIZE(mipi_642mbps_24mhz),
> >> +			.regs = mipi_642mbps_24mhz,
> >>  		}
> >>  	},
> >>  };
> >> @@ -410,6 +475,9 @@ struct imx258 {
> >>  	/* Current mode */
> >>  	const struct imx258_mode *cur_mode;
> >>  
> >> +	const struct imx258_link_freq_config *link_freq_configs;
> >> +	const s64 *link_freq_menu_items;
> >> +
> >>  	/*
> >>  	 * Mutex for serialized access:
> >>  	 * Protect sensor module set pad format and start/stop streaming safely.
> >> @@ -713,7 +781,7 @@ static int imx258_set_pad_format(struct v4l2_subdev *sd,
> >>  		imx258->cur_mode = mode;
> >>  		__v4l2_ctrl_s_ctrl(imx258->link_freq, mode->link_freq_index);
> >>  
> >> -		link_freq = link_freq_menu_items[mode->link_freq_index];
> >> +		link_freq = imx258->link_freq_menu_items[mode->link_freq_index];
> >>  		pixel_rate = link_freq_to_pixel_rate(link_freq);
> >>  		__v4l2_ctrl_s_ctrl_int64(imx258->pixel_rate, pixel_rate);
> >>  		/* Update limits and set FPS to default */
> >> @@ -727,7 +795,7 @@ static int imx258_set_pad_format(struct v4l2_subdev *sd,
> >>  			vblank_def);
> >>  		__v4l2_ctrl_s_ctrl(imx258->vblank, vblank_def);
> >>  		h_blank =
> >> -			link_freq_configs[mode->link_freq_index].pixels_per_line
> >> +			imx258->link_freq_configs[mode->link_freq_index].pixels_per_line
> >>  			 - imx258->cur_mode->width;
> >>  		__v4l2_ctrl_modify_range(imx258->hblank, h_blank,
> >>  					 h_blank, 1, h_blank);
> >> @@ -747,7 +815,7 @@ static int imx258_start_streaming(struct imx258 *imx258)
> >>  
> >>  	/* Setup PLL */
> >>  	link_freq_index = imx258->cur_mode->link_freq_index;
> >> -	reg_list = &link_freq_configs[link_freq_index].reg_list;
> >> +	reg_list = &imx258->link_freq_configs[link_freq_index].reg_list;
> >>  	ret = imx258_write_regs(imx258, reg_list->regs, reg_list->num_of_regs);
> >>  	if (ret) {
> >>  		dev_err(&client->dev, "%s failed to set plls\n", __func__);
> >> @@ -946,9 +1014,9 @@ static int imx258_init_controls(struct imx258 *imx258)
> >>  	imx258->link_freq = v4l2_ctrl_new_int_menu(ctrl_hdlr,
> >>  				&imx258_ctrl_ops,
> >>  				V4L2_CID_LINK_FREQ,
> >> -				ARRAY_SIZE(link_freq_menu_items) - 1,
> >> +				ARRAY_SIZE(link_freq_menu_items_19_2) - 1,
> >>  				0,
> >> -				link_freq_menu_items);
> >> +				imx258->link_freq_menu_items);
> >>  
> >>  	if (imx258->link_freq)
> >>  		imx258->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> >> @@ -964,8 +1032,10 @@ static int imx258_init_controls(struct imx258 *imx258)
> >>  	if (vflip)
> >>  		vflip->flags |= V4L2_CTRL_FLAG_READ_ONLY;
> >>  
> >> -	pixel_rate_max = link_freq_to_pixel_rate(link_freq_menu_items[0]);
> >> -	pixel_rate_min = link_freq_to_pixel_rate(link_freq_menu_items[1]);
> >> +	pixel_rate_max =
> >> +		link_freq_to_pixel_rate(imx258->link_freq_menu_items[0]);
> >> +	pixel_rate_min =
> >> +		link_freq_to_pixel_rate(imx258->link_freq_menu_items[1]);
> > 
> > The arrays currently have two entries so this works but it'd nice to have a
> > bit more robust way to handle differences between the two arrays. Could you
> > maintain e.g. the number of entries in the array in a struct field perhaps?
> 
> Would it make more sense to do something like default to index 0 and then use 
> ARRAY_SIZE to iterate through the array and do a comparison to get the min and
> max size so it would always choose the correct value no matter how many entries
> there are?

I'll check that later patch you mentioned in the follow-up separately.

-- 
Kind regards,

Sakari Ailus

