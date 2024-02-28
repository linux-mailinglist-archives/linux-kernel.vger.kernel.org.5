Return-Path: <linux-kernel+bounces-84528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C2886A7E3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 06:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E951C224C0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5505820DEB;
	Wed, 28 Feb 2024 05:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMPzR1GT"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F1520B17;
	Wed, 28 Feb 2024 05:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709097548; cv=none; b=TClLF4Nk01WjfOIjqhh4s6dfSUhrVw5MF8jKSjbJzKD0cXnKRd0wHKUsSKFftEOUJCDK+JD7/7XK+K98LME5bHax7yZ51iga9gNHoeBH7DazycA52S2JlV0afLeaCo66O+lIzc9svRIO8sO/gfvYvnduP29WArod90kpXhllEsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709097548; c=relaxed/simple;
	bh=jlab61Hljw3PJNoX481KLKGWYANsj1bij7Z2bH+N6qM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ik8GG9Vm2TYjhpoXthq+BcyXnn/cqjk64SD8N/3oL3nlc2H8syHHGgLwc/CxoRCAXd9O/TNRp6WSDulluZtuGozksWB0C4i0UwwEIQyBiAjqnj7YaWAODr5Kp6bgdv+R8DieexcmTnUcnckewxSbDSBglkdN29SwsXlC5adQZ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMPzR1GT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dca3951ad9so27412445ad.3;
        Tue, 27 Feb 2024 21:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709097546; x=1709702346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pLoM1AUr3lyNWmih/Ag/5+yLPsbix/UiSuab5g418b8=;
        b=MMPzR1GT+f+dhLvRP8NkAmBZ3JfpuqWcHEfWKZtrmLXc3TXiwxBULMpDGGovZfjUSs
         DeN/h5JEDxvM3tiNKJSrfuzL1g+nEN2QxHk99H6vURDny64L07J/FqzV8YSke2SHxQ0R
         pvY2Rm+OIqzoHBpKp7O5ba3g+kDbCSE7iIWawwZJfK8bB17bHHnIzEWEOVmZuEy3Aymk
         sj2Wq1bGNFSwacA17NubrfEGebDQZ66gpq2Ph3GxZulY3sabkkL+Zk9SUmEWkrDR3Qfm
         gqEeFN9ozjrnwcJeigPE/42/6i91aUkMReD16MEfg+gHaJFxRjaP5Nz4kaYFqw5GQE+X
         tvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709097546; x=1709702346;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLoM1AUr3lyNWmih/Ag/5+yLPsbix/UiSuab5g418b8=;
        b=TUarTl8fXhqsCnf7i+FRWzrVkUg3OkxnqqvuUnysN8N8vFxVLtjSyBMHkRyHDAHqJq
         1Pnr6SKEYMOarg6CsNXTmEGewQZ/g2d1QZ8ZvUzsBEfCuc4JG1NSwD7auuZZfIFed/Nx
         394xbICb975I5qv5SCXKpulB3yKFtjYxAIcaNjpxCD+tpEoPgFd09YMmrb7eLxyF+8oO
         9IZ/t0fGFcleurawe32O3V43GpsD5RUq4pXEG0XWAyCwXaXLYRxUgRjeC2B+XVKTpu1g
         6b2tEWT7oaXll1sHm0EncOp/NuYc4guu1nntGlpMrQwLlBPj4n6Npx7segsYp4/zWpoY
         iRHw==
X-Forwarded-Encrypted: i=1; AJvYcCU/VBdklASRk0Gp/Af665abInsxbWpeS45QO4gebzNrAJokA2XrRPETJmOPMySgy44O8QoQjKxUYSOwJcxZkk38mklsGYyRh7Gs7RXvsmepfynT8O85Jyhdfzf3afVbyMygYAl0l30/x5+1
X-Gm-Message-State: AOJu0YxRZbtiWsqlzm++cY25r+JYVgddzpd93Fenz9zuTb2XEg5C7s+2
	ruicjsJdnlNDChHM2MeTUH9nEtvkRynaRIuIT3EA1fpi+uzI8ORJ
X-Google-Smtp-Source: AGHT+IHMR++w99lUPALLB7NMfIkurJJ7tVcVKMruUMlztWE6NmzD6txDSC6Fax8YqLFQzLHeFI8j0Q==
X-Received: by 2002:a17:903:24c:b0:1da:190c:3481 with SMTP id j12-20020a170903024c00b001da190c3481mr15561494plh.34.1709097545965;
        Tue, 27 Feb 2024 21:19:05 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902bc4700b001db5b39635dsm2389759plz.277.2024.02.27.21.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 21:19:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3e328271-26ee-45da-bb9f-b5414ea4f716@roeck-us.net>
Date: Tue, 27 Feb 2024 21:19:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>,
 Charlie Jenkins <charlie@rivosinc.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Parisc List <linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <e11fea7a-e99e-4539-a489-0aa145ee65f0@roeck-us.net>
 <ZdzPgSCTntY7JD5i@shell.armlinux.org.uk> <ZdzZ5tk459bgUrgz@ghost>
 <ZdzhRntTHApp0doV@shell.armlinux.org.uk>
 <b13b8847977d4cfa99b6a0c9a0fcbbcf@AcuMS.aculab.com> <Zd0b8SDT8hrG/0yW@ghost>
 <cdd09f7a-83b2-41ba-a32c-9886dd79c43e@roeck-us.net>
 <9b4ce664-3ddb-4789-9d5d-8824f9089c48@csgroup.eu>
 <Zd25XWTkDPuIjpF8@shell.armlinux.org.uk>
 <c8ddcc98-acb0-4d2d-828a-8dd12e771b5f@csgroup.eu> <Zd4h6ZhvLSWfWJG/@ghost>
 <4d5ce145-22be-4683-b3a9-4de77da87b76@roeck-us.net>
 <c972a30691594072b866ab56017c300c@AcuMS.aculab.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <c972a30691594072b866ab56017c300c@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 14:44, David Laight wrote:
> ..
>> This is the "known" list of failures. I don't currently run kunit tests
>> on nios2 or riscv32, for example, nor on any architectures with no qemu
>> support.
> 
> nios2 is definitely going to 'crash and burn' if you do a misaligned access.
> 

Curiously enough, it doesn't. I get lots of

kernel unaligned access @ 0xc848eb78; BADADDR 0xc86f1d01; cause=6, isn=0x20800017

but a checksum test with unaligned data does pass, so the kernel
somehow handles it. It does crash, later, though, if CONFIG_NET_TEST
is enabled. Apparently the gso tests trigger lots of unaligned
accesses, and those are just too much for the kernel to handle.

Guenter

> Although Intel (aka the Altera bit) are claiming current version
> of their Quartus fpga build software is the last one the will
> support the nios2.
> They are expecting everyone to move to a risc-v soft cpu instead.
> We aren't happy about that, I doubt some of the big telco's are
> either - I believe some mobile base stations have fpga with a
> lot of nios2 in them - almost certainly running with a few kB
> of code and data memory and running small control tasks.
> If you want to run Linux, find an fpga with an ARM core.
> 
> There are some solutions - like writing a compatible soft cpu.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)


