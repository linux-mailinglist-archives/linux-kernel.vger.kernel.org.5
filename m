Return-Path: <linux-kernel+bounces-118827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F2C88BFCD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D6951C240EE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BAE746E;
	Tue, 26 Mar 2024 10:47:43 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556933C30;
	Tue, 26 Mar 2024 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711450063; cv=none; b=hXZR2TS29rigl8tkouyPnqsRCRcbofknuokl4FjXfAIypn3nocJLTK6PomvmH81of9DW4eC5vkuCkA2roITCPBznrgeJKnl1e4vDtnGHxiRvmEMUHiRdI8NKgtni+jOjs8VlracGpeLkYXD6BX7BUmXHW3qtqgSz51RgpKYVv+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711450063; c=relaxed/simple;
	bh=e8abdu1tcmiI2xK+Ds67Ozww6jto271BJbcS9taJliU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bXwMKDeE1wuTq0gM2iZrdcSKwfV6Y2Hl/pxYYJfmUZAh+xDg8XtbWDyuf5cagLS9oZ78FvZ5TfuZp5PG/Klvq4RI0Tsges5n/q+AYcEyisdg8kGgWcoRIP/xQLu5eF573VBTqQ/WAOZyKW+5Pk1pq+ox9QlO0S8zAldI4veJ1jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 42QAlIKu022823;
	Tue, 26 Mar 2024 18:47:18 +0800 (+08)
	(envelope-from surong.pang@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4V3mfn1MLpz2LsfGh;
	Tue, 26 Mar 2024 18:45:37 +0800 (CST)
Received: from shmbx05.spreadtrum.com (10.29.1.56) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 26 Mar
 2024 18:47:16 +0800
Received: from shmbx05.spreadtrum.com ([fe80::3169:eec0:7a15:2543]) by
 shmbx05.spreadtrum.com ([fe80::3169:eec0:7a15:2543%16]) with mapi id
 15.00.1497.023; Tue, 26 Mar 2024 18:47:16 +0800
From: =?utf-8?B?5bqe6IuP6I2jIChTdXJvbmcgUGFuZyk=?= <surong.pang@unisoc.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?57+f5LqsIChPcnNvbiBaaGFpKQ==?= <Orson.Zhai@unisoc.com>,
        =?utf-8?B?5YiY5pm65YuHIChaaGl5b25nIExpdSk=?= <Zhiyong.Liu@unisoc.com>,
        "Surong.Pang@gmail.com" <Surong.Pang@gmail.com>
Subject: Re: [PATCH] usb: gadget: rndis: add multi packages support for rndis
Thread-Topic: [PATCH] usb: gadget: rndis: add multi packages support for rndis
Thread-Index: Adp/akWVC9LH/DiDSWmkHtRpuRTpKg==
Date: Tue, 26 Mar 2024 10:47:16 +0000
Message-ID: <9d39b91505c4449f98e8431e2f257f8b@shmbx05.spreadtrum.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MAIL:SHSQR01.spreadtrum.com 42QAlIKu022823

RGVhciBHcmVn77yMDQpTaGFyZSBBbmRyb2lkIFBob25lIGludGVybmV0IHRvIFdpbmRvd3MgUEMg
dmlhIFVTQiBzdGlsbCBuZWVkIHRoZSBybmRpcyBmZWF0dXJlLg0KT0ssIGlmIHJuZGlzIHdpbGwg
YmUgZGVsZXRlZCBlbnRpcmVseSwgdGhpcyBwYXRjaCBjYW4gYmUgYWJhbmRvbmVkLg0KDQo+IA0K
PiANCj4gT24gV2VkLCBNYXIgMDYsIDIwMjQgYXQgMDE6NDk6NDlQTSArMDgwMCwgU3Vyb25nIFBh
bmcgd3JvdGU6DQo+ID4gQXMgbmNtLCBhZ2dlcmdhdGUgbXVsdGkgc2tiIHBhY2thZ2VzIGFuZCB0
cmFuc2ZlciB0aGVtIGF0IG9uZSBVUkIuDQo+ID4gSW4gVVNCMi4wLCB0aGUgbmV0d29yayB0aHJv
dWdocHV0IGNhbiBiZSBpbXByb3ZlZCBmcm9tIGFib3V0IDE4TUIvUyB0bw0KPiA+IDM1TUIvUy4N
Cj4gDQo+IFdoeSBpcyBybmRpcyBzdGlsbCBiZWluZyB1c2VkPyAgSXQncyBhbiBpbnNlY3VyZSBh
bmQgb2Jzb2xldGUgcHJvdG9jb2wgdGhhdCBzaG91bGQgbm90IGJlIHVzZWQgYXQgYWxsIGFueXdo
ZXJlLiAgSSBrZWVwIHRyeWluZyB0byBkZWxldGUgaXQNCj4gZW50aXJlbHksIGJ1dCBuZWVkIHRv
IGdvIGFuZCB3cml0ZSBhbiBhY3RpdmUgZXhwbG9pdCB0byBwcm92ZSB0byBwZW9wbGUganVzdCBo
b3cgYmFkIGl0IHJlYWxseSBpcyBiZWZvcmUgSSBjYW4gZG8gc28uLi4NCj4gDQo+IEFkZGluZyBt
b3JlIGZ1bmN0aW9uYWxpdHkgdG8gaXQgaXMgbm90IGEgZ29vZCBpZGVhLCB3aGF0IGlzIHdyb25n
IHdpdGggdGhlIG90aGVyLCBidWlsdC1pbiwgbmV0d29ya2luZyBwcm90b2NvbHMgaW5zdGVhZD8g
IFdoeSBhcmUgeW91DQo+IHVzaW5nIHRoaXMgb2xkIG9uZSBzdGlsbCB3aGVuIHRoZXJlIGFyZSBz
byBtYW55IGJldHRlciBvcHRpb25zIG91dCB0aGVyZT8NCj4gDQo+IHRoYW5rcywNCj4gDQo+IGdy
ZWcgay1oDQo=

