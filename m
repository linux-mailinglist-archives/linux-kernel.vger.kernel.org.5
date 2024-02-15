Return-Path: <linux-kernel+bounces-66466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3730B855D16
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21EF281887
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4E71C6AF;
	Thu, 15 Feb 2024 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itAkpQ4s"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBA41C683;
	Thu, 15 Feb 2024 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707987378; cv=none; b=cyaNsJI6t7YNzAMYWHOLZ53G0LgxV7AnmfWOZEKHcN2LPpWu6gHNC/WsqsRcPMrj5VyEgx5aQD7ENx6ramHJtW4IHtAohoOG3X4Ze0DLS3v4JYbHViK3cEppNt0xUu9IZnZ/HCoUvEndG7FgpkQxxSn3QpiKY2CTHDjMZbo8xOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707987378; c=relaxed/simple;
	bh=ALyl+bYujG8tsP4ZtTQd7/ial9uO/MFRzgKH335+l8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=orFSCxRby7/ZOFNPQneePeBG9A+Nz4GM/+/UvKstYxPnV6rNHykIyn0vA0se0egpJVt+ltRcr/22cHBNuB7FpIV2KTg7AahmG2mESjgIOuY4CQrWpm8eo+BZYQPGNLFPPdoBXXSXJ0vyjyC9oFkqI2WgYXlZF3kEuADg68ZoQvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itAkpQ4s; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d91397bd22so4455095ad.0;
        Thu, 15 Feb 2024 00:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707987376; x=1708592176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dewtdZMyloFiQnPyoazWlr4DOVfKVCdGKw6OrWcJ5MU=;
        b=itAkpQ4sqx2WEdc2qlk53OcwIhunVvP6dFHzD7bYnCbfOuY8ucYeg85KUGkIYFQZTN
         UdUZL3R1WhBOkU3yG4IbAOebZIVO/r7lJhwTq5Ed5nDQm8Msj4L6vhCE3K/d766T4+TT
         Ii0vsFUeODTem6ZEeB/VcPlUmJ04A1KW1nCOxjIrcWZoDYVbSW9uf3QO38gYke6mgA8e
         nYAj8Mm/kAKvyd0zDrvRqXHnT0MFghYkG1T5IoHj64BKq4r9ANZFLNhMKLCHue95pWtV
         mxWK8eLfps8bLxsdfOGox1IRvaCpOW9BQPrPaZAFgeQPuf3IqRoEkq+Oud5th/tS0g0P
         0jPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707987376; x=1708592176;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dewtdZMyloFiQnPyoazWlr4DOVfKVCdGKw6OrWcJ5MU=;
        b=azjjoCZJFJGU5UiOgUZD5H0AD+wPVrSsfyJlNVDAyHFwTboRjCR1fKXmNzULhS4i9b
         AbkXGbritZFWsZ+PtUzqIiGeiCNB6/jtqpsqjPBx/AM3HqOh1oxptFS7zbHoGQDphY/c
         QMsBnhDrrFXVakfo8QjHelvOVG8DpLNUQEdACFwuKr5j/tXVNw2BaiyQLbUxAAnp2C/j
         FPqGt3bz2tfKskuXGOXza+FP6AFNMW8gPnqxALDP2vq1AiVJvrA2mqV2lZV2ue/yr41J
         r4R+NHTuKQA0t2mfNeObgWKlhOPm9h5qgt34HaulDuFQ+rcbto33ohsJSJEYgUE7Fhhr
         cHhA==
X-Forwarded-Encrypted: i=1; AJvYcCUTGq5UersK08hcYPXXf8XGTWwowfckyitCtIEN0GwU5yj92BuNe4IzMstVRxCvOZmtkQfzQO+9KtZwhIWTJ6ZI2FrKbKR16EOwtVmhBFRZQ4vrb55Cd/oqkkj7kg0IqBhugohZcfxmIfQ1
X-Gm-Message-State: AOJu0Yyva+b4ufyDMAAEtAnFvffwduO7Agn8ZY8AUAD5U8aori6pZyrB
	SEJiUCPz1xgvMjmzKAq3UbZi9dPo4rChyINvEaJqJJQrC5XZFrl9
X-Google-Smtp-Source: AGHT+IGFSL2kVJYOzCu+XqawyXqGFXkv5DfF1zrMocSiWHfo8iIjQ+gqS1j6eVV2c9cpOxjdzuGpsA==
X-Received: by 2002:a17:90a:6c44:b0:298:db59:b6a7 with SMTP id x62-20020a17090a6c4400b00298db59b6a7mr1283667pjj.34.1707987375708;
        Thu, 15 Feb 2024 00:56:15 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id qc14-20020a17090b288e00b0029900404e11sm893067pjb.27.2024.02.15.00.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 00:56:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <11fff7fe-ec4c-4340-a67f-d1d54d0712d8@roeck-us.net>
Date: Thu, 15 Feb 2024 00:56:13 -0800
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
 John David Anglin <dave.anglin@bell.net>
Cc: David Laight <David.Laight@aculab.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Parisc List <linux-parisc@vger.kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20240214-fix_sparse_errors_checksum_tests-v8-0-36b60e673593@rivosinc.com>
 <20240214-fix_sparse_errors_checksum_tests-v8-2-36b60e673593@rivosinc.com>
 <2ec91b11-23c7-4beb-8cef-c68367c8f029@roeck-us.net> <Zc1pSi59aDOnqz++@ghost>
 <cb4e358b-3fd0-4ca4-bf53-9cc379087304@roeck-us.net>
 <1d5e059e-5b31-415d-ae41-593415812e94@bell.net> <Zc2GfgiCpevtKTtS@ghost>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Zc2GfgiCpevtKTtS@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/14/24 19:35, Charlie Jenkins wrote:
> On Wed, Feb 14, 2024 at 10:00:37PM -0500, John David Anglin wrote:
>> On 2024-02-14 8:58 p.m., Guenter Roeck wrote:
>>> Specifically: Yes, the carry/borrow bits should be restored. Question is
>>> if the Linux kernel's interrupt handler doesn't restore the carry bits
>>> or if the problem is on the qemu side.
>> The carry/borrow bits in the PSW should be saved and restored by the save_specials
>> and rest_specials macros.  They are defined in arch/parisc/include/asm/assembly.h.
> 
> Why would they be needed to be restored in linux? The manual says "The
> PSW is set to the contents of the IPSW by the RETURN FROM INTERRUPTION
> instruction". This means that the PSW must be restored by the hardware.
> 
> We can see the QEMU implementation in:
> 
> rfi:
> https://github.com/qemu/qemu/blob/v8.2.1/target/hppa/sys_helper.c#L93
> 
> handling interrupt:
> https://github.com/qemu/qemu/blob/v8.2.1/target/hppa/int_helper.c#L109
> 
> However the implementation appears to be faulty. During an RFI, the PSW
> is always set to 0x804000e (regardless of what the PSW was before the
> interrupt).
> 

Not sure if I agree. The interrupt handler in Linux is the one which needs to set
IPSW. Looking into the code, I agree with Dave that the tophys macro seems to
clobber the carry bits before psw is saved, so they can not really be restored.
The only issue with that idea is that I can only reproduce the problem with
an interrupted ldd instruction but not, for example, with ldw. This is why it
would be really important to have someone with real hardware test this.

Thanks,
Guenter


