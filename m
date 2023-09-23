Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEB67AC52F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 23:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjIWVNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 17:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjIWVNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 17:13:36 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5A6180
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 14:13:29 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-138-x1T-MNuFPFKmQvfVANy0Sg-1; Sat, 23 Sep 2023 22:13:21 +0100
X-MC-Unique: x1T-MNuFPFKmQvfVANy0Sg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 23 Sep
 2023 22:13:20 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 23 Sep 2023 22:13:20 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Noah Goldstein' <goldstein.w.n@gmail.com>,
        kernel test robot <lkp@intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: x86/csum: Remove unnecessary odd handling
Thread-Topic: x86/csum: Remove unnecessary odd handling
Thread-Index: AQHZ7ib2fs4a8+P0bkWBCjHsrqR0abAo6HRA
Date:   Sat, 23 Sep 2023 21:13:19 +0000
Message-ID: <d02bd4f823534a00ae4915ead3d92773@AcuMS.aculab.com>
References: <20230920192300.3772199-1-goldstein.w.n@gmail.com>
 <202309231130.ZI5MdlDc-lkp@intel.com>
 <CAFUsyfKDRiX9kKOhHcA4PLqqT6Q5faHF0eRGiKN+9NSbvrUfDw@mail.gmail.com>
In-Reply-To: <CAFUsyfKDRiX9kKOhHcA4PLqqT6Q5faHF0eRGiKN+9NSbvrUfDw@mail.gmail.com>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTm9haCBHb2xkc3RlaW4NCj4gU2VudDogMjMgU2VwdGVtYmVyIDIwMjMgMTU6MDUNCj4g
DQo+IE9uIEZyaSwgU2VwIDIyLCAyMDIzIGF0IDEwOjI14oCvUE0ga2VybmVsIHRlc3Qgcm9ib3Qg
PGxrcEBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSGkgTm9haCwNCj4gPg0KPiA+IGtlcm5l
bCB0ZXN0IHJvYm90IG5vdGljZWQgdGhlIGZvbGxvd2luZyBidWlsZCB3YXJuaW5nczoNCj4gPg0K
PiA+IFthdXRvIGJ1aWxkIHRlc3QgV0FSTklORyBvbiB0aXAveDg2L2NvcmVdDQo+ID4gW2Fsc28g
YnVpbGQgdGVzdCBXQVJOSU5HIG9uIHRpcC9tYXN0ZXIgdGlwL2F1dG8tbGF0ZXN0IGxpbnVzL21h
c3RlciB2Ni42LXJjMiBuZXh0LTIwMjMwOTIxXQ0KPiA+IFtJZiB5b3VyIHBhdGNoIGlzIGFwcGxp
ZWQgdG8gdGhlIHdyb25nIGdpdCB0cmVlLCBraW5kbHkgZHJvcCB1cyBhIG5vdGUuDQo+ID4gQW5k
IHdoZW4gc3VibWl0dGluZyBwYXRjaCwgd2Ugc3VnZ2VzdCB0byB1c2UgJy0tYmFzZScgYXMgZG9j
dW1lbnRlZCBpbg0KPiA+IGh0dHBzOi8vZ2l0LXNjbS5jb20vZG9jcy9naXQtZm9ybWF0LXBhdGNo
I19iYXNlX3RyZWVfaW5mb3JtYXRpb25dDQo+ID4NCj4gPiB1cmw6ICAgIGh0dHBzOi8vZ2l0aHVi
LmNvbS9pbnRlbC1sYWItbGtwL2xpbnV4L2NvbW1pdHMvTm9haC1Hb2xkc3RlaW4veDg2LWNzdW0t
UmVtb3ZlLXVubmVjZXNzYXJ5LQ0KPiBvZGQtaGFuZGxpbmcvMjAyMzA5MjEtMDMyNDUwDQo+ID4g
YmFzZTogICB0aXAveDg2L2NvcmUNCj4gPiBwYXRjaCBsaW5rOiAgICBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9yLzIwMjMwOTIwMTkyMzAwLjM3NzIxOTktMS1nb2xkc3RlaW4udy5uJTQwZ21haWwu
Y29tDQo+ID4gcGF0Y2ggc3ViamVjdDogeDg2L2NzdW06IFJlbW92ZSB1bm5lY2Vzc2FyeSBvZGQg
aGFuZGxpbmcNCj4gPiBjb25maWc6IHg4Nl82NC1yYW5kY29uZmlnLTEyMS0yMDIzMDkyMSAoaHR0
cHM6Ly9kb3dubG9hZC4wMS5vcmcvMGRheS0NCj4gY2kvYXJjaGl2ZS8yMDIzMDkyMy8yMDIzMDky
MzExMzAuWkk1TWRsRGMtbGtwQGludGVsLmNvbS9jb25maWcpDQo+ID4gY29tcGlsZXI6IGdjYy0x
MiAoRGViaWFuIDEyLjIuMC0xNCkgMTIuMi4wDQo+ID4gcmVwcm9kdWNlICh0aGlzIGlzIGEgVz0x
IGJ1aWxkKTogKGh0dHBzOi8vZG93bmxvYWQuMDEub3JnLzBkYXktDQo+IGNpL2FyY2hpdmUvMjAy
MzA5MjMvMjAyMzA5MjMxMTMwLlpJNU1kbERjLWxrcEBpbnRlbC5jb20vcmVwcm9kdWNlKQ0KPiA+
DQo+ID4gSWYgeW91IGZpeCB0aGUgaXNzdWUgaW4gYSBzZXBhcmF0ZSBwYXRjaC9jb21taXQgKGku
ZS4gbm90IGp1c3QgYSBuZXcgdmVyc2lvbiBvZg0KPiA+IHRoZSBzYW1lIHBhdGNoL2NvbW1pdCks
IGtpbmRseSBhZGQgZm9sbG93aW5nIHRhZ3MNCj4gPiB8IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVz
dCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gPiB8IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvb2Uta2J1aWxkLWFsbC8yMDIzMDkyMzExMzAuWkk1TWRsRGMtbGtwQGludGVsLmNvbS8N
Cj4gPg0KPiA+IHNwYXJzZSB3YXJuaW5nczogKG5ldyBvbmVzIHByZWZpeGVkIGJ5ID4+KQ0KPiA+
ID4+IGFyY2gveDg2L2xpYi9jc3VtLXBhcnRpYWxfNjQuYzoxNjo0NTogc3BhcnNlOiBzcGFyc2U6
IGluY29ycmVjdCB0eXBlIGluIHJldHVybiBleHByZXNzaW9uDQo+IChkaWZmZXJlbnQgYmFzZSB0
eXBlcykgQEAgICAgIGV4cGVjdGVkIHJlc3RyaWN0ZWQgX193c3VtIEBAICAgICBnb3QgdW5zaWdu
ZWQgbG9uZyBsb25nIEBADQo+ID4gICAgYXJjaC94ODYvbGliL2NzdW0tcGFydGlhbF82NC5jOjE2
OjQ1OiBzcGFyc2U6ICAgICBleHBlY3RlZCByZXN0cmljdGVkIF9fd3N1bQ0KPiA+ICAgIGFyY2gv
eDg2L2xpYi9jc3VtLXBhcnRpYWxfNjQuYzoxNjo0NTogc3BhcnNlOiAgICAgZ290IHVuc2lnbmVk
IGxvbmcgbG9uZw0KPiA+ID4+IGFyY2gveDg2L2xpYi9jc3VtLXBhcnRpYWxfNjQuYzoxNjo0NTog
c3BhcnNlOiBzcGFyc2U6IGluY29ycmVjdCB0eXBlIGluIHJldHVybiBleHByZXNzaW9uDQo+IChk
aWZmZXJlbnQgYmFzZSB0eXBlcykgQEAgICAgIGV4cGVjdGVkIHJlc3RyaWN0ZWQgX193c3VtIEBA
ICAgICBnb3QgdW5zaWduZWQgbG9uZyBsb25nIEBADQo+ID4gICAgYXJjaC94ODYvbGliL2NzdW0t
cGFydGlhbF82NC5jOjE2OjQ1OiBzcGFyc2U6ICAgICBleHBlY3RlZCByZXN0cmljdGVkIF9fd3N1
bQ0KPiA+ICAgIGFyY2gveDg2L2xpYi9jc3VtLXBhcnRpYWxfNjQuYzoxNjo0NTogc3BhcnNlOiAg
ICAgZ290IHVuc2lnbmVkIGxvbmcgbG9uZw0KPiA+DQo+ID4gdmltICsxNiBhcmNoL3g4Ni9saWIv
Y3N1bS1wYXJ0aWFsXzY0LmMNCj4gPg0KPiA+ICAgICAxMw0KPiA+ICAgICAxNCAgc3RhdGljIGlu
bGluZSBfX3dzdW0gY3N1bV9maW5hbGl6ZV9zdW0odTY0IHRlbXA2NCkNCj4gPiAgICAgMTUgIHsN
Cj4gPiAgID4gMTYgICAgICAgICAgcmV0dXJuICh0ZW1wNjQgKyByb3I2NCh0ZW1wNjQsIDMyKSkg
Pj4gMzI7DQo+ID4gICAgIDE3ICB9DQo+ID4gICAgIDE4DQo+IA0KPiBKdXN0IG5lZWRzIGEgYChf
X3dzdW0pYCBjYXN0LiBTaG91bGQgSSBwb3N0IGEgbmV3IHBhdGNoPw0KDQpJdCdsbCBuZWVkIHRv
IGJlIGEgKF9fZm9yY2UgX193c3VtKSBjYXN0Lg0KDQpJIHRoaW5rIG5ldyBwYXRjaGVzIGFyZSBl
eHBlY3RlZC4uLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBC
cmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdp
c3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

