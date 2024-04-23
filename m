Return-Path: <linux-kernel+bounces-154823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D77DB8AE186
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDA33B227AC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF51762171;
	Tue, 23 Apr 2024 09:59:21 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2093.outbound.protection.partner.outlook.cn [139.219.17.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E054C60267;
	Tue, 23 Apr 2024 09:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713866361; cv=fail; b=n3Bn9pfzDy2kDzAp3Tkuo1HOJeiaq4TLEHDrsVliW8mP6IEmwUIv6BOmth5AiStnQfjlRNOBgu78nqTMSIhzgsbPnMnE6AGLQP2+ulIWDhB4Mq4Aw/31kSy7NYBhpjhAOGTaXT8uGbU/y8JtsgjpOGsuk/pAAK1bEXSmNb7Z04c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713866361; c=relaxed/simple;
	bh=nqngpfpCav10x3W+Me/cq0dSzEXO4QnU9lgLA9qxQx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NBpVfMqOTGDbirvzwtDiYzpBP5/H3zCv1I1OVlOV/pA5/eBpnoG5BuJbHfU4m19gkYFU7/bcTkEZkPQTHgtdXzYrENysNWfQA3UdhxHONYsWVv0mVnVYFQnHQkbsxc78+68+57EyuB6d3Cm2gVF+FHEeO4GJKNEzbRAnZzGr6+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhV03J1UTYPMP3xlePRqW3hIstVDHmt6lu4fNjMRvdwn/+4qeo9zs2wcZYvP8Bkn994yrxSYlzDAMmiXPTNxj4sqUZEU8OzOoo/pP6wO0N0MbjofyqSa3JugbJRmxcC4wiN9rmNJKE/ZjlKv5il9wrAiSRU9mzBphXixOY4wWu7Osg0SM2N3s5RlGGDPmKlI3vH2nAPMl//B32tBLcAqTy61Qks1aDIWLahnwFFxXGox3e9s+1VhAJHnXhpjTezLotBmjyuSeLTEPRCmDzSewdvdtCa4lbtfP1lWwA8oAtmVblHvFv9Rnis4RcKYqJqAqxiQ3qp5uFmkCUA9slJp6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/x6jMrCWJlzdAaS2oQIcaNdHHQ1iOrWBcqg+v/vLi1E=;
 b=FCuD1Z1Mdb0v01C6zstMZxdnGOPtqBqpLn/hvU3GiMQ8XSe9DfF1ExQqpg2Uz7nAR+hMjpU0Ms1+StOxBM6w9mAW6fclzdqSbkGnIIl83jdXkW759Jc5/yjzCEDIYzq/Sny6qStwZ3bxcmg1OnxV9bamjjuba4SrPRqcB0vD03x/NEduTbglJW0hOXz6roMr8wSt2we0MTrlWuwSMt+cg+6jjsv7tOst0GidxU0LmwjTap4tQnr4fwn++OBFa3hThs6uWKX/Qt29AaucvkU7SObE3+CbQgrz3TD+DmwAxVZUqfgUIACIOXu5WgZ3OPW0NGM94npwgzPFeTuP5RM9uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0633.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 07:26:54 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c%7]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 07:26:54 +0000
From: Joshua Yeong <joshua.yeong@starfivetech.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	conor@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	joshua.yeong@starfivetech.com,
	leyfoon.tan@starfivetech.com,
	jeeheng.sia@starfivetech.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 2/2] dt-bindings: cache: Add docs for StarFive Starlink cache controller
