Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0937CCCC1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343950AbjJQT7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjJQT7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:59:32 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2046.outbound.protection.outlook.com [40.107.117.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B288FF1;
        Tue, 17 Oct 2023 12:59:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+13umzzrTQAMRI1CMgyzB7VwNI/mwRiwqT/RTrPlKhVvRBiDVGezHgsdlriiMIbhp+Hiqw5I0W1TC0vbuG7+VYL8SjnsIdoGT2ZFMcg/uBVZIbiK0+x4dAptLzV4a4JWvFzzd93YnRMfWkmeG7+1vLmgjDES/+3ooqn60qsOW9zoh5PjrQ+RnCrnKu4vqW2tmNHJpJ80p+uxuj1b2XoRoRPRsAjx1Ekaisn24x/m3ullrlxAIyNQnPcn0oXtFCpTcAzzA9h1lO4uhSY/QuHNL5J95F0F1jTUaj0ihQyrxXL3/shTvWqd2bRzU90SSFBp8inajHtBUiSpboEGSqRSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zChZKIeJd8lTeYa9kwcv8k5MX2Iud+Zox3b5ytRjRQ=;
 b=m0aQAw4ffOxcviunIZVD4NXT4tStY9bZEO379RlLahhfgyFbmMYavh5WSwhAF/cvZmZtSOmqvxEFj/EkBIEPjUP9XqhiwKDLiVD+R9iY80cxFNjNDKQWZ7MASlYz82XQ2M7pFUq1qm0HenFes5lvTZh3tmcfJv2qDRRRA1C6SSoadBZNYcZMZXRtHbMZXF/wJtDU8qyTaOpTBxB7gbfau1Lp2kTAh8e0ztzq2xCLD73BJ0TZQjPgOYaLjGLjjs6YssLqxWs9uyAOd/EzPaiLJHccIvSWXymfEeUV5P5tZA67/cUmiU0KlIEr58AvL2w8IKnX/Zz3g6vuYs30X7an8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zChZKIeJd8lTeYa9kwcv8k5MX2Iud+Zox3b5ytRjRQ=;
 b=a0lMb/RBdo20t5IiGTeigePC4W6JyFKPfQzfAZpZb4xXHoT8Gs2F6DoKVVAAnCGgrHuo3xWcuXWAXym1sXzdY0j67M6ea4oz8n1g88DwiloeUQQ00bzYGhTM7zo/6YpPW/HyjVSkwnwfmPil44EfY3lEAE2IWMNZmQOblai5CO4=
Received: from SG2PR02CA0065.apcprd02.prod.outlook.com (2603:1096:4:54::29) by
 SEZPR03MB6514.apcprd03.prod.outlook.com (2603:1096:101:44::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.34; Tue, 17 Oct 2023 19:59:26 +0000
Received: from SG2PEPF000B66C9.apcprd03.prod.outlook.com
 (2603:1096:4:54:cafe::75) by SG2PR02CA0065.outlook.office365.com
 (2603:1096:4:54::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21 via Frontend
 Transport; Tue, 17 Oct 2023 19:59:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG2PEPF000B66C9.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Tue, 17 Oct 2023 19:59:26 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 18 Oct
 2023 03:59:25 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Wed, 18 Oct
 2023 03:59:24 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 18 Oct 2023 03:59:24 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id D67A668E45;
        Tue, 17 Oct 2023 22:59:23 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id C7BD321CFCCF; Tue, 17 Oct 2023 22:59:23 +0300 (IDT)
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
Subject: [PATCH v7 2/3] dt-bindings: usb: ci-hdrc-usb2: add npcm750 and npcm845 compatible
Date:   Tue, 17 Oct 2023 22:59:02 +0300
Message-ID: <20231017195903.1665260-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231017195903.1665260-1-tmaimon77@gmail.com>
References: <20231017195903.1665260-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66C9:EE_|SEZPR03MB6514:EE_
X-MS-Office365-Filtering-Correlation-Id: 3803f4b2-878e-433b-c981-08dbcf4b910c
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: twzBTD8rCXbs1z7cniXLrj3+WM/aRzVl09NouS2OK0oJfg2rH9AHfZsmlQoUdnDwA+qlhrjeGPLuDwUTMGuqaiiu1cATBHA9j+mIkuABQN49wr7vnF049G5ejA/b/U1lVQTbdv6O+VL5tjQ9+iLtTDKiZ51R0FIZ/B2znwbEf0RKB9v8pzXfZO3UxDorxolpwnDyJv9XSgJAkcrfqUkst6sviD83XqDmtwMDgDd0ozIImFCyc9M6xI7CLu2Vb2QxJsIBc49NeuQBJsPCw7CDlEUq+2N1vydTiAu+hvTORKBbFgvIh2HOJyfKvwnFOPv6NHGW0XP6bRs9UFX3VwP1yhH2WjvBXzphQH4gmE1lxrHf2pJcnyzvil4T9iXRskc4uxVR0DgIY9ZD7LT8hLkgisd4E1FyYDo68cs9X4Ro8F11hMSOj6xq9CmitSx+G7WE4b8stLPRDTMAOS2LWlqlmkrkeLIqzjFAQ1qUMvWx3UNbRRD3xgBQ/rEqs+4ZPzIBHPUBEbmU8gYRWOrfiA6QBXWM3Jxspg1BgpaIAF4oMrtsGB6axnP0MohlbjXDEyZm7LTuSqFMf5d39QdEb4VRmdPBhxOeVso4lPpXWD8nsqJxq3xQrQFIIH3v/THSZJN5K+ozz2H/4t9Z1tmOMwYFbigKBFRXbYsLFK5uKQ6gD/EPrz0n50pwCqFYuCZb4kyK9wQlu9zscR7bWGzl7c175of/bDqzrW7g6qNvDn/kIpVPfAiff7esv77zd6R8ZSv4NeeUhgFWpSDpfHrJW2mfGGMxmv0/a+grGDYP8vlGYSYXhJh8xUn3G765NLzytiJnoDRlnqrYe2n26Zh/36ZBcti8fmMhQbmmGHUDJtj/jngtUZJ/KDVBXX6Yd+9DpaUsWoDS8MNEWdWmmnfD3vh5+A==
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(451199024)(82310400011)(61400799006)(186009)(64100799003)(48200799006)(40470700004)(46966006)(36840700001)(40480700001)(36756003)(40460700003)(41300700001)(110136005)(70206006)(70586007)(76482006)(54906003)(921005)(356005)(83170400001)(26005)(55446002)(82740400003)(81166007)(42186006)(336012)(6266002)(1076003)(73392003)(42882007)(316002)(36860700001)(6666004)(82202003)(2616005)(478600001)(8936002)(7416002)(47076005)(8676002)(4326008)(5660300002)(2906002)(45356006)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:59:26.4994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3803f4b2-878e-433b-c981-08dbcf4b910c
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66C9.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6514
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
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
 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
index 1394557517b1..f5ec1aef839e 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
@@ -16,6 +16,7 @@ properties:
       - enum:
           - chipidea,usb2
           - lsi,zevio-usb
+          - nuvoton,npcm750-udc
           - nvidia,tegra20-ehci
           - nvidia,tegra20-udc
           - nvidia,tegra30-ehci
@@ -66,6 +67,10 @@ properties:
       - items:
           - const: xlnx,zynq-usb-2.20a
           - const: chipidea,usb2
+      - items:
+          - enum:
+              - nuvoton,npcm845-udc
+          - const: nuvoton,npcm750-udc
 
   reg:
     minItems: 1
@@ -388,6 +393,7 @@ allOf:
             enum:
               - chipidea,usb2
               - lsi,zevio-usb
+              - nuvoton,npcm750-udc
               - nvidia,tegra20-udc
               - nvidia,tegra30-udc
               - nvidia,tegra114-udc
-- 
2.33.0

