Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13A27A5C83
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjISI2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjISI23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:28:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4D512E;
        Tue, 19 Sep 2023 01:28:18 -0700 (PDT)
Received: from lhrpeml100006.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RqZS00nD3z6D9BD;
        Tue, 19 Sep 2023 16:23:28 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml100006.china.huawei.com (7.191.160.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 19 Sep 2023 09:28:15 +0100
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.031;
 Tue, 19 Sep 2023 09:28:15 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     Jiaqi Yan <jiaqiyan@google.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "jthoughton@google.com" <jthoughton@google.com>,
        "somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
        "erdemaktas@google.com" <erdemaktas@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "duenwen@google.com" <duenwen@google.com>,
        "Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>,
        "mike.malvestuto@intel.com" <mike.malvestuto@intel.com>,
        "gthelen@google.com" <gthelen@google.com>,
        Linuxarm <linuxarm@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "rric@kernel.org" <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: RE: [RFC PATCH 0/9] ACPI:RASF: Add support for ACPI RASF, ACPI RAS2
 and configure scrubbers
Thread-Topic: [RFC PATCH 0/9] ACPI:RASF: Add support for ACPI RASF, ACPI RAS2
 and configure scrubbers
Thread-Index: AQHZ5/oe1pAvyQNvtUqNE6jH1WS6cbAfdxAAgADQwZCAAIfAAIABBNeA
Date:   Tue, 19 Sep 2023 08:28:15 +0000
Message-ID: <efc626c3c01f4b44a715f4695682454a@huawei.com>
References: <20230915172818.761-1-shiju.jose@huawei.com>
        <CACw3F50Edbk7uemvS-ZCNABKSz=3VMaRdPjzoYp9XE-hkOUKBg@mail.gmail.com>
        <e8a20cf946354312b865c1d69a18a81c@huawei.com>
 <CACw3F51eSVKybNWKvf_YULfQPhuQWZRDKvP23oOJo=HeNBgGCA@mail.gmail.com>
In-Reply-To: <CACw3F51eSVKybNWKvf_YULfQPhuQWZRDKvP23oOJo=HeNBgGCA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.173.32]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSmlhcWkgWWFuIDxqaWFxaXlhbkBn
b29nbGUuY29tPg0KPlNlbnQ6IDE4IFNlcHRlbWJlciAyMDIzIDE4OjQ3DQo+VG86IFNoaWp1IEpv
c2UgPHNoaWp1Lmpvc2VAaHVhd2VpLmNvbT4NCj5DYzogbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsgbGludXgtDQo+a2VybmVsQHZnZXIua2VybmVsLm9yZzsg
cmFmYWVsQGtlcm5lbC5vcmc7IGxlbmJAa2VybmVsLm9yZzsNCj5uYW95YS5ob3JpZ3VjaGlAbmVj
LmNvbTsgdG9ueS5sdWNrQGludGVsLmNvbTsgamFtZXMubW9yc2VAYXJtLmNvbTsNCj5kYXZlLmhh
bnNlbkBsaW51eC5pbnRlbC5jb207IGRhdmlkQHJlZGhhdC5jb207IGp0aG91Z2h0b25AZ29vZ2xl
LmNvbTsNCj5zb21hc3VuZGFyYW0uYUBocGUuY29tOyBlcmRlbWFrdGFzQGdvb2dsZS5jb207IHBn
b25kYUBnb29nbGUuY29tOw0KPnJpZW50amVzQGdvb2dsZS5jb207IGR1ZW53ZW5AZ29vZ2xlLmNv
bTsgVmlsYXMuU3JpZGhhcmFuQGFtZC5jb207DQo+bWlrZS5tYWx2ZXN0dXRvQGludGVsLmNvbTsg
Z3RoZWxlbkBnb29nbGUuY29tOyBMaW51eGFybQ0KPjxsaW51eGFybUBodWF3ZWkuY29tPjsgSm9u
YXRoYW4gQ2FtZXJvbg0KPjxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyB0YW54aWFvZmVp
IDx0YW54aWFvZmVpQGh1YXdlaS5jb20+Ow0KPlplbmd0YW8gKEIpIDxwcmltZS56ZW5nQGhpc2ls
aWNvbi5jb20+OyBicEBhbGllbjguZGU7IG1jaGVoYWJAa2VybmVsLm9yZzsNCj5ycmljQGtlcm5l
bC5vcmc7IGxpbnV4LWVkYWNAdmdlci5rZXJuZWwub3JnDQo+U3ViamVjdDogUmU6IFtSRkMgUEFU
Q0ggMC85XSBBQ1BJOlJBU0Y6IEFkZCBzdXBwb3J0IGZvciBBQ1BJIFJBU0YsIEFDUEkgUkFTMg0K
PmFuZCBjb25maWd1cmUgc2NydWJiZXJzDQo+DQo+T24gTW9uLCBTZXAgMTgsIDIwMjMgYXQgMzoy
MOKAr0FNIFNoaWp1IEpvc2UgPHNoaWp1Lmpvc2VAaHVhd2VpLmNvbT4gd3JvdGU6DQo+Pg0KPj4g
WytjYyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZ10NCj4+DQo+PiBIZWxsbywNCj4+DQo+PiA+
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+ID5Gcm9tOiBKaWFxaSBZYW4gPGppYXFpeWFu
QGdvb2dsZS5jb20+DQo+PiA+U2VudDogMTcgU2VwdGVtYmVyIDIwMjMgMjI6MTQNCj4+ID5Ubzog
U2hpanUgSm9zZSA8c2hpanUuam9zZUBodWF3ZWkuY29tPg0KPj4gPkNjOiBsaW51eC1hY3BpQHZn
ZXIua2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBsaW51eC0NCj4+ID5rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyByYWZhZWxAa2VybmVsLm9yZzsgbGVuYkBrZXJuZWwub3JnOw0KPj4gPm5h
b3lhLmhvcmlndWNoaUBuZWMuY29tOyB0b255Lmx1Y2tAaW50ZWwuY29tOyBqYW1lcy5tb3JzZUBh
cm0uY29tOw0KPj4gPmRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbTsgZGF2aWRAcmVkaGF0LmNv
bTsganRob3VnaHRvbkBnb29nbGUuY29tOw0KPj4gPnNvbWFzdW5kYXJhbS5hQGhwZS5jb207IGVy
ZGVtYWt0YXNAZ29vZ2xlLmNvbTsNCj5wZ29uZGFAZ29vZ2xlLmNvbTsNCj4+ID5yaWVudGplc0Bn
b29nbGUuY29tOyBkdWVud2VuQGdvb2dsZS5jb207IFZpbGFzLlNyaWRoYXJhbkBhbWQuY29tOw0K
Pj4gPm1pa2UubWFsdmVzdHV0b0BpbnRlbC5jb207IGd0aGVsZW5AZ29vZ2xlLmNvbTsgTGludXhh
cm0NCj4+ID48bGludXhhcm1AaHVhd2VpLmNvbT47IEpvbmF0aGFuIENhbWVyb24NCj4+ID48am9u
YXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgdGFueGlhb2ZlaSA8dGFueGlhb2ZlaUBodWF3ZWku
Y29tPjsNCj4+ID5aZW5ndGFvIChCKSA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPg0KPj4gPlN1
YmplY3Q6IFJlOiBbUkZDIFBBVENIIDAvOV0gQUNQSTpSQVNGOiBBZGQgc3VwcG9ydCBmb3IgQUNQ
SSBSQVNGLA0KPj4gPkFDUEkgUkFTMiBhbmQgY29uZmlndXJlIHNjcnViYmVycw0KPj4gPg0KPj4g
Pk9uIEZyaSwgU2VwIDE1LCAyMDIzIGF0IDEwOjI54oCvQU0gPHNoaWp1Lmpvc2VAaHVhd2VpLmNv
bT4gd3JvdGU6DQo+PiA+Pg0KPj4gPj4gRnJvbTogU2hpanUgSm9zZSA8c2hpanUuam9zZUBodWF3
ZWkuY29tPg0KPj4gPj4NCj4+ID4+IFRoaXMgc2VyaWVzIGFkZCwNCj4+ID4+IDEuIHN1cHBvcnQg
Zm9yIEFDUEkgUkFTRihSQVMgZmVhdHVyZSB0YWJsZSkgUENDIGludGVyZmFjZXMgdG8NCj4+ID4+
IGNvbW11bmljYXRlIHdpdGggdGhlIEhXIHBhdHJvbCBzY3J1YmJlciBpbiB0aGUgcGxhdGZvcm0s
IGFzIHBlcg0KPj4gPj4gQUNQSQ0KPj4gPj4gNS4xICYgdXB3YXJkcyByZXZpc2lvbi4gU2VjdGlv
biA1LjIuMjAuDQo+PiA+Pg0KPj4gPj4gMi4gc3VwcG9ydCBmb3IgQUNQSSBSQVMyKFJBUzIgZmVh
dHVyZSB0YWJsZSksIGFzIHBlciBBQ1BJIDYuNSAmDQo+PiA+PiB1cHdhcmRzIHJldmlzaW9uLiBT
ZWN0aW9uIDUuMi4yMS4NCj4+ID4+DQo+PiA+PiAzLiBzY3J1YiBkcml2ZXIgc3VwcG9ydHMgY29u
ZmlndXJpbmcgcGFyYW1ldGVycyBvZiB0aGUgbWVtb3J5DQo+PiA+PiBzY3J1YmJlcnMgaW4gdGhl
IHN5c3RlbS4gVGhpcyBkcml2ZXIgaGFzIGJlZW4gaW1wbGVtZW50ZWQgYmFzZWQgb24NCj4+ID4+
IHRoZSBod21vbiBzdWJzeXN0ZW0uDQo+PiA+Pg0KPj4gPj4gVGhlIGZlYXR1cmVzIGhhdmUgdGVz
dGVkIHdpdGggUkFTRiBhbmQgUkFTMiBlbXVsYXRpb24gaW4gdGhlIFFFTVUuDQo+PiA+DQo+PiA+
SSBhbSB2ZXJ5IGN1cmlvdXMgaG93IHRoZSB0ZXN0IGlzIGRvbmUuIERvZXMgdGhlIGh3IHBhdHJv
bCBzY3J1YmJlcg0KPj4gPm9uIGhvc3QgYWN0dWFsbHkgYmVlbiBkcml2ZW4gYnkgdGhlIGRyaXZl
ciB0byBzY3J1YiBtZW1vcnkgRElNTXMNCj4+ID4oZG9lc24ndCBzZWVtIHNvIHRvIG1lLCBidXQg
ZG8gY29ycmVjdCBtZSk/IE9yIGl0IGlzIGxpa2UgdG8gYSBWTQ0KPj4gPnNjcnViYmluZyBpcyBz
aW11bGF0ZWQgYW5kIG5vIHJlYWwgb3AgdG8gRElNTXM/DQo+PiBJbnRlbnQgaGVyZSBpcyBoYXJk
d2FyZSBzY3J1YmJlciBvbiBob3N0IGFzIGZhciBhcyB3ZSBhcmUgY29uY2VybmVkLg0KPg0KPlNv
cnJ5IG1heWJlIG15IHF1ZXN0aW9uIHdhcyBub3QgY2xlYXIsIHNvIGxldCBtZSB0cnkgYWdhaW4u
DQo+DQo+RG9lcyB0aGUgZHJpdmVyIGJlaW5nIHRlc3RlZCBvbiBhIG1hY2hpbmUgYW5kIGRpcmVj
dGx5IG9yIGluZGlyZWN0bHkgY29udHJvbA0KPihzdGFydC9zdG9wKSBoYXJkd2FyZSBwYXRyb2wg
c2NydWJiZXIgdG8gc2NydWIgcGh5c2ljYWwgbWVtb3J5PyB3aGF0IGFyZSB0aGUNCj5DUFUgY2hp
cCwgbWVtb3J5IGNvbnRyb2xsZXIsIGFuZCBESU1NIGNoaXBzPw0KVGhlIGRyaXZlciBoYXMgYmVl
biB0ZXN0ZWQgd2l0aCBxZW11X3N5c3RlbV9hYXJjaDY0IHdpdGggc3RhdGUgbWFjaGluZSB0byBl
bXVsYXRlDQp0aGUgUkFTRiBhbmQgUkFTMiB0YWJsZXMgc3VwcG9ydCBmb3IgY29uZmlndXJpbmcg
cGFyYW1ldGVycyBvZiBhIHBhdHJvbCBzY3J1YmJlci4NClRodXMgbm8gcmVhbCBIVyBwYXRyb2wg
c2NydWJiZXIgYW5kIERJTU0gaW52b2x2ZWQgaW4gdGhlIHRlc3RpbmcuDQoNCj4NCj4+IENvdWxk
IGJlIHVzZWQgZm9yIFZNIHRvbyBwZXJoYXBzLiBXZSBkaWQgaXQgd2l0aCBRRU1VIGVtdWxhdGlv
biBmb3INCj4+IG5vdyAgdG8gZ2V0IHRoZSBmbGV4aWJpbGl0eSBvZiBjb25maWd1cmF0aW9uLiBI
b3dldmVyIHRoZXJlIHdpbGwgYmUNCj4+IG90aGVyIHNjcnViIGNvbnRyb2xzIG92ZXIgdGltZSwg
c3VjaCBhcyBERFI1IEVDUy4NCj4+IGh0dHBzOi8vbWVkaWEtd3d3Lm1pY3Jvbi5jb20vLS9tZWRp
YS9jbGllbnQvZ2xvYmFsL2RvY3VtZW50cy9wcm9kdWN0cy8NCj4+IHdoaXRlLQ0KPnBhcGVyL2Rk
cjVfbmV3X2ZlYXR1cmVzX3doaXRlX3BhcGVyLnBkZj9yZXY9Yjk4ZjQ5NzdkOTMzNGI0YWE1ZDAN
Cj4+IGQyMTFhOTJiZjE0YQ0KPj4NCj4+IEFsc28gZm91bmQgdGhlcmUgaXMgdmVyeSBzaW1wbGUg
c3VwcG9ydCBmb3Igc2NydWIgY29udHJvbCBpbiBlZGFjLCBhbmQNCg0KVGhhbmtzLA0KU2hpanUN
Cg==
