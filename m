Return-Path: <linux-kernel+bounces-117491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECF788AD45
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99348BC67EF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21194126F03;
	Mon, 25 Mar 2024 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMIimtAT"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A031B5B1;
	Mon, 25 Mar 2024 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711384969; cv=none; b=Bnc7PWgXk9J214ziPaeT02HKT5PuE6KNlmZp+yViFVGSTLNj6cWU9a6x4t+u31zfGgeDx64AWvvFZTCYxkcU0vOX81heEBxCIyQpmWm9v+1Kdh+VSTmfYsF57smnkOriipbfpcGnakdcW9Wv0VLfhMA8DaP+XqXjLP4eFVPGa1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711384969; c=relaxed/simple;
	bh=BsOG0zlpUuIaqZ5XWJcrPCv0aTbo8dN5dmZPSdYyRz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=s4j/PU/gs5HlGauqIGvJQCjdVdUIt5Z66jupi+muLlgcAkw9QshA7OpZ4K752mbyGSXL9yHm6DJ8cp/0SGpguPAM1TGxeLjiDaCrswDx305Ti/LU5d9PGq5lsN2ouai2OnRIFuVozoGK4pQhkXiTg1ACHerLf2HCLbp7NUw00mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMIimtAT; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ea9a60f7f5so1582420b3a.3;
        Mon, 25 Mar 2024 09:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711384967; x=1711989767; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=i6zXI16W5U44j+CqavsDltFFlmUoDY+2ezEvYOwd6U0=;
        b=TMIimtATt/70zAz5V9HyibxpLnui9dJA7+d84kmTN62yJW8YyGRoowcjTESt3EmUq4
         70nRdH1yPORifsgvUiq1Gz5cYZnqBPmWrLa3fSQV6XBvITUECmggmfXT6w+xOUMobMJw
         F+cnmmApyHCaJnphBV/TdOBacpxUhqPZSiJWycb62LDpm7+EkR9nQEW0ju+X9+vU7bah
         rXwteozskjQkMMa/Am+OO8aup8m99Nlk8Putzb2JQtLeD5v5L8h7uY2yL/ugzOIwHXUG
         nbFHgZC2b61FL049xQeePZWsDid23P9ODZVpocMnHeKmwxBPKb0G8PY3CBsMLIyJ5JUA
         iImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711384967; x=1711989767;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6zXI16W5U44j+CqavsDltFFlmUoDY+2ezEvYOwd6U0=;
        b=fypp8unFxXSatdswZMSetQv6n7w6yOTNec5CGwWMKlHedlBOX1I45tsr4dt+ND4tkE
         pmKLT7f+n+u7AG2ElK0gJxFvCWf/9JcHM1tDTGkGDGX1v5BQmCAUQQ+pGRIHcg6Fqkbj
         FuAzE0fyud7NY8AXtbiyIC0GsrM/mazyMqxpqzPGpGFDFnkntZ3VJKC3OdS6hfZA1mCS
         fWUlBN0FgXQQrY43QkM+Q8uwIeJmC95R1wNkMS1ct56aYm6XM/rUYlzniNlZklFaolJx
         Xy8A4bpt8iANOe7nu0cKgG3oa+KMLZejhDPXOMWRbJeR85KP8KgjsR1WopF8RuuYsS66
         fGHg==
X-Forwarded-Encrypted: i=1; AJvYcCUlgFW0MDlj8NQbBnqwNfBkSkpiN5Q4w1aZMfrIM79idkbBr4wwXQQ1FdViZ6a+BEeMQPH4Xp+G+mjzzJ4rQ8VddWTvY2H3R1HYs6jvZZ7m5CMoFCJEOmdkqSmSnf1n7UomQyJtUzHBkYSYbv/t7IS7D+fOoOLMH9QFA9RIMqd2PTxBYi4P3Dx7vKi8Kcrd4dsXP0QK2q0E4Ds0C+Puqr29LSoHI6jocAcl8q7MLN6Hu2poa/jHDJYyxfEEHLhhC8TNE9SuliZNM1uXWTIEVgxhnHMiOfDeec8LLrq1
X-Gm-Message-State: AOJu0YwmwBSbnVWn48hXo0AL+mtrkeHr7G/V8+SsNIpeqSbj8wJVB570
	gqPCUfzcPs9YfRO5daV18NJ2HQamRdtaM/p3ZeRoQVxECDH3ZT3S
