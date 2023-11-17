Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEE97EF72E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 18:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346176AbjKQRnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 12:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjKQRm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 12:42:58 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E054D75;
        Fri, 17 Nov 2023 09:42:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ofah5zIELYSyaMruUUnNRA1tQFhizyGk8weGzZ9xm/djSg68VhCjja0bADaUJf60+raFcEG7JbY6FhIv2aWE4osqr/wlyIj6BK4eWLEtLeOTiOBfwyv0xJAADLD6tDwzzjlS78Cq9TrHWTbj9OaRB2ibrPFzg2UKPccqJsT9W2lbiKihgTezNwwfPL7SOQkIsoSkbDWiwb0G+HsN8nRJTJwtWjgmU8ays3GfjbnKUgHJum0xnBuSuqmoEFXGbcklgGNqaZr142U1gVfKAqryo8FMY3qA0S/D6oxadX+qXpSkAagrKpnlokjMXEDaGY3tlt9PSdukoklpywV2rW/zkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tUn2KAFVldogu7paKZcLTHtNcOirwZYfRJlTriHXSM=;
 b=TtWhq1Jz+fYNikRDRqxsNyY0iY7VC0Q+R3XFJ9s6v0hC3UdBFklUXbJhIjRj4uD9eTOY8iFpdjUbUWoip+BJN9nY4O0XRgrxbjZeH23KVJc9MEodT7jraZBEQuMMHTDVRPyyr7jctVdx44B5/2coK3L30K5uIjZG/C2I/l3f/2usd39Ard1jutkKwG7SuZndTSfAB8xbTam+KRTwDXsHTxTNt4nnKrQURRUx3AVbDHwkBN5Tv5DRz5PQ61c+mKQYv/A4ojPwaSzAgP7Yl23puYRAdZA+Sg8VcPl96q3poijy42tRORPyLRnBPT/fFF7HXs/YX8ndN0Fd3uJPqImbwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tUn2KAFVldogu7paKZcLTHtNcOirwZYfRJlTriHXSM=;
 b=ucpMBa4Ja3FzJcTSgJNcT9HCzsRr3+y4w1bbmbrV910vhi4+L35oYVtUpDNrEAAvq6OyAntqiHTgtFaRxSDql74aN8rXdF7vnBw9P4LPaXpqfSwk/XWDDv9Vh8ToJFMPov5cVO4/hUemS/467xL5XkMi+NgiSY5UxV3d9oT9NC4=
Received: from CY5PR16CA0028.namprd16.prod.outlook.com (2603:10b6:930:10::25)
 by DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.23; Fri, 17 Nov 2023 17:42:48 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:930:10:cafe::f4) by CY5PR16CA0028.outlook.office365.com
 (2603:10b6:930:10::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20 via Frontend
 Transport; Fri, 17 Nov 2023 17:42:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Fri, 17 Nov 2023 17:42:47 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 17 Nov
 2023 11:42:47 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 17 Nov
 2023 09:42:47 -0800
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Fri, 17 Nov 2023 11:42:46 -0600
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <michal.simek@amd.com>,
        <ben.levinsky@amd.com>, <tanmay.shah@amd.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 2/4] dts: zynqmp: add properties for TCM in remoteproc
Date:   Fri, 17 Nov 2023 09:42:36 -0800
Message-ID: <20231117174238.1876655-3-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231117174238.1876655-1-tanmay.shah@amd.com>
References: <20231117174238.1876655-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|DS7PR12MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d746f6-fdaa-4c85-3e69-08dbe7949d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XIsWsXbCxqoRGtqgUIdsWd6s606rhTsnv61IV+pidZmeXRwuOc/eN7us9baoqAf2Vm7Va+1WespQdKpTDo0s0X8SZz8MggEncYZT5sBLufaKoXNGFKp9qnjwdBVfNsfDi4GxW+PUcf9A/Chf9fpbGhzd6jqX+wV75JXpHAlL9obY9pprztSuZa4Vs6A5WPqqujUT2DpjX9UEoOX5gyhrYmywex6hHnRSHcDkO0uGZgBlUP35vjHwnZ/Sh79HhInI1uKgQjaVgYBi+s7LuIne1qsJm7U4R9ZOoJNq9GEpCttufHtWMgQuepH/+xvef5ZEbQSab3CfYK1sqUveMBLTuPJ/DtHq+XCEQEnwnbhLZy4cu8NSVSqPx4H2XuvZOOSS1eMvMgwHyotMgm4Z30BZbhlkcQWWGAbJPUJuNlzpxUbf50uHvBIehxckfvvFSQLN1pv7DEn5+jKg9/3oh2Ub0H8owggX/RDViKCe+AHzyzbXqLZ6ZlhLq6oTXzKbnEYEvqwrzVOeTFQokNPMdaj2EqpIxPtfHJ7FpKdHNe9+YhCy4CIzTl4CUDqYtOiM6pRhzrDS5WZKxGSe1Lkg+1AWlCRAgCC4fGnWfL3qx95TRpENdVPDrXoHYfuLXQ008qitLc3b/NnkL8QHaKUi/OKM+fEU7TxU3mnF+zIf8aPdtwHNVG23gi9qLHqphsS9kxtGfZSUEMogUE6sbfwCNujpvhQT2cSpH+xs4pOch4hS9XLOWQalfUVOqOcrgmQutwLPWvwNi30zRY3TmDfh06RDpw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(2616005)(81166007)(41300700001)(356005)(6666004)(86362001)(36860700001)(478600001)(82740400003)(110136005)(70586007)(70206006)(2906002)(36756003)(1076003)(40480700001)(7049001)(26005)(54906003)(316002)(336012)(426003)(83380400001)(40460700003)(8676002)(5660300002)(8936002)(4326008)(44832011)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 17:42:47.9830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d746f6-fdaa-4c85-3e69-08dbe7949d70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6048
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add properties as per new bindings in zynqmp remoteproc node
to represent TCM address and size.

