Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0775B8027D9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 22:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbjLCVPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 16:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCVPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 16:15:03 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C724CD6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 13:15:08 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-304-X4AvT-tEMg2K4WwiKTdRmw-1; Sun, 03 Dec 2023 21:15:05 +0000
X-MC-Unique: X4AvT-tEMg2K4WwiKTdRmw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 3 Dec
 2023 21:14:49 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 3 Dec 2023 21:14:49 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Zack Rusin <zackr@vmware.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "VMware Graphics Reviewers" <linux-graphics-maintainer@vmware.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Raul Rangel <rrangel@chromium.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] input/vmmouse: Fix device name copies
Thread-Topic: [PATCH] input/vmmouse: Fix device name copies
Thread-Index: AQHaJipxBM/uGJI7Q0K7wjneTI1KYbCYDPww
Date:   Sun, 3 Dec 2023 21:14:49 +0000
Message-ID: <f3e6cab719c646bf91265b6fd2887061@AcuMS.aculab.com>
References: <20231127204206.3593559-1-zack@kde.org>
 <ZWzLvctpo1nNTMOo@google.com>
 <d180f06b-64b0-4885-9794-5127c297a0f0@app.fastmail.com>
In-Reply-To: <d180f06b-64b0-4885-9794-5127c297a0f0@app.fastmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAwMyBEZWNlbWJlciAyMDIzIDIwOjUxDQo+IE9u
IFN1biwgRGVjIDMsIDIwMjMsIGF0IDE5OjQxLCBEbWl0cnkgVG9yb2tob3Ygd3JvdGU6DQo+ID4g
T24gTW9uLCBOb3YgMjcsIDIwMjMgYXQgMDM6NDI6MDZQTSAtMDUwMCwgWmFjayBSdXNpbiB3cm90
ZToNCj4gPj4gRnJvbTogWmFjayBSdXNpbiA8emFja3JAdm13YXJlLmNvbT4NCj4gPj4NCj4gPj4g
TWFrZSBzdXJlIHZtbW91c2VfZGF0YTo6cGh5cyBjYW4gaG9sZCBzZXJpbzo6cGh5cyAod2hpY2gg
aXMgMzIgYnl0ZXMpDQo+ID4+IHBsdXMgYW4gZXh0cmEgc3RyaW5nLCBleHRlbmQgaXQgdG8gNjQu
DQo+ID4+DQo+ID4+IEZpeGVzIGdjYzEzIHdhcm5pbmdzOg0KPiA+PiBkcml2ZXJzL2lucHV0L21v
dXNlL3ZtbW91c2UuYzogSW4gZnVuY3Rpb24g4oCYdm1tb3VzZV9pbml04oCZOg0KPiA+PiBkcml2
ZXJzL2lucHV0L21vdXNlL3ZtbW91c2UuYzo0NTU6NTM6IHdhcm5pbmc6IOKAmC9pbnB1dDHigJkg
ZGlyZWN0aXZlIG91dHB1dCBtYXkgYmUgdHJ1bmNhdGVkIHdyaXRpbmcNCj4gNyBieXRlcyBpbnRv
IGEgcmVnaW9uIG9mIHNpemUgYmV0d2VlbiAxIGFuZCAzMiBbLVdmb3JtYXQtdHJ1bmNhdGlvbj1d
DQo+ID4+ICAgNDU1IHwgICAgICAgICBzbnByaW50Zihwcml2LT5waHlzLCBzaXplb2YocHJpdi0+
cGh5cyksICIlcy9pbnB1dDEiLA0KPiA+PiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+DQo+ID4+IGRyaXZlcnMvaW5wdXQv
bW91c2Uvdm1tb3VzZS5jOjQ1NTo5OiBub3RlOiDigJhzbnByaW50ZuKAmSBvdXRwdXQgYmV0d2Vl
biA4IGFuZCAzOSBieXRlcyBpbnRvIGENCj4gZGVzdGluYXRpb24gb2Ygc2l6ZSAzMg0KPiA+PiAg
IDQ1NSB8ICAgICAgICAgc25wcmludGYocHJpdi0+cGh5cywgc2l6ZW9mKHByaXYtPnBoeXMpLCAi
JXMvaW5wdXQxIiwNCj4gPj4gICAgICAgfCAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+ID4+ICAgNDU2IHwgICAgICAgICAgICAg
ICAgICBwc21vdXNlLT5wczJkZXYuc2VyaW8tPnBoeXMpOw0KPiA+PiAgICAgICB8ICAgICAgICAg
ICAgICAgICAgfn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiA+DQo+ID4gVGhpcyBzaW1w
bHkgd2FzdGVzIDMyIGJ5dGVzLiBJdCBpcyBwZXJmZWN0bHkgZmluZSB0byB0cnVuY2F0ZSBwaHlz
DQo+ID4gKHdoaWNoIGRvZXMgbm90IGhhcHBlbiBpbiByZWFsIGxpZmUpLg0KPiA+DQo+ID4gLVdm
b3JtYXQtdHJ1bmNhdGlvbiBpcyBkaXNhYmxlZCBpbiBub3JtYWwgYnVpbGRzLCBmb2xrcyBzaG91
bGQgc3RvcA0KPiA+IHVzaW5nIGl0IHdpdGggVz0xIGFzIHdlbGwuDQo+IA0KPiBJdCBkb2VzIGZp
bmQgcmVhbCBidWdzLCBhbmQgd2UgYXJlIGZhaXJseSBjbG9zZSB0byBiZWluZyBhYmxlDQo+IHRv
IGVuYWJsZSBpdCBieSBkZWZhdWx0IG9uY2UgdGhlIHJlbWFpbmluZyB3YXJuaW5ncyBhcmUgYWxs
DQo+IGZpeGVkLg0KPiANCj4gSXQgYWxzbyBkb2Vzbid0IHdhc3RlIGFueSBtZW1vcnkgaW4gdGhp
cyBzcGVjaWZpYyBjYXNlIHNpbmNlDQo+IHZtbW91c2VfZGF0YSBpcyBjdXJyZW50bHkgYXQgMTY4
IGJ5dGVzLCB3aGljaCBnZXRzIHJvdW5kZWQNCj4gdXAgdG8gZWl0aGVyIDE5MiBvciAyNTYgYnl0
ZXMgYW55d2F5LiBJJ2Qgc3VnZ2VzdCB1c2luZw0KPiB0aGUgbWluaW11bSBzaXplIHRoYXQgaXMg
bGFyZ2UgZW5vdWdoIHRob3VnaCwgaW4gdGhpcyBjYXNlDQo+IDM5IGJ5dGVzIGZvciB0aGUgc3Ry
aW5nIEkgZ3Vlc3MuDQoNClRoYXQgcmF0aGVyIGRlcGVuZHMgb24gd2hldGhlciBhbnkgb2YgdGhl
IGVhcmxpZXIgY2hhcltdIGxlbmd0aHMNCmhhdmUgYmVlbiByb3VuZGVkIHVwIHRvIGEgJ25pY2Un
IHZhbHVlLg0KDQpJJ2QgYWxzbyBoYXZlIHRob3VnaHQgdGhhdCBkYW5nZXJvdXMgb3ZlcmZsb3dz
IHdvdWxkIGNvbWUgZnJvbQ0KdW5ib3VuZGVkICVzIGZvcm1hdHMsIG5vdCBmaXhlZCBzaXplIHN0
cmluZ3Mgb3IgaW50ZWdlcnMgdGhhdCBhcmUNCmFsd2F5cyBzbWFsbC4NCg0KVGhlcmUgcmVhbGx5
IG91Z2h0IHRvIGJlIGEgc2FuZSBtZXRob2Qgb2YgdGVsbGluZyBnY2Mgbm90IHRvIGJsZWF0DQph
Ym91dCBzbnByaW50ZigpIHBvdGVudGlhbGx5IG92ZXJmbG93aW5nIHRoZSB0YXJnZXQuDQoNCkkn
dmUgdHJpZWQgYSBmZXcgdGhpbmcgYnV0IG5vbmUgb2YgdGhlbSB3b3JrLg0KSUlSQyB1c2luZyB0
aGUgcmVzdWx0IChpbiBzb21lIHdheXMpIGlzIGVub3VnaCwgYnV0IG5laXRoZXINCih2b2lkKXNu
cHJpbnRmKC4uLik7IG9yIGlmIChzbnByaW50ZiguLi4pKTsgaXMgZW5vdWdoDQooYnV0IHRoZXkg
J2ZpeCcgJ3dhcm4gdW51c2VkIHJlc3VsdCcpLg0KDQoJRGF2aWQNCg0KPiANCj4gICAgICBBcm5k
DQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBG
YXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2
IChXYWxlcykNCg==

