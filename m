Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198937DDEE4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjKAKGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbjKAKG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:06:27 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2088.outbound.protection.outlook.com [40.107.117.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F9DF3;
        Wed,  1 Nov 2023 03:06:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcHdPfkN+NZjMJkvOKDlCm9ScKLONPiXd6HTOweGg8KD0efF45/Ujo0XjauYyP8ivawZmOD05/Yp38E/cGAakSp7zX4a5i6seCehOU9EFAkW2jsAOt5RI6TIt5S5uTtFavqQBQ89Hgr7AkNKs4o+GS5HsufxYezPOkTB2uiAUzrV82wn1NvINLzEyHc6GyAzVl5OiXpauBA16wkQA7HEjS1NHlZZwWv2e6vW49aFlHOKFdaRDdY/Y+z1qw7YRWteO5A8aOeyAeiO+aRF9DXT2eOo3gpAHmAX2r0oLeRH1ACcauUrQhH+G/502KjmALOaANYb/o1hrw19SbwDOhgp/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irfYr8OVEyxmeamN7dwIjkiF9gynvXC3fYeuuHmMpMM=;
 b=KvkfY8uFWg3vJO9UufPe0sHLlbxtUZAkgMhmb+94XGUJ6Ca/Vi15vw6tnYnYYq20LJ/hdstTzVJE3ns0U36+YwasXRe6QPgzwFcBx4vZ2dhdr/WXj0mnxJgpxzbDtuzPChq0sPIMEMUBOtZGg2eP8zd6+dHN2a/G1AgdB/8HX8KvcW3bpht7X8bopjQT49wkAlLNDJTudC7uKm4POSLhNrYsf7mrlDj8ZCmLZ7ib1Ms+LENWR+Vcm+0mlrGzH48IwhMn9bxfpuDF/NqzTYNhl42+Q1t7zviuLRuq42gRv+fJS7ZeegfyfAbHPSq0XWvrqfGzlF+k29GDwkyB3Ko/3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irfYr8OVEyxmeamN7dwIjkiF9gynvXC3fYeuuHmMpMM=;
 b=RjqQMn5LI2BpvHiHQkNDUbrHWP4DI35S8F3gKRPW55MYN+0EIzeHJhh5tsSa39Er9tXiljMD9E4EJmMJl19PEVcLurmNFq6ZRXUyaGvFStX6Ocg3A/4mG/4QorfZQv621hOw6u2jM+raB9zWD68beZPzloqAcdudYBF03TfTHYIxuMV12YZDiUqzm/A4F83Kt+wA7lLn3/iMNRCWjPLPYiesXa0eXtgUdtUcca2FhoN3jUeJzK2cYbn1SZtOMXz9Q4E6iDfw3rhJcT736qik6pytIl1s02LO3Nh+W+gDawY63Wq+dW57LADazFB4vMCYk11fJ27DU9V1gT71wwAXLw==
Received: from PS2PR01CA0071.apcprd01.prod.exchangelabs.com
 (2603:1096:300:57::35) by SI2PR04MB4235.apcprd04.prod.outlook.com
 (2603:1096:4:e8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Wed, 1 Nov
 2023 10:06:18 +0000
Received: from HK3PEPF0000021C.apcprd03.prod.outlook.com
 (2603:1096:300:57:cafe::f4) by PS2PR01CA0071.outlook.office365.com
 (2603:1096:300:57::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 10:06:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021C.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server id 15.20.6838.22 via Frontend Transport; Wed, 1 Nov 2023 10:06:17
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
Subject: [PATCH v1 02/10] ARM: dts: aspeed: yosemite4: Enable adc15
Date:   Wed,  1 Nov 2023 18:05:59 +0800
Message-Id: <20231101100609.2516844-3-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231101100609.2516844-1-Delphine_CC_Chiu@wiwynn.com>
References: <20231101100609.2516844-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021C:EE_|SI2PR04MB4235:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d7c10b34-1cfd-41ff-1979-08dbdac230cc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iWnjhVlA+FKopP2/djPnEl8PVt9d6opJ+wSehntzzh8a2oLMrDtj/WyQ271oRomVIPsACi6ujFMzLsWY5A8Cbp8qVulGVc+0ZtlbsqhL985hJG1Gwe4y9m0deesiBRZBWbKRqgbBIvOgkjrYIKG+2PmOdXPqBebk1ZSSYBj4kc6FOqMC3oGdqUIIGqr2iy6y5a+PDaxkKYqq/xCpo+Sd743ARpsIVoTzHGHn5GSGB4GfN42ywZZSf8AHpsLepqkLiOApUliXGWMwI6N819vIUpZyEK/zcp/Xq215cAV/ZCsUFjY3UyaZNz8VhIILZ39UxjS/YbvPSrAABERJBDJNGaNosNVkYBRWU+tUCCMZrLNbbFIQuZu2hIS3SjIQEe6BDPyAAQfVAfEHeThkTDfr3CvmXPvw6AiarzZMVGO+IKYXS9hBPohvMMAv6pgxumdlx8/JFdP7N8tKVc6plCyuJN6biNP9RH5fcWBJeZyId10g4vvBCjvA3UYZuD4HAmsKuUzhw/Ae7twWe9p4+DxzwtyhzNoxgPuJdkUSqxKmPYtxqCuZNDrlgmugYx3rFIWGUQQmKyeKxc9mpd4nNESQJXa5UqtBMEPbjhQu4Ergm+Izg3bRHvoqfopl+5E0Y8Rwnb9KuJLPHo/4X8nS34ni1PlDRTTBYLR1hWzDTrWjxS88ja4H98ksBOqK4e+WaGT/reMYUqnIdwU9W2sEEBvtIw==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(346002)(376002)(39860400002)(136003)(396003)(1800799009)(82310400011)(451199024)(64100799003)(186009)(36840700001)(46966006)(36736006)(2616005)(956004)(41300700001)(36756003)(8936002)(26005)(6512007)(4326008)(1076003)(7416002)(36860700001)(81166007)(110136005)(2906002)(82740400003)(70206006)(356005)(47076005)(70586007)(5660300002)(6506007)(316002)(8676002)(6486002)(336012)(9316004)(40480700001)(478600001)(83380400001)(86362001)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 10:06:17.8062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c10b34-1cfd-41ff-1979-08dbdac230cc
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021C.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB4235
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Yosemite 4 adc15 config

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index a5b4585e81e6..c540523d5588 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -51,7 +51,7 @@ iio-hwmon {
 		compatible = "iio-hwmon";
 		io-channels = <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
 				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
-				<&adc1 0>, <&adc1 1>;
+				<&adc1 0>, <&adc1 1>, <&adc1 7>;
 	};
 };
 
@@ -920,10 +920,10 @@ &pinctrl_adc4_default &pinctrl_adc5_default
 &adc1 {
 	ref_voltage = <2500>;
 	status = "okay";
-	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default>;
+	pinctrl-0 = <&pinctrl_adc8_default &pinctrl_adc9_default
+	    &pinctrl_adc15_default>;
 };
 
-
 &ehci0 {
 	status = "okay";
 };
-- 
2.25.1

