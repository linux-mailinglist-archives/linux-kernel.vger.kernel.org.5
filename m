Return-Path: <linux-kernel+bounces-138609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CBA89F45C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B4A1F257A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0974115ECF1;
	Wed, 10 Apr 2024 13:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q8g+2dUB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T2V3VAFr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC0215ADBF;
	Wed, 10 Apr 2024 13:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756001; cv=none; b=rAAGWTFT3J5GwkniIOboMWTDr3bPOKUqV5QJkh9ZKI2kR9OzFa2EZXMSYTtg6CYudqJzTjyE1IG1fUIzmAmKlfaUHPLxT+po/oxxZqFojdDmv+J68gH7ou0MpPWV1To8kkodDlZ7mQHrTLBlV5wGefaTKZaI+Ivc6KARK0Oa34s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756001; c=relaxed/simple;
	bh=FIObw+nkd3bM6GB0vbvXE8UQ7qTFir/wKkV2t7da6Go=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=K4dV/xYlabK77fxbGKhHCYZ7/1fCGS1cy1UuMn+wNYYA5G7/vi+d4hr2pI6xqQw/Zjv0BwMQ+zsvcnyG5AIzPHH1bPeL6Txk4YalNZa5xiQ9LTQg76AUTk9BgIbmuwhXOjSk2LXHJG/WwYLLYVjyPrWdEURBzVbsHwexFb8ZydM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q8g+2dUB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T2V3VAFr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Apr 2024 13:33:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712755998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KvcjXtJHxGZvszgd21JjPouK1zZmiXf4vKLraFZNs7g=;
	b=Q8g+2dUBle1+qFcvpD1qzY+6c1Qki3GGQ32/5t3c74xpNujXq/Xkw7qh1mI3qd+hgvUSJs
	x2wNIEIsSLRz9PSph2hHWdrZhAGWL+OLMMUSlCUPo3i/kPQQIJXG6FmOdfmMbcThHlms81
	YISG9qe2iJA0epKc1iuJbZBh74r5gKT64jnh94ijDzXUueipIRGXx8p1CtZLkcq6DVqILA
	VfYSkrDh+8LIwrWScOS2caXDNsX1n0yYVksG1HC9JW9f2kpdS4+EjdnDMFQrGvJO7VHc30
	pfcbKKysa9F3IwNEA60pMTzji/2UjcK/1CYvgYnHMAp52szTjE3w9LTC+z6O5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712755998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KvcjXtJHxGZvszgd21JjPouK1zZmiXf4vKLraFZNs7g=;
	b=T2V3VAFrsfQG28ICTD/LrSkDnoldfwsZFJSSELgYoHnUe+KUJ3iIeLdDlpsQf0cLfRwxfl
	/cuvNwg1rdvn2rDg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/topology: Don't update cpu_possible_map
 in topo_set_cpuids()
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <87ttkc6kwx.ffs@tglx>
References: <87ttkc6kwx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171275599725.10875.2334973841173648754.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     675ae1aac0572595999e6f78a16e51351291f7aa
Gitweb:        https://git.kernel.org/tip/675ae1aac0572595999e6f78a16e51351291f7aa
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 08 Apr 2024 15:22:01 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Apr 2024 15:24:27 +02:00

x86/topology: Don't update cpu_possible_map in topo_set_cpuids()

topo_set_cpuids() updates cpu_present_map and cpu_possible map. It is
invoked during enumeration and "physical hotplug" operations. In the
latter case this results in a kernel crash because cpu_possible_map is
marked read only after init completes.

There is no reason to update cpu_possible_map in that function. During
enumeration cpu_possible_map is not relevant and gets fully initialized
after enumeration completed. On "physical hotplug" the bit is already set
because the kernel allows only CPUs to be plugged which have been
enumerated and associated to a CPU number during early boot.

Remove the bogus update of cpu_possible_map.

Fixes: 0e53e7b656cf ("x86/cpu/topology: Sanitize the APIC admission logic")
Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/87ttkc6kwx.ffs@tglx

---
 arch/x86/kernel/cpu/topology.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index aaca8d2..d17c9b7 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -123,7 +123,6 @@ static void topo_set_cpuids(unsigned int cpu, u32 apic_id, u32 acpi_id)
 	early_per_cpu(x86_cpu_to_apicid, cpu) = apic_id;
 	early_per_cpu(x86_cpu_to_acpiid, cpu) = acpi_id;
 #endif
-	set_cpu_possible(cpu, true);
 	set_cpu_present(cpu, true);
 }
 
@@ -210,7 +209,11 @@ static __init void topo_register_apic(u32 apic_id, u32 acpi_id, bool present)
 		topo_info.nr_disabled_cpus++;
 	}
 
-	/* Register present and possible CPUs in the domain maps */
+	/*
+	 * Register present and possible CPUs in the domain
+	 * maps. cpu_possible_map will be updated in
+	 * topology_init_possible_cpus() after enumeration is done.
+	 */
 	for (dom = TOPO_SMT_DOMAIN; dom < TOPO_MAX_DOMAIN; dom++)
 		set_bit(topo_apicid(apic_id, dom), apic_maps[dom].map);
 }

