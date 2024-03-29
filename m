Return-Path: <linux-kernel+bounces-125302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 640C18923B8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1975F2870B2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CC886269;
	Fri, 29 Mar 2024 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAPO4U5T"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3A93B78E;
	Fri, 29 Mar 2024 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711738579; cv=none; b=H2aob/l7dtt6p7LidqdWeDOdht/bNz29HHU7v9+FQzEHT1r7acRWJPjqsKOwA2SWppccHAwat+dm9t7fAOJw1KY5+GANR+dpQlDgG4bl3b3+JUHqwI9UqunlyVzRhrhDLWSCAIL2/+Vzk4jkGISMu3acIsu5mOJYv9pTvU29abM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711738579; c=relaxed/simple;
	bh=FRxKZJ7nHYeoTjrbOoTE5rSbT1ES/c9ViYwjDi0bOWI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=e322S/efK8LLpPtkq9IMAS4mNAlFbwCroz8H34bl17Vmr0ZjBBjI2Kpoe04+tsHgaubqqEUgBVGufHwSNsWySM7PEaMMXnm+4wdVX9pFeDa0yZBzeg4/0h0M10vya2z2+hrBA4dW4eysViWT8Bo/iDaZ23EFuWJWy5PVoZr1sHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAPO4U5T; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33ec7e38b84so1569218f8f.1;
        Fri, 29 Mar 2024 11:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711738575; x=1712343375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=74yiZ5kwgEm/k9S9Xxk23q/p06vudsTp9pnHVGdWlYc=;
        b=XAPO4U5TrpbZ0LEUVxWemKeRKOXQLfnfB5GFlr9qMbR6RGGAVjLHPK9S0H2dP43Qb7
         FPgjFqfEzvSYdwHEDtd9k18p67IbMVja3/Ntu1gMg3l0952uGdz0Heo3maBsaqzc9iui
         fpabU7PA/R2ojbAyruX+XgVZwkCwQz7Mh+WOfqga54S/2tYUquZSOR1eCOdKLmrfqT0I
         rTgEXKeHeet7sQsE5CpGBPP0Sl/B06rK18xkf9NTUpe/Oeoh16CoQumN6ATSEVbxJOD5
         nIyivMMNc69rYshAyhdlSVjakivOVBgmSyYy0z96g6e0165J2tE1JkN0j1nQ4e+oJoRW
         gIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711738575; x=1712343375;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=74yiZ5kwgEm/k9S9Xxk23q/p06vudsTp9pnHVGdWlYc=;
        b=O3CsPeETP3nP5fDc3QX00sISpaCS/Ir+cKolThbPDaYsyN4Vg6f3krrSP1Iom55OuN
         ur+IczoUBJUizjCwkiFpNoesKyjLjLOMjHErghAA5JNPbh01jhjcBP6V1bRUnWCjgC6E
         C+wZQuQRnVEual3sC9/0mPvUWb3HYOLRWsU0MXYv3PbQ3GsxdGY69lZg7JotxES5LG1B
         GfPN1B1ng8m7lZKxSjjEGMitd/up1ycRgT7Q0UjN4tXfRrbNeRyWhRP3RR/WZGzP3JKF
         h14LXq5aLPTMQh3f77tE66XZhH7hlaaMXdKaVZBzZcC7VYn8i4aiDslVjBmNJpk9deKY
         kM0g==
X-Forwarded-Encrypted: i=1; AJvYcCXtxALZ6AuAJjhDG1ghnhw41aH34Jls0A/ZXfviaf0GKNvVtQNGI/h8Cu1fpmogCgDUzdqoHykSaGzJ2+GSyDHelXCLhstDd/gtmiy+GuwOiXKTWBbnwY3hzM3Rt7nPqwQsN10otltXwt8ukg==
X-Gm-Message-State: AOJu0YxAU7XGoYGOfmTPtAj1WPLIYi7CxK5Idb8VgUxFygTrDV4H+VSH
	PgIgWelaH3bh34sl8W01s33qX49rpW65JEad916R4HRrof2lCfiBc1IMMouL
X-Google-Smtp-Source: AGHT+IFbPfgb5RqV5qtgCHqpP43LLJD/VzMHCIbXsTSwvgFbS7XF1qDurziedHGETOxjhCQTllhO2g==
X-Received: by 2002:a5d:590f:0:b0:33d:c657:6ae3 with SMTP id v15-20020a5d590f000000b0033dc6576ae3mr2098778wrd.7.1711738575419;
        Fri, 29 Mar 2024 11:56:15 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id dn2-20020a0560000c0200b0033e25c39ac3sm4754350wrb.80.2024.03.29.11.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 11:56:15 -0700 (PDT)
