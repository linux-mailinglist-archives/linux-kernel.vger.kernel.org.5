Return-Path: <linux-kernel+bounces-14257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B83E5821A12
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24361B21E75
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3535DDC3;
	Tue,  2 Jan 2024 10:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wnk585Hk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD627D515
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3366e78d872so8993663f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 02:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704191926; x=1704796726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6I/ZeMGGOiFDUJYSRFCMtUApKW3uRQm4MZAuRqFbg8Y=;
        b=Wnk585HkUWWDh7ed7ct259xTJu7owl9KJe/5AX/AtroMaCCkAb53mAypDaeuZrm6H+
         N4aHIpDCWq1Ewk56bJ6QqE37m+nQRmDAKLbrKLaQpSrKqSVIWKidibE812iYGdrph1P+
         FbnR+Y2u6DGGXnk7m4wusALyKavAxK5vaqD9h+g7DAI912SHVw76Pvl7wttRX28YNzJu
         2pLXm8Xlg2Mhle/snu6prhYIl6iEegtOE1jJ7sk0WSjdm8LNqs4N1hq7eOWn0X4Lc0YI
         LzlRsgGb7nNzhbLpP3rmLlATs5f39sY/4XBEnyDQEfyYre95ATwt2ViJjPhlDmvjiOYB
         7GAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704191926; x=1704796726;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6I/ZeMGGOiFDUJYSRFCMtUApKW3uRQm4MZAuRqFbg8Y=;
        b=Kd2AQnl8bw+dsREI/zP4p0m+SRXQDwI9MxlZV/jaYaskOTbaXyJQcEK7EfF4vaEkzb
         avT6WSQ14oVK5OEbVRJWBDakqLoJfkmUVbcT+54syZj758BbHwlOUkuRq9EsjVULMa7p
         DaOB1oQVlrO007TBbX77yPEoxQoLoPztp/UXcUSc38T/N+eAzJJvaYnzKE8/uynATzhg
         ko4IXsrtrgwlr0JwH0Hd/068in7QzUGzT+9lx+GxHPRko0LMi3lol+RUTgJUs72H7IrL
         jfY4tH6xEVs5BDwz7t/5txQ6eVlLrQpbMtNTp07hXSGRIb//c9eMDDJS9i+DkU3JgBhJ
         qFSg==
X-Gm-Message-State: AOJu0YzmptxZeETNOmA5yTSHCoGtH8mPK6pBOBFMJkReJqd9zyf5VfC/
	1cOImpKEqYvZCjYToV6FsrIWyysZDRIh6A==
X-Google-Smtp-Source: AGHT+IErOCtDk9wNBdpZ/uy911tsGlu8buysXBUvu2I2VZ6sByz6cS4lYzFvhVejJxiBXN4PQ7DWCQ==
X-Received: by 2002:a05:600c:1ca6:b0:40d:5b15:8df0 with SMTP id k38-20020a05600c1ca600b0040d5b158df0mr2918349wms.208.1704191925879;
        Tue, 02 Jan 2024 02:38:45 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id m2-20020adfe0c2000000b00337464bf723sm1851055wri.18.2024.01.02.02.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jan 2024 02:38:45 -0800 (PST)
Message-ID: <f3ece04e-78a8-4d0a-9bf2-22656e31d491@linaro.org>
Date: Tue, 2 Jan 2024 11:38:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: clock: qcom,hfpll: Convert to YAML
Content-Language: en-US
To: Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231231-hfpll-yaml-v1-0-359d44a4e194@z3ntu.xyz>
 <20231231-hfpll-yaml-v1-1-359d44a4e194@z3ntu.xyz>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231231-hfpll-yaml-v1-1-359d44a4e194@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/12/2023 15:48, Luca Weiss wrote:
> Convert the .txt documentation to .yaml.
> 
> Take the liberty to change the compatibles for ipq8064, apq8064, msm8974
> and msm8960 to follow the updated naming schema. These compatibles are
> not used upstream yet.
> 


> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,apq8064-hfpll
> +          - qcom,ipq8064-hfpll
> +          - qcom,msm8960-hfpll
> +          - qcom,msm8974-hfpll
> +          - qcom,msm8976-hfpll-a53
> +          - qcom,msm8976-hfpll-a72
> +          - qcom,msm8976-hfpll-cci
> +          - qcom,qcs404-hfpll
> +      - const: qcom,hfpll
> +
> +  reg:
> +    items:
> +      - description: Base address and size of the register region

HPLL registers

> +      - description: Optional base address and size of the alias register region

Alias register region

> +    minItems: 1
> +
> +  '#clock-cells':
> +    const: 0
> +
> +  clocks:
> +    items:
> +      - description: board XO clock
> +
> +  clock-names:
> +    items:
> +      - const: xo
> +
> +  clock-output-names:
> +    description:
> +      Name of the PLL. Typically hfpllX where X is a CPU number starting at 0.
> +      Otherwise hfpll_Y where Y is more specific such as "l2".
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +  - clocks
> +  - clock-names
> +  - clock-output-names
> +
> +additionalProperties: false
> +
> +examples:
> +  # Example 1 - HFPLL for L2 cache
> +  - |
> +    clock-controller@f9016000 {
> +        compatible = "qcom,ipq8064-hfpll", "qcom,hfpll";
> +        reg = <0xf9016000 0x30>;
> +        clocks = <&xo_board>;
> +        clock-names = "xo";
> +        clock-output-names = "hfpll_l2";
> +        #clock-cells = <0>;
> +    };
> +  # Example 2 - HFPLL for CPU0

Just keep one example, they are the same. And then drop the comment.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


