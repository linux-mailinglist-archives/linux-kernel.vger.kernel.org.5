Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9857E328A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 02:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbjKGBQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 20:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjKGBQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 20:16:30 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7151BF;
        Mon,  6 Nov 2023 17:16:23 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A71G49V03823446, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A71G49V03823446
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Nov 2023 09:16:04 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 7 Nov 2023 09:16:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 7 Nov 2023 09:16:03 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Tue, 7 Nov 2023 09:16:03 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Johan Hovold <johan@kernel.org>
CC:     Stefan Eichenberger <eichest@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: RE: [PATCH] USB: xhci-plat: fix legacy PHY double inity
Thread-Topic: [PATCH] USB: xhci-plat: fix legacy PHY double inity
Thread-Index: AQHaDxyJZpnjRAISQ06Vkn+OQSkmobBsqcjggAAuZtD//7GWAIAAhs6A//+ARgCAAIargP//gAIAAC8ZbZA=
Date:   Tue, 7 Nov 2023 01:16:03 +0000
Message-ID: <c85c1f7512524cdf9b452c2c023dc640@realtek.com>
References: <20231103164323.14294-1-johan+linaro@kernel.org>
 <ZUY8cGrofUtPOMV8@eichest-laptop>
 <5a493e6fedb449bc93f83f31a682e5b9@realtek.com>
 <ZUi3hrDbseJbIsWZ@hovoldconsulting.com>
 <b2f3db01ad7d43dbbb8ee11cfd1346ea@realtek.com>
 <ZUi9dgnvBT5f6wzo@hovoldconsulting.com>
 <bafbd60ac8134a0782a7ee27c01971ea@realtek.com>
 <ZUjDEC9M7zTsXIRp@hovoldconsulting.com>
In-Reply-To: <ZUjDEC9M7zTsXIRp@hovoldconsulting.com>
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

