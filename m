Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05FE7D278D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 02:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbjJWAqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 20:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJWAqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 20:46:03 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CE7E9;
        Sun, 22 Oct 2023 17:45:58 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 39N0iJja078965;
        Mon, 23 Oct 2023 08:44:19 +0800 (+08)
        (envelope-from peterlin@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Mon, 23 Oct 2023
 08:44:15 +0800
From:   Yu Chien Peter Lin <peterlin@andestech.com>
To:     <acme@kernel.org>, <adrian.hunter@intel.com>,
        <ajones@ventanamicro.com>, <alexander.shishkin@linux.intel.com>,
        <andre.przywara@arm.com>, <anup@brainfault.org>,
        <aou@eecs.berkeley.edu>, <atishp@atishpatra.org>,
        <conor+dt@kernel.org>, <conor.dooley@microchip.com>,
        <conor@kernel.org>, <devicetree@vger.kernel.org>,
        <dminus@andestech.com>, <evan@rivosinc.com>,
        <geert+renesas@glider.be>, <guoren@kernel.org>, <heiko@sntech.de>,
        <irogers@google.com>, <jernej.skrabec@gmail.com>,
        <jolsa@kernel.org>, <jszhang@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
        <locus84@andestech.com>, <magnus.damm@gmail.com>,
        <mark.rutland@arm.com>, <mingo@redhat.com>, <n.shubin@yadro.com>,
        <namhyung@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <peterlin@andestech.com>,
        <peterz@infradead.org>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <rdunlap@infradead.org>, <robh+dt@kernel.org>,
        <samuel@sholland.org>, <sunilvl@ventanamicro.com>,
        <tglx@linutronix.de>, <tim609@andestech.com>, <uwu@icenowy.me>,
        <wens@csie.org>, <will@kernel.org>, <ycliang@andestech.com>
Subject: [PATCH v3 RESEND 01/13] riscv: errata: Rename defines for Andes
Date:   Mon, 23 Oct 2023 08:40:48 +0800
Message-ID: <20231023004100.2663486-2-peterlin@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023004100.2663486-1-peterlin@andestech.com>
References: <20231023004100.2663486-1-peterlin@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 39N0iJja078965
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using "ANDES" rather than "ANDESTECH" to unify the naming
convention with directory, file names, Kconfig options
and other definitions.

Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
Reviewed-by: Charles Ci-Jyun Wu <dminus@andestech.com>
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
Changes v1 -> v2:
  - No change
Changes v2 -> v3:
  - Rewrote commit message (suggested by Conor)
---
 arch/riscv/errata/andes/errata.c       | 10 +++++-----
 arch/riscv/include/asm/errata_list.h   |  4 ++--
 arch/riscv/include/asm/vendorid_list.h |  2 +-
 arch/riscv/kernel/alternative.c        |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/errata/andes/errata.c b/arch/riscv/errata/andes/errata.c
index 197db68cc8da..d2e1abcac967 100644
--- a/arch/riscv/errata/andes/errata.c
+++ b/arch/riscv/errata/andes/errata.c
@@ -18,9 +18,9 @@
 #include <asm/sbi.h>
 #include <asm/vendorid_list.h>
 
-#define ANDESTECH_AX45MP_MARCHID	0x8000000000008a45UL
-#define ANDESTECH_AX45MP_MIMPID		0x500UL
-#define ANDESTECH_SBI_EXT_ANDES		0x0900031E
+#define ANDES_AX45MP_MARCHID		0x8000000000008a45UL
+#define ANDES_AX45MP_MIMPID		0x500UL
+#define ANDES_SBI_EXT_ANDES		0x0900031E
 
 #define ANDES_SBI_EXT_IOCP_SW_WORKAROUND	1
 
@@ -32,7 +32,7 @@ static long ax45mp_iocp_sw_workaround(void)
 	 * ANDES_SBI_EXT_IOCP_SW_WORKAROUND SBI EXT checks if the IOCP is missing and
 	 * cache is controllable only then CMO will be applied to the platform.
 	 */
-	ret = sbi_ecall(ANDESTECH_SBI_EXT_ANDES, ANDES_SBI_EXT_IOCP_SW_WORKAROUND,
+	ret = sbi_ecall(ANDES_SBI_EXT_ANDES, ANDES_SBI_EXT_IOCP_SW_WORKAROUND,
 			0, 0, 0, 0, 0, 0);
 
 	return ret.error ? 0 : ret.value;
@@ -43,7 +43,7 @@ static bool errata_probe_iocp(unsigned int stage, unsigned long arch_id, unsigne
 	if (!IS_ENABLED(CONFIG_ERRATA_ANDES_CMO))
 		return false;
 
-	if (arch_id != ANDESTECH_AX45MP_MARCHID || impid != ANDESTECH_AX45MP_MIMPID)
+	if (arch_id != ANDES_AX45MP_MARCHID || impid != ANDES_AX45MP_MIMPID)
 		return false;
 
 	if (!ax45mp_iocp_sw_workaround())
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index b55b434f0059..c190393aa9db 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -12,8 +12,8 @@
 #include <asm/vendorid_list.h>
 
 #ifdef CONFIG_ERRATA_ANDES
-#define ERRATA_ANDESTECH_NO_IOCP	0
-#define ERRATA_ANDESTECH_NUMBER		1
+#define ERRATA_ANDES_NO_IOCP 0
+#define ERRATA_ANDES_NUMBER 1
 #endif
 
 #ifdef CONFIG_ERRATA_SIFIVE
diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
index e55407ace0c3..2f2bb0c84f9a 100644
--- a/arch/riscv/include/asm/vendorid_list.h
+++ b/arch/riscv/include/asm/vendorid_list.h
@@ -5,7 +5,7 @@
 #ifndef ASM_VENDOR_LIST_H
 #define ASM_VENDOR_LIST_H
 
-#define ANDESTECH_VENDOR_ID	0x31e
+#define ANDES_VENDOR_ID		0x31e
 #define SIFIVE_VENDOR_ID	0x489
 #define THEAD_VENDOR_ID		0x5b7
 
diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
index 319a1da0358b..0128b161bfda 100644
--- a/arch/riscv/kernel/alternative.c
+++ b/arch/riscv/kernel/alternative.c
@@ -43,7 +43,7 @@ static void riscv_fill_cpu_mfr_info(struct cpu_manufacturer_info_t *cpu_mfr_info
 
 	switch (cpu_mfr_info->vendor_id) {
 #ifdef CONFIG_ERRATA_ANDES
-	case ANDESTECH_VENDOR_ID:
+	case ANDES_VENDOR_ID:
 		cpu_mfr_info->patch_func = andes_errata_patch_func;
 		break;
 #endif
-- 
2.34.1

