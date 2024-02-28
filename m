Return-Path: <linux-kernel+bounces-84648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5126886A97A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9269F283ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0262562C;
	Wed, 28 Feb 2024 08:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yZSOtEHp"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EA525567
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709107503; cv=none; b=BST1LZc9lFHEZItYIJ38GPuHiqqbtZeDjbH+2xZuYuqVxUOrYnnoOhw1Dsff0+C8ZT5rkhJAPSB7IayoV3cXwiJMsgGZYpNxdIBkJ1D3UqHIN5dKPQQ1B6gbvfU1UdA5IdookZB3bwS3NpimxQnJfxTkKUZzexrgxxjGvQV7FcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709107503; c=relaxed/simple;
	bh=rnC1y2SSq3RywIjq3hfkvfvqRvL4I+pH1frk6vkugDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5Gx8kw4WmdLL2vkA6mhxOIUAjERwX2b95f3lagSTNvu2zMrufrT/IUfodg1rqo5vmLi9CLsKacNnLuH4AJ7Lmybtd2JVZ6dZA2SwL7es4vpQRQ1mDV2dzvk4dwlSBdUttlPKI70ds4FjEqWkPR3Ln16gWjUhYawnTJ2U1E5Lp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yZSOtEHp; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33db19538d0so1128271f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 00:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709107499; x=1709712299; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vc502tF8ByhugONRdblELIyv+0sQYkGIhK4y3DjwW1c=;
        b=yZSOtEHpkPJG0lnm5EAANtYuG3xQe6BXt5pxAGGSkXzyrpezf/rdczgTK2n64vIugb
         EZEN6T0vBuLcqdFgp/O1CTtSDuOE5u0jsLooyNvqBi9fvnUBty5iVVZdSKYI6OOyphh+
         58gMH6xuoqucH62QEyeTkwG/npXdXjU+pPhnyoHMr3DqqTNd+RTCDDRBmbeF7RSfBlat
         NMDeqK+jhcS7Ic4jvh1oacOPBS7Z8oVamICR5GqMvbGAUb64Gkhk3AMp90MmC6cnl4qe
         bXBvsxx12IjM9oucWo26toJBEtxERC99R7bUXUhE8fKMOmuWw5A7l9eQNrAo5uPQhRp/
         f4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709107499; x=1709712299;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vc502tF8ByhugONRdblELIyv+0sQYkGIhK4y3DjwW1c=;
        b=IncC94Zevo3DE/59MJxFf9r+H7m7Aul9/K6opX/nvJla07Qb5Ncr1PTtjRQvqsDkQ6
         f/NUMTYl9V4v92A61O1ibuCyERMTMfwMc2V2wrxqYN0QKCszcnE5fq598CaMs22M3a+R
         nhxP6jp1idtyfc2YeGznn3D4kw5KlDHkLNGZMO5ztOj3Twg3+lGwZmcZCEyjPQqaXc6O
         xDfp+b73gGrMNOAR6BXlVnLydMRy4fjp7jGzoQLCRsoidy9ODc0NhP/FTkBZ+hMNVrWY
         etfPEcwofDxuZaDpdFdO36pzIN6xTMOmC9HhqJC39sBgKGPPj8FRxjg3fEg1AvWJe7vY
         ceYw==
X-Forwarded-Encrypted: i=1; AJvYcCU/dgtn8PWXXjv6UKmiTKTUTrwwvDy6cn5iQDIrYv0cBEGK7Z56ZfapKzEhAs5yb/0hVzptihjBTTnFySZWnCAEuqRGG0Da2Xvs0CMX
X-Gm-Message-State: AOJu0YxI1mRKP0YxqyB0AsYgZ770CUZhp1Vi+EG4YAQ0U1CehgzkHSAy
	cpTwK4bWletqL7WJXd5SXJ0dCSTnf+A2pStV2yPI5TkYghH3Dt4gxtKswYmmtRw=
X-Google-Smtp-Source: AGHT+IHXHO94MLl9EWvrABHlZzbmNiVmCMY19lCfuwoyoAY5uHCEF295TutBQdp+jSG71a/1ERu+XA==
X-Received: by 2002:a05:6000:a18:b0:33d:9fee:686f with SMTP id co24-20020a0560000a1800b0033d9fee686fmr9161553wrb.1.1709107499461;
        Wed, 28 Feb 2024 00:04:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:999:a3a0:ecf0:90fe:8664:ce2? ([2a01:e0a:999:a3a0:ecf0:90fe:8664:ce2])
        by smtp.gmail.com with ESMTPSA id a10-20020a5d4d4a000000b0033d13530134sm13550536wru.106.2024.02.28.00.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 00:04:59 -0800 (PST)
Message-ID: <0e0e5ca1-9c8f-4213-a795-9695f2ae234d@rivosinc.com>
Date: Wed, 28 Feb 2024 09:04:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] riscv: Set unalignment speed at compile time
To: Evan Green <evan@rivosinc.com>, Charlie Jenkins <charlie@rivosinc.com>
Cc: Conor Dooley <conor@kernel.org>, Conor Dooley
 <conor.dooley@microchip.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Jisheng Zhang <jszhang@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org,
 Charles Lohr <lohr85@gmail.com>
