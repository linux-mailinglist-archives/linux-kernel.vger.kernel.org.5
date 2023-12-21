Return-Path: <linux-kernel+bounces-8330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ECB81B5C7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18AC3286112
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 12:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCCC6E5B6;
	Thu, 21 Dec 2023 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cncQcERW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1871573182;
	Thu, 21 Dec 2023 12:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/YdpUEV5mN9QS3mPvqxK1Y4rL63lP8UOrHfJsYl9byFSea9vh42I3G3apkWTURppk2Regj3VooyJMXPN15EZrTFKn/wlikbnbcTKAR3BtEAKCr+SBm70FZICCs/klzQxjEAgyCW0C4QaqdJeXA7mTl5s+LQwZ0+Miu69cLpSFXQkx+yTQpDTa56PHNg5mQ1KMPDSyeJ132c2gKhpXqJYiEPJCVz2SyTEZyxKjc4PU34RgE98l1Q7+a9gST+Pr9veFcJm4IHl43L/ejLYzp+xwQwVNVeTng/zZyAfajyfrTgY16IPSoVodsHCJZTyazyllmiimvdwX8MK10n/Up1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMi7616qcl1PQeaHO1efvzQDD9ZOZZTtUAIH7N6syMU=;
 b=bsks+dwv+v7AI0i0KGJ3ScIVPaeR40CMTFohUxcFm02PcUsDx9CRWRceEFdsCqEplydKQyHoJZiqe4SJkG6FvR3/XmvjcAEfRl3eqXSewBN5WemT44UiiUCKVQrUzLae7zaNkXh87t83Vfqtqf8hhWo9uU3q9vSCJPlvehrRfg/YlpUIp27PkgNx9wOY7ICmr7cdghiexNviFO4+ToRh3PYHGydygeIhrfxlKwK+hPt4/Z8CHZcEDxKJ4v6ubNDbOMoZ58Z4vYO8JHl5qbA92XNuUVmBi4GhhA1ybJww886dQST7y2e6gcXwZMU0beD7yISsdLmQrW899P+9kiAWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMi7616qcl1PQeaHO1efvzQDD9ZOZZTtUAIH7N6syMU=;
 b=cncQcERWmvsXsBsWwyyFiYQWbAtEJQhSJdaQPR3lVPqkdYjZvo4RNFA40jqtunZoKbgonuze7jZOkv55cb5G6DIlfRAqeZLRX5AyzyeIfBNsUZIwXA1SbPbOkOu7QppwIIhuCVoPtboHUBHIF9w81F81WuaCns8a830YXxt0ce0=
Received: from MW4P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::9) by
 SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 12:28:06 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:8b:cafe::d3) by MW4P221CA0004.outlook.office365.com
 (2603:10b6:303:8b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20 via Frontend
 Transport; Thu, 21 Dec 2023 12:28:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 12:28:05 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 06:28:04 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Naman Trivedi Manojbhai
	<naman.trivedimanojbhai@amd.com>, Rob Herring <robh+dt@kernel.org>, "Wolfram
 Sang" <wsa@kernel.org>, <devicetree@vger.kernel.org>, kishore Manne
	<nava.kishore.manne@amd.com>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 1/4] dt-bindings: firmware: xilinx: Describe missing child nodes
