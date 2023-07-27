Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C13764498
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 05:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjG0DyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 23:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjG0DyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 23:54:10 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2073.outbound.protection.outlook.com [40.107.255.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C272706;
        Wed, 26 Jul 2023 20:54:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUyJbVEAgJL18kYOuHxb8pgT9KUMdehoEB1HNlKmAhI5H7XQDaBrZ4U4lDJZUSNAnPtNg+vwP2z9qqYP94Ux34D90lcDa17TsDVt7yJ323bJaizitp6jOnnt59wnUfOpS689Sgv8ZTuycxcIT6DBbvsHCLdDmaqZa4oVudM3fqMh+WYSiRJOuf9+d/RAagj5jRDWPg2AhLYfZyA/52XhzlnAuzYFEeGk0+PcHKn2laHpqczLQgYWplMLmxd3l/SuXMpq0TpQWAj+V8W1hCyziUYq/RpxSwmQzwD6Ldlhpzf1qQTk5nKW63g3SlrQTy28HshfezD/HGmYHltDMQKzTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CslGI3EcBYmKKbHK4uoj2nZe/+uviADL4ZIfa2qQTQs=;
 b=TfG6yRlr7MBLZRrEtTy+5T7kIKdimerurSGcNWR3JpSpA5gOpTRX7ySDMYV16LXzqZLznwIALwdk1LXw5+n45b0WqP5PwWXm9ROBiknC0+fv/ZjUELqWYf2ndgFDHMIDFUIoMAme/+dL045BDDfUXmE5J/zHX618TwUszrphCBUhtnZ+Itm8tqdZ1kdWrPzKCNwuTc1C5Q7dEsNR81DhcQaDkIszICRAGNDnZwTi9ktwEye4tpBKiPtWcmNzVX1ovnPeasJO0XT1v3Yvu1giIDObjNN91Y/3mowWypn0BYvcZvhMiwqSOXPMkhGPm9FcTOSAaw2oTzIqCyWiL3Ve5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CslGI3EcBYmKKbHK4uoj2nZe/+uviADL4ZIfa2qQTQs=;
 b=f8MOhJXTEOmH9NtEziw7xeueGZCAbGw8nkRlxAuYmCndbI5l5dYndQlbFVtYZv9Vsl/ncZLpWwgyOxIiFxGzIA/CNrlcjeVdHQxh9ZIFYR3dTjJvQOPrRP35AspATEI1m+hMid+eErsMnua3q5o9/9SrWtJUF31AFwOVfddTwStEbLX4o6OXZdh9Zrjof5oXeQ1weN9+2xoxHfqbFTI25NrZjY9L1VD5sCDiez4xzMU2PPjqR4/exnYjsqva6+of9ZgcJTcvUV4Pqrau4DkMtQ8aU73PtZ6orWK0jHQA+UDMOc8Ns/zRZddx7NgbJRUb0ASbQWbFvMujlQTglABJRQ==
Received: from PSBPR02CA0007.apcprd02.prod.outlook.com (2603:1096:301::17) by
 SI2PR04MB4442.apcprd04.prod.outlook.com (2603:1096:4:fe::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.33; Thu, 27 Jul 2023 03:54:03 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:301:0:cafe::96) by PSBPR02CA0007.outlook.office365.com
 (2603:1096:301::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Thu, 27 Jul 2023 03:54:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server id 15.20.6631.22 via Frontend Transport; Thu, 27 Jul 2023 03:54:02
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
Subject: [PATCH v4 1/2] dt-bindings: arm: aspeed: add Facebook Yosemite V4 board
Date:   Thu, 27 Jul 2023 11:53:49 +0800
Message-Id: <20230727035354.1906590-2-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230727035354.1906590-1-Delphine_CC_Chiu@wiwynn.com>
References: <20230727035354.1906590-1-Delphine_CC_Chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|SI2PR04MB4442:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d408b127-6805-42d9-950b-08db8e551df5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kQuxRIQY5z+ufn10SClxptvCA7GTCgcP2DFwArzhXwQ+802iBRFYv9gNJCMv1XXtSxULgWx79K02gcFlyAMTo5ECP9fcZJGbbbKMmezgmbWXK4mc10feSv/nyn86l4cp70U5t9dSxMNgjTCaGru2iX6lfH4N0+JHSajnuCdEeovHEPvg7tG1F0Azp809bhocGDM1r/GPM+rTUuEnLUwl1n89V1kuRHlk/dLqvBigmig/e2U0123lUxK98qlAm00l3ok8VJJq6xKbHJ+DoVPLFgiioC3vIwNqZwpIppZc66eDXk3uprVAgSLHad9HcRWB1iIA2PdNHVWgYQLGoW7iqO5dQnfCQnGm7V42uC1/uoMhtvA/VtPH8SvQmqR+rMoPQZ2OkjJly4yH7vKKW2W+23P+DIKsPazChdAV+OSCvcxPBvqED9t2nLGP++R2j/9fg43XKQONKc1fZu1di2db9Jmp+AyeOBDbvD9RG9Loet7qgCVUPP9KqtnsEQ3V5vIJbrM92qNtcjY0tS+820pOn7abL9oSCrCmlBuTbmmaCn5JhgirBotnDFaHEyvhQB/8FC3ahcy6AfbvW2yf4L6bz7pzMQ7ynXLAKvHcw8EYTTbuvEiiSgNIqDurqx6R0eOSd1H663O8umbcUbxqICnTsKIvIpQOl928/o3AIJiAx/m+6u1A3vqdcvfK95/79xOqHspFvSMMWMrQSSeYRXbX3g==
X-Forefront-Antispam-Report: CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230028)(6069001)(4636009)(136003)(346002)(376002)(39860400002)(396003)(47680400002)(451199021)(82310400008)(36840700001)(46966006)(4326008)(26005)(9316004)(356005)(6506007)(1076003)(81166007)(82740400003)(2616005)(956004)(186003)(336012)(47076005)(36860700001)(6512007)(36756003)(2906002)(86362001)(5660300002)(4744005)(70206006)(7416002)(478600001)(40480700001)(316002)(70586007)(6666004)(6486002)(41300700001)(54906003)(110136005)(8936002)(36736006)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 03:54:02.5773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d408b127-6805-42d9-950b-08db8e551df5
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB4442
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

