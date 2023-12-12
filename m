Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC2780E757
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346263AbjLLJUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346185AbjLLJUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:20:21 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27982EB;
        Tue, 12 Dec 2023 01:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702372828; x=1733908828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f3eiUKT+cKcrQtCN2MDItspu7jMjjWkhuuJpCpoi/JE=;
  b=n7z9RbHlWpmX++R9/nW5SMu7v+8qm4da5teoR+PR7e64kfu2uSMC1eRq
   BayggVD3GGnQeQJ3lWFU69Lsjxr5/+D0YQ39ZtaMhB1FB7e0rGmKYyNCS
   OOvIvi8l4RyRvBtrP4DoHD/dDXWRMiCDDoMrV7k0DVWVwvnsvFfezVAK9
   ldFQ2yDqtZIZx2Kv5WDUhEHpjaHhRtxkn00EKXpMW5KO97xwPC1odQbQe
   ObpMVJ7pgQN22o4btQRtpbOGsNR41JRKk14TZ5YQssu6R4iydjRL1kqgf
   3aQzUOToBOuWGbzMeG97IB2XL0TL5wcPc5dChpufzLEzTql94X0XRvT11
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="480974301"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="480974301"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 01:20:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="917213010"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="917213010"
Received: from haibo-optiplex-7090.sh.intel.com ([10.239.159.132])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 01:20:20 -0800
From:   Haibo Xu <haibo1.xu@intel.com>
Cc:     xiaobo55x@gmail.com, haibo1.xu@intel.com, ajones@ventanamicro.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Guo Ren <guoren@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Minda Chen <minda.chen@starfivetech.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Xu <peterx@redhat.com>, Like Xu <likexu@tencent.com>,
        Vipin Sharma <vipinsh@google.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Thomas Huth <thuth@redhat.com>,
        Aaron Lewis <aaronlewis@google.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvm-riscv@lists.infradead.org
Subject: [PATCH v4 05/11] tools: riscv: Add header file vdso/processor.h
Date:   Tue, 12 Dec 2023 17:31:14 +0800
Message-Id: <7b633cc441f5133608597463301fef122f5174d3.1702371136.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1702371136.git.haibo1.xu@intel.com>
References: <cover.1702371136.git.haibo1.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borrow the cpu_relax() definitions from kernel's
arch/riscv/include/asm/vdso/processor.h to tools/ for riscv.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
---
 tools/arch/riscv/include/asm/vdso/processor.h | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 tools/arch/riscv/include/asm/vdso/processor.h

diff --git a/tools/arch/riscv/include/asm/vdso/processor.h b/tools/arch/riscv/include/asm/vdso/processor.h
new file mode 100644
index 000000000000..662aca039848
--- /dev/null
+++ b/tools/arch/riscv/include/asm/vdso/processor.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_VDSO_PROCESSOR_H
+#define __ASM_VDSO_PROCESSOR_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm-generic/barrier.h>
+
+static inline void cpu_relax(void)
+{
+#ifdef __riscv_muldiv
+	int dummy;
+	/* In lieu of a halt instruction, induce a long-latency stall. */
+	__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
+#endif
+
+#ifdef CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE
+	/*
+	 * Reduce instruction retirement.
+	 * This assumes the PC changes.
+	 */
+	__asm__ __volatile__ ("pause");
+#else
+	/* Encoding of the pause instruction */
+	__asm__ __volatile__ (".4byte 0x100000F");
+#endif
+	barrier();
+}
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_PROCESSOR_H */
-- 
2.34.1

