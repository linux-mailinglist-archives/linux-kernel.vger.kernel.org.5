Return-Path: <linux-kernel+bounces-11832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2F581EC47
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F401F21B4B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 05:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D0853AC;
	Wed, 27 Dec 2023 05:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="PrRhlFZ3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2012.outbound.protection.outlook.com [40.92.52.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28976440A;
	Wed, 27 Dec 2023 05:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfNQcNm7kIWObIGGB29a2NsJjq6C/mTEqycvgA2AOHdwo+tz/6dyYapv9RXzpNLnWtWedcr4FB688Wlr3gKmpCMZRwODSP6EyNenVR1xja+3zUFJwICAqATbSmkCzkGb4lfMj285pYHApgT18TCT0+D9ztxgOiLDPQXYEgwqehgjTU2ITeZ4Uwk8CqbL4BwqwfxAoeDSK45KnsA9H+1gj3T7rbvdiQYxnIzQxXT0eV0l+56lufnTIKZmp3BpiSDUDOi+AtnyNJIJs7ki9XoFkSOUoURUjZvay/pLE0DqQkp1Up+MC+JK7fo4GFdoh9R7RU5L+eOwjszazXxjIMNH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s37jSSSIfWvv4osA/JKTica5YwY6pLg6qIwu6mIngXE=;
 b=detK97g3zEki8NT8YUXbWxll6fmgPPh2eBn+VymXWTm5ozc/AF4Z3M0O0OMMNYeYIzOqY6Wa/KOE8A7BFe6t3DpGC+qSeTLcRrs1qMBfoEEzOpGr690y0paHo5A2ta3n2yi8bISXWL8R6H9zt+5ROHstVEMGqp5UeSYAmF2pLIkMQk3zxlgtzqpq+1E7KfFhdI8xcnPL/B0AhSyrLw5C04wN9rwjB0C2DqmhUYMt46Uh9n9h0ww1g6tLVi3xZRg7GDTI3bS9d41RoeNi2xBwKwdj37of2iTbItsozDDopgcIB1vTRqGQ59exEopvfGpidn2rl8DIOVmaE0kRtW6Qww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s37jSSSIfWvv4osA/JKTica5YwY6pLg6qIwu6mIngXE=;
 b=PrRhlFZ3hNW1zWH55SWt5Mb16UNm80azs5RT/H4StXz9V1mgbUJgRGWVPn/b7TcwvpIzkMCGgnv+XHsCszQ42nsvmj7EWc4WYkNJPrduWPqcQHUHYlHQWSY/PSUFxQtqtI+6H1pfgmvrfv0bdXmIFt2mqO+wem26K0E37DRDLov9160sfH2IeZ53sAFIY01COvuaRNlT7jzSyoap1gvp2No2hsBzFRZkzeE00NjsDTpohq4M+tKdWX/e7ew+fQ3ScbY3Qen8GG+yykQbU5PC3sH9FaXDZMe/W+Dn5Mtu7ASpm+n7ChYb7aSlQz6ddvrs2cTz28q//iZJxMxNEjxOrA==
