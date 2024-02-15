Return-Path: <linux-kernel+bounces-67408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F78856AFD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C1591C2418C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D110136999;
	Thu, 15 Feb 2024 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9mmhxKA"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAD2136674;
	Thu, 15 Feb 2024 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018183; cv=none; b=mzqRMnYgyrGZtnxb9U9fFDhIsDUImUVcy5PIHMMYsqSy+djS+0/YMq3YmRkC6MSJXO7+DGzcu2UJsQE3td8zGtSkAAU5y7mUpI1rCdjaFNyecrmiSMY8xPOq+yfXwInpApKVoGl+cSKYvci32W2B3/Il7907DK/Yq6JytbnFT2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018183; c=relaxed/simple;
	bh=Tu04A/tYEInRqlhtMyUCiPQz+FcaRurq4xxfnzEfa0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hswFZuinNvep8VZm4sXlSoObOJitb8D2vOrGdCDnsr//XotQJqHTBOxp0K9vWhwcHJkmu5l+ngpBzFyhzvTCoU+4t863f81k5NClE6l8/1OLFDqOHkQ0ggVigVfFOUwdcSSx50Nt51yva+0Rxg3ZnwnKgP1hmVT0yujAt+cOoKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9mmhxKA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d8aadc624dso9511135ad.0;
        Thu, 15 Feb 2024 09:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708018181; x=1708622981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=6pWmAvVc8iLBZa9BoIsuJ5Nc1dEHrTnzdyfUL7RUnKs=;
        b=H9mmhxKAavqx5QW7xr48X9z107SM2aJCecM+fVQ1lYCXUzRNWKnAlCbq2D9ss9LoXC
         N5dZR+mS4tL8ulraItzGA6l1AWMiwa7YBGHRnVf9V95GlQwHREV+h+fLO4nGx60i0IK4
         7kawVe5tDf1vEuc/fltT95SQt6HxOK1PJI0Sds3X+/djrajaR1fPpXeRJLfuE0VyIk/1
         NmJrePzMY948zANLYB137gtM4vUY1OQN9yDn6m5cxHoGQebihbGB2AQgEmt0X1uh78UI
         /FesQ/nFgK369ZOhJORiS0Fj4JWCf92xDOtP7AEaTQXQNhJbUSqVTLw8uNu4FAW2B4lT
         TS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708018181; x=1708622981;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6pWmAvVc8iLBZa9BoIsuJ5Nc1dEHrTnzdyfUL7RUnKs=;
        b=a0Joxq5iJm4ds+dE5fQSbG6Tbvj02O9VGNb9fWt3k1LnEhHZWgNpkBEgi3Dy8U3u8/
         2vIbavZLUqMtknDjj9E4xzSHFlP3ZSacq/m8ZLiuUIemwDhBxhHtyE+Niu8+LuLogGCl
         wWTVhimM63SHiVDjeXRAxET71iYjvtigFXtGtdVRu4A9T7OQbV8d6ygL9FNFwYkvLT1r
         eCzQQ/yrzYqyRwcf1phU12bsdPoIP66libQCyWPwnqxnWKWFua6axEuHbw9ovHgGQ3v8
         Aj9+O72ZIPS27iwnObzD/S03yqdxdBN+SljHlaOurbxIKz3DSswaCFtvBlS1CJKdK/at
         AIEA==
X-Forwarded-Encrypted: i=1; AJvYcCWIus1/TgKYba9cDQoKxO8VZ9odGZITSaspzEOCbK7CRSl5pRwUWSFc8JjxCoh6k1DbxQszEphejmfUSdpgMx189ym0YXIffHpD1mFvarxobB64Tjbx78rw1uFWz2lKHd95593Nf7cHI734
X-Gm-Message-State: AOJu0YxJ24NAsuAf1fh1uWrr3rHFXcsyXUDpY4B2EHnZQMBYLQYB9Vo6
	kAl/JTLC/+pyVw6qxks1UYDRXgsqH9T5xOi1c8fbS43ev+7ZN+7b
X-Google-Smtp-Source: AGHT+IHdMGjY2xM4W/w5uIboqudsCbZXuOZLgZZPQcfcjVjFRbky08BzvkCnoZ9wl0dP4qQ2f3JXTg==
X-Received: by 2002:a17:902:b78c:b0:1db:562c:1823 with SMTP id e12-20020a170902b78c00b001db562c1823mr2368895pls.36.1708018181033;
        Thu, 15 Feb 2024 09:29:41 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jz4-20020a170903430400b001db94dfc2b5sm941771plb.107.2024.02.15.09.29.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 09:29:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3c35ed45-2455-4727-920b-98f5fe2679e2@roeck-us.net>