SGkgSm9oYW4sDQoNCj4gDQo+IE9uIE1vbiwgTm92IDA2LCAyMDIzIGF0IDEwOjM3OjA2QU0gKzAw
MDAsIFN0YW5sZXkgQ2hhbmdb5piM6IKy5b63XSB3cm90ZToNCj4gDQo+ID4gPiA+IEkgdXNlIGRy
aXZlcnMvdXNiL2R3YzMvY29yZS5jIGFuZCBkcml2ZXJzL3VzYi9kd2MzL2R3YzMtcnRrLmMgSQ0K
PiA+ID4gPiBkZXNjcmliZSB0aGUgUEhZIGFzIGdlbmVyaWMgYW5kIGxlZ2FjeSBQSFkgaW4gZGV2
aWNlIHRyZWUuDQo+ID4gPg0KPiA+ID4gVGhhdCdzIG5vdCByaWdodC4gWW91IHNob3VsZCBqdXN0
IHVzZSB0aGUgZ2VuZXJpYyBQSFkgYmluZGluZyBmb3IgbmV3DQo+IHBsYXRmb3Jtcy4NCj4gPiA+
DQo+ID4gPiA+IE91ciBkcml2ZXIgbmVlZHMgdGhlIEFQSSBiYXNlIG9uIGEwODc5OWNmMTdjMiAo
InVzYjogcGh5OiBhZGQgdXNiDQo+ID4gPiA+IHBoeQ0KPiA+ID4gbm90aWZ5IHBvcnQgc3RhdHVz
IEFQSSIpLg0KPiA+ID4gPiBCdXQgZ2VuZXJpYyBQSFkgZHJpdmVyIGlzIG5vdCBzdXBwb3J0IHRo
aXMuDQo+ID4gPg0KPiA+ID4gWWVzLCBidXQgeW91IGFkZGVkIHRoYXQgaW50ZXJmYWNlIHlvdXJz
ZWxmLCBhbmQgdGhhdCBJIHRoaW5rIG1lcmdpbmcNCj4gPiA+IHRoYXQgd2FzIGEgbWlzdGFrZS4N
Cj4gPiA+DQo+ID4gPiBXZSBzaG91bGQgbm90IGJlIGJ1aWxkaW5nIGZ1bmN0aW9uYWxpdHkgb24g
dG9wIG9mIHRoZSBsZWdhY3kgVVNCIFBIWQ0KPiA+ID4gaW1wbGVtZW50YXRpb24gd2hpY2ggaXMg
c3R1Y2sgaW4gc29tZSB0cmFuc2l0aW9uYWwgbGltYm8uDQo+ID4gPg0KPiA+ID4gQXBwYXJlbnRs
eSwgeW91ciBQSFkgZHJpdmVycyB3aGljaCB3ZXJlIG1lcmdlZCBmb3IgNi42IGFyZSB0aGUgb25s
eQ0KPiA+ID4gdXNlcnMgb2YgdGhpcyBpbnRlcmZhY2UsIGFuZCB0aGVyZSBhcmUgbm8gdXBzdHJl
YW0gZGV2aWNldHJlZXMgdGhhdCB1c2UNCj4gdGhlc2UgUEhZcy4NCj4gPiA+DQo+ID4gPiBJIHRo
aW5rIHdlIHNob3VsZCByZXZlcnQgdGhpcyBtZXNzIGJlZm9yZSB3ZSBkaWcgb3Vyc2VsdmVzIGlu
dG8gYW4NCj4gPiA+IGV2ZW4gZGVlcGVyIGhvbGUuDQo+ID4NCj4gPiBUaGlzIGlzIGFuIGludGVy
aW0gbWV0aG9kLCBhcyB0aGUgY3VycmVudCBnZW5lcmljIFBIWSBmcmFtZXdvcmsgZG9lcw0KPiA+
IG5vdCBzdXBwb3J0IHNwZWNpYWwgb3BlcmF0aW9ucyBvbiBVU0IgUEhZLg0KPiANCj4gVGhlbiB5
b3UgbmVlZCB0byBhZGQgdGhhdC4NCj4gDQo+IFlvdSBjYW4ndCBhZGQgYSBuZXcgaW50ZXJmYWNl
IHdoaWNoIGlzIGJyb2tlbiBieSBkZXNpZ24gYW5kIGNhbid0IGJlIHVzZWQNCj4gdW5sZXNzIHlv
dSBhYnVzZSB0aGUgZGV2aWNldHJlZSBhbmQgZGVzY3JpYmUgeW91ciBQSFlzIHVzaW5nICpib3Ro
KiB0aGUNCj4gZ2VuZXJpYyAncGh5JyBwcm9wZXJ0eSBhbmQgdGhlICpkZXByZWNhdGVkKiAndXNi
LXBoeScgcHJvcGVydHkuDQo+IA0KPiBUaGF0J3MganVzdCBicm9rZW4uDQoNCkkgd2lsbCBtb2Rp
ZnkgdGhlIFJlYWx0ZWsgcGh5IHRvIHNvbHZlIHRoaXMgcHJvYmxlbSBhbmQganVzdCB1c2UgdGhl
IGdlbmVyaWMgUEhZLg0KSSBkb24ndCB0aGluayB0aGlzIHBhdGNoIG9uIGEwODc5OWNmMTdjMiAo
InVzYjpwaHk6IE5ldyB1c2IgcGh5IG5vdGlmaWNhdGlvbiBwb3J0IHN0YXR1cyBBUEkiKSBuZWVk
cyB0byBiZSByZXZlcnRlZC4NCkkgd2lsbCBzdWJtaXQgZml4ZXMgYmFzZWQgb24gdGhlc2UgcGF0
Y2hlcy4NCg0KVGhhbmtzLA0KU3RhbmxleQ0KDQo+ID4gTm93IHRoZSBnZW5lcmljIFBIWSBjYW4n
dCBpbnN0ZWFkIFVTQiBQSFkgaW4gdGhpcyBzdGFnZS4NCj4gPiBGb3IgZXhhbXBsZSwNCj4gPiBk
cml2ZXJzL3BoeS90aS9waHktdHdsNDAzMC11c2IuYw0KPiA+IGRyaXZlcnMvcGh5L3F1YWxjb21t
L3BoeS1xY29tLWlwcTgwNngtdXNiLmMNCj4gPiBkcml2ZXJzL3BoeS90aS9waHktb21hcC11c2Iy
LmMNCj4gDQo+IFRoZXNlIHNob3VsZCBiZSBmaXhlZCBhcyB3ZWxsIGV2ZW50dWFsbHkuDQo+IA0K
PiBKb2hhbg0K
