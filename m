Return-Path: <linux-kernel+bounces-2863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FDF81634E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 00:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F9B31C20C38
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 23:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5335F4B131;
	Sun, 17 Dec 2023 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddzvoU7I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131A34B12B
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 23:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c495ab68cso4784595e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 15:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702855401; x=1703460201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YNDNxYIAR2omW0Iw58oFmO1xHTduBk19i+Qg8GrwOok=;
        b=ddzvoU7IpBisYmP6pOBrbKYdESO2iyT9usJc9Uv7jnW2S2wiKIl7TV7h5zaLCiSsMJ
         ScIXD7nbR/MCBa6eOXPgXQHy3FY2Nsbku34brd3pkN6qE3vHc0c0gwTbcVB7cCVJZI48
         AyRiAJ6vIabGk7WGTTUhb89RwQ18GGAiigYFdFMdWbFQEKW9fc3mR1DAOA0nOMn66SSU
         4hy1bDwLD0bx9EnBpHu4CHBgziJAC0C3h6OElucorPxOBoiZuzS/VLVzTbHwi3NeTjTw
         8rJ5uP9OurahvtCBvOcA2OU98JNSiXlzaIr/DNxQEjG/yuI4L+dqzxl16ZTbKSj6ZTTQ
         ri5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702855401; x=1703460201;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YNDNxYIAR2omW0Iw58oFmO1xHTduBk19i+Qg8GrwOok=;
        b=YR5oWu6fS0Mn+/fuFgiDugcYDryGW+4PWDbGjFuxf5pgcI2z5CXQ6y3RtS8GzvrLqS
         4FRwgTNAyFQxVfpoYuuGkYyqUZj1oF/CDCsFhWdc1B6IbgkIW/P7m+Suu7aK62uDL3it
         0XhYGzYi4hhJ+HLkORsImXwUyvVbLOmRNFRYRAURQ9bPOs0kqqGl6I/i/rvMV96aCx8w
         5DRwdGuh+W8fWQdfVY92KoS15d3Wx05if/FId/LLe/F7K0LBtPAUwOFI1mRl2nb+nbWl
         QrkrsQrxZu1Qu6FrixqwDHikuTlM/i2jYxQgx+DnPNdwBd0b2+X8WMek123zA526Vvqs
         xhjg==
X-Gm-Message-State: AOJu0YwyNHoz8M49tgdpS7s8QBWou4EvBoZUQMlRXzcrKA7yQATVnIDF
	+aDJSXB1jVaudM/UC/8P2uY=
X-Google-Smtp-Source: AGHT+IHyOMxeW366N8PbMvyg6sMfhnuAlxg/FsrFIarplTZzdIwS7kgg8aZ4vkJBD7Ydh9FG5wTROQ==
X-Received: by 2002:a05:600c:3b23:b0:40c:2631:7c3d with SMTP id m35-20020a05600c3b2300b0040c26317c3dmr18479856wms.2.1702855400878;
        Sun, 17 Dec 2023 15:23:20 -0800 (PST)
Received: from ?IPV6:2a01:4b00:d20e:7300:c482:b9a:a1b4:9bfa? ([2a01:4b00:d20e:7300:c482:b9a:a1b4:9bfa])
        by smtp.gmail.com with ESMTPSA id j17-20020a05600c1c1100b0040b48690c49sm39724440wms.6.2023.12.17.15.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Dec 2023 15:23:20 -0800 (PST)
Message-ID: <45351e30-d197-4b9c-864f-8ff5f9b6ab61@gmail.com>
Date: Sun, 17 Dec 2023 23:23:19 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: lib: Optimize 'strlen' function
Content-Language: en-US
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
 <a210197c479e48778672aa13287eef88@AcuMS.aculab.com>
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <a210197c479e48778672aa13287eef88@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/23 18:10, David Laight wrote:
> From: Ivan Orlov
>> Sent: 13 December 2023 15:46
> 
> Looking at the old code...
> 
>>   1:
>> -	lbu	t0, 0(t1)
>> -	beqz	t0, 2f
>> -	addi	t1, t1, 1
>> -	j	1b
> 
> I suspect there is (at least) a two clock stall between
> the 'ldu' and 'beqz'.

Hmm, the stall exists due to memory access? Why does two subsequent 
accesses to the memory (as in the example you provided) do the trick? Is 
it because two "ldb"s could be parallelized?

> Allowing for one clock for the 'predicted taken' branch
> that is 7 clocks/byte.
> 
> Try this one - especially on 32bit:
> 
> 	mov	t0, a0
> 	and	t1, t0, 1
> 	sub	t0, t0, t1
> 	bnez	t1, 2f
> 1:
> 	ldb	t1, 0(t0)
> 2:	ldb	t2, 1(t0)
> 	add	t0, t0, 2
> 	beqz	t1, 3f
> 	bnez	t2, 1b
> 	add	t0, t0, 1
> 3:	sub	t0, t0, 2
> 	sub	a0, t0, a0
> 	ret
>
I tested it on my 64bit board, and this variant is definitely faster 
than the original implementation! Here is the results of the benchmark 
which compares this variant with the word-oriented one:

Test count per size: 1000

Size: 1 (+-0), mean_old: 711, mean_new: 708
Size: 2 (+-0), mean_old: 649, mean_new: 713
Size: 4 (+-0), mean_old: 499, mean_new: 506
Size: 8 (+-0), mean_old: 344, mean_new: 350
Size: 16 (+-0), mean_old: 342, mean_new: 362
Size: 32 (+-0), mean_old: 369, mean_new: 387
Size: 64 (+-0), mean_old: 393, mean_new: 401
Size: 128 (+-4), mean_old: 457, mean_new: 424
Size: 256 (+-13), mean_old: 578, mean_new: 476
Size: 512 (+-31), mean_old: 842, mean_new: 573
Size: 1024 (+-19), mean_old: 1305, mean_new: 777
Size: 2048 (+-97), mean_old: 2280, mean_new: 1193
Size: 4096 (+-149), mean_old: 4226, mean_new: 2002
Size: 8192 (+-439), mean_old: 8131, mean_new: 3634
Size: 16384 (+-615), mean_old: 16353, mean_new: 6905
Size: 32768 (+-2566), mean_old: 37075, mean_new: 14232
Size: 65536 (+-6047), mean_old: 73797, mean_new: 37090
Size: 131072 (+-10071), mean_old: 146802, mean_new: 73402
Size: 262144 (+-18150), mean_old: 293003, mean_new: 146118
Size: 524288 (+-21247), mean_old: 585057, mean_new: 291324

Benchmark code:

https://github.com/ivanorlov2206/strlen-benchmark/blob/main/strlentest.c

It looks like the variant you suggested could be faster for shorter 
strings even on the 64bit platform.

Maybe we could enhance it even more by loading 4 consequent bytes into 
different registers so the memory loads would still be parallelized?

-- 
Kind regards,
Ivan Orlov


