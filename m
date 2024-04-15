Return-Path: <linux-kernel+bounces-144718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F4C8A49A7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68C71C23347
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E1C2E620;
	Mon, 15 Apr 2024 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="p/igsuF3"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2137.outbound.protection.outlook.com [40.107.7.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2154D2E413;
	Mon, 15 Apr 2024 08:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168088; cv=fail; b=vA7HcJDyebVnqr9ly6XKnszehy15UinMBONsWFPZosPfLwk+XcNOILfKXtAheilD/E+IK5usHzIVCvjXMF5lG3liJ9dimI9r8SkwJdVIPS5BFWCbnVehUGp3eZs5YCQOF1x/TSgf0Kcoc537bU6kEkOCfUBUbqMQwTaTcMWcVYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168088; c=relaxed/simple;
	bh=pw961RvUl15Tu1LK95H9ygZRyOyxpBNCGHSRFavRpV0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e4N1pOdQQrQxYyaui1JKOLoR6AwHeZFa1ikQn5pl/agXLwWsnJKH50FOeJql74TvM79kGLEj4NdLRbv8GPJFFnt/XimFdorTd0FUEQX7EkPuhwneXVnkiQv31Zohv/KQxIxk7rJ4Wjicv7iRPHu150dcbDhhCOsQdmuQ1ltEwvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=p/igsuF3; arc=fail smtp.client-ip=40.107.7.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kp4J8JQW/WTNPP48p9q+fV/JWB9Xlnj/AmTS9MgUpfEaGiQ4d4RqhnuuJEsy1lItFUSP0I8o5xdODt0N7B8pJM31XP+1FHqbBl6tJXdq2rayE7RVnO+a13wdFE6pyqC68/vXFoR6cACiP8blzBPxH5hozM4FRthPa6983+v7QBOcM3OzMTouV+7EaZ90HhxtuGAVjh1cGv6rI3Mnfkrthtn8yzpvhGFbuiJmmVVrVgNnnSzA5cLOLjoS1u+rfiRqv8uUkaGRxucAV0jd6lla0nRB/AoWmrbF2hiNVJh+fWRd0U972wdZwfgnwrxE3MRe07kIAqCsUXdUvsC14K7MIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pw961RvUl15Tu1LK95H9ygZRyOyxpBNCGHSRFavRpV0=;
 b=Gpe2rFhi0V/RuUaz3hn7UqeBRj6eBDRRl0cbfahjw/MsmDF9DLik0X3GUwgu2Lkij0ampG7V1XjL0+j46NYKNxLYNeH2qM2dQPZUp3eUmYKGpCoo9dMwzDPQqE+mgJWblVtkszwayxGWGoMA6l5aRbS2Ol7MHV+CpsPG+vYc8cqWuwOGWzr2Lot7cB3rTD6uIrgTnbDttRBxR1DQl+cLNrwn137BgwwhrY/iNJk9pH4MdFQhGHHaRnIWr+fTumlUuqqA0nPJK8sBORTO4Mu2OQpEK3k/hn7MbYA0sdt+I/rwj/k7UltQ7K9mQf9KNu3sZVfE80ZaEGQDdP/HoKlZ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pw961RvUl15Tu1LK95H9ygZRyOyxpBNCGHSRFavRpV0=;
 b=p/igsuF3lPTtM2kqPmjSqLogjEZTm4G1QCtFKOXkjSAhvU6ElhSkTDKUTQckBs+q0atDhv/espLvizWTCTNpLEL4u3aNVoZkm/hpypbQhxj5/X7yUH/Z/bEBnU+0AeqSmcCAQxH2ERfoY7txIlDpbr/SqG+zpBpn2iAxqZWTe2k=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM7PR04MB7158.eurprd04.prod.outlook.com (2603:10a6:20b:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 15 Apr
 2024 08:01:22 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 08:01:22 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
	<olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mor Nagli
	<mor.nagli@solid-run.com>
Subject: Re: [PATCH net-next v2] net: dsa: mv88e6xxx: control mdio bus-id
 truncation for long paths
Thread-Topic: [PATCH net-next v2] net: dsa: mv88e6xxx: control mdio bus-id
 truncation for long paths
Thread-Index: AQHahplel9+e2e4yBUems+nCmHLLS7FYK+IAgBDdH4A=
Date: Mon, 15 Apr 2024 08:01:22 +0000
Message-ID: <f0e879e4-745c-4b33-b60e-15973cf9c42e@solid-run.com>
References:
 <20240404-mv88e6xxx-truncate-busid-v2-1-69683f67008b@solid-run.com>
 <1692b2fc-9c62-42ac-a9e8-d843ec932722@lunn.ch>
In-Reply-To: <1692b2fc-9c62-42ac-a9e8-d843ec932722@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|AM7PR04MB7158:EE_
x-ms-office365-filtering-correlation-id: f46e6b18-3f7b-43ec-5cec-08dc5d223d9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wcDa4IE00jJE+bVAFSbI+D1k/LTe34/iH94yQcIbq4Ac+HJyqeORpBl0kBX3crsmRS4iFNvxSCKCSsV9gGcV0ofAifaQSWUyKaanzfX1FSiOegA4gdMrJ3dUKs1JdRohLuvgiCKytqeCBtUDHaPfnAcxEC3Ps+UdMqJHsOkbkYIbUt93BtFQRvcCe8OrUU8KQTqf4FUBDRPsPwgX0iOpuaihVOhV743/4/v/xAXPeVgC2hcPWl2qWJGFBg8AJ4uI75DEr6DP5DWIHu8uH6cvHt4BUz0uaxARLkFAORTuKc/NSe+aZ0PZNhUmGM15ZOBRh7xDXJyUgP+yAgf9LmsnONVVw5eoS/uL+MKup6qkJcxAqJYxCzp+KeKCVjU7iJHuIb72RCX/+TddH/CHCkDG2jopgmYdCbB1u7u5QS/4QRTKWYkdrkGgrIvb2sGLDtBRDyo2Gkr8KJ0UhwlKMcNaQle3fMUUubLhlc/X60akvJshWMSuA5+hmmaeWWaTbrofdeC4aw0Ik2Zc/pqzsS69prTcPnOLHoNHhiyVlQ1vkNqf/697nCShpWoqkn9IcAneC1XLbshn+xY8jSQjfKCliAv3K6RbgjNhA9hOmrUCnf69ZWdOGafM/4xFi/sQLXZZ4KUDmUuFCxkcbT39gqNp659+uht+XCrYhJiWRehnK5DFXhCiJojnQ/o/E/ssH/m4bMypbbuApHejRI8rF0v+usYLTWKTDgqdEiOimew13PQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UjNHc3RxY3dELy96NVdsb3pjdEdtdEpselhRb1I3aEZnTkVJdlZFaDBoVDR6?=
 =?utf-8?B?SXZJZ1RBaEN3bUQxVElGVUp1UmEvMk1aZUFOaWR3cUlGaEtZeUMrS1FSUG9D?=
 =?utf-8?B?K3lpZlh2bzB5cVJHK0N1V0wvQks2QnBjYXB2YkdCcXlnMmZqc0IvVW15eEw1?=
 =?utf-8?B?NWxveDZWMHJQc2ovTFdmU1RjNzlTL2VIZFl1aTBlVnJPZ3hsWm00MkFMb2hw?=
 =?utf-8?B?VmMxOUw2cWl1bW9JRXRzOFE5UEpnUWtUUWdxejZSMGNpbE1oZ2xUSU5YN0Fo?=
 =?utf-8?B?QTVLQjBOaWhiQitWb3RidDRwRVhsWkIrRzR1UTMwMVYvSVFXV29YditJNzJI?=
 =?utf-8?B?NEx5UWh2TndxaXZZZ0VlZnFTUmRjL09SM2pzcWVRN21MQ2tVY0ZUeERMWHBm?=
 =?utf-8?B?cURqMlduOFJYbFZzNExmdnk1NDJyNW5qRFNCMGpWeTlteE5GdE9CU0k1b2pH?=
 =?utf-8?B?dU94L1dJT2pTbnlQUis3eXZiTG1jNEhBbWJyRVRQN2Z2K0hRSEttVmNBNU1X?=
 =?utf-8?B?Rk12T3VYOFRKUVFhQXAxVVBzN0pJOVdrNnE0eVAraEoreU5rcjBuaXN6cDEw?=
 =?utf-8?B?TnNtREdvY0FyYTNsb2NXN1BFWk0yM01ORlFaM2J4WHpoUlJtNklEQUNWc3d0?=
 =?utf-8?B?WTJiQVFSNDFLNGN0N0dJdTgyVUxCalBWNVJCTldRekZqSGtuWkdCeUhCMVFl?=
 =?utf-8?B?L0FYLzArWFlkL2dMVkpQdWtCek9PdndNdHVLZjltRTNjTlhvTHZ6cnVLNG5j?=
 =?utf-8?B?bTh3ZlVseThJMzZwOS9VNFpaZ0wzN0NrbEdYK0c5ZjF5NlhFSjFDNWREVis0?=
 =?utf-8?B?ZEV0WmQ0amx3UE00dTBQcjc2a0lDeU9BVG5aeit3cCtBbEQ0dkdHbkI0TU13?=
 =?utf-8?B?U2dFV2d5QlJ2Z3Z1RHRITGM5MHJxK0hFUjUyRHVycVVWb1JBKzJ4bmt0enp2?=
 =?utf-8?B?Q2lydUNESksrVVV1L0RVOWJUSDdZaTYvWGV6NUh4Ym05WCtOZyt2UlE4MUJx?=
 =?utf-8?B?SUFiYjljRVRNZ0tGWTBLRElkbzZEdFpNcE5DRk9XMEtYVThmZXN2cVpTa3ZE?=
 =?utf-8?B?cm5Cc3JIWnZjNDRtOEhGN2FrdGJaK1A3NG5obHVweDFCMG43VUwrU2pqYndH?=
 =?utf-8?B?WjNRNVZOVXQxQjl5dVIySExEQlg2NGRkaUhBSDRuR1BQSzZtTy8zd3M0ejkw?=
 =?utf-8?B?T3VxZUxqYmNwRm9KTzdmTzhseUVnTm1LV0hsNXkrbVNWOVV3MytpUW80YnNs?=
 =?utf-8?B?UGpHWWtIR09qR1JUQm5VM2FQT3JBUDJveXRnMzI3UzV0ZkZoYTZ0a0pQT1N3?=
 =?utf-8?B?Rnp0UWg3NnhSNFkvNlhlK3lhZ2ZUNU5RUzEzQ0tXb2xaYmI4L3hpYjJVMDJ5?=
 =?utf-8?B?c2JTRGNOL0xTZGlubWs0bDdUUDd1QWZSdWkzVHN2Z2V4VDB5TmJuMmFRR0dB?=
 =?utf-8?B?cWk4SzgyTlFOT051YXViblJqRlFXN3FLWWxwVXhpMDM1VTBVRVJjTENIMENP?=
 =?utf-8?B?d0phMDJMSDBlVEVPN2kwenN6dzF6RFhIbjVlbFVrLzV5Y1hQVGRMVmlsZXdC?=
 =?utf-8?B?bzF2V0ZUUWFNYlo2RVdoWFBmVGNWNmZjeW5qSDFwZTcwYldpT3RTWUJPNGF3?=
 =?utf-8?B?VE55cEtoMzFlQTJpbTFqT0lUYlI2NFFOWkNRZnJscm9EQzBxU29iVjdob1Y4?=
 =?utf-8?B?TWhaYUNpdk03Y0FNRzh1emJXd0R5ZjREU09IeDhVd09yaVhJTlFFbVZzQVl5?=
 =?utf-8?B?UkI0bnVTU012dVIyMkZDUFIxMjEyQlZsZWM3Z1BGeEk2dklHbWlHMUVaKzI3?=
 =?utf-8?B?WnlXQ25XSldMUXZndTY3QjMvZkUxOGw5VEgzOXE4UjFXUW81QU5DQytjYURE?=
 =?utf-8?B?dUcxRG5qWHhyTmw3Q0lEU1ZPWmlpTmlZN1QyNm1nTnd6dm45MVZOT1dGbDky?=
 =?utf-8?B?Qzdoa0F1dDNoaXFwRzhTSXZrcW9kMXNrZ0QxV2RnKzMrUU1lUEcxWnVTVUJE?=
 =?utf-8?B?NFE4dFJ2dVgveUQ5dGg4aHRQWFRiNWxPQjNCUjBXMFdTbnRhREM1K2hvM3Nu?=
 =?utf-8?B?OXhhSEtSZ3Vib2xWbSt1OVlyeS8yb0JWSUZpWFJEbVZSL3JMYktCNWZ3Wk53?=
 =?utf-8?Q?kNUSvCkGoMnhFj6dozAJnwu0X?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B47A75CEBAA9E04FBC7C9A917ED8B39C@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f46e6b18-3f7b-43ec-5cec-08dc5d223d9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 08:01:22.3285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fMEVD3C5VBEG5gGXbcaVRWMUuyZJI5aDOnZ5mNRcLfR+E1XoE6g5PhYVN9QAP7mkjZw6GIEdwfKQVsZ1VU9LVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7158

QW0gMDQuMDQuMjQgdW0gMTY6Mjkgc2NocmllYiBBbmRyZXcgTHVubjoNCj4+ICsJfSBlbHNlIGlm
IChlcnIgPj0gTUlJX0JVU19JRF9TSVpFKSB7DQo+PiArCQkvKiBJZiBnZW5lcmF0ZWQgYnVzIGlk
IGlzIHRydW5jYXRlZCwgbmFtZXMgaW4gc3lzZnMNCj4+ICsJCSAqIG1heSBjb2xsaWRlLiBJbnNl
cnQgYSBzcGVjaWFsIG51bWVyaWMgc3VmZml4IHRvIG1hcmsNCj4+ICsJCSAqIHRydW5jYXRpb24g
YW5kIGF2b2lkIG5hbWUgY29sbGlzaW9ucy4NCj4+ICsJCSAqLw0KPj4gKwkJZXJyID0gc25wcmlu
dGYoTlVMTCwgMCwgIi4uLiEtJWQiLCB0cnVuYyk7DQo+PiArCQlpZiAoZXJyIDwgMCkNCj4+ICsJ
CQlyZXR1cm4gZXJyOw0KPiBJdCB0b29rIG1lIGEgd2hpbGUgdG8gZmlndXJlIG91dCB3aGF0IHRo
aXMgd2FzIGRvaW5nLiBSYXRoZXIgdGhhbiBlcnIsDQo+IG1heWJlIGFkZCBhIG5ldyB2YXJpYWJs
ZSBwb3N0Zml4X2xlbiwgdG8gZ2l2ZSBhIGNsdWUgdGhhdCB0aGlzIGlzIHVzZWQNCj4gdG8gZGV0
ZXJtaW5lIGhvdyBsb25nIHRoZSBwb3N0IGZpeCBpcywgYW5kIHNvIGhvdyBtdWNoIG5lZWRzIHRv
IGJlDQo+IHRydW5jYXRlZCBmcm9tIHRoZSBlbmQgb2YgdGhlIHN0cmluZyB0byBtYWtlIHJvb20g
Zm9yIGl0Lg0KSSBjb25zaWRlcmVkIGFkZGluZyBhIG5ldyB2YXJpYWJsZSAoZS5nLiBidXNpZF9s
ZW4pIHRvIGNhcHR1cmUgYWxsIHJlc3VsdHMNCmZyb20gc25wcmludGYgY2FsbHMuIEJ1dCBpdCBp
cyBjb25mdXNpbmcgYmVjYXVzZSBpbiBzb21lIGNhbGxzIGl0IGlzDQpsZW5ndGggb2YgcGFydHMg
b2YgYnVzLWlkIG9ubHkuDQoNCk1heWJlIGp1c3QgdXNpbmcgYSBuZXcgdmFyaWFibGUgImxlbiIg
Zm9yIGFsbCBzbnByaW50ZiBjYW4gYmUgcmVhZGFibGU/DQoNCg==

