Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E832786B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbjHXJRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237853AbjHXJQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:16:58 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2045.outbound.protection.outlook.com [40.107.249.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F5010FA;
        Thu, 24 Aug 2023 02:16:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRL8IFSm6Pmdm7ai/bd6P7WjCFiBRjvEs7QAIaoFQS9Y7kfCcDJhunXMSZh6f26vEh89QnvcAYP0dre5Wvnhg4JTvVCTVgjmtY+GHf8KKQMkD6rQj5931hRIhfGLEBy8jhm/o9tZMwTNVZJtu+k3Jp2/vPzZGcXledjJmg6/FWSdSwiF3UsebfYBmpCS8YgkB7fMnFx+3x3uzbL5MLeY9jJk6TILd6i57x2Zs/VuOw2kGyyHSz24QGLBWgF8NCYv5eXJlqE7CLygDq8yWyo22Z3m9kvVnqSrAd12LntpOU/3enVKhVhz5oJ6DouHzKvFGjqZcSF1i36Rad0zY0Vu/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nutZQJPCqR1y0+LI0oPQ/hYUO5Bl2EabmBwdKKgTAIs=;
 b=gGLu3q26M8TXjJbEvmqm/ISWRChR2OaQzTN64Ops60KH5kzAGUJ5P7Qat/tY9aaTEyJn37hp+tbGiwOTRXeIu9uior2jz+BmsrCdPziCz1UdSwwlppf+mLaI8gzClinpS0Qr4iVmICx//Oeuhe3ZRfDlnH0qangdB2nr8OdclboXev8bzoBGpTPyjqL9k2QyTXkvhiYNCnrENILfGs0pICMprVBTRjyAqjRO1FajMdvXfT0YmLP/eq+eB9GigCcswkIldTzrgtv3ezU9ovBpWZLMHsL5OkcEbJDmsEzejD4R7IDpWMkmv2v/in1u1pBZZV0MpyyUHhb882QdLTsEYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nutZQJPCqR1y0+LI0oPQ/hYUO5Bl2EabmBwdKKgTAIs=;
 b=K3JVUMsHkmpof2Bba0ABiEbHCVCYA4UmleGfjYnlAmsRNxlxWJ91haQBqc2aYNpVEqF+K97LFfQzJ50SezH+nN61puia4KrqaYuNkshPtHkTRoxTZuZPijIhfw9mYDE+VF1f6EV8ThRYhyxlnYauo8eAYd8+pmrtebYMT+sltJM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DB9PR04MB8138.eurprd04.prod.outlook.com (2603:10a6:10:25c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 09:16:54 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%5]) with mapi id 15.20.6678.031; Thu, 24 Aug 2023
 09:16:53 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [RFC net-next v2 5/5] net: phy: nxp-c45-tja11xx: implement mdo_insert_tx_tag
