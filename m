Return-Path: <linux-kernel+bounces-44621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5746384252F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFB80B237BA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FA476030;
	Tue, 30 Jan 2024 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="NgId3XpE"
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71476A35F;
	Tue, 30 Jan 2024 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.39.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618431; cv=none; b=P1m99ETxEThZLLR1XcIp7B3gxv2HvuCmM9Wn493Wjq31UPhiwdUpx0cWRCRMRN6JnMIKsrvPDvQNfCfdNBmaUgSP5A6Xy4z8fkdLrQHW3gamF2MHM4uV9x9AFh6mHuEHNITIjoFHw8Cw1pX8iNAAWKvdvlCgMwgiXIBl6iZ60EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618431; c=relaxed/simple;
	bh=LWCEE7Ky7ZqC2xZnLL48J6mdU/wI6QANLum+jdUp8h0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uL9DcwVj2Ntemu09/jq8ssX7rRRo3sQswa+vi/mD5KCd5fyDrDLrXg4fBIoXkdV0p/nS0ev7MBnzjhJ+qJwDdbnH+QMO2PlCsQGCW4Da+Su+PspZqzvSEWHzhdf+U7eEyQyUu/pyLIoDYYq30F3d0enX+dr6tW0QKLwGRsqdrhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com; spf=pass smtp.mailfrom=dh-electronics.com; dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b=NgId3XpE; arc=none smtp.client-ip=188.68.39.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1706617791;
	bh=LWCEE7Ky7ZqC2xZnLL48J6mdU/wI6QANLum+jdUp8h0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=NgId3XpE+F7hU3JeeLXAjPrhKu+VadeUAbULAkoAsMkzesjEieSKAiGsfiyrPNtA+
	 qw+d1amDXOCQd5vbru+vg78kXzeNnsGlYQPP6qvSwJRYcgj50+xQlIR6q1jqxaV5Zk
	 SLrv9M0tovDUYBwzTGhkOsceeFUxwzFE1NNE59qcbLxdvqg92rGdJpFPTw9BDvdVaZ
	 ahJkQfTRibb211YJNJQo0vDS56xkNAx04VcAkFhCp1fwxSaSShTX8RM3ZVIsGsl8zv
	 BAF0CiYnEJr2jSuF2Ehn+1sW4AXxy/tVSK0bwDI7TemAp6QAVnFZzOG7VZO7C2kUvV
	 YJeC2zlJhtMAg==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>, Lino Sanfilippo
	<LinoSanfilippo@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
CC: Rob Herring <robh@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "quentin.schulz@theobroma-systems.com"
	<quentin.schulz@theobroma-systems.com>, Heiko Stuebner
	<heiko.stuebner@cherry.de>
Subject: RE: [PATCH v5 2/6] serial: 8250: Support separate rs485 rx-enable
 GPIO
Thread-Topic: [PATCH v5 2/6] serial: 8250: Support separate rs485 rx-enable
 GPIO
Thread-Index: AQHaUH1C9lFNHAGCbEecDp85JK6VnLDscmeAgAP+JYCAAd4lkA==
Date: Tue, 30 Jan 2024 12:29:47 +0000
Message-ID: <3d31b17ffd4a4f02aaaa1b6c33a09009@dh-electronics.com>
References: <20240126-dev-rx-enable-v5-0-5d934eda05ca@theobroma-systems.com>
 <20240126-dev-rx-enable-v5-2-5d934eda05ca@theobroma-systems.com>
 <098216ce-50b3-43e4-ad1a-42228c58b761@gmx.de>
 <37522087-d3ac-4cc7-b11b-c844d36206ba@theobroma-systems.com>
In-Reply-To: <37522087-d3ac-4cc7-b11b-c844d36206ba@theobroma-systems.com>
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

