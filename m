Return-Path: <linux-kernel+bounces-98297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E75C877806
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 19:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A0B12813E1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 18:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8093B39AE7;
	Sun, 10 Mar 2024 18:37:25 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF703A1AB
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710095845; cv=none; b=CE65mvj0TrWWCL+X+oMpIrfeGwigXlhyJN8nxWZUgDncV+ULJN327D6JAnZFAjWqL+fq4u03xZXDBgXq2MIGBf/tv5UEmZSB6QFIyESEPeprxJJ0A7kEYcklekhN/oe2w65NxfGGpuykCkRieFJqdqafZAe/UKxevbw+w1pYK14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710095845; c=relaxed/simple;
	bh=kbWGHOTGHPftct1YqUNqJ7ouPJ1OedgTOSV8N4+yFF4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=b8OguskriqHq6+B2+yGKn9uTn5ptWozip4jPa3VvV0bIlyN4CWJ1bku7+lYU6/Im9m2O1UH9kdrvdJrAPBENsklzpB5iBVzrVqo/PgCQExpF/0xIDH1JJB8VkeJJ3sbYSae2qAL+2gOrdIu5k3yiAZzqV/YciGTCDdZ1T5Ekrug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-248-YiiRSlQpNdS9qY0k5gpFOg-1; Sun, 10 Mar 2024 18:37:18 +0000
X-MC-Unique: YiiRSlQpNdS9qY0k5gpFOg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 10 Mar
 2024 18:37:27 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 10 Mar 2024 18:37:27 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Nathan Chancellor' <nathan@kernel.org>, Masahiro Yamada
	<masahiroy@kernel.org>
CC: "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Bill Wendling
	<morbo@google.com>, Justin Stitt <justinstitt@google.com>, Nick Desaulniers
	<ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [PATCH] kbuild: remove GCC's default -Wpacked-bitfield-compat
 flag
Thread-Topic: [PATCH] kbuild: remove GCC's default -Wpacked-bitfield-compat
 flag
Thread-Index: AQHab+ZnjkGcfLRbvEm2I9CKWI0+3rExU5Uw
Date: Sun, 10 Mar 2024 18:37:27 +0000
Message-ID: <74e770fb614c41208203732b095bd20f@AcuMS.aculab.com>
References: <20240306124709.324448-1-masahiroy@kernel.org>
 <20240306164950.GB3659677@dev-arch.thelio-3990X>
In-Reply-To: <20240306164950.GB3659677@dev-arch.thelio-3990X>
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

RnJvbTogTmF0aGFuIENoYW5jZWxsb3INCj4gU2VudDogMDYgTWFyY2ggMjAyNCAxNjo1MA0KPiAN
Cj4gT24gV2VkLCBNYXIgMDYsIDIwMjQgYXQgMDk6NDc6MDlQTSArMDkwMCwgTWFzYWhpcm8gWWFt
YWRhIHdyb3RlOg0KPiA+IENvbW1pdCA0YTU4MzhhZDlkMmQgKCJrYnVpbGQ6IEFkZCBleHRyYSBn
Y2MgY2hlY2tzIikgYWRkZWQgdGhlDQo+ID4gLVdwYWNrZWQtYml0ZmllbGQtY29tcGF0IGZsYWcu
DQo+ID4NCj4gPiBHQ0MgbWFudWFsIHNheXM6DQo+ID4gICAiVGhpcyB3YXJuaW5nIGlzIGVuYWJs
ZWQgYnkgZGVmYXVsdC4gVXNlIC1Xbm8tcGFja2VkLWJpdGZpZWxkLWNvbXBhdA0KPiA+ICAgIHRv
IGRpc2FibGUgdGhpcyB3YXJuaW5nLiINCj4gPg0KPiA+IFRoZSB0ZXN0IGNvZGUgaW4gdGhlIG1h
bnVhbDoNCj4gPg0KPiA+ICAgc3RydWN0IGZvbw0KPiA+ICAgew0KPiA+ICAgICBjaGFyIGE6NDsN
Cj4gPiAgICAgY2hhciBiOjg7DQo+ID4gICB9IF9fYXR0cmlidXRlX18gKChwYWNrZWQpKTsNCj4g
Pg0KPiA+IC4uLiBlbWl0cyAibm90ZTogb2Zmc2V0IG9mIHBhY2tlZCBiaXQtZmllbGQg4oCYYuKA
mSBoYXMgY2hhbmdlZCBpbiBHQ0MgNC40Ig0KPiA+IHdpdGhvdXQgVz0zLg0KPiA+DQo+ID4gTGV0
J3MgcmVtb3ZlIGl0LCBhcyBpdCBpcyBhIGRlZmF1bHQgd2l0aCBHQ0MuDQo+ID4NCj4gPiBDbGFu
ZyBkb2VzIG5vdCBzdXBwb3J0IHRoaXMgZmxhZywgc28gaXRzIHJlbW92YWwgd2lsbCBub3QgYWZm
ZWN0IENsYW5nDQo+ID4gYnVpbGRzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTWFzYWhpcm8g
WWFtYWRhIDxtYXNhaGlyb3lAa2VybmVsLm9yZz4NCj4gDQo+IFJldmlld2VkLWJ5OiBOYXRoYW4g
Q2hhbmNlbGxvciA8bmF0aGFuQGtlcm5lbC5vcmc+DQoNCmdjYyBnZW5lcmF0ZXMgcHJldHR5IGNy
YXAgY29kZSBmb3IgdGhlIGFib3ZlLg0KY2xhbmcgaXMgb2sgdW5sZXNzIHlvdSBleHRlbmQgdGhl
IHN0cnVjdHVyZSB0byAzIGJ5dGVzLg0KU2VlOg0KaHR0cHM6Ly9nb2Rib2x0Lm9yZy96LzljMWNz
b25ZOQ0KDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1s
ZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJh
dGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


