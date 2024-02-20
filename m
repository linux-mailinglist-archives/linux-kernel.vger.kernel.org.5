Return-Path: <linux-kernel+bounces-72380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D0C85B2A6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2643B283BDF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5597958AA9;
	Tue, 20 Feb 2024 06:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="aPqJCBdc"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1820659173
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708409298; cv=none; b=PLGmhh9n8+2eNFVAkaf/04w2PCXekTJ9mVCY5jmNDnzEIkfxe92eei5W4yp6D5imJ90d9YXHlLtKaYq1V2B+z65GI4PB2shQ9tdJdeukpCTXT6SSlb9E4yTDFqtTZuDB2NlqEE0HXOBjBl1zbtr+aRs0RF98/bDACVB8eESi9yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708409298; c=relaxed/simple;
	bh=v7MGRVtZtPXfGkmyqYWN6Y63LLsHhhJ5iWWU9xTfhDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjpByJhQYbZMEKlcsMnj2NVZZioKfL8TcxEMhLuNEbNEUk7uOJmMrcSnT+absKq4C83nOlyBKM6raifCosujSTlJGfaZXK9hgBowNV4bZ5LRZB/wvkkGVXqdk60YT9vqXK1Exca/Z2mQDnXZ2JnLyXAY6LRynZAmfxGO5KIl7CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=aPqJCBdc; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d7232dcb3eso27198745ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 22:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708409296; x=1709014096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=104PBPP87dGRJ1dWRj3TJVt38h0tClUYGYzJ0Qy5+KM=;
        b=aPqJCBdcguj+QRV4/8xux4H71k2JcnCkg5WcnCVabn4aemZ/VLzcnb+Ows6/pAMOm9
         MEFIXo/d5dOURfIn8uLgIL4dzq9AszhBy9MF0BfE8r24BZ+xaAkPZtyrP2XcMl3ducAs
         Q8JSiDBFf1uakZgJTUltK7JdFn23Wli7Ch66deirIqZWtNVUosiigJl9jayH0knyLDUt
         r/yzfJmlV7Sy7COHIl/erle9ILw7q0lb5BZ4JB5qGErxHyqII1RZqox3Y0vUSxpjIvQ0
         BGeZhymC8whTvqcdYG+0jiGII/c5FoMk1zVSkkjWkqcsXSi6zihkvpuPCD3zVFG9P0Pc
         BThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708409296; x=1709014096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=104PBPP87dGRJ1dWRj3TJVt38h0tClUYGYzJ0Qy5+KM=;
        b=SjyrIuXDdKTBY7K08t41xDR42vUkRCD4qXMcwQScDELFqQ9OuanGn4gdt49FFvmKm8
         Nj2jvtkdeFAOPMFp6f/43h6QkHCRqtvZg46a94WLBx7SBn+FrWtQ5HGbXaZuhqt2gjaS
         aWzj87ryBrHFfyXeKpxKfuOrhX39uy7eHXEbksc2p1cHNbfB9JQ3TKzkR/xAgKfmuMZr
         9B07Xl0+L/bfF0npy3J8HNT+nGTCGeK1AHED34iwspXJjTobaRJmYXd83uRu1Jug7s8A
         MXwOknEms8HupndsXHFnNdHNpuBNntYP7Fv6kqFEqYEoaTRDgm98mBOECF4D9yOAx1yp
         QSyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/Z9N1CvoJMjEp8XS+QlrN1+/ymRigpVL1LzwG+C6Mv6Rbm3FwWZLVk8AMQHCoNkajYS5Ct82uWjm6MSDeZ6c4O6x1r/FYKbzGbtxz
X-Gm-Message-State: AOJu0Yw6/NbzvsIl8A7vtJ8kii3DF2LOHIduM6eDklnYnlXeT+oCWd6t
	Syxn5fIDAayLeVjUVH3uuaZuT3FryZhiVhKoyb9K5Y6uVthkoZnUbM1OUzRTOKw=
X-Google-Smtp-Source: AGHT+IFY/JcHrI+xAG094ZcXNaFl0GQyv1RbkAVoM5o1aUQFAbhKoPaBFMazisxA1YDdZaveAQB90g==
X-Received: by 2002:a17:902:cf0e:b0:1db:a164:3e50 with SMTP id i14-20020a170902cf0e00b001dba1643e50mr13726229plg.40.1708409296360;
        Mon, 19 Feb 2024 22:08:16 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([171.76.80.86])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090276c600b001db4c89aea5sm5368114plt.158.2024.02.19.22.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 22:08:15 -0800 (PST)
From: Anup Patel <apatel@ventanamicro.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Atish Patra <atishp@atishpatra.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Saravana Kannan <saravanak@google.com>,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v13 05/13] genirq/matrix: Dynamic bitmap allocation
Date: Tue, 20 Feb 2024 11:37:10 +0530
Message-Id: <20240220060718.823229-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220060718.823229-1-apatel@ventanamicro.com>
References: <20240220060718.823229-1-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

Some (future) users of the irq matrix allocator, do not know the size
of the matrix bitmaps at compile time.

To avoid wasting memory on unnecessary large bitmaps, size the bitmap
at matrix allocation time.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/x86/include/asm/hw_irq.h |  2 --
 kernel/irq/matrix.c           | 28 +++++++++++++++++-----------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index b02c3cd3c0f6..edebf1020e04 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -16,8 +16,6 @@
 
 #include <asm/irq_vectors.h>
 
-#define IRQ_MATRIX_BITS		NR_VECTORS
-
 #ifndef __ASSEMBLY__
 
 #include <linux/percpu.h>
diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 75d0ae490e29..8f222d1cccec 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -8,8 +8,6 @@
 #include <linux/cpu.h>
 #include <linux/irq.h>
 
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
 
 #define CREATE_TRACE_POINTS
@@ -50,24 +48,32 @@ __init struct irq_matrix *irq_alloc_matrix(unsigned int matrix_bits,
 					   unsigned int alloc_start,
 					   unsigned int alloc_end)
 {
+	unsigned int cpu, matrix_size = BITS_TO_LONGS(matrix_bits);
 	struct irq_matrix *m;
 
-	if (matrix_bits > IRQ_MATRIX_BITS)
-		return NULL;
-
-	m = kzalloc(sizeof(*m), GFP_KERNEL);
+	m = kzalloc(struct_size(m, scratch_map, matrix_size * 2), GFP_KERNEL);
 	if (!m)
 		return NULL;
 
+	m->system_map = &m->scratch_map[matrix_size];
+
 	m->matrix_bits = matrix_bits;
 	m->alloc_start = alloc_start;
 	m->alloc_end = alloc_end;
 	m->alloc_size = alloc_end - alloc_start;
-	m->maps = alloc_percpu(*m->maps);
+	m->maps = __alloc_percpu(struct_size(m->maps, alloc_map, matrix_size * 2),
+				 __alignof__(*m->maps));
 	if (!m->maps) {
 		kfree(m);
 		return NULL;
 	}
+
+	for_each_possible_cpu(cpu) {
+		struct cpumap *cm = per_cpu_ptr(m->maps, cpu);
+
+		cm->managed_map = &cm->alloc_map[matrix_size];
+	}
+
 	return m;
 }
 
-- 
2.34.1


