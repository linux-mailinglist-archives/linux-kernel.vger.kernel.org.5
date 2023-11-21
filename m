Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884B47F2900
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbjKUJb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbjKUJbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:31:23 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F280EC1;
        Tue, 21 Nov 2023 01:31:18 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AL9UpU021510095, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AL9UpU021510095
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 17:30:52 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 21 Nov 2023 17:30:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 21 Nov 2023 17:30:51 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Tue, 21 Nov 2023 17:30:51 +0800
From:   Justin Lai <justinlai0215@realtek.com>
To:     Heiner Kallweit <heiner.kallweit@web.de>,
        "kuba@kernel.org" <kuba@kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v11 09/13] net:ethernet:realtek:rtase: Implement pci_driver suspend and resume function
Thread-Topic: [PATCH net-next v11 09/13] net:ethernet:realtek:rtase: Implement
 pci_driver suspend and resume function
Thread-Index: AQHaF8h49q/By0XF+EyMW2bU6F3AArB688YAgAmV+oA=
Date:   Tue, 21 Nov 2023 09:30:51 +0000
Message-ID: <da79c9899e454b80a73ef44d7fdd0135@realtek.com>
References: <20231115133414.1221480-1-justinlai0215@realtek.com>
 <20231115133414.1221480-10-justinlai0215@realtek.com>
 <22d15e87-a629-4c4c-a2dc-dcae50822e72@web.de>
In-Reply-To: <22d15e87-a629-4c4c-a2dc-dcae50822e72@web.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.210.185]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
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

