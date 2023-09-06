Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1D979410B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242952AbjIFQDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242943AbjIFQDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:03:09 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2040.outbound.protection.outlook.com [40.107.13.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483EE19B6;
        Wed,  6 Sep 2023 09:02:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbhxT65Q5DoLvmZgW1J6vtGAKqIh2CGMi7mL/ODBtt71bw3Gp1vp7Dar+Np3gyyqeDLsa/JDAedGdQqP7WNUykrPnE2dV15I4FdCcErBGqZKv0iXkdr58Bm+ViXO7yJX3gVPIUllltoi3VV80LVNUMuPFN6FWM84bW1l5NzNeNbyEW/D9GSic39tkAwYQ7LXVUK+U2kp/1CGHODtHpXiUfDJ7STPO3zYXOPCG+z3UmRFxlG/c6F+FGpUX2oQ1/IVX2tCBUDCGy6yPBbZXaCNK1kV1RI4qFiSy2tbvILh0eN0CERbxuqPoriRMytk/2PpM3RvOMD/tQgYP/c8KOanJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2Wn/tvR1KV8Ik+ceejs9cjh3Q7P7b6whpwPUHS4gsQ=;
 b=Dp3ITncPN70GpIO/1gH3DIzh7MCJ/KFjoHy/mvROIdUYhDszEtKqp3oqMV0o1lx0jeKqg3qeb5W6E3sgicbB2MKuV2X8aIyuYskwbFxFgcwCGl6iDtuH1jv/UMIK2CaXQ+tOv9qAwExtn92U3f5ws3PZMMCp/GjXmKe9kNg8pFjkJjq72s0uGqivE4MLPqbd2k2wtIszHXmgTFoU2lFmiFgMgD80OkPJSuUBwiMJgrpQxXnMxQu7x6ofTwJpAJIZc2FINQKKH1+D8a+cUfIitrnQ6VKxesAm4+XmaYiR1TH3FsBNEyD3nbZ/Pq+GTMQhvnOViPmgPtNNjTPcWGNBSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2Wn/tvR1KV8Ik+ceejs9cjh3Q7P7b6whpwPUHS4gsQ=;
 b=IAUYJqTByXHuV9HbqwA/aQKLJ7+H04DFvFTGJfOGsGOyQyOYSujUSqWTFQLKxkffetF4tld1HuRZzx5LNgMwZs/xYV6/QoOqoSRiJuJDlKj26riIilcrRyUInGuhDM/b6KsPG3ydliqJ5QEVLo5wydAyPfaA1v4lj9drYBe3dKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8958.eurprd04.prod.outlook.com (2603:10a6:102:20d::11)
 by AS1PR04MB9429.eurprd04.prod.outlook.com (2603:10a6:20b:4db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 16:02:34 +0000
Received: from PAXPR04MB8958.eurprd04.prod.outlook.com
 ([fe80::d7c:390a:4105:65ee]) by PAXPR04MB8958.eurprd04.prod.outlook.com
 ([fe80::d7c:390a:4105:65ee%6]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 16:02:34 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [RFC net-next v3 4/6] net: phy: nxp-c45-tja11xx: add MACsec support
Date:   Wed,  6 Sep 2023 19:01:32 +0300
Message-Id: <20230906160134.311993-5-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906160134.311993-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230906160134.311993-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::17) To PAXPR04MB8958.eurprd04.prod.outlook.com
 (2603:10a6:102:20d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8958:EE_|AS1PR04MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: 987281ea-53a8-44c3-aaf7-08dbaef2ae1c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a2tv0/cRRRuC0sdCC8co1dU93WWQ9rbqzjpLV/maebJQUTyRvKOuFLBENLjfUB6TfpxC/80sql2L2mCo3eRd//clTp1bz8upXlbh/d1BsDQVPTOLWKXZokGs9aCFCw/JToAd/wIKlQ4wsMuPQ0DgQL3y2rA0l/QXe9J/Swlnq4AV0Jn7oEaBWFUGTwGeWXo21DABkcr+l+CoA3hFwbn+7DsnUe0+5S16TD6ltekpvO+8r+1WatdyJalzft/vBKDPE65k6o6bifFUJOzzUBH0at8ldJTrjF0x9BhosdwLkPnDPdNfJaQaPdLfaqi0EyIIejgfhAIEjRN22ASRC+haj2gKamsEcYHP5Q2AuvNTVYo9va2DOYtcmSmWnXXjj26cvxhBktpUMoGBPwz1+ZAuC1ZOeirnahbWXAlpnRF4MeC6v4Mr8J3ucyR5GyxVlAKE+cNy+refIKnCmeTp5Yuvs/BbOQfYaUIIwZtu+qrhl7NHYpr5UW3kPb2/JG2ZyuSJt7KZSIDoP2frrWwSt7YRWHi4WMMHRH0JbrV3IMGbDFwnsfvUVnboQjowhc9UEHJt9imnTxRo89Em4f4NWsiWfkX3xq9I3Rwhb6t4cB+1OEbW4Gq0uuP8fHypvp75EMuDF5iZG1rWeXxkGMCMeb0oPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8958.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(41300700001)(7416002)(921005)(38350700002)(86362001)(2616005)(478600001)(83380400001)(26005)(6512007)(1076003)(6486002)(6506007)(52116002)(38100700002)(66476007)(66556008)(66946007)(316002)(2906002)(30864003)(8936002)(5660300002)(4326008)(8676002)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?igeCNpZ94T8T9Jg8yvzi2aNgdF19LvsSHK5exAnVK7BpClmhwBLCPRuLucmR?=
 =?us-ascii?Q?HowVrvaZrY6/eZOztc5OS0sAbT3dSI2Pso4Nzla1b/krsWD2z2SP1PvOUlBS?=
 =?us-ascii?Q?pvdfV539FdroPAivIvT6aak/1yBHw0HMK3wFg6ADg4KK1qvZ+dzgg3GsH0Jq?=
 =?us-ascii?Q?za3BI1PhL7PSULe1BSQ4CpE7NPYP0pZ93UgH0C/BY1RBTawnQlFco2LEEcSl?=
 =?us-ascii?Q?Kt4jCukxbDTtzZz9QS+YXqwHwSAvIHAcKt966lafvuvD5rIao8zzgOCOaX9S?=
 =?us-ascii?Q?Ot2zbT93kP0qaYNIUGPZYwCef6lG+2SOi8imYV7KDwDHQTerNcGGCYp8/U9v?=
 =?us-ascii?Q?t0fMoFV4MLbROw+2VP+kKhSfwt+tmy2JYcJkgh1Flk6kxrO4BRPbqxT14GvD?=
 =?us-ascii?Q?rrMvlKRjq5pYBDkmVNC1tzCsfIWo5WbS3o2KUt5ke6f/6fZkIIGkOgHZB1IU?=
 =?us-ascii?Q?KD+uc6/J+6f4cVq9R0DWLJ5nyJjp04QUiJnSE9XO09bmPTUfl+zPe42Nb7Dr?=
 =?us-ascii?Q?x9ifBI8HLO5i9geza21kzsNuFw+EFNF4xxt9xXQWEoXIgiq8pdVcyv0mE8IL?=
 =?us-ascii?Q?qSF0yjkgznfKvSbAOAvPR4qmkt7onIJAUX6UeARpIUJ5upQI6GNxMoEl57J4?=
 =?us-ascii?Q?nwpjHK/XMzRcXnxin89L4erCW6XGBKRtiNuFWpx3vfbrHqjXsQoFCDneFK5J?=
 =?us-ascii?Q?itGXMdiDOrO6gZ7fkNbAxbrcu0jThvzgiR38NrFYtrK99JAO2vO+YlV5LrRu?=
 =?us-ascii?Q?YpnEiudIeFioftUp12w+1x6Xy1RwHgUPzODFnkd/bfLbtG73WvqIwnzU6J+C?=
 =?us-ascii?Q?YCAs0uwN3/Ie1cenJ3mpa6IeP2sFVlDTAeD6A7X7/E3OhiQzQG57eZrqzAdK?=
 =?us-ascii?Q?sKbxfxDaqgsBTvbs300eE6mdaitg+f/WxqhY4LcYEX+xlL5jzhujVW4+nZ/5?=
 =?us-ascii?Q?YHiJswHQ/sbLXcI+Rvj5bBQrB4bjWiZ87TS6grsvBcR77r1nVB7rOK+Jf5cR?=
 =?us-ascii?Q?woggqVMsQ3mY5YPeO1bUjAy7+naff8pqVK8TrEUTrKkQ7Z25dRHWp4yGqgND?=
 =?us-ascii?Q?bBLR7tmoN076XUCED97ggHMQXk5eOpSVjwbE54uDT/eqIxuLX+dRn4IcHsYt?=
 =?us-ascii?Q?E1Cb9v0Z1Bzv0OoI36/mz3+1jNulXG1jxBFYo1RuzJEr7cFtKMHIgmOtictr?=
 =?us-ascii?Q?6LMv65rYXXe34Xour3lH4QZJF2LLi8MS8Vs3H3Zh2qBi0RIdWp1fdBQdylrt?=
 =?us-ascii?Q?QR8dPRXxMr8z2wOoL3LHHgR9vIKdrdE9y/8BvWBkVZbc3fSpunfzw0VnJfEE?=
 =?us-ascii?Q?+6Lbbez0nTRqq8LdC+Oct+wF5E6HvKcUhohXHTYMGVWTKyb0oVda37DOmSoL?=
 =?us-ascii?Q?Vaab7uJDWnTIMGuCf3ID8AVGgRnhxwTpGALlnIYKntZO/BqakdtfuSsGF+7v?=
 =?us-ascii?Q?FJ9DYAfepUedctVsdPU56QAujfB+xN8vIdHB2cp1hn6LDWifGKK1YYVVGr/F?=
 =?us-ascii?Q?/7OPL3mVp+TLfk/W0MXkfWxB1yFu05jbDq7y01TSWn1kVgdtyTmZIIt9c7KR?=
 =?us-ascii?Q?Jr1Hsxntycaq7BJQgWknQekGrO5fHEVIUIO8Z87RMqOqZ6hUPUg+2mINhMXH?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 987281ea-53a8-44c3-aaf7-08dbaef2ae1c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8958.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 16:02:33.8958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbVID+YcrzH48GMAV5eAhZjL9orKO0lTd8cMx1b9eP5OiME69ArLsxHddxNgRxY55Q99qNM+6pw+y44enDPffWdeZq/+Gf4L2+dRk2GrN/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9429
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MACsec support.
The MACsec block has four TX SCs and four RX SCs. The driver supports up
to four SecY. Each SecY with one TX SC and one RX SC.
The RX SCs can have two keys, key A and key B, written in hardware and
enabled at the same time.
The TX SCs can have two keys written in hardware, but only one can be
active at a given time.
On TX, the SC is selected using the MAC source address. Due of this
selection mechanism, each offloaded netdev must have a unique MAC
address.
On RX, the SC is selected by SCI(found in SecTAG or calculated using MAC
SA), or using RX SC 0 as implicit.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---

Changes in v3:
- removed struct nxp_c45_rx_sc
- replaced struct nxp_c45_tx_sa with struct nxp_c45_sa
- reworked the implementation around struct nxp_c45_sa
- various renamings
- tried to better group the functions by SA type/SC type
- no key is stored in the driver
- TX SAs limited to 2 insted of 4(no key in the driver consequence)
- used sci_to_cpu where in various functions
- improved debug information
- nxp_c45_secy_valid function reworked
- merged TX/RX SA set key functions
- merged TX/RX SA set pn functions
- tried to stick to tx_sa/rx_sa/rx_sc/tx_sc function naming. 
- nxp_c45_macsec_config_init will return an error if a write fails.
- MACSEC_TXSC_CFG_SCI renamed to MACSEC_TXSC_CFG_SCB
- return -ENOSPC if no SC/SA available in the hardware
- phydev->macsec_ops allocated using devm_kzalloc
- changed name of the driver object file

Changes in v2:
- WARN_ON_ONCE if reg address is not properly aligned
- improved patch description

 MAINTAINERS                              |    2 +-
 drivers/net/phy/Kconfig                  |    2 +-
 drivers/net/phy/Makefile                 |    6 +-
 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 1307 ++++++++++++++++++++++
 drivers/net/phy/nxp-c45-tja11xx.c        |   74 +-
 drivers/net/phy/nxp-c45-tja11xx.h        |   56 +
 6 files changed, 1415 insertions(+), 32 deletions(-)
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx-macsec.c
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 612d6d1dbf36..e43cf13dc8e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15229,7 +15229,7 @@ NXP C45 TJA11XX PHY DRIVER
 M:	Radu Pirea <radu-nicolae.pirea@oss.nxp.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	drivers/net/phy/nxp-c45-tja11xx.c
+F:	drivers/net/phy/nxp-c45-tja11xx*
 
 NXP FSPI DRIVER
 M:	Han Xu <han.xu@nxp.com>
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 107880d13d21..79f54f773af2 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -306,7 +306,7 @@ config NXP_C45_TJA11XX_PHY
 	depends on PTP_1588_CLOCK_OPTIONAL
 	help
 	  Enable support for NXP C45 TJA11XX PHYs.
-	  Currently supports the TJA1103 and TJA1120 PHYs.
+	  Currently supports the TJA1103, TJA1104 and TJA1120 PHYs.
 
 config NXP_TJA11XX_PHY
 	tristate "NXP TJA11xx PHYs support"
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index c945ed9bd14b..62b42f0d6a85 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -83,7 +83,11 @@ obj-$(CONFIG_MICROSEMI_PHY)	+= mscc/
 obj-$(CONFIG_MOTORCOMM_PHY)	+= motorcomm.o
 obj-$(CONFIG_NATIONAL_PHY)	+= national.o
 obj-$(CONFIG_NCN26000_PHY)	+= ncn26000.o
-obj-$(CONFIG_NXP_C45_TJA11XX_PHY)	+= nxp-c45-tja11xx.o
+nxp-c45-tja-objs		+= nxp-c45-tja11xx.o
+ifdef CONFIG_MACSEC
+nxp-c45-tja-objs		+= nxp-c45-tja11xx-macsec.o
+endif
+obj-$(CONFIG_NXP_C45_TJA11XX_PHY)	+= nxp-c45-tja.o
 obj-$(CONFIG_NXP_CBTX_PHY)	+= nxp-cbtx.o
 obj-$(CONFIG_NXP_TJA11XX_PHY)	+= nxp-tja11xx.o
 obj-$(CONFIG_QSEMI_PHY)		+= qsemi.o
diff --git a/drivers/net/phy/nxp-c45-tja11xx-macsec.c b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
new file mode 100644
index 000000000000..4a403d6ad75d
--- /dev/null
+++ b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
@@ -0,0 +1,1307 @@
+// SPDX-License-Identifier: GPL-2.0
+/* NXP C45 PTP PHY driver interface
+ * Copyright 2023 NXP
+ * Author: Radu Pirea <radu-nicolae.pirea@oss.nxp.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/ethtool_netlink.h>
+#include <linux/kernel.h>
+#include <linux/mii.h>
+#include <linux/module.h>
+#include <linux/phy.h>
+#include <linux/processor.h>
+#include <net/macsec.h>
+
+#include "nxp-c45-tja11xx.h"
+
+#define MACSEC_REG_SIZE			32
+#define TX_SC_MAX			4
+
+#define TX_SC_BIT(secy_id)		BIT(MACSEC_REG_SIZE - (secy_id) - 1)
+
+#define VEND1_MACSEC_BASE		0x9000
+
+#define MACSEC_CFG			0x0000
+#define MACSEC_CFG_BYPASS		BIT(1)
+#define MACSEC_CFG_S0I			BIT(0)
+
+#define MACSEC_TPNET			0x0044
+#define PN_WRAP_THRESHOLD		0xffffffff
+
+#define MACSEC_RXSCA			0x0080
+#define MACSEC_RXSCKA			0x0084
+
+#define MACSEC_TXSCA			0x00C0
+#define MACSEC_TXSCKA			0x00C4
+
+#define MACSEC_RXSC_SCI_1H		0x0100
+
+#define MACSEC_RXSC_CFG			0x0128
+#define MACSEC_RXSC_CFG_XPN		BIT(25)
+#define MACSEC_RXSC_CFG_AES_256		BIT(24)
+#define MACSEC_RXSC_CFG_SCI_EN		BIT(11)
+#define MACSEC_RXSC_CFG_RP		BIT(10)
+#define MACSEC_RXSC_CFG_VF_MASK		GENMASK(9, 8)
+#define MACSEC_RXSC_CFG_VF_OFF		8
+
+#define MACSEC_RPW			0x012C
+
+#define MACSEC_RXSA_A_CS		0x0180
+#define MACSEC_RXSA_A_NPN		0x0184
+#define MACSEC_RXSA_A_XNPN		0x0188
+#define MACSEC_RXSA_A_LNPN		0x018C
+#define MACSEC_RXSA_A_LXNPN		0x0190
+
+#define MACSEC_RXSA_B_CS		0x01C0
+#define MACSEC_RXSA_B_NPN		0x01C4
+#define MACSEC_RXSA_B_XNPN		0x01C8
+#define MACSEC_RXSA_B_LNPN		0x01CC
+#define MACSEC_RXSA_B_LXNPN		0x01D0
+
+#define MACSEC_RXSA_CS_AN_OFF		1
+#define MACSEC_RXSA_CS_EN		BIT(0)
+
+#define MACSEC_TXSC_SCI_1H		0x0200
+#define MACSEC_TXSC_CFG			0x0228
+#define MACSEC_TXSC_CFG_XPN		BIT(25)
+#define MACSEC_TXSC_CFG_AES_256		BIT(24)
+#define MACSEC_TXSC_CFG_AN_MASK		GENMASK(19, 18)
+#define MACSEC_TXSC_CFG_AN_OFF		18
+#define MACSEC_TXSC_CFG_ASA		BIT(17)
+#define MACSEC_TXSC_CFG_SCE		BIT(16)
+#define MACSEC_TXSC_CFG_ENCRYPT		BIT(4)
+#define MACSEC_TXSC_CFG_PROTECT		BIT(3)
+#define MACSEC_TXSC_CFG_SEND_SCI	BIT(2)
+#define MACSEC_TXSC_CFG_END_STATION	BIT(1)
+#define MACSEC_TXSC_CFG_SCB		BIT(0)
+
+#define MACSEC_TXSA_A_CS		0x0280
+#define MACSEC_TXSA_A_NPN		0x0284
+#define MACSEC_TXSA_A_XNPN		0x0288
+
+#define MACSEC_TXSA_B_CS		0x02C0
+#define MACSEC_TXSA_B_NPN		0x02C4
+#define MACSEC_TXSA_B_XNPN		0x02C8
+
+#define MACSEC_SA_CS_A			BIT(31)
+
+#define MACSEC_EVR			0x0400
+#define MACSEC_EVER			0x0404
+
+#define MACSEC_RXSA_A_KA		0x0700
+#define MACSEC_RXSA_A_SSCI		0x0720
+#define MACSEC_RXSA_A_SALT		0x0724
+
+#define MACSEC_RXSA_B_KA		0x0740
+#define MACSEC_RXSA_B_SSCI		0x0760
+#define MACSEC_RXSA_B_SALT		0x0764
+
+#define MACSEC_TXSA_A_KA		0x0780
+#define MACSEC_TXSA_A_SSCI		0x07A0
+#define MACSEC_TXSA_A_SALT		0x07A4
+
+#define MACSEC_TXSA_B_KA		0x07C0
+#define MACSEC_TXSA_B_SSCI		0x07E0
+#define MACSEC_TXSA_B_SALT		0x07E4
+
+#define MACSEC_UPFR0D2			0x0A08
+#define MACSEC_UPFR0M1			0x0A10
+#define MACSEC_OVP			BIT(12)
+
+#define	MACSEC_UPFR0M2			0x0A14
+#define ETYPE_MASK			0xffff
+
+#define MACSEC_UPFR0R			0x0A18
+#define MACSEC_UPFR_EN			BIT(0)
+
+#define ADPTR_CNTRL			0x0F00
+#define ADPTR_CNTRL_CONFIG_EN		BIT(14)
+#define ADPTR_CNTRL_ADPTR_EN		BIT(12)
+
+#define TX_SC_FLT_BASE			0x800
+#define TX_SC_FLT_SIZE			0x10
+#define TX_FLT_BASE(flt_id)		(TX_SC_FLT_BASE + \
+	TX_SC_FLT_SIZE * (flt_id))
+
+#define TX_SC_FLT_OFF_MAC_DA_SA		0x04
+#define TX_SC_FLT_OFF_MAC_SA		0x08
+#define TX_SC_FLT_OFF_MAC_CFG		0x0C
+#define TX_SC_FLT_BY_SA			BIT(14)
+#define TX_SC_FLT_EN			BIT(8)
+
+#define TX_SC_FLT_MAC_DA_SA(base)	((base) + TX_SC_FLT_OFF_MAC_DA_SA)
+#define TX_SC_FLT_MAC_SA(base)		((base) + TX_SC_FLT_OFF_MAC_SA)
+#define TX_SC_FLT_MAC_CFG(base)		((base) + TX_SC_FLT_OFF_MAC_CFG)
+
+#define ADAPTER_EN	BIT(6)
+#define MACSEC_EN	BIT(5)
+
+enum nxp_c45_sa_type {
+	TX_SA,
+	RX_SA,
+};
+
+struct nxp_c45_sa {
+	void *sa;
+	const struct nxp_c45_sa_regs *regs;
+	enum nxp_c45_sa_type type;
+	bool is_key_a;
+	u8 an;
+	struct list_head list;
+};
+
+struct nxp_c45_secy {
+	struct macsec_secy *secy;
+	struct macsec_rx_sc *rx_sc;
+	struct list_head sa_list;
+	int secy_id;
+	bool rx_sc0_impl;
+	struct list_head list;
+};
+
+struct nxp_c45_macsec {
+	struct list_head secy_list;
+	DECLARE_BITMAP(secy_bitmap, TX_SC_MAX);
+	DECLARE_BITMAP(tx_sc_bitmap, TX_SC_MAX);
+};
+
+struct nxp_c45_sa_regs {
+	u16 cs;
+	u16 npn;
+	u16 xnpn;
+	u16 lnpn;
+	u16 lxnpn;
+	u16 ka;
+	u16 ssci;
+	u16 salt;
+};
+
+static const struct nxp_c45_sa_regs rx_sa_a_regs = {
+	.cs	= MACSEC_RXSA_A_CS,
+	.npn	= MACSEC_RXSA_A_NPN,
+	.xnpn	= MACSEC_RXSA_A_XNPN,
+	.lnpn	= MACSEC_RXSA_A_LNPN,
+	.lxnpn	= MACSEC_RXSA_A_LXNPN,
+	.ka	= MACSEC_RXSA_A_KA,
+	.ssci	= MACSEC_RXSA_A_SSCI,
+	.salt	= MACSEC_RXSA_A_SALT,
+};
+
+static const struct nxp_c45_sa_regs rx_sa_b_regs = {
+	.cs	= MACSEC_RXSA_B_CS,
+	.npn	= MACSEC_RXSA_B_NPN,
+	.xnpn	= MACSEC_RXSA_B_XNPN,
+	.lnpn	= MACSEC_RXSA_B_LNPN,
+	.lxnpn	= MACSEC_RXSA_B_LXNPN,
+	.ka	= MACSEC_RXSA_B_KA,
+	.ssci	= MACSEC_RXSA_B_SSCI,
+	.salt	= MACSEC_RXSA_B_SALT,
+};
+
+static const struct nxp_c45_sa_regs tx_sa_a_regs = {
+	.cs	= MACSEC_TXSA_A_CS,
+	.npn	= MACSEC_TXSA_A_NPN,
+	.xnpn	= MACSEC_TXSA_A_XNPN,
+	.ka	= MACSEC_TXSA_A_KA,
+	.ssci	= MACSEC_TXSA_A_SSCI,
+	.salt	= MACSEC_TXSA_A_SALT,
+};
+
+static const struct nxp_c45_sa_regs tx_sa_b_regs = {
+	.cs	= MACSEC_TXSA_B_CS,
+	.npn	= MACSEC_TXSA_B_NPN,
+	.xnpn	= MACSEC_TXSA_B_XNPN,
+	.ka	= MACSEC_TXSA_B_KA,
+	.ssci	= MACSEC_TXSA_B_SSCI,
+	.salt	= MACSEC_TXSA_B_SALT,
+};
+
+static const
+struct nxp_c45_sa_regs *nxp_c45_sa_regs_get(enum nxp_c45_sa_type sa_type,
+					    bool key_a)
+{
+	if (sa_type == RX_SA)
+		if (key_a)
+			return &rx_sa_a_regs;
+		else
+			return &rx_sa_b_regs;
+	else if (sa_type == TX_SA)
+		if (key_a)
+			return &tx_sa_a_regs;
+		else
+			return &tx_sa_b_regs;
+	else
+		return NULL;
+}
+
+static int nxp_c45_macsec_write(struct phy_device *phydev, u16 addr, u32 value)
+{
+	u32 lvalue = value;
+	u16 laddr;
+	int ret;
+
+	WARN_ON_ONCE(addr % 4);
+
+	phydev_dbg(phydev, "write addr 0x%x value 0x%x\n", addr, value);
+
+	laddr = VEND1_MACSEC_BASE + addr / 2;
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, laddr, lvalue);
+	if (ret)
+		return ret;
+
+	laddr += 1;
+	lvalue >>= 16;
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, laddr, lvalue);
+
+	return ret;
+}
+
+static int nxp_c45_macsec_read(struct phy_device *phydev, u16 addr, u32 *value)
+{
+	u32 lvalue;
+	u16 laddr;
+	int ret;
+
+	WARN_ON_ONCE(addr % 4);
+
+	laddr = VEND1_MACSEC_BASE + addr / 2;
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, laddr);
+	if (ret < 0)
+		return ret;
+
+	laddr += 1;
+	lvalue = (u32)ret & 0xffff;
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, laddr);
+	if (ret < 0)
+		return ret;
+
+	lvalue |= (u32)ret << 16;
+	*value = lvalue;
+
+	phydev_dbg(phydev, "read addr 0x%x value 0x%x\n", addr, *value);
+
+	return 0;
+}
+
+static struct nxp_c45_secy *nxp_c45_find_secy(struct list_head *secy_list,
+					      sci_t sci)
+{
+	struct nxp_c45_secy *pos, *tmp;
+
+	list_for_each_entry_safe(pos, tmp, secy_list, list)
+		if (pos->secy->sci == sci)
+			return pos;
+
+	return ERR_PTR(-EINVAL);
+}
+
+static struct nxp_c45_sa *nxp_c45_find_sa(struct list_head *sa_list,
+					  enum nxp_c45_sa_type sa_type, u8 an)
+{
+	struct nxp_c45_sa *pos, *tmp;
+
+	list_for_each_entry_safe(pos, tmp, sa_list, list)
+		if (pos->an == an && pos->type == sa_type)
+			return pos;
+
+	return ERR_PTR(-EINVAL);
+}
+
+static struct nxp_c45_sa *nxp_c45_sa_alloc(struct list_head *sa_list, void *sa,
+					   enum nxp_c45_sa_type sa_type, u8 an)
+{
+	struct nxp_c45_sa *first = NULL, *pos, *tmp;
+	int ocurences = 0;
+
+	list_for_each_entry_safe(pos, tmp, sa_list, list) {
+		if (pos->type != sa_type)
+			continue;
+
+		if (pos->an == an)
+			return ERR_PTR(-EINVAL);
+
+		first = pos;
+		ocurences++;
+		if (ocurences >= 2)
+			return ERR_PTR(-ENOSPC);
+	}
+
+	tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
+	if (!tmp)
+		return ERR_PTR(-ENOMEM);
+
+	if (first)
+		tmp->is_key_a = !first->is_key_a;
+	else
+		tmp->is_key_a = true;
+
+	tmp->sa = sa;
+	tmp->type = sa_type;
+	tmp->an = an;
+	tmp->regs = nxp_c45_sa_regs_get(tmp->type, tmp->is_key_a);
+	list_add_tail(&tmp->list, sa_list);
+
+	return tmp;
+}
+
+static void nxp_c45_sa_free(struct nxp_c45_sa *sa)
+{
+	list_del(&sa->list);
+	kfree_sensitive(sa);
+}
+
+static void nxp_c45_sa_list_free(struct list_head *sa_list)
+{
+	struct nxp_c45_sa *pos, *tmp;
+
+	list_for_each_entry_safe(pos, tmp, sa_list, list)
+		nxp_c45_sa_free(pos);
+}
+
+static void nxp_c45_sa_set_pn(struct phy_device *phydev,
+			      struct nxp_c45_sa *sa, u64 pn,
+			      u32 replay_window)
+{
+	const struct nxp_c45_sa_regs *sa_regs = sa->regs;
+	pn_t npn = {.full64 = pn};
+	pn_t lnpn;
+
+	if (!pn)
+		return;
+
+	nxp_c45_macsec_write(phydev, sa_regs->npn, npn.lower);
+	nxp_c45_macsec_write(phydev, sa_regs->xnpn, npn.upper);
+	if (sa->type != RX_SA)
+		return;
+
+	if (pn > replay_window)
+		lnpn.full64 = pn - replay_window;
+	else
+		lnpn.full64 = 1;
+
+	nxp_c45_macsec_write(phydev, sa_regs->lnpn, lnpn.lower);
+	nxp_c45_macsec_write(phydev, sa_regs->lxnpn, lnpn.upper);
+}
+
+static void nxp_c45_sa_set_key(struct macsec_context *ctx,
+			       const struct nxp_c45_sa_regs *sa_regs,
+			       u8 *salt, ssci_t ssci)
+{
+	struct phy_device *phydev = ctx->phydev;
+	u32 key_size = ctx->secy->key_len / 4;
+	u32 salt_size = MACSEC_SALT_LEN / 4;
+	u32 *key_u32 = (u32 *)ctx->sa.key;
+	u32 *salt_u32 = (u32 *)salt;
+	u32 reg, value;
+	int i;
+
+	for (i = 0; i < key_size; i++) {
+		reg = sa_regs->ka + i * 4;
+		value = (__force u32)cpu_to_be32(key_u32[i]);
+		nxp_c45_macsec_write(phydev, reg, value);
+	}
+
+	if (ctx->secy->xpn) {
+		for (i = 0; i < salt_size; i++) {
+			reg = sa_regs->salt + (2 - i) * 4;
+			value = (__force u32)cpu_to_be32(salt_u32[i]);
+			nxp_c45_macsec_write(phydev, reg, value);
+		}
+
+		value = (__force u32)cpu_to_be32((__force u32)ssci);
+		nxp_c45_macsec_write(phydev, sa_regs->ssci, value);
+	}
+
+	nxp_c45_macsec_write(ctx->phydev, sa_regs->cs, MACSEC_SA_CS_A);
+}
+
+static void nxp_c45_rx_sa_update(struct phy_device *phydev,
+				 struct nxp_c45_sa *sa, bool en)
+{
+	const struct nxp_c45_sa_regs *sa_regs = sa->regs;
+	u32 cfg;
+
+	cfg = sa->an << MACSEC_RXSA_CS_AN_OFF;
+	cfg |= en ? MACSEC_RXSA_CS_EN : 0;
+	nxp_c45_macsec_write(phydev, sa_regs->cs, cfg);
+}
+
+static void nxp_c45_tx_sa_update(struct phy_device *phydev,
+				 struct nxp_c45_sa *sa, u8 encoding_sa,
+				 bool en)
+{
+	u32 cfg = 0;
+
+	if (sa->an != encoding_sa)
+		return;
+
+	nxp_c45_macsec_read(phydev, MACSEC_TXSC_CFG, &cfg);
+
+	cfg &= ~MACSEC_TXSC_CFG_AN_MASK;
+	cfg |= sa->an << MACSEC_TXSC_CFG_AN_OFF;
+
+	if (sa->is_key_a)
+		cfg &= ~MACSEC_TXSC_CFG_ASA;
+	else
+		cfg |= MACSEC_TXSC_CFG_ASA;
+
+	if (en)
+		cfg |= MACSEC_TXSC_CFG_SCE;
+	else
+		cfg &= ~MACSEC_TXSC_CFG_SCE;
+
+	nxp_c45_macsec_write(phydev, MACSEC_TXSC_CFG, cfg);
+}
+
+static void nxp_c45_set_sci(struct phy_device *phydev, u16 sci_base_addr,
+			    sci_t sci)
+{
+	u64 lsci = sci_to_cpu(sci);
+
+	nxp_c45_macsec_write(phydev, sci_base_addr, lsci >> 32);
+	nxp_c45_macsec_write(phydev, sci_base_addr + 4, lsci);
+}
+
+static bool nxp_c45_sci_valid(sci_t sci, bool scb)
+{
+	u16 port = sci_to_cpu(sci);
+
+	if (scb && port != 0)
+		return false;
+	if (!scb && port != 1)
+		return false;
+
+	return true;
+}
+
+static void nxp_c45_select_secy(struct phy_device *phydev, u8 id)
+{
+	nxp_c45_macsec_write(phydev, MACSEC_RXSCA, id);
+	nxp_c45_macsec_write(phydev, MACSEC_RXSCKA, id);
+	nxp_c45_macsec_write(phydev, MACSEC_TXSCA, id);
+	nxp_c45_macsec_write(phydev, MACSEC_TXSCKA, id);
+}
+
+static bool nxp_c45_secy_valid(struct nxp_c45_secy *phy_secy,
+			       bool can_rx_sc0_impl)
+{
+	bool end_station = phy_secy->secy->tx_sc.end_station;
+	bool send_sci = phy_secy->secy->tx_sc.send_sci;
+	bool scb = phy_secy->secy->tx_sc.scb;
+	bool rx_sci_valid, tx_sci_valid;
+	sci_t sci = phy_secy->secy->sci;
+
+	phy_secy->rx_sc0_impl = false;
+
+	if (send_sci) {
+		if (end_station || scb)
+			return false;
+		else
+			return true;
+	}
+
+	if (end_station) {
+		tx_sci_valid = nxp_c45_sci_valid(sci, scb);
+		if (phy_secy->rx_sc) {
+			sci = phy_secy->rx_sc->sci;
+			rx_sci_valid = nxp_c45_sci_valid(sci, scb);
+		} else {
+			rx_sci_valid = true;
+		}
+
+		return tx_sci_valid && rx_sci_valid;
+	}
+
+	if (scb)
+		return false;
+
+	if (!can_rx_sc0_impl)
+		return false;
+
+	if (phy_secy->secy_id != 0)
+		return false;
+
+	phy_secy->rx_sc0_impl = true;
+
+	return true;
+}
+
+static bool nxp_c45_mac_addr_free(struct macsec_context *ctx)
+{
+	struct nxp_c45_phy *priv = ctx->phydev->priv;
+	struct nxp_c45_secy *pos, *tmp;
+
+	list_for_each_entry_safe(pos, tmp, &priv->macsec->secy_list, list) {
+		if (pos->secy == ctx->secy)
+			continue;
+
+		if (memcmp(pos->secy->netdev->dev_addr,
+			   ctx->secy->netdev->dev_addr, ETH_ALEN) == 0)
+			return false;
+	}
+
+	return true;
+}
+
+static void nxp_c45_tx_sc_en_flt(struct phy_device *phydev, int secy_id,
+				 bool en)
+{
+	u32 tx_flt_base = TX_FLT_BASE(secy_id);
+	u32 reg = 0;
+
+	nxp_c45_macsec_read(phydev, TX_SC_FLT_MAC_CFG(tx_flt_base), &reg);
+	if (en)
+		reg |= TX_SC_FLT_EN;
+	else
+		reg &= ~TX_SC_FLT_EN;
+	nxp_c45_macsec_write(phydev, TX_SC_FLT_MAC_CFG(tx_flt_base), reg);
+}
+
+static void nxp_c45_tx_sc_set_flt(struct macsec_context *ctx,  int secy_id)
+{
+	const u8 *dev_addr = ctx->secy->netdev->dev_addr;
+	struct phy_device *phydev = ctx->phydev;
+	u32 tx_flt_base = TX_FLT_BASE(secy_id);
+	u32 reg;
+
+	reg = dev_addr[0] << 8 | dev_addr[1];
+	nxp_c45_macsec_write(phydev, TX_SC_FLT_MAC_DA_SA(tx_flt_base), reg);
+	reg = dev_addr[5] | dev_addr[4] << 8 | dev_addr[3] << 16 |
+		dev_addr[2] << 24;
+
+	nxp_c45_macsec_write(phydev, TX_SC_FLT_MAC_SA(tx_flt_base), reg);
+	nxp_c45_macsec_read(phydev, TX_SC_FLT_MAC_CFG(tx_flt_base), &reg);
+	reg &= TX_SC_FLT_EN;
+	reg |= TX_SC_FLT_BY_SA | secy_id;
+	nxp_c45_macsec_write(phydev, TX_SC_FLT_MAC_CFG(tx_flt_base), reg);
+}
+
+static void nxp_c45_tx_sc_update(struct phy_device *phydev,
+				 struct nxp_c45_secy *phy_secy)
+{
+	u32 cfg = 0;
+
+	nxp_c45_macsec_read(phydev, MACSEC_TXSC_CFG, &cfg);
+
+	phydev_dbg(phydev, "XPN %s\n", phy_secy->secy->xpn ? "on" : "off");
+	if (phy_secy->secy->xpn)
+		cfg |= MACSEC_TXSC_CFG_XPN;
+	else
+		cfg &= ~MACSEC_TXSC_CFG_XPN;
+
+	phydev_dbg(phydev, "key len %u\n", phy_secy->secy->key_len);
+	if (phy_secy->secy->key_len == 32)
+		cfg |= MACSEC_TXSC_CFG_AES_256;
+	else
+		cfg &= ~MACSEC_TXSC_CFG_AES_256;
+
+	phydev_dbg(phydev, "encryption %s\n",
+		   phy_secy->secy->tx_sc.encrypt ? "on" : "off");
+	if (phy_secy->secy->tx_sc.encrypt)
+		cfg |= MACSEC_TXSC_CFG_ENCRYPT;
+	else
+		cfg &= ~MACSEC_TXSC_CFG_ENCRYPT;
+
+	phydev_dbg(phydev, "protect frames %s\n",
+		   phy_secy->secy->protect_frames ? "on" : "off");
+	if (phy_secy->secy->protect_frames)
+		cfg |= MACSEC_TXSC_CFG_PROTECT;
+	else
+		cfg &= ~MACSEC_TXSC_CFG_PROTECT;
+
+	phydev_dbg(phydev, "send sci %s\n",
+		   phy_secy->secy->tx_sc.send_sci ? "on" : "off");
+	if (phy_secy->secy->tx_sc.send_sci)
+		cfg |= MACSEC_TXSC_CFG_SEND_SCI;
+	else
+		cfg &= ~MACSEC_TXSC_CFG_SEND_SCI;
+
+	phydev_dbg(phydev, "end station %s\n",
+		   phy_secy->secy->tx_sc.end_station ? "on" : "off");
+	if (phy_secy->secy->tx_sc.end_station)
+		cfg |= MACSEC_TXSC_CFG_END_STATION;
+	else
+		cfg &= ~MACSEC_TXSC_CFG_END_STATION;
+
+	phydev_dbg(phydev, "scb %s\n",
+		   phy_secy->secy->tx_sc.scb ? "on" : "off");
+	if (phy_secy->secy->tx_sc.scb)
+		cfg |= MACSEC_TXSC_CFG_SCB;
+	else
+		cfg &= ~MACSEC_TXSC_CFG_SCB;
+
+	nxp_c45_macsec_write(phydev, MACSEC_TXSC_CFG, cfg);
+}
+
+static void nxp_c45_set_rx_sc0_impl(struct phy_device *phydev,
+				    bool enable)
+{
+	u32 reg = 0;
+
+	nxp_c45_macsec_read(phydev, MACSEC_CFG, &reg);
+	if (enable)
+		reg |= MACSEC_CFG_S0I;
+	else
+		reg &= ~MACSEC_CFG_S0I;
+	nxp_c45_macsec_write(phydev, MACSEC_CFG, reg);
+}
+
+static bool nxp_c45_is_rx_sc0_impl(struct list_head *secy_list)
+{
+	struct nxp_c45_secy *pos, *tmp;
+
+	list_for_each_entry_safe(pos, tmp, secy_list, list)
+		if (pos->rx_sc0_impl)
+			return pos->rx_sc0_impl;
+
+	return false;
+}
+
+static void nxp_c45_rx_sc_en(struct phy_device *phydev,
+			     struct macsec_rx_sc *rx_sc, bool en)
+{
+	u32 reg = 0;
+
+	nxp_c45_macsec_read(phydev, MACSEC_RXSC_CFG, &reg);
+	if (rx_sc->active && en)
+		reg |= MACSEC_RXSC_CFG_SCI_EN;
+	else
+		reg &= ~MACSEC_RXSC_CFG_SCI_EN;
+	nxp_c45_macsec_write(phydev, MACSEC_RXSC_CFG, reg);
+}
+
+static void nxp_c45_rx_sc_update(struct phy_device *phydev,
+				 struct nxp_c45_secy *phy_secy)
+{
+	struct macsec_rx_sc *rx_sc = phy_secy->rx_sc;
+	struct nxp_c45_phy *priv = phydev->priv;
+	u32 cfg = 0;
+
+	nxp_c45_macsec_read(phydev, MACSEC_RXSC_CFG, &cfg);
+	cfg &= ~MACSEC_RXSC_CFG_VF_MASK;
+	cfg = phy_secy->secy->validate_frames << MACSEC_RXSC_CFG_VF_OFF;
+
+	phydev_dbg(phydev, "validate frames %u\n",
+		   phy_secy->secy->validate_frames);
+	phydev_dbg(phydev, "replay_protect %s window %u\n",
+		   phy_secy->secy->replay_protect ? "on" : "off",
+		   phy_secy->secy->replay_window);
+	if (phy_secy->secy->replay_protect) {
+		cfg |= MACSEC_RXSC_CFG_RP;
+		if (cfg & MACSEC_RXSC_CFG_SCI_EN) {
+			phydev_dbg(phydev, "RX SC enabled, window will not be updated\n");
+		} else {
+			phydev_dbg(phydev, "RX SC disabled, window will be updated\n");
+			nxp_c45_macsec_write(phydev, MACSEC_RPW,
+					     phy_secy->secy->replay_window);
+		}
+	} else {
+		cfg &= ~MACSEC_RXSC_CFG_RP;
+	}
+
+	phydev_dbg(phydev, "rx_sc->active %s\n",
+		   rx_sc->active ? "on" : "off");
+	if (rx_sc->active &&
+	    test_bit(phy_secy->secy_id, priv->macsec->secy_bitmap))
+		cfg |= MACSEC_RXSC_CFG_SCI_EN;
+	else
+		cfg &= ~MACSEC_RXSC_CFG_SCI_EN;
+
+	phydev_dbg(phydev, "key len %u\n", phy_secy->secy->key_len);
+	if (phy_secy->secy->key_len == 32)
+		cfg |= MACSEC_RXSC_CFG_AES_256;
+	else
+		cfg &= ~MACSEC_RXSC_CFG_AES_256;
+
+	phydev_dbg(phydev, "XPN %s\n", phy_secy->secy->xpn ? "on" : "off");
+	if (phy_secy->secy->xpn)
+		cfg |= MACSEC_RXSC_CFG_XPN;
+	else
+		cfg &= ~MACSEC_RXSC_CFG_XPN;
+
+	nxp_c45_macsec_write(phydev, MACSEC_RXSC_CFG, cfg);
+}
+
+static void nxp_c45_rx_sc_del(struct phy_device *phydev,
+			      struct nxp_c45_secy *phy_secy)
+{
+	struct nxp_c45_sa *pos, *tmp;
+
+	nxp_c45_macsec_write(phydev, MACSEC_RXSC_CFG, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_RPW, 0);
+	nxp_c45_set_sci(phydev, MACSEC_RXSC_SCI_1H, 0);
+
+	list_for_each_entry_safe(pos, tmp, &phy_secy->sa_list, list)
+		if (pos->type == RX_SA)
+			nxp_c45_rx_sa_update(phydev, pos, false);
+}
+
+static int nxp_c45_mdo_dev_open(struct macsec_context *ctx)
+{
+	struct nxp_c45_phy *priv = ctx->phydev->priv;
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_secy *phy_secy;
+	int any_bit_set;
+	u32 reg = 0;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	nxp_c45_tx_sc_en_flt(phydev, phy_secy->secy_id, true);
+	nxp_c45_set_rx_sc0_impl(phydev, phy_secy->rx_sc0_impl);
+	if (phy_secy->rx_sc)
+		nxp_c45_rx_sc_en(phydev, phy_secy->rx_sc, true);
+
+	any_bit_set = find_first_bit(priv->macsec->secy_bitmap, TX_SC_MAX);
+	if (any_bit_set == TX_SC_MAX) {
+		nxp_c45_macsec_read(phydev, MACSEC_CFG, &reg);
+		reg |= MACSEC_CFG_BYPASS;
+		nxp_c45_macsec_write(phydev, MACSEC_CFG, reg);
+	}
+
+	set_bit(phy_secy->secy_id, priv->macsec->secy_bitmap);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_dev_stop(struct macsec_context *ctx)
+{
+	struct nxp_c45_phy *priv = ctx->phydev->priv;
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_secy *phy_secy;
+	int any_bit_set;
+	u32 reg = 0;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	nxp_c45_tx_sc_en_flt(phydev, phy_secy->secy_id, false);
+	if (phy_secy->rx_sc)
+		nxp_c45_rx_sc_en(phydev, phy_secy->rx_sc, false);
+	nxp_c45_set_rx_sc0_impl(phydev, false);
+
+	clear_bit(phy_secy->secy_id, priv->macsec->secy_bitmap);
+	any_bit_set = find_first_bit(priv->macsec->secy_bitmap, TX_SC_MAX);
+	if (any_bit_set == TX_SC_MAX) {
+		nxp_c45_macsec_read(phydev, MACSEC_CFG, &reg);
+		reg &= ~MACSEC_CFG_BYPASS;
+		nxp_c45_macsec_write(phydev, MACSEC_CFG, reg);
+	}
+
+	return 0;
+}
+
+static int nxp_c45_mdo_add_secy(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	bool can_rx_sc0_impl;
+	int idx;
+	u32 reg;
+
+	phydev_dbg(phydev, "add SecY SCI %016llx\n",
+		   sci_to_cpu(ctx->secy->sci));
+
+	if (!nxp_c45_mac_addr_free(ctx))
+		return -EBUSY;
+
+	if (nxp_c45_is_rx_sc0_impl(&priv->macsec->secy_list))
+		return -EBUSY;
+
+	idx = find_first_zero_bit(priv->macsec->tx_sc_bitmap, TX_SC_MAX);
+	if (idx == TX_SC_MAX)
+		return -ENOSPC;
+
+	phy_secy = kzalloc(sizeof(*phy_secy), GFP_KERNEL);
+	if (!phy_secy)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&phy_secy->sa_list);
+	phy_secy->secy = ctx->secy;
+	phy_secy->secy_id = idx;
+
+	/* If the point to point mode should be enabled, we should have only
+	 * one SecY enabled, respectively the new one.
+	 */
+	can_rx_sc0_impl = list_count_nodes(&priv->macsec->secy_list) == 0;
+	if (!nxp_c45_secy_valid(phy_secy, can_rx_sc0_impl)) {
+		kfree_sensitive(phy_secy);
+		return -EINVAL;
+	}
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	nxp_c45_set_sci(phydev, MACSEC_TXSC_SCI_1H, ctx->secy->sci);
+	nxp_c45_tx_sc_set_flt(ctx, phy_secy->secy_id);
+	nxp_c45_tx_sc_update(phydev, phy_secy);
+
+	if (phy_interrupt_is_valid(phydev)) {
+		nxp_c45_macsec_read(phydev, MACSEC_EVER, &reg);
+		reg |= TX_SC_BIT(phy_secy->secy_id);
+		nxp_c45_macsec_write(phydev, MACSEC_EVER, reg);
+	}
+
+	set_bit(idx, priv->macsec->tx_sc_bitmap);
+	list_add_tail(&phy_secy->list, &priv->macsec->secy_list);
+
+	return 0;
+}
+
+static void nxp_c45_tx_sa_next(struct nxp_c45_secy *phy_secy,
+			       struct nxp_c45_sa *next_sa, u8 encoding_sa)
+{
+	struct nxp_c45_sa *sa;
+
+	sa = nxp_c45_find_sa(&phy_secy->sa_list, TX_SA, encoding_sa);
+	if (!IS_ERR(sa)) {
+		memcpy(next_sa, sa, sizeof(*sa));
+	} else {
+		next_sa->is_key_a = true;
+		next_sa->an = encoding_sa;
+	}
+}
+
+static int nxp_c45_mdo_upd_secy(struct macsec_context *ctx)
+{
+	u8 encoding_sa = ctx->secy->tx_sc.encoding_sa;
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	struct nxp_c45_sa next_sa;
+	bool can_rx_sc0_impl;
+
+	phydev_dbg(phydev, "update SecY SCI %016llx\n",
+		   sci_to_cpu(ctx->secy->sci));
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	if (!nxp_c45_mac_addr_free(ctx))
+		return -EBUSY;
+
+	/* If the point to point mode should be enabled, we should have only
+	 * one SecY enabled, respectively the new one.
+	 */
+	can_rx_sc0_impl = list_count_nodes(&priv->macsec->secy_list) == 1;
+	if (!nxp_c45_secy_valid(phy_secy, can_rx_sc0_impl))
+		return -EINVAL;
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	nxp_c45_tx_sc_set_flt(ctx, phy_secy->secy_id);
+	nxp_c45_tx_sc_update(phydev, phy_secy);
+
+	nxp_c45_tx_sa_next(phy_secy, &next_sa, encoding_sa);
+	nxp_c45_tx_sa_update(phydev, &next_sa, encoding_sa,
+			     ctx->secy->operational);
+
+	nxp_c45_set_rx_sc0_impl(phydev, phy_secy->rx_sc0_impl);
+	if (phy_secy->rx_sc)
+		nxp_c45_rx_sc_update(phydev, phy_secy);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_del_secy(struct macsec_context *ctx)
+{
+	u8 encoding_sa = ctx->secy->tx_sc.encoding_sa;
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	struct nxp_c45_sa next_sa;
+	u32 reg;
+
+	phydev_dbg(phydev, "delete SecY SCI %016llx\n",
+		   sci_to_cpu(ctx->secy->sci));
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	nxp_c45_mdo_dev_stop(ctx);
+	nxp_c45_tx_sa_next(phy_secy, &next_sa, encoding_sa);
+	nxp_c45_tx_sa_update(phydev, &next_sa, encoding_sa, false);
+	if (phy_secy->rx_sc)
+		nxp_c45_rx_sc_del(phydev, phy_secy);
+
+	nxp_c45_sa_list_free(&phy_secy->sa_list);
+	if (phy_interrupt_is_valid(phydev)) {
+		nxp_c45_macsec_read(phydev, MACSEC_EVER, &reg);
+		reg &= ~TX_SC_BIT(phy_secy->secy_id);
+		nxp_c45_macsec_write(phydev, MACSEC_EVER, reg);
+	}
+
+	clear_bit(phy_secy->secy_id, priv->macsec->tx_sc_bitmap);
+	list_del(&phy_secy->list);
+	kfree(phy_secy);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_add_rxsc(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+
+	phydev_dbg(phydev, "add RX SC SCI %016llx %s\n",
+		   sci_to_cpu(ctx->rx_sc->sci),
+		   ctx->rx_sc->active ? "enabled" : "disabled");
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	if (phy_secy->rx_sc)
+		return -ENOSPC;
+
+	if (!nxp_c45_sci_valid(ctx->rx_sc->sci, ctx->secy->tx_sc.scb))
+		return -EINVAL;
+
+	phy_secy->rx_sc = ctx->rx_sc;
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	nxp_c45_set_sci(phydev, MACSEC_RXSC_SCI_1H, ctx->rx_sc->sci);
+	nxp_c45_rx_sc_update(phydev, phy_secy);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_upd_rxsc(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+
+	phydev_dbg(phydev, "update RX SC SCI %016llx %s\n",
+		   sci_to_cpu(ctx->rx_sc->sci),
+		   ctx->rx_sc->active ? "enabled" : "disabled");
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	nxp_c45_rx_sc_update(phydev, phy_secy);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_del_rxsc(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+
+	phydev_dbg(phydev, "delete RX SC SCI %016llx %s\n",
+		   sci_to_cpu(ctx->rx_sc->sci),
+		   ctx->rx_sc->active ? "enabled" : "disabled");
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	nxp_c45_rx_sc_del(phydev, phy_secy);
+	phy_secy->rx_sc = NULL;
+
+	return 0;
+}
+
+static int nxp_c45_mdo_add_rxsa(struct macsec_context *ctx)
+{
+	struct macsec_rx_sa *rx_sa = ctx->sa.rx_sa;
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	u8 an = ctx->sa.assoc_num;
+	struct nxp_c45_sa *sa;
+
+	phydev_dbg(phydev, "add RX SA %u %s to RX SC SCI %016llx\n",
+		   an, rx_sa->active ? "enabled" : "disabled",
+		   sci_to_cpu(rx_sa->sc->sci));
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	sa = nxp_c45_sa_alloc(&phy_secy->sa_list, rx_sa, RX_SA, an);
+	if (IS_ERR(sa))
+		return PTR_ERR(sa);
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	nxp_c45_sa_set_pn(phydev, sa, rx_sa->next_pn,
+			  ctx->secy->replay_window);
+	nxp_c45_sa_set_key(ctx, sa->regs, rx_sa->key.salt.bytes, rx_sa->ssci);
+	nxp_c45_rx_sa_update(phydev, sa, rx_sa->active);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_upd_rxsa(struct macsec_context *ctx)
+{
+	struct macsec_rx_sa *rx_sa = ctx->sa.rx_sa;
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	u8 an = ctx->sa.assoc_num;
+	struct nxp_c45_sa *sa;
+
+	phydev_dbg(phydev, "update RX SA %u %s to RX SC SCI %016llx\n",
+		   an, rx_sa->active ? "enabled" : "disabled",
+		   sci_to_cpu(rx_sa->sc->sci));
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	sa = nxp_c45_find_sa(&phy_secy->sa_list, RX_SA, an);
+	if (IS_ERR(sa))
+		return PTR_ERR(sa);
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	nxp_c45_sa_set_pn(phydev, sa, rx_sa->next_pn,
+			  ctx->secy->replay_window);
+	nxp_c45_rx_sa_update(phydev, sa, rx_sa->active);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_del_rxsa(struct macsec_context *ctx)
+{
+	struct macsec_rx_sa *rx_sa = ctx->sa.rx_sa;
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	u8 an = ctx->sa.assoc_num;
+	struct nxp_c45_sa *sa;
+
+	phydev_dbg(phydev, "delete RX SA %u %s to RX SC SCI %016llx\n",
+		   an, rx_sa->active ? "enabled" : "disabled",
+		   sci_to_cpu(rx_sa->sc->sci));
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	sa = nxp_c45_find_sa(&phy_secy->sa_list, RX_SA, an);
+	if (IS_ERR(sa))
+		return PTR_ERR(sa);
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	nxp_c45_rx_sa_update(phydev, sa, false);
+
+	nxp_c45_sa_free(sa);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_add_txsa(struct macsec_context *ctx)
+{
+	struct macsec_tx_sa *tx_sa = ctx->sa.tx_sa;
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	u8 an = ctx->sa.assoc_num;
+	struct nxp_c45_sa *sa;
+
+	phydev_dbg(phydev, "add TX SA %u %s to TX SC %016llx\n",
+		   an, ctx->sa.tx_sa->active ? "enabled" : "disabled",
+		   sci_to_cpu(ctx->secy->sci));
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	sa = nxp_c45_sa_alloc(&phy_secy->sa_list, tx_sa, TX_SA, an);
+	if (IS_ERR(sa))
+		return PTR_ERR(sa);
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	nxp_c45_sa_set_pn(phydev, sa, tx_sa->next_pn, 0);
+	nxp_c45_sa_set_key(ctx, sa->regs, tx_sa->key.salt.bytes, tx_sa->ssci);
+	nxp_c45_tx_sa_update(phydev, sa, ctx->secy->tx_sc.encoding_sa,
+			     tx_sa->active);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_upd_txsa(struct macsec_context *ctx)
+{
+	struct macsec_tx_sa *tx_sa = ctx->sa.tx_sa;
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	u8 an = ctx->sa.assoc_num;
+	struct nxp_c45_sa *sa;
+
+	phydev_dbg(phydev, "update TX SA %u %s to TX SC %016llx\n",
+		   an, ctx->sa.tx_sa->active ? "enabled" : "disabled",
+		   sci_to_cpu(ctx->secy->sci));
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	sa = nxp_c45_find_sa(&phy_secy->sa_list, TX_SA, an);
+	if (IS_ERR(sa))
+		return PTR_ERR(sa);
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	nxp_c45_sa_set_pn(phydev, sa, tx_sa->next_pn, 0);
+	nxp_c45_tx_sa_update(phydev, sa, ctx->secy->tx_sc.encoding_sa,
+			     tx_sa->active);
+	return 0;
+}
+
+static int nxp_c45_mdo_del_txsa(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	u8 an = ctx->sa.assoc_num;
+	struct nxp_c45_sa *sa;
+
+	phydev_dbg(phydev, "delete TX SA %u %s to TX SC %016llx\n",
+		   an, ctx->sa.tx_sa->active ? "enabled" : "disabled",
+		   sci_to_cpu(ctx->secy->sci));
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	sa = nxp_c45_find_sa(&phy_secy->sa_list, TX_SA, an);
+	if (IS_ERR(sa))
+		return PTR_ERR(sa);
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	nxp_c45_tx_sa_update(phydev, sa, ctx->secy->tx_sc.encoding_sa, false);
+
+	nxp_c45_sa_free(sa);
+
+	return 0;
+}
+
+static const struct macsec_ops nxp_c45_macsec_ops = {
+	.mdo_dev_open = nxp_c45_mdo_dev_open,
+	.mdo_dev_stop = nxp_c45_mdo_dev_stop,
+	.mdo_add_secy = nxp_c45_mdo_add_secy,
+	.mdo_upd_secy = nxp_c45_mdo_upd_secy,
+	.mdo_del_secy = nxp_c45_mdo_del_secy,
+	.mdo_add_rxsc = nxp_c45_mdo_add_rxsc,
+	.mdo_upd_rxsc = nxp_c45_mdo_upd_rxsc,
+	.mdo_del_rxsc = nxp_c45_mdo_del_rxsc,
+	.mdo_add_rxsa = nxp_c45_mdo_add_rxsa,
+	.mdo_upd_rxsa = nxp_c45_mdo_upd_rxsa,
+	.mdo_del_rxsa = nxp_c45_mdo_del_rxsa,
+	.mdo_add_txsa = nxp_c45_mdo_add_txsa,
+	.mdo_upd_txsa = nxp_c45_mdo_upd_txsa,
+	.mdo_del_txsa = nxp_c45_mdo_del_txsa,
+};
+
+int nxp_c45_macsec_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	if (!phydev->macsec_ops)
+		return 0;
+
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PORT_FUNC_ENABLES,
+			       MACSEC_EN | ADAPTER_EN);
+	if (ret)
+		return ret;
+
+	ret = nxp_c45_macsec_write(phydev, ADPTR_CNTRL, ADPTR_CNTRL_CONFIG_EN |
+				   ADPTR_CNTRL_ADPTR_EN);
+	if (ret)
+		return ret;
+
+	ret = nxp_c45_macsec_write(phydev, ADPTR_CNTRL, ADPTR_CNTRL_ADPTR_EN);
+	if (ret)
+		return ret;
+
+	ret = nxp_c45_macsec_write(phydev, MACSEC_TPNET, PN_WRAP_THRESHOLD);
+	if (ret)
+		return ret;
+
+	/* Set MKA filter. */
+	ret = nxp_c45_macsec_write(phydev, MACSEC_UPFR0D2, ETH_P_PAE);
+	if (ret)
+		return ret;
+
+	ret = nxp_c45_macsec_write(phydev, MACSEC_UPFR0M1, MACSEC_OVP);
+	if (ret)
+		return ret;
+
+	ret = nxp_c45_macsec_write(phydev, MACSEC_UPFR0M2, ETYPE_MASK);
+	if (ret)
+		return ret;
+
+	ret = nxp_c45_macsec_write(phydev, MACSEC_UPFR0R, MACSEC_UPFR_EN);
+
+	return ret;
+}
+
+int nxp_c45_macsec_probe(struct phy_device *phydev)
+{
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct device *dev = &phydev->mdio.dev;
+
+	priv->macsec = devm_kzalloc(dev, sizeof(*priv->macsec), GFP_KERNEL);
+	if (!priv->macsec)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&priv->macsec->secy_list);
+	phydev->macsec_ops = &nxp_c45_macsec_ops;
+
+	return 0;
+}
+
+void nxp_c45_handle_macsec_interrupt(struct phy_device *phydev,
+				     irqreturn_t *ret)
+{
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *pos, *tmp;
+	struct nxp_c45_sa *sa;
+	u8 encoding_sa;
+	int secy_id;
+	u32 reg = 0;
+
+	if (!phydev->macsec_ops)
+		return;
+
+	do {
+		nxp_c45_macsec_read(phydev, MACSEC_EVR, &reg);
+		if (!reg)
+			return;
+
+		secy_id = MACSEC_REG_SIZE - ffs(reg);
+		list_for_each_entry_safe(pos, tmp, &priv->macsec->secy_list,
+					 list)
+			if (pos->secy_id == secy_id)
+				break;
+
+		encoding_sa = pos->secy->tx_sc.encoding_sa;
+		phydev_dbg(phydev, "pn_wrapped: TX SC %d, encoding_sa %u\n",
+			   pos->secy_id, encoding_sa);
+
+		sa = nxp_c45_find_sa(&pos->sa_list, TX_SA, encoding_sa);
+		if (!IS_ERR(sa))
+			macsec_pn_wrapped(pos->secy, sa->sa);
+		else
+			WARN_ON(!sa);
+
+		nxp_c45_macsec_write(phydev, MACSEC_EVR,
+				     TX_SC_BIT(pos->secy_id));
+		*ret = IRQ_HANDLED;
+	} while (reg);
+}
diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 7ab080ff02df..fc3f06e2ca5e 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -14,9 +14,10 @@
 #include <linux/processor.h>
 #include <linux/property.h>
 #include <linux/ptp_classify.h>
-#include <linux/ptp_clock_kernel.h>
 #include <linux/net_tstamp.h>
 
+#include "nxp-c45-tja11xx.h"
+
 #define PHY_ID_TJA_1103			0x001BB010
 #define PHY_ID_TJA_1120			0x001BB031
 
@@ -75,9 +76,11 @@
 #define PORT_CONTROL_EN			BIT(14)
 
 #define VEND1_PORT_ABILITIES		0x8046
+#define MACSEC_ABILITY			BIT(5)
 #define PTP_ABILITY			BIT(3)
 
 #define VEND1_PORT_FUNC_IRQ_EN		0x807A
+#define MACSEC_IRQS			BIT(5)
 #define PTP_IRQS			BIT(3)
 
 #define VEND1_PTP_IRQ_ACK		0x9008
@@ -148,7 +151,6 @@
 
 #define TS_SEC_MASK			GENMASK(1, 0)
 
-#define VEND1_PORT_FUNC_ENABLES		0x8048
 #define PTP_ENABLE			BIT(3)
 #define PHY_TEST_ENABLE			BIT(0)
 
@@ -281,25 +283,6 @@ struct nxp_c45_phy_data {
 			    irqreturn_t *irq_status);
 };
 
-struct nxp_c45_phy {
-	const struct nxp_c45_phy_data *phy_data;
-	struct phy_device *phydev;
-	struct mii_timestamper mii_ts;
-	struct ptp_clock *ptp_clock;
-	struct ptp_clock_info caps;
-	struct sk_buff_head tx_queue;
-	struct sk_buff_head rx_queue;
-	/* used to access the PTP registers atomic */
-	struct mutex ptp_lock;
-	int hwts_tx;
-	int hwts_rx;
-	u32 tx_delay;
-	u32 rx_delay;
-	struct timespec64 extts_ts;
-	int extts_index;
-	bool extts;
-};
-
 static const
 struct nxp_c45_phy_data *nxp_c45_get_data(struct phy_device *phydev)
 {
@@ -1218,12 +1201,25 @@ static int nxp_c45_start_op(struct phy_device *phydev)
 
 static int nxp_c45_config_intr(struct phy_device *phydev)
 {
-	if (phydev->interrupts == PHY_INTERRUPT_ENABLED)
+	int ret;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				       VEND1_PORT_FUNC_IRQ_EN, MACSEC_IRQS);
+		if (ret)
+			return ret;
+
 		return phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
 					VEND1_PHY_IRQ_EN, PHY_IRQ_LINK_EVENT);
-	else
-		return phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
-					  VEND1_PHY_IRQ_EN, PHY_IRQ_LINK_EVENT);
+	}
+
+	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+				 VEND1_PORT_FUNC_IRQ_EN, MACSEC_IRQS);
+	if (ret)
+		return ret;
+
+	return phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+				  VEND1_PHY_IRQ_EN, PHY_IRQ_LINK_EVENT);
 }
 
 static int tja1103_config_intr(struct phy_device *phydev)
@@ -1289,6 +1285,7 @@ static irqreturn_t nxp_c45_handle_interrupt(struct phy_device *phydev)
 	}
 
 	data->nmi_handler(phydev, &ret);
