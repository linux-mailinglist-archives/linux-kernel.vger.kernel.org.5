Return-Path: <linux-kernel+bounces-105602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDDB87E140
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D8462825FA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 00:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EEBFC19;
	Mon, 18 Mar 2024 00:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qezxlb9f"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B609AD23;
	Mon, 18 Mar 2024 00:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710722028; cv=none; b=t4fRPKE5LSGTe9nZkNv/itT69lpcWX15pVlfa7ofNpRCHzfgX4/0C0p2swj+MGGywov3PvE+ENuXCgRuP5TNieg3mFf7dgiXUIDsmwFZScaoYXV/mdd4NyQj1DIdryae+8GqxmPiKm8XKrbXgRP3FiPaPJz4vyLO/+Qz0MDgoJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710722028; c=relaxed/simple;
	bh=psz1eCidTIDSQgxOYHEcO2MpAtuGi8B5che1X86lyto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7tzF+J1hkI/f86+Ts4SB+kzh9btl/7C0tSWc3ge+70bpaBcwlIBHeuNE+L1xAj0fwKs3VPEmCW5gOD8V9cmj30CCemKSliJye0sc9BOUPVf9h1+Q0vMlAwkAbzQNUpY263Ad+0kxFtpLo9vywK9X4CNoxH91OpJVkWeAgFsI0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qezxlb9f; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dd10ae77d8so22835425ad.0;
        Sun, 17 Mar 2024 17:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710722026; x=1711326826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DfhnDW5OGlo/pr+6UOixZkMPM1UIxu68W5Spy7o3JkA=;
        b=Qezxlb9fEwDK3u56jCik5iIgbIKWsqsWQu7FEQl+Z34adNBblshoEfDcalQ/mSDMIA
         /iS2N8FVD45FWl1HXS08LHTW/9m3W6J/1hDV3TWFrChqqnr+llXvMlzLa4Grk0heCMf3
         g/UmW1oSWG+iAIGhHxywntB1oYl52Lc/c3SisqohDZKBsjDAkklk3oc6YF2nzVzyLLh5
         1KYDqSy15XRdWroadtMEj01aVkns4DvvIhiacNgj1+DZqx1KrV+m2cfadmcg7r8f1c3O
         eKtUv3+1BAGjoIAFVmG4A3rTKntrwJ+RlDFevX7zReZZqI7IN0qRPyJ9RTu1quZ3PgCe
         looA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710722026; x=1711326826;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DfhnDW5OGlo/pr+6UOixZkMPM1UIxu68W5Spy7o3JkA=;
        b=BKR832s/NP7eadTjej0/hgdlHDRSYw129GhIMY1Mq+iK8zZdyNCQHfaMN1s4/MnkWx
         mwnLAcMbJsX0utLwwDRLGtvMIgfpbHVVUE3ylVQD5CIQv0k4FMvej09EaLPqArA3fhzF
         FB4jl6v2rQI6TR3O7cYnwiit/AXOupUSNsBfuUP9ZKD7UkN44asLca8r9SuLxI4tkrS4
         fiWSlIyHFw0RjIzW/EBBjlr3ig4y4xRcYl65WLWYg914R4A01sXj98STnNBkCxMJYQw8
         Tvh/s1XuQ0SsMLIywwezAQDJGSUJuPw1Q1/UZl1zX04SHcFnmF1qockPBEGOYfB4Y+S9
         gnJg==
X-Forwarded-Encrypted: i=1; AJvYcCX2b1m4falwWKEVKsz1TwpkTnTvk/6NyVui56NUbV4KEeyXcdPzsbrcMv/B87BfA+9Ez4cW1v1+S06d2N2WrV+beKvpKkOAyfJ59ex9b40CsN7U177xn6h7dqg7rQ/M3oN7UAse16HannVJ
X-Gm-Message-State: AOJu0Yy2jpSfpEjBbcgyYCn8eoN6p7q/8z3fRZSqx4jFBXBHNnDCxsM1
	7J/kVKz9A8YLhEubzDheWKohEontvwALDBRqr19oAoMbYusRnAF4
X-Google-Smtp-Source: AGHT+IGtuEDzxb+Wqgr47235rCw5OYIMzyj+3tRx96vOT5GTPK9NvbyTEx2Mt8dtDP5/HYJfdv0BNA==
X-Received: by 2002:a17:903:2282:b0:1e0:e11:c631 with SMTP id b2-20020a170903228200b001e00e11c631mr3442856plh.34.1710722025684;
        Sun, 17 Mar 2024 17:33:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902eac600b001dd689a6ff4sm7789618pld.227.2024.03.17.17.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 17:33:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <92746b1d-6993-43a2-9245-adda3d9b7e79@roeck-us.net>
