Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4586A80C0F9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 06:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjLKFtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 00:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjLKFsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 00:48:43 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2062.outbound.protection.outlook.com [40.107.117.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D709C10D9;
        Sun, 10 Dec 2023 21:48:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuHwkuvaHsUyZzgCIgsoTHO0Y8G3kIMJdyY1NVTzl5Noh7BNUwnxL++wtKKPdODauXqz4hxqWSB7B/80s4oArAdS4+9mfpysIZaF8gUdn+8ojhOky7W2H0hpvzJmWe43a2riIO/wjlNYQRNXTpzlalZihS9/pOkuyOx63s8tBefBKi1rxPhXohm1Nhc++z3pO0heW4s3XdEIqz7vtX69/JoyhFGTRpFeG9VCzvcyR8Q2pnn1Xaz0rLsrVpg+t6rTD+zGuKoZWVB7Ya9S3VMYVJqWrUvyM9b18kSUBiWq6KDcSBaXBx3kiogC6w8webo1XqBljJl+1ZwToE0lo6sfQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGTire1khymAurDE24N2Ga1RZMcRUKvih7zqhbJUcjI=;
 b=Hn3WDr1XbtdIDYwqPuIyy0tm04DvXADrqZH4/p3MtAdkV+dmMcgsDeC5zGHxAnuidb2LnfoJNQNuasT6+yAUPxUDNIvErikivnNkaNnl2dvixoJY13GD8u7BXlnSmJfruFbH1eQywwP0/Pu9ArjaaOB71obEyf6ZyzoURZXFRJEAHy3BD+udEBDjIVXD5Wdc2fjqrWqrc+FgRLNL8uAl9LqFSgiVii3GQuC56gt7qEgDIhBTc2cH4vIINgBY3Md9jPjYYdr+nJxM9nnbzrAWrY2hcipcgSM6HKT0d/ny+WMTWdJ7F45krkJ5fAKs08PkYr/Erin3JcM+r5jL2vCMYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGTire1khymAurDE24N2Ga1RZMcRUKvih7zqhbJUcjI=;
 b=rqvaLxSYFkAWygVCyeiZDpDRvyNT3u7pBPkzMHldXwxaIktwJF9SoRGEWE1ifpiraBx/G9uvcD0vMPdldFcbgA+1xdLTcCdnpX5aZ1uvUlyzIHsbgDatsceUGtkcWpyC9giShIRpMYF3DT/EbmS7hj2SIgFtNYYA/PonsTUsgiGxKKxKNvmYBbFM4ovLP+kuVbewis9wdteDGRk2APiSM1+rG22zJp/gjAbEKLK4OW1VxuydlI6k/FsYFFNFElWiaL2GEY2PYOo4KSAWApn/yp2g9crGC5sXluYmGambXCuwQHYhAJL652zXo3YuGhNa2WVxmalqNpxoQLNGyOrVkw==
Received: from SG2PR02CA0054.apcprd02.prod.outlook.com (2603:1096:4:54::18) by
 TYZPR04MB4381.apcprd04.prod.outlook.com (2603:1096:400:2a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Mon, 11 Dec 2023 05:48:21 +0000
Received: from HK2PEPF00006FAF.apcprd02.prod.outlook.com
 (2603:1096:4:54:cafe::bc) by SG2PR02CA0054.outlook.office365.com
 (2603:1096:4:54::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 05:48:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FAF.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server id 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 05:48:21
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
Subject: [PATCH v3 11/14] ARM: dts: aspeed: yosemite4: Revise mx31790 fan tach config
Date:   Mon, 11 Dec 2023 13:47:26 +0800
Message-Id: <20231211054730.208588-12-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211054730.208588-1-Delphine_CC_Chiu@wiwynn.com>
References: <20231211054730.208588-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FAF:EE_|TYZPR04MB4381:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3e6b815f-b62a-4ee5-5ad4-08dbfa0cc87b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jGB1wBYuUXwiH8DgS5K+Q2bBvsEguZ6sJtnHzr9VKK+5oRgnCIk35SCHLcBzBhVBWV9YkQ7mhnoH+1miHmrcU5OBkpCrOOoTWD0NfUFaRoosx/J06S4Y0A7bQIeTo6dR0oUHX4YLq1xZUaEarNWKikTLUh1RG5/GSbZn1VqiMBaZNFnJOriOUCyRS6yKlggJHoRxwwkEQJ3D6eJlnoRhRp4zqtHEYXGC6nAefSYAUxwng+J0NsigYLqhbvvMHub1h7lho04sBW+Eygcd4XUFz/IXmjjCXx+5Aeh7oNv7THrFa/UW2JA4WtOvdyufv/6h6DLQglqVbhdG/zr3SRGWfbdO5Hs3hNNQVhrQyWgCTE3LagFccv+h/sknznJmaIjhmXqqSmxHvwExqdKA5Dr50JXE+IkNjSirgy1MzptAAUt6l/Xu+SsXKRcMUiitSzWIlJLf1jWvjuP0kitTFQ3+7PZMJAGg5ktUChShXwvrAAibZwEfOoarYtAIOri9F0kQiyrHBuOZWCPgW7RKPYPds9MvdxX5Gb+acNPWGEphr1Zo4bv/v1RDEyacMcwBia4IE5xD7qDGvqVxw211RCd/YcBAM+FY2cK8cVm3VODJzvqVif+A9B/W1tA93reYwSzauQNvSrOM0r+VzHOZo3rPXBVGGmkKl/7ARW6FdxO6Bg4QwtulyVcucAvDBda447vKwPoGT/H+17Jij0O0M0LEnQ==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(39850400004)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(36840700001)(46966006)(1076003)(26005)(956004)(2616005)(336012)(6506007)(6512007)(36860700001)(83380400001)(47076005)(5660300002)(7416002)(41300700001)(2906002)(4326008)(478600001)(9316004)(6486002)(8676002)(8936002)(70206006)(70586007)(110136005)(316002)(36736006)(82740400003)(81166007)(86362001)(356005)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 05:48:21.0948
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6b815f-b62a-4ee5-5ad4-08dbfa0cc87b
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FAF.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB4381
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revise fan tach config for max31790 driver change

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 48 +++++++++++++++++--
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index eb3687bfd632..073f27f1e35f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -1095,8 +1095,18 @@ adc@1f {
 
 			pwm@20{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x20>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			gpio@22{
@@ -1108,8 +1118,18 @@ gpio@22{
 
 			pwm@2f{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x2f>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			adc@33 {
@@ -1145,8 +1165,18 @@ adc@1f {
 
 			pwm@20{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x20>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			gpio@22{
@@ -1158,8 +1188,18 @@ gpio@22{
 
 			pwm@2f{
 				compatible = "maxim,max31790";
-				pwm-as-tach = <4 5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x2f>;
+				channel@4 {
+					reg = <4>;
+					sensor-type = "TACH";
+				};
+
+				channel@5 {
+					reg = <5>;
+					sensor-type = "TACH";
+				};
 			};
 
 			adc@33 {
-- 
2.25.1

