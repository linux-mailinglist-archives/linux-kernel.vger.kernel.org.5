Return-Path: <linux-kernel+bounces-76249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ECE85F4BF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9D91C222BC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AF03FB2F;
	Thu, 22 Feb 2024 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="QtWU6bjM"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89F03B182
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594900; cv=none; b=M+ov+o3rMxYCZ5ns+hxWMU/3VZLo28woff4XSsR9a6te7JF25LLtMD8ygPXEcSVak/DLueE4uI72/IDOGrgC3wutBU5G/0bf2GHlk8m5LJJ2Frue3ZdignEhM5eXujxSp84u+i6WNpxXWk3wvce6ymKAzGCJgJnWWDN2XHFB4qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594900; c=relaxed/simple;
	bh=v7MGRVtZtPXfGkmyqYWN6Y63LLsHhhJ5iWWU9xTfhDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i8hYnXGXtztvcQrVkAvJQAtxOWb/My26vMJcw72qn0xP2xXdkygcbdnmU9otsVyEOfOeblbjLYsyCt8HFAfVwAD//0g2PZhohEtb7C12YTF4ZALjnb/j33yrlo4bLnPWdJM/b97YrYUxas+h85hC2Vg8pDRnCCdPEdpaVJRzZhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=QtWU6bjM; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bd4e6a7cb0so5227653b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708594897; x=1709199697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=104PBPP87dGRJ1dWRj3TJVt38h0tClUYGYzJ0Qy5+KM=;
        b=QtWU6bjMpLIs7y1TwU7tZi9d9/Sj/I/zt+N22JwUml+NHw0PGCCr8+jPoDUcL9v5Ci
         9BEzw9CA0RbUixmSt9DfDQY7wIOhFSA+JbIEk2cVCuB8rfXKMMuXh7FPq3uF/qWD9z+/
         RGpREcR3qe8Xv15Et5sSblFQ7HPYVypYj6qd1g6hlkzE7WdcH2x3jo3E/bDR1QnDTWC8
         PeKrT6oU9DhCEeDWSR0xmKdxdO35w8u6BtzumH//pN5jMuuRJxfbZCV4Wuu3XNghvzAo
         ErXhSu+UbvZEi6GU5ss/k1HuNFY5s+ZR8luET4Yzi7jM0SfcALLW+ETNObhr7xtO7PcM
         mWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708594897; x=1709199697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=104PBPP87dGRJ1dWRj3TJVt38h0tClUYGYzJ0Qy5+KM=;
        b=jlBHC1XBviUR3PrpFla3W+yRaaN8Vp9O6yEf1pVa9IKvYI56ezifJBLsYIE6kVL03R
         CCsOphv21ZK3enKjWMofD8N/MoVXRPIYIV1smXyEkcTzXnZcCy38kdSwxU5i2tMIjgy7
         NRh36STyn+mPuRlYcRYRlOuW0evABdBmoK14GwGj25tj/TlRUn+aPqri8NsK8N2yIUy2
         cY5hyck76VffX11harGff4VrUfk6nbM1pNHEiAwCcbXT/ZkI6mfYb20Qezj0TERsmwMb
         S4IterAHbNzmNP6ynEHoxmBlBXvkCvs3w+2aiacJXYGcw65DmZ46YJaobQfrTtNyhWyP
         H02A==
X-Forwarded-Encrypted: i=1; AJvYcCWq3d5PhTuBm6BPTYaWrFX3qoTZd/g1RKaHXAV6eVKxph8eYf7Cz8cJHX38kH0WVfTo2h17fhtHyRmzuIH649SI793jxr05Kqxp/c5l
X-Gm-Message-State: AOJu0YyWPhtdTZOz9p4VzMIHwsH6w6ArEZCjdN/ykw5XYe7A+4hG3y/b
	KYWu8fl1G8qcBfW/YE+sk/yuoxmJWnM8zz5aQIYf0eDgevhHjqZ8ZeLKD7kkqlo=
X-Google-Smtp-Source: AGHT+IG88khSq1/PCKAmx/cLM4tzht00nwLDSagx3gre/CG1DcDTTQJYSGtnn3JbDviLDEoBKv0D4Q==
X-Received: by 2002:a05:6808:118b:b0:3c1:59ea:1b9b with SMTP id j11-20020a056808118b00b003c159ea1b9bmr11802239oil.50.1708594897585;
        Thu, 22 Feb 2024 01:41:37 -0800 (PST)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id n15-20020a05680803af00b003c17c2b8d09sm130699oie.31.2024.02.22.01.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 01:41:37 -0800 (PST)
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
Subject: [PATCH v14 10/18] genirq/matrix: Dynamic bitmap allocation
Date: Thu, 22 Feb 2024 15:09:58 +0530
Message-Id: <20240222094006.1030709-11-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222094006.1030709-1-apatel@ventanamicro.com>
References: <20240222094006.1030709-1-apatel@ventanamicro.com>
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


