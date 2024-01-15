Return-Path: <linux-kernel+bounces-26073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAFD82DB00
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAB1AB2183B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073D31758A;
	Mon, 15 Jan 2024 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="vq/HV1pr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xMFlJ6Gt"
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E451757A;
	Mon, 15 Jan 2024 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 0A22B3200AA6;
	Mon, 15 Jan 2024 09:08:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 15 Jan 2024 09:08:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1705327705;
	 x=1705414105; bh=0d0cNX45c0k/Z7r10RBxHdCHQsWb9L2TKadpx8b3xsg=; b=
	vq/HV1prHpPllBsgQngOpmV3rgtPm+E4zlCjcV4IDwRRd4H9oo1BjUMXKURqd5VP
	kcTyH+kVpI7X4/83pZ9O26kNwWnUip7gQwNzqFAvPM026HHJYcZC0NNKYY8MjD9Z
	ZRRwz+8yarBIDortly+fhSTKstPBnp35hxo7ECbDX8mE69kMJ/tQRusSFciMRoWF
	ToxWH+h5sgXhzXBacFWFlNHDywAI4L1LcqMHbgtzmmQWhRD5CafanO9SVneA3pnX
	X0+Y3WapzT9pGnGJ6DF36Tcm+1jhaCd3+m7fo4JXVVypP3wUh75WEqm3bsFO7MIV
	hu0sRXRCT1xheFkUzYIn2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705327705; x=
	1705414105; bh=0d0cNX45c0k/Z7r10RBxHdCHQsWb9L2TKadpx8b3xsg=; b=x
	MFlJ6GtNN7VBk+AkLk8gDCsc05SHTMXZ1JXe45VX6xHfAK77JsL1/di4KjxibkQx
	BtL62ISyA9PKvxbvuk/6Efhym+VoHEk5lO37E5xmDkkSi1M4EkX7k8g3onGXW3mX
	prPFoFGv/1bqSUBhzf1wKVXJhzZ/0kPA9dMfYFPtPKpRtNkrznx0lpto0gNXkxhu
	s21+IXnrhcxMYiV2YgInlCChBJLQ6ksjlTzG+4C6EnUIUaIgzkdKe77T87vUDzh2
	EaLtcESTv7kWh+3FVKxJ+bqDdUuKqwLl+RE8eym4/ghOG5Km+mLvGAtINzvUJ92U
	0KFFMhTh9pE8wZGwqTMyg==
X-ME-Sender: <xms:WDylZarNWP-1cMZPFMEpkma_umZHmnLYqLjAliKw-xqIoBQJq-dXnQ>
    <xme:WDylZYppRM7eQ1UhQPS73HAIlrtYALSW6n66LtEwkJMoVTSelZ3sZeRaHS1t_OFlh
    Wf_CV9_6UMYK3nPL0E>
X-ME-Received: <xmr:WDylZfNDiziiORlqBcSLnrqdlHcI7wbFwqdTROFxMD1wncSh6P4YoXuvSQP2OR1dmCi_Bhyzlxw5TVrFgHhmvo8bLxMwxkPwaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejuddgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepleeuffehheegleeuvdelgffhueekjeetueevuefhffdtgfeu
    hfeggfeukefffedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:WDylZZ6sP9W7lvfkyQYQ2tGCB9qSEA4Y4a1F64dF0xFoD-Jm6uZcqw>
    <xmx:WDylZZ43HmPdFMOa_lDMuTeCLlUcbAOcm-8Uqg82R19qPDb5anc1XA>
    <xmx:WDylZZg-ZCRgHeSGXVPnRxGpjSFhKg56fHMmTGWObCM05seYaGhg7w>
    <xmx:WTylZWztGWtOcDyG-OKBf3kXdtmB7tA4JzePqm6vjSSsrdGXY--_xw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jan 2024 09:08:23 -0500 (EST)
Message-ID: <731134fd-4b3d-418c-84ee-80646bffcc01@flygoat.com>
Date: Mon, 15 Jan 2024 14:08:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: memblock_reserve for unadded region (was: [PATCH] MIPS: loongson64:
 fix boot failure)
To: rppt@kernel.org, linux-mm@kvack.org
Cc: Bibo Mao <maobibo@loongson.cn>, linux-mips@vger.kernel.org,
 Paul Burton <paulburton@kernel.org>, Li Xuefeng <lixuefeng@loongson.cn>,
 Yang Tiezhu <yangtiezhu@loongson.cn>, Gao Juxin <gaojuxin@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>, Huang Pei <huangpei@loongson.cn>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-kernel@vger.kernel.org
References: <20231225093025.23215-1-huangpei@loongson.cn>
Content-Language: en-US
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Autocrypt: addr=jiaxun.yang@flygoat.com;
 keydata= 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
 HVO98ZmbMeg=
