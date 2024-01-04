Return-Path: <linux-kernel+bounces-16581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D4982408D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74771F26C0E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3239921112;
	Thu,  4 Jan 2024 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="I9G8OF+a"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3629210F3;
	Thu,  4 Jan 2024 11:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGm/6dHOyOTDRraak5a3G9ygHdcBXlGSx9g9LD6MGYW/f3p+kg1hGyxJSUwR+QDasBIZiUONQAHVskcRP1Fn1OVbv+bv8MdZWNfrEvkToiubnlGp8iHHwjwsnQ/vnX+dmj7VTxqOgcg7/VQkiAa2gi7HKZNb+sXwxmmuCuO/2T3hc2A4wnPoKT59TXOAD54YrFQi7J1PNkpMrxKorZOKurMFn4orT4D3PHPK5WJvuqvVSDaMFcKksGsREj1lEwj4lK3uqL9+u8ZAgIHc5vOQ9bb1/zQwaxqJQ0tSjDAw9kfqbl8rzPTbCoavgjQJUfWmoW0vmNT7i4Gr5r0LMqdVsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCsNf4nK2zjl0zVSoofgLUFnGt0K3HKReArWSdHZVTU=;
 b=bGiflmbYr7AJngLROquso64pHJ70s1fpCWO8tvCQJB7h5Eafos0rh8SSqMSGATaSLXt/84DtVEJ06KURhr4+sDE9QVs9j2YuPkDhuyE4RK9StG3CzUr8ffXOWLLSHmKsttD/HmD1NiAALo1Vsn0sF1eJukQq7TgH0T8wiQvGvdPRH/nVm3Zhzt5RnSTzOQkqSViZzVS4KPHWegzKvupMJFf+6ra7GLHjovgdsWMoNbZ+xwTP4SEHKKnNfgQEenD8ZJoSMMMa77Q6vZiwVC8O4dP93lIjgCxOOKU8qLKPAwpqa7XuaierIRIDXRv9M2o/jmTZMPJVZ/2Mf5OA5n5/UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCsNf4nK2zjl0zVSoofgLUFnGt0K3HKReArWSdHZVTU=;
 b=I9G8OF+a+u7cf5NhnBHplfx4U6Swpj5nPeFjJDXBM85UkLNTFkN4dZIHfXWvrNKOPL61pGJbr31ys6VMe7YW5qZ/f/GRXQV19TkZAbWXO6aQLOYgGmhZF/ZkWAdPfMYlxXSc30tnPibMu7w+07bgAcAuyFM2m9BTfOeRzGC/E84=
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB9PR04MB9378.eurprd04.prod.outlook.com (2603:10a6:10:36a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 11:25:38 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%6]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 11:25:36 +0000
From: Josua Mayer <josua@solid-run.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Nishanth Menon
	<nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo
	<kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] arm64: dts: add description for solidrun am642 som
 and evaluation board
Thread-Topic: [PATCH 2/5] arm64: dts: add description for solidrun am642 som
 and evaluation board
Thread-Index: AQHaPjfQD2Hm5iwN2EeNfOjZgITuSbDJSgwAgAA0RACAAAXPgIAAAOoA
Date: Thu, 4 Jan 2024 11:25:36 +0000
Message-ID: <1a7c032a-a1e7-4956-99dd-208dd4bdf8a4@solid-run.com>
References: <20240103-add-am64-som-v1-0-dda1f9227aef@solid-run.com>
 <20240103-add-am64-som-v1-2-dda1f9227aef@solid-run.com>
 <eb90f92f-de58-42b2-8eb1-9d78e1fd7a60@linaro.org>
 <0402b960-6daa-446b-8503-d991deac5532@solid-run.com>
 <c28ab577-35ad-45f6-8be4-08b441cdb50b@linaro.org>
