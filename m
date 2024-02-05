Return-Path: <linux-kernel+bounces-52040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2E284933A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 704DAB20DF9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F07C139;
	Mon,  5 Feb 2024 05:13:58 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2102.outbound.protection.outlook.com [40.107.239.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F45BE6F;
	Mon,  5 Feb 2024 05:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707110038; cv=fail; b=kUxBoobBZGLnv9Pjf9Gpywt9s+HTge5CEA1HCnLDVh/1BNu47lcbBZn4noNqbNU0AAR2Qn1mXjMwQaRyB4Ma4UG1xyxeull6nsxHUEuZaiZw5mjlJ72JyF9+nFsGzUeLoA3zRRHkvrNZtSlCS/qK2b6aIqg5X/LM11lHPoyJFdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707110038; c=relaxed/simple;
	bh=0B0lcqj+owhpt/ttDtP1oTnHjLJInbPmDN4BVOHjUSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K5QzAKnIWZ899j7NoR0gtVX3jng8gXPLv/0wF8fRGIBZX2ShPd5+pFVoD4qlWa+UYfgt4ckkyc1lsm4Ml3IsPjPhrOuw6LC3mV+tYw72RyOzVCUSDod6kzoTaMqbHyDI+fmpnFl3Krvn9LwqqpSzArHdtRlQJAcsnzH3it29Ew4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyvL/bKPRPhVdKc8dpGcaOTkhn3k2H+EFdNP1MMPU0c/+WJtSE1MhwJ21r9HZvneyICyHXv4Vi2vX5j2ULqFcHK2LvLyAChOZtROE2ibvqXe2JH5LrAm30meajT6WitcA55X3MopISAgyS9ug/FeBdJewLduDfNpnw6mopcaYA7oIMP4f08k1+CxpuNt+N0OQdF7l5ycPOZpWLonpKAF4kPDdquhihz8clm6Y/yO5fZMC7Yw7F9lNbvlLtKmpJaV5FkuoSNnkPKnuQL7Hw/KQzVBt50sowKewLSynxQQWJ+fl1Lp2kNp+FlQtr9Qdni2sqZVbSu8vUzIpLumsIs6KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhD2zerR0naphy4NoxcOd+wGWyxsezBEfX6T6cDvcYA=;
 b=MXNJwaST6AgMUgHWrWIZEPf6B7ovNmxJ1peK4IyFxgljoruPyMgDf64fcYkX7v/UtR9G2SmosXgtz+Do2UW/yccyXUMIb7UyLwYp4eqC/vDj278K6CtqTmjbB/KdTaB3BiYuF0hiH5mX7hmEem/912N7kWtE01b9cqe0rTq/UpVipPSq7Q9Rw78VRM1hJy51ZVlx2crEk/j+yrcayNsbXHlfOxXI+hZs9EEIph9M3zzyO0Uf/Hf7fIZFCgw9oCbYEOgUBf4M5pNV02NxCq+I8in1Wzn8t2CG7LkVDpXhYXLiifei/Y/DwOmt9RwfNp2OIaJar9t9knFUMwgy6v0Akg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:42::6)
 by PNXPR01MB7488.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 05:13:52 +0000