In-Reply-To: <20231225093025.23215-1-huangpei@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi mm folks,

Just a quick question, what is the expected behavior of memblock_reserve
a region that is not added to memblock with memblock_add?

I'm unable to find any documentation about memblock_reserve in comments and
boot-time-mm, but as per my understanding to the code, this should be a 
legit usage?

In practical we run into uninitialized nid of reserved block problem, 
should we fix it
in our usage, or on memblock side?

Thanks

在 2023/12/25 09:30, Huang Pei 写道:
> Since commit 61167ad5fecd("mm: pass nid to reserve_bootmem_region()),
> loongson64 booting failed with CONFIG_DEFERRED_STRUCT_PAGE_INIT like
> this:
> ----------------------------------------------------------------------
>   Call Trace:
>   [<ffffffff8235d088>] reserve_bootmem_region+0xa8/0x184
>   [<ffffffff82333940>] memblock_free_all+0x104/0x2a8
>   [<ffffffff8231d8e4>] mem_init+0x84/0x94
>   [<ffffffff82330958>] mm_core_init+0xf8/0x308
>   [<ffffffff82318c38>] start_kernel+0x43c/0x86c
>
>   Code: 10400028  2402fff0  de420000 <dc432880> 0203182b 14600022
>   64420070  00003025  24040003
>
>   ---[ end trace 0000000000000000 ]---
>   Kernel panic - not syncing: Attempted to kill the idle task!
>   ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
> ----------------------------------------------------------------------
>
> The root cause is no memory region "0x0-0x1fffff" paired with
> memory-reserved region "0x0-0x1fffff" and "0x0-0xfff", with "memblock
> =debug":
>
> ----------------------------------------------------------------------
>    memory[0x0]     [0x0000000000200000-0x000000000effffff],
>    0x000000000ee00000 bytes on node 0 flags: 0x0 !!!!here
>    memory[0x1]     [0x0000000090000000-0x00000000fdffffff],
>    0x000000006e000000 bytes on node 0 flags: 0x0
>    memory[0x2]     [0x0000000100000000-0x000000027fffffff],
>    0x0000000180000000 bytes on node 0 flags: 0x0
>    memory[0x3]     [0x0000100000000000-0x000010000fffffff],
>    0x0000000010000000 bytes on node 1 flags: 0x0
>    memory[0x4]     [0x0000100090000000-0x000010027fffffff],
>    0x00000001f0000000 bytes on node 1 flags: 0x0
>    reserved.cnt  = 0x1f
>    reserved[0x0]   [0x0000000000000000-0x000000000190c80a],
>    0x000000000190c80b bytes flags: 0x0 !!!!oops 0x0-0x1fffff not in memory[0]
>    reserved[0x1]   [0x000000000190c810-0x000000000190eea3],
>    0x0000000000002694 bytes flags: 0x0
> ----------------------------------------------------------------------
>
> It caused memory-reserved region "0x0-0x1fffff" without valid node id
> in "memblock_get_region_node" from "memmap_init_reserved_pages", lead to
> "reserve_bootmem_region-> init_reserved_page -> early_pfn_to_nid()"
> accessing "node_data" out of bound.
>
> To fix this bug, we should remove unnecessary memory block reservation.
>
> +. no need to reserve 0x0-0x1fffff below kernel loading address, since
> it is not registered by "memblock_add_node"
>
> +. no need to reserve 0x0-0xfff for exception handling if it is not
> registered by "memblock_add" either.
>
> Fixes: commit 61167ad5fecd("mm: pass nid to reserve_bootmem_region())
> Signed-off-by: Huang Pei <huangpei@loongson.cn>
> ---
>   arch/mips/kernel/traps.c    | 3 ++-
>   arch/mips/loongson64/numa.c | 2 --
>   2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 246c6a6b0261..9b632b4c10c3 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -2007,7 +2007,8 @@ unsigned long vi_handlers[64];
>   
>   void reserve_exception_space(phys_addr_t addr, unsigned long size)
>   {
> -	memblock_reserve(addr, size);
> +	if(memblock_is_region_memory(addr, size))
> +		memblock_reserve(addr, size);
>   }
>   
>   void __init *set_except_vector(int n, void *addr)
> diff --git a/arch/mips/loongson64/numa.c b/arch/mips/loongson64/numa.c
> index 8f61e93c0c5b..0f516dde81da 100644
> --- a/arch/mips/loongson64/numa.c
> +++ b/arch/mips/loongson64/numa.c
> @@ -130,8 +130,6 @@ static void __init node_mem_init(unsigned int node)
>   			memblock_reserve((node_addrspace_offset | 0xfe000000),
>   					 32 << 20);
>   
> -		/* Reserve pfn range 0~node[0]->node_start_pfn */
> -		memblock_reserve(0, PAGE_SIZE * start_pfn);
>   	}
>   }
>   

-- 
---
Jiaxun Yang


