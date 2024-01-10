Return-Path: <linux-kernel+bounces-22241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4107829B52
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9AF1C21E64
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E63E4B5C0;
	Wed, 10 Jan 2024 13:32:36 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2051.outbound.protection.partner.outlook.cn [139.219.146.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F181E4A9AC;
	Wed, 10 Jan 2024 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JPtrEEdrFwLPB+ZtK6YWa3nSgfsLiEoB8nAif0uCS6iiAsz3YDbZvEENjwjkSw5eSNd9jKQdF6wBQXzUjKMQS0G5WYGBI8lqatu3LJvGSGNt5UmcRC07R3M6BCGrsSMIEZ51pm5nwE+54Co9G+f0jzPntsVkJRm32b4ACJ/Zo3c5hy86naoOUpqfuXZTmLljx2Lh9NPHeJfAXudi164h9wKTKChY7ROrooW/o1NXE9YZsHQo64CVTXKzlIR5mOkkNnwYAAK3HK9zQcsNeWdyiBYzPoHCO4Zn5FslZfpjAa5F6To+TxbCRal888H5d+VwH2biAOSFVB9e5/vKxqn4Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AYcpDZUu1D3OVsJJN37tZ+6we1npeB3N3ndEhOmXLs=;
 b=jYRI0zNyG6VFyLtN2KuwqibCyEUxYuztX12Whc+SfzbHbVdWwlESK+RDV+L/RTwkgUb4FtX+rvnO89rc6XYZLL6tmt/7ctxRgxJ6cHJ8cavBTAXZwzgqIjJh6JmbXUZ8iOnHL3IQBjhdIXl0HEOejXcA7QKVbZU/GFxjrondFe+6I3APM4S+ji6w3a5ynmZPDT6UeD322BD5H3P7rPYsLnU17v943ra2IqJ4cPQQXTSB4VHr2KkUlKrKGOfjpGQvmQbcNW7Vt7ruHXZocKtDNGZXc4+RKQiH4aKp+C1yfpD8XXKGE7i5bx8kinYh/OSBY8ag5VbQdEjiz2eAQ5GWwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0626.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:10::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.33; Wed, 10 Jan
 2024 13:32:30 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7135.033; Wed, 10 Jan 2024 13:32:30 +0000
From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
To: kernel@esmil.dk,
	conor@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	emil.renner.berthing@canonical.com,
	hal.feng@starfivetech.com,
	xingyu.wu@starfivetech.com
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	jeeheng.sia@starfivetech.com,
	leyfoon.tan@starfivetech.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFC v3 13/16] dt-bindings: clock: Add StarFive JH8100 Always-On clock and reset generator
