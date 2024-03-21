Return-Path: <linux-kernel+bounces-109651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34750881BFA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 05:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FCF283509
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8AF2BAFC;
	Thu, 21 Mar 2024 04:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="N3++ZyRR"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828556FBF;
	Thu, 21 Mar 2024 04:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710995992; cv=none; b=h8vwEZKP+rjX/bmFkI+vptKI0oVS6g5v/f1ha+lsiCLnBkcf+LD7qqIO2P18QNhucr6BwLR7kxGE8zXrobborQwTBJKolUSQ3LPn9oJeYtr2Jy0iUnfsLWKpGX/hHRBgKjAYTCd3q0E66SBjcHdBjd97yxD58Q9cHdBhwKgLxrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710995992; c=relaxed/simple;
	bh=bXH3LTZQb0BcQowVSX+dlyGGDO6k3bqGTWcs3BYwsMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NdYZRGO7LhFILG4Dns5GLvjwMXolnNKHwXTsddkxO56T73yqJYxUkJ8ppasFPQGmPDQCIB6uurNPcy3o+29/26A6OLcZK4SZy6ta3TZ7K+zRgLuZCWhSEPh0YmNP4whr/GEqEpsV8Is//IrKTaXytar5u+QXQEXdzaPY7k16ye4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=N3++ZyRR; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=TG/kojo4MfR9m2ePLKKNRYbP9JmFRG/HMKZR9UCfC9s=;
	b=N3++ZyRRTyMlHyQkyMQiBet3n/ePSBCvlu2eJHmX4Hgsak+IepfElFKTQ+SeGH
	01gUuO5A6fJkfrTngIEA6jW1vUqg5vAl1R7qJhHd5TyqX9igokEe10u7VfJXdRis
	EOKdhXVgCHTCf9UBygMj5iRz+sRBDfbwqN/as43Hq/C/c=
Received: from [192.168.101.252] (unknown [14.21.70.188])
	by gzga-smtp-mta-g1-3 (Coremail) with SMTP id _____wDXvx3NuftlxJ7sAA--.37307S2;
	Thu, 21 Mar 2024 12:38:37 +0800 (CST)
Message-ID: <7bdc4d24-adfd-4a8c-b824-6833149f5636@126.com>
Date: Thu, 21 Mar 2024 12:38:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: coding-style: ask function-like macros to
 evaluate parameters
To: Barry Song <21cnbao@gmail.com>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Zankel <chris@zankel.net>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Herbert Xu <herbert@gondor.apana.org.au>, Guenter Roeck
 <linux@roeck-us.net>, Max Filippov <jcmvbkbc@gmail.com>
References: <20240320001656.10075-1-21cnbao@gmail.com>
 <EFB48F08-F0B5-47C0-8C47-00A542344AC9@126.com>
 <CAGsJ_4xJsqOO-NXs3OWVA47vcK-zUpcrMxCbnY7x5khRH0dnxA@mail.gmail.com>
From: Meiyong Yu <meiyong.yu@126.com>
In-Reply-To: <CAGsJ_4xJsqOO-NXs3OWVA47vcK-zUpcrMxCbnY7x5khRH0dnxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXvx3NuftlxJ7sAA--.37307S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF4UCFWUZr4UJFWxXrWUurg_yoW5uw18pF
	W5JF42qa1kXryUAr1qvw1SyFy7trW5CFW7WrsxtryUuFs0yFn3Kr47tr15uFs7Ar48CayU
	ua1jg3sxuFyayaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jtVysUUUUU=
X-CM-SenderInfo: 5phl501qjo53a6rslhhfrp/1tbijhKohmVLZvaPiwAAsI


在 2024/3/21 8:11, Barry Song 写道:
> On Thu, Mar 21, 2024 at 12:39 PM Meiyong Yu <meiyong.yu@126.com> wrote:
>>
>>> On Mar 20, 2024, at 08:17, Barry Song <21cnbao@gmail.com> wrote:
>>>
>>> ﻿From: Barry Song <v-songbaohua@oppo.com>
>>>
>>> Recent commit 77292bb8ca69c80 ("crypto: scomp - remove memcpy if
>>> sg_nents is 1 and pages are lowmem") leads to warnings on xtensa
>>> and loongarch,
>>>    In file included from crypto/scompress.c:12:
>>>    include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
>>>    include/crypto/scatterwalk.h:76:30: warning: variable 'page' set but not used [-Wunused-but-set-variable]
>>>       76 |                 struct page *page;
>>>          |                              ^~~~
>>>    crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
>>>>> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-Wunused-variable]
>>>      174 |                         struct page *dst_page = sg_page(req->dst);
>>>          |
>>>
>>> The reason is that flush_dcache_page() is implemented as a noop
>>> macro on these platforms as below,
>>>
>>> #define flush_dcache_page(page) do { } while (0)
>>>
>>> The driver code, for itself, seems be quite innocent and placing
>>> maybe_unused seems pointless,
>>>
>>> struct page *dst_page = sg_page(req->dst);
>>>
>>> for (i = 0; i < nr_pages; i++)
>>>     flush_dcache_page(dst_page + i);
>>>
>>> And it should be independent of architectural implementation
>>> differences.
>>>
>>> Let's have a guidance in codingstyle to ask for the evaluation
>>> of parameters.
>>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Chris Zankel <chris@zankel.net>
>>> Cc: Huacai Chen <chenhuacai@loongson.cn>
>>> Cc: Herbert Xu <herbert@gondor.apana.org.au>
>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>> Suggested-by: Max Filippov <jcmvbkbc@gmail.com>
>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>> ---
>>> Documentation/process/coding-style.rst | 7 +++++++
>>> 1 file changed, 7 insertions(+)
>>>
>>> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
>>> index 9c7cf7347394..8065747fddff 100644
>>> --- a/Documentation/process/coding-style.rst
>>> +++ b/Documentation/process/coding-style.rst
>>> @@ -827,6 +827,13 @@ Macros with multiple statements should be enclosed in a do - while block:
>>>                 do_this(b, c);        \
>>>         } while (0)
>>>
>>
>>> +Function-like macros should evaluate their parameters, for unused parameters,
>> I do not support this point, if the parameter is unused, why not to remove it.
>>
> Linux boasts support for numerous architectures, striving for
> independence in its
> drivers and core code implementation across these architectures. Consequently,
> certain architectures may utilize parameters for the same APIs, while others may
> not.

So the probem is  designed api is not reasonable,  it use not essential 
paramter,

you can change the api, but not avoid it.

Anthor question, why you do not use the parameter, if not use it,  will 
trigger function/feature dismiss problem ?

>> about the warning,  is  tool misreport,  the tool must make better
>>
> no. This is not the case.
>
>>> +cast them to void:
>>> +
>>> +.. code-block:: c
>>> +
>>> +    #define macrofun(a) do { (void) (a); } while (0)
>>> +
>>> Things to avoid when using macros:
>>>
>>> 1) macros that affect control flow:
>>> --
>>> 2.34.1
>>>
>>


