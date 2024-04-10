Return-Path: <linux-kernel+bounces-138036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4705F89EB58
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F9DDB24B06
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8FD13AA5F;
	Wed, 10 Apr 2024 06:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c2DQ73jJ"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A612F13AA5A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712732377; cv=none; b=RybCloTGj50QBJNReYszF8sa02kmcD0zUt0gmCe0Q5c1SKh0dtgK/ht0K2dCxhCOwUXFcLpDDz8wvAzgj6mrmaCwBwWK0WOM/dcQ17Lallelbar0AA230FUI39cc1LvAOhT9PJENy4odZWWRnVM4S9INwDXIC5qkGIgCa51MT48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712732377; c=relaxed/simple;
	bh=45nvXYdqWHsssPpsqHVUK+QuOOvuF1vyj9YQggoZjMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=usLpl+M3AaRPefyb4QUAATLcv7hrpMEML8ESFpc3PYfW3Bhrtiqv+ACbfy3cogr7mnU1Fmm1stF68tHWYJ5Smif/V6Q1jJprISk5GegkAGVfn1YCogwvM4w8htvLAzU0WVJfCJe+CpJWTAz97fi2VklrP/IV7mYNwEhlzrRXEAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c2DQ73jJ; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d094bc2244so68275841fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 23:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712732374; x=1713337174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=irqlEKOEBz9zVTX5ET6ObBZ9mYMAyzmpT3TvBmoLetU=;
        b=c2DQ73jJW3NIEcAQSYM4NY9+Q3JhiG0LUE0X7lUw7HN//T4Dj8krSo+jTYCO6NSfil
         QImYV3JeU+3pV4rGBQhvn6QxtopMn653PpZLczEybkhyR8ohbdAvcBDJdRwdOpNDwVcS
         FCynIVTz75ieJOxA8oIhByP63CamcEL0wPg8DDKWFx+tzSQjWtrHEFfK5D/9gvUQBBIE
         0df4o8f3Jl3PDqSVjBtB+zpcgiZ4dxoERH9ZXxay3JckMLE/irzvULK3Bi5gDHml2QH5
         lkIZk5SXhrEeAG2anGkN3Mabm7v04nKiiWRbTVM1imAeH8UX+Dn4tXgDnVxEBpI1YEM0
         tA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712732374; x=1713337174;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irqlEKOEBz9zVTX5ET6ObBZ9mYMAyzmpT3TvBmoLetU=;
        b=G70yF17sW15TTHHMIv+1h7YiscYLQyXywQI2YcfpnjQ49lDK8weusmQiULzrVfFV3A
         47Dk9H0bmbDzYdiQ1RTnPfpYPbXLoUVX/jI5DCRFsCKVeDcR0kEHF4kfCyj/LgmjALUB
         JuE9/fplIS4wmxQRt9teT1euI1d5od3BLgdomXJB0TvOKl7tX5v3PRFm0mMM6aVPYNkv
         3vtOXMT53EdUank6SRGdHiOUUNBxvkZhxIjGPriCylkik+KYLEMDSzsW3oJm084dmUrk
         Z3X/bDF8w3vEZ6uGisO00/rzdD4qO88zs98aRsoV+crVxFJCaa2KszhIGrMQBeHyEPjI
         JWiw==
X-Forwarded-Encrypted: i=1; AJvYcCUILH8VJJ4euVdcsds5hMhT8donIyaKB/zRcXOg6f9Tv6dKPcj2ulSMBXH74QN3LO6ExV6Q4or8Y0gYBcN2JZLrzoSCDaO12a5TjSap
X-Gm-Message-State: AOJu0Yz4eTswzKRWWynXFkL6jNHWI0bvVYwakdkQnug+WtdYMiPuSy8l
	XaJLSaAkp3B2ZpqQ6yz5GGkbQJg5lN9sxY5TwS+T/mXAuSt0CzlAkolDtnt/Hqw=
X-Google-Smtp-Source: AGHT+IGX1VybfQx4v0n2SjzPZaw4LLa2aaM+zIOhXNtj4FiZDVC5lT0TustbyCOt269jFUtelMiq0A==
X-Received: by 2002:a2e:9bc6:0:b0:2d6:c0d5:b96e with SMTP id w6-20020a2e9bc6000000b002d6c0d5b96emr1208003ljj.24.1712732373780;
        Tue, 09 Apr 2024 23:59:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id l23-20020a05600c1d1700b0041663c75ef1sm1323990wms.32.2024.04.09.23.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 23:59:33 -0700 (PDT)
Message-ID: <2379377e-ca1c-453f-bb74-186ab738ce39@linaro.org>
Date: Wed, 10 Apr 2024 08:59:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] dt-bindings: phy: qcom,ipq8074-qmp-pcie: add
 ipq9574 gen3x2 PHY
To: mr.nuke.me@gmail.com, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240409190833.3485824-1-mr.nuke.me@gmail.com>
 <20240409190833.3485824-6-mr.nuke.me@gmail.com>
 <019180df-67b9-438b-a10d-f92fd4ddec03@linaro.org>
 <33461c22-21a3-023b-4750-c69304471ea8@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <33461c22-21a3-023b-4750-c69304471ea8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/04/2024 22:19, mr.nuke.me@gmail.com wrote:
>>
>>
>>>   
>>>     clock-names:
>>>       items:
>>>         - const: aux
>>>         - const: cfg_ahb
>>>         - const: pipe
>>> +      - const: anoc
>>> +      - const: snoc
>>
>> OK, you did not test it. Neither this, nor DTS. I stop review, please
>> test first.
> 
> I ran both `checkpatch.pl` and `make dt_binding_check`. What in this 
> patch makes you say I "did not test it", and what test or tests did I miss?
> 

.. and no, you did not. If you tested, you would easily see error:
	clock-names: ['aux', 'cfg_ahb', 'pipe'] is too short

When you receive comment from reviewer, please investigate thoroughly
what could get wrong. Don't answer just to get rid of reviewer. It's
fine to make mistakes, but if reviewer points to issue and you
immediately respond "no issue", that's waste of my time.

Look at entire code of qcom,pcie how it is organized. Or:
https://elixir.bootlin.com/linux/v6.8/source/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml#L132


Best regards,
Krzysztof


