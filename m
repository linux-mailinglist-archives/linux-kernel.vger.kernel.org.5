Return-Path: <linux-kernel+bounces-13472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEFC820703
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 16:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6500E1F21D6F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 15:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91764156DA;
	Sat, 30 Dec 2023 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="IarIyMOX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7523D14F70;
	Sat, 30 Dec 2023 15:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLGr+gaJvC+oOj+IIgSN0B/DjiMzh8bEj5yXrl0Rl82pMXptk9PRzA6VctoW9x/mbptFzSmg/AGW/CtQvZU6R/hXwkkNF/kIGRYYlzpawQg1VnKhUCsIwWCkzwY+WmrkYA5FsABpCCgRYgVBvhngnKQEW5kqAub8gQwofAJQzV7YCRy+l6tQ+xMrE7pj024OGQTDhNZaONoOS01sxEXE9s9lj6IVKpq8ev5oKVQQdq+9gDPLp/xkW1wPHPg+qyW2taGc8D6ljErqOdUPQgEPoApJCrIEWIl+j8v87UZhIQmxZgS8Lt92T55Dkk8ls+d7GhMWjeMOTVjAV8vuyzLsYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVv2+HWSJb/Bvvy/FVIMBCe6S2QDYRd1TZN8Ua4xMS4=;
 b=fa1Dh7rkTrm3rsO1WSgC/dzuS5W+z89GnSVbb140yo7KaTb9AFcct+aJ+zlHSLBtZXq4BXO3vClVRtpcbLH+DR1f7hxwW/OvHVseOfbSfoDxYo3Hd/8UKbn/pyOjeo9xKhudYMaBK5syVkcGO4gdfzj/JYD+ExxYqeycmfceWfBbyY96L/31miCL2d3wnPHfpyzf0Sv2WGzwVrN+mGI0x+aAWZyAhVTRZpof8YjFU8m7LinWQmUktN+V3JbYxT2/AdOLBH0SEU+RlJ6z2uQ3i0pM8sG/T+exKiQruPinFLKohTcdNY7la9kZDNLHlGGJ4xegq2Xw2j8+j6I6pe2aNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVv2+HWSJb/Bvvy/FVIMBCe6S2QDYRd1TZN8Ua4xMS4=;
 b=IarIyMOXUPN09FSolhtquBB1Wd8GLE2WuYIspeg5A9+lgxHfPYi0E9e5kAAX1YY1vghfzUgAT/Sk5/c3BiyHr8MfocZjs6/UAyhY8Fx2MHH4M2gavqcU97LBCxdYgh1g41dHQU1M6PvAMEltRnIZam4y2P66/hXcLuXGqywUibA=
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
Date: Sat, 30 Dec 2023 16:44:42 +0100
Subject: [PATCH v4 08/11] arm: dts: marvell: clearfog-gtr: sort pinctrl
 nodes alphabetically
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231230-support-clearfog-gtr-l8-sfp-v4-8-1d7f0e2c7128@solid-run.com>
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
X-MS-Office365-Filtering-Correlation-Id: 599808f9-10ba-48f4-f8e3-08dc094e417b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TBww3xy5Mp7CQI5eZht92Du2SVvmQBtCwsXBt3SSJDZLPf71QSZ9c+6YARyuiwMOOpFaBlBmaagMSSmX7ViAx13zuATbjsEyPajW5JHqBr2ObxNqQiTYap0WwHahwwlc3oR7n4lv+ecc3POIBg7v3hkrtJshA3MRu5u8B3zFIi97X04w2VGZtSlDQghPvkgDhAt6wClTWDUHNf0Sz0l8SbNE6AZIvbIPswiQfyrWEdRvpWlSHG+4R9iawYjrS8fRwZHsV05fYFXshUt4DL8G0UFGyDgkXN+sGPpKYVjaBox8xLRpao9wLFa2q+zwxIXvIHQW6tPacVvCto0wmFCuUkwKqKyGrD2/otWHXEGAA/JV7ICzRpUDsNbaJ+SwUuklxrv3PzjE6kJBeaQgle2jgWUkylRQYI9CFgW+nN2NWqgUbnK8NLTtULu93MJKFsQmImya0xiTHIeuSjq4H0MuAWv/1h7PIHxO6MLJaJLWlMtt8oj33ZIJ6WFE/HOVLU48mOSRB2qN4DOe9vjdBR2Y1eBmrRdHz15z4OuxD7v5jEzx2ZdqMRZOGwWDH9Wyq3RhgGH0VHazk5l2cFNOSb3lD9GR85w7GDz11zoVMzZ03/mW3NIPaUhbDNon4z253pZs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39830400003)(376002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2616005)(36756003)(2906002)(86362001)(107886003)(478600001)(66556008)(66476007)(66946007)(5660300002)(83380400001)(26005)(6486002)(110136005)(8936002)(8676002)(316002)(4326008)(6666004)(6506007)(6512007)(52116002)(38350700005)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzdEYkdHQVlxMGpRRmVCN1Q5eWZmUHB3SkV4NExvR2xKdnlTZXlVZVF5SzZV?=
 =?utf-8?B?UHpwUENNTWVyMFRoc25rcVdZeXdnL0grb0pCU1FjWHpMNkVueXRnaWRZcU93?=
 =?utf-8?B?Mks5dUNSNGkwYzVJYlV6aWV2UGJhV2dlaVRHM0x0anVJOW5kUUlxQkN2ZUZq?=
 =?utf-8?B?enEzTUV0TEZseEpxMEhDZzhuT1NYVkVneUJwcnBKTENPTXpyUFMwaWdSWEpw?=
 =?utf-8?B?djgrV1RKb2RuN2ZaQVNTVk9rRzN0dUNsVUoxZHdjZGh6MXJuS0VrTitkN3No?=
 =?utf-8?B?RFVpZU90cEVHSmp5aXYrRTd6UXpyZmJGRUxKUCtodnpSMXZQK05vSE05VXFs?=
 =?utf-8?B?NDhrWTFabUFuZjEvRVBtYkFWTGRZeE1zczBnTzNqMk9MVUtvYUFwM082U1U4?=
 =?utf-8?B?OUsxZ2RUTkRjSWRiVURKZTJPNU5xYlZGYjg1K295aWlDRHJ6eFJUQlY1cnlp?=
 =?utf-8?B?bUVwU3gwM0o1VU5pUjJOdXU3Y2UrOVBWdmM0ZDh5dTBGTEc1Q0Nha1FXaEVt?=
 =?utf-8?B?TGVrNW5rR3FmNWVlRDg5OGdYcTJsMDVMQ1dKazc3NTZ0emlNTEZHVFlrOW9j?=
 =?utf-8?B?OWpGcDVVS0lZclRsSzllWUFDODZxREx5RktnRlo2aGJDSHBEOWZaNmxpcXNG?=
 =?utf-8?B?ZGJTVHNMdlBXZ2xrM21EWXEwZkh1cVNZQUVQRlFmSzdHSWJ2MDZ6UlhFR1lC?=
 =?utf-8?B?RVcrUkFTNm5rcWt1bkRENlRUd05YNWdiNGhyREV6NUkvUUlDZlB0VWl6d294?=
 =?utf-8?B?eDhRREhRcEoyMmNSd0NqdGVCeHU1NjNYU24zOElNTDNkdGVXc29nUmxhOUov?=
 =?utf-8?B?RVgzQ2pDNzBRbzk2cWV0cEUraTJCaVFDbUxGMnFBVUNzUzBSWDlubytLaXRG?=
 =?utf-8?B?REQrRG90ZHR2Y0V6aHJoTHk0YVpIQnluT05kVCswYjNLeFJvdko2Ky9PYkZW?=
 =?utf-8?B?MmtIcjRmUitLb05JdklrZENnQm5qdkJweWNiM3VHcTRVVndUTWxSK2hmb0My?=
 =?utf-8?B?QnJaZ1FMYjFSLzdjbnJaWlBYUG5xVnlEWDFIdUsvdUZWSjBsdmNQS0lzdU5y?=
 =?utf-8?B?S1FrSVlrZ0M4K1UxU2dQbVZzVjZrd0FQYTVhTXV6NmdOSmJTQXBSd01PRThS?=
 =?utf-8?B?RG16Z2kveU5kNU93cWt6RExETEJmbEVtWksxck1vWkVjSjZ5dERqcDdEZkpL?=
 =?utf-8?B?enNQMGlTOStudlV2RCtyb2lWYzJWeTVpbEhZZkd6ZGpKMHpYU3I4WDdRc2R3?=
 =?utf-8?B?R3lobUlJd2U2M1Nmc216MUpNUXpwV0l5RVVwZnp2bjltbVpRck91U2NjQkdQ?=
 =?utf-8?B?NmtKWS96VEMycWFlTHJuNGJGa3JYeFZ3bDhOdUtIRlc3VE9sTUhHK3FLVVVI?=
 =?utf-8?B?Umx2VUlwdU42aWQ5Z2pVbGw3dkJwaUtuZG1TbDlSa3JyZXBTcENrMERFQ21O?=
 =?utf-8?B?YTJ3aklkRlgrUElSaEc3MG1DbmtrWDliOW94NG5WNTJSakRaTGxhNzgvanMv?=
 =?utf-8?B?T0hPdDhwVHhrYXhqVDd0aEJrZzhRYzhOcExiYm1hOEdtQWhXVlFWbVc5dmNO?=
 =?utf-8?B?UU5RTHRZZzFzaXg1b1NCY3lodGJvR0pGUlBzb08rMnc1V0tSQ1hHM3h5emRs?=
 =?utf-8?B?bWdZZ05EVjhLaVFnendNZTVyQmtNeFlRWTJLa1l2RGFFN2dicnE1TWNwQ0Q1?=
 =?utf-8?B?RHpqUEI2RkkrbUJwb1V1NWIzZG51ZVhDZWprcUl4NVFLeWV6UHB3YjhHWWk1?=
 =?utf-8?B?VDhXVlowK3VwNXNpcnRVVUpBM1o5V2FYeVlRdGdNbk9nR01WUUNEYkdJRjNw?=
 =?utf-8?B?dEZRZFhuNU9UeDhaQ1cyR0ZERXpXMGg1RUJQS0tlNi8xZGxuTnZ4OG9mUXRn?=
 =?utf-8?B?R21tUGlTbU12UU45VGtGN0lWSTFHTG9NZjRBZHNFcFgzc0JYczJUSkhLYXp2?=
 =?utf-8?B?eFRIQUhyTHBRckphbXp4c0htK0ZpWmN2RW9lQ1pXVm43NUxsVUQwM29sT0RC?=
 =?utf-8?B?amxjNGpJUVAySWNkeHRQK05sd0psM2JqOUU3VWM1TDJ6aUQvRFlpMndlZUhM?=
 =?utf-8?B?QVFJUWF6Zis4ZmZZSzlaaWJSSWt4UkRGTVNaRFlDd3MzNjdkTm5UWnBRMU12?=
 =?utf-8?Q?wPRR+RKBvCLA5pSx94isQVXas?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 599808f9-10ba-48f4-f8e3-08dc094e417b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2023 15:44:49.2367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5ASTCqCE7GUb5Q6Big0n+xwl1odc0lGz3X869rcmNuleqVyhl5iFWgrxRN2FvjQD7AiNhIZ2ogLYDUTXq1ydg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6970

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


