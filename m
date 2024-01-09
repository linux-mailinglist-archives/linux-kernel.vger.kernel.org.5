Return-Path: <linux-kernel+bounces-20528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F351828031
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A311C23771
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9DE24B58;
	Tue,  9 Jan 2024 08:12:44 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2068.outbound.protection.partner.outlook.cn [139.219.17.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D898C15B;
	Tue,  9 Jan 2024 08:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvfTgT09hgnfMNQpRl8tPcFyG9JEUhcgekJdNRY8YYoEY5ceVhRh8wWJhuN3p7dMOmHJDOj/atZeVXMIm3fmy9HEUs5gXVJESe20lgZEGuf5YnYWoj3Pp2yicTVUNefOLZfqu8QHCcf4lJRTOBnqMg9LVl7/qWxfE437Imp8c8oLjr5JFAME28t0Yb1YHFJ7zcnNN21o2KucUkPCy4EC61aOdmqcOhOUAKDluLb0hY7Im9sBWKLR1bbvyTlhuewKxltNmanJiWQPGARdJGvrFRoPIsUp4M+ldUtBA2L62cHDOWZxbBrJmw9ZaxmXTEGCa3EMnmK8kcxVjCPwgZFNaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCNQmJxw/OwuB7fvLzpPAeoRHZN0H65Sd912aDZBWhs=;
 b=d1dDz+W6PnY2AxwAGsPV08XNwCgq1D6kk0O3xE05HtxE9xsgPMr0BrQ314gTg9/twToz8dOZxN6AdWPd1jIeiAKm/YF9HmQC6gDT0II6sEhbRyF+F6qljowMYKdYzgwQh0rfOxrvZI2S3jTKiwORLwdquNDSLSSOMksvGYO0bgJV7ePVs7Ceym4tVaUQj25NV92lOrMPGtjVK3o950L+/0nogv5fK/8CdtpXT0J6r0qxYQoGiuKPvBPGAd1YWHg4gDljbDbs+WzuWJQfcu0R2He88nQTrErjWRlRblQDT5iA8ykGSJtHifgYTtmwcC/ptIsyFJhF9qfxa2/Uabq8WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20) by BJSPR01MB0529.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.32; Tue, 9 Jan
 2024 08:12:29 +0000
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 ([fe80::aaac:167d:8e0d:3acb]) by
 BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn ([fe80::aaac:167d:8e0d:3acb%5])
 with mapi id 15.20.6933.032; Tue, 9 Jan 2024 08:12:29 +0000
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
Subject: RE: [PATCH 2/2] net: stmmac: Add StarFive JH8100 dwmac support
Thread-Topic: [PATCH 2/2] net: stmmac: Add StarFive JH8100 dwmac support
Thread-Index: AQHaQgh2nf3c4aA7dki8/ENX7FGoorDPoBmAgAFzoYCAAAt9gIAAAobw
Date: Tue, 9 Jan 2024 08:12:29 +0000
Message-ID:
 <BJSPR01MB0595E8847D0EEAB9CE60318D9E6AA@BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn>
References: <20240108075810.14161-1-chunhau.tan@starfivetech.com>
 <20240108075810.14161-3-chunhau.tan@starfivetech.com>
 <1c0474d3-e182-48c8-8ec2-12847c84164b@linaro.org>
 <BJSPR01MB05950484841C3D104EC91DEC9E6AA@BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn>
 <557a2dc7-d1e3-48f8-8eea-4792211849b3@linaro.org>
