Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476937D2EC8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbjJWJo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbjJWJoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:44:02 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2040.outbound.protection.outlook.com [40.107.15.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2446AFC;
        Mon, 23 Oct 2023 02:43:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUfqbqrVgtU32twVH9Lhc2FRhoQ402fDDtRgO1A2+FgiEBWMJT5to9khA2E71frtQIEDsKyhK2iad15TMJkJ68z/WnCvlZTKB4RgjnhXk7Lzm4Ueb+Ge+o8R7wY+VWW3F4CZ9KP4pFMBNrN4/qrNDVqoOuGk6Vu3bBDxapoSzu9HtvcWn5sTPBtYkXqiVGT3c1YKPfMKix+4NhYbIVWKXSEppAxY7Nln27AXKUEUCW1Kwq342NAfVMbDD103CHNIYZyKFFHK1JYRdYwiveNfL8Q/Z9+Qby/ywY7Mbg5MSIZO3fPKXwxGPnjJplkdL/v2X4v8PMi2YSGjPjmS/LK1TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eToqvjiNd3NOCUOxmeYpv8/1767N6tWWMjHZjG6NL/s=;
 b=WpdyZ12qGu76LcqfktMcEskQwGBaHw3i42yWewP/wOyR6EKUhi0NFxOOW4mr9a519DgA/ycr4sDlshpdYwKpVf+JFnYsTJ6zEMnB4vxng6KXO9nDgRZ/qCtUjVbOosA9iJG2cj3s2aVWGuy5X7j7JBj4tTf7TCJavGkHcTdIPR+ggp0tv1pA/50kE3GnrPXwJP6Pn6F8ThJK/51pYXcfwgjKwSRy9vy7veZdaRCRCJctoHiGXSuqGNe72kwpDzqYGDb+c+pMvkibdLAlgscyqr3CqyqrDt45HOeEllXD16n2lGOhB2FGO1YOr4Zck46OuzsGkYszOTXKt/pHza9TVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eToqvjiNd3NOCUOxmeYpv8/1767N6tWWMjHZjG6NL/s=;
 b=UMvapyjH/KUNhqU2YOTTpWNe7CmdsvE5N7sneF5AUJfHpKXv/ZSxD/xhABkvJ5qI6cZ8E1AhhH2eJJ6xaa87PqJhYhTkKmaqVIK7QiW52jf9/FIQ73pjCu8yTryqRnvddsfC87JRurES6ykgcxPjIT4auLqJntdGOBItKdw+iAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DB9PR04MB10011.eurprd04.prod.outlook.com (2603:10a6:10:4c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.22; Mon, 23 Oct
 2023 09:43:53 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::b1fa:fd23:8cc2:f5ee]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::b1fa:fd23:8cc2:f5ee%6]) with mapi id 15.20.6933.011; Mon, 23 Oct 2023
 09:43:53 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sebastian.tobuschat@oss.nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v8 6/7] net: phy: nxp-c45-tja11xx: add MACsec statistics
