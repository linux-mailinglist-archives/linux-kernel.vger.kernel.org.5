Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015067A9816
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjIURaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjIUR3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:29:03 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199394CB32;
        Thu, 21 Sep 2023 10:14:51 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bffc55af02so21366791fa.2;
        Thu, 21 Sep 2023 10:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695316490; x=1695921290; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PT7BtDLW9rg1Fg+vRZKPaEJl+Jt/zEwGch4+5k14AJA=;
        b=jbTXabZFaLasSJgCpvAUWon2To2ZzV3zfOiWkLo8Ex8+zHD2pWle9/dawKl+y5w+VG
         jDGWAUTp25OnC/oqhGoCix9eu/5vtieZytoAXW0Zance5sjmhWY8dQCa2TbMDyOUm1Mj
         QOFPjVEXWZYGceZJvj01yqMckvLHDWt4V60btBPzHsrtvc0dACSlOyAPvivJ9Xj2eQX8
         Fj1nF8xK/FHSoABdTLtJrqy2SgQnVjKWhNSNIK58ejdWLab0bS1/1gaENvcZbJoGu2gA
         KEUFx4K2VuYnt/upx6fM4k9M9GhHCSJm1T6EiKZy2CoOQ/zTcxIZH/zHK1NwTzGqNWZM
         017g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316490; x=1695921290;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PT7BtDLW9rg1Fg+vRZKPaEJl+Jt/zEwGch4+5k14AJA=;
        b=QXW6vtjPi2ZCND6KOwAq32eKGnpVKhQqlgGWmLr+wwfd35EPldFT/A30/0HwVZdbOB
         jbOuUkHBwNrMDtz2rMydCtfPSgyDHrIElovUnEabLBXE2xnn/sDNlIpz1bH2ON8E4ZxE
         7FRl9AwpitFn5BYDwpie2VwEFnO3mul/zOx0+z9yrlsr9pXoE6SXMlaAagcZ5QPr/a77
         S1OVaqkLM+vxjt8OjCO5qLjg0gxhDObWVbIgyakjU5I/0rztvpav3SuOyrsI15fqnscy
         4SlZ45IhX+wVmxtH/B+LjtULfDq6kQ2THSrwXuJZk/BhCRC2e+odyvA2BDRUZNFceVfj
         2ddw==
X-Gm-Message-State: AOJu0YxUvPaQyBAP+9O6qlv5pea3U8gYx1FnQ6pRrubZcwUaum3tPCrH
        C90ishhVue3gntAYatqnDb83KQgqSzigYopAEhY=
X-Google-Smtp-Source: AGHT+IHh/1wwPrkBE5tRlQhDTSHXcqJ71kW307h+QJbF0bmMxsCiJ7umyPGEEJzsfhPmdwuJd+L4lA==
X-Received: by 2002:adf:e490:0:b0:319:735c:73e1 with SMTP id i16-20020adfe490000000b00319735c73e1mr4959090wrm.4.1695306820635;
        Thu, 21 Sep 2023 07:33:40 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id e24-20020a5d5958000000b00317ab75748bsm1916735wri.49.2023.09.21.07.33.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Sep 2023 07:33:40 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Xu Kuohai <xukuohai@huaweicloud.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        bpf@vger.kernel.org, kpsingh@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 1/3] arm64: patching: Add aarch64_insn_copy()
In-Reply-To: <9084901f-730c-cf33-9337-f18a3c17283f@huaweicloud.com>
References: <20230908144320.2474-1-puranjay12@gmail.com>
 <20230908144320.2474-2-puranjay12@gmail.com>
 <9084901f-730c-cf33-9337-f18a3c17283f@huaweicloud.com>
Date:   Thu, 21 Sep 2023 14:33:34 +0000
Message-ID: <mb61pil83a94x.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xu Kuohai <xukuohai@huaweicloud.com> writes:

