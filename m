Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE56A771CDE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjHGJIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjHGJIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:08:19 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 610E3E79;
        Mon,  7 Aug 2023 02:08:15 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37797gmH6014049, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37797gmH6014049
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 7 Aug 2023 17:07:42 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 7 Aug 2023 17:07:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 7 Aug 2023 17:07:12 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 7 Aug 2023 17:07:12 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] usb: dwc3: add Realtek DHC RTD SoC dwc3 glue layer driver
Thread-Topic: [PATCH v2 1/2] usb: dwc3: add Realtek DHC RTD SoC dwc3 glue
 layer driver
Thread-Index: AQHZxFokPxd4W07ijUGGBrmKl0qPKq/VrnaAgADyIuCAAIy6gIAA9MlwgACO44CABeKOsA==
Date:   Mon, 7 Aug 2023 09:07:12 +0000
Message-ID: <ae619edfcce545b78697c6bcdadfff27@realtek.com>
References: <20230801092541.25261-1-stanley_chang@realtek.com>
 <20230802011400.v4jim6ajsqc3tvei@synopsys.com>
 <ff9ca6f15936450696bff502c0047708@realtek.com>
 <20230803000417.qfuwsx5we5a7lfvd@synopsys.com>
 <7d47cbfdbc31436b89d3d92bf980c8fa@realtek.com>
 <20230803231156.laggnj5bzuhugwfd@synopsys.com>
