Return-Path: <linux-kernel+bounces-94093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970948739D8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5811C21CD3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7C5134743;
	Wed,  6 Mar 2024 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="TnSU1zDu"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277BE13440D;
	Wed,  6 Mar 2024 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736856; cv=none; b=iqXjcNJFZQC5u20dD/Dq6aBls5+GCYZYhPaHRvq4Lb3zpuBabzn3GyT1KSORn5kZclogCORCdS/c4HP+Gb36+zGqbam+fUJnWjMAEjDd1MWWaNzh+MEH2jk86e9XLlC2XUhx76MdGOEAZnY84yhausyXIH8rP37lSO6XcLPLGZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736856; c=relaxed/simple;
	bh=96054vt0RIF8FrPah2L/xxgnSuYxMgqAI0Q+ZetCRX0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=EiX36p1nvI5D5EGnBTP4Rq3w360Dyd4EqhCbcglFekTK8Iybpm7DGVvhs0X6JpIEYi8YKDLOVyFfFGxslGqKoNwu2Uhpka/VxZldJ+3D9VLwjFHnS8AFnTITk75Lp/HREKOavvuLAqa6TyJrDu2kSvRvuyXxJJpznKoH4OggMwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=TnSU1zDu; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1709736849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H2lJKxoSRgpljXG36rHJ6kJtSm+0/59EDB5to3fB+oQ=;
	b=TnSU1zDusf5T/c53MxwSN6xIpjDRNDKnurr+17PoFbB5sdtWiZB0JdVkx477Gme5fGGZkB
	AJF59d5e4aL9ftyUBeoJCcGS5YT62/trfhyNlpMqq8g/ntPHfpezzd+6aFjCU4mgmsOlH7
	92bJR/q63hdhlVvXtQsM1XnlAIzSJJORSRYkzfFc0SAHjgJP28V7Lp+Tk1Q+H4gMKm3nUb
	IKItpvxIuCknX3+ehpR5gJZS6MnNIhbAXmmSfUbeULpQV8Lf4mXD7xYmtXZwO3IjhO4XJy
	F8+YHYK8olbqyhvHbkBsXSAJ7rJ+vHsZqu6R/r7jjx7FpboRowKKUELKCJ4qGQ==
Date: Wed, 06 Mar 2024 15:54:07 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Tim Pambor <tp@osasysteme.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, AnandMoon <linux.amoon@gmail.com>, Magnus Damm
 <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: r9a07g044: Add complete CPU cache information
In-Reply-To: <db77fa78e75b9712ebba1dfd7e4340603cae4fe3.camel@osasysteme.de>
References: <20240305151336.144707-1-tp@osasysteme.de>
 <TYCPR01MB112696A947F31C31FE3A3AFF586212@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <db77fa78e75b9712ebba1dfd7e4340603cae4fe3.camel@osasysteme.de>
Message-ID: <8d9ec337e794cb2ecc69a961c7e47e3f@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Tim and Biju,

On 2024-03-06 11:10, Tim Pambor wrote:
> thanks for the review.
> 
>> Thanks for the patch.
>> 
>> > -----Original Message-----
>> > From: Tim Pambor <tp@osasysteme.de>
>> > Sent: Tuesday, March 5, 2024 3:14 PM
>> > Subject: [PATCH] arm64: dts: r9a07g044: Add complete CPU cache
>> > information
>> >
>> > Based on ARM Cortex-A55 TRM and RZG2/L user's manual, each Cortex-
>> > A55 has
>> 
>> RZ/G2L
>> 
>> > - 32 KB of L1 4-way, set-associative instruction cache
>> > - 32 KB of L1 4-way, set-associative data cache

Just a small suggestion, moving "L1" after "set-associative" would make
these two lines a bit more readable.

>> > Each cache has a cache line length of 64B and therefore there are
>> > 32768B/(4 * 64B)=128 sets for each cache.
>> >
>> > RZG2/L are not configured with the optional per-core L2 cache but
>> > only have a L3 cache shared among all
>> RZ/G2L
>> > cores. In this case, the L3 cache appears as a L2 cache to the
>> > system. Therefore, specify "cache-level
>> > = <2>" for the L3 cache.
> 
> I will send a v2 with the commit message corrected.
> 
>> You mean for L3 Cache, cache-level = <2> if there is no L2 Cache on
>> the system? Does it need any update
>> on dt-bindings to make this clear?
> 
> I followed the approach chosen for the Rockchip RK356x, which also has
> a Cortex-A55 with an L3 cache but no L2 cache [1]. I can add a comment
> to the device tree explaining that there is no L2 cache and that
> therefore the L3 cache appears as a L2 cache to the system. Do you
> consider that sufficient?

As I noted in the description of the Rockchip RK356x patch linked above,
the documentation from ARM states that the CPU cores see the shared L3
cache as their L2 caches, when there are no private, per-code L2 caches
in a particular SoC that employs the DynamIQ architecture.

