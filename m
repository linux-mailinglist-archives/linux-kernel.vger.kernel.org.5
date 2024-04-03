Return-Path: <linux-kernel+bounces-129234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1714189676D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3669D1C25BCD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C06D608ED;
	Wed,  3 Apr 2024 08:00:21 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2109.outbound.protection.partner.outlook.cn [139.219.17.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F121BDCF;
	Wed,  3 Apr 2024 08:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131220; cv=fail; b=aICZbrCP0iWk8wvtlJog7YwqY3DAfY0W6dR3E9JqsgcjUqRLg1dlG/2vpzLNdHAkGHVOSxXAVbimD+1jdquoj+GWY0fRbRr9QrcENaWBAC93QwRnGgd9ztmYrj48JoYsa/sRWF5iSzosvD1XMH1Yxb+8vkfx3W9LBDH0wfjay6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131220; c=relaxed/simple;
	bh=b2/VYjL8+3n+GjD1ETA75SEdhuxr9kuJQinwlENNJFs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uvWS0Na7srk4z8zbItsQfI3YgagjBuN3EAzX4neUamcRS1cvXo8Wir9CwroZdAmGlbXCuc2nc10DIkA4JDsJa9rInwCuInivsgFsAIEkIycoh0l0YcwmSZ/frzh/PVEIcY/cS+3yEe/TqLFMaUdAKcntoPDK+fdo6tjlU6hJk9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmahqf0E/V9XUsvrM4NCPz5uU+civopkvzH2YTl2muGqxttUJOosPP5ozJ6e/gvECIDFwIID7Ig18vaqILZFjv+gram+8ntXsDMW+QIaRoq/Ls0oWOh4vCH58nM3o9k9Rgc/Ed3gWiuDC3jcwck0P6jn7l4aGz23xWtA0uc53L/7Bl4ad0VG5AgR+WCLGmYs3RkiWqqMdjk64zZ4mZSJjuD8ko9NuTf6GqvAi+cc7P4Awae+ka03sgDk9mgu8uRKrdGkJDZsHPj8eZ8EhztdWGGpbZByZWv495Ss5YWGmu5MAtiLr+FyClfyCpfmBGyRPbbMH9HhD2blbTwA1n3jwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2/VYjL8+3n+GjD1ETA75SEdhuxr9kuJQinwlENNJFs=;
 b=StBxjoWQ48Zw2oUcARDf4zuyN4E+stv0zXOOAsSVNpzyvtb05SdNjdFB+Ll2dNjcdEMAGfsFaf6h57HE/nbjR0Y0+bNzxbiDdhDHZ1lIKYjnfEFA25HX4BKKRGRjNI6+cN4jI7T93h+c/rClZ4mEeJbvBpoXieXvxGkI/DTAvVKivtS6BLgDmLQLTUDEX2f3h2paE0t29Epb3WgN6XVdXap+4V4MsVJT+AIVd34WPe2TtPbN1si9OzUOMOjVo47HWhybmJdbZpwGnlaE4RSL8/2MaqMtbNzqu3wK08ltLei8SAlm4mHcoH4MVLC2aIxmAfLR8wTTdMdakqJK610gSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1114.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Wed, 3 Apr
 2024 07:44:36 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::9a50:2c82:c5d4:2b3d]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::9a50:2c82:c5d4:2b3d%4])
 with mapi id 15.20.7409.028; Wed, 3 Apr 2024 07:44:36 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Conor Dooley
	<conor@kernel.org>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Hal Feng
	<hal.feng@starfivetech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v3] clk: starfive: pll: Fix lower rate of CPUfreq by
 setting PLL0 rate to 1.5GHz
Thread-Topic: [PATCH v3] clk: starfive: pll: Fix lower rate of CPUfreq by
 setting PLL0 rate to 1.5GHz
