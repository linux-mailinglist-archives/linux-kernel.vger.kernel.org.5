Return-Path: <linux-kernel+bounces-19707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46106827143
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3E78282C34
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ECB47786;
	Mon,  8 Jan 2024 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.onmicrosoft.com header.i=@nuvoton.onmicrosoft.com header.b="uttHVWk3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01rlnn2050.outbound.protection.outlook.com [40.95.110.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394314777C;
	Mon,  8 Jan 2024 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=taln60.nuvoton.co.il
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Toq+zBhFGLG++L0jAmn0+DOMlFPrWREuQ2ihXl8OQ7CqBL7dFI5JYM5957dC9yBDSte8yTGmXbJ0lwaSP4J8g8EpA5KEZlsKUPGsuPIzWB6uLcmWrIKOskpu7HAhGgsHLnnhBcmh56WutN1vwChF8c28Wh3EtxK1wFCsRaub8zpmvKdKaUDYa1ZaOlZvYP3NOcLx9wEPlZwj+HJ95fSjYcLJKOn3K7nPYS+JXAyoHgzcaH1fuibQ1vBoMfjwcoDl88e5hD7LxgpMeZXfqTARSYXMFiVHSsq6kRX4+uJ9mMSm0hPJcF/LWNU/dLgCo99gWKEmrW6hnLOWkFTlFcU+gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvTno2ldL33EagYWpxaNixMNkdbH0dEQ0CPhyIa9KWY=;
 b=VHh3AvH5bsxdzmu9XW1oQD+kRCw+b3tjCkHuoRn/kDXHf1SJTgy4UD4qVoy+kiYBl/nxbvv7Ou2zZocMZRL+WJRGBOyrGhLVafTf/4qLqJZ3vJeWryR4LFqH4gHBRv9k/C2LIJE/eqsZDRi3WZdmVWxJ+HqACKo8c7shB6eLU7fVFFFcN8HyrkCDBgZw1p57JqV8bqNqAi9LKRr3MNjI6gEARcndje6t8ibPbRxW7zwbVuAskkeyPKoVXIi0Y343ZrZldf3fOj50y1+FDmLjh3do3qb9q+WAI8NE4z4ifP/GEuPT2J+mmeFG95o5errnD9X9x15Bsm7MFZys/w/wTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 211.75.126.7) smtp.rcpttodomain=baylibre.com
 smtp.mailfrom=taln60.nuvoton.co.il; dmarc=fail (p=none sp=quarantine pct=100)
 action=none header.from=gmail.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvTno2ldL33EagYWpxaNixMNkdbH0dEQ0CPhyIa9KWY=;
 b=uttHVWk3xgMag4pByyKzbjXLB3tsq62KgeQunEPXdPbDwxg8ouFzPRKdapf59oJasl2i/fkdxtMbnfxDiIyfBXwatUGpY+xvyZJxrggsmEWHLFTqC9SjW6JwbV+jkxCt5CLocgPQRWBA8Cf282qrN0K8Fqk72TM+P5YVsw/PO/A=
