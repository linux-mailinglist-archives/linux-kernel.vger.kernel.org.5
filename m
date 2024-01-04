Return-Path: <linux-kernel+bounces-16280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCF6823C20
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C27128704C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 06:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4955D1C6A1;
	Thu,  4 Jan 2024 06:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VPqMhhw2";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="NTs6XPxY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B0D1A70D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 06:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 92c84646aac811ee9e680517dc993faa-20240104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=sF1NP8sG4OkI5yKJRj77j3dsXu4K4sy5xW+bdjJXR90=;
	b=VPqMhhw2Fqp84A3wh9l4Ll4YXm+07BQvs4NOCBlzvoS0xLmCzW6EKyctXEjcXiDuzaZ9F5S+EbI8xJO917bvGHH5QOPaHDpjFlLvcmW47mwVoaM21Y/WWmFboIB9YZrlirkeGcHs+muP1m8HD0DXQZ3hjEKXExjF7GR8HNWOggo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:feaa7ccc-c16b-45b7-8f83-27e5071d1cd2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:5ea37982-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 92c84646aac811ee9e680517dc993faa-20240104
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 134720663; Thu, 04 Jan 2024 14:14:52 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 4 Jan 2024 14:14:52 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 4 Jan 2024 14:14:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GetPJKSSTnf5/Yz7fOIG98qmbP0lWTpFeDcf3SyxpPtKBlDfbMpG1QPPbc/E3WNM2+Mj+Yv/jJDie6ifkXG4nPGZemV+t6T9WP7JH/RnJ1y6hZP4l4RqrJ4cNkEVSM8w4PgVLuVNNbENxCQd4PdQkXRPkIRn3+e6M3H7UtSdRFUW+2QaujFZRlgy8hb29Glunx97ywjgngkdUomMpH5jpM3TuHCiljqKoE/T3qO20v/o5VlgYMF1qDv+2u2ay39bjoKDgXs0kaQJVSW0Au2bgVLW/SlVIEjFYcZ0fMIE3yLPA98xApMUHdGAQLjqhg84KAPRJZPUIZibkmyQHn6zmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sF1NP8sG4OkI5yKJRj77j3dsXu4K4sy5xW+bdjJXR90=;
 b=BL/3jRnfuIofZ8cA7FveAwT8XJd1mrGXQvaH1+jARvZ1T1O6GJPpxEMyv1L27jiPz5V59S9yQbrX/uKFjcf2zfewUFZBr1zAgsSAwVPdgYkDER7J/Y/eyRJb1bUGoQ1d9x5uL3J3cZw/7jLVJBFMwZlgRtP4KLgLGBldJENJKeuIry4Mj9INAliJG9HA6GeZ6naxnD/pmFvfMYdbqBPOx0bOkllf6C3BIKtyrS1GSVlkBHq0vmnRfC0J8zxotzYGnUZ72sZaSL2FTH8ECtbc5fKuS4T77RfkfYPEKHI29CmuYNPW5SF1qbKV9CRRDnCZQFlN6DUiszDehichbY9vNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sF1NP8sG4OkI5yKJRj77j3dsXu4K4sy5xW+bdjJXR90=;
 b=NTs6XPxYJ2yLHpKKCAeFU+ZNL1Zn9jPqenUxSRGochl/x0cVfR3UrdW47faqJDwPaZBDA3Xgcgyohcsk+VmcNPNPGe8o8ycYkrWgY/XVNpfqlG64m0lWjHu/rr7Ej6rIgzlDS8RCkACS+hAmAmjgqzyDi/u8XpgKlINLYq0A9Xk=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB8862.apcprd03.prod.outlook.com (2603:1096:990:a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 06:14:48 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 06:14:48 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?TWFjIFNoZW4gKOayiOS/iik=?= <Mac.Shen@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= <Shuijing.Li@mediatek.com>
Subject: Re: [PATCH] drm/mediatek/dp: Add the HDCP feature for DisplayPort
Thread-Topic: [PATCH] drm/mediatek/dp: Add the HDCP feature for DisplayPort
Thread-Index: AQHaHrPjdunoffcOCEGmErF8vNrJIrDJbTsA
Date: Thu, 4 Jan 2024 06:14:48 +0000
Message-ID: <e571d57804562a86b07e8aadf2e43c7439b3a78b.camel@mediatek.com>
References: <20231124085346.26602-1-mac.shen@mediatek.com>
In-Reply-To: <20231124085346.26602-1-mac.shen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB8862:EE_
x-ms-office365-filtering-correlation-id: 12e73202-bb4b-45f5-6f02-08dc0cec74ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KWJz/ohkgZAZ+JptegyXrVp3gJPzT41rnd35tvNgFxFRxN9NxibiA+C+QvC2NmdhsZrbRIeP4//iT7ZXOT8GisoU92brtl+NT4Sz3CI+7cKatEQ2PVZQuLZv0kYYrNJgUzHBN1b5wHCd8G4eXmWaiF1FeifxouyUKSeiLYPxS8lCQfKZkxekHtEB0TawmYiQ8br0/3CYhi7nA0oukTFlCtBv2EHecaO3LXPQeo8JZqTLbz+huXN+Dq6Q+Mm2NJB5qd/EV9sFvtsHqhnLIiRkpGHLvUHRUWFMxkCx+IuJT5VK6ypEJEqqFSeg5qjF+ALE2SwNLnDVCLN01amcAsoS4JuHd6a/pU36agkU7JAgHN/69Z3ygyWRdJ2pC3lj15oX3OehQFaU5wqIfDaCepg8iPPL/Ax8zfmo7cXE8Fi4+umTMrsudL5j2aVSj8hD1G0s3sj+VHA6WYTVWixx2nenpdRcW2jCr1+v+Xx7pRZs1I+AgHw9I1o/MLU56uz3fRrB6nwQXvdilL/Vzf/lfbdOg6yLwz1hCCufyYsyKbDkT8q2ZblyVf9UAnU6ysSBpg492XJsk2UsRPoFlK4bNl16BXzrTgv5Qlcab327wd1w8qOKUtFK3s8QpyrCTrgfhq9vDji93/1SIFEMH/1Bb54gfWA6/lJ0d4rCvWbZXpWHgcY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(4326008)(4001150100001)(2906002)(5660300002)(7416002)(478600001)(71200400001)(6512007)(6506007)(110136005)(54906003)(76116006)(66946007)(64756008)(66446008)(66476007)(66556008)(316002)(8676002)(8936002)(6486002)(41300700001)(38100700002)(122000001)(36756003)(85182001)(86362001)(38070700009)(107886003)(26005)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzNuNTFWU3pDblhCUy90d3pLN3hweUZSUjNLdzN6OEZjTHZ1MmRhZ2lMQVJL?=
 =?utf-8?B?QUg4ak5IZ3Q5MDdGaHRicWVpY0JvR0lrL21FMngxWFM2UE1uaXA4SHJiMkNw?=
 =?utf-8?B?RXRmbmhaTitTT2F0cmJtV2tURnp1K1JXRGpLVUg4V3pIdENBSDJHZXVWVjc2?=
 =?utf-8?B?Q08rSy9udjJ0TEh6WStPSzgrS3lzRmhkVGc0NUgzS04reWRpZzM1WkNnSU1k?=
 =?utf-8?B?akF3NkRMRkNra1duSzZOWWFXSnF4ZklDc1l2ZGV0TjdRZW80d2FxT1RNUXlC?=
 =?utf-8?B?Y1lYNWl4dSt0V0l3NnphZ3RMRUFtd3Q3QThTM0lKZlVYTXdubzA4ZnJ1MThD?=
 =?utf-8?B?Y3hJZjZMY2p4b1h5amYvWWxlOE4zblRzZHBtaEJNM3RSMnhiOXB2Y2syMlBR?=
 =?utf-8?B?bmpXWkJMQnFtVmdudmN3NFFIY1RDbVVlR3NlUEkvSmhaZ1dnRm1xamNYR2Qr?=
 =?utf-8?B?WTYvU25wTmpET2ZaVU5EMm5mdGtKdHpUa1JwY0VaVm9UVGpQRTB6NjI2WUg2?=
 =?utf-8?B?MVRKN1p0elJOQW9oZ0wvNUZ1OFVCOFZXT0lhRS9XSUJEU2hGK3RNaXFpb0hh?=
 =?utf-8?B?bC90OFBCeDl2eEVjNkhNTW9wY045T21ZelZSMjN5b3puN0I2M1UrSzB1aVkx?=
 =?utf-8?B?Zjg3NUVwaHpwRGR6MG05VVZSR1o0T09NdnI1K1BVT0x0RVZPbnpPV2hkMC9M?=
 =?utf-8?B?T2NRM1R1Vkd1WjRxbDdoa3pCWHMraVVwRUpaM2FnZzR6VVJkU3RKc0VhaXpE?=
 =?utf-8?B?VGQ4WnEzSW1PY2JXSW5NcnNUV2ZHNUpPZTYzNUNTQWFtVkJFV0pMTm54VjRW?=
 =?utf-8?B?WXdrN0had0w3YzE4YUEvSGg2MWcxTnFrWURKeEN3UGoveC9Za1haRS9DUjlB?=
 =?utf-8?B?ek14dEJRQmhJWXJqVnNkQk82YkFQUzE3d2JJT1R5NVNucG5lZlJ5MXI3Yi9I?=
 =?utf-8?B?bXRxcXVqd0RtQVU1RGZTVzk2U1F6eUw4emx3MzFqN1NXSmM0Si9na1RTYUY5?=
 =?utf-8?B?ZEFwR1BPVDNIV3FxTmVJSGZzNXNmdDBEUkllbVBzTERBMTgyeTJtZkwzbytI?=
 =?utf-8?B?NmNZL1RKbUp6VjFVSzhmKzVCRmNlMkdjb1FPbmFGS1pTclFBMEVONVQ4NWZh?=
 =?utf-8?B?VTlIOWJXbzVDbGNJbHVaNDlWWlRMZjdYd3AxU1UxREc4eFNlclhsZGc2NE9X?=
 =?utf-8?B?NzdLSnRSQnZsR2NiclU3cStxenJrMUlyaEJudkxONDM2bGZZYkE1M21qVjN2?=
 =?utf-8?B?aEZIbGRqZnJPVnUzUk43VnFhRVNQcENnb2E0MGNSdk1yUWx6K0ZFMVNyTFJV?=
 =?utf-8?B?L20xS0dFZzhTTmVZcGUwS01nbXVwK0xIV1VzdnZCVDB0eTQxR2VPODRzMGdu?=
 =?utf-8?B?Rmc4bkQvcFRRblp4WktVK3JPdjZDQW1IUGRiMWQ2ODRlc0FiVTdHZVRlL1Fz?=
 =?utf-8?B?ZmErY0w0YlBFbk91Y3o0d2NPRFErUEp0Q0lHTVhhbzZqbTRxeEFOV0RwT0Zv?=
 =?utf-8?B?clJDcHVsRHlXSDB1Nnp4QW90aEo2dGhFOXR1RHpZSEZxRjRqK1ZOeU9Jc0oz?=
 =?utf-8?B?dGZJT09hTVg1QUhjQVhiNzFlYVNvcEhuS1hmUUVsNUpXQS9kdTBqQkpXUmdw?=
 =?utf-8?B?Q1FhWitSVHRTWE41RDZzZnZTeG5KNkhuRVJDMy9weEJXUmJKWDIvc2xFWjRP?=
 =?utf-8?B?SklqUU5BWitDcjhlT09YMkJkdDRlWWIyY0pIQWU2RG9vNTh3OFNidXRLdUJN?=
 =?utf-8?B?cEFWTVhyOS9TWUxsblpSUjJ3Wmp4d3RJTnlKVzdqMSszdEI5am1KVENrZlVM?=
 =?utf-8?B?bGpKWlBFMUZwV0hQVGtIdTZ4NE5mSWNDOFcxTHdodzZyc29KM2ExbmVZQ0RF?=
 =?utf-8?B?QzBLUUlyaFZnZi9sNitNWGNyTlh3STEwUklueXBITU10SjRqT2pqdURyVmQ5?=
 =?utf-8?B?b2xGRlZZdkM0Q0hndjQ5V1ZIakd0TWkzQm83WTcvRVE4QkxTUEVDYk9zWGxi?=
 =?utf-8?B?Tlh2cTFCcnFMOExhRE5hNW0vS2FNdTZRZ1VZMVY5Y256Z1pnRUNmeDBIZnc0?=
 =?utf-8?B?ZTZTckVkc3hhVHBRNlROWDNUU1dYeTlDUGZ6Y0MxZHZWZUNBK3B3bzZoZHFJ?=
 =?utf-8?Q?8mUQTb/1Bh5bxYHAolpzLGB3o?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF2598914C120E408093EE471B62F5F2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e73202-bb4b-45f5-6f02-08dc0cec74ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 06:14:48.8497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cYxCov3xk/6T//UkQ4FM90yaIcefyE51dCozwPjTwPyMnsRi6/x2Do3CmplKHpWOL7vk4/Lt/V2ppmFJsRDpkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8862

SGksIE1hYzoNCg0KT24gRnJpLCAyMDIzLTExLTI0IGF0IDE2OjUzICswODAwLCBtYWMuc2hlbiB3
cm90ZToNCj4gQWRkIHRlZSBjbGllbnQgYXBwbGljYXRpb24sIEhEQ1AgMS54IGFuZCAyLnggYXV0
aGVudGljYXRpb24gZm9yDQo+IERpc3BsYXlQb3J0DQo+IHRvIHN1cHBvcnQgdGhlIEhEQ1AgZmVh
dHVyZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IG1hYy5zaGVuIDxtYWMuc2hlbkBtZWRpYXRlay5j
b20+DQo+IC0tLQ0KDQpbc25pcF0NCg0KPiArDQo+ICt2b2lkIG1kcnZfZHBfdHhfaGRjcDF4X3Nl
dF9zdGFydF9hdXRoKHN0cnVjdCBtdGtfaGRjcF9pbmZvDQo+ICpoZGNwX2luZm8sIGJvb2wgZW5h
YmxlKQ0KDQpUaGUgcHJlZml4ICdtZHJ2JyBvZiBlYWNoIGZ1bmN0aW9uIHNlZW1zIHJlZHVuZGFu
dC4gU28gZHJvcCB0aGUgcHJpZml4DQonbWRydicuDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICt7DQo+
ICsJaGRjcF9pbmZvLT5oZGNwMXhfaW5mby5lbmFibGUgPSBlbmFibGU7DQo+ICsNCj4gKwlpZiAo
ZW5hYmxlKSB7DQo+ICsJCWhkY3BfaW5mby0+YXV0aF9zdGF0dXMgPSBBVVRIX0lOSVQ7DQo+ICsJ
CWhkY3BfaW5mby0+aGRjcDF4X2luZm8ubWFpbl9zdGF0ZXMgPQ0KPiBIRENQMVhfbWFpbl9zdGF0
ZV9BMDsNCj4gKwkJaGRjcF9pbmZvLT5oZGNwMXhfaW5mby5zdWJfc3RhdGVzID0NCj4gSERDUDFY
X3N1Yl9GU01fSURMRTsNCj4gKwl9IGVsc2Ugew0KPiArCQloZGNwX2luZm8tPmF1dGhfc3RhdHVz
ID0gQVVUSF9aRVJPOw0KPiArCQloZGNwX2luZm8tPmhkY3AxeF9pbmZvLm1haW5fc3RhdGVzID0N
Cj4gSERDUDFYX21haW5fc3RhdGVfSDI7DQo+ICsJCWhkY3BfaW5mby0+aGRjcDF4X2luZm8uc3Vi
X3N0YXRlcyA9DQo+IEhEQ1AxWF9zdWJfRlNNX0lETEU7DQo+ICsJCXRlZV9oZGNwX2VuYWJsZV9l
bmNyeXB0KGhkY3BfaW5mbywgZmFsc2UsIEhEQ1BfTk9ORSk7DQo+ICsJCW1oYWxfZHBfdHhfaGRj
cDF4X3N0YXJ0X2NpcGhlcihoZGNwX2luZm8sIGZhbHNlKTsNCj4gKwkJdGVlX2hkY3AxeF9zb2Z0
X3JzdChoZGNwX2luZm8pOw0KPiArCX0NCj4gKw0KPiArCWhkY3BfaW5mby0+aGRjcDF4X2luZm8u
cmV0cnlfY291bnQgPSAwOw0KPiArfQ0KPiArDQo=

