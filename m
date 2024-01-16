Return-Path: <linux-kernel+bounces-27297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5440582ED77
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3DB285883
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E341B970;
	Tue, 16 Jan 2024 11:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uN/mJWor"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1861B7F9;
	Tue, 16 Jan 2024 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHWvPc0gpyZbQ+oXydBT7fD/kwHTrWRdufLuUMesAhRn5g1Rk03wcJlPTAkEybwWZxUUZJHwqloIPq+jj3kalwUUnLmJHiuE1UT7lIfBqw/IjZCudRQJThz4kPwIKhsnjeBY5ynoqsspLViEp6zQUvSMRWbevm1/14I6G4JGKvQgQgb3O3KgPDjBeDXFCJ0p3yVmUJVl6QWyuisLfzZkCLjnsF9Y5m3As0ubR9mLRhlfVbSkdEuC5+52mAvE8ovmtwNvo7peRPq2IuAVz+4QwBLo65uQy8xG21fXidZzQsjX7fSXlo4P5JOKjv88QuPaz+z0Xgl9Jqz5jRgGFgcvbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0U9VRIQx+vPXjn+OJUoWxqYhd9p4A/qVSO5tg2kI4E=;
 b=NtmNygebqmjlHhIsQg0p/iSRdZwg1sjg3YRKwWsOBs5uGqPEoBi2WlqjOWrdwHxYOfBK6MyYeG5OfJ8XeYdIApDEe3Bz9xDKyUjdnp6XSMS3+IsasyHZv/A6Nm5v9HuUaPhRwCuK/QrdGIiRY/X8z0jxSPnC4fb3Mo0UIaTfRMQOtHj+fS26DyxAUSZC2SYSNnPkd60BLSFOjZ8Kwaim62NymiR8+Holvv05xg8FzLP6ZT2gOcVvPe4pKQc8SwZKqvXPJitSO56uFVgh569jWbsVEPj5voBV1qjkmPoB+wjGniSAZJtUfjJZNMvAhRYO7PyHxFv9V9wOUXPIGP9iHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0U9VRIQx+vPXjn+OJUoWxqYhd9p4A/qVSO5tg2kI4E=;
 b=uN/mJWorlpb77HcZurLRl9dsPogW1T4cyXIJzi1R5YXgkm8GtuRbYcF5vP5XiTkoCQpsb4T2e56cVIJHPy5CisWZ8m6mutSnwpuxxuSdna9UqMg7uZ8Q8j/BqDx9uQxxkg5WkB+zOINO8225BLQjEdMsdm/aBc6afx5B91DDxhs=
Received: from BY3PR04CA0025.namprd04.prod.outlook.com (2603:10b6:a03:217::30)
 by BY5PR12MB4968.namprd12.prod.outlook.com (2603:10b6:a03:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 11:11:45 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::3c) by BY3PR04CA0025.outlook.office365.com
 (2603:10b6:a03:217::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23 via Frontend
 Transport; Tue, 16 Jan 2024 11:11:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 11:11:44 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 05:11:41 -0600
Received: from xirdraganc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 16 Jan 2024 05:11:40 -0600
From: Dragan Cvetic <dragan.cvetic@amd.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>, <michal.simek@xilinx.com>,
	<linux-arm-kernel@lists.infradead.org>, <robh+dt@kernel.org>,
	<mark.rutland@arm.com>, <devicetree@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH 1/2] dt-bindings: misc: xlnx,sd-fec: convert bindings to yaml
