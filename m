Return-Path: <linux-kernel+bounces-5374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C85F9818A0B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA812824E2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38181C293;
	Tue, 19 Dec 2023 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wehvg8ni"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316A11D13D;
	Tue, 19 Dec 2023 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6VEXBcI5tkbnAdU/S0Y7L7xRjyCyrSX141LJZoWCUuEMFsD0khIMYGvgDsRFxf7Jk4opBhuvTHsBrCs4Gkp/d/KvStxw6WDRy8/271ngK6nAnAD1ty82AfUszeHVYcfKd5xy0KSncYnmuXyIdUtLv7SAHW3Q30/PLCBw5zl/KA1E4ySQSzSLdWLxslMRLu24mZ1nlZPBR2COYdAbozsvOVkiaHo9uK8zyG6lyPFncRJvni52WLyQhz+dFi410S2FliBjkuFfa0EqUMlVhGqYkj91yFFROf+JvevY/crslC2VbAABkmjlHfu3biPXZ47jNphTur6YjqeluP55+bffA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmis3+f7gAFHFT0ZxqSp9Y13gZmWIHsxt8paGVHhqY8=;
 b=HI/xOnwMqmXL7PGHKdncC81AyQn9hz+zSoYFlK8Q7UP+L898+H6rI+e1hl6w+bNcIIE+YbXqkX1Ep6kUvgqijtQCpXn1ZzrfVjQ6aFcrUKiy8PIbc33ueRNEx8mHYMvjBt6dINjnAFqcuLjVk4KSu5+eLGATjXKe1L4Y7o51rgKUpAYBr2qEVOObDkyuvYo1QYrYhZGLk2xYDb8wLiqT9dRPLGEyqRPUtY5R+ds7cHrdGsX9KBmPuSBoNjgQKkoNVCkKy2dTVhRb8TEnGs5pQc1deH7uPs35WEgYmWfl5NsGz3Tt/NO5utzGnVyA2r8WPfSAXSv4KKurI0hGC1+C8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmis3+f7gAFHFT0ZxqSp9Y13gZmWIHsxt8paGVHhqY8=;
 b=wehvg8nitmKK1dwY71ZhjU7xdHQPYZkIAaai+621gvUO2R1fiHzPrHIgJGyH2AC6Ew6FeifvZbn6umf5AHoqJGLsp3+bvhBB8yboFCE4yTjJWaE7XBxdkxi07nXvHd3bi13mFP2ap5i3v416WHysDzrtqVkC3wXgEa10uGA7JFw=
