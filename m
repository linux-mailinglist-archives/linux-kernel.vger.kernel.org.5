Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F857D807E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjJZKSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjJZKSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:18:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F96183;
        Thu, 26 Oct 2023 03:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698315500; x=1729851500;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tiJ94SMzePm8CGLJQBB+8e5vPbI81y2Nzad4KmqiHC8=;
  b=jSQlX4Pas5qiXz/UFXotqzGb+0Utk6S3HIDQN3d7uKf8p9sH5+l8llS4
   C0NyfUAFq7XP7Zlk4sWlvbR3soCw2oZDV/lFnyWldtMnAnvJo7uB+0Hbf
   fBPUg6STxGGSH/K8vOKckg1tITADWHBJKn07N2WiuMej461HC0sZ+pJp6
   EBnqpaNXATFj9MUF0iglPQlK+uv2LPPp2vngyt3IPV4P6v5ixUa88A7PJ
   VTly7En72O7mU7IKcennNdpPVVgqLb85B51l32XTmh3JrrR4NAC3Ts8+t
   8KG/rr629IcVCKzfUG7GWLQRR4vpom5UWRnzYgrPVOu0HrRjESaG3HGLS
   w==;
X-CSE-ConnectionGUID: qDRF6jxKTUqq7Gfds2wdJQ==
X-CSE-MsgGUID: fqVwy8rsRWKUZd5aGAleNQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="10631784"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2023 03:18:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 26 Oct 2023 03:17:54 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 26 Oct 2023 03:17:51 -0700
From:   Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To:     <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <andrew@lunn.ch>,
        <Jose.Abreu@synopsys.com>, <linux@armlinux.org.uk>,
        <fancer.lancer@gmail.com>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V2] net: pcs: xpcs: Add 2500BASE-X case in get state for XPCS drivers
Date:   Thu, 26 Oct 2023 15:46:42 +0530
Message-ID: <20231026101642.3913-1-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DW_2500BASEX case in xpcs_get_state( ) to update speed, duplex and pause

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
Change List:                                                                    
============                                                                    
V1 -> V2:
  - Remove the default initialization of speed, pause and duplex

V0 -> V1:                                                                       
  - Remove the auto-negotiation check due to currently the DW_2500BASEX mode    
    doesn't imply any auto-negotiation 

 drivers/net/pcs/pcs-xpcs.c | 25 +++++++++++++++++++++++++
 drivers/net/pcs/pcs-xpcs.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 4dbc21f604f2..392aaad2d412 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1090,6 +1090,24 @@ static int xpcs_get_state_c37_1000basex(struct dw_xpcs *xpcs,
 	return 0;
 }
 
+static int xpcs_get_state_2500basex(struct dw_xpcs *xpcs,
+				    struct phylink_link_state *state)
+{
+	int sts;
+
+	sts = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_STS);
+
+	state->link = !!(sts & DW_VR_MII_MMD_STS_LINK_STS);
+	if (!state->link)
+		return 0;
+
+	state->speed = SPEED_2500;
+	state->pause |= MLO_PAUSE_TX | MLO_PAUSE_RX;
+	state->duplex = DUPLEX_FULL;
+
+	return 0;
+}
+
 static void xpcs_get_state(struct phylink_pcs *pcs,
 			   struct phylink_link_state *state)
 {
@@ -1127,6 +1145,13 @@ static void xpcs_get_state(struct phylink_pcs *pcs,
 			       ERR_PTR(ret));
 		}
 		break;
+	case DW_2500BASEX:
+		ret = xpcs_get_state_2500basex(xpcs, state);
+		if (ret) {
+			pr_err("xpcs_get_state_2500basex returned %pe\n",
+			       ERR_PTR(ret));
+		}
+		break;
 	default:
 		return;
 	}
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 39a90417e535..96c36b32ca99 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -55,6 +55,8 @@
 /* Clause 37 Defines */
 /* VR MII MMD registers offsets */
 #define DW_VR_MII_MMD_CTRL		0x0000
+#define DW_VR_MII_MMD_STS		0x0001
+#define DW_VR_MII_MMD_STS_LINK_STS	BIT(2)
 #define DW_VR_MII_DIG_CTRL1		0x8000
 #define DW_VR_MII_AN_CTRL		0x8001
 #define DW_VR_MII_AN_INTR_STS		0x8002
-- 
2.34.1

