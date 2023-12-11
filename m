Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16E780C0FB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 06:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbjLKFtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 00:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbjLKFsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 00:48:51 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2087.outbound.protection.outlook.com [40.107.255.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8AAF2;
        Sun, 10 Dec 2023 21:48:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RR8ubtJz0FRWlgIdqPmPp4/oXot8zeF7XhCmvLSQd81XzLZDrkEJPq6mfZqEe1UWHQ53xpKCYzDRVQO8OBVnXEr5JXmliClu1cqVX3ckI/Ig7NIGFsbh9Z84KzFPwtKcrSG5AbvQtzWbZPpozhLAmxK+B1QKEt/olvlRt3x6feloSzQnrw7QF5GhDzkh9xWhSxZpNL6yAFIrzEpR496gSKVFw+KP2iwgZQIsLoc6BD9F3KBgkgkKBh5LdZmoVerFLW2VmkgbVDoiMDkzYRY/vKY6n/tZsWsji5jYnB162VopjjTT9pyuicX9htmBId5mnoBMvndYflLQ1D88XOs4wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ngrZal1T5zKIoze4a9wDrSNcGDO8QNLgbJOqp4+OZ4=;
 b=hqx5IP+4ZUmEqVtevPS++vGHwWaH8TvpeQf3mOQmq5LIsARAZKh88ODNyHKxlC6xFVpoze8Yl8yzkgEe9Hbdb5cZ4JyfLhS/KXxdOhpqrh7G24PKYUc19/4FljfUU1qjTzb5NnPVMP+sK3HqAWeZ6+TaV5RbBddUAPH8RAW/p0lwdjpBtSBOKrLr6tWkXhckHFAGGsM477EOMYXf+x+aMbBkCqJ9dPdKqr7o8g/Eigy2RSTZMvwrLCmSrbuGInQZtcRtLuqBz+UQa2bbgvUBCta3OpYjQuzKxDj1fhO0HZmrNZuc+6PxAYhniTseZQab0IJKZcx2pcrKVMNYf4rqYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ngrZal1T5zKIoze4a9wDrSNcGDO8QNLgbJOqp4+OZ4=;
 b=XGA5wHAIUkNPriQd1aMt0DL1+cGyqciu/haR535IGb0iXkTLaMyPNayrroGhKQdDCC2cLcx13tthhpa2QL0vcWGSOqip4zN5QRH2lizk5mZmdkryj7f61sYTyjwpwz28vCta2OD+j/cmkr7nWEsVZniTeBmOrksyVyOXblLY0F36mQSAEjKfcVO5HVh9v+M4mRKMD84h3h2BlYf/GNfoZ2CFhLch0kgxsKO5qi2w5hIz4TFtqAV9/xK4D/4R96FvFWGMNY4yB1LZpjzj/XCULMAJFEnxFHL8kvZt3mxDYvgeYYZrfnXjQJ+eeyOhiCZJLNXkd1amXIOMrsaGSQpWsA==
Received: from SG2PR02CA0050.apcprd02.prod.outlook.com (2603:1096:4:54::14) by
 SEZPR04MB6622.apcprd04.prod.outlook.com (2603:1096:101:91::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Mon, 11 Dec 2023 05:48:29 +0000
Received: from HK2PEPF00006FAF.apcprd02.prod.outlook.com
 (2603:1096:4:54:cafe::f5) by SG2PR02CA0050.outlook.office365.com
 (2603:1096:4:54::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 05:48:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FAF.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server id 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 05:48:28
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
Subject: [PATCH v3 13/14] ARM: dts: aspeed: yosemite4: support mux to cpld
Date:   Mon, 11 Dec 2023 13:47:28 +0800
Message-Id: <20231211054730.208588-14-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211054730.208588-1-Delphine_CC_Chiu@wiwynn.com>
References: <20231211054730.208588-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAF:EE_|SEZPR04MB6622:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8618c39a-4622-477d-9be3-08dbfa0ccd2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IENDRkgC60Uy12QdFKCRpJ0NYbTtCkBr66Phd/ANWFC6ucWzw7vYsbNLgbL8leoPiEIFcQ+0DYZExmB+dPjCjJrh1SBrRrtH3ZE8HyV5kgwTL6Q/VMcJJzYLWVOYHyZ/hQxQaqcFcWkIAY5sYpHurlBRj0Lx5pkbImhDVRv6Fd+7KXjYyRCtslshmqIN6yK55nopC4zQlPEeMirpMe6V4dhF4ASiywCpeWz/wHsWCXYsnyMYvHWL9xC2Nvu0curK/UZMUNm9IN7RQNTJe0zAlcyv74cs8lTmTfl9F/lXEnOG1QIlQT1Guq/NH/dMg4szsbgQygksKhJBtpeVS0D+UtOqrBxFBOS51VTgFFMGgpBkUeo1VLRl4Z1ByTzW9li/VO3SA0Ldd2dzpLXRCMpZFHiibEFuMr6n2eLcGvM2h8iIRz5mZbjDhIcQJpT0rAgU+Z2Nls2lGpRyKnba+MYejBX6C4pHjrtRUz6OvPmoNKC93D2+UgdSSD6ERHa4IclbkymLLBTq9XSARTCz1ACvVtdiMlRxpaoLpKewVjx6Uxwz3aeTjovloWTTL5+JQpSPF0fFNDbwlEjiyOiJKPGpLpploQiIDz3WuTNz8BbO3FYbpdlstetchAMQi+kIeaq55Lv49wcIu5KkjYZYiqh+DPq4lDNJw3mZAAR6c+oC+EnE83YvC9S56BQNXjLvkB8Y5TDeGrV08ACz4lL0sJYwMw==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(396003)(136003)(376002)(39850400004)(346002)(230922051799003)(451199024)(64100799003)(82310400011)(1800799012)(186009)(46966006)(36840700001)(6512007)(6506007)(36860700001)(5660300002)(1076003)(47076005)(336012)(26005)(2616005)(956004)(36756003)(9316004)(7416002)(70586007)(70206006)(6486002)(40480700001)(2906002)(83380400001)(82740400003)(81166007)(41300700001)(356005)(478600001)(86362001)(8676002)(8936002)(4326008)(36736006)(110136005)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 05:48:28.9542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8618c39a-4622-477d-9be3-08dbfa0ccd2a
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FAF.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6622
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mux pca9544 to cpld was added on EVT HW schematic design,
so add dts setting for devices behind mux pca9544 to cpld

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 64 ++++++++++++++-----
 1 file changed, 49 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index c8e3a85b7a11..fdc33bffd467 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -36,6 +36,10 @@ aliases {
 		i2c31 = &imux31;
 		i2c32 = &imux32;
 		i2c33 = &imux33;
+		i2c34 = &imux34;
+		i2c35 = &imux35;
+		i2c36 = &imux36;
+		i2c37 = &imux37;
 	};
 
 	chosen {
@@ -951,24 +955,54 @@ &i2c12 {
 	status = "okay";
 	bus-frequency = <400000>;
 
-	temperature-sensor@48 {
-		compatible = "ti,tmp75";
-		reg = <0x48>;
-	};
+	i2c-mux@70 {
+		compatible = "nxp,pca9544";
+		i2c-mux-idle-disconnect;
+		reg = <0x70>;
 
-	eeprom@50 {
-		compatible = "atmel,24c128";
-		reg = <0x50>;
-	};
+		imux34: i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
 
-	eeprom@54 {
-		compatible = "atmel,24c64";
-		reg = <0x54>;
-	};
+			temperature-sensor@48 {
+				compatible = "ti,tmp75";
+				reg = <0x48>;
+			};
+
+			eeprom@50 {
+				compatible = "atmel,24c128";
+				reg = <0x50>;
+			};
 
-	rtc@6f {
-		compatible = "nuvoton,nct3018y";
-		reg = <0x6f>;
+			eeprom@54 {
+				compatible = "atmel,24c64";
+				reg = <0x54>;
+			};
+
+			rtc@6f {
+				compatible = "nuvoton,nct3018y";
+				reg = <0x6f>;
+			};
+		};
+
+		imux35: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		imux36: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+
+		imux37: i2c@3 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <3>;
+		};
 	};
 };
 
-- 
2.25.1

