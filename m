Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E58773731
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjHHC7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjHHC7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:59:05 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B501E10CC;
        Mon,  7 Aug 2023 19:59:02 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3782wUpzD029217, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3782wUpzD029217
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 8 Aug 2023 10:58:30 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 8 Aug 2023 10:58:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 8 Aug 2023 10:58:17 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 8 Aug 2023 10:58:17 +0800
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
Thread-Index: AQHZxFokPxd4W07ijUGGBrmKl0qPKq/VrnaAgADyIuCAAIy6gIAA9MlwgACO44CABeKOsIAAc0MAgACusCA=
Date:   Tue, 8 Aug 2023 02:58:17 +0000
Message-ID: <f38e2a4cb00d40429bf3504a183bbc83@realtek.com>
References: <20230801092541.25261-1-stanley_chang@realtek.com>
 <20230802011400.v4jim6ajsqc3tvei@synopsys.com>
 <ff9ca6f15936450696bff502c0047708@realtek.com>
 <20230803000417.qfuwsx5we5a7lfvd@synopsys.com>
 <7d47cbfdbc31436b89d3d92bf980c8fa@realtek.com>
 <20230803231156.laggnj5bzuhugwfd@synopsys.com>
 <ae619edfcce545b78697c6bcdadfff27@realtek.com>
 <20230807235636.mlos5tpeg5foymnz@synopsys.com>
In-Reply-To: <20230807235636.mlos5tpeg5foymnz@synopsys.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhpbmgsDQoNCj4gT24gTW9uLCBBdWcgMDcsIDIwMjMsIFN0YW5sZXkgQ2hhbmdb5piM6IKy
5b63XSB3cm90ZToNCj4gPiBIaSBUaGluaCwNCj4gPg0KPiA+ID4gPiA+ID4gPiA+ICtzdGF0aWMg
aW50IGR3YzNfcnRrX3NldHVwX3JvbGVfc3dpdGNoKHN0cnVjdCBkd2MzX3J0aw0KPiA+ID4gPiA+
ID4gPiA+ICsqcnRrKQ0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBBbnkgcmVhc29uIHdo
eSB3ZSdyZSBkb2luZyB0aGUgcm9sZSBzd2l0Y2ggaGVyZSBhbmQgbm90DQo+ID4gPiA+ID4gPiA+
IHdoYXQncyBpbXBsZW1lbnRlZCBmcm9tIHRoZSBjb3JlPw0KPiA+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gQmVjYXVzZSB3ZSBoYXZlIHRvIHNldCB0aGUgdXNiIDIuMCBwaHkgbW9kZSB0aHJvdWdo
DQo+ID4gPiA+ID4gPiBzd2l0Y2hfdXNiMl9kcl9tb2RlDQo+ID4gPiA+ID4gaW4gdGhlIGZ1bmN0
aW9uIGR3YzNfcnRrX3NldF9kcl9tb2RlLg0KPiA+ID4gPiA+ID4gSW4gZmFjdCwgc3dpdGNoX2R3
YzNfZHJfbW9kZSB3aWxsIHVzZSB0aGUgcm9sZSBzd2l0Y2hpbmcNCj4gPiA+ID4gPiA+IGltcGxl
bWVudGVkIGJ5DQo+ID4gPiA+ID4gY29yZS4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiBJIGRvbid0IHRoaW5rIHRoaXMgaXMgYSBnb29kIHdheSB0byBnbyBhYm91dCBpdC4gRG8g
eW91ICh0aGUNCj4gPiA+ID4gPiBnbHVlDQo+ID4gPiA+ID4gZHJpdmVyKSBjcmVhdGUgYSByb2xl
IHN3aXRjaCBzdHJ1Y3R1cmUgYW5kIHJlZ2lzdGVyIHRvIHRoZSBzYW1lDQo+ID4gPiA+ID4gcm9s
ZSBzd2l0Y2ggZGV2aWNlIHRoYXQgdGhlIGR3YzMgY29yZSB3b3VsZCByZWdpc3RlciBsYXRlcj8g
SQ0KPiA+ID4gPiA+IGRpZCBub3QgZXhwZWN0IHRoYXQgdG8gd29yayBhdCBhbGwuDQo+ID4gPiA+
ID4NCj4gPiA+ID4gSW4gb3VyIGFwcGxpY2F0aW9uLCB0aGlzIHJvbGUgc3dpdGNoIGluIHRoZSBn
bHVlIGRyaXZlciB3b3JrcyBmaW5lLg0KPiA+ID4NCj4gPiA+IElzIHRoZSBvcmRlciBvZiBvcGVy
YXRpb24gYmV0d2VlbiB0aGUgc3dpdGNoIGZyb20gdGhlIGNvcmUgdnMgdGhlDQo+ID4gPiBnbHVl
IGRldGVybWluYXRlPyBBbHNvLCB3aGljaCBvcGVyYXRpb24gc2hvdWxkIGhhcHBlbiBmaXJzdD8g
SXQncw0KPiA+ID4gbm90IGNsZWFyIGhvdyB5b3UgaGFuZGxlIGl0IGhlcmUuDQo+ID4NCj4gPiBX
ZSBoYXZlIGEgdHlwZSBjIGRyaXZlciB0aGF0IGZpcnN0IGNhbGxzIHJvbGUgc3dpdGNoIGluIGds
dWUuDQo+ID4gVGhlIHJvbGUgc3dpdGNoaW5nIGZ1bmN0aW9uIGluIGdsdWUgd2lsbCBjYWxsIHRo
ZSByb2xlIHN3aXRjaGluZyBmdW5jdGlvbiBpbg0KPiBjb3JlLg0KPiANCj4gSG93IGRvIHdlIGtu
b3cgdGhhdD8gWW91J3JlIHJlZ2lzdGVyaW5nIHRvIHRoZSBzYW1lIHN3aXRjaCBkZXZpY2UsIHdv
dWxkbid0DQo+IHRoZSBzd2l0Y2ggZXZlbnQgbm90aWZ5IHRoZSBzd2l0Y2ggd29yayBpbiBib3Ro
IHRoZSBnbHVlIGFuZCB0aGUgY29yZT8gUGVyaGFwcw0KPiBJJ20gbWlzc2luZyBzb21ldGhpbmcg
aGVyZSwgYnV0IGlzIHRoZXJlIHNvbWUgbWVjaGFuaXNtIHRoYXQgd2FpdHMgZm9yIHRoZQ0KPiBz
d2l0Y2ggd29yayBmcm9tIHRoZSBnbHVlIHRvIGNvbXBsZXRlIGJlZm9yZSB0aGUgY29yZS4NCg0K
Rmlyc3QsIHRoZSBzd2l0Y2hlcyBpbiBnbHVlIGFuZCBjb3JlIGFyZSBkaWZmZXJlbnQgZGV2aWNl
cy4NCkluIHRoZSB0eXBlLWMgZHJpdmVyLCB3ZSBvbmx5IG5vdGlmeSB0aGUgc3dpdGNoIGluIHRo
ZSBnbHVlLg0KVGhlbiwgdGhlIHN3aXRjaCBpbiB0aGUgZ2x1ZSBjYWxscyB0aGUgc3dpdGNoIGlu
IHRoZSBjb3JlIHRvIGNoYW5nZSByb2xlcy4NClRoaXMgaXMgYSBzZXF1ZW50aWFsIHByb2Nlc3Mu
IFNvIHRoZXJlIGlzIG5vIG9yZGVyIHByb2JsZW0uDQoNClRoYW5rcywNClN0YW5sZXkNCg==
