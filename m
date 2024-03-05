Return-Path: <linux-kernel+bounces-91793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8048716B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA5C1C20B3B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF4C7E574;
	Tue,  5 Mar 2024 07:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="KlaNh4hU"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBE14C637;
	Tue,  5 Mar 2024 07:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623612; cv=fail; b=LGWXaJCbs7GJf2xl7bNE/TFOAYu1Z8shCVkyj+2TYq06p+omGRUMiHhx5fyq6PkR8MJ+29jL4z860U1E2qeFfb5zWmafdyz/EWCkAMQhkGgK9fOjSH3UgMl0eccEK+skbowAabZJxXvj+YnAczx4cwLiZZNfntA9NT8CJp/RDV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623612; c=relaxed/simple;
	bh=cumaUsRKLX9I+VniU97I7hPe4OxwfBOZhpN3aw9wRJI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r8+RfP+s01UP7hrrUhC4kNrqNTsTYK5MH8WfAuarJWi+8TUtm/LZp8+pMxOyqD/BoqFic1nEjDO+o2gxgTmEQAwcaDN2vwwDYz9DsCBEqgMld1QuGJAkeiU3amLCCCnufu6i2BP4wZ1I4CvL+SM2bZtaWSfc/KiMg1Nb7xPghOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=KlaNh4hU; arc=fail smtp.client-ip=40.107.105.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQ2veCKgMHZ722cqt5ziGTQEEOLVQshtvnWMJiuG60Cq3+RxDWtROYolrsvu8b7UHJAInC4e+doR3LUYrc6m4poGKFOg6kzYAc2IN6Oe2uuhyp8ZI8OvKJl4/3eAvWTD6CbU/NQ4EmmyI8x8hg6xBsSLFab8hp9yULCO1WXBHQRqI9RyFLtJrYao2RNphG6nk+ZgTFHhLfMUtKvnp6DUUEa7lPhueGsQrRtvMtNtwEk8PgB1oP9sTCI41sVduIiflgq2Fw1yVlVsQ38RZ5DfSD0BZ5E64hoedIIwVe1GAkpPXarhAVcAhJ0yJbSZ7MeHhRD/8IiyIZnUcIOE8UDYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cumaUsRKLX9I+VniU97I7hPe4OxwfBOZhpN3aw9wRJI=;
 b=Rtsb+3KS46Lsql6nytpctB0nnv3l4AYr+cwhN03d4PdqHsXnnmBCO38k/nGTnktaX3/PwXkprPhEJOL632lHfvBUDo6qABOveQcmlz4ATjvoHE+14s6YkuQFEmh3sF34VCsvw/AbuM6p8s78cAebGEkXRRyDr+hSNfieOLSiZdT2Tsyp4+HAIGfbhi6pHgh2QAdqTNeKQhvTYLr61pO2pqbpGpbQZs/K9HkzXpsbWDBcaalVIWZb/kLnFu57RVY9HUKsP5n3nMtLA/Z17Msx4YMV/bt0LWrZ+4WM1RAd6POb5Fk7tsB3TYmEMBrIFhwb+BRVrQorHIM4fGjQ1bxo/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cumaUsRKLX9I+VniU97I7hPe4OxwfBOZhpN3aw9wRJI=;
 b=KlaNh4hUahZMKSuhhtEEbgr4On5/juEgo6lrNbKC+ZWXqb9zOgsO68hEZ/ivSaSdBLeJBs+RS3RIKND+6/WP9B+t0pVKv6zVmnfeAjNtdGnea44aSai9I0yxwyraDBwdxqETXFu4MMvWW1kjDhKL/hRI7Od2nTMGVIeGwMyglK0SAKbEkVltAbOgeu1tmnG8JR5TNjiogUhXfiQ19yTvhy5V79S3tzBYxLnpJIAk3r5hXDTnxbTjs4TSyC9lmWRN+TzC3M0PDhOkDA9L0gbkn5qRm+ouoMFUsc1k42R8mdJBpngB4qXVe3EnyVSWxJTT3QDCaF9pysG8la95enFtbw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by VE1PR10MB3839.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:16f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 07:26:47 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ab67:6d35:16b1:81c8]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ab67:6d35:16b1:81c8%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 07:26:47 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
	"sherry.sun@nxp.com" <sherry.sun@nxp.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "robh@kernel.org" <robh@kernel.org>,
	"shenwei.wang@nxp.com" <shenwei.wang@nxp.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "jirislaby@kernel.org" <jirislaby@kernel.org>,
	"robert.hodaszi@digi.com" <robert.hodaszi@digi.com>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "frank.li@nxp.com" <frank.li@nxp.com>
