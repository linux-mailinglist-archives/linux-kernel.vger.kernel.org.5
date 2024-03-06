Return-Path: <linux-kernel+bounces-93421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD5A872F84
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDC6AB20FC1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC585BAEA;
	Wed,  6 Mar 2024 07:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UfBOrtcM"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368A35BAD4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 07:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709709773; cv=none; b=oaBcKjohkU6Q5g4duLkyGzH567qJbTUCQZQYXEPV19fU0nUvo5K/PhJH+/GRdqfl9We+C0+WeL/DHF66PeFpwnvwEM+V6Rg9ks0UJCTDz8TUj6rg7NnRyRkkQhQn7Q2usayHhhWJ5Ev9Rx7USFVc8tHM7sHkGIHaRQm57fcixOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709709773; c=relaxed/simple;
	bh=BNawQSYenadVQ3wJw5cVJLNmDPC3u6fmfMYQGZd7weg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VMgaq7sNvdVLMiLXozaSMRbwtz0LFYzP7FqxcFa4TDNp+LdT1lF6fRtRQYsan8jTeWoaDWKXN7i/RwG7PUoAYAOJM2DYs8CX4gsQ7UuTbtkvtfnZNA5xOJIfF2x8XyvCKevZYU32QeWqgvzJPuL1ti/3+lbqEN8KpPTySCYD72Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UfBOrtcM; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so9281009a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 23:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709709769; x=1710314569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lA08Rjqfko7iEZFn5QeJ0rJtCYEJAgfrdf2O814ABAg=;
        b=UfBOrtcMwYIe+WQ+4hzp6dhHjVsohABP/R/FIxwq+WC7TgMcnZzP0dNSleX0RyB6Uc
         Cj2nDqWs6fu9vmsw2SIi9h3Yfxwe56LfZEx5iSwqrQoS+/zPofSQPFI700fp5UYqcp+j
         QxwRQOETxtbK+1aYpsrdEpvfHssZGxV2mr7xN4gAMQ9O46KCxbxc/iI8/wiaq9AnLybe
         nv+G7NP+aCFbYj9EMPjGJzoi00tIyU3Q68LesEVO2418sbb19nLzR8eKQxmvuTun2Ggj
         1Ddr5GLH5+Bb9Xot9IvwHEbcAr6bxtbDqp6vDtX+umXfDNmBq3twHz5MKg3JLR8dac0j
         2y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709709769; x=1710314569;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lA08Rjqfko7iEZFn5QeJ0rJtCYEJAgfrdf2O814ABAg=;
        b=we3UXDv+hz5USJXxkE62NpTaFQhlCq2b/4/mZHMmiIxOiTaOjpv+mo0oaMFb44sot/
         CSuRscZZ6Va1s399gd+kN/E1uss5/gX+EdCsG+dWE9kWsmD3MLZPEidA0gTzRg66RaKp
         ehVhYrfVFQTTVSlc4LfWKtg7GfUv1eAlMUd1vI81hvIi7zyLef7eZhb4nirK/06v7oMI
         Y6u2rAv4BHvPIVFRaYx1U2DHmH5fJ+aLDrV6nGNba0bAtkkrCHpGCikl4DsnITSiGZ0z
         F3cNsyZ73+mDFYgJVA1Pyb4O4SxdTxjWys5Hv4PDblt0qOgtK4VJxIoN63gNAwb4EAWT
         2Z7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZGvdEu9KXNy9vaWurDka4uBG4rhdHInDmN3C1tQGW/DJfJG/DoxzTcwmoWWEYN5JeE5YsDNlVZrYlc557LxnYVmUclPcItqTfX2HP
X-Gm-Message-State: AOJu0YzM5TdXVND0EyKr0Q94/NXKNYPiuBTXspQk7mxxyazXP59S4i99
	7mKaXlceuHdLPvXMY35grtntkejVeOIlkvkYqXioToCnbEU5/LsqXFLw7/yom3o=
X-Google-Smtp-Source: AGHT+IEq4s7yF3TfT1R4kl+SiJgkepnTcKTJTHZndXGyBx2qknsZbGeHN+9yoVsFBJndNNXuP0+GOQ==
X-Received: by 2002:a50:cb88:0:b0:566:1fbd:22bb with SMTP id k8-20020a50cb88000000b005661fbd22bbmr9902602edi.9.1709709769523;
        Tue, 05 Mar 2024 23:22:49 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id h7-20020aa7de07000000b005664afd1185sm6611791edv.17.2024.03.05.23.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 23:22:49 -0800 (PST)
Message-ID: <87e0aa08-9176-495d-b799-c2ddb53c8a23@linaro.org>
Date: Wed, 6 Mar 2024 08:22:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cpufreq: qcom-nvmem: add support for IPQ5321
Content-Language: en-US
To: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240228-ipq5321-sku-support-v1-0-14e4d4715f4b@quicinc.com>
 <20240228-ipq5321-sku-support-v1-3-14e4d4715f4b@quicinc.com>
 <20240304071222.cx3s37mphddk23bv@vireshk-i7>
 <20240305043503.tgy5ahl243or7lm5@vireshk-i7>
 <c82e4053-4cef-4010-a734-4dc537574201@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <c82e4053-4cef-4010-a734-4dc537574201@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/03/2024 05:40, Kathiravan Thirumoorthy wrote:
>>>
>>> Applied. Thanks.
>>
>> Dropped since the previous commit it required too. Can we get the
>> necessary acks for me to pick those ?
>>
> 
> Sorry for not mentioning the dependencies.
> 
> patch 1/3 and 2/3 are already has the R-b and A-b tags. But typically 

From whom? Not from Qualcomm SoC maintainers.

> those patches will go via qcom tree. Do you want to pick it via your 
> tree? Sorry, I'm not sure on this...

Your cover letter or patch changelog should clearly document
dependencies, so maintainers could understand what to do with this patch.

Best regards,
Krzysztof


