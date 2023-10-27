Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACFA7D8FB8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345289AbjJ0HYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjJ0HYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:24:51 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A765E116
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:24:48 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-99-c3ny-4--NCCoNyvHcCaNEQ-1; Fri, 27 Oct 2023 08:24:46 +0100
X-MC-Unique: c3ny-4--NCCoNyvHcCaNEQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 27 Oct
 2023 08:24:44 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 27 Oct 2023 08:24:44 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     Vasily Gorbik <gor@linux.ibm.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: RE: [PATCH v4 1/3] math.h: add DIV_ROUND_UP_NO_OVERFLOW
Thread-Topic: [PATCH v4 1/3] math.h: add DIV_ROUND_UP_NO_OVERFLOW
Thread-Index: AQHaB2rGM+Cp9N+qfkK9yv140Cm+RbBbwb/AgAB4uICAAQLGEA==
Date:   Fri, 27 Oct 2023 07:24:44 +0000
Message-ID: <57e8138250304f5b9701867949b9ee04@AcuMS.aculab.com>
References: <20231024161931.78567-1-sebastian.reichel@collabora.com>
 <20231024161931.78567-2-sebastian.reichel@collabora.com>
 <CAHk-=whYDbZ29fx_xeSxtYSjtF8WJkaLjzyB8RN5_Rk9Sh-YyQ@mail.gmail.com>
 <CAHk-=wjO5ivM6k7iMiThO9JfxH0dhLe=mcC4TQwReU0nBCnWpg@mail.gmail.com>
 <your-ad-here.call-01698246313-ext-3263@work.hours>
 <CAHk-=wgs2DDdckcONG+YbB-GDH2QFCoZJ=Vm+YXxb1moZzuDgQ@mail.gmail.com>
 <055dd714f98f4e45b2add561b7663378@AcuMS.aculab.com>
 <CAHk-=wgBM7Swi7wmvi0M+sBFjzn-vEv1KzgM-hbJ4h3J3BR+UA@mail.gmail.com>
In-Reply-To: <CAHk-=wgBM7Swi7wmvi0M+sBFjzn-vEv1KzgM-hbJ4h3J3BR+UA@mail.gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjYgT2N0b2JlciAyMDIzIDE3OjU0DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMS8zXSBtYXRoLmg6IGFkZCBESVZfUk9VTkRfVVBfTk9fT1ZF
UkZMT1cNCj4gDQo+IE9uIFdlZCwgMjUgT2N0IDIwMjMgYXQgMjI6NTcsIERhdmlkIExhaWdodCA8
RGF2aWQuTGFpZ2h0QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRG9lc24ndCB0aGF0IHZl
cnNpb24gZW5kIHVwIGNhbGxpbmcgaW5saW5lIGZ1bmN0aW9ucz8NCj4gPiBTbyB3b24ndCBiZSB1
c2FibGUgaW4gc3RhdGljIGluaXRpYWxpc2VycyAtIHRoZSBzYW1lIGFzIHN0YXRlbWVudCBmdW5j
dGlvbnMuDQo+IA0KPiBEYXZpZCwgcGxlYXNlIGVpdGhlciByZWFkIHdoYXQgSSB3cml0ZSwgb3Ig
YWN0dWFsbHkgdGVzdCB0aGluZ3Mgb3V0LA0KPiBpbnN0ZWFkIG9mIGp1c3QgYWRkaW5nIG5vaXNl
Lg0KDQpJIGRvIHRlc3QgYSBsb3Qgb2Ygc3R1ZmYuDQpGb3Igc29tZSByZWFzb24gSSdkIGFzc3Vt
ZWQgdGhhdCB5b3Ugd291bGQgYmUgYWJsZSB0bw0KaGF2ZSBhIGNhbGwgdG8gYSBmdW5jdGlvbiBp
bnNpZGUgYSBzdGF0aWMgaW5pdGlhbGlzZXIuDQoNCkNsZWFybHkgbm90IGVub3VnaCBjb2ZmZWUg
Oi0oDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkg
Um9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlv
biBObzogMTM5NzM4NiAoV2FsZXMpDQo=

