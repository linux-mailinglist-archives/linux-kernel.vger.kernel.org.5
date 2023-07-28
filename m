Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C84766ACB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbjG1KfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236241AbjG1Kdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:33:39 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A4A59DA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690540303; x=1722076303;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xbMFJDkuvSAVzLORTJHW0ZL04qI1N0hFjbaAsJ5qgb0=;
  b=IGiU3Bywq02hm2Q3wY4HiXgC6osLByrgB5lzoqpOpIKSpmVSb6V8yg/S
   t/cebbBZL+y9ic/WZ7Chh6Ty7kXa8zrdvIxGDPephp3Z+WKYxaDQDT3Uw
   Ep/9Y9Ss6cYZwp1IbuW9WJRO/KMKqxbFN2l/aqDNAQp04t7VdzSTBIJhi
   46VykHmH0F4P5J+A55XhLPira1FwKtQhbueYSB1FVDwuRT5D2wtlC0eBm
   8+OwI//G19qBbMbkP4+DXVhubYIaiMn27TiqDxWi16Ebu7Ihoy4FKHQIc
   bMl1cSx8Fd3Xex9uCw8p/3QOKVVkEymJpRtoNbRN7jH7/XC7aiv3IPVzV
   w==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="222729088"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:30:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:30:14 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:30:11 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <varshini.rajendran@microchip.com>,
        Hari Prasath <Hari.PrasathGE@microchip.com>
Subject: [PATCH v3 42/50] irqchip/atmel-aic5: Add support for sam9x7 aic
Date:   Fri, 28 Jul 2023 16:00:02 +0530
Message-ID: <20230728103002.267440-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hari Prasath <Hari.PrasathGE@microchip.com>

Add support for the Advanced interrupt controller(AIC) chip in the sam9x7.

Signed-off-by: Hari Prasath <Hari.PrasathGE@microchip.com>
Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/irqchip/irq-atmel-aic5.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index 145535bd7560..bab11900f3ef 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -320,6 +320,7 @@ static const struct of_device_id aic5_irq_fixups[] __initconst = {
 	{ .compatible = "atmel,sama5d3", .data = sama5d3_aic_irq_fixup },
 	{ .compatible = "atmel,sama5d4", .data = sama5d3_aic_irq_fixup },
 	{ .compatible = "microchip,sam9x60", .data = sam9x60_aic_irq_fixup },
+	{ .compatible = "microchip,sam9x7", .data = sam9x60_aic_irq_fixup },
 	{ /* sentinel */ },
 };
 
@@ -406,3 +407,12 @@ static int __init sam9x60_aic5_of_init(struct device_node *node,
 	return aic5_of_init(node, parent, NR_SAM9X60_IRQS);
 }
 IRQCHIP_DECLARE(sam9x60_aic5, "microchip,sam9x60-aic", sam9x60_aic5_of_init);
+
+#define NR_SAM9X7_IRQS		70
+
+static int __init sam9x7_aic5_of_init(struct device_node *node,
+				      struct device_node *parent)
+{
+	return aic5_of_init(node, parent, NR_SAM9X7_IRQS);
+}
+IRQCHIP_DECLARE(sam9x7_aic5, "microchip,sam9x7-aic", sam9x7_aic5_of_init);
-- 
2.25.1

