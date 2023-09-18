Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC357A49F2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241634AbjIRMmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241468AbjIRMlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:41:40 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E031B9F;
        Mon, 18 Sep 2023 05:41:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioG0HXDWapnyAzb2alCQSt8Dp2Xgxeoc2FtAyTTpsYziCVkgIQT/uOWVHdx8UhSJdifppelZfx9aXvmrMyJsCWZfvj3c4C8GwSlWc7J32xnFOPdx01TZOWbiaQwRhlT7J2A0LqQRFrdQFoisdrc0Xh+4bi+IbeZHknk7+MdRppZ6uIu/IFCMpVT4TCQBunStxQNvAyuGq4CmDD3l2et+RqDiJ/ZoGKpWTyS5VywFSdy96ZqwP2oGuakLR7aRParpQEDrwMPsYC1g50KBlb5NH/1X0NFuZbazs7rLTgSNk0UzRGhGaRZSk9lZ8j9M0I1gC+gnl3Wo40aZ0LNo16pEnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8BF4ZJ2zijslDDEk9BF9Ek9ZQthKDQophjkG/J2h28=;
 b=JNSTX4G87vsc3NukZY04Op52JqcCQuBgsqUZdvQ9RrbDOd4iIPuZ22mjR3qBKqV7ZgyF8reo8adXe8LYynJOqHq2EcdDjwOLhPdcL2muwBbvkIVp8lBmZZSGb6U+DIJ92feIGzaNmna4zzTBamAw5IYhhxR3T/kxErBLKddX4LFT3IGEWBzeBVqUB8VUy9+8NTbFOpIy2zqETCOdTXm25guj8XAk1JKSiTqposBhpOO7aNejS6pAIidnZeEdhQDBOAon/VhVGmyJLOJEK+7FyfQyY1fvMJB++zQKWcJ/gFSXYWdDbMlWDK8QbL1t08567EBUu1XF4aPAyj8BfzTedA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8BF4ZJ2zijslDDEk9BF9Ek9ZQthKDQophjkG/J2h28=;
 b=Mcg47sPJPg6fQyDBYW2N0+gb7IYzWrpICmdqlvFUcjNEdI2jqO5x4U9PTNMxLhe1aTp7PrB16BDFBf8EmkaEkCyeNiRU0DPy846Sx4kTLNH363CLqvfgPxn9XlsxarRnt8fzHXPa87Ne5GF1fPfcghl9D0EH7fR7Ov5eGqlhheY=
