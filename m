Return-Path: <linux-kernel+bounces-125326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A47F3892426
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F3E1F22AF5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AC5131E59;
	Fri, 29 Mar 2024 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biJZ2hn2"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC0E1EA8F;
	Fri, 29 Mar 2024 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740140; cv=none; b=abFgKWmv/TUvsnoWRao1ylhU5A7D272HRTdCcvNEUYhU5TA4dqUZ5Xl6vtQ/gLeHU9gR5fsbN+6cWdu13ixOOKt6YPKTjY1t0EgmTaUFnYG6WR1eCjeTJ48qZS49zYgfYGgvkICF5Q9R1AE5hOD5O6KoqQ7/f9yojkhOSyM7Bd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740140; c=relaxed/simple;
	bh=x9oCqEmE47fH+lCruYBavHci7f/vBeTmfvVEWU5dFJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZ/Cbt7ZvoP2I/Y73xHyE/F7R8EVFIWevWq0IqnFQozVjbWpOz3NzzUm2Yywjwny+LkE/FTeLbK8wpPgsUKk7fGAC92UuUFId6U40vWlYZK7u2Z9eLk19THFNTrJKM3epmROVUEoNVCZ7horEvMgA+xVzJxWJlf6KPUJGG6K5NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biJZ2hn2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41545616455so12367935e9.0;
        Fri, 29 Mar 2024 12:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711740137; x=1712344937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I0COmV02Xjs6bigwSR72AO2S5c2HwRuO1pRKJTQ072A=;
        b=biJZ2hn2ey47XHYC4qKgsivyRew3DzvMdP/Ey2iNb1nInoqhb+Vg5dsh87FwAhlBQm
         GQSiuv7YlpzM51lOMLpZBWzPxH8hluTIyFaTYkGEXfPE+JdfPFNoN1iIk7OVzusNEtgT
         O0V07mCynqVlJLHe6ypSJcJf838thvoGDWF3yViow3bS7T26mCMMFXGvzwujc4m5/jwi
         pfd/zoRBYC1ggPvLLXtCCIuJEnsZHpiZ334KBiAGBowa8PqSfzIQzBTkLuKGdoXeBPv7
         Fm+o0buDo5JTwpsc1asrTMKguqB/wPapcf6o4t/c6RlkVIWdsjoBAWc99L9BitvGN92X
         TVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711740137; x=1712344937;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0COmV02Xjs6bigwSR72AO2S5c2HwRuO1pRKJTQ072A=;
        b=oOV0qk+Jcqi/WzAEGQVVL9Sgu94zu0fI1cvXADf2pn7L3QO9Jx/huv1w9YmofRYtlR
         2xwMT4gWjJ6woeiF3CgYPB26HaD+l4Fk88x+/KzAfxa+6ENyV6cyalecJiABSzkf55Q5
         +5zgZSBrygl/R2684B+x3kHf8qRg46yX1QWrFP7FycS4IhXUSTHwitjEQsRgJnRuIUob
         LWcMBmMBo1ISkPnUONqk96+V+yUioZVosDWInmbn11RWv4irxPmUHuwWp8MI4jnDTkGc
         morj4U081idFfiSz2oXyv0SzuX3tx+XfyQu6dllRLD6cd5IBf4EK8V2rfZqMF9LW+7Q6
         k9xw==
X-Forwarded-Encrypted: i=1; AJvYcCUf033yVM2qgw4NfOLyI1gX4K1X+CYaftkK8h+ua9aFGZu7BMHbkgQPt0FGKwo4/6yZZX9U6IOc3IR9P23mJgen1EiXwqM0yuMuWEkxdOkioAGyv2HIzybHBsyDBPQWiYckuil6JzbQbKCa+A==
X-Gm-Message-State: AOJu0YyqDVf66LBDhg0QjjI6yxmwVFoIcXCA9uGU9wZZdo0jhi2jJ7II
	iVB/dwXtvqMzSxGZ1OuNnQdyhahmnqZinrQq7T+4glW82EUFe9p4
X-Google-Smtp-Source: AGHT+IEwn3YaZULTZvrB4ScCr89wKFSCotW9AHiPfe5RvM3cp7fGOw8HQqEkvOEPo41qmgrr2bQg5A==
X-Received: by 2002:a7b:cd0c:0:b0:414:610b:13c3 with SMTP id f12-20020a7bcd0c000000b00414610b13c3mr2387709wmj.27.1711740137161;
        Fri, 29 Mar 2024 12:22:17 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id fc11-20020a05600c524b00b0041408e16e6bsm6272344wmb.25.2024.03.29.12.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 12:22:16 -0700 (PDT)
