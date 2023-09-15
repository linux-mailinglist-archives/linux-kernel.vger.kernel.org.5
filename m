Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F79E7A161D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 08:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjIOG3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 02:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjIOG3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 02:29:49 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2080.outbound.protection.outlook.com [40.107.215.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AD92130;
        Thu, 14 Sep 2023 23:29:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEFxoSYKhPIfpWuu4YVU0cM8TTSUsjJ/1w+0U0xv3Rv3z7EfOGsQ7LhYbvFj5AELpqyNs3HesXCX8IA4KEf4jPKeLvhkS9ukVIL6EZZrbJxK633h3/R2W472rY3xol7ckrRn6EKPfW8ZD4vISFmhF80CqWpPIWjUN3nkPIf1epQHeBJ/EAvy5A4FkEWwq1wvvDlmAi7bHvJvZ1vCAVLYs8XNaVA4NpiLFbz9UyUrPmA7R/eIzBSnogEv1N5+gAcyso7YY/POFqqGaBAMb8XLBXI0dBDCi46dWwUrjtH1MbkDOY7NU/0X5CrkFlloaDPtjLyApt2BmtxE0O1kq/YcPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llSSxjNOPF9TvD4dlBTSjANY6MqNb2RIlx7h2QerM2A=;
 b=dBfqdiGi9BOO7BNZdhyMSEQIZYwr33XFo6M63I43hBNzF792zJATgzFnPyT+evyQoHqdvxsBC92mO2UMz5oBemIpQk4oXTqe5DqCRjAfdsn3CRyVuAMzMSJFnLiczGH+cvYEh+yAxltKdIDPVCZZ+5f2/Ws97L1kOxQqlcLv+EETxr54PmcQMqhyGvBjkpsgmX+sSGGDmiH4v/WuB11d/AQK8UGWRQsKtu8TTGu0Aapzq31DvY/YGYncaBhTHnUb+7dAhXtkkHzbLNE6KE4hcH/mC83uhh+s9z9DjnCwTEVo78P6Q0R5fKcBOI/Aq1z8c6nhcv8mOthG7pzMPoY9wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llSSxjNOPF9TvD4dlBTSjANY6MqNb2RIlx7h2QerM2A=;
 b=M8qG7t0psjOI+E5sUoENTfN9y5mv4rmmEPk357jeOrYquPI4WxypImNp3zRllMS0Gqh65BE/syi9KJ6+X1V/Siof5MzhRkVqADmJA5zpDcFQ1Slvq/QSfQyr2K4NjIXtCytk9LGA7X7Jy52dD3p7BntFxJU6LhSvaL4EpNCVWRRVspx3tBL1wK1V8dOAeYuisAcVp2sKb8ZeRvXWszvyKgKk9C9DwS82gpqwcyxa3/sLacYa7CX/wJd3s5TKUkINkcrOpqfJTZll/FAuzM7Te6a6qpLQxCb3MldRhayBeK3R1aae9SmH26eKXvyX6kalVhrTCqUiCsmi0DUcJE1vSg==
Received: from SG2PR02CA0029.apcprd02.prod.outlook.com (2603:1096:3:18::17) by
 SI2PR04MB6130.apcprd04.prod.outlook.com (2603:1096:4:1fb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.21; Fri, 15 Sep 2023 06:29:40 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:3:18:cafe::b9) by SG2PR02CA0029.outlook.office365.com
 (2603:1096:3:18::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 06:29:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server id 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023
 06:29:39 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: hwmon: add MAX31790
Date:   Fri, 15 Sep 2023 14:29:24 +0800
Message-Id: <20230915062926.2460502-3-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915062926.2460502-1-Delphine_CC_Chiu@wiwynn.com>
References: <20230915062926.2460502-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E1:EE_|SI2PR04MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d36922a-4099-4407-364d-08dbb5b52448
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bJgwVOnUlJ+wuFuIOxeAUXKY/f0XxJoXMZHMJcMz6jPkzGSeuIwGtC8FykINt3f3uCHWTwsk3bdRECsUj0aYYbsnuO4ktcY7GxP4qOf/JDqrZmyDH51SrMbTkEqrTuRd2nYcJPv8/IyT4Ow7c8/eTktEbDqmEf++D/eLljJp6Cva+ZewKNd/X+5U0WslSEVagNYVex4nkj2iLAXPdOtuVBQ3Nxx20yFAqPSEep5k4UeYIt/ydry8rvP9PJuDr7QoYn9b6M3JazyT00eBgd7/P+Rlu2jy9sXGZ9S8lepMZGcKqZV6zjW2rjCkVEmxYjSPinBylkz8DJYBEM0BVo/1gP97uEJBxwSmAkj8QBMgJ9qONqXcfjXf6YTkAIOXRFmvoN9KOA/bWHYdZWTi0MDjHv1F3/BeIyo+9ht5hBJXzRX9cXMNYFAVOaGhz99J1r/u1/g5ThKSUd4ob8sM9L93F4P6mxQVpasD0AX1zpR+r//Tv7bfzrS2rYjWq+x9/Y2h78/2Dlc6TVtxANbSO2UkLLuvi+2TZQM7ucP41VAaTGqOnN3nAn7WSamoU6hDH7bd3XrWgto0kzGk1HxlkjQ9wg7c676XzKYc6ngunBRdo5V+LdgzIq62myPY/gDcYV1FSg2I8b1yvudBk6JpmUwkTWpOIJ0PyiKYbNRUgAejZNuqIEdh9fi8tVHPCuFt2L1N
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(136003)(396003)(39860400002)(376002)(346002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(46966006)(5660300002)(316002)(36736006)(41300700001)(8936002)(4326008)(8676002)(47076005)(36860700001)(81166007)(356005)(9316004)(82740400003)(956004)(2616005)(26005)(1076003)(2906002)(6486002)(6506007)(6666004)(6512007)(966005)(478600001)(336012)(110136005)(70206006)(70586007)(36756003)(40480700001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 06:29:39.9539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d36922a-4099-4407-364d-08dbb5b52448
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB6130
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings for the MAXIM MAX31790.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
Changelog:
v2 - Add dt-bindings for the MAXIM MAX31790.
---
 .../bindings/hwmon/maxim,max31790.yaml        | 59 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
new file mode 100644
index 000000000000..2bd455b36b3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/maxim,max31790.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim max31790
+
+maintainers:
+  - Delphine CC Chiu  <Delphine_CC_Chiu@wiwynn.com>
+
+description: |
+  The MAX31790 controls the speeds of up to six fans using
+  six independent PWM outputs. The desired fan speeds (or PWM duty cycles)
+  are written through the I2C	interface.
+  The outputs drive “4-wire” fans directly, or can be used to modulate
+  the fan’s power terminals using an external pass transistor.
+
+  Datasheets:
+    https://datasheets.maximintegrated.com/en/ds/MAX31790.pdf
+
+properties:
+  compatible:
+    enum:
+      - maxim,max31790
+
+  reg:
+    maxItems: 1
+
+  pwm-as-tach:
+    description: |
+      There are 6 PWM output channel in MAX31790 that allows to be configured
+      as a TACH input by setting the Fan Configuration register.
+      Config PWM output channels in the array as tachometer inputs.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 6
+    items:
+      enum: [1, 2, 3, 4, 5, 6]
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pwm@20 {
+        compatible = "maxim,max31790";
+        reg = <0x20>;
+        pwm-as-tach = <2 5>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index c8fdd0d03907..97e13b6bf51d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1371,6 +1371,12 @@ F:	Documentation/devicetree/bindings/hwmon/adi,max31760.yaml
 F:	Documentation/hwmon/max31760.rst
 F:	drivers/hwmon/max31760.c
 
+ANALOG DEVICES INC MAX31790 DRIVER
+M:	Delphine CC Chiu  <Delphine_CC_Chiu@wiwynn.com>
+S:	Odd Fixes
+F:	Documentation/devicetree/bindings/hwmon/maxim,max31790.yaml
+F:	drivers/hwmon/max31790.c
+
 ANALOGBITS PLL LIBRARIES
 M:	Paul Walmsley <paul.walmsley@sifive.com>
 S:	Supported
-- 
2.25.1

