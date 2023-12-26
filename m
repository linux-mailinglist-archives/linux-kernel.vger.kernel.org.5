Return-Path: <linux-kernel+bounces-11607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F318F81E8DF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82B822839EE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 18:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FFA524AE;
	Tue, 26 Dec 2023 18:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="WlZHB7vP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C808F51C27;
	Tue, 26 Dec 2023 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bekqBRIJlOp0wXqUUM+IkuuxxJQJWUvJfzt+Knrna2mHQJgIlxEYoc/kaZzoP+TCYUv56inyTKf6JgHV2nmIvHk6HPB/r19Wi4tkt6feBOfspLJ1QPlDT+bOsKLv89BB5jVGzFex1tFigYpc2LHfwBYex8nqnUKRUDpPnQXoWjSgeV8xkKpY4lCJdYgdilvgvXIGD8CgoBPMLLbYoRtIqUuo2CJueyP90vpu0cxUf1vKfuosdF1EkM+KF3OItTyjfG4N3/SN8FfSKBHOvCJuwn1AdNOiSuu+OXqzIQ0nW7PaQ98Dxoi1lG94AiGveYLZVtnQnkpGU8msYvFk330p7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xr6Vk83GmnL+VkJ2sRAU6nYvmN34VDs9J2G1/cdoA74=;
 b=A1t4L+pruR6EMhFWHxFAaLupkmt1RVwcacGZE6D+pZu1Y62jZoiYT9buFtzHC0yaxLa67073tSr46+aD/Zpbb13jANSwUUX+5pgW3HxUNCmy76WW5VtrBK91nv7Ln3fhrJR5yGdbbWS2lkGSqMAX0dWU8Md2icrrDGdoJP9bA4vIwdYbEc0O0YUnrOsHk49jLsBNm+zWnLOYRv/PLVFpnQqoROf6/R18ot1hlDebd+32QsROm91aJ6vmeeDdIQ7rKO/r1ymO+GAnocNuAL60CTLsl/yLcAGRKawfPBbS6eOLmFoYdLuzzFGMM6px7zOwJIznfAsowJSwRP/03olx6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xr6Vk83GmnL+VkJ2sRAU6nYvmN34VDs9J2G1/cdoA74=;
 b=WlZHB7vPI8+w1MoY4IcsJ6+/gONwDzTNrAP7Tcyn2t2gQV57oY0hw/3dn8ct1fg598OHozenpLzRwsaGRjOms04tgp0YjVjjQ1XtIFqMrDbaAl98l0ybr6TxnDiYubBQVV/DfJmeBcL/sgr82UHTP+ZzXLA82VVYw9Ej2cjVtKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB9PR04MB9868.eurprd04.prod.outlook.com (2603:10a6:10:4c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 18:11:52 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73%6]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 18:11:52 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Tue, 26 Dec 2023 19:11:32 +0100
