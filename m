Return-Path: <linux-kernel+bounces-62874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D97A852723
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1DAE1F25FDF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FDCD26B;
	Tue, 13 Feb 2024 01:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/2eJoNZ"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57787C13C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 01:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707789186; cv=none; b=kJxD/69XuUjNZSKhfV6LJXEGdsP3x+qKXD3XbhLJCuSJAPJuA+POYpfqJf1hYp6RflYzwAby8EcEWZ6H1XwC/i4MR68VbG2cqtHpiUcut9m/zd5YsQJ0/v5dEtRL2287CThP4xviqR5VPGJlMkAaqu7O1WREA9FSmc9n+69GlHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707789186; c=relaxed/simple;
	bh=BWGZqnQPN3L4vUHdJB7kmy8KJq559VQbJjGiXGMrrdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YYPhDNE4oA1nK5Lf09ZrTjlgSbFWHHquHZRGuzCMAUzBv5A/b3GQh+mrPebGFV5KOyEM1FwvVgNIrBZsG7e17KeCaaD259nFrE90cDGYtUEiE3M3any/7ipF1iM/DZ+aHh8CEdoeewBFjaPjiTzUBG3Gej0RY8QmeUSWyQ69OCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/2eJoNZ; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bff4553fa7so226086b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707789183; x=1708393983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=B9HSYjkXvwOWeT5GkjE75izl7NYNlz8O++ApzyIDNBc=;
        b=Y/2eJoNZSrj/c3RgkRKLKgRpTqONtpg82g7JQlqpM1oa4jUc2vtYg0LprA9p/dJ6gE
         oJo3WNv4YLKGNb40CFAsq3/n0FKURREjOnymqRPWVhaGdR/a6RNn4BgQTmnEoCPSkRGT
         KQoxUbMxwIOzJ3GYJeLOwP8Wcf8wCW/taeMiUQZQd3V1YdEPKZa18qMHJVLChK0j2poB
         AZWL+e/sWZlzbc3mSaa5no0Pv8pFkSeDbtb03nb6edNW7zTZ/LJh0yVxgE7kYmxUvQb1
         ewCeb7qUMeVibz9VllvFfRGiHAe9lMg8YALwutH7GW5KpcGxt6tzls88Q+9ub5PwBAc0
         tfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707789183; x=1708393983;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B9HSYjkXvwOWeT5GkjE75izl7NYNlz8O++ApzyIDNBc=;
        b=tdfi96fMAvwn6rt4oMwr0pPK6WEhIDUHMiU/U99VEMYXoAuSv5i0uScr9s7H7KnoII
         JnAiJ05azt1ypNhyZWu2/pMQVdUjj1C+WG8ho4w41DBjXBvjw9kle9VbNuNsEdbne9Ve
         SAslzTJEUuEGiFUXuKXUiNuCm2hUQo5GQ2UZXyVK5NKRLek4SIp7+TaoV+5Y4pmsMNGb
         d9PIiVvGHsNvXXViVa74cfJeNeqcMHnkuGgAhVMitJQkJx2zR5gmpQf1pRPI8sPhlfDp
         YS1zX3Nw5DaPbBJNi5Kg+sM5AQXFyJsHp/QPJ+/q2dHAk5KB4t0ZO4njrii4/zaUsQfd
         EV/w==
X-Forwarded-Encrypted: i=1; AJvYcCWUsA4lc+vpElkr9tfPzmg3uieHl8JSNWo/wf9R6TENU7ehOpelFviZTXyhF+FsOf7Bo3wRexIoQ2zLE9GRV0jMdLYOnZTGmc9RAFpS
X-Gm-Message-State: AOJu0Yx3Jl96n9ee0dnIHWOxFQFk83pW4cIKceobJYtNKpRm2+m1geIs
	au12O0myjz9WTDEyVqQUYcw/3yFg3EE+s12sQA78HfZeEgkidvikyK6NKLLA
