Return-Path: <linux-kernel+bounces-18581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D41825FB6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 14:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FDB91F22408
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 13:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB55847C;
	Sat,  6 Jan 2024 13:36:14 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2071.outbound.protection.outlook.com [40.107.239.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E197494;
	Sat,  6 Jan 2024 13:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpOrq9IYDkg/U91nxfM46FOdSh9PLm1/ho0Pv12Y1cPCjbbLokliG/aCUwcydxIoWEq9NlzPCI26LqjY+jARKK51EsU7GmHY03vu/E6Yr7rNjBenBexqOWBFGA8g3k9QjTIM/YlRYSbZFg4OyA6N1A3VuUcCmM1HfnCVrNvHPTUypiGSSDJ+eIZ0YLPLSMJ9eQgm6LkkWaTYFN4S7usLE1KQCnUowkEEZrlKT4CxOi3eTDK+bPeOSqm+9DMUKrdQDgwzW/UWVPt8vu2V9s8vknyKuW4YXibozmwfGiS00dK7C4EXRJsQU5yqZP5karEmYvOnsxKs5XWvvUdhkmaaFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKHXj3F2NfYxp+0VyvmYXwCr4S5KoL8DGhvuXgVBe1k=;
 b=bdIf/Q/4zdD/T/nXA8aGaMKibgRPJnCBuQ39lkRkLjvxLUvKGY+DzO4wmPwg/qaBVSn7baJPGnoNpytotR5HY4Vfy0Yo8ZBDg7jM6ZfOyJt5qwBdhpsTYPX9gXsPb/VyHST5mAJ/4H//IJylws71lNU8ZyyahlmRBXkZlBXJQEl2kDcREqhtty13Ou+BM8zt15mtnUgu3XFt/RNSbYqT5sXoyTxTApTE4tFwWYEoIiPAIgcSfZPKKWQRE4w2vW7RPxpX/4XwGN1+t21lhi2COOFohEuRM9AeewgWqDQXzruLhdqOoQvJtoRRuW/rOB9VCxDxsh5bHjEkaDO9HHJDsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:42::6)
 by MA0PR01MB8931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.18; Sat, 6 Jan
 2024 13:36:10 +0000
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c1b:b2aa:7fc0:6532]) by MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c1b:b2aa:7fc0:6532%7]) with mapi id 15.20.7159.015; Sat, 6 Jan 2024
 13:36:10 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: power: supply: stc3117: Convert to DT schema format