Date: Thu, 21 Dec 2023 13:27:54 +0100
Message-ID: <1d7988cfadf3554d11f0779f96a670b4fd86ce5a.1703161663.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1703161663.git.michal.simek@amd.com>
References: <cover.1703161663.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3079; i=michal.simek@amd.com; h=from:subject:message-id; bh=xeHZ+H+fl1QI3vYy/F3AiECHNJ4UY923yqjJce1+Rs0=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQWfc/0ya9ffJoXt3BT6Ns/TgqTN2+8cblnqimnk3P+7 LXtWYYPO2JZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBE1v5nmO/fYf1PRol3ifyt 7T9Vc5YttV5RNJ1hfqXTH5++3OusX4wX6P03Yws5Xpi1FAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 0369c5c2-de71-4b02-1daa-08dc022048a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kNCm0wc7Vt60DnZlQmuRCDMX8ztqp5M//hdVISFBmEKKZRf2ZrgK2Wu18a8qUnghoH1cz/bKnGDnnJ7YDjdYMwKZ9YR/ML3JRK2yReOY3VhprnN9oE2Qw0l3u4+21xJlVRwPoMMiU2deKfvnrrWljvtknfZJBYpQA0SXOrAiUGcNKn1lVMVZNx4U43RYELPp1tX5VZIfMvyLz08BeXvFnRMTs+FOzLQaftYiJ6YNj7kLLNKOC9wyYYvS/LGU3i5tvQz/z/U+WcsymypAIFJLm8dd3FYHCtmV7VYiHwEswtitKOzQ++V6P8lsNsrFmNILFXK7fxMFwgYXuLsVMbNSnTkDOZPVKf7PGNJdXB5ObDDGcDTZ+lFEaj6APQOzojzH66BZeAwQSPjdq+EBc1HXXC+lQjWOs2/tVuszu5NqlIRsAjlhDJy3BjpzFLlmQq7Ec/YVH7HclTi2Mw7lJ7OjCupUYY2CLfi20+veiFNNw348NMuAsNT3EO8bY6Vzr+Gmfr55aK/eB2gOAYNuT8haLQA1q9QWIOazRC3o282ZARcQv2ncQ++lpqeEiJcToxg5Dkkk5yKFPwVzmazHtv68sW1veeFSOO2eZeO9hhR3WyDNXE4gJi0tbxE+3QeJm+lwOEOVwKs/ATbBIIUDUuXLtC7gamCn1HYvsLLLIJhmWirDRYaF1fTSRBHSqAorO7pbs3/4SVItAvPxqFpiPI+UN6vcHJkOSBiNiOL6SR9OKM+51QpKP9VqZdr2YVr7AbMBnzOQy75sqmkvxPL8WmsUAIPVV1q55VrDcBQGNyWHzYA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(82310400011)(1800799012)(451199024)(186009)(64100799003)(40470700004)(36840700001)(46966006)(2906002)(81166007)(5660300002)(2616005)(70586007)(16526019)(110136005)(54906003)(8676002)(47076005)(36860700001)(40480700001)(8936002)(70206006)(478600001)(44832011)(4326008)(86362001)(82740400003)(356005)(41300700001)(6666004)(26005)(316002)(83380400001)(336012)(426003)(40460700003)(36756003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 12:28:05.8932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0369c5c2-de71-4b02-1daa-08dc022048a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723

Firmware node has more than fpga, aes and clock child nodes but also power,
reset, gpio, pinctrl and pcap which are not described yet.
All of them have binding in separate files but there is missing connection
to firmware node that's why describe it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v3:
- s/power-controller/power-management/g
- extend example

Changes in v2:
- Sort nodes by name
- Rename zynqmp-power to power-controller
- Keep only single patch for easier handling as done in v1

 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
index 98945220c33c..884917edb19d 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
@@ -41,6 +41,37 @@ properties:
   "#power-domain-cells":
     const: 1
 
+  gpio:
+    $ref: /schemas/gpio/xlnx,zynqmp-gpio-modepin.yaml#
+    description: The gpio node describes connect to PS_MODE pins via firmware
+      interface.
+    type: object
+
+  pcap:
+    $ref: /schemas/fpga/xlnx,zynqmp-pcap-fpga.yaml
+    description: The ZynqMP SoC uses the PCAP (Processor Configuration Port) to
+      configure the Programmable Logic (PL). The configuration uses the
+      firmware interface.
+    type: object
+
+  pinctrl:
+    $ref: /schemas/pinctrl/xlnx,zynqmp-pinctrl.yaml#
+    description: The pinctrl node provides access to pinconfig and pincontrol
+      functionality available in firmware.
+    type: object
+
+  power-management:
+    $ref: /schemas/power/reset/xlnx,zynqmp-power.yaml#
+    description: The zynqmp-power node describes the power management
+      configurations. It will control remote suspend/shutdown interfaces.
+    type: object
+
+  reset-controller:
+    $ref: /schemas/reset/xlnx,zynqmp-reset.yaml#
+    description: The reset-controller node describes connection to the reset
+      functionality via firmware interface.
+    type: object
+
   versal-fpga:
     $ref: /schemas/fpga/xlnx,versal-fpga.yaml#
     description: Compatible of the FPGA device.
@@ -73,7 +104,26 @@ examples:
     firmware {
       zynqmp_firmware: zynqmp-firmware {
         #power-domain-cells = <1>;
+        gpio {
+          compatible = "xlnx,zynqmp-gpio-modepin";
+          gpio-controller;
+          #gpio-cells = <2>;
+        };
+        pcap {
+          compatible = "xlnx,zynqmp-pcap-fpga";
+        };
+        pinctrl {
+          compatible = "xlnx,zynqmp-pinctrl";
         };
+        power-management {
+          compatible = "xlnx,zynqmp-power";
+          interrupts = <0 35 4>;
+        };
+        reset-controller {
+          compatible = "xlnx,zynqmp-reset";
+          #reset-cells = <1>;
+        };
+      };
     };
 
     sata {
-- 
2.36.1


