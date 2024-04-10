Return-Path: <linux-kernel+bounces-138035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACB889EB54
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F0EB283000
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB7C13AA5F;
	Wed, 10 Apr 2024 06:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QHt9Ga4m"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2094.outbound.protection.outlook.com [40.107.22.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C4C46B8B;
	Wed, 10 Apr 2024 06:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712732362; cv=fail; b=M0kVhg+Tle2Huv1dHtpr/3Q85HHtFEw2i+7jf6TiRzHqcLjWOahMWfUYXPN2QBqVuPpW19S8TTBPWPeue1L5MdkAZzm25ZxLNtpmMWl+qkXd3AdXve0E2MuVDrpGpJvlzp3ycordFDQ9trlUIjKBJhLC3k8PCc4rUjmK8TWXyxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712732362; c=relaxed/simple;
	bh=v2Tvt4OelRx8CemKLMLYRS3kM231nlf04WU2ynIyfEQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NJGL2lWGfJwpwl4MxW8yzmn/UHoEKVCdafhkY9bvx0a5wRJgYgS94/mlQhYkp7oHFUGceYYI8YBWYfOAKXGM03jHE+s5jsK/U9dnSvY2+rrH6Aw0rtbjtGNZefDlqluuHHrH/AGfyz25En0N1ReBD63TH/zHOkVunJZ9ILjkaOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QHt9Ga4m; arc=fail smtp.client-ip=40.107.22.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDkGNT4mv/V9NB+tJ4nB8VXGuCJ9km58VK4kbAXb6YJWYi9ujajPILuObZJk7V5REdLGa8JoFADIUk+kGjH21x997fNunqh+So0vb86kVx4KW9F0USMkMJc+2/3nvLHjwg88DfnSkv/i1qAIUhVutDmdkofPGryII532LRGbbLqwU/T3r7QO2jgB/N01qPzjl2q5P9ZHUkfJd0v2gjjGtpJiOHg53WDCoYnrb00HruYtRGNgOZxG5/dz0UMvYjsRhnofnNExlmpzOyhOsmYaN+ndC4BRdCfa6pVnh6uWfATqd+Pom9zKgLKi7muSi3bd0KW5MVEa0Zzei8GDAMDxjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2Tvt4OelRx8CemKLMLYRS3kM231nlf04WU2ynIyfEQ=;
 b=Mye7ph/jmb+qhTUywfE3gEk/XMa1X4jpradKmD4V0agiYO8tG5ojcZPkompVUiT5OqSlQGlHJirTOEi+lWHC9gdMj4uYZwMJxNcp+6erKShFie84gnYh5LrMrqhAvOxa7gx8XFHY8h/JfDVAjB1pDEEr84vXJPyc6IV+15K91PhlVjb/pP6wBfN/OS6Uj/NlHog+vqEhthQAr+o/7sy9ys5AeJJSBAFeJ35tkc6hnxKzLwKt30rm82lqpSL0k9XId/4lsGWFkm7wc7Ux3u1zu5YcrXWPfIqiq5hjU9/QFB12pDrBPCPoe0pIBmYx+h9OjL6qd758vfQ9a+gdB76VDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2Tvt4OelRx8CemKLMLYRS3kM231nlf04WU2ynIyfEQ=;
 b=QHt9Ga4mRaH082+t8+1d7GL7ODYdbHi5v7Vmml1rYrbTrmzKYROiN4B6A0Y5u29W9W9nfwCZZGOkl8N+/AjpPDSxlm6sVYqOPT7BGtOwxhSXlc93+3KBoblYgncDcmUR1K+QVvdqASUE247aUA3G+7mGhbgOXyqCn9CGz8vc+0g=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by PA1PR04MB10324.eurprd04.prod.outlook.com (2603:10a6:102:448::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 06:59:18 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::4662:223:b694:bbc7]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::4662:223:b694:bbc7%6]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 06:59:18 +0000
From: Gaurav Jain <gaurav.jain@nxp.com>
To: Pankaj Gupta <pankaj.gupta@nxp.com>, Horia Geanta <horia.geanta@nxp.com>,
	Varun Sethi <V.Sethi@nxp.com>, 'Herbert Xu' <herbert@gondor.apana.org.au>,
	"'David S . Miller'" <davem@davemloft.net>, Iuliana Prodan
	<iuliana.prodan@nxp.com>
