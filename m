Return-Path: <linux-kernel+bounces-24903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1FD82C478
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F7A284FFF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F7217C95;
	Fri, 12 Jan 2024 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="KbRkycci"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1651AABE;
	Fri, 12 Jan 2024 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hvWvrYU63e+RMvmJo6Ie6S550yYvyt4QTNIah9lcAtfmia4TufrGE99LwVUadWPlrFkl/yh0itmHvMaEN4BqgzW5thfo9/PDsDwRk5S+8v3XjozHLMhjsCNzCWBERKR8QyttM7C65vbNN5Hx6G3uxjDHj7RCs69sRSqQ1Ue1sd29tzjaPHH7/dE2SvZAg9kaNFzP9AGaSsfIi/uDNgR+VFCJpuhkAv5RAniYeyxk3ImnGyTyDKnlSkrCVWyWUgR34jB6X0g+N/iUQAyjGTy34Z5MkradOhIAzQT5lyTBKYBTMTO1rUJUHfS0XF8/UjPTs+SUtnGOlGsPEeTS2sHF3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDSNKZILwea1n/vHFeVlvORmTOvg96tgvZALVxEMZmc=;
 b=ZgAc97nruR+n8Cv1dqUjkwLBxB5NXpfaVyNy02jRp/yPHXP5i2zENNxPcc1nS8q7LYE+wVTOmFVxECY7OhIbmqxKVPUVWSyWSBdqs29tOewDHXrhMWFF//HzwtY982HzS/Hx0q0G4PC4/COEDioc34FWfrFpxFlPGo9m+SsOle+YGea1gdKhJaSTfD1E0FDYnwJDwzACKR58EOdVdPlDWs7mUwx1lH4P3DccSPoHtqDqshmSPMMLHijoWQfgQykRxFKSgn3xsV7k7NavM1wAHDMZvxt+X5rUTQOPB/u67Kppjc3YVQlbA1iMaW5RXB93BJG6iBVrAF2aXPISjhmSWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDSNKZILwea1n/vHFeVlvORmTOvg96tgvZALVxEMZmc=;
 b=KbRkycciIxPpbIq0ElGb2n4A2nkoFnGQievUcs+L4qAXeO3e2zlLBcV2VgukWq8sx3W9rQY2+EyzPJ7fZD+jbyU2uHAoZzRinRTO2er3Msg9NSAv3CrVQOaJK75ydz51/1tKIoPDB2j/3NCc8qiwSC93egmkmUPPxGILGh/XDks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AS8PR04MB7846.eurprd04.prod.outlook.com (2603:10a6:20b:2a0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 17:12:41 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%7]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 17:12:41 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Fri, 12 Jan 2024 18:12:27 +0100