Date:   Thu, 24 Aug 2023 12:16:15 +0300
Message-Id: <20230824091615.191379-6-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|DB9PR04MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: d41f8702-7190-4255-f255-08dba482db50
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZNHRgb4K5oDNnr1aqkKAx5wHgwT8LWLba/4mz2jYYQlDJNLL5H3ttTBBqC53HmCg9trrGCD4QP2pXSY8pdrE8Z0r/bJ1+MUdA9xFpkJSzB4GktUheVB+R7MTBhKIv7qkl096jZNmAJVFZUpZ7bT82tubdM7bkRQ+J2UoPZXdaChBddt6qqYAegQLigYZ1YdzMDPH2NPTqmXY5AEOcS0L5ZJlmP4Ua2+IeoYYOkWYtqwrZrq9tj4PxVbXiTJRWeHQ6NwjaJWwg7dHgCadlAk9lVJJVUJeZyL57CiE3DrP1bx4ufKcliPtbwXM88KEnVd0AgDNwNv95qcrCy1JxZOMKUkeeGSuFnokG8ipatPlmWdksytzLGag3VMtq4A9pTdf+aEeGNjlklIdXnUb596k4DILPwmCM/eV+EnnhQY2sPliqimYNygCzGgZA60Wr2xOAY3JV/ZBOztJD4MwmGxVcaIoQNzTwDXSc35eBtcs4jQ5Fnb8g/lfvD2hM7PINvx6zweoERnD+MrUIPb4vZvgHVtXV3qdpi8YrXx2lByGUsyiQxaaBKTjtirKL1T/pa6oVhQlBSmemFU2M/hWpuSWVXRzdWT1e1/pp72RSH0iUPC5VBQhWBz8GPLw5uwgGnf8y6lqiEpIyakDlELSDhMNYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(186009)(1800799009)(451199024)(1076003)(2616005)(5660300002)(4326008)(8676002)(8936002)(7416002)(26005)(38350700002)(921005)(6666004)(38100700002)(66946007)(66556008)(66476007)(316002)(478600001)(41300700001)(6512007)(2906002)(6506007)(86362001)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UAS6clcZeAwHzm1GZzLg+gFgVp0sahGzIOyvHWx6daNhZtYzt+Wzfj1eRAz3?=
 =?us-ascii?Q?TKWItkTdVlJf7UFjvTWGmGkoXeAsj4cGl08EFIgpZGnpAd2ruMsW3FNAQJ5K?=
 =?us-ascii?Q?unRFES+Q4RSOh7fC3rBVxTdvtO3pIGhu/ozhYrgYty2B7m2vIUn0/vLBamGb?=
 =?us-ascii?Q?XG9pQMz3Dd41ardOi6kqATFKbBrM+YdeNhzJAD61LbFGivPDattn880tkOmQ?=
 =?us-ascii?Q?WpozjTTwQ1o0YZm8e8HbwhSaHxwZf8Q/4KBoHcJymjsFecoK3yD5h/GVEvEg?=
 =?us-ascii?Q?WARJSpIFOhGwhkER/Sto62sMxXW/sbKtmncaR58O6na79NvucpMnldUaGMNz?=
 =?us-ascii?Q?UqtDfex8/qTj3XJ7jbw5a3PqAAdJLzr3ssNcsXY8QXGqTiczYnCnF9OeG7mi?=
 =?us-ascii?Q?jbtpZ2enLDHeBKBtuWjm9C3V+sw0EFqBXXRTi/WZbzAto8Wlgfxe3Vcw8Li5?=
 =?us-ascii?Q?FdKLx3hlf+eM0ltEGhxtSVqQHPOTPus5yPn6xTODLqRniFY4ipk8MuI3Sgo7?=
 =?us-ascii?Q?XHqIaR450lo2R69TjVm4st8HUt8aq6Ca66Bzmi/QGjjD8vh29Eks50njGGAE?=
 =?us-ascii?Q?aigoXPo22NrvxNI8vuyr0gsL23ZV+rh5CXJzMDlv1N4xto7RgZXYlWAiHP01?=
 =?us-ascii?Q?TD3QH2EsG1V42WWa5+3ClhTSvM3jMFRO/HphVqYtVNqEvFh91FaSFfO9/xpU?=
 =?us-ascii?Q?tf6rEO2GRd1AYxHY3PIt2Hz4jFpPJbpUEoOgkVi7GGvdf+fi+jtjM8Rqkzga?=
 =?us-ascii?Q?sCPPK1TL1Vxj8URXU9hoilhMe/5MYrKu/gR5sqJ3mQhUykCUfhBz/b2aa8u5?=
 =?us-ascii?Q?U5Rg+RqLhWDJmENwV3Hp5YX7ixHJRsul0vyTm1lGs69dxHZqUb7z/eOy6Lrd?=
 =?us-ascii?Q?dNs+Zk7x1kKiVPLb4ZdDocnQUBCgxXOnS6iDeVTJkFQttvRADzDgnzOzzT+7?=
 =?us-ascii?Q?1mnL0igIe6iNDr6IakyEYY7ovVNLeWRf/HUPa+zgejq3ueDe+vv00RltP5bp?=
 =?us-ascii?Q?ht2b5HdfyjScUu2OcUQdkJkeeJ8ucauvZQ1FoOszDQBvFy2PXAUW/k4WDx/6?=
 =?us-ascii?Q?xk8W2QnMXxaV0Vch6B6LiwbbtarD3emYa0/ultmdMQFDXxzchm4Yq5bvU6zo?=
 =?us-ascii?Q?n7RVKh7dtix3FzojQBbQDnrtl7xMgYs+yiDa93VeEyd4AYARJNwAE/Tc4tzD?=
 =?us-ascii?Q?+lSnSHzmC4GvDrnyHWRD5ZOCj0+OPmCRtVRqorMCbqtweAi9/F4BVB8fW33t?=
 =?us-ascii?Q?bWxx5H24lMddGKIq1s0cAHdG0gpOZqb0kc1WD5LzJZuw8XezXj7xzPW+nhPA?=
 =?us-ascii?Q?/t3c0FClQBScio0LKOWtCdWqIID97swr0w2IaFhAFzQmqM1Uy1+2/2sa6F04?=
 =?us-ascii?Q?TvwKKIQ2rj2f8b1wgV1pyLGWZiHVIuVnRoF4oCVfzIMvgrLork9VALAqd80i?=
 =?us-ascii?Q?Xn4m6kzuxL9Su0m664wiUhIZ+FDm0jKzlY8r++EskGh9XcddYXdIQZwzVp8d?=
 =?us-ascii?Q?O0Y0W2hBiY3mXNK8g1uoqOEFuX0UDwhovtxj4jk87zHVmNOg15cFIBoS1CQi?=
 =?us-ascii?Q?lqvDtGCE+COwI2SJ3hCR9QSG2PUesteiVq5HC+oWwJ2/9aAAYMxgtK2va/ce?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d41f8702-7190-4255-f255-08dba482db50
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 09:16:53.6798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVPGkGTEdT0aDbLnH1U0i/p3NJhEx9zKufwu0CmF3WSdgzeRtpb5R/zAxzWNTTdSETZ1DOYnmyvPemJ9cxiOk8dg/DsKwUdE038C2qCOEes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8138
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement mdo_insert_tx_tag to insert the TLV header in the ethernet
frame.

