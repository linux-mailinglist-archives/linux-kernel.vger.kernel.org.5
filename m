Return-Path: <linux-kernel+bounces-25869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC6482D704
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC271F21C24
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1C5F9EC;
	Mon, 15 Jan 2024 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="CDd8hdL6"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2048.outbound.protection.outlook.com [40.107.8.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA82F9C1;
	Mon, 15 Jan 2024 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lClCCwXgdxoxCSZ7/M2FlbErVKk0hmZHiR9ZXpVkPBL1iLf/p0Czhyl9nFBU93kIDRUmhEjfvtsxcyshFBws8S4FdNaPflNeTsd+Qz/TZPxQ9hMyxwok6IOQd/T20tN0h7uYKODRk6/TrXu/XEJ3FoJ72VQF5rye0F2F7qFiPtI/4/cI4Zx34SflQi4px30/jaPZTSB64M4aiPa7Uz2F8QAhPrWGcRzJTxw/8c2Thp84AFgaBF1Yr+bY40aMh7JMUEAqvrh4O3E68jPQRXeH0HCuVn3/fvzbaOwF4Aeh/D7wthREEsEEHGndavllIU+LQ6bOel2iCrncVVP2U6+rFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhTYgZXt92oQKHampK1/tBZ8SuNP5fsgdmIpxI72uBg=;
 b=edgCcceeT6MdBpC9z0mhC7V9njKdA+UApp+zrPE/sjdTx8528Fu2VJlNZSzwKfwRO4ZOkDmi31mA5U6xxJUj82UGef3w8e5RS5L+CToKe33xl/4QF5YFvYPWchwxsBT8sNbJQDL1fOVY5QoKCqC8cAzPIxhpJ+KYzkDspHjhY8QdGlCf4lmSr7Ej+J1WBqzcdeNSNkM1ErNSJAs2w/I7GVHTtRFshOL6Y85eD7f0g5jD3tKlmp+K7/VZvkOayv7pE8zBKd/fic+mUi828K8SWILNS0fi0Zp/1b69/VCRitGhtSwPDnP8z+PWjYhJ3woZvp8wnorFR7MkT3lygi6J6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhTYgZXt92oQKHampK1/tBZ8SuNP5fsgdmIpxI72uBg=;
 b=CDd8hdL6MSZ4BHBy0eOscSDD5SjfUWJAeUbooM+O13ixLWemDLZGnxs2RqtDAfYlk3bqkudw2wmOKOs3cXc8LHHzFPf5rQLNUv1hQ/DGn9dkrnGRSpxAr4bi9DTUhfshI+zo4WPnUlscdCvWtvxmoY96ilK2qzWs5tfLkm7kncw=
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by PAXPR04MB9667.eurprd04.prod.outlook.com (2603:10a6:102:242::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 10:17:19 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%7]) with mapi id 15.20.7181.020; Mon, 15 Jan 2024
 10:17:19 +0000
From: Josua Mayer <josua@solid-run.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Nishanth Menon
	<nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>
CC: Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rtc@vger.kernel.org"
	<linux-rtc@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] dt-bindings: rtc: abx80x: convert to yaml
Thread-Topic: [PATCH v2 2/5] dt-bindings: rtc: abx80x: convert to yaml
Thread-Index: AQHaRXqM9m6egMxAy0iAmXaXPfibdLDWa+UAgAMNhQCAAAh5gIAA/G+AgAAuw4A=
Date: Mon, 15 Jan 2024 10:17:19 +0000
Message-ID: <d702f384-7c0f-443b-84bc-4333933cee7b@solid-run.com>
References: <20240112-add-am64-som-v2-0-1385246c428c@solid-run.com>
 <20240112-add-am64-som-v2-2-1385246c428c@solid-run.com>
 <7f45aaea-6520-41c7-8788-f6dd14c5fcb2@linaro.org>
 <fa954f30-22dc-4914-b037-c0ebb311637b@solid-run.com>
 <9cbc3ab1-0621-450c-b9f5-ecb1f401d326@solid-run.com>
 <c8c41aec-1a53-4b5f-82a3-e9b786c5325b@linaro.org>
