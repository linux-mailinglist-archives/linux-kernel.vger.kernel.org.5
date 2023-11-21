Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0E87F2604
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 07:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjKUG4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 01:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKUG4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 01:56:46 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81594BB;
        Mon, 20 Nov 2023 22:56:39 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AL6sDNI11388979, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AL6sDNI11388979
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 14:54:13 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 21 Nov 2023 14:54:13 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 21 Nov 2023 14:54:12 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Tue, 21 Nov 2023 14:54:12 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Kishon Vijay Abraham I <kvijayab@amd.com>,
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
Thread-Index: AQHaE5lppIbVtDBYMkuRe6XIgfyuz7CDzxSAgACVIpA=
Date:   Tue, 21 Nov 2023 06:54:12 +0000
Message-ID: <16319548dfc6446fa1874ec962da8f20@realtek.com>
References: <20231110054738.23515-1-stanley_chang@realtek.com>
 <2d234d31-3045-72f2-57db-db03515eebcf@amd.com>
In-Reply-To: <2d234d31-3045-72f2-57db-db03515eebcf@amd.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS2lzaG9uLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtpc2hv
biBWaWpheSBBYnJhaGFtIEkgPGt2aWpheWFiQGFtZC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE5v
dmVtYmVyIDIxLCAyMDIzIDE6NDcgUE0NCj4gVG86IFN0YW5sZXkgQ2hhbmdb5piM6IKy5b63XSA8
c3RhbmxleV9jaGFuZ0ByZWFsdGVrLmNvbT47IEdyZWcNCj4gS3JvYWgtSGFydG1hbiA8Z3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IENjOiBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwub3Jn
PjsgSm9oYW4gSG92b2xkIDxqb2hhbkBrZXJuZWwub3JnPjsgS2lzaG9uDQo+IFZpamF5IEFicmFo
YW0gSSA8a2lzaG9uQGtlcm5lbC5vcmc+OyBHZWVydCBVeXR0ZXJob2V2ZW4NCj4gPGdlZXJ0K3Jl
bmVzYXNAZ2xpZGVyLmJlPjsgSmluamllIFJ1YW4gPHJ1YW5qaW5qaWVAaHVhd2VpLmNvbT47IFJv
Yg0KPiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBBbGFuIFN0ZXJuIDxzdGVybkByb3dsYW5k
LmhhcnZhcmQuZWR1PjsgWWFuZw0KPiBZaW5nbGlhbmcgPHlhbmd5aW5nbGlhbmdAaHVhd2VpLmNv
bT47IEZsYXZpbyBTdWxpZ29pIDxmLnN1bGlnb2lAYXNlbS5pdD47DQo+IFJveSBMdW8gPHJveWx1
b0Bnb29nbGUuY29tPjsgSGVpa2tpIEtyb2dlcnVzDQo+IDxoZWlra2kua3JvZ2VydXNAbGludXgu
aW50ZWwuY29tPjsgUmljYXJkbyBDYcOxdWVsbw0KPiA8cmljYXJkby5jYW51ZWxvQGNvbGxhYm9y
YS5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1waHlAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgbGludXgtdXNiQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYzIDEvNF0gcGh5OiBjb3JlOiBhZGQgbm90aWZ5X2Nvbm5lY3QgYW5kDQo+IG5vdGlm
eV9kaXNjb25uZWN0IGNhbGxiYWNrDQo+IA0KPiANCj4gRXh0ZXJuYWwgbWFpbC4NCj4gDQo+IA0K
PiANCj4gSGkgU3RhbmxleSwNCj4gDQo+IE9uIDExLzEwLzIwMjMgMTE6MTUgQU0sIFN0YW5sZXkg
Q2hhbmcgd3JvdGU6DQo+ID4gSW4gUmVhbHRlayBTb0MsIHRoZSBwYXJhbWV0ZXIgb2YgdXNiIHBo
eSBpcyBkZXNpZ25lZCB0byBjYW4gZHluYW1pYw0KPiA+IHR1bmluZyBiYXNlIG9uIHBvcnQgc3Rh
dHVzLiBUaGVyZWZvcmUsIGFkZCBhIG5vdGlmeSBjYWxsYmFjayBvZiBwaHkNCj4gPiBkcml2ZXIg
d2hlbiB1c2IgY29ubmVjdGlvbi9kaXNjb25uZWN0aW9uIGNoYW5nZS4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFN0YW5sZXkgQ2hhbmcgPHN0YW5sZXlfY2hhbmdAcmVhbHRlay5jb20+DQo+ID4g
LS0tDQo+ID4gdjEgdG8gdjI6DQo+ID4gICAgICBObyBjaGFuZ2UNCj4gPiB2MiB0byB2MzoNCj4g
PiAgICAgIE5vIGNoYW5nZQ0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9waHkvcGh5LWNvcmUuYyAg
fCA0Nw0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAg
aW5jbHVkZS9saW51eC9waHkvcGh5LmggfCAxOCArKysrKysrKysrKysrKysrDQo+ID4gICAyIGZp
bGVzIGNoYW5nZWQsIDY1IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3BoeS9waHktY29yZS5jIGIvZHJpdmVycy9waHkvcGh5LWNvcmUuYyBpbmRleA0KPiA+IDk2
YTBiMWUxMTFmMy4uYTg0YWQ0ODk2YjdmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGh5L3Bo
eS1jb3JlLmMNCj4gPiArKysgYi9kcml2ZXJzL3BoeS9waHktY29yZS5jDQo+ID4gQEAgLTQ4OSw2
ICs0ODksNTMgQEAgaW50IHBoeV9jYWxpYnJhdGUoc3RydWN0IHBoeSAqcGh5KQ0KPiA+ICAgfQ0K
PiA+ICAgRVhQT1JUX1NZTUJPTF9HUEwocGh5X2NhbGlicmF0ZSk7DQo+ID4NCj4gPiArLyoqDQo+
ID4gKyAqIHBoeV9ub3RpZnlfY29ubmVjdCgpIC0gcGh5IGNvbm5lY3Qgbm90aWZ5DQo+ID4gKyAq
IEBwaHk6IHRoZSBwaHkgcmV0dXJuZWQgYnkgcGh5X2dldCgpDQo+ID4gKyAqIEBwb3J0OiB0aGUg
cG9ydCBpbmRleCBmb3IgY29ubmVjdA0KPiA+ICsgKg0KPiA+ICsgKiBJZiBwaHkgbmVlZCB0aGUg
Z2V0IGNvbm5lY3Rpb24gc3RhdHVzLCB0aGUgY2FsbGJhY2sgY2FuIGJlIHVzZWQuDQo+ID4gKyAq
IFJldHVybnM6ICUwIGlmIHN1Y2Nlc3NmdWwsIGEgbmVnYXRpdmUgZXJyb3IgY29kZSBvdGhlcndp
c2UgICovIGludA0KPiA+ICtwaHlfbm90aWZ5X2Nvbm5lY3Qoc3RydWN0IHBoeSAqcGh5LCBpbnQg
cG9ydCkgew0KPiA+ICsgICAgIGludCByZXQ7DQo+ID4gKw0KPiA+ICsgICAgIGlmICghcGh5IHx8
ICFwaHktPm9wcy0+Y29ubmVjdCkNCj4gPiArICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ICsN
Cj4gPiArICAgICBtdXRleF9sb2NrKCZwaHktPm11dGV4KTsNCj4gPiArICAgICByZXQgPSBwaHkt
Pm9wcy0+Y29ubmVjdChwaHksIHBvcnQpOw0KPiA+ICsgICAgIG11dGV4X3VubG9jaygmcGh5LT5t
dXRleCk7DQo+ID4gKw0KPiA+ICsgICAgIHJldHVybiByZXQ7DQo+ID4gK30NCj4gPiArRVhQT1JU
X1NZTUJPTF9HUEwocGh5X25vdGlmeV9jb25uZWN0KTsNCj4gPiArDQo+ID4gKy8qKg0KPiA+ICsg
KiBwaHlfbm90aWZ5X2Rpc2Nvbm5lY3QoKSAtIHBoeSBkaXNjb25uZWN0IG5vdGlmeQ0KPiA+ICsg
KiBAcGh5OiB0aGUgcGh5IHJldHVybmVkIGJ5IHBoeV9nZXQoKQ0KPiA+ICsgKiBAcG9ydDogdGhl
IHBvcnQgaW5kZXggZm9yIGRpc2Nvbm5lY3QNCj4gPiArICoNCj4gPiArICogSWYgcGh5IG5lZWQg
dGhlIGdldCBkaXNjb25uZWN0aW9uIHN0YXR1cywgdGhlIGNhbGxiYWNrIGNhbiBiZSB1c2VkLg0K
PiA+ICsgKg0KPiA+ICsgKiBSZXR1cm5zOiAlMCBpZiBzdWNjZXNzZnVsLCBhIG5lZ2F0aXZlIGVy
cm9yIGNvZGUgb3RoZXJ3aXNlICAqLyBpbnQNCj4gPiArcGh5X25vdGlmeV9kaXNjb25uZWN0KHN0
cnVjdCBwaHkgKnBoeSwgaW50IHBvcnQpIHsNCj4gPiArICAgICBpbnQgcmV0Ow0KPiA+ICsNCj4g
PiArICAgICBpZiAoIXBoeSB8fCAhcGh5LT5vcHMtPmRpc2Nvbm5lY3QpDQo+ID4gKyAgICAgICAg
ICAgICByZXR1cm4gMDsNCj4gPiArDQo+ID4gKyAgICAgbXV0ZXhfbG9jaygmcGh5LT5tdXRleCk7
DQo+ID4gKyAgICAgcmV0ID0gcGh5LT5vcHMtPmRpc2Nvbm5lY3QocGh5LCBwb3J0KTsNCj4gPiAr
ICAgICBtdXRleF91bmxvY2soJnBoeS0+bXV0ZXgpOw0KPiA+ICsNCj4gPiArICAgICByZXR1cm4g
cmV0Ow0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKHBoeV9ub3RpZnlfZGlzY29ubmVj
dCk7DQo+IA0KPiBQbGVhc2UgdXNlIEVYVENPTiBmcmFtZXdvcmsgZm9yIG5vdGlmeWluZyBjb25u
ZWN0L2Rpc2Nvbm5lY3QuDQoNCkRvIHlvdSBtZWFuIHJlZ2lzdGVyaW5nIG5vdGlmaWNhdGlvbnMg
dmlhIGV4dGNvbl9yZWdpc3Rlcl9ub3RpZmllcj8NCg0KQnV0IHRoZXJlIGlzIG5vIGV4dGNvbiBk
ZXZpY2UgcHJvdmlkZWQgaW4gdGhlIFVTQiBmcmFtZXdvcmsgdG8gbm90aWZ5IGNvbm5lY3QgYW5k
IGRpc2Nvbm5lY3QuDQpUaGVyZWZvcmUsIEkgYWRkZWQgdGhlIG5vdGlmaWNhdGlvbiBjb25uZWN0
aW9uL2Rpc2Nvbm5lY3Rpb24gYmFzZWQgb24gdGhlIGdlbmVyaWMgcGh5LiANClt2Myw0LzRdIHVz
YjogY29yZTogYWRkIHBoeSBub3RpZnkgY29ubmVjdCBhbmQgZGlzY29ubmVjdA0KaHR0cHM6Ly9w
YXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXVzYi9wYXRjaC8yMDIzMTExMDA1NDcz
OC4yMzUxNS00LXN0YW5sZXlfY2hhbmdAcmVhbHRlay5jb20vDQoNClRoYW5rcywNClN0YW5sZXkN
Cg==
