Return-Path: <linux-kernel+bounces-71826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3DE85AB2C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6041C2262B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C67152F9A;
	Mon, 19 Feb 2024 18:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T9dhl9wb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5cl4VRZe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7362950253;
	Mon, 19 Feb 2024 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367858; cv=none; b=qDplQ/1LxoEcf953Qlcr3xo4qIac5szAv7Mypv6svWf6uncv0x8hEsse3+ddu+LMNLVWbA6O+v9AOZMoyAumBxGhmxb6hmM3VFCrWNR72NDkEntw8WVbmHgYnyr4GFkK0Trz342qfgldKZ0z+Z4BoFQOoSNXFAKF93LL1cT/OGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367858; c=relaxed/simple;
	bh=ZbbhHE6UUZwGqw0XhucTQNlCcltUp3JDNyecsexFdj8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Hswiu/qFUB7c1BbHIL1wrHUJtDTyuxgs0FOWKHifaID0GCCWAz+uRpHcBmeONf6vk9TI8LVsj0UMSUex17HI6TH1usHgDEVxNP659eIby8rsHNe6PRPAuDedwxYbDWBZ+gQJRYdCZToN4xcK4SzMR54I8Qo1onAj7kNyrO4+j7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T9dhl9wb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5cl4VRZe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 18:37:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708367854;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6f6pCTjBTNIp0oMTlhFm1Cm0MI2mqcpz6venSi+2MPM=;
	b=T9dhl9wbHxNISzzU5ziU9G1/h4eF0hQ/R72QZv9VIiAHV08hHcmVmxhbsEJppFoiSls9dN
	5StbHh7L4a1KDeFyU4d3u8rAMX4A+CD0iB4Ox+kgtNijwDlIFQMraknPS1R0T24sOX6tpy
	enXgdV/PY+ZCqeY/uB2i237gcycCujdyNIC+5No39YlHv+R5ZRnhFxeAfcl2ZNvKQ3Zp1b
	Ulag7ir4Qp2gRFDs2is0aOB5VBPSO2HbV2aB12KFzC5UA338/VnzoHAU8i5ntOhLwMRH8B
	6kvJ6n8Cy8bcIT5x9L9nNytIXIKEh+SFMA6SHfrSIrrr6K/lzIl/QQDY1+M+hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708367854;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6f6pCTjBTNIp0oMTlhFm1Cm0MI2mqcpz6venSi+2MPM=;
	b=5cl4VRZe8TOSm1rKfyvyaRgmDphJQOIj7/0Opuaz1bxUNbsQTkfoVnGiO0FbQ2w+5r6wmV
	SHNo9wKkQF7PT6DA==
From: "tip-bot2 for James Morse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Allocate the cleanest CLOSID by
 searching closid_num_dirty_rmid
Cc: James Morse <james.morse@arm.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Shaopeng Tan <tan.shaopeng@fujitsu.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Babu Moger <babu.moger@amd.com>,
 Peter Newman <peternewman@google.com>,
 Carl Worth <carl@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240213184438.16675-11-james.morse@arm.com>
References: <20240213184438.16675-11-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170836785387.398.10584661729291507090.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     6eac36bb9eb0349c983313c71692c19d50b56878
Gitweb:        https://git.kernel.org/tip/6eac36bb9eb0349c983313c71692c19d50b56878
Author:        James Morse <james.morse@arm.com>
AuthorDate:    Tue, 13 Feb 2024 18:44:24 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 16 Feb 2024 19:18:32 +01:00

x86/resctrl: Allocate the cleanest CLOSID by searching closid_num_dirty_rmid

MPAM's PMG bits extend its PARTID space, meaning the same PMG value can be used
for different control groups.

This means once a CLOSID is allocated, all its monitoring ids may still be
dirty, and held in limbo.

Instead of allocating the first free CLOSID, on architectures where
CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is enabled, search
closid_num_dirty_rmid[] to find the cleanest CLOSID.

The CLOSID found is returned to closid_alloc() for the free list
to be updated.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
Link: https://lore.kernel.org/r/20240213184438.16675-11-james.morse@arm.com
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/resctrl/internal.h |  2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 45 +++++++++++++++++++++++++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 ++++++++---
 3 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 872ba1a..b7b9d92 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -566,5 +566,7 @@ void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
 void __init thread_throttle_mode_init(void);
 void __init mbm_config_rftype_init(const char *config);
 void rdt_staged_configs_clear(void);
+bool closid_allocated(unsigned int closid);
+int resctrl_find_cleanest_closid(void);
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 13b0c8d..101f1b1 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -386,6 +386,51 @@ static struct rmid_entry *resctrl_find_free_rmid(u32 closid)
 	return ERR_PTR(-ENOSPC);
 }
 
+/**
+ * resctrl_find_cleanest_closid() - Find a CLOSID where all the associated
+ *                                  RMID are clean, or the CLOSID that has
+ *                                  the most clean RMID.
+ *
+ * MPAM's equivalent of RMID are per-CLOSID, meaning a freshly allocated CLOSID
+ * may not be able to allocate clean RMID. To avoid this the allocator will
+ * choose the CLOSID with the most clean RMID.
+ *
+ * When the CLOSID and RMID are independent numbers, the first free CLOSID will
+ * be returned.
+ */
+int resctrl_find_cleanest_closid(void)
+{
+	u32 cleanest_closid = ~0;
+	int i = 0;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+
+	if (!IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID))
+		return -EIO;
+
+	for (i = 0; i < closids_supported(); i++) {
+		int num_dirty;
+
+		if (closid_allocated(i))
+			continue;
+
+		num_dirty = closid_num_dirty_rmid[i];
+		if (num_dirty == 0)
+			return i;
+
+		if (cleanest_closid == ~0)
+			cleanest_closid = i;
+
+		if (num_dirty < closid_num_dirty_rmid[cleanest_closid])
+			cleanest_closid = i;
+	}
+
+	if (cleanest_closid == ~0)
+		return -ENOSPC;
+
+	return cleanest_closid;
+}
+
 /*
  * For MPAM the RMID value is not unique, and has to be considered with
  * the CLOSID. The (CLOSID, RMID) pair is allocated on all domains, which
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index bc6e0f8..8fc4620 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -137,13 +137,22 @@ static void closid_init(void)
 
 static int closid_alloc(void)
 {
-	u32 closid = ffs(closid_free_map);
+	int cleanest_closid;
+	u32 closid;
 
 	lockdep_assert_held(&rdtgroup_mutex);
 
-	if (closid == 0)
-		return -ENOSPC;
-	closid--;
+	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
+		cleanest_closid = resctrl_find_cleanest_closid();
+		if (cleanest_closid < 0)
+			return cleanest_closid;
+		closid = cleanest_closid;
+	} else {
+		closid = ffs(closid_free_map);
+		if (closid == 0)
+			return -ENOSPC;
+		closid--;
+	}
 	__clear_bit(closid, &closid_free_map);
 
 	return closid;
@@ -163,7 +172,7 @@ void closid_free(int closid)
  * Return: true if @closid is currently associated with a resource group,
  * false if @closid is free
  */
-static bool closid_allocated(unsigned int closid)
+bool closid_allocated(unsigned int closid)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
 

