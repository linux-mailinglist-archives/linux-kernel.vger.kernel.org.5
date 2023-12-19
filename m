Return-Path: <linux-kernel+bounces-5401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA1C818A48
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D351C24790
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A963F1CA8D;
	Tue, 19 Dec 2023 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I5pFWUvp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66691C2AE;
	Tue, 19 Dec 2023 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5SrdF6skf7fnjDxIRDAqwrmFbn5eAi2vcUE/oNSxmmKYTKNchFupYhxpqQ8z4c0BSjqT+rgtaqV5zhpRGneR9K74q7LJo8uAgs4rX3U5jHEc7Vwe1zbqw0bVypToDAPdefbfY7OrgyoVCBX8z263Vnt5WYkaxwX/s4e54+SvKKg3+/KCvE86uqbq7Xvs8XyuMjPFTqrW6mFdW0eLIBQwVGYHkC91TFzJBuX0O4AfB+BVLQxjyoyUcqqcrbL1h9bPrR+0H+txNJKXd3NLhLNlQ7S2XdsZfMqlvOZL6dF6u/8QQW9InWgLCEPlYrrkGW5YxtMdVxvkZpxRgNekIdAdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJaZ5jmWBXX9tuTCfqiQwZpSdqIc+9R+nKDlMQ+bYyw=;
 b=QiN6gJal1RYsfmW7TbD7zr2J7VlD1g/t/BwqbjcBcmNS9bRbzuEOq7iPC/NmO2tCmvWazY/uJ2QRpIxscbW+bNy7kvGy8/6X5KFDE2kaqpGDq4tZxSmxSDjGG71YjQaCPE3c7rbVB1H9FHOHvl8w4cEeu9Z+ReMv5+B26ra3WVTBdNRX83S+FdvwmS9Er7r2l3G5t1vbPyRa7FfDYHNwjvnZ73fb87P0BLQsxhnyFkTMLuHJzCX0mXopiCJR1oCtlbjZSXKmOUbWwhylTh/c7jt3TKiAGHr3MNfYpZ/xuhaSty7T/kgkTUMLNcCptRxVnqlZeVVG/VDdWv6no2ly6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJaZ5jmWBXX9tuTCfqiQwZpSdqIc+9R+nKDlMQ+bYyw=;
 b=I5pFWUvp84KfQJ8ZMvOrzUl14qJ+kB1SGRnb34BLGCeh0WaKDtqUbeJLyUMiPXUCA+jJOm4+1vNYh6k6Y+3AwiZhhDKnPL3k0HX9wZlMjuL63nSuCDrNusBw+O9a9T8QxHkz0I5PQGExDQnnOIk1sQ7NVSDO6EXgMB5aMD+5qtU=
Received: from CH2PR18CA0042.namprd18.prod.outlook.com (2603:10b6:610:55::22)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 14:41:08 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::ca) by CH2PR18CA0042.outlook.office365.com
 (2603:10b6:610:55::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Tue, 19 Dec 2023 14:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 14:41:08 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 19 Dec
 2023 08:41:06 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krishna Potthuri
	<sai.krishna.potthuri@amd.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Linus Walleij
	<linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-gpio@vger.kernel.org>
Subject: [PATCH] dt-bindings: pinctrl: xilinx: Rename *gpio to *gpio-grp
Date: Tue, 19 Dec 2023 15:41:02 +0100
Message-ID: <2e3a1f1f57cf929bd05115bc081e6d01d5a53443.1702996859.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1575; i=michal.simek@amd.com; h=from:subject:message-id; bh=Ul92XtjmUMbFtE4gmwkva9K4Y+so50w22oxs/Dx05Ik=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTG1TXBpe7xJ01jOb/+bmS9JF90cOXtZJVtB1d/TZfq9 AyXqNTpiGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABM5vZphNtv/Cg1D/otOy/2K 5XVq/mo8PBQuy7BgemTJ2/X/d7a4OqhFKXmmzN11pMUXAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DM4PR12MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: b0f55c64-21b2-4956-c2e2-08dc00a08987
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vh7dEciXUpBl9UAmJ4hYnq4u826YU3YxXZjQLWixwgN/nHpJXHwIuDkA96kf3LtrcW+aaJyO0M5zP4dUnz5KURb6+aAtWou2rR8DKwVvUxzUuP5lZDjoVd0zDaBqElObQPidVT22KHv3IJlLaUSUsfKX4SO+Ai7TP9ej2QU0KQxz1RS5gmj4ztXrTfjaN7zFDTbexMGSeaHU6/9a1tMGvAFmaTKk+xcaKBRugtsIQqAxdVqZOBwieB+xoQH/EshNnrCWeqdAt3Om5wG3J+HuvdvuKHj+HnIupwJ/DJVYVyPuZ5wGg9L1Jhle8H2TsiyBjLTPQA9SmZqusmquaoLGQI82i/pi8pr/ycZoWF58vIQIBj5WQyM0neoPsEJ6dNf6iR90jDQ/DZdHkd2IG4FaFNIx/Nos+Gnbrv26+nwtBrJs1izxbbUrBIcRUf1am9OGJLPfMHxhmAJR5NPE/2N7fXI7uaHaFXKETIVbMZ+ljVPACCgYdAmydVPhkNzbL893uD5EuQ3UPho0kPcOhPnCcoRmcUXBWIQ8YVfS66MZ+bmn5NiU18oeWmQ3O3JREDCRlUz0OF90BlZEvbgPRqRZrODagvlgbOc82GFZNZjXov2SAEDRzxB6V4k/3FDmpmSqPeKDcH3ZjWNKuZrRkOOm8iDbXNGdcnQIoH/4HibeYJvIt0YLifrM3ELDgzIHOCCyAv6HcrJhrIQTvwE299q3BsWfTmokDf++m8dXkGVwFRB8R0JRhf79eOoSadUm2kh1X601pr8OMq1AnnMVaMGS3Vrk6QxYDLLC3mfPblWPNG0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(426003)(16526019)(336012)(2616005)(6666004)(26005)(82740400003)(356005)(81166007)(36756003)(86362001)(8936002)(8676002)(4326008)(478600001)(110136005)(41300700001)(36860700001)(7416002)(5660300002)(2906002)(47076005)(83380400001)(70206006)(44832011)(70586007)(54906003)(316002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 14:41:08.1285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f55c64-21b2-4956-c2e2-08dc00a08987
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937

Anything ending with gpio/gpios is taken as gpio phande/description which
is reported as the issue coming from gpio-consumer.yaml schema.
That's why rename the gpio suffix to gpio-grp to avoid name collision.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.yaml          | 2 +-
 .../devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.yaml
index b85f9e36ce4b..d2676f92ef5b 100644
--- a/Documentation/devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/xlnx,zynq-pinctrl.yaml
@@ -39,7 +39,7 @@ properties:
       phandle to the SLCR.
 
 patternProperties:
-  '^(.*-)?(default|gpio)$':
+  '^(.*-)?(default|gpio-grp)$':
     type: object
     patternProperties:
       '^mux':
diff --git a/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
index 01b6f2b57843..f13d315b5d5e 100644
--- a/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml
@@ -31,7 +31,7 @@ properties:
     const: xlnx,zynqmp-pinctrl
 
 patternProperties:
-  '^(.*-)?(default|gpio)$':
+  '^(.*-)?(default|gpio-grp)$':
     type: object
     patternProperties:
       '^mux':
-- 
2.36.1


