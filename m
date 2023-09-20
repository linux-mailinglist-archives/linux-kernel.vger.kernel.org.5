Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8857A773C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbjITJXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbjITJXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:23:41 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C514B11C;
        Wed, 20 Sep 2023 02:23:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3G/01q+QCCOieInhbJyA18/B/G7iCMTwwb9IDpAaa24J6/p8TChqM3neXwXp+F0BYuLH1E05v5UiJ0vN9wrDOnwiuuh0sLAfRUiF3X1lxxVk8qsYXD9K0ROmN6vUVx69QDQay+XcpTjmDZgJ+rgMrLGcJqfnfMjdaVooK4amn2yC2sHBht+RYDChSdkrRiUpJvhROFxYxie4eWyFlObq5hEIep7KNErX3FXciflplnPeqJsw4PCyfhw44vpGz1UrPM7RpoEY7xMhKAWCKjm8GRjV8b4rniVW+i3xGibsoTMmQ3gkLTxEj5MykDcuqi70VKG3hwE1UUkSV0x0aqCDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nOcHZ3erTtpxgSdF8DVKMxiY/4NZiSMZwmBsJxmlvI=;
 b=Ygo8sSMDCl2XnGgPUGwN45LE/0vl0rgwNZ2SIB0y7etTkgnmB1ADERxuh8BsrJmkoCjICrOd1NP5yHUsYDliXI0AvY2/3ZB+SotL6PaSkT/CMvZ1oXkyUmcgDb7XBEIL9pK/EfmTXlkFWvnooIGucFzxivpBzXtwdIMN4OwxuYFF5HXqq2fVrqB5AxtivS2u8Zn1looZTYt7rJf4pDbHgesf57YrVURDl/uaYFgPYAtBxEVi0IuuuZ9Xt2YwSmNYWsYLq3DUZYSmqyhzKFmnJkMZvWyLGPNsgkKMP6zLNnk528/yQQwRlgQvQ9imyx5hHM6gIWTZen3DnITbJFhTnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nOcHZ3erTtpxgSdF8DVKMxiY/4NZiSMZwmBsJxmlvI=;
 b=Xj6OePrLDshOBBo0+c15i+R0rnnmmmorjkh4m6RkkCYtORXvRLpfPxR3F0KaLNDw+7nuk6xq4Nrpwb/eV1+L1Eamt9xJGECvOIA1B4i8iCGOMSqniMicuWV4Pi1D7oQPAR8AUCdf8hqtQ6tHyaclGvL+Z5kip/PXwZrb5nIqDLY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM7PR04MB6933.eurprd04.prod.outlook.com (2603:10a6:20b:10d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Wed, 20 Sep
 2023 09:23:03 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 09:23:03 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@oss.nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v5 6/7] net: phy: nxp-c45-tja11xx: add MACsec statistics
