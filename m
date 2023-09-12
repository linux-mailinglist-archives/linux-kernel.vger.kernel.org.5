Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03B479C449
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbjILDkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbjILDkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:40:09 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 40771CA;
        Mon, 11 Sep 2023 20:40:05 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38C3dlokF2088805, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38C3dlokF2088805
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 11:39:47 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 12 Sep 2023 11:39:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 12 Sep 2023 11:39:46 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c]) by
 RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c%5]) with mapi id
 15.01.2375.007; Tue, 12 Sep 2023 11:39:46 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 RESEND 1/2] usb: dwc3: core: configure TX/RX threshold for DWC3_IP
Thread-Topic: [PATCH v2 RESEND 1/2] usb: dwc3: core: configure TX/RX threshold
 for DWC3_IP
Thread-Index: AQHZ2XPLXhNkYatA80OF+c6YFdmS4bAV2rkAgAC24zD//4kEgIAAh2kA
Date:   Tue, 12 Sep 2023 03:39:46 +0000
Message-ID: <dfe06de8a0ab44bca5b1bb51a342f5e7@realtek.com>
References: <20230828055212.5600-1-stanley_chang@realtek.com>
 <20230911234408.xb5higafb6ssajyt@synopsys.com>
 <567f066c59de49e88dec4bae459d1dcc@realtek.com>
 <20230912033256.g3ya63yg4duxe22h@synopsys.com>
In-Reply-To: <20230912033256.g3ya63yg4duxe22h@synopsys.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhpbmgsDQoNCj4gPiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3
YzMvY29yZS5jIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiA+ID4gaW5kZXgNCj4gPiA+
ID4gOWM2YmYwNTRmMTVkLi4xZjc0YTUzODE2YzMgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZl
cnMvdXNiL2R3YzMvY29yZS5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5j
DQo+ID4gPiA+IEBAIC0xMjQ2LDYgKzEyNDYsMzkgQEAgc3RhdGljIGludCBkd2MzX2NvcmVfaW5p
dChzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiA+ID4gPiAgICAgICAgICAgICAgIH0NCj4gPiA+ID4gICAg
ICAgfQ0KPiA+ID4gPg0KPiA+ID4gPiArICAgICBpZiAoRFdDM19JUF9JUyhEV0MzKSkgew0KPiA+
ID4NCj4gPiA+IFdvdWxkIHlvdSBtaW5kIGFsc28gYWRkIHRoZSBjaGVja3MgZm9yIERXQ191c2Iz
MSBhbmQgRFdDX3VzYjMyPw0KPiBCb3RoDQo+ID4gPiB0aGUNCj4gPiA+IERXQ191c2IzMSBhbmQg
RFdDX3VzYjMyIHNoYXJlIHRoZSBzYW1lIGZpZWxkIG9mZnNldHMgd2l0aGluDQo+ID4gPiBHVFgv
UlhUSFJDRkcgcmVnaXN0ZXJzLiBUaGUgbWFjcm9zIGFyZSBhbHJlYWR5IGRlZmluZWQgZm9yIHRo
b3NlIElQcy4NCj4gPg0KPiA+IERXQzMgYW5kIERXQzMxLCBEV0MzMiBzZWVtIHRvIGhhdmUgZGlm
ZmVyZW50IHJlZ2lzdGVyIGRlZmluaXRpb24gYXMNCj4gZm9sbG93cy4NCj4gDQo+IFllcy4gVGhh
dCdzIHdoYXQgSSBtZWFudC4gVGhleSBhcmUgYWxyZWFkeSBkZWZpbmUgaW4gdGhlIGNvcmUuaCBm
b3IgRFdDX3VzYjMxLg0KPiBEV0NfdXNiMzIgYWxzbyBzaGFyZXMgdGhlIHNhbWUgb2Zmc2V0cyBh
cyBEV0NfdXNiMzEgZm9yIHRoaXMuDQo+IENhbiB5b3UgYWxzbyBpbmNsdWRlIHRoZSBzZXR0aW5n
IG9mIEdUWC9SWFRIUkNGRyBsb2dpYyBmb3IgdGhvc2UgMiBJUHM/DQo+IA0KSSB1bmRlcnN0YW5k
LiBJIHdpbGwgYWRkIHRoZW0uDQoNClRoYW5rcywNClN0YW5sZXkNCg==
