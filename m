Return-Path: <linux-kernel+bounces-25492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B383282D118
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 16:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EAFF1C20BC1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEE9257A;
	Sun, 14 Jan 2024 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="X0tPEXuw"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2062.outbound.protection.outlook.com [40.107.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A8D7E;
	Sun, 14 Jan 2024 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVrgMsp6jZFn1dd36GzHR0nuxm4xicLL6Su6qug8C8AJo1Ex6qcu6shpjl+U5ZD7KOh9Qp0WnFgnw0kZPF7Z6C1d5NfvHp7anKncIc3Xlp7+Rw5UQisJ3gfbDGF0Vy1RfQYPrK6Xdy1NA7s0Wl6SZeLUAKwaj6jfulUeQOdFe0KOOobgp3IfHxY0ts3K0qQWl9OXUJf8DOCaNbr9OSDrxJGm30F9qHb9Ll7Lunn/AUWUlFxYEPeZnu9cz+ReCQ6r8MRZVhW2vVMhLBopf9Tj9cqovdjbcFFiWLOAkighCZqUDIB64aQME7BWbsRZ4Ul3n0fC/8xwFszYcglEmt1UaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kbi9tva5vOZr+crfDbduLfW0Cky/eV0QG0EzRRIWj6Q=;
 b=Wp/XkTAteqfPEBIS61pohsiPBumTiyaNtr2BPBZbEs4PrOe1pqxp1grJYOSnMN96k6C3qex36dp409s1e8rrZvI2g1AoeAHKY2lyQ82WC7z50mcoeDLqRfWw4u8rVbbANWX3YFprD45AcBoNdJQcUeVwYRTUJMpNtx0DvfNFSJksbDkKS+l85uOiBb3ggf+99+pjX1uUz5ix33gFO8ypJUvN1DOmZNDUAGN7h6dyjqxvjpTHgTT4z/t78OLAsiXLu8D+szHSq3nTeHSqWZhWkm6/tb/6YoqIHhFEMoAy2aXnQrp/BvFHHyDsJfMHDjdqESObDRRrecstR8E9v8N7IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kbi9tva5vOZr+crfDbduLfW0Cky/eV0QG0EzRRIWj6Q=;
 b=X0tPEXuwAjtLhRtfnLTg4fCTPLyRl0PwJ16kLuH8iIwEFyURnVGGGFvBZYPQonj1cFlfKzdOFvyhE6WWp0bJ2qdraD2fnGkwcQEkiztmL2m3TU3bIGezroVwt+QeKkTbB0WDHpc8W/ez0xaNrgtfNRdDc3QPTDg7DFe9/Fl7T4g=
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AM8PR04MB7762.eurprd04.prod.outlook.com (2603:10a6:20b:241::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Sun, 14 Jan
 2024 15:14:07 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%7]) with mapi id 15.20.7181.020; Sun, 14 Jan 2024
 15:14:07 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>
CC: Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rtc@vger.kernel.org"
	<linux-rtc@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] arm64: dts: add description for solidrun am642 som
 and evaluation board
Thread-Topic: [PATCH v2 4/5] arm64: dts: add description for solidrun am642
 som and evaluation board
Thread-Index: AQHaRXqNRxBDBTIBFEOB99P14tzvurDWdLaAgAL49gA=
Date: Sun, 14 Jan 2024 15:14:07 +0000
Message-ID: <9872cad8-d8a6-4a5b-a395-865345f61885@solid-run.com>
References: <20240112-add-am64-som-v2-0-1385246c428c@solid-run.com>
 <20240112-add-am64-som-v2-4-1385246c428c@solid-run.com>
 <e945eec2-382a-4b31-bb6e-32b5234fdb51@ti.com>
