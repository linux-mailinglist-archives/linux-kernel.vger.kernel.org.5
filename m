Return-Path: <linux-kernel+bounces-144034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BDF8A4119
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C356B21318
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAF421A0D;
	Sun, 14 Apr 2024 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="YjQ0vDqT"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D7A20B12
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713081624; cv=none; b=tKfIorQeGMurqfB0ZuQKcgK4XkGUfW9K7SWrT9K4j8pOHLdLxj+HZD7kOjY8iW+WEhAzVzVi5jDj/iEjcsbfliA8H24nQ3Pw8jQ1nB9h5EWaOagWInHpDrkbn4/zGGjrvKpZwrCeds16jqlLVMphynLTdJG3FJ0D9Np7N7LIYow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713081624; c=relaxed/simple;
	bh=zm9RpGKAoFVClY35GVKJp2e5Go7G/KpaY5NNEyPFbrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oS06jSq5xjwU8pBviETjySeUNxrSi8O6arDb2phaQdLx7vxuyDfkNQNDc7raEaMoO5Tqjm0A2klacpt0efqS0JDbHmgNAXEL51Vm+YGYFhAMo6GKWNyh5zddFDGOz99qtayRAyaRdMFX2VBP0atMkdvL8mijANNk5BjYDxgK0Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=none smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=YjQ0vDqT; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jookia.org
Date: Sun, 14 Apr 2024 18:00:09 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1713081620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sfKDt/wteDbIz5a70amJfBbHPdzo9pYu3x/eiw2iAEw=;
	b=YjQ0vDqTFTO1Q6IIY4iWhHZxwK3Fzbut0Ai0B3RsPmHcUvMWGwWhuFS6dHHD+mWCtCTdpu
	/z+2IWSeHyq0MJTU49dExv1jXlw9B3uUUjGsoY4Yu0RD2TiTnzCpovEbUwiQXhtM0difu5
	lUBbeDC4Wfcmcpdsb8WOenukXgTzzeONrlUzSgPrhAgvqspCaQmbs6ttEENzfaU2v9QmNg
	1DdtMzbsE6MMC/ZBc97wGYWy47M5313hP1T1KRecf/SKeLOvqzEL4KSZTA8h2V0KqaDdAL
	yhWl363C+BNXqCXCW9XN9JHh52DPW9isco8suypKuiBZsNM9639crimJOXcc3A==
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
Subject: Re: [PATCH 1/4] regulator: axp20x: AXP717: fix LDO supply rails and
 off-by-ones
Message-ID: <ZhuNCUnJri4hBOxx@titan>
References: <20240329235033.25309-1-andre.przywara@arm.com>
 <20240329235033.25309-2-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329235033.25309-2-andre.przywara@arm.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 29, 2024 at 11:50:30PM +0000, Andre Przywara wrote:
> The X-Powers AXP717 PMIC has separate input supply pins for each group
> of LDOs, so they are not all using the same DCDC1 input, as described
> currently.
> 
> Replace the "supply" member of each LDO description with the respective
> group supply name, so that the supply dependencies can be correctly
> described in the devicetree.
> Also fix two off-by-ones in the regulator macros, after some double
> checking the numbers against the datasheet.
> 
> Fixes: d2ac3df75c3a ("regulator: axp20x: add support for the AXP717")
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Hi,

