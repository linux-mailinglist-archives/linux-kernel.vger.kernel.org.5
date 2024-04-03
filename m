Return-Path: <linux-kernel+bounces-130188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D959C897527
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E57028DC02
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB241514F4;
	Wed,  3 Apr 2024 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lEppQnUT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3E214F12B;
	Wed,  3 Apr 2024 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161453; cv=none; b=P25w/mJ4Yk+CIgLA9Z4Ag2pf3TyzhC18rnC61OjqJpxPpS5XQb75x3L3Uoi6Da/UVoBrGTEVSZGuLD03h3mg4F97z1BzJ+TRaw9MLj/Lw0RB2d2FXFcoo7zjS0x3tonAEkXUcnWFn5flTeuaCLkssVP0t3toYMd0H7SVP/ruMM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161453; c=relaxed/simple;
	bh=mfbKRGDeAW6lacMfeoaHRqTauFZUDH+47jG8h2LpJzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXrK+cWciAOLB5gbiUvMxsGMzklOEz2FJvgd5ug6qe7l41wfLeZA8W1JsUFhMaPIf7z0oORFA8zwoXBYJOUFQxuN/XjVVY4XWRz1h9T60xfGD4Pjh4/g+756QdUf3twSdOCJEm2j7R8yaWNY5Ge2ynS4/S+ZEDy2A3E/9+BYQTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lEppQnUT; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712161452; x=1743697452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mfbKRGDeAW6lacMfeoaHRqTauFZUDH+47jG8h2LpJzY=;
  b=lEppQnUT5BvBrPxiVV8FQjILipyp+ZnNWajnblfy6oeFieCLMtT0f9w6
   eOgWu+e3lL1hgmFoQtdY+ZSa1FreXenx+aURWHiDhkrsKHgJYLWzgIVzw
   9VbHcEqbivj8tMHWh4ldXXUKY4/uSeVQdfSeiYrrL3wfXT0dJ9IMZ2Yxo
   MY5Rj9ehW/suRii5I19KScs5ytT/8rt2WXgNGFbm19zjU/vDA/JxqOpNR
   w/5USXUPnUx9Y4JjDiH27d4idp/CiOtStkTA2Sibsk7mo4Lk/NiWwwCxo
   R/jMjwIywZKU5HMueQL3xBg9T271apULdw3RCCQtmtBWY97HlLjS+9CsX
   w==;
X-CSE-ConnectionGUID: a5sKs2KPRxyB7Bv6N1TOuA==
X-CSE-MsgGUID: tnPwUIJCSiqi2FkNznAKdA==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7637729"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7637729"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 09:23:46 -0700
X-CSE-ConnectionGUID: 8zbmQFEoSkaXJZPipJqLmA==
X-CSE-MsgGUID: j+XM1B3HQGuXmbySi9P8Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18913062"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 09:23:42 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id E3A5311F811;
	Wed,  3 Apr 2024 19:23:38 +0300 (EEST)
Date: Wed, 3 Apr 2024 16:23:38 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: git@luigi311.com
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	pavel@ucw.cz, phone-devel@vger.kernel.org,
	Ondrej Jirman <megi@xff.cz>
Subject: Re: [PATCH v3 21/25] drivers: media: i2c: imx258: Use macros
Message-ID: <Zg2CirmwL3JfjA8s@kekkonen.localdomain>
References: <20240403150355.189229-1-git@luigi311.com>
 <20240403150355.189229-22-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403150355.189229-22-git@luigi311.com>

Hi Luis,

