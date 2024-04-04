Return-Path: <linux-kernel+bounces-130869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5637B897E3F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C24F285ED0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 04:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAB920B35;
	Thu,  4 Apr 2024 04:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="caiU1hhF"
Received: from weasel.tulip.relay.mailchannels.net (weasel.tulip.relay.mailchannels.net [23.83.218.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083D81AAC4
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 04:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.247
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712205641; cv=pass; b=cft4MTrR97qLivuawYShbTuVujaSZ4UtniD7/pGyPd6JcfHfXFriAXKPP7hMDDejg8iXGf2J0d/w7DlW/jlQn951JLHt8IwmqTKb2nCzNNiKNxbBvlOliwW8DAyNKWEcGhPsk29OZ6acetzzIb9Tr+JYiwF70Lv8Zli0UCJgOBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712205641; c=relaxed/simple;
	bh=ltGALoslXFszQstpAodsRF0+NxBLxa9wowH64HGNeEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9nE0hM+3w39T7w2Os7vjk+3On/fXV2jQBPbr+G5n1twxZ2PYRJTQJuGUQkXn4MNk0LYNjyzNQUDUeevQrI/cQpVQuuI0NzlkowAJ5Gk/pT/Vq1PEo/ARkmogcVONVzHpSjzL844kuEOgA/l3e4Ulo6cvaiYbm7Jg0WtYkM4ZZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=caiU1hhF; arc=pass smtp.client-ip=23.83.218.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 704176C2A24
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 04:40:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a235.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1917C6C29BE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 04:40:32 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1712205632; a=rsa-sha256;
	cv=none;
	b=Ie20Q7xCx4Z+eqnDm+CJSrLrkvv3zXIfSfh+1a1zaDh1cqhE7ZC5CL78CiO9p1d2IwsJwK
	EmDRheICarm57793XbtQbx+ntsHINDPYsx2WcClIZZYt8UvFnGy0An/P1HQHcP6rP0S4LG
	jf2vt61KTkNhkzL8j/te9Nbmj2WAbjHTL4azK+oWhoqoF8tTjKlynwneRypqHThIaalgPv
	0xFusQRw07tlCipFskOb9imQYsUIiVBc4JomRa0Z/LqZ0shrkWuMGFqGYY+JhUHp+aIEQh
	smfwsiX4dDinhoHAPf4metN0Wp5kNUiQY2lvpDUWSMqVL0WfHmzk1lsn9aySnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1712205632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=kE06ODyDv7LpjuZm1itjYyzIs393wMc50zgjG2XOxGY=;
	b=fZR1pS2gn3ql3UCMtUH4Sgmv+nWgI/KydctI1iGNJJn6QF8nZ0lRe94T8ggfBOtY8n9/YK
	ssyWt1GAvxoKRsWNz6CeDpfI89qZrBGqKvEPU976iEwlkjWduisH71WKts/ulEe6fNNCd/
	TQcYjyDA49z5Oo5Kh8Ahq/KQ2pXCVuBZnrb7SS6DqSbPKrqriNuT+dZkrDfv3iuz4OmMVA
	FAMTAs3duUi9qZzBRJHTEoCbVBZ0s+HF/pnf2+9w9BPSqGiK0YBqmVm3m8lsbZBX0O1knM
	TP+9xUNpYKQ4KAkH1EYYDWI48qoT/Y7YMvhKYfVAuPmEC0TXw8YJDnPADmlCQw==
ARC-Authentication-Results: i=1;
	rspamd-86f86f958-whfbb;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Attack-Shelf: 22ef8a991d61e9b9_1712205632333_1916259985
X-MC-Loop-Signature: 1712205632333:3366858372
X-MC-Ingress-Time: 1712205632333
Received: from pdx1-sub0-mail-a235.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.125.113.83 (trex/6.9.2);
	Thu, 04 Apr 2024 04:40:32 +0000
Received: from kmjvbox.templeofstupid.com (c-73-222-159-162.hsd1.ca.comcast.net [73.222.159.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a235.dreamhost.com (Postfix) with ESMTPSA id 4V987M6CqnzTK
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 21:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1712205631;
	bh=kE06ODyDv7LpjuZm1itjYyzIs393wMc50zgjG2XOxGY=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=caiU1hhFuLHmOXH/bmpsvb5OEP9TMe/Cja818DY3HvLMi24UQtjm5lWlCxXLggL/Z
	 m5cHe8tN5CYbxqziAgCiz92aGITCgkrx/8zdo7Sk2Wrh02vqFFPE6zIFaaE8ya1iwy
	 KwrN2HJkzD+Bp2jjzP2j6S9MC0HbpYAJ9o1GpfYxPpq/FZyh4+eKGF5YcqeyvlD70n
	 gNV5If3HTDFErkP5RRa/eijw8U9MUGH3WTiSYAa7k2RVk4RG/2a7pjE9/PokOKtzmZ
	 DTwdu9S+scgUD1CWqQjEPH0u2k5kUBeCIv+Tserv5D37Elksiuty+5YwCILcBcQXjO
	 SBbLHw6nZxKKQ==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e0189
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Wed, 03 Apr 2024 21:40:28 -0700
Date: Wed, 3 Apr 2024 21:40:28 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ali Saidi <alisaidi@amazon.com>,
	David Reaver <me@davidreaver.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Limit stage2_apply_range() batch size to
 smallest block
Message-ID: <20240404044028.GA1976@templeofstupid.com>
References: <cover.1711649501.git.kjlx@templeofstupid.com>
 <ebf0fac84cb1d19bdc6e73576e3cc40a9cab0635.1711649501.git.kjlx@templeofstupid.com>
 <ZgbGtpj5mStTkAkn@linux.dev>
 <20240329191537.GA2051@templeofstupid.com>
 <87r0fsrpko.wl-maz@kernel.org>
 <20240402170052.GA1988@templeofstupid.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402170052.GA1988@templeofstupid.com>

On Tue, Apr 02, 2024 at 10:00:53AM -0700, Krister Johansen wrote:
> On Sat, Mar 30, 2024 at 10:17:43AM +0000, Marc Zyngier wrote:
> > On Fri, 29 Mar 2024 19:15:37 +0000,
> > Krister Johansen <kjlx@templeofstupid.com> wrote:
> > > On Fri, Mar 29, 2024 at 06:48:38AM -0700, Oliver Upton wrote:
> > > > On Thu, Mar 28, 2024 at 12:05:08PM -0700, Krister Johansen wrote:
> > > > > Further reducing the stage2_apply_range() batch size has substantial
> > > > > performance improvements for IO that share a CPU performing an unmap
> > > > > operation.  By switching to a 2mb chunk, IO performance regressions were
> > > > > no longer observed in this author's tests.  E.g. it was possible to
> > > > > obtain the advertised device throughput despite an unmap operation
> > > > > occurring on the CPU where the interrupt was running.  There is a
> > > > > tradeoff, however.  No changes were observed in per-operation timings
> > > > > when running the kvm_pagetable_test without an interrupt load.  However,
> > > > > with a 64gb VM, 1 vcpu, and 4k pages and a IO load, map times increased
> > > > > by about 15% and unmap times increased by about 58%.  In essence, this
> > > > > trades slower map/unmap times for improved IO throughput.
> > > > 
> > > > There are other users of the range-based operations, like
> > > > write-protection. Live migration is especially sensitive to the latency
> > > > of page table updates as it can affect the VMM's ability to converge
> > > > with the guest.
> > > 
> > > To be clear, the reduction in performance was observed when I
> > > concurrently executed both the kvm_pagetable_test and a networking
> > > benchmark where the NIC's interrupts were assigned to the same CPU where
> > > the pagetable test was executing.  I didn't see a slowdown just running
> > > the pagetable test.
> > 
> > Any chance you could share more details about your HW configuration
> > (what CPU is that?)  and the type of traffic? This is the sort of
> > things I'd like to be able to reproduce in order to experiment various
> > strategies.
> 
> Sure, I only have access to documentation that is publicly available.
> 
> The hardware where we ran into this inititally was Graviton 3, which is
> a Neoverse-V1 based core.  It does not support FEAT_TLBIRANGE.  I've
> also tested on Graviton 4, which is Neoverse-V2 based.  It _does_
> support FEAT_TLBIRANGE.  The deferred range based invalidation
> support, was enough to allow us to teardown a large VM based on 4k pages
> and not incur a visible performance penalty.  I haven't had a chance to
> test to see if and how Will's patches change this, though.

Just a quick followup that I did test Will's patches and didn't find
that it changed the performance of the workload that I'd been testing.
IOW, I wasn't able to discern a network performance difference between
the baseline and those changes.

Thanks,

-K

