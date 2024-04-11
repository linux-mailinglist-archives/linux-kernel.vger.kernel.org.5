Return-Path: <linux-kernel+bounces-139822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBBC8A082F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10281B24917
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B000713CA95;
	Thu, 11 Apr 2024 06:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A0Pos9MI"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98507E57F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816047; cv=none; b=KyhEPWTMDnVuyRFNTnkeqB9eGtFHVxfpVLqH8jaH3Ej0pD0cwpLeogEO3dRUfbWgENuIZZpfHTd9D7xjXXsubG1nEV9pDZV11aLsEdZH5dGyUShsalmyImZJXt5mF1PDVwBigdWzdtYFgOIpUZqHEbaWE3O+dxytcBw0xsXsww8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816047; c=relaxed/simple;
	bh=cg047QglKLND8WA1DSf/fOhS/2zKEK+Kbb+tpn9gCxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CHl9Tu7iCHHYiVPlVFU8H/DU28CGX+v0wSHISIHtZFe8LHIi4l2WsWUvdSe79kBcaQ5NParvS5XTW/la+LiChR/9JJgvlZYGt2e//WrAk1XXv3T6UgHZeHY/26UxCCFw1iNr1WIKawOaPMF7ZVtvD+oQ9WYmi7Hc5WtOTV5lJIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A0Pos9MI; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4166d6dab3dso29232015e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712816044; x=1713420844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8YephaNtqju2Q3YgN7N48UKz+wONymX+nCCIjUn+u9A=;
        b=A0Pos9MIr91vNKlnjx/pU9Zm4Al9PIrdh1+B9VTOB9oFJPA3k2NJzOIjQtuRIUxz+A
         cISEemRL76jbJg1AycjMeoOYiSYIffrM6SzRHc2lWls6UrezBXNHPMDV2c2Iyx9kTG+u
         iLMphXnNGLnU4MSCRb0lfbOHcLg98p+HNoSOMJfl6tlRpvBr4nAi61WBAAbtty/uGTFy
         wM0sfV95dNdui+RoZ9XO8ALy/BuVUPZAGvwv67v3MgZgH2VX2cW5u5Q1QYCuDcSBgeJu
         HsqwE18ytSC66266gz0kn1d2iiUAGvmkFQZHlbLKfKR/acuAan1wCn9C54kTjYCE7FKv
         kWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712816044; x=1713420844;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YephaNtqju2Q3YgN7N48UKz+wONymX+nCCIjUn+u9A=;
        b=K1dJxfpUultZfMJRRitslZXNV6Lza3bfTefqFJjYanA7h2En1xHhogr8i9G815nWor
         sEgfLtF84ge4NrpZ/eWYHEttl+ESXtF6gdzBzScJ7h/6gg9Xwtp1XX8DbkuDfz1ELPgK
         68yRn79n+IukFYGudNtk22FNTzc+20/q4Wcw1+TJtf2fOaBDzXIeVk8rV7UcaSeM1BdZ
         P9Q2/2j1MgCOnPa4kRSuvY0EHbV7cMDqA7D7aLFABvv5uv9anixjjEjf0AAF7A/EOO1W
         khWuOnkM2kwDnYA2w2ievUmVoVX+mxubtYqfN7FAlJaboAri3IE+wHcGM72AhzyHTODx
         wTAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+Afd5GAFBwRnM0sDKoduQoNXhJC/1mt8yLTWMSJM5+xp4wyzv3tXFWe6Jg8AqzKgQD89nokxZz01okOGyIYL0lCbUaoflsrklNu7w
X-Gm-Message-State: AOJu0YwFGIqm1vV5ht7NTwXhCdsoixwdiNj6LSAweKV41eOB/pSGYGCg
	08fGjjCJElckAHvR1yzHi+BngRrM3rRoPzwTIFUdcxAtTp+Fb26FYdhRVXhI7bQ=
X-Google-Smtp-Source: AGHT+IED0MsavpCWwAeAU5BHcAkfxmQ6MUFNO+xQA0Uom2+QPmpsoAH3YVU22D8ZYwJk7t4oso+mvQ==
X-Received: by 2002:a05:600c:4f08:b0:415:6728:a584 with SMTP id l8-20020a05600c4f0800b004156728a584mr3293175wmq.25.1712816043821;
        Wed, 10 Apr 2024 23:14:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id ay7-20020a05600c1e0700b00417d4f60692sm1178808wmb.44.2024.04.10.23.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 23:14:03 -0700 (PDT)
Message-ID: <29ece6c8-ddf4-4dcd-b5b4-1cad8bc858d3@linaro.org>
Date: Thu, 11 Apr 2024 08:14:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] dt-bindings: clock: mobileye,eyeq5-clk: add EyeQ6L
 and EyeQ6H
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>
References: <20240410-mbly-olb-v1-0-335e496d7be3@bootlin.com>
 <20240410-mbly-olb-v1-2-335e496d7be3@bootlin.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240410-mbly-olb-v1-2-335e496d7be3@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/04/2024 19:12, Théo Lebrun wrote:
