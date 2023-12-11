Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A7C80BFA5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 04:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233529AbjLKCuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:50:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbjLKCuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:50:20 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2077.outbound.protection.outlook.com [40.107.215.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFD5125;
        Sun, 10 Dec 2023 18:50:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDhNnWnsw4oPhdq0sfdQgoRvJA0BTmHttde+fkcANG72iP6d5T5Rxgsq7twCHQkwsYHLB52aj5KEZFaXEJxGdVfkOv+c6TQAAU4TljRGkvUy6NqnEU4Xk61H2B+96Gbf4VbqmRsN+S1mpN/WpYtSAbI2nyZCOZZKXQJUi20fb6dR4fCu/vCwIqzyAA2R3DE/oSld8ItOattDKnBiDfIE/Ox7dArvyvWPbNEsdr7SEn5eKfO26ZOID35Q1D2JIAoxis+958glCroHVPYy/rnz2ZIw+MlfRYt3NH5CyQE0pFDbGvVoIu3DNKQfx/VtvbSzv+fP5wTLU5cRXlLr909M7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMd6HYaAsmF5z7kcGL9OkN6HPkOFiqEArjYVw3SCJWM=;
 b=hjojXtID1S26yqcKCwbiFfKCzibQX+ALxtXFZ2/ebIIGIdyDq/Yu68X27KcT6b17zFYOC9FUXW05zydPhl/A9889sDosP+deLklv1GhvdZh4CpuBooHTiNruV9qKcPBSDOTQHIKpEBmXZWvALWLjZTPNT+bpJAves96yslYgRQbNDXlfeZfAOnrf8wMU+CKxtQ1uz4b7OfiTP8ez/qKWP3JHPJDI32MONEsgXEvzR35k0kdN7RUK9gNPpcEbAUILr2gZp3Cg5ZKF2Ae+s3Zb6D4RvPHK9xZhPZfBBjJ+2HGqz/yp8dtfvL9wIlPimPn2P5auzqXX3aC6U00ozqcOKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMd6HYaAsmF5z7kcGL9OkN6HPkOFiqEArjYVw3SCJWM=;
 b=A+1OMZwunn+2XROyMsNIo7dpEQAtcXUmO9jjFDPkyz2L0r6mn7QRcouRYZtumj3POXzk/oc6udcf1yLyOwQSsFKptZYmW+j3o7PReXmNUOVpTh0BSM+gcNMv8bbrZEdYt/dozhe+05fvkfrJslI+9lq63xd7YwLQq0soUqAvArB7iZJyihWJE5irKnLhmH1jP22ulhIJao2MbmtcaVs/+k5meb5FMPW6BdtaP5R6jtYtynpsl3KskQnMic8J0zMmNXudS0v0vakysQYHyEjITfA3jzg/+o20BxxF4daWIzLpWB4TnfxlapeE+UA7uvBl66Pa2ySZ6KuOGTcF7NZuRg==
Received: from SG2PR02CA0028.apcprd02.prod.outlook.com (2603:1096:3:18::16) by
 TYZPR04MB4448.apcprd04.prod.outlook.com (2603:1096:400:29::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Mon, 11 Dec 2023 02:50:18 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:3:18:cafe::44) by SG2PR02CA0028.outlook.office365.com
 (2603:1096:3:18::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 02:50:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server id 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023
 02:50:17 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/14] ARM: dts: aspeed: yosemite4: Add gpio pca9506
Date:   Mon, 11 Dec 2023 10:49:38 +0800
Message-Id: <20231211024947.3990898-8-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211024947.3990898-1-Delphine_CC_Chiu@wiwynn.com>
References: <20231211024947.3990898-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|TYZPR04MB4448:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bef77dbc-eac3-4cbe-2382-08dbf9f3e8e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oXNFEstEMUvFXoYlVYmJFRT5MEeRqoPhqO8GYJr31QxXbRBCXQa0H76PR4XhUmqJzD2OhAs1nxVNvqFndYYB8xkMk1mlzWrc/pAQSv6RWym31kLzj4yvRStAoSUSecP3XMIWDkOyZ0BOWEwdZmCHAi8yP7tVy1JnYrfYncyEaxYKxDHjszl7vkzvawoVOlBo7z/O726Vq52pzZ88JgGYBPl/c1FCVLX4U3MjbBLhcPrmXqMNWYd5PBzY6TLpWgQ+fUKaOXVKXN2vYl9hOgNmpDB/4ZgSR2TdMkHUPeFbCary7lMvaiE2Kz6657hthb4cQR+ZjFu9tDyBnRoFhTHQN9SC8fLbYY20oXCrE2v6ug4NIClDrml4McIHKPNzyDk2no09Ba6i6Ogq4tOw7ryMANmdesH9/UKnKmUaaPbhJXB+txO21ho/N7DyG4wL/pF2od8dx3DB0hM5O/amY7K9IvNiJVoji20DZvN6Nk2EQMfit1/9JVCp/RD6xLZiqhQkvARIuB9ibgD6jaoz410QVNFN+5lQW0I2yHlWN0pjb8Yqzkp+m0xWSw1gfFEHQXflR486EWAtgm/9OBzSAjXIm3sFff3IPonFKi4XiuSZQ4CHWYUsqUOCrlknpRWNx7E48Ek0GXqfjcSh1s6oO7HHpwkrO2geNDcF4kXuhU3rZD92llnH+gnRR5iGUcfoFFMNXJ4JRQ8UBd6z4nn+4tucUQ==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(376002)(346002)(396003)(136003)(39850400004)(230922051799003)(1800799012)(186009)(451199024)(82310400011)(64100799003)(36840700001)(46966006)(6512007)(26005)(336012)(956004)(2616005)(1076003)(6486002)(478600001)(6506007)(6666004)(47076005)(36860700001)(7416002)(2906002)(5660300002)(41300700001)(9316004)(70206006)(70586007)(4326008)(8676002)(8936002)(316002)(110136005)(36736006)(356005)(81166007)(82740400003)(86362001)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 02:50:17.5463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bef77dbc-eac3-4cbe-2382-08dbf9f3e8e1
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB4448
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio pca9506 I/O expander for yv4 use

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 251 ++++++++++++++++++
 1 file changed, 251 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 7f0134fcee57..da413325ce30 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -175,6 +175,34 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@20 {
+		compatible = "nxp,pca9506";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	power-sensor@40 {
 		compatible = "adi,adm1281";
 		reg = <0x40>;
@@ -193,6 +221,34 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@20 {
+		compatible = "nxp,pca9506";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	power-sensor@40 {
 		compatible = "adi,adm1281";
 		reg = <0x40>;
@@ -211,6 +267,34 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@20 {
+		compatible = "nxp,pca9506";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	power-sensor@40 {
 		compatible = "adi,adm1281";
 		reg = <0x40>;
@@ -229,6 +313,34 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@20 {
+		compatible = "nxp,pca9506";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	power-sensor@40 {
 		compatible = "adi,adm1281";
 		reg = <0x40>;
@@ -247,6 +359,34 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@20 {
+		compatible = "nxp,pca9506";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	power-sensor@40 {
 		compatible = "adi,adm1281";
 		reg = <0x40>;
@@ -265,6 +405,34 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@20 {
+		compatible = "nxp,pca9506";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	power-sensor@40 {
 		compatible = "adi,adm1281";
 		reg = <0x40>;
@@ -283,6 +451,34 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@20 {
+		compatible = "nxp,pca9506";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	power-sensor@40 {
 		compatible = "adi,adm1281";
 		reg = <0x40>;
@@ -301,6 +497,34 @@ mctp@10 {
 		reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
 	};
 
+	gpio@20 {
+		compatible = "nxp,pca9506";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	power-sensor@40 {
 		compatible = "adi,adm1281";
 		reg = <0x40>;
@@ -683,6 +907,33 @@ rtc@6f {
 &i2c13 {
 	status = "okay";
 	bus-frequency = <400000>;
+	gpio@20 {
+		compatible = "nxp,pca9506";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@21 {
+		compatible = "nxp,pca9506";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@22 {
+		compatible = "nxp,pca9506";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	gpio@23 {
+		compatible = "nxp,pca9506";
+		reg = <0x23>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
 
 &i2c14 {
-- 
2.25.1

