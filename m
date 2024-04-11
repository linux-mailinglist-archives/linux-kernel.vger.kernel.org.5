Return-Path: <linux-kernel+bounces-140382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 552C28A1393
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B79B2859CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5609914A0A4;
	Thu, 11 Apr 2024 11:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HddZYBBR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3153399F;
	Thu, 11 Apr 2024 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712836252; cv=none; b=ZfZrXN6xpmR8OKZNirqDFDx6L7td3VpP5oghuxjnSbO2jsUYFJUVR/mb9gxcR879TmbRAl6rDXXMLWcO9u5fmNk8kTKV4Ju8nz/S+e23Aw37U2Lwx32JKaw59LvboGqNP5YtY+NZjb2NosR4Oi/hfQEHyuiPzgmF/L8ndjWcyQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712836252; c=relaxed/simple;
	bh=x2xmEMXg0ToXdBU/uFQI+8ztDExZFbr51eVT23DMBXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGuQcE3THn5n87fz66kVt97yZ49ehM53sTwiMtW5OwKJv8v/6wU7HkC48YBd6WglBh0x7IS1z03UNndxYMexflKPiZjyfMbUo7kgOlaim+H7vqguGca+4qs8w3ByEzLjy2ZSQuGn80Uby9hkqEsmb1Sy0tAn68kb10kwJIfn+Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HddZYBBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91396C433F1;
	Thu, 11 Apr 2024 11:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712836252;
	bh=x2xmEMXg0ToXdBU/uFQI+8ztDExZFbr51eVT23DMBXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HddZYBBR7ETEpcmSBl1vlrueptxmLgeRCRvRjPNgIe/F5XpjbrAr3RE6WHwEl/16H
	 ZZBQDyqaHZ/C7piAbZsOkT+TtOvx0MpQsyoHAnALrGWkfR3rFsFfTwVrJ/wOR0z6ji
	 4nrcwj6flDD/uv1//kqb+TDVPTEkKQFShwGDtqkJdSp9jJTAOdnTTcPXFpzC+5CiJ7
	 MUsgCIfphnz1ex3A1cuELUd0bBmxUGnmnCphnJlLO1PtSM0RIPbWoPw6/5g+UScojj
	 5VMZMHzXL6UIejIxtOtee2Fy/BJh5S7BHVGCF5kPT9OSOVKU1+5Ps7Rd5JNxhCxhP7
	 knsAJS9yyxQNw==
Date: Thu, 11 Apr 2024 12:50:47 +0100
From: Lee Jones <lee@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, mazziesaccount@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mfd: rohm-bd71828: Add power off functionality
Message-ID: <20240411115047.GI1980182@google.com>
References: <20240402111700.494004-1-andreas@kemnade.info>
 <20240402111700.494004-3-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240402111700.494004-3-andreas@kemnade.info>

On Tue, 02 Apr 2024, Andreas Kemnade wrote:

> Since the chip can power off the system, add the corresponding
> functionality.
> Based on https://github.com/kobolabs/Kobo-Reader/raw/master/hw/imx6sll-clara2e/kernel.tar.bz2
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>  drivers/mfd/rohm-bd71828.c       | 36 +++++++++++++++++++++++++++++++-
>  include/linux/mfd/rohm-bd71828.h |  3 +++
>  2 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/rohm-bd71828.c b/drivers/mfd/rohm-bd71828.c
> index 594718f7e8e1..4a1fa8a0d76a 100644
> --- a/drivers/mfd/rohm-bd71828.c
> +++ b/drivers/mfd/rohm-bd71828.c
> @@ -464,6 +464,27 @@ static int set_clk_mode(struct device *dev, struct regmap *regmap,
>  				  OUT32K_MODE_CMOS);
>  }
>  
> +static struct i2c_client *bd71828_dev;
> +static void bd71828_power_off(void)
> +{
> +	while (true) {
> +		s32 val;
> +
> +		/* We are not allowed to sleep, so do not use regmap involving mutexes here. */
> +		val = i2c_smbus_read_byte_data(bd71828_dev, BD71828_REG_PS_CTRL_1);
> +		if (val >= 0)
> +			i2c_smbus_write_byte_data(bd71828_dev,
> +						  BD71828_REG_PS_CTRL_1,
> +						  BD71828_MASK_STATE_HBNT | (u8)val);
> +		mdelay(500);
> +	}
> +}
> +
> +static void bd71828_remove_poweroff(void *data)
> +{
> +	pm_power_off = NULL;
> +}
> +
>  static int bd71828_i2c_probe(struct i2c_client *i2c)
>  {
>  	struct regmap_irq_chip_data *irq_data;
> @@ -542,7 +563,20 @@ static int bd71828_i2c_probe(struct i2c_client *i2c)
>  	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO, mfd, cells,
>  				   NULL, 0, regmap_irq_get_domain(irq_data));
>  	if (ret)
> -		dev_err_probe(&i2c->dev, ret, "Failed to create subdevices\n");
> +		return	dev_err_probe(&i2c->dev, ret, "Failed to create subdevices\n");
> +
> +	if (of_device_is_system_power_controller(i2c->dev.of_node) &&
> +	    chip_type == ROHM_CHIP_TYPE_BD71828) {
> +		if (!pm_power_off) {
> +			bd71828_dev = i2c;
> +			pm_power_off = bd71828_power_off;
> +			ret = devm_add_action_or_reset(&i2c->dev,
> +						       bd71828_remove_poweroff,
> +						       NULL);
> +		} else {
> +			dev_warn(&i2c->dev, "Poweroff callback already assigned\n");
> +		}
> +	}
>  
>  	return ret;
>  }
> diff --git a/include/linux/mfd/rohm-bd71828.h b/include/linux/mfd/rohm-bd71828.h
> index 3b5f3a7db4bd..9776fde1262d 100644
> --- a/include/linux/mfd/rohm-bd71828.h
> +++ b/include/linux/mfd/rohm-bd71828.h
> @@ -4,6 +4,7 @@
>  #ifndef __LINUX_MFD_BD71828_H__
>  #define __LINUX_MFD_BD71828_H__
>  
> +#include <linux/bits.h>
>  #include <linux/mfd/rohm-generic.h>
>  #include <linux/mfd/rohm-shared.h>
>  
> @@ -41,6 +42,8 @@ enum {
>  #define BD71828_REG_PS_CTRL_2		0x05
>  #define BD71828_REG_PS_CTRL_3		0x06
>  
> +#define BD71828_MASK_STATE_HBNT		BIT(1)
> +
>  //#define BD71828_REG_SWRESET		0x06

How did this get in here?

>  #define BD71828_MASK_RUN_LVL_CTRL	0x30
>  
> -- 
> 2.39.2
> 

-- 
Lee Jones [李琼斯]

