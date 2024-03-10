Return-Path: <linux-kernel+bounces-98307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBE4877832
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 20:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AAFA280F0A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 19:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E93139FDD;
	Sun, 10 Mar 2024 19:21:29 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0443A3065B
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 19:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710098488; cv=none; b=u+kh18LK9pjeRVeYkp9X3lQjJ0rZQSSxRDTLPKvU4KQ1HkD+SFokrDEJRBmHkNuad51dbqKLSJjT8ZDppROpWrOO9cmt+1rkNEZrFmspEIwpoi9+cNahYDhwvj0sDauRqVcUbfoKvyAiQIv9wP8N2pODupaRfUZjX0lGWQqLmbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710098488; c=relaxed/simple;
	bh=70k3ELYwo8APY5Flhg9BYAtyoC9Ry466M+E2QAHKOjs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=n6/GMbdq/2yOIGyUEEhznzNaRIyzJzDlkhucQKv/6BrDItYFnDi+vRza/jmmnYyd384SEPLcqM4Zz+G9WCIYEOOf83DYUpa/fCdahkmhc81albSStmEhHs6+OpJaDomD04NtmhqppQSQVRjMUgzvjS7kFVOeJUrEXPijXd9CPbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-129-0f0pknVrNz6uFqbPFuYfrw-1; Sun, 10 Mar 2024 19:21:22 +0000
X-MC-Unique: 0f0pknVrNz6uFqbPFuYfrw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 10 Mar
 2024 19:21:32 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 10 Mar 2024 19:21:32 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Alexey Dobriyan' <adobriyan@gmail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sysfs: make sysfs_emit() return ssize_t
Thread-Topic: [PATCH] sysfs: make sysfs_emit() return ssize_t
Thread-Index: AQHacSGUwrSw/pXJ00e4g0Ogucny5LExWxcw
Date: Sun, 10 Mar 2024 19:21:32 +0000
Message-ID: <333d84d215c44589840e18cec9108fb0@AcuMS.aculab.com>
References: <33cd8f96-4b4f-4741-ac05-ef1bd267ce6b@p183>
 <2024030713-favorably-liking-2135@gregkh>
 <f57ab790-d0a5-4454-977b-9bdc146e6e93@p183>
In-Reply-To: <f57ab790-d0a5-4454-977b-9bdc146e6e93@p183>
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

