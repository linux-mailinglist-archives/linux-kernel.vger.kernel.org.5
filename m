Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6587C80BF97
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 04:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbjLKCuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbjLKCuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:50:14 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2070.outbound.protection.outlook.com [40.107.117.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED04186;
        Sun, 10 Dec 2023 18:50:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5IgraK4TNnv9uz3LoXxuhUvDVbO03WR5wJi2rvKrgwNbfiprqt9sxghZkbTjGcWR6bJOHb+LL4ZbVK9DXIKGu2L5kF6c/GTlEDhzrCTi9wrTirEOxkjQeOIO3jyee3OCM34IJXUrjy9yCO7iDHq67RDyM5wSItoQYQbIr8cFfZMLW38B2PvfNiKMu8pab7rNFPOtGpOdphdheXOE78rcBwC5lnjPC5uY3Uk+YqP5qMGaosDOhb0d8mjG1q3hGyl22QE7Up/XB1WwnDPSwwjNNLuwEShWVWQmubluYltaCAxLINz+F6AJEdD1ij3FiSwYhAeYVOnjuEHHLu5/Om4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zsmK47O4uAWeM7dDfAnIa4yPQrzYmWUcPGa4gFr5YYk=;
 b=G4k7u3E6cHpgvi/LBziS51FW50Q4kmMHE4mFSY92vaIQXBQeVwDNeCknpV31hm7wq9uCbUam2j4//zkjtoXbIYB8ceqnQm+X6AQAfcOLeYmyi23mN96Kh3HUpgNxJ4zsS8BsFOS4P4O5CYdoJKPlZ/2+uOu7SQ0q0v/nf5/vmQNu2C3hoDevrEG8m3nzqJL7wkhM4H5tcGwNniaLxpc36AFPznt1zUud16hEfZQ6s69jm1adajEvswLkk7np2uTblSjePd/i3/agFh1omREO88XtieLCmX44/Mlwp6FVhSgeIcgn4Guof8RTLoCiaRQPXY/SSfU99MnBGD33TuEDOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsmK47O4uAWeM7dDfAnIa4yPQrzYmWUcPGa4gFr5YYk=;
 b=MsOU3bN8KxdfXn4bK5E2As5pkBZQKznyLd2Tmd0phw8qncFZMUQ2tiMLYCIM0yl+yyVZaTX/jh0+VvDLdL3NWHSotAEHsaYyjQNxs9UfVPgrMeRTkKiIReAQovpK8oiEpDL7V/3nO79/IW2+1OKVudn5kR6GenbnoNrKsHvE7fBnX9T6Wla18qbr8U3Yi4vmMVs9nQUbOolREXvuijzLIAJ6MvhRjI8tKcXfARwzY+GxtnfDJ0ucRdK92Mg5F9voD26hMvsAAjflZS+Bel/fD3Lq/gF1vaODT0/DT07hCVTHaw1L9Ji+UmNiSZXfynRrOBTrL2mRPJzq/3VxtKQnGQ==
Received: from SG2PR02CA0043.apcprd02.prod.outlook.com (2603:1096:3:18::31) by
 SEZPR04MB6234.apcprd04.prod.outlook.com (2603:1096:101:cc::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Mon, 11 Dec 2023 02:50:07 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:3:18:cafe::ac) by SG2PR02CA0043.outlook.office365.com
 (2603:1096:3:18::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 02:50:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server id 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023
 02:50:05 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/14] ARM: dts: aspeed: yosemite4: Enable watchdog2
Date:   Mon, 11 Dec 2023 10:49:35 +0800
Message-Id: <20231211024947.3990898-5-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211024947.3990898-1-Delphine_CC_Chiu@wiwynn.com>
References: <20231211024947.3990898-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|SEZPR04MB6234:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fce56365-fdd5-442e-0e95-08dbf9f3e1d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5C+fKF6YNjYznRVSmXq89zmPoCoKoR8UP5b3iq1FMqYDUSqwgsCkJf+yBA8sbf6uGWY2rRnorxnNmzZ/WznKHFG8xHjqvdYOjc5/jN4E0Lj0YY988n1qgeFOk3WAhBKBzWzz31EKmU6+M20/hWcDI4xSWlYZ0ce5TH7g9hJuZZDBtyGKWO2i83M2WTtOrzZO1656/bVK4XPZkEJbAk1ElzwB7tLo15mbKbOmzPk9nqJmT9PKkLj2JIdp22rTXi9er+PTid2RjiRJ7Rj/lH5lKmA7VhQ1bdRmrINw9qSWGUD+6EN5UCLomu2GBAKh+mIAOZt9eFq6+5/sdZP3FzHXigkS4zzX1NIdANmBcWMsZ/676zFzBpPyT7NkPtFDykXnXXyFUpYHeXELG5CZxUwdmIuMeseVBlWN5dSL5W+mgtEOhNZk0JdVo94UaSGy7a1O3ZiPJg+m0xiX0LKoJ/DXRmKVPqPHF1SFWwnZTD7KB6TaIS2cL+YASizvwUD81X3HqA7lCPDMl+Aeu3vaXid7yG4KnR0gJGlGAu2uU0LaHslf3KLCZ6Q/cVFDoFy0D6a+sG+qRXtXNOJvBz9bQkEvwsNaPgn5/RwWmltKeRXoAuaAOLzbygjyJhoNYQtA2huzOa59ku4JuqUE9giAnBr1JGDoeXJlLB26Bx/hrUvtM5oZ1B+yu3U4zeQX6O8kxUYpv78G0nZFEX7rxEjRQI7Q3A==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(39850400004)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(36840700001)(46966006)(1076003)(26005)(956004)(2616005)(336012)(6506007)(6666004)(6512007)(36860700001)(47076005)(5660300002)(7416002)(41300700001)(2906002)(4744005)(4326008)(478600001)(9316004)(6486002)(8676002)(8936002)(70206006)(70586007)(110136005)(316002)(36736006)(82740400003)(81166007)(86362001)(356005)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 02:50:05.7962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fce56365-fdd5-442e-0e95-08dbf9f3e1d9
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6234
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enable watchdog2 setting

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
index 0449a7e36ff6..0e9095c83a59 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
@@ -120,6 +120,13 @@ &wdt1 {
 	aspeed,ext-pulse-duration = <256>;
 };
 
+&wdt2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdtrst2_default>;
+	aspeed,reset-type = "system";
+};
+
 &mac2 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.25.1

