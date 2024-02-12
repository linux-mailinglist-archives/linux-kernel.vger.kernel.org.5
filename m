Return-Path: <linux-kernel+bounces-62459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E10852118
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5F821F22030
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54B94D9F0;
	Mon, 12 Feb 2024 22:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="a7o3Kbg8"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2100.outbound.protection.outlook.com [40.107.241.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FE51EA78;
	Mon, 12 Feb 2024 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707775906; cv=fail; b=T5OM0XmHXjXmGZh5MheagXMqyH4ktgB+b08IwDyAU+IkVfZNfbXR0ZD2MEt8cwaiB5+1tq9a+WpudHWPAd5Lcd4tUIshKILO8hSUF4tUZS+1EtaywTC9Mf/WSyvX2P7CV0mLx3e1ELlZ1E4ESATKO+SivLbFQZcqAHrljrqLmLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707775906; c=relaxed/simple;
	bh=sjKa5UKwhhmddpO7OKONcE3zNVh0JgzWHgj7faHKz8E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nwhhIbcWsbWDARqve4e2lUiA07iZoagSLNegcld8yEY9/Wbd0GrafjxkY//hC9ux4RLyH5OiIbxe0533du+JWFObkyrfYphxGPofk24ZFMaD9MX8sNamr5Tr0V++RhklLLQ2kJ1nlW72GVtYJoBp93DlX6/XYwQw/u+NV/03qYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk; spf=pass smtp.mailfrom=bang-olufsen.dk; dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b=a7o3Kbg8; arc=fail smtp.client-ip=40.107.241.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9FheKJexLnLVMCZjn8WMNjEpxb047CMyqclOCZH4RLgnSjy95lfoGqUk1jCPaBV+djD33r4Byt+0oU3w+mLwro5bs2/c4IaSsPhAxpyT4KUQXD7HWrxTZjZglVViC2qDrfnNkZ5RwjNarz2LB4oROhmK63r4buDJEjnjTjfzAkCTWypATrWW2QCiDl4JiOgHKb7MXVQSokEVY5wKJQGavWY9M68gAsvQ1j35NPiItV9nnm1x/DgTV4FILVuURqBoNeKz9cLLAL61XhTwxp5ey+ngBka0f6HvWx18CR5jlva1TLMjH4IX2Hx3XHBK3dnvmXdwz8XO9JJovx9B6sGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjKa5UKwhhmddpO7OKONcE3zNVh0JgzWHgj7faHKz8E=;
 b=gAZu3AH45ox+xvHarhcI5oFeJY0jIbqrEryWvTgXqDmhPVjJLAuLmFvO/Y6PZWxESoNDVu85ZsMAHqBi/5zuS8Iho9kipQtv4RdZKWeBJ+UZj/BMYa5yzEskOAc5m8AkT/xUsHtOt42QwxkuuGtCp/LmTneBPvYg+zwFsckdyd0Kt1TYr8/Lxt24Txbz02mWFSBxmdmLezTjUg++JqD9jFy1ilRNDheejkOOm0dX5tllbkSSE+Q2sWfkSAlyHMKjEuErKZYM6dTxhhCGhcSSiefBzxlbrB4u2Oj5VzM+ZKP4Fhmqo39+xDgwVw4c9VhCoXjigLCY5xFdE8CL7QX56g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjKa5UKwhhmddpO7OKONcE3zNVh0JgzWHgj7faHKz8E=;
 b=a7o3Kbg8axCDYSoNQHW8PNc6Co80CDlUY0mhuqf1Mm/qihPEzIwWDnnQxvePVRB86JlwDXOe7moH4j076JthOK0gB6pt8noU2pQAqaQlTavUKIIhXSIesm/ttWdnfnA5xQHXqjSHV+cuIVWVw6bVVi6yLwmcUFhRLtNSHqB2KCY=
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com (2603:10a6:20b:53e::20)
 by AM9PR03MB7882.eurprd03.prod.outlook.com (2603:10a6:20b:435::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Mon, 12 Feb
 2024 22:11:41 +0000
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::3c77:8de8:801c:42a7]) by AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::3c77:8de8:801c:42a7%4]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 22:11:41 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
CC: Linus Walleij <linus.walleij@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: realtek: fix digital interface select
 macro for EXT0
Thread-Topic: [PATCH net-next] net: dsa: realtek: fix digital interface select
 macro for EXT0
