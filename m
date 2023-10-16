Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E3E7CA51E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjJPKRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjJPKQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:16:47 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FB312B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 03:16:26 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39GAGEF1119464;
        Mon, 16 Oct 2023 05:16:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1697451374;
        bh=UZYjBdWAg9JVKmqxPo56hC7NpJy6uWjMu8LlhaZH4UA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FUXyJX1Cc6omp57163Gzol59Z0EpaRrbZo08VDZ0nKLIvTXb0s+6WOhmGDH5kF8UU
         euXG/dRwqtZdMZtplsBIj3tMUHetwHhoAx/HMsULVXLEEX0dtsE/HK8LcKO2AjRLwt
         UikctcxgaqNRQBbmh6Qi2UyjXT8uEmcgJInVoIj4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39GAGEtd040501
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Oct 2023 05:16:14 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Oct 2023 05:16:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Oct 2023 05:16:14 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39GAG90g033447;
        Mon, 16 Oct 2023 05:16:12 -0500
From:   Neha Malcom Francis <n-francis@ti.com>
To:     <nm@ti.com>, <ssantosh@kernel.org>, <t-konduru@ti.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <n-francis@ti.com>,
        <u-kumar1@ti.com>
Subject: [PATCH v3 1/3] soc: ti k3-socinfo: Fix typo
Date:   Mon, 16 Oct 2023 15:46:06 +0530
Message-ID: <20231016101608.993921-2-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016101608.993921-1-n-francis@ti.com>
References: <20231016101608.993921-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in driver that comments out wrong bit.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
No change since v2

 drivers/soc/ti/k3-socinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
index 6ea9b8c7d335..d45f5cb955a6 100644
--- a/drivers/soc/ti/k3-socinfo.c
+++ b/drivers/soc/ti/k3-socinfo.c
@@ -20,7 +20,7 @@
  *  31-28 VARIANT	Device variant
  *  27-12 PARTNO	Part number
  *  11-1  MFG		Indicates TI as manufacturer (0x17)
- *  1			Always 1
+ *  0			Always 1
  */
 #define CTRLMMR_WKUP_JTAGID_VARIANT_SHIFT	(28)
 #define CTRLMMR_WKUP_JTAGID_VARIANT_MASK	GENMASK(31, 28)
-- 
2.34.1

