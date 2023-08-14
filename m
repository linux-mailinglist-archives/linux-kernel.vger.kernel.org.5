Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C96177BC10
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjHNOwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjHNOv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:51:57 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502821B5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:51:52 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-265-LSIVBqBIPKKau79zkCsJLw-1; Mon, 14 Aug 2023 15:51:31 +0100
X-MC-Unique: LSIVBqBIPKKau79zkCsJLw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 14 Aug
 2023 15:51:19 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 14 Aug 2023 15:51:19 +0100
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
Thread-Index: AdnGwkt6hGqNS4p3Ts2CQBK2yLMoFAANMf+AAITzIRAADNjaAACIoXRgABaQVAAAwNZ4AA==
Date:   Mon, 14 Aug 2023 14:51:19 +0000
Message-ID: <de8333e06b0a49d3b18fe9a0be50738c@AcuMS.aculab.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KPiBT
ZW50OiAxMCBBdWd1c3QgMjAyMyAyMDo0Nw0KLi4uDQo+IEJ1dCB1c2luZyBhbiAqdW5zaWduZWQq
IGNvbnN0YW50IDIwIHdoZW4gdGhlIG90aGVyIHNpZGUgaXMgc2lnbmVkDQo+IG1lYW5zIHRoYXQg
bm93IHNvbWVib2R5IGlzIGNvbmZ1c2VkLiBXZSBzaG91bGQgd2Fybi4NCg0KVGhlbiB5b3UgZ2V0
ICdmaXhlcycgbGlrZToNCg0KaW50IGRvX3RjcF9nZXRzb2Nrb3B0KHN0cnVjdCBzb2NrICpzaywg
aW50IGxldmVsLA0KCQkgICAgICBpbnQgb3B0bmFtZSwgc29ja3B0cl90IG9wdHZhbCwgc29ja3B0
cl90IG9wdGxlbikNCnsNCglzdHJ1Y3QgaW5ldF9jb25uZWN0aW9uX3NvY2sgKmljc2sgPSBpbmV0
X2Nzayhzayk7DQoJc3RydWN0IHRjcF9zb2NrICp0cCA9IHRjcF9zayhzayk7DQoJc3RydWN0IG5l
dCAqbmV0ID0gc29ja19uZXQoc2spOw0KCWludCB2YWwsIGxlbjsNCg0KCWlmIChjb3B5X2Zyb21f
c29ja3B0cigmbGVuLCBvcHRsZW4sIHNpemVvZihpbnQpKSkNCgkJcmV0dXJuIC1FRkFVTFQ7DQoN
CglsZW4gPSBtaW5fdCh1bnNpZ25lZCBpbnQsIGxlbiwgc2l6ZW9mKGludCkpOw0KDQoJaWYgKGxl
biA8IDApDQoJCXJldHVybiAtRUlOVkFMOw0KDQooU3BvdHRlZCB3aGlsZSBsb29raW5nIHRvIHNl
ZSBpZiB0aGUgZ2VuZXJpYyBnZXRzb2Nrb3B0KCkNCmNvZGUgd291bGQgbGV0IG5vdyBteSBkcml2
ZXIgdG8ga2VybmVsX2dldHNvY2tvcHQoKSBvbiBhIFNDVFANCmNvbm5lY3Rpb24gdG8gZmluZCBv
dXQgdGhlIG51bWJlciBvZiBzdHJlYW1zLg0KU2VlbXMgdGhlIEJQRiBwZW9wbGUgaGF2ZW4ndCB5
ZXQgcmVxdWlyZWQgdGhlIGZ1bGx5IGdlbmVyaWMgY2hhbmdlLikNCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==

