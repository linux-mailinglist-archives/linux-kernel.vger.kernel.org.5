Return-Path: <linux-kernel+bounces-11612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B810781E8EA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC51C1C2094C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 18:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0B254BD0;
	Tue, 26 Dec 2023 18:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="ThSq8Daf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF5D53E36;
	Tue, 26 Dec 2023 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2WOU/fGFs52kjccNSDrhvGN2X4R/WtTzHn8Qq0NSKgNXcUz603Zp/wMjY5v4akp5wvLFLT5y/De4NAYL7xlaY0GZHNPRRiCnN6Dv0AuJnw+JTAJDTAauxSKEdTfmK3ffA6eORdcJFvgfb2SA84/1fUDmvsxPE0mCsGM9p5Xta2bfXxpCA9RbT+OF52qXSLWn3ZQVo6nv3b0eGdF5JIbzCPyku9ihAnShaqivdBJt+h/qt2LZvYtY1u6uAATxHQ3r7RmyC8ccgumK1En9pL+exozGEDFUBhJ1Ypk2MDfo5x+Cb8hu/U+x6Omngl299g7gJBIt1cwtsVXjftzeC9GGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVv2+HWSJb/Bvvy/FVIMBCe6S2QDYRd1TZN8Ua4xMS4=;
 b=FogAmwdD8GVw97JWjOecgPDyncLWsAB1SGJCRvoetPQBqFnFQ5Ij3v5edORPC3w71exzVDcDz7A6VNFcimAR/OVLP7Cz0P9fEwP73v7QaN4DXChRmY93EykreM7umLhD0fAXCZ9mJRYjV6EpWG+ip6XXZA/avCxCF780u3SqcJDZG5+o3dTdgTnrhNl9jfXdgI5TTh/RxFUdKK16PBFOsn3LT5MH1HyPOEybI2EvqrZydyo9Cyg2ZrALdoQFam6pEQ+5PKAhG/8z+v0pJmzryAGd9AN7VjFVg9WrATIjZIIp6A3nDHyKnHOuISUkGMDopB/SbWc25cdfqxO8XKzMGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVv2+HWSJb/Bvvy/FVIMBCe6S2QDYRd1TZN8Ua4xMS4=;
 b=ThSq8DafzJu8vmO8tqVwu5I15ZNXkJd/XGw2AMgifTbPGU8RUAPdfIyFLRFOSWjtbN1d4NKr+454SVwmhgDgSlfWF+MaTjjlAHtje4UaBWIADSaf/ZecKJrhJHXPZQK97L3dkAJ2Ivtit/Nnx1hdJvz/+7zgk7QiLVIOE0/2mW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB9PR04MB9868.eurprd04.prod.outlook.com (2603:10a6:10:4c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 18:11:53 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73%6]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 18:11:53 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Tue, 26 Dec 2023 19:11:36 +0100
