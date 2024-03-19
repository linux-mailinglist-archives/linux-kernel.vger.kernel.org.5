Return-Path: <linux-kernel+bounces-107635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D28887FF70
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005371C22BC5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7C781754;
	Tue, 19 Mar 2024 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOWcBsTZ"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2098174F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710857882; cv=none; b=CmxjG/ZT3YZMnl0YORMGO1yg/Q5tFzTJycwZ449zO67BI5g6t4QZwID+x0X1I/FnfyGG9LCf8++ZUd5ZFoPFKHLQNbuyykdS2gZu9OPB0/XutXzNiclLNrxdkYOPCiKSscJmFrTdnNJRPF4h9wVMOfqMvDS+d/FsimyDmkm8R7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710857882; c=relaxed/simple;
	bh=Ngo7I28ehFnIyWMvqYsqxTOaNxUTATfqh+y2MQnnF5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJT6le8hzfNMjcVJGfNAXjdolfGTvevJpPWzPncoZd29oe4Hef9BLgym8nma8BTNFBR+QIXU9CNAH8jBUrlZozAoiW5dZquPmjse/XoQOkvhE+UW6LhSRyJsqg2BR/8D/fhX0qtmtMk7u+KpEWk8mcia+YNfln43fqTLW9cs3cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOWcBsTZ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1def142ae7bso37762395ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 07:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710857880; x=1711462680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=r21iHhdhJ4DClbHKl3nwaHMNMiWy6HKHiyTydfXw++4=;
        b=hOWcBsTZKsYx7nxL+8wJeXzgkUJWQZsiuPyz4hL4uYRqjv+Cs7frZrhLa3eFaJ0DoO
         qBVVhgMIyPvsyVWVKI5q7U9NUO61qyP0GtIPjFyQjAL3b1tJs5moq4TZgpO3+xaBcS7a
         yr9EXTJfXc7ytOYbZBMA2IPkUcrid+rSPQGGEu8mDVlEID0PdUJ4kdztOK4Tpi0ZWjWw
         UOLuI5i4g/ovuRsnCo7Ip1Ky4w5Gz4qZBnwE4KQ8SxddxLQyJDvWqnQIm9CLHG8ftazV
         APdwskkHWxjCQI3XyH9iP0rOijLP+B/wqQ2ZEq7+/BUvgFrlmbz7e42dOH7OKLDIcv6l
         FN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710857880; x=1711462680;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r21iHhdhJ4DClbHKl3nwaHMNMiWy6HKHiyTydfXw++4=;
        b=stP2fwIUu2Qe324C5+Z1GEaXiE25C4/ytjGgLu5VoYoCjhfBPZ5tPnqrkRlQAQ8+TZ
         Ubyslqq1ArY6rKBdD6d/ChrZNL2Jj6ZyoF0PRb2FKdTUCddMVJU6PDxD6siGH3xpz95M
         LpWVhp28HyLcPt0T0A6ojytIG0+zfP2H2lhcyAH9S/J0qBDsU0T0GwNZgOaT6Oq71zn1
         OfSCPpyx3f7UrHE+qsLoM3y/v4uKlFuKecZtOREQ2QfZdaHktVoGzeKtD4iXP663v0i6
         rNpM4fm+1QHZVM9JVKrFRTgKgc2FuI21D3WiQizFrnBkvwtFkXZGl27j9BULrJWGCuyK
         z7Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWGjj3UUNZhh9hmfUDeXENiG7VsSgKzmkfBZzNC9kVfzB6u4tc/+NfFepWryVukzxdg0UkF/a46H9avIVH95YJHc9BPdBTctck2rNKz
X-Gm-Message-State: AOJu0YxnrCH90BaPfv4KOhiAnCsvx61gTP8/dDUmvnc+Z61rkuYcI6gT
	CppCYv/P9iLrDKEL4mjfFXd3KQuOKvH8Uf6oOkncbggyvBhPWZL8
