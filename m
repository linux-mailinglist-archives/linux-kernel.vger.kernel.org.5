Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7FD7772E4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbjHJI3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjHJI3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:29:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98402ED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:29:32 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-214-I3eaVDq4MvG0XZR_8-ylxQ-1; Thu, 10 Aug 2023 09:29:30 +0100
X-MC-Unique: I3eaVDq4MvG0XZR_8-ylxQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 10 Aug
 2023 09:29:27 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 10 Aug 2023 09:29:27 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: RE: [PATCH v3 5/5] minmax: Relax check to allow comparison between
 int and small unsigned constants.
Thread-Topic: [PATCH v3 5/5] minmax: Relax check to allow comparison between
 int and small unsigned constants.
Thread-Index: AdnGwkt6hGqNS4p3Ts2CQBK2yLMoFAANMf+AAITzIRAADNjaAACIoXRg
Date:   Thu, 10 Aug 2023 08:29:27 +0000
Message-ID: <f88a67c60b3d4a8c98a4aaaa32fd2c33@AcuMS.aculab.com>
References: <01e3e09005e9434b8f558a893a47c053@AcuMS.aculab.com>
 <b6a49ed73aba427ca8bb433763fa94e9@AcuMS.aculab.com>
 <CAHk-=whr-iSsxEZ4fYfkQzs7XQN=aQhbZQKGEMnZiGdrDgLKPQ@mail.gmail.com>
 <82fc9f39e3914a74abc7f968b1abba68@AcuMS.aculab.com>
 <CAHk-=whOOMM8k+6vB5k3LA=c3OwvHo+1iS6_SOwssV5_MUdoCg@mail.gmail.com>
