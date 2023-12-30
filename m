Return-Path: <linux-kernel+bounces-13463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF2C8206F0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 16:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B52AB2159C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 15:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6399FBA4B;
	Sat, 30 Dec 2023 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="gEPU2ZXG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2098F945A;
	Sat, 30 Dec 2023 15:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Srwf5t/KcpvyObeH/zojqH3upZQ1NbjHawHEr4/sv2DM5QZeBd/qWyUMNuXwiHzUpC/elviPBN2Xej3ARqwtAyT+RXVCpo4ZLmf5u1yFQPQwuz7kvfpYuPR7qWLE34cLzu+DI6IKyK7lvBXQAl2+/meu01xXCBwBoUf4iFHLtqDmwVli/DlW7A1TEjqfmxXCHiMb4o3COXnyPi1hyXrdNsqrkQVTgOUDwkpqFZuJ70kKTlHIGFtw4Sqqps4cpFqotBMAmsUUBtx1Bn9mkXHTaq2gYp8tk29Kn6hXB3wj61lxffnXcWkuf8NJHhZO32M5vIRiLK/V//rc+tzuDcDqFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1jefzKMvZkRJIxSXlZbuk8TcVlPWBB7rZYpUqKDH4M=;
 b=HquDXPbIX18+snckQ+zF4zGYz55fCQ1BAnxNjpLjjR4qJzEz1GB7WH0x3Edxqj4nu0cbZr2nxkbao6AUacAWC7MHX31sbnQqKXMm/om3OBt+s9axlKUiBGGgXvsx2fYTPz0cZn0/BsS/cx0Ybt0fs999zEnZMPcYImEkVv/DO4yCeZHS4eXcDtFxjBjAj1KNRCgBbJk7piGKuFZbUc3ya9wmFBGEQrxjIzVd8e//sm5dgPWGr//HR1xaH3Lle6k4GRiEluoXY3AscPRMO9QGTrlgSF+BQdgDg+VQm6AvxA44ZJDpU6G8pnC5pZsEHqsATHfl5U3DLLVkLFL9+fhHBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1jefzKMvZkRJIxSXlZbuk8TcVlPWBB7rZYpUqKDH4M=;
 b=gEPU2ZXGiW99WOPxqwsFUDp73/3/Opm5sdnCsVV4V+ndwLPFWoGlllVhBmSIupCzPvSDr4Z13g+2qoic/eQLp/LO3z02+sn1F/Pic/yvBybFjxK8tYhjEqc3WTe/V1H2kFnaurW0ujRreRL8bX0WEY4Il0Gozt8o3BvwjAfxKiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB8PR04MB6970.eurprd04.prod.outlook.com (2603:10a6:10:fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.22; Sat, 30 Dec
 2023 15:44:46 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73%6]) with mapi id 15.20.7135.023; Sat, 30 Dec 2023
 15:44:46 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 30 Dec 2023 16:44:36 +0100
