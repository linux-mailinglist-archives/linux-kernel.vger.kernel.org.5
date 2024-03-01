Return-Path: <linux-kernel+bounces-88510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E5686E2A2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72A57B236A0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BCD6E2AA;
	Fri,  1 Mar 2024 13:43:40 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6938A6D1D8
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709300620; cv=none; b=fo7l0Q52bYntQU+CTuL33+0g1XfHwAtTs5GNDFx2paAoWbuAlMJIMYSPe1/Qq5/No+8Bg1Vix+r5VWVeJWtK/I5e92FyQ2wB7wEeZBSzZimUOERJxagFs0vFYDDUef6h1f8F+lakx2XA2xeoWqP0Ait7L8RUazxyv4QFYHlLUb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709300620; c=relaxed/simple;
	bh=Ma1KpOvHWUcqpTf0DyGC6ylpZU3RI52UAcVgAc0a4FI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=jNDziUPvqPqKVe3wJh9ncGquLqhGNJUV3S6+jP+D8iaha8oRhP/tsEMdueN1UdKu9QesxJdYDJY7YUwXFPUSDny0BELt5ChYKv0UF+/XQhtPlJhiFWiI7e3/aXT1UoKXyvUBD+yfus5w5gS9Krh/TwkDdC/gBqR37mF11TCEOHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-17-bbzuvQ2FPi6D0WR-XddUGw-1; Fri, 01 Mar 2024 13:43:31 +0000
X-MC-Unique: bbzuvQ2FPi6D0WR-XddUGw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 1 Mar
 2024 13:43:23 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 1 Mar 2024 13:43:23 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: "'Uecker, Martin'" <Martin.Uecker@med.uni-goettingen.de>,
	"keescook@chromium.org" <keescook@chromium.org>, "linux@rasmusvillemoes.dk"
	<linux@rasmusvillemoes.dk>
CC: "corbet@lwn.net" <corbet@lwn.net>, "miguel.ojeda.sandonis@gmail.com"
	<miguel.ojeda.sandonis@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "gustavoars@kernel.org" <gustavoars@kernel.org>,
	"ndesaulniers@google.com" <ndesaulniers@google.com>,
	"jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
	"ojeda@kernel.org" <ojeda@kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>
Subject: RE: [+externe Mail+] RE: [PATCH] compiler.h: Explain how
 __is_constexpr() works
Thread-Topic: [+externe Mail+] RE: [PATCH] compiler.h: Explain how
 __is_constexpr() works
Thread-Index: AQHaa5MvghvgXFQBskOAdfSAj6aDybEilNaggABK04CAAAHC0A==
Date: Fri, 1 Mar 2024 13:43:23 +0000
Message-ID: <9c4518eae05c4758afe08c6b90678e92@AcuMS.aculab.com>
References: <20240301044428.work.411-kees@kernel.org>
	 <af0eff12e6bc41039614add550406c11@AcuMS.aculab.com>
 <22c9c4cc27b13b2fb6f3cd9fa6f827f56f30770b.camel@med.uni-goettingen.de>
