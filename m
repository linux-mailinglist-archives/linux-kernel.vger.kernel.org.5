Return-Path: <linux-kernel+bounces-12639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 313F481F830
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25C31F233AB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F067490;
	Thu, 28 Dec 2023 12:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0ftsP2Xu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65318466
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 12:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 4C6623200A89;
	Thu, 28 Dec 2023 07:23:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 28 Dec 2023 07:23:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703766198; x=1703852598; bh=fM7/zGyEYysEvVHcUQj7FtYh0mju
	iCiJQyKM0uIK+uM=; b=0ftsP2XuEmLwU8V0h9/o/T0KuJkFfVwRPR6PLFma+MHe
	tPuUCSBUGfM2SBMjR8YlcPmM4sexOGMfmC8qpITHeM83X/FBdUEjNu9ddHabkl9w
	dcww+miIjRbpH2JeQV6ftEjINVOJUSi2kxcS3cBZRseIeNDz4Fl1Euhl0xK8vWDJ
	CbHizentF2ONsIQHFelerPETLMPm1Bxek7iVBoC+/Bd9yG+YWwOHOwZP0xGq4jPf
	CrIHpU9iEq590nlaV+M6zSB5xuY6jOJY/D/A++IDCdVAZcJRHolptjBAgtKnCraW
	gGkbi0BC0r15hsKBVWnl1HkeFDuW+zNNT/XjWhAm7w==
X-ME-Sender: <xms:tmiNZeDgGcQ5x9A4F3-DpbNXaJY6ZWGRoXFXIg-nz57v_syP3ayOcg>
    <xme:tmiNZYgbhJXD-bTYtC_d2AdVzEoC5n7KQcdzG3KknA3J57FbjbqjAiRsezX6JPMLa
    pH57eMLTG5-uPI>
X-ME-Received: <xmr:tmiNZRlBvKIsR9EwvYViUx14ONBha_EWgPnN1bpBMCmnVe8fuf4jDCbsnN_L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhephefhtdejvdeiffefudduvdffgeetieeigeeugfduffdvffdtfeehieejtdfh
    jeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:tmiNZcyZk2Ic7Cwm8bAt1twt32DRNVBi8KqyXixUPtBxDwvhKouz0A>
    <xmx:tmiNZTSIWYG99jQC7lIiBUDidLyo6MzJ3WxF5V412etRd_IlLR3VoQ>
    <xmx:tmiNZXZSVKzZEgLHvFtaY0vIcZY9KPxJxqs8yGZ55TP8gcTjd012Zg>
    <xmx:tmiNZSE-QY-5GesfR6MSIE1KrAiXIKP0z072gQcgiNpG9KKanSaqbQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 07:23:17 -0500 (EST)
Date: Thu, 28 Dec 2023 14:23:13 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, zhangzekun11@huawei.com,
	john.g.garry@oracle.com, dheerajkumar.srivastava@amd.com,
	jsnitsel@redhat.com
Subject: Re: [PATCH v3 0/2] iommu/iova: Make the rcache depot properly
 flexible
Message-ID: <ZY1osaGLyT-sdKE8@shredder>
References: <cover.1694535580.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1694535580.git.robin.murphy@arm.com>

On Tue, Sep 12, 2023 at 05:28:04PM +0100, Robin Murphy wrote:
> v2: https://lore.kernel.org/linux-iommu/cover.1692641204.git.robin.murphy@arm.com/
> 
> Hi all,
> 
> I hope this is good to go now, just fixed the locking (and threw
> lockdep at it to confirm, which of course I should have done to begin
> with...) and picked up tags.

Hi,

After pulling the v6.7 changes we started seeing the following memory
leaks [1] of 'struct iova_magazine'. I'm not sure how to reproduce it,
which is why I didn't perform bisection. However, looking at the
mentioned code paths, they seem to have been changed in v6.7 as part of
this patchset. I reverted both patches and didn't see any memory leaks
when running a full regression (~10 hours), but I will repeat it to be
sure.

Any idea what could be the problem?

Thanks

[1]
unreferenced object 0xffff8881a5301000 (size 1024): 
  comm "softirq", pid 0, jiffies 4306297099 (age 462.991s) 
  hex dump (first 32 bytes): 
    00 00 00 00 00 00 00 00 e7 7d 05 00 00 00 00 00  .........}...... 
    0f b4 05 00 00 00 00 00 b4 96 05 00 00 00 00 00  ................ 
  backtrace: 
    [<ffffffff819f5f08>] __kmem_cache_alloc_node+0x1e8/0x320 
    [<ffffffff818a239a>] kmalloc_trace+0x2a/0x60 
    [<ffffffff8231d31e>] free_iova_fast+0x28e/0x4e0 
    [<ffffffff82310860>] fq_ring_free_locked+0x1b0/0x310 
    [<ffffffff8231225d>] fq_flush_timeout+0x19d/0x2e0 
    [<ffffffff813e95ba>] call_timer_fn+0x19a/0x5c0 
    [<ffffffff813ea16b>] __run_timers+0x78b/0xb80 
    [<ffffffff813ea5bd>] run_timer_softirq+0x5d/0xd0 
    [<ffffffff82f1d915>] __do_softirq+0x205/0x8b5 

