Return-Path: <linux-kernel+bounces-5428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51210818A99
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFD2AB23073
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF5D34557;
	Tue, 19 Dec 2023 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ELcL5ZXc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2075.outbound.protection.outlook.com [40.107.13.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC13262B6;
	Tue, 19 Dec 2023 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/elW8gvFs0r5/bc+BnJSsYvCPFIObA52Rp2F3m49iDENrBXyli5mq1a+mX7B76smsqOsu1+5asLagWMlmHKABgEmcZF2NS3qRZisvErYL2BgUFtlRFDZvWoyLk+1kHcyhAg1nHKotKOP1zjIjeG6nSJ9NM/d/laybki4w60TvBQV41Qj5RNVN2OFasTPPPizLLGxofJfbuLzUwLS2qaTxmeSMxKGAel1Dw/FqJ4WpB5rdN4KhWipe7rGfPoNNh6Z1awtDEqQrft4k5c5Myach6JBQbsfmNTL9kJgKbts/5sZ5Ah+m9+APOOzeXz/3tx6t9Ew9zbasKCq8kRfIojUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O1w+rrf6fhToxrc73HPl1BH+Xp01TOcL3R3Djvj+50M=;
 b=h//iZaSq2Fo4NMj3SvUjA3zz1N14LLZ+WvIp0WEmEeApxvA6eeqWIhaqmBWgbAN2XJqp1MVfqgghyJTgtVC7jF3bnW060EAai6+lnDnU3WAeevtKmfqgGo3jxc4Ok1/OduU5nR+niDyzz/VAOdkd9L/XJm8nMl+JmNZx11YJ4+N0MqG51F91yUm3lmIssaqqg8Uu7ru4stwlIzs1/TDngwkuqSeFMi8QxENQxxpbbMWgoMoCNVSOPFGQGRh4hUv4DrhNFSWcag9G2aDx1DiExoGwjJ3Yid6V9nXEAWEwi/T09+Z90ByoaZI84Ow5pln4wwzAa9zXCNtJN5MqR2e2ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O1w+rrf6fhToxrc73HPl1BH+Xp01TOcL3R3Djvj+50M=;
 b=ELcL5ZXc3LJB8n4jdN2jBkEHXQWhgz3uPjvm/H6A+bwS59RufzxBe58OsZz1atEt67hCic/jqjK/OZokLK+Gn414z43kt25o/b+N7z7wEF8s+Sy8kS8Ylt7S2q6knqYaFpsYOQjXEuhN+O8Xpq2Rs5vVkEXq8TI8u7r/fFjqQn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS8PR04MB9142.eurprd04.prod.outlook.com (2603:10a6:20b:449::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Tue, 19 Dec
 2023 14:54:32 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c%6]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 14:54:32 +0000
From: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To: sd@queasysnail.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	richardcochran@gmail.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	sebastian.tobuschat@oss.nxp.com,
	andrei.botila@oss.nxp.com,
	"Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v9 9/9] net: phy: nxp-c45-tja11xx: implement mdo_insert_tx_tag
Date: Tue, 19 Dec 2023 16:53:33 +0200
Message-Id: <20231219145333.240323-10-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219145333.240323-1-radu-nicolae.pirea@oss.nxp.com>
References: <20231219145333.240323-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0104.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::45) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AS8PR04MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: da60f44e-cb36-4131-3c1a-08dc00a268a5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q4EaUNOuJAqgU9k5RsiSXH94mW6H0pw9PylRVNXf/HnEoCG5YVQjEoik/5bGilStcCHYRojDtttaE5ElTjU9xEZousiA9Lckilz3idbjdRlm4F94G8O0BPeV6ZI3gaX+L4cBfq4JWaNsTAb7Mee9uh0vr2b/VA/ej+O3WNkifNcBzUekvHe5QH1JzitBP5RZISn21bH7X2NKA/HobUQC3aUmly4PJ6MoaGdOFmLSQh0/BlYbHmn/VjicF4j3zThoyBcte7s4LgV++SXRy5E27v4ERI5fp+2CV9UWiidH4pn76eQ6hIAzwafwCnj2YpEwSXiCtlpJvCaV1cgfCNkn+zoLRSdJcGxgF4ZvRRvEp/nbmPHxrkTY2GI4Nv7zPfK9EJda6HDFpzU8D/OTGLmreuSAdtERYUpywit95j2Os2t2mo2KIvAv9Ycdr8F+dA7xZRCQZ8s/XZ8k1nEAwK5XK+3NgqtiSERAZxgaRJY2OBS0pdHtyl3BtOmeXL1Wa157VFB1ccqhd8tFL8shN+BcPgeuIF6WKyIDdR9dSzPo4f7afKe09JDOjrPVrRV3fGfLgfmADIbt8lottljLFy4f4kGCNIupsAx5/uQohgZr3XRoeC5LwjcF3PsuTAyP2Af/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(136003)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(52116002)(2616005)(1076003)(38100700002)(66946007)(316002)(7416002)(5660300002)(41300700001)(8936002)(478600001)(2906002)(66476007)(6486002)(66556008)(6506007)(6512007)(4326008)(8676002)(86362001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9sCIHuf3fFexnm5d4pKjaDd0f0a+JXseReC+NmFAl3F4ZOa9T+jDJRxDv0Tb?=
 =?us-ascii?Q?WZXJi3u1ZoS+CmAe0LbsEgHvfKGNu5sYAkBvjPr16TiCq6AQdrxb20yNPziE?=
 =?us-ascii?Q?g1iG+AotLHDof8VqnhJAgRiwIpwZLGZwEvDnY5uCxbYtQukZZnq/wJFA7/jm?=
 =?us-ascii?Q?oCsJyjGaGoceepAZpxGEVpRQMDbOaVnEBTDEmoYhOAf9cIDU2WMLa+4E1S5r?=
 =?us-ascii?Q?El33iGjI+NQfbVscTCc0yT8Pwz6z5fZVjPG/DlmBV6vrXFfzjPRkpnxgJYIn?=
 =?us-ascii?Q?brjMvny3V8sOTatmOcykQGQP2V1tCHMk6MxZtWkbl9bZUDawJRgJsA4aUEDs?=
 =?us-ascii?Q?AcYx8PvbmDnAeFBz/SgC/N50eLAUHMRO2xc+HiM8ghZSSObUhm+3pPOidZo5?=
 =?us-ascii?Q?H5HVZwTFyKo73I9k0V51UKUKVcbaeHB8AJAlTiAVRZvMG5xwlj8Mkdnu1Y1Q?=
 =?us-ascii?Q?GChj9KtcNIO+0EwPQJAzZAMA3bx9fJGB7oWlbpVhqOAXkEFVKVUgEuVSziWU?=
 =?us-ascii?Q?Ngx1vNMvTlIOXY2saI5Kx2d8SCC+Mu/2Ix+pahaEbkD9HXrDyGvOgZpKS5Qk?=
 =?us-ascii?Q?I2Pntx7oGCFWIMIgSaSoXa0F9Mktjc6if3lkPAiYjjOXLGfj7fzVTe/26RY8?=
 =?us-ascii?Q?snNWWvkpETa8QKQ2tZNid5SA9X8WXFKSQGDGULOhRB1WsjMzeggeiWcUwdSh?=
 =?us-ascii?Q?OKu+iEAG1rfnZYwJakuHXuXi+4gqxqwOSAJE54yrsDZ5E83HwfUxzB+QLgob?=
 =?us-ascii?Q?kzqfC13f1mNRxLe7iZ8FN5JKLKq/XDh+wwAHhUfQejuEzqClk0zzfU1G0BnB?=
 =?us-ascii?Q?kpI1MQWERl96sEw5ckJHmRF7BIXq0WiGiNO7a5jkNb54S0V3fXhFB6OIgO/d?=
 =?us-ascii?Q?ErNKC7gYwjUbqdL+f3jn7nc/3rRyAKThaKYex5yMAB06JA+Sv4+6Ip7UU64C?=
 =?us-ascii?Q?gNax6jnoMlsfn5ZV7V+iY1b2J55Hj8h9IFW3dDh91pTdM77Imfuw+TgEe1z5?=
 =?us-ascii?Q?PA3Q6VB3MRQe/+ojfWeXajHFyT3dkSVZyhDFg+s/r2U7hInxw+CA2KIVPHV+?=
 =?us-ascii?Q?yVa/9UM0OU6FhJbyeKsEPHWkhGoZq8BSB8CrJlWI/Jjlrp2tv3TKQ54nbk5o?=
 =?us-ascii?Q?fLP/0ZnbL/DR0zZxOkcafE20ahtHaTwBkp9vvslNnJeCHGHpZcic635cpbaA?=
 =?us-ascii?Q?ozybXeny4o96dHcoWg2lJzRjSBt12RWNf1y9jvNVYB4U2K60dE9xG5y9V86V?=
 =?us-ascii?Q?tpfqGovFkz14N4UCc4dBFYCXezBTAY2Yloy/TC5AebKeKnAJJP7l4M/R7lKD?=
 =?us-ascii?Q?YmJ87UbuSqX0b38uHgImgFs/KQfi2M2bgV6vrN8ftolomI2gDJPb2BbOEm0T?=
 =?us-ascii?Q?6hAodWghT8C4tF10eTu1CNFLW8KpEHIpuZvBWtcW9gwJqW3hMGZ6meyD4Vvr?=
 =?us-ascii?Q?cgKRe1YO37ePJWEhnDfRdvSJkk8i0YmBSV5HbS5iJy30Eq2V8dEnQikoDifV?=
 =?us-ascii?Q?NTikYryomizAyQqzFIfGLwOx22+SuuH2XtMqk3VS08K6k4Jt4VaM4d/Q2ug4?=
 =?us-ascii?Q?c2OsAK9qURpT9H1TSoB+Bxf1jSGTpa23IfNFQLVO22xLGA7A8bmYca8J1dO9?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da60f44e-cb36-4131-3c1a-08dc00a268a5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 14:54:32.2294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1AYIz9fJaNbjC7M9wLNSkOaNvUrXc6lJWwTNR9bKj2MVdMx+BwFzhbkLjvBux/Wvzc8tJPOqH8ADNFepyFZ2G9hWEQhGCqCfKXSFEkKlRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9142

Implement mdo_insert_tx_tag to insert the TLV header in the ethernet
frame.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v6-v9:
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
index 40a926ffb318..550ef08970f4 100644
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
@@ -1543,6 +1551,31 @@ static int nxp_c45_mdo_get_rx_sa_stats(struct macsec_context *ctx)
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
@@ -1563,6 +1596,9 @@ static const struct macsec_ops nxp_c45_macsec_ops = {
 	.mdo_get_tx_sa_stats = nxp_c45_mdo_get_tx_sa_stats,
 	.mdo_get_rx_sc_stats = nxp_c45_mdo_get_rx_sc_stats,
 	.mdo_get_rx_sa_stats = nxp_c45_mdo_get_rx_sa_stats,
+	.mdo_insert_tx_tag = nxp_c45_mdo_insert_tx_tag,
+	.needed_headroom = TJA11XX_TLV_TX_NEEDED_HEADROOM,
+	.needed_tailroom = TJA11XX_TLV_NEEDED_TAILROOM,
 };
 
 int nxp_c45_macsec_config_init(struct phy_device *phydev)
@@ -1583,6 +1619,11 @@ int nxp_c45_macsec_config_init(struct phy_device *phydev)
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


