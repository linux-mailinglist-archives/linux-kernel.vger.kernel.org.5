Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EBF786B62
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240625AbjHXJRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbjHXJRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:17:03 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2057.outbound.protection.outlook.com [40.107.105.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00596198A;
        Thu, 24 Aug 2023 02:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADn+WGQh0IPYyKCtpx2UkustOi07HzlEmrHJfOmJLZtwqW9chr3f0TUg5TwIMf0ldaodNlbwNYNdbn3SxUir20nui4tTWHqDs2cO2dWmd6Lge2eHc7fraR9TzUZ3XhUouFz4DszPaNq/j0jx72hBM1tpUsG2ACVuoZZ3gY1q5KC8vz62XBuHoGu3zvHg5n6ef3W+yCn5g2u+nc91t0HFM0qQmk5GQvegnTwl8s+T973wd/XjMX8a7hkUNBys9t/OxBmMwTWZU+AtbRQJgQCf+vbSYD3jHVzlfmhlE1qslq+3sTKLNeAo/aEBDV1+y7awuoHcObhgSy61GNCvenkoqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZqPLcnJRPBqhtz4EKxbRGl7EgrLTMasmN6EjnmfQj8=;
 b=KdcGbL5SO1hZE3u+0T/iJ/G0Lqf8Ndp+B6BuI3lcdcgRK/LsQDZkTERdHvMDJSUqmKjCDDrmIWbOF/LaJ9+EDn9HRQJ6sA8CNmIkS5+ZJLSYi3w7JagLxkKCIqNkTsyhrqJDLdN9aTfQspEvyQQcSmrHtFXL9kaIlnSPk0GVKhoZt/IlXJEu6lcewds5s/WDffzmRiwuyA/mZ8Cbq9mK3aOQfch+dtxzsVBkQkGRtAawMbuYQkyPssRj7/Qj4NcGcwFTkM/0qR6TAw0dV4881TmbnaAE4Xa7cG0bk8xyLUqXZrmcoLOC2GBeDRgYpbdusAt1h2DX9WxLeggY5hsYAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZqPLcnJRPBqhtz4EKxbRGl7EgrLTMasmN6EjnmfQj8=;
 b=IJLv2LF/SHS6esVyj8NhFMnDHzDXvzuiEIAEqelLsV27Zd8xwHvdPsXeWhvXv47l7iXaFDNgM0DbZKCwNXb3niUWGVhrRC55nOz8uvA3uTbQy7ufdZ6dK1K/DxWMNT3Md1fwmKTmQY+f9+yEcsA9hcwmMA5r0GC4og9FCQF+lx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DBBPR04MB7675.eurprd04.prod.outlook.com (2603:10a6:10:207::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 09:16:51 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%5]) with mapi id 15.20.6678.031; Thu, 24 Aug 2023
 09:16:51 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [RFC net-next v2 3/5] net: phy: nxp-c45-tja11xx add MACsec support
