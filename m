Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA412779338
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbjHKPeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236598AbjHKPeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:34:00 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016F330DF;
        Fri, 11 Aug 2023 08:33:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwC1Vlca8uqgYpNcbC9Uj2IFroRiHXCMBmxWxqj+7aYwOtbLs6yZydhDj/ALIh45be1Du2aw1VTDgCng6xSTmcfup3CasobTdR0LlS4eGMifh/iq7LZHM8xfK9PV8fAjDm2Y1EJSZaG5jhj38pBBcmRcw/4ZBUtWpD25CEUPh4O8fWHr6I94KHw6QMSR/ubmlAv+DF/Ahxe1qZ5u5zjpQ5OTifiQPr0FKa0xz1KKr+/zVu734dL7/kAvdefPGDtdEZY8osq2rbSqN+6qxC9ev4bN81gg+q3bZxITNgCUIktoCrq0h2tX/s5fAzQ7daKjY7wt7S34Hxye7HDJn29ZOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGm9AQ3LClk4b22e3mfvo+vrMF1yzGJZeFvv6yDBTCI=;
 b=cKa70QQdQ9BswzQdJMUBCkN2jUVQJ5aLYqywVXDU5SlRnYMwJmyKnMAWQVZQMWpZ9hsS9htrugVQfMrUwcQQnLsvZUsj97CC9xbpECnQ9ilPV2ycEZzMuSF6XEgGrtmgCaKOVXzffYLcnxbo4mXlU8VZdXO/eIpZtLH2Qi71S8RKSN8jPIsztqDPNBccjH+9o+RvYZH4vS/hnNTM+/qCPSMd3FrEVlQc/kDPmdOoul/gxyazRqQlplD7pjGZx7v35Wxey0egKvI/6sr5SIJTXXuG/ptZps9m30sp+rwuDNAuQOLVyorIC2JYDvs0776IAWMc06vrI+FApF3/ty7NkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGm9AQ3LClk4b22e3mfvo+vrMF1yzGJZeFvv6yDBTCI=;
 b=fxkLvnbJV0AngXdHb/PO0z1BV/JaKHzycN4+0DSFLDgR2V1Hb47qQR7Bm299plsUoezYhedVeCA3Z86iBSxiuy4Asu1rcQpJS0Z1g06yJav7sde0nLajjpET+B6L2H4fBO0pwNDl83DSFs2MaH8c2SVrTRwUAhDRuWhfreT0YUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by PR3PR04MB7338.eurprd04.prod.outlook.com (2603:10a6:102:80::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 15:33:47 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 15:33:47 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [RFC net-next v1 5/5] net: phy: nxp-c45-tja11xx: implement mdo_insert_tx_tag
Date:   Fri, 11 Aug 2023 18:32:49 +0300
Message-Id: <20230811153249.283984-6-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 55c8589b-75a0-409e-c9b1-08db9a805acf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: od3NUWz1cUTSXYyaYMFfd04qYfj3U87f/UgfTSLTVNhWHuFe9fo0hpLbQ3KMZnYbSZNF+7NgiMw1egve/RBicpj5B0ixA1x/iu+FCIA3I9TthEpgTh91htAaFEm5xLRH2G4qsxcmZdytBPWw5Ye+14iiSrFhkKp/ut2MwPefyz6meft5owjnkhZ6/THLI3CRDDNjO75fXjweWhjbgy9/ypHy16l/l9SS+qacxIAvcTSfBsbHFF0AiP/0Cz4KBq/LJtfqqQbzMaBahmiYyhSvNzeLN76c0F8AyVajdu4ddiQ+1CD+a6L77weC5fCryIODM+kxRaEFKiS8BJ7Knt/nfabYp5RCTYfKjKZi/tHcArV7I2W3QerY+BzQ3EIlQ6lDfXPvmkwDLq+wBk6dBJofivWYBvLIsNt9YA+MYY1XKxcGjXTBpr8Azp7petVz2qFfXjkCIq85SMnHpfyQTa/HjyOJSxegm+AQwO/atQFrGi0QV2Qh3PSxC1wtksrCP+2bG7/iN5QpRHxqh08FO/gec3dK0J+uSnmtaEERIIX8+xLcdeOSf5V9Evxor//a1jTzAx2hTb6fjczX+KVugn6yx5lmkpDYcGk4pdEghPl/cAw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(186006)(451199021)(1800799006)(2906002)(6486002)(52116002)(38100700002)(2616005)(6512007)(26005)(1076003)(38350700002)(6506007)(478600001)(316002)(4326008)(66946007)(41300700001)(8676002)(8936002)(5660300002)(66556008)(66476007)(7416002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QTt48vgxYROeggHotlZV4j/o8TSeE8YeZboAWzXwR/PmoAc1lcYeGyO3SUzX?=
 =?us-ascii?Q?RM/SnNw5ItnZF8SCtt7LqqeDVtHxKnnaYPILN712HWYU4mrG8KOAesXI44Th?=
 =?us-ascii?Q?ZvRVFa6jzp19UemSLFt3tIotZ4JP3lRticxRnrp4cY0LzgfsQ62e/jYuSpx3?=
 =?us-ascii?Q?aAYIiNjAoULMS7kOXHPf7B8yH8oVQy2UQJdZoMs89i+O25FSmzc+rNfqN49R?=
 =?us-ascii?Q?JeFGqWq98cWI5KiqvjBI/2Zleinb0rK1IJAAnuMzDb3X46iSBW1zIEEtd5+4?=
 =?us-ascii?Q?1TE1KMdxguauf2gID6LWY1uvJgQIfSgT0WqM8RAHuezaSnu1b8k6A6IW2Ai3?=
 =?us-ascii?Q?4+VsjQduDc0OFP7VdWW1vuLVj3Pt9r04CxixE6NljBFaSB7yFoxslEWHaoPu?=
 =?us-ascii?Q?bo0RaTYkhhpFqSRQovhBpyOEwQSNe9pvkfZQdgbeumNJgjy4SrCJX42AQQcV?=
 =?us-ascii?Q?jpvW3tNKVWtgB5Gm8fcPhlbh2hoz6DhOwPKtipdm7eqIi6Q19UK/dm2mbQjZ?=
 =?us-ascii?Q?Tad53N8PcsVPaR8v5fCGW+REfAouEFAoSUkiWDj47Zpe++1zjftPF4lY5ZTN?=
 =?us-ascii?Q?5B3esLb3rPzaxQOHOuQSIEpftBCz4x2/Eu20KNBKSP74o1tDHfiJmJ7fo5WG?=
 =?us-ascii?Q?OxK8xHC5DqiRsEw0hhNmu0QsSqDCk93E0y+1leID9aMkP3XhWS3lHfN1TZ0k?=
 =?us-ascii?Q?BrKe7lD73/cE4Bji6HnEkQQq6KYxY79inv16xCt0OVJPykTqVZHdTiDE0uDx?=
 =?us-ascii?Q?FwjyctMniWTJ4OEbHgMZbpLUttnGOJboJjVRVv2qY/dxZWOjHcY9A2DCkYII?=
 =?us-ascii?Q?JFvAG5fxPxX0WW6dJaAGhoQPjIq1+zMP2Smb1Aki4m2oK9tjUMC+LYdkf4XM?=
 =?us-ascii?Q?tz65f/Wz9lf6fUmghml/BKUeV1Wwq3MT536nVCxgKSFsFJrcvjaps4Pn6240?=
 =?us-ascii?Q?EsKJC4NaWLNzoi8NowW0wr0MRXvHAPimS6ZtKllEob5zUPkV13uvrmtvi76t?=
 =?us-ascii?Q?FQ4/GAWeARjuFoSQmqMWoAj8K7oOy47z8DUp77SLMISJ2DX7TQ4cpgp6HRUC?=
 =?us-ascii?Q?woiLydg+auP+RiNqDwbILT3mKBrvI9OQDoIQpoODIdT7b5e9sHxLGtvGfWfl?=
 =?us-ascii?Q?85XjWQA6+Ye0LzE5akNCL5w3GJ6mmbrfmVAoHxuWUZRmL4XBJuS8GTdDJLnp?=
 =?us-ascii?Q?AmWop2rICtgIhseHgLPorU+Z3SDfeMfeApS0lGBs/cE3syf50BrRZjW0fWFi?=
 =?us-ascii?Q?SsbIz5s/kPlRc54A+D0H5tyN+rvjWz/qxLGx0AURysSI7jo9J9DPNedx266f?=
 =?us-ascii?Q?Ufoq1st05jWVYbAOjLh7HzfiBr0DTLnSeYBa2oW49jRcnX75CwYHU9KVCjhl?=
 =?us-ascii?Q?ifN4/pLvZleBhcr4fgcp8I5Vo5qLFGHsc3Xk0bbKPKsfjbjmrgYSWrvp5Sw1?=
 =?us-ascii?Q?O/6Di10gJd465c/f8EPNxOmHmAY7weaOl1pm1CHOSWqxqmeVV1k19IWBL5JA?=
 =?us-ascii?Q?lUJdnrbuMSpPgPKFQ0fjyhPyHBj78qyRj4UoXZmEqUn9Cc/9VRz6Ra+WgCkI?=
 =?us-ascii?Q?b8qDaIKucNJpuHSedLqrn9M8DKlmaxCtih9D62Vxu70rsoGVMDbr1iiEUr97?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c8589b-75a0-409e-c9b1-08db9a805acf
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 15:33:47.4627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5WR/6ct9MwVE2PVmAXFkc/wPWaIbjJfi8uUzx4VmZQvaIDhSvriw2f3/2ysuXpruZN7y1vgQDBWGUlqwu5F8RWzNFVGIgIbRaoY6gE7DnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7338
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

The TLV header contains the TX SC that will be used to encrypt the
frame.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 59 ++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx-macsec.c b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
index da63e35571d0..53f8706bc572 100644
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
@@ -167,6 +171,14 @@
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
 struct nxp_c45_rx_sc {
 	struct macsec_rx_sc *rx_sc;
 	struct macsec_rx_sa *rx_sa_a;
@@ -310,6 +322,7 @@ void nxp_c45_macsec_config_init(struct phy_device *phydev)
 			 MACSEC_EN | ADAPTER_EN);
 
 	nxp_c45_macsec_write(phydev, ADPTR_CNTRL, ADPTR_CNTRL_CONFIG_EN);
+	nxp_c45_macsec_write(phydev, ADPTR_TX_TAG_CNTRL, ADPTR_TX_TAG_CNTRL_ENA);
 	nxp_c45_macsec_write(phydev, ADPTR_CNTRL, ADPTR_CNTRL_CONFIG_EN |
 			     ADPTR_CNTRL_ADPTR_EN);
 	nxp_c45_macsec_write(phydev, ADPTR_CNTRL,
@@ -322,6 +335,8 @@ void nxp_c45_macsec_config_init(struct phy_device *phydev)
 	nxp_c45_macsec_write(phydev, MACSEC_UPFR0M1, MACSEC_OVP);
 	nxp_c45_macsec_write(phydev, MACSEC_UPFR0M2, ETYPE_MASK);
 	nxp_c45_macsec_write(phydev, MACSEC_UPFR0R, MACSEC_UPFR_EN);
+
+	nxp_c45_macsec_write(phydev, MACSEC_CFG, MACSEC_CFG_EXTSCS);
 }
 
 static void nxp_c45_macsec_cfg_ptp(struct phy_device *phydev, bool enable)
@@ -1750,6 +1765,47 @@ static int nxp_c45_mdo_get_rx_sa_stats(struct macsec_context *ctx)
 	return 0;
 }
 
