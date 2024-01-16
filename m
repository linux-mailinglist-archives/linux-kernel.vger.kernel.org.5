Return-Path: <linux-kernel+bounces-26941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8DB82E83E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7AC284D33
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 03:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BDC8493;
	Tue, 16 Jan 2024 03:27:55 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C453179C1;
	Tue, 16 Jan 2024 03:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.9.175.10])
	by gateway (Coremail) with SMTP id _____8Axjuu296Vld48AAA--.2549S3;
	Tue, 16 Jan 2024 11:27:50 +0800 (CST)
Received: from Board-3A3000 (unknown [111.9.175.10])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxAOWy96VlBzADAA--.649S2;
	Tue, 16 Jan 2024 11:27:48 +0800 (CST)
Date: Tue, 16 Jan 2024 11:27:46 +0800
From: Huang Pei <huangpei@loongson.cn>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: rppt@kernel.org, linux-mm@kvack.org, Bibo Mao <maobibo@loongson.cn>,
	linux-mips@vger.kernel.org, Paul Burton <paulburton@kernel.org>,
	Li Xuefeng <lixuefeng@loongson.cn>,
	Yang Tiezhu <yangtiezhu@loongson.cn>,
	Gao Juxin <gaojuxin@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kernel@vger.kernel.org
Subject: Re: memblock_reserve for unadded region (was: [PATCH] MIPS:
 loongson64: fix boot failure)
Message-ID: <20240116032746.rh2jh6gihykzorg5@Board-3A3000>
References: <20231225093025.23215-1-huangpei@loongson.cn>
 <731134fd-4b3d-418c-84ee-80646bffcc01@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <731134fd-4b3d-418c-84ee-80646bffcc01@flygoat.com>
X-CM-TRANSID:AQAAf8CxAOWy96VlBzADAA--.649S2
X-CM-SenderInfo: xkxd0whshlqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF48Zr4UtrW3GFyUXF13trc_yoWrKw17pr
	13JF17Cr48Jr1UXrW8Jr15Wr1xXa1Fk3WUJrZrJr18uF1Dur17Xr18JryrXFyDJrWUGF1I
	qFyDXr1jvw1DAwcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
	6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_
	JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU
	0xZFpf9x07jepB-UUUUU=

On Mon, Jan 15, 2024 at 02:08:21PM +0000, Jiaxun Yang wrote:
> Hi mm folks,
> 
> Just a quick question, what is the expected behavior of memblock_reserve
> a region that is not added to memblock with memblock_add?
> 
> I'm unable to find any documentation about memblock_reserve in comments and
> boot-time-mm, but as per my understanding to the code, this should be a
> legit usage?
> 
> In practical we run into uninitialized nid of reserved block problem, should
> we fix it
> in our usage, or on memblock side?
> 
> Thanks

I have same question. Kernel make a dmi info(see dmi_string, or add
memblock=debug) copy.

If reserved SMIBIOS memory belong to kernel, no need to make a copy.

But if not, how could it be included in a range of memblock.memory?

