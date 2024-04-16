Return-Path: <linux-kernel+bounces-147115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CA58A6FA6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 972691F21ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34D313442D;
	Tue, 16 Apr 2024 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ktEZYhpY"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2043.outbound.protection.outlook.com [40.107.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A02F131723;
	Tue, 16 Apr 2024 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280772; cv=fail; b=dc+BOJz+iNxT/e4UARRfM9OTVL+99YthKpOE7YUM8IryKaPwzGExNbo+TMLFuImb2pnJAQjEseEUbGVHq/Pc/RgXPus2kWJrgFpJ6T7fvjd5GlNsefqqiPUKSeejWElfwYiKyUqGL9Q6bNkNNWOj9HMY1I8EovEtmM0pF+dHhWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280772; c=relaxed/simple;
	bh=a8Yin9UNvJZ1H69GAJ2Gs9KZmurfHKDKhqvvf0HW9hw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NGnMaZMwWp9jo3THJ41qYgf4Ec23Q8FvUXKXqiBWHNDKgWl7LkrhAnEC+4kW6B+32f0tndoD/PHiAMmuoyAU4GnsqejfKjZiqRWlxDZDsHWsS3SAmlGyNdJLomB7oZ9ujgSzqpqr+MDVZ3vrDKlnxrgkFz3nbJkKp+oN6Y5MstA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ktEZYhpY; arc=fail smtp.client-ip=40.107.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIbMOm0ta2l2IiBdi/4GdtydQxE2MY3FoqINXyj+BL17iZ50uiXKf7mrHMqLmVdTZ4RiDEsv/ls61yTDo2wD6sLUipFZ3qxONaYZC48DGeRTe13wivJYCGXWlSLSd1vW56dl1PvRCd7qfEsna6Jdt/+Hh4UsudL0dxHLcdwrb1yEGz4zhRplz/0J8lRZKNc4jFPoxn546Jmv8KZwNFVLq90weNlq5jdcubBt4xYdXX51SrsnUZd1OJdK4k2FItyONEqCQWHJznuGy/x5f+iqU2jCrAC+5dJZLArxNQ2XVxsHaqht1zByIBXrhPK5GcC7Za1E5cf5HhN4lNy+6OAtfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3NVyXgePVeYYgwWIWlhBWJiZIvg/AVy+K9WBcxlvX0=;
 b=U+1wZHLvmlTf3ttdL09hgmBV53T0GCFwHJo3Ko5JnUzfDweER4U8A3V6vlXi26R0ICajQovfBI2kAncCXWuHP7Wd2mcmqz4BbqKhRQAppfwtbj5hsdB7+qxtBbUYvjfXDepmKQEscJigdTsygcQbYo5r9MnO+X4JPZ4qy0fPw/C6Aj8a1oonTbzdZl5Q5qzNbc3w1eRWRvz2hG6Pvo1rnVegG1xH9gped+JNHTCmSRwPlI8Y6Bj7LcKUJOqJ+k2tKl7LK8Q+OB2rIQNUMYcW3pqQh3y12zOrjuNN9h5iamFNe4upmKWfqdltCrPdC5tSHISpQl29b3tNbLz96gxoOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3NVyXgePVeYYgwWIWlhBWJiZIvg/AVy+K9WBcxlvX0=;
 b=ktEZYhpYnhZzG/jCQMXnmT4KVzOVUWFD8IRuhWDss9Aqaub62qM1zkeKmctnYrxA0XFB2v97cmKJmOTJngYzRzCliYURQKtklHKMcnLZB+DHVwIYZYOSKIX+a0B+eZ/L3ODS+j1CULiyn2wD7yzShr3fjNv79h0vzXVVfpt0cd4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB9194.eurprd04.prod.outlook.com (2603:10a6:10:2f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 15:19:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 15:19:28 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 16 Apr 2024 23:26:45 +0800
Subject: [PATCH 09/11] arm64: dts: imx93-11x11-evk: add sleep pinctrl for
 sdhc2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-imx93-dts-4-13-v1-9-da8ac02e8413@nxp.com>
References: <20240416-imx93-dts-4-13-v1-0-da8ac02e8413@nxp.com>
In-Reply-To: <20240416-imx93-dts-4-13-v1-0-da8ac02e8413@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713281224; l=1902;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=IkgkzajW3i1/2uBfzzBinYnK7req5nUwjI0YrZQay6g=;
 b=cgtKK1BL+Gm9DeOmk6BC7Lj5yOQSoXesqsP6htoWUo9i511SpIefxQoSheojBZ1QN4E+K+qSp
 KTUk1Fc7AToCwv5bdaxjDmYDrwJY7Tro3UZB8s/FB969Hg1c7kl3LNA
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: 163d6662-54ca-4fd9-b7d8-08dc5e289ba1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xSfjeHmbtm00ASkSQRutJPQh6tH9UUzE9AycjpXHTKMcAnupqe31GX1lAN9Pt6nzlexwyPBIu1grmzJWk7cqGGTuinHr2ViuEV9in+FObc/TYyqw3niGyvp/fWYjG/GUg6bWbtSykqqYB4fghdawSDoSMsDjG/ereVWaN+2cDkkOx+pcc9F99IODkJJA1l+h1+j/kv3RoBvumur4DI1caskj//tXjBul8hZJmKq4EwluaiUsxsFRhkDVqL+GpEmQkgAwMIKp4jfaKPKKig2bcuRfXlrdNxowoiIjH7wAkAtY+u6MvnKPP8a9DlSu5p68gH2gbzsmUzmWwnZP3wivor0rQcbZY2Euv8sUMOR/nC7Emk0NIqloBfj+HNA+Q7ceH0GRsCtZQjA+d9KicDHZ+1kHpXCLv1VeGQHrDV3G9WEKepFVv0K0xEw1oWhhtDRR13YIPEzOlgURYW98POExaHNwzWs59OtDOSvSeS3IZdIqu3K9+W9dXG8NnPKR39PkBO50r1cKMlJGuOSSBpdCJtJ6p1Yx1BVeF5iTdPkE68EqI2g4Vxv5ny5bHwnYsxsn4E4Jraw87r+bCA0T/F1FiYD6RuN51F2kRAvR7xcfMhwupIiMhEuKpPb6GX9NVCT68UUzDfs8OfAchAbYobrn97mCnzWMOZnWy5oSOdzrLZ7nHRFLfpdd+PqhGG9SgLlQZfz2gPWqSpQmAIwRl8wAkw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWd1a1dhN1UxaGZ1MStiYmJZMDd0dGNxZ2l2bTFNU2h2aHhXdVNicG1XT08z?=
 =?utf-8?B?MUU4ZnRQNHZORHBkV1lzSFROaUh5VmRtTmpoZW1oelVqeVVNTHNsS09UUml2?=
 =?utf-8?B?M2h5c1NoOEdVUWJaeVkxRWFJd25wRmoxUHRrZjJmbWJRVFJ5SG1hZWwyeDUx?=
 =?utf-8?B?aGp4NFZFc3hIZi8xUFRwNkUvdDRIMjBadS9iTDNVVGQzNFFEVXJOTHJMYzZz?=
 =?utf-8?B?c3VCdDhoSkJkd2REZml5eDlETGJjUkg2VXFFdUExdE5RdlVCZjRCUlpaRGJI?=
 =?utf-8?B?dlhWRzNBZDZQd2JYbmhzUEc4RWQ4MFZ4L3A5eWVsTHM5TGYrVHRCVitvRkw0?=
 =?utf-8?B?UDJjeFlHZ3daeC9ERXFMUU9JcW5KQUxMQ3RhdC9yN2RRbTkrT0ticzNkdEdW?=
 =?utf-8?B?MWY2MmFOVzJmSEt0TXFmOHpISnk2a1gwSWFtSW16YTRLZUZvbkY1RlFaemxi?=
 =?utf-8?B?R05Gd0VzS2xzbDFCWWQyMXk1cG5Ia1VHOWNuN3pnWndNM00xeE5YZzFudS8v?=
 =?utf-8?B?OCtxYXhBK0twQmd6Ulh3RmtwWmtnUElyQzZUaUZ4U01TNHlveUt6Ym9iZzFm?=
 =?utf-8?B?dWx6OTgrRVFSYmEwQ2d3LzB6R29IdHZLUGhOMjVIRERCd1JDZ29kN2NyWTNr?=
 =?utf-8?B?eUQwUFA4SEt0WnBsdC9pYjNjUnN5MGFQYmI2SjJFTVNQY2F5Vno5NmpHUHpK?=
 =?utf-8?B?QnV6Tkt0QUpCbU5BUFJjbkZkNVdVdzNRdVA1YkUreDlTeE9iVFJhUHJYVm1I?=
 =?utf-8?B?RkZBQW45MEdxbFlXTkRPcFZMUE9nRHFqRmJybTYwTlcvaHVMcjJKRlFpZzFO?=
 =?utf-8?B?ZEhDakpJbWtGa29UNFIydUJzTTFBUTNxQjVSRjZXQzM0dmVlMzlDWEkybVpM?=
 =?utf-8?B?UkMwRWE5UFZ3TmJ1WlNvTHF1QnFlZGhtaitDR2puS3BkN2hoU3c4UFlaT1BC?=
 =?utf-8?B?R1V2WWpDcDl3QTRORXFWdWQyMnFxcHAwTktWeUl0RytKeHQ2QzhQaDdKQ2sr?=
 =?utf-8?B?TUc5MFhkWEYvMC94SGdKT2tWb1lOZ3NObGJyZG4yZUplMTVETExwYUhNcXZY?=
 =?utf-8?B?MWdWZjdudEVIZVp2Y1ZuVXNKU0NqSERZVGYxSi9wQnY5OE9pMWhBZ3lGaHNj?=
 =?utf-8?B?S3pnQkduK01yUFhYUW5hV1RTUUYrSFdqSE9qd2ZsOUUrc1N6RGlaclA3aE5r?=
 =?utf-8?B?UlI4S0lvZlRqaDBUL1VWdXA4RXVEb0pKbjZyQ0RySFpqclY3eWRENTcwZjRa?=
 =?utf-8?B?TU0rcSt3Q1VPTXMvYnk4WTMvdlBhTXRnMlZzam9lcDl2V2w5dlpaY3hJenJO?=
 =?utf-8?B?UE9lL3plRzdqbUZoejJvVWxWVStUekE3RFFBSGwwOTRtRnNKbTVpdlZzY2ZB?=
 =?utf-8?B?RHd5SDR3SEkzam9icERwTkJMQ2lTb1hTZ3lOeWF3N2hacDcybVlkdklzall0?=
 =?utf-8?B?VU0zUlBML1ZrME9hS0VSVkZybTdDM1BjbmtSb0swaEU4NEVNMWVVQnRmQWRN?=
 =?utf-8?B?VEVLYVJwQVJnMFcrTjA0NlBDSEJ6OVp3clM0SHplWVRjZ3ZaWHZqWFhXaGd0?=
 =?utf-8?B?NGRaOTh6MHBjSzJlYjZxemdFQ1M4bGxWSDhXWnFGOHBscFlYSXlUZHFkelY4?=
 =?utf-8?B?T3RpVUc0RENFMlR4MGFTcnpmS2kyRm9xWTV1ZGNlQkJ1U3NYN09UOTRBZm9T?=
 =?utf-8?B?TlkzNXB2V0RRVWdOVW9DYXRjRlNjSDlLc29CUzlYc0FjeC9oTjZ6MVk1SnUr?=
 =?utf-8?B?RzA1UmtTWm5jVmFzQUVPK2ZMTmRreHh5V3orWW1YMGNYRDJQTVlJMTJwNkd3?=
 =?utf-8?B?OUcvUzRXU0hsbCtJcVJId0M0T2o2RndGL3pzVStjYVM3eTZidk9la0trNW44?=
 =?utf-8?B?dFMxcWVoQkNmdHZvK3kxRGw1OGFVVmF3R01zTG5Eb3FUZCt0QUVWZDlUWlRQ?=
 =?utf-8?B?QjYvZmNXR1VwOWxrQ2VmZVlEWHQ3YTJsQXdnaTV4WmZWOGlSNXppQmZoNWtq?=
 =?utf-8?B?RDlGVVZ4cTJsM3ZkUkFOUVZWamdiK1pONkhTYjBHR3BxaXFXY2lnTTMzOUI2?=
 =?utf-8?B?eFdvTnhqR0NTR3FiV0Q0aXVxSHo0eFBWMTN5VDlSQ2NMblFYQVY5NTA2QzZ0?=
 =?utf-8?Q?YRRSJxG7po6SOWILy4xkhPHYF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 163d6662-54ca-4fd9-b7d8-08dc5e289ba1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:19:28.3506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: puoABZztjnVvePg81/TbY2Bauy4rV5GLf73Vey5tqUUyps5ARF87EjCLm78I02oWT2tkrrYwgNZ8Kd4FUuzSxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9194

From: Peng Fan <peng.fan@nxp.com>

Add sleep pinctrl for SDHC2 for suspend usage.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index f848cb0922ef..b29d470d2492 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -169,10 +169,11 @@ &usdhc1 {
 };
 
 &usdhc2 {
-	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
 	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
 	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
 	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_gpio_sleep>;
 	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
 	vmmc-supply = <&reg_usdhc2_vmmc>;
 	bus-width = <4>;
@@ -452,6 +453,12 @@ MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
 		>;
 	};
 
+	pinctrl_usdhc2_gpio_sleep: usdhc2gpiosleepgrp {
+		fsl,pins = <
+			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x51e
+		>;
+	};
+
 	/* need to config the SION for data and cmd pad, refer to ERR052021 */
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins = <
@@ -490,4 +497,17 @@ MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x400013fe
 			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
 		>;
 	};
+
+	pinctrl_usdhc2_sleep: usdhc2sleepgrp {
+		fsl,pins = <
+			MX93_PAD_SD2_CLK__GPIO3_IO01            0x51e
+			MX93_PAD_SD2_CMD__GPIO3_IO02		0x51e
+			MX93_PAD_SD2_DATA0__GPIO3_IO03		0x51e
+			MX93_PAD_SD2_DATA1__GPIO3_IO04		0x51e
+			MX93_PAD_SD2_DATA2__GPIO3_IO05		0x51e
+			MX93_PAD_SD2_DATA3__GPIO3_IO06		0x51e
+			MX93_PAD_SD2_VSELECT__GPIO3_IO19	0x51e
+		>;
+	};
+
 };

-- 
2.37.1


