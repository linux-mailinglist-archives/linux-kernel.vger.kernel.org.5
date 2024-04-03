Return-Path: <linux-kernel+bounces-129143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833818965D0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDB2BB238BD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F6C56B68;
	Wed,  3 Apr 2024 07:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="urhspgV7"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2095.outbound.protection.outlook.com [40.107.20.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7429E156C2;
	Wed,  3 Apr 2024 07:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712128512; cv=fail; b=QHUX4V8ynpPvpDICNxZEnM6O21A75QNj94VdEu30CcxosZaRqmgpMc3W3Afn1lCKSAASUvWCDJQiSNbdTeSa04kKFYsRmkFvmi5MBF9fyKtJtYGByf9XCy5TyTXsaXG8ylUXtNkP9+c+8hflkbZg/rmLs7W8aOmOlsx8l0ewKn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712128512; c=relaxed/simple;
	bh=hzwBXQHosTiW6FSaYMb36/vJIaEPiudiZMFs727nqYc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GGZS89uRTRb1rN9yWpOi1ZV/yhyT3jM/x+fuqY8Z3WzAWQM4f9gz8NS/gVDzaTgcTL0jW3EArrTJXjcLWPQFw1JQRgwqpnlwblOXz8tiY8MxlIrIb5px6PthkSYbWLxLwcpnIKY9TSNqcNqKgZML8i7YPRK6ISWYhWuKLB78u6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=urhspgV7; arc=fail smtp.client-ip=40.107.20.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i73DXAn5ixUvqEVENGgZJWxC2cPGn7lX0mcxcbd1uHCag7xicwwgzF6A7xed9n+bKPkQT2/jmhu0wHnHInK/HoR261W6p6P72NKVqDsgqClV+prlBk18BL77yNouMWqoKs9e4KYCQ3ByiLD1ddnFdfe5tr+qNi0oHif3FdfM+10XJm2PjUfUpiCkG8zlrs9sSARu5usGpNwSv4j9EvdkGKcjkivRLD1TlIzfwueOqNC0MkiWt2MEYKijEtBZACNxUmi9imHJQwMOiDu4SwIdiN1j5EKTwyOFLgUtSkIHWu1rooVgAoJibXRJhf3g0KX4aWdB8Z3EOy13RYy8MCv9Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzwBXQHosTiW6FSaYMb36/vJIaEPiudiZMFs727nqYc=;
 b=loTC3bjSIqXDr9+kZFfBZSfIMvdyc/xkkNpv4yUcTU1MoU1bfKdN67A4qVTWkcdbPZVetxjpt6XOEPi21CrSpcMeTg6+ClZYrEwtiq/sxNAS9ZAatRddUUtYmPgW6NgN5jygxJxyZeHAB7HMSRMWdfth1iZvYhTwYm4AaTVPPXOwsICp9Nan3Bzo2jHZOzSNnxsD61czke58Xv228z/onmO4VzSpZvHlOJALFHttdp9B7LtEruEAbu0nDIzU5T3KCFPQa8SagodP+0ePfa4+dR69+oscwSODi7aE4snlHSNCMPHKtJJyLa3ev0xOh1CXSUdG1KuUZ/0GN3g1HNFeXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzwBXQHosTiW6FSaYMb36/vJIaEPiudiZMFs727nqYc=;
 b=urhspgV7wdjXm03ga0KLFtt1vx1EdkiprDr0fdmD8tUuVl10EXru6nK8Nnux8SqPflM2ZdvwbcDQrQpbJhSE/f9zUpMArulNYhqWwrMLxuCWJcdjEOMTHkvXMIEPvR/GBv8l8ie3mgLrRKzZ+yB5JduDNOfgl45+CuEwGQEMhFE=
Received: from VE1PR06MB6911.eurprd06.prod.outlook.com (2603:10a6:800:1a4::13)
 by AM7PR06MB6504.eurprd06.prod.outlook.com (2603:10a6:20b:119::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Wed, 3 Apr
 2024 07:15:07 +0000
Received: from VE1PR06MB6911.eurprd06.prod.outlook.com
 ([fe80::9256:56bc:4cd2:d41]) by VE1PR06MB6911.eurprd06.prod.outlook.com
 ([fe80::9256:56bc:4cd2:d41%2]) with mapi id 15.20.7452.019; Wed, 3 Apr 2024
 07:15:07 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH net-next v2] net: phy: dp8382x: keep WOL settings across
 suspends
Thread-Topic: [PATCH net-next v2] net: phy: dp8382x: keep WOL settings across
 suspends
Thread-Index: AQHagRSZ7N1xc3ecZEet9kKLrQN9R7FVvlIAgABs1IA=
Date: Wed, 3 Apr 2024 07:15:07 +0000
Message-ID: <ebf88d8f-c5e7-49c1-ac7f-ee7fef9bffe3@leica-geosystems.com>
References: <20240328133358.30544-1-catalin.popescu@leica-geosystems.com>
 <20240402174536.75cbe074@kernel.org>
In-Reply-To: <20240402174536.75cbe074@kernel.org>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR06MB6911:EE_|AM7PR06MB6504:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fitusWg7H07fMoY1ONPmqH3mpOueR90/ufSU7l+JTqwgJmh+lVNMUiDgpc61YNoLG+1Ar3oj2G668zF8UiUTMH3jwdCVtGA7q4SGRC+c7uNe2wc9eCr+SDqxHblgns5sEIJ+5304yHFDmFx5R0Re1jWjABQZMeHk2CqoORnL/5UtpNS3edtK0oLpv7BiOx9nXiFwwYSuR2POVd4nIHhtHqb+cF5mUhMP3Kf1lI2tzHaSl2PjPtLrteiw3xTBVMN6xtNWFQltyOaaNhC6WHA4N7voxUgs9VQ/5/7K7bex9csAT0xrAhjRixcW47ejN03tq3ucInr0Wt4MsXHInAae9V/3Trr0pQGso6w/lJMpuRgYCI+sltMOqdXm0FmblCmXCOgc+Ljeu0eE9pi0CQLreO4ji/UqYtqu81wB12461ONGz2o1uxiRxVpl297IaKoRnANJVIUXoM7QXqBDq+BV6FRZd6zWKqjNTV1sbzBcC5WkKOsYTk2fRCjNfnHesUgeoJ6VcgXkVjl+6/ky9w8DxPO63W62aOL2LDHGyE5i/nyU+dLZnk1Bkri1PwlX/W0vrjXPij0kla+wVZ7+Q2FNVqu+AH1GrEnZUH24WTROyIYmr1yfLR7MPKV8f8JVdcYoH66Md3kPujjM0C/SmWORfedAD5QyPhGmuuNeb6gueM4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR06MB6911.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NnYyUWxCczJ4VW9VRkJXVE5oLzNnVUlodFdFVzBNcjExZHpEcjMveW0zUzl6?=
 =?utf-8?B?em9MZ3NnUm1lWmNXNmJ0RG1FOGVYb1VHN3M5VU1pSGpuK3RnNERkSXlXTEl3?=
 =?utf-8?B?TU14dHZoczR0c0NibktlK2JUTVFSTGlSL2FaUndPQ0g0aCtOZzJvanJENnhQ?=
 =?utf-8?B?WWZMTFJOdmlXRzYxRVNEbmZGa2VUejdncVRVU1E4cmdncUNFbndmcE54eTdx?=
 =?utf-8?B?OEpaVlc0K0ZqUVJSbVhoVHV6NXZueFdGTFBaeU16eFpjSENtYnVuUGlSM21n?=
 =?utf-8?B?bmdLZzU2RmpIdEppVzc4OVcwa2duN0lvZXphQW5UVDFwdHE0SlhMSUhUMm5O?=
 =?utf-8?B?bVIxYWNPSk9IZWZ5bWVHZmhxSnJxTFlCM0tTUzdrM0ZhSlVGQUxUNDFQaUYy?=
 =?utf-8?B?amNLQVY5Smo4QnZUY3NYQkE2cXU5ZWZYdzFNUVRFL1VvRVl3am5hMkpyRzV5?=
 =?utf-8?B?eTkxNzlDT25PNW5OT1JMYjk3aGZTMjg2Yzd0d2JzaHRVSlpLWDZFdjZUKzgx?=
 =?utf-8?B?a3REb2tkVWl5LzF4SWJqb0R4bnFtVmtVVzNteWUwdnpsam9YeG9WTnRIb1Rh?=
 =?utf-8?B?aTJHK2pNckZyRUNCcUNqbDNpS20rTzVSY3BIT3RzN1RnWk8vWWJYSWp3dHQ4?=
 =?utf-8?B?RHROeU5HRlR6QW85ZE9tZFRFVHhjb3FuNXBqWGtPeUlGdzI4emZHQysydk5X?=
 =?utf-8?B?V2gvbTM5bzlLbHpwUVpVRlEwcHB4REpDUHZHbmFjRHpvNCtFcFAyNlBVQjAv?=
 =?utf-8?B?S1RIcTIxeFRmVmpQeGRHWU8veHI0c1pudjFmSlkzWVVMemhMRlRxZUM5QTM0?=
 =?utf-8?B?UkJFUG1WOGFBYzUyK3Y4NU5zdnMxYk54dmpqTjlMR2pneWdkb0RxcHNYb1FJ?=
 =?utf-8?B?QThmV1F5eHMrcTVjZUtxUTJuR1lyVjRhTWxwcy9rRmJKelpPcG5ISzRpSXZP?=
 =?utf-8?B?c01ibHQrY1JUeUZVSzNBampDbHRIM3N0aHNjTks2bld3V3NrdFFTeE9GKytE?=
 =?utf-8?B?VUkyQkJSWHhtOFhDSUNsWjhYOGRELzZSb2h2RjRaY2hRU0FKWndiK2xybjhL?=
 =?utf-8?B?YzRhc3JNVjQzWXNQeGtnMGg5ODYrK2dNU0tTODZ2bnRFSjRjY29JdzJ4UXJR?=
 =?utf-8?B?cVpFWk4zcjc1UkJDVXpqWDN5V3QrSlBuQUM5eUJtMXVQZFdNOHgxcWFKVkVQ?=
 =?utf-8?B?WDVwN2pOREJLcldHamhCakZZQWdoTSt5UmJuQTdsZmlBQXU5RFA5SGkvVmhH?=
 =?utf-8?B?STRoVXBsOVNZaU5RN2dpQzNtZk5xWTVtNE41RE05UytsRitvOEpoSFhjalFh?=
 =?utf-8?B?Z09QdjlraTVZWmdQYnBVWm9PQjE0dXcyTnJQSGZMbVRPNHhwa2pvcjc1b0VD?=
 =?utf-8?B?Z2J1bnZHUnB4QWhremVzK2ovMDFjS2ZXeHllVklscWFPc2JQYU1xN28wWFZk?=
 =?utf-8?B?RGpqNzBrVFdtM0pIcHBzN0VOeGVQUW9kays2aW95UGE2QXozOTBUclhsU2ZB?=
 =?utf-8?B?Wm5ETlV4QmJXNzRnemFKSWFHR0VZQzFVNTI3NDRaMW9DbWJZaEVMUEN1aWtu?=
 =?utf-8?B?a0lVWkJXVEtWRnE4NnVnY3Q2YXorTUl6cU1rNWtWQ2ZaKythRjdHVC9aR3JV?=
 =?utf-8?B?OG5waGI1ZVpYTW1xam0xRWJYS0ZiTTdCMGhJMUdpcXFoRHAvY042UHBaRVE2?=
 =?utf-8?B?TkVrV1JMcks0Vk15MERLdTlJOUR2V25yRTEzRmdPMkVXRmNyL0pDVXZTUisv?=
 =?utf-8?B?b29UeGREZDMyczdrNnBIajBGTE1XTThqS0plb0QzZ0l5WHFoOHFHNks1bGdM?=
 =?utf-8?B?OWVYblZqR0tGM3YwODhSQkRLMmJaNnRzaWFkMG9PMmVWYkdKQmE5aTJKTE43?=
 =?utf-8?B?VGM3WEdQZDVyZGcwUTRCbEJVTjNvVkl1VXliT0tLRG9JcmlVVUUzQnFCbzVQ?=
 =?utf-8?B?OEJVWldWRnhZR1NOMHJtKzNXdks5SlNtRGxLbTkxSTFwc3hINEZTMkpXaHph?=
 =?utf-8?B?RzZQd011Q0pXaWlwcFhNNlJlQWR2eGNybnhrOTY0ZGc3ZGtzNUtKUXl3Z096?=
 =?utf-8?B?a21PcUhPUFFVSituUWlTb1VpelI0b2FmRE9NMnUrWUFvL1QyWlRiaTBwV29W?=
 =?utf-8?B?bGlGUktxVGxVOHFnYW9DRHFnME1tbXEwU1pZVlByTHF6TlBBSFRzbm51UHdW?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD4A3697D1B3144693EF419FF1C3556E@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR06MB6911.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b45b9b-0a11-4879-0e08-08dc53adcac7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 07:15:07.5794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XsuHcaLw7npGBV9Z8xwaGhznRMKiZyIWIsuizWT4S/sQG5ySSqXUMQLvdfIb07rPz0qJozuoFOxxmHLUN6H4FBI1+SPjvexmDIQI9GIjanlfQU21OJC5QQYFeCE5Iqkd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR06MB6504

T24gMDMvMDQvMjAyNCAwMjo0NSwgSmFrdWIgS2ljaW5za2kgd3JvdGU6DQo+IFtTb21lIHBlb3Bs
ZSB3aG8gcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGt1
YmFAa2VybmVsLm9yZy4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWth
Lm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+DQo+IFRoaXMgZW1haWwgaXMg
bm90IGZyb20gSGV4YWdvbuKAmXMgT2ZmaWNlIDM2NSBpbnN0YW5jZS4gUGxlYXNlIGJlIGNhcmVm
dWwgd2hpbGUgY2xpY2tpbmcgbGlua3MsIG9wZW5pbmcgYXR0YWNobWVudHMsIG9yIHJlcGx5aW5n
IHRvIHRoaXMgZW1haWwuDQo+DQo+DQo+IE9uIFRodSwgMjggTWFyIDIwMjQgMTQ6MzM6NTggKzAx
MDAgQ2F0YWxpbiBQb3Blc2N1IHdyb3RlOg0KPj4gLXN0YXRpYyBpbnQgZHA4MzgyMl9zZXRfd29s
KHN0cnVjdCBwaHlfZGV2aWNlICpwaHlkZXYsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAg
c3RydWN0IGV0aHRvb2xfd29saW5mbyAqd29sKQ0KPj4gK3N0YXRpYyBpbnQgX2RwODM4MjJfc2V0
X3dvbChzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2LA0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgZXRodG9vbF93b2xpbmZvICp3b2wpDQo+IFdoeSB0aGUgdW5kZXJzY29yZSwg
eW91IGNhbiBhbGwgdGhpcyBhbnkgbnVtYmVyIG9mIHRoaW5ncyBtYXliZQ0KPiBkcDgzODIyX2Nv
bmZpZ193b2woKSBvciBkcDgzODIyX2FwcGx5X3dvbCgpPw0KDQpTdXJlLCBJJ2xsIHVzZSBkcDgz
ODIyX2NvbmZpZ193b2wuDQoNCg==