Subject: [PATCH v4 02/11] dt-bindings: marvell: a38x: convert the soc
 compatibles description to yaml
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231230-support-clearfog-gtr-l8-sfp-v4-2-1d7f0e2c7128@solid-run.com>
References: <20231230-support-clearfog-gtr-l8-sfp-v4-0-1d7f0e2c7128@solid-run.com>
In-Reply-To: <20231230-support-clearfog-gtr-l8-sfp-v4-0-1d7f0e2c7128@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR0P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::16) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DB8PR04MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 089e301f-d86e-4298-cfd7-08dc094e3fce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6+9N8scDVVG/bduYXAH9ZAjoTEvjvOUvVtw1mn5juI/zz3bKzdSZ9H40Op5jSUKpFwDNFqNdBBzGCdosDhOkBTHh8nUYq2a7rVtxtMdhAh96UmntDJ2uHp7l8E237bJ6ObiWaP1CXv1lqjPhGu+JVDfBYCniuGfHzYGA+Al+tN341UzeQyjjnF4Yc0l6bpZTIdvu1ekiZ3stHTmUTFILOyfs/TiMwixYxVyfFIfAZETMU4hH6lwCQQQ+s/DoCQGCkp02JPrkN9vNtBYXz6ppHSurSc2BwxavjnAQzNGkJXoc05VW2oMKprNmjleGMqtXE8ipWKcSUaDJoa5cmhlw+wQqEPn+6DT0eS0dzqjS/48iqStn0Yl5kAQaSP9oFma6Yri57JeDEOT+xTfYzG/iMX0c4O4vEjqoWu+DOkcopc0/slSgxLWiT6n9z23GoKtJhGlnJfobz+93s6IrnuwvDGG6Qv+RT+PATUwVxjAF4Ug9pdZTJpEWmqg5DHDQid/VGTmrjqXKu4AgMI+aqgDoKEEhK6BcUX+rovFBhUtziZcx8ggA0hrcnMJTU1JQblLwi7LzRnQa7WzsIk98vYMUOBscIdX8GzXqau23rr2FBbo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39830400003)(376002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2616005)(36756003)(2906002)(86362001)(107886003)(966005)(478600001)(66556008)(66476007)(66946007)(5660300002)(26005)(6486002)(110136005)(8936002)(8676002)(316002)(4326008)(6666004)(6506007)(6512007)(52116002)(38350700005)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1AzQmFCcUxKMkRzQkkwTFIyNW55bVg1Qm5vQlJIa2dhMGR3OFE0bjl4ZDVX?=
 =?utf-8?B?R2JpWW1rWnNZa2MwT2dvdVpEZ3V0NnZ1YnhSelc0ekxFb0NQOWFBMFRQUnVL?=
 =?utf-8?B?dWFjcS9zNzJ3cGlEQklIaDloU0hWMldxaHFZME9RdFgvYTg0czJmdzVwM0pV?=
 =?utf-8?B?RzFKL1dNd1h6VWdCbVFXUUdqaHZaMGlPaTcxV2NLcS9IUDZONVpYd1pvZ3JS?=
 =?utf-8?B?dXFHSFlUVUZTa2hOSGp1bkZ3QkJaQmRKUUduQUh4RTllSERDbkNtd0pBdjNM?=
 =?utf-8?B?NUVST0VQU2tCeFFnZ2lJRlZYdFJWR2NNbU02NUpZc3Z5cXR5RVdWMFpYSXhm?=
 =?utf-8?B?SkIwNThSQ2VpeEYwNm1Za3pkZVJlR1k5QWJ4b0NFQzBKMDFjWHRVb2NMQXZP?=
 =?utf-8?B?bkM2dVhnZUt5QWxzV3lMbHdxVHRvU05NUEFRN3lmUFI3WEJPVzhOT1JOR3ZS?=
 =?utf-8?B?aDN4MU9kNGJjbExzeU55eFoyQkdlTXZMVXFDRy80c2dYOUZFVDVsb0VxY2tI?=
 =?utf-8?B?azhleUZNTFdKOW5UZnF1Mi9ncSs2MTVVS2Z5R3JWL3pGRTZDanZySm8wdWx3?=
 =?utf-8?B?dEZadDJhM1k5cm5lNlVJbytYQmN5cTJIWkh0ZmlSYzVkWEFRT3hEZVljakND?=
 =?utf-8?B?M2syeUdiU3U0bEUycElNd3hNaUpXSkc2aTlBU2ExbkNUWXI2Wkc1anRwbThD?=
 =?utf-8?B?U2d3ZHFvbzhxMmdxclJDRkQ3WjRMRUt0amVpeHVFNnZxcHVjN05YdTlyQjYr?=
 =?utf-8?B?WjBoT09DcDNNY0JuM0FHclgwNFRFQjVzeXN0UHZMMklzMU9MVUtwZVUrdzFl?=
 =?utf-8?B?VXl0QlVMZE5LRUdhMVlNUEx1MGlFY05YVDlvenJOZUFieXNSeDExdnJEUUtj?=
 =?utf-8?B?OVpseXJ0UVZDaGZjSkZHV0d1UEI3MlhQS2FQNUVVSHlzTjBMWklOM1laT3Fr?=
 =?utf-8?B?QXpvRnd6MnJESnVhckhiRlVlWGhWZ1kvOEZ3MUR4Nm9TVTVia0NPMTM0QlhH?=
 =?utf-8?B?SHozdUhuNmw5eU5kcE0zdUhNMUNwcS9EOWVMdHgyVlg1M1RXZ0gyWHk4UHpQ?=
 =?utf-8?B?WnlmRjE2STRrTXI1UG1MZmttUEFENHdkTU1kclJ4R1V4Vzk5MlZEOUN4Q1JO?=
 =?utf-8?B?WVFtdTRhUFp5NC9ZN09Bd1ptcW11U29KRy9OY2lSQWM1RExNbTcxNlpEWWRN?=
 =?utf-8?B?cUJ5YmVubENJckJjNkNGSmtQSnBHSmVWMi8wU2xtYXNhRjhISFNYOTdYRWN0?=
 =?utf-8?B?Q25sM3VNNExTOTBqSkZlcktJVnpsYytPTnRGVDlLNndXWGpOLzYxdDIzN0dD?=
 =?utf-8?B?b0h0QUtRRDBlaDZmV25JVlN2U3RMUEVFcFZsaGw2VFdIZ1grQnpOQ0N2U1hP?=
 =?utf-8?B?NGxVRVRSZ3FQb3ZiRmRHSFdiT0hCQVMrci9vKzB3Rmd5TEtRV2VIVzdoa0U2?=
 =?utf-8?B?NVhaTTJjY0ZjQWNDeTVDQUVRK1NrUUFyU1ZPSW56ZjFSQVZ3UWRGSis5a21U?=
 =?utf-8?B?RDg0Y0dmVHdBTFIyMTNFL1N4RFhvT1FsODdsRURPcnJyblhuMDc2OFMrRWxh?=
 =?utf-8?B?WU90NU9rN3dKa1l0dHNNZm5mQ1FyWk14a2xHQTRrL3hKeDNjSnVVOGd0anp1?=
 =?utf-8?B?R3hnOTNsUXU5VlVYQ3BHbFlCUmJoYzFyb3l1VWd6UnVyY3Z3dDVWWHJ2OVVv?=
 =?utf-8?B?Rkd6c3B3QmhxRlN4YlFOWlBISW85dWIzSXI1bGJmYXpSalA0Wjk4ZWVsZkVD?=
 =?utf-8?B?YTdGWnJKSklEMWVMZmNkS2VxcDAyUzVyTmVpYmg0QmpmajlkUjdGQlQ2Tk9D?=
 =?utf-8?B?dkhrU3ZibjlNZHMvemJmV2RRd0xXVWhMSDJ2alZROUtNeENsRlRycGVTRUFY?=
 =?utf-8?B?NUVWSnFRVWF1ZVJ0OUowM2s2VDlWWGZtSHpUS005SzdTZitoaFdQalBXUTdi?=
 =?utf-8?B?UmtzemR4dkh2UlZEb0Y2bzFsVXZBR1NGWlJ1UzRvMG5QckRkL0ZZMUV1elpX?=
 =?utf-8?B?Y0tCQkNpZlpMRDY1dVQ3TS9jQUpkT1BHdkw4NlNjMmZ4MlpVSVkrMEZCNWh1?=
 =?utf-8?B?ZUpDRU5ydXpHd244aVJESUhEVHlxRG9MTWxrVUhWaTZEK1kxMHZzR2JyVUFD?=
 =?utf-8?Q?xwjWMHK1zx2ot8Kg1Mk1pu/ps?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 089e301f-d86e-4298-cfd7-08dc094e3fce
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2023 15:44:46.3450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpXS3KGk8rRnib8rhb8czROqXF/lhgzEmD1vsplxpfRcX0WDxiOA4yTQtmhe4vtuEsXAfDWPMaWKfbw0uKnMcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6970

Convert the existing txt binding for armada-38x socs to DT schema
format.

Note that the current bindings only document the SoC (armada380,
armada385, armada388). This is undesirable, instead there should be
entries for actual boards.

For now only convert to yaml, the content can be corrected separately.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 .../bindings/arm/marvell/armada-38x.yaml           | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

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


