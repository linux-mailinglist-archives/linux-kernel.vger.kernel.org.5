Return-Path: <linux-kernel+bounces-59445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB0884F738
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C966C1F221C5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658C967E83;
	Fri,  9 Feb 2024 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cxsEHkRi"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3894364D6
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707488674; cv=none; b=emz+kutqTgpj3mcesswh8M5JfugzOK8r4JALBfhrc6bWOk0a7yMQmM7ZIwp/zg+xwtpQWqcZPqaOpP6yewUWjSTL4ZFTJmkR9FhXEAC9pwoP9FtTOMmCZT5SVOUrojXXElH5FdH4jIG3DrH4g44m2HLQScsg8SzSHz7n9yPjxaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707488674; c=relaxed/simple;
	bh=DxV7YSPawRh31Po7R+5GcnGrbzeh2t0F2vuW2JJUjxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PNT1L3MOlpsc2w3BLT6+VXajuiaRvoIw0Js0jCxqlWLrO+GrfSLvNx9eUGBJjtCUoyvzjJf5utTQ/MFxuHBhlBRrGJNj6M0twd0XJUk5I5nPkgL7iUIBbsB15oJ4k3Uho5ArnRZvJH6rSym8ped/Znv7I8huAcMUvlRcOQAm3io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cxsEHkRi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4105006bf11so8344575e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 06:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707488671; x=1708093471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ked2MqjaX2cujQETK86IxsZc7hmPyzvg7wjxmlrSOJU=;
        b=cxsEHkRilby7OMUNGh6UU/S/Z++gZKmsOyNKDuy6akrkC5qKAqEsGI/2Oo/9HJodNK
         1rZ6BwfNMZfllm7JbB30tmObZ566shYrPicLewGSzy3JUtnCCviZRJDznLUY1z4XejzL
         ujC0hG2eVGnO9dX/ru/KsKK5aQryRQiV4+Jp194btJnPKed5ukTs88YF5hNvMZAoLuI7
         Sh2z8R5Wo+fI4J3I+FNCFojDC9JaINGc3xYnHWi+GfVk3AlOwvyfN69Hdv3+1lwYK5en
         Q3funX1kl4yMjKGhapXEfC5wvkq7gTl28xug5Py5ox5PEOGyoAxOshOvfwYDAuGeoNxG
         XtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707488671; x=1708093471;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ked2MqjaX2cujQETK86IxsZc7hmPyzvg7wjxmlrSOJU=;
        b=GvXIn6U90U0kPygJCF8igLlAwpS43sPNAm3JDNOVMH7YkMD0eIS1P6U9dVeZyOD854
         QZCcDoEIF/IqOFu+b4CWmZ+8iM5Mt4f3z2wxOH1jb6fz1o+EmSjlPdYQ+eKAOGm1qMyA
         XjWh9cEMCPfNyYrr4BzTE4O/PQbCeA1/2lLWe8/USrqVn6qdq2b9LS0asmQ3xYwuoKGu
         UMkfh6xMe7GnQPLKwtS6ukWTLoq9Qaks4luRy2B+6Al4fwRsVgtxByGVM1wuCLSTQelS
         3+vcjmw6APV5sh2jIqGFrSf1wlGDQxbzJmJatKwqclHsXkOuCV4OlGxnNNn7FdLHfcGB
         1x4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkMGFkQucdrkLeNU735kfXVp+mNt2wU3j9AIaiRKPaxqroS3vYmnpVqdjsCNqK13ThcMpyVS1BcyGbJHTC9B/hbHtvxRWowdBjEeIH
X-Gm-Message-State: AOJu0YwlW3W6aGwPyNfi3ejRpyyKap5LV9zjKeEIy4mUuN0KhsQ7fFJp
	E95SF012o5XdaFeUmxggKrIo+lU98FlrsxbpDFvesdmu2IKHHxumsPgdd0HZZgqnNBgfCN/1PLa
	6
X-Google-Smtp-Source: AGHT+IFps+rRfvOTYoKiJfhV4c5v4Lq+vUJVTSme5DpRi3bRpnbvzjEXP/q+nIKx9DW15WVSj7/iaQ==
X-Received: by 2002:a05:600c:1c25:b0:410:273:c648 with SMTP id j37-20020a05600c1c2500b004100273c648mr1380559wms.0.1707488671013;
        Fri, 09 Feb 2024 06:24:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWpyuWJhq+fcd1DG3FJ4iUARI5stA4idAgFG3oA66KUxRShbB6vv/FfNBsG9nOzmzfX30l+/BikX3AfSu0rDkh0Nb7N3H4Acn07EYXGrtRJScHXszxyKqJ38VV3QxMAzAtey2joEtv7MhQ91BUDZ/nmCkOBWVWDEWW1jbXOo6k7+mb90yBsntkTnkQqpxKnmX++tSbkiJ2kf4WlsLs618Q2C/U2qTiaPyAaxP74v/oxREME3EvfEc3Ii5jVDOPJ2Gngh0bWNBdlm9KfIj1snDHvzzdfv7g//nctrwkd0U6L2PHZ815zPbskLmzLDhegsr5u0ndFgIwpUOpeXjaFukn+S+XGiNwLH+H0PeNBSY41QvdhCK0IbjWjzQ==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id c3-20020a5d4cc3000000b0033946c0f9e7sm1932146wrt.17.2024.02.09.06.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 06:24:30 -0800 (PST)
Message-ID: <f0f52ab1-6c73-4c8c-96c3-fc3d0174223d@linaro.org>
Date: Fri, 9 Feb 2024 15:24:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: Enable GCC and interconnect for
 QDU1000/QRU1000
Content-Language: en-US
To: Komal Bajaj <quic_kbajaj@quicinc.com>, quic_bjorande@quicinc.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 arnd@arndb.de, geert+renesas@glider.be, neil.armstrong@linaro.org,
 nfraprado@collabora.com, rafal@milecki.pl,
 Konrad Dybcio <konrad.dybcio@linaro.org>, catalin.marinas@arm.com,
 will@kernel.org
References: <20230822132333.17580-1-quic_kbajaj@quicinc.com>
 <b4d7d4cf-5bee-492c-819d-79af01e73cec@linaro.org>
 <14cfbfe0-de9f-e81f-60d6-5c8a6496d816@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <14cfbfe0-de9f-e81f-60d6-5c8a6496d816@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/02/2024 14:53, Komal Bajaj wrote:
> 
> 
> On 8/22/2023 7:54 PM, Konrad Dybcio wrote:
>> On 22.08.2023 15:23, Komal Bajaj wrote:
>>> Add the QDU1000/QRU1000 GCC and interconnect drivers as built-in.
>>> These are necessary for the Qualcomm QDU1000/QRU1000 platform to boot
>>> to shell.
>>>
>>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>>> ---
>> Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>
>> Konrad
> 
> Can you please apply this patch?

You did not send it to proper folks and lists, so I would say: it cannot
be applied. You can easily check: go to MSM patchwork and look for this
patch.

The rule is the same for all SoC architectures - the SoC-related
defconfig changes go via SoC tree, so please follow CC-list for MSM and
resend with correct addresses.

Best regards,
Krzysztof


