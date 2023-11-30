Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C597FEC6F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbjK3J7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjK3J7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:59:31 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616DBB2;
        Thu, 30 Nov 2023 01:59:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgec/mTD6B5ldK+u/LWkM4Re3ewSZwCHZjE8FASLjqrRn8yXaeCX8uMKXg0nJv3RJGoqNVexcesxd40+JFORt+sy8avAbU21+TAEEWK49ogLAY9I8+HUvZg8kDTbUuOrOK3ijqGR4rd48zIXFuDeLd/IBf59Buu+WGhVe/65Tt7szjHSoNGN6SKnpb+mspNRFkw97nvsIVWzXY6QQiOnphY5A5yjyb6Os0WGpWJdFxyX7UW6ZKoYzXu7tLIKqnqiuog+aBwSe8CQFq1jqd90gR2ZvxeO9dgZKuAih/KsD3M6azrDQIB/PdILaOD6wR9PQlXu9sMZ8j8vF25Z20HBjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7r7sexIk/V9GGyP+D00wv2FcZ6ezJLBcaeqcAN7nCA=;
 b=hkmxXu5GZfibRQKgdiIB6HQYR8ytoHgloPEtVP16sIzlsT9XP6VA4BwH7a5zowvmisvwuhA0SS+TkaRcxKdYdvve8OV+T7MOFVthjpXoQ6+OpF1AOQIwV+GXBwTO2J0eHsvYNdgR7Vum6ayA8TADWVdSx+58F94Clicml9N5y+9ILo56U29zvCniwulAxCyIjuK5iW7K1rwDXsgzddoCjyGt3d9snxbIeF0WYH9C3USYfMh2rw9gdMhsyO2CwnYPnPfT6s0jPwRf4dKxI0hzl2D0YHthpKG+ZSKQOxu1MUFMb18MWCBrHBGgd0iChCMAkIOHD+ALEBZCWrYCPo9LdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7r7sexIk/V9GGyP+D00wv2FcZ6ezJLBcaeqcAN7nCA=;
 b=Zq1tEmX3LCtgDLipVoIVp1em0WQ8lwM3DcFBKMj63JC9aWMvWEylMSXfjIsLxCC7bnFZYj8h12jd/tHMwCloInAdZwpS9aLbaDRB427dGlyvzpKp5UKPb5hxyHVb3eNx3nI+ffe7Swwpfj+pOaz/Z1xjNRnR2bI9rIElMwWvRyQ=
