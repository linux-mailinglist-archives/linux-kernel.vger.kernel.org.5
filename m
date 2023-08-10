Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5AC7770DD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjHJHAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjHJHAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:00:46 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2063.outbound.protection.outlook.com [40.107.215.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00632E7E;
        Thu, 10 Aug 2023 00:00:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOe2X3RBZ/GNHj+EzB+/Vj8YhiZPzwco+znoyrkuB+zdRGX6wyAG6wschluGdaurbxmmaEjpC+9v4bveaZlIZmbWa9f3JprlDTidu7P75JGrK7OjvQ6mlnlu9My75dGTvXO4ERGVoCV00ErqlDzURf7XHaU/jwQyWZ1er0O19nWgAuYbS0rMczExUaqeHD/r6/urb6/5fmDzO5s94Khw7Wx1t+iiAyYcoTCjZICJjJ/F4OnYBypvl4yEBZm+/Ioe1D/viSCqZDiWdMDOtbmkjDsqYjLEVitigBqTssFrHDkAEBES+gdB8Bfoc8TiDOxT2TVpiRbRMO/SJiMjCEa1Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nR6cVdZSs6d5ymIMfN+gkpYp07n3M0sInmtDOVvUTL8=;
 b=hUz3q6eqzjF8FSrGmH0j0msD8rVsZXFvVRyCHC+2tHYfXLx2+TrR+U1gSwalyrQwU+P2rzzAo0TgjFEfREIOvZaqhy7S9M1cW1Ay/pp+VCNAfdCQP0PtXoBR+Cd83Gxb+9OKXHW5fzwxqswwd4AmJMSkWqAbmXBpUAdJmk4Qa6v9zNIEBbptL1jmnG+jJRYxFlVGMYKwNV91MFJFas5ir6E8wbjIvwBYTSgxWN/5mHHVIXMH5YLx9F61SWqGHr2Llmf6Hc3XKfyC4ldNDSOBKwLIFgwTlPJ0ocoMD5r+oIvZrr8Qs7tNCQWwbdWX6yqzUieXp7e85cHbejGCvC5ijQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nR6cVdZSs6d5ymIMfN+gkpYp07n3M0sInmtDOVvUTL8=;
 b=Oxic9UEuLPe9Fjp5QbWWN9DzvdwzKskEhpr0h87K85Ec6n5zCZv8dRXnyYWsnKJTx1QPaJadm9HYGXEndqw3tk0MRF+9srKMKHeTJ/GeoNwYTMK0kFnVkxgYFtQMiq9TFjZFXu9WMAfjI7lUNdS36QQSM9BNECMRhOgJ8TL9pNX3CGJRlmWjI6sOEUUT1GuoYaC+R0F00ZFghsN474SMHICnEapYeELod7DlYgOkPCae1ovpmPpbOJmBPVXZcUrKoFms7kY7kN6O5Pv/qtEUYj0Vx76g0vaq6bLba+qqRcoGvgWLzZ9Kx63PL86fLU/RGfNWN/QcBw7Pf2qvGEDdUg==
Received: from PSBPR02CA0012.apcprd02.prod.outlook.com (2603:1096:301::22) by
 TYSPR04MB7048.apcprd04.prod.outlook.com (2603:1096:400:47b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 07:00:40 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:301:0:cafe::f) by PSBPR02CA0012.outlook.office365.com
 (2603:1096:301::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Thu, 10 Aug 2023 07:00:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server id 15.20.6652.19 via Frontend Transport; Thu, 10 Aug 2023 07:00:40
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
Subject: [PATCH v9 1/2] dt-bindings: arm: aspeed: add Facebook Yosemite 4 board
Date:   Thu, 10 Aug 2023 15:00:29 +0800
Message-Id: <20230810070032.335161-2-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230810070032.335161-1-Delphine_CC_Chiu@wiwynn.com>
References: <20230810070032.335161-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|TYSPR04MB7048:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bb9bd00c-b8a6-46c7-51bc-08db996f8205
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mOPqu5/W0rPC52TW9oSqPvS8Sf9oa/7LehPoWWh//GCCc6aardPzrirhXyC1oLQh8DBMNVxW0ZBHyFVJT2RRiQrCj4zorrD07o3WZ+HwjxJ1Weytx2qqOo5Xm3wdR0mre0mJezB3CIKVhLKDnhGVPQwfZsXmrRdh8YL6J2566pD0IimIIymu1CE40Yw+MuuRNYZUU/inz6Fwc449IAQiBRPxNRIWeCNOmMcQvRAGRnIK+02a2gNw5XEOqI9yDNmrJc663f+XyHPTHh2nH2uCmpssnKRF7nivLW4Aqd2BZfIr2/IWswgGteb7QjKJX/lnlS84VEx8Nll5AOQ+4wHfcYAF1YOFYnXDxJFHk7mVXSsauyig88/WdRHCEtqOlAgMeQwWYBQZrUMyv5g7RvpBfvZIBpaH3EN+8vJ38DQFov1sJQotF7gumCGhzY4MgHrz/2HihxfYw0uLxcRrzLEpLEs7jvGRaU8NMWY/L3Qj2BfAGE/ucjvsbLlvXSJ/jBsQcJhdc4FgAn8tFKrbX7422k9+78WtZegl6Aku7Bk7BOhiQW19+hzk/wfi48I3osvRR8pi98sx9klrdJG/5f6N8B9xv3NOabGjljXGoqIV6W7UfavorkcU6z/cl6rUB0ml9p0GwWIpVtaKi09zBofZKiVY2Tvrr0K4uosr5WzRzmjguw74fsM85HNKj0f9SgAEI0PLeX9mID6YHKDlNteyWQ==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230028)(6069001)(4636009)(39860400002)(396003)(376002)(346002)(136003)(47680400002)(82310400008)(1800799006)(186006)(451199021)(46966006)(36840700001)(6512007)(54906003)(110136005)(70586007)(4326008)(70206006)(478600001)(40480700001)(5660300002)(6486002)(36736006)(316002)(6666004)(41300700001)(8676002)(8936002)(1076003)(6506007)(26005)(82740400003)(86362001)(336012)(7416002)(36756003)(47076005)(36860700001)(4744005)(81166007)(356005)(956004)(2616005)(9316004)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 07:00:40.2363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9bd00c-b8a6-46c7-51bc-08db996f8205
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7048
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

