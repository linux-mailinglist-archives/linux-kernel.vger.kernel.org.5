Return-Path: <linux-kernel+bounces-134507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A92E989B259
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8DB1F21334
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD2F38DD6;
	Sun,  7 Apr 2024 13:49:41 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2130.outbound.protection.partner.outlook.cn [139.219.146.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBC621103;
	Sun,  7 Apr 2024 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712497780; cv=fail; b=i9DwfxCMN/XpuzijaSJ1lemHZ/mKuvNxxtA1G/h70cmTZqr0CnYzsbvfHaOn89gLg7ikolFDQj9o6jcPlJM162wK/5EZpKR5I5TvEnqypxAM4EEUGeAitoZgA1DDLnkFysqtiGVv/LwxQS+4L+BLTLdMlZfcvqcV2MRPtV/ju08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712497780; c=relaxed/simple;
	bh=9HOhyEyXjFJ5wY4pYwcOa2cnTWpX5SvWMGb7dRFsZfo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T/Q+4n4OoOHPIJ6zcNcXJ+EWDNRGETS5qV6cZMu/fixm0rLc1d6oQNLw8HgrS6LzFD/xKKb7urV1qNWveNXNJktll+KKY3yr4anFbnqolMiyG5NMRIcvuLwRq6IoTSXnCsuMcbDWHisSr9hV8ok9HvQFLOb8oRufrHOkYOyZxMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ypg+LvC5639Lz1KIt8F5hLboES06wjnF25CVmBnwY1KW2HtSD3nDqnoNN81ZmOdp1rOvho4Di73ltUjKX/H5AWoiniliY2mrH6nA8XTo3TVy8cxPOHURscftGD2lr35HIWICO8DQygQnOKoXJ2t5KTXYm16mkgl0uDGilQyt64pRJky89yOvyN5a4vYJOWCSpRCGd3Oi15iaW1abJSqAITDZajtQQEgQsLkRIwWeVLMP8AoNmU4au1FRn/hO/r0/bVD7n7xegyJic93KP0XC1LtOawIDQtpkR2OIOvfpaGSg+mdG1kZtCD9vJdYEIW77dk+P3YLu+LXCMzckhhnvYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HOhyEyXjFJ5wY4pYwcOa2cnTWpX5SvWMGb7dRFsZfo=;
 b=Tgb8RgFHmQ52hadbNpS+Pval8xcQrIwETg2mS35/uNmaqv6nFBIrn9vP3OP1+Eb3dsdK+c7w5ic/se7NqT824Kk5bLNxBpNFA7WyNFTmMYHrTI8XxaYg01Ml9kUHNUZBAVQjdYsqh8BJx09eb6UNS/LSNRYYDkvACGYIX3mI3hH9qR+9acF3562mCJoWvZ5IJ2gIang10hLrRRod7JLmSewp3QoYa1vQFz4nBcGyb4ymDP0S16WIjcD82Qb2SSt6cT/nNZTkY+BpMjVRI01x6fNXH8ova696NEtrW21bROB0dlwujycsrFJG6sEAsD+WpLpNehRQ1nJWfk7XtUGkfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB0953.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 13:14:22 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::6174:711d:d93:87c9]) by NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::6174:711d:d93:87c9%4]) with mapi id 15.20.7409.053; Sun, 7 Apr 2024
 13:14:22 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Samuel Holland <samuel.holland@sifive.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Hal Feng
	<hal.feng@starfivetech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Michael
 Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Conor
 Dooley <conor@kernel.org>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: RE: [PATCH v3] clk: starfive: pll: Fix lower rate of CPUfreq by
 setting PLL0 rate to 1.5GHz
Thread-Topic: [PATCH v3] clk: starfive: pll: Fix lower rate of CPUfreq by
 setting PLL0 rate to 1.5GHz
Thread-Index:
 AQHahN18qtXBKBZlXUquUnYUH2QsmrFVKPiAgACsqfCAAFBPgIAAA5cAgAJ6jgCABCt3UA==
Date: Sun, 7 Apr 2024 13:14:22 +0000
Message-ID:
 <NTZPR01MB09568C037BFC15CE7EF0E9A49F01A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240402090920.11627-1-xingyu.wu@starfivetech.com>
 <8d21b1bc-9402-41d4-bd81-c521c8a33d2d@kernel.org>
 <NTZPR01MB095662C4A6FCAEB7B35C48FF9F3DA@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <bcf12c0b-d569-4d64-adfb-bad053c182a8@kernel.org>
 <NTZPR01MB09566AB865A0266332268DC69F3DA@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <74d6213f-51de-4d48-a7fb-844d6bb57fa7@sifive.com>
