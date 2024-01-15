Return-Path: <linux-kernel+bounces-26266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8CF82DDBB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B561C21E2C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA39A17BD4;
	Mon, 15 Jan 2024 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tpseYO8t"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A516017BC2
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 16:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a28bd9ca247so1068015066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 08:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705336783; x=1705941583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1s6j+FrysBouv14P98ktCGarV5O8RGCf1PmuuB0Rod4=;
        b=tpseYO8tZGVb4UQ1nnF0J2snj5NMnKQFBD0P5no56iFgD8zpqDopl0PUtPqVCWwgfG
         UAgEFQ3UoBaTYeD3tAL2XDMdZvS8++311WGVOE3W1eRt1cjmhlm1YhaZP41pbZQ1rj9O
         lPQkuEh3TnCrGdXlsN/VBr51CqJRuKE8nXZ2ro2S3atB9u8F1KoA6/pA3Y8P3SBBfOCA
         2OF2k7Kk8J4yWIETIWPyvZXY9nqOzcL0CFaKoLkIF652sCvTKt/TouBVnx5fjomFXliG
         uIfIwvWx/o2TwdbUI5Q2ljuru/h0aJVJQU5KFBcFtk8MSjZI34ZeHXuTJW6w6jDn/gt3
         wlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705336783; x=1705941583;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1s6j+FrysBouv14P98ktCGarV5O8RGCf1PmuuB0Rod4=;
        b=qTpKP3/HGIHaXiJI37+PeSMiokpdNNUoPCZTFdEDJhMpCM/mjf3eM+e8H29YqwtQkF
         mzkw9E9UCQmtFDL1lQ/29lRqbC/Ot68/72O6yy7fxsytLXjSFVdnbUQjAnjubnjJlV7w
         6k+iIbt75jYx16tp47dzvTD7Y1wyn/ZsX8N9P9Eag+re6c5kw7oJ12/6azIcfqSnAvOk
         22/dMDGqQWM7+NXLz05oWr6DySgqnjD1b2edf2sd2agz9M0eUBJCevA6eIZpmDy/Y5NC
         nA1QPgx3xyMTNwJ24/c/EXV7DOdcLfzYGPvvNHJW/HU8s2v/46mYfb81kq92tPxj2v3n
         EQvQ==
X-Gm-Message-State: AOJu0Yw3eMqXlLTHDpoVgbEtiKl/fjCrFXRO2G/0AGTD7bxKaP+ep8+8
	92R975mMgTzeXyKPzQLfIxYj5vJYSuYSXg==
X-Google-Smtp-Source: AGHT+IG23mOFs8vkRBURMu/H8p+Yj+m45958ginxHcSkzR3eWp3MCA1dHVGuF4KPAbil5U/K3om3YA==
X-Received: by 2002:a17:907:10d9:b0:a2c:ab45:13cd with SMTP id rv25-20020a17090710d900b00a2cab4513cdmr2760064ejb.26.1705336782885;
        Mon, 15 Jan 2024 08:39:42 -0800 (PST)
Received: from [192.168.174.25] (178235179017.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.17])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709063bca00b00a2ae69cca5asm5555174ejf.144.2024.01.15.08.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 08:39:42 -0800 (PST)
Message-ID: <c4029b89-dbc6-4035-a122-078d51f4013e@linaro.org>
Date: Mon, 15 Jan 2024 17:39:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: qcom: sm8450: Revert "interconnect: qcom:
 sm8450: Enable sync_state"
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Georgi Djakov <djakov@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240115153420.1525037-1-krzysztof.kozlowski@linaro.org>
 <0d76ebd1-5edc-44c4-80e6-315cf6579079@linaro.org>
 <858d6109-bb6a-41bb-a7fe-e0dd0a16208a@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <858d6109-bb6a-41bb-a7fe-e0dd0a16208a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.01.2024 16:55, Krzysztof Kozlowski wrote:
> On 15/01/2024 16:38, Konrad Dybcio wrote:
>> On 15.01.2024 16:34, Krzysztof Kozlowski wrote:
>>> Revert commit 16862f1b2110 ("interconnect: qcom: sm8450: Enable
>>> sync_state"), because it causes serial console to corrupt, later freeze
>>> and become either entirely corrupted or only print without accepting any
>>> input.
>>>
>>> Cc: <stable@vger.kernel.org>
>>> Fixes: 16862f1b2110 ("interconnect: qcom: sm8450: Enable sync_state")
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>
>> What's the board you're testing this on? And kernel base revision?
> 
> HDK8450
> 
>>
>> The symptoms you mentioned happened for me with this on some recent
>> -next:
> 
> This was bisected, so all mainline kernels with this patch. Reverting
> this patch helps (on top of that commit or on next).

I don't quite get your answer. Was reverting \/ the solution for you?

Konrad
> 
>>
>> https://lore.kernel.org/lkml/f24f32f1213b4b9e9ff2b4a36922f8d6e3abac51.1704278832.git.viresh.kumar@linaro.org/


