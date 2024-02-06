Return-Path: <linux-kernel+bounces-54583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AAE84B11A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9831F24CB2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DAE745E0;
	Tue,  6 Feb 2024 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="U2E+ab0L"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DCF12BF3C
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707211500; cv=none; b=FF4w1I9XaXiaFRl4QSEdqmg/fO8u2GyVPCwdqON9Ii7apvdgy7BTQpvD6Br99Ewj9zKEqRqtrkiihHKumXSBBpcA+IBhFBASMxQ8nRgc7ZrA/EbdjaMN4tbn1Q8Czs6/RIhxN6BTBPI231qw+deBI0tTTLnB/4VuxoLOouIr9I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707211500; c=relaxed/simple;
	bh=vOqlbdfxhcsaCnZ17fBY9oZbHfd19Xy/8LiZ75ANLJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BrjtYLS3azf6viMKb7YFTzTqOqzkhEa5qnX71UugXHBDGc7wlaB3UCtBiRY2cnUEkpGnQS26R6Whx1sRTD5vwk57jMdlG88ORTHm5bbmsoiFyZwtIQDUUzIEbAUbJBJ4gEAGe0aZdgCrUhTZeZo9uSuKm4P5KPKpWsxUVU3f284=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=U2E+ab0L; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d97e303fdfso5315605ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 01:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707211498; x=1707816298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R8r9psvandqJ07ZF90QtVTVKq/Y9rSgNYXnuqiW3t60=;
        b=U2E+ab0LtKrzNOoRX2m3paTMdRjtL4we5ZBamkWybh9/8nHanZCepDq0SJQXVq8yfZ
         aUstvQxffwX3qgwyl2PJqi9MLO2DtTTiQD9hZDg13qJ2fA1BwxuRDGi1NB0DLszHcHm8
         jFuJ4ILn8HbN/hMRR8eA+ix04FblP/fEiDDzYoswJq4kOKrwIpQ+uMegnT887NK+KqK/
         6ZCK2mJBHQChQpY+fCV+EI+nUVhlJc3dpVkOZNEkGsSCzNzw+Lb7GYVb7lxOhJWbYSIv
         dk6izRSThblN8EuuQONblfYl+776zkZYpk3qtkj+9CqfDOuclNzbMrZIwV1MRTTvLOZj
         YiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707211498; x=1707816298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8r9psvandqJ07ZF90QtVTVKq/Y9rSgNYXnuqiW3t60=;
        b=kTTJ2mNsFYbhtaJjku+n2O9B5RkMGzoTbNj2UgmHkEOcybUBxugDvudNYLm3gHuDlb
         IwuHAlKPbiSwjAknispxTThjatSaF0Ynajz8KhGKFRBMGq8bTNlzY8qZK1jCZHthXsVT
         3GSPmkh3bKA+V2i7b+Ce8rxYQTbiIbM8bjJxt2Sk/Zaob2Hh7YBz2DbzXjDI+1Oj6w3h
         B43maGaqomdAWpwFMtQAwY3i8DzMrR8HsZe0VJKKgbMxvlHWx1Lq3K2F/wNdLa3UCg81
         Hz529m3k9nE8tByWCEJ8ccf/XwF2GXPCL8c60HzukjUzLOCOXmyoK9tMReDzzwMa97/S
         PfsA==
X-Gm-Message-State: AOJu0YxG/bi1coHqEg6mRGqShq670uFy3xr0c5DlBnF8kGQD7yEUIBp1
	tkUe+/y3gLhmxv8CfP3pWCKiUNQI+vBXqF9H6HueC/M5eCZMQSaENdrr6GTykJHXrX/gW+Z5Vxx
	o
