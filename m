Return-Path: <linux-kernel+bounces-5720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EA5818E8F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049E01C24BDB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901A239AEC;
	Tue, 19 Dec 2023 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="hXeec/N+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEB13A1B9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3e84fded7so3141565ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 09:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703007980; x=1703612780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxzCTJ+m1lwBq+RMy/cftySc6UneYPqTwJF8JhbniDw=;
        b=hXeec/N+8w/TaInjdCZDrwA5oxBuB2FqPrscUupZ/mHRD7vS0bP/9ortxDQJfhhWlq
         Btu267dcv/FSnCuA0hbLdqLG3jcn/iRqoyYaJDEbtKGTRW9jDnTscM/iX2bifzw6OOnw
         +7eVmklAy/HVpmz8sj4gl6aBgYUa3w9phzafjcZLNOZeZAZZqRqXvXtMTNjlJZZYxDdN
         WYYGD4q3WdhPn2XT00MaI7piSCUqWG+DrZzDEgiM/aKPEWyx3DbXaNutdhdwOs042tPt
         0jGDHitJhY1cuDoBVrGrtIuCvDnfM6yy6tb7en4gtEWcDm8Hso86Dyu2NZ17pz4NnvTr
         A1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703007980; x=1703612780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxzCTJ+m1lwBq+RMy/cftySc6UneYPqTwJF8JhbniDw=;
        b=sp8MVY97uz+FhLA6BQd3lB4loLoRQQ1A8jtUntBGn313kZ+v5gAEXeTs5mccurCke2
         mKABN0tAnOK3bwJqooVoZUjXHIEKAJp4n87TpFgQ2KWWlT56udicN5XloRCbYylC0t2p
         HE7LmDPqMC/Y1yFhVsT6WTErcO6zCC890pX4dpgtgY4nvF+BLSAyGxEoablz1zQyayj2
         i06mH7Y+ZAko/Ce3RCLbq9m0r6OKaPYr+FsJPm0GhzzfFRx3TgU/QLn8X4PdNWrOMByk
         7fX4laVmj3ckx3uxSDfjozQDTLzEGxDGyglAk7Cf769/Cgq8E9fHh7A2NVlgYPyv9eKf
         +G8w==
X-Gm-Message-State: AOJu0YzYXM9xS1WL3+f3M9TKzA8B8iLunTlBt9BsbdY0OwTCNHLMo9tW
	FLo2QRdSmrc+kMsl/Ri1bWGWGg==
X-Google-Smtp-Source: AGHT+IGFtvkGTPcA5+8hPSE9xpA6pHB1AGzz+4bVKCbl0RMQ6TV2kDkPIPCZHZCd/3GrTRkpVagWdQ==
X-Received: by 2002:a17:903:41c8:b0:1d3:c5e4:b2f3 with SMTP id u8-20020a17090341c800b001d3c5e4b2f3mr2609020ple.100.1703007980064;
        Tue, 19 Dec 2023 09:46:20 -0800 (PST)
Received: from sunil-pc.Dlink ([106.51.188.200])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b001d3320f6143sm14453015plh.269.2023.12.19.09.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:46:19 -0800 (PST)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v3 08/17] ACPI: RISC-V: Implement arch function to reorder irqchip probe entries
Date: Tue, 19 Dec 2023 23:15:17 +0530
Message-Id: <20231219174526.2235150-9-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
References: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
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

RINTC->IMSIC->APLIC->PLIC

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/riscv/Makefile |  2 +-
 drivers/acpi/riscv/irq.c    | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/riscv/irq.c

diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
index 8b3b126e0b94..f80b3da230e9 100644
--- a/drivers/acpi/riscv/Makefile
+++ b/drivers/acpi/riscv/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y 	+= rhct.o
+obj-y 	+= rhct.o irq.o
diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
new file mode 100644
index 000000000000..36e0525b3235
--- /dev/null
+++ b/drivers/acpi/riscv/irq.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023, Ventana Micro Systems Inc
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
2.39.2


