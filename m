Return-Path: <linux-kernel+bounces-68796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A682085807F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD291F23368
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A47130AE2;
	Fri, 16 Feb 2024 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uFrX6Yc9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ECYwbaSj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB0C12FB2D;
	Fri, 16 Feb 2024 15:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096614; cv=none; b=V7vN5xU52lPEHoRcghJXK/V/rSN2+sky83HlKGPk018hmVdg1pBC6Jn6CeW+6LFItYfDw23A//R22vtI9Qqdik2fapLjvKZycngfMqc9N5UCEx7NzDfxj6MbnfZq14fpwfnesCkfZxV0Nyl9f+XRJoRP3FC9RbWSi9gMVesHp9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096614; c=relaxed/simple;
	bh=ioe2GA/1+lcfLti+VlRk9lhT10z3QQ1cuSbotr0bXzY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UA1zFB9e5q4K5Hdf9i1/4MlzcUB8jnSQnsK7Zy/g3pVhsGoj3K9SxK4Lt8PJmGOzs6cofSU2VaNkIjwZVMzxBbP+g32XxwU18DZtkb/mQ3TGoT9GAtqpJR+EkA3QNxZKl7wyAeIM7/jEi2af9DG0HfiYWB3muyRvqyFDVMLijAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uFrX6Yc9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ECYwbaSj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:16:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096610;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KtWFXfkl1AGKFK+oSAjJDdxbIk0vfWtKmBtSsanyfDM=;
	b=uFrX6Yc9qZNr5amXZOEtd2llG8AHi67w2pq2/bTxT2gJt7oAfhTJ8yt6uIlqL6fMO6RNiq
	wlB1wLqXszQSrGcOwXHxaROTWwj+ryg4y4X53WXjW8AT0ed/lDTihCQ6cGTzldJIalMdDI
	HUKVaN0BTPiuPMMTucekTnqP6J/IjCwkPLV01KMUYTif67mSmgdcuTWU01TchxmfHCOlbu
	ezGqTwL1BAv+2ruy54P9DUCRb3oLFduuvbsVZuyWLuc9gi8VbDigmqXVE8+XuBSrZjXEGO
	EtKz6i/OTFUVa48WZ+zJBbvQ0+ZwcF7j+JmUbv9d+ixLSsPFXBJHXZnVZRuWGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096610;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KtWFXfkl1AGKFK+oSAjJDdxbIk0vfWtKmBtSsanyfDM=;
	b=ECYwbaSjpI2KgQErkpKE9v0yIJiSMEK5VnJeF3SSriKRs5XIQ4N3dSS1JFcoOmy88I3CRn
	igjLZ3SHf9wTOiCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/cpu/topology: Provide logical pkg/die mapping
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210252.846136196@linutronix.de>
References: <20240213210252.846136196@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809660991.398.11224403618848319747.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     b7065f4f844c7876ed071b67e2ba57838152bd63
Gitweb:        https://git.kernel.org/tip/b7065f4f844c7876ed071b67e2ba57838152bd63
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:06:07 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:44 +01:00

x86/cpu/topology: Provide logical pkg/die mapping

With the topology bitmaps in place the logical package and die IDs can
trivially be retrieved by determining the bitmap weight of the relevant
topology domain level up to and including the physical ID in question.

Provide a function to that effect.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210252.846136196@linutronix.de





---
 arch/x86/include/asm/topology.h |  9 +++++++++
 arch/x86/kernel/cpu/topology.c  | 28 ++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 94ef1a6..bdd6a98 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -156,6 +156,15 @@ static inline unsigned int topology_max_die_per_package(void)
 	return __max_dies_per_package;
 }
 
+#ifdef CONFIG_X86_LOCAL_APIC
+int topology_get_logical_id(u32 apicid, enum x86_topology_domains at_level);
+#else
+static inline int topology_get_logical_id(u32 apicid, enum x86_topology_domains at_level)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_SMP
 #define topology_cluster_id(cpu)		(cpu_data(cpu).topo.l2c_id)
 #define topology_die_cpumask(cpu)		(per_cpu(cpu_die_map, cpu))
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index aea408d..29759b4 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -229,6 +229,34 @@ void __init topology_register_boot_apic(u32 apic_id)
 	topo_register_apic(apic_id, CPU_ACPIID_INVALID, true);
 }
 
+/**
+ * topology_get_logical_id - Retrieve the logical ID at a given topology domain level
+ * @apicid:		The APIC ID for which to lookup the logical ID
+ * @at_level:		The topology domain level to use
+ *
+ * @apicid must be a full APIC ID, not the normalized variant. It's valid to have
+ * all bits below the domain level specified by @at_level to be clear. So both
+ * real APIC IDs and backshifted normalized APIC IDs work correctly.
+ *
+ * Returns:
+ *  - >= 0:	The requested logical ID
+ *  - -ERANGE:	@apicid is out of range
+ *  - -ENODEV:	@apicid is not registered
+ */
+int topology_get_logical_id(u32 apicid, enum x86_topology_domains at_level)
+{
+	/* Remove the bits below @at_level to get the proper level ID of @apicid */
+	unsigned int lvlid = topo_apicid(apicid, at_level);
+
+	if (lvlid >= MAX_LOCAL_APIC)
+		return -ERANGE;
+	if (!test_bit(lvlid, apic_maps[at_level].map))
+		return -ENODEV;
+	/* Get the number of set bits before @lvlid. */
+	return bitmap_weight(apic_maps[at_level].map, lvlid);
+}
+EXPORT_SYMBOL_GPL(topology_get_logical_id);
+
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 /**
  * topology_hotplug_apic - Handle a physical hotplugged APIC after boot

