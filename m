Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04ECB7938F3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237922AbjIFJxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbjIFJxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:53:45 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6084DE45;
        Wed,  6 Sep 2023 02:53:41 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-792717ef3c9so120177539f.3;
        Wed, 06 Sep 2023 02:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693994021; x=1694598821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O+jbAb9PPLtM12pxrmkTUbrYGmlsLRIoU8cv1defV5Y=;
        b=OTzkPJHpPmheLcNh5QjDuTvHWzNfgIPtcmxj7qcSbKWDYB++t6M45Xftsq8YlGyeBq
         GOjRURYsdlxMMSzJqwzFZVGMiCK6usSYE+kxeYizC16Zr/ToP5RD/dh4rRskJpY0F52w
         0tJawIpm+ojEcAOa/I5DhB799GEprgJrHAF0iXXR+U+XAJpaLl2JLP7CrI8k8zZa73t0
         e341Umr6Kn0eqWYa2O9e1QzeVzJIzS9HqFuFcA5dgxc/o0lghU9lpQ0bAFGmbJLG1qfl
         csT32m4HonaPXzVe6vh5ERNmjJ+j6JK24Ga4s1LUEUkaoJp8whedAT1Bo3IcpKTbk1yi
         eRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693994021; x=1694598821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+jbAb9PPLtM12pxrmkTUbrYGmlsLRIoU8cv1defV5Y=;
        b=bC5BS+qFj9bTum4SoeeRvVrm+o1SxG/3aoZXqH2bpm/L8M0XPGZO0Ycy4NR6+NfAL6
         sY092a+l2N7jB/52APGWhtF4AcVfp06nWhMqqB1xwNmz1rn4j75xka55c58M4vLLnZbK
         uR2BwaKxKgWS03euI8GptJSrO4LseLeNdAT/6tY703LnIQRVBC7GgwcHLAYSHb8aFk91
         7DEYSpF/sRnIXd5DsXsuOdi7/SdZjseBneR359aWOGcuAMklhqaAj9GFg2f3ixxpo8bJ
         cv8QVIkNLi3kihcxOWrU4T4w7s9Woq0bVu/DMSuUmC8DGta+wba+wvqHg+dhNjd9ESLh
         LhJQ==
X-Gm-Message-State: AOJu0Yy4rB+EIxHny9wfhQ6pRMpPvkp86Q1V8YUqUTaaUdTPCvXhfSkk
        IKTWonaeRvuzn3dQv9pHt9ckeOYOj2IIDQ==
X-Google-Smtp-Source: AGHT+IGY/qLNyoCrTABXTk3TA/RxWtVfBTfWVWCGs6usqsOk5C11IAvkn8UoLUYOq6beO2Ls9YiQEw==
X-Received: by 2002:a05:6e02:cd0:b0:34f:28bd:71fa with SMTP id c16-20020a056e020cd000b0034f28bd71famr3236183ilj.3.1693994020717;
        Wed, 06 Sep 2023 02:53:40 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090a1f4800b0025bd4db25f0sm11447586pjy.53.2023.09.06.02.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 02:53:40 -0700 (PDT)
From:   Szuying Chen <chensiying21@gmail.com>
X-Google-Original-From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
To:     Niklas.Cassel@wdc.com, dlemoal@kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jesse1_Chang@asmedia.com.tw, Richard_Hsu@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw
Subject: [PATCH v3] ahci: libahci: clear pending interrupt status
Date:   Wed,  6 Sep 2023 17:53:34 +0800
Message-Id: <20230906095334.10310-1-Chloe_Chen@asmedia.com.tw>
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

Cleared PxIS and PxIE with error recovery when ISR handle interface fatal.
Then a SDB FIS with ERR (set PxIS.TFES) is received
before PxCMD.ST is set to 0.
When error recovery was finish and PxCMD.ST is set to 1.
The HBA can't issue any new commands.
Because the PxIS.TFES bit is not cleared.
To avoid this,
we adds the function to clear pending interrupt before COMRESET.
It follows the AHCI 1.3.1 - section 6.2.2.2 specification.

Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
---
V1->V2: On suggestion by Damien to renamed helper function and modified
ahci_port_init() to make use of the helper.
V2->V3: On suggestion by Niklas to modify commit log and delete the
extra describe.

 drivers/ata/libahci.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index e2bacedf28ef..f1263364fa97 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1256,6 +1256,26 @@ static ssize_t ahci_activity_show(struct ata_device *dev, char *buf)
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
+}
+
 static void ahci_port_init(struct device *dev, struct ata_port *ap,
 			   int port_no, void __iomem *mmio,
 			   void __iomem *port_mmio)
@@ -1270,18 +1290,7 @@ static void ahci_port_init(struct device *dev, struct ata_port *ap,
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
+	ahci_port_clear_pending_irq(ap);

 	/* mark esata ports */
 	tmp = readl(port_mmio + PORT_CMD);
@@ -1603,6 +1612,8 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
 	tf.status = ATA_BUSY;
 	ata_tf_to_fis(&tf, 0, 0, d2h_fis);

+	ahci_port_clear_pending_irq(ap);
+
 	rc = sata_link_hardreset(link, timing, deadline, online,
 				 ahci_check_ready);

--
2.39.2

