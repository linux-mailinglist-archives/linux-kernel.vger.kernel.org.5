Return-Path: <linux-kernel+bounces-123386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 181B48907C6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF2A1C2BA3B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AD6130AD8;
	Thu, 28 Mar 2024 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="iLeD3wxB"
Received: from mail-108-mta98.mxroute.com (mail-108-mta98.mxroute.com [136.175.108.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2253F2C6B1
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711648538; cv=none; b=LnOPTD6IYTUTr5Dc/tF3BPQlfnZfC/sQ6Q6r/39At/P7UmikUjzGg3UAX3EPjXC13nBLZ6tndChPl/rozjrOHhMVn+Zay8Z2lWmtV97nM/0nJqsJ+J94IW/qRdc98IJM4g9LGsWvfdlixCSyFst3tlSxK9kPO4Qrd46u7MSOqac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711648538; c=relaxed/simple;
	bh=9JQrfxIFYw4wMMtwKrIRRSIUWt1KQ+q0fSgnUWKDvGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GVhnb5hY6RV84Xqb/lhDylfll0m108/TiIuy5bCX3ZIv5GwiBp9rQo9xZ+MIDjiVePVn7c18n+J2qb8puliOWB2nLoAHQoqFwAUCClH0674fbxoWq2qSdTI4hYICkyo0l0MfoLlOCE5DaHJy8EDz8LbuvZstfdFckQ8Fsyl0fxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=iLeD3wxB; arc=none smtp.client-ip=136.175.108.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta98.mxroute.com (ZoneMTA) with ESMTPSA id 18e8633df680003bea.00f
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Thu, 28 Mar 2024 17:55:30 +0000
X-Zone-Loop: 3f0502bbc65327321c754dd6a8c806686e3623d4ec5f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TooUpKNmahOQVfIystDvjov+ubya1DEVDHbSgKDdBdY=; b=iLeD3wxB3DGXbIVeCmPmtFdeRO
	2suXeGLlEOBqOcSGSM92Brmb0N8QO7gB3KXVQyxRu679pRAzNoN7jMunuZq1UCdxrvEu2YEbsDuYQ
	arfBJctpQ8qeFe0BJfTGSFJxZToKZcxiO2b/LRtN/j/Zmq+dl2cj1bU/YoZzpNMLKykSYffYlWK/K
	78E3D62s42HquXQpe9QT645PT6WdBpCdtrE5et8vch9YubAlOS+gmOCIYiUgA3pzLZ7gk5rpass2/
	C0vjD1PkieP4dtddHo9kOdoGq/jyLhaiuoX467b54X8FQMWUI9nrbdgqVPW8/iFx0F4+rOgA7U7Si
	z8ujZmzg==;
Message-ID: <11f2e7d8-fd4c-4e14-81d8-cbc2cd2442fa@luigi311.com>
Date: Thu, 28 Mar 2024 11:55:24 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/23] media: i2c: imx258: Add support for 24MHz clock
Content-Language: en-US
To: Sakari Ailus <sakari.ailus@linux.intel.com>, git@luigi311.com
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
 jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240327231710.53188-1-git@luigi311.com>
 <20240327231710.53188-9-git@luigi311.com>
 <ZgUlzCfUN-PnF8Yy@kekkonen.localdomain>
From: Luigi311 <personal@luigi311.com>
In-Reply-To: <ZgUlzCfUN-PnF8Yy@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: personal@luigi311.com

On 3/28/24 02:09, Sakari Ailus wrote:
> Hi Luigi311,
> 
> Thank you for the patchset.
> 
> On Wed, Mar 27, 2024 at 05:16:54PM -0600, git@luigi311.com wrote:
>> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
>>
>> There's no reason why only a clock of 19.2MHz is supported.
>> Indeed this isn't even a frequency listed in the datasheet.
>>
>> Add support for 24MHz as well.
>> The PLL settings result in slightly different link frequencies,
>> so parameterise those.
>>
>> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
>> Signed-off-by: Luigi311 <git@luigi311.com>
> 
> Is Luigi311 your real name? As per
> Documentation/process/submitting-patches.rst, anonymous (or pseudonym I'd
> say as well) contributions are not an option.

Luigi311 is not my real name but it would be a lot easier to find me if
it was. My real name is Luis Garcia which is a super common name so its
actually way easier to find me and all my work using my online name of
Luigi311. I can go ahead and swap over to Luis Garcia if required but a
name like that would provide no value in contacting/finding me since I'm
not famous like all the other Luis Garcia's that appear on google.

> 
>> ---
>>  drivers/media/i2c/imx258.c | 133 +++++++++++++++++++++++++++++--------
>>  1 file changed, 107 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
>> index 351add1bc5d5..6ee7de079454 100644
>> --- a/drivers/media/i2c/imx258.c
>> +++ b/drivers/media/i2c/imx258.c
>> @@ -76,9 +76,6 @@
>>  #define REG_CONFIG_MIRROR_FLIP		0x03
>>  #define REG_CONFIG_FLIP_TEST_PATTERN	0x02
>>  
>> -/* Input clock frequency in Hz */
>> -#define IMX258_INPUT_CLOCK_FREQ		19200000
>> -
>>  struct imx258_reg {
>>  	u16 address;
>>  	u8 val;
>> @@ -115,7 +112,9 @@ struct imx258_mode {
>>  };
>>  
>>  /* 4208x3120 needs 1267Mbps/lane, 4 lanes */
>> -static const struct imx258_reg mipi_data_rate_1267mbps[] = {
>> +static const struct imx258_reg mipi_1267mbps_19_2mhz[] = {
>> +	{ 0x0136, 0x13 },
>> +	{ 0x0137, 0x33 },
>>  	{ 0x0301, 0x05 },
>>  	{ 0x0303, 0x02 },
>>  	{ 0x0305, 0x03 },
>> @@ -133,7 +132,29 @@ static const struct imx258_reg mipi_data_rate_1267mbps[] = {
>>  	{ 0x0823, 0xCC },
>>  };
>>  
>> -static const struct imx258_reg mipi_data_rate_640mbps[] = {
>> +static const struct imx258_reg mipi_1272mbps_24mhz[] = {
>> +	{ 0x0136, 0x18 },
>> +	{ 0x0137, 0x00 },
>> +	{ 0x0301, 0x05 },
>> +	{ 0x0303, 0x02 },
>> +	{ 0x0305, 0x04 },
>> +	{ 0x0306, 0x00 },
>> +	{ 0x0307, 0xD4 },
>> +	{ 0x0309, 0x0A },
>> +	{ 0x030B, 0x01 },
>> +	{ 0x030D, 0x02 },
>> +	{ 0x030E, 0x00 },
>> +	{ 0x030F, 0xD8 },
>> +	{ 0x0310, 0x00 },
>> +	{ 0x0820, 0x13 },
>> +	{ 0x0821, 0x4C },
>> +	{ 0x0822, 0xCC },
>> +	{ 0x0823, 0xCC },
>> +};
>> +
>> +static const struct imx258_reg mipi_640mbps_19_2mhz[] = {
>> +	{ 0x0136, 0x13 },
>> +	{ 0x0137, 0x33 },
>>  	{ 0x0301, 0x05 },
>>  	{ 0x0303, 0x02 },
>>  	{ 0x0305, 0x03 },
>> @@ -151,9 +172,27 @@ static const struct imx258_reg mipi_data_rate_640mbps[] = {
>>  	{ 0x0823, 0x00 },
>>  };
>>  
>> +static const struct imx258_reg mipi_642mbps_24mhz[] = {
>> +	{ 0x0136, 0x18 },
>> +	{ 0x0137, 0x00 },
>> +	{ 0x0301, 0x05 },
>> +	{ 0x0303, 0x02 },
>> +	{ 0x0305, 0x04 },
>> +	{ 0x0306, 0x00 },
>> +	{ 0x0307, 0x6B },
>> +	{ 0x0309, 0x0A },
>> +	{ 0x030B, 0x01 },
>> +	{ 0x030D, 0x02 },
>> +	{ 0x030E, 0x00 },
>> +	{ 0x030F, 0xD8 },
>> +	{ 0x0310, 0x00 },
>> +	{ 0x0820, 0x0A },
>> +	{ 0x0821, 0x00 },
>> +	{ 0x0822, 0x00 },
>> +	{ 0x0823, 0x00 },
>> +};
>> +
>>  static const struct imx258_reg mode_common_regs[] = {
>> -	{ 0x0136, 0x13 },
>> -	{ 0x0137, 0x33 },
>>  	{ 0x3051, 0x00 },
>>  	{ 0x3052, 0x00 },
>>  	{ 0x4E21, 0x14 },
>> @@ -313,10 +352,6 @@ static const char * const imx258_supply_name[] = {
>>  
>>  #define IMX258_NUM_SUPPLIES ARRAY_SIZE(imx258_supply_name)
>>  
>> -/* Configurations for supported link frequencies */
>> -#define IMX258_LINK_FREQ_634MHZ	633600000ULL
>> -#define IMX258_LINK_FREQ_320MHZ	320000000ULL
>> -
>>  enum {
>>  	IMX258_LINK_FREQ_1267MBPS,
>>  	IMX258_LINK_FREQ_640MBPS,
>> @@ -335,25 +370,55 @@ static u64 link_freq_to_pixel_rate(u64 f)
>>  }
>>  
>>  /* Menu items for LINK_FREQ V4L2 control */
>> -static const s64 link_freq_menu_items[] = {
>> +/* Configurations for supported link frequencies */
>> +#define IMX258_LINK_FREQ_634MHZ	633600000ULL
>> +#define IMX258_LINK_FREQ_320MHZ	320000000ULL
>> +
>> +static const s64 link_freq_menu_items_19_2[] = {
>>  	IMX258_LINK_FREQ_634MHZ,
>>  	IMX258_LINK_FREQ_320MHZ,
>>  };
>>  
>> +/* Configurations for supported link frequencies */
>> +#define IMX258_LINK_FREQ_636MHZ	636000000ULL
>> +#define IMX258_LINK_FREQ_321MHZ	321000000ULL
> 
> These values aren't used outside the array below and the macro names are
> imprecise anyway. Could you put the numerical values to the array instead?

Ok I've removed the defines and just threw the values into the array instead.

> 
>> +
>> +static const s64 link_freq_menu_items_24[] = {
>> +	IMX258_LINK_FREQ_636MHZ,
>> +	IMX258_LINK_FREQ_321MHZ,
>> +};
>> +
>>  /* Link frequency configs */
>> -static const struct imx258_link_freq_config link_freq_configs[] = {
>> +static const struct imx258_link_freq_config link_freq_configs_19_2[] = {
>>  	[IMX258_LINK_FREQ_1267MBPS] = {
>>  		.pixels_per_line = IMX258_PPL_DEFAULT,
>>  		.reg_list = {
>> -			.num_of_regs = ARRAY_SIZE(mipi_data_rate_1267mbps),
>> -			.regs = mipi_data_rate_1267mbps,
>> +			.num_of_regs = ARRAY_SIZE(mipi_1267mbps_19_2mhz),
>> +			.regs = mipi_1267mbps_19_2mhz,
>>  		}
>>  	},
>>  	[IMX258_LINK_FREQ_640MBPS] = {
>>  		.pixels_per_line = IMX258_PPL_DEFAULT,
>>  		.reg_list = {
>> -			.num_of_regs = ARRAY_SIZE(mipi_data_rate_640mbps),
>> -			.regs = mipi_data_rate_640mbps,
>> +			.num_of_regs = ARRAY_SIZE(mipi_640mbps_19_2mhz),
>> +			.regs = mipi_640mbps_19_2mhz,
>> +		}
>> +	},
>> +};
>> +
>> +static const struct imx258_link_freq_config link_freq_configs_24[] = {
>> +	[IMX258_LINK_FREQ_1267MBPS] = {
>> +		.pixels_per_line = IMX258_PPL_DEFAULT,
>> +		.reg_list = {
>> +			.num_of_regs = ARRAY_SIZE(mipi_1272mbps_24mhz),
>> +			.regs = mipi_1272mbps_24mhz,
>> +		}
>> +	},
>> +	[IMX258_LINK_FREQ_640MBPS] = {
>> +		.pixels_per_line = IMX258_PPL_DEFAULT,
>> +		.reg_list = {
>> +			.num_of_regs = ARRAY_SIZE(mipi_642mbps_24mhz),
>> +			.regs = mipi_642mbps_24mhz,
>>  		}
>>  	},
>>  };
>> @@ -410,6 +475,9 @@ struct imx258 {
>>  	/* Current mode */
>>  	const struct imx258_mode *cur_mode;
>>  
>> +	const struct imx258_link_freq_config *link_freq_configs;
>> +	const s64 *link_freq_menu_items;
>> +
>>  	/*
>>  	 * Mutex for serialized access:
>>  	 * Protect sensor module set pad format and start/stop streaming safely.
>> @@ -713,7 +781,7 @@ static int imx258_set_pad_format(struct v4l2_subdev *sd,
>>  		imx258->cur_mode = mode;
>>  		__v4l2_ctrl_s_ctrl(imx258->link_freq, mode->link_freq_index);
>>  
>> -		link_freq = link_freq_menu_items[mode->link_freq_index];
>> +		link_freq = imx258->link_freq_menu_items[mode->link_freq_index];
>>  		pixel_rate = link_freq_to_pixel_rate(link_freq);
>>  		__v4l2_ctrl_s_ctrl_int64(imx258->pixel_rate, pixel_rate);
>>  		/* Update limits and set FPS to default */
>> @@ -727,7 +795,7 @@ static int imx258_set_pad_format(struct v4l2_subdev *sd,
>>  			vblank_def);
>>  		__v4l2_ctrl_s_ctrl(imx258->vblank, vblank_def);
>>  		h_blank =
>> -			link_freq_configs[mode->link_freq_index].pixels_per_line
>> +			imx258->link_freq_configs[mode->link_freq_index].pixels_per_line
>>  			 - imx258->cur_mode->width;
>>  		__v4l2_ctrl_modify_range(imx258->hblank, h_blank,
>>  					 h_blank, 1, h_blank);
>> @@ -747,7 +815,7 @@ static int imx258_start_streaming(struct imx258 *imx258)
>>  
>>  	/* Setup PLL */
>>  	link_freq_index = imx258->cur_mode->link_freq_index;
>> -	reg_list = &link_freq_configs[link_freq_index].reg_list;
>> +	reg_list = &imx258->link_freq_configs[link_freq_index].reg_list;
>>  	ret = imx258_write_regs(imx258, reg_list->regs, reg_list->num_of_regs);
>>  	if (ret) {
>>  		dev_err(&client->dev, "%s failed to set plls\n", __func__);
>> @@ -946,9 +1014,9 @@ static int imx258_init_controls(struct imx258 *imx258)
>>  	imx258->link_freq = v4l2_ctrl_new_int_menu(ctrl_hdlr,
>>  				&imx258_ctrl_ops,
>>  				V4L2_CID_LINK_FREQ,
>> -				ARRAY_SIZE(link_freq_menu_items) - 1,
>> +				ARRAY_SIZE(link_freq_menu_items_19_2) - 1,
>>  				0,
>> -				link_freq_menu_items);
>> +				imx258->link_freq_menu_items);
>>  
>>  	if (imx258->link_freq)
>>  		imx258->link_freq->flags |= V4L2_CTRL_FLAG_READ_ONLY;
>> @@ -964,8 +1032,10 @@ static int imx258_init_controls(struct imx258 *imx258)
>>  	if (vflip)
>>  		vflip->flags |= V4L2_CTRL_FLAG_READ_ONLY;
>>  
>> -	pixel_rate_max = link_freq_to_pixel_rate(link_freq_menu_items[0]);
>> -	pixel_rate_min = link_freq_to_pixel_rate(link_freq_menu_items[1]);
>> +	pixel_rate_max =
>> +		link_freq_to_pixel_rate(imx258->link_freq_menu_items[0]);
>> +	pixel_rate_min =
>> +		link_freq_to_pixel_rate(imx258->link_freq_menu_items[1]);
> 
> The arrays currently have two entries so this works but it'd nice to have a
> bit more robust way to handle differences between the two arrays. Could you
> maintain e.g. the number of entries in the array in a struct field perhaps?

Would it make more sense to do something like default to index 0 and then use 
ARRAY_SIZE to iterate through the array and do a comparison to get the min and
max size so it would always choose the correct value no matter how many entries
there are?

> 
>>  	/* By default, PIXEL_RATE is read only */
>>  	imx258->pixel_rate = v4l2_ctrl_new_std(ctrl_hdlr, &imx258_ctrl_ops,
>>  				V4L2_CID_PIXEL_RATE,
>> @@ -1086,8 +1156,19 @@ static int imx258_probe(struct i2c_client *client)
>>  	} else {
>>  		val = clk_get_rate(imx258->clk);
>>  	}
>> -	if (val != IMX258_INPUT_CLOCK_FREQ) {
>> -		dev_err(&client->dev, "input clock frequency not supported\n");
>> +
>> +	switch (val) {
>> +	case 19200000:
>> +		imx258->link_freq_configs = link_freq_configs_19_2;
>> +		imx258->link_freq_menu_items = link_freq_menu_items_19_2;
>> +		break;
>> +	case 24000000:
>> +		imx258->link_freq_configs = link_freq_configs_24;
>> +		imx258->link_freq_menu_items = link_freq_menu_items_24;
>> +		break;
>> +	default:
>> +		dev_err(&client->dev, "input clock frequency of %u not supported\n",
>> +			val);
>>  		return -EINVAL;
>>  	}
>>  
> 


