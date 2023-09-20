Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704C57A7251
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbjITFsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjITFr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:47:59 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2043.outbound.protection.outlook.com [40.107.215.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F87F8F;
        Tue, 19 Sep 2023 22:47:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ier5L5LAEJTJxsCwsfxqCZxUFWSj+Ay8eb4W07R1kY1UbSHl1WQfCgf/6Oq9JdxlU5xsCfc2d4hcxxaGRzJEk/5NX/SEBiWTdxmr1jsOMEeAr+rJN17kEY7G6NwsEUUS/gJJRFiE5+KDR1ZesmJSLIDk+2YdHbZS6pnTC1XH8UXCn0JcogChHqTVXU0AIt3t1kZ7rocHp6xVHiQlnhVU/9aMLukWpnA9+M0THisCzrToAXnrupOezcJDgOS07gG2s9iXYwHSBKYG67kFF/JxBG1yk+p4RTFDEpc0pHrWm2nAOz7GUxnEFQKc9Vf9tDUmPwpFTh1ozPFfyYz+UsN/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jO14/LDSrisvq3XoyS4yq2BBmb5WxQIOivxUKsRfefk=;
 b=dXYEJr1vyZRzn6/QV3+FfB2IMzNX8ZMgHDBgrMARbCAiHky/JN0pVFtmzSyGePexH4aICTzfPEmJrn7qMc3lPZwiK8jslx+eCoOvAgu05+5yKl339qND9ZQR+sHS+4tmQzK8qO8Uca3QLLBtLZskEK9zMsjcGPjTZFq9624byFT5ldPRgbZ5cerUPWku1mdEiWhLJY9ODGmF/FT+dT59/1iIt4zVVuTrSxPuqH8NfXzP8SaQ9AyhzViJ8JeTblrylCWixjGyriGUSN0XKyPRXV9PcSZzIO+lnNexlSXyNLpbaAnfq1JSZ6jvlDe2AH+P1kefGAStXDc4yfgAXO1qdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jO14/LDSrisvq3XoyS4yq2BBmb5WxQIOivxUKsRfefk=;
 b=1Z9YrsGa/rQKIlVn4z+hAg46Bk8bgACqEUfHpFfWmlK1+SksN43RL13HTsLQAOULEBzaBQZtTT8sCSexwlTHFhc3A+JmLdDVXH7VgEpgN2j3w+IFInHqZJHK9hc/AfldIwvbtGUMIe6jMUlwdCfEX2qwfTawCjHWR08sBrJxzUqgdrRhkcZ0iG2+dQpGyzXId2/4nepZIbjyeJBBGllV41mCVOzZ0y+EUbgvI47B+wjEeDjuS/EjLj2KbfbUGCvG6Ups7Tdbdp4lUodHvoGwwedrI5nrrB7flCfEevZ0wiiGkF8/fOWAhZ3hO6XaMB/YwklpARPPbNMPuQI53StrFw==
Received: from SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35) by
 PUZPR04MB6625.apcprd04.prod.outlook.com (2603:1096:301:e7::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.27; Wed, 20 Sep 2023 05:47:47 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096:4:0:cafe::d8) by SG2PR04CA0173.outlook.office365.com
 (2603:1096:4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.29 via Frontend
 Transport; Wed, 20 Sep 2023 05:47:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server id 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023
 05:47:46 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: hwmon: add INA233 binding documents
Date:   Wed, 20 Sep 2023 13:47:36 +0800
Message-Id: <20230920054739.1561080-2-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230920054739.1561080-1-Delphine_CC_Chiu@wiwynn.com>
References: <20230920054739.1561080-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66D0:EE_|PUZPR04MB6625:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b96f898a-0dd2-44a6-703c-08dbb99d1e4b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fmtoz2RIPy9bwyFLYPuJE1yKluDt4lapKK4xUPq02T7EpnEbj08Ha2AJ03kEn1ZgWSyPSCsmNn34CNJZNSY7ibpMPX+t8KoUel7gbMWtaAaq8u8a9nXsASE5Mm/R7jrYD7OIqD02tUYWK4AM2t7U3ugp5i/7JiXodigujKrHggO3QX4m2N1VyBAuD/KEck7x6ANpcyt553IDVBspphGkGX/51kKTzdn4ZK+QcN/fQtka+VXOtXJbCXnV0VeQmHmRONfFSDBY3xzcm3mqNMNYq9xWEJNac1IgOfOmjHcke8Hi022SVvzh/FdCCJrLYOz3cdWEOPVIH2PVEKCxZVatL7a8Q+Yy7kG+1gISKZKdMWHnIbXw+h/XdMBhbKBNNY4HKAWWOP3eNidFsWZq1ILAYx8++BLxzSDi9P60wC/ddpFsBOXiEoJEkqiaoEJCv4t2rJER8wEg4Ddp0dXNWvFRQhyNvm9fD6PEhqr5jFuTyw++3TDaPKSjxPADkbIACmBcUIHWGb6Fd6dobH5QayvYLGsMw7SOdT8SSYn+RCGa/GfewfwOcQq5npxb36u4JgEWt/FqwOg3woYkwWgx8A0+K9Fx//tQZlHw+BvHyccxFb/tRziCJo+LQhUbo5Tx/X/gO107hiCP+zY55jW85qdCCglLcNfHd4v0dzNgY+qiwyFJyd3pkpHY/QR6JjMz09BxFFV007uJAYRSHQ5QUrcE4Q==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199024)(1800799009)(82310400011)(186009)(46966006)(36840700001)(2906002)(5660300002)(40480700001)(1076003)(26005)(110136005)(41300700001)(316002)(36736006)(70586007)(70206006)(478600001)(8936002)(4326008)(8676002)(6666004)(2616005)(6506007)(6486002)(9316004)(6512007)(36756003)(956004)(36860700001)(47076005)(336012)(356005)(81166007)(86362001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 05:47:46.6071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b96f898a-0dd2-44a6-703c-08dbb99d1e4b
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6625
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add INA233 binding documents for Yosemite V4 config.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../devicetree/bindings/hwmon/ina233.txt      | 27 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++++
 2 files changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ina233.txt

diff --git a/Documentation/devicetree/bindings/hwmon/ina233.txt b/Documentation/devicetree/bindings/hwmon/ina233.txt
new file mode 100644
index 000000000000..a1067788ec0c
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ina233.txt
@@ -0,0 +1,27 @@
+Bindings for the Maxim MAX31790 Intelligent Fan Controller
+==========================================================
+
+Reference:
+
+https://pdf1.alldatasheet.com/datasheet-pdf/view/930928/TI1/INA233.html
+
+The INA233 device is a current, voltage and power monitor with an I2C-, SMBus-,and PMBus-compatible interface
+that is compliant with digital bus voltages from 1.8 V to 5.0 V.
+The device monitors and reports values for current, voltage and power.
+The integrated power accumulator can be used for energy or average power calculations.
+Programmable calibration value, conversion times and averaging when combined with an internal multiplier
+enable direct readouts of current in amperes and power in watts.
+
+Required properties:
+- compatible     	: ti,ina233
+- reg            	: I2C address
+- resistor-calibration  : MFR_CALIBRATION which will be set into register 0xd4
+- current-lsb    	: Current_LSB for calibration
+Example:
+
+        ina233@45 {
+                compatible = "ti,ina233";
+                reg = <0x45>;
+                resistor-calibration = /bits/ 16 <0x0a00>;
+                current-lsb= /bits/ 16 <0x0001>;
+        };
diff --git a/MAINTAINERS b/MAINTAINERS
index bf0f54c24f81..48b9a73d259f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10243,6 +10243,12 @@ F:	Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
 F:	Documentation/hwmon/ina209.rst
 F:	drivers/hwmon/ina209.c
 
+INA233 HARDWARE MONITOR DRIVER
+M:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
+S:     Odd Fixes
+F:     Documentation/devicetree/bindings/hwmon/ina233.txt
+F:     drivers/hwmon/ina233.c
+
 INA2XX HARDWARE MONITOR DRIVER
 M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-hwmon@vger.kernel.org
-- 
2.25.1

