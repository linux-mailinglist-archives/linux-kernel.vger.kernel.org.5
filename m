Return-Path: <linux-kernel+bounces-19090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3248267C4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 06:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3DC61F21A96
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 05:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7188813;
	Mon,  8 Jan 2024 05:29:25 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2072.outbound.protection.partner.outlook.cn [139.219.146.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF87B79CD;
	Mon,  8 Jan 2024 05:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IroX4JULUpfLHLyYz6QH9uJDOPRSEWPE5PsHodo5dsxZ56Wmdqh2nLQPSV4xONvuLQHAI8VcDIaf8wdZyEumQP8wkvCqBOo8GI6f0+lGo6fMH1nxx6uH9DcUsws1X+acA30GSNDeiUFomyLwy+QU0xwafHRWZIGQ17YC5QNbG9lb8OKeuk8iz0DxXUijL6MagENYqRQem4v/zWM+pWkwls4mU/fhKtUPkrkqFhMkdenf8zxWlIpGvzyLILF4gg4Owf+U/CcGJTtij87rngIixQK+2sgUWV1vMmWWM5y5TqtxhFFqljhBdHdehpsjINl21ru9zBL/prx4szqqbPx70A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSRDRy2je5bhVbk5SpBOU+QZvxmILXFmOs+ZSfUHP/U=;
 b=gbeXQTua+V768/q4NPiTUxK+Xsyl7Hm/dp0e9WjDpG0rRdZf19Xe7tCoWoKeB1m5RmWlOwqf2W9lVt01ypFqH/0glvaVQqJnzwJovDdGfgXAX6sTXuSQkz8y48DoSR+2eDEwmIyAB9VWv7WGs3LNlBNK+23R1xjQK6QjS+R+yAa/BcWIeqvmqNphv48tk14u2eVUk7iR1f8DHYixn0yxoSTgAyRSSxPO0bxgahpPj4seUXBP7r0lM3TJZbf5LRkWMTrpGlkmW16btiJokZTkVayma7SEkUP234Jg7uFTLIsC1zzkjt2e8ZWRA2cvh9oUYcdu480xyUeiY6W6htHzOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6) by ZQ0PR01MB1032.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Sun, 7 Jan
 2024 23:57:49 +0000