X-Google-Smtp-Source: AGHT+IFlKRND9s2wi/3Lif9JOqd2rHcB2ofU28B1WWCmf/M/qgl1iqHvXKKqwbHj2BJwCAz8QPKwSQ==
X-Received: by 2002:a17:902:d2c4:b0:1de:fc12:f66c with SMTP id n4-20020a170902d2c400b001defc12f66cmr13917764plc.27.1710857879922;
        Tue, 19 Mar 2024 07:17:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b001dd744f97d0sm10173611plb.273.2024.03.19.07.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 07:17:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ce352c9c-2052-4a23-809a-ef4cc9b7169c@roeck-us.net>
Date: Tue, 19 Mar 2024 07:17:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xtensa: remove redundant flush_dcache_page and
 ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE macros
Content-Language: en-US
To: Barry Song <21cnbao@gmail.com>, chris@zankel.net, jcmvbkbc@gmail.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc: willy@infradead.org, dennis@kernel.org, alexghiti@rivosinc.com,
 Barry Song <v-songbaohua@oppo.com>, Huacai Chen <chenhuacai@loongson.cn>,
 Herbert Xu <herbert@gondor.apana.org.au>, kernel test robot <lkp@intel.com>
References: <20240319010920.125192-1-21cnbao@gmail.com>
 <CAGsJ_4z1k9BQGPJvuXtXPQueokM-yu0nf7yQko6yjhj-0fgAnA@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAGsJ_4z1k9BQGPJvuXtXPQueokM-yu0nf7yQko6yjhj-0fgAnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/18/24 18:27, Barry Song wrote:
> On Tue, Mar 19, 2024 at 2:09 PM Barry Song <21cnbao@gmail.com> wrote:
>>
>> From: Barry Song <v-songbaohua@oppo.com>
>>
>> xtensa's flush_dcache_page() can be a no-op sometimes. There is a
>> generic implementation for this case in include/asm-generic/
>> cacheflush.h.
>>   #ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
>>   static inline void flush_dcache_page(struct page *page)
>>   {
>>   }
>>
>>   #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
>>   #endif
>>
>> So remove the superfluous flush_dcache_page() definition, which also
>> helps silence potential build warnings complaining the page variable
>> passed to flush_dcache_page() is not used.
>>
>>     In file included from crypto/scompress.c:12:
>>     include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
>>     include/crypto/scatterwalk.h:76:30: warning: variable 'page' set but not used [-Wunused-but-set-variable]
>>        76 |                 struct page *page;
>>           |                              ^~~~
>>     crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
>>>> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-Wunused-variable]
>>       174 |                         struct page *dst_page = sg_page(req->dst);
>>           |
>>
>> The issue was originally reported on LoongArch by kernel test
>> robot (Huacai fixed it on LoongArch), then reported by Guenter
>> and me on xtensa.
>>
>> This patch also removes lots of redundant macros which have
>> been defined by asm-generic/cacheflush.h.
>>
>> Cc: Huacai Chen <chenhuacai@loongson.cn>
>> Cc: Herbert Xu <herbert@gondor.apana.org.au>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202403091614.NeUw5zcv-lkp@intel.com/
>> Reported-by: Barry Song <v-songbaohua@oppo.com>
>> Closes: https://lore.kernel.org/all/CAGsJ_4yDk1+axbte7FKQEwD7X2oxUCFrEc9M5YOS1BobfDFXPA@mail.gmail.com/
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
> 
> Hi Guenter,
> I am not a xtensa guy, so I will need your help for a full test. if
> turns out it is a too big(ambitious)

I sent a Tested-by: tag to your patch. As far as my testing goes, it works fine,
and I added your patch to my "testing" branch (which tries to be buildable
and testable for all architectures).

> fix, a minimal fix might be:
> 

FWIW, I think a minimal fix would have been to mark the variable as __maybe_unused,
but as others have pointed out it would be nice if there would be a guidance
about optional API functions like this one that specifies if it may be
implemented as macro and, if so, how it has to handle unused variables.

Thanks,
Guenter


