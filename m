Return-Path: <linux-kernel+bounces-167639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9D28BAC86
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4657828172E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FC5153565;
	Fri,  3 May 2024 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XTDC5hji"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2088.outbound.protection.outlook.com [40.107.13.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535DD2E620;
	Fri,  3 May 2024 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714739300; cv=fail; b=VKxoQ1mHjriQugOXM6d3wSWpE/C44S4j7UZQLGqFm2h1ryAMZTIcvIimhEuqLDix9wR41TPDAgkMCtAl3rt5uEGMkn24nxkjMJUgduxp/P51F0aGUYQjdlsGf/LHhEDDtcWIqos4d0v0MG0MZTQk316jH3w+R0m9R1yx06vkXC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714739300; c=relaxed/simple;
	bh=4srOBw1z4hQqr2JejrESGMxlT9ILfWSM5RusXpa3jao=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N7Hfo56Eilu7ZfTwAUHOqKCNfCOJVzlZyzsb8U5z3fej2g241v3MX2/4PZe2iY8BnzLo1M0W8SmC+cJcae/GMzyyZ5AtKWOObvUn3kaQFLhT1O8lVikZVsSbh3S6P0nE1GZf96kuzUbCceTGCTS70fWZbujaQIO3mtaxWJb9ErU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XTDC5hji; arc=fail smtp.client-ip=40.107.13.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiF/NZUoRLPLXEzsqFz1PcDYEFIinP3w3ShC5xJ+pxNnrux6Wj2lt8tIgAKLzawCjOCjsmjvGM1zbZgxuKPWYlc1bitPg9cXHQRLaoRg+HTgL4AiAGNSxFdWVVf28Ie2cwcglWd2D7Qah8br21djw1X2Av5m5eaLD0XwNKnLg9bxGp9Ly/5gISjuLJDXxNIAa6y0ZRaJWCOsx+VslvmyXHj5MtxYaqC7XAQbE5I08f98TrbGZMc9fQooSdi6ghdE5EcwSuUztGO8nWb/3UHZTFSa5mxNxExVyZkk9J/RkIxQTwdc1EneEx3g9BgZkTaUPlUYLUpJZje8Ui4cv3DFsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4srOBw1z4hQqr2JejrESGMxlT9ILfWSM5RusXpa3jao=;
 b=gjsAav3P1h0R45PVbWg7h9t9SZQfU7D9jB1Q4guqSGAY7BeKYYbK2mHk8Ln7HuWLl/9dP3jUiIM2Vu158hRrH32hD9ZZBAWia1PcbwOM9wX9QoN1z3Up/+NUcmHKz/LJBGcsmuktopn4m+0A7z7bJNsEL91sS/U6BcCL3zG0/C1X0G/aEorMi2bQIonKtmm/slwZjHP0lRJ7qhe2YTMcb/elnE7Y2cLw1L4t5/fPNZLMuVNI/djl7mik1rao12txOeXMCPNhvoBIEESrEZoJrqH0Dg5smXYkVWsZ24rRUK5WLRQCSrDlDuyT1ZHwnLf4+UKAEmHoXLgNNiD7LlUryA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4srOBw1z4hQqr2JejrESGMxlT9ILfWSM5RusXpa3jao=;
 b=XTDC5hjiQBXjDDpO8r2kGlYAH2kch5i1iC4AzpGtlglN15hOmYK4KvAg6tE6rQP8Gpl7+nSzlzjHfOy8GRcqPmRqenBSINSaIytYSJNcHw0OBat3CfyYBw22FskDJGmh4Ac/Sz8pa2+ZGqF+Bz6NY2kWgdPdduS0nhMG9xgev6E=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA1PR04MB10100.eurprd04.prod.outlook.com (2603:10a6:102:45c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Fri, 3 May
 2024 12:28:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 12:28:15 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Alexander Stein
	<alexander.stein@ew.tq-group.com>
Subject: RE: [PATCH v4 3/3] arm64: dts: freescale: add i.MX95 19x19 EVK
 minimal board dts
Thread-Topic: [PATCH v4 3/3] arm64: dts: freescale: add i.MX95 19x19 EVK
 minimal board dts
Thread-Index: AQHanPlbUOlwP2mwJk6RsurtWkfXmbGFRa8AgAAl/1A=
Date: Fri, 3 May 2024 12:28:15 +0000
Message-ID:
 <DU0PR04MB9417862B60AEE9656A529974881F2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240503-imx95-dts-v3-v4-0-535ddc2bde73@nxp.com>
 <20240503-imx95-dts-v3-v4-3-535ddc2bde73@nxp.com>
 <CAOMZO5D9i8LG7-4X6D+oHfZrJj+QoKa0DTusMX-H32227_s_4Q@mail.gmail.com>
In-Reply-To:
 <CAOMZO5D9i8LG7-4X6D+oHfZrJj+QoKa0DTusMX-H32227_s_4Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA1PR04MB10100:EE_
x-ms-office365-filtering-correlation-id: a30e8dcd-3f19-4a83-a5e8-08dc6b6c81a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|1800799015|7416005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?L2NWaDdYRzd5cHdNdzRGclArTnZPR1FjbWZpZ3dYb3dsQWtxTDFocVlkRkRR?=
 =?utf-8?B?SmZ1OWZqcjVBUGlJRlNONGR2Q1k1UjE2MWpLbUdPTFhQb0JBQzdWS0c3bG9y?=
 =?utf-8?B?ajFGRDdwaUFnWjVST0IxQmtvZDgraW11ZlVOZkF2Yzg4ZnlwN1RpTktBRTEx?=
 =?utf-8?B?UmhpWGtKSEVBTzc5R3hhWXlTODRUQnMxMlpBMmFueDlFTFZmMDBDRlpVWkJG?=
 =?utf-8?B?V1VJZFZFcHJ5VmZDc250dkpuWVNJendhSExhZEZMaUlzYTFKa3lPdDF0VkVz?=
 =?utf-8?B?WmxONWtqS3FaYk5aL1BEcUpOZXVkSkxNSGpoU1MxM1lBU0IvVXZ5bDhMQjJi?=
 =?utf-8?B?QmJic2dtNzlKM2RVNWQ0b2JKM0J1eUdydlFjZmtHUzNPaGlxVmhhcVpXWVBR?=
 =?utf-8?B?djQ5ZEZONkd3MC9JQlp1emxpTHBFU3NsdkM2RFB5cmJyaWxEZE05WjByNmUv?=
 =?utf-8?B?N2YwV0UrU0RQMXR5Nk9KdUtvOUFEWHlRWEd5a1pCcGJXM1pQUDJGWUx3QldI?=
 =?utf-8?B?bTFKa2JWNzFxYW9IVUszZ01ZeXhwU2FKMFl1Y1pqVFpEVVBsZFhQUmtZeHdz?=
 =?utf-8?B?OVllVkhHaFVsZjl5OFg0VFZHNytDR1B5Tis0RXdRTSs1dTN5ZTVYbzAvT2pq?=
 =?utf-8?B?UEFJd211NDJXUzNiQ3ZRZ0NmekhCcTQ4NU1HUW9wYWVsWXdsZFoyVmJLMWVa?=
 =?utf-8?B?bnVYR1NrNVdtRndqVUFqdlplMk5LOWVuRlN5Q05WSGtrb005bE1tNG0wYmV5?=
 =?utf-8?B?N0FVbnRnR1lMK2w5R2RQRGFlKzV3Y0IzUUo4TWwvWDUvOGcxUDk2SWduZEhn?=
 =?utf-8?B?MlRiblFnQlV1U0NzSXdsdUw1d0ZMbWpubkJySFcySnN4VGM2MENLR3gzS1NK?=
 =?utf-8?B?U3g3U2w0RTcybEVHekFUbUJHQjI3eE9sK3pBRG1IeVUybWFvaytFT2VKZUJU?=
 =?utf-8?B?bGI2ZEx2bkJITlZiazRKV2Z0OGZGTTAyV0ZQRW9uVHZQalVrSUV2bW5Hajk2?=
 =?utf-8?B?V3h3ajRocmt1QStZMzZjeTFaNHdJN3NlbktTVndWUEdERkdvTW9KYzZBV0lK?=
 =?utf-8?B?UGIvckdSMUU2aWllRmxoUTNKTUNNR0RYYzNpYmRLZ3RkVGhZOGMxK0t4bVFW?=
 =?utf-8?B?ditQYnZUdUhTb1VHd1RDdnFmcTJEbm1ubWVkaHd0OS9IRkJ3RXA0OEJYaWhR?=
 =?utf-8?B?Z080VE9KWFJFek80QzRGUEJjb2doZDBsM0syV2xkb3kyZmd6TXZZTGhWM3Zu?=
 =?utf-8?B?SGZyaWhreHJwa2JmeGUwem9SbUZTWVNUeTd1b3QvMFhES3VTdklnRnB5cUFK?=
 =?utf-8?B?VHh4ZU96U1BGaW40QTJwRmpkU2pkdmViV2k1d3VZelVkcDhJczJmYkJZQUY5?=
 =?utf-8?B?VDhRWitER0l3L1MwRlgybGFGN2dhRDdUdzJablY0Q2ZYcFlFUUJydHI2eWJh?=
 =?utf-8?B?bEVVdlUySzdobUt5TGZHRmJ5aVVpc2JWeWVyTC9yK2VNVEpPaG5EMjJPa2Q3?=
 =?utf-8?B?cy9EV0VWZUdYa3NtUDh3UzYxcDR2OTRJaWhCTlFKMFUxelBtUUpTNXk4OWwy?=
 =?utf-8?B?UnpsdExCV09iM2JWNkI1aUFrN29GakZpYnNDUmh3RlBLalpIU1pVQ0VGbXVY?=
 =?utf-8?B?TjJUUHVYVG5EWGpwdE5HTkNSdUtkckVNT0pMa25SVCtvbnB4ejRtTHlrQ0V3?=
 =?utf-8?B?WDlJNkRDUkZDK0czalJ2V015WWEzYkhuWFR0ZmgvZEhWc2xGb25sWjlVNXJn?=
 =?utf-8?B?U0VKT3A4YVNxOE5EMHZUbC95anVDb3M5dUxVZzNBeVhmL0RXMU9FV0JPTDg5?=
 =?utf-8?B?S1BiRnR6Zys3akxCUU5mUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RlR1Sm5OdzY3ZHV5d0t3QkJsZjZtNk5ncXZaSysyWk1FcFhwZFdlSnFTNlIr?=
 =?utf-8?B?L0xoOVlXTzVFYmV0RHNWR0ZFd3VQaHJ2cDVaOURoT01mdHlZamc4Z0xjTzZs?=
 =?utf-8?B?Q2NYWG9TVVl4MDdoTXdKYnB4NkZ1OGJpRnFyajlsRVpqMGkzUmd5aGpKTlpp?=
 =?utf-8?B?VEZaeW5ZYk5uT0p4VWlpcFdNQmhaRTBrNmIyRGsrQ1ZtNTB6RzAxdStRTE1z?=
 =?utf-8?B?aUtXd1NSZWFJQnZKLzNuVC90R3o0WllEYXhzd0gyM290N3NyWXVjOXFyTDJj?=
 =?utf-8?B?VEg3YkVyVlBZclJEa2oxK3lNSGV2V1ArdFR6SnJ2OTRaMitHWDJoQ28yWjdN?=
 =?utf-8?B?czlteXIvVzRJLzJUMjBLQXBGQXhWaU44VFVQZnBnRG1jY0N2aVNET1ErNU5H?=
 =?utf-8?B?S2xWVmFta2ZjVHlTUWdWNmRZL1FBREwwQW1VQ3hPRFRRdDcrT05zaHErTUhK?=
 =?utf-8?B?dVNTaW0zSWxOOUF4YzFoZ1BCQlhvZi82OEovelBDZUJHK0I3NTF3WDNBWFN1?=
 =?utf-8?B?OG9tNzY0UmsrYUJhYjR6V25zaHJjMkpRODJaU2o1WjhsbzB2UkxtaUhFSnpB?=
 =?utf-8?B?aDdSMjNyR2N3WC9QK0p5Q0lTWkQxMXUxREVnQzhNd3NVcmpDa0t3YlMyc0hl?=
 =?utf-8?B?S2tSdmN1VldhWUsyN0o1NlpnYkM4dW9Ic21PUmhES1B6Yi9Mb3BFbTd6T1gx?=
 =?utf-8?B?eTFESEdPR2hJc2wreXZZdjJvSjJ1WGdmMmxTQmloTjRRY254N1dvWWlhdE5D?=
 =?utf-8?B?bUEzQytHbWhGUDh0RUZVUXVtMnRxTmllS3VITG1YZ2dhd29wYVE3UndPQTdJ?=
 =?utf-8?B?NmNXQ2g3ZDJrUzUyUTg0K0tidG4yaFZWNjMrU3dCLzFHN1RRZUtnQmFxKzZ0?=
 =?utf-8?B?MGVyUHdTbVgzNkVBeFlSSW1qVURtWTV4bDJwQ3M1d2lBeis1eFVQY2Z1bG9v?=
 =?utf-8?B?Rm9jNWc1ZlBRemVSTElFQjhuTXNkMDZCREpMcjdtN0FIVDRpdXRYVG4wM3Jh?=
 =?utf-8?B?aHM0dzgrZy9wc05lRUk3by9oK2k2OUx0cDlYeGdQL1JEb3NpYlV4allBSUJ3?=
 =?utf-8?B?czJRMy9TNVYwZ1lIZHkyOXR4ZVlhUVR5SzJEallQd0VXTUxVQmlZcnRnL1dR?=
 =?utf-8?B?TDVkcXNrUjlYWFVMM0ZBRGJpM3dGcndWUFR6ZlRkMm1oVDcyb0taUyt6bHlz?=
 =?utf-8?B?cFdTMlhxQnByREpXQVBJQ1JNanVaS3dORi91MkR6WVV2WDNzVGp6T0JRbUtz?=
 =?utf-8?B?MjducXNoR0VOVFpUeUgwUlRoY0lIa2Y1Y3pzR0g0MUh0K3MzQldINWVaWFdY?=
 =?utf-8?B?a2djL3JGTFNqeGtzVjIvWXNjTzZob1ErV2EvSm4wY3psYUZHbWRkR0wza2pj?=
 =?utf-8?B?UlgxcW5oOHUwMWxZeVlKSCs2SXhDYjJ5QkV0QWZYODRXcW95RlBPQVhiand3?=
 =?utf-8?B?NGFIdGMzc3RzUmhXMWdkbm90Q1VkUUZFVkdyVUw2SGdWeE5Xcy9TeG8vdTNO?=
 =?utf-8?B?T2FpMDhERUhBcitTN29CM3NUb0w0WlIvZGRWS0N3YVpVOHk5MXBNNUxVNm5u?=
 =?utf-8?B?Zzh3cmVMbUw4YjdCdjVPMHFManl4TUdLY0tHNWhFQm9XNU5rMDREOFBwamdo?=
 =?utf-8?B?ejlMaS9IY29VWUxUZyt0azFmUU1CbWNQU2w0QjUyS1pjOVhId3FKbzBabVVV?=
 =?utf-8?B?V1drWHpyYVl4b1JaMkFLR3k2MnMrNFVGSDhyU3c2Tndrc2gvZ0VIN2ZmQTZW?=
 =?utf-8?B?bUxBemNjWVZyWkxOZXpwWlhKdXJ4c1RpTnZyNFNkOTdSQ2VQWWVaK1IzRkQ0?=
 =?utf-8?B?Q3dxbDlpdENEZE9iZncvOElEQjIwNDVsVnlCeUoxN3RBRXRSZ1V2aEN3b0VL?=
 =?utf-8?B?VmNkaldJY3lWOEVTTmlDakV0bzkrK1V0K21RUUkwclpSK25pai9HbmxlRE81?=
 =?utf-8?B?d3JOcjNaNVRVOENaSlpFTElQeGcxM0toMzZkNDdkckxrVGxTTmhmN3FzWWw1?=
 =?utf-8?B?dmhIc2tNOWJFQ2l1R0lCZ1dTQW5ibDVsbDg2UU1aYjc2TlArbGt2Z2J1eWYr?=
 =?utf-8?B?ZitVUk5PT3ViYlcwYUV0R3c1RGJOTGhsRytzTUVQbmdOZVQ4U2EwSmNYZEhv?=
 =?utf-8?Q?A1f4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a30e8dcd-3f19-4a83-a5e8-08dc6b6c81a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 12:28:15.5089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gQ817+UWvwWTFCc3nVDJNSwntGgv0TZM6VGVSHlCBI+Y6eIVcI4SKti31h1eQknjY8hPEvsG1/Y8EE/ltkIorw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10100

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDMvM10gYXJtNjQ6IGR0czogZnJlZXNjYWxlOiBhZGQg
aS5NWDk1IDE5eDE5IEVWSw0KPiBtaW5pbWFsIGJvYXJkIGR0cw0KPiANCj4gSGkgUGVuZywNCj4g
DQo+IE9uIFRodSwgTWF5IDIsIDIwMjQgYXQgMTA6MjnigK9QTSBQZW5nIEZhbiAoT1NTKSA8cGVu
Zy5mYW5Ab3NzLm54cC5jb20+DQo+IHdyb3RlOg0KPiANCj4gPiArICAgICAgIGFsaWFzZXMgew0K
PiA+ICsgICAgICAgICAgICAgICBncGlvMCA9ICZncGlvMTsNCj4gPiArICAgICAgICAgICAgICAg
Z3BpbzEgPSAmZ3BpbzI7DQo+ID4gKyAgICAgICAgICAgICAgIGdwaW8yID0gJmdwaW8zOw0KPiA+
ICsgICAgICAgICAgICAgICBncGlvMyA9ICZncGlvNDsNCj4gPiArICAgICAgICAgICAgICAgZ3Bp
bzQgPSAmZ3BpbzU7DQo+ID4gKyAgICAgICAgICAgICAgIGkyYzAgPSAmbHBpMmMxOw0KPiA+ICsg
ICAgICAgICAgICAgICBpMmMxID0gJmxwaTJjMjsNCj4gPiArICAgICAgICAgICAgICAgaTJjMiA9
ICZscGkyYzM7DQo+ID4gKyAgICAgICAgICAgICAgIGkyYzMgPSAmbHBpMmM0Ow0KPiA+ICsgICAg
ICAgICAgICAgICBpMmM0ID0gJmxwaTJjNTsNCj4gPiArICAgICAgICAgICAgICAgaTJjNSA9ICZs
cGkyYzY7DQo+ID4gKyAgICAgICAgICAgICAgIGkyYzYgPSAmbHBpMmM3Ow0KPiA+ICsgICAgICAg
ICAgICAgICBpMmM3ID0gJmxwaTJjODsNCj4gPiArICAgICAgICAgICAgICAgbW1jMCA9ICZ1c2Ro
YzE7DQo+ID4gKyAgICAgICAgICAgICAgIG1tYzEgPSAmdXNkaGMyOw0KPiA+ICsgICAgICAgICAg
ICAgICBtbWMyID0gJnVzZGhjMzsNCj4gPiArICAgICAgICAgICAgICAgc2VyaWFsMCA9ICZscHVh
cnQxOw0KPiA+ICsgICAgICAgICAgICAgICBzZXJpYWwxID0gJmxwdWFydDI7DQo+ID4gKyAgICAg
ICAgICAgICAgIHNlcmlhbDIgPSAmbHB1YXJ0MzsNCj4gPiArICAgICAgICAgICAgICAgc2VyaWFs
MyA9ICZscHVhcnQ0Ow0KPiA+ICsgICAgICAgICAgICAgICBzZXJpYWw0ID0gJmxwdWFydDU7DQo+
ID4gKyAgICAgICAgICAgICAgIHNlcmlhbDUgPSAmbHB1YXJ0NjsNCj4gPiArICAgICAgICAgICAg
ICAgc2VyaWFsNiA9ICZscHVhcnQ3Ow0KPiA+ICsgICAgICAgICAgICAgICBzZXJpYWw3ID0gJmxw
dWFydDg7DQo+ID4gKyAgICAgICB9Ow0KPiANCj4gVGhpcyBsb29rcyBsaWtlIGFuIGV4Y2Vzc2l2
ZSBhbGlhc2VzIGxpc3QuDQo+IENhbid0IHlvdSBqdXN0IGhhdmUgc2VyaWFsMCwgbW1jMCwgYW5k
IG1tYzEgaW5zdGVhZD8NCg0Kb2ssIHdpbGwgZHJvcCBvdGhlciBhbGlhcy4NCg0KPiANCj4gPiAr
ICAgICAgIHJlZ18xcDh2OiByZWd1bGF0b3ItMXA4diB7DQo+ID4gKyAgICAgICAgICAgICAgIGNv
bXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsNCj4gPiArICAgICAgICAgICAgICAgcmVndWxh
dG9yLW1heC1taWNyb3ZvbHQgPSA8MTgwMDAwMD47DQo+ID4gKyAgICAgICAgICAgICAgIHJlZ3Vs
YXRvci1taW4tbWljcm92b2x0ID0gPDE4MDAwMDA+Ow0KPiA+ICsgICAgICAgICAgICAgICByZWd1
bGF0b3ItbmFtZSA9ICIrVjEuOF9TVyI7DQo+ID4gKyAgICAgICB9Ow0KPiA+ICsNCj4gPiArICAg
ICAgIHJlZ18zcDN2OiByZWd1bGF0b3ItM3AzdiB7DQo+ID4gKyAgICAgICAgICAgICAgIGNvbXBh
dGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsNCj4gPiArICAgICAgICAgICAgICAgcmVndWxhdG9y
LW1heC1taWNyb3ZvbHQgPSA8MzMwMDAwMD47DQo+ID4gKyAgICAgICAgICAgICAgIHJlZ3VsYXRv
ci1taW4tbWljcm92b2x0ID0gPDMzMDAwMDA+Ow0KPiA+ICsgICAgICAgICAgICAgICByZWd1bGF0
b3ItbmFtZSA9ICIrVjMuM19TVyI7DQo+ID4gKyAgICAgICB9Ow0KPiA+ICsNCj4gPiArICAgICAg
IHJlZ192cmVmXzF2ODogcmVndWxhdG9yLWFkYy12cmVmIHsNCj4gPiArICAgICAgICAgICAgICAg
Y29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4ZWQiOw0KPiA+ICsgICAgICAgICAgICAgICByZWd1
bGF0b3ItbmFtZSA9ICJ2cmVmXzF2OCI7DQo+ID4gKyAgICAgICAgICAgICAgIHJlZ3VsYXRvci1t
aW4tbWljcm92b2x0ID0gPDE4MDAwMDA+Ow0KPiA+ICsgICAgICAgICAgICAgICByZWd1bGF0b3It
bWF4LW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsNCj4gPiArICAgICAgIH07DQo+IA0KPiBUaGVzZSBy
ZWd1bGF0b3JzIGFyZSBub3QgdXNlZCBhbnl3aGVyZS4NCj4gDQo+IFBsZWFzZSBhZGQgdGhlbSB3
aGVuIHRoZXkgaGF2ZSBjb25zdW1lcnMgZm9yIHRoZW0uDQoNCm9rLiBXaWxsIGRyb3AgdGhlIHVu
dXNlZCBvbmVzIGZvciBub3cuDQoNClRoYW5rcywNClBlbmcuDQo=