On Wed, Apr 03, 2024 at 09:03:50AM -0600, git@luigi311.com wrote:
> From: Luis Garcia <git@luigi311.com>
> 
> Use understandable macros instead of raw values.
> 
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Luis Garcia <git@luigi311.com>
> ---
>  drivers/media/i2c/imx258.c | 434 ++++++++++++++++++-------------------
>  1 file changed, 207 insertions(+), 227 deletions(-)
> 
> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
> index e2ecf6109516..30352c33f63c 100644
> --- a/drivers/media/i2c/imx258.c
> +++ b/drivers/media/i2c/imx258.c
> @@ -33,8 +33,6 @@
>  #define IMX258_VTS_30FPS_VGA		0x034c
>  #define IMX258_VTS_MAX			65525
>  
> -#define IMX258_REG_VTS			0x0340
> -
>  /* HBLANK control - read only */
>  #define IMX258_PPL_DEFAULT		5352
>  
> @@ -90,6 +88,53 @@
>  #define IMX258_PIXEL_ARRAY_WIDTH	4208U
>  #define IMX258_PIXEL_ARRAY_HEIGHT	3120U
>  
> +/* regs */
> +#define IMX258_REG_PLL_MULT_DRIV                  0x0310
> +#define IMX258_REG_IVTPXCK_DIV                    0x0301
> +#define IMX258_REG_IVTSYCK_DIV                    0x0303
> +#define IMX258_REG_PREPLLCK_VT_DIV                0x0305
> +#define IMX258_REG_IOPPXCK_DIV                    0x0309
> +#define IMX258_REG_IOPSYCK_DIV                    0x030b
> +#define IMX258_REG_PREPLLCK_OP_DIV                0x030d
> +#define IMX258_REG_PHASE_PIX_OUTEN                0x3030
> +#define IMX258_REG_PDPIX_DATA_RATE                0x3032
> +#define IMX258_REG_SCALE_MODE                     0x0401
> +#define IMX258_REG_SCALE_MODE_EXT                 0x3038
> +#define IMX258_REG_AF_WINDOW_MODE                 0x7bcd
> +#define IMX258_REG_FRM_LENGTH_CTL                 0x0350
> +#define IMX258_REG_CSI_LANE_MODE                  0x0114
> +#define IMX258_REG_X_EVN_INC                      0x0381
> +#define IMX258_REG_X_ODD_INC                      0x0383
> +#define IMX258_REG_Y_EVN_INC                      0x0385
> +#define IMX258_REG_Y_ODD_INC                      0x0387
> +#define IMX258_REG_BINNING_MODE                   0x0900
> +#define IMX258_REG_BINNING_TYPE_V                 0x0901
> +#define IMX258_REG_FORCE_FD_SUM                   0x300d
> +#define IMX258_REG_DIG_CROP_X_OFFSET              0x0408
> +#define IMX258_REG_DIG_CROP_Y_OFFSET              0x040a
> +#define IMX258_REG_DIG_CROP_IMAGE_WIDTH           0x040c
> +#define IMX258_REG_DIG_CROP_IMAGE_HEIGHT          0x040e
> +#define IMX258_REG_SCALE_M                        0x0404
> +#define IMX258_REG_X_OUT_SIZE                     0x034c
> +#define IMX258_REG_Y_OUT_SIZE                     0x034e
> +#define IMX258_REG_X_ADD_STA                      0x0344
> +#define IMX258_REG_Y_ADD_STA                      0x0346
> +#define IMX258_REG_X_ADD_END                      0x0348
> +#define IMX258_REG_Y_ADD_END                      0x034a
> +#define IMX258_REG_EXCK_FREQ                      0x0136
> +#define IMX258_REG_CSI_DT_FMT                     0x0112
> +#define IMX258_REG_LINE_LENGTH_PCK                0x0342
> +#define IMX258_REG_SCALE_M_EXT                    0x303a
> +#define IMX258_REG_FRM_LENGTH_LINES               0x0340
> +#define IMX258_REG_FINE_INTEG_TIME                0x0200
> +#define IMX258_REG_PLL_IVT_MPY                    0x0306
> +#define IMX258_REG_PLL_IOP_MPY                    0x030e
> +#define IMX258_REG_REQ_LINK_BIT_RATE_MBPS_H       0x0820
> +#define IMX258_REG_REQ_LINK_BIT_RATE_MBPS_L       0x0822
> +
> +#define REG8(a, v) { a, v }
> +#define REG16(a, v) { a, ((v) >> 8) & 0xff }, { (a) + 1, (v) & 0xff }

The patch is nice but these macros are better replaced by the V4L2 CCI
helper that also offers register access functions. Could you add a patch to
convert the driver to use it (maybe after this one)?

