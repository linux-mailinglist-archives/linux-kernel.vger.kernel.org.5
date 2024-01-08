Return-Path: <linux-kernel+bounces-19782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E64638273D0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E29E41C211EA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B49452F62;
	Mon,  8 Jan 2024 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cNm4Tk5f"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A17751C51;
	Mon,  8 Jan 2024 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFngOnnxyMdgibVqiyuy8Nh4j06V6yHYVHoNJaQYyWDxNs8Zyxbrs8AkN4IWyqNm8Z1e4LZs6AbKrrdCXMGU3gC3iwFeNIMDeTau/drtHEEMBUsMShR7p5wdPAIjrZLjglVoQotmOQ638tMynBEwxhV6pGNFchnT4963UnGvoDQiz8HfGw2ZM6H6lMYTHvuX7XP+tXHdZpZI8Qpg9nH/q+NUrJdumZsS+b7cc25+U9mqBCYfh+B1CsuELNoI7ZUe2N+KLPs7MLmtPRc/5v5mqZAd24BJ+Zo+IBLaxdNwwCL5WaNUCSIOvr66lWYw/YIvU6Saj+2cTl6xTIgjg5fg0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtdTICBwJImj6z/mBcD7met1g5fjHkm+7jnIlQ6zAxg=;
 b=H8sWvUdB8ZqKhY1FIkLG2X/2qmkKOXn3SE2KUyX6/KTrCFtjGfoXv3XqRM1yAXzEvmE06vmdpKE8ahi+BWkwwL0rArcaHVaM6Q5XZ6fKF7e6c6pr6jwCk4lFhP/i8474XgkE2OaqFh4AcvSdc9T8UTMIWLT4Z+gD7K74n8PEIpN/4V+wlsCkdbWKMOniwKIJEWyc1OTyz+jjkymAUC7MM0vXRyXuV35lCORSH/oiT//OaacsGQFXS632SzMa/d5XU9MpGnLr3TSFLY+gQa378ySTsbHE6nvKjC+pygAGzdl5+0GHNgVp4N296ypLkIf/6RLbu3cpv1nC5WNjFpQmfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtdTICBwJImj6z/mBcD7met1g5fjHkm+7jnIlQ6zAxg=;
 b=cNm4Tk5f3h06G9cwgv4PNCgcTkVdag9ZYsw0byroMUaxS0g2V9Fq8HaRWVAgaBVXA6cb/LswkjPbSKBV3L1ujcPYwyZt4niNFC9VjCNoiVj/chvjw2T1sk0mIZz2HVT+g2usKA4Hzg2C9UWmJIZAIP+svsFovMY7dQixlCiNN2I=
Received: from BL1PR13CA0068.namprd13.prod.outlook.com (2603:10b6:208:2b8::13)
 by MW3PR12MB4377.namprd12.prod.outlook.com (2603:10b6:303:55::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 15:39:38 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::73) by BL1PR13CA0068.outlook.office365.com
 (2603:10b6:208:2b8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.14 via Frontend
 Transport; Mon, 8 Jan 2024 15:39:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.12 via Frontend Transport; Mon, 8 Jan 2024 15:39:38 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 09:39:36 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Neal Frager <neal.frager@amd.com>, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring
	<robh+dt@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 02/14] arm64: zynqmp: Add output-enable pins to SOMs
