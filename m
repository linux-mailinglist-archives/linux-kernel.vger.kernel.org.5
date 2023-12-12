Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E409A80E8A4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 11:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346134AbjLLKHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 05:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjLLKHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 05:07:08 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01rlnn2044.outbound.protection.outlook.com [40.95.54.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BA8A6;
        Tue, 12 Dec 2023 02:07:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciQQQP42QLFHON8zbqiecCmGzCN2qldiDqlmxcbEjWjWsjuOQUdOiHWhk8tVmZvxBvtBLnU7jQFh7n7yqmD4Yq+FjHvmSzCiPx+OnIf4kSZ/5bM1A4yS73S7DL8bIWGyzrPjqy8xDNtJT2q5ejw/801Hv7QMJhr0WKAEDLW7AvzeCIPsPy49lyyz9Fzh6vHiOUBv0jcYKwDEcwgKIBwzf3HW3tD3xolYOO93jHcC3wOgp/whx/urlCvrD2YwiQBcC5G7mGGGgzRbcnosI4eeTS2baGJHig9czayraf+k6kHR6ThyQCVt+gDfjt0qdE7xoVc8iCT5sqtOF2puvNzfjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALUjWsX9FgdHbt4Zlk1z0xogMsk2bhjqaB1eDM0h8bQ=;
 b=czQTKuf9BOHZu1MKVW5qFSknRmm9idf6ulcXSizY+q4wrDGmfjtS8dChxgouPXp7cbnkLz4w3bZ1oB99LIY4XX+RAOXBLXaYUvFkmsuWCIlf+wWGHoTtuB9UJDd3D9RzKNEEqFKwUp6Ox6ykt/LJ0uCAHurEqtrq4DwIGS9fVnE19OpRvCL1GI1afC3asLl0RWVTJdfqq2Vri7yT1KcrNYp/QMslgVUEyBjOx6Iht292fi+KsSM2SYygc4w4gAP/VLLAnrwoBikLdysrokp9f+eAEWDGtiJhRO9mykLHsv8icR5jVnCZpJgt3g5vj6Uz7Yj0AjI8PALMtT0wxeviDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 211.75.126.7) smtp.rcpttodomain=arndb.de smtp.mailfrom=gmail.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALUjWsX9FgdHbt4Zlk1z0xogMsk2bhjqaB1eDM0h8bQ=;
 b=CBcSRLqJms6q7qAiaDD10hXGYjE8U4FdI6s7nWY4I22q2xfk03BYeKga8DL7hu6JtU5eqkI7nzOrPsclcaa7N/0C81yla3kVfc1DhDlSfedO242JJZ9jd7isgNkbipRcoK+DyswjSI1FFJdZO1uIstFUOo0LixivhsFKyRfGnJo=
Received: from SG2PR04CA0212.apcprd04.prod.outlook.com (2603:1096:4:187::8) by
 SI2PR03MB5969.apcprd03.prod.outlook.com (2603:1096:4:146::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.33; Tue, 12 Dec 2023 10:07:10 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:4:187:cafe::4f) by SG2PR04CA0212.outlook.office365.com
 (2603:1096:4:187::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Tue, 12 Dec 2023 10:07:10 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 211.75.126.7)
 smtp.mailfrom=gmail.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 211.75.126.7 as permitted sender)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Tue, 12 Dec 2023 10:07:09 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 12 Dec
 2023 18:07:08 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 12 Dec 2023 18:07:08 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id 7E0965F5D9;
        Tue, 12 Dec 2023 12:07:07 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <arnd@arndb.de>, <pmenzel@molgen.mpg.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v2 1/3] dt-bindings: soc: nuvoton: Add NPCM BPC
Date:   Tue, 12 Dec 2023 12:07:01 +0200
Message-ID: <20231212100703.3374555-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212100703.3374555-1-tmaimon77@gmail.com>
References: <20231212100703.3374555-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[211.75.126.7];domain=NTHCCAS01.nuvoton.com
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|SI2PR03MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: f2eed293-7fbc-4df2-60d5-08dbfafa1a45
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0vRhsDngQrc75C9mf39qVLQRT1XKC6Erfv0ILSP7oL4/Fbuv592QbIMCOK4G3LOqESb7k2zNRH26cUDTpud6lIIJ+lRSNiGBQlUxajGnTvxT8kmXlL9Mq9QPrqxWIyfOZR5fsHcM6qDr/LPzZLWbNml26QLOT6wRnO1+aTP6pg+PwEzzrj6BKu3ADFuUOtLLzDRFSqRci8BSeqYwkJ4YUxXWLKMEYqHdHNekCY6C91JzDqURfj9VqsvrGCuF1zGC4pJLhH6ObI2aEIoROHM62n3UrNdx0c21WOCtghei2xGSEwqttsG2pmx2b4Z1RvxHRLQlkPtaSHjrmKy6+4gGsit32ksN0RhAG5V/QPx6qcwgggJGNJSevvljTp4+n2ZR56CZx+AZlDAKH+zQYeAexkz86Yh0enyHTHpJAyr8jfjp18gSL+OQIQdsUBHng+idJu2SWMEZqkF1YarANt2v0d72U9j9oHTJGzFBqbvsP0nk2Pef9Vbrj1SS3FFW1sDmE0i6wDH5h2tpPbEDcaK38dkleuro1eymCyczJD7iBaew1staqMhbc+tdb3rGEFhzVPLK4yKdaQF+DMzHWdOOpY5Wv7AJTzTPqq1xwDg6xaXbLvxt4+n7eCSAoixNjguHovJgWiVvGnWj0JTK+/gUC+wd6+uim2aBwGZhZDNFJYnZxeDhjUTLV7snTBjT8l2khG9sQbFCImx5MzB4uVml7CFG/Je4dUF9e8vn6JoelNiSnLF0wtPM7gWOM/WnTJiiQhf1KndoOOnMOmtP2dZ3skh/OhANgG48N62qukG25cTPiKWWwSEQzELKyS6TnZyaQJOE/dGJuc8DuYTIJh3+ew==
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(48200799006)(61400799012)(46966006)(40470700004)(40460700003)(82202003)(26005)(336012)(6266002)(73392003)(2616005)(1076003)(47076005)(4326008)(8676002)(5660300002)(35950700001)(8936002)(41300700001)(7416002)(498600001)(2906002)(966005)(6666004)(110136005)(316002)(54906003)(70206006)(70586007)(55446002)(86362001)(36756003)(82740400003)(76482006)(356005)(81166007)(921008)(40480700001);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 10:07:09.1485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2eed293-7fbc-4df2-60d5-08dbfafa1a45
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5969
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
 .../soc/nuvoton/nuvoton,npcm-bpc.yaml         | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-bpc.yaml

diff --git a/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-bpc.yaml b/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-bpc.yaml
new file mode 100644
index 000000000000..30033cdac8f5
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-bpc.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/nuvoton/nuvoton,npcm-bpc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton BMC NPCM BIOS Post Code (bpc) controller
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
+    enum:
+      - nuvoton,npcm750-bpc
+      - nuvoton,npcm845-bpc
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
+      If present, Enable FIFO capture of the DWord address according to
+      one address setting.
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
+        compatible = "nuvoton,npcm750-bpc";
+        reg = <0xf0007040 0x20>;
+        interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+        nuvoton,monitor-ports = <0x80>;
+    };
+...
-- 
2.34.1

