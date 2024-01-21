Return-Path: <linux-kernel+bounces-32022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F18083556A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DBEC1C21053
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3234E364DE;
	Sun, 21 Jan 2024 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="enYY0PYr"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01147364B9;
	Sun, 21 Jan 2024 11:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705835752; cv=none; b=Sa+ckYRZi+qRgIckULKmnjfYG8MzOiVEr4t7uOY3UfMkupU5cgIIMJFsFV8tU6Fi13vVO8fWyCozrjVeHS3RR0reoJAkkPTuSBk8qwmLZzc2tFK9QRGNo3j+xX5vQwTrDCM9f8B34cl0PCGcLmyCzn8oeEEmrPTq/PrC4aVAbxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705835752; c=relaxed/simple;
	bh=BJl6dRunfUdJhmlTiGBxhm3Khy2eKzAexEswACUFpvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDSFsyhNxE2cVv/Kbermh5PYXy/ZDRno6GPGK701ig51aMn4IS5S6N+kBvm3/H3GCnebgMI4rP5MdeAoyvF/pkZcfXP4Loav5Is2pqJTgg0TwhYlcN15iueEt86wJpwu0PBs8DFrPBZAchnxlzK9qJb9qDfm+76JkmJ1cY8BPuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=enYY0PYr; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1705835317; bh=BJl6dRunfUdJhmlTiGBxhm3Khy2eKzAexEswACUFpvQ=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=enYY0PYrFfDg2fge47bPemI8U/Scz2W1AK+j/8fY0K9FuXo3bOKYg4voojmNNkaqT
	 32ffl8bOq9TyIpEVa290gdVT6cTfc7Z0AHtCf/1Rc5l6oLivk2vZ/LG7qO582k3YkX
	 SjR8KCkOdtBnKhDH4FzfI3r2rIn3yV7AWo+wfF2Y=
Date: Sun, 21 Jan 2024 12:08:37 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Aren Moynihan <aren@peacevolution.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Quentin Schulz <quentin.schulz@bootlin.com>, Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 3/3] power: supply: axp20x_usb_power: set input current
 limit in probe
Message-ID: <tgejuevbkneg5vmo7lnxf7ml3z2g3jcjweii7lxqp5lrxs6srd@la3rdfiiqbun>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Aren Moynihan <aren@peacevolution.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Quentin Schulz <quentin.schulz@bootlin.com>, Sebastian Reichel <sre@kernel.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240121014057.1042466-1-aren@peacevolution.org>
 <20240121014057.1042466-7-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121014057.1042466-7-aren@peacevolution.org>

Hello Aren,

On Sat, Jan 20, 2024 at 08:40:04PM -0500, Aren Moynihan wrote:
> axp803 sets the current limit to 3A by default if it doesn't detect a
> battery. The datasheet says that reg 0x2D bit 6 is used to indicate
> first power on status. According to it, if that bit is 0 and the
> battery is not detected, it will set the input current limit to 3A,
> however setting that bit to 1 doesn't to prevent the pmic from setting
> the current limit to 3A.
> 
> Fixes: c279adafe6ab ("power: supply: axp20x_usb_power: add support for AXP813")
> 
> Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> ---
> I'm not sure if the pmic simply ignores the first power on field, or if
> it needs to be set in a specific way / at a specific time. I tried
> setting it in arm-trusted-firmware, and the pmic still set the input
> current limit to 3A.
> 
> The datasheet for axp813 says it has the same first power on bit, but I
> don't have hardware to test if it behaves the same way. This driver uses
> the same platform data for axp803 and axp813.
> 
>  drivers/power/supply/axp20x_usb_power.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
> index 5656f6e57d54..95b136ee20f2 100644
> --- a/drivers/power/supply/axp20x_usb_power.c
> +++ b/drivers/power/supply/axp20x_usb_power.c
> @@ -52,6 +52,7 @@ struct axp_data {
>  	const int			*curr_lim_table;
>  	int				input_curr_lim_table_size;
>  	const int			*input_curr_lim_table;
> +	int				force_input_curr_lim;
>  	struct reg_field		curr_lim_fld;
>  	struct reg_field		input_curr_lim_fld;
>  	struct reg_field		vbus_valid_bit;
> @@ -599,6 +600,7 @@ static const struct axp_data axp813_data = {
>  	.input_curr_lim_table_size = ARRAY_SIZE(axp_813_usb_input_curr_lim_table),
>  	.input_curr_lim_table = axp_813_usb_input_curr_lim_table,
>  	.input_curr_lim_fld = REG_FIELD(AXP22X_CHRG_CTRL3, 4, 7),
> +	.force_input_curr_lim = 500000,
>  	.usb_bc_en_bit	= REG_FIELD(AXP288_BC_GLOBAL, 0, 0),
>  	.usb_bc_det_fld = REG_FIELD(AXP288_BC_DET_STAT, 5, 7),
>  	.vbus_disable_bit = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 7, 7),
> @@ -786,6 +788,17 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
>  			return ret;
>  	}
>  
> +	if (power->axp_data->force_input_curr_lim) {
> +		/*
> +		 * Certain chips set the input current limit to 3A when there is
> +		 * no battery connected. Normally the default is 500mA.
> +		 */
> +		ret = axp20x_usb_power_set_input_current_limit(power,
> +				power->axp_data->force_input_curr_lim);
> +		if (ret)
> +			return ret;
> +	}

This will break the usecase of powering Pinephone from USB without a battery
present (or fully discharged).

The phone can require more than 500mA before USB power supply detection manages
to run and sets the higher limit. Linux should keep the limit set by the
bootloader until it figures out something better based on BC 1.2 or USB-PD.

You should only change the limit as the result of negotiation.

Kind regards,
	o.

>  	if (power->usb_bc_en_bit) {
>  		/* Enable USB Battery Charging specification detection */
>  		ret = regmap_field_write(power->usb_bc_en_bit, 1);
> -- 
> 2.43.0
> 

