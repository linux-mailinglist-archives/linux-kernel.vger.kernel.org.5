Return-Path: <linux-kernel+bounces-75455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5034D85E8F3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A7C28528B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B650886631;
	Wed, 21 Feb 2024 20:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LbgD4kWu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iDeVqb1X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDDA85958;
	Wed, 21 Feb 2024 20:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708546921; cv=none; b=JHlpKtOeKDcAopxhanRJfbU2lYuxtv58IBc899sqi2LC9Ft3eYAU4HAgzUPL8LAHmMfOj9rM/nLlQi8N2BKKEZDkX7CdMRabqmVcwLK53kahc3Dvy6bUEcu9W0c1hg4m222rHVIo9X7fZFWxoNLxb8ob4W2lkqBrzH5FUFp3L8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708546921; c=relaxed/simple;
	bh=ImC36rMMHpLz4+5E+KQEQoxCcH+ZOWrg6nxm1kytxdU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=davt3baTd1T1N0byLQPsVXDAajVrjnxd3oKC7KD55yW7J3uyoyn/0/Vz/cn0ObNkYXec8RPaNPCXOOhchkFdBXOYZ2a2bu4mRaraUB3/Uh3/88a3toq4QlnSxeX9o/LvpXw/Wv+tXei7o+rtJLqzJgfFi81YQZe1h9Rz30Lgf9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LbgD4kWu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iDeVqb1X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 Feb 2024 20:21:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708546916;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LYXevElDZUwwcuCssk+PoziO3z76J9Zi3RvRyDyoi1s=;
	b=LbgD4kWufpeq1TOYGRUKiQExZAnKWyLFII5hLKB2PjBeRis7FYENAIloe9k+vw2+QbB4SK
	gGTQWL+bYEBqGCZh7uV/TqtkzSq9qxZN2oVpEBmSN6EmNpmFBpaPSU/q/dFwri7CAVFMCE
	7k6lfdLES/RIzA2kESPD5TWWZoDsgmEURn1V17jRFBbEAFg7uHmXS3blR+sauZLTUXI/D1
	qdrVdeqa+5PKNLYgxDCnjRcwQhXonK9RXcftuoPSeV1GKoinD4khk31AmY+hkAhUGlulf+
	yLhbjqw4J2CIhOrI+q/sfhQedtr8RF6E8YH8JPHL5HcDCJzXsbFEYqwAFuOLLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708546916;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LYXevElDZUwwcuCssk+PoziO3z76J9Zi3RvRyDyoi1s=;
	b=iDeVqb1X9KcQD36OakGQakXKCEVOt0v4bcQ5UJE6B7e0pMKkkATdkpRAYENpEQ5iciA6t4
	iu89mD3oIctU6KCw==
From: "tip-bot2 for Oliver Upton" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v3-its: Do not assume vPE tables are
 preallocated
Cc: George Cherian <gcherian@marvell.com>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, Thomas Gleixner <tglx@linutronix.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240219185809.286724-2-oliver.upton@linux.dev>
References: <20240219185809.286724-2-oliver.upton@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170854691584.398.7536977527591129636.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     ec4308ecfc887128a468f03fb66b767559c57c23
Gitweb:        https://git.kernel.org/tip/ec4308ecfc887128a468f03fb66b767559c57c23
Author:        Oliver Upton <oliver.upton@linux.dev>
AuthorDate:    Mon, 19 Feb 2024 18:58:06 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 21 Feb 2024 21:11:20 +01:00

irqchip/gic-v3-its: Do not assume vPE tables are preallocated

The GIC/ITS code is designed to ensure to pick up any preallocated LPI
tables on the redistributors, as enabling LPIs is a one-way switch. There
is no such restriction for vLPIs, and for GICv4.1 it is expected to
allocate a new vPE table at boot.

This works as intended when initializing an ITS, however when setting up a
redistributor in cpu_init_lpis() the early return for preallocated RD
tables skips straight past the GICv4 setup. This all comes to a head when
trying to kexec() into a new kernel, as the new kernel silently fails to
set up GICv4, leading to a complete loss of SGIs and LPIs for KVM VMs.

Slap a band-aid on the problem by ensuring its_cpu_init_lpis() always
initializes GICv4 on the way out, even if the other RD tables were
preallocated.

Fixes: 6479450f72c1 ("irqchip/gic-v4: Fix occasional VLPI drop")
Reported-by: George Cherian <gcherian@marvell.com>
Co-developed-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240219185809.286724-2-oliver.upton@linux.dev
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 53abd47..b822752 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3181,6 +3181,7 @@ static void its_cpu_init_lpis(void)
 	val |= GICR_CTLR_ENABLE_LPIS;
 	writel_relaxed(val, rbase + GICR_CTLR);
 
+out:
 	if (gic_rdists->has_vlpis && !gic_rdists->has_rvpeid) {
 		void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
 
@@ -3216,7 +3217,6 @@ static void its_cpu_init_lpis(void)
 
 	/* Make sure the GIC has seen the above */
 	dsb(sy);
-out:
 	gic_data_rdist()->flags |= RD_LOCAL_LPI_ENABLED;
 	pr_info("GICv3: CPU%d: using %s LPI pending table @%pa\n",
 		smp_processor_id(),

