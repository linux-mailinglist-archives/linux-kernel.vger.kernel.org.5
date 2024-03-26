Return-Path: <linux-kernel+bounces-118617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 739E588BD51
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49DDC1F3E43D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6723857333;
	Tue, 26 Mar 2024 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jl1tjTte"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EDE548FA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444196; cv=none; b=ROfESQd9QqElw90Gf9Nh5w96bOpaoHSXvwdrv5uHg0KxqEQabzpOmApzcq3r9zRCBfGT6WIUjnkjPHy44wIrXnmBcrf/yyp96FaixYdAGTTR15QKNMs/MxsBAu8VbYonIHtUQyZiJ3klYbsgYt557FAif0IudxpCcIoR+vjuFPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444196; c=relaxed/simple;
	bh=5Mfg3cAEqQHcDfQSPGTXTY+BSG6g04522lPi9IZ6HSY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mMsbd87g8bOZLIrCwwa2Au6w1Pd/ii7JNFqnOCfdWERoftya+XB7KCyshLSroZZWoH7O2yUKyhfJ6FvZAymSnLjx31eBEoy+NbqCMCY0yb4+T0HgIO1Wie6ztJZW9t0heeI4qUo6wBwpt3riqg5+CNgWFgfaZ8hQwHnnmjKZ57U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jl1tjTte; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56c1a520659so1764228a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711444193; x=1712048993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C/0aOAO1H78sXE4ecqOfYnPqbfj2kgK7iNx5nq8FjyQ=;
        b=Jl1tjTtea9VlTftYK2ZZJ0mZ35oUgNJt+f0uhnja22+/RtWvQ6tJIHPluSA8c6gGbp
         a8x1uNRTEog+1haTASEtW9LhMZ0MzXQXc0pSsNBmuhZFVn0/v6PcLDQi0USNIvNLlhWG
         Eyz2RjyZ5apRffdgRbTNJwIHun4uNEtSXY/kWlgDFrv7uf0hDu3yoRlxHQqfCMB+SV38
         mcm6c6wxZwWbyGc/uW+OsHaxuA32Ngtq4Tzhh0w2RVSHm1Q5aIxHiNgEuS7KxGVnj/6L
         X6nWylvqP72WhlMbJoM5nnjWs0F09ZhdHp6FuZy6ua28JPCv58FvccO55+mRvD1mE4qr
         BPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711444193; x=1712048993;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/0aOAO1H78sXE4ecqOfYnPqbfj2kgK7iNx5nq8FjyQ=;
        b=kpN+H9+G0RQBePW4ihwnNu3jAN/qZ3vaUv3Ex7ZoEHT9YJ6UdBiy4zMY+9hU7U12wg
         VJOToLtlXwN63mGmZh/WCOz3eZk9S3w6AtDf2CmyQqbSV7EI5wfgDSdpI8x7k34cz4Pb
         LFTdQSWACEheBzuMfmrdENu2vaiACxMl+xURLggrYsPmhhxfm0ERfiCNUVwU+ZUDCkuy
         y9VOhyX0QBpgs7TbySvber0lpKl2TPoEFvsR3goWUFo5IJQxPZMvrNQYGz9axyKjw28R
         aq2b5mM/AZ8mJi2/heeVFwIt5JNwEFEDlU8Q5D0U/YeEpTJhjniEXxEO5LT0FEh2pHjt
         pplA==
X-Forwarded-Encrypted: i=1; AJvYcCV9oH/ZZKIlp1nCl0PdZyLBIw78PPQc2yfPEPirSKrWJoh/u2lSgDpiIZLWTIad9sWnee7N3vS2YasIEhSwVUesahKNvZVJGFhtnaVE
X-Gm-Message-State: AOJu0YxLuoqB+t3FaaEmxLmWu9SzQuUQqiNaXlipDy6XFnF3TXpd0Cyb
	KnsBVpgngt/nNRXaV6nkc44tp7+quHUpWYwqZj3gga873+Zy51IYFmlWFUSMLJ3QKqWM/I3qfik
	T
X-Google-Smtp-Source: AGHT+IGufNO6EHXt8Q7khkkznmdlFXoI+wI5M2phhK0jxKfd99dTLesRNPDIlYf2751/NqEFkwD8lA==
X-Received: by 2002:a17:906:474e:b0:a47:4e09:e685 with SMTP id j14-20020a170906474e00b00a474e09e685mr1400093ejs.32.1711444192953;
        Tue, 26 Mar 2024 02:09:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709063b8100b00a46fbff47a6sm3982096ejf.168.2024.03.26.02.09.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 02:09:52 -0700 (PDT)
Message-ID: <adb00149-6b90-43ee-9db0-4fcad1eeb4ca@linaro.org>
Date: Tue, 26 Mar 2024 10:09:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory: omap-gpmc: fixup wrongly hierarchy of the
 sub-devices
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Brock Zheng <yzheng@techyauld.com>, Roger Quadros <rogerq@kernel.org>
Cc: Andreas Kemnade <andreas@kemnade.info>, Tony Lindgren <tony@atomide.com>,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6fftq2zlkpaf7xptyff6ky63cinr76ziyvdbm5jhj2apubr5vf@l4gvbdax3l2e>
 <f45b3195-38a9-4c49-b873-01e5a0b275a3@kernel.org>
 <20240301133809.0d26865e@aktux>
 <f59c9450-2784-46fa-afc9-4f194055cb24@kernel.org>
 <laqqencookmgwesfaetd5xw5wfmjdffmjvyjitapfehmu7zy5y@k7gsdexf3jcv>
 <beacb55c-951b-4177-83ab-94fda44cd2b7@kernel.org>
 <yxefg4ie4vxblxvr272jvzncxvj2t6xjfuisvmkt2jk663xgsu@o2ogbyepmg3z>
 <bbc16b3c-7e76-4f0a-8ada-42d2da3426fd@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <bbc16b3c-7e76-4f0a-8ada-42d2da3426fd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/03/2024 17:48, Krzysztof Kozlowski wrote:
> On 03/03/2024 09:18, Brock Zheng wrote:
>> On TI-AM335x，FPGA under GPMC local-bus can not work on 6.x kernel.
>>
>> GPMC <--> FPGA  <--> sub-devices....
>>
>> I found that the platform sub-devices are in wrongly organized
>> hierarchy.  The grandchildren are now under the GPMC device directly,
>> not under it's father(FPGA).
>>
>> Signed-off-by: Brock.Zheng <yzheng@techyauld.com>
> 
> Your SoB still has '.' between names. I can remove it while applying.
> It is too late in the cycle for me to pick it up. I will take it after
> the merge window.

Although I wrote I could apply it, but:
1. There is still no fixes tag, even though I asked.
2. This is not marked as v2 and is attached to some other thread. Please
version your patches, so next one will be v3. Add changelog after ---.
Then send as a new patchset.

Please send v3 with above corrected.

Best regards,
Krzysztof


