Return-Path: <linux-kernel+bounces-145971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 844038A5DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD881F21CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26F9158217;
	Mon, 15 Apr 2024 22:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6ic+DeJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1036682D93;
	Mon, 15 Apr 2024 22:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713220027; cv=none; b=iROfRU8+UAJrx9SrYTnXEqda/x4IdFwXcwlVmcB7T5Pw3a+rabqWZaSgHcgnAkOrAVXiFmiNoRRziGbly9J9ZmX5Cv4MX0578XjZKFr5uEXroxTIAjcTlpbtokrdpv9HBXjLNhxfjQ7OkTvcF21RM/EZjXSWsk3zHjA+8fejbIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713220027; c=relaxed/simple;
	bh=HEf/tRcjyvnch8G1vURup/zbc73d2ZJkc5OYcs0NKco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgaU0OpdehsZ7XpoARxv9DkqeEI2NQ2w1IooWPSm1BpSU+Tq5uGagM2EvnaP97KNA+isRalWtUpAwQPFFxbQmGk7oueCF9X0X+mQmavsv2LrgL4ZtzRetNqmuwH8oFwYm72x1gp93wR+Ay1OQ/CQtSpjYYk2vh6xt2R0SOvNcHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6ic+DeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5171CC113CC;
	Mon, 15 Apr 2024 22:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713220026;
	bh=HEf/tRcjyvnch8G1vURup/zbc73d2ZJkc5OYcs0NKco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h6ic+DeJpJjMdu+ZMBmBoT1mHXbZwxdPlCBsMhKa3rEEQur6u5Togj2/sh4qQlIQG
	 q56pEWUGzu3goJ0NNv8vDm/8M7pOhoVMrDxSsC+xEECSfaF09lO2uQ8Fkx5LOmOesX
	 k5mQ3pxDOBgbWzRh0xoKRQlP+RDTbcAeS+43UEsuwL3n91R0UyWzq0VMY6GALF0Bwd
	 +fljv149smnODNlWw2PMYlgrKHxoJxOOJOVZPz7ZJWXabT0AXSj63AikAnlbYaIXcU
	 K4YfYeOd7Vz9quMI5fyUJJNMm6kZ2KR1fkWzPDbWpJdmwYNaOxfWC5ldodwIvp3jci
	 HsTy1DHc1tCpQ==
Date: Mon, 15 Apr 2024 17:27:04 -0500
From: Rob Herring <robh@kernel.org>
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] dt-bindings: net: add STM32MP13 compatible in
 documentation for stm32
Message-ID: <20240415222704.GA191094-robh@kernel.org>
References: <20240411143658.1049706-1-christophe.roullier@foss.st.com>
 <20240411143658.1049706-2-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411143658.1049706-2-christophe.roullier@foss.st.com>

On Thu, Apr 11, 2024 at 04:36:48PM +0200, Christophe Roullier wrote:
> New STM32 SOC have 2 GMACs instances.
> GMAC IP version is SNPS 4.20.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> ---
>  .../devicetree/bindings/net/stm32-dwmac.yaml  | 80 +++++++++++++++++--
>  1 file changed, 72 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> index 857d58949b029..20f58eff6e6f9 100644
> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> @@ -22,18 +22,17 @@ select:
>          enum:
>            - st,stm32-dwmac
>            - st,stm32mp1-dwmac
> +          - st,stm32mp13-dwmac
>    required:
>      - compatible
>  
> -allOf:
> -  - $ref: snps,dwmac.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
>        - items:
>            - enum:
>                - st,stm32mp1-dwmac
> +              - st,stm32mp13-dwmac
>            - const: snps,dwmac-4.20a
>        - items:
>            - enum:
> @@ -74,13 +73,16 @@ properties:
>  
>    st,syscon:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
> -    items:
> -      - items:

It is subtle, but the '-' there was significant...

> -          - description: phandle to the syscon node which encompases the glue register
> -          - description: offset of the control register
>      description:
>        Should be phandle/offset pair. The phandle to the syscon node which
> -      encompases the glue register, and the offset of the control register
> +      encompases the glue register, the offset of the control register and
> +      the mask to set bitfield in control register
> +    items:
> +      minItems: 2
> +      items:

Now you removed it, so any number of <phandle offset mask> are allowed. 
You need:

items:
  - minItems: 2
    items:
      - ...


> +        - description: phandle to the syscon node which encompases the glue register
> +        - description: offset of the control register
> +        - description: field to set mask in register
>  
>    st,ext-phyclk:
>      description:
> @@ -108,6 +110,34 @@ required:
>  
>  unevaluatedProperties: false
>  
> +allOf:
> +  - $ref: snps,dwmac.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - st,stm32mp1-dwmac
> +              - st,stm32-dwmac
> +    then:
> +      properties:
> +        st,syscon:
> +          items:
> +            minItems: 2

You mean 'maxItems: 2' as 2 is already the min.

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - st,stm32mp13-dwmac
> +    then:
> +      properties:
> +        st,syscon:
> +          items:
> +            minItems: 3
> +
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> @@ -168,3 +198,37 @@ examples:
>             snps,pbl = <8>;
>             phy-mode = "mii";
>         };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/stm32mp1-clks.h>
> +    #include <dt-bindings/reset/stm32mp1-resets.h>
> +    #include <dt-bindings/mfd/stm32h7-rcc.h>
> +    //Example 4

Not a useful comment.

> +     ethernet3: ethernet@5800a000 {
> +           compatible = "st,stm32mp13-dwmac", "snps,dwmac-4.20a";
> +           reg = <0x5800a000 0x2000>;
> +           reg-names = "stmmaceth";
> +           interrupts-extended = <&intc GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
> +                                 <&exti 68 IRQ_TYPE_LEVEL_HIGH>;
> +           interrupt-names = "macirq",
> +                             "eth_wake_irq";
> +           clock-names = "stmmaceth",
> +                         "mac-clk-tx",
> +                         "mac-clk-rx",
> +                         "eth-ck",
> +                         "ptp_ref",
> +                         "ethstp";
> +           clocks = <&rcc ETHMAC>,
> +                    <&rcc ETHTX>,
> +                    <&rcc ETHRX>,
> +                    <&rcc ETHCK_K>,
> +                    <&rcc ETHPTP_K>,
> +                    <&rcc ETHSTP>;
> +           st,syscon = <&syscfg 0x4 0xff0000>;
> +           snps,mixed-burst;
> +           snps,pbl = <2>;
> +           snps,axi-config = <&stmmac_axi_config_1>;
> +           snps,tso;
> +           phy-mode = "rmii";
> +     };
> -- 
> 2.25.1
> 