Received: from CY5PR13CA0018.namprd13.prod.outlook.com (2603:10b6:930::17) by
 PH7PR12MB5619.namprd12.prod.outlook.com (2603:10b6:510:136::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.23; Thu, 30 Nov 2023 09:59:33 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:0:cafe::af) by CY5PR13CA0018.outlook.office365.com
 (2603:10b6:930::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13 via Frontend
 Transport; Thu, 30 Nov 2023 09:59:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Thu, 30 Nov 2023 09:59:32 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 03:59:30 -0600
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
Subject: [PATCH 1/2] arm64: zynqmp: Move fixed clock to / for kv260
Date:   Thu, 30 Nov 2023 10:59:15 +0100
Message-ID: <09060cf0a38f0fc75c14e6d51b2d06c116c3ecef.1701338352.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1701338352.git.michal.simek@amd.com>
References: <cover.1701338352.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3334; i=michal.simek@amd.com; h=from:subject:message-id; bh=Kk6Lf9ceFRIi28VCuu5v35OuYOd1sumLA32KxWNAOyg=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtSMmE9PZl1PMb7g+pE3RvJuQcjkFyqP1vZ3dE4yE9cM/ dvbJTejI5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEykN5FhwfTA5WFTfE1mhL76 /f/hooav6yQkshjmKSd/urSN8XbE0on733H83KavEHhUHwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|PH7PR12MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca1f346-20ce-4c54-ac47-08dbf18b0d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tnSQ1EqysHO+rJRHSDrEvnIfEz9bgL+thr6i/GEoQAtmyrBApMHZPoyZn0cswyK81xjwpUDmxJ/st+M9in4Z2r9AmSq0BnlH9y+OOKz71lQAcaXqcqW0XXXWJSUoevn2I8BYDQSnzbuoKpULtb8WVsdbE3FTdmuB4biyijkY+XG4bPbBmpc6iwkGEcw0VjC5MmJxbG4LKKUlOM5OGfIBCkFAHsBj79N99CznP5U9tTxoerQFjtRpx8zyjwQPCH0/HDNResfsAVQ9TmaGPtxYJvo3wYcp5WOl33hJX48bmYkbmoQ51gGRtYBi17sY3hM0PKndeVNY4bjA/VgetpvTlpCzxzdaNtNgw0NgGZ6/8IBLea6hP4JDHqcF9GOW9cqqRuxA4SG5ki+FKMx4Q5gllmf7cOKn9v7PCrX0k7AZbkjXng7KZ5N9WZRPmuAVSF7I+E7FvDdLkHV0/2y7Gm1QdJbx3umtgfk4o2jZODhGp5NsdSRTru4Zx+WPiZbBNo1XWZaUhZVYuRt4BR/p/13nJTxO2GVsY3DFhLWPR3AZWhBhuHkwJqx7/TD8mz5EggZAuR9UPiP/CKfG9g1v175LjZXksYvWLr8xlqwUktQ9q4Fq4iVPC/8a//FQpzSdOOAm6bEJIYLgCJyZktQ23Lv+eT6RKiZmSYX6rXo9eozgS3RtWDDinbMK0d6SVlB5FTe4WvME0f+0X1nVD+Gkr+G/UjaaUHRi2XtTZN57KIB9KgBFtvxHTe4okmGm+GBiCmFejXRPSH2QgukOjr38mcHGyWB7DPx8ND46ASiRdD6Kfgq0aJPCPqggtERL1RFz1QhHHMurshQWVSi/1OA9KxrxLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(186009)(451199024)(82310400011)(1800799012)(64100799003)(40470700004)(36840700001)(46966006)(81166007)(316002)(356005)(40460700003)(110136005)(2616005)(16526019)(26005)(36756003)(54906003)(426003)(336012)(70586007)(82740400003)(6666004)(70206006)(202311291699003)(478600001)(40480700001)(5660300002)(7416002)(47076005)(44832011)(86362001)(36860700001)(41300700001)(2906002)(83380400001)(8676002)(8936002)(4326008)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 09:59:32.5743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca1f346-20ce-4c54-ac47-08dbf18b0d2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5619
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed clock nodes can't be on the bus because they are missing reg
property. That's why move them to root.
And because it is root it is good to have it as the first node in a file.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 28 ++++++++---------
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 30 +++++++++----------
 2 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
index ae1b9b2bdbee..dee238739290 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
@@ -21,20 +21,7 @@
 /dts-v1/;
 /plugin/;
 
-&i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */
-	#address-cells = <1>;
-	#size-cells = <0>;
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_i2c1_default>;
-	pinctrl-1 = <&pinctrl_i2c1_gpio>;
-	scl-gpios = <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-
-	/* u14 - 0x40 - ina260 */
-	/* u27 - 0xe0 - STDP4320 DP/HDMI splitter */
-};
-
-&amba {
+&{/} {
 	si5332_0: si5332_0 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -72,6 +59,19 @@ si5332_5: si5332_5 { /* u17 */
 	};
 };
 
+&i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1_default>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+
+	/* u14 - 0x40 - ina260 */
+	/* u27 - 0xe0 - STDP4320 DP/HDMI splitter */
+};
+
 /* DP/USB 3.0 and SATA */
 &psgtr {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
index b59e48be6465..73c5cb156caf 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
@@ -16,21 +16,7 @@
 /dts-v1/;
 /plugin/;
 
-&i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */
-	#address-cells = <1>;
-	#size-cells = <0>;
-	pinctrl-names = "default", "gpio";
-	pinctrl-0 = <&pinctrl_i2c1_default>;
-	pinctrl-1 = <&pinctrl_i2c1_gpio>;
-	scl-gpios = <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpio 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-
-	/* u14 - 0x40 - ina260 */
-	/* u43 - 0x2d - usb5744 */
-	/* u27 - 0xe0 - STDP4320 DP/HDMI splitter */
-};
-
-&amba {
+&{/} {
 	si5332_0: si5332_0 { /* u17 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -68,6 +54,20 @@ si5332_5: si5332_5 { /* u17 */
 	};
 };
 
+&i2c1 { /* I2C_SCK C23/C24 - MIO from SOM */
+	#address-cells = <1>;
+	#size-cells = <0>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c1_default>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio 24 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+
+	/* u14 - 0x40 - ina260 */
+	/* u43 - 0x2d - usb5744 */
+	/* u27 - 0xe0 - STDP4320 DP/HDMI splitter */
+};
+
 /* DP/USB 3.0 */
 &psgtr {
 	status = "okay";
-- 
2.36.1

