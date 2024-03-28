Return-Path: <linux-kernel+bounces-123470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD11890910
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9191F27EF0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B55137C52;
	Thu, 28 Mar 2024 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="jqJ3pmAW"
Received: from hedgehog.birch.relay.mailchannels.net (hedgehog.birch.relay.mailchannels.net [23.83.209.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D537E80BE0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653714; cv=pass; b=ON1BxCRsJlX9OLUDw2Ind9maGKLoSDKX9e6SSaI3FxnkEOwEvy6m1YF+pe7NpbyGbB84MRzfOX9kM68mhl7UktD4gi+1kgPX2jIL/1v2SMDoZAh1szq8eLyrkP+nxf0f84NJcnWdAoyruEzDeeTQ/Aehzxna+NpSDLDTpTacSfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653714; c=relaxed/simple;
	bh=gx9qPOOQKHzVmVAf8SKh3hRmJgVS3K5xbQ++1OuXNYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdxgf4ndLYZRo+d76+hIS4qwTSW7yxHlydddCr7j7Zz4E3X7EjqMd1ioxxfXkS68vPU7yt0jxQPbxt56sEOBKxaoNwx5/yFJHT7+jZp1/NR9Z6c18xvFs3hODmOTWyEuZYwSGA0aOMSA4dxip0Opaoj+JAawXPhN0W5zZkJlvHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=jqJ3pmAW; arc=pass smtp.client-ip=23.83.209.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 79B5E100558
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:05:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a310.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 09C29102BC9
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:05:18 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1711652718; a=rsa-sha256;
	cv=none;
	b=okEpkO9FUBqnbY70r+DkpqAXjbFwPosF5kpb0QXy4iXQJkvXzY8gfkh5mBzyxbRTNmrarI
	A97DqNQenzhvVJu2troA3yWzm80vjJQyX4D7E86TFT9qT/f0FBFizLuxTqT2Zhq88rxfmQ
	KRvL5kz/EEDZFXtuWL4Hc/sXfCPrnDE2ize+REdry1LlrW3As9+5sVOlWg+MPIhLh+8G3J
	90IcZmyyxRsRGI3eQ3OA2Sb4ahIEmyi2QwnhW97CcEYbL5R/BXi5+03NX2B5JQyOjvSiUI
	/AFQzgr0a8FJllHleBZLkQNwVv0THigvgk0dUTI2zIOPNipbmZ5XDE2A5pC1ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1711652718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=CyPAt3OCMyMrdjD1IpXOFJVGM6jxVVGih0kVtDn4WME=;
	b=31cNtM3Eron7yzovJ9U4jYIpK3lKBw11acGASqL2K4EkD9Dxm2iPVQsV4zX19RmQakkJ+u
	+seTag6T6MhOZE9NkyetHAnmx6iuVJ8H25oKUJB/1EFfwjqbULBO1U5OsIRu4tAxkUvWJS
	rC6jgqlNa1tDmeLUvnWIiVmWc9n9e2y/ylrxSRdQ+LnSfi2gM1gtl9AihECBuTD1hylzxk
	YGX5hsAJ/NNCAXT8VAekYBPvf4a5xuIjGWKRONywYVdWle6rctn8BKzD7WY+uJLCFJCNUW
	v4gR4cw407rj3ZkNR9ppVab5xxlNCUAn7LKr8FYpcNMZA+d/zq4aX6gVNNOdCw==
ARC-Authentication-Results: i=1;
	rspamd-699949c56f-t4wlw;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Tangy-Rock: 79566ced6cd99ec4_1711652718388_787268094
X-MC-Loop-Signature: 1711652718388:871828371
X-MC-Ingress-Time: 1711652718388
Received: from pdx1-sub0-mail-a310.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.126.216.122 (trex/6.9.2);
	Thu, 28 Mar 2024 19:05:18 +0000
Received: from kmjvbox.templeofstupid.com (c-73-222-159-162.hsd1.ca.comcast.net [73.222.159.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a310.dreamhost.com (Postfix) with ESMTPSA id 4V5CfP2dB6z1Q0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1711652717;
	bh=CyPAt3OCMyMrdjD1IpXOFJVGM6jxVVGih0kVtDn4WME=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=jqJ3pmAW3waag/++QEaE8tUYDpx3YpdCdmhNqEwcrk8aSXEAiJLSlXveFT9+4R+cx
	 getQ3q2UTJ53OK06i3DARckFWw7yC3nxYDvWB6s9bM0UgszOYia8maTBtvhQmirmQR
	 ID9VjsHHQj71u8OJ8dceCBvSkjsy/2613Gm9tujlQXJCRZ/oH1poe2PIdLoxdKZp0R
	 P2JJtHncKWq4DJwPSMfLnHGK7pnVozMgC43fgR38tW0xl/Hw1Nvjtu2yjNWzZC5WzA
	 R1Jlas3KePcId4VF+rGvNLMb0AaU08i4TxZKUsMXB3sX7RHbA/2ahiLfpiSNEdTYBH
	 TzsyIrmNh7pVA==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e004a
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Thu, 28 Mar 2024 12:05:08 -0700
Date: Thu, 28 Mar 2024 12:05:08 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Cc: James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ali Saidi <alisaidi@amazon.com>,
	David Reaver <me@davidreaver.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: arm64: Limit stage2_apply_range() batch size to
 smallest block
Message-ID: <ebf0fac84cb1d19bdc6e73576e3cc40a9cab0635.1711649501.git.kjlx@templeofstupid.com>
References: <cover.1711649501.git.kjlx@templeofstupid.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1711649501.git.kjlx@templeofstupid.com>

stage2_apply_range() for unmap operations can interfere with the
performance of IO if the device's interrupts share the CPU where the
unmap operation is occurring.  commit 5994bc9e05c2 ("KVM: arm64: Limit
stage2_apply_range() batch size to largest block") improved this.  Prior
to that commit, workloads that were unfortunate enough to have their IO
interrupts pinned to the same CPU as the unmap operation would observe a
complete stall.  With the switch to using the largest block size, it is
possible for IO to make progress, albeit at a reduced speed.

This author tested network and storage where the interrupts were pinned
to the same CPU where an unmap was occurring and found that throughput
was reduced about 4.75-5.8x for networking, and 65.5x-500x for storage.

The use-case where this has been especially painful is with hardware
virtualized containers.  Many containers have a short lifetime and may
be run on systems where the host is intentionally oversubscribed. This
limits the options for pinning and prefaulting.  Although NIC interrupts
allow their CPU affinity to be altered, some NVMe devices do not permit
it.  Some cloud-block storage devices have only a few queues, which
means unlucky placement can have high performance impact.

Further reducing the stage2_apply_range() batch size has substantial
performance improvements for IO that share a CPU performing an unmap
operation.  By switching to a 2mb chunk, IO performance regressions were
no longer observed in this author's tests.  E.g. it was possible to
obtain the advertised device throughput despite an unmap operation
occurring on the CPU where the interrupt was running.  There is a
tradeoff, however.  No changes were observed in per-operation timings
when running the kvm_pagetable_test without an interrupt load.  However,
with a 64gb VM, 1 vcpu, and 4k pages and a IO load, map times increased
by about 15% and unmap times increased by about 58%.  In essence, this
trades slower map/unmap times for improved IO throughput.

This introduces KVM_PGTABLE_MAX_BLOCK_LEVEL, and then uses it to limit
the size of stage2_apply_range() chunks to the smallest size that's
addressable via a block mapping -- 2mb on a 4k granule size.

Cc: <stable@vger.kernel.org> # 5.15.x: 3b5c082bbfa2: KVM: arm64: Work out supported block level at compile time
Cc: <stable@vger.kernel.org> # 5.15.x: 5994bc9e05c2: KVM: arm64: Limit stage2_apply_range() batch size to largest block
Cc: <stable@vger.kernel.org> # 5.15.x
Suggested-by: Ali Saidi <alisaidi@amazon.com>
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 4 ++++
 arch/arm64/kvm/mmu.c                 | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 19278dfe7978..b0c4651a4d9a 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -19,11 +19,15 @@
  *  - 4K (level 1):	1GB
  *  - 16K (level 2):	32MB
  *  - 64K (level 2):	512MB
+ *
+ *  The max block level is the _smallest_ supported block size for KVM.
  */
 #ifdef CONFIG_ARM64_4K_PAGES
 #define KVM_PGTABLE_MIN_BLOCK_LEVEL	1
+#define KVM_PGTABLE_MAX_BLOCK_LEVEL	2
 #else
 #define KVM_PGTABLE_MIN_BLOCK_LEVEL	2
+#define KVM_PGTABLE_MAX_BLOCK_LEVEL	KVM_PGTABLE_MIN_BLOCK_LEVEL
 #endif
 
 #define kvm_lpa2_is_enabled()		system_supports_lpa2()
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index dc04bc767865..1e927b306aee 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -41,7 +41,7 @@ static phys_addr_t __stage2_range_addr_end(phys_addr_t addr, phys_addr_t end,
 
 static phys_addr_t stage2_range_addr_end(phys_addr_t addr, phys_addr_t end)
 {
-	phys_addr_t size = kvm_granule_size(KVM_PGTABLE_MIN_BLOCK_LEVEL);
+	phys_addr_t size = kvm_granule_size(KVM_PGTABLE_MAX_BLOCK_LEVEL);
 
 	return __stage2_range_addr_end(addr, end, size);
 }
-- 
2.25.1


