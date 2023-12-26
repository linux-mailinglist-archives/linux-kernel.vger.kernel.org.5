Return-Path: <linux-kernel+bounces-11614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF8981E8EE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A828D1F22A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 18:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DE154F8D;
	Tue, 26 Dec 2023 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="haH4f9pw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5428554789;
	Tue, 26 Dec 2023 18:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1f0pSbCfqkSCRSCNW1u+SGLLda/Ljw6KsmDsA7fSkTLc++FlvzLWV7vBSi5CiHFgAKCDvTQ3j2A2szKWbPYCnlY8af/boYW7jsy4Y6jFca4CaEiasWYSW738O1sfxljnl531NBS6Z7ljFY7IjJbazhlHYIevnCSvjonR3LCfyajHmvj6XpwamsVwpo9PhEpXAqGCWJ133fD7vumu51TaZkdVQZzCF9vSiShXX3p9llUH7pdhJ7xPzEWLkPD0MtHhdff/5n52TiG1YOzk3tg4v9/dMxX/T74FB09102CX65CeCmOA4jCfhvrWCftDgoV5gAH7fGayKsCY1uo6FJMBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P40i+6AVm8IdTbDuAqwbFqY4jH9ZruaP6Q9zKpBfGZ4=;
 b=ZQNpoNyl3OeKkYg0AbdEWBD/YbXlRocB4dXnY/uzBRTCy3vfhRkFndBNmIrP4TqJPjDufC13mB8kiR1ni4R0StLUf0uTCnkOkHhIl8wuFovrEHO5PTNLCHkI8CgvRb2hYQsrfre+S8iId99qS1VH1KMDOEUKXQEGfsMdac0EZMCZFHewSqzmMY8NLxie3U049gY/1vZvRWWMkSEyfUukgaeXjIxGLJSTOjuxx39PzEE3q4f3YaIEVbscrjtmhthaIycJwy684J1T6fQP7NlLx8AU69OUSrMzoyKaan1u/GFaqc19W6B9dYr5OXvoBp1IIdfq7s9ELzfwQcBBcQvQhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P40i+6AVm8IdTbDuAqwbFqY4jH9ZruaP6Q9zKpBfGZ4=;
 b=haH4f9pwoawMpz64fqKuL4hyVtaAFo/gu4pIpO+/VfzLxKawd/PwujjOrCW8LYHQ/y/BIOHd0u0EZ5dRNK6yeDS2I4XD6Zv5ZjNo+E8690bE15kci5HAKp486a19e/ephL9nxfwPTHhDH634NTzbRv3t+YFvebVPbxt4DAo+Eic=
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
Date: Tue, 26 Dec 2023 19:11:38 +0100
Subject: [PATCH v3 7/8] arm: dts: marvell: clearfog-gtr-l8: add support for
 second sfp connector
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231226-support-clearfog-gtr-l8-sfp-v3-7-fd1ac2d6bf2e@solid-run.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6098bdfb-6c62-477e-8fad-08dc063e241a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TnrqY9GbIBYirlaMOqRxcgaHauHcPGW+Jqc1uD0CdLaXdEoPwR1c9pcd1j3llMgKH6IO1L0K2YlgsUfGfSk4JuxlSnr1Ghh9sjbfXV14mDdKF9FAtqMp2+VLNe+b29NEz8QMa6F1r2X+w6gq6fyKOCSkaajpLaBe77pdEOs7TWl2YxCXmXd8IpU906eXVbWQDjvutEk4nId0bjPry4GvAICVjQ8jsYvV2PK+4pHUc7SmWElFWIT2Og24B1Y23Qw1dKHZo7rE9ch5o9LqSjxAsvkwOXfMMn975Ia2oYDBcoUrGkdNcqJjiFVtMsOOYja4723OxVp/GPlTU5Z/qMUOEX4KGnV+iD9sx+TINfvWiXNipYfiUEJMhn+KdKWx3rteaQU7qkfNhCTGfj++1QEzF9kNriW8vau73yo8Z1Xrp8EATevn5QH+F1G7CXC/sbDL2OH4tYCaKLlTn5Ph0KkkabicfoZ3vBhhX7utF6bEmmi3fxMrQG52v/VNqbeBKbxzx6HXSA90GO8+cb/NZzWiMfBctUb+aTtoHQ90QCS5VoyIE8Li8uPEjCrlrWiEadYK1mdtONFm1nwsgMqNpGtf4P7q0dOwbkJMkQVJSJ1bxWDQbo+T7RoMb5sl4htKuYBb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39840400004)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(26005)(6512007)(2616005)(4326008)(8676002)(110136005)(66946007)(66476007)(66556008)(316002)(83380400001)(52116002)(6506007)(107886003)(6666004)(38100700002)(86362001)(8936002)(478600001)(6486002)(5660300002)(2906002)(36756003)(41300700001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UU9IN29OOEVhakp0N0xZdHhQMWJiRlVQTmFoNGt3YVJHZmpPZkdDcGZqbzBx?=
 =?utf-8?B?NkY0WFBBcG1ZVURqLzRhRkZkVzlDeVVpVDJUV1d6Z0paY216ckx0dXN2REtw?=
 =?utf-8?B?c2daS3hUSnU4M282MXBLUWFwVyswamFuK1BiQ2x3Nm9LMkp2a3pGR0dGU0Y0?=
 =?utf-8?B?cnhZY3JuQUFzSVcweWw4ME82aE42VmpkbjlFKzJrN3p5VGVPMXY4c2srMFZC?=
 =?utf-8?B?QVo2OW5xL3FDazVoZ0JnZjl0ZTB4aGVZTmRHbG5kWFI4YnVXVWI0cFZLRGRK?=
 =?utf-8?B?NWhpR2FORmdZMlRVdGJoU0tvWDJubEpjazQ0aFAzN0tNTk8vZWh4dDBaM095?=
 =?utf-8?B?anM4eFBHSXRnMXZWQTZFNkh3K0NOT1BBUjF2M01PSTAxTE16ZVV2cm1RN0dp?=
 =?utf-8?B?WEg1QmQ2YXBRSzhSdmEwNk1DSGRZN3ZxMS8rK0xWZjUydnphdWkzdlFLdU5w?=
 =?utf-8?B?bC81b0JFejhLek1neitZL1FBWnBMdlBiUDRtbEUzL2FHUjJ1V0xGV3p2U1Bl?=
 =?utf-8?B?KytTZXZwMmZvOTNuTExhRmliWWtCMVd1aFJoVWtiQUxSQ0VNUzFEM1FmVGo0?=
 =?utf-8?B?cFdHRzBWVHhDdFNIUzRwWGt3ejFkcHZlSXNNUXFNYS93YVZoMy92V3hvTG5j?=
 =?utf-8?B?TGMyR0Q0SFUrOEN5VFRObENLK2R0alpOUXdTM0JFK1N3N1krMXJoaFBVeWZF?=
 =?utf-8?B?L1lBdWpQVHVKN1g5dWZLVDM4bzJXM00vVU5CbDBVN3dZMGZRS2JoTnl3cEl0?=
 =?utf-8?B?c2Izb3RpN2h1TjhXaVpibmhsU2Jjb3BBMThaTnpDL011MTdQcmZJSVo1Vmcw?=
 =?utf-8?B?K1N4b2U4Vk5XREhRN240eW4xekFXYVFuZjZ3TkRvWmNyMC9BZ0R0VkY1ZzRS?=
 =?utf-8?B?Q0ppc1k3TlVsbStnT3JVWE4xaXdMRzVtK256ZU5HbWJVMTFzZ2NieHdtakFz?=
 =?utf-8?B?NEFPQW15MFRrMjg2MUQvOFFvRkJYei90ZERtOXNjTThYd2V0aVJhNTczTmdC?=
 =?utf-8?B?dDQwNmlySjdLOGN0VUZUWldxYWJWMk52ZlFneWNPMG5VV1d3bG0va0FmUXBz?=
 =?utf-8?B?ZGRSYjdTaWFvU1NQUWRNYjRqNGxKU01iRzBMcTQxUmN3NWpFU3FLUkVKQlVC?=
 =?utf-8?B?M0VIZ1UvYmNUcDF3Z1EyemRGK2JabTJXYTk3WHdHQzdxeUhkQjRiNUFkbnFy?=
 =?utf-8?B?Z1QreVFia0RTZzdZN0h3SU9QdzhkaldqNEo4UnZRcTUxR29EeCtnZFdYa0lv?=
 =?utf-8?B?YmR5dzFzTmtxK2Mxd2NLN1hIaEFYSndKTDB2Sm1KMVF1ZlZHSGUzQ05RKzR0?=
 =?utf-8?B?RXBkNHUzdGlYdnRadEhoTURTUTh1NHVuSEhSS1VkbjBFOWR2MEZqZGIyYmh4?=
 =?utf-8?B?WEVBaWtjQ2E2L1JXaUhSOHFUcnJXOUY1TUpGRUlXNVBxZENxdE5ZK1F3U3NV?=
 =?utf-8?B?bHhlK3g4UFpZL0hZTlV4V0J3VmJXS0V0NVMvOXVyWWM3cWFOTEgwWld6TWk5?=
 =?utf-8?B?Sjh2b3FXaGQ3T09FOTNVMUpHK0Q3MGRtUWhLN1IxWjd0M2s3Mmx4YjZEdktj?=
 =?utf-8?B?czNZeHRQNEwybll0TzQ1RHBzOFRySG9mbTFNaDVKaXN6T0taKytOY2ttTTND?=
 =?utf-8?B?SURzQW9oeGdPdW5Yem5VdGxrMHNUY2RnVkNxemRDMXJLSmloYTVUa3ZVNGRO?=
 =?utf-8?B?aTRwU0l2V29xbmRZckNPSWQxaU8wOEh6SjAwMm1hUGRnMk1JVDdDbjRjLzVM?=
 =?utf-8?B?NGdEWGFFaDVqQTU2K2tnc2pmNVg4ZVE0dzVyVHpaZ3BDMHdWUTlDUjRPRVU2?=
 =?utf-8?B?ZnFNWWpZZVpubUlZMSs1bmVobG1YaFhIMC9xRTdnT0h6enZ2VHUxck52SnlG?=
 =?utf-8?B?cmUxS3QvcWc5Ym5xMWVqOExrYk1NbTArMUV3U1Y4blR0REFGSFc4bXRQdHU3?=
 =?utf-8?B?M1I2bisvKytxa2VpV0FOdVIvdURCNzl1R2tGNDV6M292dExCc3YrR1lnNWxl?=
 =?utf-8?B?Z2ZvUjlCSVZsRGIvdGtIWWtucC9YaUFCTndXVE5HUGFDdWluTm1XTWkvRmRY?=
 =?utf-8?B?OVRPNGpIV1F3bXU5UGV3QVlZY2gxbHI3Q0c0RFVNWXBXR05xSEJOYUYrNHJ5?=
 =?utf-8?Q?eB9UX4WUybPctuW2Hd1BqMAz7?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6098bdfb-6c62-477e-8fad-08dc063e241a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 18:11:54.4659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9jcW4pJf8T15xmSNNOv4c9K3aJ1Bp6CqWXZ7SVbQGi0Pqx6qCctcaLtDiQCElDMxUKw/UIcfBoPyTsw4LxbBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9868

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


