Return-Path: <linux-kernel+bounces-81277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DF2867343
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F9E282EBE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8286D4EB2F;
	Mon, 26 Feb 2024 11:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="TVWGoMnZ"
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2119.outbound.protection.outlook.com [40.107.12.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4864E1D3;
	Mon, 26 Feb 2024 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.12.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947296; cv=fail; b=W+R7Ijtw2FH21mNFRb282ubOtTV73MU6MFWf+X3y3BAGKJX4DQW040H/4+7dHoMUHVwcEoxKIeKpsgXkSkXxXMWTzI5Ol5TPqTLSIOeO0DhrEeDW69Q2JNDyny16WjiSH7+6w7tcq/TdwLGeid2tp41TeDt5t4m3VuohpIFxiqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947296; c=relaxed/simple;
	bh=HTJiVjoIu07ATIjj8vQiyB9PECeC6eFYffmFJa+A3Zg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RSZBJoJbiFcR2viAWF54lAHNm7j253ny2p5MAIqu7TBKJ/kF6BeGvkqjXoNcxmM0iL1BE4VNK1LmxQHRDcDsh1PEkp5LHJRhUpBASNimYzSTrJLFpbaPyy/wRrQeIT1NBh/pOTl3YYSD7SgMN/oY/vvIkjToPXUvNEWR8bYdQ6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=TVWGoMnZ; arc=fail smtp.client-ip=40.107.12.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTwQk+DknJ/oDV5RJS0ivy/S0QrmTdXjQUMXpPgQyO87+k9kr56eQXpZkvpMnTBgs6ySPOek6rULc6FJ86Qm5vmheRKZhGJvUTYuOe0BpoxV1ynyuGBrchjxfeu3ePgtNjWlDzdiWDql5T0hW8DY1/Qgwyx8ua9V3erooZ9i+DtNGv65NpPOA42nhKAQrBoa/FHi/Mz8erJqrHtERchdFkmxbTy7/jDGmqz3pCvm+oyomd7vJv+q3fVicxQSZX0wv+iR94aqareIeho4dQV5K3tOrTvHOyH2gX+Rqe7443nkQ6moBuwncTAESbCpIsObVoGxm9hUo4LwCw63AEcSvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTJiVjoIu07ATIjj8vQiyB9PECeC6eFYffmFJa+A3Zg=;
 b=OL02PJodJxK3pn6LTLRZ2AEocKW2y7CATjkiggErXpzTiNrA8o+vVfbeMk5O/c2oHGG/oi0LqTukXtHdWTuq4E/JVOuORAk1r2zxb1RbMEI7h3prwB61jvNZtIPJLIBNGNsSWqHIZMMGhuaEMK7UZ7SQhaum9oc/PeZsJH5LCAeRf2NAH9dRwDmdwsG6O8pTEwS5WQcO0TlSXzI3hPd5QFh7Xi8WY03IQeSmVgnLcTi+iRILs2TMOSJuPvk4qy4YexYiV7bUZ6fBvMwdho7GPyxw65gziRnACa0rkhnh3C7muTJMd47wVcJoaqowC42axXg0QYME9nrPCLJb8ceNWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTJiVjoIu07ATIjj8vQiyB9PECeC6eFYffmFJa+A3Zg=;
 b=TVWGoMnZWLQ+7O84Seq4JT280PAN0tIM6FnnswyLXM2DQ8OzTdbIty2MRmOn2GPGes/hkEgs4t9VWFqYv8wEiLdFUbcd7IMgOUswQafpoClAtp/gUioI+YiZzcslJSkM6jvX+ZfC9ZyCDy1LEPQjeChZp4jIwvn8yCvl66Q4Yq+eYq3oj7XHagrtsPaUZVKhecpg7gM0dIm1/1bSvtNnda6tTfVZVuUt5FfAy+i03ySNgE7SCxyA95gdR5LnXGtXpEzAtLaQzGCcgp478C0FWIg9erK+WSKiIFGYC/J+5qWcioEGUx3V5C8dHtRRaHNdusIyBNSbPWymG5LCh4A7Rw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB1603.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.36; Mon, 26 Feb 2024 11:34:51 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7316.035; Mon, 26 Feb 2024
 11:34:51 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Charlie Jenkins <charlie@rivosinc.com>, Guenter Roeck
	<linux@roeck-us.net>, David Laight <David.Laight@aculab.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, Helge Deller
	<deller@gmx.de>, "James E.J. Bottomley"
	<James.Bottomley@hansenpartnership.com>, Parisc List
	<linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Palmer
 Dabbelt <palmer@rivosinc.com>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Topic: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Index: AQHaZqVM7f0VA9oidkaHzRbh3i5s67EcglMA
Date: Mon, 26 Feb 2024 11:34:51 +0000
Message-ID: <7ae930a7-3b10-4470-94ee-89cb650b3349@csgroup.eu>
References:
 <20240223-fix_sparse_errors_checksum_tests-v10-1-b6a45914b7d8@rivosinc.com>
In-Reply-To:
 <20240223-fix_sparse_errors_checksum_tests-v10-1-b6a45914b7d8@rivosinc.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB1603:EE_
x-ms-office365-filtering-correlation-id: 110968ef-48a6-4e7f-425e-08dc36bef203
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 K75/xKxFaO+c5GpnhBweR65C4tiYLkgw1T7ihJ3pEbqJr0SpF5XUMz0Si20k+jKNLKpEKhep3L69O2+FIrFQZiNPmAH2TDgwYfEN4tCfJLtimm0G2C9miydQpvP15ecjnRcijhW2ky4UW1Lxdu128HXLfP93wJhMyzoxYh/NASjr1YeZrbivFYr+mHXn+9tPZ52qcV2zicrpnLCpIeXVOqcAa4LGi2Cx7K+RPz+HgJ7MEGFbQRODg8RlQVEL0oIIJy+Nv6N6Z1WUP9X678S8KeDkFsadI2tR/asJID43F2pflFdcW4TbNQj7M/0S6lZup9Uk1AK5GDvCWpAznWzdm5vKSzQ3paFE9sgt5ItUmleDJSMeu+iueFhoAiiHP58Fkgxy7UmK1pmBrt3mWX6wGzESGjHaeHGbS0xXWRm7s26kUNzLRGTu04/tZKtye+2r2tvP0N9aFUYebLqo31z3YnGnZXM6luIWXeDIwn2WSnjHtxkveLiwIb4b/5+b80jeSSFO7S+yUIMKP9Dp0y03KUrKJIhcnLSu+toMVIVuxpHfyVoBQLuHbPsMeyNHMMjbXf80SGVWUrA7w5eQvG7VgbvnjlVY8a4UqqSwM1kHpwe5PzUYdSAC9KLAUBSpkeJU10N3XGQjv38qKE7L33EXb6tUkkzDvXPkDTxn+ggVgXhpy7GQYCkOrh7rZhjuy/alSVus4b31jx9SqrOX+pbPhCF32r56d0HovVdQptikyiU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUxsNFJua1c5RjRkSWZhZzNvTnAxdWVTL2NkdXJ2SlJ4TnBzTDhVeHF5a242?=
 =?utf-8?B?RWptZUFESXJCaXVlU3dzVkw3bmZKOHl3MVEvY2hMMld6MTI4TU1XRHdoanRN?=
 =?utf-8?B?VWwxSEg0WmVybDBpODN3ZlJBUkZ4K2x0bUlSK1JHbU9JRlV3WDYwbzdWOU92?=
 =?utf-8?B?ejQxcHRrZTlDaHhMNUFKRWMySmpvODhneW4zem56TVU5SEh0clA5WWlheDBC?=
 =?utf-8?B?dzBoaGk2Mys5amJNWDlMOWMrMWdWSm50VnBjMVNUZW5VWEZKNDkwa1lnVGVj?=
 =?utf-8?B?YVVRRC8rUkxoMklYcGRERW5pNnU3VnphMXVDb2ZBVVlPUFVjMUFBZjd2VjJr?=
 =?utf-8?B?b0VjYlZrakdqV0EzS3pYMERDWnlpcEhRMkpUVVRVT3lkUGdxMFdDMFlCZi96?=
 =?utf-8?B?NEhFek84MHBCZmovU3RvaHlLL2xtUjlKRmdMV2d4RjBwREFFUWVoN05MdlNV?=
 =?utf-8?B?OTdaNFFNTnFuTGtPaytybW0wemJCNERIR3h2bXhTdGhTQW9xTUE3NkZ0Q2ZU?=
 =?utf-8?B?OWZaa0QwajNnaURpbHNvNnIzUmZrMUg3V2gyTURCQjVkNEcyQkYzSlJSazVw?=
 =?utf-8?B?MVBXS1NiYU9QL3pZZFdvYkhQeTF2ZC85T1J0eFlrRjZGRnhVVEoxZmR6VDhQ?=
 =?utf-8?B?blpsWXNIdlQxT2JzcGx0MUFxZDc2SFQ5WGQ5Y1FSdWVsTmlCTllDVXF6S2lD?=
 =?utf-8?B?WTFhMmQxNDBtV2hjUWFZYm1TNDdtTWx3RGc1bGFVQjVsZllKVnVSeTcyVDF4?=
 =?utf-8?B?dWo4RjlHMjVicndIV1VtSUNDOE5rRVQ4dHQ2TkpjWUZobHMzZlNGcXZnaGRV?=
 =?utf-8?B?Z2h0SFdCVE96ajRkeXZMZ0ZrMGZuVDQxQkw1R2poMlN1dXR0bnRtNTg4NUJT?=
 =?utf-8?B?K1pOc2piTHYwL0QwNDRQUy9kU0NkY1ZvOU1hUk1ocTZGdVZLL094bS85NXBY?=
 =?utf-8?B?SlhmdTkwZlQ4TVNlWGR3OTNUMW84V21qQlo3VitqVDZ2SlZYSzZ5YmZNMWpt?=
 =?utf-8?B?QTBIZHROUWN3MlhuNWRmcnBRaDUvVElzcGpSQnZ2dmVBWFdtQzVMVDRlc0VN?=
 =?utf-8?B?TEpZQjNqK2g4aTloUVp6dkRmdGFWeU9wa3l6N1o0WTh3ODNseWRadGlnSTR0?=
 =?utf-8?B?RytkMXR2U1d1ZDdGelRPK2VPN0xZOEgxNXBQV1g5Y1VLeXdWVFh0SVM0c2VG?=
 =?utf-8?B?L0tWRGdXSzBBWWlKOEk3a3FBbmQzWGFpcTdIY3FwZ0RqekNwbEVLWHFTYndW?=
 =?utf-8?B?TmNwV21STnJKV2czZ3AwbnE5clhId3p6RzIwTEpuaWlCYUk5UXVzdnN5d242?=
 =?utf-8?B?aEx3Rm4xNGRUTW81ajNYMDBjM2xsb3I3azYzQ2d3YzhialF5ZGJxekFJMTZj?=
 =?utf-8?B?MERyMVl5eC9BRWhnL2lwNDQzM3VteExIZTJPVVJXVVBDbHhWWkJ0YWs4WDdK?=
 =?utf-8?B?eThQWjBOWFZtWWU4Y2JYbXdTZm8yQ3dodklWLyttTVVaZVA3ZVZhTk4xKzlM?=
 =?utf-8?B?ZU1hcVNhUFJBem9nQWo4Uyt6QkZHa3ducEx0S3luK0VjZVpGSHlVM3N5SzM0?=
 =?utf-8?B?Y2lwYWtOcWl0TlpwbURaTklRR0IvejgvcmN4SmV3YWRLS092aUtLTTFBbktR?=
 =?utf-8?B?dndYeTcxTktYQ3ZkVXlvWXBzL21kSFh5K1NINGdRMGJoWHowdTBlRTVQTnpm?=
 =?utf-8?B?d2duRUZHSTFUQ0ZLUHpOZml6ai9WVkxaU2lPWlN4Z2ZiRGYrbVJRODJ6ZW1l?=
 =?utf-8?B?eVJYZ1JoWGVlMTJJVzBzS2xPV1k3clRxcDVNYTRvTWg0MHk5aGhrUDYvOCs1?=
 =?utf-8?B?by9CamFBL2NranI2NnAwdWZ0dkQydDdCSW93QmdldTVOM0ZiclN4V3hsS2l2?=
 =?utf-8?B?dTlobGJscnBaYnNZREpGeFZRVC9URGg5SEJxQjlZVVBxdzYrR0xra3o0QnRH?=
 =?utf-8?B?ZHZVSVVlUHFvWHp3NnBUM2swOXAxVE8vbUE0N0hDdlQybUk3WFFGY3EyMGMy?=
 =?utf-8?B?U1VmNXIycUxMeG0rUDMxMFdVenVTeVU0c3ZuZUZBOHNRMlcwVFU5cEhyU1JH?=
 =?utf-8?B?U05SaXg4L3FhN0ErSWcrNlN4bHZtVW9WTXdSbUxXUjhFMTVzZEZFb1orN1gv?=
 =?utf-8?Q?XJNogx9Bahl/5qXxhdj1P3thW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CBFA37952EBD44BAEDD15FFE55B4A1E@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 110968ef-48a6-4e7f-425e-08dc36bef203
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 11:34:51.1218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qpf5rsrxyakN1OBenh3RfJ8VuQcG8z0UDI1pt6WuRxiECOn+xgV4OejPSIj1lQQKu0tSrGj8KsvaDuQAGjAD3r1tDYFah8L2nTBjtQ4yGSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1603

DQoNCkxlIDIzLzAyLzIwMjQgw6AgMjM6MTEsIENoYXJsaWUgSmVua2lucyBhIMOpY3JpdMKgOg0K
PiBUaGUgdGVzdCBjYXNlcyBmb3IgaXBfZmFzdF9jc3VtIGFuZCBjc3VtX2lwdjZfbWFnaWMgd2Vy
ZSBub3QgcHJvcGVybHkNCj4gYWxpZ25pbmcgdGhlIElQIGhlYWRlciwgd2hpY2ggd2VyZSBjYXVz
aW5nIGZhaWx1cmVzIG9uIGFyY2hpdGVjdHVyZXMNCj4gdGhhdCBkbyBub3Qgc3VwcG9ydCBtaXNh
bGlnbmVkIGFjY2Vzc2VzIGxpa2Ugc29tZSBBUk0gcGxhdGZvcm1zLiBUbw0KPiBzb2x2ZSB0aGlz
LCBhbGlnbiB0aGUgZGF0YSBhbG9uZyAoMTQgKyBORVRfSVBfQUxJR04pIGJ5dGVzIHdoaWNoIGlz
IHRoZQ0KPiBzdGFuZGFyZCBhbGlnbm1lbnQgb2YgYW4gSVAgaGVhZGVyIGFuZCBtdXN0IGJlIHN1
cHBvcnRlZCBieSB0aGUNCj4gYXJjaGl0ZWN0dXJlLg0KDQpJJ20gc3RpbGwgd29uZGVyaW5nIHdo
YXQgd2UgYXJlIHJlYWxseSB0cnlpbmcgdG8gZml4IGhlcmUuDQoNCkFsbCBvdGhlciB0ZXN0cyBh
cmUgZXhwbGljaXRlbHkgdGVzdGluZyB0aGF0IGl0IHdvcmtzIHdpdGggYW55IGFsaWdubWVudC4N
Cg0KU2hvdWxkbid0IGlwX2Zhc3RfY3N1bSgpIGFuZCBjc3VtX2lwdjZfbWFnaWMoKSB3b3JrIGZv
ciBhbnkgYWxpZ25tZW50IGFzIA0Kd2VsbCA/IEkgd291bGQgZXhwZWN0IGl0LCBJIHNlZSBubyBj
b21tZW50IGluIGFybSBjb2RlIHdoaWNoIGV4cGxpY2l0cyANCnRoYXQgYXNzdW1wdGlvbiBhcm91
bmQgdGhvc2UgZnVuY3Rpb25zLg0KDQpJc24ndCB0aGUgcHJvYmxlbSBvbmx5IHRoZSBmb2xsb3dp
bmcgbGluZSwgYmVjYXVzZSBjc3VtX29mZnNldCBpcyANCnVuYWxpZ25lZCA/DQoNCmNzdW0gPSAq
KF9fd3N1bSAqKShyYW5kb21fYnVmICsgaSArIGNzdW1fb2Zmc2V0KTsNCg0KT3RoZXJ3aXNlLCBp
ZiB0aGVyZSByZWFsbHkgaXMgYW4gYWxpZ25tZW50IGlzc3VlIGZvciB0aGUgSVB2NiBzb3VyY2Ug
b3IgDQpkZXN0aW5hdGlvbiBhZGRyZXNzLCBpc24ndCBpdCBlbm91Z2ggdG8gcGVyZm9ybSBhIDMy
IGJpdHMgYWxpZ25tZW50ID8NCg0KSSBndWVzcyB3ZSBzaG91bGQgaW52b2x2ZSBBUk0gcGVvcGxl
IGluIHRoaXMgZGlzY3Vzc2lvbi4NCg0KQ2hyaXN0b3BoZQ0K

