Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3712B7E01CA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377690AbjKCKzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347241AbjKCKy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:54:58 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61559D7;
        Fri,  3 Nov 2023 03:54:51 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A3AsRIl9092021, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A3AsRIl9092021
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Nov 2023 18:54:27 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 3 Nov 2023 18:54:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 3 Nov 2023 18:54:26 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 3 Nov 2023 18:54:26 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     "Thinh.Nguyen@synopsys.com" <Thinh.Nguyen@synopsys.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: RE: [PATCH v6 1/2] usb: dwc3: add Realtek DHC RTD SoC dwc3 glue layer driver
Thread-Topic: RE: [PATCH v6 1/2] usb: dwc3: add Realtek DHC RTD SoC dwc3 glue
 layer driver
Thread-Index: AQHZ18re3VzH2NdIJ0+XVY2ifQSysbBh2g4AgAONr8D//5JCAIAD1jtg
Date:   Fri, 3 Nov 2023 10:54:26 +0000
Message-ID: <da4c75ba87c3476694361ee3bc333401@realtek.com>
References: <20230826031028.1892-1-stanley_chang@realtek.com>
 <202310301424.39UEOShlC2187546@rtits1.realtek.com.tw>
 <bc33c01db5b048899dce5467e7efec74@realtek.com>
 <202311011453.3A1ErwKI3829148@rtits1.realtek.com.tw>
In-Reply-To: <202311011453.3A1ErwKI3829148@rtits1.realtek.com.tw>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
x-kse-antivirus-attachment-filter-interceptor-info: license violation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
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

