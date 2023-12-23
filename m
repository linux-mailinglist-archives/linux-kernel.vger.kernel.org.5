Return-Path: <linux-kernel+bounces-10452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4C081D48E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2422BB21EC9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106E111CA3;
	Sat, 23 Dec 2023 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hehFhjOL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A952A1119C
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 14:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-54c7744a93fso2957877a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 06:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703341386; x=1703946186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eUtubScy5GgYH48lqXbABEThZ+ymAXfmCY1RXmy3kE8=;
        b=hehFhjOLH4nTJ5+l3kRAafo8q9HDzpeDQ2xYacB7yWledTGEVcFbQ/HjlqZqhgZ3iz
         RHWCAgCA/ub3mf6cYWiD9zBJOg0ar7NYTIc3wZpJ46u+paEv810qLtWAodn46fLooLEW
         ZsvhwtrGhVWJpf1RJsGpEJoAj13l/addbaqnPPk3UTNVyPGSPj84YlVyfeGfD/2u2EpN
         v+dKltH/RM7tN0lmxI00jTRW0cn5jHkfYVj5bUP5zAXwRF64eF9Wz1y0vTQpzeCkm74B
         nxv9fzl3myX8vgHq4rGEyTlbi1cbj71FSURo8xtd0i4ZM+1hL0desQXN2r5kviWP89rm
         mv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703341386; x=1703946186;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eUtubScy5GgYH48lqXbABEThZ+ymAXfmCY1RXmy3kE8=;
        b=KfMDjHGeMGGA8qWffUIlj5sF4YCsn8MpvTEZeWu37u7joXj3CMwYw2LgHoYTr+27ff
         KICXCSaoA81AnAZ5+QmT14Y3oNca/MwTx2p2kg3RXFRycc2QkarAZFx29OS0QpWxBnQx
         0yBrgyQSNhUYOFqBFkmLFXPtyEVrFrdqPIbraLmJlznVx6d8Va9U+jepM8qEzM29qGME
         j8XHLAwgYX+CPeUPp0eWylrr0Sc8rEaaHas10qZriQ8RlJb6u7XfJvX2Io0cMo/U2w0D
         W6Cn5lTPKD3zZhLRo82Uh3rwdtesAuCZnH2Bgatc2P1lP9fympHpMlnSljHT33m4vhnc
         nbKw==
X-Gm-Message-State: AOJu0Ywo+ly5NNdgHGVR91ABC1/FO5UB+vtksCoOy1SrQtXKKD5ZUaYe
	HN4iz/AwJ9ffB4XLxK7n1+hgdYJC9iRdwg==
X-Google-Smtp-Source: AGHT+IEzM0CTjziLqsSniZ3DXJLzZDp5cBCF9G7iaOVNTOSRkVUYP5cOZY+sKs3ps5HrES1fj+smkg==
X-Received: by 2002:a50:8e13:0:b0:54c:4837:9a99 with SMTP id 19-20020a508e13000000b0054c48379a99mr1998071edw.64.1703341385765;
        Sat, 23 Dec 2023 06:23:05 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id w14-20020aa7d28e000000b0055306f10c28sm3949225edq.28.2023.12.23.06.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Dec 2023 06:23:05 -0800 (PST)
Message-ID: <6fe05804-da74-45cd-a6f1-df4644671d99@linaro.org>
Date: Sat, 23 Dec 2023 15:23:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] [RFC PATCH 1/7] osdump: Add one new os minidump
 module
Content-Language: en-US
To: ruipeng qi <ruipengqi7@gmail.com>
Cc: catalin.marinas@arm.com, will@kernel.org, bhe@redhat.com,
 vgoyal@redhat.com, dyoung@redhat.com, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, zalbassam@google.com, dianders@chromium.org,
 mark.rutland@arm.com, lecopzer.chen@mediatek.com, maz@kernel.org,
 arnd@arndb.de, yury.norov@gmail.com, brauner@kernel.org, mcgrof@kernel.org,
 maninder1.s@samsung.com, michael.christie@oracle.com,
 samitolvanen@google.com, linux-arm-kernel@lists.infradead.org,
 qiruipeng@lixiang.com
References: <20231221130930.32634-1-ruipengqi7@gmail.com>
 <e9aa311f-6f13-410e-bb35-20320275668c@linaro.org>
 <CADHLONGLZaZT4Ot56AnxOf=ROrTWvge5=NUx5uqKqJhpJibfOQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CADHLONGLZaZT4Ot56AnxOf=ROrTWvge5=NUx5uqKqJhpJibfOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/12/2023 15:12, ruipeng qi wrote:
> On Fri, Dec 22, 2023 at 12:25 AM Krzysztof Kozlowski <krzysztof.kozlowski
> @linaro.org> wrote:
>>> Osdump is a new crash dumping solution aiming at specific embedded
>>> devices within automotive or Industrial.
>>>  - limited memory.
>>>  - reboot as soon as possible when system fault.
>>
>> NAK, sorry, work with Qualcomm minidump series to incorporate all your
>> needs there.
> 
> Sorry, I didn't explain it properly. Will add more descriptions in the
> next version. Osdump is a totally different mindump, which aims at
> helping to solve kernel issues as easy as kdump/kexec/crash, but
> with little costs.
> 
> For something like Pstore, you can get where the issue occurs. You can
> figure out the problem if it is easy, but sometimes you can't. For example:
> 
> <4>[    5.311431]  task_blocks_on_rt_mutex+0x234/0x380
> <4>[    5.316166]  rt_spin_lock_slowlock_locked+0xcc/0x2b0
> <4>[    5.321257]  rt_spin_lock_slowlock+0x5c/0x90
> <4>[    5.325633]  rt_spin_lock+0x60/0x74
> <4>[    5.329207]  refill_stock+0x58/0x230
> 
> You can find where the issue occurs.
> static inline struct rt_mutex_waiter *rt_mutex_top_waiter(struct rt_mutex *lock)
>  {
>   struct rb_node *leftmost = rb_first_cached(&lock->waiters);
>   struct rt_mutex_waiter *w = NULL;
>   if (leftmost) {
>     w = rb_entry(leftmost, struct rt_mutex_waiter, tree_entry);
>     BUG_ON(w->lock != lock);
> 
> But you don't know why w->lock and lock are different, and who is wrong.
> 
> Qcom minidump can dump some logs like dmsg, some status like IRQ or
> Run queue. This can help to learn some information when the issue occurs,
> which will help to find out the root cause. But what it dumps are limited, it
> doesn't dump w and lock if they are not local data.

So add missing features to it. I don't think you got my comment and keep
arguing on the same thing repeated for upstream submissions many times.
We do not want multiple vendor solutions. Every vendor wants his work
and does not care about integrating or reusing other pieces.

> 
> For osdump, it dumps objects stored in slab, datas in bss, data segments,
> some data alloced with memblock, data stored in local stack, and so on.
> In a word, it dumps almost all of the key data in the kernel. Besides, you
> can use the crash tool to analyze the dump file.

I don't see a problem why minidump cannot do it.

> 
> In a word, I think this toal different minidump should have its own place in
> the kernel world. Looking forward to your suggestions!

No, work with minidump.

For any further submissions which do not merge this work into minidump,
please carry:

Nacked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


