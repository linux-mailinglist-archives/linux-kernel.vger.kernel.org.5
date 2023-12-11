Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D889F80C0F0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 06:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbjLKFss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 00:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbjLKFsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 00:48:31 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2089.outbound.protection.outlook.com [40.107.117.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BF619B9;
        Sun, 10 Dec 2023 21:48:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOURqCWWzji3YwMVqlnH0ATEAwe2buvWpgNyYh73VgsYiOsoV3t1uY6kznEZ1lAXcpisHbFiRODmJrzkV6MS1r+qtHoxYcH8GDd7A06GRZT3eTEknoBl5qZPuAk9wl1E37WRxyWMFoDjtzEzabRm/LgGKSQbPu8aFKu19ARZxJrWYs9cvJm8lTurmipbyyr/LLzwvDBUL/C1z4U4nPpxlqtsgc/hN1sphClr3uUCvG5QYA0IUMKjjHOBO0DBOVXSpkotmAnmY/H2TnZPldfewynHpsfhkkFPTkoltv909aLLVajBcnBmrK4NLEYiyjEhgqOpE4KkhFPHPBCwtSZrYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83g37U5JYMWUOI9fyNbhOqOvY47pyGOSPX4Hsoy3xvA=;
 b=jaY1sF8+MBjLjF4KQduGIYqpUULod1uvIvpsXOY7xx3ZAutpseYAX98U7LL6QYsOBp/8FgyZYU+u1HKoHilrEGBwan/6tCFf31ueaitqmyVrLLrZCvaSfbTT13roUzWYuyP+DHM7Y7Fd8YBMqcju6DHmOkoSrCUlLxtfFm3Gcb5hH7jKKqHaylil8zBjwtPAcf6HgCa/t1T33vQHkxqIQ3jJd90uLs473azimWAsLe0OBDxCBPX+7Q4k1JqY266Dy2pGBZZsVlkk8ir7Zks3M8o9G0df1l8Beowj+0SKsxCFsB/WMn65dgDc4T3rPjCzRA+vBxg/2mQRnwIWyOGsEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83g37U5JYMWUOI9fyNbhOqOvY47pyGOSPX4Hsoy3xvA=;
 b=mmOHL6GYZVFak6fM2EYJkkECSNAY27usC2stNTE1z54/G7SSK+297VsTaxDuPWmdBnkA6vE+2xyMS/I/Y7M4n7jhuBhOXvNL9QyBnyDPvSKekPMzoCPj53vQ1w04xYLIvsKrxHw0mKYNrHYAWgvJ0NyLR7rvXH3iuK2JkGgSD7Vhsuwuv47TbujJSUurD1yyhu5I+fMKWIatXPAZ2JPYEKvgSK3PrP4Vm9GWx9dCAv2juD/tWETMDMmzCnol0Rrzn6v/Z0mo9Y3gvrFRk1tMB3lhBNH4YsESILwVjdJ7irTjjmCH3A5qE/nABL1UNBoY0UBmnqTgrjAMuwJclZ4uyQ==
Received: from SG2PR02CA0058.apcprd02.prod.outlook.com (2603:1096:4:54::22) by
 TYZPR04MB8299.apcprd04.prod.outlook.com (2603:1096:405:dc::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.30; Mon, 11 Dec 2023 05:48:13 +0000
Received: from HK2PEPF00006FAF.apcprd02.prod.outlook.com
 (2603:1096:4:54:cafe::11) by SG2PR02CA0058.outlook.office365.com
 (2603:1096:4:54::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 05:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FAF.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server id 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 05:48:13
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/14] ARM: dts: aspeed: yosemite4: Revise i2c14 and i2c15 schematic change
Date:   Mon, 11 Dec 2023 13:47:24 +0800
Message-Id: <20231211054730.208588-10-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211054730.208588-1-Delphine_CC_Chiu@wiwynn.com>
References: <20231211054730.208588-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAF:EE_|TYZPR04MB8299:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d7c4ca24-7c07-4fa0-de9d-08dbfa0cc3d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hR9Sr05EKlV4GNOW44b9TuTBpBF162vcv4ziQyRe85MEpU8Yp+IGHkDe8zLXNdTGFc+HcQM6e8epFa6EAlgfeyhhkmsPKhxMD9rT4YyQU7WEIg2TE6Uic1BX/yd2g9yfFKAwSA4j6XeG7fD3S7/cP/sv9d/bVqluoNJGbvA8idJm1H9Y3KEIPxX6YCfAoA5J6ERGbbDHrj8GfX8AKZPHJcBoiQ8QCb0/KKQcO6XE5gOvPPBBM4QYOye93OnjK9HoHd6t19eLp0/Iae8juyFgZBGpTgWBnPMM/YJGLfohwiRWV3hAoF2aj4mfKyr0SJRaAg2u+dfAZ2Hkf3yjlj6pFnG7rCDbLE4WKUh3q+1BSWaC77AO2d7c1W8UsLHGcPUBiQQhY4r7yk2/jN4e5FRbFxOGKN2ZSSakXl1Ghs1PSjFc5rJmLyt+04CFD+V0U9webQO0NGWnWMegQQZc8nj0KpR2q0kOlHrlgrYTbgBudiPuhGvRc5awBZwu2q2M/EjuLm3ZQUOzN7HFnJU5SexYdy8D1j2yepbUhSfiDcMZORJyQCK+41HXpS4KDn5GwuiWOkRtJ8ZjpsiVJpF4qdKs2c3aGioD8kKFWKTwmprLgf6Ccp1E6IuapkQjQbuRdUJKo3tXTMueSqvN9R0Ue1m4kCHANd4DHLRt5Gw6x/XHMwImb+aEbsuS/mbGjLoFozXkTLryqLnSA3SKEYDdYXB3lQ==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(396003)(346002)(376002)(39850400004)(136003)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(46966006)(36840700001)(83380400001)(2906002)(81166007)(478600001)(356005)(41300700001)(82740400003)(9316004)(70586007)(70206006)(7416002)(40480700001)(6486002)(36736006)(110136005)(316002)(6666004)(86362001)(4326008)(8936002)(8676002)(6506007)(6512007)(36756003)(47076005)(5660300002)(1076003)(36860700001)(26005)(336012)(956004)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 05:48:13.2666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c4ca24-7c07-4fa0-de9d-08dbfa0cc3d0
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FAF.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB8299
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revise i2c14 and i2c15 schematic change:
- Revise adc128d818 adc mode for yosemite4 schematic change
- Revise ina233 for yosemite4 schematic change
- Remove idle state setting for yosemite4 NIC connection

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 31 ++++++++++++-------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index ccb5ecd8d9a6..ed2b1200603d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1010,44 +1010,54 @@ &i2c14 {
 	adc@1d {
 		compatible = "ti,adc128d818";
 		reg = <0x1d>;
-		ti,mode = /bits/ 8 <2>;
+		ti,mode = /bits/ 8 <1>;
 	};
 
-	adc@35 {
+	adc@36 {
 		compatible = "ti,adc128d818";
-		reg = <0x35>;
-		ti,mode = /bits/ 8 <2>;
+		reg = <0x36>;
+		ti,mode = /bits/ 8 <1>;
 	};
 
 	adc@37 {
 		compatible = "ti,adc128d818";
 		reg = <0x37>;
-		ti,mode = /bits/ 8 <2>;
+		ti,mode = /bits/ 8 <1>;
 	};
 
 	power-sensor@40 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x40>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@41 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x41>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@42 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x42>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@43 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x43>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	power-sensor@44 {
-		compatible = "ti,ina230";
+		compatible = "ti,ina233";
 		reg = <0x44>;
+		resistor-calibration = /bits/ 16 <0x0a00>;
+		current-lsb= /bits/ 16 <0x0001>;
 	};
 
 	temperature-sensor@4e {
@@ -1217,7 +1227,6 @@ mctp@10 {
 
 	i2c-mux@72 {
 		compatible = "nxp,pca9544";
-		i2c-mux-idle-disconnect;
 		reg = <0x72>;
 
 		imux24: i2c@0 {
-- 
2.25.1

