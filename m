Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A49752F72
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 04:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbjGNCfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 22:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbjGNCf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 22:35:29 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2084.outbound.protection.outlook.com [40.107.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE5D2D5F;
        Thu, 13 Jul 2023 19:35:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgMK4LEf01wcysx7ip5ASdjDDfe3+TdYk2pWu9Gp1Ul9UYahdw19Y6RZdJPPNAGVhPpE9g2rO7bjHDCMEfkGE+81RLr0yKZo/XmcYF1MNniefTtnDwgMMH77fphewPO2gfAS751vVd7JKbANJIeS/0em2ODqpb8Ok0MpJkHAdRWvU3vZQEa4hWEHM/eK357Cx6kJzQtfZikSXQ0vdmbJsNjMk+AJoBOI5tts0ltH3mN/jg6jrcDP6OS0PDxxyU2Ey4nHCd0ta1Rir1EgoRP2a49ATkEo2PRQ483/ZRosIFgmG5hXVDRFjp/osxAGbCJYE6lTYhMY0u8FsQGTBn3xGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvwKzWDypqFoyT/5pNg4W+cTRPm+3P1A9+KTXwD9dYc=;
 b=eCUOUiDbDyMDWKvvnGVGFd7rCPpcMCIXG+vUIjrjwV14MhRNLSCI9IZ0orC8eSI5ipIinj4M6k8jmcODrqFDRyg+xgNqEIzUepe4BW9zTEtTFn5TPaTjzQ8S8/j5lmF4vjWCiwjTUgsEDr/JtUkzBmMeWkoAtHdILugGvM4vLtDEftrJtE15Umw9MxInPftDm9NWDfqeGn+Eg1i2J41q/HmfS8tP4oOXdmOtxdWX33Q0jlcQFJv8Fxl2IKH9kW6ENLg2PoCahZbQIYqWAGylrdKgvmsOHsgkOiZBjkWX7VLzmrFpakKG4zAw+b/lHQ2O8l2hs+rGWY9VHA8i1CHtjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvwKzWDypqFoyT/5pNg4W+cTRPm+3P1A9+KTXwD9dYc=;
 b=RuakNdgcJXhGDkH/W5a/MYLyYyZWCrYQzXs7NVD+6qbm1vNpejeYi/jEtF9oLw8bO2JV1QfT8tTmDhKdGC5Qdzc8bVKP6gkyim6WMlb5WJV8N8Oy5m+6vSaZRGve3CDtEB+KalYXiVq72/0kQ3VBeP/Z+Oqppi6ceS6KRjDMdibQqsAm79HHwN48m2xCVTSCaDbgpEkX09CpET4IusfZyxaDZn+bP1EaXKPxREa09Qcx6rEiHOBvOsSio4ekId3fSgpQZ6Ed262qpO43kE4esRh7hCcGDai28CJoWfQfXqR7H3GIpqYw3iz+lfwwzYbCfc6BtPaWO/UToLQPRtoVeQ==
Received: from SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34) by
 KL1PR0401MB4243.apcprd04.prod.outlook.com (2603:1096:820:2a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 02:35:21 +0000
Received: from SG2APC01FT0057.eop-APC01.prod.protection.outlook.com
 (2603:1096:4:0:cafe::f6) by SG2PR04CA0172.outlook.office365.com
 (2603:1096:4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.26 via Frontend
 Transport; Fri, 14 Jul 2023 02:35:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2APC01FT0057.mail.protection.outlook.com (10.13.36.138) with Microsoft SMTP
 Server id 15.20.6609.14 via Frontend Transport; Fri, 14 Jul 2023 02:35:20
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: arm: aspeed: add Facebook Yosemite V4 board
Date:   Fri, 14 Jul 2023 10:34:59 +0800
Message-Id: <20230714023502.3225096-2-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230714023502.3225096-1-Delphine_CC_Chiu@wiwynn.com>
References: <20230712073752.54624-3-Delphine_CC_Chiu@wiwynn.com>
 <20230714023502.3225096-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2APC01FT0057:EE_|KL1PR0401MB4243:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 11998584-762e-478a-9ebb-08db8412f850
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iqIko7sseBEl4pd6VdT4ShmLqi0TlPrrOmGAy1CxU/sZUjp6QcOmo0fY3hE2wTF5A3ZHQdmckR79X6P7k1Hy8H1mU95Qb5qH/Re6EXsfGyKMwU3C0jSIjXKGYOvIMAbt4qIpLyg58ww4ta6CGt1neq49CarCEuJaf3JZgE7xVO9FKE+QW6Zqy6mnmOlicdmIvyK84IGm5Ap199afawVjqgRRd72VSexexk4v+s/tiIC9koSQ7NOH5zwQ7RDwPS4bY+TngZlw+KOue1kFMES00GsfhaXrQxqBGtfPhTD6kvZzhW2Rc9rlc66U1HN8OrCzrKcUcahhRx2fWtPWwgfVErKihx0kWWw0M5uHr6FFSmUwseMcWmWvAdXArssAfE7nmgSVReI8yrKReo3FiIaUeEcxfR49cISqLF/tzW3ALOBlmVkG0Gqt+gqQlfx15TKFEeo/chb4b01cTWfoqGna4k7zH7NZK/FU7Md1GI653hFbRIo40/HzxvnnKDIWJ8L3qd79WgaaRBBjxqrpxssPKQqX9X1t3BkIy6BS4iz1Sb6urLpROTTDRUQH+s2+3Sh5sK/C9aYhfzujtzWEo14M2aeu4vFAkfDx/r3yWKLcWMmLxwNUumLenjB6wYtpELub3YnqsR7Aavj6fi4agBsvGBaC30zqYRhpdPZ/uxUSc3odRUaKwofKXh9MngFY8z1k751iyKF8uMb0S/2q6cqD0w==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230028)(6069001)(4636009)(376002)(346002)(136003)(396003)(39860400002)(47680400002)(451199021)(36840700001)(46966006)(54906003)(110136005)(41300700001)(40480700001)(4326008)(70586007)(70206006)(7416002)(478600001)(4744005)(5660300002)(2906002)(8936002)(8676002)(36736006)(316002)(6666004)(6486002)(6512007)(356005)(82740400003)(86362001)(26005)(1076003)(6506007)(186003)(336012)(47076005)(9316004)(36860700001)(82310400005)(2616005)(36756003)(956004)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 02:35:20.4930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11998584-762e-478a-9ebb-08db8412f850
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0057.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB4243
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new compatibles used on Facebook Yosemite V4.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index e0eff4c05879..2ef6821e3648 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -79,6 +79,7 @@ properties:
               - facebook,elbert-bmc
               - facebook,fuji-bmc
               - facebook,greatlakes-bmc
+              - facebook,yosemitev4-bmc
               - ibm,everest-bmc
               - ibm,rainier-bmc
               - ibm,tacoma-bmc
-- 
2.25.1

