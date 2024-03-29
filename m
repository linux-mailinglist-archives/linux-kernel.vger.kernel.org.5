Return-Path: <linux-kernel+bounces-125322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60F48923F7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE281C2242D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC771311AC;
	Fri, 29 Mar 2024 19:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="NQQc8MK0"
Received: from weasel.tulip.relay.mailchannels.net (weasel.tulip.relay.mailchannels.net [23.83.218.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5775225A8
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.247
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711739749; cv=pass; b=S7+JaUCzE0ERcUzEmpGvuLQPqA7KNiW+3ZwqbUt2y3sp2fNzZZszapoXiqxl9eENEAaF2SQfxtqwPYBvAQIby/3m7kphqHFinEJRF2z7D8QmiZ7bNQO8dA8yFpGhMhnaPaj8dBecQiXOM8wbOw4+9Zq/hnXar5QztrA89h8WGvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711739749; c=relaxed/simple;
	bh=iOaS0dTkfcP+SU/f5iG3clrpiLMk4p12ElyX3Y4YXxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soR53J5l/SKNt2y8lrJb2E/G2bWoU35/u0Q2PoJ6Hmcn34EmG6DK6B4tv2hQh8Aef8G68N+rGeYH1QGpRUEN9TnZo1jWxxUD1V2fa7IKLBmfrEVKUK9HqAhs6EQDq3xPM5Kir6smNMAVsE1tHh07lKUcP4lx2IqCDDx+7mTKcCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=NQQc8MK0; arc=pass smtp.client-ip=23.83.218.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 195B6C2E9B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 19:15:46 +0000 (UTC)
Received: from pdx1-sub0-mail-a283.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B041CC2CE1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 19:15:45 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1711739745; a=rsa-sha256;
	cv=none;
	b=q/u7m64wupglLOHdkBkI8MpaSRLFsDl7vKQKnfVX8OcqD265OJfTigaPvuxZx7qK+2izxR
	Km7zbO343IMfXKDOjg6PJiYASk56atLYe0Gz4JjBAlR4mgL8xQ3wZc4uE/AM0sHqt/D0WR
	4ftJsVHqCJYPzMr4CsuTxtmbhFT/u8LPuJY0Hch4GypCYB46Ez8vBpOMhJB+f2mY5SSH5A
	UvpS8uyL7HcxYqTXQegBV0NsVXkecdn6DNVBd/vGcfQ7fbFRoQ4J82+mLOKZXpIKR/TEfl
	oYA5dMeUFA3FHSo5F353W+XkDwl41H8IxS/OjrCGZSpjUhqSRxWzb61ror696A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1711739745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=EnlZ5bLVy+yCG0ojGQujTIq4MzqFgRZKmBSDVDyKsvw=;
	b=X4waSwCPtNsp5fare4dWfk04kmrBuQY8SE4Vv2cO2gY1FXGuoBSmrCGGZ30VNX0PXAHZ8T
	1Bn4t2/2pOTWS46ValAqTxpf8+mddVL8PWgnkumIid7r8MFbRAjx+9aH82+7+0abbqpBQh
	f8lWlffkOniHtUaNz/12ZpfAGpyQHAdeSCvLbF6383FkJbXmzYP+7L6H42Xgd3nmq2/cwG
	OP/dhPmIQupuGZTiXOFOCiFF7PfJXotPyKjb/fxVaEWk9CrdUOuRPxPqxsj8D7NcfRDiED
	AmqWE+nVgzQHHVa7RErWSW0KlUWX6OtUp7mz0KRZ61fEIUsxRqkuLyNc+KllTA==
ARC-Authentication-Results: i=1;
	rspamd-699949c56f-t4wlw;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Arithmetic-Abiding: 5b964ffa53fe2a3e_1711739745995_3816288518
X-MC-Loop-Signature: 1711739745995:80590942
X-MC-Ingress-Time: 1711739745995
Received: from pdx1-sub0-mail-a283.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.126.216.122 (trex/6.9.2);
	Fri, 29 Mar 2024 19:15:45 +0000
Received: from kmjvbox.templeofstupid.com (c-73-222-159-162.hsd1.ca.comcast.net [73.222.159.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a283.dreamhost.com (Postfix) with ESMTPSA id 4V5qr10163z9r
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 12:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1711739745;
	bh=EnlZ5bLVy+yCG0ojGQujTIq4MzqFgRZKmBSDVDyKsvw=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=NQQc8MK0iSg8t46rKs0l7KChbqPJCT3UV27c+dIAnyjDkYes8WOqyLB4LKMcGaSFh
	 aLtq/6IDeEDZesWoKYY8UXpgBSsA2aFLPemwD6WRqhTR8F5QNE4JIqtCyC9jFMXROA
	 qe5qZ6DRT7IfQ3keIAbLB4IsRBJ/jsK/Yi4vGPycjtBdRFp48g+/XuPEx/dEC5W03D
	 0jqqpTEbdgfwqmQANlsb8UK39J6eybUomYdkdTmcEffvQlTLm+MkwdLXslXUjSwzYF
	 8M2FH/28q6nsnU40rH9ZoIhy2E1Rw0WgBPEhLiLVHCC4ioLmkWd0zz7lhELw8Mty5m
	 tSCIX+Rx9lzcQ==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e0098
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Fri, 29 Mar 2024 12:15:37 -0700
Date: Fri, 29 Mar 2024 12:15:37 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ali Saidi <alisaidi@amazon.com>,
	David Reaver <me@davidreaver.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Limit stage2_apply_range() batch size to
 smallest block
Message-ID: <20240329191537.GA2051@templeofstupid.com>
References: <cover.1711649501.git.kjlx@templeofstupid.com>
 <ebf0fac84cb1d19bdc6e73576e3cc40a9cab0635.1711649501.git.kjlx@templeofstupid.com>
 <ZgbGtpj5mStTkAkn@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgbGtpj5mStTkAkn@linux.dev>

Hi Oliver,
Thanks for the response.

On Fri, Mar 29, 2024 at 06:48:38AM -0700, Oliver Upton wrote:
> On Thu, Mar 28, 2024 at 12:05:08PM -0700, Krister Johansen wrote:
> > stage2_apply_range() for unmap operations can interfere with the
> > performance of IO if the device's interrupts share the CPU where the
> > unmap operation is occurring.  commit 5994bc9e05c2 ("KVM: arm64: Limit
> > stage2_apply_range() batch size to largest block") improved this.  Prior
> > to that commit, workloads that were unfortunate enough to have their IO
> > interrupts pinned to the same CPU as the unmap operation would observe a
> > complete stall.  With the switch to using the largest block size, it is
> > possible for IO to make progress, albeit at a reduced speed.
> 
> Can you describe the workload a bit more? I'm having a hard time
> understanding how you're unmapping that much memory on the fly in
> your workload. Is guest memory getting swapped? Are VMs being torn
> down?

Sorry I wasn't clear here.  Yes, it's the VMs getting torn down that's
causing the problems.  The container VMs don't have long lifetimes, but
some may be up to 256Gb in size, depending on the user.  The workloads
running the VMs aren't especially performance sensitive, but their users
do notice when network connections time-out.  IOW, if the performance is
bad enough to temporarily prevent new TCP connections from being
established or requests / responses being recieved in a timely fashion,
we'll hear about it.  Users deploy their services a lot, so there's a
lot of container vm churn.  (Really it's automation redeploying the
services on behalf of the users in response to new commits to their
repos...)

> Also, it seems a bit odd to steer interrupts *into* the workload you
> care about...

Ah, that was only intentionally done for the purposes of measuring the
impact.  That's not done on purpose in production.

Nevertheless, the example we tend to run into is that a box may have 2
NICs and each NIC has 32 Tx-Rx queues.  This means we've got 64 NIC
interrupts, each assigned to a different CPU.  Our systems have 64 CPUs.
What happens in practice is that a VM will get torn down, and that has a
1-in-64 chance of impacting the performance of the subset of the flows
that are mapped via RSS to the interrupt that happens to be assigned to
the CPU where the VM is being torn down.

Of course, the obvious next question is why not just bind the VMs flows
to the CPUs the VM is running on?  We don't have a 1:1 mapping of
network device to VM, or VM to CPU right now, which frustrates this
approach.

> > Further reducing the stage2_apply_range() batch size has substantial
> > performance improvements for IO that share a CPU performing an unmap
> > operation.  By switching to a 2mb chunk, IO performance regressions were
> > no longer observed in this author's tests.  E.g. it was possible to
> > obtain the advertised device throughput despite an unmap operation
> > occurring on the CPU where the interrupt was running.  There is a
> > tradeoff, however.  No changes were observed in per-operation timings
> > when running the kvm_pagetable_test without an interrupt load.  However,
> > with a 64gb VM, 1 vcpu, and 4k pages and a IO load, map times increased
> > by about 15% and unmap times increased by about 58%.  In essence, this
> > trades slower map/unmap times for improved IO throughput.
> 
> There are other users of the range-based operations, like
> write-protection. Live migration is especially sensitive to the latency
> of page table updates as it can affect the VMM's ability to converge
> with the guest.

To be clear, the reduction in performance was observed when I
concurrently executed both the kvm_pagetable_test and a networking
benchmark where the NIC's interrupts were assigned to the same CPU where
the pagetable test was executing.  I didn't see a slowdown just running
the pagetable test.

> > Cc: <stable@vger.kernel.org> # 5.15.x: 3b5c082bbfa2: KVM: arm64: Work out supported block level at compile time
> > Cc: <stable@vger.kernel.org> # 5.15.x: 5994bc9e05c2: KVM: arm64: Limit stage2_apply_range() batch size to largest block
> > Cc: <stable@vger.kernel.org> # 5.15.x
> 
> This is a performance improvement, *not* a correctness fix. Please don't
> cc stable for it.

Apologies.  I consulted the Stable Rules[1] before applying these tags and
the guidance it gave was just that "It must either fix a real bug that
bothers people."

In our case, the teardown causes TCP throughput to drop from 9.5Gbps to
about 2Gbps during a teardown, which is something that does bother our
users.

> > ---
> >  arch/arm64/include/asm/kvm_pgtable.h | 4 ++++
> >  arch/arm64/kvm/mmu.c                 | 2 +-
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> > index 19278dfe7978..b0c4651a4d9a 100644
> > --- a/arch/arm64/include/asm/kvm_pgtable.h
> > +++ b/arch/arm64/include/asm/kvm_pgtable.h
> > @@ -19,11 +19,15 @@
> >   *  - 4K (level 1):	1GB
> >   *  - 16K (level 2):	32MB
> >   *  - 64K (level 2):	512MB
> > + *
> > + *  The max block level is the _smallest_ supported block size for KVM.
> 
> This feels like a non sequitur given the old comment is left in place...

I'll fix if we keep this approach.  Is the objection to the name
KVM_PGTABLE_MAX_BLOCK_LEVEL or just the comment?

> >   */
> >  #ifdef CONFIG_ARM64_4K_PAGES
> >  #define KVM_PGTABLE_MIN_BLOCK_LEVEL	1
> > +#define KVM_PGTABLE_MAX_BLOCK_LEVEL	2
> >  #else
> >  #define KVM_PGTABLE_MIN_BLOCK_LEVEL	2
> > +#define KVM_PGTABLE_MAX_BLOCK_LEVEL	KVM_PGTABLE_MIN_BLOCK_LEVEL
> >  #endif
> >  
> >  #define kvm_lpa2_is_enabled()		system_supports_lpa2()
> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index dc04bc767865..1e927b306aee 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -41,7 +41,7 @@ static phys_addr_t __stage2_range_addr_end(phys_addr_t addr, phys_addr_t end,
> >  
> >  static phys_addr_t stage2_range_addr_end(phys_addr_t addr, phys_addr_t end)
> >  {
> > -	phys_addr_t size = kvm_granule_size(KVM_PGTABLE_MIN_BLOCK_LEVEL);
> > +	phys_addr_t size = kvm_granule_size(KVM_PGTABLE_MAX_BLOCK_LEVEL);
> >  
> >  	return __stage2_range_addr_end(addr, end, size);
> >  }
> 
> This doesn't feel right to me. A property that we had before is that
> leaf entries are visited at most once, since every mapping size was
> evenly divisible into KVM_PGTABLE_MIN_BLOCK_LEVEL.
> 
> Seems like we could wind up visiting a PUD mapping 512 times, at least
> for 4K pages.

I have an idea, but it seems to go against the current design of the
pagtable walkers.  My sense was that they've been written to
discourage passing mutable state to the function that calls
kvm_pgtable_walk().  If we were willing to permit this, it seems like we
could leverage __kvm_pgtable_visit()'s knowledge about the size of the
mapping it walked to determine whether range_addr_end should be
incremented by our BLOCK_LEVEL constant, or advanced to the end of the
mapping that was already successfully walked.  (If I'm reading right,
anyway)  Does that seem like a reasonable approach?

If we do modify the walk to allow state to be passed back, I have a
second patch I'd like to send you.  Ali found that there was a
performance regression on the kvm_pagetable_test on the map creation
step when a large number of threads operated on a comparatively small
memory range.  (E.g. 64 cpus and 8g of RAM).  We debugged this a bit and
found that there's an unmap in the map creation step if the test ends up
instantiating a readable zero page that needs to be copied and made
writable.  With the deferred TLBI logic, the tlb invalidation happens at
the end of the unmap operation whether a PTE is cleared or not.  With so
many threads, this doesn't always suceeed. The prior approach of just
doing the invalidation in stage2_unmap_put_pte() outperforms the
deferred invalidation, because stage2_unmap_put_pte() only calls
__kvm_tlb_flush_vmid_ipa() if it clears a valid PTE.  If we modify the
walk to keep state on whether any PTEs are successfully cleared, and
condition the deferred invalidation on that state, we obtain performance
that is equivalent to the pre range based deferred invalidation
approach.

Thanks,

-K