CC: "'linux-crypto@vger.kernel.org'" <linux-crypto@vger.kernel.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, dl-linux-imx
	<linux-imx@nxp.com>
Subject: RE: [PATCH] caam: init-clk based on caam-page0-access
Thread-Topic: [PATCH] caam: init-clk based on caam-page0-access
Thread-Index: AQHZsvA/KLmaPoGzDkGhNWRUjZbKiK++PL0AgA8Zi4CBk9sngIABkYbQ
Date: Wed, 10 Apr 2024 06:59:18 +0000
Message-ID:
 <AM0PR04MB6004E4E4430B7CDEA6FAAF30E7062@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <20230710053418.2406915-1-pankaj.gupta@nxp.com>
 <06bbe95c-118a-0e19-3480-49fc42f3dcb0@nxp.com>
 <DU2PR04MB863006A155869F804AB624439501A@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <AM9PR04MB8604DB56777FE12C7C3BFBFB95072@AM9PR04MB8604.eurprd04.prod.outlook.com>
In-Reply-To:
 <AM9PR04MB8604DB56777FE12C7C3BFBFB95072@AM9PR04MB8604.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|PA1PR04MB10324:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bQa8Hw8T2Ht3TYt+wP4h3iQrDPAS1Xma08VWruc20fIzOkPrgKVg8FBl+nNC6cd/UMG3pvqUdh6Q8D7pnaNY2Hub0kug1bpd2OM/sG67aZ31FwJYFds2LAJpbdcCqaxIZpwKQk4ghgAc1h3eRWOHvxDldhBtURHINUmBRW3q46IDM09Cv4Tf0+0NueAseMziiXGVmT/7wb5pvOnW88umW20zI/W4O7mPKcOR1J7W/IpTTAdu/Uc3uUdu9BQWh6XlWlde+fSeyC6iteaey7Yr8c/+LcdF3dNT/uDDznEugP1jTFdaFsJX5auTbH6+IuyFhjIQ+1J4y2YDd19LVWsu8dbGDhaGLf0khQjPnZuIkIkSxBUpeNrmtexzmzRKAOEjwmEGTjAowpcLm2RyZ5ljJzddnL3o7gwsHBOYIqzTc0dfWnWpFPtT8L8bbLeizz8I+dIQNchCKpuzbGwaCaaLqHGLwwnk3YY1cRhsGbIGM+ZmhhaaNigOZw871YTOkoouZ5l+kiUYL0AN5qTl1BPEMg9Cwl0K/IZRD6x8zfV8HpPTSlYwhiZWSG0Gq/Y96N1R5xpCnt3kfYoLcoUGLKxEalmExEyfV9a0HVeLFQo0/H+NWFQXOZ7omPtRLqA2eb3SED1n/Z4c/uzerP004JYE181bkC4d7cR1XYGjQatOIWE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L0lzZ2U1T0dsSmUzb2J6dDdpWGxsNlJaNVhTV0V1RmhaRUR4NHpZMjQwS1l6?=
 =?utf-8?B?Yk9Ra0YrRURNcFI0SlVhVDdFOVBjbkI3ejNGZmUwQ3hmZ3RkT1YvUjhoMURP?=
 =?utf-8?B?R3U1bUlBdk5TWWRmTFc2L0dlMGl2Zjk4OXkrVEJ4enpocGdGcG1yVG1tSS9H?=
 =?utf-8?B?YWdvbVdJdVdlVk1hZm9sRkFNc0tDZTdtRUFld2NHTVBwdG91UmZjSVpWVFlC?=
 =?utf-8?B?d1hLZHpyOWtxa0hMMGtPMk14QUZtNldWRTBiTXNCeXJDYnNmejhBbDdtelFy?=
 =?utf-8?B?Qi94Y0EyL2M3dzd3ZzVBWE4vMVlURlc4OGRDVmp4V2NOTDJIdVVJRVpqN2t1?=
 =?utf-8?B?aUw5VXFDUzUvSy9xSDdoNWhTbGRGaHpZcjB0b1M0Nm5Pam5ORUUyUXMzM0Fp?=
 =?utf-8?B?dVRSWGMvMnpKY1VmTTZTU3h4K09hcVlyTDZTV3JoMlBjR2RVMmlod1pVTUhK?=
 =?utf-8?B?YnRLbDRwOEd2MndmYkJOdkZtdDAvcGNLK2NHQnczckhQQkRoQTBpeTMxSUhr?=
 =?utf-8?B?cEJJZlFFUG1Ka1BqSFNpSFZCUmtaWlBORmNxa1d6bjczNmlRZ3lCZXJiZlFi?=
 =?utf-8?B?Sm1VT0xEaDNVTldObVNiTkJFK1F1UlhUNmV0L3BKcVQ4Q2VGTEh4cHZxM09h?=
 =?utf-8?B?endJdStHWlBwbngrWFN2MGZnNWVFTGJwRG52dlNNdmYrTlgvNW55dzhjTWFS?=
 =?utf-8?B?ckJ3M2FqQlduaUQxSkNZWlJvVW5McEtSeE5IdHVNdm9zRnlJZDdJdlhQdzFD?=
 =?utf-8?B?c24rdlI3N1pWZmFGU3dpNm4vQ1dVYnNjOEZnQUR0dzZ2ZEM3cVArNkgvMUdJ?=
 =?utf-8?B?UG4xU3F0RThmR2xzMmorYUdYOU1QR0lOa3hBRGc2M1RtT3R6UWY1Ti9ROWxn?=
 =?utf-8?B?bU9wcTFIUGpxLzA3Sm5sVEhZd1BUNHN0Y2pUM3RXY3RvTG9oWS93WWZJWFMw?=
 =?utf-8?B?bFJCNllKVFdiUDcvOW9DT3hiNEZRa1VzeVZkMVVlb01icCtYeE9ONzl3OVJH?=
 =?utf-8?B?SEVZOE85NGdsc2tlc29wdFlsaWlXWktaczU4SWJ0WFdsbHJabWFMeGtIY015?=
 =?utf-8?B?TEpiQ3p5dUIyaUR0ZjMydklwUDZFU3o3S0hNQmlXbkxoTVNJRTVXMXoxNTVk?=
 =?utf-8?B?bkRUMGViNzVNcGdmRWtZZDVpNFJXV2swOEpUczBJNkxyaTN5VDRzbUdiL3FF?=
 =?utf-8?B?WE4zeXlQSHVHcUVBNnFGcDZaRitSMEhtL1VLWTQyRVhGYU8xOVIza0JtcGF2?=
 =?utf-8?B?NEZoTEhSUUtYOHV2K0E1N3loZE1STWJPZURYa2l0b3k0UmVDcGlYc2dXZTNK?=
 =?utf-8?B?eFJnZzdMbEtOdElib0ttNlAycnhBenZHVnpPbnZKajFrRENWMHRSNGg3dTZ2?=
 =?utf-8?B?eHk2RlRxdEdjTXNEb3h5c1dMWG8xaVVOazBzeGFxSmpWTVB1djBkY2EyWUJK?=
 =?utf-8?B?ZDdvMDIrM3VrK0xnTGtXUlo2dnRkSndic0ExdjIzZXBwK3dkdGM2ZjRkT1Bw?=
 =?utf-8?B?bVNkSHZpNVRyUkFkdjY5eDUyS0FxUjBOMGZxTEw0dHpXazN2c01CQUo1aGs0?=
 =?utf-8?B?QWdFYWpWTEl6amRwOUxYYWpGdUUwMXBUQmtGSXZaUlVRdkdlWGhWVkVqZzZH?=
 =?utf-8?B?aDgvR2NrTGFua3gzS21pNkcrOCs2Y0c2Tk5uNkx6UGJTQ2IxODFIYmIwKzBu?=
 =?utf-8?B?NHdHVkhsL0c4NjBmNjhsZ0l3VVp6YnV5TDZ1ZFQ0aUxkYjNoZnJLM25OTTZu?=
 =?utf-8?B?Mlp6UXZkN2lMaTJyRzlvNm1maDRaQjZOWUVKQzV0Y3VEQmwxcVZaVEtBNDdN?=
 =?utf-8?B?dWhKWkxSWmVaVUptc3RDOGJlZHNzSnpRcDMwd2VPWmdPVXA4amR3dExqK0R0?=
 =?utf-8?B?UTRiU0N2bzJIK1Z0TGZ1bERiZ3RrRDFuVmFJeEVDV3JTN1dWMk04N1I3U1Ur?=
 =?utf-8?B?dEQzTlRaajgyN25CWCtZL0ZjZU92WGZZS0ZpeVFYQ0s2d2FDeWt3aStVby96?=
 =?utf-8?B?dG56NGd5TFoybTV1MjlKMXdSR2NFa2dNYndQUWdYUnJnWG85ZWluN2NVL1U1?=
 =?utf-8?B?SVFkNVZYZTZmZlJZNFJ0MUt4cFBxd244WXdQT0k3YTJOWmk5cHN3Zi9JNzBI?=
 =?utf-8?Q?0KcfpL1td1ehSlHbsYOuEva4K?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6ffc6d-c650-4665-e2a2-08dc592bbdc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 06:59:18.1911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GGWG7IEayIedgVO9uuxCI3Kc49tF11r1Ku8B+1oAOanQ3CnfPTEmBwv3ZAj7PfSexg5Z30dO4ZlAqR221EyFUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10324

