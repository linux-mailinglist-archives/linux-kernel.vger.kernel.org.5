Return-Path: <linux-kernel+bounces-22295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1C1829BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05AAFB22076
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C464A98B;
	Wed, 10 Jan 2024 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Si5EbaOv"
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201C5495CF
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 14:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 20E575C00B0;
	Wed, 10 Jan 2024 09:01:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 10 Jan 2024 09:01:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704895267; x=1704981667; bh=re+Q9geUHzAXfBwVb7JEE7u2m42b
	h9L0BNgJRkiS9FI=; b=Si5EbaOvyJjpE1kzS1/mdRzUrwx86f9CzHGR6gu25jLa
	d+aL6JfTPqw4duMabpPXDkgYcGrueHy7EzamlM4aa13LDZOCq/n82wqIreXSNzEl
	gTOoqwXX5Bshj4dUT4fPCXVW/vI3xsFN1h+ZulFigIuMkUMahkjs+dUjxrEqfWhh
	d2Uys7DQpBG2XzvsGQonRUZLdHr12ZqrIJUYT6kzIEZ0vs1cHernJftpYfix/ZU6
	kiGLRm+CCMPNAu+Pq8smqGhOaG0woRcyZ+8gGnvPahCI1aYRcW51zS1uP84PBEbW
	di3ta33JzNuyjjo+9UFupZcxvJ7vuvL7nAeimsAsEw==
X-ME-Sender: <xms:IaOeZaybL29_rgPqcsx-R-8BXpN3jIK3GvGAsH92StiD34iejo92Qg>
    <xme:IaOeZWTspw9-8CtaXZIOkwpnCkDGRQBIsxqJjpQlD3y7chxnvuPN5ZkT3vuw6GW0I
    rAvevJdukaMiH0>
X-ME-Received: <xmr:IaOeZcXWcSRZkpBe3GACwZbudrs4C3zYoKSA5R8orp8uXfOUdRUhdZ1Q4otJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeiuddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:IqOeZQjc7OM6NMnES65dfTs56zvBxdTWNbEHz50iITLtKMRix_WfVg>
    <xmx:IqOeZcCjLN2ZF5vMrrh7cvr2MswWUumZZ7in7Wr7MNfATUUupGiQKw>
    <xmx:IqOeZRLVBj3IILRdEhZiJhgbgQBVro4V7kllHmZlpf5BuRMHi6khNg>
    <xmx:I6OeZaBXNdmFajBTlwluOWxcy1ywxAeOZZVtB42IrVKg5qhqh5XQzg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jan 2024 09:01:05 -0500 (EST)
Date: Wed, 10 Jan 2024 16:00:59 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, zhangzekun11@huawei.com,
	john.g.garry@oracle.com, dheerajkumar.srivastava@amd.com,
	jsnitsel@redhat.com, Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 0/2] iommu/iova: Make the rcache depot properly
 flexible
Message-ID: <ZZ6jG5NyaUpeCpXq@shredder>
References: <cover.1694535580.git.robin.murphy@arm.com>
 <ZY1osaGLyT-sdKE8@shredder>
 <c9cf02b5-7add-46ea-8db1-46fdce191c1c@arm.com>
 <ZZ2AqZT4dD-s01q9@shredder>
 <ab22c439-e7da-49b5-b20b-856daf376c02@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab22c439-e7da-49b5-b20b-856daf376c02@arm.com>