Thread-Index: AQHaXftVXMm0w9i/N0+x56Cz2hlOWbEHRPEA
Date: Mon, 12 Feb 2024 22:11:40 +0000
Message-ID: <jwuivjydlckjedwovyclamepv7loyzu7uvik3jupbihb5j2yh2@jeo3cgxc5ztt>
References: <20240212-realtek-fix_ext0-v1-1-f3d2536d191a@gmail.com>
In-Reply-To: <20240212-realtek-fix_ext0-v1-1-f3d2536d191a@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB8805:EE_|AM9PR03MB7882:EE_
x-ms-office365-filtering-correlation-id: ccf3dd10-d958-434b-4029-08dc2c179704
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lXLP6UPzABrplWS6FlymuCjRE6q6yUtvHkxd7K7pr+8WBMvHyTr3sPgEBx9XEnx7Hafv3g1r7J7I5tLOVNaT+4aCEdeDb3X4cjJBWAQ4f9GbMGoRMOi54lrzZS0/kjF5OXC7ioVeS1kRJhcciY+JXu9b6bk4HIb06a0vQdomONMsF7PijPvd49j74aGXPniXVzzfdlqKB+TVhCI16R7XvPzRSZpkVt7KqWsmCGrgAZwjLwMhgQ9ybPvSK4k5zmVcqlkQu4YKkM5+NeOomED8Ynk28WGaS6+03OHPTjZz4p4BsBK3jeAe6gMyZh5oaWDCj8zM4mh1LQIuJhcz1ds5iwbJie2jOJXJ+8LP8WAE9XkMG6pGtzcG+1kZ6YB1oi//y4m6EolFsBsIRd/LvE4Y9QETD5vXz8i9GfFrnAt86v4ZrP5Qo2pA/vUgznyI5eVeta5GmOLgCbYAM5oC4jWDFWPUKa/pT1ha3MqFHFTBgIylcaSdWxIJcXTFn9PBx4+thkq1dIPVG9wTIdgj59chm9ZT6see1uwxECuVFmIegJbhjlIaDioMPeZu6XBDfm8fVq5Y0EXhkXasZ3J+RJwa7H3aM6r3PyaRoImXtxNQEDFK/mA9DCIQq+4dCHO+Q4yy
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB8805.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39850400004)(366004)(376002)(346002)(136003)(396003)(230273577357003)(1800799012)(186009)(451199024)(64100799003)(33716001)(86362001)(41300700001)(6486002)(6506007)(64756008)(76116006)(66946007)(85182001)(478600001)(6916009)(66556008)(85202003)(71200400001)(54906003)(66446008)(66476007)(8936002)(38070700009)(122000001)(4326008)(316002)(9686003)(6512007)(8676002)(83380400001)(38100700002)(26005)(2906002)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z3d6UDVvdmtUMzlSK3ZwZnI3T1A4U2Q4bXdTbmxMNkpIOGN5a21ySDZBbEdm?=
 =?utf-8?B?SEd2czVOdFN3ckhoUldwMUtuMTZnaGVHVzB0d0xFNFJ2cERVV2NWcGxZT0J1?=
 =?utf-8?B?ZVJwODc3NWN0dXZTbnRDQ0syM1BKbEM1MlZTdkNQd29MVzhnT214eUxCWTlt?=
 =?utf-8?B?STBlTkowZmJlWGpYR0luWlh2NnJtMFVKaTYvTXFhR2VQbUlIRWxlQjZWaG5w?=
 =?utf-8?B?eWdZK0tyTUZSMUYzMEVkS05KelV1a0phMFZJRFcvckZ5K0NTczhvb1krTUlH?=
 =?utf-8?B?cnozTCtVK3dmaWpaVlRNUXY3NHZINjlvRUhPcm5veGM2V1hVR3pDcFFSNUNF?=
 =?utf-8?B?QitKSDFqbGJ3d01FMktleXVDSno4VEQwV25MWEx0M2lXaVpiUFNtZFNaSDRm?=
 =?utf-8?B?RXFjQXJUU213TW1PZzd3RS9kR3djWHdLa3o0WkZnY1RuRmdobnRTaFVDcmNp?=
 =?utf-8?B?NWJOSTdBcTlYc3JTRFNDL3ZLQm94T21DN3NZbkVGUUNyaVMwNVlQYkQ5NXgy?=
 =?utf-8?B?UVBwOHM4eW9abzUrUk5rM3ZTL1NXV0ZCUlZrUmtONXZVbk1CKzU0Y2JMMWhm?=
 =?utf-8?B?cWt5RzRGOEJVK3VSOFBjMCtGZzM3ajhBYjFsdXZJelJ1SFljRXFKazY2WnpM?=
 =?utf-8?B?NTQ2T2I3U2gyZDYydk82KzYxa0gvMU1lZVdxUGRvSU9CSHJvdGZKYlozN0pM?=
 =?utf-8?B?c3pqb3BuSDdYeWlGbXQrSFhndU41TzlSVGlHdTZKR2NUQU9IV3pWbDJaUnc5?=
 =?utf-8?B?M2tLWHRjTGNlMDg0ZnZRTm4zRzJZTUJJU04wUWdkOFc4dXdoNkNiRlJFZ3gr?=
 =?utf-8?B?eGRrUC9kZ2VSU2d5TTVINEl4Uno0cm51ZGdoMitMbjd6aFRNakZ6a0c2MG9k?=
 =?utf-8?B?ajV3SzNMZXhlc2kwdERzTU8wZmtybDhTWjVCUzNYZHY3cVAyUmFxYVdQMk1Y?=
 =?utf-8?B?YTlFU3A1OU5DbUpvYkd0MWJIdG1zZ0p2V2NDMFJsNzJEZExFakVnSzFjRlBx?=
 =?utf-8?B?T01uQy90VjQvaklvNlMwODFEbmtlQ0xuK2diKzhsZ0VwaHNvODRick1rd0RR?=
 =?utf-8?B?Q0wyTExQMUdiRHkzTU1tT1J4U0ZRMHFYSGJTYVZoSHFlTEVmdlFFOElucFJH?=
 =?utf-8?B?Z29VMVNvSk1kS29lb0FxVEptN1Y0U1ZPS2JEWFdlaHAwa1pqWUJjbTZqNmRF?=
 =?utf-8?B?ZUdsOHNLWDdkQ2tCQzh6RERleU9yQ0pmRHAzeGU5M1VnOWR4UTNpdTdkblIr?=
 =?utf-8?B?Y0NQOTJxdmR1L3o1NkZBMml5VVkrYTdWQmJMT1luWmRHMGhWYytOclpReDZ4?=
 =?utf-8?B?QWdFeGpmajE4SG54MW5MUnJvbDFGUzArcnNQeVRBSG43eEsxOUlsZ0FPZHdw?=
 =?utf-8?B?VEQzODhXODZxZjBNT2tldng0R0xmNkU0bUszZSt6eHF4RnlMVW1BWUFBMGgr?=
 =?utf-8?B?cmR3d2RMZ2JraXVscVVha1pNdGhEUkpUMmYvcVVObDlBdVJHUFBGSHpYRlFO?=
 =?utf-8?B?V3ByVHRmQ29ibmdEcW5GZlU5eW1SOHovdjBYSkNWei9FN3lsaDVvaGIvNmxH?=
 =?utf-8?B?YjVQNWxpR3ROYTY2T1NyOUZYeEdjbHBwbzNoRStHdkprMG1DR09GSUpOUUp5?=
 =?utf-8?B?alVZV21PT0FxS1R0L2xHaXpBT3dvMHRoT0RMRmZTVGVHZCs0MkkrU0FrWFBI?=
 =?utf-8?B?dVRTTHJjK1lRZ05sQkJxeXI4Ynh1N0xWYmVtUTFzSWJQalJnemR0aCtEM1ht?=
 =?utf-8?B?SHZTK3JUNXJTTE5yTFhpYk1GOUZKMVRMcTNPbzNSa1F5WHdMWmV3VTZ1ZXZp?=
 =?utf-8?B?Wjd0TytWK2hqQnJJc1Q5MzFEbXc4SjZNUGFGbldYazBxR3BQUGNlUU1uZ0li?=
 =?utf-8?B?TlBJQnkyOHJyMHhjczJwTXNmY2tnRGVwUjFONGxnN3QwSkM2MzdITnUyclA5?=
 =?utf-8?B?VHdITXlSZWtFWEZ5SE1rYmFUQzhyaTRJRWZ4VFhTUlA3Y01GbGI2QURnOUVr?=
 =?utf-8?B?ci9YNFlkbzdKRjVSSlFaWWpzWW5HWCs2MVUxMkdKVkRJdkQvZHlWSzBhV3BS?=
 =?utf-8?B?VFZTTGhHUkNqUzlxRnFqL3hObWIzWFA1ejcxd0VSRzZWNGhQM2x4c0cvcXlm?=
 =?utf-8?Q?mUgzS9guG7FC0/FiFrs/khd69?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56A16F7D523F2048ADFDD6FB9A3528EA@eurprd03.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf3dd10-d958-434b-4029-08dc2c179704
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 22:11:40.8692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6peyf2K4ch4dqLaPHYl0MmkfRXDMg8dVaJNLWmyp9qo5WgK1rEVDB26Tozv1Y0aOBSy0p8btd6w20xKjeLI6Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7882

