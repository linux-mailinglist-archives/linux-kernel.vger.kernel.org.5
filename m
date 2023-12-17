Return-Path: <linux-kernel+bounces-2859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D9D8162E8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2A91F21B30
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFF24A988;
	Sun, 17 Dec 2023 22:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZI6Qwuz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D2D44C95
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 22:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40c32e205fcso4740865e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 14:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702853675; x=1703458475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LPvpS7R4wE5DRxO9i/YwUOLdN8AtChaRRgGgCZAfswA=;
        b=hZI6QwuzCTeqsXH40erDj0I3MrHsZ+MOkkP1pNTJ3zx1dTgZ+hDA6Iys27ZWKHYKZ/
         73xrf+8HYduoOu+PR86M10Ca0MQ0du5oHUHAom4Gnmu5YtmUype6a/hEL2hCDxkMH5Rk
         ryNVj/3YdjJAbOfQbAGBznkBH6BSE9YTvtTlupBaLZ6JjbQBwRWmB5efSk+qLZFoTKUP
         Jf5vKKu016mOMD5pgO4gzU2kFeosvQvpT6BFtyQ4+UWON+b4d26jLkgrq/aUFjXwHGXm
         AkYEK2lv85xuXnhEoQlOukmye0fXe3QtujY9MT/zbdvzrdi24neya4kxmK8MeHtzrmeX
         fWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702853675; x=1703458475;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LPvpS7R4wE5DRxO9i/YwUOLdN8AtChaRRgGgCZAfswA=;
        b=EaTiyITMxFrLoOj1ZBMiO0J7ABFr8jiBa8XvnFp4203wSUroyc0voXCgTYa8AY2gPh
         iMGVOhDZSj7wCN0aXEistmspaQ7PzsTmtjnxInw4QaXe7fOMtPSXXtVr7naG/e8fnc8g
         lHF3JxHAIepIzvQAZoFxeTbYDGGs+43KXx64j6hsu5/aC7vD6t4NbcJK6HABcFJS6xBf
         7hXv3X82FKBHrTDVL51XfcfLSyHGXH6v+lDp7CG7T94Q+dMPfDQ+Ymv1k/U6OyFdkuo4
         AYcmcZ1r0514YbQFHJ/gHTeW1KLbYxmUHs8pjyabogrq0+BZNameR1WF4fSlv+BFggHR
         VU6A==
X-Gm-Message-State: AOJu0Yy2CJYs38ecAKGw8/OeCTGr8UT/XWtnLE584IrAOgEniItfAWXc
	YvgR5M2ACYgtWe6Qikr0bPA=
X-Google-Smtp-Source: AGHT+IEJCSwNB+HrllWWy73g8O07cH+Zn/P3nm9F7Zdktr+2W5C10RdUqxDxWXnGUmwWwKV8EVDHew==
X-Received: by 2002:a05:600c:1d23:b0:40d:123a:50eb with SMTP id l35-20020a05600c1d2300b0040d123a50ebmr2931119wms.3.1702853674720;
        Sun, 17 Dec 2023 14:54:34 -0800 (PST)
Received: from ?IPV6:2a01:4b00:d20e:7300:c482:b9a:a1b4:9bfa? ([2a01:4b00:d20e:7300:c482:b9a:a1b4:9bfa])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b0040c4c9c52a3sm27532512wmo.12.2023.12.17.14.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Dec 2023 14:54:33 -0800 (PST)
Message-ID: <f495519c-c681-4445-aedc-0f44fbd192e8@gmail.com>
Date: Sun, 17 Dec 2023 22:52:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ivan Orlov <ivan.orlov0322@gmail.com>
Subject: Re: [PATCH] riscv: lib: Optimize 'strlen' function
To: David Laight <David.Laight@ACULAB.COM>,
 "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
Cc: "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
 "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
 "samuel@sholland.org" <samuel@sholland.org>,
 "alexghiti@rivosinc.com" <alexghiti@rivosinc.com>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
References: <20231213154530.1970216-1-ivan.orlov0322@gmail.com>
 <86d3947bce1f49c395224998e7d65dc2@AcuMS.aculab.com>
Content-Language: en-US
In-Reply-To: <86d3947bce1f49c395224998e7d65dc2@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/23 17:00, David Laight wrote:
> From: Ivan Orlov
>> Sent: 13 December 2023 15:46
>>
>> The current non-ZBB implementation of 'strlen' function iterates the
>> memory bytewise, looking for a zero byte. It could be optimized to use
>> the wordwise iteration instead, so we will process 4/8 bytes of memory
>> at a time.
> ...
>> 1. If the address is unaligned, iterate SZREG - (address % SZREG) bytes
>> to align it.
> 
> An alternative is to mask the address and 'or' in non-zero bytes
> into the first word - might be faster.
> 
Hi David,

Yeah, it might be an option, I'll test it. Thanks!

> ...
>> Here you can find the benchmarking results for the VisionFive2 board
>> comparing the old and new implementations of the strlen function.
>>
>> Size: 1 (+-0), mean_old: 673, mean_new: 666
>> Size: 2 (+-0), mean_old: 672, mean_new: 676
>> Size: 4 (+-0), mean_old: 685, mean_new: 659
>> Size: 8 (+-0), mean_old: 682, mean_new: 673
>> Size: 16 (+-0), mean_old: 718, mean_new: 694
> ...
> 
> Is that 32bit or 64bit?
> The word-at-a-time strlen() is typically not worth it for 32bit.
> 

I tested it on 64-bit board only as it is the only board I have...

I assume the performance gain would be less noticeable on 32bit, 
probably the word-oriented function could be even slower than the 
byte-oriented one for shorter strings.

However, I'm not sure if any physical 32-bit risc-v boards with Linux 
support actually exist at the moment... So the only way to test the 
solution on the 32-bit system would be QEMU, and probably it wouldn't be 
really representative, right?

But it definitely worth a try and probably I could include a separate 
implementation for 32-bit RISC-V which will simply iterate the bytes in 
case if QEMU 32-bit test will show significant overhead for 
word-oriented function.

> I'd also guess that pretty much all the calls in-kernel are short.

I'm 99% sure they are! However, I believe if word-oriented solution 
doesn't introduce performance overhead for shorter strings but works 
much faster for longer strings, it still worth an implementation! :)

> You might try counting as: histogram[ilog2(strlen_result)]++
> and seeing what it shows for some workload.
> I bet you (a beer if I see you!) that you won't see many over 1k.

Sounds like a funny experiment, and I accept a bet! Beer is more than 
doable as I'm also located in the UK (Manchester).

-- 
Kind regards,
Ivan Orlov


