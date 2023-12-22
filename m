Return-Path: <linux-kernel+bounces-9732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B3C81CA5D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 565EA1F229D7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D251A5B8;
	Fri, 22 Dec 2023 12:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="COm310mC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2Naat/YG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD5519443;
	Fri, 22 Dec 2023 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 4EE5C3200AD9;
	Fri, 22 Dec 2023 07:58:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 22 Dec 2023 07:58:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1703249924;
	 x=1703336324; bh=gBzr86HYVLagWtrGT5nOWo3pzHJeoT0tMLV9Ajf9peY=; b=
	COm310mCw+Si6H3zLC5g3hwDzFToTLe/BFcls0JI1gEeFUok4HXbH0oHhwhHXOCj
	nyG6wDnXfDYwFoAv5ddKGJ2tIB+FDN4vXdtatQuRvTbm+cL9BsyPIgsMc+nNAIMW
	gZcnktwubrg604BJjX4PgGp3wPdLni6izP1F1E4jeotU94K0tMeVVI1jMwOrUeIb
	yhnYsBKkXKwNJUX3RLYlD2b7ppKbpk8HoeCMvbSlYedjhFN3syiG2/2RDCoxAblo
	Z2XfKCoEDrvyE14/56KZxvalzrg/fw7noJ+Hvk3Cju/ySlXLwOtr3tkyIdmOz6ht
	nWMKOa4gQbyJK29Usw+euw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1703249924; x=
	1703336324; bh=gBzr86HYVLagWtrGT5nOWo3pzHJeoT0tMLV9Ajf9peY=; b=2
	Naat/YGX5XS7SDzQ+g1gV1vlXnjEH6v8UlwyLnrgxptQqvRaSFNH0Wxnt2ZVfkXc
	xDaqMQ3T0XCifzbRPFHBXnQ8iL8ifxydl9MKR2tsxqyTOQX3WU4Xr8y/Q7+hxmDJ
	yJbKTC5+fZm2+IxeNBVuayWXpiiWSToNf203kJZ0z5RGlvL8ClZv9o21jxzn+X6o
	jKqSHk7NETl0jlILcNkT+/LDc04hFhO+RbM8C6SLQGHfNPgmrH3Pcp2F68beDMsT
	+tlHNy5aDL85VxZfjrgN7ttTcUHTTHBMAKjVwSx6DBCeVHNzCPc3k28Wk+342S74
	MseiLO8ZjWHd4O78CSIGA==
X-ME-Sender: <xms:BIiFZZcYJpLrO1OK2zOh5uBE1F9sD6kHW2gLLHnKm11tTaxkc71okg>
    <xme:BIiFZXM-elmM_lqMc2aFvkORTTBNeOfofM1DwNH2AJbhXb6cSy082vs9uKXNOfUzV
    LQVJ19dHA-by5jmZHs>
X-ME-Received: <xmr:BIiFZShBjDCie-DDH0CmBv-eWhgY8Hl90EvG0u6h7qkennSO3J_sJI8289Xs0_RTzaD_fDiXFlyNA_aFWzpMcgpKhLmFcRNHibqALxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddujedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvfhfhjggtgfesthekredttddvjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeeiudduffdufffgffelfedujeehteffffdukeekvdfgvdeileej
    ffekueehuddugfenucffohhmrghinhepghgvnhgvgidrshgsnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhl
    hihgohgrthdrtghomh
X-ME-Proxy: <xmx:BIiFZS8aBbRgzFX2oWiOcyAUwU3UNw5kheZ1vt7PghZeEqpZc_TPXQ>
    <xmx:BIiFZVskSl3RMCc-KfIVb9gq9Tt0R2DhEmUwM-VYp6r-b5AP4BmV1w>
    <xmx:BIiFZRHZBURW-AdraA8coe0Qg-hZkT-9bFNS-h1Hd7w6nC0QLc-nhA>
    <xmx:BIiFZWWcDXVGh3KRc4d0YKunlMnSKQCXEDhm2oumLk0xV8IwEhDVRg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Dec 2023 07:58:43 -0500 (EST)
