Return-Path: <linux-kernel+bounces-87958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC6D86DB7E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 286CAB2473D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF6A67E69;
	Fri,  1 Mar 2024 06:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DGiDOzLd"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441A68464
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 06:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709274777; cv=none; b=aHl9bd+ytRtOwFsDsBcx2ZM4ZgN9qQ/nmH5rtPfmLzgZlrJKAjfea1AmtHMDvOFdMx3Q+ouNEuZR4KnJNXHGI9qi6WwV6xW4oOQray1QZHNW5T44cTlUzdeIB9fiAy9iEVjfd8qsiSSJfQ5yeekAFe1sgnCuashAgUmgmYXXvTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709274777; c=relaxed/simple;
	bh=mI78DUW4wRxHNnJ1fs9e0sGJgx2bZduxuF0FBg2vXOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O3j82QTZkGtnW/43aGP+T0IBGg/Z9stDOAX6Kp+K80ljVfAzfgpIM5a7SZ2Ad59EXu0UDqSVigfu1MhYsjlABzJfcdw5A3BO6sBJR4VSdGJ374VbtqCsZG04cD53FtogAld1v2bumYsUoAMF1cwIcXUnpouoRjBqEe2/Jnh6m5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DGiDOzLd; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso2356717a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709274774; x=1709879574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UBVbyEBm0jBwXAyNNz88x9yj2LmG9W+zbm9SeSAk2ZU=;
        b=DGiDOzLd15lzxedksKlgD+Ff6KPqyp3dT/xiz2nukRD+8DvBwbPjdu+lPjKBN1VpeK
         FJfVEAkHS8ZRAyUAE+O/wJM5yBv82+oeOLdxk8COchgmE4Nltwnsl+jMCTLeK2d6p/vH
         BPScUZYrh0GbYFwiNu4cH5ZLoaQm5RljWdzpWsWe1QUgbBLH6snR2vIEV3ztWOZI1Aav
         Rl5fK4K/OErTkeriS7BiUvMLeaJVGYGFwY6nSbMZG4q8bDABlTYhJEfMz3jLxsAEBt9H
         JPIdM6Me5AG1vPv8mlFTzX9/liCOvCxKyrIEcwNTsQploFX13p4RR13Xel1F5t0eQSdI
         hIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709274774; x=1709879574;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UBVbyEBm0jBwXAyNNz88x9yj2LmG9W+zbm9SeSAk2ZU=;
        b=n4n0vgdO7IYfO6rRhsZg2gTLYPueZS0X2WL227r9GqG6CtMVyaUeFBF5ybx2KPO5o0
         zj5YXjk3d9lBrcB+fSa2m3E9Eb7Iq/HqMzdD0lad4QvbvukQBRROTP2pDE2wRAWQKk3u
         c4y5zxyYrUV6r4Id0ekGWLtJpDC5siYVAXhBcov5ZuSWdVNXztKuYyACQ8SxaWPjPJUZ
         EClNXuN8CRm0RueV5d0/72GHvKU7TvmsTaxm0wCeMsKurOMWmV6lAIplmTQJstjat3IZ
         bxjo4/FNZME6oTUr3EqSSa5VDsR96IMMdJW53YKFlHuXtvrvCq1S5v540z5YxBwLbBBP
         FL6g==
X-Forwarded-Encrypted: i=1; AJvYcCWCdqcs1CJyxWWja24ejSrsqmDaIsJpybmVbuxA+S81zvVLJV3OgQmGO33wOnMtgazm/wxYSJ1cHxraKWOi5tA5SP5TCahjwLmjSMQy
X-Gm-Message-State: AOJu0YyEXuSEgqDyQtllrtncyXaNxwxWxI6jhynBAVvuF7/F1m7BNPkV
	Iyxm8gZah/VEpnG2/SOCdMm5MVLTy++jxtGI6VUJcQU3+Khy/RUgsf+GQVDmQBk=
X-Google-Smtp-Source: AGHT+IEboVE7lWGpBbTfZVGSdlk76ia333DmjtLgj1yYru/QE+sNcc8EuVlz5nyjr/xffSGOtzngBQ==
X-Received: by 2002:aa7:d88f:0:b0:566:d6e4:7d1b with SMTP id u15-20020aa7d88f000000b00566d6e47d1bmr307997edq.41.1709274773419;
        Thu, 29 Feb 2024 22:32:53 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id y26-20020a056402135a00b0056694006fa7sm1263001edw.70.2024.02.29.22.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 22:32:52 -0800 (PST)
Message-ID: <688d4d83-86dd-423a-a401-9cea262d83c1@linaro.org>
Date: Fri, 1 Mar 2024 07:32:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] dt-bindings: iommu: Add Qualcomm TBU bindings
Content-Language: en-US
To: Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
 Georgi Djakov <djakov@kernel.org>
Cc: Georgi Djakov <quic_c_gdjako@quicinc.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, will@kernel.org,
 robin.murphy@arm.com, joro@8bytes.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
 robdclark@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 quic_sukadev@quicinc.com, quic_pdaly@quicinc.com, quic_sudaraja@quicinc.com
References: <20240226172218.69486-1-quic_c_gdjako@quicinc.com>
 <20240226172218.69486-2-quic_c_gdjako@quicinc.com>
 <b6215fcd-29fc-4495-999f-b7b03b36c087@linaro.org>
 <70095e04-eaec-4323-b2ac-2d4d366763d5@kernel.org>
 <20240229222347.GA918@hu-cgoldswo-sd.qualcomm.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240229222347.GA918@hu-cgoldswo-sd.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/02/2024 23:24, Chris Goldsworthy wrote:
> On Thu, Feb 29, 2024 at 10:09:34PM +0200, Georgi Djakov wrote:
>> Hi Krzysztof,
>>
>> On 29.02.24 19:53, Krzysztof Kozlowski wrote:
>>> On 26/02/2024 18:22, Georgi Djakov wrote:
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/iommu/qcom,tbu.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Qualcomm TBU (Translation Buffer Unit)
>>>> +
>>>> +maintainers:
>>>> +  - Georgi Djakov <quic_c_gdjako@quicinc.com>
>>>> +
>>>> +description:
>>>> +  The Qualcomm SMMU500 implementation consists of TCU and TBU. The TBU contains
>>>> +  a Translation Lookaside Buffer (TLB) that caches page tables. TBUs provides
>>>> +  debug features to trace and trigger debug transactions. There are multiple TBU
>>>> +  instances with each client core.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: qcom,qsmmuv500-tbu
>>>
>>> Why we don't have SoC specific compatibles? If that's for SDM845, then
>>> it should be qcom,sdm845-tbu or qcom,sdm845-qsmmuv500-tbu
>>>
>>
>> Because they should be all compatible (as registers). Adding a SoC compatible
>> might get overly-specific, but i can also see the benefits in that, so ok will
>> do it!
>>
> 
> Hi Krzysztof,
> 
> JFYI that the TBUs are used on our mobile SoCs going up until the SoC
> we commercialized in early 2022, Snapdragon 8 Gen 1. Including SDM845
> there are three more premium tier SoCs using TBUs plus all of their
> value-tier derivatives.  There will also be prior generation premium
> tier SoCs along with their derivatives that use the TBU as well. Does
> it make sense to have a target-specific compatible string given this? 

This does not explain me anything. Why an exemption from usual bindings
rules should apply here?

https://elixir.bootlin.com/linux/v6.8-rc6/source/Documentation/devicetree/bindings/writing-bindings.rst

Best regards,
Krzysztof