Date:   Thu, 24 Aug 2023 12:16:13 +0300
Message-Id: <20230824091615.191379-4-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0116.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::33) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|DBBPR04MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 6473f6d7-c948-46fc-acc7-08dba482da18
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3hNTVe+goalEcJfp4EqxRHnNHAIkjS4oYI/XC2A7g+VXe2ZPArkyZiEqq3+6cbktZoTCG0J1Gx+EAQ850/hEtPfuZ88QeqrZ2nb9frgZU6QDuSky1CJFJjtj2BkVTeiS/SnVeE5oi5QCW1/LD8YTy0VjH58luKeT7ZHFbTRRmJdUy58BP+GgqhhwYiEEoK4RYUDva73+B3qzriEt+/P2xOmTGV/f+OahslrOX60xHvMd9K7wy9/pgmHM3VDU6RtqymF1THe8qBlV8YayrsL8ifF0qh2mkn4Cr9Y9lz+ZTajA+zPajbustZfeJLDP3GHyXn4BKtUx7r4tc8WZRtkoebh3IP+DcG/8ttB0cij518ngdmgt9BzsM0UIpTfHStjkI6Ntku0HiU4DXt7E5eR0L1tJ4buyeXQ9QCGQCNRgn75ZS90nlC+Y03EU1X0Q2D9FbLVG2SNMx4vRXQhkofHi3B9KrcxXDf0num18akrXHhiifxSJ3mBth60U2QxXexK+0cb4n1D4GCVYT47wRH7J1lZ8yI/AAGG40qqt1Uv+gUCLxae2ycOpQCTd3ZSw5K1HdUgCBJrAUXrwfPceKvgH+EblDZX9vKwTJBv0ul6Uk5+6u8A8FxjziJSU7c1xPGg8/I1zZSUtg1vMN4QknyFMbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(186009)(1800799009)(451199024)(1076003)(2616005)(5660300002)(4326008)(8676002)(8936002)(30864003)(83380400001)(7416002)(26005)(38350700002)(921005)(6666004)(38100700002)(66946007)(66556008)(66476007)(316002)(478600001)(41300700001)(6512007)(2906002)(6506007)(86362001)(52116002)(6486002)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A8e6oZZRwwLHkN3oT0lU4NXqdrJyl+hiip7g5LE7kFjxO0yY/vIc88f2uMgW?=
 =?us-ascii?Q?tiFQuXeWyjX5uglI2f4UN9yeqNZ7DowJ+4O4yfZIZDpIcV/V/LhV50m13AoZ?=
 =?us-ascii?Q?q7hcEEMdl+LYFDXgFGg2OhisPKDORkYW+pJz78Ht7HLs4rOhWFIXOgtcH/YE?=
 =?us-ascii?Q?sYjeVFcz3CvJN5MMvysx3q2hAH4nzjIMGocJ9DaijJbAwD6O6y8T08pGjECh?=
 =?us-ascii?Q?CNcTo96pbRld08fBEraeShJC6MwXLLKNu2TJoMD8if5PNFHjXgPeiPFY2i6l?=
 =?us-ascii?Q?HMhb2niEey19ws3qTM0dcnyRbhvsCESOd09/mkXcU3/vG6tCAizzFfLYaSgW?=
 =?us-ascii?Q?arpauflZcmCKQeS4/pAhtSNeFJMmJnOkAQJ9bifcfUe2eZWgKPp065e/fsfq?=
 =?us-ascii?Q?wIx38cmrfaMktXY8ZdWB/cxyTTO0FqxM1Z/OMCUpEMmTr7bqtgftRUcmTiAw?=
 =?us-ascii?Q?yIzt33pCpBuUdWcxVJDiRYLX7V8ie+a8pFsTC7lR4E+QL5U6HzxB+QYYyx70?=
 =?us-ascii?Q?Luolkp2yI8QFlwtCk44OKpK7grzt5QU6A57iL80LciP7zfvs85PtdNL4jaPz?=
 =?us-ascii?Q?MEPiRnHZACsLEbr1pnlAbKKhpAKwl2ERGzKQTq+qqGY7Up/d54d7Mv+jGpTz?=
 =?us-ascii?Q?Q90YiE7kHjAJ/dh6B9LXTwLFETa3LCXgB2KUm4Heq+FwXPYPT6NupiO9Kqef?=
 =?us-ascii?Q?AV+vvLE2s0u7+Vz7Agk2W+1oPb0XDNTL6bnPFbENZN/KtRtoBxKqQbknMQd8?=
 =?us-ascii?Q?xoo3NMIneYaAkWa/TlIdE8NBr6ywwTLreGOFP4Plhkn973AnlKBnphjvVvhF?=
 =?us-ascii?Q?P3qfAlzpfvFg+RTu3i/Ka4+6tFhVgBl54fAiX/Pq3GUmzfduBgbjwPxEKxsd?=
 =?us-ascii?Q?GY+9a7uzRPzWL2lK9K52eq83TUifcnA7S6wEGjjtqJFlZKTaKUghRYllMEwe?=
 =?us-ascii?Q?4xkIviQ3horISgorpsNiP2eBn9H+ZwbTp0Y5j1HgdHi8r3+uB/i9EYbnJrHj?=
 =?us-ascii?Q?r3+KkzCfkeikLbLFTOhiPatQozeO5CqDUhbFytVTXYfOyujoJdmMhag7VwxN?=
 =?us-ascii?Q?g4ESaESHptEhdjBdTkPSwQqisK1CUzgKcNgWR+N3TAt0RIe2bAl1IYWmqpRw?=
 =?us-ascii?Q?nmh4LSAchTG+jtcskIeCExzS4cQeOVsOx2lpbcfBq15p8VSBIhiOZ7fZeVqr?=
 =?us-ascii?Q?vXA+jPl/2/qoBAwOnoJUdgkaKhhpaejFFsB3mYVx5HBcM5C6UUfaSrChKu7T?=
 =?us-ascii?Q?8faP5Rksoz4pPh6U1Xt6beZ+YY45P/lAE6Kpp9jwDIQp7SZV3M10lNwaUOaZ?=
 =?us-ascii?Q?0RfNjHCYwkBpleGs9E9hmI9Xs2/qqKR4rYKJBxCCGLeC6WJ0DmGlwSgbrhLK?=
 =?us-ascii?Q?rmNRIIXLcyf4aLa4UzX0/OS5mb/wruWcBISQ0IvR0YV82wQmFwdlwyAlX0Of?=
 =?us-ascii?Q?N4tP5HuekHonyfio6sOQPjiTJX7Yz8sKTU1CyTE9UovbIq02JLdUjYocE0gY?=
 =?us-ascii?Q?qjQtCwXT6UbS925y0+9z6HlJVSmz04HzLcb6cbteT1mEYvsPRjMtYMPSmLuK?=
 =?us-ascii?Q?aLo0eYTUucAx3tWvPcu4i2usJF3LMC1kc7iQx35lys7Ck31Wo1kyiA1Emf+A?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6473f6d7-c948-46fc-acc7-08dba482da18
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 09:16:51.7326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGhFI/DKWPkLdfaOIszSBR+gfwP5UOpyQjpGb1RXLBsTdCUbPdftKcuffwNsqCvLZYn8WaSlj89h+VY7Q0zmbewvtPgK+pH1n/Nb+7N3Pxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7675
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
 MAINTAINERS                              |    2 +-
 drivers/net/phy/Kconfig                  |    2 +-
 drivers/net/phy/Makefile                 |    4 +
 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 1397 ++++++++++++++++++++++
 drivers/net/phy/nxp-c45-tja11xx.c        |   72 +-
 drivers/net/phy/nxp-c45-tja11xx.h        |   55 +
 6 files changed, 1501 insertions(+), 31 deletions(-)
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx-macsec.c
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9cc15c50c2c6..3d1e2c9c278b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15173,7 +15173,7 @@ NXP C45 TJA11XX PHY DRIVER
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
index c945ed9bd14b..ee53e2fdb968 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -83,6 +83,10 @@ obj-$(CONFIG_MICROSEMI_PHY)	+= mscc/
 obj-$(CONFIG_MOTORCOMM_PHY)	+= motorcomm.o
 obj-$(CONFIG_NATIONAL_PHY)	+= national.o
 obj-$(CONFIG_NCN26000_PHY)	+= ncn26000.o
+nxp-c45-tja11xx-objs		+= nxp-c45-tja11xx.o
+ifdef CONFIG_MACSEC
+nxp-c45-tja11xx-objs		+= nxp-c45-tja11xx-macsec.o
+endif
 obj-$(CONFIG_NXP_C45_TJA11XX_PHY)	+= nxp-c45-tja11xx.o
 obj-$(CONFIG_NXP_CBTX_PHY)	+= nxp-cbtx.o
 obj-$(CONFIG_NXP_TJA11XX_PHY)	+= nxp-tja11xx.o