X-Google-Smtp-Source: AGHT+IEyWQ/Tdp7OhsXODjgzE6QvJ6i+EwJdHXr+0N64oDh9My4/IcabB4BRaQg/teyOL6XTGHR9kg==
X-Received: by 2002:a17:902:ec8a:b0:1d5:efd6:20f with SMTP id x10-20020a170902ec8a00b001d5efd6020fmr2289192plg.1.1707211497690;
        Tue, 06 Feb 2024 01:24:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVIzuoQFU0lBMGRFz1/ZSjCVIWe8aszIpAeYlO3KU1WZQl34maPzJhby59uoO5k/xzRpgCtChE/GKINEO8rM/E1wJK3Ax51vo5U//jFZX2EaiGBDyItOewtQUJiKRGkkpGgZx5+hmYdHoe32vv7taCW7lm6dMLE/js1Z72YtPzRlDfFRFoGkLPtMuxBoXG1qiXeM07GDdbPhxaCLZE5GFGx4DMY/ThoDDO4awnE56qoXpnpW5/cOpA52OhOUPU3ZfTP5XgyBK9TQcCz3zeloPa1X06MXACOAHyfNo9TZQsKcsw3uBPnGu2v2eTAYjLREFJvqZ+pyrZo8SOaY0K8cZ7DLofWFWA=
Received: from ?IPV6:2a01:e0a:999:a3a0:20a2:d2ee:941a:156e? ([2a01:e0a:999:a3a0:20a2:d2ee:941a:156e])
        by smtp.gmail.com with ESMTPSA id ky12-20020a170902f98c00b001d8a80cbb15sm1353566plb.238.2024.02.06.01.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 01:24:57 -0800 (PST)
Message-ID: <32cfb8d2-7ea1-44da-8739-2cbe2b597b60@rivosinc.com>
Date: Tue, 6 Feb 2024 10:24:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: hwprobe: export VA_BITS
To: Jessica Clarke <jrtc27@jrtc27.com>, Stefan O'Rear <sorear@fastmail.com>
Cc: Charlie Jenkins <charlie@rivosinc.com>, Jonathan Corbet <corbet@lwn.net>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-doc@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>,
 linux-kernel@vger.kernel.org, Robin Ehn <rehn@rivosinc.com>
References: <20240201140319.360088-1-cleger@rivosinc.com>
 <ZbxUUsKdKIPI8Fb/@ghost> <701d3350-93d3-4235-aaf7-04c6492420a7@rivosinc.com>
 <5657c211-531b-4890-8c52-182b7b4eae7c@app.fastmail.com>
 <5A2420B9-6039-445B-B2C3-77F13EDD77BA@jrtc27.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <5A2420B9-6039-445B-B2C3-77F13EDD77BA@jrtc27.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 04/02/2024 01:22, Jessica Clarke wrote:
> On 3 Feb 2024, at 10:40, Stefan O'Rear <sorear@fastmail.com> wrote:
>>
>> On Fri, Feb 2, 2024, at 3:22 AM, Clément Léger wrote:
>>> On 02/02/2024 03:32, Charlie Jenkins wrote:
>>>> On Thu, Feb 01, 2024 at 03:02:45PM +0100, Clément Léger wrote:
>>>>> Some userspace applications (OpenJDK for instance) uses the free bits
>>>>> in pointers to insert additional information for their own logic.
>>>>> Currently they rely on parsing /proc/cpuinfo to obtain the current value
>>>>> of virtual address used bits [1]. Exporting VA_BITS through hwprobe will
>>>>> allow for a more stable interface to be used.
>>>>
>>>> mmap already supports this without a need for applications to know the
>>>> underlying hardware. If a hint address is passed into mmap, it will never
>>>> return an address that uses more bits than the hint address. I designed
>>>> it that way so that something like this wasn't necessary.
>>>
>>> Ok even though probing this kind of thing is probably not what mmap is
>>> meant to do. IMHO, probing this through the regular hwprobe interface is
>>> probably more coherent but maybe Robin (which needs this information)
>>> can rely on that.
>>
>> Both of these are useful, separately and in conjunction.
>>
>> hwprobe allows applications which can adapt to different VA sizes to learn
>> which is in use prior to allocating memory.
>>
>> mmap hints allow applications which require a fixed limit on the VA size to
>> express that limit at the point of requirement, the hint can be set based on
>> the hwprobe result to explicitly indicate its use.
> 
> Neither is an architecture-specific concept though. If you want to
> expose a notion of VA bits to userspace then it should probably be done
> in a more generic manner than the RISC-V-specific hwprobe syscall,
> probably as two numbers, low and high bits (ia64’s regions may be gone,
> but sparc64 still has both halves of the address space presented to
> userspace, with the stack in high/negative memory).

Agreed, this is not architecture specific. The initial goal was to
expose SVxx extensions which are hardware specific but it seemed wrong
since this is some S-mode extension. But maybe we can go back with
exposing these extensions rather than VA_BITS.

