Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEE87D6557
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbjJYIit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbjJYIir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:38:47 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54746181
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:38:44 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-117-IHdEVsP-No-ljDSTXp_RpQ-1; Wed, 25 Oct 2023 09:38:41 +0100
X-MC-Unique: IHdEVsP-No-ljDSTXp_RpQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 25 Oct
 2023 09:38:39 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 25 Oct 2023 09:38:39 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: RE: [PATCH v4 1/3] math.h: add DIV_ROUND_UP_NO_OVERFLOW
Thread-Topic: [PATCH v4 1/3] math.h: add DIV_ROUND_UP_NO_OVERFLOW
Thread-Index: AQHaBszYM+Cp9N+qfkK9yv140Cm+RbBaJ2TA
Date:   Wed, 25 Oct 2023 08:38:39 +0000
Message-ID: <4c2d36375bd74d94a2e6ef5d2fa0df99@AcuMS.aculab.com>
References: <20231024161931.78567-1-sebastian.reichel@collabora.com>
 <20231024161931.78567-2-sebastian.reichel@collabora.com>
 <CAHk-=whYDbZ29fx_xeSxtYSjtF8WJkaLjzyB8RN5_Rk9Sh-YyQ@mail.gmail.com>
 <CAHk-=wjO5ivM6k7iMiThO9JfxH0dhLe=mcC4TQwReU0nBCnWpg@mail.gmail.com>
