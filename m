Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513B07A46E1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239278AbjIRKZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241129AbjIRKZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:25:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3FAAD;
        Mon, 18 Sep 2023 03:25:12 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rq15N2sZWz6J7Db;
        Mon, 18 Sep 2023 18:20:24 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 18 Sep 2023 11:25:10 +0100
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.031;
 Mon, 18 Sep 2023 11:25:10 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     David Hildenbrand <david@redhat.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
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
        Linuxarm <linuxarm@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>
Subject: RE: [RFC PATCH 3/9] Documentation/scrub-configure.rst: Add
 documentation for scrub driver
Thread-Topic: [RFC PATCH 3/9] Documentation/scrub-configure.rst: Add
 documentation for scrub driver
Thread-Index: AQHZ5/ogEycepSDhbUOm98pdzG2eC7AgIWsAgAAq9pA=
Date:   Mon, 18 Sep 2023 10:25:10 +0000
Message-ID: <946f29d2370c41deb7a7c5a6f2bff0f3@huawei.com>
References: <20230915172818.761-1-shiju.jose@huawei.com>
        <20230915172818.761-4-shiju.jose@huawei.com>
 <887344ee-068d-f78f-d5f8-e816b966d875@redhat.com>
In-Reply-To: <887344ee-068d-f78f-d5f8-e816b966d875@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.156.14]
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