Subject: [PATCH v2 2/5] dt-bindings: rtc: abx80x: convert to yaml
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240112-add-am64-som-v2-2-1385246c428c@solid-run.com>
References: <20240112-add-am64-som-v2-0-1385246c428c@solid-run.com>
In-Reply-To: <20240112-add-am64-som-v2-0-1385246c428c@solid-run.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::8) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AS8PR04MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fea5869-2e40-4e32-9aa9-08dc1391af15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RP3Ww9Pi9mcLmJfczpyLD7XSCvrtrZTdfrjNzyr/7SLwfyKu540NTaUboZhfV0jFVXSFshW48/o1fJ+u/OUy/qAhiums1Ajh+Mle2h4A+OnehZI9/rg5kDCmeuiPvi3dvKsUYtMLuABnGhEiS61q95R3cYHHOS/Y8j4mFxRCGc99hNec5SPYmFnENOAwwbPzMR3Deu+cdeln34tcmzW7gtepNd1ixiu04Ha/8X6srSKThbnO7YRwcWbApZKPtkdHpJAJzAU3vzQoiqyba/96CsEbrfc2rsLrlkOiLabjAzh/9E/rR0RSeXJbaubSMs5qa7rOC2Dy1C639s4TMVM+Deq+yGdZDeF88rQ8fvCn9S45lXRhBtmYW5ULeoErLUqpCPTtX2H9v3llrpqHBniNI3zyuo2BPIbt9mNcuHCXyV8cIXntYwivXg2+ls2w9WJ6UN3kXTfDoekW5J+rrWqYm9f594+g7U8Xxhv1rjVvjHv5F2KvA+3A69k5QAHeo/QzjRPK8eEldH5QLR2CGqFjg+B92EJdUE+DhRmhvknlVKs+tkJ80L8CPuoPhK92onNIEtqasV5LL9vHM4fKX5ONqRwVW1VQqzuyfeQ4VP/GKAc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39840400004)(366004)(376002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(4326008)(36756003)(2616005)(26005)(5660300002)(6512007)(8936002)(8676002)(41300700001)(478600001)(2906002)(7416002)(86362001)(6666004)(38100700002)(966005)(6506007)(6486002)(66476007)(316002)(66556008)(54906003)(66946007)(110136005)(83380400001)(38350700005)(107886003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THdzdDJJWTZhekV5amowNnZWcGxzZEk4S3d4ZkJNaVhFUVhHaHNGRy9RNUhK?=
 =?utf-8?B?TDM4SXZBUFllaHZRcFZDSGlkWlp5YThkMitYMmlnd2R0OVlsaEYxeDFWWjY0?=
 =?utf-8?B?U0VsK2p2UmtXVHpFS2NjMmJEWitxanJEaEhkbnE5QUpFQXo4bytqY0QrbjhS?=
 =?utf-8?B?dURMdzVCN2h5WGsvMHNuSXJuRW1YdlErS2NCQTUzWUltQ1dkN1JVNHZpUkZk?=
 =?utf-8?B?YUZGdE1sNTVhaERNVkZhd0VZNlZERXpxUTYxQlM1SUNUZDNsQlBNK1R0QitD?=
 =?utf-8?B?L0NWUkxNRlZ2YU5DUWRGWWFDc3NLcHNZclFzbERGTmNEallFcXFYU1pLUG1U?=
 =?utf-8?B?REtRamg4Mm9xSTZaQTBPK0VvbE5PYUs2dHoxWUNKVjJ6azc4cm1WMngrMTBx?=
 =?utf-8?B?UHl6Vm9qK2E3TWVUYlAvdUZJcEI0YnFuVzNJTWVuTW5OY0x6bEQ5ZlduOUU5?=
 =?utf-8?B?NmJ5Q0Qwb1k4djRLNDZrN2dQMjFidlFCTzlXQytuZzdQamswQlVHTk5Bc05J?=
 =?utf-8?B?WVViRDlWRWh2Q0EzTUlhRFZnaVJxeVJORjJRNUMvS3d2NUdKaE5zNk9rTnBU?=
 =?utf-8?B?U29pcUV5VUNuYUFoUTB2Q0dlM2dlYmVGMWtPSU5yTWp6dUQwMzlna3pOQTRB?=
 =?utf-8?B?TUs0MFVKTCt0RTVxOUFDTDRiQVpkcUNaaFF6NjM1WklxdWJCaG9QY0t1MGxo?=
 =?utf-8?B?SUJ6RENnZFFHSmw2ME10TWdxM1RkWWprdEhZSVN6Yy9FaVVISUd0SDRRY0R0?=
 =?utf-8?B?RlF6N3JqMlp5MnQyWWhRUjc5THpXUFRLbENlaTI5L3lVc2pPYjMvNVJFblZL?=
 =?utf-8?B?NWNabDgvT0lySFdRcFF0eVRJL0tDVklWclRDejBVNVM5SHF5UVdNZllUeURq?=
 =?utf-8?B?ZDI1TDJyUFZGUVF6TGtVTGV3WlZOR2Z1clc4RG1YRUJ0ZWVOTy9nMFBIOC9Y?=
 =?utf-8?B?MVBVMWJYK2hrVHlNT2pNUkRJci9rZlV5NFdzdnVkbG1PNmhqRUo1VnpIcis4?=
 =?utf-8?B?MWVJWHBKWFNReXR1M0FabzZrcUpzeGNWRXRWczRsWmhwNXFOWUNkMTJ1QVdB?=
 =?utf-8?B?ckxYeFVQU3lNV1AyNUVZc0FvbVExQVFyWm5WRU8vYmtWQnEwMmRPcUhnS1BY?=
 =?utf-8?B?K0hpMDQ0dkV2a3ZPMHoyTU44Q2VSK2hLM2NiSzNHUDd6U2x5VFZ0cm40ZWVh?=
 =?utf-8?B?ZHY3OWpJV2FUSld2SGVqblQ4WUZrTWJtV3lBRFJ2S2Y1NGNSRUlyQlM1WUFD?=
 =?utf-8?B?dDRLSHhib3ErY09nV0RZT3IwM0NIS1BKNHM0NUFPZHYzdk81RFBOSVk3ZTlQ?=
 =?utf-8?B?UU03SGRhSTd2RWM5aStWaVdZdEMxNjUwUHZQZktIN2tSbVlvZlJsWjVYRHlx?=
 =?utf-8?B?ZWZPbW1tZDZFbEVud1c3SlBXeEVzU0JZMG5QZUZwOVA4VkRuQ2crOS9mMXll?=
 =?utf-8?B?M0VobHBiSVdoRUgzTWpSMDdUSVVNQWtDNXQyR0tQQ0pqRXBVKzBaVlNhZDNr?=
 =?utf-8?B?ZTJyZ2tqeUVCRlBoYzdiTUx3UldpbkxuRFd2T3Z6d3dzVE0vVExGYjVlM2Nq?=
 =?utf-8?B?VDd5dGM1WTN6RW45K2x1Y2NadmNjam90VlB3U2Y5Q1VTWC9QUGl5cnBFN3l0?=
 =?utf-8?B?c2JSeXVabmhmNnppOG4yTDJ4WlZGMzJTVHdLNmVSN1MxUDhxMHFnU1N6R3pB?=
 =?utf-8?B?V0pjcE5sQWFqbVFHa0xvNUluaUtqZ2UrUHZUUlNNNE9nRnJXMUhzYnVUTWNz?=
 =?utf-8?B?Y3ErS2NsYzdhd2xDSHoyS1RiaXo2YzBMWFZwRndjaFZORmpLbE56bVRORnJl?=
 =?utf-8?B?aWR6cDVEODQ1YWF3cXRiTDIyWU5IS2FSeEtjekwvdE1xY2JkZVJuakJORXBm?=
 =?utf-8?B?cUlRZTA5VHdEZm1LK0dudGlEbUQ0NkVsNmI4V3pzV3ozUlUvSVZncXlIVmpP?=
 =?utf-8?B?U0JSazllWFNtTEpLVXVRSHBQUkJ1MVFJcEl0VGJ5VGtmZnpFUUVnNE4rK2tm?=
 =?utf-8?B?Y0VGbTdnRHBoV3BZR0xFV3BKOGhucUJ0amRmbnNTMmR0a2FMbzFPY2VBSDN4?=
 =?utf-8?B?U2l0eG1ENFRleFkvYjQwTWdPbE5LMWhpbVlaV2pLeXpCMnJkNnRXYVRqTEhu?=
 =?utf-8?Q?is6ppnjCYmnuS0F89KLZvHHHw?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fea5869-2e40-4e32-9aa9-08dc1391af15
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 17:12:40.9766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1JT7IYjrIE2e02obtTM+Pfp3EdXE/2vGpR3CUBKG3XT5HVutSsGJ+QRhk/iTJe1KB3EgYmLcWe+0ZMIQ3Z0ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7846

Convert the abracon abx80x rtc text bindings to dt-schema format.

Additionally added "interrupts" property which was missing from text
format, because abx80x and driver support them.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 .../devicetree/bindings/rtc/abracon,abx80x.txt     | 31 ------------
 .../devicetree/bindings/rtc/abracon,abx80x.yaml    | 56 ++++++++++++++++++++++
 2 files changed, 56 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt b/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
deleted file mode 100644
index 2405e35a1bc0..000000000000
--- a/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-Abracon ABX80X I2C ultra low power RTC/Alarm chip
-
-The Abracon ABX80X family consist of the ab0801, ab0803, ab0804, ab0805, ab1801,
-ab1803, ab1804 and ab1805. The ab0805 is the superset of ab080x and the ab1805
-is the superset of ab180x.
-
-Required properties:
-
- - "compatible": should one of:
-        "abracon,abx80x"
-        "abracon,ab0801"
-        "abracon,ab0803"
-        "abracon,ab0804"
-        "abracon,ab0805"
-        "abracon,ab1801"
-        "abracon,ab1803"
-        "abracon,ab1804"
-        "abracon,ab1805"
-        "microcrystal,rv1805"
-	Using "abracon,abx80x" will enable chip autodetection.
- - "reg": I2C bus address of the device
-
-Optional properties:
-
-The abx804 and abx805 have a trickle charger that is able to charge the
-connected battery or supercap. Both the following properties have to be defined
-and valid to enable charging:
-
- - "abracon,tc-diode": should be "standard" (0.6V) or "schottky" (0.3V)
- - "abracon,tc-resistor": should be <0>, <3>, <6> or <11>. 0 disables the output
-                          resistor, the other values are in kOhm.
diff --git a/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml b/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
new file mode 100644
index 000000000000..c80d4a46a044
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/abracon,abx80x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Abracon ABX80X I2C ultra low power RTC/Alarm chip
+
+maintainers: []
+
+allOf:
+  - $ref: rtc.yaml#
+
+properties:
+  compatible:
+    anyOf:
+      - description: auto-detection from id register
+        const: abracon,abx80x
+      - const: abracon,,ab0801
+      - const: abracon,,ab0803
+      - const: abracon,,ab0804
+      - const: abracon,,ab0805
+      - const: abracon,,ab1801
+      - const: abracon,,ab1803
+      - const: abracon,,ab1804
+      - const: abracon,,ab1805
+      - const: microcrystal,rv1805
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  abracon,tc-diode:
+    description:
+      Trickle-charge diode type.
+      Required to enable charging backup battery.
+    anyOf:
+      - description: standard diode with 0.6V drop
+        const: standard
+      - description: schottky diode with 0.3V drop
+        const: schottky
+
+  abracon,tc-resistor:
+    description:
+      Trickle-charge resistor value in kOhm.
+      Required to enable charging backup battery.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 3, 6, 11]
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false

-- 
2.35.3


