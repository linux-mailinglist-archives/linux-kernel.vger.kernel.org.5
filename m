Return-Path: <linux-kernel+bounces-44003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747D9841C10
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6926A1C22C77
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C4A38F82;
	Tue, 30 Jan 2024 06:41:16 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2088.outbound.protection.partner.outlook.cn [139.219.146.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EECE381AB;
	Tue, 30 Jan 2024 06:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706596876; cv=fail; b=HRW32A+F9AuZLy4NWBRoy97ID2OofkLwgIVeWqZJFjEJ51CFqIKWF6M4CTbKvSf/tzMmZuDGmwuLdeYQrX1BgA4DJwySSv6afS9mEIyOH47USxobjQBCMcc2RCTzs4iva/ROxqffBpgTXSn2DqyuGGv4LHmZkCu+me9r8GcytEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706596876; c=relaxed/simple;
	bh=s0f00FS5CtF9MMVfCbEOOf/9H9GB2ynEjxAQD0vNIuI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yt91PWACp0EUvpfkUEYHxJCpLkUtalboNayWK59A5vG0B2TAUL+ST2VfnoKlyGaFPMZutusJC+uVF812MFkMvvIIYWGHmE7+qBByc7o2Qk8jLDY3qoFaIXjjNeieZBY9M3zqh7Q1kazevTEHLNZeg8mkbzcAsx49iL4TjPsvfrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+s06u/lHez4+kKV/VsGLH4sZyTMftBkPwsN2zA4MP7Xh5EVYYRacB2ped+enzxijBB3yltmx+Ca+wiRZTGfEzge2aKNK9nF1mq05vpJEupdR63N3h82c4P7pNIIEU1sL/XqfLE7XrOA/Khfd9he6r/zCSXcGSWqiP2A1rD7GzqE0hqGIU76yxot/4cEQZ3PwmjosUKIP4Ezb2lYb0KCZHnS7Lhsn2FmlC/DwqYPhgO1VREWbphEmruxJdF0GBuxocBuuUie5eF0Tbv2GFR+0vywexOCPOxo7xvtN7OUuLqEEnFWPCwz1BkhFKMtieJm6r2Wu+AhKoltI5zoT+q9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0f00FS5CtF9MMVfCbEOOf/9H9GB2ynEjxAQD0vNIuI=;
 b=g4DoFXWqNR+63ct9OdRagO7eEMU2xQVnXPnpJlhPiqPG4csjuRJ3KTG8RHWcy3gIldYK2vUBmBY6Rvgh9emAGIZF9pIe5S52IsfqBnmxTJvqGmjKafHEqNRag2qxMrlUtCkvsTYLwKOIv+d3cg30iwYGMLzAXiyAQer+mtRcZWdxEwMzscKu2pdVNDFy75QaqE5/I+Zj/al1mIw6JLXFY1Kg16ZXyACAGVhbt1Kj0rop6c9AGyaqwZGbFrdxrlvKvIpkC7tVw+DmwibMpt+7yPSJ+Dqfq3PeatA/j2ONNkhNrewarDDgtdcqDbcH1264UfxMoaWuOcStHhEXw7cgbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::8) by ZQ0PR01MB1221.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 06:41:03 +0000
