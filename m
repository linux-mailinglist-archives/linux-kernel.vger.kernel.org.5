Return-Path: <linux-kernel+bounces-52430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B883C849800
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 345C8B220F4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED9917591;
	Mon,  5 Feb 2024 10:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PPJmMYYp"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3391758C
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707129965; cv=none; b=ealTVz1mpnw+9dkkLoCMzXNzr2zslqh7BHfVMTwOpd2Gr9Ow7wzs5bI+QJKKXLK41c2OI2X6LqrdkPz2zj7jl08qGAUqBPe5aBe6ilvRb43cTBBUtIQmT/oFhCqcDvvC0i12nKDOj/Jria8qLWJTgJf8spFseBJ5DjsNsFjUnQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707129965; c=relaxed/simple;
	bh=77iFNEHKVIXpZJ3WQ9OokaIFb6o7PkbNxntdJkJq64A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6XokxTUSutevMGSNUquXlyS2fYyJuSPx4UdVOw5pesgu5EnABNxAOa09foPRwEWT0mvGR3TLmo3tjQuENyi/2CJCQS2X2w82AdtPedadLZysMvCpJtVOkVmhXL9kKzRfJh3ChphADgyKXre6fsuDg3TRMM1FswY7RE/OmdV5jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PPJmMYYp; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a293f2280c7so557081266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 02:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707129961; x=1707734761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ntf6XiJg+uquHuohSeB8m4nTdK6afPOnXLG0uSUyh8M=;
        b=PPJmMYYpLnHpIaVmoWQmUy7GD4YL6lvxU1HYofCO8CyS7Megkeu7KxXTUoj70lmJYw
         z+48IFqd+GiGkJU3JQpZsdg8S8VW/5MmSLPV/r6R/RR8c5CeVk7KxSztGu2DtWz7KxGZ
         n5Mg4PjbWPDCqtFckODaoImiticIcxf+Ry1BYhveZHabQBh+m6eAIgVvC4372oNFMy1n
         K31GUrxlvx6c9EXzw14kOmWtFMAFaGQh4hJMRzn88o0OnBfbatQG8+iz5Y/bms1s8ciH
         HqqxwokRGuJTqg3oRcu7eTN5X/nzrn2fiB3YR+EtpmN6DSbHNudGCD0rhhJaBhe3aUDc
         Kbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707129961; x=1707734761;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ntf6XiJg+uquHuohSeB8m4nTdK6afPOnXLG0uSUyh8M=;
        b=vmHPkdMkAIWHV0kgrp4LN9egDeHHULpJIIZqiITX/Vpe9i/stsuV/JEoRXwFZ7YUwx
         bCgW/38A05QFnh+woqZDOpfE2oXPIJW8S7cXhXMsoWaCQh0lmNpiV8X1XPZwCiYjuTsM
         SpHzFH4lK4kr/uyWiqtxeW0zID4Q3bZS8OPbyBV2mURRNJU3n8dE+RbBn8aJlb19HDYO
         cPrLqTrgecNuKZK88J3ZjOm3PqoQn3zYO4IwpxRjHkagQiek/suYK/X3RQBRDMhYcbUI
         Bt4Ln3Iuv2gH0ARvTiX2xIAXQEGGPW3sptyl33mdPm965hS3tauX1/v080x6MJGbKhMB
         gfMA==
X-Gm-Message-State: AOJu0YxxPpitNHq14RUE/8YmLXdjRtMQdjI15uLco+sSX2FjryjYvS1N
	0a4UBMySlVucpSXEypAD32NaEN4++9AOr5sl3rb1vbDlFTqIAVokmm1Zdwvjr8E=
X-Google-Smtp-Source: AGHT+IGS2fF+m31bmpTIjSMkYsRkKhrz1pjJz0TSTSvOWj1cBF4mzEkr7PP+m8+N9Ld9ZJPvnjs5qQ==
X-Received: by 2002:a17:906:6850:b0:a36:436:b188 with SMTP id a16-20020a170906685000b00a360436b188mr12175527ejs.48.1707129961516;
        Mon, 05 Feb 2024 02:46:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUniav8AWoeB0zev9toafaqagXtXc9wwX3Y2pWknITSeHLciNAK6VTsdZ0SUqVfqxVqzj1Fij/JVfZBzQkQE14MLotOEvAczVjwE/EHtxudW/WuwU9QW1tdHXEiZRwuSLsZdoOdFwwDIt6PatL7zN4WwPmH9qoJNzfdUCognN7GhTmwu8nY0KNlQCCZhtxrbo07GC8iOfgyZkVpNBKrwvTYySTrGpx2qP+/CUzM7yR47yrjearqan30U6n3E94tqySBbReMyV4TtKZ+ST4ZdbZ5B/k95FLiln1kPvQ+Cd/IIelf5/tpslerMkjYjZSFLPe67UBPSOUf95QWonaMmphXV7WeW0VxyACr2WhiN8aYXyOmQJYT
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id cu9-20020a170906ba8900b00a37116e2885sm3819603ejd.84.2024.02.05.02.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 02:46:00 -0800 (PST)
Message-ID: <d2313be8-9e89-4ecf-975c-66920168ae89@linaro.org>
Date: Mon, 5 Feb 2024 11:45:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] soc: qcom: socinfo: add SoC Info support for
 QCM8550 and QCS8550 platform
Content-Language: en-US
To: Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 dmitry.baryshkov@linaro.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20240119100621.11788-1-quic_tengfan@quicinc.com>
 <20240119100621.11788-4-quic_tengfan@quicinc.com>
 <04fa81b1-e47e-4cf9-8e59-3a1777a13879@linaro.org>
 <f5ab4243-dd74-4b34-87c4-0073f5585151@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <f5ab4243-dd74-4b34-87c4-0073f5585151@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/02/2024 11:10, Tengfei Fan wrote:
> 
> 
> On 2/5/2024 4:04 PM, Krzysztof Kozlowski wrote:
>> On 19/01/2024 11:06, Tengfei Fan wrote:
>>> Add SoC Info support for QCM8550 and QCS8550 platform.
>>>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>>
>> NAK.
>>
>> Drop my tag.
>>
>> Best regards,
>> Krzysztof
>>
> 
> This patch has been applied by Bjorn.
> 
> Should I remove your tag only, or do I need to do other processing?

Nothing to do in such case.

Best regards,
Krzysztof


