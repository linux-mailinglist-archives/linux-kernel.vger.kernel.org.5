Return-Path: <linux-kernel+bounces-156515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE2E8B03AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CF51C23187
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEA315821F;
	Wed, 24 Apr 2024 07:59:32 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2104.outbound.protection.partner.outlook.cn [139.219.146.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61658157468;
	Wed, 24 Apr 2024 07:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945571; cv=fail; b=HsNmgGB2l7+rUqpaaq+z8D21zoqZCaGGgYJFJSwKqNBBKEva01WWZ5yqIQWuET59uiICAIbipCFWyksD4IWvqK+xb31dE2qn/w/8zWOdikJUpMozOMo5zIXYxJOicipmRwHdBYr6uxRxSHCPL/zWjxiCam8p+SxrJxQSC8Q2Ofc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945571; c=relaxed/simple;
	bh=5lKCkXk5FoGziSuhCLz72hHkExSqqRyFzqveEnFN0Go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=du6LLJaN8solAOjMtNmYNXVRcahLIV7YX4xivK6Zb3poDI4ZGlmQgwDD0jPP6uYPrUJFHjUvwWjmUUsqYuxkHd8zjptJFJHjy5OpBtgzmwcQqwHEjX0y6ZkN8o4/QV1h70lE+/yFCvtm0UDk545/5NYYfvJohU7uevcqdl13zLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3Kn6fBCeMWR0n7fV/Uf9LVqTJjPCTO9iKv7AKKVtMV/4IaSEgIZlCmLDNGTO3vJf9gLANbZbolHLa0dgIgdhnI7ugG3jl9s18Y7g2Ezjw88ZjawFsOJUlzd+2RIGv4Nunckv/fl9QmFIMgaKW/w+Zp9j0w0hnzpZAdT+G5b2XK8tc3diYayzPg+lDb5e7p+jdkMtC63Wn0rMeQbfpzI1ybCbCZAggf1tBYt183wjet89nEBla6b7DyxUfTiio3opjfXM+Ic5quOmLI5SQR8HoG1DdZMnyAHTTVQVadkLwdpPOg36ZQJYk8lFp4gcd12kqVpL9nOHJ/Ge2w3+8ElBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UR6JvOax0G0YID2cOXh0FKMYs57WEA34jlTT5teKN64=;
 b=hptbKkh79xxYdSbxmHmj+pONw2lSKcy1FIYQbLvI49eJNldmvTYkHBg8Zpwaz8tqOJ79xKEOqbwN5CbB52BZ1g1VramBMwHoj8yE+xRFvJWB1qXFsYjG7l2d3RP/O2JBIMer7zBrFzxaBxtDqZxsuvLskB+yw8Pp6XENmmgmMmalYliMJtqSIJNwvFdovWhgA6WxkoDZHQGb2CsvjUZS+B/tl0a5khaZLQGTGlAO4zHMJY+wbTn0ymWkR30/ewaI9lwLmBWgSxhhDs2ztN6g5onXaqx3EVlfb5oTnwnhfVpZX8sAPOPVx67KVfpBFlOFz9XXXl+28c54L5S7Fxj5yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14) by SH0PR01MB0460.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33; Wed, 24 Apr
 2024 07:59:25 +0000
