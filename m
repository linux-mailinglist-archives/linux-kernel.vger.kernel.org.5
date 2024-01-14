Return-Path: <linux-kernel+bounces-25513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEF082D170
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 17:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA7E1F21653
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 16:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74DA5243;
	Sun, 14 Jan 2024 16:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="c33wUdbH"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2060.outbound.protection.outlook.com [40.107.6.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BF57E;
	Sun, 14 Jan 2024 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtqTIx/77nn36bGhlYHXbGY5VpHYFgylNmQC9FKtYiINZRZ9Hu+LHiKdXiikvwAzK4L8ijux0/zxJ5mjCovqYQ1VG/1E4oA8F5HJwOGghOBnDCMXlo0ImBE9oqjJrMEEeSrwmJJ2kwVmKaqaD/haHh66Swmd/a3WEC7oyRvCPCYDlbCt7AYgANWJxRQldbRWZ15xXfHArdZNW3aitPXbn30dZS59PWsZ204ppuCV7tR8OO48CsLpLXgC2sZPfyEXR4aXkL4NjzQXUYcWUsklzCBXVYMI2uoNJXoEiK3OxYzzs/iWMS6nK1/SPiCXy6AypepQsLg2D65dZ6FRIbeo7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8SG/egCFUnuGQx6p2j3JP6Brr9VQaJFr8mOF32Nk4I=;
 b=hHip0nL63YjKEGJ8qr3E1HOS1pL6jtrHlPn3qp5NCEF73Aj2nw9v+ajxmdqM5+8bgu8m3QcSSa98Gv729FuIqf8BtNH3aBPKJ6ZOK74A3dRKXbXrMDWFUd1u07uUyTlO3jK5Iuu9wZObx5/q6Ivet5EPKVjoqlqp52QOGptmuYam37MV6xxwGQYMiDIBq0aYL81/HW8Azmcbowm+EVmrrqzbuNakj4k21yfUomZcLC7psO6mnh/sjgyCFL5G1JJRQQkUqn0x5pGkUxiTEzw4MwU+z37nHCcuoq26L+4JMpKYzBQ6nDSGZlZAsbmr3fo+8qW9psgGeFXii1ZuOQRCxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8SG/egCFUnuGQx6p2j3JP6Brr9VQaJFr8mOF32Nk4I=;
 b=c33wUdbH2VkKVgmMiP0L8dHql5JnCexQpTezL+aD+ybBsCLOenqYTOhc4jDce+dyrqFVfQyxrBTGxPa6F8+mUl9XaIlbH44YVVArnE6oIV8PBJ5N/j0cw5DD0wbXcN2Ge2vNgNx2/UST4WOicVNPqHkGFIAubK6fsYxRxNH9ysI=
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AM8PR04MB7827.eurprd04.prod.outlook.com (2603:10a6:20b:247::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Sun, 14 Jan
 2024 16:26:28 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%7]) with mapi id 15.20.7181.020; Sun, 14 Jan 2024
 16:26:27 +0000
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
Thread-Index: AQHaRXqM9m6egMxAy0iAmXaXPfibdLDWa+UAgAMNhQCAAAh5gA==
Date: Sun, 14 Jan 2024 16:26:27 +0000
Message-ID: <9cbc3ab1-0621-450c-b9f5-ecb1f401d326@solid-run.com>
References: <20240112-add-am64-som-v2-0-1385246c428c@solid-run.com>
 <20240112-add-am64-som-v2-2-1385246c428c@solid-run.com>
 <7f45aaea-6520-41c7-8788-f6dd14c5fcb2@linaro.org>
 <fa954f30-22dc-4914-b037-c0ebb311637b@solid-run.com>
