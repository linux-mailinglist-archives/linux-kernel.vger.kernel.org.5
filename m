Return-Path: <linux-kernel+bounces-66234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7D58558DD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 02:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712C51C2332A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E3D1C0F;
	Thu, 15 Feb 2024 01:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5WoLlHd"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B26D184E;
	Thu, 15 Feb 2024 01:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707962294; cv=none; b=mzoVLNBUJUMtImrnyeF2GUFXbzR9duNjTjWrO/RXXjBmryNT4uZgwCWzGP6duJBp9NB4ZZMR6vopx52q9+6iCf3d9uOnMY9xSf327S2B7uGqCnw6TeVgSoivxgOc+rnTWYoTNYharygYJF5/x7msyOf5snxBCyfZfapi074IW2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707962294; c=relaxed/simple;
	bh=dyYKjfJrvnkHCRfDScJsdh2BCcE8PsyhqJ4uBpiLcQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mmm8sbETePUtcJC8TZyC1jSlHYpozwJfKV9mzHaKDPuItxONjJXd1Xsf9qV7kL6YYN4LH3etiAbemf7eeosET51uKXzR764/WY9LuEqez1DY7D39re2biRspu11Tn/vJulmzAGu0QgpMVjc+3UtUdbnFO2O3XbFR2J0B+QLn2BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5WoLlHd; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5dbf7b74402so345084a12.0;
        Wed, 14 Feb 2024 17:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707962291; x=1708567091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=htGW/e8GI+F2UFASV1GomX9AsIMgFedKg9ypjTyRfqk=;
        b=Y5WoLlHdxLNB+YmSyCzT9XQ+7ui5YD5RxUc41pyGgDAmkRjcxfTfsXmukcanLM1tjk
         TmdFUYraYKMSD9s1iKmSJpo0OH20HM/YBZW/s7nmyakI/Z9/CXqzTNoGVCa7qMK+JTuN
         udB7MhnYBgM4T11hp7yoa9eK0Wi+b8iw/aHFuMy/FvMEpWfiZ04NnUP9pqOKwNTnfp4C
         Qj1rMO/4g31vA1r+RQ3G5top4I1hrveaysMt/EoQtiEfYYMuN/VBqzcBJLiTQAx0eqSP
         b1CLhKrMGN1/PoDgpC0av/SQWQ2dMM3kGq5MRF+xkQRxZjR5P/V+N0jTdKPHvnnzFk24
         Yreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707962291; x=1708567091;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htGW/e8GI+F2UFASV1GomX9AsIMgFedKg9ypjTyRfqk=;
        b=MTzK3O3uOqLJBtry644QYEBu8+OKySByUA388bKTVcgNLhyXslCIp73lmKomWhSh3J
         TWArQ9FH+A6amgp9v4BfHgpbeUdXWzGIkM5WNi9FkacL/SJ162fq3T1O2XRqSBezbv94
         kbyblHZD0hQuog0c0bpuq6CxvxStg+FAPvG7xynIVlrmhHUeEEKsLtGca4DK8oJ/lp8f
         H7kXWynS6XPanZ82ani5DCuWPeNyZltVRY++45i0Nmij7dd23U5hyn1GhX2kA4WLqo7D
         +1DDQ1kjNX5W5nQ9PjwRy/rQUGFmxSsBgp5szp8VpRN8NOrj+QG46yKF7AjJ96XZkX6I
         va+w==
X-Forwarded-Encrypted: i=1; AJvYcCViQ+UGP7CENfRp86OMYo7/hSf3LiVuFjVGFOzO6dzMG5fHOeo5YV1ZC+Q/N85mQB62oZ3kzYwnIHrb3vdMpEpS4EZGeog3TjJTNPVASwp0wRnyTVgeVDY6R+SZVUqvzpdaAluH10CWQca7
X-Gm-Message-State: AOJu0YwmIlEN55Ma3TUSnbbTVbnINJgCAoo65/evaYVZDe7g+WOomSjP
	ny2H8YtMVaq0ULRJGe5CXcFEGNo+R0qks7++X5k8+0MLKbKuRUBhSnHr8OGt
X-Google-Smtp-Source: AGHT+IEizk+6xlAROeTrgkBev5o0tVhsDH3KFE4TJjnGEzH7VB+7oN00ZHxg3vRyhNI1zT2yQBs2pg==
X-Received: by 2002:a05:6a20:e605:b0:1a0:686b:afec with SMTP id my5-20020a056a20e60500b001a0686bafecmr605289pzb.10.1707962291398;
        Wed, 14 Feb 2024 17:58:11 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x41-20020a056a0018a900b006e02f4bb4e4sm127106pfh.18.2024.02.14.17.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 17:58:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cb4e358b-3fd0-4ca4-bf53-9cc379087304@roeck-us.net>
