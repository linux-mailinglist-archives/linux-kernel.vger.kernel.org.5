Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878ED7C7A0E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443038AbjJLXBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443053AbjJLXBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:01:53 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01hn2204.outbound.protection.outlook.com [52.100.0.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045E0BE;
        Thu, 12 Oct 2023 16:01:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqJ48aChpKnA8IUNpdKQa5FrxRmJOwoRMvlFNMkqnoOskx4bxltQdcNAbkaFV7OZKv+2RBNgML4N2Sc69w+N4j+Yak4V9uqpKDaOc2GWUwp1vVaRFiWFG2vEMAj5EiM2/yrv2YKo0SU6VP640iHaRpn2HA9EGOF9dACeYtZB3uMRDrkuVx0TnjP7eGQ807DZKsYq0cm7Pw17UCdpvbO0QAz5IYw2KQ7f2WUCBEyuYdYa+A6s9EL8XTkdFILS/6D+aVkOevmYRyvgBdG+o1I9VTXZAtzL5BEnLr6RKQJGR+OshhzztAuE4Z0OlbTVvZh2wwpEt8mLSxcMRKZkPgWyjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zChZKIeJd8lTeYa9kwcv8k5MX2Iud+Zox3b5ytRjRQ=;
 b=NCv1NBzg0t3SecowOaylX5/x4zIwZR3UhAWcQdpmYsUgk+PhrGcayk9SRQ/uzBmamvrkhPHxzcrKuXCSMl7SCvFgHbn3Z0MhAJItHcHp4dIZnjQcDUXOLyoCd4O0Towaah+pYOoxa9AcVbFg1IAJDFiw/OigKZy4CZrPQlxxU1/EVTdW3p2pbYpcuia1hvH3P+DV66TElZjpJW0lGqFCnRB6Ez2tr/lTX0e7B0Mz0gfMSRo31gfxOBMtGXgqoV9wWg+/tJSQNH5d+56o9I0lxreiaa0xejb6jEA0lc6NHzaQxQlgDWxWs1q8vT4vFlp6Z7G0+r78i1yNZRz5E8qT5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zChZKIeJd8lTeYa9kwcv8k5MX2Iud+Zox3b5ytRjRQ=;
 b=Ib2gi3F/DF1SipGqeYjd0C5xlzJH8Bx0E10hmWdHMzMXSxkfc9MGmDSyJ4ScjewtPGk+qjf/UthL5pETsgPXeyk9ucox0CnBq3H5CMu2rdn6VGA+Oc8GIeiA1m8nA067xuwB85wOaGkZmphiekJ5twl2kaZLPcVZpRbFRA43Fp4=
Received: from PS2PR03CA0016.apcprd03.prod.outlook.com (2603:1096:300:5b::28)
 by SEYPR03MB6795.apcprd03.prod.outlook.com (2603:1096:101:8d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.41; Thu, 12 Oct
 2023 23:01:33 +0000
Received: from HK3PEPF00000221.apcprd03.prod.outlook.com
 (2603:1096:300:5b:cafe::d7) by PS2PR03CA0016.outlook.office365.com
 (2603:1096:300:5b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.29 via Frontend
 Transport; Thu, 12 Oct 2023 23:01:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK3PEPF00000221.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Thu, 12 Oct 2023 23:01:33 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Oct
 2023 07:01:02 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 13 Oct 2023 07:01:02 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln58.nuvoton.co.il (Postfix) with ESMTP id 66C5A68E73;
        Fri, 13 Oct 2023 02:01:01 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 5D02B21CFCC4; Fri, 13 Oct 2023 02:01:01 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <peter.chen@kernel.org>, <gregkh@linuxfoundation.org>,
        <avifishman70@gmail.com>, <tali.perry1@gmail.com>,
        <joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
        <benjaminfair@google.com>, <j.neuschaefer@gmx.net>
CC:     <openbmc@lists.ozlabs.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v6 2/3] dt-bindings: usb: ci-hdrc-usb2: add npcm750 and npcm845 compatible
Date:   Fri, 13 Oct 2023 02:00:56 +0300
Message-ID: <20231012230057.3365626-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231012230057.3365626-1-tmaimon77@gmail.com>
References: <20231012230057.3365626-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000221:EE_|SEYPR03MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea55f65-90a2-4f22-bd1c-08dbcb772df7
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mKx/dvxF9c8QL52KBaIcsn/e4r/qyPYtmBJb+rd9CMbODM0LUszV1tKl2tpc?=
 =?us-ascii?Q?J2kSKVG36sFusf0zW/QkYBBIOleTm5edSc/3k5J2Yo0OCH4pnL8KQ7/B05U0?=
 =?us-ascii?Q?2w5eqH1JbsHeSlPtcfwzzsFSSxBWvEqdjloeZY4W+9rhf9+fKbJue2pPTPc9?=
 =?us-ascii?Q?nREVthzHdVU1+HOgEhDotJWC3P4r0L30Q93zU+GJfj7hd6nJABdLZXB+NJfH?=
 =?us-ascii?Q?LMafWGNJbINSaPnc8o7t8OxNMhYdb9G/ZQ4D1UMCIrZh68E5H9S98LES7KF7?=
 =?us-ascii?Q?1BOEzDLT5Ke6Po7gZ2JJZvRDVnXmNxMwI1pqUAQshvyG50FnZAgQ8ZV7TfI4?=
 =?us-ascii?Q?mqYCXAY1XSP1POv9LvlfthjsEGfHJrePUVxgDdPUBmCBf9SiXSHsRrsFqWLT?=
 =?us-ascii?Q?0Rz50niGOsYdLWvU01zgY+l5CNCMDPHD08wB0PXaWKHV5fgbksLOr6EwkmAT?=
 =?us-ascii?Q?SjgnDwsEAnXH+d7TZh0eRj2udMaAhRkocbT0LXio3Krpvqswc4gRATG65y94?=
 =?us-ascii?Q?0m2kh/7MJZSA0yzBKmAplDhUzgRcZTNiHMdnSA0pmdJtR//3zhrhB1gPhZ4d?=
 =?us-ascii?Q?IB9ekam0oLvvlAdx8bJ4aiqTMUC+KN7fURJfJpGNa+smIEF9A+k+K9KqeY//?=
 =?us-ascii?Q?r2pLdur1Xr5dyLZnUxEJ4NHjqgphvu5Dijc+Bn4Klc1j0QWKNPexeiaHNGRq?=
 =?us-ascii?Q?+Vkwvj668dorYtfFzVwKdeWH8ckOLjixrhNiiZu/JfQtYcYTVoB8nCoInuQ+?=
 =?us-ascii?Q?pCI6b0icshuflyL3Lnv2ahoQjeECjgiS2SPh46aKKs8edcPa4G3TYS9bdfwM?=
 =?us-ascii?Q?0MHrbJFIJBaAoGBYjoR+mQ5N1oQZcWUc7xXsoAhgiVuF0+PXjnqVbJJTTRto?=
 =?us-ascii?Q?v9ujqNTeGZ6lo7VOwVLB37eShVYNtXIQm/ztsBXW5Uurv4B5/ODq0phnUxkQ?=
 =?us-ascii?Q?oSmVuJQRTpUgTulMYMJCPQkwD71nINFAg0042x30qLE=3D?=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(61400799006)(186009)(48200799006)(64100799003)(82310400011)(5400799018)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(1076003)(2616005)(478600001)(82202003)(7416002)(42882007)(34020700004)(6666004)(336012)(6266002)(73392003)(47076005)(2906002)(76482006)(70206006)(54906003)(8676002)(5660300002)(110136005)(70586007)(41300700001)(42186006)(4326008)(8936002)(26005)(316002)(83170400001)(82740400003)(356005)(40480700001)(81166007)(36860700001)(36756003)(55446002)(45356006)(84790400001)(35450700002)(12100799048);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 23:01:33.5501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea55f65-90a2-4f22-bd1c-08dbcb772df7
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF00000221.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6795
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

