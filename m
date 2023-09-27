Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BFD7B0109
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjI0Jz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjI0JzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:55:25 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01hn2205.outbound.protection.outlook.com [52.100.0.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B134A192;
        Wed, 27 Sep 2023 02:55:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jx/1S+k3sAqeSe+zIg8hoxmP3Ensp2uY59Nv4+/iyBo9nOO4/tbMaBCPcwY+OKQEDtihGg/8h7aXSXFnvFEAWlIUzMsZJmZq11/Jcf928GMPpzYeaPBhcr5RvBja2PmbSDj/1HwO3HmVdz8Mfk/5Rcnc1N59MQtt7vzJSExThCbJeowuu2hprehZL9tjnhl4xrajx4Uq9CuQPPEHAEJo/W8UYmLPx1YtrEihmSeejg6ARX3s3488FktkJAu+yRJvTXK8KiIYpAtuNqwtq7TQtsfkVCJD7r3nBvNoDc5jpm0mGmzcHoHlqxyJz0H2Uy+Z5jIHodrq8c6X/T98+fj6ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhbXqOJR79u+/b1TOeqh2Q568aPZn+33VQAaeCzrrDc=;
 b=b+uBEHisN2dfdzDvIMUGHYDrt0RjtWLsTa0kGGTsZc8Rr3sa70ppZdRAf647LdKa9cPn1/se4I8BfrPcIa3+53lrhB+s1qs7wkU5kMUn0XLOITmx5tgNi+JHJIeZ85M0Tqo5W3Dt9gb1tpnHOyWJY7CFz824XshGvEwtpbKOy46LDgb9/WbSUL1QrDMBNPHr9cb3UYT4Y0G/eBRtRA6VgqoL2qqnn5RBq5aLcyA1A1EZiG9Ot2ysimLT7rRlxybOHhuzzODecmImk4+9WE7R3SOEyLEQEqW1qsXzR8dPIR1sUy6DbayI6a4y4Pq12jcjh0JXJ0z5UKb1Zzaee/Bx/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhbXqOJR79u+/b1TOeqh2Q568aPZn+33VQAaeCzrrDc=;
 b=jpvxniJfpFXimsLfsfqV99ypiuab344h75LT4ylsrJAjpBPf1NHU7mn1C/xUCfG9pxhDjzrXDuvTBL5qspJDiJ9haSDuLAl6cfaDM3e0fTPfVhfPZ/XTk7kiAHz9eD+/bC2QuOz/aHec9eCtESEhP3Xxq2tvX8ulyUDvc1vvOkQ=
Received: from SG2PR02CA0101.apcprd02.prod.outlook.com (2603:1096:4:92::17) by
 TYZPR03MB6599.apcprd03.prod.outlook.com (2603:1096:400:1fd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.24; Wed, 27 Sep 2023 09:55:18 +0000
Received: from SG2PEPF000B66C9.apcprd03.prod.outlook.com
 (2603:1096:4:92:cafe::44) by SG2PR02CA0101.outlook.office365.com
 (2603:1096:4:92::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Wed, 27 Sep 2023 09:55:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG2PEPF000B66C9.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 27 Sep 2023 09:55:18 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 27 Sep
 2023 17:55:13 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 27 Sep 2023 17:55:12 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 31D0864742; Wed, 27 Sep 2023 12:55:12 +0300 (IDT)
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
Subject: [PATCH v2 2/3] dt-bindings: usb: ci-hdrc-usb2: add npcm750 and npcm845 compatible
Date:   Wed, 27 Sep 2023 12:55:08 +0300
Message-ID: <20230927095509.267029-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230927095509.267029-1-tmaimon77@gmail.com>
References: <20230927095509.267029-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66C9:EE_|TYZPR03MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: fe94630f-2eec-400b-662a-08dbbf3fdb18
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KPKbSaOHBa59HKsAcPDl8arkaDhU7uC1l2yrwOAMaa8j9dJpGtm40kepbTwI?=
 =?us-ascii?Q?fexkNTfdevV9G8jg/09WQvOkcz1CQR/r+JKbpEDojbfVayVT1hFQfYhbFXDw?=
 =?us-ascii?Q?QjPtt3agX5sfIo6wTvS3+B6bs0RQgX+tKwrWl+3EoeyM7NA6EcdCVq3lDhzi?=
 =?us-ascii?Q?9k/dAM5/uwy2wt7FB9keBwtTh6oW/yCdg6sWn+ugAruzOcmIxeYlHbHslBR6?=
 =?us-ascii?Q?AjGGWjZ+IzLn2cUSCSEoS/tRaTUV7YhpzQU/w7TZ4IWBXXaVcwJouCAwjhJ9?=
 =?us-ascii?Q?ccCn0IsJrtnV1nY901Wwz0KBzxIy/SM0B7djW+/lYriGfuaHYWgbo+AtgOV2?=
 =?us-ascii?Q?I/fVEiVUSniN0QrnQggWL9Hhxm1LA7d50lDsg8Xz7K3fbX08IjumETic4IR+?=
 =?us-ascii?Q?2P8guznDKulOg5yZ/96RKWrioIBIQ/XbMtlhTm148GC9xYhdNG+bb2pDZ9YV?=
 =?us-ascii?Q?kgF5mm36ym6xKoR/L80WxqVQJOZqFF2FjaegR3HEh8c5hPYW18KjGfRq09JN?=
 =?us-ascii?Q?CZZtxlwyYcmzjv5NIfP6D1xiLvxMqSPEBCc164OZD8GoQSRh+kEpmgDHFmbX?=
 =?us-ascii?Q?UzyugYaNPkJ84kAVQb1k237Txs06qaiGQX4O84L/Y5sKr2FunMY3+W9liJln?=
 =?us-ascii?Q?xbRWdGQmY88o3miQOm1+l/PK0mMYCJwypm4nhTyyRNaz2hDcxzDHehNszaep?=
 =?us-ascii?Q?UavD7Yhc7ne3pXtS+YouRO2q1g6EnkJ1hdtbbU7ACrk1wf5AuYRNwxks39+N?=
 =?us-ascii?Q?GBnqLvlvVcyStXQh+rddg4v6a1/ansUTagUR1c6w4afSoGyr6HXxky+GNkn8?=
 =?us-ascii?Q?1h2yBL6wBTvSTlFj2cB3SriIDWRWyVu5Dfybs8+O8mgD33PiyBxb/a0mYbhF?=
 =?us-ascii?Q?I9QOjPqCRDqgesdK8Nwg/vgUrHJVmMJ9T6fhoYMsi4b8s9AM6OA04D0OEyfo?=
 =?us-ascii?Q?8DKLgQtK1YQFD9IjUl308kUmqUxHhRYPydP4uwF/Ul0=3D?=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(82310400011)(5400799018)(451199024)(186009)(48200799006)(61400799006)(36840700001)(40470700004)(46966006)(4744005)(40460700003)(73392003)(6266002)(1076003)(5660300002)(4326008)(54906003)(110136005)(36756003)(82202003)(40480700001)(70206006)(316002)(41300700001)(2906002)(7416002)(8936002)(81166007)(42882007)(70586007)(356005)(26005)(6666004)(83170400001)(76482006)(336012)(42186006)(47076005)(55446002)(478600001)(921005)(34020700004)(2616005)(82740400003)(36860700001)(8676002)(45356006)(35450700002)(84790400001)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 09:55:18.1461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe94630f-2eec-400b-662a-08dbbf3fdb18
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66C9.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6599
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

