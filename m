Return-Path: <linux-kernel+bounces-22050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF0682986F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A5328309E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142AC47A48;
	Wed, 10 Jan 2024 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2OfQR/Ax"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C4B47F4C;
	Wed, 10 Jan 2024 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cH3jiY6B7w8nlZii12GpA1Z4Y8pH1E27tECAa7mHUJmt0vA8s+vYsbJe1iqzpTv8PGcHo1G3gMexJrntmmfiJyiTrT7vRDX3YgJ8IdPUSYIQmkB8nm0mb1fuFLDkg52P5A8CrRnIR/mKL9OR49t/sB08pCpQSF2lVhYvWPTKNAVGkf5I7Fqtwx7rQXH1EZxb8LS27N/ZMIho80O+fCpUt53oi9Pb4807f62ZK984J9JexR76kZfAeqIyqx6vPIbt2yNymCUQNc5k4Tfu8wOr31gRRB5QLOCqoErrlxyCHy7sqyg+TNSRfkhCsyyGsQkwUO+t4vXoau2ICkkdYti9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ryzx4qBqBJCq7RdfAaphiPfrmxkQ2zuHY1gruHd8I18=;
 b=Z0OOHC+G5br9dfwKKtWwbgV/ekFngX2XIiytTMUZiZeategM2LZCq6cKgncHcgIAvYl9/tla6sPbH3HakCTjbCdRXJsk8PkYjEUjSx0EkjngK1HtMrp+BMXZhEOoqnQlq8eGHOa6fqSxJATgpanDBw2mj5S0jf9lHXHDsyhISjek06Mes4kEFOnLAHfHQireCdOizM9E08X7j7lGd8C1yK93fthLZHG64U/gTw6hPHHRxBzvxbLlr6OOuAxfU/2hVBQ5H+sKyLHc8dwTC/BgisLsVBv+Zn6zXHiMYdC3VBOWRzDvPMz4UbruF+KLzVWLXKVK9vQ1+k4iHWhfGcxxtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ryzx4qBqBJCq7RdfAaphiPfrmxkQ2zuHY1gruHd8I18=;
 b=2OfQR/Ax0BB6nsP/du/fQ19b7UP0qbZHNeYSjuE1f/k0mdTMLfoMt9MDxMK75Rm/ld5g2O/zols5pfqxpyX4oN8YdiIz1eqr4EX5VyOewS0u7MoN+Tc3E73szAI/mN1SHf+FjCL6x2+79/7HU7nvd01w6Eacs/jZLPVes2E4H2Q=
Received: from CY5PR20CA0026.namprd20.prod.outlook.com (2603:10b6:930:3::23)
 by IA1PR12MB8311.namprd12.prod.outlook.com (2603:10b6:208:3fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.27; Wed, 10 Jan
 2024 11:11:52 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:3:cafe::76) by CY5PR20CA0026.outlook.office365.com
 (2603:10b6:930:3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 11:11:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 11:11:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 05:11:50 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 05:11:50 -0600
Received: from xhdsgoud40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 10 Jan 2024 05:11:45 -0600
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <michal.simek@amd.com>, <gregkh@linuxfoundation.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jirislaby@kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
	<shubhrajyoti.datta@amd.com>, <manion05gk@gmail.com>, Manikanta Guntupalli
	<manikanta.guntupalli@amd.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH V8 1/3] dt-bindings: Add reference to rs485.yaml
Date: Wed, 10 Jan 2024 16:41:05 +0530
Message-ID: <20240110111107.3645284-2-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240110111107.3645284-1-manikanta.guntupalli@amd.com>
References: <20240110111107.3645284-1-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|IA1PR12MB8311:EE_
X-MS-Office365-Filtering-Correlation-Id: 5affdcdd-992a-44e9-0765-08dc11ccf24c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5Xc5yo9xsQ+bK5R++6zUnr4fJjgwUxAsgYKPflFwT1MzdK+FbRD3qNNIHh/Dp+jVQLdryWPcc6BBuFe99B13nV6WdfEsWwNuMP3QOJIq1PQ5AsK9pIOXbWbAU3afZcdpWO+oy0HlMxynVvb1uxJT34esMEHbaxqpM65ZtTpThxf7Jl+tBNSmzvcpQc+miJNeDKGSroF1Eeo3CKscpgMK7cB78KjP80h3tE8wTJ2dOT+ZojOigKx/O2gRSYp6NPXW0qJGyTnQiF2GSLQW11ADyi/FqY9SD2/HGLOZrSAKvYwg79ZNYszeS9u/p885DsFo8rCx8DJZne1Ix21D9/q6sSFrZrBTyMPSHVwr2w/Z3L7XjUlWB6odKU64UQpDOKPs+tkhu57hZLIJUscBwwVVrzfTY8HQF/lkvOH50WxmGeXg9PhmvBAiu7LsrmLTRfGf7KzzavD3KkUXLE6sp+bYBMXE18WquFKJmiLGqnSEBHDopuWlnV3p8UeyolKTOocPjVMV8fe16sTRdIQDpiLkp7bzozcDViEgr87PV9sHUR33rQny+qVdOYU5FNfR8UDWphzWhzjtpEHOShDEhxYAfRlTRbCTHQul0T1jQX1YcfLF4iRB6Ay+y1y3hJgTB4KpeBLqXGaR/ORSwc6DGXk9WSmDC80OlMTVdehsYHq5sVSO3xoZq/+1cyt0p0qOFirBoTo+lVZNiTylu1yrUHinvpAjpbiVmf+ToeppI54pPuMBgN8lh7LQMMUkLFCx26ZskevSeq4Zdekh5eEDU0QD/hz5fZ6EoRXb3U8h0eceX48=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(83380400001)(921011)(41300700001)(70586007)(356005)(36756003)(81166007)(86362001)(70206006)(82740400003)(36860700001)(47076005)(426003)(336012)(1076003)(26005)(2616005)(4326008)(2906002)(110136005)(316002)(478600001)(6666004)(54906003)(8936002)(44832011)(5660300002)(7416002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 11:11:51.4274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5affdcdd-992a-44e9-0765-08dc11ccf24c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8311

Xilinx/AMD Kria SOM KD240 board has a rs485 compatible peripheral.
Update the binding to have rs485 support.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
---
Changes for V2:
Modify optional gpio name to xlnx,phy-ctrl-gpios.
Update commit description.

Changes for V3:
Modify optional gpio name to rts-gpios.
Update commit description.

Changes for V4:
Update rts-gpios description.

Changes for V5:
Remove rts-gpios description.
Update commit message and description.

Changes for V6:
Update commit description.

Changes for V7:
Update commit description.

Changes for V8:
None.
---
 Documentation/devicetree/bindings/serial/cdns,uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
index e35ad1109efc..2129247d7c81 100644
--- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
@@ -55,6 +55,7 @@ required:
 
 allOf:
   - $ref: serial.yaml#
+  - $ref: rs485.yaml#
   - if:
       properties:
         compatible:
-- 
2.25.1