Date: Sun, 17 Mar 2024 17:33:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] crypto: scompress: remove memcpy if sg_nents is 1 and
 pages are lowmem
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net,
 linux-crypto@vger.kernel.org, akpm@linux-foundation.org, chrisl@kernel.org,
 sjenning@redhat.com, vitaly.wool@konsulko.com, linux-kernel@vger.kernel.org,
 Barry Song <v-songbaohua@oppo.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>,
 Chengming Zhou <zhouchengming@bytedance.com>
References: <20240301192745.14987-1-21cnbao@gmail.com>
 <aaa8b7d7-5abe-47bf-93f6-407942436472@roeck-us.net>
 <CAGsJ_4wWEdxk0qNV89bL0zeGaXUBb7h92mdNeRCgcUCY5C84ww@mail.gmail.com>
 <bf2a5631-79cc-414e-82f0-6b45e487c8d9@roeck-us.net>
 <CAGsJ_4xGKFaQPD-KurP2=qiD5zSdnOwZtH-kyASP_PgFX_mJAg@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAGsJ_4xGKFaQPD-KurP2=qiD5zSdnOwZtH-kyASP_PgFX_mJAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/17/24 17:21, Barry Song wrote:
> On Mon, Mar 18, 2024 at 8:14 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 3/17/24 16:48, Barry Song wrote:
>>> On Mon, Mar 18, 2024 at 7:13 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On Sat, Mar 02, 2024 at 08:27:45AM +1300, Barry Song wrote:
>>>> [ ... ]
>>>>> @@ -152,8 +165,17 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
>>>>>                         ret = -ENOSPC;
>>>>>                         goto out;
>>>>>                 }
>>>>> -             scatterwalk_map_and_copy(scratch->dst, req->dst, 0, req->dlen,
>>>>> -                                      1);
>>>>> +             if (dst == scratch->dst) {
>>>>> +                     scatterwalk_map_and_copy(scratch->dst, req->dst, 0,
>>>>> +                                              req->dlen, 1);
>>>>> +             } else {
>>>>> +                     int nr_pages = DIV_ROUND_UP(req->dst->offset + req->dlen, PAGE_SIZE);
>>>>> +                     int i;
>>>>> +                     struct page *dst_page = sg_page(req->dst);
>>>>> +
>>>>> +                     for (i = 0; i < nr_pages; i++)
>>>>> +                             flush_dcache_page(dst_page + i);
>>>>
>>>> flush_dcache_page() is an empty macro on some architectures
>>>> such as xtensa. This results in
>>>
>>> Hi Guenter,
>>>
>>> this is a bug of xtensa, could you test the patch:
>>
>> Thanks for the update.
>>
>>> https://lore.kernel.org/all/20240313045036.51065-1-21cnbao@gmail.com/
>>>
>>
>> That doesn't build for me.
>>
>>     CC      arch/xtensa/kernel/asm-offsets.s
>> In file included from ./include/linux/highmem.h:8,
>>                    from ./include/linux/bvec.h:10,
>>                    from ./include/linux/blk_types.h:10,
>>                    from ./include/linux/writeback.h:13,
>>                    from ./include/linux/memcontrol.h:23,
>>                    from ./include/linux/swap.h:9,
>>                    from ./include/linux/suspend.h:5,
>>                    from arch/xtensa/kernel/asm-offsets.c:24:
>> ./include/linux/cacheflush.h:9:5: error: "ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE" is not defined, evaluates to 0 [-Werror=undef]
>>       9 | #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
>>
>> A similar works for loongarch, so I don't know what is wrong.
>> Maybe some context patch is missing.
> 
> this is weird as include/asm-generic/cacheflush.h will define it to 0
> 
>   #ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
>   static inline void flush_dcache_page(struct page *page)
>   {
>   }
> 
>   #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
>   #endif
> 
> Maybe somewhere else also needs to be fixed.
> Can you tell me your toolchain version and toolchain name? and defconfig name?
> 

config is allmodconfig - GCC_PLUGINS.

Toolchains are self-built from gcc source using the buildall system. I tried
gcc 11.4, 12.3, and 13.2. I don't think that matters, though, since
"asm-generic/cacheflush.h" isn't included from arch/xtensa. The diff below
seems to fix the problem, but I have not fully tested it.

Guenter

---
diff --git a/arch/xtensa/include/asm/cacheflush.h b/arch/xtensa/include/asm/cacheflush.h
index 11efdc8eb262..62662919cbbc 100644
--- a/arch/xtensa/include/asm/cacheflush.h
+++ b/arch/xtensa/include/asm/cacheflush.h
@@ -183,4 +183,6 @@ extern void copy_from_user_page(struct vm_area_struct*, struct page*,

  #endif

+#include <asm-generic/cacheflush.h>
+
  #endif /* _XTENSA_CACHEFLUSH_H */