Date: Mon, 8 Jan 2024 16:39:13 +0100
Message-ID: <9270938b48c8939ac5dca4ac2c59f1c4a8c564d8.1704728353.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1704728353.git.michal.simek@amd.com>
References: <cover.1704728353.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3183; i=michal.simek@amd.com; h=from:subject:message-id; bh=K4Likrju5N6IQT/vTOAqCEGTmbOAXbKQ1ofxxlprE/w=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQ54moefnoJsU/m2K9al791hVvjfwH1yEnbYj6/PHhAK jHllWZMRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZhIczjDXNk1S3/MvROkJX2G YY+OztKnYc0/NzDMlZJhd1waFFZpY3EpJirLhSk3TuIqAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|MW3PR12MB4377:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa912df-158c-46d4-76e5-08dc1060060d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RJbUM0oHlN79pxVwiu0oNkgZ8iDgoUlJZPoGwGcw2yI89QuD8RxL672gIQnUz5UVmuXqtTJuUCuHbggtJ2z3F5ffp2MrEBxOi7N1kh+AFBfHInENCTaPgRYWMbMsReTs+EQCUHpJ7p1syvvc8DDI44vERELdEhkerUMY25j2ldA9HH5xmMOChDEf9LIwpho6wsqFQVE5jF4v3FXsnrNytafLTSGFRW5mRUN8qAgxWUGVPaTj21NW6B820cpXKpLybGE/lBWefVz7vJ26zRgMSiijKHXYpl4VzDM0EPDcRlieXT8ozDKqMjUQ92F+xByszXS38KkUQ6LFPGFISJhXCIx7WYzaA6EmO/4Df8p1kHRCkSdRyEjBrR1mHmqY4CZnPWedTdaVHMUFLZj60qT3LDjXpIVDZl2AkZB2776FA/24VSNZ4BV+15ZKjtkx8eaxE0S9Eo/4Y8LDRKDaIWXIe9eFKCms9GvqAEOR7X3n9cOI/XhdYNb79ZZNcJIBQvxlkU0qmdrzwJQenpuu+ioNPAuMLInayO0o9c0eGQMw+D178gbS+h8P8u9ws9xUcoaMlXVa0KdaPepOIwhLU4eC64JE9gppw6SGheG0cAfEqs9yZvbwhoqkLCvDCzBbDGGHyDNS5inLi/nhGg4C83STdyOd6tUYrfjUbIoJphodAN5tekfmWKTLjxDDcH/STFtjhQ3o2/SNJA8bbjLJXiDKdg7Yoed4gitmu0um80JcEYQLFTh4f9rn42FH5FDAxH6LhMTYE51DBlx3U28HRvipoezf/Zn8Z8hYnnw5/fV0mJ4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(40470700004)(46966006)(36840700001)(47076005)(5660300002)(2906002)(81166007)(41300700001)(36756003)(86362001)(356005)(82740400003)(36860700001)(40460700003)(8936002)(40480700001)(8676002)(4326008)(478600001)(6666004)(70206006)(70586007)(316002)(110136005)(54906003)(426003)(336012)(16526019)(2616005)(44832011)(26005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 15:39:38.3905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa912df-158c-46d4-76e5-08dc1060060d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4377

From: Neal Frager <neal.frager@amd.com>

Now that the zynqmp pinctrl driver supports the tri-state registers, make
sure that the pins requiring output-enable are configured appropriately for
SOMs.

Without it, all tristate setting for MIOs, which are not related to SOM
itself, are using default configuration which is not correct setting.
It means SDs, USBs, ethernet, etc. are not working properly.

In past it was fixed through calling tristate configuration via bootcmd:
usb_init=mw 0xFF180208 2020
kv260_gem3=mw 0xFF18020C 0xFC0 && gpio toggle gpio@ff0a000038 && \
  gpio toggle gpio@ff0a000038

Signed-off-by: Neal Frager <neal.frager@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso | 5 +++++
 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
index 92f4190d564d..e7940067ff3c 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso
@@ -185,6 +185,7 @@ conf-rx {
 		conf-tx {
 			pins = "MIO36";
 			bias-disable;
+			output-enable;
 		};
 
 		mux {
@@ -236,6 +237,7 @@ conf-rx {
 		conf-bootstrap {
 			pins = "MIO71", "MIO73", "MIO75";
 			bias-disable;
+			output-enable;
 			low-power-disable;
 		};
 
@@ -243,6 +245,7 @@ conf-tx {
 			pins = "MIO64", "MIO65", "MIO66",
 				"MIO67", "MIO68", "MIO69";
 			bias-disable;
+			output-enable;
 			low-power-enable;
 		};
 
@@ -251,6 +254,7 @@ conf-mdio {
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
 			bias-disable;
+			output-enable;
 		};
 
 		mux-mdio {
@@ -281,6 +285,7 @@ conf-tx {
 			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
 			"MIO60", "MIO61", "MIO62", "MIO63";
 			bias-disable;
+			output-enable;
 			drive-strength = <4>;
 			slew-rate = <SLEW_RATE_SLOW>;
 		};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
index f88b71f5b07a..f72312926299 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso
@@ -168,6 +168,7 @@ conf-rx {
 		conf-tx {
 			pins = "MIO36";
 			bias-disable;
+			output-enable;
 		};
 
 		mux {
@@ -219,6 +220,7 @@ conf-rx {
 		conf-bootstrap {
 			pins = "MIO71", "MIO73", "MIO75";
 			bias-disable;
+			output-enable;
 			low-power-disable;
 		};
 
@@ -226,6 +228,7 @@ conf-tx {
 			pins = "MIO64", "MIO65", "MIO66",
 				"MIO67", "MIO68", "MIO69";
 			bias-disable;
+			output-enable;
 			low-power-enable;
 		};
 
@@ -234,6 +237,7 @@ conf-mdio {
 			slew-rate = <SLEW_RATE_SLOW>;
 			power-source = <IO_STANDARD_LVCMOS18>;
 			bias-disable;
+			output-enable;
 		};
 
 		mux-mdio {
@@ -264,6 +268,7 @@ conf-tx {
 			pins = "MIO54", "MIO56", "MIO57", "MIO58", "MIO59",
 			"MIO60", "MIO61", "MIO62", "MIO63";
 			bias-disable;
+			output-enable;
 			drive-strength = <4>;
 			slew-rate = <SLEW_RATE_SLOW>;
 		};
-- 
2.36.1


