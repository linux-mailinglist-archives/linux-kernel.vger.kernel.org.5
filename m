Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120807F0A84
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 03:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjKTCTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 21:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTCTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 21:19:21 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520ED133;
        Sun, 19 Nov 2023 18:19:14 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AK2GuFP2401014, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AK2GuFP2401014
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Nov 2023 10:16:56 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 20 Nov 2023 10:16:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 20 Nov 2023 10:16:55 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Mon, 20 Nov 2023 10:16:55 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Vinod Koul <vkoul@kernel.org>, Johan Hovold <johan@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Roy Luo <royluo@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        =?utf-8?B?UmljYXJkbyBDYcOxdWVsbw==?= 
        <ricardo.canuelo@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v3 1/4] phy: core: add notify_connect and notify_disconnect callback
Thread-Topic: [PATCH v3 1/4] phy: core: add notify_connect and
 notify_disconnect callback
Thread-Index: AQHaE5lppIbVtDBYMkuRe6XIgfyuz7CChzHg
Date:   Mon, 20 Nov 2023 02:16:55 +0000
Message-ID: <8216e62cf2e646a6bdc8dd6629c88f41@realtek.com>
References: <20231110054738.23515-1-stanley_chang@realtek.com>
In-Reply-To: <20231110054738.23515-1-stanley_chang@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
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

