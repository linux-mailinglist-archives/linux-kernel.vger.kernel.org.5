Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE6F793A02
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 12:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239187AbjIFKgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 06:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjIFKf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:35:59 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80072CE2;
        Wed,  6 Sep 2023 03:35:55 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 386AZCFf8000411, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 386AZCFf8000411
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Sep 2023 18:35:12 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 6 Sep 2023 18:35:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 6 Sep 2023 18:35:40 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c]) by
 RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c%5]) with mapi id
 15.01.2375.007; Wed, 6 Sep 2023 18:35:40 +0800
From:   =?utf-8?B?SnlhbiBDaG91IFvlkajoirflrold?= <jyanchou@realtek.com>
To:     Ben Chuang <benchuanggli@gmail.com>
CC:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh80.chung@samsung.com" <jh80.chung@samsung.com>
Subject: RE: [PATCH] mmc: Add Synopsys DesignWare mmc cmdq host driver
Thread-Topic: [PATCH] mmc: Add Synopsys DesignWare mmc cmdq host driver
Thread-Index: AQHZ2u7HZPZa6nsQ8020UOdAb07ii7ADGZ2AgADnnLCACJJBgIABECig
Date:   Wed, 6 Sep 2023 10:35:39 +0000
Message-ID: <7a5b1e68f53240749c7453826d7fdbd9@realtek.com>
References: <20230830030503.13349-1-jyanchou@realtek.com>
 <CACT4zj-nRyAhtasV-gZW9Ja_FWNwvELnkuyPcq4SyDuGuEM8jA@mail.gmail.com>
 <d171e2279da847fa81022f6fd23869fb@realtek.com>
 <CACT4zj8yP0DPRfQ9_=gxaM+paZLW_86b5YVyGse-WiWK_KszPw@mail.gmail.com>
