Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA10E7B0AC4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjI0RAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjI0RAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:00:35 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AF3F5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 10:00:33 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-578d0d94986so8323809a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 10:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695834033; x=1696438833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9sLv+V8gGTdOjGyr5tjbv9gRJE2ViFoNFxWNgg6Hz8=;
        b=ImEM1Z7qQWJ9pWvjGfmPTZ6MedwTOlrrGPtiX5vsmQ3sUZ7MJxNJfy0baVKQiTMuZl
         n/sixhJG7Bna30gD0zlbk4h+NX5oTGDQedW9KHdC+WhNtxs9q0WlpdMBXlkFGbAl8zUU
         jEaelMhEX430FdiP0oWUkku+aI4HWNpzlt9xfMRC3Ck5/e1yPtPbbTyo6PDpn66S04KG
         2xfbey3SI0sMFsVbY7xEyQCz75FwnVeIL05esfhexrsbdU9pdpfu5A8V33YkVVfUF/vY
         bRdnxr0SYls53DcWGj/ghuNSKzPmgkuCaw9bA0vna1E6gttCE/gvsAkoj/B7HLtwufqt
         qy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695834033; x=1696438833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9sLv+V8gGTdOjGyr5tjbv9gRJE2ViFoNFxWNgg6Hz8=;
        b=jTdo79s/3W1d4yNP/uZ42LvvM5DdxrSNnGjiAP5MO0C1NISGyZDge3n8YUHiXyVbhu
         iTq+dlqt0z3RQEv9QUncPE2lWUwN8IDYZ2ajwEOoWrCIeS8kklPGvNkPPK65TKiX+92I
         /Pc/2MSMW+pB5o6tTgaqYdZEZmre89sqRxqnvUzQn3ci21d9IjXR24f0/nwZXam0HIFY
         hKAL95K5Hpe5d4J5J5zrF4TQMgmvYQzWxIl/+qJXkk6pR1I8q1M3CbvKukRWYNyL6OMN
         vQsFPWUNxJ+cSvYc1eijFrgHitAXkEARaIP1+eSu8BUCGHISXpEYQNyMX5t8h5sNkQZE
         QVfg==
X-Gm-Message-State: AOJu0YyQnRdNhFwUQrlYn+T7sxmd/R7NGbNQVgjSPwYl5iaaUmoc+zHl
        0b1k2Kgb4r1ql45Q+u+CEGRQyQ==
X-Google-Smtp-Source: AGHT+IEa6asAbG8e1D9Wtlofxs/aqoo7qS7D0/bHcFiviEGPFGXQU+G/6kse8wYhSvo9I9okP5V4Sw==
X-Received: by 2002:a05:6a20:7d95:b0:14c:daa9:5e22 with SMTP id v21-20020a056a207d9500b0014cdaa95e22mr2978244pzj.45.1695834033151;
        Wed, 27 Sep 2023 10:00:33 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.42])
        by smtp.gmail.com with ESMTPSA id u7-20020a637907000000b00584b293d157sm3279396pgc.80.2023.09.27.10.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 10:00:32 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v2 -next 2/4] RISC-V: ACPI: RHCT: Add function to get CBO block sizes
Date:   Wed, 27 Sep 2023 22:30:13 +0530
Message-Id: <20230927170015.295232-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927170015.295232-1-sunilvl@ventanamicro.com>
References: <20230927170015.295232-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cache Block Operation (CBO) related block size in ACPI is provided by RHCT.
Add support to read the CMO node in RHCT to get this information.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/include/asm/acpi.h |  9 +++++
 drivers/acpi/riscv/rhct.c     | 72 ++++++++++++++++++++++++++++++++++-
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index d5604d2073bc..0c4e8b35103e 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -66,6 +66,8 @@ int acpi_get_riscv_isa(struct acpi_table_header *table,
 		       unsigned int cpu, const char **isa);
 
 static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
+int acpi_get_cbo_block_size(struct acpi_table_header *table, unsigned int cpu, u32 *cbom_size,
+			    u32 *cboz_size, u32 *cbop_size);
 #else
 static inline void acpi_init_rintc_map(void) { }
 static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
@@ -79,6 +81,13 @@ static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
 	return -EINVAL;
 }
 
