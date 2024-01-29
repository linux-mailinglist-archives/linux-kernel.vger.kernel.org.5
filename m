Return-Path: <linux-kernel+bounces-42125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 205ED83FCB4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A034F2837FE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82494101E6;
	Mon, 29 Jan 2024 03:27:43 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2046.outbound.protection.partner.outlook.cn [139.219.17.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6414FC02;
	Mon, 29 Jan 2024 03:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706498862; cv=fail; b=MnDyBgrVOVst2CClyAlidk5qB3qdm8besFMFi/dpUBrcyy0wkqaQMFWiN8i72ZhdcrwvCU3ynC71Cs23vudQw0+nzihGiXmmvKdFsApPNBSzbULHSkgz8gcKZWwJv5ywe82YLJ1PLmpetGHplc/fwJ5oW/3ZPJxJ59AudLbVBJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706498862; c=relaxed/simple;
	bh=+pCWZj/JNlJ9+NLZmDbDxHzVf0oDxr46qJldhdroxIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mzXkbaL4EkspnPaZLdzCnOYM9AlNTtkmRvm/mBVrXzbCbUubh/c9BY7LE4NROPQt8jQ7LmJOtYEueMjcpZRIalDBNkJTuQRqcfPZUOGKTXqDC9Xz59862d7C5+/Qq5WA46gctSzXQK6R0IoJ8HRp2MedAYSycVG8Vh1dZn5Ggw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLnNE2rmeUemB1m1BbNth7Tbzz9mL/1/QpFJBEsMjJ2U3fGyZhUvt9yiVsdzin4hMZm0RFtiysvF4C2QGMN/y80k6PzRl+aefD81thMEN+P3UVj4gY3EjhJBvZZ0QVtcpuWmrEKyuLIelr9ia9IoYdwtr4lkAHOfuVD/aWV9/rSzFjOVTNcsyrMwh9kNW1paRhYXy12tgRFbVrEDIhVPckR/K+FvZNvO8nQNd0XgDHvk7MB56ypqNPdRiVxvwmyTlnPIhYaOoPFDtm7D6D3AQz14Hyv1TZtQaeMr1EDcE5sDp3VRfYTxuZjwRjifsG/JOKehWlOpiMxwnrSTkFa23A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXJxtkBzFPxuabFFn+yIOFvh7e+QAnvI0bCtUSLtm04=;
 b=X3DGlP+k+s4yuixr6f9YKGrk6aNi3Wm8MASWT9s0J7ns0ggiGKtbjPEgbdOejk3vhtMq+7TYx8wQ2/SAu5lsEgFA7sNZv2a2gLTfitxCD6TZH7Zi6EMzlv0041lKEMhW25KxNjsmm6EydybpZ+cCfOOGTMYltDKBqPC5ReldgpQOGP60f7PQNJNwxOO6FZ7I/sBln/oA6YGo5t77bq4cMXVjPvQ+A23q5CWjTOtEJqDvfrlnh/BtgaSMSZmgCMkdqh/1yF1Amv894r/6MK+WdXsG195IJJPTfLDIJe5wd6Hd8ARNOz9P7OkH7GljEEeSoje0kJs6ExjqRh8pAOk/sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) by ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 03:12:52 +0000
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::a5c6:9ab0:d20f:cb78]) by
 ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn ([fe80::a5c6:9ab0:d20f:cb78%6])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 03:12:52 +0000
