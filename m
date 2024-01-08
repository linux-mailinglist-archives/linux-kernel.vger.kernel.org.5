Return-Path: <linux-kernel+bounces-19872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6088275F8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E6B5283DF8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B875465C;
	Mon,  8 Jan 2024 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="UUw8G0o/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2041.outbound.protection.outlook.com [40.107.249.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CD853E31;
	Mon,  8 Jan 2024 17:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxKLj0hAjagpAw7l77/8EncXBeWtw1A92uOW/VXiYT0Hy/kVGP58YLPipDTHL9/cvlvoqZQQeiL1ImvG9A8PmTx6xy17C+BkYk873hjFiu74soc0XtgdRbBzhQFiJhSmm10LrTFRWpvG8cN3rtI7O3bJPdQvkoFc4ZIW/L5B1B423xvAa/ttijjTz3WMclpTd07jbx0Km/fJs1gb2aQzugZJ0eie5/yVFeDWN63/RW5r75NG3GfP820fNsvop3JzEqG0bLIZrlkuFLkUe2tvfqP8xPGiQfaG/+0hDRK9Hma6/ZeIfDqwfLB5cCKKwfZggIp8rVoL+14OMxu0zQ/K7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+q/DJjhtpfla04TfekAMdT6CcqDaowkK9FTre5f4pCc=;
 b=B2sinQbGrd/X8hOfoscxYfsDJnfASKYd5w7YcYMU03Rcknzrd/3bSLCtcjBis+UIbBEWytx0cZ0McZsx8lqNsy80kV7PNKaQvweHCzv3HwAOZXmxwc4VBY0VvVUCycCivAgf9IB4YPmTsBy+a9mlBnZHO4oVYWuYTQB+f7MOQdtx5GDmBIYu0x3qFgle/efU5QN0TtPziPqtyVy+xir4zFkaMuM6pRfqKSGrzi/dmd8Kk/WvLlPBX0fSczVQDtv8PokiezzoygVl0FATCR8HMzDZRUTs+MyXieMrYqCvNt1uXM0+GjpgZiZ96l1zOl2OTbwNCKG3qgVFmP5wKHii5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+q/DJjhtpfla04TfekAMdT6CcqDaowkK9FTre5f4pCc=;
 b=UUw8G0o/jGupn3ZCMYGGSmC27KGqTAa+SZU8+2sAfVt7BWAZ+PQi6IoJ0ZRN5M5pp9rsIMVardz6X5uVwhQKou5E16w8CDkwZFkCgQoYxL9lrFbGTX9pt5CRiGL7vxf+QzOoigw+FqBpTG8HnWmjo2xJVJ4dOJAX5H2h1Kt2CJE=
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AM8PR04MB7922.eurprd04.prod.outlook.com (2603:10a6:20b:249::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 17:03:22 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%6]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 17:03:22 +0000
From: Josua Mayer <josua@solid-run.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: sfp: add fixup for tplink 2.5gbase-t rj45 modules
Thread-Topic: [PATCH] net: sfp: add fixup for tplink 2.5gbase-t rj45 modules
Thread-Index: AQHaQL2cuueGFMzcdkaNl7D4eZ1st7DOhq4AgAGhAYA=
Date: Mon, 8 Jan 2024 17:03:21 +0000
Message-ID: <e65d9a0d-b4df-43cb-aa98-dc17317fdf60@solid-run.com>
References:
 <20240106-tplink-25gbaset-sfp-fixup-v1-1-8d26696bd2f4@solid-run.com>
 <ZZrNChuIw0X9fr6Z@shell.armlinux.org.uk>
