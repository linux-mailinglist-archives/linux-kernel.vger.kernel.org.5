Return-Path: <linux-kernel+bounces-13280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AC98202E2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 00:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FBCD1F21F28
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 23:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5070214F68;
	Fri, 29 Dec 2023 23:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TGlnMH6f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F87C14F67
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 23:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a26fa294e56so395588066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 15:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703893914; x=1704498714; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+euFWqMJJkXiPS9ThG6gX+dfKUD0ApFu+6/ednPk02U=;
        b=TGlnMH6fFccaGH1UcA3nW9ra6YLe7BXJ5tQa/95AEPaHTZpzb/b5yfoPYlS79ZcNSI
         peWKe4mwv/ilZ2LnOm4PrcU6mr8GypQ6TnZMxw6RfvVxeGlAfEr8uHvqHngZNYJmwOi1
         mBx06T8j0mCEc1BV0uaMYffaFdFCHd3TGZ5ufGj0CxnLqTKZJsLqJOixsYtZtBVz5CkW
         LEf4efJFR3oZeGeiAxdOLQIO5hkwatZa+MNxt6jmv8eIaeGBzfxwOzsMfYHZ9w5esF2F
         O0sr30Bsu2tHTSPck1zP1wMytpqQoz8djWC03COncOzBA1fBkJUtk56SZvWD5t1XrVpX
         6b4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703893914; x=1704498714;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+euFWqMJJkXiPS9ThG6gX+dfKUD0ApFu+6/ednPk02U=;
        b=nnHHkf7c0cJmh4RXZoXiz1Wa4+Lv45UWleXI3GCpjQ22JNEMjpOGtgsHCQr9pRFt3J
         5O1d9RY2V7VD39BYovqINNjXNzPiRSl1D3LRZUwctUCMuJ+OMdE7cgSXXtDBAiRgUcRW
         3l+M+g0TquZIio/p0kFoY4LJN3QRSyeBZcKfXUZWGngwlch6GgK9vHPbBnKblRpmTB7P
         UUrfZAIsCjeYIDzqkHUoT6kWKa5+mw5JM7HdcdO/9sp3a5GRsKCaNu4ryjpPBVB/qzET
         Bw2OMPjzOnJoHz2g++RUh21eBLdxwC+OABHOu7zxLnb3ukBNJVD3nfuNIonmiqeyq110
         fwDg==
X-Gm-Message-State: AOJu0YxJg1e8RS2oM5iPGszmOeyR4bKFZNvulz9sqj14avliQMWSjIHv
	MYB6673eYEVQpUseB/Mi1M9XrD9IxeEBcQ==
X-Google-Smtp-Source: AGHT+IEZLEvgPP3ahYwzenIjDIuESsbwlOQfI4RC7EC8W/b1ijXh/HWo6aIqKz0oVQLeAdy9Po/ghw==
X-Received: by 2002:a17:906:73d5:b0:a23:3bf5:bc73 with SMTP id n21-20020a17090673d500b00a233bf5bc73mr4897253ejl.58.1703893913867;
        Fri, 29 Dec 2023 15:51:53 -0800 (PST)
Received: from [192.168.199.125] (178235179036.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.36])
        by smtp.gmail.com with ESMTPSA id d8-20020a170906304800b00a26a5f80d07sm2256252ejd.14.2023.12.29.15.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Dec 2023 15:51:53 -0800 (PST)
Message-ID: <4e56729e-0549-4075-8f6c-a43c84ae9b9a@linaro.org>
Date: Sat, 30 Dec 2023 00:51:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] dt-bindings: clock: qcom: Allow VDD_GFX supply to
 GX
Content-Language: en-US
To: Bjorn Andersson <quic_bjorande@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold
 <johan+linaro@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20231220-sa8295p-gpu-v2-0-4763246b72c0@quicinc.com>
 <20231220-sa8295p-gpu-v2-1-4763246b72c0@quicinc.com>
 <26617c83-31b3-4ad9-8a61-0b8271fad41f@linaro.org>
 <20231227203048.GB1315173@hu-bjorande-lv.qualcomm.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231227203048.GB1315173@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27.12.2023 21:30, Bjorn Andersson wrote:
> On Fri, Dec 22, 2023 at 09:12:04AM +0100, Krzysztof Kozlowski wrote:
>> On 22/12/2023 05:39, Bjorn Andersson wrote:
>>> In some designs the SoC's VDD_GFX pads are supplied by an external
>>> regulator, rather than a power-domain. Allow this to be described in the
>>> GPU clock controller binding.
>>>
>>> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>>> ---
>>>  Documentation/devicetree/bindings/clock/qcom,gpucc.yaml | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
>>> index f369fa34e00c..c0dd24c9dcb3 100644
>>> --- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
>>> +++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
>>> @@ -53,6 +53,9 @@ properties:
>>>    power-domains:
>>>      maxItems: 1
>>>  
>>> +  vdd-gfx-supply:
>>> +    description: Regulator supply for the VDD_GFX pads
>>> +
>>>    '#clock-cells':
>>>      const: 1
>>>  
>>> @@ -74,6 +77,19 @@ required:
>>>    - '#reset-cells'
>>>    - '#power-domain-cells'
>>>  
>>> +# Allow either power-domains or vdd-gfx-supply, not both
>>> +oneOf:
>>> +  - required:
>>> +      - power-domains
>>> +  - required:
>>> +      - vdd-gfx-supply
>>
>> This should be enough, assuming one of them is actually required. The
>> code. See also:
>> https://elixir.bootlin.com/linux/v5.17-rc2/source/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml#L91
>>
> 
> Yes, that would be the correct binding. But the majority of our
> DeviceTree source does not specify a power-domain for their gpucc.
> 
> While this should be corrected, it seem reasonable to leave this
> optional for now.
Moreover, I think it would be reasonable to add power-domains as
required in qcom,gcc.yaml. IIRC all "normal" (not q6) clock controllers
use at least CX+MX, with perhaps more hw-specific domains for some clocks
or GDSCs.

Konrad

