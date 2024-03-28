Return-Path: <linux-kernel+bounces-123437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB11089089D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6834D1F25BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29C213775E;
	Thu, 28 Mar 2024 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjOym6iM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB4D137746;
	Thu, 28 Mar 2024 18:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711651839; cv=none; b=iKe5E5ZdGBbhKQXLFclvb/qHGOxT49bvZ+I8Yrwam2oXrhPMI/jQCP+BdGPqa/K2/QsoobtVjbrBAN/WUNp6NVaHfbdtKUUksE8CgI8PsJ1YLAj5pg4vUDMScyFADVQtLzAABSIGtOu2Oh1PMF+nccvczpNNKcIAfBq1tiMw7TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711651839; c=relaxed/simple;
	bh=4YV4eMCtC0egKx+zBizfkV4KX4IW04QZTHkdqw2rvEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToSAD0qTTC16s9/CCM29ubf3q/dAKCvkx4GNQ4gHcLyxnh5kxVKwgqds/FAzUruDlUpf444NS5YnRykaQrqGhfBk6Y0dO478xhsipFvJdjgOU6TDB7oLd5kIneatNHdF/5f7JXa1/KSeuk08N0km012t9UDCfxv+B+H++CK2PTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjOym6iM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D153C433C7;
	Thu, 28 Mar 2024 18:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711651838;
	bh=4YV4eMCtC0egKx+zBizfkV4KX4IW04QZTHkdqw2rvEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CjOym6iMfoQH46YdksEMNunkr11EPy8fqRdISQU7xMYl5CHqwPMt0Fj42RuSCkIjj
	 qBbtyQme8ddxS69WuBK3qXAIwm6+wenRnYoHnlsulDKNS/gmuQ7c4hPx2m8uStUx+n
	 puoFO/7ImboQZS7WJHxDg2OUZdsC4mVhwfNXAr8Wm8eYoJUXLVf4JYiUlR9gExbrAB
	 FkoODt70t4Nflb00E2ciUKrRyOgrvTzVgKdejnaJaH5Ux4voA1giS6VL5T30Lbr4VP
	 l68oaHm+nfaZ9ai49DoW9j/q306ETMAT908xtHs8SCuvrUx4iSbJgw4nGNgMQ/LWlL
	 DxgpHfijcpxaA==
Date: Thu, 28 Mar 2024 13:50:36 -0500
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/3] dt-bindings: leds: Add Silergy SY7802 flash LED
Message-ID: <20240328185036.GA79266-robh@kernel.org>
References: <20240327-sy7802-v1-0-db74ab32faaf@apitzsch.eu>
 <20240327-sy7802-v1-1-db74ab32faaf@apitzsch.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327-sy7802-v1-1-db74ab32faaf@apitzsch.eu>

On Wed, Mar 27, 2024 at 11:51:33PM +0100, André Apitzsch wrote:
> Document Silergy SY7802 flash LED driver devicetree bindings.
> 
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---
>  .../devicetree/bindings/leds/silergy,sy7802.yaml   | 96 ++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/silergy,sy7802.yaml b/Documentation/devicetree/bindings/leds/silergy,sy7802.yaml
> new file mode 100644
> index 000000000000..d32efac8baa6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/silergy,sy7802.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/silergy,sy7802.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Silergy SY7802 1800mA Boost Charge Pump LED Driver
> +
> +maintainers:
> +  - André Apitzsch <git@apitzsch.eu>
> +
> +description: |
> +  The SY7802 is a current-regulated charge pump which can regulate two current
> +  levels for Flash and Torch modes.
> +
> +  The SY7802 is a high-current synchronous boost converter with 2-channel
> +  high side current sources. Each channel is able to deliver 900mA current.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - silergy,sy7802
> +
> +  reg:
> +    maxItems: 1
> +
> +  enable-gpios:
> +    maxItems: 1
> +    description: A connection to the 'EN' pin.
> +
> +  flash-gpios:
> +    maxItems: 1
> +    description: A connection to the 'FLEN' pin.
> +
> +  vin-supply:
> +    description: Regulator providing power to the 'VIN' pin.
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^led@[0-1]$":
> +    type: object
> +    $ref: common.yaml#
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        description: Index of the LED.
> +        minimum: 0
> +        maximum: 1
> +
> +      led-sources:
> +        allOf:

Don't need allOf here.

> +          - minItems: 1
> +            maxItems: 2
> +            items:
> +              minimum: 0
> +              maximum: 1
> +
> +    required:
> +      - reg
> +      - led-sources
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - enable-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/leds/common.h>
> +
> +    flash-led-controller@53 {

This needs to go under an appropriate bus node to fix the errors. i2c 
presumably.

> +        compatible = "silergy,sy7802";
> +        reg = <0x53>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        enable-gpios = <&tlmm 16 GPIO_ACTIVE_HIGH>;
> +
> +        led@0 {
> +            reg = <0>;
> +            function = LED_FUNCTION_FLASH;
> +            color = <LED_COLOR_ID_WHITE>;
> +            led-sources = <0>, <1>;
> +        };
> +    };
> 
> -- 
> 2.44.0
> 

