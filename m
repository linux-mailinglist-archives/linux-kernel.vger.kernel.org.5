Return-Path: <linux-kernel+bounces-130181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 355A1897503
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57CF51C25C61
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FBD14F12B;
	Wed,  3 Apr 2024 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SkO0cMBu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652DE14EC62;
	Wed,  3 Apr 2024 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161140; cv=none; b=JEDBj8gjDe52hGsMfuf/Z96M5pSWqUqBffFMtiRRk6/o5BQFM/GKYnqIIlSpazzkgiYnJmgtN7OHSUTpBD3FRO/ZVdZ6JoV6If0VH4XpfOeTTcZyWawXDmpQXlRztwIAMvwQw1FoGsbhd4Y3uh5W46SQxqx35YunohG9np0nKAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161140; c=relaxed/simple;
	bh=SGfPVU8V5igH8YWHdvcYC/PRY8VGmklyP1mTAt5HW2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W60BM0kNe+YpzFev3Hawob8TkOZPLNsepuv9NAn4OuUaGUbRTQCin1ZSlALxON48FaQSd+Goad1yEsH33TUhLRsaq94DnH57z1nMWdgQGAKuy39+m9Sr4q8oiivwFT3PXFqK2Yr9E+dQPvPmlEe6lWY4HtxY9IazQ8ITz0eXiTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SkO0cMBu; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712161139; x=1743697139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SGfPVU8V5igH8YWHdvcYC/PRY8VGmklyP1mTAt5HW2w=;
  b=SkO0cMBu5yiJgvIV5m4piEuc6hdhcCs0Y5N85kgoKtDTldvq7sTdZEF0
   Iqo/cXflcSx8KdN0EsDMDW6Z/kaMWxIuI8foLO0BnEkMPXU6LrtbSB71u
   rcdGTKyNWRfxcYGyNSKQE+GrJhrZbtvT5epZN2cY8giXa+Y7wjGxd9ISh
   rPyg305j9NCvuVtSqZuzvVRCZ5XI7YBtEbZgbrGyBXP0mQxBgg6Lp3TGC
   aLlQzsdaMYsYjvTfn1bUmZvPfgR0o6JLY89CIdvyeKNYGL6QJfxXxxkQv
   7r+eOK6wClYEMYQXu6/rIO/euFQJAiNe2pQbkVWY3stmmCuW9i31G5HKk
   Q==;
X-CSE-ConnectionGUID: sqt/afK5R3+PLBYO0oCxzg==
X-CSE-MsgGUID: vNDgo3EpSuWPHAYm7Wi4bA==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="7594728"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7594728"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 09:18:52 -0700
X-CSE-ConnectionGUID: bjlkRXSBRHO8Nb0ulkHabQ==
X-CSE-MsgGUID: +46wiwqRQ/qbWc2RyCbZKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="18552257"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 09:18:48 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 90B1C11F811;
	Wed,  3 Apr 2024 19:18:45 +0300 (EEST)
Date: Wed, 3 Apr 2024 16:18:45 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: git@luigi311.com
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
	jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	pavel@ucw.cz, phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 19/25] media: i2c: imx258: Change register settings
 for variants of the sensor
Message-ID: <Zg2BZXQpzsm7jMnc@kekkonen.localdomain>
References: <20240403150355.189229-1-git@luigi311.com>
 <20240403150355.189229-20-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403150355.189229-20-git@luigi311.com>

Hi Luis, Dave,

