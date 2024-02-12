Return-Path: <linux-kernel+bounces-61160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3592850E33
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68711C20E47
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 07:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53E68832;
	Mon, 12 Feb 2024 07:52:32 +0000 (UTC)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940D7747F;
	Mon, 12 Feb 2024 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707724352; cv=none; b=CRqZIdfSUusUhDMRmp2vdvXci1rQrwlklE8uw40XtpemenlwpKmqEPcuIvThPvF8cKiVDLPS9EJTOEudqBAuMCuLhkQjqZelDE4mEGD8BIjGTYt7jjoBcYm3Vp7ht5QeW9TLEQoufyx432GM/9akDbQrEOpo2dIJRnAFAD69rw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707724352; c=relaxed/simple;
	bh=d4WCViB2/A3Yw3ikUJootsnEMQUnEqVYiRN3vVVKkB0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AV8xyM0+xPkl0YkIbQ8xiB5r341efKGU++Of0PEQgd6zy/IoC0y51SeqHRKOpRfiwZSr1bxh/Iq3IWUKhpl7c6zmivXNgI78tlbnaZD12Zk4JQ7x4SibsphOsiP2TqMb8DXIQZcd8ljxkgbDCfunXYvLY1/tMsRS5avu6zOwEtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <D.Dulov@aladdin.ru>
To: Arend van Spriel <arend.vanspriel@broadcom.com>, Kalle Valo
	<kvalo@codeaurora.org>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Pieter-Paul Giesberts <pieterpg@broadcom.com>, "Franky (Zhenhui) Lin"
	<frankyl@broadcom.com>, "John W. Linville" <linville@tuxdriver.com>, Kan Yan
	<kanyan@broadcom.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "brcm80211-dev-list.pdl@broadcom.com"
	<brcm80211-dev-list.pdl@broadcom.com>, "SHA-cyfmac-dev-list@infineon.com"
	<SHA-cyfmac-dev-list@infineon.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH] brcmfmac: Remove unnecessary NULL-check.
Thread-Topic: [PATCH] brcmfmac: Remove unnecessary NULL-check.
Thread-Index: AQHaXPu8Ul+O+I0pZkCmdWukSCEYrLEFU9mAgAAAXgCAAP98EA==
Date: Mon, 12 Feb 2024 07:52:21 +0000
Message-ID: <766583ee1500472b8c1285bb2d9b0e9b@aladdin.ru>
References: <20240211150516.3475-1-d.dulov@aladdin.ru>
 <60a0a753-47ba-4f80-b93e-2878f214bc3c@broadcom.com>
 <6afd3242-a691-4ad5-a849-ab1d02baa6d0@broadcom.com>
In-Reply-To: <6afd3242-a691-4ad5-a849-ab1d02baa6d0@broadcom.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
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

