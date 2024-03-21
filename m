Return-Path: <linux-kernel+bounces-110625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF9888616B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E79828693A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FCF13443B;
	Thu, 21 Mar 2024 20:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NNkn9QLO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aT+kUfid"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9248E13441F;
	Thu, 21 Mar 2024 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711051352; cv=none; b=VLE0HUTGseK1m3nJR9l+sGlwftlYl0HFAcdjDaRwDd4xDZhpBXf0h6XTZMtnxlvHBtHtxPLvSsvmIUBVVT8HsxKajm5F+GN5yVANOoFixpQtVTA/vVSIgqcEGMJV0s+9vpel+0C0iPlR10FVitSkKE3op0Oa+Cak0lgU/PQ1C8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711051352; c=relaxed/simple;
	bh=epTfLOewodEC86qJUC6RxLcdPz3Hlv4ahcc4eMW0kaU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=guU3zcugUMvVgxZmJ/I6uFssYuhMkhjCxt0/0w4F4v8HcgE35eKviY4U6tgrCjrt/tAQQS4xq9prNx6Sz2hwRpmOa5mXFhwFEQgheZTGi0WpNCO3JCXBI2FVqgF/prrwO1DpdRbMNLtEWaJJZMjsHQmC7r+g/qsTAr03eh2e+uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NNkn9QLO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aT+kUfid; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 21 Mar 2024 20:02:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711051348;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=faM9E3twZF3hQBVekLZiz6R2tsI1iVLR+JuxSZCz95U=;
	b=NNkn9QLOg0mzVjLe6RJ7c3wfQLieCIvZY/LdTPaQmIJ9m/6B4yBJSS8wx+0oKiWwpQ58I0
	xU7+eKUjG2kEbjgBtppUhn3Lh2LVmTZ7mQa7PpcQRIfrCv4DoqfzWo2PbSkSnNPDJrNgg6
	U5kmWisIVg+Q7c8a37ulmDwCUhmrQappE0FsQhOFMucGSAMclVZW46YEj0C+hqj3jmh1Ty
	HE3m3cBPBP/KyV7ow0XflLjHoGMliAcv2Zp0WmDbci3nVC9mwOZ1FiabOtous8P9CYFviq
	RRJAY/zdytrubSW2m/5PRRC/qmI5NOSgRDrwDndWJebsT9G9udZpS+TdCKJ5HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711051348;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=faM9E3twZF3hQBVekLZiz6R2tsI1iVLR+JuxSZCz95U=;
	b=aT+kUfidiloCo63kki8B+9tkzXyQnzopm5srWYMI+c8ATMj9a/ECQ3gmUubiFvRCJ8Zmci
	c+k+mwn1gBzYDICw==
From: "tip-bot2 for Rafael J. Wysocki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cpu: Move leftover contents of topology.c to setup.c
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <12422874.O9o76ZdvQC@kreacher>
References: <12422874.O9o76ZdvQC@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171105134784.10875.12163504829972581498.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     edf66a3c76635a5d326badd83d76fd480a0c8db2
Gitweb:        https://git.kernel.org/tip/edf66a3c76635a5d326badd83d76fd480a0c8db2
Author:        Rafael J. Wysocki <rafael.j.wysocki@intel.com>
AuthorDate:    Mon, 18 Mar 2024 19:12:45 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Mar 2024 20:47:40 +01:00

x86/cpu: Move leftover contents of topology.c to setup.c

The only useful piece of arch/x86/kernel/topology.c is the definition
of arch_cpu_is_hotpluggable() that can be moved elsewhere (other
architectures tend to put it into setup.c), so do that and delete
the rest of the file.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/12422874.O9o76ZdvQC@kreacher
---
 arch/x86/kernel/Makefile   |  2 +-
 arch/x86/kernel/setup.c    |  8 +++++++-
 arch/x86/kernel/topology.c | 43 +-------------------------------------
 3 files changed, 9 insertions(+), 44 deletions(-)
 delete mode 100644 arch/x86/kernel/topology.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 7407769..5d12816 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -62,7 +62,7 @@ obj-$(CONFIG_X86_64)	+= sys_x86_64.o
 obj-$(CONFIG_X86_ESPFIX64)	+= espfix_64.o
 obj-$(CONFIG_SYSFS)	+= ksysfs.o
 obj-y			+= bootflag.o e820.o
-obj-y			+= pci-dma.o quirks.o topology.o kdebugfs.o
+obj-y			+= pci-dma.o quirks.o kdebugfs.o
 obj-y			+= alternative.o i8253.o hw_breakpoint.o
 obj-y			+= tsc.o tsc_msr.o io_delay.o rtc.o
 obj-y			+= resource.o
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3e1e96e..d50b258 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -7,6 +7,7 @@
  */
 #include <linux/acpi.h>
 #include <linux/console.h>
+#include <linux/cpu.h>
 #include <linux/crash_dump.h>
 #include <linux/dma-map-ops.h>
 #include <linux/dmi.h>
@@ -1227,3 +1228,10 @@ static int __init register_kernel_offset_dumper(void)
 	return 0;
 }
 __initcall(register_kernel_offset_dumper);
+
+#ifdef CONFIG_HOTPLUG_CPU
+bool arch_cpu_is_hotpluggable(int cpu)
+{
+	return cpu > 0;
+}
+#endif /* CONFIG_HOTPLUG_CPU */
diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
deleted file mode 100644
index d42c28b..0000000
--- a/arch/x86/kernel/topology.c
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * Populate sysfs with topology information
- *
- * Written by: Matthew Dobson, IBM Corporation
- * Original Code: Paul Dorwin, IBM Corporation, Patrick Mochel, OSDL
- *
- * Copyright (C) 2002, IBM Corp.
- *
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
- * NON INFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * Send feedback to <colpatch@us.ibm.com>
- */
-#include <linux/interrupt.h>
-#include <linux/nodemask.h>
-#include <linux/export.h>
-#include <linux/mmzone.h>
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <linux/irq.h>
-#include <asm/io_apic.h>
-#include <asm/cpu.h>
-
-#ifdef CONFIG_HOTPLUG_CPU
-bool arch_cpu_is_hotpluggable(int cpu)
-{
-	return cpu > 0;
-}
-#endif /* CONFIG_HOTPLUG_CPU */

