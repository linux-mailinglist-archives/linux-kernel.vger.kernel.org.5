Return-Path: <linux-kernel+bounces-19314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3447B826B49
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CFE31C21F74
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55596134C3;
	Mon,  8 Jan 2024 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QxSt1KPi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AF613ACF;
	Mon,  8 Jan 2024 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704708192; x=1736244192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t9ibrJFOVgyhcdPDuPa5NcrTMKPcC41hMEaQWW3U7Ic=;
  b=QxSt1KPiWi6C/xsc3LQzhsXvpRXSCLZ2NB8dWCOaaM8DfaUsqWfM2/rT
   yffJ17tKA2M46pj4EL+fdhx5NWQSmSJxFhC81CgrahOSjsJH5GWYdzcM3
   ucneqyEe/2CwFdcu7UE/Pm6iYoOlbsLvhSsD1rUaxRcgVn/d8vIEG/ZsV
   zjKiy/vk5fWK8TR3l5obaPXxfF83EIQINfpoz9MlybW98plJOKn+Ddo/z
   3oVkUrZG3EKPSUr8iJe1YtRdGyhwin+oogsitUkDGL1trIcLAKqW/EiLg
   BwHfcGg/saThJCu2ldgUCiIzV1CiAlgYAgJGZ9Qx7xiKcZ94PQDbbWLdy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="464239563"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="464239563"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 02:03:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="1028361723"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="1028361723"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 02:03:09 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id A664111F913;
	Mon,  8 Jan 2024 12:03:06 +0200 (EET)
Date: Mon, 8 Jan 2024 10:03:06 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org,
	"Paul J . Murphy" <paul.j.murphy@intel.com>,
	Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] media: i2c: imx335: Support multiple link frequency
Message-ID: <ZZvIWhqPkwe9E8wR@kekkonen.localdomain>
References: <20231213091712.55529-1-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213091712.55529-1-umang.jain@ideasonboard.com>

Hi Umang,

Thanks for the patch.

Note that Daniele and Paul are no longer maintaining the driver.

