Return-Path: <linux-kernel+bounces-19793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B9D827418
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C252860B3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E240253E16;
	Mon,  8 Jan 2024 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2b6LypeX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C485252F7C;
	Mon,  8 Jan 2024 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaLoPf34ft2nOI+Xyen+R0XRzfYCl0cVjlaml/puTAlJ33+Dj0/j3U1pT6Oza3ioOeePutGgl3kwz8miMnS5TGdpfum6wkOTUSmsTpuNqF0Dioe7xKInY89FBCBXGzjZs4vZSNdPTWqxjd0vNXHuiLkXGlFgSH7EfvWBAcSAf07mj9JxfMeV1AxGBnJW18IN+0K8f87qN0xUfnyRXxQX61MGSttIaw3jrJUm1Li++vQbhtW42nWlWi+gQGKamNtJtf+qcFucgTOPiUD55ESGFp23AAwmeBy1ZHAS0zXbsZsi1cob7+5q52q5r6kOz+wXgL1ubin94RjA+DMiXPpd1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saMye7E6RX1JxSucCbivbQymZ5PgCCESf9IwueLxGfE=;
 b=lb67u64gGrPYviLDSwFlT2q7ZmSPeqwHSUhUT7Mp4XGZgib0Ai9c77rRNgN2Ki9EKK0j/KCtucM8Z5+aAyCQQ+08BmuFzA10O8bEP9744d5AIz7mOIF4kjp4teOiFckw6YgL6eAPY66D/P+scaUY92eRH/0CweZ5MZno0tCGIpMCBw6t1b0d9muBU86q5wJI2cmKOK0W1w/nMujrItk5LsUjYMZn9ArOYYXje36VUWPRcKXXXBUa1nR8B1H2Kch5eVd7Ewpav66PXfXgbA4+5ZDeNqDn8O/hGTsWRk25daMVq5c00hf7MbNWyFL5kQKhed+OE6GCreWWbXxsU+vE3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saMye7E6RX1JxSucCbivbQymZ5PgCCESf9IwueLxGfE=;
 b=2b6LypeXib+TivYlHDCYiLk1wkhfh47LvGDdBCp7S5MT57XDC3Ylvt8yGbEuSP4DPFA/krNDx9Oi0qlr6EkLaoQ4lFveXuXbTo2etY78yE+blGiYXnV4TXX8lASiTcyVxvLvHKjr8eIL2QQmHc5Fhkmhh0GtSW5EORDRYJxnEls=
Received: from MN2PR13CA0027.namprd13.prod.outlook.com (2603:10b6:208:160::40)
 by MN0PR12MB5809.namprd12.prod.outlook.com (2603:10b6:208:375::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 15:41:48 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:160:cafe::8) by MN2PR13CA0027.outlook.office365.com
 (2603:10b6:208:160::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.14 via Frontend
 Transport; Mon, 8 Jan 2024 15:41:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Mon, 8 Jan 2024 15:41:48 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 09:41:17 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Conor Dooley
	<conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 11/14] arm64: zynqmp: Disable Tri-state for MIO38 Pin
