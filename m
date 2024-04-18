Return-Path: <linux-kernel+bounces-150782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2918AA488
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6DB9282C5A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3E4194C6A;
	Thu, 18 Apr 2024 21:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jb0WozuY"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B215B165FD6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 21:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713474113; cv=none; b=u0t6WsF94ZiAMSZeQoMDi+9rN6z6ZP33dmpWPtFsGO28t8r1noiT5Hd8Ghj2HYQ6NRbbJznE6TDsOa+OnurIwhG2Pc+aL1qXaLd0Vd+lq8+CSsxuobdzUozkacq/2/yca0pNd0609XA5XdFPz2bsQB09S5FzNzhtyQvVAYzLf/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713474113; c=relaxed/simple;
	bh=7CdVP5Kj31ni265PFLdukb0vu5F9fG0Y+00FI3capLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpS4C/iCJVgqR6JKIAnPKxFvbub2JJCtBprEPJY+FkIn1jgVpneivroAs4Z65qpUTF3yYiW+5W00AstUPUujbhjjcpY/8dPcnnJGyl0hLoR6TYMX+kd2WY3nTQ6VIftCTvfQ0WT6hoWZZ+B6lPSJyO5sPV48evKqexpGdQs5R4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jb0WozuY; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d87c661031so256221fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713474110; x=1714078910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K1Eg8XAotf29L29Zp7YHNAD+JmxvqCaer9g5b5fj8ko=;
        b=jb0WozuYXi0p9JhP7epzMRfp6eV8eVBpuC7KZD5+2OTrjMYN1VJ9CR8wZLyVvStZ6I
         DM5QiA0u2e7Zc18r7gRKXwr1mJWzYgwLVqSoEADIWXXdbsMLyZwmgZeTyaM/csngA9cu
         hoY7PHegqXuB2Rux06QlP4bQkbEP53xozKTQzhw8x48IyXU+PqM97td6b9F2P388jnI5
         Q/4WBBjSyv2KsMsl7csdHSfaS4WOVAS7FD5E8sjQ2bztUI13sKHWAfLYZ/6Cltm/OFGj
         0Qd7kImULFKZJl5/FXnobUCB0dc4g2CKUvP8TzKs7qEUiCk7Vs50R1nrfMr0KLJz2kUo
         Dekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713474110; x=1714078910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1Eg8XAotf29L29Zp7YHNAD+JmxvqCaer9g5b5fj8ko=;
        b=K6DK36sovX4dq4qR4sGCK7aHl9NRHk4pEtg5V+cGWcbqN0VXfECpBavPLQgNtNsJHX
         xBJTVF+WlPl2dzarTFYHRDPIlQdgrt+g+0qMrtbXa9Gces1sNqBAbc8zNdLn/socak8/
         sPk3FmySwaLEdOKlmCY77U3Iey/UX61Wme2wrafEPtTPYCbAU9+XjzVK/xIw4/50F5E1
         zWCYnh0i8gTFKATgPJj7fjuJ7uahAaXlVgTwEX1hrQ13OUW+RyaI3aISLEsch/U3ZtyV
         b3aWB+LuDj+pqAY/PuWU0XhaUHyiVjZh8mHPNLiBvggUGFrkDreXo6aTMLDogu2COF6O
         y51w==
X-Forwarded-Encrypted: i=1; AJvYcCU5kDzKLediThicz6e/jIPVFkaykkOTmaQoNbjTIJWYNTc1Ws6TH+e+FlE6plw7RjoTtMc+NxzLIGFl08RzFBUefVOs8BQexi4j/gTq
X-Gm-Message-State: AOJu0YyFD7VjoVR1Clwy+7lZwKj8y3nmKsD8/7vOqHaqtKvuMDniczPm
	1hkmHgD7lY4wo7adWWEzdy6fvY01DSlyAsiNsySr9WsFXpIoSYdE+8Yi4PKp4g8=
X-Google-Smtp-Source: AGHT+IGO7E0wKPCpyQwkhAvJUDIjqNmSsoDbzNbd01heBkjJR5epON3YpCVJX3hcRVc6iX6QO0bVng==
X-Received: by 2002:ac2:464b:0:b0:519:69c6:29bb with SMTP id s11-20020ac2464b000000b0051969c629bbmr111728lfo.0.1713474109808;
        Thu, 18 Apr 2024 14:01:49 -0700 (PDT)
