Return-Path: <linux-kernel+bounces-68822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCCB8580B6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D61283797
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF161468E5;
	Fri, 16 Feb 2024 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ub4Q9Ypx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xkQ6j5gu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C0013DB92;
	Fri, 16 Feb 2024 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096635; cv=none; b=G/Y7iZBo8PbUydGxq1IUEcYhv7dTep7cQ9Gpkn5+N+vz67xN2BbhJ0UCEPZkjzd8sOh/p+RHnhEzWmfd8ih+5yuuoPtXEZFtlFD2vqUCa7qcgaRpjvYSf8iwBFKAuQ9A3KFMlsQwr6I8osJ8swoy0OfdCQVPcAey6YH/4vCXoII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096635; c=relaxed/simple;
	bh=nDlE4X0ng9q7iOe7i+g9avJ6X54ZJIGug0xn+B6kq7w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=g+nEQYaLNZHns/l4nNFEZFqEg3SYH9VfHif86PL46IE5pxz7tCegHx4t5pUtl7GAviWieZzAr+lfil7mQcNjBOoFiS8iYGCD1YAqt+QiGxMx9KqJfO95xUnqRZYXM8YfUbv5b/J1z2dJeZsTXD1bc4anri+mgh445947GZ3Il3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ub4Q9Ypx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xkQ6j5gu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096632;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dvip3UNsyz5614co79jTNwLUOGvG2mP7TOXQ4IpY+U8=;
	b=ub4Q9YpxQ/Unljcl7ElrCNw4aZf7FCkqaDs3zVLZ5m8MuRp2VB3tvDcRe9ZmIEyUhEIWaO
	yYC9uN7Lxg0l8nWbqu+9iA9p+qWmcK7qfcgbE/Klm7isR83Y8c3hBypqzO0Ho/saKdzYnh
	pDK0bRtrqmszadE+gALL5oxxzEQm19PCCa12QSOSr2IpeiGOTMoE/C4MVdHS33t5X6cyTg
	LS1VXFchTs/GQYBakU/N8DjzKvhc0ZTM5N2z3LoRqyw0N2Wv6pYzBHbSPMwlSS/kHW0/k5
	8/KtL/Sm/VwZ9o9sUTRUUupLHBJV9Asy43d8sW1Hg+l1/A2ct1gUa4pU1+sffA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096632;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dvip3UNsyz5614co79jTNwLUOGvG2mP7TOXQ4IpY+U8=;
	b=xkQ6j5guakMEyO39NQsksI4lrHFlcz0Q9H3XFwQ798bsTPofXfTmMJvNgg87t2ykm/X8tg
	hHp4oh6SEhuY9ZDg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Remove the pointless writeback of
 boot_cpu_physical_apicid
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240212154640.055288922@linutronix.de>
References: <20240212154640.055288922@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809663172.398.2589362385322757454.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     58d16928358f91d48421838a7484321b3149130d
Gitweb:        https://git.kernel.org/tip/58d16928358f91d48421838a7484321b3149130d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:19 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:41 +01:00

x86/apic: Remove the pointless writeback of boot_cpu_physical_apicid

There is absolutely no point to write the APIC ID which was read from the
local APIC earlier, back into the local APIC for the 64-bit UP case.

Remove that along with the apic callback which is solely there for this
pointless exercise.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240212154640.055288922@linutronix.de



---
 arch/x86/include/asm/apic.h           |  1 -
 arch/x86/kernel/apic/apic.c           |  3 ---
 arch/x86/kernel/apic/apic_flat_64.c   |  7 -------
 arch/x86/kernel/apic/apic_numachip.c  | 12 ------------
 arch/x86/kernel/apic/bigsmp_32.c      |  1 -
 arch/x86/kernel/apic/local.h          |  1 -
 arch/x86/kernel/apic/x2apic_cluster.c |  1 -
 arch/x86/kernel/apic/x2apic_phys.c    |  6 ------
 arch/x86/kernel/apic/x2apic_uv_x.c    |  6 ------
 arch/x86/xen/apic.c                   |  7 -------
 10 files changed, 45 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 16e5e00..89eae0c 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -294,7 +294,6 @@ struct apic {
 	u32	(*cpu_present_to_apicid)(int mps_cpu);
 
 	u32	(*get_apic_id)(u32 id);
-	u32	(*set_apic_id)(u32 apicid);
 
 	/* wakeup_secondary_cpu */
 	int	(*wakeup_secondary_cpu)(u32 apicid, unsigned long start_eip);
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index ce6d31b..e3cebd4 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2485,9 +2485,6 @@ EXPORT_SYMBOL_GPL(x86_msi_msg_get_destid);
 
 static void __init apic_bsp_up_setup(void)
 {
-#ifdef CONFIG_X86_64
-	apic_write(APIC_ID, apic->set_apic_id(boot_cpu_physical_apicid));
-#endif
 	reset_phys_cpu_present_map(boot_cpu_physical_apicid);
 }
 
diff --git a/arch/x86/kernel/apic/apic_flat_64.c b/arch/x86/kernel/apic/apic_flat_64.c
index fe9b728..f6ef121 100644
--- a/arch/x86/kernel/apic/apic_flat_64.c
+++ b/arch/x86/kernel/apic/apic_flat_64.c
@@ -61,11 +61,6 @@ static u32 flat_get_apic_id(u32 x)
 	return (x >> 24) & 0xFF;
 }
 
