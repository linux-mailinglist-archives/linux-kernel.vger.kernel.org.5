Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44FA7B574A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbjJBP7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238310AbjJBP7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:59:03 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01hn2208.outbound.protection.outlook.com [52.100.164.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68135DA;
        Mon,  2 Oct 2023 08:58:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBzk8aG2KDyK0bfZbgoCzKl6lBDRqpfVJurBbPc7YV8VUWTl0IN9is77T0CVzpCyhTpCKguor0NcMmFPHjFzU/968pc3lmXTk1LwyNKvovSUuL1u5CMG3SsNfLfQOSKVdUgZKhzcPPcZs3AyTkCuMiK+Q3jowuQpb03Iugy0Eigmsw4dPRwXaZzXDKIKJpxspndFxBjn+ZOy3fyhhMouRjZX/s0Sf/GGeB8HkuZ30sEbUehNmELCdfBP/YukZ6fMnFIRUHUA0+XWOCrXaqy01WFucL1Zh5xERVLDWIp6/mssSgBAwkTHvVLbSOjDZEpGgZ+tSB+qGeadeR2AYgBc/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhbXqOJR79u+/b1TOeqh2Q568aPZn+33VQAaeCzrrDc=;
 b=Bhd9ysKFzJgEL27CZ5cYK4amvRTkkgfCi0Gi4EwNyuYWti6cukLOSLqSF4P0iOkjmqEFm8uKoCW1Sn94r8En0dDe0b9ZpWT80UT96jMrZsrYYzYCWwYkpFluW6Dib97F5NiOkB4m13WV2aP1pglXYDUCEIqqyA6AQfGqoS/vyg7qrzbJrXJfqRyTp9Vj8X1m1U9QAkJpcEpgBkxqPtqCvrLq2zFII0+1AoTCAGY+L3gnqu1SCUEuaiOJV2Xc7YcQmGip1bcdlLuNEFRmEU2U22/C/wTkNfV4kOZT3LgW2oVLgh9axHgMsPWEfo2JlMqF63IwcSs+OzNWFkD65Ii2zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhbXqOJR79u+/b1TOeqh2Q568aPZn+33VQAaeCzrrDc=;
 b=S8NJupPp/x2Wmfsc3T9AZcUzxRseoRODu//N6qDO1Hn4zKcTczZa/LH2uOfiPxHFt9n7ZcUuxeMMVY36L0V4akNzw+s9Xf52yKL2tdIL0br/Qg8uhepAta3WRmYf3o1/Zf/V9JhgqyEVe6ZXQv5UTrrdQR6mGkqFqzvcjBemMz0=
Received: from SG2PR01CA0145.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::25) by TYZPR03MB6696.apcprd03.prod.outlook.com
 (2603:1096:400:1f0::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24; Mon, 2 Oct
 2023 15:58:53 +0000
Received: from SG2PEPF000B66CF.apcprd03.prod.outlook.com
 (2603:1096:4:8f:cafe::a9) by SG2PR01CA0145.outlook.office365.com
 (2603:1096:4:8f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30 via Frontend
 Transport; Mon, 2 Oct 2023 15:58:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG2PEPF000B66CF.mail.protection.outlook.com (10.167.240.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 2 Oct 2023 15:58:53 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 2 Oct
 2023 23:58:52 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 2 Oct 2023 23:58:52 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 8D7C464742; Mon,  2 Oct 2023 18:58:51 +0300 (IDT)
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
Subject: [PATCH v3 2/3] dt-bindings: usb: ci-hdrc-usb2: add npcm750 and npcm845 compatible
Date:   Mon, 2 Oct 2023 18:58:47 +0300
Message-ID: <20231002155848.62198-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231002155848.62198-1-tmaimon77@gmail.com>
References: <20231002155848.62198-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CF:EE_|TYZPR03MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: f1abb67a-dc0d-4252-6956-08dbc3607a19
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CplAmAJtC7NQKB4qmkfFzwTHhAfkZUOk+AD6nYZJbKVaFGX7x6MpBIIaGJ68?=
 =?us-ascii?Q?67zqehTsz48ytxgliCOjZr++4dCo5d3S2fNW7/WPLgq2jhS+FqgbRhPVJKZk?=
 =?us-ascii?Q?lF5EIZZfzV+Itit1ALSnlixtMP2fpfK+1BKt77aCCWZsCOhH0/LlxF6j9uAx?=
 =?us-ascii?Q?bPsca6rCoJhlb7AaJpImvMrsTzykOTqXCcmNGgUdmSBG3z0jBDPwRJLS356M?=
 =?us-ascii?Q?OrOfmAcKlNn/RL6LS2in0OQvh/SR0w2PeLNC4GreQyXgAlcu8ZgxCGsg4GKH?=
 =?us-ascii?Q?b0W//64nM7CrNn+WFmiue/jEZ+mn/MuCUAXr+E9xzxTF1xXMPjgKVzx8M/k3?=
 =?us-ascii?Q?w/OcEX1dvwfNJ6OxdQNXW/kBHpZdgwvYUOv5xhd6e9ieGerLDwKWn7ZNDTAj?=
 =?us-ascii?Q?KbIk/IyMQI5zSNV6X3XKW0RgR9F3ExCfRCtu3mmAlNDUl+B06Gxfo+F+WPS7?=
 =?us-ascii?Q?6pWOP04vHEaFednB0hO+spayKp9S/4nLaSdKn0LQSai4QGl2VavqV/FVrAU/?=
 =?us-ascii?Q?06hi/nRb2g2fpmUS5sRRlMdHi/XHgZZ77WuohfYZ0j7RyUp6Im77YBSZBbNl?=
 =?us-ascii?Q?kPfaoEBYWdHTYbF+CENWK0WctpPezAZk+tCk/7RZSAf2d9uv8URqgN5B1Hgb?=
 =?us-ascii?Q?yFSr3p6avNueT3oQOF+UwT2IJ2VdkXg7+Mi38Fn3RjIGpASzwhXGstRVjEQ7?=
 =?us-ascii?Q?YW2tYNqnh7AoinkUDq4Xcu+lMZiDmJiqG4ttgrf7Ex0x7laWuY0B/SX4Cei/?=
 =?us-ascii?Q?Uet/Rj+R1neJRCDNS8s7o3CafjrahmNGWO/wyDMY2tIeuoU6csRwEHgrMpWt?=
 =?us-ascii?Q?DcSVkVNYfNFZLw7FMC8FCExlU3J29hgQvOlMRR12dO8whmsBXw1FmqgLFO7q?=
 =?us-ascii?Q?CjzqnyjTLO6rpzJXnnnMTLedtiVOiTfXXR14r0ZszQbdlnPRXNp1I6dSO9hN?=
 =?us-ascii?Q?wgufyzBMW+aYEK7yovVw9zV56Xt7sn1Rl1MONUSprxk=3D?=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(61400799006)(48200799006)(64100799003)(82310400011)(451199024)(186009)(5400799018)(40470700004)(36840700001)(46966006)(47076005)(40460700003)(6666004)(478600001)(73392003)(42882007)(36860700001)(34020700004)(1076003)(83170400001)(2616005)(26005)(82740400003)(82202003)(6266002)(336012)(316002)(40480700001)(356005)(921005)(81166007)(4744005)(2906002)(55446002)(8936002)(8676002)(5660300002)(4326008)(70586007)(70206006)(54906003)(76482006)(36756003)(110136005)(41300700001)(42186006)(7416002)(45356006)(35450700002)(84790400001)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 15:58:53.4725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1abb67a-dc0d-4252-6956-08dbc3607a19
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CF.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6696
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

