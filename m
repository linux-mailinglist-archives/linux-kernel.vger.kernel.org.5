Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B4678742A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242171AbjHXP1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242194AbjHXP1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:27:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A0419B0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:27:32 -0700 (PDT)
Date:   Thu, 24 Aug 2023 15:27:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692890850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3KxgU1bxYDQYQZZ2ualz2wGau09WiCguX45PA5GMm/Y=;
        b=vTGGuVSU5sG9KXTKynY+XP4JEoTnzOv1llE8kKC+3X+kAwRBe2X6fQ9tMh/S7ZvlQw1YQl
        eHS0lK87TAqydXVqJq6qrjcAr+ET/bEuAUnpYfTbexYBvRaK7HmE6y0Du6anflyAItVbsb
        UN79tskdUjHSujUbFiAVK97UDw4vBbqvixSrs/C/K4Zza3dnvpL1GnflTCiWL/lyxagfpa
        CGJWzspX1vOaY99XMHNqPk986DPr4fvcbDeYZHG7MkE8q1XbsHxl2YDWvu1uEg4QSpQjjA
        4QfWhCIaliK5ABVhvUt7XLNrbcOy/iGgs54JO7mQJHVI7LENRwcp1AMhanNRlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692890850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3KxgU1bxYDQYQZZ2ualz2wGau09WiCguX45PA5GMm/Y=;
        b=HEco+woyup3ILH4xK/NgHiUQkGUoSN62dJDfWRURCFpceU36KG/ROYc4I1o8mp2KREt/Zj
        30XbHhNNr24/heDw==
From:   "irqchip-bot for Neil Armstrong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/qcom-pdc: Add support for v3.2 HW
Cc:     Maulik Shah <quic_mkshah@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230823-topic-sm8x50-upstream-pdc-ver-v3-1-aa7d9ab862e4@linaro.org>
References: <20230823-topic-sm8x50-upstream-pdc-ver-v3-1-aa7d9ab862e4@linaro.org>
MIME-Version: 1.0
Message-ID: <169289084988.27769.11549275599635669970.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     bc82cc42644b19a23567c2e06d084e3557ee2711
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/bc82cc42644b19a23567c2e06d084e3557ee2711
Author:        Neil Armstrong <neil.armstrong@linaro.org>
AuthorDate:    Wed, 23 Aug 2023 11:42:19 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 24 Aug 2023 16:24:58 +01:00

irqchip/qcom-pdc: Add support for v3.2 HW

Starting from HW version 3.2 the IRQ_ENABLE bit has moved to the
IRQ_i_CFG register and requires a change of the driver to avoid
writing into an undefined register address.

Get the HW version from registers and set the IRQ_ENABLE bit to the
correct register depending on the HW version.

Reviewed-by: Maulik Shah <quic_mkshah@quicinc.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230823-topic-sm8x50-upstream-pdc-ver-v3-1-aa7d9ab862e4@linaro.org
---
 drivers/irqchip/qcom-pdc.c | 61 +++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index a32c0d2..9bb6951 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -22,9 +22,22 @@
 
 #define PDC_MAX_GPIO_IRQS	256
 
+/* Valid only on HW version < 3.2 */
 #define IRQ_ENABLE_BANK		0x10
 #define IRQ_i_CFG		0x110
 
