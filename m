Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A47579A5B1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 10:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbjIKIML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 04:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbjIKIMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:12:07 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDA6FC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:12:02 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-93-xpYnoRY3Nwem60r5SNClpQ-1; Mon, 11 Sep 2023 09:11:55 +0100
X-MC-Unique: xpYnoRY3Nwem60r5SNClpQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 11 Sep
 2023 09:11:44 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 11 Sep 2023 09:11:44 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Namhyung Kim' <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: RE: [PATCH] perf annotate: Add more x86 mov instruction cases
Thread-Topic: [PATCH] perf annotate: Add more x86 mov instruction cases
Thread-Index: AQHZ4rAUrSROyt/pQUyYWZsk6XFaNLAVR23w
Date:   Mon, 11 Sep 2023 08:11:44 +0000
Message-ID: <ad8a8d46151142a883d2d259c884acc0@AcuMS.aculab.com>
References: <20230908052216.566148-1-namhyung@kernel.org>
 <CAP-5=fUtEvW9h7N=w3vvYBB3vytnTXJsXrHDD6zLA2DzYFOBHQ@mail.gmail.com>
 <CAM9d7cj1rEjGy0QM2tkJhBn=hac-9Jya+ZJ4SNhBmB29u5KVMg@mail.gmail.com>
