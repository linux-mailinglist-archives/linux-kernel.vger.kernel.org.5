Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CE276C853
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjHBI1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbjHBI1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:27:20 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 36361E48;
        Wed,  2 Aug 2023 01:27:18 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3728QaklE004404, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3728QaklE004404
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 2 Aug 2023 16:26:36 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 2 Aug 2023 16:26:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 2 Aug 2023 16:26:50 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Wed, 2 Aug 2023 16:26:50 +0800
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
Thread-Index: AQHZxFokPxd4W07ijUGGBrmKl0qPKq/VrnaAgADyIuA=
Date:   Wed, 2 Aug 2023 08:26:50 +0000
Message-ID: <ff9ca6f15936450696bff502c0047708@realtek.com>
References: <20230801092541.25261-1-stanley_chang@realtek.com>
 <20230802011400.v4jim6ajsqc3tvei@synopsys.com>
In-Reply-To: <20230802011400.v4jim6ajsqc3tvei@synopsys.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhpbmgsDQoNCj4gPiArc3RydWN0IGR3YzNfcnRrIHsNCj4gPiArICAgICBzdHJ1Y3QgZGV2
aWNlICpkZXY7DQo+ID4gKyAgICAgdm9pZCBfX2lvbWVtICpyZWdzOw0KPiA+ICsgICAgIHNpemVf
dCByZWdzX3NpemU7DQo+ID4gKw0KPiA+ICsgICAgIHN0cnVjdCBkd2MzICpkd2M7DQo+ID4gKw0K
PiA+ICsgICAgIGludCBjdXJfZHJfbW9kZTsgLyogY3VycmVudCBkciBtb2RlICovDQo+ID4gKyAg
ICAgYm9vbCBzdXBwb3J0X2RyZF9tb2RlOyAvKiBpZiBzdXBwb3J0IEhvc3QvZGV2aWNlIHN3aXRj
aCAqLw0KPiANCj4gSSB0aGluayB3ZSBtYXkgbm90IG5lZWQgdGhpcyBhbmQgZG8gYXdheSB0aGUg
Ym9vbGVhbiBzdXBwb3J0X2RyZF9tb2RlLg0KDQpZZXMsIHRoZSBpbml0aWFsIGZsb3cgc2hvdWxk
IGJlIHNpbXBsaWZpZWQgYXMNCkBAIC0zNDYsMTIgKzM0Miw3IEBAIHN0YXRpYyBpbnQgZHdjM19y
dGtfcHJvYmVfZHdjM19jb3JlKHN0cnVjdCBkd2MzX3J0ayAqcnRrKQ0KDQogICAgICAgIHJ0ay0+
Y3VyX2RyX21vZGUgPSBkcl9tb2RlOw0KDQotICAgICAgIGlmIChkZXZpY2VfcHJvcGVydHlfcmVh
ZF9ib29sKGR3YzNfZGV2LCAidXNiLXJvbGUtc3dpdGNoIikpDQotICAgICAgICAgICAgICAgcnRr
LT5zdXBwb3J0X2RyZF9tb2RlID0gdHJ1ZTsNCi0gICAgICAgZWxzZQ0KLSAgICAgICAgICAgICAg
IHJ0ay0+c3VwcG9ydF9kcmRfbW9kZSA9IGZhbHNlOw0KLQ0KLSAgICAgICBpZiAocnRrLT5zdXBw
b3J0X2RyZF9tb2RlKSB7DQorICAgICAgIGlmIChkZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKGR3
YzNfZGV2LCAidXNiLXJvbGUtc3dpdGNoIikpIHsNCiAgICAgICAgICAgICAgICBkd2MzX3J0a19z
ZXR1cF9yb2xlX3N3aXRjaChydGspOw0KICAgICAgICAgICAgICAgIHJ0ay0+Y3VyX2RyX21vZGUg
PSBkd2MzX3J0a19nZXRfZHJfbW9kZShydGspOw0KICAgICAgICB9DQoNCj4gPiArc3RhdGljIGlu
dCBkd2MzX3J0a19zZXRfZHJfbW9kZShzdHJ1Y3QgZHdjM19ydGsgKnJ0aywgaW50IGRyX21vZGUp
DQo+IA0KPiBXaHkgcmV0dXJuIHRoZSBtb2RlIHJhdGhlciB0aGFuIHN0YXR1cyBpZiB0aGUgc2V0
dGluZz8gWW91J3JlIG5vdCBjaGVja2luZyB0aGUNCj4gcmV0dXJuIG9mIHRoaXMgZnVuY3Rpb24g
aW4gdGhlIGNhbGxlciBhbnl3YXkuDQoNCllvdSBhcmUgcmlnaHQsIHRoaXMgcmV0dXJuIHZhbHVl
IGlzIHVubmVjZXNzYXJ5Lg0KSSB3aWxsIHJlbW92ZSBpdC4NCg0KPiA+ICt7DQo+ID4gKyAgICAg
aWYgKCFydGstPnN1cHBvcnRfZHJkX21vZGUpDQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gcnRr
LT5jdXJfZHJfbW9kZTsNCj4gPiArDQo+ID4gKyAgICAgcnRrLT5jdXJfZHJfbW9kZSA9IGRyX21v
ZGU7DQo+ID4gKw0KPiA+ICsgICAgIHN3aXRjaF9kd2MzX2RyX21vZGUocnRrLCBkcl9tb2RlKTsN
Cj4gPiArICAgICBtZGVsYXkoMTApOw0KPiA+ICsgICAgIHN3aXRjaF91c2IyX2RyX21vZGUocnRr
LCBkcl9tb2RlKTsNCj4gPiArDQo+ID4gKyAgICAgcmV0dXJuIHJ0ay0+Y3VyX2RyX21vZGU7DQo+
ID4gK30NCj4gPiArDQoNCj4gPiArc3RhdGljIGludCBkd2MzX3J0a19zZXR1cF9yb2xlX3N3aXRj
aChzdHJ1Y3QgZHdjM19ydGsgKnJ0aykNCj4gDQo+IEFueSByZWFzb24gd2h5IHdlJ3JlIGRvaW5n
IHRoZSByb2xlIHN3aXRjaCBoZXJlIGFuZCBub3Qgd2hhdCdzIGltcGxlbWVudGVkDQo+IGZyb20g
dGhlIGNvcmU/DQo+IA0KQmVjYXVzZSB3ZSBoYXZlIHRvIHNldCB0aGUgdXNiIDIuMCBwaHkgbW9k
ZSB0aHJvdWdoIHN3aXRjaF91c2IyX2RyX21vZGUgaW4gdGhlIGZ1bmN0aW9uIGR3YzNfcnRrX3Nl
dF9kcl9tb2RlLg0KSW4gZmFjdCwgc3dpdGNoX2R3YzNfZHJfbW9kZSB3aWxsIHVzZSB0aGUgcm9s
ZSBzd2l0Y2hpbmcgaW1wbGVtZW50ZWQgYnkgY29yZS4NCg0KPiA+ICsNCj4gPiArbW9kdWxlX3Bs
YXRmb3JtX2RyaXZlcihkd2MzX3J0a19kcml2ZXIpOw0KPiA+ICsNCj4gPiArTU9EVUxFX0FVVEhP
UigiU3RhbmxleSBDaGFuZyA8c3RhbmxleV9jaGFuZ0ByZWFsdGVrLmNvbT4iKTsNCj4gPiArTU9E
VUxFX0RFU0NSSVBUSU9OKCJEZXNpZ25XYXJlIFVTQjMgUmVhbHRlayBHbHVlIExheWVyIik7DQo+
ID4gK01PRFVMRV9BTElBUygicGxhdGZvcm06cnRrLWR3YzMiKTsNCj4gPiArTU9EVUxFX0xJQ0VO
U0UoIkdQTCIpOw0KPiANCj4gSSdtIG5vdCBmYW1pbGlhciB3aXRoIGxpY2Vuc2luZyBtdWNoLCBi
dXQgY2FuIHRoZSBTUERYIGhlYWRlciBpbmRpY2F0ZXMNCj4gZGlmZmVyZW50IHZlcnNpb24gdGhh
biB0aGUgbW9kdWxlIGxpY2Vuc2U/DQo+IA0KVGhhbmtzIEdyZWcgZm9yIHlvdXIgY29tbWVudC4N
CkVpdGhlciBHUEwgb3IgR1BMIHYyIGFyZSBzdWl0YWJsZSBmb3Igb3VyIHNvdXJjZSBjb2RlLg0K
DQpUaGFua3MsDQpTdGFubGV5DQoNCg==
