Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F78D75E46E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 21:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjGWTSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 15:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGWTSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 15:18:16 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF711BC
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 12:18:16 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b89114266dso29709495ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 12:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1690139895; x=1690744695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pW/D68CVUATDRvkkjfDHL+y9HJPS05BTKqrSEexxpog=;
        b=S4mbzqkyBOsbsoQQ28NtKbuZQoLczx3V7rt47BuYtA6nNDw1b8k0dDBQq1WvMmftYu
         ZtHDIrrjgIKDFhVbESxIkTD5yG4KPUWjw1A5SINWXZlrkC5YJ+by0mXd8PPux7hkjMwZ
         P/KjGym1/AaFTLnf1m3f2NwOftCPWfENn0oeyrxzpr0xD4FjYhhKx6qunB6S6NnGe2Cy
         rlW13aUC+J0c27hbQO+3xXcvKXx4mSh4Az3Gg9BNNHw4BCgzkgW5Cg7ba93kfn/VM7NC
         Qv8/Kdr9XkXhrIXz76SCkuF3veGgb7SIo1UJm+A7Khx6+RIRWq8lCN0rdis/9XQ/TYKZ
         hm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690139895; x=1690744695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pW/D68CVUATDRvkkjfDHL+y9HJPS05BTKqrSEexxpog=;
        b=kc45Usn0BCL10F2l+m8ezWfXj9bJXRF0Y9GSmjHfG3WBGDgrLeP6TV5i3aidqi5gUm
         gEtmsoMdMEUVQUo4on5YiAmFH+I9usQdDVHZIU8YjCHMwxdLM2TOx5Qu/yuPH0D17Vsv
         q4VdzjgwGJWwUuffBSQisMnp4myqx4cojTskyEJSwl7mCNhgxxi0PyTDo/Bk1lRX0pD7
         TB1GGd6+pYhNsVmFMiCFP2733xEysqdXqPpU6xbT+fPz5QcBCEd96qXODzCfxgLkpJMD
         K3RSIswaxB+0SYVVjfvJ9UI6M9f140YP/Og8ikjvbHbpESj56BMDv8FwLpnHvgOuJiRl
         93Xg==
X-Gm-Message-State: ABy/qLYp7G+C+LchToYYaycX/RWmXYRyuPgIsgJoONhEJJFXp+pFeKv/
        pRHqxJ8bSJY/vSO4NOHromV1BT8f+6G7wuKwCl4=
X-Google-Smtp-Source: APBJJlH/dUeOgWFZp3VoB+w/4CrifL2iv7H2FX3MX6Ad+5talhr/ouM9nYEFlrcpqswE8mkPN38a6g==
X-Received: by 2002:a17:902:ec83:b0:1b8:b41e:66b4 with SMTP id x3-20020a170902ec8300b001b8b41e66b4mr10434855plg.67.1690139895538;
        Sun, 23 Jul 2023 12:18:15 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.25])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b001b9e86e05b7sm7235508plp.0.2023.07.23.12.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 12:18:15 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 -fixes] RISC-V: ACPI: Fix acpi_os_ioremap to return iomem address
Date:   Mon, 24 Jul 2023 00:47:58 +0530
Message-Id: <20230723191758.1262960-1-sunilvl@ventanamicro.com>
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
index 5ee03ebab80e..e6fdb9edcdd9 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -215,9 +215,9 @@ void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
 	early_iounmap(map, size);
 }
 
-void *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
+void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
 {
-	return memremap(phys, size, MEMREMAP_WB);
+	return (__force void __iomem *) memremap(phys, size, MEMREMAP_WB);
 }
 
 #ifdef CONFIG_PCI
-- 
2.39.2

