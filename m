Return-Path: <linux-kernel+bounces-16267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A3B823BE4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 06:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC7F287E5D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 05:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5987318EA8;
	Thu,  4 Jan 2024 05:48:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2086.outbound.protection.partner.outlook.cn [139.219.146.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDBA18B00;
	Thu,  4 Jan 2024 05:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gqT+AlBJA9Z0u9ZvMetJHpTyN8oRCkABtusA6vtNxMcZiiJRbntAASR5Zqj74aO1FtPerf8xoaE/7qbM5c3ytbTtkShD/mImQVoyQiB2T6zVZeIM5+f71zD5a1vI+w8UbJh3aXKNtLSluLI4xjAu8yRjnwrr2cpnjn9uDOR15JaDM2sFd8PpgEvOeRr+1MQGobIZ+vf+YP0rtxV6e8qDSqPCx15mLvTqiswBYunpyDYJXJiXxxbI3hLBuXscLFOG1bp20cASoxEnF46LR+6S4jaA3yNH+mlAOnEY1DvRTuEUBSraLfzD65bbE43MJMp5FVbwC979XEVVwEE+Yc12TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpIlqX1F6oRIEE2HeyDQPUNE1uK+ZdFiOZnZJLQ/mDk=;
 b=XLvA1BXmkm7e8eSn7ixqXl/rGZ6OPys/5cn7l8r8T8OMmRBelAaKkpE11uK6WX1NAKq4s6Kemg4wN8vIwsJoBFiAo9VL76heLyDd1oz2eWClX+HrHxc5LWWFSETA5GrV/7KPBVkx8CBZV4qAKZTwq3V3PlYFceJ3y4TtLfF8XJdV96gdX7eBVhLRacoieLy3KmQpgBR7rJwtCmfbwsZ1sH3R5BwSehXCY8L5yqwAUvcuPaInD0QMK7HuZHMEV/Jc/sXxSjttIcnkRF6bcL1i/U3lyOeL7tJ5U+kkAM7sT3Yle5xtSvrswFVqrTUflyjvnBr+Lk7Wo3Sv4102nGM27w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.14; Thu, 4 Jan
 2024 03:12:31 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::bc6e:a7fa:7ab5:7417]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::bc6e:a7fa:7ab5:7417%4])
 with mapi id 15.20.7135.026; Thu, 4 Jan 2024 03:12:31 +0000
From: Yuklin Soo <yuklin.soo@starfivetech.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Linus Walleij
	<linus.walleij@linaro.org>, Yuklin Soo <yuklin.soo@starfivetech.com>
CC: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Hal Feng
	<hal.feng@starfivetech.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Jianlong Huang <jianlong.huang@starfivetech.com>, Emil Renner Berthing
	<kernel@esmil.dk>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Drew
 Fustini <drew@beagleboard.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Subject: RE: [RFC PATCH 1/6] dt-bindings: pinctrl: starfive: add JH8100
 pinctrl bindings
Thread-Topic: [RFC PATCH 1/6] dt-bindings: pinctrl: starfive: add JH8100
 pinctrl bindings
Thread-Index: AQHaM+jQtC6UubUli02XCaS05iYu97CzPUUAgAAeLoCAFbP3wA==
Date: Thu, 4 Jan 2024 03:12:31 +0000
Message-ID:
 <ZQ0PR01MB130273F2A3286849FB5BB0C9F667A@ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn>
References: <20231221083622.3445726-1-yuklin.soo@starfivetech.com>
 <20231221083622.3445726-2-yuklin.soo@starfivetech.com>
 <CACRpkdYL8wK2vX7P7p4QvU9VV2CPjRv_aXiLqO+07MMCCKKk4Q@mail.gmail.com>
 <6c861db8-f6cd-4e12-856a-ef45efc654a2@linaro.org>