Received: from MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::72b4:8a64:2d93:7cc0]) by MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::72b4:8a64:2d93:7cc0%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 05:13:52 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: sre@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] dt-bindings: power: supply: st,stc3117
Date: Mon,  5 Feb 2024 10:43:18 +0530
Message-Id: <20240205051321.4079933-2-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240205051321.4079933-1-bhavin.sharma@siliconsignals.io>
References: <20240205051321.4079933-1-bhavin.sharma@siliconsignals.io>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0085.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::21) To MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:42::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAZPR01MB6957:EE_|PNXPR01MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: e4159f9a-0676-4cca-a6ac-08dc26093e52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JxTXvFdUjRK+gLaqQr/Dzva+HsT0aDO7ftbG6haTEUYc5Je20wtsT4ZvOougokqCayYnRMWCfyAXdFSWFBvP3Zzv9zLooXY8b4UIjzl/mAYupGZhdEJc/oXzIfwyQuiZGKiLhBzMOIWnpYgPdfXaP9beF0+MP8Dw0RuqtoJopDX+Op0lgYRIKBG/F7x0Z1qSK2qnXrgL+zhKulSSf6oIcHQaWhSISSn1u7I2eXLjlrUlWunFjDRTKE3sqD87QopeQStscCLjiQAMrjZ+MMiUmiPOJIGAsNQHNqplHvBczuBicEuSyrF4xMzpR3vNYmSzMI/rfYbUAYNTQ8Zm6IjL/3abdKeM7JkBVCR0iNmW7ZkZ0azlc9Vkhaa8ETQEj2MrZDu2kKgrbeZVQGAI8plyajH1ssKuE535Hi073QnHJIEMI8IU4oEqhaC81anqqUPw81uAyaGfii+I3RpXd82JNHi9c/hm6fRbKWEtKYZfNzAZqmLyCs2lZKxOJRUOZFjhsWxWboJDdQD2u1kAVNikBfc/yOvYSxiDOu2ZJAn7uOGZLi/uVxtHes2I4hdqKqPlv0LeGUB0D/fYix6i7iCRFPYz7vXu9xNrR6AGh5IoW5M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39830400003)(366004)(136003)(396003)(230922051799003)(230273577357003)(451199024)(64100799003)(186009)(1800799012)(41300700001)(44832011)(5660300002)(2906002)(316002)(66476007)(66556008)(66946007)(54906003)(8676002)(8936002)(38350700005)(36756003)(4326008)(478600001)(26005)(86362001)(6666004)(52116002)(6506007)(6512007)(1076003)(2616005)(83380400001)(6486002)(38100700002)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jx/H6fAaN/b95fe2REYuTFcOWTu04g6NCkOj9ssQ89LDJFnbKUt85G4O4LLR?=
 =?us-ascii?Q?W50rgLaJanDHgqYUkGGA2TkolBEPOC37dE4NZTB8CmANPGYz7mCvHpnoBqzD?=
 =?us-ascii?Q?TUb4J7WA1cf6s2LfVXOqCIDbDxEDC6mtUxDi8NmvSJ7jyVa9yAi2+fQWSEeg?=
 =?us-ascii?Q?8t3cHEIOhGftQMUJN0Thu7rOtr92NeNo3fcsIE2yp8Tny7tb/yzRRJS9oSJX?=
 =?us-ascii?Q?/4KF4oeXJFwfW6yArhTb2cS6ToVtdPqF+GO0mQHAORsj6v2Yz7dCm6mOrRK8?=
 =?us-ascii?Q?87qvZjRBtGm6snhsa/2FmDpTVniQQIOoomRpxf+ww242MUPsGGc3ScAJb9/M?=
 =?us-ascii?Q?aR8MN0A3DOhdRiwj4gpvROzNGEKra0oZaIm4+uMo3TwY6qsOkIvdZRMQIcXB?=
 =?us-ascii?Q?leEbhhVXcArhcw6NWgEajFdJflcDshMRH2Dw8uUhZMgTcOltf6fy70N25AVZ?=
 =?us-ascii?Q?/1trJTvKz3zmm/VETUX30OKjMKKaqXaOOl4Q6ULD1j3oOlzPz6ygCLvNawrI?=
 =?us-ascii?Q?ss+gnew45NVi6w0Qse59nCUXfyfbiCnfk5HvYNF0xqgG2xXEWGcG+56bMMN+?=
 =?us-ascii?Q?/DO1mWEHCiIeGzBJ9KCBR6109czIJf+6/lrifkOKwmwmThraJt9ncHLNy2ZO?=
 =?us-ascii?Q?351UpU6/5WSQxdZGUn1/cWVrQPeGs9PMsTyIt3W1kNzDYeetEvo5vSkIriO1?=
 =?us-ascii?Q?kZHBL+gZgYT0t7+LK8gFEOztuoGLWkFT0/aQx1JZ74jH+ejenGje9X1+oQuz?=
 =?us-ascii?Q?avc4Wyd56X4S+pRW6VqrvvkyKhAT3muq31OrfK9HXlCXMS8o4MDUTigqlMMR?=
 =?us-ascii?Q?WAOzziCHGtz6vwSLiV36C0wN2XYSTdWMxqu/xhurY6O+iunyyc1QeQ0D5lhC?=
 =?us-ascii?Q?FKSDEo85LhcmXoT1wEjuJBnqPydJ9KD2QOS5vi88RG5mMJizFpJj1Lv4CeRj?=
 =?us-ascii?Q?IgD+u1CmeOMtPNoe7kfbe9hQ4dC53Dvvd15PH4VKY/i0TUFgLXUU5yGx0krg?=
 =?us-ascii?Q?zFoJLc5W4qHCPCDFxMAnnjYXawitJ7QVStj0R77rww4QhMv7fAkBJrXvk7NG?=
 =?us-ascii?Q?vrKMdflhW2lNgth/ogBcyMTtiqN4NY/+4WKsU2SoRinBMovwNII0KtQ1jN/c?=
 =?us-ascii?Q?aA82lWH3Y+2T+YjS3QklG8yQakENM+g8JipgY6ZpfKCAKjChMz9iPT5+k7bZ?=
 =?us-ascii?Q?ZZ+qqU6YNTfo1jWV1y9X7ymIro43V3aaPd4C9iM/QXD1W0TEivGRJzV0BXmf?=
 =?us-ascii?Q?YpJB58U5QoPgGO3vghRaHvnKiXu1HwIMm8BunfnrZageG26QPdmseO3Y4Qto?=
 =?us-ascii?Q?ZIBo85Y9EcpsbXuDw/xCLm/TjbwDZ2JeNk6i+avWR4+I5rJpGLdTnp/olI4P?=
 =?us-ascii?Q?Qls4pCQZG0hRDNxLLfe4SSZ/TYtU5WyUVMlRNlduXlGJze3xJk5TwWoSQyA/?=
 =?us-ascii?Q?rRhcglxflykLJAEQ/EG2vsnbt1k9GB8klmgGL9FfgiZ4L77+1ZURd6Ihy0P2?=
 =?us-ascii?Q?lhOLGvLXciQoG46YsD11yCVf4DJTPAlz3yE3+NDODdm6LKDT76m9n1cwhFPb?=
 =?us-ascii?Q?mR+H0TGcJy1KHHZW3W0jfC55//QO7ckYXwnLgOIFWXLc5v9b04ED8Y2r390M?=
 =?us-ascii?Q?hHMsLXJUPliXQO16hLF86o0=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: e4159f9a-0676-4cca-a6ac-08dc26093e52