> 
> 在 2023/12/25 09:30, Huang Pei 写道:
> > Since commit 61167ad5fecd("mm: pass nid to reserve_bootmem_region()),
> > loongson64 booting failed with CONFIG_DEFERRED_STRUCT_PAGE_INIT like
> > this:
> > ----------------------------------------------------------------------
> >   Call Trace:
> >   [<ffffffff8235d088>] reserve_bootmem_region+0xa8/0x184
> >   [<ffffffff82333940>] memblock_free_all+0x104/0x2a8
> >   [<ffffffff8231d8e4>] mem_init+0x84/0x94
> >   [<ffffffff82330958>] mm_core_init+0xf8/0x308
> >   [<ffffffff82318c38>] start_kernel+0x43c/0x86c
> > 
> >   Code: 10400028  2402fff0  de420000 <dc432880> 0203182b 14600022
> >   64420070  00003025  24040003
> > 
> >   ---[ end trace 0000000000000000 ]---
> >   Kernel panic - not syncing: Attempted to kill the idle task!
> >   ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
> > ----------------------------------------------------------------------
> > 
> > The root cause is no memory region "0x0-0x1fffff" paired with
> > memory-reserved region "0x0-0x1fffff" and "0x0-0xfff", with "memblock
> > =debug":
> > 
> > ----------------------------------------------------------------------
> >    memory[0x0]     [0x0000000000200000-0x000000000effffff],
> >    0x000000000ee00000 bytes on node 0 flags: 0x0 !!!!here
> >    memory[0x1]     [0x0000000090000000-0x00000000fdffffff],
> >    0x000000006e000000 bytes on node 0 flags: 0x0
> >    memory[0x2]     [0x0000000100000000-0x000000027fffffff],
> >    0x0000000180000000 bytes on node 0 flags: 0x0
> >    memory[0x3]     [0x0000100000000000-0x000010000fffffff],
> >    0x0000000010000000 bytes on node 1 flags: 0x0
> >    memory[0x4]     [0x0000100090000000-0x000010027fffffff],
> >    0x00000001f0000000 bytes on node 1 flags: 0x0
> >    reserved.cnt  = 0x1f
> >    reserved[0x0]   [0x0000000000000000-0x000000000190c80a],
> >    0x000000000190c80b bytes flags: 0x0 !!!!oops 0x0-0x1fffff not in memory[0]
> >    reserved[0x1]   [0x000000000190c810-0x000000000190eea3],
> >    0x0000000000002694 bytes flags: 0x0
> > ----------------------------------------------------------------------
> > 
> > It caused memory-reserved region "0x0-0x1fffff" without valid node id
> > in "memblock_get_region_node" from "memmap_init_reserved_pages", lead to
> > "reserve_bootmem_region-> init_reserved_page -> early_pfn_to_nid()"
> > accessing "node_data" out of bound.
> > 
> > To fix this bug, we should remove unnecessary memory block reservation.
> > 
> > +. no need to reserve 0x0-0x1fffff below kernel loading address, since
> > it is not registered by "memblock_add_node"
> > 
> > +. no need to reserve 0x0-0xfff for exception handling if it is not
> > registered by "memblock_add" either.
> > 
> > Fixes: commit 61167ad5fecd("mm: pass nid to reserve_bootmem_region())
> > Signed-off-by: Huang Pei <huangpei@loongson.cn>
> > ---
> >   arch/mips/kernel/traps.c    | 3 ++-
> >   arch/mips/loongson64/numa.c | 2 --
> >   2 files changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> > index 246c6a6b0261..9b632b4c10c3 100644
> > --- a/arch/mips/kernel/traps.c
> > +++ b/arch/mips/kernel/traps.c
> > @@ -2007,7 +2007,8 @@ unsigned long vi_handlers[64];
> >   void reserve_exception_space(phys_addr_t addr, unsigned long size)
> >   {
> > -	memblock_reserve(addr, size);
> > +	if(memblock_is_region_memory(addr, size))
> > +		memblock_reserve(addr, size);
> >   }
> >   void __init *set_except_vector(int n, void *addr)
> > diff --git a/arch/mips/loongson64/numa.c b/arch/mips/loongson64/numa.c
> > index 8f61e93c0c5b..0f516dde81da 100644
> > --- a/arch/mips/loongson64/numa.c
> > +++ b/arch/mips/loongson64/numa.c
> > @@ -130,8 +130,6 @@ static void __init node_mem_init(unsigned int node)
> >   			memblock_reserve((node_addrspace_offset | 0xfe000000),
> >   					 32 << 20);
> > -		/* Reserve pfn range 0~node[0]->node_start_pfn */
> > -		memblock_reserve(0, PAGE_SIZE * start_pfn);
> >   	}
> >   }
> 
> -- 
> ---
> Jiaxun Yang


