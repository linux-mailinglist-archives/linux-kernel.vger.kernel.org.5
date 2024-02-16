Return-Path: <linux-kernel+bounces-68812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AD38580A0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E882286360
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648F4135A5B;
	Fri, 16 Feb 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e1+OFHf6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9vhBZkBS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44AA1350ED;
	Fri, 16 Feb 2024 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096627; cv=none; b=BwWywcv/TJ/SJEdVKNyY+pOULvp4zYba9wbHAQgWE5AW0CixsLDh9djw2TEeWWLeppabVGNosqnhyX2tS+PGqMOSBO4CyPQ6uF/sczCRWd1Q50OIfADmK4ny9f9gUfu7NzONyyaa5Iv7C57N+dGo3GWmzVk2cdFFkZReTlFqYxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096627; c=relaxed/simple;
	bh=K5+qlSc4Yo4B3VFaQSLecQE9/0oNut1jsvDJ5maU9nk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WnG/T3jA6OBz2WDIEpRI/S3KOJKkacJxp99E/QNr/W12UmjzoU+lcyKSMqyaNjd4HYkbrcipl+2GqP6cYSWkKP9Apq8QDM7aUUxRLZXiuan/3yR5UcpCKbYs+oSlGNAsnThQSU1cIfezqMlsKvuYf3MJIyTkV8ryUfxLC/u0zU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e1+OFHf6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9vhBZkBS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096624;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YBPQzE0M5aGFTZgvsP8CZBcikdBaFd0XoMSUyLHP2R8=;
	b=e1+OFHf6CuFEEkhdSqgI+xuKp5CMTJ2DHFs+s4P3mpE0a5UKLgjh3d3zKgbMqjvOwHAva7
	rZexorXG8ibv+4tQoMv3SzgdCbQ0XHRTNTRyH5Hb30fCYpo01ZPlrJXoX4Yg2yg09UCOKx
	K9cfbP9bw+qowUniiTiGvd9v2xfrUAVVx5ixkGZse5j93YH1LaoAXecujdFS46Tpj3oNWd
	+xpJZyYjXYUMFR1zDg2XMXVDT/zHqgQciG8qXA+81Igcdof7A8pueIrALyskz9U37m5imI
	8IUAJjROyhfal4lXS1nCoMqEsqoIDBcNhO//0dlEYhdjyWcjdGHfd7ZIcb5PDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096624;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YBPQzE0M5aGFTZgvsP8CZBcikdBaFd0XoMSUyLHP2R8=;
	b=9vhBZkBSr1G38EFolh6PC84QTJ7wwTu4MMnODPnIx7TaGwt0S5+651R8fTzu2McBzaRzmf
	uOd3Yzn0sF+zPUDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/xen/smp_pv: Register fake APICs
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210251.940043512@linutronix.de>
References: <20240213210251.940043512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809662371.398.14602580617204463788.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     e7530702346637af46bca1d114e6d63312eb3461
Gitweb:        https://git.kernel.org/tip/e7530702346637af46bca1d114e6d63312eb3461
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:42 +01:00

x86/xen/smp_pv: Register fake APICs

XENPV does not use the APIC. It's just piggy packing on the infrastructure
and fiddles with global variables as it sees fit.

These global variables are going away, so let XENPV register pseudo APIC
IDs to keep the accounting correct and keep up the illusion that XEN/PV is
something sane.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210251.940043512@linutronix.de



---
 arch/x86/xen/smp_pv.c | 37 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 7f6f340..98849b3 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -29,6 +29,7 @@
 #include <asm/idtentry.h>
 #include <asm/desc.h>
 #include <asm/cpu.h>
+#include <asm/apic.h>
 #include <asm/io_apic.h>
 
 #include <xen/interface/xen.h>
@@ -150,34 +151,16 @@ int xen_smp_intr_init_pv(unsigned int cpu)
 
 static void __init xen_pv_smp_config(void)
 {
-	int i, rc;
-	unsigned int subtract = 0;
-
-	num_processors = 0;
-	disabled_cpus = 0;
-	for (i = 0; i < nr_cpu_ids; i++) {
-		rc = HYPERVISOR_vcpu_op(VCPUOP_is_up, i, NULL);
-		if (rc >= 0) {
-			num_processors++;
-			set_cpu_possible(i, true);
-		} else {
-			set_cpu_possible(i, false);
-			set_cpu_present(i, false);
-			subtract++;
-		}
+	u32 apicid = 0;
+	int i;
+
+	topology_register_boot_apic(apicid++);
+
+	for (i = 1; i < nr_cpu_ids; i++) {
+		if (HYPERVISOR_vcpu_op(VCPUOP_is_up, i, NULL) < 0)
+			break;
+		topology_register_apic(apicid++, CPU_ACPIID_INVALID, true);
 	}
-#ifdef CONFIG_HOTPLUG_CPU
-	/* This is akin to using 'nr_cpus' on the Linux command line.
-	 * Which is OK as when we use 'dom0_max_vcpus=X' we can only
-	 * have up to X, while nr_cpu_ids is greater than X. This
-	 * normally is not a problem, except when CPU hotplugging
-	 * is involved and then there might be more than X CPUs
-	 * in the guest - which will not work as there is no
-	 * hypercall to expand the max number of VCPUs an already
-	 * running guest has. So cap it up to X. */
-	if (subtract)
-		set_nr_cpu_ids(nr_cpu_ids - subtract);
-#endif
 	/* Pretend to be a proper enumerated system */
 	smp_found_config = 1;
 }