From: William Qiu <william.qiu@starfivetech.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-can@vger.kernel.org
Cc: Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	William Qiu <william.qiu@starfivetech.com>
Subject: [PATCH v1 2/4] dt-bindings: can: Add bindings for CAST CAN Controller
Date: Mon, 29 Jan 2024 11:12:37 +0800
Message-Id: <20240129031239.17037-3-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129031239.17037-1-william.qiu@starfivetech.com>
References: <20240129031239.17037-1-william.qiu@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0011.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::23) To ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1253:EE_
X-MS-Office365-Filtering-Correlation-Id: c453ed54-5ee4-4886-895a-08dc20782e26
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9g7CygIeZv65EggUsJ9tpuhxnijPQIe4JCUvlkdBFyDaQGg2BiA0AQcLWF1ZGXAZ3Bew2wEweCfPCeV4XH75LGV/fbAYBuqnE4wA4rrI5Q23bCtzs89AcYia2TlptVInkCGX52Mnq/F6bBpXLC+4vpx8bzDDFXvjO3FO7LaHJmie/YdkTel/UoGQzxwdWgLU6uO6y4q6DPPP4A6wlbVAzxK/Fz5CA2hfivhX49BLUNv4SBLf5X+SfbfgYwB8Aw+nkJYb5rjSAjTLgOUOib98Ap4ptXJTTM3WHjgt1IWBCoAKOfQt6uPDRfpMzbVLdsHVY4DAICYOMS5HqO2ptf4NjXAkyLdOFW4ap80VON9J+aq5GYjILH5Ms9vC7wMRui0EqR+Z0rrLjXd12x2umIMwpmWE/4D6eVD/3v1YbdVS9g4CeWoe7bZaS2OKiJ38BLSPpDBp8tbzEZK8g/0aq3jLy0IUgzIw00T5jOCBHWvRJ/YLgAlxLYm9cqjJ8U6c1cndJue3GMIydhwS3jqLnKjoZUra38kXDbJgp/ijjPFVhrIrY4OfLAzXouj3LSw8ebh5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(39830400003)(346002)(366004)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(41320700001)(4326008)(8936002)(8676002)(7416002)(5660300002)(44832011)(86362001)(966005)(54906003)(66946007)(66556008)(66476007)(38350700005)(2906002)(40180700001)(41300700001)(36756003)(38100700002)(52116002)(508600001)(6666004)(2616005)(83380400001)(1076003)(40160700002)(107886003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VTIQQUI99RZzeRkxhVoq0t3F35PHGcP+RXBxwJweB9s5OfFUsejn2PUmxKlo?=
 =?us-ascii?Q?3IResT8ZgqXvJJRq/KG7DXI5kKzlHL1YAZML2TCgWCPTjXch0cpbqWEci9fG?=
 =?us-ascii?Q?BkIEvckXvtZ7B5MyT9lmTKqQpIw+jdQmjiJYMARroLLZdUrmtVuiENIvcIv/?=
 =?us-ascii?Q?hee2Iheeoq4RjEsIwplIXLyh31dkAMRrcHOcfcfYKOdstHVd3nUvm4TyasR5?=
 =?us-ascii?Q?ZwLyymcYKGPFD3sb4u5vTQxWWF6wHEbobEi4qSsESKJlqylyNlOZXUFtWB7t?=
 =?us-ascii?Q?94U6o86pAtczvt92ztY7aNrc1MNEX6JwCCkuN4NP5OcFj4DGoAanl4YfxvZK?=
 =?us-ascii?Q?vJfppaU6OFqX68juOsnigG0F689aDKJN6GYmNDr6R4BxgHGYY2LbAaH3h0G7?=
 =?us-ascii?Q?eN7VBEH5XvuwxwAW1qq8PDNwU/UpnqetyLhAxWhXGi9sZEzbavd2nB726BAr?=
 =?us-ascii?Q?J9a9k/Z3kkecWzy7sZkS11NSyYdQz6zVS7ZoWzszDXAgAY8HtXQVzUTdMWHc?=
 =?us-ascii?Q?tocIjnLp3nz0OGJmr+27erXBsOsustjGoY8dOjGi8af00t0qHR3OWt1rKdlL?=
 =?us-ascii?Q?LSRHIhT4QkIFrAHJgxHVv7J5PnuhmNfzGKLfTThmbzSjNU4LFt0f1MS9fJUQ?=
 =?us-ascii?Q?to4uKpCe+m5NmJmwu+oiZggMsEXrl58X8eJIBpWda7jeHF9qfIy+b0Gh9otc?=
 =?us-ascii?Q?ZS9TCWty1h+PUu3tOj19ZMY0l0iCe5VYGPDDYtlOUdvMIxi7E6hRGaED2Ah5?=
 =?us-ascii?Q?pZ/XYN0VCJrn9EqrercbQe9HAMDkn1bvgvWVlh3DAmZeuU40wTqvjz9soX6b?=
 =?us-ascii?Q?BAv95nC2fpr42FWXzJyG/Uiivb901BWoCWeZwq8fK1RbILoa6o7U9HXAS2MJ?=
 =?us-ascii?Q?buzoi+xgGRRFrFf8GMlqQnGSiqhA+1NBtC420lH2/elVmjeKGE1F6HBIHOA6?=
 =?us-ascii?Q?GqUT3nsMk7kZ01U2avldhClbZvYnYvnMl8Xkb5xEI3ai/c2ICVUztHcLeWmO?=
 =?us-ascii?Q?aZPVHHnEpgyhu2VIjeDiNg/8qWMHGRHdTfFYIP58u4yV2/WHQEl4ULHr3irv?=
 =?us-ascii?Q?jA93uPIDLkmOudNDvCiZR6vJii7t7QvhMt4WvTl6u/fTGoa4MieV9EgTRUO6?=
 =?us-ascii?Q?RnsITcmFKLx2VAliM7d0GERn7ywUcrmbDIncjPIRaN/QAifPy+6Xzl4KGtce?=
 =?us-ascii?Q?WkCGX9EXv8GJAXGk276ZthMA/gX3CoR94l2Q+bsYUb5K9zg/OPHzW/uSRuQi?=
 =?us-ascii?Q?bWUzZcPxQxeIdSAu9m7Zmj+YgvmaeoG4FseubXV4ieetKw5SMVMc+QFgkeBp?=
 =?us-ascii?Q?RwOWGNmTwto3jpjoM2S8LvQW/1tAwOanLJbxpqPPju2SXvEScK5ObgQiEhN/?=
 =?us-ascii?Q?/imF4shFPmVq4SLICJ2vL+5J2nPKUNYyFC3Hc37gUBZSPRvAzNINDk93V4tZ?=
 =?us-ascii?Q?a46hEn5TKTXxSS8sMXyPkILzJWEw6xTPsAJaPunfmvH/XLY38SGd2aRgYNAM?=
 =?us-ascii?Q?Brm6YUsKtOdib6FiM+HopMBzwPdhE/GmNRA9UgHLV+MW83RHcTYgRp72XkHF?=
 =?us-ascii?Q?RXjFPVOSevqDW9Jo1Gj6pbxyxkN+yc7jjjUAzLQ5mGGL+AjR2g0dxI+JN+5s?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c453ed54-5ee4-4886-895a-08dc20782e26
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 03:12:52.3258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfMV201NMjxlXvLFvf2q3UQAjq+jzZ2V48IU7nFT4g3BHmY5v2QsuPIib2iuiIbQ+o8ACSETKcxSI0M+OB3UOnImZg4+MNMbctnfFqXoudo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1253

Add bindings for CAST CAN Controller

Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 .../devicetree/bindings/net/can/cast,can.yaml | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/cast,can.yaml

diff --git a/Documentation/devicetree/bindings/net/can/cast,can.yaml b/Documentation/devicetree/bindings/net/can/cast,can.yaml
new file mode 100644
index 000000000000..ea52132d9b1c
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/cast,can.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/cast,can.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CAST CAN controller
+
+maintainers:
+  - William Qiu <william.qiu@starfivetech.com>
+
+allOf:
+  - $ref: can-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: starfive,can
+    then:
+      required:
+        - starfive,syscon
+
+properties:
+  compatible:
+    enum:
+      - cast,can
+      - cast,canfd
+      - starfive,can
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 3
+
+  clock-names:
+    items:
+      - const: apb_clk
+      - const: timer_clk
+      - const: can_clk
+
+  resets:
+    minItems: 3
+
+  reset-names:
+    items:
+      - const: rst_apb
+      - const: rst_core
+      - const: rst_timer
+
+  starfive,syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to System Register Controller syscon node
+          - description: offset of SYS_SYSCON_NE__SAIF__SYSCFG register for CAN controller
+          - description: shift of SYS_SYSCON_NE__SAIF__SYSCFG register for CAN controller
+          - description: mask of SYS_SYSCON_NE__SAIF__SYSCFG register for CAN controller
+    description:
+      Should be four parameters, the phandle to System Register Controller
+      syscon node and the offset/shift/mask of SYS_SYSCON_NE__SAIF__SYSCFG register
+      for CAN controller.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+  - |
+    can@130d0000{
+        compatible = "starfive,can";
+        reg = <0x130d0000 0x1000>;
+        interrupts = <112>;
+        clocks = <&syscrg 115>,
+                 <&syscrg 116>,
+                 <&syscrg 117>;
+        clock-names = "apb_clk", "timer_clk", "can_clk";
+        resets = <&syscrg 111>,
+                 <&syscrg 112>,
+                 <&syscrg 113>;
+        reset-names = "rst_apb", "rst_core", "rst_timer";
+        starfive,syscon = <&sys_syscon 0x10 0x3 0x8>;
+    };
+
+...
-- 
2.34.1