> +
>  struct imx258_reg {
>  	u16 address;
>  	u8 val;
> @@ -145,179 +190,139 @@ struct imx258_mode {
>   * lane data rate when using 2 lanes, thus allowing a maximum of 15fps.
>   */
>  static const struct imx258_reg mipi_1267mbps_19_2mhz_2l[] = {
> -	{ 0x0136, 0x13 },
> -	{ 0x0137, 0x33 },
> -	{ 0x0301, 0x0A },
> -	{ 0x0303, 0x02 },
> -	{ 0x0305, 0x03 },
> -	{ 0x0306, 0x00 },
> -	{ 0x0307, 0xC6 },
> -	{ 0x0309, 0x0A },
> -	{ 0x030B, 0x01 },
> -	{ 0x030D, 0x02 },
> -	{ 0x030E, 0x00 },
> -	{ 0x030F, 0xD8 },
> -	{ 0x0310, 0x00 },
> -
> -	{ 0x0114, 0x01 },
> -	{ 0x0820, 0x09 },
> -	{ 0x0821, 0xa6 },
> -	{ 0x0822, 0x66 },
> -	{ 0x0823, 0x66 },
> +	REG16(IMX258_REG_EXCK_FREQ, 0x1333),
> +	REG8(IMX258_REG_IVTPXCK_DIV, 10),
> +	REG8(IMX258_REG_IVTSYCK_DIV, 2),
> +	REG8(IMX258_REG_PREPLLCK_VT_DIV, 3),
> +	REG16(IMX258_REG_PLL_IVT_MPY, 0x00C6),
> +	REG8(IMX258_REG_IOPPXCK_DIV, 10),
> +	REG8(IMX258_REG_IOPSYCK_DIV, 1),
> +	REG8(IMX258_REG_PREPLLCK_OP_DIV, 2),
> +	REG16(IMX258_REG_PLL_IOP_MPY, 0x00D8),
> +	REG8(IMX258_REG_PLL_MULT_DRIV, 0),
> +
> +	REG8(IMX258_REG_CSI_LANE_MODE, 1),
> +	REG16(IMX258_REG_REQ_LINK_BIT_RATE_MBPS_H, 0x09A6),
> +	REG16(IMX258_REG_REQ_LINK_BIT_RATE_MBPS_L, 0x6666),
>  };
>  
>  static const struct imx258_reg mipi_1267mbps_19_2mhz_4l[] = {
> -	{ 0x0136, 0x13 },
> -	{ 0x0137, 0x33 },
> -	{ 0x0301, 0x05 },
> -	{ 0x0303, 0x02 },
> -	{ 0x0305, 0x03 },
> -	{ 0x0306, 0x00 },
> -	{ 0x0307, 0xC6 },
> -	{ 0x0309, 0x0A },
> -	{ 0x030B, 0x01 },
> -	{ 0x030D, 0x02 },
> -	{ 0x030E, 0x00 },
> -	{ 0x030F, 0xD8 },
> -	{ 0x0310, 0x00 },
> -
> -	{ 0x0114, 0x03 },
> -	{ 0x0820, 0x13 },
> -	{ 0x0821, 0x4C },
> -	{ 0x0822, 0xCC },
> -	{ 0x0823, 0xCC },
> +	REG16(IMX258_REG_EXCK_FREQ, 0x1333),
> +	REG8(IMX258_REG_IVTPXCK_DIV, 5),
> +	REG8(IMX258_REG_IVTSYCK_DIV, 2),
> +	REG8(IMX258_REG_PREPLLCK_VT_DIV, 3),
> +	REG16(IMX258_REG_PLL_IVT_MPY, 0x00C6),
> +	REG8(IMX258_REG_IOPPXCK_DIV, 10),
> +	REG8(IMX258_REG_IOPSYCK_DIV, 1),
> +	REG8(IMX258_REG_PREPLLCK_OP_DIV, 2),
> +	REG16(IMX258_REG_PLL_IOP_MPY, 0x00D8),
> +	REG8(IMX258_REG_PLL_MULT_DRIV, 0),
> +
> +	REG8(IMX258_REG_CSI_LANE_MODE, 3),
> +	REG16(IMX258_REG_REQ_LINK_BIT_RATE_MBPS_H, 0x134C),
> +	REG16(IMX258_REG_REQ_LINK_BIT_RATE_MBPS_L, 0xCCCC),
>  };
>  
>  static const struct imx258_reg mipi_1272mbps_24mhz_2l[] = {
> -	{ 0x0136, 0x18 },
> -	{ 0x0137, 0x00 },
> -	{ 0x0301, 0x0a },
> -	{ 0x0303, 0x02 },
> -	{ 0x0305, 0x04 },
> -	{ 0x0306, 0x00 },
> -	{ 0x0307, 0xD4 },
> -	{ 0x0309, 0x0A },
> -	{ 0x030B, 0x01 },
> -	{ 0x030D, 0x02 },
> -	{ 0x030E, 0x00 },
> -	{ 0x030F, 0xD8 },
> -	{ 0x0310, 0x00 },
> -
> -	{ 0x0114, 0x01 },
> -	{ 0x0820, 0x13 },
> -	{ 0x0821, 0x4C },
> -	{ 0x0822, 0xCC },
> -	{ 0x0823, 0xCC },
> +	REG16(IMX258_REG_EXCK_FREQ, 0x1800),
> +	REG8(IMX258_REG_IVTPXCK_DIV, 10),
> +	REG8(IMX258_REG_IVTSYCK_DIV, 2),
> +	REG8(IMX258_REG_PREPLLCK_VT_DIV, 4),
> +	REG16(IMX258_REG_PLL_IVT_MPY, 0x00D4),
> +	REG8(IMX258_REG_IOPPXCK_DIV, 10),
> +	REG8(IMX258_REG_IOPSYCK_DIV, 1),
> +	REG8(IMX258_REG_PREPLLCK_OP_DIV, 2),
> +	REG16(IMX258_REG_PLL_IOP_MPY, 0x00D8),
> +	REG8(IMX258_REG_PLL_MULT_DRIV, 0),
> +
> +	REG8(IMX258_REG_CSI_LANE_MODE, 1),
> +	REG16(IMX258_REG_REQ_LINK_BIT_RATE_MBPS_H, 0x134C),
> +	REG16(IMX258_REG_REQ_LINK_BIT_RATE_MBPS_L, 0xCCCC),
>  };
>  
>  static const struct imx258_reg mipi_1272mbps_24mhz_4l[] = {
> -	{ 0x0136, 0x18 },
> -	{ 0x0137, 0x00 },
> -	{ 0x0301, 0x05 },
> -	{ 0x0303, 0x02 },
> -	{ 0x0305, 0x04 },
> -	{ 0x0306, 0x00 },
> -	{ 0x0307, 0xD4 },
> -	{ 0x0309, 0x0A },
> -	{ 0x030B, 0x01 },
> -	{ 0x030D, 0x02 },
> -	{ 0x030E, 0x00 },
> -	{ 0x030F, 0xD8 },
> -	{ 0x0310, 0x00 },
> -
> -	{ 0x0114, 0x03 },
> -	{ 0x0820, 0x13 },
> -	{ 0x0821, 0xE0 },
> -	{ 0x0822, 0x00 },
> -	{ 0x0823, 0x00 },
> +	REG16(IMX258_REG_EXCK_FREQ, 0x1800),
> +	REG8(IMX258_REG_IVTPXCK_DIV, 5),
> +	REG8(IMX258_REG_IVTSYCK_DIV, 2),
> +	REG8(IMX258_REG_PREPLLCK_VT_DIV, 4),
> +	REG16(IMX258_REG_PLL_IVT_MPY, 0x00D4),
> +	REG8(IMX258_REG_IOPPXCK_DIV, 10),
> +	REG8(IMX258_REG_IOPSYCK_DIV, 1),
> +	REG8(IMX258_REG_PREPLLCK_OP_DIV, 2),
> +	REG16(IMX258_REG_PLL_IOP_MPY, 0x00D8),
> +	REG8(IMX258_REG_PLL_MULT_DRIV, 0),
> +
> +	REG8(IMX258_REG_CSI_LANE_MODE, 3),
> +	REG16(IMX258_REG_REQ_LINK_BIT_RATE_MBPS_H, 0x13E0),
> +	REG16(IMX258_REG_REQ_LINK_BIT_RATE_MBPS_L, 0x0000),
>  };
>  
>  static const struct imx258_reg mipi_640mbps_19_2mhz_2l[] = {
> -	{ 0x0136, 0x13 },
> -	{ 0x0137, 0x33 },
> -	{ 0x0301, 0x05 },
> -	{ 0x0303, 0x02 },
> -	{ 0x0305, 0x03 },
> -	{ 0x0306, 0x00 },
> -	{ 0x0307, 0x64 },
> -	{ 0x0309, 0x0A },
> -	{ 0x030B, 0x01 },
> -	{ 0x030D, 0x02 },
> -	{ 0x030E, 0x00 },
> -	{ 0x030F, 0xD8 },
> -	{ 0x0310, 0x00 },
> -
> -	{ 0x0114, 0x01 },
> -	{ 0x0820, 0x05 },
> -	{ 0x0821, 0x00 },
> -	{ 0x0822, 0x00 },
> -	{ 0x0823, 0x00 },
> +	REG16(IMX258_REG_EXCK_FREQ, 0x1333),
> +	REG8(IMX258_REG_IVTPXCK_DIV, 5),
> +	REG8(IMX258_REG_IVTSYCK_DIV, 2),
> +	REG8(IMX258_REG_PREPLLCK_VT_DIV, 3),
> +	REG16(IMX258_REG_PLL_IVT_MPY, 0x0064),
> +	REG8(IMX258_REG_IOPPXCK_DIV, 10),
> +	REG8(IMX258_REG_IOPSYCK_DIV, 1),
> +	REG8(IMX258_REG_PREPLLCK_OP_DIV, 2),
> +	REG16(IMX258_REG_PLL_IOP_MPY, 0x00D8),
> +	REG8(IMX258_REG_PLL_MULT_DRIV, 0),
> +
> +	REG8(IMX258_REG_CSI_LANE_MODE, 1),
> +	REG16(IMX258_REG_REQ_LINK_BIT_RATE_MBPS_H, 0x0500),
> +	REG16(IMX258_REG_REQ_LINK_BIT_RATE_MBPS_L, 0x0000),
>  };
>  
>  static const struct imx258_reg mipi_640mbps_19_2mhz_4l[] = {
> -	{ 0x0136, 0x13 },
> -	{ 0x0137, 0x33 },
> -	{ 0x0301, 0x05 },
> -	{ 0x0303, 0x02 },
> -	{ 0x0305, 0x03 },
> -	{ 0x0306, 0x00 },
> -	{ 0x0307, 0x64 },
> -	{ 0x0309, 0x0A },
> -	{ 0x030B, 0x01 },
> -	{ 0x030D, 0x02 },
> -	{ 0x030E, 0x00 },
> -	{ 0x030F, 0xD8 },
> -	{ 0x0310, 0x00 },
> -
> -	{ 0x0114, 0x03 },
> -	{ 0x0820, 0x0A },
> -	{ 0x0821, 0x00 },
> -	{ 0x0822, 0x00 },
> -	{ 0x0823, 0x00 },
> +	REG16(IMX258_REG_EXCK_FREQ, 0x1333),
> +	REG8(IMX258_REG_IVTPXCK_DIV, 5),
> +	REG8(IMX258_REG_IVTSYCK_DIV, 2),
> +	REG8(IMX258_REG_PREPLLCK_VT_DIV, 3),
> +	REG16(IMX258_REG_PLL_IVT_MPY, 0x0064),
> +	REG8(IMX258_REG_IOPPXCK_DIV, 10),
> +	REG8(IMX258_REG_IOPSYCK_DIV, 1),
> +	REG8(IMX258_REG_PREPLLCK_OP_DIV, 2),
> +	REG16(IMX258_REG_PLL_IOP_MPY, 0x00D8),
> +	REG8(IMX258_REG_PLL_MULT_DRIV, 0),
> +
> +	REG8(IMX258_REG_CSI_LANE_MODE, 3),
> +	REG16(IMX258_REG_REQ_LINK_BIT_RATE_MBPS_H, 0x0A00),
> +	REG16(IMX258_REG_REQ_LINK_BIT_RATE_MBPS_L, 0x0000),
>  };
>  
>  static const struct imx258_reg mipi_642mbps_24mhz_2l[] = {
> -	{ 0x0136, 0x18 },
> -	{ 0x0137, 0x00 },
> -	{ 0x0301, 0x05 },
> -	{ 0x0303, 0x02 },
> -	{ 0x0305, 0x04 },
> -	{ 0x0306, 0x00 },
> -	{ 0x0307, 0x6B },
> -	{ 0x0309, 0x0A },
> -	{ 0x030B, 0x01 },
> -	{ 0x030D, 0x02 },
> -	{ 0x030E, 0x00 },
> -	{ 0x030F, 0xD8 },
> -	{ 0x0310, 0x00 },
> -
> -	{ 0x0114, 0x01 },
> -	{ 0x0820, 0x0A },
> -	{ 0x0821, 0x00 },
> -	{ 0x0822, 0x00 },
> -	{ 0x0823, 0x00 },
> +	REG16(IMX258_REG_EXCK_FREQ, 0x1800),
> +	REG8(IMX258_REG_IVTPXCK_DIV, 5),
> +	REG8(IMX258_REG_IVTSYCK_DIV, 2),
> +	REG8(IMX258_REG_PREPLLCK_VT_DIV, 4),
> +	REG16(IMX258_REG_PLL_IVT_MPY, 0x006B),
> +	REG8(IMX258_REG_IOPPXCK_DIV, 10),
> +	REG8(IMX258_REG_IOPSYCK_DIV, 1),
> +	REG8(IMX258_REG_PREPLLCK_OP_DIV, 2),
> +	REG16(IMX258_REG_PLL_IOP_MPY, 0x00D8),
> +	REG8(IMX258_REG_PLL_MULT_DRIV, 0),
> +
> +	REG8(IMX258_REG_CSI_LANE_MODE, 1),
> +	REG16(IMX258_REG_REQ_LINK_BIT_RATE_MBPS_H, 0x0A00),
> +	REG16(IMX258_REG_REQ_LINK_BIT_RATE_MBPS_L, 0x0000),
>  };
>  
>  static const struct imx258_reg mipi_642mbps_24mhz_4l[] = {
> -	{ 0x0136, 0x18 },
> -	{ 0x0137, 0x00 },
> -	{ 0x0301, 0x05 },
> -	{ 0x0303, 0x02 },
> -	{ 0x0305, 0x04 },
> -	{ 0x0306, 0x00 },
> -	{ 0x0307, 0x6B },
> -	{ 0x0309, 0x0A },
> -	{ 0x030B, 0x01 },
> -	{ 0x030D, 0x02 },
> -	{ 0x030E, 0x00 },
> -	{ 0x030F, 0xD8 },
> -	{ 0x0310, 0x00 },
> -
> -	{ 0x0114, 0x03 },
> -	{ 0x0820, 0x0A },
> -	{ 0x0821, 0x00 },
> -	{ 0x0822, 0x00 },
> -	{ 0x0823, 0x00 },
> +	REG16(IMX258_REG_EXCK_FREQ, 0x1800),
> +	REG8(IMX258_REG_IVTPXCK_DIV, 5),
> +	REG8(IMX258_REG_IVTSYCK_DIV, 2),
> +	REG8(IMX258_REG_PREPLLCK_VT_DIV, 4),
> +	REG16(IMX258_REG_PLL_IVT_MPY, 0x006B),
> +	REG8(IMX258_REG_IOPPXCK_DIV, 10),
> +	REG8(IMX258_REG_IOPSYCK_DIV, 1),
> +	REG8(IMX258_REG_PREPLLCK_OP_DIV, 2),
> +	REG16(IMX258_REG_PLL_IOP_MPY, 0x00D8),
> +	REG8(IMX258_REG_PLL_MULT_DRIV, 0),
> +
> +	REG8(IMX258_REG_CSI_LANE_MODE, 3),
> +	REG16(IMX258_REG_REQ_LINK_BIT_RATE_MBPS_H, 0x0A00),
> +	REG16(IMX258_REG_REQ_LINK_BIT_RATE_MBPS_L, 0x0000),
>  };
>  
>  static const struct imx258_reg mode_common_regs[] = {
> @@ -363,45 +368,29 @@ static const struct imx258_reg mode_common_regs[] = {
>  	{ 0x7423, 0xD7 },
>  	{ 0x5F04, 0x00 },
>  	{ 0x5F05, 0xED },
> -	{ 0x0112, 0x0A },
> -	{ 0x0113, 0x0A },
> -	{ 0x0342, 0x14 },
> -	{ 0x0343, 0xE8 },
> -	{ 0x0344, 0x00 },
> -	{ 0x0345, 0x00 },
> -	{ 0x0346, 0x00 },
> -	{ 0x0347, 0x00 },
> -	{ 0x0348, 0x10 },
> -	{ 0x0349, 0x6F },
> -	{ 0x034A, 0x0C },
> -	{ 0x034B, 0x2F },
> -	{ 0x0381, 0x01 },
> -	{ 0x0383, 0x01 },
> -	{ 0x0385, 0x01 },
> -	{ 0x0387, 0x01 },
> -	{ 0x0404, 0x00 },
> -	{ 0x0408, 0x00 },
> -	{ 0x0409, 0x00 },
> -	{ 0x040A, 0x00 },
> -	{ 0x040B, 0x00 },
> -	{ 0x040C, 0x10 },
> -	{ 0x040D, 0x70 },
> -	{ 0x3038, 0x00 },
> -	{ 0x303A, 0x00 },
> -	{ 0x303B, 0x10 },
> -	{ 0x300D, 0x00 },
> -	{ 0x0350, 0x00 },
> -	{ 0x0204, 0x00 },
> -	{ 0x0205, 0x00 },
> -	{ 0x020E, 0x01 },
> -	{ 0x020F, 0x00 },
> -	{ 0x0210, 0x01 },
> -	{ 0x0211, 0x00 },
> -	{ 0x0212, 0x01 },
> -	{ 0x0213, 0x00 },
> -	{ 0x0214, 0x01 },
> -	{ 0x0215, 0x00 },
> -	{ 0x7BCD, 0x00 },
> +	REG16(IMX258_REG_CSI_DT_FMT, 0x0a0a),
> +	REG16(IMX258_REG_LINE_LENGTH_PCK, 5352),
> +	REG16(IMX258_REG_X_ADD_STA, 0),
> +	REG16(IMX258_REG_Y_ADD_STA, 0),
> +	REG16(IMX258_REG_X_ADD_END, 4207),
> +	REG16(IMX258_REG_Y_ADD_END, 3119),
> +	REG8(IMX258_REG_X_EVN_INC, 1),
> +	REG8(IMX258_REG_X_ODD_INC, 1),
> +	REG8(IMX258_REG_Y_EVN_INC, 1),
> +	REG8(IMX258_REG_Y_ODD_INC, 1),
> +	REG16(IMX258_REG_DIG_CROP_X_OFFSET, 0),
> +	REG16(IMX258_REG_DIG_CROP_Y_OFFSET, 0),
> +	REG16(IMX258_REG_DIG_CROP_IMAGE_WIDTH, 4208),
> +	REG8(IMX258_REG_SCALE_MODE_EXT, 0),
> +	REG16(IMX258_REG_SCALE_M_EXT, 16),
> +	REG8(IMX258_REG_FORCE_FD_SUM, 0),
> +	REG8(IMX258_REG_FRM_LENGTH_CTL, 0),
> +	REG16(IMX258_REG_ANALOG_GAIN, 0),
> +	REG16(IMX258_REG_GR_DIGITAL_GAIN, 256),
> +	REG16(IMX258_REG_R_DIGITAL_GAIN, 256),
> +	REG16(IMX258_REG_B_DIGITAL_GAIN, 256),
> +	REG16(IMX258_REG_GB_DIGITAL_GAIN, 256),
> +	REG8(IMX258_REG_AF_WINDOW_MODE, 0),
>  	{ 0x94DC, 0x20 },
>  	{ 0x94DD, 0x20 },
>  	{ 0x94DE, 0x20 },
> @@ -414,48 +403,39 @@ static const struct imx258_reg mode_common_regs[] = {
>  	{ 0x941B, 0x50 },
>  	{ 0x9519, 0x50 },
>  	{ 0x951B, 0x50 },
> -	{ 0x3030, 0x00 },
> -	{ 0x3032, 0x00 },
> -	{ 0x0220, 0x00 },
> +	REG8(IMX258_REG_PHASE_PIX_OUTEN, 0),
> +	REG8(IMX258_REG_PDPIX_DATA_RATE, 0),
> +	REG8(IMX258_REG_HDR, 0),
>  };
>  
>  static const struct imx258_reg mode_4208x3120_regs[] = {
> -	{ 0x0900, 0x00 },
> -	{ 0x0901, 0x11 },
> -	{ 0x0401, 0x00 },
> -	{ 0x0405, 0x10 },
> -	{ 0x040E, 0x0C },
> -	{ 0x040F, 0x30 },
> -	{ 0x034C, 0x10 },
> -	{ 0x034D, 0x70 },
> -	{ 0x034E, 0x0C },
> -	{ 0x034F, 0x30 },
> +	REG8(IMX258_REG_BINNING_MODE, 0),
> +	REG8(IMX258_REG_BINNING_TYPE_V, 0x11),
> +	REG8(IMX258_REG_SCALE_MODE, 0),
> +	REG16(IMX258_REG_SCALE_M, 16),
> +	REG16(IMX258_REG_DIG_CROP_IMAGE_HEIGHT, 3120),
> +	REG16(IMX258_REG_X_OUT_SIZE, 4208),
> +	REG16(IMX258_REG_Y_OUT_SIZE, 3120),
>  };
>  
>  static const struct imx258_reg mode_2104_1560_regs[] = {
> -	{ 0x0900, 0x01 },
> -	{ 0x0901, 0x12 },
> -	{ 0x0401, 0x01 },
> -	{ 0x0405, 0x20 },
> -	{ 0x040E, 0x06 },
> -	{ 0x040F, 0x18 },
> -	{ 0x034C, 0x08 },
> -	{ 0x034D, 0x38 },
> -	{ 0x034E, 0x06 },
> -	{ 0x034F, 0x18 },
> +	REG8(IMX258_REG_BINNING_MODE, 1),
> +	REG8(IMX258_REG_BINNING_TYPE_V, 0x12),
> +	REG8(IMX258_REG_SCALE_MODE, 1),
> +	REG16(IMX258_REG_SCALE_M, 32),
> +	REG16(IMX258_REG_DIG_CROP_IMAGE_HEIGHT, 1560),
> +	REG16(IMX258_REG_X_OUT_SIZE, 2104),
> +	REG16(IMX258_REG_Y_OUT_SIZE, 1560),
>  };
>  
>  static const struct imx258_reg mode_1048_780_regs[] = {
> -	{ 0x0900, 0x01 },
> -	{ 0x0901, 0x14 },
> -	{ 0x0401, 0x01 },
> -	{ 0x0405, 0x40 },
> -	{ 0x040E, 0x03 },
> -	{ 0x040F, 0x0C },
> -	{ 0x034C, 0x04 },
> -	{ 0x034D, 0x18 },
> -	{ 0x034E, 0x03 },
> -	{ 0x034F, 0x0C },
> +	REG8(IMX258_REG_BINNING_MODE, 1),
> +	REG8(IMX258_REG_BINNING_TYPE_V, 0x14),
> +	REG8(IMX258_REG_SCALE_MODE, 1),
> +	REG16(IMX258_REG_SCALE_M, 64),
> +	REG16(IMX258_REG_DIG_CROP_IMAGE_HEIGHT, 780),
> +	REG16(IMX258_REG_X_OUT_SIZE, 1048),
> +	REG16(IMX258_REG_Y_OUT_SIZE, 780),
>  };
>  
>  struct imx258_variant_cfg {
> @@ -923,7 +903,7 @@ static int imx258_set_ctrl(struct v4l2_ctrl *ctrl)
>  		}
>  		break;
>  	case V4L2_CID_VBLANK:
> -		ret = imx258_write_reg(imx258, IMX258_REG_VTS,
> +		ret = imx258_write_reg(imx258, IMX258_REG_FRM_LENGTH_LINES,
>  				       IMX258_REG_VALUE_16BIT,
>  				       imx258->cur_mode->height + ctrl->val);
>  		break;

-- 
Kind regards,

Sakari Ailus