Thread-Index: AQHahN18qtXBKBZlXUquUnYUH2QsmrFVKPiAgACsqfCAAFBPgIAAA5cA
Date: Wed, 3 Apr 2024 07:44:36 +0000
Message-ID:
 <NTZPR01MB09566AB865A0266332268DC69F3DA@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240402090920.11627-1-xingyu.wu@starfivetech.com>
 <8d21b1bc-9402-41d4-bd81-c521c8a33d2d@kernel.org>
 <NTZPR01MB095662C4A6FCAEB7B35C48FF9F3DA@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <bcf12c0b-d569-4d64-adfb-bad053c182a8@kernel.org>
In-Reply-To: <bcf12c0b-d569-4d64-adfb-bad053c182a8@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1114:EE_
x-ms-office365-filtering-correlation-id: 6a8f81e3-fc2f-4b34-4548-08dc53b1e94d
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Re+irz25jQxh6ToxJivlA2P9uc4YJlXfP9LkfCbSQ0+SasNuwef/PpoME/2PuUL8hMziq2ox+eFcCGe6VqpPJxfjZ+cBwKBuJZm0sIwHjtgADnh9FrEtWIncESA7emXOlH87JrCl6DF9HFKCWCiuOGnD78XQCgr76U5xR0LUV4ImcFYBIi1R47yVE94pY3c+YRwf0l/fn7NCWA2D1bII4iW2uYSHGUoEPs/cFSxtLani7bM69Vt71qMYML6yT6yne5c6fifs6LrBCZEpjEGGoO3KRR3zj/kpgDKxCAKW9l1Rb9CjkFB34jH0C1kL/cQVv4CgaNZ/3hpaKek5rKPVov3uYHFqZIK767t8xusTMDU3sXCf7TB8k6XqroX7xlaOI+nN2TZ5shq3jiO2nlAMukaIlTdAEHUeW5V4bM/Qk16/PWF+BeeQ+1W+h8Yl/aBINXcEfOR2fAddImE5Ue5JCzzIKR6RVAij6EnZAM+gadUwYebIkLaHdrkiTGlOFVXP6G6zwkigNVgPqxRuYSFjJfmL6IcsmjVDPYbT5Ttfsc3td/w9utmGq3fSIA+TTHNAEme51sMcxKxAf0n1gQsMky5LE6EKNkRmhDDFhD3MdPJwcAkcWp/3n1X1HlXfUBep
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(41320700004)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QmFoYVpBbUNwY3UyNGNrazdycG5uUnp6anBKOTBGcXFVQVpkNlFXWVREZ1lC?=
 =?utf-8?B?UThnSVVZK1VCSkhCeFJVUW5aVFhnbU5HSHV4b3JVV0hQYThEc3hxSFIrRksx?=
 =?utf-8?B?YngxcTFUMHR6L0lRcEVNcWp0TDlha1gybnJGTW5mbm9wRUdyV1dhTk1rQUVH?=
 =?utf-8?B?bFV2eFh6SldObGo5dUpmQkduTW91RkUzcVpmTG9oMkFXWHNuQkh6V3FNblBH?=
 =?utf-8?B?TWtaSTVKRSswL05vbHRKOTJhNTVkK2x0dU1mYUxOOHAxekdJdVJuZXhIVkhB?=
 =?utf-8?B?UkFFRTRVbFlieHRhdlBEc3dCNllMeVFQNlgyVFJnUHBLcmw0MmpHU3pySi85?=
 =?utf-8?B?bDZjd2xHU2VPSkZoT0lFQ0Z6UkZ1TVp5V0pjSTY2aERGVldRYWJDY2JzUmhm?=
 =?utf-8?B?Mk5jNXM3d3F5cUtpazFoNUhhcTdYYVJLaHdoNXRxNGlmdDErYkpnVDBDWnYr?=
 =?utf-8?B?V0xwTXRCQ0gvRThpYXczaXJnV2taT2l0czhPc3RMU2VQWm9QZmRja0tKQjRp?=
 =?utf-8?B?NFhDWEtSQXZBdk9VVzd6V3pTSHJDanJjU0xjQTBaZW1ZMEZKQnFCM2NjRWIw?=
 =?utf-8?B?QTVSUEczbjl5ejU2WVN3Q0V1RjBWWFJDYnhSWG8wQ09IM1doWFcyNnExUVZF?=
 =?utf-8?B?VUN3TUpKUFlJckNsRDlvMkhQSFlsUnhpd2NzMG04NC84VnJteTJHNEJxdnVL?=
 =?utf-8?B?UmFXbEZpREZMaFdEU0Vvelc5eWZNZGpnazJLTGloYjl5TEpVRzBpWnRpaUxD?=
 =?utf-8?B?ajh3MWpoZjM5dk94NFB3cmJzOEhoMFFxY09KdzZyWjdxZUZkZnNuclRZdXZL?=
 =?utf-8?B?bU9UZ1B1bndYcnlsWXJaK0RIbHM5VGVzSXBsU0ZXWlFMNFArTFFVT3FSQVJw?=
 =?utf-8?B?RDc5bDY0T2ExVWVBZS9uVDhSVU1FRUpGOEdTanBUem0rQlpDVmplT2tQV1oz?=
 =?utf-8?B?VWhBTzRQM1JQeTZEaWJ5Z0ZYNGVDeFFNcitNeFk3T25vT0NpWEVjSUdYOG0x?=
 =?utf-8?B?RjRxby9NMWlxTGpFU1EzdnV3TGx6YmNkVE50VTlaNTNQN0xQTWwwSXJWTmg5?=
 =?utf-8?B?eXdENHl0eW5HcmRQYVlHNHh5TlU5UHVZcGFYNjgwMW84bWVQLzJ1RnFsVkI0?=
 =?utf-8?B?cnpWSUM5MThyTTJDR1JJbG9ZSGZTd056MFVaanh5Wi9JYTBzbWlva2xMd0Nl?=
 =?utf-8?B?dHprK3MwQnFJdEw5akgrQ3h4S1p5SU0xNmFpanFFTDZLYk1ZaWZPK3VHb2s2?=
 =?utf-8?B?dWxnQUxERG1UUkg2YkdxYTRRYTRqMitYNHRvNWFHMHB6RFZqL1ZrVFZRT055?=
 =?utf-8?B?T3owdVNpakRIOGZQOGY0UkZ4Y0NBWnFkYjVzWmRidkZKYkp3cmZjODVkNWtv?=
 =?utf-8?B?dk1YK3ZTOGlMOXo0Q1k5TnVzT2xsVUhDQTNaRU9NRXBWVzNVRExpVGVWWjZB?=
 =?utf-8?B?MUQ0c0xGZzNDN2kvRjJaWVA5SG9DeW1QMmRGUXQxb2E1OEt6c3Jia1E4QWJz?=
 =?utf-8?B?TC9mbVdidjIrUVJlK25zaHdKTTlLOVRSU1pRZHA1L0Q4RjY1aTJNUVZ1TTla?=
 =?utf-8?B?ZHZvWnZRNVdwVGVoUjRrUDQxVlhaaUEwbzViTENzdThiY2VrZVc2ZTUzYTI2?=
 =?utf-8?B?QmFKSTJxdEloMDg4RjZoOWdUR1k5LzQ1MFBLajZyNGFGYitGc2JacnAzTVJ2?=
 =?utf-8?B?M1g0eFRhenpmejFNWHNOQytMcmM3Yk9NS1V2MFM2YzYyL2JJUWQ1RGhPMGEz?=
 =?utf-8?B?UERVUXBXVHFmMXB1VlB6MU5wMk96OC9rQTQvcGxBakljemkzY1R0ajhNcUs2?=
 =?utf-8?B?bHl1RWoxQkczU01KRHZjME5FeDdGdWNNbmRNL2hiSXhBYnBkUlY5UzVPY2dW?=
 =?utf-8?B?S00zZ0hVTnpiYU90QjlnWTZKcXFTRDVxemsxVFZtTlhJa2lQdXlEUVAvcXFY?=
 =?utf-8?B?aFJYUlZmdG1uZS9tTlFJNGhXNE5XQjN0WEVJTzVnVkRSdUlDRHFmL0o1cG5E?=
 =?utf-8?B?TFY4NmZ1TWplT1E2MHg4Y3RlUzFsRjVVU3hmaGptZ2ZtNW01VkxjbnEzb3pY?=
 =?utf-8?B?bVAvM0dmSncxQkRDbi9BN09tUk1yVzh3dDFkc2FkRFpLWTZrdURxNVpxOStF?=
 =?utf-8?Q?3Iun1j9AhUOQSvstHLVnwyhqQ?=
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
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8f81e3-fc2f-4b34-4548-08dc53b1e94d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 07:44:36.7969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UpwxDD6PRE8p1fqLUR/iIHwPu7IqxAbVa61DJWLfa42XUHRMmnpcnU8GcB0MTs6ACV5e5tvpgN4l3q0W7zrh2rIt657CPkzhrxJdyZHyJTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1114

