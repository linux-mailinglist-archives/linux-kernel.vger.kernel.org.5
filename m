Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA49D75F24E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjGXKMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjGXKLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:11:46 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8D959F3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 03:04:27 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666e916b880so2302060b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 03:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1690193032; x=1690797832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UUcCkSTwYLiD/t1kcQ5bDbSt1mwTfBpcBGNsDxfuBOA=;
        b=CNwx/jLmX1kzvaYEGA/thpQvQrezMQ734fYSg9UAAm6yofFqIEpkSVs/+WHZxynyl2
         Vk5PFfX0aoJHpDT1WSh2FCbYNS80FR1zvpg9Hg6ZufKE2ymwsc4/zCvYErKQsLCNn7Ug
         jAT8y4mbv+syB/ElAFiNUUiItdQdWpKw++rdUy7g6l/G5og8eJf5/OoNKyRUl126Rz3b
         Y90AEXS9SwLiC/i5KoxCrCwfEN0/+GBzo5QUtk+bYLFUDshvh4GM6Q1zeoAd/jUNnSrB
         uSzkC6GecKY8I09698ymosvxd53FxBz0BKxSNBmLzMk9pbEPCaf5Pb/ZJASRb40Lbkx6
         A0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690193032; x=1690797832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UUcCkSTwYLiD/t1kcQ5bDbSt1mwTfBpcBGNsDxfuBOA=;
        b=kKoAndRUm4ELbulE6i/63k1jdrsG/e4W7hLpiwh3yHmQ8CtDpM42T5tYyFEFWBKKcb
         +Q1zAivmEYFzKL9Rzme5+94x17kiH4snJTob19fMjAPOaga+FMiqoF43iTcQuFxySI06
         ZlO0Ypt5OM87d8oUrBAFtFS7xMfylCz91qo8WqgII2gqkQvu9D+w0rFGgHpwagB72qkv
         cDx3CrrpG2Yosj8sVbKrqJSQVaMOEAvR/tOyBCs6KFB0HZufPLVRbXyvHYBjRChuxGL1
         XqKz7vf/iJpZstTEkwcqG6fWmupf/9S8F5kqexDfClHR6eh2d/QbbRcHRHQl8+SfP8yz
         9rEg==
X-Gm-Message-State: ABy/qLYnCcGASmr89t4VpcvWT8/2cQindnofaWiwaWDWV7bsh2xcKqT/
        OHJyIWylv+r7isJBWvFZzhz1pQ==
X-Google-Smtp-Source: APBJJlF43UAKvGrY1ke4RxpEUoaG1cuBNgNQ+LQfclku2hQlPUblZkiVF3u8/jv+OZzAmqZsogTuIg==
X-Received: by 2002:a05:6a20:a11b:b0:134:d8e6:2717 with SMTP id q27-20020a056a20a11b00b00134d8e62717mr8724991pzk.47.1690193032051;
        Mon, 24 Jul 2023 03:03:52 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.25])
        by smtp.gmail.com with ESMTPSA id l12-20020a62be0c000000b0067459e92801sm7344789pff.64.2023.07.24.03.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 03:03:51 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3 -fixes] RISC-V: ACPI: Fix acpi_os_ioremap to return iomem address
Date:   Mon, 24 Jul 2023 15:33:46 +0530
Message-Id: <20230724100346.1302937-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

acpi_os_ioremap() currently is a wrapper to memremap() on
RISC-V. But the callers of acpi_os_ioremap() expect it to
return __iomem address and hence sparse tool reports a new
warning. Fix this issue by type casting to  __iomem type.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307230357.egcTAefj-lkp@intel.com/
Fixes: a91a9ffbd3a5 ("RISC-V: Add support to build the ACPI core")
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
Changes since v2:
	1) Removed unnecessary __force.
	2) Removed unnecessary space after cast to fix checkpatch --strict warning.

Changes since v1:
	1) Removed enhancements from the fix patch.

 arch/riscv/include/asm/acpi.h | 2 +-
 arch/riscv/kernel/acpi.c      | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index f71ce21ff684..d5604d2073bc 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -19,7 +19,7 @@ typedef u64 phys_cpuid_t;
 #define PHYS_CPUID_INVALID INVALID_HARTID
 
 /* ACPI table mapping after acpi_permanent_mmap is set */
-void *acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
+void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
 #define acpi_os_ioremap acpi_os_ioremap
 
 #define acpi_strict 1	/* No out-of-spec workarounds on RISC-V */
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index 5ee03ebab80e..56cb2c986c48 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -215,9 +215,9 @@ void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
 	early_iounmap(map, size);
 }
 
-void *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
+void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
 {
-	return memremap(phys, size, MEMREMAP_WB);
+	return (void __iomem *)memremap(phys, size, MEMREMAP_WB);
 }
 
 #ifdef CONFIG_PCI
-- 
2.39.2

