Return-Path: <linux-kernel+bounces-10881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9166481DDEE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 04:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A14D281A0E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 03:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF65ED1;
	Mon, 25 Dec 2023 03:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UbVZeY2J"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2077.outbound.protection.outlook.com [40.107.13.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE4D15B0;
	Mon, 25 Dec 2023 03:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqas6ELFn4m9uRJoRPyqVyT3oUPmb5jXeTErC/kd2a4zBzKrOjhGmUm2unX27dfUvDg80Q+ZeVLG63SBuHpZ5IW9ExpkCHnGMSHlSWwKE+ciH7/i++0dEmIjDysNOxXZDL8ixcqODX3GsE41FijgvLbj3uKPap1xiy3nMn4mCC7Iuf2fYBgxWQ7emSyDNsvBasPbxq6acSI+VMsaj/L9S04rp/mDphReLJ4X5GnyqPCBEc3a6YEZLxUn5FV+A2b+QJGnXEv091Ee/Xl0OwXrtXNDkeQMBP7sr5ACe78763C0lN6MqL7BLIaq4Nsfi0mDEyFuC6ulZo/LjXqDdpx9mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nHXIdiZ1v03i5bJGyTSZSF9qr/KwyW37UfabobikYA=;
 b=lFLMAZZP2QQA4sHfJCt93UUYkzrR2H+lYK+Ruj6KHVlYZWL7PVT1EK1RNrTb9m7XV+J0apdsyr0D3lr3bmSIkhD/A+PJZ4G2DvZ1X5gj8Jsb5R/crkrnSrso4Z3P41557eiWvPm2Hro6/1yL1TVgjbItr8oCnsySqrmYvKm05bnBd3eHjPppnw0li3hx1eH0E7p04t+ynUWhCxW9Rd0+oXCGToPH8nisGK4iGWIHmkgUwJ4VfUPXG0H6B6noSnNtrsOejKSqmnhqa+DMuUtXaUq3tau5tj+WHBZLUlXCOaTd3D+pNN01tY44H01X5TlErUz10V4AEibXaWFgwodDxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nHXIdiZ1v03i5bJGyTSZSF9qr/KwyW37UfabobikYA=;
 b=UbVZeY2JlR7I1Y1BSgCbasG//2wfDOuP+5ho4FCGTulYyrW99OZKmvFVc8T8Pvc2bwRxYXXdoyynQz0Wvkc2jvOAgiThCOsQ9m2r1/qjkyWe2CZ+ELWpzBkMJ2VKNee2JmaRepxGN3MS2k7uBvY2d841nhlU+eBG+en6E34jEUo=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7839.eurprd04.prod.outlook.com (2603:10a6:102:c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Mon, 25 Dec
 2023 03:18:56 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7113.026; Mon, 25 Dec 2023
 03:18:56 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Markus Elfring <Markus.Elfring@web.de>, Abel Vesa <abelvesa@kernel.org>,
	Fabio Estevam <festevam@gmail.com>, Michael Turquette
	<mturquette@baylibre.com>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo
	<shawnguo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, dl-linux-imx
	<linux-imx@nxp.com>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, "cocci@inria.fr" <cocci@inria.fr>
Subject: RE: [PATCH 2/2] clk: imx: composite-8m: Delete two unnecessary
 initialisations in __imx8m_clk_hw_composite()
Thread-Topic: [PATCH 2/2] clk: imx: composite-8m: Delete two unnecessary
 initialisations in __imx8m_clk_hw_composite()
Thread-Index: AQHaNPU2ppcP/llaeUOj4bOXsvn6uLC5WCTw
Date: Mon, 25 Dec 2023 03:18:56 +0000
Message-ID:
 <DU0PR04MB9417C785D62961AEB47CFDD38899A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <1d494176-2238-4430-bc26-4e4c78fe4ede@web.de>
 <6604590e-d0f7-4798-a1b9-b2f474f3a642@web.de>
