Return-Path: <linux-kernel+bounces-7195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5874C81A30F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F517281798
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D082440C1B;
	Wed, 20 Dec 2023 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DW8qqBvB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A51B40BF0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33677fb38a3so1192372f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 07:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703087407; x=1703692207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WW1JG7tjDbMcqaXkDUX/m7k0skMs0TrgqA4/j39oQXs=;
        b=DW8qqBvBXfkFgOZbQZ+Uk+hMewbgSEJyVC9xKrU3oEpt5sbQLJezDfrj1lWZQDW/nD
         JZxjRro/N0jLeqTrJXRBaF5Sx5AIA0MSglHCmvyT2LXDXXf1WVOjfS9kd28xPWzPujuG
         1rh7rifEp+p1xCltPRVd2gncxv7cNI2WVHbSp3aeFoYVNqmaLqX/Hy5By3B4g01f7L/N
         M5eRhj7Nyied7aXAVQUR3DkGBXELX5VwZVUbpvkMGXxK9vkpdcIOKo8M7AbQVN+vqMUV
         Sne84uxKKX4LbJUr/5f7AZlCNSr67uNP1NVi0PGHa35gmm9IOXB0L77Zh/jyYi6g5Mhz
         mMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703087407; x=1703692207;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WW1JG7tjDbMcqaXkDUX/m7k0skMs0TrgqA4/j39oQXs=;
        b=SfxsJNVUZgKa2cpCCUm4Z8x/fAiyL1BPCB6oHec59RLgV8GEiNsF3D/w4dEoxIQUgY
         MzwUP7KszlFX7U0+eTp3rlUia4Oc38GkaBmJeNS2GeqOmMILepogHsaLlobImrFiJo/K
         +yGkQwv5PvKaFgBacHBF16xmMtJuvzeTM0LtaateV7jnwpQ/xBPFqgSNlmWo80Fz0P7e
         c04vGXizIqUzqBPy1TX0N38E8YOxlN9XilDOO7tGXLBGccASsGflowPH9G5wDBu+Y4Xn
         6rgz1GebD0hTSRJwXT8GIIdo0QEBr5yG6k4McIIXIH+VxPx1BUjpPdHA5WQ+9F0ZnObn
         BJ1A==
X-Gm-Message-State: AOJu0YxmQtWI3uT+575ge+vebQmUifpohV2SDH88jK7r/HCFBAnCs0EY
	9X8kbGAqhnqQvwPUxt3tCVUSrg==
X-Google-Smtp-Source: AGHT+IEcemHJ908fymklvuplr7/Vv8UOwfZFA/FigLaHFQnCHK9OcguzDYqHu/WP7NsJV52r3/xiSA==
X-Received: by 2002:a05:600c:5493:b0:40c:7124:962b with SMTP id iv19-20020a05600c549300b0040c7124962bmr3571421wmb.124.1703087406742;
        Wed, 20 Dec 2023 07:50:06 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id bi18-20020a05600c3d9200b0040d378623b1sm40439wmb.22.2023.12.20.07.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 07:50:06 -0800 (PST)
Message-ID: <440e2ad2-ecc5-4888-9923-a172d94c710d@linaro.org>
Date: Wed, 20 Dec 2023 16:50:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: Add coresight nodes for sm8450
Content-Language: en-US
To: Jinlong Mao <quic_jinlmao@quicinc.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tingwei Zhang <quic_tingweiz@quicinc.com>,
 Yuanfang Zhang <quic_yuanfang@quicinc.com>,
 Tao Zhang <quic_taozha@quicinc.com>, coresight@lists.linaro.org
References: <20231220124009.16816-1-quic_jinlmao@quicinc.com>
 <dfc7fe85-7418-410c-bd82-6e08799e6417@linaro.org>
 <439916dc-8f71-4998-b145-1d183d9e68f5@quicinc.com>
 <77ba0140-5b74-40d7-a923-4b270d661d3a@linaro.org>
 <98407ed5-5e0c-4bee-be4c-70b3d8972823@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <98407ed5-5e0c-4bee-be4c-70b3d8972823@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/12/2023 14:40, Jinlong Mao wrote:
> 
> 
> On 12/20/2023 9:21 PM, Krzysztof Kozlowski wrote:
>> On 20/12/2023 14:07, Jinlong Mao wrote:
>>>
>>>
>>> On 12/20/2023 8:46 PM, Krzysztof Kozlowski wrote:
>>>> On 20/12/2023 13:40, Mao Jinlong wrote:
>>>>> Add coresight components on Qualcomm SM8450 Soc. The components include
>>>>> TMC ETF/ETR, ETE, STM, TPDM, CTI.
>>>>>
>>>>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>>>>> ---
>>>>>    arch/arm64/boot/dts/qcom/sm8450.dtsi | 742 +++++++++++++++++++++++++++
>>>>>    1 file changed, 742 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>>> index 1783fa78bdbc..112b5a069c94 100644
>>>>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>>> @@ -285,6 +285,192 @@ CLUSTER_SLEEP_1: cluster-sleep-1 {
>>>>>    		};
>>>>>    	};
>>>>>    
>>>>> +	ete0 {
>>>>
>>>> ete-0
>>> Thanks for the review.
>>>
>>> In arm,embedded-trace-extension.yaml, the node name pattern is
>>> "^ete([0-9a-f]+)$".
>>
>> I don't understand why this binding requires ete name. It's not like it
>> is a generic name worth preserving. Also, the recommended suffix for
>> names is with '-'.
>>
> The number in the ete name should be the same as the number of the CPU.

My question was why "ete" is needed.

> So we can know which CPU this ete belongs to from the name.

Wait, what? Why? Node names should not be for that.

> 
> I will update the binding in arm,embedded-trace-extension.yaml.

No, wait, please finish this discussion first. You need to give people
chance to respond...

Best regards,
Krzysztof