In-Reply-To: <74d6213f-51de-4d48-a7fb-844d6bb57fa7@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB0953:EE_
x-ms-office365-filtering-correlation-id: 32be69af-0085-47cd-448e-08dc5704a443
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WVNCSC1JbXJZoqfy5vP1ZO4MZS7OsjLAjOCUs/4LcENF1i4XrhbHpVOmrATty3WO6GHB4OpL/Pg39HhivzpAPHRNYfRAlqgxqAGGyoiJnxDgqHrHLEzMSXXmKd4wIuZBZQLx98f5EuTQrUZSQDPf+dlbr0zss3YqHLorjS3BZE5aFhqd3iortnxdWfp0inlDsOXYhCtkHPC5lc7Qj5o/gW9ou74eI3DI1AyZRPeLlrkQRWPe8vq78duF8A4ZQ7hIozhvs4/6bmNThZu/aURIrTd+PqPDrSbkq2zN02AWmBQGO5sBCKDzPb+3oSjrPB3HKjpi8MJu/rxCXqEl53g/fmfdBh++Q5z2Rem4/2vLiL07fLZuzYE73HUL0+ST8fYjKVmIn/M2WqfDO+eu453tr/VO9yeHUvrqawIzoRv6uzYhrk3wVjuhS2yEqHALaeCMMguR67pWUdsfM6kF6wGHLE17Kf9nz2GVu5U+cfEOAruwgyUPNIx8W8T8OqttJSg2jP9GFtHuCfHcEXZWsXJgLvNFw5mT2YqFQKP4EeMTN/mlS+q5oKESQPFQ+NtLgfZKWJzNNKRJSrok/ojE2Ki7VTsOtThdymL0PlwD1tcSMs1ES4nkbtl9r/WqOvzQ1S53
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(41320700004)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a1NxUGFscmVRUUw1Y0dwcHZOUDd4dnY5c2xqSXFFZkJyeUk0ejlxK3VvSFNS?=
 =?utf-8?B?SEpIUlBiV1RQdyswMDFnbXpTc2Y1M0Z6c3loMVBLblZEWHdDVmNLdk9SVGk2?=
 =?utf-8?B?Rk8zaFFVQnpUbXMxRks5VGpaYlFnK3MxZExzbUJQYTRpNGhmSUhtcFB6RVEv?=
 =?utf-8?B?cHNWcTF0WFA4dkxoTlZOWjlTN2RRM3A3VHp6ZFRuUDRVN0VXV3htS1JqaEJQ?=
 =?utf-8?B?VGZXc0pnZDB5czhkOFR4MUpFcGlyR3RwUmJobk1pYlFINEtYRmU2MlhVZ0lM?=
 =?utf-8?B?VzJwQkxRNWpCanB1Ykx6VWU0d0psbHcybTZDb2FZRU1hWmIxblI1ZUFBQXYx?=
 =?utf-8?B?c3BWWXU1bzNIeStNM1BPeDkvdUZtMUpkaTVnaWl5MlpDb1Bnbm5aNkNwZThX?=
 =?utf-8?B?VnNYZzNBaGRab2Z4b2J3dVpNOElrTWx4NC9lTTI5UWZIems5U2hNK2plY1Nn?=
 =?utf-8?B?endZdUdUSTdENGpGVWRJWkNVZzRpc3U3Qnozb0ZKMnNCRlRnWC9VT2lRemFS?=
 =?utf-8?B?OCtvVnZjOU9jQlVxbUZvSmlyNGdMaklXcEI5MDJTcFNoeDJmZmE3MFdjTG00?=
 =?utf-8?B?WHBjc05kSG1oZCtSSVAvV3FlSDJ4czluRmtwODZKTXpwWVFBN3NEY1BNQk5p?=
 =?utf-8?B?NWxCUWpaVXJXWkZ4dGdPZWkyZHdxeWxtcGNpakV1QzhmUUg2NklIZ0NrOTVG?=
 =?utf-8?B?cms3U29DdGNtZnUyeENyb2hScmJEVjhnVWVoYW5zTlBCR3BBY0JCVmVXVDE0?=
 =?utf-8?B?WG5yWWJ2WktwNmxvMGdWM3o1K1RxeHltR1FabUJtRGlWb1FiaWhJb1VXM3lV?=
 =?utf-8?B?MnhHZTZBbHZ3L2hMY1hjbDRJNEVCSlI0Wks5aUJvdnJ5WnJDbDlTa1lTQlY3?=
 =?utf-8?B?VG9QZFRXNDFweHBwQ2dSUjFSdzRLcmgzWmlkbEhYUXZVT09sQStTcTU5TDZT?=
 =?utf-8?B?azA3UnFaYnREZkN1bUVSMnVZOWphVDI1YS9kRUd2WUNzeXpSVWR3cjV2YVRa?=
 =?utf-8?B?VndtdGJYTTZseUFRQ1d0d2I1UUc3UnNENzJKVlZOYThkcExvRy8xdDNINFNN?=
 =?utf-8?B?b2h0MlFBUk9MSm85a3FoWXVGV2dnR1RBV1EyTWpzejlKWGFHb0pBVDV2MlBi?=
 =?utf-8?B?NDZBaGRQTnZDbmRseFRFQk1Ha3lTTmprSnoxbFk5UnRSOGVzR3VPN3R4UVYv?=
 =?utf-8?B?Y1Q5WWROdkhacW1XQXV0QlFxMXlod2FuYmMzandLam5jUWlTMlA5SnJic2ow?=
 =?utf-8?B?QXpiU2JUcTRjOGRIdm0yZDR0UUpadUo5UXhHRCtiMHQ3dzlPWUphYnA0dnV3?=
 =?utf-8?B?cHN2eWk0TUNZbDcxaW53OE1rNml2SUlsUlBaSlFJQ2J6ZVpwVitnb1BtZG9U?=
 =?utf-8?B?cEdlMXQvSE5oclFTT0JWa0w4b0UzcnFadDdiUjFjUVdsZ1ozd0JnWFU0anhr?=
 =?utf-8?B?ajFyckI4b1pTZ1FCSWx5VHFubmJ4aWpVRzcyZDVyN2J2UDRWOGdJa3Jid1V6?=
 =?utf-8?B?ZEl0ejkyVzQvNm1EdmpyMkIxU1A5aXNFUk1xVnVCNE1IcjRIUGlpblpiMjBJ?=
 =?utf-8?B?UGtYbDBCWVIrZFN1TTMxNU4wS1RPVTFxWndtcW4vV3lkNElyQ3RsT3RKaUxv?=
 =?utf-8?B?QlJtY1ZrOFBFOXpQMFJuMXQ2Z0V5bk1VYmdpZ1g2a3VaY3BEMTFCSVFRRFM4?=
 =?utf-8?B?V0ZQNEEyWUJvbFpoNjVzYktIamFrR0cwcGJTYktxbjREd3h3T2E2ZklINDVJ?=
 =?utf-8?B?dmsvUWdOVDJ2M3pkTUo2MWNsUldaQ05oSXJ1SHdtOFRaOHY2dmJnTlZQbURn?=
 =?utf-8?B?Ukw5aG5tTllHcmU3ZnJiUGVSV2dGKzBGRWQ2ZGR3YklMVmVIUjBVYUdWNzk1?=
 =?utf-8?B?QmpFWEVYM2JhNkN1Rkd2SGZaOGJyOTZGSzVvdUJnN1ZUb2JCYlZ5RGdtdVIv?=
 =?utf-8?B?SGY3eU9HSDZZcGs5ckNHSTEyZTlESGRWSnB2bGFWQTNnOVBKMU1haGx4Zk12?=
 =?utf-8?B?TTFyRTJ5WnVMRVBDcVE1OStDMVVLcG5NdzVVRVlJZUdYTHllYjZiNjNGYis0?=
 =?utf-8?B?V2kwUHpKNkNxaGtBNkhtOEVVRFcrTUpZeDBvK2RkYitEQ3k2dWIvT0p5aVJL?=
 =?utf-8?Q?f8ikLZW1dBnfC/Yklq7TxfKMB?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 32be69af-0085-47cd-448e-08dc5704a443
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 13:14:22.6724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9bQaoCm3sdaL0JT0EVvdK39+5isZuQUTib2aYLla7qf7oQEPDROHb9OPOSwsndexmJ3cwv58AZ4kLrN2hTLoNz4++1LoV0xriIcyYrhKunc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB0953

