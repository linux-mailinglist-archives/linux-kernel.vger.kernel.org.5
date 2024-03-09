Return-Path: <linux-kernel+bounces-97902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD6E87715B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 14:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6267281C6D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F013BBF0;
	Sat,  9 Mar 2024 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZGV/jlr"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6973BBC2
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709990731; cv=none; b=bHqHTUu+IKZbwxIXdxMtIs4X4kz4+FTNvm15mjvuHUBaQ/afrrqjWqMflZ7u1pnhzPa625xXf/chEDNELhHkoS/LHGP54zGM3gntE1NGyfCJBNFAQS0WciBp6nUCR0CiIIm99DwiLSxcWbb+T/QBtn5TkTyi5sMGkxI5enBgw2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709990731; c=relaxed/simple;
	bh=LHB6rFgP2ZQBJqCKzNVyKTDcpYrfFT5IZ++abJMN94M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SiQVUnr/8GARqenD5odpgIzxx5/0irxzmVtL2VfjTotTlBu2C+TP8xnoe+Xce/NsFrExd+Ilgk/gof1q8AiuBzya3WKLLB9sWFnQcVORxdp9wT7QZonRezC9Yuujsk8I06F6931d1mrBo3xNXIwE4qFMiBA/L5r3KB+XwbjPJGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NZGV/jlr; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a456ab934eeso415382966b.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 05:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709990728; x=1710595528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yDiQvphz9r/4tswvU3DLnkYQoFIGQ/fVX+Hfug55pYU=;
        b=NZGV/jlru5r433VqTgFMOiobtVy0QPavoPFuJ73L/uJpTFC3GxjjkzxWtzjLWDTumm
         VnTLe0WwiUH16wL4/lPzPICJcg4eYVeg+xM5kPgzgigwb/MkOugnqwbrmeakUEI1CY/R
         /tGAH2s7CVV0vxj/DD6BK1r6KT6nZ9OWaNK700XzePCc3PcZEPaht6wBV8k4IyjZaWbd
         M9lMwKZIdvx6hQAHRCF7oZDbTkT+/SVZ6ysOGu4cqCPu9sxoyWNPI84vrWyDP/DkunHe
         NOfW+mYdkeL4VEpc4Ji3pZiyS0/DWKcnmsRHPpdvJ7xAGX1qkytcjTvcK0kKG5xTZw42
         uZIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709990728; x=1710595528;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yDiQvphz9r/4tswvU3DLnkYQoFIGQ/fVX+Hfug55pYU=;
        b=QJpfAPJ+wp0XaWISE8kGdHItssrhWRFbZcDakjzICBuVUYQL2gDXJFQ7ddczUXedQN
         jZvB6vD0gyIuxaxtc2tVjGY8/7CEg5Yxr0uDqiPCruK3QJ16DKqbmLeUBIkytNiIGMzU
         b7WBKLFFs4GpFEgB/DEdpA4Lih6/9PbdgRcWPTTiySs8TLpj69GkMgMIjbnGmDca6VJS
         Q6AiDeAV/XFBYkiPNMrw33mc3bMAyh/B2vMnlpMjX6AAh7+W/CS6d7s70YnBjot2xHqB
         rnO23qVsjVVDYUDPuUpyJ8sjhfBc9junUGyD2FlZJqtTUw85pAN+RIJk7phd8ESPaZdg
         1pPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9kfEwYZlnLheu1D2KhKC86irshTbfjqFnVypKNZJzZWNeqwGTCDtt65/9PITTKf4fsyNSfZMpIWO1dS2UnnVP9vJHJBCMW1vfOE+Z
X-Gm-Message-State: AOJu0YwUZkYtcAZHuqoW6dqQepg2j07utS0Vx9so7KOyE4NkRVEeD+sP
	alK/KaHa4XFgZo+hcZL33ejdYE53hUbvPoErteoHoMQPsILvShClEtIfRH5gssU=
X-Google-Smtp-Source: AGHT+IEqMUeTbIwEJMFFWcxPSCURfWjwaIR3Ho9n40MtX5g6Fu+gZKAk5/hreEtCMYPdV7ZxgdwHUQ==
X-Received: by 2002:a17:906:f8da:b0:a45:902b:3cb0 with SMTP id lh26-20020a170906f8da00b00a45902b3cb0mr1019082ejb.58.1709990728160;
        Sat, 09 Mar 2024 05:25:28 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id lr1-20020a170906fb8100b00a442e2940fdsm887802ejb.179.2024.03.09.05.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 05:25:27 -0800 (PST)
Message-ID: <fb78bdda-2ec7-4fcc-888e-233905a9386c@linaro.org>
Date: Sat, 9 Mar 2024 14:25:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/4] dt-bindings: remoteproc: add Tightly Coupled
 Memory (TCM) bindings
