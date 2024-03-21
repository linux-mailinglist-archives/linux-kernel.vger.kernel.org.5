Return-Path: <linux-kernel+bounces-110015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579488858EB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49EF61C210D1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489B27603C;
	Thu, 21 Mar 2024 12:17:38 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2108.outbound.protection.partner.outlook.cn [139.219.17.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD2775804;
	Thu, 21 Mar 2024 12:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711023457; cv=fail; b=UY5xI/1e17iPMHwyYd5S2sDV906oi5WFhhq5DH+TZJVdUwkQuGN//e9FMbXc56tr0VIlBF1BUzN1KFmYv+3t6r3VKGpYZQBH+8NgcWUWpNncOPKPz7hPYpkHwA2G812UtfHVRqUaj56Xut5x4IPUKautIt3s6I3l/A1Jtw3k3LY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711023457; c=relaxed/simple;
	bh=nBVqvIHL/9WSZ47DJkNUrAW+pB08e5SENIt+FHtGeho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ArMrUetp6LXULqCroVLY9mOukEFM2r0c5I5Rj9Kq3G45XyNHQ3n6aKVO0KprN9O5cLOtVLRuo5LpX1xsysM63AnqJvdNuNrFu4XjcOMzEm0BljlNHp7Ny5hlkdBOrxkrpedE8ZjyxsXYdprsAjsJ3BRbs9BwYQlUrtJj+3ufagk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fq9aPu2oflmpPfT80tA0+W1STuHvhzFykKhA79Suh6h6iqq30dDfoBv9T341U9ixlVbP10plF1Z8sjwnYPjodmF1F48AhjzbHCazPEjkOLzw4iFi9SF1A4ZV1smuRR60gYy/P9fUgJAugQmhIsd3eZyNJiDZDO80xlLHUXCOUHht15XrJ0cwlo4IZJegt0XDKwEiQz0MdGG0C4FGgfqJSG5nqo9WJd7Xi5/eCqjkXjquv7RLVd+XTlwdMC0NkTBMD9L5IwEow9tHClizytDY3bhvQj8zHX3wonWhM73ZlzOqzUsy73Y8ZLe9a0WeWHET3/Ak5T4z6K2p4E0dOyMT2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBVqvIHL/9WSZ47DJkNUrAW+pB08e5SENIt+FHtGeho=;
 b=C0Sd0XdTAA5iwLXaJgjcMYCP8EixH9wbORcqy5RSterddVQdf+M+7ATaAhy8A1OIFTUXHgVjzKe58iNLx71de2kZ6YLqSOwHPQAnKORMekF01JHLfz7ZmlBFc5tcVMXc7XCntqvInzJSo/5kTjaq3/Op2ABj3ZbXbzPEvtQT0copwTXNfRE+xvtG2XWx6IXidv6a/q/uJQ8NbRu+pO0EFGXwvk8LXLvwq7R3JVkH4HcoAlMlpxMwFF3BaxYkl6DE2GpWLA/TvXB04O2TSjs7qkojMEWyGl5flmqEMcFjiOJfoyS3jGtu1q+whLkhGB9mLiXuLKWrmap1Tg5cCNi2Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0589.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.35; Thu, 21 Mar
 2024 12:17:25 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%6])
 with mapi id 15.20.7249.041; Thu, 21 Mar 2024 12:17:24 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Jack Zhu
	<jack.zhu@starfivetech.com>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-staging@lists.linux.dev"
	<linux-staging@lists.linux.dev>
Subject:
 =?utf-8?B?5Zue5aSNOiBbdjFdIHN0YWdpbmc6IG1lZGlhOiBzdGFyZml2ZTogUmVuYW1l?=
 =?utf-8?B?ZCBjYXB0dXJlX3JhdyB0byBjYXB0dXJlX2R1bXA=?=
Thread-Topic: [v1] staging: media: starfive: Renamed capture_raw to
 capture_dump
