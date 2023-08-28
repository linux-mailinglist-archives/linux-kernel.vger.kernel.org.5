Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57ED78AE07
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjH1Ky7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjH1Ky3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:54:29 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8CE198
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:54:09 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-312-yYM7kxAkNtydxSJM6giphA-1; Mon, 28 Aug 2023 11:53:09 +0100
X-MC-Unique: yYM7kxAkNtydxSJM6giphA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 28 Aug
 2023 11:53:12 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 28 Aug 2023 11:53:12 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Helge Deller <deller@gmx.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chanho Min <chanho.min@lge.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit
 kernels
Thread-Topic: [PATCH] lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit
 kernels
Thread-Index: AQHZ15Tpa0MOqrSpzEiPMMjR1E/Se6//izkQ
Date:   Mon, 28 Aug 2023 10:53:12 +0000
Message-ID: <cc5f4f5701674b96b0009b6b9b257cc8@AcuMS.aculab.com>
References: <ZOkGCSNr0VN2VIJJ@p100>
 <CAHk-=wjZwSymfuGvf7TX3UQLU1OMN1FZMnEA-Hja0ruqyhMK4A@mail.gmail.com>
 <CAHk-=whVvD05T0yD5DQj803uETLD6qDq-Vx-SiLPcrL=eO77LQ@mail.gmail.com>
In-Reply-To: <CAHk-=whVvD05T0yD5DQj803uETLD6qDq-Vx-SiLPcrL=eO77LQ@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjUgQXVndXN0IDIwMjMgMjE6NDMNCi4uLi4N
Cj4gQ2xhbmcgdHVybnMgdGhpczoNCj4gDQo+ICAgICAgICAgcmV0dXJuIF9fZmZzNjQodmFsKTsN
Cj4gDQo+IGludG8gdGhpcyBob3Jyb3I6DQo+IA0KPiAgICAgICAgIHB1c2hxICAgJXJheA0KPiAg
ICAgICAgIG1vdnEgICAgJXJkaSwgKCVyc3ApDQo+ICAgICAgICAgI0FQUA0KPiAgICAgICAgIHJl
cA0KPiAgICAgICAgIGJzZnEgICAgKCVyc3ApLCAlcmF4DQo+ICAgICAgICAgI05PX0FQUA0KPiAg
ICAgICAgIHBvcHEgICAgJXJjeA0KPiANCj4gd2hpY2ggaXMganVzdCBpbmNyZWRpYmx5IGJyb2tl
biBvbiBzbyBtYW55IGxldmVscy4gSXQgKnNob3VsZCogYmUgYQ0KPiBzaW5nbGUgaW5zdHJ1Y3Rp
b24sIGxpa2UgZ2NjIGRvZXM6DQo+IA0KPiAgICAgICAgIHJlcDsgYnNmICVyZGksJXJheCAgICAg
ICMgdG1wODcsIHdvcmQNCj4gDQo+IGJ1dCBjbGFuZyBkZWNpZGVzIHRoYXQgaXQgcmVhbGx5IHdh
bnRzIHRvIHB1dCB0aGUgYXJndW1lbnQgb24gdGhlDQo+IHN0YWNrLCBhbmQgYXBwYXJlbnRseSBh
bHNvIHdhbnRzIHRvIGRvIHRoYXQgbm9uc2Vuc2ljYWwgc3RhY2sNCj4gYWxpZ25tZW50IHRoaW5n
IHRvIG1ha2UgdGhpbmdzIGV2ZW4gd29yc2UuDQo+IA0KPiBXZSB1c2UgdGhpczoNCj4gDQo+ICAg
c3RhdGljIF9fYWx3YXlzX2lubGluZSB1bnNpZ25lZCBsb25nIHZhcmlhYmxlX19mZnModW5zaWdu
ZWQgbG9uZyB3b3JkKQ0KPiAgIHsNCj4gICAgICAgICBhc20oInJlcDsgYnNmICUxLCUwIg0KPiAg
ICAgICAgICAgICAgICAgOiAiPXIiICh3b3JkKQ0KPiAgICAgICAgICAgICAgICAgOiAicm0iICh3
b3JkKSk7DQo+ICAgICAgICAgcmV0dXJuIHdvcmQ7DQo+ICAgfQ0KPiANCj4gZm9yIHRoZSBkZWZp
bml0aW9uLCBhbmQgaXQgbG9va3MgbGlrZSBjbGFuZyByb3lhbGx5IGp1c3Qgc2NyZXdzIHVwDQo+
IGhlcmUuIFllcywgIm0iIGlzIF9hbGxvd2VkXyBpbiB0aGF0IGlucHV0IHNldCwgYnV0IGl0IGRh
bW4gd2VsbA0KPiBzaG91bGRuJ3QgYmUgdXNlZCBmb3Igc29tZXRoaW5nIHRoYXQgaXMgYWxyZWFk
eSBpbiBhIHJlZ2lzdGVyLCBzaW5jZQ0KPiAiciIgaXMgYWxzbyBhbGxvd2VkLCBhbmQgaXMgdGhl
IGZpcnN0IGNob2ljZS4NCg0KV2h5IGRvbid0IHdlIGp1c3QgcmVtb3ZlIHRoZSAibSIgb3B0aW9u
Pw0KDQpQcmV0dHkgbXVjaCB0aGUgb25seSB0aW1lIGl0IHdpbGwgYmUgd29yc2UgaXMgaXQgdGhl
IHZhbHVlDQppcyBpbiBtZW1vcnkgYW5kIGxvYWRpbmcgaXQgaW50byBhIHJlZ2lzdGVyIGNhdXNl
cyBhIHNwaWxsDQp0byBzdGFjay4NCg0KV2hpbGUgaXQgaXMgcG9zc2libGUgdG8gZ2VuZXJhdGUg
Y29kZSB3aGVyZSB0aGF0IGhhcHBlbnMgaXQNCmlzIHByZXR0eSB1bmxpa2VseS4NCg0KCURhdmlk
DQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBG
YXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2
IChXYWxlcykNCg==

