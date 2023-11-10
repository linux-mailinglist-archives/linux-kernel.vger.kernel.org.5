Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62EE67E7E64
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345913AbjKJRo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345895AbjKJRns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:43:48 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032E8A5DE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:00:25 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-107-mpQGjel4NGeU1hbYwlOghw-1; Fri, 10 Nov 2023 09:00:22 +0000
X-MC-Unique: mpQGjel4NGeU1hbYwlOghw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 10 Nov
 2023 09:00:21 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 10 Nov 2023 09:00:21 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        "imre.deak@intel.com" <imre.deak@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Build fail in drivers/gpu/drm/i915/display/intel_tc.c
Thread-Topic: Build fail in drivers/gpu/drm/i915/display/intel_tc.c
Thread-Index: AdoTX9s2sPRYSwRmSkOwOZ8JicXQjgAEEIUiABCaxIA=
Date:   Fri, 10 Nov 2023 09:00:21 +0000
Message-ID: <39709b4bb3e447159759a9923bd4a564@AcuMS.aculab.com>
References: <4df68c74c4da46ac943ac21578e9b084@AcuMS.aculab.com>
 <ZU1shQH64ryxp/l5@ideak-desk.fi.intel.com>
 <CAHk-=wgiPxF6GnvaSGV+xOjcBO-T1vxLYhSvho0Q5Cdqw7t74w@mail.gmail.com>
In-Reply-To: <CAHk-=wgiPxF6GnvaSGV+xOjcBO-T1vxLYhSvho0Q5Cdqw7t74w@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTAgTm92ZW1iZXIgMjAyMyAwMDo1Mg0KPiAN
Cj4gT24gVGh1LCA5IE5vdiAyMDIzIGF0IDE1OjM0LCBJbXJlIERlYWsgPGltcmUuZGVha0BpbnRl
bC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gVGhlIGNvbXBpbGVyIHdhcm4gc2hvdWxkIGJlIGZpeGVk
L3N1cHByZXNzZWQgYnk6DQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMxMDI2
MTI1NjM2LjUwODAtMS1uaXJtb3kuZGFzQGludGVsLmNvbQ0KPiANCj4gVWdoLCBzbyBub3cgaXQn
cyBhIGR5bmFtaWMgYWxsb2NhdGlvbiwgd2FzdGluZyBtZW1vcnksIGFuZCBhIHBvaW50ZXINCj4g
dG8gaXQsIHVzaW5nIGFzIG11Y2ggbWVtb3J5IGFzIHRoZSBhcnJheSBkaWQgaW4gdGhlIGZpcnN0
IHBsYWNlLg0KPiANCj4gQWxsIGJlY2F1c2Ugb2YgYSBwb2ludGxlc3Mgd2FybmluZyB0aGF0IHdh
cyBhIGZhbHNlIHBvc2l0aXZlIC0gYW5kIHdhcw0KPiBhbHdheXMgaGFybWxlc3MgYW55d2F5LCBz
aW5jZSBzbnByaW50ZigpIGlzIHNhZmUgKGllIGl0IHdhcyBvbmx5IGENCj4gIm1pZ2h0IGJlIHRy
dW5jYXRlZCIpLg0KDQpUaGF0IGVudGlyZSB3YXJuaW5nIGZvciBzbnByaW50ZigpIGlzIGEgZmFs
c2UgcG9zaXRpdmUuDQpUaGUgb25lcyB0aGF0IGFyZSBsaWtlbHkgdG8gb3ZlcmZsb3cgdW5leHBl
Y3RlZGx5IGFyZSB0aGUgb25lcw0Kd2l0aCBhICIlcyIgZm9ybWF0IGZvciBhICdjaGFyIConIHBv
aW50ZXIgd2hlcmUgdGhlcmUgaXMgbm8NCmltcGxpZWQgbGVuZ3RoLg0KDQpUaGUgc2FtZSBjaGVj
ayBmb3IgcHJpbnRmKCkgdXNpbmcgdGhlIGltcGxpZWQgYnVmZmVyIGxlbmd0aA0KcHJvYmFibHkg
ZG9lcyBtYWtlIHNlbnNlLg0KDQpJIGRvbid0IGV2ZW4gdGhpbmsgdGhlcmUgaXMgYSB3YXkgb2Yg
YXZvaWRpbmcgaXQgb24gYSBjYXNlIGJ5IGNhc2UNCmJhc2lzIC0gYXBhcnQgZnJvbSBwYXNzaW5n
IGJvdGggdGhlIGJ1ZmZlciBhZGRyZXNzIGFuZCBsZW5ndGgNCnRvIGFuIGlubGluZSBhc20gdGhh
dCB0aGUgY29tcGlsZXIgaGFzIHRvIGFzc3VtZSBtaWdodCBjaGFuZ2UNCnRoZSB2YWx1ZXMsIGJ1
dCB0aGF0IHRlbmRzIHRvIGdlbmVyYXRlIGFuIGV4dHJhICdtb3YnIGluc3RydWN0aW9uDQpmb3Ig
bm8gZ29vZCByZWFzb24gYXQgYWxsLg0KDQo+IA0KPiBQbGVhc2UgZG9uJ3QgZG8gdGhpcy4gRWl0
aGVyIGRvIHRoYXQgKCh0Y19wb3J0ICYgNykgKyAxKSBzdWdnZXN0aW9uIG9mDQo+IERhdmlkJ3Ms
IG9yIGp1c3QgZG8gJyVjJyBhbmQgbWFrZSB0aGUgZXhwcmVzc2lvbiBiZQ0KPiANCj4gICAnMScg
KyB0Y19wb3J0DQo+IA0KPiB3aGljaCBzaG91bGQgYmUgZmluZSBzaW5jZSBJOTE1X01BWF9QT1JU
UyBpcyA4IG9yIHdoYXRldmVyLg0KDQpJZiBJJ2QgdGhvdWdoIGZvciAyIHNlY29uZHMgdGhhdCBp
cyB3aGF0IEknZCBoYXZlIGRvbmUuDQpCdXQgSSB3YW50ZWQgdG8gZ2V0IHNvbWV0aGluZyB0aHJv
dWdoIHRoZSBjb21waWxlci4NCg0KPiBJIGRvIHdvbmRlciB3aHkgdGhvc2UgcG9ydHMgYXJlIHBy
aW50ZWQgb3V0IGFzICcxLTgnLCB3aGVuIHRoZSAnZW51bQ0KPiBwb3J0JyBpcyBQT1JUX0EuLkku
DQoNClRoZXkgbG9vayBsaWtlIFRDX1BPUlRfWzEuLjZdIHRvIG1lIC0gdGhlIGVudW0gdmFsdWVz
IGFyZSAwLi41DQp3aGljaCBpcyB3aHkgdGhlcmUgaXMgYSAncmFuZG9tJyAnKyAxJy4NCg0KCURh
dmlkDQoNCj4gDQo+IFNvIGl0IHdvdWxkIGFjdHVhbGx5IGhhdmUgbWFkZSBtb3JlIHNlbnNlIHRv
IHByaW50IHRoZW0gb3V0IGFzICVjIHdpdGgNCj4gdGhlIGV4cHJlc3Npb24gYmVpbmcNCj4gDQo+
ICAgICdBJyt0Y19wb3J0DQo+IA0KPiBidXQgSSBndWVzcyBieSBub3cgcGVvcGxlIG1pZ2h0IGRl
cGVuZCBvbiB0aGUgMS4uOCBuYW1pbmc/DQo+IA0KPiAgICAgICAgICAgICAgTGludXMNCg0KLQ0K
UmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1p
bHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVz
KQ0K

