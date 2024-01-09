Return-Path: <linux-kernel+bounces-20490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D50827FA3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9AC1C20E4E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB65224F8;
	Tue,  9 Jan 2024 07:43:04 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2057.outbound.protection.partner.outlook.cn [139.219.146.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A31B65F;
	Tue,  9 Jan 2024 07:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRIenlHz7AFs7DkIWjBpMJmRkXS+cGkT2ay8Qr13l5RIEtZNwmMdnwEJNMnccxIiEqI0HEvLkZ6mQ47PSNf4dyeyBPTRqTwr2iZ/o4hTMAGJXe6KqQWDKyOvZbV/n0kNwTjwhbQF1AwWPJVfsHu/Cm6Fw5B/XcfSHVg9uQ+W9oJIfcR+MTJ2sM9Y5XOV9LXqFJRC39WD16wvgxt3tOg7ZMQG5QsLNUi4NzW6EY17FcRnOw9a/y2B6IkMNrnuVNg1Gf/CynPvGwFDjCma5oYWSaqkBNPuBpjDnv4Aftp3HAHNOp7nG7mKhqvR4cvwuGXnD87ZMAhucXEmyajMQFXgfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgZWGrbudggTBn2QrTE/Sp0xwRQfoBfvwaiEXgFDs+8=;
 b=N8pY1EDwI1Nv1cjZAjRpEX8LuyfVggOSQherod3/zK04rboywrg1+Y3z8IBhkHT6GOA5h8kZvQDNhkFxVfej/PGEP+R8JVea2SOefVYvjn1Y7mcJYjtKhBK9X4IAeQjE3mmSF3eja7eq+7gB3Ql5jIMjrX2WymP/xcM2zcreoTR7c+mffwa/7aAZMDxondjbkUShmFcq+Od2aH/QRJW89qNYRqDDKfdfgXMRmF9tR1JF/WOcfP3yeNhrNJe60qAe8pzppZkT6vRmDcw7bWJtyjWByAyMqSm6D0di1wT/3WO7mSqOAOOgZnVenezfsYaViMNNwm2JtrUqieduf5zkhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20) by BJSPR01MB0770.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Tue, 9 Jan
 2024 07:27:49 +0000
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 ([fe80::aaac:167d:8e0d:3acb]) by
 BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn ([fe80::aaac:167d:8e0d:3acb%5])
 with mapi id 15.20.6933.032; Tue, 9 Jan 2024 07:27:49 +0000
From: ChunHau Tan <chunhau.tan@starfivetech.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>, Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>, Andrew Halaney <ahalaney@redhat.com>,
	Jisheng Zhang <jszhang@kernel.org>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>, Russell King <rmk+kernel@armlinux.org.uk>
CC: Leyfoon Tan <leyfoon.tan@starfivetech.com>, JeeHeng Sia
	<jeeheng.sia@starfivetech.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/2] dt-bindings: net: starfive,jh7110-dwmac: Add StarFive
 JH8100 support
Thread-Topic: [PATCH 1/2] dt-bindings: net: starfive,jh7110-dwmac: Add
 StarFive JH8100 support
Thread-Index: AQHaQgh0Hx+kDwvvJ0e+cd6zLXBSI7DPlRuAgAGA9hA=
Date: Tue, 9 Jan 2024 07:27:48 +0000
Message-ID:
 <BJSPR01MB05951FFA70FEDDD2917C37749E6AA@BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn>
References: <20240108075810.14161-1-chunhau.tan@starfivetech.com>
 <20240108075810.14161-2-chunhau.tan@starfivetech.com>
 <0aaa3f78-07c5-4c03-bb1b-897020541e7b@linaro.org>
