Return-Path: <linux-kernel+bounces-11924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 110E581EDA5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 342861C216F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 09:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9096D286B5;
	Wed, 27 Dec 2023 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VGlLKZHs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F349D241EC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 09:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d420aaa2abso12568235ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 01:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1703668560; x=1704273360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f91KsRb4g73o9XLwWJe5WREbxIqOUCrliXJFtsA5gvY=;
        b=VGlLKZHsFNiBaZ3kSAXQkNcCI+RAoQD+/crkX7wEWGJ9A/3S5elW/cn2wkYY1NFux2
         2mgyalofVZrgO+uUZuhokjLVl8T0Bijahz4z47AYujTn/snsBDzZ4sF3c8QibhFEzxqL
         P3QtOgJuXr+8TiLbQqDWFg8Uf3i/019B9Yg0QyV2scKHAJHgtyqtiFbMFVNCfvmOeGaD
         zQvI3YlAOGUinmK+KR4wfbm0ImUdufaAEZyWcxsKtq/vwdeEge6Q+dLEODp1atANfDl5
         XNaTzcpaeCjf8XN0pJ4k4bm65VrNrnnY8EqUyjvDRR4z491Fv4a6yrGGES16xJi2TZpm
         R1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703668560; x=1704273360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f91KsRb4g73o9XLwWJe5WREbxIqOUCrliXJFtsA5gvY=;
        b=mXOXd0T7RX+65cxWZJoJLKs9+IDbU3S9RNGZysBU7W66+SV0pEvx+yrWEwngJhL7H2
         A/K6fuhDKqqlCJPTsLlZkTqMcgQQmkh7CxNwb8vaWsNqjXVmmw0KnCWUCzmvBWsSfHRs
         41MvUuUd7ZFPOKpKgHmMk92JHJYaYaAZCiGXF0jjVWstBPVSBgyeg52TZZDCIYIDcfmX
         OcqZHh4NqZEh8NRfMuih5NgWKVvQ5M4SFRIzvM5OPQUpNrD/5xY6exXpm/G2+IdI0ZvX
         9V6JPf3sf6biXvX/L7HAC/6QuS8O5rEtRn1bhb/9M7Wtve7Q2i8iFCWJwGu1UN+xFWr4
         ka0g==
X-Gm-Message-State: AOJu0YxrhJIcaIKa02rzQf567CsumOgfLv+iooIPvUlyl1fJ4uqz4UnP
	J3UCVnUKf4k0FdKgDQrrbYPzEEPCazixEg==
X-Google-Smtp-Source: AGHT+IFTgbMkjU3aBqRgdPpkGqFocnZJuRL/30JcwjDTZ9G8D5nbib9SdYIcheVYTMlSLtr0qZhkDA==
X-Received: by 2002:a17:903:41ce:b0:1d4:53cf:fb99 with SMTP id u14-20020a17090341ce00b001d453cffb99mr1743507ple.24.1703668560197;
        Wed, 27 Dec 2023 01:16:00 -0800 (PST)
Received: from [10.254.96.216] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id n10-20020a1709026a8a00b001d3e3704d2fsm11452826plk.31.2023.12.27.01.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 01:15:59 -0800 (PST)
Message-ID: <e464c55e-d03a-4df9-abef-5ece182d7a2b@bytedance.com>
Date: Wed, 27 Dec 2023 17:15:54 +0800
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
 <5aff3bcf-ef36-45b3-8ac0-a4b19697419c@bytedance.com>
 <CAGsJ_4xuuaPnQzkkQVaRyZL6ZdwkiQ_B7_c2baNaCKVg_O7ZQA@mail.gmail.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <CAGsJ_4xuuaPnQzkkQVaRyZL6ZdwkiQ_B7_c2baNaCKVg_O7ZQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2023/12/27 15:01, Barry Song wrote:
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
>>
>>>
>>> BTW, in many cases, hardware-accelerators drivers/crypto can do compression and
>>> decompression by off-loading CPU;
>>> we won't have a chance to let hardware check the dst buffer size. so
>>> giving the dst buffer
>>> with enough length to the hardware's dma engine is the right way. I
>>> mean, we shouldn't
>>> change dst from 2pages to 1page.
>>
>> But how do we know 2 pages is enough for any compression algorithm?
>>
> 
> There is no guarrette 2 pages is enough.
> 
> We can invent our own compression algorithm, in our algorithm, we can
> add a lot of metadata, for example, longer than 4KB when the source data
> is uncompress-able. then dst can be larger than 2 * PAGE_SIZE.  but this
> is not the case :-) This kind of algorithm may never succeed.
> 
> For those in-tree algorithms, we have a WORST_COMPR_FACTOR. in
> ubifs, zram and zswap, we all use "2" as the worst comp factor.

Thanks for your explanation! Maybe it's best for us to return to 2 pages
if no other people's comments. And this really need more documentation :-)
since there is no any comment or check in the acomp compress interface.

/*
 * @src:	Source Data
 * @dst:	Destination data
 * @slen:	Size of the input buffer
 * @dlen:	Size of the output buffer and number of bytes produced
 * @flags:	Internal flags
 * @__ctx:	Start of private context data
 */
struct acomp_req {
	struct crypto_async_request base;
	struct scatterlist *src;
	struct scatterlist *dst;
	unsigned int slen;
	unsigned int dlen;
	u32 flags;
	void *__ctx[] CRYPTO_MINALIGN_ATTR;
};

> 
> /*
>  * Some compressors, like LZO, may end up with more data then the input buffer.
>  * So UBIFS always allocates larger output buffer, to be sure the compressor
>  * will not corrupt memory in case of worst case compression.
>  */
> #define WORST_COMPR_FACTOR 2
> 
> #ifdef CONFIG_FS_ENCRYPTION
> #define UBIFS_CIPHER_BLOCK_SIZE FSCRYPT_CONTENTS_ALIGNMENT
> #else
> #define UBIFS_CIPHER_BLOCK_SIZE 0
> #endif
> 
> /*
>  * How much memory is needed for a buffer where we compress a data node.
>  */
> #define COMPRESSED_DATA_NODE_BUF_SZ \
>         (UBIFS_DATA_NODE_SZ + UBIFS_BLOCK_SIZE * WORST_COMPR_FACTOR)
> 
> 
> For years, we have never seen 2 pages that can be a problem. but 1
> page is definitely
> not enough, I remember I once saw many cases where accelerators' dmaengine
> can write more than 1 page.
> 
>> Thanks.
>>
>>>
>>>>                 scatterwalk_map_and_copy(scratch->dst, req->dst, 0, req->dlen,
>>>>                                          1);
>>>
>>>
> 
> Thanks
> Barry

