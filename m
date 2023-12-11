Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F57E80C0D5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 06:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjLKFrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 00:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbjLKFro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 00:47:44 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2077.outbound.protection.outlook.com [40.107.117.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6A8106;
        Sun, 10 Dec 2023 21:47:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzNo81TrpG4ZhuDZwoK2o4YpIkrRcc+mXNz4FsfuQppk20FPGeLmwRfwFJ8Bq6qlQw9w+plA040cTjD66cvQ9xIf+aIxDH92MJjazE7wlrbf1QXQ8Sn80cCtJ6sC22scqGWVW61LEsjD8aLo3hxscgNGK9MOxjN6Jg/u7KK3pM/g1IhNUXvqGOOmdtOAVQtT/iJOUCfldPGqxRtQ9mUC3ne0UJKl1vFvw3NXscQuYEY4n14Sm3sIfSf3Mcb+KSfih6CgMfbqysXpDwh7OPnxIoudqE8G5FmuePlLrd2Bivdf/xtKRO9bRoEeFoxS79PQt5qml9rWxqOz1VqLKAH5Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9POU9qli8Y0G3IvdZsP/n3F+xvU76du76ssEtkRE+ao=;
 b=NZDZ0a43XOM/zzhfRP5MyAv0RgHc5ltSrTMV2vTtn6rJ1/pjNRullwEVz1TP04e2BxFYQpVGOMe0XZiXISAJ55SfOaHeXaM7YzzGxhRjZ/FBfd6mdxbsOboG74Hg/ThgMjd5FUZ8SmLXArNegBM9v5CX3DqRC0oSC+Mp3YvLhxH7fUKoLf4ToJVnvq8D4loCAus4aqUD4itEFzZ16jJ7DFUWTiRdokZLpjZhj+34GCnlq0w14LSEJxkaN0PAoyMzvTcSXm7cL0oxVLdTWkKNhrcdyCC75HBrJQLkE2zPrHw3TNYKybXeua4w/2NYGLi4QmWUckRB+8D44QFiNjmv6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9POU9qli8Y0G3IvdZsP/n3F+xvU76du76ssEtkRE+ao=;
 b=sH4zN26/rGPE36sn/j4j1vdQ8+lh10w/n36AC8BQaNfftAoR8rTbgCy0rkbB4xE8L65wkfguep2n1y0bq9HD+DmFP7w5Sp5Z6cKQns8JvrJeeWEbeM2YaMr1f1qSL9681EK3ie1WGckklbQ8QmS8n1eSxibnmCLZhwMJSoRjgLyvIzpctIzgpyu4GY7AcT7+lHnY7g8RueJn1KfPN4RhwkL3TyWxo0Xs1BvlLJl/Qcf6UpfL2o6q236I4NMueWJ+AgnBOd7yULdl4gbSee/I3ETTOFuqaOyo+IZhM0FeM799X0pInmqXa2TJG8b5/M2woWJtOaRTvNgV3253pIKpxw==
Received: from SG2PR02CA0052.apcprd02.prod.outlook.com (2603:1096:4:54::16) by
 TYZPR04MB6103.apcprd04.prod.outlook.com (2603:1096:400:25a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Mon, 11 Dec 2023 05:47:44 +0000
Received: from HK2PEPF00006FAF.apcprd02.prod.outlook.com
 (2603:1096:4:54:cafe::52) by SG2PR02CA0052.outlook.office365.com
 (2603:1096:4:54::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 05:47:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FAF.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server id 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 05:47:43
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
Subject: [PATCH v3 03/14] ARM: dts: aspeed: yosemite4: Enable spi-gpio setting
Date:   Mon, 11 Dec 2023 13:47:18 +0800
Message-Id: <20231211054730.208588-4-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211054730.208588-1-Delphine_CC_Chiu@wiwynn.com>
References: <20231211054730.208588-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAF:EE_|TYZPR04MB6103:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cacc32f4-8069-44fb-1b14-08dbfa0cb258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XP5WblAyjIqNuBj831UeheaJdGgT2z0vVOs4P93U9um7+owfknDp9msLXxAKV6eOeo8zoss64fNhGD/iUB9BehqnFcpUbKgjokxZXyS1Sy6hnokrVGCFEfRRPDngyyYpQk1l6Lz72fPmJriESdX04JASL75MKDbyOpFRYDwuzKvTmgCZok3cmTqaveZItVRYZnyNDiQCgDofW4HNKEllE3hPHZo5wTGO9WDsJ+lwaygfSRUmMU38FLV3rhUWyOXMgdc148FnHgBpo9nWCIklcFrqtFVwUi816jNZ3+eJtFpel164nWlBjeEa2Snsqj2aqNBwiRYZsj/OUVpR/5eccteSuelFBv301qlmf1TW3yTL0r6sIeemm8lrff8/AfD66O228aXR3hdfkHqD8Ur0dAG8kvJLllHIIAKBm/eHNJcZzP4FE1guhBdI4inhwSZ0Xm0WUc2ujmgG36xQtZAs7NRAH1wW/4omwvj8QTJNXq3IN9LrLwnjYJMS2c4K+fSZTFtThKf6oj941g4ttc/kZoXPBWqzeyoo8YNC8hfTabNBgPKKiF46GGNDGlNI3Fhee1ijeO59qXqNwdgaMw5v6lh8+VcDZjTscmbhn01g7qh6856BMz+WCFpIDTUsVn+JNSDpPFGzcNWPrTzbfigupaUMhjMiIOHJKDex1tdAWBTu1VJkrsUOi7K157LiDSeMfY98XQ4kR5dL9ucFycJHcQ==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(396003)(39850400004)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(82310400011)(36840700001)(46966006)(1076003)(26005)(956004)(2616005)(336012)(6506007)(6666004)(6512007)(36860700001)(47076005)(5660300002)(7416002)(41300700001)(2906002)(4326008)(478600001)(9316004)(6486002)(8676002)(8936002)(70206006)(70586007)(110136005)(316002)(36736006)(82740400003)(81166007)(86362001)(356005)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 05:47:43.9539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cacc32f4-8069-44fb-1b14-08dbfa0cb258
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FAF.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6103
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enable spi-gpio setting for spi flash

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index c32736fbaf70..0449a7e36ff6 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -53,6 +53,24 @@ iio-hwmon {
 				<&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
 				<&adc1 0>, <&adc1 1>, <&adc1 7>;
 	};
+
+	spi_gpio: spi-gpio {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		gpio-sck = <&gpio0 ASPEED_GPIO(X, 3) GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>;
+		gpio-miso = <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+		cs-gpios = <&gpio0 ASPEED_GPIO(X, 0) GPIO_ACTIVE_LOW>;
+
+		tpmdev@0 {
+			compatible = "tcg,tpm_tis-spi";
+			spi-max-frequency = <33000000>;
+			reg = <0>;
+		};
+	};
 };
 
 &uart1 {
-- 
2.25.1

