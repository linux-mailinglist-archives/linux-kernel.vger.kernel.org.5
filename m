Return-Path: <linux-kernel+bounces-11613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F7081E8EB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA87284923
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 18:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3885351C31;
	Tue, 26 Dec 2023 18:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Ouu+LjdQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E926B54656;
	Tue, 26 Dec 2023 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jm9Ioo8GShkRZpuDM9Vhk6ovwsqX/rarbStxxc9OHtbyutLR0y3gqDMtx3KTjXKj03j49bsX8zzmEH+Wp29lqWRLaJclMaH8RUD7HZYZMZEUowss51dcoex7FXBniK/Va6xlfdEsDsyQG/bItsrj2CzPa8q49eN8OhUKQmkp6l+fFDpiJWrXM3Mdtx8GMbgBGX3TFnoq1jqgZdiXFx9XXV1Kl4//IClcVr9muD19i4TZCZ970RCgP14WLuXaMwRo6eF4VM/Rrd8IBQCSvjaZKHlvbomFl2jhI2Y5URonnO78Hfgdl5G/HVaQNylf9bLRqtleBhgNI2Rl2J+8mlbl/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MglBJUqaxruQGh0ZPAoTMXRHGmU/vvywi3A7VAP5PSs=;
 b=Ni2aONBVX95cMmANR6uRFYO2QbedTKEsItfFpoZAWbTKTT7B6ptogcg/Y/kKl2o+BGxU8zzYZcZK29Hfy3XNCnOu6EJbhalkjVazpJnXZbQocsb7J4+MnQSIBZcx2JuPRwIVbnYLdymSe5la+AU50TfM8XmJ4TCW7PQzYImJO/TwF4TNU7cIieETsduLU4TYu7d9Zkad71zUL5b6sL4SW3sWLFXxrexG0GaSAksyyR9AZ3WwGheg4WlBXrtpfqcgodm26S/OkSY5dwFN/Vo2mELjPl0Xjttv8B8kmGMrHSbMVs/6GrPL5EeU3nIbyNWyUI3A+y1bAcOrGKgii86NWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MglBJUqaxruQGh0ZPAoTMXRHGmU/vvywi3A7VAP5PSs=;
 b=Ouu+LjdQ486D9RQPaS6iPSywLlEPHjTec0ikxDZ7uYY64MIj+HviAklUtcGrKDp9lCp+ZIIfwSWyzNpAA84g/rquDnkK4Cd2OdJ762nRuyyjyA0igIMA32N/Ulpbf14eOjKTs08Z7X873W2jMHF5F9vTIPAPHutVAvHGzqZeftk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB9PR04MB9868.eurprd04.prod.outlook.com (2603:10a6:10:4c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 18:11:54 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73%6]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 18:11:54 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Tue, 26 Dec 2023 19:11:37 +0100