Message-ID: <97e1f121-9e84-4e63-9c9c-57e2de0b29d7@gmail.com>
Date: Fri, 29 Mar 2024 19:56:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/13] firmware: qcom: qseecom: convert to using the TZ
 allocator
From: Maximilian Luz <luzmaximilian@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Elliot Berman <quic_eberman@quicinc.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Guru Das Srinagesh <quic_gurus@quicinc.com>,
 Andrew Halaney <ahalaney@redhat.com>, Alex Elder <elder@linaro.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@quicinc.com, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240325100359.17001-1-brgl@bgdev.pl>
 <56e1c63a-4c09-4d92-9ef2-aad5390879cc@gmail.com>
 <CAMRc=Mf_pvrh2VMfTVE-ZTypyO010p=to-cd8Q745DzSDXLGFw@mail.gmail.com>
 <CAMRc=MfsVWcoMC-dB-fdxy332h-ucUPTfEUMAnCt5L-q3zJxWg@mail.gmail.com>
 <82f94b54-82d1-49b9-badf-63d948b347fc@gmail.com>
Content-Language: en-US
In-Reply-To: <82f94b54-82d1-49b9-badf-63d948b347fc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/29/24 7:53 PM, Maximilian Luz wrote:
> On 3/29/24 11:22 AM, Bartosz Golaszewski wrote:
>> On Thu, Mar 28, 2024 at 7:55 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>
>>> On Thu, Mar 28, 2024 at 5:50 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>>>
>>>> If I understand correctly, it enters an atomic section in
>>>> qcom_tzmem_alloc() and then tries to schedule somewhere down the line.
>>>> So this shouldn't be qseecom specific.
>>>>
>>>> I should probably also say that I'm currently testing this on a patched
>>>> v6.8 kernel, so there's a chance that it's my fault. However, as far as
>>>> I understand, it enters an atomic section in qcom_tzmem_alloc() and then
>>>> later tries to expand the pool memory with dma_alloc_coherent(). Which
>>>> AFAIK is allowed to sleep with GFP_KERNEL (and I guess that that's the
>>>> issue here).
>>>>
>>>> I've also tried the shmem allocator option, but that seems to get stuck
>>>> quite early at boot, before I even have usb-serial access to get any
>>>> logs. If I can find some more time, I'll try to see if I can get some
>>>> useful output for that.
>>>>
>>>
>>> Ah, I think it happens here:
>>>
>>> +       guard(spinlock_irqsave)(&pool->lock);
>>> +
>>> +again:
>>> +       vaddr = gen_pool_alloc(pool->genpool, size);
>>> +       if (!vaddr) {
>>> +               if (qcom_tzmem_try_grow_pool(pool, size, gfp))
>>> +                       goto again;
>>>
>>> We were called with GFP_KERNEL so this is what we pass on to
>>> qcom_tzmem_try_grow_pool() but we're now holding the spinlock. I need
>>> to revisit it. Thanks for the catch!
>>>
>>> Bart
>>
>> Can you try the following tree?
>>
>>      https://git.codelinaro.org/bartosz_golaszewski/linux.git
>> topic/shm-bridge-v10
>>
>> gen_pool_alloc() and gen_pool_add_virt() can be used without external
>> serialization. We only really need to protect the list of areas in the
>> pool when adding a new element. We could possibly even use
>> list_add_tail_rcu() as it updates the pointers atomically and go
>> lockless.
> 
> Thanks! That fixes the allocations for CONFIG_QCOM_TZMEM_MODE_GENERIC=y.
> Unfortunately, with the shmbridge mode it still gets stuck at boot (and
> I haven't had the time to look into it yet).
> 
> And for more bad news: It looks like the new allocator now fully exposes
> a bug that I've been tracking down the last couple of days. In short,
> uefisecapp doesn't seem to be happy when we split the allocations for
> request and response into two, causing commands to fail. Instead it
> wants a single buffer for both. Before, it seemed to be fairly sporadic
> (likely because kzalloc in sequence just returned consecutive memory
> almost all of the time) but now it's basically every call that fails.
> 
> I have a fix for that almost ready and I'll likely post it in the next
> hour. But that means that you'll probably have to rebase this series
> on top of it...

Forgot to mention: I tested it with the fix and this series, and that
works.

> Best regards,
> Max
> 

