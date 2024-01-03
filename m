Return-Path: <linux-kernel+bounces-15281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E6A82299A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689141C23056
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22BA182B5;
	Wed,  3 Jan 2024 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="e2Kj28QL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DBE182A8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5ce0656a7bdso1728341a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 00:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704271325; x=1704876125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XUOMD+6A00d5ZGAifhjvQ+Aa1RBACk89BQgrWE9Fd40=;
        b=e2Kj28QL/qdLAJL7oND+YS1297/w3hBbDZI/ljMMAzp4W0fcRFfz3J/l0kosICOjSZ
         VtV2pB6oczDTVl2rnhXi9MAts+gmyoTV1TU1ikMAypWChbpEISiXGZ28eOY1qWCoeKGr
         LdqSrRjWMcyj8VcdtJY22J3JF+1opLn4q/XsDf0aRDutgtxgILnkFl1tM+Zh4eFMbVT+
         xkJBpihEzU46tOE35JJINyrc+f9nXnZd42NDWZTOBC+0bq10ZRepT1/GnyRWraOq6GyQ
         vP/wAr4hz9FK7UjOKPUjOtW+6paGQ2W46APn2KhNXrWflklJbJroOsv794wEF+OgJbRX
         6CEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704271325; x=1704876125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XUOMD+6A00d5ZGAifhjvQ+Aa1RBACk89BQgrWE9Fd40=;
        b=RClKf94BhoDXp5B6WFzQwdLuVLpaIskpVJ+sg5pP/ccgAdlZsO20ijWoEG7Vj7p4B0
         N9xjJ8AjGG/L7M3B59hvUjIloLQ7MB0t00DL+WAvjJ6ZJMDCmun9rl4jiw6wBbIW/ZBo
         uW9b2bxUipXaGyMXq11hi4foEn/p00ODE5/YP1aDk8nBlL7H0rgkCMId6uWVfHq98mnB
         ETGV10ynqFAj1jyG/ZbxpfTmrYxpbCEhbXlVheGFYS1Vb9BLmsRp0TD9hW7n3x9Ax4sE
         k1fN1XQOc7GSZ+V9c5eQslg16ZMx3ZHsjZ5J008HSrvNbXjMK/R1WLsNdNXwFHk0yE2n
         pvmQ==
X-Gm-Message-State: AOJu0Yzf9ojnUBa1ca9CypX0twgykJLlEfqbLvV5jbGjZ7k8xkPRWQbf
	qRKmIsiu7mNNIGqsvfx3lN5KgG3qHAvLBA==
X-Google-Smtp-Source: AGHT+IGtWGTPzGq/vswwR8+rbjSNTleUjLBqwiIAPHdD87utxDh8ABa6Gb7q5SWXBVO8zHON3CqHBg==
X-Received: by 2002:a05:6a20:ba02:b0:195:e5b9:fbe2 with SMTP id fa2-20020a056a20ba0200b00195e5b9fbe2mr4250481pzb.101.1704271324462;
        Wed, 03 Jan 2024 00:42:04 -0800 (PST)
Received: from [10.255.153.34] ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id jj20-20020a170903049400b001c61073b076sm23263005plb.144.2024.01.03.00.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 00:42:04 -0800 (PST)
Message-ID: <2251496b-4244-463c-a2aa-56ac8b696f00@bytedance.com>
Date: Wed, 3 Jan 2024 16:41:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [crypto?] general protection fault in
 scatterwalk_copychunks (5)
To: Barry Song <21cnbao@gmail.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>,
 syzbot <syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, davem@davemloft.net, herbert@gondor.apana.org.au,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, yosryahmed@google.com
References: <0000000000000b05cd060d6b5511@google.com>
 <CAKEwX=OmWYivf7dg_izW8pn5s5q15+nx-vRMsV47T_qG=dep_Q@mail.gmail.com>
 <CAF8kJuPLEXEXG+4esR6MbRa3iirTrJ7-w3YCorB9iD=gnQ+G3A@mail.gmail.com>
 <CAKEwX=PaFmreqmNrisatSN1=k2kRiYgDksgDze-t=GBD=0iJDg@mail.gmail.com>
 <CAF8kJuPF5ACu8o1P7GqEQRb6p8QShyTVNuzrrY557g+SsddzWA@mail.gmail.com>
 <CAKEwX=NHdr9=hUBiZhnLZyRPsp=JwN3Vkwud2XEn3=pNurYGpQ@mail.gmail.com>
 <f27efd2e-ac65-4f6a-b1b5-c9fb0753d871@bytedance.com>
 <CAGsJ_4x31mT8TXt4c7ejJoDW1yJhyNqDmJmLZrf2LxMt7Zwg2A@mail.gmail.com>
 <5aff3bcf-ef36-45b3-8ac0-a4b19697419c@bytedance.com>
 <CAGsJ_4zkOM4CZ4HeqXxKWv95Y4w6Bh02bvXSDpUrS4jZQMLXRw@mail.gmail.com>
