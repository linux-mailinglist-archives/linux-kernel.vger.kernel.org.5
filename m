Return-Path: <linux-kernel+bounces-76126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C7285F33A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68F31F2300F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFF83716F;
	Thu, 22 Feb 2024 08:41:43 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995FA23747;
	Thu, 22 Feb 2024 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708591303; cv=none; b=TZDfhl14TaKj1z7qb/S7dgYkSWZoIaeJitC5ZEukkEn48VZMZ7ZUWLIgk3MqFfO+PMDa0Drlvi4cr/Kxm1L3kXefje6vXPPXJ41Gr3v9moTQ+8e9WWITQQy34/4qYfKOri+vOadrZzaICrCSuWod9WdEffFD1SlIV8yLDcPt4PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708591303; c=relaxed/simple;
	bh=sMXqZxiP9g8gdSynKiNBOM8kHpMxXvlXIdpGmQRqTkw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkIfHxboWy7YdjLcmUiu6mPZoI+Ao74ySLxLPDloF+kJGiNDNH2TNwy1LLfj7KBP3DhlCtFA8636ilu+LdqEjyMPWT7BTiHzMfE7bmxIj2bOhbmrNXiDrNIAOhNDQtBPy9V/AoPwfxdmi8H1rt+PHpDA1yA4hxp3EdVo3evun7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
	by Atcsqr.andestech.com with ESMTP id 41M8e38C074466;
	Thu, 22 Feb 2024 16:40:03 +0800 (+08)
	(envelope-from peterlin@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Thu, 22 Feb 2024
 16:39:59 +0800
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
CC: Randolph <randolph@andestech.com>, Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v9 02/10] irqchip/riscv-intc: Allow large non-standard interrupt number
Date: Thu, 22 Feb 2024 16:39:38 +0800
Message-ID: <20240222083946.3977135-3-peterlin@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222083946.3977135-1-peterlin@andestech.com>
References: <20240222083946.3977135-1-peterlin@andestech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 41M8e38C074466

Currently, the implementation of the RISC-V INTC driver uses the
interrupt cause as the hardware interrupt number, with a maximum of
64 interrupts. However, the platform can expand the interrupt number
further for custom local interrupts.

To fully utilize the available local interrupt sources, switch
to using irq_domain_create_tree() that creates the radix tree
map, add global variables (riscv_intc_nr_irqs, riscv_intc_custom_base
and riscv_intc_custom_nr_irqs) to determine the valid range of local
interrupt number (hwirq).

Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
Reviewed-by: Randolph <randolph@andestech.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
Changes v1 -> v2:
  - Fixed irq mapping failure checking (suggested by Clément and Anup)
Changes v2 -> v3:
  - No change
Changes v3 -> v4: (Suggested by Thomas [1])
  - Use pr_warn_ratelimited instead
  - Fix coding style and commit message
Changes v4 -> v5: (Suggested by Thomas)
  - Fix commit message
Changes v5 -> v6: (Suggested by Anup [2])
  - Add riscv_intc_* global variables for checking the range of valid
    interrupt number in riscv_intc_domain_alloc()
  - Advertise the number of interrupts allowed
Changes v6 -> v7:
  - No functional change
Changes v7 -> v8:
  - Include Reviewed-by tags from Anup and Atish
Changes v8 -> v9 (Suggested by Thomas [3]):
  - Fix coding style 
  - Update hwirq range checks
  - Update riscv_intc_* global variables initialization

[1] https://patchwork.kernel.org/project/linux-riscv/patch/20231023004100.2663486-3-peterlin@andestech.com/#25573085
[2] https://patchwork.kernel.org/project/linux-riscv/patch/20231213070301.1684751-3-peterlin@andestech.com/#25636589
[3] https://patchwork.kernel.org/project/linux-riscv/patch/20240129092553.2058043-3-peterlin@andestech.com/#25710584
---
 drivers/irqchip/irq-riscv-intc.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index e8d01b14ccdd..684875c39728 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -19,15 +19,16 @@
 #include <linux/smp.h>
 
 static struct irq_domain *intc_domain;
+static unsigned int riscv_intc_nr_irqs __ro_after_init = BITS_PER_LONG;
+static unsigned int riscv_intc_custom_base __ro_after_init = BITS_PER_LONG;
+static unsigned int riscv_intc_custom_nr_irqs __ro_after_init;
 
 static asmlinkage void riscv_intc_irq(struct pt_regs *regs)
 {
 	unsigned long cause = regs->cause & ~CAUSE_IRQ_FLAG;
 
-	if (unlikely(cause >= BITS_PER_LONG))
-		panic("unexpected interrupt cause");
-
-	generic_handle_domain_irq(intc_domain, cause);
+	if (generic_handle_domain_irq(intc_domain, cause))
+		pr_warn_ratelimited("Failed to handle interrupt (cause: %ld)\n", cause);
 }
 
 /*
@@ -93,6 +94,14 @@ static int riscv_intc_domain_alloc(struct irq_domain *domain,
 	if (ret)
 		return ret;
 
+	/*
+	 * Only allow hwirq for which we have corresponding standard or
+	 * custom interrupt enable register.
+	 */
+	if ((hwirq >= riscv_intc_nr_irqs && hwirq < riscv_intc_custom_base) ||
+	    (hwirq >= riscv_intc_custom_base + riscv_intc_custom_nr_irqs))
+		return -EINVAL;
+
 	for (i = 0; i < nr_irqs; i++) {
 		ret = riscv_intc_domain_map(domain, virq + i, hwirq + i);
 		if (ret)
@@ -117,8 +126,7 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn)
 {
 	int rc;
 
-	intc_domain = irq_domain_create_linear(fn, BITS_PER_LONG,
-					       &riscv_intc_domain_ops, NULL);
+	intc_domain = irq_domain_create_tree(fn, &riscv_intc_domain_ops, NULL);
 	if (!intc_domain) {
 		pr_err("unable to add IRQ domain\n");
 		return -ENXIO;
@@ -132,7 +140,11 @@ static int __init riscv_intc_init_common(struct fwnode_handle *fn)
 
 	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
 
-	pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
+	pr_info("%d local interrupts mapped\n", riscv_intc_nr_irqs);
+	if (riscv_intc_custom_nr_irqs) {
+		pr_info("%d custom local interrupts mapped\n",
+			riscv_intc_custom_nr_irqs);
+	}
 
 	return 0;
 }
-- 
2.34.1


