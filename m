Return-Path: <linux-kernel+bounces-168394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EC38BB7FE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E94A286874
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC4C83A10;
	Fri,  3 May 2024 23:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G22qLQx8"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DACD65194;
	Fri,  3 May 2024 23:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714777906; cv=fail; b=mvbStTkLb4pOLHkXV04rYoNr2n2mY8fOWFdkThpK4S1bPtV8RIEX5dhlSIFSAbbmAvHYrCXmrfD064eHZGnMvdIxpCXEPDaOhkZQFnRNWNBTQ0xiY0OADnuNzRkiBha1CoD+S20EBwxhLtbuDWYYYQhzUbG1B1syPcZXHIapUIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714777906; c=relaxed/simple;
	bh=yLHFXL6d71G9zA6ggjpyU+QaC8aUhPbADtwjXl05o7E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iNLBMUlWCxEyho55hOX1nZOPEAFePdXoUbH85VBsOTNCSJdQ0kTAYSBFje941CGS4UWU9TprBnn6yHV0EduQ/fH5KdNZNMycxqM+3srdv7dAOw/vQ56guaexwSa6Y7ruiSpLYM9OMv9BTzhOQGkaiLEjP3vYV73Z7uwVJHW+2mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=G22qLQx8; arc=fail smtp.client-ip=40.107.21.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QruS0Pr3MAIRkYTY3dwrfSBOboBgpOvCcgLQ5x8SFl/FRn+qfVvMDtyt/ATqgYqDHYl26SI0w0DHOb8kIPkesmDyeLmTqxF4k/HFWpMYbsYPeI25SqIL2hbEWljv+aFLs9qZbguWR54ZtRHcYD5c1OEEvRF54Jh1dHWHuFgy/ub9lcbNIyN/hiYqmSeMmvzp6gUv1U6ybK9MIkG21AyH6qfLBSiileu7m5LFo73fhzaZHjfhpjauLCcSQI/KiG7RKuQD27zxSIiHqC1FlPnenvsW+3EIgIuGnraZuS6F0+0h3kgRlGoEWvBxQfMwNslx4hNAdP10CjfeEzOBQKqR/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLHFXL6d71G9zA6ggjpyU+QaC8aUhPbADtwjXl05o7E=;
 b=I9pChR+xiqZG/1InktnyptN0tWaIlLq6/OYRKpHoOVAp45XDfxZuNmYARNpiWOVBM1SnvSa++O1DxuxRn4fOqtx+pXL8W9dNsqAdHNA7YgBzEEvNmL7ha1PD7XaZVCE9NIaLGrtwQjclzdtM5+GEukOK7X22Cma+N9kKAah4ninyoGf+JOuuwJTY2E43F+SRD2a7EfV1nGeKNw77hhNaefEJfIV4n1RK8ih0ko1EyGt81V+QpGVm2CkLgfq6jdxilIiaZ9hE3/tgOTqn/AJtkha6Bn2F1HFCnixpUgm/KYF8bbJ4HRgg2FobwVjotk1kONLGXYFnOzpBK3uTGue1gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLHFXL6d71G9zA6ggjpyU+QaC8aUhPbADtwjXl05o7E=;
 b=G22qLQx8wAIGJg3gYaSJatPdN6sKdslMnL/kTsIw2pnLdH+MVskXbKAV8LtVWPrpx+hHvpC+5c5N6c1Gq2sK5K35R94lRpJYAN44ptBONA75mapxlChMZmKHVaJcR1eOjRdSE4vaQ3T9g4KuuzvFKBCNU2zQjManNyuAyTLC0DY=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB9191.eurprd04.prod.outlook.com (2603:10a6:20b:44e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.36; Fri, 3 May
 2024 23:11:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 23:11:40 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Linus Walleij <linus.walleij@linaro.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
	<jonathanh@nvidia.com>, Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu
	<wellslutw@gmail.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Emil Renner Berthing
	<kernel@esmil.dk>, Jianlong Huang <jianlong.huang@starfivetech.com>, Hal Feng
	<hal.feng@starfivetech.com>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Viresh
 Kumar <vireshk@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
	"soc@kernel.org" <soc@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>, Alim Akhtar
	<alim.akhtar@samsung.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Patrice Chotard <patrice.chotard@foss.st.com>, Heiko Stuebner
	<heiko@sntech.de>, Damien Le Moal <dlemoal@kernel.org>, Ludovic Desroches
	<ludovic.desroches@microchip.com>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Aisheng Dong <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>, "Ghennadi Procopciuc (OSS)"
	<ghennadi.procopciuc@oss.nxp.com>, Sean Wang <sean.wang@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Dan Carpenter <dan.carpenter@linaro.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "openbmc@lists.ozlabs.org"
	<openbmc@lists.ozlabs.org>
Subject: RE: [PATCH 00/21] pinctrl: Use scope based of_node_put() cleanups
Thread-Topic: [PATCH 00/21] pinctrl: Use scope based of_node_put() cleanups
Thread-Index: AQHam8XZF+hoIEqtO0+ph11dwkNN67GFHQ8AgAEJP+A=
Date: Fri, 3 May 2024 23:11:40 +0000
Message-ID:
 <DU0PR04MB9417D5D76707C413ABC0BAC0881F2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240501-pinctrl-cleanup-v1-0-797ceca46e5c@nxp.com>
 <CACRpkdaRpJw=kHtya2iww7vvm+Bt6-oPMmz-6VzfhZniSoMP3w@mail.gmail.com>
In-Reply-To:
 <CACRpkdaRpJw=kHtya2iww7vvm+Bt6-oPMmz-6VzfhZniSoMP3w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS8PR04MB9191:EE_
x-ms-office365-filtering-correlation-id: 5b44d46e-9f13-438a-f5ee-08dc6bc66415
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?QzZwOUVoYzJXWTBHNzY5T1RYYkNJMXA4OUlJRy9VeitoRy9IMHJJejJFZSs1?=
 =?utf-8?B?NjJsQnhmUUZ6Sjk0b2g3MFRPaDVaY3MwSUZyQVRudU5jUU1XV3ZWRmpkNkdK?=
 =?utf-8?B?QS9OZnczZXlFMzhiNFZTNXpWbGJSQUVMOGVqZ3dGaE5IbGRRdDR2K2gzVmI5?=
 =?utf-8?B?bC81WlJaZ0hYTEU5YnVJd2ZKclBZRlYyWitVOUM4ZnllWDZFNFcyZnRzamFE?=
 =?utf-8?B?OFRBWE82bTBUVjk0KzJSWlp0STdCcWxjY1Rha09oOUFYMyttL2E5Yzl3N2Ew?=
 =?utf-8?B?UmVrM0R2endLTUYxaWNwMHhTU1pJM1VJS3NPVUZjQ0pscVNoVHNrWGJSemZ0?=
 =?utf-8?B?NUExUTdBUnZaQjB4MmxkWFoxbGJKL3pBVmRVOUMwcis4djdlVEJ6NXJUZEtl?=
 =?utf-8?B?TFZMbHFEVTFUSHMwc0lZYWNTNk9BWXQ2N05MYWREYnMxclVVT2lYM2Y2UjdS?=
 =?utf-8?B?aXE3NDE3Yi9iRk1vUDRzeDhic1h4OXpwdjNpODZodDJJcmJDR2lOU0MwSDZB?=
 =?utf-8?B?OTA3YkVMK21ldVVOSHhlQVlGSGFpcmN4ZE55ZXdwa05LdkZYNTIyWlE3aGh6?=
 =?utf-8?B?Mk9zek94UXFEOXM5d1NzUXA0THZuMTBYNDBhYWs2elVsZ0FURWRRR1YwVFFq?=
 =?utf-8?B?czIzNndVQWFWVk92clNxYW5MY3JpUjlkQTNqYlpMSXF3emViblFya3FZTnJF?=
 =?utf-8?B?MWJyQ09JVndlRVNpd0ZteXFybW53b203d0tsZXBwUUlQMGNXMzl1cHBpZTlF?=
 =?utf-8?B?U21LR1l1RGpiSGd4bFkvbk15cXFGM0NPNDJyaksrbmRpdS8zY0Vad0hhdHl0?=
 =?utf-8?B?aFhDQ01QN04vRkpjQlowMUcyMzM3d2xHeXp5Q2czaG9yblJkOHloUHV5Vi9w?=
 =?utf-8?B?aGhleFNURHhvaGtEK2trdVpwcndDSmhtVldUNUJVSzdhNzJuc3I0Mnd6RWFj?=
 =?utf-8?B?dVltenZpWUdEYVdSSjI5dDlaTmN0UTVpNU84cUtLVUFxenZlK0hmcHA4ZGpW?=
 =?utf-8?B?Q3VNQTc1dE1DSTErVmh4YWdGRWpSZWlWWDFQUXR2c3dzTUd2cTFOUVkzTmND?=
 =?utf-8?B?cGRtWGpPY2sybVRtaXFQdmVQUEFMWWVodUpscnZEeW1IKzJrc2hCNjZNd013?=
 =?utf-8?B?RW5NRUltcC9tc0FVUzRKYXVKUG9aZkduZVd6cTgwQ2ZIdTVqdXlReHlvTUZM?=
 =?utf-8?B?c1JXdEdBMWMxWW9IeER5ai9aT3F3QTJ1RExrazI2R29NdFRFVXZxYjFlV2xY?=
 =?utf-8?B?bzZDb1BTYkRIOGw2b2gya3Q1OElENVE2Y09pSGZ2cnZ2eDVOYjk1Smw4Rnpj?=
 =?utf-8?B?cnhSNFRhM2Q5ZVk4dU5PeWdza01ET1E1dWQvNzNqZi9oTE5aY05ZeDNoMUVm?=
 =?utf-8?B?cFRwWnA4RFluSUFFelgwTCtaMmZZZWp4cDNTeFR4anAyT0oxQWdHd3hJcDlM?=
 =?utf-8?B?NWVLeHlja1FnN1YxcVY3anNJc2NicWRMRkhhTW5WdHJHaDJMUXF2Q3FLOVRM?=
 =?utf-8?B?dWRHNkpuMWllNWZScGFkUlM2VWlXcDJaWXpuc3hXTlpLdmdEWHAyemMrbnk3?=
 =?utf-8?B?T2FYTnVSdHJ3azJZMXd0TjVPRVdrOGl0UC9rN3lzYW9HRDh6OGFlYXFqQnk1?=
 =?utf-8?B?bm0zSjNENW9TcTFuWWY3N1BLVklyem1qb1diVHdId2JoYkpxMkJPbDRUb2tO?=
 =?utf-8?B?T0dsU0ZsRnVvMWtkS0lZYmN2VStLUFdqUC9WWERqUWhndm1NZGFLSXBEbW5t?=
 =?utf-8?B?bTUvVTBPem5ub1liZU9DLy82bHphTHlHUzdwalpYR1VuTXluNytTTDA4N29R?=
 =?utf-8?B?QVo5cXlKS0pObHdMUk1Udz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MmhUU2hwU3BRSWozZDRDMkl6VW1oR1AzUUNwS2FTb2VOSzFNRmE5Z1JqWEc0?=
 =?utf-8?B?Zm1tdjJVZzBzRElSMnJhWWdsTG1UT0hXRENZVU5zNVhjaDhjUk1GcFlLMzdn?=
 =?utf-8?B?dnNuWFQ0eCtvNDZEU25nTWJqek5sa0xKUmhpU21SZ0VMcldubS9aTUNVdHF1?=
 =?utf-8?B?U2VBelNjcVR1UkF3QnF6MmhWdmZ2c2YwUUpPT0dQSm0wamtVWVpFSEZHSFhM?=
 =?utf-8?B?NE90NzhlWWV0b1p0eFJuQjA3Yk93V1NLZVZjeW95U1VoZStWbFo3YjJZQVhB?=
 =?utf-8?B?OGtJTXNHZ3l3OGdVeFljWjluRXpJbE9rdUtYcWN6UXFPUm03SXdpRituS1hp?=
 =?utf-8?B?bktOSGg4ZjREUGVLV28xV1VRT0gvcDZLVy9TVmNmczRsaWR3dkxnc2kvMGlV?=
 =?utf-8?B?T0lBSHgzaG1Vd2gwU2ZuUXUwV2lSVEoxbi9qOVlNVExrN2ZiTHBPOUpjZWcr?=
 =?utf-8?B?K0xWd2ErMGVTSkFhSmR1dm9yRWUvQ0VncUptalJlQ2JkYjJWQjlpaktvTHAy?=
 =?utf-8?B?K1RSVzdORVo5b2dhTlJQbDdmOHdab25WMG5lejNBY3BSUklnMjNySDBaT2M4?=
 =?utf-8?B?dEFhanFTa2QwR2pBU29Vc1p2ajhrRXZ1U0lROUhsTXJ4bFFrZ01xRFR4TWlL?=
 =?utf-8?B?a1dzMkxLZnA4Y25SbVhuRGY3WEdnbUdVRkIrY0hhdy9QM21wYWFQU2RWWTlM?=
 =?utf-8?B?aUdQeHB6c2pHRzhDS0FxVG4wZEFEWmliL3crWDlOMDlPMWkvZkFrSEhtS01F?=
 =?utf-8?B?eEY5NlFPMWVsWHJEeG5ZZWMrNE4ySkx5UHo5eFRUNHFhYkJVSWNtdjNETTdW?=
 =?utf-8?B?RVdMaTcxN005dmMxZmQ2c2ZvcFFGZjBHdFdKNE9NWUVGV3FOMFpKSVRSVE9Q?=
 =?utf-8?B?ZURZMmgzdjdNajRoWGVIU2tiV3dXK1RnODFSZ284Smx5ZllhS0dVNGVqc0M1?=
 =?utf-8?B?YzBjUzNHTHVOMEp3Nm5iU3RieGE0Smh0cG51VVUzaTJjZDAwc2p2RWhJS2ht?=
 =?utf-8?B?bytaeFBDMG8zeVZ6dDZYWGpwSlVSZFlqNjdNclpvYi9rMGZZb25qcVQ3czZR?=
 =?utf-8?B?Vm1LQWJ6T0gxL3NYYUR5Z3RDVlhoTzBFWHdVT3daSEpNZmh4NGNsdndlWmVR?=
 =?utf-8?B?ZXh0V3RGb3c3b2FGcTBiajJkR1ZROVRDY3NETjJpUjc0ZmpQUzhnWENQTFo3?=
 =?utf-8?B?L0dTOS9zTlZPSmdDbnREbHRHWC80a2NOWCs1ajNuYWZ2T2pzT0RoNVY0R25S?=
 =?utf-8?B?VjR3elluS0ZYRTU4M0tTcmRma3NGa2JtTkl3eUpFRzB3NTkrakNON0dOUjFq?=
 =?utf-8?B?ZWQrRGc3eStheG1VS2FBNVAyNGY3a3BBWHg0WmtpZmZLa1ZYZVo2eWpyeFdy?=
 =?utf-8?B?azUwVkY2a05NSngxWkVuTTJISWYvN29KRk5HTXFhenQ4MXFMRklUSWFzYnhN?=
 =?utf-8?B?Zk1lUkFTL1ZQNUNueEI1RHpoc1RyOGc5Nkh1R0pDMDUwdHFOU3M5c21IRWRa?=
 =?utf-8?B?c2hBNXRwckxYWFhrTmVIbWVwM2ZkZ0phQXlMdndUWGtNeE5LRTNUN0JKcnhO?=
 =?utf-8?B?UmdtNUJZZ01vMHRLcmVEVzZhUGpuT0MxNlZzRzZlTzNpeTNwMlZSUWtYTmpt?=
 =?utf-8?B?TVUzZ0RVMjNCdXB2dm1wVDFKemJNRlI4WkplSVVoNVdsNWdLK3g3RHJIK0FB?=
 =?utf-8?B?akVueHpXK3kvamlRSjBseDBKT2piU00vK0dwbHVna1JxeDIrdkYyRFp4a3R6?=
 =?utf-8?B?STRabEt6K0VlYWVwLzVwN2Z6U0VFVmpOY29hbUEwSXExRm9MVU5MaHVuSVRV?=
 =?utf-8?B?Sk1hZXpqOVk0ODZpdnd4azFZVUZmZW5wbEVQL0xDNThRRm1iSUJWSDh4VGZp?=
 =?utf-8?B?NjJBNXRQck5RMGR2WENCczdaYlVMSk1Mb1J3NVlaRG5qbmU4ajY2UkI3R0ph?=
 =?utf-8?B?SHhFTWwxdkZqbTZEQklzZkNxR2FSWVV6bkpRRGZmYnZqbnEvMHRSRjZlc3VP?=
 =?utf-8?B?QkszSG1BSlMwMWJHTFZadlZ0bjRYZmFXOEJTMlFjN2hpOEVOQno3OUFWZTNJ?=
 =?utf-8?B?SUdISVpBNWw3c3ZFblRZYVZYWDQwdnRCVXZJSVQwUDd4enlxQWxWeDBTMU50?=
 =?utf-8?Q?lbyQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b44d46e-9f13-438a-f5ee-08dc6bc66415
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 23:11:40.6410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XWzUJl2JaHLV99jsMXx0K2J7ZLDHv9l3R3NjqLiga1b4fp0hG0yFwEEW2Oz1wVjKHKLFyXgaIIj61nL5nHeH+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9191

SGkgTGludXMsDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwMC8yMV0gcGluY3RybDogVXNlIHNj
b3BlIGJhc2VkIG9mX25vZGVfcHV0KCkgY2xlYW51cHMNCj4gDQo+IEhpIFBlbmcsDQo+IA0KPiB0
aGFua3MgZm9yIGRvaW5nIHRoaXMhIEkgYW0gdmVyeSBtdWNoIGluIGZhdm9yIG9mIHVzaW5nIHNj
b3BlZCBtYW5hZ2VtZW50DQo+IG9mIHJlc291cmNlcyB3aGVyZSBpdCBtYWtlcyBpdCBlYXNpZXIg
dG8gZG8gdGhlIHJpZ2h0IHRoaW5nLg0KPiANCj4gSSBhZ3JlZSB3aXRoIEtyenlzenRvZidzIGNv
bW1lbnQgdGhhdCB3ZSBzaG91bGQgYXZvaWQgc2NvcGluZyBpbiBjYXNlcyB3aGVyZQ0KPiB0aGVy
ZSBpcyBhIGNsZWFyIHBhdGggZ3JhYi91c2UvcmVsZWFzZSBzbyB0aGUgY29kZSBpcyBlYXN5IHRv
IHJlYWQgYWxyZWFkeSBhcyBpdA0KPiBpcy4gTGV0J3MgZHJvcCB0aG9zZS4NClllYWgsIHdpbGwg
ZHJvcCB0aGVtIGluIHYyLg0KDQo+IA0KPiBJIHNhdyB0aGVyZSB3YXMgc29tZSBwYXRjaCB0aGF0
IHdhcyBldmVuIGEgZml4LCBwZXJoYXBzIEkgc2hvdWxkIHBpY2sgdGhhdA0KPiBvbmUgc2VwYXJh
dGVseSBmb3IgZml4ZXMsIGJ1dCBwcm9iYWJseSBpdCBpcyBub24tdXJnZW50Lg0KDQpOb3QgdXJn
ZW50LCBJIHdpbGwgYWRkIGZpeCB0YWcgaW4gdjIuDQoNClRoYW5rcywNClBlbmcuDQo+IA0KPiBJ
IHN1cHBvc2Ugd2Ugd2lsbCBqdXN0IGFwcGx5IHYyIGFmdGVyIHBlb3BsZSBoYWQgc29tZSB0aW1l
IHRvIGxvb2sgYXQgaXQhDQo+IA0KPiBZb3VycywNCj4gTGludXMgV2FsbGVpag0K

