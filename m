Return-Path: <linux-kernel+bounces-150322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ECC8A9D57
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA0B6B2515C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DA8165FB0;
	Thu, 18 Apr 2024 14:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vl+8FzIY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7CA1DFD8;
	Thu, 18 Apr 2024 14:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451222; cv=none; b=FmVlB2NI3ea1nEVVfC+xIYlcei+phGUkzw5AoDOubuudqTeA0Lls2BSVWXf39e5IVlH8lihtv5r3v7bwkTb0UtddafcAeNqUMNu9KjpvL6P4x0JkSyrymFpVyfZGq44A5PXPx8myPBKYSi3OsqeUlX9RRSjY5Sv+D1FZHp6a0Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451222; c=relaxed/simple;
	bh=5wfD8jgqY0xbfl+rru6H0p8KlLn4S30xcJPK4wWQpgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofJEin1LY8tcX/AdqwWDvvX591vLixPxvN2fSiqRrRd6I+IDYlX2IMQUVN+pSHy293K0CHk0NqbilEPOQAKBosn+AcuXMlMPPTKdRCwxuCgxewdXq5P6WOoA+b4XbO/CbBtbQHXWn7gvkkZZRSHL/qWy3J4FiL+UZ7Bala6eQ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vl+8FzIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDF3C113CC;
	Thu, 18 Apr 2024 14:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713451222;
	bh=5wfD8jgqY0xbfl+rru6H0p8KlLn4S30xcJPK4wWQpgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vl+8FzIY8lRwJQCg8/tnlOURjc1wqcdh2vmm0xxZZ0zPph+fvjmfCadtMGrSsFrTa
	 DDTDsfopTL9Fxw32cu9fL0PCSRBw+tcoSzz8m9m+3TcCAb8GAMb3OlSqxdddqrnAEf
	 C/eopdDzijTjqOxHb34ePAtFwPYnvT+FoCpudq5r0wvZd4m5kgzm1cYCwQ1/5aoPN1
	 fCj2ZmtpMMtU12U2Wiw+Co0nqdtma9JBL+CmY4yIq5H3lmeNnBIZVhG4YIONVcgCZV
	 i2ZZR5/IND1sbWTOjoOTU6VEP0GmbWeRUPkJgsjtTnRPAJVrn9EQMj5q3qp3rM5lBL
	 K00jwZmjZgQGw==
Date: Thu, 18 Apr 2024 09:40:19 -0500
From: Rob Herring <robh@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	alexandru.tachici@analog.com, lars@metafoo.de, jic23@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org,
	nuno.sa@analog.com, marcelo.schmitt@analog.com,
	bigunclemax@gmail.com, dlechner@baylibre.com, okan.sahin@analog.com,
	fr0st61te@gmail.com, alisa.roman@analog.com,
	marcus.folkesson@gmail.com, schnelle@linux.ibm.com,
	liambeguin@gmail.com
Subject: Re: [PATCH v6 4/5] dt-bindings: iio: adc: ad7192: Add AD7194 support
Message-ID: <20240418144019.GA1581398-robh@kernel.org>
References: <20240417170054.140587-1-alisa.roman@analog.com>
 <20240417170054.140587-5-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417170054.140587-5-alisa.roman@analog.com>

On Wed, Apr 17, 2024 at 08:00:53PM +0300, Alisa-Dariana Roman wrote:
> Unlike the other AD719Xs, AD7194 has configurable differential
> channels. The user can dynamically configure them in the devicetree.
> 
> Also add an example for AD7194 devicetree.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  .../bindings/iio/adc/adi,ad7192.yaml          | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> index cf5c568f140a..7e4e15e4e648 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
> @@ -21,8 +21,15 @@ properties:
>        - adi,ad7190
>        - adi,ad7192
>        - adi,ad7193
> +      - adi,ad7194
>        - adi,ad7195
>  
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
>    reg:
>      maxItems: 1
>  
> @@ -89,6 +96,30 @@ properties:
>      description: see Documentation/devicetree/bindings/iio/adc/adc.yaml
>      type: boolean
>  
> +patternProperties:
> +  "^channel@[0-9a-z]+$":

Unit-addresses are hex (typically). So something like:

'^channel@(100|[0-9a-f]{1,2})$'

> +    type: object
> +    $ref: adc.yaml
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        description: The channel index.
> +        minimum: 1
> +        maximum: 256

Why not 0 based?


> +
> +      diff-channels:
> +        description: |

Don't need '|' if no formatting.

> +          Both inputs can be connected to pins AIN1 to AIN16 by choosing the
> +          appropriate value from 1 to 16.
> +        items:
> +          minimum: 1
> +          maximum: 16
> +
> +    required:
> +      - reg
> +      - diff-channels

Single ended modes aren't supported?

> +
>  required:
>    - compatible
>    - reg
> @@ -103,6 +134,17 @@ required:
>  
>  allOf:
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - adi,ad7190
> +            - adi,ad7192
> +            - adi,ad7193
> +            - adi,ad7195
> +    then:
> +      patternProperties:
> +        "^channel@[0-9a-z]+$": false
>  
>  unevaluatedProperties: false
>  
> @@ -133,3 +175,38 @@ examples:
>              adi,burnout-currents-enable;
>          };
>      };
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "adi,ad7194";
> +            reg = <0>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            spi-max-frequency = <1000000>;
> +            spi-cpol;
> +            spi-cpha;
> +            clocks = <&ad7192_mclk>;
> +            clock-names = "mclk";
> +            interrupts = <25 0x2>;
> +            interrupt-parent = <&gpio>;
> +            aincom-supply = <&aincom>;
> +            dvdd-supply = <&dvdd>;
> +            avdd-supply = <&avdd>;
> +            vref-supply = <&vref>;
> +
> +            channel@1 {
> +                reg = <1>;
> +                diff-channels = <1 6>;
> +            };
> +
> +            channel@2 {
> +                reg = <2>;
> +                diff-channels = <16 5>;
> +            };
> +        };
> +    };
> -- 
> 2.34.1
> 

