Return-Path: <linux-kernel+bounces-40092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3634C83DA21
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6881E1C22FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AA518E29;
	Fri, 26 Jan 2024 12:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="js/pC6R3"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105761803E;
	Fri, 26 Jan 2024 12:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706272057; cv=none; b=ADSHvOfaSjWEQsELqflbd9Obq1s8z6f5OtpMejVr4Y6wkM59TixGEEIX8VEqY7hu7Ad2JElnl79iHOY2swIokEO6mKxj6aNOkLbFlryZqSbC8gtza5Gu3p0rI0kT3bhRy7DuoklaIkRLK1jsNAdvJrLfKlLJGjE2gppPeV9152w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706272057; c=relaxed/simple;
	bh=KA05afh1+3sfbcKyDuyuFL2hqhLhvNewNqmQTsDO5T0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9CfEF6nu0UH7Feuchs2BDfi92RJGDXW7A0MOvdidLTe3IMZY7ntiAt5uwOS+Av1S9P0jjF5Tv+ejRdX4+zz7aDutZIrob4wBNPb8pVVAB1Wbptrmszv4Vnn+3YjKvz1iDKu5JeZB8K29luqGRIlUX/Q+I/6zQkaCfHJRQjH2mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=js/pC6R3; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 0CF4823298;
	Fri, 26 Jan 2024 13:27:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1706272044;
	bh=WEvYxyv4AaxaAKscG9gxq+rXAKFPX6EAGGEoH3y++zM=; h=From:To:Subject;
	b=js/pC6R3Lh09GKBK4dceP/e9RsD2Sn/ctdz/R8jUego37LSKkS6YQaoau0XCNO7EG
	 r62Xq+mG7vtm7t+EPGa5OTgn883EEUIa0aNJoO31RS3p42F56cPEACyMQiJVys6WcE
	 UL1+y0gPaDJLApEKEfyh6H20lDJigb29bQqeeYYDkB+uel3QwlOgQZW0X1IC2J7A60
	 lVA86dO2di3zhPkkKugDJjQNJ4wbKnuFPWnbE2+t22KzM+yxZPy1MvBXSVpLoP0Izn
	 6b4ehYZNQBCLstWvoSNrTMBIwv041Cb4jt7VyWp/Nh3HwkdnZxLKEFi5+jBz91244b
	 jQh5il7YEmyCg==
Date: Fri, 26 Jan 2024 13:27:19 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Peng Fan <peng.fan@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] gpio: vf610: allow disabling the vf610 driver
Message-ID: <20240126122719.GA13659@francesco-nb>
References: <20240124205900.14791-1-martin@kaiser.cx>
 <20240124205900.14791-2-martin@kaiser.cx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124205900.14791-2-martin@kaiser.cx>

On Wed, Jan 24, 2024 at 09:58:57PM +0100, Martin Kaiser wrote:
> The vf610 gpio driver is enabled by default for all i.MX machines,
> without any option to disable it in a board-specific config file.
> 
> Most i.MX chipsets have no hardware for this driver. Change the default
> to enable GPIO_VF610 for SOC_VF610 and disable it otherwise.
> 
> Add a text description after the bool type, this makes the driver
> selectable by make config etc.
> 
> Fixes: 30a35c07d9e9 ("gpio: vf610: drop the SOC_VF610 dependency for GPIO_VF610")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> v4:
>  - add a new patch to enable COMPILE_TEST
> 
> v3:
>  - split the changes into three patches
> 
> v2:
>  - enable the vf610 gpio driver in the defconfig files for arm_v7
>    (i.MX7ULP) and arm64 (i.MX8QM, DXL, ULP and i.MX93)
> 
>  drivers/gpio/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 1301cec94f12..353af1a4d0ac 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -711,7 +711,8 @@ config GPIO_UNIPHIER
>  	  Say yes here to support UniPhier GPIOs.
>  
>  config GPIO_VF610
> -	def_bool y
> +	bool "VF610 GPIO support"
> +	default y if SOC_VF610

any reason for having this default y for SOC_VF610, but not for the
other SOC that uses the same variant (i.MX7ULP, ... ?).

Francesco