Received: from [192.168.1.102] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id e28-20020ac2547c000000b00515d407aaa0sm379193lfn.252.2024.04.18.14.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 14:01:49 -0700 (PDT)
Message-ID: <c3ea22ed-5750-438f-89d5-e56f908ba835@linaro.org>
Date: Fri, 19 Apr 2024 00:01:48 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 RESEND 1/6] dt-bindings: clock: qcom: Add SM8650 video
 clock controller
Content-Language: en-US
To: Jagadeesh Kona <quic_jkona@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
 Ajit Pandey <quic_ajipan@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240321092529.13362-1-quic_jkona@quicinc.com>
 <20240321092529.13362-2-quic_jkona@quicinc.com>
 <CAA8EJppsMchthssctEgUf9q45j84cSLQ78Ur+vaA0Z7GEQi8+g@mail.gmail.com>
 <725471b1-46a9-43b0-bede-33f01c953d51@quicinc.com>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <725471b1-46a9-43b0-bede-33f01c953d51@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Jagadeesh,

On 3/25/24 08:07, Jagadeesh Kona wrote:
> 
> 
> On 3/21/2024 6:42 PM, Dmitry Baryshkov wrote:
>> On Thu, 21 Mar 2024 at 11:26, Jagadeesh Kona <quic_jkona@quicinc.com> wrote:
>>>
>>> Extend device tree bindings of SM8450 videocc to add support
>>> for SM8650 videocc. While it at, fix the incorrect header
>>> include in sm8450 videocc yaml documentation.
>>>
>>> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>    .../devicetree/bindings/clock/qcom,sm8450-videocc.yaml    | 4 +++-
>>>    include/dt-bindings/clock/qcom,sm8450-videocc.h           | 8 +++++++-
>>>    2 files changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>>> index bad8f019a8d3..79f55620eb70 100644
>>> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>>> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>>> @@ -8,18 +8,20 @@ title: Qualcomm Video Clock & Reset Controller on SM8450
>>>
>>>    maintainers:
>>>      - Taniya Das <quic_tdas@quicinc.com>
>>> +  - Jagadeesh Kona <quic_jkona@quicinc.com>
>>>
>>>    description: |
>>>      Qualcomm video clock control module provides the clocks, resets and power
>>>      domains on SM8450.
>>>
>>> -  See also:: include/dt-bindings/clock/qcom,videocc-sm8450.h
>>> +  See also:: include/dt-bindings/clock/qcom,sm8450-videocc.h
>>
>> This almost pleads to go to a separate patch. Fixes generally should
>> be separated from the rest of the changes.
>>
> 
> Thanks Dmitry for your review.
> 
> Sure, will separate this into a separate patch in next series.
> 
>>>
>>>    properties:
>>>      compatible:
>>>        enum:
>>>          - qcom,sm8450-videocc
>>>          - qcom,sm8550-videocc
>>> +      - qcom,sm8650-videocc
>>>
>>>      reg:
>>>        maxItems: 1
>>> diff --git a/include/dt-bindings/clock/qcom,sm8450-videocc.h b/include/dt-bindings/clock/qcom,sm8450-videocc.h
>>> index 9d795adfe4eb..ecfebe52e4bb 100644
>>> --- a/include/dt-bindings/clock/qcom,sm8450-videocc.h
>>> +++ b/include/dt-bindings/clock/qcom,sm8450-videocc.h
>>> @@ -1,6 +1,6 @@
>>>    /* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>>>    /*
>>> - * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>>> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
>>>     */
>>>
>>>    #ifndef _DT_BINDINGS_CLK_QCOM_VIDEO_CC_SM8450_H
>>> @@ -19,6 +19,11 @@
>>>    #define VIDEO_CC_MVS1C_DIV2_DIV_CLK_SRC                                9
>>>    #define VIDEO_CC_PLL0                                          10
>>>    #define VIDEO_CC_PLL1                                          11
>>> +#define VIDEO_CC_MVS0_SHIFT_CLK                                        12
>>> +#define VIDEO_CC_MVS0C_SHIFT_CLK                               13
>>> +#define VIDEO_CC_MVS1_SHIFT_CLK                                        14
>>> +#define VIDEO_CC_MVS1C_SHIFT_CLK                               15
>>> +#define VIDEO_CC_XO_CLK_SRC                                    16
>>
>> Are these values applicable to sm8450?
>>
> 
> No, the shift clocks above are part of SM8650 only. To reuse the
> existing SM8550 videocc driver for SM8650 and to register these shift
> clocks for SM8650, I added them here.
> 

In such case I'd strongly suggest to add a new qcom,sm8650-videocc.h file,
and do #include qcom,sm8450-videocc.h in it, thus the new header will be
really a short one.

This will add pristine clarity.

--
Best wishes,
Vladimir

