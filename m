Return-Path: <linux-kernel+bounces-6684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D69819C11
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3612B1C22736
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E7921366;
	Wed, 20 Dec 2023 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K7NGFniq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wlOGrnn3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0FA20B26;
	Wed, 20 Dec 2023 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Dec 2023 10:03:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703066640;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=McJSL9PH2b26dWdY7LTBbhjTwGvt5WzRVPSWJPRBUIY=;
	b=K7NGFniqpV+EFA5kW66MNMzlzt2OIkm7ePfIHjXTTMRmkB/VwvQZaG3GOdLE/3cMdJ2bpf
	gFOD+CYdyIwiMjxXai4g5U5YurZ4PpT4TbFOrN4fyo0e/rajB9EeVyJFgLlJx+g+ack7wP
	JvZKFvumxYjlyLn/l5awqk8nbqFgtffMx70KjPAeLumYZmY7T0/asZkDCyCHrkRUnsJUjz
	NQ5G9CG2XSgdSWStivLGw89BSZtslKJ3EwayuhJKyAKQuj59yrSaOHQSV5wYGYJCLlne+S
	K5jv5NUj7GWvFWJfpKoOl8uOenB8mTDGRbME2pEjvKGe3PK57tQnvKYJPiyV6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703066640;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=McJSL9PH2b26dWdY7LTBbhjTwGvt5WzRVPSWJPRBUIY=;
	b=wlOGrnn3OPkvQCz7hVJVca4VJCYMp9sGV95pBeMKn6IOEND/BMvxvXMw++BR5cHbLbdJEK
	vmaSlHio6jWyIcBw==
From: "tip-bot2 for Vegard Nossum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/asm: Add DB flag to 32-bit percpu GDT entry
Cc: Vegard Nossum <vegard.nossum@oracle.com>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20231219151200.2878271-6-vegard.nossum@oracle.com>
References: <20231219151200.2878271-6-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170306663962.398.1278759370786877493.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     bc90aefa99f74452d549d503a3f1cbf3adc9c6bb
Gitweb:        https://git.kernel.org/tip/bc90aefa99f74452d549d503a3f1cbf3adc9c6bb
Author:        Vegard Nossum <vegard.nossum@oracle.com>
AuthorDate:    Tue, 19 Dec 2023 16:12:00 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 20 Dec 2023 10:57:51 +01:00

x86/asm: Add DB flag to 32-bit percpu GDT entry

The D/B size flag for the 32-bit percpu GDT entry was not set.

The Intel manual (vol 3, section 3.4.5) only specifies the meaning of
this flag for three cases:

 1) code segments used for %cs -- doesn't apply here

 2) stack segments used for %ss -- doesn't apply

 3) expand-down data segments -- but we don't have the expand-down flag
    set, so it also doesn't apply here

The flag likely doesn't do anything here, although the manual does also
say: "This flag should always be set to 1 for 32-bit code and data
segments [...]" so we should probably do it anyway.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20231219151200.2878271-6-vegard.nossum@oracle.com
---
 arch/x86/kernel/setup_percpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index f2583de..b30d6e1 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -106,7 +106,7 @@ void __init pcpu_populate_pte(unsigned long addr)
 static inline void setup_percpu_segment(int cpu)
 {
 #ifdef CONFIG_X86_32
-	struct desc_struct d = GDT_ENTRY_INIT(DESC_DATA32 & ~_DESC_DB,
+	struct desc_struct d = GDT_ENTRY_INIT(DESC_DATA32,
 					      per_cpu_offset(cpu), 0xFFFFF);
 
 	write_gdt_entry(get_cpu_gdt_rw(cpu), GDT_ENTRY_PERCPU, &d, DESCTYPE_S);