Received: from PS2PR02CA0091.apcprd02.prod.outlook.com (2603:1096:300:5c::31)
 by SEYPR03MB7968.apcprd03.prod.outlook.com (2603:1096:101:168::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 13:54:30 +0000
Received: from HK2PEPF00006FB5.apcprd02.prod.outlook.com
 (2603:1096:300:5c:cafe::ac) by PS2PR02CA0091.outlook.office365.com
 (2603:1096:300:5c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Mon, 8 Jan 2024 13:54:30 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 211.75.126.7)
 smtp.mailfrom=taln60.nuvoton.co.il; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=gmail.com;
Received-SPF: None (protection.outlook.com: taln60.nuvoton.co.il does not
 designate permitted sender hosts)
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 HK2PEPF00006FB5.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.12 via Frontend Transport; Mon, 8 Jan 2024 13:54:29 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 8 Jan
 2024 21:54:24 +0800
Received: from taln58.nuvoton.co.il (10.191.1.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 8 Jan 2024 21:54:24 +0800
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
	by taln58.nuvoton.co.il (Postfix) with ESMTP id 8C75F5F649;
	Mon,  8 Jan 2024 15:54:23 +0200 (IST)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
	id 8BF9CDC0047; Mon,  8 Jan 2024 15:54:23 +0200 (IST)
From: Tomer Maimon <tmaimon77@gmail.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <tali.perry1@gmail.com>,
	<joel@jms.id.au>, <venture@google.com>, <yuenn@google.com>,
	<benjaminfair@google.com>
CC: <openbmc@lists.ozlabs.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Tomer Maimon
	<tmaimon77@gmail.com>
Subject: [PATCH v22 4/8] dt-bindings: soc: nuvoton: add binding for clock and reset registers
Date: Mon, 8 Jan 2024 15:54:17 +0200
Message-ID: <20240108135421.684263-5-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108135421.684263-1-tmaimon77@gmail.com>
References: <20240108135421.684263-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB5:EE_|SEYPR03MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d72320-b249-4be3-aee6-08dc1051556b
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ePeVN6yWmgxcfRl8nzvRTI+Y8369zHx/Aov5bTLywIPvuqHXjnLdMbNW3WMxfUa0P65NZP8FugLKcjCma6iOVi+IwiIiH7VbvUefB7UHuaSoLS5u88y7TCA/6LZgQG2406Q4dHrfGzLS372xRYkD5pB6Mmj0cLbtCCfVifyC60aRfhkj728qg8Dapbz0Diq+OqcSJdKQlkGi0SGgaaRy1zcjyjcdAKJNQVXBYED1ogcjaexjDBhTd94d1L1NJpckNidYpP0G+eyGNwE9AEeyGEPVfmNaMmgsHUBBGZ4pt6cVYdR2UINmYSpA+JXVqA3AbC/CEkujHyEm5RKF1T1SclmSDMu8M0FI9bwh8CVVr5LPEDy2RPvegmiJmshGWhKaRjY+Zy6dVZsyUkNNrDjGUmR3WuKOAytPSnYJ2B3pqtOZjat/ZhnYRuDP5Z6FacNcsEBvInCVu9DVOILnsVbO5FVu69ORw96JQDnVuuSow+d835Bbki+nUSgFx/9gZCDDJZ4f22eEEhmb9GCSTFokp2B52MkJink/d5VvnY4EzOLM2HWRlD4VBubCzbK6ni90+jwJsVNU4Buwh24at3iO6JNV6GIqkICirKX6nCef8+0JzyDVMzTtBRj4/KKxMRPNKeCWoc4avjwHWMnrsfmhnMEq7IP3bMnh+B2ahiNiCrFAGR0vXMM5TDhJOp33zWhyYE6hIW3G1GkVTDboVmQQ1IknlUbaYYjGrhNc+PbWXjS2Mfncxe8Ue+feIJFfTUIlZsGLcsJdFgBwUHwumFPM0CeFJBalkL9B7J4MA7Y7wPio6k4bg9uDDV2Hw8XcZ6h3uTX3QT0ohK01rbY9K06stw==
X-Forefront-Antispam-Report:
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(61400799012)(48200799006)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(966005)(1076003)(26005)(2616005)(336012)(6266002)(498600001)(6666004)(47076005)(35950700001)(83380400001)(73392003)(82202003)(42882007)(5660300002)(2906002)(7416002)(41300700001)(70206006)(42186006)(316002)(76482006)(54906003)(8936002)(110136005)(8676002)(4326008)(70586007)(82740400003)(55446002)(36756003)(356005)(81166007)(83170400001)(40460700003)(40480700001)(45356006)(35450700002);DIR:OUT;SFP:1022;
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 13:54:29.0814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d72320-b249-4be3-aee6-08dc1051556b
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK2PEPF00006FB5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7968

A nuvoton,*-clk-rst node is present in nuvoton-common-npcm7xx.dtsi and
will be added to nuvoton-common-npcm8xx.dtsi. It is necessary for the
NPCM7xx and NPCM8xx clock and reset drivers, and may later be used to
retrieve SoC model and version information.

This patch adds a binding to describe this node.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../soc/nuvoton/nuvoton,npcm-clk-rst.yaml     | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-clk-rst.yaml

diff --git a/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-clk-rst.yaml b/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-clk-rst.yaml
new file mode 100644
index 000000000000..dfec64a8eb26
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/nuvoton/nuvoton,npcm-clk-rst.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/nuvoton/nuvoton,npcm-clk-rst.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clock and reset registers block in Nuvoton SoCs
+
+maintainers:
+  - Tomer Maimon <tmaimon77@gmail.com>
+
+description:
+  The clock and reset registers are a registers block in Nuvoton SoCs that 
+  handle both reset and clock functionality.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - nuvoton,npcm750-clk-rst
+          - nuvoton,npcm845-clk-rst
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties:
+  type: object
+
+examples:
+  - |
+    clk_rst: syscon@801000 {
+      compatible = "nuvoton,npcm750-clk-rst", "syscon", "simple-mfd";
+      reg = <0x801000 0x6C>;
+    };
-- 
2.34.1


