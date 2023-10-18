Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B73A7CDC0A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjJRMkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjJRMk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:40:28 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1695A118
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:40:26 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-57bc2c2f13dso3830677eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697632825; x=1698237625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTW8kyBICRbc9yF0k81A432uuMoCKuaw9w1HIRoraUU=;
        b=NTfKEvAJWgSqK7pj+57ku/n0+pT0mfNrcosiW+x4RGyTbK1mrxyrcGxF5wRULIjJaN
         rDqTKyplPU+CtK8RL3d1G4YXrGeVb3e1EnKK8J483vhW/8YFvbaPyyWFi5psGzINz7fX
         +OSC2nEHQ9/zn8TJOqmcBgyeEyGPcCJ0aSXJEVafSf/B4N6deIcq+LdOPncGFl0FiN+/
         1dSBr0PcSHQj4mBGYQwRJ5ntSfFQHFNydVzwAitricAWNaWMzYVIaWPxFKpnhrrvX6ao
         31EaOyOfOOcmeLqv00PA8AcZN7Myx7MmrZtPx0X7w6zhENrz+Eu33ALX7u52+4hSf4+c
         8RGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697632825; x=1698237625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTW8kyBICRbc9yF0k81A432uuMoCKuaw9w1HIRoraUU=;
        b=hnJnldD8cG4Xlq0Q0uCShKiJT1LXIbPZmeXGE06FYHg76KmQT/lBlQWX6z6+sPjhB7
         jzYmYLQFfeUOq5RRmuZ0WUDFkwpfIi9LgFInXY417fxTjBps0WB3P/s6thBfjVlCFAzq
         QJSvq0mvAFZNkSQxRJ/NiaPjaR4Da9fwfMSXDnDd2+EWAWLLhWRmU6FMWjQtYBmwL4A+
         JYZeeZqvGSIoz4fjx6Kju+YEh639HrVqlPbhrJDvz+en39WpyE+w8SVIbFxfKPA5+Dfv
         2POelURZSDFvLMl0bEyT5AvCsePbUozr0K5IU++BT+PIOFNqykQlgU3l81a+3S9EE3y8
         cdDA==
X-Gm-Message-State: AOJu0YzcYuOrxqTnAVAGUMXlqS5Ss3Od2xoBb90CPv4qyl/ma6wtKhQY
        NwEMMEa00x9gNwcthHmhOdjYFw==
X-Google-Smtp-Source: AGHT+IE+m2EHBJN9d3qCsG5KnmCBnxr+6J1AHtmLSj7QaF3/j+hOqrsvoHsCY29ami4VGt/j4ba8eg==
X-Received: by 2002:a05:6358:c608:b0:143:96e0:5bef with SMTP id fd8-20020a056358c60800b0014396e05befmr4870648rwb.4.1697632825171;
        Wed, 18 Oct 2023 05:40:25 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id w190-20020a6382c7000000b005891f3af36asm1599267pgd.87.2023.10.18.05.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 05:40:24 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v4 -next 3/4] RISC-V: ACPI: RHCT: Add function to get CBO block sizes
Date:   Wed, 18 Oct 2023 18:10:06 +0530
Message-Id: <20231018124007.1306159-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231018124007.1306159-1-sunilvl@ventanamicro.com>
References: <20231018124007.1306159-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cache Block Operation (CBO) related block size in ACPI is provided by RHCT.
Add support to read the CMO node in RHCT to get this information.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/acpi.h |  6 +++
 drivers/acpi/riscv/rhct.c     | 87 +++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index d5604d2073bc..7dad0cf9d701 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -66,6 +66,8 @@ int acpi_get_riscv_isa(struct acpi_table_header *table,
 		       unsigned int cpu, const char **isa);
 
 static inline int acpi_numa_get_nid(unsigned int cpu) { return NUMA_NO_NODE; }
+void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_size,
+			     u32 *cboz_size, u32 *cbop_size);
 #else
 static inline void acpi_init_rintc_map(void) { }
 static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
@@ -79,6 +81,10 @@ static inline int acpi_get_riscv_isa(struct acpi_table_header *table,
 	return -EINVAL;
 }
 
+static inline void acpi_get_cbo_block_size(struct acpi_table_header *table,
+					   u32 *cbom_size, u32 *cboz_size,
+					   u32 *cbop_size) { }
+
 #endif /* CONFIG_ACPI */
 
 #endif /*_ASM_ACPI_H*/