T24gTW9uLCBGZWIgMTIsIDIwMjQgYXQgMDY6MzQ6MzNQTSAtMDMwMCwgTHVpeiBBbmdlbG8gRGFy
b3MgZGUgTHVjYSB3cm90ZToNCj4gV2hpbGUgbm8gc3VwcG9ydGVkIGRldmljZXMgY3VycmVudGx5
IHV0aWxpemUgRVhUMCwgdGhlIHJlZ2lzdGVyIHJlc2VydmVzDQo+IHRoZSBiaXRzIGZvciBhbiBF
WFQwLiBFWFQwIGlzIHV0aWxpemVkIGJ5IGRldmljZXMgZnJvbSB0aGUgZ2VuZXJhdGlvbg0KPiBw
cmlvciB0byBydGw4MzY1bWIsIHN1Y2ggYXMgdGhvc2Ugc3VwcG9ydGVkIGJ5IHRoZSBkcml2ZXIg
bGlicmFyeQ0KPiBydGw4MzY3Yi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEx1aXogQW5nZWxvIERh
cm9zIGRlIEx1Y2EgPGx1aXpsdWNhQGdtYWlsLmNvbT4NCj4gLS0tDQoNClJldmlld2VkLWJ5OiBB
bHZpbiDFoGlwcmFnYSA8YWxzaUBiYW5nLW9sdWZzZW4uZGs+DQoNCj4gIGRyaXZlcnMvbmV0L2Rz
YS9yZWFsdGVrL3J0bDgzNjVtYi5jIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L2RzYS9yZWFsdGVrL3J0bDgzNjVtYi5jIGIvZHJpdmVycy9uZXQvZHNhL3JlYWx0ZWsvcnRsODM2
NW1iLmMNCj4gaW5kZXggYmU1NjM3M2U5NDczLi4xMjY2NWE4YTM0MTIgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL3J0bDgzNjVtYi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0
L2RzYS9yZWFsdGVrL3J0bDgzNjVtYi5jDQo+IEBAIC0yMDksMTAgKzIwOSwxMCBAQA0KPiAgI2Rl
ZmluZSBSVEw4MzY1TUJfRVhUX1BPUlRfTU9ERV8xMDBGWAkJMTMNCj4gIA0KPiAgLyogRXh0ZXJu
YWwgaW50ZXJmYWNlIG1vZGUgY29uZmlndXJhdGlvbiByZWdpc3RlcnMgMH4xICovDQo+IC0jZGVm
aW5lIFJUTDgzNjVNQl9ESUdJVEFMX0lOVEVSRkFDRV9TRUxFQ1RfUkVHMAkJMHgxMzA1IC8qIEVY
VDEgKi8NCj4gKyNkZWZpbmUgUlRMODM2NU1CX0RJR0lUQUxfSU5URVJGQUNFX1NFTEVDVF9SRUcw
CQkweDEzMDUgLyogRVhUMCxFWFQxICovDQo+ICAjZGVmaW5lIFJUTDgzNjVNQl9ESUdJVEFMX0lO
VEVSRkFDRV9TRUxFQ1RfUkVHMQkJMHgxM0MzIC8qIEVYVDIgKi8NCj4gICNkZWZpbmUgUlRMODM2
NU1CX0RJR0lUQUxfSU5URVJGQUNFX1NFTEVDVF9SRUcoX2V4dGludCkgXA0KPiAtCQkoKF9leHRp
bnQpID09IDEgPyBSVEw4MzY1TUJfRElHSVRBTF9JTlRFUkZBQ0VfU0VMRUNUX1JFRzAgOiBcDQo+
ICsJCSgoX2V4dGludCkgPD0gMSA/IFJUTDgzNjVNQl9ESUdJVEFMX0lOVEVSRkFDRV9TRUxFQ1Rf
UkVHMCA6IFwNCj4gIAkJIChfZXh0aW50KSA9PSAyID8gUlRMODM2NU1CX0RJR0lUQUxfSU5URVJG
QUNFX1NFTEVDVF9SRUcxIDogXA0KPiAgCQkgMHgwKQ0KPiAgI2RlZmluZSAgIFJUTDgzNjVNQl9E
SUdJVEFMX0lOVEVSRkFDRV9TRUxFQ1RfTU9ERV9NQVNLKF9leHRpbnQpIFwNCj4gDQo+IC0tLQ0K
PiBiYXNlLWNvbW1pdDogMGYzNzY2NmQ4N2QyZGVhNDJlYzIxNzc2YzNkNTYyYjdjYmQ3MTYxMg0K
PiBjaGFuZ2UtaWQ6IDIwMjQwMjEyLXJlYWx0ZWstZml4X2V4dDAtODA0YWEzMjcyYTc2DQo+IA0K
PiBCZXN0IHJlZ2FyZHMsDQo+IC0tIA0KPiBMdWl6IEFuZ2VsbyBEYXJvcyBkZSBMdWNhIDxsdWl6
bHVjYUBnbWFpbC5jb20+DQo+