X-Google-Smtp-Source: AGHT+IHj7ORNV5iZfjrVaD+IH53ca5TYr9gaePxoGGGxAS6Ra9dP48GahfdY7D/gO4FmqY617Z/bTw==
X-Received: by 2002:a05:6a20:6a9e:b0:1a3:52ef:cc84 with SMTP id bi30-20020a056a206a9e00b001a352efcc84mr4743932pzb.60.1711384966727;
        Mon, 25 Mar 2024 09:42:46 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902f54a00b001dd7a97a266sm4858839plf.282.2024.03.25.09.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 09:42:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a238b9dd-9251-4241-81ef-461081c1c4be@roeck-us.net>
Date: Mon, 25 Mar 2024 09:42:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: mfd: twl: Convert trivial subdevices to
 json-schema
Content-Language: en-US
To: Andreas Kemnade <andreas@kemnade.info>, dmitry.torokhov@gmail.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 lee@kernel.org, alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org, sre@kernel.org
References: <20240324183727.206384-1-andreas@kemnade.info>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240324183727.206384-1-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/24/24 11:37, Andreas Kemnade wrote:
> Convert subdevices with just an interrupt and compatbile to
> json-schema and wire up already converted subdevices.
> RTC is available in all variants, so allow it unconditionally.
> GPADC binding for TWL603X uses two different compatibles, so
> specify just the compatible and do not include it.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

For watchdog:

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in v2:
> - style cleanup
> - absolute paths
> - unevalutedProperties instead of additionalProperties
>    due to not accepting things in if: clauses without it
> 
>   .../bindings/input/twl4030-pwrbutton.txt      | 21 ------
>   .../devicetree/bindings/mfd/ti,twl.yaml       | 72 ++++++++++++++++++-
>   .../devicetree/bindings/rtc/twl-rtc.txt       | 11 ---
>   .../bindings/watchdog/twl4030-wdt.txt         | 10 ---
>   4 files changed, 71 insertions(+), 43 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/input/twl4030-pwrbutton.txt
>   delete mode 100644 Documentation/devicetree/bindings/rtc/twl-rtc.txt
>   delete mode 100644 Documentation/devicetree/bindings/watchdog/twl4030-wdt.txt
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
> index 52ed228fb1e7e..c2357fecb56cc 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> @@ -15,6 +15,67 @@ description: |
>     USB transceiver or Audio amplifier.
>     These chips are connected to an i2c bus.
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
> +          $ref: /schemas/iio/adc/ti,twl4030-madc.yaml
> +          unevaluatedProperties: false
> +
> +        bci:
> +          type: object
> +          $ref: /schemas/power/supply/twl4030-charger.yaml
> +          unevaluatedProperties: false
> +
> +        pwrbutton:
> +          type: object
> +          additionalProperties: false
> +          properties:
> +            compatible:
> +              const: ti,twl4030-pwrbutton
> +            interrupts:
> +              items:
> +                - items:
> +                    const: 8
> +
> +        watchdog:
> +          type: object
> +          additionalProperties: false
> +          properties:
> +            compatible:
> +              const: ti,twl4030-wdt
> +
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
>   properties:
>     compatible:
>       description:
> @@ -42,7 +103,16 @@ properties:
>     "#clock-cells":
>       const: 1
>   
> -additionalProperties: false
> +  rtc:
> +    type: object
> +    additionalProperties: false
> +    properties:
> +      compatible:
> +        const: ti,twl4030-rtc
> +      interrupts:
> +        maxItems: 1
> +
> +unevaluatedProperties: false
>   
>   required:
>     - compatible
> diff --git a/Documentation/devicetree/bindings/rtc/twl-rtc.txt b/Documentation/devicetree/bindings/rtc/twl-rtc.txt
> deleted file mode 100644
> index 8f9a94f2f8969..0000000000000
> --- a/Documentation/devicetree/bindings/rtc/twl-rtc.txt
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -* Texas Instruments TWL4030/6030 RTC
> -
> -Required properties:
> -- compatible : Should be "ti,twl4030-rtc"
> -- interrupts : Should be the interrupt number.
> -
> -Example:
> -	rtc {
> -		compatible = "ti,twl4030-rtc";
> -		interrupts = <11>;
> -	};
> diff --git a/Documentation/devicetree/bindings/watchdog/twl4030-wdt.txt b/Documentation/devicetree/bindings/watchdog/twl4030-wdt.txt
> deleted file mode 100644
> index 80a37193c0b86..0000000000000
> --- a/Documentation/devicetree/bindings/watchdog/twl4030-wdt.txt
> +++ /dev/null
> @@ -1,10 +0,0 @@
> -Device tree bindings for twl4030-wdt driver (TWL4030 watchdog)
> -
> -Required properties:
> -	compatible = "ti,twl4030-wdt";
> -
> -Example:
> -
> -watchdog {
> -	compatible = "ti,twl4030-wdt";
> -};


