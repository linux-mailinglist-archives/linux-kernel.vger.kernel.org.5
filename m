Return-Path: <linux-kernel+bounces-121688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3BF88EC76
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8D11C31BDB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E7014C598;
	Wed, 27 Mar 2024 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="brS1SRrX"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D077A59B74
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711560035; cv=none; b=AQqhgzsPJr8Wy66lS0iQwe9Q9EA1UeXa7X2SCBUHfGbHp1nyfFb+rDhGrH9be4B7TZhEuxf40YAuBTOHgD3bafy8BTAcRtD0Kw9Pu/7OvKhDHfBUoRPF1NFG5SSNPZxX82XwUYnMIjBCTjVJObHRXPJAsqxkdzMDO9F1bM1vUHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711560035; c=relaxed/simple;
	bh=xT5Spvc9g8iJRVNn1iZAIxuC6G7yQ+ynbDKn2/jOnLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mw2RxXdJk4aHXVuORSFyqniEoVwd+btaHf2Q5K0uO5+ijtawbq3GT3aKx2Mk7FFCFBYcnVL8y1hnnXsY3mB9o5GxXmjiujzV/oSAU2ufvWkrhm4mcuJsVPxDtF8PgNHahrNEZe6pmBLC6bN8MyNHcMWE4MUFMEpCQcBa9eB4f/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=brS1SRrX; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513ccc70a6dso12079918e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 10:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711560032; x=1712164832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hRYCDmPRFOgifWgQbpCQCxcP/wS1sO1XPzx76LdNHww=;
        b=brS1SRrXN1ECzKb2lze2dypcZqwmajAbjm/6nJ7HUFh+hqV0lTbPya3Q59CVwxlJAU
         YxLIei3qk1ctIRMFNm7jXTXdkZ2OLFYqKN64/ErAHNcTcEtBOez1yTY7wVxU7Id5qOso
         I1n/tMJ1QCQcqdLV8RpesdMcwsFYbISQJ1DedYPxDqnFIC8JMqjc/9EDQ61pmn9wAx3h
         oKQGfRVT5lHANSldLTNll/c7NsQQE1oDLw/ZlXAek+43chDeV0oZkaGWgb4gz6iixsci
         DUOFDTH91AFbXuR/9oSSvaCYgMXJ1qvp9xQ+EzifzMp7guZkPyUu3h6KRYz2jqLHDH9E
         omAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711560032; x=1712164832;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRYCDmPRFOgifWgQbpCQCxcP/wS1sO1XPzx76LdNHww=;
        b=B/V5cHgFy1+soA9s04eW7SNsSRm60vNj43e/kE7d+0SllKQsh/RGkeJeTvAjlhQaTI
         FNExWGcKQvAWKkiDdPR9X9AQm1plWlZUxRRsq7InFQEv4TTonMKGYNgcEOe4eAQ3I+LF
         rBw7MJ5RuNCCvBhSdaAY2kjnYzUKL5cORc0UHx8zpTl6fJTmAGohfOx4UR6qG8JqQQ9C
         A28AmyUAGCOmnVZ/AUsLGOOwUWv3qblj1W3UXaTj5q8ZBp1mXdv51PQcP4RiuZEhby8t
         IJQMUFVGRzqftXVtdhx6YvYQEwPU7UHcEORYFWUCydvSBe6mzKp20mkEk9uhug8Eh4RP
         4ZkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzLg7Qdjv1dHgVV+LZXYOGKwnyIIpBZdoJ8Dwy+R/EZGlfWJV63/3vK/hJ6VQiVbyGT8VrvClH1c5TlBbJN1vj05qqAQmAe6pzXa1Y
X-Gm-Message-State: AOJu0Yw6/njAASdjI5F1RUfk2dAmZEggKaptGI95gS/BcYI4IvqXsWWP
	2JRuOdlJOUxFtMsE+XiWbK2bwg4IdbQsJ1YDwCdcYDw2EFwliEjAhSD3oDZlDYE=
X-Google-Smtp-Source: AGHT+IGhHoYyeFQQabzIeWJlouJBfY0hv8v7DFEhXKC2VEZjpoOzWR88IavZZGoOcIkL1YaxefpfFA==
X-Received: by 2002:ac2:5b4f:0:b0:512:fe25:550b with SMTP id i15-20020ac25b4f000000b00512fe25550bmr89826lfp.47.1711560031964;
        Wed, 27 Mar 2024 10:20:31 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id oy4-20020a170907104400b00a4df4243473sm2132632ejb.4.2024.03.27.10.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 10:20:31 -0700 (PDT)
Message-ID: <a8126c44-02c1-4dd3-83a5-c149006b63d1@linaro.org>
Date: Wed, 27 Mar 2024 18:20:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: qcs6490-rb3gen2: Introduce USB
 redriver
To: Bjorn Andersson <quic_bjorande@quicinc.com>,
 cros-qcom-dts-watchers@chromium.org, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240326-rb3gen2-dp-connector-v2-0-a9f1bc32ecaf@quicinc.com>
 <20240326-rb3gen2-dp-connector-v2-4-a9f1bc32ecaf@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240326-rb3gen2-dp-connector-v2-4-a9f1bc32ecaf@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27.03.2024 3:04 AM, Bjorn Andersson wrote:
> The RB3gen2 has a USB redriver on APPS_I2C, enable the bus and introduce
> the redriver. The plumbing with other components is kept separate for
> clarity.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

