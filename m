Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD88B7B59D3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 20:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238144AbjJBRvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238371AbjJBRvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:51:09 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01hn2249.outbound.protection.outlook.com [52.100.223.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37546DA;
        Mon,  2 Oct 2023 10:51:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOcPx7f54RjSX1d7TWhvxbAc1XlV02PfgUgPCGACg4RFHKiIsEaiyppUERY35cdwyDfuexNyNoG/qsQL3osQxwXi5Or7emaB2Eb8VwHoZ7vQIGTHQJ4YBlFHH9odJ/dv3NStTNtzm94M1hjg4A5pqq0k3eJsuKweZfK884UgwlZFv0T4yldufvtU8s6UD93JcHm3uC26rvzubmjZKzd/XCSRyySK2OuEYh0uyrFkQRDOePNr67smPSAlhNkuTPYfS0A1k6863anjpkmLKIzQ4Fn8OP8/cI1LeLmo0nFWXLdYYEACiPjbaWtsbkL3hr17z/hH9JznQ3B83ZGuZ6+FqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xh//HvtVKRvH9LtVE1IvCtdRPawMJE/q7BQZ/zoaMMw=;
 b=IcdSJtM20CSDNDNWDFu2qbVhjw1x0wrlSSEec8N8uPhJpWRrnriEvIF+FtCB6hvUnpZ9qcnzGoVJTIX+5vCDXZFFlIYmMqKWFoeOyH2r3FiiqkU7PR8naxgKoONyUAj6ssHvybLN87Uwl5EKUBGPobLkhVrA1+PHJ/u2JitlEFoTaLrurpnBZn0R3j+th/WTOfI3bx0i5vbEkNnhgw/743SUDIQKsaAh3A45WM92cdpY0nYy7WfUq+kDyEZt0CC8StMFsb+eTOP6FSmOsP6AnFMi9y6EVIEpHTvEMK65CJRuIT1CjkmN8ROLDhsXpbF6r6XDubvr8PCTzxT99UwvqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=antmicro.com smtp.mailfrom=nuvoton.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=gmail.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xh//HvtVKRvH9LtVE1IvCtdRPawMJE/q7BQZ/zoaMMw=;
 b=lPT1uIfD18pavVRmhiOfiTwOY3tUCxolfMcXfHOhC39kGUOrTWYw6/s3RkIkvMF7n9PeQ8NGX6edZxyOg6xaG2pCq7QNyT9cW/8JzAiE6HoxNRQxI+KW8irmaCLZPHKbi5o8p0tSLlx96rTsWaBoC0RjXDJ/XDxLEA4NJfiT0uM=
Received: from SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) by SEYPR03MB8079.apcprd03.prod.outlook.com
 (2603:1096:101:16b::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Mon, 2 Oct
 2023 17:50:58 +0000
Received: from HK2PEPF00006FB2.apcprd02.prod.outlook.com
 (2603:1096:4:193:cafe::3b) by SI2PR01CA0047.outlook.office365.com
 (2603:1096:4:193::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.32 via Frontend
 Transport; Mon, 2 Oct 2023 17:50:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS04.nuvoton.com; pr=C
Received: from NTHCCAS04.nuvoton.com (175.98.123.7) by
 HK2PEPF00006FB2.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 2 Oct 2023 17:50:56 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS04.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.14; Tue, 3
 Oct 2023 01:50:56 +0800
Received: from taln60.nuvoton.co.il (10.191.1.180) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 3 Oct 2023 01:50:56 +0800
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 3536764741; Mon,  2 Oct 2023 20:50:55 +0300 (IDT)
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
Subject: [PATCH v3 1/2] dt-bindings: mmc: npcm,sdhci: Document NPCM SDHCI controller
Date:   Mon, 2 Oct 2023 20:50:51 +0300
Message-ID: <20231002175052.112406-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231002175052.112406-1-tmaimon77@gmail.com>
References: <20231002175052.112406-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[175.98.123.7];domain=NTHCCAS04.nuvoton.com
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB2:EE_|SEYPR03MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: cb23849a-783e-409e-6656-08dbc370217a
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V5jyVG4UDWjmmdhfVIj3Qi3YFgb11LNI48sLnmn/HRZw6nBVbPzShxPh85O+?=
 =?us-ascii?Q?8UIrwqjBu2rOfaERO3LrQa2B4Ae2TX9E0cveNqWUpKErE6Jx4r9slnbUcZNS?=
 =?us-ascii?Q?bkFzLvIY2ECDL5ArBgO7yS7C8bFOYvC053l+m8dMhBniyEcEHLH9GIUZQc8I?=
 =?us-ascii?Q?HIdatGvokYItmNaZfkECLezNdRAL8a27sImR9qyiAUURCo2cVcH8QL/AVzCl?=
 =?us-ascii?Q?IOugzOBGiFqjke77J10scdqgUIFiG5OlJ+05/zVGn+wf0dIxVzAteSuOud+3?=
 =?us-ascii?Q?QP+M6PkP59iZaOppJnXkvvAGeReoLc2rzmzZF+5VIaR1dMkOEKIAsO1xT/n6?=
 =?us-ascii?Q?UautKVp8gwQ//dZPN+Opai+/cyB5fpA0nsiQhrj2jBzk1ZoB/pm5goBVZjWC?=
 =?us-ascii?Q?OH5Qfp2CABtGITNAPQO9pMCGHRwRF9VTmB5IvrkEIDsyPqupNuaKp1mbVaD7?=
 =?us-ascii?Q?8NMb8ZWwMLSMrgzv5/+2AIKdx03pccrfYtHP0l33CLowOdRarS7OyQfuXqrg?=
 =?us-ascii?Q?+N2rcfOkYu+hO8O5ZYYnkuscdHxD8aGBc7L5iLZyB/VU95BQYOsTO/Tz+mK/?=
 =?us-ascii?Q?IaX4ryrXfWmwpDktcl9L6Hxnw3HzYKRm/FJQ0QmjMVlLF1/FRxIRThKcXHh1?=
 =?us-ascii?Q?1Un4+K0NyvUM2qH55BCDHTNQwBkngKaT7VhctqYtivqHukaumePOXV1zffEr?=
 =?us-ascii?Q?tNlIo4tD6S5AoLCxim4NtAKsoynaDxwIJI6OqyVgH3DIzIax99ko2CkANg+E?=
 =?us-ascii?Q?wmcHfhFQ23yVivXuyb6g3K0KrbnQl/zPtj94WM0GQqUT/yfI7fqSv2dkc9uh?=
 =?us-ascii?Q?iLKKMUMGHGYP4+Jn3eu9i/MKQ4DCBAjRsrj9ccCN7IqskPZ3OCccXV9ieC7d?=
 =?us-ascii?Q?uRJcY3pCphcKZaNw+VvhIAL4U11JUDMZ6FJh9VmBn9OuYtEOSMdqUoDV1XLn?=
 =?us-ascii?Q?pLUhqpAwoiFTxUrg6lQ9bXD89vegUNgsiQCvX4pwh8bXDfqwiUWYIvcHPU60?=
 =?us-ascii?Q?OIRFJfcPWj6vt8IEBzjNx2R0bIIN063/AKfqNmSd+v1rvUw=3D?=
X-Forefront-Antispam-Report: CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS04.nuvoton.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(186009)(61400799006)(48200799006)(451199024)(5400799018)(64100799003)(82310400011)(36840700001)(40470700004)(46966006)(6266002)(40460700003)(6666004)(82202003)(2616005)(1076003)(82740400003)(73392003)(83170400001)(70206006)(336012)(55446002)(54906003)(42186006)(70586007)(966005)(356005)(42882007)(76482006)(26005)(478600001)(921005)(34020700004)(81166007)(36860700001)(47076005)(110136005)(83380400001)(316002)(7416002)(2906002)(4326008)(8676002)(40480700001)(36756003)(8936002)(41300700001)(6636002)(5660300002)(45356006)(35450700002)(36900700001)(84790400001)(12100799045);DIR:OUT;SFP:1501;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 17:50:56.8011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb23849a-783e-409e-6656-08dbc370217a
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS04.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB2.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8079
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