In-Reply-To: <22c9c4cc27b13b2fb6f3cd9fa6f827f56f30770b.camel@med.uni-goettingen.de>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogVWVja2VyLCBNYXJ0aW4NCj4gU2VudDogMDEgTWFyY2ggMjAyNCAxMzoyMg0KPiANCj4g
TXkgc3VnZ2VzdGlvbiB3b3VsZCBhbHNvIHRvIGxpbWl0IGV4cGxhbmF0aW9uLiBOb2JvZHkgc2hv
dWxkDQo+IHdyaXRlIHN1Y2ggY29kZSBhbmQgaWYgeW91IG5lZWQgdG8sIHlvdSBjYW4gZmluZCBl
eHBsYW5hdGlvbnMNCj4gYWxsIG92ZXIgdGhlIGludGVybmV0Lg0KPiANCj4gRmluYWxseSwgSSBz
dGlsbCB0aGluayB0aGUgbW90aXZhdGlvbiBmb3IgdGhpcyBtYWNybyAocmVtb3ZpbmcNCj4gVkxB
cykgaXMgbWlzZ3VpZGVkIGlmIHNlY3VyaXR5IGlzIHRoZSBnb2FsIGJlY2F1c2UgVkxBcyBwcm92
aWRlDQo+IHByZWNpc2UgYm91bmRzIGFuZCBsYXJnZXIgd29yc3QtY2FzZSBmaXhlZC1zaXplIGFy
cmF5cyBkbyBub3QuDQo+IA0KPiBJdCB3b3VsZCBiZSBiZXR0ZXIgdG8gdXNlIHRoZSBjb21waWxl
ciBvcHRpb25zIHRoYXQgZGV0ZWN0DQo+IHBvc3NpYmx5IHVzZSBvZiBWTEFzIG9mIHVuYm91bmRl
ZCBzaXplIGFuZCBpZiB0aGVyZSBhIHByb2JsZW1zDQo+IHdpdGggdGhpcywgaW1wcm92ZSB0aGlz
IG9uIHRoZSBjb21waWxlciBzaWRlLg0KDQpJbiBrZXJuZWwgY29kZSAod2l0aCBsaW1pdGVkIHN0
YWNrKSB0aGVyZSBoYXMgdG8gYmUgZW5vdWdoIHJvb20NCmZvciB0aGUgbGFyZ2VzdCBwb3NzaWJs
ZSAnVkxBJyBzbyB5b3UgbWlnaHQgYXMgd2VsbCBhbGxvY2F0ZSBvbmUuDQoNCkFsbG93aW5nIFZM
QSBhbHNvIG1ha2VzIGl0IHByZXR0eSBtdWNoIGltcG9zc2libGUgdG8gZG8gYW55DQpraW5kIG9m
IHN0YXRpYyBzdGFjayB1c2UgYW5hbHlzaXMuDQpUaGUgZmluZSBJQlQgdGFncyBjYW4gYmUgdXNl
ZCBpZGVudGlmeSB2YWxpZCBpbmRpcmVjdCBjYWxscw0Kd2hpY2ggcHJldHR5IG11Y2ggb25seSBs
ZWF2ZXMgcmVjdXJzaW9uIHN0b3BwaW5nIGZ1bGwgc3RhdGljDQpzdGFjayBhbmFseXNpcyAtIGFu
ZCB0aGF0IGNvdWxkIGJlIGJhbm5lZCBleGNlcHQgZm9yIGEgZmV3DQpsaW1pdGVkIGNhc2VzIHdo
ZXJlIDEgbGV2ZWwgY291bGQgYmUgcGVybWl0dGQuDQoNCmlzX2NvbnN0ZXhwcigpIGhhcyBvdGhl
ciB1c2VzIC0gdGhlcmUgYXJlIHBsYWNlcyB3aGVyZQ0KX19idWlsdGluX2NvbnN0YW50X3AoKSBp
c24ndCBzdHJvbmcgZW5vdWdoLg0KUGFydGljdWxhcmx5IGlmIHlvdSBuZWVkIHRvIHVzZSBidWls
dGluX2Nob29zZV9leHByKCkNCm9yIF9HZW5lcmljKCkgdG8gZ2V0IHNlbGVjdCBhIHR5cGUuDQoN
CkZvciBpbnN0YW5jZSwgaWYgeW91IGNhbiBhIGNvbnN0YW50IHZhbHVlIGJldHdlZW4gMCBhbmQg
TUFYSU5UDQppdCBpcyBzYWZlIHRvIGNhc3QgdG8vZnJvbSB1bnNpZ25lZCBpbiBvcmRlciBjaGFu
Z2UgYW55DQppbXBsaWNpdCBpbnRlZ2VyIHByb21vdGlvbiBjYXN0IHRoYXQgbWF5IGJlIGdyaWVm
IHNvbWUuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1s
ZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJh
dGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