X-MS-Exchange-CrossTenant-AuthSource: MAZPR01MB6957.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 05:13:52.2747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRq/ElbxWqBJFK8cE2BiQPJOkld8Mql0u7zF1RupEQkJxp2bRVDhY9CrkaMyE0gBC2eib8F11bg4y+ux1TgqSpMJfWivyMxZczYQETI9fUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB7488

Signed-off-by: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
---
Changelogs :

v2 -> v3
- Resolved DTC warnings and errors
- Formatted the changelogs
- Added monitored battery properties
- Replaced 'additionalProperties' with 'unevaluatedProperties'
- Replaced '&i2c6' with 'i2c'

v1 -> v2
- String value is redundantly quoted with any quotes (quoted-strings)
- Found character '\t' that cannot start any token
---
 .../bindings/power/supply/st,stc3117.yaml     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/st,stc3117.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/st,stc3117.yaml b/Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
new file mode 100644
index 000000000000..9ab0b0d6b30e
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/st,stc3117.yaml#
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
+      - st,stc3117
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    bat: battery {
+       compatible = "simple-battery";
+       device-chemistry = "lithium-ion-polymer";
+       energy-full-design-microwatt-hours = <16800000>;
+       charge-full-design-microamp-hours = <4000000>;
+       voltage-min-design-microvolt = <3000000>;
+    };
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      stc3117@70 {
+        compatible = "st,stc3117";
+        reg = <0x70>;
+        monitored-battery = <&bat>;
+      };
+    };
-- 
2.25.1


