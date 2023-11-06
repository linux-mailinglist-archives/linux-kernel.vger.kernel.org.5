Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474277E1DE9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjKFKIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjKFKIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:08:49 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E764B8;
        Mon,  6 Nov 2023 02:08:42 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A6A8OtC43454666, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A6A8OtC43454666
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 18:08:24 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 6 Nov 2023 18:08:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 6 Nov 2023 18:08:24 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Mon, 6 Nov 2023 18:08:24 +0800
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
Thread-Index: AQHaDxyJZpnjRAISQ06Vkn+OQSkmobBsqcjggAAuZtD//7GWAIAAhs6A
Date:   Mon, 6 Nov 2023 10:08:24 +0000
Message-ID: <b2f3db01ad7d43dbbb8ee11cfd1346ea@realtek.com>
References: <20231103164323.14294-1-johan+linaro@kernel.org>
 <ZUY8cGrofUtPOMV8@eichest-laptop>
 <5a493e6fedb449bc93f83f31a682e5b9@realtek.com>
 <ZUi3hrDbseJbIsWZ@hovoldconsulting.com>
In-Reply-To: <ZUi3hrDbseJbIsWZ@hovoldconsulting.com>
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

SGkgSm9oYW4sDQoNCj4gDQo+IE9uIE1vbiwgTm92IDA2LCAyMDIzIGF0IDA2OjUzOjIzQU0gKzAw
MDAsIFN0YW5sZXkgQ2hhbmdb5piM6IKy5b63XSB3cm90ZToNCj4gPiA+ID4gT24gRnJpLCBOb3Yg
MDMsIDIwMjMgYXQgMDU6NDM6MjNQTSArMDEwMCwgSm9oYW4gSG92b2xkIHdyb3RlOg0KPiA+ID4g
PiA+IENvbW1pdHMgN2I4ZWYyMmVhNTQ3ICgidXNiOiB4aGNpOiBwbGF0OiBBZGQgVVNCIHBoeSBz
dXBwb3J0IikNCj4gPiA+ID4gPiBhbmQNCj4gPiA+ID4gPiA5MTM0YzFmZDA1MDMgKCJ1c2I6IHho
Y2k6IHBsYXQ6IEFkZCBVU0IgMy4wIHBoeSBzdXBwb3J0IikgYWRkZWQNCj4gPiA+ID4gPiBzdXBw
b3J0IGZvciBsb29raW5nIHVwIGxlZ2FjeSBQSFlzIGZyb20gdGhlIHN5c2RldiBkZXZpY2V0cmVl
DQo+ID4gPiA+ID4gbm9kZSBhbmQgaW5pdGlhbGlzaW5nIHRoZW0uDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiBUaGlzIGJyb2tlIGRyaXZlcnMgc3VjaCBhcyBkd2MzIHdoaWNoIG1hbmFnZXMgUEhZcyB0
aGVtc2VsZiBhcw0KPiA+ID4gPiA+IHRoZSBQSFlzIHdvdWxkIG5vdyBiZSBpbml0aWFsaXNlZCB0
d2ljZSwgc29tZXRoaW5nIHdoaWNoDQo+ID4gPiA+ID4gc3BlY2lmaWNhbGx5IGNhbiBsZWFkIHRv
IHJlc291cmNlcyBiZWluZyBsZWZ0IGVuYWJsZWQgZHVyaW5nDQo+ID4gPiA+ID4gc3VzcGVuZCAo
ZS5nLiB3aXRoIHRoZSB1c2JfcGh5X2dlbmVyaWMgUEhZIGRyaXZlcikuDQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiBBcyB0aGUgZHdjMyBkcml2ZXIgdXNlcyBkcml2ZXItbmFtZSBtYXRjaGluZyBmb3Ig
dGhlIHhoY2kNCj4gPiA+ID4gPiBwbGF0Zm9ybSBkZXZpY2UsIGZpeCB0aGlzIGJ5IG9ubHkgbG9v
a2luZyB1cCBhbmQgaW5pdGlhbGlzaW5nDQo+ID4gPiA+ID4gUEhZcyBmb3IgZGV2aWNlcyB0aGF0
IGhhdmUgYmVlbiBtYXRjaGVkIHVzaW5nIE9GLg0KPiANCj4gPiA+IFRlc3RlZC1ieTogU3Rhbmxl
eSBDaGFuZyA8c3RhbmxleV9jaGFuZ0ByZWFsdGVrLmNvbT4NCj4gDQo+ID4gSSBhbSBzb3JyeSB0
byBub3RpZnkgeW91IHRoaXMgcGF0Y2ggaXMgdGVzdGVkIGZhaWwuDQo+IA0KPiBIbW0uIFRoYW5r
cyBmb3IgdGVzdGluZy4NCj4gDQo+ID4gSSB0ZXN0IHRoZSBSZWFsdGVrIHBoeSBkcml2ZXIgYXQg
ZHJpdmVycy9waHkvUmVhbHRlay9waHktcnRrLXVzYjIuYyBhZ2Fpbi4NCj4gPiBCdXQgSSBjYW4n
dCBnZXQgdGhlIHBoeSBpbiB4aGNpLg0KPiANCj4gPiBJdCBpcyBhIGR3YzMgZ2VuZXJpYyBwaHkg
ZHJpdmVyLCBhbmQgaXQgaXMgYWxzbyBhIHVzYiBwaHkgZHJpdmVyLg0KPiANCj4gVGhhdCBzb3Vu
ZHMgYnJva2VuIChpLmUuIHRvIGJlIHJlbHlpbmcgb24gYm90aCBmcmFtZXdvcmtzKSwgYnV0IGlu
ZGVlZCB0aGF0DQo+IHNlZW1zIHRvIGJlIHRoZSBjdXJyZW50IHN0YXRlIG9mIHRoZSBnZW5lcmlj
IGFuZCBsZWdhY3kgVVNCIFBIWQ0KPiBpbXBsZW1lbnRhdGlvbnMuDQo+IA0KPiBXaGF0IGEgbWVz
cy4NCg0KPiA+IEJhc2Ugb24geW91IG1vZGlmaWVkLCBJIGNhbid0IHJ1biBvbiBjYWxsYmFjaw0K
PiA+IHJ0a19waHktPnBoeS5ub3RpZnlfcG9ydF9zdGF0dXMgPSBydGtfcGh5X25vdGlmeV9wb3J0
X3N0YXR1czsNCj4gDQo+IFdoaWNoIGR3YzMgZHJpdmVyIGFyZSB5b3UgdXNpbmc/IFVubGVzcyBJ
J20gbWlzc2luZyBzb21ldGhpbmcgdGhpcyB3b3VsZCBub3QNCj4gYmUgYW4gaXNzdWUgdW5sZXNz
IHlvdSBhcmUgZG9pbmcgc29tZXRoaW5nIGNyYXp5IGxpa2UgZGVzY3JpYmluZyB0aGUgc2FtZSBQ
SFkNCj4gdHdpY2UgaW4gdGhlIGRldmljZXRyZWUgKGkuZS4gYm90aCBhcyBhIGdlbmVyaWMgYW5k
IGxlZ2FjeSBQSFkpLg0KDQpJIHVzZSBkcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBhbmQgZHJpdmVy
cy91c2IvZHdjMy9kd2MzLXJ0ay5jDQpJIGRlc2NyaWJlIHRoZSBQSFkgYXMgZ2VuZXJpYyBhbmQg
bGVnYWN5IFBIWSBpbiBkZXZpY2UgdHJlZS4NCk91ciBkcml2ZXIgbmVlZHMgdGhlIEFQSSBiYXNl
IG9uIGEwODc5OWNmMTdjMiAoInVzYjogcGh5OiBhZGQgdXNiIHBoeSBub3RpZnkgcG9ydCBzdGF0
dXMgQVBJIikuDQpCdXQgZ2VuZXJpYyBQSFkgZHJpdmVyIGlzIG5vdCBzdXBwb3J0IHRoaXMuDQoN
ClRoYW5rcywNClN0YW5sZXkNCg0KPiBBcHBhcmVudGx5LCB0aGVyZSBhcmUgbm8gaW4tdHJlZSB1
c2VycyBvZiB0aGlzIHBhcnRpY3VsYXIgcmVhbHRlayBQSFkgc28gSSBjYW4ndA0KPiBjaGVjayB0
aGUgZGV2aWNldHJlZSwgYnV0IHdlIGRvIGhhdmUgb3RoZXIgaW5zdGFuY2VzIG9mIHN1Y2ggYWJ1
c2Ugc2luY2UgYXQNCj4gbGVhc3QgYSBkZWNhZGU6DQo+IA0KPiAgICAgICAgIDY3NDdjYWE3NmNh
YiAoInVzYjogcGh5OiB0d2w0MDMwOiB1c2UgdGhlIG5ldyBnZW5lcmljIFBIWQ0KPiBmcmFtZXdv
cmsiKQ0KPiANCj4gQW5kLCB5ZXMsIHRoZW4gdGhpcyBpcyBzb3J0IG9mIGV4cGVjdGVkLiBUaGUg
ZHdjMyBkcml2ZXIgaGFzIGFsd2F5cyBtYW5hZ2VkIGl0cw0KPiBvd24gUEhZcywgYnV0IGZ1bmN0
aW9uYWxpdHkgaGFzIG5vdyBiZWVuIGJvbHRlZCBvbiB0b3Agc28gdGhhdCBwZW9wbGUgbWF5DQo+
IGhhdmUgc3RhcnRlZCByZWx5aW5nIG9uIGl0IGJlaW5nIG1hbmFnZWQgKmFsc28qIGJ5IHhoY2ks
IHdlbGwgYXQgbGVhc3QgZm9yDQo+IG5vdGlmaWNhdGlvbnMgbGlrZSB0aGUgb25lIHlvdSBqdXN0
IGFkZGVkOg0KPiANCj4gICAgICAgICBhMDg3OTljZjE3YzIgKCJ1c2I6IHBoeTogYWRkIHVzYiBw
aHkgbm90aWZ5IHBvcnQgc3RhdHVzIEFQSSIpDQo+IA0KPiBKb2hhbg0K
