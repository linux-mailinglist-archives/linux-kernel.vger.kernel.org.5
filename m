Return-Path: <linux-kernel+bounces-136332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8997489D2C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BCDB1C22622
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E4F77620;
	Tue,  9 Apr 2024 07:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K752pzON"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2135.outbound.protection.outlook.com [40.107.241.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25A242046;
	Tue,  9 Apr 2024 07:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712646056; cv=fail; b=Rcgw4GYyvX8erFPsIGrlYP/LFlR2/2bfjuFJR5fZMZy8Pk+M61d3XI/jQ8eL54LuFEAMII2+quW3b+GkSCDkJgV5ev+OX3CQN/KZHxT+3ZWDLcQu+WQgy2y+Dk8FGivhjjxCU7bpu5lgSp9GedMP+jseNz4JcpfkYb6nRCULpbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712646056; c=relaxed/simple;
	bh=9iO+F5i/k6WqdJQIavuzDp90F5b7hLxdfZaORQVfALM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=doEVen2EzHwPYY3r4HHTYOo5Ha2NzqatqV3Bx0IoVIBX6csFCV66A6JZY3K5XXmrI7kEoRcSq+EQrSP1Ck7t6oATo/Bs01Hqcwla6nhFncfVa5VDu52+N6YYm5Js8Hen2x/nLy6p55sZjT3AVCLJzOIO4NwZnMAbUUEK69sRU+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=K752pzON; arc=fail smtp.client-ip=40.107.241.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhTYmFMxiZuX8rIf1Dc7ZL4rSnQgdmqWyEZ8w8sahg9SV1IAzD/y8whOVUdkqxE02Csc1uU+Zz7ENXPNZ5JsEEMurW4na1eBpwVTIPW4lg3GO3/p41BsaJskEp9dvoOOQzJ1sN85bWM2fC/WcIBtsf3x6IbmqYy/pVQIixPIJkXzI2ogvvADMEgaJf+INThmPnUU8Iljw2Cwk0dSiF2VMWJ4KEx6SXv+lRK8d4YLdGyiMKqBb9V07eaBmuvgbywcDSlDZQWvGcILnHIJAu2mfSA583lCEvOdaXyJX8efeKEQtc8/8wuT3/enQwcld+08R5ruevtT7taMVQ415Z4okA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iO+F5i/k6WqdJQIavuzDp90F5b7hLxdfZaORQVfALM=;
 b=BrliFDVtGfFVdsKBW9xEnEw4hc4quAIwPsZPH3xquKQ1pCLoNBtaVD1k0E+nhA+XHw2kmdxjbp5ljnVUnFzXKlStDUSul5cWNT79gtPRonhmjcEkDHafo4A1FMYcs3r0gdUh0FKOmdBG5+Otg/csRRuCsU0NuX+OTxTD8azYIMcJ6JEpAqk/Rvd24L5pylgNgBica2zjB3PWxXenmgumYEMLzIEPc9D0v8Bqunti8sdqUJVDsf75fHEPiNJmJZvohMgJoUJ1uh4PhcwpOU7SZhj0HY9dYUcYzti8N9utBuCGbGDQOdyMTR3Rwl+Haa7A3khQjPlpnO0Dj36gepnEqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9iO+F5i/k6WqdJQIavuzDp90F5b7hLxdfZaORQVfALM=;
 b=K752pzON/jl1VokZZKwnydxlzXks8AdomxxDZ0VNaTFB9OfL3frxU5sLMh8VT7o4ACwqZFJ0MnVHeNkKsrGsoveKAziNwl8RR5Z98N2W3uYB9oWTguwNL7oA4WMlCabg4XeS2anxw6v4ooVfqch0g2ROQpYDqG0u4i4uitO2Cek=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AM8PR04MB7762.eurprd04.prod.outlook.com (2603:10a6:20b:241::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 07:00:51 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4%2]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 07:00:51 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Horia Geanta <horia.geanta@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>,
	Varun Sethi <V.Sethi@nxp.com>, 'Herbert Xu' <herbert@gondor.apana.org.au>,
	"'David S . Miller'" <davem@davemloft.net>, Iuliana Prodan
	<iuliana.prodan@nxp.com>
CC: "'linux-crypto@vger.kernel.org'" <linux-crypto@vger.kernel.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, dl-linux-imx
	<linux-imx@nxp.com>
