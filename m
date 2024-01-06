Return-Path: <linux-kernel+bounces-18551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7F3825F19
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 11:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F221C214E4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 10:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342F96FA1;
	Sat,  6 Jan 2024 10:15:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2045.outbound.protection.outlook.com [40.107.239.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AB46FAD;
	Sat,  6 Jan 2024 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eh0+RyqnWmxhet6RNkF8QcwDfmjqBAaCwfcH4wUhFvtViGYwvxExWlbhxTdBKpn+Z18dVmnaugiT9JsJMay9SC+HZnRoKuNwkhmtfYxxluCXUOgDZwY3anEOO+TANQ1UJeZaQR0T4pBVa5z2ZPztZJC7JvGqIA1CIP0zTEmYGlzvcaTyX0dP+5z47fQi/BaE/cbS0RHjpa58IMGC1stu9V0PG4QMay9s3xiXiSCVO+rSucpUDAmG3GBCWGvefOrsiMDMSl62R3QQQvsqcr/dEIOo6DW4VGARyjxN427imkmE+aSoOKXyR5T64bD/m+kBEi4KLZG9xmG72i4HWIxICQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gt0RsM/VIpEIaJ4Odhf1rpxdTv+cTD4RIvTWMcGdaj0=;
 b=GIwChduNqQWTomi4O8MJSF66yBeLOw+q2yV6ip6kZEUgbkXaRDmz2emSC0G4Ki361aMzACAD4vvUukGWF3zOHhYh9g/1ONtmPG/EpSQOwNZRynu9BcQ925hWoUXIzPKCBqbtcTOzwZCArus86ZRFh8lPOOcp7U0Aw8Eow12kP/CmtBct1l5Q3LhQ9Se9NstgI33BTRS0fA3aX6DRSc3uHO/EXSD8vYuWWI27ckPzWflTu6+pbyxo376y0EAIOcQtdUENtzKEQahYTcyrQ9ji9Mrefgv/aJ4anDV0QDVnbH8ScNClY3KwwKRIIuX/Jv9xgfhg6wv0EWIma7Kh9M5cyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:42::6)
 by MA0PR01MB6415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:74::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.18; Sat, 6 Jan
 2024 10:15:07 +0000
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c1b:b2aa:7fc0:6532]) by MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::c1b:b2aa:7fc0:6532%7]) with mapi id 15.20.7159.015; Sat, 6 Jan 2024
 10:15:07 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: power: supply: stc3117: Convert to DT schema format
