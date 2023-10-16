Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3538C7CB13C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 19:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbjJPRVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 13:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233945AbjJPRU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 13:20:56 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A20330DE
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 09:50:11 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b3c2607d9bso2337533b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 09:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1697475011; x=1698079811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGpfWXp12h96iIrhrZ9w/4qboCYb79h5kFDLjoFea9A=;
        b=TQEbZR5I3mwF8aFca89GAt1KoFSJF53udj3ReynViMjvp2q8ufWOGy0GN7Cic0tmkN
         FkqN1ONwbQuJLdOG0eTtttNh7I1WCiLRDHqUm31nqK12LOxH0mMwkOJIJUJulouAmgRE
         9xDhUu0y5t5fkL9Ig6wqMVRktaPZUgu0F30UFAbgEHCRByEg/1Oc0oro+Vc7h5RkEuqi
         UD44Hp4YOyYgjbnHxB3CcH2ZkgiI2PzcGXitKOhBhfpuefPB2Rd/TakKdbXl9YV/qw41
         Du5xujCVEwQROZfyOy0x5UOo0uY8JuUAbwonigxsONkPeBWiCbpEHseJcP4qUpFyvU4J
         TRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697475011; x=1698079811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGpfWXp12h96iIrhrZ9w/4qboCYb79h5kFDLjoFea9A=;
        b=Y1mDqkfxIf+q+Ay5fKlqcAuEB4897JEr5uyk0Bwi/i2FSeJeJvHqr+eE1JajMdPwRr
         wvW+VV3Sr1nlvLLG0hC4LTX4xLXMWEZMxTsqUw6D9vasXyoPn/V5/LfH1XR5uyMAHanb
         8jczifmxIEaR6U3Di9sAWgL7kQeSrbiOd/c6woiA7c4zIiTP0pGs3cF/FRtDQDQBNVeB
         BWb+ffhVJnHRiAbAWujuMn3vxp+Xp2uUR32dTX0hyhRKNSIp115nBzp8eGDPwz15XLzw
         iMyLrDUMW/grp5Wg+ekr705EetAyhtm+MXLSxSBfqrReACnKY1dEAwYRxexXE7cLd6ue
         dL5g==
X-Gm-Message-State: AOJu0Yxi2mnrXhg3gfr8hCJkkDZxF7qAW5AFavbu62w930HiMeRthT9m
        17qF4DUH+PJWflDVcf0U6IJkog==
X-Google-Smtp-Source: AGHT+IGjQ2ofm9vq+rM9KYxzcQbOI6U0lRLO3PtlSK9ezYbqJA021qj0LVOx7aeW/7sHzfS/fqtlUw==
X-Received: by 2002:a05:6a00:1389:b0:6b2:6835:2a82 with SMTP id t9-20020a056a00138900b006b268352a82mr9317417pfg.13.1697475010850;
        Mon, 16 Oct 2023 09:50:10 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id t21-20020a056a0021d500b006b1e8f17b85sm111252pfj.201.2023.10.16.09.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:50:10 -0700 (PDT)
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
        Ard Biesheuvel <ardb@kernel.org>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 -next 1/3] RISC-V: ACPI: Enhance acpi_os_ioremap with MMIO remapping
Date:   Mon, 16 Oct 2023 22:19:56 +0530
Message-Id: <20231016164958.1191529-2-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016164958.1191529-1-sunilvl@ventanamicro.com>
References: <20231016164958.1191529-1-sunilvl@ventanamicro.com>
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

Enhance the acpi_os_ioremap() to support opregions in MMIO space. Also,
have strict checks using EFI memory map to allow remapping the RAM similar
to arm64.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/Kconfig       |  1 +
 arch/riscv/kernel/acpi.c | 87 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d607ab0f7c6d..805c8ab7f23b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -39,6 +39,7 @@ config RISCV
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_HAS_VDSO_DATA
+	select ARCH_KEEP_MEMBLOCK if ACPI
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
 	select ARCH_STACKWALK
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index 56cb2c986c48..e619edc8b0cc 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -14,9 +14,10 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/efi.h>
 #include <linux/io.h>
+#include <linux/memblock.h>
 #include <linux/pci.h>
-#include <linux/efi.h>
 
 int acpi_noirq = 1;		/* skip ACPI IRQ initialization */
 int acpi_disabled = 1;
@@ -217,7 +218,89 @@ void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
 
 void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
 {
-	return (void __iomem *)memremap(phys, size, MEMREMAP_WB);
+	efi_memory_desc_t *md, *region = NULL;
+	pgprot_t prot;
+
+	if (WARN_ON_ONCE(!efi_enabled(EFI_MEMMAP)))
+		return NULL;
+
+	for_each_efi_memory_desc(md) {
+		u64 end = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT);
+
+		if (phys < md->phys_addr || phys >= end)
+			continue;
+
+		if (phys + size > end) {
+			pr_warn(FW_BUG "requested region covers multiple EFI memory regions\n");
+			return NULL;
+		}
+		region = md;
+		break;
+	}
+
+	/*
+	 * It is fine for AML to remap regions that are not represented in the
+	 * EFI memory map at all, as it only describes normal memory, and MMIO
+	 * regions that require a virtual mapping to make them accessible to
+	 * the EFI runtime services.
+	 */
+	prot = PAGE_KERNEL_IO;
+	if (region) {
+		switch (region->type) {
+		case EFI_LOADER_CODE:
+		case EFI_LOADER_DATA:
+		case EFI_BOOT_SERVICES_CODE:
+		case EFI_BOOT_SERVICES_DATA:
+		case EFI_CONVENTIONAL_MEMORY:
+		case EFI_PERSISTENT_MEMORY:
+			if (memblock_is_map_memory(phys) ||
+			    !memblock_is_region_memory(phys, size)) {
+				pr_warn(FW_BUG "requested region covers kernel memory\n");
+				return NULL;
+			}
+
+			/*
+			 * Mapping kernel memory is permitted if the region in
+			 * question is covered by a single memblock with the
+			 * NOMAP attribute set: this enables the use of ACPI
+			 * table overrides passed via initramfs.
+			 * This particular use case only requires read access.
+			 */
+			fallthrough;
+
+		case EFI_RUNTIME_SERVICES_CODE:
+			/*
+			 * This would be unusual, but not problematic per se,
+			 * as long as we take care not to create a writable
+			 * mapping for executable code.
+			 */
+			prot = PAGE_KERNEL_RO;
+			break;
+
+		case EFI_ACPI_RECLAIM_MEMORY:
+			/*
+			 * ACPI reclaim memory is used to pass firmware tables
+			 * and other data that is intended for consumption by
+			 * the OS only, which may decide it wants to reclaim
+			 * that memory and use it for something else. We never
+			 * do that, but we usually add it to the linear map
+			 * anyway, in which case we should use the existing
+			 * mapping.
+			 */
+			if (memblock_is_map_memory(phys))
+				return (void __iomem *)__va(phys);
+			fallthrough;
+
+		default:
+			if (region->attribute & EFI_MEMORY_WB)
+				prot = PAGE_KERNEL;
+			else if ((region->attribute & EFI_MEMORY_WC) ||
+				 (region->attribute & EFI_MEMORY_WT))
+				prot = pgprot_writecombine(PAGE_KERNEL);
+		}
+	}
+
+	return ioremap_prot(phys, size, pgprot_val(prot));
 }
 
 #ifdef CONFIG_PCI
-- 
2.39.2

