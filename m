Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862547B5B7C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238952AbjJBTlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238929AbjJBTlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:41:50 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01hn2204.outbound.protection.outlook.com [52.100.0.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A2BB3;
        Mon,  2 Oct 2023 12:41:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhAJy4u4o9T28GEgZsstQ8MwX2Ft64SzBZcoXaIGMylLe+eN2Q6wRATzDZb8Tba5vsjl01RAIAScl3U69E/qvWrhF75vAxBLnp+aq73kSFe2oFMWO/UWhJXbYOeGVLYkRnNbBatas9FdMECeK46OwbIumli0qBjICbCrlShMNChb+ExZmxYgqPGT68zlK8PwUh4UIKVfYkEqh+4azAThq9Yfj+yuEdv/oXMLEN7prGzc4seCM27YhlFi5GOsIos7kLPJiiJ1JywFcZrF8UTOdzH1t9LPpI75WZ0QJAUvkU+i9nc4QAKgtdGWagxUIZBg/KGvfQAF1oAQvcJ3IsXPtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xh//HvtVKRvH9LtVE1IvCtdRPawMJE/q7BQZ/zoaMMw=;
 b=HMkFAdjXZgD+D2MaU4gKNi5r5GNNjFFfTila7JfqBfqHqXJXiqP89e5Ik9/b7qA3WsRL8sX6Lu2cmuUQIoC+P5laOydL4gyW+QILxrEMR65C5wDVfCfWXwn+paNxOPsq4Nf0YxeNMTYhy1k48fjRTbEOxPAw8JEcBEZO5vjE+RhdxTxB8GtXGm9e0v1LIx3LmPblN245RKf5hl7ePVco1QVBLQpbWS/73j4V136zsQtdzgbkEdLl4B94sDCge5H5yxHqYf+0HdnlxlJ8Vk0Gl+DL8+IZPq3wmmO2PeIApfBW9zqQR718wyMsuD3TQ0e8OrR+y1ICKtc8duId4XSY3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=antmicro.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xh//HvtVKRvH9LtVE1IvCtdRPawMJE/q7BQZ/zoaMMw=;
 b=fyQXyIpyBaZTPBm7w5WrcjBNSsIEk+vJvZ4AsPwqxoxq/Dm0dGXO5MBDkQ7Dh1zhKMHuHfi+4kmsIIWZGZbys05CcssWPr2PBYym7Vo2QDNe+OrUCtSljuvalIKt5D8UjMQk+81ONfhq3Is8U1ujtGuvMuiImjLoYP7XdFcBVmM=
Received: from SGAP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::20) by
 TYSPR03MB7884.apcprd03.prod.outlook.com (2603:1096:400:47b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.28; Mon, 2 Oct 2023 19:41:42 +0000
Received: from SG2PEPF000B66CE.apcprd03.prod.outlook.com
 (2603:1096:4:b6:cafe::9) by SGAP274CA0008.outlook.office365.com
 (2603:1096:4:b6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Mon, 2 Oct 2023 19:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 SG2PEPF000B66CE.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 2 Oct 2023 19:41:42 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Tue, 3
 Oct 2023 03:41:41 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14; Tue, 3 Oct
 2023 03:41:41 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Oct 2023 03:41:41 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 6CD5564741; Mon,  2 Oct 2023 22:41:40 +0300 (IDT)
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
Subject: [PATCH v4 1/2] dt-bindings: mmc: npcm,sdhci: Document NPCM SDHCI controller
Date:   Mon, 2 Oct 2023 22:41:37 +0300
Message-ID: <20231002194138.125349-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231002194138.125349-1-tmaimon77@gmail.com>
References: <20231002194138.125349-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[175.98.123.7];domain=NTHCCAS04.nuvoton.com
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CE:EE_|TYSPR03MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 47373453-7fe0-4274-86db-08dbc37f9a9f
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oFvI3z8IbK/tswUPemzCKxa+zCnYVQHVEAtBEYYR9/gC/osVB4bf61TdpmM9?=
 =?us-ascii?Q?0bh5F8MYtYKGB2r42fDB9wE6Z+eaD2Zb0H1mvegpBe1lAtc+uWRzXQyzSxXS?=
 =?us-ascii?Q?O+GWwkEpGgO3CzUPd0aViYWA4iepy6zObFNFlLtXnaRSEpIaTTGYwcstD1It?=
 =?us-ascii?Q?whwJMiXMd3nLTgGGz/OETX9FXlfBDabCoKmstfy2rQLffKn8/5OOcnr1gXAt?=
 =?us-ascii?Q?jgAGr0cQn2HVKY5lvbnUq8TyotEpy6yXAmm7vYR6CnVyyzzdBnGeIiVaHt7+?=
 =?us-ascii?Q?vTOEBiQ3A3R+RBVLAKoaUOhZTOE3Ggp7iL8oQMZXh+RkQunIJdkUxTPGEJsc?=
 =?us-ascii?Q?A3hU5a4NBHpissdLaYC6M5vzL/hjfcjuKTyYcIWNX/+Qg2lYyaDnnmxrBQ3V?=
 =?us-ascii?Q?f/x+OXfdvrpv21SUp2G0oplj0VA0Q11+jhyDQT8vC/ngtwKsFty904asVJ67?=
 =?us-ascii?Q?QHJQkamFxK6+ZqsvY82n5kw+zNRB9JzCig54+6eijO6SBr/GHcxp2LBxfSw/?=
 =?us-ascii?Q?aclXz/L8B/bk/8stQIS2X8Ls82w/aP3I7l2YBJysdm9iUQlhqGId7LZskkga?=
 =?us-ascii?Q?pKseY3csKwsb08/KscX7EyewDH6SAmCmuwfpyfSNGnhb3+Ondy7/AhyNHy6p?=
 =?us-ascii?Q?TOek4hgi8Gjskf6eD8XoMaFpNqcREukCvfBg5L0+1HLI9bhW7WY8zXAZ+GVX?=
 =?us-ascii?Q?1liFxvv3du057oWHUA/y3WAKXAzMIOhFGs7CYiGxNCjVnVfaj6RYUb//P2f8?=
 =?us-ascii?Q?0cUCw0hB87fbo7dDpfKcx8zfAQgkNWtL1jAC9a8R3EqSPwFaTYtn4dmzzlgE?=
 =?us-ascii?Q?r/lPel5mpwQczLvJKSNjbRzPewib77Gb00FqhD3fLUGwKaJasYarsZwTER88?=
 =?us-ascii?Q?VhimpGKTKLGXxOJDoeAkLe7BBAYrPpJ2ohnyE8YYi0ZbEJkTFgkVFgu0hRtg?=
 =?us-ascii?Q?4XjhXqYPnxj2RWnOmuPBiGZ7m3adEHcnP63QXDS7I4MTKYbNqcI35S3HzrIu?=
 =?us-ascii?Q?MQL0FJKHqiMD5Ditm83IyvRnzQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(61400799006)(48200799006)(64100799003)(186009)(451199024)(82310400011)(5400799018)(46966006)(36840700001)(40470700004)(36756003)(40460700003)(73392003)(40480700001)(34020700004)(82202003)(36860700001)(83380400001)(55446002)(5660300002)(41300700001)(4326008)(6266002)(26005)(42882007)(336012)(2616005)(8676002)(8936002)(47076005)(6666004)(1076003)(81166007)(7416002)(478600001)(966005)(2906002)(76482006)(921005)(356005)(316002)(42186006)(54906003)(70206006)(70586007)(82740400003)(110136005)(83170400001)(6636002)(45356006)(84790400001)(35450700002)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 19:41:42.4372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47373453-7fe0-4274-86db-08dbc37f9a9f
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66CE.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7884
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