SGkgVmlub2QsDQoNClBsZWFzZSBoZWxwIHJldmlldyB0aGlzIHBhdGNoLg0KDQpUaGFua3MsDQpT
dGFubGV5DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RhbmxleSBD
aGFuZyA8c3RhbmxleV9jaGFuZ0ByZWFsdGVrLmNvbT4NCj4gU2VudDogRnJpZGF5LCBOb3ZlbWJl
ciAxMCwgMjAyMyAxOjQ1IFBNDQo+IFRvOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51
eGZvdW5kYXRpb24ub3JnPg0KPiBDYzogU3RhbmxleSBDaGFuZ1vmmIzogrLlvrddIDxzdGFubGV5
X2NoYW5nQHJlYWx0ZWsuY29tPjsgVmlub2QgS291bA0KPiA8dmtvdWxAa2VybmVsLm9yZz47IEpv
aGFuIEhvdm9sZCA8am9oYW5Aa2VybmVsLm9yZz47IEtpc2hvbiBWaWpheSBBYnJhaGFtDQo+IEkg
PGtpc2hvbkBrZXJuZWwub3JnPjsgR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGds
aWRlci5iZT47IEppbmppZQ0KPiBSdWFuIDxydWFuamluamllQGh1YXdlaS5jb20+OyBSb2IgSGVy
cmluZyA8cm9iaEBrZXJuZWwub3JnPjsgQWxhbiBTdGVybg0KPiA8c3Rlcm5Acm93bGFuZC5oYXJ2
YXJkLmVkdT47IFlhbmcgWWluZ2xpYW5nIDx5YW5neWluZ2xpYW5nQGh1YXdlaS5jb20+Ow0KPiBG
bGF2aW8gU3VsaWdvaSA8Zi5zdWxpZ29pQGFzZW0uaXQ+OyBSb3kgTHVvIDxyb3lsdW9AZ29vZ2xl
LmNvbT47IEhlaWtraQ0KPiBLcm9nZXJ1cyA8aGVpa2tpLmtyb2dlcnVzQGxpbnV4LmludGVsLmNv
bT47IFJpY2FyZG8gQ2HDsXVlbG8NCj4gPHJpY2FyZG8uY2FudWVsb0Bjb2xsYWJvcmEuY29tPjsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtcGh5QGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIHYzIDEv
NF0gcGh5OiBjb3JlOiBhZGQgbm90aWZ5X2Nvbm5lY3QgYW5kIG5vdGlmeV9kaXNjb25uZWN0DQo+
IGNhbGxiYWNrDQo+IA0KPiBJbiBSZWFsdGVrIFNvQywgdGhlIHBhcmFtZXRlciBvZiB1c2IgcGh5
IGlzIGRlc2lnbmVkIHRvIGNhbiBkeW5hbWljIHR1bmluZw0KPiBiYXNlIG9uIHBvcnQgc3RhdHVz
LiBUaGVyZWZvcmUsIGFkZCBhIG5vdGlmeSBjYWxsYmFjayBvZiBwaHkgZHJpdmVyIHdoZW4gdXNi
DQo+IGNvbm5lY3Rpb24vZGlzY29ubmVjdGlvbiBjaGFuZ2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBTdGFubGV5IENoYW5nIDxzdGFubGV5X2NoYW5nQHJlYWx0ZWsuY29tPg0KPiAtLS0NCj4gdjEg
dG8gdjI6DQo+ICAgICBObyBjaGFuZ2UNCj4gdjIgdG8gdjM6DQo+ICAgICBObyBjaGFuZ2UNCj4g
LS0tDQo+ICBkcml2ZXJzL3BoeS9waHktY29yZS5jICB8IDQ3DQo+ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBpbmNsdWRlL2xpbnV4L3BoeS9waHkuaCB8IDE4
ICsrKysrKysrKysrKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgNjUgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L3BoeS1jb3JlLmMgYi9kcml2ZXJzL3BoeS9w
aHktY29yZS5jIGluZGV4DQo+IDk2YTBiMWUxMTFmMy4uYTg0YWQ0ODk2YjdmIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL3BoeS9waHktY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvcGh5L3BoeS1jb3Jl
LmMNCj4gQEAgLTQ4OSw2ICs0ODksNTMgQEAgaW50IHBoeV9jYWxpYnJhdGUoc3RydWN0IHBoeSAq
cGh5KSAgfQ0KPiBFWFBPUlRfU1lNQk9MX0dQTChwaHlfY2FsaWJyYXRlKTsNCj4gDQo+ICsvKioN
Cj4gKyAqIHBoeV9ub3RpZnlfY29ubmVjdCgpIC0gcGh5IGNvbm5lY3Qgbm90aWZ5DQo+ICsgKiBA
cGh5OiB0aGUgcGh5IHJldHVybmVkIGJ5IHBoeV9nZXQoKQ0KPiArICogQHBvcnQ6IHRoZSBwb3J0
IGluZGV4IGZvciBjb25uZWN0DQo+ICsgKg0KPiArICogSWYgcGh5IG5lZWQgdGhlIGdldCBjb25u
ZWN0aW9uIHN0YXR1cywgdGhlIGNhbGxiYWNrIGNhbiBiZSB1c2VkLg0KPiArICogUmV0dXJuczog
JTAgaWYgc3VjY2Vzc2Z1bCwgYSBuZWdhdGl2ZSBlcnJvciBjb2RlIG90aGVyd2lzZSAgKi8gaW50
DQo+ICtwaHlfbm90aWZ5X2Nvbm5lY3Qoc3RydWN0IHBoeSAqcGh5LCBpbnQgcG9ydCkgew0KPiAr
CWludCByZXQ7DQo+ICsNCj4gKwlpZiAoIXBoeSB8fCAhcGh5LT5vcHMtPmNvbm5lY3QpDQo+ICsJ
CXJldHVybiAwOw0KPiArDQo+ICsJbXV0ZXhfbG9jaygmcGh5LT5tdXRleCk7DQo+ICsJcmV0ID0g
cGh5LT5vcHMtPmNvbm5lY3QocGh5LCBwb3J0KTsNCj4gKwltdXRleF91bmxvY2soJnBoeS0+bXV0
ZXgpOw0KPiArDQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0xfR1BMKHBo
eV9ub3RpZnlfY29ubmVjdCk7DQo+ICsNCj4gKy8qKg0KPiArICogcGh5X25vdGlmeV9kaXNjb25u
ZWN0KCkgLSBwaHkgZGlzY29ubmVjdCBub3RpZnkNCj4gKyAqIEBwaHk6IHRoZSBwaHkgcmV0dXJu
ZWQgYnkgcGh5X2dldCgpDQo+ICsgKiBAcG9ydDogdGhlIHBvcnQgaW5kZXggZm9yIGRpc2Nvbm5l
Y3QNCj4gKyAqDQo+ICsgKiBJZiBwaHkgbmVlZCB0aGUgZ2V0IGRpc2Nvbm5lY3Rpb24gc3RhdHVz
LCB0aGUgY2FsbGJhY2sgY2FuIGJlIHVzZWQuDQo+ICsgKg0KPiArICogUmV0dXJuczogJTAgaWYg
c3VjY2Vzc2Z1bCwgYSBuZWdhdGl2ZSBlcnJvciBjb2RlIG90aGVyd2lzZSAgKi8gaW50DQo+ICtw
aHlfbm90aWZ5X2Rpc2Nvbm5lY3Qoc3RydWN0IHBoeSAqcGh5LCBpbnQgcG9ydCkgew0KPiArCWlu
dCByZXQ7DQo+ICsNCj4gKwlpZiAoIXBoeSB8fCAhcGh5LT5vcHMtPmRpc2Nvbm5lY3QpDQo+ICsJ
CXJldHVybiAwOw0KPiArDQo+ICsJbXV0ZXhfbG9jaygmcGh5LT5tdXRleCk7DQo+ICsJcmV0ID0g
cGh5LT5vcHMtPmRpc2Nvbm5lY3QocGh5LCBwb3J0KTsNCj4gKwltdXRleF91bmxvY2soJnBoeS0+
bXV0ZXgpOw0KPiArDQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCj4gK0VYUE9SVF9TWU1CT0xfR1BM
KHBoeV9ub3RpZnlfZGlzY29ubmVjdCk7DQo+ICsNCj4gIC8qKg0KPiAgICogcGh5X2NvbmZpZ3Vy
ZSgpIC0gQ2hhbmdlcyB0aGUgcGh5IHBhcmFtZXRlcnMNCj4gICAqIEBwaHk6IHRoZSBwaHkgcmV0
dXJuZWQgYnkgcGh5X2dldCgpDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3BoeS9waHku
aCBiL2luY2x1ZGUvbGludXgvcGh5L3BoeS5oIGluZGV4DQo+IGY2ZDYwN2VmMGU4MC4uY2Y5OGNi
MjlkZGFhIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3BoeS9waHkuaA0KPiArKysgYi9p
bmNsdWRlL2xpbnV4L3BoeS9waHkuaA0KPiBAQCAtMTIyLDYgKzEyMiw4IEBAIHN0cnVjdCBwaHlf
b3BzIHsNCj4gIAkJCSAgICB1bmlvbiBwaHlfY29uZmlndXJlX29wdHMgKm9wdHMpOw0KPiAgCWlu
dAkoKnJlc2V0KShzdHJ1Y3QgcGh5ICpwaHkpOw0KPiAgCWludAkoKmNhbGlicmF0ZSkoc3RydWN0
IHBoeSAqcGh5KTsNCj4gKwlpbnQJKCpjb25uZWN0KShzdHJ1Y3QgcGh5ICpwaHksIGludCBwb3J0
KTsNCj4gKwlpbnQJKCpkaXNjb25uZWN0KShzdHJ1Y3QgcGh5ICpwaHksIGludCBwb3J0KTsNCj4g
IAl2b2lkCSgqcmVsZWFzZSkoc3RydWN0IHBoeSAqcGh5KTsNCj4gIAlzdHJ1Y3QgbW9kdWxlICpv
d25lcjsNCj4gIH07DQo+IEBAIC0yNDMsNiArMjQ1LDggQEAgc3RhdGljIGlubGluZSBlbnVtIHBo
eV9tb2RlIHBoeV9nZXRfbW9kZShzdHJ1Y3QNCj4gcGh5ICpwaHkpICB9ICBpbnQgcGh5X3Jlc2V0
KHN0cnVjdCBwaHkgKnBoeSk7ICBpbnQgcGh5X2NhbGlicmF0ZShzdHJ1Y3QgcGh5DQo+ICpwaHkp
Ow0KPiAraW50IHBoeV9ub3RpZnlfY29ubmVjdChzdHJ1Y3QgcGh5ICpwaHksIGludCBwb3J0KTsg
aW50DQo+ICtwaHlfbm90aWZ5X2Rpc2Nvbm5lY3Qoc3RydWN0IHBoeSAqcGh5LCBpbnQgcG9ydCk7
DQo+ICBzdGF0aWMgaW5saW5lIGludCBwaHlfZ2V0X2J1c193aWR0aChzdHJ1Y3QgcGh5ICpwaHkp
ICB7DQo+ICAJcmV0dXJuIHBoeS0+YXR0cnMuYnVzX3dpZHRoOw0KPiBAQCAtMzk2LDYgKzQwMCwy
MCBAQCBzdGF0aWMgaW5saW5lIGludCBwaHlfY2FsaWJyYXRlKHN0cnVjdCBwaHkgKnBoeSkNCj4g
IAlyZXR1cm4gLUVOT1NZUzsNCj4gIH0NCj4gDQo+ICtzdGF0aWMgaW5saW5lIGludCBwaHlfbm90
aWZ5X2Nvbm5lY3Qoc3RydWN0IHBoeSAqcGh5LCBpbnQgaW5kZXgpIHsNCj4gKwlpZiAoIXBoeSkN
Cj4gKwkJcmV0dXJuIDA7DQo+ICsJcmV0dXJuIC1FTk9TWVM7DQo+ICt9DQo+ICsNCj4gK3N0YXRp
YyBpbmxpbmUgaW50IHBoeV9ub3RpZnlfZGlzY29ubmVjdChzdHJ1Y3QgcGh5ICpwaHksIGludCBp
bmRleCkgew0KPiArCWlmICghcGh5KQ0KPiArCQlyZXR1cm4gMDsNCj4gKwlyZXR1cm4gLUVOT1NZ
UzsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGlubGluZSBpbnQgcGh5X2NvbmZpZ3VyZShzdHJ1Y3Qg
cGh5ICpwaHksDQo+ICAJCQkJdW5pb24gcGh5X2NvbmZpZ3VyZV9vcHRzICpvcHRzKQ0KPiAgew0K
PiAtLQ0KPiAyLjM0LjENCg0K
