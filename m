Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D217EDE33
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 11:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbjKPKIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 05:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjKPKId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 05:08:33 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9874CC5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 02:08:29 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-4-KbudXczuMvSlfOhXmqjSIA-1; Thu, 16 Nov 2023 10:08:18 +0000
X-MC-Unique: KbudXczuMvSlfOhXmqjSIA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 16 Nov
 2023 10:07:35 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 16 Nov 2023 10:07:35 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
CC:     David Howells <dhowells@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "fengwei.yin@intel.com" <fengwei.yin@intel.com>
Subject: RE: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
Thread-Topic: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
Thread-Index: AQHaF/9mUr/d/cPMC0WC86r1pNT+UrB8tOyw
Date:   Thu, 16 Nov 2023 10:07:35 +0000
Message-ID: <4c0c3ee6cfa84d21a807055bc1aa27b8@AcuMS.aculab.com>
References: <202311061616.cd495695-oliver.sang@intel.com>
 <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
 <20231115190938.GGZVUXcuUjI3i1JRAB@fat_crate.local>
 <CAHk-=whFW+uWOmOtRNh0What_fu8Xo8KF2+EeUH1kn4qFxGAhA@mail.gmail.com>
 <CAHk-=whrc-ruKs4Kt90EGzKd+pYhZFKs6bgBVCV=55BK+p1nzg@mail.gmail.com>
In-Reply-To: <CAHk-=whrc-ruKs4Kt90EGzKd+pYhZFKs6bgBVCV=55BK+p1nzg@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTUgTm92ZW1iZXIgMjAyMyAyMDowNw0KLi4u
DQo+ICAtIG91ciBjdXJyZW50ICJtZW1jcHlfb3JpZyIgZmFsbGJhY2sgZG9lcyB1bnJvbGxlZCBj
b3B5IGxvb3BzLCBhbmQNCj4gdGhlIHJlcF9tb3ZzX2FsdGVybmF0aXZlIGZhbGxiYWNrIG9idmlv
dXNseSBkb2Vzbid0Lg0KPiANCj4gSXQncyBub3QgY2xlYXIgdGhhdCB0aGUgdW5yb2xsZWQgY29w
eSBsb29wcyBtYXR0ZXIgZm9yIHRoZSBpbi1rZXJuZWwNCj4ga2luZHMgb2YgY29waWVzLCBidXQg
d2hvIGtub3dzLiBUaGUgbWVtY3B5X29yaWcgY29kZSBpcyBkZWZpbml0ZWx5DQo+IHRyeWluZyB0
byBiZSBzbWFydGVyIGluIHNvbWUgb3RoZXIgd2F5cyB0b28uIFNvIHRoZSBmYWxsYmFjayBzaG91
bGQNCj4gdHJ5IGEgKmJpdCogaGFyZGVyIHRoYW4gSSBkaWQsIGFuZCBub3QganVzdCB3aXRoIHRo
ZSB3aG9sZSAiZG9uJ3QgdHJ5DQo+IHRvIGhhbmRsZSBleGNlcHRpb25zIiBpc3N1ZSBJIG1lbnRp
b25lZC4NCg0KSSdtIHByZXR0eSBzdXJlIHRoZSB1bnJvbGxlZCBjb3B5IChhbmQgb3RoZXIgdW5y
b2xsZWQgbG9vcHMpDQpqdXN0IHdhc3RlcyBJLWNhY2hlIGFuZCBzbG93cyB0aGluZ3MgZG93biBj
b2xkLWNhY2hlLg0KDQpXaXRoIG91dCBvZiBvcmRlciBleGVjdXRlIG9uIG1vc3QgeDg2IGNwdSAo
ZXhjZXB0IGF0b21zKSB5b3UNCmRvbid0IHJlYWxseSBoYXZlIHRvIHdvcnJ5IGFib3V0IHRoZSBt
ZW1vcnkgbGF0ZW5jeS4NClNvIGdldCB0aGUgbG9vcCBjb250cm9sIGluc3RydWN0aW9ucyB0byBy
dW4gaW4gcGFyYWxsZWwgd2l0aA0KdGhlIG1lbW9yeSBhY2Nlc3Mgb25lcyBhbmQgeW91IGNhbiBj
b3B5IG9uZSB3b3JkIGV2ZXJ5IGNsb2NrLg0KSSBuZXZlciBtYW5hZ2VkIGEgc2luZ2xlIGNsb2Nr
IGxvb3AsIGJ1dCB5b3UgY2FuIGdldCBhIHR3bw0KY2xvY2sgbG9vcCAod2l0aCAyIHJlYWRzIGFu
ZCAyIHdyaXRlcyBpbiBpdCkuDQoNClNvIHVucm9sbGluZyBvbmNlIGlzIHR5cGljYWxseSBlbm91
Z2guDQoNCllvdSBjYW4gYWxzbyBpZ25vcmUgYWxpZ25tZW50LCB0aGUgZXh0cmEgY29zdCBpcyBt
aW5pbWFsIChvbg0KSW50ZWwgY3B1IGF0IGxlYXN0KS4gSSB0aGluayBpdCByZXF1aXJlcyBhbiBl
eHRyYSB1LW9wIHdoZW4NCnRoZSBjb3B5IGNyb3NzZXMgYSBjYWNoZSBsaW5lIGJvdW5kYWRyeS4N
Cg0KT24gaGFzd2VsbCAod2hpY2ggaXMgbm93IHF1aXRlIG9sZCkgYm90aCAncmVwIG1vdnNiJyBh
bmQNCidyZXAgbW92c3EnIGNvcHkgMTYgYnl0ZXMvY2xvY2sgdW5sZXNzIHRoZSBkZXN0aW5hdGlv
bg0KaXMgMzIgYnl0ZSBhbGlnbmVkIHdoZW4gdGhleSBjb3B5IDMyIGJ5dGVzL2Nsb2NrLg0KU291
cmNlIGFsaWdubWVudCBtYWtlIG5vIGRpZmZlcmVudCwgbmVpdGhlciBkb2VzIGJ5dGUNCmFsaWdu
bWVudC4NCg0KQW5vdGhlciAtT3Mgc3R1cGlkaXR5IGlzICdwdXNoICR4OyBwb3AgJXJlZycgdG8g
bG9hZA0KYSBzaWduZWQgYnl0ZSBjb25zdGFudC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQg
QWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVz
LCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

