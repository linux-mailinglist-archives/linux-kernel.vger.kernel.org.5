Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21DF801252
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjLASMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjLASM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:12:29 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DE3FE
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:12:34 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-257-UsWWvVUmOhOZXVt_VID7jw-1; Fri, 01 Dec 2023 18:12:27 +0000
X-MC-Unique: UsWWvVUmOhOZXVt_VID7jw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 1 Dec
 2023 18:12:19 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 1 Dec 2023 18:12:19 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jann Horn' <jannh@google.com>, Waiman Long <longman@redhat.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH] locking: Document that mutex_unlock() is non-atomic
Thread-Topic: [PATCH] locking: Document that mutex_unlock() is non-atomic
Thread-Index: AQHaJGdmWd9hceM5t0qWKvuVqma2ELCUtpLQ
Date:   Fri, 1 Dec 2023 18:12:19 +0000
Message-ID: <28b147c3d7354d1a8ff0b903da9b54f4@AcuMS.aculab.com>
References: <20231130204817.2031407-1-jannh@google.com>
 <06c05c8b-9a3b-4c04-b898-0f82e98da70f@redhat.com>
 <CAG48ez1a=VuEWwPTjcXFAwCyt9bRH-WzAfw0uP-qVu83kdxkZw@mail.gmail.com>