Date:   Wed, 20 Sep 2023 12:22:36 +0300
Message-Id: <20230920092237.121033-7-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 36bbc336-d46d-4ecc-c88f-08dbb9bb30c4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bXVFTCMGBm1XaUf0Kk80I2aFdzlni0QDbD8Mhg0hdFV7f8w78a8BkoLqLQg083Jx07P/4ei4mKuhoGHkdLGgrj6V93xz5jNSeh9BTJ3gH1kgJv0vxqH/9Jrb6541Ce95dviIvPrenjeDGWtbvpvuf9qISxkEOc/+ZgnsQV4peK445fKsIajFdnXXfwyZUBVKcajYYUE3pL3p/hDtjh9r26mb+F7FcLQ2N1x1CCTHrrXx0xrydyjNpQ2jugMMXymQn0S+OVEDmYRodi6FUFzHPp8F+5bRzT7mJl78DrvmtsN1+sgN16/j+Ly9BBNqnWgEAebPakRcMTVxWvz/x1GNUYMOTNfzhFjOPTxjaADKVzEbvWeQeaTfQOFLjYNPGraQfBJUTbI7vRnBF8y5tFJeL/wWZwnegakDIDnV3DtTcOXoc8WlTYtDwNpTvl00oBnlJ7Juoj31y79VFwflZlv6JAtcLzeNopQ/8HvrF+G0COeCGnRKjuHafPLjveddyOHkY/LbbSkbZ4AWQmBPZtDPFupOa7JBVts7Ghab/d/DF4wriRLF1vtbaMV8iW4P6CrgFazNQ7Vk53j9zroRdPwuCI66hj7fbCC5BLlMMROfiV4L65Fja/dDVsQa5kHDWDdw19Afz5VCRnOgNVRXnCbM2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199024)(1800799009)(186009)(316002)(41300700001)(8676002)(4326008)(66476007)(8936002)(1076003)(6512007)(83380400001)(38350700002)(6486002)(6506007)(26005)(52116002)(2616005)(6666004)(86362001)(38100700002)(478600001)(921005)(66556008)(66946007)(6636002)(2906002)(5660300002)(7416002)(30864003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+NhME1JhO/z8lgGS8mpxbMjLQiHOsnbZ70NPcrJZkU1zVkPaFLMJgMLOPL9B?=
 =?us-ascii?Q?ZQLvfWakUM5BwGE5t8jC2mnBc5O78jQI55na/8U6pxiBBnYOZLEeXRBhQ3lX?=
 =?us-ascii?Q?y/v3ALHm5V1RphU72ay2KYuMZxlFzgIviyNRoQsfxqHXFCkt2T9Z6RLVSzjc?=
 =?us-ascii?Q?F17NoxocOrbddimyA7XpwPkMAUrkZE9bypt3ZjJPhr3LlDhr+WnBwLLDpdhv?=
 =?us-ascii?Q?ev+dJsk2C0bV5mTvJoyb5jaE1jVrFeDHi6LB4UtB35EA83OsINR264z73kn/?=
 =?us-ascii?Q?pEezLrIpfuGeT0jde6vjYIwuoo8ix/39xPstMaKpSqWyBA/BiKoFSYggnLs+?=
 =?us-ascii?Q?YrE+ZhKSBjxPkc1a3KyTYliyF0k5Mbnt2Ma5YAxVtZ6bmUi2tpeHuBBFBwRj?=
 =?us-ascii?Q?tp4WzWgqStVoSxmfEthXhwNFKAp1LKmHLooYGlIH5fqfxRIMvnnk1d08m2cc?=
 =?us-ascii?Q?Q6ZxDp115ErkqppVwYwuTMo+3SEicGUhixon84t3NvewGoazDedNLGQgxLvj?=
 =?us-ascii?Q?E+mpPvVQmpX2mHxqmRPor5GJIjDeNKIUChX0t2alBNgGGAgCciOi/ZFwvvHh?=
 =?us-ascii?Q?d3Xr4m0DnGSy8PAoLFDGgd6Lqq9kzphOvnEp2msXz6OacImuidGGUtc6xSLG?=
 =?us-ascii?Q?xYiBhLqGlFE2gHSyUHyVkjmb6eD9u+43R2tPdzakS0PX2eZByN6/UdR6P7Q0?=
 =?us-ascii?Q?F0PHCWX87cCaKFHfTrIceN80F2dp74lxfsS1l+ZD/MRnFstqlveQzZ+eU5VG?=
 =?us-ascii?Q?BNhc4VaOZsEgE+8DlReMxdcAEkavJOYExBqoGOJJWnxCgGaiBXYFLMjiLqtN?=
 =?us-ascii?Q?j3gCbVi3O5vTIPJu0QeMeIZS2qwocej5e+L7jF1Ld4va57ts3Ls6egC9TD3z?=
 =?us-ascii?Q?UDTHXDtsbVYPR9P2ZGw4KqsEk+s3OxGEw6GBVCIhI5jnk0EgalT92ZaN34Rz?=
 =?us-ascii?Q?sN0ZrR0aLFmhlOdOL1zZd1Mn2I06HT+5vTX2uP7324vw8AremTSStHVXRGTG?=
 =?us-ascii?Q?dquCh4z1COZvT3xMoSCN8yfu0jjyLOwNRNZWAVfNk31MXRRg7wdJy9g4y67A?=
 =?us-ascii?Q?AYv0Vim+Jmiym33lcZfvXIBvcWDIaR0fqUt4X1W5Klt7b8aI9G4Dw1bxpdxV?=
 =?us-ascii?Q?9nZb31/LHHvAaGmAFHWXkIraKvL8JdbuL27RAtEV0ldG/x4wxsEoCkeUIKT8?=
 =?us-ascii?Q?AI6PnRbY/7FtOAQ5KDbRYsw4MI1EkcUK/jxOwnS/fSd6T/ftQ14U3GUDrFYh?=
 =?us-ascii?Q?jBs378veXiAd38zGBUoexoslKdwMT7E53jjHjlNOu+apEbgv6wTH03dPiE4+?=
 =?us-ascii?Q?C1WxA4Lt8KkYRqIFBzMcZaBG7WHVxfbdDvq+wxU2x8p14MnLVf008ZkdlRYt?=
 =?us-ascii?Q?1K/ioZ47nJ2NGld7CADfeenxDc38w/4U2BjAJQEzT1KCEWvPMz5eo7PIY6Hh?=
 =?us-ascii?Q?AT8Y5E8oobe2zI6c1vlmImt2w8UYpcxwiM0j0EeRPTQM24MeuGFudczMCgyS?=
 =?us-ascii?Q?bZEaqNmfIGftEoF0Mrh+j7g8w/alYIvRvLmf20ftoCjmeFk1zLP6+W0QKqfP?=
 =?us-ascii?Q?JiIEorSM4aIvqs/uwQKzcNf3nU54ZdaJXyMXMDPrrE/asb6qQMYij5DNNsF2?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36bbc336-d46d-4ecc-c88f-08dbb9bb30c4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 09:23:03.2743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jT7CO9AQ8tINThEXJJval/a2rpFQUI2rm7dYyp9M7YdH6/osmjoBjiy+m8TWzntx1igFlD0FgOkP3ffDZL/TslnV0mwdKevG9Vp8pIuuPA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6933
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v5:
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

