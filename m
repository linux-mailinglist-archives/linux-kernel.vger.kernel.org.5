Return-Path: <linux-kernel+bounces-7985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 407B881B023
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE98B1F22A75
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD4216431;
	Thu, 21 Dec 2023 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iVgMlaYb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B9515ADF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-54c77e0835bso624805a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 00:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703146640; x=1703751440; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uLYwiILJNrPOJYFa4MFmqZhds1DmcYKaUvDcrn7HxWs=;
        b=iVgMlaYbKb9M2Wvpo0ToLdx7bd3WGM2wIqRUUwPi6GNVjG0m1acr6gjDdNhih4fw5t
         ZlhaA9IRLwWoEQ+LTvKpTZBPfshDuAMLHjYuD9WNYhOUi3kb7DogYfU4sN40+aFQ+oje
         ffWQjmBvvFHaFas9Cglc91j2n8169mCWBFU86TlbJqcrNR5JaPbw9g61pLQq9pRpA/Gm
         yMIJMMOlvQw0RCAscYI4YZ8E40vkZ6bX/tyB4DLgx/cXcHoZFDAbX5uAcazAdTyMY9R6
         zfbOgZppmJOp8/gbWT3PxmSEjj6VuXnOgd50JhZJPYUWUN/zHrWP5TWRUfAP/gLnslZW
         b8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703146640; x=1703751440;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uLYwiILJNrPOJYFa4MFmqZhds1DmcYKaUvDcrn7HxWs=;
        b=UF2U/C0Ww8N0N+af7d8K72LHZcShle8JTGSfI/zKXWtZASoU/aFAQ076/7iZ8lR916
         MPQ2HRYQZALoRaMYrYm1S59LjqXXD72K1pPUUOIfkrTKza47guXp59/ru8GeGD/WUDho
         fb5w2deJtq5/FrsHE3GoVylUsmbV1mByOnJH/Kq1e4k/lHYXjCoiEpfIYFlJlFIr85VE
         L4ktLTRa3kjYwZ4EDAHOGsgYoHidmF9H48dve4EYdBrTKgM+a/XcLy8owqSMGZxcjGR0
         6EjDX0RfqZoIbgK+i/jEVpJVjDNjHKcJjpc0E+e1Ra9ZEu5fH34GCKKJxd4MX80K54+E
         oyLw==
X-Gm-Message-State: AOJu0Yy+EkIxACD6Gq9T9HgLnqcpQbhjQy0zQhY4dOhh8nTrXT6Z2pFu
	us8apKYlAhNcXCOT9SIBvt3eRg==
X-Google-Smtp-Source: AGHT+IEsUFE3b6ZmMvtVbWhFZG/84+iqBYKb+wDG9qKlpVyyj88WDeMkrGeIi6gVvMIDIeQdW4tF1w==
X-Received: by 2002:a50:c21a:0:b0:553:816f:cf2e with SMTP id n26-20020a50c21a000000b00553816fcf2emr2363423edf.22.1703146640485;
        Thu, 21 Dec 2023 00:17:20 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id m9-20020aa7c2c9000000b00552666f4745sm840485edp.22.2023.12.21.00.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 00:17:19 -0800 (PST)
Message-ID: <c64a41af-ff62-43c5-89f7-0558f8456010@linaro.org>
Date: Thu, 21 Dec 2023 09:17:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: coresight: Update the pattern of
 ete node name
Content-Language: en-US
To: Jinlong Mao <quic_jinlmao@quicinc.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 Leo Yan <leo.yan@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tingwei Zhang <quic_tingweiz@quicinc.com>,
 Yuanfang Zhang <quic_yuanfang@quicinc.com>,
 Tao Zhang <quic_taozha@quicinc.com>, coresight@lists.linaro.org
References: <20231220140538.13136-1-quic_jinlmao@quicinc.com>
 <20231220140538.13136-2-quic_jinlmao@quicinc.com>
 <79f88d35-17cc-43b0-bb22-3c854f89d961@linaro.org>
 <8e5e9603-456b-4956-be03-b866feeeafb4@quicinc.com>
 <c41ff7c8-48d6-4f4f-a9df-aafe953a2e98@linaro.org>
 <f2f983b7-4c57-4b1b-925d-ffb18f6350a0@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <f2f983b7-4c57-4b1b-925d-ffb18f6350a0@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/12/2023 09:15, Jinlong Mao wrote:
> 
> 
> On 12/21/2023 4:12 PM, Krzysztof Kozlowski wrote:
>> On 21/12/2023 04:28, Jinlong Mao wrote:
>>>>> diff --git a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
>>>>> index f725e6940993..cbf583d34029 100644
>>>>> --- a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
>>>>> +++ b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
>>>>> @@ -23,7 +23,7 @@ description: |
>>>>>    
>>>>>    properties:
>>>>>      $nodename:
>>>>> -    pattern: "^ete([0-9a-f]+)$"
>>>>> +    pattern: "^ete-([0-9a-f]+)$"
>>>>
>>>> My concerns are not resolved. Why is it here in the first place?
>>>
>>> Hi Krzysztof,
>>>
>>> ETE is acronym of embedded trace extension. The number of the name is
>>> the same as the number of the CPU it belongs to.
>>
>> This is obvious and was not my question.
> 
> Do you mean why the pattern match of the node name is added here ?

Yes, especially that it is requiring a non-generic name.

> 
> This node should not have the node name match, right ?

Usually. For sure shouldn't be for non-generic names.

Best regards,
Krzysztof


