Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AAC801114
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378717AbjLARQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLARQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:16:24 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04860F3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:16:30 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-63-yqVC9vEsO-yucNhPuXm0ag-1; Fri, 01 Dec 2023 17:16:27 +0000
X-MC-Unique: yqVC9vEsO-yucNhPuXm0ag-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 1 Dec
 2023 17:16:20 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 1 Dec 2023 17:16:20 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnaldo Carvalho de Melo' <acme@kernel.org>
CC:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] perf beauty: Don't use 'find ... -printf' as it isn't
 available in busybox
Thread-Topic: [PATCH 1/1] perf beauty: Don't use 'find ... -printf' as it
 isn't available in busybox
Thread-Index: AQHaI9e+SqSraxumCUi58U+dHeCYHbCUUq5AgABV0YCAAAJZgA==
Date:   Fri, 1 Dec 2023 17:16:20 +0000
Message-ID: <970de0610f8e4c9481817f6aea76c5a3@AcuMS.aculab.com>
References: <ZWkEeqdmCHMLhLr2@kernel.org>
 <ecad5dffa8474ed8a5367e917610e707@AcuMS.aculab.com>
 <ZWoRhbyvClv0TffR@kernel.org>
In-Reply-To: <ZWoRhbyvClv0TffR@kernel.org>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQXJuYWxkbyBDYXJ2YWxobyBkZSBNZWxvDQo+IFNlbnQ6IDAxIERlY2VtYmVyIDIwMjMg
MTc6MDINCj4gDQo+IEVtIEZyaSwgRGVjIDAxLCAyMDIzIGF0IDEyOjA1OjMxUE0gKzAwMDAsIERh
dmlkIExhaWdodCBlc2NyZXZldToNCj4gPiAuLi4NCj4gPiA+ICAjIENyZWF0ZSBsaXN0IG9mIGFy
Y2hpdGVjdHVyZXMgdGhhdCBoYXZlIGEgc3BlY2lmaWMgZXJybm8uaC4NCj4gPiA+ICBhcmNobGlz
dD0iIg0KPiA+ID4gLWZvciBhcmNoIGluICQoZmluZCAkdG9vbHNkaXIvYXJjaCAtbWF4ZGVwdGgg
MSAtbWluZGVwdGggMSAtdHlwZSBkIC1wcmludGYgIiVmXG4iIHwgc29ydCAtcik7IGRvDQo+ID4g
PiArZm9yIGFyY2ggaW4gJChmaW5kICR0b29sc2Rpci9hcmNoIC1tYXhkZXB0aCAxIC1taW5kZXB0
aCAxIC10eXBlIGQgfCB3aGlsZSByZWFkIGFyY2ggOyBkbyBiYXNlbmFtZQ0KPiA+ID4gJGFyY2gg
OyBkb25lIHwgc29ydCAtcik7IGRvDQo+ID4gPiAgCXRlc3QgLWYgJHRvb2xzZGlyL2FyY2gvJGFy
Y2gvaW5jbHVkZS91YXBpL2FzbS9lcnJuby5oICYmIGFyY2hsaXN0PSIkYXJjaGxpc3QgJGFyY2gi
DQo+ID4gPiAgZG9uZQ0KPiA+DQo+ID4gSmVlcGVycyAuLi4NCj4gPiBEb2VzIHRoaXMgd29yaz8N
Cj4gPiAJZm9yIGYgaW4gJHRvb2xzZGlyL2FyY2gvKi9pbmNsdWRlL3VhcGkvYXNtL2Vycm5vLmg7
IGRvDQo+ID4gCQlbICEgLWYgJGYgXSAmJiBicmVhaw0KPiA+IAkJZD0ke2YlL2luY2x1ZGUvdWFw
aS9hc20vZXJybm8uaH0NCj4gPiAJCWFyY2hsaXN0PSIke2QjIyovfSAkYXJjaGxpc3QiDQo+ID4g
CWRvbmUNCj4gPiBObyBmb3JrKClzIG9yIGV4ZWMoKXMuDQo+ID4gSSB0aGluayBpdCBvbmx5IGRp
ZmZlcnMgaW4gaGF2aW5nIGEgdHJhaWxpbmcgc3BhY2UgaW5zdGVhZCBvZiBhIGxlYWRpbmcgb25l
Lg0KPiANCj4g4qyiW2FjbWVAdG9vbGJveCBwZXJmLXRvb2xzLW5leHRdJCBmb3IgZiBpbiB0b29s
cy9hcmNoLyovaW5jbHVkZS91YXBpL2FzbS9lcnJuby5oOyBkbw0KPiBkPSR7ZiUvaW5jbHVkZS91
YXBpL2FzbS9lcnJuby5ofSA7IGFyY2g9IiR7ZCMjKi99IiA7IGVjaG8gIickYXJjaCciIDsgZG9u
ZQ0KPiAnYWxwaGEnDQo+ICdtaXBzJw0KPiAncGFyaXNjJw0KPiAncG93ZXJwYycNCj4gJ3NwYXJj
Jw0KPiAneDg2Jw0KPiDirKJbYWNtZUB0b29sYm94IHBlcmYtdG9vbHMtbmV4dF0kIGZvciBhcmNo
IGluICQoZmluZCB0b29scy9hcmNoIC1tYXhkZXB0aCAxIC1taW5kZXB0aCAxIC10eXBlIGQgfA0K
PiB3aGlsZSByZWFkIGFyY2ggOyBkbyBiYXNlbmFtZSAkYXJjaCA7IGRvbmUgfCBzb3J0IC1yKSA7
IGRvIHRlc3QgLWYNCj4gdG9vbHMvYXJjaC8kYXJjaC9pbmNsdWRlL3VhcGkvYXNtL2Vycm5vLmgg
JiYgZWNobyAiJyRhcmNoJyIgOyBkb25lDQo+ICd4ODYnDQo+ICdzcGFyYycNCj4gJ3Bvd2VycGMn
DQo+ICdwYXJpc2MnDQo+ICdtaXBzJw0KPiAnYWxwaGEnDQo+IOKsolthY21lQHRvb2xib3ggcGVy
Zi10b29scy1uZXh0XSQNCj4gDQo+IFRoZXJlIHdhcyBhIHJlYXNvbiBmb3IgaGF2aW5nIHg4NiBm
aXJzdCwgbGVtbWUgZGlnIGl0Li4uIEp1c3QgdG8gaGF2ZQ0KPiBhcyB0aGUgZmlyc3Qgc3RyY21w
IGluOg0KDQpJIHJldmVyc2VkIHRoZSBvcmRlciBieSBhZGRpbmcgdGhlIG5hbWVzIGF0IHRoZSBm
cm9udCBvZiAkYXJjaGxpc3QgLSBzbyB0aGUgb3JkZXINCndvdWxkIHN0aWxsIGJlIHJldmVyc2Ug
c29ydGVkICh0aGUgc2hlbGwgc29ydHMgZmlsZW5hbWUgZ2xvYnMpLg0KDQpUaGUgJ1sgLWYgJGYg
XSB8fCBicmVhaycgbGluZSBpcyBvbmx5IHRoZXJlIGluIGNhc2UgdGhlcmUgYXJlIG5vIG1hdGNo
aW5nIGZpbGVzLg0KSWYgdGhhdCBjYW4gaGFwcGVuIHB1dHRpbmcgWyAiJGFyY2hsaXN0IiA9ICIq
ICIgXSAmJiBhcmNobGlzdD0NCmFmdGVyIHRoZSBsb29wIHdvdWxkIGJlIHNsaWdodGx5IGJldHRl
ci4NCkJ1dCB3aXRoIG9ubHkgNiBpdGVtIHRoZSBleHRyYSBzdGF0KCkgd2lsbCBiZSBub2lzZS4N
Cg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2Fk
LCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5v
OiAxMzk3Mzg2IChXYWxlcykNCg==

