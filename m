Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D63776F5B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjHJFGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjHJFGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:06:35 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C16592;
        Wed,  9 Aug 2023 22:06:35 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso2652045ad.1;
        Wed, 09 Aug 2023 22:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691643995; x=1692248795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RbIZ6+TF5sZsQZ7FDf5OkaqBqtNyqV1bMcvI7Ewy41s=;
        b=QXiF/GbzwsW4oVqUHfJu86el/xjbFoEnq2N+uZLq3HhhmbKQ/q9GbeJhnluiGqznD0
         4sG0UzDQMNkFaAJTjihkPgrP+/uWwGeVD2aC5nliyHfaqRxple7JS5gYiIRgJCbCYAsK
         Je3vD7wdwgXFqfK0L/JZgpG6a8qnn43MpyfIiP6q5hKtwZ9BSJU47XduMZ6MZGUghmfU
         /EArVIwI2rD+AzskR7VDn/YBszQf6I0TAUq7b95wJm2bPzjlBFEWEWVT0JDi/YDtENix
         3jLE+hbxn/eL1FgtNikXIzn+9JX+l8v63WfrNjfQhhjrpBoUMtT1QF+1cQ5ErRoyXeUF
         n6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691643995; x=1692248795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RbIZ6+TF5sZsQZ7FDf5OkaqBqtNyqV1bMcvI7Ewy41s=;
        b=af2D8ywT1xez3pTHiS0lI19ZBywdYtqXUBmE95Kzjyff4mco2CqecCPLbK1zLgvLz6
         eOdo3iENzmEYyOHV0Nw+uQqBMEZG99HkJycmGrfx1HBZ8BzH/oJ8Jtd8+sLK8wcXkTPy
         KTK56UeAsJk3udeQipK9+9mRSVbvRjV0gO00RuaXDs9mYljpcq89afYHmAu+v4FN2Jsg
         gQZLj7WqBpl8PBCB3IVvrLPv2Cb6WwAMz6FA1m40IShYgXnSXm/IcZImwAQBlcvY3azf
         qlkXOBgSpwPOcpuDz3VQexDcEGKZf2HFbeOMbcO9z6sxbWNlrMf8jAdEUJ2UNV2JEpOG
         LKnw==
X-Gm-Message-State: AOJu0YxES58yop1GGWMbLdLnDPJvwRnCePUQdhMWQrBo9Z0W7hXkC1C5
        w7SIfmdXOa/wLLy4pVvPE13MzghFcGKLmw==
X-Google-Smtp-Source: AGHT+IEPTfFXlaMWdXsW6iRDmvLV9Z8jrnhQg24iKCYXncpOHQig80qbPmUp6nLYeqFXB+TQm31ynA==
X-Received: by 2002:a17:903:41c8:b0:1b3:d6c8:7008 with SMTP id u8-20020a17090341c800b001b3d6c87008mr1258509ple.57.1691643994669;
        Wed, 09 Aug 2023 22:06:34 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902b78a00b001bba7aab826sm519880pls.163.2023.08.09.22.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 22:06:34 -0700 (PDT)
From:   Szuying Chen <chensiying21@gmail.com>
X-Google-Original-From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
To:     dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jesse1_Chang@asmedia.com.tw, Richard_Hsu@asmedia.com.tw,
        Chloe_chen@asmedia.com.tw, Szuying Chen <Chloe_Chen@asmedia.com.tw>
Subject: [PATCH] ahci: libahci: clear pending interrupt status
Date:   Thu, 10 Aug 2023 13:05:31 +0800
Message-Id: <20230810050531.43505-1-Chloe_Chen@asmedia.com.tw>
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

When ISR handle interface fatal error with error recovery after clear PxIS
and PxIE. Another FIS(SDB FIS with err) that set PxIS.IFS to 1 is recevied
during error recovery, which causing the HBA not issue any new commands
after cmd.ST set 1.

Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
---
 drivers/ata/libahci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 06aec35f88f2..0ae51fd95d46 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -679,9 +679,21 @@ static int ahci_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val)

 void ahci_start_engine(struct ata_port *ap)
 {
+	struct ahci_host_priv *hpriv = ap->host->private_data;
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 tmp;

+	/* clear SError */
+	tmp = readl(port_mmio + PORT_SCR_ERR);
+	writel(tmp, port_mmio + PORT_SCR_ERR);
+
+	/* clear port IRQ */
+	tmp = readl(port_mmio + PORT_IRQ_STAT);
+	if (tmp)
+		writel(tmp, port_mmio + PORT_IRQ_STAT);
+
+	writel(1 << ap->port_no, hpriv->mmio + PORT_IRQ_STAT);
+
 	/* start DMA */
 	tmp = readl(port_mmio + PORT_CMD);
 	tmp |= PORT_CMD_START;
--
2.39.2

