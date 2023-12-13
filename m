Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D41881090F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 05:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378492AbjLMEUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 23:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbjLMEUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 23:20:07 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72260AC;
        Tue, 12 Dec 2023 20:20:10 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 383478016;
        Wed, 13 Dec 2023 12:20:02 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 13 Dec
 2023 12:20:02 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 13 Dec
 2023 12:20:01 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Wed, 13 Dec 2023 12:20:01 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        "conor@kernel.org" <conor@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "Hal Feng" <hal.feng@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>
Subject: RE: [PATCH v1 06/16] clk: starfive: Add JH8100 System clock generator
 driver
Thread-Topic: [PATCH v1 06/16] clk: starfive: Add JH8100 System clock
 generator driver
Thread-Index: AQHaKDp8qa+gHWDJHkGDh0MGWRuwVrCfD58AgAd/fYA=
Date:   Wed, 13 Dec 2023 04:20:01 +0000
Message-ID: <a554a163793e4513b25766c21ddc3f02@EXMBX066.cuchost.com>
References: <20231206115000.295825-1-jeeheng.sia@starfivetech.com>
 <20231206115000.295825-7-jeeheng.sia@starfivetech.com>
 <CAJM55Z_VgBGvCPuvwmQahMcMfuWKnOKpZ9bBbbhei_Teu5Apeg@mail.gmail.com>