Content-Language: en-US
To: Tanmay Shah <tanmay.shah@amd.com>, andersson@kernel.org,
 mathieu.poirier@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 michal.simek@amd.com, ben.levinsky@amd.com
Cc: linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
References: <20240301181638.814215-1-tanmay.shah@amd.com>
 <20240301181638.814215-3-tanmay.shah@amd.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240301181638.814215-3-tanmay.shah@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/03/2024 19:16, Tanmay Shah wrote:
> From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> 
> Introduce bindings for TCM memory address space on AMD-xilinx Zynq
> UltraScale+ platform. It will help in defining TCM in device-tree
> and make it's access platform agnostic and data-driven.
> 
> Tightly-coupled memories(TCMs) are low-latency memory that provides
> predictable instruction execution and predictable data load/store
> timing. Each Cortex-R5F processor contains two 64-bit wide 64 KB memory
> banks on the ATCM and BTCM ports, for a total of 128 KB of memory.
> 
> The TCM resources(reg, reg-names and power-domain) are documented for
> each TCM in the R5 node. The reg and reg-names are made as required
> properties as we don't want to hardcode TCM addresses for future
> platforms and for zu+ legacy implementation will ensure that the
> old dts w/o reg/reg-names works and stable ABI is maintained.
> 
> It also extends the examples for TCM split and lockstep modes.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
> 
> Changes in v12:
>   - add "reg", "reg-names" and "power-domains" in pattern properties
>   - add "reg" and "reg-names" in required list
>   - keep "power-domains" in required list as it was before the change
> 
> Changes in v11:
>   - Fix yamllint warning and reduce indentation as needed
> 
>  .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 188 ++++++++++++++++--
>  1 file changed, 168 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
> index 78aac69f1060..dc6ce308688f 100644
> --- a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
> @@ -20,9 +20,21 @@ properties:
>    compatible:
>      const: xlnx,zynqmp-r5fss
>  
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 2
> +
> +  ranges:
> +    description: |
> +      Standard ranges definition providing address translations for
> +      local R5F TCM address spaces to bus addresses.
> +
>    xlnx,cluster-mode:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      enum: [0, 1, 2]
> +    default: 1
>      description: |
>        The RPU MPCore can operate in split mode (Dual-processor performance), Safety
>        lock-step mode(Both RPU cores execute the same code in lock-step,
> @@ -37,7 +49,7 @@ properties:
>        2: single cpu mode
>  
>  patternProperties:
> -  "^r5f-[a-f0-9]+$":
> +  "^r5f@[0-9a-f]+$":
>      type: object
>      description: |
>        The RPU is located in the Low Power Domain of the Processor Subsystem.
> @@ -54,8 +66,17 @@ patternProperties:
>        compatible:
>          const: xlnx,zynqmp-r5f
>  
> +      reg:
> +        minItems: 1
> +        maxItems: 4
> +
> +      reg-names:
> +        minItems: 1
> +        maxItems: 4
> +
>        power-domains:
> -        maxItems: 1
> +        minItems: 2
> +        maxItems: 5
>  
>        mboxes:
>          minItems: 1
> @@ -101,35 +122,162 @@ patternProperties:
>  
>      required:
>        - compatible
> +      - reg
> +      - reg-names
>        - power-domains
>  
> -    unevaluatedProperties: false
> -
>  required:
>    - compatible
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +
> +allOf:
> +  - if:
> +      properties:
> +        xlnx,cluster-mode:
> +          enum:
> +            - 1
> +    then:
> +      patternProperties:
> +        "^r5f@[0-9a-f]+$":
> +          type: object
> +
> +          properties:
> +            reg:
> +              minItems: 1
> +              items:
> +                - description: ATCM internal memory
> +                - description: BTCM internal memory
> +                - description: extra ATCM memory in lockstep mode
> +                - description: extra BTCM memory in lockstep mode
> +
> +            reg-names:
> +              minItems: 1
> +              items:
> +                - const: atcm0
> +                - const: btcm0
> +                - const: atcm1
> +                - const: btcm1

Why power domains are flexible?

> +
> +    else:
> +      patternProperties:
> +        "^r5f@[0-9a-f]+$":
> +          type: object
> +
> +          properties:
> +            reg:
> +              minItems: 1
> +              items:
> +                - description: ATCM internal memory
> +                - description: BTCM internal memory
> +
> +            reg-names:
> +              minItems: 1
> +              items:
> +                - const: atcm0
> +                - const: btcm0
> +
> +            power-domains:
> +              maxItems: 3

Please list power domains.

>  
>  additionalProperties: false


Best regards,
Krzysztof


