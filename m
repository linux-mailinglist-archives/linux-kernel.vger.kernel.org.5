Return-Path: <linux-kernel+bounces-125293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9905D89239C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6875B23C3C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643B94D9F9;
	Fri, 29 Mar 2024 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FH/mjfvs"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4041DA5E;
	Fri, 29 Mar 2024 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711738430; cv=none; b=J6DI/fClfC+Sgwpc7dzDjA/ZFf/L5AD8PJhC11roPycctRL0jYMW8jw3RmBeJhtBk7E+gIHYsQxC1mOK6k6kWJY9CBIOWvzV1BfhBqvqtOfhLGZHLpP0EjkId7mk605a+x5qmLX5pqtc2b5pmJfnNJmAQoN26Oku5c4Ym8WnCfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711738430; c=relaxed/simple;
	bh=MrcWaccHuWO26Oo0rz+WLEjrhuK5Slp6ybTdJPwnkUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tAQ/ABMY0LXTxGXW+ymVZ1VDwhzbBZuF6NSNKRkQ+8zBrfqVdkQua3ot61OXY4NLo5GmZh07JUFq1Gsy1GLX+smYSZQb+/V/AYYj45fKdQ+ChtibiPqZPKOrlAqHZwdiy+VJwMHL212WStYKMXh1A/NNabTitpCbc3W00Sw0F0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FH/mjfvs; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41551639550so4244285e9.2;
        Fri, 29 Mar 2024 11:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711738427; x=1712343227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qvFwD0VdyHpD42fxMgclHLAoEOf/dK1nAyEahgoL8Ow=;
        b=FH/mjfvsP7cjaD8Y15aEl/Q/UbG7sNwZz1H9jOkMMjopAbbKfJ2hTdPTffgdi0LKJv
         Db/EuUBNjZwJYmNCOZOaMBSUidHfSUYFm/kOB+qnJ+9l/3cfC8ystfzKgcWEwSX47rRe
         5ZY7/xemZAuDNLP3LICFhV61UygiU5cnreQb28EBWaCTNctGlAr0ViUDxibIwYB4AFCD
         pQ9DNYBbQji3MNwikvjaLgG/+KErXMIaErLlwco40Kuyy5Asvm/wAbQFmNvEWSPikWTp
         7FW1/240S5+j9SIn/dMOokX3jnaJAxHsZ44F3vpXRmbg2rXe87w8GIs2lFyJU8ug7/tz
         uygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711738427; x=1712343227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qvFwD0VdyHpD42fxMgclHLAoEOf/dK1nAyEahgoL8Ow=;
        b=JIfjlKFJ9M7W9nSTsfkUlrYpFcagv/5kmJW3mlFNQKfn9jI7vg55z6hQhaTV679tRX
         xynDGTQi1WiJpnzwtmvwbMxTkwhiHB0h9aZ+pvehewn2/qzyuACbxFSDcKBWIaihUdWX
         t5LufI4DrqE7L0riihqMAuixvMTLPudX5JaNtynjCpZvDjnT+CB3BmzOCmioXk2ygo3H
         Imyb+U3mViDwMj6HO8+O564D8hz5ZKnKf7ynNJG7w8QQh58OH6OW5AljTKQG+JRsIPpe
         wMiU+PIRHcGudjjHU7pB4a0Tru1qh++95PvReckkWSMHY+uWPlXqovK+HB1YV79ROrlW
         odUg==
X-Forwarded-Encrypted: i=1; AJvYcCUKRugg1357y0nRUYGqGm8uFhBWOTf/tPrgL0768kNIN4kmEIm4oGiQ6TyNq3pKRTEM1YV3J1yHkWVOpoDde13noEYj6blHLiPHcHsa147PbKnsops/dha+JczhCE1TfMS+ilgy7jITGdXTmQ==
X-Gm-Message-State: AOJu0YzH0+8Y5HEzBdl2a+mEN5WGteA79N23ydUEW9uNcxV/FyMsnRxx
	uK3sVE/bodkPo+ZRSLVY5AZQSWMUSEx1dxV+ivb+mkIxuvKxEcq0
