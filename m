Return-Path: <linux-kernel+bounces-138431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAFD89F125
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B1D1F24C69
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A88815AD9E;
	Wed, 10 Apr 2024 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FArxwAfY"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31B715A4A0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712749623; cv=none; b=Us2PlBW7p4t+e5P5xYA36BI2enGERd7JehLopgFw5r2GVH0h1mxj9H7Ya9s3CLyTXjO4kyG5EL9mo3SXQIokDq2f3gJElpY46jwKzQz/P2iy7a0qFNd4T0YIStSYLAay649jZn2RTnV1ySbEoYuLUJgLLKtp2ohU2peLS2ixywg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712749623; c=relaxed/simple;
	bh=CW+mD6GTRkoQYXsN50pvVgrsZ6ghzRF4hd23UYqT+zA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSxJ2NGslxoRsVbY9zrngNkcEWZ2tZFDJ0H08jtgbUWRRs7PC+i7P21kihXI55r07MLSq7J0k35KuuwZezfhGnivfj25DF9de+zwiNZJTRucmrStKSV+/IgVo98fCo08vI7ZZeH9p65y42whEbuxAP2OmzTwYIo1gS1jr5EfE8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FArxwAfY; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d895138d0eso27569211fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 04:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712749620; x=1713354420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oZ6YNeiNukRuh6MMTnZ6ixiPqjgd5+C31ndu168QCzk=;
        b=FArxwAfYjCFQ28ezbMSLkd607mC+nlzfb0xDEqr2g5o+PposDK5DmRoKGsAb6kFkFX
         PLusD0ko4w9VyshZg19zQYmB3V3olgcMNjkC0sXwE/sbGWtFYDPr/5BqRHgWGPdGwgzF
         rlkDXFMaPpLi9jTgHnieV8MIbkDqW0ma2JM2d2RgNp1zFanCe83tNZccBV5l5z/quXL7
         gfFkb84YheHQLOxRiDF57AeQUXxB7BSc71jc1yhJRhCjugO30SguIuq1OTdoNn9CURlb
         uF3CTkZ1W2oRZIZW+eDAJ5m519c+Epo74JI0ymimfWlBC2OJQB8cA9TgBnfPGhsE/LRR
         OG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712749620; x=1713354420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oZ6YNeiNukRuh6MMTnZ6ixiPqjgd5+C31ndu168QCzk=;
        b=w7ASIMYtY9sQXDOWt0Wtqhhuf5CwvTwbfe91yleDI39O0lJ9oALrP1UcfZbU96ENOe
         kCq+UOPkm7IZaQaffpTcUfOxgqRtm+p9SLlU3wTvsVl+2wFtBvV8H44cbXeN54dqRzzm
         GB1blojq2pPRlmbiCLzsg4CzLaFTC6DuP8c03IVHjTJxyuOM5tgCRI6zPfsqxUc+cJwH
         y08fXEDWqOTyOUIFYUbhj33wQJKICFidNEedzOq5KOH862rLuOyXpBB0nwacHyASaY72
         YCfQivYShoeeV+nt+87vfxzjilUImzUFuJnTTWYiKtff1WgPZqLuplefJ9E0OsoR96jm
         u27g==
X-Forwarded-Encrypted: i=1; AJvYcCUQPXLLJSkFg6c2EjE8hPgUT+GOEz5d6LKldYv81+oPcefwDf2biNwnJaUa3ehdHr8dDfW+p8aeSO72qcMKlzfmKOt4aWtZu9KxSEye
X-Gm-Message-State: AOJu0Yx6SiQeZvYjunOLJr+bh5XX/saYs5adoUGd1H679QnHkuSLYor6
	xY5Cxpp+/fLMtWQ6hHyTk2H/hHMiJCg4Y3ejBnZhiPvLkQG27fDOq6M7f/6zeFs=
X-Google-Smtp-Source: AGHT+IGnm7b8Cinq20QKqQAozywBKC44Y66uug2JGp4mxZff/pCzj2zNm4gy03Ua488m3Kggfu/ZvQ==
X-Received: by 2002:a05:651c:1037:b0:2d8:71d4:4c62 with SMTP id w23-20020a05651c103700b002d871d44c62mr1461674ljm.49.1712749619821;
        Wed, 10 Apr 2024 04:46:59 -0700 (PDT)