Message-ID: <7249cb98-0b63-4ef6-8f6e-e29ac6c0a73f@flygoat.com>
Date: Fri, 22 Dec 2023 12:58:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] MIPS: Allow vectored interrupt handler to reside
 everywhere for 64bit
Content-Language: en-US
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231221125405.229100-1-tsbogend@alpha.franken.de>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20231221125405.229100-1-tsbogend@alpha.franken.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/12/21 12:54, Thomas Bogendoerfer 写道:
> Setting up vector interrupts worked only with handlers, which resided
> in CKSEG0 space. This limits the kernel placement for 64bit platforms.
> By patching in the offset into vi_handlers[] instead of the full
> handler address, the vectored exception handler can load the
> address by itself and jump to it.
>
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Could you please keep me in Cc if you are going to propose a better
solution :-)

Thanks
- Jiaxun

> ---
>   arch/mips/kernel/genex.S | 8 ++++----
>   arch/mips/kernel/traps.c | 9 +++------
>   2 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
> index b6de8e88c1bd..a572ce36a24f 100644
> --- a/arch/mips/kernel/genex.S
> +++ b/arch/mips/kernel/genex.S
> @@ -272,18 +272,17 @@ NESTED(except_vec_vi, 0, sp)
>   	.set	push
>   	.set	noreorder
>   	PTR_LA	v1, except_vec_vi_handler
> -FEXPORT(except_vec_vi_lui)
> -	lui	v0, 0		/* Patched */
>   	jr	v1
>   FEXPORT(except_vec_vi_ori)
> -	 ori	v0, 0		/* Patched */
> +	 ori	v0, zero, 0		/* Offset in vi_handlers[] */
>   	.set	pop
>   	END(except_vec_vi)
>   EXPORT(except_vec_vi_end)
>   
>   /*
>    * Common Vectored Interrupt code
> - * Complete the register saves and invoke the handler which is passed in $v0
> + * Complete the register saves and invoke the handler, $v0 holds
> + * offset into vi_handlers[]
>    */
>   NESTED(except_vec_vi_handler, 0, sp)
>   	SAVE_TEMP
> @@ -331,6 +330,7 @@ NESTED(except_vec_vi_handler, 0, sp)
>   	/* Save task's sp on IRQ stack so that unwinding can follow it */
>   	LONG_S	s1, 0(sp)
>   2:
> +	PTR_L	v0, vi_handlers(v0)
>   	jalr	v0
>   
>   	/* Restore sp */
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 246c6a6b0261..d90b18908692 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -2091,16 +2091,14 @@ static void *set_vi_srs_handler(int n, vi_handler_t addr, int srs)
>   		 * If no shadow set is selected then use the default handler
>   		 * that does normal register saving and standard interrupt exit
>   		 */
> -		extern const u8 except_vec_vi[], except_vec_vi_lui[];
> +		extern const u8 except_vec_vi[];
>   		extern const u8 except_vec_vi_ori[], except_vec_vi_end[];
>   		extern const u8 rollback_except_vec_vi[];
>   		const u8 *vec_start = using_rollback_handler() ?
>   				      rollback_except_vec_vi : except_vec_vi;
>   #if defined(CONFIG_CPU_MICROMIPS) || defined(CONFIG_CPU_BIG_ENDIAN)
> -		const int lui_offset = except_vec_vi_lui - vec_start + 2;
>   		const int ori_offset = except_vec_vi_ori - vec_start + 2;
>   #else
> -		const int lui_offset = except_vec_vi_lui - vec_start;
>   		const int ori_offset = except_vec_vi_ori - vec_start;
>   #endif
>   		const int handler_len = except_vec_vi_end - vec_start;
> @@ -2119,10 +2117,9 @@ static void *set_vi_srs_handler(int n, vi_handler_t addr, int srs)
>   #else
>   				handler_len);
>   #endif
> -		h = (u16 *)(b + lui_offset);
> -		*h = (handler >> 16) & 0xffff;
> +		/* insert offset into vi_handlers[] */
>   		h = (u16 *)(b + ori_offset);
> -		*h = (handler & 0xffff);
> +		*h = n * sizeof(handler);
>   		local_flush_icache_range((unsigned long)b,
>   					 (unsigned long)(b+handler_len));
>   	}


