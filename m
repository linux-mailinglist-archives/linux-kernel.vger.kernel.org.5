Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52B2811E0C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 20:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441988AbjLMTFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 14:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbjLMTFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 14:05:36 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01rlnn2084.outbound.protection.outlook.com [40.95.54.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF7C95;
        Wed, 13 Dec 2023 11:05:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2sp9XurqZY/nFhxYYYn0jh5/gFkMfCTdLwOzcvlw0TrSgEHsVSwQ63Qyd+mKmMHtcNNZeEi4vXTQsL13GiF+nKgp+Ne2d6i55YHkCKe0q4dq4fuEWIoeUAN096SYSmd4PvBGeVx+7tUqH+IirxZ2WNbUBa1Evec/30jxF1liSG1txe5eN71Qykfqc1ZFG7zlJvggYFKO29pG1mU9+m4jX2ykZbkO/bJVKeq8X+UgYZRqnI3tLKz7TA6tQrHK1JKdHQYlZB94Hmrbj/N2pKIZFOpdwzn/OBoMIk9RHbp1jwMmoLTpQ+5mxlYlazAOTAIr+5Yb8A/CQsyq969nQqzhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0LyUQsBfa7WSXoN5rhI9TJq9YpuQCvgfS5Mnc2qq9k=;
 b=G4JgD9oW5As9uNSGo9CYtj3EvZydwLrEpRMvAWaPQjqQLLc1KzPpXd8x/HGl3kAYzikLUMJjUIw1p9lRMP98WnyFim5VZbzfVhKIsi3eqkSdhe74kZOyy7OdqHgt+VxO63c5q43/lVDJMSmQgQlRlu888BIuBGZy3HgxQCEprci5Tr6S76rUbu3cFYOIcCr/8DHvb26CLLmfkle55zqjthEDhfcGGT0JzxZ3+2SqVyVxKMkrhA3d8QYqFAnwErhAYT6ofbDrQe1N6Q9jM9VMx11dQhxt/FqU+xvWi4+LnO+iAuA563873gp3X21+2aZiVqK4+5aUEqUuYhJlF4PNpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 175.98.123.7) smtp.rcpttodomain=arndb.de smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0LyUQsBfa7WSXoN5rhI9TJq9YpuQCvgfS5Mnc2qq9k=;
 b=jafi9euktJMBFizVPlkEUWoJyJLw82Udk8DKpqixfBJ/tKGPby65dnpSPezzhGYmcNlqUc8B0Aj0eAtx4IyRsVJwcic2lgM80iMdwNu7ZaHq73USnfAVUEdvlqLGwWtYBd0O7Eq2GGxjYDQSk9WLExMGhTAeo9YplJODiQo3Oy4=
Received: from SI2PR06CA0010.apcprd06.prod.outlook.com (2603:1096:4:186::6) by
 PUZPR03MB6188.apcprd03.prod.outlook.com (2603:1096:301:bb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.26; Wed, 13 Dec 2023 19:05:34 +0000
Received: from SG1PEPF000082E3.apcprd02.prod.outlook.com
 (2603:1096:4:186:cafe::7c) by SI2PR06CA0010.outlook.office365.com
 (2603:1096:4:186::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28 via Frontend
 Transport; Wed, 13 Dec 2023 19:05:34 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 175.98.123.7)
 smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 175.98.123.7 as permitted sender)
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 SG1PEPF000082E3.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 19:05:33 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Thu, 14
 Dec 2023 03:05:32 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 14 Dec 2023 03:05:32 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id A0FFD5F5B8;
        Wed, 13 Dec 2023 21:05:31 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <arnd@arndb.de>, <pmenzel@molgen.mpg.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v3 1/3] dt-bindings: soc: nuvoton: Add NPCM BPC