Received: from SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c]) by SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 ([fe80::e0a:f88a:cad1:dc1c%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 07:59:25 +0000
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
Subject: [PATCH v3 2/2] dt-bindings: cache: Add docs for StarFive Starlink cache controller
Date: Wed, 24 Apr 2024 15:58:56 +0800
Message-Id: <20240424075856.145850-3-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240424075856.145850-1-joshua.yeong@starfivetech.com>
References: <20240424075856.145850-1-joshua.yeong@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0048.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::15) To SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:20::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SH0PR01MB0841:EE_|SH0PR01MB0460:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6bdcc4-cb93-4e7e-ace3-08dc64347592
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FnStteJ3arhRaxj1TjzUGu6noHj/2TvqzNo2CIBu02oks6vKxBrf8dGc2Rc0nPWjvKU8xkO2OHMUdMn3v+X5wFJlWJLujKS8NXZ83B8qmQ9O6Dcz8k/+oIAdmLjiSorBSH/Mo0qEIgmTckC34hZOpEBGgxF6kK6d05MtsxyHIn4HYlMsXylFr6GBY/rEkJQoCIARzX0Ca6r/pEq5D5NRSiQKg5zYThqEHpPcncKDfRhlWMxjnmfCrJ9ImGKxCu0/9xPeVWQ1FIeYSMyKsE+mLfud1DBeXdBLteXnz9Q28b6AHptlSgPm6J9CFWnQjlzmsMga2dfapA33/4YmhsxmzSDOkDAHUIz0hlZPk0xyeiGZi3p3LdOOO5eCzKbO73z9wvp0R/rGZYNUUTRWqd/qM4WVTlxSwEVb0J10w6B4rwNVML9qI2J8fPn5YB0gVq0sS0BQE3PfFMCOc362vVLaEITME/B0d1g0cBWw514qNaQPPYmMbEjkYkK//hG5KjSfYZoawWid5FlldmPODb/P3atU+99ssSQtYWagBzzN8AUjzYYz2oRvIs6u1CE4cHEXQIV+pHo0Fmq4QOKmTjwJEUHbVc1dEj3uEQ57TpUP46Oav4q/RQ0kAK05g+Awpv+xGn2Fr85GfBUvpqHqleLfvw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(7416005)(41320700004)(1800799015)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aLQMGYg1+y8ljUTGQOVprl6xHvknpNwJCln/pa/QOYofzvpKyc8SffenN+ct?=
 =?us-ascii?Q?KeAAzSTlgaVcLKn/Ogytn+gNL7kMSODFQQWlPYu6csrM/tCwktnXfwCMZU+w?=
 =?us-ascii?Q?GNWZSoBgVz9mLuqj6Mue3vsJ71F1BTVKT+3dRBHXVX4qWSNGjm0kXwDDqJJw?=
 =?us-ascii?Q?guz39lUWh9y9Id/zN3XZvCCcc56QhK3CkwOGkjKaSrj2/kR8oIRRTAIoOizq?=
 =?us-ascii?Q?bB8x+GJZ/9MphIJDWkqdsJGoulHf/bUL/W3n5PdBRhmpmdUAZKFU9xlRvYSx?=
 =?us-ascii?Q?KDrC2Nw5CC79K2RzAXaGWiD9IG/qUCwb3VhavgssMnD/UI44ytHByKIDJWHI?=
 =?us-ascii?Q?W0RKyuE7TzNR22Bn+g8/hRKfwmQOHz1+tz8awtbwAXuEdgRo6Fs7JBIkeo4a?=
 =?us-ascii?Q?hp0xHIJsYBHzROJweKA7GU5Q2jG+7h7m4YxrYwpX26b3tZr1NqCjb7pm80F8?=
 =?us-ascii?Q?siS6QVZc/DhPN5TxU/WlCQShK/PrwwmujV/LK5JhUKokbgNsZxWFji4w8OkA?=
 =?us-ascii?Q?P1Bgz4s0ou/l4z5tmSMCaSBg2Guabf5YGcDJX4iZZOLYdNlfzv+Y/iRrdmdd?=
 =?us-ascii?Q?/ufrCgK5Pjdg/ThEXQCcOnTl/DPj2DcA7o9OKCJO791MbmKW5Fwv713rENZv?=
 =?us-ascii?Q?VNK2IZRrbA+4wy8V8en59M17Qge/RWnx8ibYmjFfCW/SuGDONZeBF71ueTfX?=
 =?us-ascii?Q?Al8TL7pG2OnKhJjJBfxcwyew6qT5uBlOpWTdby7HzYa8vBatOwV8Aod3e6tt?=
 =?us-ascii?Q?8H09KYpzPk+wc5U2vEiNqZ5fc0zxQz2zSM/X3zyPmgYZ1XrEY4iG9szi34iA?=
 =?us-ascii?Q?GpVag+LzCxPFSI3bvm1xPSXnYmfWqA0VkdyGsNjSqja10F1wJZOpQ22DG0FS?=
 =?us-ascii?Q?Bnds2tMgbhNtvQANNr5ix+ug7QuEvQ3aD52vi+3kBI+Gtj3KC3LLHJ6OT4Id?=
 =?us-ascii?Q?ZmpEbq1c2y30Kq+JC9s8BisG/LlZm/FluHBccmZjwm/eLAzbQ8kHihT061BA?=
 =?us-ascii?Q?72YiOS0zGYuaaAOvb3WhO9Xe/Gy0FTx1Doy/xHhZTu3HZVSpTyrVkpaYI7kv?=
 =?us-ascii?Q?s12gcRWMPbgaVenkZCmSQrbukhbGwbnCzK74HW0lTIhfCdCN6l5OgIQU3t1Z?=
 =?us-ascii?Q?mXLoeLnK1MvgqBlQos0Qq+t+Gt0jZpDlVtedhcPeqy2IbGZoRO3HUq5KVZaU?=
 =?us-ascii?Q?XOeI7Fxw3jSRVxDCoQCjzO+dXivZijCqx5lebFyC+XhWQxUeUEMLC5393iFR?=
 =?us-ascii?Q?HIsj4mragR7WHapBMrsJps3vXPR4jch7fB4A9qXGpHY/Ev1LvuTV2ZVeZsst?=
 =?us-ascii?Q?JKmXRgsPRT8ePii57zGgCrg6OEsWjbb1KJS2JeQCuDpbPg4zXcB0VjWtt3zX?=
 =?us-ascii?Q?LmBvdD7OhEbQ/lc4PCcl+CN+cVD+nmWxDIDWlOCPUQCfD/foOFeGji2Cuz83?=
 =?us-ascii?Q?ovzHLPb462yFJnfPUQuh2ps7XBnlV78NLLQybUF2LsGyQj8M1ZoWb18Wq63G?=
 =?us-ascii?Q?GJzXsbN6rQ9B9sIsCje9c7lcxJ9Pp8yOBgzb9oTF76nYmxCJpQ5HizekaRAa?=
 =?us-ascii?Q?z3IqMIJ75PfhQ6hFy0ajN27FNWDj86ndFYGXlldku4YPAr0hLK1q7cnB2hJP?=
 =?us-ascii?Q?0zKALOe1YwiEQRDFgxxYR+Y=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6bdcc4-cb93-4e7e-ace3-08dc64347592
X-MS-Exchange-CrossTenant-AuthSource: SH0PR01MB0841.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 07:59:25.6194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +uOilfcSRANc591JY4yvfRq/SYFLFfMICxy81M/C/8v70TixVG6xtIqbp9HEe4XRaeG4tQz7rj3zdKeUesYm76W28+nyqqVYfsQp8f0UtXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SH0PR01MB0460

Add DT binding documentation used by StarFive's
JH8100 SoC Starlink cache controller.

Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
---
 .../cache/starfive,jh8100-starlink-cache.yaml | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cache/starfive,jh8100-starlink-cache.yaml

diff --git a/Documentation/devicetree/bindings/cache/starfive,jh8100-starlink-cache.yaml b/Documentation/devicetree/bindings/cache/starfive,jh8100-starlink-cache.yaml
new file mode 100644
index 000000000000..6d61098e388b
--- /dev/null
+++ b/Documentation/devicetree/bindings/cache/starfive,jh8100-starlink-cache.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/cache/starfive,jh8100-starlink-cache.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive StarLink Cache Controller
+
+maintainers:
+  - Joshua Yeong <joshua.yeong@starfivetech.com>
+
+description:
+  StarFive's StarLink Cache Controller manages the L3 cache shared between
+  clusters of CPU cores. The cache driver enables RISC-V non-standard cache
+  management as an alternative to instructions in the RISC-V Zicbom extension.
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
+      soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        cache-controller@15000000 {
+          compatible = "starfive,jh8100-starlink-cache", "cache";
+          reg = <0x0 0x15000000 0x0 0x278>;
+          cache-block-size = <64>;
+          cache-level = <3>;
+          cache-sets = <8192>;
+          cache-size = <0x400000>;
+          cache-unified;
+        };
+      };
-- 
2.25.1


