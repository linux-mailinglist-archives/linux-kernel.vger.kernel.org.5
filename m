Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8A27D7EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 10:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbjJZImE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 04:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjJZIlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 04:41:55 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF46810E
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 01:41:51 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-405-HugBNGsgMPCUITDyO-WHrA-1; Thu, 26 Oct 2023 09:41:48 +0100
X-MC-Unique: HugBNGsgMPCUITDyO-WHrA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 26 Oct
 2023 09:41:47 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 26 Oct 2023 09:41:47 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: RE: [PATCH v4 1/3] math.h: add DIV_ROUND_UP_NO_OVERFLOW
Thread-Topic: [PATCH v4 1/3] math.h: add DIV_ROUND_UP_NO_OVERFLOW
Thread-Index: AQHaBszYM+Cp9N+qfkK9yv140Cm+RbBaJ2TAgACPJoCAAQKN4A==
Date:   Thu, 26 Oct 2023 08:41:47 +0000
Message-ID: <2873863a22f441c9889ba405d8a71d97@AcuMS.aculab.com>
References: <20231024161931.78567-1-sebastian.reichel@collabora.com>
 <20231024161931.78567-2-sebastian.reichel@collabora.com>
 <CAHk-=whYDbZ29fx_xeSxtYSjtF8WJkaLjzyB8RN5_Rk9Sh-YyQ@mail.gmail.com>
 <CAHk-=wjO5ivM6k7iMiThO9JfxH0dhLe=mcC4TQwReU0nBCnWpg@mail.gmail.com>
 <4c2d36375bd74d94a2e6ef5d2fa0df99@AcuMS.aculab.com>
 <CAHk-=whrytmsiaLS=rn==qrYw81y2Qiv6dAZxvGzwgX=dMFxng@mail.gmail.com>
In-Reply-To: <CAHk-=whrytmsiaLS=rn==qrYw81y2Qiv6dAZxvGzwgX=dMFxng@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMgDQo+IFNlbnQ6IDI1IE9jdG9iZXIgMjAyMyAxODo0MQ0KPiAN
Cj4gT24gVHVlLCAyNCBPY3QgMjAyMyBhdCAyMjozOCwgRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWln
aHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBMaW51cyBUb3J2YWxkcw0KPiA+
ID4gPiAgLSB3ZSBjYW4ndCBldmVuIHVzZSBhIHN0YXRlbWVudCBleHByZXNzaW9uIGFuZCBfX2F1
dG9fdHlwZSwgYmVjYXVzZQ0KPiA+ID4gPiB0aGVzZSB0aGluZ3MgYXJlIHVzZWQgaW4gdHlwZSBk
ZWZpbml0aW9ucyBldGMgYW5kIG5lZWQgdG8gYmUgY29uc3RhbnQNCj4gPiA+ID4gZXhwcmVzc2lv
bnMNCj4gPg0KPiA+IERvZXNuJ3QgbWluKCkgZ2V0IGFyb3VuZCB0aGF0IGJ5IHVzaW5nIGlzX2Nv
bnN0ZXhwcigpIGFuZA0KPiA+IF9fYnVpbHRpbl9jaG9vc2VfZXhwdHIoKSAtIHRoZSBzYW1lIGNv
dWxkIGJlIGRvbmUgaGVyZS4NCj4gDQo+IE5vcGUuIEkgd2FudGVkIHRvIGRvIGl0IHRoYXQgd2F5
IC0gaXQgd291bGQgaGF2ZSBtYWRlIHRoaW5ncyBtdWNoDQo+IHNpbXBsZXIgYW5kIGF2b2lkIHRo
ZSB3aG9sZSBfR2VuZXJpYygpIHRoaW5nLCBidXQgdHJ5IGl0IC0geW91IGNhbm5vdA0KPiB1c2Ug
c3RhdGVtZW50IGV4cHJlc3Npb25zIGluIGEgbm9uLWZ1bmN0aW9uIGNvbnRleHQgZXZlbiB3aXRo
DQo+IF9fYnVpbHRpbl9jaG9vc2VfZXhwcigpLg0KDQpfR2VuZXJpYygpIGhhcyBleGFjdGx5IHRo
ZSBzYW1lIGlzc3VlcyBhcyBfX2J1aWx0aW5fY2hvb3NlX2V4cHIoKS4NCkFsbCB0aGUgY29kZSBo
YXMgdG8gYmUgdmFsaWQgZm9yIGFsbCB0eXBlcy4NCk1ha2VzIHRlc3RpbmcgZm9yIG5lZ2F0aXZl
IGNvbnN0YW50cyBhIFBJVEEuDQpTb21ldGhpbmcgbGlrZSB0aGlzIHdvcmtlZDoNCgkoX19idWl0
aW5fY2hvb3NlX2V4cHIoX19pc19jb25zdGV4cHIoKHgpICYmIGlzX3NpZ25lZF90eXBlKF9fdHlw
ZW9mKHgpKSwgeCwgMSkgPCAwKQ0KQWx0aG91Z2ggb3VyIGlzX3NpZ25lZF90eXBlKCkgaXNuJ3Qg
Y29uc3RhbnQgKGVub3VnaCkgZm9yIHBvaW50ZXIgdHlwZXMuDQpTbyB5b3UgbmVlZCBhbm90aGVy
IGNoZWNrIGZvciAodHlwZW9mKHgpKTEgYmVpbmcgY29uc3RhbnQuDQoNCj4gQW5kIG5vLCBtaW4v
bWF4IGhhdmUgbmV2ZXIgYmVlbiB1c2FibGUgaW4gdGhhdCBjb250ZXh0DQoNCkkndmUgY2xlYXJs
eSBub3QgdGVzdGVkIGl0IGFuZCBhc3N1bWVkIHRoZSBjb21tZW50IGltcGxpZWQNCnRoYXQgd2Fz
IG9rLg0KDQpJdCdkIHByb2JhYmx5IHdvcmsgaW4gQysrIC0gd2hpY2ggaXMgcGVyZmVjdGx5IHdp
bGxpbmcgdG8NCmFkZCBmdW5jdGlvbnMgdG8gaW5pdGlhbGlzZSBzdGF0aWMgZGF0YSAtIGV2ZW4g
d2hlbiB5b3UnZA0KcmF0aGVyIGhhdmUgYSBjb21waWxlIHRpbWUgZXJyb3IuDQoNCglEYXZpZA0K
DQo+IA0KPiAgICAgICAgICAgICAgICAgIExpbnVzDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBM
YWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBU
LCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

