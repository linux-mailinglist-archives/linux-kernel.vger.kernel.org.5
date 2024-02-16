Return-Path: <linux-kernel+bounces-68828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AF58580C2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669421C22067
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9ED14831E;
	Fri, 16 Feb 2024 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SfF7TCCo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pnZQSbGW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D75146001;
	Fri, 16 Feb 2024 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096639; cv=none; b=nydoQL8qr+0oxzJFsoXQo/dVrmWpAx7s0Ub335xIEXpTH2La821hSo8+X+YBvM1CWws9vFaeleFLlWe6aU+Klhq+aWq/7fiEI+k4PZniHMxBBJxLQkrVrZ0U12PKdAfq8MqYIk0AIaFnCcT7ArTUC5UWSrA/IiRwGWIZYYWIYaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096639; c=relaxed/simple;
	bh=eYeI2pOm6P80UWbWK5vXNZ7z3fJYCF7/eTqS0BQZ7GU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uLUduogLJEH+mxH8/G+jOljzFLOOk3/YDfiLNWL+Mllpe8zrDzq0JMtR1GU6RH7qOsJEhcO+dx6t7zQoHkhPml5B4Tu+2/IXo43fu2QM9JqgLn3DZGgSJ1oAOlNhy4vP2MCCuC2/08YaF79w/1WdASmj44M6VcEPPjwxxNciZTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SfF7TCCo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pnZQSbGW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096636;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A5zBwfjnIxMZKYLYMFarpQy16iShzShdaoU7j0JFddc=;
	b=SfF7TCCojWTFCDhQnZHZrNAO9SLBBjlh+QUZETYSXb7KUyveAMe2tS23GKeWNwYKNE8lkc
	r1Yxzb+ByzLl5I6LnQa+ITFaMndiELzF/q2g9pMpZIyrzNZJy1JXObQcp5hekNJZEVEwl+
	emK/ma+jQQy0kHPRK5CtL6RrfC8c3zFFwULwPJMsx/VVa36hQwSrfjbTSfu0QC9szhTlmb
	VwZSb9PSxw+FwQ6yj4QZO4jMfmNIHlXduiLqIBLpJYENJWZy/BWaXT4uGt/XDOhb12GK6J
	7JFy+seOxKodQcgcPVS3hEJs2tl1H28ClTpG9vzf3SMffBlX8UylSIdPL4MNbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096636;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A5zBwfjnIxMZKYLYMFarpQy16iShzShdaoU7j0JFddc=;
	b=pnZQSbGWNFrv2iJkjEsu63MdXOI2iRef79OHrFqUYOmlw9InAcp+APqSYxiNTsWuuZeKmx
	dpQN9ObJCdfNjAAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/jailhouse: Prepare for separate mpparse callbacks
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240212154639.683073662@linutronix.de>
References: <20240212154639.683073662@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809663556.398.5687023151563142285.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     30c928691ce1c861d22ef236ed28bbf0b7a763bc
Gitweb:        https://git.kernel.org/tip/30c928691ce1c861d22ef236ed28bbf0b7a763bc
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:10 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:40 +01:00

x86/jailhouse: Prepare for separate mpparse callbacks

Provide a wrapper around the existing function and fill the new callbacks
in.

No functional change as the new callbacks are not yet operational.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240212154639.683073662@linutronix.de



---
 arch/x86/kernel/jailhouse.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index 578d16f..6d663af 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -118,6 +118,11 @@ static void __init jailhouse_get_smp_config(unsigned int early)
 	}
 }
 
+static void __init jailhouse_parse_smp_config(void)
+{
+	jailhouse_get_smp_config(false);
+}
+
 static void jailhouse_no_restart(void)
 {
 	pr_notice("Jailhouse: Restart not supported, halting\n");
@@ -201,21 +206,24 @@ static void __init jailhouse_init_platform(void)
 	struct setup_data header;
 	void *mapping;
 
-	x86_init.irqs.pre_vector_init	= x86_init_noop;
-	x86_init.timers.timer_init	= jailhouse_timer_init;
-	x86_init.mpparse.get_smp_config	= jailhouse_get_smp_config;
-	x86_init.pci.arch_init		= jailhouse_pci_arch_init;
+	x86_init.irqs.pre_vector_init		= x86_init_noop;
+	x86_init.timers.timer_init		= jailhouse_timer_init;
+	x86_init.mpparse.find_mptable		= x86_init_noop;
+	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
+	x86_init.mpparse.parse_smp_cfg		= jailhouse_parse_smp_config;
+	x86_init.mpparse.get_smp_config		= jailhouse_get_smp_config;
+	x86_init.pci.arch_init			= jailhouse_pci_arch_init;
 
-	x86_platform.calibrate_cpu	= jailhouse_get_tsc;
-	x86_platform.calibrate_tsc	= jailhouse_get_tsc;
-	x86_platform.get_wallclock	= jailhouse_get_wallclock;
-	x86_platform.legacy.rtc		= 0;
-	x86_platform.legacy.warm_reset	= 0;
-	x86_platform.legacy.i8042	= X86_LEGACY_I8042_PLATFORM_ABSENT;
+	x86_platform.calibrate_cpu		= jailhouse_get_tsc;
+	x86_platform.calibrate_tsc		= jailhouse_get_tsc;
+	x86_platform.get_wallclock		= jailhouse_get_wallclock;
+	x86_platform.legacy.rtc			= 0;
+	x86_platform.legacy.warm_reset		= 0;
+	x86_platform.legacy.i8042		= X86_LEGACY_I8042_PLATFORM_ABSENT;
 
-	legacy_pic			= &null_legacy_pic;
+	legacy_pic				= &null_legacy_pic;
 
-	machine_ops.emergency_restart	= jailhouse_no_restart;
+	machine_ops.emergency_restart		= jailhouse_no_restart;
 
 	while (pa_data) {
 		mapping = early_memremap(pa_data, sizeof(header));