diff --git a/drivers/net/phy/nxp-c45-tja11xx-macsec.c b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
new file mode 100644
index 000000000000..1567865b8de4
--- /dev/null
+++ b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
@@ -0,0 +1,1397 @@
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
+#define TX_SC_BIT(secy_id) BIT(MACSEC_REG_SIZE - (secy_id) - 1)
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
+#define MACSEC_RXSC_SCI_2H		0x0104
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
+#define MACSEC_RXSA_CS_A		BIT(31)
+#define MACSEC_RXSA_CS_AN_OFF		1
+#define MACSEC_RXSA_CS_EN		BIT(0)
+
+#define MACSEC_TXSC_SCI_1H		0x0200
+#define MACSEC_TXSC_SCI_2H		0x0204
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
+#define MACSEC_TXSC_CFG_SCI		BIT(0)
+
+#define MACSEC_TXSA_A_CS		0x0280
+#define MACSEC_TXSA_A_NPN		0x0284
+#define MACSEC_TXSA_A_XNPN		0x0288
+
+#define MACSEC_TXSA_B_CS		0x02C0
+#define MACSEC_TXSA_B_NPN		0x02C4
+#define MACSEC_TXSA_B_XNPN		0x02C8
+
+#define MACSEC_TXSA_CS_A		BIT(31)
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
+struct nxp_c45_rx_sc {
+	struct macsec_rx_sc *rx_sc;
+	struct macsec_rx_sa *rx_sa_a;
+	struct macsec_rx_sa *rx_sa_b;
+};
+
+struct nxp_c45_tx_sa {
+	struct macsec_tx_sa *tx_sa;
+	u8 key[MACSEC_MAX_KEY_LEN];
+	u8 salt[MACSEC_SALT_LEN];
+	u8 an;
+	u64 next_pn;
+	bool is_enabled;
+	bool is_key_a;
+};
+
+struct nxp_c45_secy {
+	struct macsec_secy *secy;
+	struct nxp_c45_tx_sa *tx_sa[MACSEC_NUM_AN];
+	struct nxp_c45_rx_sc *rx_sc;
+	int enabled_an;
+	int secy_id;
+	bool tx_sa_key_a;
+	bool point_to_point;
+	struct list_head list;
+};
+
+struct nxp_c45_macsec {
+	struct list_head secy_list;
+	DECLARE_BITMAP(secy_bitmap, TX_SC_MAX);
+	DECLARE_BITMAP(tx_sc_bitmap, TX_SC_MAX);
+};
+
+struct nxp_c45_macsec_sa_regs {
+	u16 rxsa_cs;
+	u16 rxsa_npn;
+	u16 rxsa_xnpn;
+	u16 rxsa_lnpn;
+	u16 rxsa_lxnpn;
+	u16 txsa_cs;
+	u16 txsa_npn;
+	u16 txsa_xnpn;
+	u16 rxsa_ka;
+	u16 rxsa_ssci;
+	u16 rxsa_salt;
+	u16 txsa_ka;
+	u16 txsa_ssci;
+	u16 txsa_salt;
+};
+
+static const struct nxp_c45_macsec_sa_regs sa_a_regs = {
+	.rxsa_cs	=	MACSEC_RXSA_A_CS,
+	.rxsa_npn	=	MACSEC_RXSA_A_NPN,
+	.rxsa_xnpn	=	MACSEC_RXSA_A_XNPN,
+	.rxsa_lnpn	=	MACSEC_RXSA_A_LNPN,
+	.rxsa_lxnpn	=	MACSEC_RXSA_A_LXNPN,
+	.txsa_cs	=	MACSEC_TXSA_A_CS,
+	.txsa_npn	=	MACSEC_TXSA_A_NPN,
+	.txsa_xnpn	=	MACSEC_TXSA_A_XNPN,
+	.rxsa_ka	=	MACSEC_RXSA_A_KA,
+	.rxsa_ssci	=	MACSEC_RXSA_A_SSCI,
+	.rxsa_salt	=	MACSEC_RXSA_A_SALT,
+	.txsa_ka	=	MACSEC_TXSA_A_KA,
+	.txsa_ssci	=	MACSEC_TXSA_A_SSCI,
+	.txsa_salt	=	MACSEC_TXSA_A_SALT,
+};
+
+static const struct nxp_c45_macsec_sa_regs sa_b_regs = {
+	.rxsa_cs	=	MACSEC_RXSA_B_CS,
+	.rxsa_npn	=	MACSEC_RXSA_B_NPN,
+	.rxsa_xnpn	=	MACSEC_RXSA_B_XNPN,
+	.rxsa_lnpn	=	MACSEC_RXSA_B_LNPN,
+	.rxsa_lxnpn	=	MACSEC_RXSA_B_LXNPN,
+	.txsa_cs	=	MACSEC_TXSA_B_CS,
+	.txsa_npn	=	MACSEC_TXSA_B_NPN,
+	.txsa_xnpn	=	MACSEC_TXSA_B_XNPN,
+	.rxsa_ka	=	MACSEC_RXSA_B_KA,
+	.rxsa_ssci	=	MACSEC_RXSA_B_SSCI,
+	.rxsa_salt	=	MACSEC_RXSA_B_SALT,
+	.txsa_ka	=	MACSEC_TXSA_B_KA,
+	.txsa_ssci	=	MACSEC_TXSA_B_SSCI,
+	.txsa_salt	=	MACSEC_TXSA_B_SALT,
+};
+
+static const
+struct nxp_c45_macsec_sa_regs *nxp_c45_get_macsec_sa_regs(bool key_a)
+{
+	if (key_a)
+		return &sa_a_regs;
+
+	return &sa_b_regs;
+}
+
+static int nxp_c45_macsec_write(struct phy_device *phydev, u16 reg, u32 val)
+{
+	WARN_ON_ONCE(reg % 4);
+
+	reg = reg / 2;
+	phy_write_mmd(phydev, MDIO_MMD_VEND2,
+		      VEND1_MACSEC_BASE + reg, val);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2,
+		      VEND1_MACSEC_BASE + reg + 1, val >> 16);
+	return 0;
+}
+
+static int nxp_c45_macsec_read(struct phy_device *phydev, u16 reg, u32 *value)
+{
+	u32 lvalue;
+	int ret;
+
+	WARN_ON_ONCE(reg % 4);
+
+	reg = reg / 2;
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, VEND1_MACSEC_BASE + reg);
+	if (ret < 0)
+		return ret;
+
+	lvalue = (u32)ret & 0xffff;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, VEND1_MACSEC_BASE + reg + 1);
+	if (ret < 0)
+		return ret;
+
+	lvalue |= (u32)ret << 16;
+	*value = lvalue;
+
+	return 0;
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
+void nxp_c45_macsec_config_init(struct phy_device *phydev)
+{
+	if (!phydev->macsec_ops)
+		return;
+
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PORT_FUNC_ENABLES,
+			 MACSEC_EN | ADAPTER_EN);
+
+	nxp_c45_macsec_write(phydev, ADPTR_CNTRL, ADPTR_CNTRL_CONFIG_EN |
+			     ADPTR_CNTRL_ADPTR_EN);
+	nxp_c45_macsec_write(phydev, ADPTR_CNTRL, ADPTR_CNTRL_ADPTR_EN);
+
+	nxp_c45_macsec_write(phydev, MACSEC_TPNET, PN_WRAP_THRESHOLD);
+
+	/* Set MKA filter. */
+	nxp_c45_macsec_write(phydev, MACSEC_UPFR0D2, ETH_P_PAE);
+	nxp_c45_macsec_write(phydev, MACSEC_UPFR0M1, MACSEC_OVP);
+	nxp_c45_macsec_write(phydev, MACSEC_UPFR0M2, ETYPE_MASK);
+	nxp_c45_macsec_write(phydev, MACSEC_UPFR0R, MACSEC_UPFR_EN);
+}
+
+static void nxp_c45_macsec_cfg_ptp(struct phy_device *phydev, bool enable)
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
+static bool nxp_c45_is_macsec_ptp_enabled(struct list_head *secy_list)
+{
+	struct nxp_c45_secy *pos, *tmp;
+
+	list_for_each_entry_safe(pos, tmp, secy_list, list)
+		if (pos->point_to_point)
+			return pos->point_to_point;
+
+	return false;
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
+	return ERR_PTR(-ENOENT);
+}
+
+static void nxp_c45_rx_sc_en(struct phy_device *phydev,
+			     struct nxp_c45_rx_sc *rx_sc,
+			     bool en)
+{
+	u32 reg = 0;
+
+	nxp_c45_macsec_read(phydev, MACSEC_RXSC_CFG, &reg);
+	if (rx_sc->rx_sc->active && en)
+		reg |= MACSEC_RXSC_CFG_SCI_EN;
+	else
+		reg &= ~MACSEC_RXSC_CFG_SCI_EN;
+	nxp_c45_macsec_write(phydev, MACSEC_RXSC_CFG, reg);
+}
+
+static int nxp_c45_tx_sc_en_flt(struct phy_device *phydev, int secy_id, bool en)
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
+
+	return 0;
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
+	nxp_c45_macsec_cfg_ptp(phydev, phy_secy->point_to_point);
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
+	nxp_c45_macsec_cfg_ptp(phydev, false);
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
+static int nxp_c45_tx_sc_set_flt(struct macsec_context *ctx,  int secy_id)
+{
+	const u8 *dev_addr = ctx->secy->netdev->dev_addr;
+	u32 tx_flt_base = TX_FLT_BASE(secy_id);
+	u32 mac_sa;
+
+	mac_sa = dev_addr[0] << 8 | dev_addr[1];
+	nxp_c45_macsec_write(ctx->phydev, TX_SC_FLT_MAC_DA_SA(tx_flt_base),
+			     mac_sa);
+	mac_sa = dev_addr[5] | dev_addr[4] << 8 |
+		dev_addr[3] << 16 | dev_addr[2] << 24;
+
+	nxp_c45_macsec_write(ctx->phydev, TX_SC_FLT_MAC_SA(tx_flt_base),
+			     mac_sa);
+	nxp_c45_macsec_write(ctx->phydev, TX_SC_FLT_MAC_CFG(tx_flt_base),
+			     TX_SC_FLT_BY_SA | TX_SC_FLT_EN | secy_id);
+
+	return 0;
+}
+
+static bool nxp_c45_port_valid(struct nxp_c45_secy *phy_secy, u16 port)
+{
+	if (phy_secy->secy->tx_sc.end_station &&
+	    __be16_to_cpu((__force __be16)port) != 1)
+		return false;
+
+	return true;
+}
+
+static bool nxp_c45_rx_sc_valid(struct nxp_c45_secy *phy_secy,
+				struct macsec_rx_sc *rx_sc)
+{
+	u16 port =  (__force u64)rx_sc->sci >> (ETH_ALEN * 8);
+
+	if (phy_secy->point_to_point && phy_secy->secy_id != 0)
+		return false;
+
+	return nxp_c45_port_valid(phy_secy, port);
+}
+
+static bool nxp_c45_secy_cfg_valid(struct nxp_c45_secy *phy_secy, bool can_ptp)
+{
+	u16 port =  (__force u64)phy_secy->secy->sci >> (ETH_ALEN * 8);
+
+	if (phy_secy->secy->tx_sc.scb)
+		return false;
+
+	if (phy_secy->secy->tx_sc.send_sci && phy_secy->secy->tx_sc.end_station)
+		return false;
+
+	if (!phy_secy->secy->tx_sc.send_sci &&
+	    !phy_secy->secy->tx_sc.end_station) {
+		if (!can_ptp)
+			return false;
+
+		if (phy_secy->secy_id != 0)
+			return false;
+
+		phy_secy->point_to_point = true;
+	} else {
+		phy_secy->point_to_point = false;
+	}
+
+	return nxp_c45_port_valid(phy_secy, port);
+}
+
+static int nxp_c45_update_tx_sc_secy_cfg(struct phy_device *phydev,
+					 struct nxp_c45_secy *phy_secy)
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
+		cfg |= MACSEC_TXSC_CFG_SCI;
+	else
+		cfg &= ~MACSEC_TXSC_CFG_SCI;
+
+	nxp_c45_macsec_write(phydev, MACSEC_TXSC_CFG, cfg);
+
+	return 0;
+}
+
+static int nxp_c45_update_rx_sc_secy_cfg(struct phy_device *phydev,
+					 struct nxp_c45_secy *phy_secy)
+{
+	struct nxp_c45_rx_sc *rx_sc = phy_secy->rx_sc;
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
+			phydev_dbg(phydev, "RX SC enabled, window will be updated\n");
+			nxp_c45_macsec_write(phydev, MACSEC_RPW,
+					     phy_secy->secy->replay_window);
+		}
+	} else {
+		cfg &= ~MACSEC_RXSC_CFG_RP;
+	}
+
+	phydev_dbg(phydev, "rx_sc->active %s\n",
+		   rx_sc->rx_sc->active ? "on" : "off");
+	if (rx_sc->rx_sc->active &&
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
+	return 0;
+}
+
+static int nxp_c45_update_key_status(struct phy_device *phydev,
+				     struct nxp_c45_tx_sa *tx_sa)
+{
+	bool key_a = tx_sa->is_key_a;
+	u32 cfg = 0;
+
+	nxp_c45_macsec_read(phydev, MACSEC_TXSC_CFG, &cfg);
+
+	cfg &= ~MACSEC_TXSC_CFG_AN_MASK;
+	cfg |= tx_sa->an << MACSEC_TXSC_CFG_AN_OFF;
+
+	if (!key_a)
+		cfg |= MACSEC_TXSC_CFG_ASA;
+	else
+		cfg &= ~MACSEC_TXSC_CFG_ASA;
+
+	tx_sa->is_enabled = tx_sa->tx_sa->active;
+	if (tx_sa->tx_sa->active)
+		cfg |= MACSEC_TXSC_CFG_SCE;
+	else
+		cfg &= ~MACSEC_TXSC_CFG_SCE;
+
+	nxp_c45_macsec_write(phydev, MACSEC_TXSC_CFG, cfg);
+
+	return 0;
+}
+
+static int nxp_c45_tx_sa_disable(struct phy_device *phydev,
+				 struct nxp_c45_secy *phy_secy)
+{
+	u32 cfg = 0;
+
+	nxp_c45_macsec_read(phydev, MACSEC_TXSC_CFG, &cfg);
+	cfg &= ~MACSEC_TXSC_CFG_SCE;
+	nxp_c45_macsec_write(phydev, MACSEC_TXSC_CFG, cfg);
+
+	return 0;
+}
+
+static int nxp_c45_txsa_set_pn(struct phy_device *phydev,
+			       struct nxp_c45_tx_sa *tx_sa)
+{
+	const struct nxp_c45_macsec_sa_regs *sa_regs;
+
+	sa_regs = nxp_c45_get_macsec_sa_regs(tx_sa->is_key_a);
+
+	nxp_c45_macsec_write(phydev, sa_regs->txsa_npn, tx_sa->next_pn);
+	nxp_c45_macsec_write(phydev, sa_regs->txsa_xnpn, tx_sa->next_pn >> 32);
+
+	return 0;
+}
+
+static int nxp_c45_txsa_get_pn(struct phy_device *phydev,
+			       struct nxp_c45_tx_sa *tx_sa)
+{
+	const struct nxp_c45_macsec_sa_regs *sa_regs;
+	u32 reg = 0;
+
+	sa_regs = nxp_c45_get_macsec_sa_regs(tx_sa->is_key_a);
+
+	nxp_c45_macsec_read(phydev, sa_regs->txsa_npn, &reg);
+	tx_sa->next_pn = reg;
+	nxp_c45_macsec_read(phydev, sa_regs->txsa_xnpn, &reg);
+	tx_sa->next_pn |= (u64)reg << 32;
+
+	return 0;
+}
+
+static int nxp_c45_set_rxsa_key_cfg(struct macsec_context *ctx,
+				    bool key_a, bool upd)
+{
+	const struct nxp_c45_macsec_sa_regs *sa_regs;
+	u64 npn = ctx->sa.rx_sa->next_pn;
+	u32 cfg;
+
+	sa_regs = nxp_c45_get_macsec_sa_regs(key_a);
+
+	if (npn && !upd) {
+		nxp_c45_macsec_write(ctx->phydev, sa_regs->rxsa_npn, npn);
+		nxp_c45_macsec_write(ctx->phydev, sa_regs->rxsa_lnpn, npn);
+		if (ctx->secy->xpn) {
+			nxp_c45_macsec_write(ctx->phydev, sa_regs->rxsa_xnpn,
+					     npn >> 32);
+			nxp_c45_macsec_write(ctx->phydev, sa_regs->rxsa_lxnpn,
+					     npn >> 32);
+		}
+	} else if (npn && upd) {
+		if (npn > ctx->secy->replay_window)
+			npn -= ctx->secy->replay_window;
+		else
+			npn = 1;
+
+		nxp_c45_macsec_write(ctx->phydev, sa_regs->rxsa_lnpn, npn);
+		if (ctx->secy->xpn)
+			nxp_c45_macsec_write(ctx->phydev, sa_regs->rxsa_lxnpn,
+					     npn >> 32);
+	}
+
+	cfg = MACSEC_RXSA_CS_A | (ctx->sa.assoc_num << MACSEC_RXSA_CS_AN_OFF);
+	cfg |= ctx->sa.rx_sa->active ? MACSEC_RXSA_CS_EN : 0;
+	nxp_c45_macsec_write(ctx->phydev, sa_regs->rxsa_cs, cfg);
+
+	return 0;
+}
+
+static int nxp_c45_txsa_set_key(struct macsec_context *ctx,
+				struct nxp_c45_tx_sa *tx_sa)
+{
+	const struct nxp_c45_macsec_sa_regs *sa_regs;
+	u32 ssci = (__force u32)tx_sa->tx_sa->ssci;
+	u32 key_size = ctx->secy->key_len / 4;
+	u32 salt_size = MACSEC_SALT_LEN / 4;
+	u32 *salt = (u32 *)tx_sa->salt;
+	u32 *key = (u32 *)tx_sa->key;
+	u32 reg;
+	int i;
+
+	sa_regs = nxp_c45_get_macsec_sa_regs(tx_sa->is_key_a);
+
+	for (i = 0; i < key_size; i++) {
+		reg = sa_regs->txsa_ka + i * 4;
+		nxp_c45_macsec_write(ctx->phydev, reg,
+				     (__force u32)cpu_to_be32(key[i]));
+	}
+
+	if (ctx->secy->xpn) {
+		for (i = 0; i < salt_size; i++) {
+			reg = sa_regs->txsa_salt + (2 - i) * 4;
+			nxp_c45_macsec_write(ctx->phydev, reg,
+					     (__force u32)cpu_to_be32(salt[i]));
+		}
+
+		nxp_c45_macsec_write(ctx->phydev, sa_regs->txsa_ssci,
+				     (__force u32)cpu_to_be32(ssci));
+	}
+
+	nxp_c45_macsec_write(ctx->phydev, sa_regs->txsa_cs, MACSEC_TXSA_CS_A);
+
+	return 0;
+}
+
+static int nxp_c45_commit_rx_sc_cfg(struct phy_device *phydev,
+				    struct nxp_c45_secy *phy_secy)
+{
+	struct nxp_c45_rx_sc *rx_sc = phy_secy->rx_sc;
+	u64 sci = (__force u64)rx_sc->rx_sc->sci;
+
+	nxp_c45_macsec_write(phydev, MACSEC_RXSC_SCI_1H,
+			     (__force u32)cpu_to_be32(sci));
+	nxp_c45_macsec_write(phydev, MACSEC_RXSC_SCI_2H,
+			     (__force u32)cpu_to_be32(sci >> 32));
+
+	return nxp_c45_update_rx_sc_secy_cfg(phydev, phy_secy);
+}
+
+static int nxp_c45_disable_rxsa_key(struct phy_device *phydev, bool key_a)
+{
+	const struct nxp_c45_macsec_sa_regs *sa_regs;
+	u32 reg = 0;
+
+	sa_regs = nxp_c45_get_macsec_sa_regs(key_a);
+
+	nxp_c45_macsec_read(phydev, sa_regs->rxsa_cs, &reg);
+	reg &= ~MACSEC_RXSA_CS_EN;
+	nxp_c45_macsec_write(phydev, sa_regs->rxsa_cs, reg);
+
+	return 0;
+}
+
+static int nxp_c45_rx_sc_del(struct phy_device *phydev,
+			     struct nxp_c45_rx_sc *rx_sc)
+{
+	nxp_c45_macsec_write(phydev, MACSEC_RXSC_CFG, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_RXSC_SCI_1H, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_RXSC_SCI_2H, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_RPW, 0);
+
+	if (rx_sc->rx_sa_a)
+		nxp_c45_disable_rxsa_key(phydev, true);
+
+	if (rx_sc->rx_sa_b)
+		nxp_c45_disable_rxsa_key(phydev, false);
+
+	return 0;
+}
+
+static int nxp_c45_set_rxsa_key(struct macsec_context *ctx, bool key_a)
+{
+	u32 *salt = (u32 *)ctx->sa.rx_sa->key.salt.bytes;
+	const struct nxp_c45_macsec_sa_regs *sa_regs;
+	u32 ssci = (__force u32)ctx->sa.rx_sa->ssci;
+	u32 key_size = ctx->secy->key_len / 4;
+	u32 salt_size = MACSEC_SALT_LEN / 4;
+	u32 *key = (u32 *)ctx->sa.key;
+	u32 reg;
+	int i;
+
+	sa_regs = nxp_c45_get_macsec_sa_regs(key_a);
+
+	for (i = 0; i < key_size; i++) {
+		reg = sa_regs->rxsa_ka + i * 4;
+		nxp_c45_macsec_write(ctx->phydev, reg,
+				     (__force u32)cpu_to_be32(key[i]));
+	}
+
+	if (ctx->secy->xpn) {
+		for (i = 0; i < salt_size; i++) {
+			reg = sa_regs->rxsa_salt + (2 - i) * 4;
+			nxp_c45_macsec_write(ctx->phydev, reg,
+					     (__force u32)cpu_to_be32(salt[i]));
+		}
+		nxp_c45_macsec_write(ctx->phydev, sa_regs->rxsa_ssci,
+				     (__force u32)cpu_to_be32(ssci));
+	}
+
+	nxp_c45_set_rxsa_key_cfg(ctx, key_a, false);
+
+	return 0;
+}
+
+static void nxp_c45_tx_sc_clear(struct nxp_c45_secy *phy_secy)
+{
+	struct nxp_c45_tx_sa **tx_sa;
+	u8 i;
+
+	tx_sa = phy_secy->tx_sa;
+	for (i = 0; i < ARRAY_SIZE(phy_secy->tx_sa); i++) {
+		kfree(tx_sa[i]);
+		tx_sa[i] = NULL;
+	}
+}
+
+static int nxp_c45_mdo_add_secy(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	u64 sci = (__force u64)ctx->secy->sci;
+	struct nxp_c45_secy *phy_secy;
+	bool can_ptp;
+	int idx;
+	u32 reg;
+
+	phydev_dbg(ctx->phydev, "add secy SCI %llu\n", ctx->secy->sci);
+
+	if (!nxp_c45_mac_addr_free(ctx))
+		return -EBUSY;
+
+	if (nxp_c45_is_macsec_ptp_enabled(&priv->macsec->secy_list))
+		return -EBUSY;
+
+	idx = find_first_zero_bit(priv->macsec->tx_sc_bitmap, TX_SC_MAX);
+	if (idx == TX_SC_MAX)
+		return -EBUSY;
+
+	phy_secy = kzalloc(sizeof(*phy_secy), GFP_KERNEL);
+	if (!phy_secy)
+		return -ENOMEM;
+
+	phy_secy->secy = ctx->secy;
+	phy_secy->secy_id = idx;
+	phy_secy->enabled_an = ctx->secy->tx_sc.encoding_sa;
+	phy_secy->tx_sa_key_a = true;
+
+	/* If the point to point mode should be enabled, we should have only
+	 * one secy enabled, respectively the new one.
+	 */
+	can_ptp = list_count_nodes(&priv->macsec->secy_list) == 0;
+	if (!nxp_c45_secy_cfg_valid(phy_secy, can_ptp)) {
+		kfree(phy_secy);
+		return -EINVAL;
+	}
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	nxp_c45_macsec_write(phydev, MACSEC_TXSC_SCI_1H,
+			     (__force u32)cpu_to_be32(sci));
+	nxp_c45_macsec_write(phydev, MACSEC_TXSC_SCI_2H,
+			     (__force u32)cpu_to_be32(sci >> 32));
+	nxp_c45_tx_sc_set_flt(ctx, phy_secy->secy_id);
+	nxp_c45_update_tx_sc_secy_cfg(phydev, phy_secy);
+	if (phy_interrupt_is_valid(phydev)) {
+		nxp_c45_macsec_read(phydev, MACSEC_EVER, &reg);
+		reg |= TX_SC_BIT(phy_secy->secy_id);
+		nxp_c45_macsec_write(phydev, MACSEC_EVER, reg);
+	}
+	set_bit(idx, priv->macsec->tx_sc_bitmap);
+	list_add_tail(&phy_secy->list, &priv->macsec->secy_list);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_upd_secy(struct macsec_context *ctx)
+{
+	struct nxp_c45_tx_sa *new_tx_sa, *old_tx_sa;
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	bool can_ptp;
+
+	phydev_dbg(phydev, "update secy SCI %llu\n", ctx->secy->sci);
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	if (!nxp_c45_mac_addr_free(ctx))
+		return -EBUSY;
+
+	/* If the point to point mode should be enabled, we should have only
+	 * one secy enabled, respectively the new one.
+	 */
+	can_ptp = list_count_nodes(&priv->macsec->secy_list) == 1;
+	if (!nxp_c45_secy_cfg_valid(phy_secy, can_ptp))
+		return -EINVAL;
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	nxp_c45_tx_sc_set_flt(ctx, phy_secy->secy_id);
+	nxp_c45_update_tx_sc_secy_cfg(phydev, phy_secy);
+
+	if (phy_secy->enabled_an != ctx->secy->tx_sc.encoding_sa) {
+		old_tx_sa = phy_secy->tx_sa[phy_secy->enabled_an];
+		phy_secy->enabled_an = ctx->secy->tx_sc.encoding_sa;
+		new_tx_sa = phy_secy->tx_sa[phy_secy->enabled_an];
+		if (!new_tx_sa) {
+			nxp_c45_tx_sa_disable(phydev, phy_secy);
+			goto disable_old_tx_sa;
+		}
+
+		if (!new_tx_sa->tx_sa->active) {
+			nxp_c45_tx_sa_disable(phydev, phy_secy);
+			goto disable_old_tx_sa;
+		}
+
+		new_tx_sa->is_key_a = phy_secy->tx_sa_key_a;
+		phy_secy->tx_sa_key_a = phy_secy->tx_sa_key_a;
+		nxp_c45_txsa_set_key(ctx, new_tx_sa);
+		nxp_c45_txsa_set_pn(phydev, new_tx_sa);
+		nxp_c45_update_key_status(phydev, new_tx_sa);
+
+disable_old_tx_sa:
+		if (old_tx_sa) {
+			old_tx_sa->is_enabled = false;
+			nxp_c45_txsa_get_pn(phydev, old_tx_sa);
+		}
+	}
+
+	if (test_bit(phy_secy->secy_id, priv->macsec->secy_bitmap))
+		nxp_c45_macsec_cfg_ptp(phydev, phy_secy->point_to_point);
+
+	if (phy_secy->rx_sc)
+		nxp_c45_update_rx_sc_secy_cfg(phydev, phy_secy);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_del_secy(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	u32 reg;
+
+	phydev_dbg(phydev, "delete secy SCI %llu\n", ctx->secy->sci);
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	nxp_c45_mdo_dev_stop(ctx);
+	nxp_c45_tx_sa_disable(phydev, phy_secy);
+	nxp_c45_tx_sc_clear(phy_secy);
+	if (phy_secy->rx_sc) {
+		nxp_c45_rx_sc_del(phydev, phy_secy->rx_sc);
+		kfree(phy_secy->rx_sc);
+	}
+
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
+	struct nxp_c45_rx_sc *rx_sc;
+
+	phydev_dbg(phydev, "add RX SC %s\n",
+		   ctx->rx_sc->active ? "enabled" : "disabled");
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	if (phy_secy->rx_sc)
+		return -ENOMEM;
+
+	if (!nxp_c45_rx_sc_valid(phy_secy, ctx->rx_sc))
+		return -EINVAL;
+
+	rx_sc = kzalloc(sizeof(*rx_sc), GFP_KERNEL);
+	if (!rx_sc)
+		return -ENOMEM;
+
+	phy_secy->rx_sc = rx_sc;
+	rx_sc->rx_sc = ctx->rx_sc;
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	nxp_c45_commit_rx_sc_cfg(phydev, phy_secy);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_upd_rxsc(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	struct nxp_c45_rx_sc *rx_sc;
+
+	phydev_dbg(phydev, "update RX SC %llu %s\n", ctx->rx_sc->sci,
+		   ctx->rx_sc->active ? "enabled" : "disabled");
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	rx_sc = phy_secy->rx_sc;
+	if (rx_sc->rx_sc != ctx->rx_sc)
+		return -EINVAL;
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	nxp_c45_commit_rx_sc_cfg(phydev, phy_secy);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_del_rxsc(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	struct nxp_c45_rx_sc *rx_sc;
+
+	phydev_dbg(phydev, "delete RX SC %llu %s\n", ctx->rx_sc->sci,
+		   ctx->rx_sc->active ? "enabled" : "disabled");
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	rx_sc = phy_secy->rx_sc;
+	if (rx_sc->rx_sc != ctx->rx_sc)
+		return -EINVAL;
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	nxp_c45_rx_sc_del(phydev, rx_sc);
+	kfree(rx_sc);
+	phy_secy->rx_sc = NULL;
+
+	return 0;
+}
+
+static int nxp_c45_mdo_add_rxsa(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	struct nxp_c45_rx_sc *rx_sc;
+	struct macsec_rx_sa *rx_sa;
+	u8 an = ctx->sa.assoc_num;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	rx_sc = phy_secy->rx_sc;
+	if (rx_sc->rx_sc != ctx->sa.rx_sa->sc)
+		return -EINVAL;
+
+	rx_sa = ctx->sa.rx_sa;
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	if (!rx_sc->rx_sa_a) {
+		phydev_dbg(phydev, "add RX SA A %u %s\n",
+			   an, rx_sa->active ? "enabled" : "disabled");
+		nxp_c45_set_rxsa_key(ctx, true);
+		rx_sc->rx_sa_a = rx_sa;
+		return 0;
+	}
+
+	if (!rx_sc->rx_sa_b) {
+		phydev_dbg(phydev, "add RX SA B %u %s\n",
+			   an, rx_sa->active ? "enabled" : "disabled");
+		nxp_c45_set_rxsa_key(ctx, false);
+		rx_sc->rx_sa_b = rx_sa;
+		return 0;
+	}
+
+	return -ENOMEM;
+}
+
+static int nxp_c45_mdo_upd_rxsa(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	struct nxp_c45_rx_sc *rx_sc;
+	struct macsec_rx_sa *rx_sa;
+	u8 an = ctx->sa.assoc_num;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	rx_sc = phy_secy->rx_sc;
+	if (rx_sc->rx_sc != ctx->sa.rx_sa->sc)
+		return -EINVAL;
+
+	rx_sa = ctx->sa.rx_sa;
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	if (rx_sc->rx_sa_a == rx_sa) {
+		phydev_dbg(phydev, "update RX SA A %u %s\n",
+			   an, rx_sa->active ? "enabled" : "disabled");
+		nxp_c45_set_rxsa_key_cfg(ctx, true, true);
+		return 0;
+	}
+
+	if (rx_sc->rx_sa_b == rx_sa) {
+		phydev_dbg(phydev, "update RX SA B %u %s\n",
+			   an, rx_sa->active ? "enabled" : "disabled");
+		nxp_c45_set_rxsa_key_cfg(ctx, false, true);
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+static int nxp_c45_mdo_del_rxsa(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	struct nxp_c45_rx_sc *rx_sc;
+	struct macsec_rx_sa *rx_sa;
+	u8 an = ctx->sa.assoc_num;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	rx_sc = phy_secy->rx_sc;
+	if (rx_sc->rx_sc != ctx->sa.rx_sa->sc)
+		return -EINVAL;
+
+	rx_sa = ctx->sa.rx_sa;
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	if (rx_sc->rx_sa_a == rx_sa) {
+		phydev_dbg(phydev, "delete RX SA A %u %s\n",
+			   an, rx_sa->active ? "enabled" : "disabled");
+		nxp_c45_disable_rxsa_key(phydev, true);
+		rx_sc->rx_sa_a = NULL;
+		return 0;
+	}
+
+	if (rx_sc->rx_sa_b == rx_sa) {
+		phydev_dbg(phydev, "delete RX SA B %u %s\n",
+			   an, rx_sa->active ? "enabled" : "disabled");
+		nxp_c45_disable_rxsa_key(phydev, false);
+		rx_sc->rx_sa_b = NULL;
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+static int nxp_c45_mdo_add_txsa(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	struct nxp_c45_tx_sa *tx_sa;
+	u8 sa = ctx->sa.assoc_num;
+
+	phydev_dbg(phydev, "add TX SA %u %s\n", ctx->sa.assoc_num,
+		   ctx->sa.tx_sa->active ? "enabled" : "disabled");
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	if (phy_secy->tx_sa[sa])
+		return -EBUSY;
+
+	tx_sa = kzalloc(sizeof(*tx_sa), GFP_KERNEL);
+	tx_sa->an = ctx->sa.assoc_num;
+	memcpy(tx_sa->key, ctx->sa.key, MACSEC_MAX_KEY_LEN);
+	memcpy(tx_sa->salt, ctx->sa.tx_sa->key.salt.bytes, MACSEC_SALT_LEN);
+	tx_sa->tx_sa = ctx->sa.tx_sa;
+	tx_sa->next_pn = ctx->sa.tx_sa->next_pn;
+	phy_secy->tx_sa[sa] = tx_sa;
+
+	if (tx_sa->an == phy_secy->enabled_an && tx_sa->tx_sa->active) {
+		nxp_c45_select_secy(phydev, phy_secy->secy_id);
+		tx_sa->is_key_a = phy_secy->tx_sa_key_a;
+		phy_secy->tx_sa_key_a = !phy_secy->tx_sa_key_a;
+		nxp_c45_txsa_set_key(ctx, tx_sa);
+		nxp_c45_txsa_set_pn(phydev, tx_sa);
+		nxp_c45_update_key_status(phydev, tx_sa);
+	}
+
+	return 0;
+}
+
+static int nxp_c45_mdo_upd_txsa(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	u64 next_pn = ctx->sa.tx_sa->next_pn;
+	struct nxp_c45_secy *phy_secy;
+	struct nxp_c45_tx_sa *tx_sa;
+	u8 sa = ctx->sa.assoc_num;
+
+	phydev_dbg(phydev, "update TX SA %u %s\n", ctx->sa.assoc_num,
+		   ctx->sa.tx_sa->active ? "enabled" : "disabled");
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	tx_sa = phy_secy->tx_sa[sa];
+	if (!tx_sa)
+		return -EINVAL;
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	if (tx_sa->is_enabled && tx_sa->tx_sa->active && next_pn) {
+		tx_sa->next_pn = next_pn;
+		nxp_c45_txsa_set_pn(phydev, tx_sa);
+
+		return 0;
+	}
+
+	if (tx_sa->is_enabled && !tx_sa->tx_sa->active) {
+		if (next_pn)
+			tx_sa->next_pn = next_pn;
+		else
+			nxp_c45_txsa_get_pn(phydev, tx_sa);
+
+		nxp_c45_update_key_status(phydev, tx_sa);
+
+		return 0;
+	}
+
+	if (!tx_sa->is_enabled && tx_sa->tx_sa->active &&
+	    tx_sa->an == phy_secy->enabled_an) {
+		if (next_pn)
+			tx_sa->next_pn = next_pn;
+
+		tx_sa->is_key_a = phy_secy->tx_sa_key_a;
+		phy_secy->tx_sa_key_a = !phy_secy->tx_sa_key_a;
+		nxp_c45_txsa_set_key(ctx, tx_sa);
+		nxp_c45_txsa_set_pn(phydev, tx_sa);
+		nxp_c45_update_key_status(phydev, tx_sa);
+
+		return 0;
+	}
+
+	if (!tx_sa->is_enabled && !tx_sa->tx_sa->active)
+		tx_sa->next_pn = next_pn;
+
+	return 0;
+}
+
+static int nxp_c45_mdo_del_txsa(struct macsec_context *ctx)
+{
+	struct macsec_tx_sa *ctx_sa = ctx->sa.tx_sa;
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *phy_secy;
+	struct nxp_c45_tx_sa *tx_sa;
+	u8 sa = ctx->sa.assoc_num;
+
+	phydev_dbg(phydev, "delete TX SA %u %s\n", sa,
+		   ctx_sa->active ? "enabled" : "disabled");
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	tx_sa = phy_secy->tx_sa[sa];
+	if (!tx_sa)
+		return -EINVAL;
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	if (tx_sa->is_enabled)
+		nxp_c45_update_key_status(phydev, tx_sa);
+
+	phy_secy->tx_sa[sa] = NULL;
+	kfree(tx_sa);
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
+int nxp_c45_macsec_probe(struct phy_device *phydev)
+{
+	struct nxp_c45_phy *priv = phydev->priv;
+
+	priv->macsec = kzalloc(sizeof(*priv->macsec), GFP_KERNEL);
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
+	struct nxp_c45_tx_sa *tx_sa;
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
+		phydev_dbg(phydev, "pn_wrapped: tx sc %d, tx sa an %u\n",
+			   pos->secy_id, pos->enabled_an);
+		tx_sa = pos->tx_sa[pos->enabled_an];
+		macsec_pn_wrapped(pos->secy, tx_sa->tx_sa);
+		nxp_c45_macsec_write(phydev, MACSEC_EVR,
+				     TX_SC_BIT(pos->secy_id));
+		*ret = IRQ_HANDLED;
+	} while (reg);
+}
diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 7ab080ff02df..5bf7caa4e63d 100644
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
@@ -1614,6 +1611,7 @@ static int nxp_c45_config_init(struct phy_device *phydev)
 
 	nxp_c45_counters_enable(phydev);
 	nxp_c45_ptp_init(phydev);
+	nxp_c45_macsec_config_init(phydev);
 
 	return nxp_c45_start_op(phydev);
 }
@@ -1629,7 +1627,9 @@ static int nxp_c45_get_features(struct phy_device *phydev)
 static int nxp_c45_probe(struct phy_device *phydev)
 {
 	struct nxp_c45_phy *priv;
-	int ptp_ability;
+	bool macsec_ability;
+	int phy_abilities;
+	bool ptp_ability;
 	int ret = 0;
 
 	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
@@ -1645,9 +1645,9 @@ static int nxp_c45_probe(struct phy_device *phydev)
 
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
@@ -1666,6 +1666,20 @@ static int nxp_c45_probe(struct phy_device *phydev)
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
index 000000000000..905c5afb0a5e
--- /dev/null
+++ b/drivers/net/phy/nxp-c45-tja11xx.h
@@ -0,0 +1,55 @@
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
+void nxp_c45_macsec_config_init(struct phy_device *phydev);
+void nxp_c45_handle_macsec_interrupt(struct phy_device *phydev,
+				     irqreturn_t *ret);
+int nxp_c45_macsec_probe(struct phy_device *phydev);
+#else
+static inline
+void nxp_c45_macsec_config_init(struct phy_device *phydev)
+{
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