Date: Mon, 8 Jan 2024 16:39:22 +0100
Message-ID: <9f8a0687be407a8ffad610087074e94ebc4f5982.1704728353.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1704728353.git.michal.simek@amd.com>
References: <cover.1704728353.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2951; i=michal.simek@amd.com; h=from:subject:message-id; bh=NAm3bgwC4tjFVVxRsOzvkT6TFE+17ZLOoBpu26K7LlA=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQ54po3RX4WfJKYceim7neB/MyZG6+f6zrm/oh/wg8nJ Y70Fz0fOmJZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBEXtQyLJgzV2fZYesnwSd3 aZ7U3mF8rS3jySuGOZxmU3dPvGRW9yzDznmGiE56TeW6pQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|MN0PR12MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: c849cb13-e993-4691-e257-08dc106053b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XS5Yhh1iTiyvTxZMWvUxrUT3CBDjwoHsycK/MQzXkhjS9nttUV5IEN0XFYcgZt6v0eaWF1PzqVER4ZYCrJqFNhBOlOsDorSAmKaKVzXmLOY7xgwwn9+yTQt5nkuEEGscWV+MrdIZSDL8PEk09TGv3ByoNfp83sO9hPtho8K0ES3MWGh6ed8/qBW/VxeUO9IZuwJDgBX7jTA7pLNZSNYTT2krODpOZhkvbwu5cKtQVVIh9cFzlTz+CKw1jXeBQzEd5pJyqZQxhJXARoIWO5dqu1SFPkAaN1QyfcHRQyMVMySDNFOb6n3yDO83WP17G31SJq2R02iWF63xdnoNV6KVbnH9PggTXCWh3CqFEsBwTEqlv3acWBe+G0wbPFlcblZ/K7Yetgkm/MpPos5DOvWurJZMNO8Sv6J/lEClakLd4dWtjIV2gYRr9Iu0USr9clvgHmiabnP8IRpTy5sGHj0VVQCd4Ra8WSlAY6qLvnoN6Pv0v16xD0kS1FFe7AX1LCtmer3GplkKNWkhSHHTvGM6VJvZn7fOUMm+dT0wkozqJYq5ktjFCcjeH9bvV2rXFnmFaxKFtCCzuZIb8zirLfvwoeu47nlEhS8DQu3Wvb78LxRnL6NHq/hvQ8RvNwnV/E1CDQF5LL4Yk57oqYSp/Nm1dDZJXVY8dbKuhddb+tDfgTZ8p0nNIS6/BqsMVKsND8laPcKl5IJWv5ICpFEJdpsETyGar39+sqLV4RDbFSW7+TOZoqjoJZDgmqcRpMpSzaRRoZ5asYqpeb0cYXHbQ00SW/jSep56n9MSyPHy5ZewNKY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(1800799012)(186009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(81166007)(41300700001)(4326008)(2906002)(5660300002)(82740400003)(54906003)(110136005)(44832011)(40460700003)(36756003)(86362001)(36860700001)(356005)(40480700001)(6666004)(316002)(8676002)(8936002)(70206006)(47076005)(70586007)(83380400001)(26005)(478600001)(426003)(336012)(16526019)(2616005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 15:41:48.6985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c849cb13-e993-4691-e257-08dc106053b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5809

From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>

gpio38 is used in SOM's kv260 to reset the Ethernet PHY.
At present, HW reset is not working properly as Tri-state 
is enabled for MIO38, causing inappropriate PHY register reads.

Disabled Tri-state for MIO38 to make HW reset work.

Tri-state disable :
ZynqMP> md 0xFF180208 2
ff180208: 00bfe7a3 00000540

Tri-state enable :
ZynqMP> md 0xFF180208 2
ff180208: 00bfe7e3 00000540

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 25 +++++++++++++++++++
 .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 25 +++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
index b7b94254cc09..585b5845a1f4 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
@@ -169,6 +169,25 @@ phy0: ethernet-phy@1 {
 &pinctrl0 {
 	status = "okay";
 
+	pinctrl_gpio0_default: gpio0-default {
+                conf {
+                        groups = "gpio0_38_grp";
+                        bias-pull-up;
+                        power-source = <IO_STANDARD_LVCMOS18>;
+                };
+
+                mux {
+                        groups = "gpio0_38_grp";
+                        function = "gpio0";
+                };
+
+                conf-tx {
+                        pins = "MIO38";
+                        bias-disable;
+                        output-enable;
+                };
+        };
+
 	pinctrl_uart1_default: uart1-default {
 		conf {
 			groups = "uart1_9_grp";
@@ -324,6 +343,12 @@ mux {
 	};
 };
 
+&gpio {
+        status = "okay";
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_gpio0_default>;
+};
+
 &uart1 {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
index 1446c2b19de7..037f0941ba0b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
@@ -152,6 +152,25 @@ phy0: ethernet-phy@1 {
 &pinctrl0 {
 	status = "okay";
 
+	pinctrl_gpio0_default: gpio0-default {
+		conf {
+			groups = "gpio0_38_grp";
+			bias-pull-up;
+			power-source = <IO_STANDARD_LVCMOS18>;
+		};
+
+		mux {
+			groups = "gpio0_38_grp";
+			function = "gpio0";
+		};
+
+		conf-tx {
+			pins = "MIO38";
+			bias-disable;
+			output-enable;
+		};
+	};
+
 	pinctrl_uart1_default: uart1-default {
 		conf {
 			groups = "uart1_9_grp";
@@ -307,6 +326,12 @@ mux {
 	};
 };
 
+&gpio {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio0_default>;
+};
+
 &uart1 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.36.1