Date:   Wed, 13 Dec 2023 21:05:26 +0200
Message-ID: <20231213190528.3751583-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213190528.3751583-1-tmaimon77@gmail.com>
References: <20231213190528.3751583-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E3:EE_|PUZPR03MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: a0bf08cf-a2cd-4514-3236-08dbfc0e7b7b
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RLgkv2SDPda2oXkk6KDrynrJHvHbo+XrFV6MYPN/7NnY4f7UbQb8FsLnVxLL/InUxI570QTLlWBDcXuDGXIcoJU7t97G3sn8eHyTRWjnKtvRK6OR9k5YYX5wwAxxQtvXyPDJHSG3NAHyjEtEXpNsz7DfMRIhq6CfLVaf9Meg3ywzglaBwPHwf5bw9L3f+9oBtd1R8LzuC2qtnrQjxbsjMehE2ftizwlFv6N/PggXPs2IuuqvinEuExRjVxWFNJvnDxWUh+rspR/9MT7B5MgglB/dGkg5i2tL6qukO1ky3SKySacAg7THw26Cw2PW9EwIBGu77v2hkpMgW09NXdFj1FraozLhk0QLkDMJOXN5Gggcx44vBxdoXwRqetrfyxUwPSgVr5p/5Cx73MzMRPSC+CfL0srOq4WH4cDm4e8+j7ihg/mZKVLsKqd65RpRqIX6mJgIwGLGNMsEdA0sP1GurAksodGQZ/j3AW9VUNmvxIOBfTA2cE2T5ZFEGXapTbOhcWemvChbmK5tDnHE4dwp4ua6694gdIfawcfeC5bWrK7GGyXC3hJuMdPbYHUGWdzPtCF4Qx/1+t3DvF9jEpBMQ/P9SZUGNc4bIJsu4hz20XPAofmKjct83D3M2+mQkKh6G5Th6M8U+V4ULIQaPmQN0B9MHitupwcqr5WNu9DOnz1O6g7HhKGC0kI9sliTQDiAxG8jFe2TRT3f2+vpkn4fNDJksu3gqL3V4fgMGezoC2rpmcfsbAzVqN/OkGC6g5J0QtX9ElbLLe4At89K32Q4SfyUyDvi3LsasiqyL8/r1rruc0rIg7W97T8cqiB7pjJmAkd6K3qGGz9jx/yTTvt9qg==
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(82310400011)(61400799012)(451199024)(48200799006)(64100799003)(46966006)(40470700004)(40480700001)(1076003)(2616005)(73392003)(6266002)(336012)(26005)(82202003)(6666004)(40460700003)(55446002)(86362001)(81166007)(82740400003)(921008)(36756003)(356005)(5660300002)(35950700001)(8936002)(8676002)(7416002)(4326008)(47076005)(54906003)(70206006)(76482006)(110136005)(70586007)(966005)(41300700001)(2906002)(316002)(498600001);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 19:05:33.3532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0bf08cf-a2cd-4514-3236-08dbfc0e7b7b
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E3.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6188
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,PDS_HELO_SPF_FAIL,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_FAIL,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added device tree binding documentation for Nuvoton BMC NPCM BIOS Post
Code (BPC).

The NPCM BPC monitoring two configurable I/O addresses written by the
host on the bus.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../soc/nuvoton/nuvoton,npcm-bpc.yaml         | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-bpc.yaml

diff --git a/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-bpc.yaml b/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-bpc.yaml
new file mode 100644
index 000000000000..c04302a1d52b
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-bpc.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/nuvoton/nuvoton,npcm-bpc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton BMC NPCM BIOS Post Code (BPC) controller
+
+maintainers:
+  - Tomer Maimon <tmaimon77@gmail.com>
+
+description:
+  Nuvoton BMC NPCM BIOS Post Code (BPC) monitoring two configurable I/O
+  addresses written by the host on the bus, the capture data stored in
+  128-word FIFO.
+
+  NPCM BPC supports capture double words, when using capture
+  double word only I/O address 1 is monitored.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - nuvoton,npcm845-bpc
+          - nuvoton,npcm750-bpc
+      - const: nuvoton,npcm-bpc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  nuvoton,monitor-ports:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Contain monitor I/O addresses on the bus, at least one monitor I/O
+      address required.
+
+  nuvoton,bpc-en-dwcapture:
+    description:
+      Set DWCAPTURE bit in BPCFEN register that enable double words capture
+      according to the first address setting.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - nuvoton,monitor-ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    bpc: bpc@f0007040 {
+        compatible = "nuvoton,npcm750-bpc", "nuvoton,npcm-bpc";
+        reg = <0xf0007040 0x20>;
+        interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+        nuvoton,monitor-ports = <0x80>;
+    };
+...
-- 
2.34.1

