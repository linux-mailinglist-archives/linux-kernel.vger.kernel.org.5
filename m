Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B2D7E77AF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345774AbjKJCnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345662AbjKJCnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:43:49 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396F8133;
        Thu,  9 Nov 2023 18:43:46 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AA2hdgA71946567, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AA2hdgA71946567
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 10:43:39 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 10 Nov 2023 10:43:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 10 Nov 2023 10:43:39 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 10 Nov 2023 10:43:38 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1] usb: dwc3: add device put function to decrement the ref-counted reference
Thread-Topic: [PATCH v1] usb: dwc3: add device put function to decrement the
 ref-counted reference
Thread-Index: AQHaEVqWcz3GNmQjYUqtWzr6T0MhhrByVAEAgACHE7A=
Date:   Fri, 10 Nov 2023 02:43:38 +0000
Message-ID: <4721829510e04b12bdb3c38f406b9584@realtek.com>
References: <20231107091252.11783-1-stanley_chang@realtek.com>
 <20231110023419.nds42y4nmevpk75b@synopsys.com>
In-Reply-To: <20231110023419.nds42y4nmevpk75b@synopsys.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGhpbmggTmd1eWVuIDxU
aGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDEwLCAy
MDIzIDEwOjM0IEFNDQo+IFRvOiBTdGFubGV5IENoYW5nW+aYjOiCsuW+t10gPHN0YW5sZXlfY2hh
bmdAcmVhbHRlay5jb20+DQo+IENjOiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5
cy5jb20+OyBDaHJpc3RvcGhlIEpBSUxMRVQNCj4gPGNocmlzdG9waGUuamFpbGxldEB3YW5hZG9v
LmZyPjsgR3JlZyBLcm9haC1IYXJ0bWFuDQo+IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47
IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MV0gdXNiOiBkd2MzOiBhZGQgZGV2aWNlIHB1dCBm
dW5jdGlvbiB0byBkZWNyZW1lbnQgdGhlDQo+IHJlZi1jb3VudGVkIHJlZmVyZW5jZQ0KPiANCj4g
DQo+IEV4dGVybmFsIG1haWwuDQo+IA0KPiANCj4gDQo+IE9uIFR1ZSwgTm92IDA3LCAyMDIzLCBT
dGFubGV5IENoYW5nIHdyb3RlOg0KPiA+IFdoZW4gdGhlIGZ1bmN0aW9uIGV4aXRzLCB0aGUgY291
bnQgc2hvdWxkIGJlIGRlY3JlbWVudGVkIHZpYQ0KPiA+IHBsYXRmb3JtX2RldmljZV9wdXQgYW5k
IG9mX25vZGVfcHV0Lg0KPiA+DQo+ID4gRml4ZXM6IDM0YzIwMDQ4MzU2OSAoInVzYjogZHdjMzog
YWRkIFJlYWx0ZWsgREhDIFJURCBTb0MgZHdjMyBnbHVlDQo+ID4gbGF5ZXIgZHJpdmVyIikNCj4g
PiBTaWduZWQtb2ZmLWJ5OiBTdGFubGV5IENoYW5nIDxzdGFubGV5X2NoYW5nQHJlYWx0ZWsuY29t
Pg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3VzYi9kd2MzL2R3YzMtcnRrLmMgfCAzICsrKw0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvZHdjMy9kd2MzLXJ0ay5jIGIvZHJpdmVycy91c2IvZHdjMy9kd2MzLXJ0ay5j
DQo+ID4gaW5kZXggNTkwMDI4ZThmZGNiLi45ZDZmMmE4YmQ2Y2UgMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy91c2IvZHdjMy9kd2MzLXJ0ay5jDQo+ID4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9k
d2MzLXJ0ay5jDQo+ID4gQEAgLTE4Nyw2ICsxODcsNyBAQCBzdGF0aWMgZW51bSB1c2JfZGV2aWNl
X3NwZWVkDQo+ID4gX19nZXRfZHdjM19tYXhpbXVtX3NwZWVkKHN0cnVjdCBkZXZpY2Vfbm9kZSAq
bnApDQo+ID4NCj4gPiAgICAgICByZXQgPSBtYXRjaF9zdHJpbmcoc3BlZWRfbmFtZXMsIEFSUkFZ
X1NJWkUoc3BlZWRfbmFtZXMpLA0KPiA+IG1heGltdW1fc3BlZWQpOw0KPiA+DQo+ID4gKyAgICAg
b2Zfbm9kZV9wdXQoZHdjM19ucCk7DQo+ID4gICAgICAgcmV0dXJuIChyZXQgPCAwKSA/IFVTQl9T
UEVFRF9VTktOT1dOIDogcmV0OyAgfQ0KPiA+DQo+ID4gQEAgLTMzOSw2ICszNDAsOCBAQCBzdGF0
aWMgaW50IGR3YzNfcnRrX3Byb2JlX2R3YzNfY29yZShzdHJ1Y3QNCj4gPiBkd2MzX3J0ayAqcnRr
KQ0KPiA+DQo+ID4gICAgICAgc3dpdGNoX3VzYjJfcm9sZShydGssIHJ0ay0+Y3VyX3JvbGUpOw0K
PiA+DQo+ID4gKyAgICAgcGxhdGZvcm1fZGV2aWNlX3B1dChkd2MzX3BkZXYpOw0KPiANCj4gRG9u
J3QgeW91IHVzZSB0aGlzIGFmdGVyIHByb2JlPyBXaHkgcHV0IGhlcmUgYW5kIG5vdCBvbiByZW1v
dmU/DQoNCkkgZG9uJ3QgdXNlIGR3YzNfcGRldiBpbiBkcml2ZXIuDQpJIHVzZSBydGstPmR3YyBh
bmQgZHdjIGlzIHJlbW92ZWQgYnkgb2ZfcGxhdGZvcm1fZGVwb3B1bGF0ZSBvbiByZW1vdmUuDQpT
byBJIHRoaW5rIEkgZG9uJ3QgbmVlZCB0byBrZWVwIHRoZSBjb3VudCBvZiBkd2MzX3BkZXYuDQoN
ClRoYW5rcywNClN0YW5sZXkNCg0KPiANCj4gQlIsDQo+IFRoaW5oDQo+IA0KPiA+ICsgICAgIG9m
X25vZGVfcHV0KGR3YzNfbm9kZSk7DQo+ID4gICAgICAgcmV0dXJuIDA7DQo+ID4NCj4gPiAgZXJy
X3BkZXZfcHV0Og0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4NCg==
