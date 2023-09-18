Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40007A4C48
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjIRPaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjIRP3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:29:39 -0400
Received: from frasgout.his.huawei.com (unknown [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C819CCE9;
        Mon, 18 Sep 2023 08:26:40 -0700 (PDT)
Received: from lhrpeml500002.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rq7LC1Qt4z67fBs;
        Mon, 18 Sep 2023 23:01:55 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500002.china.huawei.com (7.191.160.78) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 18 Sep 2023 16:03:52 +0100
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.031;
 Mon, 18 Sep 2023 16:03:52 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     David Hildenbrand <david@redhat.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "jiaqiyan@google.com" <jiaqiyan@google.com>,
        "jthoughton@google.com" <jthoughton@google.com>,
        "somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
        "erdemaktas@google.com" <erdemaktas@google.com>,
        "pgonda@google.com" <pgonda@google.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "duenwen@google.com" <duenwen@google.com>,
        "Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>,
        "mike.malvestuto@intel.com" <mike.malvestuto@intel.com>,
        "gthelen@google.com" <gthelen@google.com>,
        tanxiaofei <tanxiaofei@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: RE: [RFC PATCH 3/9] Documentation/scrub-configure.rst: Add
 documentation for scrub driver
Thread-Topic: [RFC PATCH 3/9] Documentation/scrub-configure.rst: Add
 documentation for scrub driver
Thread-Index: AQHZ5/ogEycepSDhbUOm98pdzG2eC7AgIWsAgAAq9pCAACaMgIAAA76AgAABnYCAADN9QA==
Date:   Mon, 18 Sep 2023 15:03:52 +0000
Message-ID: <a5443c2ddf8246d987c4b9a70ba6239a@huawei.com>
References: <20230915172818.761-1-shiju.jose@huawei.com>
 <20230915172818.761-4-shiju.jose@huawei.com>
 <887344ee-068d-f78f-d5f8-e816b966d875@redhat.com>
 <946f29d2370c41deb7a7c5a6f2bff0f3@huawei.com>
 <7282d074-15ba-4fe7-bf62-6a4dd6089817@redhat.com>
 <20230918132835.000031b7@huawei.com>
 <930acbe1-942f-d10f-f33e-020693b60d6e@redhat.com>
In-Reply-To: <930acbe1-942f-d10f-f33e-020693b60d6e@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.156.14]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IERhdmlkIEhpbGRlbmJyYW5k
IDxkYXZpZEByZWRoYXQuY29tPg0KPlNlbnQ6IDE4IFNlcHRlbWJlciAyMDIzIDEzOjM1DQo+VG86
IEpvbmF0aGFuIENhbWVyb24gPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNvbT47IExpbnV4YXJt
DQo+PGxpbnV4YXJtQGh1YXdlaS5jb20+DQo+Q2M6IFNoaWp1IEpvc2UgPHNoaWp1Lmpvc2VAaHVh
d2VpLmNvbT47IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj5tbUBrdmFjay5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHJhZmFlbEBrZXJuZWwub3JnOw0KPmxl
bmJAa2VybmVsLm9yZzsgbmFveWEuaG9yaWd1Y2hpQG5lYy5jb207IHRvbnkubHVja0BpbnRlbC5j
b207DQo+amFtZXMubW9yc2VAYXJtLmNvbTsgZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tOyBq
aWFxaXlhbkBnb29nbGUuY29tOw0KPmp0aG91Z2h0b25AZ29vZ2xlLmNvbTsgc29tYXN1bmRhcmFt
LmFAaHBlLmNvbTsNCj5lcmRlbWFrdGFzQGdvb2dsZS5jb207IHBnb25kYUBnb29nbGUuY29tOyBy
aWVudGplc0Bnb29nbGUuY29tOw0KPmR1ZW53ZW5AZ29vZ2xlLmNvbTsgVmlsYXMuU3JpZGhhcmFu
QGFtZC5jb207IG1pa2UubWFsdmVzdHV0b0BpbnRlbC5jb207DQo+Z3RoZWxlbkBnb29nbGUuY29t
OyB0YW54aWFvZmVpIDx0YW54aWFvZmVpQGh1YXdlaS5jb20+OyBaZW5ndGFvIChCKQ0KPjxwcmlt
ZS56ZW5nQGhpc2lsaWNvbi5jb20+DQo+U3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMy85XSBEb2N1
bWVudGF0aW9uL3NjcnViLWNvbmZpZ3VyZS5yc3Q6IEFkZA0KPmRvY3VtZW50YXRpb24gZm9yIHNj
cnViIGRyaXZlcg0KPg0KPk9uIDE4LjA5LjIzIDE0OjI4LCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPj4gT24gTW9uLCAxOCBTZXAgMjAyMyAxNDoxNTozMyArMDIwMA0KPj4gRGF2aWQgSGlsZGVu
YnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4NCj4+PiBPbiAxOC4wOS4yMyAxMjoy
NSwgU2hpanUgSm9zZSB3cm90ZToNCj4+Pj4gSGkgRGF2aWQsDQo+Pj4+DQo+Pj4+IFRoYW5rcyBm
b3IgbG9va2luZyBpbnRvIHRoaXMuDQo+Pj4+DQo+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KPj4+Pj4gRnJvbTogRGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+
Pj4+PiBTZW50OiAxOCBTZXB0ZW1iZXIgMjAyMyAwODoyNA0KPj4+Pj4gVG86IFNoaWp1IEpvc2Ug
PHNoaWp1Lmpvc2VAaHVhd2VpLmNvbT47IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOw0KPj4+
Pj4gbGludXgtIG1tQGt2YWNrLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPj4+
Pj4gQ2M6IHJhZmFlbEBrZXJuZWwub3JnOyBsZW5iQGtlcm5lbC5vcmc7IG5hb3lhLmhvcmlndWNo
aUBuZWMuY29tOw0KPj4+Pj4gdG9ueS5sdWNrQGludGVsLmNvbTsgamFtZXMubW9yc2VAYXJtLmNv
bTsNCj4+Pj4+IGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbTsgamlhcWl5YW5AZ29vZ2xlLmNv
bTsNCj4+Pj4+IGp0aG91Z2h0b25AZ29vZ2xlLmNvbTsgc29tYXN1bmRhcmFtLmFAaHBlLmNvbTsN
Cj4+Pj4+IGVyZGVtYWt0YXNAZ29vZ2xlLmNvbTsgcGdvbmRhQGdvb2dsZS5jb207IHJpZW50amVz
QGdvb2dsZS5jb207DQo+Pj4+PiBkdWVud2VuQGdvb2dsZS5jb207IFZpbGFzLlNyaWRoYXJhbkBh
bWQuY29tOw0KPj4+Pj4gbWlrZS5tYWx2ZXN0dXRvQGludGVsLmNvbTsgZ3RoZWxlbkBnb29nbGUu
Y29tOyBMaW51eGFybQ0KPj4+Pj4gPGxpbnV4YXJtQGh1YXdlaS5jb20+OyBKb25hdGhhbiBDYW1l
cm9uDQo+Pj4+PiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgdGFueGlhb2ZlaSA8dGFu
eGlhb2ZlaUBodWF3ZWkuY29tPjsNCj4+Pj4+IFplbmd0YW8gKEIpIDxwcmltZS56ZW5nQGhpc2ls
aWNvbi5jb20+DQo+Pj4+PiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCAzLzldIERvY3VtZW50YXRp
b24vc2NydWItY29uZmlndXJlLnJzdDogQWRkDQo+Pj4+PiBkb2N1bWVudGF0aW9uIGZvciBzY3J1
YiBkcml2ZXINCj4+Pj4+DQo+Pj4+PiBPbiAxNS4wOS4yMyAxOToyOCwgc2hpanUuam9zZUBodWF3
ZWkuY29tIHdyb3RlOg0KPj4+Pj4+IEZyb206IFNoaWp1IEpvc2UgPHNoaWp1Lmpvc2VAaHVhd2Vp
LmNvbT4NCj4+Pj4+Pg0KPj4+Pj4+IEFkZCBkb2N1bWVudGF0aW9uIGZvciBzY3J1YiBkcml2ZXIs
IHN1cHBvcnRzIGNvbmZpZ3VyZSBzY3J1Yg0KPj4+Pj4+IHBhcmFtZXRlcnMsIGluIERvY3VtZW50
YXRpb24vc2NydWItY29uZmlndXJlLnJzdA0KPj4+Pj4+DQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTog
U2hpanUgSm9zZSA8c2hpanUuam9zZUBodWF3ZWkuY29tPg0KPj4+Pj4+IC0tLQ0KPj4+Pj4+ICAg
ICBEb2N1bWVudGF0aW9uL3NjcnViLWNvbmZpZ3VyZS5yc3QgfCA1NQ0KPj4+Pj4gKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPj4+Pj4+ICAgICAxIGZpbGUgY2hhbmdlZCwgNTUgaW5z
ZXJ0aW9ucygrKQ0KPj4+Pj4+ICAgICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9z
Y3J1Yi1jb25maWd1cmUucnN0DQo+Pj4+Pj4NCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9zY3J1Yi1jb25maWd1cmUucnN0DQo+Pj4+Pj4gYi9Eb2N1bWVudGF0aW9uL3NjcnViLWNv
bmZpZ3VyZS5yc3QNCj4+Pj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4+Pj4+IGluZGV4IDAw
MDAwMDAwMDAwMC4uOWY4NTgxYjg4Nzg4DQo+Pj4+Pj4gLS0tIC9kZXYvbnVsbA0KPj4+Pj4+ICsr
KyBiL0RvY3VtZW50YXRpb24vc2NydWItY29uZmlndXJlLnJzdA0KPj4+Pj4+IEBAIC0wLDAgKzEs
NTUgQEANCj4+Pj4+PiArPT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4+Pj4+PiArU2NydWIg
c3Vic3lzdGVtIGRyaXZlcg0KPj4+Pj4+ICs9PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPj4+
Pj4+ICsNCj4+Pj4+PiArQ29weXJpZ2h0IChjKSAyMDIzIEhpU2lsaWNvbiBMaW1pdGVkLg0KPj4+
Pj4+ICsNCj4+Pj4+PiArOkF1dGhvcjogICBTaGlqdSBKb3NlIDxzaGlqdS5qb3NlQGh1YXdlaS5j
b20+DQo+Pj4+Pj4gKzpMaWNlbnNlOiAgVGhlIEdOVSBGcmVlIERvY3VtZW50YXRpb24gTGljZW5z
ZSwgVmVyc2lvbiAxLjINCj4+Pj4+PiArICAgICAgICAgIChkdWFsIGxpY2Vuc2VkIHVuZGVyIHRo
ZSBHUEwgdjIpIDpPcmlnaW5hbCBSZXZpZXdlcnM6DQo+Pj4+Pj4gKw0KPj4+Pj4+ICstIFdyaXR0
ZW4gZm9yOiA2LjcNCj4+Pj4+PiArLSBVcGRhdGVkIGZvcjoNCj4+Pj4+PiArDQo+Pj4+Pj4gK0lu
dHJvZHVjdGlvbg0KPj4+Pj4+ICstLS0tLS0tLS0tLS0NCj4+Pj4+PiArVGhlIHNjcnViIHN1YnN5
c3RlbSBkcml2ZXIgcHJvdmlkZXMgdGhlIGludGVyZmFjZSBmb3IgY29uZmlndXJlDQo+Pj4+Pj4g
K3RoZQ0KPj4+Pj4NCj4+Pj4+ICIuLi4gaW50ZXJmYWNlIGZvciBjb25maWd1cmluZyBtZW1vcnkg
c2NydWJiZXJzIGluIHRoZSBzeXN0ZW0uIg0KPj4+Pj4NCj4+Pj4+IGFyZSB3ZSBvbmx5IGNvbmZp
Z3VyaW5nIGZpcm13YXJlL2h3LWJhc2VkIG1lbW9yeSBzY3J1YmJpbmc/IEkgYXNzdW1lDQo+c28u
DQo+Pj4+IFRoZSBzY3J1YiBjb250cm9sIGNvdWxkIGJlIHVzZWQgZm9yIHRoZSBTVyAgYmFzZWQg
bWVtb3J5IHNjcnViYmluZyB0b28uDQo+Pj4NCj4+PiBPa2F5LCBsb29rcyBsaWtlIHRoZXJlIGlz
IG5vdCB0b28gbXVjaCBody9maXJtd2FyZSBzcGVjaWZpYyBpbiB0aGVyZQ0KPj4+IChiZXNpZGVz
IHRoZXNlIHdlaXJkIHJhbmdlIGNoYW5nZXMpLg0KPj4+IFsuLi5dDQo+Pj4NCj4+Pj4+PiArLS0t
LS0tLQ0KPj4+Pj4+ICsNCj4+Pj4+PiArICBUaGUgdXNhZ2UgdGFrZXMgdGhlIGZvcm0gc2hvd24g
aW4gdGhpcyBleGFtcGxlOjoNCj4+Pj4+PiArDQo+Pj4+Pj4gKyAgICAjIGVjaG8gMHgzMDAwMDAg
PiAvc3lzL2NsYXNzL3NjcnViL3NjcnViMC9yZWdpb24wL2FkZHJfYmFzZQ0KPj4+Pj4+ICsgICAg
IyBlY2hvIDB4MTAwMDAwID4gL3N5cy9jbGFzcy9zY3J1Yi9zY3J1YjAvcmVnaW9uMC9hZGRyX3Np
emUNCj4+Pj4+PiArICAgICMgY2F0IC9zeXMvY2xhc3Mvc2NydWIvc2NydWIwL3JlZ2lvbjAvc3Bl
ZWRfYXZhaWxhYmxlDQo+Pj4+Pj4gKyAgICAjIDEtNjANCj4+Pj4+PiArICAgICMgZWNobyAyNSA+
IC9zeXMvY2xhc3Mvc2NydWIvc2NydWIwL3JlZ2lvbjAvc3BlZWQNCj4+Pj4+PiArICAgICMgZWNo
byAxID4gL3N5cy9jbGFzcy9zY3J1Yi9zY3J1YjAvcmVnaW9uMC9lbmFibGUNCj4+Pj4+PiArDQo+
Pj4+Pj4gKyAgICAjIGNhdCAvc3lzL2NsYXNzL3NjcnViL3NjcnViMC9yZWdpb24wL3NwZWVkDQo+
Pj4+Pj4gKyAgICAjIDB4MTkNCj4+Pj4+DQo+Pj4+PiBJcyBpdCByZWFzb25hYmxlIHRvIHJldHVy
biB0aGUgc3BlZWQgYXMgaGV4PyBZb3Ugc2V0IGl0IGFzIGRlYy4NCj4+Pj4gUHJlc2VudGx5IHJl
dHVybiBzcGVlZCAgYXMgaGV4IHRvIHJlZHVjZSB0aGUgbnVtYmVyIG9mIGNhbGxiYWNrDQo+Pj4+
IGZ1bmN0aW9uIG5lZWRlZCBmb3IgcmVhZGluZyB0aGUgaGV4L2RlYyBkYXRhIGJlY2F1c2UgdGhl
IHZhbHVlcyBmb3INCj4+Pj4gdGhlIGFkZHJlc3MgcmFuZ2UgbmVlZCB0byBiZSBpbiBoZXguDQo+
Pj4NCj4+PiBJZiBzcGVlZF9hdmFpbGFibGUgcmV0dXJucyBkZWMsIHNwZWVkIGJldHRlciBhbHNv
IHJldHVybiBkZWMgSU1ITy4NCj4+Pg0KPj4+Pg0KPj4+Pj4NCj4+Pj4+PiArICAgICMgY2F0IC9z
eXMvY2xhc3Mvc2NydWIvc2NydWIwL3JlZ2lvbjAvYWRkcl9iYXNlDQo+Pj4+Pj4gKyAgICAjIDB4
MTAwMDAwDQo+Pj4+Pg0KPj4+Pj4gQnV0IGRpZG4ndCB3ZSBzZXQgaXQgdG8gMHgzMDAwMDAgLi4u
DQo+Pj4+IFRoaXMgaXMgYW4gZW11bGF0ZWQgZXhhbXBsZSBmb3IgdGVzdGluZyB0aGUgUkFTRi9S
QVMyIGRlZmluaXRpb24uDQo+Pj4+IEFjY29yZGluZyB0byB0aGUgUkFTRiAmIFJBUzIgZGVmaW5p
dGlvbiwgdGhlIGFjdHVhbCBhZGRyZXNzIHJhbmdlIGluDQo+Pj4+IHRoZSBwbGF0Zm9ybSBjb3Vs
ZCB2YXJ5IGZyb20gdGhlIHJlcXVlc3RlZCBhZGRyZXNzIHJhbmdlIGZvciB0aGUgcGF0cm9sDQo+
c2NydWJiaW5nLg0KPj4+PiAiVGhlIHBsYXRmb3JtIGNhbGN1bGF0ZXMgdGhlIG5lYXJlc3QgcGF0
cm9sIHNjcnViIGJvdW5kYXJ5IGFkZHJlc3MNCj4+Pj4gZnJvbSB3aGVyZSBpdCBjYW4gc3RhcnQi
LiBUaGUgcGxhdGZvcm0gcmV0dXJucyB0aGUgYWN0dWFsIGFkZHJlc3MNCj4+Pj4gcmFuZ2UgaW4g
cmVzcG9uc2UgdG8gR0VUX1BBVFJPTF9QQVJBTUVURVJTIGNvbW1hbmQgdG8gdGhlDQo+ZmlybXdh
cmUuDQo+Pj4+IFBsZWFzZSBzZWUgc2VjdGlvbiA1LjIuMjEuMi4xIEhhcmR3YXJlLWJhc2VkIE1l
bW9yeSBTY3J1YmJpbmcgLA0KPj4+PiBUYWJsZSA1Ljg3OiBQYXJhbWV0ZXIgQmxvY2sgU3RydWN0
dXJlIGZvciBQQVRST0xfU0NSVUIgaW4gdGhlIEFDUEkNCj4+Pj4gNi41IHNwZWNpZmljYXRpb24u
DQo+Pj4+DQo+Pj4NCj4+PiBTbyB5b3UgY29uZmlndXJlIFsweDMwMDAwMCAtIDB4NDAwMDAwXSBh
bmQgeW91IGdldCBbMHgxMDAwMDAgLQ0KPj4+IDB4MzAwMDAwXQ0KPj4+DQo+Pj4gSG93IGRvZXMg
dGhhdCBtYWtlIGFueSBzZW5zZT8gOikNCj4+Pg0KPj4+IFNob3VsZG4ndCB3ZSByYXRoZXIgcmV0
dXJuIGFuIGVycm9yIHdoZW4gc2V0dGluZyBhIHJhbmdlIHRoYXQgaXMNCj4+PiBpbXBvc3NpYmxl
LCBpbnN0ZWFkIG9mIHRoZSBoYXJkd2FyZSBkZWNpZGluZyB0byBzY3J1YiBzb21ldGhpbmcNCj4+
PiBjb21wbGV0ZWx5IGRpZmZlcmVudCAoYXMgY2FuIGJlIHNlZW4gaW4gdGhlIGV4YW1wbGUpPw0K
Pj4+DQo+Pg0KPj4gQSBicm9hZGVyIHNjcnViIGlzIHByb2JhYmx5IHJlYXNvbmFibGUsIGJ1dCBh
Z3JlZWQgdGhhdCBzY3J1YmJpbmcNCj4+IG5hcnJvd2VyIGlzICdpbnRlcmVzdGluZycgYXMgbm90
IHNjcnViYmluZyB0aGUgbWVtb3J5IHJlcXVlc2V0ZWQuDQo+DQo+SXQncyBub3QgZXZlbiBuYXJy
b3dlci4gQm90aCByYW5nZXMgZG9uJ3QgZXZlbiBpbnRlcnNlY3QhIChzb3JyeSB0byBzYXksIGJ1
dCB0aGlzDQo+Y29uZmlndXJhdGlvbiBpbnRlcmZhY2UgZG9lc24ndCBtYWtlIGFueSBzZW5zZSBp
ZiBoYXJkd2FyZSBqdXN0IGRvZXMNCj4qc29tZXRoaW5nKiBlbHNlKS4NCj4NCj5JZiB5b3UgY2Fu
J3QgY29uZmlndXJlIGl0IHByb3Blcmx5LCBmYWlsIHdpdGggYW4gZXJyb3IuDQo+DQo+PiBJdCdz
IHJlYWxseSBhbm5veWluZyB0aGF0IG5laXRoZXIgQUNQSSB0YWJsZSBwcm92aWRlcyBhbnkgcHJv
cGVyDQo+PiBkaXNjb3ZlcmFiaWxpdHkuICBXaGlsc3Qgd2UgY2FuIGZpeCB0aGF0IGxvbmcgdGVy
bSwgd2UgYXJlIHN0dWNrIHdpdGgNCj4+IGEgY2x1bmt5IHBva2UgaXQgYW5kIHNlZSBpbnRlcmZh
Y2UgaW4gdGhlIG1lYW50aW1lLg0KPg0KPkNhbid0IHlvdSBzZXQgaXQsIGJyaWVmbHkgZW5hYmxl
IGl0LCBhbmQgcmVhZCB0aGUgdmFsdWVzIGJhY2s/IFRoZW4sIHlvdSBjYW4NCj5jb21wbGFpbiB0
byB0aGUgdXNlciB0aGF0IHRoZSBjb25maWd1cmVkIHJhbmdlIGlzIGltcG9zc2libGUuDQoNCldp
bGwgdHJ5IHRvIGFkZCByZXBvcnQgdG8gdGhlIHVzZXIgdGhhdCB0aGUgY29uZmlndXJlZCBhZGRy
ZXNzIHJhbmdlIGlzIG5vdCBwb3NzaWJsZS4NCg0KPg0KPi0tDQo+Q2hlZXJzLA0KPg0KPkRhdmlk
IC8gZGhpbGRlbmINCg0KVGhhbmtzLA0KU2hpanUNCg==
