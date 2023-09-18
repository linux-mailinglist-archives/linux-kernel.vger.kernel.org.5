Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFE37A5025
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjIRRAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjIRRAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:00:18 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2067.outbound.protection.outlook.com [40.107.255.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7C7119;
        Mon, 18 Sep 2023 10:00:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqpVnjOnACArliHzN03yyzXchVPl0xlCRgHUO/06QLCDoahgjis/vPjQpwa7BRGUHHKlggdJto33m3I5laTH9+Q18OqUalgqBf6gWGZbBUquSeR+oAoWFQY2LZGA55qWbAEGA3JquzEPPly9PHAMO7IrCEQjQ7YCLylnUWS0yT80eMsNza0wSQQNmLZc3Mr/EHV2pO0ET3ZTKgc/V6GBWkVO7TcuGwssKconaJOYpWeUBbZHqCrNHjIRsOemFYyizz4AEcvcidQ8KZP1qzZJIoYQVM9koMJFg2ODkcdKpJvDPcrjyB5ap+yuSlCEuJe7gz/iyi56mV0DdIzjW3UFFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2VgwQ231bPnFy26htUtw/Y01hV6dqJQruO+8Xxixi4=;
 b=S/RaIkwtRk2VxgxxgYauHCFVm+f8VxwITVIllIJ5q/LumceR92rTtHVj1LwGU2peoTGoWhkNHHRRiNaNPyvAtHuI6ePbZeGYkenkZ4dHTh+QtVUkGIkCG4X4I+FpiQwwswxRHayjYUEIDx8SICehSWQ++Jz1dwlLxPL21Oo9JApXUj9MwfVw5Cb07f+sMXuAGPw5XNfxsTTMBOq8iTlOrFk5AGHx6+K3ZPYVXLZvNsipU99Hcbpe3mnY0121NMfgmJd8HzisSguHajamVm4Aa40XyvOU+0R5ATwm59duxYDlbGUWa03/Qjvu1yQoJlxpdq8//l4SqHgRkuRWAGdMsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2VgwQ231bPnFy26htUtw/Y01hV6dqJQruO+8Xxixi4=;
 b=ODdhG9JVT9/4K5bVBY/5PsGPF32oiOTKs49DUquzJMTwjWNHS6MSrVD5apKogVRommymyenmp4Z2BjXckGXHDXSqVJAfoIK33z+5fs4ieZZdLRS4/+jqCpPXfRALw/pj7jBUreZNJwfsZLxmVyvMMDFXgamVI68in+e6PI1Y69Q=
Received: from SI2PR02CA0039.apcprd02.prod.outlook.com (2603:1096:4:196::9) by
 PUZPR03MB5851.apcprd03.prod.outlook.com (2603:1096:301:a6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.24; Mon, 18 Sep 2023 17:00:06 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:196:cafe::c8) by SI2PR02CA0039.outlook.office365.com
 (2603:1096:4:196::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26 via Frontend
 Transport; Mon, 18 Sep 2023 17:00:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 17:00:05 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Tue, 19
 Sep 2023 01:00:03 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 19 Sep
 2023 01:00:03 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 19 Sep 2023 01:00:03 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 617816473F; Mon, 18 Sep 2023 20:00:02 +0300 (IDT)
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
Subject: [PATCH v1 1/2] dt-binding: usb: ci-hdrc-usb2: document Nuvoton NPCM supprt
Date:   Mon, 18 Sep 2023 19:59:57 +0300
Message-ID: <20230918165958.2659-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230918165958.2659-1-tmaimon77@gmail.com>
References: <20230918165958.2659-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|PUZPR03MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: fb8b3d7c-066c-4a93-f296-08dbb868b53d
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M53H6ijmio0AQSBA6YmCUm3ikCE2CivI0plmxy9whcEDilsfGrxJtEgkEkFd5z76NhrPZoTj/s8Xf3eMV+/pAbIgeGxJJMLItzVn0vZQM0VQM5kwyZW7eNvGYSx2qLRX5L997SU5ZsjkWfZZPBL7MGNF6UytlpMLCsplxEQGB6ulFmMh3PvJSYud2g7WA7FVaGGONXtIzE+aXzINdPyrwYgBSpEN9n75ZzYLYvqsW57B1ZZMPOylC9JkS2Ob8Ma6OaPibDIOM4/SMAerKx47VKS2bZbyqS84ChKQfhnHzHROo91PAAtY8yJYbKuDZADhlHht3ARxoWgpSccMSA6S2ySDhA5g6EjAyfW9YgOMkDiq2u3msuLgirds20zw2da6359GNnrP49CnWR1Oi5f6LyUYqHIJMHSj/cZqcw8VxhtVFfEdwMpzB7RYy7/vgkZdySNh1Ydh8X0LBWSNN1c1Ldo9Zlx+Xd2i8YAOm617/TtzhwPIuN13e2FoyA3UPV/TrWm5nnyVX+Xfvr1IX9ENarPv+ibFOnUKuBrMx6Nkr9BqdYfJQUzq/OpnZnz9bHAI80/y//6n7dyXlThK5Z9MckjG6Boo1GJnTnimVxdyff8orXLFSfAgY6k7BYVQHZ9kBaxsqCNgolb4Q8WCkt8ujJDVMBCqgGNFD3LhEYwh/5bdV6/ayD6kfdyJDUQ3K6PeANsr51u+RUSf0fmS/84SBbkZkYnUooKwCTu8yi0WfstVHHOH/JPgHWQSo5jnPE7c1kd5Yt2aaDyvpyPonUtIEhP7ji+1gZRV+3IgvXf2QY85JCM59xPYBdpsAdPpDSDMp9j839xtVn8R7/wgCzE2iY0zUw6FfdRV8LWhMnJaxiQo/owLxl3mMNQEMS9uHcb/dwL3hxNmx73IBP3gDHjrlg==
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(186009)(451199024)(61400799006)(82310400011)(48200799006)(40470700004)(36840700001)(46966006)(40480700001)(36756003)(83170400001)(356005)(921005)(81166007)(82740400003)(55446002)(40460700003)(478600001)(76482006)(70206006)(5660300002)(42186006)(70586007)(2906002)(6666004)(8676002)(8936002)(4326008)(54906003)(82202003)(73392003)(6266002)(336012)(42882007)(47076005)(36860700001)(7416002)(110136005)(41300700001)(316002)(26005)(2616005)(1076003)(45356006)(35450700002);DIR:OUT;SFP:1101;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 17:00:05.4902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8b3d7c-066c-4a93-f296-08dbb868b53d
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB5851
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

Nuvoton NPCM BMC SoCs use ChipIdea silicon IP for the USB device controller.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../devicetree/bindings/usb/ci-hdrc-usb2.yaml    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
index 1394557517b1..9de4dfe004d1 100644
--- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
+++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
@@ -16,6 +16,7 @@ properties:
       - enum:
           - chipidea,usb2
           - lsi,zevio-usb
+          - nuvoton,npcm-udc
           - nvidia,tegra20-ehci
           - nvidia,tegra20-udc
           - nvidia,tegra30-ehci
@@ -325,6 +326,20 @@ properties:
     type: boolean
     deprecated: true
 
+  nuvoton,sysgcr:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to syscon that configures usb phy mux.
+          - description: offset of usb phy mux selection.
+          - description: mask usb phy mux selection.
+          - description: value usb phy mux selection.
+    description:
+      A phandle to syscon with three arguments that configure usb phy mux.
+      The argument one is the offset of usb phy mux selection, the argument two
+      is the mask usb phy mux selection, the argument three is the mask usb phy
+      mux selection.
+
   port:
     description:
       Any connector to the data bus of this controller should be modelled
@@ -388,6 +403,7 @@ allOf:
             enum:
               - chipidea,usb2
               - lsi,zevio-usb
+              - nuvoton,npcm-udc
               - nvidia,tegra20-udc
               - nvidia,tegra30-udc
               - nvidia,tegra114-udc
-- 
2.33.0

