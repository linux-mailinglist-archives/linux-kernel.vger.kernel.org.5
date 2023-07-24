Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3D275EC99
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGXHea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGXHe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:34:28 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5FA2C6;
        Mon, 24 Jul 2023 00:34:26 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36O7XSXZ0019428, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36O7XSXZ0019428
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 24 Jul 2023 15:33:28 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 24 Jul 2023 15:33:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 24 Jul 2023 15:33:39 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 24 Jul 2023 15:33:39 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
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
Thread-Index: AQHZsJ7kDWGiCOPLRk2HhU7h2LN0sq/H/g6AgACS9CD//4JIgIAAjEhQ
Date:   Mon, 24 Jul 2023 07:33:39 +0000
Message-ID: <8d6ee5765dc34d5fa042195b27aa7eec@realtek.com>
References: <20230707064725.25291-1-stanley_chang@realtek.com>
 <2023072452-jasmine-palm-7b73@gregkh>
 <47131beec8a24572873aa31e87cfaab6@realtek.com>
 <2023072454-mosaic-ogle-9a27@gregkh>
In-Reply-To: <2023072454-mosaic-ogle-9a27@gregkh>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KPiA+ID4NCj4gPiA+IEhvdyBkbyB5b3Uga25vdyB0aGF0IHRoZSBkaXNjb25u
ZWN0IHdpbGwgbm90IGhhdmUgYWxyZWFkeSBiZWVuDQo+ID4gPiB0cmlnZ2VyZWQgYXQgdGhpcyBw
b2ludCwgd2hlbiB0aGUgc3RhdHVzIGNoYW5nZXM/DQo+ID4NCj4gPiBUaGUgc3RhdHVzIGNoYW5n
ZSBvZiBjb25uZWN0aW9uIGlzIGJlZm9yZSBwb3J0IHJlc2V0Lg0KPiA+IEluIHRoaXMgc3RhZ2Us
IHRoZSBkZXZpY2UgaXMgbm90IHBvcnQgZW5hYmxlLCBhbmQgaXQgd2lsbCBub3QgdHJpZ2dlcg0K
PiBkaXNjb25uZWN0aW9uLg0KPiANCj4gT2ssIHRoZW4gc2F5IHRoYXQgaGVyZSBwbGVhc2UgOikN
Cg0KT2theS4gSSB3aWxsIGFkZCBpdC4NCg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91
c2IvY29yZS9odWIuYyBiL2RyaXZlcnMvdXNiL2NvcmUvaHViLmMgaW5kZXgNCj4gPiA+ID4gYTcz
OTQwM2E5ZTQ1Li44NDMzZmY4OWRlYTYgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdXNi
L2NvcmUvaHViLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy91c2IvY29yZS9odWIuYw0KPiA+ID4g
PiBAQCAtNjE0LDYgKzYxNCwxOSBAQCBzdGF0aWMgaW50IGh1Yl9leHRfcG9ydF9zdGF0dXMoc3Ry
dWN0IHVzYl9odWINCj4gPiA+ID4gKmh1YiwNCj4gPiA+IGludCBwb3J0MSwgaW50IHR5cGUsDQo+
ID4gPiA+ICAgICAgICAgICAgICAgcmV0ID0gMDsNCj4gPiA+ID4gICAgICAgfQ0KPiA+ID4gPiAg
ICAgICBtdXRleF91bmxvY2soJmh1Yi0+c3RhdHVzX211dGV4KTsNCj4gPiA+ID4gKw0KPiA+ID4g
PiArICAgICBpZiAoIXJldCkgew0KPiA+ID4gPiArICAgICAgICAgICAgIHN0cnVjdCB1c2JfZGV2
aWNlICpoZGV2ID0gaHViLT5oZGV2Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgICAgICAg
aWYgKGhkZXYgJiYgIWhkZXYtPnBhcmVudCkgew0KPiA+ID4NCj4gPiA+IFdoeSB0aGUgY2hlY2sg
Zm9yIG5vIHBhcmVudD8gIFBsZWFzZSBkb2N1bWVudCB0aGF0IGhlcmUgaW4gYSBjb21tZW50Lg0K
PiA+DQo+ID4gSSB3aWxsIGFkZCBhIGNvbW1lbnQgOg0KPiA+IC8qIE9ubHkgbm90aWZ5IHJvb3Ro
dWIuIFRoYXQgaXMsIHdoZW4gaGRldi0+cGFyZW50IGlzIGVtcHR5LiAqLw0KPiANCj4gQWxzbyBk
b2N1bWVudCB0aGlzIHRoYXQgdGhpcyB3aWxsIG9ubHkgaGFwcGVuIGZvciByb290IGh1YiBzdGF0
dXMgY2hhbmdlcywgdGhhdCdzDQo+IG5vdCBvYnZpb3VzIGluIHRoZSBjYWxsYmFjayBuYW1lIG9y
IGRvY3VtZW50YXRpb24gb3IgYW55d2hlcmUgZWxzZSBoZXJlLg0KDQpBbGwgdXNiIHBoeSBub3Rp
ZmljYXRpb25zIChjb25uZWN0aW9uLCBkaXNjb25uZWN0aW9uKSBhcmUgb25seSBmb3Igcm9vdGh1
Yi4NClNvIEkgZG9uJ3Qgc3BlY2lhbCB0byBkb2MgdGhpcy4NCg0KPiA+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgc3RydWN0IHVzYl9oY2QgKmhjZCA9IGJ1c190b19oY2QoaGRldi0+YnVzKTsN
Cj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgaWYgKGhjZC0+dXNiX3Bo
eSkNCj4gPiA+ID4gKw0KPiA+ID4gdXNiX3BoeV9ub3RpZnlfcG9ydF9zdGF0dXMoaGNkLT51c2Jf
cGh5LA0KPiA+ID4gPiArDQo+IHBvcnQxIC0NCj4gPiA+IDEsICpzdGF0dXMsICpjaGFuZ2UpOw0K
PiA+ID4gPiArICAgICAgICAgICAgIH0NCj4gPiA+ID4gKyAgICAgfQ0KPiA+ID4gPiArDQo+ID4g
Pg0KPiA+ID4gVGhpcyBpcyBzYWZlIHRvIG5vdGlmeSB3aXRoIHRoZSBodWIgbXV0ZXggdW5sb2Nr
ZWQ/ICBBZ2FpbiwgYQ0KPiA+ID4gY29tbWVudCB3b3VsZCBiZSBoZWxwZnVsIHRvIGZ1dHVyZSBw
ZW9wbGUgZXhwbGFpbmluZyB3aHkgdGhhdCBpcyBzby4NCj4gPiA+DQo+ID4NCj4gPiBJIHdpbGwg
YWRkIGEgY29tbWVudDoNCj4gPiAvKg0KPiA+ICAqIFRoZXJlIGlzIG5vIG5lZWQgdG8gbG9jayBz
dGF0dXNfbXV0ZXggaGVyZSwgYmVjYXVzZSBzdGF0dXNfbXV0ZXgNCj4gPiAgKiBwcm90ZWN0cyBo
dWItPnN0YXR1cywgYW5kIHRoZSBwaHkgZHJpdmVyIG9ubHkgY2hlY2tzIHRoZSBwb3J0DQo+ID4g
ICogc3RhdHVzIHdpdGhvdXQgY2hhbmdpbmcgdGhlIHN0YXR1cy4NCj4gPiAgKi8NCj4gDQo+IExv
b2tzIGdvb2QsIGlmIHlvdSBkbyBpdCB3aXRob3V0IHRoZSB0cmFpbGluZyB3aGl0ZXNwYWNlIDop
DQo+IA0KT2theQ0KDQoNClRoYW5rcywNClN0YW5sZXkNCg==
