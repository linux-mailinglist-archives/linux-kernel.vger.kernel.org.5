Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C8379FEBE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbjINIrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbjINIrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:47:10 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A9BDE91
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:47:05 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-236-xJwBvLsLMwuuTmppwXLEdw-1; Thu, 14 Sep 2023 09:46:57 +0100
X-MC-Unique: xJwBvLsLMwuuTmppwXLEdw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 14 Sep
 2023 09:46:54 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 14 Sep 2023 09:46:54 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Geert Uytterhoeven' <geert@linux-m68k.org>,
        Evan Green <evan@rivosinc.com>
CC:     Palmer Dabbelt <palmer@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Sia Jee Heng" <jeeheng.sia@starfivetech.com>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Simon Hosie <shosie@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Alexandre Ghiti" <alexghiti@rivosinc.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <apatel@ventanamicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Andy Chiu" <andy.chiu@sifive.com>
Subject: RE: [PATCH v4 1/2] RISC-V: Probe for unaligned access speed
Thread-Topic: [PATCH v4 1/2] RISC-V: Probe for unaligned access speed
Thread-Index: AQHZ5t2uDoI3R+Ee30ay/cEMVFilT7AaADQQ
Date:   Thu, 14 Sep 2023 08:46:54 +0000
Message-ID: <de95229a14614198894a8ce421c30d94@AcuMS.aculab.com>
References: <20230818194136.4084400-1-evan@rivosinc.com>
 <20230818194136.4084400-2-evan@rivosinc.com>
 <CAMuHMdVtXGjP8VFMiv-7OMFz1XvfU1cz=Fw4jL3fcp4wO1etzQ@mail.gmail.com>
 <CALs-Hsvu7BsK8P0+xeuLmKEqg-q=kQANbf8FkiPGPhwhnSXpmA@mail.gmail.com>
 <CAMuHMdV594xA1UoTeVixpXm3i5LDFO5cT=dd_iRwWLwvxQctZg@mail.gmail.com>
In-Reply-To: <CAMuHMdV594xA1UoTeVixpXm3i5LDFO5cT=dd_iRwWLwvxQctZg@mail.gmail.com>
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

RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuDQo+IFNlbnQ6IDE0IFNlcHRlbWJlciAyMDIzIDA4OjMz
DQouLi4NCj4gPiA+ICAgICByemZpdmU6DQo+ID4gPiAgICAgICAgIGNwdTA6IFJhdGlvIG9mIGJ5
dGUgYWNjZXNzIHRpbWUgdG8gdW5hbGlnbmVkIHdvcmQgYWNjZXNzIGlzDQo+ID4gPiAxLjA1LCB1
bmFsaWduZWQgYWNjZXNzZXMgYXJlIGZhc3QNCj4gPg0KPiA+IEhybSwgSSdtIGEgbGl0dGxlIHN1
cnByaXNlZCB0byBiZSBzZWVpbmcgdGhpcyBudW1iZXIgY29tZSBvdXQgc28gY2xvc2UNCj4gPiB0
byAxLiBJZiB5b3UgcmVib290IGEgZmV3IHRpbWVzLCB3aGF0IGtpbmQgb2YgdmFyaWFuY2UgZG8g
eW91IGdldCBvbg0KPiA+IHRoaXM/DQo+IA0KPiBSb2NrLXNvbGlkIGF0IDEuMDUgKGV2ZW4gd2l0
aCBpbmNyZWFzZWQgcmVzb2x1dGlvbjogMS4wNTg1MyBvbiAzIHRyaWVzKQ0KDQpXb3VsZCB0aGF0
IG1hdGNoIHplcm8gb3ZlcmhlYWQgdW5sZXNzIHRoZSBhY2Nlc3MgY3Jvc3NlcyBhDQpjYWNoZSBs
aW5lIGJvdW5kYXJ5Pw0KKEkgY2FuJ3QgcmVtZW1iZXIgd2hldGhlciB0aGUgdGVzdCBpcyB1c2lu
ZyBpbmNyZWFzaW5nIGFkZHJlc3Nlcy4pDQoNCi4uLg0KPiA+ID4gICAgIHZleHJpc2N2L29yYW5n
ZWNyYWI6DQo+ID4gPg0KPiA+ID4gICAgICAgICBjcHUwOiBSYXRpbyBvZiBieXRlIGFjY2VzcyB0
aW1lIHRvIHVuYWxpZ25lZCB3b3JkIGFjY2VzcyBpcw0KPiA+ID4gMC4wMCwgdW5hbGlnbmVkIGFj
Y2Vzc2VzIGFyZSBzbG93DQo+IA0KPiBjcHUwOiBSYXRpbyBvZiBieXRlIGFjY2VzcyB0aW1lIHRv
IHVuYWxpZ25lZCB3b3JkIGFjY2VzcyBpcyAwLjAwNDE3LA0KPiB1bmFsaWduZWQgYWNjZXNzZXMg
YXJlIHNsb3cNCj4gDQo+ID4gPiBJIGFtIGEgYml0IHN1cnByaXNlZCBieSB0aGUgbmVhci16ZXJv
IHZhbHVlcy4gIEFyZSB0aGVzZSBleHBlY3RlZD8NCj4gPg0KPiA+IFRoaXMgY291bGQgYmUgZXhw
ZWN0ZWQsIGlmIGZpcm13YXJlIGlzIHRyYXBwaW5nIHRoZSB1bmFsaWduZWQgYWNjZXNzZXMNCj4g
PiBhbmQgY29taW5nIG91dCA+MTAweCBzbG93ZXIgdGhhbiBhIG5hdGl2ZSBhY2Nlc3MuIElmIHlv
dSdyZSBpbnRlcmVzdGVkDQo+ID4gaW4gZ2V0dGluZyBhIGxpdHRsZSBtb3JlIHJlc29sdXRpb24s
IHlvdSBjb3VsZCB0cnkgdG8gcHJpbnQgYSBmZXcgbW9yZQ0KPiA+IGRlY2ltYWwgcGxhY2VzIHdp
dGggc29tZXRoaW5nIGxpa2UgKHNvcnJ5IGdtYWlsIG1hbmdsZXMgdGhlIHdoaXRlc3BhY2UNCj4g
PiBvbiB0aGlzKToNCg0KSSdkIGV4cGVjdCBvbmUgb2YgdGhyZWUgcG9zc2libGUgdmFsdWVzOg0K
LSAxLjB4OiBCYXNpY2FsbHkgemVybyBjb3N0IGV4Y2VwdCBmb3IgY2FjaGUgbGluZS9wYWdlIGJv
dW5kYXJpZXMuDQotIH4yOiBIYXJkd2FyZSBkb2VzIHR3byByZWFkcyBhbmQgbWVyZ2VzIHRoZSB2
YWx1ZXMuDQotID4xMDA6IFRyYXAgZml4ZWQgdXAgaW4gc29mdHdhcmUuDQoNCkknZCB0aGluayB0
aGUgJzInIGNhc2UgY291bGQgYmUgY29uc2lkZXJlZCBmYXN0Lg0KWW91IG9ubHkgbmVlZCB0byB0
aW1lIG9uZSBhY2Nlc3MgdG8gc2VlIGlmIGl0IHdhcyBhIGZhdWx0Lg0KDQoJRGF2aWQNCg0KLQ0K
UmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1p
bHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVz
KQ0K