Date: Thu, 15 Feb 2024 09:29:38 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: John David Anglin <dave.anglin@bell.net>,
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Parisc List <linux-parisc@vger.kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com>
 <20240214-fix_sparse_errors_checksum_tests-v8-2-36b60e673593@rivosinc.com>
 <2ec91b11-23c7-4beb-8cef-c68367c8f029@roeck-us.net> <Zc1pSi59aDOnqz++@ghost>
 <cb4e358b-3fd0-4ca4-bf53-9cc379087304@roeck-us.net>
 <1d5e059e-5b31-415d-ae41-593415812e94@bell.net> <Zc2GfgiCpevtKTtS@ghost>
 <11fff7fe-ec4c-4340-a67f-d1d54d0712d8@roeck-us.net> <Zc4veRSmxHHqu/bB@ghost>
 <0fa4d53a-6ce7-4f44-81b2-86282f0b9451@roeck-us.net> <Zc5A+c0gmxtygNIa@ghost>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Zc5A+c0gmxtygNIa@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/15/24 08:51, Charlie Jenkins wrote:
> On Thu, Feb 15, 2024 at 08:30:22AM -0800, Guenter Roeck wrote:
>> On 2/15/24 07:36, Charlie Jenkins wrote:
>>> On Thu, Feb 15, 2024 at 12:56:13AM -0800, Guenter Roeck wrote:
>>>> On 2/14/24 19:35, Charlie Jenkins wrote:
>>>>> On Wed, Feb 14, 2024 at 10:00:37PM -0500, John David Anglin wrote:
>>>>>> On 2024-02-14 8:58 p.m., Guenter Roeck wrote:
>>>>>>> Specifically: Yes, the carry/borrow bits should be restored. Question is
>>>>>>> if the Linux kernel's interrupt handler doesn't restore the carry bits
>>>>>>> or if the problem is on the qemu side.
>>>>>> The carry/borrow bits in the PSW should be saved and restored by the save_specials
>>>>>> and rest_specials macros.  They are defined in arch/parisc/include/asm/assembly.h.
>>>>>
>>>>> Why would they be needed to be restored in linux? The manual says "The
>>>>> PSW is set to the contents of the IPSW by the RETURN FROM INTERRUPTION
>>>>> instruction". This means that the PSW must be restored by the hardware.
>>>>>
>>>>> We can see the QEMU implementation in:
>>>>>
>>>>> rfi:
>>>>> https://github.com/qemu/qemu/blob/v8.2.1/target/hppa/sys_helper.c#L93
>>>>>
>>>>> handling interrupt:
>>>>> https://github.com/qemu/qemu/blob/v8.2.1/target/hppa/int_helper.c#L109
>>>>>
>>>>> However the implementation appears to be faulty. During an RFI, the PSW
>>>>> is always set to 0x804000e (regardless of what the PSW was before the
>>>>> interrupt).
>>>>>
>>>>
>>>> Not sure if I agree. The interrupt handler in Linux is the one which needs to set
>>>> IPSW. Looking into the code, I agree with Dave that the tophys macro seems to
>>>> clobber the carry bits before psw is saved, so they can not really be restored.
>>>> The only issue with that idea is that I can only reproduce the problem with
>>>> an interrupted ldd instruction but not, for example, with ldw. This is why it
>>>> would be really important to have someone with real hardware test this.
>>>>
>>>> Thanks,
>>>> Guenter
>>>
>>> Yes, we definitely feedback from somebody with access to hardware, but I
>>> do not understand how "The PSW is set to the contents of the IPSW by the
>>> RETURN FROM INTERRUPTION" could be interpreted as anything except that
>>> the hardware is expected to over-write the contents of the PSW during
>>> the rfi.
>>>
>>
>> Sure, I absolutely agree. But that assumes that IPSW is set correctly
>> in the Linux interrupt handler. We do know that something odd happens
> 
> The manual defines the saving of PSW as the responsibility of the
> hardware as well: "When an interruption occurs, the current value of the
> PSW is saved in the Interruption Processor Status Word (IPSW)". I don't
> think this should be interpreted to mean that a software interrupt
> handler is required to save the IPSW.
> 

Sorry, I meant the manipulation of ipsw by the linux interrupt handler.

Guenter

> - Charlie
> 
>> when an unaligned ldd is encountered. At least for my part I don't know
>> if the problem is in emulate_ldd() in the Linux kernel or in the ldd
>> implementation and trap handling in qemu. I do know (from my logs)
>> that qemu does see the correct PSW/IPSW values, because they do
>> show up correctly in the Linux kernel when running the qemu emulation.
>> Only it somehow gets lost when the Linux interrupt handler returns.
>>
>> Thanks.
>> Guenter
>>