T24gMjAyNC0wNC0wNSA1OjI4IEFNLCBTYW11ZWwgSG9sbGFuZCB3cm90ZToNCj4gDQo+IEhpIFhp
bmd5dSwNCj4gDQo+IE9uIDIwMjQtMDQtMDMgMjo0NCBBTSwgWGluZ3l1IFd1IHdyb3RlOg0KPiA+
IE9uIDAzLzA0LzIwMjQgMTU6MjQsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ID4+DQo+
ID4+IE9uIDAzLzA0LzIwMjQgMDk6MTksIFhpbmd5dSBXdSB3cm90ZToNCj4gPj4+IE9uIDAzLzA0
LzIwMjQgMDoxOCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gPj4+Pg0KPiA+Pj4+IE9u
IDAyLzA0LzIwMjQgMTE6MDksIFhpbmd5dSBXdSB3cm90ZToNCj4gPj4+Pj4gQ1BVZnJlcSBzdXBw
b3J0cyA0IGNwdSBmcmVxdWVuY3kgbG9hZHMgb24gMzc1LzUwMC83NTAvMTUwME1Iei4NCj4gPj4+
Pj4gQnV0IG5vdyBQTEwwIHJhdGUgaXMgMUdIeiBhbmQgdGhlIGNwdSBmcmVxdWVuY3kgbG9hZHMg
YmVjb21lDQo+ID4+Pj4+IDMzMy81MDAvNTAwLzEwMDBNSHogaW4gZmFjdC4NCj4gPj4+Pj4NCj4g
Pj4+Pj4gU28gUExMMCByYXRlIHNob3VsZCBiZSBkZWZhdWx0IHNldCB0byAxLjVHSHouIEJ1dCBz
ZXR0aW5nIHRoZQ0KPiA+Pj4+PiBQTEwwIHJhdGUgbmVlZCBjZXJ0YWluIHN0ZXBzOg0KPiA+Pj4+
Pg0KPiA+Pj4+PiAxLiBDaGFuZ2UgdGhlIHBhcmVudCBvZiBjcHVfcm9vdCBjbG9jayB0byBPU0Mg
Y2xvY2suDQo+ID4+Pj4+IDIuIENoYW5nZSB0aGUgZGl2aWRlciBvZiBjcHVfY29yZSBpZiBQTEww
IHJhdGUgaXMgaGlnaGVyIHRoYW4NCj4gPj4+Pj4gICAgMS4yNUdIeiBiZWZvcmUgQ1BVZnJlcSBi
b290Lg0KPiA+Pj4+PiAzLiBDaGFuZ2UgdGhlIHBhcmVudCBvZiBjcHVfcm9vdCBjbG9jayBiYWNr
IHRvIFBMTDAgY2xvY2suDQo+ID4+Pj4+DQo+ID4+Pj4+IFJldmlld2VkLWJ5OiBIYWwgRmVuZyA8
aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gPj4+Pj4gRml4ZXM6IGUyYzUxMGQ2ZDYzMCAo
InJpc2N2OiBkdHM6IHN0YXJmaXZlOiBBZGQgY3B1IHNjYWxpbmcgZm9yDQo+ID4+Pj4+IEpINzEx
MA0KPiA+Pj4+PiBTb0MiKQ0KPiA+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBYaW5neXUgV3UgPHhpbmd5
dS53dUBzdGFyZml2ZXRlY2guY29tPg0KPiA+Pj4+PiAtLS0NCj4gPj4+Pj4NCj4gPj4+Pj4gSGkg
U3RlcGhlbiBhbmQgRW1pbCwNCj4gPj4+Pj4NCj4gPj4+Pj4gVGhpcyBwYXRjaCBmaXhlcyB0aGUg
aXNzdWUgYWJvdXQgbG93ZXIgcmF0ZSBvZiBDUFVmcmVxWzFdIGJ5DQo+ID4+Pj4+IHNldHRpbmcN
Cj4gPj4+Pj4gUExMMCByYXRlIHRvIDEuNUdIei4NCj4gPj4+Pj4NCj4gPj4+Pj4gSW4gb3JkZXIg
bm90IHRvIGFmZmVjdCB0aGUgY3B1IG9wZXJhdGlvbiwgc2V0dGluZyB0aGUgUExMMCByYXRlDQo+
ID4+Pj4+IG5lZWQgY2VydGFpbiBzdGVwcy4gVGhlIGNwdV9yb290J3MgcGFyZW50IGNsb2NrIHNo
b3VsZCBiZSBjaGFuZ2VkIGZpcnN0Lg0KPiA+Pj4+PiBBbmQgdGhlIGRpdmlkZXIgb2YgdGhlIGNw
dV9jb3JlIGNsb2NrIHNob3VsZCBiZSBzZXQgdG8gMiBzbyB0aGV5DQo+ID4+Pj4+IHdvbid0IGNy
YXNoIHdoZW4gc2V0dGluZyAxLjVHSHogd2l0aG91dCB2b2x0YWdlIHJlZ3VsYXRpb24uIER1ZSB0
bw0KPiA+Pj4+PiBQTEwgZHJpdmVyIGJvb3QgZWFybGllciB0aGFuIFNZU0NSRyBkcml2ZXIsIGNw
dV9jb3JlIGFuZCBjcHVfcm9vdA0KPiA+Pj4+PiBjbG9ja3MgYXJlIHVzaW5nIGJ5IGlvcmVtYXAo
KS4NCj4gPj4+Pj4NCj4gPj4+Pj4gWzFdOiBodHRwczovL2dpdGh1Yi5jb20vc3RhcmZpdmUtdGVj
aC9WaXNpb25GaXZlMi9pc3N1ZXMvNTUNCj4gPj4+Pj4NCj4gPj4+Pj4gUHJldmlvdXMgcGF0Y2gg
bGluazoNCj4gPj4+Pj4gdjI6DQo+ID4+Pj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8y
MDIzMDgyMTE1MjkxNS4yMDgzNjYtMS14aW5neXUud3VAc3Rhcg0KPiA+Pj4+PiBmaQ0KPiA+Pj4+
PiB2ZQ0KPiA+Pj4+PiB0ZWNoLmNvbS8NCj4gPj4+Pj4gdjE6DQo+ID4+Pj4+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC8yMDIzMDgxMTAzMzYzMS4xNjA5MTItMS14aW5neXUud3VAc3Rhcg0K
PiA+Pj4+PiBmaQ0KPiA+Pj4+PiB2ZQ0KPiA+Pj4+PiB0ZWNoLmNvbS8NCj4gPj4+Pj4NCj4gPj4+
Pj4gVGhhbmtzLA0KPiA+Pj4+PiBYaW5neXUgV3UNCj4gPj4+Pj4gLS0tDQo+ID4+Pj4+ICAuLi4v
amg3MTEwLXN0YXJmaXZlLXZpc2lvbmZpdmUtMi5kdHNpICAgICAgICAgfCAgIDUgKw0KPiA+Pj4+
PiAgLi4uL2Nsay9zdGFyZml2ZS9jbGstc3RhcmZpdmUtamg3MTEwLXBsbC5jICAgIHwgMTAyICsr
KysrKysrKysrKysrKysrKw0KPiA+Pj4+DQo+ID4+Pj4gUGxlYXNlIGRvIG5vdCBtaXggRFRTIGFu
ZCBkcml2ZXIgY29kZS4gVGhhdCdzIG5vdCByZWFsbHkgcG9ydGFibGUuDQo+ID4+Pj4gRFRTIGlz
IGJlaW5nIGV4cG9ydGVkIGFuZCB1c2VkIGluIG90aGVyIHByb2plY3RzLg0KPiA+Pj4NCj4gPj4+
IE9LLCBJIHdpbGwgc3VibWl0IHRoYXQgaW4gdHdvIHBhdGNoZXMuDQo+ID4+Pg0KPiA+Pj4+DQo+
ID4+Pj4gLi4uDQo+ID4+Pj4NCj4gPj4+Pj4NCj4gPj4+Pj4gQEAgLTQ1OCw2ICs1MzUsOCBAQCBz
dGF0aWMgaW50IGpoNzExMF9wbGxfcHJvYmUoc3RydWN0DQo+ID4+Pj4+IHBsYXRmb3JtX2Rldmlj
ZQ0KPiA+Pj4+ICpwZGV2KQ0KPiA+Pj4+PiAgCXN0cnVjdCBqaDcxMTBfcGxsX3ByaXYgKnByaXY7
DQo+ID4+Pj4+ICAJdW5zaWduZWQgaW50IGlkeDsNCj4gPj4+Pj4gIAlpbnQgcmV0Ow0KPiA+Pj4+
PiArCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnA7DQo+ID4+Pj4+ICsJc3RydWN0IHJlc291cmNlIHJl
czsNCj4gPj4+Pj4NCj4gPj4+Pj4gIAlwcml2ID0gZGV2bV9remFsbG9jKCZwZGV2LT5kZXYsIHNp
emVvZigqcHJpdiksIEdGUF9LRVJORUwpOw0KPiA+Pj4+PiAgCWlmICghcHJpdikNCj4gPj4+Pj4g
QEAgLTQ4OSw2ICs1NjgsMjkgQEAgc3RhdGljIGludCBqaDcxMTBfcGxsX3Byb2JlKHN0cnVjdA0K
PiA+Pj4+PiBwbGF0Zm9ybV9kZXZpY2UNCj4gPj4+PiAqcGRldikNCj4gPj4+Pj4gIAkJCXJldHVy
biByZXQ7DQo+ID4+Pj4+ICAJfQ0KPiA+Pj4+Pg0KPiA+Pj4+PiArCXByaXYtPmlzX2ZpcnN0X3Nl
dCA9IHRydWU7DQo+ID4+Pj4+ICsJbnAgPSBvZl9maW5kX2NvbXBhdGlibGVfbm9kZShOVUxMLCBO
VUxMLA0KPiA+Pj4+PiArInN0YXJmaXZlLGpoNzExMC1zeXNjcmciKTsNCj4gPj4+Pg0KPiA+Pj4+
IFlvdXIgZHJpdmVycyBzaG91bGQgbm90IGRvIGl0LiBJdCdzIGZyYWdpbGUsIGhpZGVzIHRydWUg
bGluay9kZXBlbmRlbmN5Lg0KPiA+Pj4+IFBsZWFzZSB1c2UgcGhhbmRsZXMuDQo+ID4+Pj4NCj4g
Pj4+Pg0KPiA+Pj4+PiArCWlmICghbnApIHsNCj4gPj4+Pj4gKwkJcmV0ID0gUFRSX0VSUihucCk7
DQo+ID4+Pj4+ICsJCWRldl9lcnIocHJpdi0+ZGV2LCAiZmFpbGVkIHRvIGdldCBzeXNjcmcgbm9k
ZVxuIik7DQo+ID4+Pj4+ICsJCWdvdG8gbnBfcHV0Ow0KPiA+Pj4+PiArCX0NCj4gPj4+Pj4gKw0K
PiA+Pj4+PiArCXJldCA9IG9mX2FkZHJlc3NfdG9fcmVzb3VyY2UobnAsIDAsICZyZXMpOw0KPiA+
Pj4+PiArCWlmIChyZXQpIHsNCj4gPj4+Pj4gKwkJZGV2X2Vycihwcml2LT5kZXYsICJmYWlsZWQg
dG8gZ2V0IHN5c2NyZyByZXNvdXJjZVxuIik7DQo+ID4+Pj4+ICsJCWdvdG8gbnBfcHV0Ow0KPiA+
Pj4+PiArCX0NCj4gPj4+Pj4gKw0KPiA+Pj4+PiArCXByaXYtPnN5c2NyZ19iYXNlID0gaW9yZW1h
cChyZXMuc3RhcnQsIHJlc291cmNlX3NpemUoJnJlcykpOw0KPiA+Pj4+PiArCWlmICghcHJpdi0+
c3lzY3JnX2Jhc2UpDQo+ID4+Pj4+ICsJCXJldCA9IC1FTk9NRU07DQo+ID4+Pj4NCj4gPj4+PiBX
aHkgYXJlIHlvdSBtYXBwaW5nIG90aGVyIGRldmljZSdzIElPPyBIb3cgYXJlIHlvdSBnb2luZyB0
byBlbnN1cmUNCj4gPj4+PiBzeW5jZWQgYWNjZXNzIHRvIHJlZ2lzdGVycz8NCj4gPj4+DQo+ID4+
PiBCZWNhdXNlIHNldHRpbmcgUExMMCByYXRlIG5lZWQgc3BlY2lmaWMgc3RlcHMgYW5kIHVzZSB0
aGUgY2xvY2tzIG9mIFNZU0NSRy4NCj4gPj4NCj4gPj4gVGhhdCdzIG5vdCBhIHJlYXNvbiB0byBt
YXAgb3RoZXIgZGV2aWNlJ3MgSU8uIFRoYXQgY291bGQgYmUgYSByZWFzb24NCj4gPj4gZm9yIGhh
dmluZyBzeXNjb24gb3Igc29tZSBvdGhlciBzb3J0IG9mIHJlbGF0aW9uc2hpcCwgbGlrZSBjbG9j
ayBvciByZXNldC4NCj4gPj4NCj4gPj4+IEJ1dCBTWVNDUkcgZHJpdmVyIGFsc28gbmVlZCBQTEwg
Y2xvY2sgdG8gYmUgY2xvY2sgc291cmNlIHdoZW4gYWRkaW5nDQo+ID4+PiBjbG9jayBwcm92aWRl
cnMuIEkgdHJpZWQgdG8gYWRkIFNZU0NSRyBjbG9ja3MgaW4gJ2Nsb2NrcycgcHJvcGVydHkNCj4g
Pj4+IGluIERUIGFuZCB1c2UNCj4gPj4+IGNsa19nZXQoKSB0byBnZXQgdGhlIGNsb2Nrcy4gQnV0
IGl0IGNvdWxkIG5vdCBydW4gYW5kIGNyYXNoLiBTbyBJDQo+ID4+PiB1c2UNCj4gPj4+IGlvcmVt
YXAoKSBpbnN0ZWFkLg0KPiA+Pg0KPiA+PiBTbyBpbnN0ZWFkIG9mIHByb3Blcmx5IG1vZGVsIHRo
ZSByZWxhdGlvbnNoaXAsIHlvdSBlbnRhbmdsZSB0aGUNCj4gPj4gZHJpdmVycyBldmVuIG1vcmUu
DQo+ID4+DQo+ID4+IFBsZWFzZSBjb21lIHdpdGggYSBwcm9wZXIgZGVzaWduIGZvciB0aGlzLiBJ
IGhhdmUgbm8gY2x1ZSBhYm91dCB5b3VyDQo+ID4+IGhhcmR3YXJlLCBidXQgdGhhdCBsb29rcyBs
aWtlIHlvdSBhcmUgYXN5bmNocm9ub3VzbHkgY29uZmlndXJpbmcgdGhlDQo+ID4+IHNhbWUgaGFy
ZHdhcmUgaW4gdHdvIGRpZmZlcmVudCBwbGFjZXMuDQo+ID4+DQo+ID4+IFNvcnJ5LCB0aGF0J3Mg
cG9vciBjb2RlLg0KPiA+Pg0KPiA+PiBCZXN0IHJlZ2FyZHMsDQo+ID4+IEtyenlzenRvZg0KPiA+
DQo+ID4gSGkgS3J6eXN6dG9mLA0KPiA+DQo+ID4gSWYgSSB1c2UgdGhlIG9sZCBwYXRjaFsxXSBs
aWtlIHYyIGFuZCBzZXQgdGhlIFBMTDAgZGVmYXVsdCByYXRlIGluIHRoZQ0KPiA+IFNZU0NSRyBk
cml2ZXIsIHdpbGwgaXQgYmUgYmV0dGVyPw0KPiA+DQo+ID4gWzFdOg0KPiA+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC8yMDIzMDgyMTE1MjkxNS4yMDgzNjYtMS14aW5neXUud3VAc3RhcmZp
dmUNCj4gPiB0ZWNoLmNvbS8NCj4gDQo+IEJvdGggcmVwYXJlbnRpbmcgY3B1X3Jvb3QgYW5kIGVu
Zm9yY2luZyB0aGUgbWF4aW11bSBjcHVfY29yZSBmcmVxdWVuY3kgY2FuDQo+IGJlIGFjY29tcGxp
c2hlZCB3aXRoIGNsayBub3RpZmllcnMuIFNlZSBmb3IgZXhhbXBsZSBjY3VfbXV4X25vdGlmaWVy
X3JlZ2lzdGVyKCkNCj4gaW4gZHJpdmVycy9jbGsvc3VueGktbmcvY2N1X211eC5jLg0KPiANCg0K
VGhpcyBzZWVtcyBsaWtlIGEgZ29vZCBpZGVhLiBJJ2xsIHRyeSBpdC4NCg0KVGhhbmtzLA0KWGlu
Z3l1IFd1DQo=