-static u32 set_apic_id(u32 id)
-{
-	return (id & 0xFF) << 24;
-}
-
 static int flat_probe(void)
 {
 	return 1;
@@ -86,7 +81,6 @@ static struct apic apic_flat __ro_after_init = {
 
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= flat_get_apic_id,
-	.set_apic_id			= set_apic_id,
 
 	.calc_dest_apicid		= apic_flat_calc_apicid,
 
@@ -155,7 +149,6 @@ static struct apic apic_physflat __ro_after_init = {
 
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= flat_get_apic_id,
-	.set_apic_id			= set_apic_id,
 
 	.calc_dest_apicid		= apic_default_calc_apicid,
 
diff --git a/arch/x86/kernel/apic/apic_numachip.c b/arch/x86/kernel/apic/apic_numachip.c
index f7591dc..16410f0 100644
--- a/arch/x86/kernel/apic/apic_numachip.c
+++ b/arch/x86/kernel/apic/apic_numachip.c
@@ -38,11 +38,6 @@ static u32 numachip1_get_apic_id(u32 x)
 	return id;
 }
 
-static u32 numachip1_set_apic_id(u32 id)
-{
-	return (id & 0xff) << 24;
-}
-
 static u32 numachip2_get_apic_id(u32 x)
 {
 	u64 mcfg;
@@ -51,11 +46,6 @@ static u32 numachip2_get_apic_id(u32 x)
 	return ((mcfg >> (28 - 8)) & 0xfff00) | (x >> 24);
 }
 
-static u32 numachip2_set_apic_id(u32 id)
-{
-	return id << 24;
-}
-
 static void numachip1_apic_icr_write(int apicid, unsigned int val)
 {
 	write_lcsr(CSR_G3_EXT_IRQ_GEN, (apicid << 16) | val);
@@ -225,7 +215,6 @@ static const struct apic apic_numachip1 __refconst = {
 
 	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= numachip1_get_apic_id,
-	.set_apic_id			= numachip1_set_apic_id,
 
 	.calc_dest_apicid		= apic_default_calc_apicid,
 
@@ -260,7 +249,6 @@ static const struct apic apic_numachip2 __refconst = {
 
 	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= numachip2_get_apic_id,
-	.set_apic_id			= numachip2_set_apic_id,
 
 	.calc_dest_apicid		= apic_default_calc_apicid,
 
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index 29f354a..9285d50 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -72,7 +72,6 @@ static struct apic apic_bigsmp __ro_after_init = {
 
 	.max_apic_id			= 0xFE,
 	.get_apic_id			= bigsmp_get_apic_id,
-	.set_apic_id			= NULL,
 
 	.calc_dest_apicid		= apic_default_calc_apicid,
 
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index a77c23e..f8a87f9 100644
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -16,7 +16,6 @@
 /* X2APIC */
 void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest);
 u32 x2apic_get_apic_id(u32 id);
-u32 x2apic_set_apic_id(u32 id);
 
 void x2apic_send_IPI_all(int vector);
 void x2apic_send_IPI_allbutself(int vector);
diff --git a/arch/x86/kernel/apic/x2apic_cluster.c b/arch/x86/kernel/apic/x2apic_cluster.c
index 4926b12..567dbd2 100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -237,7 +237,6 @@ static struct apic apic_x2apic_cluster __ro_after_init = {
 	.max_apic_id			= UINT_MAX,
 	.x2apic_set_max_apicid		= true,
 	.get_apic_id			= x2apic_get_apic_id,
-	.set_apic_id			= x2apic_set_apic_id,
 
 	.calc_dest_apicid		= x2apic_calc_apicid,
 
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 8f1c39f..12d4c35 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -129,11 +129,6 @@ u32 x2apic_get_apic_id(u32 id)
 	return id;
 }
 
-u32 x2apic_set_apic_id(u32 id)
-{
-	return id;
-}
-
 static struct apic apic_x2apic_phys __ro_after_init = {
 
 	.name				= "physical x2apic",
@@ -149,7 +144,6 @@ static struct apic apic_x2apic_phys __ro_after_init = {
 	.max_apic_id			= UINT_MAX,
 	.x2apic_set_max_apicid		= true,
 	.get_apic_id			= x2apic_get_apic_id,
-	.set_apic_id			= x2apic_set_apic_id,
 
 	.calc_dest_apicid		= apic_default_calc_apicid,
 
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 3ae696f..7fef504 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -745,11 +745,6 @@ static void uv_send_IPI_all(int vector)
 	uv_send_IPI_mask(cpu_online_mask, vector);
 }
 
-static u32 set_apic_id(u32 id)
-{
-	return id;
-}
-
 static int uv_probe(void)
 {
 	return apic == &apic_x2apic_uv_x;
@@ -769,7 +764,6 @@ static struct apic apic_x2apic_uv_x __ro_after_init = {
 
 	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= x2apic_get_apic_id,
-	.set_apic_id			= set_apic_id,
 
 	.calc_dest_apicid		= apic_default_calc_apicid,
 
diff --git a/arch/x86/xen/apic.c b/arch/x86/xen/apic.c
index d475238..8835d1c 100644
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -33,12 +33,6 @@ static unsigned int xen_io_apic_read(unsigned apic, unsigned reg)
 	return 0xfd;
 }
 
-static u32 xen_set_apic_id(u32 x)
-{
-	WARN_ON(1);
-	return x;
-}
-
 static u32 xen_get_apic_id(u32 x)
 {
 	return ((x)>>24) & 0xFFu;
@@ -131,7 +125,6 @@ static struct apic xen_pv_apic __ro_after_init = {
 
 	.max_apic_id			= UINT_MAX,
 	.get_apic_id			= xen_get_apic_id,
-	.set_apic_id			= xen_set_apic_id,
 
 	.calc_dest_apicid		= apic_flat_calc_apicid,
 

