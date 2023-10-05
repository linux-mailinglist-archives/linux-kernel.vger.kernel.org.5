Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B6B7BAA16
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 21:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjJET0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 15:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjJETZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 15:25:39 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01hn2218.outbound.protection.outlook.com [52.100.164.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA91FD;
        Thu,  5 Oct 2023 12:25:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhbTqlGR/wtketlbybabYwX/qDtX+m7lm9ATRl5jcXMOJ1OkpI6NoLrIfDnmWSM/d2l0ddSAPu7jInz5//XZtS6E4vPLKCxu7A3vhGQrT1EGC7rbnYtI+p7SK8XU0h5b0HcSHl872Arncjwc2QSjHbHvIUbSf0Q4L4VBR4+eul5vd/c9JaPuUsDmODEeL7FHKrdzReEK0nuwueL6mWXfQZecMyVnuSSC91duftUe3ZbDzn8gT7f/Fco3x/c2iimTp+VxD3l42OlHM7o5ZqwiRlZLsuTzlshhCzlPaIqm9Q++MKsGgoED0jXhXTFQHLdc4Kht+VAJPRYdSqk0hakUwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ga4nxXaSRjk2FEtgsMqYOL1T0U4hiQE2m7Uq+3F5eM=;
 b=NEpSC45a1U/gJjr+TzZi6YAD6K4934w5A96mNbQw7JMc2YAxcCU9Sykb5nKHXNElO39oVyaj+ULcR9t+MMDonPr9cYSdCVJT1POgtRpwIfMVM8abLWXWGOxbtEGS7EHKR9+jrUx75790+cyfou2Tbk3ItIOzldA3K3RiBDE+LNREenKioyDJND53uKHA19K6spybF06v/WZGthqekscTsaGyAaTJ9d7aBbPOQkEXCWD3xjBjsHnG2bq+fIqVVpZlHYECQfi6hq2D1I3b7TGHz2aUBvJk5K5nrNZCE+srkbFTVwjARS9gwRwJpcAe3ivrv2levgIpTgGTARNfJfEeFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ga4nxXaSRjk2FEtgsMqYOL1T0U4hiQE2m7Uq+3F5eM=;
 b=G9zqK4eb/TE86mdDBY/MQ+755bxz2+0qJYbc9UzEyY4FIv8SbbYkiVJKEVourAaP68N7FSV1rj7oLXSlz6RGVcWCWPors+o8DYCU6bs6SwjaQW3zFTzdUHEJGCgNtjXGPmj4r+BbR86z6Ae+RpxrzCHV0YFa3rUMAOgGuV5va3A=
Received: from PS2PR06CA0004.apcprd06.prod.outlook.com (2603:1096:300:56::16)
 by TYUPR03MB7177.apcprd03.prod.outlook.com (2603:1096:400:347::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Thu, 5 Oct
 2023 19:25:34 +0000
Received: from HK3PEPF0000021C.apcprd03.prod.outlook.com
 (2603:1096:300:56:cafe::fb) by PS2PR06CA0004.outlook.office365.com
 (2603:1096:300:56::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Thu, 5 Oct 2023 19:25:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK3PEPF0000021C.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 19:25:33 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 6 Oct
 2023 03:25:33 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Fri, 6 Oct
 2023 03:25:32 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 6 Oct 2023 03:25:32 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id D36B063A28; Thu,  5 Oct 2023 22:25:31 +0300 (IDT)
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
Subject: [PATCH v5 2/3] dt-bindings: usb: ci-hdrc-usb2: add npcm750 and npcm845 compatible
Date:   Thu, 5 Oct 2023 22:25:28 +0300
Message-ID: <20231005192529.162785-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231005192529.162785-1-tmaimon77@gmail.com>
References: <20231005192529.162785-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021C:EE_|TYUPR03MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d9d9d7d-9cd7-47fd-59f1-08dbc5d8d884
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SVag7QkPHQ9kDeM6+QeGsZR3hvn9NkdLWBoeW23cqa4db87bBEo03p9rJXAn?=
 =?us-ascii?Q?IY9tywFONjLjPj0zCJz79dev6cvQeXMWG3V6Fvxcc1ZwvTMXIAkDqn/HopQv?=
 =?us-ascii?Q?UhfOP/l6q29+ufndf4vm+DO+Us0Dbj75gG9PiG481xRoS7bYCIXmBVz81jfx?=
 =?us-ascii?Q?0IPkkJPPYzDmzbk1fxcJPZphdrvDMMg6f6ydXVAIT+0Gqcn1VXOKDPoPlCxs?=
 =?us-ascii?Q?31IoTgCzU/EzRlM5Ge8ruonMkAgsddk7MgxpOJlNcpllomyknpxzgF/Pkdzb?=
 =?us-ascii?Q?idrUWYVLoasZ+fxz3tJkjdKIHOBjsv/bTCw32tvLelo8Bfjq6bnBIoKy8s9x?=
 =?us-ascii?Q?HggEaSApxNgOvSQltoeP2026663+Vb3l6kB9Q1Q/jR2qqYAJx4Uh3zAKwHd4?=
 =?us-ascii?Q?4BOJvlSPcnh1TbI5Ps8I7G3hsYGOv/lvNUbPcZf7kTdLOKGFEM+CRaIqUNrs?=
 =?us-ascii?Q?C2iX0UhAoNatybpojb6lfyq/h9OSobZPipf6kLPc89v8aEszuYUJjQfOXUF1?=
 =?us-ascii?Q?LLpAbNoTZe0zqfjnJJQmJop2Q0cdVdNkWEtnBVjzB53Wfzwth958XvbLrDsF?=
 =?us-ascii?Q?K8mLbIPK957OIu2e4P3Ujvz2VHYl8oYD1nFg6wgdljzvBg1EZ1w67v0MJMpT?=
 =?us-ascii?Q?LZTHPvGVJ6Q7vfLYShwwG37XaPPonNzp95qBxjAAP18mkGB8aDQHzR8JA2HR?=
 =?us-ascii?Q?rhlZx8dWICBYmrI6dpKDnsxFj5M/sG0Np9F9SzAE86hqBTqqy7IxhXYwW2I/?=
 =?us-ascii?Q?7DdLTV0Irx19Uj4zWYdp4+67dUiIK/hgumIxHH2NXkfY6kPUsDPxgiTJnBNb?=
 =?us-ascii?Q?dZUE8NQAYWF/4Zx3vgUUZ5LIT5JhUdmAT33+aVvu8tn1ZVfFqcB90KYEtNBe?=
 =?us-ascii?Q?0thq+P3ACbavSHLFXKChMyFs2wPndfr6JtPb7zX8Z9diSFKfDAtOPebQxLQz?=
 =?us-ascii?Q?Mxfxm4nnD2m/iG0VziEeiekEZbDMY8fXDaYDuiQY1lU=3D?=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(64100799003)(451199024)(48200799006)(5400799018)(61400799006)(186009)(82310400011)(36840700001)(46966006)(40470700004)(6266002)(40460700003)(40480700001)(478600001)(6666004)(76482006)(921005)(81166007)(336012)(2616005)(47076005)(356005)(55446002)(83170400001)(36860700001)(82740400003)(34020700004)(41300700001)(7416002)(2906002)(36756003)(73392003)(54906003)(42882007)(1076003)(110136005)(82202003)(26005)(8676002)(5660300002)(316002)(8936002)(70206006)(42186006)(70586007)(4326008)(45356006)(84790400001)(35450700002)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 19:25:33.8748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9d9d7d-9cd7-47fd-59f1-08dbc5d8d884
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021C.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7177
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
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
 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
index 1394557517b1..57780f8340ea 100644
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
@@ -388,6 +393,8 @@ allOf:
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