Subject: [PATCH v3 1/8] dt-bindings: marvell: a38x: convert the soc
 compatibles description to yaml
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231226-support-clearfog-gtr-l8-sfp-v3-1-fd1ac2d6bf2e@solid-run.com>
References: <20231226-support-clearfog-gtr-l8-sfp-v3-0-fd1ac2d6bf2e@solid-run.com>
In-Reply-To: <20231226-support-clearfog-gtr-l8-sfp-v3-0-fd1ac2d6bf2e@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::21) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DB9PR04MB9868:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d16dbc3-cc47-496d-16d2-08dc063e227e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lpLZrrEJWmu+109troNnY2elx+8m22MlhFEFKe9SHkIH6z3HpxoK46u7fF9SQp5e78befoo4t86jfx4FjqZK6sa1BTxDRFhAjlkWtB0gGwcVVozzLqG99Pi89LSCA6pfX5dRCEKcJSqGrN86fadtmt9QM+Dkz7YDkke60oSnLyZQ5fTsXEu+OQjMEeyReLu1x9OPGptRJdUyWCTtxJJfUgwWQYqcYA4m3AnKH8ESnRNvDRSrRT9qZpa4XBFnHuCJujjzqi1NKk18ODnUuwVKc/WVOxJukpkTf6kz8dtZFE4keExgCxicSo/nDW5HB896HuM7MEM/jDJHmHLEb0nQXz3kEd2JdzvlCA+Q87bCn3gg07BMlXcZzUM8YA8JVB9lieIkvrMQcpD+3iirWErZ7haqekLbFvKyCA95bBxuii+cGnqyJL/od6D9DVFh1jOQM4ody4Bms2cAnRScnj/Bsd2UlbKVRADxToz1A9faqaq7pGW4SBtJk71q5DK3btMI3h7OP9f+3QkomgbxaMqYd6bLTH3V0S5F5/XcRn0lXYdGUYDPJfaxF9RWAYW/v7JDNhjKidpkMe8BU6F3qWB6bgniENZrh/LKQruTDJxV4ds=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39840400004)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(26005)(6512007)(2616005)(4326008)(8676002)(110136005)(66946007)(66476007)(66556008)(316002)(83380400001)(52116002)(6506007)(107886003)(6666004)(38100700002)(86362001)(8936002)(478600001)(966005)(6486002)(5660300002)(2906002)(36756003)(41300700001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZG1HckpCTnZ6ZFJ1YzhTMzlocGYvN0lhTkY4RmIwVWxuVVpnMC83cDFia0VD?=
 =?utf-8?B?TnJIeDhRNUFFNGpBZE1MVFZyNjJ2WDVDRnhZbWtDZVVSTXgzalBobWU0L0NU?=
 =?utf-8?B?Um9nQTd0aDBoUFJ5L0dlRUEzTmwxeEh0VXo2YzREeHlwdVQzT1dRVEozWXUz?=
 =?utf-8?B?aEdsK1RtSVljMzdDZy9sOHgwTFloV3NEOWhBNlByL2drR01UOFprWjlFTUgw?=
 =?utf-8?B?aDJzOVRNR01RT095ZFNtMDd2d2o2N3lweG9wY0M3QXA3eHVyQURCeGdTSkxN?=
 =?utf-8?B?ZTJnN0dIcEhiZHAzTG9wa1R1NGYyQjEvajdtV3ZOeWRZRkpqRitxQkhIYWZZ?=
 =?utf-8?B?ZmV0VEVQZEY5K0lXek4rOXpqejFYbFhpLzczM2FzZXFOQWF1RjN5RngxT094?=
 =?utf-8?B?VkZrV1ByYkQrUXluMG5DRWJXRVZXL1lrallKeUtCZTh0dTFCU3JnSzRJc013?=
 =?utf-8?B?YzI2NlhqUGhFKzhyUEJEOWxiaUtyYUZ4VHJUSVdVZVJTbEZGVEVSWldQYm5z?=
 =?utf-8?B?ejNPU2krdkQ0WXNhVFpqNHJVNGhNMHJ1TmNKdVBRZDNOQVM3OWRYWWIxUUhU?=
 =?utf-8?B?SU52azRlZDZRTStvQWlQT0hMU0xUZGRKRFZVeHlrdTFNeGlWMTMzYVhnUzNs?=
 =?utf-8?B?UHdiM2VBRjBGbE1ZSVBncWxxQUp3NU1FM1R0U2VKNjhTQVQ0dUQvOFdha3pF?=
 =?utf-8?B?RHMrMjVZaUdKS0hsTnR2UjZsRDFZMjBna2x2RUtqaFo4bWU2NnpvWmxISERL?=
 =?utf-8?B?YW9LUXdFclhWT2hvTHlZYkQ2K0lRVEh0LzhPd1UxM3JOUHhxMHVPVHk2d0xT?=
 =?utf-8?B?UHZycjFvTkpQdnpBNDQ2NkZ1ZTByOGpyODdxTGc4M0EreW1LeEtDNStKbXh6?=
 =?utf-8?B?U25NaVR5dHlHT3Bsa2srMlpzSVByZGtEZlprc0FjT2hiR25yOUtrZ2prZlRl?=
 =?utf-8?B?c3FMVW9EenpJaE00WlYvSkdmUllxbE5SOCtCSU9DSld6aTl0RlRURFRQQkFq?=
 =?utf-8?B?c09vMUI1NzRUcjk1b25leUZzTjQ2STlhbVhUK2EvYktqQlFEMk5mMXFoQjhq?=
 =?utf-8?B?TmNkanR5Yk9mTklWdVpTaUMrOE9yaTIyOWxXTlFjZERzTm1pN2xyRGxSdlJr?=
 =?utf-8?B?ck8yaDJVdGhzWS9tbWtiaEExR2lwamlkSzRybXJ6R0I3c2p5QXJCWUlxaEF4?=
 =?utf-8?B?UW81UTRJTk10L2o4YXArNWhyeGxkMlJHaHFPeTl4bTZhOWRSNStvWVU1c2di?=
 =?utf-8?B?cXNXSndtRHd1TE0rVWQ3M2p1bXRiRXJTV1c4T1FXd3loNUVRZ3p0c1VlVDhQ?=
 =?utf-8?B?OVlnbGhKd0h0b2JuTXdVVC9LVlRiTi9zSy9BbWRBajR3U0ZETDgzaTFRcFJD?=
 =?utf-8?B?YVd0NVZoM1JsV0hJRkNPNGpnaWZDQ1FuS09hK3FlQ25MZWNKR1NBZXp6dGd2?=
 =?utf-8?B?R0dTOGVFMmJNRlhOTHRtUC9kcXBvKzhTOE0wVWFLZURpZFd5dGJMN0tkaFVJ?=
 =?utf-8?B?YVNUb3NVbnZmTDhnMERIUk42eG5nZW5tU1dETzdhTHoyd0h1ZFFrRG15Njcw?=
 =?utf-8?B?YTRiT0hmdlR5SER1d0UxTVoyZlNyMWZIdUlQbmZxaVBYODlJelA5VXRvN0pZ?=
 =?utf-8?B?Zmp3aFdSaW5PYzdqODZKMU5ZT0JjMXI3T0MzWUNSZ1hyZVZvN2hNNVQyd2Vk?=
 =?utf-8?B?ZGFIT2FFUGN2clk2VVdFcEFTWUI2ekdwbTdFZDZqZVBPN2phL3lVdWRseHFz?=
 =?utf-8?B?N2w1NEc5RWgwdU9nblM0eEY5bkFSbE5lK0RyRGd6N2J5UUhxbjd1aGkxZno5?=
 =?utf-8?B?N0J1Yk1ZK3BCOTNPa1h6TVJ5cGVzY0l4VFJTYytUMnJSUlorNWJ2ZVhLZXhq?=
 =?utf-8?B?a0NhM0h6TnFRQ2cxMW55WGh3Wmh1SkZMUDMxUTBYQmdIQ1FNb2xWNFFicENx?=
 =?utf-8?B?M1VqbmE4RU55VnNLRzd1V252Q09IcElmZEkyNWYyWVd2ekFkVy9xU2swc3ZG?=
 =?utf-8?B?K0VXK2Z1aEhhczJTamN5NEtOVHpTRE1IY3JCcS9ETk92VmxlSlNJMU9TTURP?=
 =?utf-8?B?b0xMRWFETDFSOXVZNnh0cGJEMU5JVkRiT1lIQlA0K09LdTRuRlhmNDlzNTRP?=
 =?utf-8?Q?7AxbijajzBLTfUtW3UqKbnjqe?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d16dbc3-cc47-496d-16d2-08dc063e227e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 18:11:51.7248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MP41SN52GfrVADvkwPTruAKbLWU2dB2rZ/lzOacmvQr5kofGB7y/Q3lAF/eIUGvVGDal/OOsC20vrhhvObSgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9868

Convert the existing txt binding for armada-38x socs to DT schema
format.

Note that the current bindings only document the SoC (armada380,
armada385, armada388). This is undesirable, instead there should be
entries for actual boards.

For now only convert to yaml, the content can be corrected separately.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 .../devicetree/bindings/arm/marvell/armada-38x.txt | 27 ------------------
 .../bindings/arm/marvell/armada-38x.yaml           | 33 ++++++++++++++++++++++
 2 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-38x.txt b/Documentation/devicetree/bindings/arm/marvell/armada-38x.txt
deleted file mode 100644
index 202953f1887e..000000000000
--- a/Documentation/devicetree/bindings/arm/marvell/armada-38x.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-Marvell Armada 38x Platforms Device Tree Bindings
--------------------------------------------------
-
-Boards with a SoC of the Marvell Armada 38x family shall have the
-following property:
-
-Required root node property:
-
- - compatible: must contain "marvell,armada380"
-
-In addition, boards using the Marvell Armada 385 SoC shall have the
-following property before the previous one:
-
-Required root node property:
-
-compatible: must contain "marvell,armada385"
-
-In addition, boards using the Marvell Armada 388 SoC shall have the
-following property before the previous one:
-
-Required root node property:
-
-compatible: must contain "marvell,armada388"
-
-Example:
-
-compatible = "marvell,a385-rd", "marvell,armada385", "marvell,armada380";
diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
new file mode 100644
index 000000000000..5af222e6db18
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/marvell/armada-38x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell Armada 38x Platforms
+
+maintainers:
+  - Gregory CLEMENT <gregory.clement@bootlin.com>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+
+      - description: Armada 380 SoC
+        items:
+          - const: marvell,armada380
+
+      - description: Armada 385 SoC
+        items:
+          - const: marvell,armada385
+          - const: marvell,armada380
+
+      - description: Armada 388 SoC
+        items:
+          - const: marvell,armada388
+          - const: marvell,armada385
+          - const: marvell,armada380
+
+additionalProperties: true

-- 
2.35.3