Received: from ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 ([fe80::1dbb:b090:7d89:4e22]) by
 ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn ([fe80::1dbb:b090:7d89:4e22%4])
 with mapi id 15.20.7135.032; Sun, 7 Jan 2024 23:57:49 +0000
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 RESEND 2/3] dt-bindings: perf: starfive: Add JH8100 StarLink PMU
Date: Mon,  8 Jan 2024 07:56:56 +0800
Message-ID: <20240107235657.2372910-3-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240107235657.2372910-1-jisheng.teoh@starfivetech.com>
References: <20240107235657.2372910-1-jisheng.teoh@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0015.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::9) To ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:19::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1160:EE_|ZQ0PR01MB1032:EE_
X-MS-Office365-Filtering-Correlation-Id: 3579df1f-3697-4d41-6d32-08dc0fdc73e7
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0ZaQ3Rr0SUcfPcyIW5YgFWJKmf9HhpzfpgiXV+VVCnlJKNik0iX/zT4ZlM4rc6rU3lBAoh4NBAC46qfRH/tl1iD8ri5PempP3lPDnGJVdGYqXDspgRfxEji4HG0ab+nXapbKRMEMpD6G+xD7ycd8nIAOEvUv2SOGd4CUyMKMPT+5Xa/aiu/2ZiFPsR/vjCLxvGr6mA0fR1IjWIDUVTGBgrrCtzsr9QvYoE/2Yq7Z0HAjOYgbPgDLB+PyrArcvZqrw3AdLwr38cEIPOJ60ShQc54OyAxs+KcQwyfKMl8wdjxSgyv6a8luozK3lG890iEwgIysx59TaMoQcfAgEf9gyS9CRBgcN3emvtgPtFgPmhh4kia3HTC7e1DUxYTc/flDXnsHATSOKu5snjh9IQ7iOIpJcyqTWKuNAdc0w9fFftT9O5q7+x38q+CQMY4aWcL9O+9qZEL0PsHMWKjuueNcbgjZnyOi9wWWpOcf8FkVfUPD2Eyz9bwkuKEilVyAXr2VRUvB8cUhYJjZxkiYShC6canjzcYKheBTU3SKah/MZ2fJ80QdWRh2vcFM3LLL8cWEKMaFfPNsnxKOOkniaSyTdQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39830400003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(36756003)(38100700002)(921011)(38350700005)(86362001)(83380400001)(508600001)(41320700001)(8676002)(4326008)(1076003)(66946007)(66556008)(40180700001)(110136005)(2616005)(26005)(8936002)(40160700002)(54906003)(966005)(52116002)(6666004)(66476007)(7416002)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qVTvYjkugeprOCKvgWdUvmjzdhcrMQiYIpVPBnz/FaP+4VnjNsd0ntq8gckm?=
 =?us-ascii?Q?fNNWEOB5gAaHMlYw+iYt0LsVGUEjoBIgiBkeJhbei3xrmiTqI1M+kT3TbXJ5?=
 =?us-ascii?Q?X/KF+PBXjFEGJ20vcvA1ORiDPw1Ux9PVIVg3LL9hTQ26OlaR6uGiUdtvdD0r?=
 =?us-ascii?Q?JMw20syZS5yc4qa6gKqg2VyV+A4TJ5JCcB8dpXYUnsE69bDcN9Vs16Qp4I51?=
 =?us-ascii?Q?so1Cl1oFAwDYEPR1EY3UUgjv2j9UHexk8U29Ln5GFOpYdLDKbu4RHFQ1bYgB?=
 =?us-ascii?Q?mVJyQuZaJFPiWG1E36ug4XW4PQlsTto8M4aIT8bchsCQNWb5rg2oGoUM44gp?=
 =?us-ascii?Q?7C1BUo6tlazd4lgQE9jcq3Yd44In8IM3FZf2MscOt/5dhjwXGoQWNbgYxyRf?=
 =?us-ascii?Q?jUC2DFdveoT5umxEp1m4iWRH03lN1mcLm+HUNRYU8PWn0kzPjjLVyDQ4y8S/?=
 =?us-ascii?Q?ddZHRqRAJrOsfvijzMBRrxQczkEs+U13heI9RjYdsha6YX0TlOMx7pbfDAHE?=
 =?us-ascii?Q?Ykw44DTtyUSETjxmq+NY07eOOZ2KPYPlplF2I1lqHsjCSJlg7fMYsMX20UPr?=
 =?us-ascii?Q?KvrOOoAdILTMi4w3VKCtJ6FxNgB6GPW/GSL5/6or0FYduGGkdkhW4pRE0p6e?=
 =?us-ascii?Q?K7zOKnd+sT0eTSU4eJh4Va2N8tWquFcK0mhBoM9vGH30t71Ll2T1KJccE4Oc?=
 =?us-ascii?Q?4IsjpnnhJWWqW3Wi+VEhuou4K1Ww1Lj0GAvJz/262XM96J3V6azD7NFhr11B?=
 =?us-ascii?Q?O7M1hoN68AqCGkgbWJpecwP7cWXPm2eDbRkyquI7ZdaAEoaikkOJeEpNcWc6?=
 =?us-ascii?Q?BAkvht8vPoOkku4a6aQSv/2WGjqxq9hmaNKKKPX3HdbkYdlonaUjDeioD7yh?=
 =?us-ascii?Q?CZwP/IfxAi5OX06x7rr5tWQKss8eJP+jzVZ+ugrTFx33uzv1CYnD9xpQGGUq?=
 =?us-ascii?Q?3kaafumkSftKFPOM+8wkCoH36NvqNg+hAIJlfq1l99jtC3SBGWRmNBNyj6ra?=
 =?us-ascii?Q?H2CxswCoEvyu0/sYU99v5DHI6hNk0e9qmIEHnyL5kgFyd258kSVCBP2auntK?=
 =?us-ascii?Q?XC3PPy2fNnNhbdPQeUsD2tOt5sl+vm417HztXolVKBnQoptv2l+SikEmM7nO?=
 =?us-ascii?Q?v9du1IdXHX3wYMXZXinHJQCNTL0Kp87EUTFFZB/LP4MBM0yMsLJFmC1+KQnD?=
 =?us-ascii?Q?9THbZc7o6YgDebYZPc9TvXpLzpC82j4EpASEbWO68ncMFSZymS1bYKqwPa+u?=
 =?us-ascii?Q?bWI2SGBsgxls8hcJODuiXIIixHFnWXh4gPjhhjW0Uh0ow70X4lOYWIsC1mHQ?=
 =?us-ascii?Q?SDWHXbPGMTdOlcjAt3b6YeCP1UjzlwU0Y3VX1uFpgkdtbJQuPmBxTpYcSSVN?=
 =?us-ascii?Q?y8v1uRHbTmRVNjKmuhRkZQEWQj5wtcDsKe4ZrUfwxYqw4eYy3miqzO69x1dC?=
 =?us-ascii?Q?4Cvts7vpozhTjzAjolOauruhQ2gLrcXk+D5R7zNXAFBPp0XKM7y42HqW6wPm?=
 =?us-ascii?Q?qWd+EQUaLDzZfi6U59Okn0CTkNaN+bZ7ShpCx0zG1hIbnqkJFCDfBIzP8zbD?=
 =?us-ascii?Q?KzYb6iHJN5nJxAcs5+lY6VPegrgZbr4ShZ7NhIoQF1QCstYsGl0QsGQUXpp+?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3579df1f-3697-4d41-6d32-08dc0fdc73e7
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1160.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2024 23:57:49.3718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eJ7JsP5+rtU0LJbGrz5xpHYcPezdCUZfMCbFGx41hPz+PfDAK++iEy1uXm2fRaWPao6njRUXfyGYJCOOwSORhbQDBIXrlJstPHSPlYqaJkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1032

Add device tree binding for StarFive's JH8100 StarLink PMU (Performance
Monitor Unit).

Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../perf/starfive,jh8100-starlink-pmu.yaml    | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/starfive,jh8100-starlink-pmu.yaml

diff --git a/Documentation/devicetree/bindings/perf/starfive,jh8100-starlink-pmu.yaml b/Documentation/devicetree/bindings/perf/starfive,jh8100-starlink-pmu.yaml
new file mode 100644
index 000000000000..915c6b814026
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/starfive,jh8100-starlink-pmu.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/starfive,jh8100-starlink-pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH8100 StarLink PMU
+
+maintainers:
+  - Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
+
+description:
+  StarFive's JH8100 StarLink PMU integrates one or more CPU cores with a
+  shared L3 memory system. The PMU support overflow interrupt, up to
+  16 programmable 64bit event counters, and an independent 64bit cycle
+  counter. StarFive's JH8100 StarLink PMU is accessed via MMIO.
+
+properties:
+  compatible:
+    const: starfive,jh8100-starlink-pmu
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pmu@12900000 {
+            compatible = "starfive,jh8100-starlink-pmu";
+            reg = <0x0 0x12900000 0x0 0x10000>;
+            interrupts = <34>;
+        };
+    };
-- 
2.25.1


