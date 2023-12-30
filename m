Return-Path: <linux-kernel+bounces-13473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D24820705
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 16:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F8828229E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 15:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C7C15AD0;
	Sat, 30 Dec 2023 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="L+Dk1hp3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3DB154A2;
	Sat, 30 Dec 2023 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QT7zqOzrcK5Mzl7Z50cT1aqDhNL4UUJKL9/n3lMIKNZNX3v9A54mVbsc9407V5ayY7M5sZ8UlP+BLto+AKRGqGEeZQeUqwLC3vWMfZCxENXUbjDPUz7wQd0wHGHcIOPsExZMYjaGIGI9fHF3QgWJ4We6Npq+jI5rFcDHSrI6kCMpwDuUpX2dDl6LgcaS9eCXjKstApymzgklixZdxraGiZnBo4pOqjP6UFq6KyGDAz4blExr9e3Cu1Qu5IW5XnMs1iWDxlPF2mHKqyIxlccw9DAm+JhCGNAhu5iNj+9v4p7d0Ov0uLpcCMDMv47gxzb51nbMIQMEowZSW+lcVFIGMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MglBJUqaxruQGh0ZPAoTMXRHGmU/vvywi3A7VAP5PSs=;
 b=FqDx2gZNK94H4uveWi3Jif/CjvOmoIobVx/uomJ7TJn3VKNWYGKBHeMAQ7CUYjOlSBSsSl5oUKyiUOUbCHcVHy3rM4DNVR3RH5ESUxR3DW0w9pzsoQ1xiXz/1dOa2gtof3Jol6R6R4NIBC9HPcgLtX+H09oZyKwcbg0KIoS28PWyZZCgaaByGSuRV1AOty0P6BmOyrIm8UMDO0Mi41FoO53d/93BF0+qTZkRMpRgYyztY8vSHnLqbu61CNPpXPbVIXCm55BvRDID+qKCEbDqfZL0LCrPKouV+invf67MBnLH51uXopzJdMCMlyiVRi7urfT3OJA+MuFWGXXfKqZmhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MglBJUqaxruQGh0ZPAoTMXRHGmU/vvywi3A7VAP5PSs=;
 b=L+Dk1hp3Ud7hNpv/Q8bI6unboArbwmqLPauEqOUrMqJVF4OYLGxtaGjKyE5MthFn5S+GOQa/ei+DbiKIW7w6Kc4WrjwLUdQ9jfnLm7DHtPWKwgCnciZlKFghGT/V1voE7EZTaGRWnKNxXSlNa3h/YsvUG99ZAtCpmzZ5/k+7KW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB8PR04MB6970.eurprd04.prod.outlook.com (2603:10a6:10:fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.22; Sat, 30 Dec
 2023 15:44:49 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73%6]) with mapi id 15.20.7135.023; Sat, 30 Dec 2023
 15:44:49 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 30 Dec 2023 16:44:43 +0100
Subject: [PATCH v4 09/11] arm: dts: marvell: clearfog-gtr: add missing
 pinctrl for all used gpios
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231230-support-clearfog-gtr-l8-sfp-v4-9-1d7f0e2c7128@solid-run.com>
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
X-MS-Office365-Filtering-Correlation-Id: af07b66e-1a13-48f9-449e-08dc094e41c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dgzCI/syYK8Ujc5eK8vijmq+pdPxRwJBSF2Fl+P1sWZMG7xC9c2MT0JQDHoytBVya6BZHvedN5MMqpgWOZgVv5085p7f2WLYblsh/u51rXbQ6RPZcIkKhUy+FxXZGdxlKJX7tOVAUalvCSTJk4bE8HwQUs2WXRkNoyL3Hjb9RLTjbls1aL53rkRhDFmql4AGz/l37ujFNpEeLwQ0z/SoVaH74+gMg9gJ6rCvWc/FLbYaVXSjS1+Y75Mp70GOmw6rAGgd8vOdFZDu2YPp0rf7p80srDa1eaZ6esUl9A06HQflktlHCzX6kIGPx31LF9Fn0DIe5xcODEKLEaWvcqUl2s80T8/L/3RB2Uweuhy/00VzUc8RrWNjDaeZ20Fyy61V9rb1Pok78a8dods1/M9x+X8x0aLRKxFAG3GcjEnA0O4sbmpNtK0r+vNehUafl4aaYZUTdAzLTk7tXRCPp+PkoVoB7fF4JA7klZ2WCwPYpxBZYP47UrN380eDHrDU4GCkWab/bStct5FNMZW1607kO6enePTRwT8ihclILEJFtAocwl0kQFFINau8om8Acp01CMI1iD0egw0VxbNQgNkFt7Zm7gRpRX8DHWaFi29UcVDSj3naUBlws+tcpW4p6/9Q
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39830400003)(376002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2616005)(36756003)(2906002)(86362001)(107886003)(478600001)(66556008)(66476007)(66946007)(5660300002)(83380400001)(26005)(6486002)(110136005)(8936002)(8676002)(316002)(4326008)(6666004)(6506007)(6512007)(52116002)(38350700005)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rml3a2hmNXFZajlDMkJWdFdqK3NNS1JkK290aVdkTERmSkFqUXBraUViaGdy?=
 =?utf-8?B?VTQ3bGVRR2xVRWp3eG1YTENIRThTMVNocDU1UzhRY2xqUlAvK0l3YkVRSzZX?=
 =?utf-8?B?MTh2UHZPakpSL3dWRnVUNEUzZ3ZOVHl3OXhlN084V3d0UVp1NUV0VXpBNWQ2?=
 =?utf-8?B?UHpCUFFBdDVhMW5ZMmlaeitqNGNWRGhBZzhLbHZjYXdtV3BrUXM5alErc1Mx?=
 =?utf-8?B?VjVlRUtlQmRudnMyc21EdGc2WWZWMDQzelZUelhsWGhlcnRkRkFqL0tEbXpK?=
 =?utf-8?B?VTM4NHpZem5pQitTT2kxV3p0STNzZlRKZXdpZmZEdG9oYTRxRkRBcTIrTDZZ?=
 =?utf-8?B?UEcySzdGNCtiT09YZzR0elA0R28vd1ZXdDNGa1gwZzZOWDFpVU1ESU00UmtX?=
 =?utf-8?B?eFEzcnoyMUU3K1puaTlOWmxuVDJrQjlpOGJKblpodlIxOUZIbm5sQ0xDT0ww?=
 =?utf-8?B?Sjl3M2RFQ1lzYUs0Qm5XNHJwRGpJQU1lNkJaM1lHdDNFczNPckE1anA0RmRD?=
 =?utf-8?B?cG40b1RzVTZBcFF1andKc0x3OFMzQ1lDSm5mUGpaekFhOXV5MEF2VGJTdktN?=
 =?utf-8?B?aUpaa0Zjd2ZtOExKZ1RQaUtacDVEWThHT2MzTWFoS0hZZ0U0dm1RWmdSVGZo?=
 =?utf-8?B?cmtIUTJRNlQ5b3JidW1lWjl5eGJLREJnODRYUEtXMGFTeS9zc3lrQ3Z1aUdG?=
 =?utf-8?B?dlU0OXcvTkJhdXp1OVFieFZqalRxYUVuK04yYm4xMXB5d0ZpMG9lbnVlMW9u?=
 =?utf-8?B?RUsyWWMwL2JRVVpwdjJtZ1JxcmZCVWNlTUkrbEl2ZUlDS1Z5aHRaRUVBc2FU?=
 =?utf-8?B?Yk13RTZ6UFN3SVI0RmNqY011WjE4dG9paHJDQk9xenM3Y3BaSVF0aEx4OU1R?=
 =?utf-8?B?aDdCNzBVUkZNRHVLUTI2WjNIdnBiSmpYWFZPSnM4cnhHcDdoSWdRcWVZVFRH?=
 =?utf-8?B?MVBJRzNQZGFQcXhMZ3VhK0YyMk1aQWl1b1B6NE9rdWEwNk9XNS81a0NtaG8z?=
 =?utf-8?B?V3BJMTMyU1RBcDRpcXNabmVydVVERjZNa2ZqZmFNOU91bGRQSHhrcVYrdkxp?=
 =?utf-8?B?V2NHVkcrQWdTckhRbmdOK0Q5YVpaVzNiTE90OTc3Q096a2l0SUErTG4rc3oy?=
 =?utf-8?B?azJlRkJVUlE3UTNTblpibHFLS2hzdWI1eU1XQk1Ud2JTclVmRGVzSkcrOS9z?=
 =?utf-8?B?K1FvTCtUeldYMVhUT2VyN1E0K1V6S0dhUFhGdVN6NWR6emFpWUJlOWVMcm5W?=
 =?utf-8?B?QWFocUttSWlVc3ovVHYveXcwTjBmRlk3anAzRmd1M1g2Vnk5Q3g3OFd4RkNV?=
 =?utf-8?B?NHVNaFRZa3hUb3lqblUxd3phTmd3a2VORlZoR1R1UitzcUI0YzFRNU9JVmc4?=
 =?utf-8?B?cnh2cS9JVy9vczd2TEIvTXBmT1NNRXBRVERlditFTlJpWk1iRVhDZ3FDNmVa?=
 =?utf-8?B?dzQvQ2hpR1JhTGx1eDBwcWNjcWdnUWFMRmdsQVNyUUNEakJsMVVVRFVCZWZ1?=
 =?utf-8?B?VE15Nk85aXcrRWxPWURDTFZNSGQvWW94NWdneCtQVFQzaC9aYmtkNjFzS0dW?=
 =?utf-8?B?MngvMzQrT2hvdmVNeGEzdlp4WVFBQzlNY2JBdUJyaGUzLytzMkZKWlVZcE9x?=
 =?utf-8?B?RkFqVEY1eWpOYkI2UFBUM0pZa2tndEs3Y3kxZVh1alZyUU51elV3U3hMSWFh?=
 =?utf-8?B?QitIaTFFSFZERlJhemZ3S0FuOEROVjFFVzlWYWJBSWprMUZTZGl1cVFTcWlZ?=
 =?utf-8?B?ei9RQjRtbDB4ZEU4N1A5MHEraEFTR3dxdHJ1Z3JjSUVEWDlFVmR4UEV4MGxH?=
 =?utf-8?B?SFUxK0RTSVBpNDUyYXVTOW83MWJNY1ozdXIvK2c0azFSQVNvUU4vY1JvbjRn?=
 =?utf-8?B?c2ozb2M3dWVDMFJRQXJlYnFnTXRRQzRJZkVuY01kR084SUUwaVNiemlIUWp1?=
 =?utf-8?B?SEpYV2l1MDRTUzZKS1laQW9HQjdVU3RlcXNtTFRHUWVuUXgwRjN4Smc4QWRF?=
 =?utf-8?B?ekxlek5DekNtL043NTZPVXp4RW1zMUd5WithR2JTWXdFRFJkaHZwd3Bub3hU?=
 =?utf-8?B?SHpQeHZQL1pyU0VZWUlCYlozQXIrcVpHN2xWSStpbEtVN3NzaFYzc0hKQkx4?=
 =?utf-8?Q?Td5Brx5TYa2Lqe6R10u0Dfqur?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af07b66e-1a13-48f9-449e-08dc094e41c8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2023 15:44:49.6518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+ApVLf49mbkTRcNq2d2FCT6G7g4ZbzqbiWiLK5bVVp9DWLKOsBxn5jOjjPEwh2H1u2ieVGGr/WjeCO27LMbiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6970

Various control signals such as sfp module-absence, pci-e reset or led
gpios were missing pinctrl nodes, leaving any u-boot choices in place.

Since U-Boot is shared between multiple board variants, i.e. a388
clearfog pro / base, clearfog gtr l8 / s4, it is better to explicitly
configure functions.
Add explicit pinctrl entries for all gpios currently in use.

Additionally the loss-of-signal gpio specified is invalid, in fact los
only has a pull-up on the board but no gpio connection to the cpu.
Remove this stray reference.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 .../boot/dts/marvell/armada-385-clearfog-gtr.dtsi  | 42 ++++++++++++++++++++--
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi
index 8eabb60765b0..39ac97edb463 100644
--- a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi
+++ b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi
@@ -162,6 +162,22 @@ cf_gtr_isolation_pins: cf-gtr-isolation-pins {
 					marvell,function = "gpio";
 				};
 
+				cf_gtr_led_pins: led-pins {
+					marvell,pins = "mpp42", "mpp52";
+					marvell,function = "gpio";
+				};
+
+				cf_gtr_lte_disable_pins: lte-disable-pins {
+					marvell,pins = "mpp34";
+					marvell,function = "gpio";
+				};
+
+				cf_gtr_pci_pins: pci-pins {
+					// pci reset
+					marvell,pins = "mpp33", "mpp35", "mpp44";
+					marvell,function = "gpio";
+				};
+
 				cf_gtr_poe_reset_pins: cf-gtr-poe-reset-pins {
 					marvell,pins = "mpp48";
 					marvell,function = "gpio";
@@ -179,6 +195,12 @@ cf_gtr_sdhci_pins: cf-gtr-sdhci-pins {
 					marvell,function = "sd0";
 				};
 
+				cf_gtr_sfp0_pins: sfp0-pins {
+					/* sfp modabs, txdisable */
+					marvell,pins = "mpp25", "mpp46";
+					marvell,function = "gpio";
+				};
+
 				cf_gtr_spi1_cs_pins: spi1-cs-pins {
 					marvell,pins = "mpp59";
 					marvell,function = "spi1";
@@ -193,6 +215,11 @@ cf_gtr_usb3_con_vbus: cf-gtr-usb3-con-vbus {
 					marvell,pins = "mpp22";
 					marvell,function = "gpio";
 				};
+
+				cf_gtr_wifi_disable_pins: wifi-disable-pins {
+					marvell,pins = "mpp30", "mpp31";
+					marvell,function = "gpio";
+				};
 			};
 
 			sdhci@d8000 {
@@ -221,21 +248,26 @@ usb3@f8000 {
 		};
 
 		pcie {
+			pinctrl-0 = <&cf_gtr_pci_pins>;
+			pinctrl-names = "default";
 			status = "okay";
 			/*
 			 * The PCIe units are accessible through
 			 * the mini-PCIe connectors on the board.
 			 */
+			/* CON3 - serdes 0 */
 			pcie@1,0 {
 				reset-gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
 				status = "okay";
 			};
 
+			/* CON4 - serdes 2 */
 			pcie@2,0 {
 				reset-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
 				status = "okay";
 			};
 
+			/* CON2 - serdes 4 */
 			pcie@3,0 {
 				reset-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
 				status = "okay";
@@ -243,10 +275,12 @@ pcie@3,0 {
 		};
 	};
 
+	/* CON5 */
 	sfp0: sfp {
 		compatible = "sff,sfp";
+		pinctrl-0 = <&cf_gtr_sfp0_pins>;
+		pinctrl-names = "default";
 		i2c-bus = <&i2c1>;
-		los-gpio = <&gpio1 22 GPIO_ACTIVE_HIGH>;
 		mod-def0-gpio = <&gpio0 25 GPIO_ACTIVE_LOW>;
 		tx-disable-gpio = <&gpio1 14 GPIO_ACTIVE_HIGH>;
 	};
@@ -273,6 +307,8 @@ button-1 {
 
 	gpio-leds {
 		compatible = "gpio-leds";
+		pinctrl-0 = <&cf_gtr_led_pins>;
+		pinctrl-names = "default";
 
 		led1 {
 			function = LED_FUNCTION_CPU;
@@ -408,7 +444,7 @@ &ahci1 {
 };
 
 &gpio0 {
-	pinctrl-0 = <&cf_gtr_fan_pwm>;
+	pinctrl-0 = <&cf_gtr_fan_pwm &cf_gtr_wifi_disable_pins>;
 	pinctrl-names = "default";
 
 	wifi-disable {
@@ -420,7 +456,7 @@ wifi-disable {
 };
 
 &gpio1 {
-	pinctrl-0 = <&cf_gtr_isolation_pins &cf_gtr_poe_reset_pins>;
+	pinctrl-0 = <&cf_gtr_isolation_pins &cf_gtr_poe_reset_pins &cf_gtr_lte_disable_pins>;
 	pinctrl-names = "default";
 
 	lte-disable {

-- 
2.35.3


