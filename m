Return-Path: <linux-kernel+bounces-11904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A01A81ED53
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 09:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E94FB2146F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0C36FAC;
	Wed, 27 Dec 2023 08:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="WO3Vzndr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2056.outbound.protection.outlook.com [40.107.104.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800C56FA3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDDYY3M20aQKsbif8IgzJOrRHyCQkNDosBNH6Ox81Y47jzSJJXtgdF+r04Ll8o2ZG38hcn1B6xQMh8O71ml/tLuEsxau21Ps1PqbnQ+6rcUl8ofTG9mptHAAPqLKkmM/RqMJ2UfI689q6Rd0aU/Vl26kbeEY0XVBHRFctJvRISG5HOK+M7VG6mC32QQ5pmALXLJ8vl/cvBKTJndR9rMW9Hm9+5ODDoAP3gQ4+kJCgq9O8b2WdVWzhrxWnUQxlN5+r883OLCqcynXAi4OVh5Gdo7dCflt/e6bJdVM5ocKXZgEGT5SPS+m+/RRi0bFSeM/Zxhc87FmyWNBbLneefZtlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYNojJKMmhHWXrXPXFU4MC12qvxjLUZYSse34zI4FwY=;
 b=NyMRBEQvLnOI/Y6WFchQ7tzUOc8ECVBgVdMS0kBYolzp4TaD8QIroG0jot+3S47Q1dsrl6kABIoUbo1pGRGcvfk3bH82SNnOkfVrPFslZt9UR3F6o7Hc//9E65JAHLO4E8s2zWedaygSB3q5dgZdjtoeHJxKu/9HsNXq3/4BKxxNTNegKzRmYFLA1/BpX7wyaVpW4wfu1AkucHlbrvrOlG/TxR11eH7ythzeZpjDmgQLGTxGlFa6EmX5PGul0hyHX6J1aLq7ve5BcbvnJw7pFake2hJF+/AiIQSwd0TyS7GfxSUeVLAwg9r+M98OoCOI9iZJn6H/LVOCpIbgczio/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYNojJKMmhHWXrXPXFU4MC12qvxjLUZYSse34zI4FwY=;
 b=WO3Vzndr936P3LhNoAeYcHKEHSQHYCY23/5OOimXem9Czeq2mKTLrESvYJ3YwlpIAr+OOaJhjwh+AYO1NHNEfLcF0woet66ALup3abZkBlQdXZOqzLS/mRpWaOGpGme8gwFmw9xMYRvbK4DT7mLILlzXBe7I1ItLBiwMdS/G5dM=
