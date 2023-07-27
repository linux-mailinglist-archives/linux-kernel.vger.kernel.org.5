Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0F476447E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 05:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjG0Djj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 23:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjG0Dje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 23:39:34 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2081.outbound.protection.outlook.com [40.107.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922F9106;
        Wed, 26 Jul 2023 20:39:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giGqeptczvcGykcXUdNIPTZemFn6XFAXOcqoEFw4aHHundGzhc2s7QjfYak5okfOxGXa7wIMuED3pGjkobzVSsMVZrmrVguzfIzSOnkt6dd3Igl/21798ErARgHtceBH6zxBQXWQBFycnNVxEOs7KBJPzYV+mgzsoBQQKt0i1qVQBO4jlTxRxqlT8HkmM7tYbFBLX9OURmPEVJ++7I2GkqyqmYeXiAKrlbuUQRsDKBXGJrYsjYHWq9ZRsFa1bhaA+mdE4n0Sex1rgW03zaPHeXcwkcAsRCzD0mNDJ3mQ0YTAo79vPNvNsYTPJAvRq20Balm5yd9JBV+fMXlbmtMlLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvwKzWDypqFoyT/5pNg4W+cTRPm+3P1A9+KTXwD9dYc=;
 b=MSL8NF7WX2ITwSzH6Y9/BLAfN6apNYT/riMCxkx0T0Wsx6omJSSOXUi4fWi/D5K+OK3et6DYre5il5R0dQZ309NRDie9dbkdeGEEAxC/Ft98QJM5Dn5sjXcr0RvGRd22TIgYFJIErkf9ZcF/e3DustazLQVe57AVJrmEoe4vX7CxWBmSyujCR33Xy1eQraBy6yGnFLIxNpVLkKXOW97MXuz6VRPa+ZRXbC9o2qksRiVRY09bBOtqPyy006QXcVaufwnaX86wFnYaPL/FlWuWuaiKHUCCJxI17BepJUtpufgEYDUeC4cF4w5pNFpkoz1dr0QTqVB/yUJgOd0VQyOkMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvwKzWDypqFoyT/5pNg4W+cTRPm+3P1A9+KTXwD9dYc=;
 b=i+5pSiCmDafloBz1LQyQep99apFZcbeo/SrH4EMezGmsN2Y1cGMh38Oofca2kKUdf5Xh2/coX11NQZPFcg0bW/aq0KyjDHwJ1xc7iTBNhKUWYOA9Fp7hEIZIVtzzYq6liDl1Q9zSyJY50qohOolwvc7jNlcrIWQc0UUptTuedHepjPM6xhHhYwXdHfUxntPQn6WwDMVBttwFU1i8XqJKhMipz9+yC9CqkIDwLtFgrBchJGvTf+W9JgrN3qBibt8OG1RCPoGmnuHi4Knq2h/NMkH6TXrJm+Nr278XV+CnzJaQ2vErWwwGIxSXFJ3gGaVyLVYbDsEjcfALE8JZUUZ+mg==
Received: from PU1PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:803:15::31) by TYZPR04MB7030.apcprd04.prod.outlook.com
 (2603:1096:400:45d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 03:39:29 +0000
Received: from HK2PEPF00006FB0.apcprd02.prod.outlook.com
 (2603:1096:803:15:cafe::fa) by PU1PR01CA0019.outlook.office365.com
 (2603:1096:803:15::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 03:39:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB0.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server id 15.20.6631.22 via Frontend Transport; Thu, 27 Jul 2023 03:39:28
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
Date:   Thu, 27 Jul 2023 11:39:24 +0800
Message-Id: <20230727033926.1904529-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB0:EE_|TYZPR04MB7030:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9d58552f-0107-4913-d6f7-08db8e53151d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AulGmtcuaCmPUwr4+Vli5/jDf7a05vZ3oN/LRBLkisfnpSKWDw5JzQK+glVSqzfk0+OFY+JfUXWsdc16IpJXmNubmc4/FFJH3jeWdanppxOzLQiZQrSB43/2PKJNEKpaRcXMCT6j9RqzQGHYyWgHUHnHZRUNE7xwI+sAzsQfErFPNMCii4xh/K6/ViCbNDgDc/Gytt9ABt9sEFwwnJZUtQ3obLkmOQPKiSQmtP5y+rj53QVtFruEPzTzaaBVP/PQMUA9NYsvqzY7hIsG7zjuS39S3WwG85mEE5lzUbVIysKG/zohLgtZi6mZyYl9U79itYDAZd8pD4uBvHXZoFndr/tEevcGu6zRuPZR+32BAknCbF/DZAMIwh9D2RkMHIXsg4M0vA7/5Cn7Cq52HKn6VaBPc1TA2jntf/aWcPDJ8oSUcWybDzSzml1yNLfUVYeBHzCWWycqifvdz+xE3/Ro5lDdE1xxAmkZYLCtmCxSZv3YKCgWlFzrnNKwdJqyEWOYDuSiJ6FQJ9UDP3HFp1U4G/JXtSDFImzQ6nxj3xPqDbs/YZJl9ovQ5OCOEpkukScaO9SPX+7Jp215HSup4L+vLobX4py2S8Wh9FLFIKnYzKkuCWlcWgP1KQL1Wfa51v31e23A5CA3ckTMZRRKpGMgGF2U/JUQy4O2j2dwmytKJ8R1VJRlY/JCwY1Dni86KJG4uwsdPzG6Irj6NpASnT1cVA==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230028)(6069001)(4636009)(39850400004)(136003)(346002)(376002)(396003)(47680400002)(451199021)(82310400008)(36840700001)(46966006)(110136005)(478600001)(6486002)(6512007)(6666004)(47076005)(26005)(336012)(1076003)(186003)(956004)(6506007)(2616005)(2906002)(4744005)(70586007)(316002)(8936002)(70206006)(36736006)(82740400003)(9316004)(5660300002)(8676002)(7416002)(41300700001)(4326008)(81166007)(356005)(86362001)(36860700001)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 03:39:28.8264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d58552f-0107-4913-d6f7-08db8e53151d
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB0.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB7030
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