+struct tja11xx_tlv_header {
+	struct ethhdr eth;
+	u8 subtype;
+	u8 len;
+	u8 payload[28];
+};
+
+static int nxp_c45_mdo_insert_tx_tag(struct macsec_context *ctx)
+{
+	struct nxp_c45_phy *priv = ctx->phydev->priv;
+	struct sk_buff *skb = ctx->skb;
+	struct tja11xx_tlv_header *tlv;
+	struct nxp_c45_secy *phy_secy;
+	struct metadata_dst *md_dst;
+	struct ethhdr *eth;
+	sci_t sci;
+
+	md_dst = skb_metadata_dst(skb);
+	if (!md_dst)
+		return -EINVAL;
+
+	sci = md_dst->u.macsec_info.sci;
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
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
+	tlv->payload[3] = phy_secy->secy_id << MACSEC_TLV_SC_ID_OFF |
+		MACSEC_TLV_CP;
+
+	return 0;
+}
+
 static const struct macsec_ops nxp_c45_macsec_ops = {
 	.mdo_dev_open = nxp_c45_mdo_dev_open,
 	.mdo_dev_stop = nxp_c45_mdo_dev_stop,
@@ -1770,6 +1826,9 @@ static const struct macsec_ops nxp_c45_macsec_ops = {
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