Date: Wed, 14 Feb 2024 17:58:09 -0800
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
Cc: David Laight <David.Laight@aculab.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Parisc List <linux-parisc@vger.kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com>
 <20240214-fix_sparse_errors_checksum_tests-v8-2-36b60e673593@rivosinc.com>
 <2ec91b11-23c7-4beb-8cef-c68367c8f029@roeck-us.net> <Zc1pSi59aDOnqz++@ghost>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Zc1pSi59aDOnqz++@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Charlie,

On 2/14/24 17:30, Charlie Jenkins wrote:
> On Wed, Feb 14, 2024 at 03:03:07PM -0800, Guenter Roeck wrote:
>> On 2/14/24 13:41, Charlie Jenkins wrote:
>>> The test cases for ip_fast_csum and csum_ipv6_magic were failing on a
>>> variety of architectures that are big endian or do not support
>>> misalgined accesses. Both of these test cases are changed to support big
>>> and little endian architectures.
>>>
>>> The test for ip_fast_csum is changed to align the data along (14 +
>>> NET_IP_ALIGN) bytes which is the alignment of an IP header. The test for
>>> csum_ipv6_magic aligns the data using a struct. An extra padding field
>>> is added to the struct to ensure that the size of the struct is the same
>>> on all architectures (44 bytes).
>>>
>>> The test for csum_ipv6_magic somewhat arbitrarily aligned saddr and
>>> daddr. This would fail on parisc64 due to the following code snippet in
>>> arch/parisc/include/asm/checksum.h:
>>>
>>> add		%4, %0, %0\n"
>>> ldd,ma		8(%1), %6\n"
>>> ldd,ma		8(%2), %7\n"
>>> add,dc		%5, %0, %0\n"
>>>
>>> The second add is expecting carry flags from the first add. Normally,
>>> a double word load (ldd) does not modify the carry flags. However,
>>> because saddr and daddr may be misaligned, ldd triggers a misalignment
>>> trap that gets handled in arch/parisc/kernel/unaligned.c. This causes
>>> many additional instructions to be executed between the two adds. This
>>> can be easily solved by adding the carry into %0 before executing the
>>> ldd.
>>>
>>
>> I really think this is a bug either in the trap handler or in the hppa64
>> qemu emulation. Only unaligned ldd instructions affect (actually,
>> unconditionally set) the carry flag. That doesn't happen with unaligned
>> ldw instructions. It would be worthwhile tracking this down since there are
>> lots of unaligned data accesses (8-byte accesses on 4-byte aligned addresses)
>> when running the kernel in 64-bit mode. On the other side, I guess this
>> is a different problem. Not sure though if that should even be mentioned
>> here since that makes it sound as if it would be expected that such
>> accesses impact the carry flag.
> 
> I wasn't confident it was a bug somewhere so that's why I sent this patch.
> 
> However, I have just found the section of the processor manual [1] I was
> looking for (Section Privileged Software-Accessible Registers subsection
> Processor Status Word (PSW)):
> 
> "Processor state is encoded in a 64-bit register called the Processor
> Status Word (PSW). When an interruption occurs, the current value of the
> PSW is saved in the Interruption Processor Status Word (IPSW) and
> usually all defined PSW bits are set to 0.
> 
> "The PSW is set to the contents of the IPSW by the RETURN FROM
> INTERRUPTION instruction. The interruption handler may restore the
> original PSW, modify selected bits, or may change the PSW to an entirely
> new value."
> 
> Stored in the PSW register are the "Carry/borrow bits". This confirms
> that the carry/borrow bits should be restored. The save is supposed to
> automatically happen upon an interrupt and restored by the RETURN FROM
> INTERRUPTION, thus this is a QEMU bug and not a Linux bug (please
> correct me if I am wrong).
> 

I know that much (I looked into the manual as well), I just really don't
know if this is a Linux bug or a QEMU bug, and I have not been able to
nail it down. I think someone with access to hardware will need to confirm.

Specifically: Yes, the carry/borrow bits should be restored. Question is
if the Linux kernel's interrupt handler doesn't restore the carry bits
or if the problem is on the qemu side.

> This v8 was not needed after-all it seems. It would be best to stick
> with the v7.
> 
I tend to agree; after all, v7 exposes the problem, making it easier to
determine if the problem can be reproduced on real hardware.

FWIW,I wrote some test code which exposes the problem. It is quite
easy to show that carry is always set after executing ldd on an unaligned
address. That is also why I know for sure that the problem is not
seen with ldw on unaligned addresses.

Thanks,
Guenter


