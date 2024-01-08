Return-Path: <linux-kernel+bounces-19791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9802E827401
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1230E1F21531
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970975381B;
	Mon,  8 Jan 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i663QEYn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF314C624;
	Mon,  8 Jan 2024 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxrmKi1iv9XfYIVS7xbvhvk6Wx4LftkUcVHfoyQpgrd4EJOOgQBgEnMeTuyTS4GpmilY0xAO59SUJscIIiNDQNCIiA2UsQ2CngEIq4WglnTTwWmqA0TFyw62Jx0fNP5I5vVuXD5PHrsWQMiDAqEIdKbqigtiWSi2fG96o5HM+FMr0xlaeFOMt1P8/OKhSci+UN4czpbF0gZXvzkNzn5mRfcT+5CMwOtJ2F85bO8+JViRFDfQR7vsuoJVtfgNja5kXkj9I0RMuNwbstMaYVYDJm3ZulF+pffbgKBMOXS1OxiO1WsGEx/FgIHRuCHxZ4SwGTrW28p5y1kUDnya3zUwTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9weKmW2zn68UmmUn3ktLlUy8sLS84EO2BYfDK1WWC4=;
 b=X4o2vae1YO4zb2hkN5mO65j/CmylF37VLjGL3clibwHY4c39FJjeDmFiawV3GoGb43aGtP2rceU+5gsXB8AStmltAAgiwhexT2PlRZ9mRbffzlHj5dX6mhgD3zI+6CIFjxpjvTpRG0zATrUW+x4sqhs3fuokbr/CjBSCxxBBiRFCRK2zKaapSTx+Knk9PhudxowM7+WMuqOTU+JevrB9c5uIBJixZxWYG3j6f/sLN/0DWJMg433aPW66xspWQOhpMZWC2ccbP1/p1bEf2PNZkr3PTCO5HIKh5nPfi4okenlN4TzHEnoCp/4DeMNt6VHWYhBqr6ciDlabW9wgwrEQLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9weKmW2zn68UmmUn3ktLlUy8sLS84EO2BYfDK1WWC4=;
 b=i663QEYng1XM6O5wQ/UhCOpyn5fyHS1Oz319lm8HV/SM29q0Yop+m/bYBVsX1d/vop4cO7WoEODFGiVaza0aiQ//XqR8igZz2DuosxRr1kNaPWd65KpXg5tpFuYsRjGPStIUVGFdfqsoYgLM4m4UAmFCp+O6Ggt+swYzN116LZw=
Received: from BL1PR13CA0279.namprd13.prod.outlook.com (2603:10b6:208:2bc::14)
 by DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 15:40:52 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2bc:cafe::d4) by BL1PR13CA0279.outlook.office365.com
 (2603:10b6:208:2bc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.13 via Frontend
 Transport; Mon, 8 Jan 2024 15:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Mon, 8 Jan 2024 15:40:52 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 09:40:49 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 09/14] arm64: zynqmp: Introduce u-boot options node with bootscr-address
Date: Mon, 8 Jan 2024 16:39:20 +0100
Message-ID: <4f5978d5a26fe0cd0cc6e54a97da1517bb925c01.1704728353.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1704728353.git.michal.simek@amd.com>
References: <cover.1704728353.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1281; i=michal.simek@amd.com; h=from:subject:message-id; bh=jscuwK+ebr2Wzh+zNIl0ZcvuTuhnM0wf55WwuaHeZ3E=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQ54hrz0vk5OlpnCQYwfDz91W2t2lGzxczb7N9+nXxO9 Wc2V714RywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZhI3nOGBf0MLxvyfxxbG+Nc yJY4Yf+iF7/sQhjmp2kx3vsx9aD0bv3oR73c+1j1/804AQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|DM4PR12MB5149:EE_
X-MS-Office365-Filtering-Correlation-Id: e1834570-3d69-4376-69aa-08dc1060324b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1Xehp9IYq04MNxp2/ati2ZDYuyF+Py29VIbwpwPE4/i8mcaC7a68kpAkme7X2ZmziLLYjuGYomUU5drIKsHL+OEgRkWtcKS7UR1g9Lm1OliPzR7xs/Z1CdpqfRE/WTMz8Tr0T/CucusIkBvCQTyMie5fsV8OhsivECUtHzmFiavfmaFhhA0vk6Mh2e/3861zMQ7K79D5HbNhi6fA2GQoVsW/BwRloKHjZ8UrhszdkpDGqG873V4GrooEHqSVgbsG6eGPS9Z4OzGc7zZsokS9DWRzxKgmP32i139633KdpIXDBSB3vxraOPJQeOTjNLJkRyh5AhLR4d7EYMkdkZmbtC8YGNogtpjDLYsS/RsjiBdZlcRuXsnx8Dno/NU78DNDlXHj+bjfxpbCzHXDrFqCwjJR0dapwuIUjppkUcWePIxL/n0z9yX6c76q/VHPYnBDuj+/ITpK5mwLDiQLE7CH8IHSl8Wf3SSNpJ2YN9fWnu7Q925q0KdSPQ8sBCKk6PpE13OXvTx+KVOsZe4sV4hq38zo5g6IsjoS9KFOd/UuJzI0xNvaoDPmRgng9QYVXGL1kZpqhioMrFtMbbicVuRBYfeFiWZrsaSj77HEwg46Xkv1DBI86pq6WkJWLYtpEo80zB8sr5QQBTwFYpLzjDmzT67zMmurE/VUT7LQQmuzxkl+Vi9XdZizV8JvOSNn75YXZ/Y569RM7tnxBK8TlWKMD6B+o/qjmmwlzsXvmFSNv4NvEwGOu4ggPm5GFAgPEjb054FNil4wUm9NJBV26tWbKqkM7ghpYCnatOGmEt30akM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(82310400011)(40470700004)(46966006)(36840700001)(2906002)(82740400003)(5660300002)(86362001)(81166007)(41300700001)(356005)(16526019)(36860700001)(316002)(54906003)(110136005)(426003)(336012)(8676002)(36756003)(8936002)(47076005)(2616005)(26005)(40460700003)(70586007)(70206006)(40480700001)(478600001)(6666004)(4326008)(44832011)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 15:40:52.5694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1834570-3d69-4376-69aa-08dc1060324b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5149

Add u-boot options node with details about bootscr-address.
c&p description from dtschema/schemas/options/u-boot.yaml:

"Holds the full address of the boot script file. It helps in making
automated flow easier by fetching the 64bit address directly from DT.
Value should be automatically copied to the U-Boot 'scriptaddr' variable.
When it is defined, bootscr-ram-offset property should be ignored.
Actually only one of them should be present in the DT."

Address is generic for all zynqmp boards because all of them have DDR
starting from 0. Custom boards should revisit the location and aligned it
based on their needs.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index f1b0d4a15e76..a1a9c8fd6038 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -24,6 +24,13 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	options {
+		u-boot {
+			compatible = "u-boot,config";
+			bootscr-address = /bits/ 64 <0x20000000>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.36.1


