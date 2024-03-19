Return-Path: <linux-kernel+bounces-106972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDA287F62A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B50282E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859017BB11;
	Tue, 19 Mar 2024 03:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYakhpPE"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009E07B3F3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710820144; cv=none; b=ux9BglIBHFQjPTrz82+/LSCUGaDPLrglgEoi8scgLSFgljIYIFocjGwyxrSWAdJRhmKC7s4VIAiImVbUgT/If8f/rBEdromoToyo2tZU0vWAT4zX2qhC2As0c7TYbwWRNeQ31g/DLVopBoQlS5MEJW89CZsr2SHDWC/kYsvCr7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710820144; c=relaxed/simple;
	bh=l6IhVl/etOh9sCweffMW8ULJSf1CXFYVFXmht26xtXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p9bzQg4KpQplNYJe/+FBYKpww8wfzYPvn0EBuFcZeLRplbc4KCaDCLMS0SERhdiOfUH89+l7O7yIG76+lFkVgHBJdXHDAav9WkwaiUGteaYHfk9KdZPZGPjq3vTTYiRMDek9bxM1SEdhRDWiwp68K9aXPz/KMA3b81JiS1WMR7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYakhpPE; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a47cecb98bso2204185eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710820142; x=1711424942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5aTd25vcP+zqB6E8eDdwCoKDQ1IRqv+q+vRoOzHQO7k=;
        b=HYakhpPErXjf+TN1EBu6PPRG8ifJc3YuyGY06ru7Q29SBo8UeruFb0z2WOb7PWFnc9
         iLQV9xqi0A8nPbyggySwrw+DrQf/Be05tctw6cTx8mIQfX5NQCZB+MO0COiw9i7YGrcT
         jbxvAuSPNtc7lE9wkeIQgI+AZVm8Q5vdBNA+CkUtleKWi7m0Fs14NrHDeOlk6FBbwlCj
         p30CUwgln+BI3GuBp1pBsEVseoA+7tEXUxuip65zReoX5uwsnol21jHuBQL2TF535TWu
         lZvlv+5+bTOwHxgwegrlJhrnkg0U2PCJCHRJ7wxdOWx9MyNCNRMwUSDOahxdzkT4ZHcx
         30nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710820142; x=1711424942;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5aTd25vcP+zqB6E8eDdwCoKDQ1IRqv+q+vRoOzHQO7k=;
        b=WaHWvGEUaR6cgntJXk9MAIC1wo9UqMT8cEsXmQH0yUBdZOEKhicSdyfHW6kQwitAOF
         dY3ULLFE39fU6hufrxT5NPD27SNpFgcycxsWEk1BDpGnviYW1qgm3WFpSBvV5nyTu5jJ
         VEn/n+tJjwFEjkHYzMQDHI3yJbs/KjFByp9X3XVgGVmV1Z5AEIEN62Yswqxz2jARY4yg
         07wIy6rXNVN6m/wk6piQR8O87jD14C1bUlJMTyOg/KhDqTQS5lJYl+ppAKFZ/s+ZVTDP
         d2IwDFDa170A5HxP46s7nLMIZy1k5FilS5DP1cA/1nsgH+xHwf/5sZDHaynJ+47saSIm
         /jyg==
X-Forwarded-Encrypted: i=1; AJvYcCUIUlInSSQgxo/7FnskhiLEu13vwxaS8LHSiKxEHh9KIwG8T7l/gdms7pF42/PeuWqQNRROq5+SBsl7rfIpWq8/LarQWqauIHPrCYnM
X-Gm-Message-State: AOJu0YzB+zg5hjbujyxMuq8XvxGJXhig46DrK8m9M8A3j9kMZL4plqm7
	ka7R9nKXqHL91xgz2QDIq6OBmnEGwoAjjF36WrUITl7J6HsXW+eG
X-Google-Smtp-Source: AGHT+IHdymi8hihtzoAJMUHHB5nc+gMDr0bOQVgKksLXXDh+0LsE0FdwLPYSFfhOp5o0cGCz4hSMCw==
X-Received: by 2002:a05:6358:c015:b0:17e:7c4b:bb56 with SMTP id kv21-20020a056358c01500b0017e7c4bbb56mr1792876rwc.15.1710820141869;
        Mon, 18 Mar 2024 20:49:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p6-20020a63ab06000000b005dc89957e06sm7006513pgf.71.2024.03.18.20.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 20:49:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <abf2b1db-3e13-4765-9034-712430e856d7@roeck-us.net>
Date: Mon, 18 Mar 2024 20:49:00 -0700
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
To: Barry Song <21cnbao@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Cc: chris@zankel.net, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, willy@infradead.org, dennis@kernel.org,
 alexghiti@rivosinc.com, Barry Song <v-songbaohua@oppo.com>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Herbert Xu <herbert@gondor.apana.org.au>, kernel test robot <lkp@intel.com>
References: <20240319010920.125192-1-21cnbao@gmail.com>
 <CAGsJ_4z1k9BQGPJvuXtXPQueokM-yu0nf7yQko6yjhj-0fgAnA@mail.gmail.com>
 <CAMo8BfJ+AOOY8Sn-2=CHCJ9M9kzU=w6nnkqEg=8V=2F2uNhhqQ@mail.gmail.com>
 <CAGsJ_4z8yDrrcBSByXSq79PCnCGQRaH_DXg2K2aqCApsseLDFA@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAGsJ_4z8yDrrcBSByXSq79PCnCGQRaH_DXg2K2aqCApsseLDFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/18/24 19:16, Barry Song wrote:
> On Tue, Mar 19, 2024 at 3:12 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
>>
>> On Mon, Mar 18, 2024 at 6:27 PM Barry Song <21cnbao@gmail.com> wrote:
>>> On Tue, Mar 19, 2024 at 2:09 PM Barry Song <21cnbao@gmail.com> wrote:
>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>
>>>> xtensa's flush_dcache_page() can be a no-op sometimes. There is a
>>>> generic implementation for this case in include/asm-generic/
>>>> cacheflush.h.
>>>>   #ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
>>>>   static inline void flush_dcache_page(struct page *page)
>>>>   {
>>>>   }
>>>>
>>>>   #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
>>>>   #endif
>>>>
>>>> So remove the superfluous flush_dcache_page() definition, which also
>>>> helps silence potential build warnings complaining the page variable
>>>> passed to flush_dcache_page() is not used.
>>>>
>>>>     In file included from crypto/scompress.c:12:
>>>>     include/crypto/scatterwalk.h: In function 'scatterwalk_pagedone':
>>>>     include/crypto/scatterwalk.h:76:30: warning: variable 'page' set but not used [-Wunused-but-set-variable]
>>>>        76 |                 struct page *page;
>>>>           |                              ^~~~
>>>>     crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
>>>>>> crypto/scompress.c:174:38: warning: unused variable 'dst_page' [-Wunused-variable]
>>>>       174 |                         struct page *dst_page = sg_page(req->dst);
>>>>           |
>>>>
>>>> The issue was originally reported on LoongArch by kernel test
>>>> robot (Huacai fixed it on LoongArch), then reported by Guenter
>>>> and me on xtensa.
>>
>> I wonder why this warning is considered useful in the first place?
> 
> Guenter reported it as an error not a warning
> "
> 
> Error log:
> crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
> crypto/scompress.c:174:38: error: unused variable 'dst_page'"
> 
> is it because xtensa's toolchain is different with others?
>

It is because -Werror is now default in allmodconfig builds.
Other test build systems may manually override that.

Guenter


