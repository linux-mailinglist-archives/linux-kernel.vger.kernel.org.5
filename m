Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC9F75EBF3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjGXGvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGXGvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:51:06 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C82CD2;
        Sun, 23 Jul 2023 23:51:02 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36O6neaE7018707, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36O6neaE7018707
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 24 Jul 2023 14:49:40 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 24 Jul 2023 14:49:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 24 Jul 2023 14:49:51 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 24 Jul 2023 14:49:51 +0800
From:   =?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?= <stanley_chang@realtek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Roy Luo <royluo@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Ray Chi <raychi@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v7 1/5] usb: phy: add usb phy notify port status API
Thread-Topic: [PATCH v7 1/5] usb: phy: add usb phy notify port status API
Thread-Index: AQHZsJ7kDWGiCOPLRk2HhU7h2LN0sq/H/g6AgACS9CA=
Date:   Mon, 24 Jul 2023 06:49:50 +0000
Message-ID: <47131beec8a24572873aa31e87cfaab6@realtek.com>
References: <20230707064725.25291-1-stanley_chang@realtek.com>
 <2023072452-jasmine-palm-7b73@gregkh>
In-Reply-To: <2023072452-jasmine-palm-7b73@gregkh>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IA0KPiBPbiBGcmksIEp1bCAwNywgMjAyMyBhdCAwMjo0NzowMFBNICswODAwLCBTdGFubGV5
IENoYW5nIHdyb3RlOg0KPiA+IEluIFJlYWx0ZWsgU29DLCB0aGUgcGFyYW1ldGVyIG9mIHVzYiBw
aHkgaXMgZGVzaWduZWQgdG8gY2FuIGR5bmFtaWMNCj4gPiB0dW5pbmcgYmFzZSBvbiBwb3J0IHN0
YXR1cy4gVGhlcmVmb3JlLCBhZGQgYSBub3RpZnkgY2FsbGJhY2sgb2YgcGh5DQo+ID4gZHJpdmVy
IHdoZW4gdXNiIHBvcnQgc3RhdHVzIGNoYW5nZS4NCj4gPg0KPiA+IFRoZSBSZWFsdGVrIHBoeSBk
cml2ZXIgaXMgZGVzaWduZWQgdG8gZHluYW1pY2FsbHkgYWRqdXN0IGRpc2Nvbm5lY3Rpb24NCj4g
PiBsZXZlbCBhbmQgY2FsaWJyYXRlIHBoeSBwYXJhbWV0ZXJzLiBXaGVuIHRoZSBkZXZpY2UgY29u
bmVjdGVkIGJpdA0KPiA+IGNoYW5nZXMgYW5kIHdoZW4gdGhlIGRpc2Nvbm5lY3RlZCBiaXQgY2hh
bmdlcywgZG8gcG9ydCBzdGF0dXMgY2hhbmdlDQo+IG5vdGlmaWNhdGlvbjoNCj4gPg0KPiA+IENo
ZWNrIGlmIHBvcnRzdGF0dXMgaXMgVVNCX1BPUlRfU1RBVF9DT05ORUNUSU9OIGFuZCBwb3J0Y2hh
bmdlIGlzDQo+ID4gVVNCX1BPUlRfU1RBVF9DX0NPTk5FQ1RJT04uDQo+ID4gMS4gVGhlIGRldmlj
ZSBpcyBjb25uZWN0ZWQsIHRoZSBkcml2ZXIgbG93ZXJzIHRoZSBkaXNjb25uZWN0aW9uIGxldmVs
IGFuZA0KPiA+ICAgIGNhbGlicmF0ZXMgdGhlIHBoeSBwYXJhbWV0ZXJzLg0KPiA+IDIuIFRoZSBk
ZXZpY2UgZGlzY29ubmVjdHMsIHRoZSBkcml2ZXIgaW5jcmVhc2VzIHRoZSBkaXNjb25uZWN0IGxl
dmVsIGFuZA0KPiA+ICAgIGNhbGlicmF0ZXMgdGhlIHBoeSBwYXJhbWV0ZXJzLg0KPiA+DQo+ID4g
V2hlbiBjb250cm9sbGVyIHRvIG5vdGlmeSBjb25uZWN0IHRoYXQgZGV2aWNlIGlzIGFscmVhZHkg
cmVhZHkuIElmIHdlDQo+ID4gYWRqdXN0IHRoZSBkaXNjb25uZWN0aW9uIGxldmVsIGluIG5vdGlm
eV9jb25uZWN0LCB0aGUgZGlzY29ubmVjdCBtYXkNCj4gPiBoYXZlIGJlZW4gdHJpZ2dlcmVkIGF0
IHRoaXMgc3RhZ2UuIFNvIHdlIG5lZWQgdG8gY2hhbmdlIHRoYXQgYXMgZWFybHkNCj4gPiBhcyBw
b3NzaWJsZS4gVGhlcmVmb3JlLCB3ZSBhZGQgYW4gYXBpIHRvIG5vdGlmeSBwaHkgdGhlIHBvcnQg
c3RhdHVzIGNoYW5nZXMuDQo+IA0KPiBIb3cgZG8geW91IGtub3cgdGhhdCB0aGUgZGlzY29ubmVj
dCB3aWxsIG5vdCBoYXZlIGFscmVhZHkgYmVlbiB0cmlnZ2VyZWQgYXQNCj4gdGhpcyBwb2ludCwg
d2hlbiB0aGUgc3RhdHVzIGNoYW5nZXM/DQoNClRoZSBzdGF0dXMgY2hhbmdlIG9mIGNvbm5lY3Rp
b24gaXMgYmVmb3JlIHBvcnQgcmVzZXQuDQpJbiB0aGlzIHN0YWdlLCB0aGUgZGV2aWNlIGlzIG5v
dCBwb3J0IGVuYWJsZSwgYW5kIGl0IHdpbGwgbm90IHRyaWdnZXIgZGlzY29ubmVjdGlvbi4NCg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogU3RhbmxleSBDaGFuZyA8c3RhbmxleV9jaGFuZ0ByZWFs
dGVrLmNvbT4NCj4gPiAtLS0NCj4gPiB2NiB0byB2NyBjaGFuZ2U6DQo+ID4gICAgIE5vIGNoYW5n
ZQ0KPiA+IHY1IHRvIHY2IGNoYW5nZToNCj4gPiAgICAgTm8gY2hhbmdlDQo+ID4gdjQgdG8gdjUg
Y2hhbmdlOg0KPiA+ICAgICBObyBjaGFuZ2UNCj4gPiB2MyB0byB2NCBjaGFuZ2U6DQo+ID4gICAg
IEZpeCB0aGUgd2FybmluZyBmb3IgY2hlY2twYXRjaCB3aXRoIHN0cmljdC4NCj4gPiB2MiB0byB2
MyBjaGFuZ2U6DQo+ID4gICAgIEFkZCBtb3JlIGNvbW1lbnRzIGFib3V0IHRoZSByZWFzb24gZm9y
IGFkZGluZyB0aGlzIGFwaQ0KPiA+IHYxIHRvIHYyIGNoYW5nZToNCj4gPiAgICAgTm8gY2hhbmdl
DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdXNiL2NvcmUvaHViLmMgIHwgMTMgKysrKysrKysrKysr
KyAgaW5jbHVkZS9saW51eC91c2IvcGh5LmggfA0KPiA+IDEzICsrKysrKysrKysrKysNCj4gPiAg
MiBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvY29yZS9odWIuYyBiL2RyaXZlcnMvdXNiL2NvcmUvaHViLmMgaW5kZXgNCj4g
PiBhNzM5NDAzYTllNDUuLjg0MzNmZjg5ZGVhNiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3Vz
Yi9jb3JlL2h1Yi5jDQo+ID4gKysrIGIvZHJpdmVycy91c2IvY29yZS9odWIuYw0KPiA+IEBAIC02
MTQsNiArNjE0LDE5IEBAIHN0YXRpYyBpbnQgaHViX2V4dF9wb3J0X3N0YXR1cyhzdHJ1Y3QgdXNi
X2h1YiAqaHViLA0KPiBpbnQgcG9ydDEsIGludCB0eXBlLA0KPiA+ICAgICAgICAgICAgICAgcmV0
ID0gMDsNCj4gPiAgICAgICB9DQo+ID4gICAgICAgbXV0ZXhfdW5sb2NrKCZodWItPnN0YXR1c19t
dXRleCk7DQo+ID4gKw0KPiA+ICsgICAgIGlmICghcmV0KSB7DQo+ID4gKyAgICAgICAgICAgICBz
dHJ1Y3QgdXNiX2RldmljZSAqaGRldiA9IGh1Yi0+aGRldjsNCj4gPiArDQo+ID4gKyAgICAgICAg
ICAgICBpZiAoaGRldiAmJiAhaGRldi0+cGFyZW50KSB7DQo+IA0KPiBXaHkgdGhlIGNoZWNrIGZv
ciBubyBwYXJlbnQ/ICBQbGVhc2UgZG9jdW1lbnQgdGhhdCBoZXJlIGluIGEgY29tbWVudC4NCg0K
SSB3aWxsIGFkZCBhIGNvbW1lbnQgOg0KLyogT25seSBub3RpZnkgcm9vdGh1Yi4gVGhhdCBpcywg
d2hlbiBoZGV2LT5wYXJlbnQgaXMgZW1wdHkuICovDQoNCg0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgdXNiX2hjZCAqaGNkID0gYnVzX3RvX2hjZChoZGV2LT5idXMpOw0KPiA+ICsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgaWYgKGhjZC0+dXNiX3BoeSkNCj4gPiArDQo+IHVz
Yl9waHlfbm90aWZ5X3BvcnRfc3RhdHVzKGhjZC0+dXNiX3BoeSwNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwb3J0MSAtDQo+IDEs
ICpzdGF0dXMsICpjaGFuZ2UpOw0KPiA+ICsgICAgICAgICAgICAgfQ0KPiA+ICsgICAgIH0NCj4g
PiArDQo+IA0KPiBUaGlzIGlzIHNhZmUgdG8gbm90aWZ5IHdpdGggdGhlIGh1YiBtdXRleCB1bmxv
Y2tlZD8gIEFnYWluLCBhIGNvbW1lbnQgd291bGQNCj4gYmUgaGVscGZ1bCB0byBmdXR1cmUgcGVv
cGxlIGV4cGxhaW5pbmcgd2h5IHRoYXQgaXMgc28uDQo+IA0KDQpJIHdpbGwgYWRkIGEgY29tbWVu
dDogDQovKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICANCiAqIFRoZXJlIGlzIG5vIG5lZWQgdG8gbG9jayBzdGF0dXNf
bXV0ZXggaGVyZSwgYmVjYXVzZSBzdGF0dXNfbXV0ZXggICAgIA0KICogcHJvdGVjdHMgaHViLT5z
dGF0dXMsIGFuZCB0aGUgcGh5IGRyaXZlciBvbmx5IGNoZWNrcyB0aGUgcG9ydCAgICAgICAgDQog
KiBzdGF0dXMgd2l0aG91dCBjaGFuZ2luZyB0aGUgc3RhdHVzLiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICANCiAqLyAgDQoNClRoYW5rcywNClN0YW5sZXkNCg0KLg0K
