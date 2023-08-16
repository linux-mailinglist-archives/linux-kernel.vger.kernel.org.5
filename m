Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA9677DA25
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 08:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242018AbjHPGGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 02:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbjHPGGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 02:06:01 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2066.outbound.protection.outlook.com [40.107.255.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8231BCC;
        Tue, 15 Aug 2023 23:06:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItzalaommkIDcu2z53Stnn4qmkdHVl3rC7CaRXwN6huGkB6db/m3+zseXB/OpSRBN27WrAlsJQ/lvTNKuqbOuJAekoQ68llfQbf/CUGiK47PofLO/fr1NMRokoRQEunKluRvgL0QT4q2sOYuoa/xkbfjqwyq/MNBPuIEB0nedoA/mQ6FhqRs7PEY0Jz5MjLvRCXgz63z3YQBEYbNT0/N/zp7TB61yoFx07A6KDDyIMz05iJ81dA1kDgfy59bh47/pydTMrerqTb49EOjNM5QZHQeNgL1jXvmZj4AH+IdCb5n0yQ+xQ3altcvaDhoV+iMHhDwpX2j9XxkOI48wmE7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RjaXPI86eMuwpfwOVjBsvigtaVAIhbyDBxa6IEPPK00=;
 b=JT6An8s0eKfqehf2ss5Ee/BybSoL7zh7uQCCprfVt/Fb+AUhc9J220aw75bFA7Cc6csXjtCb/vts/OXYE5sBh3ZyM2NCu0Ji/AyIInnfTLibojut89kvGo3Hs6cue+c3/HaJw4oFkYTUxJfbbtmB6qLs5L0sOgMB0W+uMeOz411drJD2ZdmexMoRHVY+5H2IKx+VuZ5WeiRNRc0ttdKyZh2aTbJi8JGs4dnV4yOwktDaCS4e3f9kBFy5z/w+a7kXsBOjrxZnr7PWw2uSJL7uHDoWvt7VVpPHzmKirxEQN5VflwcG0FfDOcAqCj1giS2YK66wByr27fTvlF7V6bivVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=lists.ozlabs.org smtp.mailfrom=wiwynn.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RjaXPI86eMuwpfwOVjBsvigtaVAIhbyDBxa6IEPPK00=;
 b=YaPKEMRMToM4q4xZcmdTJVKAzPJq77AQtxtjVDmjP7wQqBDSgbN2Vcfbn70COFS4/q0sw8pLlaRYZvkoDlRVjNjAmynSBTUPYykXJPDhoREFB0rAg2l9vyhR2S2NkVftcVylDkqFL/M2AihV4M2+2aDYEqlAuUNzWltD3BQj7oG9g9IhnwZdG1GI1seZ7TjQC/cjxXNSqDfDTgfJj8qNhdNIWLYx2co6Ifq8KhMxrzY3ugFDnOTQNTM2Nd9aLP+3R93wbfTUYJSnDApUr4E0JxRKCUXT6q+KyC7A3bYrCvriY8oIxxUjkN5TgmBP0/BK1pkHi/mlGD4MnmIr7tBxNw==
Received: from KL1PR02CA0015.apcprd02.prod.outlook.com (2603:1096:820:c::20)
 by TY0PR04MB6176.apcprd04.prod.outlook.com (2603:1096:400:32b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 06:05:56 +0000
Received: from HK3PEPF0000021C.apcprd03.prod.outlook.com
 (2603:1096:820:c:cafe::62) by KL1PR02CA0015.outlook.office365.com
 (2603:1096:820:c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 06:05:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021C.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server id 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 06:05:55
 +0000
From:   Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To:     openbmc@lists.ozlabs.org, patrick@stwcx.xyz,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH linux dev-6.1 v1 1/2] dt-bindings: arm: aspeed: add Meta Yosemite 4 board
Date:   Wed, 16 Aug 2023 14:05:46 +0800
Message-Id: <20230816060547.40489-2-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816060547.40489-1-Delphine_CC_Chiu@wiwynn.com>
References: <20230816060547.40489-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021C:EE_|TY0PR04MB6176:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0f441caa-4214-4f13-35c3-08db9e1eda68
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AG1bf+9OAXfuCtQ0xhQQw+H+qRaBJOpPlseQ1pGez5AjEChfTy+QyfG8rxYwAzQJBPmCVfIu4xQYv58WHKlESH7y/4b1lzbwHUqMrP0WGj8EMju+GCueUKOvgX3kbYsEbLLOi30pecLTAPOlUnDmUWZpS5gzvsNrvM+2UM/TzfTvwi7f8AmwFY6XUN/Qn/FKzQ0oWDrYmzaUNo6XyHGa85CoIRIn9OH08UNjH2seUmqQS++VNfT8v7098wvsqhxWpg/f+Qh3seNFtuON3LP2tQV9td9Wb/mwG2BDTBjm3Jv972M40+725cKn0Yh0R4Kd2JMJ1uDdEftBbHJWFtf+Sc2qSJY0KnGTbShacukJj/DVf5aGSlg8e1oZElgyZOWhsKB5Xew0pT6k6IPRcy5aqpgxptDe/26J8logpDz50dDGTQF23NQQiTmBh/1J3wUIH8a2UudtCp53r42oUtjDVdPz0i5JDT7hH0xo7uObjrEFtssmHt6dlnUzBILsKqmI7OEz6sV/lE01Mdc0/cIkaXpcxTB/1t11BOpan+SCJlHgLUStVuzLxOeyy8Unjim38vOs2m5e0tkb0xusjL8PO4cXEQtLaeI8fPFInznegysm62hAXCxu4ZlnGCd/lCzW6ZAyT1cAevt4YA38A4SPhWDcxSKejnmIifnVUbdAPGgTV4agofWSuvjYudRwwDnW9dQgWiUwIXl/BukR703A6A==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(6069001)(4636009)(376002)(39860400002)(396003)(346002)(136003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(6666004)(36736006)(70586007)(70206006)(6512007)(6486002)(6506007)(4744005)(2906002)(478600001)(1076003)(336012)(26005)(9316004)(110136005)(7416002)(5660300002)(2616005)(956004)(41300700001)(316002)(47076005)(36860700001)(8936002)(4326008)(82740400003)(8676002)(81166007)(356005)(36756003)(86362001)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 06:05:55.1339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f441caa-4214-4f13-35c3-08db9e1eda68
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021C.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new compatibles used on Meta Yosemite 4.

Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index fb4ce5df2fa0..6b0a6683ccae 100644
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

