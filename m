Return-Path: <linux-kernel+bounces-3288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2EB816A6A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A66DCB222DA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5645A12B8E;
	Mon, 18 Dec 2023 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+YSEPrd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286A712B72
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c2655da63so7510245e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 02:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702893803; x=1703498603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sAJ4t+ZlF+9GvsUCLeFJqAzncniYoth3/FkzEne5oZw=;
        b=M+YSEPrdMFYw++kJ1r3jH2z5B98iyGd6uGsUjD8bmaFLnOw96o7KGHIRGOqQgwDUff
         Ef7pz44KJhDtUezYVL4kiJEK7nnAdCFi6vNliKILhdf3UYFOokRiM6r1RtRuL7ChGh9D
         5zjsKXpr4l8t9hktjqYjg7gJqMKuFQs05NFG7JLelZlcUQuiRaLeqMo2VA1Z7g4AHErY
         f6bpenfUNYWLWMxMmoiIzjSL3TNbcPwJYctDd3TvdCFkCLg/QcfEfp6Sebwwtq9FGTE5
         +vvm7Rz6aBhPiN3D1ABSIdDLRIyTMKrgujmVcpA2uyejC4Op23pp0YlR1Ssnk4p5V7Ia
         c0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702893803; x=1703498603;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sAJ4t+ZlF+9GvsUCLeFJqAzncniYoth3/FkzEne5oZw=;
        b=EJphkO1jeM8pIht84m5M+j+/YJ6Di2VuNvKNnu65FF+smRbuz6HsNU+C+mHyl/qsfb
         IQftC+bIi28iYag8iEdhKPWCI8RWZd+/FB3CbrqxXZGYvPcwM6rS4MxaDjFyMhFWL1f6
         i9QRsG8Q4U5FXVyMy92sG0Kzwt2Wzs28bQerj0+AcfShr5jCOUbJ+gP1bTR+gKPGDpWp
         cRTe5DDnOVeBP09e4ALQwOeh6denyqjvcIkiMtONZItopUcU2UMqmKFN5MeUfqc57gsb
         Fz59mZlnQiNZPFcUarW3i0PbFSQh+pYCaRMO14ZDWOxV3HM+NOibjgGvs+ADLLJC6MoU
         z6+Q==
X-Gm-Message-State: AOJu0Yw/3mPEE5DyA86wGpEd/9H+jbzsAS6xzZlyS2U9hoRddIkQ16Ag
	mq84tZtzOOOPp24kJBYE/R4=
X-Google-Smtp-Source: AGHT+IFs8F4MaXExSYtt4MkPmPlq58aSE/hyCEVFB6HJE1s5fFzh90VRsJObpMFYCYdJuuH093Flvw==
X-Received: by 2002:a05:600c:1c9d:b0:408:3836:525f with SMTP id k29-20020a05600c1c9d00b004083836525fmr19264207wms.1.1702893802949;
        Mon, 18 Dec 2023 02:03:22 -0800 (PST)
Received: from ?IPV6:2a01:4b00:d20e:7300:aa3f:acb9:5744:ea8f? ([2a01:4b00:d20e:7300:aa3f:acb9:5744:ea8f])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b0040b3515cdf8sm41329359wms.7.2023.12.18.02.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 02:03:22 -0800 (PST)
Message-ID: <f12ef9ea-14fe-491a-890b-a645bb4827cb@gmail.com>
Date: Mon, 18 Dec 2023 10:03:21 +0000
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
 <86d3947bce1f49c395224998e7d65dc2@AcuMS.aculab.com>
 <de80b4c7-1ffb-478e-9117-9d5b829470bd@gmail.com>
 <bd9159806a2e4fd188a78515b58ec51e@AcuMS.aculab.com>
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <bd9159806a2e4fd188a78515b58ec51e@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/23 09:20, David Laight wrote:
> From: Ivan Orlov
>> Sent: 18 December 2023 01:42
>>
>> On 12/17/23 17:00, David Laight wrote:
>>> I'd also guess that pretty much all the calls in-kernel are short.
>>> You might try counting as: histogram[ilog2(strlen_result)]++
>>> and seeing what it shows for some workload.
>>> I bet you (a beer if I see you!) that you won't see many over 1k.
>>
>> Hi David,
>>
>> Here is the statistics for strlen result:
>>
>> [  223.169575] Calls count for 2^0: 6150
>> [  223.173293] Calls count for 2^1: 184852
>> [  223.177142] Calls count for 2^2: 313896
>> [  223.180990] Calls count for 2^3: 185844
>> [  223.184881] Calls count for 2^4: 87868
>> [  223.188660] Calls count for 2^5: 9916
>> [  223.192368] Calls count for 2^6: 1865
>> [  223.196062] Calls count for 2^7: 0
>> [  223.199483] Calls count for 2^8: 0
>> [  223.202952] Calls count for 2^9: 0
>> ...
>>
>> Looks like I've just lost a beer :)
>>
>> Considering this statistics, I'd say implementing the word-oriented
>> strlen is an overcomplication - we wouldn't get any performance gain and
>> it just doesn't worth it.
> 
> And the 32bit version is about half the speed of the 64bit one.
> 
> Of course, the fast way to do strlen is add a custom instruction!
> 
>> I simplified your code a little bit, it looks like the alignment there
>> is unnecessary: QEMU test shows the same performance independently from
>> alignment. Tests on the board gave the same result (perhaps because the
>> CPU on the board has 2 DDR channels?)
> 
> The alignment is there because it can overread the string end
> by one byte - and that mustn't cross a page boundary.
> So you either have to mark the second load as 'may fault return
> zero' or just not do it.
> 
> If the data isn't in cache the cache load will dominate.
> The DDR channels only affect cache load times.
> Get a TLB miss and add a few thousand more clocks!
> 

Ah, right, sounds reasonable...

Overall, I believe your solution is better and it would be more fair if 
you send it as a patch :) Here is benchmark results for your version vs 
the original (the old) one on the Starfive VisionFive2 RISC-V board:

Size: 1 (+-0), mean_old: 350, mean_new: 340
Size: 2 (+-0), mean_old: 337, mean_new: 347
Size: 4 (+-0), mean_old: 322, mean_new: 355
Size: 8 (+-0), mean_old: 345, mean_new: 335
Size: 16 (+-0), mean_old: 352, mean_new: 367
Size: 32 (+-0), mean_old: 425, mean_new: 362
Size: 64 (+-4), mean_old: 507, mean_new: 407
Size: 128 (+-10), mean_old: 730, mean_new: 442
Size: 256 (+-19), mean_old: 1142, mean_new: 592
Size: 512 (+-6), mean_old: 1945, mean_new: 812
Size: 1024 (+-21), mean_old: 3565, mean_new: 1312
Size: 2048 (+-108), mean_old: 6812, mean_new: 2280
Size: 4096 (+-362), mean_old: 13302, mean_new: 4242
Size: 8192 (+-385), mean_old: 26393, mean_new: 8160
Size: 16384 (+-1115), mean_old: 52689, mean_new: 15953
Size: 32768 (+-2515), mean_old: 107293, mean_new: 32391
Size: 65536 (+-6041), mean_old: 213789, mean_new: 74354
Size: 131072 (+-12352), mean_old: 426619, mean_new: 146972
Size: 262144 (+-2635), mean_old: 848115, mean_new: 291309
Size: 524288 (+-3336), mean_old: 1712847, mean_new: 589654



>>
>> --
>> Kind regards,
>> Ivan Orlov
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

-- 
Kind regards,
Ivan Orlov


