Return-Path: <linux-kernel+bounces-142167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8F48A2867
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7DCF1F23614
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8044CDEC;
	Fri, 12 Apr 2024 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ah/LE93f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C56F1DFF7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712907782; cv=none; b=ATXRn+9gWfw76bnYdVbipYhEuHP8oTDBFmrdPGOwul20b50WFc1742HtvO4nA4mg1QmWRfshoa7+Yan4KtIvOE3oqxc33WhYDaOW4D8AQx3qhvYpEP8gGFb5jAOzUbpn8+t8Y+d+Naw8dEVs9PWoHR2IZkbNWYnnmg1fg3npajY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712907782; c=relaxed/simple;
	bh=hi1ek4H1Sl9fwCdAI2V9cU6Oyh2d+MFh/nNIBD/zwX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwIWpHyAcaMnshbDvbQGSOGw/wv7nsnsvlJf0mBtUN8qRMAi47zc5ymcAm4hQoQOg2PO+Iw6IoiVW70YRy6JeLiwZryIdrLCBmUf5268nkx1XBYXhuVm4pz2WSUjnYqHpxwggHCcQHNzn/CD04yNp18bfs11JHXsNngKwuV34l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ah/LE93f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7FEC113CC;
	Fri, 12 Apr 2024 07:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712907782;
	bh=hi1ek4H1Sl9fwCdAI2V9cU6Oyh2d+MFh/nNIBD/zwX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ah/LE93fr2qg3tg8PBLedjLnN0qhcOibXIu9JJyHYqLtwZgXn/rxgasWGzJGU5c9w
	 bzhSW9TE5LWgj45nwwkZDjXP2va8nPJx25sbnGbV5IQ4Gx0taqzEkUSJlGbTEWjAy/
	 3oGH3ZuSFmf8ek4cWX7rRSml6AhfyVHMKiNXir6Eud0yESMFnI1Cmnby37uO+9QlWU
	 nmKOxTy5B21aJ0d2pT1dl6L3115r4N/LfbCU1A2JV483MkJDJp8/UhmlvE0bT5xLmc
	 ThChiw9RDOnSDgr73AoumEdNoV3bL7peeqz9LWfifVsDkHikR1IgmhAxw2sOZlJc92
	 vXw7fQisxv1Ug==
Date: Fri, 12 Apr 2024 08:42:58 +0100
From: Lee Jones <lee@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: linux-kernel@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH mfd v1 2/2] mfd: rsmu: add FemtoClock3 support
Message-ID: <20240412074258.GP2399047@google.com>
References: <53efc0ac491055cedbef156b3c3410fa5342e637.1712857691.git.lnimi@hotmail.com>
 <LV3P220MB12025D3DF84F591EC0A9262FA0052@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <LV3P220MB12025D3DF84F591EC0A9262FA0052@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>

Did you submit this set as --thread?

The 2 patches are completely separate in my inbox.

On Thu, 11 Apr 2024, Min Li wrote:

> From: Min Li <min.li.xe@renesas.com>
> 
> The RENESAS FemtoClock3 Wireless is a high-performance
> jitter attenuator, frequency translator, and clock
> synthesizer. This patch only adds support for I2C.

54 chars is too short, should be more like 70+.

What I2C support is being added here?

