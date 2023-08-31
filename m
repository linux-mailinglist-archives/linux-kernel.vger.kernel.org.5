Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D9D78E4F9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 05:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240474AbjHaDJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 23:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjHaDJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 23:09:40 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A30CC2;
        Wed, 30 Aug 2023 20:09:37 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5734b893a11so284862eaf.1;
        Wed, 30 Aug 2023 20:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693451377; x=1694056177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9RXlB9MIgueAa9gzs3f/OTKyoQLTxJwUBTOdXek0lCk=;
        b=BlMK6Pe0cdUsUIwcBwJjKV+W7Fupm8mhQx+YtcGGQFYJwyPw1mF0ekOKNhqA0HhfRZ
         7NAI/f8GTUCEqDdB1jtmS0l43qJZ7hDDzh/0Pqy74e2/LhZM3I+9J+Ov2mouuwNjebr9
         40M/FoIk3urrrlFjLhlZA4A3foiJ9dhDPz7pDO5nSDoPskP8Bvl3FfBx/sCrt98bVur1
         qQ/VQ15r3lMusVfiKibD+lExihbCIfek9kmp2xI80mt8Q75PwgS5w0lvMQR/Bc9zfobJ
         us0NHSTn2hWveyeG23WIBHQQz0IK2gko9eBNy7ubaRdnn1qTdJwl1Dr1SRjttmOKJEZ5
         8GTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693451377; x=1694056177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9RXlB9MIgueAa9gzs3f/OTKyoQLTxJwUBTOdXek0lCk=;
        b=ZApkyUBhKRGRdnpczvVJdualb0ptNIqVvZXJEuLGURcRhCU40KhaNid3zGz4zVmFYv
         0xcNDT/c6/1/mLzFWPWd87lCbV6/8g1eqJyw4nF5Sx4yo1a7linEIqydxEOjq5Lvgjud
         7umuYDBQo26BP6J7Sv0MWTpct7r3wTKL/81T9f+AnvMObkR9nl5xxcJ2UyhhDQ8xykgq
         nNgvZJEEN5jecV0t9BylXIJGkTVqIkVAyPkFN7G7A0aLoDpE1BzSR+MbdOjh6VHeLcvN
         ObrTL5D2X3oLHr4LpyFtEHQRwOU9qxvpB+quuN6hS0lTBdek/n/TbGnMj0WtiN5adjla
         4gsQ==
X-Gm-Message-State: AOJu0YyBo2wexQx8uSNXXpSqEUPiW1iv81+/HHzCenu/4C9K/p07OypR
        ga0jZH02zhZEwjpU51LtyfRMI/FU8cwAag==
X-Google-Smtp-Source: AGHT+IHihW/Qoho00/zN7hAUukH8tbuDBfaQFXuoK0uJ9RpVZhoXnelnCOZDNnYfCHvxt1w5G3QyRQ==
X-Received: by 2002:a05:6358:9308:b0:139:c75f:63eb with SMTP id x8-20020a056358930800b00139c75f63ebmr3420297rwa.21.1693451377048;
        Wed, 30 Aug 2023 20:09:37 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id x7-20020a63b207000000b00563df2ba23bsm324514pge.50.2023.08.30.20.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 20:09:36 -0700 (PDT)
From:   Szuying Chen <chensiying21@gmail.com>
X-Google-Original-From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
To:     Niklas.Cassel@wdc.com, dlemoal@kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jesse1_Chang@asmedia.com.tw, Richard_Hsu@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw
Subject: [PATCH] ahci: libahci: clear pending interrupt status
Date:   Thu, 31 Aug 2023 11:09:24 +0800
Message-Id: <20230831030924.21960-1-Chloe_Chen@asmedia.com.tw>
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
---
 drivers/ata/libahci.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 06aec35f88f2..1ae788251a6c 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1584,6 +1584,23 @@ static int ahci_pmp_retry_softreset(struct ata_link *link, unsigned int *class,
 	return rc;
 }

+static void PortClearPendingInterrupt(struct ata_port *ap)
+{
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+	void __iomem *port_mmio = ahci_port_base(ap);
+	u32 tmp;
+
+	/* clear port SERR */
+	tmp = readl(port_mmio + PORT_SCR_ERR);
+	writel(tmp, port_mmio + PORT_SCR_ERR);
+
+	/* clear port IRQ */
+	tmp = readl(port_mmio + PORT_IRQ_STAT);
+	writel(tmp, port_mmio + PORT_IRQ_STAT);
+
+	writel(1 << ap->port_no, hpriv->mmio + HOST_IRQ_STAT);
+}
+
 int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
 		      unsigned long deadline, bool *online)
 {
@@ -1602,6 +1619,9 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
 	tf.status = ATA_BUSY;
 	ata_tf_to_fis(&tf, 0, 0, d2h_fis);

+	/* clear pending Interrupt */
+	PortClearPendingInterrupt(ap);
+
 	rc = sata_link_hardreset(link, timing, deadline, online,
 				 ahci_check_ready);

--
2.39.2

