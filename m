Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CB97DDEFF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbjKAKHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbjKAKHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:07:15 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2041.outbound.protection.outlook.com [40.107.215.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0EC123;
        Wed,  1 Nov 2023 03:06:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MapFRvxtKSZ3rCHP5m/ad2dnulnIN36w4JgdhKsXr6EWnptAid8Wmz+5Q/SEqFEbYvREyVUIGjCnADTIO26xaFdgXyafaOb2wYaD8iwNctVS/u4JABAUsdXsP4L/kr3AroTLPYGuP9yWpuOGagtzAafpl3zfI17nK/XAScqsYVEnsMapclO2/IgmjYsxC4qJCuhfY/jNKwMilD3IJ7qX+f4dUGrKOPb1NElEnOZEXAmMQfPApUv9eIKSCJsQTwNFStVc0ss4N2HGz2+zZCYcauSyrXrAsgnSWrVkTl7x6H7OgL2FUUITGjoJhV3KO8RTwMRftyvNTlHVbhnBtcflLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGk5j9ALgYLDS5d1cIdFPaQLdMxkc4MaKdLgSWfcvpo=;
 b=c0BAkdyFejV99e5aZIhJXQrihzsP13HfU8w7jEZIw3RyDuHQEr17M/TeEL7xRo5r0s8nrHu+sgDRK6wO6LyQ09EVV853096m4RcfBKO90ReF9YI9L+6BGUF5qwI5gf9tGOk7uuBAE02thxFsy2r8vU9FL4GVRNlfWhsgQtEeu7dI9oIXHUN3e5u2ScePt5OIOhRRVvMdkKB3dUTKjvepP+lfmImjLOe3BAzsFlDwCJmHqmkAQ08ihAExMythfK/ygRPA6q1o0HmVc8IRRtd2eSP2Q9Hv9e3sxZ5M3Fewlr9uQ66Q7WTmhtwvVNnSHuTTf/ssdYFi+DAfQUZaDwwISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGk5j9ALgYLDS5d1cIdFPaQLdMxkc4MaKdLgSWfcvpo=;
 b=SAc7qA6mfnA/aiEqXBETShIe5BSY58OEHMCeX6bwQ6ECXVjKwGD7wqKp1hUDUyx2QYOqGw2zfUnltME6AsC6Go/DBkDJN9EnmI9tkAIwNf1MipZC/RNIlS3NaeYzZoqiM0n/mEr2w7XC7Vp081edpsz3v2PULe6nntZDtKNhEZMEdywEG6Qbb7ddw++kHweloOWltHvvlstZduqrjL46Y9boxsWtw1O4WPwxZWNoJu0oUcui6ZN/sjYzHlkJhfgFqh/eS9zlQ8+RcpxPJoN3cpjfZKtJ0CCr8IFSklbtvRN4t2mT9faX4/4fMCwW6D0IFIN4xy0lmVyKyEp76Pk6ow==
Received: from PS2PR01CA0059.apcprd01.prod.exchangelabs.com
 (2603:1096:300:57::23) by PUZPR04MB6351.apcprd04.prod.outlook.com
 (2603:1096:301:eb::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Wed, 1 Nov
 2023 10:06:42 +0000
Received: from HK3PEPF0000021C.apcprd03.prod.outlook.com
 (2603:1096:300:57:cafe::a3) by PS2PR01CA0059.outlook.office365.com
 (2603:1096:300:57::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 10:06:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021C.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server id 15.20.6838.22 via Frontend Transport; Wed, 1 Nov 2023 10:06:42
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
Subject: [PATCH v1 09/10] ARM: dts: aspeed: yosemite4: Revise i2c14 and i2c15 schematic change
Date:   Wed,  1 Nov 2023 18:06:06 +0800
Message-Id: <20231101100609.2516844-10-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231101100609.2516844-1-Delphine_CC_Chiu@wiwynn.com>
References: <20231101100609.2516844-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021C:EE_|PUZPR04MB6351:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e1631906-402a-4353-7261-08dbdac23f53
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RolNubGywJAz54UOaygCqCLptRwT3MGEuyYOayt6VL+3zDDWdiN1s6iOwNKU5WovgDqf9RxglcMc0/3hdDixCt91+lnnP3Iv3gIj6v0WcW7AKDA6F/xR1pga1ukIFr5xoen9FB7QfiQCKlwFqEnYk9+s4b2wPBSufEce5EUXT40hCiNla3bnZCKHRExymFrCTF2iDtuA2bpBwInh7C9ri0SuWguOg7XtvkNT8slZSj+jCCFW/onExeRwHD4IFQbluIydCLj9BW3eRCrQ1k1DtqtoA6/aLwhd7i7P6VUtLCjL0UtZ+kh7xGiThdmg/NfZL88JtCYIqADThIMU/z0eEouDeiFBT6Os0Rtr6c9joEEoKxaoSGdkqMdTVkvQwHp/WaAKzUSiOu/H55Lyobvo0LJ5xX9AQ8i/XLPKAagxE5iavXdNDEdRBt2RsPDwc93MvZMrAipSuXvlBetXGlpoM1lyxnYVNTbtMPbjlMHKzshtjMecNm57n8tXBot3T4efM2A7NgrXm2CCvkZucreA724RpibM+FyoVRg13EZW3Ye3/isYZCNAenLdWT+cjes89FqGlk9EpBM+UQ0atKo/UtT9z55IAy0hGpKfVJoCaJak4q34D2Qcmo4zrEFcl8Mo0eDsqI0a0CYYC7agifOj0QywjVlhwIS426uVViSdbrGYyDpmv00m1G7GMvWcObab1NASQpHH6soFMuwvx4qI2A==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(39860400002)(376002)(396003)(136003)(346002)(64100799003)(451199024)(1800799009)(186009)(82310400011)(36840700001)(46966006)(316002)(40480700001)(36860700001)(2906002)(7416002)(41300700001)(86362001)(8936002)(36756003)(8676002)(4326008)(6666004)(81166007)(82740400003)(356005)(47076005)(70206006)(2616005)(36736006)(83380400001)(336012)(6512007)(5660300002)(70586007)(26005)(1076003)(478600001)(956004)(9316004)(110136005)(6486002)(6506007);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 10:06:42.1657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1631906-402a-4353-7261-08dbdac23f53
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021C.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6351
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index d2b8091326ea..a0f0424457fa 100644
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

