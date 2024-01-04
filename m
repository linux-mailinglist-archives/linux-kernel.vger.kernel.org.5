Return-Path: <linux-kernel+bounces-17064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4783A8247C6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 992F6B21CEC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E211C2C867;
	Thu,  4 Jan 2024 17:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="LdevKSTF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2083.outbound.protection.outlook.com [40.107.8.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAECB2C69C;
	Thu,  4 Jan 2024 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbzSPCC2Dv+9sJ/HCBXOB+dFgSwsXtyRtQO6oPjzOp5G26xNGjCLc9mjj8rGwjcqpgda3nnOPR+pI6jfhNAL5+ynRUj/CReXeexNaYrFYZ/g1mzSP0jhTjBM2EMEV11sHWHScmGuBCkSK7tKkP23h9cqaCXBbm5xfEWKAZIF2rGsxrOr3cKvSQS2c2PF2tHnYCMP6metk39+kEc7iXsqhsVJt38gVgbIBr18rTdZlRchMqox27NJgPhYLb7Iilo1hOka54rM0U9tVBxp2FoGNiLp7xGQ8JbKHJV/ehh5ogSmIJ+gkT5p+fRt6OuJ+L+4HuVn4mphSFh2FmOEwzANNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P40i+6AVm8IdTbDuAqwbFqY4jH9ZruaP6Q9zKpBfGZ4=;
 b=XMcGo1Nep3K1bIBn5HSlJzUYX9aouWituqqhl4ACZ7Gyabp2m7+b+WuzCmAG4p/1Lj3Xs7ymdT5vFjI3RRmbCabFT7/eJfNqqoaTc7EnukR/F3vB46CWqM2iUbt0ubOaZv0M6AYsJb0K8ZSxb0U08rQFXaLTzyZIohUCvdubRbtNxl4hKcHtq7fDEtHKX4e+ab41Yj1Ziv+NzmWNEfTuWVC+QRdDll7sgCv8FiBQBU8d14WCb5odIbAA0XeblA5smI1Ztuc2SC0Yok7eOk5VSp7Z3eLpkOyn7ixgoHOJvVOedA/oJJuNyGx2KjlToeIu+B7pQ/KQceDe/4ZcXy68pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P40i+6AVm8IdTbDuAqwbFqY4jH9ZruaP6Q9zKpBfGZ4=;
 b=LdevKSTFeR8/enr2gzZ0d/wi4GBxUeCIkq2rLZriydFLCo78Govr86ghgto/6taGPdFO2EVadzNj049msZez+6jbS93St7+TqSIEUhF7aSI01EhEs9mOXnb+7M3tDKXZVLwgmuWgI5SqBfN82XqPTZ3JOEzHpNfjpL/aPoC3uRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB9PR04MB8233.eurprd04.prod.outlook.com (2603:10a6:10:24b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 17:48:12 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%6]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 17:48:12 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 04 Jan 2024 18:48:10 +0100
