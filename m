Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120737FEC70
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbjK3J7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbjK3J7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:59:33 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D8110F0;
        Thu, 30 Nov 2023 01:59:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5r3O9WTQVNnX+IOYgiEMU8RJIczSn88Vq1K52vGxD65bqoawWirlew+H6EWthN8m/UaZ86xTRrNfbP8MQN3c2KRyVn+3no2iWnJwsi4m11h3TaKrbHM10d9b31bOyG5Rzxx1voJw5A/6qEXwd5BSPWzN0mPp44thIbyb0+XytnZdVPLhsb9aZ6TlEGBe7d8lhZKV5ztztzsfMBPy/xa1WBnA5y8TdPKIlb39mm871OJ5s1PtRdKqB3J95lxi5EQ9WVYdhWjVzJSCunn8yaveE9mZtRNIwsU5FouhmSywf96PvHWSeFqSUdP3nybTIIueKqxJ/QJNhHRVpvjYCv78g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wk196xvgBjRVFxYYMx9HM4LPc9jMSeL/gCs3Tg65vhg=;
 b=MBx3ZiXuvaPfs0Rqx7zpSFz3nOqVZIduDhF59U7w5ZO2bjc0HEBBh1YdY0gOXLssLkiWs+Uy0d8E+pNGMkjlWqrk4tyjSvkZEFdrhrCoBaL6jP14nDzvgXoAucKyDmLyqyeRAyxZD+1ddQRDejWObsFkoLKCVOA5wbSc5MhHVnluJLJP3wKti9WTugV7tiXa3qgiQjVVifDh0FjHvxaHReuyRXxaBTLH6fEJcriuUuGrFjIDeN17j7jucCBjj2gsf1pmLnP7OyvoGjRk3TsDrBG3KvJnAq+MRYsOHVGSWVJk8twnPw2ddxmAdyyCcO4WIj4rXde9smhw4gse5S2cGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wk196xvgBjRVFxYYMx9HM4LPc9jMSeL/gCs3Tg65vhg=;
 b=dQsKSNObuq7Lqx1+3Z+kg4g6pqXL8XNYlEzG1g/yjTKvqsKGxSa68m29airxxBVwJkNHNhezvIW76e2kSPRNlHh/yHRF+wn2b0YLQKazNJ49ipeoFflGJDCmlw6lfR0fDjRYfK8/SPwAvMbz+Hs83CykIbj3oi4X0Cbf7cnFjVk=
Received: from CYZPR10CA0008.namprd10.prod.outlook.com (2603:10b6:930:8a::18)
 by BY5PR12MB4872.namprd12.prod.outlook.com (2603:10b6:a03:1c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 09:59:36 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::7c) by CYZPR10CA0008.outlook.office365.com
 (2603:10b6:930:8a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Thu, 30 Nov 2023 09:59:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 09:59:35 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 03:59:34 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Andrew Davis <afd@ti.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Harini Katakam <harini.katakam@amd.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/2] arm64: zynqmp: Fix clock node name in kv260 cards
