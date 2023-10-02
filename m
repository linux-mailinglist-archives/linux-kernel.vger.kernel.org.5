Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268C87B5BBD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 22:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjJBUGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 16:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjJBUGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 16:06:25 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01hn2228.outbound.protection.outlook.com [52.100.223.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BCE93;
        Mon,  2 Oct 2023 13:06:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iediswfvyTgLBPZWCg4dVW3YNC04F30lL8d+foQagxpW21wqFITqpiB6CYyo+sK+vwhCLZJILo/JYEh+mSCwNnMrEq8OEAhofuzrvk6ETyLbjQYDWwtfh0G66Ik/u633RQEIIPR/tnK/nqtlJttVjTpIVj+OJHMOwgEt86zWrxyRTzDXIPkzGK0+U3uRO99Y60WoUXBm1d89/rr8SC7Hu3kTKIJ9VcxORBk8tASOfrGFz3TEmhQCx/g7Pt1nI3I7E35w7jkNeydtVyFVE9x3ZNqD+omzLLSNcslxgr6VPC3HwFBV07f23qeXxYP5cq0CwG73XhjZBVExrDTDYWi+1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xh//HvtVKRvH9LtVE1IvCtdRPawMJE/q7BQZ/zoaMMw=;
 b=GKr/3e+o3eiA8iAekqtGcosEoMmlniN9olEDBMvLWvcelk/5/WRUndDZFPlw4Xg9QFXyYPdlyvZ1OxXpg7l6GaJfFSjdTksrWNzlmwDgFBtAEOiYXjaNSQzY76ir5hgnV7VA3SO7YpiPhOqZZKVOrASaIzjNlIQ8wUks3DRVO31CX639y/tSyVOiLMPrrWhDeBfggvuuNPlRYOxZT1nBTwmndXagsA8lpMv9hOyt2j3MtZI4HL3jDeywEDkXlMVbqiRj5VZxO8DKqSJr2yx9shOqYDac+sh4DrZJDIfSNBQUf4MdUFblIVOgtkeYLKbD/1B6PPqk6Xj1AGxTVp5/Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=antmicro.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xh//HvtVKRvH9LtVE1IvCtdRPawMJE/q7BQZ/zoaMMw=;
 b=qNAJ4v0a3Yi6jzGB+0x4kxBLuoDmmGbLuQOoxB7Xb+sBamhe9Xwq0tUcEj2HrrlR4DC34XRt52PT+kcwFw6oQHW3Ndl54ctYpjb2JNeGpNmYrpR6KUmd9gfzm3WL3kAG1giiFVNBAaCXhjx+VSdr3rjwaOWXihT9sVkvffszPWY=
Received: from KU1PR03CA0041.apcprd03.prod.outlook.com (2603:1096:802:19::29)
 by TY0PR03MB6426.apcprd03.prod.outlook.com (2603:1096:400:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Mon, 2 Oct
 2023 20:06:16 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:802:19:cafe::a6) by KU1PR03CA0041.outlook.office365.com
 (2603:1096:802:19::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.24 via Frontend
 Transport; Mon, 2 Oct 2023 20:06:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 2 Oct 2023 20:06:14 +0000
Received: from NTHCCAS02.nuvoton.com (10.1.9.121) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Oct
 2023 04:06:14 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 3 Oct
 2023 04:06:14 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Oct 2023 04:06:13 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 0787F64741; Mon,  2 Oct 2023 23:06:13 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     <ulf.hansson@linaro.org>, <avifishman70@gmail.com>,
        <tali.perry1@gmail.com>, <joel@jms.id.au>, <venture@google.com>,
        <yuenn@google.com>, <benjaminfair@google.com>,
        <adrian.hunter@intel.com>, <skhan@linuxfoundation.org>,
        <davidgow@google.com>, <pbrobinson@gmail.com>, <gsomlo@gmail.com>,
        <briannorris@chromium.org>, <arnd@arndb.de>,
        <krakoczy@antmicro.com>, <andy.shevchenko@gmail.com>
CC:     <openbmc@lists.ozlabs.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/2] dt-bindings: mmc: npcm,sdhci: Document NPCM SDHCI controller
Date:   Mon, 2 Oct 2023 23:06:09 +0300
Message-ID: <20231002200610.129799-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231002200610.129799-1-tmaimon77@gmail.com>
References: <20231002200610.129799-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|TY0PR03MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: 76605ba0-2822-4d93-8aa5-08dbc3830826
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CLpi+RGTHDtl3zT0jSfGeTD6mJk57fFTVlQEYtcqqpyW7dRGza09Q26ajtJr?=
 =?us-ascii?Q?7QfqbnDk/9r1mTPtg1kQ80agkUrAGlcOpbeoVIbdhzXqMWCsplEJVanf26jy?=
 =?us-ascii?Q?FnbrUlmc30RuyUfvWOHrP0V6Z5bVDfi/4eC2On8S3FWoGq0OemnJMMPmaCcq?=
 =?us-ascii?Q?+/zydSDu9tFtfehTXEcb0M1DZ7GlD+r/kiMwMsvCmI7RiShSfEkAWZi2CvVB?=
 =?us-ascii?Q?Q4hcigoSgwG3xnJf2ONXF3oubj0+HSnoa0lwhe8hNarwQXd1FovYAWNc6PFm?=
 =?us-ascii?Q?N1TAOVC+A83uxfovDy6/Y5AyGV6YGO9bnAQU4y3/G6SyxoriCWHV3Hm7aFyM?=
 =?us-ascii?Q?rSlS9ry7T/Y5hZwifqgwumqUWZ43MMK88NLxxLhzXrIzcybjXqf35OZIo9wI?=
 =?us-ascii?Q?0MgZnZCbN4lpAnhXewawjkqTwZDEIxY2tyZo0Ryd4EMGnYZHBGu2s1+2fJov?=
 =?us-ascii?Q?Qek4FnnRdqFMHNvYtodQVePT8nqc3+Al8VzwxXNXNTNkqOS6nflC3sfejpHb?=
 =?us-ascii?Q?Fdeyghc72dJepcj0AhdoSJyigGnNEYs+UUE3Adn6bt6yvfPHheX3ll5AGYuB?=
 =?us-ascii?Q?mlX/BjfPIEPHH4fiBcRlQKaZgGdJHGWTkb7CNVQWjuolKV0QY6Rw/Wf/xDLN?=
 =?us-ascii?Q?g1LtgmUDEeU3vj+l8PgyAm77jpk0+RSzykmdgbHvpV/KfdSnUbprLFjP6GZs?=
 =?us-ascii?Q?hXHMM9ASP27YF2jeL+PdKgatUiPfpSdqHlR5jUr5B7E/iWp5NtGCOoZ5CPOE?=
 =?us-ascii?Q?RMNuo/d3N5yIVcn91Uk68VQ2qKr5cU1HvMvIX/vTetW7ZLUBu+cWFtTR5wXi?=
 =?us-ascii?Q?MZCHitokYZ8huJuhPb0GR1F3vv7gCQDRgWU6avh66vT23sndBqE+m2ikNi8q?=
 =?us-ascii?Q?HUDitA1zf1v9cjPNnGyB4emKsgznC8EDTQzWffa50kM9MSWeC28OHK9oWhwm?=
 =?us-ascii?Q?ehnnahtNGCDlhDa2IqfcUWn4VVJWic/kSIaY/h4rRgmKusnQgznkVofKxfGK?=
 =?us-ascii?Q?r02OLmgKFercYmf69jgWYvWSFg=3D=3D?=
X-Forefront-Antispam-Report: CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(5400799018)(451199024)(64100799003)(186009)(61400799006)(82310400011)(48200799006)(46966006)(36840700001)(40470700004)(40460700003)(40480700001)(6666004)(478600001)(966005)(76482006)(47076005)(34020700004)(36860700001)(356005)(81166007)(55446002)(921005)(82740400003)(83170400001)(7416002)(83380400001)(336012)(73392003)(42882007)(6266002)(82202003)(1076003)(26005)(2616005)(2906002)(36756003)(70586007)(70206006)(41300700001)(316002)(110136005)(6636002)(8676002)(5660300002)(54906003)(4326008)(8936002)(42186006)(45356006)(84790400001)(35450700002)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 20:06:14.7620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76605ba0-2822-4d93-8aa5-08dbc3830826
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6426
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

Add binding for Nuvoton NPCM SDHCI controller.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mmc/npcm,sdhci.yaml   | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/npcm,sdhci.yaml

diff --git a/Documentation/devicetree/bindings/mmc/npcm,sdhci.yaml b/Documentation/devicetree/bindings/mmc/npcm,sdhci.yaml
new file mode 100644
index 000000000000..196fdbfa16ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/npcm,sdhci.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/npcm,sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NPCM SDHCI Controller
+
+maintainers:
+  - Tomer Maimon <tmaimon77@gmail.com>
+
+allOf:
+  - $ref: mmc-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,npcm750-sdhci
+      - nuvoton,npcm845-sdhci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mmc@f0840000 {
+      compatible = "nuvoton,npcm750-sdhci";
+      reg = <0xf0840000 0x200>;
+      interrupts = <0 27 4>;
+      clocks = <&clk 4>;
+    };
-- 
2.33.0