> Signed-off-by: Min Li <min.li.xe@renesas.com>
> ---
>  drivers/mfd/rsmu_core.c  | 10 +++++-----
>  drivers/mfd/rsmu_i2c.c   | 16 ++++++++--------
>  include/linux/mfd/rsmu.h |  4 ++--
>  3 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mfd/rsmu_core.c b/drivers/mfd/rsmu_core.c
> index 29437fd0b..951ddd92c 100644
> --- a/drivers/mfd/rsmu_core.c
> +++ b/drivers/mfd/rsmu_core.c
> @@ -40,12 +40,12 @@ static struct mfd_cell rsmu_sabre_devs[] = {
>  	},
>  };
>  
> -static struct mfd_cell rsmu_sl_devs[] = {
> +static struct mfd_cell rsmu_fc3_devs[] = {
>  	[RSMU_PHC] = {
> -		.name = "8v19n85x-phc",
> +		.name = "rc38xxx-phc",

You don't say anything about why 8v19n85x-phc is being removed in the
commit message.  Please describe the whole change properly.

>  	},
>  	[RSMU_CDEV] = {
> -		.name = "8v19n85x-cdev",
> +		.name = "rc38xxx-cdev",
>  	},
>  };
>  
> @@ -61,8 +61,8 @@ int rsmu_core_init(struct rsmu_ddata *rsmu)
>  	case RSMU_SABRE:
>  		cells = rsmu_sabre_devs;
>  		break;
> -	case RSMU_SL:
> -		cells = rsmu_sl_devs;
> +	case RSMU_FC3:
> +		cells = rsmu_fc3_devs;
>  		break;
>  	default:
>  		dev_err(rsmu->dev, "Unsupported RSMU device type: %d\n", rsmu->type);
> diff --git a/drivers/mfd/rsmu_i2c.c b/drivers/mfd/rsmu_i2c.c
> index cba64f107..a3f50a184 100644
> --- a/drivers/mfd/rsmu_i2c.c
> +++ b/drivers/mfd/rsmu_i2c.c
> @@ -262,11 +262,11 @@ static const struct regmap_config rsmu_sabre_regmap_config = {
>  	.can_multi_write = true,
>  };
>  
> -static const struct regmap_config rsmu_sl_regmap_config = {
> +static const struct regmap_config rsmu_fc3_regmap_config = {
>  	.reg_bits = 16,
>  	.val_bits = 8,
>  	.reg_format_endian = REGMAP_ENDIAN_BIG,
> -	.max_register = 0x340,
> +	.max_register = 0xE88,
>  	.cache_type = REGCACHE_NONE,
>  	.can_multi_write = true,
>  };
> @@ -302,8 +302,8 @@ static int rsmu_i2c_probe(struct i2c_client *client)
>  	case RSMU_SABRE:
>  		cfg = &rsmu_sabre_regmap_config;
>  		break;
> -	case RSMU_SL:
> -		cfg = &rsmu_sl_regmap_config;
> +	case RSMU_FC3:
> +		cfg = &rsmu_fc3_regmap_config;
>  		break;
>  	default:
>  		dev_err(rsmu->dev, "Unsupported RSMU device type: %d\n", rsmu->type);
> @@ -336,8 +336,8 @@ static const struct i2c_device_id rsmu_i2c_id[] = {
>  	{ "8a34001",  RSMU_CM },
>  	{ "82p33810", RSMU_SABRE },
>  	{ "82p33811", RSMU_SABRE },
> -	{ "8v19n850", RSMU_SL },
> -	{ "8v19n851", RSMU_SL },
> +	{ "rc38xxx0", RSMU_FC3 },
> +	{ "rc38xxx1", RSMU_FC3 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, rsmu_i2c_id);
> @@ -347,8 +347,8 @@ static const struct of_device_id rsmu_i2c_of_match[] = {
>  	{ .compatible = "idt,8a34001",  .data = (void *)RSMU_CM },
>  	{ .compatible = "idt,82p33810", .data = (void *)RSMU_SABRE },
>  	{ .compatible = "idt,82p33811", .data = (void *)RSMU_SABRE },
> -	{ .compatible = "idt,8v19n850", .data = (void *)RSMU_SL },
> -	{ .compatible = "idt,8v19n851", .data = (void *)RSMU_SL },
> +	{ .compatible = "idt,rc38xxx0", .data = (void *)RSMU_FC3 },
> +	{ .compatible = "idt,rc38xxx1", .data = (void *)RSMU_FC3 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, rsmu_i2c_of_match);
> diff --git a/include/linux/mfd/rsmu.h b/include/linux/mfd/rsmu.h
> index 0379aa207..b4a90fc81 100644
> --- a/include/linux/mfd/rsmu.h
> +++ b/include/linux/mfd/rsmu.h
> @@ -11,11 +11,11 @@
>  #define RSMU_MAX_WRITE_COUNT	(255)
>  #define RSMU_MAX_READ_COUNT	(255)
>  
> -/* The supported devices are ClockMatrix, Sabre and SnowLotus */
> +/* The supported devices are ClockMatrix, Sabre and FemtoClock3 */
>  enum rsmu_type {
>  	RSMU_CM		= 0x34000,
>  	RSMU_SABRE	= 0x33810,
> -	RSMU_SL		= 0x19850,
> +	RSMU_FC3	= 0x38312,
>  };
>  
>  /**
> -- 
> 2.39.2
> 

-- 
Lee Jones [李琼斯]

