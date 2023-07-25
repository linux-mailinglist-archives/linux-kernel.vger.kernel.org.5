Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C0B760653
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 05:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjGYDGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 23:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjGYDGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 23:06:14 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9780BE69;
        Mon, 24 Jul 2023 20:06:11 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36P2ho7kB027817, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36P2ho7kB027817
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Jul 2023 10:43:50 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 25 Jul 2023 10:44:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 25 Jul 2023 10:44:01 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 25 Jul 2023 10:44:01 +0800
From:   =?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?= <stanley_chang@realtek.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Roy Luo" <royluo@google.com>, Ray Chi <raychi@google.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v8 1/5] usb: phy: add usb phy notify port status API
Thread-Topic: [PATCH v8 1/5] usb: phy: add usb phy notify port status API
Thread-Index: AQHZvhqkycGt3KejTUSlVj06OKYZVq/IcTcAgAFVX3A=
Date:   Tue, 25 Jul 2023 02:44:01 +0000
Message-ID: <0c611f376c4646bda5bae2b46261ecbc@realtek.com>
References: <20230724103600.14164-1-stanley_chang@realtek.com>
 <802dd50c-7201-45d2-8855-6692aeb947db@rowland.harvard.edu>
In-Reply-To: <802dd50c-7201-45d2-8855-6692aeb947db@rowland.harvard.edu>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxhbiwNCg0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2NvcmUvaHViLmMNCj4gPiArKysgYi9k
cml2ZXJzL3VzYi9jb3JlL2h1Yi5jDQo+ID4gQEAgLTYxNCw2ICs2MTQsMzAgQEAgc3RhdGljIGlu
dCBodWJfZXh0X3BvcnRfc3RhdHVzKHN0cnVjdCB1c2JfaHViICpodWIsDQo+IGludCBwb3J0MSwg
aW50IHR5cGUsDQo+ID4gICAgICAgICAgICAgICByZXQgPSAwOw0KPiA+ICAgICAgIH0NCj4gPiAg
ICAgICBtdXRleF91bmxvY2soJmh1Yi0+c3RhdHVzX211dGV4KTsNCj4gPiArDQo+ID4gKyAgICAg
LyoNCj4gPiArICAgICAgKiBUaGVyZSBpcyBubyBuZWVkIHRvIGxvY2sgc3RhdHVzX211dGV4IGhl
cmUsIGJlY2F1c2Ugc3RhdHVzX211dGV4DQo+ID4gKyAgICAgICogcHJvdGVjdHMgaHViLT5zdGF0
dXMsIGFuZCB0aGUgcGh5IGRyaXZlciBvbmx5IGNoZWNrcyB0aGUgcG9ydA0KPiA+ICsgICAgICAq
IHN0YXR1cyB3aXRob3V0IGNoYW5naW5nIHRoZSBzdGF0dXMuDQo+ID4gKyAgICAgICovDQo+ID4g
KyAgICAgaWYgKCFyZXQpIHsNCj4gPiArICAgICAgICAgICAgIHN0cnVjdCB1c2JfZGV2aWNlICpo
ZGV2ID0gaHViLT5oZGV2Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgIC8qDQo+ID4gKyAgICAg
ICAgICAgICAgKiBBcHBsaWVzIHRvIHJvb3RodWIgb25seS4gVGhhdCBpcywgd2hlbiBoZGV2LT5w
YXJlbnQgaXMNCj4gPiArICAgICAgICAgICAgICAqIGVtcHR5LiBPbmx5IHJvb3RodWIgd2lsbCBi
ZSBub3RpZmllZCBvZiBwb3J0IHN0YXRlDQo+ID4gKyAgICAgICAgICAgICAgKiBjaGFuZ2VzLCBz
aW5jZSB0aGUgVVNCIFBIWSBvbmx5IGNhcmVzIGFib3V0IGNoYW5nZXMgYXQNCj4gPiArICAgICAg
ICAgICAgICAqIHRoZSBuZXh0IGxldmVsLg0KPiA+ICsgICAgICAgICAgICAgICovDQo+ID4gKyAg
ICAgICAgICAgICBpZiAoaGRldiAmJiAhaGRldi0+cGFyZW50KSB7DQo+IA0KPiBoZGV2IGNhbiBu
ZXZlciBiZSBOVUxMLCBzbyB5b3UgZG9uJ3QgbmVlZCB0byB0ZXN0IGl0LiAgQWxzbywgdGhlcmUg
aXMgYW4NCj4gaXNfcm9vdF9odWIoKSByb3V0aW5lIHlvdSBjYW4gY2FsbCBoZXJlIC0tIGl0J3Mg
YW4gaW5saW5lIGRlZmluZWQgaW4gdXNiLmguICBJZiB5b3UNCj4gdXNlIHRoYXQgdGhlbiB5b3Ug
d29uJ3QgaGF2ZSB0byBleHBsYWluIGl0IGluIHRoZSBjb21tZW50Lg0KPiANCj4gVG8gYmUgZmFp
ciwgdGhlcmUgYXJlIHBsZW50eSBvZiBvdGhlciBwbGFjZXMgaW4gdGhlIGRyaXZlciB0aGF0IHRl
c3QgIWhkZXYtPnBhcmVudA0KPiAob3IgIXVkZXYtPnBhcmVudCkgd2l0aCBubyBleHBsYW5hdGlv
bi4NCj4gDQoNClVzaW5nIGlzX3Jvb3RfaHViKCkgaXMgYSBnb29kIGNob2ljZS4NCg0KVGhhbmtz
LA0KU3RhbmxleQ0KDQo=
