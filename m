Return-Path: <linux-kernel+bounces-72821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0357F85B8FD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 276C21C22478
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA31634EB;
	Tue, 20 Feb 2024 10:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="BINvbA+w"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2096.outbound.protection.outlook.com [40.107.104.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F2A627F3;
	Tue, 20 Feb 2024 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424811; cv=fail; b=bedfyRxg4Xj+xRGVj646lHWuv4RPGeQyG4A/LWXNRXfV7GlLymSCIDMU+8qy+APoRkhEVC/rlTaqESjdlvVjxM6E9bfnM8IRxVmyeYYpU3WZhwugdLkNBfVmewfW7ud5nVKILUDsznZmgKsXcXow6RwNKFInLEkVWvVYO8+Wn7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424811; c=relaxed/simple;
	bh=OeJll9x+89WzqLxiVrl0RC01pWEQhVnzmX1mALO1PjE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rED3O9B5oCZgbBtp/LypjCCQmGMrft4/mcoL7stcvjPCWlwd59owQzgycxaHucSg5TefaDXRdI+1DX0mHHFqDSpDjwNsVlsU+/FIG1q05sfF3D2jt8JJ7cW0XAxnhWCdEovEkDv4wgBVmlMVh3gbU645xwqB9uxRNZxXybQggX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk; spf=pass smtp.mailfrom=bang-olufsen.dk; dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b=BINvbA+w; arc=fail smtp.client-ip=40.107.104.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOfX4ypxSBQ6tns2Wu0vIhx+jDQZMwJGAfm7XNWKbXW/MUbVDubM6PGxKaRkxF+6SqvE2lGSPG8w72zuQbag3lsCHKy4zi3V6khaDQ17pK66KsfknpOqlyqWpfR+z73STaQnxNfC2ActeLhjEdMOFjHKW5QIfz+IXWwXh/02pE8hZSNAMPp0Yx0jr24IC9E2Wmy5rvV/60Sqy3VFkjwGxq7atbAlbLVlu6eQ0KRi7oRllyERNAszrZYP1Vh3LLa2s+iOQ7Z/Ej24LL4VL2Pb5eGGsqb5Ns3TkOeKnDJZ8qf01vPpF1bHeHDwxa6j12lRyAQa+53XNNSvzWiC8aNKOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OeJll9x+89WzqLxiVrl0RC01pWEQhVnzmX1mALO1PjE=;
 b=hqr+Q2NAEzoxay+GeccJC1TGxnzrTsjEggp5gReujdnRzd1U0ydDzXXoqxVsHSf13YxBjql4Bz7MscVw1DOvgEly9fkl8kQldboqNSqUQYhv2vSd/uPiVPBOU2LiJ5djrv1zqZWUQkdPbixsUbqAL40HKNWt50hMsQccM03SpdyXgecWvA43TP8JH8ii3Sj9jRMjTLM7NH8isrlhqtwWWqnoD9woGvgXnionsLzia1QAmN3plRGYoSj6uaufOeJq9gseIVY7Mj9+0G6lAOIJctSs1tWdIAxp1w4jyVn8xkBj9q6MREEM9f5jK/sSAe2GDgYoRAKJe6XJzsofN0vWNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeJll9x+89WzqLxiVrl0RC01pWEQhVnzmX1mALO1PjE=;
 b=BINvbA+wsD8q83X3Ez5SVb/vZ4jQBA1ypVSoC4br/7i7I6kgK8ZxlnWkFveHWGZ7TBHPfDN1mqfVrrxBWPUxrqtZCR/L/WUWSbmVh+MkzQEpmYp7JNOl67EbD/8Ylx7e/gU8GiZ+DzFyuXGTEuEnNVl9CEp9it7EfLzbTwDdOH8=
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com (2603:10a6:20b:53e::20)
 by PA6PR03MB10322.eurprd03.prod.outlook.com (2603:10a6:102:3d5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 10:26:46 +0000
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::3c77:8de8:801c:42a7]) by AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::3c77:8de8:801c:42a7%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 10:26:46 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
CC: Linus Walleij <linus.walleij@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/3] net: dsa: realtek: support reset
 controller
