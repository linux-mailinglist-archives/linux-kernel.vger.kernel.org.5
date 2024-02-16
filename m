Return-Path: <linux-kernel+bounces-68842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26D38580E1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816341F23CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B0514E2E4;
	Fri, 16 Feb 2024 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MrNgT+Ty";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mvSsCX3W"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD8114C5AB;
	Fri, 16 Feb 2024 15:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096649; cv=none; b=usi+7//ktID1NhapRpe3zuAiYXPdR3/HILl7X/h11cn62tjSiQpiCxuwjPx0RZKYJgaFftwyzpl7DGHCtnAGv9bXBzJzODnce5qKKJZLGovGLTZ3reNbMyE4zYWtHI+sDG3FobRH5n+U3p6cRvZ+8uYQl0dsdCtlllEYlDbw2F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096649; c=relaxed/simple;
	bh=MQs4Sxt3kgCW9f39A48G8wZuyE2036JcE1LffFF5VQM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WzKsCj4+Mp/Cuqw7XKGKSim2byjVjS/qpClZTAQ/sHZbCArLy8SA7QBYKR1EVfwcKngsLvjwi49Mfb+38VnZUN+n2T6NQcVJYXySUyY0Du+CHth2FO3T0CrGyADVDKzbXGun00d+J5vzfgxPICCO4JL2WGvr5WXzVO2FKPI9S/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MrNgT+Ty; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mvSsCX3W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096646;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HfYsugg5on+ACsZdxXXf8cD7R5sMllkQzwF0wt1kLcY=;
	b=MrNgT+TyyTIYVnufNDXeLjPo0XlnhfI8dbzCh/Stcex+SsDoTG3H/o0gPs2uSZrTqjm0Xn
	7jWA9yLcW79ctyNB22ZM/4kY3MfMd4quQHSBm0nb1BoKCEEZEsWpVlkHjJrEV7sHNbrP4K
	T3q8Cv/0bIHfegQvkzS5oXj/jV6f5cYlHjeiG1S0w4cSQaewB7VSalQB0BhEMYbJ1LgQvk
	/aMoTtdC9T9K5BQvT6y8o44MLAa/Jn1HUeCauu37YHQnCZK59K9S1J1n4zbVq202jpVUWw
	x6VxTN4tQ/IHKFs4sYTRT1742rPy70zS11gCmIbC8nTqMc0eW/4YJkBYBVY/ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096646;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HfYsugg5on+ACsZdxXXf8cD7R5sMllkQzwF0wt1kLcY=;
	b=mvSsCX3WKAXVdKk85uCPAmhYXqBS/d6ps/yJZaw6oIhefUNG0phHj+6gZyznbLiQcMoupe
	adWCtqdTQeLucTCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/xen/smp_pv: Remove cpudata fiddling
Cc: Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Michael Kelley <mhklinux@outlook.com>,
 Zhang Rui <rui.zhang@intel.com>, Wang Wendy <wendy.wang@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240212153625.576579177@linutronix.de>
References: <20240212153625.576579177@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809664543.398.14970045765304774752.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     d5474e4d2c91b3f27864e9898f7f6e49daf26d93
Gitweb:        https://git.kernel.org/tip/d5474e4d2c91b3f27864e9898f7f6e49daf26d93
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:04:24 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:38 +01:00

x86/xen/smp_pv: Remove cpudata fiddling

The new topology CPUID parser installs already fake topology for XEN/PV,
which ends up with cpuinfo::max_cores = 1.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20240212153625.576579177@linutronix.de




---
 arch/x86/xen/smp_pv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index a0f07bb..3ae29c2 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -73,7 +73,6 @@ static void cpu_bringup(void)
 	}
 	cpu = smp_processor_id();
 	smp_store_cpu_info(cpu);
-	cpu_data(cpu).x86_max_cores = 1;
 	set_cpu_sibling_map(cpu);
 
 	speculative_store_bypass_ht_init();
@@ -224,8 +223,6 @@ static void __init xen_pv_smp_prepare_cpus(unsigned int max_cpus)
 
 	smp_prepare_cpus_common();
 
-	cpu_data(0).x86_max_cores = 1;
-
 	speculative_store_bypass_ht_init();
 
 	xen_pmu_init(0);

