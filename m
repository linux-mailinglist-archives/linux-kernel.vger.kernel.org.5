Return-Path: <linux-kernel+bounces-106268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 315C187EBAC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5027C1C21388
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6E14F616;
	Mon, 18 Mar 2024 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTvddIHQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD334F5F9;
	Mon, 18 Mar 2024 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710774473; cv=none; b=Pz9tn2KSYxfSPUAW/gFvOn9so4mxsOZJ2n3uqRf7ee2PlT9fYyIGLUNwmdNOAdLFWECNbCoQLPf2U9DVER+pozkOE4ipkbgsheQ1rDmTq2L14jqtWR5YMG0uAvT/uOQ+PRuTwLzbUdysajyTUwmvdVSojGcr9/Ajh1jK055BmMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710774473; c=relaxed/simple;
	bh=b6jIKK6IF/UBDD/2p5Ab01jRH32PNiTjuD4LIO3HBnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWaC0uhj8QpAZbQlV3z0zBHLuplni4kNbb1+7EhkCgYfRJtMGICHNhV7wyyX30rbI5JiTcaj4BR6NQdLjKAM+0mlbx1sDOUt7G8x7FFBK3hAdo8X4g1IBOmYviPOXHgp1a+9GHhIpSG8CEsRBy4Pe2V7GKOZRDMkZQ1lZFZMM/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTvddIHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EA8C433C7;
	Mon, 18 Mar 2024 15:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710774472;
	bh=b6jIKK6IF/UBDD/2p5Ab01jRH32PNiTjuD4LIO3HBnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KTvddIHQty8QyZBWziR57LP012BCa/gAgEr/+x88Fh2GQF82FhOy/XekROmZJHr3W
	 PJGeujPI6eYqlFV1ofbTXVxidIrpdsWn+7t+lokdweWXiA1OpEhh7H6CuCoWJTy1C+
	 dqNTZD1kpTHWkYwy9kyQ5+4FhVywqsLINg+1NZZJaR1uNLl8UkmZ9Wpl2I6UTvF/DX
	 K9/+6WUfA+wrsfihMeAg2tig/6lCvHoG8KU4VzT1niKvBwjWKB23dQRJwK9gtrvvEz
	 4rOIN2O/R6yWIY+vdA19W+2zlReCbRo89Jb+0z099wNYTqrYzBQ4r1T0f70BoXi6vw
	 GsUshDY4pTRhw==
Date: Mon, 18 Mar 2024 10:07:50 -0500
From: Rob Herring <robh@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: dmitry.torokhov@gmail.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, lee@kernel.org, alexandre.belloni@bootlin.com,
	wim@linux-watchdog.org, linux@roeck-us.net,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org,
	sre@kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: twl: Convert trivial subdevices to
 json-schema
Message-ID: <20240318150750.GA4000895-robh@kernel.org>
References: <20240318124051.4166253-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318124051.4166253-1-andreas@kemnade.info>

On Mon, Mar 18, 2024 at 01:40:50PM +0100, Andreas Kemnade wrote:
> Convert subdevices with just an interrupt and compatbile to
> json-schema and wire up already converted subdevices.
> RTC is available in all variants, so allow it unconditionally
> GPADC binding for TWL603X uses two different compatibles, so
> specify just the compatible and not include it.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Well, my name is in that yaml file, so I should take care of my sheep,
> in case a step-by-step approach is acceptable this is at least a
> checkpoint for me that I understand multi file binding mechanics
> properly.
> 
>  .../bindings/input/twl4030-pwrbutton.txt      | 21 ------
>  .../devicetree/bindings/mfd/ti,twl.yaml       | 68 +++++++++++++++++++
>  .../devicetree/bindings/rtc/twl-rtc.txt       | 11 ---
>  .../bindings/watchdog/twl4030-wdt.txt         | 10 ---
>  4 files changed, 68 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
>  delete mode 100644 Documentation/devicetree/bindings/rtc/twl-rtc.txt
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/twl4030-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt b/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
> deleted file mode 100644
> index 6c201a2ba8acf..0000000000000
> --- a/Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -Texas Instruments TWL family (twl4030) pwrbutton module
> -
> -This module is part of the TWL4030. For more details about the whole
> -chip see Documentation/devicetree/bindings/mfd/ti,twl.yaml.
> -
> -This module provides a simple power button event via an Interrupt.
> -
> -Required properties:
> -- compatible: should be one of the following
> -   - "ti,twl4030-pwrbutton": For controllers compatible with twl4030
> -- interrupts: should be one of the following
> -   - <8>: For controllers compatible with twl4030
> -
> -Example:
> -
> -&twl {
> -	twl_pwrbutton: pwrbutton {
> -		compatible = "ti,twl4030-pwrbutton";
> -		interrupts = <8>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> index 52ed228fb1e7e..03d725d5294db 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> @@ -15,6 +15,65 @@ description: |
>    USB transceiver or Audio amplifier.
>    These chips are connected to an i2c bus.
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,twl4030
> +    then:
> +      properties:
> +        madc:
> +          type: object
> +          $ref: ../iio/adc/ti,twl4030-madc.yaml

Use 'absolute' paths: /schemas/iio/...

> +

Drop blank line

> +          unevaluatedProperties: false

blank line between DT properties

> +        bci:
> +          type: object
> +          $ref: ../power/supply/twl4030-charger.yaml
> +
> +          unevaluatedProperties: false
> +        pwrbutton:
> +          type: object
> +          properties:
> +            compatible:
> +              const: ti,twl4030-pwrbutton
> +            interrupts:
> +              const: 8

As 'interrupts' is a matrix, this needs to be:

interrupts:
  items:
    - items:
        - const: 8

> +
> +          additionalProperties: false

In the indented cases, it is preferred to put this before 'properties'.

> +        watchdog:
> +          type: object
> +          properties:
> +            compatible:
> +              const: ti,twl4030-wdt
> +
> +          additionalProperties: false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,twl6030
> +    then:
> +      properties:
> +        gpadc:
> +          type: object
> +          properties:
> +            compatible:
> +              const: ti,twl6030-gpadc
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,twl6032
> +    then:
> +      properties:
> +        gpadc:
> +          type: object
> +          properties:
> +            compatible:
> +              const: ti,twl6032-gpadc
> +
>  properties:
>    compatible:
>      description:
> @@ -42,6 +101,15 @@ properties:
>    "#clock-cells":
>      const: 1
>  
> +  rtc:
> +    type: object
> +    properties:
> +      compatible:
> +        const: ti,twl4030-rtc
> +      interrupts:
> +        maxItems: 1
> +    additionalProperties: false
> +
>  additionalProperties: false
>  
>  required:

