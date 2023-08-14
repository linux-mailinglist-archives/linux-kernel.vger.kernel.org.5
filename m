Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8EE77BD9D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjHNQHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjHNQGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:06:43 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A21F10CE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:06:42 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-25-_YVO4ZTJNqKJ7-DriTv8WQ-2; Mon, 14 Aug 2023 17:06:40 +0100
X-MC-Unique: _YVO4ZTJNqKJ7-DriTv8WQ-2
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 14 Aug
 2023 17:06:27 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 14 Aug 2023 17:06:27 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Takashi Iwai <tiwai@suse.de>
CC:     Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH RFC] Introduce uniptr_t as a generic "universal" pointer
Thread-Topic: [PATCH RFC] Introduce uniptr_t as a generic "universal" pointer
Thread-Index: AQHZytqIYRyb8qc5OEi2/YTeIeVM5K/p+fiw
Date:   Mon, 14 Aug 2023 16:06:27 +0000
Message-ID: <412b612bd05f4ccca9326554697b6b6b@AcuMS.aculab.com>
References: <87edkce118.wl-tiwai@suse.de> <20230809143801.GA693@lst.de>
 <87a5v0e0mv.wl-tiwai@suse.de>
 <CAHk-=wgGV61xrG=gO0=dXH64o2TDWWrXn1mx-CX885JZ7h84Og@mail.gmail.com>
In-Reply-To: <CAHk-=wgGV61xrG=gO0=dXH64o2TDWWrXn1mx-CX885JZ7h84Og@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMgDQo+IFNlbnQ6IDA5IEF1Z3VzdCAyMDIzIDE2OjU5DQo+IA0K
PiBPbiBXZWQsIDkgQXVnIDIwMjMgYXQgMDc6NDQsIFRha2FzaGkgSXdhaSA8dGl3YWlAc3VzZS5k
ZT4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgcmVtYWluaW5nIHF1ZXN0aW9uIGlzIHdoZXRoZXIgdGhl
IHVzZSBvZiBzb2NrcHRyX3QgZm9yIG90aGVyDQo+ID4gc3Vic3lzdGVtcyBhcyBhIGdlbmVyaWMg
cG9pbnRlciBpcyBhIHJlY29tbWVuZGVkIC8gYWNjZXB0YWJsZSBtb3ZlLi4uDQo+IA0KPiBWZXJ5
IG11Y2ggbm90IHJlY29tbWVuZGVkLiBzb2NrcHRyX3QgaXMgaG9ycmlibGUgdG9vLCBidXQgaXQg
d2FzIChwYXJ0DQo+IG9mKSB3aGF0IG1hZGUgaXQgcG9zc2libGUgdG8gZml4IGFuIGV2ZW4gd29y
c2UgaG9ycmlibGUgaGlzdG9yaWNhbA0KPiBtaXN0YWtlIChpZSBnZXR0aW5nIHJpZCBvZiBzZXRf
ZnMoKSkuDQo+IA0KPiBTbyBJIGRldGVzdCBzb2NrcHRyX3QuIEl0J3MgZ2FyYmFnZS4gQXQgdGhl
IHZlcnkgbWluaW11bSBpdCBzaG91bGQNCj4gaGF2ZSBoYWQgdGhlIGxlbmd0aCBhc3NvY2lhdGVk
IHdpdGggaXQsIG5vdCBwYXNzZWQgc2VwYXJhdGVseS4NCg0KRldJVyBJJ3ZlIHRob3VnaHQgeW91
J2Qgd2FudCBzb21ldGhpbmcgbGlrZToNCnN0cnVjdCBwdHJfYXJnIHsNCgl2b2lkICAgICAgICAg
ICprZXJuZWw7DQoJdm9pZCBfX3VzZXIgICAqdXNlcjsNCgl1bnNpZ25lZCBpbnQgIGtlcm5lbF9s
ZW47DQoJdW5zaWduZWQgaW50ICB1c2VyX2xlbjsNCn07DQoNClRoZW4gW2dzXWV0c29ja29wdCgp
IGNvdWxkIGNvcHkgc2hvcnQgdXNlciBidWZmZXJzIGludG8NCmtlcm5lbCBzcGFjZSAoZWcgb24g
c3RhY2spIHdoaWxlIGFsbG93aW5nIGNvZGUgdGhhdCBuZWVkcw0KdmVyeSBsYXJnZSBidWZmZXJz
IChlZyBzb21lIHNjdHAgb3B0aW9ucykgdG8gZGlyZWN0bHkNCmFjY2VzcyBhIHVzZXJzcGFjZSBi
dWZmZXIuDQoNClRoZXJlIGNlcnRhaW5seSB1c2VkIHRvIGJlIHNvY2tvcHQgY2FsbHMgd2hlcmUg
dGhlIHVzZXINCmRpZG4ndCBwYXNzIHRoZSBjb3JyZWN0L2FueSBsZW5ndGguDQpUaGV5IG1pZ2h0
IGFsbCBoYXZlIGJlZW4gaW4gZGVjbmV0Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRy
ZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1L
MSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