diff --git a/drivers/acpi/riscv/rhct.c b/drivers/acpi/riscv/rhct.c
index 489b0e93b1e5..caa2c16e1697 100644
--- a/drivers/acpi/riscv/rhct.c
+++ b/drivers/acpi/riscv/rhct.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt)     "ACPI: RHCT: " fmt
 
 #include <linux/acpi.h>
+#include <linux/bits.h>
 
 static struct acpi_table_rhct *acpi_get_rhct(void)
 {
@@ -81,3 +82,89 @@ int acpi_get_riscv_isa(struct acpi_table_header *table, unsigned int cpu, const
 
 	return -1;
 }
+
+static void acpi_parse_hart_info_cmo_node(struct acpi_table_rhct *rhct,
+					  struct acpi_rhct_hart_info *hart_info,
+					  u32 *cbom_size, u32 *cboz_size, u32 *cbop_size)
+{
+	u32 size_hartinfo = sizeof(struct acpi_rhct_hart_info);
+	u32 size_hdr = sizeof(struct acpi_rhct_node_header);
+	struct acpi_rhct_node_header *ref_node;
+	struct acpi_rhct_cmo_node *cmo_node;
+	u32 *hart_info_node_offset;
+
+	hart_info_node_offset = ACPI_ADD_PTR(u32, hart_info, size_hartinfo);
+	for (int i = 0; i < hart_info->num_offsets; i++) {
+		ref_node = ACPI_ADD_PTR(struct acpi_rhct_node_header,
+					rhct, hart_info_node_offset[i]);
+		if (ref_node->type == ACPI_RHCT_NODE_TYPE_CMO) {
+			cmo_node = ACPI_ADD_PTR(struct acpi_rhct_cmo_node,
+						ref_node, size_hdr);
+			if (cbom_size && cmo_node->cbom_size <= 30) {
+				if (!*cbom_size)
+					*cbom_size = BIT(cmo_node->cbom_size);
+				else if (*cbom_size != BIT(cmo_node->cbom_size))
+					pr_warn("CBOM size is not the same across harts\n");
+			}
+
+			if (cboz_size && cmo_node->cboz_size <= 30) {
+				if (!*cboz_size)
+					*cboz_size = BIT(cmo_node->cboz_size);
+				else if (*cboz_size != BIT(cmo_node->cboz_size))
+					pr_warn("CBOZ size is not the same across harts\n");
+			}
+
+			if (cbop_size && cmo_node->cbop_size <= 30) {
+				if (!*cbop_size)
+					*cbop_size = BIT(cmo_node->cbop_size);
+				else if (*cbop_size != BIT(cmo_node->cbop_size))
+					pr_warn("CBOP size is not the same across harts\n");
+			}
+		}
+	}
+}
+
+/*
+ * During early boot, the caller should call acpi_get_table() and pass its pointer to
+ * these functions (and free up later). At run time, since this table can be used
+ * multiple times, pass NULL so that the table remains in memory.
+ */
+void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_size,
+			     u32 *cboz_size, u32 *cbop_size)
+{
+	u32 size_hdr = sizeof(struct acpi_rhct_node_header);
+	struct acpi_rhct_node_header *node, *end;
+	struct acpi_rhct_hart_info *hart_info;
+	struct acpi_table_rhct *rhct;
+
+	if (acpi_disabled)
+		return;
+
+	if (table) {
+		rhct = (struct acpi_table_rhct *)table;
+	} else {
+		rhct = acpi_get_rhct();
+		if (!rhct)
+			return;
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
+	end = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->header.length);
+	for (node = ACPI_ADD_PTR(struct acpi_rhct_node_header, rhct, rhct->node_offset);
+	     node < end;
+	     node = ACPI_ADD_PTR(struct acpi_rhct_node_header, node, node->length)) {
+		if (node->type == ACPI_RHCT_NODE_TYPE_HART_INFO) {
+			hart_info = ACPI_ADD_PTR(struct acpi_rhct_hart_info, node, size_hdr);
+			acpi_parse_hart_info_cmo_node(rhct, hart_info, cbom_size,
+						      cboz_size, cbop_size);
+		}
+	}
+}
-- 
2.39.2

