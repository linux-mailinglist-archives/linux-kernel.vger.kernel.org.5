Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C318680BF9B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 04:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjLKCuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjLKCuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:50:01 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2066.outbound.protection.outlook.com [40.107.215.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5E710F;
        Sun, 10 Dec 2023 18:50:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrW2WERdnKa8z62fwRoQMsLMQ3GCylRL6Pg/4HFRTzH40AF8QyXdDCuKu5RwjvYxn41zobfv4J0oCEJfKU1CLQGi+Ms29Ytq0UiswenvCnz7afQbu35yISBGwvL1yF7kKBu2bwGW8rMrHLx3oKneAU6lt5xpY73RAdrRRc59/PWI4alMZ3yng29bZvNWeZQnuOjBZ2PAuhu7mW7SiIfXJgaktdy7Loqlw3Zhm8Y7EvR33tzKFoTsLrFlhPr9e7ruCazcTe+6FXdX/Av/2llZfh7B8i6iHDTbUHODwUs0cA9MbthIOaa7gNtWo/sV/EC82fSB8j4ptgWSQH7wJHL5uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9POU9qli8Y0G3IvdZsP/n3F+xvU76du76ssEtkRE+ao=;
 b=DH2xZs5cIJYoRglhmQQWQBIJjmofTiJFqBc7/msfBg/HCYMkY+DDrj2C8HfpIabtIQgHPFjnvvFPsO8bWF3DRABDhnLbcMc5IUOQUhU3slr0W0nDN7QCxrfDd//3fWSKgVsqM+KduJRFoVmGb5IXNrSsqBoGjC0T0Vl7qnN+PGFWJFI7ywMisS1sBrqhPecpgJNpeYh5r47oA68kK2dY5dA6jDBv13YarjYYe2kXgQ2K3yUor8uMO8ZT3yqCbdevp4zfo6QWyyFWnfadt4DBQ+qcOk7kFtIArP99eXfUe8OXGrzsHT9wmpLMyaPr2qIWu/p6kzz/i2xf+orswmon0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9POU9qli8Y0G3IvdZsP/n3F+xvU76du76ssEtkRE+ao=;
 b=1825T69WyCAHi/51p/6GE2HFEypEfEFabZYpJI+p2mwzykVdhtdmnBjrAZJoznequebKJZAMhvK+9K2bFhuz4uv/jkNd69zfYvNTdk0iLMOVwNwkFXfYDTod8JOYy/RivfMxCNZb2wxXPMQaI8lPygFywUmkUR5Ju1PFRzuyxxk3v35RKsr37Wk7Zcrf0wwgMm4VFBrHPKLLbYv/aIVX2WgTcALKJQYJW/MH/llBvWpl2FWAsYuxSDvBFJ+StRJTxu+Sc9J4TBryEU8ydocXgH90al3vbhI4R/oZblBLKXzBLESMLBCh1TnweyJczY9msqh2R4GjL2JNWtfm2c5e2g==
Received: from SG2PR02CA0047.apcprd02.prod.outlook.com (2603:1096:3:18::35) by
 SI2PR04MB4122.apcprd04.prod.outlook.com (2603:1096:4:f0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Mon, 11 Dec 2023 02:50:03 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:3:18:cafe::e9) by SG2PR02CA0047.outlook.office365.com
 (2603:1096:3:18::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 02:50:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server id 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023
 02:50:02 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/14] ARM: dts: aspeed: yosemite4: Enable spi-gpio setting
Date:   Mon, 11 Dec 2023 10:49:34 +0800
Message-Id: <20231211024947.3990898-4-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211024947.3990898-1-Delphine_CC_Chiu@wiwynn.com>
References: <20231211024947.3990898-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|SI2PR04MB4122:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 81e4f611-ba8b-4329-71d4-08dbf9f3dff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fKZuz32l/uUZJGqDYlkB+k/0m8ltjWdytdPyS8jDP/2jl1izVXGNSXZ3Xmae0AFqJk+DI/OTmxiL5KNKEwnRUphV9tZTjWntwA1jDsT/WfbBFkpdXyD5VqxpBVyR7AeFVcjc7QXECB0mJnlt8X0Gs17QE+Z31so6xrguOTy+M+L3/Fc0MCBKU2AsqW4xxgeHyUsIKPb6J1cK7PhVUNefvzL6i7z2hwOTOveNqU+19Epxz9b7NIheqN44xeBuNjFnEa7P5lR+nIhen93wHtiNUl3KuWwR9TW60YCXCPFaBeDfDAiKbt07COIr0p0iuJWc7n/fvSlxoSygQ7sG4Tb76+YpEOh0s9t7ab4nW4Bi0WJ4P2VCGNWNMobHlMGHQLaGG67nazcKCPqDv+UvYbqPfeItpSBwrLb+1urxsHOff5u54dqREUHhZWBtCpqckaCQ5U5lOJiSuqsXx0YD1te+SvGpwNUma0gtKuRkNkxyijrGLDuLztS7edHMjBkfqOwZWccKzMYhecQysf8qILpr97IqnWADpMHCgTyvjZ8P+EhI2D7qbzwFqc8yE3XoOmRoFIBzTCwsclBsY2v7FlVHXAJpx7jJW0JiIHvG82IQgDDc5xUXVGv9UBL02eUFNSyd2QAMX8djgeZgqBpXkI0akUaraS8V80rH86mia53IRxsM0qClkBIMAt5chLH3z0vfI6tVYlN0K/fa6Ovoq+8uyA==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(39850400004)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(36840700001)(46966006)(1076003)(26005)(956004)(2616005)(336012)(6506007)(6666004)(6512007)(36860700001)(47076005)(5660300002)(7416002)(41300700001)(2906002)(4326008)(478600001)(9316004)(6486002)(8676002)(8936002)(70206006)(70586007)(110136005)(316002)(36736006)(82740400003)(81166007)(86362001)(356005)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 02:50:02.6399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e4f611-ba8b-4329-71d4-08dbf9f3dff7
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB4122
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