SGVsbG8hDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldyEgSSdsbCBjb3JyZWN0IHRoZSBwYXRj
aCBhbmQgc2VuZCB0aGUgMm5kIHZlcnNpb24gdG9kYXkuDQoNCkRhbmlpbCBEdWxvdg0KDQoNCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBcmVuZCB2YW4gU3ByaWVsIFttYWlsdG86
YXJlbmQudmFuc3ByaWVsQGJyb2FkY29tLmNvbV0gDQpTZW50OiBTdW5kYXksIEZlYnJ1YXJ5IDEx
LCAyMDI0IDEwOjI3IFBNDQpUbzogRGFuaWlsIER1bG92IDxELkR1bG92QGFsYWRkaW4ucnU+OyBL
YWxsZSBWYWxvIDxrdmFsb0Bjb2RlYXVyb3JhLm9yZz4NCkNjOiBEYXZpZCBTLiBNaWxsZXIgPGRh
dmVtQGRhdmVtbG9mdC5uZXQ+OyBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgUGll
dGVyLVBhdWwgR2llc2JlcnRzIDxwaWV0ZXJwZ0Bicm9hZGNvbS5jb20+OyBGcmFua3kgKFpoZW5o
dWkpIExpbiA8ZnJhbmt5bEBicm9hZGNvbS5jb20+OyBKb2huIFcuIExpbnZpbGxlIDxsaW52aWxs
ZUB0dXhkcml2ZXIuY29tPjsgS2FuIFlhbiA8a2FueWFuQGJyb2FkY29tLmNvbT47IGxpbnV4LXdp
cmVsZXNzQHZnZXIua2VybmVsLm9yZzsgYnJjbTgwMjExLWRldi1saXN0LnBkbEBicm9hZGNvbS5j
b207IFNIQS1jeWZtYWMtZGV2LWxpc3RAaW5maW5lb24uY29tOyBuZXRkZXZAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsdmMtcHJvamVjdEBsaW51eHRlc3Rp
bmcub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBicmNtZm1hYzogUmVtb3ZlIHVubmVjZXNzYXJ5
IE5VTEwtY2hlY2suDQoNCk9uIDIvMTEvMjAyNCA4OjI1IFBNLCBBcmVuZCB2YW4gU3ByaWVsIHdy
b3RlOg0KPiBPbiAyLzExLzIwMjQgNDowNSBQTSwgRGFuaWlsIER1bG92IHdyb3RlOg0KPj4gSW4g
dGhpcyBjYXNlIHJlcSB3aWxsIG5ldmVyIGJlIE5VTEwsIHNvIHJlbW92ZSB1bm5lY2Vzc2FyeSBj
aGVjay4NCj4+DQo+PiBGb3VuZCBieSBMaW51eCBWZXJpZmljYXRpb24gQ2VudGVyIChsaW51eHRl
c3Rpbmcub3JnKSB3aXRoIFNWQUNFLg0KPiANCj4gTG9va3MgZ29vZCB0byBtZSwgYnV0IHdoZW4g
ZG8gd2UgY2FsbCB0aGluZ3MgYSAiZml4IiBhbmQgd2hlbiBpcyANCj4gImltcHJvdmVtZW50IiBt
b3JlIGFwcHJvcHJpYXRlLg0KPiANCj4+IEZpeGVzOiA3MWJiMjQ0YmEyZmQgKCJicmNtODAyMTE6
IGZtYWM6IGFkZCBVU0Igc3VwcG9ydCBmb3IgDQo+PiBiY200MzIzNS82LzggY2hpcHNldHMiKQ0K
PiBSZXZpZXdlZC1ieTogQXJlbmQgdmFuIFNwcmllbCA8YXJlbmQudmFuc3ByaWVsQGJyb2FkY29t
LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IERhbmlpbCBEdWxvdiA8ZC5kdWxvdkBhbGFkZGluLnJ1
Pg0KPj4gLS0tDQo+PiDCoCBkcml2ZXJzL25ldC93aXJlbGVzcy9icm9hZGNvbS9icmNtODAyMTEv
YnJjbWZtYWMvdXNiLmMgfCAzICstLQ0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9icm9hZGNvbS9icmNtODAyMTEvYnJjbWZtYWMvdXNiLmMgDQo+PiBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1hYy91c2IuYw0KPj4gaW5kZXggOWZi
NjhjMmRjN2UzLi4zOGU0ZTRmMzJhMzkgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9icm9hZGNvbS9icmNtODAyMTEvYnJjbWZtYWMvdXNiLmMNCj4+ICsrKyBiL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL2Jyb2FkY29tL2JyY204MDIxMS9icmNtZm1hYy91c2IuYw0KPj4gQEAgLTQ1
NSw4ICs0NTUsNyBAQCBicmNtZl91c2JkZXZfcWluaXQoc3RydWN0IGxpc3RfaGVhZCAqcSwgaW50
IHFzaXplKQ0KPj4gwqDCoMKgwqDCoCBicmNtZl9lcnIoImZhaWwhXG4iKTsNCj4+IMKgwqDCoMKg
wqAgd2hpbGUgKCFsaXN0X2VtcHR5KHEpKSB7DQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmVxID0g
bGlzdF9lbnRyeShxLT5uZXh0LCBzdHJ1Y3QgYnJjbWZfdXNicmVxLCBsaXN0KTsNCj4+IC3CoMKg
wqDCoMKgwqDCoCBpZiAocmVxKQ0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdXNiX2ZyZWVf
dXJiKHJlcS0+dXJiKTsNCj4+ICvCoMKgwqDCoMKgwqDCoCB1c2JfZnJlZV91cmIocmVxLT51cmIp
Ow0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGxpc3RfZGVsKHEtPm5leHQpOw0KPj4gwqDCoMKgwqDC
oCB9DQo+IA0KPiBBeSB5b3UgYXJlIGFscmVhZHkgdG91Y2hpbmcgdGhpcyBjb2RlIHlvdSBjb3Vs
ZCBjb25zaWRlciB1c2luZyANCj4gbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKCkuDQoNClRoYXQg
IkF5IHlvdSBhcmUgLi4uIiBzaG91bGQgYmUgIkFzIHlvdSBhcmUgLi4uIi4NCg0KPj4gwqDCoMKg
wqDCoCBrZnJlZShyZXFzKTsNCg==