In-Reply-To: <CAHk-=whOOMM8k+6vB5k3LA=c3OwvHo+1iS6_SOwssV5_MUdoCg@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDcgQXVndXN0IDIwMjMgMTY6NDkNCj4gDQo+
IE9uIE1vbiwgNyBBdWcgMjAyMyBhdCAwMzo1MCwgRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRA
YWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUbyBteSBtaW5kIHRoZSB2YWx1ZSBvZiBtaW4o
dmFyaWFibGUsIFRXRU5UWSkgc2hvdWxkbid0IGRlcGVuZA0KPiA+IG9uIGhvdyBUV0VOVFkgaXMg
ZGVmaW5lZCByZWdhcmRsZXNzIG9mIHRoZSB0eXBlIG9mIHRoZSB2YXJpYWJsZS4NCj4gPiBTbyAy
MCwgMjB1LCAyMGwsIDIwdWwsIChjaGFyKTIwLCBzaXplb2YgKGZvbyksIG9mZnNldG9mKHgsIHkp
DQo+ID4gc2hvdWxkIGFsbCBiZSBlcXVhbGx5IHZhbGlkIGFuZCBhbGwgZ2VuZXJhdGUgdGhlIHNh
bWUgcmVzdWx0Lg0KPiANCj4gVGhhdCBzb3VuZHMgbmljZSwgYnV0IEkgZG9uJ3QgYmVsaWV2ZSBp
dCBpcyB0cnVlLg0KPiANCj4gSWYgc29tZWJvZHkgd3JpdGVzDQo+IA0KPiAgICAgICBhID0gbWlu
KGIsIDIwdSk7DQo+IA0KPiB0aGVuIHRoYXQgaXMgKm5vdCogdGhlIHNhbWUgdGhpbmcgYXMNCj4g
DQo+ICAgICAgIGEgPSBtaW4oYiwgMjApOw0KPiANCj4gd2l0aG91dCBrbm93aW5nIHRoZSB0eXBl
cy4NCj4gDQo+IEJ1dCB5b3UgbWFrZSB0aGVtIGJlIHRoZSBzYW1lIHRoaW5nIC0gbm93IHRoZXkg
YmVjb21lIGFtYmlndW91cyBhbmQNCj4gZGVwZW5kIG9uIHRoZSB0eXBlIG9mICdiJy4NCj4gDQo+
IERvZXMgdGhhdCBleHByZXNzaW9uIG1lYW4gImdpdmUgbWUgYSBudW1iZXIgMC4uMjAiIG9yICJN
SU5JTlQuLjIwIj8NCg0KV2h5IGRvZXMgdGhlIGxvd2VyIGJvdW5kIG9mIGFueSB0eXBlIG1hdHRl
cj8NClRoZXJlIGFyZSB0d28gaW50ZWdlciB2YWx1ZXMgYmV0d2VlbiAtaW5maW5pdHkgYW5kICtp
bmZpbml0eS4NClRoZSByZXR1cm4gdmFsdWUgaXMgdGhlIHNtYWxsZXIgb2YgdGhlIHR3byB2YWx1
ZXMuDQoNClRoZSBvbmx5IHByb2JsZW0gYXJpc2VzIHdoZW4gdGhlcmUgaXNuJ3QgYSBDIHR5cGUg
dGhhdCBpcw0KZ3VhcmFudGVlZCB0byBiZSBhYmxlIHRvIGNvbnRhaW4gdGhlIHJlc3VsdC4NClR5
cGljYWxseSB0aGlzIGhhcHBlbnMgd2hlbiBjb21wYXJpbmcgc2lnbmVkIGludCBhbmQgdW5zaWdu
ZWQgaW50DQp3aGVyZSB0aGUgdmFsdWUgbWlnaHQgYmUgLTEgYW5kICgxdSA8PCAzMSkgLSBjbGVh
cmx5IGFsbG93aW5nDQp0aGlzIGlzIHByb2JsZW1hdGljLg0KDQo+IEFuZCB0aGUgd2hvbGUgcG9p
bnQgb2YgdGhlIHR5cGUgY2hlY2tpbmcgaXMgdmVyeSBtdWNoIHRvIG5vdCBoYXZlDQo+IGFtYmln
dW91cyBjb21wYXJpc29ucyB3aGVyZSB5b3UgY2FuIGhhdmUgdGhvc2Uga2luZHMgb2YgcXVlc3Rp
b25zLg0KPiANCj4gPiBJJ3ZlIGZvdW5kIGFsbCBzb3J0cyBvZiBkdWJpb3VzIG1pbl90KCkgd2hp
bGUgd3JpdGluZyB0aGVzZSBwYXRjaGVzLg0KPiA+IE9uZSBpbiBhIGZpbGVzeXN0ZW0gd2FzIG1p
bl90KHVsb25nLCB1bG9uZ192YXIsIHU2NF92YXIpIGFuZCBJDQo+ID4gY291bGRuJ3QgY29udmlu
Y2UgbXlzZWxmIGl0IHdhcyByaWdodCBvbiAzMmJpdC4NCj4gDQo+IEhvbmVzdGx5LCB0aGF0J3Mg
YSBncmVhdCBleGFtcGxlLCBidXQgSSB0aGluayB0aGF0J3MgbW9yZSBvZiBhbg0KPiBhcmd1bWVu
dCBhZ2FpbnN0ICdtaW5fdCgpJyB0aGFuIGl0IGlzIGFuIGFyZ3VtZW50IGZvciBjaGFuZ2luZyAn
bWluKCknDQo+IGFuZCAnbWF4KCknLg0KPiANCj4gSSB0aGluayBpdCB3YXMgYSBtaXN0YWtlIHRv
IGRvICJtaW5fdCgpIiwNCg0KQXQgbGVhc3Qgd2UgYWdyZWUgb24gdGhhdC4NCg0KPiBhbmQgd2Ug
c2hvdWxkIGhhdmUgZG9uZQ0KPiBzaWduLWJhc2VkIG9uZXMgKCJkbyBhIHVuc2lnbmVkL3NpZ25l
ZCBtaW4vbWF4IikuDQoNClBhdGNoIDEgYWRkcyBtaW5fdW5zaWduZWQoKSB0aGF0IHVzZXMgdGhl
IGludGVnZXIgcHJvbW90aW9uDQpydWxlcyB0byBjb252ZXJ0IGEgbm9uLW5lZ2F0aXZlIHNpZ25l
ZCB2YWx1ZSB0byB1bnNpZ25lZCB3aXRob3V0DQpldmVyIG1hc2tpbmcgaGlnaCBiaXRzLg0KVGhl
IGNvbXBpbGVyIHRoZW4gb3B0aW1pc2VzIG1vc3Qgb2YgaXQgYXdheS4NCg0KSSdtIG5vdCBzdXJl
IHlvdSBldmVyIHdhbnQgdG8gZm9yY2UgYSBzaWduZWQgY29tcGFyZSB3aXRoIGENCm5vbi1jb25z
dGFudCB1bnNpZ25lZCB2YWx1ZS4NClBhdGNoIDUgKHdoaWNoIHlvdSBzZWVtIHRvIHJlYWxseSBk
aXNsaWtlKSBtYWtlcyBjb21wYXJpc29ucw0KYWdhaW5zdCB1bnNpZ25lZCBjb25zdGFudHMgJ2p1
c3Qgd29yaycgLSB0aGUgcmV0dXJuZWQgdmFsdWUgaXMNCm5ldmVyIG1pc2xlYWRpbmcuDQoNClRo
ZSBvdGhlciBjb21tb24gcHJvYmxlbSB3aXRoIG1pbigpIGlzIGRpZmZlcmVudCBzaXplZCAob3Ig
bmFtZWQpDQp1bnNpZ25lZCB0eXBlcy4NCkl0IHdvdWxkIGJlIG5pY2UgZm9yIHRoZXNlIHRvIGJl
IGFsbG93ZWQgKHNpbmNlIHRoZSByZXN1bHQgYWx3YXlzDQpmaXRzIGluIHRoZSBzbWFsbGVyIHR5
cGUpIHdpdGhvdXQgaGF2aW5nIHRvIHVzZSAoZXZlbikgbWluX3Vuc2lnbmVkKCkNCmJlY2F1c2Ug
eW91J2QgdGhlbiBrbm93IHRoYXQgbm90aGluZyB3YXMgc2lnbmVkLg0KDQpDaGFuZ2luZyB0aGUg
YmFzaWMgdGVzdCBmcm9tICdzYW1lIHR5cGVzJyB0byAnc2FtZSBzaWduZWRuZXNzJw0KaW4gcGF0
Y2ggMyBtYWtlcyB0aGlzICdqdXN0IHdvcmsnLg0KDQo+IEkgYWdyZWUgdGhhdCBhICJtaW5fdCgp
IiB0aGF0IG5hcnJvd3MgdGhlIHR5cGUgaXMgdmVyeSBzY2FyeSwgaW4gdGhhdA0KPiBpdCBtaWdo
dCBsb3NlIGJpdHMsIGFuZCBpdCdzIG9idmlvdXNseSBhbHNvIGVhc2lseSBkZXBlbmRlbnQgb24g
d29yZA0KPiBzaXplIHRvbywgYXMgaW4geW91ciBleGFtcGxlLg0KPiANCj4gV2UgY291bGQgcGVy
aGFwcyBhaW0gdG8gbWFrZSAnbWluX3QoKScgd2FybiBhYm91dCAndCcgYmVpbmcgbmFycm93ZXIN
Cj4gdGhhbiB0aGUgdHlwZXMgeW91IGNvbXBhcmUuDQoNClRoYXQgaXMgZ29pbmcgdG8gZ2l2ZSBm
YWxzZSBwb3NpdGl2ZXMgd2l0aCBzaXplb2YoKS4NCg0KPiAoQWx0aG91Z2ggdGhlbiB5b3UgaGl0
IHRoZSB0cmFkaXRpb25hbCAiQyBkb2Vzbid0IHJlYWxseSBoYXZlICdjaGFyJw0KPiBhbmQgJ3No
b3J0JyB0eXBlcyBpbiBleHByZXNzaW9ucyIsIHNvIHlvdSdkIHByb2JhYmx5IGhhdmUgdG8gZG8g
dGhlDQo+IHR5cGUgc2l6ZSBjaGVjayB3aXRoIHdpZGVuaW5nIG9mICd0JyBpbiBwbGFjZSwgc28g
J21pbl90KGNoYXIsIGludCwNCj4gaW50KScgd291bGQgYmUgb2spLg0KDQpVc3VhbGx5IHlvdSBz
ZWU6DQoJY2hhcl9hID0gbWluX3QoY2hhciwgY2hhcl9iLCBsaW1pdCk7DQp0aGUgJ2NoYXInIHBy
ZXR0eSBtdWNoIG5lZWRzIHRvIGJlICdpbnQnLg0Kb3I6DQoJY2hhcl9hID0gbWluX3QoY2hhciwg
Y2hhcl9hICsgMSwgY2hhcl9iKTsNCnBhdGNoIDQgY29udmVydHMgY2hhci9zaG9ydCB0byBzaWdu
ZWQgaW50IGZvciB0aGUgc2lnbmVkbmVzcyB0ZXN0Lg0KDQpBcyBhIEMgdGVzdCwgd2hpY2ggb2Yg
dGhlc2UgZW51bSB2YWx1ZXMgYXJlIHVuc2lnbmVkPw0KQW5kIHdoYXQgZGlmZmVyZW5jZSBkb2Vz
IGdjYyAxMyBtYWtlPz8NCg0KZW51bSBlYSB7IGVhMSA9IDEsIGVhMXUgPSAxdX07DQplbnVtIGVi
IHsgZWIxID0gMSwgZWIxdSA9IDF1LCBlYm0xID0gLTF9Ow0KZW51bSBlYyB7IGVjMSA9IDEsIGVj
MXUgPSAxdSwgZWNteCA9IDB4ODAwMDAwMDB9Ow0KZW51bSBlZCB7IGVkMSA9IDEsIGVkbTEgPSAt
MSwgZWRteCA9IDB4ODAwMDAwMDB1fTsNCg0KKGZvciB0aGUgYW5zd2VyIHNlZSBodHRwczovL2dv
ZGJvbHQub3JnL3ovR3JNOGo5YTFxICkNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVz
cyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEg
MVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

