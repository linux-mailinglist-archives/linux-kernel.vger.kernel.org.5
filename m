Return-Path: <linux-kernel+bounces-154347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B838ADB05
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03FAA1C20E5E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A658017BA0;
	Tue, 23 Apr 2024 00:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b="sdTj0rJt"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D9C134C6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 00:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713831038; cv=none; b=YQo8dkt/kZFf/qpUCHurDZmkBg4OLvTu1f7Yem7DqGRbBALaNIBZ9gG9lUTUzgWO+SGjOebsRvzg4CioOy+nB8GSBZ/VHqR8Sngr9zTzRikxRKClNGX22m2AL/32emHS3O1PGSLY/xfrGnmE5kM1O5srHdfGyOKYHCZ2hjfXxXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713831038; c=relaxed/simple;
	bh=DddfLvBrYl9mrWkgY8ASnmpcK/f4Mq5McEMvf2HvzZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0rfVz8a8gTYGzEa0OUxHl9qUtKXd3Nxn5hHhCbS581yegcpEBKAk+M9TBZkwQIc7RjUwBqfIh815M4bVbHtimBotkNC5pdptHn2QuRIVIRXcBQ+2rwwVOKC+R1zy4jOHmcBt99v3p7SGWq3qiKlQnGqWDCqkLMuadaX8mkajBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org; spf=none smtp.mailfrom=jookia.org; dkim=pass (2048-bit key) header.d=jookia.org header.i=@jookia.org header.b=sdTj0rJt; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jookia.org
Date: Tue, 23 Apr 2024 10:09:12 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
	t=1713831034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wxMsnwwgYTRpN+n1pAjIWgxOeAtkZF/bH9vNkvOLnY8=;
	b=sdTj0rJtuoSGbqhR8idHk8Cp/R6XUfuuNCggnswID6iZ94iIvEg1Jb3xnE8uLJnj+vupOt
	Vt91S+1GWsKuWilWbXyMaJ1m4SDb8y7swQ1H+cc3lvxvg6qk9NKP36U/hVFNNChssonsJD
	D1CFHCxU734bS7q+2y5Q07z78DA7+yFvknKDRfaRMMBahqSk8YqdX6KY1Ys02tYPvTZcVj
	BZWjbR98/9tth+DqrFcXCcRn6cCaTpKWWycqvSNuWPVvCuHb6pM4sdJejls3dp55y6xu9l
	mFSFOvXUF3wF/Swfiq/o7ZyhoxbWvPIoUFXD8p9Ce6UpIBwslZ5EEFQYbc2AJA==
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
Subject: Re: [PATCH v2 2/5] regulator: axp20x: AXP717: fix LDO supply rails
 and off-by-ones
Message-ID: <Zib8KOXwqJT3ftHm@titan>
References: <20240418000736.24338-1-andre.przywara@arm.com>
 <20240418000736.24338-3-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418000736.24338-3-andre.przywara@arm.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 18, 2024 at 01:07:33AM +0100, Andre Przywara wrote:
> The X-Powers AXP717 PMIC has separate input supply pins for each group
> of LDOs, so they are not all using the same DCDC1 input, as described
> currently.
> 
> Replace the "supply" member of each LDO description with the respective
> group supply name, so that the supply dependencies can be correctly
> described in the devicetree.
> 
> Also fix two off-by-ones in the regulator macros, after some double
> checking the numbers against the datasheet. This uncovered a bug in the
> datasheet: add a comment to document this.

Hi,

This looks a lot better with the comment.

John.

Reviewed-by: John Watts <contact@jookia.org>

> 
> Fixes: d2ac3df75c3a ("regulator: axp20x: add support for the AXP717")
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/regulator/axp20x-regulator.c | 33 ++++++++++++++++------------
>  1 file changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
> index 34fcdd82b2eaa..f3c447ecdc3bf 100644
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
> @@ -763,10 +763,15 @@ static const struct linear_range axp717_dcdc1_ranges[] = {
>  	REGULATOR_LINEAR_RANGE(1220000, 71, 87, 20000),
>  };
>  
> +/*
> + * The manual says that the last voltage is 3.4V, encoded as 0b1101011 (107),
> + * but every other method proves that this is wrong, so it's really 106 that
> + * programs the final 3.4V.
> + */
>  static const struct linear_range axp717_dcdc2_ranges[] = {
>  	REGULATOR_LINEAR_RANGE(500000,   0,  70,  10000),
>  	REGULATOR_LINEAR_RANGE(1220000, 71,  87,  20000),
> -	REGULATOR_LINEAR_RANGE(1600000, 88, 107, 100000),
> +	REGULATOR_LINEAR_RANGE(1600000, 88, 106, 100000),
>  };
>  
>  static const struct linear_range axp717_dcdc3_ranges[] = {
> @@ -790,40 +795,40 @@ static const struct regulator_desc axp717_regulators[] = {
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