In-Reply-To: <557a2dc7-d1e3-48f8-8eea-4792211849b3@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJSPR01MB0595:EE_|BJSPR01MB0529:EE_
x-ms-office365-filtering-correlation-id: 873ba479-faab-4897-171e-08dc10eab937
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wUYkSykvLf0dsDmL7urX0P506yg3uPfP5TPbLpahTFBpQjied2qGSbsspqh7qqmOjzKaUOgY6Qmcqv1waVPCMD/aBnz8xg5YKXDlyuFC92poIWmoB63coEk+SM3t2vFET+mu03ZfwkPLopC1YCzT4jKlDp3siIGKPG1v6r0nj7ehJCFL2vW7a+innFxIzyNi6IRsTWudNQ5nSBK853Ye9ogxpil18j7x0+J2f3KByGLEJ6N9aqeTxRUmVhw3H/ux0cQ1FoGd32aH4TOMHj5Al+KwHtZRmp4gIbW10hH71O5wtaCOifPhAs5s83JHtS5yoYdi/mz3stjnHaE9fLCc0JVlXSu72eFQvn5PNr40wQqIFecEAOugs7+BDqL6hjnpBaGpJCKi0XXL3haXj0FYhaT/IfGjsQrHXDls2Ix7dwwM+otuhEisuK6T/q4n4GmZEVSdu6nPMkjrykhy7DWJHuPgUTOhWeR4aCd0csarQ/YnrfCcJJ1mHa/9VqJd1MfOK+TT0WvrIW1eu4kMy+h+07P1YI2dyBEILlJ4mQWqqxAcHC+SQjfgbvcg2kxeorohXcNG5M8+Fv8l3KNQev8Z3Q==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39830400003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(33656002)(86362001)(40160700002)(122000001)(40180700001)(38100700002)(83380400001)(921011)(66574015)(9686003)(55016003)(53546011)(508600001)(7696005)(71200400001)(64756008)(66946007)(66556008)(54906003)(66446008)(8676002)(110136005)(8936002)(76116006)(4326008)(5660300002)(7416002)(2906002)(38070700009)(66476007)(26005)(41300700001)(41320700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c2lsL0NYK0w0Q2lxTHBlR0Z5Q214UTlTcVEzbVFSYjVIVU9wb3hBdE95UXdz?=
 =?utf-8?B?SCswcjVLeWk3UkRTL210Qk03R3RoVzMzbmUxUUFsQklTRmdCamViYjVHUTJp?=
 =?utf-8?B?c0pNZ3NMV3hpRUpmVjdsYlBlQjAxL0sxRUNFblZZbUlNc2FRODFHZmJyUURE?=
 =?utf-8?B?cWV2cjBqWWpqaWZVeXdRT3VQZkFGa1U5UmZkT0NNdjVGSDdhbWgyTzhoR2ZG?=
 =?utf-8?B?TlZDbGZxb0RxSkdLbmVSS3MvVWVFRFBPUEZkVVMwZ05zbkhsL1Byb2hWUi8w?=
 =?utf-8?B?MHg1cFkweEp5YmpUU3hkWkxRRXJLSkhZR3BlMTA2T1JKREVEYUFGeXdZM3hE?=
 =?utf-8?B?cDE4VjhtTWFmeVBzL2ZaelpUa3dmd1BFcFNKaEIyOVNEeHhSTEFRbXhMSnM4?=
 =?utf-8?B?QU8zZU1DOUJNMTZuckdGYW9Bd0xxQnJNV3JqNzBQYmEwcVNIYi9SNFdGdHdO?=
 =?utf-8?B?RzFsWGJ0bmRyaW82WDYzNGFlUms5SXY1c3pmRjZiTTlCSDlQZDZPVjhJR25O?=
 =?utf-8?B?RVozZmNZSUJtN0ZVbHl0ZmIvbDlIazhYL0ZiVVBKRHN6SHhLYk9kdjFtcEZB?=
 =?utf-8?B?S3A2ci9kMkFvc0ZkRkRBaTdER21NN0V6Q0lmRmRLa29ZbDBSQ3R2Z1M5VFNp?=
 =?utf-8?B?cGlueC9pNVM2bUR4VEVESTljTFdOWk5ubnJZaDNmbElsT3FUVk8zWERnNUE3?=
 =?utf-8?B?YnFnczN6Tk10dy9HQjQ5VFdnTHZHL3hLRGtva3FjLzh1RGE4OVBxM3NhOWlD?=
 =?utf-8?B?TGJmT0tPL1Y4ZisvZlVncUpLbjFtczVKMG9pVVB1WHZENzMxZFJLY3lNbDla?=
 =?utf-8?B?b2xNc0tzbm1DOUFNb3k0YitWSlZaaXk5UEhXNGZCdVBueWpUSHBmcWhyK2dS?=
 =?utf-8?B?TEhpeTV0QmdLVmo5WmNaR0xMSFljZSs1dWFjV1NoVkRBTCtvR2pDUXFnWjhn?=
 =?utf-8?B?S2J5T2h0QWtTZmVTSTNwTTRrNCtmMWR4NUo2RmJnUWpNdjIrRGJaMFNMdEp0?=
 =?utf-8?B?bWhyWXNKS2ZUZmEwZ0ZuTFM1ajRwY2hMOWUvb1Q1QWRFS213Ykc3ckxMR3Uv?=
 =?utf-8?B?UlRBWldQSmpaTE9pL1hGaW1EdmV1ZjJGMGpTZ0U0R2ZwVmNURUxkaDdpeVl4?=
 =?utf-8?B?eXZoa0FQK09aNzBSRHo4dHNOamh2NGliUjU0VEFFdGZ5Ym1KT1c2dnVoTkpv?=
 =?utf-8?B?Y2Q1anc0S1pLL0Myei9OcGY5ci9lbTdWZkw5SFNhMFFsR2FFUFdEMnRaY3Ur?=
 =?utf-8?B?YWZUcFFRUCsvTDdRWXphRlY0eG5vY2xwVXhTVkpDeTZNUkhPZVNBYUo0b2N2?=
 =?utf-8?B?aVQ2WmpzaGVaNTI5d2tUclFtUy9abFI0bDdHV3pTY0QxQkdvaWRWV0x0aEZX?=
 =?utf-8?B?WCtxRFI1cklQSGdyeElEUXc5QUxTZ20rM0IzS05iV0NONjNmYUVGSVQ1TXc2?=
 =?utf-8?B?QTE3RUFPL3ozY0VOWnFUK0Y0bUs3dFBqMUNhYmw1ZU9hWDdpVXNSNzVJQlZx?=
 =?utf-8?B?eVNOa0dJUHpIb2NlNkY5V1BmMDY1MzhiK3lpK3QwdnBXd3JXUlBWQ3V6RjJX?=
 =?utf-8?B?ZTlVZnc3bC9XdWdvOUJneGxKMFFGZm8xcHoya3JZZGErdDBpQm1LUExxeTNI?=
 =?utf-8?B?NEVEOUNLcE9TZE5sMENRL2hhV3NaeDJURjVFU1g1bU02UnZneHJNazBVRFpZ?=
 =?utf-8?B?VTEyMmhWWFJ5LzltcXlXMW9yMVhTVEVoWGFHQjloa2VIK1RDR0ZqUmFVUEJi?=
 =?utf-8?B?SllST1dSQzc3NkxLZ1U1ZlVTeWFodjN3L0EvR0lCbVJNckd4RXo3RUFiclE5?=
 =?utf-8?B?eXBERHo5eDBHeDYyNWZ6aFhncTd6emhTNjh2bnlRdnVIMUFySTNXNmkxd1dB?=
 =?utf-8?B?aGxpMzlLMlh0MlNhcG1aVkdkNXAyVlRPczVuL2NjMUsyTWowcFVUODFBbkgr?=
 =?utf-8?B?a1hNRVRYbk4wcWlhZXlkNGVXb0dqRVh5N1RlUGpSODRSM0pWTlY4UjFQenNw?=
 =?utf-8?B?Y0ZiQXgwV2h1S1JocVFuMjFaRTRsb1dQS2ExVjR3STEyK1dIdkJOZDhnUHpo?=
 =?utf-8?B?U2lPRytXTkNEcTJoR3IvSmY1emFjOTZ0RzdEUENPRWdhNUVsWFhqSlI0Y3FY?=
 =?utf-8?B?eHdEcCs1VnNIRTRrUGNsK01LbHBtTC93c2s3Y0MrSE1qMDl6WXVXOVBJeGo0?=
 =?utf-8?B?eFE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 873ba479-faab-4897-171e-08dc10eab937
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 08:12:29.5207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uffQuhn4rzML+1rOMnu8/jJJUPAz12NMdtex9g6kEfGrG+g6zgFA6tlxrpVwh7HchKwgzD8+lIwAqDmI3F7hcETCiroD66tabkx2TTwtZpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0529

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCA5
IEphbnVhcnksIDIwMjQgMzo1OSBQTQ0KPiBUbzogQ2h1bkhhdSBUYW4gPGNodW5oYXUudGFuQHN0
YXJmaXZldGVjaC5jb20+OyBEYXZpZCBTIC4gTWlsbGVyDQo+IDxkYXZlbUBkYXZlbWxvZnQubmV0
PjsgRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgSmFrdWINCj4gS2ljaW5za2kg
PGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IFJvYiBI
ZXJyaW5nDQo+IDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBFbWlsIFJlbm5lciBCZXJ0aGluZyA8a2Vy
bmVsQGVzbWlsLmRrPjsgUm9iIEhlcnJpbmcNCj4gPHJvYmhAa2VybmVsLm9yZz47IEtyenlzenRv
ZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZz47DQo+IENvbm9y
IERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47IE1heGltZSBDb3F1ZWxpbg0KPiA8bWNvcXVl
bGluLnN0bTMyQGdtYWlsLmNvbT47IEFsZXhhbmRyZSBUb3JndWUNCj4gPGFsZXhhbmRyZS50b3Jn
dWVAZm9zcy5zdC5jb20+OyBTaW1vbiBIb3JtYW4gPGhvcm1zQGtlcm5lbC5vcmc+Ow0KPiBCYXJ0
b3N6IEdvbGFzemV3c2tpIDxiYXJ0b3N6LmdvbGFzemV3c2tpQGxpbmFyby5vcmc+OyBBbmRyZXcg
SGFsYW5leQ0KPiA8YWhhbGFuZXlAcmVkaGF0LmNvbT47IEppc2hlbmcgWmhhbmcgPGpzemhhbmdA
a2VybmVsLm9yZz47IFV3ZQ0KPiBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0
cm9uaXguZGU+OyBSdXNzZWxsIEtpbmcNCj4gPHJtaytrZXJuZWxAYXJtbGludXgub3JnLnVrPg0K
PiBDYzogTGV5Zm9vbiBUYW4gPGxleWZvb24udGFuQHN0YXJmaXZldGVjaC5jb20+OyBKZWVIZW5n
IFNpYQ0KPiA8amVlaGVuZy5zaWFAc3RhcmZpdmV0ZWNoLmNvbT47IG5ldGRldkB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPiBsaW51eC1zdG0zMkBzdC1tZC1tYWlsbWFuLnN0b3JtcmVwbHkuY29tOw0K
PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCAyLzJdIG5ldDogc3RtbWFjOiBBZGQgU3RhckZpdmUgSkg4MTAwIGR3bWFjIHN1cHBvcnQN
Cj4gDQo+IE9uIDA5LzAxLzIwMjQgMDg6MjUsIENodW5IYXUgVGFuIHdyb3RlOg0KPiA+DQo+ID4N
Cj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogS3J6eXN6dG9mIEtv
emxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiA+PiBTZW50OiBNb25k
YXksIDggSmFudWFyeSwgMjAyNCA1OjA3IFBNDQo+ID4+IFRvOiBDaHVuSGF1IFRhbiA8Y2h1bmhh
dS50YW5Ac3RhcmZpdmV0ZWNoLmNvbT47IERhdmlkIFMgLiBNaWxsZXINCj4gPj4gPGRhdmVtQGRh
dmVtbG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1Yg0K
PiA+PiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRo
YXQuY29tPjsgUm9iDQo+ID4+IEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IEVtaWwgUmVu
bmVyIEJlcnRoaW5nIDxrZXJuZWxAZXNtaWwuZGs+Ow0KPiA+PiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA+PiA8a3J6eXN6dG9mLmtvemxvd3Nr
aStkdEBsaW5hcm8ub3JnPjsNCj4gPj4gQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3Jn
PjsgTWF4aW1lIENvcXVlbGluDQo+ID4+IDxtY29xdWVsaW4uc3RtMzJAZ21haWwuY29tPjsgQWxl
eGFuZHJlIFRvcmd1ZQ0KPiA+PiA8YWxleGFuZHJlLnRvcmd1ZUBmb3NzLnN0LmNvbT47IFNpbW9u
IEhvcm1hbiA8aG9ybXNAa2VybmVsLm9yZz47DQo+ID4+IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJh
cnRvc3ouZ29sYXN6ZXdza2lAbGluYXJvLm9yZz47IEFuZHJldyBIYWxhbmV5DQo+ID4+IDxhaGFs
YW5leUByZWRoYXQuY29tPjsgSmlzaGVuZyBaaGFuZyA8anN6aGFuZ0BrZXJuZWwub3JnPjsgVXdl
DQo+ID4+IEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT47IFJ1
c3NlbGwgS2luZw0KPiA+PiA8cm1rK2tlcm5lbEBhcm1saW51eC5vcmcudWs+DQo+ID4+IENjOiBM
ZXlmb29uIFRhbiA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0ZWNoLmNvbT47IEplZUhlbmcgU2lhDQo+
ID4+IDxqZWVoZW5nLnNpYUBzdGFyZml2ZXRlY2guY29tPjsgbmV0ZGV2QHZnZXIua2VybmVsLm9y
ZzsNCj4gPj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7DQo+ID4+IGxpbnV4LXN0bTMyQHN0LW1kLW1haWxtYW4uc3Rvcm1yZXBseS5jb207
DQo+ID4+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+PiBTdWJqZWN0
OiBSZTogW1BBVENIIDIvMl0gbmV0OiBzdG1tYWM6IEFkZCBTdGFyRml2ZSBKSDgxMDAgZHdtYWMN
Cj4gPj4gc3VwcG9ydA0KPiA+Pg0KPiA+PiBPbiAwOC8wMS8yMDI0IDA4OjU4LCBUYW4gQ2h1biBI
YXUgd3JvdGU6DQo+ID4+PiBBZGQgSkg4MTAwIGR3bWFjIHN1cHBvcnQuDQo+ID4+Pg0KPiA+Pj4g
U2lnbmVkLW9mZi1ieTogVGFuIENodW4gSGF1IDxjaHVuaGF1LnRhbkBzdGFyZml2ZXRlY2guY29t
Pg0KPiA+Pj4gLS0tDQo+ID4+PiAgZHJpdmVycy9uZXQvZXRoZXJuZXQvc3RtaWNyby9zdG1tYWMv
ZHdtYWMtc3RhcmZpdmUuYyB8IDEgKw0KPiA+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9zdG1p
Y3JvL3N0bW1hYy9kd21hYy1zdGFyZml2ZS5jDQo+ID4+IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQv
c3RtaWNyby9zdG1tYWMvZHdtYWMtc3RhcmZpdmUuYw0KPiA+Pj4gaW5kZXggNWQ2MzBhZmZiNGQx
Li4zNzM3MTRmNmUzODIgMTAwNjQ0DQo+ID4+PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9z
dG1pY3JvL3N0bW1hYy9kd21hYy1zdGFyZml2ZS5jDQo+ID4+PiArKysgYi9kcml2ZXJzL25ldC9l
dGhlcm5ldC9zdG1pY3JvL3N0bW1hYy9kd21hYy1zdGFyZml2ZS5jDQo+ID4+PiBAQCAtMTQ2LDYg
KzE0Niw3IEBAIHN0YXRpYyBpbnQgc3RhcmZpdmVfZHdtYWNfcHJvYmUoc3RydWN0DQo+ID4+IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4gPj4+DQo+ID4+PiAgc3RhdGljIGNvbnN0IHN0cnVjdCBv
Zl9kZXZpY2VfaWQgc3RhcmZpdmVfZHdtYWNfbWF0Y2hbXSA9IHsNCj4gPj4+ICAJeyAuY29tcGF0
aWJsZSA9ICJzdGFyZml2ZSxqaDcxMTAtZHdtYWMiCX0sDQo+ID4+PiArCXsgLmNvbXBhdGlibGUg
PSAic3RhcmZpdmUsamg4MTAwLWR3bWFjIgl9LA0KPiA+Pg0KPiA+PiBObyBkaWZmZXJlbmNlcz8g
VGhlbiB3aHkgYXJlbid0IHRoZSBkZXZpY2VzIG1hZGUgY29tcGF0aWJsZSB3aXRoIGVhY2gNCj4g
Pj4gb3RoZXI/DQo+ID4gVGhlcmUgaXMgYSBkaWZmZXJlbmNlIGJldHdlZW4gSkg3MTEwICYgSkg4
MTEwLA0KPiA+IEpINzExMCBoYXMgdHdvIHJlc2V0IHNpZ25hbHMgKGFoYiwgc3RtbWFjZXRoKSwg
d2hpbGUgSkg4MTEwIGhhcyBvbmx5DQo+ID4gb25lIHJlc2V0IHNpZ25hbCAoc3RtbWFjZXRoKSwg
dGhpcyB3aWxsIGJlIHNob3duIGluIGRldmljZSB0cmVlIGZpbGUuDQo+IA0KPiBTbyBpZiB5b3Ug
YXJlIHNvIHBpY2t5IHRoZW4gYWdhaW46IE5vIGRpZmZlcmVuY2VzIGluIHRoZSBkcml2ZXI/IFRo
ZW4gdXNlDQo+IGNvbXBhdGliaWxpdHkgb3IgcHJvdmlkZSByZWFsIGFyZ3VtZW50cy4gTkFLLg0K
VGhlcmUgYXJlIG5vIGRpZmZlcmVuY2VzIGluIHRoZSBkcml2ZXIuDQpPa2F5LCB0aGUgZHJpdmVy
IHdpbGwgcmVtYWluIHRoZSBzYW1lLCBJIHdpbGwgZHJvcCB0aGlzIGNoYW5nZSBpbiBWMi4gDQpU
aGFuayB5b3UgZm9yIHRoZSBmZWVkYmFjay4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6
dG9mDQoNCg==