Content-Language: en-US
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAGsJ_4zkOM4CZ4HeqXxKWv95Y4w6Bh02bvXSDpUrS4jZQMLXRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/1/3 14:53, Barry Song wrote:
> On Wed, Dec 27, 2023 at 7:38 PM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> On 2023/12/27 14:25, Barry Song wrote:
>>> On Wed, Dec 27, 2023 at 4:51 PM Chengming Zhou
>>> <zhouchengming@bytedance.com> wrote:
>>>>
>>>> On 2023/12/27 08:23, Nhat Pham wrote:
>>>>> On Tue, Dec 26, 2023 at 3:30 PM Chris Li <chrisl@kernel.org> wrote:
>>>>>>
>>>>>> Again, sorry I was looking at the decompression side rather than the
>>>>>> compression side. The compression side does not even offer a safe
>>>>>> version of the compression function.
>>>>>> That seems to be dangerous. It seems for now we should make the zswap
>>>>>> roll back to 2 page buffer until we have a safe way to do compression
>>>>>> without overwriting the output buffers.
>>>>>
>>>>> Unfortunately, I think this is the way - at least until we rework the
>>>>> crypto/compression API (if that's even possible?).
>>>>> I still think the 2 page buffer is dumb, but it is what it is :(
>>>>
>>>> Hi,
>>>>
>>>> I think it's a bug in `scomp_acomp_comp_decomp()`, which doesn't use
>>>> the caller passed "src" and "dst" scatterlist. Instead, it uses its own
>>>> per-cpu "scomp_scratch", which have 128KB src and dst.
>>>>
>>>> When compression done, it uses the output req->dlen to copy scomp_scratch->dst
>>>> to our dstmem, which has only one page now, so this problem happened.
>>>>
>>>> I still don't know why the alg->compress(src, slen, dst, &dlen) doesn't
>>>> check the dlen? It seems an obvious bug, right?
>>>>
>>>> As for this problem in `scomp_acomp_comp_decomp()`, this patch below
>>>> should fix it. I will set up a few tests to check later.
>>>>
>>>> Thanks!
>>>>
>>>> diff --git a/crypto/scompress.c b/crypto/scompress.c
>>>> index 442a82c9de7d..e654a120ae5a 100644
>>>> --- a/crypto/scompress.c
>>>> +++ b/crypto/scompress.c
>>>> @@ -117,6 +117,7 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
>>>>         struct crypto_scomp *scomp = *tfm_ctx;
>>>>         void **ctx = acomp_request_ctx(req);
>>>>         struct scomp_scratch *scratch;
>>>> +       unsigned int dlen;
>>>>         int ret;
>>>>
>>>>         if (!req->src || !req->slen || req->slen > SCOMP_SCRATCH_SIZE)
>>>> @@ -128,6 +129,8 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
>>>>         if (!req->dlen || req->dlen > SCOMP_SCRATCH_SIZE)
>>>>                 req->dlen = SCOMP_SCRATCH_SIZE;
>>>>
>>>> +       dlen = req->dlen;
>>>> +
>>>>         scratch = raw_cpu_ptr(&scomp_scratch);
>>>>         spin_lock(&scratch->lock);
>>>>
>>>> @@ -145,6 +148,9 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
>>>>                                 ret = -ENOMEM;
>>>>                                 goto out;
>>>>                         }
>>>> +               } else if (req->dlen > dlen) {
>>>> +                       ret = -ENOMEM;
>>>> +                       goto out;
>>>>                 }
>>>
>>> This can't fix the problem as crypto_scomp_compress() has written overflow data.
>>
>> No, crypto_scomp_compress() writes to its own scomp_scratch->dst memory, then copy
>> to our dstmem.
> 
> Hi Chengming,
> I still feel these two memcpys are too big and unnecessary, so i sent
> a RFC[1] to remove
> them as well as another one removing memcpy in zswap[2].
> but unfortunately I don't have real hardware to run and collect data,
> I wonder if you are
> interested in testing and collecting data as you are actively
> contributing to zswap.

Ok, I just tested these three patches on my server, found improvement in the
kernel build testcase on a tmpfs with zswap (lz4 + zsmalloc) enabled.

        mm-stable 501a06fe8e4c	patched
real	1m38.028s		1m32.317s
user	19m11.482s		18m39.439s
sys	19m26.445s		17m5.646s

The improvement looks good! So feel free to add:

Tested-by: Chengming Zhou <zhouchengming@bytedance.com>

Thanks.

> 
> [1] https://lore.kernel.org/linux-mm/20240103053134.564457-1-21cnbao@gmail.com/
> [2]
> https://lore.kernel.org/linux-mm/20240103025759.523120-1-21cnbao@gmail.com/
> https://lore.kernel.org/linux-mm/20240103025759.523120-2-21cnbao@gmail.com/
> 
> Thanks
> Barry

