Return-Path: <linux-kernel+bounces-68831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C928580C9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC711C20B77
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78C214A088;
	Fri, 16 Feb 2024 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WiTZGcje";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2PH0a4Mm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54061482F8;
	Fri, 16 Feb 2024 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096641; cv=none; b=ucc7oMnkcPexIx5KSzEa79v6/99eGCIS5JodLE+ejFTFB2LJE8hu+K86D7fGIXVbgdEXcbZEDZsKVqoCg2UhDMPcw3tznUL5R+WJQcqOJOb3UZ33jsoLCqHQsteXyCXdslEKN1a4VInrCsXl8HOQrfBDaSB5SgcVIk0iat9FzfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096641; c=relaxed/simple;
	bh=W6IkiDaHSQcH08JZ06jgT61Ci05rfvKYeWWcyFvwBww=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SC2KyF7q8/BG+myUOmPlw1mHf9Sai+J9cc2APPKDWF09ZUbpOY8RW+8e8XdtLa5TTUUGsMvoHC9pFT7ChhAyZ/Z3+lEGnwxbK1F5XO22bMBA/pcrGKsNquxRis5DIGWZi2cIe2mU0mMRc88k4TMp2a9zxti4D+JAAz/FfBRz2LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WiTZGcje; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2PH0a4Mm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096638;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+guX6p9+GZlAySuMScx26xWtV3AHd/EP4htMfs7efY=;
	b=WiTZGcjepeS29ro8t+d0YGjAGhFMpcT/zBbPGi/ATa1zB/m8OWSrFG/ObgIkXCopJyDn+9
	Dx7Q3/PPKkd0sMZ5r+0DKlxzWrYUfDBuNvvdn/DtV3xyu6zUVx51+Hid0U53jr0oEIxY3P
	8XbgoRr19og+UsAFEvdkY22IOJB3zUGFK9I2BO2uTDS9T3UdzeXJ0pSddFhhJoZywmET+d
	GbT/goecilJGxim3as762D5OQbKK7bijY70oxAveTP8gD0NbbUU6c3bWfqbXnyE9x/Kbb6
	c/fNozs7oHXD1Q/mxMfDQ92LmUYlBdBPZmfdg39ceAOD3FvdJIv5DrWyBCO6bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096638;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2+guX6p9+GZlAySuMScx26xWtV3AHd/EP4htMfs7efY=;
	b=2PH0a4MmWEo+QIajCDR68z+h0+85WYKxmqCYeeIEJ24ta3xhkJdPFWu/8ixkzzZrKssLSe
	yieCC2Jt2vnDalAw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/dtb: Rename x86_dtb_init()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240212154639.495992801@linutronix.de>
References: <20240212154639.495992801@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809663770.398.12953695910445393819.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     5faf8ec77111a699b6a566c4155511fc020f8644
Gitweb:        https://git.kernel.org/tip/5faf8ec77111a699b6a566c4155511fc020f8644
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:06 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:40 +01:00

x86/dtb: Rename x86_dtb_init()

x86_dtb_init() is a misnomer and it really should be used as a SMP
configuration parser which is selected by the platform via
x86_init::mpparse:parse_smp_config().

Rename it to x86_dtb_parse_smp_config() in preparation for that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240212154639.495992801@linutronix.de



---
 arch/x86/include/asm/prom.h  | 4 ++--
 arch/x86/kernel/devicetree.c | 2 +-
 arch/x86/kernel/setup.c      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/prom.h b/arch/x86/include/asm/prom.h
index 65dee24..043758a 100644
--- a/arch/x86/include/asm/prom.h
+++ b/arch/x86/include/asm/prom.h
@@ -23,11 +23,11 @@ extern int of_ioapic;
 extern u64 initial_dtb;
 extern void add_dtb(u64 data);
 void x86_of_pci_init(void);
-void x86_dtb_init(void);
+void x86_dtb_parse_smp_config(void);
 #else
 static inline void add_dtb(u64 data) { }
 static inline void x86_of_pci_init(void) { }
-static inline void x86_dtb_init(void) { }
+static inline void x86_dtb_parse_smp_config(void) { }
 #define of_ioapic 0
 #endif
 
diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index afd0992..c05b900 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -302,7 +302,7 @@ void __init x86_flattree_get_config(void)
 }
 #endif
 
-void __init x86_dtb_init(void)
+void __init x86_dtb_parse_smp_config(void)
 {
 	if (!of_have_populated_dt())
 		return;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 0e431c9..39edb89 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1133,7 +1133,7 @@ void __init setup_arch(char **cmdline_p)
 	 * Read APIC and some other early information from ACPI tables.
 	 */
 	acpi_boot_init();
-	x86_dtb_init();
+	x86_dtb_parse_smp_config();
 
 	/*
 	 * get boot-time SMP configuration:

