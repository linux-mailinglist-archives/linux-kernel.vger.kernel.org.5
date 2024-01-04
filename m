Return-Path: <linux-kernel+bounces-17062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC228247C2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A367B281CE3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFCF2C6A9;
	Thu,  4 Jan 2024 17:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="AYvFnJ01"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2083.outbound.protection.outlook.com [40.107.8.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE8C2C18D;
	Thu,  4 Jan 2024 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPxEqPWf/T+HhTRisNLr04w7aC8xWdKCUp9V35kq2d1yqSEhm6LfkbqQaTZInJqQCO/ex/kIokRkAxHjqFl/nzPj09Mer1/zb8oFQzt4eLFHX6YBZxLX0u/jLFkR2qKuLH7yPTXw0P3qsjIc5ydfQEwg7VT3552jzL4vld5I87pnmwlyW23neodhhasJqQYbTpDnZkVu5igWBw8In++DwEG6LGwSeMPtR90t72i/8V75k06M9W3qZDXDr/GyXInkOadauIAt+UEBKVh3m16/BQC9amvryy7oL/EN1YhfAIpqZ+WxRNyXHF4HzUztK0Q1FITZsthLv2FpcOunsx6K1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MglBJUqaxruQGh0ZPAoTMXRHGmU/vvywi3A7VAP5PSs=;
 b=a8LyWlQ7b5l5YMWQ+mVO4gTZVfmswZnk8dwhrndHiv1w9Jfj+yEXBgXkskjqEC9ZPTLmQO2jRxODvLSx5BuNRMwG/Ybz4dt8nxC1aSiH4pjul0+Wp8ruD7BRZVfAick/pc2P8fjtLFTHTzfDhY5UV2TmOfO5DwkczKZ5wpC8wrshSbF1cF3rwgnhNgbwzCSl/ChjyQit3S9z3v1wvfAxOG81HHIPysc7cb3GIn8Ug/jfa5YbSg5tO7t9rFSwpc28YNPs8VUbEOyfh3bS2ZX/FFoYQDnZ9r+bLgrO+vsPftnl6YTl/Ut/F9Pxql+YX/4eFtIwN4oJCcMcSrJ1sUzYTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MglBJUqaxruQGh0ZPAoTMXRHGmU/vvywi3A7VAP5PSs=;
 b=AYvFnJ01aisg6qfB2kK4t8dkZbResiDHJeufwymQ5nW28Pf3bavIUPot4yfvKKh0dg7QFzJl1kUDk8MXTCxc8BWeBZKqLT7SyqGTLW9tchU4+1s7BDGTNWZnOMe19TParI2HSo0hGvd2yajZfhbbaSUNfToQQKyoKb9crKFvje0=
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
Date: Thu, 04 Jan 2024 18:48:09 +0100
Subject: [PATCH v5 08/10] arm: dts: marvell: clearfog-gtr: add missing
 pinctrl for all used gpios
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240104-support-clearfog-gtr-l8-sfp-v5-8-52be60fc54e3@solid-run.com>
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
X-MS-Office365-Filtering-Correlation-Id: 51ff7296-73d4-4ac4-4dcb-08dc0d4d50c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bfvOlgXPJlPGKQE3heC7WdI3RsxeFP31xDmpV57Asqyz5wSoeJJ6myHadAwahoXKGnydH+Rc9+sjnW23iXkTsRVYEE72JONenO2FX/ClOPybPSq2EJuH8c95dcUyKXyy4gv8u4woUKbuXbEtlvaNiBZVf3xAFiVwLe81Ah1F/rHVD4tN6D8MmU/pFSPPMsBrwhQBC12sOYCTfznmLjUWgwEhCXRb5g9X6u+gjfwqWbWSNvxvpS7EK3x4XV2+VKavAgYHu5lSpjwnkcdZE/1j/afEuNgJGTm0pVIcxQu7y8Oi9Bx6o2lODxJV+n+gNcZUSUQrZ/9SJVB/FCrvh2q7gVmpDeFXLlmPiVcOToorl8Ry41XtHaldg96xRapexnAmUMOR46asPG3toLRysDuAALX9y3VVT0QOHrWg3WjY+jXAG6vXev57QQk/0tG0LppCKibjgjUCknxYTnBDh7a9YWr/NAYKXDi89HPoze7aLV0EsAgJxzQwxo+XRrvjTIbNB/8gtaF88hBEpOrm8omOT4sW+WL565g2s0aG/bqJkhfLhB5i0XwLRclspaywp8ZXZ05BBBj9d6kTBcs3yK6k8Je87cyo+X4D0TCGpgwaS6qH/WHcHDzS0H6NJBeWjZfx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39840400004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38100700002)(38350700005)(36756003)(86362001)(26005)(4326008)(107886003)(6512007)(6506007)(66476007)(66946007)(66556008)(8676002)(478600001)(8936002)(6486002)(52116002)(316002)(110136005)(2616005)(83380400001)(41300700001)(5660300002)(7416002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aElmRGJSa0I1dklhaWVMcVA4aEg5Z0NLVEZaVzVsaGxpRW5IVmh4N3g2bnFX?=
 =?utf-8?B?UmExSmYvUTN0ZjQxOU5FY3hKNG1ZYTRUR1BHTTRlTXV2ZGlwbXBTcjk3anRX?=
 =?utf-8?B?TTlxUS80N1RhTTZXZGR3Z3dCK2VQM2tDNVpGZVVQaVFScnBPdXQ5aTVYaS83?=
 =?utf-8?B?TGFITHRoaGlDVVNyQm1KWWZHV0F0VEtIUk1LejhWVUJmSlhTOEI1dzZKVXpE?=
 =?utf-8?B?ZG82NkpGK3p5Z3JENEZ1bVVpdW0rU1VITmhRMWRDOE5hRHFKUUlXdzkvdFAy?=
 =?utf-8?B?VHJJTW9lYXFFeWloalJaWFJhWVR0Rm1WaXUzdmN6anIzaFFjQUJlSGJHNUdM?=
 =?utf-8?B?b213dGdZWXRXNVFXQzRMOGlLcFlETzBPc0VWYkZHZkJzeXQ5RkVVLzdrWGow?=
 =?utf-8?B?RHlkMi9QdDBxM05RQ1NEL2crNHUzQ3dmYWU3TkloNFdkWmFYYmdMc0Joc3Ex?=
 =?utf-8?B?akZVVi9pOGJXd0pVV0N4eEpkMWRXTlRUaTFMampPaVR0cXoyaDhCdFFjWHhN?=
 =?utf-8?B?VXo3ejFkOU0zMzhBUnhwSllBOG82RzF6MDVxTDVxMXNQaG5uNDROS3JRaUhE?=
 =?utf-8?B?WlpZZ3FuOTl5ZWZiUCs2a1RhTWFyVkdlZTJSR3dmOEZhK2xmWGFxWWFtUitV?=
 =?utf-8?B?YUNBbjFLUTAzYnJBL2V0UytsZFNRSW01dWc1MHlpUzZqZUdiZzBPbDVYQjEv?=
 =?utf-8?B?d0RLQTdZSmFwSG1lNXY0Vk5oVFBzeEFNK2pTQ09UZStJbTY3RVdMMG1qKysr?=
 =?utf-8?B?WmdaTnhoY291VVd2TUZ5OEpENlIveHRWMFEyVklFNFBwNzhHR2Z0NytPdGd6?=
 =?utf-8?B?OG1JZU03Tjh5MEpVVlMzZ05qU3BYL3UzaTVRbTdaNGViWjVNU3hoWWRpdUZa?=
 =?utf-8?B?dkExalI3eFhSVVdRcnBkc0VKUkxEL1c4MkppL0xQNHJ4dkFKbXhFakJOaitL?=
 =?utf-8?B?aGZXSFVncWd5Mll1UTR1YmNWMUNUaCthOTRKUWI1a01abXVLUmxhMDhUTDBk?=
 =?utf-8?B?aElnVWZ2dWlnWFgvQ0JUQkZpVmI4SVZiMlVUWlpCMmtrQms0N3J1MmtLcVVa?=
 =?utf-8?B?a0tWWGpuWEQvUW5UeDhUSmJ6d1lyNmJVWlRTcjBsc2ZldWZjb3cvRnhackY2?=
 =?utf-8?B?QzJYMVNIM2lLcXh6a2V6d1YvaUFzUlI0c3FPeW1CWERQM0dLOTJGQzc2U2t5?=
 =?utf-8?B?ZWVsV0hQcEQ2d1ByYlNaTlVuTGdrWHQ5NmlYbXpjcEpWWG56aE9WbFhBS0RL?=
 =?utf-8?B?R0c5ZlBqM2RWV21Zb2dyLy9mSzlOc0JtWS8yRWRiM1BjVDkyaEdhRGN3RWZG?=
 =?utf-8?B?aHZOUyt3VzZ3VGRjOE1JR2ZVWEE1SG1TZTdjMGx2RXp6TEZQdUYzcGM3LzJH?=
 =?utf-8?B?THA2VGwvV1p6V3Y0YnVjbHVldG5QR0ZGUkYvQ0pxZk15Qkx2cmhGNVpkWjJD?=
 =?utf-8?B?bi9pQUtacDBPcVVVTndJTWVVeGNyU0JGaUFsMzJHbVBPeDRoTno2cGdTRzJC?=
 =?utf-8?B?ZlpjaUNrRk1DeTg2NHlmZUFYbE1jazRBS2RvUVVmWmdjV3UxUmRrdnExckJI?=
 =?utf-8?B?VzB3MzVxWGZlZ2xXbzhPWGk4WmF1VVNZZUFkWER6OHgxTnpjRHdSTjJSU1o5?=
 =?utf-8?B?MWNFeG8wVnNLNVZNendIbWlMOFlzWG9PRm41MGhwdi9YL1owaHljZTkrekpS?=
 =?utf-8?B?eTZZYS9EWWFLTFowRU9RQmkwM0dQLzBtdnJaaUVBdE1mdDMyclRsUEhoMU9J?=
 =?utf-8?B?SUxCdmJ1VXR5QVhIei9qSWhKdzRwbHVmam8xRkw2Wm9DSkV0YzRPZmtBZCsx?=
 =?utf-8?B?ZllRc3VGQzB4c3JXZEN1bGdwemRLSHFRVENWZ0REdFRjRW1VeHpabDNyWkhp?=
 =?utf-8?B?eUY0eEJ4ZHpmcjJ1ZGxUWUYycVpXR2txNXVWWjhXK0t6dzdlYlVDWjZSRm5Z?=
 =?utf-8?B?OSt2YWtSTDJrd1pKSU8vNnkvTGVGZWdiTG9DSDlrUlRTcVBLRnhjZ01Vc2tL?=
 =?utf-8?B?TzVVbHdoQStUSEEwVis3Y2RjS1lmVFNxeHczUGN2QUhZMTRwNUZza0FYMWJm?=
 =?utf-8?B?U3h2QzN3ekFpNmNROG5oa2NvNFBFaWRJVjBKL3Zya0JCN1orR2diQlEwVis4?=
 =?utf-8?Q?ds/gBVQ01vz8/gpjJjF7PZnxQ?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ff7296-73d4-4ac4-4dcb-08dc0d4d50c6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 17:48:09.9278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: voY3z6H5uJaqWOuSWURuDS4lhTuGHIXh+xt6v4dmagGSOJ4mJBWuo/sub0u1LB8IRnbr4ZeHWALo4Sq8cF+9fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8233

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