In-Reply-To: <fa954f30-22dc-4914-b037-c0ebb311637b@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8963:EE_|AM8PR04MB7827:EE_
x-ms-office365-filtering-correlation-id: 51675d94-da62-4923-efae-08dc151d8f1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Uh7aemzMH1sCeyPgJO141xTvh7ARA4b4MVN0OT9j+nwk2BY893RoC71HVkWj6uS+5XKum1MIedqJEXagpeJt6pCRY7ymRDa3xk4XvkxQnO8CfVqnEFo+MyqR0HVujmBm2g7ZLTGr9zDDDqwvKJvcG62TbIni9EQYoiCj67c19U/HbNfQ+KtZuUWFRAhVxL6N/2DLUzGDugBpCzpMnyj6YXwTA83TvooiKMo8osalmH2C4qAJhiiWfQiNUm/WuOgJrxvVSSheRuwvoyjhy/1vY/cEgxJeAC8JWDevcnonxqi5p7a89oWVWzCxwCF1CIorkLaBlrOz7YgPwYammD7f+IShvjGBoLwDLhZsJEURM6zLF69LjcXc7TZLIfHdcoG4B5HPNclM0x16pPrS8JeFoEd976S8QOgm1WNpQOv3Gu9PRaLnsK46I8MNt/+tltspzGgOOwpplKleXy8yxQKM+mMS+ee5JvfH6EKaSeFCrSPRp1Y+NXfChY0UQJdtoxrHmkMWbIQZhDshe7Mq7WDa7UB87+KjXh9z0QINH5jj9idL2ppsi6zW6Od17yHN5ArLhPNIY289rEywkQczHatg5vVTf2Y3MsIQxuCOoAEfCvDscwN78Iv2qnR0rf2AgGpGdJM1tyF+z2eAxw7N6dHRjA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(39840400004)(396003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(6512007)(53546011)(6506007)(2616005)(2906002)(41300700001)(71200400001)(7416002)(5660300002)(4326008)(4744005)(76116006)(478600001)(6486002)(966005)(8676002)(8936002)(66446008)(91956017)(54906003)(66476007)(64756008)(110136005)(66556008)(66946007)(316002)(38100700002)(36756003)(86362001)(31696002)(122000001)(38070700009)(31686004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L3g4WkZUVXBMb0k5WTNUb2w5Z0RFZyt2K2J0Y01ZaDk0b2ZiTnd5L290ZHBu?=
 =?utf-8?B?RHQ2Z1Q1YVpZSzF5V2FvYWV1WDNldkVhdEJqdm1BTm5jajYyRVpOY1JoQlJx?=
 =?utf-8?B?Rm95STA0eEl4ZmJSdVAyUThrbmwzNU5HNjZyQUtVdmZ0cXY1MU9LQmkvN09J?=
 =?utf-8?B?NENxaWozT1pyN0FCRTlSVE5oZW1TeG1EdGVTeE90SmowMmRpRzRJVXVpYThw?=
 =?utf-8?B?YUl5bnBycGR2Y2ZGZTMwcy9Wbms0Vnc4ZWI1K0ltL3YrYTZUWEpEeSt6NWI1?=
 =?utf-8?B?TURjY1dEQURHZU9tZmkwWWVLZncxRHlNeXY0WGt2STdHVHFpanZjNFRlVVdJ?=
 =?utf-8?B?QmNkTlUwZFlMSlpjVk10YVNUTmpTUVhId1k2TEtKcTBHZW1kclQzbW9HMyta?=
 =?utf-8?B?MmxTQUdvL3BpaXppdTVpSjBrdGFKOE1sYlNjelcyRXQ5blo3OERWamVXSmtp?=
 =?utf-8?B?V2tWNzZ2ZG9nSUU4cmJxTWYxN1dLTUNiSGZYY1BYR21sSjIzVWZ2VlhzWXBM?=
 =?utf-8?B?R2tCcktBR0Y2SWM5c0FHcE9WdG9UaHJCTnBkMXFTbXkzdS9IYlFFYitiQ1pD?=
 =?utf-8?B?amwvdTdYbmc3emM4elF5cmVORERjaXFnQVpkd2hlUnFEd3kvdjQ4OCtEWW9U?=
 =?utf-8?B?dEJmR3lSSm9yWXVvMnZOZDVrVXBNQnQ0ZTlZaEJCeE51ZlRuMFkzQ0dkWlRw?=
 =?utf-8?B?Sm1janBlbzE5R1ZYSFA2d0ZmUE1zcVlINGFpVWZhYytwUTE3cVF3Z3J1dGJG?=
 =?utf-8?B?VFkxeGxOVW00ZUZhREk5dWplZTdUUVJrUFJmVVY5cHNEWXhTcHRFSGRPVVNS?=
 =?utf-8?B?UEZXclcwcnFtNmVsS29kWnRzZ2RtWHN4ZXZneDE0b2dlRnprZXZFYUxEcHdP?=
 =?utf-8?B?MS9rc1hWVHkwR1JaQzNZVHlUT1JvU3hGTG5HQTMzdzBLQTVuSGtKR0hqNGgy?=
 =?utf-8?B?cHJaRGh1V1lMZTNpTUVtK0pFV2pMK1RpMzJ3RFlybnhzRzVaa1FLWlMxOE52?=
 =?utf-8?B?bjNFZWNVREY3ck1kbE0yMys3WUhHZUtYUFN0YS8xMlJrK2l4OHJWU2h2S2gv?=
 =?utf-8?B?SzBUeU1MZ3FSeU9JNmM3NHNydHBweWZIbmxLU2NVTGhGQTFESmJZZGRVc1VQ?=
 =?utf-8?B?NHNhMmxVMUF2cXh4aDIxY3FtckNXRWM3SGRQMDVKV1lEcGp4RnZ0SVhwTkox?=
 =?utf-8?B?bnVsdkRkOVh4TllwaFNBZmJ4QmNMVy9FbHMvTHBuVUFDcHI0WnYvSHJ4MnAx?=
 =?utf-8?B?V0lIVmpGeTZ4UWVqbC9SS0ZWSHBiOWRSSXRybUMxNXJPdzFKdE4rYk8xYUNs?=
 =?utf-8?B?b29jdXNOT2FDSjZUYXdWcDFSU0NNRVpwSjNtNS9oK1A2WGw0T0R2QnNnMWlu?=
 =?utf-8?B?aDJ4bTh2MjBhYXcxYlRBeFlxblloN1FodEdGRFBmNDl5Nit4c2RhWnVSR3FU?=
 =?utf-8?B?WDlEczA2V3VCNk93VDBnY29oc0N5NFJ0U3hpQ1lTUTdEYlFXYitlaHRpUDU2?=
 =?utf-8?B?Ty9BT0pOVVpuTlB4RG9CUkE3UWpPR1dFcDFGTXBSTFZWRDRVUFBlS2l5L0xo?=
 =?utf-8?B?UzNBWVM5SHp1eGxLbmN6Sk9jT1lORENoMEFLbDhLRmZ4UXRNMXNNaGdzN1pr?=
 =?utf-8?B?cHdmOW1qZXYvbjlaU2lmclZhZ0lmdHVHcHFhNTZtSkF2UTc3TUIyUzFDRlBJ?=
 =?utf-8?B?c0tpWnpIaW5BTGFsNDJEajRCMXhacXJXdEtlVFFIR3hNaEhDcWw5VGtOUDVo?=
 =?utf-8?B?cHRHZFRNSWJlZ1FXQUwwVEppVEEwSzZ1cHhtZTNqOEdYQURDMUMrZHRDb1kw?=
 =?utf-8?B?MEVvVnJ1RDFFYUpFUU5MN3Z0TUM4OUhiUlUxZ1JKbi83YmRRNGdtTm1wemVZ?=
 =?utf-8?B?R1RObUJlMzNUbkNNSFBzQTdIMy9OSHlWSWlzb1RYMDFFOG12MDNrYzMyYXox?=
 =?utf-8?B?MldKbGI1N0ZHcUROSmdzZ2Z4bDVLUnpkamRHdmE0eXdsYVE3cTFDZ1lUS0hD?=
 =?utf-8?B?QStoc2JzSTJBU2wwWW9JaWFlZFJwSXE2SXVINXJySEFNMUsvS1B3OGNQVUtW?=
 =?utf-8?B?TVBKNE1TNnp0QWpwWkQzMXB6V25PaW54eWRLS1dpMW9Da29NU3JZam93Wjh1?=
 =?utf-8?Q?DD1bQGVxZVOQXh/e+irmj0iEE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A09F0956D7AD648B02D080C089835AB@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 51675d94-da62-4923-efae-08dc151d8f1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2024 16:26:27.8808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4PmZ7EoIc/lYydMagYy3PsqMbQDf7WhGUz9Q242URL+EFyHCuLduRUhOeicxHa25g7X2p3fYOdQyjxrofdzz8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7827

QW0gMTQuMDEuMjQgdW0gMTY6NTYgc2NocmllYiBKb3N1YSBNYXllcjoNCg0KPiBBbSAxMi4wMS4y
NCB1bSAxODoxOCBzY2hyaWViIEtyenlzenRvZiBLb3psb3dza2k6DQo+PiBPbiAxMi8wMS8yMDI0
IDE4OjEyLCBKb3N1YSBNYXllciB3cm90ZToNCj4+PiArKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvcnRjL2FicmFjb24sYWJ4ODB4LnlhbWwNCj4+PiBAQCAtMCwwICsxLDU2
IEBADQo+Pj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNE
LTItQ2xhdXNlKQ0KPj4+ICslWUFNTCAxLjINCj4+PiArLS0tDQo+Pj4gKyRpZDogaHR0cDovL2Rl
dmljZXRyZWUub3JnL3NjaGVtYXMvcnRjL2FicmFjb24sYWJ4ODB4LnlhbWwjDQo+Pj4gKyRzY2hl
bWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPj4+ICsN
Cj4+PiArdGl0bGU6IEFicmFjb24gQUJYODBYIEkyQyB1bHRyYSBsb3cgcG93ZXIgUlRDL0FsYXJt
IGNoaXANCj4+PiArDQo+Pj4gK21haW50YWluZXJzOiBbXQ0KPj4gWW91IG5lZWQgYSBuYW1lIGhl
cmUuIElmIHRoZXJlIGlzIG5vIGRyaXZlciBtYWludGFpbmVyIG9yIGFueW9uZQ0KPj4gaW50ZXJl
c3RlZCwgcHV0IGRldmljZXRyZWUgbGlzdC4NCj4gQWNrLg0KPj4+ICsNCj4+PiArYWxsT2Y6DQo+
Pj4gKyAgLSAkcmVmOiBydGMueWFtbCMNCg0KKyAkcmVmOiAvc2NoZW1hcy9pbnRlcnJ1cHRzLnlh
bWwjDQoNCklzIGl0IGFjY2VwdGFibGUgdG8gcmVmZXJlbmNlIGdlbmVyaWMgaW50ZXJydXB0cyBz
Y2hlbWE/Og0KDQpJIHNlZSBubyBydGMgeWFtbCBkb2luZyB0aGF0LCBhbmQgb25seSBzb21lIGRl
c2NyaWJlIGludGVycnVwdHMgcHJvcGVydHkgZXhwbGljaXRseS4gQnV0IEltcG9ydGluZyB0aGUg
c2NoZW1hIHdvdWxkIGFsc28gY292ZXIgLXBhcmVudCBhbmQgLW5hbWVzLg0KDQo+Pj4gKw0KPj4+
ICsgIGludGVycnVwdHM6DQo+Pj4gKyAgICBtYXhJdGVtczogMQ0KDQoNCnNpbmNlcmVseQ0KSm9z
dWEgTWF5ZXINCg0K