In-Reply-To: <6604590e-d0f7-4798-a1b9-b2f474f3a642@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB7839:EE_
x-ms-office365-filtering-correlation-id: 0d14005b-b4be-40da-5e41-08dc04f83acf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1W5N1/icrbvzoDLJcUz9bsE5vLCxDCNl7GR/BDpRXN1DeO3q1a0eyudEBogampBuuncDGT+Nu430Pv1CL1t0OfjgllQqeHQMjOVogS0aYLiR0BBj8GT4ZTST2FDPC4xA8g1xagYzCwj+6Hwc75bRiQDFKLrA2VVhYb19A1kQIzLdgrDf7kVZ9DST3BjtpPWRdQKTsl5+/k0LLFxzrWaFoZTV8cOlavTZBhaYPtWjMZJdxrL4BopNh/8Masik0vhIyjOi2Klil9NlDKRYNR55XefDTgX0O8jT0LIYB/SBhoDUyjMZ9QrJWBtwC+VzM/19ZGKROy9Os+WlDmPnDykHu6XiGzid3oJrWEb8UK63a0MN9Z4Hz1LmaHwGsDXcFcxFXoEHXVZ0MDj29jhdr3JB0Mk5oq7FV+lvbU1Qg1f4p6+jjFvsM2Ng8GKcSwAEy8z1DP5gPdKfmxU3Pe/sxdcFZnsQ0g+D3oR7QGVqECitiS9CVDDwsva5PJQTd32A41w0ZwTuuBPJY9rUBDRvT2yPcEtWmtlDZsaqzdFy+GTYP5YhygQBotrOcjH7660bgMpxM4pmeS1n0Q+o6tUSvcyTUS+3y6tgU4Pq7pNmfNwxAhiX9idziT+VrRLpkuNXsXzxiXUhBrZ+JSs6zWHklefSgw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(71200400001)(4744005)(478600001)(2906002)(8676002)(8936002)(122000001)(5660300002)(44832011)(7416002)(7696005)(6506007)(9686003)(66446008)(64756008)(66476007)(66556008)(66946007)(55016003)(921011)(38070700009)(110136005)(4326008)(54906003)(316002)(76116006)(52536014)(33656002)(83380400001)(86362001)(26005)(41300700001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WFJhMlNxVGZEZWNFZWIrb2g5cW9qV3N4NlFjVEpXSmx3elkwYVVQMjBhUW5P?=
 =?utf-8?B?K2ozLzBlNUpZZ1g0eWVuc1ZhUTJ0R0EveWtIdlJBZzExaUN2TkVSNklaaElU?=
 =?utf-8?B?NndaTGk5VExqMHpKd1N0QlBWYUFrNE1hV2w2VUw1UXVoeTNKcEJlWlc5Yitp?=
 =?utf-8?B?NU1ITXNUbkZKTEJHSWJIZGFtd3pyc29kQVpVbjV1cTFza2JnNjVNV25BTTBQ?=
 =?utf-8?B?MktJd0VJY0VwTkVkRW50M0c0STdXQnRNbFh0a0xaenRBWEh3VVpscUtPRG83?=
 =?utf-8?B?aTZwM3ZFazdtMTFFdklaMnYyU2FTaVlKSEt4QWYyUk5lTnVWT3h2NFBPNTdR?=
 =?utf-8?B?UXNlVWoxU2JOWXg2dy82YTQ3elBpeExVK2k5ZjFTTjExMjVXZFVucmJDMEpZ?=
 =?utf-8?B?c2xlbHhKaWkwZW1KRklydTFENVliSkluUHVTMEZZRW9IM1htVFhCMW9nUkFM?=
 =?utf-8?B?SVFZcFpYUldBalhtMzB0VG5pUGZqNmZRNFNIME9MR1hSeldDM0M3QW5HcS9X?=
 =?utf-8?B?azhYVnc2WG10YlN3TmVkaElnNHNxYUtSTkhrNGFxSVBYM09EZXBuVVVwZXFi?=
 =?utf-8?B?dU8weHVDQjlNQ2hjKzZvWHRCckxYeU4veEo3eHlKazE1QTl3NFk3R0hXdnNz?=
 =?utf-8?B?SnBEWm83cEJtNWdnNkR1d0xyMktJVmVDalBEWFZKWHhqai93ZW1sSVZPbUNW?=
 =?utf-8?B?UUdmVHltcS9KcVk2VDFzRE5BYXlHNEdNSHNoalBtbFNVK2RTZmFUZUs4azZH?=
 =?utf-8?B?QnA5UG9DM281dWYzU3ZmbVRoRlJybTBoQVRVV2FZTmNUbG1RNDduV20zVUQ5?=
 =?utf-8?B?WS9tblV0R21jSkZzRjZYd2NJVkpPb0I5NGErOThKTlE2eTUxZHkzMVRYT0tX?=
 =?utf-8?B?UUNNS2VwZXFkRjd1TWg5TnQxdTJoNDAvaEtkWk5TK3lSbnBjK2U5VHJYQkEv?=
 =?utf-8?B?UUYwcm5pZ2VpbU50UENJVk81TzJaZzdabUJsUFkyUHYzTGMyamRUN3ZEd2xu?=
 =?utf-8?B?cHBaY0w1d0hFemNkcnNaNVp2VHhlRnp3NGdQSlZZOFd4elZMRTRQb29IYlFU?=
 =?utf-8?B?c2tQbzhoQlU0azA3MG1HSnd6aVR3QXQrL3BHR2dWbkoyUHZ1THlpdHRHSXFP?=
 =?utf-8?B?ZnI4SFJZeGhvQmViTXNWWCs5THRoSXRqUVB4QmdIVHpiNnpiY2FRbnNxTnlz?=
 =?utf-8?B?eHpOTFdFdldEWFFuY2h4eWVYUTZSTStxV0xzd2ZYNlJ1azA2NkNTUkFWVjRD?=
 =?utf-8?B?SzJvUlB2NldtUkFycDFBM3pUNGk0OW5CTGJyTDBNZldyS1ZoYXVpVjZHQXE1?=
 =?utf-8?B?dVJsTzdlMzBpaVRya25VR1padGlyZUxYd3RwTXVjc0xUbjlraUk2aStvc0hH?=
 =?utf-8?B?UkVqUlNrNjRrWVBOR3RRWGtjeHpmYTNlZVdiem1pMFAxU1pzSUkwcTlDZDlB?=
 =?utf-8?B?MkdOa2Y2WGMxTXBHaVNpWmVEQkVBSHo3K094dVh2SUZTOG9Dem4wMTVZWWoy?=
 =?utf-8?B?WE5yVVJiNFBrR0hjZy9TSys0cTVzSmJpdmFPZ1ZId0R6am50emtjNVJrdFVY?=
 =?utf-8?B?T0cwTXFxZGQ2dkpYbDh2WVluaFArSk1RaVM5Zi94OWZWU3ZNT3lnUlBzdzZW?=
 =?utf-8?B?ZXFUODdoUkdaZEpwREtjRWl4WHlIbkswRnFqeVBrVE9IYTgxSWNNTXZvVktM?=
 =?utf-8?B?Tld1WHhINnB2cG5JcHIrR1RBWWpaVERpQTlUYXhhZG5kRW9lL2dHL2lXWG8y?=
 =?utf-8?B?M09JeXBnWmJkckJUaGtTK0syVlRxWlpmRCtMS0VkYW1yR1hFazExT2lHSTMv?=
 =?utf-8?B?cHhFdEErdjdpbjlXREduenV0MXJNTlFuZlBDS1JlNVkxQTdMWncrSUZRaHdM?=
 =?utf-8?B?dVBiZVV6Znd3dFBKOEVDWGJucHBTcmtuK2VGalVTOEhBN2t5YUU3S0dRWVNi?=
 =?utf-8?B?VkV0MXF4UGI2dW1DeXdzRiswSlYzcCs5aWd6ckRIZXI0VmpCREhIOW42RkR1?=
 =?utf-8?B?VitsaFRhaklXQzNQdGJ5NXpLVHFuOEt0LzJSQjh3cVJnbHRHTE44QjJhUU9W?=
 =?utf-8?B?d3pxSmJTcy9GM2xPU1ZmTFlQVlhjTGJDY2FQSG1ZV3FRcVhqV0pXT1BVT1Fv?=
 =?utf-8?Q?kvu8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d14005b-b4be-40da-5e41-08dc04f83acf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2023 03:18:56.4732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L8ZBSbcHxGlYI/p7wGvVRf5g+R/wdaDfXG6ipovzLk5EOrpWmQShuiGdTfAQ/9P9UjBRJ9nd2O/n0rpX9gX+3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7839

PiBTdWJqZWN0OiBbUEFUQ0ggMi8yXSBjbGs6IGlteDogY29tcG9zaXRlLThtOiBEZWxldGUgdHdv
IHVubmVjZXNzYXJ5DQo+IGluaXRpYWxpc2F0aW9ucyBpbiBfX2lteDhtX2Nsa19od19jb21wb3Np
dGUoKQ0KPiANCj4gRnJvbTogTWFya3VzIEVsZnJpbmcgPGVsZnJpbmdAdXNlcnMuc291cmNlZm9y
Z2UubmV0Pg0KPiBEYXRlOiBGcmksIDIyIERlYyAyMDIzIDE3OjExOjAzICswMTAwDQo+IA0KPiBU
d28gbG9jYWwgdmFyaWFibGVzIHdpbGwgZXZlbnR1YWxseSBiZSBzZXQgdG8gYXBwcm9wcmlhdGUg
cG9pbnRlcnMgYSBiaXQgbGF0ZXIuDQo+IFRodXMgb21pdCB0aGUgZXhwbGljaXQgaW5pdGlhbGlz
YXRpb24gYXQgdGhlIGJlZ2lubmluZy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmt1cyBFbGZy
aW5nIDxlbGZyaW5nQHVzZXJzLnNvdXJjZWZvcmdlLm5ldD4NCg0KUmV2aWV3ZWQtYnk6IFBlbmcg
RmFuIDxwZW5nLmZhbkBueHAuY29tPg0K