> ---
>  drivers/regulator/axp20x-regulator.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> index 34fcdd82b2eaa..3907606b091f6 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -140,7 +140,7 @@
>  
>  #define AXP717_DCDC1_NUM_VOLTAGES	88
>  #define AXP717_DCDC2_NUM_VOLTAGES	107
> -#define AXP717_DCDC3_NUM_VOLTAGES	104
> +#define AXP717_DCDC3_NUM_VOLTAGES	103
>  #define AXP717_DCDC_V_OUT_MASK		GENMASK(6, 0)
>  #define AXP717_LDO_V_OUT_MASK		GENMASK(4, 0)
>  
> @@ -766,7 +766,7 @@ static const struct linear_range axp717_dcdc1_ranges[] = {
>  static const struct linear_range axp717_dcdc2_ranges[] = {
>  	REGULATOR_LINEAR_RANGE(500000,   0,  70,  10000),
>  	REGULATOR_LINEAR_RANGE(1220000, 71,  87,  20000),
> -	REGULATOR_LINEAR_RANGE(1600000, 88, 107, 100000),
> +	REGULATOR_LINEAR_RANGE(1600000, 88, 106, 100000),
>  };

I'm not entirely sure these are correct after reading the datasheet.

From what I can tell REGULATOR_LINEAR_RANGE is inclusive, so for DCDC1
we have these ranges (we agree DCDC1 is correct, it is not affected by
this patch):

#define AXP717_DCDC1_NUM_VOLTAGES	88
static const struct linear_range axp717_dcdc1_ranges[] = {
	REGULATOR_LINEAR_RANGE(500000,   0, 70, 10000),
	REGULATOR_LINEAR_RANGE(1220000, 71, 87, 20000),
};

The datasheet says this for the register:

0.5~1.2V,10mV/step,71steps
1.22~1.54V,20mV/step,17steps
0000000: 0.50V
0000001: 0.51V
..
1000110: 1.20V
1000111: 1.22V
1001000: 1.24V
..
1010111: 1.54V
1011000~1111111: Reserve

Converting to decimal:

0: 0.50V (range 1 start)
1: 0.51V
..
70: 1.20V (range 1 end)
71: 1.22V (range 2 start)
72: 1.24V
..
87: 1.54V (range 2 end)
88 onwards: reserved

The maximum voltages are the last value plus one (to include voltage zero).

For DCDC2 after applying this patch we get:

#define AXP717_DCDC2_NUM_VOLTAGES	107
static const struct linear_range axp717_dcdc2_ranges[] = {
	REGULATOR_LINEAR_RANGE(500000,   0,  70,  10000),
	REGULATOR_LINEAR_RANGE(1220000, 71,  87,  20000),
	REGULATOR_LINEAR_RANGE(1600000, 88, 106, 100000),
};

The datasheet marks the maximum value as 1101011: 3.40V, so 106 (the old
value for range) seems correct, but the NUM_VOLTAGES seems like it
should be bumped up to 108. I think you fixed the wrong thing here.

#define AXP717_DCDC3_NUM_VOLTAGES	103
static const struct linear_range axp717_dcdc2_ranges[] = {
	REGULATOR_LINEAR_RANGE(500000,   0,  70,  10000),
	REGULATOR_LINEAR_RANGE(1220000, 71,  87,  20000),
	REGULATOR_LINEAR_RANGE(1600000, 88, 106, 100000),
};

The datasheet marks the maximum value as 1101011: 3.40V, so 106 (the old
value for range) seems correct, but the NUM_VOLTAGES seems like it
should be bumped up to 108. I think you fixed the wrong thing here.
For DCDC3 after applying this patch we get:

#define AXP717_DCDC3_NUM_VOLTAGES	103
static const struct linear_range axp717_dcdc3_ranges[] = {
	REGULATOR_LINEAR_RANGE(500000,   0,  70, 10000),
	REGULATOR_LINEAR_RANGE(1220000, 71, 102, 20000),
};

The datasheet marks the maximum value as 1100110: 1.84V, which is 102.
So this patch to correct the AXP717_DCDC3_NUM_VOLTAGES is correct here.

John.

>  
>  static const struct linear_range axp717_dcdc3_ranges[] = {
> @@ -790,40 +790,40 @@ static const struct regulator_desc axp717_regulators[] = {
>  	AXP_DESC(AXP717, DCDC4, "dcdc4", "vin4", 1000, 3700, 100,
>  		 AXP717_DCDC4_CONTROL, AXP717_DCDC_V_OUT_MASK,
>  		 AXP717_DCDC_OUTPUT_CONTROL, BIT(3)),
> -	AXP_DESC(AXP717, ALDO1, "aldo1", "vin1", 500, 3500, 100,
> +	AXP_DESC(AXP717, ALDO1, "aldo1", "aldoin", 500, 3500, 100,
>  		 AXP717_ALDO1_CONTROL, AXP717_LDO_V_OUT_MASK,
>  		 AXP717_LDO0_OUTPUT_CONTROL, BIT(0)),
> -	AXP_DESC(AXP717, ALDO2, "aldo2", "vin1", 500, 3500, 100,
> +	AXP_DESC(AXP717, ALDO2, "aldo2", "aldoin", 500, 3500, 100,
>  		 AXP717_ALDO2_CONTROL, AXP717_LDO_V_OUT_MASK,
>  		 AXP717_LDO0_OUTPUT_CONTROL, BIT(1)),
> -	AXP_DESC(AXP717, ALDO3, "aldo3", "vin1", 500, 3500, 100,
> +	AXP_DESC(AXP717, ALDO3, "aldo3", "aldoin", 500, 3500, 100,
>  		 AXP717_ALDO3_CONTROL, AXP717_LDO_V_OUT_MASK,
>  		 AXP717_LDO0_OUTPUT_CONTROL, BIT(2)),
> -	AXP_DESC(AXP717, ALDO4, "aldo4", "vin1", 500, 3500, 100,
> +	AXP_DESC(AXP717, ALDO4, "aldo4", "aldoin", 500, 3500, 100,
>  		 AXP717_ALDO4_CONTROL, AXP717_LDO_V_OUT_MASK,
>  		 AXP717_LDO0_OUTPUT_CONTROL, BIT(3)),
> -	AXP_DESC(AXP717, BLDO1, "bldo1", "vin1", 500, 3500, 100,
> +	AXP_DESC(AXP717, BLDO1, "bldo1", "bldoin", 500, 3500, 100,
>  		 AXP717_BLDO1_CONTROL, AXP717_LDO_V_OUT_MASK,
>  		 AXP717_LDO0_OUTPUT_CONTROL, BIT(4)),
> -	AXP_DESC(AXP717, BLDO2, "bldo2", "vin1", 500, 3500, 100,
> +	AXP_DESC(AXP717, BLDO2, "bldo2", "bldoin", 500, 3500, 100,
>  		 AXP717_BLDO2_CONTROL, AXP717_LDO_V_OUT_MASK,
>  		 AXP717_LDO0_OUTPUT_CONTROL, BIT(5)),
> -	AXP_DESC(AXP717, BLDO3, "bldo3", "vin1", 500, 3500, 100,
> +	AXP_DESC(AXP717, BLDO3, "bldo3", "bldoin", 500, 3500, 100,
>  		 AXP717_BLDO3_CONTROL, AXP717_LDO_V_OUT_MASK,
>  		 AXP717_LDO0_OUTPUT_CONTROL, BIT(6)),
> -	AXP_DESC(AXP717, BLDO4, "bldo4", "vin1", 500, 3500, 100,
> +	AXP_DESC(AXP717, BLDO4, "bldo4", "bldoin", 500, 3500, 100,
>  		 AXP717_BLDO4_CONTROL, AXP717_LDO_V_OUT_MASK,
>  		 AXP717_LDO0_OUTPUT_CONTROL, BIT(7)),
> -	AXP_DESC(AXP717, CLDO1, "cldo1", "vin1", 500, 3500, 100,
> +	AXP_DESC(AXP717, CLDO1, "cldo1", "cldoin", 500, 3500, 100,
>  		 AXP717_CLDO1_CONTROL, AXP717_LDO_V_OUT_MASK,
>  		 AXP717_LDO1_OUTPUT_CONTROL, BIT(0)),
> -	AXP_DESC(AXP717, CLDO2, "cldo2", "vin1", 500, 3500, 100,
> +	AXP_DESC(AXP717, CLDO2, "cldo2", "cldoin", 500, 3500, 100,
>  		 AXP717_CLDO2_CONTROL, AXP717_LDO_V_OUT_MASK,
>  		 AXP717_LDO1_OUTPUT_CONTROL, BIT(1)),
> -	AXP_DESC(AXP717, CLDO3, "cldo3", "vin1", 500, 3500, 100,
> +	AXP_DESC(AXP717, CLDO3, "cldo3", "cldoin", 500, 3500, 100,
>  		 AXP717_CLDO3_CONTROL, AXP717_LDO_V_OUT_MASK,
>  		 AXP717_LDO1_OUTPUT_CONTROL, BIT(2)),
> -	AXP_DESC(AXP717, CLDO4, "cldo4", "vin1", 500, 3500, 100,
> +	AXP_DESC(AXP717, CLDO4, "cldo4", "cldoin", 500, 3500, 100,
>  		 AXP717_CLDO4_CONTROL, AXP717_LDO_V_OUT_MASK,
>  		 AXP717_LDO1_OUTPUT_CONTROL, BIT(3)),
>  	AXP_DESC(AXP717, CPUSLDO, "cpusldo", "vin1", 500, 1400, 50,
> -- 
> 2.35.8
> 