Received: from PAWPR02MB10280.eurprd02.prod.outlook.com
 (2603:10a6:102:34f::18) by DU2PR02MB10231.eurprd02.prod.outlook.com
 (2603:10a6:10:491::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 08:29:25 +0000
Received: from PAWPR02MB10280.eurprd02.prod.outlook.com
 ([fe80::3e71:f4ec:d35a:4726]) by PAWPR02MB10280.eurprd02.prod.outlook.com
 ([fe80::3e71:f4ec:d35a:4726%5]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 08:29:24 +0000
From: Vincent Whitchurch <Vincent.Whitchurch@axis.com>
To: "joe@perches.com" <joe@perches.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, Vincent Whitchurch <Vincent.Whitchurch@axis.com>,
	"gpiccoli@igalia.com" <gpiccoli@igalia.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "sergey.senozhatsky@gmail.com"
	<sergey.senozhatsky@gmail.com>, "jbaron@akamai.com" <jbaron@akamai.com>,
	"jim.cromie@gmail.com" <jim.cromie@gmail.com>, "john.ogness@linutronix.de"
	<john.ogness@linutronix.de>, kernel <kernel@axis.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pmladek@suse.com" <pmladek@suse.com>,
	"drinkcat@chromium.org" <drinkcat@chromium.org>, "lb@semihalf.com"
	<lb@semihalf.com>
Subject: Re: Re: [PATCH v3 2/2] dynamic debug: allow printing to trace event
Thread-Topic: Re: [PATCH v3 2/2] dynamic debug: allow printing to trace event
Thread-Index: AQHWevUdBil70sMw30SX1Up8thUsKalI2EqAgAHPaoCAAAYfgId4lXwAgAEEXgA=
Date: Wed, 27 Dec 2023 08:29:24 +0000
Message-ID: <8e0f337c0dde3fe81fc71620275852c4d42beeaf.camel@axis.com>
References: <1c54063e-8ad2-5be3-85fe-519f5a944d20@igalia.com>
In-Reply-To: <1c54063e-8ad2-5be3-85fe-519f5a944d20@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.38.3-1+deb11u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB10280:EE_|DU2PR02MB10231:EE_
x-ms-office365-filtering-correlation-id: f98b9b5e-4f9e-4167-21e0-08dc06b5ef09
x-ld-processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 NUWpAG6Y1f2v2A3xn34P+DT1/TEWjfNFH0WzavBZNCazEtMEYvSGN4VAp514u4iZgdaty7fwinqzfaG164pv/tm8ucOxD7hPzdu6SnUFoGObPS90P290dlg1psDydp1QBGl/uArSkgULJH5xpdid9V2dMRG96gmrzpyoditYiqrVTyfPJ0MvTQltSJ4swL48qfdtZfUArKSKHA7BAyjpvuY3p7QQ0sALl7KIxQpJVPFL2b1F2AP8ovpKiC/DlIxczXjwCfXRGtz4orf4fUGnQNXvWc+HJ/CY4t+RT5Pq02oDS8RGfaGQxEZltY+tG+f1/CRqFYR3xIKRnDjMRYeTyZ463bK0H1EP7U0DXX7KHRaHvM0fPiPyv/WAYKDfXUnu+sTe6IujhNsqij1DIrFWLh2oQhv52EskU8YFgi+GxV8edI2XsSh3I8aKwdBVIfP9++Qp/acIPlJYreWvY23pEHVu8EBUppZj+ENwYeu36PQeY9uS+ySbFMw2yFbVnzpQ3LNG+Sf9hxI7K2GVxQtojm9eW95RJXtc6lNrHXE0TFc6AgKepbtd5zzCu+imQ1UBPJN2MzWk+haneO0nTRWrSkxeN16Z4ZFu0O8hhbW9NJ0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB10280.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39850400004)(396003)(346002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(6506007)(66574015)(26005)(2616005)(71200400001)(6512007)(966005)(83380400001)(7416002)(5660300002)(4326008)(8676002)(2906002)(41300700001)(4001150100001)(6486002)(8936002)(4744005)(110136005)(478600001)(91956017)(66946007)(316002)(76116006)(54906003)(64756008)(66476007)(66556008)(66446008)(86362001)(36756003)(122000001)(38100700002)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RlVBWVEzRkxib05IRkNnSGRLYkV2Sm9KUFJaWUhxWmllelU4bGJqUCtoNlJj?=
 =?utf-8?B?WHRQODE4cmo3Wm1rMmg3cDlJVEhXWjdMZkJDM096cjJFRll3U25BcXl3NGFy?=
 =?utf-8?B?eTh3c2NaSUg0N2FGVWJkRjd1SzBHT1A1eEE5a3FpVk9hSjRVTVp3MWMxZVBK?=
 =?utf-8?B?aGt3bFh5d1FMOGo1RWNzOTF3bjBmY1B0bzQ2WHRPb0NiTm1vd3UvaXhYeURC?=
 =?utf-8?B?R3FxVVZoRUk2c0gyVEVGL3ZJblhlOXdYQXkyNU5DS29qYW01dW1RM0Q4NHdi?=
 =?utf-8?B?czFrZ1RCc1lWNFZRK1VOMGVmSG81NDhHMVRWTG11UFloc1ZFYU1hTzlpV0N5?=
 =?utf-8?B?cFVBOCtMRVNKLzIvdWNyekV2bXdpcHdUQ0JPQ1JnNzlBTnlXaHlxL0x1dk5N?=
 =?utf-8?B?bmhDb3hEOTE2UEdvRlR2UUpRZG1JUS9YN0dINFlBbWtBWWpjblNxdG1Tb3FF?=
 =?utf-8?B?WlpodWl1OEVaVGo5dm56Vi9vRkJPaVVjSzZHbnBBdWJNQThsZzduSys4eEo0?=
 =?utf-8?B?bmRRZmVWaU82aGZYQm1HN0IrTFI5ZTlzSVNKc2xBWFR5YXBJQ1pzbm9zT0RL?=
 =?utf-8?B?Y3FOTy9VbCtGaEE1Z0lxVVg0YmxHOHlIRnZkQnY4M0NNMDRCNCtJRk10Q0FC?=
 =?utf-8?B?bmNwN3lWT2x0QVFid01RcFVCQ0xpUUV5c0RZb3B0aDd2dE5MU2xDU2sxekFq?=
 =?utf-8?B?N3N4RnE0VjlGRDdRTEJSZ0hTOTE2TGtLbFM1cWU2UldxZlVaSjlSdFpTVDdW?=
 =?utf-8?B?ZXNPc0hWTC9VT0V3Wmt0akc4MlNXbkRoeEVLZkNuZHlxeTIrZWVaTkd0UW4y?=
 =?utf-8?B?czk4N2ZDOVpyamFuQ2pWTnhROWNEWXpkMTdZelgxWmxrTkllNGovbjV1eWwy?=
 =?utf-8?B?eTlKREhCdGNWZ3hMdjVrRTNvQ2R4VmpBUVBDM2FqOUNOdmN0VHV1aGQzdjkz?=
 =?utf-8?B?aHVJT04wdmFGY0dPVWt4WlNEcGpGODRob21ONy9YZnBpUTdKS0Vpc29ZUVls?=
 =?utf-8?B?bW9SQWlmdXV6U1lHMlJqRnQ5NDNlOFRXZnVIYTd3SjdnMGFKMEFROGZrdUMr?=
 =?utf-8?B?ekVyZlk0U2VNRXA4Q1preU1VRHFqUnlPRFRNd0tXNUhCNE5PeTRxTUtpc1pP?=
 =?utf-8?B?QUZvNjVkT3d0UmFQRVN5dmptd2poSnAwdFZuNmVTbWV4bmoyN1doQkZSVGh2?=
 =?utf-8?B?dFlIMlNjbGR0NDhqVnBqSGNDRTNtaEVGMHcwR25raUVlNTJ1UW92QTJGbUk2?=
 =?utf-8?B?NUNHVWlVaHhsUkJ5Nkg3Q2VFR3NrbXc1b0k0UXlYM2tqVDNydVNmT2Rrc214?=
 =?utf-8?B?S1NydGMrV084TUVTMXFRU2ttWnFUMFpiWXpRTG9sM0kvSTFuOUdMTUJZbEhk?=
 =?utf-8?B?K242bG5DUjhVVEhLR0xmcG9YclFOcGwvMERqa2IrRkF6SWZQSkhyblNHTENP?=
 =?utf-8?B?TTZTd0Jyb3VWUjM5aXkwaTJFaGtITXN3N3E0WEl1SGcyWnFVV2FlREdFNnJX?=
 =?utf-8?B?MnloaC95SG5hVG01WTFSdkpvL2c3TXpXTVVwZnR3TnZ5WTNiZEFyRlZwelFt?=
 =?utf-8?B?SFBPUTRUQ0FSTWdEQ05KdUFuZVFDb3p0cDdJbXZsZ09tazVMVUloWjdtUHBF?=
 =?utf-8?B?Rmp1ZVo5ZVJMd3E3VkxDWW54dXRtUmJBbHNxWUhYL0UzUE9FYjVLUFBzbjlD?=
 =?utf-8?B?QjRCSEJOYUQ2RTNFeGVSK3lzTDNJZHRQd2lxTFRmSm4zRU5OMTZHSnIxZGhn?=
 =?utf-8?B?MU5lQWRnREJVRFIwU2g5ZDZRRXF1N1BDZ0J3M1ZPOWFnYUtBT2VmQ0c3VzRI?=
 =?utf-8?B?T1NzTUY3Q0hUNVRMSldYU1pPUUJoWGp3OE9qZUhrR2JoUjFSRnVacFJncmRY?=
 =?utf-8?B?OEFjeU1iSmhGRzFWaXlrUzhOY0ZWUUtVS2RBZTJ1akdlMXJKc0laZG0waGhI?=
 =?utf-8?B?bzA0enVFMnRqTEZUOWUzeEpCRk1uOUI0Yjl3dDlSYnRyVXRTVzdJT2dNYlBs?=
 =?utf-8?B?VUVOTGk1QTBKNmhzUkxXWjdoTGpTUVJGajllc3dwY3Mzc280TUZ0UURuU3JW?=
 =?utf-8?B?NmE0eklodmRHWGRwSWlsWWlpWTU1aHhqM2ZMVlg4V1czdnQ4OTdHUlM3NXNn?=
 =?utf-8?Q?pHNri6sr9D/rzRrtp/jZP3aCe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7F0177297424B45994FC38FBE39D496@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB10280.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f98b9b5e-4f9e-4167-21e0-08dc06b5ef09
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 08:29:24.8356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 17N4UMZbNnZfWGFhemh4+tG9sWlPpFtuelUFxp7KGCrW2qYFVUdoBiV/GShT9mQ6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR02MB10231

T24gVHVlLCAyMDIzLTEyLTI2IGF0IDEzOjU3IC0wMzAwLCBHdWlsaGVybWUgRy4gUGljY29saSB3
cm90ZToNCj4gW0ZpcnN0IG9mIGFsbCwgYXBvbG9naWVzIGZvciBuZWNybydpbmcgdGhpcyB0aHJl
YWQgLSBmb3IgdGhvc2UgdGhhdA0KPiBzb21laG93IGRlbGV0ZWQgdGhlIGZ1bGwgdGhyZWFkIG9m
IHRoZWlyIGNsaWVudHMsIGhlcmUgaXMgdGhlIGxpbms6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xrbWwvMjAyMDA4MjUxNTMzMzguMTcwNjEtMS12aW5jZW50LndoaXRjaHVyY2hAYXhpcy5j
b20vXQ0KPiANCj4gU28sIEkgd291bGQgbGlrZSB0byByZW9wZW4gdGhpcyBkaXNjdXNzaW9uLiBJ
cyB0aGVyZSBhbnkgcmVhc29uIHRoaXMNCj4gZmVhdHVyZSB3YXNuJ3QgbWVyZ2VkIEpvZT8gQ2Fu
IHdlIGltcHJvdmUgc29tZXRoaW5nIGluIG9yZGVyIHRvIGdldCBpdA0KPiBpbnRvIG1haW5saW5l
Pw0KPiANCj4gSSdtIHNheWluZyB0aGF0ICdjYXVzZSBJIGFsbW9zdCBpbXBsZW1lbnRlZCB0aGlz
IG15c2VsZiBoZXJlLCBJIGhhdmUgdGhlDQo+IHNhbWUgdXNlIGNhc2UgYXMgVmljZW50J3MgLSBi
dXQgdGhhbmtmdWxseSwgSSBzZWFyY2hlZCBiZWZvcmUgYW5kIGhlDQo+IGFscmVhZHkgaW1wbGVt
ZW50ZWQgdGhhdC4gQXMgcGVyIG15IHVuZGVyc3RhbmRpbmcsIHRoZXJlIHdhcyBubw0KPiBvYmpl
Y3Rpb24gZnJvbSBTdGV2ZW4sIHJpZ2h0Pw0KDQpKaW0gYW5kIMWBdWthc3ogKENDJ2QpIGFyZSBh
Y3RpdmVseSB3b3JraW5nIG9uIGdldHRpbmcgdGhpcyBmZWF0dXJlDQptZXJnZWQ6DQoNCiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjMxMjIzMDE1MTMxLjI4MzYwOTAtMS1sYkBzZW1p
aGFsZi5jb20vDQo=

