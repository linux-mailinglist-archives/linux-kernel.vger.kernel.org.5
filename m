Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC38D7545F2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 03:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjGOBE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 21:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjGOBE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 21:04:26 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0866A3AA3;
        Fri, 14 Jul 2023 18:04:22 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,206,1684767600"; 
   d="scan'208";a="172657788"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jul 2023 10:04:22 +0900
Received: from mulinux.home (unknown [10.226.92.194])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2AAA140A10D5;
        Sat, 15 Jul 2023 10:04:18 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 02/10] spi: rzv2m-csi: Adopt HZ_PER_MHZ for max spi clock
Date:   Sat, 15 Jul 2023 02:03:59 +0100
Message-Id: <20230715010407.1751715-3-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com>
References: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of HZ_PER_MHZ for CSI_MAX_SPI_SCKO to make it clear
what its value means.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 drivers/spi/spi-rzv2m-csi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rzv2m-csi.c b/drivers/spi/spi-rzv2m-csi.c
index b595f3b7294d..3931045a85eb 100644
--- a/drivers/spi/spi-rzv2m-csi.c
+++ b/drivers/spi/spi-rzv2m-csi.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/spi/spi.h>
+#include <linux/units.h>
 
 /* Registers */
 #define CSI_MODE		0x00	/* CSI mode control */
@@ -71,7 +72,7 @@
 #define TX_TIMEOUT_ERROR	BIT(2)
 #define RX_TIMEOUT_ERROR	BIT(3)
 
-#define CSI_MAX_SPI_SCKO	8000000
+#define CSI_MAX_SPI_SCKO	(8 * HZ_PER_MHZ)
 
 struct rzv2m_csi_priv {
 	void __iomem *base;
-- 
2.34.1