> Add bindings describing EyeQ6L and EyeQ6H clock controllers.
> Add constants to index clocks.
> 
> Bindings are conditional for two reasons:
>  - Some compatibles expose a single clock; they do not take clock cells.
>  - All compatibles take a PLLs resource, not all take others (aimed at
>    divider clocks). Those that only take a resource for PLLs do not
>    require named resources.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  .../bindings/clock/mobileye,eyeq5-clk.yaml         | 103 ++++++++++++++++++---
>  MAINTAINERS                                        |   2 +
>  include/dt-bindings/clock/mobileye,eyeq5-clk.h     |  21 +++++
>  3 files changed, 113 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml b/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
> index 2d4f2cde1e58..a1651fcce258 100644
> --- a/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
> +++ b/Documentation/devicetree/bindings/clock/mobileye,eyeq5-clk.yaml
> @@ -4,12 +4,13 @@
>  $id: http://devicetree.org/schemas/clock/mobileye,eyeq5-clk.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Mobileye EyeQ5 clock controller
> +title: Mobileye EyeQ clock controller
>  
>  description:
> -  The EyeQ5 clock controller handles 10 read-only PLLs derived from the main
> -  crystal clock. It also exposes one divider clock, a child of one of the PLLs.
> -  Its registers live in a shared region called OLB.
> +  EyeQ clock controllers expose read-only PLLs derived from main crystal clock.
> +  Some also expose divider clocks, children of specific PLLs. Its registers
> +  live in a shared region called OLB. EyeQ5 and EyeQ6L have a single OLB
> +  instance while EyeQ6H have seven, leading to seven clock controllers.
>  
>  maintainers:
>    - Grégory Clement <gregory.clement@bootlin.com>
> @@ -18,18 +19,23 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: mobileye,eyeq5-clk
> +    enum:
> +      - mobileye,eyeq5-clk
> +      - mobileye,eyeq6l-clk
> +      - mobileye,eyeq6h-central-clk
> +      - mobileye,eyeq6h-west-clk
> +      - mobileye,eyeq6h-east-clk
> +      - mobileye,eyeq6h-south-clk
> +      - mobileye,eyeq6h-ddr0-clk
> +      - mobileye,eyeq6h-ddr1-clk
> +      - mobileye,eyeq6h-acc-clk
>  
> -  reg:
> -    maxItems: 2
> +  reg: true

No, you must leave widest constraints here.

>  
> -  reg-names:
> -    items:
> -      - const: plls
> -      - const: ospi
> +  reg-names: true

No, you must leave widest constraints here.


>  
>    "#clock-cells":
> -    const: 1
> +    enum: [0, 1]

Looks like you squash here quite different devices...

>  
>    clocks:
>      maxItems: 1
> @@ -43,9 +49,80 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - reg-names
>    - "#clock-cells"
>    - clocks
>    - clock-names
>  
> +allOf:
> +  # "mobileye,eyeq5-clk" provides:
> +  #  - PLLs and,
> +  #  - One divider clock related to ospi.
> +  - if:
> +      properties:
> +        compatible:
> +          const: mobileye,eyeq5-clk
> +    then:
> +      properties:
> +        reg:
> +          minItems: 2
> +          maxItems: 2
> +        reg-names:
> +          minItems: 2
> +          maxItems: 2

So any name is now valid? Like "yellow-pony"?

> +          items:
> +            enum: [ plls, ospi ]
> +      required:
> +        - reg-names
> +
> +  # "mobileye,eyeq6h-south-clk" provides:
> +  #  - PLLs and,
> +  #  - Four divider clocks related to emmc, ospi and tsu.
> +  - if:
> +      properties:
> +        compatible:
> +          const: mobileye,eyeq6h-south-clk
> +    then:
> +      properties:
> +        reg:
> +          minItems: 4
> +          maxItems: 4
> +        reg-names:
> +          minItems: 4
> +          maxItems: 4
> +          items:
> +            enum: [ plls, emmc, ospi, tsu ]
> +      required:
> +        - reg-names
> +
> +  # Other compatibles only provide PLLs. Do not ask for named resources.
> +  - if:
> +      not:
> +        required:
> +          - reg-names
> +    then:
> +      properties:
> +        reg:
> +          minItems: 1
> +          maxItems: 1

No, just restrict properly reg per variant.


> +        reg-names: false

That's redundant. Drop entire if.


> +
> +  # Some compatibles provide a single clock; they do not take a clock cell.
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - mobileye,eyeq6h-central-clk
> +            - mobileye,eyeq6h-west-clk
> +            - mobileye,eyeq6h-east-clk
> +            - mobileye,eyeq6h-ddr0-clk
> +            - mobileye,eyeq6h-ddr1-clk
> +    then:
> +      properties:
> +        "#clock-cells":
> +          const: 0

Wait, so you define device-per-clock? That's a terrible idea. We also
discussed it many times and it was rejected many times.

You have one device, not 5.



Best regards,
Krzysztof


