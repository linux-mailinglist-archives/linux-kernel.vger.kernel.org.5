Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB1A8011C2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjLARdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjLARdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:33:07 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C87E268D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:26:11 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-34-VenaSfaZNNST9igTQCh--Q-1; Fri, 01 Dec 2023 17:26:08 +0000
X-MC-Unique: VenaSfaZNNST9igTQCh--Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 1 Dec
 2023 17:26:00 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 1 Dec 2023 17:26:00 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Benno Lossin' <benno.lossin@proton.me>,
        Theodore Ts'o <tytso@mit.edu>
CC:     Alice Ryhl <aliceryhl@google.com>,
        "a.hindborg@samsung.com" <a.hindborg@samsung.com>,
        "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>,
        "arve@android.com" <arve@android.com>,
        "bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "cmllamas@google.com" <cmllamas@google.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dxu@dxuuu.xyz" <dxu@dxuuu.xyz>,
        "gary@garyguo.net" <gary@garyguo.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maco@android.com" <maco@android.com>,
        "ojeda@kernel.org" <ojeda@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
        "surenb@google.com" <surenb@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tkjos@android.com" <tkjos@android.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "wedsonaf@gmail.com" <wedsonaf@gmail.com>,
        "willy@infradead.org" <willy@infradead.org>
Subject: RE: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
Thread-Topic: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
Thread-Index: AQHaI6grPX7M7xYYCUW0jSY5A3gIgLCUVnoAgAA0bcyAACL7kA==
Date:   Fri, 1 Dec 2023 17:25:59 +0000
Message-ID: <70efae6ae16647ddbb2b2c887e90e7c8@AcuMS.aculab.com>
References: <386bbdee165d47338bc451a04e788dd6@AcuMS.aculab.com>
 <20231201122740.2214259-1-aliceryhl@google.com>
 <20231201150442.GC509422@mit.edu>
 <zWaYgly6VpMZcvVUAILQWBSs9VnO7nFiAiCo4eTzT4SJEfqXY8G8w7f6az7kz9wEB4pA8EbajkQZRX4CuifI00Ce3EA_4muXjz_kfdAuzOU=@proton.me>
In-Reply-To: <zWaYgly6VpMZcvVUAILQWBSs9VnO7nFiAiCo4eTzT4SJEfqXY8G8w7f6az7kz9wEB4pA8EbajkQZRX4CuifI00Ce3EA_4muXjz_kfdAuzOU=@proton.me>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQmVubm8gTG9zc2luDQo+IFNlbnQ6IDAxIERlY2VtYmVyIDIwMjMgMTU6MTQNCj4gDQo+
IE9uIDEyLzEvMjMgMTY6MDQsIFRoZW9kb3JlIFRzJ28gd3JvdGU6DQo+ID4gT24gRnJpLCBEZWMg
MDEsIDIwMjMgYXQgMTI6Mjc6NDBQTSArMDAwMCwgQWxpY2UgUnlobCB3cm90ZToNCj4gPj4NCj4g
Pj4gWW91IGNhbiBpbXBvcnQgaXQgd2l0aCBhIHVzZSBzdGF0ZW1lbnQuIEZvciBleGFtcGxlOg0K
PiA+Pg0KPiA+PiB1c2Uga2VybmVsOjpmaWxlOjpmbGFnczo6T19SRE9OTFk7DQo+ID4+IC8vIHVz
ZSBhcyBPX1JET05MWQ0KPiA+DQo+ID4gVGhhdCdzIGdvb2QgdG8gaGVhciwNCg0KRXhjZXB0IHRo
YXQgdGhlIGV4YW1wbGVzIGhlcmUgc2VlbSB0byBpbXBseSB5b3UgY2FuJ3QgaW1wb3J0DQphbGwg
b2YgdGhlIHZhbHVlcyB3aXRob3V0IGxpc3RpbmcgdGhlbSBhbGwuDQoNCkZyb20gd2hhdCBJJ3Zl
IHNlZW4gb2YgdGhlIHJ1c3QgcGF0Y2hlcyB0aGUgbGFuZ3VhZ2Ugc2VlbXMNCnRvIGhhdmUgYSBs
b3dlciBTTlIgdGhhbiBBREEgb3IgVkhETC4NClRvbyBtdWNoIHN5bnRhdGljICdnb29wJyBtYWtl
cyBpdCBkaWZmaWN1bHQgdG8gc2VlIHdoYXQgY29kZQ0KaXMgYWN0dWFsbHkgZG9pbmcuDQoNCi4u
Li4NCj4gQWx0ZXJuYXRpdmVseSBpZiB3ZSBlbmQgdXAgd2l0aCBtdWx0aXBsZSBmbGFncyBtb2R1
bGVzIHlvdSBjYW4gZG8gdGhpcw0KPiAodGhlIHNpeHRoIG9wdGlvbiBmcm9tIEFsaWNlKToNCj4g
DQo+ICAgICB1c2Uga2VybmVsOjpmaWxlOjpmbGFncyBhcyBmaWxlX2ZsYWdzOw0KPiAgICAgdXNl
IGtlcm5lbDo6Zm9vOjpmbGFncyBhcyBmb29fZmxhZ3M7DQo+IA0KPiAgICAgLy8gdXNhZ2U6DQo+
IA0KPiAgICAgZmlsZV9mbGFnczo6T19SRE9OTFkNCj4gDQo+ICAgICBmb29fZmxhZ3M6Ok9fUkRP
TkxZDQoNClRoYXQgbG9va3MgdXNlZnVsIGZvciB0aGUgJ29iZnVzY2F0ZWQgcnVzdCcgY29tcGV0
aXRpb24uDQpDb25zaWRlcjoNCgl1c2Uga2VybmVsOjpmaWxlOjpmbGFncyBhcyBmb29fZmxhZ3M7
DQoJdXNlIGtlcm5lbDo6Zm9vOjpmbGFncyBhcyBmaWxlX2ZsYWdzOw0KDQpJdCdzIHByb2JhYmx5
IGZvcnR1bmF0ZSB0aGF0IEknIG9sZCBlbm91Z2ggcmV0aXJlIGJlZm9yZSBhbnlvbmUgZm9yY2Vz
DQptZSB0byB3cml0ZSBhbnkgb2YgdGhpcyBzdHVmZiA6LSkNCg0KCURhdmlkDQoNCi0NClJlZ2lz
dGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24g
S2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