Thread-Index: AQHaa6YnLa1tXVh+aUef9+vjDvqGG7FCFPIAgAAiCwA=
Date: Thu, 21 Mar 2024 12:17:24 +0000
Message-ID:
 <SHXPR01MB0671C5F9FD505906E460FA2FF232A@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
References: <20240301070025.11144-1-changhuang.liang@starfivetech.com>
 <d741106e-5bff-441a-beb3-5ef1c81d912a@xs4all.nl>
In-Reply-To: <d741106e-5bff-441a-beb3-5ef1c81d912a@xs4all.nl>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0671:EE_|SHXPR01MB0589:EE_
x-ms-office365-filtering-correlation-id: 023e733e-7f8f-495c-1089-08dc49a0ddeb
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zENz4RVQ5qKy/NAXLK++31h44giAg+48c+Ve0BaHamM6h1irmzlv5/AEiHISFkwLvWcTTHYCIv1inZX//vinh3ne6D7zP/fgaHdTJOU7hOONxYG/+GMh1rVwR2YpUWVyNzUpL9axrqC8VZhdY+t4/DpvEixcO6FP26EKinPaTxxVlJMB9uGzLOlxCCZCjs6gMwYHa5YDT0LrnfPHb1qEgS3e8elqZC+tPr7KAa+dNtAWRMIMr3ts2HZGwUGh7L1nMEkUzz3MjF+27B6E8UtybKuR7o2ar2wRWdimqdhhGMVoBo+diakmG1GpLPSJWTH5luowt8f5xUHvIFhFKLouZedxq0fS2+gBLOwIjiHkCnlyXnwbZS0Wgvy+TCjoize1dyX1GgsQaM2guCXU/GvhUuKB8/EMtJfIyUGX+GYHEaLr1HywiiOckLfziesmaVAbmc4pi06khEmL6GeyWz09evVozVnrkZtyHrBSQ7wBAo+pm9jHIIZeU16e8yb593xb62/X0pXzuW94k1Sb01wYA9MQ/FM0zcgAM8iSVv9+p6F55Qy6DBWRNkD7NXNasvEX/kuGRbSR8LeNd5+PJkHCZEkXS0hzCnK/X1XDZjfJLIvq0FhElYh9baJRlUBG3aI9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(41320700004)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OUU0UmVBbXZoVHd5dWcra1Y2OFdZQ1Q1bUpMTEJUSlNkbkFRb2x4Z0luaUl6?=
 =?utf-8?B?bWlEQXFYT05lbWR6Z2VlSS9NeS84U0tTUXJWQWZoa1dkaTFxQ1hRMkdSU3Yv?=
 =?utf-8?B?VDMrUkpFcllsTy9UclFmNlI2NlN1dm50MWI4RGpCa2ZPdnFmYXBnaWp0K2th?=
 =?utf-8?B?V0hCK0RlbFB6TGZKVkZRUFBId01raDF3c2lZSGJKM1VBeUg2ODBTRkJIdTY1?=
 =?utf-8?B?T0xWMlJMZG9ERUtZRXJsUmgvM2d5YXNsOStqNll6WURWbGVjb3hmcW9MaVgz?=
 =?utf-8?B?UkZ5S21LSXowc0t1RkJZMEF2dE5QaUNkYUQrdkx6ZkU0MC9EUmR5dG5mc3BT?=
 =?utf-8?B?em52WW1aaGw1TjJsRUxZU01WQ1U1ZmE2ekFzamRaRTh6Vy9tNzlHZ2FlYU1X?=
 =?utf-8?B?Ymk2bTBDbHpZWU5oRDhhaDhheGQ3TFRoVFkrQTNObGxucmhMK25IVEtBTm9Z?=
 =?utf-8?B?RVlUQVkzQ1BLcE8xdGw5bkxpejZDa2VYTHdadVAySERzZTNpVFB3VkRKWjY3?=
 =?utf-8?B?R054T3FuWXhqNFVtTFJtUlNNSmgwcTBIU3pBekptNXM2L0p3OXNLc1poNWJm?=
 =?utf-8?B?Wnd5bCtCRTM4NGVxdVRyVjNQM3hZbHJHT1lWVC9tNlhQMVA4SExRZmcyTzkw?=
 =?utf-8?B?M0hpL2FaQjQyMFFtMERHdjYvYVI2OWNLWkdlSytuSGpIckhmMEdQdDJ4NnZE?=
 =?utf-8?B?S2xqNUw1U25OUFkrSGxIREpGdU5DQS9MNDFWUWhnZzFBK25TeWlpNUxQSWVx?=
 =?utf-8?B?TDRXVVlzWmIxcUVMczRJUUFpUllVcUpIZnRtbHVGNEwxVjlRUTZOQVU4bzRZ?=
 =?utf-8?B?MU5zY0N6aHZqRS9HaWNIR2gwaTFDWmxBYmhXV3pwWU5qVTYrd2wwdzk2eXM2?=
 =?utf-8?B?clJ0NGxDdWZSR1ZYU3VNTm1RSEZ6OTVFSHlZblBmYUtXM1ZDNm1McHJjbEl0?=
 =?utf-8?B?QWZscDRBditCR3hwUGZlSDV3QW1iRm8zekdPS0xrbXMzM2phalFyUERZbHo2?=
 =?utf-8?B?NUdmRVlyL1NHQi84ZHdzd3dsdWlhdzRmdGxwSjRpUWNpSnVoTDVEVFZXSUNy?=
 =?utf-8?B?eUE2dnZnTGVZcTAxMGcvckM0VzdqYnR5ditWYWdmNjc0cGVQQlpLbFRnalY2?=
 =?utf-8?B?QWRoeVYyMkJibkRlYWpMaGU2NWZrNytmQ3QzVnFCSk5kREpmYy9nQldSMC9o?=
 =?utf-8?B?UXdiMFh0SDJjOVVvNWM4WWZ0Y1hyTjRCZEN0SmhaeTcreDVzWWVDN3RwUyt0?=
 =?utf-8?B?Qk5FUHVVR0ttNEUraCtYRk1hTjVJVEFCSEJVZnY3dFd4RjJSSGd1bVBRNWxU?=
 =?utf-8?B?RXJUenVoeXR6SnVGZ2pYbUdGdFAyNzczdDFJekhZYTF3TlRhUDJVZXBEUGVk?=
 =?utf-8?B?TU1haE5CZitycTJlSjZpQ0FuTTRWT3FXQmpwQkQvaW9DTEJKQmhvMy9BaldH?=
 =?utf-8?B?WTBlZFkwelNBQm13TS9DaExZV1FYayt6UjRxMHJoRjBDZ1NSVUh6R283MDFp?=
 =?utf-8?B?QldwQ1NONytyZG9TRzNRQ1pjbGNhSFppY2RxRTNTR2sra3E5dkY4Tzd2NVRL?=
 =?utf-8?B?bWhQRzlWVlMyZk5DVlFsT3JpTzJleDlvOWN4VTlBcXJCbWhrWnkwSDNNeDNj?=
 =?utf-8?B?dmFNRjRkSElHVUhmY2NPK1p1Kys1R0VoSHBCMXRiR3FBeExFUS9UZFNBb3NS?=
 =?utf-8?B?bnAzalk2OWNyMjJ3b2gxa282S21lZnhNSGRDaFZ6SVptQk1LQjFQWXlOMDc0?=
 =?utf-8?B?OXY1SWlqd01lNlZoRkNtaythQ2Z3QzBNd1h5bVVCNU5naGVFR0w3RE5Zeitj?=
 =?utf-8?B?ZElYYmlMVkFaL1ladXhNcVQwWk0wMTBjK3QvZzExTXRIdk45TzByaVQrZ1dx?=
 =?utf-8?B?VGhGdk9hZHFOOFFwelppcEFZOEtFTWswT2ZTMC9OalJkVDNza1hCck1oU0c3?=
 =?utf-8?B?WHM4Y0tZZHM0MWlGT0M4dk1RS0N1dnpzQUtmcGJlblZvWnBKYjA1STNNWmVW?=
 =?utf-8?B?Ri91Q25LdzNsZjRLc0RUM3BnN3dzSzJnUHUvd2lTeWpUV2lId2gyVGNjTXVL?=
 =?utf-8?B?L0haZnBEMEs0aExma3N1ZVFTQkpuRHFyTm9qbmNOYTAzdVdwbWhaUEJSemJG?=
 =?utf-8?B?YXJKdHloTW8vSTExR0dTVHJqU2dOcUREVzdOWm8zUU1FSUJsbUwzR3NhWHpI?=
 =?utf-8?B?Y2c9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 023e733e-7f8f-495c-1089-08dc49a0ddeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 12:17:24.6071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZLhw8f+zSVV6A+Gwq0Vy6O329lh75OLeJvVBpkvJ7A0W/0LPInZiNfy8jNrRLpGvybD9K2x1b9+3dWPLc5LC6fHcpbrFb06mS9Z0kfJ7uJ0notBayzSbcG1n1hgEogn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0589

SGksIEhhbnMNCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KDQo+IE9uIDAxLzAzLzIwMjQg
ODowMCBhbSwgQ2hhbmdodWFuZyBMaWFuZyB3cm90ZToNCj4gPiBUaGUgcGl4ZWwgZm9ybWF0cyBj
YXB0dXJlZCBieSB0aGUgY2FwdHVyZV9yYXcgdmlkZW8gZGV2aWNlIGRlcGVuZHMgb24NCj4gPiB3
aGF0IHBpeGVsIGZvcm1hdHMgY29tZSBmcm9tIHRoZSBzb3VyY2UgZGV2aWNlLiBJdCBpcyBhY3R1
YWxseSBkdW1wDQo+ID4gdGhlIHNvdXJjZSBkZXZpY2UgZGF0YS4gU28gcmVuYW1lZCBpdCB0byBj
YXB0dXJlX2R1bXAuDQo+IA0KPiBJIGRvbid0IHRoaW5rICdkdW1wJyBpcyBhIGdyZWF0IG5hbWUu
IEkgdGhpbmsgd2hhdCB5b3UgcmVhbGx5IHdhbnQgdG8gc2F5IGlzDQo+ICd1bnByb2Nlc3NlZCcu
IEFuZCB1c3VhbGx5IHRoYXQgaXMgaW5kZWVkIGNhbGxlZCAncmF3IGNhcHR1cmUnLg0KPiANCg0K
U3RhckZpdmUgSkg3MTEwIFNvQyBhbHNvIHN1cHBvcnRzIHRoZSBvdXRwdXQgb2YgdGhlIHJhdyBm
b3JtYXQgZGF0YSBmcm9tIElTUCBwb3J0LCBzZWU6DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2FsbC8yMDI0MDMwNjA5MzMzNC45MzIxLTEtY2hhbmdodWFuZy5saWFuZ0BzdGFyZml2ZXRlY2gu
Y29tLw0KDQpTbyBJIHRoaW5rIGl0IGlzIGJldHRlciB0byBjYWxsIHRoZSBJU1Agb3V0cHV0IHBv
cnQgImNhcHR1cmVfcmF3Ii4NCg0KT24gdGhlIG90aGVyIGhhbmQsIE9sZCAiY2FwdHVyZV9yYXci
IHZpZGVvIGRldmljZXMgY2FuIGFsc28gc3VwcG9ydCBZVVYgY29sb3Igc3BhY2UsIA0KbWFpbmx5
IGRlcGVuZGluZyBvbiB0aGUgY2FtZXJhIG91dHB1dCBmb3JtYXQuIFRoZXJlIG1heSBiZSBhIGNv
bmZ1c2lvbiBjYWxsZWQgaXQgImNhcHR1cmVfcmF3Ii4NCg0KUmVnYXJkcywNCkNoYW5naHVhbmcN
Cg0KDQo=