+/* Valid only on HW version >= 3.2 */
+#define IRQ_i_CFG_IRQ_ENABLE	3
+
+#define IRQ_i_CFG_TYPE_MASK	GENMASK(2, 0)
+
+#define PDC_VERSION		0x1000
+
+/* Notable PDC versions */
+enum {
+	PDC_VERSION_3_2	= 0x30200,
+};
+
 struct pdc_pin_region {
 	u32 pin_base;
 	u32 parent_base;
@@ -37,6 +50,7 @@ static DEFINE_RAW_SPINLOCK(pdc_lock);
 static void __iomem *pdc_base;
 static struct pdc_pin_region *pdc_region;
 static int pdc_region_cnt;
+static unsigned int pdc_version;
 
 static void pdc_reg_write(int reg, u32 i, u32 val)
 {
@@ -53,15 +67,22 @@ static void pdc_enable_intr(struct irq_data *d, bool on)
 	int pin_out = d->hwirq;
 	unsigned long enable;
 	unsigned long flags;
-	u32 index, mask;
-
-	index = pin_out / 32;
-	mask = pin_out % 32;
 
 	raw_spin_lock_irqsave(&pdc_lock, flags);
-	enable = pdc_reg_read(IRQ_ENABLE_BANK, index);
-	__assign_bit(mask, &enable, on);
-	pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
+	if (pdc_version < PDC_VERSION_3_2) {
+		u32 index, mask;
+
+		index = pin_out / 32;
+		mask = pin_out % 32;
+
+		enable = pdc_reg_read(IRQ_ENABLE_BANK, index);
+		__assign_bit(mask, &enable, on);
+		pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
+	} else {
+		enable = pdc_reg_read(IRQ_i_CFG, pin_out);
+		__assign_bit(IRQ_i_CFG_IRQ_ENABLE, &enable, on);
+		pdc_reg_write(IRQ_i_CFG, pin_out, enable);
+	}
 	raw_spin_unlock_irqrestore(&pdc_lock, flags);
 }
 
@@ -142,6 +163,7 @@ static int qcom_pdc_gic_set_type(struct irq_data *d, unsigned int type)
 	}
 
 	old_pdc_type = pdc_reg_read(IRQ_i_CFG, d->hwirq);
+	pdc_type |= (old_pdc_type & ~IRQ_i_CFG_TYPE_MASK);
 	pdc_reg_write(IRQ_i_CFG, d->hwirq, pdc_type);
 
 	ret = irq_chip_set_type_parent(d, type);
@@ -246,7 +268,7 @@ static const struct irq_domain_ops qcom_pdc_ops = {
 static int pdc_setup_pin_mapping(struct device_node *np)
 {
 	int ret, n, i;
-	u32 irq_index, reg_index, val;
+	unsigned long val;
 
 	n = of_property_count_elems_of_size(np, "qcom,pdc-ranges", sizeof(u32));
 	if (n <= 0 || n % 3)
@@ -277,11 +299,22 @@ static int pdc_setup_pin_mapping(struct device_node *np)
 			return ret;
 
 		for (i = 0; i < pdc_region[n].cnt; i++) {
-			reg_index = (i + pdc_region[n].pin_base) >> 5;
-			irq_index = (i + pdc_region[n].pin_base) & 0x1f;
-			val = pdc_reg_read(IRQ_ENABLE_BANK, reg_index);
-			val &= ~BIT(irq_index);
-			pdc_reg_write(IRQ_ENABLE_BANK, reg_index, val);
+			if (pdc_version < PDC_VERSION_3_2) {
+				u32 irq_index, reg_index;
+
+				reg_index = (i + pdc_region[n].pin_base) >> 5;
+				irq_index = (i + pdc_region[n].pin_base) & 0x1f;
+				val = pdc_reg_read(IRQ_ENABLE_BANK, reg_index);
+				__assign_bit(irq_index, &val, 0);
+				pdc_reg_write(IRQ_ENABLE_BANK, reg_index, val);
+			} else {
+				u32 irq;
+
+				irq = i + pdc_region[n].pin_base;
+				val = pdc_reg_read(IRQ_i_CFG, irq);
+				__assign_bit(IRQ_i_CFG_IRQ_ENABLE, &val,  0);
+				pdc_reg_write(IRQ_i_CFG, irq, val);
+			}
 		}
 	}
 
@@ -299,6 +332,8 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
 		return -ENXIO;
 	}
 
+	pdc_version = pdc_reg_read(PDC_VERSION, 0);
+
 	parent_domain = irq_find_host(parent);
 	if (!parent_domain) {
 		pr_err("%pOF: unable to find PDC's parent domain\n", node);
