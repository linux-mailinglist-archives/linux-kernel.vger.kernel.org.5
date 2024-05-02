Return-Path: <linux-kernel+bounces-166240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B058B97EE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4BEB1C222CD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2033C55C3A;
	Thu,  2 May 2024 09:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WR6c0ach"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4E754747;
	Thu,  2 May 2024 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642774; cv=none; b=QT18sG0EQtvmIHyGXRtKErG/D9HjpxA3WwQ04cGJCu4c/gJxTWDKyOSJmEhigXeGHP/e/dOBMnVpR/j46VRoGu+Wl+tiFf0cDWNI++YUYU1U3OGTszFJY3BP1Xj/X63hitG1q3TXoIgsWExDJbcpAKouYY68vHSFKWX04e1clMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642774; c=relaxed/simple;
	bh=+6Ccg1WrPBmta14Ehps1oyUTy8o9qKi/CgRkjuvTG9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMjq+MqGY2JwR2SvOl770FKs1EnDVF3odvMXlNcsdiBZD1F9EhTKmH2JY9JVOpRuk2lZg7Tw1g+uKCLpFnyBU7vh5ncp3iHmJ2RcGwuVpbygXnfp/eLXqRc0sF5uL3o7ZxUOZ+u5Fy5to/wTjS9LPFsi5774AWzxj2q1DTYIOiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WR6c0ach; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232B8C113CC;
	Thu,  2 May 2024 09:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714642773;
	bh=+6Ccg1WrPBmta14Ehps1oyUTy8o9qKi/CgRkjuvTG9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WR6c0achz1dfiNbXcWotZoYVheq17pTQDYO8y7R8VOfN/HCJervtkTRPu6szOlTgK
	 m1oNeSSbcZ6rBoa+po2Hi6dBNCeiZV4WwpbhyHj4Jqgkd+3c+VUukBRUIJkNz2SnU0
	 wMcY3D5HtItbuLIEQPyPX359VXxYPfD6RIGQzH8opEOrggYozHxuQCM7/psjds3Pi+
	 w9q4w/Gj7SunQg5XynsmoEVcRoBY+/w4TCJG46HX8Oy3iA6Il+yFdAKfuFBxX6tRLy
	 CRowyM22ZVsdP/2/prlHcoulHITRSk542Y1peCKZ/XmjL5D2M6/yICDxPA2i0RWIpx
	 uuWOohWqcAquQ==
Date: Thu, 2 May 2024 10:39:28 +0100
From: Lee Jones <lee@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Ryan Walklin <ryan@testtoast.com>,
	Chris Morgan <macroalpha82@gmail.com>
Subject: Re: [PATCH v2 4/5] mfd: axp20x: AXP717: Add support for boost
 regulator
Message-ID: <20240502093928.GN5338@google.com>
References: <20240418000736.24338-1-andre.przywara@arm.com>
 <20240418000736.24338-5-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418000736.24338-5-andre.przywara@arm.com>

On Thu, 18 Apr 2024, Andre Przywara wrote:

> The AXP717 also contains a boost regulator, to provide the 5V USB VBUS
> rail when running on battery.
> 
> Add the registers to the MFD description to be able to use them from the
> regulator driver.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: John Watts <contact@jookia.org>
> ---
>  drivers/mfd/axp20x.c       | 2 ++
>  include/linux/mfd/axp20x.h | 2 ++
>  2 files changed, 4 insertions(+)

Acked-by: Lee Jones <lee@kernel.org>

> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index d8ad4e120d379..02513b1eff2e8 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -209,6 +209,8 @@ static const struct regmap_access_table axp313a_volatile_table = {
>  };
>  
>  static const struct regmap_range axp717_writeable_ranges[] = {
> +	regmap_reg_range(AXP717_MODULE_EN_CONTROL, AXP717_MODULE_EN_CONTROL),
> +	regmap_reg_range(AXP717_BOOST_CONTROL, AXP717_BOOST_CONTROL),
>  	regmap_reg_range(AXP717_IRQ0_EN, AXP717_IRQ4_EN),
>  	regmap_reg_range(AXP717_IRQ0_STATE, AXP717_IRQ4_STATE),
>  	regmap_reg_range(AXP717_DCDC_OUTPUT_CONTROL, AXP717_CPUSLDO_CONTROL),
> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index 8c0a33a2e9ce2..4dad54fdf67ee 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -115,6 +115,8 @@ enum axp20x_variants {
>  #define AXP313A_IRQ_STATE		0x21
>  
>  #define AXP717_ON_INDICATE		0x00
> +#define AXP717_MODULE_EN_CONTROL	0x19
> +#define AXP717_BOOST_CONTROL		0x1e
>  #define AXP717_IRQ0_EN			0x40
>  #define AXP717_IRQ1_EN			0x41
>  #define AXP717_IRQ2_EN			0x42
> -- 
> 2.35.8
> 

-- 
Lee Jones [李琼斯]

