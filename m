Return-Path: <linux-kernel+bounces-16393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FB0823DD3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 09:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0AD728299F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 08:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3E61DFC2;
	Thu,  4 Jan 2024 08:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qBmw/LTR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277FF1E500
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 08:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a271a28aeb4so25935666b.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 00:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704358014; x=1704962814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dxxff/ErUIZVKvL74Mkxu99RYlOp8uSYyZc1MOwQOvU=;
        b=qBmw/LTR0k6S3qJV3gm8fXzIBYDmV4fUyX2REyOj4a3PccxOzqw8ZJgseKhkJ1I9hq
         BYWPpicXz+HJGdrauwZ4i7mcJyYNElWXJxh09VHw/h1TDIBUOp3O+FOxn82vh4fjtE8V
         Hh/4gsQ8SGx/+HX+v48AHBGJMgpFtn7K7L6V/J2FzB9IuGXjuP6keKcWZGMytYlykei9
         y/kSQC2Z4AuwVG707bYWnR09NgFOAjL/JrIIVBGOuBl3E8zIGq+AYDtW58ARvwGKfcjO
         WsXUfxXAI9LxXkNMZYVeUA8yID1OCovfsPIgqwenxmQK1aSFgb++iOqYegd9LEiWWyXX
         Hs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704358014; x=1704962814;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dxxff/ErUIZVKvL74Mkxu99RYlOp8uSYyZc1MOwQOvU=;
        b=YymE5uiV83mFzMAROSMiZOkx+Ap7TnfE7CyH4NYhiy5tZ1lATRVRFoex6hkSomvrEF
         oIExSPnhsy2e63821qlku9O9rHqc/pgjR6Q3gv6st3ajbbwAHkvaQ+cZL0bpsnj3Am1H
         2SNPFtritIFTB681pu+qSRvMZ5T9y8D8SwSyIfQrQMByiAZE8zws+hJrgsJ3sHhxIY1C
         crLindI5PHd/CakravocOIdpAaiPIIsTG1wEtRZm1dutKD2FxQf/ZzoeB9G0fGIVAaA8
         idkNDnjxDmXnmLishcJBmnYhy9dW2HAR7qdV4mlnH7KnRFZvMdh/z1F8iKmNSTqWosC/
         TN7g==
X-Gm-Message-State: AOJu0YxR9vT9xhvp1l+0fMLXx0QVnhvh5ec7hYFOku7usrXA3EJWqNSR
	HelxCtdyy0nHSmFgQFr+pGNyiUNWP9rAMQ==
X-Google-Smtp-Source: AGHT+IHYpBh1xZGp/wlODRHn1IqGJT/3CyW1hfetHp5iswBWH6tlMsaNV98kS4VgOho0zPiuXenKgQ==
X-Received: by 2002:a17:906:ad8a:b0:a27:f950:4576 with SMTP id la10-20020a170906ad8a00b00a27f9504576mr122278ejb.151.1704358014442;
        Thu, 04 Jan 2024 00:46:54 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id ka24-20020a170907921800b00a26a80a58fcsm13126060ejb.196.2024.01.04.00.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 00:46:54 -0800 (PST)
Message-ID: <3a290bf9-928d-4d21-9c93-0d1db59d6fff@linaro.org>
Date: Thu, 4 Jan 2024 09:46:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: clk: sprd: Add UMS9620 support
Content-Language: en-US
To: Chunyan Zhang <chunyan.zhang@unisoc.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
References: <20231229085156.1490233-1-chunyan.zhang@unisoc.com>
 <20231229085156.1490233-2-chunyan.zhang@unisoc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231229085156.1490233-2-chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/12/2023 09:51, Chunyan Zhang wrote:
> Add UMS9620's clock compatible strings and descriptions for clock
> and clock-names for UMS9620.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  .../bindings/clock/sprd,ums512-clk.yaml       | 79 ++++++++++++++++---
>  1 file changed, 68 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> index 43d2b6c31357..dcad41a1fea7 100644
> --- a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> +++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> @@ -30,25 +30,38 @@ properties:
>        - sprd,ums512-mm-clk
>        - sprd,ums512-mm-gate-clk
>        - sprd,ums512-apapb-gate
> +      - sprd,ums9620-pmu-gate
> +      - sprd,ums9620-g1-pll
> +      - sprd,ums9620-g5l-pll
> +      - sprd,ums9620-g5r-pll
> +      - sprd,ums9620-g8-pll
> +      - sprd,ums9620-g9-pll
> +      - sprd,ums9620-g10-pll
> +      - sprd,ums9620-apapb-gate
> +      - sprd,ums9620-ap-clk
> +      - sprd,ums9620-apahb-gate
> +      - sprd,ums9620-aon-gate
> +      - sprd,ums9620-aonapb-clk
> +      - sprd,ums9620-topdvfs-clk
> +      - sprd,ums9620-ipaapb-gate
> +      - sprd,ums9620-ipa-clk
> +      - sprd,ums9620-ipaglb-gate
> +      - sprd,ums9620-ipadispc-gate
> +      - sprd,ums9620-pcieapb-gate
> +      - sprd,ums9620-pcie-clk
> +      - sprd,ums9620-mm-gate
> +      - sprd,ums9620-mm-clk
> +      - sprd,ums9620-dpu-vsp-gate
> +      - sprd,ums9620-dpu-vsp-clk
>  
>    "#clock-cells":
>      const: 1
>  
>    clocks:
> -    minItems: 1
> -    maxItems: 4

No, constraints stay here.

>      description: |
>        The input parent clock(s) phandle for the clock, only list
>        fixed clocks which are declared in devicetree.
>  
> -  clock-names:

No, you cannot just drop properties. Widest constraints stay here.

> -    minItems: 1
> -    items:
> -      - const: ext-26m
> -      - const: ext-32k
> -      - const: ext-4m
> -      - const: rco-100m
> -
>    reg:
>      maxItems: 1
>  
> @@ -57,7 +70,43 @@ required:
>    - '#clock-cells'
>    - reg
>  
> -additionalProperties: false
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            pattern: "^sprd,ums512-.*"
> +
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 1
> +          maxItems: 4
> +
> +        clock-names:
> +          minItems: 1
> +          items:
> +            - const: ext-26m
> +            - const: ext-32k
> +            - const: ext-4m
> +            - const: rco-100m
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            pattern: "^sprd,ums9620-.*"
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 1
> +          maxItems: 6
> +
> +        clock-names:
> +          minItems: 1
> +          maxItems: 6

Missing names.

Most likely you are trying to stuff too many devices into one binding. I
suggest split, could be with some shared/common schema (see Qualcomm GCC
bindings).

> +
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> @@ -68,4 +117,12 @@ examples:
>        clock-names = "ext-26m";
>        #clock-cells = <1>;
>      };
> +
> +    aonapb_gate: clock-controller@0 {
> +      compatible = "sprd,ums9620-aon-gate";

Drop entire example, no need for new example for every new compatible.



Best regards,
Krzysztof