Date: Tue, 16 Jan 2024 11:11:34 +0000
Message-ID: <20240116111135.3059-2-dragan.cvetic@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240116111135.3059-1-dragan.cvetic@amd.com>
References: <20240116111135.3059-1-dragan.cvetic@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|BY5PR12MB4968:EE_
X-MS-Office365-Filtering-Correlation-Id: d3aec420-16a6-4fe2-a8d4-08dc1683ece6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wZgvW0GeuOfZ+iWnA0RPKRZpgydCJcConn2eyvcR5rgATQ+gc/M48hGZ/5eGly5S4XHCAGDZIffEnj2BOkK5F6OcIFvRcQc63GaxrHuG8Qt55bHU+3+Je6HoSdwtWE78dCx/SOLG2jeEIfYAGO0FF/VAAkUYamlH3PNzDoWsSjlkkBWjZjF+ynkgIGEtCpu6l+QYde6ObNHLPkPHh8I32/sSIlEW9J5qmVcCtPMck+L+LuSkvyKsXb+bKLMfcvwXn8zmzwBW5/h8JzZ5vFE/o/NgVhi7/esSbk346Cul+RGl4itiuzRlL8RmEEIGqbA5O3HA/eXKfXkN/06WIKjldLMjPNQIkRI2Ec/buSELmeCVZgXit6fxTzNMxfL3WEm+6eOsIOYna7lwn7bBgld6VrmWkwPGojqC+dDJs8Mnvwu74WvSUuBaZuGhsy4NAe8KqDmhfR5wRz2VpqHb/JCBIy3tOs9MGEMF9DJv0XsUJQEJyGuTZ0Y6neMUrWszVZiF9qGIsPBYbQFi7rE1LFwRW8GG/9OJ47jZVCIWb46vW3W3JQx40tBn7XHXsMzlR1kDgDARnBwWs+Pz89TghAkQIB6Q3I5LaGAmtT5ZS69Aa4ZNxg6rth82kZsURokn4vkG9AxFKyCqRqlm2bIoJ0yRHODFSQt79pzCFyL0t8on3FMMUlLjeNl9rscnFH5QytSyZEnHLRkzI4gOIhhd4CF7JndQwlOmCytp7ddOvJ2EkYka4yU/LejPVSKs8rMesKa0ntjnyUc/4bd1RemIINb9F28otgrZKpCtkdX/XvM/qQU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799012)(46966006)(40470700004)(36840700001)(66899024)(2616005)(426003)(6666004)(36756003)(478600001)(966005)(47076005)(36860700001)(41300700001)(26005)(336012)(1076003)(83380400001)(40460700003)(40480700001)(5660300002)(110136005)(70586007)(2906002)(70206006)(44832011)(8936002)(356005)(54906003)(4326008)(8676002)(81166007)(316002)(86362001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 11:11:44.9584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3aec420-16a6-4fe2-a8d4-08dc1683ece6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4968

Convert AMD (Xilinx) sd-fec bindings to yaml format, so it can validate
dt-entries as well as any future additions to yaml.
Conversion txt to yamal is done "one to one", no new changes in txt file
has been made.

Reviewed-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@amd.com>
---
 .../devicetree/bindings/misc/xlnx,sd-fec.txt  |  58 --------
 .../devicetree/bindings/misc/xlnx,sd-fec.yaml | 132 ++++++++++++++++++
 2 files changed, 132 insertions(+), 58 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
 create mode 100644 Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml

diff --git a/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt b/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
deleted file mode 100644
index e3289634fa30..000000000000
--- a/Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
+++ /dev/null
@@ -1,58 +0,0 @@
-* Xilinx SDFEC(16nm) IP *
-
-The Soft Decision Forward Error Correction (SDFEC) Engine is a Hard IP block
-which provides high-throughput LDPC and Turbo Code implementations.
-The LDPC decode & encode functionality is capable of covering a range of
-customer specified Quasi-cyclic (QC) codes. The Turbo decode functionality
-principally covers codes used by LTE. The FEC Engine offers significant
-power and area savings versus implementations done in the FPGA fabric.
-
-
-Required properties:
-- compatible: Must be "xlnx,sd-fec-1.1"
-- clock-names : List of input clock names from the following:
-    - "core_clk", Main processing clock for processing core (required)
-    - "s_axi_aclk", AXI4-Lite memory-mapped slave interface clock (required)
-    - "s_axis_din_aclk", DIN AXI4-Stream Slave interface clock (optional)
-    - "s_axis_din_words-aclk", DIN_WORDS AXI4-Stream Slave interface clock (optional)
-    - "s_axis_ctrl_aclk",  Control input AXI4-Stream Slave interface clock (optional)
-    - "m_axis_dout_aclk", DOUT AXI4-Stream Master interface clock (optional)
-    - "m_axis_dout_words_aclk", DOUT_WORDS AXI4-Stream Master interface clock (optional)
-    - "m_axis_status_aclk", Status output AXI4-Stream Master interface clock (optional)
-- clocks : Clock phandles (see clock_bindings.txt for details).
-- reg: Should contain Xilinx SDFEC 16nm Hardened IP block registers
-  location and length.
-- xlnx,sdfec-code : Should contain "ldpc" or "turbo" to describe the codes
-  being used.
-- xlnx,sdfec-din-words : A value 0 indicates that the DIN_WORDS interface is
-  driven with a fixed value and is not present on the device, a value of 1
-  configures the DIN_WORDS to be block based, while a value of 2 configures the
-  DIN_WORDS input to be supplied for each AXI transaction.
-- xlnx,sdfec-din-width : Configures the DIN AXI stream where a value of 1
-  configures a width of "1x128b", 2 a width of "2x128b" and 4 configures a width
-  of "4x128b".
-- xlnx,sdfec-dout-words : A value 0 indicates that the DOUT_WORDS interface is
-  driven with a fixed value and is not present on the device, a value of 1
-  configures the DOUT_WORDS to be block based, while a value of 2 configures the
-  DOUT_WORDS input to be supplied for each AXI transaction.
-- xlnx,sdfec-dout-width : Configures the DOUT AXI stream where a value of 1
-  configures a width of "1x128b", 2 a width of "2x128b" and 4 configures a width
-  of "4x128b".
-Optional properties:
-- interrupts: should contain SDFEC interrupt number
-
-Example
----------------------------------------
-	sd_fec_0: sd-fec@a0040000 {
-		compatible = "xlnx,sd-fec-1.1";
-		clock-names = "core_clk","s_axi_aclk","s_axis_ctrl_aclk","s_axis_din_aclk","m_axis_status_aclk","m_axis_dout_aclk";
-		clocks = <&misc_clk_2>,<&misc_clk_0>,<&misc_clk_1>,<&misc_clk_1>,<&misc_clk_1>, <&misc_clk_1>;
-		reg = <0x0 0xa0040000 0x0 0x40000>;
-		interrupt-parent = <&axi_intc>;
-		interrupts = <1 0>;
-		xlnx,sdfec-code = "ldpc";
-		xlnx,sdfec-din-words = <0>;
-		xlnx,sdfec-din-width = <2>;
-		xlnx,sdfec-dout-words = <0>;
-		xlnx,sdfec-dout-width = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml b/Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml
new file mode 100644
index 000000000000..05bc01cb5075
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/xlnx,sd-fec.yaml
@@ -0,0 +1,132 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/xlnx,sd-fec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx SDFEC(16nm) IP
+
+maintainers:
+  - Cvetic, Dragan <dragan.cvetic@amd.com>
+  - Erim, Salih <salih.erim@amd.com>
+
+description: |
+  The Soft Decision Forward Error Correction (SDFEC) Engine is a Hard IP block
+  which provides high-throughput LDPC and Turbo Code implementations.
+  The LDPC decode & encode functionality is capable of covering a range of
+  customer specified Quasi-cyclic (QC) codes. The Turbo decode functionality
+  principally covers codes used by LTE. The FEC Engine offers significant
+  power and area savings versus implementations done in the FPGA fabric.
+
+properties:
+  compatible:
+    const: xlnx,sd-fec-1.1
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description: List of clock specifiers.
+    additionalItems: true
+    minItems: 2
+    maxItems: 8
+    items:
+      - description: Main processing clock for processing core.
+      - description: AXI4-Lite memory-mapped slave interface clock.
+      - description: Control input AXI4-Stream Slave interface clock.
+      - description: DIN AXI4-Stream Slave interface clock.
+      - description: Status output AXI4-Stream Master interface clock.
+      - description: DOUT AXI4-Stream Master interface clock.
+      - description: DIN_WORDS AXI4-Stream Slave interface clock
+      - description: DOUT_WORDS AXI4-Stream Master interface clock
+
+  clock-names:
+    additionalItems: true
+    minItems: 2
+    maxItems: 8
+    items:
+      - const: core_clk
+      - const: s_axi_aclk
+      - enum:
+          - s_axis_ctrl_aclk
+          - s_axis_din_aclk
+          - m_axis_status_aclk
+          - m_axis_dout_aclk
+          - s_axis_din_words_aclk
+          - m_axis_dout_words_aclk
+
+  interrupts:
+    maxItems: 1
+
+  xlnx,sdfec-code:
+    description:
+      Should contain "ldpc" or "turbo" to describe the codes being used.
+    $ref: /schemas/types.yaml#/definitions/string-array
+    items:
+      enum: [ ldpc, turbo ]
+
+  xlnx,sdfec-din-width:
+    description: |
+      Configures the DIN AXI stream where a value of 1
+      configures a width of "1x128b", 2 a width of "2x128b" and 4 configures a width
+      of "4x128b".
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 1, 2, 4 ]
+
+  xlnx,sdfec-din-words:
+    description: |
+      A value 0 indicates that the DIN_WORDS interface is
+      driven with a fixed value and is not present on the device, a value of 1
+      configures the DIN_WORDS to be block based, while a value of 2 configures the
+      DIN_WORDS input to be supplied for each AXI transaction.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1, 2 ]
+
+  xlnx,sdfec-dout-width:
+    description: |
+      Configures the DOUT AXI stream where a value of 1 configures a width of "1x128b",
+      2 a width of "2x128b" and 4 configures a width of "4x128b".
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 1, 2, 4 ]
+
+  xlnx,sdfec-dout-words:
+    description: |
+      A value 0 indicates that the DOUT_WORDS interface is
+      driven with a fixed value and is not present on the device, a value of 1
+      configures the DOUT_WORDS to be block based, while a value of 2 configures the
+      DOUT_WORDS input to be supplied for each AXI transaction.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1, 2 ]
+
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - xlnx,sdfec-code
+  - xlnx,sdfec-din-width
+  - xlnx,sdfec-din-words
+  - xlnx,sdfec-dout-width
+  - xlnx,sdfec-dout-words
+
+additionalProperties: false
+
+examples:
+  - |
+    sd-fec@a0040000 {
+        compatible = "xlnx,sd-fec-1.1";
+        reg = <0xa0040000 0x40000>;
+        clocks = <&misc_clk_2>, <&misc_clk_0>, <&misc_clk_1>, <&misc_clk_1>,
+                 <&misc_clk_1>, <&misc_clk_1>;
+        clock-names = "core_clk", "s_axi_aclk", "s_axis_ctrl_aclk",
+                      "s_axis_din_aclk", "m_axis_status_aclk",
+                      "m_axis_dout_aclk";
+        interrupts = <1 0>;
+        xlnx,sdfec-code = "ldpc";
+        xlnx,sdfec-din-width = <2>;
+        xlnx,sdfec-din-words = <0>;
+        xlnx,sdfec-dout-width = <1>;
+        xlnx,sdfec-dout-words = <0>;
+    };
+
-- 
2.17.1


