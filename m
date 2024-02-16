Return-Path: <linux-kernel+bounces-68844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE248580E4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABB251F228D1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D478E14F9E0;
	Fri, 16 Feb 2024 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cFkJ0NK0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jRtCfgdC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E7514D442;
	Fri, 16 Feb 2024 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096651; cv=none; b=I/6aUnPWoJK4lfSkV+jKFMTEE5AUFBtja9MpLV92XqvQ7gsEBOFZ7u4BJFMzJRFLF+9BxfkZO5bUbAemfduFJejJCLZe8DOTLcOrjRpRt93IO70z79jh9+xiOnPflh4qmE02F8xYxSRmBefsiqildq7N1DtXAtjb0BfVJurzF68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096651; c=relaxed/simple;
	bh=L1rQBQWzHmSEkzvHpRK11yidKrq+3QvBtLlftmr6lno=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nOl6WFHjv1PMTolpBuUDJoO1nPsPQvmkgLAPO8LyQui4asPQ6+SaMwBS8g2RRt66JcURHl5bkGrWeZ50f3N1eLFrZqNRMvdl4d7KMOeLYaaS7QbcIg8cz0TDwi0QhO26wSDNbCpgqOAlWRBjfWGAjsW4kuy1fJjgViG0SgqkrLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cFkJ0NK0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jRtCfgdC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096647;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h8ZDmlexJ/FR3BGrh5ILsdK/ZmxMBOCgaz+OdPmZYrQ=;
	b=cFkJ0NK0oGPvNjKAIHRLxjylLcrg1miSEDSldu8+LaF3q8eBb6yLOcMtSD1SX5vN/e9KY+
	rbkVrw7ujvXnX2G5+y1wl0cKzkA3vJC7DFcVHsIZJ1pRn/uQ2wPa/XvcdL4aBipwyZuqu3
	VYpL0msjpx2bu6AMXPvATgmN5MOyn1FjaMB8I6SKzkVYcDzq/T5sneRiNYtgbAZDHxNGnZ
	jBOxZn3kUXjL1M/KFhsElqFfowkfrEY5xMlMb53HFLZ7Lk0RZUjGKXpaiAfbm5xVWfyGU5
	ZFG987EkEvtQSAHDhGC5wwETwBkThJhNicCsj2Z8P4V3fMxFloMU7YQFd5fo1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096647;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h8ZDmlexJ/FR3BGrh5ILsdK/ZmxMBOCgaz+OdPmZYrQ=;
	b=jRtCfgdCowTt30gnT9Mho8aVaG9oUA4KNQ5GzjGCI9kOCZm7lf2lEn6YJdU5jO8lwIvs+K
	z5TEfn0dHuOfNkBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/cpu: Remove x86_coreid_bits
Cc: Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Michael Kelley <mhklinux@outlook.com>,
 Zhang Rui <rui.zhang@intel.com>, Wang Wendy <wendy.wang@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240212153625.455839743@linutronix.de>
References: <20240212153625.455839743@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809664671.398.16532631441883708404.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     fab75e790f00dca592d9a934d9f1237b81093b99
Gitweb:        https://git.kernel.org/tip/fab75e790f00dca592d9a934d9f1237b81093b99
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:04:21 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:38 +01:00

x86/cpu: Remove x86_coreid_bits

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20240212153625.455839743@linutronix.de




---
 arch/x86/include/asm/processor.h | 2 --
 arch/x86/kernel/cpu/common.c     | 1 -
 2 files changed, 3 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 4fbeffd..de1648e 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -122,8 +122,6 @@ struct cpuinfo_x86 {
 #endif
 	__u8			x86_virt_bits;
 	__u8			x86_phys_bits;
-	/* CPUID returned core id bits: */
-	__u8			x86_coreid_bits;
 	/* Max extended CPUID function supported: */
 	__u32			extended_cpuid_level;
 	/* Maximum supported CPUID level, -1=no CPUID: */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d72787d..33064e6 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1753,7 +1753,6 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	c->x86_vendor_id[0] = '\0'; /* Unset */
 	c->x86_model_id[0] = '\0';  /* Unset */
 	c->x86_max_cores = 1;
-	c->x86_coreid_bits = 0;
 #ifdef CONFIG_X86_64
 	c->x86_clflush_size = 64;
 	c->x86_phys_bits = 36;

