Return-Path: <linux-kernel+bounces-136242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F7489D1A5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967B61F24A72
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F91524AF;
	Tue,  9 Apr 2024 04:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="JcASuTYO"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2094.outbound.protection.outlook.com [40.107.215.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A578433C8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 04:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712638464; cv=fail; b=g+gWfXHEbltP5blpCgbUI/y0Rq57K+AqaH6Sly79TK4AOH/lqdmKQsX+5XzSlP+5Xr0L70dengUa4I01r8X9QjXyE7b5sPRS6RkMAR/cTxQE4wkn5f745IaXqVKn9klLXxAz1lmbbG/EPpfXzomOtS4RL1z95lBQA9XV4BALgFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712638464; c=relaxed/simple;
	bh=ULLD/Wx+zmQpMBj+d5HShFIJMyKS7trCtVko9IVLIvg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VopD5mtyhsJrewqRj5HYr2kTLHZLGKVaK4Kv0EghCVDpAs4J94n38QE21xLB473wCdSiq+SNydcXzzOLCskGK6YyTAkUYa9AoNvoQ4iL8Nw+O8MXY34C7uXtm/ED1SZvuUFCdEo/EGPFqd7WloubWGigfcZWg4C6LEYZCy5k8t8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=JcASuTYO; arc=fail smtp.client-ip=40.107.215.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoYqVUIhES1mRFNv4qqCmrayteYbDAN9GvS/BhHeYjCQSjkAB/aoxQ7s0GjLDpIEwFurVCxxGZy4tTk9fKxBoG/YxoV4csPReNsgQubP4VmDafTls7BjRUVNi2z2BPx2fayqP87QdzdRwOMd9EGlzdy2jPG/nModDJ3j+NSYA8UZhlX6jEzdiB012VOS4HbukghC8i0sA3B9MXZXbu5r8hLSXPuNOvwu/C5rDM1qxjxE9r7UWsP7rwhhvd+0mj0Pni+eSwOGpAsRrP2XgvKQlC4oGrRv7ucwIrm7f42LUFNAYVgXDEL/15ZfmJdCkHnDbv4P+OoECAh9bWfoMfEf1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULLD/Wx+zmQpMBj+d5HShFIJMyKS7trCtVko9IVLIvg=;
 b=Jt/x6Ct9teEKvpnglqDBcZKlONY365hcKkn7Y+LBmBDR5ijAumniJOvBm7jCcZ8PunhHzwMYKO9Yy6i8uoRyjV0Rz0V1UnZqjDU4kI9QsuCscwvaUHiS3VCvgFiEPmHX5JRO6Exe76+ajGE0JH9T55fizI3RfhhuzdaWJG28sPQxFVEy13yF9MKDmz+Bre2UEFZUJMGhoxZcr/bylbriP1lwURGRpI+ZkfPtKYsf/ubEKkFR8/MZlSlAibriKMOC15WkzJbAx1Xa/wH7TdOKSjK51eQwm3c2MU921cnHFDQjRKUtqmUbnRw3ozQIFkVti/pMnScDKDjR4nJgGHucbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULLD/Wx+zmQpMBj+d5HShFIJMyKS7trCtVko9IVLIvg=;
 b=JcASuTYOSXM8BMtIpFp52zJ6T4ZnofxlE8+ACrq8NSkuyTGGGWWusgEW34WEBBjE9vpT9MUEAGqs3F+TmmkwVuMJQKmJOyYLr65uHlQ6ZPG/UbUtd1VlhftbVyTxboUeqZ5m2NAgZbPNS5l7RlTiht5Za/+4eSUNsTT8+E9UZyU=
Received: from SEZPR02MB7164.apcprd02.prod.outlook.com (2603:1096:101:194::8)
 by SEZPR02MB7101.apcprd02.prod.outlook.com (2603:1096:101:195::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.41; Tue, 9 Apr
 2024 04:54:16 +0000
Received: from SEZPR02MB7164.apcprd02.prod.outlook.com
 ([fe80::5652:ff56:99db:8db1]) by SEZPR02MB7164.apcprd02.prod.outlook.com
 ([fe80::5652:ff56:99db:8db1%3]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 04:54:16 +0000
From: =?utf-8?B?5YiY5rW36b6ZKExhb0xpdSk=?= <liuhailong@oppo.com>
To: Oscar Salvador <osalvador@suse.de>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"nathan@kernel.org" <nathan@kernel.org>, "ndesaulniers@google.com"
	<ndesaulniers@google.com>, "trix@redhat.com" <trix@redhat.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "llvm@lists.linux.dev"
	<llvm@lists.linux.dev>, "surenb@google.com" <surenb@google.com>,
	"zhaoyang.huang@unisoc.com" <zhaoyang.huang@unisoc.com>,
	"quic_charante@quicinc.com" <quic_charante@quicinc.com>, "yuzhao@google.com"
	<yuzhao@google.com>
Subject: Re: [PATCH] mm: vmscan: do not skip CMA while LRU is full of CMA
 folios
Thread-Topic: [PATCH] mm: vmscan: do not skip CMA while LRU is full of CMA
 folios
Thread-Index: AQHaiYuRl0SECUJYB0aKbci+ca4YcLFeDTEAgAFTqYA=
Date: Tue, 9 Apr 2024 04:54:15 +0000
Message-ID: <e99fd119-c1a1-4d4d-9483-f7c4a4377441@oppo.com>
References: <20240408080539.14282-1-liuhailong@oppo.com>
 <ZhOtCtGBSCntUHvR@localhost.localdomain>
In-Reply-To: <ZhOtCtGBSCntUHvR@localhost.localdomain>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR02MB7164:EE_|SEZPR02MB7101:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 gRG7hoTl7Y6tMOZZ2rz4MZ/WJapQ0if/ajAbLEju9tF7XVlGiDz9X2C2K7DToA0EmaxmCSZhCWgqhDfIvhGLxbl8so/6Ts2js9qU9srYwEzaiAvayy3IPTEPTu2sv3+Tez3mq1hPmOo2DWY4obpOaKfzVH0RsuadADL/tjb65g149I28erJ8nRoEYlbuDyklPDgoqLFZ7CGmbZF3Ep2jPBoHZCMI13o7qG5UxW6He574SeY+7r9I+MWkhdcqOkgEQtJWobFz+KQqxvexSIM1JSDxDsFrGVFWqlIO6YNW4KvD/YXdK8PRZX52QPmqG+UAlqI1J+EgspnWUm5DgF4kgsN/NuFj+52rhMWZ2o2IgweCkcN4S22Ug434YfGJYk4hma29h5EPqswFhkX7lL4KyLD2gYjZSw+ziNp+fccPg2CsBQ/seBJZo7BzMSzOMLC8PlRXE46K1qAkZbc4UbTtwiZ407wx+7ITJACtnKYFgxTYej5N3ECX64lQL8gLyQAVZiw/OlTeSAxHtHPqHVVImEksg/ptkJ2fITdFAbS7SyOiLa4scQL7+vIiSjgyD/+mfe2w4zC59gLylMtX2UjjYFgI26ogp8Hjva8a4uu3NGEb/3jMooGUEpMSsbjcBgAuTvQEkwQzRK9eFlgxHkJq8HMZzTs5QmGHedU91qRU9+Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR02MB7164.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a095dWZBTkJEM1hRanRoZk8wY0hNYjkwSWFNUnpHOUtrSlhNL0phV09mdUZU?=
 =?utf-8?B?S214Qkxac3NPMVVaUEc4OExMNW9zWW5HQjI5aDdnV0tleFl1ODV5WCtidlNW?=
 =?utf-8?B?TFBsOTZsdzdsOUdvSkFuWWJlNno0cUNCcVVlMmJXMTAxSzhiSFNlcWlpV2s0?=
 =?utf-8?B?UnQzVUVvRjk0MENRUTZqeFQrQkUvNXZCVVJDc3E2dHJlaVdUZEdhdTVpczBI?=
 =?utf-8?B?SGc5YVJ6QjBLdzFyQ3I2bklsYlZDR0hyT0JxTGNGZUxKcWdXM01sTFJUZktY?=
 =?utf-8?B?ZzFYUmVjZjdFV1ZGMGViTWs0Tk1CS3lpbmlUVDNmL09rYVlzeHlwdGo4UWN1?=
 =?utf-8?B?Wk03ajNQdFMyTitVRm1SSkZjUEd0aDhMd1dGWE1DRENpWkhKdTY5b2RwVXNy?=
 =?utf-8?B?N1dZcmxHOCsvR25sbThBVzRFL1dxYkxxcU0rR29oQU1RQUVZbVVLR1RWS2FX?=
 =?utf-8?B?QWFRZkZlLzJZdERCeitVZWZEbW9HWmwyUk1xK3M1Mzk1VkZRNVBhYVdMdHpi?=
 =?utf-8?B?SlI3WjBLbVZpV1AxUTVtell3Sm5TOVc2Ti84aHhKTFVhM3lIUEVjZy9EdTRi?=
 =?utf-8?B?R1ZZNDFLTTNzZWhEdVc0VHdPY2xoU0gvREhCVm4xSEdpSmhoS3EySVEzSkN5?=
 =?utf-8?B?OXNuZGRRSEdtY1pTV0REK0VwZ012aTlsb3RLUUdxbm1aMTdYRllyTGJDbm1B?=
 =?utf-8?B?QlN6TTBpWkFLdTYwQUJSRDU1UzRhczdBTTg3Smd0eDNDYWh1TWpWL1NJTm9k?=
 =?utf-8?B?NzVtcjU2TWF0cldyVzlCUmdaNEhIVWR1a2hoVC9GMUNzektUYTJocjB1V2ky?=
 =?utf-8?B?Ym9QR0RlSWJHeHhXV0hVNWs5NlJMSmlQTlZaenFxUFJ4THhUWHcvQmlianhH?=
 =?utf-8?B?RXhOYjhZdjVTOEowaFZIN3MxYlhBNVVHYml6ZE8zRUhZRGlJdFFPNUYvZ20z?=
 =?utf-8?B?UUJBR2tZM0lIdldJcW92a1FQRWNVVUo3UFlQREE1RTBwSUd4TjhRL0dPa29t?=
 =?utf-8?B?dkVvTG9xY0ZpK2I1UkVkYlFuOTJHeHNhcUwxRDBhVmxnbXorYVlNMmdqb08x?=
 =?utf-8?B?UFF1ckJmUmJLU3pyY2JXdHdDSFZMNU1xcDVMdlZtOGR3dk1RcmNLSlIwWXVB?=
 =?utf-8?B?U1VFRkNWOUo4Ym1Kd0E3dUFsTVRkM2xPcTJCZ01YY1U1d2hMRHNxV3d5OWYw?=
 =?utf-8?B?U3V4MUdIanNOM3NmVm9ZMy9uWmtpaHkyeTdWOHJKdk1tU3JQVFhMQktObkVa?=
 =?utf-8?B?WUY3NWE2SGQ1VHVFVHI1aWJ5WGdDMXQyeDlEV0RJcExXdEdUbWlvdGFlRjFP?=
 =?utf-8?B?Nzk3d1NXYWl2VHNURjNqNWJDd0ttZmIxWCtLMi9qbXBybVBMK0tQeWVUcGlw?=
 =?utf-8?B?L1FMWWhQM3kyVW1Gc3BXZk1QTURaYmUwUG0rOEJmSUoyYkk5UEd3RnYvSmFX?=
 =?utf-8?B?SXlhQzJqb1g1QmxxZDVkdHpmcjlFdlhZSm5xblI5MlVqaCtEbkFHdW8yTnBq?=
 =?utf-8?B?TVltekdubE1JT1RJemVoamYrMlV6SHpMZVNWL25WZFBQRHFtTXdkQkowc21a?=
 =?utf-8?B?SDlta2owQzFVUEE3aVNlbVltNTJHUVJ3VEpVSHdiOGhFUFI2SmtSSi9ZTnIv?=
 =?utf-8?B?d2RhQWY3V09YRHRRMnpPelhlUlE5NmJaWk9Ya21HZmdCMjhVaEJFMElhTk1F?=
 =?utf-8?B?ZC9vSGFzbzg1YTA4MGVnUzBqTHdwOTlUUmFYTzRqT2hhSmVPRjlXUmdwS3lI?=
 =?utf-8?B?RzBNMnNUWGxyUEdMdlBHZjNib1E1WHZoM2kzSkRJWU15VFFuYXJQY2IveE15?=
 =?utf-8?B?cGM1WU5sU1gwaDMyWWdqLzR0UGYzb2wzTFp0a01kelhkck9JdGQvaTl1a2lR?=
 =?utf-8?B?Q24vOU5MUThHMk0wQXh4eEJ1R05WbkZoV1BoMWpsbG9QYTh0NERqclB1NXhW?=
 =?utf-8?B?Q0UxREZuZEhrMklvTHJ4VFJqZ3ZGeXFRM0RtT2tzVjNkdlFyNHR0d0R6S2FO?=
 =?utf-8?B?ajJaQVV1NXg4b1JtM1krb3g3Y0dMRFZJV2dqNFF1WUZSdCtlSUhkeVdHWFBL?=
 =?utf-8?B?eE8rUXJ4VkRxNHBGY2FxSXZ4MjREYURwaDl0RW5Lb2o0ZFJsQUVXV1pJU3Y0?=
 =?utf-8?Q?wCWUsm6ek2nvzRnTVfiqd0Rpv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C9C075A8D84EF49885FC373115E0659@apcprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB7164.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9057b52-8fee-4b97-9d24-08dc58511b94
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 04:54:15.7698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x7H7QlfWEpiv9mdZHFVVV6KO7jvrPr28FdxKs9gP7MXQfmxAFSzmIzbBkZINYVO/Wz4kgWi+lTjF4IK7Enh4xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB7101

T24gMjAyNC80LzggMTY6MzgsIE9zY2FyIFNhbHZhZG9yIHdyb3RlOg0KPiBPbiBNb24sIEFwciAw
OCwgMjAyNCBhdCAwNDowNTozOVBNICswODAwLCBsaXVoYWlsb25nQG9wcG8uY29tIHdyb3RlOg0K
Pj4gRnJvbTogbGl1aGFpbG9uZyA8bGl1aGFpbG9uZ0BvcHBvLmNvbT4NCj4+IEBAIC02MjAyLDYg
KzYyMTMsMTYgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgZG9fdHJ5X3RvX2ZyZWVfcGFnZXMoc3Ry
dWN0IHpvbmVsaXN0ICp6b25lbGlzdCwNCj4+ICAJCSAqLw0KPj4gIAkJaWYgKHNjLT5wcmlvcml0
eSA8IERFRl9QUklPUklUWSAtIDIpDQo+PiAgCQkJc2MtPm1heV93cml0ZXBhZ2UgPSAxOw0KPj4g
Kw0KPj4gKwkJLyoNCj4+ICsJCSAqIElmIHdlJ3JlIGdldHRpbmcgdHJvdWJsZSByZWNsYWltaW5n
IG5vbi1jbWEgcGFnZXMgYW5kDQo+PiArCQkgKiBjdXJyZW50bHkgYSBzdWJzdGFudGlhbCBudW1i
ZXIgb2YgQ01BIHBhZ2VzIG9uIExSVSwNCj4gInNpdCBvbiBMUlUiID8NCkdvdCBpdCwgVGhhbmtz
DQo+IA0KPj4gKwkJICogc3RhcnQgcmVjbGFpbWluZyBjbWEgcGFnZXMgdG8gYWxsZXZpYXRlIG90
aGVyIHRocmVhZHMNCj4+ICsJCSAqIGFuZCBkZWNyZWFzZSBscnUgc2l6ZS4NCj4+ICsJCSAqLw0K
Pj4gKwkJaWYgKHNjLT5wcmlvcml0eSA8IERFRl9QUklPUklUWSAtIDIgJiYNCj4+ICsJCSAgICBz
Yy0+bnJfc2Nhbm5lZCA8IChzYy0+bnJfc2tpcHBlZF9jbWEgPj4gMykpDQo+IA0KPiBXaHkgInNj
LT5ucl9za2lwcGVkX2NtYSA+PiAzIj8gSXQgZmVlbHMgYSBiaXQgaGFyZGNvZGVkLg0KPiBNYXli
ZSB0aGUgY29tbWVudCBvciB0aGUgY2hhbmdlbG9nIHNob3VsZCBjb250YWluIGEgcmVmZXJlbmNl
IGFib3V0IHdoeQ0KPiB0aGlzICIvOCIgd2FzIGEgZ29vZCBjaG9pY2UuDQoNCldoZW4gdGhlIG51
bWJlciBvZiBza2lwcGVkIENNQSBhZ2VzIGV4Y2VlZHMgZWlnaHQgdGltZXMgdGhlIG51bWJlciBv
Zg0Kc2Nhbm5lZCBwYWdlcywgaXQgaW5kaWNhdGVzIHRoYXQgQ01BIHBhZ2VzIGNvbnN0aXR1dGUg
dGhlIG1ham9yaXR5DQpvZiB0aGUgTFJVIHBhZ2VzLiBTZXR0aW5nIHRoZSB2YWx1ZSB0b28gbG93
IG1heSByZXN1bHQgaW4gcHJlbWF0dXJlDQpyZWNsYW1hdGlvbiBvZiBDTUEgcGFnZXMsIHdoaWNo
IGFyZSB1bm5lY2Vzc2FyeSBmb3Igbm9uLW1vdmFibGUNCmFsbG9jYXRpb25zLiBDb252ZXJzZWx5
LCBzZXR0aW5nIGl0IHRvbyBoaWdoIG1heSBkZWxheSBwcm9ibGVtIGRldGVjdGlvbg0KdW50aWwg
bXVjaCBsYXRlciwgd2FzdGluZyBDUFUgdGltZSBpbiBpZGxlIGxvb3BzLg0KDQpCcnMsDQpIYWls
b25nLg0K

