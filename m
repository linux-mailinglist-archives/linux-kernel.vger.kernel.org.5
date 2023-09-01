Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C9478FA09
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238512AbjIAIgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbjIAIgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:36:54 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D9810DE;
        Fri,  1 Sep 2023 01:36:51 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bf1935f6c2so11331305ad.1;
        Fri, 01 Sep 2023 01:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693557410; x=1694162210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=55BfpGuwLusivJNyI1HNMwBWqeaqctChQyzGU00DJsA=;
        b=ovG+6kjhGPQb6+YTG8uRo7LFx2G0BbP8Gqm99OgnQlbU/5rESQF2HFjn88aSor2XmR
         fDmYZUmF6sEAW4ybrfjFg/PvE+90kUNil6mg/ISwt6d+NMidHRqVJBEc2PS8jhQ0JYRq
         PG2lQk7V+VybMDzTWFI3ChAS6FC5zMDWA7txQ7piHWHr2MEJsX70ANknce25F6ZEkWuc
         r4u5XD+9kDO7BMz7arPAiwVQk6FftKba1vsSfZK+XSh9lJQcOYyduwoZFb1VblemHYZt
         Gi+NQHEob+B1hlQeefmQZ25TUlp9/0UtJiayxk7ZQwYTvbbfrd5jkeMjwGAnRO6u+4y/
         BnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693557410; x=1694162210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55BfpGuwLusivJNyI1HNMwBWqeaqctChQyzGU00DJsA=;
        b=e3FK7htCummxWriOnMzEpc8NWSDvbYsWAlvt36HPc/ovBPEP1P6spk89ZCSGgnx8z5
         9h1wi3ckxfBx8cBt2WycvsH4nxS1Mqjd74P5nXV/zy5P6+a2NlUjoOPvCeNbt1+y/P7A
         1yd2qvI2HVMP6nZJGKAnQwRZJ3Hw/e/UE9hY1zuk2DAXnuBv/IuXPmjsk8StMX7dTPiM
         zU/Fp8Ft3SqayRlO2cTfwhUbuFeZlhrGD+V0kZMNiSEKKqcMTt0a2W1z7qq5qFJckX3m
         bT/+ArkyuwFrRLsz1YoOE4UpOaujg5ei+bwko2GlYNiTISsPLKY2JLXpDNizDbNFJvFQ
         YstQ==
X-Gm-Message-State: AOJu0YxxrwG02rAZLNlxw2ed0ujymHYvFqljw1J2VpcJUiPeojosscBZ
        ROUV7J3TQibawQ0E3Sqhn3E=
X-Google-Smtp-Source: AGHT+IHVEy1KUMGUAHI2M1xMPYpYaSCOYprCl6jmt9DoGlb3eSNpaEYVvTfP2tysSOGBzgZf0puP3g==
X-Received: by 2002:a17:902:e5c5:b0:1bb:85cd:9190 with SMTP id u5-20020a170902e5c500b001bb85cd9190mr2980803plf.18.1693557410610;
        Fri, 01 Sep 2023 01:36:50 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id iy22-20020a170903131600b001bf20c80684sm2502504plb.6.2023.09.01.01.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 01:36:50 -0700 (PDT)
From:   Szuying Chen <chensiying21@gmail.com>
X-Google-Original-From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
To:     Niklas.Cassel@wdc.com, dlemoal@kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jesse1_Chang@asmedia.com.tw, Richard_Hsu@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw
Subject: [PATCH v2] ahci: libahci: clear pending interrupt status
Date:   Fri,  1 Sep 2023 16:36:13 +0800
Message-Id: <20230901083613.5544-1-Chloe_Chen@asmedia.com.tw>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the function to clear pending interrupt before COMRESET.
It follows the  AHCI1.3.1 - section6.2.2.2 specification.

Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
---modify function name and substitution related behavior.

 drivers/ata/libahci.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 06aec35f88f2..f8ecd9956ea1 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1256,6 +1256,27 @@ static ssize_t ahci_activity_show(struct ata_device *dev, char *buf)
 	return sprintf(buf, "%d\n", emp->blink_policy);
 }

+static void ahci_port_clear_pending_irq(struct ata_port *ap)
+{
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+	void __iomem *port_mmio = ahci_port_base(ap);
+	u32 tmp;
+
+	/* clear SError */
+	tmp = readl(port_mmio + PORT_SCR_ERR);
+	dev_dbg(ap->host->dev, "PORT_SCR_ERR 0x%x\n", tmp);
+	writel(tmp, port_mmio + PORT_SCR_ERR);
+
+	/* clear port IRQ */
+	tmp = readl(port_mmio + PORT_IRQ_STAT);
+	dev_dbg(ap->host->dev, "PORT_IRQ_STAT 0x%x\n", tmp);
+	if (tmp)
+		writel(tmp, port_mmio + PORT_IRQ_STAT);
+
+	writel(1 << ap->port_no, hpriv->mmio + HOST_IRQ_STAT);
+
+}
+
 static void ahci_port_init(struct device *dev, struct ata_port *ap,
 			   int port_no, void __iomem *mmio,
 			   void __iomem *port_mmio)
@@ -1270,18 +1291,8 @@ static void ahci_port_init(struct device *dev, struct ata_port *ap,
 	if (rc)
 		dev_warn(dev, "%s (%d)\n", emsg, rc);

-	/* clear SError */
-	tmp = readl(port_mmio + PORT_SCR_ERR);
-	dev_dbg(dev, "PORT_SCR_ERR 0x%x\n", tmp);
-	writel(tmp, port_mmio + PORT_SCR_ERR);
-
-	/* clear port IRQ */
-	tmp = readl(port_mmio + PORT_IRQ_STAT);
-	dev_dbg(dev, "PORT_IRQ_STAT 0x%x\n", tmp);
-	if (tmp)
-		writel(tmp, port_mmio + PORT_IRQ_STAT);
-
-	writel(1 << port_no, mmio + HOST_IRQ_STAT);
+	/* clear pending irq */
+	ahci_port_clear_pending_irq(ap);

 	/* mark esata ports */
 	tmp = readl(port_mmio + PORT_CMD);
@@ -1602,6 +1613,9 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
 	tf.status = ATA_BUSY;
 	ata_tf_to_fis(&tf, 0, 0, d2h_fis);

+	/* clear pending irq */
+	ahci_port_clear_pending_irq(ap);
+
 	rc = sata_link_hardreset(link, timing, deadline, online,
 				 ahci_check_ready);

--
2.39.2

