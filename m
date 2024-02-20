Return-Path: <linux-kernel+bounces-72732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DE685B817
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74401C22AC8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A021C664CE;
	Tue, 20 Feb 2024 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ln48aDRN"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD03664C8
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422255; cv=none; b=LMIWi5hw/Uc1GGcpWSIBL5AKRJ5ii+X5rntC+qZJi7B/0a01JqdxOsfsv0k8oOj2K9eYmQVp6h0PUb3C/FM4RNIz64BJYtxJrcsNT7I2VHVuZwhIagOvTbDPrgFs6b5ccowTqgteulX6OH9zM71oqGD1gddSeTPAeHz3yVYvMO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422255; c=relaxed/simple;
	bh=aWhU4KZf1+PKiqK9VJ0RJ6lM36mMOZnFCnjB/9WAvpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1PzmCv6k5xuqB8qYIeV1vH2CwnXCx6miFqfXZNQlyhOjOfm900O/T7Ad4cM4hO6Ynn2Tsu1Otayjsve1ffMHmFkJNyrdx7ffjfwQR5gDyS9LAxJciTozQaQ5MYSC87fa4YJSkuyPjJmlQ7r0yF6wLbTykYB+saRIuuCU6gtT9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ln48aDRN; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33d2b354c72so1947002f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 01:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708422252; x=1709027052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D8j+SDown3N+zroKUPSdflj3MV2aNmedcuEvRrakCIg=;
        b=ln48aDRNMJFpYGRcON+IhB/zkM3BihLcDs73QN3qXjvqw2LRnJLD+WK5Js+iUBYYI4
         HRKeFmIZjVrzoovr9wOMrz31vmmQiNuy5am5fcAAvhwAACKBXDWigW+fXzZc5GLrUSfr
         FAmEewYNdqSxjYC0x86wJqYPcFn/aOj42pm2rqCkPE8cYgk7yKrlp5GtHqDae72jGRMY
         mx85f4qxp2OOB+fWp6lw5r+HBQHE5T0kWs6QGaMn4SBBR1Iq4alnzooe7pZZ1VjOG5Vk
         lGNAT8w+ptFqSuNmTvUBRfrsfuc2y2KNNmIo+2MdErertTwu95moa5/fotnmWqFe+Oeb
         whlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708422252; x=1709027052;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8j+SDown3N+zroKUPSdflj3MV2aNmedcuEvRrakCIg=;
        b=fYsm06NzGEEGu+WSA0axyL1+oP5J03hhQuyhpHd8flppDYXg+4F116VLhwOCtbTAYT
         CwUZoRWNdbKEamRrieTfMP+BpqWAfw5R/7s+WOhgHCKw05YhwgxMV5VtYPty1M0X39AM
         QqoQBapyOS+DOae6uh+fHxIqOW4/kMcLnwOmamVNH/uLTnbZMr1ONgSSJteZ2M7B08ed
         tSVRID60yl9kWwTa2MqjlRyvmK5d4Pv1DeLBxnSfyUZHQ4/T7lCTuK4rV9EZ7RuOlbjm
         03dxfgsDPmStgL8TYk9Jmw7ZYb8AiLPrTwgYHbfhi+e+sSKH1ufv5I6VI5vd47n3ML1W
         gMnw==
X-Forwarded-Encrypted: i=1; AJvYcCUqlRFwNWw3OllTD5oE+1nEBxWZrscMhgUGOrtJy+t0IFPmrxaZYj31cEQ9pdMm8THYScCywp15p9E3Uoc6PH6UsWPoEsaj1uil6BnD
X-Gm-Message-State: AOJu0Yxb6CmU83aJE3h+eWdA8PfB9vOMC7mMNrf8ItTBY8bvN8xmKQlp
	Lg0Bp/omjnYg1edTcSPY+Kc2ZCzfRNnrz+lV85YEEBdd0kFVVzXewVLAjeVm6Yc=
X-Google-Smtp-Source: AGHT+IH6tp1ol5hK5ImAhfZxZUSkeYbVTKI95ja152exvbYjcEZqQNq1oYeBTyzx6FQgmA4cCgCrNg==
X-Received: by 2002:a05:6000:1203:b0:33d:1d8a:7d2 with SMTP id e3-20020a056000120300b0033d1d8a07d2mr7673889wrx.16.1708422252302;
        Tue, 20 Feb 2024 01:44:12 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id i13-20020a5d55cd000000b0033b198efbedsm12779204wrw.15.2024.02.20.01.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 01:44:11 -0800 (PST)
Message-ID: <984ba853-a87f-4689-8cdc-60e7f07a37f4@linaro.org>
Date: Tue, 20 Feb 2024 10:44:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/6] arm64: dts: qcom: add base AIM500 dtsi
Content-Language: en-US
To: Jingyi Wang <quic_jingyw@quicinc.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: kernel@quicinc.com, Tingwei Zhang <quic_tingweiz@quicinc.com>
References: <20240205115721.1195336-1-quic_jingyw@quicinc.com>
 <20240205115721.1195336-6-quic_jingyw@quicinc.com>
 <a429f2ab-8c6d-477c-8abc-51243523064c@linaro.org>
 <37ba0703-6a15-48d5-bb07-71d0fa1c5b2c@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <37ba0703-6a15-48d5-bb07-71d0fa1c5b2c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/02/2024 10:11, Jingyi Wang wrote:
> Hi Krzysztof,
> 
> On 2/5/2024 8:35 PM, Krzysztof Kozlowski wrote:
>> On 05/02/2024 12:57, Jingyi Wang wrote:
>>> Introduce aim500 board dtsi.
>>>
>>> AIM500 Series is a highly optimized family of modules designed to
>>> support AIoT and Generative AI applications based on sm8650p with
>>> PMIC and bluetooth functions etc.
>>>
>>> Co-developed-by: Tingwei Zhang <quic_tingweiz@quicinc.com>
>>> Signed-off-by: Tingwei Zhang <quic_tingweiz@quicinc.com>
>>> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi | 409 +++++++++++++++++++
>>>  1 file changed, 409 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi b/arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi
>>> new file mode 100644
>>> index 000000000000..cb857da8653b
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/qcom/sm8650p-aim500.dtsi
>>> @@ -0,0 +1,409 @@
>>> +// SPDX-License-Identifier: BSD-3-Clause
>>> +/*
>>> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
>>> + */
>>> +
>>> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>>> +#include "sm8650p.dtsi"
>>> +#include "pm8550.dtsi"
>>> +#include "pm8550b.dtsi"
>>> +#define PMK8550VE_SID 8
>>> +#include "pm8550ve.dtsi"
>>> +#include "pm8550vs.dtsi"
>>> +#include "pmk8550.dtsi"
>>> +
>>> +/ {
>>> +	aliases {
>>> +		serial1 = &uart14;
>>> +	};
>>> +
>>> +	vph_pwr: vph-pwr-regulator { };
>>
>> What is this? Why is it needed?
>>
>>
>> Best regards,
>> Krzysztof
>>
> vph_pwr is the power supply which differs from board design, it is defined in sm8650p-aim500-aiot.dts,
> and it is used in the sm8650p-aim500.dts for regulator supply, so we leave the node here.

How an empty, unused node is a power supply?

Best regards,
Krzysztof


