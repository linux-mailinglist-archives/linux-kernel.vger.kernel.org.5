Return-Path: <linux-kernel+bounces-13466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1740E8206F8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 16:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B758B210A8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 15:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E25EAD2;
	Sat, 30 Dec 2023 15:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="DqxOBoJH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2077.outbound.protection.outlook.com [40.107.6.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E890BA46;
	Sat, 30 Dec 2023 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjdlTf1wq+o8HAGrxLbaYJstOiA+Ii/kFF1rtZSrcW0HBpU7xHZfEBvllAu/wbz67SyKIGvfK325Tn2dSx/c2j6Vlf4wbFgh0oueCF1rJ/GSnF+w5v4QShbJz0bFpQ36txwHbZHn2FcN89giI5CSFK2o8Gy/D5P3SbsDVVcxyL/ueqH2azsEiCr3L/mZ1fuvVdZoCURRhyK4SM649gsVIZVkP+UddABAdbYAjN2X0tB0WhHFlT5ei9bp0ZcJrIkEdcaXdPVlHMkej2TTqAU3xRNVL/kv5Y5n0MyXNonv52ndsH8serrB9IfUZeFj5oHcNo38prI+r5UuwxnD7gdwbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P40i+6AVm8IdTbDuAqwbFqY4jH9ZruaP6Q9zKpBfGZ4=;
 b=ilIySovV8v72u6tm10BOYIo++L117moBIXBzQ8wjwOzob7omtjBE7l/ZLsCLKLZ2NsPmai08D6hSWpZv+qhR2rh4BV8kik3dgGlbBJjnmZLVl8/d0F1MK20eZyybDIlP7dQVhtGZo3nRQm4oWnhw1mUcVzzsKOKZ5AMmee3i8w6e/bNK22ziZZZRStr7bN6/4CcUlKQUIetkVEktInWxCpA9ykG012cTWCBTDoA4QJgltpfl3WGwUOwJkufGwUimuUwnz1OkDMLxw0VBFLYTOuTBRkCguxbm1Mg9aeahiOZ4WvolH1YyYHBC9QaBFHY7e2RS0MEy2FDRqFwd7Eq16A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P40i+6AVm8IdTbDuAqwbFqY4jH9ZruaP6Q9zKpBfGZ4=;
 b=DqxOBoJHwesBWpYIZ8IMHKY4bggyAOiIr3vh0Tc+/6h7GvoAq4OL8t/uLqoVF7mEuXYKWBPg69AOEnpO8+9kbUJdBF6OjQ8NOxGYbfE85D8+uvFlBRKFrLUsg8xtMxOIZpt4Pky6cpD/nNVFFJysj/KtxHVn06cfWDt0V1uZCyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB9PR04MB9704.eurprd04.prod.outlook.com (2603:10a6:10:303::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Sat, 30 Dec
 2023 15:44:50 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::4db1:aae8:c643:2e73%6]) with mapi id 15.20.7135.023; Sat, 30 Dec 2023
 15:44:50 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 30 Dec 2023 16:44:44 +0100
