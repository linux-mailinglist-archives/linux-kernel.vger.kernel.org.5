Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E20979CA7E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjILIqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjILIp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:45:59 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 636B5AA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:45:55 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-251-xsmTvxyCNdS6PTrhFzXR5w-1; Tue, 12 Sep 2023 09:45:42 +0100
X-MC-Unique: xsmTvxyCNdS6PTrhFzXR5w-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 12 Sep
 2023 09:45:39 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 12 Sep 2023 09:45:39 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Charlie Jenkins' <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: RE: [PATCH v4 2/5] riscv: Add checksum library
Thread-Topic: [PATCH v4 2/5] riscv: Add checksum library
Thread-Index: AQHZ5QNmAqaxDkDqBUuW+t+6iXe0brAW2+/w
Date:   Tue, 12 Sep 2023 08:45:38 +0000
Message-ID: <1818c4114b0e4144a9df21f235984840@AcuMS.aculab.com>
References: <20230911-optimize_checksum-v4-0-77cc2ad9e9d7@rivosinc.com>
 <20230911-optimize_checksum-v4-2-77cc2ad9e9d7@rivosinc.com>
In-Reply-To: <20230911-optimize_checksum-v4-2-77cc2ad9e9d7@rivosinc.com>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2hhcmxpZSBKZW5raW5zDQo+IFNlbnQ6IDExIFNlcHRlbWJlciAyMDIzIDIzOjU3DQo+
IA0KPiBQcm92aWRlIGEgMzIgYW5kIDY0IGJpdCB2ZXJzaW9uIG9mIGRvX2NzdW0uIFdoZW4gY29t
cGlsZWQgZm9yIDMyLWJpdA0KPiB3aWxsIGxvYWQgZnJvbSB0aGUgYnVmZmVyIGluIGdyb3VwcyBv
ZiAzMiBiaXRzLCBhbmQgd2hlbiBjb21waWxlZCBmb3INCj4gNjQtYml0IHdpbGwgbG9hZCBpbiBn
cm91cHMgb2YgNjQgYml0cy4gQmVuY2htYXJraW5nIGJ5IHByb3h5IGNvbXBpbGluZw0KPiBjc3Vt
X2lwdjZfbWFnaWMgKDY0LWJpdCB2ZXJzaW9uKSBmb3IgYW4geDg2IGNoaXAgYXMgd2VsbCBhcyBy
dW5uaW5nDQo+IHRoZSByaXNjdiBnZW5lcmF0ZWQgY29kZSBpbiBRRU1VLCBkaXNjb3ZlcmVkIHRo
YXQgc3VtbWluZyBpbiBhDQo+IHRyZWUtbGlrZSBzdHJ1Y3R1cmUgaXMgYWJvdXQgNCUgZmFzdGVy
IHRoYW4gZG9pbmcgNjQtYml0IHJlYWRzLg0KPiANCi4uLg0KPiArCXN1bSAgID0gc2FkZHItPnM2
X2FkZHIzMlswXTsNCj4gKwlzdW0gICs9IHNhZGRyLT5zNl9hZGRyMzJbMV07DQo+ICsJc3VtMSAg
PSBzYWRkci0+czZfYWRkcjMyWzJdOw0KPiArCXN1bTEgKz0gc2FkZHItPnM2X2FkZHIzMlszXTsN
Cj4gKw0KPiArCXN1bTIgID0gZGFkZHItPnM2X2FkZHIzMlswXTsNCj4gKwlzdW0yICs9IGRhZGRy
LT5zNl9hZGRyMzJbMV07DQo+ICsJc3VtMyAgPSBkYWRkci0+czZfYWRkcjMyWzJdOw0KPiArCXN1
bTMgKz0gZGFkZHItPnM2X2FkZHIzMlszXTsNCj4gKw0KPiArCXN1bTQgID0gY3N1bTsNCj4gKwlz
dW00ICs9IHVsZW47DQo+ICsJc3VtNCArPSB1cHJvdG87DQo+ICsNCj4gKwlzdW0gICs9IHN1bTE7
DQo+ICsJc3VtMiArPSBzdW0zOw0KPiArDQo+ICsJc3VtICs9IHN1bTI7DQo+ICsJc3VtICs9IHN1
bTQ7DQoNCkhhdmUgeW91IGdvdCBnY2MgdG8gY29tcGlsZSB0aGF0IGFzLWlzPw0KDQpXaGVuZXZl
ciBJJ3ZlIHRyaWVkIHRvIGdldCBhICd0cmVlIGFkZCcgY29tcGlsZWQgc28gdGhhdCB0aGUNCmVh
cmx5IGFkZHMgY2FuIGJlIGV4ZWN1dGVkIGluIHBhcmFsbGVsIGdjYyBhbHdheXMgcGVzc2ltaXNl
cw0KaXQgdG8gYSBsaW5lYXIgc2VxdWVuY2Ugb2YgYWRkcy4NCg0KQnV0IEkgYWdyZWUgdGhhdCBh
ZGRpbmcgMzJiaXQgdmFsdWVzIHRvIGEgNjRiaXQgcmVnaXN0ZXINCm1heSBiZSBubyBzbG93ZXIg
dGhhbiB0cnlpbmcgdG8gZG8gYW4gJ2FkZCBjYXJyeScgc2VxdWVuY2UNCnRoYXQgaXMgZ3VhcmFu
dGVlZCB0byBvbmx5IGRvIG9uZSBhZGQvY2xvY2suDQooQW5kIG9uIEludGVsIGNwdSBmcm9tIGNv
cmUtMiB1bnRpbCBJSVJDIEhhc3dlbGwgYWRjIHRvb2sgMiBjbG9ja3MhKQ0KDQpJSVJDIFJJU0NW
IGRvZXNuJ3QgaGF2ZSBhIGNhcnJ5IGZsYWcsIHNvIHRoZSBhZGMgc2VxdWVuY2UNCmlzIGhhcmQg
LSBwcm9iYWJseSB0YWtlcyB0d28gZXh0cmEgaW5zdHJ1Y3Rpb25zIHBlciB2YWx1ZS4NCkFsdGhv
dWdoIHdpdGggcGFyYWxsZWwgZXhlY3V0ZSBpdCBtYXkgbm90IG1hdHRlci4NCkNvbnNpZGVyOg0K
CXZhbCA9IGJ1ZltvZmZzZXRdOw0KCXN1bSArPSB2YWw7DQoJY2FycnkgKz0gc3VtIDwgdmFsOw0K
CXZhbCA9IGJ1ZltvZmZzZXQxXTsNCglzdW0gKz0gdmFsOw0KCS4uLg0KdGhlIGNvbXBhcmUgYW5k
ICdjYXJyeSArPScgY2FuIGJlIGV4ZWN1dGVkIGF0IHRoZSBzYW1lIHRpbWUNCmFzIHRoZSBmb2xs
b3dpbmcgdHdvIGluc3RydWN0aW9ucy4NCllvdSBkbyB0aGVuIGEgZmluYWwgc3VtICs9IGNhcnJ5
OyBzdW0gKz0gc3VtIDwgY2Fycnk7DQoNCkFzc3VtaW5nIGFsbCBpbnN0cnVjdGlvbnMgYXJlIDEg
Y2xvY2sgYW5kIGFueSByZWFkIGRlbGF5cw0KZ2V0IGZpbGxlZCB3aXRoIG90aGVyIGluc3RydWN0
aW9ucyAoYnkgc291cmNlIG9yIGhhcmR3YXJlDQppbnN0cnVjdGlvbiByZS1vcmRlcmluZykgZXZl
biB3aXRob3V0IHBhcmFsbGVsIGV4ZWN1dGUNCnRoYXQgaXMgNCBjbG9ja3MgZm9yIDY0IGJpdHMs
IHdoaWNoIGlzIG11Y2ggdGhlIHNhbWUgYXMgdGhlDQoyIGNsb2NrcyBmb3IgMzIgYml0cy4NCg0K
UmVtZW1iZXIgdGhhdCBhbGwgdGhlIDMyYml0IHZhbHVlcyBjYW4gc3VtbWVkIGZpcnN0IGFzDQp0
aGV5IHdvbid0IG92ZXJmbG93Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExh
a2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQs
IFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