unreferenced object 0xffff8881392ec000 (size 1024): 
  comm "softirq", pid 0, jiffies 4306326731 (age 433.359s) 
  hex dump (first 32 bytes): 
    00 10 30 a5 81 88 ff ff 50 ff 0f 00 00 00 00 00  ..0.....P....... 
    f3 99 05 00 00 00 00 00 87 b7 05 00 00 00 00 00  ................ 
  backtrace: 
    [<ffffffff819f5f08>] __kmem_cache_alloc_node+0x1e8/0x320 
    [<ffffffff818a239a>] kmalloc_trace+0x2a/0x60 
    [<ffffffff8231d31e>] free_iova_fast+0x28e/0x4e0 
    [<ffffffff82310860>] fq_ring_free_locked+0x1b0/0x310 
    [<ffffffff8231225d>] fq_flush_timeout+0x19d/0x2e0 
    [<ffffffff813e95ba>] call_timer_fn+0x19a/0x5c0 
    [<ffffffff813ea16b>] __run_timers+0x78b/0xb80 
    [<ffffffff813ea5bd>] run_timer_softirq+0x5d/0xd0 
    [<ffffffff82f1d915>] __do_softirq+0x205/0x8b5 

unreferenced object 0xffff8881411f9000 (size 1024): 
  comm "softirq", pid 0, jiffies 4306708887 (age 51.459s) 
  hex dump (first 32 bytes): 
    00 10 1c 26 81 88 ff ff 2c 96 05 00 00 00 00 00  ...&....,....... 
    ac fe 0f 00 00 00 00 00 a6 fe 0f 00 00 00 00 00  ................ 
  backtrace: 
    [<ffffffff819f5f08>] __kmem_cache_alloc_node+0x1e8/0x320 
    [<ffffffff818a239a>] kmalloc_trace+0x2a/0x60 
    [<ffffffff8231d31e>] free_iova_fast+0x28e/0x4e0 
    [<ffffffff82310860>] fq_ring_free_locked+0x1b0/0x310 
    [<ffffffff8231225d>] fq_flush_timeout+0x19d/0x2e0 
    [<ffffffff813e95ba>] call_timer_fn+0x19a/0x5c0 
    [<ffffffff813ea16b>] __run_timers+0x78b/0xb80 
    [<ffffffff813ea5bd>] run_timer_softirq+0x5d/0xd0 
    [<ffffffff82f1d915>] __do_softirq+0x205/0x8b5 

unreferenced object 0xffff88812be26400 (size 1024): 
  comm "softirq", pid 0, jiffies 4306710027 (age 50.319s) 
  hex dump (first 32 bytes): 
    00 c0 2e 39 81 88 ff ff 32 ab 05 00 00 00 00 00  ...9....2....... 
    e3 ac 05 00 00 00 00 00 1f b6 05 00 00 00 00 00  ................ 
  backtrace: 
    [<ffffffff819f5f08>] __kmem_cache_alloc_node+0x1e8/0x320 
    [<ffffffff818a239a>] kmalloc_trace+0x2a/0x60 
    [<ffffffff8231d31e>] free_iova_fast+0x28e/0x4e0 
    [<ffffffff82310860>] fq_ring_free_locked+0x1b0/0x310 
    [<ffffffff8231225d>] fq_flush_timeout+0x19d/0x2e0 
    [<ffffffff813e95ba>] call_timer_fn+0x19a/0x5c0 
    [<ffffffff813ea16b>] __run_timers+0x78b/0xb80 
    [<ffffffff813ea5bd>] run_timer_softirq+0x5d/0xd0 
    [<ffffffff82f1d915>] __do_softirq+0x205/0x8b5 

unreferenced object 0xffff8881261c1000 (size 1024): 
  comm "softirq", pid 0, jiffies 4306711547 (age 48.799s) 
  hex dump (first 32 bytes): 
    00 64 e2 2b 81 88 ff ff c0 7c 05 00 00 00 00 00  .d.+.....|...... 
    87 a5 05 00 00 00 00 00 0e 9a 05 00 00 00 00 00  ................ 
  backtrace: 
    [<ffffffff819f5f08>] __kmem_cache_alloc_node+0x1e8/0x320 
    [<ffffffff818a239a>] kmalloc_trace+0x2a/0x60 
    [<ffffffff8231d31e>] free_iova_fast+0x28e/0x4e0 
    [<ffffffff82310860>] fq_ring_free_locked+0x1b0/0x310 
    [<ffffffff8231225d>] fq_flush_timeout+0x19d/0x2e0 
    [<ffffffff813e95ba>] call_timer_fn+0x19a/0x5c0 
    [<ffffffff813ea16b>] __run_timers+0x78b/0xb80 
    [<ffffffff813ea5bd>] run_timer_softirq+0x5d/0xd0 
    [<ffffffff82f1d915>] __do_softirq+0x205/0x8b5 

