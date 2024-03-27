Return-Path: <linux-kernel+bounces-121695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF9488EC93
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DA921C31C4F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76CE137C2A;
	Wed, 27 Mar 2024 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSQOu+pd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8C514D426;
	Wed, 27 Mar 2024 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711560282; cv=none; b=Fdj2tvPUdPVNYPsX2ooZo4akm4EYo7bXcLXPmgZkCi/0L/QXfVduktfsrTy3vSwhak14WxoHXSK7CbxdUUt7Yvvou2mReq1TH7PZhmQqOnV3kPFy6uOS3lYXnCLYpsnbOetkX3WdPHkAUeLrh3lDy5GQgJREGTpwBT2bTAzH3GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711560282; c=relaxed/simple;
	bh=etEwvmr8xb/0bk8xdVXxjqJ52tsDAWEL45d5y1fPL8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ds1eTuuUXWNPv5nQcG/X0lElb0Kj7pDCV91dV9IR0Skf48xXGG12tj6JZNFXXjp/EuSXqSr4SPUzPmwiwkYU1xQDKyDWd31i4/Lviq60yeUaGqG0oaDphazs6eaEZTQ9frQMiVqTyLQrdJlo5B1FlREzZkPQwOVY0XTX/S0CcqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSQOu+pd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D67C433C7;
	Wed, 27 Mar 2024 17:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711560281;
	bh=etEwvmr8xb/0bk8xdVXxjqJ52tsDAWEL45d5y1fPL8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GSQOu+pdnlf5J7EOdSMN9x4SGU0C+TbbdSpMxS1tQJlj+d3/Hc6xCFxoGWzjb5Ezp
	 6ROMzMVPh1TIeq2LyNPdFVWlajotTpxzK5B+HUfllN8hifdgtUMEZkBoKu8YiwtWrc
	 ULfmCpXWhDu2kRwsXiVo1eSOzwl94M6JVVI8aFiEY7tSim3Mz7r9xBwmnGyBKXw1E2
	 il+S449VwcNeWXGiqGTN4UxL/6CQwUtZykWMUCtdjk3ffdPsw4uyYwD/3xgQF/pUgw
	 08lZZ9VlcTebUkeUgVFDyQmumjGi8hd93Ib/9MMhT7acei7lm14jD8OprMfcNB+Lfk
	 cVz/2VDHkNGtw==
Date: Wed, 27 Mar 2024 12:24:39 -0500
From: Rob Herring <robh@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [RFC PATCH 02/13] dt-bindings: pinctrl: renesas: Document
 RZ/V2H(P) SoC
Message-ID: <20240327172439.GA3664500-robh@kernel.org>
References: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240326222844.1422948-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326222844.1422948-3-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Tue, Mar 26, 2024 at 10:28:33PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Add documentation for the pin controller found on the Renesas RZ/V2H(P)
> (R9A09G057) SoC. Compared to RZ/G2L family of SoCs there are slight
> differences on the RZ/V2H(P) SoC for pinmuxing.
> 
> Also add 'renesas-rzv2h,output-impedance' property. Drive strength
> setting on RZ/V2H(P) depends on the different power rails which are
> coming out from the PMIC (connected via i2c). These power rails
> (required for drive strength) can be 1.2/1.8/3.3V.
> 
> Pin are grouped into 4 groups,
> 
> Group1: Impedance
> - 150/75/38/25 ohms (at 3.3 V)
> - 130/65/33/22 ohms (at 1.8 V)
> 
> Group2: Impedance
> - 50/40/33/25 ohms (at 1.8 V)
> 
> Group3: Impedance
> - 150/75/37.5/25 ohms (at 3.3 V)
> - 130/65/33/22 ohms (at 1.8 V)
> 
> Group4: Impedance
> - 110/55/30/20 ohms (at 1.8 V)
> - 150/75/38/25 ohms (at 1.2 V)
> 
> 'renesas-rzv2h,output-impedance' property as documented which can be
> [1, 2, 4, 6] indicates x Value strength.

Looks like the values are x1, x1.5, x3ish, x6...

> 
> As the power rail information cannot be available very early in the
> boot process as 'renesas-rzv2h,output-impedance' property is added
> instead of reusing output-impedance-ohms property.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  .../pinctrl/renesas,rzg2l-pinctrl.yaml        | 22 +++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> index 881e992adca3..77f4fc7f4a21 100644
> --- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> @@ -26,6 +26,7 @@ properties:
>                - renesas,r9a07g043-pinctrl # RZ/G2UL{Type-1,Type-2} and RZ/Five
>                - renesas,r9a07g044-pinctrl # RZ/G2{L,LC}
>                - renesas,r9a08g045-pinctrl # RZ/G3S
> +              - renesas,r9a09g057-pinctrl # RZ/V2H(P)
>  
>        - items:
>            - enum:
> @@ -66,10 +67,14 @@ properties:
>      maxItems: 1
>  
>    resets:
> -    items:
> -      - description: GPIO_RSTN signal
> -      - description: GPIO_PORT_RESETN signal
> -      - description: GPIO_SPARE_RESETN signal
> +    oneOf:
> +      - items:
> +          - description: GPIO_RSTN signal
> +          - description: GPIO_PORT_RESETN signal
> +          - description: GPIO_SPARE_RESETN signal
> +      - items:
> +          - description: PFC main reset
> +          - description: Reset for the control register related to WDTUDFCA and WDTUDFFCM pins
>  
>  additionalProperties:
>    anyOf:
> @@ -111,6 +116,15 @@ additionalProperties:
>          output-high: true
>          output-low: true
>          line-name: true
> +        renesas-rzv2h,output-impedance:

'renesas-rzv2h' is not a vendor.

That should give you a warning if you actually used this somewhere.

> +          description: |
> +            Output impedance for pins on RZ/V2H(P) SoC.
> +            x1: Corresponds to 0 in IOLH register.
> +            x2: Corresponds to 1 in IOLH register.
> +            x4: Corresponds to 2 in IOLH register.
> +            x6: Corresponds to 3 in IOLH register.

Why not just use 0-3 for the values? 


> +          $ref: /schemas/types.yaml#/definitions/uint32
> +          enum: [1, 2, 4, 6]
>  
>      - type: object
>        additionalProperties:
> -- 
> 2.34.1
> 

