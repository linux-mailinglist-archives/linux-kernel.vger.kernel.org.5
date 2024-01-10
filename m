Return-Path: <linux-kernel+bounces-21949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3010829700
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6831F218CF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F314438C;
	Wed, 10 Jan 2024 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W54yrdbi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LkG2atyT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FDC405FF;
	Wed, 10 Jan 2024 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jan 2024 10:09:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704881396;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TIgW4R6YAM5Po2GV3pibFu2xpbNoKGCJeRWB/9sD/E=;
	b=W54yrdbiyvXoYWmUVGcN1faSFY4UWEe7oJBP1U1lJeeQ0IqeCOeummWASOEm+AnsZW3KGc
	wSpkWsJao+XQ8YrSXWIu6LwNZTzRIUaFltY61t/fXZJR96KgFNCOwge9dwE3bkh5nGBgFz
	NX1YWZwcnGSds3qg3kKnkogaWM87m6/k6Jwr5DsP6M2d2QtimPOv5AzTHoDGhIzAYQqzTw
	JairGqpiL0cu5kAE/fPAfRLhYuNr44kQHa35OdDNlkxOHdrgMw3hu36yMxMuNbsQkaPQA7
	LKD/YQohK2zAVSpKLGWigHc+sD+jK2Zu2ZcvcPXQM53svR8sVSrSjpBDRy5cgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704881396;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3TIgW4R6YAM5Po2GV3pibFu2xpbNoKGCJeRWB/9sD/E=;
	b=LkG2atyTxqPl6qeJh0GBNlIBKlp03/QRh1zomBmldzdEYIFLrxVf5JBYaEj4BfZkq8ddJG
	8aZx+NLspSkP+UCw==
From: "tip-bot2 for Breno Leitao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/bugs: Rename CONFIG_GDS_FORCE_MITIGATION =>
 CONFIG_MITIGATION_GDS_FORCE
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Breno Leitao <leitao@debian.org>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231121160740.1249350-2-leitao@debian.org>
References: <20231121160740.1249350-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170488139531.398.13211930159092959781.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     be83e809ca67bca98fde97ad6b9344237963220b
Gitweb:        https://git.kernel.org/tip/be83e809ca67bca98fde97ad6b9344237963220b
Author:        Breno Leitao <leitao@debian.org>
AuthorDate:    Tue, 21 Nov 2023 08:07:28 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 10 Jan 2024 10:43:14 +01:00

x86/bugs: Rename CONFIG_GDS_FORCE_MITIGATION => CONFIG_MITIGATION_GDS_FORCE

So the CPU mitigations Kconfig entries - there's 10 meanwhile - are named
in a historically idiosyncratic and hence rather inconsistent fashion
and have become hard to relate with each other over the years:

   https://lore.kernel.org/lkml/20231011044252.42bplzjsam3qsasz@treble/

When they were introduced we never expected that we'd eventually have
about a dozen of them, and that more organization would be useful,
especially for Linux distributions that want to enable them in an
informed fashion, and want to make sure all mitigations are configured
as expected.

For example, the current CONFIG_SPECULATION_MITIGATIONS namespace is only
halfway populated, where some mitigations have entries in Kconfig, and
they could be modified, while others mitigations do not have Kconfig entries,
and can not be controlled at build time.

Fine-grained control over these Kconfig entries can help in a number of ways:

  1) Users can choose and pick only mitigations that are important for
     their workloads.

  2) Users and developers can choose to disable mitigations that mangle
     the assembly code generation, making it hard to read.

  3) Separate Kconfigs for just source code readability,
     so that we see *which* butt-ugly piece of crap code is for what
     reason...

In most cases, if a mitigation is disabled at compilation time, it
can still be enabled at runtime using kernel command line arguments.

This is the first patch of an initial series that renames various
mitigation related Kconfig options, unifying them under a single
CONFIG_MITIGATION_* namespace:

    CONFIG_GDS_FORCE_MITIGATION => CONFIG_MITIGATION_GDS_FORCE
    CONFIG_CPU_IBPB_ENTRY       => CONFIG_MITIGATION_IBPB_ENTRY
    CONFIG_CALL_DEPTH_TRACKING  => CONFIG_MITIGATION_CALL_DEPTH_TRACKING
    CONFIG_PAGE_TABLE_ISOLATION => CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
    CONFIG_RETPOLINE            => CONFIG_MITIGATION_RETPOLINE
    CONFIG_SLS                  => CONFIG_MITIGATION_SLS
    CONFIG_CPU_UNRET_ENTRY      => CONFIG_MITIGATION_UNRET_ENTRY
    CONFIG_CPU_IBRS_ENTRY       => CONFIG_MITIGATION_IBRS_ENTRY
    CONFIG_CPU_SRSO             => CONFIG_MITIGATION_SRSO
    CONFIG_RETHUNK              => CONFIG_MITIGATION_RETHUNK

Implement step 1/10 of the namespace unification of CPU mitigations related
Kconfig options and rename CONFIG_GDS_FORCE_MITIGATION to
CONFIG_MITIGATION_GDS_FORCE.

[ mingo: Rewrote changelog for clarity. ]

Suggested-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20231121160740.1249350-2-leitao@debian.org
---
 arch/x86/Kconfig           | 2 +-
 arch/x86/kernel/cpu/bugs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 53f2e77..1dba33a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2587,7 +2587,7 @@ config SLS
 	  against straight line speculation. The kernel image might be slightly
 	  larger.
 
-config GDS_FORCE_MITIGATION
+config MITIGATION_GDS_FORCE
 	bool "Force GDS Mitigation"
 	depends on CPU_SUP_INTEL
 	default n
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index bb0ab84..3c7e27b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -671,7 +671,7 @@ enum gds_mitigations {
 	GDS_MITIGATION_HYPERVISOR,
 };
 
-#if IS_ENABLED(CONFIG_GDS_FORCE_MITIGATION)
+#if IS_ENABLED(CONFIG_MITIGATION_GDS_FORCE)
 static enum gds_mitigations gds_mitigation __ro_after_init = GDS_MITIGATION_FORCE;
 #else
 static enum gds_mitigations gds_mitigation __ro_after_init = GDS_MITIGATION_FULL;