X-Google-Smtp-Source: AGHT+IELe0KtVPfoSVZEkGdtTR/jfCpqwbpre3tc4QE7Gw5yu0BJvPt8AEdvpdIbAVOLH+DXXLT5Dg==
X-Received: by 2002:a05:600c:3587:b0:414:887f:6167 with SMTP id p7-20020a05600c358700b00414887f6167mr2456768wmq.7.1711738427084;
        Fri, 29 Mar 2024 11:53:47 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id o10-20020a05600c510a00b004148a5e3188sm9331808wms.25.2024.03.29.11.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 11:53:46 -0700 (PDT)
Message-ID: <82f94b54-82d1-49b9-badf-63d948b347fc@gmail.com>
Date: Fri, 29 Mar 2024 19:53:44 +0100
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
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <CAMRc=MfsVWcoMC-dB-fdxy332h-ucUPTfEUMAnCt5L-q3zJxWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/29/24 11:22 AM, Bartosz Golaszewski wrote:
> On Thu, Mar 28, 2024 at 7:55 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>> On Thu, Mar 28, 2024 at 5:50 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>>
>>> If I understand correctly, it enters an atomic section in
>>> qcom_tzmem_alloc() and then tries to schedule somewhere down the line.
>>> So this shouldn't be qseecom specific.
>>>
>>> I should probably also say that I'm currently testing this on a patched
>>> v6.8 kernel, so there's a chance that it's my fault. However, as far as
>>> I understand, it enters an atomic section in qcom_tzmem_alloc() and then
>>> later tries to expand the pool memory with dma_alloc_coherent(). Which
>>> AFAIK is allowed to sleep with GFP_KERNEL (and I guess that that's the
>>> issue here).
>>>
>>> I've also tried the shmem allocator option, but that seems to get stuck
>>> quite early at boot, before I even have usb-serial access to get any
>>> logs. If I can find some more time, I'll try to see if I can get some
>>> useful output for that.
>>>
>>
>> Ah, I think it happens here:
>>
>> +       guard(spinlock_irqsave)(&pool->lock);
>> +
>> +again:
>> +       vaddr = gen_pool_alloc(pool->genpool, size);
>> +       if (!vaddr) {
>> +               if (qcom_tzmem_try_grow_pool(pool, size, gfp))
>> +                       goto again;
>>
>> We were called with GFP_KERNEL so this is what we pass on to
>> qcom_tzmem_try_grow_pool() but we're now holding the spinlock. I need
>> to revisit it. Thanks for the catch!
>>
>> Bart
> 
> Can you try the following tree?
> 
>      https://git.codelinaro.org/bartosz_golaszewski/linux.git
> topic/shm-bridge-v10
> 
> gen_pool_alloc() and gen_pool_add_virt() can be used without external
> serialization. We only really need to protect the list of areas in the
> pool when adding a new element. We could possibly even use
> list_add_tail_rcu() as it updates the pointers atomically and go
> lockless.

Thanks! That fixes the allocations for CONFIG_QCOM_TZMEM_MODE_GENERIC=y.
Unfortunately, with the shmbridge mode it still gets stuck at boot (and
I haven't had the time to look into it yet).

And for more bad news: It looks like the new allocator now fully exposes
a bug that I've been tracking down the last couple of days. In short,
uefisecapp doesn't seem to be happy when we split the allocations for
request and response into two, causing commands to fail. Instead it
wants a single buffer for both. Before, it seemed to be fairly sporadic
(likely because kzalloc in sequence just returned consecutive memory
almost all of the time) but now it's basically every call that fails.

I have a fix for that almost ready and I'll likely post it in the next
hour. But that means that you'll probably have to rebase this series
on top of it...

Best regards,
Max


