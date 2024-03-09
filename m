Return-Path: <linux-kernel+bounces-97895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA77877140
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 14:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72CBE1F21436
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962E23BBF7;
	Sat,  9 Mar 2024 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oq3GDVuD"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E6C3BBD4
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 13:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709989537; cv=none; b=H+1aowjZgA9qZtLPt/7Dux0tXIhxGSPlVIGcXHvmrBru4wZbHKIfeCvSf8cmJDLF7tLUFdDo3fFGFSIuK0pjzhmXve61w9Sl86XGXXFhFrztt2prRCNcuxyUWOFMqXBxshsxz1/x7pnm+0hbr52AmWf34dVO3yo9sW+7pgBniiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709989537; c=relaxed/simple;
	bh=jORuAfMzRHp96TO8E22KPYB5BFafo2u2n65ZxkWV0EQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTYuBRbxF20SmE1e9ObkgzDHHGBmF5RQZrFWk1Rz7SILstnz3/Vzr6axCJ6/87Qc3qqrdEjzBMZp7Z7/G0TQhX5vnzGV82jwyZ1eqFUHvwZjoD37glquMp2LK9wjWhzKONjG4VIV8QlDVw0sRNwf2k/KLd09fAUnMBQnsZ+mDzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Oq3GDVuD; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d4141c4438so37021971fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 05:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709989534; x=1710594334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+P5tkOeCJtFZ5Fvtv4CW9J/3ohqdcFpVVsawKF3lAGs=;
        b=Oq3GDVuDp34jFtxzmDov+JH3lHGI3yapKzynLmS6qJXm7sFYBEDtmBftCBq+UQJ1vX
         NckTfSSGIHFPuStfRZ657I7G4dLg/d56xHMBdWQVVbQ2c46/PIySD9mzfNQQ0oR623FN
         V8oqc3IeHbYuuVr53xYBpoga4dS9GJZe6eQf766gWOhdh7095CWApqSW3Gy9zF0bu0jG
         kIiQHuePQzgwCRb+je2ZlF8Ja33F7qXvMlyxM7YLjkijplzgGGAGk8G7SpZc3C3/yk9w
         tuBcg1F6vJWbv9yqS2RhI61pOyjKo9fey6RJkDLwC10hh9GJDhZo+wfLCYSbODoZVGhF
         gGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709989534; x=1710594334;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+P5tkOeCJtFZ5Fvtv4CW9J/3ohqdcFpVVsawKF3lAGs=;
        b=qG+MBySQBUJOjnzMk37vzXQahBJwQxPHqdtB7Egb5IILvrO9F2tvV8kfVQaB+UgrH8
         8RGANpasZr6uoiMBNZPRpcv91ZwPkvq19cIAQdRnYhUEXwIzAI+lPxw6ElSn1377QjI7
         BXn9ORhYoAsLr7Y8vlqHSKO9+wY/5jd9YwumnfKkd4sj1kQ3U9KOBkYqPoW8m1uoxFaT
         /eU7wRDDd04fH0PR91sPcD+bL3rNFUbCEzIsNpxViYA5QMS9HBCRCG5VIvmP2QwIicxn
         oVIj1FkyxrOjiFwBsxNygO9Gy24A+Efng3Tw9JDUea8PXYzwc4Qtbe+HK21kUw7zH4ab
         Ufjg==
X-Forwarded-Encrypted: i=1; AJvYcCX093kQXpjeY0hHYCyPb+BIBUP9Zrd643netF5NkLZQ/mkrUUiNsRjW1uulqADsFUpH293YvO7jIIsMEl2H7Odlm/mCxGCOSag69IIe
X-Gm-Message-State: AOJu0YxR0rwwOFRJRbtEvHQyv6p9NAU0cWN6jY9LkvBt4AjowV4nkj6M
	6dZJaoP8z6c5gqsa1uAoUBnWQ3YD4q6VVp/4wLnGLwmOowmeKpjh7o/HRFj8Gnc=
X-Google-Smtp-Source: AGHT+IHYsX+nOuSmvOZAILhgvKwYrM3v9nSL2e0xDwqB55zCNS/6TcHtQZ61ub80DDRG3LLDLrGwfw==
X-Received: by 2002:a2e:7214:0:b0:2d2:c53f:ab18 with SMTP id n20-20020a2e7214000000b002d2c53fab18mr1208142ljc.11.1709989533703;
        Sat, 09 Mar 2024 05:05:33 -0800 (PST)
Received: from [192.168.16.23] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id q10-20020a2e84ca000000b002d29e1845c9sm300979ljh.58.2024.03.09.05.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Mar 2024 05:05:33 -0800 (PST)
Message-ID: <52b25cbf-6f73-4c51-9a46-ff5843fef89e@linaro.org>
Date: Sat, 9 Mar 2024 14:05:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: thermal: lmh: Add QCM2290 compatible
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Thara Gopinath
 <thara.gopinath@gmail.com>, Amit Kucheria <amitk@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240308-topic-rb1_lmh-v1-0-50c60ffe1130@linaro.org>
 <20240308-topic-rb1_lmh-v1-1-50c60ffe1130@linaro.org>
 <9747c836-adb8-4d21-92c0-a022847fdff6@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <9747c836-adb8-4d21-92c0-a022847fdff6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9.03.2024 12:06, Krzysztof Kozlowski wrote:
> On 08/03/2024 23:08, Konrad Dybcio wrote:
>> Document the QCM2290 LMH.
>>
> 
> MSM8998 appeared as well. Please either explain in the commit msg or
> drop it from the binding (if it is not correct).

Hm, git messed with my branches.. I'll send the correct patch in v2.

Konrad