Thread-Topic: [PATCH net-next v4 3/3] net: dsa: realtek: support reset
 controller
Thread-Index: AQHaY42tH0aJAWy/AU6VqyhRW8ot+rETB3+A
Date: Tue, 20 Feb 2024 10:26:45 +0000
Message-ID: <lvt7su5mmf7b3w4gbxd6vlt25klsyziuuaznfzjy7d4oxz46qx@4dzc4cgmfkbc>
References: <20240219-realtek-reset-v4-0-858b82a29503@gmail.com>
 <20240219-realtek-reset-v4-3-858b82a29503@gmail.com>
In-Reply-To: <20240219-realtek-reset-v4-3-858b82a29503@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB8805:EE_|PA6PR03MB10322:EE_
x-ms-office365-filtering-correlation-id: 0b654a2d-c228-43ec-62f8-08dc31fe7087
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pl5vg3IPNAMIJP2LSf8c/YnOIJZ7LOlvHg/ApIi7dhdKYaFDLlKtSqZHpO3Yjq0qy86Y4CD7vPhd7UT47cZcmLJMF6N0DVTu2hNJT4HGb+yTwdMF0BEQkYbGEmjsYlMmtUlju94rC2oRkCTf3qukl89tz6GQoaRi7t6mQufNTh9eRHJcciZohy6PSHfb/R3Zhz4X2KOyr7SMzPBQpb5jSTrpTREQBahE9nTEFwf9iBSt48NAcJAb6nOZhEE9RX2Eqj9byQXFA9PSOAtlO2SM9zG6mu5Ur1JTLjWM4Bdki9hY3iZxjcsnrhNusY3VVvQpZ/worJSHWcF5jUhYkTfkGxj6mB6ht9HYSJJacTsWT9xotkEOxANYmnC9vzEu55Ls2M+1CsPtaj7pOZTCwRAhFUqsn210BM7dHIHLLncZeYw13Uuy0h1UZL8VEhQt20O/4SCk50qb18YtOZ0gUDC3z04pEPIL6T1k7kPJ6ikklAcjKbTeDj8Z8FPGQmc4F2eF6ov+PNbvTSujCr/dzz4Ej5L1YdJFOMKB/3xplmv7ZQ9bDUHKIdrS/6ZSB4zkiy0owUGiq/xmGIpxxybH+GSZvoW/8pTKtxjTUQR7fpuOWqw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB8805.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejZ2TGJTdHVpU0ErQ3k3OGY3ZGNyQlg3dnIrbG1hS3RMUWVHRmIvdFFGcXhz?=
 =?utf-8?B?MFJiUDQ3Y2dwN0gzSFNBOVNHMFlhZEwwRXQzL0ZyV2I4MnlxMHdUcHV5dU9s?=
 =?utf-8?B?UnFFbXd3QnVua2d2a2tlS2trRzVXcGNvd1h6dEVuc24vQTltRDk0bTlKUWJk?=
 =?utf-8?B?NHhLUG9TTVJTKzY4Zkc4dVlHRFkvWlh1dnpPejFKdThnNFpiTmlVcm5wR2VQ?=
 =?utf-8?B?dHY4MktjNjB2dDRlMVNnWWY2RUFXN0xCeDZOWHlMcTd2djRsYTg2Ryt0c1Uv?=
 =?utf-8?B?dXkvMVIreFFXYW1rQmVhdXFWYjc2dzE2aWxTWXkycGMxVmNqR2pneTZnN0Q4?=
 =?utf-8?B?MlBDYjRVZFIvZkFwNnc5eGt0SmQ4TUVmZFo1bnhsd3Z4b2VudVNCcWRIT1Q3?=
 =?utf-8?B?SWRMMXQvMnRnN085YnI4MEc5bHlrcXNnekFFbXdqMENLRG1NRUdXYjNDdjZx?=
 =?utf-8?B?S0dlTGlOMU9ZcFRTcEtjckh3S1hFUmJYblJYbmw1emoydEtvUitpc2xucTRI?=
 =?utf-8?B?eUw4eEFIMURLMWxTVVE2WHcvMEp2QktzOGJuUTFMT25xOTBNQlVVbFdnMnlV?=
 =?utf-8?B?RGV4Z2hMaE5rMStpdXVwOHVuOW5VNUNHakIxbjJrUGJIRWVyVXg1WVM4M0I5?=
 =?utf-8?B?bmRSbnNJZVdKSzg0c1R2TTZ3Zkh6RUVJVTVXSy9UYStKTlpYYkdqTmdBc2JZ?=
 =?utf-8?B?cGlhejd1YjFxWGlNQTRNVXZjTE1iSTJNbkxNOFpBZ3ZMaU1wQUFuOGFMbTRa?=
 =?utf-8?B?ZmFhVUtOZFVyWWgwTTh5L0JxSG1CSC9sN1hWYWM3NUJkZDkxK0U1VnZ5Sndh?=
 =?utf-8?B?NHN1ZzIrOVdWeG1tckRvWGdlSkkxYS9kbm50ZHZTSlEvcFlrVEtURHlmalp3?=
 =?utf-8?B?Sm81RjNlTnRmYmNTbTNuOEpnOGpsNmVCUzY0bnc2bnZrWkp1OW5id3VUV1Fm?=
 =?utf-8?B?SU51UDJmSGdwcFpKeHhockRwOXhUc2xkb25yNTRVcjViamxGUUM1a3B2TzdH?=
 =?utf-8?B?YjFoODlpWEVpdmg1cEZ5OHRxM0JKWEttRHpuRVFheTlCSXo2RGkrVGVIanlW?=
 =?utf-8?B?cjBQSWx3bThWdDgrakZ6UjIwaWFuZmNvWFMwQy9ZV2QxUmkzN1U0Q1o0SFZN?=
 =?utf-8?B?cDdZMGFKWGZja2IvcXR0V3Q0VXFhMXJHVkkvZFdUZk5IbzJjZlo3TWpKM0tL?=
 =?utf-8?B?RWRKQTF6UUJqd2pTSVJHYU0yeTBqdzhTVU1leTBRYitsYjlKT3FZVlhjZW02?=
 =?utf-8?B?aXEyNGtqbkVmYWxvNnpsaWUvZmVPL2NndHdYUmNWVG1pM0ovNWtwQ2ZmRzAx?=
 =?utf-8?B?T1VzUnBtWGpBQlQ0NE81RlFoRURDL3NUa3R5MC9MZkZNRDZVaGNIL05sUFVE?=
 =?utf-8?B?c0lDSlUvYlVmcVRKdUt6RTV1eGFUL3doM2x3ZjFEbi9PdmZ0eDdFM2lPZkky?=
 =?utf-8?B?Vm95YTBCa0FXWUdqaVVVMG4xcDlJMERGNXZCeFNvRytTWlpseWFWNHBaMWMx?=
 =?utf-8?B?WmtCSko3TExpbjFEeDY0VTF3L0xzd0tOcFUyZHFKVjJVN29vSmlnUkR4dkZi?=
 =?utf-8?B?cU5paU13aGUxcTZ1REtNWXJmYnMwODVMRUE1bUVPSDFQT1hSWk1CdnJPZVZ0?=
 =?utf-8?B?dEpVRWpqc0NscUlRQlQ2U0FtVXh4NFBuSjNvV3haSFVGZnEvT1Vaa2hkMEk4?=
 =?utf-8?B?UEp1WUlpRnoyenpjZlpHY3J5QyszVVBkSzZhR0lROGdBRXJpSkN0elVlYkNT?=
 =?utf-8?B?dTZiN29sMHUwNkxvZk03YVgzWk5mam5PQTJkakVKUE5xMzRsQzhjR1F1bEY0?=
 =?utf-8?B?dWJneTNYQVZkdGdjMGxDTnJYcGpsK3A5eWpZMk5xSWF5b1dZYXZwTWltV2xE?=
 =?utf-8?B?UzVxQUxMS2ZBNytrL0ptbS9Dc1pKSkR5bDd3bWREYWdPS3VES3BRYW9qUHRw?=
 =?utf-8?B?WWF0TTdydStobm9EMDFmdnc0cjIxK2lJTlA2WGREY2gxcENMVU94RkhmMDNH?=
 =?utf-8?B?MHd5elBNSWRWbnhLVGpVYTFaam4zTzAwYWMzdm9WaFhYaHZnUW9tWkFQKzVR?=
 =?utf-8?B?dFZJZGxNM1FCTVhxNUpZbTVxUEg1czQ4Tjk4Q3R0aWM2UFc0K2RVekhpSjYv?=
 =?utf-8?Q?PuDlzRnmfRExcDLEbQvMj29Js?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18D6C47CB7CACB418A1C8552E26A5761@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB8805.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b654a2d-c228-43ec-62f8-08dc31fe7087
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 10:26:45.8843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ziQuzRNa339lgq/JDOiEZnYqvj56LZ2IpjnrnXsDDRc3PCJ1odg7BsPxvATWrwjbMvOizX6R1rbcyk3OUV2cog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR03MB10322

