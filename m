Return-Path: <linux-kernel+bounces-32038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285BD835597
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B2A1C20BE8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 11:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBE136AFD;
	Sun, 21 Jan 2024 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="Kn4NHR4j"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A736364DB;
	Sun, 21 Jan 2024 11:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705838150; cv=none; b=lK/kab8iT3cS0h/xGkToXVyOXcURDxAv1PU3Wyeo0OmZKIend2xMR22So9iU9ZgKOeoJ5JJKmbzv9f8uaUXigo0Z8uO7QaH7/pdO7M0iDlT+Eg2NTNY4uQyVGy+h70qbAv70JPsevn9Vp3dIH3c88SMRcBSPYzDgipKQ2niL1Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705838150; c=relaxed/simple;
	bh=VgT/ghWM9Rl0uTNRGxHSL3MLjQYvVBrjftEsvy2LytQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mrjs6fLc9m2uapTGtKdpCvSV3K6IJI/WDwAj7JHQRmlO8/In6KkziifOxP099PQ4euyyLOJVBJfud9iEjVQhXrPV5eH4/ANmvFg2pE8QbHebcQlDAtESyK4MPKgTtFMGZ8c2hFEJpjMXQ30F31K551l2UqnmLMd9p6gdfwOtBFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=Kn4NHR4j; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1705838145; bh=VgT/ghWM9Rl0uTNRGxHSL3MLjQYvVBrjftEsvy2LytQ=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=Kn4NHR4jpd+CKkKFE49IyQqnoq3JTaeBXJLkMRFN4NqCp3HGYh8j6y2ELyY5CPBUi
	 WuJSklx5BVYnqH8o33UVzaVzUCMNoVD+LSAQYhFS0x5y1BSI/dNQR92/xBk8zHdfKk
	 SXytiTi5hJ8EeUD7hOlKvCk3oIGSkRShl7Rvlia8=
Date: Sun, 21 Jan 2024 12:55:43 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Aren Moynihan <aren@peacevolution.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/3] power: supply: axp20x_usb_power: enable usb_type
 reporting
Message-ID: <yltrgkwj3evlyj6lu6ltdk2kg5bchtzginpx7dyblt6aqtdzwp@noczofep5o5b>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Aren Moynihan <aren@peacevolution.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Sebastian Reichel <sre@kernel.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240121014057.1042466-1-aren@peacevolution.org>
 <20240121014057.1042466-5-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240121014057.1042466-5-aren@peacevolution.org>

Hello Aren,