In-Reply-To: <e945eec2-382a-4b31-bb6e-32b5234fdb51@ti.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8963:EE_|AM8PR04MB7762:EE_
x-ms-office365-filtering-correlation-id: d3ff77ca-4896-4761-6779-08dc151373c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /O3UyBhK/uaKJHsip8+IBqr5xToiEFX3wcq0JDA3J1xJY+YHMOqMIoe1T2BlzDuv1oRcBGLBJPlxtmd2+Q7HJ1R64PhIsgJ8nHQKZHppsaJ4hUPqQMab2nVCNql8Tq+tWjASllnz1HnTpKyQr19FZDbnUm9ZJnxjstGQ+aEDRZjGlsCmJ/SCi8rNFOYyfYyqwDNS8R0wQIIu2lLe3fJ+KhJMpvhrlE7ibV594ixDD0GJZe+z1q2XHIyIiICQFAlW0pXpqLEc+gUONM+XpIA2Vnl6nslj25rpdVPHq7IdPh0fWdxToHuLWsgB56TocsCH41wHMWekf0BLEORCxoL2/g2tNNVqH60t0tWmxcnhKqPX9rMUjHPmHEUBaO6gAVN5yxB7ncHqkeMB2VFEfwEs7tA2hyKSQUx6o9MPl1McliyTt7iapWRBhBx5RJXfZB7g1fPIfX0erYzc49yr33C15hmQPEZBgi/wBiHYy6B/LYelcwWGVhgDQ6APZ3sAsNRfTEU2ShN1BAB0qUWDb1uezLfysQp0Y87SV4lEDli9MCVEBB+MW/35mCs6JXYr5vHH5ZT4/5pECZolG8lsA7qWB+Kw6iv51+mHRFRMHfqGC8MdyePhak3da1ys5mqyJ6KI4pCOsygHCRlo0HfosmUkPQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39840400004)(376002)(396003)(136003)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(122000001)(38100700002)(38070700009)(36756003)(31686004)(86362001)(31696002)(26005)(2616005)(66556008)(83380400001)(64756008)(54906003)(76116006)(66476007)(66946007)(316002)(91956017)(110136005)(6512007)(71200400001)(478600001)(8936002)(8676002)(6506007)(53546011)(66446008)(6486002)(2906002)(41300700001)(4326008)(5660300002)(7416002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N3dRUXJWNGdsbzA0UzQ0TzdoOE84Qk1hT0hqNFYrdGdJYm1VZU1GV3JvSVRE?=
 =?utf-8?B?M3h5UWl3ZkdLZ2ZUaGRsWFBZOEtET1JUSEFqK3Z4d0hPQitUUUo5TTBKQ2N0?=
 =?utf-8?B?Y2pVV21BeWE1MWJaNlBGcVZLVWxXazdpSS90K2tNWTN1Q2crdTgzSnRsMW04?=
 =?utf-8?B?VWw1eWFTeFJiWVJWTERxUzYzeW5aNHZFUWJRTE5XNnpSWHdOMmNoRFdHbFpG?=
 =?utf-8?B?OUVTRDcxeXpDZmZ6WkFhcnlZejBxb0hFd2tRek1FclZxRG03Rlk0Vjh1eno0?=
 =?utf-8?B?NmVQQllic3loNFMwRjRmNVprRjI0S0xhdDNqRGVoZ0d4L2FxcjJTeVpmc0hP?=
 =?utf-8?B?cVJpbk9CKzJ6SW00ZERRK3FtNTNha1hXTzV2K210TitvUjg5blNZbFhJMnk4?=
 =?utf-8?B?SXhPaDY3eFZyWS9BQnZlMzhMa1JKYzR6eDBtdzlaTDVXS2tGM256ZndCUll6?=
 =?utf-8?B?eVVUY25OWlRQcUh3ZWVXUU42eVJwQngxWjN6VnJycnRESDVTVEZlVkFnZ3k5?=
 =?utf-8?B?MjZ0Y2w1c2ZaU1hjNWtUcmdtV2VwQ0ZBT3B1UkJvUEJkYnlWeUNlVnFJcWxY?=
 =?utf-8?B?SHN0dGdOdEloZmZVQXZXWEJUMGhtNW5tKysxQ0RDWHRQNEUzQ0R1QWtkdTlD?=
 =?utf-8?B?N3F3TG1YZVVHYVAvd0VvRmVRR2NpSTBBRWluNVJQUlhBVmRsRXhodSt2WTBi?=
 =?utf-8?B?eWRRRlJHS3BuOE5FdWJNZ0FXSGlYUHN6RUlZekErajVRVDZlc29HVDcxS0lT?=
 =?utf-8?B?YzFEc3hMVmkrSTlLSUdvbWJ1UXFVTk5jTUhKaUZrdEYxQVlDVExVWVFORHh0?=
 =?utf-8?B?aHBkVVBUS3ByalpjejVBSGoyaFF6QTZZd2xXd3FqWnZsdUFsVGJDSzhGK1lG?=
 =?utf-8?B?OUVScFR5VzZYNXJPTForY0pSQnpIOHBpYnRiQXpIYjRmWk5WSVJueFhYaTJB?=
 =?utf-8?B?cHdKb1Y2WlVaYm5yV0V1SXhIQTdWbGRaQ2dMR2Y1WGJIbmpMTVUyZis1bWtJ?=
 =?utf-8?B?dlF2L3lNVVgySFhwRjVtSjBjbVN3YXc4YTNaTHJwL0FRV1NRbXVFeGdFbml3?=
 =?utf-8?B?UUlRbE0yRmduZStsT0tHQmZBa1g0cHVmWktVYXVVbVd2bG15UEtVNUxDQW1s?=
 =?utf-8?B?YTdZcHU5L1BMWnpqaFNIUWpJOW5sdmFMTkd4b3FWbnZ5ZTJIRDMwb0IwUnRT?=
 =?utf-8?B?NHladldtOE9YYWZ0K05QTm5ZU1VmWDBhaTBlc3p6U0JhT0FXN2xyM1U4QWlY?=
 =?utf-8?B?bXV5U0Zaa0tYam9sQlJXRUF3R3ZYWWFnaHB2L1ZoSUNrTnkzSWFNTjZMMnMw?=
 =?utf-8?B?cUJUTFY4NDdPRjlCV0NpZStKUUdHQStyTVlJZGczMlFJZVowNkZvMW5HZkE4?=
 =?utf-8?B?SlBFdXhlcm1tazU3bGgxcDVQOFVoZUFBRFo3aXcvYVFxWDhxY1UzVTlUMkVq?=
 =?utf-8?B?RzUwSjFQSm5USk9DS29mbXFSL3g0VDV3M1gwNFc5Z0JOb2IrS0p1bUFFek9F?=
 =?utf-8?B?aWlnd2NPWWJDSjFyUmhoZXlFSlMwSXVmRXNPMC84RWM0KzBjdlBRUDAwbWVJ?=
 =?utf-8?B?L3pjc1ZxNDc2VTJWelRxejNsT21lZk1jSnpOVmFXamlScnlpa05DcWF4aWYz?=
 =?utf-8?B?NFI2TG1HdWRJeVlCMVJod2xsaXgrb2x0UlVtaG5lZzV0aFVYU1VKb0x1TWJl?=
 =?utf-8?B?b3A4THdDL3FUVTUrWWM3aXRuZWNvdWhHL2tvMW9neGMwYkZoUTJ1QUVWZ2l5?=
 =?utf-8?B?UFA0T3pHU3lHNm9reXZNZXZ4eWJXYjZ4cEl5T2ZpNkFPaDFGL21jQjFxZ2pN?=
 =?utf-8?B?Uysyenp6ckRaRVQ4YmlDNzdRZE5TTGovZWdnV1hKbEtWRUVFNnFrK2JtRUEw?=
 =?utf-8?B?N0l5SzFTb0FPZElscjBlcGt2Q3BPV0dQYnY5QkROV0FaZFNhVHI3NGxMWUdi?=
 =?utf-8?B?WUJQZzhETVUwL2ZLYzJpUFo4MWFCT3ltMW1jU0JNeVhtV0pLREM4VEs2RHhU?=
 =?utf-8?B?UE1qVU05cnduaDJmWGZtRUVRV29UM1JrdXhFKzMwSDBLRWJKY2xyM25IOHlP?=
 =?utf-8?B?UUQwRXdTNlRwblZ0MHZNTUFGckhFNWhzdjRYK2d5S1lTT2hGZ2dRVHJ0cFVm?=
 =?utf-8?Q?L6n3TunHrg5GuOksKoicco3Lp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0523D96229529C4D8E40689DF9812EF4@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ff77ca-4896-4761-6779-08dc151373c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2024 15:14:07.0372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MyKX5XX1autGf/uWtKbTeSxwV5/s5l7Q9bdzgkaLLMbpo708YborVfbGuCz6FDl9PBASvFtJGtvAnZ53dr7+0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7762

QW0gMTIuMDEuMjQgdW0gMTg6NTAgc2NocmllYiBBbmRyZXcgRGF2aXM6DQoNCj4gT24gMS8xMi8y
NCAxMToxMiBBTSwgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+PiArDQo+PiArwqDCoMKgIC8qIGNoYXJn
ZXJANmEgKi8NCj4NCj4gPw0KVGhlIHBhcnRpY3VsYXIgY2hpcCBicTI1NzEzIGhhcyBubyBtYWlu
bGluZSBzdXBwb3J0LCBubyBkdCBiaW5kaW5ncywgYW5kIEkgZG8gbm90IHVuZGVyc3RhbmQgaXQg
d2VsbCBlbm91Z2ggZm9yIGRlZmluaW5nIHJlYXNvbmFibGUgYmluZGluZ3MgbXlzZWxmLg0KDQpT
aW5jZSBpdCBpcyBhc3NlbWJseSBvcHRpb24gYW5kIG5vdCBjdXJyZW50bHkgYXZhaWxhYmxlIEkg
YWRkZWQganVzdCBhIG1hcmtlci4NCkRyb3AgaXQgaW5zdGVhZD8NCg0KPg0KPj4gK307DQo+PiAr
DQo+PiArJm1haW5faTJjMSB7DQo+PiArwqDCoMKgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7
DQo+PiArwqDCoMKgIHBpbmN0cmwtMCA9IDwmbWFpbl9pMmMxX3BpbnNfZGVmYXVsdD4sIDwmbWFp
bl9pMmMxX2ludF9waW5zX2RlZmF1bHQ+Ow0KPg0KPiBUaGUgaW50ZXJydXB0IHBpbiBiZWxvbmdz
IHRvIHRoZSBydGNANjkgYW5kIHNob3VsZCBiZSBpbiB0aGUgbm9kZSBiZWxvdy4NCkFjay4NCkkg
d2lsbCByZW5hbWUgdGhlIGludGVycnVwdCBwaW5jdHJsIG5vZGUgcnRjX2ludF9waW5zX2RlZmF1
bHQsIGFjY29yZGluZ2x5Lg0KPg0KPj4gK8KgwqANCj4+ICsNCj4+ICsmcGNpZTBfcmMgew0KPj4g
K8KgwqDCoCBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPj4gK8KgwqDCoCBwaW5jdHJsLTAg
PSA8JnBjaWUwX3BpbnNfZGVmYXVsdD47DQo+PiArwqDCoMKgIHJlc2V0LWdwaW9zID0gPCZtYWlu
X2dwaW8xIDE1IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPj4gK8KgwqDCoCBwaHlzID0gPCZzZXJkZXMw
X2xpbms+Ow0KPj4gK8KgwqDCoCBwaHktbmFtZXMgPSAicGNpZS1waHkiOw0KPj4gK8KgwqDCoCBu
dW0tbGFuZXMgPSA8MT47DQo+PiArwqDCoMKgIG11eC1jb250cm9scyA9IDwmc2VyZGVzX211eD47
DQo+PiArwqDCoMKgIG11eC1jb250cm9sLW5hbWVzID0gInNlcmRlcyI7DQptdXgtY29udHJvbHMg
d2FzIGEgZG93bnN0cmVhbSB3b3JrYXJvdW5kIHRvIGVuc3VyZSBzZXR0aW5nIHRoZSBtdXggYmVm
b3JlIHBjaSBwcm9iZSAoZG93bnN0cmVhbSBwYXRjaCBvbiBsaW51eCA1LjEwIHBjaSBkcml2ZXIp
Lg0KSSBzaGFsbCByZW1vdmUgaXQgdW50aWwgY29uZmlybWluZyB3aGV0aGVyIGl0IG1ha2VzIHNl
bnNlIC8gaXMgcmVxdWlyZWQgdXBzdHJlYW0uDQo+PiArwqDCoMKgIHN0YXR1cyA9ICJkaXNhYmxl
ZCI7DQo+DQo+IFRoaXMgbm9kZSBpcyBhbHJlYWR5IGRlZmF1bHQgZGlzYWJsZWQgaW4gdGhlIHBh
cmVudCAuZHRzaSBhbmQNCj4gaGFzIGJlZW4gZm9yIG1vcmUgdGhhbiBhIHllYXIgbm93LCB5b3Ug
bWlnaHQgbmVlZCB0byBnbyByZWNoZWNrDQo+IGlmIHRoZXNlIGRpc2FibGVzIGFyZSBuZWVkZWQu
IEkgc2VlIHNldmVyYWwgYmVsb3cgdGhhdCBhbHNvDQo+IGFyZSBub3QgbmVlZGVkLg0KQWNrLg0K
VHVybnMgb3V0IHZlcnkgbWFueSBub2RlcyBhcmUgd2l0aG91dCBzdGF0dXMgaW4gazMtYW02NC1t
YWluLmR0c2kuDQpJIHdlbnQgdGhyb3VnaCBhbGwgb2YgdGhlbSBpbiBzb20gYW5kIGNhcnJpZXIg
ZHRzLCBsZWZ0IHdpdGggZXhwbGljaXQgc3RhdHVzIGFyZToNCg0KLSBjcHN3M2dfbWRpbw0KLSBj
cHN3X3BvcnQyDQotIGljc3NnMV9tZGlvDQotIG1haWxib3gwX2NsdXN0ZXIyDQotIG1haWxib3gw
X2NsdXN0ZXI0DQotIG1haW5faTJjMA0KLSBtYWluX2kyYzENCi0gbWFpbl9tY2FuMA0KLSBtYWlu
X21jYW4xDQotIG1haW5fdWFydDANCi0gbWFpbl91YXJ0Mw0KLSBvc3BpMA0KDQo+DQo+PiArfTsN
Cj4+ICsNCj4+ICsmcGNpZTBfZXAgew0KPj4gK8KgwqDCoCBwaHlzID0gPCZzZXJkZXMwX2xpbms+
Ow0KPj4gK8KgwqDCoCBwaHktbmFtZXMgPSAicGNpZS1waHkiOw0KPj4gK8KgwqDCoCBudW0tbGFu
ZXMgPSA8MT47DQo+PiArwqDCoMKgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+PiArfTsNCj4NCj4g
RGVsZXRlIHRoaXMgbm9kZSwgYWRkZWQgaXQgYmFjayBpZi93aGVuIHlvdSBwbGFuIHRvIHVzZSBp
dA0KPiBhbmQgb25seSBpbiB0aGUgZHQgZmlsZSB0aGF0IGFkZHMgdGhlIHJlc3Qgb2YgdGhlIG5l
ZWRlZA0KPiBwcm9wZXJ0aWVzLg0KQWNrLg0KPj4gKw0KPj4gK8KgwqDCoCByZXNlcnZlZC1tZW1v
cnkgew0KPj4gK8KgwqDCoMKgwqDCoMKgICNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KPj4gK8KgwqDC
oMKgwqDCoMKgICNzaXplLWNlbGxzID0gPDI+Ow0KPj4gK8KgwqDCoMKgwqDCoMKgIHJhbmdlczsN
Cj4+ICsNCj4+ICvCoMKgwqDCoMKgwqDCoCBzZWN1cmVfZGRyOiBvcHRlZUA5ZTgwMDAwMCB7DQo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWcgPSA8MHgwMCAweDllODAwMDAwIDB4MDAgMHgw
MTgwMDAwMD47IC8qIGZvciBPUC1URUUgKi8NCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFs
aWdubWVudCA9IDwweDEwMDA+Ow0KPg0KPiBBbGlnbm1lbnQgbm90IG5lZWRlZCBmb3Igbm8tbWFw
IG5vZGVzLg0KQWNrLg0KDQpUaGFua3MhIHNpbmNlcmVseSwNCkpvc3VhIE1heWVyDQoNCg==