On Wed, Apr 03, 2024 at 09:03:48AM -0600, git@luigi311.com wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> Sony have advised that there are variants of the IMX258 sensor which
> require slightly different register configuration to the mainline
> imx258 driver defaults.
> 
> There is no available run-time detection for the variant, so add
> configuration via the DT compatible string.
> 
> The Vision Components imx258 module supports PDAF, so add the
> register differences for that variant
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Luis Garcia <git@luigi311.com>
> ---
>  drivers/media/i2c/imx258.c | 48 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
> index 775d957c9b87..fa48da212037 100644
> --- a/drivers/media/i2c/imx258.c
> +++ b/drivers/media/i2c/imx258.c
> @@ -6,6 +6,7 @@
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
>  #include <media/v4l2-ctrls.h>
> @@ -321,8 +322,6 @@ static const struct imx258_reg mipi_642mbps_24mhz_4l[] = {
>  
>  static const struct imx258_reg mode_common_regs[] = {
>  	{ 0x3051, 0x00 },
> -	{ 0x3052, 0x00 },
> -	{ 0x4E21, 0x14 },
>  	{ 0x6B11, 0xCF },
>  	{ 0x7FF0, 0x08 },
>  	{ 0x7FF1, 0x0F },
> @@ -345,7 +344,6 @@ static const struct imx258_reg mode_common_regs[] = {
>  	{ 0x7FA8, 0x03 },
>  	{ 0x7FA9, 0xFE },
>  	{ 0x7B24, 0x81 },
> -	{ 0x7B25, 0x00 },
>  	{ 0x6564, 0x07 },
>  	{ 0x6B0D, 0x41 },
>  	{ 0x653D, 0x04 },
> @@ -460,6 +458,33 @@ static const struct imx258_reg mode_1048_780_regs[] = {
>  	{ 0x034F, 0x0C },
>  };
>  
> +struct imx258_variant_cfg {
> +	const struct imx258_reg *regs;
> +	unsigned int num_regs;
> +};
> +
> +static const struct imx258_reg imx258_cfg_regs[] = {
> +	{ 0x3052, 0x00 },
> +	{ 0x4E21, 0x14 },
> +	{ 0x7B25, 0x00 },
> +};
> +
> +static const struct imx258_variant_cfg imx258_cfg = {
> +	.regs = imx258_cfg_regs,
> +	.num_regs = ARRAY_SIZE(imx258_cfg_regs),
> +};
> +
> +static const struct imx258_reg imx258_pdaf_cfg_regs[] = {
> +	{ 0x3052, 0x01 },
> +	{ 0x4E21, 0x10 },
> +	{ 0x7B25, 0x01 },
> +};
> +
> +static const struct imx258_variant_cfg imx258_pdaf_cfg = {
> +	.regs = imx258_pdaf_cfg_regs,
> +	.num_regs = ARRAY_SIZE(imx258_pdaf_cfg_regs),
> +};
> +
>  static const char * const imx258_test_pattern_menu[] = {
>  	"Disabled",
>  	"Solid Colour",
> @@ -637,6 +662,8 @@ struct imx258 {
>  	struct v4l2_subdev sd;
>  	struct media_pad pad;
>  
> +	const struct imx258_variant_cfg *variant_cfg;
> +
>  	struct v4l2_ctrl_handler ctrl_handler;
>  	/* V4L2 Controls */
>  	struct v4l2_ctrl *link_freq;
> @@ -1104,6 +1131,14 @@ static int imx258_start_streaming(struct imx258 *imx258)
>  		return ret;
>  	}
>  
> +	ret = imx258_write_regs(imx258, imx258->variant_cfg->regs,
> +				imx258->variant_cfg->num_regs);
> +	if (ret) {
> +		dev_err(&client->dev, "%s failed to set variant config\n",
> +			__func__);
> +		return ret;
> +	}
> +
>  	ret = imx258_write_reg(imx258, IMX258_CLK_BLANK_STOP,
>  			       IMX258_REG_VALUE_08BIT,
>  			       imx258->csi2_flags & V4L2_MBUS_CSI2_NONCONTINUOUS_CLOCK ?
> @@ -1492,6 +1527,10 @@ static int imx258_probe(struct i2c_client *client)
>  
>  	imx258->csi2_flags = ep.bus.mipi_csi2.flags;
>  
> +	imx258->variant_cfg = of_device_get_match_data(&client->dev);

You'll also need to keep this working for ACPI based systems. I.e. in
practice remove "of_" prefix here and add the non-PDAF variant data to the
relevant ACPI ID list.

> +	if (!imx258->variant_cfg)
> +		imx258->variant_cfg = &imx258_cfg;
> +
>  	/* Initialize subdev */
>  	v4l2_i2c_subdev_init(&imx258->sd, client, &imx258_subdev_ops);
>  
> @@ -1579,7 +1618,8 @@ MODULE_DEVICE_TABLE(acpi, imx258_acpi_ids);
>  #endif
>  
>  static const struct of_device_id imx258_dt_ids[] = {
> -	{ .compatible = "sony,imx258" },
> +	{ .compatible = "sony,imx258", .data = &imx258_cfg },
> +	{ .compatible = "sony,imx258-pdaf", .data = &imx258_pdaf_cfg },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, imx258_dt_ids);

-- 
Kind regards,

Sakari Ailus

