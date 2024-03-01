Return-Path: <linux-kernel+bounces-88462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FC286E1ED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52CCC1C22D0D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F5C6A8B2;
	Fri,  1 Mar 2024 13:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=med.uni-goettingen.de header.i=@med.uni-goettingen.de header.b="Ps5nlape"
Received: from mail1.med.uni-goettingen.de (mail1.med.uni-goettingen.de [134.76.103.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D9769E1C
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.103.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709299449; cv=none; b=ClFTvPSJItqtCHXiFHkoluYr2h/HyDBQgoFOrX8MVS6Cojw0e7UY2WdZVnVrLiYSAoUI9Mi4+6+Sz1o6dfNptk3AYHKaeultDPJCVvkro+BiLb7oPrmi6eM1m8XquCv2nd1iI3xtkaLn9Bqfm5yAukCdcPAhdRL00VJzY6njoRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709299449; c=relaxed/simple;
	bh=mxWKJ8RTRnGA7eFG1tywu8YEdQFGZoDBTHm7fjuKdTU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fxPmZEFhT+LWIBYfY94tKN8aH0lPRXnv+XVuYfL4YHMg7dNx4SdHG26mkIoW/jz1hHjOXwjYbrmyXjbo8ib5LzVfy1AWulj3FbEoBT7+CeHmw0jO3D7y5mqAzpq9ium8V56t+5/SHafVczN/bVALz6AtFLOeLIHse5yMIK3pWmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=med.uni-goettingen.de; spf=pass smtp.mailfrom=med.uni-goettingen.de; dkim=pass (2048-bit key) header.d=med.uni-goettingen.de header.i=@med.uni-goettingen.de header.b=Ps5nlape; arc=none smtp.client-ip=134.76.103.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=med.uni-goettingen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=med.uni-goettingen.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=med.uni-goettingen.de; s=Mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:
	From:Sender:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mxWKJ8RTRnGA7eFG1tywu8YEdQFGZoDBTHm7fjuKdTU=; b=Ps5nlapeyCdeYTvUj3ICVS2vg5
	zdj8/b9anNyLt1UWZtGaovWMpHtFfgdPmNCqJqRUXKhG57Rb768EViLErecZeeXSJieDlSKZfVejD
	UZ6LUzCG5kmlo9ymfCYFTD2CHIFlJpPkW65Ols9p6b/SdLM59hzWfIxpmudRwSp25oS8U2cqZxf55
	MW/qxwmm9iMIIfGChqZCZsRMIapEdVadnTPb8Y6cvYipCrRD7nWJJTObvU7lDZUtBeGK0uqEIOzY0
	4tKRJqVJErlvoKVrNlpnlgCtLPkwhmT3t6OseyPy2JwzR6vBoldAejnT5pyNbd21rDTBHGUvjJwbL
	MYyjszAw==;
Received: from umg-exc-01.ads.local.med.uni-goettingen.de ([10.76.100.74]:29415)
	by mail1.med.uni-goettingen.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <Martin.Uecker@med.uni-goettingen.de>)
	id 1rg2pg-00032L-0c;
	Fri, 01 Mar 2024 14:21:48 +0100
Received: from umg-exc-01.ads.local.med.uni-goettingen.de (10.76.100.74) by
 umg-exc-01.ads.local.med.uni-goettingen.de (10.76.100.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 14:21:45 +0100
Received: from umg-exc-01.ads.local.med.uni-goettingen.de
 ([fe80::2886:b6b:10e3:deea]) by umg-exc-01.ads.local.med.uni-goettingen.de
 ([fe80::2886:b6b:10e3:deea%6]) with mapi id 15.01.2507.035; Fri, 1 Mar 2024
 14:21:45 +0100
From: "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>
To: "keescook@chromium.org" <keescook@chromium.org>,
	"linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
	"David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>
CC: "corbet@lwn.net" <corbet@lwn.net>, "miguel.ojeda.sandonis@gmail.com"
	<miguel.ojeda.sandonis@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "gustavoars@kernel.org" <gustavoars@kernel.org>,
	"ndesaulniers@google.com" <ndesaulniers@google.com>,
	"jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
	"ojeda@kernel.org" <ojeda@kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>
Subject: Re: [+externe Mail+] RE: [PATCH] compiler.h: Explain how
 __is_constexpr() works
Thread-Topic: [+externe Mail+] RE: [PATCH] compiler.h: Explain how
 __is_constexpr() works
Thread-Index: AQHaa7zea2tnGf5kn0G3mh48EMfk27EizpQA
Date: Fri, 1 Mar 2024 13:21:45 +0000
Message-ID: <22c9c4cc27b13b2fb6f3cd9fa6f827f56f30770b.camel@med.uni-goettingen.de>
References: <20240301044428.work.411-kees@kernel.org>
	 <af0eff12e6bc41039614add550406c11@AcuMS.aculab.com>
In-Reply-To: <af0eff12e6bc41039614add550406c11@AcuMS.aculab.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <935E7E0ABD95954982DB4A23C34DA0E8@med.uni-goettingen.de>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQpCVFcgbXkgbWFpbiBlbWFpbCBhZGRlc3MgaXMgbm93OiB1ZWNrZXJAdHVncmF6LmF0DQoNCk15
IHN1Z2dlc3Rpb24gd291bGQgYWxzbyB0byBsaW1pdCBleHBsYW5hdGlvbi4gTm9ib2R5IHNob3Vs
ZA0Kd3JpdGUgc3VjaCBjb2RlIGFuZCBpZiB5b3UgbmVlZCB0bywgeW91IGNhbiBmaW5kIGV4cGxh
bmF0aW9ucw0KYWxsIG92ZXIgdGhlIGludGVybmV0Lg0KDQpGaW5hbGx5LCBJIHN0aWxsIHRoaW5r
IHRoZSBtb3RpdmF0aW9uIGZvciB0aGlzIG1hY3JvIChyZW1vdmluZw0KVkxBcykgaXMgbWlzZ3Vp
ZGVkIGlmIHNlY3VyaXR5IGlzIHRoZSBnb2FsIGJlY2F1c2UgVkxBcyBwcm92aWRlDQpwcmVjaXNl
IGJvdW5kcyBhbmQgbGFyZ2VyIHdvcnN0LWNhc2UgZml4ZWQtc2l6ZSBhcnJheXMgZG8gbm90LiAg
wqANCg0KSXQgd291bGQgYmUgYmV0dGVyIHRvIHVzZSB0aGUgY29tcGlsZXIgb3B0aW9ucyB0aGF0
IGRldGVjdA0KcG9zc2libHkgdXNlIG9mIFZMQXMgb2YgdW5ib3VuZGVkIHNpemUgYW5kIGlmIHRo
ZXJlIGEgcHJvYmxlbXMNCndpdGggdGhpcywgaW1wcm92ZSB0aGlzIG9uIHRoZSBjb21waWxlciBz
aWRlLg0KDQpNYXJ0aW4NCg0KDQpBbSBGcmVpdGFnLCBkZW0gMDEuMDMuMjAyNCB1bSAwOTozMiAr
MDAwMCBzY2hyaWViIERhdmlkIExhaWdodDoNCj4gRnJvbTogS2VlcyBDb29rDQo+ID4gU2VudDog
MDEgTWFyY2ggMjAyNCAwNDo0NQ0KPiA+IFRvOiBSYXNtdXMgVmlsbGVtb2VzIDxsaW51eEByYXNt
dXN2aWxsZW1vZXMuZGs+DQo+ID4gDQo+ID4gVGhlIF9faXNfY29uc3RleHByKCkgbWFjcm8gaXMg
ZGFyayBtYWdpYy4gU2hlZCBzb21lIGxpZ2h0IG9uIGl0IHdpdGgNCj4gPiBhIGNvbW1lbnQgdG8g
ZXhwbGFpbiBob3cgYW5kIHdoeSBpdCB3b3Jrcy4NCj4gDQo+IEFsbCB0aGUgOHMgZG9uJ3QgaGVs
cC4uLg0KPiANCj4gSSBkb24ndCB0aGluayB5b3UgbmVlZCB0aGF0IG11Y2ggZXhwbGFuYXRpb24u
DQo+IA0KPiBQZXJoYXBzIGp1c3Qgc2F5aW5nIHRoYXQgdGhlIHR5cGUgb2YgPzogZGVwZW5kcyBv
biB0aGUgdHlwZXMNCj4gb2YgdGhlIHZhbHVlcyBhbmQgaXMgaW5kZXBlbmRlbnQgb2YgdGhlIGNv
bmRpdGlvbi4NCj4gVGhlIHR5cGUgb2YgKDAgPyAodm9pZCAqKXAgOiAoZm9vICopcSkgaXMgbm9y
bWFsbHkgJ3ZvaWQgKicNCj4gKHNvIHRoYXQgYm90aCB2YWx1ZXMgY2FuIGJlIGFzc2lnbmVkIHRv
IGl0KS4NCj4gQnV0IGlmICdwJyBpcyAnYW4gaW50ZWdlciBjb25zdGFudCBleHByZXNzaW9uIHdp
dGggdmFsdWUgMCcNCj4gdGhlbiAodm9pZCAqKXAgaXMgTlVMTCBhbmQgdGhlIHR5cGUgaXMgJ2Zv
byAqJy4NCj4gDQo+IFRoZSB0eXBlIGNhbiB0aGVuIGJlIGNoZWNrZWQgdG8gZmluZCBvdXQgaXQg
J3AnIGlzIGNvbnN0YW50IDAuDQo+IEEgbm9uLXplcm8gY29uc3RhbnQgJ3AnIGNhbiBiZSBtdWx0
aXBsZXMgYnkgMC4NCj4gDQo+IEkgbmVlZCB0byByZXBsYWNlIHRoZSBkZWZpbml0aW9uIHdpdGgg
KHRoZSBtb3JlIHBvcnRhYmxlKToNCj4gI2RlZmluZSBfX2lmX2NvbnN0ZXhwcihjb25kLCBpZl9j
b25zdCwgaWZfbm90X2NvbnN0KSBcDQo+IAlfR2VuZXJpYygwID8gKHZvaWQgKikoKGxvbmcpKGNv
bmQpICogMCkgOiAoY2hhciAqKTAsIFwNCj4gCQljaGFyICo6IChpZl9jb25zdCksIFwNCj4gCQl2
b2lkICo6IChpZl9ub3RfY29uc3QpKQ0KPiB3aGljaCBpcyBhcmd1YWJseSBsZXNzIGNyeXB0aWMu
DQo+IA0KPiAjZGVmaW5lIF9faXNfY29uc3RleHByKGNvbmQpIF9faWZfY29uc3RleHByKGNvbmQs
IDEsIDApDQo+IA0KPiBTbyB0aGF0IEkgY2FuIHdyaXRlOg0KPiAjZGVmaW5lIGlzX25vbl9uZWdf
Y29uc3QoeCkgKF9faWZfY29uc3RleHByKHgsIHggLCAtMSkgPj0gMCkNCj4gYW5kIGF2b2lkIHRo
ZSBjb21waWxlciBibGVhdGluZyBhYm91dCBzb21lIGNvbXBhcmlzb25zDQo+IGluIHVucmVhY2hh
YmxlIGNvZGUuDQo+IA0KPiAJRGF2aWQNCj4gDQo+IC0NCj4gUmVnaXN0ZXJlZCBBZGRyZXNzIExh
a2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQs
IFVLDQo+IFJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo+IA0KDQo=