Received: from ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::380f:84dd:fec:a39]) by ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
 ([fe80::380f:84dd:fec:a39%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 06:41:03 +0000
From: William Qiu <william.qiu@starfivetech.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Emil Renner Berthing
	<kernel@esmil.dk>, Rob Herring <robh+dt@kernel.org>, Wolfgang Grandegger
	<wg@grandegger.com>, Philipp Zabel <p.zabel@pengutronix.de>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Subject: RE: RE: [PATCH v1 0/4] CAST Controller Area Network driver support
Thread-Topic: RE: [PATCH v1 0/4] CAST Controller Area Network driver support
Thread-Index: AQHaUmEJuS1ELIQV10Sl2BziVX79G7DwbOcAgAAAc/CAADtDgIABQPgg
Date: Tue, 30 Jan 2024 06:41:03 +0000
Message-ID:
 <ZQ0PR01MB125322A22CCE431C7197E9069F7DA@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
References: <20240129031239.17037-1-william.qiu@starfivetech.com>
 <20240129-gills-excitable-01213b5b28eb-mkl@pengutronix.de>
 <ZQ0PR01MB1253323CA8F8173D98BDD3949F7EA@ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn>
 <20240129-boneless-herbicide-24966319a1e4-mkl@pengutronix.de>
In-Reply-To: <20240129-boneless-herbicide-24966319a1e4-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1253:EE_|ZQ0PR01MB1221:EE_
x-ms-office365-filtering-correlation-id: 23ee2bfc-c434-46cf-bbf8-08dc215e6dd6
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 c1oLDcrTXEO5Yi8Aets/v1K3iiSLnRQf+p75R1OsJWbqSCpoiuPbXwquPBSvZNpdN3SWY0WHisWUPMNw40zpamVxbc58G5UZ+EDGFn6LIVh7rzumY3145XkLg+44lSTB6ZGZ78H8+hxyWuCNdq6aEAMUnMykze0pucQS7PJODyUa51OndkHQxj0WpdodZG2IyMu24zQ9Is1d5CEOtkUpRGheYfBlmKyD7/zoBgjcxLyckYo58lW1V1fFs0E4GUXesTaVzEfInQTYtv7J3JdFAwcK58DfsQnEEPJqBR3/uAN5SuBnYPVoVa0UlvWsdyvZjGe7nVvxYfeFrF9KfMKEGJ80grhaaPvVul5v74Vg/HfFAkco8NnE4KayvF8NgZfncqN+weTCYI/3M8PEJ1GBpQemW1q2NjPY3Z6HXJNvmuhgCnKX1q4FXO/MWX2Banuo8h+hgO5vdArLX2cIpHnDFlBYdQYAKzv/Y4/t1bM3BhzxaOIPanoRxKiU8AB8HaNYw1V5y99SgRp1+uOfcY/qKR57Q2tufxHGxudolWOalGhBF/FJZ7l4SXQMeXhifhEK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(39830400003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(41320700001)(83380400001)(26005)(9686003)(38100700002)(122000001)(8676002)(44832011)(5660300002)(4326008)(8936002)(7416002)(508600001)(2906002)(7696005)(966005)(53546011)(66476007)(66556008)(64756008)(76116006)(66946007)(54906003)(71200400001)(41300700001)(66446008)(6916009)(40180700001)(38070700009)(40160700002)(86362001)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1p0SC9BWEQrNTR2UStLRkFNUDRyaS9WRDlCWVFSUDNzS21WVTAxcnhySTBM?=
 =?utf-8?B?MlRwQi8vRFc4SWxLSFBZaW1MRG1Gck9SWjBNODAzWFJDU0twNG5GSGdsSFRo?=
 =?utf-8?B?MzZYVHJtemE4L1piUW5qaG5RQURwZld6TVJWWnlReTVCQXl6VmdUNkROWktm?=
 =?utf-8?B?Q3REaDV5Zk9leDZxM0JEMEo5cE5OVFJUWEg0dEtTT0NoWnJrb0R2Y2hDclR2?=
 =?utf-8?B?NEVKNDk4MjBkMWJTRmVxOU9FL29GbUVZNi9NOTdXUUZnNmJubXlZaE1rejE3?=
 =?utf-8?B?cmEyL3VkY29TRGdVVnBZUlNrd2dNN2xWUjNNeWlCQjRMRFd4WERPTG1LRGJ3?=
 =?utf-8?B?dkI2Mmd2TjJQV0FLQklOUE9xdTBSN1hmaGRnYW5zOGtRT200c1VneGxXT3NY?=
 =?utf-8?B?M3h4Tml3aEZBdGpyYnB0YmRyU2RHb25yUzB5K1RmZUYyZFlJYjlCbXlwQTZ2?=
 =?utf-8?B?eDZsSEFoOEd0ZGI1SjdONXF5ZnNxODZvM1o4d3RycXlnK2NHTStJN0pLTjla?=
 =?utf-8?B?d1VsRUVOZEhVa3BsY09ZcEs4ZDIyVmhwandHTDdrakZRNHZsR2IwT1JQN0tT?=
 =?utf-8?B?N2VSREFwMGFheVJoYStlbUhtdGdueFVTckZEZEU2ZWF4ZnZTZ0drQk1JWkdS?=
 =?utf-8?B?VnlqQnNVUzZ6QmpRUFVRc0U4M2NVdjBLWVBlL0dGcUhhTTZ4WFc1YlBQK05J?=
 =?utf-8?B?cUlrcDY3aDVQVDZLOFNEbXpONlBrRG0xajhWWHkzUktmSUdhT1JqNmdBdTd1?=
 =?utf-8?B?T2xnRmZMQ1BkRTRESGdzTGpQZ2Nsdmt0dWhhWHNWbnYrSVdmL3p6RWZYL1Ju?=
 =?utf-8?B?ekJrUjlNaG1Qd0dLY09ET0JOM0dxYTJ5Ymc0cjg3KzExeFZiaHZ2bjVxL3B0?=
 =?utf-8?B?a1JrMDA0WTRLOGdlRzd0cHdFYlVLV0J6TXAvYmcyMVRlK2Q1a08zWmJBRnFU?=
 =?utf-8?B?UmduZ1lTeXRHN0dyTUV5dXpFVGlFcjJZZXBwRGJwUVVkaTdUbDhMZlV5VmM5?=
 =?utf-8?B?SXpEUWszaFJtL1A5eGVYaUV3YldOaTVKVU9DeVR3UTBzUysyRjAvdmR3WTht?=
 =?utf-8?B?aFZleDJCejhMWkFxSk1veFNSaGxwbVVzcFkyeGZuaHFZWlo1b09VNXBtZXpu?=
 =?utf-8?B?SFN4R2FYZ0h2NHhnZUFtL1RrM0hsKy8wZ0M1blE4K1NIaE9SV0d2S01vSHdR?=
 =?utf-8?B?c0cvQktCSEorbnJHcm04anhOcjRhL2c2NlJKWWwvajA4OENHQXgxdXk5VzhE?=
 =?utf-8?B?ODM0K3Y0T0FqUUUrY3RwdUlNMkNZT1NTYzVRRGgxNDd2OThmUmc3V3ZINXh1?=
 =?utf-8?B?dENYZDdMV1pKb1dCem1Tbm15MlpwUFMxclZpUU83b0l4dkIzYTY1NXhJVExL?=
 =?utf-8?B?V0cwaEU3d2V6c2Nqc1E1VW9XUzRXWkJrQ0MyVmgzMThCYS9DaGh1dStVb2U4?=
 =?utf-8?B?YUNyVUtKWm5YOHRQR3g2R3dLOWFiTGFGYThwZitaTW9LdCtuUytjMzdzSmJl?=
 =?utf-8?B?b1o5Q0g1eVpLZUY4RkhyZXNLY1pqdFRjaUlyVURVM2Fsc2JkUjM1cFN6VENC?=
 =?utf-8?B?aTIyVHRkSGlkTlNNTTRBdmRRTTR2RXhPZG9hL2ZEWlpaVVpLMC8vZ2VMazc0?=
 =?utf-8?B?cnpJNUhPcEx1d1JMdzN2bXNEN1NhdCtHci9tUFAyQjgyNytZSEJ3OUdndEN2?=
 =?utf-8?B?QjVPNTVjOCtVM0xNV1MreVhZMnhsQ2UxVlpsbEF6MTRZdmM4cTNNWU1xQ1Bs?=
 =?utf-8?B?N0Z6VFNvYWZDNGhJZ1d5d0pRaWRWV2RKeVBDcklPaGhyb056N2x6d3VqSHNL?=
 =?utf-8?B?OXZhcTRlVEJ2RmxIdHozOElPZ3QyOS95VWtTSzM3QVZtZU16OUgwVTlWcDYw?=
 =?utf-8?B?TTlJdWhqeG5rQ0w1UWZCOVRxck5Jem9MaVFoT3kxWTY3YUIxT05WUVRQc3hx?=
 =?utf-8?B?UFJrU3B6ampFRU81T0ZNZnQ3RzRlbXh2ckZzNVpPbi9VMlRaYXBXL20xQW9I?=
 =?utf-8?B?SFh0K1JwVmtrRG56WUNTdmgveGlPMnp1czhKWmNIcDBCNURheHpsSzQ3M1Nq?=
 =?utf-8?B?U1hmeDVGTExRcCs4V00xRlVHRktWTjlwWmZxcmZQTDI5MVZaZ0tKdER4VHRL?=
 =?utf-8?B?eU10eFpHbXlZSk1zM3FYK2lybnVuQlpzTTVUbVBVYnJnN3kvaHh5M1FxMTI0?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1253.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ee2bfc-c434-46cf-bbf8-08dc215e6dd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 06:41:03.2915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zfvW0S79F3niPC1IuwSe9b4B53WsuOTMjQkTrzL0voR0GRejFMv1NPOIB7FXxYKvyjPrMuMrGLHT63CMFziMe+FAfQJQyvWuu8m/alRdDEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1221

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyYyBLbGVpbmUtQnVk
ZGUgPG1rbEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyNOW5tDHmnIgyOeaXpSAxOTozMQ0K
PiBUbzogV2lsbGlhbSBRaXUgPHdpbGxpYW0ucWl1QHN0YXJmaXZldGVjaC5jb20+DQo+IENjOiBk
ZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsN
Cj4gbGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtY2FuQHZnZXIua2VybmVs
Lm9yZzsgRW1pbCBSZW5uZXINCj4gQmVydGhpbmcgPGtlcm5lbEBlc21pbC5kaz47IFJvYiBIZXJy
aW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBXb2xmZ2FuZw0KPiBHcmFuZGVnZ2VyIDx3Z0BncmFu
ZGVnZ2VyLmNvbT47IFBoaWxpcHAgWmFiZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+Ow0KPiBL
cnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+OyBD
b25vciBEb29sZXkNCj4gPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBEYXZpZCBTIC4gTWlsbGVyIDxk
YXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYw0KPiBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29t
PjsgSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvDQo+IEFiZW5pIDxwYWJl
bmlAcmVkaGF0LmNvbT47IFBhdWwgV2FsbXNsZXkgPHBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbT47
DQo+IFBhbG1lciBEYWJiZWx0IDxwYWxtZXJAZGFiYmVsdC5jb20+OyBBbGJlcnQgT3UgPGFvdUBl
ZWNzLmJlcmtlbGV5LmVkdT4NCj4gU3ViamVjdDogUmU6IFJFOiBbUEFUQ0ggdjEgMC80XSBDQVNU
IENvbnRyb2xsZXIgQXJlYSBOZXR3b3JrIGRyaXZlciBzdXBwb3J0DQo+IA0KPiBPbiAyOS4wMS4y
MDI0IDA4OjA3OjQ5LCBXaWxsaWFtIFFpdSB3cm90ZToNCj4gPiA+IElzIHRoZXJlIGEgcHVibGlj
IGF2YWlsYWJsZSBkYXRhIHNoZWV0IGZvciB0aGUgSVAgY29yZT8NCj4gPg0KPiA+IFdlIGRvIGhh
dmUgdGhlIGRhdGEgc2hlZXQsIGJ1dCBJJ20gbm90IHN1cmUgaWYgQ0FTVCBpcyB3aWxsaW5nIHRv
IG1ha2UNCj4gPiBpdCBwdWJsaWMuIEkgbmVlZCB0byBjb250YWN0IHRoZW0gZmlyc3QgYW5kIHRo
ZW4gcmVwbHkgdG8geW91Lg0KPiA+IE9yIHlvdSBjYW4gY29udGFjdCB0aGVtIG9uIHRoZWlyIHdl
YnNpdGUsIHdoaWNoIGlzDQo+IGh0dHBzOi8vd3d3LmNhc3QtaW5jLmNvbS8uDQo+IA0KPiBJJ2xs
IGNvbnRhY3QgdGhlbSB2aWEgdGhlIHdlYnNpdGUsIGJ1dCBwbGVhc2UgYXNrIHRoZW0gYXMgd2Vs
bCwgYXMgeW91IGhhdmUNCj4gcHJvYmFibHkgYSBiZXR0ZXIsIG1vcmUgZGlyZWN0IGNvbnRhY3Qg
dG8gdGhlbS4NCj4gDQo+IHJlZ2FyZHMsDQo+IE1hcmMNCj4gDQpJIHNlZS4gSSdsbCBkbyBpdCAu
DQoNClRoYW5rcywNCldpbGxpYW0NCj4gLS0NCj4gUGVuZ3V0cm9uaXggZS5LLiAgICAgICAgICAg
ICAgICAgfCBNYXJjIEtsZWluZS1CdWRkZSAgICAgICAgICB8DQo+IEVtYmVkZGVkIExpbnV4ICAg
ICAgICAgICAgICAgICAgIHwgaHR0cHM6Ly93d3cucGVuZ3V0cm9uaXguZGUgfA0KPiBWZXJ0cmV0
dW5nIE7DvHJuYmVyZyAgICAgICAgICAgICAgfCBQaG9uZTogKzQ5LTUxMjEtMjA2OTE3LTEyOSB8
DQo+IEFtdHNnZXJpY2h0IEhpbGRlc2hlaW0sIEhSQSAyNjg2IHwgRmF4OiAgICs0OS01MTIxLTIw
NjkxNy05ICAgfA0K

