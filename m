Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824087D7F19
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344537AbjJZI5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjJZI5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:57:18 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE386129
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:57:15 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-189-oDjpJJgrPuajMzD05ByH3Q-1; Thu, 26 Oct 2023 09:57:12 +0100
X-MC-Unique: oDjpJJgrPuajMzD05ByH3Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 26 Oct
 2023 09:57:11 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 26 Oct 2023 09:57:11 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>
CC:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: RE: [PATCH v4 1/3] math.h: add DIV_ROUND_UP_NO_OVERFLOW
Thread-Topic: [PATCH v4 1/3] math.h: add DIV_ROUND_UP_NO_OVERFLOW
Thread-Index: AQHaB2rGM+Cp9N+qfkK9yv140Cm+RbBbwb/A
Date:   Thu, 26 Oct 2023 08:57:11 +0000
Message-ID: <055dd714f98f4e45b2add561b7663378@AcuMS.aculab.com>
References: <20231024161931.78567-1-sebastian.reichel@collabora.com>
 <20231024161931.78567-2-sebastian.reichel@collabora.com>
 <CAHk-=whYDbZ29fx_xeSxtYSjtF8WJkaLjzyB8RN5_Rk9Sh-YyQ@mail.gmail.com>
 <CAHk-=wjO5ivM6k7iMiThO9JfxH0dhLe=mcC4TQwReU0nBCnWpg@mail.gmail.com>
 <your-ad-here.call-01698246313-ext-3263@work.hours>
 <CAHk-=wgs2DDdckcONG+YbB-GDH2QFCoZJ=Vm+YXxb1moZzuDgQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgs2DDdckcONG+YbB-GDH2QFCoZJ=Vm+YXxb1moZzuDgQ@mail.gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjUgT2N0b2JlciAyMDIzIDE4OjQ0DQo+IA0K
