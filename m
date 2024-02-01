Return-Path: <linux-kernel+bounces-48927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B33F846348
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D42E1C25230
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839F8405CF;
	Thu,  1 Feb 2024 22:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvdlH42R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1A647F66;
	Thu,  1 Feb 2024 22:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706825514; cv=none; b=N3elQRHmnlr9HbCvKZ0+lsZ0lAVeTYHbCmhYIdW6aOLORgkbqJHX5IxJv/LnBE/WRg4QkwUzUGiUoEEt4mbGE40nGsbcG+N/Wz7ZRR5YEhD4b7UT8ASbvI06at7FkljFBJvuOC+v63nPGpQvdecunluo44ro86oJgBrusCZZv/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706825514; c=relaxed/simple;
	bh=bfnUreV/nfXZCXmsG8UmyxaFFTMZMOyL4FzIFxDA/0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqr4Dhxo8FFpg+m+RyGV2HaYYFLErrdl+rmVwlrb6HkZBtQ0qGasGjGwVzf1r2gDrqD0KyU68lsPPyHbBXP1ibyZMkoP4FcAYQFA/RHvjZ5+1+2Wl6rXeIUwoTcBjUm31MuZRkqqXMco0QB+OqCpL9ettTFdQeJ7kpiaxZFi4S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvdlH42R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7F2C433F1;
	Thu,  1 Feb 2024 22:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706825514;
	bh=bfnUreV/nfXZCXmsG8UmyxaFFTMZMOyL4FzIFxDA/0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YvdlH42R3T8o8N6i01fGZzSN2cfZ8W1Ut9gtlDBu5A+18in3IR5daIFcgiPJXu0ez
	 dRk+Y8eiv0BJEx1Q4KzGis4ZyB7k4ZyAjvuSna7zEdXN7a5i1Kuq7bdJEPvPHlxMTK
	 o8ChWpwuXeXoU8nhaLqlSqe1MLTIaoVaIchVaxGS8tZ9WjzrKVuEFmfS4Wbuzu756E
	 K08W6i99O2Z2t84jcEaFAfMzA5ENxEsRBTqJI7imaAcz0wD0yjfCwubVwXJFzLIVc5
	 23KjBCbOxe8/A+p3WBRAWQ7H7YkcRswgw9GHJUshC+PFWPtAF4vPELdMZp9ZxBNTUv
	 aoMgtTfcLs0YA==
Date: Thu, 1 Feb 2024 16:11:51 -0600
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: dt-bindings: gpio-regulator: Fix
 {gpios-,}states limits
Message-ID: <20240201221151.GA1562458-robh@kernel.org>
References: <cover.1706802756.git.geert+renesas@glider.be>
 <b20aab137058c02ab5af9aaa1280729a02c6ea49.1706802756.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b20aab137058c02ab5af9aaa1280729a02c6ea49.1706802756.git.geert+renesas@glider.be>

On Thu, Feb 01, 2024 at 04:58:41PM +0100, Geert Uytterhoeven wrote:
> make dtbs_check:
> 
>     arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dtb: regulator-vccq-sdhi0: Unevaluated properties are not allowed ('gpios-states', 'states' were unexpected)
> 	    from schema $id: http://devicetree.org/schemas/regulator/gpio-regulator.yaml#

Unevaluated properties warning here is not interesting. If a property 
fails validation, then it is considered unevaluated. It's that warning 
which is interesting:

arch/arm64/boot/dts/renesas/r8a77951-salvator-xs.dtb: regulator-vccq-sdhi0: gpios-states:0: [1] is too short
        from schema $id: http://devicetree.org/schemas/regulator/gpio-regulator.yaml#

> 
> The number of items in "gpios-states" must match the number of items in
> "gpios", so their limits should be identical.
> 
> The number of items in "states" must lie within the range from zero up
> to 2^{number of gpios}.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> The second issue did not cause any dtbs_check errors?

I'm not seeing 'states' fail, but it looks like you did? Is that the 
issue you mean? Looks like in the matrix case, we're now setting 
minItems if unspecified.

> ---
>  .../devicetree/bindings/regulator/gpio-regulator.yaml         | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/gpio-regulator.yaml b/Documentation/devicetree/bindings/regulator/gpio-regulator.yaml
> index f4c1f36e52e9c3d8..1cecf8faee5dc374 100644
> --- a/Documentation/devicetree/bindings/regulator/gpio-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/gpio-regulator.yaml
> @@ -47,6 +47,7 @@ properties:
>          1: HIGH
>        Default is LOW if nothing else is specified.
>      $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
>      maxItems: 8
>      items:
>        enum: [0, 1]
> @@ -57,7 +58,8 @@ properties:
>        regulator and matching GPIO configurations to achieve them. If there are
>        no states in the "states" array, use a fixed regulator instead.
>      $ref: /schemas/types.yaml#/definitions/uint32-matrix
> -    maxItems: 8
> +    minItems: 0
> +    maxItems: 256
>      items:
>        items:
>          - description: Voltage in microvolts
> -- 
> 2.34.1
> 