References: <20240216-disable_misaligned_probe_config-v4-0-dc01e581c0ac@rivosinc.com>
 <20240216-disable_misaligned_probe_config-v4-2-dc01e581c0ac@rivosinc.com>
 <20240227-condone-impeach-9469dffc6b47@wendy> <Zd4nMa+x28omuhiF@ghost>
 <20240227-citable-scanning-1fd48c96b758@spud> <Zd414nBtjHcsYWnL@ghost>
 <CALs-HssaGBHrFdavM=VYm+z0vBWKSnoS2b0cAmjnXA_Kji1KdA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CALs-HssaGBHrFdavM=VYm+z0vBWKSnoS2b0cAmjnXA_Kji1KdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 27/02/2024 20:44, Evan Green wrote:
> On Tue, Feb 27, 2024 at 11:20 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
>>
>> On Tue, Feb 27, 2024 at 06:48:54PM +0000, Conor Dooley wrote:
>>> On Tue, Feb 27, 2024 at 10:17:21AM -0800, Charlie Jenkins wrote:
>>>> On Tue, Feb 27, 2024 at 11:39:25AM +0000, Conor Dooley wrote:
>>>>> On Fri, Feb 16, 2024 at 12:33:19PM -0800, Charlie Jenkins wrote:
>>>
>>>>>> +config RISCV_EMULATED_UNALIGNED_ACCESS
>>>>>> +       bool "Assume the CPU expects emulated unaligned memory accesses"
>>>>>> +       depends on NONPORTABLE
>>>>>
>>>>> This is portable too, right?
>>>>
>>>> I guess so? I think I would prefer to have the probing being the only
>>>> portable option.
>>>
>>> I dunno, I think there could be value to someone in always emulating
>>> this in the kernel and I don't think that should relegate them to the
>>> naughty step, given it can work everywhere.
>>
>> Alright, I will remove the nonportable.
>>
>>>
>>>
>>>>>> +config RISCV_SLOW_UNALIGNED_ACCESS
>>>>>> +       bool "Assume the CPU supports slow unaligned memory accesses"
>>>>>> +       depends on NONPORTABLE
>>>>>> +       help
>>>>>> +         Assume that the CPU supports slow unaligned memory accesses. When
>>>>>> +         enabled, this option improves the performance of the kernel on such
>>>>>> +         CPUs.
>>>>>
>>>>> Does it? Are you sure that generating unaligned accesses on systems
>>>>> where they are slow is a performance increase?
>>>>> That said, I don't really see this option actually doing anything other
>>>>> than setting the value for hwprobe, so I don't actually know what the
>>>>> effect of this option actually is on the kernel's performance.
>>>>>
>>>>> Generally I would like to suggest a change from "CPU" to "system" here,
>>>>> since the slow cases that exist are mostly because the unaligned access
>>>>> is actually emulated in firmware.
>>>>
>>>> It would be ideal if "emulated" was used for any case of emulated
>>>> accesses (firmware or in the kernel).  Doing emulated accesses will be
>>>> orders of magnitude slower than a processor that "slowly" handles the
>>>> accesses.
>>>>
>>>> So even if the processor performs a "slow" access, it could still be
>>>> beneficial for the kernel to do the misaligned access rather than manual
>>>> do the alignment.
>>>
>>> Right. But, at least from a probing perspective, SLOW is what gets
>>> selected when firmware emulates the unaligned access so to userspace
>>> seeing slow means that the performance could be horrifically bad:
>>>
>>> |     rzfive:
>>> |         cpu0: Ratio of byte access time to unaligned word access is
>>> | 1.05, unaligned accesses are fast
>>> |
>>> |     icicle:
>>> |
>>> |         cpu1: Ratio of byte access time to unaligned word access is
>>> | 0.00, unaligned accesses are slow
>>> |         cpu2: Ratio of byte access time to unaligned word access is
>>> | 0.00, unaligned accesses are slow
>>> |         cpu3: Ratio of byte access time to unaligned word access is
>>> | 0.00, unaligned accesses are slow
>>> |
>>> |         cpu0: Ratio of byte access time to unaligned word access is
>>> | 0.00, unaligned accesses are slow
>>> |
>>> |     k210:
>>> |
>>> |         cpu1: Ratio of byte access time to unaligned word access is
>>> | 0.02, unaligned accesses are slow
>>> |         cpu0: Ratio of byte access time to unaligned word access is
>>> | 0.02, unaligned accesses are slow
>>> |
>>> |     starlight:
>>> |
>>> |         cpu1: Ratio of byte access time to unaligned word access is
>>> | 0.01, unaligned accesses are slow
>>> |         cpu0: Ratio of byte access time to unaligned word access is
>>> | 0.02, unaligned accesses are slow
>>> |
>>> |     vexriscv/orangecrab:
>>> |
>>> |         cpu0: Ratio of byte access time to unaligned word access is
>>> | 0.00, unaligned accesses are slow
>>>  https://lore.kernel.org/all/CAMuHMdVtXGjP8VFMiv-7OMFz1XvfU1cz=Fw4jL3fcp4wO1etzQ@mail.gmail.com/
>>
>> If the accesses are horrifically slow then maybe they should be flagged
>> as emulated rather than slow by the probe.
> 
> Yeah, I thought about that too. I didn't feel like I had enough info
> to come up with the delineating number for "horrifically slow". Plus
> Clement came in with a series to detect specifically that accesses are
> emulated (though it will only work on future platforms that can
> delegate the trap to the kernel).

Yes, the delegation request mechanism should be part of SBI 3.0. At that
point we should be able to detect properly if accesses are emulated or
slow (providing the SBI implements the new extension).

Clément

> 
> -Evan