Subject: RE: [PATCH] caam: init-clk based on caam-page0-access
Thread-Topic: [PATCH] caam: init-clk based on caam-page0-access
Thread-Index: AQHZsvA+WWrJieH4YkOWcmdVA0ACEa++PL0AgADTpXCBoiCZwA==
Date: Tue, 9 Apr 2024 07:00:51 +0000
Message-ID:
 <AM9PR04MB8604DB56777FE12C7C3BFBFB95072@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20230710053418.2406915-1-pankaj.gupta@nxp.com>
 <06bbe95c-118a-0e19-3480-49fc42f3dcb0@nxp.com>
 <DU2PR04MB863006A155869F804AB624439501A@DU2PR04MB8630.eurprd04.prod.outlook.com>
In-Reply-To:
 <DU2PR04MB863006A155869F804AB624439501A@DU2PR04MB8630.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|AM8PR04MB7762:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZwO1oC8UrTvojP8Ox3MKnfsC8W2ttrfk05ReyZiq8KHTTWu9T4crJdM5NCrciwzrggH73SC8DLEmUBWzMLd4/p9Dz5ccSwtIRG5WbSQNf1ULSMKxN5EW7xdga2uhQ2OgvJ7H67ruzZsqzWDCEHKBJmXXJZPB0jyRC2C17CBMM7hknxYdALDxjoO48KjNRoPUK8YTrNCUvotOZxjSpjAte/GCUuh5SoAO8tARd/rLxT/GUhhs5xTrfeDdWUc4x9o5QkOyj7WsFQzogufdwJALzQUPNMvMmRmRuOO9905i1Oku1y7Ed4B6oH7T+vYwu3wZRq1Vd7vutlrUNaB+G6tk64nhDob79DJgmQZFnFP7IQg85dr6RmoJc+e6iPYJHPKgok997HidXKKu/UA6pieRcMoN340Okdiu2fl87sNpZOmSKlSvtWXeY253JBDLDWE9SgRuyZh8ho2Us2q5sQlLkPzEMOZMQCifKLMGbxiw8R9uyX0hTFPczD8NmBPsSNjrCHppc2UjLj+DYQb9hpUPvs6mnZhEwpVlEf+jkWbbwg2SWkeZT5n7Lx+iOv68F3LwPfIOJX1ewVo8TxJ0xU6Ks48IX8e2CtHz489jLsXfh1CoXSwn2bs49myU23jI0FEGPjhzqkqWAMaLEX55yRMlg2hlBvirEoANGP8ENxWClEE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dC9XMGppVlA2Z3I2YklqQ01aeVRqSU5VTmlWMjd1WVBEZEJxNHhCZ1JUSXR4?=
 =?utf-8?B?MHBwbkh0UWl4RFFrK2hQWTU5MFB1dXRNMFA1NnAzVjlZUEYxempWVDZhZm9o?=
 =?utf-8?B?R0R6OEZIMHc5aDhwRlk0akFuQjV5YlAvSXhxelp4dkFJMHo3M2N3UG1CckVy?=
 =?utf-8?B?eHIwWjE4TU1KMncyNWNlQUN6c0VhbUVyZm9pR1RRSXZ5MVlMMHB1R2ZEd2t6?=
 =?utf-8?B?b0JOYUhQcTE1ZFgvWUlHbVNkSE9mMzk0SnRSb0lqNXZJZ0ZlR2xsOVBEbHBq?=
 =?utf-8?B?VHc3Vnc4ZlNFUVlDMzlraFo0N1BYSVk0RVJmSkVhV3dSS1lsKzduYU5wWTRt?=
 =?utf-8?B?QVhXenlvVmo2VlM2UnZJamduWDdJSThkNytFczdldUllUGQ4dTZBVjNBYnYr?=
 =?utf-8?B?UHplRmhQZktualZNeUw0VlI5Z3ZjOTFCc3J6bXY2MXAwa1ZzT1lkdlNqZHBI?=
 =?utf-8?B?L013d1pTaVBLTFRMa0FIOVdSUytPa1AxVkVzSDQySlQ0M0ZSSytNek5ZTVJ5?=
 =?utf-8?B?UGJFSEkyMU9oRm1xN2syejdNbGJVRDRkdXU2Q2I2U0FlN3F2cGZINFNpMEY2?=
 =?utf-8?B?cjVPaCtzdzFFMHByTk14S3dMdVVTV1o4SjBIbEtKQ1oxVEFuckdnSEcwR1Vz?=
 =?utf-8?B?a0c3SHA5UGFOcjdGY2RPckVsMEE0aGF0K3VLZjNWbUJjam9ZN01HbHhZUUpm?=
 =?utf-8?B?UGVibzFQN1FjTy92QWh1SEl4UlA4dDJFUXVuYnNzZGlrNHcwVWREOHZRUTRJ?=
 =?utf-8?B?MENJa1Ftb0ZJaWcraXdpZFRzTHJIbnUvdnVGWHl0US9KbkFlSWJNd2laSmNj?=
 =?utf-8?B?eEwzb0ZCSWZBaEZWTnlMYnBqRlBEdHZZSkxqNGhUd0o3UnV1QXBuSks2V1k3?=
 =?utf-8?B?Q0YvYStOSkhKcVhKQ3BwczdNNWRIT0paeGo0RzlhZG4yK1RrcGljbE5CRW5W?=
 =?utf-8?B?RzFoSUJmd3lpNVR1aUlXQmx6c3VXWVBmRExsbTRIMU5LVGpXVU4vbUVBZlh1?=
 =?utf-8?B?YTZWVUE4MmRkbjBiWU9tRUVON2lyeGppM3RsYzliMitxazhScmVOT1N4Smw5?=
 =?utf-8?B?NWhCNlRDY2RFWktNOC94cmdobFJCN01qU0I3WkNhbzFROTUzMTRtbTdST3lw?=
 =?utf-8?B?Q0hxUkp2R1ord25TTnVsZyttUHlQT3hNaVBkeHZKR0dhZVJyd2M2TjJLZFI5?=
 =?utf-8?B?Z3ArbCtla3FrWU5CKzBET2hCY1MrcnF6citBeEUwWmQyQUxpME44cGZUUm5k?=
 =?utf-8?B?MUZTM3pZbjZqblNidjR5ODZKVVhab1JpV3daV2wwMFZ4QmpUSGx2Q05lbzhT?=
 =?utf-8?B?czhzcmZMalJEVEw4a0s0dTJ1c3AzS1lpN1ZPQ0lwRDE1NXhaUldDNWxpeUlL?=
 =?utf-8?B?cTIvcHJDeGk4NUtFa1c3bG5HOE1BbTREcktMS0xOSmF5K0wrTnpVWDRZTSt6?=
 =?utf-8?B?NjRsSzJqRnBCMzFyNDZVcXJnYXJDcUFSNm91eHdZZVh2S0p0d2kyRGF1N2Rm?=
 =?utf-8?B?ZTU2ZytqT1o3YUVzcnBGemVYQ3p2ckI0K003eVl4VTRBUGtySHp5KzBmaG4z?=
 =?utf-8?B?dUxxdDZ5YmdueXFxcGczWjR2ckxCWG96VEFZRVplWlZ2TkxoZzRYR01mdEVJ?=
 =?utf-8?B?Q1A0dGJ1aWpjc2VzVnFSamZtbG1hemFwSVJiZFpBdWVlczZGTC9PTG5OTjla?=
 =?utf-8?B?OUoxQXVreEY4YjBsRUJPR1hUMk9aS2NhRzc2QjhFZWljQStRYUd2L0FqYVlU?=
 =?utf-8?B?aWFzUHhSYVFIb3RLL0p0LzRyanQxS1RDY21RWWRWSEV5dXMwdzF1YWhYU0Z6?=
 =?utf-8?B?R004Y3VaRmZzcWRBRDIzbUxBYWJ6MW5NRVVIWEVzN0lJVUhPUmJKUTI5bkp0?=
 =?utf-8?B?UWxzazUzUW5FREU2ME5iVk5wWktsVU9jaXlrdy9UTWVFTzF6VlcyNFhyUWx3?=
 =?utf-8?B?WU5RTURNbmRGNHhQeHNIdW1SOFBQMzZXNW8xSEJveEVQUklISzZkSVRUSFJK?=
 =?utf-8?B?dFg2UElGTHJheTRuc2cwVmlwMG1ES0lEUmRoUk9naExQbFZuSDllZ0MwUXBI?=
 =?utf-8?B?a3pjN1NjMFkvdWYrR1NiZW5YWVB1Q2VuVkJBL1lTaDV5dHg1UGkzZDkzQlZE?=
 =?utf-8?Q?81U812jVrnyZlNhEWMSSexdBx?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b334ca6-e2d3-4fb9-9e74-08dc5862cae9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 07:00:51.4099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pdQpyjl2a6UsI93q5Rsl88QhQGP7GqnSnuxOdZizEpWxaMm4d5aI7tihTkRatQ2FIAOzlEoYO27vOIqD44eivw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7762

