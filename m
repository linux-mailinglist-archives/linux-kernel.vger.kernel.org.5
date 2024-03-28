Return-Path: <linux-kernel+bounces-123469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 574BC89090F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CF3D29A030
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49A9137C29;
	Thu, 28 Mar 2024 19:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="WnHXoDHX"
Received: from buffalo.tulip.relay.mailchannels.net (buffalo.tulip.relay.mailchannels.net [23.83.218.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C5F80BE0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653708; cv=pass; b=Gr5I28Z82PUk693N7vBOvp3+aB8g1GGKIWqmhuDwnPXO2jvZWhARskhawcVTzFowiBBB1ZwWK0lhR+7d/BbQFKexUcGZRsCgNE7BVDn2PZ+/GjBYkEzUzrQoxg75r7IrJI/gata378i3s7GgCPPe3P9RagRFrPMjOs880C6Iylo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653708; c=relaxed/simple;
	bh=qTPJImufvV5ASN7LhY3I4AeFqA1N1hCnHDloI+wmFfY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=V/SwNAatFwmBl7tz3cqP2aAHFoAOOCHfTF8sUoNek3tiF0P6Ka7eDjdYlFXVsPjxzzQNcEFOm7nAQ1dCd1tAdFCSH6X6v0Ma4ReCPrddYEgg8HtY7iTiUNldRCboQKwamTgOW30CCb/iR2/WiWK7cREORNTuSl/BVe4oXOYCHKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=WnHXoDHX; arc=pass smtp.client-ip=23.83.218.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1E4972C278A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:04:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a310.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id AD2862C1CCC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:04:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1711652683; a=rsa-sha256;
	cv=none;
	b=aLBi5T86flY2pOvuFvje/oHcIRq+P4iypHemUWLw0OhxfJ9PA5xAFKLcmlTJsbPJXiL2qq
	1cE9+uGyqiyUy1lAy6js+G4oN6H496DoEtVkF3kT9m10Ouf1D3gGZsXLAEVI3JXliIm1Gl
	eJ65MEPHKtHTFCXd/DsTW//mKAKktcpJAfkat1nIT0qivjQesJ1EKo/gv3sLdhQ54JbB9k
	rR9bZIbCHXURwelGUG1N/t2NYxMCozTwtXHZnHN91DupSFMUqpS3JjWPrqL1b/6iO7q4zb
	Xt96aqQo04y+I9xTH0qacijGxZ9cJUqv6bRHYL6X46fuRbttvH4pWH7ytmcoeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1711652683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 dkim-signature; bh=M4mKD0+XXr3iAcqde4xMt3RYAlgHRmBZwIlXckXewGA=;
	b=DVkSjQrkVvMy20UgW1BqGG0CMyQdxf/MC+qKj0WP6se+FSMRP50lsnTktOv4SXOmpwNe96
	R3CXpdUUax1kBdlll/xsitgtuhbtB9+ZiKKugLlv9ClROd1I0x9qBrtxrxgxqW5e2EvQa0
	uvAZfFpcSyoFUQKTS8FH7qNFvP9RCuYiwIrBdqgyB/4kWqJwHTN4ismYKidHXlH0RfrWyh
	K1/i3T57redu0+hw2I+X7LczaDEx06vc9fCF8B8q/4AmqT44X2diKlTX9b1jXo7x5tEnEG
	ZQwjfBSIf00el+VP1F2BwTOazy0GKJ81FuOqSTNS4eymxIz1zyJO87VVhi422A==
ARC-Authentication-Results: i=1;
	rspamd-699949c56f-gmpvn;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Befitting-Drop: 6099396338a483bb_1711652683931_1959291487
X-MC-Loop-Signature: 1711652683931:1342331129
X-MC-Ingress-Time: 1711652683931
Received: from pdx1-sub0-mail-a310.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.168.172 (trex/6.9.2);
	Thu, 28 Mar 2024 19:04:43 +0000
Received: from kmjvbox.templeofstupid.com (c-73-222-159-162.hsd1.ca.comcast.net [73.222.159.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a310.dreamhost.com (Postfix) with ESMTPSA id 4V5Cdl2sM8z110
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1711652683;
	bh=M4mKD0+XXr3iAcqde4xMt3RYAlgHRmBZwIlXckXewGA=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=WnHXoDHXUZidboTfj3roSTDzbx78PWzOsLwhc476sRls+4jUuF4xDVB2Ayod4B7Fd
	 aD8mm4lyqEjaUBeiRPkQ3KHx5Tg50DouCuB8HCuEXLrVvej7FmNMM9+AGexD4bouMI
	 f+TyZuORVetGCIVJglKsPSr2yamNSFamqULjS5JQzk7Z9M9LgZtZ1Mm7Q2wdusvJlG
	 +7JCQwN26yRX06tPWH8pTrulbL6Dv2q6YNruPKx2Tn7DHLd+MAjR2R276UUY4OqfDJ
	 Unh6y0n4LxRAsxZNGHyhJi2MsRTPxOgCQ190Zqp7eTWs1v+t2nizF/0AzO7q6rlHwI
	 qRhR1P3SH9uDw==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e004a
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Thu, 28 Mar 2024 12:04:34 -0700
Date: Thu, 28 Mar 2024 12:04:34 -0700
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
Subject: [RFC] KVM: arm64: improving IO performance during unmap?
Message-ID: <cover.1711649501.git.kjlx@templeofstupid.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
Ali and I have been looking into ways to reduce the impact a unmap_stage2_range
operation has on IO performance when a device interrupt shares the cpu where the
unmap operation is occurring.

This came to our attention after porting a container VM / hardware virtualized
containers workload to arm64 from x86_64.  On ARM64, the unmap operations took
longer. kvm_tlb_flush_vmid_ipa runs with interrupts disabled.  Unmaps that don't
check for reschedule promptly may delay the IO.

One approach that we investigated was to modify the deferred TLBI code to run
even if range based operations were not supported.  (Provided FWB is enabled).
If range based operations were supported, the code would use them.  However, if
the CPU didn't support FEAT_TLBIRANGE or the unmap was larger than a certain
size, we'd fall back to vmalls12e1is instead.  This reduced the performance
impact of the unmap operation to less than 5% impact on IO performance.
However, with Will's recent patches[1] to fix cases where free'd PTEs may still
be referenced, we were concerned this might not be a viable approach.

As a follow-up to this e-mail, I'm sending a patch for a different approach.  It
shrinks the stage2_apply_range batch size to the minimum block size instead of
the maximum block size.  This eliminates the IO performance regressions, but
increases the overall map / unmap operation times when the CPU is receiving IO
interrupts.  I'm unsure if this is the optimal solution, however, since it may
generate extra unmap walks on 1gb hugepages. I'm also unclear if this creates
problems for any of the other users of stage2_apply_range().

I'd love to get some feedback on the best way to proceed here.

Thanks,

-K

[1] https://lore.kernel.org/kvmarm/20240325185158.8565-1-will@kernel.org/

