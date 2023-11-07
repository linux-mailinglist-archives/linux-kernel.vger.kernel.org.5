Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5C27E345D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 04:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbjKGDxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 22:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjKGDxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 22:53:02 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2043.outbound.protection.outlook.com [40.107.117.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCE211A;
        Mon,  6 Nov 2023 19:53:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZEL1P1clXk/NyqCaAGfilBOPR3b2kKG6stHuoIyXorCxUHCg0wm1q9o/6StBHVOm8oHQ+Z3RKbm1ipuzaHhy9/T9+APfEsynbTvDD6grktTG9zSehq296O7thzDUpZ2e64XzFjy/cTEM0AyuuwbCsNNadjbmz+E1H3TDWqARNWgaXi/6bp4o8DbGrhK2/B6SgJJWW89Lhvq7d/mRpVDnuqNcDKWdRh89LYxv9G/ADQrm8RzK9UAdZWDUmgCLJDzE9F2iv2d6Ga/DEk6I5V+aTyRLvvLbQQIhWvdS2U7foCUOWID1HR+kEkfjDllu0y1ft0m3xSNO/3D7G8NKZKWqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z82lfyBnK3TV+y5xeq6J4tQtgLcPKjjHTTyUCjiQDK0=;
 b=GYbVe5GPZEYuzSNrPpfmV3Ut4BwuywkzrtBO0MRNa9LMEPhslIJwXUZXmyitXSYCpIahBXxNxpUiaLuqacN+sVmq0pgmNX1V9dSFQog10jfWejRaGULggEHfFdwFhbkAef2jMC2lF81kejF9BuLr0iuChMBKBT8NqFtkKLHWiKzBZROZ3ly8hkVCyjH3AaYhLhIFf+MAUtLXu9xTRKdFn087344ckAbuowBEvaDl0dDRL0xVMJn2u9WBOVMSIrmSJZIUyl6LU6Cz1/0gk0rvO0Uex4RR4LnwDbagRrC0QRV1dkiLHzn7R4GwSQZLUJM4DV/FoIu0rWbF6TmQJK0tng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z82lfyBnK3TV+y5xeq6J4tQtgLcPKjjHTTyUCjiQDK0=;
 b=g04Tt59+dlmcZngDY+0iCtfj/H4EGWMpfbApb434A6DVsS++PFesrvUom/SXr4VA2jMoru6XDT4bi9X7mGBkenP8WfqyVAAgp0VNKabUjWgh8r4pxKPmlh2/g/gWLFpAWA9U27XEFZ3KbhblbZXWpReK3w/vcNHciC8iyrchc6M=
Received: from SG2PR06CA0203.apcprd06.prod.outlook.com (2603:1096:4:1::35) by
 SEZPR03MB7515.apcprd03.prod.outlook.com (2603:1096:101:12f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 03:52:53 +0000
Received: from SG2PEPF000B66CA.apcprd03.prod.outlook.com
 (2603:1096:4:1:cafe::89) by SG2PR06CA0203.outlook.office365.com
 (2603:1096:4:1::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29 via Frontend
 Transport; Tue, 7 Nov 2023 03:52:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 SG2PEPF000B66CA.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 03:52:53 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Tue, 7
 Nov 2023 11:52:51 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 7 Nov 2023 11:52:51 +0800
From:   Seven Lee <wtli@nuvoton.com>
To:     <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <conor+dt@kernel.org>,
        <YHCHuang@nuvoton.com>, <KCHSU0@nuvoton.com>, <CTLIN0@nuvoton.com>,
        <SJLIN0@nuvoton.com>, <wtli@nuvoton.com>, <scott6986@gmail.com>,
        <supercraig0719@gmail.com>, <dardar923@gmail.com>
Subject: [PATCH v4 1/2] ASoC: dt-bindings: nau8821: Add DMIC slew rate.
Date:   Tue, 7 Nov 2023 11:52:29 +0800
Message-ID: <20231107035230.1241683-2-wtli@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231107035230.1241683-1-wtli@nuvoton.com>
References: <20231107035230.1241683-1-wtli@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CA:EE_|SEZPR03MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d78a2ac-4c21-4a65-7bd2-08dbdf450504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s4VsgCdBXXDtHA45kt0/VdMhcL+77FBzoTw11sEUFaRRzi1x0+KwVRt0/XBDQPaKBtnnRlAYGLMctfcDfAd8Zb3k40OH9WJfPgU8IQcnQJswOlMgsod0wISQKDYwaROGUl5HP5erYrmiuwju8ejSSrvz9+5G1F437haVpVX5/B+rRqOhrgmfD+1Ofv4F3Grwhh+HRaWQQ0hi0DIaanYvkOOWP1OjFAheiDOQL/apa01VpAoOrQqK9VeSs6wV7rrvk3uTENt126JReFYsJxCodVJVsV09Eno3BvR9kVGYPwYM5xjOLlvnHB+TNowkvFfCJ5WYCcgrclUq7qhUiTUaEZDIuYzy8rpoV8eQwDHKXdhV354qdayL/qNSYDQL1AsuXAAPaYyLOSZtyBXooNSqBFXX8DCQdT+S7pvyI5xtMRQnUwBI5qn356VOxkzl7PnkkzcCDvB+lhVYuOdc9nqmZ8OuzHLlrNeEzQZPSmq6jaklu5DB6dGRnsyu4eSnsMTVmqvpicr4ZWxUAXcQ6/CBCDaPtnEYO76Mi96woHCLWqNrGReoOJIilXs3bSF/MXd8ZpM4PXz8cbdNlbIb3TBWTw2JvaeOQWkLOS+JzS3EUznreCR4SN3C+jhfUCs/NxP+F6DY0tdYSz7PgT9etn9eEikCxe8tdT23zT/oPyd82NGaQQSq05EGq4Sf5sInCLvEPZ6rdbc3bCkKxvv3xljSHEObFp+Iq+k7eG9HvGN8Zj19Jdma8Uk1AwShzvgzejJZhRKK8TcSSoUOKnyViMiwkBh9nuL+RRWjI2pPySMclTM=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(230922051799003)(1800799009)(186009)(82310400011)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(36756003)(40480700001)(316002)(426003)(336012)(8676002)(4326008)(8936002)(26005)(1076003)(7416002)(6916009)(54906003)(70206006)(36860700001)(5660300002)(70586007)(41300700001)(478600001)(47076005)(6666004)(2616005)(81166007)(2906002)(82740400003)(86362001)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 03:52:53.2037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d78a2ac-4c21-4a65-7bd2-08dbdf450504
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CA.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7515
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add input with DMIC slew rate controls.

Signed-off-by: Seven Lee <wtli@nuvoton.com>
---
 .../devicetree/bindings/sound/nuvoton,nau8821.yaml       | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
index 3e54abd4ca74..3380b6aa9542 100644
--- a/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
+++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
@@ -89,6 +89,14 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     default: 3072000
 
+  nuvoton,dmic-slew-rate:
+    description: The range 0 to 7 represents the speed of DMIC slew rate.
+        The lowest value 0 means the slowest rate and the highest value
+        7 means the fastest rate.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    maximum: 7
+    default: 0
+
   nuvoton,left-input-single-end:
     description: Enable left input with single-ended settings if set.
         For the headset mic application, the single-ended control is
@@ -127,6 +135,7 @@ examples:
             nuvoton,jack-insert-debounce = <7>;
             nuvoton,jack-eject-debounce = <0>;
             nuvoton,dmic-clk-threshold = <3072000>;
+            nuvoton,dmic-slew-rate= <0>;
             #sound-dai-cells = <0>;
         };
     };
-- 
2.25.1

