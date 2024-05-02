Return-Path: <linux-kernel+bounces-166242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC6F8B97F1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810C02821A5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FCB55E48;
	Thu,  2 May 2024 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2rOjOjg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986F95644E;
	Thu,  2 May 2024 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642797; cv=none; b=W8ZKWdAPKw2m3gREZ/lU6a1xvzsOU0r07szqEdguxh6VEHOqryvvqtaR89qrV2puwajPHca3/1QnX2+0X7QkA+umXU8GUQcrhhA0GETZ1fBlbssAjAjggm2YpGSVje0v0DrXyHaDBZQruw4IhBcXLwGggljr7vtse3W+VTpB2fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642797; c=relaxed/simple;
	bh=XDreVcdgnb4l0AWnp6PwxBkkaLG6fyoUycyBhaa5yiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXxcaczK7Q4trYP88zDI7BVgiUIDCppU1MDc8qe6VZS4GEhmHb3ZsMtmi0Q3GVB70eAwbNnvIfYkWM+kqxftbbzKHRSHhG49+2Ym9YfIyzZmQzswIKxgOvmqFxTvqU6LZjzlfZZAQdg1mEhedM59Yi+2kui10t2tcHRaQIKknJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2rOjOjg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BE1C113CC;
	Thu,  2 May 2024 09:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714642797;
	bh=XDreVcdgnb4l0AWnp6PwxBkkaLG6fyoUycyBhaa5yiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N2rOjOjgtYJSRh337e2p9IwcmxZNUiOdIerlCneKZN3nmsaFQitCLjbaXkBBw/skF
	 HfuArGSyUfj9S9dOnV9zI2azMvVg/iGu4wGVaGgtl10EQ2BkLq916FLydbsw6n8gtm
	 2RH2u65lwecEjEfru3Kd4r/1kgT6DuKOUy7kvw2WWP2GFoEB1/OXE5EZGaVO/Y1ngu
	 z9nIxGvnsMT3zdTfA60Y5xOmcWUFetW0AelEXOvKbtfxUZ1SO71Ea9RYYoCwkH8aTQ
	 mSdNi1ewyi65YUrpNyc+cl7OIJuTtuz+1tuUkRpIDHc8e28IW/JXrYOegwBSDZ1a5F
	 ZXzgTHRUzaCLQ==
Date: Thu, 2 May 2024 10:39:51 +0100
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
Subject: Re: [PATCH v2 3/5] dt-bindings: mfd: x-powers,axp152: add boost
 regulator
Message-ID: <20240502093951.GO5338@google.com>
References: <20240418000736.24338-1-andre.przywara@arm.com>
 <20240418000736.24338-4-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418000736.24338-4-andre.przywara@arm.com>

On Thu, 18 Apr 2024, Andre Przywara wrote:

> The X-Powers AXP717 contains a boost regulator, that it meant to provide
> the 5V USB VBUS voltage when the devices operates on battery.
> 
> Add the name "boost" to the regexp describing the allowed node names,
> to allow the regulator to be described in the devicetree.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Lee Jones <lee@kernel.org>

> diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> index b8e8db0d58e9c..14ab367fc8871 100644
> --- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> +++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> @@ -274,7 +274,7 @@ properties:
>            Defines the work frequency of DC-DC in kHz.
>  
>      patternProperties:
> -      "^(([a-f])?ldo[0-9]|dcdc[0-7a-e]|ldo(_|-)io(0|1)|(dc1)?sw|rtc(_|-)ldo|cpusldo|drivevbus|dc5ldo)$":
> +      "^(([a-f])?ldo[0-9]|dcdc[0-7a-e]|ldo(_|-)io(0|1)|(dc1)?sw|rtc(_|-)ldo|cpusldo|drivevbus|dc5ldo|boost)$":
>          $ref: /schemas/regulator/regulator.yaml#
>          type: object
>          unevaluatedProperties: false
> -- 
> 2.35.8
> 

-- 
Lee Jones [李琼斯]

