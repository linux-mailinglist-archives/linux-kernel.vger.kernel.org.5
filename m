Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9EA7E1E7A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjKFKh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjKFKhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:37:25 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893BF94;
        Mon,  6 Nov 2023 02:37:22 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A6Ab6Tq93464615, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A6Ab6Tq93464615
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 18:37:06 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 6 Nov 2023 18:37:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 6 Nov 2023 18:37:06 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Mon, 6 Nov 2023 18:37:06 +0800
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
Thread-Index: AQHaDxyJZpnjRAISQ06Vkn+OQSkmobBsqcjggAAuZtD//7GWAIAAhs6A//+ARgCAAIargA==
Date:   Mon, 6 Nov 2023 10:37:06 +0000
Message-ID: <bafbd60ac8134a0782a7ee27c01971ea@realtek.com>
References: <20231103164323.14294-1-johan+linaro@kernel.org>
 <ZUY8cGrofUtPOMV8@eichest-laptop>
 <5a493e6fedb449bc93f83f31a682e5b9@realtek.com>
 <ZUi3hrDbseJbIsWZ@hovoldconsulting.com>
 <b2f3db01ad7d43dbbb8ee11cfd1346ea@realtek.com>
 <ZUi9dgnvBT5f6wzo@hovoldconsulting.com>
In-Reply-To: <ZUi9dgnvBT5f6wzo@hovoldconsulting.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
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

