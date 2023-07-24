Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BF475EE35
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjGXIrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjGXIrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:47:15 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A60E7E4A;
        Mon, 24 Jul 2023 01:47:12 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36O8k7dgD005803, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36O8k7dgD005803
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 24 Jul 2023 16:46:07 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 24 Jul 2023 16:46:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 24 Jul 2023 16:46:18 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Mon, 24 Jul 2023 16:46:18 +0800
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
Thread-Index: AQHZsJ7kDWGiCOPLRk2HhU7h2LN0sq/H/g6AgACS9CD//4JIgIAAjEhQgAAVD/A=
Date:   Mon, 24 Jul 2023 08:46:18 +0000
Message-ID: <832fc6ec78074b49a719221ccefd2d90@realtek.com>
References: <20230707064725.25291-1-stanley_chang@realtek.com>
 <2023072452-jasmine-palm-7b73@gregkh>
 <47131beec8a24572873aa31e87cfaab6@realtek.com>
 <2023072454-mosaic-ogle-9a27@gregkh> 
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

SGkgR3JlZywNCg0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArICAgICBpZiAoIXJldCkgew0KPiA+
ID4gPiA+ICsgICAgICAgICAgICAgc3RydWN0IHVzYl9kZXZpY2UgKmhkZXYgPSBodWItPmhkZXY7
DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgaWYgKGhkZXYgJiYgIWhkZXYt
PnBhcmVudCkgew0KPiA+ID4gPg0KPiA+ID4gPiBXaHkgdGhlIGNoZWNrIGZvciBubyBwYXJlbnQ/
ICBQbGVhc2UgZG9jdW1lbnQgdGhhdCBoZXJlIGluIGENCj4gY29tbWVudC4NCj4gPiA+DQo+ID4g
PiBJIHdpbGwgYWRkIGEgY29tbWVudCA6DQo+ID4gPiAvKiBPbmx5IG5vdGlmeSByb290aHViLiBU
aGF0IGlzLCB3aGVuIGhkZXYtPnBhcmVudCBpcyBlbXB0eS4gKi8NCj4gPg0KPiA+IEFsc28gZG9j
dW1lbnQgdGhpcyB0aGF0IHRoaXMgd2lsbCBvbmx5IGhhcHBlbiBmb3Igcm9vdCBodWIgc3RhdHVz
DQo+ID4gY2hhbmdlcywgdGhhdCdzIG5vdCBvYnZpb3VzIGluIHRoZSBjYWxsYmFjayBuYW1lIG9y
IGRvY3VtZW50YXRpb24gb3INCj4gYW55d2hlcmUgZWxzZSBoZXJlLg0KPiANCj4gQWxsIHVzYiBw
aHkgbm90aWZpY2F0aW9ucyAoY29ubmVjdGlvbiwgZGlzY29ubmVjdGlvbikgYXJlIG9ubHkgZm9y
IHJvb3RodWIuDQo+IFNvIEkgZG9uJ3Qgc3BlY2lhbCB0byBkb2MgdGhpcy4NCg0KSSB3aWxsIGFk
ZCB0aGUgY29tbWVudDoNCi8qDQogKiBBcHBsaWVzIHRvIHJvb3RodWIgb25seS4gVGhhdCBpcywg
d2hlbiBoZGV2LT5wYXJlbnQgaXMNCiAqIGVtcHR5LiBPbmx5IHRoZSByb290aHViIHdpbGwgYmUg
bm90aWZpZWQgb2YgcG9ydCBzdGF0ZQ0KICogY2hhbmdlcywgc2luY2UgdGhlIFVTQiBQSFkgb25s
eSBjYXJlcyBhYm91dCBjaGFuZ2VzIGF0DQogKiB0aGUgbmV4dCBsZXZlbC4NCiAqLw0KDQoNClRo
YW5rcywNClN0YW5sZXkNCg==
