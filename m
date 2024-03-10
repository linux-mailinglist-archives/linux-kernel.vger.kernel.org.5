Return-Path: <linux-kernel+bounces-98315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 519E0877852
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 20:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0BAF1F21295
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 19:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F46B3A1A2;
	Sun, 10 Mar 2024 19:43:14 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9E620335
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 19:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710099793; cv=none; b=dOkOuZtnMRkmP8eBW7CnbLFllYKiC7WNGwJTh2XIxOwpr1IFYAUZf9CM/61dTDQYKuxGHh/0T+NucLUDGT7wAM52rCFqwpD/FmqrDxOqCBOatY488YDADxXHQ3u14XK0Cz+Zk4FkZ0HFOHiWSIdc/DSNNbBkntlSD8tmHXU6Oow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710099793; c=relaxed/simple;
	bh=J3hHOIDKrVgCM4kdsGPxV8/B4F8p+mTsleZQ51fGrCA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=G4mUSCoxJE2wsmFl0xMNbfYnf8OxRbzrKpEKoiYDweEs0xas9iVoiI+w6rOnaxuq5/PyW9FVTT8lWHCJvWdf+r40qyOx/Oyo1T+TfpY5CJX8qayb3C2oa1q6NhL8++tvyb9gisq6eWFkpIaYSxlt+tn9pwkTNbBgo/h5BB75aU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-158-NaaYfuJrOBy0jcWCpLAwGw-1; Sun, 10 Mar 2024 19:43:08 +0000
X-MC-Unique: NaaYfuJrOBy0jcWCpLAwGw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 10 Mar
 2024 19:43:18 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 10 Mar 2024 19:43:18 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Nazerke Turtayeva' <nturtayeva@ucsb.edu>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: Question about unpacking large initramfs (>2G)
Thread-Topic: Question about unpacking large initramfs (>2G)
Thread-Index: AQHacc+Qmbacfw5d7EiWXwAjIr6uu7ExYL9w
Date: Sun, 10 Mar 2024 19:43:18 +0000
Message-ID: <a6dddd70d2844e438c2e6c205fa41b7d@AcuMS.aculab.com>
References: <CAHY78BqCpMQptPN0SMaXuRqHOhYi+wnMEUSTYt7OHDZih4e7yQ@mail.gmail.com>
In-Reply-To: <CAHY78BqCpMQptPN0SMaXuRqHOhYi+wnMEUSTYt7OHDZih4e7yQ@mail.gmail.com>
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

RnJvbTogTmF6ZXJrZSBUdXJ0YXlldmENCj4gU2VudDogMDkgTWFyY2ggMjAyNCAwMzoxMQ0KPiAN
Cj4gUmVjZW50bHkgSSB3YXMgdGVzdGluZyBMTE1zIGZvciBSSVNDLVYgb24gTGludXggcGx1cyBC
dWlsZHJvb3QgcGx1cw0KPiBPcGVuU0JJIGFuZCBTcGlrZSBJU0EgU2ltdWxhdG9yLiBOZXZlcnRo
ZWxlc3MsIGdpdmVuIG15IHJvb3RmcyBlbmQgdXANCj4gYmVpbmcgcHJldHR5IGxhcmdlLCAzLjZH
QiBhdCB0aGUgbW9tZW50LCBteSBsaW51eCBib290IGZhbGxzIHNob3J0DQo+IHdpdGggIkluaXRy
YW1mcyB1bnBhY2tpbmcgZmFpbGVkOiB3cml0ZSBlcnJvciIuIEkgd2FzIHRyeWluZyB0byBkZWJ1
Zw0KPiB0aGlzIHByb2JsZW0gbGFzdCB3ZWVrLCBidXQgZ290IGNvbmZ1c2VkIHdpdGggY29kZSBj
b21wbGV4aXR5IDooLg0KDQpJJ2QgbG9vayBhdCByZW1vdmluZyB1bndhbnRlZCBzdHVmZiBmcm9t
IGluaXRyYW1mcy4NCkZvciBvdXIgYnVpbGRyb290IGltYWdlcyB3ZSBkZWxldGUgYSBsb3Qgb2Yg
c3R1ZmYgLSBzaW5jZSBpdA0KY2FuIGJlIGZvdW5kIGluIHRoZSBkaXNrIGltYWdlIGFmdGVyIG1v
dW50aW5nIHRoZSBkaXNrIC8uDQooQWx0aG91Z2ggSSdtIG5vdCBhdCBhbGwgc3VyZSBob3cgbXVj
aCBvZiB0aGUgaW5pdHJhbWZzIG1lbW9yeQ0KaXMgcmVjb3ZlcmVkIC0gZXNwZWNpYWxseSB3aXRo
b3V0IHBpdm90X3Jvb3QuDQoNCk9uZSB0aGluZyBJIGhhdmUgbm90aWNlZCBvbiB4ODYgaXMgdGhh
dCB0aGUgLmtvIGZpbGVzIGFyZQ0KbWFzc2l2ZSBiZWNhdXNlIHRoZXkgY29udGFpbiBhIGxvdCBv
ZiBkZWJ1ZyBpbmZvLg0KKEkgd2FzIGxvb2tpbmcgYXQgd2h5IGl0IHRvb2sgc28gbG9uZyBiZXR3
ZWVuIHRoZSBsYXN0IGdydWINCm1lc3NhZ2UgYW5kIHRoZSBmaXJzdCBrZXJuZWwgb25lLikNCkFs
c28gdGhlIGRlZmF1bHQgYnVpbGQgYWxzbyBwdXRzIGFsbCB0aGUgbW9kdWxlcyBpbnRvIHRoZQ0K
aW5pdHJhbWZzIC0gZXZlbiB0aG91Z2ggbW9zdCBjYW4gYmUgbG9hZGVkIGZyb20gdGhlIHJvb3Qg
ZmlsZXN5c3RlbS4NCg0KCURhdmlkLg0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUs
IEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJl
Z2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