On Wed, Dec 13, 2023 at 02:47:12PM +0530, Umang Jain wrote:
> Support link frequency of 445MHz in addition to 594MHz.
> Break out the register set specific to each data lane rate and also add
> the general timing register set corresponding to the each data
> lane rate.
> 
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
> Changes in v3:
> - Use tabspace for indent as denoted by checkpatch.
> 
> Changes in v2:
> - Split out from [PATCH v3 0/8] media: Sony IMX335 improvements
>   where original patch was introduced.
> - Add general timing registers to each data lane rate configuration
> - Reword commit message. 
> ---
>  drivers/media/i2c/imx335.c | 108 +++++++++++++++++++++++++++++--------
>  1 file changed, 87 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
> index 7a37eb327ff4..ffceeb8a15c7 100644
> --- a/drivers/media/i2c/imx335.c
> +++ b/drivers/media/i2c/imx335.c
> @@ -49,7 +49,8 @@
>  #define IMX335_INCLK_RATE	24000000
>  
>  /* CSI2 HW configuration */
> -#define IMX335_LINK_FREQ	594000000
> +#define IMX335_LINK_FREQ_594MHz	594000000
> +#define IMX335_LINK_FREQ_445MHz	445500000
>  #define IMX335_NUM_DATA_LANES	4
>  
>  #define IMX335_REG_MIN		0x00
> @@ -99,7 +100,6 @@ static const char * const imx335_supply_name[] = {
>   * @vblank_min: Minimum vertical blanking in lines
>   * @vblank_max: Maximum vertical blanking in lines
>   * @pclk: Sensor pixel clock
> - * @link_freq_idx: Link frequency index
>   * @reg_list: Register list for sensor mode
>   */
>  struct imx335_mode {
> @@ -111,7 +111,6 @@ struct imx335_mode {
>  	u32 vblank_min;
>  	u32 vblank_max;
>  	u64 pclk;
> -	u32 link_freq_idx;
>  	struct imx335_reg_list reg_list;
>  };
>  
> @@ -133,6 +132,7 @@ struct imx335_mode {
>   * @again_ctrl: Pointer to analog gain control
>   * @vblank: Vertical blanking in lines
>   * @cur_mode: Pointer to current selected sensor mode
> + * @link_freq_idx: Selected link frequency index
>   * @mutex: Mutex for serializing sensor controls
>   * @cur_mbus_code: Currently selected media bus format code
>   */
> @@ -156,20 +156,16 @@ struct imx335 {
>  	};
>  	u32 vblank;
>  	const struct imx335_mode *cur_mode;
> +	u32 link_freq_idx;
>  	struct mutex mutex;
>  	u32 cur_mbus_code;
>  };
>  
> -static const s64 link_freq[] = {
> -	IMX335_LINK_FREQ,
> -};
>  
>  /* Sensor mode registers */
>  static const struct imx335_reg mode_2592x1940_regs[] = {
>  	{0x3000, 0x01},
>  	{0x3002, 0x00},
> -	{0x300c, 0x3b},
> -	{0x300d, 0x2a},
>  	{0x3018, 0x04},
>  	{0x302c, 0x3c},
>  	{0x302e, 0x20},
> @@ -177,10 +173,6 @@ static const struct imx335_reg mode_2592x1940_regs[] = {
>  	{0x3074, 0xc8},
>  	{0x3076, 0x28},
>  	{0x304c, 0x00},
> -	{0x314c, 0xc6},
> -	{0x315a, 0x02},
> -	{0x3168, 0xa0},
> -	{0x316a, 0x7e},
>  	{0x31a1, 0x00},
>  	{0x3288, 0x21},
>  	{0x328a, 0x02},
> @@ -266,6 +258,65 @@ static const struct imx335_reg raw12_framefmt_regs[] = {
>  	{0x341d, 0x00},
>  };
>  
> +static const struct imx335_reg mipi_data_rate_1188Mbps[] = {
> +	{0x300c, 0x3b},
> +	{0x300d, 0x2a},
> +	{0x314c, 0xc6},
> +	{0x314d, 0x00},
> +	{0x315a, 0x02},
> +	{0x3168, 0xa0},
> +	{0x316a, 0x7e},
> +	{0x319e, 0x01},
> +	{0x3a18, 0x8f},
> +	{0x3a1a, 0x4f},
> +	{0x3a1c, 0x47},
> +	{0x3a1e, 0x37},
> +	{0x3a1f, 0x01},
> +	{0x3a20, 0x4f},
> +	{0x3a22, 0x87},
> +	{0x3a24, 0x4f},
> +	{0x3a26, 0x7f},
> +	{0x3a28, 0x3f},
> +};
> +
> +static const struct imx335_reg mipi_data_rate_891Mbps[] = {
> +	{0x300c, 0x3b},
> +	{0x300d, 0x2a},
> +	{0x314c, 0x29},
> +	{0x314d, 0x01},
> +	{0x315a, 0x06},
> +	{0x3168, 0xa0},
> +	{0x316a, 0x7e},
> +	{0x319e, 0x02},
> +	{0x3a18, 0x7f},
> +	{0x3a1a, 0x37},
> +	{0x3a1c, 0x37},
> +	{0x3a1e, 0xf7},
> +	{0x3a20, 0x3f},
> +	{0x3a22, 0x6f},
> +	{0x3a24, 0x3f},
> +	{0x3a26, 0x5f},
> +	{0x3a28, 0x2f},
> +};
> +
> +static const s64 link_freq[] = {
> +	/* Corresponds to 1188Mbps data lane rate */
> +	IMX335_LINK_FREQ_594MHz,
> +	/* Corresponds to 891Mbps data lane rate */
> +	IMX335_LINK_FREQ_445MHz,
> +};
> +
> +static const struct imx335_reg_list link_freq_reglist[] = {
> +	{
> +		.num_of_regs = ARRAY_SIZE(mipi_data_rate_1188Mbps),
> +		.regs = mipi_data_rate_1188Mbps,
> +	},
> +	{
> +		.num_of_regs = ARRAY_SIZE(mipi_data_rate_891Mbps),
> +		.regs = mipi_data_rate_891Mbps,
> +	},
> +};
> +
>  static const u32 imx335_mbus_codes[] = {
>  	MEDIA_BUS_FMT_SRGGB12_1X12,
>  	MEDIA_BUS_FMT_SRGGB10_1X10,
> @@ -280,7 +331,6 @@ static const struct imx335_mode supported_mode = {
>  	.vblank_min = 2560,
>  	.vblank_max = 133060,
>  	.pclk = 396000000,
> -	.link_freq_idx = 0,
>  	.reg_list = {
>  		.num_of_regs = ARRAY_SIZE(mode_2592x1940_regs),
>  		.regs = mode_2592x1940_regs,
> @@ -405,7 +455,7 @@ static int imx335_update_controls(struct imx335 *imx335,
>  {
>  	int ret;
>  
> -	ret = __v4l2_ctrl_s_ctrl(imx335->link_freq_ctrl, mode->link_freq_idx);
> +	ret = __v4l2_ctrl_s_ctrl(imx335->link_freq_ctrl, imx335->link_freq_idx);
>  	if (ret)
>  		return ret;
>  
> @@ -755,6 +805,14 @@ static int imx335_start_streaming(struct imx335 *imx335)
>  	const struct imx335_reg_list *reg_list;
>  	int ret;
>  
> +	/* Setup PLL */
> +	reg_list = &link_freq_reglist[imx335->link_freq_idx];
> +	ret = imx335_write_regs(imx335, reg_list->regs, reg_list->num_of_regs);
> +	if (ret) {
> +		dev_err(imx335->dev, "%s failed to set plls\n", __func__);
> +		return ret;
> +	}
> +
>  	/* Write sensor mode registers */
>  	reg_list = &imx335->cur_mode->reg_list;
>  	ret = imx335_write_regs(imx335, reg_list->regs,
> @@ -881,7 +939,7 @@ static int imx335_parse_hw_config(struct imx335 *imx335)
>  	};
>  	struct fwnode_handle *ep;
>  	unsigned long rate;
> -	unsigned int i;
> +	unsigned int i, j;
>  	int ret;
>  
>  	if (!fwnode)
> @@ -945,13 +1003,21 @@ static int imx335_parse_hw_config(struct imx335 *imx335)
>  		goto done_endpoint_free;
>  	}
>  
> -	for (i = 0; i < bus_cfg.nr_of_link_frequencies; i++)
> -		if (bus_cfg.link_frequencies[i] == IMX335_LINK_FREQ)
> -			goto done_endpoint_free;
>  
> -	dev_err(imx335->dev, "no compatible link frequencies found\n");
> +	for (i = 0; i < bus_cfg.nr_of_link_frequencies; i++) {
> +		for (j = 0; j < ARRAY_SIZE(link_freq); j++) {
> +			if (bus_cfg.link_frequencies[i] == link_freq[j]) {
> +				imx335->link_freq_idx = j;
> +				break;

Instead of stabbing the old implementation, could you instead use
v4l2_link_freq_to_bitmap()
<URL:https://patchwork.linuxtv.org/project/linux-media/patch/20240108075221.15757-2-sakari.ailus@linux.intel.com/>?

> +			}
> +		}
>  
> -	ret = -EINVAL;
> +		if (j == ARRAY_SIZE(link_freq)) {
> +			ret = dev_err_probe(imx335->dev, -EINVAL,
> +					    "no supported link freq found\n");
> +			goto done_endpoint_free;
> +		}
> +	}
>  
>  done_endpoint_free:
>  	v4l2_fwnode_endpoint_free(&bus_cfg);
> @@ -1101,7 +1167,7 @@ static int imx335_init_controls(struct imx335 *imx335)
>  							V4L2_CID_LINK_FREQ,
>  							ARRAY_SIZE(link_freq) -
>  							1,
> -							mode->link_freq_idx,
> +							imx335->link_freq_idx,
>  							link_freq);
>  	if (imx335->link_freq_ctrl)
>  		imx335->link_freq_ctrl->flags |= V4L2_CTRL_FLAG_READ_ONLY;

-- 
Regards,

Sakari Ailus

