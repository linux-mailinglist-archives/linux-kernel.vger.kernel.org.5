Return-Path: <linux-kernel+bounces-17066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615948247CA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86CA2B22BA4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D712D04E;
	Thu,  4 Jan 2024 17:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="CynSgYzK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2083.outbound.protection.outlook.com [40.107.8.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDDA2D021;
	Thu,  4 Jan 2024 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAq5ewOhI7QyVylVf0dCwoRlgOdyIjVPQUtnuBLHT48qLITlKTG3VAXruUz4W+EdIaXvjNrnhGtoZ/H6SNfsHjP/ZmK0zXg3/stflot9UyfqIVoTZXWxI05JOfiRwjf1lRWZTAxXijd0tVq3kcxIahOwQZ96VKLNr7oDrrQ9R7EsWDIVJIzrDGoCxpZydVgWg+ymisdY2WcKyHDZHhuWgB1FjWmJgGxrAVVFJ60SoOhkDTMrXk6fipcrumx6fi+5wPI2F4vU7WPjIsxD71U2s5SXNzf32hNfNz7/MXQoiwtcdA84EKde2C7ul3xB0wekzdYN13JK+pyeyaZD1j5UPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVv2+HWSJb/Bvvy/FVIMBCe6S2QDYRd1TZN8Ua4xMS4=;
 b=C6kdN8flxxppMRZ+rDXpjMmDelNaghhb0PtcSWwcDaoQ3dhSIdtr/sf90o+FMFIuqxZJLvxT3HoOoIg1tU27C3+TcFxyZ4dvKIvsCKvKcD1ub7fCHjmpVKJFJwwZNVEWjIJv0sSkV4joKl1I80U0XPxLjf2vsqyggeTcyFNn8ZBTGTjSLhbiYxnQJqRyTDV1u4zTOwkVbClxmhNdDd5Fs9eMJ8rG8rS6vqKuiWSXIZYTU3ib9D26jgp6Sqw9nm/haI1aGs/jeeEdnffjJJNlHM8B3XB8a+2A/ioLvJcaSPqfw+dvWX108mvCtHUyk0Ns5bCwwPliplQLzrvPtFZqog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVv2+HWSJb/Bvvy/FVIMBCe6S2QDYRd1TZN8Ua4xMS4=;
 b=CynSgYzKaph2/kzKYr+CHLOv3QYLLbHs2tfbduG57uMHx0YAnFmeJ29UvhJuHRru8zXKy+i6A0CdoGJ4+UyzJCnEHAbQ9jOSe3dXMiJpRq6q+V2JJghkLf7X1NAPIf6d7n50yE3AoR8hS+1fyxxFkciu3cUwW7e12f4yC+AquQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB9PR04MB8233.eurprd04.prod.outlook.com (2603:10a6:10:24b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 17:48:11 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%6]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 17:48:11 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 04 Jan 2024 18:48:08 +0100
