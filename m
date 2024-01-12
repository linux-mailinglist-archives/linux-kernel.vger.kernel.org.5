Return-Path: <linux-kernel+bounces-24896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB5182C45C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80BFF1C2236F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420B1175B8;
	Fri, 12 Jan 2024 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="oQkzuTeJ"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2134.outbound.protection.outlook.com [40.107.113.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BB8175A8;
	Fri, 12 Jan 2024 17:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joSRcwBfQsAVmzSAZUXdxHR/wsvhxlRbONnRR+MQdCZD3M4ILOHj5gKHjep0BrsekCafm2+AmyZaePX8qWgB1dmlEtAtyk49Tr9/47kwweFG0FNFgC3jnb+Op5fbdvnd9arHdu2A0TKu7R1tNTqqPNLUlqAEz7eXtnIDo8vB8bDnzFkz7+SxZpLqEeJf1d4QWfseI5wpTEF1cpo95bnSqmD+vP8MKS616NvzoXMWnNggOmKklSC7KH5PLZXdpwpX/wq0flm4JpR6KRkyIoMw8v9q3hP6uLLfSEiOp8IvY4Mt5N4qGoeE9R8Ddl+bbcyv+teG/SHNz3aqmXoBy/tPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IKbzjPtcoGnfI73zeMzXhasYoPWT1X0mK79ai/gfYw=;
 b=Aja4rajCDYxfZHMYUG635OVYdXSHsi1BZRpQ3PvP0ZXKrvzat1GHByFmmOgywtyAXu5EU03iRud07jLzBWXLKsuu92gApM7UNequMyaYmBq01/LjwG4UYFOiyFBKTdr6WF9N6JbKjfdn9C799ZW3j/Ib+iu6iGbaUuc1r9ykbsKkK5LVspDUngeJZGN7CZ76hKUjMWAkIhMBRK/Ca1cYMhKuWGAUofBf7rJAypbVFpLcHSjxdr6Qbktz1PBfDGkNTB9WfRjNfsN0Il70c8BhHPORQImwIbWHRad7/LuzLMbYeN0At+07uscMLLzuvKInOvmVzSXbdJ6fqbXMs+zxLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IKbzjPtcoGnfI73zeMzXhasYoPWT1X0mK79ai/gfYw=;
 b=oQkzuTeJkLsME8f0Xb4ThkPtACQnz+8r5MjC+aTwmUy9WtW2J2onzhscbreWHIp6/0aj8AtGK7AhSUhtDcrp+7WydQNxkIzl9RFk37wHt5s6PR/fBiJIYy3PsvcRipMDpcSO8wjE8nnQB9MnY5BAFkJV18fB1FbbD/cp/blt4M0=
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 (2603:1096:400:3c0::10) by TYYPR01MB8183.jpnprd01.prod.outlook.com
 (2603:1096:400:fe::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.14; Fri, 12 Jan
 2024 17:10:40 +0000
Received: from TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::8d12:a02a:9fdc:9c78]) by TYCPR01MB11269.jpnprd01.prod.outlook.com
 ([fe80::8d12:a02a:9fdc:9c78%5]) with mapi id 15.20.7202.014; Fri, 12 Jan 2024
 17:10:40 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm
	<magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v4 3/4] pinctrl: renesas: pinctrl-rzg2l: Add the missing
 port pins P19 to P28
Thread-Topic: [PATCH v4 3/4] pinctrl: renesas: pinctrl-rzg2l: Add the missing
 port pins P19 to P28
Thread-Index: AQHaRWNYeOFbn4ZS1k+YsSHgigQSfrDWPJeQgAArzwCAAAEmsA==
Date: Fri, 12 Jan 2024 17:10:40 +0000
Message-ID:
 <TYCPR01MB11269F75A63DB020297DF21DA866F2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20240112142621.13525-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240112142621.13525-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TYCPR01MB112699FAB53E6E4647893516B866F2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <CA+V-a8smkiub9ACDsqxv0z8yF_iLVEXG2OHwS7iJ+tmsdmTQ6g@mail.gmail.com>