Received: from DM6PR11CA0030.namprd11.prod.outlook.com (2603:10b6:5:190::43)
 by PH7PR12MB6444.namprd12.prod.outlook.com (2603:10b6:510:1f8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Tue, 19 Dec
 2023 14:31:39 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:190:cafe::e5) by DM6PR11CA0030.outlook.office365.com
 (2603:10b6:5:190::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Tue, 19 Dec 2023 14:31:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 14:31:38 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 19 Dec
 2023 08:31:27 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Mark Brown
	<broonie@kernel.org>, Moritz Fischer <mdf@kernel.org>, "Naman Trivedi
 Manojbhai" <naman.trivedimanojbhai@amd.com>, Rob Herring
	<robh+dt@kernel.org>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Tom
 Rix <trix@redhat.com>, Wu Hao <hao.wu@intel.com>, Xu Yilun
	<yilun.xu@intel.com>, <devicetree@vger.kernel.org>, kishore Manne
	<nava.kishore.manne@amd.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-fpga@vger.kernel.org>
Subject: [PATCH] dt-bindings: firmware: xilinx: Fix versal-fpga node name
Date: Tue, 19 Dec 2023 15:31:25 +0100
Message-ID: <6779af2f9cc21c912f10cf310388d99b980800b2.1702996281.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1782; i=michal.simek@amd.com; h=from:subject:message-id; bh=8EivlOzUeLz8Zukvq9SNXdvylXFXvVgj2HMLZVB7EMQ=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTGldYle34amdzJ+HnjSV3pFv15jLbx/KH6xxVVlJYs2 5s/oTG3I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAExE1YlhQUvz4mDvCYu7dq64 1Xn0cfX+ddWNpxnmSrza9aVG+OSrY6uZixhmTM4MYJPUBQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|PH7PR12MB6444:EE_
X-MS-Office365-Filtering-Correlation-Id: c5451e56-e852-41fe-15a2-08dc009f363c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	G6Wo/3GMoHaE95zosX4FoDeewxf4cyYmC8MlP9F8RfZcb+9rngty5S9blhTp3+WvVLIdS7D0V5VG6Y+EQfmh9biXLEq85H/Gwcpj4BwVWI/O61hDRH8IriAeTW12WOx11GtsagCWisI82yYyZrCgZV3H1IW1Al4xKzZOXlBhMgTa+QhorRDXtEgEteJgYsBh+Fy0bXdimJ3UPIMtoB4vyWN7s+Ek3i0kvJdzrafQ6Vb+B9pCj0CDC5K5DxfQ9bfZ+rvvlth0fue7V2suNgZCb1+aHlj+VjNmrmRHvOrnWb6+eYVrdVeTx2F9CPSnpXvPSemtcSwzXwW8t0G4uQqOjPzRYyqYrqSr/WIolnvYiWNcZX5dEaru/PZE3+QiwiJMXj3tAFO13tMMwvL+7y4QCnubP0doHv1XLhXOCCVnEHq5s4oewGWvEDPIJdseZ1NkArKJ5XPN/MEWH96bRs8WdbNlvwXyTza7/rvhxw76FlAqqR9jD6VAIraCDMWQ111No+mCfx5FdVHcOA56//1LBVRr4VkwsjNfyfjHle8lJdIEFFGIvSHWW2nErDk0jugC0kqDBmk+bSk2IfC77YK66iTYT1jPauFd7sDeRUWoXRif2pg5zmgQmaaNwMoGYq3+HUIZTitxesmsXJZO9P6qF5goJqszz38bEcSjxljHuNOicIPbqlHyydkU+9hg67u4vNVIYarPiy62l4EOsmRLoGG4v4NVeRi+dqCzr35/PZUvat+2JgZsl6dRzojGIYpK6u59T9r8sd0HVJR8wTl0y5BW5Ban33fEtHdvtDTUwc4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(40480700001)(426003)(16526019)(336012)(26005)(2616005)(40460700003)(356005)(47076005)(82740400003)(36756003)(86362001)(83380400001)(44832011)(81166007)(5660300002)(4326008)(36860700001)(8676002)(70586007)(70206006)(8936002)(110136005)(54906003)(316002)(7416002)(41300700001)(2906002)(478600001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 14:31:38.8693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5451e56-e852-41fe-15a2-08dc009f363c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6444

Based on commit 83a368a3fc8a ("docs: dt-bindings: add DTS Coding Style
document") using underscore ('_') in node name is not recommended that's
why switch to dash ('-').

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml        | 4 ++--
 Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
index 8e584857ddd4..3d578f98ae2c 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
@@ -41,7 +41,7 @@ properties:
   "#power-domain-cells":
     const: 1
 
-  versal_fpga:
+  versal-fpga:
     $ref: /schemas/fpga/xlnx,versal-fpga.yaml#
     description: Compatible of the FPGA device.
     type: object
@@ -84,7 +84,7 @@ examples:
       compatible = "xlnx,versal-firmware";
       method = "smc";
 
-      versal_fpga: versal_fpga {
+      versal_fpga: versal-fpga {
         compatible = "xlnx,versal-fpga";
       };
 
diff --git a/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml b/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
index 26f18834caa3..80833462f620 100644
--- a/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
+++ b/Documentation/devicetree/bindings/fpga/xlnx,versal-fpga.yaml
@@ -26,7 +26,7 @@ additionalProperties: false
 
 examples:
   - |
-    versal_fpga: versal_fpga {
+    versal_fpga: versal-fpga {
          compatible = "xlnx,versal-fpga";
     };
 
-- 
2.36.1