Message-ID: <2b1dc031-d645-494c-9103-a2bb422ea60b@gmail.com>
Date: Fri, 29 Mar 2024 20:22:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 00/13] firmware: qcom: qseecom: convert to using the TZ
 allocator
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
 <97e1f121-9e84-4e63-9c9c-57e2de0b29d7@gmail.com>
 <CAMRc=McLJFGcy-A6PZNmjgDXnvx8z0J4k-Dbak-txvWnycHG2A@mail.gmail.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <CAMRc=McLJFGcy-A6PZNmjgDXnvx8z0J4k-Dbak-txvWnycHG2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/29/24 8:07 PM, Bartosz Golaszewski wrote:
> On Fri, Mar 29, 2024 at 7:56 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>
>>
>>
>> On 3/29/24 7:53 PM, Maximilian Luz wrote:
>>> On 3/29/24 11:22 AM, Bartosz Golaszewski wrote:
>>>> On Thu, Mar 28, 2024 at 7:55 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>>>>
>>>>> On Thu, Mar 28, 2024 at 5:50 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>>>>>
>>>>>> If I understand correctly, it enters an atomic section in
>>>>>> qcom_tzmem_alloc() and then tries to schedule somewhere down the line.
>>>>>> So this shouldn't be qseecom specific.
>>>>>>
>>>>>> I should probably also say that I'm currently testing this on a patched
>>>>>> v6.8 kernel, so there's a chance that it's my fault. However, as far as
>>>>>> I understand, it enters an atomic section in qcom_tzmem_alloc() and then
>>>>>> later tries to expand the pool memory with dma_alloc_coherent(). Which
>>>>>> AFAIK is allowed to sleep with GFP_KERNEL (and I guess that that's the
>>>>>> issue here).
>>>>>>
>>>>>> I've also tried the shmem allocator option, but that seems to get stuck
>>>>>> quite early at boot, before I even have usb-serial access to get any
>>>>>> logs. If I can find some more time, I'll try to see if I can get some
>>>>>> useful output for that.
>>>>>>
>>>>>
>>>>> Ah, I think it happens here:
>>>>>
>>>>> +       guard(spinlock_irqsave)(&pool->lock);
>>>>> +
>>>>> +again:
>>>>> +       vaddr = gen_pool_alloc(pool->genpool, size);
>>>>> +       if (!vaddr) {
>>>>> +               if (qcom_tzmem_try_grow_pool(pool, size, gfp))
>>>>> +                       goto again;
>>>>>
>>>>> We were called with GFP_KERNEL so this is what we pass on to
>>>>> qcom_tzmem_try_grow_pool() but we're now holding the spinlock. I need
>>>>> to revisit it. Thanks for the catch!
>>>>>
>>>>> Bart
>>>>
>>>> Can you try the following tree?
>>>>
>>>>       https://git.codelinaro.org/bartosz_golaszewski/linux.git
>>>> topic/shm-bridge-v10
>>>>
>>>> gen_pool_alloc() and gen_pool_add_virt() can be used without external
>>>> serialization. We only really need to protect the list of areas in the
>>>> pool when adding a new element. We could possibly even use
>>>> list_add_tail_rcu() as it updates the pointers atomically and go
>>>> lockless.
>>>
>>> Thanks! That fixes the allocations for CONFIG_QCOM_TZMEM_MODE_GENERIC=y.
>>> Unfortunately, with the shmbridge mode it still gets stuck at boot (and
>>> I haven't had the time to look into it yet).
>>>
>>> And for more bad news: It looks like the new allocator now fully exposes
>>> a bug that I've been tracking down the last couple of days. In short,
>>> uefisecapp doesn't seem to be happy when we split the allocations for
>>> request and response into two, causing commands to fail. Instead it
>>> wants a single buffer for both. Before, it seemed to be fairly sporadic
>>> (likely because kzalloc in sequence just returned consecutive memory
>>> almost all of the time) but now it's basically every call that fails.
>>>
>>> I have a fix for that almost ready and I'll likely post it in the next
>>> hour. But that means that you'll probably have to rebase this series
>>> on top of it...
>>
>> Forgot to mention: I tested it with the fix and this series, and that
>> works.
>>
> 
> Both with and without SHM bridge?

With CONFIG_QCOM_TZMEM_MODE_GENERIC=y (and the upcoming fix) everything
works. With CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=y things unfortunately
still get stuck at boot (regardless of the fix). I think that's
happening even before anything efivar related should come up.

> If so, please Cc me on the fix.

Sure, will do.

Best regards,
Max

