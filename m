Return-Path: <linux-kernel+bounces-19781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AD08273CD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA5528237D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FCF524C8;
	Mon,  8 Jan 2024 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4s4y82RU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968D451C51;
	Mon,  8 Jan 2024 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMjKv4mdB2m0tUAKuqiH49Xc4Maueo/d9QDFW4I5LUtQt5spPpa1zjmdHbh5U1ugdHwBwbdstN6Pd5iR6ClIFda9UuRiP0f7JnVC/tL3UubYwpouYsFSz73ygf06dCJSf7ZjjYPo8Od3m3RZue3zLgMri3lFtz10twe3gJ3oGl20MRcFYTQ+9/xViihc/j2roOg0lriKtZj4hI3p906Px3vIywfwyFN1CNDBHHV7uSidcJXMq2G76fq3GAFGhGsC3QBHcsjHm0fk2bFmcUUFLdzRL7elSKZfDiUkdkMFPkd/chFlFCBnsGKirTUyYowmFJsulNMOxLt9mEcvxQP1Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZ0ohL+6IzxyMfWcDl5pYx1mrHNm3da736S74Xq2a8w=;
 b=W4/n1G608vg4slRlaovFubsiFbcp0k4Ls3sxBs1LzdEm+VaSqkc8/M45J/bjqSxYVIYEYwgeU4ZGBastD9yWdaxQQm7mQr8UPZqz7YOSl/XzuX8c6u9UtBK936X4tGIcvA8M4FkzTvOFACSO7tAamoOhhl5j+Sp2DUimL2U1plRhNMwp/cy/xRmRHpJypUv2sOtlbQRYhJLy3MCsZ9Eo5EMju0+wrBJ7O/aqE0RYqM5Bti5ANyMmjoGPzBDrBoDeoHIoAnyFcKv+BeAEZkkYoco7dG89Sk1kPuOZvMrjFNNGdnm2RqnSmEuR6fjFmztbe0g0YOgl13hu3NPcExjZGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZ0ohL+6IzxyMfWcDl5pYx1mrHNm3da736S74Xq2a8w=;
 b=4s4y82RUeeSnI1kRaQeVk6jo62Ga978or9t1gVeGjJrFGoJIMPVknhAyTkUMJkdKb0p0+OUZBlt3uL4Nj9y9shcJPKpXTqWsdO+rSENDAh4B+LJ4+bHTZmkwyNECGXVX7TFFBb9cDGkvjQFn0CUQkmRp0KuIE1wc4J9z+Cn8x8I=