SGkgSm9oYW4sDQoNCj4gDQo+IE9uIE1vbiwgTm92IDA2LCAyMDIzIGF0IDEwOjA4OjI0QU0gKzAw
MDAsIFN0YW5sZXkgQ2hhbmdb5piM6IKy5b63XSB3cm90ZToNCj4gPiA+IE9uIE1vbiwgTm92IDA2
LCAyMDIzIGF0IDA2OjUzOjIzQU0gKzAwMDAsIFN0YW5sZXkgQ2hhbmdb5piM6IKy5b63XQ0KPiB3
cm90ZToNCj4gDQo+ID4gPiA+IEkgdGVzdCB0aGUgUmVhbHRlayBwaHkgZHJpdmVyIGF0IGRyaXZl
cnMvcGh5L1JlYWx0ZWsvcGh5LXJ0ay11c2IyLmMgYWdhaW4uDQo+ID4gPiA+IEJ1dCBJIGNhbid0
IGdldCB0aGUgcGh5IGluIHhoY2kuDQo+ID4gPg0KPiA+ID4gPiBJdCBpcyBhIGR3YzMgZ2VuZXJp
YyBwaHkgZHJpdmVyLCBhbmQgaXQgaXMgYWxzbyBhIHVzYiBwaHkgZHJpdmVyLg0KPiA+ID4NCj4g
PiA+IFRoYXQgc291bmRzIGJyb2tlbiAoaS5lLiB0byBiZSByZWx5aW5nIG9uIGJvdGggZnJhbWV3
b3JrcyksIGJ1dA0KPiA+ID4gaW5kZWVkIHRoYXQgc2VlbXMgdG8gYmUgdGhlIGN1cnJlbnQgc3Rh
dGUgb2YgdGhlIGdlbmVyaWMgYW5kIGxlZ2FjeQ0KPiA+ID4gVVNCIFBIWSBpbXBsZW1lbnRhdGlv
bnMuDQo+ID4gPg0KPiA+ID4gV2hhdCBhIG1lc3MuDQo+ID4NCj4gPiA+ID4gQmFzZSBvbiB5b3Ug
bW9kaWZpZWQsIEkgY2FuJ3QgcnVuIG9uIGNhbGxiYWNrDQo+ID4gPiA+IHJ0a19waHktPnBoeS5u
b3RpZnlfcG9ydF9zdGF0dXMgPSBydGtfcGh5X25vdGlmeV9wb3J0X3N0YXR1czsNCj4gPiA+DQo+
ID4gPiBXaGljaCBkd2MzIGRyaXZlciBhcmUgeW91IHVzaW5nPyBVbmxlc3MgSSdtIG1pc3Npbmcg
c29tZXRoaW5nIHRoaXMNCj4gPiA+IHdvdWxkIG5vdCBiZSBhbiBpc3N1ZSB1bmxlc3MgeW91IGFy
ZSBkb2luZyBzb21ldGhpbmcgY3JhenkgbGlrZQ0KPiA+ID4gZGVzY3JpYmluZyB0aGUgc2FtZSBQ
SFkgdHdpY2UgaW4gdGhlIGRldmljZXRyZWUgKGkuZS4gYm90aCBhcyBhIGdlbmVyaWMgYW5kDQo+
IGxlZ2FjeSBQSFkpLg0KPiA+DQo+ID4gSSB1c2UgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgYW5k
IGRyaXZlcnMvdXNiL2R3YzMvZHdjMy1ydGsuYyBJDQo+ID4gZGVzY3JpYmUgdGhlIFBIWSBhcyBn
ZW5lcmljIGFuZCBsZWdhY3kgUEhZIGluIGRldmljZSB0cmVlLg0KPiANCj4gVGhhdCdzIG5vdCBy
aWdodC4gWW91IHNob3VsZCBqdXN0IHVzZSB0aGUgZ2VuZXJpYyBQSFkgYmluZGluZyBmb3IgbmV3
IHBsYXRmb3Jtcy4NCj4gDQo+ID4gT3VyIGRyaXZlciBuZWVkcyB0aGUgQVBJIGJhc2Ugb24gYTA4
Nzk5Y2YxN2MyICgidXNiOiBwaHk6IGFkZCB1c2IgcGh5DQo+IG5vdGlmeSBwb3J0IHN0YXR1cyBB
UEkiKS4NCj4gPiBCdXQgZ2VuZXJpYyBQSFkgZHJpdmVyIGlzIG5vdCBzdXBwb3J0IHRoaXMuDQo+
IA0KPiBZZXMsIGJ1dCB5b3UgYWRkZWQgdGhhdCBpbnRlcmZhY2UgeW91cnNlbGYsIGFuZCB0aGF0
IEkgdGhpbmsgbWVyZ2luZyB0aGF0IHdhcyBhDQo+IG1pc3Rha2UuDQo+IA0KPiBXZSBzaG91bGQg
bm90IGJlIGJ1aWxkaW5nIGZ1bmN0aW9uYWxpdHkgb24gdG9wIG9mIHRoZSBsZWdhY3kgVVNCIFBI
WQ0KPiBpbXBsZW1lbnRhdGlvbiB3aGljaCBpcyBzdHVjayBpbiBzb21lIHRyYW5zaXRpb25hbCBs
aW1iby4NCj4gDQo+IEFwcGFyZW50bHksIHlvdXIgUEhZIGRyaXZlcnMgd2hpY2ggd2VyZSBtZXJn
ZWQgZm9yIDYuNiBhcmUgdGhlIG9ubHkgdXNlcnMgb2YNCj4gdGhpcyBpbnRlcmZhY2UsIGFuZCB0
aGVyZSBhcmUgbm8gdXBzdHJlYW0gZGV2aWNldHJlZXMgdGhhdCB1c2UgdGhlc2UgUEhZcy4NCj4g
DQo+IEkgdGhpbmsgd2Ugc2hvdWxkIHJldmVydCB0aGlzIG1lc3MgYmVmb3JlIHdlIGRpZyBvdXJz
ZWx2ZXMgaW50byBhbiBldmVuIGRlZXBlcg0KPiBob2xlLg0KPiANCg0KVGhpcyBpcyBhbiBpbnRl
cmltIG1ldGhvZCwgYXMgdGhlIGN1cnJlbnQgZ2VuZXJpYyBQSFkgZnJhbWV3b3JrIGRvZXMgbm90
IHN1cHBvcnQgc3BlY2lhbCBvcGVyYXRpb25zIG9uIFVTQiBQSFkuDQpOb3cgdGhlIGdlbmVyaWMg
UEhZIGNhbid0IGluc3RlYWQgVVNCIFBIWSBpbiB0aGlzIHN0YWdlLg0KRm9yIGV4YW1wbGUsDQpk
cml2ZXJzL3BoeS90aS9waHktdHdsNDAzMC11c2IuYw0KZHJpdmVycy9waHkvcXVhbGNvbW0vcGh5
LXFjb20taXBxODA2eC11c2IuYw0KZHJpdmVycy9waHkvdGkvcGh5LW9tYXAtdXNiMi5jDQoNClRo
YW5rcywNClN0YW5sZXkNCg0K
