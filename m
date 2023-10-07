Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DEA7BC750
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 14:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343926AbjJGMAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 08:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343892AbjJGMAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 08:00:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0734C2
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 05:00:45 -0700 (PDT)
Date:   Sat, 07 Oct 2023 12:00:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696680044;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eks3FV3uvSfcZSrXuFTsbcqICww6h8jb0FfHip1B8p0=;
        b=cuL2sP7bhbQuEWV8Ui9HNsshQZqV6OAMGSThp29ZEwO7yKKoIecsv+qTbBrg/CxomPySYx
        vvS2MlbI4y/j8oBG8IlGSK0FxYBf5Os/7ycNKQeymSd8xj13/mY8ka8qbABeGq7XmVYZL7
        LnCwB96X3+o5WnuQSTzQ7sN89D7Ez0zkGWadZAP4+Rfy95A9jQcOlAq4oQ17/f1T5vcQXs
        gb49tJ3paDattvdj4lJZssYYatFbr0qM1814iDPERyT+XJt2uIIY9eNIh5Yfm/nGphZlZx
        dhiRTQMYWlFeE9276sEbHpi/8OgrEbgYNczwRWjfsHFw0EkZzqJSoPARH4/vBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696680044;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Eks3FV3uvSfcZSrXuFTsbcqICww6h8jb0FfHip1B8p0=;
        b=tM7iMuFEyiwCWLCfr3v3kqIOWFqg1v4MV52eFilf1+WC1JIdVawfDz2DLmKyZBHggSe10P
        Y/lNXHddUwpWtIBQ==
From:   "irqchip-bot for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/riscv-intc: Mark all INTC nodes
 as initialized
Cc:     Dmitry Dunaev <dunaev@tecon.ru>,
        Anup Patel <apatel@ventanamicro.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230926102801.1591126-1-dunaev@tecon.ru>
References: <20230926102801.1591126-1-dunaev@tecon.ru>
MIME-Version: 1.0
Message-ID: <169668004402.3135.14972053144849513086.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     e13cd66bd821be417c498a34928652db4ac6b436
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e13cd66bd821be417c498a34928652db4ac6b436
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Tue, 03 Oct 2023 10:13:51 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 07 Oct 2023 12:47:12 +01:00

irqchip/riscv-intc: Mark all INTC nodes as initialized

The RISC-V INTC local interrupts are per-HART (or per-CPU) so we
create INTC IRQ domain only for the INTC node belonging to the boot
HART. This means only the boot HART INTC node will be marked as
initialized and other INTC nodes won't be marked which results
downstream interrupt controllers (such as PLIC, IMSIC and APLIC
direct-mode) not being probed due to missing device suppliers.

To address this issue, we mark all INTC node for which we don't
create IRQ domain as initialized.

Reported-by: Dmitry Dunaev <dunaev@tecon.ru>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230926102801.1591126-1-dunaev@tecon.ru
Link: https://lore.kernel.org/r/20231003044403.1974628-4-apatel@ventanamicro.com
---
 drivers/irqchip/irq-riscv-intc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index 4adeee1..e8d01b1 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -155,8 +155,16 @@ static int __init riscv_intc_init(struct device_node *node,
 	 * for each INTC DT node. We only need to do INTC initialization
 	 * for the INTC DT node belonging to boot CPU (or boot HART).
 	 */
-	if (riscv_hartid_to_cpuid(hartid) != smp_processor_id())
+	if (riscv_hartid_to_cpuid(hartid) != smp_processor_id()) {
+		/*
+		 * The INTC nodes of each CPU are suppliers for downstream
+		 * interrupt controllers (such as PLIC, IMSIC and APLIC
+		 * direct-mode) so we should mark an INTC node as initialized
+		 * if we are not creating IRQ domain for it.
+		 */
+		fwnode_dev_initialized(of_fwnode_handle(node), true);
 		return 0;
+	}
 
 	return riscv_intc_init_common(of_node_to_fwnode(node));
 }