Received: from BL0PR0102CA0018.prod.exchangelabs.com (2603:10b6:207:18::31) by
 BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 15:39:34 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::30) by BL0PR0102CA0018.outlook.office365.com
 (2603:10b6:207:18::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Mon, 8 Jan 2024 15:39:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Mon, 8 Jan 2024 15:39:34 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 09:39:32 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, "moderated list:ARM/ZYNQ ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 01/14] arm64: xilinx: Move address/size-cells to proper locations
Date: Mon, 8 Jan 2024 16:39:12 +0100
Message-ID: <18339ffa3d8c3bf284d9c53ce950beea76516408.1704728353.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1704728353.git.michal.simek@amd.com>
References: <cover.1704728353.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12487; i=michal.simek@amd.com; h=from:subject:message-id; bh=tHFdh5/5mGBHhdVT/x85Z1yspmyrtBHUATzqJapY3+M=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtQ54qof9to2b060lbmmJVqz6Nuagw9KPO7cLth9t3Hbt +zd5+M+dMSyMAgyMciKKbJI21w5s7dyxhThi4flYOawMoEMYeDiFICJGK9lmB85gUHAs2Ud4wKJ Z7fL53Xd3OL51IFhnv4361f6md9vbStUyeIqlvffU5LTAwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|BY5PR12MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d8ee3a-2f31-4ea0-37ec-08dc106003a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2JGczk8iB3AOO9gCVHd0DDvcl+tLdpKQeWYAxIuPyAKffwrPpv589Sr1Z+/rsYEHmZ+jagnPSFk+CCc+SY7ssjVxDIyssp+rKdAZAKoqeDq2dDzpyCROhPAwGFHk+7J3bGKtifubaTZg+sJs2PV3HzPAbZP4YqCvGsfPsdQL6MyQC0Ssmkd52I1tuwjlFqdE0g9fktVXQzZl1vMbwb2NE4dlPxWsGWVvUCKmgqVErYferxqohIQZLDU7VbqJge/MwpH4OXlfaFSL/AANlzwhC7pbsg3Xki60+JX59QUN2RI4YvViKVwpNvZT22cS/Bc2xhLcWScbJYTyyqYEkI3eZXs8eVQq2wBKVMWZWB9szVytdsgDIV/LjnCe5o2djgpK3c54YrgFBtCSu0RulgUrBgBBNaeLcBjC18PxlvRoGmOHAKAMp/23Si5nnqum7TnHofAnrHrxXonaoT+AqTTlNTmt6RcDceurJoa8A4dQxpooqlveuS1MGSc8IumpGVPFNL9M6exwFRzBvq4IFjYtAIpYpdFFICqs5hXIMs+f8Lz3vAUGW+7g7c6aBvNZdbgwdVfleFjduD1t08z2qSxojmWXxtnm8hhl+I3M2ML94N8ciJI9LupxR86sxgZb5YGrkgJ8PG9uC+t8enc8LmYJMLGaiahAk7hVK+1t4TT4fWMh+jyJSkoDXtI3nn39Qj/qv5Q/IHOng61836LktANJaXbfkSHp1izy7kNeqriDml7j0qgv1QfNKBFXBUWAR6wI+PdO2LW870+SwI1cy8iY3nkITk7hNwMajBBIS9oUqWY=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39850400004)(376002)(396003)(346002)(230922051799003)(64100799003)(1800799012)(186009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(81166007)(41300700001)(30864003)(2906002)(5660300002)(82740400003)(54906003)(110136005)(44832011)(40460700003)(36756003)(86362001)(36860700001)(356005)(40480700001)(6666004)(316002)(8676002)(8936002)(4326008)(70206006)(47076005)(70586007)(83380400001)(26005)(478600001)(16526019)(426003)(336012)(2616005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 15:39:34.3428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d8ee3a-2f31-4ea0-37ec-08dc106003a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148

Move cells to board dtsi files from generic zynqmp.dtsi. Changes are
related to qspi, spi, nand, i2c and ethernet
address cells

 make -j8 W=1 dtbs

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts  |  6 ++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts  |  2 ++
 arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts  |  2 ++
 .../boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |  4 ++++
 .../boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    |  8 ++++++++
 .../boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    |  2 ++
 .../boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts    |  2 ++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts  |  2 ++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts  |  6 ++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts  |  4 ++++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts  |  4 ++++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts  |  6 ++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts  |  6 ++++++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts |  2 ++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi             | 14 --------------
 15 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
index 51622896b1b1..5442edede687 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
@@ -129,6 +129,8 @@ mux {
 };
 
 &qspi { /* MIO 0-5 - U143 */
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	spi_flash: flash@0 { /* MT25QU512A */
 		compatible = "jedec,spi-nor"; /* 64MB */
@@ -240,6 +242,8 @@ &sdhci0 { /* MIO13-23 - 16GB emmc MTFC16GAPALBH-IT - U133A */
 };
 
 &spi1 { /* MIO6, 9-11 */
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	label = "TPM";
 	num-cs = <1>;
@@ -251,6 +255,8 @@ tpm@0 { /* slm9670 - U144 */
 };
 
 &i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	bootph-all;
 	clock-frequency = <400000>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
index 04079d1704f1..cbaf6303a17c 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
@@ -38,6 +38,8 @@ &dcc {
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
index 3dec57cf18be..18187b6df3d8 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
@@ -39,6 +39,8 @@ &dcc {
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
index 73491626e01e..986efae8847a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
@@ -118,6 +118,8 @@ &gpu {
 };
 
 &i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -353,6 +355,8 @@ &psgtr {
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* Micron MT25QU512ABB8ESF */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
index f767708fb50d..7599a12b64a5 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
@@ -109,6 +109,8 @@ &gpio {
 };
 
 &i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -132,6 +134,8 @@ rtc@68 {
 };
 
 &nand0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_nand0_default>;
@@ -444,6 +448,8 @@ &rtc {
 };
 
 &spi0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	num-cs = <1>;
 	pinctrl-names = "default";
@@ -464,6 +470,8 @@ partition@0 {
 };
 
 &spi1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	num-cs = <1>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
index f553b317e6b2..17e8a7c3701a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
@@ -103,6 +103,8 @@ &gpio {
 
 /* just eeprom here */
 &i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
index 6ec1d9813973..5ad533cf86ea 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
@@ -171,6 +171,8 @@ &i2c1 {
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index 52f998c22538..b4456e5b5058 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -176,6 +176,8 @@ &gpu {
 };
 
 &i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1_default>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 84952c14f021..55a8d3e9d44f 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -228,6 +228,8 @@ &gpu {
 };
 
 &i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -492,6 +494,8 @@ max20751@73 { /* u96 */
 };
 
 &i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -951,6 +955,8 @@ &psgtr {
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 16MB + 16MB */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index 5084ddcee00f..59a919368094 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -135,6 +135,8 @@ &gpu {
 };
 
 &i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -438,6 +440,8 @@ &psgtr {
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* n25q512a 128MiB */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
index b273bd1d920a..4fe60f22c852 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
@@ -140,6 +140,8 @@ &gpu {
 };
 
 &i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -450,6 +452,8 @@ &psgtr {
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* n25q512a 128MiB */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 50c384aa253e..afc5571bf72b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -240,6 +240,8 @@ &gpu {
 };
 
 &i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -503,6 +505,8 @@ max20751@73 { /* u96 */
 };
 
 &i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -958,6 +962,8 @@ &psgtr {
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 16MB + 16MB */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index 617cb0405a7d..e3e0377d543e 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -200,6 +200,8 @@ &gpu {
 };
 
 &i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -380,6 +382,8 @@ i2c@3 {
 };
 
 &i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	clock-frequency = <400000>;
 	pinctrl-names = "default", "gpio";
@@ -788,6 +792,8 @@ &psgtr {
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor"; /* 16MB + 16MB */
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
index c406017b0348..7386ffb7daeb 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts
@@ -43,6 +43,8 @@ &gpio {
 };
 
 &qspi {
+	#address-cells = <1>;
+	#size-cells = <0>;
 	status = "okay";
 	flash@0 {
 		compatible = "m25p80", "jedec,spi-nor";
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index ea1a9ba16246..a9a23cf50196 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -571,8 +571,6 @@ nand0: nand-controller@ff100000 {
 			clock-names = "controller", "bus";
 			interrupt-parent = <&gic>;
 			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 			iommus = <&smmu 0x872>;
 			power-domains = <&zynqmp_firmware PD_NAND>;
 		};
@@ -653,8 +651,6 @@ i2c0: i2c@ff020000 {
 			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <400000>;
 			reg = <0x0 0xff020000 0x0 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 			power-domains = <&zynqmp_firmware PD_I2C_0>;
 		};
 
@@ -665,8 +661,6 @@ i2c1: i2c@ff030000 {
 			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <400000>;
 			reg = <0x0 0xff030000 0x0 0x1000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 			power-domains = <&zynqmp_firmware PD_I2C_1>;
 		};
 
@@ -718,8 +712,6 @@ qspi: spi@ff0f0000 {
 			num-cs = <1>;
 			reg = <0x0 0xff0f0000 0x0 0x1000>,
 			      <0x0 0xc0000000 0x0 0x8000000>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 			iommus = <&smmu 0x873>;
 			power-domains = <&zynqmp_firmware PD_QSPI>;
 		};
@@ -819,8 +811,6 @@ spi0: spi@ff040000 {
 			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff040000 0x0 0x1000>;
 			clock-names = "ref_clk", "pclk";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			power-domains = <&zynqmp_firmware PD_SPI_0>;
 		};
 
@@ -831,8 +821,6 @@ spi1: spi@ff050000 {
 			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 			reg = <0x0 0xff050000 0x0 0x1000>;
 			clock-names = "ref_clk", "pclk";
-			#address-cells = <1>;
-			#size-cells = <0>;
 			power-domains = <&zynqmp_firmware PD_SPI_1>;
 		};
 
@@ -1005,8 +993,6 @@ ams_pl: ams-pl@400 {
 				compatible = "xlnx,zynqmp-ams-pl";
 				status = "disabled";
 				reg = <0x400 0x400>;
-				#address-cells = <1>;
-				#size-cells = <0>;
 			};
 		};
 
-- 
2.36.1


