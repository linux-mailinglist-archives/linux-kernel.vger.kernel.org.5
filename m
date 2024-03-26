Return-Path: <linux-kernel+bounces-118837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5814D88BFEF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111C52E5153
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCF012B87;
	Tue, 26 Mar 2024 10:53:02 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432065C99;
	Tue, 26 Mar 2024 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711450381; cv=none; b=aEPBO1vvAfMvDiBulMgMJ6eoK5gLS442+QA8iGMCRfWGUfjzX3gJPlAqrgNiC6VcwxkITnBtis+GQI4eLiBMsVm1hu3zdb2XrAgKV2XEMirtyhT6rh/xGaUG6dLsbGjtaoS/swnpG9n9ZkIFitxIKaiEOfJYGTW0ykh4w99rQqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711450381; c=relaxed/simple;
	bh=Go7aUeZIPQV1AB3KkjTSpZ3prin5O2xCjTt1dDlaYZI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=u3ISYsus5A0OberVqjN7mNt+2CfZiJc4v+cbcMqPvBMhyWHjmtstqzHv+2p2O1u1X+D57e3yMPBpo4hZTgNZOCFriAntzEH7k/fRte6hr6tL7V8pOrlxeLnDs9sWItWmHCLpZlieLPHETfUI8QwVvPuM4d5do/gR7xhoWK4GWq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 42QAqlfv029882;
	Tue, 26 Mar 2024 18:52:47 +0800 (+08)
	(envelope-from surong.pang@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx02.spreadtrum.com [10.0.1.204])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4V3mn62WY6z2LsfGk;
	Tue, 26 Mar 2024 18:51:06 +0800 (CST)
Received: from shmbx05.spreadtrum.com (10.29.1.56) by SHMBX02.spreadtrum.com
 (10.0.1.204) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 26 Mar
 2024 18:52:46 +0800
Received: from shmbx05.spreadtrum.com ([fe80::3169:eec0:7a15:2543]) by
 shmbx05.spreadtrum.com ([fe80::3169:eec0:7a15:2543%16]) with mapi id
 15.00.1497.023; Tue, 26 Mar 2024 18:52:45 +0800
From: =?utf-8?B?5bqe6IuP6I2jIChTdXJvbmcgUGFuZyk=?= <surong.pang@unisoc.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?57+f5LqsIChPcnNvbiBaaGFpKQ==?= <Orson.Zhai@unisoc.com>,
        =?utf-8?B?5YiY5pm65YuHIChaaGl5b25nIExpdSk=?= <Zhiyong.Liu@unisoc.com>,
        "Surong.Pang@gmail.com" <Surong.Pang@gmail.com>
Subject: Re: [PATCH] usb: gadget: rndis: add multi packages support for rndis
Thread-Topic: [PATCH] usb: gadget: rndis: add multi packages support for rndis
Thread-Index: Adp/a7tzqpcaU9L4T8+iYzgAPdl2KQ==
Date: Tue, 26 Mar 2024 10:52:45 +0000
Message-ID: <4a9042d738d94d5da1457260185c95d6@shmbx05.spreadtrum.com>
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
X-MAIL:SHSQR01.spreadtrum.com 42QAqlfv029882

RGVhciBHcmVnLA0KDQpUaGVzZSB2YWx1ZXMgYXJlIGp1c3QgdXNlZCB0byByZWNvcmRlZCB3YXRl
ciBtYXNrIG9mIHJlY2VpdmVkIHBhY2thZ2VzIHBlciB0cmFuc2Zlci4NCkp1c3QgdG8gcHJpbnQg
dGhlIHdhdGVyIG1hc2sgaW5mb3JtYXRpb24sIHRoZXkgY2FuIGJlIGRlbGV0ZWQuDQoNCkFueXdh
eSwgaWYgcm5kaXMgd2lsbCBiZSBkZWxldGVkIGVudGlyZWx5LCB0aGlzIHBhdGNoIGNhbiBiZSBh
YmFuZG9uZWQuDQoNCj4gDQo+IA0KPiBPbiBXZWQsIE1hciAwNiwgMjAyNCBhdCAwMTo0OTo0OVBN
ICswODAwLCBTdXJvbmcgUGFuZyB3cm90ZToNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQv
ZnVuY3Rpb24vcm5kaXMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9y
bmRpcy5jDQo+ID4gQEAgLTM5LDYgKzM5LDggQEANCj4gPg0KPiA+ICAjaW5jbHVkZSAicm5kaXMu
aCINCj4gPg0KPiA+ICtzdGF0aWMgaW50IG1heF9vdXRfcGt0c19wZXJfeGZlcjsNCj4gPiArc3Rh
dGljIGludCBtYXhfb3V0X3NpemVfcGVyX3hmZXI7DQo+IA0KPiBOb3RlLCB0aGlzIHdpbGwgbm90
IHdvcmssIHlvdSBjYW4ndCBoYXZlIGRldmljZS1zcGVjaWZpYyB2YXJpYWJsZXMgYXMgYSBzaW5n
bGUgZW50cnksIG90aGVyd2lzZSBtdWx0aXBsZSBkZXZpY2VzIGF0IHRoZSBzYW1lIHRpbWUgd2ls
bCBub3QNCj4gd29yayBhdCBhbGwuDQo+IA0KPiB0aGFua3MsDQo+IA0KPiBncmVnIGstaA0K

