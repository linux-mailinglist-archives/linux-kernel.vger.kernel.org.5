Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C5679410C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242964AbjIFQDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242931AbjIFQDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:03:13 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2075.outbound.protection.outlook.com [40.107.13.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE6E1997;
        Wed,  6 Sep 2023 09:02:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqECGbUt+d6Xe/qivlmzugOqEiSn5aUfmUD7VlZ7USSQafTNaC9R8/vmUNskzY2D3a9ps+34vd9aiTQhKAxF2UrbAKPBlZ0jf4UipdF2sQoItzzWkXDXIu9TAKMh01NQNXzBFE0Ul2APys3u+xu+QFfygaqcIxSJtc+zVRyVGM1oeXV37OVlaU9uHTZE3E0pU2A7daH2eYM7ySLM21OYFkXUU62ZijEK534fztx/+1+bh/04KpzxUZJSF+PplcO9fPZvJ+0cpbcTJRyRnkDLDZl+wXM9OVZUqEg+k7PBSV5EcIEQDp9Giuhfd1OfHcnC0caxxPe7vhyym3YcjrLPXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17/I6FiWZIbD7l2CuJdKQLegiM8rYflHJRf2PjSqaJY=;
 b=N+GhEVCIfPPR2cElbK9tdUQ/+AQnk8iLPvvrC9uSQW+L+TAcV9k0oWsTsRP0Gz6VWOrfedjOZor8fukm/gBZiXVoV5zwE8qEAUpEvyANiSq+mlsmEeZF8UWbXNKp4464/KA4efy2/d/m2dTY0qyiSLayc0hICxJyiQV3oFVlLqMFVyLXGCToJSTVMYJMF/yRUAOh9k/pOao2vVHDojp/sslGfzRcUHuDaISyssllToU7ZvqIlpfKGpW4eP1RzqXrkUd7+jfnFXpG+6ArVYcp/KIeU/1Vknmg8hIXTObPKxv+e9Nispn47vjGHWAnnf1bE9a4cphOlOuvxk8nNOuyNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17/I6FiWZIbD7l2CuJdKQLegiM8rYflHJRf2PjSqaJY=;
 b=Hi1yzGAGwBIcBraOAbIznsksG/Tm3Zjef+KKxiH7smTsi6JILRcTPqbHnLOyIB8ZIpS4CSzghnCcEb5W5PpvedXytdctyr1wGFlTlMUzW1O6s9vx36GyJXl/BnC123y4KB8BCMa7ZArs0HfEsZ0If2X4pl69uVpQjmsmg4M7uQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8958.eurprd04.prod.outlook.com (2603:10a6:102:20d::11)
 by AS1PR04MB9429.eurprd04.prod.outlook.com (2603:10a6:20b:4db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 16:02:37 +0000
Received: from PAXPR04MB8958.eurprd04.prod.outlook.com
 ([fe80::d7c:390a:4105:65ee]) by PAXPR04MB8958.eurprd04.prod.outlook.com
 ([fe80::d7c:390a:4105:65ee%6]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 16:02:37 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [RFC net-next v3 6/6] net: phy: nxp-c45-tja11xx: implement mdo_insert_tx_tag
Date:   Wed,  6 Sep 2023 19:01:34 +0300
Message-Id: <20230906160134.311993-7-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 58727da3-0c51-4724-4fbf-08dbaef2b043
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FxsmINua+U/8XY9foe+iyCQvoZhNJ2qltE6w+j2vPgJh1jZahICV77GB/FRJyM1hF25srDhAS+FxacVfFQ6g6Jom8okhvtqF69Z48g6x8uRrcP+oSM/EMX4lHQlbK5+L/gBAAv2SCClctPSpq952MbH6Z863qUtBT/JinvBqTNgWZs3FKTuY0N73zI2Cb53HEDsO6ZfqBI14x2ITtXDh6CQJOfIjoFrjkKqKSCq1zuY4hMB8JDizXn1T0If3oyr0jUmfE9X4CG1t/wrt5DV+4dtXCJp9r+OYFgLZSA346SY/MjA0TdfgSlcZg6AaoMH8KSE3M1nW8rCU+eRUijiX/ujOcxSZZA7SbRWufUFEMMB8sM2iFRmDrD0+Zxogan9QwlwwBJ0T07ndETuxWW4CwLHQ7CPfAC8s7o19ejfB+S1VGdWThHm4gkvfc7FadcaFcKPiSV65zt1mzN8nKQ60ab+g/NUisGAr8rW7ZmlBvgoWG07DKxsHMT9XQzNJZeX89hdWjPl6IXyh8lj1TUNjzMOKBhUxd2Ei4RlQ2ePZO9s/hWcDKSy3Fib5Jlf/VH/mYHJSIROIdqWxRCVuf5/Tm6vOresLXIdvrKAOQvlPMhuVuvU66yeFZmd+230P8JQkNEcuP2wq4N8iQ1EyiMxUFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8958.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(41300700001)(7416002)(921005)(38350700002)(86362001)(2616005)(478600001)(26005)(6666004)(6512007)(1076003)(6486002)(6506007)(52116002)(38100700002)(66476007)(66556008)(66946007)(316002)(2906002)(8936002)(5660300002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?upfcEymQvyyygOIj65HL9c/jWCOEG4oJ0TAbUCeu/id7yvXNrNADZqfwe2Z7?=
 =?us-ascii?Q?U1vrqYmRJm0+xZpBTjFXQ8fmfEZMqrFnNwawTKrdBcOOKkeQXW+rlyt32flM?=
 =?us-ascii?Q?krW7aj40f5P+0pY9maAFtGO4+8gzorZcckS5h72iGge0Sb+SfGuEuoFl5Wcq?=
 =?us-ascii?Q?28tdN4DFEujMtaPY2aEXeiry3oxHd+u7M3r7FpS1bZY+R3/sqbHG0jqDS743?=
 =?us-ascii?Q?E5XT7qrNTr49fuQ3AzpnM+mG4N+S0HnGU7Qjf3lAu08xzppWKatoxQLKrIVm?=
 =?us-ascii?Q?rgw+gWNt/QSWvGTCl8RrCvH82JXheQEdfYAyXIUctTfdnc1BVgwDHO0zs7Rv?=
 =?us-ascii?Q?yP5hnhVe+HdfMnNOdzMpPVT6Qtf6fNXbIxoPU2C1MCRJ/YvJaPaJ46sIyLlI?=
 =?us-ascii?Q?nPBLevHYf4B+E1BeErYgS8hVhH3FbUYSGaUiQCGiJXf+25X1kNDw2J3fHVkN?=
 =?us-ascii?Q?9/drueTFxezPDQ8SQ2XnmZRyA//McL7l2+yk99OnpI4Hkv628bf1ApIms3EJ?=
 =?us-ascii?Q?9IIfAko4FvyOu80I/2LvAs/qWuNAzwJZUdVBeiZpyfNOSYvlCdgosOSqlkdt?=
 =?us-ascii?Q?aPOHAXOyYSPWLewk1+rCZsf+XY6osx1FsHexNJnysETot7/STCg3MWxyWJA+?=
 =?us-ascii?Q?letonSnp6aH2ELyfiXnRDMW/Szp/uKE4MYZ7THwDkp3K5MdjQCxtG5FBuzhp?=
 =?us-ascii?Q?VsUgzBkYzXGzxQ6W2zjExxPo6QiojAIlHPdYMGqOhxXbDWfgpdQGzwTuOSra?=
 =?us-ascii?Q?dvlL2j2cXx6XB9htYX6a0jthvbQ0PLo8Bo1Y5jhoq2Q6ZxJpdGsPDslcz4W3?=
 =?us-ascii?Q?+hq+T6sHOkEwUqR0lniUVnSNSTQPmfnmFXi7ZD+pZuzcjSgv7WQYE0RUIBUV?=
 =?us-ascii?Q?b/tblHPueERQ5TPJjcxosQYmUPtZMaOiZhMzo8zIDp1dxmHjCT/X4C6gmOD5?=
 =?us-ascii?Q?F6/tLUoK18VeVq6b9pOHiOdAulzcZWbuTlQysq9T6mT65WT0jxzaSiQfu3aU?=
 =?us-ascii?Q?hNk0EYE3Wvmb4Z3Dz4XvvBaUB9pt96+6BUqxybTiO3Oa0iLfQD2jS4066/5O?=
 =?us-ascii?Q?P44rQYjfo4mmm2NWk0wtgTIKEsqkXAU1sUyC/XKYuoLkESxzw/XXR1BCQaUZ?=
 =?us-ascii?Q?JMNweFiok8NVcHR6FgUz3ENMeqgANcX18oI777UA60dJENByoN29tvlXpX6k?=
 =?us-ascii?Q?AYd3e0j7cMjhiQdmamvqJ5DVTqWB3qG+HxPEftp3zo9SPvlONiCWXEnA92Mg?=
 =?us-ascii?Q?kujQtvTc8khtl9Ht7zCW4t81FnPbFcqZw+FOVuH0BjWpqsZBXyHJMsx5MgR6?=
 =?us-ascii?Q?UvwZpaq02bZLeeSrwm8kmtt3a2qzm9v8H0EUl7BNCL03R4AFjuhkRaULOGKK?=
 =?us-ascii?Q?aG1GKR7TWi8Xs6t27BYigeg4/HBho0kBR3Rr/JeeLOKGef04SXsIWzPzKxvs?=
 =?us-ascii?Q?Vf4WmiST9fTwVuWE/WB6IJ5d4y1ZFexD3CNjmTRU7ZwrMElfhpsPzZ+ytIFO?=
 =?us-ascii?Q?HpM8vqEDtT9mKqLe7hgM4GIfJVlqk9EBhp41utMuapW/ILfk/WsjJl4ffyPW?=
 =?us-ascii?Q?/S5eX0DJXXcPlgjy/Y0+HsNMNv/CLh9WiZmzHes6zfOdVUMZnC1tdSwN+93M?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58727da3-0c51-4724-4fbf-08dbaef2b043
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8958.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 16:02:37.2761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2aMmGg5AVFQuaK25OTt9SIwBwAGMcDGqNQfkRX6QacRn9D11wvXiT2lt6uZCAZ34elxBfAdXhmRklH7OxInhpUvRdKQu6+HjLvKtWujXh7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9429
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

If extscs parameter is set to 1, then the TLV header will contain the
TX SC that will be used to encrypt the frame, otherwise the TX SC will
be selected using the MAC source address.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---

Changes in V3:
- extscs parameter renamed to macsec_extscs and improved description

Changes in V2:
- added extscs parameter to choose the TX SC selection mechanism between
and MAC SA based selection and TLV header based selection
 
 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 72 ++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx-macsec.c b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
index ec827b2080d8..e2c7794a4a09 100644
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
 
@@ -118,6 +120,8 @@
 #define ADPTR_CNTRL			0x0F00
 #define ADPTR_CNTRL_CONFIG_EN		BIT(14)
 #define ADPTR_CNTRL_ADPTR_EN		BIT(12)
+#define ADPTR_TX_TAG_CNTRL		0x0F0C
+#define ADPTR_TX_TAG_CNTRL_ENA		BIT(31)
 
 #define TX_SC_FLT_BASE			0x800
 #define TX_SC_FLT_SIZE			0x10
@@ -166,6 +170,18 @@
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
+static bool macsec_extscs;
+module_param(macsec_extscs, bool, 0);
+MODULE_PARM_DESC(macsec_extscs, "Select the TX SC using TLV header information. PTP frames encryption cannot work when this feature is enabled");
+
 enum nxp_c45_sa_type {
 	TX_SA,
 	RX_SA,
@@ -1523,6 +1539,48 @@ static int nxp_c45_mdo_get_rx_sa_stats(struct macsec_context *ctx)
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
+	if (!macsec_extscs)
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
@@ -1543,6 +1601,9 @@ static const struct macsec_ops nxp_c45_macsec_ops = {
 	.mdo_get_tx_sa_stats = nxp_c45_mdo_get_tx_sa_stats,
 	.mdo_get_rx_sc_stats = nxp_c45_mdo_get_rx_sc_stats,
 	.mdo_get_rx_sa_stats = nxp_c45_mdo_get_rx_sa_stats,
+	.mdo_insert_tx_tag = nxp_c45_mdo_insert_tx_tag,
+	.needed_headroom = TJA11XX_TLV_TX_NEEDED_HEADROOM,
+	.needed_tailroom = TJA11XX_TLV_NEEDED_TAILROOM,
 };
 
 int nxp_c45_macsec_config_init(struct phy_device *phydev)
@@ -1562,6 +1623,11 @@ int nxp_c45_macsec_config_init(struct phy_device *phydev)
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
@@ -1584,6 +1650,12 @@ int nxp_c45_macsec_config_init(struct phy_device *phydev)
 		return ret;
 
 	ret = nxp_c45_macsec_write(phydev, MACSEC_UPFR0R, MACSEC_UPFR_EN);
+	if (ret)
+		return ret;
+
+	if (macsec_extscs)
+		ret = nxp_c45_macsec_write(phydev, MACSEC_CFG,
+					   MACSEC_CFG_EXTSCS);
 
 	return ret;
 }
-- 
2.34.1

