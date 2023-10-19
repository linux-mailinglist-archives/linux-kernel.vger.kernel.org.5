Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBE27CF801
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjJSMEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345610AbjJSMDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:03:20 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2089.outbound.protection.outlook.com [40.107.6.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD18D68;
        Thu, 19 Oct 2023 05:03:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCvNh7ZjV9Ntjk39MI7C9kQgBfrFwZp+quWRe34BEK64RGJzJ2u24Skr0r6kLXzT9HXmS9nMzNHOOAz2V6gJS1qI77OecbLOdydSwURcbhcE8CheKzqox/C76Bxzb7yygWzmYTLM3mS4Tl09Sm2izvpyJk5L5bO4jQYYNKlV7SuXWdlWlDZ3w4YmuWVeYDVbQX1bRsAJ1K7+lUJ/zaJ7ZLMWYlRgvM7e2BDI1VKYYn3+N+mNaAaqrwUw++tiJtEok1j6EaVAacGnJ8Q4Tdsm7J+6AJ9SGOwA/rHM0L8ZGELcOemxqo1d9rd+rQa8NUeC9iw0yp5I98BkSW2dYsyjpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlCaEwzLJwJQhM2FHF/4VqTXShcY7qSgVY2gyqriqQ8=;
 b=bvn4yQdgDJJNJrKBICYwNuV/T/Yats1XwMY71ArO5wA40/zCQCxQO2dt/AmmkCyK1bI02qe0rpGy1UKMYmhT0qe3bYbrL/deOCTgEbulWIqjc+YTLoT8R0LsftZXumG31BJgUbFsv28IS2e+yNXYJV5bUyDSiJjihmkFeG2vb6ybpPvecUBst/+kx6/QI7aAG9f1/0Tn4wPCIwbBhkp/xxl4AyWQ5eXLV7PQ5g8ndHNK3Fo9AtlNFyn2nof7IQiZOZth5EnerjXhu3pRWBHIfUp1+/hE7Px4l2T0v4pHtIw3Vaosn4sFA6DzrWeMR4a8rrbeh+EH0sOcdn96Ooxg6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlCaEwzLJwJQhM2FHF/4VqTXShcY7qSgVY2gyqriqQ8=;
 b=hZr7CrpCqNlCsToiOYc4jm/C+aNlxFLEu6br24oi40dyaIsal1Nz4gicY7iNu7wEyO28Ux2zJAf1vgSNyaPEkA73+CTvhyHiqdXvQwp0tU0OulgFdMjYgvGFaqyr9S7kfDKZ9ikJBEF3ipXfQkYBq+gNWWnajG85T1ykKSluiRE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by PR3PR04MB7436.eurprd04.prod.outlook.com (2603:10a6:102:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8; Thu, 19 Oct
 2023 12:03:00 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6933.008; Thu, 19 Oct 2023
 12:03:00 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sebastian.tobuschat@oss.nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v7 7/7] net: phy: nxp-c45-tja11xx: implement mdo_insert_tx_tag
Date:   Thu, 19 Oct 2023 15:02:09 +0300
Message-Id: <20231019120209.290480-8-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019120209.290480-1-radu-nicolae.pirea@oss.nxp.com>
References: <20231019120209.290480-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0236.eurprd08.prod.outlook.com
 (2603:10a6:802:15::45) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|PR3PR04MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: 5486d272-a9b2-4715-f002-08dbd09b56e4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bH3BudLxkRuHtb2Zk+669GM+o5AykQM6Rx24hFdfZcEV9BJVJF6ap6He3UqIZVygoe2axsgyfy90uUkKZRtDxKveAK35JFZ3y4hyWLhaA/vbZB7Y+Ls2QKAELDv70XCR3dlSYgwLjoiCA41m9wx13vNX2OTaD/86/yvSnts2p363B2ninoYLfAj2Db9+JUFG4z8lw0d1ZiZWmrEfnqexqMf9ok/lH0i88mIupNxXl9WLwQDRgLhmfFTeO8a8/oMstGNHcqBB2BFhyMGvxwJeUVKG9uczPLKGgA1aPWyNXeVIoykYZ7phygtN+Bqvq1SnIkwr7g+orFKOnpijITDbyIfdPtqjJJ2uAhFMIrPKwEwkAyoOFHOlYkEg3E9+k3e3R7OiocxcG0/qMXy8ocCnPlbQ38EyWJs1r1DGSqnyN3gP2Jx6b72U9XoUQBlfr+7t2ScY0XpPRzXxJ4mNogKjfleVJZlyZtKt2vtxgVK3PravIonjq/H0Cc4vZvLzmgv05QwULXRE1X7rzN31j8e2DyWiqvaSpz5aEXZTnRI8hPprV0IpXH1DI8JCehG7vvburw08luotumBUdbLuicAPsBfWWQSgmMY4Pa+o50yGsgUULGgP5Ck6OvLUPYixLqcd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(2906002)(5660300002)(4326008)(66476007)(66946007)(8936002)(66556008)(316002)(478600001)(6486002)(8676002)(41300700001)(7416002)(86362001)(38100700002)(52116002)(2616005)(6506007)(1076003)(26005)(6512007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X6eZVmfo4esN4uar1bsba5qddUw104tcmaOYh/RguJcwvZYMRPjFwxcYSwAn?=
 =?us-ascii?Q?3sPjuDKYlIZB8I77t38nAqtTCURCy3tDdQtKGoS26p3EyXOeczI+acVQ86Gt?=
 =?us-ascii?Q?PLFtmfH7QkOlt6tcGpVRYHARBS7meKvFKMq2htvO7WnoY06Bsr9CnJDTkPmx?=
 =?us-ascii?Q?XmhDPuG9bR4rLlTkNRMbXQCHc+kLPkHTJfVUbpUK1lTpZHo/ZZAbtCt4Kje+?=
 =?us-ascii?Q?5CWZ3GXPIGYoJBK/TDPgZHb0C6MABIsDIpHHrnbXnkBAAMJZZxqkWaxz6VuC?=
 =?us-ascii?Q?2xpkU30xnTECHcq+dQRGr4ypJ1NcnCiHIwFOidZ8sirbZrTvY1WmDB1LOX3E?=
 =?us-ascii?Q?vfNFpdlx8ZPmlyLGlTIN2LDoTAyxzwQOA5KdSkwFdvDiF2knoSQ/93PBb2bo?=
 =?us-ascii?Q?RLouIpW3T63hfuiOXHAS9vk+OjbMJPlazotbRwRIPiqcD8uGVJAqr0EnJug8?=
 =?us-ascii?Q?uZq9ulZggsw4x9Kd9P+0RI17K2a3+Bs20Iwv9MNrTtupER9TPAv0wd3Hd00T?=
 =?us-ascii?Q?4ACWV3XBZLL6SGAzkAF0MbAl8Om4z78FPi09Cn+oo7/sHuZEx7D9ZBjR6nBV?=
 =?us-ascii?Q?0cnlbt6WWDx7Ks1j3ytiu7+X6pLrGOcB33/ThPhX+uUjS8iZQwPwaoU2/PME?=
 =?us-ascii?Q?SzgbRdvLKw1gon3ChO8ZlV01yPD1UGgewk3j1igQLiE8YGGQ+1zDDS2Y8WcT?=
 =?us-ascii?Q?CNctxv819yFsZz9aQZtb3XWuoJeKbX58R2H9wcocH518ZoRI2hYmJ5y2PwNw?=
 =?us-ascii?Q?Ji1Thno0VIP49Bzo6agBHPlXI+Kkx5OQthO19sKk5XOakzez6hIIH+FbrIzz?=
 =?us-ascii?Q?ThrqhB4/972zix7Bh0wUWn/vWpOvIbCNu6VzlpiPmD+U1PJeOMxlR4iPIPz5?=
 =?us-ascii?Q?Fd+S+Md8ZT1M1RSz33nJKqOenuyyQr+tvfGpvsSs7lZfKWiS/+I9SgUwhw06?=
 =?us-ascii?Q?xVRzO45aAoHmyJFowVV6O46y7IGQeIYX1pLECJbOLNqgy42xN8YsAzS44k3u?=
 =?us-ascii?Q?WfkiRrCZNP2+2ahGqh0zK5CsT44or3WzSwVe4lpEjuIZkv97LtW2yDH6gh8v?=
 =?us-ascii?Q?FZsg7pxQUh/66y1ESK07H4P2cWToWVlNbmxfl1XKNIT2Mnb0zv9c2Dlr6PZr?=
 =?us-ascii?Q?jbxFOUG6ynDdKrPfEaD+DuTYMoZ6mm/a5coSMXtstDtnNR0VzkNzbXo3CIfH?=
 =?us-ascii?Q?jcP7lBXs680WhrXVgC9f6/kY4Iw2WXhxCGYCtmu+ajD/581kUJmLG8EFScDJ?=
 =?us-ascii?Q?6A5rawSNoG+xeoucUR9YqGTqmL5ThjgEDSyTTFkMHbj7zYnbaTIM3JisW7a5?=
 =?us-ascii?Q?6v/4vC3adDdGVyA8nGm0Y+cnEe7zeqockT/wOMhBCnbAW3qN0WQXbRbs3nOh?=
 =?us-ascii?Q?d68S3vt/PmEHyk5kIsfiCfXSq1mgQd+GoqQbo8YHIuM7dx2Gv69521PSQ5vQ?=
 =?us-ascii?Q?t9odYRDUrXiiNd2s20g1VDSWqutq0BCL6odv6j5UG/tHIkm54wx238zvVgv2?=
 =?us-ascii?Q?cSxPy3NYeuCtVA/m95Ozf3NWeT/Oi7tRyYRo4IxupZNKn9MldRIk4Cp1fKGs?=
 =?us-ascii?Q?SY961gop/lCcOvWqz6tiZlzoqSI/OPtjRxKKD4aZdG2J41e1jqB2EznKSpDa?=
 =?us-ascii?Q?6Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5486d272-a9b2-4715-f002-08dbd09b56e4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:03:00.0736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JsAdDWIvO/9VB0KvGycKN6h6GbQpJDld5GVZO34ERfqhr7tOLvJ+/qzTLoiLzj4IOTCvTKSlm4t4oswruVuF8WqP5pP2bK+J1EGorJZbdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7436
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
Changes in v6-v7:
- none

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