RnJvbTogQWxleGV5IERvYnJpeWFuDQo+IFNlbnQ6IDA4IE1hcmNoIDIwMjQgMDY6MjYNCj4gDQo+
IE9uIFRodSwgTWFyIDA3LCAyMDI0IGF0IDEwOjA0OjQxUE0gKzAwMDAsIEdyZWcgS3JvYWgtSGFy
dG1hbiB3cm90ZToNCj4gPiBPbiBNb24sIEZlYiAwNSwgMjAyNCBhdCAwMToxMTozNlBNICswMzAw
LCBBbGV4ZXkgRG9icml5YW4gd3JvdGU6DQo+ID4gPiBzeXNmc19lbWl0KCkgaXMgbW9zdCBvZnRl
biBmb3VuZCBpbiBmdW5jdGlvbnMgcmV0dXJuaW5nIHNzaXplX3QNCj4gPiA+IG5vdCBpbnQ6DQo+
ID4gPg0KPiA+ID4gCXN0YXRpYyBzc2l6ZV90IG9vcHNfY291bnRfc2hvdyguLi4pDQo+ID4gPiAJ
ew0KPiA+ID4gCQlyZXR1cm4gc3lzZnNfZW1pdChwYWdlLCAuLi4pOw0KPiA+ID4gCX0NCj4gPiA+
DQo+ID4gPiBUaGlzIHBhdHRlcm4gcmVzdWx0cyBpbiBzaWduLWV4dGVuc2lvbiBpbnN0cnVjdGlv
biBiZXR3ZWVuDQo+ID4gPiBzeXNmc19lbWl0KCkgcmV0dXJuIHZhbHVlIChpbnQpIGFuZCBjYWxs
ZXIgcmV0dXJuIHZhbHVlICh3aGljaCBpcw0KPiA+ID4gc3NpemVfdCkuDQo+ID4NCj4gPiBJcyB0
aGF0IGEgcHJvYmxlbT8NCj4gDQo+IFNtYWxsIHByb2JsZW0sIGJ1dCwgeWVzLg0KPiANCj4gSWYg
c3lzZnNfZW1pdCgpIHJldHVybnMgImludCIsIHRoZW4gZXZlcnkgdXNlciBjb21waWxlcyB0bw0K
PiANCj4gCWNhbGwJc3lzZnNfZW1pdA0KPiAJbW92c3gJcmF4LCBlYXgNCj4gCXJldA0KPiANCj4g
R2l2ZW4gdGhhbiBzeXNmc19lbWl0KCkgaXMgdGhlIG9mZmljaWFsIHdheSB0byBwcmludCBpbiBz
eXNmcywNCj4gdGhlcmUgYXJlIGxvdHMgb2YgdXNlcnMgYW5kIHRoZXJlIHdpbGwgYmUgbW9yZSB1
c2VycyBpbiB0aGUgZnV0dXJlDQo+IGFzIGl0IGdyb3dzLg0KPiANCj4gVGhpcyB0cmFpbGluZyAi
bW92c3giIGluc3RydWN0aW9uIGlzIGR1cGxpY2F0ZWQgZXZlcnkgdGltZS4NCg0KQWN0dWFsbHkg
eW91IGFyZSBtaXNzaW5nIGEgdGFpbCBjYWxsLi4uDQpCdXQgbm8gb25lIHdpbGwgbm90aWNlIHRo
ZSBleHRyYSBleGVjdXRpb24gdGltZSwgaXQgd2lsbA0KYmUgbWFza2VkIGJ5IHRoZSBjb3N0IG9m
IHRoZSBmb3JtYXR0aW5nLg0KU28gaXQgaXMgYSBzbWFsbCBhbW91bnQgb2YgSS1jYWNoZS4NCg0K
SW4gcmVhbGl0eSB0aGUgYmVzdCBmaXggaXMgbm90IHRvIHVzZSBzc2l6ZV90IGZvciBzb21ldGhp
bmcNCndoZXJlIHRoZSBkb21haW4gb2YgdGhlIHZhbHVlIGlzIG11Y2ggc21hbGxlci4NCkluIHRo
aXMgY2FzZSBpdCBpcyBwcm9iYWJseSB1bnNpZ25lZCBhcyB3ZWxsLg0KDQpFZmZpY2llbnQgY2Fs
bGluZyBjb252ZW50aW9ucyBmb3IgNjRiaXQgY29kZSBwcm9iYWJseSByZXF1aXJlDQphbGwgbm9u
LW5lZ2F0aXZlIHR5cGVzIGJlIHBhc3NlZC9yZXR1cm5lZCBhcyAndW5zaWduZWQgbG9uZycgYW5k
DQp0aGVuIGNvcGllZCB0byBhbiAndW5zaWduZWQgaW50JyB0byBnZXQgYmV0dGVyIGNvZGUgZ2Vu
ZXJhdGlvbi4NClNpZ25lZCB2YWx1ZXMgYXJlIG11Y2ggbW9yZSBkaWZmaWN1bHQgdGhvdWdoLg0K
QnV0IHVubGVzcyB5b3UgYXJlIHRyeWluZyB0byBnZXQgdGhhdCBsYXN0IGV4dHJhIGNsb2NrIHRo
ZXJlDQphcmUgbGlrZWx5IHRvIGJlIG11Y2ggbG93ZXIgaGFuZ2luZyBmcnVpdC4NCg0KCURhdmlk
DQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBG
YXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2
IChXYWxlcykNCg==


