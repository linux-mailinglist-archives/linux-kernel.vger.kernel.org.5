Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414297A49EE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241557AbjIRMmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241413AbjIRMlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:41:35 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D514FD1;
        Mon, 18 Sep 2023 05:41:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9bKs98HMbe5BQ1newH8rM1FEsMLaHD/PCvlQwu7JyjKd+mFcUg3CveZglBxiIqBPmzpsp7jpIZ2zSaouwll9CLYx/J6i7dVXYnfgMw2W9KPENOgXCS33s1FsJu4BIaoPhpiQKUkC/LSf3xPJ2OCiE07RIcezyopAGmY6jOZqiNWNtS8uPW7aRqSrE8w7Y6sfgA97kB24BoH/p7GGKi8rQaHmO1TCzsM/7+0UGq7mWTZ49cXgeEBxz2ia5Z8G4wztP/83r3K8RfZ2gbkAEJztNsF+UsBPF3AddPSwajburXtDuTqIIixQMcjx3SKlI0aNYHPRLm7y1J9pB1nehZqmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJXRT3ztIiflOx+eTMHYQtm6Jklq83t+FMJIOmcth4E=;
 b=MPpfPzH7mbvErmK7R97TWcMnN/n6sG8CG2JOvQpjgcBWjndDCACRHx1xvCAprcJQ/olMK1UL2iGjCATsLP1hWXv1gEyxbz8tIsVC3OptNJ53zY4UG1TKIMBKQmTqhDaUKhY4CPHzdH1MB469Rfc/1fGNckeYinoGk3NwBoqbmqb1El6GgI6YqnXyZtVHUV3RCPajZo50Swbuy18d/45FlQhnDCauaCQkf2wLAMlUAut1YPTduwMpMkc5gveERlAeFKFmUh8Or6cmwyDGLzw4RzFE75Kn8RziJk/yiY0OOqikhD3G/WQncsKVFadXFHjoY1Swq9ycZtfBDCBtZkjrRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJXRT3ztIiflOx+eTMHYQtm6Jklq83t+FMJIOmcth4E=;
 b=W3WzXiUQp/PoKL9zEjGYZjBn3lWTa/nJkElGLH0yjZGUWUXV/dBbruBBXTO7qrebsP3EUgjPrhhETeOf+2hO84fzGyIMLfTjcAetaZnU2170HbPX62QqcQ9cMluwwrld/UQkVIFZFqSHKQXyKv9u3lEBANSxKCKhm/5GlwehSnc=
Received: from CY8PR10CA0048.namprd10.prod.outlook.com (2603:10b6:930:4b::14)
 by DM6PR12MB5007.namprd12.prod.outlook.com (2603:10b6:5:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 12:41:23 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:4b:cafe::89) by CY8PR10CA0048.outlook.office365.com
 (2603:10b6:930:4b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 12:41:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 12:41:23 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 07:41:21 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        "Radhey Shyam Pandey" <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/6] arm64: xilinx: Do not use '_' in DT node names
