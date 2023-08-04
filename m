Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE7076FE11
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjHDKFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjHDKEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:04:53 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2078.outbound.protection.outlook.com [40.107.117.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F39346BD;
        Fri,  4 Aug 2023 03:04:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zt7FPNI9gx/IShYAGIwR+H4xuy4UGD0dT9u2tvYBzt/JxjZYv/2t0qQ6eI5ZFncNYIcD7xg13GE2K9wOek7dEf5K5V5TLe5RR4XDBqcvwqZCLaJFWfsT80Xf217V+hOuHDzhb5ihm2jj16yWCstT8w2t5v8qWjf8VozTDgLBXLABesfxVHsJQdn7vOw/dzwtI9XPfS4BV0nstovrGB2tRdPVh3CZ+4bQ3qUMYKwj6vOigFbFFtbbpxbO6LEQZTuIX9SxGCBsV/P2zZ+5dzI9786rSwtkoFSLng+ekfZqyNHSyVTEOf8uLNyn7Na1QOtX/jvJ/2ny5Dd8qVBBSo40CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CslGI3EcBYmKKbHK4uoj2nZe/+uviADL4ZIfa2qQTQs=;
 b=PsmG5yzsE/1Rn8fMg+vzgeN0SFy4cUD2IPfYCs+FeaPZDjg1toDu7L4YFVy+kBPcTT74emOA3PrQDe7jX5uLQRzJLH/9Iy8UD5ELu/xSOH3CM4K7o1SC3AOFR9VV0oLELAY8lac6AMmuSUr372WuAuYMz14zrpdzXZ6gMjRuNoORcaeInCgOqrr8kAY2Q0QlgJvfvj5OITnP0ViFRmTMvwhKjOl+6MADI3MEd4e+8VEhrmrN2VBgjbxumprnfyl9LgCxIIgk5oTsku8KmO9TvrTOHHf2ZruyuRy0cGsMckaRRMLzdhdsio5dGtRS0cNndIBRoDWnI9QfkakMjgZ81g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CslGI3EcBYmKKbHK4uoj2nZe/+uviADL4ZIfa2qQTQs=;
 b=bJ63zLMx38BDsIN01hb/8fLr1rVP//kUXWD2njboTLniVPaGM9VWeX/XRj+phPIpOnINhdAIpxkjP7AXEnxFTmh7j7VTZ2DDfECdMIj6iNt7FZpcN0Mu3WLXq8CNHkLzRMakcMrK+oKPzYSEhMJPKOKWH/jRM+aLIZ8oCPXe30pix9IdPR28LKYnfLTaBSwWugt+zbGlVUoORMatPisMfRN37TffbgjS5f9+OLIR8ILxx3yDxPAHwZcBInkn/OqbbXFU1/E+FxgR/t8VNHKayDaiVFMF5p1dS/GuZ9vmdj4uNW/ekU6b737CIX8zVG3KGMsY8DaL9ypUVgtibyHRNA==
Received: from PS2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::17) by SEYPR04MB6847.apcprd04.prod.outlook.com
 (2603:1096:101:c4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 10:04:48 +0000
Received: from HK3PEPF0000021F.apcprd03.prod.outlook.com
 (2603:1096:300:58:cafe::c4) by PS2PR01CA0029.outlook.office365.com
 (2603:1096:300:58::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Fri, 4 Aug 2023 10:04:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021F.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server id 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 10:04:47
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
Subject: [PATCH v5 1/2] dt-bindings: arm: aspeed: add Facebook Yosemite V4 board
Date:   Fri,  4 Aug 2023 18:04:35 +0800
Message-Id: <20230804100438.1983745-2-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230804100438.1983745-1-Delphine_CC_Chiu@wiwynn.com>
References: <20230804100438.1983745-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021F:EE_|SEYPR04MB6847:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 86a58a64-f287-46c8-5eb3-08db94d23c4e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IC4+23aCI0od+79UwgA+W2jH8bvUpL9MS57+QZdpQdOcF43sLIY6zy3WUOSQNlVLw6MfG2/RfSYm5wIILJmxlN8NcQG0bG9wfGI9zGGcGWnMV+/d0tW7ysFQzJ2eZhQ8FKDmKHVQpNrZ3mrIKCBZDIU5KrSuXM39fQw0Tq0uTLQqQcD3be08X2RaiEFiD2hojpK+2UNLhu2FPjPj3EcVFhah/3xF/JmKdh2lsKHMg8FC8DlOayMravRGQfdD8Yp6O7YtGEMmMWLtZ40En1fSadGaFS0I0HgVFcm5gbeHKzMwkpjK46/2d/XS8T6EN3zK5G6YKa+PDQNbKeqdXsrWZo8USPvOYGVZgYWBOKshzTaiohDcRiUIgAUSO7rIv1k9n+chjo5yWQ8QqKDc6pyuZa4IIsHuVDIMCi+FWAhLVKrSUTKqFCwooARhVw/duZLrpLuVbDRwuuRksPVPuGewy40qbzuJkjUpMKiimmTmcto+WDJRFQjiVDvTkqsuGQ6EqIPT1ZRLrPh1JOkhRB521GPsbone0u2k7jhOjbwbD6qYpkgNBmIvOOV9k+Rq2rDddCkOcq5vYvDhSTTRdupio0NZDIX16J+e8fL3rXpFWIb5jNiXgSLY0eI1sCo4RmnjVC561FpgXR1d++UdEEylzIQ0mGOklNUbhwy1qM+HoXqlbDdxCQpVsYThFsB2Bs0jIwgUuJasH/Qlsc90fhJ9nw==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230028)(6069001)(4636009)(396003)(136003)(39860400002)(346002)(376002)(47680400002)(1800799003)(451199021)(186006)(82310400008)(46966006)(36840700001)(316002)(36736006)(478600001)(36860700001)(2616005)(5660300002)(956004)(47076005)(7416002)(86362001)(2906002)(9316004)(356005)(81166007)(4744005)(82740400003)(36756003)(6666004)(26005)(6506007)(40480700001)(1076003)(8936002)(8676002)(6512007)(41300700001)(6486002)(336012)(4326008)(110136005)(54906003)(70586007)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 10:04:47.6212
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a58a64-f287-46c8-5eb3-08db94d23c4e
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021F.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB6847
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new compatibles used on Facebook Yosemite V4.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