X-Google-Smtp-Source: AGHT+IHdCT+WCaQev4xYxm10ZNpcZHoU6YWvB/d90snh7mAjUaKHk3XQ0ikb5HpF8JBWfDx9zQvEVw==
X-Received: by 2002:a05:6808:201f:b0:3c0:34de:423a with SMTP id q31-20020a056808201f00b003c034de423amr6464269oiw.11.1707789183382;
        Mon, 12 Feb 2024 17:53:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUdmv4VD0m00dmk8K+T0O9eighPsUwiqp+MfpDYg4TOtrpyjbb6dzIKcTHgxCL2TuqFLmQ8M02txwNsp5ymY9KbhjofCo2nG7lSfmGvG5Kz0nrOlViYd/wMjvelok3STO3UlkzpBpcXdFOnerYVvNpKCmH0Ul6zicrOg3vGVtzzspUdz8cRNuaWEN8v2N5qydHS3LSX
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o13-20020a62cd0d000000b006e04e9c1d50sm6480588pfg.31.2024.02.12.17.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 17:53:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <04432c4a-b85a-4078-b08c-a19a077c5174@roeck-us.net>
Date: Mon, 12 Feb 2024 17:53:01 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] lib: checksum: Use aligned accesses for
 ip_fast_csum and csum_ipv6_magic tests
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: David Laight <David.Laight@aculab.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Al Viro
 <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20240212-fix_sparse_errors_checksum_tests-v7-0-bbd3b8f64746@rivosinc.com>
 <20240212-fix_sparse_errors_checksum_tests-v7-2-bbd3b8f64746@rivosinc.com>
 <dc352315-0b7b-407a-8704-e424934a922d@roeck-us.net> <Zcq4jj3vsVtqQIHr@ghost>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Zcq4jj3vsVtqQIHr@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/12/24 16:32, Charlie Jenkins wrote:
> On Mon, Feb 12, 2024 at 04:14:49PM -0800, Guenter Roeck wrote:
>> On 2/12/24 12:33, Charlie Jenkins wrote:
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
>>> Fixes: 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and ip_fast_csum")
>>> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>>
>> This thing really wants to annoy me. Now I get:
>>
>>       # test_csum_ipv6_magic: ASSERTION FAILED at lib/checksum_kunit.c:494
>>       Expected ( u64)csum_result == ( u64)expected, but
>>           ( u64)csum_result == 46543 (0xb5cf)
>>           ( u64)expected == 46544 (0xb5d0)
>>       not ok 5 test_csum_ipv6_magic
>>
>> with the parisc64 tests. All other architectures / platforms work fine
>> after applying the various pending fixes. It looks like a carry gets
>> lost somewhere, but I have not been able to figure out where exactly
>> that happens. This only happens with the 64-bit hppa assembler code.
>>
>> Guenter
>>
> 
> How do you test parisc64? It's not in buildroot which I have been using
> to test the other architectures.
> 

Its qemu support is quite new. 32 bit userspace should work.

The errors are quite interesting.

[   16.989782] ###### i=1 len=0xd22c123d proto=0xb1 csum=0x88e31421 expected=0xb5d0 -> csum 0xb5cf
[   16.990249] ###### i=3 len=0xb15e4531 proto=0xba csum=0xa2853676 expected=0xe6c1 -> csum 0xe6c0
[   16.992119] ###### i=5 len=0xbad8adbb proto=0xce csum=0x9e498ff7 expected=0xa836 -> csum 0xa835
[   16.992498] ###### i=7 len=0xceeaefca proto=0x5c csum=0x2c29f715 expected=0xe87c -> csum 0xe87b
[   16.992769] ###### i=9 len=0x5c1d4d09 proto=0x8c csum=0x1fe21431 expected=0x5875 -> csum 0x5874
[   16.993026] ###### i=11 len=0x8c075723 proto=0x93 csum=0x1f6f03e1 expected=0xd361 -> csum 0xd360
[   16.993282] ###### i=13 len=0x93195303 proto=0x8e csum=0x45499a3b expected=0xdd50 -> csum 0xdd4f
[   16.993538] ###### i=15 len=0x8e0c125d proto=0x9a csum=0x8ab89b8c expected=0xad6b -> csum 0xad6a
[   16.993790] ###### i=17 len=0x9a03e5a2 proto=0x7e csum=0x43d23b4e expected=0x90b5 -> csum 0x90b4

Every odd index fails, and the returned value is one less than the expected value. It is almost
as if something goes wrong with 64-bit loads from 32-bit aligned addresses. I'll do some more
debugging.

Guenter


