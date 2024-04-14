Return-Path: <linux-kernel+bounces-144150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B00908A4272
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FAA31F2134C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 13:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5C83E462;
	Sun, 14 Apr 2024 13:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="f0NhijbI"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2115.outbound.protection.outlook.com [40.107.8.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BF92E633;
	Sun, 14 Apr 2024 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713100065; cv=fail; b=Cvht8Ou02KWhCl7yaL89D1R8xv9+b/YVurnnYEMgAltUsxN0986Ex3bpQ4fvGrmOh+SG5qjLEQ+GDvkjrAHsgVvMt8F/H/4TS0e05ozKgDbWIkwsKE7qMIrNbWkO4dHjfYgjduzYrQPOoktysH28ykwuoa8nLnslyv8Y1xjhM58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713100065; c=relaxed/simple;
	bh=Wnq5EEpfntDcWaucdh3bDgfRw55ucZnyCrS9I34fY54=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oczOLAZJlevUmvBP9QCXIwoATZ6498A3HnZwSmVCZfRD4D+PRcVDNdUl+DjnBa5AWom2m9dYLsKQb9hFGYvYJq4c5Dpn9nXJUxJRLBfZ/P3wz4DDxV+j8PWTivfmdv2hpwPdopJmAsmXCuXyl2dpZVD1lqmEllev/w5w7HCdqPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=f0NhijbI; arc=fail smtp.client-ip=40.107.8.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjINcPL/B+eivlTgJFhxWBhat6UFwpkWrnLf+H9u2SYMTcNd4cZQ5DQvtefoQozjUekWkTbQpL8kbb0VSiOhq8wzDgzBoIXAVxNlt98nWta05ml3I4yx6FiFwLbobjcZLUNUXom1UFbBbg8UulSNLcwY1GP0vvqN8qu1RvUw8XHnslNUPywXKXSMLFE03Xbj/gsMmsIYp8F+J02Edhb+ZyVGrSwNEE1LZh+VRL8PBNW7BZbySWRQSIgE9kyhPwTY+RO1IMw57sbu/NiTWtWC4Bpit2pX/hu/oS4mHldd/uiZwwGtT5KbUc8UeP17bMx4jhWIpp3HRAhtB2l1bKhWPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wnq5EEpfntDcWaucdh3bDgfRw55ucZnyCrS9I34fY54=;
 b=HezXRYsGp3zDbl+nRe2bs2SU6DZiDhLE/Zd4KrgJ1eCNZ0XVHMKIG/Hn76da57Pn8+6bZeaS8/Z65VhW0ifovm/HE8GXiPrwWf4DIy2j/M28rfJiubaSUXbR3PWPI/oPyoQ3s/Q/Sh6OcbuJhoPHTxGm2xZni9BC28lAawLQIxAN6JKxwSs82nXbSeHCE3EODYpp+xFJHQWacjwCSxUno8Nsh9ndgZxdb2BjuZTa5OuX0IwjeVdqGEEt5CNs3PRKz8SFUTJyOQXeNBrsvhI9nVDy8EzJmuJ75tM9luEb0m/OxTI9+20pcaC06lpi9nG5M/3gpSNtUeoSUHnYAkw5nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wnq5EEpfntDcWaucdh3bDgfRw55ucZnyCrS9I34fY54=;
 b=f0NhijbIVitmdJ4roRkdjE+BJVodzOjpkRLQmvvRKYQT/dWZ6h5qbMZYCiSRSCD55okeQkMw+7Ebd887ya518nv2xunyGcOMoU9u0h41rDao6jrhIdad9YnkuHqJT3NEcNzuMpDypFhtNlY5I8odO7an5HY+1x3XIRXwByMDHxE=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB8150.eurprd04.prod.outlook.com (2603:10a6:20b:3f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Sun, 14 Apr
 2024 13:07:40 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7452.046; Sun, 14 Apr 2024
 13:07:40 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, Gregory Clement
	<gregory.clement@bootlin.com>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
CC: Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] arm64: dts: add description for solidrun cn9131
 solidwan board
Thread-Topic: [PATCH v3 4/4] arm64: dts: add description for solidrun cn9131
 solidwan board
Thread-Index: AQHajmt4w4zwT8gI9EGUFXDjzCdkprFnvJ2A
Date: Sun, 14 Apr 2024 13:07:39 +0000
Message-ID: <f5432ff8-33d1-4de7-9bbf-0c0ba51500bc@solid-run.com>
References: <20240414-cn9130-som-v3-0-350a67d44e0a@solid-run.com>
 <20240414-cn9130-som-v3-4-350a67d44e0a@solid-run.com>
In-Reply-To: <20240414-cn9130-som-v3-4-350a67d44e0a@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|AS8PR04MB8150:EE_
x-ms-office365-filtering-correlation-id: 067f1182-38ff-41c6-1710-08dc5c83dd1c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 TpomdVHVK7QZDqEJWXDcSs577ZC4SO3AEZY7Rz/4NmI8DgpmmGzh7FFsrdccdyoGKIWz9LSigDe94lf0CczVRXmT8JNTBghuTfZZsgUS62d8SMyX1s15+S9YM2NO0J4JqumH/AVAYfg8MrNMCyqdfoEpPt09KcvZi/CKlhc4PJWQFhc9asBXK9dD+u2ToTetJEI12ZFmV8z9X12/vxAiL7G/CV3RbqIjdmPbuO7UOG/DXzmbcyO0DpthqUAojUALKraHewglB66UMkWs4+hDLkXgXRRqmeLIXOTiCm47N97YqvbephQZS0aPHjDkLSoDU6LYStdD3QjFZlpQCU5HJ6e0rE7miYJq0Bt+ivgmd7r+aki8Qy+gDP7uSZcChbFIIE+PLbB2nGeU+41c6t7vCLtXT43txhFrINFejT5Q6hH3ePwoEh/iyTNVPRFKkqY1s/QqxQuc86fveH3XfhZlHxZ5BfuH61myRwIk3w9y1TylZHcNe3jsmqlw8OZp/FDQK1/+mrtTZ2CFlvYHI2oRNUwpkjBa1EsQXptxO9wPa1yA8kTKSkU+cyr8d3B3O52Vvxg35+XsfTthuZ8cuAotnyMvF1YdDBcN5/UNFovMqALBqhounURqcz49M6uM1QeBgFMshgijFX7fU0JLf9CYrD9OMkMZG0/B3aD15IjAmPF5cA9hIiEdZlk5DUcDlKKDMOUqThk4TzTOrrPnQcxzOLHoHIYoCUsr9iu09KtnP1w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXlYZzl2SnhXL3I2SDNKS1Mza25TVmJjb2pGTkVZbURUcVRWN3QxdjU3d0Mz?=
 =?utf-8?B?dGlWN0RDWGdJMGdiYldRQ1pDbndRbjVSeTN5WnhReG01M0pUWCtCZVpLQSsr?=
 =?utf-8?B?VlVVaTcxdVkwZW1ISlBrbnJLY20rMDMrNEs4eUZTeVhrbE04ZzJEMDlsZ29R?=
 =?utf-8?B?dFdMdzlpM0ZvWVRIY1YvbitZNGgvc1d1bzhHZGtFdlFTVnM1VDNWWmxiR1RV?=
 =?utf-8?B?Q01nSm5KVjdoUWlCK0kxb015T3AyRU1pMUtEQ2o1VkNiL3BIc2o2TjJYbFdO?=
 =?utf-8?B?SkV2MndMdkptY2x6VVN0NmlqT0dYKzNKN0ZsZStJM0R5TTQ4ZnFIaW1XSGlk?=
 =?utf-8?B?Znp1eFlWMXJ1OVZjS0FnL2NpdG55c0VHdCsvZHVxUmJnL3k4MVZaVndqbHJP?=
 =?utf-8?B?dTlRMFozTVEyVjVGTk5yUkxqRzN5U2RLbnI4YUtxYnhXR0dvS1lDY1hLWThP?=
 =?utf-8?B?MWU2WHE4dTdMOEhnQXE5Z1VTNTR1L2EyUXRXYm1KcFJpanoyR2ZHUCtZaFda?=
 =?utf-8?B?WkVtZmNkZHg1RkxaWlh3STRtb3VOWnFTL0xCV1A4djl4Zi9HOExWUVNNS0FG?=
 =?utf-8?B?Y1A1Q3QwaVhGYTRKRWR4QkFKdXlSVlZFQjVuQnJVN1lpWjFGR2c5dHVDNUpK?=
 =?utf-8?B?bUppYjB3emhPNEkvYkhLSlUvMnFmNExkSm1mRExPamdLNVA4anVKcFlEUUQ0?=
 =?utf-8?B?OTJ2STk5dnNnbXZJWXlRVW5vd0VnMDc4R1NpZXczYnpyY1kyRm1PWUVsdlJ0?=
 =?utf-8?B?V2sySTZidlhpWmJwWnF4ejB4S3lWSzRpb2gxSitPT08vWmtmcWNNRkxYVzN6?=
 =?utf-8?B?dGxkTStFMmhQeDI5VzlzaVBBM3lYV1JnMDZtWVZVRm5VbnE0MnZoTDBEUnNQ?=
 =?utf-8?B?T0lXM0dwVXYzRFN2TUJLLzgyMDZyN0sxOS9peUg5TDZaNVphaU1GbHZjOG5i?=
 =?utf-8?B?UFBrN2dNazM0cFpySmMzclV4T1FJdnM4ampuTTErQml3bEc5S0hkZUxjZjBW?=
 =?utf-8?B?L3A1TVBKWkdJc1N0T2FPcHYraTlEV2hwU1ltak9KNGRKK0F1bUo3TnY4bG1p?=
 =?utf-8?B?c3hicVF3am9teTl3Skh1OEF2dS9RSzlsK0F0MFhFV1lYUlJwZ1JWNlFZSUQ3?=
 =?utf-8?B?enVmbnhaRG1kOE81UithY0NDVXFKN2gyMlhqWTlCMVJQaFU3czVHRXpEMklr?=
 =?utf-8?B?RUozaEM0dktTek1Hc0R4WDNTVnFDdnFOUGRTbi9wOFVzVUNRYWJ0bHRDM0Yy?=
 =?utf-8?B?R2FMMUZ5VGZhTk9xOU1BeDNxamhiZWI5QkNib2dwQ3JEaTV5RTNDU0x5NU51?=
 =?utf-8?B?aTNVUzZVc1o4MGVXUnhlaWphVFFObWd5WDVUUzFrelZ2clVGcVlWanFqNCtG?=
 =?utf-8?B?cG0vQUJiNGlCV3JlVVZqa0Zmbkg1OGFqUWFScTdXQUZqcG9RTEpYQk9ZZ3lK?=
 =?utf-8?B?WXJBZkgzSlZ6S1p4QmErN3FTZVRKT28zZTJOL0REMllyUkN3dFJBOEVQenIw?=
 =?utf-8?B?bno3c0NXcloveVVKY3R0M1hTRTRBMm9nMmlHSENhUC9oMWQ4Mk43cVh6b1ln?=
 =?utf-8?B?NHR1azBYelJmU00xd0NZQWdEQmswa3plVk5ZYmFrd3paS245bEFSUmlOWjFL?=
 =?utf-8?B?SExoUjgzdGtxdEtqY2pXbWMzRXd3RXZKTVBTUm1VZXZUQzJaWUlhTTdxNGtW?=
 =?utf-8?B?Z3Q0ZUxtMCtkQld2VFREVVhwUFBCNFkwTTk3N1dSclROYXZrRmFGTDZWZDNC?=
 =?utf-8?B?M3J5R2pSWXZscWFWWmJNVVREMWVuYk5Ja0FEak1PVjZtdlNlb2ZkQnVTZU9z?=
 =?utf-8?B?VjBIckdqNG9DaFdYS2xiQUVHdUNjWndydmdCbGV0djJ0eUZZem9zb0JqeGNL?=
 =?utf-8?B?dzgxb2JOaUg5VUZ3b2R3VnBVY2Mrby9SMy8rUEJYelVaaDMvNXpSRzkzMDRW?=
 =?utf-8?B?c2ZHRC9uODU2a0J5emZVUGFMMVVza3lHWlVNM2kwM1JRckVzTEpKalpQWEF3?=
 =?utf-8?B?MEQvQlRVWWordTg4S0JTb1I5SlFYL1BNeTB5V04vemVlQjZyc0QxaU4xR1Rv?=
 =?utf-8?B?K2ZQdml5RU5VMm51VkNMYWdXd21qODlLN1NFUm9ZUitTdi9JMVBHRHA1di9L?=
 =?utf-8?Q?tRZ7n6drBQUqwRzsMFC2+Gu4k?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4BBEC2883C95D45AA32A8BD5B0AFBB5@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 067f1182-38ff-41c6-1710-08dc5c83dd1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2024 13:07:39.9628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sygFvFOTlmqrMUDwZxP1yRePN56nEdDO4H0pYPZWvuwh2dj600FlRF+DETozrMms72N12oegi6wN/zIjI/KgBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8150

QW0gMTQuMDQuMjQgdW0gMTQ6NTggc2NocmllYiBKb3N1YSBNYXllcjoNCj4gQWRkIGRlc2NyaXB0
aW9uIGZvciB0aGUgU29saWRSdW4gQ045MTMxIFNvbGlkV0FOLCBiYXNlZCBvbiBDTjkxMzAgU29N
DQo+IHdpdGggYW4gZXh0cmEgY29tbXVuaWNhdGlvbiAgcHJvY2Vzc29yIG9uIHRoZSBjYXJyaWVy
IGJvYXJkLg0KPg0KPiBUaGlzIGJvYXJkIGRpZmZlcmVudGlhdGVzIGl0c2VsZiBmcm9tIENOOTEz
MCBDbGVhcmZvZyBieSBwcm92aWRpbmcNCj4gYWRkaXRpb25hbCBTb0MgbmF0aXZlIG5ldHdvcmsg
aW50ZXJmYWNlcyBhbmQgcGNpIGJ1c2VzOg0KPiAyeCAxMEdicHMgU0ZQKw0KPiA0eCAxR2JwcyBS
SjQ1DQo+IDF4IG1pbmlQQ0ktRQ0KPiAxeCBtLjIgYi1rZXkgd2l0aCBzYXRhLCB1c2ItMi4wIGFu
ZCB1c2ItMy4wDQo+IDF4IG0uMiBtLWtleSB3aXRoIHBjaWUgYW5kIHVzYi0yLjANCj4gMXggbS4y
IGIta2V5IHdpdGggcGNpZSwgdXNiLTIuMCwgdXNiLTMuMCBhbmQgMnggc2ltIHNsb3RzDQo+IDF4
IG1wY2llIHdpdGggcGNpZSBvbmx5DQo+IDJ4IHR5cGUtYSB1c2ItMi4wLzMuMA0KPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBKb3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT4NCj4gLS0tDQo+ICBh
cmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvTWFrZWZpbGUgICAgICAgICAgICAgICB8ICAgMSAr
DQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvY245MTMxLWNmLXNvbGlkd2FuLmR0cyB8
IDY1MyArKysrKysrKysrKysrKysrKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgNjU0IGluc2Vy
dGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9N
YWtlZmlsZSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9NYWtlZmlsZQ0KPiBpbmRleCAw
MTlmMjI1MWQ2OTYuLjE2ZjlkNzE1NmQ5ZiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290
L2R0cy9tYXJ2ZWxsL01ha2VmaWxlDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVs
bC9NYWtlZmlsZQ0KPiBAQCAtMzAsMyArMzAsNCBAQCBkdGItJChDT05GSUdfQVJDSF9NVkVCVSkg
Kz0gYWM1eC1yZC1jYXJyaWVyLWNuOTEzMS5kdGINCj4gIGR0Yi0kKENPTkZJR19BUkNIX01WRUJV
KSArPSBhYzUtOThkeDM1eHgtcmQuZHRiDQo+ICBkdGItJChDT05GSUdfQVJDSF9NVkVCVSkgKz0g
Y245MTMwLWNmLWJhc2UuZHRiDQo+ICBkdGItJChDT05GSUdfQVJDSF9NVkVCVSkgKz0gY245MTMw
LWNmLXByby5kdGINCj4gK2R0Yi0kKENPTkZJR19BUkNIX01WRUJVKSArPSBjbjkxMzEtY2Ytc29s
aWR3YW4uZHRiDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvY245
MTMxLWNmLXNvbGlkd2FuLmR0cyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWFydmVsbC9jbjkxMzEt
Y2Ytc29saWR3YW4uZHRzDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAw
MDAwMC4uYmE3ZGQ1NWFiZmI0DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvYXJjaC9hcm02NC9i
b290L2R0cy9tYXJ2ZWxsL2NuOTEzMS1jZi1zb2xpZHdhbi5kdHMNCj4gQEAgLTAsMCArMSw2NTMg
QEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKw0KPiArLyoNCj4gKyAq
IENvcHlyaWdodCAoQykgMjAyNCBKb3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT4NCj4g
KyAqDQo+ICsgKiBEVFMgZm9yIFNvbGlkUnVuIENOOTEzMCBDbGVhcmZvZyBCYXNlLg0KPiArICoN
Cj4gKyAqLw0KPiArDQo+ICsvZHRzLXYxLzsNCj4gKw0KPiArI2luY2x1ZGUgPGR0LWJpbmRpbmdz
L2lucHV0L2lucHV0Lmg+DQo+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3MvbGVkcy9jb21tb24uaD4N
Cj4gKw0KPiArI2luY2x1ZGUgImNuOTEzMC5kdHNpIg0KPiArI2luY2x1ZGUgImNuOTEzMC1zci1z
b20uZHRzaSINCj4gKw0KPiArLyoNCj4gKyAqIEluc3RhbnRpYXRlIHRoZSBleHRlcm5hbCBDUDEx
NQ0KPiArICovDQo+ICsNCj4gKyNkZWZpbmUgQ1AxMVhfTkFNRQkJY3AxDQo+ICsjZGVmaW5lIENQ
MTFYX0JBU0UJCWY0MDAwMDAwDQo+ICsjZGVmaW5lIENQMTFYX1BDSUV4X01FTV9CQVNFKGlmYWNl
KSAoMHhlMjAwMDAwMCArIChpZmFjZSAqIDB4MTAwMDAwMCkpDQo+ICsjZGVmaW5lIENQMTFYX1BD
SUV4X01FTV9TSVpFKGlmYWNlKSAweGYwMDAwMA0KPiArI2RlZmluZSBDUDExWF9QQ0lFMF9CQVNF
CWY0NjAwMDAwDQo+ICsjZGVmaW5lIENQMTFYX1BDSUUxX0JBU0UJZjQ2MjAwMDANCj4gKyNkZWZp
bmUgQ1AxMVhfUENJRTJfQkFTRQlmNDY0MDAwMA0KPiArDQo+ICsjaW5jbHVkZSAiYXJtYWRhLWNw
MTE1LmR0c2kiDQo+ICsNCj4gKyN1bmRlZiBDUDExWF9OQU1FDQo+ICsjdW5kZWYgQ1AxMVhfQkFT
RQ0KPiArI3VuZGVmIENQMTFYX1BDSUV4X01FTV9CQVNFDQo+ICsjdW5kZWYgQ1AxMVhfUENJRXhf
TUVNX1NJWkUNCj4gKyN1bmRlZiBDUDExWF9QQ0lFMF9CQVNFDQo+ICsjdW5kZWYgQ1AxMVhfUENJ
RTFfQkFTRQ0KPiArI3VuZGVmIENQMTFYX1BDSUUyX0JBU0UNCj4gKw0KVGhpcyBpcyBub3QgdmVy
eSBwcmV0dHksIGJ1dCBzaGFyZWQgYmV0d2VlbiBhbGwgQ045MzEzIGRlc2lnbnMuDQpDTjkxMzIg
ZGVzaWducyB3aWxsIGV2ZW4gaGF2ZSB0d28gb2YgdGhlc2Ugd2l0aCBkaWZmZXJlbnQgYWRkcmVz
c2VzLg0KDQpJcyB0aGlzIHdvcnRoIG1vdmluZyBpbnRvIGEgZHRzaT8NCg0KSSBzZWUgdHdvIG9w
dGlvbnMgdGhlbjoNCg0KMS4gaW50cm9kdWNlIGNuOTEzMS5kdHNpICh3aGljaCBpbmNsdWRlcyBj
bjkxMzAuZHRzaSkuDQoNCkJvYXJkcyB0aGVuIGNhbiBzaW1wbHkgaW5jbHVkZSBjbjkxMzEuZHRz
aSBhbmQgc2tpcCBjbjkxMzAuZHRzaQ0KDQoyLiBpbnRyb2R1Y2UgYSBzdGFuZGFsb25lIGNuOTEz
MC1jcDEuZHRzaSB3aGljaCBvbmx5IGluc3RhbnRpYXRlcyBjcDEsDQphbmQgZG9lcyBub3QgaW5j
bHVkZSBjbjkxMzAuZHRzaS4NCg0KQm9hcmRzIHNob3VsZCBpbmNsdWRlIGV2ZXJ5dGhpbmcgdGhl
eSBuZWVkLCBlLmcuDQpjbjkxMzAuZHRzaSArIGNuOTEzMC1jcDEuZHRzaSArIGNuOTEzMC1jcDIu
ZHRzaQ0KDQo=

