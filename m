Return-Path: <linux-kernel+bounces-68810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D26AE85809B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C593284F7F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04F312FB03;
	Fri, 16 Feb 2024 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0hZgJf5U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hifQFBHT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793031350C0;
	Fri, 16 Feb 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096626; cv=none; b=Q/xp1pWWEfwP0lbB1F3GkKhY3BGUiZKgm/nDtfZlPERyo26F0oyqckUKvkEMHuv+VPmdQNJHXVuCjXt1V9/FdeZKCWEZz4x1sqE7rDLVeIgcmft22rjyvt+ktx0QwFTL25AsuVE3jhOkFCHYzAgDn03YJBEMytcNRaqEk7Y3lGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096626; c=relaxed/simple;
	bh=8OXqzqDqiAgXRX98bDsNqwUJ49zoas/C+H4VBVzBs9E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XbC+uUqaaJKTE5nWZH3eTJ8rsHd1Zzsi/0dTirzmRFbk5zoR7qBCZIb3ed++UxBneI85b83cYqpjF3bs/v+AqjZvMVgrbEd+3TuW/pZLDqT2kK1XcPBQOKV2ZASBq4CTYmgD8zwS2dN3ZFIWLq6+L60duxwVmZu8hUau22sj7kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0hZgJf5U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hifQFBHT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096622;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kPjihb+DTzL+jkBdhj9A0lxeAb+aMfJaCci4rNsJ+cU=;
	b=0hZgJf5U0+ryVPVBK+3rP2gOH4/zt7IpKhjl3PvqHl1pgcXZLytoaB6dFo14eAQFR3E8JN
	ezUeIIh/1YAi0VOS614mjAafhwo0LvW+kV6Vi+5Yeq8ER8+0vYww9+rVCEtvIPJI0OUMoV
	PcmVYtcKjjeDvRRrm4PGgRe1fc/Dt3PehQ6vOvNjh0UdD2TA3wzJKOcvHePwynBwDuELtB
	xLgMvFWnhL7n1Kqc2cKjG+uYqJ3Pn7m0rioupZlQoL4u/l6y+qttLw+h4jHYhZTHj24WAu
	5Qir3r5uVqL1NrfDCQCQQIlbacf6Wjpnj4+H9xYe8072B1BuDwFdRngWEk5GRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096622;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kPjihb+DTzL+jkBdhj9A0lxeAb+aMfJaCci4rNsJ+cU=;
	b=hifQFBHTgVNosPSDIXA+BOrpXWW/rfZ4C4siquudH7O1yyAaHBeQuYNrTu5zVLd+2DJOpu
	mfjQ/cCIlDXV2WBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/cpu/topology: Simplify APIC registration
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210252.050264369@linutronix.de>
References: <20240213210252.050264369@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809662197.398.5373559794664776495.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     4c4c6f38704ab0e3f85f660b7479de7aa559d79a
Gitweb:        https://git.kernel.org/tip/4c4c6f38704ab0e3f85f660b7479de7aa559d79a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:43 +01:00

x86/cpu/topology: Simplify APIC registration

Having the same check whether the number of assigned CPUs has reached the
nr_cpu_ids limit twice in the same code path is pointless. Repeating the
information that CPUs are ignored over and over is also pointless noise.

Remove the redundant check and reduce the noise by using a pr_warn_once().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210252.050264369@linutronix.de



---
 arch/x86/kernel/cpu/topology.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index a6c9314..8b42918 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -107,14 +107,6 @@ static int allocate_logical_cpuid(u32 apic_id)
 	if (cpu >= 0)
 		return cpu;
 
-	/* Allocate a new cpuid. */
-	if (nr_logical_cpuids >= nr_cpu_ids) {
-		WARN_ONCE(1, "APIC: NR_CPUS/possible_cpus limit of %u reached. "
-			     "Processor %d/0x%x and the rest are ignored.\n",
-			     nr_cpu_ids, nr_logical_cpuids, apic_id);
-		return -EINVAL;
-	}
-
 	cpuid_to_apicid[nr_logical_cpuids] = apic_id;
 	return nr_logical_cpuids++;
 }
@@ -135,7 +127,7 @@ static void cpu_update_apic(int cpu, u32 apicid)
 
 static int generic_processor_info(int apicid)
 {
-	int cpu, max = nr_cpu_ids;
+	int cpu;
 
 	/* The boot CPU must be set before MADT/MPTABLE parsing happens */
 	if (cpuid_to_apicid[0] == BAD_APICID)
@@ -155,21 +147,12 @@ static int generic_processor_info(int apicid)
 	}
 
 	if (num_processors >= nr_cpu_ids) {
-		int thiscpu = max + disabled_cpus;
-
-		pr_warn("APIC: NR_CPUS/possible_cpus limit of %i reached. "
-			"Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
-
+		pr_warn_once("APIC: CPU limit of %d reached. Ignoring further CPUs\n", nr_cpu_ids);
 		disabled_cpus++;
-		return -EINVAL;
+		return -ENOSPC;
 	}
 
 	cpu = allocate_logical_cpuid(apicid);
-	if (cpu < 0) {
-		disabled_cpus++;
-		return -EINVAL;
-	}
-
 	cpu_update_apic(cpu, apicid);
 	return cpu;
 }

