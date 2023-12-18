Return-Path: <linux-kernel+bounces-3431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B865816C26
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1737B212DC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0127F1A70B;
	Mon, 18 Dec 2023 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UdehhhkE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951AB1A702
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d38bedd799so23793185ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 03:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1702898814; x=1703503614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kfKoRLV9oJp0z3qD43gucxUcp/9jii5+iBZKMhLvNG4=;
        b=UdehhhkE+GE/wFpdXbaPC0i7eyVLszkF4sQwToAi1BZLiJkM5d0Wup7ZMv84yljIvt
         cJMJBSz2HKGavELtQmCuogu9djri0cLvhJ51/7m4/kIVX2Q3KTVKbHNNJVO6e1TKSzNC
         VbfcCVnpjglmM8+Tz8cRfkPv1+iXFEY1y6qUeaS2yP1z+PyReg1voLHMEsAXkEIIqdsb
         sGsuYaaz7x1gixqo4LdgNl1YVYsZrXTJw8ZlJ/BkX2MFrrGn2apIuY8q4dsaGzR1ollm
         kUelyaWiN2nBX+KIGaBulsKMm0eEfnk78J4pH6rmEw6sbisvAO97rIcLw1HZL/IuYxv2
         eIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702898814; x=1703503614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kfKoRLV9oJp0z3qD43gucxUcp/9jii5+iBZKMhLvNG4=;
        b=fJOUVlzzXi6gq27ilM9M06c+xn2hxBAJr/+Pl57YtuOaFrMGJ726SQtLGUOBFS3P3M
         BB6L8BAgwCSjS1ocJivW5lBv8QDbLCgBwNYunA0uCRZFotuZJI6eICq5MNkme4Nht9C8
         XiwFSog8JypEVSP9aKztZmIjA1MFy52GIV3oR1+eTsPd1T3ZQ7Yeji+axUjjgvh5uA87
         6C5rHBbXPUQEDquwZkijHkmbxRwesful0d3n69RWL3WXNsLm4deX+MC474PgGVCE0Oqv
         6dE5DoNls+d6V2/M9tqf2GawvqeBnX74bXCsPuEQvsti3lDEpQpwVuswY/TWx12/YUzQ
         OP0A==
X-Gm-Message-State: AOJu0Yxtg/SUP1ngk9O3bi/to1IK0pFv1YAgJVwKqN/nahZLFuSs2zsS
	F8f2B4wzlusRMM6sKJj0la8oMQ==
X-Google-Smtp-Source: AGHT+IHDg2mX/8+mIoUoJv5lZOdY4IClX4/y+WxS3+zhFVNhCFF73U6DA57W1ux2VpGkb6k2X/2SVQ==
X-Received: by 2002:a17:902:e54e:b0:1d0:b42f:e41b with SMTP id n14-20020a170902e54e00b001d0b42fe41bmr18377215plf.64.1702898813773;
        Mon, 18 Dec 2023 03:26:53 -0800 (PST)
Received: from [10.254.38.164] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id p6-20020a170902eac600b001d3ae3df256sm2369851pld.149.2023.12.18.03.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 03:26:53 -0800 (PST)
Message-ID: <c53eb450-ebce-4ac3-91cd-59d5ae44d702@bytedance.com>
Date: Mon, 18 Dec 2023 19:26:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] mm/zswap: directly use percpu mutex and buffer in
 load/store
Content-Language: en-US
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>,
 Chris Li <chriscli@google.com>, Nhat Pham <nphamcs@gmail.com>,
 Vitaly Wool <vitaly.wool@konsulko.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Chris Li <chrisl@kernel.org>
References: <20231213-zswap-dstmem-v2-0-daa5d9ae41a7@bytedance.com>
 <20231213-zswap-dstmem-v2-6-daa5d9ae41a7@bytedance.com>
 <CAJD7tkZSrd-R-vuVqh29fgZ6bmo3EJxdb2Eahm0Ozg5hkPEjRg@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAJD7tkZSrd-R-vuVqh29fgZ6bmo3EJxdb2Eahm0Ozg5hkPEjRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2023/12/18 17:37, Yosry Ahmed wrote:
> On Mon, Dec 18, 2023 at 12:22 AM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> Since the introduce of reusing the dstmem in the load path, it seems
>> confusing that we are now using acomp_ctx->dstmem and acomp_ctx->mutex
>> now for purposes other than what the naming suggests.
>>
>> Yosry suggested removing these two fields from acomp_ctx, and directly
>> using zswap_dstmem and zswap_mutex in both the load and store paths,
>> rename them, and add proper comments above their definitions that they
>> are for generic percpu buffering on the load and store paths.
>>
>> So this patch remove dstmem and mutex from acomp_ctx, and rename the
>> zswap_dstmem to zswap_buffer, using the percpu mutex and buffer on
>> the load and store paths. And refactor out __zswap_store() to only
>> include the compress & store, since I found zswap_store() is too long.
> 
> I am not sure refactoring out __zswap_store() is useful to be honest,
> but I am not objecting to it, it mirrors __zswap_load() in a sense.

Yes, it mirrors __zswap_load() and only includes compress and store.
And it makes easy for me to only concentrate on __zswap_store/load()
when renaming the percpu buffers and mutex. But if anyone has objection,
I can drop it.

> However, if you want to do so, please do it in a separate patch from
> renaming the percpu buffers and mutex. This will make reviewing easier
> (and make my Suggested-by correctly scoped).

Right, will do.

> 
> Also, any reason why raw_smp_processor_id() is used here instead of
> smp_processor_id()?
> 

Here we don't need the CPU id stable, since we only need to pick one
CPU and use the mutex to serialize.

And from the comments below in <include/linux/smp.h>, WARN would happen
if we use smp_processor_id() here without other helpers.

 * The CPU id is stable when:
 *
 *  - IRQs are disabled;
 *  - preemption is disabled;
 *  - the task is CPU affine.

 * When CONFIG_DEBUG_PREEMPT; we verify these assumption and WARN
 * when smp_processor_id() is used when the CPU id is not stable.

Thanks!