This patch also adds alternative remoteproc node to represent
remoteproc cluster in split mode. By default lockstep mode is
enabled and users should disable it before using split mode
dts. Both device-tree nodes can't be used simultaneously one
of them must be disabled. For zcu102-1.0 and zcu102-1.1 board
remoteproc split mode dts node is enabled and lockstep mode
dts is disabled.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 .../boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts  |  8 +++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 60 +++++++++++++++++--
 2 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
index c8f71a1aec89..495ca94b45db 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts
@@ -14,6 +14,14 @@ / {
 	compatible = "xlnx,zynqmp-zcu102-rev1.0", "xlnx,zynqmp-zcu102", "xlnx,zynqmp";
 };
 
+&rproc_split {
+	status = "okay";
+};
+
+&rproc_lockstep {
+	status = "disabled";
+};
+
 &eeprom {
 	#address-cells = <1>;
 	#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index b61fc99cd911..602e6aba7ac5 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -247,19 +247,69 @@ fpga_full: fpga-full {
 		ranges;
 	};
 
-	remoteproc {
+	rproc_lockstep: remoteproc@ffe00000 {
 		compatible = "xlnx,zynqmp-r5fss";
 		xlnx,cluster-mode = <1>;
 
-		r5f-0 {
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x20000>,
+			 <0x0 0x20000 0x0 0xffe20000 0x0 0x20000>,
+			 <0x1 0x0 0x0 0xffe90000 0x0 0x10000>,
+			 <0x1 0x20000 0x0 0xffeb0000 0x0 0x10000>;
+
+		r5f@0 {
+			compatible = "xlnx,zynqmp-r5f";
+			reg = <0x0 0x0 0x0 0x20000>, <0x0 0x20000 0x0 0x20000>;
+			reg-names = "atcm", "btcm";
+			power-domains = <&zynqmp_firmware PD_RPU_0>,
+					<&zynqmp_firmware PD_R5_0_ATCM>,
+					<&zynqmp_firmware PD_R5_0_BTCM>;
+			memory-region = <&rproc_0_fw_image>;
+		};
+
+		r5f@1 {
+			compatible = "xlnx,zynqmp-r5f";
+			reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
+			reg-names = "atcm", "btcm";
+			power-domains = <&zynqmp_firmware PD_RPU_1>,
+					<&zynqmp_firmware PD_R5_1_ATCM>,
+					<&zynqmp_firmware PD_R5_1_BTCM>;
+			memory-region = <&rproc_1_fw_image>;
+		};
+	};
+
+	rproc_split: remoteproc-split@ffe00000 {
+		status = "disabled";
+		compatible = "xlnx,zynqmp-r5fss";
+		xlnx,cluster-mode = <0>;
+
+		#address-cells = <2>;
+		#size-cells = <2>;
+
+		ranges = <0x0 0x0 0x0 0xffe00000 0x0 0x10000>,
+			 <0x0 0x20000 0x0 0xffe20000 0x0 0x10000>,
+			 <0x1 0x0 0x0 0xffe90000 0x0 0x10000>,
+			 <0x1 0x20000 0x0 0xffeb0000 0x0 0x10000>;
+
+		r5f@0 {
 			compatible = "xlnx,zynqmp-r5f";
-			power-domains = <&zynqmp_firmware PD_RPU_0>;
+			reg = <0x0 0x0 0x0 0x10000>, <0x0 0x20000 0x0 0x10000>;
+			reg-names = "atcm", "btcm";
+			power-domains = <&zynqmp_firmware PD_RPU_0>,
+					<&zynqmp_firmware PD_R5_0_ATCM>,
+					<&zynqmp_firmware PD_R5_0_BTCM>;
 			memory-region = <&rproc_0_fw_image>;
 		};
 
-		r5f-1 {
+		r5f@1 {
 			compatible = "xlnx,zynqmp-r5f";
-			power-domains = <&zynqmp_firmware PD_RPU_1>;
+			reg = <0x1 0x0 0x0 0x10000>, <0x1 0x20000 0x0 0x10000>;
+			reg-names = "atcm", "btcm";
+			power-domains = <&zynqmp_firmware PD_RPU_1>,
+					<&zynqmp_firmware PD_R5_1_ATCM>,
+					<&zynqmp_firmware PD_R5_1_BTCM>;
 			memory-region = <&rproc_1_fw_image>;
 		};
 	};
-- 
2.25.1

