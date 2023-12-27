Return-Path: <linux-kernel+bounces-11809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0127381EBF3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 04:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2551E1C2129E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 03:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BAB3C3F;
	Wed, 27 Dec 2023 03:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hU2dmQ93"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED183C0D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 03:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6dbff975a2aso469696a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 19:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1703649098; x=1704253898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=reORFa1TwZDZzjEgWJpjbpsKpL4fAljPjBgD+hVKVJk=;
        b=hU2dmQ93D3n7mAwObNfHNnvbE/HkzuW26DA4hFruXO4F+l4sztz1hiWV1YVaUwXSRT
         a86AjqZsqxDnp0vHTxW6N3i6NmN4PCSlgO1eOp48C0urxd4wUHbdXPiZe2AByUF743LG
         0RsoOxAFaRKjN0AVBSdfjV+l2o7kmVq71ec+h2oMaxZF+Rg01TW+USNi5aDSKsv6PwFY
         8eOQag1AnxXyJFVQAHZxfik1eVhd0qsDNWZWZuRl7hAMvd4LJxw4nIleG1Y9aa2KkXoz
         WOSnOc/bPaSeznjdIL1Lhv+MMcRl2Lv9utwQW/2BSHlXbA2ybD20hs7vWCczBNIH0F9l
         lbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703649098; x=1704253898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=reORFa1TwZDZzjEgWJpjbpsKpL4fAljPjBgD+hVKVJk=;
        b=KAS2urzQorbj5ySZl46SQAgwsoz29sCCjW2nv7V7Bm5tKXGRC4UpCi4IATIoU45GC0
         nMr6GDKS4ffE1fC45uInXYt1AVoCJiSVZO3htlvzyF0hY0xkhqEiT56qJg2DbTNuhAe1
         zUd/ithb7MIDLY1c6HjgTpMb+HDvG3dss3jfNNnyyZAFQ1e7i1Zmu1GVrvL15DkzZS7K
         KUOV5Fus1vLv8wtpJRsBsBqOylJBoI19j6Z+cmGxjJ4Pw7KOJbiuwtM6emyzH0xeZSAT
         kLx0zSBLngmpa9ydue5MW2UzBURc2hfq3Vdbm3LU07ACfy3jSm5KnI8rz4cRKbYF/2hN
         t7fA==
X-Gm-Message-State: AOJu0YyPpcc053/ULgAbwP2LMDYWB81NpRxNLXb1CLnOLFztXl/8y7yG
	GaJnWe2hqTMjKncMup6P8MQXVNlWaGSMuA==
X-Google-Smtp-Source: AGHT+IHsOaVjT3F8LcJBDltNKHVmej/2YzvoPIbersq8N/MJhN80Uw+LY6nNoHDtNvYGn9+jHBdOcg==
X-Received: by 2002:a05:6808:120e:b0:3ba:a85:42b2 with SMTP id a14-20020a056808120e00b003ba0a8542b2mr11245601oil.58.1703649098602;
        Tue, 26 Dec 2023 19:51:38 -0800 (PST)
Received: from [10.254.10.159] ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id b15-20020aa78ecf000000b006d9a7a48bbesm6304822pfr.116.2023.12.26.19.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Dec 2023 19:51:38 -0800 (PST)
Message-ID: <f27efd2e-ac65-4f6a-b1b5-c9fb0753d871@bytedance.com>
Date: Wed, 27 Dec 2023 11:51:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [crypto?] general protection fault in
 scatterwalk_copychunks (5)
Content-Language: en-US
To: Nhat Pham <nphamcs@gmail.com>, Chris Li <chrisl@kernel.org>,
 21cnbao@gmail.com
Cc: syzbot <syzbot+3eff5e51bf1db122a16e@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, davem@davemloft.net, herbert@gondor.apana.org.au,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, yosryahmed@google.com
References: <0000000000000b05cd060d6b5511@google.com>
 <CAKEwX=OmWYivf7dg_izW8pn5s5q15+nx-vRMsV47T_qG=dep_Q@mail.gmail.com>
 <CAF8kJuPLEXEXG+4esR6MbRa3iirTrJ7-w3YCorB9iD=gnQ+G3A@mail.gmail.com>
 <CAKEwX=PaFmreqmNrisatSN1=k2kRiYgDksgDze-t=GBD=0iJDg@mail.gmail.com>
 <CAF8kJuPF5ACu8o1P7GqEQRb6p8QShyTVNuzrrY557g+SsddzWA@mail.gmail.com>
 <CAKEwX=NHdr9=hUBiZhnLZyRPsp=JwN3Vkwud2XEn3=pNurYGpQ@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAKEwX=NHdr9=hUBiZhnLZyRPsp=JwN3Vkwud2XEn3=pNurYGpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2023/12/27 08:23, Nhat Pham wrote:
> On Tue, Dec 26, 2023 at 3:30 PM Chris Li <chrisl@kernel.org> wrote:
>>
>> Again, sorry I was looking at the decompression side rather than the
>> compression side. The compression side does not even offer a safe
>> version of the compression function.
>> That seems to be dangerous. It seems for now we should make the zswap
>> roll back to 2 page buffer until we have a safe way to do compression
>> without overwriting the output buffers.
> 
> Unfortunately, I think this is the way - at least until we rework the
> crypto/compression API (if that's even possible?).
> I still think the 2 page buffer is dumb, but it is what it is :(

Hi,

I think it's a bug in `scomp_acomp_comp_decomp()`, which doesn't use
the caller passed "src" and "dst" scatterlist. Instead, it uses its own
per-cpu "scomp_scratch", which have 128KB src and dst.

When compression done, it uses the output req->dlen to copy scomp_scratch->dst
to our dstmem, which has only one page now, so this problem happened.

I still don't know why the alg->compress(src, slen, dst, &dlen) doesn't
check the dlen? It seems an obvious bug, right?

As for this problem in `scomp_acomp_comp_decomp()`, this patch below
should fix it. I will set up a few tests to check later.

Thanks!

diff --git a/crypto/scompress.c b/crypto/scompress.c
index 442a82c9de7d..e654a120ae5a 100644
--- a/crypto/scompress.c
+++ b/crypto/scompress.c
@@ -117,6 +117,7 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
        struct crypto_scomp *scomp = *tfm_ctx;
        void **ctx = acomp_request_ctx(req);
        struct scomp_scratch *scratch;
+       unsigned int dlen;
        int ret;

        if (!req->src || !req->slen || req->slen > SCOMP_SCRATCH_SIZE)
@@ -128,6 +129,8 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
        if (!req->dlen || req->dlen > SCOMP_SCRATCH_SIZE)
                req->dlen = SCOMP_SCRATCH_SIZE;

+       dlen = req->dlen;
+
        scratch = raw_cpu_ptr(&scomp_scratch);
        spin_lock(&scratch->lock);

@@ -145,6 +148,9 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
                                ret = -ENOMEM;
                                goto out;
                        }
+               } else if (req->dlen > dlen) {
+                       ret = -ENOMEM;
+                       goto out;
                }
                scatterwalk_map_and_copy(scratch->dst, req->dst, 0, req->dlen,
                                         1);