Date: Sat,  6 Jan 2024 15:44:34 +0530
Message-Id: <20240106101435.2927116-2-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240106101435.2927116-1-bhavin.sharma@siliconsignals.io>
References: <20240106101435.2927116-1-bhavin.sharma@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0079.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::19) To MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:42::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAZPR01MB6957:EE_|MA0PR01MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e35b58-1f06-4429-8952-08dc0ea05b79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vqEpkuOlk5WMpnFEsvz/96NTNndfzp2+pO8zCzmjOEVOfESN+GW6QXgjxcPAoXRFhV42MqV09wDe2Pc+aJTl6VnM9QhVdHQrhzRIFL01zrmKWaVWVr2lsaNxodcFomcfFF9yQca68y47ELlmI9ncUW9uz4XWZOhWN/lt5HZTejIenumDu+F7/xYIJkc82wDKsGndvchPRu73cQBJg6pgBEX+dhwFC7yz9M/MCy94aLLmdLK62VFoNNvYcKJRajr7RwJcyXsW5/eHnGJmU4Yb1VQVR0NihcXsmfVYjli9vHecjiaACTJG/b0f2mcup8p+DjdJeDvAtiwMU0mxsKOvrppKKuFyYRc5bKIzs9wgtAiRUWJPc84uHCBwzvK8YLOP+kbqlgBoJiPweDYeeIgPsTMoz51JdWvbYmt94ZfD3D7hNXqTaq132uT23skH+Qibm4jc3HUEGa7Gf6k777lt3Fh9HV3P0wgz02LLTdiJgx8Mtca1NpwGCA/ablFfzRHjy6vfnCFmijp3QM4iz7+jJPhNs9iRJ9XW37bLI5YBJHlcjAAdI6qiJUmP1ABf0U0gf6uhGKe9S00KG16bAg6tmNcZ1gk5OnDbbmr4eGG3ZaA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(39830400003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38100700002)(44832011)(4326008)(5660300002)(2906002)(38350700005)(6512007)(478600001)(6666004)(52116002)(6506007)(1076003)(26005)(2616005)(54906003)(66946007)(6916009)(36756003)(66556008)(316002)(66476007)(8936002)(8676002)(6486002)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xRarUwOrFjXHwjBEfZCXWFAwd2Z9sUqEchicOZ5aVHvAKAIFHxf5Cs6dkZLT?=
 =?us-ascii?Q?eA0IOK1eq4xbghhvGRpITu78jB+WBr644NXi0JTO8vQgulg2TvfdsUrHEUm2?=
 =?us-ascii?Q?ej7VtdyIKkVCrGv1D4OruRBkl6VV/9favWVzzvlEAsCtTCGyqLpI9A03VqK7?=
 =?us-ascii?Q?XkulOPxeDXoa2AHFvycx3Ieburv5ZXrYFFRrW7VueTCZr3XW0nIK5kO2vX8Z?=
 =?us-ascii?Q?Yh8jQzLSYamvHnRbSY6pqASgtGwvuSdxx9+KI1OHd2trp3ntcDDFVBZXpzoU?=
 =?us-ascii?Q?m2pb+4qVlwCXoDgac8E8Hm/qVFUCJ5/xyZh7t73WbzlfY4/8vCVRmCtJJsBN?=
 =?us-ascii?Q?f71OT3Tjk3MyOZIsKov8OKD+zmTqwpDrR7E6w6M0jK4vsvTLKnCGW1ts7adL?=
 =?us-ascii?Q?gkxtXSCf/k6oNhvCUmVfUZr+4yn7yEDXBsO1miTIC0JcfKRR+CE66+1vlTsC?=
 =?us-ascii?Q?XVe6esVsETSax5FmIwSIu+5WE9Izy4FdhTa93FoeNxoAlig+ZG14M25rv+7H?=
 =?us-ascii?Q?lKOxsm3EZjuQn/o4gSeeyHIBJKQda6MfBZLFFZymNqYJpBgUQO8Jr9EOQW2s?=
 =?us-ascii?Q?vkpSJvQaPEaQxbQgtB4EwwYaVWNxdiRiqugeW2IvA8jf/hfkRy1YUeTe9NPD?=
 =?us-ascii?Q?bDlgBnnaVXFsA4bofUlVTm0szOpiUGbQmhGnvrp0jEJhJjk+xpsCzfepY4t3?=
 =?us-ascii?Q?kjP/eGSOXpBMsIc2nfU53C83yruwaP4Bc9pnasFiHROBwAJ8QoSjbsEmEXac?=
 =?us-ascii?Q?vfh+HcGt1/iVRNKRhmndduVAaUBhr48YvbfXvJvVKOxw2R8bYLIZqmgkTw9Z?=
 =?us-ascii?Q?BUzZKrU5v5ZWWaoNrxrGAglZmPakIZDzGkcxAFILHYrd56MfIdN4QDIKr6SW?=
 =?us-ascii?Q?AhFG7guph+UiuYuxNn2FPv/U5qbv0+WNA/YGF0y7zNj+41EceTeBuQNyk8Mj?=
 =?us-ascii?Q?tbb7pH0wcx5VraITiW5Z2GPhLoMQ411tz+6Xjc6s7xsmgK/CJ1p9nKVADd9z?=
 =?us-ascii?Q?8tFSTNDMFIAYJOX3t8u0Oq8NRwK1yWObOIryad0AjVE66V7OvVJ/khAZCcgF?=
 =?us-ascii?Q?sL5ojZ6+bUF0mRWu8Uw0Ei/2tTV7wqi6aJkJ8uoua8SLE6o9/V22pKsGcLfl?=
 =?us-ascii?Q?gwsZTc0OnFkGOpaXT1KO8Gp9yw765nmHm1P7SxvbCKOuM6RtyJVVOy/H2sei?=
 =?us-ascii?Q?CQPoq+pz70Eh2VchCJ7//JCbKZlJSdiVQpHgPsH5A6DgQ2ZersyYlwFHIJye?=
 =?us-ascii?Q?ivWVuSQ4n5wrq+HxEQJ9jgmTRF5LbzrykOahzHTAdQpFDHlI0gMdVUISvsKg?=
 =?us-ascii?Q?Qo2Lo5X0sGyeVQ1VN0Knzmrzs1DU/T8awP4zG/jZRm/4/nEzSnB6HfbKZi5L?=
 =?us-ascii?Q?kWetRBYhwmM1EIhX2EhB+XGf/2yzUdyrneiESK/nD2RVem6JyfVYv++ReCC2?=
 =?us-ascii?Q?zvO8UhdXhCO/3+B0FUqx2QyxvF4yvn8PqOVx6VLFbUVAKEUu4NSqW5+RIl5K?=
 =?us-ascii?Q?sUnkXZmgOGDWjnfvt5HjR/H5UyBLhwW3Hr0GtUpUdTjpz2w8q40M0vQA+amB?=
 =?us-ascii?Q?2IXyomEQgaV9A0CSeIm8/AaPFngbAkSS0qfPIfax3Fpvmw71kjmehDeMWzTK?=
 =?us-ascii?Q?/SDTMcJsuvAklUT73uz5t1Q=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e35b58-1f06-4429-8952-08dc0ea05b79
X-MS-Exchange-CrossTenant-AuthSource: MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2024 10:15:07.2847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 856rxs90wy4shiF7VKkbwUPHdRSfKGFNOR/dJ9wFmOvpfexre5RQSIfHiSXkpW8WoUQfrhmFxUdm/r54looxCVnWxl8+iM9iHkG2pEFIjKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6415

Convert the binding to DT schema format.

Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
---
 .../bindings/power/supply/stc3117-fg.yaml     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/stc3117-fg.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/stc3117-fg.yaml b/Documentation/devicetree/bindings/power/supply/stc3117-fg.yaml
new file mode 100644
index 000000000000..2c33132ab785
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/stc3117-fg.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/supply/sc27xx-fg.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: STMicroelectronics STC3117 Fuel Gauge Unit Power Supply Bindings
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
+	status = "okay";
+      };
+    };
+
-- 
2.34.1