In-Reply-To: <CAG48ez1a=VuEWwPTjcXFAwCyt9bRH-WzAfw0uP-qVu83kdxkZw@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSmFubiBIb3JuDQo+IFNlbnQ6IDAxIERlY2VtYmVyIDIwMjMgMTU6MDINCj4gDQo+IE9u
IEZyaSwgRGVjIDEsIDIwMjMgYXQgMTozM+KAr0FNIFdhaW1hbiBMb25nIDxsb25nbWFuQHJlZGhh
dC5jb20+IHdyb3RlOg0KPiA+IE9uIDExLzMwLzIzIDE1OjQ4LCBKYW5uIEhvcm4gd3JvdGU6DQo+
ID4gPiBJIGhhdmUgc2VlbiBzZXZlcmFsIGNhc2VzIG9mIGF0dGVtcHRzIHRvIHVzZSBtdXRleF91
bmxvY2soKSB0byByZWxlYXNlIGFuDQo+ID4gPiBvYmplY3Qgc3VjaCB0aGF0IHRoZSBvYmplY3Qg
Y2FuIHRoZW4gYmUgZnJlZWQgYnkgYW5vdGhlciB0YXNrLg0KPiA+ID4gTXkgdW5kZXJzdGFuZGlu
ZyBpcyB0aGF0IHRoaXMgaXMgbm90IHNhZmUgYmVjYXVzZSBtdXRleF91bmxvY2soKSwgaW4gdGhl
DQo+ID4gPiBNVVRFWF9GTEFHX1dBSVRFUlMgJiYgIU1VVEVYX0ZMQUdfSEFORE9GRiBjYXNlLCBh
Y2Nlc3NlcyB0aGUgbXV0ZXgNCj4gPiA+IHN0cnVjdHVyZSBhZnRlciBoYXZpbmcgbWFya2VkIGl0
IGFzIHVubG9ja2VkOyBzbyBtdXRleF91bmxvY2soKSByZXF1aXJlcw0KPiA+ID4gaXRzIGNhbGxl
ciB0byBlbnN1cmUgdGhhdCB0aGUgbXV0ZXggc3RheXMgYWxpdmUgdW50aWwgbXV0ZXhfdW5sb2Nr
KCkNCj4gPiA+IHJldHVybnMuDQo+ID4gPg0KPiA+ID4gSWYgTVVURVhfRkxBR19XQUlURVJTIGlz
IHNldCBhbmQgdGhlcmUgYXJlIHJlYWwgd2FpdGVycywgdGhvc2Ugd2FpdGVycw0KPiA+ID4gaGF2
ZSB0byBrZWVwIHRoZSBtdXRleCBhbGl2ZSwgSSB0aGluazsgYnV0IHdlIGNvdWxkIGhhdmUgYSBz
cHVyaW91cw0KPiA+ID4gTVVURVhfRkxBR19XQUlURVJTIGxlZnQgaWYgYW4gaW50ZXJydXB0aWJs
ZS9raWxsYWJsZSB3YWl0ZXIgYmFpbGVkDQo+ID4gPiBiZXR3ZWVuIHRoZSBwb2ludHMgd2hlcmUg
X19tdXRleF91bmxvY2tfc2xvd3BhdGgoKSBkaWQgdGhlIGNtcHhjaGcNCj4gPiA+IHJlYWRpbmcg
dGhlIGZsYWdzIGFuZCB3aGVyZSBpdCBhY3F1aXJlZCB0aGUgd2FpdF9sb2NrLg0KPiA+ID4NCj4g
PiA+IChXaXRoIHNwaW5sb2NrcywgdGhhdCBraW5kIG9mIGNvZGUgcGF0dGVybiBpcyBhbGxvd2Vk
IGFuZCwgZnJvbSB3aGF0IEkNCj4gPiA+IHJlbWVtYmVyLCB1c2VkIGluIHNldmVyYWwgcGxhY2Vz
IGluIHRoZSBrZXJuZWwuKQ0KPiA+ID4NCj4gPiA+IElmIG15IHVuZGVyc3RhbmRpbmcgb2YgdGhp
cyBpcyBjb3JyZWN0LCB3ZSBzaG91bGQgcHJvYmFibHkgZG9jdW1lbnQgdGhpcyAtDQo+ID4gPiBJ
IHRoaW5rIHN1Y2ggYSBzZW1hbnRpYyBkaWZmZXJlbmNlIGJldHdlZW4gbXV0ZXhlcyBhbmQgc3Bp
bmxvY2tzIGlzIGZhaXJseQ0KPiA+ID4gdW5pbnR1aXRpdmUuDQo+ID4NCj4gPiBTcGlubG9ja3Mg
YXJlIGZhaXIuIFNvIGRvaW5nIGEgbG9jay91bmxvY2sgc2VxdWVuY2Ugd2lsbCBtYWtlIHN1cmUg
dGhhdA0KPiA+IGFsbCB0aGUgcHJldmlvdXNseSB3YWl0aW5nIHdhaXRlcnMgYXJlIGRvbmUgd2l0
aCB0aGUgbG9jay4gUGFyYS12aXJ0dWFsDQo+ID4gc3BpbmxvY2tzLCBob3dldmVyLCBjYW4gYmUg
YSBiaXQgdW5mYWlyIHNvIGRvaW5nIGEgbG9jay91bmxvY2sgc2VxdWVuY2UNCj4gPiBtYXkgbm90
IGJlIGVub3VnaCB0byBndWFyYW50ZWUgdGhlcmUgaXMgbm8gd2FpdGVyLiBUaGUgc2FtZSBpcyB0
cnVlIGZvcg0KPiA+IG11dGV4LiBBZGRpbmcgYSBzcGluX2lzX2xvY2tlZCgpIG9yIG11dGV4X2lz
X2xvY2tlZCgpIGNoZWNrIGNhbiBtYWtlDQo+ID4gc3VyZSB0aGF0IGFsbCB0aGUgd2FpdGVycyBh
cmUgZ29uZS4NCj4gDQo+IEkgdGhpbmsgdGhpcyBwYXR0ZXJuIGFueXdheSBvbmx5IHdvcmtzIHdo
ZW4geW91J3JlIG9ubHkgdHJ5aW5nIHRvIHdhaXQNCj4gZm9yIHRoZSBjdXJyZW50IGhvbGRlciBv
ZiB0aGUgbG9jaywgbm90IHRhc2tzIHRoYXQgYXJlIHF1ZXVlZCB1cCBvbg0KPiB0aGUgbG9jayBh
cyB3YWl0ZXJzIC0gc28gYSB0YXNrIGluaXRpYWxseSBob2xkcyBhIHN0YWJsZSByZWZlcmVuY2Ug
dG8NCj4gc29tZSBvYmplY3QsIHRoZW4gYWNxdWlyZXMgdGhlIG9iamVjdCdzIGxvY2ssIHRoZW4g
ZHJvcHMgdGhlIG9yaWdpbmFsDQo+IHJlZmVyZW5jZSwgYW5kIHRoZW4gbGF0ZXIgZHJvcHMgdGhl
IGxvY2suDQo+IFlvdSBjYW4gc2VlIGFuIGV4YW1wbGUgb2Ygc3VjaCBtdXRleCB1c2FnZSAod2hp
Y2ggaXMgZXhwbGljaXRseSBsZWdhbA0KPiB3aXRoIHVzZXJzcGFjZSBQT1NJWCBtdXRleGVzLCBi
dXQgaXMgZm9yYmlkZGVuIHdpdGgga2VybmVsIG11dGV4ZXMpIGF0DQo+IHRoZSBib3R0b20gb2Yg
dGhlIFBPU0lYIG1hbnBhZ2UgZm9yIHB0aHJlYWRfbXV0ZXhfZGVzdHJveSgpIGF0DQo+IDxodHRw
czovL3B1YnMub3Blbmdyb3VwLm9yZy9vbmxpbmVwdWJzLzAwNzkwNDg3NS9mdW5jdGlvbnMvcHRo
cmVhZF9tdXRleF9kZXN0cm95Lmh0bWw+LA0KPiBpbiB0aGUgc2VjdGlvbiAiRGVzdHJveWluZyBN
dXRleGVzIi4NCg0KSSBkb24ndCB1bmRlcnN0YW5kIGF0IGFsbCB3aGF0IGFueSBvZiB0aGlzIGlz
IGFib3V0Lg0KWW91IGNhbm5vdCBkZS1pbml0aWFsaXNlLCBmcmVlIChldGMpIGEgbXV0ZXggKG9y
IGFueSBvdGhlciBwaWVjZSBvZg0KbWVtb3J5IGZvciB0aGF0IG1hdHRlcikgaWYgYW5vdGhlciB0
aHJlYWQgY2FuIGhhdmUgYSByZWZlcmVuY2UgdG8gaXQuDQpJZiBzb21lIG90aGVyIGNvZGUgbWln
aHQgYmUgaG9sZGluZyB0aGUgbXV0ZXggaXQgYWxzbyBtaWdodCBiZSBqdXN0DQphYm91dCB0byBh
Y3F1aXJlIGl0IC0geW91IGFsd2F5cyBuZWVkIGFub3RoZXIgbG9jayBvZiBzb21lIGtpbmQgdG8N
CmVuc3VyZSB0aGF0IGRvZXNuJ3QgaGFwcGVuLg0KDQpJSVJDIHByZXR0eSBtdWNoIHRoZSBvbmx5
IHRpbWUgeW91IG5lZWQgdG8gYWNxdWlyZSB0aGUgbXV0ZXggaW4gdGhlDQpmcmVlIHBhdGggaXMg
aWYgbG9ja3MgYXJlIGNoYWluZWQsIGVnOg0KCWxvY2sodGFibGUpDQoJZW50cnkgPSBmaW5kX2Vu
dHJ5KCk7DQoJbG9jayhlbnRyeSkNCgl1bmxvY2sodGFibGUpDQoJLi4uDQoJdW5sb2NrKGVudHJ5
KQ0KDQpUaGVuIHRoZSBmcmVlIGNvZGUgaGFzIHRvOg0KCWxvY2sodGFibGUpDQoJcmVtb3ZlX2Zy
b21fdGFibGUoZW50cnkpDQoJbG9jayhlbnRyeSkNCgl1bmxvY2soZW50cnkpDQoJdW5sb2NrKHRh
YmxlKQ0KCWZyZWUoZW50cnkpDQoNCklTVFIgc29tZXRoaW5nIGFib3V0IG11dGV4X3VubG9jaygp
IG5vdCBiZWluZyBhIGZ1bGwgbWVtb3J5IGJhcnJpZXIuDQpCdXQgdGhhdCBpcyBlbnRpcmVseSBk
aWZmZXJlbnQgdG8gdGhpcyBkaXNjdXNzaW9uLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBB
ZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMs
IE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