Subject: [PATCH v3 6/8] arm: dts: marvell: clearfog-gtr: add missing
 pinctrl for all used gpios
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231226-support-clearfog-gtr-l8-sfp-v3-6-fd1ac2d6bf2e@solid-run.com>
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
X-MS-Office365-Filtering-Correlation-Id: fe6979a2-87a2-4160-2ffb-08dc063e23da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PAHM+8ThhZHIZrgKvHpoeBkISxKyK9msTlTIeWKmV6yKKVxwpXytjFRpk3ktYgTRE/arMxKMAL6fnk8k3bAP0l4lZixJIKkgOmOEvWLEmW4GEn9mvfMZWekE6eh5fIHBhQISDtlJ5j+zz4TJ6ufmVWVgoe4D3+LRDQvMp5QXzDJOwd8AJHZlbVAhdSxOtOV4wLbUVi8E8Cpfn8KG8U/j1L7UApfJ6rujivymh+FpRQdwaUF+Nom1IoOimLjwpZTWFyVQHabKHZv+zlw+1QtsQr02S79Eft0EeVBrYn9a6Foda6fIv2iWCt23N/nW6vxkedkgmrSiU0I44wyk3a54xzJ0oXYAmliC2Iui8ZSP7Hm0JLwxH3dsfpYrLBX/JRh6l62AauYMwn+cqoDAHrMljHm+VMiu1QAIHc9FD95jewdIXCiaOsIMIwPIwTDgJCV4Ul01jvWWK0fMn43kBlBm9IaudUEItu2HEsFU2G85WsxJB0KmS0yp7WUntn/BqoylXhJQ+jICLl3U4eaHRlxkpxP5SUuDvz3yV6sh5E5bFWGyP6nO36SPDm0bIKk3j0fdhF27cmiPqsf6ezVrHeUO8owybYAMRqG6FjSLmtUCZTxzEx6XDT6rubhbxS+1DwFm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39840400004)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(26005)(6512007)(2616005)(4326008)(8676002)(110136005)(66946007)(66476007)(66556008)(316002)(83380400001)(52116002)(6506007)(107886003)(6666004)(38100700002)(86362001)(8936002)(478600001)(6486002)(5660300002)(2906002)(36756003)(41300700001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RSt0SlhVMjBmOCtKS3hpQWVxYUxyOWpzWUlueDY1eGtxRzkrT21ZaUNTS0Rj?=
 =?utf-8?B?a25YY3lDYlpqZ1lyUmRGR3J4SUpERTR0L3FaS0pMajRTSW91R3lWRmczZ3hZ?=
 =?utf-8?B?eFJBOVZwTVF3dHMwRjBHTHl1bGxPYjhWZkNkU2o5WXZLSVlzN253MFpDNVJH?=
 =?utf-8?B?b3lBeG92MnNYeUJBamRmdEw3VGRjSE5hQWdsa3hwZ2puUGs5QVo1OTQwd3Ex?=
 =?utf-8?B?bTZuVGVtekY2UEdzSUN2TVJ2RVMxbWRIb0JJckk4NFp3MWxDVmczUVE5K3Qv?=
 =?utf-8?B?MDM4ejNPZFdmY0Z3L0pGejVhVUM1L2h2bGhHbzVZODZGUFhqRlkyd2dJY2w1?=
 =?utf-8?B?S1NvdFJhVDJRN09KL1ptNzA4QkhzVFpLN3hNdzc0aHZSZExsTDZYSFJ5Ritq?=
 =?utf-8?B?N2FhSllIY0tnOEtGVGkxa2ZmM3NaWTYzNzN4ckljR3pTV0d1K3JQbS9XUkp5?=
 =?utf-8?B?QnZOeXlJM202QjBVcXN1ZitMeEVjNU1UNmJiU2lHVkJUQUtaOUxaY0RKQ0Ju?=
 =?utf-8?B?RFNxT2Rua2luTXQvZ0k1WUhzaklnYzg2SjVkYVcveEdqVzVkcFAvelVMVHVi?=
 =?utf-8?B?aXhqV0FRall3aDRVeURnemlmbHRYeUp0TGZ0YWYvQUNSWjQ4allUZzF4RE1X?=
 =?utf-8?B?cnBTcENENVg0TUNuU3FuY0dXUXVRNklMc0VkRWNwc1ZISWhuUGNmajVyWU1O?=
 =?utf-8?B?d3NDMmo4cEl2QUdHSTJCbXc3UTU5ZlZtNHNWTHR2S2lsS0U1WDZRNzM4Kzdx?=
 =?utf-8?B?WUNiWjZheDYrVy83WklUakZsU2ZxUnBPTkRHSzJYUmFiN0N0djlQS2F1RHhC?=
 =?utf-8?B?eWIwVjlXRXZXeUU4SjBZMWw5STQwdmZlaVB0NWJ2ajR2RlVVdkl1UUMzY3NC?=
 =?utf-8?B?N1oxM2VrbElrUGVLTXc1MzROWmxaOGVVMlhGaXNrTlVqaVpOMzJSSHY1K0RW?=
 =?utf-8?B?VUxweU1VaU45Z0xDbEx4TklDYytROUJMZzZWS3lHb0tuek56cWYyTnB5QzVv?=
 =?utf-8?B?eEtOWFVqckMwNTEvWExvQlZENS9VVTNYOXRjUmtUNnRjKzFtLzQ3bXhPS2ly?=
 =?utf-8?B?MG12eUVrc0lqWFJRNHhtTlpVaFFhcGpZdFBJQ0toanQ2bUxKdFl3UHYrRGx3?=
 =?utf-8?B?cERnek1INmpCeG1rRXJsUGFkQjZVZ3IvTkp5amprQzdyMFhSNklyY242eEUw?=
 =?utf-8?B?dEpYRHZUZncwOGx2MUgwcllSUWl0VThETkJrWDI1WGFLd0VnN1JCbktySitv?=
 =?utf-8?B?Nk95bFFhdTB0V0MxTTkwUU1xTUNTaEQ1RzNiVS9UK1N2RmlFdGQ5YVZLaTNM?=
 =?utf-8?B?MWxtZGRHd3ovQWRVSUdxcVQ0SnpvUWVPYXd0V2RSWGxEWE9lc0FmcjdXRlVV?=
 =?utf-8?B?QkNhUk1adENKa2pWZkxCY245WDNsbzdxaDFqZy82aWUxREFlZzdQUWpGMlJp?=
 =?utf-8?B?M0liNDFnczJYNUEvb09LUzhjWkF3N3I4ZWc4cnVuRlRQMno3NGI4Q1J3cita?=
 =?utf-8?B?bGRCcEdrSDdZNm9SNDVDajRCeDV2bmdadU13R3NLTC8wRlJKZzJsbGNpSk0v?=
 =?utf-8?B?S3h2ZjRXbWhTUkRESGcxejV1ZU9YT3dJWXZMSnVXLzh6RnZBdUJIMDlJOHNU?=
 =?utf-8?B?VjI5M1B1Q0d4cTVRbERKNXpCcElnY0lNMGdrRmVEaUVJZmdJd1BqUk1kOVRL?=
 =?utf-8?B?WGJwMkVJTjNURE0rN2IwLzF6MzJpMXZibzByY3ZZTHJGQVI4dmZJQXp1OWlS?=
 =?utf-8?B?K01KdWVhSU9oUDF2aU1pM3p2Y09QYk4wbStMUnZoSmxCQy94dGwwV0ZjcW1w?=
 =?utf-8?B?SERIUitUallyem9lckJDMjBTZktEWkZvQXZSVE52TjM1d09uOXEvNG5zN3Ji?=
 =?utf-8?B?YUxkZnp6NjUxc1RrTXBCZ3FmUUxMdEZ4c1c2Y2prOCtSWXNiUVZIYWU3dU1E?=
 =?utf-8?B?VEFPRUZWSUorWFp5TFRLY1pSaTBhRVBXVU5jZGpua0xrVnZMcGNKR09PUUZk?=
 =?utf-8?B?OEl5TkUzaHhNS2Qwa1M3MXNPQ0N4UlY0dEozSlI1QU54WnZxM0FyeThJbW41?=
 =?utf-8?B?YTZqK0VjblQ3d3daMTFmekkyQXNDNDY1UjI0UVAzeE9NODMzYUFrYk03Y3VX?=
 =?utf-8?Q?oC+O7bOMn1ZEHuaxBKD51O78e?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6979a2-87a2-4160-2ffb-08dc063e23da
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 18:11:53.9963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MW4d7YHfeyPoSsnc8MuM0Ci/1tEUnQax0lHvbTp9exHqKrucIVR1UyPGyPOWnSGHlaSy4etzFFb8P/gx+F9vQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9868

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


