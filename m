Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31E876C56B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjHBGls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjHBGli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:41:38 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D132D40;
        Tue,  1 Aug 2023 23:41:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ki6Ex3IZYxK5U7xHAUv6MiiWVNDlKw4Q6ZnBGWofyVA+Bl9Ogh3ey6+rmnRP3ib4H4Y4IypL1Fn8/COWaCoVT7sM+AVhUZE1pkTsbNSLdk9RWbm0FQFqOCa1bI8JBDuRwyPCbCMsz8sn5AKO+UC1FDs8+U359zeXKXYgrgL3nG3NEBsATrkWxhR3nXshwwOA8zdRllxNVHLgyKDyXi/R1LafOkkSVeTQBO5k5HUPotFeBF8VOr5j6RZsGtsGiGO2pM8+fRZinhfyaTftj8QbEbsSzLyG/E10wWT+MMpFraIkPNBC0Ffljpl6qDYzZPweVhc/1PF5bEYUh03b+cUvNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOHL7oHYwKU8owEfqCpUIKV/RuI3UysW2nFFyV0QiCc=;
 b=O3ZuiHSK2Sa2kCKc6wGGFFOFokOSAiAw8Kswyu62Taxv2ptA+Ky4ySGzA5gLSBTOyLKuK6HL/p8e6fI3ZOZZFhpZXcuCu+mEqMdrANO7nMjBpJ5HvkYH5Rzh+F/NnxlrTucBInRKJypJJRvwWZd8UyZ6Y/M9jxes6tKCH8jFH2qJ39geOKkmZAcCElMZsrhHTBlE6FIpdLowRiCf0zQb1aoP/zMiwo1Pk3CccsJmJBWeLDN6Hf2d7KOK2ZMf2UoMYUmUgUzAwE7kQcrMhfWuY+GlVRr4ZXc+xIUqVqgdc2+HgX/h10KxdfSGESbd/3d9ntIs9f5XDWYnvTOopvmAJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=topicproducts.com; dmarc=none action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOHL7oHYwKU8owEfqCpUIKV/RuI3UysW2nFFyV0QiCc=;
 b=gesgNSBoDhc3qHG2NkNQrXabVtO5wGmJX2ZCZ29exu2gbse084dLx61jI5WVGrlvfi1JCe6Cka9kmUcQHztu7LlRtrc1It2eLUVzQqf2zTm/xSpYWFa26H/LBjJik7lkcRhyb1KN3jqxmxrYzdUC8+B8DTmHfUd1qhXE9x46bn7nyKkGCxnzB8FzWf/SlvQeuKQ9y3EazVkJqar6OeY/q72oYMN+0LMs58j/rZ++GvrSJxGDvYb+ofQ/D5m+wLXd9iiOay1+A7Moj1d6Yh+Ckl2GstZdigjZg3HazkWCA7x0Iwj4iIBD75BM36MXBijCtof05zMjOBdrQ5dv0BImRg==
