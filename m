Return-Path: <linux-kernel+bounces-119988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6FE88CFC2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73FB3329612
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBB613D2B2;
	Tue, 26 Mar 2024 21:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C0ueIFGU"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E0C12B151
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711487542; cv=none; b=cD7yLqCelSV/DLdVq9uxR0rZVP8Od6X/lZLiwLLrhaL7gU5W8D9z2f08RaVGxPwc50Hy4qxR033ldP1dm5j5wD/HvUzrkW8oDvi4G3KcbHrA+KNc5ebrfcsZPJPUqv+PDEv/MG336VSLE/GibNlLE6+i4Rjy74N/VCX/Nwv0vfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711487542; c=relaxed/simple;
	bh=0F+X70AWDarLptOn48RiTTiG3E2O6A30qLqNPJ7uOUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dzHcnEszkh/LJ/6ZABWhsm0Vyn4eHrlLj2+Izxfs0qbT3QH6rxy+BZ4zwauVGnc3ce4iByKkfQkNuVhaQhWTyOsl5o8UOwu/2c6IHN76yoAB2eUzQ63QB1PMzR4iUN7XTsNCFVG5s1PydCrazON7Nfr1GpOeKM/H5UrcfS98E+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C0ueIFGU; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a4702457ccbso771380866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711487539; x=1712092339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Esfbc3Ag4sk4mR5JiEPjgl2V8thBIUnXRFUq7g9Wfhk=;
        b=C0ueIFGUMKh0JS3zSge+kT1jYbUoTfGWe0X+nnVnbZVg27tkURonrQ7EYUntfkfkaY
         r1RMgLBeyyawRZ1jSxhbT9nvca3qTcYHxBaEigDq6uIgjq9FuGbeC5QWLmUcZWKCTpL4
         nYw0SJddg+Z3vqhXL7djb2qjMkFbtT5ksHO7MMEARDE18zqbOGDU+HPqWaI/pQgGlFwP
         jez36wVMRzJLlZ19xPBBL9QBuRPGx9FOzcZsoteV/s6UXdUUk9pDJ2q4u1YxaXs93jqC
         wDELRBbvJOoXKfBUcmCOLb+kpb0wwWFEiSYmJx0NwwpzrWP5wTt1NkJwtngD5ZlebUsq
         Mgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711487539; x=1712092339;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Esfbc3Ag4sk4mR5JiEPjgl2V8thBIUnXRFUq7g9Wfhk=;
        b=aNLgR8Rhcoinb2ZNECFSb1vG93A0vUTsdRULD478mdQAjytL9tTGesVldJQEIOl7T3
         D7SMTnuyHa4hfFG55dt2v/IaZKtnkRIxinQAGa8mFvVFi93NbFrXQ8l0SDRMWpRwoNgb
         S6dmgKiKqEQYo+JSXs4wKLv7C5Lk1FOyprWpiSb6bUpHLBeXmcRwlMQFC3mbkh6o9CJi
         S6j7y7ecV2ncOQzE5D5hrfQ1GyfM7bljkx88w0iniBB4ZtKA80YiJanfCBpujrNNsWDV
         veFvDS/bNHW9KxYsRBI7QwmIcGTBjz7hq91UF2puirW4IMda0vRlOpYfCrzFu9skhS6v
         hLOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdbLRbFY6roBYfM5QnKltAMNwYM5phIVdRfcb+yJ6xEY99A0xgWVFZeCngqdxLMdwsCFPJGV0vkc8DHlz81qXZN2fgimG3UFM0GYSH
X-Gm-Message-State: AOJu0YwYbF+GwCUpm6av/20v2AUJAH4Sszd5SB0T+l88aCySRSzFzQ8L
	Gox4VbfGK+Nsm8ZftiSpLxZKGvyiJcdvJGm6in8ksGTi60B38yV3xaPIZuH/hec=
X-Google-Smtp-Source: AGHT+IFhPdAh4ot4NumYAC6S676xljYyytiKnFIYNPBSdI9pf8Rc4hlPwytEGQYHqeAnOZJ1cyUVxQ==
X-Received: by 2002:a17:906:398f:b0:a47:3526:2e0f with SMTP id h15-20020a170906398f00b00a4735262e0fmr7584171eje.75.1711487539223;
        Tue, 26 Mar 2024 14:12:19 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id z23-20020a170906271700b00a473766cfeasm4630496ejc.217.2024.03.26.14.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 14:12:18 -0700 (PDT)
Message-ID: <1e138728-f78e-4bfe-b59b-297e599759ab@linaro.org>
Date: Tue, 26 Mar 2024 22:12:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] interconnect: qcom: icc-rpm: Remodel how QoS settings
 are stored
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Bjorn Andersson <andersson@kernel.org>, Georgi Djakov
 <djakov@kernel.org>, Shawn Guo <shawn.guo@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240326-topic-rpm_icc_qos_cleanup-v1-0-357e736792be@linaro.org>
 <20240326-topic-rpm_icc_qos_cleanup-v1-4-357e736792be@linaro.org>
 <ZgM2naP4mGLKwbCV@gerhold.net>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZgM2naP4mGLKwbCV@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.03.2024 9:57 PM, Stephan Gerhold wrote:
> On Tue, Mar 26, 2024 at 08:42:35PM +0100, Konrad Dybcio wrote:
>> Currently, the QoS settings are stored in the node data, even though
>> they're a property of the bus/provider instead. Moreover, they are only
>> needed during the probe step, so they can be easily moved into struct
>> qcom_icc_desc.
>>
>> Reshuffle things around to make it anywhere near readable & comparable
>> with a reference. As a nice bonus, a lot of bytes are shaved off and
>> a few miliseconds are shaved off here and there.
>>
>> As an example, bloat-o-meter reports this on sm6115.o:
>> Total: Before=14799, After=13263, chg -10.38%
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---

[...]


> Nitpick: Why is the u16 const when the other (non-pointer) members are
> not? The u16 also feels a bit like overkill here. The struct would have
> exactly the same size with a full unsigned int because of padding.

That's just my brain performing premature (and as you can see invalid)
optimizations.. I can change it to u32

> 
> Alternatively, you could consider using an empty last entry as sentinel
> instead of adding the count (i.e. with NOC_QOS_MODE_INVALID = 0). Not
> sure what is cleaner here.

Nah, let's keep the counter

> 
> I haven't looked closely at the actual conversion of the definitions in
> the drivers. What is the chance that you made an accidental mistake in
> there? Or was it scripted? :D

By hand. After this change, it should hopefully be very easy and
convenient to check against downstream.

Konrad