In-Reply-To: <CAM9d7cj1rEjGy0QM2tkJhBn=hac-9Jya+ZJ4SNhBmB29u5KVMg@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTmFtaHl1bmcgS2ltDQo+IFNlbnQ6IDA5IFNlcHRlbWJlciAyMDIzIDAwOjU2DQo+IA0K
PiBIaSBJYW4sDQo+IA0KPiBPbiBUaHUsIFNlcCA3LCAyMDIzIGF0IDExOjI04oCvUE0gSWFuIFJv
Z2VycyA8aXJvZ2Vyc0Bnb29nbGUuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIFRodSwgU2VwIDcs
IDIwMjMgYXQgMTA6MjLigK9QTSBOYW1oeXVuZyBLaW0gPG5hbWh5dW5nQGtlcm5lbC5vcmc+IHdy
b3RlOg0KPiA+ID4NCj4gPiA+IEluc3RydWN0aW9ucyB3aXRoIHNpZ24tIGFuZCB6ZXJvLSBleHRl
bnRpb24gbGlrZSBtb3ZzYmwgYW5kIG1vdnp3cSB3ZXJlDQo+ID4gPiBub3QgaGFuZGxlZCBwcm9w
ZXJseS4gIEFzIGl0IGNhbiBjaGVjayBkaWZmZXJlbnQgc2l6ZSBzdWZmaXggKC1iLCAtdywgLWwN
Cj4gPiA+IG9yIC1xKSB3ZSBjYW4gb21pdCB0aGF0IGFuZCBhZGQgdGhlIGNvbW1vbiBwYXJ0cyBl
dmVuIHRob3VnaCBzb21lDQo+ID4gPiBjb21iaW5hdGlvbnMgYXJlIG5vdCBwb3NzaWJsZS4NCj4g
PiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBOYW1oeXVuZyBLaW0gPG5hbWh5dW5nQGtlcm5lbC5v
cmc+DQo+ID4gPiAtLS0NCj4gPiA+ICB0b29scy9wZXJmL2FyY2gveDg2L2Fubm90YXRlL2luc3Ry
dWN0aW9ucy5jIHwgOSArKysrKystLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS90b29scy9w
ZXJmL2FyY2gveDg2L2Fubm90YXRlL2luc3RydWN0aW9ucy5jDQo+IGIvdG9vbHMvcGVyZi9hcmNo
L3g4Ni9hbm5vdGF0ZS9pbnN0cnVjdGlvbnMuYw0KPiA+ID4gaW5kZXggNWY0YWM0ZmM3ZmNmLi41
Y2RmNDU3ZjVjYmUgMTAwNjQ0DQo+ID4gPiAtLS0gYS90b29scy9wZXJmL2FyY2gveDg2L2Fubm90
YXRlL2luc3RydWN0aW9ucy5jDQo+ID4gPiArKysgYi90b29scy9wZXJmL2FyY2gveDg2L2Fubm90
YXRlL2luc3RydWN0aW9ucy5jDQo+ID4gPiBAQCAtNzQsMTIgKzc0LDE1IEBAIHN0YXRpYyBzdHJ1
Y3QgaW5zIHg4Nl9faW5zdHJ1Y3Rpb25zW10gPSB7DQo+ID4gPiAgICAgICAgIHsgLm5hbWUgPSAi
bW92ZHFhIiwgICAgIC5vcHMgPSAmbW92X29wcywgIH0sDQo+ID4gPiAgICAgICAgIHsgLm5hbWUg
PSAibW92ZHF1IiwgICAgIC5vcHMgPSAmbW92X29wcywgIH0sDQo+ID4gPiAgICAgICAgIHsgLm5h
bWUgPSAibW92c2QiLCAgICAgIC5vcHMgPSAmbW92X29wcywgIH0sDQo+ID4gPiAtICAgICAgIHsg
Lm5hbWUgPSAibW92c2xxIiwgICAgIC5vcHMgPSAmbW92X29wcywgIH0sDQo+ID4gPiAgICAgICAg
IHsgLm5hbWUgPSAibW92c3MiLCAgICAgIC5vcHMgPSAmbW92X29wcywgIH0sDQo+ID4gPiArICAg
ICAgIHsgLm5hbWUgPSAibW92c2IiLCAgICAgIC5vcHMgPSAmbW92X29wcywgIH0sDQo+ID4gPiAr
ICAgICAgIHsgLm5hbWUgPSAibW92c3ciLCAgICAgIC5vcHMgPSAmbW92X29wcywgIH0sDQo+ID4g
PiArICAgICAgIHsgLm5hbWUgPSAibW92c2wiLCAgICAgIC5vcHMgPSAmbW92X29wcywgIH0sDQo+
ID4NCj4gPiBJbiBJbnRlbCdzIG1hbnVhbCBzb21lIG9mIHRoZXNlIG5hbWVzIGFyZSAiTW92ZSBE
YXRhIEZyb20gU3RyaW5nIHRvDQo+ID4gU3RyaW5nIiBvcGVyYXRpb25zLCBtb3ZzYiBhbmQgbW92
c3cgaW4gcGFydGljdWxhci4gVGhlc2UgaW5zdHJ1Y3Rpb25zDQo+ID4gY2FuIGJlIHVzZWQgdG8g
bWFrZSBzaW1wbGUgbWVtY3B5IGxvb3BzLiBDb3VsZCBpdCBiZSB0aGUgcGFzdCBvbWlzc2lvbg0K
PiA+IHdhcyBkZWxpYmVyYXRlIGR1ZSB0byB0aGUgZGlmZmVyZW50IHdheSB0aGUgYWRkcmVzc2lu
ZyB3b3JrcyBpbiB0aGUNCj4gPiBpbnN0cnVjdGlvbnM/DQo+IA0KPiBJIGRvbid0IGtub3cgYnV0
IGluIHRlcm1zIG9mIGluc3RydWN0aW9uIHBhcnNpbmcsIHRoZXkgYXJlIHRoZSBzYW1lDQo+ICJN
T1ZFIiB3aXRoIHR3byBvcGVyYW5kcy4gIEknbSBub3QgYXdhcmUgb2YgYW55dGhpbmcgaW4gcGVy
ZiB3aXRoDQo+IHRoZSBvcGVyYW5kcyBvZiB0aGVzZSBpbnN0cnVjdGlvbnMuICBTbyBJIGd1ZXNz
IGl0J2QgYmUgZmluZSB0byBhZGQNCj4gdGhlc2UgaW5zdHJ1Y3Rpb25zIGV2ZW4gaWYgdGhleSBo
YXZlIGRpZmZlcmVudCB1bmRlcmx5aW5nIGJlaGF2aW9ycy4NCg0KSSdtIHByZXR0eSBzdXJlIHRo
YXQgJ3JlcCBtb3ZzW2J3bHFdJyAoYWthIHdoaWxlIChjeC0tKSAqZGkrKyA9ICpzaSsrKQ0KaXMg
bGlrZWx5IHRvIGJlIG1pc3NpbmcgdGhlIG1lbW9yeSBhcmd1bWVudCBwYXJhbWV0ZXJzLg0KVGhl
cmUgaXMgYWxzbyAnZnVuIGFuZCBnYW1lcycgd2l0aCBvbmUgdmFyaWFudCAtIGlpcmMgJ3JlcCBt
b3ZzZCcNCndoYXQgaGFzIGJlZW4gdXNlZCBmb3IgNjRiaXQsIGJ1dCBnb3QgaGlqYWNrZWQgYnkg
b25lIG9mIHRoZSBTSU1EIHNldHMuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3Mg
TGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQ
VCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

