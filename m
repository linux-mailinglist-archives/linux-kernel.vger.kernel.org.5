Return-Path: <linux-kernel+bounces-84909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D97E86AD90
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD86D1F2B331
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E6F13EFF6;
	Wed, 28 Feb 2024 11:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R/9OCBCC"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6236912A15A;
	Wed, 28 Feb 2024 11:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119821; cv=fail; b=Uh3AR37ktObV3s6feo/VtYXBOM2XLkdJDnTPHsTAWY6xABklSLqDEtGOAGOJrCsIKWKLZ5uq+B7NRTQNcHzjzjzzktk3h4V63byF4/LhwcEavFjsL8mlp52Pk8vHBbo6JS3jnTCzExrQLs38M9zNbVuhuvJ4FQnXW+k+et8NS5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119821; c=relaxed/simple;
	bh=kTPoKuhndx4QS7KfxCDZ4iB5xMMbEL5qh/MnEbFJfe8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UPx3cya+8j2PvocePqdxduBgMfzlUR9YJbiT92JM/yJz3ecHlb3SmDwzB9ipmKqKSple4jSPUsTjir6sfygxG/Xm+sKYFRshzrlTYaIz88Ux2hhy2k7QapSs1zB2o0HDJMhYgQIyJ9J34mLS1JO1vqeEMYvgkDQgzDHzgIAPclc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=R/9OCBCC; arc=fail smtp.client-ip=40.107.21.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoRHkJxsDHJNBpqXVrZA29+NvmvV5eFvwbMl8mlSo7b44kckywxWCX9B504z+R95JCD3oC+HSXZTfLxroFlr65QSqb4sV2LBvaHKDzqigqS3tV/WIZMF6oF67IopcLmoSdo9oDVt2p66P3qAC7zZQhSpbkPczfb4s9qABfjDD+vkcFDkZOggtcUBeCpmXEmac95HeNUKRDx21SPaRoFICvrjAjICehK1JJa8F/QUwNWBG0Hiw3XQlO9ryQI9towZbsOb5Xg2dhif5LrIsZVOm0GWMz05yWSXwbc1Hon2Hh3dhNIM/ki3n1n0jDTe9tMgRfgpkG4nO7Oi7PXU/GZAmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Af6/fAhUa3cDCp6K7qBtPbwiPtjox3Ber3+3lEicmcc=;
 b=PKtr4FA1iVsYBiK+uHr9ajDHgiXMf4RlAsB/jylPwWofNJoZMZYMvmrddCY77NhNnV1VcGsmQutfgB3rN1Um4mg70MY9EaJvPo8ooUBlCtTRODy0sqWXaPZDHBHo2BhiGRY3koCqxocBDaG8B/tlw2yfcLN0wrxeU6Y5pESkKUtXqCdbpo2ajz/c1jEZAft4brPwD2nOHzvBgoq0lUeBFceUchDhWcHfbR0uyEJ94o/lSb6/M3HtXpau/kEEdKrg3kExgru6rdQNNe5D9Fqy/4tncY9qbQMGOzIwVyVY+WWZusD5AJpHuBZeO/AqnYC4ujQJPdloy8PTmjndC+l0qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Af6/fAhUa3cDCp6K7qBtPbwiPtjox3Ber3+3lEicmcc=;
 b=R/9OCBCCCgDPLG+s2YPbQ4k2EqG28XWxU7kXT0RJ+FgiYk6JMdG1TLiF2sske5CYoGsEdmYhMUSDwgrL51BrvGUIwlCH+KHBXEfvHNUgiJRmLZqy6x1KVtN6oKkkheFg40KsE9Xl9D1dCRSHxRFyDRVF2YMVF3usNUenMS1N1co=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8466.eurprd04.prod.outlook.com (2603:10a6:20b:349::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 11:30:16 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 11:30:16 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	shawnguo@kernel.org,
	conor+dt@kernel.org
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	peter.chen@kernel.org,
	xu.yang_2@nxp.com,
	jun.li@nxp.com,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 03/11] arm64: dts: imx8ulp-evk: enable usb nodes and add ptn5150 nodes