PiBPbiBXZWQsIDI1IE9jdCAyMDIzIGF0IDA1OjA1LCBWYXNpbHkgR29yYmlrIDxnb3JAbGludXgu
aWJtLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBZb3UgcHJvYmFibHkgd2FudA0KPiA+DQo+ID4gICNk
ZWZpbmUgX19kaXZfcm91bmRfdXAobixkKSBfR2VuZXJpYygobikrKGQpLCAgICAgICAgICBcDQo+
ID4gICAgICAgICB1bnNpZ25lZCBsb25nIGxvbmc6IF9fZGl2X3JvdW5kX3VwX3VsbCwgICAgICAg
ICBcDQo+ID4gICAgICAgICBsb25nIGxvbmc6IF9fZGl2X3JvdW5kX3VwX2xsLCAgICAgICAgICAg
ICAgICAgICBcDQo+ID4gICAgICAgICB1bnNpZ25lZCBsb25nOiBfX2Rpdl9yb3VuZF91cF91bCwg
ICAgICAgICAgICAgICBcDQo+ID4gICAgICAgICBsb25nOiBfX2Rpdl9yb3VuZF91cF9sLCAgICAg
ICAgICAgICAgICAgICAgICAgICBcDQo+ID4gICAgICAgICB1bnNpZ25lZCBpbnQ6IF9fZGl2X3Jv
dW5kX3VwX3UsICAgICAgICAgICAgICAgICBcDQo+ID4gICAgICAgICBpbnQ6IF9fZGl2X3JvdW5k
X3VwX2kpKG4sZCkNCj4gPg0KPiA+IHRvIGF2b2lkIGVhcmx5IHR5cGUtY2hlY2tpbmcgZm9yIGV4
cHJlc3Npb25zIHRoYXQgd2lsbCBiZSBkaXNjYXJkZWQNCj4gPiBhbmQgcHJldmVudCBlcnJvcnMg
bGlrZToNCj4gDQo+IEFjay4gSSBub3RpY2VkIHRoYXQgbGF0ZXIgd2hlbiBJIHRyaWVkIHRvIGRv
IGEgYmlnZ2VyIGNvbmZpZyBidWlsZCAtDQo+IHRoZSBjb21waWxlciB3b3VsZCB3YXJuIGFib3V0
IHRoZSBpbXBsaWNpdCB0cnVuY2F0aW9uIG9mIHRoZSBpbnRlZ2VyDQo+IGFyZ3VtZW50cyAoZm9y
IHRoZSBjYXNlcyB3aGVyZSB0aGV5IHdlcmVuJ3QgdXNlZCkuDQo+IA0KPiA+IFBsdXMgdHlwb3Mg
Zml4ZXMgYmVsb3cgcGFzc2VzIGFsbHllc2NvbmZpZyBmb3IgczM5MCwgMzItYml0IHg4NiBhbmQg
YXJtLg0KPiANCj4gTG92ZWx5Lg0KPiANCj4gSXQgd291bGQgaGF2ZSBiZWVuIGV2ZW4gYmV0dGVy
IGlmIHNvbWVib2R5IHRvbGQgbWUgdGhhdCBJIHdhcyBzdHVwaWQNCj4gYW5kIHRoZXJlIHdhcyBz
b21lIG5pY2UgdHJpY2sgdG8gaXQsIGJ1dCBhdCBsZWFzdCB0aGUgX0dlbmVyaWMoKQ0KPiBhcHBy
b2FjaCBkb2Vzbid0IHNlZW0gYnJva2VuIC0ganVzdCBhIGZldyB0d2Vha3MgbmVlZGVkLg0KDQpE
b2Vzbid0IHRoYXQgdmVyc2lvbiBlbmQgdXAgY2FsbGluZyBpbmxpbmUgZnVuY3Rpb25zPw0KU28g
d29uJ3QgYmUgdXNhYmxlIGluIHN0YXRpYyBpbml0aWFsaXNlcnMgLSB0aGUgc2FtZSBhcyBzdGF0
ZW1lbnQgZnVuY3Rpb25zLg0KDQpXaWxsIHRoaXMgdHJpY2sgd29yazoNCiNkZWZpbmUgWkVST19V
TkxFU1NfVFlQRSh4LCB0eXBlKSBfR2VuZXJpYyh4LCB0eXBlOiB4LCBkZWZhdWx0IDApDQojZGVm
aW5lIGRpdl9ydSh0eXBlLCBmbiwgbiwgZCkgXA0KCXR5cGU6IGZuKFpFUk9fVU5MRVNTX1RZUEUo
dHlwZSwgKG4pICsgKGQpLCBuKSwgWkVST19VTkxFU1NfVFlQRSh0eXBlLCAobikgKyAoZCksIGQp
DQp0aGVuOg0KI2RlZmluZSBfX2Rpdl9yb3VuZF91cChuLCBkKSBfR2VuZXJpYygobikrKGQpLCAg
ICAgICAgICBcDQoJZGl2X3J1KHVuc2lnbmVkIGxvbmcgbG9uZywgX19kaXZfcm91bmRfdXBfdWxs
LCBuLCBkKSwNCgkuLi4NCg0KV2hpY2ggd291bGQgYWxsb3cgdGhlICdmdW5jdGlvbnMnIGJlICNk
ZWZpbmVzLg0KDQpCdXQgaXQgc3RpbGwgaGFzIHRoZSBpc3N1ZXMgb2YgZG9pbmcgJ2JpZycgZGl2
aXNpb25zLg0KQWx0aG91Z2ggdGhlIGNvbXBpbGVyIHdpbGwgdXNlIDMyYml0IChhbmQgNjQgYnkg
MzIgYml0KSBkaXZpc2lvbnMNCmZvciA2NCBiaXQgdHlwZXMgaWYgaXQga25vd3MgdGhlIHZhbHVl
cyBhcmUgc21hbGwuDQoNCmNsYW5nIHNlZW1zIHRvIGFkZCBjb25kaXRpb25hbHMgdG8gYXZvaWQg
NjR4NjQgZGl2aWRlcy4NClByb2JhYmx5IHdvcnRoIGl0IGZvciBpbnRlbCB4ODYgY3B1LCBidXQg
bm90IGZvciBhbWQgb25lcy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtl
c2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBV
Sw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