In-Reply-To: <20230803231156.laggnj5bzuhugwfd@synopsys.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhpbmgsDQoNCj4gPiA+ID4gPiA+ICtzdGF0aWMgaW50IGR3YzNfcnRrX3NldHVwX3JvbGVf
c3dpdGNoKHN0cnVjdCBkd2MzX3J0ayAqcnRrKQ0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQW55IHJl
YXNvbiB3aHkgd2UncmUgZG9pbmcgdGhlIHJvbGUgc3dpdGNoIGhlcmUgYW5kIG5vdCB3aGF0J3MN
Cj4gPiA+ID4gPiBpbXBsZW1lbnRlZCBmcm9tIHRoZSBjb3JlPw0KPiA+ID4gPiA+DQo+ID4gPiA+
IEJlY2F1c2Ugd2UgaGF2ZSB0byBzZXQgdGhlIHVzYiAyLjAgcGh5IG1vZGUgdGhyb3VnaA0KPiA+
ID4gPiBzd2l0Y2hfdXNiMl9kcl9tb2RlDQo+ID4gPiBpbiB0aGUgZnVuY3Rpb24gZHdjM19ydGtf
c2V0X2RyX21vZGUuDQo+ID4gPiA+IEluIGZhY3QsIHN3aXRjaF9kd2MzX2RyX21vZGUgd2lsbCB1
c2UgdGhlIHJvbGUgc3dpdGNoaW5nDQo+ID4gPiA+IGltcGxlbWVudGVkIGJ5DQo+ID4gPiBjb3Jl
Lg0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IEkgZG9uJ3QgdGhpbmsgdGhpcyBpcyBhIGdvb2Qgd2F5
IHRvIGdvIGFib3V0IGl0LiBEbyB5b3UgKHRoZSBnbHVlDQo+ID4gPiBkcml2ZXIpIGNyZWF0ZSBh
IHJvbGUgc3dpdGNoIHN0cnVjdHVyZSBhbmQgcmVnaXN0ZXIgdG8gdGhlIHNhbWUgcm9sZQ0KPiA+
ID4gc3dpdGNoIGRldmljZSB0aGF0IHRoZSBkd2MzIGNvcmUgd291bGQgcmVnaXN0ZXIgbGF0ZXI/
IEkgZGlkIG5vdA0KPiA+ID4gZXhwZWN0IHRoYXQgdG8gd29yayBhdCBhbGwuDQo+ID4gPg0KPiA+
IEluIG91ciBhcHBsaWNhdGlvbiwgdGhpcyByb2xlIHN3aXRjaCBpbiB0aGUgZ2x1ZSBkcml2ZXIg
d29ya3MgZmluZS4NCj4gDQo+IElzIHRoZSBvcmRlciBvZiBvcGVyYXRpb24gYmV0d2VlbiB0aGUg
c3dpdGNoIGZyb20gdGhlIGNvcmUgdnMgdGhlIGdsdWUNCj4gZGV0ZXJtaW5hdGU/IEFsc28sIHdo
aWNoIG9wZXJhdGlvbiBzaG91bGQgaGFwcGVuIGZpcnN0PyBJdCdzIG5vdCBjbGVhciBob3cgeW91
DQo+IGhhbmRsZSBpdCBoZXJlLg0KDQpXZSBoYXZlIGEgdHlwZSBjIGRyaXZlciB0aGF0IGZpcnN0
IGNhbGxzIHJvbGUgc3dpdGNoIGluIGdsdWUuDQpUaGUgcm9sZSBzd2l0Y2hpbmcgZnVuY3Rpb24g
aW4gZ2x1ZSB3aWxsIGNhbGwgdGhlIHJvbGUgc3dpdGNoaW5nIGZ1bmN0aW9uIGluIGNvcmUuDQoN
ClR5cGUgYyBkcml2ZXIgc2V0dGluZyBzd2l0Y2ggcm9sZSBmdW5jdGlvbjoNCiAgICAgIHwtLS0t
PiBTZXQgcm9sZSBpbiB0aGUgZ2x1ZQ0KICAgICAgICAgICAgICAgICAgIHwtLS0tPiBTZXQgcm9s
ZXMgaW4gdGhlIGNvcmUNCiAgICAgICAgICAgICAgICAgICB8LS0tLT4gc3dpdGNoX3VzYjJfZHJf
bW9kZSBpbiBnbHVlDQoNCj4gPg0KPiA+ID4gSG93IGFib3V0IHdlIGNyZWF0ZSBhIGNvdXBsZSBv
cHMgY2FsbGJhY2tzIHRvIGR3YzMgc3RydWN0dXJlLiBPbmUgdG8NCj4gPiA+IGluaXRpYWxpemUg
Z2FkZ2V0IGFuZCB0aGUgb3RoZXIgZm9yIGhvc3QuIFNob3VsZCBhbnkgcGxhdGZvcm0NCj4gPiA+
IHNwZWNpZmljIGRldmljZSBuZWVkIHNvbWUgaW50aWFsaXphdGlvbiBiZWZvcmUgaW5pdGlhbGl6
aW5nIHRoZQ0KPiA+ID4gc3BlY2lmaWMgcm9sZSwgd2UgY2FuIGludm9rZSB0aGVzZSBjYWxsYmFj
a3MuDQo+ID4gPg0KPiA+ID4gZS5nLjoNCj4gPiA+DQo+ID4gPiBzdHJ1Y3QgZHdjM19nbHVlX29w
cyB7DQo+ID4gPiAgICAgICAgIGludCAoKmluaXRfZ2FkZ2V0KShzdHJ1Y3QgZHdjMyAqZHdjKTsN
Cj4gPiA+ICAgICAgICAgaW50ICgqaW5pdF9ob3N0KShzdHJ1Y3QgZHdjMyAqZHdjKTsgfQ0KPiA+
ID4NCj4gPiA+IHN0cnVjdCBkd2MzIHsNCj4gPiA+ICAgICAgICAgLi4NCj4gPiA+ICAgICAgICAg
Y29uc3Qgc3RydWN0IGR3YzNfZ2x1ZV9vcHMgICAgICAqb3BzOw0KPiA+ID4gfQ0KPiA+ID4NCj4g
PiA+DQo+ID4gPiBzdGF0aWMgaW50IGR3YzNfZ2x1ZV9pbml0X2dhZGdldChzdHJ1Y3QgZHdjMyAq
ZHdjKSB7DQo+ID4gPiAgICAgICAgIGlmICghZHdjLT5vcHMtPmluaXRfZ2FkZ2V0KQ0KPiA+ID4g
ICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ID4NCj4gPiA+ICAgICAgICAgcmV0dXJuIGR3
Yy0+b3BzLT5pbml0X2dhZGdldChkd2MpOyB9DQo+ID4gPg0KPiA+ID4gc3RhdGljIGludCBkd2Mz
X2dsdWVfaW5pdF9ob3N0KHN0cnVjdCBkd2MzICpkd2MpIHsNCj4gPiA+ICAgICAgICAgaWYgKCFk
d2MtPm9wcy0+aW5pdF9ob3N0KQ0KPiA+ID4gICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+
ID4NCj4gPiA+ICAgICAgICAgcmV0dXJuIGR3Yy0+b3BzLT5pbml0X2hvc3QoZHdjKTsgfQ0KPiA+
ID4NCj4gPiA+DQo+ID4gPiBZb3VyIGdsdWUgZHJpdmVyIHdvdWxkIGltcGxlbWVudCB0aGVzZSBj
YWxsYmFja3MuIEluDQo+ID4gPiBkd2MzX2dhZGdldF9pbml0KCkgYW5kIGR3YzNfaG9zdF9pbml0
KCksIHdlIGNhbiBjYWxsIHRoZXNlIGNhbGxiYWNrcw0KPiA+ID4gYXQgc3RhcnQuIEkgYWRtaXQg
dGhhdCB0aGlzIG1heSBub3QgYmUgdGhlIGdyZWF0ZXN0IHNvbHV0aW9uIHNpbmNlDQo+ID4gPiBp
dCB3b3VsZCByZXF1aXJlIHRoZSBnbHVlIGRyaXZlciB0byBhbGxvYyBhbmQgcmVnaXN0ZXIgYSBk
d2MzDQo+ID4gPiBwbGF0Zm9ybSBkZXZpY2UuIEJ1dCBJIHRoaW5rIHNob3VsZCBiZSBvay4gSWYg
YW55b25lIGVsc2UgY2FuIGNoaW1lIGluIGZvcg0KPiBtb3JlIGlkZWEsIGl0J2QgYmUgZ3JlYXQu
DQo+ID4NCj4gPg0KPiA+IFRoYW5rcyBmb3IgeW91ciBhZHZpY2UuDQo+ID4gSGVyZSBpcyBhIHNv
bHV0aW9uLiBBcyB5b3UncmUgY29uY2VybmVkLCBpdCBtdXN0IHJlZ2lzdGVyIGNhbGxiYWNrcyB3
aXRoIHRoZQ0KPiBjb3JlIGRyaXZlci4gSXQgbG9va3MgYSBiaXQgY29tcGxpY2F0ZWQuDQo+ID4g
SSBub3RpY2VkIHRoZSBwaHlfc2V0X21vZGUgYXBpLg0KPiA+IE1heWJlIEkgY2FuIHRyeSB0byBt
b3ZlIHN3aXRjaF91c2IyX2RyX21vZGUgdG8gcGh5IGRyaXZlci4NCj4gPg0KPiA+IHBoeV9zZXRf
bW9kZShkd2MtPnVzYjJfZ2VuZXJpY19waHksIFBIWV9NT0RFX1VTQl9IT1NUKTsNCj4gPiBwaHlf
c2V0X21vZGUoZHdjLT51c2IyX2dlbmVyaWNfcGh5LCBQSFlfTU9ERV9VU0JfREVWSUNFKTsNCj4g
Pg0KPiANCj4gSSdtIGNvbmNlcm4gaWYgdGhlcmUgYXJlIG90aGVyIHVud2FudGVkIHNpZGUgZWZm
ZWN0cyB0aGlzIG1heSBoYXZlIHRvIG90aGVyDQo+IHBsYXRmb3Jtcy4NCg0KDQpJIGRpZG4ndCBh
ZGQgYW55IG5ldyBwaHlfc2V0X21vZGUgdG8gZHdjMy9jb3JlLg0KSSBtZWFuIHVzZSBleGlzdGlu
ZyBjYWxsYmFjaywgYXMgZm9sbG93cw0KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgv
djYuNC44L3NvdXJjZS9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyNMMjAzDQoNCg0KVGhhbmtzLA0K
U3RhbmxleQ0K
