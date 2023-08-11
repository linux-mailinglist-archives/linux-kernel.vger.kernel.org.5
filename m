Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268B9779337
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236661AbjHKPeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236624AbjHKPdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:33:52 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EB410E4;
        Fri, 11 Aug 2023 08:33:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHt6cH9/YOxLrCo/V8jDV08AN0a6P0op2KxZxrfRc8KsfzaGScwfrAn0+Qsxp1REdGBXxhUD9LlE3xU2HzMDQCQSQ9kT3ONZl+NtmljUXGD/mYB9iJNqvfRNJa3kGDfIH+rM71y/Y4PnzK+XxN/9ZkN4s0toaSsHr3cDlSCsrjX/mNAZrzvoxI9JeKhZk9O9ZYaw2ZVYaR8ASSKidfpRP7YB9BVLxWEHW4RLLki0tQKfrG03kU/GpoYVelPNqHLvbuSX1YmMldXNvBVHVlsQHsaxXKHcvVRMOF+PedbArN4FobRLUC6ynZl6UMMiMmdZ2SridgELLRDBflygJIml+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfrYGRnLpBqMJQAH2Wwc2HekC1Jhn9A/4j6gUFfh0Is=;
 b=D+JWgj2qWBjRQGfNOi47ILQqMATYu+xBu2JcemioeeDY6DSCZlHeiNQiN7HUKy/UZcGLD9PbhsFF6u5CP73x/Oqz4YKAPoYo+sK840b+MpTq8hUNaCkr2jUooa3preoS5FU7a+BxXSpMmrOmxubnU3J8fciYKLz1nBMExogH8Ctj0qRqvaZnb+CabdW6Cuj6IyqK1YCkzGwdrhyha0vPPE3vePEdVC7kEpaShbd2cW1nfxOLY/0OoXAoGkIc5f0yNcuTJ8x6G2MDtHJnj+eXFy7s4gX+K6K3vxe/jW/mXD+7RAoCG2/qPkQQSEfvwKJWYSrfimfDTdiJGwHU553jnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfrYGRnLpBqMJQAH2Wwc2HekC1Jhn9A/4j6gUFfh0Is=;
 b=C337UEFIsGK4o5K0tNgucMQNHrCGSM02fRUwNxQ4mHz+NFqdaiHFD1CO6BPDiOhjlDjIrzLa0z5Ydf1iBIZk/ZHkvdfY2wS4lzELjLP4opLsWep1W/czg+GHW1ZhYp53g6lRzlQAAYnH8Pw4oTz2T4JYK3n0UnG3RvuiKK77Rs8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by PR3PR04MB7338.eurprd04.prod.outlook.com (2603:10a6:102:80::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 15:33:45 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 15:33:45 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [RFC net-next v1 3/5] net: phy: nxp-c45-tja11xx add MACsec support
Date:   Fri, 11 Aug 2023 18:32:47 +0300
Message-Id: <20230811153249.283984-4-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811153249.283984-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230811153249.283984-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::11) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|PR3PR04MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: 632f0201-4a4c-4aad-0ea2-08db9a8059a1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kVLfJSsTnktnJPFAr9mFRYkGLwMF/oaP/KpjGs+GV+93NzZOAlMiUUmy/o245uD92F7ZMzK9mm44ZP94YDjyYXC/GZBSJDBTj30oXOEAv0ljT961sYN+2bBDZ1f3wUVSQciVzUS9tq1dj5wNk5prvxyyIW9ccS93347weDIaoXS05iiq+9ahnprDY4L4qipDpE2NfmUqUxnaMbBP0mRKaaiBvtRmdgp6IEYExXuYoO2IMm/f2UYWDFFfo3J+3qlRk1chN9l1qC3WTMVOs/e7sL/sUCRTKNI9iRKaJj54X32zwlBXuoj9OTbC7mw1Er+NsVyY4wxrxkhdDzYHXm8ds6jpu6JcsTLkSOs1XdF01NYP9ewSwVQawGQ7givPVZnvKf3P4XKgHtS8kY3CFYBeH3VFnBbx1O2S9HrmTQ59UXoQVaMEOOHIlTXI2ono1IXifpGqxNxAFWcoumFll/Q0hLS7qqHiJ085V2mGeNtKBl+kJNygB0UOq6XZzknwSjGp5Je4O4i/sZDb4eVxt1bU5+kjHQJkB0Y6txgR64CI8RKLwanpoZEhOicvVuWVXcbNzDRQCrD1njsXKXoK7sMo4IrT2UdQRLhzn9sYuDvzfwADo+hhX+bm30/E4+vbkGgd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(186006)(451199021)(1800799006)(2906002)(6486002)(52116002)(38100700002)(2616005)(83380400001)(6512007)(26005)(1076003)(38350700002)(6506007)(478600001)(316002)(4326008)(66946007)(41300700001)(8676002)(8936002)(5660300002)(66556008)(30864003)(66476007)(7416002)(86362001)(559001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ig5vvmQ0/1dQksm4p8zm52Q+kzdNUbfkeo/5/ze7lfUHgtjq2SNjCjfbW39P?=
 =?us-ascii?Q?YgegyIeKV0CSFIo7tZ08skiNuCtR8bCWY9XrLwkdIkche31WKKW6FNCyXo7x?=
 =?us-ascii?Q?sf1f6SwpbuDsBHSPc4qc7AIKyucUl/L9tvWwA6507tQMLiYhA3F0R72F5fWj?=
 =?us-ascii?Q?iLUZAiLopH0ZxYxKZ56Ten5mo2xj/jgHz2Q5DVQzI0rw+axBx2nadwTzFpSX?=
 =?us-ascii?Q?C8+uoSA+Ic1QYJmfOexCm/m09qDahH2a+eLYfGYs5SpnKdjqGRiCzIW9RMCQ?=
 =?us-ascii?Q?wjHepNeF1IGVgPQyqbCGtROfJSZvmQbgcSCQz6/pH2cFwlyIHZMmTWZqbldZ?=
 =?us-ascii?Q?Ph0zK/oo1LEzWq3rgv/aOV3gOpuKnf3shVfxPBEF3T+xmOnydQBnrHpdR/d9?=
 =?us-ascii?Q?49roHHDY5ntKNRxGrDEZmMQ+N6ovJdyqVjx0KTxxysOB56vRugheXziaRK3t?=
 =?us-ascii?Q?Xw0doQpTnvvbt/zP4lXyadxpo9mKs5YU7GzqtmT//hzsQfaS1VYgBUfro1LA?=
 =?us-ascii?Q?r+HSUwi19TWcKNmLcVsrm/GBX4HF+pwbkoxUK5dvtQ5Lkt6gF5k8QUzwDukD?=
 =?us-ascii?Q?Qs2pf11PbM3S6Q8CJu+OQpdoF4IqNoE1espTxI0tq84eLS5gsCX5XBs+fJEP?=
 =?us-ascii?Q?gwhofibG8EMEDSMPWcdT8NPxkhfx0saSZC+G92vpri5SnGiGSGbQ5NOr3CIS?=
 =?us-ascii?Q?11kcxRPGCDuGN0eaTckOo8yIPrXQKzlFsvkO2nOklsmDFGKtTq1N6KKx97go?=
 =?us-ascii?Q?11fTMX9dCHNcHtJIhU5bAcJqzPihkrCULxS/yBBecYCEKNufnh9mHdvQwSgx?=
 =?us-ascii?Q?BK/W/Qna7ClvJb/crUfVCMhXQ+vyLNVERsBBiYQy5Q0b0jBofZSl3Nk1ppwT?=
 =?us-ascii?Q?1X+EbZuWbDX/VD53m3kxrOHIuSo1B4Z8TOyHTdqY1X8fIrt0PES/5hM5lyIS?=
 =?us-ascii?Q?DbGi9gnDH8Cff1O7kLmgir9mTaOj9/2O0OYUE2TpCZYAmYnGKLpx2diQhE/k?=
 =?us-ascii?Q?kmuxhdrNeARBQjVX6A01bggNOaAdsBDU48tEvaU0qCd0eHJQ3T/Ne/N5EzE4?=
 =?us-ascii?Q?nOLnqq7syQZO4PB8PauXf1SHMxw92B/ky54fPEsEr5SWfal/zrObI8//t2KE?=
 =?us-ascii?Q?BLebB9yZpEiDcYnDopB5VYFWIOZaOJP91D2qqhCSs19MgoYoxA9tb/SrlM/u?=
 =?us-ascii?Q?14ZIYmPWPkHjcjjlp5tzrJSRj/v+dEk0jgFUA6eUHQ8oT5w2cha7kJvl1T3+?=
 =?us-ascii?Q?nK3mK4Vd3GpKIDliz03Gy4cp+HYyTNtu6GvuIgNHrjm0PceUHiw6gulYM17O?=
 =?us-ascii?Q?a+ZXGdoeO9OzcnlHC35rccVWZLW1CImdUnvEF8aHHfpPGl9FO9HWsKBADxFi?=
 =?us-ascii?Q?lojTZxuMidspCJgheKpQMknpP1fEOv/q/RNkclTo1QG5uSke0P26DinBGtph?=
 =?us-ascii?Q?9EwSYqjltMZ2RYIjah1+ZL3Gvu9xNy2unamBC6kiob9bft30y/uf5gVJbo1z?=
 =?us-ascii?Q?GPyGg6Xsskg3ZiBR7+vp5yobLlmJuQhPIWjVtRzSiLe6ycHFMdoUpjbWntf0?=
 =?us-ascii?Q?i0GQ/Tcthp4suHPbXda1Afq+manimRe+2ZchRafwiW0ei0T8ZCbJeH06CYqL?=
 =?us-ascii?Q?fw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 632f0201-4a4c-4aad-0ea2-08db9a8059a1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 15:33:45.6230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZLYevvV1ZKUpiVXLPMnQKeBw8G47tErX+H7plWhShEk4b0CIjB/98ZbzduDkVEGqZL/mBMWQMzwB2JrrrxOUfU5EXHjjfZ0BWSx3jFm1jt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7338
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MACsec support.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 MAINTAINERS                              |    2 +-
 drivers/net/phy/Makefile                 |    2 +-
 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 1819 ++++++++++++++++++++++
 drivers/net/phy/nxp-c45-tja11xx.c        |   72 +-
 drivers/net/phy/nxp-c45-tja11xx.h        |   37 +
 5 files changed, 1901 insertions(+), 31 deletions(-)
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx-macsec.c
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx.h

diff --git a/MAINTAINERS b/MAINTAINERS
index d984c9a7b12c..f2af99e74e05 100644
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
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index c945ed9bd14b..cdf0b42deb01 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -83,7 +83,7 @@ obj-$(CONFIG_MICROSEMI_PHY)	+= mscc/
 obj-$(CONFIG_MOTORCOMM_PHY)	+= motorcomm.o
 obj-$(CONFIG_NATIONAL_PHY)	+= national.o
 obj-$(CONFIG_NCN26000_PHY)	+= ncn26000.o
-obj-$(CONFIG_NXP_C45_TJA11XX_PHY)	+= nxp-c45-tja11xx.o
+obj-$(CONFIG_NXP_C45_TJA11XX_PHY)	+= nxp-c45-tja11xx.o nxp-c45-tja11xx-macsec.o
 obj-$(CONFIG_NXP_CBTX_PHY)	+= nxp-cbtx.o
 obj-$(CONFIG_NXP_TJA11XX_PHY)	+= nxp-tja11xx.o
 obj-$(CONFIG_QSEMI_PHY)		+= qsemi.o
diff --git a/drivers/net/phy/nxp-c45-tja11xx-macsec.c b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
new file mode 100644
index 000000000000..da63e35571d0
--- /dev/null
+++ b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
@@ -0,0 +1,1819 @@
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
+#define MACSEC_INOV1HS			0x0140
+#define MACSEC_INOV2HS			0x0144
+#define MACSEC_INOD1HS			0x0148
+#define MACSEC_INOD2HS			0x014C
+#define MACSEC_RXSCIPUS			0x0150
+#define MACSEC_RXSCIPDS			0x0154
+#define MACSEC_RXSCIPLS			0x0158
+#define MACSEC_RXAN0INUSS		0x0160
+#define MACSEC_RXAN0IPUSS		0x0170
+#define MACSEC_RXSAAIPOS		0x0194
+#define MACSEC_RXSAAIPIS		0x01B0
+#define MACSEC_RXSAAIPNVS		0x01B4
+#define MACSEC_RXSABIPOS		0x01D4
+#define MACSEC_RXSABIPIS		0x01F0
+#define MACSEC_RXSABIPNVS		0x01F4
+#define MACSEC_OPUS			0x021C
+#define MACSEC_OPTLS			0x022C
+#define MACSEC_OOE1HS			0x0248
+#define MACSEC_OOE2HS			0x024C
+#define MACSEC_TXSAAOPPS		0x028C
+#define MACSEC_TXSAAOPES		0x0290
+#define MACSEC_TXSABOPPS		0x02CC
+#define MACSEC_TXSABOPES		0x02D0
+#define MACSEC_INPWTS			0x0630
+#define MACSEC_INPBTS			0x0638
+#define MACSEC_IPSNFS			0x063C
+
+struct nxp_c45_rx_sc {
+	struct macsec_rx_sc *rx_sc;
+	struct macsec_rx_sa *rx_sa_a;
+	struct macsec_rx_sa *rx_sa_b;
+};
+
+struct nxp_c45_tx_sa {
+	struct macsec_tx_sa *tx_sa;
+	struct macsec_tx_sa_stats stats;
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
+	nxp_c45_macsec_write(phydev, ADPTR_CNTRL, ADPTR_CNTRL_CONFIG_EN);
+	nxp_c45_macsec_write(phydev, ADPTR_CNTRL, ADPTR_CNTRL_CONFIG_EN |
+			     ADPTR_CNTRL_ADPTR_EN);
+	nxp_c45_macsec_write(phydev, ADPTR_CNTRL,
+			     ADPTR_CNTRL_ADPTR_EN);
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
+	u32 tx_flt_base = TX_FLT_BASE(secy_id);
+	const u8 *dev_addr = ctx->secy->netdev->dev_addr;
+	u32 mac_sa;
+
+	mac_sa = dev_addr[0] << 8 | dev_addr[1];
+	nxp_c45_macsec_write(ctx->phydev,
+			     TX_SC_FLT_MAC_DA_SA(tx_flt_base),
+			     mac_sa);
+	mac_sa = dev_addr[5] | dev_addr[4] << 8 |
+		dev_addr[3] << 16 | dev_addr[2] << 24;
+
+	nxp_c45_macsec_write(ctx->phydev,
+			     TX_SC_FLT_MAC_SA(tx_flt_base),
+			     mac_sa);
+	nxp_c45_macsec_write(ctx->phydev,
+			     TX_SC_FLT_MAC_CFG(tx_flt_base),
+			     TX_SC_FLT_BY_SA | TX_SC_FLT_EN |
+			     secy_id);
+
+	return 0;
+}
+
+static bool nxp_c45_port_valid(struct nxp_c45_secy *phy_secy, u16 port)
+{
+	if (phy_secy->secy->tx_sc.end_station && __be16_to_cpu(port) != 1)
+		return false;
+
+	return true;
+}
+
+static bool nxp_c45_rx_sc_valid(struct nxp_c45_secy *phy_secy,
+				struct macsec_rx_sc *rx_sc)
+{
+	u16 port = rx_sc->sci >> (ETH_ALEN * 8);
+
+	if (phy_secy->point_to_point && phy_secy->secy_id != 0)
+		return false;
+
+	return nxp_c45_port_valid(phy_secy, port);
+}
+
+static bool nxp_c45_secy_cfg_valid(struct nxp_c45_secy *phy_secy, bool can_ptp)
+{
+	__be16 port = phy_secy->secy->sci >> (ETH_ALEN * 8);
+
+	if (phy_secy->secy->tx_sc.scb)
+		return false;
+
+	if (phy_secy->secy->tx_sc.send_sci && phy_secy->secy->tx_sc.end_station)
+		return false;
+
+	if (!phy_secy->secy->tx_sc.send_sci && !phy_secy->secy->tx_sc.end_station) {
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
+	nxp_c45_macsec_write(phydev, sa_regs->txsa_npn,
+			     tx_sa->next_pn);
+	nxp_c45_macsec_write(phydev, sa_regs->txsa_xnpn,
+			     tx_sa->next_pn >> 32);
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
+		nxp_c45_macsec_write(ctx->phydev, sa_regs->rxsa_npn,
+				     npn);
+		nxp_c45_macsec_write(ctx->phydev, sa_regs->rxsa_lnpn,
+				     npn);
+		if (ctx->secy->xpn) {
+			nxp_c45_macsec_write(ctx->phydev,
+					     sa_regs->rxsa_xnpn,
+					     npn >> 32);
+			nxp_c45_macsec_write(ctx->phydev,
+					     sa_regs->rxsa_lxnpn,
+					     npn >> 32);
+		}
+	} else if (npn && upd) {
+		if (npn > ctx->secy->replay_window)
+			npn -= ctx->secy->replay_window;
+		else
+			npn = 1;
+
+		nxp_c45_macsec_write(ctx->phydev, sa_regs->rxsa_lnpn,
+				     npn);
+		if (ctx->secy->xpn)
+			nxp_c45_macsec_write(ctx->phydev,
+					     sa_regs->rxsa_lxnpn,
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
+				     cpu_to_be32(key[i]));
+	}
+
+	if (ctx->secy->xpn) {
+		for (i = 0; i < salt_size; i++) {
+			reg = sa_regs->txsa_salt + (2 - i) * 4;
+			nxp_c45_macsec_write(ctx->phydev, reg,
+					     cpu_to_be32(salt[i]));
+		}
+
+		nxp_c45_macsec_write(ctx->phydev, sa_regs->txsa_ssci,
+				     cpu_to_be32(tx_sa->tx_sa->ssci));
+	}
+
+	nxp_c45_macsec_write(ctx->phydev, sa_regs->txsa_cs,
+			     MACSEC_TXSA_CS_A);
+
+	return 0;
+}
+
+static int nxp_c45_commit_rx_sc_cfg(struct phy_device *phydev,
+				    struct nxp_c45_secy *phy_secy)
+{
+	struct nxp_c45_rx_sc *rx_sc = phy_secy->rx_sc;
+
+	nxp_c45_macsec_write(phydev, MACSEC_RXSC_SCI_1H,
+			     cpu_to_be32((u32)(rx_sc->rx_sc->sci)));
+	nxp_c45_macsec_write(phydev, MACSEC_RXSC_SCI_2H,
+			     cpu_to_be32((u32)(rx_sc->rx_sc->sci >> 32)));
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
+static void nxp_c45_clear_dev_stats(struct phy_device *phydev,
+				    struct nxp_c45_secy *phy_secy)
+{
+	nxp_c45_macsec_write(phydev, MACSEC_OPUS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_OPTLS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_OOE1HS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_OOE2HS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_TXSAAOPES, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_TXSABOPES, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_TXSAAOPPS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_TXSABOPPS, 0);
+
+	if (phy_secy->rx_sc) {
+		nxp_c45_macsec_write(phydev, MACSEC_INPBTS, 0);
+		nxp_c45_macsec_write(phydev, MACSEC_INPWTS, 0);
+		nxp_c45_macsec_write(phydev, MACSEC_IPSNFS, 0);
+	}
+}
+
+static void nxp_c45_clear_rx_sc_stats(struct phy_device *phydev)
+{
+	int i;
+
+	nxp_c45_macsec_write(phydev, MACSEC_RXSAAIPIS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_RXSAAIPNVS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_RXSAAIPOS, 0);
+
+	nxp_c45_macsec_write(phydev, MACSEC_RXSABIPIS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_RXSABIPNVS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_RXSABIPOS, 0);
+
+	nxp_c45_macsec_write(phydev, MACSEC_INOD1HS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_INOD2HS, 0);
+
+	nxp_c45_macsec_write(phydev, MACSEC_INOV1HS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_INOV2HS, 0);
+
+	nxp_c45_macsec_write(phydev, MACSEC_RXSCIPDS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_RXSCIPLS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_RXSCIPUS, 0);
+
+	for (i = 0; i < MACSEC_NUM_AN; i++)
+		nxp_c45_macsec_write(phydev, MACSEC_RXAN0INUSS + i * 4, 0);
+
+	for (i = 0; i < MACSEC_NUM_AN; i++)
+		nxp_c45_macsec_write(phydev, MACSEC_RXAN0IPUSS + i * 4, 0);
+}
+
+static void nxp_c45_clear_rx_sa_stats(struct phy_device *phydev,
+				      u8 an, bool is_key_a)
+{
+	if (is_key_a) {
+		nxp_c45_macsec_write(phydev, MACSEC_RXSAAIPIS, 0);
+		nxp_c45_macsec_write(phydev, MACSEC_RXSAAIPNVS, 0);
+		nxp_c45_macsec_write(phydev, MACSEC_RXSAAIPOS, 0);
+	} else {
+		nxp_c45_macsec_write(phydev, MACSEC_RXSABIPIS, 0);
+		nxp_c45_macsec_write(phydev, MACSEC_RXSABIPNVS, 0);
+		nxp_c45_macsec_write(phydev, MACSEC_RXSABIPOS, 0);
+	}
+
+	nxp_c45_macsec_write(phydev, MACSEC_RXAN0INUSS + an * 4, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_RXAN0IPUSS + an * 4, 0);
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
+	nxp_c45_clear_rx_sc_stats(phydev);
+
+	return 0;
+}
+
+static int nxp_c45_set_rxsa_key(struct macsec_context *ctx, bool key_a)
+{
+	u32 *salt = (u32 *)ctx->sa.rx_sa->key.salt.bytes;
+	const struct nxp_c45_macsec_sa_regs *sa_regs;
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
+				     cpu_to_be32(key[i]));
+	}
+
+	if (ctx->secy->xpn) {
+		for (i = 0; i < salt_size; i++) {
+			reg = sa_regs->rxsa_salt + (2 - i) * 4;
+			nxp_c45_macsec_write(ctx->phydev, reg,
+					     cpu_to_be32(salt[i]));
+		}
+		nxp_c45_macsec_write(ctx->phydev, sa_regs->rxsa_ssci,
+				     cpu_to_be32(ctx->sa.rx_sa->ssci));
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
+static void nxp_c45_tx_sa_stats_read(struct phy_device *phydev,
+				     struct nxp_c45_tx_sa *tx_sa,
+				     struct macsec_tx_sa_stats *stats)
+{
+	u32 reg = 0;
+
+	if (tx_sa->is_key_a) {
+		nxp_c45_macsec_read(phydev, MACSEC_TXSAAOPES, &reg);
+		stats->OutPktsEncrypted = reg;
+		nxp_c45_macsec_read(phydev, MACSEC_TXSAAOPPS, &reg);
+		stats->OutPktsProtected = reg;
+	} else {
+		nxp_c45_macsec_read(phydev, MACSEC_TXSABOPES, &reg);
+		stats->OutPktsEncrypted = reg;
+		nxp_c45_macsec_read(phydev, MACSEC_TXSABOPPS, &reg);
+		stats->OutPktsProtected = reg;
+	}
+}
+
+static void nxp_c45_tx_sa_stats_clear(struct phy_device *phydev,
+				      struct nxp_c45_tx_sa *tx_sa)
+{
+	if (tx_sa->is_key_a) {
+		nxp_c45_macsec_write(phydev, MACSEC_TXSAAOPES, 0);
+		nxp_c45_macsec_write(phydev, MACSEC_TXSAAOPPS, 0);
+	} else {
+		nxp_c45_macsec_write(phydev, MACSEC_TXSABOPES, 0);
+		nxp_c45_macsec_write(phydev, MACSEC_TXSABOPPS, 0);
+	}
+}
+
+static void nxp_c45_tx_sa_stats_backup(struct phy_device *phydev,
+				       struct nxp_c45_tx_sa *tx_sa)
+{
+	struct macsec_tx_sa_stats stats;
+
+	nxp_c45_tx_sa_stats_read(phydev, tx_sa, &stats);
+	tx_sa->stats.OutPktsEncrypted += stats.OutPktsEncrypted;
+	tx_sa->stats.OutPktsProtected += stats.OutPktsProtected;
+	nxp_c45_tx_sa_stats_clear(phydev, tx_sa);
+}
+
+static int nxp_c45_mdo_add_secy(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
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
+			     cpu_to_be32((u32)ctx->secy->sci));
+	nxp_c45_macsec_write(phydev, MACSEC_TXSC_SCI_2H,
+			     cpu_to_be32((u32)(ctx->secy->sci >> 32)));
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
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct nxp_c45_tx_sa *new_tx_sa, *old_tx_sa;
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
+			nxp_c45_tx_sa_stats_backup(phydev, old_tx_sa);
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
+	int i;
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
+	nxp_c45_clear_dev_stats(phydev, phy_secy);
+	if (phy_secy->rx_sc) {
+		nxp_c45_rx_sc_del(phydev, phy_secy->rx_sc);
+		kfree(phy_secy->rx_sc);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(phy_secy->tx_sa); i++)
+		if (phy_secy->tx_sa[i] && phy_secy->tx_sa[i]->is_enabled)
+			nxp_c45_tx_sa_stats_clear(phydev,
+						  phy_secy->tx_sa[i]);
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
+		nxp_c45_clear_rx_sa_stats(phydev, an, true);
+		rx_sc->rx_sa_a = NULL;
+		return 0;
+	}
+
+	if (rx_sc->rx_sa_b == rx_sa) {
+		phydev_dbg(phydev, "delete RX SA B %u %s\n",
+			   an, rx_sa->active ? "enabled" : "disabled");
+		nxp_c45_disable_rxsa_key(phydev, false);
+		nxp_c45_clear_rx_sa_stats(phydev, an, false);
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
+	if (tx_sa->is_enabled && tx_sa->tx_sa->active &&
+	    next_pn) {
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
+	if (tx_sa->is_enabled) {
+		nxp_c45_update_key_status(phydev, tx_sa);
+		nxp_c45_tx_sa_stats_clear(phydev, tx_sa);
+	}
+
+	phy_secy->tx_sa[sa] = NULL;
+	kfree(tx_sa);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_get_dev_stats(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct macsec_dev_stats  *dev_stats;
+	struct nxp_c45_secy *phy_secy;
+	u32 reg = 0;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	dev_stats = ctx->stats.dev_stats;
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	nxp_c45_macsec_read(phydev, MACSEC_OPUS, &reg);
+	dev_stats->OutPktsUntagged = reg;
+	nxp_c45_macsec_read(phydev, MACSEC_OPTLS, &reg);
+	dev_stats->OutPktsTooLong = reg;
+
+	dev_stats->InPktsUntagged = 0;
+	dev_stats->InPktsNoTag = 0;
+	dev_stats->InPktsBadTag = 0;
+	dev_stats->InPktsUnknownSCI = 0;
+	dev_stats->InPktsNoSCI = 0;
+
+	if (phy_secy->rx_sc) {
+		nxp_c45_macsec_read(phydev, MACSEC_INPBTS, &reg);
+		dev_stats->InPktsBadTag = reg;
+
+		nxp_c45_macsec_read(phydev, MACSEC_INPWTS, &reg);
+		if (phy_secy->secy->validate_frames == MACSEC_VALIDATE_STRICT)
+			dev_stats->InPktsNoTag += reg;
+		else
+			dev_stats->InPktsUntagged += reg;
+
+		nxp_c45_macsec_read(phydev, MACSEC_IPSNFS, &reg);
+		if (phy_secy->secy->validate_frames == MACSEC_VALIDATE_STRICT)
+			dev_stats->InPktsNoSCI += reg;
+		else
+			dev_stats->InPktsUnknownSCI += reg;
+	}
+
+	/* Always 0. */
+	dev_stats->InPktsOverrun = 0;
+
+	return 0;
+}
+
+static int nxp_c45_mdo_get_tx_sc_stats(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct macsec_tx_sc_stats *tx_sc_stats;
+	struct macsec_tx_sa_stats tx_sa_stats;
+	struct nxp_c45_secy *phy_secy;
+	struct nxp_c45_tx_sa *tx_sa;
+	u32 reg = 0;
+	u64 stat;
+	int i;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	tx_sc_stats = ctx->stats.tx_sc_stats;
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	nxp_c45_macsec_read(phydev, MACSEC_OOE1HS, &reg);
+	stat = (u64)reg << 32;
+	nxp_c45_macsec_read(phydev, MACSEC_OOE2HS, &reg);
+	stat |= reg;
+	if (ctx->secy->tx_sc.encrypt)
+		tx_sc_stats->OutOctetsEncrypted = stat;
+	else
+		tx_sc_stats->OutOctetsEncrypted = 0;
+
+	if (ctx->secy->protect_frames)
+		tx_sc_stats->OutOctetsProtected = stat;
+	else
+		tx_sc_stats->OutOctetsProtected = 0;
+
+	tx_sc_stats->OutPktsEncrypted = 0;
+	tx_sc_stats->OutPktsProtected = 0;
+
+	for (i = 0; i < ARRAY_SIZE(phy_secy->tx_sa); i++) {
+		tx_sa = phy_secy->tx_sa[i];
+		if (!tx_sa)
+			continue;
+
+		if (tx_sa->is_enabled) {
+			nxp_c45_tx_sa_stats_read(phydev, tx_sa, &tx_sa_stats);
+			tx_sc_stats->OutPktsEncrypted +=
+				tx_sa_stats.OutPktsEncrypted;
+			tx_sc_stats->OutPktsProtected +=
+				tx_sa_stats.OutPktsProtected;
+			continue;
+		}
+
+		tx_sc_stats->OutPktsEncrypted += tx_sa->stats.OutPktsEncrypted;
+		tx_sc_stats->OutPktsProtected += tx_sa->stats.OutPktsProtected;
+	}
+
+	return 0;
+}
+
+static int nxp_c45_mdo_get_tx_sa_stats(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct macsec_tx_sa_stats *tx_sa_stats;
+	struct nxp_c45_secy *phy_secy;
+	struct nxp_c45_tx_sa *tx_sa;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	tx_sa = phy_secy->tx_sa[ctx->sa.assoc_num];
+	if (!tx_sa)
+		return -EINVAL;
+
+	tx_sa_stats = ctx->stats.tx_sa_stats;
+
+	if (!tx_sa->is_enabled) {
+		tx_sa_stats->OutPktsEncrypted =
+			tx_sa->stats.OutPktsEncrypted;
+		tx_sa_stats->OutPktsProtected =
+			tx_sa->stats.OutPktsProtected;
+		return 0;
+	}
+
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	nxp_c45_tx_sa_stats_read(phydev, tx_sa, tx_sa_stats);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_get_rx_sc_stats(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct macsec_rx_sc_stats *rx_sc_stats;
+	struct nxp_c45_secy *phy_secy;
+	struct nxp_c45_rx_sc *rx_sc;
+	u32 reg = 0;
+	int i;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	rx_sc = phy_secy->rx_sc;
+	if (rx_sc->rx_sc != ctx->rx_sc)
+		return -EINVAL;
+
+	rx_sc_stats = ctx->stats.rx_sc_stats;
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	rx_sc_stats->InPktsInvalid = 0;
+	rx_sc_stats->InPktsNotValid = 0;
+	rx_sc_stats->InPktsOK = 0;
+
+	if (rx_sc->rx_sa_a) {
+		nxp_c45_macsec_read(phydev, MACSEC_RXSAAIPIS, &reg);
+		rx_sc_stats->InPktsInvalid += reg;
+		nxp_c45_macsec_read(phydev, MACSEC_RXSAAIPNVS, &reg);
+		rx_sc_stats->InPktsNotValid += reg;
+		nxp_c45_macsec_read(phydev, MACSEC_RXSAAIPOS, &reg);
+		rx_sc_stats->InPktsOK += reg;
+	}
+
+	if (rx_sc->rx_sa_b) {
+		nxp_c45_macsec_read(phydev, MACSEC_RXSABIPIS, &reg);
+		rx_sc_stats->InPktsInvalid += reg;
+		nxp_c45_macsec_read(phydev, MACSEC_RXSABIPNVS, &reg);
+		rx_sc_stats->InPktsNotValid += reg;
+		nxp_c45_macsec_read(phydev, MACSEC_RXSABIPOS, &reg);
+		rx_sc_stats->InPktsOK += reg;
+	}
+
+	ctx->stats.rx_sa_stats->InPktsNotUsingSA = 0;
+	for (i = 0; i < MACSEC_NUM_AN; i++) {
+		nxp_c45_macsec_read(phydev, MACSEC_RXAN0INUSS + i * 4, &reg);
+		rx_sc_stats->InPktsNotUsingSA += reg;
+	}
+
+	ctx->stats.rx_sa_stats->InPktsUnusedSA = 0;
+	for (i = 0; i < MACSEC_NUM_AN; i++) {
+		nxp_c45_macsec_read(phydev, MACSEC_RXAN0IPUSS + i * 4, &reg);
+		rx_sc_stats->InPktsUnusedSA += reg;
+	}
+
+	nxp_c45_macsec_read(phydev, MACSEC_INOD1HS, &reg);
+	rx_sc_stats->InOctetsDecrypted = (u64)reg << 32;
+	nxp_c45_macsec_read(phydev, MACSEC_INOD2HS, &reg);
+	rx_sc_stats->InOctetsDecrypted |= reg;
+
+	nxp_c45_macsec_read(phydev, MACSEC_INOV1HS, &reg);
+	rx_sc_stats->InOctetsValidated = (u64)reg << 32;
+	nxp_c45_macsec_read(phydev, MACSEC_INOV2HS, &reg);
+	rx_sc_stats->InOctetsValidated |= reg;
+
+	nxp_c45_macsec_read(phydev, MACSEC_RXSCIPDS, &reg);
+	rx_sc_stats->InPktsDelayed = reg;
+	nxp_c45_macsec_read(phydev, MACSEC_RXSCIPLS, &reg);
+	rx_sc_stats->InPktsLate = reg;
+	nxp_c45_macsec_read(phydev, MACSEC_RXSCIPUS, &reg);
+	rx_sc_stats->InPktsUnchecked = reg;
+
+	return 0;
+}
+
+static int nxp_c45_mdo_get_rx_sa_stats(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct macsec_rx_sa_stats *rx_sa_stats;
+	struct nxp_c45_secy *phy_secy;
+	struct nxp_c45_rx_sc *rx_sc;
+	u8 an = ctx->sa.assoc_num;
+	u32 reg = 0;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	rx_sc = phy_secy->rx_sc;
+	if (rx_sc->rx_sc != ctx->sa.rx_sa->sc)
+		return -EINVAL;
+
+	if (!rx_sc->rx_sa_a && !rx_sc->rx_sa_b)
+		return -EINVAL;
+
+	rx_sa_stats = ctx->stats.rx_sa_stats;
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	if (rx_sc->rx_sa_a == ctx->sa.rx_sa) {
+		nxp_c45_macsec_read(phydev, MACSEC_RXSAAIPIS, &reg);
+		rx_sa_stats->InPktsInvalid = reg;
+		nxp_c45_macsec_read(phydev, MACSEC_RXSAAIPNVS, &reg);
+		rx_sa_stats->InPktsNotValid = reg;
+		nxp_c45_macsec_read(phydev, MACSEC_RXSAAIPOS, &reg);
+		rx_sa_stats->InPktsOK = reg;
+	}
+
+	if (rx_sc->rx_sa_b == ctx->sa.rx_sa) {
+		nxp_c45_macsec_read(phydev, MACSEC_RXSABIPIS, &reg);
+		rx_sa_stats->InPktsInvalid = reg;
+		nxp_c45_macsec_read(phydev, MACSEC_RXSABIPNVS, &reg);
+		rx_sa_stats->InPktsNotValid = reg;
+		nxp_c45_macsec_read(phydev, MACSEC_RXSABIPOS, &reg);
+		rx_sa_stats->InPktsOK = reg;
+	}
+
+	nxp_c45_macsec_read(phydev, MACSEC_RXAN0INUSS + an * 4, &reg);
+	rx_sa_stats->InPktsNotUsingSA = reg;
+	nxp_c45_macsec_read(phydev, MACSEC_RXAN0IPUSS + an * 4, &reg);
+	rx_sa_stats->InPktsUnusedSA = reg;
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
+	.mdo_get_dev_stats = nxp_c45_mdo_get_dev_stats,
+	.mdo_get_tx_sc_stats = nxp_c45_mdo_get_tx_sc_stats,
+	.mdo_get_tx_sa_stats = nxp_c45_mdo_get_tx_sa_stats,
+	.mdo_get_rx_sc_stats = nxp_c45_mdo_get_rx_sc_stats,
+	.mdo_get_rx_sa_stats = nxp_c45_mdo_get_rx_sa_stats,
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
+		list_for_each_entry_safe(pos, tmp, &priv->macsec->secy_list, list)
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
index 000000000000..ace2df002508
--- /dev/null
+++ b/drivers/net/phy/nxp-c45-tja11xx.h
@@ -0,0 +1,37 @@
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
+void nxp_c45_macsec_config_init(struct phy_device *phydev);
+void nxp_c45_handle_macsec_interrupt(struct phy_device *phydev,
+				     irqreturn_t *ret);
+int nxp_c45_macsec_probe(struct phy_device *phydev);
+
-- 
2.34.1

