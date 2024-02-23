Return-Path: <linux-kernel+bounces-78048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55222860E63
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB571F2691F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEC25C615;
	Fri, 23 Feb 2024 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x4tKrKwr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NFkI9fI6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE69714F8C;
	Fri, 23 Feb 2024 09:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681441; cv=none; b=U0vGo4LO3iXShJoAY7Ga+CxSqSxuL42IplMyvcYCrQu86Xy60Jl7oafycEL2Ixwxw5EMXfWETQs2lgIbcNKFOwOcOd5hIA76ujHe2P/4bLqEToME99pzGrf90GOsCGSrK/hS0iODI0xdyFYaWY9AArwJCGBxFQh1B5qXgsQ13GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681441; c=relaxed/simple;
	bh=ab2I6JkexfU+9v41SMqz4psQrcPaq4GJN2LCA6JMPsU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lC8B6djAqxYearDuFtyiC2O8DvBSwnsiRhauPuGsFDbke/PFE3qrUSNo8gfRE5+LuuF96EO73F2KBeFPO0RFfm25ApNGk1FQoCkJ+oF6MGwTsQ/9f99Peo7aTmxOnwMfFWcRIsNPHF6mphPLZf/gCEpu0drHmZ8773XI26GUdJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x4tKrKwr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NFkI9fI6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 Feb 2024 09:43:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708681432;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ucm4lAwyWPcwo/tq+3h/qsYC19yBS3eu8e1YCZAEME0=;
	b=x4tKrKwrg+8mKQ3YXADmdfbf1hU6//wecawbuCH5SJjnq7KC8CGNhWTmetGjNlzZxh8zb4
	2AwT9MnH+QAetVhrGlnffPK0TgHUrJYJ4BrRvjsiuMZA84p8lHvkgr/7yGW+McdVsoF/cG
	uHh7/n4JHX3QK20GQFG2CHYfBSoYFKcl9GoV1tD3cLNPXGG/IkkdY0Mc8bw0FPuT9OYNr3
	WvFk/83V1D9qtoTWjojX7wKbUS32dK11QZd3cP8iJUKfgr56P3U+VXzCrhbOD7NcswBskF
	Nwx7blsUaDcDsMeVIHRSpSjCypnIVeajPtjDYCZjuGlZr4FaPWZcqbmy1rgidg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708681432;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ucm4lAwyWPcwo/tq+3h/qsYC19yBS3eu8e1YCZAEME0=;
	b=NFkI9fI65JwjrUfXzn4Mqnug2hmLU/C36SoFl+U41oe5gRQ5k8uvRul6kQ1lqOoAkzq/la
	0CBxOGoIUb3n5iCg==
From:
 tip-bot2 for =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/matrix: Dynamic bitmap allocation
Cc: bjorn@rivosinc.com, Anup Patel <apatel@ventanamicro.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240222094006.1030709-11-apatel@ventanamicro.com>
References: <20240222094006.1030709-11-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170868143119.398.7440083204320178509.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     5b98d210ac1e4eb35abfbd940df50dec10ae81e1
Gitweb:        https://git.kernel.org/tip/5b98d210ac1e4eb35abfbd940df50dec10a=
e81e1
Author:        Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
AuthorDate:    Thu, 22 Feb 2024 15:09:58 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 23 Feb 2024 10:18:44 +01:00

genirq/matrix: Dynamic bitmap allocation

A future user of the matrix allocator, does not know the size of the matrix
bitmaps at compile time.

To avoid wasting memory on unnecessary large bitmaps, size the bitmap at
matrix allocation time.

Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240222094006.1030709-11-apatel@ventanamicro=
com

---
 arch/x86/include/asm/hw_irq.h |  2 --
 kernel/irq/matrix.c           | 28 +++++++++++++++++-----------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index b02c3cd..edebf10 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -16,8 +16,6 @@
=20
 #include <asm/irq_vectors.h>
=20
-#define IRQ_MATRIX_BITS		NR_VECTORS
-
 #ifndef __ASSEMBLY__
=20
 #include <linux/percpu.h>
diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 75d0ae4..8f222d1 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -8,8 +8,6 @@
 #include <linux/cpu.h>
 #include <linux/irq.h>
=20
-#define IRQ_MATRIX_SIZE	(BITS_TO_LONGS(IRQ_MATRIX_BITS))
-
 struct cpumap {
 	unsigned int		available;
 	unsigned int		allocated;
@@ -17,8 +15,8 @@ struct cpumap {
 	unsigned int		managed_allocated;
 	bool			initialized;
 	bool			online;
-	unsigned long		alloc_map[IRQ_MATRIX_SIZE];
-	unsigned long		managed_map[IRQ_MATRIX_SIZE];
+	unsigned long		*managed_map;
+	unsigned long		alloc_map[];
 };
=20
 struct irq_matrix {
@@ -32,8 +30,8 @@ struct irq_matrix {
 	unsigned int		total_allocated;
 	unsigned int		online_maps;
 	struct cpumap __percpu	*maps;
-	unsigned long		scratch_map[IRQ_MATRIX_SIZE];
-	unsigned long		system_map[IRQ_MATRIX_SIZE];
+	unsigned long		*system_map;
+	unsigned long		scratch_map[];
 };
=20
 #define CREATE_TRACE_POINTS
@@ -50,24 +48,32 @@ __init struct irq_matrix *irq_alloc_matrix(unsigned int m=
atrix_bits,
 					   unsigned int alloc_start,
 					   unsigned int alloc_end)
 {
+	unsigned int cpu, matrix_size =3D BITS_TO_LONGS(matrix_bits);
 	struct irq_matrix *m;
=20
-	if (matrix_bits > IRQ_MATRIX_BITS)
-		return NULL;
-
-	m =3D kzalloc(sizeof(*m), GFP_KERNEL);
+	m =3D kzalloc(struct_size(m, scratch_map, matrix_size * 2), GFP_KERNEL);
 	if (!m)
 		return NULL;
=20
+	m->system_map =3D &m->scratch_map[matrix_size];
+
 	m->matrix_bits =3D matrix_bits;
 	m->alloc_start =3D alloc_start;
 	m->alloc_end =3D alloc_end;
 	m->alloc_size =3D alloc_end - alloc_start;
-	m->maps =3D alloc_percpu(*m->maps);
+	m->maps =3D __alloc_percpu(struct_size(m->maps, alloc_map, matrix_size * 2),
+				 __alignof__(*m->maps));
 	if (!m->maps) {
 		kfree(m);
 		return NULL;
 	}
+
+	for_each_possible_cpu(cpu) {
+		struct cpumap *cm =3D per_cpu_ptr(m->maps, cpu);
+
+		cm->managed_map =3D &cm->alloc_map[matrix_size];
+	}
+
 	return m;
 }
=20

