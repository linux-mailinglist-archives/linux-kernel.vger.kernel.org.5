Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E678F7DB5BC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjJ3JGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbjJ3JGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:06:03 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09871BD
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:05:58 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-200-g2Ds3xdjPpCK9cbP3JEE4w-1; Mon, 30 Oct 2023 09:05:55 +0000
X-MC-Unique: g2Ds3xdjPpCK9cbP3JEE4w-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 30 Oct
 2023 09:05:48 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 30 Oct 2023 09:05:48 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Uros Bizjak' <ubizjak@gmail.com>
CC:     Brian Gerst <brgerst@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Ingo Molnar" <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov" <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: RE: [PATCH v2 00/11] x86-64: Stack protector and percpu improvements
Thread-Topic: [PATCH v2 00/11] x86-64: Stack protector and percpu improvements
Thread-Index: AQHaCCWwM6Gzma9PGEyZRt5JZqLOarBhUF8AgACvZQCAAA+iwA==
Date:   Mon, 30 Oct 2023 09:05:48 +0000
Message-ID: <1eb4f2c46e1642519a40924ed3fe3ccc@AcuMS.aculab.com>
References: <20231026160100.195099-1-brgerst@gmail.com>
 <a094c7da294a4827994af72249262593@AcuMS.aculab.com>
 <CAFULd4ZBGzceGbRaVLuMJ+qkoUpMv-rdBZB_D=Mni5RAWzgQBQ@mail.gmail.com>
In-Reply-To: <CAFULd4ZBGzceGbRaVLuMJ+qkoUpMv-rdBZB_D=Mni5RAWzgQBQ@mail.gmail.com>
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