In-Reply-To: <0aaa3f78-07c5-4c03-bb1b-897020541e7b@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJSPR01MB0595:EE_|BJSPR01MB0770:EE_
x-ms-office365-filtering-correlation-id: 326143e8-a22b-4583-48ed-08dc10e47b75
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fM9LWMLJd6k+jXgJi6Rcxykqf9kqGrBoN8aNsKwPX7Hzs37IpMTrP8mb50+4uZxlJ3GBjNuw+wA2EfQLpTt0HvsE87XDI1Qu+FUQqPaceDKVjVYvZab+6Pi75NA/iaJfImQG3JzxbT84YSb9pOk1Hlu4d9J1wOmcSX6d4TexVcqSn+KjPshG3K6k/Ez3W/enpClVECUWjMjwGyTNQ4i+wLeyKXWQgtfx+Ghh61JEKMghVxGrad1bUWGM23ZHzdpRawYcpVI6aySJMJFWEwC36Ge28fTpc0M3LmK81mMjXoBWC7/SSeF/iwNWJHEuHWWLt3o/qbmD2ECVPLLkUdpHMGd1vaqfs3y88G0+lB8Pz+kRORmdyqmTBgmSC0H0oXG9gwh2P+/4wRtDrN9OmFlUCJ96oGbMC/4n8McsKj7HWLQDB7sNhkDLigJz5tzOFfVQn+bGg0MfHkBirI8vfawhZzQ31XgnsYEmajjnbYzPuhoNNOaFYi1oOmt4pv4I5YovbzI6gjgJipDDIgCXXMIsawEbUFJNwF4TGomHOFKPYtvcdjhYH2KH6TpiDJnjyUq9GOp0Ib4Zw3Q52lZYLkDpJnkiDep/fcPIgHFpr6SmWeRNjnwG4jjc0WJFN/1lUfF6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39830400003)(346002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(66946007)(76116006)(38100700002)(66556008)(110136005)(66446008)(8936002)(921011)(66476007)(54906003)(64756008)(8676002)(55016003)(4326008)(41320700001)(26005)(122000001)(5660300002)(41300700001)(83380400001)(2906002)(33656002)(40160700002)(71200400001)(86362001)(9686003)(38070700009)(7696005)(53546011)(7416002)(508600001)(40180700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YkdsMGtqNTFsQ3o5dkJHQjJSanZQRmx0SEdqMmltVUUveitWM1lWL0tWMjlM?=
 =?utf-8?B?Skg0dGZZd0c0WndJVkU5RjhMSll6Z2xESGhrRmdsZzlkMkxSYkhNYUNrU0hq?=
 =?utf-8?B?dG8xdDQyQkJZNzZyUGNvS2RwclRBSUE0RFJGQ0VYWTQ2MWR1Y3MxS1ZGYUow?=
 =?utf-8?B?MXMrL1BSL3JlTy9kOEhLeFZKZHVwZ29xOUgwekRrWWhQUUE4MzJoTW9rZ0hJ?=
 =?utf-8?B?MTFiU3B0Ly8vNFpkOTIvSzA5L3dpTlFYa1NnQkdkNER3emg1SVgzNmNBSk9V?=
 =?utf-8?B?U0RVcmhtOThwc2JwTUhVZzNDZ21TTDhncUVjM0pIdk9SdDFQOWNDMUZPcFBp?=
 =?utf-8?B?ZTZ3bWF5MXFmM1R6eE1SQ3MzRGVpeW9XUzlBb2J2YjgrVVpPMzV3WjJGbWJ4?=
 =?utf-8?B?bGp2MG1TbU5kV015Q09XOXdaUW9Rc2JtYTh6Q3paUkNKbW1hTkVGTmxxR0c5?=
 =?utf-8?B?QktPV25hSW5lYnZTNVFPUTcrTy9Yc1JmVUErN3BPMzd5S3lGaytQMk1DV0FM?=
 =?utf-8?B?cWMyWHBDTG9XN2NYTnBzb2pYVkhiZXgwZE85QlJyZDBsV003V1gvWktiMUR0?=
 =?utf-8?B?Q3ZtdFNXS0dpeGZsY09oZ1NKZzZUM1E3WkFsNFY0K2hLTUNoa0ZISzlkQlk1?=
 =?utf-8?B?b0dvWEpRcS9UZlZYRkVUaXdkUmF6RlR6WTVyOEVsZzk0TU12U29UMnRUdXVM?=
 =?utf-8?B?ZDRUSUJxbGNqVzl5VmFMVjlRYTcxQkVyWDBVMU9DcUZibnp2SlNXOHpUTTEr?=
 =?utf-8?B?bDRReHdPYXg1Y1Z6TGxpWXZzUGJJTjl6ekdIS2JpZXJHNmVxWFBaWW5VUW0w?=
 =?utf-8?B?S0VIcjR0Zy91OUZGaEpDeklXYWdoNER4YitZMXdiQm1tL3lEeFJUVE40NklO?=
 =?utf-8?B?NVZYWXVCd1ZLOVlVaGlVRytJbnNuMG15RmIrK3M1dU05SXlYbDZrOTBpdDd1?=
 =?utf-8?B?c3NraXh6aThBWEpyLzRTUDlGNzFMai9zSGpGeVhxNmpVM1ZjamR5YW1HVDdO?=
 =?utf-8?B?eDVpLzNKeEhXbmlPUEtPTU5ZUUFNbDV5eHIvcjNLb3pyenJWRmI1OW9HTTJ2?=
 =?utf-8?B?QWpUYzdPTE90M2lXQ1g1Z2RlSmM0ODRVdmtyNkxLNWtKMmswTGFzUHN3Z3dz?=
 =?utf-8?B?SGY0VlNpclRicU9XTUgzWGJCT1Z4a2tnajRGV01uSWlqWGlqYnk3bmNrWXdN?=
 =?utf-8?B?WktqQi9pb1VYcjYwUWV0cjlXdWl6azhkZlFBaEpZRnh1emR1TmdsckxuOVRC?=
 =?utf-8?B?TzZUQm5WZmFkbTUrc2twdnJieFlBMXdERWVzRzM2Tlc4RVA4TEhvRWxFdnNp?=
 =?utf-8?B?eXp1Mlg1NzZxM2t1NTFGM2FVTGtSeVNQZ3B6N3NhckxlZUpKN3RKYkNpcXk1?=
 =?utf-8?B?M2ExMjhsbVpiMkd6V0xuTk9DenlRZ0MvMXJ6T2xNTXMvYzNuSmVVMFMxd3B5?=
 =?utf-8?B?dXVYekJPRkxoN01LZ0Z3WVgxU3FNNlgrYjZMZ2hpSFFST2x0MVovQUtDc2ZK?=
 =?utf-8?B?dTlOZlZmQVVST0FVZklMU091MkpXUlpWOW1TY2RxSWhQNFBjamZ1bjRvN3Zv?=
 =?utf-8?B?M2ZreVFVL0FjNnFQc01PK0FDMGc0MmVhcjVTbkVwOEhaRFVWZ2dFMmFvNGNX?=
 =?utf-8?B?eERZNExjdmxBZUxJRUxOSjA1MHZvWlRXalgrc1p6OGg0WjV5QW1zNWZUZy9z?=
 =?utf-8?B?S2wzTjQ0R3B5ajlXNzlZUFhONGxBckNFbnpxcHQ4dkhKM3VWdEIwS3p0TmZ6?=
 =?utf-8?B?dUMyMk5idlpzRWxqWlpHNTRMRVgxL3RJSDdlZVVUakFZODhmZ0pSaWl1VGR4?=
 =?utf-8?B?YVc2V2NWNTV2WGgrNjNRVlpYaXlkSnUra1d0bVZXOFpHTlJ3Uis2VXpOZjdi?=
 =?utf-8?B?R3NDWmdPdEFqTk14TGFnTWxjQTM4VHYzMkhCa3VQMG85ZlVGMG1TUlBXUlNI?=
 =?utf-8?B?NElhd1YyRGI1SXhWcnNSMW0rT0ovbmFzbGJ4U1dBQ0l4MVFWV0FXMG4zamhN?=
 =?utf-8?B?ZlpUNnlGWEpnczM2RnU0KzdvZ2lpQ2FXN25MbmdrT1BtUTJza0UzZnBZVDR1?=
 =?utf-8?B?dWNwT2dMN3ltTURKeVNBTTB0cWhuSXhBalR5cldHN0xxdjdRSWNRd1grYW1R?=
 =?utf-8?B?YnlManpNVUcyQUswTGpKa2t0Rk9vMWtMTno1NDlKWCtnMmxTYzVMN2dzMkVx?=
 =?utf-8?B?N2c9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 326143e8-a22b-4583-48ed-08dc10e47b75
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 07:27:48.9027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WqZtJqDti08H02JLAHWxZ0LUGwEth+pjHOK5IbvlYav7UrqQ5ACIwDLN4bV/817wHPw5klAYIUYjx7D5f0WRmBRcLVbHaRehfGRD6e8aBcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0770

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBNb25kYXksIDgg
SmFudWFyeSwgMjAyNCA0OjI4IFBNDQo+IFRvOiBDaHVuSGF1IFRhbiA8Y2h1bmhhdS50YW5Ac3Rh
cmZpdmV0ZWNoLmNvbT47IERhdmlkIFMgLiBNaWxsZXINCj4gPGRhdmVtQGRhdmVtbG9mdC5uZXQ+
OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1Yg0KPiBLaWNpbnNraSA8
a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgUm9iIEhl
cnJpbmcNCj4gPHJvYmgrZHRAa2VybmVsLm9yZz47IEVtaWwgUmVubmVyIEJlcnRoaW5nIDxrZXJu
ZWxAZXNtaWwuZGs+OyBSb2IgSGVycmluZw0KPiA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9m
IEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsNCj4gQ29ub3Ig
RG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgTWF4aW1lIENvcXVlbGluDQo+IDxtY29xdWVs
aW4uc3RtMzJAZ21haWwuY29tPjsgQWxleGFuZHJlIFRvcmd1ZQ0KPiA8YWxleGFuZHJlLnRvcmd1
ZUBmb3NzLnN0LmNvbT47IFNpbW9uIEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz47DQo+IEJhcnRv
c3ogR29sYXN6ZXdza2kgPGJhcnRvc3ouZ29sYXN6ZXdza2lAbGluYXJvLm9yZz47IEFuZHJldyBI
YWxhbmV5DQo+IDxhaGFsYW5leUByZWRoYXQuY29tPjsgSmlzaGVuZyBaaGFuZyA8anN6aGFuZ0Br
ZXJuZWwub3JnPjsgVXdlDQo+IEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRy
b25peC5kZT47IFJ1c3NlbGwgS2luZw0KPiA8cm1rK2tlcm5lbEBhcm1saW51eC5vcmcudWs+DQo+
IENjOiBMZXlmb29uIFRhbiA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0ZWNoLmNvbT47IEplZUhlbmcg
U2lhDQo+IDxqZWVoZW5nLnNpYUBzdGFyZml2ZXRlY2guY29tPjsgbmV0ZGV2QHZnZXIua2VybmVs
Lm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGxpbnV4LXN0bTMyQHN0LW1kLW1haWxtYW4uc3Rvcm1yZXBseS5jb207DQo+
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIDEvMl0gZHQtYmluZGluZ3M6IG5ldDogc3RhcmZpdmUsamg3MTEwLWR3bWFjOiBBZGQNCj4g
U3RhckZpdmUgSkg4MTAwIHN1cHBvcnQNCj4gDQo+IE9uIDA4LzAxLzIwMjQgMDg6NTgsIFRhbiBD
aHVuIEhhdSB3cm90ZToNCj4gPiBBZGQgU3RhckZpdmUgSkg4MTAwIGR3bWFjIHN1cHBvcnQuDQo+
ID4gSkg4MTAwIGR3bWFjIGhhcyBvbmUgcmVzZXQgc2lnbmFsIGluc3RlYWQgb2YgMiByZXNldHMg
YXMgaW4gSkg3MTEwLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVGFuIENodW4gSGF1IDxjaHVu
aGF1LnRhbkBzdGFyZml2ZXRlY2guY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvbmV0
L3N0YXJmaXZlLGpoNzExMC1kd21hYy55YW1sICAgfCAyOCArKysrKysrKysrKystLS0tLS0tDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQNCj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bmV0L3N0YXJmaXZlLGpoNzExMC1kd21hYy55YW1sDQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL25ldC9zdGFyZml2ZSxqaDcxMTAtZHdtYWMueWFtbA0KPiA+IGluZGV4IDVl
N2NmYmJlYmNlNi4uM2QwNDQ3NzI2OTAyIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvc3RhcmZpdmUsamg3MTEwLWR3bWFjLnlhbWwNCj4gPiAr
KysNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3N0YXJmaXZlLGpo
NzExMC1kd21hYy55YW1sDQo+ID4gQEAgLTE3LDYgKzE3LDcgQEAgc2VsZWN0Og0KPiA+ICAgICAg
ICBjb250YWluczoNCj4gPiAgICAgICAgICBlbnVtOg0KPiA+ICAgICAgICAgICAgLSBzdGFyZml2
ZSxqaDcxMTAtZHdtYWMNCj4gPiArICAgICAgICAgIC0gc3RhcmZpdmUsamg4MTAwLWR3bWFjDQo+
IA0KPiBJIGhhdmUgZG91YnRzIHRoYXQgeW91IHRlc3RlZCBpdC4gTWlzc2luZyBjaGFuZ2UgdG8g
c25wcyxkd21hYy4NCldpbGwgZml4IGluIFYyLg0KPiANCj4gPiAgICByZXF1aXJlZDoNCj4gPiAg
ICAgIC0gY29tcGF0aWJsZQ0KPiA+DQo+ID4gQEAgLTI1LDYgKzI2LDcgQEAgcHJvcGVydGllczoN
Cj4gPiAgICAgIGl0ZW1zOg0KPiA+ICAgICAgICAtIGVudW06DQo+ID4gICAgICAgICAgICAtIHN0
YXJmaXZlLGpoNzExMC1kd21hYw0KPiA+ICsgICAgICAgICAgLSBzdGFyZml2ZSxqaDgxMDAtZHdt
YWMNCj4gPiAgICAgICAgLSBjb25zdDogc25wcyxkd21hYy01LjIwDQo+ID4NCj4gPiAgICByZWc6
DQo+ID4gQEAgLTU0LDE2ICs1Niw2IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICBtaW5JdGVtczog
Mw0KPiA+ICAgICAgbWF4SXRlbXM6IDMNCj4gPg0KPiA+IC0gIHJlc2V0czoNCj4gPiAtICAgIGl0
ZW1zOg0KPiA+IC0gICAgICAtIGRlc2NyaXB0aW9uOiBNQUMgUmVzZXQgc2lnbmFsLg0KPiA+IC0g
ICAgICAtIGRlc2NyaXB0aW9uOiBBSEIgUmVzZXQgc2lnbmFsLg0KPiA+IC0NCj4gPiAtICByZXNl
dC1uYW1lczoNCj4gPiAtICAgIGl0ZW1zOg0KPiA+IC0gICAgICAtIGNvbnN0OiBzdG1tYWNldGgN
Cj4gPiAtICAgICAgLSBjb25zdDogYWhiDQo+ID4gLQ0KPiA+ICAgIHN0YXJmaXZlLHR4LXVzZS1y
Z21paS1jbGs6DQo+ID4gICAgICBkZXNjcmlwdGlvbjoNCj4gPiAgICAgICAgVHggY2xvY2sgaXMg
cHJvdmlkZWQgYnkgZXh0ZXJuYWwgcmdtaWkgY2xvY2suDQo+ID4gQEAgLTkzLDYgKzg1LDIyIEBA
IHJlcXVpcmVkOg0KPiA+DQo+ID4gIGFsbE9mOg0KPiA+ICAgIC0gJHJlZjogc25wcyxkd21hYy55
YW1sIw0KPiA+ICsgIC0gaWY6DQo+ID4gKyAgICAgIHByb3BlcnRpZXM6DQo+ID4gKyAgICAgICAg
Y29tcGF0aWJsZToNCj4gPiArICAgICAgICAgIGNvbnRhaW5zOg0KPiA+ICsgICAgICAgICAgICBl
bnVtOg0KPiA+ICsgICAgICAgICAgICAgIC0gc3RhcmZpdmUsamg3MTEwLWR3bWFjDQo+ID4gKyAg
ICB0aGVuOg0KPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgIHJlc2V0czoNCj4g
PiArICAgICAgICAgIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBNQUMg
UmVzZXQgc2lnbmFsLg0KPiA+ICsgICAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBBSEIgUmVzZXQg
c2lnbmFsLg0KPiA+ICsgICAgICAgIHJlc2V0cy1uYW1lczoNCj4gPiArICAgICAgICAgIGl0ZW1z
Og0KPiA+ICsgICAgICAgICAgICAtIGNvbnN0OiBzdG1tYWNldGgNCj4gPiArICAgICAgICAgICAg
LSBjb25zdDogYWhiDQo+IA0KPiBNaXNzaW5nIGVsc2U6IG5hcnJvd2luZyB5b3VyIGpoODEwMC4N
CldpbGwgZml4IGluIFYyLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K

