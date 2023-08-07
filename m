Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5729E771EC9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 12:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjHGKu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 06:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjHGKuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:50:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5879E1735
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 03:50:23 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-129-0l4wJ5DwPhyQohUdAAL24A-1; Mon, 07 Aug 2023 11:50:11 +0100
X-MC-Unique: 0l4wJ5DwPhyQohUdAAL24A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 7 Aug
 2023 11:50:07 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 7 Aug 2023 11:50:07 +0100
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
Thread-Index: AdnGwkt6hGqNS4p3Ts2CQBK2yLMoFAANMf+AAITzIRA=
Date:   Mon, 7 Aug 2023 10:50:07 +0000
Message-ID: <82fc9f39e3914a74abc7f968b1abba68@AcuMS.aculab.com>
References: <01e3e09005e9434b8f558a893a47c053@AcuMS.aculab.com>
 <b6a49ed73aba427ca8bb433763fa94e9@AcuMS.aculab.com>
 <CAHk-=whr-iSsxEZ4fYfkQzs7XQN=aQhbZQKGEMnZiGdrDgLKPQ@mail.gmail.com>
In-Reply-To: <CAHk-=whr-iSsxEZ4fYfkQzs7XQN=aQhbZQKGEMnZiGdrDgLKPQ@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDQgQXVndXN0IDIwMjMgMTk6MTQNCj4gDQo+
IE9uIEZyaSwgNCBBdWcgMjAyMyBhdCAwMzo1NiwgRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRA
YWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBDb252ZXJ0IGNvbnN0YW50cyBiZXR3ZWVuIDAg
YW5kIElOVF9NQVggdG8gJ2ludCcgcHJpb3IgdG8gY29tcGFyaXNvbnMNCj4gPiBzbyB0aGF0IG1p
bihzaWduZWRfdmFyLCAyMHUpIGFuZCwgbW9yZSBjb21tb25seSwgbWluKHNpZ25lZF92YXIsIHNp
emVvZigpKQ0KPiA+IGFyZSBib3RoIHZhbGlkLg0KPiANCj4gSSByZWFsbHkgdGhpbmsgdGhpcyB3
aG9sZSBzZXJpZXMgaXMgYnJva2VuLg0KPiANCj4gV2hhdCBkb2VzIHRoZSAiYXJlIGJvdGggdmFs
aWQiIGV2ZW4gKk1FQU4qPw0KDQpUbyBteSBtaW5kIHRoZSB2YWx1ZSBvZiBtaW4odmFyaWFibGUs
IFRXRU5UWSkgc2hvdWxkbid0IGRlcGVuZA0Kb24gaG93IFRXRU5UWSBpcyBkZWZpbmVkIHJlZ2Fy
ZGxlc3Mgb2YgdGhlIHR5cGUgb2YgdGhlIHZhcmlhYmxlLg0KU28gMjAsIDIwdSwgMjBsLCAyMHVs
LCAoY2hhcikyMCwgc2l6ZW9mIChmb28pLCBvZmZzZXRvZih4LCB5KQ0Kc2hvdWxkIGFsbCBiZSBl
cXVhbGx5IHZhbGlkIGFuZCBhbGwgZ2VuZXJhdGUgdGhlIHNhbWUgcmVzdWx0Lg0KDQpOb3RlIHRo
YXQgdGhlIHBhdGNoZXMgc3RpbGwgcmVqZWN0IG1pbih1bnNpZ25lZF92YXIsIC0xKSwNCm1pbihz
aWduZWRfdmFyLCAweDgwMDAwMDAwdSkgYW5kIG1pbihzaWduZWRfdmFyLCB1bnNpZ25lZF92YXIp
DQoodW5sZXNzIHRoZSB1bnNpZ25lZF92YXIgaXMgY2hhci9zaG9ydCkuDQoNCkl0IGlzbid0IGFz
IHRob3VnaCBhbGwgdGhlIGNvbnN0YW50cyByZWFsbHkgaGF2ZSB0aGUgJ2NvcnJlY3QnDQp0eXBl
LiBJIGZvdW5kIG9uZSBjbGFtcCh2YWwsIE1JTl9GT08sIE1BWF9GT08pIHdoZXJlIE1JTl9GT08N
CndhcyAyMCBhbmQgTUFYX0ZPTyBhbiBleHByZXNzaW9uIGluY2x1ZGluZyBzaXplb2YoKS4NCg0K
T25lIG9mIHRoZSBwcm9ibGVtcyBJJ20gdHJ5aW5nIHRvIHNvbHZlIGlzIHRoYXQgcHJldHR5IG11
Y2gNCm5vIG9uZSBzZWVtcyB0byBoYXZlIGdvbmUgYmFjayB0aHJvdWdoIHRoZSBkZWZpbml0aW9u
cyB0bw0KZml4IGEgdHlwZSBlcnJvciByZXBvcnRlZCBieSBtaW4oKSwgd2hhdCBhbHdheXMgaGFw
cGVucyBpcw0KdGhleSBkZWNpZGUgdGhlIGFuc3dlciBpcyBtaW5fdCgpLg0KDQpVbmZvcnR1bmF0
ZWx5IGl0IGlzIGFsbCB0b28gZWFzeSB0byBwaWNrIHRoZSB3cm9uZyB0eXBlLg0KV2l0aCBhID0g
bWluKGIsIGxpbWl0KSBvZnRlbiB0eXBlb2YoYSkgaXMgcGlja2VkIG9yLCBldmVuDQp3b3JzZSwg
dHlwZW9mKGIpIHdpdGhvdXQgYW55IHJlZ2FyZCBmb3Igd2hldGhlciB0aGF0IGNhbg0KdHJ1bmNh
dGUgJ2xpbWl0Jy4NCkluIGVzc2VuY2UgdGhlIGNhc3RpbmcgZG9uZSBpbiBtaW5fdCgpIGlzIHJl
YWxseSB3b3JzZSB0aGFuDQpoYXZpbmcgYSBtaW4oKSB0aGF0IGRvZXNuJ3QgdG8gdGhlIHR5cGUg
Y2hlY2sgYXQgYWxsLg0KQm90aCBhcmUgbGlrZWx5IHRvIGNvbnZlcnQgbmVnYXRpdmUgdmFsdWVz
IHRvIGxhcmdlIHBvc2l0aXZlDQpvbmVzLCBidXQgbWluX3QoKSBjYW4gYWxzbyBtYXNrIG9mZiBo
aWdoIGJpdHMuDQoNCkkndmUgZm91bmQgYWxsIHNvcnRzIG9mIGR1YmlvdXMgbWluX3QoKSB3aGls
ZSB3cml0aW5nIHRoZXNlIHBhdGNoZXMuDQpPbmUgaW4gYSBmaWxlc3lzdGVtIHdhcyBtaW5fdCh1
bG9uZywgdWxvbmdfdmFyLCB1NjRfdmFyKSBhbmQgSQ0KY291bGRuJ3QgY29udmluY2UgbXlzZWxm
IGl0IHdhcyByaWdodCBvbiAzMmJpdC4NCg0KQ2hlY2tpbmcgdGhhdCBib3RoIHZhbHVlcyBoYXZl
IHRoZSBzYW1lIHNpZ25lZG5lc3MgKHBhdGNoIDMpDQpyZW1vdmVzIGEgbG90IG9mIHRoZSByZXF1
aXJlbWVudHMgZm9yIG1pbl90KCkuDQpJbiBwYXJ0aWN1bGFyIGl0IGFsbG93cyBtaW4odWludF92
YXIsIHNpemVvZiAoKSkuDQoNClJlLWNoZWNraW5nIHdpdGggdW5zaWduZWQgY2hhci9zaG9ydCBw
cm9tb3RlZCB0byBpbnQgKGFzIGhhcHBlbnMNCnByZXR0eSBtdWNoIGFzIHNvb24gYXMgeW91IGJy
ZWF0aCBvbiB0aGUgdmFsdWUpLg0KVGhpcyBtZWFucyB0aGF0IGNoZWNrcyBvZiBjaGFyIHN0cnVj
dHVyZSBtZW1iZXJzIGFyZSBsaWtlbHkNCnRvIGJlIGFjY2VwdGVkIHdpdGhvdXQgbGlrZWx5IGlu
Y29ycmVjdCAnJiAweGZmKSBiZWluZw0KYXBwbGllZCB0byB0aGUgb3RoZXIgdmFsdWUgYnkgYSBt
aW5fdCh1OCwgYSwgYikuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNp
ZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsN
ClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

