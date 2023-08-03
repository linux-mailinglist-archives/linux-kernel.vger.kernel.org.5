Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE9476E095
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 08:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbjHCG4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 02:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjHCG4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 02:56:32 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47B761B2;
        Wed,  2 Aug 2023 23:56:30 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3736tv4N3029753, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3736tv4N3029753
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 3 Aug 2023 14:55:57 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 3 Aug 2023 14:55:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 3 Aug 2023 14:55:58 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 3 Aug 2023 14:55:58 +0800
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
Thread-Index: AQHZxFokPxd4W07ijUGGBrmKl0qPKq/VrnaAgADyIuCAAIy6gIAA9Mlw
Date:   Thu, 3 Aug 2023 06:55:58 +0000
Message-ID: <7d47cbfdbc31436b89d3d92bf980c8fa@realtek.com>
References: <20230801092541.25261-1-stanley_chang@realtek.com>
 <20230802011400.v4jim6ajsqc3tvei@synopsys.com>
 <ff9ca6f15936450696bff502c0047708@realtek.com>
 <20230803000417.qfuwsx5we5a7lfvd@synopsys.com>
In-Reply-To: <20230803000417.qfuwsx5we5a7lfvd@synopsys.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhpbmgsDQoNCj4gPiA+ID4gK3N0YXRpYyBpbnQgZHdjM19ydGtfc2V0dXBfcm9sZV9zd2l0
Y2goc3RydWN0IGR3YzNfcnRrICpydGspDQo+ID4gPg0KPiA+ID4gQW55IHJlYXNvbiB3aHkgd2Un
cmUgZG9pbmcgdGhlIHJvbGUgc3dpdGNoIGhlcmUgYW5kIG5vdCB3aGF0J3MNCj4gPiA+IGltcGxl
bWVudGVkIGZyb20gdGhlIGNvcmU/DQo+ID4gPg0KPiA+IEJlY2F1c2Ugd2UgaGF2ZSB0byBzZXQg
dGhlIHVzYiAyLjAgcGh5IG1vZGUgdGhyb3VnaCBzd2l0Y2hfdXNiMl9kcl9tb2RlDQo+IGluIHRo
ZSBmdW5jdGlvbiBkd2MzX3J0a19zZXRfZHJfbW9kZS4NCj4gPiBJbiBmYWN0LCBzd2l0Y2hfZHdj
M19kcl9tb2RlIHdpbGwgdXNlIHRoZSByb2xlIHN3aXRjaGluZyBpbXBsZW1lbnRlZCBieQ0KPiBj
b3JlLg0KPiA+DQo+IA0KPiBJIGRvbid0IHRoaW5rIHRoaXMgaXMgYSBnb29kIHdheSB0byBnbyBh
Ym91dCBpdC4gRG8geW91ICh0aGUgZ2x1ZQ0KPiBkcml2ZXIpIGNyZWF0ZSBhIHJvbGUgc3dpdGNo
IHN0cnVjdHVyZSBhbmQgcmVnaXN0ZXIgdG8gdGhlIHNhbWUgcm9sZSBzd2l0Y2gNCj4gZGV2aWNl
IHRoYXQgdGhlIGR3YzMgY29yZSB3b3VsZCByZWdpc3RlciBsYXRlcj8gSSBkaWQgbm90IGV4cGVj
dCB0aGF0IHRvIHdvcmsgYXQNCj4gYWxsLg0KPiANCkluIG91ciBhcHBsaWNhdGlvbiwgdGhpcyBy
b2xlIHN3aXRjaCBpbiB0aGUgZ2x1ZSBkcml2ZXIgd29ya3MgZmluZS4NCg0KPiBIb3cgYWJvdXQg
d2UgY3JlYXRlIGEgY291cGxlIG9wcyBjYWxsYmFja3MgdG8gZHdjMyBzdHJ1Y3R1cmUuIE9uZSB0
bw0KPiBpbml0aWFsaXplIGdhZGdldCBhbmQgdGhlIG90aGVyIGZvciBob3N0LiBTaG91bGQgYW55
IHBsYXRmb3JtIHNwZWNpZmljIGRldmljZQ0KPiBuZWVkIHNvbWUgaW50aWFsaXphdGlvbiBiZWZv
cmUgaW5pdGlhbGl6aW5nIHRoZSBzcGVjaWZpYyByb2xlLCB3ZSBjYW4gaW52b2tlDQo+IHRoZXNl
IGNhbGxiYWNrcy4NCj4gDQo+IGUuZy46DQo+IA0KPiBzdHJ1Y3QgZHdjM19nbHVlX29wcyB7DQo+
ICAgICAgICAgaW50ICgqaW5pdF9nYWRnZXQpKHN0cnVjdCBkd2MzICpkd2MpOw0KPiAgICAgICAg
IGludCAoKmluaXRfaG9zdCkoc3RydWN0IGR3YzMgKmR3Yyk7IH0NCj4gDQo+IHN0cnVjdCBkd2Mz
IHsNCj4gICAgICAgICAuLg0KPiAgICAgICAgIGNvbnN0IHN0cnVjdCBkd2MzX2dsdWVfb3BzICAg
ICAgKm9wczsNCj4gfQ0KPiANCj4gDQo+IHN0YXRpYyBpbnQgZHdjM19nbHVlX2luaXRfZ2FkZ2V0
KHN0cnVjdCBkd2MzICpkd2MpIHsNCj4gICAgICAgICBpZiAoIWR3Yy0+b3BzLT5pbml0X2dhZGdl
dCkNCj4gICAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiANCj4gICAgICAgICByZXR1cm4gZHdj
LT5vcHMtPmluaXRfZ2FkZ2V0KGR3Yyk7IH0NCj4gDQo+IHN0YXRpYyBpbnQgZHdjM19nbHVlX2lu
aXRfaG9zdChzdHJ1Y3QgZHdjMyAqZHdjKSB7DQo+ICAgICAgICAgaWYgKCFkd2MtPm9wcy0+aW5p
dF9ob3N0KQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+IA0KPiAgICAgICAgIHJldHVy
biBkd2MtPm9wcy0+aW5pdF9ob3N0KGR3Yyk7IH0NCj4gDQo+IA0KPiBZb3VyIGdsdWUgZHJpdmVy
IHdvdWxkIGltcGxlbWVudCB0aGVzZSBjYWxsYmFja3MuIEluIGR3YzNfZ2FkZ2V0X2luaXQoKSBh
bmQNCj4gZHdjM19ob3N0X2luaXQoKSwgd2UgY2FuIGNhbGwgdGhlc2UgY2FsbGJhY2tzIGF0IHN0
YXJ0LiBJIGFkbWl0IHRoYXQgdGhpcyBtYXkgbm90DQo+IGJlIHRoZSBncmVhdGVzdCBzb2x1dGlv
biBzaW5jZSBpdCB3b3VsZCByZXF1aXJlIHRoZSBnbHVlIGRyaXZlciB0byBhbGxvYyBhbmQNCj4g
cmVnaXN0ZXIgYSBkd2MzIHBsYXRmb3JtIGRldmljZS4gQnV0IEkgdGhpbmsgc2hvdWxkIGJlIG9r
LiBJZiBhbnlvbmUgZWxzZSBjYW4NCj4gY2hpbWUgaW4gZm9yIG1vcmUgaWRlYSwgaXQnZCBiZSBn
cmVhdC4NCg0KDQpUaGFua3MgZm9yIHlvdXIgYWR2aWNlLg0KSGVyZSBpcyBhIHNvbHV0aW9uLiBB
cyB5b3UncmUgY29uY2VybmVkLCBpdCBtdXN0IHJlZ2lzdGVyIGNhbGxiYWNrcyB3aXRoIHRoZSBj
b3JlIGRyaXZlci4gSXQgbG9va3MgYSBiaXQgY29tcGxpY2F0ZWQuDQpJIG5vdGljZWQgdGhlIHBo
eV9zZXRfbW9kZSBhcGkuDQpNYXliZSBJIGNhbiB0cnkgdG8gbW92ZSBzd2l0Y2hfdXNiMl9kcl9t
b2RlIHRvIHBoeSBkcml2ZXIuDQoNCnBoeV9zZXRfbW9kZShkd2MtPnVzYjJfZ2VuZXJpY19waHks
IFBIWV9NT0RFX1VTQl9IT1NUKTsNCnBoeV9zZXRfbW9kZShkd2MtPnVzYjJfZ2VuZXJpY19waHks
IFBIWV9NT0RFX1VTQl9ERVZJQ0UpOw0KDQpUaGFua3MsDQpTdGFubGV5DQo=
