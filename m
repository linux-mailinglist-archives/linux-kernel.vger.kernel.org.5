Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B447A595F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 07:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjISFbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 01:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjISFbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 01:31:41 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38BE130;
        Mon, 18 Sep 2023 22:31:32 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 2A9DF24E287;
        Tue, 19 Sep 2023 13:31:29 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 19 Sep
 2023 13:31:29 +0800
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 19 Sep
 2023 13:31:28 +0800
Received: from EXMBX168.cuchost.com ([fe80::1869:e641:8a12:96d6]) by
 EXMBX168.cuchost.com ([fe80::1869:e641:8a12:96d6%16]) with mapi id
 15.00.1497.044; Tue, 19 Sep 2023 13:31:28 +0800
From:   JiaJie Ho <jiajie.ho@starfivetech.com>
To:     Chris Hofstaedtler <chris@hofstaedtler.name>
CC:     "aurelien@aurel32.net" <aurelien@aurel32.net>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "davidlt@rivosinc.com" <davidlt@rivosinc.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: starfive crypto list_add corruption
Thread-Topic: starfive crypto list_add corruption
Thread-Index: AQHZ2yzjjWDz/x6w9kGlTSbBzWx+s7AEQLcAgAECsiCADtOfAIANpvYw
Date:   Tue, 19 Sep 2023 05:31:28 +0000
Message-ID: <50aa501b9aa64d3bad457f4625a17a45@EXMBX168.cuchost.com>
References: <292c90859f2e4135b40307d61488692c@EXMBX168.cuchost.com>
 <24laigwzjtx6scexj5otiesaolgytduhfp7ahqi7hvyhyc4fnv@vc2gqkxnp7v3>