If extscs parameter is set to 1, then the TLV header will contain the
TX SC that will be used to encrypt the frame, otherwise the TX SC will
be selected using the MAC source address.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 66 ++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx-macsec.c b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
index edfdd2540d39..f06505c04b13 100644
--- a/drivers/net/phy/nxp-c45-tja11xx-macsec.c
+++ b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/phy.h>
 #include <linux/processor.h>
+#include <net/dst_metadata.h>
 #include <net/macsec.h>
 
 #include "nxp-c45-tja11xx.h"
@@ -23,6 +24,7 @@
 #define VEND1_MACSEC_BASE		0x9000
 
 #define MACSEC_CFG			0x0000
+#define MACSEC_CFG_EXTSCS		BIT(26)
 #define MACSEC_CFG_BYPASS		BIT(1)
 #define MACSEC_CFG_S0I			BIT(0)
 
@@ -121,6 +123,8 @@
 #define ADPTR_CNTRL			0x0F00
 #define ADPTR_CNTRL_CONFIG_EN		BIT(14)
 #define ADPTR_CNTRL_ADPTR_EN		BIT(12)
+#define ADPTR_TX_TAG_CNTRL		0x0F0C
+#define ADPTR_TX_TAG_CNTRL_ENA		BIT(31)
 
 #define TX_SC_FLT_BASE			0x800
 #define TX_SC_FLT_SIZE			0x10
@@ -167,6 +171,18 @@
 #define MACSEC_INPBTS			0x0638
 #define MACSEC_IPSNFS			0x063C
 
