Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD4278A61A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 08:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjH1Gwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 02:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjH1Gv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 02:51:58 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2048.outbound.protection.outlook.com [40.107.117.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A25A10D;
        Sun, 27 Aug 2023 23:51:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwD0V9F8DCktSoosMwlqvAHvYPJ67S1mp/41maweOvnC2FjLrS9wzmYylOL94ujby5tZtZfx+EsXVpWVmkfDTJg+qw79rgeO4v1MQFOVQ/LHcSvEQ9jMlV6sIqqEYgE127ypQE29yW8QEiLQ9auLk4loLw9zeDMYli3pBrvQL91/DTLV9DY2/tIO0vXX2KML/VxKnfqXIunGrm78hAn6PhT/LR4/wRE/tU51tAisBXMnmoSVZIR2qtOAYIU4UZt1Ss5EmQkUjFiBJr/Yw/CmH96Rc/QStKPIzBzc4dfhW4xHhVM7PMWgk14kh5rqiK/43ZR9GdJ7QtRe0Rr7ZmF3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H53+xw6y1ppEJj7t65dwlPjf7ukfprpesDdkDOIs3Io=;
 b=b2p5R+X++MkzeDUNd1uoNiU/m/uX39Z4qerOoRVEXHonjnWiMcAd9q07/2C0RCYJh08MSpfn8Hwo70ZEf0p3x6GEcRPHSmmgniNyjf+jnvoxNZJ1V/Fy5OCzXYLYvfLpbKyj1/lRDfQnd6zVv5Wj7vdk4R0Ib2SAyoE3ZAmwmGrO0BLAQ9m4ME2RFvYS3UNGRSqVEokrca7UdYtpREEG+AObZk69Xv9yjYk+fHN53G/JyLePKNMcBsJEVH1I5a+/VrUHxh/wI8vy5vk2XJdMMaTn7ZWELAzRBammim1ufNXcM8EmgPtRK9sXh7PnHtPxgxWXtnNp6dtmWZVO+EKUtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H53+xw6y1ppEJj7t65dwlPjf7ukfprpesDdkDOIs3Io=;
 b=itYDEfrWa02cvPhF1vCOAiigEJw9qIYVLwwWAdklPQoITjQyNJ8vuWpHh56qqfEqob0JDInCx0cGlLO8/1ZrKMkO3TyYgaJCnKgqLkFnlDykuf+Eab7YmfgtlWdCI6LV5N6SVn5ArSb+DYiSJVhwr9cIe6EtT2KIKFLcPLe77ebInmdYNC8s7X+7hYSel03fbBbKmxqEYzo0bN/MjktHVldX06AnS7PXzMayYspyTt68y2jadNVS24hWpUCibctpAVkH9bDb0kDl/5eHKkY2PzppjFuk38UhYlg5KzezN6uATGNGH2CM3S5LfcxAXFbAAh+XzuJ2K2S4woFUuPFHsA==
Received: from SG2P153CA0030.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::17) by
 KL1PR04MB6645.apcprd04.prod.outlook.com (2603:1096:820:da::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.34; Mon, 28 Aug 2023 06:51:46 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:4:c7:cafe::89) by SG2P153CA0030.outlook.office365.com
 (2603:1096:4:c7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.6 via Frontend
 Transport; Mon, 28 Aug 2023 06:51:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.6745.17 via Frontend Transport; Mon, 28 Aug 2023 06:51:45
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v12 1/2] dt-bindings: arm: aspeed: add Facebook Yosemite 4 board
Date:   Mon, 28 Aug 2023 14:51:35 +0800
Message-Id: <20230828065137.2332953-2-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230828065137.2332953-1-Delphine_CC_Chiu@wiwynn.com>
References: <20230828065137.2332953-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|KL1PR04MB6645:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 155e1877-41a1-409d-407a-08dba7933ed3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: //iY/1AHTDg4L5cC4+GbPU35dVXDBizHNa1p0ZztW/K6yLb0+Q7BYZ4erKaYI6rCKRfLvXygq/r2zmfRUok2dJYauXFJJTKl8dpZXWHwPovDL/3RPVNLDrN81P6Z7mrB6+5p3sWg3SVmF20H03B+HEGqNOtpNFIeBmsQheMy0J8Gvb33GIz7rEZ2M86H004iZozKwxkOMHlFT2WrtvHiXSyf7/nK2BOkjtG8i1zktjrIH6SywCAtCmCbMoajfDEvm5y0DTaypKXasdYbTgjf+Szi/fZaxY69YV0eoGLpEYKP8nn3wHDv0fo/HXar2P9YUUgUBoEpMMSvTcsW98JilUNldKzJ0ucmv7vKm8TpyqEuDMz+0/aR9ySiFVBcMGkhvc6Cy7SXHOB+PSNtWC+8qhH2E5lnr3GYIN/E6WVNmbJzzgTRhSCXlaFWJBCQ8u/gePeW7TI5AwR6gN6liWuKYJpUoFQETIwBV3gsP/eJEE6LrbRKi1aO5lLoza53BpRf4MaEGJrhRVp8NYQ884nAS+DH1rouzV+7cTPgIpuapSOuGbHcwMUmDNoR6L53GT4aAFbeggoSJeJdFZJGaycV8xuGOogjj6F6D+5j08DNmZbKhtKpiNG6JfJPv6KzgOupANs3yU512iydsc8bkBC/qM0Uzbme7D1/M3Cyv+ROpCg/PC82ZaM35ImF+/aVRx82lcFMHTjuzYhi0cu9Zfor2w==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(346002)(396003)(376002)(136003)(39850400004)(47680400002)(1800799009)(451199024)(82310400011)(186009)(36840700001)(46966006)(8676002)(8936002)(4326008)(2906002)(36736006)(36756003)(110136005)(54906003)(316002)(70206006)(70586007)(5660300002)(7416002)(336012)(41300700001)(36860700001)(6486002)(6506007)(2616005)(26005)(1076003)(6512007)(40480700001)(4744005)(81166007)(82740400003)(356005)(478600001)(86362001)(6666004)(47076005)(9316004)(956004);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 06:51:45.6932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 155e1877-41a1-409d-407a-08dba7933ed3
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR04MB6645
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new compatibles used on Facebook Yosemite 4.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changelog:
 v7 - Revise changelog format
 v6 - Change project name from yosemitev4 to yosemite4
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index e0eff4c05879..23ee325bfed0 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -79,6 +79,7 @@ properties:
               - facebook,elbert-bmc
               - facebook,fuji-bmc
               - facebook,greatlakes-bmc
+              - facebook,yosemite4-bmc
               - ibm,everest-bmc
               - ibm,rainier-bmc
               - ibm,tacoma-bmc
-- 
2.25.1