Date: Wed, 28 Feb 2024 19:29:56 +0800
Message-Id: <20240228113004.918205-3-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228113004.918205-1-xu.yang_2@nxp.com>
References: <20240228113004.918205-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: e03b1575-79b8-4c44-3660-08dc3850a1da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5ozyyqVDLy5izxXWpqBD2vaFBHDSxxuMRCKTQ+NX0JZluI/on1CaFt2PKixKii+LrSNs8RIsOxUUStJ6jLOlP7NAgeORxrXYmonmfk0GIr+r41OSgnvL7S3SwC16ArLFprhaffcyjxqw8zA1CcK1YXqrXRbHsJJcF8wPqXIspKfPCdelxkh5h3jjfmdHt3cldyZglfSixTCBlJ0JhRdeimfTxpLBgufaCuus9LG7iXstj19OOalksm98flXx8V31lnWbygEv8zSxdipmZuD1TVJGyKnzQMUrDoCQpcVYjzP3G5WItPGlNajHCyzEPocX02K3zKyEox1yMUzoE1aGTiw5+dmfY8D0kl8UiT11ryiWPrIYGrde2GXIEQJefB8MYmyNGnbsaKmSMlqlZ8zoMARZfxGtRTrBJkKUwk5MaEKH6OlPV2wvwdVRBVzJlfCrCNYScccTj1C8cbVP/Mu8RyDw5HCXtQ1XDrrER7araGQ2epzYURlowmFubvRroLxiHxb0d3kx/5sDAR0xx0iDXVrq9C3Zh8WQ+GxJI0eSKAllJEe+JdSS79sD8OjMQExWPXVOB5pO7Kyiy/5rnkFDb4rg/y/YszFLat2pDmTZtSpn4F+REa0cz6IKNudZmaaa/Ng1TEGSnbFPB+XH5WYI+YN6/eKkxVBef/5A1QFENOkk/C+AdtMkFo848QTesDpXWAj3SU2sgYCVpowRP3bdnA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bePApjZB0jPwBOHduFUxm/VhZ+/gavUlTAkpaPtt0zf3kuNsciWOfuquEC3z?=
 =?us-ascii?Q?48BNAzm98P1QmINKj5NTGwciN3mD5nl6UESYXPmOH0pUr+bigVymxaXp/gkp?=
 =?us-ascii?Q?YY2IJnG1HiaWu281mz+nqXNVxFf687waSiOT+xCuXENtkazXkPtTN/T/3GW2?=
 =?us-ascii?Q?mgILd6jQbgGObd/1OFlvR3qFyuh5pY1bSzEcdFSEHHdyowArdtsj/614nsQS?=
 =?us-ascii?Q?4m+0jEfCKArlRr0CthCyjVKiSmD4PHz0swdEi028TgYPA1YaCnqWY98+VmR2?=
 =?us-ascii?Q?VC20qGFQgOGUCoUrL8CfG9Git8qrtVGqCdI+sGV6WomY7z6Satm6IGwKfREX?=
 =?us-ascii?Q?5HIHrJic+7T5qgUre0Yn+I/GGZCe9ZeTM/VRyVVqAu+ryp+E5+Z76swHrnK2?=
 =?us-ascii?Q?ziW1UbxCFoIBgWcYBnyZMZK4npKos5CNLWwhosbQQ/NI6Zp7/ffuOAziwFXM?=
 =?us-ascii?Q?p2QyB0HgVlnQFW+Rjowf86RPnFJSFcc8ygfmaF/A70vzVWwaGh/d+9dSWDw3?=
 =?us-ascii?Q?5K6uc953FzPG6ND2zg9YK/mc2qZof8ZkIGq20S75BDqF98g4U8T0AICBF94s?=
 =?us-ascii?Q?Yk85iTf7I1oqzwY5IFv4XskIz3fHbsJL/NpUB6QY8tXYbWl30IsnC4+u38er?=
 =?us-ascii?Q?+99hRkq4lvX6Mifmkkt/odLgQ3NzB2YYnP8hOiRgAfFy7+l+QRSrLTs+IWTf?=
 =?us-ascii?Q?KcY3lyP7twbtU2KWLipYRmQZ7L8YlyxyIncUbZ7nruNaY2/l/K+pkrGp6NOl?=
 =?us-ascii?Q?Uv+RI+bGi/q3bxCFbLATEuhFA6UfJf5By6E5orU9sKH2pVj1F6clYVhQcHth?=
 =?us-ascii?Q?4Bg5suyydgpBWsnWj0g8UfF7u/b9b/PFhcqAs2omzi2VDeQvcIaWLExOqEh4?=
 =?us-ascii?Q?ZD7uYyIDyCsMQsfqoiEktvJIctCM1sSLD+pJtIIYhDNSgzStiEeuNIG68EF8?=
 =?us-ascii?Q?bDi9AO4q1IShcEPC3Exq0nNXvOuLM/ro9PkPmOW+wDcT88pHA+9qUAvmpHQC?=
 =?us-ascii?Q?0HQ6xkeZWJU+tSOJGW6XTH+WXkz+nLnxX9nmdDi+x2CZS1hZbmyqhFmsugSF?=
 =?us-ascii?Q?6kfUlwJditRUeWekxCY2FfV09V5anFV+7mezk0EHHKIwP1oYm2kOYu7zYK1w?=
 =?us-ascii?Q?1NZ2/f43BWYgxHPGQ2whhtaD8bFX+Ya5zAc9KzYCm6PY6g9RS3OB0Mpl+NXg?=
 =?us-ascii?Q?TWDPuLhM7rm+4XlXnxtmwX+UL2rv3FTHipZ1pfIjw9PvqMbMJzTHsqDuQCBm?=
 =?us-ascii?Q?2q0aZ7IO5zYnX5Ui0E/QCMppROKGqCicjhJOFizQXvJRtyBa9P6gi6kbbxZI?=
 =?us-ascii?Q?cBW7tlFrZaMDDIaDc04XL+WXFrv092ByFdSueGnmvI0FGk0BVRHEEAjZZEbC?=
 =?us-ascii?Q?3VYfiqScGRhm8BbsBYIZhcLHRzjLObmPHmKcHu1dXowOYF5s1Jn3JTt/C4kr?=
 =?us-ascii?Q?ikD6qwlSM0K8I/ciLElPdF667g2xfBQ1+Yrp6QOVnsYJP4HLGe5AjUaiNZDa?=
 =?us-ascii?Q?1+JUVWujdhOBCg7udcAbMNDBJFaQarlzFwPW3w+DO57J2rrknFKcFYaIe3tn?=
 =?us-ascii?Q?pEyI5gYJlvKKt9OeicWXZIpAzdhIpQQ5nVx3VZ8x?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e03b1575-79b8-4c44-3660-08dc3850a1da
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 11:30:14.6217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KCK4O9x7ov3wxHpTEKjnCNXjXfmCKvWB6TiXBfcG0O3a/Kia3MptrApIT+zg81UO/XSJS7dtbmuGSnyjyvPdyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8466

