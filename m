Return-Path: <linux-kernel+bounces-88523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F34B886E2D5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62E68B227A0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53CC6EB79;
	Fri,  1 Mar 2024 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=med.uni-goettingen.de header.i=@med.uni-goettingen.de header.b="dOSDBgHj"
Received: from mail1.med.uni-goettingen.de (mail1.med.uni-goettingen.de [134.76.103.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256676EB65
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.103.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709301401; cv=none; b=qnittflk2eMBabU3/E6bY++2cPFugCmLMtIEn5hx1rl90aWSIwbSqITCXx4Gaf2jS7mzxspcrOAnTGLNxCx0LQmUlF+k4kBZ+puK+sSKnCVi9G1RPLrRolf0wcf6QC22kQuxX6rjDWBF/wgKQyAIZRcFyrDkcMc3RkrMAOEIQEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709301401; c=relaxed/simple;
	bh=aSAZ9IvItWkzqGAhdfq95ly+QFvNX0+jk/v2bNT5oUE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KP1PCWQK9CB4eQrEBow3m2ypQ8CzwxPOSPo8LbLkQaKmEWUPbGL6wh+HF/7YZg1eCVw39WUVzHZEASLOKBCo8msXRioCRAH2KDhDSWPh14uvK2FFfNxMzMwK0UpvFYcYrcbGfki7hEDVFtgHzJgo4LHh60stX8J1h0Qqx88lA/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=med.uni-goettingen.de; spf=pass smtp.mailfrom=med.uni-goettingen.de; dkim=pass (2048-bit key) header.d=med.uni-goettingen.de header.i=@med.uni-goettingen.de header.b=dOSDBgHj; arc=none smtp.client-ip=134.76.103.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=med.uni-goettingen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=med.uni-goettingen.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=med.uni-goettingen.de; s=Mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:
	From:Sender:Reply-To:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aSAZ9IvItWkzqGAhdfq95ly+QFvNX0+jk/v2bNT5oUE=; b=dOSDBgHjNX0tgd7KpIPWiFd0nk
	7oOt0fA30HhqWhVBex4zY9xNFnn5ENtnpZ1JMr6pQn+YKwCPIeZpflwcoR3jBa0RGkRPrI+Qt9xDu
	yqpzvFwoJv25r6TEOgPnzrG/VuMpryMT7ublMLS/Jm1GAFMPwWL1ZvQMHdDc51nw23Lens2gCEQzS
	bXJLJHqdpqA75v62bpXGG7tQJBDgz4v0t2KQGzurW39FSXA6fz9CSabWnDq4I1hq9S4BsK7fI/Wj8
	eubWpMCygkjPsXRAJ/UNLxv8r5nao+eEjU5F8SoD61NgwQulNp1NiJou7KhuR1prh9NZnB/kFi+FM
	O5osLPQg==;
Received: from umg-exc-02.ads.local.med.uni-goettingen.de ([10.76.100.75]:6494)
	by mail1.med.uni-goettingen.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <Martin.Uecker@med.uni-goettingen.de>)
	id 1rg3NL-0002aq-1z;
	Fri, 01 Mar 2024 14:56:35 +0100
Received: from umg-exc-01.ads.local.med.uni-goettingen.de (10.76.100.74) by
 umg-exc-02.ads.local.med.uni-goettingen.de (10.76.100.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 14:56:32 +0100
Received: from umg-exc-01.ads.local.med.uni-goettingen.de
 ([fe80::2886:b6b:10e3:deea]) by umg-exc-01.ads.local.med.uni-goettingen.de
 ([fe80::2886:b6b:10e3:deea%6]) with mapi id 15.01.2507.035; Fri, 1 Mar 2024
 14:56:32 +0100
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
Thread-Index: AQHaa7zea2tnGf5kn0G3mh48EMfk27EizpQAgAAGCoCAAAOvAA==
Date: Fri, 1 Mar 2024 13:56:32 +0000
Message-ID: <c018bb116dc77c952283e0e6c66b9be0bfa07b0e.camel@med.uni-goettingen.de>
References: <20240301044428.work.411-kees@kernel.org>
	 <af0eff12e6bc41039614add550406c11@AcuMS.aculab.com>
	 <22c9c4cc27b13b2fb6f3cd9fa6f827f56f30770b.camel@med.uni-goettingen.de>
	 <9c4518eae05c4758afe08c6b90678e92@AcuMS.aculab.com>
In-Reply-To: <9c4518eae05c4758afe08c6b90678e92@AcuMS.aculab.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <48E42B31D70269458C6C3D465222065F@med.uni-goettingen.de>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

QW0gRnJlaXRhZywgZGVtIDAxLjAzLjIwMjQgdW0gMTM6NDMgKzAwMDAgc2NocmllYiBEYXZpZCBM
YWlnaHQ6DQo+IEZyb206IFVlY2tlciwgTWFydGluDQo+ID4gU2VudDogMDEgTWFyY2ggMjAyNCAx
MzoyMg0KPiA+IA0KPiA+IE15IHN1Z2dlc3Rpb24gd291bGQgYWxzbyB0byBsaW1pdCBleHBsYW5h
dGlvbi4gTm9ib2R5IHNob3VsZA0KPiA+IHdyaXRlIHN1Y2ggY29kZSBhbmQgaWYgeW91IG5lZWQg
dG8sIHlvdSBjYW4gZmluZCBleHBsYW5hdGlvbnMNCj4gPiBhbGwgb3ZlciB0aGUgaW50ZXJuZXQu
DQo+ID4gDQo+ID4gRmluYWxseSwgSSBzdGlsbCB0aGluayB0aGUgbW90aXZhdGlvbiBmb3IgdGhp
cyBtYWNybyAocmVtb3ZpbmcNCj4gPiBWTEFzKSBpcyBtaXNndWlkZWQgaWYgc2VjdXJpdHkgaXMg
dGhlIGdvYWwgYmVjYXVzZSBWTEFzIHByb3ZpZGUNCj4gPiBwcmVjaXNlIGJvdW5kcyBhbmQgbGFy
Z2VyIHdvcnN0LWNhc2UgZml4ZWQtc2l6ZSBhcnJheXMgZG8gbm90Lg0KPiA+IA0KPiA+IEl0IHdv
dWxkIGJlIGJldHRlciB0byB1c2UgdGhlIGNvbXBpbGVyIG9wdGlvbnMgdGhhdCBkZXRlY3QNCj4g
PiBwb3NzaWJseSB1c2Ugb2YgVkxBcyBvZiB1bmJvdW5kZWQgc2l6ZSBhbmQgaWYgdGhlcmUgYSBw
cm9ibGVtcw0KPiA+IHdpdGggdGhpcywgaW1wcm92ZSB0aGlzIG9uIHRoZSBjb21waWxlciBzaWRl
Lg0KPiANCj4gSW4ga2VybmVsIGNvZGUgKHdpdGggbGltaXRlZCBzdGFjaykgdGhlcmUgaGFzIHRv
IGJlIGVub3VnaCByb29tDQo+IGZvciB0aGUgbGFyZ2VzdCBwb3NzaWJsZSAnVkxBJyBzbyB5b3Ug
bWlnaHQgYXMgd2VsbCBhbGxvY2F0ZSBvbmUuDQo+IA0KPiBBbGxvd2luZyBWTEEgYWxzbyBtYWtl
cyBpdCBwcmV0dHkgbXVjaCBpbXBvc3NpYmxlIHRvIGRvIGFueQ0KPiBraW5kIG9mIHN0YXRpYyBz
dGFjayB1c2UgYW5hbHlzaXMuDQoNCklmIHlvdSBsaW1pdCBWTEFzIHRvIGEgY2VydGFpbiBtYXhp
bXVtIHNpemUsIHRoZW4geW91IGNvdWxkIHVzZQ0KdGhpcyBmb3IgYW5hbHlzaXMgYW5kIGl0IHdv
dWxkIG5vdCBiZSB3b3JzZSB0aGFuIHVzaW5nIHdvcnN0IGNhc2UNCmZpeGVkLXNpemUgYXJyYXkg
b24gdGhlIHN0YWNrLiBCdXQgeW91IGNhbiBhbHNvIHVzZSB0aGUgKnByZWNpc2UqDQpydW4tdGlt
ZSBib3VuZCBvZiB0aGUgVkxBIGlmIHlvdXIgc3RhdGljIGFuYWx5c2lzIGlzIHNtYXJ0IGVub3Vn
aC4NCllvdSBjYW4gYWxzbyB1c2UgdGhlIHByZWNpc2UgcnVuLXRpbWUgYm91bmQgZm9yIHJ1bi10
aW1lIGJvdW5kcw0KY2hlY2tpbmcuIEl0IGlzIHN0cmljdGx5IG1vcmUgZXhwcmVzc2l2ZSB0byB1
c2UgVkxBcyAob3IgZGVwZW5kZW50DQp0eXBlcyBpbiBnZW5lcmFsKSBhbmQgdGhlcmVmb3IgKmdv
b2QqIGZvciBzdGF0aWMgYW5hbHlzaXMuDQoNCj4gVGhlIGZpbmUgSUJUIHRhZ3MgY2FuIGJlIHVz
ZWQgaWRlbnRpZnkgdmFsaWQgaW5kaXJlY3QgY2FsbHMNCj4gd2hpY2ggcHJldHR5IG11Y2ggb25s
eSBsZWF2ZXMgcmVjdXJzaW9uIHN0b3BwaW5nIGZ1bGwgc3RhdGljDQo+IHN0YWNrIGFuYWx5c2lz
IC0gYW5kIHRoYXQgY291bGQgYmUgYmFubmVkIGV4Y2VwdCBmb3IgYSBmZXcNCj4gbGltaXRlZCBj
YXNlcyB3aGVyZSAxIGxldmVsIGNvdWxkIGJlIHBlcm1pdHRkLg0KPiANCj4gaXNfY29uc3RleHBy
KCkgaGFzIG90aGVyIHVzZXMgLSB0aGVyZSBhcmUgcGxhY2VzIHdoZXJlDQo+IF9fYnVpbHRpbl9j
b25zdGFudF9wKCkgaXNuJ3Qgc3Ryb25nIGVub3VnaC4NCj4gUGFydGljdWxhcmx5IGlmIHlvdSBu
ZWVkIHRvIHVzZSBidWlsdGluX2Nob29zZV9leHByKCkNCj4gb3IgX0dlbmVyaWMoKSB0byBnZXQg
c2VsZWN0IGEgdHlwZS4NCj4gDQo+IEZvciBpbnN0YW5jZSwgaWYgeW91IGNhbiBhIGNvbnN0YW50
IHZhbHVlIGJldHdlZW4gMCBhbmQgTUFYSU5UDQo+IGl0IGlzIHNhZmUgdG8gY2FzdCB0by9mcm9t
IHVuc2lnbmVkIGluIG9yZGVyIGNoYW5nZSBhbnkNCj4gaW1wbGljaXQgaW50ZWdlciBwcm9tb3Rp
b24gY2FzdCB0aGF0IG1heSBiZSBncmllZiBzb21lLg0KDQpnbGFkIHRvIGhlYXIgaXQgaXMgdXNl
ZnVsLg0KDQpNYXJ0aW4NCg0KPiANCj4gCURhdmlkDQo+IA0KPiAtDQo+IFJlZ2lzdGVyZWQgQWRk
cmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBN
SzEgMVBULCBVSw0KPiBSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0KDQo=

