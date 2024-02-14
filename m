Return-Path: <linux-kernel+bounces-66097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D61498556D6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423331F223B6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F301B13DBA7;
	Wed, 14 Feb 2024 23:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHvL7Eje"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B09B128388;
	Wed, 14 Feb 2024 23:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951792; cv=none; b=lG/edtT2Y+8QmeypVZBZ7SJvqN4fUcvmT+cqpNq1w2r1xju/DVVIPpKAtkhjDrB6VJKjMdj1HpQ3Ctt6r+kxG6mhrQkyKjFgC8UjdWeY0N452Xrs+pm8ufn2zrbyDQMAv5ufaXOz5Uq+oEKOpjCasN+gf/XnFaD6N28Kq6EK+/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951792; c=relaxed/simple;
	bh=ykirw4cmA2+9ydHbNedf3+zryWiqyI2UNN0bE/4GBw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ihr/24bsmw19gxnpm570nDMbBLntSqW0Q4/L8UF8XHpQ0mce4o7ijZeREJjzln/uQZLkTShRNyku3zFu6GLllU92fS3fd2oVJ2lh+SvaVLwQnRL5KnOgm4JKnGKuktSMtpduJrjL4mu9dI7FjzdlHe7M1toF4uTtYIGhtVsthzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHvL7Eje; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso267059a12.0;
        Wed, 14 Feb 2024 15:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707951790; x=1708556590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IULViN1YE3jnUbW2nwCagZ5usHptjYJ+ObRYjMrSkZQ=;
        b=gHvL7EjeOt+ADDdTMRlLJg8PDKz9ygoScwZtAyB3PtAX/HVDOTmFTDv6jKit3cVgcR
         VIZmOgkd0UrBRom6mPdT0tBVMgrNQYqaeUlYhqCe8kwkOXs5Dki/if4yodMUyZAsJfMQ
         9kBo+TNK9ilKuS/PX39cUueaQtKUBTLqQHRJ7DkfKiE8asgSB4ANCDK7BmM0PwImcQ70
         KyFXqDq2yQXyg+eHbIPdwNO/2UUkCaXqM/QOATjE61VexNC0u3KKVvszbMq6xs5GeXuN
         estpOy4nI6fNcqj/8Q5pNpD51KKKl/fN+9UpJe/k44+BxM7X8cIrwYz1ADdDUU7qK46p
         xOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707951790; x=1708556590;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IULViN1YE3jnUbW2nwCagZ5usHptjYJ+ObRYjMrSkZQ=;
        b=rw22FGa7VenTVvdcXArifCfvm08TjK+dxOC1j6IVvXzedVCzkgMNZQb2V8EqKfPCYI
         H+tErTEkkgiQdp40BB9V+0xkHsEZwYKNLpNVBwhhBfgdJ7oH3IfnhzfEWB9LIFiYoRUP
         LYW+h8pXRWq9f7kR6jsSzETrAsCOI1Fd9z+dil7QZ4Ft6YY3b+3AyVrtMkJke96ItpcO
         99+SfRutzFnYRiungZOYGhrFT85C7/XLbG95AHROli+nGkaNH7PJX8m/pkfrBRPs9xJF
         SpaCSAeACiyCcwMV+YlOMu2SCYOk1YjErLzDS96YLXg9FToX6YhUCaEqLcYzwDaxv/2V
         e/Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVreuo1CZqrPJi7JaF9i+2dKCUR5IXFVw9QrZ+SQM5k1OnEjDhl6iQkOFfAQzGQbDe+X39FdIRhTBsLvR/Z0DxxT4IO24M/60P3JLhf
X-Gm-Message-State: AOJu0YykbjJGjS1RbE1em5G3gOeEoqH/C6QnY68A5QzDlB5B6ojIyhvN
	Une/Q0C/mQegMkx94BbLT0xSuFMgimZiCzhSdRup5KkF/81RxUsf
