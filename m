Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CDC7DDEF5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbjKAKHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbjKAKG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:06:57 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2054.outbound.protection.outlook.com [40.107.117.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F0C119;
        Wed,  1 Nov 2023 03:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmyNxAFzM1z4CwhQbx639P6XpEv3dWEhKJtxn1jeFEg/bI+0qK4cztRbUgvR0YeA1Rchjntb1wObDJFs71lrnTV61jw1Zj7vMzbl5i7+hRXxKbRwoGxCTga7FNMtKEMGXO+seqAKfwNrtdhhMlzcTvarG03/p9a1adojMAHPMW2wi8alzxio66gim6r34Gg/no+hjIuLZx7PqIc9nNtXJpmpL/zmPOt2wTybqwIEonWWywIjIVCddJxgINFK+1UEObOml1WmP4QWPscOhfFUnZoxnEHRt0dTk7MdQAOY8GS8oOvJ7cE99FX1r+POv42XtPKt3fB4d1zVxA0SvL6PWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35HQaRL1Pf3wCPxykt6OvctpFhwvKLgIEWC2V9goRQ8=;
 b=cnewkrFXS9iWzUd04PCAGjtJpF4cYyaRlTWeevKRNbY7uj0J8xSyO/aShV4BthDAUnA/XHJbQjqNVk0eVtd1fXxCNgRYapvPsqth0N58k9/n8ogAcMhsdBfFXpujV77cyxgn3Gu23dXFwCsWT2k7ZifgvoTzDpO881r/qaH4BpmmOfD1hwvOuLDhUoP/JHShxLkciXhYfY74grQLyIKkm0qvSLilQ6+HpGesTBnyRT4E9nTgVCeVKccmkbrw/Up7vG5fv9t6ggWTOeRyVMoBtE1Pk1zJqXQ0fLNE2In+yZmDCHlq8O4ijtpQZRERerq83V6WOcl2BXQnYpi1Sk8cHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35HQaRL1Pf3wCPxykt6OvctpFhwvKLgIEWC2V9goRQ8=;
 b=jziF9et9r9c7gSE10Ib9qDVp6w24B//4ok8t20Mzujq0LUMgRLJGgxhez7MzSX3kPpV5h8WX/Q1VnsensiBW0ZOJVBSR06fKSXirfibOxwyrFCLkfWRvJfZZG/eZF9manN7HUrteGvWeOEzxvDZphB6MnxDCu+mXpSgVbGpRXLhHbddVvWNEH7HU68Lo/+RymhUDDzQlyJsdvDxNi/TywUGk1yRuHTqtmmM8QvVCPCabzOuMpS1xGHENnkxEbcq5jqjLJDEpclNzsuFJHAwEH+5JHpId3nMMrPaQZ2M24pVGziFRNgx1RXSohrLAmvWcAUL7ms64aLLafrR27XfA1w==
Received: from PS2PR01CA0069.apcprd01.prod.exchangelabs.com
 (2603:1096:300:57::33) by PUZPR04MB6487.apcprd04.prod.outlook.com
 (2603:1096:301:f5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.25; Wed, 1 Nov
 2023 10:06:32 +0000
Received: from HK3PEPF0000021C.apcprd03.prod.outlook.com
 (2603:1096:300:57:cafe::2a) by PS2PR01CA0069.outlook.office365.com
 (2603:1096:300:57::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 10:06:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021C.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server id 15.20.6838.22 via Frontend Transport; Wed, 1 Nov 2023 10:06:32
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 06/10] ARM: dts: aspeed: yosemite4: Revise power sensor adm1281 for schematic change
Date:   Wed,  1 Nov 2023 18:06:03 +0800
Message-Id: <20231101100609.2516844-7-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231101100609.2516844-1-Delphine_CC_Chiu@wiwynn.com>
References: <20231101100609.2516844-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021C:EE_|PUZPR04MB6487:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b77f0c77-f8fc-4d7f-66ff-08dbdac23975
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rzEm1/5DZQIJ1GwNO0SoYIqeDE69iE4Cny3jvMMar+J53sEqktO6bRclfqUgYYANQhhDrZk3fxthX4cC+neGJwVtg7aRLXkWbFkPpa6v7hRqD2lSLYuWx3EzkkDNWTNHNRQeqURR3vP+b+dzhIoa0usv41jckYhxyW4YFZDOviE7kkS/VEP0cIle5SbjJBP73K/gRsd0KMm7EAyHk5zYcVLErhdtNfTkNrnTraWTMu/jf+D0THeILG50oA9ovyB6T/CyxXBln3FeFifZs8FAsxX0PyzLmcpNXnzy9exTet5omDI7sRyIpenkjZqzHjprgVt5hlLE+ZAGtu5UrlIvMHAK+IcXF08CKdG+7jKnbR89j/fJoh9zhESj3c/3/hxCGLvIH5fMG4Ve/TEtbBoy+7PNXM1BxyuSTOoCXDLgEh7BCkJpJYp7ERK8UgrynSCrU/XZdW+J24UpTMaJMUoE1GKuI5j9if/DcteWEFpGsa2CTcgpwdwKcov/P1mAZsOUYeGWlQtKjnWqdDm5GhoiWQ8KQpFv0Xqk599MBhtDV1szf1qjEBYJa4zwJhEnecQ8TNPCBo5fCpECGM3eeLHxFOuR1O5RWL2lUsoBea+5w4VZ4A7gQJHgE9TAcyRFWqLB7qVeHFa2BNKeS6MVZ0ZxKSKNQQhT65wsrYTG8lYSkwhAJbw795PG2i4UyWmnsMCYR5ex+IMIxZ7pQEcxwVhbtA==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(39860400002)(396003)(346002)(136003)(376002)(64100799003)(451199024)(1800799009)(186009)(82310400011)(46966006)(36840700001)(2906002)(86362001)(41300700001)(7416002)(8676002)(4326008)(8936002)(5660300002)(36756003)(9316004)(478600001)(6486002)(6512007)(110136005)(26005)(6666004)(47076005)(40480700001)(6506007)(36736006)(1076003)(81166007)(316002)(956004)(83380400001)(82740400003)(336012)(70206006)(70586007)(36860700001)(356005)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 10:06:32.3375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b77f0c77-f8fc-4d7f-66ff-08dbdac23975
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021C.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6487
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revise power sensor adm1281 for yosemite4 schematic change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 5bad7abd8f65..b9dd7705b172 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -176,8 +176,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -193,8 +194,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -210,8 +212,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -227,8 +230,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -244,8 +248,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -261,8 +266,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -278,8 +284,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
@@ -295,8 +302,9 @@ mctp@10 {
 	};
 
 	power-sensor@40 {
-		compatible = "adi,adm1278";
+		compatible = "adi,adm1281";
 		reg = <0x40>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 };
 
-- 
2.25.1