+	nxp_c45_handle_macsec_interrupt(phydev, &ret);
 
 	return ret;
 }
@@ -1614,6 +1611,9 @@ static int nxp_c45_config_init(struct phy_device *phydev)
 
 	nxp_c45_counters_enable(phydev);
 	nxp_c45_ptp_init(phydev);
+	ret = nxp_c45_macsec_config_init(phydev);
+	if (ret)
+		return ret;
 
 	return nxp_c45_start_op(phydev);
 }
@@ -1629,7 +1629,9 @@ static int nxp_c45_get_features(struct phy_device *phydev)
 static int nxp_c45_probe(struct phy_device *phydev)
 {
 	struct nxp_c45_phy *priv;
-	int ptp_ability;
+	bool macsec_ability;
+	int phy_abilities;
+	bool ptp_ability;
 	int ret = 0;
 
 	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
@@ -1645,9 +1647,9 @@ static int nxp_c45_probe(struct phy_device *phydev)
 
 	mutex_init(&priv->ptp_lock);
 
-	ptp_ability = phy_read_mmd(phydev, MDIO_MMD_VEND1,
-				   VEND1_PORT_ABILITIES);
-	ptp_ability = !!(ptp_ability & PTP_ABILITY);
+	phy_abilities = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+				     VEND1_PORT_ABILITIES);
+	ptp_ability = !!(phy_abilities & PTP_ABILITY);
 	if (!ptp_ability) {
 		phydev_dbg(phydev, "the phy does not support PTP");
 		goto no_ptp_support;
@@ -1666,6 +1668,20 @@ static int nxp_c45_probe(struct phy_device *phydev)
 	}
 
 no_ptp_support:
+	macsec_ability = !!(phy_abilities & MACSEC_ABILITY);
+	if (!macsec_ability) {
+		phydev_info(phydev, "the phy does not support MACsec\n");
+		goto no_macsec_support;
+	}
+
+	if (IS_ENABLED(CONFIG_MACSEC)) {
+		ret = nxp_c45_macsec_probe(phydev);
+		phydev_dbg(phydev, "MACsec support enabled.");
+	} else {
+		phydev_dbg(phydev, "MACsec support not enabled even if the phy supports it");
+	}
+
+no_macsec_support:
 
 	return ret;
 }
diff --git a/drivers/net/phy/nxp-c45-tja11xx.h b/drivers/net/phy/nxp-c45-tja11xx.h
new file mode 100644
index 000000000000..692a5f29baed
--- /dev/null
+++ b/drivers/net/phy/nxp-c45-tja11xx.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* NXP C45 PHY driver header file
+ * Copyright 2023 NXP
+ * Author: Radu Pirea <radu-nicolae.pirea@oss.nxp.com>
+ */
+
+#include <linux/ptp_clock_kernel.h>
+
+#define VEND1_PORT_FUNC_ENABLES		0x8048
+
+struct nxp_c45_macsec;
+
+struct nxp_c45_phy {
+	const struct nxp_c45_phy_data *phy_data;
+	struct phy_device *phydev;
+	struct mii_timestamper mii_ts;
+	struct ptp_clock *ptp_clock;
+	struct ptp_clock_info caps;
+	struct sk_buff_head tx_queue;
+	struct sk_buff_head rx_queue;
+	/* used to access the PTP registers atomic */
+	struct mutex ptp_lock;
+	int hwts_tx;
+	int hwts_rx;
+	u32 tx_delay;
+	u32 rx_delay;
+	struct timespec64 extts_ts;
+	int extts_index;
+	bool extts;
+	struct nxp_c45_macsec *macsec;
+};
+
+#if IS_ENABLED(CONFIG_MACSEC)
+int nxp_c45_macsec_config_init(struct phy_device *phydev);
+void nxp_c45_handle_macsec_interrupt(struct phy_device *phydev,
+				     irqreturn_t *ret);
+int nxp_c45_macsec_probe(struct phy_device *phydev);
+#else
+static inline
+int nxp_c45_macsec_config_init(struct phy_device *phydev)
+{
+	return 0;
+}
+
+static inline
+void nxp_c45_handle_macsec_interrupt(struct phy_device *phydev,
+				     irqreturn_t *ret)
+{
+}
+
+static inline
+int nxp_c45_macsec_probe(struct phy_device *phydev)
+{
+	return 0;
+}
+#endif
-- 
2.34.1