On Sat, Jan 20, 2024 at 08:40:02PM -0500, Aren Moynihan wrote:
> Axp803 and axp813 can report the detected usb bc mode. SDP, CDP, and DCP
> are supported.
> 
> Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> ---
> 
>  drivers/power/supply/axp20x_usb_power.c | 52 +++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
> index 8c0c2c25565f..5656f6e57d54 100644
> --- a/drivers/power/supply/axp20x_usb_power.c
> +++ b/drivers/power/supply/axp20x_usb_power.c
> @@ -57,6 +57,7 @@ struct axp_data {
>  	struct reg_field		vbus_valid_bit;
>  	struct reg_field		vbus_mon_bit;
>  	struct reg_field		usb_bc_en_bit;
> +	struct reg_field		usb_bc_det_fld;
>  	struct reg_field		vbus_disable_bit;
>  	bool				vbus_needs_polling: 1;
>  };
> @@ -69,6 +70,7 @@ struct axp20x_usb_power {
>  	struct regmap_field *vbus_valid_bit;
>  	struct regmap_field *vbus_mon_bit;
>  	struct regmap_field *usb_bc_en_bit;
> +	struct regmap_field *usb_bc_det_fld;
>  	struct regmap_field *vbus_disable_bit;
>  	struct power_supply *supply;
>  	const struct axp_data *axp_data;
> @@ -197,6 +199,37 @@ axp20x_usb_power_get_input_current_limit(struct axp20x_usb_power *power,
>  	return 0;
>  }
>  
> +static int axp20x_get_usb_type(struct axp20x_usb_power *power,
> +			       union power_supply_propval *val)
> +{
> +	unsigned int reg;
> +	int ret;
> +
> +	if (!power->usb_bc_det_fld)
> +		return -EINVAL;

What if detection is disabled becase custom input current limit was set by the
user? Does the HW keep the result of previous detection in the register?

Kind regards,
	Ondrej

> +	ret = regmap_field_read(power->usb_bc_det_fld, &reg);
> +	if (ret)
> +		return ret;
> +
> +	switch (reg) {
> +	case 1:
> +		val->intval = POWER_SUPPLY_USB_TYPE_SDP;
> +		break;
> +	case 2:
> +		val->intval = POWER_SUPPLY_USB_TYPE_CDP;
> +		break;
> +	case 3:
> +		val->intval = POWER_SUPPLY_USB_TYPE_DCP;
> +		break;
> +	default:
> +		val->intval = POWER_SUPPLY_USB_TYPE_UNKNOWN;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>  static int axp20x_usb_power_get_property(struct power_supply *psy,
>  	enum power_supply_property psp, union power_supply_propval *val)
>  {
> @@ -266,6 +299,8 @@ static int axp20x_usb_power_get_property(struct power_supply *psy,
>  	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
>  		return axp20x_usb_power_get_input_current_limit(power,
>  								&val->intval);
> +	case POWER_SUPPLY_PROP_USB_TYPE:
> +		return axp20x_get_usb_type(power, val);
>  	default:
>  		break;
>  	}
> @@ -423,6 +458,14 @@ static enum power_supply_property axp813_usb_power_properties[] = {
>  	POWER_SUPPLY_PROP_VOLTAGE_MIN,
>  	POWER_SUPPLY_PROP_CURRENT_MAX,
>  	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +	POWER_SUPPLY_PROP_USB_TYPE,
> +};
> +
> +static enum power_supply_usb_type axp813_usb_types[] = {
> +	POWER_SUPPLY_USB_TYPE_SDP,
> +	POWER_SUPPLY_USB_TYPE_DCP,
> +	POWER_SUPPLY_USB_TYPE_CDP,
> +	POWER_SUPPLY_USB_TYPE_UNKNOWN,
>  };
>  
>  static const struct power_supply_desc axp20x_usb_power_desc = {
> @@ -453,6 +496,8 @@ static const struct power_supply_desc axp813_usb_power_desc = {
>  	.property_is_writeable = axp20x_usb_power_prop_writeable,
>  	.get_property = axp20x_usb_power_get_property,
>  	.set_property = axp20x_usb_power_set_property,
> +	.usb_types = axp813_usb_types,
> +	.num_usb_types = ARRAY_SIZE(axp813_usb_types),
>  };
>  
>  static const char * const axp20x_irq_names[] = {
> @@ -555,6 +600,7 @@ static const struct axp_data axp813_data = {
>  	.input_curr_lim_table = axp_813_usb_input_curr_lim_table,
>  	.input_curr_lim_fld = REG_FIELD(AXP22X_CHRG_CTRL3, 4, 7),
>  	.usb_bc_en_bit	= REG_FIELD(AXP288_BC_GLOBAL, 0, 0),
> +	.usb_bc_det_fld = REG_FIELD(AXP288_BC_DET_STAT, 5, 7),
>  	.vbus_disable_bit = REG_FIELD(AXP20X_VBUS_IPSOUT_MGMT, 7, 7),
>  	.vbus_needs_polling = true,
>  };
> @@ -708,6 +754,12 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	ret = axp20x_regmap_field_alloc_optional(&pdev->dev, power->regmap,
> +						 axp_data->usb_bc_det_fld,
> +						 &power->usb_bc_det_fld);
> +	if (ret)
> +		return ret;
> +
>  	ret = axp20x_regmap_field_alloc_optional(&pdev->dev, power->regmap,
>  						 axp_data->vbus_disable_bit,
>  						 &power->vbus_disable_bit);
> -- 
> 2.43.0
> 

