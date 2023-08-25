Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F6F788380
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244241AbjHYJZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242481AbjHYJY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:24:56 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2068.outbound.protection.outlook.com [40.107.255.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16E01FC3;
        Fri, 25 Aug 2023 02:24:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSn5LZafFsefhxD9IJyrt8SfVyFrLSxjniYJQlS0Mqkk4kR9dJb2oCBMsudjroEg19n5kPuS+ZnevtGEpT+gfC+DiXQtHCKk1dSt3WK/qiV416nOH/7nJuxDDitdbXddEudgd3AG0CL9sbVQWz1Wig7rePyLpyZOZGxBMtJT8FO7meevNXP/Ujsi9cWqxaHUHW85S0G/ghfu7Z+jYlJwIvTHVsJwPqW2uKMUJ9Ew52yy6lnH/zbKQYykEdKcn0VgSi7mS2acwqdbM/Wbg8w+Wzjsqn649DgjO+IBR4gltIXhdljyHucbHdwIm7wOrqmq6agFMl9AY+BpmDgqxzcldA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H53+xw6y1ppEJj7t65dwlPjf7ukfprpesDdkDOIs3Io=;
 b=dA4FZnASec3u3m8HPnXmkDLg2wKhTDH5Yj/ifLCj+Nyf184ltoI4k8el3AYVbtCf3hLE1gVckJYc2/2aIlcvDQd7DPv7soykSzalodm03XMQPAgvcGj4op9TP/XkrGh88mR4ToW0TMwRwrKTgdKgSmFuu6wpwN3Ul7CeYymXcNShFRvU5RQBJBntl+TBfN67OrqGQpNRgmks02L2Z8FiHQ2tdoPvtIah+CXz44+wDKERBzCI8cxifDlfBecxluiKICiPM3zHoSPinqua6rCyfrlZXch4nQnHJXHNayWcNrGHAM42xj+On6kqS6Rb8H2HTLWQuuXt/qLGYY0fpMV8vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H53+xw6y1ppEJj7t65dwlPjf7ukfprpesDdkDOIs3Io=;
 b=W4nTM4NGTRv0DKSMERbrPymDZqk9SZwIl635dxwICH/0jMQ0yhn3EgJ12KeyH+9RP0biKrLvMyJGirWZg8Z2KdTkij4PWHqzzXLoBswRyLQ7UNEcvAuddRN0EhWdbv2sH92w4NeR4d2b/THYg4rVuJfuZmzF92a7W2Sq7F4b7hwxRBgj9Zy4WGC9+o1vY7/JnzVVjUU0EFwOesKBLZgDX9yzADsiZxj1SpH5WTP/+nqQXrUyiT190tJ0SftZlxP4X8SjLAaE9oIh8x135BMnLFjSz1p5bMGhyQM+ijq0LkkOmPeZm4wG8deRMXfk9gzIe80FfdGmtE/joKTBA3pJiQ==
Received: from SGAP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::27) by
 TYZPR04MB5926.apcprd04.prod.outlook.com (2603:1096:400:202::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.27; Fri, 25 Aug 2023 09:24:48 +0000
Received: from SG2PEPF000B66C9.apcprd03.prod.outlook.com
 (2603:1096:4:b6:cafe::94) by SGAP274CA0015.outlook.office365.com
 (2603:1096:4:b6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29 via Frontend
 Transport; Fri, 25 Aug 2023 09:24:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG2PEPF000B66C9.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server id 15.20.6699.15 via Frontend Transport; Fri, 25 Aug 2023
 09:24:46 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 1/2] dt-bindings: arm: aspeed: add Facebook Yosemite 4 board
Date:   Fri, 25 Aug 2023 17:24:36 +0800
Message-Id: <20230825092438.2082402-2-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230825092438.2082402-1-Delphine_CC_Chiu@wiwynn.com>
References: <20230825092438.2082402-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66C9:EE_|TYZPR04MB5926:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ee9cf36c-f46d-4c6e-5fb6-08dba54d2011
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9MESGvXp36/oDqEo4+hQ0eS5HE68QnDlSgI5K4I6DQ2TJ00ChZkEgUwK7AudmbvrJmG/YDlpwJqaU2XHp9N3LYDO5OoBOhCHJH5hWXm2xu8TLz4qWfmQcGo6js2g2N7yIqqWBsI/bOs7ilclL1gAQl96o6fiI388Eer5CyOlYcSsWelhD6VoVboAkqvnR3r6aa4WSrxW1+Up1pCx1g/taGFlnBjRF2j0nCHEGkRVuohD6+3J79N9q7IhOnrbEnp357XLQjD8vh+HnCb6dyoPMv7GfyqAAfly2A+GhUduTm/e3zp0fmJw7sPSd2cTN89XLdY6U5CHqz7MdWqMVKa1zaaW5gceesdLmA0DSyDf4FqYjLpf0Q7j4+ajQ2FWpWllERcFYteKEP/47+K0iLmHCP7hk2kpVz0LZwow+yRxD8oJ40YdLzxY6rfXZzP+3B7MWfFDPgazaiU5CLpXTiiw/9jn0WY4kFixjhX3kAmPen8UCNAH1sD0pCVtV62jCNstSx+uORzCBsccguLuZ5gZu9Cjt4ZWeKDNlch/9eEy5Nv3Uilqg7GO+3L21eq7XrdxxRuXL/KZFZzJPU0RBvTu8qevz1moL3LESQBT7CkYyHzbSCy4xyyY9Op9BvjwU4Bcl24G9DWGwobm4MoxoNtFEZIfRRZK619wST/YFk6ZVckKKuuPgWwStuk4Gac906YYJAZ+X8lGOLZES18MSV07tg==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(39850400004)(396003)(376002)(346002)(136003)(47680400002)(1800799009)(186009)(82310400011)(451199024)(36840700001)(46966006)(1076003)(956004)(2616005)(5660300002)(4326008)(8676002)(8936002)(336012)(47076005)(36756003)(4744005)(9316004)(7416002)(36860700001)(26005)(40480700001)(82740400003)(356005)(6666004)(81166007)(36736006)(70586007)(54906003)(70206006)(316002)(110136005)(478600001)(41300700001)(6512007)(2906002)(6506007)(86362001)(6486002);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 09:24:46.5100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9cf36c-f46d-4c6e-5fb6-08dba54d2011
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66C9.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5926
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