T24gTW9uLCBGZWIgMTksIDIwMjQgYXQgMDg6NDQ6NDJQTSAtMDMwMCwgTHVpeiBBbmdlbG8gRGFy
b3MgZGUgTHVjYSB3cm90ZToNCj4gK3ZvaWQgcnRsODN4eF9yZXNldF9hc3NlcnQoc3RydWN0IHJl
YWx0ZWtfcHJpdiAqcHJpdikNCj4gK3sNCj4gKwlpbnQgcmV0Ow0KPiArDQo+ICsJcmV0ID0gcmVz
ZXRfY29udHJvbF9hc3NlcnQocHJpdi0+cmVzZXRfY3RsKTsNCj4gKwlpZiAoIXJldCkNCj4gKwkJ
cmV0dXJuOw0KDQpJZiBwcml2LT5yZXNldF9jdGwgaXMgTlVMTCAtIGkuZS4gaWYgbm8gRFQgcHJv
cGVydHkgaXMgc3BlY2lmaWVkIC0gdGhlbg0KdGhpcyB3aWxsIGFsd2F5cyByZXR1cm4gZWFybHkg
YW5kIHRoZSBHUElPIHdpbGwgbm90IGJlIGFzc2VydGVkLg0KDQo+ICsNCj4gKwlkZXZfd2Fybihw
cml2LT5kZXYsDQo+ICsJCSAiRmFpbGVkIHRvIGFzc2VydCB0aGUgc3dpdGNoIHJlc2V0IGNvbnRy
b2w6ICVwZVxuIiwNCj4gKwkJIEVSUl9QVFIocmV0KSk7DQoNCllvdSBvbmx5IGxvZyBhbiBlcnJv
ciBpZiB0aGUgcmVzZXQgY29udHJvbGxlciBhc3NlcnQgZmFpbHMsIGJ1dCBub3QgaWYNCnRoZSBH
UElPIGFzc2VydCBmYWlscy4gV2h5IHRoZSB1bmVxdWFsIHRyZWF0bWVudD8NCg0KSSBzdWdnZXN0
IGtlZXBpbmcgaXQgc2ltcGxlOg0KDQp2b2lkIHJ0bDgzeHhfcmVzZXRfYXNzZXJ0KHN0cnVjdCBy
ZWFsdGVrX3ByaXYgKnByaXYpDQp7DQogIGludCByZXQ7DQoNCiAgcmV0ID0gcmVzZXRfY29udHJv
bF9hc3NlcnQocHJpdi0+cmVzZXRfY3RsKTsNCiAgaWYgKHJldCkNCiAgICBkZXZfd2Fybihwcml2
LT5kZXYsICJmYWlsZWQgdG8gYXNzZXJ0IHJlc2V0IGNvbnRyb2w6ICVkXG4iLCByZXQpOw0KDQog
IHJldCA9IGdwaW9kX3NldF92YWx1ZShwcml2LT5yZXNldCwgZmFsc2UpOw0KICBpZiAocmV0KQ0K
ICAgIGRldl93YXJuKHByaXYtPmRldiwgImZhaWxlZCB0byBhc3NlcnQgcmVzZXQgR1BJTzogJWRc
biIsIHJldCk7DQp9DQoNCm9yIGV2ZW4gZHJvcCB0aGUgd2FybmluZ3MgYWx0b2dldGhlci4NCg0K
PiArDQo+ICsJZ3Bpb2Rfc2V0X3ZhbHVlKHByaXYtPnJlc2V0LCB0cnVlKTsNCj4gK30NCj4gKw0K
PiArdm9pZCBydGw4M3h4X3Jlc2V0X2RlYXNzZXJ0KHN0cnVjdCByZWFsdGVrX3ByaXYgKnByaXYp
DQo+ICt7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCXJldCA9IHJlc2V0X2NvbnRyb2xfZGVhc3Nl
cnQocHJpdi0+cmVzZXRfY3RsKTsNCj4gKwlpZiAoIXJldCkNCj4gKwkJcmV0dXJuOw0KPiArDQo+
ICsJZGV2X3dhcm4ocHJpdi0+ZGV2LA0KPiArCQkgIkZhaWxlZCB0byBkZWFzc2VydCB0aGUgc3dp
dGNoIHJlc2V0IGNvbnRyb2w6ICVwZVxuIiwNCj4gKwkJIEVSUl9QVFIocmV0KSk7DQo+ICsNCj4g
KwlncGlvZF9zZXRfdmFsdWUocHJpdi0+cmVzZXQsIGZhbHNlKTsNCj4gK30NCg0KU2FtZSBjb21t
ZW50cyBhcHBseSB0byB0aGlzIGZ1bmN0aW9uLiBKdXN0IGRlYXNzZXJ0IGJvdGguDQoNCj4gKw0K
PiAgTU9EVUxFX0FVVEhPUigiTHVpeiBBbmdlbG8gRGFyb3MgZGUgTHVjYSA8bHVpemx1Y2FAZ21h
aWwuY29tPiIpOw0KPiAgTU9EVUxFX0FVVEhPUigiTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVp
akBsaW5hcm8ub3JnPiIpOw0KPiAgTU9EVUxFX0RFU0NSSVBUSU9OKCJSZWFsdGVrIERTQSBzd2l0
Y2hlcyBjb21tb24gbW9kdWxlIik7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9kc2EvcmVh
bHRlay9ydGw4M3h4LmggYi9kcml2ZXJzL25ldC9kc2EvcmVhbHRlay9ydGw4M3h4LmgNCj4gaW5k
ZXggMGRkZmYzM2RmNmIwLi5jOGEwZmY4ZmQ3NWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0
L2RzYS9yZWFsdGVrL3J0bDgzeHguaA0KPiArKysgYi9kcml2ZXJzL25ldC9kc2EvcmVhbHRlay9y
dGw4M3h4LmgNCj4gQEAgLTE4LDUgKzE4LDcgQEAgaW50IHJ0bDgzeHhfcmVnaXN0ZXJfc3dpdGNo
KHN0cnVjdCByZWFsdGVrX3ByaXYgKnByaXYpOw0KPiAgdm9pZCBydGw4M3h4X3VucmVnaXN0ZXJf
c3dpdGNoKHN0cnVjdCByZWFsdGVrX3ByaXYgKnByaXYpOw0KPiAgdm9pZCBydGw4M3h4X3NodXRk
b3duKHN0cnVjdCByZWFsdGVrX3ByaXYgKnByaXYpOw0KPiAgdm9pZCBydGw4M3h4X3JlbW92ZShz
dHJ1Y3QgcmVhbHRla19wcml2ICpwcml2KTsNCj4gK3ZvaWQgcnRsODN4eF9yZXNldF9hc3NlcnQo
c3RydWN0IHJlYWx0ZWtfcHJpdiAqcHJpdik7DQo+ICt2b2lkIHJ0bDgzeHhfcmVzZXRfZGVhc3Nl
cnQoc3RydWN0IHJlYWx0ZWtfcHJpdiAqcHJpdik7DQo+ICANCj4gICNlbmRpZiAvKiBfUlRMODNY
WF9IICovDQo+IA0KPiAtLSANCj4gMi40My4wDQo+

