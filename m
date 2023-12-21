Return-Path: <linux-kernel+bounces-8548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3038981B943
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99B88B22A65
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B5C36095;
	Thu, 21 Dec 2023 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jr3dRwFc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996FB6D6DB;
	Thu, 21 Dec 2023 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wf/2tTm/MvXys4Jm78PyBJ/Xv/x6VKdMhvglIQMCVRQ9Sy/2Hff+XcnQYD8esU9hHYoWL5vGwSQoKrbbtFSLz8uaJW0INpA2Fth3N5lhKSPQHOBr4XBzxKhJm29BSxqR+wt0CqNPGlmY/JOWC5MFKt9TwYWRMPqP/PngqgTgKJgthwbFR20N5YTyus7ZUP5VEtwkzQnD7Q0tkfYJJoTyo5eyvz4N6EcVQr/wKb+emvKrJ4J/DPmmHjbtVPuhg+EWXYqXsSfm/N60BW6Pebsduf+JLlXGkStNi+Rpy9R3ScVBpXgeKNUUZW2VFi9E8VL5xRGrB/FxdoEJ/qBSCJJNWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yhqRe2zRgBJlGOxuFr7YGgmZ53X9RWo+OMauCo2ZxY=;
 b=ofQbWegXMWAKEic4ZaNcPLBA4QKuJ59H4/XYeKlhb7oLBPyBlqXk6xu0aY5Zw7xsIP7gSOD5K+rwMhvEMqD/+o8yc6m14hvo2ObPNK10JpGgbY7A+XrnGchN1aVhhVlawS8XZkDyTzViVtRaNUQssIMzewZYmFjA3VBzREIlNnbhPEcUnF5hHjckSf+9FxE6i0E517caq0/xJYaKfFlkhpZhv/+A9VDAwcfl5Co9huw26YC4efEW4hzwHRZSZqVN+9J6SRCPf5fup91bND6QWZN8ignF56oaf8EAIU740I35IiowIIAQibw14BNb3oH1f+NB6f24kG2UXsr4lSH2UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yhqRe2zRgBJlGOxuFr7YGgmZ53X9RWo+OMauCo2ZxY=;
 b=jr3dRwFcj3HzcdusjSgc8eNxy9p03lu37ZKrsObwcVeSzLmT6I+5r55vIYgJGKPXjeMz9+EUvhhhlgootS04uOCdPjDXPf5zsg6s7+HGfHEC8nnu6+dwdHIeLMkxItYW2e0fEWjRacIfwdPvIsmkUf1HbAOD3P5O2awJBHpItdY=
Received: from PH7PR17CA0017.namprd17.prod.outlook.com (2603:10b6:510:324::13)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 14:05:13 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::12) by PH7PR17CA0017.outlook.office365.com
 (2603:10b6:510:324::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20 via Frontend
 Transport; Thu, 21 Dec 2023 14:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 14:05:13 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 08:05:11 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring
	<robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-serial@vger.kernel.org>
Subject: [PATCH] dt-bindings: serial: Describe ARM dcc interface
Date: Thu, 21 Dec 2023 15:05:09 +0100
Message-ID: <9d7e85914eb1cdb313b28cb019093a84dd9b4773.1703167505.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1647; i=michal.simek@amd.com; h=from:subject:message-id; bh=171JCoMC0LOBZ0zeSM3fyFJhdUksav2JPFhBrG1mMO0=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQWNyFmiVqTvUwyr1T8zwfUhWpnaxbeW8vy6XRU+hzDl PKdEsUdsSwMgkwMsmKKLNI2V87srZwxRfjiYTmYOaxMIEMYuDgFYCJHhBgWdPB/zJmywnWW/enQ xdP13K06PTNWM8xTUT/xYH5WuHZEsAd/0IMHW7mPP5MEAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|SA0PR12MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: 470a9715-b9a5-4bda-c76b-08dc022dda19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Xf872Q4y4t/6/9WBhMsXlx5VrBDlQWjcEG99z3RSMrrWXAjZxdwII8SBxMcRgp4x9SSM6joK72YSE/8cerwweBrgd4ccrfCUi6cy5+yvwvvEwKXuag4jkjPlJQpnMttzxnfuB5YwsUrT0g9sQ10EygvhwaGN+uM0MjvaqYfU6qsZCZLutCl+RYxtmL6IE6X2HDubn9rVi7B1uQ2LW5LnRoOJRRsagrkBNPIWYHBJr6NJYCuUoixr/1i/qFExFJmX/X7gx8Am2miXsiGqLpay1cHBz6vOGxpurMokdqEAyANHCdbBaOcynpWghnSwzbeR3DOSGnnOF3bxqqLuEwHTsjA15eIYjIP1FwwciFI+iFUR/hGlWQ63/vEB6bWdWCia3kHd3BnmxLoL5PWFzpisfd1JAkt3psYO3paWDqe9n8ohR7G6hTFIE7UOWIEUq/dWoMxPI5E3iyvAWgJNbDCCg/augKIuYIWZ3GoNzlBBChGzAbl0uhdDv+O4e980P8Z+RA/I2RcMGMe21SMSFDBvgeqMtuO4ITqrdv///csJ1fb7db7WmBhm/mMZP+wnx7ffwje+dN0hQjXvwmW0Mj8zI6Bc2QWwFApoJ5bGw2ghSKr43YQ0q4v/sukljjjWX/fRbregVdtK6CXzplnMTziDHl0WUrlGxOUxmcNxnmtkCxBbHWscdZMZAEv7bMBarhECa7bStuqZo2HjEN3x66hjBaw4sbVxlJmBRR+KoM8IcwMruz5Hg4rdLDRbEzn3J+D9HJajQqI4kBPg9AE93De+OA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(110136005)(70586007)(70206006)(40480700001)(966005)(54906003)(316002)(8936002)(8676002)(40460700003)(4326008)(44832011)(81166007)(336012)(426003)(82740400003)(47076005)(2616005)(26005)(16526019)(5660300002)(41300700001)(36756003)(86362001)(356005)(2906002)(36860700001)(478600001)(7416002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 14:05:13.5049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 470a9715-b9a5-4bda-c76b-08dc022dda19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384

Debug Communication Channel (DCC) provides the way how to pass data between
target CPU and host via JTAG interface. Every CPU has own interface for
communication via dbgdtrtx_el0 and dbgdtrrx_el0 registers.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

This communication interface is used for flash programming on Xilinx
SOCs from U-Boot.
https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/serial/arm_dcc.c

---
 .../devicetree/bindings/serial/arm,dcc.yaml   | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/arm,dcc.yaml

diff --git a/Documentation/devicetree/bindings/serial/arm,dcc.yaml b/Documentation/devicetree/bindings/serial/arm,dcc.yaml
new file mode 100644
index 000000000000..fd0589356617
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/arm,dcc.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/serial/arm,dcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM DCC (Data communication channel) serial emulation
+
+maintainers:
+  - Michal Simek <michal.simek@amd.com>
+
+description: |
+  ARM DCC (Data communication channel) serial emulation interface available
+  via JTAG can be also used as one of serial line tightly coupled with every
+  ARM CPU available in the system.
+
+properties:
+  compatible:
+    const: arm,dcc
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    serial {
+      compatible = "arm,dcc";
+    };
-- 
2.36.1