If exposing VA_BITS is still  useful for other architectures, maybe
exposing a mask of "used" bits could be more flexible. Which mechanism
to use to expose that is another problem. sysconf() might be a good fit
since it already exposes page size.

Clément

> 
> Jess
> 
>> -s
>>
>>> Clément
>>>
>>>>
>>>> - Charlie
>>>>
>>>>>
>>>>> Link: https://github.com/openjdk/jdk/blob/master/src/hotspot/os_cpu/linux_riscv/vm_version_linux_riscv.cpp#L171 [1]
>>>>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>>>>
>>>>> ---
>>>>> Documentation/arch/riscv/hwprobe.rst  | 3 +++
>>>>> arch/riscv/include/asm/hwprobe.h      | 2 +-
>>>>> arch/riscv/include/uapi/asm/hwprobe.h | 1 +
>>>>> arch/riscv/kernel/sys_hwprobe.c       | 3 +++
>>>>> 4 files changed, 8 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
>>>>> index b2bcc9eed9aa..6f198c6ed4f0 100644
>>>>> --- a/Documentation/arch/riscv/hwprobe.rst
>>>>> +++ b/Documentation/arch/riscv/hwprobe.rst
>>>>> @@ -210,3 +210,6 @@ The following keys are defined:
>>>>>
>>>>> * :c:macro:`RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE`: An unsigned int which
>>>>>   represents the size of the Zicboz block in bytes.
>>>>> +
>>>>> +* :c:macro:`RISCV_HWPROBE_KEY_VA_BITS`: An unsigned long which
>>>>> +  represent the number of bits used to store virtual addresses.
>>>>> diff --git a/arch/riscv/include/asm/hwprobe.h b/arch/riscv/include/asm/hwprobe.h
>>>>> index 630507dff5ea..150a9877b0af 100644
>>>>> --- a/arch/riscv/include/asm/hwprobe.h
>>>>> +++ b/arch/riscv/include/asm/hwprobe.h
>>>>> @@ -8,7 +8,7 @@
>>>>>
>>>>> #include <uapi/asm/hwprobe.h>
>>>>>
>>>>> -#define RISCV_HWPROBE_MAX_KEY 6
>>>>> +#define RISCV_HWPROBE_MAX_KEY 7
>>>>>
>>>>> static inline bool riscv_hwprobe_key_is_valid(__s64 key)
>>>>> {
>>>>> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
>>>>> index 9f2a8e3ff204..2a5006cddb7b 100644
>>>>> --- a/arch/riscv/include/uapi/asm/hwprobe.h
>>>>> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
>>>>> @@ -67,6 +67,7 @@ struct riscv_hwprobe {
>>>>> #define RISCV_HWPROBE_MISALIGNED_UNSUPPORTED (4 << 0)
>>>>> #define RISCV_HWPROBE_MISALIGNED_MASK (7 << 0)
>>>>> #define RISCV_HWPROBE_KEY_ZICBOZ_BLOCK_SIZE 6
>>>>> +#define RISCV_HWPROBE_KEY_VA_BITS 7
>>>>> /* Increase RISCV_HWPROBE_MAX_KEY when adding items. */
>>>>>
>>>>> /* Flags */
>>>>> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
>>>>> index a7c56b41efd2..328435836e36 100644
>>>>> --- a/arch/riscv/kernel/sys_hwprobe.c
>>>>> +++ b/arch/riscv/kernel/sys_hwprobe.c
>>>>> @@ -202,6 +202,9 @@ static void hwprobe_one_pair(struct riscv_hwprobe *pair,
>>>>> if (hwprobe_ext0_has(cpus, RISCV_HWPROBE_EXT_ZICBOZ))
>>>>> pair->value = riscv_cboz_block_size;
>>>>> break;
>>>>> + case RISCV_HWPROBE_KEY_VA_BITS:
>>>>> + pair->value = VA_BITS;
>>>>> + break;
>>>>>
>>>>> /*
>>>>>  * For forward compatibility, unknown keys don't fail the whole
>>>>> -- 
>>>>> 2.43.0
>>>>>
>>>>>
>>>>> _______________________________________________
>>>>> linux-riscv mailing list
>>>>> linux-riscv@lists.infradead.org
>>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>>
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> 

