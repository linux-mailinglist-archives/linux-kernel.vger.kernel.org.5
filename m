Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEAA776EAF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 05:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjHJDoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 23:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjHJDod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 23:44:33 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2084.outbound.protection.outlook.com [40.107.117.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C952100;
        Wed,  9 Aug 2023 20:44:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4pwpZHUEqtHZ3xIxrGdSCU2bf5cjM9Rl63V5WOP6WfBcWte/RwlAkXnuq2xBmqtQtGsbs6hzewEWB5PYQ+29KJP7LK3W+BWGRf/PGbx8AfOilVMRyvIfZzmyob0Ejh/0YQZRSO0IxmAXA7x5BsGMS9nrWgRUTvuBEURyfBiqSmwn4Lld22+JOPeHNy5V4kTbvtufT4XV2HsTjzXRdStDoK1PsMBbBQ4CzUA5hrHJRskfyE7oJ8+47mVX8PyqrqTVBSVhNpfq+niiFi7Z/0G75kvKlI61p+CQKW6fYkZgSJfd1qOICrQezMM5NpGjyjNpcpPJwOaDxW/TrJHiJNh4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nR6cVdZSs6d5ymIMfN+gkpYp07n3M0sInmtDOVvUTL8=;
 b=QAHta8jSsyyuHce3TdV7g9jNa/GZyU0OcI31HFIPU6ipPLXIzqyzwu77Yj0z1vWGON2QcEz8IDn7uGu/v20rI/8Y2K4z0umJbAM90he6qVcCninSqwos9tyGInlYJWx3vxbuK7KPYEzrlLhQx751Fc1kRsWco7zcMy5vbBLe9Pe4R874TAIxoRS8bDrqXpdEc3jiVJ/rnWpQE+34GDdVTN0UInc9w7znzUdsENz5n7pYU0yJpW2uR4ECvLvvnlvRheSegY+lAS7vR0mqdNfxyanIV5q7g+b7vw8BI6inGC+qZsHyA4SDjbBOW7ctfMZNlpmEHCrmk0M8EXZAUDPENg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nR6cVdZSs6d5ymIMfN+gkpYp07n3M0sInmtDOVvUTL8=;
 b=Fjfl75O8AFKR+rl537ApTqFQOqkIs7er3WhcPrZ2ndb0tBSYwIG2Tt7d8mFrF3yrshCpfZQq527vyrKmdOIricIqEmXBbSr17YkLjGqtsBiUZksD6/pYBO/2Apeq1NLYEAPjmziobscusHFMy6Rj1FR/LgB1XeN0fX+7+rl+VQiZ+E02/aWWnB925/6rF04/TVFEPGuLIh7Ivx7cSsaKBudxUtOZwyKjgH6zUxBleiIIzCO7oAG97MAF4c4oz6KGrt/gfyE8vtTmlw/VdYzyEyUu6IIFRyxVrVPay2gJwlPceE3rvFTd1uson2YC3cPJxa8iVKVB7zTUhpHa14VtxQ==
Received: from PS2PR04CA0014.apcprd04.prod.outlook.com (2603:1096:300:55::26)
 by SI2PR04MB4364.apcprd04.prod.outlook.com (2603:1096:4:f0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Thu, 10 Aug 2023 03:44:27 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:55:cafe::21) by PS2PR04CA0014.outlook.office365.com
 (2603:1096:300:55::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Thu, 10 Aug 2023 03:44:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server id 15.20.6652.20 via Frontend Transport; Thu, 10 Aug 2023 03:44:27
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
Subject: [PATCH v8 1/2] dt-bindings: arm: aspeed: add Facebook Yosemite 4 board
Date:   Thu, 10 Aug 2023 11:44:18 +0800
Message-Id: <20230810034421.742166-2-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230810034421.742166-1-Delphine_CC_Chiu@wiwynn.com>
References: <20230810034421.742166-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|SI2PR04MB4364:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 602e3f03-b811-4546-eab0-08db995418d0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k0JfmRzMd5XdOIxQ2/2OsCKmvKFMx70iUfmLcYLFMR2pH8yGrTyg/3uUOLp8Y3YHuYVWKsHKoMD+7C0cD4f4WPqDXOfq9i6M7c55NbEb8qW0JaIsR1eH82sZrb0+wi4ZAGns2iEL4toJmQRQ2vEQL6XNJcBj63KyclWlS0vO4UiWLZ0MXl77kTHL1ttDN3waYyn7fH94de4H6k6sjA7ich4nIYfaM7rqBhqtA/wC7iTSPYmg6aW5T5wPRZF9UQ642xOgeD3Y3dnviKQtwwiMirPjqbCPy57YsAOzy9OV709mdSE+6NpIuIZ2LkkA+HhsjYfVxYGNB9z70okox42V5BRE+04+aoJ3MBanCpKNOwbZuCS3cRnNek76Aw1elIH5l6QiK+1vkdVxtNg3VQP5jV8RTQOfLmwb2Rb8veq2g8pnjDrDMZMLKBXHngxf2XXjDg5U9YLol7vADVdlDe6B/o/svQgz411iFRzUerq00WnqZtMQtzvS8up7+3S425lcyFlyfvjAJBfNZkS6zG8Xk7ORNF2Nfs+6rQb00A4u9QMC8+oWv+FDz05efrCoqjCNNvrpzahY6SH7OK+CuQdNFgCOuNxdn97ec7lxv0dEYdcbavU18sVpIVZehM21vjj9crc1Pmc1s88smelgtVot4rt8076zYAt2bLjEg71aARih+Ydh8w4L32VyEbmeazCkPE/MJ4TxseAaPu5n99oNJA==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230028)(6069001)(4636009)(376002)(396003)(346002)(136003)(39860400002)(47680400002)(82310400008)(186006)(1800799006)(451199021)(36840700001)(46966006)(2616005)(6486002)(956004)(356005)(81166007)(6666004)(82740400003)(36756003)(9316004)(336012)(1076003)(26005)(6506007)(40480700001)(6512007)(5660300002)(54906003)(110136005)(47076005)(4326008)(70586007)(4744005)(36860700001)(70206006)(7416002)(36736006)(316002)(2906002)(8936002)(478600001)(41300700001)(8676002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 03:44:27.3204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 602e3f03-b811-4546-eab0-08db995418d0
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB4364
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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