In-Reply-To: <c28ab577-35ad-45f6-8be4-08b441cdb50b@linaro.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8963:EE_|DB9PR04MB9378:EE_
x-ms-office365-filtering-correlation-id: 46e928aa-b0c5-43a1-bf1c-08dc0d17dfb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Re5O1IWqksgKZl/N5mptZCJ9GrbnjRGZOAlggicgmlTyt/CGWU60KGs3Hmxxm4uKeflbA7FGl1TbHutK2MOfHm9rIriGkMCFsdHXDv/q6kDHjkz9FtNjvnqENG0+uXiamq9Cle0w3zG1/1wzsll9hvEpw4zZE0taXATtcMr2hzn8CIAC0NLz4l+FrkWCnXDr77l5Z2C+IrkJvFYPT1yHSthiD1YVoWdW7ISg7ImKi8AXo+bozPzoOv4bP1w72AVZi8Vi71bYO90Vwx8M8YKU4wocs6IGfaUIqcqyBG6XDDY1zm/iTW8AQIzSx1gNpT10gTOJ0AaJSWLPSTceTzl3IUIqkcgvn7suaLkfc3Cw4VmS9Njs4gGZSWWlfpGa6eY9Rj/LviqcF+aDK8EMD5GMajgzOpSLr4qL/H5FOJgs4VTw3EP+bOOsERUgbdmxIpX9rAKjyCZCu+F5/hHTwvbNMhwOBpD+OQf0eRh9J4OTiBdx3HdKDpNHgVy5LQ51oI5ArcQnqSkacldcf07GfNlKoFWp3JM5u1scRt01ZngF4JbY3vbxIAd9dpVygZ/EbW25DWkO/mcj7WQdoNcwudsBTLeVDw2FSCMC+yt4ZvwqNoHLYe74lZT+/szbWwaOPgr9Opkrl/m1thUzwNgSvPOpSQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39840400004)(366004)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(38100700002)(122000001)(38070700009)(36756003)(31686004)(31696002)(86362001)(26005)(2616005)(83380400001)(91956017)(76116006)(71200400001)(54906003)(478600001)(316002)(110136005)(6512007)(8936002)(8676002)(53546011)(6506007)(66446008)(64756008)(66946007)(66556008)(66476007)(6486002)(4744005)(2906002)(7416002)(41300700001)(5660300002)(4326008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?akFHeGZ3NjdBRzRkamkxeWFzeVMxK0poZXRsSnVyOGp6UllDL1JpTmhiOGxE?=
 =?utf-8?B?RXh0WFBiK2RBZjJ4MnZhenRSandJTThKMWNGUytBZ1RzVG9xWkpicU04L2lv?=
 =?utf-8?B?S2lYMDRVeGIxM3JBQ1Yvd2J0NlE0RjdSMW5hellqd1hhT2ZYRVdrMVIrRExQ?=
 =?utf-8?B?WGhjb1loZkhsc0JscmZRekpLdWpENHZpbEt3WTRJRmd4N01jb3JKeDZwS2xu?=
 =?utf-8?B?UHlSOEt2UEdxazBaV2s3bGlnYStydWpNSktzOUxkSjVYWE16aTkzVklxdW51?=
 =?utf-8?B?dGh1UUxmcFVCUDZ5dTFtYWhtUGR3OTFFbDlFYUVHY0JDTC85aC9IVk1RWUkz?=
 =?utf-8?B?RWJWdWdZUHRwYzl6aHllWklaMHlpTTVZdXE4VWJ6S2pBUXpKSXBlaUdaV3o4?=
 =?utf-8?B?a21zQ0UxT21EY1JZeURDZXRtZS9GeWNvOWJvVno3NXhIbldhRkpqVjdPbHlh?=
 =?utf-8?B?Zlg3am1UWThUdXZFMjE3NVpnRVRHZW5INTdzWVdCZ3VaMGFleWQ4VVhDdzlW?=
 =?utf-8?B?aU5EYlErR2JxMUkvOHpiRWZLL21LbGw3Q081bHFUNUZzYklSVjUzbHZ0TlZs?=
 =?utf-8?B?bllpb0FFQTRYdXQxT1ZGVkJyYzlJTTFRM1ZhRFl3ZHppbHlwQWJqOEJmYkdI?=
 =?utf-8?B?amdkakM1NTM5UVhvdncvc3FrQllaR1VhcktHcEZKbUh4VGxZYUZreFBRUTlp?=
 =?utf-8?B?dGxzYXdnbi9tc1JCTTVTQ0dEUUhBaUpXRGtrYndsc3VycUd0eVR3WmFYSEVi?=
 =?utf-8?B?SU9GdzB0TnFTMEJVZVhDKy9pTFJob3NVeUNXczJkWmNlUVd6S0NyY2h4TU9h?=
 =?utf-8?B?ckFwcHBQazFHV2N3TThmN2hiclk0Y0ZVOW1UZ1N2SDBUR0tDM09aWHFSd2sr?=
 =?utf-8?B?a0oxZkRwc0tMMkg4cW5wTU5Tc3Bqdmpjd25hWTRXdEFkemNrZ2YrL1BxQmpB?=
 =?utf-8?B?c01RZzJ2SlMzeFQvOEtWdXNhSUcvSVQvZXVEaDRxVGtaZkRXL1g3Yit3YVdn?=
 =?utf-8?B?MlJ3ZUJHcjhBaGVNYzJkUjNEUitqYVpqcDNuckZwZm8xNkM4V2YvUW5sdzJz?=
 =?utf-8?B?Y0FmWDlGcWpXbHhKNGpXRzZGbkd3TnAvZURRRkZTdXRydnYvcVlyWlBCdWVr?=
 =?utf-8?B?dVRTM1JPcFJPTW0yMDYvekV0cWN1Y3pndTE3TUkwUCtLQlBldlZ6dVdhNUxn?=
 =?utf-8?B?M05JdXA3T1pOeDZJNUV3SHVpdHdEZmZkSzhRZy9ka0l2K2RQZk1nZmo5UDBH?=
 =?utf-8?B?RWlzc0E2L3g2NVRLRmNrREQxS0x5MnovNnNiQ280ZnZmbHQrVDk1QTZEdnkr?=
 =?utf-8?B?cXJRK011bkNMNWJCTWdOZzJ2VTRRb1AvMXF1TUFENWFuUlpOQTJqT3JkZ0NJ?=
 =?utf-8?B?bGxjUHVFNmVwK0pyTDdMZkFkckJncVc5R2hQSUJycEU1cGlnMkJpU1hZejh4?=
 =?utf-8?B?akNHMVludDVNc0R1R0gyMFhnUFBQTDhLbXFQZ0lLVVBQLzBIM0Y1ODBINkRH?=
 =?utf-8?B?Y1FUS1N4N3h5dTdPSmJ0SmF0Wmo4ZGNBUEdmcXZZbDVLM3EvZnhiVzVhRzB0?=
 =?utf-8?B?MkpoRWVQVzJaTjFlRHdReldaRmFNOEtnZWVmN2QrK0ZZcS9xT1VtWXl2YVBZ?=
 =?utf-8?B?WEgwdnNlTjNnMk95U3F5OGhLQzhBOG5TRUloZHlLTXNaREwzajZ3eThWb1h5?=
 =?utf-8?B?ZWxkd2xITlFKTWRMTmlrYzZNNTJMZ1pQYkdrL2NZclV1THpHampzTnFMQUFV?=
 =?utf-8?B?eXVkbUo5SU51ZXlJZDRKZ0lyWDRTN3JNb1pXaXZNUFdmMlUvNEdmVy83eHVn?=
 =?utf-8?B?VzZjWXBIRFozZWZDZ0MreTFQd2Izc1crUWlHSjNxVmZ2dEs3SS8xclhWclU4?=
 =?utf-8?B?YnhPUDVEVmRDOTVza3h2Vzc2elpBU0R2eUZxanNtVlJvYWlsckdhVXQ2alJO?=
 =?utf-8?B?MUcrNVFyVTEwd3NlK1BKbzMrN051V2J1QjdNL3VpSnZNSWRWSmJnZjhFampp?=
 =?utf-8?B?ODhxTXk0WG9uUGhnYkpXRHdsL1NHWWR2Z0UvbkU5WlNQVi9ZWVBRYXJPRjFh?=
 =?utf-8?B?MWl2b0dKMEVUMUd6dURwWDNsSXdJbU9SU0IxV09LaW1iblRBYlJwdUxiTStW?=
 =?utf-8?Q?Bw7pDPsLwpuCdTHQaPFS8Whth?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <62F89F8FDD5ECB4AB5DB9FF44DCE1095@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e928aa-b0c5-43a1-bf1c-08dc0d17dfb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 11:25:36.8575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zp3tmhrJ6LzVTdjseQX6UtFRk7nxv/eSbMz3h+NOJCEZFdlFYAyv81TZANrTgoCE8tG9l1jHBdCKeHd75CapUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9378

DQpBbSAwNC4wMS4yNCB1bSAxMjoyMiBzY2hyaWViIEtyenlzenRvZiBLb3psb3dza2k6DQo+IE9u
IDA0LzAxLzIwMjQgMTI6MDEsIEpvc3VhIE1heWVyIHdyb3RlOg0KPg0KPg0KPj4+PiArDQo+Pj4+
ICsJbGVkcyB7DQo+Pj4+ICsJCWNvbXBhdGlibGUgPSAiZ3Bpby1sZWRzIjsNCj4+Pj4gKwkJcGlu
Y3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4+Pj4gKwkJcGluY3RybC0wID0gPCZsZWRzX3BpbnNf
ZGVmYXVsdD47DQo+Pj4+ICsJCXN0YXR1cyA9ICJva2F5IjsNCj4+PiBXaGVyZSB3YXMgaXQgZGlz
YWJsZWQ/DQo+PiBOb3doZXJlLiBCZXR0ZXIgdG8gb21pdCBzdGF0dXMgb24gbmV3IG5vZGVzIGFk
ZGVkIGJ5IG5ldyBkdHMgZmlsZT8NCj4gWWVzLCB5b3Ugc2hvdWxkIG5vdCBoYXZlIGFueSByZWR1
bmRhbnQgc3RhdHVzIHByb3BlcnRpZXMuIG9rYXkgaXMgYnkNCj4gZGVmYXVsdC4NCk9rYXksIHRo
YW5rcy4NCj4NCj4+Pj4gKw0KPj4+PiArCQkvKiBEMjQgKi8NCj4+Pj4gKwkJbGVkMTogbGVkLTEg
ew0KPj4+PiArCQkJbGFiZWwgPSAibGVkMTpncmVlbiI7DQo+Pj4gVXNlIGZ1bmN0aW9uDQo+PiBU
aGlzIGJvYXJkIGhhcyBubyBkZWZhdWx0IGZ1bmN0aW9uIGRlZmluZWQgYnkgbGFiZWxzIG9yIGVu
Y2xvc3VyZS4NCj4+IE5vdCBzdXJlIHdoYXQgdG8gcGljayBmb3IgImZ1bmN0aW9uIiBwcm9wZXJ0
eS4gQ2FuIEkgb21pdCBpdCBhbmQgc2V0IG9ubHkgY29sb3I/DQo+Pg0KPj4gSWYgc28gLSBzaG91
bGQgSSBkcm9wIGxhYmVsIGNvbXBsZXRlbHkgLSBvciBrZWVwIHRoZSAibGVkMSLCoCBwYXJ0Pw0K
PiBUaGVuIGtlZXAgbGFiZWwuDQpKdXN0IHRvIGJlIGNsZWFyLCB3aGljaCBpcyBjb3JyZWN0PzoN
CmEpIGxhYmVsID0gImxlZDE6Z3JlZW4iOw0KYikgbGFiZWwgPSAibGVkMSI7IGNvbG9yID0gPExF
RF9DT0xPUl9JRF9HUkVFTj47DQo+DQo+DQo+DQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9m
DQo+DQo=

