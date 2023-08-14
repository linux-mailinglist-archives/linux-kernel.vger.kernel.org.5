Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451B377B343
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbjHNIF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbjHNIFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:05:10 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD5CCC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:05:06 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-202-j8XliKWdOjCiUpAptZ0L3A-1; Mon, 14 Aug 2023 09:05:03 +0100
X-MC-Unique: j8XliKWdOjCiUpAptZ0L3A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 14 Aug
 2023 09:04:53 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 14 Aug 2023 09:04:53 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>
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
Thread-Index: AdnGwkt6hGqNS4p3Ts2CQBK2yLMoFAANMf+AAITzIRAADNjaAACIoXRgABaQVAAAsmVSUA==
Date:   Mon, 14 Aug 2023 08:04:53 +0000
Message-ID: <b5cf056d6e9a4c74a35733681eb22fe6@AcuMS.aculab.com>
References: <01e3e09005e9434b8f558a893a47c053@AcuMS.aculab.com>
 <b6a49ed73aba427ca8bb433763fa94e9@AcuMS.aculab.com>
 <CAHk-=whr-iSsxEZ4fYfkQzs7XQN=aQhbZQKGEMnZiGdrDgLKPQ@mail.gmail.com>
 <82fc9f39e3914a74abc7f968b1abba68@AcuMS.aculab.com>
 <CAHk-=whOOMM8k+6vB5k3LA=c3OwvHo+1iS6_SOwssV5_MUdoCg@mail.gmail.com>
 <f88a67c60b3d4a8c98a4aaaa32fd2c33@AcuMS.aculab.com>
 <CAHk-=wiU=euKEQOzgdQqTAekJgHMMTtqMwdAw=mGkcGoR9ChEw@mail.gmail.com>
In-Reply-To: <CAHk-=wiU=euKEQOzgdQqTAekJgHMMTtqMwdAw=mGkcGoR9ChEw@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTAgQXVndXN0IDIwMjMgMjA6NDcNCj4gDQo+
IE9uIFRodSwgMTAgQXVnIDIwMjMgYXQgMDE6MjksIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0
QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiBEb2VzIHRoYXQgZXhwcmVzc2lvbiBtZWFu
ICJnaXZlIG1lIGEgbnVtYmVyIDAuLjIwIiBvciAiTUlOSU5ULi4yMCI/DQo+ID4NCj4gPiBXaHkg
ZG9lcyB0aGUgbG93ZXIgYm91bmQgb2YgYW55IHR5cGUgbWF0dGVyPw0KPiANCj4gQmVjYXVzZSBp
dCBtaWdodCBhY3R1YWxseSBiZSB0aGUgdXBwZXIgYm91bmQuDQo+IA0KPiBUaGF0IE1JTklOVCBi
ZWNvbWVzIGJlIDIwIGlmIGl0J3MgdW5zaWduZWQsIGFuZCB5b3UgZG8gbWluKCkgb24gaXQuDQo+
IA0KPiBCdWdzIHdoZW4gbWl4aW5nIHVuc2lnbmVkIGFuZCBzaWduZWQgY29tcGFyaXNvbnMgaXMg
V0hZIFdFIEhBVkUgVEhFDQo+IFRZUEUgQ0hFQ0sgSU4gVEhFIEZJUlNUIFBMQUNFLg0KDQpIYXZl
IHlvdSBjb25zaWRlcmVkIHBhdGNoZXMgMSB0byAzIGFuZCBtYXliZSA0Pw0KVGhlc2Ugc3RpbGwg
ZGlzYWxsb3cgc2lnbmVkIHYgdW5zaWduZWQgY29tcGFyZXMgYnV0IGRvbid0IHdvcnJ5DQphYm91
dCB0aGUgYWN0dWFsIHR5cGVzIGludm9sdmVkLg0KDQpBbGwgeW91ciBvYmplY3Rpb25zIHNlZW4g
dG8gYmUgdG8gcGF0Y2ggNS4NCg0KPiBBbmQgbm8sIGNvbnN0YW50cyBkb24ndCBuZWNlc3Nhcmls
eSBtYWtlIHRoYXQgYW55IGRpZmZlcmVudC4NCj4gDQo+IEkgdGhpbmsgd2UgYWxsIGFncmVlIHRo
YXQgdXNpbmcgYSAoc2lnbmVkKSBjb25zdGFudCAyMCBtYWtlcyBwZXJmZWN0DQo+IHNlbnNlIHdo
ZW4gdGhlIG90aGVyIHNpZGUgaXMgYW4gdW5zaWduZWQgZW50aXR5LiBJdCBtYXkgYmUgInNpZ25l
ZCIsDQo+IGJ1dCB3aGVuIHRoZSB2YWx1ZSBpcyBwb3NpdGl2ZSwgd2UgZG9uJ3QgY2FyZS4NCj4g
DQo+IEJ1dCB1c2luZyBhbiAqdW5zaWduZWQqIGNvbnN0YW50IDIwIHdoZW4gdGhlIG90aGVyIHNp
ZGUgaXMgc2lnbmVkDQo+IG1lYW5zIHRoYXQgbm93IHNvbWVib2R5IGlzIGNvbmZ1c2VkLiBXZSBz
aG91bGQgd2Fybi4NCg0KSW4gdGhhdCBjYXNlIG1heWJlIEkgY2FuIGFkZCBhbiBpc19zaWduZWQo
KSBjaGVjayBpbnRvIHRoZSBjb25zdGFudA0KdGVzdC4NClRoZSB3aWxsIGFsbG93IG1pbih1bnNp
Z25lZF92YXIsIDIwKSBidXQgZGlzYWxsb3cgbWluKHNpZ25lZF92YXIsIDIwdSkuDQoNCkkgbWln
aHQgc2ltcGxpZnkgdGhpbmdzIGJ5IGxpbWl0aW5nIHRoZSBjaGVja3Mgb24gdGhlICdiYWNrd2Fy
ZHMnDQpjb21wYXJlIG9mIG1pbihjb25zdGFudCwgdmFyaWFibGUpLg0KKFRoZXkgYWxtb3N0IG5l
ZWQgYSB3YXJuaW5nLi4uKQ0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