On Wed, Jan 10, 2024 at 12:48:06PM +0000, Robin Murphy wrote:
> On 2024-01-09 5:21 pm, Ido Schimmel wrote:
> > Hi Robin,
> > 
> > Thanks for the reply.
> > 
> > On Mon, Jan 08, 2024 at 05:35:26PM +0000, Robin Murphy wrote:
> > > Hmm, we've got what looks to be a set of magazines forming a plausible depot
> > > list (or at least the tail end of one):
> > > 
> > > ffff8881411f9000 -> ffff8881261c1000
> > > 
> > > ffff8881261c1000 -> ffff88812be26400
> > > 
> > > ffff88812be26400 -> ffff8188392ec000
> > > 
> > > ffff8188392ec000 -> ffff8881a5301000
> > > 
> > > ffff8881a5301000 -> NULL
> > > 
> > > which I guess has somehow become detached from its rcache->depot without
> > > being freed properly? However I'm struggling to see any conceivable way that
> > > could happen which wouldn't already be more severely broken in other ways as
> > > well (i.e. either general memory corruption or someone somehow still trying
> > > to use the IOVA domain while it's being torn down).
> > 
> > The machine is running a debug kernel that among other things has KASAN
> > enabled, but there are no traces in the kernel log so there is no memory
> > corruption that I'm aware of.
> > 
> > > Out of curiosity, does reverting just patch #2 alone make a difference?
> > 
> > Will try and let you know.

I can confirm that the issue reproduces when only patch #2 is reverted.
IOW, patch #1 seems to be the problem:

unreferenced object 0xffff8881a1ff3400 (size 1024):
  comm "softirq", pid 0, jiffies 4296362635 (age 3540.420s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 67 b7 05 00 00 00 00 00  ........g.......
    3f a6 05 00 00 00 00 00 93 99 05 00 00 00 00 00  ?...............
  backtrace:
    [<ffffffff819f7a68>] __kmem_cache_alloc_node+0x1e8/0x320
    [<ffffffff818a3efa>] kmalloc_trace+0x2a/0x60
    [<ffffffff8231f8f3>] free_iova_fast+0x293/0x460
    [<ffffffff823132f0>] fq_ring_free_locked+0x1b0/0x310
    [<ffffffff82314ced>] fq_flush_timeout+0x19d/0x2e0
    [<ffffffff813e97da>] call_timer_fn+0x19a/0x5c0
    [<ffffffff813ea38b>] __run_timers+0x78b/0xb80
    [<ffffffff813ea7dd>] run_timer_softirq+0x5d/0xd0
    [<ffffffff82f21605>] __do_softirq+0x205/0x8b5
unreferenced object 0xffff888165b9a800 (size 1024):
  comm "softirq", pid 0, jiffies 4299383627 (age 519.460s)
  hex dump (first 32 bytes):
    00 34 ff a1 81 88 ff ff bd 9d 05 00 00 00 00 00  .4..............
    f3 ab 05 00 00 00 00 00 37 b5 05 00 00 00 00 00  ........7.......
  backtrace:
    [<ffffffff819f7a68>] __kmem_cache_alloc_node+0x1e8/0x320
    [<ffffffff818a3efa>] kmalloc_trace+0x2a/0x60
    [<ffffffff8231f8f3>] free_iova_fast+0x293/0x460
    [<ffffffff823132f0>] fq_ring_free_locked+0x1b0/0x310
    [<ffffffff82314ced>] fq_flush_timeout+0x19d/0x2e0
    [<ffffffff813e97da>] call_timer_fn+0x19a/0x5c0
    [<ffffffff813ea38b>] __run_timers+0x78b/0xb80
    [<ffffffff813ea7dd>] run_timer_softirq+0x5d/0xd0
    [<ffffffff82f21605>] __do_softirq+0x205/0x8b5

> > 
> > > And is your workload doing anything "interesting" in relation to IOVA
> > > domain lifetimes, like creating and destroying SR-IOV virtual
> > > functions, changing IOMMU domain types via sysfs, or using that
> > > horrible vdpa thing, or are you seeing this purely from regular driver
> > > DMA API usage?
> > 
> > The machine is running networking related tests, but it is not using
> > SR-IOV, VMs or VDPA so there shouldn't be anything "interesting" as far
> > as IOMMU is concerned.
> > 
> > The two networking drivers on the machine are "igb" for the management
> > port and "mlxsw" for the data ports (the machine is a physical switch).
> > I believe the DMA API usage in the latter is quite basic and I don't
> > recall any DMA related problems with this driver since it was first
> > accepted upstream in 2015.
> 
> Thanks for the clarifications, that seems to rule out all the most
> confusingly impossible scenarios, at least.
> 
> The best explanation I've managed to come up with is a false-positive race
> dependent on the order in which kmemleak scans the relevant objects. Say we
> have the list as depot -> A -> B -> C; the rcache object is scanned and sees
> the pointer to magazine A, but then A is popped *before* kmemleak scans it,
> such that when it is then scanned, its "next" pointer has already been
> wiped, thus kmemleak never observes any reference to B, so it appears that B
> and (transitively) C are "leaked". If that is the case, then I'd expect it
> should be reproducible with patch #1 alone (although patch #2 might make it
> slightly more likely if the work ever does result in additional pops
> happening), but I'd expect the leaked objects to be transient and not
> persist forever through repeated scans (what I don't know is whether
> kmemleak automatically un-leaks an object if it subsequently finds a new
> reference, or if it needs manually clearing in between scans). I'm not sure
> if there's a nice way to make that any better... unless maybe it might make
> sense to call kmemleak_not_leak(mag->next) in iova_depot_pop() before that
> reference disappears?

I'm not familiar with the code so I can't comment if that's the best
solution, but I will say that we've been running kmemleak as part of our
regression for years and every time we got a report it was an actual
memory leak. Therefore, in order to keep the tool reliable, I think it's
better to annotate the code to suppress false-positives rather than
ignoring it.

Please let me know if you want me to test a fix.

Thanks for looking into this!

