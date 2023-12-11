Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E9380C0FC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 06:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbjLKFta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 00:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbjLKFsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 00:48:51 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2059.outbound.protection.outlook.com [40.107.215.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD363130;
        Sun, 10 Dec 2023 21:48:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUP8tcK5L+I+ATUWl0smHVE+EGplk/FYSWL+x1KI2NwzyleTAkGl7q6O0ucw2TlHV/zS6l3MZQ3LL+o/nAAxA7jTbc9/xAKePA7NWTY1rySKuXLQ/22fasGUo98OxA3uDxTc0UDxZzCpA9bPeiiZiXDdV5exMjh07O+t0uJ3YmtLPlLPKyqZei/mn5w84HIrNn14MjYUF/GOnIeraITu4iTnF83lhmZG7OK9c2Dvg6JwxMolTXtHEy7OYtrSMWATEDYA04fTXuUEhvpe1f7bdtpLiPKhRjPHiK0vWs+FdlZU+NDMTBI/XAlyuVVZVa+/8n1n3CGlmPlGyJepKLm5zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjXjpmhQSh+Q1/LQSzTEFjTUT2q5oHytWtDAaWRNQxg=;
 b=PHQg81jr15QdM58gvlnWcK5j/IDpRhduG4SRyzd13NCMdLQATbOOkA7qoLWKDu9zlzo8A7GNvPZcZKH7tOkHLOs2jsknzpO7v1KKmX7spZjQ43PJ2q3Fh7cCmGZX48PBnM8r9G6kkHaAGEVoTRhCMsAIhK5cvbKBBqR+jJFGUaRHvhxUC6NQPNXNmX89/j7V4JmxoJpXdZbfG6BnRB5XBEyR6+CBfo/5ExRHmtTFtL9Kp/2uxPYXKYHgUYXqY7ZuxrTP4e1uTKXVs9OToV3oMiHfIMdggCMXMdrB/oVAzWp4oWj4N012ccqxFJB2AxiO0WP7j8dwms0KfmiFXGpqPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjXjpmhQSh+Q1/LQSzTEFjTUT2q5oHytWtDAaWRNQxg=;
 b=34veCkmBXorTOC8kQllnKMUQr8TGWq9QzMyOdvLzPMnx1CjOgRFxri32Ibc/JyU1QsQ8wtIBlN2FYVu4ghH4z03jz5bXKoIyAnCMYm7pncQ0voGqZ16xgfYxWqzNyajm+i6J30FWfEj0WfwtsDeDGXqu1HxsCHqEzQHTOMigdEY5kPAf+VBGItJBmDzPn2KF+1IfU85kNBKH1jkptbri54UhqS2LrnS+T83QElqKjq8gg+wbUqlT3jtz5ZH2RbGdKN3F5EOh+OvrvHbKe+ljIelRKXbsm203YRz7oaeWfXCNh9DDi7Zm/Blth6TBbQ+uG6ebH0oP4UIu9Q900qwfow==
Received: from SG2PR02CA0060.apcprd02.prod.outlook.com (2603:1096:4:54::24) by
 SEZPR04MB7166.apcprd04.prod.outlook.com (2603:1096:101:17d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 05:48:33 +0000
Received: from HK2PEPF00006FAF.apcprd02.prod.outlook.com
 (2603:1096:4:54:cafe::71) by SG2PR02CA0060.outlook.office365.com
 (2603:1096:4:54::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 05:48:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FAF.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server id 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 05:48:32
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
Subject: [PATCH v3 14/14] ARM: dts: aspeed: yosemite4: Revise gpio name
Date:   Mon, 11 Dec 2023 13:47:29 +0800
Message-Id: <20231211054730.208588-15-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211054730.208588-1-Delphine_CC_Chiu@wiwynn.com>
References: <20231211054730.208588-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAF:EE_|SEZPR04MB7166:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c7eece12-fd09-49a0-707d-08dbfa0ccf45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VVPqT+NiOHLcL2WHagtKNmPCfxY06Oi3vzBmAvE7oql1WBZ8V4A5E0z1gsT8JXJNwR1iSQtP2jiW+an1F4aAvw07dRwdbGwjK0ItAgHHxHLzOTXj9GTjSTv1KomxUnelc0qX7zmKbIomHXUsL7vchr2ay/EKy0Fti1wXisXLO148dErQk7s+FIuaOsAixYXVflQPeSNR4CxGLPd9Xck/6ICS4begadUxhBcXyrYmqX6o/SnJvvVDK4JUucVxsIKmqODFrzS8SEDVe8qUhRSe0dqyjlaUIyAMHGNfqdYMkSG62BZVOsm0d0jYmXToraS4/WWf4QBmLmARfTeSfLpAGrntezNjuzFTsh+oN+YURpSqQpVoD5bIIsiDV1mEQEwqGzXUWd9WmEqmhp1pMBWso8QtDCevfn+I+VegTQ5PPWS0PLKgay4i7htSUE6PzW6zQiRmQBl1Ny06b2nD3poftYcVhO1Y8cTj18U4g/cmcWWhvJ93B9Bqp3zgIOt6Ta4ZfTlUR56WsluBGZajXY+HDRPy/svzLYNJqxjnQDvt6qSdt5Ta+U/9loiThBIUyzZ6P2FWHp3kl7ZnmvgqDEA87Sfa/A9gOP6mV6eynHST1qvbb2m4ZWtH8uj1ka+vxLVBqyqb9si0fVzaSaL+1C7GBQWmgEKomIO28ZjsN6wUVzEsUq8tsRpEFnlm83HJQ39kt4jds1uOIWe1RfUnDrk7JQ==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(39850400004)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(36840700001)(46966006)(1076003)(26005)(956004)(2616005)(336012)(6506007)(6666004)(6512007)(36860700001)(83380400001)(47076005)(5660300002)(7416002)(41300700001)(2906002)(4326008)(478600001)(9316004)(6486002)(8676002)(8936002)(70206006)(70586007)(110136005)(316002)(36736006)(82740400003)(81166007)(86362001)(356005)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 05:48:32.4855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7eece12-fd09-49a0-707d-08dbfa0ccf45
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FAF.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB7166
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75,WEIRD_QUOTING autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revise gpio name for EVT schematic changes

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
Changelog:
  - v3
    - Correct patch for revising gpio name
  - v2
    - Add patch for revising gpio name
---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite4.dts   | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index fdc33bffd467..8b258b128cfe 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1414,7 +1414,7 @@ &pinctrl_gpiu4_default &pinctrl_gpiu5_default
 	/*B0-B7*/       "FLT_HSC_SERVER_SLOT8_N","AC_ON_OFF_BTN_CPLD_SLOT5_N",
 			"PWRGD_SLOT1_STBY","PWRGD_SLOT2_STBY",
 			"PWRGD_SLOT3_STBY","PWRGD_SLOT4_STBY","","",
-	/*C0-C7*/       "PRSNT_NIC3_N","","","","FM_NIC0_WAKE_N",
+	/*C0-C7*/       "","","","","FM_NIC0_WAKE_N",
 			"FM_NIC1_WAKE_N","","RST_PCIE_SLOT2_N",
 	/*D0-D7*/       "","","","","","","","",
 	/*E0-E7*/       "PRSNT_NIC1_N","PRSNT_NIC2_N","","RST_PCIE_SLOT1_N",
@@ -1432,16 +1432,15 @@ &pinctrl_gpiu4_default &pinctrl_gpiu5_default
 	/*K0-K7*/       "","","","","","","","",
 	/*L0-L7*/       "","","","","","","ALT_MEDUSA_P12V_EFUSE_N","",
 	/*M0-M7*/       "EN_NIC0_POWER_BMC_R","EN_NIC1_POWER_BMC_R",
-			"INT_MEDUSA_IOEXP_TEMP_N","FLT_P12V_NIC0_N",
+			"INT_MEDUSA_IOEXP_TEMP_N","PRSNT_NIC3_N",
 			"INT_SMB_BMC_SLOT1_4_BMC_N",
 			"AC_ON_OFF_BTN_CPLD_SLOT6_N","","",
 	/*N0-N7*/       "FLT_HSC_SERVER_SLOT1_N","FLT_HSC_SERVER_SLOT2_N",
 			"FLT_HSC_SERVER_SLOT3_N","FLT_HSC_SERVER_SLOT4_N",
-			"FM_BMC_READY_R2","FLT_P12V_STBY_BMC_N","","",
+			"FM_BMC_READY_R2","RST_SMB_NIC0_R_N","","",
 	/*O0-O7*/       "AC_ON_OFF_BTN_CPLD_SLOT8_N","RST_SMB_NIC1_R_N",
 			"RST_SMB_NIC2_R_N","RST_SMB_NIC3_R_N",
-			"FLT_P3V3_NIC2_N","FLT_P3V3_NIC3_N",
-			"","",
+			"","","","",
 	/*P0-P7*/       "ALT_SMB_BMC_CPLD1_N","'BTN_BMC_R2_N",
 			"EN_P3V_BAT_SCALED_R","PWRGD_P5V_USB_BMC",
 			"FM_BMC_RTCRST_R","RST_USB_HUB_R_N",
@@ -1459,9 +1458,8 @@ &pinctrl_gpiu4_default &pinctrl_gpiu5_default
 			"","ALT_P12V_AUX_N","FAST_PROCHOT_N",
 			"SPI_WP_DISABLE_STATUS_R_N",
 	/*T0-T7*/       "","","","","","","","",
-	/*U0-U7*/       "","","FLT_P3V3_NIC1_N","FLT_P12V_NIC1_N",
-			"FLT_P12V_NIC2_N","FLT_P12V_NIC3_N",
-			"FLT_P3V3_NIC0_N","",
+	/*U0-U7*/       "","","RST_PCIE_SLOT3_N","",
+			"","PRSNT_NIC0_N","","",
 	/*V0-V7*/       "FM_RESBTN_SLOT5_BMC_N","FM_RESBTN_SLOT6_BMC_N",
 			"FM_RESBTN_SLOT7_BMC_N","FM_RESBTN_SLOT8_BMC_N",
 			"","","","",
-- 
2.25.1