> On 9/8/2023 10:43 PM, Puranjay Mohan wrote:
>> This will be used by BPF JIT compiler to dump JITed binary to a RX huge
>> page, and thus allow multiple BPF programs sharing the a huge (2MB)
>> page.
>> 
>> The bpf_prog_pack allocator that implements the above feature allocates
>> a RX/RW buffer pair. The JITed code is written to the RW buffer and then
>> this function will be used to copy the code from RW to RX buffer.
>> 
>> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>> Acked-by: Song Liu <song@kernel.org>
>> ---
>>   arch/arm64/include/asm/patching.h |  1 +
>>   arch/arm64/kernel/patching.c      | 41 +++++++++++++++++++++++++++++++
>>   2 files changed, 42 insertions(+)
>> 
>> diff --git a/arch/arm64/include/asm/patching.h b/arch/arm64/include/asm/patching.h
>> index 68908b82b168..f78a0409cbdb 100644
>> --- a/arch/arm64/include/asm/patching.h
>> +++ b/arch/arm64/include/asm/patching.h
>> @@ -8,6 +8,7 @@ int aarch64_insn_read(void *addr, u32 *insnp);
>>   int aarch64_insn_write(void *addr, u32 insn);
>>   
>>   int aarch64_insn_write_literal_u64(void *addr, u64 val);
>> +void *aarch64_insn_copy(void *dst, const void *src, size_t len);
>>   
>>   int aarch64_insn_patch_text_nosync(void *addr, u32 insn);
>>   int aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt);
>> diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
>> index b4835f6d594b..243d6ae8d2d8 100644
>> --- a/arch/arm64/kernel/patching.c
>> +++ b/arch/arm64/kernel/patching.c
>> @@ -105,6 +105,47 @@ noinstr int aarch64_insn_write_literal_u64(void *addr, u64 val)
>>   	return ret;
>>   }
>>   
>> +/**
>> + * aarch64_insn_copy - Copy instructions into (an unused part of) RX memory
>> + * @dst: address to modify
>> + * @src: source of the copy
>> + * @len: length to copy
>> + *
>> + * Useful for JITs to dump new code blocks into unused regions of RX memory.
>> + */
>> +noinstr void *aarch64_insn_copy(void *dst, const void *src, size_t len)
>> +{
>> +	unsigned long flags;
>> +	size_t patched = 0;
>> +	size_t size;
>> +	void *waddr;
>> +	void *ptr;
>> +	int ret;
>> +
>
> check whether the input address and length are aligned to instruction size?

Will add a check that dst is aligned to instruction size and len is a
multiple of instruction size.

>
>> +	raw_spin_lock_irqsave(&patch_lock, flags);
>> +
>> +	while (patched < len) {
>> +		ptr = dst + patched;
>> +		size = min_t(size_t, PAGE_SIZE - offset_in_page(ptr),
>> +			     len - patched);
>> +
>> +		waddr = patch_map(ptr, FIX_TEXT_POKE0);
>> +		ret = copy_to_kernel_nofault(waddr, src + patched, size);
>> +		patch_unmap(FIX_TEXT_POKE0);
>> +
>> +		if (ret < 0) {
>> +			raw_spin_unlock_irqrestore(&patch_lock, flags);
>> +			return NULL;
>> +		}
>> +		patched += size;
>> +	}
>> +	raw_spin_unlock_irqrestore(&patch_lock, flags);
>> +
>> +	caches_clean_inval_pou((uintptr_t)dst, (uintptr_t)dst + len);
>> +
>
> seems flush_icache_range() or something like should be called here to
> ensure the other CPUs' pipelines are cleared, otherwise the old instructions
> at the dst address might be executed on other CPUs after the copy is complete,
> which is not expected.

Sure, I will use flush_icache_range() in place of
caches_clean_inval_pou() in the next version 

>
>> +	return dst;
>> +}
>> +
>>   int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
>>   {
>>   	u32 *tp = addr;
