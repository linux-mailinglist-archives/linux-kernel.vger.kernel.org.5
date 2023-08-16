Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A4B77DB8A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242624AbjHPIAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242625AbjHPIAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:00:30 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2056.outbound.protection.outlook.com [40.107.117.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42C9AB;
        Wed, 16 Aug 2023 01:00:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNVgEh0MvcdPqai1pcvgH4HVvFRfi6bOT24zgtxZjLOjec7FqgUn+bjvYLBA9RSq8mTsz+HKv7P/+B6YBlkCbrwELdFspUAATkOkip6lGjLPGUFuMBzqnO/GJPINr4Sci5iJ7ZrS5nhsOZGwFAu3dJ19IgN2a0wG+oMgom53aH4z/5Ha0y12uKG6qpKS0A3tjx6frNKWPlmA7AvNRu0zsRySRTUVZuduLQHFA6qvLNCIoQjOvFB2tc/EVIFa4pxpKyOAWbmnl6z4MJuABl6kLfis7T/qw76IgCMh2+ievrIRtd5pe4S5645/leW35EgkFeSFpsYEwh57TLVT+7aO7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwDPLZtAyHatlg2hwtop+Faa8mph+phfV89NVDiFpBc=;
 b=bu6eM4NanGoGQGmgmXDXasPBuElJZx+X6p6Ki5jq/wY8u37Hvgw/kXoe/WWAapZhVT04LrXrpvJ727WXT6Wr7Zv/ie1Jti9aSuui4vwssJwI1tPrz6S7h+aALrLAYiL5b1GlYqE6xGMO9M4mk8AgcUpeGHKKBhY86b3o3+dLnQk+K11W3ejxcS9Vlb8riRtCg9gDQuli/XzWD0mpVFD9s+xmaVU7vr3xYMQw6Q20OjFAqQ3llwxx8yZ8PKM70/NNK157tsD/pghW5mm161qW7X8I86GMLrUpZxmsr7uxo3WX7igYeMwQyjoqKpkshtSJ0mqWUu4ANTfGJn8jDpDk2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwDPLZtAyHatlg2hwtop+Faa8mph+phfV89NVDiFpBc=;
 b=SX4m3QmmHPavqJFWfsO9M0Wg4yprn8KXuaPzjZ7GougYv0Ld/dIqHk5v0AiIS57LEOcX3VGNUoNwK7hBvJS3+F9nJHLhD5O/10GWqI6pBPc4fjl/qsxwabLKfRIvsUkofq/V1alPPqYYoRBTHqz77Cm0Vkrg1DLJdagmBUyRTHQ=
Received: from KL1P15301CA0064.APCP153.PROD.OUTLOOK.COM (2603:1096:820:3d::7)
 by PUZPR03MB5935.apcprd03.prod.outlook.com (2603:1096:301:b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 08:00:24 +0000
Received: from HK3PEPF0000021C.apcprd03.prod.outlook.com
 (2603:1096:820:3d:cafe::1e) by KL1P15301CA0064.outlook.office365.com
 (2603:1096:820:3d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.5 via Frontend
 Transport; Wed, 16 Aug 2023 08:00:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK3PEPF0000021C.mail.protection.outlook.com (10.167.8.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 08:00:23 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 16 Aug
 2023 16:00:08 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Wed, 16 Aug
 2023 16:00:08 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 16 Aug 2023 16:00:08 +0800
From:   Seven Lee <wtli@nuvoton.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <YHCHuang@nuvoton.com>, <KCHSU0@nuvoton.com>, <CTLIN0@nuvoton.com>,
        <WTLI@nuvoton.com>, <SJLIN0@nuvoton.com>, <scott6986@gmail.com>,
        <supercraig0719@gmail.com>, <dardar923@gmail.com>,
        Seven Lee <wtli@nuvoton.com>
Subject: [PATCH 1/2] ASoC: dt-bindings: nau8821: Add single-ended input feature
Date:   Wed, 16 Aug 2023 16:00:05 +0800
Message-ID: <20230816080006.1624342-1-wtli@nuvoton.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021C:EE_|PUZPR03MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ff7ab0-b25a-4828-7455-08db9e2ed82f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XpSwLT3z4GxtyvxFub9jcoop+5jtf/0FzesqEljZMqT3+Fn1tzrI/KG98rsXs3cIsbDYLRTV2kG1VAwIMHS67TkrheZ5Lu94mBqPdaii9UdTIXXrOt4qA1sP+derqiS5fI8rBBQQ0K7bPGSlV3fmKstgYsrof7sKOpGHJJcNa0Oi5yCYCzIt8i9drQJkiTIlWfc3LqSKxPDnFZnw9YJRBlGkDnyshZG4ILr2jgvHBo9ICE1l6zCEeQMfITvndlj5rA45dT2lHWzPOK+wUQVejMHl5fvsQcS0fhtcGL9C2Ulhgff7KbABy73U+kmjPdLa3RshmuLv99KrqDww+3WM/85INZXTye2QK7WhO+WRLdcgT4reA6+rE8aQuqaA1aEcOpG4dc/ZmggLxhkc+7f1O/lGPtlOu2LJFrJKtXUMPfA0dOV8cUWEdXqacSR00bZANEgmkUzuOtH4Rgh0ofC+lHY/oE0t0ZPDOSZ8A+j/Yclb+TrlPTwd0Q9ZWq0rylXPARr4rubv28XuuTc8mbTig5L0BFoKrwubnQSAJMwyyCepOi1IoDcYNF+laOKWYPckbc9mB9ag4LmZVCb46LEEZSw9QuluFt7oMzTgxRZjOF8wUNHRVnyfluluQ46t0P9XSQfJaRdeD7Mn7NqP+tIA5w+GOXTVDwYNJW4M80++YRZdZ+Ca1WpwitZlW/MF1tf5ZTKLj8Xq+5V4DIDSGjqpfVx197Q/g1DP2xgrig+vc4ugxLTeZa2cqnNPxp/yZO/az1ds4J6eFbIpg1kUaHbtD0OpkBHJINVxVvtdcnQg8K4QJKG8ujHt2mb5iy6WArbE
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(1800799009)(82310400011)(451199024)(186009)(36840700001)(46966006)(40470700004)(316002)(356005)(82740400003)(70586007)(70206006)(81166007)(54906003)(6916009)(12101799020)(36860700001)(41300700001)(5660300002)(47076005)(8936002)(8676002)(4326008)(7416002)(2906002)(83380400001)(40460700003)(26005)(40480700001)(336012)(478600001)(426003)(86362001)(107886003)(6666004)(1076003)(36756003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 08:00:23.5417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ff7ab0-b25a-4828-7455-08db9e2ed82f
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021C.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB5935
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add input with single-ended control.

Signed-off-by: Seven Lee <wtli@nuvoton.com>
---
 .../devicetree/bindings/sound/nuvoton,nau8821.yaml         | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
index fc2f4ce4db88..3e54abd4ca74 100644
--- a/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
+++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
@@ -89,6 +89,12 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     default: 3072000
 
+  nuvoton,left-input-single-end:
+    description: Enable left input with single-ended settings if set.
+        For the headset mic application, the single-ended control is
+        just limited to the left adc for design demand.
+    type: boolean
+
   '#sound-dai-cells':
     const: 0
 
@@ -114,6 +120,7 @@ examples:
             nuvoton,jkdet-pull-enable;
             nuvoton,jkdet-pull-up;
             nuvoton,key-enable;
+            nuvoton,left-input-single-end;
             nuvoton,jkdet-polarity = <GPIO_ACTIVE_LOW>;
             nuvoton,micbias-voltage = <6>;
             nuvoton,vref-impedance = <2>;
-- 
2.25.1

