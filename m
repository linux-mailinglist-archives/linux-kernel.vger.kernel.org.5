Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01F779E955
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbjIMNcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239451AbjIMNcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:32:35 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2048.outbound.protection.outlook.com [40.107.8.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3635219B9;
        Wed, 13 Sep 2023 06:32:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHkPcgadNKiG1iKmN+qj7Bjo3FZTUtT9jbi+741peqnfk2E9V9y3cyl4ByN8AHByCY8H1qIleHRHl6AbrVAVrCSm5y2Zdmsgcy7talPMGTYPvTthnbOudI1IDmtLHOjgOtXj5eMa8f5MwU7RBos4M929xRzDQHaAn520KT5qAxI1H7xgCqWCFMPfKFNBGrLNHlcxCgb9Kg3GX7O2EmNrOTLI/Gz4BMFk6Li2cyMhM03GHgtxpbkLjcFkl0/b1HGInutuvzPY3a+TD08KuZU9pqvasNp9JJ5i+J6HFqQq9+uDhiAZRAjs6gboAdgLrJu6dImqRxUojQ/lsQFOzcX8ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbgymYEpTtC8zKQCAf8DDtL5vzg6aPd13SnHTxF7AvU=;
 b=GalCGTL7I9FrEG2W9DtWDbGRdhd11zKxZ+HRBqjuby0zMi+tgSeUB4pI5ImFWLPe3z2CfrDhby5RiCI1dsv5t+J4qcct4rXFcWe4zsalJQ/jRJc2RKLCGN8Fww4v6v+BgwKImDIr3KiENXLVCDTXCVUqPkNuGWwOhi6gkrNZ+LyWyzznct0WiuRY3gR9IUcHVe1pzhoVD+qMFO5TTpU2D30J1mA6ZvoV45qHgIPWi5969uNY2Q4J2JBN17O5PcvA0JwlSl4igjJB0RqGg8prFr5DTonJE+Ff4eqApdc1oa54IdzmtUHdtDUWOyuw+HBUGULlXxq4hMn3Abq/oBGqig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbgymYEpTtC8zKQCAf8DDtL5vzg6aPd13SnHTxF7AvU=;
 b=Di3hZqNINbKtWkqje1en+NE9gOsEqmyDOL8EHn+J1GvrgZVIs8YJX08KO4G6ZZSfowWUdkLXb0Qz09qr7pmZfScQZn/IyiWPJHtPwvyv0imI2XZhPSAv5M68yrCfTxKu5ZfVCaEbshjznAXSRwZpX9ERkta7Ac07iDFCdDqcWb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM8PR04MB7235.eurprd04.prod.outlook.com (2603:10a6:20b:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 13:32:28 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 13:32:28 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [RFC net-next v4 6/7] net: phy: nxp-c45-tja11xx: add MACsec statistics
Date:   Wed, 13 Sep 2023 16:32:04 +0300
Message-Id: <20230913133205.3749628-7-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8ed69464-8085-45e6-ff61-08dbb45ddfaf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 47Oy1obMFHYvUSKDJSMiskueg0qSP+2k+sR2vMATZA8G2bQ/YYS2gQzzS4NpOGpLLnb2KF3qcKXl2eyJ0tZFPpn9ZRXM/GYrKW2iJ/FjymIevlUzabCcWk98jUcun8Er5dEJkW7x9lIg+JDqn0WllGEQp5pJSE3vx3GURQJVYFqVFu57iUqGmykQuUhTM7bwWD3Hyr50T5AlmpIuaIet3son2+iaThDY9omW7x39LtunV9lOIX6of5NNWuREwmr5QUpPWhmeNJa6rTC72d98Ijeanj4f+rmTx8xc5oVrx8OAO7krrBgUskd5oxczSKV2HhLAnpr+WYrghEWAAg+NQm3NreJUiVZh2YSQdPyZCeiALeWgyrzyTp8e5EFJHkvR7eGpkD9b4tOFUQH+BJ+7pjOlbFvGRYVC9/W8NHM4zAXwF1/d0Xe9CATtjrhpWbGg76f6NGI08+CetcxLoe9ncB1ahLRxsAEP5EsrHFyrO6YsnsScNY2WAeiyBcYgAph9pIGZyLTIn9HlkKmw3/0OpGT2pyhFciN1rgQgv+JnfHe9UmnzA4XhtdouEC+fI6fWg3MIvSWkcaoRY4ie3SuLady44vGWHUBBhWg2yTpYpKMSDrSY3yf1alWTNqTdd+pSVdOE5gvGhGH/VPBRIcmsXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(136003)(366004)(186009)(451199024)(1800799009)(26005)(4326008)(8936002)(8676002)(52116002)(6666004)(1076003)(38100700002)(921005)(2616005)(478600001)(83380400001)(5660300002)(66476007)(66556008)(66946007)(41300700001)(6506007)(6486002)(316002)(6512007)(7416002)(30864003)(2906002)(86362001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g9JV/z8ztAH0mNqXtTyW9XBTxBtPZsoaatdhB3cQwvCijTybjH04zpgpHNxs?=
 =?us-ascii?Q?zb714hWfS3SyHnJO9AU+KWGPttXypTNiz32oUAGdwAESJ/ocWUW19oG9Aba8?=
 =?us-ascii?Q?Xala0JlXFoCAbHWyUM2N5aWcgqbsjlaldbwid7yxDG+qNo7CBANsn0Na8Unf?=
 =?us-ascii?Q?71GJKqy8rzKqwbcEtu46a9aGlVE0amRcSVj7ZG4297IVLCcI32VG3IcqS8jv?=
 =?us-ascii?Q?BsjsbcCt1SZqlojkopSCiyyDSElLMNTE9arf8TbEEUt/5bDpJ1KHjaLNYez2?=
 =?us-ascii?Q?/FILn+1SPr4t4f1FI2iUK8OF3JjfJ0BaSNFlidSNu3fORnyVo8F9Pm5EUuET?=
 =?us-ascii?Q?gEJ/I100b9e2kjzHhL7gaBoyufsTDn4FFGehwfibJ2DTwjJ2HX21fZGvHDOc?=
 =?us-ascii?Q?jQtXteIBopFJXWYqSghZLevR57TgPcKFh8MRE1yto+bxnToZMVTlN38VzfQn?=
 =?us-ascii?Q?NB+E+vgkZjy4xjPY3LwzazdslgmjDTinfcdviZtRn7FqgPJ58h7pahewFOlW?=
 =?us-ascii?Q?dE8v6oEDwzNulagbeS6g9y5i144YoULHzpcMKoVQaMAzAlmuKTi7TdxI+1YD?=
 =?us-ascii?Q?Ro3AyZDwYyB41siJ9mFsJRsVDVb58jInLpjxjhy1W+8teIwCiZLUY+KGFSHp?=
 =?us-ascii?Q?WkJfT+oHr77AqM2URQs3eRfecyLG13btLpxfDFAB9fh7a8b9XAX7U6AdiG+E?=
 =?us-ascii?Q?2EBOGr8h6SvzJpHGESdt7Vv7wnxpZ8GK8smLso9tCnGXwAVUpCb1sVtB61Uk?=
 =?us-ascii?Q?Ydm8mCwnFWeCTOrqoelBfl19F7er7UhqGgOAzDXQUMqrzao1kgccwlsJujf1?=
 =?us-ascii?Q?c/jbxYLSqCvxFnzmlwMVgh9jmplxRgYSSv5zI4pQVLoyYAvVzm5R7uEEagLo?=
 =?us-ascii?Q?unFPikawR/sBhGwZjIIIlmMrVRne+O4LzcEiZ7M8YovbxkqJWOc0zJfebIEi?=
 =?us-ascii?Q?tL0mL7iq7bkbAdKNxR/LvCtIjoSF1wZS8wCEMQ2J6fugXaaYXpItfB0N9Fq/?=
 =?us-ascii?Q?WVe8UPPcL8cR+1kyCo1n0jJy4rPtF/fujc5rYIiu5/EeHdtFfXLfHLYjBjuM?=
 =?us-ascii?Q?pbdo7IaCQS3KVVtxhGJ8iqipHYRyn3cMTb1WK6Cwwc8sGNo7qgt490XPUHI7?=
 =?us-ascii?Q?woT+tZRGtp/iiRB6nQEvAn69zZaP1j20lZJiBbjIYkJTcRWWFVhOqtY7vvmy?=
 =?us-ascii?Q?zyt7332XhAos7OkNAh49kqY1lp9WK2732NJF6+pdvwXCDMtXTwPcTOXW+oz8?=
 =?us-ascii?Q?99uTW86OiFck9tEu5xsKMzpZT7WvheQ5KY1/7V5YNvUF5732kUlV37Co5IQk?=
 =?us-ascii?Q?pTVeyovLb11Cwhvxi8NHemje0jzcj/hvQJ7rS7/oFwUBjUhf/M0lfylTY7Np?=
 =?us-ascii?Q?Xoc9TmsoMtrcAMiPNfn/YJBd8OE1NdgTowKE4AglC8IhRgzBoz9HEIdMBpEF?=
 =?us-ascii?Q?iBfUquYVE2aq4BBrYqvvVn686M6lHSLVnZVHItSDDiW2qYWDeRDj74pqiamu?=
 =?us-ascii?Q?FSC3fzQVbAx7TZIsvuIAWPpzWYRMXPMA2Z+HzogoN3VibT5c/ueSA4TerDJH?=
 =?us-ascii?Q?9oIAo5bPhOpeEG5P3lz9i5JgpBQQgUffLJhTyEn6XnlSBFbKI4nSTJCec7JD?=
 =?us-ascii?Q?Iw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ed69464-8085-45e6-ff61-08dbb45ddfaf
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 13:32:28.3177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6Ng3hgyfqGl0WZm9Myw2Mti2DWjXqzXevpYqCfxYWuTyd6YXOYFrVew2MFFg4eySNsjAjyEfISKEEbGE5rJRs5iA0W1mVirjDXkDgtTEuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7235
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MACsec statistics callbacks.
The statistic registers must be set to 0 if the SC/SA is
deleted to read relevant values next time when the SC/SA is used.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v4:
- Added nxp_c45_macsec_read32_64 function to read 32b counters into u64
variables.
- Added nxp_c45_macsec_read64 function to read 64b counters.

Changes in v3:
- reworked the implementation around struct nxp_c45_sa
- changed the way how OutOctetsEncrypted are propagated to the userspace
- changed the way how OutOctetsProtected are propagated to the userspace
- read and clear OutOctetsProtected

Changes in v2:
- split the patch from "net: phy: nxp-c45-tja11xx: add MACsec support"

 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 345 +++++++++++++++++++++++
 1 file changed, 345 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx-macsec.c b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
index fb7f1cb62a6e..3634b6cedf24 100644
--- a/drivers/net/phy/nxp-c45-tja11xx-macsec.c
+++ b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
@@ -137,6 +137,35 @@
 #define ADAPTER_EN	BIT(6)
 #define MACSEC_EN	BIT(5)
 
+#define MACSEC_INOV1HS			0x0140
+#define MACSEC_INOV2HS			0x0144
+#define MACSEC_INOD1HS			0x0148
+#define MACSEC_INOD2HS			0x014C
+#define MACSEC_RXSCIPUS			0x0150
+#define MACSEC_RXSCIPDS			0x0154
+#define MACSEC_RXSCIPLS			0x0158
+#define MACSEC_RXAN0INUSS		0x0160
+#define MACSEC_RXAN0IPUSS		0x0170
+#define MACSEC_RXSA_A_IPOS		0x0194
+#define MACSEC_RXSA_A_IPIS		0x01B0
+#define MACSEC_RXSA_A_IPNVS		0x01B4
+#define MACSEC_RXSA_B_IPOS		0x01D4
+#define MACSEC_RXSA_B_IPIS		0x01F0
+#define MACSEC_RXSA_B_IPNVS		0x01F4
+#define MACSEC_OPUS			0x021C
+#define MACSEC_OPTLS			0x022C
+#define MACSEC_OOP1HS			0x0240
+#define MACSEC_OOP2HS			0x0244
+#define MACSEC_OOE1HS			0x0248
+#define MACSEC_OOE2HS			0x024C
+#define MACSEC_TXSA_A_OPPS		0x028C
+#define MACSEC_TXSA_A_OPES		0x0290
+#define MACSEC_TXSA_B_OPPS		0x02CC
+#define MACSEC_TXSA_B_OPES		0x02D0
+#define MACSEC_INPWTS			0x0630
+#define MACSEC_INPBTS			0x0638
+#define MACSEC_IPSNFS			0x063C
+
 enum nxp_c45_sa_type {
 	TX_SA,
 	RX_SA,
@@ -175,6 +204,11 @@ struct nxp_c45_sa_regs {
 	u16 ka;
 	u16 ssci;
 	u16 salt;
+	u16 ipis;
+	u16 ipnvs;
+	u16 ipos;
+	u16 opps;
+	u16 opes;
 };
 
 static const struct nxp_c45_sa_regs rx_sa_a_regs = {
@@ -186,6 +220,9 @@ static const struct nxp_c45_sa_regs rx_sa_a_regs = {
 	.ka	= MACSEC_RXSA_A_KA,
 	.ssci	= MACSEC_RXSA_A_SSCI,
 	.salt	= MACSEC_RXSA_A_SALT,
+	.ipis	= MACSEC_RXSA_A_IPIS,
+	.ipnvs	= MACSEC_RXSA_A_IPNVS,
+	.ipos	= MACSEC_RXSA_A_IPOS,
 };
 
 static const struct nxp_c45_sa_regs rx_sa_b_regs = {
@@ -197,6 +234,9 @@ static const struct nxp_c45_sa_regs rx_sa_b_regs = {
 	.ka	= MACSEC_RXSA_B_KA,
 	.ssci	= MACSEC_RXSA_B_SSCI,
 	.salt	= MACSEC_RXSA_B_SALT,
+	.ipis	= MACSEC_RXSA_B_IPIS,
+	.ipnvs	= MACSEC_RXSA_B_IPNVS,
+	.ipos	= MACSEC_RXSA_B_IPOS,
 };
 
 static const struct nxp_c45_sa_regs tx_sa_a_regs = {
@@ -206,6 +246,8 @@ static const struct nxp_c45_sa_regs tx_sa_a_regs = {
 	.ka	= MACSEC_TXSA_A_KA,
 	.ssci	= MACSEC_TXSA_A_SSCI,
 	.salt	= MACSEC_TXSA_A_SALT,
+	.opps	= MACSEC_TXSA_A_OPPS,
+	.opes	= MACSEC_TXSA_A_OPES,
 };
 
 static const struct nxp_c45_sa_regs tx_sa_b_regs = {
@@ -215,6 +257,8 @@ static const struct nxp_c45_sa_regs tx_sa_b_regs = {
 	.ka	= MACSEC_TXSA_B_KA,
 	.ssci	= MACSEC_TXSA_B_SSCI,
 	.salt	= MACSEC_TXSA_B_SALT,
+	.opps	= MACSEC_TXSA_B_OPPS,
+	.opes	= MACSEC_TXSA_B_OPES,
 };
 
 static const
@@ -284,6 +328,26 @@ static int nxp_c45_macsec_read(struct phy_device *phydev, u16 addr, u32 *value)
 	return 0;
 }
 
+static void nxp_c45_macsec_read32_64(struct phy_device *phydev, u16 addr,
+				     u64 *value)
+{
+	u32 lvalue;
+
+	nxp_c45_macsec_read(phydev, addr, &lvalue);
+	*value = lvalue;
+}
+
+static void nxp_c45_macsec_read64(struct phy_device *phydev, u16 addr,
+				  u64 *value)
+{
+	u32 lvalue;
+
+	nxp_c45_macsec_read(phydev, addr, &lvalue);
+	*value = (u64)lvalue << 32;
+	nxp_c45_macsec_read(phydev, addr + 4, &lvalue);
+	*value |= lvalue;
+}
+
 static struct nxp_c45_secy *nxp_c45_find_secy(struct list_head *secy_list,
 					      sci_t sci)
 {
@@ -419,6 +483,41 @@ static void nxp_c45_sa_set_key(struct macsec_context *ctx,
 	nxp_c45_macsec_write(ctx->phydev, sa_regs->cs, MACSEC_SA_CS_A);
 }
 
+static void nxp_c45_rx_sa_clear_stats(struct phy_device *phydev,
+				      struct nxp_c45_sa *sa)
+{
+	nxp_c45_macsec_write(phydev, sa->regs->ipis, 0);
+	nxp_c45_macsec_write(phydev, sa->regs->ipnvs, 0);
+	nxp_c45_macsec_write(phydev, sa->regs->ipos, 0);
+
+	nxp_c45_macsec_write(phydev, MACSEC_RXAN0INUSS + sa->an * 4, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_RXAN0IPUSS + sa->an * 4, 0);
+}
+
+static void nxp_c45_rx_sa_read_stats(struct phy_device *phydev,
+				     struct nxp_c45_sa *sa,
+				     struct macsec_rx_sa_stats *stats)
+{
+	nxp_c45_macsec_read(phydev, sa->regs->ipis, &stats->InPktsInvalid);
+	nxp_c45_macsec_read(phydev, sa->regs->ipnvs, &stats->InPktsNotValid);
+	nxp_c45_macsec_read(phydev, sa->regs->ipos, &stats->InPktsOK);
+}
+
+static void nxp_c45_tx_sa_clear_stats(struct phy_device *phydev,
+				      struct nxp_c45_sa *sa)
+{
+	nxp_c45_macsec_write(phydev, sa->regs->opps, 0);
+	nxp_c45_macsec_write(phydev, sa->regs->opes, 0);
+}
+
+static void nxp_c45_tx_sa_read_stats(struct phy_device *phydev,
+				     struct nxp_c45_sa *sa,
+				     struct macsec_tx_sa_stats *stats)
+{
+	nxp_c45_macsec_read(phydev, sa->regs->opps, &stats->OutPktsProtected);
+	nxp_c45_macsec_read(phydev, sa->regs->opes, &stats->OutPktsEncrypted);
+}
+
 static void nxp_c45_rx_sa_update(struct phy_device *phydev,
 				 struct nxp_c45_sa *sa, bool en)
 {
@@ -633,6 +732,23 @@ static void nxp_c45_tx_sc_update(struct phy_device *phydev,
 	nxp_c45_macsec_write(phydev, MACSEC_TXSC_CFG, cfg);
 }
 
+static void nxp_c45_tx_sc_clear_stats(struct phy_device *phydev,
+				      struct nxp_c45_secy *phy_secy)
+{
+	struct nxp_c45_sa *pos, *tmp;
+
+	list_for_each_entry_safe(pos, tmp, &phy_secy->sa_list, list)
+		if (pos->type == TX_SA)
+			nxp_c45_tx_sa_clear_stats(phydev, pos);
+
+	nxp_c45_macsec_write(phydev, MACSEC_OPUS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_OPTLS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_OOP1HS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_OOP2HS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_OOE1HS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_OOE2HS, 0);
+}
+
 static void nxp_c45_set_rx_sc0_impl(struct phy_device *phydev,
 				    bool enable)
 {
@@ -722,6 +838,32 @@ static void nxp_c45_rx_sc_update(struct phy_device *phydev,
 	nxp_c45_macsec_write(phydev, MACSEC_RXSC_CFG, cfg);
 }
 
+static void nxp_c45_rx_sc_clear_stats(struct phy_device *phydev,
+				      struct nxp_c45_secy *phy_secy)
+{
+	struct nxp_c45_sa *pos, *tmp;
+	int i;
+
+	list_for_each_entry_safe(pos, tmp, &phy_secy->sa_list, list)
+		if (pos->type == RX_SA)
+			nxp_c45_rx_sa_clear_stats(phydev, pos);
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
+	for (i = 0; i < MACSEC_NUM_AN; i++) {
+		nxp_c45_macsec_write(phydev, MACSEC_RXAN0INUSS + i * 4, 0);
+		nxp_c45_macsec_write(phydev, MACSEC_RXAN0IPUSS + i * 4, 0);
+	}
+}
+
 static void nxp_c45_rx_sc_del(struct phy_device *phydev,
 			      struct nxp_c45_secy *phy_secy)
 {
@@ -731,11 +873,20 @@ static void nxp_c45_rx_sc_del(struct phy_device *phydev,
 	nxp_c45_macsec_write(phydev, MACSEC_RPW, 0);
 	nxp_c45_set_sci(phydev, MACSEC_RXSC_SCI_1H, 0);
 
+	nxp_c45_rx_sc_clear_stats(phydev, phy_secy);
+
 	list_for_each_entry_safe(pos, tmp, &phy_secy->sa_list, list)
 		if (pos->type == RX_SA)
 			nxp_c45_rx_sa_update(phydev, pos, false);
 }
 
+static void nxp_c45_clear_global_stats(struct phy_device *phydev)
+{
+	nxp_c45_macsec_write(phydev, MACSEC_INPBTS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_INPWTS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_IPSNFS, 0);
+}
+
 static void nxp_c45_macsec_en(struct phy_device *phydev, bool en)
 {
 	u32 reg;
@@ -932,6 +1083,7 @@ static int nxp_c45_mdo_del_secy(struct macsec_context *ctx)
 	nxp_c45_mdo_dev_stop(ctx);
 	nxp_c45_tx_sa_next(phy_secy, &next_sa, encoding_sa);
 	nxp_c45_tx_sa_update(phydev, &next_sa, false);
+	nxp_c45_tx_sc_clear_stats(phydev, phy_secy);
 	if (phy_secy->rx_sc)
 		nxp_c45_rx_sc_del(phydev, phy_secy);
 
@@ -945,6 +1097,9 @@ static int nxp_c45_mdo_del_secy(struct macsec_context *ctx)
 	clear_bit(phy_secy->secy_id, priv->macsec->tx_sc_bitmap);
 	nxp_c45_secy_free(phy_secy);
 
+	if (list_empty(&priv->macsec->secy_list))
+		nxp_c45_clear_global_stats(phydev);
+
 	return 0;
 }
 
@@ -1102,6 +1257,7 @@ static int nxp_c45_mdo_del_rxsa(struct macsec_context *ctx)
 
 	nxp_c45_select_secy(phydev, phy_secy->secy_id);
 	nxp_c45_rx_sa_update(phydev, sa, false);
+	nxp_c45_rx_sa_clear_stats(phydev, sa);
 
 	nxp_c45_sa_free(sa);
 
@@ -1191,12 +1347,196 @@ static int nxp_c45_mdo_del_txsa(struct macsec_context *ctx)
 	nxp_c45_select_secy(phydev, phy_secy->secy_id);
 	if (ctx->secy->tx_sc.encoding_sa  == sa->an)
 		nxp_c45_tx_sa_update(phydev, sa, false);
+	nxp_c45_tx_sa_clear_stats(phydev, sa);
 
 	nxp_c45_sa_free(sa);
 
 	return 0;
 }
 
+static int nxp_c45_mdo_get_dev_stats(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct macsec_dev_stats  *dev_stats;
+	struct nxp_c45_secy *phy_secy;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	dev_stats = ctx->stats.dev_stats;
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	nxp_c45_macsec_read32_64(phydev, MACSEC_OPUS,
+				 &dev_stats->OutPktsUntagged);
+	nxp_c45_macsec_read32_64(phydev, MACSEC_OPTLS,
+				 &dev_stats->OutPktsTooLong);
+	nxp_c45_macsec_read32_64(phydev, MACSEC_INPBTS,
+				 &dev_stats->InPktsBadTag);
+
+	if (phy_secy->secy->validate_frames == MACSEC_VALIDATE_STRICT)
+		nxp_c45_macsec_read32_64(phydev, MACSEC_INPWTS,
+					 &dev_stats->InPktsNoTag);
+	else
+		nxp_c45_macsec_read32_64(phydev, MACSEC_INPWTS,
+					 &dev_stats->InPktsUntagged);
+
+	if (phy_secy->secy->validate_frames == MACSEC_VALIDATE_STRICT)
+		nxp_c45_macsec_read32_64(phydev, MACSEC_IPSNFS,
+					 &dev_stats->InPktsNoSCI);
+	else
+		nxp_c45_macsec_read32_64(phydev, MACSEC_IPSNFS,
+					 &dev_stats->InPktsUnknownSCI);
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
+	struct macsec_tx_sa_stats tx_sa_stats;
+	struct macsec_tx_sc_stats *stats;
+	struct nxp_c45_secy *phy_secy;
+	struct nxp_c45_sa *pos, *tmp;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	stats = ctx->stats.tx_sc_stats;
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	nxp_c45_macsec_read64(phydev, MACSEC_OOE1HS,
+			      &stats->OutOctetsEncrypted);
+	nxp_c45_macsec_read64(phydev, MACSEC_OOP1HS,
+			      &stats->OutOctetsProtected);
+	list_for_each_entry_safe(pos, tmp, &phy_secy->sa_list, list) {
+		if (pos->type != TX_SA)
+			continue;
+
+		memset(&tx_sa_stats, 0, sizeof(tx_sa_stats));
+		nxp_c45_tx_sa_read_stats(phydev, pos, &tx_sa_stats);
+
+		stats->OutPktsEncrypted += tx_sa_stats.OutPktsEncrypted;
+		stats->OutPktsProtected += tx_sa_stats.OutPktsProtected;
+	}
+
+	return 0;
+}
+
+static int nxp_c45_mdo_get_tx_sa_stats(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct macsec_tx_sa_stats *stats;
+	struct nxp_c45_secy *phy_secy;
+	u8 an = ctx->sa.assoc_num;
+	struct nxp_c45_sa *sa;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	sa = nxp_c45_find_sa(&phy_secy->sa_list, TX_SA, an);
+	if (IS_ERR(sa))
+		return PTR_ERR(sa);
+
+	stats = ctx->stats.tx_sa_stats;
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	nxp_c45_tx_sa_read_stats(phydev, sa, stats);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_get_rx_sc_stats(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct macsec_rx_sa_stats rx_sa_stats;
+	struct macsec_rx_sc_stats *stats;
+	struct nxp_c45_secy *phy_secy;
+	struct nxp_c45_sa *pos, *tmp;
+	u32 reg = 0;
+	int i;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	if (phy_secy->rx_sc != ctx->rx_sc)
+		return -EINVAL;
+
+	stats = ctx->stats.rx_sc_stats;
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	list_for_each_entry_safe(pos, tmp, &phy_secy->sa_list, list) {
+		if (pos->type != RX_SA)
+			continue;
+
+		memset(&rx_sa_stats, 0, sizeof(rx_sa_stats));
+		nxp_c45_rx_sa_read_stats(phydev, pos, &rx_sa_stats);
+
+		stats->InPktsInvalid += rx_sa_stats.InPktsInvalid;
+		stats->InPktsNotValid += rx_sa_stats.InPktsNotValid;
+		stats->InPktsOK += rx_sa_stats.InPktsOK;
+	}
+
+	for (i = 0; i < MACSEC_NUM_AN; i++) {
+		nxp_c45_macsec_read(phydev, MACSEC_RXAN0INUSS + i * 4, &reg);
+		stats->InPktsNotUsingSA += reg;
+		nxp_c45_macsec_read(phydev, MACSEC_RXAN0IPUSS + i * 4, &reg);
+		stats->InPktsUnusedSA += reg;
+	}
+
+	nxp_c45_macsec_read64(phydev, MACSEC_INOD1HS,
+			      &stats->InOctetsDecrypted);
+	nxp_c45_macsec_read64(phydev, MACSEC_INOV1HS,
+			      &stats->InOctetsValidated);
+
+	nxp_c45_macsec_read32_64(phydev, MACSEC_RXSCIPDS,
+				 &stats->InPktsDelayed);
+	nxp_c45_macsec_read32_64(phydev, MACSEC_RXSCIPLS,
+				 &stats->InPktsLate);
+	nxp_c45_macsec_read32_64(phydev, MACSEC_RXSCIPUS,
+				 &stats->InPktsUnchecked);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_get_rx_sa_stats(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct macsec_rx_sa_stats *stats;
+	struct nxp_c45_secy *phy_secy;
+	u8 an = ctx->sa.assoc_num;
+	struct nxp_c45_sa *sa;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	sa = nxp_c45_find_sa(&phy_secy->sa_list, RX_SA, an);
+	if (IS_ERR(sa))
+		return PTR_ERR(sa);
+
+	stats = ctx->stats.rx_sa_stats;
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	nxp_c45_rx_sa_read_stats(phydev, sa, stats);
+	nxp_c45_macsec_read(phydev, MACSEC_RXAN0INUSS + an * 4,
+			    &stats->InPktsNotUsingSA);
+	nxp_c45_macsec_read(phydev, MACSEC_RXAN0IPUSS + an * 4,
+			    &stats->InPktsUnusedSA);
+
+	return 0;
+}
+
 static const struct macsec_ops nxp_c45_macsec_ops = {
 	.mdo_dev_open = nxp_c45_mdo_dev_open,
 	.mdo_dev_stop = nxp_c45_mdo_dev_stop,
@@ -1212,6 +1552,11 @@ static const struct macsec_ops nxp_c45_macsec_ops = {
 	.mdo_add_txsa = nxp_c45_mdo_add_txsa,
 	.mdo_upd_txsa = nxp_c45_mdo_upd_txsa,
 	.mdo_del_txsa = nxp_c45_mdo_del_txsa,
+	.mdo_get_dev_stats = nxp_c45_mdo_get_dev_stats,
+	.mdo_get_tx_sc_stats = nxp_c45_mdo_get_tx_sc_stats,
+	.mdo_get_tx_sa_stats = nxp_c45_mdo_get_tx_sa_stats,
+	.mdo_get_rx_sc_stats = nxp_c45_mdo_get_rx_sc_stats,
+	.mdo_get_rx_sa_stats = nxp_c45_mdo_get_rx_sa_stats,
 };
 
 int nxp_c45_macsec_config_init(struct phy_device *phydev)
-- 
2.34.1

