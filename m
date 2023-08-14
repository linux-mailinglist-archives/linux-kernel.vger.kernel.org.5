Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BB677BD0C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjHNPaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjHNPaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:30:04 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EE510F0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:30:00 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-229-x3MjH5ZfOW6T0TEKdzKQeQ-1; Mon, 14 Aug 2023 16:29:58 +0100
X-MC-Unique: x3MjH5ZfOW6T0TEKdzKQeQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 14 Aug
 2023 16:29:46 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 14 Aug 2023 16:29:46 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: RE: [PATCH v3 5/5] minmax: Relax check to allow comparison between
 int and small unsigned constants.
Thread-Topic: [PATCH v3 5/5] minmax: Relax check to allow comparison between
 int and small unsigned constants.
Thread-Index: AdnGwkt6hGqNS4p3Ts2CQBK2yLMoFAANMf+AAITzIRAADNjaAACIoXRgABaQVAAAwNZ4AAABUbYA
Date:   Mon, 14 Aug 2023 15:29:46 +0000
Message-ID: <2b39a714cdcd4299be8c404ae699a4d3@AcuMS.aculab.com>
References: <01e3e09005e9434b8f558a893a47c053@AcuMS.aculab.com>
 <b6a49ed73aba427ca8bb433763fa94e9@AcuMS.aculab.com>
 <CAHk-=whr-iSsxEZ4fYfkQzs7XQN=aQhbZQKGEMnZiGdrDgLKPQ@mail.gmail.com>
 <82fc9f39e3914a74abc7f968b1abba68@AcuMS.aculab.com>
 <CAHk-=whOOMM8k+6vB5k3LA=c3OwvHo+1iS6_SOwssV5_MUdoCg@mail.gmail.com>
 <f88a67c60b3d4a8c98a4aaaa32fd2c33@AcuMS.aculab.com>
 <CAHk-=wiU=euKEQOzgdQqTAekJgHMMTtqMwdAw=mGkcGoR9ChEw@mail.gmail.com>
 <de8333e06b0a49d3b18fe9a0be50738c@AcuMS.aculab.com>
In-Reply-To: <de8333e06b0a49d3b18fe9a0be50738c@AcuMS.aculab.com>
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

RnJvbTogRGF2aWQgTGFpZ2h0DQo+IFNlbnQ6IDE0IEF1Z3VzdCAyMDIzIDE1OjUxDQo+DQo+IEZy
b206IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4NCj4gPiBT
ZW50OiAxMCBBdWd1c3QgMjAyMyAyMDo0Nw0KPiAuLi4NCj4gPiBCdXQgdXNpbmcgYW4gKnVuc2ln
bmVkKiBjb25zdGFudCAyMCB3aGVuIHRoZSBvdGhlciBzaWRlIGlzIHNpZ25lZA0KPiA+IG1lYW5z
IHRoYXQgbm93IHNvbWVib2R5IGlzIGNvbmZ1c2VkLiBXZSBzaG91bGQgd2Fybi4NCj4gDQo+IFRo
ZW4geW91IGdldCAnZml4ZXMnIGxpa2U6DQo+IA0KPiBpbnQgZG9fdGNwX2dldHNvY2tvcHQoc3Ry
dWN0IHNvY2sgKnNrLCBpbnQgbGV2ZWwsDQo+IAkJICAgICAgaW50IG9wdG5hbWUsIHNvY2twdHJf
dCBvcHR2YWwsIHNvY2twdHJfdCBvcHRsZW4pDQo+IHsNCj4gCXN0cnVjdCBpbmV0X2Nvbm5lY3Rp
b25fc29jayAqaWNzayA9IGluZXRfY3NrKHNrKTsNCj4gCXN0cnVjdCB0Y3Bfc29jayAqdHAgPSB0
Y3Bfc2soc2spOw0KPiAJc3RydWN0IG5ldCAqbmV0ID0gc29ja19uZXQoc2spOw0KPiAJaW50IHZh
bCwgbGVuOw0KPiANCj4gCWlmIChjb3B5X2Zyb21fc29ja3B0cigmbGVuLCBvcHRsZW4sIHNpemVv
ZihpbnQpKSkNCj4gCQlyZXR1cm4gLUVGQVVMVDsNCj4gDQo+IAlsZW4gPSBtaW5fdCh1bnNpZ25l
ZCBpbnQsIGxlbiwgc2l6ZW9mKGludCkpOw0KPiANCj4gCWlmIChsZW4gPCAwKQ0KPiAJCXJldHVy
biAtRUlOVkFMOw0KDQpBY3R1YWxseSB0aGF0IGNvZGUgaGFzIGJlZW4gYnJva2VuIHNpbmNlIHRo
ZSB0ZXN0IHdhcyBhZGRlZCBpbiAyLjQuNC4NCkF0IHRoYXQgdGltZSBtaW4oKSB3YXMgYSBsb2Nh
bCBpbmxpbmUgd2l0aCB1bnNpZ25lZCBpbnQgYXJncy4NCjIuNC45IGFkZGVkIG1pbih0eXBlLGEs
YikNCjIuNC4xMCByZW5hbWVkIG1pbigpIHRvICBtaW5fdCgpIGFuZCBhZGRlZCBtaW4oKSB3aXRo
IHRoZSBzdHJpY3QNCiAgdHlwZSBjaGVja2luZy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQg
QWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVz
LCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

