Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD807A7736
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbjITJXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbjITJXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:23:14 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB603AF;
        Wed, 20 Sep 2023 02:23:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNE8tmrxpmoK7SZ8XUonakEpWJFYuPbhAMmcTnkmj/UzkPlzc24jE3t8GkP9++CqLU25PQ41aCgSYBTBw+AjnwoiUdWJLYrRRyz/GUZZutLi0Oe/mCl4zNyIyyYRMoF1eh/8my5y+OZzNIFu7AkVqgAWf19gmMf7MPbYcm1qQBBWLZLDKGXrfuJoqr1Xmfwng/ngbrSjOdxrKLd5QqmWeqra+/s4/TNZCJRMHCrQ+Teb7vyu4NzecSLckIOH4OInNYDv0i1FRHwyiwRCW731y323LRfPgzyGqdNwJcfSyH6cYlEAQ/8UaJ5FKOht4jL68qVz42c/25787ic4orR4Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9euG0uAS8G445WOAx6gFRnjtPHUXe82BT2Zu3+2a3Q=;
 b=T4ec7dtNnXYpTh+V1dUcHgnUIg3bwQV9IfRK2tM72lrylpvKYewPSmvHX0LR7IMs5SVUr0251jFGO9kAAQ2svkX7d0a0RHU3MxBcJUfxyg/01yGzasYWtJE2LaDG4hEvUswprT13XlZySuSr5TKOtV7NmpZIQ4n4+LHMFbHixXq1wbwTSBezFbWkN+CPl1birhWrU/FP3fdsvr2PIFIhND7D5Hmnai1OA7zUfTXIuT2fstHcVB1KKGQzMUk8+uzRK6nVOybBCBUhI2WlWkRbkpIiYRvZHOqaO1dleRXZfa+EVgXi3t/ZpmuapY5hDlPlFvj/gJ9BumHJnBSRj8Gb9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9euG0uAS8G445WOAx6gFRnjtPHUXe82BT2Zu3+2a3Q=;
 b=ZBSx82QgcDOjQpAee+YBk23Arj9j9IP6YvG2axwwX2F/GD8v0QJVSd41bzZ5O0uCvPpzYtlxGdMB3hTko25vtkXIs2TMyh2/pKnJrgJzrRYNMzFOMFA1sHKyMJFCHZvxFwrv1HgHPLQFYC15edggv5fCZ4swv4Eoy0z5qA28WXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM7PR04MB6933.eurprd04.prod.outlook.com (2603:10a6:20b:10d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Wed, 20 Sep
 2023 09:23:04 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 09:23:04 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@oss.nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v5 7/7] net: phy: nxp-c45-tja11xx: implement mdo_insert_tx_tag