In-Reply-To: <6c861db8-f6cd-4e12-856a-ef45efc654a2@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB1302:EE_|ZQ0PR01MB0981:EE_
x-ms-office365-filtering-correlation-id: 7c26bebd-085b-4543-d7fb-08dc0cd2fd48
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 K1Ldjc4x8GBitLIl5yNqAX6F7V5BPSOwwijz8yCF0rsHrDeBsqaYQ50L5dzOxwXRdc33zhH2TjmB6Pn8rpb2lFqH0n2m4Xcq58SywcBtRaD/vuA7L66k8Y91yY1bOj1Vw02En7owFsEWz8CBLxMHkhTtlKoNo3rCGk7/wF0M2+Q93AbT2G/uO0zuh9A3sC9ULh+mkts3EgoED163nd9eQQ1bVHGYaCirfQJKye2CZkPwtUxu/RGniWJ34AF4/ZDhww2uy1/Iw5jTEnw96nTXvU/deHwzCR+3lIteh0MMlNZ9RV6CAp7eJSnCfVy3o3t6glb5O2gXtGasVAv+d5Vpl10qf+73iS+2uPwh0A8Ltm6dK21iGf9+zxsqtAGYQahtaIvy5j99rtVF0JuIe+SbfEZOjUvxIyy3vcB3zfTpMHQdb4vhG/QSq0zdt4+xsSc9ZKorH/2oyU1b7J6kHyQdFU1ZdZlitd0CYkJJBl5zglIY4Hzwnlo9YymMHqqbWXiYXi9MMZptx0bigIY32J1NfKJcQMYfXHEh18eJYNIk7V6dnr6RwXGZaCBYWBeABXlt
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(346002)(366004)(396003)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(7696005)(41320700001)(122000001)(53546011)(9686003)(508600001)(66556008)(55016003)(71200400001)(110136005)(66446008)(4326008)(76116006)(40160700002)(33656002)(66946007)(54906003)(44832011)(66476007)(41300700001)(2906002)(8936002)(8676002)(83380400001)(5660300002)(40180700001)(4744005)(7416002)(86362001)(38100700002)(64756008)(26005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VTZtcVBzZ2xsOXdTbFFuQ1I2engvTVM3TWgzSG9aZTRZY1ZKSUY3dXd3N2g5?=
 =?utf-8?B?QVR3L1F0bEh4LzBXZ2FhSHI0Y3I2SWxRSlVKM3k5UWxpZVdRd2ZFZGNtTTdU?=
 =?utf-8?B?cUxrS05jRjk0VDFNRVFKek11bnBHaTBFVVNTR0FEWHR3bHZsMzN4ZVh1Rldn?=
 =?utf-8?B?MXB3OTljNkJzdkU0YW5EejUxc0Z2WG5kMUE3N3dpWE5JMnNTaGVBK3YyM3dw?=
 =?utf-8?B?elBnL2huWm9sUGNIcWkrSG9OM3czNG5FSGdDdC9yeWE2aGJGTENXZXcxSVo3?=
 =?utf-8?B?c1VvRENxZEFlUHNONzFhdTJZdGhoMFUrMVpNbHhBK1ZjZEhFZHJuNFgrd3pw?=
 =?utf-8?B?dFVrV0xub0ZpNFZnM3NhMmx3ZW95QzRyUFRNMTdpRm4wQ0haR1lBbWFQenJ1?=
 =?utf-8?B?Y1NBaThrMks0TFlDa1dEa1k4eTcxWlBLWGhsT0dqUGhWV3QvMzBFMlBCdllI?=
 =?utf-8?B?WHJNMGU1Sy9FNHJtanROQWJvNCtadVRCYzVrOXRaUVV4bk14UDBvWU4xS29S?=
 =?utf-8?B?OWdtQWhaaERCMDNJTGFpcWIya1NnV1hQZXUwZVFuNEpJVVVlZEIzNHBhZ3U0?=
 =?utf-8?B?Q0JrSEg2SS91YXpIdzdpcmtDYjBPWVFMalBRdGgvQXJwTlR0YXFpeHdkc2lu?=
 =?utf-8?B?Q3grUW93N3VXMmhoL0FLRkJOWDNKN1pCVTcvbGJkdWRQQTRZRVR2MEsyclF0?=
 =?utf-8?B?WDh3V3h4YUszNVBndmJ4cUFHb3pLYmVJVzNCdWo5Umo2YVlXb0duTnB1Njln?=
 =?utf-8?B?R2NjTnJDOWFaMXNFdWxuWk1HTlJMaWRmUW53alBDeFp4N2c1TmdRck50UVdU?=
 =?utf-8?B?aW5ZNk5yT2JDcXQvUWszNDVuV0E0djJCY21OZmo3TFpvR2t5T3JGQmlDaTM4?=
 =?utf-8?B?SFdHWjVOWVVCV2RiOHVpdXBRc2RzbFdldTZSMnJ3WE83cXR2OWlsVHVDbUFH?=
 =?utf-8?B?ZXd0TTR6M0JuMWJlMjJBUTZZUEc5Q2M4c0dvWDJBbURKcEpXMmpDWUd0UXBk?=
 =?utf-8?B?MG9DbTd5WkZyWXU3QUNXQUN0MFUvcGFYVUh2OTBBK01YOW92OFpXeGtscVVy?=
 =?utf-8?B?TnhFS0NYVVZXU1BrVXg1dXNLbEpiY1RBSDVoeUFnR2szTkNpdy9nQ1lPdmNG?=
 =?utf-8?B?QkVhT21EVHZNU0JRSGhWQVZLcTU0ZHc3NC93SFNwdS95RUpMZHlxNXJmT0ZR?=
 =?utf-8?B?UmRxMTFwS1pweXRQVGc3eXdaNEJGSld3VitCQ0F0ajkxbDkzQ1RjbVlLNmxY?=
 =?utf-8?B?a0dKY1NJa2JDOFYvM21zUGt2TVBvbzNLbzVqc3JFdWJLd1l3cTZIMnVVK3A0?=
 =?utf-8?B?TS9pNlVVZE9ITXFGcDNKWHExV2FLbE0zaCtYRmUzZ2w2VFhIMHB4QkdmUG5D?=
 =?utf-8?B?bURUTDNKNVM0WlJhTUc3dFpZZ0Y1UzhGcEk5ZS96am15VUNoNXZYYTU0MlNK?=
 =?utf-8?B?R3ZFcVVpYjdWWStKeTVPcmJyaXdid3dIRWNtWHM3TCtNOGlTMk9SUm50amJV?=
 =?utf-8?B?NW8rMURkMGNISFdOZDNsR2dFY2xNY2I1LzJiNE5TK203cXZWRFdjcERSalZL?=
 =?utf-8?B?QlZ6aGdoZ3JTU1lLTExKdDlob0pmeHVHQ1lYS1B0RDczb0paUmh0MnZEcWdT?=
 =?utf-8?B?d2pTMVRsbjdDcC96VEhpODdCUUVYTkdvcWpQVUhoMHJubTUyRG5JSjRUbmdv?=
 =?utf-8?B?SmIrQWJNMVNaQnJGY2tDN3Y2RVVtbS8rRERhR0RPc1RKNVJXV2dpeDhmelNI?=
 =?utf-8?B?bk1QR0hrMzYrWEUwQjlYbElseENlbzlVL3NUOS9ocXFDcWJ0RGJwaHg4WS9K?=
 =?utf-8?B?V285SWR1d1J5bnEzRzFPcGVjNkgyWlA3VUdkaDMwRFN6dGIwRFBDcDE1dC9L?=
 =?utf-8?B?S1J2dHdTTTJxSHovbWVweGVna05leFdhOHc2cyt2MVA3ZjhoK0czRjN5bFZD?=
 =?utf-8?B?eE4wR1lNeHYzV0o5Wk9qdFloMldyR1BtY0JZdEduUG5WNVR6NmMrdHQ3RTJ0?=
 =?utf-8?B?dEUyZG5USDJVUUxHb0k4NVBUVXd0dVY4SXQwVk55WjAvc2wwWlUrYzJNMCtZ?=
 =?utf-8?B?cGVRMWZmSFhTdFZ3S29JOFlUTTZJa0tvZnVNZVA5c1ZGdGZQVWwvTWIyZjVw?=
 =?utf-8?B?RUlMRU1PMUgzYUdhblMvdWZuNE55cnNXOGhaa3pzbSt6NjVmamJhbkRkcUw2?=
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
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c26bebd-085b-4543-d7fb-08dc0cd2fd48
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 03:12:31.1619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cEKQ+uOLOAEHkLcT55Gx70YbFwzFD35ObA+9pt22zX7vCC4K/udwhewuPMCfTag2jqYON3+7axJEWBIk1Zvm0cxm7XpMPt2rwNjlObJScKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB0981

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwg
RGVjZW1iZXIgMjEsIDIwMjMgMTE6NDUgUE0NCj4gVG86IExpbnVzIFdhbGxlaWogPGxpbnVzLndh
bGxlaWpAbGluYXJvLm9yZz47IFl1a2xpbiBTb28NCj4gPHl1a2xpbi5zb29Ac3RhcmZpdmV0ZWNo
LmNvbT4NCj4gQ2M6IEJhcnRvc3ogR29sYXN6ZXdza2kgPGJhcnRvc3ouZ29sYXN6ZXdza2lAbGlu
YXJvLm9yZz47IEhhbCBGZW5nDQo+IDxoYWwuZmVuZ0BzdGFyZml2ZXRlY2guY29tPjsgTGV5Zm9v
biBUYW4gPGxleWZvb24udGFuQHN0YXJmaXZldGVjaC5jb20+Ow0KPiBKaWFubG9uZyBIdWFuZyA8
amlhbmxvbmcuaHVhbmdAc3RhcmZpdmV0ZWNoLmNvbT47IEVtaWwgUmVubmVyIEJlcnRoaW5nDQo+
IDxrZXJuZWxAZXNtaWwuZGs+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6
dG9mIEtvemxvd3NraQ0KPiA8a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPjsgQ29u
b3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsNCj4gRHJldyBGdXN0aW5pIDxkcmV3QGJl
YWdsZWJvYXJkLm9yZz47IGxpbnV4LWdwaW9Admdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0K
PiByaXNjdkBsaXN0cy5pbmZyYWRlYWQub3JnOyBQYXVsIFdhbG1zbGV5IDxwYXVsLndhbG1zbGV5
QHNpZml2ZS5jb20+OyBQYWxtZXINCj4gRGFiYmVsdCA8cGFsbWVyQGRhYmJlbHQuY29tPjsgQWxi
ZXJ0IE91IDxhb3VAZWVjcy5iZXJrZWxleS5lZHU+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENI
IDEvNl0gZHQtYmluZGluZ3M6IHBpbmN0cmw6IHN0YXJmaXZlOiBhZGQgSkg4MTAwIHBpbmN0cmwN
Cj4gYmluZGluZ3MNCj4gDQo+IE9uIDIxLzEyLzIwMjMgMTQ6NTcsIExpbnVzIFdhbGxlaWogd3Jv
dGU6DQo+ID4+ICsgICAgICAgICAgZHJpdmUtc3RyZW5ndGg6DQo+ID4+ICsgICAgICAgICAgICBl
bnVtOiBbIDIsIDQsIDgsIDEyIF0NCj4gPg0KPiA+IE1pbGxpYW1wZXJlcz8gVGhlbiBzcGVsbCB0
aGF0IG91dCBpbiBhIGRlc2NyaXB0aW9uOg0KPiANCj4gT3IganVzdCB1c2UgZHJpdmUtc3RyZW5n
dGgtbWljcm9hbXANCg0KU3VnZ2VzdCBjaGFuZ2luZyDigJxkcml2ZS1zdHJlbmd0aDrigJ0gdG8g
4oCcZHJpdmUtc3RyZW5ndGg6IERyaXZlIHN0cmVuZ3RoIGluIG1B4oCdIHNpbmNlIHRoZSB1bml0
IGlzIGluIG1BLg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