In-Reply-To: <24laigwzjtx6scexj5otiesaolgytduhfp7ahqi7hvyhyc4fnv@vc2gqkxnp7v3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [202.188.176.82]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gSSBnb3QgdGhpcyBpc3N1ZSwgaWYgSSByZW1lbWJlciBjb3JyZWN0bHksIEkgZml4ZWQg
aXQgYnkgZW5hYmxpbmcNCj4gPiA+IENPTkZJR19BUk1fQU1CQSBhbmQgQ09ORklHX0FNQkFfUEww
OFguIEl0IGltcHJvdmVkIHRoaW5ncyBhIGJpdCwNCj4gDQo+IEkgc3RpbGwgc2VlIHRoZSBsaXN0
X2FkZCBjb3JydXB0aW9uIHRyYWNlIHdpdGggQ09ORklHX0FSTV9BTUJBIGFuZA0KPiBDT05GSUdf
QU1CQV9QTDA4WCBzZXQ6DQo+IA0KDQpbLi4uXQ0KIA0KPiBJIGFsc28gc2VlIHRoaXMgcGFuaWM6
DQo+IA0KPiBbICAgIDMuNTU4Mjk2XSBqaDcxMTAtY3J5cHRvIDE2MDAwMDAwLmNyeXB0bzogd2ls
bCBydW4gcmVxdWVzdHMgcHVtcCB3aXRoDQo+IHJlYWx0aW1lIHByaW9yaXR5DQo+IFsgICAgMy41
NjU5NjFdIGR3bW1jX3N0YXJmaXZlIDE2MDIwMDAwLm1tYzogVmVyc2lvbiBJRCBpcyAyOTBhDQo+
IFsgICAgMy41NjYwMTZdIGR3bW1jX3N0YXJmaXZlIDE2MDIwMDAwLm1tYzogRFcgTU1DIGNvbnRy
b2xsZXIgYXQgaXJxDQo+IDcwLDMyIGJpdCBob3N0IGRhdGEgd2lkdGgsMzIgZGVlcCBmaWZvDQo+
IFsgICAgMy41NzQzMjldIGNmZzgwMjExOiBMb2FkaW5nIGNvbXBpbGVkLWluIFguNTA5IGNlcnRp
ZmljYXRlcyBmb3IgcmVndWxhdG9yeQ0KPiBkYXRhYmFzZQ0KPiBbICAgIDMuNTc3NTg1XSBtbWNf
aG9zdCBtbWMxOiBjYXJkIGlzIHBvbGxpbmcuDQo+IFsgICAgMy42MDYzMjddIFVuYWJsZSB0byBo
YW5kbGUga2VybmVsIHBhZ2luZyByZXF1ZXN0IGF0IHZpcnR1YWwgYWRkcmVzcw0KPiBmZmZmZmZm
ZjgwMGZhYjI0DQo+IFsgICAgMy44MjA3NDhdIE9vcHMgWyMxXQ0KPiBbICAgIDMuODIzMDI3XSBN
b2R1bGVzIGxpbmtlZCBpbjoNCj4gWyAgICAzLjgyNjA5MF0gQ1BVOiAwIFBJRDogMSBDb21tOiBz
d2FwcGVyLzAgVGFpbnRlZDogRyAgICAgICAgVw0KPiA2LjUuMHplaGEzLTAwMDcyLWczODVlZGRm
NGU3OGYgIzYNCj4gWyAgICAzLjgzMjIyOV0gbW1jX2hvc3QgbW1jMTogQnVzIHNwZWVkIChzbG90
IDApID0gNDk1MDAwMDBIeiAoc2xvdCByZXENCj4gNDAwMDAwSHosIGFjdHVhbCAzOTkxOTNIWiBk
aXYgPSA2MikNCj4gWyAgICAzLjgzNTU2Nl0gSGFyZHdhcmUgbmFtZTogU3RhckZpdmUgVmlzaW9u
Rml2ZSAyIHYxLjJBIChEVCkNCj4gWyAgICAzLjg1MDU5NV0gZXBjIDogc3RhcmZpdmVfcnNhX2Vu
Y19jb3JlKzB4MzAvMHgxMTYNCj4gWyAgICAzLjg1NTQwMl0gIHJhIDogc3RhcmZpdmVfcnNhX2Vu
YysweDVlLzB4YmMNCj4gWyAgICAzLjg1OTY3OV0gZXBjIDogZmZmZmZmZmY4MDg2OTM3YSByYSA6
IGZmZmZmZmZmODA4Njk0YmUgc3AgOiBmZmZmZmZjODAwMDIzOTEwDQo+IFsgICAgMy44NjY4OThd
ICBncCA6IGZmZmZmZmZmODE3MjM5ODAgdHAgOiBmZmZmZmZkOGMwMTUwMDAwIHQwIDoNCj4gZmZm
ZmZmZDhjMjIzODBjOA0KPiBbICAgIDMuODc0MTE3XSAgdDEgOiAwMDAwMDAwMDAwMDAwMDAwIHQy
IDogNDcyZjkzNTFkMDdkZjcxMCBzMCA6DQo+IGZmZmZmZmM4MDAwMjM5NjANCj4gWyAgICAzLjg4
MTMzNV0gIHMxIDogZmZmZmZmZDhjMDEzZWE4MCBhMCA6IGZmZmZmZmQ4YzAxM2VhODAgYTEgOg0K
PiAwMDAwMDAwMDAwMDAwMDAxDQo+IFsgICAgMy44ODg1NTNdICBhMiA6IDAwMDAwMTAwMDAwMDAw
MDAgYTMgOiBmZmZmZmZkOGMwMTMzYzQwIGE0IDoNCj4gMDAwMDAwMDAwMDAwMDAwMg0KPiBbICAg
IDMuODk1NzcwXSAgYTUgOiBmZmZmZmZmZjgwMGZhYjI0IGE2IDogZmZmZmZmZDhmZjFkNmQ5MCBh
NyA6DQo+IDAwMDAwMDAwMDAwMDAwMDANCj4gWyAgICAzLjkwMjk4OF0gIHMyIDogZmZmZmZmZDhj
MDEzZWE0MCBzMyA6IGZmZmZmZmQ4YzIyMzgxODAgczQgOg0KPiAwMDAwMDAwMDAwMDAwMDAxDQo+
IFsgICAgMy45MTAyMDZdICBzNSA6IGZmZmZmZmQ4YzIyMzgwYjAgczYgOiBmZmZmZmZkOGMwMTMz
YzQwIHM3IDoNCj4gMDAwMDAwMDAwMDAwMDJhOA0KPiBbICAgIDMuOTE3NDI1XSAgczggOiBmZmZm
ZmZmZjgxMTRjMjQwIHM5IDogMDAwMDAwMDAxZjAzMDAwMCBzMTA6DQo+IDAwMDAwMDAwMDAwMDAw
MDENCj4gWyAgICAzLjkyNDY0Ml0gIHMxMTogZmZmZmZmZDhjMDA0ODMwMCB0MyA6IDBhMTI1NTg0
MGE0YjdkZjggdDQgOg0KPiAyOGZjMmYyYjFmM2I0ZTdkDQo+IFsgICAgMy45MzE4NjFdICB0NSA6
IGUyYmI4MDgwZTEzNDY5YjMgdDYgOiBmZmZmZmZkOGMyMjM4NDQwDQo+IFsgICAgMy45MzcxNzBd
IHN0YXR1czogMDAwMDAwMDIwMDAwMDEyMCBiYWRhZGRyOiBmZmZmZmZmZjgwMGZhYjI0IGNhdXNl
Og0KPiAwMDAwMDAwMDAwMDAwMDBmDQo+IFsgICAgMy45NDUwODNdIFs8ZmZmZmZmZmY4MDg2OTM3
YT5dIHN0YXJmaXZlX3JzYV9lbmNfY29yZSsweDMwLzB4MTE2DQo+IFsgICAgMy45NTExODNdIFs8
ZmZmZmZmZmY4MDg2OTRiZT5dIHN0YXJmaXZlX3JzYV9lbmMrMHg1ZS8weGJjDQo+IFsgICAgMy45
NTY3NjJdIFs8ZmZmZmZmZmY4MDQ1ZWRjND5dIHBrY3MxcGFkX3ZlcmlmeSsweGIyLzB4ZWENCj4g
WyAgICAzLjk2MjI1Nl0gWzxmZmZmZmZmZjgwNDVlMjFhPl0gY3J5cHRvX3NpZ192ZXJpZnkrMHhh
Mi8weGQwDQo+IFsgICAgMy45Njc5MTldIFs8ZmZmZmZmZmY4MDQ3ZThjMD5dIHB1YmxpY19rZXlf
dmVyaWZ5X3NpZ25hdHVyZSsweDE2OC8weDFkMg0KPiBbICAgIDMuOTc0NjI1XSBbPGZmZmZmZmZm
ODA0ODAwMTg+XSB4NTA5X2NoZWNrX2Zvcl9zZWxmX3NpZ25lZCsweDU4LzB4YTANCj4gWyAgICAz
Ljk4MTA3MV0gWzxmZmZmZmZmZjgwNDdmNDg2Pl0geDUwOV9jZXJ0X3BhcnNlKzB4MTQ4LzB4MTll
DQo+IFsgICAgMy45ODY3MzVdIFs8ZmZmZmZmZmY4MDQ3ZmQwOD5dIHg1MDlfa2V5X3ByZXBhcnNl
KzB4MjAvMHgxOGMNCj4gWyAgICAzLjk5MjQ4NV0gWzxmZmZmZmZmZjgwNDdkOGI0Pl0gYXN5bW1l
dHJpY19rZXlfcHJlcGFyc2UrMHg1Mi8weDg2DQo+IFsgICAgMy45OTg2NjhdIFs8ZmZmZmZmZmY4
MDQ0ZmNiOD5dIF9fa2V5X2NyZWF0ZV9vcl91cGRhdGUrMHgxNmMvMHgzNzINCj4gWyAgICA0LjAw
NDk0MV0gWzxmZmZmZmZmZjgwNDRmZWNjPl0ga2V5X2NyZWF0ZV9vcl91cGRhdGUrMHhlLzB4MTYN
Cj4gWyAgICA0LjAxMDc4MF0gWzxmZmZmZmZmZjgwNDdmYzc4Pl0geDUwOV9sb2FkX2NlcnRpZmlj
YXRlX2xpc3QrMHg4Ni8weGY2DQo+IFsgICAgNC4wMTcyMjZdIFs8ZmZmZmZmZmY4MGMzYTU5YT5d
IHJlZ3VsYXRvcnlfaW5pdF9kYisweDkyLzB4MTI0DQo+IFsgICAgNC4wMjMwNjhdIFs8ZmZmZmZm
ZmY4MDAwMjBmMD5dIGRvX29uZV9pbml0Y2FsbCsweDM4LzB4MTdjDQo+IFsgICAgNC4wMjg2NDZd
IFs8ZmZmZmZmZmY4MGMwMGYxYz5dIGtlcm5lbF9pbml0X2ZyZWVhYmxlKzB4MWEyLzB4MjA0DQo+
IFsgICAgNC4wMzQ3NDldIFs8ZmZmZmZmZmY4MGJiNGI1Nj5dIGtlcm5lbF9pbml0KzB4MWUvMHgx
MGENCj4gWyAgICA0LjAzOTk3OV0gWzxmZmZmZmZmZjgwMDAzMzZhPl0gcmV0X2Zyb21fZm9yaysw
eGEvMHgxYw0KPiBbICAgIDQuMDQ1MjE4XSBDb2RlOiAwMjA1IDg0YWEgOGEyZSAwMDBmIDAxNDAg
Mzc4MyAwMzBiIDQ3MDkgODc5MyA0MDA3DQo+IChjMzk4KSAyNzgzDQo+IFsgICAgNC4wNTI3MTVd
IC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KPiBbICAgIDQuMDU3MzM5XSBL
ZXJuZWwgcGFuaWMgLSBub3Qgc3luY2luZzogQXR0ZW1wdGVkIHRvIGtpbGwgaW5pdCENCj4gZXhp
dGNvZGU9MHgwMDAwMDAwYg0KPiBbICAgIDQuMDY0OTkwXSBTTVA6IHN0b3BwaW5nIHNlY29uZGFy
eSBDUFVzDQo+IFsgICAgNC4wNjg5MjddIC0tLVsgZW5kIEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5j
aW5nOiBBdHRlbXB0ZWQgdG8ga2lsbCBpbml0IQ0KPiBleGl0Y29kZT0weDAwMDAwMDBiIF0tLS0N
Cj4gDQo+IE1heWJlIHRoaXMgY2FuIGFsc28gYmUgaW52ZXN0aWdhdGVkLg0KDQpJcyB0aGVyZSBh
IGd1aWRlL3dpa2kgdG8gY29tcGlsZSBhIGZlZG9yYS1yaXNjdiBpbWFnZSBmb3IgVkYyIGJvYXJk
Pw0KSSdsbCB3aWxsIHRyeSByZXByb2R1Y2luZyBhbmQgZml4IHRoZXNlIGlzc3VlcyBvbiBteSBz
aWRlLg0KDQpUaGFua3MNCkppYSBKaWUNCg==