Subject: [PATCH v3 5/8] arm: dts: marvell: clearfog-gtr: sort pinctrl nodes
 alphabetically
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231226-support-clearfog-gtr-l8-sfp-v3-5-fd1ac2d6bf2e@solid-run.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8451224b-a79e-47f6-a92d-08dc063e2392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JApoHpAaMEeX4XuvEZIIrFYNdD8DjlfDfChLHLL+rVp0rNaRyeaimF+el1uPJ74ggsIFXSlwYMyNrsvL8RJC8sAGOQz+/Wbd8KyWGXNjOvyhGMhmvbQ7iVRAPWm4FCIGvmmajepVbUZdIZlZyrcvdsQ05fSBmqQtO4yhI71NStq0bY2JYangOOOwt5Rfk+BFRBzU0XJIxMo3gSXCHxJtJXXz5oOYWczjcukAiNPUHu/jPHwgDJMVdVfOBgQsxUk2MojBAC2owlXoOimYU0KejTBRDgKQ161GWI1aCT2+H37oOm3S3O8rUOEmW44A28dsQXl5qelN/kVDTVBmCZL6JaHjRtzTsO7G6o25F9j+XqBMVBIyEkrKkV70w6igHXCkz/GFLKC4fdXW4D8Z8y3Q4RkjQ5TYRlRQ+iMKbPdFVjnsalXxEb+BiQlNaPAxYcFmJHefSnDR9f7+1Lf3YgpPVMMkiF/9rEZNxnXDCZNmAx/Wr2WUaEiU/HjnzLqOQAaEJBTXExrVPyeb0liT7oaKKGAEgUUw0G2L41T447QWbPkbH7DFuItKVtFOJlv3r1gyrJjnZtWk8gfUzjrU8NImKIZvdUWj6ibSA0eRCmhhT5ZZrwBACjomcpuzbwG1Qx/g
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39840400004)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(26005)(6512007)(2616005)(4326008)(8676002)(110136005)(66946007)(66476007)(66556008)(316002)(83380400001)(52116002)(6506007)(107886003)(6666004)(38100700002)(86362001)(8936002)(478600001)(6486002)(5660300002)(2906002)(36756003)(41300700001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUhmdWQ4Z0F1dUpRQ3E1aE9YUDg3cmRlZTVEL0NpQ2FPQlM5WlEvb0VaRlZt?=
 =?utf-8?B?bEtJZ3VtQWdZYUN6SXdNZ1pHYUdqRWUrUnRWVDFWT3dEWkg3REJ6YWV4S01o?=
 =?utf-8?B?L0owUC9WdXZyUWZTbTZlRURLYW9LN0ZWdnJ2V1ZTUndtVnZ0RUtsM1NJQVRV?=
 =?utf-8?B?SjRlUjl4TlFsMVA4TCtHYUtHcEVQV2MvV25GM08vR1kxcGgweTFVc2pwc0xu?=
 =?utf-8?B?NG9MMEw3SmJtQno2RTZvUkhTVEFSWUkxSGg4a3MvdlFtU2dlS0JWSmEwa2Qv?=
 =?utf-8?B?Y0tvSlljUm5mUVdtVWk4d0tBdW5SVm5KdmRDWGJ3dytzMHlNeGt5M2tqV0sy?=
 =?utf-8?B?WDRNUTk1WVBWVXBjY1NqTDBaQmFZdGl2K0xRU0ZtVTZiVnRTV1d4cnBubXoy?=
 =?utf-8?B?ZTBBRk5EQlRNRXRkNHNubzlHRjdNZTlBVmNXK0pWZ3NvNi85Zkk5NG9Fa0xh?=
 =?utf-8?B?WnV1b21ENURUdTFRWlRxUnVuVGJ1djg0emFYWSswbHJtNUsyUTNMRzZhaFFl?=
 =?utf-8?B?WnBSRkdlS0NSZHUxV0FNK25jdkd4aVRrYUZGUGsvclN2Rk5ESHBNTHNVenh0?=
 =?utf-8?B?QS84K3hHSldtQmoxano4MGZOeTZ1ZnRXYTJDbzFWWU1EbGtoUlVyT3JkWmNF?=
 =?utf-8?B?RWlwNmFJWlo3dll5TmxLcWdkTno2WlArV2ZyZVk2Y00xTjJyNkR1MmNZQysz?=
 =?utf-8?B?RXlyWVRnS09MdnNzSkx3U1B3c1M3OE1OSnluTlAxSkk3cnJTbXVvQ0FnejNQ?=
 =?utf-8?B?YkZ2MGlWYi9nZE85ZkF3Nlg4R3QyNjNGMW11aXNzYURtKzRnK1o0T0FxYnhr?=
 =?utf-8?B?WE1qUGtSQ3VyU3V3UW9BaHJvdFlHa0FYMnVBV2Z0U3o2UFNDdlRoRWxrMmhp?=
 =?utf-8?B?YUV0eFBidktnSTFQdmNMc3NzZGtLQTJIbGg5LzV6OFhMU1hHdmsrK05aazJI?=
 =?utf-8?B?SXlUZm1WWmUzMWE0TXNLaEtoRlpRaXh5akNyNkVxUzlHQWpMSXlvbHR4U0hh?=
 =?utf-8?B?aEIxb1ErRU9QeEY5aFVWc0tDZlBKQU1jM0l2T2JWb0ErNzcxSHV2RlJaYWp0?=
 =?utf-8?B?ZjFEMFJMWDNWOEFLOThTaTZpcEFNdnl4TzhWdkdwMTdiT0MxOTdSWkJtR3JE?=
 =?utf-8?B?TjZ6MzhYNW1yS29YRVNEaGlqUUk0MXRQMHNoMVBNVTBXeFJqQ2JSeVU2RkVJ?=
 =?utf-8?B?OWJQRVAwOVVLR3RxL1A3SGFhUUJvdEgydHlFYldGODFMT05HRXIzTElSb1Q5?=
 =?utf-8?B?ZnZ4L0NuWlMvS0FpZDVmWFFzQnMwUXRuVnR0Q1JiVWpvbisvZ2FHQ1FCd0pl?=
 =?utf-8?B?ZFdORjJnVldKRFpobXRpUUl3VzgxVDNtdWZ4TmZnV1BjSnlDOExwa1RCNE93?=
 =?utf-8?B?VEl0Tm8yUHVNSzZrZ3hyUml1Z3gxaEhST25LMnU1MEZQWkJ2U0FHdTNDSFNE?=
 =?utf-8?B?eFU0eEtyL0hpdmtmRUZobm51RU5VQldzL0hXWVBpUDRyRW5tcE9rUStEbjNn?=
 =?utf-8?B?RzB0NENkOGFlTzVhU3EzUVgwQjMvSEJMakZJUjhibU9tRnorbFp6RkZHTC9O?=
 =?utf-8?B?QysyMjJ5TzVkOU4rR1pkTnAramhscGxhTDk2bHlkckcyZ1VzQjAzN3hQVmkw?=
 =?utf-8?B?SjdyWEozdlJteDZPajRiM0FpclRPVUpxdTdSVkJHVEZEVmZ5VXVndGFaK09K?=
 =?utf-8?B?Q2p0M0JUN0VzWVJIT1A4Zm5YUFR0cmQxZ2xFOXNhQW9Ib2ZMNkxqMDYyeVFD?=
 =?utf-8?B?cXNPYjhtUVg4MjBHT21YTjgrR0Y4eGVpaGora2ZhUkRGM3NXcnV1UFNXKzlp?=
 =?utf-8?B?dGlqYVhrRU9UNS9qeFI1Qi8ybzZtV3hIU1ZVYm1CUThmTjY5KzNnSTY5Y2Ro?=
 =?utf-8?B?a083Vld1bEwwVzdnMDNjaFVpUXBleFI5azBTS0R2bTNvTUZHZkxUZkJ0QUIw?=
 =?utf-8?B?WGdLY0tCODFCc0JWU21WWnBWZXlST3N6Zm1MUVFQWmt4Z3ppbWRON0xqWXdC?=
 =?utf-8?B?KzFEV2FvdTlaRllpVFMwQTZ2SFhYdEpoRm9LTEpuU0lzRU1HYkNhZWtUR1ZF?=
 =?utf-8?B?Vkc4ZXNsMS9uV1RSVDhXZURtTmxXS3FwMlk2OEtxSytEaUNrRFJWUXhNQmtx?=
 =?utf-8?Q?XDG4C/EOmdVKJ+N8U2SWOliRS?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8451224b-a79e-47f6-a92d-08dc063e2392
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 18:11:53.5398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTZznWzuIkmVCUG2CVMSq/2qJdq7niHB/lYaQnzuehdqyR5fcNbJPOCAOCdXOd61A2oKlkBg2weHgPhgjOa38A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9868

Cosmetic change to increase future patches readability when adding new
pinctrl nodes.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 .../boot/dts/marvell/armada-385-clearfog-gtr.dtsi  | 40 +++++++++++-----------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi
index d1452a04e904..8eabb60765b0 100644
--- a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi
+++ b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi
@@ -141,18 +141,13 @@ i2c@11100 { /* SFP (CON5/CON6) */
 			};
 
 			pinctrl@18000 {
-				cf_gtr_switch_reset_pins: cf-gtr-switch-reset-pins {
-					marvell,pins = "mpp18";
-					marvell,function = "gpio";
-				};
-
-				cf_gtr_usb3_con_vbus: cf-gtr-usb3-con-vbus {
-					marvell,pins = "mpp22";
+				cf_gtr_fan_pwm: cf-gtr-fan-pwm {
+					marvell,pins = "mpp23";
 					marvell,function = "gpio";
 				};
 
-				cf_gtr_fan_pwm: cf-gtr-fan-pwm {
-					marvell,pins = "mpp23";
+				cf_gtr_front_button_pins: cf-gtr-front-button-pins {
+					marvell,pins = "mpp53";
 					marvell,function = "gpio";
 				};
 
@@ -162,13 +157,6 @@ cf_gtr_i2c1_pins: i2c1-pins {
 					marvell,function = "i2c1";
 				};
 
-				cf_gtr_sdhci_pins: cf-gtr-sdhci-pins {
-					marvell,pins = "mpp21", "mpp28",
-						       "mpp37", "mpp38",
-						       "mpp39", "mpp40";
-					marvell,function = "sd0";
-				};
-
 				cf_gtr_isolation_pins: cf-gtr-isolation-pins {
 					marvell,pins = "mpp47";
 					marvell,function = "gpio";
@@ -179,18 +167,30 @@ cf_gtr_poe_reset_pins: cf-gtr-poe-reset-pins {
 					marvell,function = "gpio";
 				};
 
+				cf_gtr_rear_button_pins: cf-gtr-rear-button-pins {
+					marvell,pins = "mpp36";
+					marvell,function = "gpio";
+				};
+
+				cf_gtr_sdhci_pins: cf-gtr-sdhci-pins {
+					marvell,pins = "mpp21", "mpp28",
+						       "mpp37", "mpp38",
+						       "mpp39", "mpp40";
+					marvell,function = "sd0";
+				};
+
 				cf_gtr_spi1_cs_pins: spi1-cs-pins {
 					marvell,pins = "mpp59";
 					marvell,function = "spi1";
 				};
 
-				cf_gtr_front_button_pins: cf-gtr-front-button-pins {
-					marvell,pins = "mpp53";
+				cf_gtr_switch_reset_pins: cf-gtr-switch-reset-pins {
+					marvell,pins = "mpp18";
 					marvell,function = "gpio";
 				};
 
-				cf_gtr_rear_button_pins: cf-gtr-rear-button-pins {
-					marvell,pins = "mpp36";
+				cf_gtr_usb3_con_vbus: cf-gtr-usb3-con-vbus {
+					marvell,pins = "mpp22";
 					marvell,function = "gpio";
 				};
 			};

-- 
2.35.3