In-Reply-To: <CAJM55Z_VgBGvCPuvwmQahMcMfuWKnOKpZ9bBbbhei_Teu5Apeg@mail.gmail.com>
Accept-Language: en-US, zh-CN
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRW1pbCBSZW5uZXIgQmVy
dGhpbmcgPGVtaWwucmVubmVyLmJlcnRoaW5nQGNhbm9uaWNhbC5jb20+DQo+IFNlbnQ6IFNhdHVy
ZGF5LCBEZWNlbWJlciA5LCAyMDIzIDEyOjI1IEFNDQo+IFRvOiBKZWVIZW5nIFNpYSA8amVlaGVu
Zy5zaWFAc3RhcmZpdmV0ZWNoLmNvbT47IGtlcm5lbEBlc21pbC5kazsgY29ub3JAa2VybmVsLm9y
Zzsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5v
cmc7IHBhdWwud2FsbXNsZXlAc2lmaXZlLmNvbTsgcGFsbWVyQGRhYmJlbHQuY29tOyBhb3VAZWVj
cy5iZXJrZWxleS5lZHU7DQo+IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOyBzYm95ZEBrZXJuZWwu
b3JnOyBwLnphYmVsQHBlbmd1dHJvbml4LmRlOyBlbWlsLnJlbm5lci5iZXJ0aGluZ0BjYW5vbmlj
YWwuY29tOyBIYWwgRmVuZw0KPiA8aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT47IFhpbmd5dSBX
dSA8eGluZ3l1Lnd1QHN0YXJmaXZldGVjaC5jb20+DQo+IENjOiBsaW51eC1yaXNjdkBsaXN0cy5p
bmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsgTGV5Zm9vbiBUYW4NCj4g
PGxleWZvb24udGFuQHN0YXJmaXZldGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEg
MDYvMTZdIGNsazogc3RhcmZpdmU6IEFkZCBKSDgxMDAgU3lzdGVtIGNsb2NrIGdlbmVyYXRvciBk
cml2ZXINCj4gDQo+IFNpYSBKZWUgSGVuZyB3cm90ZToNCj4gPiBBZGQgc3VwcG9ydCBmb3IgSkg4
MTAwIFN5c3RlbSBjbG9jayBnZW5lcmF0b3IuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaWEg
SmVlIEhlbmcgPGplZWhlbmcuc2lhQHN0YXJmaXZldGVjaC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6
IExleSBGb29uIFRhbiA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiAtLS0NCj4g
PiAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA4ICsN
Cj4gPiAgZHJpdmVycy9jbGsvc3RhcmZpdmUvS2NvbmZpZyAgICAgICAgICAgICAgICAgIHwgICA5
ICsNCj4gPiAgZHJpdmVycy9jbGsvc3RhcmZpdmUvTWFrZWZpbGUgICAgICAgICAgICAgICAgIHwg
ICAxICsNCj4gPiAgZHJpdmVycy9jbGsvc3RhcmZpdmUvY2xrLXN0YXJmaXZlLWNvbW1vbi5oICAg
IHwgICA5ICstDQo+ID4gIGRyaXZlcnMvY2xrL3N0YXJmaXZlL2poODEwMC9NYWtlZmlsZSAgICAg
ICAgICB8ICAgMyArDQo+ID4gIC4uLi9jbGsvc3RhcmZpdmUvamg4MTAwL2Nsay1zdGFyZml2ZS1q
aDgxMDAuaCB8ICAxMSArDQo+ID4gIGRyaXZlcnMvY2xrL3N0YXJmaXZlL2poODEwMC9jbGstc3lz
LmMgICAgICAgICB8IDQ1NSArKysrKysrKysrKysrKysrKysNCj4gPiAgNyBmaWxlcyBjaGFuZ2Vk
LCA0OTUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9jbGsvc3RhcmZpdmUvamg4MTAwL01ha2VmaWxlDQo+ID4gIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBkcml2ZXJzL2Nsay9zdGFyZml2ZS9qaDgxMDAvY2xrLXN0YXJmaXZlLWpoODEwMC5o
DQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2Nsay9zdGFyZml2ZS9qaDgxMDAvY2xr
LXN5cy5jDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0K
PiA+IGluZGV4IDc4OGJlOWFiNWI3My4uODdiY2IyNWJlY2MxIDEwMDY0NA0KPiA+IC0tLSBhL01B
SU5UQUlORVJTDQo+ID4gKysrIGIvTUFJTlRBSU5FUlMNCj4gPiBAQCAtMjA3NjMsNiArMjA3NjMs
MTQgQEAgRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9zdGFyZml2ZSxq
aDcxMTAtdXNiLXBoeS55YW1sDQo+ID4gIEY6CWRyaXZlcnMvcGh5L3N0YXJmaXZlL3BoeS1qaDcx
MTAtcGNpZS5jDQo+ID4gIEY6CWRyaXZlcnMvcGh5L3N0YXJmaXZlL3BoeS1qaDcxMTAtdXNiLmMN
Cj4gPg0KPiA+ICtTVEFSRklWRSBKSDgxMDAgQ0xPQ0sgRFJJVkVSUw0KPiA+ICtNOglTaWEgSmVl
IEhlbmcgPGplZWhlbmcuc2lhQHN0YXJmaXZldGVjaC5jb20+DQo+ID4gK006CUxleSBGb29uIFRh
biA8bGV5Zm9vbi50YW5Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiArUzoJTWFpbnRhaW5lZA0KPiA+
ICtGOglEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svc3RhcmZpdmUsamg4
MSoueWFtbA0KPiA+ICtGOglkcml2ZXJzL2Nsay9zdGFyZml2ZS9qaDgxMDANCj4gPiArRjoJaW5j
bHVkZS9kdC1iaW5kaW5ncy9jbG9jay9zdGFyZml2ZT9qaDgxKi5oDQo+ID4gKw0KPiA+ICBTVEFU
SUMgQlJBTkNIL0NBTEwNCj4gPiAgTToJUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQu
b3JnPg0KPiA+ICBNOglKb3NoIFBvaW1ib2V1ZiA8anBvaW1ib2VAa2VybmVsLm9yZz4NCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvc3RhcmZpdmUvS2NvbmZpZyBiL2RyaXZlcnMvY2xrL3N0
YXJmaXZlL0tjb25maWcNCj4gPiBpbmRleCBmZjhlYWNlMzZlNjQuLmQ4YzdiOWJiMzg5NSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Nsay9zdGFyZml2ZS9LY29uZmlnDQo+ID4gKysrIGIvZHJp
dmVycy9jbGsvc3RhcmZpdmUvS2NvbmZpZw0KPiA+IEBAIC03MiwzICs3MiwxMiBAQCBjb25maWcg
Q0xLX1NUQVJGSVZFX0pINzExMF9WT1VUDQo+ID4gIAloZWxwDQo+ID4gIAkgIFNheSB5ZXMgaGVy
ZSB0byBzdXBwb3J0IHRoZSBWaWRlby1PdXRwdXQgY2xvY2sgY29udHJvbGxlcg0KPiA+ICAJICBv
biB0aGUgU3RhckZpdmUgSkg3MTEwIFNvQy4NClsuLi5dDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvY2xrL3N0YXJmaXZlL2poODEwMC9NYWtlZmlsZSBiL2RyaXZlcnMvY2xrL3N0YXJmaXZlL2po
ODEwMC9NYWtlZmlsZQ0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAw
MDAwMDAwLi5hZjZhMDllMjIwZDMNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvZHJpdmVy
cy9jbGsvc3RhcmZpdmUvamg4MTAwL01ha2VmaWxlDQo+ID4gQEAgLTAsMCArMSwzIEBADQo+ID4g
KyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPiArIyBTdGFyRml2ZSBKSDgx
MDAgQ2xvY2sNCj4gPiArb2JqLSQoQ09ORklHX0NMS19TVEFSRklWRV9KSDgxMDBfU1lTKQkJKz0g
Y2xrLXN5cy5vDQo+IA0KPiBUaGlzIHdpbGwgbmFtZSB0aGUgbW9kdWxlIGNsay1zeXMsIHdoaWNo
IGlzIHdheSB0b28gZ2VuZXJpYy4gUGxlYXNlIG5hbWUgdGhpcw0KPiBjbGstc3RhcmZpdmUtamg4
MTAwLXN5cyBzaW1pbGFyIHRvIHRoZSBKSDcxMTAgZHJpdmVycy4NCkp1c3QgcmVhbGl6ZWQgdGhh
dCBJIGhhdmVuJ3QgcmVwbHkgdG8gdGhpcyBjb21tZW50Lg0KSSBjYW4ndCBnaXZlIGl0IGEgbG9u
Z2VyIG5hbWUgb3RoZXJ3aXNlIGNvbXBpbGVyIHdpbGwgdGhyb3cgd2FybmluZy4NClRoYXTigJlz
IHdoeSBlbmRzIHVwIHRvIHVzZSBhIHNob3J0ZXIgbmFtZSBhbmQga2VlcCBpdCB1bmRlciBqaDgx
MDAgZm9sZGVyLg0KPiANClsuLi5dDQo=