PiBPbiAxNS4xMS4yMDIzIDE0OjM0LCBKdXN0aW4gTGFpIHdyb3RlOg0KPiA+IEltcGxlbWVudCB0
aGUgcGNpX2RyaXZlciBzdXNwZW5kIGZ1bmN0aW9uIHRvIGVuYWJsZSB0aGUgZGV2aWNlIHRvDQo+
ID4gc2xlZXAsIGFuZCBpbXBsZW1lbnQgdGhlIHJlc3VtZSBmdW5jdGlvbiB0byBlbmFibGUgdGhl
IGRldmljZSB0bw0KPiA+IHJlc3VtZSBvcGVyYXRpb24uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBKdXN0aW4gTGFpIDxqdXN0aW5sYWkwMjE1QHJlYWx0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAu
Li4vbmV0L2V0aGVybmV0L3JlYWx0ZWsvcnRhc2UvcnRhc2VfbWFpbi5jICAgfCA2NCArKysrKysr
KysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2NCBpbnNlcnRpb25zKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9ydGFzZS9ydGFz
ZV9tYWluLmMNCj4gPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcnRhc2UvcnRhc2Vf
bWFpbi5jDQo+ID4gaW5kZXggMTI2MDc2NjNkZDcyLi5iNzY3OWI3NGNjOGEgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvcmVhbHRlay9ydGFzZS9ydGFzZV9tYWluLmMNCj4g
PiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3J0YXNlL3J0YXNlX21haW4uYw0K
PiA+IEBAIC0yMzIzLDEyICsyMzIzLDc2IEBAIHN0YXRpYyB2b2lkIHJ0YXNlX3NodXRkb3duKHN0
cnVjdCBwY2lfZGV2DQo+ICpwZGV2KQ0KPiA+ICAgICAgIHJ0YXNlX3Jlc2V0X2ludGVycnVwdChw
ZGV2LCB0cCk7ICB9DQo+ID4NCj4gPiArI2lmZGVmIENPTkZJR19QTQ0KPiA+ICtzdGF0aWMgaW50
IHJ0YXNlX3N1c3BlbmQoc3RydWN0IHBjaV9kZXYgKnBkZXYsIHBtX21lc3NhZ2VfdCBzdGF0ZSkg
ew0KPiA+ICsgICAgIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYgPSBwY2lfZ2V0X2RydmRhdGEocGRl
dik7DQo+ID4gKw0KPiA+ICsgICAgIGlmICghbmV0aWZfcnVubmluZyhkZXYpKQ0KPiA+ICsgICAg
ICAgICAgICAgZ290byBvdXQ7DQo+ID4gKw0KPiA+ICsgICAgIG5ldGlmX3N0b3BfcXVldWUoZGV2
KTsNCj4gPiArICAgICBuZXRpZl9jYXJyaWVyX29mZihkZXYpOw0KPiA+ICsgICAgIG5ldGlmX2Rl
dmljZV9kZXRhY2goZGV2KTsNCj4gPiArICAgICBydGFzZV9od19yZXNldChkZXYpOw0KPiA+ICsN
Cj4gPiArb3V0Og0KPiA+ICsgICAgIHBjaV9zYXZlX3N0YXRlKHBkZXYpOw0KPiA+ICsNCj4gPiAr
ICAgICByZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBydGFzZV9yZXN1
bWUoc3RydWN0IHBjaV9kZXYgKnBkZXYpIHsNCj4gPiArICAgICBzdHJ1Y3QgbmV0X2RldmljZSAq
ZGV2ID0gcGNpX2dldF9kcnZkYXRhKHBkZXYpOw0KPiA+ICsgICAgIHN0cnVjdCBydGFzZV9wcml2
YXRlICp0cCA9IG5ldGRldl9wcml2KGRldik7DQo+ID4gKyAgICAgaW50IHJldDsNCj4gPiArDQo+
ID4gKyAgICAgcGNpX3NldF9wb3dlcl9zdGF0ZShwZGV2LCBQQ0lfRDApOw0KPiA+ICsgICAgIHBj
aV9yZXN0b3JlX3N0YXRlKHBkZXYpOw0KPiA+ICsgICAgIHBjaV9lbmFibGVfd2FrZShwZGV2LCBQ
Q0lfRDAsIDApOw0KPiA+ICsNCj4gDQo+IElNTyB0aGlzIGlzIGRvbmUgYnkgdGhlIFBDSSBjb3Jl
IGFscmVhZHkuIFNlZSBvdGhlciBkcml2ZXJzIGFuZCBQQ0kgY29yZSBjb2RlLg0KDQpUaGFuayB5
b3UsIEkgd2lsbCBjaGVjayB0aGlzIHBhcnQuDQo+IA0KPiA+ICsgICAgIC8qIHJlc3RvcmUgbGFz
dCBtb2RpZmllZCBtYWMgYWRkcmVzcyAqLw0KPiA+ICsgICAgIHJ0YXNlX3Jhcl9zZXQodHAsIGRl
di0+ZGV2X2FkZHIpOw0KPiA+ICsNCj4gPiArICAgICBpZiAoIW5ldGlmX3J1bm5pbmcoZGV2KSkN
Cj4gPiArICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+ICsNCj4gPiArICAgICBydGFzZV93YWl0
X2Zvcl9xdWllc2NlbmNlKGRldik7DQo+ID4gKw0KPiA+ICsgICAgIHJ0YXNlX3R4X2NsZWFyKHRw
KTsNCj4gPiArICAgICBydGFzZV9yeF9jbGVhcih0cCk7DQo+ID4gKw0KPiA+ICsgICAgIHJldCA9
IHJ0YXNlX2luaXRfcmluZyhkZXYpOw0KPiA+ICsgICAgIGlmIChyZXQpIHsNCj4gPiArICAgICAg
ICAgICAgIG5ldGRldl9lcnIoZGV2LCAidW5hYmxlIHRvIGluaXQgcmluZ1xuIik7DQo+ID4gKyAg
ICAgICAgICAgICBydGFzZV9mcmVlX2Rlc2ModHApOw0KPiA+ICsgICAgICAgICAgICAgcmV0dXJu
IC1FTk9NRU07DQo+ID4gKyAgICAgfQ0KPiA+ICsNCj4gPiArICAgICBydGFzZV9od19jb25maWco
ZGV2KTsNCj4gPiArICAgICAvKiBhbHdheXMgbGluaywgc28gc3RhcnQgdG8gdHJhbnNtaXQgJiBy
ZWNlaXZlICovDQo+ID4gKyAgICAgcnRhc2VfaHdfc3RhcnQoZGV2KTsNCj4gPiArDQo+ID4gKyAg
ICAgbmV0aWZfY2Fycmllcl9vbihkZXYpOw0KPiA+ICsgICAgIG5ldGlmX3dha2VfcXVldWUoZGV2
KTsNCj4gPiArICAgICBuZXRpZl9kZXZpY2VfYXR0YWNoKGRldik7DQo+ID4gKw0KPiA+ICtvdXQ6
DQo+ID4gKyAgICAgcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArI2VuZGlmIC8qIENPTkZJR19QTSAq
Lw0KPiA+ICsNCj4gPiAgc3RhdGljIHN0cnVjdCBwY2lfZHJpdmVyIHJ0YXNlX3BjaV9kcml2ZXIg
PSB7DQo+ID4gICAgICAgLm5hbWUgPSBLQlVJTERfTU9ETkFNRSwNCj4gPiAgICAgICAuaWRfdGFi
bGUgPSBydGFzZV9wY2lfdGJsLA0KPiA+ICAgICAgIC5wcm9iZSA9IHJ0YXNlX2luaXRfb25lLA0K
PiA+ICAgICAgIC5yZW1vdmUgPSBydGFzZV9yZW1vdmVfb25lLA0KPiA+ICAgICAgIC5zaHV0ZG93
biA9IHJ0YXNlX3NodXRkb3duLA0KPiA+ICsjaWZkZWYgQ09ORklHX1BNDQo+ID4gKyAgICAgLnN1
c3BlbmQgPSBydGFzZV9zdXNwZW5kLA0KPiA+ICsgICAgIC5yZXN1bWUgPSBydGFzZV9yZXN1bWUs
DQo+IA0KPiBVc2UgcG1fc2xlZXBfcHRyIGFuZCByZWxhdGVkIG1hY3JvcyB0aGVuIHlvdSBkb24n
dCBuZWVkIHRoZSBjb25kaXRpb25hbA0KPiBjb21waWxpbmcuDQoNClRoYW5rcyBmb3IgeW91ciBz
dWdnZXN0aW9uLCBJIHdpbGwgbW9kaWZ5IHRoaXMgZHJpdmVyLg0KPiANCj4gPiArI2VuZGlmDQo+
ID4gIH07DQo+ID4NCj4gPiAgbW9kdWxlX3BjaV9kcml2ZXIocnRhc2VfcGNpX2RyaXZlcik7DQoN
Cg==
