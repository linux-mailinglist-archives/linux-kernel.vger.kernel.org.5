Return-Path: <linux-kernel+bounces-144780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7C38A4AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D875B25BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DC13F9D4;
	Mon, 15 Apr 2024 08:42:59 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D283A1BA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 08:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713170578; cv=none; b=dpFUg9n9e7Q+BfpX+4ewvmCauZ2bpY8HEa43I+jIT/JvNSSMSOTbb0vlhi/NtBr9CXwXU4rOuRlToyzS18ZA4UwSRdEM8h5SOj2LK0iSz8ZfVu/ZkBZ9QFCxpwyOV4tjkj2W75+fpYg2agO1i4A0VgICg731JfBkhZ0gkmMI5go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713170578; c=relaxed/simple;
	bh=gCoRy+oXMwriNz7xWCEPJfPnWsZEN1vLk9TxR53ud+c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Xhczy3Nw58NQ63olDkeQSsa9oIzn88Jh4NfSl3M7RDCQ9XA0eSuTmFN3JjG8lU2ntxflD/rALis7fznvw7sGl9JK0WP4jLT2/S2i7C/pOyxiACFvNhuei4RP36GGdGhMNGe0q9qB8TVK8IGVY2ZX0YhWm5HGerJb+5PP89hYyMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-200-Eemd-UoyMe6maN2y4dENkg-1; Mon, 15 Apr 2024 09:42:48 +0100
X-MC-Unique: Eemd-UoyMe6maN2y4dENkg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 15 Apr
 2024 09:42:13 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 15 Apr 2024 09:42:13 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Sergio Paracuellos' <sergio.paracuellos@gmail.com>, Thorsten Blum
	<thorsten.blum@toblux.com>
CC: John Crispin <john@phrozen.org>, Thomas Bogendoerfer
	<tsbogend@alpha.franken.de>, "linux-mips@vger.kernel.org"
	<linux-mips@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] MIPS: ralink: Use min() to fix Coccinelle warning
Thread-Topic: [PATCH] MIPS: ralink: Use min() to fix Coccinelle warning
Thread-Index: AQHaizP0h4uzp/dw0kCg8BnSEaASErFpCYSA
Date: Mon, 15 Apr 2024 08:42:13 +0000
Message-ID: <e6ff2dbaf23d4d66bd8ea1bf1b87a26c@AcuMS.aculab.com>
References: <20240409153519.291205-2-thorsten.blum@toblux.com>
 <CAMhs-H8EByNhBAkhDvtHL_ZUgLnMFQcR1zeYhaKQSg-13uFnVQ@mail.gmail.com>
In-Reply-To: <CAMhs-H8EByNhBAkhDvtHL_ZUgLnMFQcR1zeYhaKQSg-13uFnVQ@mail.gmail.com>
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

RnJvbTogU2VyZ2lvIFBhcmFjdWVsbG9zDQo+IFNlbnQ6IDEwIEFwcmlsIDIwMjQgMTE6NDQNCj4g
T24gVHVlLCBBcHIgOSwgMjAyNCBhdCA1OjM24oCvUE0gVGhvcnN0ZW4gQmx1bSA8dGhvcnN0ZW4u
Ymx1bUB0b2JsdXguY29tPiB3cm90ZToNCj4gPg0KPiA+IEZpeGVzIHRoZSBmb2xsb3dpbmcgQ29j
Y2luZWxsZS9jb2NjaWNoZWNrIHdhcm5pbmcgcmVwb3J0ZWQgYnkNCj4gPiBtaW5tYXguY29jY2k6
DQo+ID4NCj4gPiAgICAgICAgIFdBUk5JTkcgb3Bwb3J0dW5pdHkgZm9yIG1pbigpDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBUaG9yc3RlbiBCbHVtIDx0aG9yc3Rlbi5ibHVtQHRvYmx1eC5jb20+
DQo+ID4gLS0tDQo+ID4gIGFyY2gvbWlwcy9yYWxpbmsvdGltZXIuYyB8IDYgKy0tLS0tDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9hcmNoL21pcHMvcmFsaW5rL3RpbWVyLmMgYi9hcmNoL21pcHMvcmFsaW5r
L3RpbWVyLmMNCj4gPiBpbmRleCA1NDA5NGY2ZTAzM2UuLmQyNzFhYzk4MzEyYSAxMDA2NDQNCj4g
PiAtLS0gYS9hcmNoL21pcHMvcmFsaW5rL3RpbWVyLmMNCj4gPiArKysgYi9hcmNoL21pcHMvcmFs
aW5rL3RpbWVyLmMNCj4gPiBAQCAtNzUsMTEgKzc1LDcgQEAgc3RhdGljIGludCBydF90aW1lcl9y
ZXF1ZXN0KHN0cnVjdCBydF90aW1lciAqcnQpDQo+ID4NCj4gPiAgc3RhdGljIGludCBydF90aW1l
cl9jb25maWcoc3RydWN0IHJ0X3RpbWVyICpydCwgdW5zaWduZWQgbG9uZyBkaXZpc29yKQ0KDQpJ
IGRvdWJ0ICd1bnNpZ25lZCBsb25nJyBpcyB0aGUgYmVzdCB0eXBlIHRoZXJlLg0KSXQgc2hvdWxk
IHByb2JhYmx5IGJlIHUzMiAtIHNvIHN0aWxsIDMyYml0IG9uIDY0Yml0IHN5c3RlbXMuDQoNCj4g
PiAgew0KPiA+IC0gICAgICAgaWYgKHJ0LT50aW1lcl9mcmVxIDwgZGl2aXNvcikNCj4gPiAtICAg
ICAgICAgICAgICAgcnQtPnRpbWVyX2RpdiA9IHJ0LT50aW1lcl9mcmVxOw0KPiA+IC0gICAgICAg
ZWxzZQ0KPiA+IC0gICAgICAgICAgICAgICBydC0+dGltZXJfZGl2ID0gZGl2aXNvcjsNCj4gPiAt
DQo+ID4gKyAgICAgICBydC0+dGltZXJfZGl2ID0gbWluKHJ0LT50aW1lcl9mcmVxLCBkaXZpc29y
KTsNCj4gDQo+IEkgZG8gZmluZCB0aGUgb3JpZ2luYWwgY29kZSBtb3JlIHJlYWRhYmxlLg0KDQpQ
cm9iYWJseSBiZWNhdXNlIGl0IGlzbid0IHJlYWxseSBhICdtaW4oKScgYnV0IGF2b2lkaW5nIGEg
ZGl2aXNpb24NCmdlbmVyYXRpbmcgYSBxdW90aWVudCBvZiB6ZXJvLg0KSXQgbWlnaHQgYmUgYmV0
dGVyIHRvIGV4cGxpY2l0bHkgYXZvaWQgdGhlIHgveCBiZWxvdy4NCg0KCURhdmlkDQo+IA0KPiBC
ZXN0IHJlZ2FyZHMsDQo+ICAgICBTZXJnaW8gUGFyYWN1ZWxsb3MNCj4gDQo+ID4gICAgICAgICBy
dF90aW1lcl93MzIocnQsIFRJTUVSX1JFR19UTVIwTE9BRCwgcnQtPnRpbWVyX2ZyZXEgLyBydC0+
dGltZXJfZGl2KTsNCj4gPg0KPiA+ICAgICAgICAgcmV0dXJuIDA7DQo+ID4gLS0NCj4gPiAyLjQ0
LjANCj4gPg0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwg
TW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzog
MTM5NzM4NiAoV2FsZXMpDQo=