Enable 2 USB nodes and add 2 PTN5150 nodes on i.MX8ULP evk board.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - fix format as suggusted by Fabio
 - add PTN5150 nodes
Changes in v3:
 - no changes
Changes in v4:
 - no changes
Changes in v5:
 - no changes
Changes in v6:
 - no changes
Changes in v7:
 - no changes
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index 69dd8e31027c..bf418af31039 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -133,6 +133,64 @@ pcal6408: gpio@21 {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
+
+	ptn5150_1: typec@1d {
+		compatible = "nxp,ptn5150";
+		reg = <0x1d>;
+		int-gpios = <&gpiof 3 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec1>;
+		status = "disabled";
+	};
+
+	ptn5150_2: typec@3d {
+		compatible = "nxp,ptn5150";
+		reg = <0x3d>;
+		int-gpios = <&gpiof 5 IRQ_TYPE_EDGE_FALLING>;
+			pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec2>;
+		status = "disabled";
+	};
+};
+
+&usbotg1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb1>;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	over-current-active-low;
+	status = "okay";
+};
+
+&usbphy1 {
+	fsl,tx-d-cal = <110>;
+	status = "okay";
+};
+
+&usbmisc1 {
+	status = "okay";
+};
+
+&usbotg2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb2>;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	over-current-active-low;
+	status = "okay";
+};
+
+&usbphy2 {
+	fsl,tx-d-cal = <110>;
+	status = "okay";
+};
+
+&usbmisc2 {
+	status = "okay";
 };
 
 &usdhc0 {
@@ -224,6 +282,32 @@ MX8ULP_PAD_PTE13__LPI2C7_SDA	0x20
 		>;
 	};
 
+	pinctrl_typec1: typec1grp {
+		fsl,pins = <
+			MX8ULP_PAD_PTF3__PTF3           0x3
+		>;
+	};
+
+	pinctrl_typec2: typec2grp {
+		fsl,pins = <
+			MX8ULP_PAD_PTF5__PTF5           0x3
+		>;
+	};
+
+	pinctrl_usb1: usb1grp {
+		fsl,pins = <
+			MX8ULP_PAD_PTF2__USB0_ID	0x10003
+			MX8ULP_PAD_PTF4__USB0_OC	0x10003
+		>;
+	};
+
+	pinctrl_usb2: usb2grp {
+		fsl,pins = <
+			MX8ULP_PAD_PTD23__USB1_ID	0x10003
+			MX8ULP_PAD_PTF6__USB1_OC	0x10003
+		>;
+	};
+
 	pinctrl_usdhc0: usdhc0grp {
 		fsl,pins = <
 			MX8ULP_PAD_PTD1__SDHC0_CMD	0x3
-- 
2.34.1