SGkgRGF2aWQsDQoNClRoYW5rcyBmb3IgbG9va2luZyBpbnRvIHRoaXMuDQoNCj4tLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQu
Y29tPg0KPlNlbnQ6IDE4IFNlcHRlbWJlciAyMDIzIDA4OjI0DQo+VG86IFNoaWp1IEpvc2UgPHNo
aWp1Lmpvc2VAaHVhd2VpLmNvbT47IGxpbnV4LWFjcGlAdmdlci5rZXJuZWwub3JnOyBsaW51eC0N
Cj5tbUBrdmFjay5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj5DYzogcmFmYWVs
QGtlcm5lbC5vcmc7IGxlbmJAa2VybmVsLm9yZzsgbmFveWEuaG9yaWd1Y2hpQG5lYy5jb207DQo+
dG9ueS5sdWNrQGludGVsLmNvbTsgamFtZXMubW9yc2VAYXJtLmNvbTsgZGF2ZS5oYW5zZW5AbGlu
dXguaW50ZWwuY29tOw0KPmppYXFpeWFuQGdvb2dsZS5jb207IGp0aG91Z2h0b25AZ29vZ2xlLmNv
bTsgc29tYXN1bmRhcmFtLmFAaHBlLmNvbTsNCj5lcmRlbWFrdGFzQGdvb2dsZS5jb207IHBnb25k
YUBnb29nbGUuY29tOyByaWVudGplc0Bnb29nbGUuY29tOw0KPmR1ZW53ZW5AZ29vZ2xlLmNvbTsg
VmlsYXMuU3JpZGhhcmFuQGFtZC5jb207IG1pa2UubWFsdmVzdHV0b0BpbnRlbC5jb207DQo+Z3Ro
ZWxlbkBnb29nbGUuY29tOyBMaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT47IEpvbmF0aGFu
IENhbWVyb24NCj48am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgdGFueGlhb2ZlaSA8dGFu
eGlhb2ZlaUBodWF3ZWkuY29tPjsNCj5aZW5ndGFvIChCKSA8cHJpbWUuemVuZ0BoaXNpbGljb24u
Y29tPg0KPlN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDMvOV0gRG9jdW1lbnRhdGlvbi9zY3J1Yi1j
b25maWd1cmUucnN0OiBBZGQNCj5kb2N1bWVudGF0aW9uIGZvciBzY3J1YiBkcml2ZXINCj4NCj5P
biAxNS4wOS4yMyAxOToyOCwgc2hpanUuam9zZUBodWF3ZWkuY29tIHdyb3RlOg0KPj4gRnJvbTog
U2hpanUgSm9zZSA8c2hpanUuam9zZUBodWF3ZWkuY29tPg0KPj4NCj4+IEFkZCBkb2N1bWVudGF0
aW9uIGZvciBzY3J1YiBkcml2ZXIsIHN1cHBvcnRzIGNvbmZpZ3VyZSBzY3J1Yg0KPj4gcGFyYW1l
dGVycywgaW4gRG9jdW1lbnRhdGlvbi9zY3J1Yi1jb25maWd1cmUucnN0DQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogU2hpanUgSm9zZSA8c2hpanUuam9zZUBodWF3ZWkuY29tPg0KPj4gLS0tDQo+PiAg
IERvY3VtZW50YXRpb24vc2NydWItY29uZmlndXJlLnJzdCB8IDU1DQo+KysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNTUgaW5zZXJ0aW9ucygrKQ0K
Pj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9zY3J1Yi1jb25maWd1cmUucnN0
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vc2NydWItY29uZmlndXJlLnJzdA0K
Pj4gYi9Eb2N1bWVudGF0aW9uL3NjcnViLWNvbmZpZ3VyZS5yc3QNCj4+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjlmODU4MWI4ODc4OA0KPj4gLS0tIC9kZXYv
bnVsbA0KPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9zY3J1Yi1jb25maWd1cmUucnN0DQo+PiBAQCAt
MCwwICsxLDU1IEBADQo+PiArPT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4+ICtTY3J1YiBz
dWJzeXN0ZW0gZHJpdmVyDQo+PiArPT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4+ICsNCj4+
ICtDb3B5cmlnaHQgKGMpIDIwMjMgSGlTaWxpY29uIExpbWl0ZWQuDQo+PiArDQo+PiArOkF1dGhv
cjogICBTaGlqdSBKb3NlIDxzaGlqdS5qb3NlQGh1YXdlaS5jb20+DQo+PiArOkxpY2Vuc2U6ICBU
aGUgR05VIEZyZWUgRG9jdW1lbnRhdGlvbiBMaWNlbnNlLCBWZXJzaW9uIDEuMg0KPj4gKyAgICAg
ICAgICAoZHVhbCBsaWNlbnNlZCB1bmRlciB0aGUgR1BMIHYyKSA6T3JpZ2luYWwgUmV2aWV3ZXJz
Og0KPj4gKw0KPj4gKy0gV3JpdHRlbiBmb3I6IDYuNw0KPj4gKy0gVXBkYXRlZCBmb3I6DQo+PiAr
DQo+PiArSW50cm9kdWN0aW9uDQo+PiArLS0tLS0tLS0tLS0tDQo+PiArVGhlIHNjcnViIHN1YnN5
c3RlbSBkcml2ZXIgcHJvdmlkZXMgdGhlIGludGVyZmFjZSBmb3IgY29uZmlndXJlIHRoZQ0KPg0K
PiIuLi4gaW50ZXJmYWNlIGZvciBjb25maWd1cmluZyBtZW1vcnkgc2NydWJiZXJzIGluIHRoZSBz
eXN0ZW0uIg0KPg0KPmFyZSB3ZSBvbmx5IGNvbmZpZ3VyaW5nIGZpcm13YXJlL2h3LWJhc2VkIG1l
bW9yeSBzY3J1YmJpbmc/IEkgYXNzdW1lIHNvLg0KVGhlIHNjcnViIGNvbnRyb2wgY291bGQgYmUg
dXNlZCBmb3IgdGhlIFNXICBiYXNlZCBtZW1vcnkgc2NydWJiaW5nIHRvby4NCg0KPg0KPj4gK3Bh
cmFtZXRlcnMgb2YgbWVtb3J5IHNjcnViYmVycyBpbiB0aGUgc3lzdGVtLiBUaGUgc2NydWIgZGV2
aWNlDQo+PiArZHJpdmVycyBpbiB0aGUgc3lzdGVtIHJlZ2lzdGVyIHdpdGggdGhlIHNjcnViIGNv
bmZpZ3VyZSBzdWJzeXN0ZW0uDQo+DQo+TWF5YmUgc2F5IGEgZmV3IHdvcmRzIHdoYXQgbWVtb3J5
IHNjcnViYmluZyBpcywgYW5kIHdoYXQgaXQgaXMgdXNlZCBmb3IuDQpTdXJlLg0KDQo+DQo+PiAr
DQo+PiArVGhlIHNjcnViIGNvbmZpZ3VyZSBkcml2ZXIgZXhwb3NlcyB0aGUgc2NydWIgY29udHJv
bHMgdG8gdGhlIHVzZXIgdmlhDQo+PiArc3lzZnMuDQo+PiArDQo+PiArVGhlIEZpbGUgU3lzdGVt
DQo+PiArLS0tLS0tLS0tLS0tLS0tDQo+PiArDQo+PiArVGhlIGNvbmZpZ3VyYXRpb24gcGFyYW1l
dGVycyBvZiB0aGUgcmVnaXN0ZXJlZCBzY3J1YmJlcnMgY291bGQgYmUNCj4+ICthY2Nlc3NlZCB2
aWEgdGhlIC9zeXMvY2xhc3Mvc2NydWIvc2NydWJYL3JlZ2lvbk4vDQo+PiArDQo+PiArc3lzZnMN
Cj4+ICstLS0tLQ0KPj4gKw0KPj4gK1N5c2ZzIGZpbGVzIGFyZSBkb2N1bWVudGVkIGluDQo+PiAr
YERvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lzZnMtY2xhc3Mtc2NydWItY29uZmlndXJlYC4N
Cj4+ICsNCj4+ICtFeGFtcGxlDQo+PiArLS0tLS0tLQ0KPj4gKw0KPj4gKyAgVGhlIHVzYWdlIHRh
a2VzIHRoZSBmb3JtIHNob3duIGluIHRoaXMgZXhhbXBsZTo6DQo+PiArDQo+PiArICAgICMgZWNo
byAweDMwMDAwMCA+IC9zeXMvY2xhc3Mvc2NydWIvc2NydWIwL3JlZ2lvbjAvYWRkcl9iYXNlDQo+
PiArICAgICMgZWNobyAweDEwMDAwMCA+IC9zeXMvY2xhc3Mvc2NydWIvc2NydWIwL3JlZ2lvbjAv
YWRkcl9zaXplDQo+PiArICAgICMgY2F0IC9zeXMvY2xhc3Mvc2NydWIvc2NydWIwL3JlZ2lvbjAv
c3BlZWRfYXZhaWxhYmxlDQo+PiArICAgICMgMS02MA0KPj4gKyAgICAjIGVjaG8gMjUgPiAvc3lz
L2NsYXNzL3NjcnViL3NjcnViMC9yZWdpb24wL3NwZWVkDQo+PiArICAgICMgZWNobyAxID4gL3N5
cy9jbGFzcy9zY3J1Yi9zY3J1YjAvcmVnaW9uMC9lbmFibGUNCj4+ICsNCj4+ICsgICAgIyBjYXQg
L3N5cy9jbGFzcy9zY3J1Yi9zY3J1YjAvcmVnaW9uMC9zcGVlZA0KPj4gKyAgICAjIDB4MTkNCj4N
Cj5JcyBpdCByZWFzb25hYmxlIHRvIHJldHVybiB0aGUgc3BlZWQgYXMgaGV4PyBZb3Ugc2V0IGl0
IGFzIGRlYy4NClByZXNlbnRseSByZXR1cm4gc3BlZWQgIGFzIGhleCB0byByZWR1Y2UgdGhlIG51
bWJlciBvZiBjYWxsYmFjayBmdW5jdGlvbiBuZWVkZWQNCmZvciByZWFkaW5nIHRoZSBoZXgvZGVj
IGRhdGEgYmVjYXVzZSB0aGUgdmFsdWVzIGZvciB0aGUgYWRkcmVzcyByYW5nZQ0KbmVlZCB0byBi
ZSBpbiBoZXguDQoNCj4NCj4+ICsgICAgIyBjYXQgL3N5cy9jbGFzcy9zY3J1Yi9zY3J1YjAvcmVn
aW9uMC9hZGRyX2Jhc2UNCj4+ICsgICAgIyAweDEwMDAwMA0KPg0KPkJ1dCBkaWRuJ3Qgd2Ugc2V0
IGl0IHRvIDB4MzAwMDAwIC4uLg0KVGhpcyBpcyBhbiBlbXVsYXRlZCBleGFtcGxlIGZvciB0ZXN0
aW5nIHRoZSBSQVNGL1JBUzIgZGVmaW5pdGlvbi4NCkFjY29yZGluZyB0byB0aGUgUkFTRiAmIFJB
UzIgZGVmaW5pdGlvbiwgdGhlIGFjdHVhbCBhZGRyZXNzIHJhbmdlIGluIHRoZQ0KcGxhdGZvcm0g
Y291bGQgdmFyeSBmcm9tIHRoZSByZXF1ZXN0ZWQgYWRkcmVzcyByYW5nZSBmb3IgdGhlIHBhdHJv
bCBzY3J1YmJpbmcuDQoiVGhlIHBsYXRmb3JtIGNhbGN1bGF0ZXMgdGhlIG5lYXJlc3QgcGF0cm9s
IHNjcnViIGJvdW5kYXJ5IGFkZHJlc3MNCmZyb20gd2hlcmUgaXQgY2FuIHN0YXJ0Ii4gVGhlIHBs
YXRmb3JtIHJldHVybnMgdGhlIGFjdHVhbCBhZGRyZXNzIHJhbmdlDQppbiByZXNwb25zZSB0byBH
RVRfUEFUUk9MX1BBUkFNRVRFUlMgY29tbWFuZCB0byB0aGUgZmlybXdhcmUuDQpQbGVhc2Ugc2Vl
IHNlY3Rpb24gNS4yLjIxLjIuMSBIYXJkd2FyZS1iYXNlZCBNZW1vcnkgU2NydWJiaW5nICwNClRh
YmxlIDUuODc6IFBhcmFtZXRlciBCbG9jayBTdHJ1Y3R1cmUgZm9yIFBBVFJPTF9TQ1JVQiBpbiB0
aGUgDQpBQ1BJIDYuNSBzcGVjaWZpY2F0aW9uLg0KDQo+DQo+PiArICAgICMgY2F0IC9zeXMvY2xh
c3Mvc2NydWIvc2NydWIwL3JlZ2lvbjAvYWRkcl9zaXplDQo+PiArICAgICMgMHgyMDAwMDANCj4N
Cj4uLi4gYW5kIGRpZG4ndCB3ZSBzZXQgaXQgdG8gMHgxMDAwMDAgPw0KPg0KPk9yIHdoYXQncyB0
aGUgbWFnaWMgaGFwcGVuaW5nIGhlcmU/DQpTYW1lIGFzIGFib3ZlLg0KDQo+DQo+PiArDQo+PiAr
ICAgICMgZWNobyAwID4gL3N5cy9jbGFzcy9zY3J1Yi9zY3J1YjAvcmVnaW9uMC9lbmFibGUNCj4N
Cj4tLQ0KPkNoZWVycywNCj4NCj5EYXZpZCAvIGRoaWxkZW5iDQo+DQoNClRoYW5rcywNClNoaWp1
DQo=
