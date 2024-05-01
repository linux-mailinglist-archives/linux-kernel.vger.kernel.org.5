Return-Path: <linux-kernel+bounces-165225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFA98B89CA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6D11F2292D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A34A12EBDF;
	Wed,  1 May 2024 12:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="aN0Xx3IG"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEFA85927
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 12:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714565964; cv=none; b=t7ZURgwnHv79VmYAQSAb3XbEx4h+wK/IA8z6X9qLUcRwsHGP3PsCBH/TTQiQo3rKnbiUpemZgBnafiBhEE0+ApVwQbnUvlbtr271YaVBj5CXSPGyxGIqbXyxS2I+3CWA/Al819NuZT47XNaR8dD5va02uMW3kK8YIdBtyYVgRiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714565964; c=relaxed/simple;
	bh=WZ0YdhfhgqeeWdtO9JpwOCiBLPkx/74G9wavBJNzooo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i9kgS9ARV6uXPYpGmvB25nF4J3CY707JH1H5sYxj8URSWdQ6h1l2yVftE3vTh+ek7Jqii/Zuta8tN771Ook3juDxkQYZxXcmY+L5w91RfzFRznDDKVkqwOT+UZV2KFLtSKhWvaeu++yCX4+EQi3kJJcA7giNthOfYFbYst62uFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=aN0Xx3IG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e651a9f3ffso33946185ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 05:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714565962; x=1715170762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xxd/snqLqM7e5ONTmxzheAfPAEAmi9DZ2uBd4oJ/FYs=;
        b=aN0Xx3IGl0tGFPARP4HvbBlvg035recZ1vbtgJAMMydOTJdKVq3Pj8RVST6l/Oxypk
         HL4vThjVTqhwfL/CaaFtQxDtRWiRXIAK+NQSSsCt4o3oiYXSpou5whCSZS79bpdFguDX
         PW/VdOO1I9YOoyDCLqAUAAf5BkOZtAm6YMbgISSwhQV7B1HSkfZj5BGaSIPh2jQpYseK
         VPBn38yu0cQbg00nqEdKHNGSeOCfy/eF8KkgaOku5rRgW3/9euX4hR5FCflZQITKiRnt
         wPjS0noAfvPuYRZeK1vQxIYlOtmNShJgpC9thxUtyAh4I2Ef2tfZs+WTfz8zLl+wayQU
         3zwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714565962; x=1715170762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xxd/snqLqM7e5ONTmxzheAfPAEAmi9DZ2uBd4oJ/FYs=;
        b=aBkqnSYJV2BBkqvshPm5xM00EIF4YoFGA6aBOCEBDWHIdKLf+2nAlMyA1O48CN/ERk
         Xf9Hl10pzIv5ZvSSMwC6U9sEL/95vFPUloNwAn+6okif3e4rTnoO6OR9521VEQ+5FeI+
         k9RKwaXPMS3j5MiXMKk/EN3anLKNnJW7SsTAHFhlETDWtNwvOn70ukNIEhRRHf/lYvp6
         IFeb3aGac8rheEDXkFb+r7+NEtu4WOfPAOV2ajjYiYA28jfeyvTtx3oYT/hmaOqS06Oq
         vO5XffM533JNfVuSy5PVTeFAQFtXoUEi8zlpJeQJC3omo7rBmaLgGq/7LXHrMi/exXwW
         E7lA==
X-Forwarded-Encrypted: i=1; AJvYcCX9mP8dyNzcE8nHM6RUxBwekAXVq4qDFRCrgP6mp3+CuyyCBww7ZLwW2HJG2x9Kbh5ZCt15Gpo/R5nJfu3I4HP8Cas54/1KSRerq3H1
X-Gm-Message-State: AOJu0YwN45Ks28zUnCQuLpWgI+Rv1oKKoXdnMbYSs4xlW3D3bPk8t3Qo
	fX/RXUWoQmCWMB2Fm2oYvr64HAOwDDBrCvavUKMIwhHMEU7bU1qnLgAyc2j8g6g=
X-Google-Smtp-Source: AGHT+IGHJ7p4jwXpu3JYkUWYmOJNcHmWpwQOeQhUAAD/vtuVqVDXO7Ep5uVJu5jo4IP3B8sXFyhN1A==
X-Received: by 2002:a17:902:f68e:b0:1e4:24cc:e021 with SMTP id l14-20020a170902f68e00b001e424cce021mr2637625plg.50.1714565961718;
        Wed, 01 May 2024 05:19:21 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.106])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001ec8888b22esm1336900plb.65.2024.05.01.05.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 05:19:21 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v5 10/17] ACPI: RISC-V: Implement function to reorder irqchip probe entries
Date: Wed,  1 May 2024 17:47:35 +0530
Message-Id: <20240501121742.1215792-11-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPI MADT entries for interrupt controllers don't have a way to describe
the hierarchy. However, the hierarchy is known to the architecture and
on RISC-V platforms, the MADT sub table types are ordered in the
incremental order from the root controller which is RINTC. So, add
architecture function for RISC-V to reorder the interrupt controller
probing as per the hierarchy as below.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/riscv/Makefile |  2 +-
 drivers/acpi/riscv/irq.c    | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/riscv/irq.c

diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
index 877de00d1b50..a96fdf1e2cb8 100644
--- a/drivers/acpi/riscv/Makefile
+++ b/drivers/acpi/riscv/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y					+= rhct.o init.o
+obj-y					+= rhct.o init.o irq.o
 obj-$(CONFIG_ACPI_PROCESSOR_IDLE)	+= cpuidle.o
 obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
new file mode 100644
index 000000000000..f56e103a501f
--- /dev/null
+++ b/drivers/acpi/riscv/irq.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023-2024, Ventana Micro Systems Inc
+ *	Author: Sunil V L <sunilvl@ventanamicro.com>
+ *
+ */
+
+#include <linux/acpi.h>
+#include <linux/sort.h>
+
+static int irqchip_cmp_func(const void *in0, const void *in1)
+{
+	struct acpi_probe_entry *elem0 = (struct acpi_probe_entry *)in0;
+	struct acpi_probe_entry *elem1 = (struct acpi_probe_entry *)in1;
+
+	return (elem0->type > elem1->type) - (elem0->type < elem1->type);
+}
+
+/*
+ * RISC-V irqchips in MADT of ACPI spec are defined in the same order how
+ * they should be probed. Since IRQCHIP_ACPI_DECLARE doesn't define any
+ * order, this arch function will reorder the probe functions as per the
+ * required order for the architecture.
+ */
+void arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr)
+{
+	struct acpi_probe_entry *ape = ap_head;
+
+	if (nr == 1 || !ACPI_COMPARE_NAMESEG(ACPI_SIG_MADT, ape->id))
+		return;
+	sort(ape, nr, sizeof(*ape), irqchip_cmp_func, NULL);
+}
-- 
2.40.1