+static inline int acpi_get_cbo_block_size(struct acpi_table_header *table,
+					  unsigned int cpu, u32 *cbom_size,
+					  u32 *cboz_size, u32 *cbop_size)
+{
+	return -EINVAL;
+}
+
 #endif /* CONFIG_ACPI */
 
 #endif /*_ASM_ACPI_H*/
diff --git a/drivers/acpi/riscv/rhct.c b/drivers/acpi/riscv/rhct.c
index b280b3e9c7d9..9042949277f8 100644
--- a/drivers/acpi/riscv/rhct.c
+++ b/drivers/acpi/riscv/rhct.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt)     "ACPI: RHCT: " fmt
 
 #include <linux/acpi.h>
+#include <linux/bits.h>
 
 static struct acpi_table_header *acpi_get_rhct(void)
 {
@@ -56,7 +57,6 @@ int acpi_get_riscv_isa(struct acpi_table_header *table, unsigned int cpu, const
 	}
 
 	end = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->header.length);
-
 	for (node = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->node_offset);
 	     node < end;
 	     node = ACPI_ADD_PTR(struct acpi_rhct_node_header, node, node->length)) {
@@ -81,3 +81,73 @@ int acpi_get_riscv_isa(struct acpi_table_header *table, unsigned int cpu, const
 
 	return -1;
 }
+
+/*
+ * During early boot, the caller should call acpi_get_table() and pass its pointer to
+ * these functions(and free up later). At run time, since this table can be used
+ * multiple times, pass NULL so that the table remains in memory
+ */
+int acpi_get_cbo_block_size(struct acpi_table_header *table, unsigned int cpu,
+			    u32 *cbom_size, u32 *cboz_size, u32 *cbop_size)
+{
+	struct acpi_rhct_node_header *node, *ref_node, *end;
+	u32 size_hdr = sizeof(struct acpi_rhct_node_header);
+	u32 size_hartinfo = sizeof(struct acpi_rhct_hart_info);
+	struct acpi_rhct_hart_info *hart_info;
+	struct acpi_rhct_cmo_node *cmo_node;
+	struct acpi_table_rhct *rhct;
+	u32 *hart_info_node_offset;
+	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+
+	BUG_ON(acpi_disabled);
+
+	if (table) {
+		rhct = (struct acpi_table_rhct *)table;
+	} else {
+		rhct = (struct acpi_table_rhct *)acpi_get_rhct();
+		if (!rhct)
+			return -ENOENT;
+	}
+
+	end = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->header.length);
+	for (node = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->node_offset);
+	     node < end;
+	     node = ACPI_ADD_PTR(struct acpi_rhct_node_header, node, node->length)) {
+		if (node->type == ACPI_RHCT_NODE_TYPE_HART_INFO) {
+			hart_info = ACPI_ADD_PTR(struct acpi_rhct_hart_info, node, size_hdr);
+			hart_info_node_offset = ACPI_ADD_PTR(u32, hart_info, size_hartinfo);
+			if (acpi_cpu_id != hart_info->uid)
+				continue;
+
+			for (int i = 0; i < hart_info->num_offsets; i++) {
+				ref_node = ACPI_ADD_PTR(struct acpi_rhct_node_header,
+							rhct, hart_info_node_offset[i]);
+				if (ref_node->type == ACPI_RHCT_NODE_TYPE_CMO) {
+					cmo_node = ACPI_ADD_PTR(struct acpi_rhct_cmo_node,
+								ref_node, size_hdr);
+					if (cbom_size && cmo_node->cbom_size <= 30)
+						*cbom_size = BIT(cmo_node->cbom_size);
+
+					if (cboz_size && cmo_node->cboz_size <= 30)
+						*cboz_size = BIT(cmo_node->cboz_size);
+
+					if (cbop_size && cmo_node->cbop_size <= 30)
+						*cbop_size = BIT(cmo_node->cbop_size);
+
+					return 0;
+				}
+			}
+		}
+	}
+
+	if (cbom_size)
+		*cbom_size = 0;
+
+	if (cboz_size)
+		*cboz_size = 0;
+
+	if (cbop_size)
+		*cbop_size = 0;
+
+	return -ENOENT;
+}
-- 
2.39.2