In-Reply-To: <c8c41aec-1a53-4b5f-82a3-e9b786c5325b@linaro.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8963:EE_|PAXPR04MB9667:EE_
x-ms-office365-filtering-correlation-id: 63a4cf7e-43ea-423f-01a6-08dc15b32830
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 g9wOK3grfIOkAvzTlvh6InqkDADKi1UbUh/QQS9aM3eiqLxq9u1zSnp51yeN8C+kQJc1RlZjICTsIbnXlQPHnaFfShm5ZHTNOU7TEgi8ux4hzjb+oi3EIBbUJxwTl5oTqnENTSJBVtfeph6A3dAD5STwTI6ES/H4q88aoskSByRtLkByXi+TfDVjRdyuB2HA7UrgNnNkb5qqKN8azuNqTbYFOFGYT9P8vBejJJZ1pwh9X4BuEqb8QaE0NEyiRqZ+YYY/hVlltye8lqXuIKpn741ch25jHeEWzmScqJU7xCDbJhZIqezRmyhXdO0u2/f+09rVXjSelT9PAGcw8vdxjodDtk2XOBmGfU5EdOmnagj64DKCkSB6EJUWEyvL5vFfSBTAQihkSn23h2OKSsdtQi1PG7CkL2tiVhRSQPQ5xi8Kszs22XDANOIWBxOH+PKnIpssOuk/vsamSKtGkGlxpqeo8xmz4Y5ERBe5hZba6WgVUU1UIx3rOGYHYhqw4hX34ZiMwTTENe8Ls4+Q7PcjXu2Kj7Rk7cp2nlIHdpLgC4KKrfRYH11kN3M0kr0JiQM1O/1ZGHvDkjD+16prkTVJjXRRz0YRLMRW1DgWuznsTJuHslDKeq0oU/QoyjfzN+f3tktIXcUPyPNHfd5Irtj8uA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39840400004)(376002)(396003)(136003)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38100700002)(122000001)(38070700009)(36756003)(31686004)(86362001)(31696002)(26005)(41300700001)(478600001)(316002)(6512007)(66556008)(54906003)(91956017)(76116006)(66946007)(2616005)(6506007)(71200400001)(110136005)(53546011)(64756008)(66476007)(66446008)(6486002)(2906002)(5660300002)(4326008)(7416002)(4744005)(8936002)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eG43QWErbktQZUZ2R0NhTjFWNy8vWUFiaUUyWTZJWUlsZTdmdndQeStZV1Iv?=
 =?utf-8?B?Sjl0VXdMb3VwK1U0WmpFbGh0NmlmOGQ4dnVZdWFmNkNaSDJ1NGhvdy9lRkJs?=
 =?utf-8?B?VEtJOWF3dWZRNndQZlFIYnowM0M2ZElmVGZMc0JlSkh0MDlwNHNCY2lIeDBj?=
 =?utf-8?B?SXIzMEdBMFphK1lxZzlwdlZWVVFhMU1CdWRNQ1BCdUF1dHhIeXFReTZiMHFM?=
 =?utf-8?B?YXdoemlMT2wyRkJQczArTlQzaUdKd0JYeC9kUWFQa3NoU3JJaERSc2FvVTJv?=
 =?utf-8?B?dHpSMlpub2IwZEF3aG1CNlkydWJoL3RIUlpqMEovUDV3YkNYZ05hRjJyMWh6?=
 =?utf-8?B?NWpET291M3BRU1VSQm9MRnoxTjh0cDluSmN6UUFTUnR3T2hDMjFxNGp6SkpI?=
 =?utf-8?B?bzAzT21mSnlJMlFjbjFMb0s0amhQdlVIeFl0ZFRER0RxS0R4NzBWQjQzM2lj?=
 =?utf-8?B?SWRBenZURUM1dmk1ZGFrK3poNWQvVFpUYlhTbkhqU0sycjkvQUErT0pYL2wx?=
 =?utf-8?B?YStDQmp6OWhFK3FXdzhza3pnQ0VGY3hVbGtvL1dIVzZ3QWFNRXRtL3pnWW1i?=
 =?utf-8?B?VE13NzZ1bTkvUG94MWRzR0tNNTFmTEZQcEdHQWpxd2VNNTdlWTdPVFZhYTla?=
 =?utf-8?B?R25SQjlFc1BSd3JNN21TZWpyL2ZBRVlOcFgzQnJhZEtCbm9DeTZ5SnlXeEo4?=
 =?utf-8?B?WElUZHpna2lnekxraGFIQXpTNjlWYVBoY2ttYjU5MTUzSXIvdTlhY0czT2dK?=
 =?utf-8?B?Um5QZVlJM3ovVkVqb2VaUjE1SzVseXpvUHljYTNFNFJYNnJVaTBpNGkwRmky?=
 =?utf-8?B?RUVsL3dnUTU2VHZlSXlQSWQrOTJjS0xNRDZUUldMNkI3MHA0R1Boamxsb1c2?=
 =?utf-8?B?SHc2c3dWeXRFMnNuRGxGY25UejczelZ2ZjNBS2xmQ1NoOEdDcVZqa0JjcmRN?=
 =?utf-8?B?eW1FOSt1OXl3U291MVR1K0IzVkJNeDd5TTkybDdVa0Ivd0VoT2xrZnRvVGJ3?=
 =?utf-8?B?OEUxd0ViRFByYnAwa1NDUEtBYnJhNWk3MGs3aEdaUVIxYnFMR3V3VnZ0bkQ1?=
 =?utf-8?B?WDZMS1dnOVhaWlN1Mm1CWXB4MXE4S093QUlpTG4zMWVVU3haTXBuYWFwQ0Jz?=
 =?utf-8?B?c293VnpYbXJ3VmRLazlpV3RoWHc2OHpCbVRwN21RUjZ1c0JQR1RGb1hId2kr?=
 =?utf-8?B?K3RUMmRPek0vTVpaRDhGTWFBMWJJZ2RaMzFrbTFvRTlxQTNzR2R4c2xuMWFh?=
 =?utf-8?B?THdiU1NSRjkyNWtIeGgrMmFuOFVYemZPWVlpVDFtMEdFZVZNUytTODhDMUMr?=
 =?utf-8?B?YktteVd5bWJYbU9jRHhOVGlseGtiK2IxL284WUtuZGdSRTBNT3F6SDFMWU8z?=
 =?utf-8?B?T2o4TVdxNFg2UDcvbUdTK3duL3I4N1A5NVN5Vmp0WHRtdGtFZHRzRk1rMlRn?=
 =?utf-8?B?S1dLSTJhb2VrNVZlalRwT3QxY2FQUk1RRnREamQ4ZDRzN25XS3VjNWMvQ0sx?=
 =?utf-8?B?RHUva0JEOE82RldySkl0eXlaSkt6ditQbFdaWCtoL0doMzlUR3VITk4wRVRn?=
 =?utf-8?B?d3VhWlJRbE1IWFBTMDlMSThsZkJtZkRkY016a21xZUp1RFBDU2Y5M1lOY3c5?=
 =?utf-8?B?QlV4SjQzZnFXWU4xRGtOUHZMMlJZcXFuRkFpczZIRkhpSldTcThmUHh2RE9O?=
 =?utf-8?B?eVlTVHB5Z1FWV2RzZVg5UEJETXlQUnFDWVdrOThydUpTb1RwaldrYlVZTWhX?=
 =?utf-8?B?Y0gySHVEQlFXZ3FqR1Njb0VUcjJqTUd2UzRJR05VRW5JYXdWcldyUW9uQjA2?=
 =?utf-8?B?cEJMVmhyeC9xSzlvbHd1TGRJcTRUbUlKY1pRYUV4QTJqT1c0R3NIK0ZERTdE?=
 =?utf-8?B?REE1R1JDWWFxcVMxS3RPenJhZ0N4a1BkS0xUTFpyQXdCblpxREJ5NVZud2Rw?=
 =?utf-8?B?UjhKQnRYZVIvclFnc1Z5aVF5MlMvZ2QyN0x4SDg4OXpJb2lvT005cHlnTHF5?=
 =?utf-8?B?TTdXT0c3ZHBhWmZhWGhiU2lHWHR4TmR0dTdCcllzd2QzZFI4WnFLZWVNS29V?=
 =?utf-8?B?VTcxR1BuL1ROK25EUkhGRkZubnNsU3J6Yyt0RFVUYkVySktQWnltMzdhaGdC?=
 =?utf-8?Q?e9bnejl/jv++DzmeI5IkF1TV+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <20B30A37652E3A47BA41D23B0B51F1AD@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a4cf7e-43ea-423f-01a6-08dc15b32830
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 10:17:19.6695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZMAEOG9yOJ4Lpy2wlMzG8Rb0fAU3EGjZ3J/EISd0q1MAFzcrNdeG4LBYtw5FcHhiWasGj7s+Nu3Q71jWT7SO0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9667

