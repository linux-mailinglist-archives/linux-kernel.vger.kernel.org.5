Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056AE7DDEF0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbjKAKGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbjKAKGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:06:42 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2084.outbound.protection.outlook.com [40.107.215.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2355130;
        Wed,  1 Nov 2023 03:06:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyQl4dzpDVaxROu3im39YW8W9AG32ep5vqD83ExFtRmiIAelt7DiXNMifbaqyJBmQHt+fAwJBLZ7HuBwLzSsvxDj2Bb5/Xd2WpNtBo98vXEFw8VhEJXEJkXcDKa6KznW8LDvPn+cQCgKss/c+hAtX4rhheSJ0tEzGmUS0ZQTa/awDw/ukpp8xwCq43+tZGvLuGNz1upl02c6S+L2/dxPMzWrg4LdXB3gz0per+2XCKp8VxBwfRl5EmFVAiK5Mx05lXaXo4m3kVp12Cdi0oa6fmfTXQg6yKtclsLAycjy651CB6sTIG8iGa6tWrKO3jnjmf+0T5SBYNH1ldh7QVrKSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdAbnRoFDsIdH/0xJkZgMdixUz8aklntETREsmiQy48=;
 b=lhZi+SExLu6Ol86ls23xvinM7+jcOkFqxDBzYpaOyAvVktVrAProNhCNSkwqlGT3OJo9IumPPyKOfiKhRJzBcEuIvZ2zUAM5YI425GjykhX381tT2m1FJeTTyENePBaQDSkNHXTGmpziDziGRJXT5wZhKJ7vzxjyjU5da0xsM35nNvf049sqFjb5nwBVLogSNHttYuV0SwBGIWoRQQdkAV4rXkJuziR6RsdFj47sE0xEeXJHsHKbQS3Q1Tw1OLvQkg+thj1F76KwogSJewnt4eZKpwy4AM5+MKXqEygILuauamrGlp9eLcAgIqpL9btm6v/tLNSgeVKybT/j604N7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdAbnRoFDsIdH/0xJkZgMdixUz8aklntETREsmiQy48=;
 b=0RsqEQw0gndc59fFsrMIhKU4+ZaW2kDQSrVez/gMZtAlobB7Ki9PP3EBsyP9oCUyZtJpEGiSmSGgjK3oZoGG7IOuendbqx8egXSi65Tt57G3h6sgfCeKJYHrbb3+27azd4p/bVf6iLdRK6XQeJAZuimX0c20z3JwNjaU5PHG1JiNSmsBAfTzFXHCpP1EmUSgvxO7uFLeizNLAMyRMG/PATj7Bnl7039Y4ef+bVS47bKTTh/OTUtpptDJAYCCiNGAfr1/8BgdacTrkUTm7eQGURjCF6WWl7Y94KLlN38wIfLzsAB4WvuoMneJ/x07ivv2Mm7G/988v5mK0gQxHH7xFQ==
Received: from PS2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:300:57::17) by TYZPR04MB6921.apcprd04.prod.outlook.com
 (2603:1096:400:33b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Wed, 1 Nov
 2023 10:06:29 +0000
Received: from HK3PEPF0000021C.apcprd03.prod.outlook.com
 (2603:1096:300:57:cafe::5b) by PS2PR01CA0053.outlook.office365.com
 (2603:1096:300:57::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 10:06:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021C.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server id 15.20.6838.22 via Frontend Transport; Wed, 1 Nov 2023 10:06:29
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
Subject: [PATCH v1 05/10] ARM: dts: aspeed: yosemite4: Revise quad mode to dual mode
Date:   Wed,  1 Nov 2023 18:06:02 +0800
Message-Id: <20231101100609.2516844-6-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231101100609.2516844-1-Delphine_CC_Chiu@wiwynn.com>
References: <20231101100609.2516844-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021C:EE_|TYZPR04MB6921:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 53c3884f-c7d2-4821-ca13-08dbdac237b2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2fB0lVe+3Nv5vBUkW+Zbamel/TGTsfSUVMeKM/fMMQ1sHrrUS8Fz2IACUO8DcDtlsqxCsWcOBaMsoXm1mwNeTrdHn2F2SLp8UlPKL9O+x2WTaCo7b+Z4aLu6me3psaGzdLHzGpdW3GavWGTMBBR60EdlF1WEsrsexB+0XNdmoAFaB2wyB5dnFEmKxg1Pbp7aOEBagCdfbJsqYlM/AK3zJhnOHIHBcywityEY0NGzmlPmQ6GBek34wcDiUOEdjLa6chrRvs19XSA4asTvt32DS/BpbryTOu4MLyNH5OscA+75V1RfC6337bsMpzOKcfIHNtnu344k4cc/E7C0T8vGEEtjmTJcsnlqiKKjGjYlDlBFK1vBgFlRT2qJM/Ec3B6y/AhVruJSU18lJRYhZfPbVueB4GjrWASAK+3TL2KYDZaqcVpXxBemMW844PGJ3qWxLoTSN1ksRc63n0Gmb+93fW6OfDV2viWux2Qeypa88oxIqD7hFl2jH1MEP7wcNkkzGP+Yt2mhbOAw/Kg16TWeqBVfyc6niGOwolr6gnlNT0SezTEBQKUP9KuPMXM8TSw2OGbSfHE2pd+YT5f1DvH9GjtGbh1Lr41Dy5kPf5W9kVwO2ziPL6VWMr3qDuEJNxKUyFQlHY5X1HhP7YMS9sOVKAUgTZpthH07/Wf1WvVZPl+nesb7ERZEvqGjbFuILU10m3fXUViyhkX4nf2ncqguqQ==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(346002)(376002)(39850400004)(396003)(136003)(186009)(1800799009)(451199024)(82310400011)(64100799003)(46966006)(36840700001)(47076005)(7416002)(70206006)(110136005)(6486002)(70586007)(6666004)(6512007)(6506007)(36860700001)(2906002)(86362001)(36756003)(82740400003)(1076003)(9316004)(356005)(81166007)(26005)(2616005)(41300700001)(956004)(336012)(316002)(36736006)(5660300002)(478600001)(8936002)(83380400001)(4326008)(8676002)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 10:06:29.3844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c3884f-c7d2-4821-ca13-08dbdac237b2
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021C.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6921
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revise quad mode to dual mode to avoid WP pin influnece the SPI

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 .../arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index bcff232a1782..5bad7abd8f65 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -149,15 +149,17 @@ flash@0 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc";
-		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
 		spi-max-frequency = <50000000>;
-#include "openbmc-flash-layout-64.dtsi"
+#include "openbmc-flash-layout-128.dtsi"
 	};
 	flash@1 {
 		status = "okay";
 		m25p,fast-read;
 		label = "bmc2";
-		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <2>;
+		spi-rx-bus-width = <2>;
 		spi-max-frequency = <50000000>;
 	};
 };
-- 
2.25.1