Subject: Re: [PATCH V2] tty: serial: fsl_lpuart: avoid idle preamble pending
 if CTS is enabled
Thread-Topic: [PATCH V2] tty: serial: fsl_lpuart: avoid idle preamble pending
 if CTS is enabled
Thread-Index: AQHabp9Uk8Hm89cO+E27Fp3CwqHMgrEov7YA
Date: Tue, 5 Mar 2024 07:26:47 +0000
Message-ID: <317ddcba7d49ab22c3a138c34235a1118f9c9297.camel@siemens.com>
References: <20240305015706.1050769-1-sherry.sun@nxp.com>
In-Reply-To: <20240305015706.1050769-1-sherry.sun@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|VE1PR10MB3839:EE_
x-ms-office365-filtering-correlation-id: b75db83a-05a1-408a-7d8b-08dc3ce59df4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GR9nonmlSIBoXkEMlsa0JvQnXWFJ0KFgaHROVjOLUfxwsGDSG0rvUkB5BdUDRuAnO0AmhUtP3wd7r8kkG+2KP/UHbaNjy0OD8iUUFqRjyTDZ/T7Tt93RDDhBSXs1SGEzlPxlaLuyRgSiiD6n24v+zV+6Hce70hhByllCq8oWEOoFJ6Ip09gBhXNiOR2zhsUQj3v0DW8ZZZ0AYZ2CGmCJlJXAk0Q6poGg9/dHfOjyKEDusR57tV3pa4HiUp02kmRPqflMcDDt0R8kdXkCgIv3s2gi9wyo2fiSdAXnzvhmLIT6ohA9zWZCsC7eeuzEHNnAlYm13i3KQg81GGXi4zFRolBhTlypSLGZGZTjUXXfVSLv+7IL4lneqWnMAxyrAVKFvzbxUrYNRA52jwVLPx7vuKRuD3BtjlhJhzNDsamSkSTa54W5N2KLof4EoYSVsd1qiMS/OaZXR95HKH4GJwCs4VqXZ4PabzjfUyc5WMrXyKM3pQw1R0EkmQ29sIjNYJ3dda0FUm6GM7wp1qVXm537bZ+52qjTau9xKp/DDhSo3l7/HAVRJuSmoa/nsMXFhpf/YTBb+kU4X+xfnJnRay46Mwpx0BtcqcigbreUauRbQULOQt0rNktXGYVDoUthYVueiLtuxcdVo9jpGWM3vD1YO/hsmu/8Zx4pmbfJPoOrTmU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bmRPbVI0T1FrMkR6SXpFRlVZUW92MWZKTWMza2lLOUJHMUhTSlJDSHk2RFJn?=
 =?utf-8?B?Yll3Y29nN2JrQ3p2bXArZGQ0a24rUTY4UWpTcDlNSms4S3JUY0wvOXNtcjJx?=
 =?utf-8?B?MjhRUnVJUDFxQU9OeS8wbjNNYXhOTGM1QmFDRVdldHoySXRLK3EwZXQzWFNV?=
 =?utf-8?B?dGlzWXJiRUYyMHBMcS8xdGY5WFZuWkJqemNyUnBjTlBsWDlWaEtFL1NUTWgr?=
 =?utf-8?B?TnhMQ1JGWjVXZHlVdjNSdE01bmJNOHhlQ296ZVMvNFZPOTN3ck9ycGt5NFJO?=
 =?utf-8?B?emFBL2RNT3RpM3BXVnJYNEpwb2hpMVFERjN3T0hmTzFXV1VCLzZqQTNESW9M?=
 =?utf-8?B?eHNlUUNFZVhwak51elNGTVJxZDVBQ05FVi83MHEwdHpyRittclgyZXYwdnAw?=
 =?utf-8?B?aFFoNEprNEcya2dVeDRjSVNuNDRJRk9QSmJNY2ZsTnhhUFgyWHNjWWNCd3py?=
 =?utf-8?B?VzdLdG8zSkFGZFVzRFJhSFVYRHU4N3dPWVk2Q2VwTXZjS1JodytTaUhlQ1NC?=
 =?utf-8?B?YkkwSkgrK2s4Y2d5WW5sYitkcU4zMWFzUHBkcllJNENQRHRtUmx1Mk9MekhW?=
 =?utf-8?B?WG1EVmZ3dGlTOTN1dFQ0Vm5vZ1BVeXA2b3UzY3c2TVExQ0pBWFNHTkZraS9u?=
 =?utf-8?B?clhNNkxUak5RUHo5cHFOMjlGYXorWEY1cmFSRTZmeXQxdjNXSkZJajJsVm9x?=
 =?utf-8?B?VStWckt4c3lHTlVzZkFQS1h2VnZvSHhNSTV1MnFUVEhNUVBmTENmajlkTE81?=
 =?utf-8?B?UEdHT1NucHpTOXR0YnUwZ0tUMHF5ODZwbnRkMnFnR1JRVWwveC81KzVEQ29a?=
 =?utf-8?B?ZlAxNHp6UnZtQU1OZDRhSlo3V1NoTFRvRkZmQ1QzMlkwM1haL0t2K2djdHNl?=
 =?utf-8?B?dytYcEFrWm5paVVHdnlSKzhXeVZwN2RjMU9LeGRsN3JodUFPUWM5WFBNSjA4?=
 =?utf-8?B?ZGgxcXlMRDgxeWk4ZmZnNy8zemJXSnBJME1BZTAwMGtyVmZ0QUlFR01yZDZx?=
 =?utf-8?B?OTAxU1I5WmJnakJaT1dXeEl1V3Y0M051ckdZRWlEbmNjM2FieGRqQUlibHhK?=
 =?utf-8?B?WGNNcURxWG9DUW15YkRUWVlqYVR2MHBDQWtnWk9zSkZLL1B2R1lQS0pXUVB0?=
 =?utf-8?B?RC80K08rZUIxeGgvNWJZZ3pHTkJNa1RwZElVZjF4TWJybUV6MWZBcWVzVU52?=
 =?utf-8?B?RUNOMWt1M1laQmJEa1JodEY1S0ZNMS9vKzV2VkJINjhYbWM4a3NnMjRHVEJB?=
 =?utf-8?B?UEIwV1FFYmpTWFhwanMzWnNOYTBGa2RvUklOc2hVanBFSzhvZGJVVWs4SDdn?=
 =?utf-8?B?d1hUc3VibEsrSHNteFJKTVdrTzdzNWVpaUVQcTNqR3pVMjRJaDJpVU02c3RI?=
 =?utf-8?B?UVJLYmkrL0lROUxjeWdIOVRwcUdvejNhc0xPRmtCRDlvb2RaMk1DdTJUTExa?=
 =?utf-8?B?STFudGJDSTNHL0FqSVd1NVQ1Mlk3Vnpnbm1WWFN5YUZDaUtWSGJJZTIzWjRY?=
 =?utf-8?B?NFBDZ3NQUU8xMDlZczJWcW83NktSTWo1d0hrdUxtYzcwZ3psYXhzZXNCMGRY?=
 =?utf-8?B?YVVuMkFTMzVzejFGL25WWmJIdlFBZ2dVWU8yTEZMaVJUV2RVNVRzWkNBQlhk?=
 =?utf-8?B?VXppVkNveTNXR2tvRFJHd3QwamJpQm4yU092d1J3T2l6aFNodG9sc2NxRzI0?=
 =?utf-8?B?emJzOXJYVXhaQmU2a0tCQTNXSVhIWlg2Y0RTN2o3TmxDS3p4TEdBYkpRUDZC?=
 =?utf-8?B?RHd1NCsycTc4ZGFocDUzQmVrakV4enNIN1ErYVhnRzZrM21uOU9keEVOSVpT?=
 =?utf-8?B?VER4aTdCdDlDOExOVC9aUFF2YnpxZkROaTFHS3R0YXJpVWoybFAwTlpuN2lp?=
 =?utf-8?B?cm92cDFMMjNIVm5SdldWR0kvNHlzc1VSZWpTeFdldFFBdFdKNFMwSHZGU3Vr?=
 =?utf-8?B?cmdqcHhoREQ2bTBXU05KclJqcGs5Y3NFT0MzcTRSSmVPR3AxQkRaWTVndEkz?=
 =?utf-8?B?YXV4R0hwM25aZ2VsMHlKbVhmNStWT1JobHEycnpEUTNMS1ltSUdJWWtPaE1x?=
 =?utf-8?B?a0o1bDBOMlhSRkdrS09VSndyMkZsNjBCMHJ2dHlDSytCeHdhRnlHNk9IUHdU?=
 =?utf-8?B?cEo5VXduamdpWE5qMjBmaUxtRVR5MzFkbmYxUFk4MWdHeFovUEN2SjFIckpr?=
 =?utf-8?Q?8eU/nNP4b6zpwK0bSBJ2vG0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACF2D50DAB55154C827620180C17E52E@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b75db83a-05a1-408a-7d8b-08dc3ce59df4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 07:26:47.4952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 92DNsnMt7x/WwNeVvxk+sXiF+f6hBdyeak5zsbjfWdGR4LcDojVImtArUP1GHcgSLHA94ZkK+IiHbkMeWsWteHaztNqlQTJTq+LMNLm5dYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3839

