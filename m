Return-Path: <linux-kernel+bounces-69889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D55D858FE3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA9D4282EAB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573317AE67;
	Sat, 17 Feb 2024 14:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HFfH7NS+"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF697A727
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708178521; cv=none; b=PLoi8WcZjNTVJsUw0d3LaVHmrGreehLGtYqE3SUB4yfXj152u+InQv3Pfcu7+U+4suh15fCfAuGsUlZ05P18O7C92iN4INPo7lGucfhb/XeFCW23McBqaICfAU9fS1VwB+lvuw5yls2f/efErYf7yF3U4AAjgv+A4eAr1EoU5zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708178521; c=relaxed/simple;
	bh=UqbGwt0t6wp2BJOZU3Pyz2nrZoLA3E0RRUpLzG5ehA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jio0Z+U9FYnIFprvuwAUqCpybpqHCD/3/HKtYoCmp9iE9i8Y2og9qASJBqUq34WFBxO2RS7FfNQOqvJEF3+hf5U7SyrHqLe9WkX3OTNWsrJFgEVEbWqJlXaEh5p6ThFiIjBvzw2Gy79LakRO3g+xtL/xRHv7sNz6YdwWJThTmGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HFfH7NS+; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d109e7bed2so37482121fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 06:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708178517; x=1708783317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XausAk3wcLMS6aTKh7J69TRAU825TD7w7U2A7K837UA=;
        b=HFfH7NS+Jm1ayYZNpvdC4j7VUVlwtmFqnubAEbqSTMHY23Eb80Ad8tWeOByMZUeAEd
         gHlTWY3/k8pyxNilg+llxMXnfvKNM2JDKidIDUKGsSigmuphvcmcFRt+OY6u2DDvFNQC
         Qmvg/RQ7Lfu85rc+SS2YCs+Cv0S1UnF0RTPyySUUCEVSaGjd6HXjUKVMp2lIZg7yn1Y8
         1t0hfdI/8xvT7wT2sytbUFf3u8s+Lo3FoHeO5U5m68UabottirMA/+i854dw1kTtNgch
         cg+ShLMIAQQjZTFXNqckVrx6OJlnBWlP3XRtWFTixH3kizJmYY3reK3o5oLs9WwDVZnw
         EmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708178517; x=1708783317;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XausAk3wcLMS6aTKh7J69TRAU825TD7w7U2A7K837UA=;
        b=wvRFjKD4kMPpuR5qxS0xjgIAXXLeZjb/LhOwhvQBMKuCvIcljcjncDHsSOaEsrWHgc
         ImMYcmi4WznJcONGTpAtRFlgLJ1CTqf9fXrueJbsTxd8Le3iAsOWEdEGxELmzTTovC4M
         ZSrlsXTOYMCJIS1q4RCqd72SZ48YXmztrInlMcP2VFQ8QtJWRgnwZJgqwlwiokEw9MXC
         zZ1kHdpa+Wms7wibFN8x7YWn3NYQl97+Tyz5rn8sQi3theBtapmwhAtR3in6QHRVICKZ
         Gua9/qXe+wUVgcMsnOKSGtNyxpm8V4EWHcHy81TVH9DwsDG45d/VspRlN3r20z3nYvDD
         Lcyg==
X-Forwarded-Encrypted: i=1; AJvYcCUf9i010I9FWMAMt7zw2xpkO0X17kkPhb7cShByFMaYXhPoH0pPP1MMJmFCHyaW0YETFcxXnvvbpnoXyzjrDWuxT320AbT4BE175+JO
X-Gm-Message-State: AOJu0Yw2xRqvuj6n+H1S3BSHnzsqUbJQKgFuYkhnhtgYPul6rh7bEHYy
	ARlwY8CJiWo50RClzqmtBlqE/lZALVBuD+ngtWvjQ1DKY5LXiLai5/XrXgeebTQ=
X-Google-Smtp-Source: AGHT+IHh5r7eqr2G0VMvB4lHnvn/22pI4BxegT8XvwdHZr9YDHIYA6OWcp0oD8D7X/lPF9ccKPKZVw==
X-Received: by 2002:ac2:5926:0:b0:511:694b:245a with SMTP id v6-20020ac25926000000b00511694b245amr4853944lfi.58.1708178517566;
        Sat, 17 Feb 2024 06:01:57 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id vh6-20020a170907d38600b00a3cf436af4fsm1008809ejc.3.2024.02.17.06.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 06:01:56 -0800 (PST)
