Return-Path: <linux-kernel+bounces-105597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7216887E131
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69E3B1C20DA6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 00:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F067B17CB;
	Mon, 18 Mar 2024 00:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAlLix2U"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E424EBF;
	Mon, 18 Mar 2024 00:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710720843; cv=none; b=JgfqDJ/Xl5gFP1f/yh0sx8wes6EpeUbJQMixcZeXlCdX8J7aMJUBst1cT+CAIwsn3irECAhNncw18XFjSkdhBjzTXLyFPaiPjOvTcv/MNKGjUGnKcX7mtthSHvZPqS8nd77WbuzGseE2H/Sf+SJqtkG0wRBxxc7/t7yhGacY4ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710720843; c=relaxed/simple;
	bh=cZOKI1eZyGsmjUEZ+hRiNuYZGhMF+xPoAcEMoaVRFug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aeIh4r6vZAViZTZKs/faEB84ybR/qVTsMsYgtot6CalacjUkCcaD7XV6/qDi9BaNOpSHZZib7pt2nGEMAIyMmxP666IuyYvtwzb8bMV5uKfCq4WvI520TvO4P4tm1P/3ZZXnZRkuV1OrI+OJ6uNcb2DHbjOoEXyhza5tApFFLEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAlLix2U; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-21fb368b468so2318579fac.0;
        Sun, 17 Mar 2024 17:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710720840; x=1711325640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVZ52BDSjh9yH+lnGU//XZN+oBlR/jN1C9XX3w9YbMY=;
        b=WAlLix2Umgd7A1cGMjpGLMOzNGQTzICQLqJyFEwEKM62lYnBLyXj9CoNlweM+yQwQ/
         Th1HzfWY4nx+o+NQaeiRXdTjKM/9b6w7X7hx9z9F/ZBYRyoHpAmwfllRpPI9cSsTCOl4
         3e7IVUjPAvu6kx6yqsS78hZqWi6FtF9/G9ZdlmI+SQqgBln2UibioCtEIgFFnBuCOsep
         b3PqDC5FuRVGuwwC1xyESqRyRhjn79NOHz5t1lt2nnzFgxxnd7V4lJw6uhKJ/QcRsi2B
         w9gvSfjeamaB7zZff7H0qPHc5eoAJFUzoaBU4T7s2HrG1boDA9EIa5zulYqa/71yKZq9
         fc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710720840; x=1711325640;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVZ52BDSjh9yH+lnGU//XZN+oBlR/jN1C9XX3w9YbMY=;
        b=QUprB0Wunk3EPIrCf2ne6gqsaX8Kq5G7fts16sgP8TTnZ3qk6h1SBNsLJOmqDqlq3f
         RfVEa7/51J6TP1ix5rruBXGu33iMKPk5N6UKK3J9T5zIn81yXc4wiyRL7K+aqIdYiuz3
         RH01/gFPPMTW1WU7sPLUzNW+XHtOs+IMkwnZPLkf2ebME4rPDI9aNZeHF/XuTyIM3HmM
         3bwjweeQGbOwOAmFaxGAn1F2+BEfHV24hvB7IsaJiL9Ucdc+jy8YGr9XXw7OF+aWauIC
         1hzuk+RRKtSJo+yigyUistF7GWyzO9T48uoxzymKt+ISa/MQLtNVU9qxNrv18N56qMXC
         eOIw==
X-Forwarded-Encrypted: i=1; AJvYcCVSOLPUq4R/xonGm3RGwVDsK/FO4ZGnIz6Mpw+z4fuGJpnvNRURdZd0QazShT2qCty9U/lMT0MFRO3ox03kcBxeDHSRTZ/q/vXqJP9k1BffSYPWp2Dt7HGaMb1oNmq/ddRlK5vSp4LWGA8k
X-Gm-Message-State: AOJu0YxAdj5rt12yNaFwrHabFnvEKFs0ak4n6qEMAjjm+Y8KIbEB+HcT
	+i1i8jB8DNyuPsMNupwgQPUYkMKR4ufyZ9k2dcXE1leDL0/0jUs3
X-Google-Smtp-Source: AGHT+IFhQTNUI/AF7UF7N+chYCDcguaqyFbJ7ZaY31XRRlXfuzqXdksvpQWQzAygmz2sgE9OXkxM+A==
X-Received: by 2002:a05:6870:a691:b0:220:873d:dbcc with SMTP id i17-20020a056870a69100b00220873ddbccmr11996322oam.49.1710720840376;
        Sun, 17 Mar 2024 17:14:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u14-20020aa7848e000000b006e6b4c637b6sm6682674pfn.116.2024.03.17.17.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 17:13:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bf2a5631-79cc-414e-82f0-6b45e487c8d9@roeck-us.net>
Date: Sun, 17 Mar 2024 17:13:57 -0700
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
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAGsJ_4wWEdxk0qNV89bL0zeGaXUBb7h92mdNeRCgcUCY5C84ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/17/24 16:48, Barry Song wrote:
> On Mon, Mar 18, 2024 at 7:13 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Hi,
>>
>> On Sat, Mar 02, 2024 at 08:27:45AM +1300, Barry Song wrote:
>> [ ... ]
>>> @@ -152,8 +165,17 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
>>>                        ret = -ENOSPC;
>>>                        goto out;
>>>                }
>>> -             scatterwalk_map_and_copy(scratch->dst, req->dst, 0, req->dlen,
>>> -                                      1);
>>> +             if (dst == scratch->dst) {
>>> +                     scatterwalk_map_and_copy(scratch->dst, req->dst, 0,
>>> +                                              req->dlen, 1);
>>> +             } else {
>>> +                     int nr_pages = DIV_ROUND_UP(req->dst->offset + req->dlen, PAGE_SIZE);
>>> +                     int i;
>>> +                     struct page *dst_page = sg_page(req->dst);
>>> +
>>> +                     for (i = 0; i < nr_pages; i++)
>>> +                             flush_dcache_page(dst_page + i);
>>
>> flush_dcache_page() is an empty macro on some architectures
>> such as xtensa. This results in
> 
> Hi Guenter,
> 
> this is a bug of xtensa, could you test the patch:

Thanks for the update.

> https://lore.kernel.org/all/20240313045036.51065-1-21cnbao@gmail.com/
> 

That doesn't build for me.

   CC      arch/xtensa/kernel/asm-offsets.s
In file included from ./include/linux/highmem.h:8,
                  from ./include/linux/bvec.h:10,
                  from ./include/linux/blk_types.h:10,
                  from ./include/linux/writeback.h:13,
                  from ./include/linux/memcontrol.h:23,
                  from ./include/linux/swap.h:9,
                  from ./include/linux/suspend.h:5,
                  from arch/xtensa/kernel/asm-offsets.c:24:
/include/linux/cacheflush.h:9:5: error: "ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE" is not defined, evaluates to 0 [-Werror=undef]
     9 | #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE

A similar works for loongarch, so I don't know what is wrong.
Maybe some context patch is missing.

Guenter