SGkgSG9yaWEvR2F1cmF2LA0KDQpBcmUgdGhlcmUgYW55IGZ1cnRoZXIgY29tbWVudHM/IFBsZWFz
ZSBzaGFyZS4NCg0KUmVnYXJkcw0KUGFua2FqDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IFBhbmthaiBHdXB0YQ0KPiBTZW50OiBUaHVyc2RheSwgSnVseSAyNywgMjAyMyAx
OjE0IFBNDQo+IFRvOiBIb3JpYSBHZWFudGEgPGhvcmlhLmdlYW50YUBueHAuY29tPjsgR2F1cmF2
IEphaW4NCj4gPGdhdXJhdi5qYWluQG54cC5jb20+OyBWYXJ1biBTZXRoaSA8Vi5TZXRoaUBueHAu
Y29tPjsgSGVyYmVydCBYdQ0KPiA8aGVyYmVydEBnb25kb3IuYXBhbmEub3JnLmF1PjsgRGF2aWQg
UyAuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47DQo+IEl1bGlhbmEgUHJvZGFuIDxpdWxp
YW5hLnByb2RhbkBueHAuY29tPg0KPiBDYzogbGludXgtY3J5cHRvQHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14DQo+IDxsaW51eC1pbXhA
bnhwLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRDSF0gY2FhbTogaW5pdC1jbGsgYmFzZWQgb24g
Y2FhbS1wYWdlMC1hY2Nlc3MNCj4gDQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPiA+IEZyb206IEhvcmlhIEdlYW50YSA8aG9yaWEuZ2VhbnRhQG54cC5jb20+DQo+ID4g
U2VudDogTW9uZGF5LCBKdWx5IDE3LCAyMDIzIDEwOjM5IFBNDQo+ID4gVG86IFBhbmthaiBHdXB0
YSA8cGFua2FqLmd1cHRhQG54cC5jb20+OyBHYXVyYXYgSmFpbg0KPiA+IDxnYXVyYXYuamFpbkBu
eHAuY29tPjsgVmFydW4gU2V0aGkgPFYuU2V0aGlAbnhwLmNvbT47IEhlcmJlcnQgWHUNCj4gPiA8
aGVyYmVydEBnb25kb3IuYXBhbmEub3JnLmF1PjsgRGF2aWQgUyAuIE1pbGxlciA8ZGF2ZW1AZGF2
ZW1sb2Z0Lm5ldD47DQo+ID4gSXVsaWFuYSBQcm9kYW4gPGl1bGlhbmEucHJvZGFuQG54cC5jb20+
DQo+ID4gQ2M6IGxpbnV4LWNyeXB0b0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+ID4gZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gPiBT
dWJqZWN0OiBSZTogW1BBVENIXSBjYWFtOiBpbml0LWNsayBiYXNlZCBvbiBjYWFtLXBhZ2UwLWFj
Y2Vzcw0KPiA+DQo+ID4gT24gNy8xMC8yMDIzIDg6MzQgQU0sIFBhbmthaiBHdXB0YSB3cm90ZToN
Cj4gPiA+IENBQU0gY2xvY2sgaW5pdGlhbGl6YXRpb24gdG8gYmUgZG9uZSBiYXNlZCBvbiwgc29j
IHNwZWNpZmljIGluZm8NCj4gPiA+IHN0b3JlZCBpbiBzdHJ1Y3QgY2FhbV9pbXhfZGF0YToNCj4g
PiA+IC0gY2FhbS1wYWdlMC1hY2Nlc3MgZmxhZw0KPiA+ID4gLSBudW1fY2xrcw0KPiA+ID4NCj4g
PiBBbnkgc3BlY2lmaWMgcmVhc29uIGZvciBkZXZpYXRpbmcgZnJvbSBkb3duc3RyZWFtIGltcGxl
bWVudGF0aW9uDQo+ID4gKGJhc2VkIG9uIERUKT8NCj4gDQo+IEltcGxlbWVudGluZyBiYXNlZCBv
biBEVCB3aWxsIGxlYWQgdG8gbXVsdGlwbGUgRFQgZW50cmllcyBpbiB0aGUgc2FtZSBjb2RlDQo+
IHNlY3Rpb246DQo+IC0gb25lIGVudHJ5IGZvciBpbXg4dWxwKGZzbCxpbXg4dWxwLWVsZSkNCj4g
LSB0aGVuIGZvciBpbXg4ZHhsKGZzbCxpbXgtc2N1KQ0KPiAtIHRoZW4gZm9yIGlteDkzIChmc2ws
aW14OTMtZWxlKQ0KPiAtIFNpbWlsYXIgZW50cmllcyBmb3IgZnV0dXJlIFNvQyBhcyB3ZWxsLg0K
PiANCj4gSGVuY2UsIGZvbGxvd2VkIHRoaXMgYXBwcm9hY2guDQo+IA0KPiA+IGh0dHBzOi8vZ2l0
aHViLmNvbS9ueHAtaW14L2xpbnV4LWlteC9ibG9iL2xmLTYuMS4xLQ0KPiA+IDEuMC4xL2RyaXZl
cnMvY3J5cHRvL2NhYW0vY3RybC5jI0w5MTENCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBIb3JpYQ0K
DQo=

