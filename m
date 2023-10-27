Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EE27D9145
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbjJ0IWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbjJ0IW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:22:27 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01hn2222.outbound.protection.outlook.com [52.100.164.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AD610FF;
        Fri, 27 Oct 2023 01:22:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ID0oWwjR8p4jaVwbziCM9AiMxtABnVNzAkIv/M6EkxKThpK9ylJAA8czxZ4lRRgShaXej0xeoyJzhhPZt/HapKpxqZ+VEU4M3ivcPr57X4d39d8hEIWnZ0yUa6Qg1b4yYHW6xQ33NjH/GNn2bo7RrCA8YOsNcNNictNui3Mw9D4Dx8YS97a28ppz3kuG+HA4qaFuUBKGQqqBTprV6W8gQ5iX/o6DZbPN0p8G48Vf1CBKJJ4Qq/uzS/yTdOCiTEo9OasalTjSuJJYdMYiyA5yO8V/w/hDX669UWPktRZpUVbAn6odppqOLUrpxZOr5PG6RsS0eLFMhGDFfYqAKHiqTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wX2jBTP5sV1ADRwrexOSmKBqHTLl6/PX36w7GH0BnrU=;
 b=XfWUYC7y714ijYlXLRHGDE5IUiSKw+eMeaxtwlxDl+qqVI6QVHkLwhANigURkdbmJYuKfhHLK4PYOz6/GMtfHEFGPsbyVOe4f3rCoZpruU8cDP8Ygu2ef3CZMyiBTpwPjyohwfpfkcJyOUrCxKT6aP8CAJJ8HqSn7NvhcglDvQDd1RPb8E0K7LWCE/R05KDixK8duOi/bik/SsdzXyiOarN1xzOsDbKq4lvjqcP5yEnwR6XGidIRr+nK4ai3xhTX2rkWJcQFInmIPj7zaRsK8WZE1UXvri9KlwlZicVEEBytwPWrHuKtVvX+4B2kW602ZQX9ZWS7dmnwJbi3xw6Syw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wX2jBTP5sV1ADRwrexOSmKBqHTLl6/PX36w7GH0BnrU=;
 b=fGw7LAOFOwUEqwIvgVobOzH5Vi+tCT7tf1jXtqmiw87fbAiW8fUdx84Xm0eanV+PSzXaeN8rrJnvgn3c9Z8Z1bqr3FGon+a95km4ElBhfGmQSs9Tblf+tRjUQG4pM1P03WOuw0ccLD7VzYnHBoM6NA3FvIId+AcoBAPa6Mnx2Bw=
Received: from SG2P153CA0050.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::19) by
 KL1PR03MB7598.apcprd03.prod.outlook.com (2603:1096:820:e0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.19; Fri, 27 Oct 2023 08:21:58 +0000
Received: from HK2PEPF00006FB5.apcprd02.prod.outlook.com
 (2603:1096:4:c6:cafe::95) by SG2P153CA0050.outlook.office365.com
 (2603:1096:4:c6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.11 via Frontend
 Transport; Fri, 27 Oct 2023 08:21:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 HK2PEPF00006FB5.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 27 Oct 2023 08:21:57 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Fri, 27
 Oct 2023 16:21:56 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 27 Oct 2023 16:21:56 +0800
From:   Seven Lee <wtli@nuvoton.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <YHCHuang@nuvoton.com>, <KCHSU0@nuvoton.com>, <CTLIN0@nuvoton.com>,
        <SJLIN0@nuvoton.com>, <scott6986@gmail.com>,
        <supercraig0719@gmail.com>, <dardar923@gmail.com>,
        <wtli@nuvoton.com>
Subject: [PATCH v2 1/2] ASoC: dt-bindings: nau8821: Add DMIC slew rate selection
Date:   Fri, 27 Oct 2023 16:21:43 +0800
Message-ID: <20231027082144.639369-2-wtli@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231027082144.639369-1-wtli@nuvoton.com>
References: <20231027082144.639369-1-wtli@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB5:EE_|KL1PR03MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: ef874de0-f1e8-4f4f-778a-08dbd6c5c96a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qxUosP54cmCwcQD/q/P3EKUJYHwb13Kg1uyGSfJlID+wVOjo/zc6u1+vSEzk3UzkF9mDB92+zdKDAlWs8GkTV0YunjeDIDNHp4yAzkBo3i3UGKYVl8zc+3ecaTRVO9IvhNyiXttSXFUN4Z0VB87Kbk8y/KGHCZdXTEttLkthjwcGxuMInAKAtoBFwN7WlQmKcbhw33rCi2o5XpBEu6+/OwooV1yt453jAcSi9KmhMzO9BGap4NkfBMhylgfAO+TY5XdE/2sOw3Dc+LiPYeIiY8LY7Di22E7+B0ht+eZhLtUoAmGnB6Wg8Td/VWm4dv4Kh5E9Urq5rxUQe8yrFPszisCupkbitBI5EZOnLDVAnOlgIrrpllCT4pMus+ONXR4/FLBwXsXYEYXORslaq5OyGvDWVs7d/PEdMFG9do/9z9WYovjroUd+9yt2GVRfSLCdjjBZt1xTHFgAImZgA+uc/ZgYWnbWtnYAIEgO7KZ7xiCrFIHPkYXXTK8YpGmG4P/OPy9tFQO3h0Km7uTL9uLGd5i6seqrjtqlqgRsFCk/0e205JMteDM2mrX17OE9J1grrydAzalxMT75balFbIFafyL7Uggjgk2NPEgMsnEDlxVOLaJ84cjkypUeaWkkdP2St96aGJJWH9JTHmxf5vH5V15y1KLvo0Pcmoty2QvUvxPj9wc9VcqeRErDUelIZ52r7X6aaxcQSZB0YjauLXj/WpXjQ02M/2unpFg50a9zkJOQRgXjTW/S/qI6PEJz6f90O2z9/+qmp1gL6liu7nM3oK8k55Tn58b9OJ+nO3Lu6XQtLXaCLC0ijWpmX3PiuydsxMfmchryI1FcUBnJWkz7csnLZkQHeYZyJp25aBv1NDk=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(186009)(5400799018)(64100799003)(82310400011)(451199024)(1800799009)(40470700004)(46966006)(36840700001)(26005)(336012)(34020700004)(426003)(1076003)(107886003)(2616005)(47076005)(356005)(82740400003)(81166007)(36756003)(86362001)(36860700001)(40480700001)(40460700003)(8676002)(4326008)(6916009)(8936002)(54906003)(41300700001)(5660300002)(7416002)(2906002)(316002)(6666004)(70586007)(70206006)(478600001)(12100799048);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 08:21:57.8843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef874de0-f1e8-4f4f-778a-08dbd6c5c96a
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7598
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add input with DMIC slew rate selection

Signed-off-by: Seven Lee <wtli@nuvoton.com>
---
 .../devicetree/bindings/sound/nuvoton,nau8821.yaml        | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
index 3e54abd4ca74..01028b7ff85c 100644
--- a/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
+++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
@@ -89,6 +89,13 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     default: 3072000
 
+  nuvoton,dmic-slew-rate-selection:
+    description: the number from 0 to 7 that sets the DMIC slew rate.
+        The unit is mV/ns. 0 is the slowest, and 7 is the fastest.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 7
+    default: 0
+
   nuvoton,left-input-single-end:
     description: Enable left input with single-ended settings if set.
         For the headset mic application, the single-ended control is
@@ -127,6 +134,7 @@ examples:
             nuvoton,jack-insert-debounce = <7>;
             nuvoton,jack-eject-debounce = <0>;
             nuvoton,dmic-clk-threshold = <3072000>;
+            nuvoton,dmic-slew-rate-selection= <0>;
             #sound-dai-cells = <0>;
         };
     };
-- 
2.25.1