In-Reply-To: <ZZrNChuIw0X9fr6Z@shell.armlinux.org.uk>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8963:EE_|AM8PR04MB7922:EE_
x-ms-office365-filtering-correlation-id: ed6afc50-e4e0-4049-4238-08dc106bb852
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 KAzcWXqAdRhfx0L9nYD6WEMs1JcYXKyd+Zy0HtgH9LMUqMiwTtLZ2LjHhx04C082rBiaBrfM9UktZ+3PJ1zWvkYQxSBM8ppYHj28HFjBOPJgzdqkT3lsRr7n6iCtQWcDa4Wc+SgSW2OZKWAiHWkw0CUY9goX7/P4E+7McxyKOVNczMnNKGjDZWFX5ew5D45HGNfJpjKsyuq6hRleCgpi89ckflK2A6RiiLEqCqPUG0BnfLFN0gMIIOrMsIIHOl2WAVK5YK8xkZRsM0/1x2lsYbCburrrx0+n+LazU9+/Y+OaxflOT8GUBLtCrlh2mSVBj92ZLXaVgM6myMhzF0wIMpx5aEhVlsotkca47C1efhSraEiKD/B3po9tnktMCACyPlVAUYviPJcwdHeekRPcof+RvWubu/FWpSZgUMY1mWuWxj1KvQeMREwi83on7iedZA2txfQ0dbfMXumEgfUhGacLn9b+7vpo5hZyeY0xv1b94JrSo66QpX9mK9Xy4oeVXyUkAVd+kQFlv9cpPOXm5I4xXBaFRBjGiB8FOcix6kRX4BTOtJ60Da1QPZs2fO2wWvPRM3GdqKJCXOMBAvtDB1dDEPoX5cFUlDKkBsvtTJFEsQmP2Ui9aLqtUY8RJYl8PJMR7Kwt9B/DJ7JrHOo3uQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(396003)(39840400004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(316002)(91956017)(478600001)(54906003)(5660300002)(6916009)(64756008)(66446008)(66556008)(66476007)(76116006)(66946007)(71200400001)(8936002)(8676002)(6512007)(6506007)(6486002)(31686004)(4326008)(2616005)(26005)(36756003)(2906002)(38070700009)(122000001)(31696002)(86362001)(41300700001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1Y2bFJkVFFMMHgxaVpuenBRYzBPU3FRby9seVBBN0lpeXM2QVM2aWhzcnA5?=
 =?utf-8?B?bk5xNTdIWTIrR3oyNVoxenBleERndTVXYUxKRUhzNllWczdhSGZJc1ZvS05K?=
 =?utf-8?B?OSszOXZacjcvZVZVUlJ6WEJFblNMVlpwL1dhWThDRkdzL1Y2UEl2d21NWGtq?=
 =?utf-8?B?WW5jNzRCTnNQQnVWUWl3dzFsYlFtWmNrODVtRUFJRTBtVHZZVWV5ejFLbkM2?=
 =?utf-8?B?MkRac2ZoVTUvU2hKY1ZRd0JiRWxMYlBSeVlyaGg2WjloOGNnUmN4aSs2WkJY?=
 =?utf-8?B?cFpjVVdIOGp1Y1Q0YlNyWTVkNEplbm13N1FKbXhQK2o2T3ZVMkgrbEdGcmNU?=
 =?utf-8?B?OHdpRy9RSkNJc2FPVGdLdFFVZjlhc1F5UXI5UElERjVrWVFJdnRTK05uQ3JQ?=
 =?utf-8?B?RXBZb1Z0ZC9YQ2puRjVnM2tsYjFrK0dMbnRtbU1RVlEwRzlPc3NXTzhnVmhR?=
 =?utf-8?B?TytPeW9rbWhib1BnTWthZkVON29kaDlGZUhGK25meWw1UEpBMDdUL2FqQWw5?=
 =?utf-8?B?djBlT1lSbUNjcVpLV1QxL3V6cDZoVDVYZmZrdTlEekdzMEVKU3RUVW9maEZw?=
 =?utf-8?B?NHFhaDJqaUVScFdQblpmK3NiS2VHVDRXQ3FrZDlzVFdzWmpaMlZmRkVtdTVB?=
 =?utf-8?B?akJ6czlYNDJtQ0FGLzNZYUhFOWFQL3BVQlFpc0d6SUlGcjNyZFpvY3Z4c0R4?=
 =?utf-8?B?Y01GQ1BhSElFZzlEeDBxWWd4U1hwcWNBeGY4Z2FuVXNJNmIxRDVTQ2xPUW83?=
 =?utf-8?B?Y0RTZVdjaVBnUmtkZWFVazF0S1JEQU9KRmc1OTVQd2NybG8rR3hIdmNBYUZE?=
 =?utf-8?B?Vk5XbHJCUjhUdDZlQkNvYmQ2M2dKMHo3dFFRSWtPcE03ajhaVEVZZVFCd2V5?=
 =?utf-8?B?Rk1TWlBaRHFyQlhlZlhYcjVkTE01anl4U3cvajlFQmVCOXVPcm10UEk4STgv?=
 =?utf-8?B?K1ZXRkVweVlNMVlaQVYvbms3MXdFSm9UR0tBU0tSeWpaTGhPTHdkaU1IaWNG?=
 =?utf-8?B?V1QxUXlzaXRNLytYZUxjR0xCdG1sdkc4OVR0cjNpT2tpcXk3UmVib1VWTXVK?=
 =?utf-8?B?NVk0NjNWcjRTYllQM0JaYUkvT1hpTmZHK2llUHZrem5HellvZWdJN2ZLNWd6?=
 =?utf-8?B?cHI2bmZQUDdtSVNTRzIrOStmTDcyMElsZkJzc1hqQjZxWUlFeHVsc1hpbmJY?=
 =?utf-8?B?bW5HOUkwRzVTc0hvc1MwM3BoZ0d1ZWZJY0hNeGFZbEJYRmhtUzd5ZmN6ek80?=
 =?utf-8?B?aUlsTGU2R0cwVytQVVlkRWNKWGZqeGMyVm52eDRRRkhZS0hyZUd0SUdQVEQ0?=
 =?utf-8?B?V0k3d2E5eG5XSWRTNXVNK3hIRUdOeHpSc20ybjNndU83YWhlTVNXNkF1Wnp1?=
 =?utf-8?B?dkpqODhOWkpGYzlIV1h4NUJ0Y25za1k2aWpoTXB4RE9iQnZiZkxGVVV3S3la?=
 =?utf-8?B?eXpZMC9UZTA3OGRDbFpBLzJPQjRpMEVJVmJVdW5YWHBaVStjanhYbEgrVjdq?=
 =?utf-8?B?M042K2FIQkpCcDI0MExVcFZlVkVwN0VjK3NaSjFxNW55VlpNRnA5MHVZaE1P?=
 =?utf-8?B?UHFUMTlCUjdzRHA0c2FPcjd5b0JRbXJzQzAvVnhpWHBocHR1SUF2Y1dBTVRt?=
 =?utf-8?B?Sno0QVJsVU8vT1E4UytIc252alRROEMzQmNDdzU5QmNGSWhiVjd2TjlvMjlm?=
 =?utf-8?B?MWtOQStUV2J4enRqeDN6c2VpRFRPYkwzeEl5cEZPQ3dLUmlRWURjT3JGUDMz?=
 =?utf-8?B?a0dtSmRqTXI5YUNZaE9lUlEzaU5GdlJ4U2tLL0Vrc3UrbEpwcUFWMG52bjlC?=
 =?utf-8?B?a0pyVHkwNnFBNFd3c2pBMFZ5TVU1WVRuVHpkeERQK0NHRjJwZ2xEdDZNZlpl?=
 =?utf-8?B?V0ZOcnZqK2dCVUhFR3JyYW00MlpQMUcyTnFzYlNXc1RSaDV5Sk5LbW12ekd6?=
 =?utf-8?B?L0dVQkMxK2p3NEdWZzlJbFozZlRZSzlwbGVPUmFCcmNBUXJVTjhPU3J6cXI4?=
 =?utf-8?B?Y1JJNkxRcnpxUExoMjNsL0w0Q3Y4Q0RmcW9GSnMwWnhyWlg4QWNBd2ZyalNj?=
 =?utf-8?B?RHRwNFoxTXdnL3BnUkpQME51R0RpOHlHT1o3K2w2R0pIbmJFV1YzeHpwQUFz?=
 =?utf-8?Q?+eLdZ9C7KPEpwZZUDMoUoEFzs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1A0F2188484B64D98D966E10CD60EE4@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6afc50-e4e0-4049-4238-08dc106bb852
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 17:03:21.9679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ghy1FZ+iMJ4RrWUfCgmu/bssbzl2TIImWys/ZW1vnqbpV8lwTXRIAZQSEGfzkS7U716x7gyvtp8jZQNJD7I9Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7922

SGkgUnVzc2VsbCwNCg0KQW0gMDcuMDEuMjQgdW0gMTc6MTAgc2NocmllYiBSdXNzZWxsIEtpbmcg
KE9yYWNsZSk6DQo+IE9uIFNhdCwgSmFuIDA2LCAyMDI0IGF0IDA1OjI5OjU2UE0gKzAxMDAsIEpv
c3VhIE1heWVyIHdyb3RlOg0KPj4gVFAtTGluayBUTC1TTTQxMFUgbW9kdWxlcyBhcmUgc2luZ2xl
LXJhdGUgMi41R0Jhc2UtVCBSSjQ1IFNGUCBtb2R1bGVzLg0KPj4gVGhlIEVFUFJPTSBkYXRhIGlz
IGx5aW5nIGFib3V0IGNvbm5lY3RvciBhbmQgZXh0ZW5kZWQgY2MsDQo+PiByZXBvcnRpbmcgMjVH
YnBzIGZpYmVyLg0KPj4NCj4+IEFkZCBmaXh1cCBmb3IgdGhlc2Ugc3BlY2lmaWMgbW9kdWxlcyBm
b3JjaW5nIFJKNDUgQCAyLjVHYmFzZS1ULg0KPj4NCj4+IEZvciByZWZlcmVuY2Ugb3JpZ2luYWwg
ZWVwcm9tIGRhdGEgZHVtcCBmcm9tIGV0aHRvb2w6DQo+Pg0KPj4gSWRlbnRpZmllciAgICAgICAg
ICAgICAgICA6IDB4MDMgKFNGUCkNCj4+IEV4dGVuZGVkIGlkZW50aWZpZXIgICAgICAgOiAweDA0
IChHQklDL1NGUCBkZWZpbmVkIGJ5IDItd2lyZSBpbnRlcmZhY2UgSUQpDQo+PiBDb25uZWN0b3Ig
ICAgICAgICAgICAgICAgIDogMHgwNyAoTEMpDQo+PiBUcmFuc2NlaXZlciBjb2RlcyAgICAgICAg
IDogMHgwMCAweDAwIDB4MDAgMHgwMCAweDAwIDB4MDAgMHg0MCAweDAwIDB4MDANCj4+IFRyYW5z
Y2VpdmVyIHR5cGUgICAgICAgICAgOiBGQzogVHdpc3RlZCBQYWlyIChUUCkNCj4+IEVuY29kaW5n
ICAgICAgICAgICAgICAgICAgOiAweDAxICg4Qi8xMEIpDQo+PiBCUiwgTm9taW5hbCAgICAgICAg
ICAgICAgIDogMzEwME1CZA0KPiBUaGlzIGlzbid0IDI1R2JwcyAtIGl0J3MgMi41R2JwcyENCm9o
IDooDQoNCkkgbWlzcmVhZCBhIGhlYWRlci1maWxlIG5vdCBiZWluZyBjYXJlZnVsIHRoYXQgZGF5
IC4uLiBzb3JyeQ0KDQo+DQo+IFNvIHdoYXQgYWN0dWFsbHkgaGFwcGVucyB3aXRoIHRoaXMgbW9k
dWxlIHdpdGhvdXQgdGhlIHF1aXJrPw0KSW4gc3VtbWFyeSBpdCBsb29rcyBsaWtlIG9uIGFybWFk
YS0zODUgaXQgaXMgd29ya2luZyBmaW5lIGV4Y2VwdCBmb3IgcmVwb3J0aW5nIHdyb25nIHBvcnQg
YW5kIGxpbmstbW9kZSAoZmliZXIpLA0KYnV0IG9uIGNuOTEzMCBpdCBpcyBub3Qgd29ya2luZyBl
aXRoZXIgd2F5Lg0KDQoxLiBPbiBDTjkxMzAgQ2xlYXJmb2cgQmFzZSwgbGludXggdjYuMS42OSB3
aXRob3V0IHRoaXMgcGF0Y2g6DQoNCk1vZHVsZSBpcyBkZXRlY3RlZCAtIGV0aHRvb2wgcmVwb3J0
cyBhIDI1MDAgZmliZXIsIG5vIGxpbmsgZGV0ZWN0ZWQsIGNvbXBoeSBjb25maWd1cmVkIGZvciAy
NTAwYmFzZXgNClsgwqDCoDUxLjQ2NTIzN10gc2ZwIHNmcDogbW9kdWxlIFRQLUxJTksgwqDCoMKg
wqDCoMKgwqDCoMKgVEwtU000MTBVIMKgwqDCoMKgwqDCoMKgcmV2IDEuMCDCoHNuIDEyMTU0SjYw
MDAwMzkgwqDCoMKgZGMgMjEwNjA1IMKgwqANClsgwqDCoDUxLjQ3NDY5OV0gbXZwcDIgZjIwMDAw
MDAuZXRoZXJuZXQgZXRoMDogc3dpdGNoZWQgdG8gaW5iYW5kLzI1MDBiYXNlLXggbGluayBtb2Rl
DQpyb290QGxvY2FsaG9zdDp+IyBpZmNvbmZpZyBldGgwIHVwDQpbIMKgwqA4OC4xNTY0ODZdIG12
cHAyIGYyMDAwMDAwLmV0aGVybmV0IGV0aDA6IGNvbmZpZ3VyaW5nIGZvciBpbmJhbmQvMjUwMGJh
c2UteCBsaW5rIG1vZGUNCnJvb3RAbG9jYWxob3N0On4jIGV0aHRvb2wgZXRoMA0KU2V0dGluZ3Mg
Zm9yIGV0aDA6DQrCoMKgwqDCoMKgwqDCoFN1cHBvcnRlZCBwb3J0czogWyBGSUJSRSBdDQrCoMKg
wqDCoMKgwqDCoFN1cHBvcnRlZCBsaW5rIG1vZGVzOiDCoMKgMjUwMGJhc2VYL0Z1bGwNCsKgwqDC
oMKgwqDCoCBTcGVlZDogMjUwME1iL3MNCsKgwqDCoMKgwqDCoCBQb3J0OiBGSUJSRQ0KwqDCoMKg
wqDCoMKgIExpbmsgZGV0ZWN0ZWQ6IG5vDQoNCjIuIE9uIEFybWFkYSAzODUgQ2xlYXJmb2cgR1RS
LCBsaW51eCA2LjEuNjkgd2l0aG91dCB0aGlzIHBhdGNoIC0gYnV0IG1hbnkgb3BlbndydCBwYXRj
aGVzOg0KDQpbIMKgwqA1NC4yOTA2MjddIHNmcCBzZnAtMDogbW9kdWxlIFRQLUxJTksgwqDCoMKg
wqDCoMKgwqDCoMKgVEwtU000MTBVIMKgwqDCoMKgwqDCoMKgcmV2IDEuMCDCoHNuIDEyMTU0SjYw
MDAwMzkgwqDCoMKgZGMgMjEwNjA1IMKgwqANClsgwqDCoDU0LjMwMDE2NF0gbXZuZXRhIGYxMDM0
MDAwLmV0aGVybmV0IGV0aDI6IHN3aXRjaGVkIHRvIGluYmFuZC8yNTAwYmFzZS14IGxpbmsgbW9k
ZQ0Kcm9vdEBPcGVuV3J0Oi8jIGlmY29uZmlnIGV0aDIgdXANClsgwqAxOTkuNjg5MzI2XSBtdm5l
dGEgZjEwMzQwMDAuZXRoZXJuZXQgZXRoMjogY29uZmlndXJpbmcgZm9yIGluYmFuZC8yNTAwYmFz
ZS14IGxpbmsgbW9kZQ0KWyDCoDI2NS44OTI5ODZdIG12bmV0YSBmMTAzNDAwMC5ldGhlcm5ldCBl
dGgyOiBMaW5rIGlzIFVwIC0gMi41R2Jwcy9GdWxsIC0gZmxvdyBjb250cm9sIHJ4L3R4DQpyb290
QE9wZW5XcnQ6LyMgZXRodG9vbCBldGgyDQpTZXR0aW5ncyBmb3IgZXRoMjoNCsKgwqDCoMKgwqDC
oMKgU3VwcG9ydGVkIHBvcnRzOiBbIEZJQlJFIF0NCsKgwqDCoMKgwqDCoMKgU3VwcG9ydGVkIGxp
bmsgbW9kZXM6IMKgwqAyNTAwYmFzZVgvRnVsbA0KwqDCoMKgwqDCoMKgIFNwZWVkOiAyNTAwTWIv
cw0KwqDCoMKgwqDCoMKgIFBvcnQ6IEZJQlJFDQrCoMKgwqDCoMKgwqAgTGluayBkZXRlY3RlZDog
eWVzDQoNCkkgd291bGQgaGF2ZSB5ZXQgdG8gdHJ5IHRoZSBleGFjdCBzYW1lIHNvdXJjZXMgYmV0
d2VlbiB0aGUgdHdvIHBsYXRmb3JtcyAtIGJ1dCBpdCBzZWVtcyB0aGUgcHJvYmxlbSBhZGRyZXNz
ZWQgYnkgbXkgc3VibWl0dGVkIHBhdGNoIGlzIGNvc21ldGljLg0KDQo+IFdlIHNob3VsZA0KPiBl
bmQgdXAgbWFya2luZyBpdCBmb3IgdXNlIGFzIGEgMjUwMGJhc2UtWCBmaWJyZSBtb2R1bGUNClll
cw0KPiB3aGljaCBzaG91bGQNCj4gcmVzdWx0IGluIGl0IHdvcmtpbmcuDQpjb25jZXB0dWFsbHkg
LSBpZiB0aGUgcHJvYmxlbSB3YXMgcHVyZWx5IGNvc21ldGljIGl0IHdpbGwgbm90IGJlIHdvcnRo
IGFkZGluZyBhIGZpeHVwPw0KPg0KPiAoUGxlYXNlIGluY2x1ZGUgaW4gdGhlIGNvbW1pdCBtZXNz
YWdlIGhvdyBpdCB3b3JrcyBvciBub3Qgd2l0aG91dCB0aGUNCj4gcGF0Y2guKQ0KDQpva2F5IC0g
SSB3aWxsIG91dGxpbmUgaXQgaGVyZSBmaXJzdCBiZWZvcmUgcG90ZW50aWFsIHYyIG9yIGRyb3Bw
aW5nIHRoZSBwYXRjaDoNCg0KPiBBbHNvLCBwYXRjaGVzIHRvIG5ldGRldiBuZWVkIHRvIGhhdmUg
Im5ldCIgKGZvciAtcmMpIG9yICJuZXQtbmV4dCINCj4gKGZvciB0aGUgbmV4dCBtZXJnZSB3aW5k
b3cpIGluIHRoZSAiW1BBVENIIC4uLl0iIG4gdGhlIHN1YmplY3QgbGluZS4NCkFjay4NCj4NCj4g
VGhhbmtzLg0K

