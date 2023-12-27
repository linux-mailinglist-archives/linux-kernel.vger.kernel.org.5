Return-Path: <linux-kernel+bounces-11867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3640E81ECA8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1981C2231B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA115255;
	Wed, 27 Dec 2023 06:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eeOHlLsf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD175228
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 06:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d099d316a8so4645796b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 22:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1703659111; x=1704263911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W0KmYt6leKPGTS8gsdFNq3/xtqnx97svAIcF690BCi4=;
        b=eeOHlLsfeukSqfUfqXnTDHUJ026M0o+F3kc5XjSosGiEZ4xoaWoZfM+27zgzRIK0SR
         KgAM8NaYJM9V3jXSrivNhTQ2jHrOJImiYBS8CtkqpLNx5a1sQ/Oc9qZmLx5FKQWnEoN8
         ex9WSaqnYT0kJr/Qzky9x9bHUKbnZNXIhhEb5KMM43PHq4BBH+VA+H/ygWe4+K4t+9Pr
         cZy0SUF6f8f8KDpXEAlA3y1Pn4rHu12Qn7wbHRrtQt+lnbfta1SMlu8yaeXMejfsdNK7
         s94ecvjHSn8K+ClPIBbSY0lyR+bw4Jpae38Fjs/SiSnZX3jVlsia0JpvPZtHFTwoRArt
         dAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703659111; x=1704263911;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W0KmYt6leKPGTS8gsdFNq3/xtqnx97svAIcF690BCi4=;
        b=uZF7mRgAUHz0y6OWsXluYhKwsb+MmFUnL7CGdqz9ZGQDtuVZSN7pXFr6bDgX/Tuo9Y
         6b2T8NNUFq/snE3nAx6ci7ApAzmpQJfep6UZHJ2WQvNGhZFaZSh4J+R0CzgeqO+AT5Ot
         t6sZhFDj2w/tXhLd7nNQ+78W8vc8cEAO3BJ0qXIdgQd/y2jb+M4LrtxCB5F1pzbkiTkz
         z/7F/TFCa31+b/DRFUjBZpA02SNEmq4X1BGr8MNCeGI8qOdgaYBwFHKRQuOSQkx4oDQs
         RVqrLEXfCXHoe9Xhx6i/xlJNqewaU8xgtaQVeLC4fWpEwnwoW6E57IyQaZ+EbPk2M0eQ
         qLLw==
X-Gm-Message-State: AOJu0Yymj2Mv6G64N7P3pOfkfC/Q4lpnqcPN7TiRisextbeZNCMW0Fbp
	qkA6JKnx01mQzQO1jhlBOwTLBuIszG13mw==
X-Google-Smtp-Source: AGHT+IEMacNb4e7c2rVDbyCMMkCfOGpmFuEeBtxkp/nShuPR1YHD3gsEeJjCsuU9R+d3/MZWcDHEIQ==
X-Received: by 2002:a05:6a00:6a04:b0:6d9:9277:b702 with SMTP id hy4-20020a056a006a0400b006d99277b702mr7200446pfb.1.1703659111130;
        Tue, 26 Dec 2023 22:38:31 -0800 (PST)
Received: from [10.254.10.159] ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id n12-20020a056a0007cc00b006d9aaf468c1sm6342026pfu.203.2023.12.26.22.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Dec 2023 22:38:30 -0800 (PST)
Message-ID: <5aff3bcf-ef36-45b3-8ac0-a4b19697419c@bytedance.com>
Date: Wed, 27 Dec 2023 14:38:24 +0800
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
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAGsJ_4x31mT8TXt4c7ejJoDW1yJhyNqDmJmLZrf2LxMt7Zwg2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2023/12/27 14:25, Barry Song wrote:
> On Wed, Dec 27, 2023 at 4:51 PM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
>>
>> On 2023/12/27 08:23, Nhat Pham wrote:
>>> On Tue, Dec 26, 2023 at 3:30 PM Chris Li <chrisl@kernel.org> wrote:
>>>>
>>>> Again, sorry I was looking at the decompression side rather than the
>>>> compression side. The compression side does not even offer a safe
>>>> version of the compression function.
>>>> That seems to be dangerous. It seems for now we should make the zswap
>>>> roll back to 2 page buffer until we have a safe way to do compression
>>>> without overwriting the output buffers.
>>>
>>> Unfortunately, I think this is the way - at least until we rework the
>>> crypto/compression API (if that's even possible?).
>>> I still think the 2 page buffer is dumb, but it is what it is :(
>>
>> Hi,
>>
>> I think it's a bug in `scomp_acomp_comp_decomp()`, which doesn't use
>> the caller passed "src" and "dst" scatterlist. Instead, it uses its own
>> per-cpu "scomp_scratch", which have 128KB src and dst.
>>
>> When compression done, it uses the output req->dlen to copy scomp_scratch->dst
>> to our dstmem, which has only one page now, so this problem happened.
>>
>> I still don't know why the alg->compress(src, slen, dst, &dlen) doesn't
>> check the dlen? It seems an obvious bug, right?
>>
>> As for this problem in `scomp_acomp_comp_decomp()`, this patch below
>> should fix it. I will set up a few tests to check later.
>>
>> Thanks!
>>
>> diff --git a/crypto/scompress.c b/crypto/scompress.c
>> index 442a82c9de7d..e654a120ae5a 100644
>> --- a/crypto/scompress.c
>> +++ b/crypto/scompress.c
>> @@ -117,6 +117,7 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
>>         struct crypto_scomp *scomp = *tfm_ctx;
>>         void **ctx = acomp_request_ctx(req);
>>         struct scomp_scratch *scratch;
>> +       unsigned int dlen;
>>         int ret;
>>
>>         if (!req->src || !req->slen || req->slen > SCOMP_SCRATCH_SIZE)
>> @@ -128,6 +129,8 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
>>         if (!req->dlen || req->dlen > SCOMP_SCRATCH_SIZE)
>>                 req->dlen = SCOMP_SCRATCH_SIZE;
>>
>> +       dlen = req->dlen;
>> +
>>         scratch = raw_cpu_ptr(&scomp_scratch);
>>         spin_lock(&scratch->lock);
>>
>> @@ -145,6 +148,9 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
>>                                 ret = -ENOMEM;
>>                                 goto out;
>>                         }
>> +               } else if (req->dlen > dlen) {
>> +                       ret = -ENOMEM;
>> +                       goto out;
>>                 }
> 
> This can't fix the problem as crypto_scomp_compress() has written overflow data.

No, crypto_scomp_compress() writes to its own scomp_scratch->dst memory, then copy
to our dstmem.

> 
> BTW, in many cases, hardware-accelerators drivers/crypto can do compression and
> decompression by off-loading CPU;
> we won't have a chance to let hardware check the dst buffer size. so
> giving the dst buffer
> with enough length to the hardware's dma engine is the right way. I
> mean, we shouldn't
> change dst from 2pages to 1page.

But how do we know 2 pages is enough for any compression algorithm?

Thanks.

> 
>>                 scatterwalk_map_and_copy(scratch->dst, req->dst, 0, req->dlen,
>>                                          1);
> 
> 
> Thanks
> Barry

