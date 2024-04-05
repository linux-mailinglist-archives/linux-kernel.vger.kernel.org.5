Return-Path: <linux-kernel+bounces-132315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C118992E6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 03:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534DD1F24AC9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE406DDA0;
	Fri,  5 Apr 2024 01:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eSUKYp+X"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2095.outbound.protection.outlook.com [40.107.247.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF57AB64B;
	Fri,  5 Apr 2024 01:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712281896; cv=fail; b=cDj/StvpEjsrIuCohut2nrESo83XP0VICOIWoJUOxhIVpaifWByvnqF1ayrwTSfH0+NIIHG9fL3hfBGdenA/uzKtJmZ7+Wa/PdiNn2iSqZUaeI3UZogQj2NiIN3KD0YrQJPGKmo/Fzeru+GiIoOtYY/UHOyeiNQkOW78O6wtc1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712281896; c=relaxed/simple;
	bh=I3U+plXcY1TZ7+KQS+gsSe1S+q4pqP2W1NTqUdEdhu8=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=ObEmbOZow7Q7YVcWtA3zbA9m6CTmXTDSq3188Vvn7K5HCo1FtVzYf0x7PPZg437k94DJzztOKDfOMiDwrLXVagD302C2GXsdVvpi1Ho2J4UsOa0Y/ExGgSt15R5tFY8WFsBZDxyPQzvORL07CTJ/KQtzNJgjC6DI59p1rYcz3e8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=eSUKYp+X; arc=fail smtp.client-ip=40.107.247.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/8Jx0t5eiu5o3fZGRN3W52rLilPUsAyNy3vppoNvpDjoheNZVc/ZzUouYBegbfCG1O2DcnKg75FZoCNNOKLb+SK51A9W35bGI5ZEeDxVkhTlEjdkobzjuKfx5QYe2/vPeRnVDtVyJ1y2iGlqRntc3I18yy9v+Lu5S4rCj+4ntQixuZs+JoeJOj11dPwL2bvFnBv0sQAUIuH/NNZXTvTLIR1GbkPnMBbv98mCFI8H6+TIMW2gL5AIfU+Jv3XX4+c4UwL6AOcb8YdvT0ekZhcNyGVPFXsZFihRtJ+gwNctJcID6zk2OuPAwVHAfpzdM1yCebuDIOx087rQjPvO3DAIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxdIhgJ4TBy03tBwGyO17f/KcEhxvnd3EjV7Crx3O8M=;
 b=Fi9IAo7KiSq/CML6Sr1Wtihm2iUANAzMZ1MvvWLHzfYNWUTrfSRvZYgz4lLPhO8YEeMcelgu3wpVVFhsDHos2fBH6a6MYdPqVcIaQyMtt+fC1qmstP86R0pSE2XxFLjhPRfBbdEAUnymCk/df3imci8P4NMXeQHva0RuZ9EWqpnL84dWV6XgWt1b2WGLKghYaI3V4YCsf/O+oMeTxSZQCtlL/fuXLSFbLAaOYV6wEmYPT60a0PLX1dwvDrn9Gpbu/HOKD99aZiaD7hDm4iPkxfbok14s/OPHLDVmtrpykIH5zH6xBp7RucmsXuQTapQLW+hhyMO2JsLHXSngeZVhrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxdIhgJ4TBy03tBwGyO17f/KcEhxvnd3EjV7Crx3O8M=;
 b=eSUKYp+X0DX4xUSh52yxVzshbb0yjZSFWsYZGxp1upiEWffqNnHEqYw9A1tQuuZwfKtmA3i8xcLqTU0/ixuqHmKpqrgYdmuhyhC4POM+wNof+JZAZ6T/8TM2IaNag1KFoHf5ZoMT5mhddu/jSf3ung3torx3m6V0MPBNP277A3o=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9334.eurprd04.prod.outlook.com (2603:10a6:20b:4de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 01:51:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Fri, 5 Apr 2024
 01:51:29 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v8 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Date: Fri, 05 Apr 2024 09:59:31 +0800
Message-Id: <20240405-pinctrl-scmi-v8-0-5fc8e33871bf@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAANbD2YC/3XQTWrDMBAF4KsErauiGWn0k1XvUbqQZbkRNLaxg
 kkJvnvlQLGt0uUIvvdG82A5Tilmdj492BTnlNPQl8G+nFi4+P4z8tSWmaFACQjEx9SH2/TFc7g
 mrgI1QhrVqaBZIeMUu3R/xr1/lPmS8m2Yvp/pM6yv/wTNwAUXXZQUlQbozFt/H1/DcGVrzIy/V
 AkQqqJYqHdNa7VvyFt1pHJHESoqC7WtU403rg3eHqnaKKKsqCoURCyN0jg0VSttVEK9MBXagCO
 jI5Hp8Ej1jv5p1etfrSNUEskEcaRmo2XlippCZfQErgUM+wsvy/IDmz26sAgCAAA=
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712282385; l=6968;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=I3U+plXcY1TZ7+KQS+gsSe1S+q4pqP2W1NTqUdEdhu8=;
 b=Xuj4nzyuPNYLSITOqULWQ2cTJUmaBCbCekJF6hIEQ+PW2zoPFmxDivez28feRUBWorC2JV31O
 QtQ52awgR4eDGMbA5bACSplDHwryPH6vM1QB/3YC/PIRv2EeRYy8/oe
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS1PR04MB9334:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BUX7bWMqNsb7hdQgiqFf4MTyC8gzedtwSt0hJ5uRXKe0SDSvx5JUAyrxvlg61IaJj0QGj90VtUnzETYbPpLkTwEz0x4Z/Ir1vpHAMAcftTuxFOUkFGC19bDlAwzBDLHCR4/KtYee4A94fJf6MXrZ3TqRYmAbkRZFYml9sA9xtByGblpT405EKRlicaZw4MrxlvRARzEWdBzvZMWbS1RM2gT11tuFidJdBgXq5qVRsMIdDS/ZFwQJX3U33yS+z60XR8pZ0L5FgcKE+Vqwik3ppA9x0BHF8jZEq6r0qxosmnTzoFtWFxsyAwVuupOss6VFfVu1tckDeqvpiEyTwp6OOhUHWTKo6zPILaL87OVcEZ1MRu4zmb/Mc92DNJfsPh/I3zH7yh5x+McQSUEgmiR1n0rSxCAzOPfCjdH+mTIJHXZ7NJ4BcaKJ0BJ8SrdfMHBAYdN35fx3bhnOeQDLQzCcwTl9C5+fKMQM10sZJsOzVaJLQCDx4reBIVwIoGaJ6X+ABHbjCEKowh5tEK+9liISoB+PJrOkeVT5ybaaSnotMfuK7EijBl0kz9QhuA+fTQM9S1wXcyQ/E3Nqr4Dvl0k7ERHY7tdkY+XPLVnEhRZ3XUNWJxN/7Xw3atlpIms8ZUT42RrCubKgdYmfkGwZvRqKL67b7AhtJVjW4gkhcaWPMNU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1hSc0pRZkpxUzRWbmxVZ2I2bWdZYWZ2T2xTQ0kydmV2RVJzYzBCN3h4ZGZt?=
 =?utf-8?B?a3B6cDVyZ0d2R0FoZGZHdWludzB5SDVzTThERERWNks2Qm9IUEZ3czF2ZFlF?=
 =?utf-8?B?OVFpbWpXZ0gvaUI3Vy9VNGVNQkZBTDVtcW91OHMya29hKzZ3ZFlvMnZQT0dX?=
 =?utf-8?B?S3Z2Ri96M1NWcFBYYjY4WkpFRWplbHZPb01VcktmejNTemV6QTdiZ0dSSVVr?=
 =?utf-8?B?MlhpZ0U4YVpCYmhLYWNLelpYbmpSZ242MEw1VTVhWUMwWDlZNU9PdGNVbzNB?=
 =?utf-8?B?UjBkcjlWNjEvUVRyYWJ4M1dZTW1TOUtwV01BdC9GL0JablFmaVoybE1TcmRK?=
 =?utf-8?B?VU1MUmJFYWlkcHo4YkhqRkJxQ3B4RFdIbERWblNIcEVpRUF0b2QrSCtvMm5M?=
 =?utf-8?B?WGlyQmRJNldDUmNJeFkxOVZiaXpFdHkyQmppK1dDeU1wSEl6U2FBTG4zLzJa?=
 =?utf-8?B?VFFpUWUwb2Z1dnZFTU1OTE5acXRTZ2NUTWVEY0xMQUdvMlpyOFJtbndZQVYz?=
 =?utf-8?B?aTNDbTBIenA4UVlDZFpwOEs1Y0lYWUxpUlhDUVZUa1kyTDBHOCtybkFDVDJh?=
 =?utf-8?B?NW83RWVGMGRUUGpRb25iZEFsdDU2ZU1FQktpVmFlL2JaNXBFSHVwamFxRjJG?=
 =?utf-8?B?M0p5bmp4bzIwNzhHOURCaDYxVmM5cGFZVEs1ZlFqUnBDQ3FSYWlhRFk2Qld3?=
 =?utf-8?B?YlhxTEdXeHlNRTI4bUpsMmtaUW1hdzNCeHVtNWtpMCs3aHY1NUdEUG50VnVN?=
 =?utf-8?B?UGNsRkpHVDBCbi9waEgvY2tjKzYzNDMybEZXKzVHeTJHQVByS3FzaDhrWTFs?=
 =?utf-8?B?UkhMZUtMcWJLT2psL2NsRWlVYkVGc05Hek9oZjJndHJPcnhKVURDU0lVTFFD?=
 =?utf-8?B?R0FoL2QzamNVY3pCY3NUMmx3MVJIMWZmSlZzS2gxTjlaQWZyUEJmSlI2NHVy?=
 =?utf-8?B?Tzl0bHNuWXk3YU9ob3lvanVmMm5yaFhpakZoZHZMSjhpTTg1cWs0NW9wdi9l?=
 =?utf-8?B?azFUNXVrRE55YkdMZnBzZ2lmL1EzSW9zTEZZVXNsREg1Q25qYitDeVdyd3hN?=
 =?utf-8?B?cmJEL2JEMXFqSWpjRkM1dE96a0I0SW03TjBXbTR6TEZPUlJsMVpORGwvamUz?=
 =?utf-8?B?MGFPV2xSYk9adjltRmt6Y2pBTUpjMzVjMC9UOWRsanY2UkU5UVJrdzlEbm1O?=
 =?utf-8?B?TG4vL2FwY2NvRWZzakR1U1J5amI4SEZ0K28vYlZSc3BvKzBoV3g4MjM5S2Yv?=
 =?utf-8?B?SnVab0FoS1NheGEybndNY0JaYzhraVFXeTBGd1dQZ1gwaDRPcTRSOUhXVVJQ?=
 =?utf-8?B?bG4wS0VMek1IZnQ0aDh2M0Jqd25Xbk5MNWxLVXA3UWpENkc1bWxkYnYzZFFW?=
 =?utf-8?B?YXcyNE5CSlhDdUYxTzFyUm4zUDBUc0RzMEhrS1FEQW5zNWdvMldSb21xSkF6?=
 =?utf-8?B?VFFaNGFPbW1NQjVOME95Tm1sVnpCdWRyQ1E0U2IvYm8vck5idFNDNGhhZlhG?=
 =?utf-8?B?ajBPWmdHRDRJZDdXTUxOUmFKNFhSV1hUY0JUSzBGbS9qWStZSEd0TlJEenJl?=
 =?utf-8?B?RTY4TWJpZ2JjR0pZUkNSQ3pXUUdhK0ZuMXNKZEV5WkNrSGw5SWFaTzlmUlFU?=
 =?utf-8?B?YldkNGJSOUZnWncwa2ZFVW1uTk1uQ3ZzMmZYQ1c4d1g3SkswUDBZZ0dnc2Nw?=
 =?utf-8?B?anFhaTZ2UGVYWlpCckEveHdQKzFZV2lCbWZJZ1dwbkpxYUZFSTV1Um0rUUtE?=
 =?utf-8?B?azhUNjF1WDIwU1JvaU5ML0kvZDUwbEp0aTJaMFlKankzZkdLdUJKVXdaajhO?=
 =?utf-8?B?RldMVFk5YWdmVnJNTzdsSDZNV1p6NzlHQllyK001b1pmZE12REg5Q2N1allh?=
 =?utf-8?B?WGlmNFZjMG1JVW40OFdSUjA3YUVtRjFGUXVYTG9vTEFoQUZSVjA4dzZXakZp?=
 =?utf-8?B?OFlGTWxZTS9ibHE1SFptNHg5NDZzVmdNbG5pYU54SFBFZDk2S2NMNm9KUURZ?=
 =?utf-8?B?QXlNV1JUb3N4anpJOVRKMnBGS2RLQTFBVXA2UzFycmVTRHZmUmE3ZTk5dkVk?=
 =?utf-8?B?QVI4aXFSUlkxSkVwYk4zc203L3hMUW5WcVRmTFQrNlZ5SGlwcWJBakF4WHlC?=
 =?utf-8?Q?Xi24zSdtdaXkvyyOau2Yf0D1E?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eabd1a1f-7d64-46e0-9cbe-08dc5512e99c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 01:51:29.8394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tq7IXBrX8IeBSpMNBy+FOwsTWTXFQkIb7KgwnPnIvUfqw/ijhifyFp4ljqcqNvoBBcOivn0Dx4GzYaNpqNxrfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9334

This patchset is a rework from Oleksii's RFC v5 patchset
https://lore.kernel.org/all/cover.1698353854.git.oleksii_moisieiev@epam.com/

This patchset introduces some changes based on RFC v5:
- introduce helper get_max_msg_size
- support compatible string
- iterate the id_table
- Support multiple configs in one command
- Added i.MX support
- Patch 5 firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol basic support
  is almost same as RFCv5 expect multiple configs support.
- Patch 4 the dt-bindings includes compatible string to support i.MX
- Rebased on 2023-12-15 linux-next/master

If any comments from RFC v5 are missed, I am sorry in advance.

This PINCTRL Protocol is following Version 3.2 SCMI Spec Beta release.

On ARM-based systems, a separate Cortex-M based System Control Processor
(SCP) provides control on pins, as well as with power, clocks, reset
controllers. So implement the driver to support such cases.

The i.MX95 Example as below:

Configuration:
The scmi-pinctrl driver can be configured using DT bindings.
For example:
/ {
	sram0: sram@445b1000 {
		compatible = "mmio-sram";
		reg = <0x0 0x445b1000 0x0 0x400>;

		#address-cells = <1>;
		#size-cells = <1>;
		ranges = <0x0 0x0 0x445b1000 0x400>;

		scmi_buf0: scmi-sram-section@0 {
			compatible = "arm,scmi-shmem";
			reg = <0x0 0x80>;
		};

		scmi_buf1: scmi-sram-section@80 {
			compatible = "arm,scmi-shmem";
			reg = <0x80 0x80>;
		};
	};

	firmware {
		scmi {
			compatible = "arm,scmi";
			mboxes = <&mu2 5 0>, <&mu2 3 0>, <&mu2 3 1>;
			shmem = <&scmi_buf0>, <&scmi_buf1>;
			#address-cells = <1>;
			#size-cells = <0>;

			scmi_iomuxc: protocol@19 {
				compatible = "fsl,imx95-scmi-pinctrl";
				reg = <0x19>;
			};
		};
	};
};

&scmi_iomuxc {
	pinctrl_tpm3: tpm3grp {
		fsl,pins = <
			IMX95_PAD_GPIO_IO12__TPM3_CH2(0x51e)
		>;
	};
};

This patchset has been tested on i.MX95-19x19-EVK board.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v8:
- For the devm_x, I still keep as it is to follow current SCMI style. In
future we may follow cleanup.h, but it is not this patchset's goal.
- Apply Cristian's change, and add tag
- _pin -> pin to drop underscore
- Add headers per Andy's comments
- Drop casting for func->groups
- Minor update for coding style
- Link to v7: https://lore.kernel.org/r/20240402-pinctrl-scmi-v7-0-3ea519d12cf7@nxp.com

Changes in v7:
- Hope I not miss any comments. If any missed, please forgive. Since
  i.MX95 SCMI firmware not support all the pinctrl features, I could only
  do limited test.
- Version set to 0x10000
- Drop scmi_msg_func_set
- Use get_all to replace flag[0,1], not support flag 2 as of now.
- Add settings_get_one and settings_get_all ops to support get_all[false, true]
- PINCTRL_SET_PERMISSIONS is not included in this patchset
- Bail out if nr_pins is 0
- Add check nr_functions and nr_groups if they are 0.
- ext_name_flag changed to bool type
- Drop unrelated comment
- Use a central function for pin request and free
- Coding style optimization
- Use pinfunction to replace scmi_pinctrl_funcs
- For the devm_x APIs comments from Andy, I not update in the x/arm_scmi/pinctrl.c,
  because it is correct usage.
- For included headers, I keep not change. I try to follow 80 max chars
  for scmi driver, but with a few lines still exceed.
- Link to v6: https://lore.kernel.org/r/20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com

Changes in v6:
- Update pinctrl driver following ARM SCMI 3.2 public release
- Addressed Dan's comments, and followed Dan's suggestions, thanks.
- Dropped R-b/T-b in patch 3/4 and patch 4/4,
- Link to v5: https://lore.kernel.org/r/20240314-pinctrl-scmi-v5-0-b19576e557f2@nxp.com

Changes in v5:
- Rebased to linux-next next-20240313
- Link to v4: https://lore.kernel.org/r/20240223-pinctrl-scmi-v4-0-10eb5a379274@nxp.com

Changes in v4:
- Rebased to next-20240222
- Drop pinctrl-scmi-imx and compatible patches in V3
- Add T-b and R-b collected from v3
- Link to v3: https://lore.kernel.org/r/20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com

Changes in v3:
- Add R-b for dt-binding patch
- Use 80 chars per line to align with other scmi drivers
- Add pinctrl_scmi_alloc_configs pinctrl_scmi_free_configs to replace
  driver global config_value and config_type array to avoid in parrell
  access issue. When num_configs is larger than 4, use alloc, else use
  stack.
- Drop the separate MAITAINERS entry for firmware scmi pinctrl
- Use enum type, not u8 when referring the scmi or generic pin conf type
- Drop scmi_pinctrl_config_get_all which is not used at all for now.
- Update copyright year to 2024
- Move the enum scmi_pinctrl_conf_type above pinctrl_proto_ops for consistency
- Link to v2: https://lore.kernel.org/r/20240104-pinctrl-scmi-v2-0-a9bd86ab5a84@nxp.com

Changes in v2:
 Added comments, and added R-b for Patch 1
 Moved the compatile string and i.MX patch to the end, marked NOT APPLY
 Patchset based on lore.kernel.org/all/20231221151129.325749-1-cristian.marussi@arm.com/
 Addressed the binding doc issue, dropped i.MX content.
 For the firmware pinctrl scmi driver, addressed the comments from Cristian
 For the pinctrl scmi driver, addressed comments from Cristian

 For the i.MX95 OEM stuff, I not have good idea, expect using compatbile
 string. Maybe the firmware public an protocol attribute to indicate it is
 VENDOR stuff or NXP use a new protocol id, not 0x19. But I think
 current pinctrl-scmi.c not able to support OEM config, should we extend
 it with some method? Anyway if patch 1-4 is good enough, they could
 be picked up first.

 Since I am only able to test the patch on i.MX95 which not support
 geneirc pinconf, only OEM configs are tested in my side.

---
Peng Fan (4):
      firmware: arm_scmi: introduce helper get_max_msg_size
      dt-bindings: firmware: arm,scmi: support pinctrl protocol
      firmware: arm_scmi: Add SCMI v3.2 pincontrol protocol basic support
      pinctrl: Implementation of the generic scmi-pinctrl driver

 .../devicetree/bindings/firmware/arm,scmi.yaml     |  50 ++
 MAINTAINERS                                        |   1 +
 drivers/firmware/arm_scmi/Makefile                 |   3 +-
 drivers/firmware/arm_scmi/driver.c                 |  17 +
 drivers/firmware/arm_scmi/pinctrl.c                | 916 +++++++++++++++++++++
 drivers/firmware/arm_scmi/protocols.h              |   3 +
 drivers/pinctrl/Kconfig                            |  11 +
 drivers/pinctrl/Makefile                           |   1 +
 drivers/pinctrl/pinctrl-scmi.c                     | 564 +++++++++++++
 include/linux/scmi_protocol.h                      |  84 ++
 10 files changed, 1649 insertions(+), 1 deletion(-)
---
base-commit: 70ca90deeca172d343bd18bf7fb2f992214c23c0
change-id: 20231215-pinctrl-scmi-4c5b0374f4c6

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