In-Reply-To:
 <CA+V-a8smkiub9ACDsqxv0z8yF_iLVEXG2OHwS7iJ+tmsdmTQ6g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11269:EE_|TYYPR01MB8183:EE_
x-ms-office365-filtering-correlation-id: 87c00cef-0f67-46dc-a6cf-08dc13916777
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RP4IIwB4leWBa5JwKLINqY0W/3T1ftiap5grg4iGa1jLXSZd8oPaABV58U/n6fIJz/ZPwzqCIvM44+Tgg+Tn2gxAc2cSiH5MKHvyvVjtI6ixgR0p5XGeeWzup43Pgdt44by4EPGH5NHSuxi9SRzoHxkh+Qr0L/aKnrYqxidWrc7aPz85lkiHI13GBUzJjKOktGxzTUkemo5OeuM6N8Trq55otK0rgKsFYsnCI7Gt4m8x/CSYEmYLqdplF2HHr+46n/2tCfdLeKzW5mP9udT/tXXOucB7BvR7RszJekoSBNUkzRn8klE6HsoSP8hLfy7OjNu1TVZ+3CWepSvgX8aoeHSn2FDcVf/VzNqsEnpKH3CE4V2fH4LSHDQCHLZgi8PXJeR0fMX8OpLsnQjFk+NLwNt8tXRiRR9D5AIBuovEHPrJHT77NOuclI4EksFb5RMEPwH9st7OBGO2M5bL6hkbJLrlA4BP0Vpbqhx22yqSzslbf55vTst5lM4STi9oyqaZBpL+jixVVpV5KVunDSNqc5njfwR6pTGXhadaPzPUBKCyvDYrq63HaC8wUPOUfQNmhI25tpLEQ9z4Feu5+UgiCPM1ZoZ4dSI61C1lkkLpfGeF09IwNUldEv6GvqIyvsYD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11269.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(4326008)(7416002)(5660300002)(2906002)(52536014)(8936002)(8676002)(66946007)(64756008)(54906003)(66556008)(66476007)(76116006)(6916009)(316002)(66446008)(41300700001)(122000001)(38100700002)(83380400001)(86362001)(33656002)(55016003)(71200400001)(478600001)(7696005)(9686003)(6506007)(53546011)(26005)(107886003)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0JZVk8rR0h1OTZrTFVNQ0tjQlFQQVViREdkVHBpZEw2SSs1T1NSbDd4Qjhl?=
 =?utf-8?B?VzNveEZsUTduRTZvaUhOUkJSSExlL3ltMSsrUGR6ZlJqL0NaQTVxTCs1Rzlq?=
 =?utf-8?B?RXRrNEZhVllSZFJBNW12TmJqWldyRktZQWg5UW5NcmlMMDQ1UXcvWnhFWWJQ?=
 =?utf-8?B?bG5lUmFBNU9qYk5LOVNMTEF3eDZzZVVMbXdrZGNvRDhJSHoyeW5ROENxK01D?=
 =?utf-8?B?MmE0ZmVuNTY4Tk1yMERSeGM2ekNkcWt5TC9PbkZQdVVuSXlMNFhwQlNQOXlx?=
 =?utf-8?B?YWpvVW4yYTRJQXU5bmhmUDF0UlZmRFArd3g5VE1TMS9hU2doeEZ3MVl6VUMw?=
 =?utf-8?B?SXBGQ0RmZ1pJSDA5VXI5eFJYa1NQc1pOTHFNUkhvS3lVOXJFbmx3d0RVUzRa?=
 =?utf-8?B?UXhaNzZwekhtUzFxVzRjK3h0SElvRmVTODFmNHpnbDZQblV2a1RaaTJOZm9n?=
 =?utf-8?B?bGtGZStJcjBOVTZqelJ3R1VXQnJUZzNMVHlhMkxNNVVDME1lYTdUSjhwNHQ0?=
 =?utf-8?B?YUkrRTJRdnFlSGpLd1NiWHF0U096TXRwOVlkUVRoc2cyN1FpOEVIK2xFak5N?=
 =?utf-8?B?WEhraVNJWWJDTE1UZ2hhZkQ4elA0WHB2dkpqUHI3RWxOSTdRRzdBMGJxQlRj?=
 =?utf-8?B?U3RBdkpDOURDSEMraVdvY2kwNDJKN0Z5STBLNWVva0pvY0pwZXJoMHROSjUy?=
 =?utf-8?B?WXNEYVMvUDFGTzRpTkJhQm5oSzIvNXppdXF4M0JuclNMQmJLZ1Z5N3pIT3lw?=
 =?utf-8?B?VjIyeGg5VG15ZUJjOWo0RGIySTdWRTRnaVI0b1RtclJNTFB1b09qN25oSHZV?=
 =?utf-8?B?bTNQenN6VytvSkVaZStHdUhTTmU1dmlVSm1xclRGc0h6NUQ5MFMyVEhSL3ZV?=
 =?utf-8?B?R0J4Q3pDa3NnbVVUMHRZYnJIS0Uwajk3QW9Oa25rZzZCYWk4Vlo2UXpYck5k?=
 =?utf-8?B?d0UzSzhhc2FRM2p5d0dFU3RaSEloclVqaUUzeWRRQ1FQaCtyNVIrN3NTZlBs?=
 =?utf-8?B?ZUNub0xxUUwvZmowaThGV2xTOHljR0Z0YWQ0YlEzVG1OSFZ1eUx6ZEpXQnJ6?=
 =?utf-8?B?RmY0NUZBdDRnbE42ZVkyM0QydldEUkZYeUlER1FYeUNwSFpsZ2tORzFnR2xh?=
 =?utf-8?B?RGZyOCswb3p1Unc1VzZlL1d1YmFyOUJSODlaaDZhSDk2Qk91WHAzd1NqM1Bt?=
 =?utf-8?B?TmJXNDBZQTBIUWhTYnRMMWxXVmhVRjZJSk5qNVVhYVpTeURaaU5FVTh6ZTBU?=
 =?utf-8?B?MC9GYU4xdlpnRXJYZFd3S09ITzB0Sk01cDcrWE5XeE8zRE9LSitzMmxIVDdZ?=
 =?utf-8?B?YS9yZjZvT2d3YUlIZ1BwaVNVUTIwUkpJby9GRFFqdndnYTI3K01aU2RxQ3NP?=
 =?utf-8?B?QkJzR2x3aEVqNkx5UUZES1JNV3VrSTZXUmJra0dKdTJLT2lyaXBKQm9jS0gx?=
 =?utf-8?B?ZW10QVR2YjZXY1ZFRzIyL0FDTWxQL0N2N3NQQkliUVE1SjhtTWNLaWlZUVQ4?=
 =?utf-8?B?bkpnYVpkR2szdGlTUVNQMWtlcThNZWlWZXViZ28rSGUvQUppRUI1QzVyL0ls?=
 =?utf-8?B?LzY3NGZFWm02Q0hOeUljYWdQMTg2czFnS3hxUGVwRER2a2xFNkNiVlFucExJ?=
 =?utf-8?B?MG45S1BndVV6TWt1a0EvWmJ6NTZHMWFsemswMEUyMHo5WSs1bnJlcHJwemtT?=
 =?utf-8?B?RmhRT1VnSWJwa0NWcmhLL0VZZEZwdXdKa2FMQm4zSUJBK0hQa2E1ZmFhRTlT?=
 =?utf-8?B?NGIxRVg0V1dPekc5OWxtWkgzZjBSK3JZRzVlblNTR3pzcW5wVkFjYWoySm9a?=
 =?utf-8?B?c0VZa0s3REJVOVFjc3grQTB6dGkvUUpXS29HbG45V2JDL3NzVVJUSk9kQmt2?=
 =?utf-8?B?NlpSZnlvT3V1dW52YUw2MGVEYThWY1BOcTRQam5pTDVLL2hRenBHUjdsM3lw?=
 =?utf-8?B?bjFHRmYyeUIxZjQ3UTlxZ2NHbmQxSkdwNkgvdk9CNGE4Smd4R0pZY2cwaFdu?=
 =?utf-8?B?cGpwbU5Vcm5yU2xaUXdIWThPVXY3RkRScUdsZ3N5RFErRG9tU3JhQW5jM1dw?=
 =?utf-8?B?cnpZRjlQYk00bHZEV043Mk5SR2pUcDhoT3pEVTNDNUIrSndjSkpQZGZNSU1o?=
 =?utf-8?B?aEF6M2xESWNHbkloME43eEdHK0YrUEJOaTFFNklIVHlmRUo5ZlBaUU5sRnI0?=
 =?utf-8?B?NFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11269.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c00cef-0f67-46dc-a6cf-08dc13916777
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 17:10:40.6658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YnvA3J9xbjYS53i8TPuW3BBqzkVzMXFQjQa1Yu8jnh8QO3pfPh1htyzAMoHVJ4HASXMFaR/FP9ucm+6GZb5lYO77/3P9Hn8y/vR6m94srSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8183

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGFkLCBQcmFiaGFrYXIg
PHByYWJoYWthci5jc2VuZ2dAZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXksIEphbnVhcnkgMTIs
IDIwMjQgNTowNiBQTQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDMvNF0gcGluY3RybDogcmVu
ZXNhczogcGluY3RybC1yemcybDogQWRkIHRoZQ0KPiBtaXNzaW5nIHBvcnQgcGlucyBQMTkgdG8g
UDI4DQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3Lg0KPiAN
Cj4gT24gRnJpLCBKYW4gMTIsIDIwMjQgYXQgMjozMeKAr1BNIEJpanUgRGFzIDxiaWp1LmRhcy5q
ekBicC5yZW5lc2FzLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+IEhpIFByYWJoYWthciwN
Cj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFByYWJo
YWthciA8cHJhYmhha2FyLmNzZW5nZ0BnbWFpbC5jb20+DQo+ID4gPiBTZW50OiBGcmlkYXksIEph
bnVhcnkgMTIsIDIwMjQgMjoyNiBQTQ0KPiA+ID4gU3ViamVjdDogW1BBVENIIHY0IDMvNF0gcGlu
Y3RybDogcmVuZXNhczogcGluY3RybC1yemcybDogQWRkIHRoZQ0KPiA+ID4gbWlzc2luZyBwb3J0
IHBpbnMgUDE5IHRvIFAyOA0KPiA+ID4NCj4gPHNuaXA+DQo+ID4gPg0KPiA+ID4gKy8qKg0KPiA+
ID4gKyAqIHN0cnVjdCByemcybF92YXJpYWJsZV9waW5fY2ZnIC0gcGluIGRhdGEgY2ZnDQo+ID4g
PiArICogQGNmZzogcG9ydCBwaW4gY29uZmlndXJhdGlvbg0KPiA+ID4gKyAqIEBwb3J0OiBwb3J0
IG51bWJlcg0KPiA+ID4gKyAqIEBwaW46IHBvcnQgcGluDQo+ID4gPiArICovDQo+ID4gPiArc3Ry
dWN0IHJ6ZzJsX3ZhcmlhYmxlX3Bpbl9jZmcgew0KPiA+ID4gKyAgICAgdTMyIGNmZzoyMDsNCj4g
PiA+ICsgICAgIHU4IHBvcnQ6NTsNCj4gPg0KPiA+ICB1MzIgPz8NCj4gVGhpcyBpcyBkb25lIGJh
c2VkIG9uIHRoZSBmZWVkYmFjayBwcm92aWRlZCBwcmV2aW91c2x5IGJ5IEdlZXJ0IFswXS4NCj4g
DQo+ID4gPiArICAgICB1OCBwaW46NTsNCj4gPg0KPiA+ICB1MzIgPz8NCj4gPg0KPiBkaXR0by4N
Cj4gDQoNCkFzIHBlclswXSBzdWdnZXN0aW9uIGlzLA0KDQpBcyBjZmcgb25seSBjb250YWlucyB0
aGUgbG93ZXIgYml0cyAoUElOX0NGR18qKSwgSSB0aGluayB5b3UgY2FuIGZpdA0KZXZlcnl0aGlu
ZyBpbiBhIHUzMjoNCg0KICAgIHUzMiBjZmc6IDIwOw0KICAgIHUzMiBwb3J0OiA1Ow0KICAgIHUz
MiBwaW46IDM7DQoNCkNoZWVycywNCkJpanUNCg==