Date:   Wed, 20 Sep 2023 12:22:37 +0300
Message-Id: <20230920092237.121033-8-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920092237.121033-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230920092237.121033-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0019.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::24) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM7PR04MB6933:EE_
X-MS-Office365-Filtering-Correlation-Id: 48a6915f-8538-43d3-cd6c-08dbb9bb3153
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jmSxDWGpBP0uZJRrEKpd8QYG2OURSCxteYBV/xd0AGHcKrJY/hallUESpbX0n9uHUUAPz7b7dk34aZXIJcypStZGRKIoO5W0dWMlLSjbqh7ZKO2s8KXQbEKB79jL2lr3IgIJDAoe5Raxca4PN21a+p5VerX0/13QYVwdYaaaXhqbTR8K4znuBWiuo6EXWyFubvGbrPkFmHKrX83EQtRjaPLyFMUQoaZQ4srE+p9a7x5nywaffUIl1oRb+I6PtJRbVIF8NiObhdLLILOrDCbPdTwUFvjIp/U9xgeGJyryvZ1w4faRudi0VINLhlcoXIgyFuDh1AFuXI50kcbWCvD6J2p7oZMVZffLyZlwoNwivoyHLyo1TyuTgARozZD9lGS+MQnWDN4vYvASXApy2FhCuRkYv7C1PdNCFS9EmWiVjR0CyRbQBobgymgar30Ynhu9AJTYUxC7rHTfrLVY7o5sl1/h+ngm1IntT9BnFsLBXbhLY6+8TJ0tv4iBz8n/6uRcbI4dVZ46chONNZOy2QkUMf01wsm6PGoNh77cmJos77XYF6DNGSNwnO007ZoOOcOAnEljm+m1Od8++jwSR+kMwUur5fQhTUidgmZls3ExkdRGVwuG+r5xzwMrMKZpO06fFjWgRZF8NBznQSUr/cPYWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199024)(1800799009)(186009)(316002)(41300700001)(8676002)(4326008)(66476007)(8936002)(1076003)(6512007)(38350700002)(6486002)(6506007)(26005)(52116002)(2616005)(6666004)(86362001)(38100700002)(478600001)(921005)(66556008)(66946007)(6636002)(2906002)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dPnBTM3evFIqeVFcCbY5iJcRJZvhxtv6T6WdmX0HUXZEPUj+mzTS4ruOhehY?=
 =?us-ascii?Q?Xovv+z7+tjoAYjXmuCxOrkfDYr6g+8DPyZRKAh1s6ShoRPtrXjmXMld8R9rR?=
 =?us-ascii?Q?EW8ePtmpahoNpp/yVH973rLRvRX2Ze7k5iigNvuAgYeI3/KqvOpzNCM8B2fW?=
 =?us-ascii?Q?AB+oQWvXW1wxJc9LaSZFKVrruW3GS/Wum6oDOfkSJg6+FIKJcoYOKfPycuSe?=
 =?us-ascii?Q?+u6LQjCAS0stYsjZnLSv3bG8GoVt890uY10bKTM6mIf5MHmhZMydnpLlNPlF?=
 =?us-ascii?Q?Re5bWGIHhd6UiEbEHQtuLp5CHIQw5fv92H0IuTm/p6sYfQ/lE9Vm5eAQfAen?=
 =?us-ascii?Q?mzsqNwUg9JrAUP+r5ufPmg6k5T/Lq70W0f3l416XLYbDy2fC6Q1KDzaslFse?=
 =?us-ascii?Q?+EnfHCR/wa1jQNt3h0dUf7j1uOiOP0cuo76JK5pNf6hXyR0oTNx7E7fIjPR4?=
 =?us-ascii?Q?oBysILdWMy4wBPZlEkNkgW9hbJdoXwIA7tg+ZfUujX5kIe843+PiMTcJ+4BD?=
 =?us-ascii?Q?Tbc3N0W0uFKo9PgDpSCRVu1f/xsx4SW8qUG51xGkVPLdj4P31TqD6k5m1TNi?=
 =?us-ascii?Q?mUut9z5tUh++cK0dEV4cQbUIQcRfuLCEZL5CA4ytlQgio8M7l+nHZNbj5MX6?=
 =?us-ascii?Q?67I7hlgYnnYh8t/LzqFoulc4lNVqFaey15kZDNa5/5MTsxdVlL+MpjXCXFTT?=
 =?us-ascii?Q?g5zAVB8dcmbmN30qFBV0WEiLJbCIiY73C3wu8u8MDFgOdbFetkwkAjOqCK6Z?=
 =?us-ascii?Q?WUTgUfD70iqrVxO3O/RVmNOMaNN62iE6pZgOJmmLgwN465wjj8gKb1uCqfs0?=
 =?us-ascii?Q?RE3ncSoIDJUzRCHyJ9PMqzIfuPanXdpy/28y5tnCTlrU88lBa2GYTwTaue9c?=
 =?us-ascii?Q?ZVKbse8mZLkpNiXxLWqbi40ZR4Rzxm1VCqkmPJNXvh7UVw8JwMk16iRNfjeP?=
 =?us-ascii?Q?w2BT43jwVqVM8FIZg6iJs4AiTd9d15dB2ZGrqKIeBkCXh92uy1e8bb4kjm+9?=
 =?us-ascii?Q?FGrArKfQTkwhngHzx2qHOEoTC7RHrUXo8EyiEL0jq9IC/jMWBzHjL4fivW4L?=
 =?us-ascii?Q?6/r0IOPmOx7P2BCQN7bUnSwRJjKIxQ8Y9Q/t/C39Sh2i68YXJNPZ+jS1NnC4?=
 =?us-ascii?Q?GJHWx+hOzSjRGvf8QVWiFiLLnUdcucENJQtYueK8zr+QJSL10LrHjAt2fdrO?=
 =?us-ascii?Q?Mat2oc++EjZ4GtYo7qQrMqNMMuRFY50+TtkgUzbzEyyupp/zL0C82YwDEZOs?=
 =?us-ascii?Q?vhI4cBMoMyCtgWfum2mRgEI08un4Ob9IcfY14qfcgjGeuVaiBPIi4OJ4haNa?=
 =?us-ascii?Q?iISL5txxfSvSbs5SPxAbSBojcwwtxnE3vP4rHBReCWLnhKQuLyTtK4GnbXHE?=
 =?us-ascii?Q?LpkpBH5es+/to1sT5q4FtFb8Biq/wshH2gd7iRwozy2IlyLTm1REAqgkZGQS?=
 =?us-ascii?Q?WR6PzdnB4ohzvtBcl2AY2pTZbV6z1rosXzDZTc6/sYu3KwLiU7KNfnQ2uo7C?=
 =?us-ascii?Q?CunwXYoTuQAxXhGunOqpEgVVDpgV2B9Qg2YbJDqcRe5pkE4Cj0ikzcutCJ10?=
 =?us-ascii?Q?rxkbXQNXvmkcAqJ/Azo0JJ9PqcxidlSeFxM0UkTKEOilHWRnUq+AMwXnK8vq?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a6915f-8538-43d3-cd6c-08dbb9bb3153
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 09:23:04.1957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: il/37mJz9MIeW+mg5heZzI7j8VEzFs30O5c0hgj5dy1Y6zP4TIFRRaajMOZ0xBrxK29AG4GZE/SuHKIKRKuc2JilkKvJpMqahmC4rmKmGiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6933
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement mdo_insert_tx_tag to insert the TLV header in the ethernet
frame.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in V5:
- removed unused defines MACSEC_TLV_CP and MACSEC_TLV_SC_ID_OFF

