Return-Path: <linux-kernel+bounces-70148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4F68593FB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 03:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EFFC1C20A21
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 02:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19F415C9;
	Sun, 18 Feb 2024 02:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fY1g+aHN"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2077.outbound.protection.outlook.com [40.107.249.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7D61103;
	Sun, 18 Feb 2024 02:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708222249; cv=fail; b=O7A4Idv0AYLoNVTN3omQOIOaPlfvtfgiSS5NFsoIZbabhshwmM47eJ4tpFgUJRyvSZrEb0ogkbTnZAnGLoBZg1k8EP8ifHiA1iIJLz4fInMXJPH3/whP20G/xaDZju4XRUXHn+m8B3J3gZ6DyXHWTn1GypEL/kPo+YIvZAtn+fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708222249; c=relaxed/simple;
	bh=F5QVCXGgwA6aqQx56Yt+Yq4c/F+Ln1SpnSXHaJJgigM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DX8yjTwMMHt5ag4ahWoWPdfMCvkjtQPh/CBqIOmLyHtq4ShKEhvyytTTe//7RKiAqvuHyEmnO7keQRFzgqhXMy7NDpQHt64FFA9/uxYbTyWaHbFHHTkmD8tbMsX/ZNUfDd1IwAmkX1AnMuNo3i+r5/JSKadV1IWbmkKCFjIio4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fY1g+aHN; arc=fail smtp.client-ip=40.107.249.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILFPFo2iXA5bEQsjBRxcqcSnTUNy2MThM2JpsBzFc5Q3OZD+kV2GClRmWxmIJBSIsUqF4iRy1Adt9t8EYKPe5ugjZesT4qgUJDSfNQC9VJNBcT4Nn1hDINQ4GIvUYK1WBiQtCTYt9lUC1YAbZa3KKaDK0fvcxfISdwT+oqB3WG21E6fNwJl53Gggqj/qVO6aI+92kI0Jgvdm3bDsb7Il/b/BMc5yXwJttjGXxq4bJaM6f4Vpp7pFitca8r+vb9HTIMRMnN+/RAwbuf85AMwKrCsvcN+KfzZXh5WZkFmYffJAZV9GRh5HQ4aaFfkUe8i5xQr2b3JCSY4eQopCFfaZwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5QVCXGgwA6aqQx56Yt+Yq4c/F+Ln1SpnSXHaJJgigM=;
 b=fFABF9f518J5q5M2PoPtPTbZt14QvszuWetNLrW7pZ4Vsfkxn8r/UTXLhYN7zojMKkI3FOtIXCYlij0cTvul680UgzkqIHotJ25WzRK4E+2jv66FQhFUdQ8x76kQa8yGrGv9Pfe30kA5Hq57GGWx+8FGBCCMtol3bfE4B5TelLxhEUlXXV09KxxiJkbUb2rJ7VCjYbpV1xOXm+YcDQ2j2snrdIHCH2r8UAtovtdBlYGruVSw/N2WRsVN3JPHmM6A8alTPJyAUZQyel2CuABlFbQSDYHb+SGJed6i4auxyfAiTxs4+Lneb49BS9tpmdl6zSewS4/6F0Y97Js8GXgsrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5QVCXGgwA6aqQx56Yt+Yq4c/F+Ln1SpnSXHaJJgigM=;
 b=fY1g+aHNKo/sazLk3Y8JIiR2EyaLE9rO+N8Lcfwt6ooKE2rRictGlVmIaNRCBJdXD8HPKBwrFCArUR1oSWYCtwqozxDXHWJANnktckQnY69Wa35PsZlebO47DftFNDj+pTEsypEFvxW9agSbKX6DEEn3yWp9hNrGaiu3Vk87U2E=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9572.eurprd04.prod.outlook.com (2603:10a6:102:24f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Sun, 18 Feb
 2024 02:10:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.033; Sun, 18 Feb 2024
 02:10:43 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Jassi Brar <jassisinghbrar@gmail.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: RE: [PATCH v6 0/4] mailbox: imx: support i.MX95 ELE/V2X MU
Thread-Topic: [PATCH v6 0/4] mailbox: imx: support i.MX95 ELE/V2X MU
Thread-Index: AQHaVJw3fd3lG9k4w0GdiaKSDUAWyLEPbOxAgAAIQQCAAABZIA==
Date: Sun, 18 Feb 2024 02:10:43 +0000
Message-ID:
 <DU0PR04MB94170454D64EF65E6774BEAB88522@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240201-imx-mailbox-v6-0-76f4f35b403e@nxp.com>
 <PA4PR04MB941646795F4E19D1EC35134F88522@PA4PR04MB9416.eurprd04.prod.outlook.com>
 <CABb+yY0aM9Dn3LPBqb11vU3Ln4bCCGOBXX77sF499cyb_sXiUA@mail.gmail.com>
In-Reply-To:
 <CABb+yY0aM9Dn3LPBqb11vU3Ln4bCCGOBXX77sF499cyb_sXiUA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB9572:EE_
x-ms-office365-filtering-correlation-id: 074d448d-ec74-4121-8fde-08dc3026cfae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zASQeCUClDw1InjdsABtn2raWKlfT8yjqlZ6gnmNh9ZWxLCbX3fhmjOKlKvkRl6SXMuAccgoSKXQVw84ljUe9eW4oOoBXopgkI0xeiT9HMZcZm2RGf7hCvdFERQXOmrIsCt6p/e887s0SxG623mhKUETOi5aaOWSByC/Zv9Tw3+zr09EPT3fpKKlIAnV4A3fOHbyisTXxsUyj+9vmTFt5I/LaS/0KzNXIYBqgUQrMftowmceI+yASHWFo1turGt4u2XzVqHMSH/trJrQerKzKkIdJjmO2lW8d4Spl/KskHWPoht8boxVOut4LfLc/ZsPiQtXDgF5thYbwDP0Yc17OQ+2ast5VwpmQDR7HE0McIcxsU0BqUQinuV/1XJuxceIIyJL3w9g4piwAAcoERLbdHuRPb3jGhvTqXSCegHX2dfoKL+X+Hm0pNC7mCb1BhfevtWcHvlh3+hmmWTUGbHc9NUtej/ET7tv7Qe2803UvIYLDpgJGnJLHyDIiw6kTaKDPhpGKYHlzOKlCR6B4QquTp01DpR9VhXQH+/jyHS8Q3f75UvDDoSXbf5C6EdfdifaCdhkJaIJ65GYacN3hx1DvnhFDT79KGdEBK2k8/I0fdc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(136003)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(52536014)(8936002)(64756008)(478600001)(41300700001)(6916009)(83380400001)(26005)(4326008)(8676002)(66556008)(66446008)(66476007)(76116006)(316002)(66946007)(38070700009)(7696005)(966005)(9686003)(54906003)(6506007)(122000001)(33656002)(71200400001)(53546011)(86362001)(38100700002)(5660300002)(2906002)(4744005)(7416002)(15650500001)(44832011)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZlFxSi9semJraW9wTHhoSlhwUjZwNUpKMkl5ZlFUMlEvRlhCTWFDVmFDSFQr?=
 =?utf-8?B?eFBoaHZ1VnRSQVkyaEVRVGhqVGpyVUsvTUIyQ3R2NWhKN3NvMVJhVU91QWlq?=
 =?utf-8?B?ZHhlaC9YWDJEZVRVK1lSQ2FQZUhFNzdNQWs4MzF5NkUrd0p1WHl2bjJzeFh5?=
 =?utf-8?B?eVdtUG9qZ3RycU50d0JpNG9hcm5sNFNYekxXTk0rKy93a0x1ZzU4ZllWZDM3?=
 =?utf-8?B?d0Z4N2VVNFVLZURMSnVnSXJqbTN0UzUwdzBtYkpELzJ4SXQxcWlSUXdmdHND?=
 =?utf-8?B?WGoxc25jTjhLSHY5V1lRVE9GYlRwQ2tVTm94T3k3eDBqYk5yVnRWbTZDMHcv?=
 =?utf-8?B?Q3FnWVpkUCs3YkYzak5rOVU0elJjYXlHRlRYaTAzK21QZ1p0Zzd1YkxCM3lW?=
 =?utf-8?B?UGhKQnJOd3QzdHR1Smt3aHFUaGkxSEdXTkYrUi85bkIwcjdoREJhekEwM2tY?=
 =?utf-8?B?NjA2RHB5VVkzTUhHRHIyM0dWQml2TzZZMHNmOUQ3RHUyQktaQWtDcFExTi8w?=
 =?utf-8?B?ZGhuUjB1RjRBSXNqWDQ3SVp6dGwzeUNqb3ZYRmVqdzBPVXBDdWZTc2tJSjdN?=
 =?utf-8?B?dmNqbE8yOGNJeCt3RXNPMkdQUHVqL0xVUXlWeGNhL3BzQXhHYWc4ckxDQzFE?=
 =?utf-8?B?WHhsdmtxcFV3Q1IvblFPNkY4L1QzMkNMOGkvcnBscS9QVVd1OHpvcis2WVdt?=
 =?utf-8?B?WmxUbTdGZVF6MWlIR0xWWms0dWxGczFYY1JaSTdRcHBINkhIU2IwSlVEc1lm?=
 =?utf-8?B?Q2ZRVEZ5MjBMQWdFZXlkUWIxTXJDb0lFTjdoK2ZNOFJTc1g4RmFEOGtJM0gy?=
 =?utf-8?B?MHRSeDdJQkdJV1plTnFJdDVKRWdBOE43bmc2VHl1U0lKU2R5d0ZRWFNPWThM?=
 =?utf-8?B?cUVRMS9iMzlndzdLUUR2TG05dnVoVTA4ekttalFSakpQMC9PUkFXYXJlTHhM?=
 =?utf-8?B?ZW0vWG4rTU1tMGxhQmlVMWwwYmhDU0ZQeXJhNWI3Ni9ESFJPbzUxQm5nTkRF?=
 =?utf-8?B?NWxqbW1MeXgzam9PS0lvSlAzeDZrQlNXemwvYmhOeUlkTVRTbzRSRzdlMzVE?=
 =?utf-8?B?aytuS0ZpYlRvZTk3bGhhbWdOU2lyRmtiOW9nSEZXcFNaRUNkUjF4TU5rZ2lu?=
 =?utf-8?B?QzdJV0k2YXNQQlVYcVNDUGVmTWN6ZVkyZUVPZ2t6NHVGMzdHck5ZQ3hibmI4?=
 =?utf-8?B?OGcvaVJ2djJNaXhQbEhDSTdrcWhEb3JOMkN3dUYvN0p3VzVzR0Z3d3FBTTEr?=
 =?utf-8?B?UjVjMDRkRVduZ1UzWVFVbU9xM2ZBelNvaXcyMjh1NkVVMmJCUStGVzBHUmpv?=
 =?utf-8?B?RWxpRzcyYytvWFBDT1gwaGEybHdVMjcwVmN3N1RyZmtTYzlndy9CMEJsWVFW?=
 =?utf-8?B?UCtLWW9HbDdHZ0xFZDNlcHVOSHhNVWh0UjJ1ZkVCZWZmN3puZWZvd2Z1ekVS?=
 =?utf-8?B?Yzd6ODJaYXg5QndIZDJVbGhpY0pGcDNpQy9aUXV1MHZUVzBpYXJoaDVBWWdB?=
 =?utf-8?B?aU0vd083N21oVFZPUHJtSTRqUC9STG5iT3Q4djNjVTVERFhpNHBtb2U3blU0?=
 =?utf-8?B?U2d4R211bnFBUUczQXBjQ2J0ZjVIa3ZESjRCMDJkdzI4WHl5cUlqOGRFWVl2?=
 =?utf-8?B?Mkg1ZElBR29sQWVhcUY0K0FVakxHeVlSdnZBZERjWWNpeFh2REdNNzAxQXIy?=
 =?utf-8?B?UFBzb3hxT2lsWGU5YWE1b2ZuSEYvUk9ZRENtOGJiMFMwSWlHbHNJVGc0MU1a?=
 =?utf-8?B?TWpDTm5ZWEc3QVVNNmROZGlUeHVoa1FRUDFJaFRuc1R6aEVOOUdpVHkzeDhO?=
 =?utf-8?B?aGw5MDBVYm5nYVhRZlFRd2FEL0ZuRG1xMGFxaUNLMFQzNTZlSHpnYnk0K0hl?=
 =?utf-8?B?cG5OdnFkUldGdlBOcTBndG0wcm45dHN6ajR1bG5lVU9Wa3d0WmJXbW5tenlV?=
 =?utf-8?B?LzBjR1VKNThFMVRkSmlVejhoSmNjOEwrOE5mR2xqRDZUVFRLK3BzR09BZzRx?=
 =?utf-8?B?ekpubEFZZFl4OCs3ZklaMmFFVXIwQnNjTVdYVWtVeWJtWEw0a0hPQmZmVkh1?=
 =?utf-8?B?RlZTMXVJdFlodGlSeEx3ZlRHQWF2SGdtdnBjaDZXNFNzOVZVb1gvTUlhSjVy?=
 =?utf-8?Q?TA9I=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 074d448d-ec74-4121-8fde-08dc3026cfae
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2024 02:10:43.0830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GXEGg0cCzRgYlh9p2maaovXzNgSQYJVYwCo8OyRgK4IK4JjGw6s66J946Uzd6tn/EWxKiBAak5LENKH0T+qIBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9572

SGkgSmFzc2ksDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NiAwLzRdIG1haWxib3g6IGlteDog
c3VwcG9ydCBpLk1YOTUgRUxFL1YyWCBNVQ0KPiANCj4gSGkgUGVuZywNCj4gDQo+IE9uIFNhdCwg
RmViIDE3LCAyMDI0IGF0IDc6MzjigK9QTSBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4gd3Jv
dGU6DQo+ID4NCj4gPiBIaSBKYXNzaQ0KPiA+DQo+ID4gPiBTdWJqZWN0OiBbUEFUQ0ggdjYgMC80
XSBtYWlsYm94OiBpbXg6IHN1cHBvcnQgaS5NWDk1IEVMRS9WMlggTVUNCj4gPiA+DQo+ID4gPiAt
IEFkZCBkdC1iaW5kaW5ncw0KPiA+ID4gLSBpLk1YOTUgRUxFL1YyWCB1c2Ugc2FtZSByZWdpc3Rl
ciBsYXlvdXQgYXMgaS5NWDhVTFAgUzQgTVUsIGJ1dA0KPiA+ID4gICB0aGUgVFIvUlIgbnVtIGlz
IGRpZmZlcmVudC4gVG8gbWFrZSBjb2RlIHJldXNhYmxlIGFuZCBub3QgYWRkIHRvbw0KPiBtdWNo
DQo+ID4gPiAgIG1hY3JvcywgYWRkIHJ1bnRpbWUgZGV0ZWN0IG51bWJlciBvZiBUUiBhbmQgUlIg
YnkgcmVhZGluZyBQQVJfT0ZGDQo+ID4gPiAgIHJlZ2lzdGVycy4NCj4gPiA+IC0gQWRkIGkuTVg5
NSBFTEUvVjJYIE1VIGVudHJ5IGluIGRyaXZlcg0KPiA+DQo+ID4gUGluZy4uDQo+ID4NCj4gZHQg
YmluZGluZ3MgYW5kIGNvbXBhdGlibGVzIGZpcnN0IG5lZWQgdG8gYmUgYWNrZWQgYnkgZHQgbWFp
bnRhaW5lcnMuDQoNClRoZSBiaW5kaW5ncyBoYXMgYmVlbiByZXZpZXdlZCBieSBDb25vciBEb29s
ZXkgd2hvIGxpc3RlZCBhcyBtYWludGFpbmVyOg0KT1BFTiBGSVJNV0FSRSBBTkQgRkxBVFRFTkVE
IERFVklDRSBUUkVFIEJJTkRJTkdTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIA0KTTogICAgICBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3Jn
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIA0KTTogICAgICBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpK2R0
QGxpbmFyby5vcmc+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIA0KTTogICAg
ICBDb25vciBEb29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+DQoNCmh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC8yMDI0MDIwMS1pbXgtbWFpbGJveC12Ni0xLTc2ZjRmMzViNDAzZUBueHAuY29t
Lw0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiB0aGFua3MNCg==