T24gMDMvMDQvMjAyNCAxNToyNCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gDQo+IE9u
IDAzLzA0LzIwMjQgMDk6MTksIFhpbmd5dSBXdSB3cm90ZToNCj4gPiBPbiAwMy8wNC8yMDI0IDA6
MTgsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ID4+DQo+ID4+IE9uIDAyLzA0LzIwMjQg
MTE6MDksIFhpbmd5dSBXdSB3cm90ZToNCj4gPj4+IENQVWZyZXEgc3VwcG9ydHMgNCBjcHUgZnJl
cXVlbmN5IGxvYWRzIG9uIDM3NS81MDAvNzUwLzE1MDBNSHouDQo+ID4+PiBCdXQgbm93IFBMTDAg
cmF0ZSBpcyAxR0h6IGFuZCB0aGUgY3B1IGZyZXF1ZW5jeSBsb2FkcyBiZWNvbWUNCj4gPj4+IDMz
My81MDAvNTAwLzEwMDBNSHogaW4gZmFjdC4NCj4gPj4+DQo+ID4+PiBTbyBQTEwwIHJhdGUgc2hv
dWxkIGJlIGRlZmF1bHQgc2V0IHRvIDEuNUdIei4gQnV0IHNldHRpbmcgdGhlDQo+ID4+PiBQTEww
IHJhdGUgbmVlZCBjZXJ0YWluIHN0ZXBzOg0KPiA+Pj4NCj4gPj4+IDEuIENoYW5nZSB0aGUgcGFy
ZW50IG9mIGNwdV9yb290IGNsb2NrIHRvIE9TQyBjbG9jay4NCj4gPj4+IDIuIENoYW5nZSB0aGUg
ZGl2aWRlciBvZiBjcHVfY29yZSBpZiBQTEwwIHJhdGUgaXMgaGlnaGVyIHRoYW4NCj4gPj4+ICAg
IDEuMjVHSHogYmVmb3JlIENQVWZyZXEgYm9vdC4NCj4gPj4+IDMuIENoYW5nZSB0aGUgcGFyZW50
IG9mIGNwdV9yb290IGNsb2NrIGJhY2sgdG8gUExMMCBjbG9jay4NCj4gPj4+DQo+ID4+PiBSZXZp
ZXdlZC1ieTogSGFsIEZlbmcgPGhhbC5mZW5nQHN0YXJmaXZldGVjaC5jb20+DQo+ID4+PiBGaXhl
czogZTJjNTEwZDZkNjMwICgicmlzY3Y6IGR0czogc3RhcmZpdmU6IEFkZCBjcHUgc2NhbGluZyBm
b3INCj4gPj4+IEpINzExMA0KPiA+Pj4gU29DIikNCj4gPj4+IFNpZ25lZC1vZmYtYnk6IFhpbmd5
dSBXdSA8eGluZ3l1Lnd1QHN0YXJmaXZldGVjaC5jb20+DQo+ID4+PiAtLS0NCj4gPj4+DQo+ID4+
PiBIaSBTdGVwaGVuIGFuZCBFbWlsLA0KPiA+Pj4NCj4gPj4+IFRoaXMgcGF0Y2ggZml4ZXMgdGhl
IGlzc3VlIGFib3V0IGxvd2VyIHJhdGUgb2YgQ1BVZnJlcVsxXSBieSBzZXR0aW5nDQo+ID4+PiBQ
TEwwIHJhdGUgdG8gMS41R0h6Lg0KPiA+Pj4NCj4gPj4+IEluIG9yZGVyIG5vdCB0byBhZmZlY3Qg
dGhlIGNwdSBvcGVyYXRpb24sIHNldHRpbmcgdGhlIFBMTDAgcmF0ZSBuZWVkDQo+ID4+PiBjZXJ0
YWluIHN0ZXBzLiBUaGUgY3B1X3Jvb3QncyBwYXJlbnQgY2xvY2sgc2hvdWxkIGJlIGNoYW5nZWQg
Zmlyc3QuDQo+ID4+PiBBbmQgdGhlIGRpdmlkZXIgb2YgdGhlIGNwdV9jb3JlIGNsb2NrIHNob3Vs
ZCBiZSBzZXQgdG8gMiBzbyB0aGV5DQo+ID4+PiB3b24ndCBjcmFzaCB3aGVuIHNldHRpbmcgMS41
R0h6IHdpdGhvdXQgdm9sdGFnZSByZWd1bGF0aW9uLiBEdWUgdG8NCj4gPj4+IFBMTCBkcml2ZXIg
Ym9vdCBlYXJsaWVyIHRoYW4gU1lTQ1JHIGRyaXZlciwgY3B1X2NvcmUgYW5kIGNwdV9yb290DQo+
ID4+PiBjbG9ja3MgYXJlIHVzaW5nIGJ5IGlvcmVtYXAoKS4NCj4gPj4+DQo+ID4+PiBbMV06IGh0
dHBzOi8vZ2l0aHViLmNvbS9zdGFyZml2ZS10ZWNoL1Zpc2lvbkZpdmUyL2lzc3Vlcy81NQ0KPiA+
Pj4NCj4gPj4+IFByZXZpb3VzIHBhdGNoIGxpbms6DQo+ID4+PiB2MjoNCj4gPj4+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDgyMTE1MjkxNS4yMDgzNjYtMS14aW5neXUud3VAc3Rh
cmZpDQo+ID4+PiB2ZQ0KPiA+Pj4gdGVjaC5jb20vDQo+ID4+PiB2MToNCj4gPj4+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDgxMTAzMzYzMS4xNjA5MTItMS14aW5neXUud3VAc3Rh
cmZpDQo+ID4+PiB2ZQ0KPiA+Pj4gdGVjaC5jb20vDQo+ID4+Pg0KPiA+Pj4gVGhhbmtzLA0KPiA+
Pj4gWGluZ3l1IFd1DQo+ID4+PiAtLS0NCj4gPj4+ICAuLi4vamg3MTEwLXN0YXJmaXZlLXZpc2lv
bmZpdmUtMi5kdHNpICAgICAgICAgfCAgIDUgKw0KPiA+Pj4gIC4uLi9jbGsvc3RhcmZpdmUvY2xr
LXN0YXJmaXZlLWpoNzExMC1wbGwuYyAgICB8IDEwMiArKysrKysrKysrKysrKysrKysNCj4gPj4N
Cj4gPj4gUGxlYXNlIGRvIG5vdCBtaXggRFRTIGFuZCBkcml2ZXIgY29kZS4gVGhhdCdzIG5vdCBy
ZWFsbHkgcG9ydGFibGUuDQo+ID4+IERUUyBpcyBiZWluZyBleHBvcnRlZCBhbmQgdXNlZCBpbiBv
dGhlciBwcm9qZWN0cy4NCj4gPg0KPiA+IE9LLCBJIHdpbGwgc3VibWl0IHRoYXQgaW4gdHdvIHBh
dGNoZXMuDQo+ID4NCj4gPj4NCj4gPj4gLi4uDQo+ID4+DQo+ID4+Pg0KPiA+Pj4gQEAgLTQ1OCw2
ICs1MzUsOCBAQCBzdGF0aWMgaW50IGpoNzExMF9wbGxfcHJvYmUoc3RydWN0DQo+ID4+PiBwbGF0
Zm9ybV9kZXZpY2UNCj4gPj4gKnBkZXYpDQo+ID4+PiAgCXN0cnVjdCBqaDcxMTBfcGxsX3ByaXYg
KnByaXY7DQo+ID4+PiAgCXVuc2lnbmVkIGludCBpZHg7DQo+ID4+PiAgCWludCByZXQ7DQo+ID4+
PiArCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnA7DQo+ID4+PiArCXN0cnVjdCByZXNvdXJjZSByZXM7
DQo+ID4+Pg0KPiA+Pj4gIAlwcml2ID0gZGV2bV9remFsbG9jKCZwZGV2LT5kZXYsIHNpemVvZigq
cHJpdiksIEdGUF9LRVJORUwpOw0KPiA+Pj4gIAlpZiAoIXByaXYpDQo+ID4+PiBAQCAtNDg5LDYg
KzU2OCwyOSBAQCBzdGF0aWMgaW50IGpoNzExMF9wbGxfcHJvYmUoc3RydWN0DQo+ID4+PiBwbGF0
Zm9ybV9kZXZpY2UNCj4gPj4gKnBkZXYpDQo+ID4+PiAgCQkJcmV0dXJuIHJldDsNCj4gPj4+ICAJ
fQ0KPiA+Pj4NCj4gPj4+ICsJcHJpdi0+aXNfZmlyc3Rfc2V0ID0gdHJ1ZTsNCj4gPj4+ICsJbnAg
PSBvZl9maW5kX2NvbXBhdGlibGVfbm9kZShOVUxMLCBOVUxMLA0KPiA+Pj4gKyJzdGFyZml2ZSxq
aDcxMTAtc3lzY3JnIik7DQo+ID4+DQo+ID4+IFlvdXIgZHJpdmVycyBzaG91bGQgbm90IGRvIGl0
LiBJdCdzIGZyYWdpbGUsIGhpZGVzIHRydWUgbGluay9kZXBlbmRlbmN5Lg0KPiA+PiBQbGVhc2Ug
dXNlIHBoYW5kbGVzLg0KPiA+Pg0KPiA+Pg0KPiA+Pj4gKwlpZiAoIW5wKSB7DQo+ID4+PiArCQly
ZXQgPSBQVFJfRVJSKG5wKTsNCj4gPj4+ICsJCWRldl9lcnIocHJpdi0+ZGV2LCAiZmFpbGVkIHRv
IGdldCBzeXNjcmcgbm9kZVxuIik7DQo+ID4+PiArCQlnb3RvIG5wX3B1dDsNCj4gPj4+ICsJfQ0K
PiA+Pj4gKw0KPiA+Pj4gKwlyZXQgPSBvZl9hZGRyZXNzX3RvX3Jlc291cmNlKG5wLCAwLCAmcmVz
KTsNCj4gPj4+ICsJaWYgKHJldCkgew0KPiA+Pj4gKwkJZGV2X2Vycihwcml2LT5kZXYsICJmYWls
ZWQgdG8gZ2V0IHN5c2NyZyByZXNvdXJjZVxuIik7DQo+ID4+PiArCQlnb3RvIG5wX3B1dDsNCj4g
Pj4+ICsJfQ0KPiA+Pj4gKw0KPiA+Pj4gKwlwcml2LT5zeXNjcmdfYmFzZSA9IGlvcmVtYXAocmVz
LnN0YXJ0LCByZXNvdXJjZV9zaXplKCZyZXMpKTsNCj4gPj4+ICsJaWYgKCFwcml2LT5zeXNjcmdf
YmFzZSkNCj4gPj4+ICsJCXJldCA9IC1FTk9NRU07DQo+ID4+DQo+ID4+IFdoeSBhcmUgeW91IG1h
cHBpbmcgb3RoZXIgZGV2aWNlJ3MgSU8/IEhvdyBhcmUgeW91IGdvaW5nIHRvIGVuc3VyZQ0KPiA+
PiBzeW5jZWQgYWNjZXNzIHRvIHJlZ2lzdGVycz8NCj4gPg0KPiA+IEJlY2F1c2Ugc2V0dGluZyBQ
TEwwIHJhdGUgbmVlZCBzcGVjaWZpYyBzdGVwcyBhbmQgdXNlIHRoZSBjbG9ja3Mgb2YgU1lTQ1JH
Lg0KPiANCj4gVGhhdCdzIG5vdCBhIHJlYXNvbiB0byBtYXAgb3RoZXIgZGV2aWNlJ3MgSU8uIFRo
YXQgY291bGQgYmUgYSByZWFzb24gZm9yIGhhdmluZw0KPiBzeXNjb24gb3Igc29tZSBvdGhlciBz
b3J0IG9mIHJlbGF0aW9uc2hpcCwgbGlrZSBjbG9jayBvciByZXNldC4NCj4gDQo+ID4gQnV0IFNZ
U0NSRyBkcml2ZXIgYWxzbyBuZWVkIFBMTCBjbG9jayB0byBiZSBjbG9jayBzb3VyY2Ugd2hlbiBh
ZGRpbmcNCj4gPiBjbG9jayBwcm92aWRlcnMuIEkgdHJpZWQgdG8gYWRkIFNZU0NSRyBjbG9ja3Mg
aW4gJ2Nsb2NrcycgcHJvcGVydHkgaW4NCj4gPiBEVCBhbmQgdXNlDQo+ID4gY2xrX2dldCgpIHRv
IGdldCB0aGUgY2xvY2tzLiBCdXQgaXQgY291bGQgbm90IHJ1biBhbmQgY3Jhc2guIFNvIEkgdXNl
DQo+ID4gaW9yZW1hcCgpIGluc3RlYWQuDQo+IA0KPiBTbyBpbnN0ZWFkIG9mIHByb3Blcmx5IG1v
ZGVsIHRoZSByZWxhdGlvbnNoaXAsIHlvdSBlbnRhbmdsZSB0aGUgZHJpdmVycyBldmVuDQo+IG1v
cmUuDQo+IA0KPiBQbGVhc2UgY29tZSB3aXRoIGEgcHJvcGVyIGRlc2lnbiBmb3IgdGhpcy4gSSBo
YXZlIG5vIGNsdWUgYWJvdXQgeW91ciBoYXJkd2FyZSwNCj4gYnV0IHRoYXQgbG9va3MgbGlrZSB5
b3UgYXJlIGFzeW5jaHJvbm91c2x5IGNvbmZpZ3VyaW5nIHRoZSBzYW1lIGhhcmR3YXJlIGluIHR3
bw0KPiBkaWZmZXJlbnQgcGxhY2VzLg0KPiANCj4gU29ycnksIHRoYXQncyBwb29yIGNvZGUuDQo+
IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQpIaSBLcnp5c3p0b2YsDQoNCklmIEkg
dXNlIHRoZSBvbGQgcGF0Y2hbMV0gbGlrZSB2MiBhbmQgc2V0IHRoZSBQTEwwIGRlZmF1bHQgcmF0
ZSBpbiB0aGUgU1lTQ1JHIGRyaXZlciwNCndpbGwgaXQgYmUgYmV0dGVyPw0KDQpbMV06IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDgyMTE1MjkxNS4yMDgzNjYtMS14aW5neXUud3VA
c3RhcmZpdmV0ZWNoLmNvbS8NCg0KVGhhbmtzLA0KWGluZ3l1IFd1DQoNCg==

