Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52F87FB24C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343688AbjK1HG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjK1HGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:06:25 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70063C2;
        Mon, 27 Nov 2023 23:06:31 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AS75WDI01877012, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AS75WDI01877012
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Nov 2023 15:05:32 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 28 Nov 2023 15:05:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 28 Nov 2023 15:05:32 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Tue, 28 Nov 2023 15:05:32 +0800
From:   =?utf-8?B?SnlhbiBDaG91IFvlkajoirflrold?= <jyanchou@realtek.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "doug@schmorgal.com" <doug@schmorgal.com>,
        "tonyhuang.sunplus@gmail.com" <tonyhuang.sunplus@gmail.com>,
        "abel.vesa@linaro.org" <abel.vesa@linaro.org>,
        "william.qiu@starfivetech.com" <william.qiu@starfivetech.com>
Subject: RE: [PATCH v7][2/4] mmc: Add Synopsys DesignWare mmc cmdq host driver
Thread-Topic: [PATCH v7][2/4] mmc: Add Synopsys DesignWare mmc cmdq host
 driver
Thread-Index: AQHaHFq+bFd/3O/jHUaixlBEulhIvbCNogOAgAG2DdA=
Date:   Tue, 28 Nov 2023 07:05:32 +0000
Message-ID: <24b03128ab594363a29494c0171e9f5f@realtek.com>
References: <20231121091101.5540-1-jyanchou@realtek.com>
         <20231121091101.5540-3-jyanchou@realtek.com>
 <23011695aafca595c3c8722fda2a8e194c5318df.camel@pengutronix.de>