SGkgQ2hyaXN0b3BoZSwNCg0KPiBMZSAwMS8xMS8yMDIzIMOgIDA3OjI3LCBTdGFubGV5IENoYW5n
W+aYjOiCsuW+t10gYSDDqWNyaXQgOg0KPiA+IEhpIENKLA0KPiA+DQo+ID4gSSB0aGluayB0aGVz
ZSBmdW5jdGlvbnMgYXJlIG5vdCBuZWVkZWQgaW4gcmVtb3ZlIGZ1bmN0aW9uLg0KPiA+DQo+ID4g
SW4gZHdjM19ydGtfcHJvYmVfZHdjM19jb3JlLA0KPiA+IEkgaGF2ZSB1c2VkDQo+ID4gZHdjM19u
b2RlID0gb2ZfZ2V0X2NvbXBhdGlibGVfY2hpbGQobm9kZSwgInNucHMsZHdjMyIpOyBhbmQgZHdj
M19wZGV2DQo+ID4gPSBvZl9maW5kX2RldmljZV9ieV9ub2RlKGR3YzNfbm9kZSk7DQo+ID4NCj4g
PiBTbywgSSBjYWxsIHRoZXNlIHB1dCBmdW5jdGlvbnMuDQo+ID4gcGxhdGZvcm1fZGV2aWNlX3B1
dChkd2MzX3BkZXYpOw0KPiA+IG9mX25vZGVfcHV0KGR3YzNfbm9kZSk7DQo+IA0KPiBZZXMsIGJ1
dCB5b3UgY2FsbCBpdCBvbmx5IGluIHRoZSBlcnJvciBoYW5kbGluZyBwYXRoIG9mIHRoZSBmdW5j
dGlvbi4NCj4gDQo+IEkgd29uZGVyIGlmIHRoZXkgc2hvdWxkIGFsc28gYmUgY2FsbGVkIGluIHRo
ZSByZW1vdmUgZnVuY3Rpb24gaW4gb3JkZXIgdG8NCj4gZGVjcmVtZW50IHRoZSByZWYtY291bnRl
ZCByZWZlcmVuY2UuDQo+IA0KPiANCj4gU2FtZSBpbiBfX2dldF9kd2MzX21heGltdW1fc3BlZWQo
KSwgdGhlIHJlZmVyZW5jZSB0YWtlbiBieToNCj4gICAgIGR3YzNfbnAgPSBvZl9nZXRfY29tcGF0
aWJsZV9jaGlsZChucCwgInNucHMsZHdjMyIpOyBpcyBuZXZlciByZWxlYXNlZC4NCj4gDQo+IA0K
PiBTZWUgdGhlIGNvbW1lbnQgYXQgWzFdIHRvIHNlZSB3aGF0IEkgbWVhbi4NCj4gDQo+IA0KPiBb
MV06IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjYvc291cmNlL2RyaXZlcnMv
b2YvYmFzZS5jI0w2ODENCg0KWW91IGFyZSByaWdodCENCkZvciBkd2MzX3BkZXYsIGR3YzNfbnAg
b3IgZHdjM19ub2RlLCBJIHNob3VsZCBhZGQgb2Zfbm9kZV9wdXQgdG8gcmVsZWFzZSB0aGVtIHdo
ZW4gdGhlIGZ1bmN0aW9uIGV4aXRzLiANCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4
L3Y2LjUuMTAvc291cmNlL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1tZXNvbi1nMTJhLmMjTDU2Nw0K
DQpJIHdpbGwgYWRkIGEgcGF0Y2ggdG8gZml4IHRoaXMuDQoNCkZvciBleGFtcGxlLA0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1ydGsuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdj
My1ydGsuYw0KaW5kZXggNTkwMDI4ZThmZGNiLi45ZDZmMmE4YmQ2Y2UgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL3VzYi9kd2MzL2R3YzMtcnRrLmMNCisrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZHdjMy1y
dGsuYw0KQEAgLTE4Nyw2ICsxODcsNyBAQCBzdGF0aWMgZW51bSB1c2JfZGV2aWNlX3NwZWVkIF9f
Z2V0X2R3YzNfbWF4aW11bV9zcGVlZChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wKQ0KDQogICAgICAg
IHJldCA9IG1hdGNoX3N0cmluZyhzcGVlZF9uYW1lcywgQVJSQVlfU0laRShzcGVlZF9uYW1lcyks
IG1heGltdW1fc3BlZWQpOw0KDQorICAgICAgIG9mX25vZGVfcHV0KGR3YzNfbnApOw0KICAgICAg
ICByZXR1cm4gKHJldCA8IDApID8gVVNCX1NQRUVEX1VOS05PV04gOiByZXQ7DQogfQ0KDQpAQCAt
MzM5LDYgKzM0MCw4IEBAIHN0YXRpYyBpbnQgZHdjM19ydGtfcHJvYmVfZHdjM19jb3JlKHN0cnVj
dCBkd2MzX3J0ayAqcnRrKQ0KDQogICAgICAgIHN3aXRjaF91c2IyX3JvbGUocnRrLCBydGstPmN1
cl9yb2xlKTsNCg0KKyAgICAgICBwbGF0Zm9ybV9kZXZpY2VfcHV0KGR3YzNfcGRldik7DQorICAg
ICAgIG9mX25vZGVfcHV0KGR3YzNfbm9kZSk7DQogICAgICAgIHJldHVybiAwOw0KDQogZXJyX3Bk
ZXZfcHV0Og0KDQoNClRoYW5rcywNClN0YW5sZXkNCg0KPiBDSg0KPiA+DQo+ID4gVGhhbmtzLA0K
PiA+IFN0YW5sZXkNCj4gPg0KPiA+PiBIaSwNCj4gPj4NCj4gPj4gSXMgc29tZXRoaW5nIGxpa2UN
Cj4gPj4gICAgICAgICAgcGxhdGZvcm1fZGV2aWNlX3B1dChkd2MzX3BkZXYpOw0KPiA+PiAgICAg
ICAgICBvZl9ub2RlX3B1dChkd2MzX25vZGUpOw0KPiA+PiBuZWVkZWQgaW4gdGhlIHJlbW92ZSBm
dW5jdGlvbj8NCj4gPj4NCj4gPj4gKGFzIGRvbmUgaW4gdGhlIGVycm9yIGhhbmRsaW5nIHBhdGgg
b2YgZHdjM19ydGtfcHJvYmVfZHdjM19jb3JlKCkpDQo+ID4+DQo+ID4+IE9yIHNob3VsZCBpdCBi
ZSBhZGRlZCBhdCB0aGUgZW5kIG9mIGR3YzNfcnRrX3Byb2JlX2R3YzNfY29yZSgpIGlmIHRoZQ0K
PiA+PiByZWZlcmVuY2UgYXJlIG5vciBuZWVkZWQgYW55bW9yZSB3aGVuIHdlIGxlYXZlIHRoZSBm
dW5jdGlvbj8NCj4gPj4NCj4gPj4gQ0oNCj4gPj4NCj4gPj4+ICsgICAgIG9mX3BsYXRmb3JtX2Rl
cG9wdWxhdGUocnRrLT5kZXYpOyB9DQo+ID4+PiArDQo+ID4+DQo+ID4+IC4uLg0KPiA+DQoNCg==
