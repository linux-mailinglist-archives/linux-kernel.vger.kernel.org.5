Return-Path: <linux-kernel+bounces-83358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 019E7869491
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9ACF1C25E8D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA3C145B23;
	Tue, 27 Feb 2024 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kteenrMY"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2066.outbound.protection.outlook.com [40.107.104.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462DE1448D7;
	Tue, 27 Feb 2024 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042054; cv=fail; b=JP9ovUrgIXOVy5yNTPcYDcfR7y1z9/+GiQRoJvEiyen2AbuyALv1fjsnKWSPDEbeeUvIBV5+QfHfKyfk7pNCBtufhSZ8ox9mnUGWH0c5Rk1cviW+VL4+gu9sbAtUts7oC5ReIXeYzxaK7XqttR42foH6xOlx8VjaLibZ191i5Nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042054; c=relaxed/simple;
	bh=1qCwECso1QIP464Vl76VuryBaLGP3/ec554toW5tjfM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aXMFrzP2fWLjip9I5he1+IfFbU4mljV8d3tDGGsoL8+u/EVYJRcLu0Lv1GuJb7BQThn4a6JiSclBVvQxRNAv2vftTGTCXF7A32rZBojw1ffY8WcNlX5MV1RI/fgqirzp9FvRyZ0Yz2nO3B/761IOQ8iurVn/+nVeRmFT9ompkBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kteenrMY; arc=fail smtp.client-ip=40.107.104.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ixwt3/KtXg+iQBAfM0fLmxOMhpiggMr4NlAimh0IzupMlGHsRXDsuJZWEp7JDdMF4SwnhMjQrC54VdT89eE2rm8CH0c7l0DCFLDEcB3JLvigIkYgU/PNHqTPU/Xc/UkOAo+CkOsHHWmNSwoG90YZf3flOCNtRP31QLrYp7zr4rNaXCLfJmsLpZ8gi8Z65D90KbMWL0Lnw/hH+AImiRC0VhlTXqI2K5q5OgAa4RI5nFT5MRva3zmBBMgm5SpPBAkbZSYuIhlWWqUZv01SiD49r4LMVCDG6S4oD0UBKGnpUlRgO9lAvmvOrUTQfnjYA/5GRjUb+1mKtRNItbuBa+fIyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qCwECso1QIP464Vl76VuryBaLGP3/ec554toW5tjfM=;
 b=a0yyRS3XTVL9+w5PFYkyst7IlZJ/C7a5g088l5O+CEhbuXnTfVdR23wG/uaepSppeeQOMTrOWi+7Ikg9pf6/wts0YMIO9tIPs96eMcDiXFL8IYqoL8MLcwZ4/TwA4bGvwCj6SM0mBpLsQj9AFwrjJtddmw85wILwPZB4l41Ynl3QAasgW4yAqSOcswVISCJKfG3Jm1zEPlNWwDQX/9S/QAIIrT3P8JUaHDA6wE5KTMPz/zVnUaU4P6eAYekKdVzuT7HNGJeL9jgAuEKHVrJTYxu6H2UlWqnHLrjbLdWIOs9d9EkTjXftYqnSFZRhcP6HvSWfNP/YNzUOZR9ITAveBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qCwECso1QIP464Vl76VuryBaLGP3/ec554toW5tjfM=;
 b=kteenrMYMMl8DLAiWGB6k0zAlcih2aRGgumStOhLJqRWxGdbp3ipyqR640TWK+WOmuFMriNeWAI8kAp+0wLRoQyP9eSy5L2k21NA+CAlETHEmhGZeel6ZTefrc2EDlcWnAyFMVEbS0J5Qg7AGii+2h+69ELYQpSb70NSKdc62C0=