Received: from DS7PR03CA0219.namprd03.prod.outlook.com (2603:10b6:5:3ba::14)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 12:41:31 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::37) by DS7PR03CA0219.outlook.office365.com
 (2603:10b6:5:3ba::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 12:41:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 12:41:31 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 07:41:29 -0500
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>,
        Conor Dooley <conor+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
        Parth Gajjar <parth.gajjar@amd.com>,
        "Piyush Mehta" <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Vishal Sagar" <vishal.sagar@amd.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 4/6] arm64: xilinx: Put ethernet phys to mdio node
Date:   Mon, 18 Sep 2023 14:41:15 +0200
Message-ID: <dc228a27579b48f3e768fcb439d118b4a0f0ef5b.1695040866.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1695040866.git.michal.simek@amd.com>
References: <cover.1695040866.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4352; i=michal.simek@amd.com; h=from:subject:message-id; bh=CguVKVNCrMXEr2XFc+tOnMLg9/2vSC1htIcg8rJVFbk=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlQO10wHy6dyzS94frmdWbLertxR3i1wQ+MPXrZU++To3 Adv1vzviGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABPpOMIwT2VPQM0hkZ2nE3Mu bb9bwPCATW/iMYYFk1RWaqt6M75MeHT/Dud7Lj/GJDMvAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: 62a0af49-2d0e-4984-42fb-08dbb84495ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SGviowWfz0FQYM+3PLhWnZdOQM7uZT8vtr2yKDIOgTjB9cRo6NaBUOr4RmTBN78zZjjrmoctJAPSPjHW6w8CbhHKqrtLaNQfygO2xOXGKiD7fJHNNPq/1M7e821rWkFQLGNOnkSC2u3cgGGBfBqIHXlB9ZiBQBHBHueIZcDXscMaobUtP/Jf7HmlbXl3Gtfy4ZYXtVzZ/fcVllLLWNooH9gmqi8bp8KRpX/FW7C9pn3lnTC8szjEmWFmRyBf9GZ/D9cKrC9bnUOVs+SbMSNZjx5/NcEz3cfCbp7FvHbDaj4Aqwm7j+j3mh7VlBLbCPnLuaqlC/dTN2adEdjdVWh8xdhUvNdRk08Cw2IZ0ZrD1AMPTEdO8pddMLmxASON9yF78lhIv1Pg/ICe9ErV1UbTLSO4/zYzwnQp+akhKVdwaqoLXXeTKFOaZGYZfnBybgEtRtgYnFNFVIEz9cgMFHra/uj+BZVONmbGa1Xqw3cv5LPVF7JPxXDkEc2uOe6nGifC5S3RmILb6k64OVDXOPgoasZJRDLlFHR2mpy+uvmZcAQQzpIBm3O7M39JfqZbZ1Fcr1GrTqpVgzeFgrHkTstAYx9c2S3uaa3lSu+JDkZIVMMYnjDecy6LhbD3kW52GbbRwfHrLZZ1OpYkRPAp91QRQOzhwD3nxglflKoKYwAMBgmxnAWKqsLGYY1IcsO4f/o+Udu7yWk0uAKaA+/ALn//rt7F8uutKr90OvjBmH4lsbnLyYeIa/OvCX9HoIX8XVon8KVFlm9Sd3heC9itRghQTdcHNPRs1+5+mGdqinNem7w=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199024)(82310400011)(1800799009)(186009)(36840700001)(40470700004)(46966006)(40480700001)(81166007)(356005)(82740400003)(36756003)(86362001)(40460700003)(478600001)(5660300002)(70206006)(70586007)(54906003)(6666004)(2906002)(8676002)(4326008)(8936002)(44832011)(336012)(426003)(83380400001)(47076005)(41300700001)(7416002)(110136005)(36860700001)(316002)(26005)(16526019)(2616005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 12:41:31.2467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a0af49-2d0e-4984-42fb-08dbb84495ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All zynqmp boards have been already described via mdio node that's why also
convert zc1751. With using mdio node there is an option to add reset
property for the whole mdio bus.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |  8 ++++--
 .../dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    | 16 +++++++-----
 .../dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    |  8 ++++--
 .../dts/xilinx/zynqmp-zc1751-xm018-dc4.dts    | 26 +++++++++++--------
 .../dts/xilinx/zynqmp-zc1751-xm019-dc5.dts    |  8 ++++--
 5 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
index e821d55d8d5a..73491626e01e 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
@@ -98,8 +98,12 @@ &gem3 {
 	phy-mode = "rgmii-id";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gem3_default>;
-	phy0: ethernet-phy@0 {
-		reg = <0>;
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
 	};
 };
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
index b59e11316b4b..f767708fb50d 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
@@ -91,12 +91,16 @@ &gem2 {
 	phy-mode = "rgmii-id";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gem2_default>;
-	phy0: ethernet-phy@5 {
-		reg = <5>;
-		ti,rx-internal-delay = <0x8>;
-		ti,tx-internal-delay = <0xa>;
-		ti,fifo-depth = <0x1>;
-		ti,dp83867-rxctrl-strap-quirk;
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		phy0: ethernet-phy@5 {
+			reg = <5>;
+			ti,rx-internal-delay = <0x8>;
+			ti,tx-internal-delay = <0xa>;
+			ti,fifo-depth = <0x1>;
+			ti,dp83867-rxctrl-strap-quirk;
+		};
 	};
 };
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
index 38b0a312171b..f553b317e6b2 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
@@ -88,8 +88,12 @@ &gem0 {
 	status = "okay";
 	phy-handle = <&phy0>;
 	phy-mode = "rgmii-id";
-	phy0: ethernet-phy@0 { /* VSC8211 */
-		reg = <0>;
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		phy0: ethernet-phy@0 { /* VSC8211 */
+			reg = <0>;
+		};
 	};
 };
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
index 6636e76545a5..6ec1d9813973 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
@@ -116,17 +116,21 @@ &gem0 {
 	status = "okay";
 	phy-mode = "rgmii-id";
 	phy-handle = <&ethernet_phy0>;
-	ethernet_phy0: ethernet-phy@0 { /* Marvell 88e1512 */
-		reg = <0>;
-	};
-	ethernet_phy7: ethernet-phy@7 { /* Vitesse VSC8211 */
-		reg = <7>;
-	};
-	ethernet_phy3: ethernet-phy@3 { /* Realtek RTL8211DN */
-		reg = <3>;
-	};
-	ethernet_phy8: ethernet-phy@8 { /* Vitesse VSC8211 */
-		reg = <8>;
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		ethernet_phy0: ethernet-phy@0 { /* Marvell 88e1512 */
+			reg = <0>;
+		};
+		ethernet_phy7: ethernet-phy@7 { /* Vitesse VSC8211 */
+			reg = <7>;
+		};
+		ethernet_phy3: ethernet-phy@3 { /* Realtek RTL8211DN */
+			reg = <3>;
+		};
+		ethernet_phy8: ethernet-phy@8 { /* Vitesse VSC8211 */
+			reg = <8>;
+		};
 	};
 };
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
index 0d2ea9c09a0a..b1857e17ab7e 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
@@ -77,8 +77,12 @@ &gem1 {
 	phy-mode = "rgmii-id";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gem1_default>;
-	phy0: ethernet-phy@0 {
-		reg = <0>;
+	mdio: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
 	};
 };
 
-- 
2.36.1

