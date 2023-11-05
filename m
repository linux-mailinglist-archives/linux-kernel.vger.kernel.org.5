Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A967E1420
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 16:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjKEPr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 10:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKEPr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 10:47:27 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28678B8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 07:47:23 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-311-k3HE-6c7MEyLMT7ytN7A-A-1; Sun, 05 Nov 2023 15:47:20 +0000
X-MC-Unique: k3HE-6c7MEyLMT7ytN7A-A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 5 Nov
 2023 15:47:19 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 5 Nov 2023 15:47:19 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nadav Amit' <nadav.amit@gmail.com>,
        Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
CC:     Richard Weinberger <richard@nod.at>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: RE: Missing clobber on alternative use on Linux UM 32-bit
Thread-Topic: Missing clobber on alternative use on Linux UM 32-bit
Thread-Index: AQHaDwMKcQHyK5uteEWVVs9ePUP5ubBr4G4Q
Date:   Sun, 5 Nov 2023 15:47:19 +0000
Message-ID: <41cac2e7ad9341259f356e1b3cf5f418@AcuMS.aculab.com>
References: <24BD0906-C6FE-499C-9A4A-00C56E6EE84A@gmail.com>
 <a55f6941-ddf6-2355-271d-5ed0db5a2a62@kot-begemot.co.uk>
 <1616BF59-5C18-46C7-86AB-92604B683652@gmail.com>
In-Reply-To: <1616BF59-5C18-46C7-86AB-92604B683652@gmail.com>
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

RnJvbTogTmFkYXYgQW1pdA0KPiBTZW50OiAwNCBOb3ZlbWJlciAyMDIzIDA5OjQxDQo+IA0KPiA+
IE9uIE5vdiA0LCAyMDIzLCBhdCAxMTozNCBBTSwgQW50b24gSXZhbm92IDxhbnRvbi5pdmFub3ZA
a290LWJlZ2Vtb3QuY28udWs+IHdyb3RlOg0KPiA+DQo+ID4gT24gMDQvMTEvMjAyMyAwOToyNSwg
TmFkYXYgQW1pdCB3cm90ZToNCj4gPj4NCj4gPj4gSSB3YXMgcmVhZGluZyAoYWdhaW4pIHRoZSB4
ODYgQyBtYWNybyBvZiDigJxhbHRlcm5hdGl2ZSgp4oCdIGFuZCBJIHdhcyBhIGJpdA0KPiA+PiBz
dXJwcmlzZWQgaXQgZG9lcyBjbG9iYmVyIHRoZSBmbGFncyAo4oCcY2PigJ0pIGFzIGEgcHJlY2F1
dGlvbi4NCj4gPj4NCj4gPj4gICNkZWZpbmUgYWx0ZXJuYXRpdmUob2xkaW5zdHIsIG5ld2luc3Ry
LCBmdF9mbGFncykgXA0KPiA+PiAJYXNtX2lubGluZSB2b2xhdGlsZSAoQUxURVJOQVRJVkUob2xk
aW5zdHIsIG5ld2luc3RyLCBmdF9mbGFncykgOiA6IDogIm1lbW9yeSIpDQo+ID4+DQo+ID4+IEFj
dHVhbGx5IHRoZXJlIHNlZW1zIHRvIGJlIG9ubHkgb25lIGluc3RhbmNlIG9mIHByb2JsZW1hdGlj
IGNhc2VzIC0gaW4gdW0vMzItYml0Og0KPiA+Pg0KPiA+PiAgI2RlZmluZSBtYigpIGFsdGVybmF0
aXZlKCJsb2NrOyBhZGRsICQwLDAoJSVlc3ApIiwgIm1mZW5jZSIsIFg4Nl9GRUFUVVJFX1hNTTIp
DQo+ID4+ICAjZGVmaW5lIHJtYigpIGFsdGVybmF0aXZlKCJsb2NrOyBhZGRsICQwLDAoJSVlc3Ap
IiwgImxmZW5jZSIsIFg4Nl9GRUFUVVJFX1hNTTIpDQo+ID4+ICAjZGVmaW5lIHdtYigpIGFsdGVy
bmF0aXZlKCJsb2NrOyBhZGRsICQwLDAoJSVlc3ApIiwgInNmZW5jZSIsIFg4Nl9GRUFUVVJFX1hN
TSkNCj4gPj4NCj4gPj4gUHJlc3VtYWJseSwgaWYgWE1NIG9yIFhNTTIgYXJlIG5vdCBzdXBwb3J0
ZWQsIHRoZXJlIHdvdWxkIGJlIGluc3RhbmNlcyB3aGVyZSBhZGRsDQo+ID4+IHdvdWxkIGJlIGFi
bGUgdG8gY2hhbmdlIGVmbGFncyBhcml0aG1ldGljIGZsYWdzIHdpdGhvdXQgdGhlIGNvbXBpbGVy
IGJlaW5nIGF3YXJlDQo+ID4+IG9mIGl0Lg0KPiA+Pg0KPiA+PiBBcyBpdCBvbmx5IGFmZmVjdHMg
MzItYml0IExpbnV4IFVNIC0gSSBkb27igJl0IGVhc2lseSBoYXZlIGFuIGVudmlyb25tZW50IHRv
IHRlc3QNCj4gPj4gdGhlIGZpeC4gQW4gYWx0ZXJuYXRpdmUgKHdvcmQtcHVuIHVuaW50ZW5kZWQp
IGlzIHRvIGFkZCDigJxjY+KAnSBhcyBhIHByZWNhdXRpb24NCj4gPj4gdG8gdGhlIGFsdGVybmF0
aXZlIG1hY3JvLg0KPiA+Pg0KPiA+IEFwcGxpY2F0aW9uIGFsdGVybmF0aXZlcyBpbiB1bSBpcyBw
cmVzZW50bHkgYSBOT1AuIEl0IGFsd2F5cyB1c2VzIHRoZSAiYmx1bnQgYW5kIGhlYXZ5IGluc3Ry
dW1lbnQiIC0NCj4gdGhlIG1vc3QgY29uc2VydmF0aXZlIG9wdGlvbi4NCj4gPg0KPiA+IEl0IGlz
IG9uIHRoZSBUT0RPIGxpc3QuDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBxdWljayByZXNwb25zZS4g
QnV0IEkgZG9u4oCZdCBzZWUgaG93IGl0IHByZXZlbnRzIHRoZSBwcm9ibGVtDQo+IChpdCBhY3R1
YWxseSBtYWtlcyBpdCB3b3JzZSAtIGFmZmVjdGluZyBYTU0vWE1NMiBDUFVzIGFzIHdlbGwpIHNp
bmNlIHlvdQ0KPiBrZWVwIHRoZSDigJxsb2NrOyBhZGRsICQwLDAoJSVlc3Ap4oCdIGluIHRoZSBy
dW5uaW5nIGNvZGUsIGFmZmVjdGluZyBlZmxhZ3MNCj4gd2l0aG91dCB0ZWxsaW5nIHRoZSBjb21w
aWxlciB0aGF0IHlvdSBkbyBzbyB0aHJvdWdoIGEg4oCcY2PigJ0gY2xvYmJlci4NCg0KZ2NjIGFs
d2F5cyBhc3N1bWVzIHRoYXQgaW5saW5lIGFzbSBjaGFuZ2VzICJjYyIgLSB0aGVyZSBpcyBubyBu
ZWVkDQp0byBhZGQgYSAnY2xvYmJlcicgZm9yIGl0Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJl
ZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXlu
ZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