Received: from DB9PR04MB8185.eurprd04.prod.outlook.com (2603:10a6:10:240::22)
 by PAXPR04MB8175.eurprd04.prod.outlook.com (2603:10a6:102:1bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 13:54:08 +0000
Received: from DB9PR04MB8185.eurprd04.prod.outlook.com
 ([fe80::c528:7058:f179:f2ba]) by DB9PR04MB8185.eurprd04.prod.outlook.com
 ([fe80::c528:7058:f179:f2ba%7]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 13:54:08 +0000
From: "Madalin Bucur (OSS)" <madalin.bucur@oss.nxp.com>
To: Markus Elfring <Markus.Elfring@web.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Sean Anderson <sean.anderson@seco.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: fman: Use common error handling code in dtsec_init()
Thread-Topic: [PATCH] net: fman: Use common error handling code in
 dtsec_init()
Thread-Index: AQHaaX74zHQIr66ZLk2hORJ8dUnhWrEeNX1Q
Date: Tue, 27 Feb 2024 13:54:08 +0000
Message-ID:
 <DB9PR04MB8185F2E41D1BC2C590B3E5B3EC592@DB9PR04MB8185.eurprd04.prod.outlook.com>
References: <9b879c8d-4c28-4748-acf6-18dc69d8ebdf@web.de>
In-Reply-To: <9b879c8d-4c28-4748-acf6-18dc69d8ebdf@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8185:EE_|PAXPR04MB8175:EE_
x-ms-office365-filtering-correlation-id: 64545c96-5825-4af8-6fa6-08dc379b91c4
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Q6XIVGH++bUhaUdMd0gfUE59ynHj2COL4jix+YRepJDHyBhUHaL1OtXyGPnf3ed7kh5LCuZrkIdFv5B/6xS3vTPL93q5cMyb407Pi46CIfWAkDTnN84xUGxGJfDhnS049b+kmJi8c1kmyLycCw+SHSKIwsVrJB1k+lM3IXWJcHOQ9gVvjyAEx5C5b1A9jW2/RfOWWvqYF2ux5yi3shxISJFcImfe+LQcFBPhAuQoJEt3Q+HPfNTB7++mOFomC3evKMvPM6vQP786LaVPwlMiNxseyVTWn6to2e6lSwBl4yYDICB9vmKPcdYtjhdEQ8nbnEUy8xkFjICk8D47uNLe8UwU4havqy6UGIGqII5L/lZLnDn98eyNsAFEiUVq+FOEytZg3bOvCGXiqlgHGw7XykQE4T4wzEweeyUOm4qv75rQGDF+0s94juZbONyA4GRcwVYIZ+PLo2RC/JCP78dqI4X5delv6qvUuaGI6DfieOpXPD9G7eU8UnT79IdRv/KfMoo2DF9meslrY6eqZi3S3z2cO/6phiYZtOo3cf935gY44OlA9r9cJoTnhYizgzS3V0wA6CYhseiA2XXkd/3SdnQix7YrYskFA2aqmn8D/g/9hzH3GXbZHtKBeVcvAbEPwkotVCcCbnR4o8sRKqLBLgYvavPvmBFlRuKTpmdcGNKnoG4ybzXljLygObt0R1Q5Z+LWA4EPU3/QysJTVa37GBWO7ZxsL0zHI5PJPcdRJH8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TUFQUlJXbE5zd1ZLcjNJY0R3WFRrMVRKaHI4dVhMOEdOQVRSamFZVkF2a0NN?=
 =?utf-8?B?VG9NWEdDdlNjOEdUR3Bwa1ZvM1IvaWY4U3ptUjhxU3c2M2t6Rll1T3JDMGxR?=
 =?utf-8?B?TEF3Q3c2RjdRVEhVU0JBYjVYTk1kejlFMGZqWktlK1pubmtkTVlPUlBlK1pW?=
 =?utf-8?B?aG5tcjlIZGk1SDZEZW9xYWdqdHB1cGFjb2JMMHgyMDlBRldrSTI2VXhPS2lB?=
 =?utf-8?B?czdXODFQQ3VFS2lCMURLbFRpcys0YmpEQkpWS09NeVBvS21YUkt1U2taOVF0?=
 =?utf-8?B?S0dBZHNjYXl1L2NiZ0hCd2RDa0haVG1RMDcyWnVGWG8vL1FLTUZNRllrRVJm?=
 =?utf-8?B?b3BtZWo5S0hZeTZlellCazJkRjZpcWwrUE9ZTERkb3FNUEY0Ri84dFEzZU1J?=
 =?utf-8?B?c3cxdGQ5a0w2d0x6VTV4ZXBYS29uZ3A2RE84c1ovQ1hybzZHVlVvSzk5ajhx?=
 =?utf-8?B?Ym4wN3pjdjFILzZYMzcwUDRoUXhlK1czSi9vWnFqMkdSdXRSdFhPRjdqQThj?=
 =?utf-8?B?S0ozV0FZVnM5MDVxV3BXQXcyL3M0b05NM0c4WWh1V0JYNU0xTHBDQ3VYNXZp?=
 =?utf-8?B?Q1BnTFhsYVJTajhOWDZQWUNFOSs5T0l1d1o0L3o1RGhra0pvSk4xSmd6dEt5?=
 =?utf-8?B?L1RzQ01qY2pic0RkdnNMdXV3OFBIM0pUZTBrOWY3QUpqa1lnQ2tVbHBCOEtP?=
 =?utf-8?B?Sy9BbmxOZTF5aTNvWGpIQWJCcXdSbjBRbXR5SUE2SDM4K0doMWFrSG1ocXRS?=
 =?utf-8?B?d29QUXJFRTIwYU5oK0hPdmMvWXAzd1FYSmpFcnFrRzZFd3lUU20rVXh4ZU5Y?=
 =?utf-8?B?Tlg2Mzkxd05ZSGx5MzRSdjI3TW9QWmJRN3FDSjdOTU5lRWttM1pnenJGMHdJ?=
 =?utf-8?B?d1lCS2dnVWdLb0R6MVpWTWEwZnJRcFBNcTM4dHRlOVNIRVM5QVdaYjFPSHIy?=
 =?utf-8?B?eEo4R2ViaHZEUllHdE56eEtmSlFvME9zWU13dy96L2JZaHQ1NUtiMjVob0dW?=
 =?utf-8?B?RHRIY241Si8wTlpCN1hYNFp0U05adG9DbzQvNDlZMHpxL1dLSkNIZlBmZ2dx?=
 =?utf-8?B?Ri9YRlB1UWNxbnVXVVF4Wm5MTFBzQlNvQUJXdERtOTRzU3hSR2d4ZW9nYmU3?=
 =?utf-8?B?SHBwYTFwZnVoUnEwdHEvaGl6QVhCYzdKZUVycjJDKzJUcjBFSVAybmVXNmN6?=
 =?utf-8?B?aURXcHVzZURZSmJCWTRjMWZxaXlQWWZ2elZwMGNQOTFzdnp4aWhIeldjNUp2?=
 =?utf-8?B?Mm5mSjNJYXpVcWxjOWxjdXh6YkNRNUZZVWhoaHRvK2hNSlRkclBwWGg4Qmwv?=
 =?utf-8?B?ZFl1YmZVT0o1aUxZb3JxRGZvK240TTlGNWlOZklYT3ByUW9JR0dpUWR3VjlZ?=
 =?utf-8?B?dUVnQXVaQjMxcTRUamx4d2VNZFBFcWlFd3J3Sks2OUUxcDRtNHV0TUFhdnV2?=
 =?utf-8?B?aUluRyt5YXo1UFV2UU9QUTR4cmRvVVUvN3lPcmdJVFVxT2pZbVFYTUl6WUph?=
 =?utf-8?B?OWhkRUxTUGJpSkxaYWYya0FTV1ZzamdFOG1QQ0NSaGYySFVuc1FjWVh5eGN4?=
 =?utf-8?B?dUxoOHhIQ0hnVEhQc0RpVFZRZVZmVVNuVUFwLzVDa2I2NHB2bWc2aFEwU01z?=
 =?utf-8?B?UHZpYjlVL3pLOFBhazRzbHBNUDIxTG5CK3hOamduKzVhUUxzUlhXaWVrdnZr?=
 =?utf-8?B?c2txMnlBTUh1ZVNSeG92UzMwMmFDb3ZvQmRKWElrOWdtc0xnL0tmVlBkeGVq?=
 =?utf-8?B?b25pT3I0SlZBdGdOQU9INGdOanR6YjhSVDZmQVRsQmhxa1FhMUsyaThad2dR?=
 =?utf-8?B?L2YzTmNySG1WRnFxQ0NhMGhJZGd5cVlpMHFIc0Jrbk1KekRUNWt1Smp2NUUx?=
 =?utf-8?B?K0hPYXJuMndqWVBSVCtFSnYvRktwdGJSQUdYU1kyam90cHEyMkE4UU5KMytK?=
 =?utf-8?B?d0prWGh2Y2gyVlJsYi9uM2JSRlhtcVJIbTZSN2JKc3pVeHZzblFDM3k3YkFk?=
 =?utf-8?B?dEprM0wvNllQek5hL0FJSjd2cVJMTFpYdWVLbWpvcGhkQnM2bDIzVlNISm9L?=
 =?utf-8?B?QXBuSFFBRzZ2dmpWc0JZQkxrSkxmcTloZmkrTG0vell0NGRsL3VibWlocDh3?=
 =?utf-8?Q?Ueyv2wpj3SiYVUAXn2j4kCcFz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64545c96-5825-4af8-6fa6-08dc379b91c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 13:54:08.4204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WNJFtp2IdLcBvDWw73IaIKTBlWO9egeCoDykJRbqyUe0tH7qDWe99haaDOfuXjB+87ylEOx+V0GyVNadkoLDMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8175

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYXJrdXMgRWxmcmluZyA8TWFy
a3VzLkVsZnJpbmdAd2ViLmRlPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAyNywgMjAyNCAz
OjE1IFBNDQo+IFRvOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBrZXJuZWwtamFuaXRvcnNAdmdl
ci5rZXJuZWwub3JnOyBEYXZpZCBTLiBNaWxsZXINCj4gPGRhdmVtQGRhdmVtbG9mdC5uZXQ+OyBF
cmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+OyBKYWt1Yg0KPiBLaWNpbnNraSA8a3Vi
YUBrZXJuZWwub3JnPjsgTWFkYWxpbiBCdWN1ciA8bWFkYWxpbi5idWN1ckBueHAuY29tPjsgUGFv
bG8NCj4gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgU2VhbiBBbmRlcnNvbiA8c2Vhbi5hbmRl
cnNvbkBzZWNvLmNvbT4NCj4gQ2M6IExLTUwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+
DQo+IFN1YmplY3Q6IFtQQVRDSF0gbmV0OiBmbWFuOiBVc2UgY29tbW9uIGVycm9yIGhhbmRsaW5n
IGNvZGUgaW4gZHRzZWNfaW5pdCgpDQo+IA0KPiBGcm9tOiBNYXJrdXMgRWxmcmluZyA8ZWxmcmlu
Z0B1c2Vycy5zb3VyY2Vmb3JnZS5uZXQ+DQo+IERhdGU6IFR1ZSwgMjcgRmViIDIwMjQgMTQ6MDU6
MjUgKzAxMDANCj4gDQo+IEFkanVzdCBqdW1wIHRhcmdldHMgc28gdGhhdCBhIGJpdCBvZiBleGNl
cHRpb24gaGFuZGxpbmcgY2FuIGJlIGJldHRlcg0KPiByZXVzZWQgYXQgdGhlIGVuZCBvZiB0aGlz
IGZ1bmN0aW9uIGltcGxlbWVudGF0aW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFya3VzIEVs
ZnJpbmcgPGVsZnJpbmdAdXNlcnMuc291cmNlZm9yZ2UubmV0Pg0KPiAtLS0NCj4gIC4uLi9uZXQv
ZXRoZXJuZXQvZnJlZXNjYWxlL2ZtYW4vZm1hbl9kdHNlYy5jICB8IDE5ICsrKysrKysrKysrLS0t
LS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mbWFu
L2ZtYW5fZHRzZWMuYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mbWFuL2Zt
YW5fZHRzZWMuYw0KPiBpbmRleCAzMDg4ZGE3YWRmMGYuLjFkZTIyNDAwZmQ4OSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZtYW4vZm1hbl9kdHNlYy5jDQo+
ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2FsZS9mbWFuL2ZtYW5fZHRzZWMuYw0K
PiBAQCAtMTI3OSw5ICsxMjc5LDggQEAgc3RhdGljIGludCBkdHNlY19pbml0KHN0cnVjdCBmbWFu
X21hYyAqZHRzZWMpDQo+ICAJCSAgIGR0c2VjLT5tYXhfc3BlZWQsIGR0c2VjLT5hZGRyLCBkdHNl
Yy0+ZXhjZXB0aW9ucywNCj4gIAkJICAgZHRzZWMtPnRiaWRldi0+YWRkcik7DQo+ICAJaWYgKGVy
cikgew0KPiAtCQlmcmVlX2luaXRfcmVzb3VyY2VzKGR0c2VjKTsNCj4gIAkJcHJfZXJyKCJEVFNF
QyB2ZXJzaW9uIGRvZXNuJ3Qgc3VwcG9ydCB0aGlzIGkvZiBtb2RlXG4iKTsNCj4gLQkJcmV0dXJu
IGVycjsNCj4gKwkJZ290byBmcmVlX3Jlc291cmNlczsNCj4gIAl9DQo+IA0KPiAgCS8qIENvbmZp
Z3VyZSB0aGUgVEJJIFBIWSBDb250cm9sIFJlZ2lzdGVyICovDQo+IEBAIC0xMjk2LDIzICsxMjk1
LDIxIEBAIHN0YXRpYyBpbnQgZHRzZWNfaW5pdChzdHJ1Y3QgZm1hbl9tYWMgKmR0c2VjKQ0KPiAg
CWVyciA9IGZtYW5fc2V0X21hY19tYXhfZnJhbWUoZHRzZWMtPmZtLCBkdHNlYy0+bWFjX2lkLA0K
PiBtYXhfZnJtX2xuKTsNCj4gIAlpZiAoZXJyKSB7DQo+ICAJCXByX2VycigiU2V0dGluZyBtYXgg
ZnJhbWUgbGVuZ3RoIGZhaWxlZFxuIik7DQo+IC0JCWZyZWVfaW5pdF9yZXNvdXJjZXMoZHRzZWMp
Ow0KPiAtCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwkJZXJyID0gLUVJTlZBTDsNCj4gKwkJZ290byBm
cmVlX3Jlc291cmNlczsNCj4gIAl9DQo+IA0KPiAgCWR0c2VjLT5tdWx0aWNhc3RfYWRkcl9oYXNo
ID0NCj4gIAlhbGxvY19oYXNoX3RhYmxlKEVYVEVOREVEX0hBU0hfVEFCTEVfU0laRSk7DQo+ICAJ
aWYgKCFkdHNlYy0+bXVsdGljYXN0X2FkZHJfaGFzaCkgew0KPiAtCQlmcmVlX2luaXRfcmVzb3Vy
Y2VzKGR0c2VjKTsNCj4gIAkJcHJfZXJyKCJNQyBoYXNoIHRhYmxlIGlzIGZhaWxlZFxuIik7DQo+
IC0JCXJldHVybiAtRU5PTUVNOw0KPiArCQlnb3RvIGVfbm9tZW07DQo+ICAJfQ0KPiANCj4gIAlk
dHNlYy0+dW5pY2FzdF9hZGRyX2hhc2ggPQ0KPiBhbGxvY19oYXNoX3RhYmxlKERUU0VDX0hBU0hf
VEFCTEVfU0laRSk7DQo+ICAJaWYgKCFkdHNlYy0+dW5pY2FzdF9hZGRyX2hhc2gpIHsNCj4gLQkJ
ZnJlZV9pbml0X3Jlc291cmNlcyhkdHNlYyk7DQo+ICAJCXByX2VycigiVUMgaGFzaCB0YWJsZSBp
cyBmYWlsZWRcbiIpOw0KPiAtCQlyZXR1cm4gLUVOT01FTTsNCj4gKwkJZ290byBlX25vbWVtOw0K
PiAgCX0NCj4gDQo+ICAJLyogcmVnaXN0ZXIgZXJyIGludHIgaGFuZGxlciBmb3IgZHRzZWMgdG8g
RlBNIChlcnIpICovDQo+IEBAIC0xMzI2LDYgKzEzMjMsMTIgQEAgc3RhdGljIGludCBkdHNlY19p
bml0KHN0cnVjdCBmbWFuX21hYyAqZHRzZWMpDQo+ICAJZHRzZWMtPmR0c2VjX2Rydl9wYXJhbSA9
IE5VTEw7DQo+IA0KPiAgCXJldHVybiAwOw0KPiArDQo+ICtlX25vbWVtOg0KPiArCWVyciA9IC1F
Tk9NRU07DQo+ICtmcmVlX3Jlc291cmNlczoNCj4gKwlmcmVlX2luaXRfcmVzb3VyY2VzKGR0c2Vj
KTsNCj4gKwlyZXR1cm4gZXJyOw0KPiAgfQ0KPiANCj4gIHN0YXRpYyBpbnQgZHRzZWNfZnJlZShz
dHJ1Y3QgZm1hbl9tYWMgKmR0c2VjKQ0KPiAtLQ0KPiAyLjQzLjINCg0KTG9va3MgZ29vZA0KDQpB
Y2tlZC1ieTogTWFkYWxpbiBCdWN1ciA8bWFkYWxpbi5idWN1ckBvc3MubnhwLmNvbT4NCg0KDQo=