Received: from SEZPR06MB5608.apcprd06.prod.outlook.com (2603:1096:101:c8::13)
 by JH0PR06MB6977.apcprd06.prod.outlook.com (2603:1096:990:70::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 05:35:25 +0000
Received: from SEZPR06MB5608.apcprd06.prod.outlook.com
 ([fe80::3786:2a86:9685:a19d]) by SEZPR06MB5608.apcprd06.prod.outlook.com
 ([fe80::3786:2a86:9685:a19d%2]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 05:35:24 +0000
From: Allen_Lin <allencl_lin@hotmail.com>
To: dmitry.torokhov@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Allen_Lin <allencl_lin@hotmail.com>
Subject: [PATCH v3 1/2] dt-bindings: input: Add Himax HX83102J touchscreen
Date: Wed, 27 Dec 2023 13:35:08 +0800
Message-ID:
 <SEZPR06MB56080820EE51CBAE9C6B6B3E9E9FA@SEZPR06MB5608.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227053509.894642-1-allencl_lin@hotmail.com>
References: <20231227053509.894642-1-allencl_lin@hotmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-TMN: [KudIRzCzJh9O+ftMosuCJlmNpOrT8g7B]
X-ClientProxiedBy: PS1PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::33) To SEZPR06MB5608.apcprd06.prod.outlook.com
 (2603:1096:101:c8::13)
X-Microsoft-Original-Message-ID:
 <20231227053509.894642-2-allencl_lin@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5608:EE_|JH0PR06MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: 30610290-c31f-40b4-d4d4-08dc069da025
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K4vfZa5K6DoFH34FAcuBaEG7/oE8BsXhZ1ecoUglcsJIwBO6Mv2elWZwW6+EgNAPlePy/Ags6xxmKKlUeJpKSlD1IhBEDHaXAPrlKcC6B1x93/XQWiiivO889gOuipWJYi3Y85Yea5BZ0S6xUSsLNZxbXH9F/nXeaTa9SpNspirNaGXEs+Zp4+onnsZnl1wOIseCdgg4Nn/V7pQDvNic+Y2XcSBuuybVUAOxvOOwH8MT//oHrB8tSrxt3GQt2JKrUkQpIvCRk68l7jaC6QfU7jydM24JCPvLa+3vI+PHmPOuuYt2xOITvm2+rDWqKsHuGBGmFuanU15lrEz/6wpevy8cDwuuBINUsatM/iteYFLWaP+caXLNyru0fGi/XzoNeOksKJmXYngLdLJhodsnuR35tYkKwEsXlv02RKIKwWbQqnSZxrZb8is/xYuKqBBeYti4Nhf/uVGnV+ouyjkaTxKNkbIeC+GnHK+kptNb5EC2vRpJPjaQAKDVygp57K9c8xtYZ9/9HzPCY1F4fPg+6gMkGzMIh8edRZo7wiLu9JPYGRM3JSVMeyTZmXRfHDKLer63oDr+39cz2A0mq9X2N0l9i4M7JmRIYEEXS/Ym/rYTU+Ij65NqjdAL4oayQcaa
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5eq696OFhhGjKxo1ZwVTlNJsOohbf+LX8S3LV2m0C6U/JBNii4GjoXjPq5v4?=
 =?us-ascii?Q?225+QqgHO7AJBKlHXUpH4EhxUt/lGmdvdOmguoPLUTy6/yQ26DsMcM7S/U2v?=
 =?us-ascii?Q?8b0xzpr6I5QtPL3cgr8NNUBeYfojL8gy1OBSzG9GRIsbqGjj8LbS0S7Gk5zN?=
 =?us-ascii?Q?ys+vdvWRwBV0AiUOVR8p5dYI3Yt1XqmBb1tLRrREk6qmhfL6LmWkBt35Hsf1?=
 =?us-ascii?Q?xHLBT6v5D/CKZGNZfEIGMrYvkRNj8fBJ86j3GRpL0FLzz6IvbPYBaGL6lShH?=
 =?us-ascii?Q?qJibpYI/odSWA8pZNPBi9gwUT4OAnda28iPgpIqw0LbXNXudZsFuTU3ntODq?=
 =?us-ascii?Q?py8Tki0CCynCQbgPdJVLpcZ89qp0rYuQ0D2SQB19olpJZKmrZDMT/0jmYYsU?=
 =?us-ascii?Q?DD0mW8JKspkQCdtGAVXkRLuiCRfhjQppuf8K8RDyjry2GU62TDtPTK5iHrnM?=
 =?us-ascii?Q?SXs1e0p9yfyxLSJap7kh0AXp5TSbMbmsqOQ7zuRL0Qjtf4IYf/l3UBeH+vLS?=
 =?us-ascii?Q?dZM9jX7Vi+deaA8dalYTr8P5mR5LGOk+LE70DPer+YIBZVs7Li5zu7YsNoFL?=
 =?us-ascii?Q?aR2nS8IRi/nRz6YzSlTmnqRa/7NQE6b0i7x/bdD2eh+a5eyEcPmZ3UkeHLJ5?=
 =?us-ascii?Q?ZNBvz6N8Z5Iul1epKLECCRku6+0BU/TDFdXtOUHzXac1wMdppgb6kTPKsPeO?=
 =?us-ascii?Q?U57nTzi0WVWfNy4XkdD6SpKoQcUoMmDJnXlt69e8N2xMF4sZLhXbukVKOugn?=
 =?us-ascii?Q?9XkU+LZCW1xb0ND6k9qzRXDR9HX0eyj5s///wZA8WmfvMhpBj/4Lp4Viosr2?=
 =?us-ascii?Q?oq/MNsxoDkFC90KrU3fGp4OODVXv00EbnKmfIHaUNx+svNuYahkuBly/KIBl?=
 =?us-ascii?Q?/HRR9ogrTCvQ/hRAuKii4lXV9+T6+zRBDyoyOLL+vNPVDr9d8ilgIGXlQpkr?=
 =?us-ascii?Q?5Cg7Pq/fEiP7haevXcsZcddWRcomkBtCj/w2PrkSeH9zR6UF2T84TUw3ePG6?=
 =?us-ascii?Q?31xItxncPQmlogQjznv8pIU/rBMqbp5qrtFmNyXz+5LyCSGd23DRox2yWnQr?=
 =?us-ascii?Q?VQbBz7LlCGqPNpmfjSygJCnFScEAg3MC2oTtr+cm1TnCeyKEOVmdvXShH/Th?=
 =?us-ascii?Q?QRLmMq/Qwi6Tbvw9VP5/tGD1Kilof7yB33kXevb560XbOjzjKHIE8BGQLoDQ?=
 =?us-ascii?Q?9x89fGHIOdSLGy9goPdIASR91Zv1sBQfYv+uXw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3208f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 30610290-c31f-40b4-d4d4-08dc069da025
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5608.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 05:35:24.9024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6977

Add the HX83102j touchscreen device tree bindings documents.

Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
---
 .../bindings/input/himax,hx83102j.yaml        | 65 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/himax,hx83102j.=
yaml

diff --git a/Documentation/devicetree/bindings/input/himax,hx83102j.yaml b/=
Documentation/devicetree/bindings/input/himax,hx83102j.yaml
new file mode 100644
index 000000000000..872b478c5753
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/himax,hx83102j.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)=0D
+%YAML 1.2=0D
+---=0D
+$id: http://devicetree.org/schemas/input/himax,hx83102j.yaml#=0D
+$schema: http://devicetree.org/meta-schemas/core.yaml#=0D
+=0D
+title: Himax hx83102j touchscreen=0D
+=0D
+maintainers:=0D
+  - Allen Lin <allencl_lin@hotmail.com>=0D
+=0D
+description:=0D
+  This Himax hx83102j touchscreen uses the spi-hid protocol.=0D
+=0D
+allOf:=0D
+  - $ref: /schemas/input/touchscreen/touchscreen.yaml#=0D
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#=0D
+=0D
+properties:=0D
+  compatible:=0D
+    enum:=0D
+      - himax,hx83102j=0D
+=0D
+  reg:=0D
+    maxItems: 1=0D
+=0D
+  interrupts:=0D
+    maxItems: 1=0D
+=0D
+  reset-gpios:=0D
+    maxItems: 1=0D
+=0D
+  spi-cpha: true=0D
+=0D
+  spi-cpol: true=0D
+=0D
+  spi-max-frequency: true=0D
+=0D
+required:=0D
+  - compatible=0D
+  - reg=0D
+  - interrupts=0D
+  - reset-gpios=0D
+=0D
+additionalProperties: false=0D
+=0D
+examples:=0D
+  - |=0D
+    #include <dt-bindings/gpio/gpio.h>=0D
+    #include <dt-bindings/interrupt-controller/irq.h>=0D
+    spi {=0D
+      #address-cells =3D <1>;=0D
+      #size-cells =3D <0>;=0D
+      hid-himax-spi@0 {=0D
+        compatible =3D "himax,hx83102j";=0D
+        reg =3D <0>;=0D
+        pinctrl-names =3D "default";=0D
+        pinctrl-0 =3D <&touch_int0 &touch_reset>;=0D
+        reset-gpios =3D <&gpio1 8 GPIO_ACTIVE_LOW>;=0D
+        spi-cpha;=0D
+        spi-cpol;=0D
+        interrupt-parent =3D <&gpio1>;=0D
+        interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;=0D
+      };=0D
+    };=0D
diff --git a/MAINTAINERS b/MAINTAINERS
index 012df8ccf34e..6a92e40d126d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9502,6 +9502,12 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/misc/hisi_hikey_usb.c
=20
+HIMAX HID HX83102J TOUCHSCREEN
+M:	Allen Lin <allencl_lin@hotmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/himax,hx83102j.yaml
+
 HIMAX HX83112B TOUCHSCREEN SUPPORT
 M:	Job Noorman <job@noorman.info>
 L:	linux-input@vger.kernel.org
--=20
2.34.1