Thus, it's the best to follow the same approach in the kernel and 
present
the same logical cache hierarchy to the userspace, to avoid the 
confusion
among the users, which would almost surely wonder why there are no L2
caches, but there is an L3 cache.  It should also avoid unexpected 
behavior
and bugs such as the one visible below, because having an L3 cache with 
no
L2 caches isn't very common.

> Currently, having cache-level = <3> also causes a out-of-bounds access
> in populate_cache_leaves.
> 
> [    0.066217]
> ==================================================================
> [    0.066369] BUG: KASAN: slab-out-of-bounds in
> populate_cache_leaves+0x25c/0x2d0
> [    0.066495] Write of size 4 at addr ffff0000082370dc by task 
> swapper/0/1
> [    0.066580]
> [    0.066619] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 6.8.0-rc2-00016-g30d5a685c65d #6
> [    0.066719] Hardware name: MYC-YG2LX (DT)
> [    0.066793] Call trace:
> [    0.066836]  dump_backtrace+0x98/0x118
> [    0.066900]  show_stack+0x18/0x24
> [    0.066959]  dump_stack_lvl+0x60/0xac
> [    0.067029]  print_report+0xf8/0x5d8
> [    0.067096]  kasan_report+0xc0/0x100
> [    0.067159]  __asan_report_store4_noabort+0x20/0x2c
> [    0.067235]  populate_cache_leaves+0x25c/0x2d0
> [    0.067308]  detect_cache_attributes+0x34c/0x1998
> [    0.067384]  update_siblings_masks+0x30/0x554
> [    0.067460]  store_cpu_topology+0xe8/0x188
> [    0.067528]  smp_prepare_cpus+0x5c/0x238
> [    0.067602]  kernel_init_freeable+0x258/0xb18
> [    0.067673]  kernel_init+0x30/0x208
> [    0.067736]  ret_from_fork+0x10/0x20
> [    0.067802]
> [    0.067835] Allocated by task 1:
> [    0.067889]  kasan_save_stack+0x3c/0x64
> [    0.067956]  kasan_save_track+0x20/0x3c
> [    0.068020]  kasan_save_alloc_info+0x68/0x78
> [    0.068090]  __kasan_kmalloc+0xd4/0xd8
> [    0.068154]  __kmalloc+0x1c0/0x430
> [    0.068215]  allocate_cache_info+0xa8/0x204
> [    0.068284]  fetch_cache_info+0xc4/0x200
> [    0.068349]  init_cpu_topology+0x348/0x45c
> [    0.068423]  smp_prepare_cpus+0x1c/0x238
> [    0.068492]  kernel_init_freeable+0x258/0xb18
> [    0.068561]  kernel_init+0x30/0x208
> [    0.068622]  ret_from_fork+0x10/0x20
> [    0.068685]
> [    0.068719] The buggy address belongs to the object at 
> ffff000008237000
> [    0.068719]  which belongs to the cache kmalloc-256 of size 256
> [    0.068849] The buggy address is located 4 bytes to the right of
> [    0.068849]  allocated 216-byte region [ffff000008237000, 
> ffff0000082370d8)
> [    0.068984]
> [    0.069018] The buggy address belongs to the physical page:
> [    0.069089] page:(____ptrval____) refcount:1 mapcount:0
> mapping:0000000000000000 index:0x0 pfn:0x48236
> [    0.069201] head:(____ptrval____) order:1 entire_mapcount:0
> nr_pages_mapped:0 pincount:0
> [    0.069297] flags: 0x840(slab|head|zone=0)
> [    0.069366] page_type: 0xffffffff()
> [    0.069430] raw: 0000000000000840 ffff000008001b40 dead000000000122
> 0000000000000000
> [    0.069526] raw: 0000000000000000 0000000080100010 00000001ffffffff
> 0000000000000000
> [    0.069616] page dumped because: kasan: bad access detected
> [    0.069684]
> [    0.069717] Memory state around the buggy address:
> [    0.069781]  ffff000008236f80: fc fc fc fc fc fc fc fc fc fc fc fc
> fc fc fc fc
> [    0.069870]  ffff000008237000: 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00
> [    0.069958] >ffff000008237080: 00 00 00 00 00 00 00 00 00 00 00 fc
> fc fc fc fc
> [    0.070042]                                                     ^
> [    0.070116]  ffff000008237100: fc fc fc fc fc fc fc fc fc fc fc fc
> fc fc fc fc
> [    0.070204]  ffff000008237180: fc fc fc fc fc fc fc fc fc fc fc fc
> fc fc fc fc
> [    0.070290]
> ==================================================================
> 
> [1] 
> https://lore.kernel.org/linux-rockchip/2285ee41e165813011220f9469e28697923aa6e0.1709491108.git.dsimic@manjaro.org/