In-Reply-To: <CAHk-=wjO5ivM6k7iMiThO9JfxH0dhLe=mcC4TQwReU0nBCnWpg@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjQgT2N0b2JlciAyMDIzIDIzOjUzDQo+IA0K
PiBPbiBUdWUsIDI0IE9jdCAyMDIzIGF0IDA5OjMyLCBMaW51cyBUb3J2YWxkcw0KPiA8dG9ydmFs
ZHNAbGludXgtZm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiA+DQo+ID4gSSB3b3VsZCByZWFsbHkg
cHJlZmVyIHRvIGp1c3QgbWFrZSBvdXIgcmVndWxhciBESVZfUk9VTkRfVVAoKSBEVFJULiAgQnV0
Og0KPiA+DQo+ID4gIC0gcGVvcGxlIGRvIHVzZSBpdCB3aXRoIGNvbXBsZXggZmlyc3QgYXJndW1l
bnRzIChpZSBmdW5jdGlvbiBjYWxscw0KPiA+IGV0YykgdGhhdCB3ZSBkb24ndCB3YW50IHRvIGV2
YWx1YXRlIHR3aWNlDQo+ID4NCj4gPiAgLSB3ZSBjYW4ndCBtYWtlIGl0IGFuIGlubGluZSBmdW5j
dGlvbiwgYmVjYXVzZSB0aGUgdHlwZXMgYXJlbid0IGZpeGVkDQo+ID4NCj4gPiAgLSB3ZSBjYW4n
dCBldmVuIHVzZSBhIHN0YXRlbWVudCBleHByZXNzaW9uIGFuZCBfX2F1dG9fdHlwZSwgYmVjYXVz
ZQ0KPiA+IHRoZXNlIHRoaW5ncyBhcmUgdXNlZCBpbiB0eXBlIGRlZmluaXRpb25zIGV0YyBhbmQg
bmVlZCB0byBiZSBjb25zdGFudA0KPiA+IGV4cHJlc3Npb25zDQoNCkRvZXNuJ3QgbWluKCkgZ2V0
IGFyb3VuZCB0aGF0IGJ5IHVzaW5nIGlzX2NvbnN0ZXhwcigpIGFuZA0KX19idWlsdGluX2Nob29z
ZV9leHB0cigpIC0gdGhlIHNhbWUgY291bGQgYmUgZG9uZSBoZXJlLg0KDQo+IA0KPiBPay4gSSBo
YXZlIGEgcG90ZW50aWFsIGJlZ2lubmluZyBvZiBhIHNvbHV0aW9uLg0KPiANCj4gSXQgaXMgdW5i
ZWxpZXZhYmx5IGRpc2d1c3RpbmdseSBjb21wbGljYXRlZC4gQnV0IGl0IG1pZ2h0IGFwcHJvYWNo
DQo+IGJlaW5nIGNvcnJlY3QuDQo+IA0KPiBBbmQgYnkgdGhhdCAiaXQgbWlnaHQgYXBwcm9hY2gg
YmVpbmcgY29ycmVjdCIgSSBvYnZpb3VzbHkgbWVhbiAidGhpcw0KPiBpcyB1bnRlc3RlZCwgYnV0
IGJ1aWxkcyBhdCBsZWFzdCBzb21lIGtlcm5lbCBjb2RlIi4NCj4gDQo+IEknbSBhbG1vc3QgY2Vy
dGFpbiBpdCB3aWxsIGZhaWwgb24gbW9yZSBjb21wbGV4IGNhc2VzLCBiZWNhdXNlIEkNCj4gYWxy
ZWFkeSBmb3VuZCBhIGxvdCBvZiBxdWVzdGlvbmFibGUgc3R1ZmYgdGhhdCB3YXMgc2ltcGx5IGhp
ZGRlbiBieQ0KPiB0aGUgb2xkIG1hY3JvIGp1c3Qgc2lsZW50bHkgZG9pbmcgdGhlIEMgYXJpdGht
ZXRpYyB0eXBlIGNvbnZlcnNpb25zLA0KPiBhbmQgdGhpcyB0aGluZyBkb2VzIHR5cGUgaGFuZGxp
bmcgbWFudWFsbHkuDQo+IA0KPiBJJ20gaG9waW5nIHRoYXQgc29tZWJvZHkgd2lsbCBnbyAiTGlu
dXMsIHlvdSdyZSBqdXN0IGJlaW5nDQo+ICpjb21wbGV0ZWx5KiBzaWxseSwgaXQncyBtdWNoIGVh
c2llciB0byBkbyBYWVoiLg0KDQo+IERvaW5nIGEgbm9uLW92ZXJmbG93aW5nIERJVl9ST1VORF9V
UCgpIHRoYXQgaXMgdXNhYmxlIGluIGFsbCBjb250ZXh0cyBpcw0KPiBhY3R1YWxseSB2ZXJ5IG5h
c3R5Lg0KPg0KPiBUaGlzIGlzIGEgdHJpYWwgYmFsbG9vbi4uICBUaGUgc2lnbmVkIGNhc2VzIG5l
ZWQgbW9yZSB0aG91Z2h0LiAgVGhlIGJlc3QNCj4gb3B0aW9uIHdvdWxkIGJlIHRvIGRpc2FsbG93
IHRoZW0gKGJ5IG5vdCBsaXN0aW5nIHRoZW0gaW4gdGhlIF9HZW5lcmljKCkNCj4gcnVsZXMpLiBC
dXQgdGhleSBjdXJyZW50bHkgaGFwcGVuLCBvZnRlbiBmb3IgYmFkIHJlYXNvbnMsIGllIHdpcmVs
ZXNzIGhhcw0KPg0KPiAJRElWX1JPVU5EX1VQKGludGVydmFsLCBNU0VDX1BFUl9TRUMpOw0KPg0K
PiBhbmQgd2hpbGUgJ2ludGVydmFsJyBpcyBhIHByb3BlciB1MzIsIE1TRUNfUEVSX1NFQyBpcyBk
ZWZpbmVkIHRvIGJlDQo+ICcxMDAwTCcsIHNvIHRoZSByZXN1bHRpbmcgQyBhcml0aG1ldGljIGlz
IGRvbmUgaW4gc2lnbmVkICdsb25nJy4NCg0KTWF5YmUgdXNlIHNvbWUgb2YgdGhlICdzdHVmZicg
ZnJvbSBtaW4oKSBhbmQgY29udmVydCBjb21waWxlLXRpbWUNCmNvbnN0YW50ICdkJyB0byBzaWdu
ZWQgaW50IHRvIGF2b2lkIHByb21vdGlvbnMuDQoNCkluZGVlZCB0aGUgd2hvbGUgdGhpbmcgcmVh
bGx5IG9ubHkgbWFrZXMgc2Vuc2UgZm9yIChkID4gMCAmJiBuID49IDApDQpzbyBmb3JjaW5nIGFu
IHVuc2lnbmVkIGRpdmlkZSB3b3VsZG4ndCBiZSBhIGJhZCB0aGluZyBhdCBhbGwuDQpJdCB3aWxs
IGFsc28gZ2VuZXJhdGUgYmV0dGVyIGNvZGUgd2hlbiAnZCcgaXMgYSBwb3dlciBvZiAyLg0KDQpJ
Z25vcmluZyB0aGUgbj09MCBjYXNlIEkgdGhpbmsgdGhpcyBhbHdheXMgZ2VuZXJhdGVzIGFuIHVu
c2lnbmVkDQpkaXZpZGUsIG5ldmVyIGRvZXMgc2lnbiBleHRlbnNpb24gYW5kIGRvZXMgYSAzMmJp
dCBkaXZpZGUNCmZvciAzMmJpdCBhcmd1bWVudHMuDQoNCiNkZWZpbmUgQ1ZUX1VMTCh4KSAoKHgp
ICsgMHUgKyAwdWwgKyAwdWxsKQ0KI2RlZmluZSBESVZfUk9VTkRfVVAobiwgZCkgKChDVlRfVUxM
KG4pICsgQ1ZUX1VMTChkKSAtIDEpIC8gQ1ZUX1VMTChkKSArIDEpDQoNCkl0IHNob3VsZCBiZSBw
b3NzaWJsZSB0byBlcnJvciBpZiAnZCcgaXMgYSBzaWduZWQgdmFyaWFibGUgb3INCmEgbm9uLXBv
c2l0aXZlIGNvbnN0YW50Lg0KSSdkIGd1ZXNzIG1vc3QgJ2QnIGFyZSBjb25zdGFudHMuDQoNCkVy
cm9yaW5nIHNpZ25lZCAnbicgaXMgcG9zc2libGUgYnV0IG1pZ2h0IGJlIGFubm95aW5nLg0KDQoJ
RGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1v
dW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEz
OTczODYgKFdhbGVzKQ0K

