Return-Path: <linux-kernel+bounces-6670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAF3819BE2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD881C2330D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0C9200DC;
	Wed, 20 Dec 2023 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KOyYKh82"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B512032B;
	Wed, 20 Dec 2023 10:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVyc9ae8rbo+j1Y+84eyLAVi8SI2jSJdOtwvHN1zxj+gZ0PapVz0azBHFVX6oFdXjuPUCq5bLDKK2ksvPduvlV9wlpYOfbr7s3oBoEzQZfqZbBgjl/v+OYset1qgwlPyZFUmtfwI+HYe3IXLKkoUSQIenec+b1Iy2ZzmCnbBFlJB20DEZxzXERy1ItmKjHYWEYkV500m5B2airDduKSTNswxM6jfsvy3/Cc5bfC+Sp3lgweVUVb5PbgPxbPa7IOFLv084DXg+FALpM31vqx6ueZKLZS+J17QSr1y+5moULkutuHttOuCczWbtrRZy0BZLuWV7kcCsCkBVBlDNPn5wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBeAzoK+XFeEEYXku7Z9lSPwszyCdgXT4neuPKnKDXU=;
 b=nEl1Dwqq2eYUTEZbjGqfIeFTgB4eLO7Jh/4KwwapOuY+oJADsHopr00p3mA+Iw/PkGl9hWww6V8H5oBvHxq7xqy6dfrFIp4XDmBwWyoz0khYXeHAon6uOoBelnUqls0kwB13jJXa/MdoNTyHBHv/5XT3+dVFnic0lEVGK6IMRJ1RKDuaogEgSvOuhfWuZo+v89bPjOxi0I7UswDe9rG9B9Uo9dKGc63SOYxZZkwt4UtMKuS0laON8+I+TFXdDMdxhC1Vxp67kJlaWm71rJX43XaWFItW7zRVLOVlJ8zdI65I18g2BZXkeIL0ia/WPW41LfeK/54Bo7goTp3PrA6e4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBeAzoK+XFeEEYXku7Z9lSPwszyCdgXT4neuPKnKDXU=;
 b=KOyYKh823Cve/loTshLjeEIp89Hxj1qo88C4pHI8h1lxRp49xWbbWplgKzTW054G+wEIFHBz/KKDQBpvO66vKcTtvZAlMPp5tASGKHc+88mV7iVt/VlUnToztFw9+j2q5ojLBxqC+flVHMa/dwsIYjxWNacdkK0MIgmkRnx3TDk=
Received: from DS7PR03CA0160.namprd03.prod.outlook.com (2603:10b6:5:3b2::15)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 10:00:47 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:3b2:cafe::1c) by DS7PR03CA0160.outlook.office365.com
 (2603:10b6:5:3b2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 10:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 10:00:47 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 04:00:44 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Mark Brown
	<broonie@kernel.org>, Naman Trivedi Manojbhai
	<naman.trivedimanojbhai@amd.com>, Rob Herring <robh+dt@kernel.org>,
	<devicetree@vger.kernel.org>, kishore Manne <nava.kishore.manne@amd.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 1/4] dt-bindings: firmware: xilinx: Describe missing child nodes
Date: Wed, 20 Dec 2023 11:00:27 +0100
Message-ID: <12d012d7ee372e43142bc4a56b0bbf3cb9c51c34.1703066422.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1703066422.git.michal.simek@amd.com>
References: <cover.1703066422.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2291; i=michal.simek@amd.com; h=from:subject:message-id; bh=ZPIvgY3t3d0PKUZmxhH5gwWzWtE2S52LzfQZZnMhFX8=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtSm3dai+xqiz9xhVlfd/8SlYGU8563lC6f/UeRqfrfCW NP0jf/9jlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjARGU6GBW3rry448KNUrdCS N+TYvrz18t//sDLMZjVUTT44teZsrOzzlLQi7R3nLb/lAAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|CY5PR12MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 931ca60c-90ae-4c6e-7be6-08dc01428a27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bixedIluW3+qTi0BwErBt19AmSjNEHUB+8i7vy/IIgqDockXtlrTHzxoUCNmUMtfrs5cpyeAHn9uYdQA6OF2KcPcJlCCFXhXyxcItSeR7SoKnz2TJlK1+nhxQNRaWq4cf/28Cihuq6UoQZnlP9OU3uEFWDdHFAiXI6aIw8Ye5+XglpkPzJJlhFaDI/19mZW09cubXXW6zuIwkheRfRj/zB7aWf6lggRTU1KKJWCL3T0ipyiOsLbGknopXSe/y+tQBipE++YdCOht6JIPE0flAxCh9N8xwrytQ9zSWypWOkUfwJhxenjGF1DeLiYPZ25GScCj4ayMLB9mu72ukgGhSqkKLQ0CCGMS80s5a5zh53UTVOyStC8O2J/CF4v9pJvfq153sbnsDv1+AgGUo6k0iPO2AeufzjugQgU2KiMEPC1CIeyQ2iEV58qlhGuBPMGkgxxUYPxsqDqH9tRhC/NNVo1pFwlaLR5Tm+jOqHKzLxAm4UWYQzSVakY9OFfWXmHfHDQFZiZqECQ3+dUjslezZxHtAu35j4E92S+PbjTBxvp9lYVx4ouxoOr4KVdOQ6IY3mnmg6Pq2lKVGfxRDawChc1JdIzYDje6ULj5H5Zhs4NdUYHJipBKZcGbdnzIuweEvVpx59OspeIAdiGhaTQst5BK33MfFg1LkpVp5gPbnCKVjlY3hfzzjyImwvu5NLiC7ghOq3Kumg3JnApdi2HJtCTBGEznEGSzttLmjVluTKjwPZHC+Si1vu+dC4Q09yye8o4nBKSucUlMyzaiv7eOuO+Hxi6KN3+cmcr+1ky5soc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(16526019)(6666004)(26005)(426003)(336012)(2616005)(4326008)(83380400001)(5660300002)(47076005)(36860700001)(44832011)(41300700001)(2906002)(7416002)(54906003)(70586007)(70206006)(478600001)(8936002)(8676002)(316002)(36756003)(110136005)(86362001)(82740400003)(81166007)(356005)(40480700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 10:00:47.5830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 931ca60c-90ae-4c6e-7be6-08dc01428a27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527

Firmware node has more than fpga, aes and clock child nodes but also power,
reset, gpio, pinctrl and pcap which are not described yet.
All of them have binding in separate files but there is missing connection
to firmware node that's why describe it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Sort nodes by name
- Rename zynqmp-power to power-controller
- Keep only single patch for easier handling as done in v1

 .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
index 98945220c33c..310c334e88a2 100644
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
+  power-controller:
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
-- 
2.36.1