Subject: [PATCH v4 10/11] arm: dts: marvell: clearfog-gtr-l8: add support
 for second sfp connector
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231230-support-clearfog-gtr-l8-sfp-v4-10-1d7f0e2c7128@solid-run.com>
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
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DB9PR04MB9704:EE_
X-MS-Office365-Filtering-Correlation-Id: e1a0116f-4dbb-4d6a-de41-08dc094e4222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EkR+7IGBzbgVV3GQx6p+Z5uHFH+tCBFGGAhZ8zi0DtjWlvRHKUk4JatNOE1fwMsg8f8MJdVOGdEkoLQZED/2WysOiq7/S7jxZQKoxtCzecCuOOt8Pd6FYQLXGX7QN2BVeDPZS8sOMDKLIADT5yPWVcRPaRM8ENfEObOZD8otMYTn6eyC/76QSNZJQYMkvKrkUt+65QmCnnIVpXriIWxlPK3MgeIAu+GdUHyMyenUpCMiCbOik9ipdj7Uy4FPqBnLhGQ2nkD1AdZsagXAIH9Zd/IHoeOMyvwRj9FbZaJd451pFiJZnioFejDksLInkhcaXvOAQ5QZe1168kl+jD/+xm1NfUALvFZAjqkwfwXECjb4QSQkQn+9It1PKwPZZnHQfi0Yru0BM8JzPaQtGIBsxFkbeYfz4TqWJ59PX2fE96jcPCvd2AK+kMzHVLC4+YtsZ8cGmn2aiNVPc0pcPNVxpJvNRQdGf3Y/J7eE13Q4l+UXLBJKdedxqeFQ+jXZZ9D70Stsar9r51SiPRXDwF24pPBn8paYuMgLAJ23P0dbLnuK/HS/2rt+5p0pvQwfMyaRr4HuZ7GyA64CeL9emIOMVIp0DVvXbqLkqwkUk7obkaVO0mhs5d7k3r2VIV1DRCxm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39830400003)(376002)(136003)(366004)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(26005)(2616005)(107886003)(86362001)(38100700002)(38350700005)(6506007)(36756003)(8676002)(4326008)(6512007)(83380400001)(52116002)(110136005)(66476007)(66556008)(316002)(478600001)(41300700001)(2906002)(8936002)(6486002)(6666004)(5660300002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVpsaVdxeng4R3pHbHlDaW9rMStiaHlXbXJaRjZHR1owMTlCamRvOVV2Z3U4?=
 =?utf-8?B?Skxab2pCYVh1aFFBRUFZWmJvUnJlZkljaDY1c0FVb1RNb2xINC9CYkYzOXkv?=
 =?utf-8?B?c2hkUTgwOU9HeXNvZjROaGNXN0FqdUNxNGJkZ0JobmsxUk9MbDhhSjUwT0p1?=
 =?utf-8?B?MlR4bDRoWjdTaXRQMU9RL2Z4ZFR3M25hdWhUcENYNUlEVjJQL2QySE9YRGRF?=
 =?utf-8?B?SGp6TGlLcml1MytucTFZaFRXbzMreGVXbCtaSGM1Vmh0eExhL0pMZ256dkxF?=
 =?utf-8?B?VUoza2FPODBuWXZ2UkJOVHRYTGZWSk94SHJBZHlDMXV6ZnVCSzdQdVE1R3Bw?=
 =?utf-8?B?WkJuMHNlM2RWVlovQmxDMVJHM0lwZjFNdklFSW9IZUtXcDlCQWcveVVjQksz?=
 =?utf-8?B?Q0ZOdGRCMGRkdjg5R0dVZzY4TkxZNlhlaU5hMU5pa0lXT2xiMnZIenBmYUNP?=
 =?utf-8?B?WWx3aHppTWVKWjZNTEF0SjZuekx3bVVlVzFCaHBJT2M2ZTlFL2J6U3hMUUZw?=
 =?utf-8?B?VThzSmVtQzhxNTd4c2hBUmF1QlFDZGdBTEFHUVNhUDN6dUtFUGhsOFVVeTAv?=
 =?utf-8?B?TDIzVnJlcThGWld1Mk0wUzBIeXhZL3Y4K3M1cTJndit0TFpjd2FaM05vQzg0?=
 =?utf-8?B?YUdRYVNVVmcxY3JmVHhiNnQxa3lmSnI3WEZWNW1HWS90Smt1dnorbEtOTGNF?=
 =?utf-8?B?czNjeTZFS2sxalpUNDNkNzNTNktRMStNRjI0SU56TU5kMVZoTmNGOXZ1ZVhY?=
 =?utf-8?B?RVBkNUVWN1p2U2N2YVBsenhUdzFQeXA0dXliU0pXTHVqVDdySHVNMmg5SUVl?=
 =?utf-8?B?QnNUQjYxZmpXbnNWU0dibmh5MEhEZlI2a20wZ3F1SGZPWW9hTWpVZ1lFL3pZ?=
 =?utf-8?B?bTNnTjlydVQ5cEptd2VUSjJzTHYwdU5FR1dUZm9XQ0hrQmVDYk1PWll5b3kx?=
 =?utf-8?B?OW5OWXZsaHNkU2tpbmVIbVRSK3lCajZvZ1lhVjBvYjZBM0FWSUJwUW82MmYx?=
 =?utf-8?B?OUlRZFovMlZwVDRycFpFQUhSek9HTzR2VzBob0VXS3A3cUowRHAyOGVxcjZW?=
 =?utf-8?B?TGN1KzQyUjF1Yy9CMk5nejJnQU5TVE1pcFlOZzRSNGJwZW9LMGxJeGZaME1V?=
 =?utf-8?B?R21zNERFTEpwbHFndWNRUnZIT2p5ZmZkeUFTeUs0dUc3dlVrZmx0VDhLQ05D?=
 =?utf-8?B?N2NKZG9aWDl6SVl2TkZwbmZWVEgwcG8xbWlkTmRNMHY4VUIraXJLcitvL2tF?=
 =?utf-8?B?TmhxQW9WUTVBcjlsZHJ1TXMyajVJVEEyb3FOOFlJYUFDQ3A1S2Q2a01VMnRX?=
 =?utf-8?B?Rjc3eEVWUW9IVUlHSHZYT2h0UFFYUUpqbUtxS21oc3hvTTQ0OS9zZzRCNURs?=
 =?utf-8?B?Vm9hcFlTbG9maHYzTGloV2daUWRoeHdBb3dXU05VUmQ5M0Y0clJtM2xyWDNl?=
 =?utf-8?B?aElvdWJZNlNDd2VkUFd1RlVVUkx1bm1QVHV2blVkSHgrV04xU3RoRVFYSzcr?=
 =?utf-8?B?clcrc29RL01STlYyRm9Zd3dPdURIL3h2a2h3L1YwN0dHWDBDN0N5U0dEWmI5?=
 =?utf-8?B?OVpCdyt6WE5YTDdnMytGNUY1V3B3UGtiWnNFMm1VRGZFWDlSS05kbVIrRndS?=
 =?utf-8?B?TlI0NDY5MVVlRVhJbGNnZmdoT0NydlZ2YXU2UGF6RE5laFRqeHVPR3hiUDBq?=
 =?utf-8?B?ejlwcEVnd3Z1UzVJeEhKSXVmSkZaS1hjMDdIbk9sNEUvdzlEQk9oang0Uk1H?=
 =?utf-8?B?THN3N0Fmcklvc3pKVnpVRnAzdHlqZFRMeXozNFFTcnlkeWI1dFRtZEFUcUFk?=
 =?utf-8?B?WDhCRUhBYjBaVkhlenEvS0hMTU5qVnBIdnVNUVBNeUlpZ1VHSmYzRkV0L3Q2?=
 =?utf-8?B?dWJZL3A0dnRmUVdGY0NHVzdiV1pkb1FJREVBSm5nS0ZEYllhaUNFQUY3YkUx?=
 =?utf-8?B?ME8vTFJDYVBkdmlSSGdtczRWay9JUHlJeFlWbk1VVnBSK29ZQk9KQ05aRG1n?=
 =?utf-8?B?WUlLNDFWcytFeEJRWHJrOWd6TkxCMVFIMS9kSm0zQVNjTmMrdGF1dHArOVFI?=
 =?utf-8?B?ZGJiTEZBZzVKNlVJM3IxL2tDL2VZbUJCanI0Nit4NjBWbWR4MmFpNmRhUGda?=
 =?utf-8?Q?tHIMKNwkJQF21sXpH9tqhfJ9Y?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1a0116f-4dbb-4d6a-de41-08dc094e4222
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2023 15:44:50.2648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/GO8CbJvdVDri2u00fH25F9ea8WDx3bwmngNaC+QketZgHd/Qaf48oeujZTrUikoRUoT/rXUAJoO9vZg8x64Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9704

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


