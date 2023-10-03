Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07F37B6707
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239847AbjJCLBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239846AbjJCLBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:01:46 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01hn2219.outbound.protection.outlook.com [52.100.0.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F230C6;
        Tue,  3 Oct 2023 04:01:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0iv0Ae3X2cCCHMfK75aj1fpblxez2De/Z7nIH1cNXxcNP5O4KM1T7bRegBLK7DHbtMAPtvul7BdLiOFMfWZ6YEdGngMGgtbz99lemI8/bj4wFhqAgpFtcZsTucvyog3OK40VqGrggEZETnpZrAoI3opp0pAlML0krVw/g65zh4bWDnYyJmGZFH1rsZzTHT+cd0fCZja1x65ld6qBe/V3/Xs04nIdZIiRM65MKHaxtL2tM4/6Md8AYr3qAthB4JIpVysWomfY9bwWq3x3pWfZEjYJ/EyO1SupO+8obHUWh3C0A6te68Tc+8kJxK8mkZPalNcgn+tHFjgOlaxneNxCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhbXqOJR79u+/b1TOeqh2Q568aPZn+33VQAaeCzrrDc=;
 b=c04/sgQ9Hr4H+qd5ipRDnlZs7g32W0nuK4V6Mb2/4qDMIO8fpuVuNgOOVo+juR6lfDHOrEfmlwGwcaA/cdKK2QlhvZ0HbHmDlwex3nKxYkCvNNnIDDUoPzMKP0JfMwGogcqpnymlnw1z1avHsbOAUOFi1ap6CkJ7v8n+wEUrrMbKpfdDgecE+s1y6mmX2dqXNxDoMIKR1sb0VqgmR0qyeA7R3N8X3b6yphN5lVNwW3qYn+5Uh7QCvuIJO5dVpscQoEVHJymYWlQ4CMACGQHlZfBPRT8udrDqt9FFzC8oqEwEr8hEF+7PgwDmYpg2h0dxOZeP3cQPnXPMqicyNuUdDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhbXqOJR79u+/b1TOeqh2Q568aPZn+33VQAaeCzrrDc=;
 b=ZhhOaTsBLDV48y2wXNQp/gx0gNr0ssNAUsEHPRFyLqf0V/jVZyQD+S0zFBkyoy4ZHlAfq+5P09UpmUcuUbp+Qu2PuUzcPeUiboVJKk125BRoJa7ZmJkDHcAfTBvuNLSU6oWz8h9/AxK+2IFaTtCBTFTgRtPMflH3DU8pwAgOiL4=
Received: from SG2PR03CA0119.apcprd03.prod.outlook.com (2603:1096:4:91::23) by
 TYZPR03MB7893.apcprd03.prod.outlook.com (2603:1096:400:452::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Tue, 3 Oct
 2023 11:01:39 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:4:91:cafe::58) by SG2PR03CA0119.outlook.office365.com
 (2603:1096:4:91::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.24 via Frontend
 Transport; Tue, 3 Oct 2023 11:01:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 3 Oct 2023 11:01:38 +0000
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Tue, 3
 Oct 2023 19:01:36 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 3 Oct
 2023 19:01:36 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Oct 2023 19:01:36 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id A1FC164742; Tue,  3 Oct 2023 14:01:35 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <peter.chen@kernel.org>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <xu.yang_2@nxp.com>, <peng.fan@nxp.com>, <avifishman70@gmail.com>,
        <tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
        <yuenn@google.com>, <benjaminfair@google.com>,
        <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v4 2/3] dt-bindings: usb: ci-hdrc-usb2: add npcm750 and npcm845 compatible
Date:   Tue, 3 Oct 2023 14:01:29 +0300
Message-ID: <20231003110130.229711-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231003110130.229711-1-tmaimon77@gmail.com>
References: <20231003110130.229711-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[175.98.123.7];domain=NTHCCAS04.nuvoton.com
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|TYZPR03MB7893:EE_
X-MS-Office365-Filtering-Correlation-Id: 96435758-aa93-4b35-89be-08dbc4001dfe
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h3Mp7DaQvTpnkBeoBgAoYAUd5xnOjPB/M2IOzP44j4BwFh/uCLDfwgzsIJZe?=
 =?us-ascii?Q?R5+/P5WK/FM7/roWe7vcShC73A68nfecXf8L5kup3QhtB6tnYt3xSSbDT4ky?=
 =?us-ascii?Q?fEZbu1LBWLTiieq5CBiiGKE4n4PGqynvw0hJOf+JjFy/zL2akAnR9ctx2A6j?=
 =?us-ascii?Q?Gbqg5ivTi/K3Jif3FlKFHovlz23FRaz2tVCnikE5WsIV6XnLHIRodfa6RlzH?=
 =?us-ascii?Q?02OozzR5g+jUbRK3etEg9n83yK/ENXUmZS6rapler+P24QLtQzbMoZ2CNSdo?=
 =?us-ascii?Q?Aviol5dxKR1t2PdvJR7zj0bsHNUEHYAdRWs+27zfginPPYFDUOq0X2NWSL9W?=
 =?us-ascii?Q?FiaWqGFKLwcngB8233xP2NAAIsCH0kf6E7gJz+feXB0wmS9D525urJz0nuCM?=
 =?us-ascii?Q?7T1PZK9D5rLgruOPJuoFM1ta/AbqAjWs3/XhA6v7EfLQttLE4r3KWa3vl9qc?=
 =?us-ascii?Q?mijH6M23QHG5rFJgwxxGCSREbaInt85wPU8JcoMQP2ssN5qAqITT3V3KGsfB?=
 =?us-ascii?Q?0s3EiyW3DunQ74ONF1uupYCnClbH2lkxNr3jr4QZzEmgfg1FRqOEJTlcyTpn?=
 =?us-ascii?Q?v9oZCBaFWvrxZQ0B0yZ8NqZVIKLFknFamM+U6cvCWG3jGMo1Aa7pNoDQA10+?=
 =?us-ascii?Q?2r0mJt/3GJd32Hc5I6iiigCBp55zXnYVI27is2oNrOo+CUyLVliT6CZhAMoz?=
 =?us-ascii?Q?htRwtQCIvSOrNnN6dHtoGepi3nPG+XsBlW3tYhyoM9q67fjcCaJ1CppVmMJc?=
 =?us-ascii?Q?3VYjbDqDU7cGP9MjufilmTWahWggYbw1I23hGGGMadwMKQgkzkrnQaey7HQv?=
 =?us-ascii?Q?+1FEeme4bZ30QXXTlIzT8tqacVrwUgiygWKajFvep3+Y+6UCubM1t6qfouy2?=
 =?us-ascii?Q?zkB/L8ABdm7/iFX74C7E/+St/JxaiNTqs4K6vC9zfH4z8myjDp8BoBkY7IKv?=
 =?us-ascii?Q?adxn23g7Sf0mvUWB4UyAmliTqAjeByzxkoOfKVlE3dA=3D?=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(64100799003)(61400799006)(186009)(82310400011)(5400799018)(48200799006)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(42882007)(82202003)(73392003)(54906003)(47076005)(6266002)(2616005)(1076003)(6666004)(70586007)(70206006)(76482006)(55446002)(83170400001)(336012)(26005)(110136005)(34020700004)(42186006)(36860700001)(478600001)(82740400003)(356005)(4744005)(7416002)(2906002)(316002)(921005)(81166007)(8936002)(8676002)(4326008)(41300700001)(40480700001)(5660300002)(36756003)(45356006)(84790400001)(35450700002)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 11:01:38.4228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96435758-aa93-4b35-89be-08dbc4001dfe
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7893
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for Nuvoton BMC NPCM750 and Nuvoton BMC NPCM845.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
index 1394557517b1..a9e173432002 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
@@ -16,6 +16,8 @@ properties:
       - enum:
           - chipidea,usb2
           - lsi,zevio-usb
+          - nuvoton,npcm750-udc
+          - nuvoton,npcm845-udc
           - nvidia,tegra20-ehci
           - nvidia,tegra20-udc
           - nvidia,tegra30-ehci
@@ -388,6 +390,8 @@ allOf:
             enum:
               - chipidea,usb2
               - lsi,zevio-usb
+              - nuvoton,npcm750-udc
+              - nuvoton,npcm845-udc
               - nvidia,tegra20-udc
               - nvidia,tegra30-udc
               - nvidia,tegra114-udc
-- 
2.33.0

