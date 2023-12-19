Return-Path: <linux-kernel+bounces-5429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77A1818A9A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA401C217F0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F183C34CF7;
	Tue, 19 Dec 2023 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EP2OiEH7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2047.outbound.protection.outlook.com [40.107.247.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423351C6BF;
	Tue, 19 Dec 2023 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ig89zqwNmzGc5KUm2yyBit+voQl7TNL5MRqw+K/CXXRbvdc/nSioF891pCGctYSUl05jrXrxG8Em2sgYWxYh19lIHCNC4O+JYqyxsBGbSKG6DYgyf4OAXPi7S8pGSy33tzX/4IDkuEv7u+YTQpVXh2gEdY0aHvRU4vEso4lAwuZOl7yPFsXSTd33gWb3f9qvtAmaCf9UIZPOelPLEx7++SWFhc/UQP+LUQQ3TrDBfPnJaaXZX9c/6kADiPtu9WgBj3nOagcdahmERjel6spvA1+GgBXbB7aV0wjDc2XvF6VsMlOOLdNsgGK5RAvZoIXg/meVBYf1tnIbtur/8QwW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXMPmIaRJ7iiIbPyK+LpgSUBBiRmaH5Ud/PZDgBulZY=;
 b=HE6tawCelQbSi7dDKA7UFbcXpG2YJHHhPGmB4eE2B3A30hsFhpM7QtRmWY8nhXzHJ1EjVI+5r9L3O/PFPxM4gewwbtvB5E6xqaNqp485k+f6mfVSzgFJuEY4i7W1JPCZqvyiD03gikyH2Y1DTERj6hoV1XCpXFDfFc2Nn6auD5a5LfaXncLqC/pM+4CEeiKi4OZjcRvUv4grY9ialsRmxQKsXG9X7IB4yscsDvYVbG3ZEhLxoc5EACuR5npnOv1BHoe0TbKxTHy6vHukCVKTgNoyGBGFDcUNeBAaCOmmne1R1CRvnWE6GxtrOV7PBpXBDZSlwpvitBMxiVP6cnEgCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXMPmIaRJ7iiIbPyK+LpgSUBBiRmaH5Ud/PZDgBulZY=;
 b=EP2OiEH7ljDYRc7AWgtURm4rry0MVPx4r1U6PaJy2z5PwjphybifFo1uXvNsAEtImRqLO2Dgq3qrz8uUGGmgFWpq32EjUI/jtqZHk0TY+KUCoiR5Q+0w6GBmzcEGWE2LUlTl1jXXNtOEQp13VJIVWHF2Aeq2LJpos3FwRCxZgJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS8PR04MB9142.eurprd04.prod.outlook.com (2603:10a6:20b:449::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Tue, 19 Dec
 2023 14:54:31 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::d618:e9c8:189a:892c%6]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 14:54:31 +0000
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
Subject: [PATCH net-next v9 8/9] net: phy: nxp-c45-tja11xx: add MACsec statistics
Date: Tue, 19 Dec 2023 16:53:32 +0200
Message-Id: <20231219145333.240323-9-radu-nicolae.pirea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c663d66b-437c-4968-6951-08dc00a26811
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5MnF2epY4PnUoJhj3GQ2KlY6MfBGhvCH2uaVtKn1GL5QHpET+0dEqUzP0Uuu/bStMFqOB5a6FnVh2rht1cgqSF/IfIgTlDC3B2Ja3CiqnEaIX5PYXtJeRihPxJcTbZACOaDGxpBCvBAO4xo+Z/HXD30pLW9/cISwfV5qhmZPfohqQfIsTjpG5w4eOzI6OQC2t61E6C6J46A6OYeJVMRZpstoPrHNppH5W2/B856eMMgFYe/24pOhr9rynCfQeLGxb1OLUGNdL72f8pBK+zLPCF1TTNcjJskQVSjpp1EMBt7zNo7D1oWjhsQhog+AGvuBVGnmOXOaJTP1cCz0DfspM2HPVwCjTp43MURQihplz65tlUBshvRrIy/Y68X3iI3wSYrTDGBUJQwdB9pAl/nB+ml75GjqgXDfXWgHS7SNU5bvILpAclPG9KkqaNccJUuW5wNlDgtDjxcu62Lly/JzHeT2PTVIl+zeyG4fy9FDw6/0VH7ThJ6yoRImjJezQ31poVvH72lHsgpYA0lIWIiXOiBX/Y7SUpB7iRjcgXIUzuXtMrNQDecnCWjETbjPI2ilnZywevh/tkkpsOpHqhQc6jBzC/nz+Z76YNliOUPYXBVG3VelpEX8Uny5BgqewsoY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(136003)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(52116002)(2616005)(1076003)(38100700002)(83380400001)(66946007)(316002)(7416002)(5660300002)(41300700001)(30864003)(8936002)(478600001)(2906002)(66476007)(6486002)(66556008)(6506007)(6512007)(4326008)(8676002)(86362001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i+cIwmpRvi3DN9Zwxkjnmqk1/x0vG6rGpiQEBL5CCYu0yrCdeNmZRXfZjuEb?=
 =?us-ascii?Q?08HVcH7XYbswr+Rk0pVzsYbBLHlQEP8L4/GTtwDWyaNnfzzFagNC3zU/sI87?=
 =?us-ascii?Q?3N7eo6gdnz59o2a8AvwR9AgSqUK8hz2xzh97brzYddT9+LHABwx/rINuozVY?=
 =?us-ascii?Q?v4A1ViOYIb7MPHZGb6oFO9PXYQmye9n4dqeK3xrMe/EIhQRgv/AmBN3wcFGM?=
 =?us-ascii?Q?K1Y3b/oaV1tayg4LP7vhTZl+2jiQL42MHbMLKWn3ZchEFaA4GAsRJ+OvfWbr?=
 =?us-ascii?Q?Ux9gKM/4BKJRIxiaUOau1vF3NfB+JRD+8JWwmStdBU3LxttJco50XxVHEPas?=
 =?us-ascii?Q?HRKSXD23mh27jB27qEGYBp4T8K3/5h9nWbo0xZ+0NASoLszOjfMUj4Cag0Tz?=
 =?us-ascii?Q?9Trls0UXlyIsfLpf9vtfora3dC6ITaBIdzb8NeQjGMP+n5QSBHs48lFmGQWx?=
 =?us-ascii?Q?HBKFkQt303YDYA8u7BD+tRD9r/imZbxn0zrbi3f61+YVJemwNSmIuKb/THjS?=
 =?us-ascii?Q?s9mSQOIZ+IxxxpjxV2HdeCfA2ABg7fJJPcgbMQI0DrRsJuXnOUmSmx70Sdbr?=
 =?us-ascii?Q?74ZPVRI1c+qDQNBrOl5qHa1Gl1ZhoynATF2vCiGeIal0tT0XuOmtUiDuRA9h?=
 =?us-ascii?Q?fx52euMv4ii5FTJRppaX5iuFziwOzTMXVb/uFFk1BbW154+24C+qT88TyJuq?=
 =?us-ascii?Q?TBzYjU45FUbI7Ioyy6ow9M1ylM+nSZlpUHXeFBWzbILkkIiGRba8WeL15Q9/?=
 =?us-ascii?Q?tzV6cKIG14X+G7V6xfLmtHLNEdAjRMEqTp4yTJO8mXgCDoB8aDhjDMNvStTG?=
 =?us-ascii?Q?0TQMRh8JJumI0BicJQ7pZ3CQqc3eNPb55EbOgUU7WBPRlZYVtr5H6tYUMTeg?=
 =?us-ascii?Q?xJiCnopqTDlwJ76ji73W9bmPp/s+mL0eJ+gu/bO3g1JqBrys/TUbvyICcN5g?=
 =?us-ascii?Q?1J1V/0jilAedVOpfVLAufP7ayWoY34pSJJXo+WLAoAB0HC53un6fw564zxtZ?=
 =?us-ascii?Q?xp/5r6sWjDOcM6o6CMCN/3aql/Wx7DO/A/rjjOIF5ItfEiXFpTTgXTr3tT+7?=
 =?us-ascii?Q?QeC49L67vC45HZIRHNVHKXpdYzBVe7wPu04Gz9Yr06nv6v571dhJ/45q7Fca?=
 =?us-ascii?Q?JAFhhlnzNQGxu6VyLYBR+v/e+F9z8FDMT5sMcfgciXX3Zy9X/8Q9DPrCOKRs?=
 =?us-ascii?Q?sJBwkTh32mzSp4zPpNI2XIQ2ZFrVQ+sJOFK6MqEFw7MeXS2aNYYSwTenFJ1l?=
 =?us-ascii?Q?nHeafOzPXRSlIJws7l5I0oJnY/nMl1eZcrPlxmEeBtI9Hy7E4BryOg6z4u6e?=
 =?us-ascii?Q?pLH12GHAd9Ts9PDLcSLfcwD4TtXEzutmCaWxrAiLKA41zTmoMSkEJfRMplRL?=
 =?us-ascii?Q?tX979H49GCqijzPpNnlhVhZFxOUUvJ4TGzd6icdFIjYrZCHUTtHES5TRmZjy?=
 =?us-ascii?Q?m+YQOFngYCnic4W6GI57QfmBoKS9a8aVqPl0Yc074q2msN9vjeAW/Koo5v5Z?=
 =?us-ascii?Q?vZsJYE4a8elU8snLZM7nnsQ/5CjTBdW+QBoU1nIcT+i5yJsb/iRTenWNLGJC?=
 =?us-ascii?Q?E95+U8ZYQKUs8NGmJ2e5OxfVg8eFAzvC0OG1UUoYy0fhmhtBbJ3Ll+D/S5DI?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c663d66b-437c-4968-6951-08dc00a26811
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 14:54:31.1832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgGancHmL9+FbTSEUeuizon9rQWjnySvy0Eg0vXr/J+/3MNTgtam7W2Vn7QMZlu+VIkbXY1rQYZFsPAqSxa4C6MoYdJXLCuonTaTRj9mH0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9142

Add MACsec statistics callbacks.
The statistic registers must be set to 0 if the SC/SA is
deleted to read relevant values next time when the SC/SA is used.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v5-v9:
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
index 9c5c07138f89..40a926ffb318 100644
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
@@ -445,6 +509,41 @@ static void nxp_c45_sa_set_key(struct macsec_context *ctx,
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
@@ -649,6 +748,23 @@ static void nxp_c45_tx_sc_update(struct phy_device *phydev,
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
@@ -733,6 +849,32 @@ static void nxp_c45_rx_sc_update(struct phy_device *phydev,
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
@@ -742,6 +884,8 @@ static void nxp_c45_rx_sc_del(struct phy_device *phydev,
 	nxp_c45_macsec_write(phydev, MACSEC_RPW, 0);
 	nxp_c45_set_sci(phydev, MACSEC_RXSC_SCI_1H, 0);
 
+	nxp_c45_rx_sc_clear_stats(phydev, phy_secy);
+
 	list_for_each_entry_safe(pos, tmp, &phy_secy->sa_list, list) {
 		if (pos->type == RX_SA) {
 			nxp_c45_rx_sa_update(phydev, pos, false);
@@ -750,6 +894,13 @@ static void nxp_c45_rx_sc_del(struct phy_device *phydev,
 	}
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
@@ -941,6 +1092,7 @@ static int nxp_c45_mdo_del_secy(struct macsec_context *ctx)
 	nxp_c45_mdo_dev_stop(ctx);
 	nxp_c45_tx_sa_next(phy_secy, &next_sa, encoding_sa);
 	nxp_c45_tx_sa_update(phydev, &next_sa, false);
+	nxp_c45_tx_sc_clear_stats(phydev, phy_secy);
 	if (phy_secy->rx_sc)
 		nxp_c45_rx_sc_del(phydev, phy_secy);
 
@@ -951,6 +1103,9 @@ static int nxp_c45_mdo_del_secy(struct macsec_context *ctx)
 	clear_bit(phy_secy->secy_id, priv->macsec->tx_sc_bitmap);
 	nxp_c45_secy_free(phy_secy);
 
+	if (list_empty(&priv->macsec->secy_list))
+		nxp_c45_clear_global_stats(phydev);
+
 	return 0;
 }
 
@@ -1108,6 +1263,7 @@ static int nxp_c45_mdo_del_rxsa(struct macsec_context *ctx)
 
 	nxp_c45_select_secy(phydev, phy_secy->secy_id);
 	nxp_c45_rx_sa_update(phydev, sa, false);
+	nxp_c45_rx_sa_clear_stats(phydev, sa);
 
 	nxp_c45_sa_free(sa);
 
@@ -1197,12 +1353,196 @@ static int nxp_c45_mdo_del_txsa(struct macsec_context *ctx)
 	nxp_c45_select_secy(phydev, phy_secy->secy_id);
 	if (ctx->secy->tx_sc.encoding_sa == sa->an)
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
@@ -1218,6 +1558,11 @@ static const struct macsec_ops nxp_c45_macsec_ops = {
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


