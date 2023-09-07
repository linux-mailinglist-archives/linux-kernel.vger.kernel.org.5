Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE483797CC8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 21:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbjIGTbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 15:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237076AbjIGTba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 15:31:30 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5580DE47;
        Thu,  7 Sep 2023 12:31:26 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76ef8b91a4bso77136385a.2;
        Thu, 07 Sep 2023 12:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694115085; x=1694719885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5y5iv1OALmVf6a+TqnduiIEngVGe9YROKwrZI/DCHtE=;
        b=Bfmz7q0HoTJdGrSR1batcK+VSy9b8uHwV0zpxsSkFYXXJJSx3QTCfFDnsc3rWg6a3m
         h0VBgOUmQVs+AYzykUUlCNylqF4dELiqMbTLCf69gnSmeXE0u5I91nR21te4Ya6Wv8uP
         lETt8nI+/yHPpibXT0tzsfJdEynbTHIxTJxuZt3ocvbnW3YVayTtQAP0avunrPtdq9WJ
         njO6M7hQxTwWpmpTZpMWDrtW+OUjcpoAKffl7tXhCH47IWfWBE+PU+NiCEMkNACfhnag
         naJPop97ckPYMv2/xOmHG8+ygedvLLnJN2LnIcaMGFAHtNYmUAPZJLbg2ckCWIGYxs/D
         hu3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694115085; x=1694719885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5y5iv1OALmVf6a+TqnduiIEngVGe9YROKwrZI/DCHtE=;
        b=QPr/oGlBx6GHC0aljzbGuTFsH+4hOVQvZzyk41MM6/6oyFwnDMc8z9r54RuwAeFQB/
         c8Fmt17d5DRhdHA6SkL2f9YgxnNst/ZgyAHcSL8mZUwpFWDH+89jo/sYYLlnn24AdtRP
         poFomsDpvbEe3IrJjRTyvGgt78lZBXgVid+jM4TZKN+N8jS4n7aoM4R9dSMFyTBw8RsB
         yEF4eFFtHvy1XyBb/p5yk7tIElE2Y8SdHgnkbd/6E3zfrDF3jNZUh1BrImy3ZXDs+TF2
         K4cSxtFgDyoPB0ll6RWFzSgq2nchJPxjP9bDtfZbBsjrfMQmdSnMXYIlQH/W8goIDzz1
         UNgA==
X-Gm-Message-State: AOJu0Yw5FGwc4EM2Lt/VS9OHqxtMNMefBxGmsMpg/R5RRNO0pt8AtWkH
        F0aHd3G1RbKVnzLVV7b1RqwR4m0oE+b21g==
X-Google-Smtp-Source: AGHT+IFhzBWdNrVTjFKMRQPUiwze2exYaZYHTBNprxZTfY4DdBzS30U16N2jYA95fuMcVsTIgnvVgA==
X-Received: by 2002:a17:902:efd4:b0:1c0:db5a:8c78 with SMTP id ja20-20020a170902efd400b001c0db5a8c78mr13831268plb.68.1694074635269;
        Thu, 07 Sep 2023 01:17:15 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id jh22-20020a170903329600b001c0de73564dsm12238493plb.205.2023.09.07.01.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 01:17:14 -0700 (PDT)
From:   Szuying Chen <chensiying21@gmail.com>
X-Google-Original-From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
To:     Niklas.Cassel@wdc.com, dlemoal@kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jesse1_Chang@asmedia.com.tw, Richard_Hsu@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw
Subject: [PATCH v4] ahci: libahci: clear pending interrupt status
Date:   Thu,  7 Sep 2023 16:17:10 +0800
Message-Id: <20230907081710.4946-1-Chloe_Chen@asmedia.com.tw>
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

When a CRC error occurs, the HBA asserts an interrupt to indicate an
interface fatal error(PxIS.IFS). The ISR clear PxIE and PxIS, then do
error recovery. Before recovery process, HBA receives another SDB FIS
with the error(PxIS.TFES) from device. This can't be serviced due to
PxIE be cleared already. During error recovery process, the HBA can't
issue any new command after setting PxCMD.ST to 1 due to PxIS.TFES
still alive.

According to AHCI 1.3.1 - section 6.2.2 specification. Fatal errors
(signified by the setting of PxIS.HBFS, PxIS.HBDS, PxIS.IFS or PxIS.TFES)
will cause the HBA to enter the ERR:Fatal state. In this state, the HBA
shall not issue any new commands.

To avoid this, introduce the function ahci_port_clear_pending_irq()
to clear pending interrupts before executing a COMRESET. This follows
the AHCI 1.3.1 - section 6.2.2.2 specification.

Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
---
V1->V2: On suggestion by Damien to renamed helper function and modified 
ahci_port_init() to make use of the helper.
V2->V3: On suggestion by Niklas to modify commit log and delete the extra 
describe.
V3->V4: On suggestion by Damien to modify problem statement on commit log.

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