Date: Sat,  6 Jan 2024 19:05:44 +0530
Message-Id: <20240106133546.936261-2-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240106133546.936261-1-bhavin.sharma@siliconsignals.io>
References: <20240106133546.936261-1-bhavin.sharma@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::36) To MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:42::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAZPR01MB6957:EE_|MA0PR01MB8931:EE_
X-MS-Office365-Filtering-Correlation-Id: a32f7af2-0684-473c-80f6-08dc0ebc71ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L4nMEUlJL1nSJgGaG+d7sEv9Ud0MJVpUpZOjXSVaNThUsdD4l4NR5W/VC4N4GQcdC/Zw4xM6LwpavN28z10ipSjOBNKjTf/c3pGXTsDphWGgmysrNB+Se17+3U+qGKucwyXFVuY/Ug/uCYgIAs1cPI0EQHPYEv2gRheFcx0nKodPD9T+s/3jY2wRF6HYWNpn1gBKjSUqvsx0yjA1/lzwfxGJL5QbR8iBPv9hWbuf2Lc5wK1B2a0TkdF+4BjEOe4N3UUsDgxJtGsvho2ZPgwlvZY0nO2vNTFrX1NGiccdU7hPsOp+le1HmjfxsXdcVBRtGwmKqPLXkR1OTh4oppXNSEWy3JXdtUl6WkVh8N0Y/gqlLyKKtmFDLSSbv8Vi7rJInuITjUgbCQ/jQmIUmY9mW3N9eL6MeGkxia1KbvRKXiaO/3LQ18Lb8YOG/gNNuswdqhpYJE4EnbJR5y2PdGTUS0KYhAQsVfa1t8XY7fjHOQaekBwJXwJmdX6VRipQgG7SvyU+D3GajfozepbMEJDxVgrKe+Qz6lJg1cbSF3qIf7yKEJbWqzCtuem7rV5fJPx6QDVi9PiOWUQmL9UnqYTaHp+GBl6KY/q5LzUrEHsova8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39830400003)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(38100700002)(44832011)(4326008)(5660300002)(2906002)(38350700005)(6512007)(478600001)(6666004)(6506007)(52116002)(966005)(26005)(2616005)(1076003)(54906003)(316002)(66946007)(66476007)(6916009)(36756003)(66556008)(8936002)(8676002)(6486002)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s8dgmjUWA08k2jnZigZrjpO0B0vbo75Jq1a7lAu6yoV4ngct9rzkWL6uX4+s?=
 =?us-ascii?Q?3b9lOy5lQpEznGbVOfPE0PC7gVhp3d1TgiwO3aRzGSwf/bheLu0HuE/rwM2K?=
 =?us-ascii?Q?0gMO635yuB3najjFBxBMC6Jtt7Fg42SLqwteJn5PXMjPcVMMDH3lcg4W7w3Y?=
 =?us-ascii?Q?yxmB8jXyWe4sXG8kpnUVqB2JC9/NZcPhilu5qqztfopnwtNdGAyJlp0a/PHB?=
 =?us-ascii?Q?GE3kJ8FceRPHYminA13fu5I+euPxndI8L90xbIyOvIfHyhHr3LmLSazZyBP4?=
 =?us-ascii?Q?r82SvOVwg3dthLlU8HX7cRUjfVTlTVPwAb5S5uR7bovPfLVmFeRhbjwtk/Fy?=
 =?us-ascii?Q?Bu6eUyz4/v1DOOHhvPSd6QWpmyDPIMntUNT+jNCLgnOlApUSD4EMOC+v0+Ee?=
 =?us-ascii?Q?TJqgJpg3hT83XDB0Jmv9zy7M/ovHPIfJCq6g076nB7Qgw2OJVt8NE73chwDe?=
 =?us-ascii?Q?QDBtxflpzQUdjNtGomS06mH9d8snD2RXHCm3XKZUEcM16VF8cUYXjr81jgza?=
 =?us-ascii?Q?V0Fh10isXh73G7JGTcyw/oerww3SNW5U/0VwMmoIOpcDQ3TQ18NWA5eym0Ob?=
 =?us-ascii?Q?/feE9HHCgtJNpK1BTwtwEROPZYQYv65iZ0An0OALiOBeibYI8JI2jGkSZYxs?=
 =?us-ascii?Q?tqfkc0z04rCdSRxOfrqMu9zFEl2pDX2VasVg5V9XhXjRl5GnKS12KkQRWjw2?=
 =?us-ascii?Q?66mgFCo1xSlKz0hqfQeG4QKFUe+6vjvZnwGQ7K/DRC6JKZK9+HQh9sT84JHM?=
 =?us-ascii?Q?3P7hWJahX1d8cZsbumZ2lQ7F+TOTqf9oDtK/zi9tc837qE9zlLzX4dDJXG2f?=
 =?us-ascii?Q?2a+2VSeQOmhtUfbJhaX0SGyGjgzvHv25o1T8AqLrmktdTQDkUMTPbxECRYvw?=
 =?us-ascii?Q?KbeA+EU9YSgtVuff+9USfOYZiCyLaUcJbVKi5573WSabYGXCkyt9v71KD1S5?=
 =?us-ascii?Q?bz6q0zLN3NtY6L8Md6z14kUgAnPghC+W7TbIJF7evx4pAgwFFIL6XS9nygvm?=
 =?us-ascii?Q?Gq4er4BfTXQVGGIz9hgqXoy7+EXqEEWcz0Wkl5tcDTCDxzn9IXSwLqKXr0W6?=
 =?us-ascii?Q?u3QPpWj5wPjN3AePGC5s9kMYryPd8p4xPjavNvKRSEsP3OZK86JDDQHJw381?=
 =?us-ascii?Q?7DXctwNtmMhtaLCbX3Y+5FFD8ZxxrPlBBKRifnEg0+Z9RR+kmCbHpmh2iS2S?=
 =?us-ascii?Q?KwjScWcCOXwQiSsKrSd8O25Dyom26ivkBUVn7ybRIspbRIKRZWAzv/wVlqXf?=
 =?us-ascii?Q?ynEw2EQ5vHAMmld3LD22Zz83c0acKq3thN3qQ7DsRFqPv1p6uhUTneUeghJv?=
 =?us-ascii?Q?L5KqI+NZ/uzxsjcv7v1HQz8rVG4ONmBNrKCrm4DX8VkmdnT69uICuS/6d1+f?=
 =?us-ascii?Q?hmt0ib7gF9kzkpPbMJcCKGCNen+TUBSEMfLXX5jZqaCwmCyVBZ/Zc7T+Hjk2?=
 =?us-ascii?Q?vFCs3IFCn/rj91Q+K0tnrj6crxZOKjGnEnLniz+zKm9ESmJUUqoaaAnE+C9W?=
 =?us-ascii?Q?W7QqOvi7+3Lfx3PoshObdVSj3tW7DVjgdIiq2QmDHZSklk3zoNHJJS3DjqPu?=
 =?us-ascii?Q?xQtpo0C1TWoT8ZIRogrt+dWldvb7tdIT5ZvG9U9LtvOZ+PSEUsXXapapRIV+?=
 =?us-ascii?Q?Idg0Tnev5f/Z7ygowLcH3G8=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: a32f7af2-0684-473c-80f6-08dc0ebc71ce
X-MS-Exchange-CrossTenant-AuthSource: MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 13:36:10.6740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxwNhclPz5KhwcHi42/MzYMjHUmRuMlKuOXWPAmx3+x1arUcGcaYsYQDDdUh9PgQNethsFCz/m6B35hcQ48iE0t6XMB8SFMtaNxZRGN7bEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8931

Convert the binding to DT schema format.

Changes in V2 resolved below errors:
	1. string value is redundantly quoted with any quotes (quoted-strings)
	2. found character '\t' that cannot start any token

Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
---
 .../bindings/power/supply/stc3117-fg.yaml     | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/stc3117-fg.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/stc3117-fg.yaml b/Documentation/devicetree/bindings/power/supply/stc3117-fg.yaml
new file mode 100644
index 000000000..d6607a5ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/stc3117-fg.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/stc3117-fg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STC3117 Fuel Gauge Unit Power Supply
+
+maintainers:
+  - Bhavin Sharma <bhavin.sharma@siliconsignals.io>
+  - Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    enum:
+      - st,stc3117-fgu
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    &i2c6 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      st3117: stc3117@70 {
+        compatible = "st,stc3117-fgu";
+        reg = <0x70>;
+        status = "okay";
+      };
+    };
-- 
2.25.1


