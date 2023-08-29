Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599C178CBF8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237720AbjH2SUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbjH2STi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:19:38 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3F01AE;
        Tue, 29 Aug 2023 11:19:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dm7Z9fuv5k8TGnEn9nsFsdO6KCL1q90PzLIcw1q9YvNqPlIBlp0bWRziAsNvVWk6uND9mtN0dHG9huvGuLfGXf0DFjDGhreVIMbtxMjthMPTwWrZhRsPQHRM0lxO5x6/Xtf2pFzOoNBknM7nI98zg/3POPLwuIU2Uz6pNH6UTX8t7unP4JHOYl3JxIEjkbD1t8+iacnrPpnoCoecOKHr1mzqgA11n6u1ljUPkNpCCodhVSex3E7bafu6moCBzkwZqQTeCjXh+U52623N0UffJMl1tYUsr2Ux09jCpQ+LXl3NetQCpivX27thwc1BI3Z3v73T47m7yi6PS8+ivYnhug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVle+cFPyvkKQhM7IT/y6D9r9t7lxg90ncG3g7OoDYM=;
 b=M9f/U8yskcOGkEzNNJCBRuW4D6NUQFK5VwBrtmmlhMyY+7+942HN/mAJDxQasozUjyFrVhyWxSq0rPApbDuO6HrQOqk2Y6hwBjw0Sb9kDKy/BhmG1X2kSUgAnPuKm/1iHvwYXHxrAILOSMMcZFs+jGk6yTCLjamPy8uXHOm16e+9JPFuhiWKy/zCKmlKW5j5oKYDfYSHuO24J8d0uY6Y31sMF3dUhp9+kjAnHO+Ogi6Gl5dXjDtF7zDHDcBPklV0UPU1v70azneQVE9EiKwoOMKCqdY/S/gmtzZyxtv6DM8NQ1XJjgXaN7rlekV17oIebF3kZbh1mrZ9lNggqL89hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVle+cFPyvkKQhM7IT/y6D9r9t7lxg90ncG3g7OoDYM=;
 b=aDeYfcSpCHohvQVkzr5XxU3d0H2FRuOb6knIxlmjhOSsaVBZz7trkNEcuu58HEdP33o/7/1d2c66sme7uv16kvtGtTB6tKtfZW8bdvezYLpnrF6KXVadUhKRtGEQvVybDvZ6VS8lnNkPE4skPltzhIRnBDvIk/riIFzXHYLnfso=
Received: from BY5PR20CA0032.namprd20.prod.outlook.com (2603:10b6:a03:1f4::45)
 by MW3PR12MB4410.namprd12.prod.outlook.com (2603:10b6:303:5b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36; Tue, 29 Aug
 2023 18:19:30 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::ce) by BY5PR20CA0032.outlook.office365.com
 (2603:10b6:a03:1f4::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35 via Frontend
 Transport; Tue, 29 Aug 2023 18:19:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.16 via Frontend Transport; Tue, 29 Aug 2023 18:19:30 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 13:19:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 11:19:12 -0700
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 29 Aug 2023 13:19:11 -0500
From:   Tanmay Shah <tanmay.shah@amd.com>
To:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@amd.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Ben Levinsky <ben.levinsky@amd.com>,
        "Tanmay Shah" <tanmay.shah@amd.com>
Subject: [PATCH v4 2/3] dts: zynqmp: add properties for TCM in remoteproc
Date:   Tue, 29 Aug 2023 11:18:59 -0700
Message-ID: <20230829181900.2561194-3-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230829181900.2561194-1-tanmay.shah@amd.com>
References: <20230829181900.2561194-1-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|MW3PR12MB4410:EE_
X-MS-Office365-Filtering-Correlation-Id: e0baf756-96a0-49b3-dadd-08dba8bc7cd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CcP7W7aH3WzvEZS8duKxmKMBNSBih2+8by8+fOmQdEXt9wFkpYxRI1PL313Jv30wZ/2rh5vL2qhXA9tB3m/oz3mQw/K+H2/nUsyckI7+9o1fNaoyJSFMpdWYPoPxpyFQ8gc64C8o78RhWEkR7p/WNeYVER96nOdsT1UcC6abZsVF1NdFPadZT1fKC6KcjMo3QpNgGehIwhXa0UH/hTreVTtBp2jZbDrjwOSInYYex6SQXLy9QHZnXqxHdEN5yQBqzpavi/OWlxZiu+YBpyWhD4F5YmurKYX1khCjIjdy7jYEkkYD1lyoclq7H87uubxYappQ5xhqgxjj/FS8i7dleWfCKx+cW4QzNpkdLUhHnb8zE3HohGvVfF/jx0VVt/sqdXjVg13jBSFA/syYjSZRmvgaXELv9XZnuA8pNqg8QbHu1l9nQwgAK7vWY6fsNXs1jX8Yh57ry0VUb+MULMKzASTR4zuK/OXAgc5ZEY3pRgmmwY5x7MpYPPhbTPqb3MKhJOCUTb738KPTE5y2FfUgV4c4lR8tG4wGuWYj7gSh77nzEPJwGZmbkDNgbQes9uTdFrLGJBYHDjGDkZBzGLAiDLcJVxtK4YdrR3mM4cCldbzk+Q3kK1AlAqB11UDRSs+8jBqBNnn1GkQvy1HVKf45KMhawo137f3nlcwffyZbiq2gD7agZnyazYLRP7eADkm//JUXYf1CvI+a4LDNoZVPGL80ezWP6KO9GV/TlINsAJuKozSu7+PmCJtS4awGRnQu04SV5RA4XKS+iXt8CiP2G5Dw9vh15uWWomAnrKZG54U=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(1800799009)(186009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(81166007)(356005)(82740400003)(8936002)(6666004)(478600001)(110136005)(70206006)(70586007)(54906003)(6636002)(316002)(41300700001)(40460700003)(36756003)(26005)(44832011)(5660300002)(8676002)(1076003)(83380400001)(2906002)(2616005)(86362001)(47076005)(40480700001)(36860700001)(336012)(426003)(4326008)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 18:19:30.3112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0baf756-96a0-49b3-dadd-08dba8bc7cd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add properties as per new bindings in zynqmp remoteproc node
to represent TCM address and size.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 28 ++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 153db59dc4b3..4a3110dc074b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -226,19 +226,35 @@ fpga_full: fpga-full {
 		ranges;
 	};
 
-	remoteproc {
+	remoteproc@ffe00000 {
 		compatible = "xlnx,zynqmp-r5fss";
-		xlnx,cluster-mode = <1>;
+		xlnx,cluster-mode = <0>;
 
-		r5f-0 {
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

