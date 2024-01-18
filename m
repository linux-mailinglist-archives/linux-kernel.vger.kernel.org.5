Return-Path: <linux-kernel+bounces-29959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0AD8315D3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4CCFB220D0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DA31F5FF;
	Thu, 18 Jan 2024 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="BfH4+tCM"
Received: from mx4.securetransport.de (mx4.securetransport.de [178.254.6.145])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76F520305;
	Thu, 18 Jan 2024 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.254.6.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705570198; cv=none; b=jpHLpZ38mkFQQTkqpwJo7wxh8WspYmT+eJPe1QX+7Bts6P02OTgzXqC2c3xsjlOy1DS4m6NKwkgmqmiqmRVEFSaPPfmFUXe9NNdBrbz8uXmFLmzIkxi+yuVu6owHHuOHIFbwUdHl/BMtQgxhWNcbE3Eu2YMh85yjSQhIF9FYPM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705570198; c=relaxed/simple;
	bh=aA3cPGIs/7zKZafcN4vYuW4EjRaFhlfin5ohb5+4zCk=;
	h=DKIM-Signature:X-secureTransport-forwarded:From:Complaints-To:To:
	 CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:Content-Type:Content-Transfer-Encoding:
	 MIME-Version; b=oj2PDk2TtLSIDh33yRn3Icox6NfrXBsYfMQN2MWTFcqrxZheBlRyEQqZ9hbizqWUOcdVpGFxgyKwPe8eNxJAaj+5vAjS/ZT3MavbmvG3lYo9wHSFTbX+8DAwgwldCuxce1xu3T2S3H5EpDUp+pxsUgAPASvVfrgf4VTYomKZ69U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com; spf=pass smtp.mailfrom=dh-electronics.com; dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b=BfH4+tCM; arc=none smtp.client-ip=178.254.6.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1705570152;
	bh=aA3cPGIs/7zKZafcN4vYuW4EjRaFhlfin5ohb5+4zCk=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=BfH4+tCMw3tbOktJp6Wvqu3pOZ3TSs9Sgb1HrMuut60YAeLkBOJnJ9cGqLFj6llwW
	 5bkoB+uF/R1CCHn8VXQYpwfp94a+PeE4kdSG7x3RIdQStzY1tjoTlg0ZbU8wnYfsM3
	 P6yZiX4lSi1N2pcM48xn/N5ekyQHNDjeqvAgNdyDVwhJOjLKeoFZYhPJv4mUKXqiJk
	 vXFVcWdfCxtzXM+OzrZVrTqaN9fKrSxnORhSEeLZl88r+6Y2iYsTz4wANin95c7tPF
	 65Ta06ZkL+YHE1lsY6d4Sht4CLnWqXRNXaC5kGfm0vkMdo1GAJg6FGHw/ZGkh4lxC0
	 p0E0HOGQTgUnA==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Greg KH <gregkh@linuxfoundation.org>
CC: "crescentcy.hsieh@moxa.com" <crescentcy.hsieh@moxa.com>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>, "LinoSanfilippo@gmx.de"
	<LinoSanfilippo@gmx.de>, "lukas@wunner.de" <lukas@wunner.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v6 1/2] tty: serial: Cleanup the bit shift with macro
Thread-Topic: [PATCH v6 1/2] tty: serial: Cleanup the bit shift with macro
Thread-Index: AQHaSJT/2G6HCu2q+UioazhsZhzEcrDeCL+AgAENyACAADkvsA==
Date: Thu, 18 Jan 2024 09:29:10 +0000
Message-ID: <fc17322010b049529054552bd44f63f1@dh-electronics.com>
References: <20231201071554.258607-2-crescentcy.hsieh@moxa.com>
 <20240117145623.3556-1-cniedermaier@dh-electronics.com>
 <2024011836-glimmer-seventh-f2a7@gregkh>
In-Reply-To: <2024011836-glimmer-seventh-f2a7@gregkh>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

