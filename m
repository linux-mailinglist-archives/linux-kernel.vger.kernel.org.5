Return-Path: <linux-kernel+bounces-19186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EF282697F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:28:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C0AE1F21EA1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE27B657;
	Mon,  8 Jan 2024 08:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eXDRizFA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4226C1170F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 08:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2a225e9449so119595366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 00:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704702481; x=1705307281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KiUaoDpIBFJNm/5JkSkSpwu9lZVeZsGzw4NT5VnaY/Q=;
        b=eXDRizFAAumLT15Oyu9oJw2FbTkv3dpsPlGNzUR3H0LIQTY/yvuusUWeMXf7sc+tzW
         SKibz00IxVp290sDb57znOeTkdtOIbeM4pppbletWxO9iVPzAd+bFT2S1L4gYN3slcOT
         W8qQnW//RBkwySCFtUvSFct63rJNChIMWAGmJPO5Poiugz7pojKCobPR4hHFex3WrFMw
         t0eEIcXCmI4z0/VdqFeNUQv9SzOLdb1yxtdzY0wynb3/R76aQBPHCUdbslsSB05/sZ66
         RUQyJr1fCmVRYs2d+cSi6HNTp8EeU6ZJ6hBZ1cjHy/f6YuZwCzanzy34G5eGa5ZtRZjQ
         yBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704702481; x=1705307281;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KiUaoDpIBFJNm/5JkSkSpwu9lZVeZsGzw4NT5VnaY/Q=;
        b=dHAYlNilisTHgWFFwmeJE1hZVFI7UXRvRIKjpktw4ig/0zNMdb26pLRDD77nJgEKHv
         tKCkRd7PHqu9pTLbWPekj99vDaLDV4nY2WOe3NvoO/OSG5oh5zHpQJ8GgYZ0LonkzbNt
         i/AXi38FBQofpU0hn0aOibiYi/HkHEjzTL4XVEzueBxyqFpeHZi16hXcdYpaCzHXjsyh
         9F1wmKYSZtKFQILvZCUNKnQ+wRgOYFHk5L9131DFR9b5jz70Jqf4ZlUDXGA/e0BPA9AY
         o2Ti4+Shjmeo/gm5OhHVdErMveisAu6KM+xhg2XKtEQ8hbo1i9MKGJXZO/kDS9scdFlO
         nQfQ==
X-Gm-Message-State: AOJu0YwlI50Bb9eGaKmWcq2A+dtBmt5aVTVB/cyhkpQF3VgR4G5gHsHr
	knNgm6V2GzJ/UrVorXEBv/O6i/AFEYFk/g==
X-Google-Smtp-Source: AGHT+IHI6qYmjvdFZgCYS4DlGuc/m7XCKg/o0Ptv0K7fz1AJIqEKZml7fOpplDjj/ahggJn7qh7fMg==
X-Received: by 2002:a17:906:3b8f:b0:a23:39e4:ca86 with SMTP id u15-20020a1709063b8f00b00a2339e4ca86mr1339215ejf.74.1704702481538;
        Mon, 08 Jan 2024 00:28:01 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id t20-20020a170906609400b00a28badcf367sm3716898ejj.54.2024.01.08.00.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 00:28:01 -0800 (PST)
Message-ID: <0aaa3f78-07c5-4c03-bb1b-897020541e7b@linaro.org>
Date: Mon, 8 Jan 2024 09:27:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: starfive,jh7110-dwmac: Add StarFive
 JH8100 support
Content-Language: en-US
To: Tan Chun Hau <chunhau.tan@starfivetech.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Simon Horman <horms@kernel.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Andrew Halaney <ahalaney@redhat.com>, Jisheng Zhang <jszhang@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Russell King <rmk+kernel@armlinux.org.uk>
Cc: Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Jee Heng Sia <jeeheng.sia@starfivetech.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20240108075810.14161-1-chunhau.tan@starfivetech.com>
 <20240108075810.14161-2-chunhau.tan@starfivetech.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240108075810.14161-2-chunhau.tan@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/01/2024 08:58, Tan Chun Hau wrote:
> Add StarFive JH8100 dwmac support.
> JH8100 dwmac has one reset signal instead of 2 resets as in JH7110.
> 
> Signed-off-by: Tan Chun Hau <chunhau.tan@starfivetech.com>
> ---
>  .../bindings/net/starfive,jh7110-dwmac.yaml   | 28 ++++++++++++-------
>  1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> index 5e7cfbbebce6..3d0447726902 100644
> --- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
> @@ -17,6 +17,7 @@ select:
>        contains:
>          enum:
>            - starfive,jh7110-dwmac
> +          - starfive,jh8100-dwmac

I have doubts that you tested it. Missing change to snps,dwmac.

>    required:
>      - compatible
>  
> @@ -25,6 +26,7 @@ properties:
>      items:
>        - enum:
>            - starfive,jh7110-dwmac
> +          - starfive,jh8100-dwmac
>        - const: snps,dwmac-5.20
>  
>    reg:
> @@ -54,16 +56,6 @@ properties:
>      minItems: 3
>      maxItems: 3
>  
> -  resets:
> -    items:
> -      - description: MAC Reset signal.
> -      - description: AHB Reset signal.
> -
> -  reset-names:
> -    items:
> -      - const: stmmaceth
> -      - const: ahb
> -
>    starfive,tx-use-rgmii-clk:
>      description:
>        Tx clock is provided by external rgmii clock.
> @@ -93,6 +85,22 @@ required:
>  
>  allOf:
>    - $ref: snps,dwmac.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - starfive,jh7110-dwmac
> +    then:
> +      properties:
> +        resets:
> +          items:
> +            - description: MAC Reset signal.
> +            - description: AHB Reset signal.
> +        resets-names:
> +          items:
> +            - const: stmmaceth
> +            - const: ahb

Missing else: narrowing your jh8100.

Best regards,
Krzysztof


