Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1271D7FD8C0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbjK2N4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjK2N4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:56:37 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070A6DE;
        Wed, 29 Nov 2023 05:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701266203; x=1732802203;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hei7pXJNKVP4qTlallaoc626BSGQdU10VHphmCZ1qaE=;
  b=Phxi3k2ujMog2Ek76+OslxHqMUmlr8/XuH0P4G6gebDiYPED733L5vwC
   ZUktuKTtYsHRagrFCx9X2nhYClv0uJKDRlgqknGQZffv5uk7MI45lKPcu
   2GOmxJWVgLkkPx+wWnXpfcxfOXgWfmJ1sm3rpaZqFc2f8XlmAo2jY7C4a
   +60qNxcg8hH39Yo98iE5SxCQgaho0le8t+cb4YaJgyf86uQb9hWlbl67C
   Xv6xF8zFJPBEf/dtAJgRP2A1FAj9Vy5lszQx4XeJTsdn4OA/K7EB9dNXF
   iUDRl4ur8TKzI+fu4bNJfBY32vBxEGGUtIF9/I4P52a29fIJ2WBNzwm2H
   g==;
X-CSE-ConnectionGUID: BHQX6+MwTYmhpSKF5vn9xQ==
X-CSE-MsgGUID: bOTPZ+PEQJm/gapsuwWiuQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="13258106"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Nov 2023 06:56:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Nov 2023 06:56:24 -0700
Received: from marius-VM.mshome.net (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Wed, 29 Nov 2023 06:56:22 -0700
From:   <marius.cristea@microchip.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <marius.cristea@microchip.com>
Subject: [PATCH v2] iio: adc: MCP3564: fix hardware identification logic
Date:   Wed, 29 Nov 2023 15:56:19 +0200
Message-ID: <20231129135619.63475-1-marius.cristea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marius Cristea <marius.cristea@microchip.com>

In mcp3564_config() fix the hardware identification logic
based on the hardware ID registers. Second part of the code was
disabled by an logic error.
Fix a typo related to the "MODULE_DESCRIPTION".

Fixes: 33ec3e5fc1ea (iio: adc: adding support for MCP3564 ADC)
Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
---
 drivers/iio/adc/mcp3564.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
index e3f1de5fcc5a..e914a885a868 100644
--- a/drivers/iio/adc/mcp3564.c
+++ b/drivers/iio/adc/mcp3564.c
@@ -1122,7 +1122,7 @@ static int mcp3564_config(struct iio_dev *indio_dev)
 	enum mcp3564_ids ids;
 	int ret = 0;
 	unsigned int tmp = 0x01;
-	bool err = true;
+	bool err = false;
 
 	/*
 	 * The address is set on a per-device basis by fuses in the factory,
@@ -1509,5 +1509,5 @@ static struct spi_driver mcp3564_driver = {
 module_spi_driver(mcp3564_driver);
 
 MODULE_AUTHOR("Marius Cristea <marius.cristea@microchip.com>");
-MODULE_DESCRIPTION("Microchip MCP346x/MCP346xR and MCP356x/MCP346xR ADCs");
+MODULE_DESCRIPTION("Microchip MCP346x/MCP346xR and MCP356x/MCP356xR ADCs");
 MODULE_LICENSE("GPL v2");

base-commit: 6543f376ec8aa90a6c1ed44b765f4f0d6c3eb1db
-- 
2.34.1

