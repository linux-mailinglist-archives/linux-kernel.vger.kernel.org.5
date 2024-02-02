Return-Path: <linux-kernel+bounces-50052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757C88473BE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A4731C23788
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7865D1474C8;
	Fri,  2 Feb 2024 15:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="a76l9Gdp"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2115.outbound.protection.outlook.com [40.107.21.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFBE1474C6;
	Fri,  2 Feb 2024 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889241; cv=fail; b=lR+ud28fXU7QAf64oc+5bQWspIGs52kkjzPLNdj/nrf3rGE3EwCDakVZ8vYzMzE1EBRnKdRhVpuosW2yS04jqu7SdbBrgDBMvfzRiq4ks2hBXrj6xP3iB4aPGDORRjd6HffgDWM4323UxHaX7ciKmjDMxeNQhzQzpOK1J/EqKoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889241; c=relaxed/simple;
	bh=oNttyKB3VG1uIkchSnei2VdIFCCaCaD27QJaxb+Ii+c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ErfdI914b3hhRgwjY9pkIpjU4+yU2nOzoBEtJRDEerVN22XULhq1a4M/EAlBB+7e2l7afPr04edb0Pf0VkGYQ3zBhGLZK3LKGGIck+kdTO7lJBR+RKq/wCr53rKikI9XjH3CyNL90qx6SaH0hdo7T3G+l1aR00n5WHEK6Y924kU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=a76l9Gdp; arc=fail smtp.client-ip=40.107.21.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NziVnuBYgF91MjAwXMgYAyUBLIGLZot2tYmSue/PDyeuR23MWVQy1wD5m5J6xTOpxiPPd7NeQS3zlalwrENZH1RU7B+76kTOedHXX1AM4/QazLXy4jYMouhvGmvh6aGlsJ8WMaa2pC1jx2/uAVNLzOgMqaIAUPFMKcAUhWlB4x/PMcxSpBpjbaLUSq3quewsj63i1if598HKd93K/FhBtwltOD1EV3ceJg8z/0nJIsRI4UELd/k3DdoAmq2sFaUUtZ4K0m9VUl0FGqbnQ0ncRZ9YVjQ+4ZiHWd5B68DW0QtZiz0N33lqbmcMjE/hcvJ/HSv6jGdEgJjC+MKqBFIczg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNttyKB3VG1uIkchSnei2VdIFCCaCaD27QJaxb+Ii+c=;
 b=FdCI2RYxWluBd3HKzACrDq2ZkKc+vaMDL/S81yZqnbogS0GaE5zIR+lIAyP3OfRWRjAQLRpGg1rNc+/RY4ycl1OIBtIuF2Z2V7EActnbI5RnYd/0N5thHwHRifZUM2cGn0tmFLzzzhz2gpbg+prARd3WXfEApv5+mnVF3b4h0cfN7cqLW8QK9HLrCLtUyRh1lz876quGPR0tHIEydDE2+fMY+BkA3TN9P107v/KXk62b+vNw/f+ZvfBmPfHOjFdZJ/OaHVrtjQIttlAGiGuE6LwUcB3q0dGedThgcDpIhSNB0zrU7tqKW2QZvwINlff2Oe7sNrNiyAQlsZTKkFY+Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNttyKB3VG1uIkchSnei2VdIFCCaCaD27QJaxb+Ii+c=;
 b=a76l9Gdp5BDie3b8yLiEJNuS7RKihgbm/RNRlsQ/WA/u2Z1pooRvNSn9yYm2pgvVj6BBmN+ChQNSw1uPBqP1tqwMirkoszD93kPgePbuuyo0M4K4PTWR3mWZfOpdsvEJEf9ys7DheppsrBoC5o/lQDyWQwtncuDav3nHnjEX5s0=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU2PR04MB9212.eurprd04.prod.outlook.com (2603:10a6:10:2fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 15:53:55 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 15:53:55 +0000
From: Josua Mayer <josua@solid-run.com>
To: Rob Herring <robh@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>, Vignesh Raghavendra
	<vigneshr@ti.com>, Conor Dooley <conor+dt@kernel.org>, Alessandro Zummo
	<a.zummo@towertech.it>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Nishanth Menon <nm@ti.com>, Yazan Shhady
	<yazan.shhady@solid-run.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: rtc: abx80x: convert to yaml
Thread-Topic: [PATCH v3 2/5] dt-bindings: rtc: abx80x: convert to yaml
Thread-Index: AQHaVeM92J2ig1PZB0Cj98jgucAxcrD3LvCAgAAFVQA=
Date: Fri, 2 Feb 2024 15:53:55 +0000
Message-ID: <6378c7a9-37b8-4ebb-84dd-547f123d3b4d@solid-run.com>
References: <20240202-add-am64-som-v3-0-2f44023d50e9@solid-run.com>
 <20240202-add-am64-som-v3-2-2f44023d50e9@solid-run.com>
 <170688808822.43802.6252377513690551092.robh@kernel.org>
In-Reply-To: <170688808822.43802.6252377513690551092.robh@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|DU2PR04MB9212:EE_
x-ms-office365-filtering-correlation-id: b6959ca1-6ed8-466f-3989-08dc24072905
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5SfBp/Em9GIKXkRwjzogAJFc5MhImGoTgbDCu4E8L2syAxB4r/+fL+R/KhPVyliZd9i3uJoWcc8i5Nfx4lmpoeBPsC9AbbByB7n8SAuPS5F8T5UpXPzmaRvSeK7/2qOReOObgtUEpuM8rZVLU8eJ0Xk+XKv30croNKoehSwawvS/S745bArq79NHIVeke/unGO/8xYalNYQgW3thw0VS00RB0rz9RHLDmKO7a9ydwe4tyaFJgzBNxdV24uSJTVhcyqBeUdab5DA2FqamYNQTS8UlCv6lLppBztgImQTd73KOuYZw/83XAeoIIAUH3aYzRU9atsg04wP1TilnxCmPApwANvFIjgMfZrMUFUn8TS49BVZK9LVDS1yWanRRGl+EBFRA/L7g7JW3E8FipsAlYYhaUmmHlh4j/gPm8RYm3DH2/Jl3j61gIR4C1j8uThDQ8hcF8xA5Z+7BAO3DP1RNTJJggO6I8FcWt2rYciRBPEr/lJcFxbFJD8bgD7jVjOpZGKtAjAh2dqcwXjR7Bfvkg5mLQCy5aY95b3vtywekSqyFiygvIvHfnImGiQ79Qb+xEv6HvMtTiiKakqgFcITQJAAkxqrAvDmemBtc9Reo2ulyGgCF/+EJogGrg0eSQbtLCh/EGaAZ/9NzjGuSjNWXPlCpdYP0uhrSNJIBqDup3PTe8PJx7cecf3iS3iSf1D/A
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(136003)(376002)(346002)(366004)(396003)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(31686004)(83380400001)(41300700001)(86362001)(36756003)(31696002)(38070700009)(122000001)(6512007)(38100700002)(26005)(2616005)(66446008)(76116006)(478600001)(6506007)(91956017)(2906002)(54906003)(66946007)(64756008)(316002)(66476007)(66556008)(6486002)(7416002)(8676002)(71200400001)(5660300002)(8936002)(6916009)(4326008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TnYzU2dpVzFQZHE3SGdoS1cyUFgwRUhSeFZyS0NsSDY0dXp5cG5RNHA4MFdQ?=
 =?utf-8?B?ZktQclAwSWdyQXB6T3VxSzdnZlAzWjNjUXJkUEhLOWJjL2Z5N0phWlVTV3RZ?=
 =?utf-8?B?Vk5lQ2FFMFdEWnlyc3B3UGhCOGJycjhCZW5hNWs1K3hTR2NuUkdZQ0xrZkJi?=
 =?utf-8?B?QUs5cjMrWVU5NFM4N3d4ZDNzQ3cwRHljNEdWZGxWb0VwaEtNaXpNSXIvUFpa?=
 =?utf-8?B?Ym91MEJZejNES2dFQ1lLaFc2aGJadGt6eWpPT0NIS3FPZHdsVFUvRE5sSHhF?=
 =?utf-8?B?RGJIWFhxaXgzTGVyRHAvcWRid0N4dWxBaGpsTisrazlTRDM5Yi90Z1N5UXVM?=
 =?utf-8?B?WmNCQWpoV1E3dGxnU01nR0VITmhzbDQwN1N4cTcyMWRjQmNyK0Z2SFQ4QW9J?=
 =?utf-8?B?bFIvSUppNG9GTEFZUk5YcHU0ZzhydVRJbVl1alpORVorRjFYTDhnbGVWc2M3?=
 =?utf-8?B?Tk9VSi9RSHlnOWpuV3dTcG5ERmZqOGFlYTZ2d044K1lDU3JNeFdhajlZWnBX?=
 =?utf-8?B?Rm5GUmdBK0tQTGRkZjhxT2h6NStCTU1kRnpVSk1qZHJyUmNJcW5mdnNrK0JY?=
 =?utf-8?B?YVkwUnZUcms5THdEUWowQmp6RjR1ZHdaY3lyL0NRZkkxbmM4dlhsTko2UDhF?=
 =?utf-8?B?M1ZQK0ZEOG9kaUlIZ3g2Tmt0K1U1WUhhdDdsbzZENE9NMG82bTJqM1dmQ2FN?=
 =?utf-8?B?aDNHV0lkSmdXcitNbGFFWHBaRjMrb0p1cERNbEhsNUhqejFyNTRkN2F4aFFG?=
 =?utf-8?B?bmFtQzBaSlpJN2tDeXNsWFpnbG8zQi8yYUc1eXRoRjAvdy9wNDhyZFA4OU1C?=
 =?utf-8?B?cEZHSlJUaXJWa3pXdlFxMjVsaDNzS2dKbHl1am1rODVmaVpYWGcwTTQ0WWo5?=
 =?utf-8?B?Vng4YlVNM3g2a2JUMGY1WVMzRTYvT2tNR3ZsV01ld05UU0hzdFZ4OWdYdis2?=
 =?utf-8?B?RjRwUHo2UXY0cjYrSFFCZzNGL1ppVXlTYi82SEdzV3RPUFF1Q05tcWRNSnps?=
 =?utf-8?B?RDNOSTRWTDhsWHZMV0pkY0JKMUVucU1kcmc1ZXVUMUZTNHVnWXkwb1dpcS9K?=
 =?utf-8?B?VGNKL3k4R1FTeVY0T216cnl0Q2VoVStxQzJ6V1M3MGRTNXF2aTlFaERjSy84?=
 =?utf-8?B?WVhCOG5ta1o0eWFQc3Mwck1DWlYrV0JsK01NRnZyTTFPR1lnOUxNSnRKNHRU?=
 =?utf-8?B?NkpsSHdoM21GQm1TdGlXYXY0K3d4U1o2Z0MvRnZkZGIwaUpJQnk4MkR0alAy?=
 =?utf-8?B?eHlSdFdqY0ZNNzNZTjRUSSt5ZVQzYmwrcW5SclB5cHg5Sy9lQVBxM3UrMm1F?=
 =?utf-8?B?anN3cm8zamVmakZHbXJYMVJaZFhXdTl1Y0g5b0ZoR0NTemZTQ0VNUnI1SVdS?=
 =?utf-8?B?TlBiUWdsU0NpZzdrS3Q4QVFwWUJIM25SNk56WEwya2pwdTJHUGZGMFdGOWhY?=
 =?utf-8?B?OHgxL3RmcE8rbDJLREMyNXJjK1NNUFRxOU5HK1U5SlE5VGNFOGo4c3VKUzF3?=
 =?utf-8?B?NGI3MkUxeEsvVEVJclo2UUgrN3dYQUNvK2lXV00xSlVEYzRVWTRpbC93dlJL?=
 =?utf-8?B?THg2U2FDaEE2TjYzU0J5MnUvTUlwYngyVTdoaGdJbVFOcjJIZ3llbTdQbFk3?=
 =?utf-8?B?T2Q2R3hhTTV2WXo3dHIzNmZBZHo2SDlsbTVSTEc3alBWYVR1QmV6Q1VlQzhI?=
 =?utf-8?B?LzVsR2lmVm15QWg4b2d0bTF4UytTSmE4d3pUR1FpelFaOXRHN1RUYVdIVGlV?=
 =?utf-8?B?RWZCOTRQV3dpNjFrZWsvSGV4eFZLK1dXczBqOEp6Z0phMnBxYllTTGlQMW90?=
 =?utf-8?B?S0Q3Sy9JQWYxdDh2VjM0aXRaeTkxNm0yVXdEZUdVZEZQUHYzUGVIeGpFWGVy?=
 =?utf-8?B?dEVUY1AycXAyK2ZqdHJDT2RwN3UwdEYyaUh5U3M4elVGTDFVL2ZkR0d6eDJs?=
 =?utf-8?B?U0RCNU1pVzR2b0lLNlZJdVRwVzh4UlB5K05WUXJWdHFncDQ0aGtmbTdRUjRa?=
 =?utf-8?B?d0tLL2VLM2YvTXNIVXJxTjlyT0owWUYxNldkakxSWlpSWkx2U1pmdG5pSXA4?=
 =?utf-8?B?VkRSTXhtTlVMYlMyR0N2bWhuTlU5bStFVmFOT1lENGh6VkI4ci9XNEZFS3Ev?=
 =?utf-8?Q?2PDv7SVoAiqkx/YLWzHZTtCpx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC1DC02F5710EE4FAAF833A19FEFC979@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b6959ca1-6ed8-466f-3989-08dc24072905
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 15:53:55.0838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D8RkDIu9cfq/ku86b8DR3jTzajrub5MaYRc1rSQoyzLbadZJgiGXKau9MciukxgqnbT8VSBnLeHRsiWXGQqcsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9212

QW0gMDIuMDIuMjQgdW0gMTY6MzQgc2NocmllYiBSb2IgSGVycmluZzoNCj4gT24gRnJpLCAwMiBG
ZWIgMjAyNCAxNToyMjoxOCArMDEwMCwgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+PiBDb252ZXJ0IHRo
ZSBhYnJhY29uIGFieDgweCBydGMgdGV4dCBiaW5kaW5ncyB0byBkdC1zY2hlbWEgZm9ybWF0Lg0K
Pj4NCj4+IEluIGFkZGl0aW9uIHRvIHRoZSB0ZXh0IGRlc2NyaXB0aW9uIHJlZmVyZW5jZSBnZW5l
cmljIGludGVycnVwdHMNCj4+IHByb3BlcnRpZXMgYW5kIGFkZCBhbiBleGFtcGxlLg0KPj4NCj4+
IFNpZ25lZC1vZmYtYnk6IEpvc3VhIE1heWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPg0KPj4gLS0t
DQo+PiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcnRjL2FicmFjb24sYWJ4ODB4LnR4dCAgICAg
fCAzMSAtLS0tLS0tLS0tDQo+PiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcnRjL2FicmFjb24s
YWJ4ODB4LnlhbWwgICAgfCA3MiArKysrKysrKysrKysrKysrKysrKysrDQo+PiAgMiBmaWxlcyBj
aGFuZ2VkLCA3MiBpbnNlcnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkNCj4+DQo+IE15IGJvdCBm
b3VuZCBlcnJvcnMgcnVubmluZyAnbWFrZSBEVF9DSEVDS0VSX0ZMQUdTPS1tIGR0X2JpbmRpbmdf
Y2hlY2snDQo+IG9uIHlvdXIgcGF0Y2ggKERUX0NIRUNLRVJfRkxBR1MgaXMgbmV3IGluIHY1LjEz
KToNCj4NCj4geWFtbGxpbnQgd2FybmluZ3MvZXJyb3JzOg0KPg0KPiBkdHNjaGVtYS9kdGMgd2Fy
bmluZ3MvZXJyb3JzOg0KPiBFcnJvcjogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3J0Yy9hYnJhY29uLGFieDgweC5leGFtcGxlLmR0czozMC4zMC0zMSBzeW50YXggZXJyb3INCkZp
eGVkIGluIHY0IGJ5IHJlZmVyZW5jaW5nICJyZWFsIiBmYWtlX2ludGMwIHJhdGhlciB0aGFuIGZp
Y3RpdGlvdXMgZ3BpbzANCj4gRkFUQUwgRVJST1I6IFVuYWJsZSB0byBwYXJzZSBpbnB1dCB0cmVl
DQo+IG1ha2VbMl06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5saWI6NDE5OiBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcnRjL2FicmFjb24sYWJ4ODB4LmV4YW1wbGUuZHRiXSBFcnJv
ciAxDQo+IG1ha2VbMl06ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uDQo+IG1h
a2VbMV06ICoqKiBbL2J1aWxkcy9yb2JoZXJyaW5nL2R0LXJldmlldy1jaS9saW51eC9NYWtlZmls
ZToxNDI4OiBkdF9iaW5kaW5nX2NoZWNrXSBFcnJvciAyDQo+IG1ha2U6ICoqKiBbTWFrZWZpbGU6
MjQwOiBfX3N1Yi1tYWtlXSBFcnJvciAyDQo=