Received: from AM0PR10CA0086.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::39)
 by AS8PR04MB8420.eurprd04.prod.outlook.com (2603:10a6:20b:3fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:41:22 +0000
Received: from AM4PEPF00025F96.EURPRD83.prod.outlook.com
 (2603:10a6:208:15:cafe::a3) by AM0PR10CA0086.outlook.office365.com
 (2603:10a6:208:15::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Wed, 2 Aug 2023 06:41:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topicproducts.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 20.93.157.195 as permitted sender)
 receiver=protection.outlook.com; client-ip=20.93.157.195;
 helo=westeu11-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 AM4PEPF00025F96.mail.protection.outlook.com (10.167.16.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.0 via Frontend Transport; Wed, 2 Aug 2023 06:41:21 +0000
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (104.47.51.236) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 02 Aug 2023 06:41:21 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by GV1PR04MB9216.eurprd04.prod.outlook.com (2603:10a6:150:2b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:41:17 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::6b6e:1525:72e9:d02f]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::6b6e:1525:72e9:d02f%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 06:41:17 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     linux-clk@vger.kernel.org
CC:     linux-kernel@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH 3/3] clk: lmk04832: Support using PLL1_LD as SPI readback pin
Date:   Wed, 2 Aug 2023 08:41:00 +0200
Message-ID: <20230802064100.15793-3-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230802064100.15793-1-mike.looijmans@topic.nl>
References: <20230802064100.15793-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.5ec2b609-3eb5-4de3-93d2-a352a16683c8@emailsignatures365.codetwo.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0079.eurprd03.prod.outlook.com
 (2603:10a6:208:69::20) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB8PR04MB6523:EE_|GV1PR04MB9216:EE_|AM4PEPF00025F96:EE_|AS8PR04MB8420:EE_
X-MS-Office365-Filtering-Correlation-Id: 971c9e8b-6220-48fc-2a87-08db93237c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: DiLCsMbU5N/QFmfIjdiokIC20kSFXjQ9NgF0vSofaS3PGmEaeosMsqp0tipYrjeahXLPQdLiePqjPfE9DuTMKIMWeNME18EF2bqMUlOJgUhWWqA8KBTMQptLMgt/KSIDEbB112JnGktrhVO6d/9JL8aF7qAdFmRcfILIHMcyYAeaEOblcHc22o4RAOSAwr1+PFzzl0Dt8+5KwEkw/xRN0FWecX0LGXjZzsq6k3wlt9ics+kO/oZtH4FMDYAKXPu1m4Bq+0W3gzGXyIn9mBb1L6LrSFMcaV2Pr6afzeIeiN8Iq0DcOXpynBCPgeg3N5pJ0/ogFPLWyDT0l8NV/amFiZxsXo9diHEin2DPZBIuCUxmmICh9wIfkycGy0++pYhjR92HgLL4vy9EmlvPKkh2rRr+38CcuZEEyQLn4q3a34sUklMkSQpkp5eyfrFdhl1WU2z/dwNfn5Dlq+LKEBGwEUTlwn0rxPYIe2L64llOZeAUO6aljbvUwv6xz3qTIKakJJBgUxDmS9O06R15YJkR5gI5QtOM9UrVf+PX19L4T+sA84JCBKdlM/jg97DnRturLyYEM8PDMWDT2EfEe70ATEjoaAeXpJaD8G2/FQtSx9yhKl1Q7OwGQoRBe8/9G+HB
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(39840400004)(396003)(451199021)(66946007)(2906002)(66476007)(4326008)(66556008)(6916009)(6486002)(52116002)(478600001)(6666004)(6512007)(83380400001)(36756003)(186003)(42882007)(38350700002)(107886003)(26005)(6506007)(1076003)(38100700002)(2616005)(83170400001)(41300700001)(8936002)(8676002)(5660300002)(44832011)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9216
X-CodeTwo-MessageID: e7d3d75c-3b9f-4d09-a72e-dc9513a73e60.20230802064121@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 31faedf2-1c22-49eb-eadf-08db932378aa
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7SRGZQFtVrRtlN5DEmevpPmW0eXxhFfrZy3R5qHSUuaTJ9snx9h/6TG0vM2QJbEnIZNLCBKPXjBsEb3lHO91Lp4iXh91b5WK4+gcKl503WkqaP2eVaVFC1HR8Ju0vZIiqd99EEsQsXW3vpCZsjNd8BsEFnXa5qx9r4AKcFYUx+G2Uf5SZXW0g9rslkpovVBRksM6tDaFGsW5mIe/E7WhykA4YVuEjj+kAwCFV1U3St0dSVVQRLSGvSJ7MSqFrkbIhJONyNbykcap6rF6C0kP3SvU5Wo6stB/+3/Gc79zvBo29MYm112Z4nP8aS1E7gAGwSkY5OZnOc1xODvCoXcp6iCq3bWHBd0HxMnSJL+BleQzNnX0MWzUl+0QItP7FXZmbB8HV0dbtWAsez5BHwVEZl5id38/2aQAkOtcqKIbIYrGYnyqbiCZ+L5NEe4dijLMgjCS2WBLAJv9+OiH3JhYphKknbVeqQIvRvdsCTaxZL3Ps7lkifwih9MNdFnROsBM5epBcqFbuWlPTrMITKKBoQ2m1ovItRVc+koQev/Ta1sHV/M2kEh+K6LCphMDijQ8WMR+CkYwHrdOlkgmUB4uGZv+C6suuhrs/p66ET08NBIN8jejQbdipcdUtdcP/7g8gY/RVcpoT2yz4d4KiJKxJMnQJH8MNFltNGh1ilXSkNAYvJo/DqQpmQUDPUt58AhAUXCGK5jgAz94Yi+JNCmyLQ==
X-Forefront-Antispam-Report: CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39840400004)(82310400008)(451199021)(46966006)(36840700001)(44832011)(6916009)(4326008)(70586007)(70206006)(2906002)(2616005)(356005)(7596003)(7636003)(42882007)(336012)(186003)(6506007)(1076003)(26005)(83170400001)(83380400001)(47076005)(36860700001)(40480700001)(107886003)(15974865002)(36756003)(478600001)(6512007)(6666004)(6486002)(41300700001)(8936002)(8676002)(5660300002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:41:21.8340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 971c9e8b-6220-48fc-2a87-08db93237c22
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8420
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PLL1_PD pin (a.k.a. STATUS_LD1) can be used as SPI readback pin. Make
this possible.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---
 drivers/clk/clk-lmk04832.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-lmk04832.c b/drivers/clk/clk-lmk04832.c
index dd1f0c59ee71..99b271c1278a 100644
--- a/drivers/clk/clk-lmk04832.c
+++ b/drivers/clk/clk-lmk04832.c
@@ -134,6 +134,11 @@
 /* 0x14b - 0x152 Holdover */
=20
 /* 0x153 - 0x15f PLL1 Configuration */
+#define LMK04832_REG_PLL1_LD		0x15f
+#define LMK04832_BIT_PLL1_LD_MUX		GENMASK(7, 3)
+#define LMK04832_VAL_PLL1_LD_MUX_SPI_RDBK		0x07
+#define LMK04832_BIT_PLL1_LD_TYPE		GENMASK(2, 0)
+#define LMK04832_VAL_PLL1_LD_TYPE_OUT_PP		0x03
=20
 /* 0x160 - 0x16e PLL2 Configuration */
 #define LMK04832_REG_PLL2_R_MSB		0x160
@@ -206,6 +211,7 @@ enum lmk04832_rdbk_type {
 	RDBK_CLKIN_SEL0,
 	RDBK_CLKIN_SEL1,
 	RDBK_RESET,
+	RDBK_PLL1_LD,
 };
=20
 struct lmk_dclk {
@@ -1346,6 +1352,10 @@ static int lmk04832_set_spi_rdbk(const struct lmk048=
32 *lmk, const int rdbk_pin)
 {
 	int reg;
 	int ret;
+	int val =3D FIELD_PREP(LMK04832_BIT_CLKIN_SEL_MUX,
+			     LMK04832_VAL_CLKIN_SEL_MUX_SPI_RDBK) |
+		  FIELD_PREP(LMK04832_BIT_CLKIN_SEL_TYPE,
+			     LMK04832_VAL_CLKIN_SEL_TYPE_OUT);
=20
 	dev_info(lmk->dev, "setting up 4-wire mode\n");
 	ret =3D regmap_write(lmk->regmap, LMK04832_REG_RST3W,
@@ -1363,15 +1373,18 @@ static int lmk04832_set_spi_rdbk(const struct lmk04=
832 *lmk, const int rdbk_pin)
 	case RDBK_RESET:
 		reg =3D LMK04832_REG_CLKIN_RST;
 		break;
+	case RDBK_PLL1_LD:
+		reg =3D LMK04832_REG_PLL1_LD;
+		val =3D FIELD_PREP(LMK04832_BIT_PLL1_LD_MUX,
+				 LMK04832_VAL_PLL1_LD_MUX_SPI_RDBK) |
+		      FIELD_PREP(LMK04832_BIT_PLL1_LD_TYPE,
+				 LMK04832_VAL_PLL1_LD_TYPE_OUT_PP);
+		break;
 	default:
 		return -EINVAL;
 	}
=20
-	return regmap_write(lmk->regmap, reg,
-			    FIELD_PREP(LMK04832_BIT_CLKIN_SEL_MUX,
-				       LMK04832_VAL_CLKIN_SEL_MUX_SPI_RDBK) |
-			    FIELD_PREP(LMK04832_BIT_CLKIN_SEL_TYPE,
-				       LMK04832_VAL_CLKIN_SEL_TYPE_OUT));
+	return regmap_write(lmk->regmap, reg, val);
 }
=20
 static int lmk04832_probe(struct spi_device *spi)
--=20
2.17.1


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topicproducts.com=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