In-Reply-To: <23011695aafca595c3c8722fda2a8e194c5318df.camel@pengutronix.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.190.236]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGhpbGlwcCwNCg0KPj4gV2UgaW1wbGVtZW50ZWQgY21kcSBmZWF0dXJlIG9uIFN5bm9wc3lz
IERlc2lnbldhcmUgbW1jIGRyaXZlci4NCj4+IFRoZSBkaWZmZXJlbmNlIGJldHdlZW4gZHdfbW1j
LmMgYW5kIGR3X21tY19jcWUuYyB3ZXJlIGRpc3RpbmN0IA0KPj4gcmVnaXN0ZXIgZGVmaW5pdGlv
bnMsIG1tYyB1c2VyIGZsb3cgYW5kIHRoZSBhZGRpdGlvbiBvZiBjbWRxLg0KPj4NCj4+IE5ldyB2
ZXJzaW9uIG9mIFVzZXIgR3VpZGUgaGFkIG1vZGlmeSBtbWMgZHJpdmVyJ3MgdXNhZ2UgZmxvdywg
d2UgbWF5IA0KPj4gbmVlZCB0byByZW5ldyBjb2RlIHRvIHByZWNpc2VseSBmb2xsb3cgdXNlciBn
dWlkZS4NCj4+DQo+PiBNb3JlIG92ZXIsIFdlIGFkZGVkIGEgd2FpdCBzdGF0dXMgZnVuY3Rpb24g
dG8gc2F0aXNmeSBzeW5vcHN5cyB1c2VyIA0KPj4gZ3VpZGUncyBkZXNjcmlwdGlvbiwgc2luY2Ug
dGhpcyBmbG93IG1pZ2h0IGJlIHNwZWNpZmljIGluIHN5bm9wc3lzIA0KPj4gaG9zdCBkcml2ZXIg
b25seS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKeWFuIENob3UgPGp5YW5jaG91QHJlYWx0ZWsu
Y29tPg0KPj4NCj4+IOKAlC0tDQo+IFsuLi5dDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMv
aG9zdC9kd19tbWNfY3FlLmMgDQo+PiBiL2RyaXZlcnMvbW1jL2hvc3QvZHdfbW1jX2NxZS5jIG5l
dyBmaWxlIG1vZGUgMTAwNjQ0IGluZGV4IA0KPj4gMDAwMDAwMDAwMDAwLi5lYjAwZDZhNDc0YjIN
Cj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3QvZHdfbW1jX2NxZS5j
DQo+PiBAQCAtMCwwICsxLDE0NjcgQEANCj4gWy4uLl0NCj4+ICsjaWZkZWYgQ09ORklHX09GDQo+
PiArc3RhdGljIHN0cnVjdCBkd19tY2lfYm9hcmQgKmR3X21jaV9jcWVfcGFyc2VfZHQoc3RydWN0
IGR3X21jaSAqaG9zdCkgDQo+PiArew0KPj4gKyAgICAgc3RydWN0IGR3X21jaV9ib2FyZCAqcGRh
dGE7DQo+PiArICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSBob3N0LT5kZXY7DQo+PiArICAgICBj
b25zdCBzdHJ1Y3QgZHdfbWNpX2Rydl9kYXRhICpkcnZfZGF0YSA9IGhvc3QtPmRydl9kYXRhOw0K
Pj4gKyAgICAgaW50IHJldDsNCj4+ICsNCj4+ICsgICAgIHBkYXRhID0gZGV2bV9remFsbG9jKGRl
diwgc2l6ZW9mKCpwZGF0YSksIEdGUF9LRVJORUwpOw0KPj4gKyAgICAgaWYgKCFwZGF0YSkNCj4+
ICsgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7DQo+PiArDQo+PiArICAgICBw
ZGF0YS0+cnN0YyA9IGRldm1fcmVzZXRfY29udHJvbF9nZXRfb3B0aW9uYWxfZXhjbHVzaXZlKGRl
diwgTlVMTCk7DQo+PiArICAgICBpZiAoSVNfRVJSKHBkYXRhLT5yc3RjKSkgew0KPj4gKyAgICAg
ICAgICAgICBpZiAoUFRSX0VSUihwZGF0YS0+cnN0YykgPT0gLUVQUk9CRV9ERUZFUikNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRVBST0JFX0RFRkVSKTsNCg0KPiBU
aGlzIHNob3VsZA0KDQo+ICAgICAgICAgICAgICAgIHJldHVybiBFUlJfQ0FTVChwZGF0YS0+cnN0
Yyk7DQoNCj4gaW5zdGVhZC4NCg0KPiBUaGVyZSBpcyBubyByZWFzb24gdG8gaGlkZSBkZXZpY2Ug
dHJlZSBwYXJzaW5nIGVycm9ycyBoZXJlLCBhbmQgSSdkIGFyZ3VlIHBkYXRhIHNob3VsZCBub3Qg
YmUgcmV0dXJuZWQgd2l0aCByc3RjIHNldCB0byBhbiBlcnJvciB2YWx1ZS4NCj4gZGV2bV9yZXNl
dF9jb250cm9sX2dldF9vcHRpb25hbF9leGNsdXNpdmUoKSByZXR1cm5zIE5VTEwgaWYgdGhlcmUg
YXJlIG5vIGVycm9ycyBhbmQgbm8gcmVzZXQgaXMgc3BlY2lmaWVkIGluIHRoZSBkZXZpY2UgdHJl
ZS4NCg0KPiBUaGVuIHlvdSBjYW4ganVzdCB1c2UgZGV2X2Vycl9wcm9iZSgpIGF0IHRoZSBjYWxs
IHNpdGUgaW4gZHdfbWNpX2NxZV9wcm9iZSgpLg0KDQpUaGFua3MgZm9yIHlvdXIgYWR2aWNlLCB3
ZSB3aWxsIGNvcnJlY3QgaXQgaW4gb3VyIG5leHQgdmVyc2lvbi4NCg0KPiBbLi4uXQ0KPj4gK2lu
dCBkd19tY2lfY3FlX3Byb2JlKHN0cnVjdCBkd19tY2kgKmhvc3QpIHsNCj4gWy4uLl0NCj4+ICsg
ICAgIGlmICghSVNfRVJSKGhvc3QtPnBkYXRhLT5yc3RjKSkgew0KPj4gKyAgICAgICAgICAgICBy
ZXNldF9jb250cm9sX2Fzc2VydChob3N0LT5wZGF0YS0+cnN0Yyk7DQo+PiArICAgICAgICAgICAg
IHVzbGVlcF9yYW5nZSgxMCwgNTApOw0KPj4gKyAgICAgICAgICAgICByZXNldF9jb250cm9sX2Rl
YXNzZXJ0KGhvc3QtPnBkYXRhLT5yc3RjKTsNCj4+ICsgICAgIH0NCg0KPiBUaGlzIHNob3VsZCBi
ZSBjaGFuZ2VkIHRvDQoNCj4gICAgICAgIGlmIChob3N0LT5wZGF0YS0+cnN0Yykgew0KPiAgICAg
ICAgICAgICAgICByZXNldF9jb250cm9sX2Fzc2VydChob3N0LT5wZGF0YS0+cnN0Yyk7DQo+ICAg
ICAgICAgICAgICAgIHVzbGVlcF9yYW5nZSgxMCwgNTApOw0KPiAgICAgICAgICAgICAgICByZXNl
dF9jb250cm9sX2RlYXNzZXJ0KGhvc3QtPnBkYXRhLT5yc3RjKTsNCj4gICAgICAgIH0NCg0KWy4u
Ll0NCj4gKyAgICAgcmV0dXJuIDA7DQo+ICsNCj4gK2Vycl9kbWF1bm1hcDoNCj4gKyAgICAgaWYg
KCFJU19FUlIoaG9zdC0+cGRhdGEtPnJzdGMpKQ0KPiArICAgICAgICAgICAgIHJlc2V0X2NvbnRy
b2xfYXNzZXJ0KGhvc3QtPnBkYXRhLT5yc3RjKTsNCg0KPlRoaXMgc2hvdWxkIGJlIGp1c3QNCg0K
PiAgICAgICAgcmVzZXRfY29udHJvbF9hc3NlcnQoaG9zdC0+cGRhdGEtPnJzdGMpOw0KDQo+IGFz
IHJlc2V0X2NvbnRyb2xfYXNzZXJ0KCkgaXMgYSBuby1vcCBpZiBob3N0LT5wZGF0YS0+cnN0YyA9
PSBOVUxMLg0KDQo+IFsuLi5dDQo+PiArdm9pZCBkd19tY2lfY3FlX3JlbW92ZShzdHJ1Y3QgZHdf
bWNpICpob3N0KSB7DQo+IFsuLi5dDQo+PiArICAgICBpZiAoIUlTX0VSUihob3N0LT5wZGF0YS0+
cnN0YykpDQo+PiArICAgICAgICAgICAgIHJlc2V0X2NvbnRyb2xfYXNzZXJ0KGhvc3QtPnBkYXRh
LT5yc3RjKTsNCg0KPiAgICAgICAgcmVzZXRfY29udHJvbF9hc3NlcnQoaG9zdC0+cGRhdGEtPnJz
dGMpOw0KDQpBbHNvLCB3ZSB3aWxsIGNvcnJlY3QgdGhpcyBpbiBvdXIgbmV3IHZlcnNpb24sIHRo
YW5rcy4NCg0KQmVzdCBSZWdhcmRzLCANCkp5YW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IFBoaWxpcHAgWmFiZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+IA0KU2VudDog
TW9uZGF5LCBOb3ZlbWJlciAyNywgMjAyMyA4OjUxIFBNDQpUbzogSnlhbiBDaG91IFvlkajoirfl
roldIDxqeWFuY2hvdUByZWFsdGVrLmNvbT47IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7IGFkcmlh
bi5odW50ZXJAaW50ZWwuY29tOyBqaDgwLmNodW5nQHNhbXN1bmcuY29tOyByaXRlc2hoQGNvZGVh
dXJvcmEub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7IGtyenlzenRvZi5rb3psb3dza2krZHRAbGlu
YXJvLm9yZw0KQ2M6IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGFzdXRvc2hkQGNvZGVhdXJvcmEub3Jn
OyBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgYXJuZEBhcm5kYi5kZTsgYnJpYW5ub3JyaXNA
Y2hyb21pdW0ub3JnOyBkb3VnQHNjaG1vcmdhbC5jb207IHRvbnlodWFuZy5zdW5wbHVzQGdtYWls
LmNvbTsgYWJlbC52ZXNhQGxpbmFyby5vcmc7IHdpbGxpYW0ucWl1QHN0YXJmaXZldGVjaC5jb20N
ClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjddWzIvNF0gbW1jOiBBZGQgU3lub3BzeXMgRGVzaWduV2Fy
ZSBtbWMgY21kcSBob3N0IGRyaXZlcg0KDQoNCkV4dGVybmFsIG1haWwuDQoNCg0KDQpIaSwNCg0K
T24gRGksIDIwMjMtMTEtMjEgYXQgMTc6MTAgKzA4MDAsIEp5YW4gQ2hvdSB3cm90ZToNCj4gV2Ug
aW1wbGVtZW50ZWQgY21kcSBmZWF0dXJlIG9uIFN5bm9wc3lzIERlc2lnbldhcmUgbW1jIGRyaXZl
ci4NCj4gVGhlIGRpZmZlcmVuY2UgYmV0d2VlbiBkd19tbWMuYyBhbmQgZHdfbW1jX2NxZS5jIHdl
cmUgZGlzdGluY3QgDQo+IHJlZ2lzdGVyIGRlZmluaXRpb25zLCBtbWMgdXNlciBmbG93IGFuZCB0
aGUgYWRkaXRpb24gb2YgY21kcS4NCj4NCj4gTmV3IHZlcnNpb24gb2YgVXNlciBHdWlkZSBoYWQg
bW9kaWZ5IG1tYyBkcml2ZXIncyB1c2FnZSBmbG93LCB3ZSBtYXkgDQo+IG5lZWQgdG8gcmVuZXcg
Y29kZSB0byBwcmVjaXNlbHkgZm9sbG93IHVzZXIgZ3VpZGUuDQo+DQo+IE1vcmUgb3ZlciwgV2Ug
YWRkZWQgYSB3YWl0IHN0YXR1cyBmdW5jdGlvbiB0byBzYXRpc2Z5IHN5bm9wc3lzIHVzZXIgDQo+
IGd1aWRlJ3MgZGVzY3JpcHRpb24sIHNpbmNlIHRoaXMgZmxvdyBtaWdodCBiZSBzcGVjaWZpYyBp
biBzeW5vcHN5cyANCj4gaG9zdCBkcml2ZXIgb25seS4NCj4NCj4gU2lnbmVkLW9mZi1ieTogSnlh
biBDaG91IDxqeWFuY2hvdUByZWFsdGVrLmNvbT4NCj4NCj4g4oCULS0NClsuLi5dDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L2R3X21tY19jcWUuYyANCj4gYi9kcml2ZXJzL21tYy9o
b3N0L2R3X21tY19jcWUuYyBuZXcgZmlsZSBtb2RlIDEwMDY0NCBpbmRleCANCj4gMDAwMDAwMDAw
MDAwLi5lYjAwZDZhNDc0YjINCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9kcml2ZXJzL21tYy9o
b3N0L2R3X21tY19jcWUuYw0KPiBAQCAtMCwwICsxLDE0NjcgQEANClsuLi5dDQo+ICsjaWZkZWYg
Q09ORklHX09GDQo+ICtzdGF0aWMgc3RydWN0IGR3X21jaV9ib2FyZCAqZHdfbWNpX2NxZV9wYXJz
ZV9kdChzdHJ1Y3QgZHdfbWNpICpob3N0KSANCj4gK3sNCj4gKyAgICAgc3RydWN0IGR3X21jaV9i
b2FyZCAqcGRhdGE7DQo+ICsgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9IGhvc3QtPmRldjsNCj4g
KyAgICAgY29uc3Qgc3RydWN0IGR3X21jaV9kcnZfZGF0YSAqZHJ2X2RhdGEgPSBob3N0LT5kcnZf
ZGF0YTsNCj4gKyAgICAgaW50IHJldDsNCj4gKw0KPiArICAgICBwZGF0YSA9IGRldm1fa3phbGxv
YyhkZXYsIHNpemVvZigqcGRhdGEpLCBHRlBfS0VSTkVMKTsNCj4gKyAgICAgaWYgKCFwZGF0YSkN
Cj4gKyAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsNCj4gKw0KPiArICAgICBw
ZGF0YS0+cnN0YyA9IGRldm1fcmVzZXRfY29udHJvbF9nZXRfb3B0aW9uYWxfZXhjbHVzaXZlKGRl
diwgTlVMTCk7DQo+ICsgICAgIGlmIChJU19FUlIocGRhdGEtPnJzdGMpKSB7DQo+ICsgICAgICAg
ICAgICAgaWYgKFBUUl9FUlIocGRhdGEtPnJzdGMpID09IC1FUFJPQkVfREVGRVIpDQo+ICsgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRVBST0JFX0RFRkVSKTsNCg0KVGhpcyBz
aG91bGQNCg0KICAgICAgICAgICAgICAgIHJldHVybiBFUlJfQ0FTVChwZGF0YS0+cnN0Yyk7DQoN
Cmluc3RlYWQuDQoNClRoZXJlIGlzIG5vIHJlYXNvbiB0byBoaWRlIGRldmljZSB0cmVlIHBhcnNp
bmcgZXJyb3JzIGhlcmUsIGFuZCBJJ2QgYXJndWUgcGRhdGEgc2hvdWxkIG5vdCBiZSByZXR1cm5l
ZCB3aXRoIHJzdGMgc2V0IHRvIGFuIGVycm9yIHZhbHVlLg0KZGV2bV9yZXNldF9jb250cm9sX2dl
dF9vcHRpb25hbF9leGNsdXNpdmUoKSByZXR1cm5zIE5VTEwgaWYgdGhlcmUgYXJlIG5vIGVycm9y
cyBhbmQgbm8gcmVzZXQgaXMgc3BlY2lmaWVkIGluIHRoZSBkZXZpY2UgdHJlZS4NCg0KVGhlbiB5
b3UgY2FuIGp1c3QgdXNlIGRldl9lcnJfcHJvYmUoKSBhdCB0aGUgY2FsbCBzaXRlIGluIGR3X21j
aV9jcWVfcHJvYmUoKS4NCg0KDQpbLi4uXQ0KPiAraW50IGR3X21jaV9jcWVfcHJvYmUoc3RydWN0
IGR3X21jaSAqaG9zdCkgew0KWy4uLl0NCj4gKyAgICAgaWYgKCFJU19FUlIoaG9zdC0+cGRhdGEt
PnJzdGMpKSB7DQo+ICsgICAgICAgICAgICAgcmVzZXRfY29udHJvbF9hc3NlcnQoaG9zdC0+cGRh
dGEtPnJzdGMpOw0KPiArICAgICAgICAgICAgIHVzbGVlcF9yYW5nZSgxMCwgNTApOw0KPiArICAg
ICAgICAgICAgIHJlc2V0X2NvbnRyb2xfZGVhc3NlcnQoaG9zdC0+cGRhdGEtPnJzdGMpOw0KPiAr
ICAgICB9DQoNClRoaXMgc2hvdWxkIGJlIGNoYW5nZWQgdG8NCg0KICAgICAgICBpZiAoaG9zdC0+
cGRhdGEtPnJzdGMpIHsNCiAgICAgICAgICAgICAgICByZXNldF9jb250cm9sX2Fzc2VydChob3N0
LT5wZGF0YS0+cnN0Yyk7DQogICAgICAgICAgICAgICAgdXNsZWVwX3JhbmdlKDEwLCA1MCk7DQog
ICAgICAgICAgICAgICAgcmVzZXRfY29udHJvbF9kZWFzc2VydChob3N0LT5wZGF0YS0+cnN0Yyk7
DQogICAgICAgIH0NCg0KWy4uLl0NCj4gKyAgICAgcmV0dXJuIDA7DQo+ICsNCj4gK2Vycl9kbWF1
bm1hcDoNCj4gKyAgICAgaWYgKCFJU19FUlIoaG9zdC0+cGRhdGEtPnJzdGMpKQ0KPiArICAgICAg
ICAgICAgIHJlc2V0X2NvbnRyb2xfYXNzZXJ0KGhvc3QtPnBkYXRhLT5yc3RjKTsNCg0KVGhpcyBz
aG91bGQgYmUganVzdA0KDQogICAgICAgIHJlc2V0X2NvbnRyb2xfYXNzZXJ0KGhvc3QtPnBkYXRh
LT5yc3RjKTsNCg0KYXMgcmVzZXRfY29udHJvbF9hc3NlcnQoKSBpcyBhIG5vLW9wIGlmIGhvc3Qt
PnBkYXRhLT5yc3RjID09IE5VTEwuDQoNClsuLi5dDQo+ICt2b2lkIGR3X21jaV9jcWVfcmVtb3Zl
KHN0cnVjdCBkd19tY2kgKmhvc3QpIHsNClsuLi5dDQo+ICsgICAgIGlmICghSVNfRVJSKGhvc3Qt
PnBkYXRhLT5yc3RjKSkNCj4gKyAgICAgICAgICAgICByZXNldF9jb250cm9sX2Fzc2VydChob3N0
LT5wZGF0YS0+cnN0Yyk7DQoNCiAgICAgICAgcmVzZXRfY29udHJvbF9hc3NlcnQoaG9zdC0+cGRh
dGEtPnJzdGMpOw0KDQoNCnJlZ2FyZHMNClBoaWxpcHANCg==