RnJvbTogR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQpTZW50OiBUaHVyc2Rh
eSwgSmFudWFyeSAxOCwgMjAyNCA4OjAyIEFNDQo+IE9uIFdlZCwgSmFuIDE3LCAyMDI0IGF0IDAz
OjU2OjIzUE0gKzAxMDAsIENocmlzdG9waCBOaWVkZXJtYWllciB3cm90ZToNCj4+IEhpIGV2ZXJ5
b25lLA0KPj4NCj4+PiBUaGlzIHBhdGNoIHJlcGxhY2VzIHRoZSBiaXQgc2hpZnQgY29kZSB3aXRo
ICJfQklUVUwoKSIgbWFjcm8gaW5zaWRlDQo+Pj4gInNlcmlhbF9yczQ4NSIgc3RydWN0Lg0KPj4+
DQo+Pj4gU2lnbmVkLW9mZi1ieTogQ3Jlc2NlbnQgQ1kgSHNpZWggPGNyZXNjZW50Y3kuaHNpZWhA
bW94YS5jb20+DQo+Pj4gLS0tDQo+Pj4gIGluY2x1ZGUvdWFwaS9saW51eC9zZXJpYWwuaCB8IDE3
ICsrKysrKysrKy0tLS0tLS0tDQo+Pj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyks
IDggZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4
L3NlcmlhbC5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3NlcmlhbC5oDQo+Pj4gaW5kZXggNTNiYzFh
ZjY3Li42Yzc1ZWJkZDcgMTAwNjQ0DQo+Pj4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3Nlcmlh
bC5oDQo+Pj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3NlcmlhbC5oDQo+Pj4gQEAgLTExLDYg
KzExLDcgQEANCj4+PiAgI2lmbmRlZiBfVUFQSV9MSU5VWF9TRVJJQUxfSA0KPj4+ICAjZGVmaW5l
IF9VQVBJX0xJTlVYX1NFUklBTF9IDQo+Pj4NCj4+PiArI2luY2x1ZGUgPGxpbnV4L2NvbnN0Lmg+
DQo+Pj4gICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPg0KPj4+DQo+Pj4gICNpbmNsdWRlIDxsaW51
eC90dHlfZmxhZ3MuaD4NCj4+PiBAQCAtMTQwLDE0ICsxNDEsMTQgQEAgc3RydWN0IHNlcmlhbF9p
Y291bnRlcl9zdHJ1Y3Qgew0KPj4+ICAgKi8NCj4+PiAgc3RydWN0IHNlcmlhbF9yczQ4NSB7DQo+
Pj4gICAgIF9fdTMyICAgZmxhZ3M7DQo+Pj4gLSNkZWZpbmUgU0VSX1JTNDg1X0VOQUJMRUQgICAg
ICAgICAgKDEgPDwgMCkNCj4+PiAtI2RlZmluZSBTRVJfUlM0ODVfUlRTX09OX1NFTkQgICAgICAg
ICAgICAgICgxIDw8IDEpDQo+Pj4gLSNkZWZpbmUgU0VSX1JTNDg1X1JUU19BRlRFUl9TRU5EICAg
KDEgPDwgMikNCj4+DQo+PiBJbiB0aGUgb2xkIGRlZmluaXRpb24gKDEgPDwgMykgd2Fzbid0IHVz
ZWQuDQo+Pg0KPj4+IC0jZGVmaW5lIFNFUl9SUzQ4NV9SWF9EVVJJTkdfVFggICAgICAgICAgICAg
KDEgPDwgNCkNCj4+PiAtI2RlZmluZSBTRVJfUlM0ODVfVEVSTUlOQVRFX0JVUyAgICAgICAgICAg
ICgxIDw8IDUpDQo+Pj4gLSNkZWZpbmUgU0VSX1JTNDg1X0FERFJCICAgICAgICAgICAgICAgICAg
ICAoMSA8PCA2KQ0KPj4+IC0jZGVmaW5lIFNFUl9SUzQ4NV9BRERSX1JFQ1YgICAgICAgICAgICAg
ICAgKDEgPDwgNykNCj4+PiAtI2RlZmluZSBTRVJfUlM0ODVfQUREUl9ERVNUICAgICAgICAgICAg
ICAgICgxIDw8IDgpDQo+Pj4gKyNkZWZpbmUgU0VSX1JTNDg1X0VOQUJMRUQgICAgICAgICAgX0JJ
VFVMKDApDQo+Pj4gKyNkZWZpbmUgU0VSX1JTNDg1X1JUU19PTl9TRU5EICAgICAgICAgICAgICBf
QklUVUwoMSkNCj4+PiArI2RlZmluZSBTRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQgICBfQklUVUwo
MikNCj4+PiArI2RlZmluZSBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYICAgICAgICAgICAgIF9CSVRV
TCgzKQ0KPj4NCj4+IElzbid0IGl0IGEgYnJlYWsgaWYgbnVtYmVyIDMgaXNuJ3Qgc2tpcHBlZCBo
ZXJlIGFzIHdlbGw/DQo+IA0KPiBVZ2gsIHllcyBpdCBpcywgZ29vZCBjYXRjaCENCj4gDQo+IENh
cmUgdG8gc2VuZCBhIHBhdGNoIHRvIGZpeCB0aGlzIHVwPw0KDQpPSywgSSdsbCBtYWtlIGEgcGF0
Y2guDQoNClJlZ2FyZHMNCkNocmlzdG9waA0K