+#define TJA11XX_TLV_TX_NEEDED_HEADROOM	(32)
+#define TJA11XX_TLV_NEEDED_TAILROOM	(0)
+
+#define MACSEC_TLV_CP			BIT(0)
+#define MACSEC_TLV_SC_ID_OFF		(2)
+
+#define ETH_P_TJA11XX_TLV		(0x4e58)
+
+bool extscs;
+module_param(extscs, bool, 0);
+MODULE_PARM_DESC(extscs, "Select the TX SC using TLV header information.");
+
 struct nxp_c45_rx_sc {
 	struct macsec_rx_sc *rx_sc;
 	struct macsec_rx_sa *rx_sa_a;
@@ -315,6 +331,8 @@ void nxp_c45_macsec_config_init(struct phy_device *phydev)
 
 	nxp_c45_macsec_write(phydev, ADPTR_CNTRL, ADPTR_CNTRL_CONFIG_EN |
 			     ADPTR_CNTRL_ADPTR_EN);
+	nxp_c45_macsec_write(phydev, ADPTR_TX_TAG_CNTRL,
+			     ADPTR_TX_TAG_CNTRL_ENA);
 	nxp_c45_macsec_write(phydev, ADPTR_CNTRL, ADPTR_CNTRL_ADPTR_EN);
 
 	nxp_c45_macsec_write(phydev, MACSEC_TPNET, PN_WRAP_THRESHOLD);
@@ -324,6 +342,9 @@ void nxp_c45_macsec_config_init(struct phy_device *phydev)
 	nxp_c45_macsec_write(phydev, MACSEC_UPFR0M1, MACSEC_OVP);
 	nxp_c45_macsec_write(phydev, MACSEC_UPFR0M2, ETYPE_MASK);
 	nxp_c45_macsec_write(phydev, MACSEC_UPFR0R, MACSEC_UPFR_EN);
+
+	if (extscs)
+		nxp_c45_macsec_write(phydev, MACSEC_CFG, MACSEC_CFG_EXTSCS);
 }
 
 static void nxp_c45_macsec_cfg_ptp(struct phy_device *phydev, bool enable)
@@ -1741,6 +1762,48 @@ static int nxp_c45_mdo_get_rx_sa_stats(struct macsec_context *ctx)
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
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct tja11xx_tlv_header *tlv;
+	struct nxp_c45_secy *phy_secy;
+	struct metadata_dst *md_dst;
+	struct ethhdr *eth;
+	sci_t sci;
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
+	if (!extscs)
+		return 0;
+
+	/* md_dst should be always set if MACsec is offloaded. */
+	md_dst = skb_metadata_dst(skb);
+	sci = md_dst->u.macsec_info.sci;
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	tlv->payload[3] = phy_secy->secy_id << MACSEC_TLV_SC_ID_OFF |
+		MACSEC_TLV_CP;
+
+	return 0;
+}
+
 static const struct macsec_ops nxp_c45_macsec_ops = {
 	.mdo_dev_open = nxp_c45_mdo_dev_open,
 	.mdo_dev_stop = nxp_c45_mdo_dev_stop,
@@ -1761,6 +1824,9 @@ static const struct macsec_ops nxp_c45_macsec_ops = {
 	.mdo_get_tx_sa_stats = nxp_c45_mdo_get_tx_sa_stats,
 	.mdo_get_rx_sc_stats = nxp_c45_mdo_get_rx_sc_stats,
 	.mdo_get_rx_sa_stats = nxp_c45_mdo_get_rx_sa_stats,
+	.mdo_insert_tx_tag = nxp_c45_mdo_insert_tx_tag,
+	.needed_headroom = TJA11XX_TLV_TX_NEEDED_HEADROOM,
+	.needed_tailroom = TJA11XX_TLV_NEEDED_TAILROOM,
 };
 
 int nxp_c45_macsec_probe(struct phy_device *phydev)
-- 
2.34.1