Date: Tue, 23 Apr 2024 15:26:39 +0800
Message-Id: <20240423072639.143450-3-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423072639.143450-1-joshua.yeong@starfivetech.com>
References: <20240423072639.143450-1-joshua.yeong@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0031.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::14) To SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SH0PR01MB0841:EE_|SH0PR01MB0633:EE_
X-MS-Office365-Filtering-Correlation-Id: df4a6bf8-e5ef-48de-6062-08dc6366c008
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BM4LYO2PP/mcV4c1Ai9wxVRdrmGedoesPJ506PtnQFahgO3x8z9U3SgsZgHdmrLPoEA+tVQR6xjgWcB8GjDuTXYyUUlDQjcPUKaaFElb4JLPhL0nEbD4PpTPHqmFLL/o8VBLH13LuMCDZpHiTXe2xbKs0wrRnqxxH+1jBPYFbQGpD72vQpp8aAvryaUmECksI/JqTT3kt2VR2P7IpGtEnQg4RTKA0nlABTP7Or2o+aEZ6VCQuZu3Ow/KMH3oViuMtcrwZeh3J7cyu9xFc0XCmEaxagDfQLE2tr5k/qu9zx2HIVnodHzmO8mc+a7PYq2Aqnu0l1443+IROzwVSCKK5GYYcyowid6fvY1Ct7Xk3SWsTqQ8OcakMMbeytLTdp3CGIHF9Fy+2m4oOPPKlJpyjIqIsHnlaeZe2KqNZhEvyxv0p0RnqFiCq8EoeOUrIMzBarqk5C1gNjkV3VIaE+RQ1K9p/Trs6xXl5ubfcML14ZC7K3IcAsRmZK0B6479SvJsur2RMvtlc6XfwfQe36hiHTKWkOJbRF657w94R7j/HfoolNEfX69zy0Lpr5Y1NP2INdQN/z8SkpozBhjaB4U3hXmLNwS2qGPKNDULke18d0CO29DOIsBKe7CST910ME7gGx4E6lRSoUbftXVyfSENMg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(41320700004)(52116005)(7416005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xZwv47HPbrfaoWPaD1OjlAfsK3F4IYzfT73MXesX5ALdeWboAX9OQ8Jym38d?=
 =?us-ascii?Q?bn+dU+3DaenrZ5y8OAtwiiupu+RKrTDJvqCYxJTGwF3Vc3n/Ij7VRurxsXUj?=
 =?us-ascii?Q?N4g0V6lA3WJ/hIYYepJhcJw7KpI39FRfSBPjefSSk/7Z6BUi0HOZvEWOLZNe?=
 =?us-ascii?Q?6vbbposSTdyHka20dPWzN+AjWVgy9BlU0bYqfoe+1DxXuCuLmsHKuQEYyGXV?=
 =?us-ascii?Q?usflDyUif8GPs2mQiYvjvNqkNQuVKHL3zBs5xCRCSgvsxR/oIQs1N1yXcfxh?=
 =?us-ascii?Q?Y4+Y1qsCjmcwktRpLcIoOmIlWG4oc8MqW5fzU7p5dKgGWOL24wNNatlmyDVA?=
 =?us-ascii?Q?3FLE32UMucGWjK2w8TYluAz8IqeDL9303FxbroZHIX4V40aoArNO+Cc+AoUd?=
 =?us-ascii?Q?HJ/RMkDFBg5sNZFGvJFB64yKeNiJM8nF+jG8DcV7ZM3khBehjNV263/Nttkx?=
 =?us-ascii?Q?vKBZi6iONywpZxqNHnXGjTmuRq4ZB+0eoOQi04IGlNOK5M6KEROEJWiY8bz3?=
 =?us-ascii?Q?waAAxjb8fDn4Ed3HN2phFYkZQDqoKrtEwgAqJAzNrnbZhD675u850sgcc+ih?=
 =?us-ascii?Q?7TSEKnWMxYThYfbN7c9TE4JZBtcjNwGVTJabxmDRoNB8YriTopPNe25gGt0P?=
 =?us-ascii?Q?iaK/hiOE9J9GBa3V3ZmNBqF8Ylu3pGMMw/mv8kDPrXWnGP2OaRfhJjsDriqI?=
 =?us-ascii?Q?ciDskZ6Ja5gTivydVHOVKyNNECFnmdTem6LiuvLVD1yT7u3izYk0wdQd0xUX?=
 =?us-ascii?Q?pZNdHdPFqPkEjcYK237c5Y24kBKSn+J4w1WxFhUldvjUyh+Nm1cXei7NETG3?=
 =?us-ascii?Q?DfylBR2EVnrbHTf3erA2MImQAbtlPuf8cZFTlX2lbZndeDTmep/3xfzRXXHB?=
 =?us-ascii?Q?AKlXGPjLzEZCJ+PglW+ojBu7rk2zEsr+QJWvJSe8ARmQQftzNr03doe5IV5x?=
 =?us-ascii?Q?6dgs03lSWW62597tomiHPkG2hN1WLmisR/yEqddrTbUO05gDLiUr/aCiV6yD?=
 =?us-ascii?Q?fI5guIw8jiRq6D8EwaKcZoEOkYWUo8BBJI4hVAxCbOKFKzOvCyLcefzSSI0W?=
 =?us-ascii?Q?oeP0CD80RlqpW+ekU7LpTPa7uEin2jt8uNwo3PCOalcb+sfPZa9c3eeKR8b7?=
 =?us-ascii?Q?qINg6xsjY2MjVY/untEmu9FTk7fZBlgMCAIXFPeVQ0m4jG13JAPsL9ro4hW0?=
 =?us-ascii?Q?HLzbZjdF02XN6AnivQ9NYsbsx7CoynX0wBZvOc212OwCbTFBshCQlKD3ARU0?=
 =?us-ascii?Q?w91i6Uomj9mwlH5qzogyudLoG2ZyJ6qZe9kT6ZdEnvamnRAltHS8tGHY+pjq?=
 =?us-ascii?Q?RGTpN1+ppGRKya7/ZdjB67n5mdjyk64tPlEBuh83j0ZiU9cIhCtVyjxzC6s7?=
 =?us-ascii?Q?+V2sOtFH/g9hRMTBdmTMko3A0be6nEiRZMR7n7aCk0XIYuftSBKVJctNjVIi?=
 =?us-ascii?Q?+mAPmTqewwVva6lNptHcdSp2zN/iBbC7xUrNhNzfZj5w0byC0asDeIBV5NaS?=
 =?us-ascii?Q?fIsN9syJLZliVmRbMXgCUQqK3FPj1qOZAP0Iovqb4yEHk+73+L+Z2rqEzowP?=
 =?us-ascii?Q?cvgabqh+JnxCzidi3H67WchfLZ9yAsG3tNmBJIZrUSiUyopQ0kdBhDq+PPVe?=
 =?us-ascii?Q?HUFoVei+sAWBGL6qY0V3qOE=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df4a6bf8-e5ef-48de-6062-08dc6366c008
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 07:26:54.0109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVYv8qGt6yrPwC0RBdmlhRe3OUDblN2O0TchSDzjFEUz8Nc9NYyWXUdhO4VjHzglSTPry3vFMyOdZ8VVS8LrJ2mAcWYXw5YzEYUffJTs2sg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0633

Add DT binding documentation used by StarFive's
JH8100 SoC Starlink cache controller.

Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
---
 .../cache/starfive,jh8100-starlink-cache.yaml | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cache/starfive,jh8100-starlink-cache.yaml

diff --git a/Documentation/devicetree/bindings/cache/starfive,jh8100-starlink-cache.yaml b/Documentation/devicetree/bindings/cache/starfive,jh8100-starlink-cache.yaml
new file mode 100644
index 000000000000..a8f39baca6cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/cache/starfive,jh8100-starlink-cache.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cache/starfive,starlink-500-cache.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive StarLink-500 Cache Controller
+
+maintainers:
+  - Joshua Yeong <joshua.yeong@starfivetech.com>
+
+description:
+  StarFive's JH8100 StarLink Cache Controller manages the L3 cache shared
+  between clusters of CPU cores. The cache driver enables RISC-V non-standard
+  cache management as an alternative to instructions in the RISC-V Zicbom
+  extension.
+
+allOf:
+  - $ref: /schemas/cache-controller.yaml#
+
+# We need a select here so we don't match all nodes with 'cache'
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - starfive,jh8100-starlink-cache
+
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: starfive,jh8100-starlink-cache
+      - const: cache
+
+  reg:
+    maxItems: 1
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - cache-block-size
+  - cache-level
+  - cache-sets
+  - cache-size
+  - cache-unified
+
+examples:
+  - |
+      cache-controller@15000000 {
+        compatible = "starfive,jh8100-starlink-cache", "cache";
+        reg = <0x15000000 0x278>;
+        cache-block-size = <64>;
+        cache-level = <3>;
+        cache-sets = <8192>;
+        cache-size = <0x400000>;
+        cache-unified;
+      };
-- 
2.25.1


