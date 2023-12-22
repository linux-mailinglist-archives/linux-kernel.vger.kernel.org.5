Return-Path: <linux-kernel+bounces-9691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0110A81C9B2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CB6EB24C6D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73D0182A1;
	Fri, 22 Dec 2023 12:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y74jHu/t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A185B17995
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 12:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e6984db43so560048e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 04:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703246857; x=1703851657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nvgpL3qEBxgU0a2eKbgDbOrM1FwKdSrTGRnjkzSYtp8=;
        b=Y74jHu/tVgBpZDwL0mQ0j5I9klRWx334YLy+tS78nbxsExmV1WkKYkT2MC4rDF2SRH
         o4pu/EqA0Y+s2F53cLNo1wJGFXqB4YMoXb0JgPGw/CnOH4on6h+CyghnyrZ1wMTjY4pb
         OkAyGpTzt6gBwl35/1taiVcGTwwb+lPy1F2SeYBxF3VeM5DZVvk1XpLdfJrObgBExkZq
         fkDzomtAx/cGzpfb9eTwTpGrFpkPUB1l7I4uuWGfkccPCtqLKgvQHtzBWyZQuaQXOwYK
         vFvGHFvXWuGCWspz9eD9uTRizzCRIA9X8RNb+Fg0iNHAtpK4XiCqUnWIjP7IDNUqZXN4
         Nk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703246857; x=1703851657;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nvgpL3qEBxgU0a2eKbgDbOrM1FwKdSrTGRnjkzSYtp8=;
        b=ABHw5/cQsFbMS3XkogZb21rYoCshJlP9cieaY3nb8lBImGqGi1EsiVWppc3FXHAlEq
         2X57XFe8rDwoBt1vgMmSKRTnUPGY4rleElZQr9uWmx4lBNyGo+npFRob565YwQ2S4iIE
         XRu+g9LRbFZ4eM7qpJiSn0AeGXD1sHyOyFDZyT/hlgD+9f+BHpRZxAvORxXfn5tof50U
         KZ/RQ7boz5fAKnVgeuwhy023c9Q0berIXkgZNMvhqEVzJj9QECZCE5l4re/vlCgTzZv4
         LmnC/xArS/fzWQ6u1a2LvX0duXXIpielo/lKW8YxN/y2OQDrpIY3fIJFDBD8R67MKNzu
         DGPQ==
X-Gm-Message-State: AOJu0YzoNnYNHxkuXe4IXo17cUWb7mYnmULpM1Nxz/KyiYH00peukanr
	8mLxi6G/m8Z6CopQgd8wfW6lf0bRZ3JHnA==
X-Google-Smtp-Source: AGHT+IESJiqB2x1rgNMeJY/VGI58lLZz48PlqJXxFZTH15QE3NVtltjaDSQWwzqSSvdmDe/FGXrcHg==
X-Received: by 2002:ac2:48b9:0:b0:50e:1870:1ef2 with SMTP id u25-20020ac248b9000000b0050e18701ef2mr480321lfg.114.1703246856607;
        Fri, 22 Dec 2023 04:07:36 -0800 (PST)
Received: from [192.168.199.125] (178235179206.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.206])
        by smtp.gmail.com with ESMTPSA id f19-20020a056402069300b0054c9b0bd576sm2470850edy.26.2023.12.22.04.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 04:07:36 -0800 (PST)
Message-ID: <94d2c5e2-d75e-4de6-928a-e278b341a02c@linaro.org>
Date: Fri, 22 Dec 2023 13:07:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] dt-bindings: clock: qcom: Allow VDD_GFX supply to
 GX
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <quic_bjorande@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold
 <johan+linaro@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231220-sa8295p-gpu-v2-0-4763246b72c0@quicinc.com>
 <20231220-sa8295p-gpu-v2-1-4763246b72c0@quicinc.com>
 <26617c83-31b3-4ad9-8a61-0b8271fad41f@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <26617c83-31b3-4ad9-8a61-0b8271fad41f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22.12.2023 09:12, Krzysztof Kozlowski wrote:
> On 22/12/2023 05:39, Bjorn Andersson wrote:
>> In some designs the SoC's VDD_GFX pads are supplied by an external
>> regulator, rather than a power-domain. Allow this to be described in the
>> GPU clock controller binding.
>>
>> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>> ---
>>  Documentation/devicetree/bindings/clock/qcom,gpucc.yaml | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
>> index f369fa34e00c..c0dd24c9dcb3 100644
>> --- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
>> @@ -53,6 +53,9 @@ properties:
>>    power-domains:
>>      maxItems: 1
>>  
>> +  vdd-gfx-supply:
>> +    description: Regulator supply for the VDD_GFX pads
>> +
>>    '#clock-cells':
>>      const: 1
>>  
>> @@ -74,6 +77,19 @@ required:
>>    - '#reset-cells'
>>    - '#power-domain-cells'
>>  
>> +# Allow either power-domains or vdd-gfx-supply, not both
>> +oneOf:
>> +  - required:
>> +      - power-domains
>> +  - required:
>> +      - vdd-gfx-supply
> 
> This should be enough, assuming one of them is actually required. The
> code. See also:
> https://elixir.bootlin.com/linux/v5.17-rc2/source/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml#L91
At least one of them indeed is, though this change is being made
implicitly. No clock controller works with no power FWIW

Konrad