Subject: [PATCH v5 09/10] arm: dts: marvell: clearfog-gtr-l8: add support
 for second sfp connector
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240104-support-clearfog-gtr-l8-sfp-v5-9-52be60fc54e3@solid-run.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4a22f743-7565-4aa9-aefe-08dc0d4d5106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WXJlQOyv4YG6OXzLGukNevac4GmFnpFokxNQcfNdfjJgwn3naV/a1DMmZPjDyb34frDBRy7fJXxMiEfDz8QQeDNYAC6hYEJzBKtV/mfv37XE4Nk44oLeaJ2frvyf9arCWHCHH9Y3WSj5WDllqjb4QZkpvBIGLWUsco8Esfoi+TrTmTor18hvTvYagV/s20Gsl7SUvEm7o8S5yTE8NtA2LcPSHoPu/dFuSaBkYY7pbZ63kvSYCyWqEswL7F4hjs7mg+LMt5ow8vLwLpMdTdtRCTK4E6SnCMCqo2k1ZOB5aBX0YJMAcDl/qxoK3LCtkosAT+Oo90RYxpyXLWOycDSA2B3Dza8PSe+E4vwOi5Ov2Akp8F80n1sT3nrX4ZfN9MpLw+eApAB/XI0wV/hP/X2nzvnT1YuRAlpntvEROJvvSaX1iSs3GZZL+oUYwToHwZHgjs4tRxzGdwGB88EKKaOicSnGcl4lvc3pdKgNBsWhWV/V0U0ZlC0PO66zsQE+1Ynp4nQ+6SA279XLqy9OKgZOS3s/lH3wZBBo/cJk0e37fzMp4f7QhjPDjk731HqKa7zmsbDMMaPnIDL7ixAfE1UBzbCLpJxZgTT80VrdGrRPLlzbGkRv5AgcXQBlitvMAtHj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39840400004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38100700002)(38350700005)(36756003)(86362001)(26005)(4326008)(107886003)(6512007)(6506007)(66476007)(66946007)(66556008)(8676002)(478600001)(8936002)(6486002)(52116002)(316002)(110136005)(2616005)(83380400001)(41300700001)(5660300002)(7416002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2Vwck03WUtpekpyOE5mN1c5QmYvUHRjY0VnWTAzaG5yZlBBVU1LU05IeTYy?=
 =?utf-8?B?YzR6M3JDOVc4d1pSWjd1VWEzUU1mVTRLVmp5QlNuUE9qK1pmc1k0ZVZEZmNZ?=
 =?utf-8?B?RFVBMVJHREw5K0hFcWtQYnhWa3IzZS9JRS9rRCsyalNZZWFUNWNyVW9SSmU1?=
 =?utf-8?B?QTVUMDhwMW9sSkVwUDhib01KT3V5MlZtYXpxSUFNUFhkaVUrVHNoTXpGcG8v?=
 =?utf-8?B?WVo0SmwxNFFZVHd1SEVIUElJTlFiWmtOYVRSYzh0RmpKbE5FZURuMGlqdXd6?=
 =?utf-8?B?TmIxWkw4ajZjb2liUURJUThKYnlmcjhlYWlNQ3BubC9ueGxBK3N4bS80bmZI?=
 =?utf-8?B?Q0pOVDlKbmJydDFabGlwUnNCY3ZLaFRQTWJTTTduMUpVLzRzRzNZYTYyZm9S?=
 =?utf-8?B?b2FPY2hLS2RvUGI2VzZwL0JLUm9HL3VnWnpOTTRkWmJIamQzNzNrRkx6ZzVk?=
 =?utf-8?B?L1NCWjd1RFpHM0Y3V09vcVVERDU2L3hsa2RIOHpDNjZQTmIxWXNtTnNXTkRx?=
 =?utf-8?B?RlViQWNZcmdhVW5Gc2lzS1JEdEF2NDBUZlBRblcwaHF5TTQ4OGFINlhjVjI3?=
 =?utf-8?B?NEJMUjJMUGFTNGtYamVVUW84WTl5RSsvSGZCZXhwMjJubFlwU2x3WXg0N28v?=
 =?utf-8?B?MEdsRmJPRG9DdVo0UVhBTHdvWGtzZFpmUlZCaXVOWUZDWHdYKzQ4QUgxdUJQ?=
 =?utf-8?B?MTBLbzJNNmxDS3p3cDZrdWk2dFlFc01LQWM3eWFPa2M3S2hMNG5yMHAyWHhG?=
 =?utf-8?B?bUhVSnVKZjY0YS9jQ0Z5TmZlRUlrbHI1b1FHQ29sdHJUdnpJUXZRS3JCdHUv?=
 =?utf-8?B?enpzQVFpSENYdVUwYVZEamFnSHQyUnBZVXB6V0VQYWhuam1pcjJmOHE4L1NQ?=
 =?utf-8?B?YTNCMkJCUGVtQjhobGxGdDJlbWQ5M3o1S2ZVc1R5YVFjT0dkS29FeEFzd0xT?=
 =?utf-8?B?UmJFMnJGQjZXNkFZT1ExUk9ZNDVxQVI3bEtwM21JdlVNRmtFQXJBYVpxZmdj?=
 =?utf-8?B?emliOUtIeGJ1V1JGemhHOTRjNnVZa3IzZ2o1Mkd0b1JWYW55RmxkU0tYMFpW?=
 =?utf-8?B?RWhFTTcyeW1UVVhiT05lc2pwN29pVkMzbXlkUGJZbGdWb2J1MzdBNStOc0gy?=
 =?utf-8?B?SnhrYkRpTVJCa3prVXVQUkxFcmhtditYTHlpVHJ1TnVWV081VnJXU29XdE5H?=
 =?utf-8?B?TktQWjI2UUY4MG9EdThWaEU2Mi9xQjAvTC9WQ0N3Q3RGTXB2Rit5dGJ0WXI3?=
 =?utf-8?B?bGQxU05jWXRmSzJnekFtZ0xHd1dLSlVMcCthd3c0dUJuUEFpWm5DVTJyUlFv?=
 =?utf-8?B?ZXNURjZITUI1NDFmRnhUWmRZMGtjc3dneXQ4NzEzaDF1OWcrTEg3VXQxY2Jk?=
 =?utf-8?B?bkY0VTl5TkRrb2Z5UDNjRE50RzRsbVVjeUV0VTM5OEF3dFY0UDBFaUdSMFpj?=
 =?utf-8?B?cHpONmptN3R4SWRvY3BINEVqdTlBc2ZSREF2YWI2ZUZhNmRXRm5rVE5HR1pC?=
 =?utf-8?B?Ym80NUN6SGdudlZidmRzR3dDc09iMSs1eXEvTkY5K1YrbmtYY1FSOGozLzdQ?=
 =?utf-8?B?bDhUbXIwT1FwVXZreGNPTmNmczFJZkl4RFVuNEVsRTJmMGpXakVpdWVPaTVk?=
 =?utf-8?B?UWtWbDR1Qi9Ja0dDaE9BOGFZVGxhdlRFNDQ4bmZ3VUV5VDBlU2RyK0V5UzVH?=
 =?utf-8?B?RHhueWlpMUNVajdISHp5UnExc3ZWVkdwMC84MVpoZzJtcHh4RVAxWS9nTUVY?=
 =?utf-8?B?a3pKNUZndzI2ZVl3eDVlenNTK2RSeEZsNDhRZzh4eGVoWkZKNFUrNUx6NXY5?=
 =?utf-8?B?NnB2Z0RKWE1FMUlQaURKZVp6N1NORWtMVnVGM3VCSkJBSnVGcFRwZXdoTy92?=
 =?utf-8?B?VHM3aG9Dek0xdnR1cXlqYnQ4TU1FTDBYODZOUjhVbzFsc3Z5UGJhK2tkSnov?=
 =?utf-8?B?Q0locmF6c2VranpVNUJnUFFrb0x4bXVvem94cld5K1Q0T2wxVldMNTRSQ1ZJ?=
 =?utf-8?B?ajJBeE9lVDZmNVlockpTbndCOHhOSCtCcENGdnFWdGIrRVlBQUFlbTJCbDBj?=
 =?utf-8?B?Qk9iUW5qMVVCQ3lEL2crd1NJUDNuRkhYWnZxM3dYWnZ6dXBIQldNVXFzTnp1?=
 =?utf-8?Q?eYHwg/kDVK6AFEyrk0EokTDwI?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a22f743-7565-4aa9-aefe-08dc0d4d5106
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 17:48:10.3694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZlvhz21v82GXRo0xixQX6nA6AS6O/wOeXz7kZGTjA+riU2y/ZFLP6wm2wMN8DHTLH34nX7HZoZ3iwqwCKbtKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8233

Clearfog GTR L8 has an extra SFP connector on the managed switch port 9.
Add descriptions for both entities along with pinctrl.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 .../boot/dts/marvell/armada-385-clearfog-gtr-l8.dts  | 20 +++++++++++++++++++-
 .../boot/dts/marvell/armada-385-clearfog-gtr.dtsi    |  8 +++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts
index cd5b070f1218..2df388f222ec 100644
--- a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts
+++ b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr-l8.dts
@@ -6,6 +6,16 @@ / {
 	model = "SolidRun Clearfog GTR L8";
 	compatible = "solidrun,clearfog-gtr-l8", "marvell,armada385",
 		     "marvell,armada380";
+
+	/* CON25 */
+	sfp1: sfp-1 {
+		compatible = "sff,sfp";
+		pinctrl-0 = <&cf_gtr_sfp1_pins>;
+		pinctrl-names = "default";
+		i2c-bus = <&i2c0>;
+		mod-def0-gpio = <&gpio0 24 GPIO_ACTIVE_LOW>;
+		tx-disable-gpio = <&gpio1 22 GPIO_ACTIVE_HIGH>;
+	};
 };
 
 &mdio {
@@ -68,11 +78,19 @@ port@8 {
 				phy-handle = <&switch0phy7>;
 			};
 
+			port@9 {
+				reg = <9>;
+				label = "lan-sfp";
+				phy-mode = "sgmii";
+				sfp = <&sfp1>;
+				managed = "in-band-status";
+			};
+
 			port@10 {
 				reg = <10>;
 				phy-mode = "2500base-x";
-
 				ethernet = <&eth1>;
+
 				fixed-link {
 					speed = <2500>;
 					full-duplex;
diff --git a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi
index 39ac97edb463..f3a3cb6ac311 100644
--- a/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi
+++ b/arch/arm/boot/dts/marvell/armada-385-clearfog-gtr.dtsi
@@ -201,6 +201,12 @@ cf_gtr_sfp0_pins: sfp0-pins {
 					marvell,function = "gpio";
 				};
 
+				cf_gtr_sfp1_pins: sfp1-pins {
+					/* sfp modabs, txdisable */
+					marvell,pins = "mpp24", "mpp54";
+					marvell,function = "gpio";
+				};
+
 				cf_gtr_spi1_cs_pins: spi1-cs-pins {
 					marvell,pins = "mpp59";
 					marvell,function = "spi1";
@@ -276,7 +282,7 @@ pcie@3,0 {
 	};
 
 	/* CON5 */
-	sfp0: sfp {
+	sfp0: sfp-0 {
 		compatible = "sff,sfp";
 		pinctrl-0 = <&cf_gtr_sfp0_pins>;
 		pinctrl-names = "default";

-- 
2.35.3