Changes in V4:
- removed macsec_extscs parameter

Changes in V3:
- extscs parameter renamed to macsec_extscs and improved description

Changes in V2:
- added extscs parameter to choose the TX SC selection mechanism between
and MAC SA based selection and TLV header based selection

 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 41 ++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx-macsec.c b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
index 4dd10ea6e06c..6ff0ceeeecd1 100644
--- a/drivers/net/phy/nxp-c45-tja11xx-macsec.c
+++ b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/phy.h>
 #include <linux/processor.h>
+#include <net/dst_metadata.h>
 #include <net/macsec.h>
 
 #include "nxp-c45-tja11xx.h"
@@ -118,6 +119,8 @@
 #define ADPTR_CNTRL			0x0F00
 #define ADPTR_CNTRL_CONFIG_EN		BIT(14)
 #define ADPTR_CNTRL_ADPTR_EN		BIT(12)
+#define ADPTR_TX_TAG_CNTRL		0x0F0C
+#define ADPTR_TX_TAG_CNTRL_ENA		BIT(31)
 
 #define TX_SC_FLT_BASE			0x800
 #define TX_SC_FLT_SIZE			0x10
@@ -166,6 +169,11 @@
 #define MACSEC_INPBTS			0x0638
 #define MACSEC_IPSNFS			0x063C
 
+#define TJA11XX_TLV_TX_NEEDED_HEADROOM	(32)
+#define TJA11XX_TLV_NEEDED_TAILROOM	(0)
+
+#define ETH_P_TJA11XX_TLV		(0x4e58)
+
 enum nxp_c45_sa_type {
 	TX_SA,
 	RX_SA,
@@ -1541,6 +1549,31 @@ static int nxp_c45_mdo_get_rx_sa_stats(struct macsec_context *ctx)
 	return 0;
 }
 
+struct tja11xx_tlv_header {
+	struct ethhdr eth;
+	u8 subtype;
+	u8 len;
+	u8 payload[28];
+};
+
+static int nxp_c45_mdo_insert_tx_tag(struct phy_device *phydev,
+				     struct sk_buff *skb)
+{
+	struct tja11xx_tlv_header *tlv;
+	struct ethhdr *eth;
+
+	eth = eth_hdr(skb);
+	tlv = skb_push(skb, TJA11XX_TLV_TX_NEEDED_HEADROOM);
+	memmove(tlv, eth, sizeof(*eth));
+	skb_reset_mac_header(skb);
+	tlv->eth.h_proto = htons(ETH_P_TJA11XX_TLV);
+	tlv->subtype = 1;
+	tlv->len = sizeof(tlv->payload);
+	memset(tlv->payload, 0, sizeof(tlv->payload));
+
+	return 0;
+}
+
 static const struct macsec_ops nxp_c45_macsec_ops = {
 	.mdo_dev_open = nxp_c45_mdo_dev_open,
 	.mdo_dev_stop = nxp_c45_mdo_dev_stop,
@@ -1561,6 +1594,9 @@ static const struct macsec_ops nxp_c45_macsec_ops = {
 	.mdo_get_tx_sa_stats = nxp_c45_mdo_get_tx_sa_stats,
 	.mdo_get_rx_sc_stats = nxp_c45_mdo_get_rx_sc_stats,
 	.mdo_get_rx_sa_stats = nxp_c45_mdo_get_rx_sa_stats,
+	.mdo_insert_tx_tag = nxp_c45_mdo_insert_tx_tag,
+	.needed_headroom = TJA11XX_TLV_TX_NEEDED_HEADROOM,
+	.needed_tailroom = TJA11XX_TLV_NEEDED_TAILROOM,
 };
 
 int nxp_c45_macsec_config_init(struct phy_device *phydev)
@@ -1581,6 +1617,11 @@ int nxp_c45_macsec_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
+	ret = nxp_c45_macsec_write(phydev, ADPTR_TX_TAG_CNTRL,
+				   ADPTR_TX_TAG_CNTRL_ENA);
+	if (ret)
+		return ret;
+
 	ret = nxp_c45_macsec_write(phydev, ADPTR_CNTRL, ADPTR_CNTRL_ADPTR_EN);
 	if (ret)
 		return ret;
-- 
2.34.1

