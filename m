Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A13479ADDB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377818AbjIKW2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235716AbjIKJ0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:26:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DA0CA;
        Mon, 11 Sep 2023 02:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694424372; x=1725960372;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QvL+SL9gHty/FSezWrpd62ssnAIuePB7hN7uQnSWCDM=;
  b=vkLD0G2Zep+ieDjFn5TDrzOY1vFKFEMAoOPLBg4f2v8rvHFKdp8j2tOC
   rYrXA+u7k4ll4kenkg9S9+1svBx6+gB2/iDdsqBQmwiks4zoH6zEPx0ob
   ILQx3MshNSxHskRFQyFGYQfElE1TaXz7gtM06Kh5iCM/uL8O4zEVycNRu
   wClP1AhNWgSWf70YC9kz+HdP9kNoZY89WvlzFVZJFJKKkvxY/qHHBQsoR
   FRDEhiDjNV2i7s0z4biUwu+uRJHJzEyVdIquFPP7eOmJ754B1J9f9+/Zh
   N5C1cMF4eIsYiCPhMnw/Gg/1r6rozVqKCLPGzps4+dxGmeEBE/Mw8S/wm
   Q==;
X-CSE-ConnectionGUID: phHXbYbgQ+2foijEDjr92w==
X-CSE-MsgGUID: nmIUrtpoTNO3i/3JAJPbWw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="3955482"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 02:26:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 11 Sep 2023 02:26:03 -0700
Received: from che-lt-i64410lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 11 Sep 2023 02:25:58 -0700
From:   Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>
To:     <linus.walleij@linaro.org>, <dmitry.torokhov@gmail.com>,
        <ulf.hansson@linaro.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <nicolas.ferre@microchip.com>, <aubin.constans@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <hari.prasathge@microchip.com>,
        <balamanikandan.gunasundar@microchip.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] mmc: atmel-mci: Add description for struct member
Date:   Mon, 11 Sep 2023 14:55:40 +0530
Message-ID: <20230911092540.76334-1-balamanikandan.gunasundar@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description for dma filtering function in struct
mci_platform_data. Fixes the warning: Function parameter or member
'dma_filter' not described in 'mci_platform_data'.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309020937.C5S2sRnr-lkp@intel.com/
Signed-off-by: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
---
 drivers/mmc/host/atmel-mci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 535783c43105..33d02a7e72fb 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -227,6 +227,7 @@ struct mci_slot_pdata {
 /**
  * struct mci_platform_data - board-specific MMC/SDcard configuration
  * @dma_slave: DMA slave interface to use in data transfers.
+ * @dma_filter: Filtering function to filter the DMA channel
  * @slot: Per-slot configuration data.
  */
 struct mci_platform_data {
-- 
2.25.1

