Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD4876449E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 05:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjG0Dye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 23:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbjG0DyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 23:54:23 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2050.outbound.protection.outlook.com [40.107.117.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62075271C;
        Wed, 26 Jul 2023 20:54:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlEPBwQ9qdJPCuqNoT+FCLj10QKPhZprX3CfKOuRusWpNRHkVp1kPwBFMGVG78QNKXqpXTj6xeH3mwhR0436guT3fQne36WJAdTct7DnVYk2ML0Sy2LIDeLlVSLMpAHgX/MMen1V3U6Pjm8rawo2rrsNf29srQ1hOdR/FDxvGwW7mx4Glg5DSrusPZLewE9HAFenXv/7v+w4921j4grS47OApG7vBEKdOeZBYm324U+HVYQ2sus025g2lZm7toiIekS7S/D9JKg9pF3OQHxDoMGqoPskp0p8IS/zkMyHVIwnH3NHnjoMFoyRdbrelAip+26nH19/vhCIGicdIU+qaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvwKzWDypqFoyT/5pNg4W+cTRPm+3P1A9+KTXwD9dYc=;
 b=dgThwV6RRvd4jUSg+Bvj9uxCNHEchaGSKZedvRAIVOLdCmDgc7u/CCvDW2t23tQu418XZJOaHwr+J9dM4O+pct94AAiMz0a7IpR5OpXrNnolJJ2CVNHdFnhqppqTeku8sZJtx0OaS/bSBWp22C+tNTp1Qqp1J2xhlzdqvO0pMGHZM06YM5IcxmFs75Z8kvBsEz0/Pcy+Cy4cLsw73jxaHTsN9MNMWgkWDYAMZePbBmszhc20NLrKV6UICj6h9kV8sf/gAlVeUxaCmKSt6JQuZEGNoZjsLejSkcjmOxdj+zxfDWZrGClCMbqXw0PApf8xHf0niVJ2kEP9KePXYz0FKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvwKzWDypqFoyT/5pNg4W+cTRPm+3P1A9+KTXwD9dYc=;
 b=M9fJOmov7ql28zXDImaFQfsQekoJl+StoRTy8vi/dfwmj9zLrfHgcCBXlXTiAL/z/hTt/40ytC06DW5qlfEeYHpcCCvUPQMFx2MqwJgagvtILuTBQWZH2XykSRe4G9TzqYehCdTbaQ7aBW4CxYlyk0vF9CrTKtNa0FSDpsmMXFQoei94xV5ApMoG1zY3VYxC1YRKf6P5qEWIX7P9DKtNCZAPm4WOi0Cx4uCW3hSlABaPunkjneJ1jBOYCo0kWf7mx3/wSdLg87eD4TZtkD8/gllSRhhPO3QVTJ0Ojt+LoXT+8P/zcS0vGJVRIsw07pkP6IR8lGpHD16ZDM5+dn+zbw==
Received: from PSBPR02CA0010.apcprd02.prod.outlook.com (2603:1096:301::20) by
 PUZPR04MB6939.apcprd04.prod.outlook.com (2603:1096:301:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 03:54:13 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:301:0:cafe::68) by PSBPR02CA0010.outlook.office365.com
 (2603:1096:301::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 03:54:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server id 15.20.6631.22 via Frontend Transport; Thu, 27 Jul 2023 03:54:12
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: aspeed: add Facebook Yosemite V4 board
Date:   Thu, 27 Jul 2023 11:53:51 +0800
Message-Id: <20230727035354.1906590-4-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230727035354.1906590-1-Delphine_CC_Chiu@wiwynn.com>
References: <20230727035354.1906590-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|PUZPR04MB6939:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c37e0d4f-e592-4651-29ce-08db8e5523fc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mVgsYnFYysg5+OE5RYnW6kL0fvDOBoB67wKUsr/AyogCd0N//5s0YzntNSaEFXlawrx6rQ+H1dvdG4gfsxqj7O0ItjOMSaiq6f8gm5vL4s3B93whFOhWsQHGhQU9wa208Ogl8s0lZ9u1ne7H5HDsI3/9oK/ikpXwYSbwAgIrOjXHsEhCMYlLSwvHRUM/eAr5aZ5rEqKX5we6jTjmzeZDYWBnuLBCURxz3/ykkKdGBGREGpIIV+yB9kvwGe9CwwKNekzzqqES3WC8z7PntmBYdiVokcQUL0ykcN4JbLB+Ah3Hc7n5mhQVAAb4bcVpxPA0YCkTaXauK4G0ZD0rwUPUITJHibnexQwXmVax2zLpiNbYT6stPI7rcsS3Lra3AsvbTSwHW7FX74hwR5qVG4zOBqtL3qqvxusP34IXfzPtoqNrnu7IIvPvRejVyXGW66sLeW2bqDGoHdC9d430vhcsPKeCJGqdU47o9eOUUEctOIK9RR9glWhIM02V18MNH2+09gkec2WorzFvMpNumcAV/vPbvvJRcSts0QQsPZsqAQJ1kZCyQSlCWWXK6rfkaX6ClRNIlFPOai7bbSvhSI+xPK8WCk21psAXslOog8TjzgAeysRmkOflmZl2Ir+JcaKPcX7ALN7vkUv/D5iapvIVd13S9yTAKez+6uA1mRxxZCHxxG1F5pyp2rZc64hAKrFq6XqaipQjDsbZE5jaVpoZUA==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230028)(6069001)(4636009)(346002)(376002)(396003)(136003)(39860400002)(47680400002)(82310400008)(451199021)(36840700001)(46966006)(2906002)(4744005)(41300700001)(36736006)(316002)(7416002)(5660300002)(8676002)(8936002)(9316004)(36756003)(40480700001)(86362001)(6512007)(6506007)(26005)(1076003)(478600001)(356005)(82740400003)(6666004)(6486002)(47076005)(36860700001)(336012)(186003)(956004)(2616005)(4326008)(70206006)(70586007)(81166007)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 03:54:12.7806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c37e0d4f-e592-4651-29ce-08db8e5523fc
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6939
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

