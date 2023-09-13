Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B4079E959
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241041AbjIMNcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240934AbjIMNck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:32:40 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2048.outbound.protection.outlook.com [40.107.8.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2581E1BC8;
        Wed, 13 Sep 2023 06:32:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPmC5BKiVGL0+7rTe0rUKYW+MlOVcko6rh4tps0XWP+ltfJ8HIc8QOTchkc709MQxYBuEgWKsMEVGz9dp+Zfgclz8il/lxduCRo8UW/eXbDeQRSXASc+9CmdWmqG7NOjIuOEXU8uGvc4CiacFPOCZjlPbO8hGIJe65vR5ah5i+5f4woOmYcPIRx9GtEeKRMzjTkIX/iM1wxanjirHAOF4edMK9sGZX5RGPSDkj6vyrq8LG4VWa3jMho1uG4LpwaV8GaD2XXhMZ1BM0A6AJZdeh9WZ8hia3ynP5l0qKpHzSeSeC0ActxPcP0H+CBWc2lERk6DlsWZpjIS/PJCwIVcKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhUktNH8zrcSA2FQ7usmA/ZK5EKutY6GMXkqgL4n0Hk=;
 b=jNWQRSy/NScBhuWA3GXuAKmLcwbEEsdGeDMpPdkq/ALeyCzUvn3z4/F4XQaeIRrF1rzYdVFBJqdNDiXE1ds7krmhP9UY0+VXrAeqdobO5sdveshuek/ScMcjKiclWd7A/cptq/W5RHLce/Kof7svWHsvVsPnumiJEm7J65aiKrbUGwHN1OAXa0YzHuAsmLlF9bhlAiHM/SgWxAUHwO0Di6XwOjSRheNOdILyZGC2/m1A5x/ZLF49XVhPUtgu60Vo6YM/MQzlhfz2ULcMMobiEP5Pn86BBVaDN2jMovs/SnRXyuoi4243SzcbBD+0/S1ER8Fo2Y1dg5Ti5uyRCwe3jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhUktNH8zrcSA2FQ7usmA/ZK5EKutY6GMXkqgL4n0Hk=;
 b=O/AR5UoNhPlbInff5Kwr6DDyultPYcf+3YmgPEAjil+xYpcwUESazaQ7XRyqYzTUbLESjA6p4qlBVHg0LFwgG0+msiEeudzDR6VqMj3XVnJ6V9OjhPlxgvZU2mAZBnsc86mlqZQINJqLb5u9M69+Jh6nqHpT5eLouds00Vzle2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM8PR04MB7235.eurprd04.prod.outlook.com (2603:10a6:20b:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 13:32:27 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 13:32:27 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [RFC net-next v4 5/7] net: phy: nxp-c45-tja11xx: add MACsec support
Date:   Wed, 13 Sep 2023 16:32:03 +0300
Message-Id: <20230913133205.3749628-6-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913133205.3749628-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230913133205.3749628-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA2P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::10) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM8PR04MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: ae438e80-b834-49d4-4ee6-08dbb45dded2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YdDXYP2Pj5ISDpgph0NFTKEK0G2g1eFD4qUbAdLKOi2a5oHaAdrwaXBzuFJEpQnAVBQ5Xz1NigN9iJVJbMth98nCda3Zb/W/Vif1I2R2l8+pbsgxX4Y/P52TvRg3Qx68yYsYz7ufDlhThXN2HBkvpPXXRQ4XsPg5QUkHyamOc0m0NcyUr5g89xs5RRtAeD0pmawTW6W+oVYTwTTl3ZKkqMB/Og+3vAYOgbj1cYtn3DKkVRVGae3h7PdHMJ44n+RPTqJr8flRpfOV9blfUp6yQI3cRZX+PRKfovAviROPG0bgj70YDpuAdVo2YJTO62Vja1TXWbPoS2zuklp/9Ctx+8a7eRlvXfhKI4wr9WETVgDjQr6qMjf+HlkYzUhgwZ5vrF0Q+acO4FwH7bsd0hHY8QPE1QsJUik1dwPvii6JOZupJ4PXk1SmVgJZtszMlNA0Ym4aAWmRwKtft1Uk88iqkug6UExE5BBhxzVwdGdxTIHEGt/y6ZjTSCtyM16PvnAqNva+BstqRCxxe0sUEgiYKVzV1tlFqW6SbgeP+WdJExuNTZj1H/yU6XV6134s0SqMHaOn3GDswC2zN5A6wuu+p2gqJKGkusWlc3GbqMJ/mArn0dfAJLVuZh+YUJ0taAmePG0M13dbp3dwwOUXfJCgaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(136003)(366004)(186009)(451199024)(1800799009)(26005)(4326008)(8936002)(8676002)(52116002)(6666004)(1076003)(38100700002)(921005)(2616005)(478600001)(83380400001)(5660300002)(66476007)(66556008)(66946007)(41300700001)(6506007)(6486002)(316002)(6512007)(7416002)(30864003)(2906002)(86362001)(38350700002)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jR0sP01y7CW9vq24GsVlZCFqhhn/GCyCUPXofmwqJdp/AJqJLz/xC/O+aIFo?=
 =?us-ascii?Q?d1RiUToccMHfH5Kn7Rnn9Fb9nDDs3E+VhuivSGCKZ5Y+3tjqFdufUPx4fWf4?=
 =?us-ascii?Q?0aMwzzWI3uV+FWRpYZdwEGCxWZE2mK9zbkYuIGXAhOGvrrn7ooy7zUTsjSvv?=
 =?us-ascii?Q?FrWdxCeXvXGDnfLqnjojMGRqwFTdGJMecrCDL0iomq65t5mKy4RZOM8BhIbs?=
 =?us-ascii?Q?QPQNgIzuH+SJGv/F8VQFf2dewrFr700Y4Y7RwqFXWzc215hC/opgpFu4LXJB?=
 =?us-ascii?Q?+xcuwj7QiQLTnGa7D0vrc0KIS61Nh+fnCJ8GJO+yq108uMp6te23nSM/+4MG?=
 =?us-ascii?Q?ZUAo5NBPUUnTHU+QJfF/odx7aZo1tJm9VyqBC0ZzeTVJEjJ13oPHHWkubHd7?=
 =?us-ascii?Q?3FOWvJmPb+XgIKKGTAOv6WOvMFaT+pEdL3EvIvbjPNXkd7GWUiHAmzzSRc12?=
 =?us-ascii?Q?ETzrR9l9vTVDBp50zp6zbKGQK9dmO6fXpn3F63/FgJfINJ3RBURwjlC8uAu6?=
 =?us-ascii?Q?xC9hRKxAXNmkA8AUHLEXiX6boLiAhYyBVrGTz7g4VtmF1XVALLpVJLIpp6hG?=
 =?us-ascii?Q?J5YpZkbtqLou01JXO725O+c0U98Jhz8Ihb3z5AMiGMuAdmIv62jEnghnava5?=
 =?us-ascii?Q?RHugIdq6tUEfXiZYov6A9Z/9C1hNK1RCTK5KRn+yVnqf7i/SsuucBTiCUnq3?=
 =?us-ascii?Q?JqiwXSBdUEZ+r+w1Ro15JURz9pCYZcU1/nWXhxoXJ8mBzsMHWpaM6b4N07ei?=
 =?us-ascii?Q?FLraLOIE/8pkfUr7wHwYxP8u+17/Jak8ArgYQnrLdounQGvnsMl1kgfKDjmY?=
 =?us-ascii?Q?XGS1WnBSa6hcNXUfu1cVt81Nkq9SeQz/ppM0HNZuL/xOqXGUyv9s2tlz8tDs?=
 =?us-ascii?Q?uVIlZvKl9ACfvXwqXJWemCxBsLqpTIGjPW0BRx88C4a9zMftPlgq3qcLruyw?=
 =?us-ascii?Q?j2cTmws9eRsRiF3MRy28Gpu2KVBlw0cJ5SmM3Ha2sh/8qDVCsi/FnppaSfHi?=
 =?us-ascii?Q?SV+HDqcFfubCkX3G0rdTso8iUfbAIn5UmZEuUuuqppsQRx4TvgPV2sqVp2sl?=
 =?us-ascii?Q?HfCqfIi7WSJmNHx7BL5FcsYgfdfRnGHd7MVJjUXLRJSQD+r5NEodkWMI/+Mu?=
 =?us-ascii?Q?CRGSAjx9Jot64abIkTLNuy8ZFZvHAfIh9vhvt0BInkTqPmuWDTwDAgAcVpta?=
 =?us-ascii?Q?X+77x8XxzYZ9+RPtCPDu58rgUjh/KpEc7TxzO0mp9ppj3ER3JDE9C0iij4IF?=
 =?us-ascii?Q?TJUtwqJB+AvZygH+YUNgM/NumDIZmBhBCiklpaKCMNO+mmNAJYSMvWXYIAdX?=
 =?us-ascii?Q?f96imZRr0M8NYW7cz1OnFZ63Mdik7JXpG697PfEDhxRZYxijs+3XyTKXPR5M?=
 =?us-ascii?Q?72KvlRszn4VA23bP2mBtCpvXk7lzf4fk/bAReZiF4CLjG15rg7qulU78mIAT?=
 =?us-ascii?Q?HWt4l+GvoQtO1foUopHQvHAGcIjvTh1Pf5lUCjColLpXm/8WYlyNVOk3TOjC?=
 =?us-ascii?Q?SjpXrS7LCYSQ/SmN1uTGXs6FaLHkCdif65CtIlaCHNsGUUDvRM8itw3JWJMS?=
 =?us-ascii?Q?jKiCzn1+Uwilv2Rofau6WGg7h9Tt4v4ckYl3AepnL5n30tcAg6lUWL2V3FeB?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae438e80-b834-49d4-4ee6-08dbb45dded2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 13:32:26.9049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emM5Vqt2ioztm2HhuAmp6Q6jCnry4BMHN7tA/O8DW7IG9T6J8SytdUsghkcoVPcV75VlQAXstd1A3oiwlcw8HUGPTBrZCwnlcb7OP4DQdJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7235
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
Changes in V4:
- Added nxp_c45_secy_free.
- Added nxp_c45_macsec_en.
- Added nxp_c45_macsec_remove.
- nxp_c45_sa_set_pn does if the pn is 0. validate_upd_sa checks this.
- check ctx->sa.update_pn flag before updating next_pn.
- nxp_c45_macsec_config_init and nxp_c45_handle_macsec_interrupt are
checking priv->macsec instead of phydev->macsec_ops to check if macsec is
offloaded.
- nxp_c45_handle_macsec_interrupt - replaced WARN_ON(!sa) with 
WARN_ON(1). sa is either -err_value or a valid pointer and WARN_ON was
doing nothing.
- nxp_c45_tx_sa_update does not check if (sa->an != encoding_sa).
encoding_sa removed from parameters list.
- nxp_c45_mdo_upd/del_txsa updates the sa status only if sa->an ==
encoding_sa
- nxp_c45_mdo_add_rxsc - apply RX SCI restrictions only if end_station is
true

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
- phydev->macsec allocated using devm_kzalloc
- changed name of the driver object file

Changes in v2:
- WARN_ON_ONCE if reg address is not properly aligned
- improved patch description

 MAINTAINERS                              |    2 +-
 drivers/net/phy/Kconfig                  |    2 +-
 drivers/net/phy/Makefile                 |    6 +-
 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 1334 ++++++++++++++++++++++
 drivers/net/phy/nxp-c45-tja11xx.c        |   75 +-
 drivers/net/phy/nxp-c45-tja11xx.h        |   62 +
 6 files changed, 1449 insertions(+), 32 deletions(-)
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
index 000000000000..fb7f1cb62a6e
--- /dev/null
+++ b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
@@ -0,0 +1,1334 @@
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
+static void nxp_c45_secy_free(struct nxp_c45_secy *phy_secy)
+{
+	list_del(&phy_secy->list);
+	kfree(phy_secy);
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
+				 struct nxp_c45_sa *sa, bool en)
+{
+	u32 cfg = 0;
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
+static void nxp_c45_macsec_en(struct phy_device *phydev, bool en)
+{
+	u32 reg;
+
+	nxp_c45_macsec_read(phydev, MACSEC_CFG, &reg);
+	if (en)
+		reg |= MACSEC_CFG_BYPASS;
+	else
+		reg &= ~MACSEC_CFG_BYPASS;
+	nxp_c45_macsec_write(phydev, MACSEC_CFG, reg);
+}
+
+static int nxp_c45_mdo_dev_open(struct macsec_context *ctx)
+{
+	struct nxp_c45_phy *priv = ctx->phydev->priv;
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_secy *phy_secy;
+	int any_bit_set;
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
+	if (any_bit_set == TX_SC_MAX)
+		nxp_c45_macsec_en(phydev, true);
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
+	if (any_bit_set == TX_SC_MAX)
+		nxp_c45_macsec_en(phydev, false);
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
+	nxp_c45_tx_sa_update(phydev, &next_sa, ctx->secy->operational);
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
+	nxp_c45_tx_sa_update(phydev, &next_sa, false);
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
+	nxp_c45_secy_free(phy_secy);
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
+	if (phy_secy->secy->tx_sc.end_station &&
+	    !nxp_c45_sci_valid(ctx->rx_sc->sci, ctx->secy->tx_sc.scb))
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
+	if (ctx->sa.update_pn)
+		nxp_c45_sa_set_pn(phydev, sa, rx_sa->next_pn,
+				  ctx->secy->replay_window);
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
+	if (ctx->secy->tx_sc.encoding_sa  == sa->an)
+		nxp_c45_tx_sa_update(phydev, sa, tx_sa->active);
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
+	if (ctx->sa.update_pn)
+		nxp_c45_sa_set_pn(phydev, sa, tx_sa->next_pn, 0);
+	if (ctx->secy->tx_sc.encoding_sa == sa->an)
+		nxp_c45_tx_sa_update(phydev, sa, tx_sa->active);
+
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
+	if (ctx->secy->tx_sc.encoding_sa  == sa->an)
+		nxp_c45_tx_sa_update(phydev, sa, false);
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
+	struct nxp_c45_phy *priv = phydev->priv;
+	int ret;
+
+	if (!priv->macsec)
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
+void nxp_c45_macsec_remove(struct phy_device *phydev)
+{
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_secy *secy_p, *secy_t;
+	struct nxp_c45_sa *sa_p, *sa_t;
+	struct list_head *secy_list;
+
+	if (!priv->macsec)
+		return;
+
+	secy_list = &priv->macsec->secy_list;
+	nxp_c45_macsec_en(phydev, false);
+
+	list_for_each_entry_safe(secy_p, secy_t, secy_list, list) {
+		list_for_each_entry_safe(sa_p, sa_t, &secy_p->sa_list, list)
+			nxp_c45_sa_free(sa_p);
+		nxp_c45_secy_free(secy_p);
+	}
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
+	if (!priv->macsec)
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
+			WARN_ON(1);
+
+		nxp_c45_macsec_write(phydev, MACSEC_EVR,
+				     TX_SC_BIT(pos->secy_id));
+		*ret = IRQ_HANDLED;
+	} while (reg);
+}
diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 7ab080ff02df..315c2149e4cb 100644
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
@@ -1679,6 +1695,7 @@ static void nxp_c45_remove(struct phy_device *phydev)
 
 	skb_queue_purge(&priv->tx_queue);
 	skb_queue_purge(&priv->rx_queue);
+	nxp_c45_macsec_remove(phydev);
 }
 
 static void tja1103_counters_enable(struct phy_device *phydev)
diff --git a/drivers/net/phy/nxp-c45-tja11xx.h b/drivers/net/phy/nxp-c45-tja11xx.h
new file mode 100644
index 000000000000..f364fca68f0b
--- /dev/null
+++ b/drivers/net/phy/nxp-c45-tja11xx.h
@@ -0,0 +1,62 @@
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
+int nxp_c45_macsec_probe(struct phy_device *phydev);
+void nxp_c45_macsec_remove(struct phy_device *phydev);
+void nxp_c45_handle_macsec_interrupt(struct phy_device *phydev,
+				     irqreturn_t *ret);
+#else
+static inline
+int nxp_c45_macsec_config_init(struct phy_device *phydev)
+{
+	return 0;
+}
+
+static inline
+int nxp_c45_macsec_probe(struct phy_device *phydev)
+{
+	return 0;
+}
+
+static inline
+void nxp_c45_macsec_remove(struct phy_device *phydev)
+{
+}
+
+static inline
+void nxp_c45_handle_macsec_interrupt(struct phy_device *phydev,
+				     irqreturn_t *ret)
+{
+}
+#endif
-- 
2.34.1

