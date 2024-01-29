Return-Path: <linux-kernel+bounces-42454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7296840188
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07FE11C2241E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D3957895;
	Mon, 29 Jan 2024 09:28:14 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AF155E59;
	Mon, 29 Jan 2024 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520493; cv=none; b=WdBz7AfaS3/9vnk6TpV60G3uxDR3BiVQKEu/iKEOU1yzKROGcgSSXPS0UyoPfBQfx+wwdvK7Av1S+xgtnsm1yhGknBpNeSMNrxZhIF9CoP/PmQY086YQn20ol3+2wXAIxWuWruxkNFv7gP6ypLEaF0d/X6tEAiRiq+mHhRShqTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520493; c=relaxed/simple;
	bh=6Mc0SeGf1uZMwqDNkaaoHSarKeUY3QFjvEIoiiORKoQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YGmA12OaPzdjsqU7RXfeihsCuuF6iyn8KMDt8mI4DfTTHFMYQeFtsjlVD4PrfaUn+Zm0Es04xQf89yxsZYIuIqNzEbzJR6HOF39p2fM5nN/W3AXQBF2N7SW+6aRIceSZNHQ4if66otBfyI+FcqJmqetADLf+vYnj+JXbYiK1n5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
	by Atcsqr.andestech.com with ESMTP id 40T9QZcP080231;
	Mon, 29 Jan 2024 17:26:35 +0800 (+08)
	(envelope-from peterlin@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Mon, 29 Jan 2024
 17:26:31 +0800
From: Yu Chien Peter Lin <peterlin@andestech.com>
To: <acme@kernel.org>, <adrian.hunter@intel.com>, <ajones@ventanamicro.com>,
        <alexander.shishkin@linux.intel.com>, <andre.przywara@arm.com>,
        <anup@brainfault.org>, <aou@eecs.berkeley.edu>,
        <atishp@atishpatra.org>, <conor+dt@kernel.org>,
        <conor.dooley@microchip.com>, <conor@kernel.org>,
        <devicetree@vger.kernel.org>, <evan@rivosinc.com>,
        <geert+renesas@glider.be>, <guoren@kernel.org>, <heiko@sntech.de>,
        <irogers@google.com>, <jernej.skrabec@gmail.com>, <jolsa@kernel.org>,
        <jszhang@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <locus84@andestech.com>,
        <magnus.damm@gmail.com>, <mark.rutland@arm.com>, <mingo@redhat.com>,
        <n.shubin@yadro.com>, <namhyung@kernel.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <peterlin@andestech.com>,
        <peterz@infradead.org>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <rdunlap@infradead.org>, <robh+dt@kernel.org>, <samuel@sholland.org>,
        <sunilvl@ventanamicro.com>, <tglx@linutronix.de>,
        <tim609@andestech.com>, <uwu@icenowy.me>, <wens@csie.org>,
        <will@kernel.org>, <inochiama@outlook.com>, <unicorn_wang@outlook.com>,
        <wefu@redhat.com>
CC: Charles Ci-Jyun Wu <dminus@andestech.com>,
        Leo Yu-Chi Liang
	<ycliang@andestech.com>
Subject: [PATCH v8 07/10] perf: RISC-V: Introduce Andes PMU to support perf event sampling
Date: Mon, 29 Jan 2024 17:25:50 +0800
Message-ID: <20240129092553.2058043-8-peterlin@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129092553.2058043-1-peterlin@andestech.com>
References: <20240129092553.2058043-1-peterlin@andestech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 40T9QZcP080231

Assign riscv_pmu_irq_num the value of (256 + 18) for the custome PMU
and add SSCOUNTOVF and SIP alternatives to ALT_SBI_PMU_OVERFLOW()
and ALT_SBI_PMU_OVF_CLEAR_PENDING() macros, respectively.

To make use of Andes PMU extension, "xandespmu" needs to be appended
to the riscv,isa-extensions for each cpu node in device-tree, and
make sure CONFIG_ANDES_CUSTOM_PMU is enabled.

Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
Reviewed-by: Charles Ci-Jyun Wu <dminus@andestech.com>
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
Co-developed-by: Locus Wei-Han Chen <locus84@andestech.com>
Signed-off-by: Locus Wei-Han Chen <locus84@andestech.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Changes v1 -> v2:
  - New patch
Changes v2 -> v3:
  - Reordered list in riscv_isa_ext[]
  - Removed mvendorid check in pmu_sbi_setup_irqs()
Changes v3 -> v4:
  - No change
Changes v4 -> v5:
  - Let ANDES_CUSTOM_PMU depend on ARCH_RENESAS
  - Include Prabhakar's Reviewed/Tested-by
Changes v5 -> v6:
  - No change
Changes v6 -> v7:
  - No change
Changes v7 -> v8:
  - No change
---
 arch/riscv/include/asm/errata_list.h |  9 -------
 arch/riscv/include/asm/hwcap.h       |  1 +
 arch/riscv/kernel/cpufeature.c       |  1 +
 drivers/perf/Kconfig                 | 14 +++++++++++
 drivers/perf/riscv_pmu_sbi.c         | 35 +++++++++++++++++++++++++---
 5 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index 96025eec5631..1f2dbfb8a8bf 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -112,15 +112,6 @@ asm volatile(ALTERNATIVE(						\
 #define THEAD_C9XX_RV_IRQ_PMU			17
 #define THEAD_C9XX_CSR_SCOUNTEROF		0x5c5
 
-#define ALT_SBI_PMU_OVERFLOW(__ovl)					\
-asm volatile(ALTERNATIVE(						\
-	"csrr %0, " __stringify(CSR_SSCOUNTOVF),			\
-	"csrr %0, " __stringify(THEAD_C9XX_CSR_SCOUNTEROF),		\
-		THEAD_VENDOR_ID, ERRATA_THEAD_PMU,			\
-		CONFIG_ERRATA_THEAD_PMU)				\
-	: "=r" (__ovl) :						\
-	: "memory")
-
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 5340f818746b..bae7eac76c18 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -80,6 +80,7 @@
 #define RISCV_ISA_EXT_ZFA		71
 #define RISCV_ISA_EXT_ZTSO		72
 #define RISCV_ISA_EXT_ZACAS		73
+#define RISCV_ISA_EXT_XANDESPMU		74
 
 #define RISCV_ISA_EXT_MAX		128
 #define RISCV_ISA_EXT_INVALID		U32_MAX
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 89920f84d0a3..0c7688fa8376 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -307,6 +307,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
+	__RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_EXT_XANDESPMU),
 };
 
 const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index ec6e0d9194a1..564e813d8c69 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -86,6 +86,20 @@ config RISCV_PMU_SBI
 	  full perf feature support i.e. counter overflow, privilege mode
 	  filtering, counter configuration.
 
+config ANDES_CUSTOM_PMU
+	bool "Andes custom PMU support"
+	depends on ARCH_RENESAS && RISCV_ALTERNATIVE && RISCV_PMU_SBI
+	default y
+	help
+	  The Andes cores implement the PMU overflow extension very
+	  similar to the standard Sscofpmf and Smcntrpmf extension.
+
+	  This will patch the overflow and pending CSRs and handle the
+	  non-standard behaviour via the regular SBI PMU driver and
+	  interface.
+
+	  If you don't know what to do here, say "Y".
+
 config ARM_PMU_ACPI
 	depends on ARM_PMU && ACPI
 	def_bool y
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 2edbc37abadf..bbd6fe021b3a 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -19,11 +19,33 @@
 #include <linux/of.h>
 #include <linux/cpu_pm.h>
 #include <linux/sched/clock.h>
+#include <linux/soc/andes/irq.h>
 
 #include <asm/errata_list.h>
 #include <asm/sbi.h>
 #include <asm/cpufeature.h>
 
+#define ALT_SBI_PMU_OVERFLOW(__ovl)					\
+asm volatile(ALTERNATIVE_2(						\
+	"csrr %0, " __stringify(CSR_SSCOUNTOVF),			\
+	"csrr %0, " __stringify(THEAD_C9XX_CSR_SCOUNTEROF),		\
+		THEAD_VENDOR_ID, ERRATA_THEAD_PMU,			\
+		CONFIG_ERRATA_THEAD_PMU,				\
+	"csrr %0, " __stringify(ANDES_CSR_SCOUNTEROF),			\
+		0, RISCV_ISA_EXT_XANDESPMU,				\
+		CONFIG_ANDES_CUSTOM_PMU)				\
+	: "=r" (__ovl) :						\
+	: "memory")
+
+#define ALT_SBI_PMU_OVF_CLEAR_PENDING(__irq_mask)			\
+asm volatile(ALTERNATIVE(						\
+	"csrc " __stringify(CSR_IP) ", %0\n\t",				\
+	"csrc " __stringify(ANDES_CSR_SLIP) ", %0\n\t",			\
+		0, RISCV_ISA_EXT_XANDESPMU,				\
+		CONFIG_ANDES_CUSTOM_PMU)				\
+	: : "r"(__irq_mask)						\
+	: "memory")
+
 #define SYSCTL_NO_USER_ACCESS	0
 #define SYSCTL_USER_ACCESS	1
 #define SYSCTL_LEGACY		2
@@ -61,6 +83,7 @@ static int sysctl_perf_user_access __read_mostly = SYSCTL_USER_ACCESS;
 static union sbi_pmu_ctr_info *pmu_ctr_list;
 static bool riscv_pmu_use_irq;
 static unsigned int riscv_pmu_irq_num;
+static unsigned int riscv_pmu_irq_mask;
 static unsigned int riscv_pmu_irq;
 
 /* Cache the available counters in a bitmask */
@@ -694,7 +717,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 
 	event = cpu_hw_evt->events[fidx];
 	if (!event) {
-		csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
+		ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
 		return IRQ_NONE;
 	}
 
@@ -708,7 +731,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 	 * Overflow interrupt pending bit should only be cleared after stopping
 	 * all the counters to avoid any race condition.
 	 */
-	csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
+	ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
 
 	/* No overflow bit is set */
 	if (!overflow)
@@ -780,7 +803,7 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
 
 	if (riscv_pmu_use_irq) {
 		cpu_hw_evt->irq = riscv_pmu_irq;
-		csr_clear(CSR_IP, BIT(riscv_pmu_irq_num));
+		ALT_SBI_PMU_OVF_CLEAR_PENDING(riscv_pmu_irq_mask);
 		enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
 	}
 
@@ -814,8 +837,14 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
 		   riscv_cached_mimpid(0) == 0) {
 		riscv_pmu_irq_num = THEAD_C9XX_RV_IRQ_PMU;
 		riscv_pmu_use_irq = true;
+	} else if (riscv_isa_extension_available(NULL, XANDESPMU) &&
+		   IS_ENABLED(CONFIG_ANDES_CUSTOM_PMU)) {
+		riscv_pmu_irq_num = ANDES_SLI_CAUSE_BASE + ANDES_RV_IRQ_PMOVI;
+		riscv_pmu_use_irq = true;
 	}
 
+	riscv_pmu_irq_mask = BIT(riscv_pmu_irq_num % BITS_PER_LONG);
+
 	if (!riscv_pmu_use_irq)
 		return -EOPNOTSUPP;
 
-- 
2.34.1