Date: Wed, 10 Jan 2024 21:31:25 +0800
Message-Id: <20240110133128.286657-14-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110133128.286657-1-jeeheng.sia@starfivetech.com>
References: <20240110133128.286657-1-jeeheng.sia@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0067.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::34) To BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0561:EE_|BJSPR01MB0626:EE_
X-MS-Office365-Filtering-Correlation-Id: 57cb3b5d-0511-481d-d05a-08dc11e09858
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mRds0sP/d70rTNftt02g44N7/qOAsi0wvP65EdZx7B3LzkKm3erLfvLLz0s1Qm9CCJBNJZZl7CmfZfUCIDIh2pCXR4oM5X/aCXKi0MR98gxkUsiR0jN7J702ZCBdDlGRmW4pZx+9haRFK9Us88nP2parb5x3UaJ4uKmB+ucDf6xR7T2mbH5n/PKC5sqBis60n7y2/Ky7imL3A0F96FePkiTXNax3jc1ugeJ+1S9mkuj0O/1OMKHgfHzpgZQB+edhtjSnPILwfmfiAjulJBQ9kRXjwCVV9NG/fQgXMInpojlugarNqT6AhZ8m5rQ9XRkKTysGvyPRrb0VDt5g7uhBNIfIemzU/j5Xu2s4Agzu4XKmAR+jEDb7uDddKJ49F9WmRR8FOJgBk5mU2gs6Za2NwysfsPACAwe28P9dWsI5r+oMEQaH3Ush8jDDfN6Z5C7oLpuokIIiwShp9eh23CF/bOa6CHhUVsoIf+NwmeldX5sOZd3+krJjB2vASz9PgjcDD8cKUwOfL4jKmoR9nYQz4I+vcMHe8dtZUQXOncvAKN7/Nn2X+LH0XR2Yu9Q65UZP/CKida0EXaj8OvEmpxLgGg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(136003)(346002)(396003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(921011)(26005)(52116002)(2616005)(41320700001)(6666004)(83380400001)(1076003)(86362001)(40160700002)(40180700001)(38100700002)(36756003)(38350700005)(5660300002)(7416002)(4326008)(55236004)(6636002)(66556008)(66476007)(66946007)(41300700001)(2906002)(8936002)(8676002)(966005)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+amrCg5e5ccY0jARzpMSATp+bU9haiZI1boxMXg1Ho1DT2RNZJ+ip97O+L53?=
 =?us-ascii?Q?rqB+kiVarP1XLqGWBxRdQ3XOUiu9zJBb4QXz6WZOyVJJSe2eFtZC/R9UGKmx?=
 =?us-ascii?Q?QM7f6QR7MlsFVSSDGgHxSqaigMrJF8CM0Ot1PqnSseexsP16Ca4PPAW83nmF?=
 =?us-ascii?Q?zfKb7f4S9G42G//mIU2gSV4yZ+uDbXriKcuTDOUg7R7/deQAMTgFZIyUzTKT?=
 =?us-ascii?Q?/CmTnX0TDdZkZUJX1AiW/WBOBPdPyThFlYR66uQ+DligmVC9dx+bAY5g1L8b?=
 =?us-ascii?Q?Qz6rqU19lG9RlViC2yep0oHmlM2Mn+FXdaTtFvInqmcX603M47KVrr2/GhEX?=
 =?us-ascii?Q?EzHEROLlo24gcYN60BdKV90pyzb0OqVM+vEKUaLR/lN7S/QMYnKOjM5Ugz6W?=
 =?us-ascii?Q?eEVLnIPj7tgkyKVCQIGPB9+uJpAys82el/jUHsGnFzRrWEti7zorEm5q1aPS?=
 =?us-ascii?Q?SMlGTAAXNrqgoc5luar+5QIIf2uDAZVBo5K+3XyRscSnQ4Tof+AUY6Kjxfym?=
 =?us-ascii?Q?wfwwMs7d+tIY9eXz4n/dotEt9lZJu4gk42WQuq5kF5jNYpluS1VWXUARkbGW?=
 =?us-ascii?Q?4TjzzrYlf80JQhZL1WhzCOqFV47uXsDyjpDrnoE7VvrkB9Txp6BvghjwlVNm?=
 =?us-ascii?Q?N/DPBBI1wbyzFnOdtnVGixs6xW0Fz/TRPZ6proPBxV4dNhpxmoSSGJRhgPnv?=
 =?us-ascii?Q?zSgrEqRFCL+xEbl4C+Uwd7gwhJdCoSy2my+tV5h1bZMpznbAENNNO06Cr2H/?=
 =?us-ascii?Q?rJ32heE2li5ZyPnZ+rPnZ51doDXgdYcm5/zhbilHirzUH1iU4arSp1SMRL9y?=
 =?us-ascii?Q?qd0X6B+fQfIjiLimBo8+v+7qFXSq5I1IFJjV0fyHskalZEsRCAzHDjzIkuAq?=
 =?us-ascii?Q?wQiBnb7q2zku5I+GBP/QZXKAJCzcXEBf1D4z1WXdeCHVeau74hE3WOmqBjOs?=
 =?us-ascii?Q?+vYoAdN4VpbiSSwIQ2P56aFFBvHUGPC8aTyCx8ECOSj9O5C+ZHsRGUkOn1l3?=
 =?us-ascii?Q?do70sq95NeSvkXnxp7k//3wtP2/ALgcBWY/qdL8Jl+FGQBofqZq+hJ7nOU1r?=
 =?us-ascii?Q?gTs/JUKdYrZSUSjpJovkiJiUsaXZiSmRxBO5pGfx/vYkwH9R+3zoj3uYbsdW?=
 =?us-ascii?Q?wuxAKru7nIvPUahFpw8BMNpNXoRwS1uhiNsOyBDFS7wyFj/tyQnoeGReV0mb?=
 =?us-ascii?Q?K3VN2LKG5QAkwVKhOM4wLya1r2WC7fDpuxHRFOQ+dXhs6T46jpjf/rhgib9r?=
 =?us-ascii?Q?Blw9Ym8017vIfdc7SzLGFi9g9UIp7q+doo7Vw2BlhqdG61GCH4rdUR88FnQT?=
 =?us-ascii?Q?ZbCiXBLIqpJCGgjaPdeXZsGOhwoQ7/YxDnkFIDiWr2vXEBNaKutVai1AvcvE?=
 =?us-ascii?Q?yQVtWdebzs2poae4R1lkVa0VvmhUZrDq8fIgBkcDxrwNkIesLkfg4SZUwb+T?=
 =?us-ascii?Q?H3kS9bs+K3p+PwfQlpERg3jI3rAm5V0fol89oMIvDquUJJ5geNlqDMX02mfk?=
 =?us-ascii?Q?wBji1KOFMWB4laV7tz5lV+BZX5EvHY8tapl6oaj8LmYcd/gJnBFGFV7N/sgT?=
 =?us-ascii?Q?pJ5xRrLPowmRJq6hGzhl6DCsEPQXa4RlhZ0gG+uvxBs8qxmvoWmR8sUhVmCa?=
 =?us-ascii?Q?343vUCliX8WuDwNtjm8ZUgk=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57cb3b5d-0511-481d-d05a-08dc11e09858
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 13:32:30.7860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BlY7QjgkEdkRrEboVRw5Y7sAE6CJzRbbS+uqkSo8B42aawIP2mwt/vhZc3ziCklVJIuAXY7Tt7GbLO+oTFvsTbfbQlTg9aBN02l4/S4uLKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0626

Add bindings for the Always-On clock and reset generator (AONCRG) on
JH8100 SoC.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../clock/starfive,jh8100-aoncrg.yaml         | 74 +++++++++++++++++++
 .../dt-bindings/clock/starfive,jh8100-crg.h   | 67 +++++++++++++++++
 .../dt-bindings/reset/starfive,jh8100-crg.h   | 16 ++++
 3 files changed, 157 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh8100-aoncrg.yaml

diff --git a/Documentation/devicetree/bindings/clock/starfive,jh8100-aoncrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh8100-aoncrg.yaml
new file mode 100644
index 000000000000..4ae1ef827fc9
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/starfive,jh8100-aoncrg.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/starfive,jh8100-aoncrg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH8100 Always-On Clock and Reset Generator
+
+maintainers:
+  - Sia Jee Heng <jeeheng.sia@starfivetech.com>
+
+properties:
+  compatible:
+    const: starfive,jh8100-aoncrg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Main Oscillator (24 MHz)
+      - description: GMAC0 RMII func
+      - description: GMAC0 RGMII func
+      - description: AON 125MHz clock
+      - description: AON 2000MHz clock
+      - description: AON 200MHz clock
+      - description: AON 667MHz clock
+      - description: RTC clock
+
+  clock-names:
+    items:
+      - const: osc
+      - const: gmac0-rmii-func
+      - const: gmac0-rgmii-func
+      - const: aon125
+      - const: aon2000
+      - const: aon200
+      - const: aon667
+      - const: rtc
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/starfive,jh8100-crg.h> for valid indices.
+
+  '#reset-cells':
+    const: 1
+    description:
+      See <dt-bindings/reset/starfive,jh8100-crg.h> for valid indices.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/starfive,jh8100-crg.h>
+
+    clock-controller@1f310000 {
+        compatible = "starfive,jh8100-aoncrg";
+        reg = <0x1f310000 0x10000>;
+        clocks = <&osc>, <&gmac0_rmii_func>, <&gmac0_rgmii_func>, <&aon125>,
+                 <&aon2000>, <&aon200>, <&aon667>, <&rtc>;
+        clock-names = "osc", "gmac0-rmii-func", "gmac0-rgmii-func", "aon125",
+                      "aon2000", "aon200", "aon667", "rtc";
+        #clock-cells = <1>;
+        #reset-cells = <1>;
+    };
diff --git a/include/dt-bindings/clock/starfive,jh8100-crg.h b/include/dt-bindings/clock/starfive,jh8100-crg.h
index 7b337c1495be..8207d5a2f4b3 100644
--- a/include/dt-bindings/clock/starfive,jh8100-crg.h
+++ b/include/dt-bindings/clock/starfive,jh8100-crg.h
@@ -351,4 +351,71 @@
 #define JH8100_SWCLK_JPEG_ICG_EN					8
 #define JH8100_SWCLK_VDEC_ICG_EN					9
 
+/* AONCRG clocks */
+#define JH8100_AONCLK_GMAC0_RMII_REFIN					0
+#define JH8100_AONCLK_GMAC0_RGMII_RXIN					1
+#define JH8100_AONCLK_GMAC0_GTXCLK					2
+#define JH8100_AONCLK_AON_1000						3
+#define JH8100_AONCLK_AON_400						4
+#define JH8100_AONCLK_AON_400_POSTOSC					5
+#define JH8100_AONCLK_AON_500						6
+#define JH8100_AONCLK_AON_500_POSTOSC					7
+#define JH8100_AONCLK_XSPI_PHY						8
+#define JH8100_AONCLK_AON_100						9
+#define JH8100_AONCLK_AON_100_POSTOSC					10
+#define JH8100_AONCLK_AON_50_POSTOSC					11
+#define JH8100_AONCLK_DDR50_POSTOCC_ICG					12
+#define JH8100_AONCLK_DDR100_POSTOCC_ICG				13
+#define JH8100_AONCLK_PUFRT_APB						14
+#define JH8100_AONCLK_RTC_HMS_APB					15
+#define JH8100_AONCLK_RTC_INTERNAL					16
+#define JH8100_AONCLK_RTC_HMS_OSC32K					17
+#define JH8100_AONCLK_RTC_HMS_CAL					18
+#define JH8100_AONCLK_GMAC0_AXI128_AHB					19
+#define JH8100_AONCLK_GMAC0_AXI128_MSTRCLK				20
+#define JH8100_AONCLK_GMAC0_AXI128_AXI					21
+#define JH8100_AONCLK_GMAC0_RMII_RTX					22
+#define JH8100_AONCLK_GMAC0_AXI128_TX					23
+#define JH8100_AONCLK_GMAC0_AXI128_TX_INV				24
+#define JH8100_AONCLK_GMAC0_AXI128_RX					25
+#define JH8100_AONCLK_GMAC0_AXI128_RX_INV				26
+#define JH8100_AONCLK_GMAC0_GTXC					27
+#define JH8100_AONCLK_XSPI_AXI						28
+#define JH8100_AONCLK_XSPI_APB						29
+#define JH8100_AONCLK_XSPI_XSPI_PHY					30
+#define JH8100_AONCLK_TVSENSOR_PCLK					31
+#define JH8100_AONCLK_TVSENSOR_TSADC					32
+#define JH8100_AONCLK_TVSENSOR_BG					33
+#define JH8100_AONCLK_MEU_PCLK_AP					34
+#define JH8100_AONCLK_MEU_PCLK_SCP					35
+#define JH8100_AONCLK_MEU_MEM_AXI					36
+#define JH8100_AONCLK_AXIMEM_128B_ACLK					37
+#define JH8100_AONCLK_APB2BISR_APB					38
+#define JH8100_AONCLK_APB2BISR_BISR					39
+#define JH8100_AONCLK_EMMC_S_PCLK					40
+#define JH8100_AONCLK_EMMC_MSTRCLK					41
+#define JH8100_AONCLK_EMMC						42
+#define JH8100_AONCLK_EMMC_SDMCLK					43
+#define JH8100_AONCLK_EMMC_SDPHY_PCLK					44
+#define JH8100_AONCLK_SDIO0_PCLK					45
+#define JH8100_AONCLK_SDIO0_MSTRCLK					46
+#define JH8100_AONCLK_SDIO0						47
+#define JH8100_AONCLK_SDIO0_SDMCLK					48
+#define JH8100_AONCLK_SDIO0_SDPHY_PCLK					49
+#define JH8100_AONCLK_HCLK						50
+#define JH8100_AONCLK_ACLK						51
+#define JH8100_AONCLK_PERF_MSTRCLK					52
+#define JH8100_AONCLK_PERF_SLVCLK					53
+#define JH8100_AONCLK_GCLK0						54
+#define JH8100_AONCLK_GCLK_OSC						55
+#define JH8100_AONCLK_RTC_ICG_EN					56
+#define JH8100_AONCLK_GMAC0_ICG_EN					57
+#define JH8100_AONCLK_XSPI_ICG_EN					58
+#define JH8100_AONCLK_TVSENSOR0_ICG_EN					59
+#define JH8100_AONCLK_MEU_ICG_EN					60
+#define JH8100_AONCLK_APB2BISR_ICG_EN					61
+#define JH8100_AONCLK_EMMC_ICG_EN					62
+#define JH8100_AONCLK_SDIO0_ICG_EN					63
+#define JH8100_AONCLK_TOP_ICG_EN					64
+
 #endif /* __DT_BINDINGS_CLOCK_STARFIVE_JH8100_H__ */
diff --git a/include/dt-bindings/reset/starfive,jh8100-crg.h b/include/dt-bindings/reset/starfive,jh8100-crg.h
index de4f25dc301d..23f15d4be22f 100644
--- a/include/dt-bindings/reset/starfive,jh8100-crg.h
+++ b/include/dt-bindings/reset/starfive,jh8100-crg.h
@@ -99,4 +99,20 @@
 #define JH8100_SWRST_VC9000D					2
 #define JH8100_SWRST_DDR_TVSENSOR				3
 
+/*
+ * AONCRG resets: assert0
+ */
+#define JH8100_AONRST_AON_IOMUX_PRESETN				0
+#define JH8100_AONRST_RTC					1
+#define JH8100_AONRST_GMAC0					2
+#define JH8100_AONRST_XSPI					3
+#define JH8100_AONRST_TVSENSOR					4
+#define JH8100_AONRST_MEU					5
+#define JH8100_AONRST_AXIMEM_128B_ARESET			6
+#define JH8100_AONRST_DFT_APB2BISR_APB				7
+#define JH8100_AONRST_SDIO0					8
+#define JH8100_AONRST_EMMC					9
+#define JH8100_AONRST_TOP					10
+#define JH8100_AONRST_IRQ_CTRL					11
+
 #endif /* __DT_BINDINGS_RESET_STARFIVE_JH8100_H__ */
-- 
2.34.1