Subject: [PATCH v5 07/10] arm: dts: marvell: clearfog-gtr: sort pinctrl
 nodes alphabetically
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240104-support-clearfog-gtr-l8-sfp-v5-7-52be60fc54e3@solid-run.com>
References: <20240104-support-clearfog-gtr-l8-sfp-v5-0-52be60fc54e3@solid-run.com>
In-Reply-To: <20240104-support-clearfog-gtr-l8-sfp-v5-0-52be60fc54e3@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR4P281CA0409.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::9) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DB9PR04MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 70cd9e73-7ac8-4bed-27d4-08dc0d4d5081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j9X45OlLQrV6LzY4zBBsc/wy5do0+I3ZAJLF0bRYwRthDDUAvGlVK0IJdyXRX/++IjCefO6UwdIWuWUNjm3llV3Dxwg6QZ/aMOCrIxaqjXW1lJwU0Cv9XByMgQBUzrVuwpargyqqjR9Ng+TSBVxUqbvzp5KBtGM6WKS0ip6j7wLKr9lxSFM6JK1uJApAdjhTe8STLtIhfXBlG6XXZHGlWQTh5Ue6SaBVg0QCda5nHYOHq3WfxJ75XeZ+VXF2UD9D4F8zAt71W/4XEqEkY3POZLqA86KDSJ2op4fj8LV2PDusL5PyW0RVKBBaJ0i67Icyq2Aymd7Pu1xcnF4tYs3qjtYyIWuTkRUdS7iVgGevIsixu4wQ6FntgK3Oc9VKx7KArU/J6lSj473D/cuWmDIOoLRHquFbUE1nzIyYyOs8OzT0eioXIZXRoDv0YdGjZgmpmoL0Rm+iuaODJnSJ8w8DLT+4o4nUuIiyhN9Zd4dhAwWyW+ZGLMwZQvwrptAEX2fT8OooJ1tGm2qW3l4fLvFoJagAphP8R3m9OMwYvxbXHX1toLxKF3BoZ9wMUXLIM4GYbuQrKsWppBiClBfDC66S6EmHbcjnjzE/581GCxBY8993s3iBH1CuhIoVqNwhr1No
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39840400004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38100700002)(38350700005)(36756003)(86362001)(26005)(4326008)(107886003)(6512007)(6506007)(66476007)(66946007)(66556008)(8676002)(478600001)(8936002)(6486002)(52116002)(6666004)(316002)(110136005)(2616005)(83380400001)(41300700001)(5660300002)(7416002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REIrc1ZzT2NjaWhNMHluUjltUk5XL0tBQm5iTUhUTkREaHZOQXFDNDAvY0lV?=
 =?utf-8?B?c2NIeU0vdXNtTS9qTFltMVJ5Q3VBOUhpYWUyZE1hUEdWY2VuVDJ4OGw4QlJW?=
 =?utf-8?B?V0p2bXJQWjd0L1BrRDhhTGtZTW1uZ1ZpWm95ODNWQWZHWE9McUx0VUNKc3Ju?=
 =?utf-8?B?cE5TT2Q2SWN6TEY2bWkwV0xKZ0hYVXZlUURzc0FVcXFXZW94TXVyS0VTZTM0?=
 =?utf-8?B?QmJYUEJHWlJ3VGR2NEdYcmg2OGlFcmFneEJmSkNtR1QvTmdmQkRCNVlIbi9S?=
 =?utf-8?B?aXFFSjMyK1FkQXROemk5bFIxNjg4RkEvL0hJZHUxV0gxRFBIdFdsWGNnaVZt?=
 =?utf-8?B?Y3FLdU5VOE1Mcit4Vml3TzE4azN4R1hHTkF4U2VIZUliTDI4UUtOaTE2MmdD?=
 =?utf-8?B?WFRHQ1ppZ2pXN2Q0dmQxeWVHL1RMUDJOVnNCS3pGeUN0enlKRWc5WkFXeXpZ?=
 =?utf-8?B?dmJ2emRYdlNjV2gzakJyTEFxV2krTnkxczhSSzJRZE5uVzdwMGZQVGJUSU1G?=
 =?utf-8?B?ZWZTaEd1UXFXaVlGZkMvZ2lIU3o2RVFFcko2Y1VBb1pjK0RwREhOQXQ4cTRt?=
 =?utf-8?B?K05GYVZaQ2FZdTFRa3pOM2lSNWdUWmxUSElnVkUrQTJGRHdCMDhDNHBqanZU?=
 =?utf-8?B?U1dRV3Z5V1RmWHJYNmpLU0hCNnJaY1JSK2V3TXd4eHBWOGo3bm1xcTBMckFJ?=
 =?utf-8?B?Nnl2anVOT2F1L21vRWVSOFFPOXhhQWp5U0R6UGFKN0dEZzF3TjlHOWEzMjVT?=
 =?utf-8?B?RjhTR1I4UlFuajJOdUFiNmVMMFZWSElXcnNvL2cxMUx5TDloT0xJS0N6K3NZ?=
 =?utf-8?B?c1J5UnJpK2IycW16Y2Rabmd3ZU10b1JCcUxld2NyZFpOOW5teEc5K00wYlRX?=
 =?utf-8?B?RnlTYTdCL09XaldyNFRob05YNGVTcFZqMGs2NEsxc1AzaVNmbmxhMHR1c1Ix?=
 =?utf-8?B?MmxodlZ3VHRSK3RHa0hwNWZpZ1lxNVdiOWZtNDBUMkVkTlkxWkhGc3pPWTNm?=
 =?utf-8?B?MnhuU0pqbjgwZE5wcWJMS2ZYRlNSTWRpV0xCaFUvc2VUUFFZd2NtTXJxRE84?=
 =?utf-8?B?WkE0TlpkMjh3ZkM2bmx1ZWVIcDNlaEtYaVBmT3JlK3dyRjZYTGl6RkEzekZM?=
 =?utf-8?B?bVlvUHAwbzhGNzh3Y0xEZFhsM2ZnWXc1V01vRUhBeW1RTGtqMi9ZZ3k0VGQ5?=
 =?utf-8?B?RTZHQmMzaUE2NGQ0SkpRb1V1alBzdmhKU2lNbHB1eG53anlwWUVXbEVPcnN4?=
 =?utf-8?B?YzFBTE1jeFp3Q2ZFNnhlLzA4UkJNS1h6eHNNdFQ3NU1yODhZZnluMVFUeVVI?=
 =?utf-8?B?bE92V3dSTjN0ZGs0eHNiekttcXNTcSszaXM2OGl1TWh1cjVLYmtjVkVEbjln?=
 =?utf-8?B?c3lCQkJTV1ovRVhoak51K0F3V0dINjIxdVZzdEM5eUlWS3VyWGNmSHRYMVU0?=
 =?utf-8?B?NnlpdE1WNEtvenJXK3FXL1JYRDVuOE9nRGVGeTh1U0tXTFBOUXdyVnA1TXQx?=
 =?utf-8?B?NkJTK1RUZXp2UExHM202L2YwNHlvUHlEekV4MURFL29iWk1CM2hHMFlIdW9I?=
 =?utf-8?B?dUNCUlpXMjA3Z1BrektaMXpTTHVzNkVYcXRaM0FuYUlFM3ZhczZhcUkxejla?=
 =?utf-8?B?UWVMaHVVV1IvVmdxQ0pxdkd2clErcERkQTUrVTBla2tVdm9KVC9WMDNNTzJy?=
 =?utf-8?B?OVpiU1h3Rk5TelFhMytSTUNvTVJNTm1TWFlieXBVMmVMK1kxTE9pOUJML0dl?=
 =?utf-8?B?UmNJK0pjWFBxUFJHRmY3dmd4MGYrME1GdE5HOVJDQmhwbGppa09wVFFiekd1?=
 =?utf-8?B?ODR0RVZzUXhFUmo0TUpsaUNHbmg4RDRmUkhOY3NrblNKMmFDRnlYRzBBOEkr?=
 =?utf-8?B?UmNoTjk3cVdnREJIRnZqSHVzcmhmZXpLN3NKN0IrV1MvNEJiRklXVWNJek1x?=
 =?utf-8?B?WTZ2ZTlKYTlXUExjcDVvVkd5enhpMHR1RHZNWWQwcW1NWmRhNmovQU5ISmlk?=
 =?utf-8?B?dXNaZUx5V3NoeWlHTUpjZXp3L3d2a2h4WDhEV00zanlLYWJrRWk5SDgxUHB3?=
 =?utf-8?B?ZlVoWFBZUDUvSVlMRllmS2pOWmtOb29wdTVsYXZhK1BzUURoVGlONXVBdVNN?=
 =?utf-8?Q?WNyhEvQMFO0nmSRbjHYk4vNRi?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cd9e73-7ac8-4bed-27d4-08dc0d4d5081
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 17:48:09.4922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qY2hAkzD7g6EJ7QHNBwHWx/y2U3H8FiWoG/p9ZTqTLmluS8hqzIP5vTcZgoR4pjPIYtL4IpfpHVS8YbAtqqLnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8233

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


