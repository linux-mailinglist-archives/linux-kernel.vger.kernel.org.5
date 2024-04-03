Return-Path: <linux-kernel+bounces-129118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FF3896536
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A211F23D4C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F88C5645D;
	Wed,  3 Apr 2024 06:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w2na6x6Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ctPNlCJ0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B276F535D4;
	Wed,  3 Apr 2024 06:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712127596; cv=none; b=qKAz2U2D0qY8b5EIdIF6s9Bybbe9tlGD1sXIJLpvmS5UE9X2UDVNr4DdzxlDeLjfGTno/ajnV+h/xNnP9M8fPqaYvf8g13/sZ8jrAhmxJWl3r4XqPqyPKGd+FjANP3LPlSHJTvzJRvz4x/wjpcAYBL3Xm1i/ftvdaY+IejUPx54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712127596; c=relaxed/simple;
	bh=qeTbd5MJFekZa37NtjIKNSK7jfzgUjevxIwJgThJqiw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=anJnAZ8Ja7f/7Mg1tMtVbJVVklbohk7rV5p9wc3W8JXC5UqwE7qrZAtByrg1zyPZCA1w2akqWRyocctIHxjkeMkOMNnUMqFJed5yZxmEb7CPtfx5ZzDB30CBdKUqsi+tHFB8u+PBP4qt+cNGTHGmvF26SHnC8w/5hhvxqywcm6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w2na6x6Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ctPNlCJ0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Apr 2024 06:59:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712127592;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I5cV+3eRfsC4tI1cpqqDcLb/9DxklC4MbivUnzQa6nM=;
	b=w2na6x6YfdEAk1J7k9NS/P3QOXJyU96QdclMMPYojHAB55LyC2i/h4x61fKW976s6s8peN
	Q2gOI131+FtHqgbjz3enp42VNSCinUQWA2H+1Cqcvc3i/ik2Wx71730SKCmERzvjiDixAB
	pMUUovlLxVfuJzF/tYu2oC1SZWWUirOO6/o0AV1qDOPVFm/Ssj9ZGnUftj0UdMQu5NOAdL
	XVCmICVbkKxkkAJ3NojeXk1O8vI0K1gfeC8dh/BSN8fKDczMHjNj1boMONfpgWVdtOtPCj
	JFBtFM7l+YoHtK55NIukaSZ4rJIxRbJEem29XNVJPlTuwHi4JERfcayY2of1EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712127592;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I5cV+3eRfsC4tI1cpqqDcLb/9DxklC4MbivUnzQa6nM=;
	b=ctPNlCJ0fc9QbnZbu/PS6gx2Xewv7edBhR8aYl1yWaldvCC1Z9qs1RHWHk/DkyQBYD6j7V
	BOeDMSb9Tsb0Q+DA==
From: "tip-bot2 for Saurabh Sengar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/of: Set the parse_smp_cfg for all the
 DeviceTree platforms by default
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1712068830-4513-3-git-send-email-ssengar@linux.microsoft.com>
References: <1712068830-4513-3-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171212759207.10875.3015707260030588957.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     222408cde4d0ab17e54d4db26751c2b5cab9ac2b
Gitweb:        https://git.kernel.org/tip/222408cde4d0ab17e54d4db26751c2b5cab9ac2b
Author:        Saurabh Sengar <ssengar@linux.microsoft.com>
AuthorDate:    Tue, 02 Apr 2024 07:40:28 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Apr 2024 08:46:08 +02:00

x86/of: Set the parse_smp_cfg for all the DeviceTree platforms by default

x86_dtb_parse_smp_config() must be set by DeviceTree platform for
parsing SMP configuration. Set the parse_smp_cfg pointer to
x86_dtb_parse_smp_config() by default so that all the dtb platforms
need not to assign it explicitly. Today there are only two platforms
using DeviceTree in x86, ce4100 and hv_vtl. Remove the explicit
assignment of x86_dtb_parse_smp_config() function from these.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/1712068830-4513-3-git-send-email-ssengar@linux.microsoft.com
---
 arch/x86/hyperv/hv_vtl.c          | 1 -
 arch/x86/include/asm/prom.h       | 7 ++-----
 arch/x86/kernel/devicetree.c      | 6 ++++--
 arch/x86/platform/ce4100/ce4100.c | 1 -
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 3efd0e0..0477534 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -34,7 +34,6 @@ void __init hv_vtl_init_platform(void)
 	/* Avoid searching for BIOS MP tables */
 	x86_init.mpparse.find_mptable = x86_init_noop;
 	x86_init.mpparse.early_parse_smp_cfg = x86_init_noop;
-	x86_init.mpparse.parse_smp_cfg = x86_dtb_parse_smp_config;
 
 	x86_platform.get_wallclock = get_rtc_noop;
 	x86_platform.set_wallclock = set_rtc_noop;
diff --git a/arch/x86/include/asm/prom.h b/arch/x86/include/asm/prom.h
index 043758a..02644e0 100644
--- a/arch/x86/include/asm/prom.h
+++ b/arch/x86/include/asm/prom.h
@@ -24,18 +24,15 @@ extern u64 initial_dtb;
 extern void add_dtb(u64 data);
 void x86_of_pci_init(void);
 void x86_dtb_parse_smp_config(void);
+void x86_flattree_get_config(void);
 #else
 static inline void add_dtb(u64 data) { }
 static inline void x86_of_pci_init(void) { }
 static inline void x86_dtb_parse_smp_config(void) { }
+static inline void x86_flattree_get_config(void) { }
 #define of_ioapic 0
 #endif
 
-#ifdef CONFIG_OF_EARLY_FLATTREE
-void x86_flattree_get_config(void);
-#else
-static inline void x86_flattree_get_config(void) { }
-#endif
 extern char cmd_line[COMMAND_LINE_SIZE];
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 003e029..0d3a50e 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -277,9 +277,9 @@ static void __init dtb_apic_setup(void)
 	dtb_ioapic_setup();
 }
 
-#ifdef CONFIG_OF_EARLY_FLATTREE
 void __init x86_flattree_get_config(void)
 {
+#ifdef CONFIG_OF_EARLY_FLATTREE
 	u32 size, map_len;
 	void *dt;
 
@@ -301,8 +301,10 @@ void __init x86_flattree_get_config(void)
 
 	if (initial_dtb)
 		early_memunmap(dt, map_len);
-}
 #endif
+	if (of_have_populated_dt())
+		x86_init.mpparse.parse_smp_cfg = x86_dtb_parse_smp_config;
+}
 
 void __init x86_dtb_parse_smp_config(void)
 {
diff --git a/arch/x86/platform/ce4100/ce4100.c b/arch/x86/platform/ce4100/ce4100.c
index f32451b..f812682 100644
--- a/arch/x86/platform/ce4100/ce4100.c
+++ b/arch/x86/platform/ce4100/ce4100.c
@@ -139,7 +139,6 @@ void __init x86_ce4100_early_setup(void)
 	x86_init.resources.probe_roms		= x86_init_noop;
 	x86_init.mpparse.find_mptable		= x86_init_noop;
 	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
-	x86_init.mpparse.parse_smp_cfg		= x86_dtb_parse_smp_config;
 	x86_init.pci.init			= ce4100_pci_init;
 	x86_init.pci.init_irq			= sdv_pci_init;
 