X-Google-Smtp-Source: AGHT+IF7nzEB/BdTWQHw2nfTZqmx63PWm2Z6al/3WdycoTCSjl2mX04/TarUQVCor2lhd5FyW+4VRw==
X-Received: by 2002:a05:6a20:d38f:b0:1a0:6856:d1a9 with SMTP id iq15-20020a056a20d38f00b001a06856d1a9mr369641pzb.10.1707951789540;
        Wed, 14 Feb 2024 15:03:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUtFgpjvamH4s9HGKND8D1df2bUnh8D3uLtTDbl4NTB2QmoGQDv4jXjFAKFDUGI86nFBstfodeOVZsMO5ssIsnXDy1TRBUxGfXYNlL0a52DMYF45x0J701+nBtT5EvjCOILDfGLaqEz9zmYS2DgzY/9PCkb7BFPHAQB+iG7Yjq86oFIStFSziFLF9YfzQb/z6wAkgo71Q9SLzdWRkzzgtlgXitgvv2RACgIL7zRgKVXbysJLfQZ6VEvegu4KzrFdgFYyru3Tjxh1lH56sNKX3M2xE9Xk3/cwCMSheYI3q3vMdoVpw==
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fd23-20020a056a002e9700b006e03cce3f4asm9914588pfb.25.2024.02.14.15.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 15:03:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2ec91b11-23c7-4beb-8cef-c68367c8f029@roeck-us.net>
Date: Wed, 14 Feb 2024 15:03:07 -0800
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
To: Charlie Jenkins <charlie@rivosinc.com>,
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Parisc List <linux-parisc@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
References: <20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com>
 <20240214-fix_sparse_errors_checksum_tests-v8-2-36b60e673593@rivosinc.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240214-fix_sparse_errors_checksum_tests-v8-2-36b60e673593@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/24 13:41, Charlie Jenkins wrote:
> The test cases for ip_fast_csum and csum_ipv6_magic were failing on a
> variety of architectures that are big endian or do not support
> misalgined accesses. Both of these test cases are changed to support big
> and little endian architectures.
> 
> The test for ip_fast_csum is changed to align the data along (14 +
> NET_IP_ALIGN) bytes which is the alignment of an IP header. The test for
> csum_ipv6_magic aligns the data using a struct. An extra padding field
> is added to the struct to ensure that the size of the struct is the same
> on all architectures (44 bytes).
> 
> The test for csum_ipv6_magic somewhat arbitrarily aligned saddr and
> daddr. This would fail on parisc64 due to the following code snippet in
> arch/parisc/include/asm/checksum.h:
> 
> add		%4, %0, %0\n"
> ldd,ma		8(%1), %6\n"
> ldd,ma		8(%2), %7\n"
> add,dc		%5, %0, %0\n"
> 
> The second add is expecting carry flags from the first add. Normally,
> a double word load (ldd) does not modify the carry flags. However,
> because saddr and daddr may be misaligned, ldd triggers a misalignment
> trap that gets handled in arch/parisc/kernel/unaligned.c. This causes
> many additional instructions to be executed between the two adds. This
> can be easily solved by adding the carry into %0 before executing the
> ldd.
> 

I really think this is a bug either in the trap handler or in the hppa64
qemu emulation. Only unaligned ldd instructions affect (actually,
unconditionally set) the carry flag. That doesn't happen with unaligned
ldw instructions. It would be worthwhile tracking this down since there are
lots of unaligned data accesses (8-byte accesses on 4-byte aligned addresses)
when running the kernel in 64-bit mode. On the other side, I guess this
is a different problem. Not sure though if that should even be mentioned
here since that makes it sound as if it would be expected that such
accesses impact the carry flag.

> However, that is not necessary since ipv6 headers should always be
> aligned on a 16-byte boundary on parisc since NET_IP_ALIGN is set to 2
> and the ethernet header size is 14.
> 
> Architectures that set NET_IP_ALIGN to 0 must support misaligned saddr
> and daddr, but that is not tested here.
> 
> Fixes: 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and ip_fast_csum")
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

I'll run this through my test system and let you know how it goes.
It should be done in a couple of hours.

Thanks,
Guenter