QW0gMTUuMDEuMjQgdW0gMDg6Mjkgc2NocmllYiBLcnp5c3p0b2YgS296bG93c2tpOg0KDQo+IE9u
IDE0LzAxLzIwMjQgMTc6MjYsIEpvc3VhIE1heWVyIHdyb3RlOg0KPj4+Pj4gK21haW50YWluZXJz
OiBbXQ0KPj4+PiBZb3UgbmVlZCBhIG5hbWUgaGVyZS4gSWYgdGhlcmUgaXMgbm8gZHJpdmVyIG1h
aW50YWluZXIgb3IgYW55b25lDQo+Pj4+IGludGVyZXN0ZWQsIHB1dCBkZXZpY2V0cmVlIGxpc3Qu
DQo+Pj4gQWNrLg0KPj4+Pj4gKw0KPj4+Pj4gK2FsbE9mOg0KPj4+Pj4gKyAgLSAkcmVmOiBydGMu
eWFtbCMNCj4+ICsgJHJlZjogL3NjaGVtYXMvaW50ZXJydXB0cy55YW1sIw0KPj4NCj4+IElzIGl0
IGFjY2VwdGFibGUgdG8gcmVmZXJlbmNlIGdlbmVyaWMgaW50ZXJydXB0cyBzY2hlbWE/Og0KPiBX
aHk/IE5vLg0KPg0KPj4gSSBzZWUgbm8gcnRjIHlhbWwgZG9pbmcgdGhhdCwgYW5kIG9ubHkgc29t
ZSBkZXNjcmliZSBpbnRlcnJ1cHRzIHByb3BlcnR5IGV4cGxpY2l0bHkuIEJ1dCBJbXBvcnRpbmcg
dGhlIHNjaGVtYSB3b3VsZCBhbHNvIGNvdmVyIC1wYXJlbnQgYW5kIC1uYW1lcy4NCj4gTm8sIGl0
IHdvdWxkbid0LiBJdCBkb2VzIG5vdCBtYXR0ZXIuIEkgZG9uJ3QgdW5kZXJzdGFuZCB3aGF0IGFy
ZSB5b3UNCj4gdHJ5aW5nIHRvIHNvbHZlLg0KZHRic19jaGVjayBpcyBjb21wbGFpbmluZyBhYm91
dCBpbnRlcnJ1cHQtcGFyZW50IHByb3BlcnR5LA0KYmVjYXVzZSBJIGFkZGVkIGJvdGggaW50ZXJy
cnVwdHMgYW5kIGludGVycnVwdC1wYXJlbnQgdG8gbXkgcnRjIG5vZGUuDQoNCkFsc28gd29uZGVy
aW5nIHdoZXRoZXIgaW50ZXJydXB0cyBwcm9wZXJ0eSBzaG91bGQgYmUgaW5jbHVkZWQgaW4NCnRo
ZSBleGFtcGxlLg0KDQpJIGZvdW5kIHRoaXMgaWRlYSBpbiB5YW1sIGZpbGVzIG91dHNpZGUgcnRj
Lg0KQnV0IG5vIGV4aXN0aW5nIHJ0YyB5YW1sIHJlZmVyZW5jZXMgdGhhdCBzY2hlbWEsIHNvIEkg
YXNrZWQuDQoNCg0Kc2luY2VyZWx5DQpKb3N1YSBNYXllcg0KDQo=

