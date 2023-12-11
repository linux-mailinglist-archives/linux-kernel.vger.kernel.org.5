Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B93880BFA4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 04:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjLKCuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbjLKCub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:50:31 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2055.outbound.protection.outlook.com [40.107.255.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96AD100;
        Sun, 10 Dec 2023 18:50:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3+CDDxDbG0l3JvI8yGqiRmFmJ4gq8NpB19GkRC1+3B4uDqs3LmSvSdZEaA6WNtewCpbgXBCt+OG9M2cSdVCtPdlKY9uDPla3v1yBgYJHAlbcKYb6g8mvQ8l2MpXymggdmv84+BOvRZGiQ//LnYr32hmhp0n1B9WwB+Q7svxV/aW5mF1BXHXLtz7R9fQDQIgmnQl0tORTedJBZhrv9NgnAH+GP0GhaE+uCLsov5T15u4JIDbrA5Tm22vF8/CzDajUY8S6Y/z0BOdkO7lE40axIgamXJfMHmR6JD9PyvJE4o7BRGxLtYUKNqzm/0uXi9MvlqS06i3Wt/h3KtjOk62rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83g37U5JYMWUOI9fyNbhOqOvY47pyGOSPX4Hsoy3xvA=;
 b=d8B7mW+UOXyryXfmoGPJNcebWP6B/T62DOxQ40t9vtWuAaUtHbQz0sUhfNar0+fXYD5NjQhM4STatuvPPAL9io4vWzF3klT4Sbapf6+pLPQpEv8OtGT2Va5IjZKkR/5WLiStsr3GhnbFfCgHDyxexjnAMq/k8fQF83U8V51qEwQFFE47nE5rCQZh4iI+bpHXeijnB9YmR7iEvuFIqT9dY0VrkX1epZjgbKpXmDuTwEe5wxQBSRrP6V4C5HVREmHEU65GY8EdLcz7tPwBhjweEoHsYQaNR2reDlIYUA2bR95cS9ZZXX5McFM81spCxFA1V6+RiXMU1VaFcPylh+Bpqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83g37U5JYMWUOI9fyNbhOqOvY47pyGOSPX4Hsoy3xvA=;
 b=cODCHb+E9TUk0team0A47Hs1T0IeYk+UcPxQPENlRTv+pLYrcHUHvPs94om+4VxRhVPc33P18HizzgSYmTB8GlRiWcFKREzzux3qgNcGbAE49XfpJtG7pvg7aMSyeJBo1AOM8Au7zogMKdvhdHRn6Kov0C8ilDB7Tu2hpyd+1IMHWf75ZvAQCRjuZl+Gg0ndoxddT/FI4t89o2D+T8je6zvK9CwMx6lFx1V1ZwhF5zGGkiqtiMv3avVz3Yb3lZUz2ax3yFk/18zhskmuCegUK25Y+ZRM+2zejQkfx1leJCPhXMiDVZmpKZiTxIUeeJu7LiylziA0Mu7S9MfPUXvQuw==
Received: from SG2PR02CA0043.apcprd02.prod.outlook.com (2603:1096:3:18::31) by
 TY0PR04MB6421.apcprd04.prod.outlook.com (2603:1096:400:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 02:50:26 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:3:18:cafe::cc) by SG2PR02CA0043.outlook.office365.com
 (2603:1096:3:18::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 02:50:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server id 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023
 02:50:24 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/14] ARM: dts: aspeed: yosemite4: Revise i2c14 and i2c15 schematic change
Date:   Mon, 11 Dec 2023 10:49:40 +0800
Message-Id: <20231211024947.3990898-10-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211024947.3990898-1-Delphine_CC_Chiu@wiwynn.com>
References: <20231211024947.3990898-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|TY0PR04MB6421:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ba72cf6f-9271-4275-a6e3-08dbf9f3ed0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j9kCO5KiGnKFGZktFZ/MufDLXcwQyqMcyTGMEwsLeQ/F8xXc1NlM5TbLirwRzzQathvDpp46E88T75Zt8ufAzUZl1+tjmtky6cacc6IQ+CwDAiIlRRJ3cC678ZHT+WCl2u0flmKw7oIzMUDqMvWwHIEF5O5+lx5KvQwY9YTbSbcLgbkQ1rxAkF7ET3Nb4A404BWn18qwsmkyrTmQQoSr2XdJoDUsYu8n6qeWBTFKBk2Or1mfZij50torkH7zyxxl0Y2KYkCMFMaRT+/cRhPHuGrpNUZBKAW5eQ7XOB2qih+0VwGGmU9xY2s4v1/Kh2vCXdRz4dA+0E7GRagFzlSUTy2pjv0fpp7OFG1xoZRjqvRXFwVifnpSOpYwtDGhrKClA4kgB3Si8V/+cKc3KNCsywcvNwnhzEpEeL4qw7y0y+oqFo/09uzat9j98g7SI2uIY28YETq6vot6SOzYtzBe4rRcdhlQjoqe6qKSyawds9LNxQucoOcECjgwWm3vbwdUuQEjh0675P1Z6583EjoIlMZvUlHYKUoo+TOQ60YKmDGoTBJ2vLZSuFRhBOlSo05OPZzJEr7fbuvIx/FmAL7gFSCCzBqfrxZoMy2DyhEyEgMaBjlNiTVJqpfvZ6MfZxEouzLmp92HX/gKs0BNfDCRHXUY12YG0vrgkU8D87nhgjma9X723XXHLDiMxzqWqyrnD+LxFVth2pVmYSr3KfCTRA==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(396003)(136003)(376002)(39850400004)(346002)(230922051799003)(451199024)(64100799003)(82310400011)(1800799012)(186009)(46966006)(36840700001)(6512007)(6506007)(36860700001)(5660300002)(1076003)(47076005)(336012)(26005)(2616005)(956004)(36756003)(9316004)(7416002)(70586007)(70206006)(6486002)(40480700001)(2906002)(83380400001)(82740400003)(81166007)(41300700001)(356005)(478600001)(86362001)(8676002)(8936002)(4326008)(36736006)(110136005)(316002)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 02:50:24.6089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba72cf6f-9271-4275-a6e3-08dbf9f3ed0f
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6421
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

