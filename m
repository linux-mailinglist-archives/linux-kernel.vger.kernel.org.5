Return-Path: <linux-kernel+bounces-167470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A788BA9F4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423E31F217FA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3996114F136;
	Fri,  3 May 2024 09:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoiDuEgm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1F7139CE5
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 09:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714728968; cv=none; b=I3ia5J5vBS0/Ylk2nUxgfK4uvIWMFUXRuF+noWaAFMg7xvnNQ759Bc5QS+G5VSuW4m92apUABadsUsueRSggTj8Ibgald/OARjeXYWl+UT1FVtZggZgZ5XiJ7ND9T6aMV5+l3lc4CoH/vEBj7tjrNHOkUu+N55PFHODxbQ6aefU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714728968; c=relaxed/simple;
	bh=C7XFDo4hhiACl+wVIfnERAMzvyYgBlfRWYA4uR9ogoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DB0/wOGqORkNBE3SYmQRlW2mIRZHvajfA3RmUv7jxFMf21htKgNAz66PVbCOpm89HghFOOFowt0Bso51loqNZ9A19gDW6olo3frR0bdPNe9Va7UlUsFvC/9ZMlcq8EP8iApmZlr0b9+AJIdS0kXU1hqAx8tB1xZGGmx5tanywFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoiDuEgm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA79C116B1;
	Fri,  3 May 2024 09:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714728968;
	bh=C7XFDo4hhiACl+wVIfnERAMzvyYgBlfRWYA4uR9ogoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YoiDuEgmZP4OHd6tzTBJp2IDJbnEtbOVIoWIW/7FPn42N/58Iv4DJbfYojxxa/42W
	 7us0UDc9GG+RrNA9/msNveq14y+0ljSxJyzdIjzJklBqAsEPwrFpgHWMbFbwa0sRBO
	 u+VvWOsNjEq85ENtvIW6Ehvuo+tu+BwAJvhBb9F6LTv68ksWbNXtYhnsArN4F1iJN3
	 rpZuGo12J3izh9hLpR0L7D02EjFVNf5G3tmlLuTYfcwQ2J3GNu5TvLuZ6llKDRy47v
	 eJaAUDIiMT0Yg5pXgGeQdZqiL/bV6Nx/PVjaU41O9nlCcrUvd1hiBF6qdtmcE+zKnR
	 SlOMfmXjAqwGA==
Date: Fri, 3 May 2024 10:36:04 +0100
From: Lee Jones <lee@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: linux-kernel@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH mfd v2 2/2] mfd: rsmu: add FemtoClock3 support
Message-ID: <20240503093604.GO1227636@google.com>
References: <20240501163256.28463-1-lnimi@hotmail.com>
 <LV3P220MB120270F8FC18DCCCFD534D82A0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <LV3P220MB120270F8FC18DCCCFD534D82A0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>

On Wed, 01 May 2024, Min Li wrote:

> From: Min Li <min.li.xe@renesas.com>
> 
> The RENESAS FemtoClock3 Wireless is a high-performance
> jitter attenuator, frequency translator, and clock
> synthesizer. This patch only adds I2C bus access for
> FemtoClock3 through REGMAP.

Nit: Choose a better place to line wrap.

This block looks odd squished like that.

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

No explanation is provided for this name change.

How is this okay?

What happened to SnowLotus?

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