RnJvbTogRmFyb3VrIEJvdWFiaWQNClNlbnQ6IE1vbmRheSwgSmFudWFyeSAyOSwgMjAyNCA5OjU3
IEFNDQoNCkhpLA0KDQo+IE9uIDI2LjAxLjI0IDIwOjU4LCBMaW5vIFNhbmZpbGlwcG8gd3JvdGU6
DQo+PiBbU29tZSBwZW9wbGUgd2hvIHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBkb24ndCBvZnRlbiBn
ZXQgZW1haWwgZnJvbSBsaW5vc2FuZmlsaXBwb0BnbXguZGUuIExlYXJuIHdoeSB0aGlzIGlzIGlt
cG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24g
XQ0KPj4NCj4+IEhpLA0KPj4NCj4+IE9uIDI2LjAxLjI0IDE4OjI3LCBGYXJvdWsgQm91YWJpZCB3
cm90ZToNCj4+PiBGcm9tOiBIZWlrbyBTdHVlYm5lciA8aGVpa28uc3R1ZWJuZXJAY2hlcnJ5LmRl
Pg0KPj4+DQo+Pj4gVGhlIFJFIHNpZ25hbCBpcyB1c2VkIHRvIGNvbnRyb2wgdGhlIGR1cGxleCBt
b2RlIG9mIHRyYW5zbWlzc2lvbnMsDQo+Pj4gYWthIHJlY2VpdmluZyBkYXRhIHdoaWxlIHNlbmRp
bmcgaW4gZnVsbCBkdXBsZXggbW9kZSwgd2hpbGUgc3RvcHBpbmcNCj4+PiByZWNlaXZpbmcgZGF0
YSBpbiBoYWxmLWR1cGxleCBtb2RlLg0KPj4+DQo+Pj4gT24gYSBudW1iZXIgb2YgYm9hcmRzIHRo
ZSAhUkUgc2lnbmFsIGlzIHRpZWQgdG8gZ3JvdW5kIHNvIHJlY2VwdGlvbg0KPj4+IGlzIGFsd2F5
cyBlbmFibGVkIGV4Y2VwdCBpZiB0aGUgVUFSVCBhbGxvd3MgZGlzYWJsaW5nIHRoZSByZWNlaXZl
ci4NCj4+PiBUaGlzIGNhbiBiZSB0YWtlbiBhZHZhbnRhZ2Ugb2YgdG8gaW1wbGVtZW50IGhhbGYt
ZHVwbGV4IG1vZGUgLSBsaWtlDQo+Pj4gZG9uZSBvbiA4MjUwX2JjbTI4MzVhdXguDQo+Pj4NCj4+
PiBBbm90aGVyIHNvbHV0aW9uIGlzIHRvIHRpZSAhUkUgdG8gUlRTIGFsd2F5cyBmb3JjaW5nIGhh
bGYtZHVwbGV4IG1vZGUuDQo+Pj4NCj4+PiBBbmQgZmluYWxseSB0aGVyZSBpcyB0aGUgb3B0aW9u
IHRvIGNvbnRyb2wgdGhlIFJFIHNpZ25hbCBzZXBhcmF0ZWx5LA0KPj4+IGxpa2UgZG9uZSBoZXJl
IGJ5IGludHJvZHVjaW5nIGEgbmV3IHJzNDg1LXNwZWNpZmljIGdwaW8gdGhhdCBjYW4gYmUNCj4+
PiBzZXQgZGVwZW5kaW5nIG9uIHRoZSBSWF9EVVJJTkdfVFggc2V0dGluZyBpbiB0aGUgY29tbW9u
IGVtNDg1IGNhbGxiYWNrcy4NCj4+Pg0KPj4gd2UganVzdCBhZGRlZCB0aGUgcnhfZHVyaW5nX3R4
X2dwaW8gdG8gdGhlIHNlcmlhbCBjb3JlLg0KPj4gV2h5IGNhbnQgeW91IHVzZSB0aGlzIEdQSU8g
Zm9yIHlvdXIgcHVycG9zZT8NCj4+DQo+PiBSZWdhcmRzLA0KPj4gTGluby4NCj4gV2hhdCB3ZSBh
cmUgdHJ5aW5nIHRvIGltcGxlbWVudCBpcyBhIGdwaW8gdGhhdCBlbXVsYXRlcyB0aGUgUlRTIHNp
Z25hbA0KPiBpdHNlbGYgYXMgd2UgZG8gbm90IGhhdmUgYSBkZWRpY2F0ZWQgUlRTIHNpZ25hbCB0
aGF0IGNhbiBiZSBjb250cm9sbGVkDQo+IHRocm91Z2ggTUNSLiBUaGUgcnggZHVyaW5nIHR4IHN0
YXRlIGluIG91ciBjYXNlIGlzIGEgZml4ZWQgc3RhdGUgb2YNCj4gIk5PX1JYX1dISUxFX1RYIg0K
DQpXaHkgY2FuJ3QgdGhlIHByb3BlcnR5IHJ0cy1ncGlvcyBiZSB1c2VkIGhlcmUgZm9yIHRoaXMg
cHVycG9zZT8NCg0KDQpSZWdhcmRzDQpDaHJpc3RvcGgNCg==

