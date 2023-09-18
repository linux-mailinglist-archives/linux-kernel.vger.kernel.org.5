Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022737A46CF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239553AbjIRKUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbjIRKUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:20:05 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F51A6;
        Mon, 18 Sep 2023 03:19:59 -0700 (PDT)
Received: from lhrpeml100004.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rq12b6TjBz6HJmg;
        Mon, 18 Sep 2023 18:17:59 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml100004.china.huawei.com (7.191.162.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 18 Sep 2023 11:19:56 +0100
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.031;
 Mon, 18 Sep 2023 11:19:56 +0100
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
Thread-Index: AQHZ5/oe1pAvyQNvtUqNE6jH1WS6cbAfdxAAgADQwZA=
Date:   Mon, 18 Sep 2023 10:19:56 +0000
Message-ID: <e8a20cf946354312b865c1d69a18a81c@huawei.com>
References: <20230915172818.761-1-shiju.jose@huawei.com>
 <CACw3F50Edbk7uemvS-ZCNABKSz=3VMaRdPjzoYp9XE-hkOUKBg@mail.gmail.com>
In-Reply-To: <CACw3F50Edbk7uemvS-ZCNABKSz=3VMaRdPjzoYp9XE-hkOUKBg@mail.gmail.com>
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

WytjYyBsaW51eC1lZGFjQHZnZXIua2VybmVsLm9yZ10NCiANCkhlbGxvLCANCg0KPi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSmlhcWkgWWFuIDxqaWFxaXlhbkBnb29nbGUuY29t
Pg0KPlNlbnQ6IDE3IFNlcHRlbWJlciAyMDIzIDIyOjE0DQo+VG86IFNoaWp1IEpvc2UgPHNoaWp1
Lmpvc2VAaHVhd2VpLmNvbT4NCj5DYzogbGludXgtYWNwaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LW1tQGt2YWNrLm9yZzsgbGludXgtDQo+a2VybmVsQHZnZXIua2VybmVsLm9yZzsgcmFmYWVsQGtl
cm5lbC5vcmc7IGxlbmJAa2VybmVsLm9yZzsNCj5uYW95YS5ob3JpZ3VjaGlAbmVjLmNvbTsgdG9u
eS5sdWNrQGludGVsLmNvbTsgamFtZXMubW9yc2VAYXJtLmNvbTsNCj5kYXZlLmhhbnNlbkBsaW51
eC5pbnRlbC5jb207IGRhdmlkQHJlZGhhdC5jb207IGp0aG91Z2h0b25AZ29vZ2xlLmNvbTsNCj5z
b21hc3VuZGFyYW0uYUBocGUuY29tOyBlcmRlbWFrdGFzQGdvb2dsZS5jb207IHBnb25kYUBnb29n
bGUuY29tOw0KPnJpZW50amVzQGdvb2dsZS5jb207IGR1ZW53ZW5AZ29vZ2xlLmNvbTsgVmlsYXMu
U3JpZGhhcmFuQGFtZC5jb207DQo+bWlrZS5tYWx2ZXN0dXRvQGludGVsLmNvbTsgZ3RoZWxlbkBn
b29nbGUuY29tOyBMaW51eGFybQ0KPjxsaW51eGFybUBodWF3ZWkuY29tPjsgSm9uYXRoYW4gQ2Ft
ZXJvbg0KPjxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyB0YW54aWFvZmVpIDx0YW54aWFv
ZmVpQGh1YXdlaS5jb20+Ow0KPlplbmd0YW8gKEIpIDxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+
DQo+U3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMC85XSBBQ1BJOlJBU0Y6IEFkZCBzdXBwb3J0IGZv
ciBBQ1BJIFJBU0YsIEFDUEkgUkFTMg0KPmFuZCBjb25maWd1cmUgc2NydWJiZXJzDQo+DQo+T24g
RnJpLCBTZXAgMTUsIDIwMjMgYXQgMTA6MjnigK9BTSA8c2hpanUuam9zZUBodWF3ZWkuY29tPiB3
cm90ZToNCj4+DQo+PiBGcm9tOiBTaGlqdSBKb3NlIDxzaGlqdS5qb3NlQGh1YXdlaS5jb20+DQo+
Pg0KPj4gVGhpcyBzZXJpZXMgYWRkLA0KPj4gMS4gc3VwcG9ydCBmb3IgQUNQSSBSQVNGKFJBUyBm
ZWF0dXJlIHRhYmxlKSBQQ0MgaW50ZXJmYWNlcyB0bw0KPj4gY29tbXVuaWNhdGUgd2l0aCB0aGUg
SFcgcGF0cm9sIHNjcnViYmVyIGluIHRoZSBwbGF0Zm9ybSwgYXMgcGVyIEFDUEkNCj4+IDUuMSAm
IHVwd2FyZHMgcmV2aXNpb24uIFNlY3Rpb24gNS4yLjIwLg0KPj4NCj4+IDIuIHN1cHBvcnQgZm9y
IEFDUEkgUkFTMihSQVMyIGZlYXR1cmUgdGFibGUpLCBhcyBwZXIgQUNQSSA2LjUgJg0KPj4gdXB3
YXJkcyByZXZpc2lvbi4gU2VjdGlvbiA1LjIuMjEuDQo+Pg0KPj4gMy4gc2NydWIgZHJpdmVyIHN1
cHBvcnRzIGNvbmZpZ3VyaW5nIHBhcmFtZXRlcnMgb2YgdGhlIG1lbW9yeQ0KPj4gc2NydWJiZXJz
IGluIHRoZSBzeXN0ZW0uIFRoaXMgZHJpdmVyIGhhcyBiZWVuIGltcGxlbWVudGVkIGJhc2VkIG9u
IHRoZQ0KPj4gaHdtb24gc3Vic3lzdGVtLg0KPj4NCj4+IFRoZSBmZWF0dXJlcyBoYXZlIHRlc3Rl
ZCB3aXRoIFJBU0YgYW5kIFJBUzIgZW11bGF0aW9uIGluIHRoZSBRRU1VLg0KPg0KPkkgYW0gdmVy
eSBjdXJpb3VzIGhvdyB0aGUgdGVzdCBpcyBkb25lLiBEb2VzIHRoZSBodyBwYXRyb2wgc2NydWJi
ZXIgb24gaG9zdA0KPmFjdHVhbGx5IGJlZW4gZHJpdmVuIGJ5IHRoZSBkcml2ZXIgdG8gc2NydWIg
bWVtb3J5IERJTU1zIChkb2Vzbid0IHNlZW0gc28gdG8NCj5tZSwgYnV0IGRvIGNvcnJlY3QgbWUp
PyBPciBpdCBpcyBsaWtlIHRvIGEgVk0gc2NydWJiaW5nIGlzIHNpbXVsYXRlZCBhbmQgbm8gcmVh
bA0KPm9wIHRvIERJTU1zPw0KSW50ZW50IGhlcmUgaXMgaGFyZHdhcmUgc2NydWJiZXIgb24gaG9z
dCBhcyBmYXIgYXMgd2UgYXJlIGNvbmNlcm5lZC4gDQpDb3VsZCBiZSB1c2VkIGZvciBWTSB0b28g
cGVyaGFwcy4gV2UgZGlkIGl0IHdpdGggUUVNVSBlbXVsYXRpb24gZm9yIG5vdw0KIHRvIGdldCB0
aGUgZmxleGliaWxpdHkgb2YgY29uZmlndXJhdGlvbi4gSG93ZXZlciB0aGVyZSB3aWxsIGJlIG90
aGVyIHNjcnViIGNvbnRyb2xzDQpvdmVyIHRpbWUsIHN1Y2ggYXMgRERSNSBFQ1MuDQpodHRwczov
L21lZGlhLXd3dy5taWNyb24uY29tLy0vbWVkaWEvY2xpZW50L2dsb2JhbC9kb2N1bWVudHMvcHJv
ZHVjdHMvd2hpdGUtcGFwZXIvZGRyNV9uZXdfZmVhdHVyZXNfd2hpdGVfcGFwZXIucGRmP3Jldj1i
OThmNDk3N2Q5MzM0YjRhYTVkMGQyMTFhOTJiZjE0YQ0KDQpBbHNvIGZvdW5kIHRoZXJlIGlzIHZl
cnkgc2ltcGxlIHN1cHBvcnQgZm9yIHNjcnViIGNvbnRyb2wgaW4gZWRhYywgYW5kIGFuIGFsdGVy
bmF0aXZlIHBhdGgNCndvdWxkIGJlIHRvIGxvb2sgYXQgZXh0ZW5kaW5nIHRoYXQgdG8gc3VmZmlj
aWVudCBjb21wbGV4aXR5IHRvIHN1cHBvcnQgcmVnaW9uIGJhc2VkIHNjYW5uaW5nLiANCmh0dHBz
Oi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVzdC9zb3VyY2UvaW5jbHVkZS9saW51eC9l
ZGFjLmgjTDUxMg0KDQo+DQo+Pg0KPj4gUHJldmlvdXMgcmVmZXJlbmNlcyB0byB0aGUgbWVtb3J5
IHNjdWIgYW5kIFJBU0YgdG9waWNzLg0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIw
MjIxMTAzMTU1MDI5LjI0NTExMDUtMS1qaWFxaXlhbkBnb29nbGUuYw0KPj4gb20vDQo+PiBodHRw
czovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtYXJtLWtlcm5lbC9wYXRjaC9D
UzFQUjg0TUIwDQo+Pg0KPjAzODcxOEY0OURCQzBGRjAzOTE5RTExODQzOTBAQ1MxUFI4NE1CMDAz
OC5OQU1QUkQ4NC5QUk9ELk9VVExPDQo+T0suQ09NLw0KPj4NCj4+IEEgU29tYXN1bmRhcmFtICgy
KToNCj4+ICAgQUNQSTpSQVNGOiBBZGQgZXh0cmFjdCBSQVNGIHRhYmxlIHRvIHJlZ2lzdGVyIFJB
U0YgcGxhdGZvcm0gZGV2aWNlcw0KPj4gICBBQ1BJOlJBU0Y6IEFkZCBjb21tb24gbGlicmFyeSBm
b3IgUkFTRiBhbmQgUkFTMiBQQ0MgaW50ZXJmYWNlcw0KPj4NCj4+IFNoaWp1IEpvc2UgKDcpOg0K
Pj4gICBtZW1vcnk6IHNjcnViOiBBZGQgc2NydWIgZHJpdmVyIHN1cHBvcnRzIGNvbmZpZ3VyaW5n
IG1lbW9yeSBzY3J1YmJlcnMNCj4+ICAgICBpbiB0aGUgc3lzdGVtDQo+PiAgIG1lbW9yeTogc2Ny
dWI6IHN5c2ZzOiBBZGQgRG9jdW1lbnRhdGlvbiBlbnRyaWVzIGZvciBzZXQgb2Ygc2NydWINCj4+
ICAgICBhdHRyaWJ1dGVzDQo+PiAgIERvY3VtZW50YXRpb24vc2NydWItY29uZmlndXJlLnJzdDog
QWRkIGRvY3VtZW50YXRpb24gZm9yIHNjcnViIGRyaXZlcg0KPj4gICBtZW1vcnk6IFJBU0Y6IEFk
ZCBtZW1vcnkgUkFTRiBkcml2ZXINCj4+ICAgQUNQSUNBOiBBQ1BJIDYuNTogQWRkIHN1cHBvcnQg
Zm9yIFJBUzIgdGFibGUNCj4+ICAgQUNQSTpSQVMyOiBBZGQgZHJpdmVyIGZvciBBQ1BJIFJBUzIg
ZmVhdHVyZSB0YWJsZSAoUkFTMikNCj4+ICAgbWVtb3J5OiBSQVMyOiBBZGQgbWVtb3J5IFJBUzIg
ZHJpdmVyDQo+Pg0KPj4gIC4uLi9BQkkvdGVzdGluZy9zeXNmcy1jbGFzcy1zY3J1Yi1jb25maWd1
cmUgICB8ICA4MiArKysrDQo+PiAgRG9jdW1lbnRhdGlvbi9zY3J1Yi1jb25maWd1cmUucnN0ICAg
ICAgICAgICAgIHwgIDU1ICsrKw0KPj4gIGRyaXZlcnMvYWNwaS9LY29uZmlnICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAxNSArDQo+PiAgZHJpdmVycy9hY3BpL01ha2VmaWxlICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICAxICsNCj4+ICBkcml2ZXJzL2FjcGkvcmFzMl9hY3BpLmMgICAg
ICAgICAgICAgICAgICAgICAgfCAgOTcgKysrKw0KPj4gIGRyaXZlcnMvYWNwaS9yYXNmX2FjcGku
YyAgICAgICAgICAgICAgICAgICAgICB8ICA3MSArKysNCj4+ICBkcml2ZXJzL2FjcGkvcmFzZl9h
Y3BpX2NvbW1vbi5jICAgICAgICAgICAgICAgfCAyNzIgKysrKysrKysrKysNCj4+ICBkcml2ZXJz
L21lbW9yeS9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTUgKw0KPj4gIGRyaXZl
cnMvbWVtb3J5L01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICB8ICAgMyArDQo+PiAgZHJp
dmVycy9tZW1vcnkvcmFzMi5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgMzM0ICsrKysrKysr
KysrKysNCj4+ICBkcml2ZXJzL21lbW9yeS9yYXNmLmMgICAgICAgICAgICAgICAgICAgICAgICAg
fCAzMzUgKysrKysrKysrKysrKw0KPj4gIGRyaXZlcnMvbWVtb3J5L3Jhc2ZfY29tbW9uLmMgICAg
ICAgICAgICAgICAgICB8IDI1MSArKysrKysrKysrDQo+PiAgZHJpdmVycy9tZW1vcnkvc2NydWIv
S2NvbmZpZyAgICAgICAgICAgICAgICAgIHwgIDExICsNCj4+ICBkcml2ZXJzL21lbW9yeS9zY3J1
Yi9NYWtlZmlsZSAgICAgICAgICAgICAgICAgfCAgIDYgKw0KPj4gIGRyaXZlcnMvbWVtb3J5L3Nj
cnViL21lbW9yeS1zY3J1Yi5jICAgICAgICAgICB8IDQ1MiArKysrKysrKysrKysrKysrKysNCj4+
ICBpbmNsdWRlL2FjcGkvYWN0YmwyLmggICAgICAgICAgICAgICAgICAgICAgICAgfCAgNTUgKysr
DQo+PiAgaW5jbHVkZS9hY3BpL3Jhc2ZfYWNwaS5oICAgICAgICAgICAgICAgICAgICAgIHwgIDU5
ICsrKw0KPj4gIGluY2x1ZGUvbWVtb3J5L21lbW9yeS1zY3J1Yi5oICAgICAgICAgICAgICAgICB8
ICA4NSArKysrDQo+PiAgaW5jbHVkZS9tZW1vcnkvcmFzZi5oICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgIDgyICsrKysNCj4+ICAxOSBmaWxlcyBjaGFuZ2VkLCAyMjgxIGluc2VydGlvbnMoKykN
Cj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4+IERvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcvc3lz
ZnMtY2xhc3Mtc2NydWItY29uZmlndXJlDQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50
YXRpb24vc2NydWItY29uZmlndXJlLnJzdCAgY3JlYXRlIG1vZGUNCj4+IDEwMDc1NSBkcml2ZXJz
L2FjcGkvcmFzMl9hY3BpLmMgIGNyZWF0ZSBtb2RlIDEwMDc1NQ0KPj4gZHJpdmVycy9hY3BpL3Jh
c2ZfYWNwaS5jICBjcmVhdGUgbW9kZSAxMDA3NTUNCj4+IGRyaXZlcnMvYWNwaS9yYXNmX2FjcGlf
Y29tbW9uLmMgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPj4gZHJpdmVycy9tZW1vcnkvcmFzMi5jICBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9tZW1vcnkvcmFzZi5jDQo+PiBjcmVhdGUgbW9kZSAx
MDA2NDQgZHJpdmVycy9tZW1vcnkvcmFzZl9jb21tb24uYyAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+
PiBkcml2ZXJzL21lbW9yeS9zY3J1Yi9LY29uZmlnICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4+IGRy
aXZlcnMvbWVtb3J5L3NjcnViL01ha2VmaWxlICBjcmVhdGUgbW9kZSAxMDA3NTUNCj4+IGRyaXZl
cnMvbWVtb3J5L3NjcnViL21lbW9yeS1zY3J1Yi5jDQo+PiAgY3JlYXRlIG1vZGUgMTAwNzU1IGlu
Y2x1ZGUvYWNwaS9yYXNmX2FjcGkuaCAgY3JlYXRlIG1vZGUgMTAwNzU1DQo+PiBpbmNsdWRlL21l
bW9yeS9tZW1vcnktc2NydWIuaCAgY3JlYXRlIG1vZGUgMTAwNzU1DQo+PiBpbmNsdWRlL21lbW9y
eS9yYXNmLmgNCj4+DQo+PiAtLQ0KPj4gMi4zNC4xDQo+Pg0KDQpUaGFua3MsDQpTaGlqdQ0K