RnJvbTogVXJvcyBCaXpqYWsNCj4gU2VudDogMzAgT2N0b2JlciAyMDIzIDA4OjA3DQo+IA0KPiBP
biBTdW4sIE9jdCAyOSwgMjAyMyBhdCAxMDo0MuKAr1BNIERhdmlkIExhaWdodCA8RGF2aWQuTGFp
Z2h0QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogQnJpYW4gR2Vyc3QNCj4gPiA+
IFNlbnQ6IDI2IE9jdG9iZXIgMjAyMyAxNzowMQ0KPiA+ID4NCj4gPiA+IEN1cnJlbnRseSwgeDg2
LTY0IHVzZXMgYW4gdW51c3VhbCBwZXJjcHUgbGF5b3V0LCB3aGVyZSB0aGUgcGVyY3B1IHNlY3Rp
b24NCj4gPiA+IGlzIGxpbmtlZCBhdCBhYnNvbHV0ZSBhZGRyZXNzIDAuICBUaGUgcmVhc29uIGJl
aGluZCB0aGlzIGlzIHRoYXQgb2xkZXIgR0NDDQo+ID4gPiB2ZXJzaW9ucyBwbGFjZWQgdGhlIHN0
YWNrIHByb3RlY3RvciAoaWYgZW5hYmxlZCkgYXQgYSBmaXhlZCBvZmZzZXQgZnJvbSB0aGUNCj4g
PiA+IEdTIHNlZ21lbnQgYmFzZS4gIFNpbmNlIHRoZSBHUyBzZWdlbWVudCBpcyBhbHNvIHVzZWQg
Zm9yIHBlcmNwdSB2YXJpYWJsZXMsDQo+ID4gPiB0aGlzIGZvcmNlZCB0aGUgY3VycmVudCBsYXlv
dXQuDQo+ID4gPg0KPiA+ID4gR0NDIHNpbmNlIHZlcnNpb24gOC4xIHN1cHBvcnRzIGEgY29uZmln
dXJhYmxlIGxvY2F0aW9uIGZvciB0aGUgc3RhY2sNCj4gPiA+IHByb3RlY3RvciB2YWx1ZSwgd2hp
Y2ggYWxsb3dzIHJlbW92YWwgb2YgdGhlIHJlc3RyaWN0aW9uIG9uIGhvdyB0aGUgcGVyY3B1DQo+
ID4gPiBzZWN0aW9uIGlzIGxpbmtlZC4gIFRoaXMgYWxsb3dzIHRoZSBwZXJjcHUgc2VjdGlvbiB0
byBiZSBsaW5rZWQNCj4gPiA+IG5vcm1hbGx5LCBsaWtlIG1vc3Qgb3RoZXIgYXJjaGl0ZWN0dXJl
cy4gIEluIHR1cm4sIHRoaXMgYWxsb3dzIHJlbW92YWwNCj4gPiA+IG9mIGNvZGUgdGhhdCB3YXMg
bmVlZGVkIHRvIHN1cHBvcnQgdGhlIHplcm8tYmFzZWQgcGVyY3B1IHNlY3Rpb24uDQo+ID4NCj4g
PiBJIGRpZG4ndCB0aGluayB0aGUgbWluaW11bSBnY2MgdmVyc2lvbiB3YXMgYW55dGhpbmcgbGlr
ZSA4LjEuDQo+ID4gSSdtIHVzaW5nIDcuNS4wIGFuZCBJIGRvbid0IHRoaW5rIHRoYXQgaXMgdGhl
IG9sZGVzdCB2ZXJzaW9uLg0KPiANCj4gUGxlYXNlIHNlZSBwcmV2aW91cyBkaXNjdXNzaW9uIHJl
Z2FyZGluZyBtb2Rlcm5pemluZyBzdGFjayBwcm90ZWN0b3INCj4gb24geDg2XzY0IFsxXQ0KPiAN
Cj4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMTExMTMxMjQwMzUuOTE4MC0x
LWJyZ2Vyc3RAZ21haWwuY29tLw0KPiANCj4gYW5kIHg4Nl8zMiBbMl0NCj4gDQo+IFsyXSBodHRw
czovL2xvcmUua2VybmVsLm9yZy9sa21sL2NvdmVyLjE2MDE5MjUyNTEuZ2l0Lmx1dG9Aa2VybmVs
Lm9yZy8NCj4gDQo+IFRoZSBjb25jbHVzaW9uIGluIFsyXSBpczoNCj4gDQo+ICJJJ20gYWxsIGlu
IGZhdm91ciBvZiBzaW1wbHkgcmVxdWlyaW5nIEdDQy04LjEgdG8gYnVpbGQgYSBtb3JlIHNlY3Vy
ZQ0KPiB4ODZfNjQga2VybmVsLiBHaXZlcyBwZW9wbGUgYW4gaW5jZW50aXZlIHRvIG5vdCB1c2Ug
YW5jaWVudCBjb21waWxlcnMuDQo+IA0KPiBBbmQgaWYgeW91IGRvIHdhbnQgdG8gdXNlIHlvdXIg
YW5jaWVudCBjb21waWxlciwgd2UnbGwgc3RpbGwgYnVpbGQsIHlvdQ0KPiBqdXN0IGRvbid0IGdl
dCB0byBoYXZlIHN0YWNrcHJvdGVjdG9yLiINCg0KSSBkaWRuJ3Qgc2VlIGEgcGF0Y2ggdGhhdCBs
aW1pdGVkICdzdGFja3Byb3RlY3RvcicgdG8gZ2NjID49IDguMQ0KV2l0aG91dCB0aGF0IGFueW9u
ZSB3aG8gYWxyZWFkeSBoYXMgaXQgZW5hYmxlZCBhbmQgaXMgdXNpbmcgYW4NCm9sZGVyIGNvbXBp
bGVyIHdpbGwgZ2V0IHZlcnkgYnJva2VuIGtlcm5lbHMuDQoNCglEYXZpZA0KDQo+IA0KPiBhbmQg
aW4gWzFdOg0KPiANCj4gIkFjay4gIFdlIGRpZCB0aGlzIGZvciAzMi1iaXQgYW5kIGdvdCBmZXcg
Y29tcGxhaW50cy4gTGV04oCZcyBmaW5pc2ggdGhlIGpvYi4iDQo+IA0KPiBVcm9zLg0KDQotDQpS
ZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWls
dG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMp
DQo=