Date:   Thu, 30 Nov 2023 10:59:16 +0100
Message-ID: <7f140e4b7101d722cedc0a1bf1ecd627e93be14c.1701338352.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1701338352.git.michal.simek@amd.com>
References: <cover.1701338352.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2978; i=michal.simek@amd.com; h=from:subject:message-id; bh=WPl/8WVBuW+N+PR+bzOnSJqGMTDrZgi5PCX0ITFJ+lc=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtSMmE8bxRnq3vxeeaewRu7H3I0WrZ/65p3We5Gvn3ku9 9Sa+BnSHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAi4YcYFvQslUwy+PXCe1LA sUvHLn1zN6xwms8wP2j+pWXnS7R60yL3uiX2SFzWYnwSCwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|BY5PR12MB4872:EE_
X-MS-Office365-Filtering-Correlation-Id: 940b8266-8f9d-4cfd-5014-08dbf18b0f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 83DYn7PGUkEWDTi/7Tr/EmJ55gNdwMEXKqCvZ4LLU6kbApLnZOtFQNqqqheC4DpsKZIQOgeJDZJTmwqB+GnblCXhzFRSkBi+toDXn6FBCbhUbZX0H2zNOcso0lQnbWRPuEu7pku3pqMRWkOky7phUkLHuNP6tvMTTx6r7HLryvXp2gHRwgxwsDL033dvul3ZDB75chpzIObfQWdMtOF/xN7/en7i3WXqEtaO5IoRCDJQJ+LyIwiOfgJDIhcTL4aso+QTCmsrN3o/pckar1cMufdDRPh4KZGAiJV6N2UcU9jISqsSyJZFQQdJbTxODH0CFPuvgDErD5EgmYydrIvhpSc96d/MXJUl4qRWxNfcBOkzAb/xsp4GG0oxJp5h4iTSlts7xDdoU06svnGRm/NVHFZzqXYfKIde0Q7RPg2RjpyGKxP2d5ePquyG/ciHutxYNn8ceKheuK+p1WDG7BkiMh5KUag9/AbmYsIX4ZeCvnxAdEeTfZlO470SBbUsvjHdqDEluCt4iPhZAkpgieQW9aS00+0Jzpi2/cB7eYzZI6T3RQm9UZYc3vvFsUOWvKdZkAsFUASOcOWTzwX1NeO/8s4In8aaXunJxdY2pnQrUUHWY7YWUmVzayjNglQY/xfIaUv56N9kV3V8rfT+ybGnbAZbYJXthh/YwsGXTQ7KhjG5AmmU6r5zYpJdJbHzOysVTH3MvSczIwOQutDp1RmNlRTvKH4voEkB2cqhYa1rsn0vrx08CG/6xZvuM1g8g6VCGEzCHVgk/ANVW9NPsRbjswSxU/BaaZZViMQQ1hCtrDV+GMPKtVDRZZ2UfTiC9czBXX4L8OKCkzXoWuxYcpvJ5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(26005)(336012)(83380400001)(426003)(6666004)(2616005)(36860700001)(47076005)(44832011)(5660300002)(4326008)(8676002)(8936002)(41300700001)(7416002)(478600001)(2906002)(316002)(110136005)(16526019)(54906003)(70206006)(70586007)(202311291699003)(86362001)(36756003)(81166007)(82740400003)(356005)(40480700001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 09:59:35.9601
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 940b8266-8f9d-4cfd-5014-08dbf18b0f31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4872
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

node name shouldn't use '_' that's why convert it to '-'.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 12 ++++++------
 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
index dee238739290..92f4190d564d 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
@@ -22,37 +22,37 @@
 /plugin/;
 
 &{/} {
-	si5332_0: si5332_0 { /* u17 */
+	si5332_0: si5332-0 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <125000000>;
 	};
 
-	si5332_1: si5332_1 { /* u17 */
+	si5332_1: si5332-1 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <25000000>;
 	};
 
-	si5332_2: si5332_2 { /* u17 */
+	si5332_2: si5332-2 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <48000000>;
 	};
 
-	si5332_3: si5332_3 { /* u17 */
+	si5332_3: si5332-3 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <24000000>;
 	};
 
-	si5332_4: si5332_4 { /* u17 */
+	si5332_4: si5332-4 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <26000000>;
 	};
 
-	si5332_5: si5332_5 { /* u17 */
+	si5332_5: si5332-5 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
index 73c5cb156caf..f88b71f5b07a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
@@ -17,37 +17,37 @@
 /plugin/;
 
 &{/} {
-	si5332_0: si5332_0 { /* u17 */
+	si5332_0: si5332-0 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <125000000>;
 	};
 
-	si5332_1: si5332_1 { /* u17 */
+	si5332_1: si5332-1 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <25000000>;
 	};
 
-	si5332_2: si5332_2 { /* u17 */
+	si5332_2: si5332-2 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <48000000>;
 	};
 
-	si5332_3: si5332_3 { /* u17 */
+	si5332_3: si5332-3 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <24000000>;
 	};
 
-	si5332_4: si5332_4 { /* u17 */
+	si5332_4: si5332-4 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <26000000>;
 	};
 
-	si5332_5: si5332_5 { /* u17 */
+	si5332_5: si5332-5 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
-- 
2.36.1

