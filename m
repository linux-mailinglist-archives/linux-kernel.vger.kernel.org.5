Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA22B75F92F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjGXOBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjGXOBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:01:34 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2DAFF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:01:31 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-228-RFpHSq0cPeuQ7jM8jWimbA-1; Mon, 24 Jul 2023 15:01:29 +0100
X-MC-Unique: RFpHSq0cPeuQ7jM8jWimbA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 24 Jul
 2023 15:01:27 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 24 Jul 2023 15:01:27 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Geert Uytterhoeven' <geert@linux-m68k.org>,
        Serge Semin <fancer.lancer@gmail.com>
CC:     "wuyonggang001@208suo.com" <wuyonggang001@208suo.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: baikal-t1: Using div64_ Ul replaces do_ Div()
 function
Thread-Topic: [PATCH] clk: baikal-t1: Using div64_ Ul replaces do_ Div()
 function
Thread-Index: AQHZvjSmxeKvFHAks0K1RCRZ2bTXfq/I8SJw
Date:   Mon, 24 Jul 2023 14:01:27 +0000
Message-ID: <daccab41116d4c88823ab7fc84846077@AcuMS.aculab.com>
References: <20230612033904.34921-1-zhanglibing@cdjrlc.com>
 <0dc9409b662180ed29cbc281f0f076b7@208suo.com>
 <fcd37e67fba625da304fdaf07e0ab0db@208suo.com>
 <CAMuHMdX0xP5Gugo7uF5Wqk9_ny6-4fOWYRm41KicOo26kC6m+g@mail.gmail.com>
 <nt6kbounehvfqo4hpfj3wbr7baukuhr22dafvoykgyehs4imsp@pc6bajyo6ugn>
 <CAMuHMdUHDK9CCJPoMgLQBrXjk9VWszYF17dUU=9JtQ8XX=QAPA@mail.gmail.com>
In-Reply-To: <CAMuHMdUHDK9CCJPoMgLQBrXjk9VWszYF17dUU=9JtQ8XX=QAPA@mail.gmail.com>
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

RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuDQo+IFNlbnQ6IDI0IEp1bHkgMjAyMyAxNDozOQ0KPiAN
Cj4gSGkgU2VyZ2UsDQo+IA0KPiBPbiBNb24sIEp1bCAyNCwgMjAyMyBhdCAzOjEz4oCvUE0gU2Vy
Z2UgU2VtaW4gPGZhbmNlci5sYW5jZXJAZ21haWwuY29tPiB3cm90ZToNCj4gPiBPbiBNb24sIEp1
bCAyNCwgMjAyMyBhdCAxMjowNDoxOVBNICswMjAwLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6
DQo+ID4gPiBPbiBXZWQsIEp1biAxNCwgMjAyMyBhdCA4OjA34oCvQU0gPHd1eW9uZ2dhbmcwMDFA
MjA4c3VvLmNvbT4gd3JvdGU6DQo+ID4gPiA+IEZpeCB0aGUgZm9sbG93aW5nIGNvY2NpY2hlY2sg
d2FybmluZzoNCj4gPiA+ID4NCj4gPiA+ID4gZHJpdmVycy9jbGsvYmFpa2FsLXQxL2NjdS1wbGwu
Yzo4MToxLTc6IFdBUk5JTkc6IGRvX2RpdigpIGRvZXMgYQ0KPiA+ID4gPiA2NC1ieS0zMiBkaXZp
c2lvbiwgcGxlYXNlIGNvbnNpZGVyIHVzaW5nIGRpdjY0X3VsIGluc3RlYWQuDQo+ID4gPiA+DQo+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFlvbmdnYW5nIFd1IDx3dXlvbmdnYW5nMDAxQDIwOHN1by5j
b20+DQo+ID4gPg0KPiA+ID4gVGhhbmtzIGZvciB5b3VyIHBhdGNoLCB3aGljaCBpcyBub3cgY29t
bWl0IGI5M2QxMzMxZWEyNjZkZWENCj4gPiA+ICgiY2xrOiBiYWlrYWwtdDE6IFVzaW5nIGRpdjY0
XyBVbCByZXBsYWNlcyBkb18gRGl2KCkgZnVuY3Rpb24iKQ0KPiA+ID4gaW4gY2xrL2Nsay1uZXh0
Lg0KPiA+ID4NCj4gPiA+ID4gYi9kcml2ZXJzL2Nsay9iYWlrYWwtdDEvY2N1LXBsbC5jDQo+ID4g
PiA+IGluZGV4IDEzZWYyODAwMTQzOS4uZDQxNzM1YzY5NTZhIDEwMDY0NA0KPiA+ID4gPiAtLS0g
YS9kcml2ZXJzL2Nsay9iYWlrYWwtdDEvY2N1LXBsbC5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMv
Y2xrL2JhaWthbC10MS9jY3UtcGxsLmMNCj4gDQo+ID4gPiA+IEBAIC03OCw5ICs3OCw5IEBAIHN0
YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyBjY3VfcGxsX2NhbGNfZnJlcSh1bnNpZ25lZA0KPiA+
ID4gPiBsb25nIHJlZl9jbGssDQo+ID4gPiA+ICAgew0KPiA+ID4gPiAgICAgICB1NjQgdG1wID0g
cmVmX2NsazsNCj4gPiA+ID4NCj4gPg0KPiA+ID4gPiAtICAgIGRvX2Rpdih0bXAsIG5yKTsNCj4g
PiA+ID4gKyAgICBkaXY2NF91bCh0bXAsIG5yKTsNCj4gPiA+ID4gICAgICAgdG1wICo9IG5mOw0K
PiA+ID4gPiAtICAgIGRvX2Rpdih0bXAsIG9kKTsNCj4gPiA+ID4gKyAgICBkaXY2NF91bCh0bXAs
IG9kKTsNCj4gPiA+ID4NCj4gPiA+ID4gICAgICAgcmV0dXJuIHRtcDsNCj4gPiA+DQo+ID4gPiBM
aWtld2lzZS4NCj4gPg0KPiA+IFJpZ2h0LiBUaGlzIHdpbGwgYWxzbyBicmVhayB0aGUgZHJpdmVy
Lg0KPiA+DQo+ID4gPiBCdXQgYXMgcmVmX2NsayBpcyB1bnNpZ25lZCBsb25nLCB0aGVyZSBpcyBu
byBuZWVkIHRvIHVzZSBkaXY2NF91bCgpDQo+ID4gPiBmb3IgdGhlIGZpcnN0IGRpdmlzaW9uLCBh
bmQgdGhpcyBjYW4gYmUgc2ltcGxpZmllZCB0bzoNCj4gPiA+DQo+ID4gPiAgICAgdTY0IHRtcCA9
ICh1NjQpKHJlZl9jbGsgLyBucikgKiBuZjsNCj4gPiA+ICAgICByZXR1cm4gZGl2NjRfdWwodG1w
LCBvZCk7DQo+ID4NCj4gPiBBYnNvbHV0ZWx5IHJpZ2h0LiBNeSBpbnRlbnRpb24gb2YgdXNpbmcg
dGhlIGRvX2RpdigpIGFueXdheSB3YXMgZm9yDQo+ID4gdGhlIHNha2Ugb2YgdGhlIGNvZGUgdW5p
ZmljYXRpb24uDQo+ID4NCj4gPiA+DQo+ID4gPiBUbyBhdm9pZCBsb3NzIG9mIHByZWNpc2lvbiwg
aXQgbWlnaHQgYmUgYmV0dGVyIHRvIHJldmVyc2UgdGhlIG9yZGVyDQo+ID4gPiBvZiB0aGUgZGl2
aXNpb24gYW5kIG11bHRpcGxpY2F0aW9uOg0KPiA+ID4NCj4gPg0KPiA+ID4gICAgIHU2NCB0bXAg
PSAodTY0KXJlZl9jbGsgKiBuZiAvIG5yOw0KPiA+DQo+ID4gQWxhcyBleGFjdGx5IHRoaXMgY29k
ZSB3aWxsIGNhdXNlIHRoZSBjb21waWxhdGlvbiBlcnJvciBvbiB0aGUgMzItYml0DQo+ID4gcGxh
dGZvcm06DQo+ID4gY2N1LXBsbC5jOigudGV4dCsweDQ1OCk6IHVuZGVmaW5lZCByZWZlcmVuY2Ug
dG8gYF9fdWRpdmRpMycNCj4gPg0KPiA+IFRoYXQncyB3aHkgSSBhbSB1c2luZyB0aGUgZG9fZGl2
KCkgaGVyZS4gSSB3b3VsZCBoYXZlIHJhdGhlciB1c2VkIHRoZQ0KPiA+IGRpdjY0X3VsKCkgaW5z
dGVhZCBhcyB0aGlzIHBhdGNoIHN1Z2dlc3RzLCBidXQgSSBoYXZlbid0IGtub3duIGFib3V0IGl0
cw0KPiA+IGV4aXN0ZW5jZSB1cCB0byB0aGlzIG1vbWVudC4NCj4gDQo+IEJ1bW1lciwgdGhhdCB3
YXMgYSBzaWxseSBtaXN0YWtlIG9uIG15IHNpZGUuLi4NCj4gKEluaXRpYWxseSwgSSBkaWRuJ3Qg
d3JpdGUgdGhlIGNhc3QgdG8gdTY0IHRoZXJlLCBhcyBhbGwgb2YgcmVmX2NsaywgbmYsIGFuZCBu
cg0KPiAgYXJlIHVuc2lnbmVkIGxvbmcuICBUaGVuIEkgcmVhbGl6ZWQgInJlZl9jbGsgKiBuZiIg
bWlnaHQgb3ZlcmZsb3cgb24NCj4gIDMyLWJpdCwgdGh1cyByZXF1aXJpbmcgYSA2NC1iaXQgcmVz
dWx0LiBBbmQgSSBhZGRlZCB0aGUgY2FzdC4uLikNCg0KQnV0IG9uIDMyYml0IHRoZSByZXN1bHQg
aXMgJ2xvbmcnLg0KU28gaXQgd2lsbCBvdmVyZmxvdyB1bmxlc3MgZG9fZGl2KCkgaXMgYWxzbyB2
YWxpZC4NCg0KVGhlIGFuYWx5c2lzIG5lZWQgdG8gbG9vayBhdCB0aGUgZG9tYWluIG9mIHRoZSB2
YWx1ZXMuDQpUaGUgd2FybmluZyBhbmQgc3VnZ2VzdGlvbiB0byB1c2UgZGl2NjRfdWwoKSBpcyBw
cmV0dHkgbXVjaCBhbHdheXMNCndyb25nLg0KDQpkaXY2NF91bCgpIGlzIGdvaW5nIHRvIGJlIGhv
cnJpYmx5IHNsb3cgb24gMzJiaXQuDQpBbHNvIG9uIDY0Yml0IEludGVsIGNwdSB0aGUgMTI4LzY0
IGRpdmlkZSB0YWtlcyB0d2ljZSBhcyBsb25nIGFzIDY0LzMyDQpldmVuIHdoZW4gdGhlIHZhbHVl
cyBhcmUgc21hbGwuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUs
IEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJl
Z2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