In-Reply-To: <CACT4zj8yP0DPRfQ9_=gxaM+paZLW_86b5YVyGse-WiWK_KszPw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.236]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmVuLA0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudCBhbmQgc3VnZ2VzdGlvbi4NCg0KPiBB
cGFydCBmcm9tIHRoZSBkaWZmZXJlbmNlIGluIHJlZ2lzdGVyIGRlZmluaXRpb25zIGFuZCB0aGUg
YWRkaXRpb24gb2YgY21kcSwgaXMgdGhlcmUgYW55IG90aGVyIGJlaGF2aW9yIHRoYXQgaXMgZGlm
ZmVyZW50IGZyb20gZHdfbW1jLmM/DQo+IEkgcmVjb21tZW5kIHVzaW5nIGEgcGF0Y2ggc2VyaWVz
IGFuZCBkZXNjcmliaW5nIHRoZSBkaWZmZXJlbmNlcyBmcm9tIGR3X21tYyBpbiB5b3VyIGNvdmVy
IGxldHRlciwgZm9yIGFuIGV4YW1wbGUgYXMgZm9sbG93cy4NCg0KV2UgaGFkIG1vZGlmaWVkIG91
ciBwYXRjaCBpbnRvIGEgcGF0Y2ggc2VyaWVzIGFuZCBmaXhlZCBjb21waWxlIGVycm9yLiBQbGVh
c2UgcmVmZXIgdG8gdGhlIGNvbW1pdHMgYmVsb3cuDQoNCj4gRG8geW91IGZvcmdldCB0byBhZGQg
ZHdfbW1jX2NxZS5vIGFuZCBkd19tbWNfY3FlLXJ0ay5vIHRvIE1ha2VmaWxlPw0KDQpUaGFua3Mg
Zm9yIHlvdXIgcmVtaW5kLCB3ZSBoYWQgYWRkZWQgZHdfbW1jX2NxZS5vLCBkd19tbWNfY3FlLXJ0
ay5vIGludG8gbmV3IHZlcnNpb24gcGF0Y2guDQoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5v
cmcvcHJvamVjdC9saW51eC1tbWMvcGF0Y2gvZGExZjdmYmFlMWRkMzRjZmM1ZDRiY2VjZjNhMjMy
M2YzODJmZmQzYS4xNjkzOTkxNzg1LmdpdC5qeWFuY2hvdUByZWFsdGVrLmNvbS8NCmh0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tbWMvcGF0Y2gvOTYxN2YwNDEzM2Jh
OGI2OTA3YjI1M2M0MTU0MDgzZjc1OTU2YTM0MS4xNjkzOTkxNzg1LmdpdC5qeWFuY2hvdUByZWFs
dGVrLmNvbS8NCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tbWMv
cGF0Y2gvOWNjNmM1MWQ4NTEzYzBkY2E1Mzk5NDIwZDc1MzgyNTE4M2FhOThmNC4xNjkzOTkxNzg1
LmdpdC5qeWFuY2hvdUByZWFsdGVrLmNvbS8NCg0KQmVzdCByZWdhcmRzLA0KSnlhbiBDaG91DQoN
Ci0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBCZW4gQ2h1YW5nIDxiZW5jaHVhbmdn
bGlAZ21haWwuY29tPiANClNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDYsIDIwMjMgMTA6MTMg
QU0NClRvOiBKeWFuIENob3UgW+WRqOiKt+WuiV0gPGp5YW5jaG91QHJlYWx0ZWsuY29tPg0KQ2M6
IGFkcmlhbi5odW50ZXJAaW50ZWwuY29tOyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOyBsaW51eC1t
bWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0
OiBSZTogW1BBVENIXSBtbWM6IEFkZCBTeW5vcHN5cyBEZXNpZ25XYXJlIG1tYyBjbWRxIGhvc3Qg
ZHJpdmVyDQoNCg0KRXh0ZXJuYWwgbWFpbC4NCg0KDQoNCkhpIEp5YW4sDQoNCk9uIFRodSwgQXVn
IDMxLCAyMDIzIGF0IDM6NDfigK9QTSBKeWFuIENob3UgW+WRqOiKt+WuiV0gPGp5YW5jaG91QHJl
YWx0ZWsuY29tPiB3cm90ZToNCj4NCj4gSGkgQmVuLA0KPiBUaGFua3MgZm9yIHlvdXIgc3VnZ2Vz
dGlvbi4NCj4NCj4gPiBUaGUgcGF0Y2ggaW5jbHVkZXMgdHdvIHBhcnRzOiBhIGR3X21tY19jcWUg
ZHJpdmVyIGFuZCBkd19tbWNfY3FlLXJ0ayBkcml2ZXIuDQo+ID4gQWRyaWFuIGFuZCBVbGYncyBj
b21tZW50c1sxXVsyXSBkb24ndCBzZWVtIHRvIGJlIGFkZHJlc3NlZC4NCj4NCj4gWzFdIFRoZSBy
ZWFzb24gd2h5IHdlIGFkZGVkIG1hbnkgY2hhbmdlcyB3YXMgYmVjYXVzZSB3ZSBmb3VuZCBvdXQg
dGhhdCANCj4gc3lub3BzeXMgSVAgZGF0YSBib29rJ3MgcmVnaXN0ZXIgYW5kIHVzZXIgZ3VpZGUg
d2l0aCBjbWRxIHN1cHBvcnQgd2VyZSANCj4gZGlmZmVyZW50IGZyb20gbm9uIGNtZHEncyAsIHNv
IHdlIHJlZmVycmVkIHRvIGR3X21tYy5jIGNvZGluZyBzdHlsZSANCj4gYW5kIHB1c2ggZHdfbW1j
X2NxZS5jIHRvIHN1cHBvcnQgdmVyc2lvbiBhZnRlciA1LjEgSkVERUMgU3RhbmRhcmQuDQo+DQoN
CkFwYXJ0IGZyb20gdGhlIGRpZmZlcmVuY2UgaW4gcmVnaXN0ZXIgZGVmaW5pdGlvbnMgYW5kIHRo
ZSBhZGRpdGlvbiBvZiBjbWRxLCBpcyB0aGVyZSBhbnkgb3RoZXIgYmVoYXZpb3IgdGhhdCBpcyBk
aWZmZXJlbnQgZnJvbSBkd19tbWMuYz8NCkkgcmVjb21tZW5kIHVzaW5nIGEgcGF0Y2ggc2VyaWVz
IGFuZCBkZXNjcmliaW5nIHRoZSBkaWZmZXJlbmNlcyBmcm9tIGR3X21tYyBpbiB5b3VyIGNvdmVy
IGxldHRlciwgZm9yIGFuIGV4YW1wbGUgYXMgZm9sbG93cw0KICBbMDAvMDRdIGNvdmVyIGxldHRl
ciAtIEFkZCBEZXNpZ25XYXJlIE1vYmlsZSBtbWMgZHJpdmVyDQogIFswMS8wNF0gSW50cm9kdWNl
IGEgc2V0dXBfdHJhbl9kZXNjIG9wcyAuLi4NCiAgWzAyLzA0XSBBZGQgZHcgbW9iaWxlX21tYyBk
cml2ZXIgLi4uLi4NCiAgWzAzLzA0XSBBZGQgY29tbWFuZCBxdWV1ZSB0byBkdyBtb2JpbGVfbW1j
IGRyaXZlciAuLi4uLg0KICBbMDQvMDRdIEFkZCBkdyBtb2JpbGUgbW1jIHJ0ayBkcml2ZXIgLi4u
Li4NCkFuZCBwbGVhc2UgcmVhZCBwYXRpZW50bHkNCmh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9j
L2h0bWwvbGF0ZXN0L3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLmh0bWwuDQoNCj4+LS0tDQo+
PiBkcml2ZXJzL21tYy9ob3N0L0tjb25maWcgICAgICAgICAgfCAgIDIyICsNCg0KRG8geW91IGZv
cmdldCB0byBhZGQgZHdfbW1jX2NxZS5vIGFuZCBkd19tbWNfY3FlLXJ0ay5vIHRvIE1ha2VmaWxl
Pw0KDQo+PiBkcml2ZXJzL21tYy9ob3N0L2NxaGNpLWNvcmUuYyAgICAgfCAgICA1ICsNCj4+IGRy
aXZlcnMvbW1jL2hvc3QvY3FoY2kuaCAgICAgICAgICB8ICAgIDIgKw0KPj4gZHJpdmVycy9tbWMv
aG9zdC9kd19tbWNfY3FlLXJ0ay5jIHwgIDk5OSArKysrKysrKysrKysrKysrKysgDQo+PiBkcml2
ZXJzL21tYy9ob3N0L2R3X21tY19jcWUtcnRrLmggfCAgMTYwICsrKw0KPj4gZHJpdmVycy9tbWMv
aG9zdC9kd19tbWNfY3FlLmMgICAgIHwgMTYzMyArKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPj4gZHJpdmVycy9tbWMvaG9zdC9kd19tbWNfY3FlLmggICAgIHwgIDQ0MiArKysrKysrKw0K
Pj4gNyBmaWxlcyBjaGFuZ2VkLCAzMjYzIGluc2VydGlvbnMoKykNCg0KDQpBbmQgc29tZSBjb21w
aWxlIGNvbXBsYWlucyBmb3IgeW91ciByZWZlcmVuY2UsDQotLS0NCmRyaXZlcnMvbW1jL2hvc3Qv
ZHdfbW1jX2NxZS5jOiBJbiBmdW5jdGlvbiAnZHdfbWNpX2NxZV9lcnJfaGFuZGxlJzoNCmRyaXZl
cnMvbW1jL2hvc3QvZHdfbW1jX2NxZS5jOjcyMzo0MTogd2FybmluZzogdGhpcyAnaWYnIGNsYXVz
ZSBkb2VzIG5vdCBndWFyZC4uLiBbLVdtaXNsZWFkaW5nLWluZGVudGF0aW9uXQ0KICA3MjMgfCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKGVyciA9PSAtRFdfTUNJ
X05PVF9SRUFEWSkNCiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIF5+DQpkcml2ZXJzL21tYy9ob3N0L2R3X21tY19jcWUuYzo3MjY6NDk6IG5vdGU6IC4uLnRo
aXMgc3RhdGVtZW50LCBidXQgdGhlIGxhdHRlciBpcyBtaXNsZWFkaW5nbHkgaW5kZW50ZWQgYXMg
aWYgaXQgd2VyZSBndWFyZGVkIGJ5IHRoZSAnaWYnDQogIDcyNiB8ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KICAgICAgfCAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fg0KLS0tLQ0KSW4gZmls
ZSBpbmNsdWRlZCBmcm9tIGRyaXZlcnMvbW1jL2hvc3QvZHdfbW1jX2NxZS1ydGsuYzoyMzoNCmRy
aXZlcnMvbW1jL2hvc3QvZHdfbW1jX2NxZS1ydGsuaDoxNTU6NTogZXJyb3I6IGNvbmZsaWN0aW5n
IHR5cGVzIGZvciAnbW1jX2h3X3Jlc2V0JzsgaGF2ZSAnaW50KHN0cnVjdCBtbWNfaG9zdCAqKScN
CiAgMTU1IHwgaW50IG1tY19od19yZXNldChzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QpOw0KICAgICAg
fCAgICAgXn5+fn5+fn5+fn5+DQpJbiBmaWxlIGluY2x1ZGVkIGZyb20gZHJpdmVycy9tbWMvaG9z
dC9kd19tbWNfY3FlLXJ0ay5jOjExOg0KLi9pbmNsdWRlL2xpbnV4L21tYy9jb3JlLmg6MTc4OjU6
IG5vdGU6IHByZXZpb3VzIGRlY2xhcmF0aW9uIG9mICdtbWNfaHdfcmVzZXQnIHdpdGggdHlwZSAn
aW50KHN0cnVjdCBtbWNfY2FyZCAqKScNCiAgMTc4IHwgaW50IG1tY19od19yZXNldChzdHJ1Y3Qg
bW1jX2NhcmQgKmNhcmQpOw0KLS0tLQ0KDQpCZXN0IHJlZ2FyZHMsDQpCZW4gQ2h1YW5nDQoNCi0t
LS0tLVBsZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5nIHRoaXMg
ZS1tYWlsLg0KDQo=
