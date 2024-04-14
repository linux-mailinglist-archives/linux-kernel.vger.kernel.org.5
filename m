Return-Path: <linux-kernel+bounces-144030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F738A410D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21884B20FFA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 07:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5014C21345;
	Sun, 14 Apr 2024 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="xjK7upus"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09212225CE
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713081042; cv=none; b=oUmHNXmb73fx9ngsTk7yt/mK9fzLAL5iOj262/LkLCiWtJtUXOsfI2a6R49Hh++XO1EwqCW+rIxfRn0y13x+aab2OPpK/BZr2RC5qiTudG1qpmH+9WpfCJVceS7gu5+bFSkDUdaCVHH7SR6yBxNOnfBfqmLAllsrcTtWG7X1pVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713081042; c=relaxed/simple;
	bh=DlrkisTiYTTNhdGDHEA9kXqEXoDP/oRSivtOzUUYqBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqaMv07ZzOV7qJWtSHOaLwAKQOzxB+yJ/6JvKvXEN0Yl8+bhH9lMNkZoa+AjzRFaZbqJSbEIuHveJOq9SDnVTijJ+tc/YX0kGDCNm6DWgBN/yi14grwumIB8sS8xawkDuiS7AUjNSpgQB6ogv29B474IOHZGEr0vnp5pDrqE0Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=none smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=xjK7upus; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jookia.org
Date: Sun, 14 Apr 2024 17:47:54 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1713081039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J74iIU8vI1GkxvSB3iLi2bj3VeEbcXCRePxliDAEfkk=;
	b=xjK7upus0wE72MAH3FpYhJbFJRk6k9oXuSSdKMhEtwSqzb6/zbXTJo2x9CGLj5QDMURXyU
	QSTxWFQFlOU0lVPAV2lywFp9Fb4QDyDYBSAc5GMPyEf7bkc6Lx4ru8psKHeKM/hT8Lc5r7
	EzVmjdm9jE7Po51IOJpXx1JRfQjSeRmTJDL1rTpakcWi7+/fNuEz4IXDPdd1xEHMcTN3ma
	QckSVOPmOHhm/RXElSn9DzKNQjRwe34mm5LnF+aZ4GNVnL6lWuYfGg4rrfWVjozpIDFFo+
	uM+qCdeCOi2COxRqod7rE93M/ymk1ls8WQjXyfhic0erPV9FttNplLH9YsKK5A==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: John Watts <contact@jookia.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Ryan Walklin <ryan@testtoast.com>,
	Chris Morgan <macroalpha82@gmail.com>
Subject: Re: [PATCH 4/4] regulator: axp20x: AXP717: Add boost regulator
Message-ID: <ZhuKKiRBxb5Cjf9v@titan>
References: <20240329235033.25309-1-andre.przywara@arm.com>
 <20240329235033.25309-5-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329235033.25309-5-andre.przywara@arm.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 29, 2024 at 11:50:33PM +0000, Andre Przywara wrote:
> The AXP717 also contains an adjustable boost regulator, to provide the
> 5V USB VBUS rail when running on battery.
> 
> Add the regulator description that states the voltage range this
> regulator can cover.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Hi,

I checked this against the AXP717 datasheet and it looks correct.

John.

Reviewed-by: John Watts <contact@jookia.org>

> ---
>  drivers/regulator/axp20x-regulator.c | 4 ++++
>  include/linux/mfd/axp20x.h           | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> index 3907606b091f6..71407c5810941 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -143,6 +143,7 @@
>  #define AXP717_DCDC3_NUM_VOLTAGES	103
>  #define AXP717_DCDC_V_OUT_MASK		GENMASK(6, 0)
>  #define AXP717_LDO_V_OUT_MASK		GENMASK(4, 0)
> +#define AXP717_BOOST_V_OUT_MASK		GENMASK(7, 4)
>  
>  #define AXP803_PWR_OUT_DCDC1_MASK	BIT_MASK(0)
>  #define AXP803_PWR_OUT_DCDC2_MASK	BIT_MASK(1)
> @@ -829,6 +830,9 @@ static const struct regulator_desc axp717_regulators[] = {
>  	AXP_DESC(AXP717, CPUSLDO, "cpusldo", "vin1", 500, 1400, 50,
>  		 AXP717_CPUSLDO_CONTROL, AXP717_LDO_V_OUT_MASK,
>  		 AXP717_LDO1_OUTPUT_CONTROL, BIT(4)),
> +	AXP_DESC(AXP717, BOOST, "boost", "vin1", 4550, 5510, 64,
> +		 AXP717_BOOST_CONTROL, AXP717_BOOST_V_OUT_MASK,
> +		 AXP717_MODULE_EN_CONTROL, BIT(4)),
>  };
>  
>  /* DCDC ranges shared with AXP813 */
> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index 4dad54fdf67ee..5e86b976c4caa 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -486,6 +486,7 @@ enum {
>  	AXP717_CLDO3,
>  	AXP717_CLDO4,
>  	AXP717_CPUSLDO,
> +	AXP717_BOOST,
>  	AXP717_REG_ID_MAX,
>  };
>  
> -- 
> 2.35.8
> 