Date:   Mon, 18 Sep 2023 14:41:12 +0200
Message-ID: <5137958580c85a35cf6aadd1c33a2f6bcf81a9e5.1695040866.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695040866.git.michal.simek@amd.com>
References: <cover.1695040866.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2003; i=michal.simek@amd.com; h=from:subject:message-id; bh=Gy+/BbGHEGpqv7ZK2vGKUUH1eRUSoRlOluimYPn+Ejg=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlQO14xsnb1vRA/F+Zw3v7Cn9Hr14eOPVl3IbGB+tK1L9 9Usj6ZDHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAiAo8Y5nA03lW9P4lzyhbu dwK7mDUiFOWCshjml9drCmX+Om0VJjvrrrrwfH6NtRwaAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DM6PR12MB5007:EE_
X-MS-Office365-Filtering-Correlation-Id: 45005be9-c8b8-4b12-203e-08dbb84490e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qLAyAaqX1VgX6I4VisyDd+ZZNwGYAgROZHyR+jJTEmZB19dJk5o3HpSovfMnL3bgEmCMvbySQ0BEDXzx9RzC6Z9n2s2JuR2mCXKMNHIXkIosOu16I5xHOykxR8B1Ga07hfKtyo26orpZ7FyYvVDq0ps0LQVvV/iBsX2nduiS7h1yUD8qodUugtiOMsKzU7CkxXHvvHoVo0Kheqnuaeqls600LYiNQBXDYFpB04k117iDL9sTmip0LhVIoKwD5QAZN5pFruZZSvELQMGdpHoq2qEGGS1A5s2gbq3f7IBd0W62Vn/XizPFNff6DMp67tEO0Q5+g8OFVumJ9syQeK43T1pi6HWmDBPvVJmluNGnU3XoNOQcxTiYBLyMq1rB0w01L1z01WfP4FjUOgDg/4UmGFDwExwOAon1E9Uq5q2C1Elj1jr8g+OLH91vshUyf5zoUSqPPjxfB6KTSnqSHF5jUEuhPll2qQVAKzRUqINItmBeH4L/KvufkUKztne/KxN75O9EAfdR8H+Y5vGEg3BlXH3GGWG1hDiQLOVqhM2T5HxzgHELl84qMEY+/XXs2mEzqyFzceAV+o3GhgvdlWUfOQuDOE5hUH8rrW2E9g1bg2bcLQLxc+8Pi2V5C1yHdTETk44SAGigTjXUyJCV9a9rTNagYHedhueCznADc/cUpOhVBpBimcCKCpgd2fLTrOHf5woor6Bmhjn0jdz1drNQt21no2+1AH3XZrS44QWsNdeWymg11Zom4fxf6GwaESpOBuiSa536XgQGzgISplQPPoD95ESd/sZqA7CjW4VYKpY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(1800799009)(82310400011)(186009)(451199024)(40470700004)(36840700001)(46966006)(426003)(336012)(2616005)(16526019)(26005)(83380400001)(44832011)(5660300002)(8936002)(4326008)(8676002)(47076005)(36860700001)(82740400003)(356005)(41300700001)(478600001)(40480700001)(81166007)(6666004)(70206006)(110136005)(316002)(70586007)(54906003)(36756003)(86362001)(2906002)(40460700003)(7416002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 12:41:23.0316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45005be9-c8b8-4b12-203e-08dbb84490e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5007
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Character '_' not recommended in node name. Use '-' instead.
Pretty much run seds below for node names.
s/zynqmp_ipi/zynqmp-ipi/
s/nvmem_firmware/nvmem-firmware/
s/soc_revision/soc-revision/
s/si5335_/si5335-/

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 4 ++--
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi            | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index d0091d3cb764..52f998c22538 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -123,13 +123,13 @@ ina226 {
 		io-channels = <&u35 0>, <&u35 1>, <&u35 2>, <&u35 3>;
 	};
 
-	si5335_0: si5335_0 { /* clk0_usb - u23 */
+	si5335_0: si5335-0 { /* clk0_usb - u23 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <26000000>;
 	};
 
-	si5335_1: si5335_1 { /* clk1_dp - u23 */
+	si5335_1: si5335-1 { /* clk1_dp - u23 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index b61fc99cd911..e50e95cbe817 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -129,7 +129,7 @@ rproc_1_fw_image: memory@3ef00000 {
 		};
 	};
 
-	zynqmp_ipi: zynqmp_ipi {
+	zynqmp_ipi: zynqmp-ipi {
 		bootph-all;
 		compatible = "xlnx,zynqmp-ipi-mailbox";
 		interrupt-parent = <&gic>;
@@ -194,12 +194,12 @@ zynqmp_power: zynqmp-power {
 				mbox-names = "tx", "rx";
 			};
 
-			nvmem_firmware {
+			nvmem-firmware {
 				compatible = "xlnx,zynqmp-nvmem-fw";
 				#address-cells = <1>;
 				#size-cells = <1>;
 
-				soc_revision: soc_revision@0 {
+				soc_revision: soc-revision@0 {
 					reg = <0x0 0x4>;
 				};
 			};
-- 
2.36.1

