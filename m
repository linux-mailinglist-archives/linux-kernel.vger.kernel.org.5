Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F298580BF9F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 04:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbjLKCu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 21:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjLKCuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 21:50:15 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2072.outbound.protection.outlook.com [40.107.255.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504E310A;
        Sun, 10 Dec 2023 18:50:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWrcjWPz683GBNJdZfOEgOHIMoyKw5p5UB/Q8HgS4w+rfyzA1F0cBfx6ZCSkpYcNjbyMM74PG2qwAumqywR/G9J9wdZYwHHR5+cIPT4XPkAVl0ivHUpi0hiQtgZ+6Pz0YVIieBXbqfAVQHp1Vn+WivckWoPuJdRt6K2w89FvnCd6u6LaIdj+HpCGGg1BMmfqu38MQ1c9FTCPah/BP/eJ8TudIyZ4bH3EKHhWjIbjIcYVMyyQai56Uw7+HW3wKxjWoqlV/Gt8qQN/X6TiFrcHR1iL5l6XYSH8NL+it01aUKSobxvmwwI1P2LI3ZngKD6uYedhNDnYNJp8g6m/bgSovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9hJP4cxinrgJgR2dHN8WewCHihh7cN0JE99FmSA1C0=;
 b=AxebcL4uEHm41UzWW85VXyi3/vgL77tG38BBbboStdpZtrb0YExdbyquAjLVcXLSfrdFeVkKnRIjgCLb0KV5Mll+abCXGvTvuf8uoFuKpKd7d91n0+sZvH9LeuMutRLyXYpf05RtOUS6Y/YyzAK9BRajzY9obUEXtt0+vNkIqVItzzbLc0AgXN7ce65rk6Dem2Z5aAWUT4Mw2XQ2aPaCYSiV7OXVMomh200/f5phzZzmxXMb/1C2eW3EwiMvi6+ChPxu0wnVC0QuWDK8kB48XfoMmCK9M8Q5ngec+/gJIBlRLspSBa5E5J+jljivdZ1N4YfJkIPckbmrCBuFt342xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9hJP4cxinrgJgR2dHN8WewCHihh7cN0JE99FmSA1C0=;
 b=Hz/9yjMJwDt87bXfKvOhBmM72YzDIr8aTNY1DZKN2y2xrdygCJyXGg6df//VspTbvArw7DDIgTxSOibWlGJU3QYmQZ4f6Uc3A9uk1HVY078cMjtZmT4ZWgBJEuXgWnJUjwhMu6pRq7ZtHKtM1gltdSQ8hb2J9eoVHfVPvaXujF3iLGbit/kDwc1RZS1mgePWx3DAQxj4itLIRGq0k4mUeAwlLOUpyNgkbdm7pBhcGaU7vUOKTNfCjs3CjjS3t3ERLBJO0CDcIvkqmbFh00XizfbPlxnP+j1fPUD7Hpw15wzr9TRZzBjUgWPLEimnMnS8HTGenl9z73KxJnHFv1SxWA==
Received: from SG2PR02CA0026.apcprd02.prod.outlook.com (2603:1096:3:18::14) by
 KL1PR04MB6784.apcprd04.prod.outlook.com (2603:1096:820:d4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Mon, 11 Dec 2023 02:50:11 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:3:18:cafe::33) by SG2PR02CA0026.outlook.office365.com
 (2603:1096:3:18::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 02:50:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server id 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023
 02:50:10 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/14] ARM: dts: aspeed: yosemite4: Revise quad mode to dual mode
Date:   Mon, 11 Dec 2023 10:49:36 +0800
Message-Id: <20231211024947.3990898-6-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211024947.3990898-1-Delphine_CC_Chiu@wiwynn.com>
References: <20231211024947.3990898-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|KL1PR04MB6784:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 295ff069-cf1e-4531-29da-08dbf9f3e4bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V/kydyFmShhZpu/JArHEorFimsdTk2ev94Z9wEjCPdATuiLkPyci3y57p3uawYzbwSfMXYBV9rmNFGtVi1xvn5MVzE6FIgejqDuq3A4GqCjl+X8OfUfIzFTCaWYV66hJGKkrUaMsb4qu6zx6wWirwBOX4Y8LpChL56LvQuEz61Ums+2DUN914LLoSlpzFztvVMXZSEqA+CLNiATzqO90F29kMX/q9ZEPq9QySVpIQOeBf/gACi/YqTNiEBLpdbTDmRHSAsTNEbcu0fYz/Yfrm4wYRQfnfFKMKBcjI3zyoUKHSqksbGBaKtlYJLrQkA9Ns2eIaH+f0OIyCFfkXT8S2P8DUrjpjY280V7Ys0uIJNSYr1DT9LaWLOdNbq7YvTpFHZQbMsFitdcJ8n19x23OuTPSFgypS7ARVS3PuP/7iQ9LylI8mtdjZ4rcRVMFK49MwhDBoi6wJt89kAYKJsFjC5ckcmb2oJWnj4xgc4uBKb6zpsFfHK0PxcNj+RMYkC9Vt/w5FNu3wzH4jhzT7CK5v8sRhPii/kgJCf0cTeMvQVM4jzo5AYncXR3ZPCetigpXmNGTrYyMjOns9fb5bZCNFQM3IQzDXRjTiJVSYk9r1NgKpjz5I6cFZFcfhnJRwoIHMm9TUUEpmh6VDKCGcDg7/94QzbH0ByI9CAqYhGiKytxBE+aYHg9j/jF1DSZLgEiZAoV59do14nPUrpWEVqE34A==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(376002)(346002)(39850400004)(396003)(136003)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(36840700001)(46966006)(26005)(1076003)(956004)(2616005)(336012)(6506007)(6666004)(6512007)(36860700001)(83380400001)(47076005)(5660300002)(7416002)(41300700001)(2906002)(4326008)(478600001)(9316004)(6486002)(8676002)(8936002)(70206006)(70586007)(316002)(110136005)(36736006)(82740400003)(81166007)(86362001)(356005)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 02:50:10.6088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 295ff069-cf1e-4531-29da-08dbf9f3e4bc
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6784
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 0e9095c83a59..7fe80ad271aa 100644
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