Received: from [172.30.204.89] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id r21-20020a2e9955000000b002d85452f55csm1781619ljj.47.2024.04.10.04.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 04:46:59 -0700 (PDT)
Message-ID: <c547e19c-158a-4512-b2d9-01668b7ac2f0@linaro.org>
Date: Wed, 10 Apr 2024 13:47:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] drm/msm/adreno: Allow specifying default speedbin
 value
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20240405-topic-smem_speedbin-v1-0-ce2b864251b1@linaro.org>
 <20240405-topic-smem_speedbin-v1-3-ce2b864251b1@linaro.org>
 <pncr7ecf4eir36skul3iwt2nf5bpuwd5zjfzzfwwnxjwe4hoes@6z2xe54crijp>
 <d8a2ef87-f29e-4bdb-a9b8-591b8bd5d2b2@linaro.org>
 <tkcbl2iwcy3feoggbk737gx32qsxe5p4ad6lfrujy2pazccrhm@kif3guuzay6h>
 <CAF6AEGsg2xCCC27t_Gqu=MMQ6tckVw=Zj90p4x7EuOm+VKA=ig@mail.gmail.com>
 <quil2y6tbilihgont2xekay4joxgnsanu3khgo77omtwkolslp@ozuaajpv5uon>
 <b77a3161-9a18-4523-8528-31c2f2f4f476@linaro.org>
 <x4sgmdodoacsu6culbjjsw52ucaylpqj2ll6tkeppllzhfqiqn@lysclxogvcfq>
 <74ebd488-15c1-47a5-86f4-14263e3a914e@linaro.org>
 <CAA8EJprAcBDEwYeGJZ=JX2qkS4wQEraXsgCiCyZU3z1ksuxivw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJprAcBDEwYeGJZ=JX2qkS4wQEraXsgCiCyZU3z1ksuxivw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/9/24 20:31, Dmitry Baryshkov wrote:
> On Tue, 9 Apr 2024 at 21:27, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 4/9/24 20:15, Dmitry Baryshkov wrote:
>>> On Tue, Apr 09, 2024 at 08:07:56PM +0200, Konrad Dybcio wrote:
>>>>
>>>>
>>>> On 4/9/24 20:04, Dmitry Baryshkov wrote:
>>>>> On Tue, Apr 09, 2024 at 10:12:00AM -0700, Rob Clark wrote:
>>>>>> On Tue, Apr 9, 2024 at 8:23 AM Dmitry Baryshkov
>>>>>> <dmitry.baryshkov@linaro.org> wrote:
>>>>>>>
>>>>>>> On Tue, Apr 09, 2024 at 05:12:46PM +0200, Konrad Dybcio wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 4/6/24 04:56, Dmitry Baryshkov wrote:
>>>>>>>>> On Fri, Apr 05, 2024 at 10:41:31AM +0200, Konrad Dybcio wrote:
>>>>>>>>>> From: Neil Armstrong <neil.armstrong@linaro.org>
>>>>>>>>>>
>>>>>>>>>> Usually, speedbin 0 is the "super SKU", a.k.a the one which can clock
>>>>>>>>>> the highest. Falling back to it when things go wrong is largely
>>>>>>>>>> suboptimal, as more often than not, the top frequencies are not
>>>>>>>>>> supposed to work on other bins.
>>>>>>>>>
>>>>>>>>> Isn't it better to just return an error here instead of trying to guess
>>>>>>>>> which speedbin to use?
>>>>>>>>
>>>>>>>> Not sure. I'd rather better compatibility for e.g. booting up a new
>>>>>>>> laptop with just dt.
>>>>>>>
>>>>>>> New speedbin can have lower max speed, so by attempting to run it at
>>>>>>> higher freq you might be breaking it.
>>>>>>
>>>>>> Usually there are some OPPs in common to all speedbins, so picking a
>>>>>> freq from that set would seem like the safe thing to do
>>>>>
>>>>> Well, the issue is about an uknown speed bin. So in theory we know
>>>>> nothing about the set of speeds itsupports. My point is that we should
>>>>> simplfy fail in such case.
>>>>
>>>> Or we could allow e.g. the lowest frequency (or 2) which if often shared
>>>> across the board to work, giving a compromise between OOBE and sanity
>>>
>>> That's also an option. But we should not be using existing speed table for
>>> the unknown bin.
>>
>> I derived this logic from msm-5.15 where it's "intended behavior".. I
>> suppose we can do better as you said though
>>
>> There have been cases in the past where the default speed bin ended up
>> having a higher max freq than subsequent ones, and I don't think I can
>> trust this product/feature code approach to guarantee this never
>> happening again.
>>
>> So. I think sticking to a single lowest freq and printing a big red line
>> in dmesg makes sense here
> 
> Make 0x80 the default supported-hw, make sure that the lowest freq has
> 0xff. Plus big-red-line.
> And hope that we'll never see 16 speed bins for the hardware.

opp-supported-hw is a u32 bitmask fwiw

I was thinking, either 0xffffffff or some driver-side hackery
(dev_pm_opp_enable).

Perhaps I'd be more in favor of the latter, as putting meaningless gobblygoo
in dt is not good

Konrad

