Return-Path: <linux-kernel+bounces-106557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FDD87F042
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E1BE283037
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8C757885;
	Mon, 18 Mar 2024 19:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="YxNpQkjr"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A436D57881
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 19:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789171; cv=none; b=RwI7K9rBFQwYb+6Z/GH92Xc7UbQSloAahtXGl/nIEeNsEQ5BQkP1vsUEoxrKgqFxk0fXKyI9J6KfKvwJ8NWc6ONvydaNyJS6DlXfaf8nLZBuyF7qb381GlUhbH/CAufjEYosWdJzLRbvbMTsGHelthPJdq+UucT3dsPGmfQtMJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789171; c=relaxed/simple;
	bh=BRzAVB64xba4LajsrQesEnO3VNhDC6VLDMobsb0exZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OwzfGG9xkP2F7S/X4QsyjbMNBpKcydQfdY0qVy/N/NWOwIxm6a9cFxjt3K7XAKOaoHlUI+JFPQ3MARGDY/X+PAV7dBAN6u1OZLSKJyNlDs4xaYNTN7MsfCWAGWPyyf+Dp7z7+K5yJYTaYQcWEDC9dqc09wU4LaZWTkHUadKD2Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=YxNpQkjr; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.4.0)
 id 088c641c652891ff; Mon, 18 Mar 2024 19:12:46 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 1DB7C66B492;
	Mon, 18 Mar 2024 19:12:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1710785566;
	bh=BRzAVB64xba4LajsrQesEnO3VNhDC6VLDMobsb0exZQ=;
	h=From:To:Cc:Subject:Date;
	b=YxNpQkjrXnpoUqSEXOE1pYdXAuD1eQ2+smUsMNnvoMUI7DNIsnJRQKXsFlxCnWi4K
	 cRBc5EzWHw2jrZoWn57APymPLEe3h8ZIiBc2lUGN/hz/f8R29J1Dm5L8OpRKS1tP8e
	 INWnYGp2rlJU640mbMeplMPO2tFiaE63LL7xC2lGM7+VH7l/F4d/THjpaeSPbc3EbU
	 TtJYkoHnUMo8gJFl0ORtj46Cxr9JpX66Sos4vEVsfRhJEZvBJkRqCAOEKvx+b7/8a2
	 ALnQDp49YVVOrtnaWgUPwFnZJNiDTfC3auTGNVJtyXKvCnpcktanee2g2ozDpxq4XR
	 0Ou9r4YtYztAA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: x86 Maintainers <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH v1] arch: x86: kernel: Remove leftover contents of topology.c
Date: Mon, 18 Mar 2024 19:12:45 +0100
Message-ID: <12422874.O9o76ZdvQC@kreacher>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgdduuddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepiedprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdr
 tghomhdprhgtphhtthhopegsphesrghlihgvnhekrdguvg
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The only useful piece of arch/x86/kernel/topology.c is the definition
of arch_cpu_is_hotpluggable() that can be moved elsewhere (other
architectures tend to put it into setup.c), so do that and delete
the rest of the file.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/kernel/Makefile   |    2 +-
 arch/x86/kernel/setup.c    |    8 ++++++++
 arch/x86/kernel/topology.c |   43 -------------------------------------------
 3 files changed, 9 insertions(+), 44 deletions(-)

Index: linux-pm/arch/x86/kernel/setup.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/setup.c
+++ linux-pm/arch/x86/kernel/setup.c
@@ -7,6 +7,7 @@
  */
 #include <linux/acpi.h>
 #include <linux/console.h>
+#include <linux/cpu.h>
 #include <linux/crash_dump.h>
 #include <linux/dma-map-ops.h>
 #include <linux/dmi.h>
@@ -1222,3 +1223,10 @@ static int __init register_kernel_offset
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
Index: linux-pm/arch/x86/kernel/topology.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/topology.c
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
Index: linux-pm/arch/x86/kernel/Makefile
===================================================================
--- linux-pm.orig/arch/x86/kernel/Makefile
+++ linux-pm/arch/x86/kernel/Makefile
@@ -60,7 +60,7 @@ obj-$(CONFIG_X86_64)	+= sys_x86_64.o
 obj-$(CONFIG_X86_ESPFIX64)	+= espfix_64.o
 obj-$(CONFIG_SYSFS)	+= ksysfs.o
 obj-y			+= bootflag.o e820.o
-obj-y			+= pci-dma.o quirks.o topology.o kdebugfs.o
+obj-y			+= pci-dma.o quirks.o kdebugfs.o
 obj-y			+= alternative.o i8253.o hw_breakpoint.o
 obj-y			+= tsc.o tsc_msr.o io_delay.o rtc.o
 obj-y			+= resource.o




