Return-Path: <linux-kernel+bounces-1847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 208A68154C2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A08EB20F28
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF963FE0;
	Sat, 16 Dec 2023 00:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A/xx4nPv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A264256383
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 00:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a1915034144so147868966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 16:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702684820; x=1703289620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sN0lvoDPfS7i150aa8oqtPzHJovkS24N6+5HgMNju2w=;
        b=A/xx4nPvBhSvcTuk2uDvfGQCoujAKpuV0ihabeCrtOhCFqoGqH+jSKeuoJNhz0ToE2
         tc/9olBae1u19CLHol3WGxpE2m4I9jRanvabgoYg3RR1C8ld4p5/O0+eW0DH/1FlPkDY
         +qfXyhOGYqdeVFfCc61PoFNh7vZN/AEP/wF1bW30Uf6IzNF97cAuGgp8R1xhpCotJHJf
         fyP1CO9/PHLPa7+ClA6RVbZ3xSbjjGnUA7V6hCIK6lY8MMV49JSEd6oTl1VzpMxsm+9R
         a4AW0EsAKZnnzCCjlFsH06E5jll8mRnPXWaFbly0ZepnJCnHwH+yGgoT7Xq+vcL1eXZa
         vvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702684820; x=1703289620;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sN0lvoDPfS7i150aa8oqtPzHJovkS24N6+5HgMNju2w=;
        b=L1lLhDWKUfuUq16gLOpcoyk/hSK572vxYmvpz6t8VtnxlUQa0Lp49SHsAqO6o/qH0y
         JNxKaLUDAoBsKT/hFClQFeB3I6rqiSo7E+zqkYWOOn7IUDOg5O53ruCwoA3ROkh3YJF8
         Iuwv9Be5N460sBz/535aT9BewOXEnLVbqMl9KMtWUa6O2Wy94PL3Afhx2PorBDnbW1Ox
         ejRmhX7FCsXzJpohnKnVQHRfPwYpP/0pDFHQlKgwtimgW7hhwLGM2rJcjnxYSGxM2nxR
         HR/BBEPxInKeMyW0TptEddbhuhiv9PAVHHHcBuxH8UHRsYAptpWQyQmIa9HNQetUW7Zt
         f1Gg==
X-Gm-Message-State: AOJu0YwgSZLWckHewlTYvucbGd1964o79K5P7ZxKVcYjLYTvxVNFyyyq
	7vjw3MMvEkd6Zxfg0d4o79OxbA==
X-Google-Smtp-Source: AGHT+IG8MdgYoGZ3DHrSECZ1F0U1XNTXqNeUPduzwiH4CmH5pEbm1spSlLj5YGFqele1Hlqsqxi5uw==
X-Received: by 2002:a17:907:869e:b0:a1e:a:12d2 with SMTP id qa30-20020a170907869e00b00a1e000a12d2mr8816400ejc.77.1702684819922;
        Fri, 15 Dec 2023 16:00:19 -0800 (PST)
Received: from [192.168.199.59] (178235179137.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.137])
        by smtp.gmail.com with ESMTPSA id mb8-20020a170906eb0800b00a1de512fa1fsm11201130ejb.186.2023.12.15.16.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 16:00:19 -0800 (PST)
Message-ID: <07e24570-4041-430f-b51e-6ac535218a30@linaro.org>
Date: Sat, 16 Dec 2023 01:00:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dt-bindings: iommu: Convert msm,iommu-v0 to yaml
Content-Language: en-US
To: David Heidelberg <david@ixit.cz>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20231215233034.95789-1-david@ixit.cz>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231215233034.95789-1-david@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16.12.2023 00:30, David Heidelberg wrote:
> Convert Qualcomm IOMMU v0 implementation to yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
[...]

> +description: >
Not sure if > is necessary

> +  The MSM IOMMU is an implementation compatible with the ARM VMSA short
> +  descriptor page tables. It provides address translation for bus masters
> +  outside of the CPU, each connected to the IOMMU through a port called micro-TLB.
> +
> +properties:
> +  compatible:
> +    const: qcom,apq8064-iommu
> +
> +  clocks:
> +    items:
> +      - description: interface clock for register accesses
> +      - description: functional clock for bus accesses
> +
> +  clock-names:
> +    items:
> +      - const: smmu_pclk
> +      - const: iommu_clk
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: Specifiers for the MMU fault interrupts.
> +    minItems: 1
> +    items:
> +      - description: non-secure mode interrupt
> +      - description: secure mode interrupt (for instances which supports it)
> +
> +  "#iommu-cells":
> +    const: 1
> +    description: |
| may not be necessary
> +      The first cell is a phandle to the IOMMU and
> +      the second cell is the stream id.
Weird wrapping

> +      A single master device can be connected to more than one iommu
> +      and multiple contexts in each of the iommu.
> +      So multiple entries are required to list all the iommus and
> +      the stream ids that the master is connected to.
> +
> +  qcom,ncb:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The total number of context banks in the IOMMU.
> +
> +required:
> +  - clocks
> +  - clock-names
> +  - reg
> +  - interrupts
> +  - qcom,ncb
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,mmcc-msm8960.h>
> +
> +    iommu@7500000 {
> +            compatible = "qcom,apq8064-iommu";
> +            #iommu-cells = <1>;
> +            clock-names =
> +                "smmu_pclk",
> +                "iommu_clk";
> +            clocks =
> +                <&clk SMMU_AHB_CLK>,
> +                <&clk MDP_AXI_CLK>;
> +            reg = <0x07500000 0x100000>;
> +            interrupts =
> +                <0 63 0>,
> +                <0 64 0>;
> +            qcom,ncb = <2>;
2012 codestyle :D

Please update to:

iommu@7500000 {
	compatible = "qcom,apq8064-iommu";
	reg = <0x07500000 0x100000>;
	interrupts = <GIC_SPI 63 IRQ_TYPE_NONE>, //preferably fix this TYPE_NONE
		     <GIC_SPI 64 IRQ_TYPE_NONE>;
	clocks = <&clk SMMU_AHB_CLK>,
		 <&clk MDP_AXI_CLK>;
	clock-names = "smmu_pclk",
		      "iommu_clk";
	#iommu-cells = <1>;
	qcom,ncb = <2>;
};

+ Krzysztof would likely suggest to reorder the definitions and occurences
in required: to match this /\

Thanks for taking care of this old junk!

Konrad