Message-ID: <0d7b5549-f56b-4693-878f-e513fbf5ca16@linaro.org>
Date: Sat, 17 Feb 2024 15:01:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 11/17] dt-bindings: net: pse-pd: Add another
 way of describing several PSE PIs
Content-Language: en-US
To: Kory Maincent <kory.maincent@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>,
 Russ Weight <russ.weight@linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>
References: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
 <20240215-feature_poe-v4-11-35bb4c23266c@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240215-feature_poe-v4-11-35bb4c23266c@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/02/2024 17:02, Kory Maincent wrote:
> PSE PI setup may encompass multiple PSE controllers or auxiliary circuits
> that collectively manage power delivery to one Ethernet port.
> Such configurations might support a range of PoE standards and require
> the capability to dynamically configure power delivery based on the
> operational mode (e.g., PoE2 versus PoE4) or specific requirements of
> connected devices. In these instances, a dedicated PSE PI node becomes
> essential for accurately documenting the system architecture. This node
> would serve to detail the interactions between different PSE controllers,
> the support for various PoE modes, and any additional logic required to
> coordinate power delivery across the network infrastructure.
> 
> The old usage of "#pse-cells" is unsuficient as it carries only the PSE PI
> index information.
> 
> This patch is sponsored by Dent Project <dentproject@linuxfoundation.org>.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Changes in v3:
> - New patch
> 
> Changes in v4:
> - Remove $def
> - Fix pairset-names item list
> - Upgrade few properties description
> - Update the commit message
> ---
>  .../bindings/net/pse-pd/pse-controller.yaml        | 84 +++++++++++++++++++++-
>  1 file changed, 81 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml b/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
> index 2d382faca0e6..6f4faec216a5 100644
> --- a/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
> +++ b/Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
> @@ -13,6 +13,7 @@ description: Binding for the Power Sourcing Equipment (PSE) as defined in the
>  
>  maintainers:
>    - Oleksij Rempel <o.rempel@pengutronix.de>
> +  - Kory Maincent <kory.maincent@bootlin.com>
>  
>  properties:
>    $nodename:
> @@ -22,11 +23,88 @@ properties:
>      description:
>        Used to uniquely identify a PSE instance within an IC. Will be
>        0 on PSE nodes with only a single output and at least 1 on nodes
> -      controlling several outputs.
> +      controlling several outputs which are not described in the pse_pis
> +      subnode. This property is deprecated, please use pse_pis instead.
>      enum: [0, 1]
>  
> -required:
> -  - "#pse-cells"
> +  pse_pis:

How did this appear here? Underscores are no allowed.

> +    type: object


Missing description.

> +
> +    properties:
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +    required:
> +      - "#address-cells"
> +      - "#size-cells"
> +
> +    patternProperties:

No underscores.

> +      "^pse_pi@[0-9a-f]+$":
> +        type: object
> +        description:
> +          PSE PI for power delivery via pairsets, compliant with IEEE
> +          802.3-2022, Section 145.2.4. Each pairset comprises a positive and
> +          a negative VPSE pair, adhering to the pinout configurations
> +          detailed in the standard.
> +          See Documentation/networking/pse-pd/pse-pi.rst for details.
> +
> +        properties:
> +          reg:
> +            description:
> +              Address describing the PSE PI index.
> +            maxItems: 1
> +
> +          "#pse-cells":
> +            const: 0
> +
> +          pairset-names:
> +            $ref: /schemas/types.yaml#/definitions/string-array
> +            description:
> +              Names of the pairsets as per IEEE 802.3-2022, Section 145.2.4.
> +              Valid values are "alternative-a" and "alternative-b". Each name
> +              should correspond to a phandle in the 'pairset' property
> +              pointing to the power supply for that pairset.
> +            minItems: 1
> +            maxItems: 2
> +            items:
> +              enum:
> +                - "alternative-a"
> +                - "alternative-b"

No need for quotes.

I believe you did not test it, so I will skip reviewing the rest.


Best regards,
Krzysztof