SGkgU2hlcnJ5LA0KDQp0aGFua3MgZm9yIHJlLXNwaW4hDQoNCk9uIFR1ZSwgMjAyNC0wMy0wNSBh
dCAwOTo1NyArMDgwMCwgU2hlcnJ5IFN1biB3cm90ZToNCj4gSWYgdGhlIHJlbW90ZSB1YXJ0IGRl
dmljZSBpcyBub3QgY29ubmVjdGVkIG9yIG5vdCBlbmFibGVkIGFmdGVyIGJvb3RpbmcNCj4gdXAs
IHRoZSBDVFMgbGluZSBpcyBoaWdoIGJ5IGRlZmF1bHQuIEF0IHRoaXMgdGltZSwgaWYgd2UgZW5h
YmxlIHRoZSBmbG93DQo+IGNvbnRyb2wgd2hlbiBvcGVuaW5nIHRoZSBkZXZpY2UoZm9yIGV4YW1w
bGUsIHVzaW5nIOKAnHN0dHkgLUYgL2Rldi90dHlMUDQNCj4gY3J0c2N0c+KAnSBjb21tYW5kKSwg
dGhlcmUgd2lsbCBiZSBhIHBlbmRpbmcgaWRsZSBwcmVhbWJsZShmaXJzdCB3cml0aW5nIDANCj4g
YW5kIHRoZW4gd3JpdGluZyAxIHRvIFVBUlRDVFJMX1RFIHdpbGwgcXVldWUgYW4gaWRsZSBwcmVh
bWJsZSkgdGhhdA0KPiBjYW5ub3QgYmUgc2VudCBvdXQsIHJlc3VsdGluZyBpbiB0aGUgdWFydCBw
b3J0IGZhaWwgdG8gY2xvc2Uod2FpdGluZyBmb3INCj4gVFggZW1wdHkpLCBzbyB0aGUgdXNlciBz
cGFjZSBzdHR5IHdpbGwgaGF2ZSB0byB3YWl0IGZvciBhIGxvbmcgdGltZSBvcg0KPiBmb3JldmVy
Lg0KPiANCj4gVGhpcyBpcyBhbiBMUFVBUlQgSVAgYnVnKGlkbGUgcHJlYW1ibGUgaGFzIGhpZ2hl
ciBwcmlvcml0eSB0aGFuIENUUyksDQo+IGhlcmUgYWRkIGEgd29ya2Fyb3VuZCBwYXRjaCB0byBl
bmFibGUgVFggQ1RTIGFmdGVyIGVuYWJsaW5nIFVBUlRDVFJMX1RFLA0KPiBzbyB0aGF0IHRoZSBp
ZGxlIHByZWFtYmxlIGRvZXMgbm90IGdldCBzdHVjayBkdWUgdG8gQ1RTIGlzIGRlYXNzZXJ0ZWQu
DQo+IA0KPiBGaXhlczogMzgwYzk2NmMwOTNlICgidHR5OiBzZXJpYWw6IGZzbF9scHVhcnQ6IGFk
ZCAzMi1iaXQgcmVnaXN0ZXIgaW50ZXJmYWNlIHN1cHBvcnQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBT
aGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+DQoNClJldmlld2VkLWJ5OiBBbGV4YW5kZXIg
U3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4NCg0KPiAtLS0NCj4gQ2hh
bmdlcyBpbiBWMjoNCj4gMS4gTW92ZSB0aGUgInJlc3RvcmUgY29udHJvbCByZWdpc3RlciIgY29t
bWVudCBtZXNzYWdlIHRvIHRoZSBhcHByb3ByaWF0ZSBwbGFjZS4NCj4gMi4gQWRkIEZpeGVzIHRh
Zy4NCj4gLS0tDQo+IMKgZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYyB8IDcgKysrKyst
LQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYyBiL2RyaXZl
cnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMNCj4gaW5kZXggNWRkZjExMGFlZGJlLi5iYmNiYzkx
NDgyYWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMNCj4g
KysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYw0KPiBAQCAtMjM0NSw5ICsyMzQ1
LDEyIEBAIGxwdWFydDMyX3NldF90ZXJtaW9zKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVj
dCBrdGVybWlvcyAqdGVybWlvcywNCj4gwqANCj4gwqDCoMKgwqDCoMKgwqDCoGxwdWFydDMyX3dy
aXRlKCZzcG9ydC0+cG9ydCwgYmQsIFVBUlRCQVVEKTsNCj4gwqDCoMKgwqDCoMKgwqDCoGxwdWFy
dDMyX3NlcmlhbF9zZXRicmcoc3BvcnQsIGJhdWQpOw0KPiAtwqDCoMKgwqDCoMKgwqBscHVhcnQz
Ml93cml0ZSgmc3BvcnQtPnBvcnQsIG1vZGVtLCBVQVJUTU9ESVIpOw0KPiAtwqDCoMKgwqDCoMKg
wqBscHVhcnQzMl93cml0ZSgmc3BvcnQtPnBvcnQsIGN0cmwsIFVBUlRDVFJMKTsNCj4gK8KgwqDC
oMKgwqDCoMKgLyogZGlzYWJsZSBDVFMgYmVmb3JlIGVuYWJsaW5nIFVBUlRDVFJMX1RFIHRvIGF2
b2lkIHBlbmRpbmcgaWRsZSBwcmVhbWJsZSAqLw0KPiArwqDCoMKgwqDCoMKgwqBscHVhcnQzMl93
cml0ZSgmc3BvcnQtPnBvcnQsIG1vZGVtICYgflVBUlRNT0RJUl9UWENUU0UsIFVBUlRNT0RJUik7
DQo+IMKgwqDCoMKgwqDCoMKgwqAvKiByZXN0b3JlIGNvbnRyb2wgcmVnaXN0ZXIgKi8NCj4gK8Kg
wqDCoMKgwqDCoMKgbHB1YXJ0MzJfd3JpdGUoJnNwb3J0LT5wb3J0LCBjdHJsLCBVQVJUQ1RSTCk7
DQo+ICvCoMKgwqDCoMKgwqDCoC8qIHJlLWVuYWJsZSB0aGUgQ1RTIGlmIG5lZWRlZCAqLw0KPiAr
wqDCoMKgwqDCoMKgwqBscHVhcnQzMl93cml0ZSgmc3BvcnQtPnBvcnQsIG1vZGVtLCBVQVJUTU9E
SVIpOw0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgaWYgKChjdHJsICYgKFVBUlRDVFJMX1BFIHwg
VUFSVENUUkxfTSkpID09IFVBUlRDVFJMX1BFKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHNwb3J0LT5pc19jczcgPSB0cnVlOw0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0K
U2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=

