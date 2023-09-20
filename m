Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EDE7A796B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbjITKh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjITKh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:37:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62319AC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 03:37:50 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-284-5wXb8dyyPl6tQ9ufCu5NpA-1; Wed, 20 Sep 2023 11:37:47 +0100
X-MC-Unique: 5wXb8dyyPl6tQ9ufCu5NpA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 20 Sep
 2023 11:37:43 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 20 Sep 2023 11:37:43 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "jon.grimm@amd.com" <jon.grimm@amd.com>,
        "bharata@amd.com" <bharata@amd.com>,
        "raghavendra.kt@amd.com" <raghavendra.kt@amd.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        Brian Cain <bcain@quicinc.com>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "Richard Henderson" <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>
Subject: RE: Arches that don't support PREEMPT
Thread-Topic: Arches that don't support PREEMPT
Thread-Index: AQHZ6x5UxOltR8DhjkKxVhgmNJa7b7AjhK8w
Date:   Wed, 20 Sep 2023 10:37:42 +0000
Message-ID: <c3d5937c27824f7f879012cdeb876a14@AcuMS.aculab.com>
References: <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net>
 <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
 <CAHk-=wgUimqtF7PqFfRw4Ju5H1KYkp6+8F=hBz7amGQ8GaGKkA@mail.gmail.com>
In-Reply-To: <CAHk-=wgUimqtF7PqFfRw4Ju5H1KYkp6+8F=hBz7amGQ8GaGKkA@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTkgU2VwdGVtYmVyIDIwMjMgMTg6MjUNCj4g
DQo+IE9uIFR1ZSwgMTkgU2VwdCAyMDIzIGF0IDA2OjQ4LCBKb2huIFBhdWwgQWRyaWFuIEdsYXVi
aXR6DQo+IDxnbGF1Yml0ekBwaHlzaWsuZnUtYmVybGluLmRlPiB3cm90ZToNCj4gPg0KPiA+IEFz
IEdlZXJ0IHBvaW5lZCBvdXQsIEknbSBub3Qgc2VlaW5nIGFueXRoaW5nIHBhcnRpY3VsYXIgcHJv
YmxlbWF0aWMgd2l0aCB0aGUNCj4gPiBhcmNoaXRlY3R1cmVzIGxhY2tpbmcgQ09ORklHX1BSRUVN
UFQgYXQgdGhlIG1vbWVudC4gVGhpcyBzZWVtcyB0byBiZSBtb3JlDQo+ID4gc29tZXRoaW5nIGFi
b3V0IG9yZ2FuaXppbmcgS0NvbmZpZyBmaWxlcy4NCj4gDQo+IEl0IGNhbiBkZWZpbml0ZWx5IGJl
IHByb2JsZW1hdGljLg0KPiANCj4gTm90IHRoZSBLY29uZmlnIGZpbGUgcGFydCwgYW5kIG5vdCB0
aGUgcHJlZW1wdCBjb3VudCBwYXJ0IGl0c2VsZi4NCj4gDQo+IEJ1dCB0aGUgZmFjdCB0aGF0IGl0
IGhhcyBuZXZlciBiZWVuIHVzZWQgYW5kIHRlc3RlZCBtZWFucyB0aGF0IHRoZXJlDQo+IG1pZ2h0
IGJlIHRvbnMgb2YgInRoaXMgYXJjaGl0ZWN0dXJlIGNvZGUga25vd3MgaXQncyBub3QgcHJlZW1w
dGlibGUsDQo+IGJlY2F1c2UgdGhpcyBhcmNoaXRlY3R1cmUgZG9lc24ndCBzdXBwb3J0IHByZWVt
cHRpb24iLg0KDQpEbyBkaXN0b3MgZXZlbiBidWlsZCB4ODYga2VybmVscyB3aXRoIFBSRUVNUFRf
RlVMTD8NCkkga25vdyBJJ3ZlIGhhZCBpc3N1ZXMgd2l0aCBtYXNzaXZlIGxhdGVuY2llcyBjYXVz
ZWQgZ3JhcGhpY3MgZHJpdmVyDQpmb3JjaW5nIHdyaXRlLWJhY2tzIG9mIGFsbCB0aGUgZnJhbWVi
dWZmZXIgbWVtb3J5Lg0KKEkgdGhpbmsgaXQgaXMgYSBmYWlsZWQgYXR0ZW1wdCB0byBmaXggYSB0
ZW1wb3JhcnkgZGlzcGxheSBjb3JydXB0aW9uLikNCg0KT1RPSCBTTVAgc3VwcG9ydCBhbmQgQ09O
RklHX1JUIHdpbGwgdGVzdCBtb3N0IG9mIHRoZSBjb2RlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0
ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBL
ZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

