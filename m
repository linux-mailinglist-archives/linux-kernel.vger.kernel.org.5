Return-Path: <linux-kernel+bounces-112363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8678878E7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 14:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 045C4B22BC7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF7A3D3B1;
	Sat, 23 Mar 2024 13:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FTgtD2l2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968541A38F4
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711201765; cv=none; b=HiQdxYTfdwaKBMS1W7myusSSrk9wWAV3ZsArVruyDwgJp8ywMp3f9+XjLsNtSR1n2a9MEIo2FdRM+SV6jZO1iunip4B72cKjRcR8TIqZDk7VoAfMNeaIE4+RgW0JEaC31cKIpjRhdfXsnCOCQTyId8i/w2l7mlTllmW9wt/zfQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711201765; c=relaxed/simple;
	bh=oeW8h9GJbeIfCj6hNaVoyF/g69+Xg5Z/AmcqXo8rnuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TNC9d0EZTdW0BygpfZ2ib28PZUdK1OGDYtwTHqyqTEYy6k1wJdKcdIogPWAopLy1p9xPfgKbe7VIsjLFwvPBegAXAd/H9hvlHlF8eGOkzJeIyWyDHb9GcQbNS3jt4bKDRtQ1hH9zZ3ewtJZ2hOcGEIFb6ywdPfFtQ58ssuFmqcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FTgtD2l2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8A3CA40E01A0;
	Sat, 23 Mar 2024 13:49:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id O7iB7vIejRhF; Sat, 23 Mar 2024 13:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711201756; bh=43GScud8BDvetKeS/zOlqZcUvC6DtKK7nMRZY30xYF0=;
	h=Date:From:To:Cc:Subject:From;
	b=FTgtD2l2v0Lb+lu8Xxq+nwW4GDzU9p3ss0fg4oGJP8IARC76g+N0HkFDB3jV/PeYO
	 Q5N30vjRt4BAw9BhRvRpTQXKi5uTYmIyoxBn/PxF7X0Ag7MYRIWmvnal3FVtnhybY3
	 9AjYu7HmXYyBemMsUYt+p3uB6Tji5IfsPHgMiKGcU0TfR3nq6FIRV0hOAsFDAOg/8x
	 ax1OgRl3BNNYlNwzkBZbwz/WXadeHkpyCQpG0gElRARczyrAAuvFniqwJK1gRAPAOA
	 z7B32Tb+rOewOWdvp6v15wl41ZmoBEgpqjDpPjEX+KFR4eLaSVeFPkcYwRCmtNsHe5
	 4SeLd64pvxRNtQwfvz9kIW4OhBXUiMqtzIokCOc8YEhAgABVwpaZD6vUpqBXHHg2Mu
	 +93FAgLfnQcD/FYA2N7YTzdtHvJjTIOB9qmBOyvNa8gbkSC396XThUjJy1fg7Sg98T
	 jSFPHheSnMCcy1/eExOjUanet2uAYgiaj+v8ufIdUmMknvDoz2IkuU/EEvLpFkclkZ
	 yHVvnDKFt1FFXd10s/TG0VAZ8bCo8MvB24Els06IH2WXBpzksuJY+X8dJN1Rlh3Uqv
	 w+waAHaMj4J971KIfqkGXgZcVGIHYvFZbDOyicNjI1kLJbGW4BLjjzq5m5xGnGJSpF
	 q/6VuzjmhxvinOXJYFfDMibQ=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D4CCE40E016B;
	Sat, 23 Mar 2024 13:49:09 +0000 (UTC)
Date: Sat, 23 Mar 2024 14:49:04 +0100
From: Borislav Petkov <bp@alien8.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: dma pool: swapper/0: page allocation failure: order:9,
 mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null)
Message-ID: <20240323134904.GBZf7d0G045fMmXYav@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This is with the latest Linus branch:

bfa8f18691ed ("Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi")

[    0.407944] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
[    0.408158] swapper/0: page allocation failure: order:9, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null)
[    0.408196] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0+ #1
[    0.408219] Hardware name: LENOVO 20Y2MMMMCC/20Y2MMMMCC, BIOS R1BET58W(1.27 ) 10/20/2020
[    0.408248] Call Trace:
[    0.408260]  <TASK>
[    0.408272]  dump_stack_lvl+0x8b/0xa0
[    0.408292]  warn_alloc+0x124/0x190
[    0.408315]  ? __alloc_pages_direct_compact+0x86/0x2a0
[    0.408341]  __alloc_pages_slowpath.constprop.0+0xbd5/0xd80
[    0.408364]  ? srso_return_thunk+0x5/0x5f
[    0.408397]  __alloc_pages+0x2f6/0x320
[    0.408419]  alloc_pages_mpol+0xe5/0x220
[    0.408437]  ? srso_return_thunk+0x5/0x5f
[    0.408459]  atomic_pool_expand+0x48/0x140
[    0.408482]  __dma_atomic_pool_init+0x49/0xb0
[    0.408504]  dma_atomic_pool_init+0x16f/0x190
[    0.408523]  ? __pfx_dma_atomic_pool_init+0x10/0x10
[    0.408543]  do_one_initcall+0x60/0x3b0
[    0.408562]  ? rdinit_setup+0x20/0x30
[    0.408587]  kernel_init_freeable+0x1cb/0x390
[    0.408606]  ? __pfx_ignore_unknown_bootoption+0x10/0x10
[    0.408628]  ? __pfx_kernel_init+0x10/0x10
[    0.408648]  kernel_init+0x16/0x1c0
[    0.408663]  ret_from_fork+0x4c/0x60
[    0.408680]  ? __pfx_kernel_init+0x10/0x10
[    0.408698]  ret_from_fork_asm+0x1a/0x30
[    0.408727]  </TASK>
[    0.408738] Mem-Info:
[    0.408750] active_anon:0 inactive_anon:0 isolated_anon:0
                active_file:0 inactive_file:0 isolated_file:0
                unevictable:0 dirty:0 writeback:0
                slab_reclaimable:22 slab_unreclaimable:1141
                mapped:0 shmem:0 pagetables:69
                sec_pagetables:0 bounce:0
                kernel_misc_reclaimable:0
                free:3823293 free_pcp:0 free_cma:0
[    0.408866] Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:1984kB pagetables:276kB sec_pagetables:0kB all_unreclaimable? no
[    0.408960] Node 0 DMA free:1024kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:1024kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[    0.409046] lowmem_reserve[]: 0 0 0 0
[    0.409071] Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 1*1024kB (U) 0*2048kB 0*4096kB = 1024kB
[    0.409141] 0 total pagecache pages
[    0.409155] 0 pages in swap cache
[    0.409170] Free swap  = 0kB
[    0.409183] Total swap = 0kB
[    0.409196] 3991469 pages RAM
[    0.409209] 0 pages HighMem/MovableOnly
[    0.409224] 163547 pages reserved
[    0.409238] 0 pages hwpoisoned
[    0.409349] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.409589] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.410214] thermal_sys: Registered thermal governor 'fair_share'


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