SGkgUGFua2FqDQoNClBsZWFzZSBjaGVjayB0aGUgYmVsb3cgY29tbWVudHMuDQoNClJlZ2FyZHMN
CkdhdXJhdiBKYWluDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFu
a2FqIEd1cHRhIDxwYW5rYWouZ3VwdGFAbnhwLmNvbT4NCj4gU2VudDogTW9uZGF5LCBKdWx5IDEw
LCAyMDIzIDExOjAzIEFNDQo+IFRvOiBIb3JpYSBHZWFudGEgPGhvcmlhLmdlYW50YUBueHAuY29t
PjsgR2F1cmF2IEphaW4gDQo+IDxnYXVyYXYuamFpbkBueHAuY29tPg0KPiBDYzogUGFua2FqIEd1
cHRhIDxwYW5rYWouZ3VwdGFAbnhwLmNvbT4NCj4gU3ViamVjdDogW1BBVENIXSBjYWFtOiBpbml0
LWNsayBiYXNlZCBvbiBjYWFtLXBhZ2UwLWFjY2Vzcw0KPiANCj4gQ0FBTSBjbG9jayBpbml0aWFs
aXphdGlvbiB0byBiZSBkb25lIGJhc2VkIG9uLCBzb2Mgc3BlY2lmaWMgaW5mbyANCj4gc3RvcmVk
IGluIHN0cnVjdA0KPiBjYWFtX2lteF9kYXRhOg0KPiAtIGNhYW0tcGFnZTAtYWNjZXNzIGZsYWcN
Cj4gLSBudW1fY2xrcw0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGFua2FqIEd1cHRhIDxwYW5rYWou
Z3VwdGFAbnhwLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2NyeXB0by9jYWFtL2N0cmwuYyB8IDI2
ICsrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NyeXB0
by9jYWFtL2N0cmwuYyBiL2RyaXZlcnMvY3J5cHRvL2NhYW0vY3RybC5jIA0KPiBpbmRleA0KPiBm
ZjlkZGJiY2EzNzcuLjc0ZDBiNzU0MWQ1NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jcnlwdG8v
Y2FhbS9jdHJsLmMNCj4gKysrIGIvZHJpdmVycy9jcnlwdG8vY2FhbS9jdHJsLmMNCj4gQEAgLTUx
MSw2ICs1MTEsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBjYWFtX21hdGNo
W10gPSB7ICANCj4gTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgY2FhbV9tYXRjaCk7DQo+IA0KPiAg
c3RydWN0IGNhYW1faW14X2RhdGEgew0KPiArCWJvb2wgcGFnZTBfYWNjZXNzOw0KPiAgCWNvbnN0
IHN0cnVjdCBjbGtfYnVsa19kYXRhICpjbGtzOw0KPiAgCWludCBudW1fY2xrczsNCj4gIH07DQo+
IEBAIC01MjMsNiArNTI0LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBjbGtfYnVsa19kYXRhIGNh
YW1faW14Nl9jbGtzW10gDQo+ID0geyAgfTsNCj4gDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGNh
YW1faW14X2RhdGEgY2FhbV9pbXg2X2RhdGEgPSB7DQo+ICsJLnBhZ2UwX2FjY2VzcyA9IHRydWUs
DQo+ICAJLmNsa3MgPSBjYWFtX2lteDZfY2xrcywNCj4gIAkubnVtX2Nsa3MgPSBBUlJBWV9TSVpF
KGNhYW1faW14Nl9jbGtzKSwgIH07IEBAIC01MzMsNiArNTM1LDcgQEAgDQo+IHN0YXRpYyBjb25z
dCBzdHJ1Y3QgY2xrX2J1bGtfZGF0YSBjYWFtX2lteDdfY2xrc1tdID0geyAgfTsNCj4gDQo+ICBz
dGF0aWMgY29uc3Qgc3RydWN0IGNhYW1faW14X2RhdGEgY2FhbV9pbXg3X2RhdGEgPSB7DQo+ICsJ
LnBhZ2UwX2FjY2VzcyA9IHRydWUsDQo+ICAJLmNsa3MgPSBjYWFtX2lteDdfY2xrcywNCj4gIAku
bnVtX2Nsa3MgPSBBUlJBWV9TSVpFKGNhYW1faW14N19jbGtzKSwgIH07IEBAIC01NDQsNiArNTQ3
LDcgQEAgDQo+IHN0YXRpYyBjb25zdCBzdHJ1Y3QgY2xrX2J1bGtfZGF0YSBjYWFtX2lteDZ1bF9j
bGtzW10gPSB7ICB9Ow0KPiANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgY2FhbV9pbXhfZGF0YSBj
YWFtX2lteDZ1bF9kYXRhID0gew0KPiArCS5wYWdlMF9hY2Nlc3MgPSB0cnVlLA0KPiAgCS5jbGtz
ID0gY2FhbV9pbXg2dWxfY2xrcywNCj4gIAkubnVtX2Nsa3MgPSBBUlJBWV9TSVpFKGNhYW1faW14
NnVsX2Nsa3MpLCAgfTsgQEAgLTU1MywxNSArNTU3LDIzIEBAIA0KPiBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGNsa19idWxrX2RhdGEgY2FhbV92ZjYxMF9jbGtzW10gPSB7ICB9Ow0KPiANCj4gIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgY2FhbV9pbXhfZGF0YSBjYWFtX3ZmNjEwX2RhdGEgPSB7DQo+ICsJLnBh
Z2UwX2FjY2VzcyA9IHRydWUsDQo+ICAJLmNsa3MgPSBjYWFtX3ZmNjEwX2Nsa3MsDQo+ICAJLm51
bV9jbGtzID0gQVJSQVlfU0laRShjYWFtX3ZmNjEwX2Nsa3MpLCAgfTsNCj4gDQo+ICtzdGF0aWMg
Y29uc3Qgc3RydWN0IGNhYW1faW14X2RhdGEgY2FhbV9pbXg4dWxwX2RhdGEgPSB7DQo+ICsJLnBh
Z2UwX2FjY2VzcyA9IGZhbHNlLA0KPiArCS5jbGtzID0gTlVMTCwNCj4gKwkubnVtX2Nsa3MgPSAw
LA0KPiArfTsNCj4gKw0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBzb2NfZGV2aWNlX2F0dHJpYnV0
ZSBjYWFtX2lteF9zb2NfdGFibGVbXSA9IHsNCj4gIAl7IC5zb2NfaWQgPSAiaS5NWDZVTCIsIC5k
YXRhID0gJmNhYW1faW14NnVsX2RhdGEgfSwNCj4gIAl7IC5zb2NfaWQgPSAiaS5NWDYqIiwgIC5k
YXRhID0gJmNhYW1faW14Nl9kYXRhIH0sDQo+ICAJeyAuc29jX2lkID0gImkuTVg3KiIsICAuZGF0
YSA9ICZjYWFtX2lteDdfZGF0YSB9LA0KPiAgCXsgLnNvY19pZCA9ICJpLk1YOE0qIiwgLmRhdGEg
PSAmY2FhbV9pbXg3X2RhdGEgfSwNCj4gKwl7IC5zb2NfaWQgPSAiaS5NWDhVTFAiLCAuZGF0YSA9
ICZjYWFtX2lteDh1bHBfZGF0YSB9LA0KPiAgCXsgLnNvY19pZCA9ICJWRioiLCAgICAgLmRhdGEg
PSAmY2FhbV92ZjYxMF9kYXRhIH0sDQo+ICAJeyAuZmFtaWx5ID0gIkZyZWVzY2FsZSBpLk1YIiB9
LA0KPiAgCXsgLyogc2VudGluZWwgKi8gfQ0KPiBAQCAtNzU2LDYgKzc2OCw3IEBAIHN0YXRpYyBp
bnQgY2FhbV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCWludCBwZ19z
aXplOw0KPiAgCWludCBCTE9DS19PRkZTRVQgPSAwOw0KPiAgCWJvb2wgcmVnX2FjY2VzcyA9IHRy
dWU7DQo+ICsJY29uc3Qgc3RydWN0IGNhYW1faW14X2RhdGEgKmlteF9zb2NfZGF0YTsNCj4gDQo+
ICAJY3RybHByaXYgPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwgc2l6ZW9mKCpjdHJscHJpdiks
IEdGUF9LRVJORUwpOw0KPiAgCWlmICghY3RybHByaXYpDQo+IEBAIC03NzIsNiArNzg1LDE1IEBA
IHN0YXRpYyBpbnQgY2FhbV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAg
CWNhYW1faW14ID0gKGJvb2wpaW14X3NvY19tYXRjaDsNCj4gDQo+ICAJaWYgKGlteF9zb2NfbWF0
Y2gpIHsNCj4gKwkJaWYgKGlteF9zb2NfbWF0Y2gtPmRhdGEpIHsNCj4gKwkJCWlteF9zb2NfZGF0
YSA9IGlteF9zb2NfbWF0Y2gtPmRhdGE7DQo+ICsJCQlyZWdfYWNjZXNzID0gaW14X3NvY19kYXRh
LT5wYWdlMF9hY2Nlc3M7DQo+ICsJCQkvKg0KPiArCQkJICogQ0FBTSBjbG9ja3MgY2Fubm90IGJl
IGNvbnRyb2xsZWQgZnJvbSBrZXJuZWwuDQo+ICsJCQkgKi8NCj4gKwkJCWlmICghaW14X3NvY19k
YXRhLT5udW1fY2xrcykNCj4gKwkJCQlnb3RvIGlvbWFwX2N0cmw7DQoNCk9QVEVFIGVuYWJsZW1l
bnQgY2hlY2sgaXMgaWdub3JlZCBiZWNhdXNlIG9mIHRoaXMgZ290byBzdGF0ZW1lbnQuDQpSZWdh
cmRzDQpHYXVyYXYgSmFpbg0KDQo+ICsJCX0NCj4gIAkJLyoNCj4gIAkJICogVW50aWwgTGF5ZXJz
Y2FwZSBhbmQgaS5NWCBPUC1URUUgZ2V0IGluIHN5bmMsDQo+ICAJCSAqIG9ubHkgaS5NWCBPUC1U
RUUgdXNlIGNhc2VzIGRpc2FsbG93IGFjY2VzcyB0byBAQCAtNzgxLDcNCj4gKzgwMyw3IEBAIHN0
YXRpYyBpbnQgY2FhbV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCQlj
dHJscHJpdi0+b3B0ZWVfZW4gPSAhIW5wOw0KPiAgCQlvZl9ub2RlX3B1dChucCk7DQo+IA0KPiAt
CQlyZWdfYWNjZXNzID0gIWN0cmxwcml2LT5vcHRlZV9lbjsNCj4gKwkJcmVnX2FjY2VzcyA9IHJl
Z19hY2Nlc3MgJiYgIWN0cmxwcml2LT5vcHRlZV9lbjsNCj4gDQo+ICAJCWlmICghaW14X3NvY19t
YXRjaC0+ZGF0YSkgew0KPiAgCQkJZGV2X2VycihkZXYsICJObyBjbG9jayBkYXRhIHByb3ZpZGVk
IGZvciBpLk1YIFNvQyIpOyBAQCAtNzkzLDcgDQo+ICs4MTUsNyBAQCBzdGF0aWMgaW50IGNhYW1f
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAkJCXJldHVybiByZXQ7DQo+
ICAJfQ0KPiANCj4gLQ0KPiAraW9tYXBfY3RybDoNCj4gIAkvKiBHZXQgY29uZmlndXJhdGlvbiBw
cm9wZXJ0aWVzIGZyb20gZGV2aWNlIHRyZWUgKi8NCj4gIAkvKiBGaXJzdCwgZ2V0IHJlZ2lzdGVy
IHBhZ2UgKi8NCj4gIAljdHJsID0gZGV2bV9vZl9pb21hcChkZXYsIG5wcm9wLCAwLCBOVUxMKTsN
Cj4gLS0NCj4gMi4zNC4xDQo=