Date:   Mon, 23 Oct 2023 12:43:26 +0300
Message-Id: <20231023094327.565297-7-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023094327.565297-1-radu-nicolae.pirea@oss.nxp.com>
References: <20231023094327.565297-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0079.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::32) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|DB9PR04MB10011:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f9dabb-ddbc-4a24-8d9f-08dbd3ac916d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05XKlqwAcrdocXgU9QhBH1SQiNgjFnYChAFjmX2DDMONlX29kmD8chj1FKrqj9KafsAL1jR7Rmt484LlaSuJ/xnTFhRBncgn35ylotbiIMK6RMHeuslermaXJ3KpuSkMVUTB8nspG2UgnSG8NTosyb4E8+SMXJngQRXPv47Sgq5baDr+G4CsTJ3B9WXOxW0hcEajVknEiJaP4YnAl08IZLYHn6fZdAtTuFIY/tvd8yimCMiSEGMVArAmKFq5/dRq8y79kJik/URsiOfi+NTpx8ZaL1r5LfOih1bgX76YypTSu3L5vcJERLqqF2W8xFv7T+35opE0wJZXQrtSk+1chYWKDeCgyu6Uy+eet9H8vvfn99PC1057nd31+DHirc8u99wnPVYUJxnXfTGwM3F6ZCU+MLlUtKvilmMJe5v2QPS/pixc9AN9j8CjOUujxfwg42fVu+uF7jGzRermYd1pxQuyqnqD5oTJvab1VSrWhQTASpx3Z2c8MB7gpCL7y80q79TCbQOWAMBssqMixS1I0ezpabbEQBpKexsV3XA/pnC07NrrEsBJudAUZVGeMsAGq8o3P9iNLY6u1WW7H6Ogu8wAEUpsfZo2Wx07wcRy75ugAZjBwVJg6GM5qxnvlllv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(38350700005)(6512007)(1076003)(2616005)(52116002)(26005)(83380400001)(6506007)(8936002)(6666004)(6486002)(478600001)(41300700001)(38100700002)(5660300002)(86362001)(8676002)(30864003)(4326008)(2906002)(66556008)(316002)(66476007)(7416002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NAnIDiP2Qw8GpJrIzrp4A6esVUnqoQMXjKb6wOota2lVeZlWdy7jpo9ooAsg?=
 =?us-ascii?Q?njyBEPMB3/FzVamED08cj1m9c5MaDYfbkAfsu/HE8f2FzBavFw7J6KwwQx1A?=
 =?us-ascii?Q?fAOOexZDf3NLEBeOVF6fBt9gpUecaetioybry75ILTtOCeebRhtIGQo37AWJ?=
 =?us-ascii?Q?dtOMke5W3bzR6JLohk1YvZ2QOe9SBVaRQ6IdgHzilQErUoSojYjp1jgspSFB?=
 =?us-ascii?Q?F8Ct1VBASeb5O5sLc0w6SL2Nq4PbGYNnSFIX++SDXysFL3LaGLGpyZbAe0pw?=
 =?us-ascii?Q?oU01nUmqhgnhVeXcs2gRPU6BGKPpwYbrmXy+LBDRDx7UhK2xbqY8TVmQqg7r?=
 =?us-ascii?Q?PdBRLNXv++xthNJ3up3Ka7q/dp/Thpg4kxx/4qYXvE7S9QY/gDOi4R2cfdx5?=
 =?us-ascii?Q?tr8fKg8PmT6+0VQtEScvl10H0a2KNoNXMPVLuTSTGgx85sl0Fq/yidEjrG8E?=
 =?us-ascii?Q?liM9UkZqsMR5RFFComk1Jw06kNgyUGfSYmmw6I3zhD1GdREPpnC2OHvskVK3?=
 =?us-ascii?Q?FpQR3IGi+PbXdjanFW1dJ5zN1cEIhMeHGkfYMhdcRwW8wkrDcRqAbB/e9jT5?=
 =?us-ascii?Q?nGaJPt6GC/YiQufFPjOefC5kOw4v4deaKuH0CeKzSU17H2WLjwCyd7DkaNCU?=
 =?us-ascii?Q?WmvSFgNvgbTtRbFM6AeCdxzaE43bDdOskhCdO6i7yeXblhTzsUS50jXCz/PF?=
 =?us-ascii?Q?FuiHd3Ct2kf0U0msgqPzPtR/xN2pD29v8ipO9lnxsZ6gfPFqrzz1LjRjwIOM?=
 =?us-ascii?Q?SMIMy+zvZJj/vPjOHWRyFaVa1uMukn6A3OUgjDF3v5su0wwnX7sRnm9MDoVb?=
 =?us-ascii?Q?96XLPXy24LXo9eZ3kpjC2aIFz2UA+VbJi33StzS0Q396eXoFF2DhYBQQ5RBf?=
 =?us-ascii?Q?L+GsqDDTpSKb3/0D6cp65omeoMKt61/9V2mYDIRPOsKVppSR1Y4+3AG1Wo+Q?=
 =?us-ascii?Q?gX4Qmipl5/y2wFL+VhhH0ghOgtscvA9LGYqbStPGRGunBvWPzamnCaYnsrJK?=
 =?us-ascii?Q?wX7IR5jP9zDu0OKncvnOOCACmofr5wJJgsmJY65LpZCu3YkSavVH4TKiIbOK?=
 =?us-ascii?Q?HO1HzKJvz05BzF3FLFATramtz1Vf+1dCUOmd5NfAgz2fzKGLTln3aEI6MHTD?=
 =?us-ascii?Q?8SKBaZGZ5mJ7fmSX6ivgieulq+umBHyDJLvmfJXUfP9cOaCl4c2vuuIQNUQz?=
 =?us-ascii?Q?IST33FqkQ9xprDhLBIV2badwghq4UXan1bWtZX4RrIC6jQYKCUGSdVWb+whs?=
 =?us-ascii?Q?EB3NUcJFLXr03huLuLTnnhgzt3sspBrfHLUqYsd/ur9U6QhzlajXSyJlp2aL?=
 =?us-ascii?Q?h4uu2aC00PNNiwKExr11GNJAQBHn40dYBtYFl6d97XRm0e2CaA0BbO76V3hv?=
 =?us-ascii?Q?LL1R+R5Hjqm3nuTqrZSC8rK3R/P6Pm3lFQ63GSB2yaqZlty9ucZvfI0C9cYp?=
 =?us-ascii?Q?32CHZCQN6NmkExvOlh4xgrbamMvxBGn10f0g/Xh1twteQC+SxD8Ch/ll2XzA?=
 =?us-ascii?Q?MnBnihmvSbecnJ6vSlfpDlx7VujcTPS89lVLtik8S++mh6OZtLGPDGaIFDci?=
 =?us-ascii?Q?cydg4DQsqa3hGUVTXs+A+7JgipGtsFlYDMRkHNDjikim+2As2VKI8r5kKfdy?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f9dabb-ddbc-4a24-8d9f-08dbd3ac916d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 09:43:53.2102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bn6N61AewYsWpp/cdPuEOfzvzkoMvrRWxDGe4ZjRnB7nDJnc+4wubSudjdZykIRNuP0wlmsFnSe/2dVl0yajzjM+ny9TvySk8PmFczV/S4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10011
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MACsec statistics callbacks.
The statistic registers must be set to 0 if the SC/SA is
deleted to read relevant values next time when the SC/SA is used.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v5-v8:
- none

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
index 821f8926f7f2..4dd10ea6e06c 100644
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
 static void nxp_c45_secy_irq_en(struct phy_device *phydev,
 				struct nxp_c45_secy *phy_secy, bool en)
 {
@@ -432,6 +496,41 @@ static void nxp_c45_sa_set_key(struct macsec_context *ctx,
 	nxp_c45_macsec_write(phydev, sa_regs->cs, MACSEC_SA_CS_A);
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
@@ -646,6 +745,23 @@ static void nxp_c45_tx_sc_update(struct phy_device *phydev,
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
@@ -735,6 +851,32 @@ static void nxp_c45_rx_sc_update(struct phy_device *phydev,
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
@@ -744,11 +886,20 @@ static void nxp_c45_rx_sc_del(struct phy_device *phydev,
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
@@ -939,6 +1090,7 @@ static int nxp_c45_mdo_del_secy(struct macsec_context *ctx)
 	nxp_c45_mdo_dev_stop(ctx);
 	nxp_c45_tx_sa_next(phy_secy, &next_sa, encoding_sa);
 	nxp_c45_tx_sa_update(phydev, &next_sa, false);
+	nxp_c45_tx_sc_clear_stats(phydev, phy_secy);
 	if (phy_secy->rx_sc)
 		nxp_c45_rx_sc_del(phydev, phy_secy);
 
@@ -949,6 +1101,9 @@ static int nxp_c45_mdo_del_secy(struct macsec_context *ctx)
 	clear_bit(phy_secy->secy_id, priv->macsec->tx_sc_bitmap);
 	nxp_c45_secy_free(phy_secy);
 
+	if (list_empty(&priv->macsec->secy_list))
+		nxp_c45_clear_global_stats(phydev);
+
 	return 0;
 }
 
@@ -1106,6 +1261,7 @@ static int nxp_c45_mdo_del_rxsa(struct macsec_context *ctx)
 
 	nxp_c45_select_secy(phydev, phy_secy->secy_id);
 	nxp_c45_rx_sa_update(phydev, sa, false);
+	nxp_c45_rx_sa_clear_stats(phydev, sa);
 
 	nxp_c45_sa_free(sa);
 
@@ -1195,12 +1351,196 @@ static int nxp_c45_mdo_del_txsa(struct macsec_context *ctx)
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
@@ -1216,6 +1556,11 @@ static const struct macsec_ops nxp_c45_macsec_ops = {
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

