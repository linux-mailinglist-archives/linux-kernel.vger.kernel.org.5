Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D73980860D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjLGK3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjLGK3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:29:39 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9D310C8;
        Thu,  7 Dec 2023 02:29:41 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B7ASh8X2090781, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B7ASh8X2090781
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Dec 2023 18:28:43 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 7 Dec 2023 18:28:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 7 Dec 2023 18:28:42 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 7 Dec 2023 18:28:42 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Vinod Koul <vkoul@kernel.org>, Johan Hovold <johan@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        =?utf-8?B?UmljYXJkbyBDYcOxdWVsbw==?= 
        <ricardo.canuelo@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v3 RESEND 1/4] phy: core: add notify_connect and notify_disconnect callback
Thread-Topic: [PATCH v3 RESEND 1/4] phy: core: add notify_connect and
 notify_disconnect callback
Thread-Index: AQHaKOCi19hiykumv0upIYLDPa/PFrCdESyAgACIcOA=
Date:   Thu, 7 Dec 2023 10:28:42 +0000
Message-ID: <b94926603360473e9d6c0fc91cf31614@realtek.com>
References: <20231207074022.14116-1-stanley_chang@realtek.com>
 <2023120750-giggle-annotate-dc4f@gregkh>
In-Reply-To: <2023120750-giggle-annotate-dc4f@gregkh>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

SGkgR3JlZywNCg0KPiANCj4gT24gVGh1LCBEZWMgMDcsIDIwMjMgYXQgMDM6Mzg6MDRQTSArMDgw
MCwgU3RhbmxleSBDaGFuZyB3cm90ZToNCj4gPiBJbiBSZWFsdGVrIFNvQywgdGhlIHBhcmFtZXRl
ciBvZiB1c2IgcGh5IGlzIGRlc2lnbmVkIHRvIGNhbiBkeW5hbWljDQo+ID4gdHVuaW5nIGJhc2Ug
b24gcG9ydCBzdGF0dXMuIFRoZXJlZm9yZSwgYWRkIGEgbm90aWZ5IGNhbGxiYWNrIG9mIHBoeQ0K
PiA+IGRyaXZlciB3aGVuIHVzYiBjb25uZWN0aW9uL2Rpc2Nvbm5lY3Rpb24gY2hhbmdlLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogU3RhbmxleSBDaGFuZyA8c3RhbmxleV9jaGFuZ0ByZWFsdGVr
LmNvbT4NCj4gPiAtLS0NCj4gPiBSRVNFTkQ6DQo+ID4gICAgIEJlY2F1c2UgdGhlcmUgaXMgbm8g
ZXh0Y29uIGRldmljZSBwcm92aWRlZCBpbiB0aGUgVVNCIGZyYW1ld29yayB0bw0KPiA+ICAgICBu
b3RpZnkgY29ubmVjdCBhbmQgZGlzY29ubmVjdC4NCj4gPiAgICAgVGhlcmVmb3JlLCBJIGFkZGVk
IHRoZSBub3RpZmljYXRpb24gY29ubmVjdGlvbi9kaXNjb25uZWN0aW9uIGJhc2VkDQo+ID4gICAg
IG9uIHRoZSBnZW5lcmljIHBoeS4gU28gSSBubyB1c2UgdGhlIEVYVENPTiBmcmFtZXdvcmsgZm9y
IG5vdGlmeWluZw0KPiA+ICAgICBjb25uZWN0L2Rpc2Nvbm5lY3QuDQo+ID4gdjIgdG8gdjM6DQo+
ID4gICAgIE5vIGNoYW5nZQ0KPiA+IHYxIHRvIHYyOg0KPiA+ICAgICBObyBjaGFuZ2UNCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9waHkvcGh5LWNvcmUuYyAgfCA0Nw0KPiA+ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIGluY2x1ZGUvbGludXgvcGh5L3BoeS5o
IHwgMTggKysrKysrKysrKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDY1IGluc2VydGlv
bnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9waHktY29yZS5jIGIvZHJp
dmVycy9waHkvcGh5LWNvcmUuYyBpbmRleA0KPiA+IDk2YTBiMWUxMTFmMy4uYTg0YWQ0ODk2Yjdm
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGh5L3BoeS1jb3JlLmMNCj4gPiArKysgYi9kcml2
ZXJzL3BoeS9waHktY29yZS5jDQo+ID4gQEAgLTQ4OSw2ICs0ODksNTMgQEAgaW50IHBoeV9jYWxp
YnJhdGUoc3RydWN0IHBoeSAqcGh5KSAgfQ0KPiA+IEVYUE9SVF9TWU1CT0xfR1BMKHBoeV9jYWxp
YnJhdGUpOw0KPiA+DQo+ID4gKy8qKg0KPiA+ICsgKiBwaHlfbm90aWZ5X2Nvbm5lY3QoKSAtIHBo
eSBjb25uZWN0IG5vdGlmeQ0KPiA+ICsgKiBAcGh5OiB0aGUgcGh5IHJldHVybmVkIGJ5IHBoeV9n
ZXQoKQ0KPiA+ICsgKiBAcG9ydDogdGhlIHBvcnQgaW5kZXggZm9yIGNvbm5lY3QNCj4gPiArICoN
Cj4gPiArICogSWYgcGh5IG5lZWQgdGhlIGdldCBjb25uZWN0aW9uIHN0YXR1cywgdGhlIGNhbGxi
YWNrIGNhbiBiZSB1c2VkLg0KPiA+ICsgKiBSZXR1cm5zOiAlMCBpZiBzdWNjZXNzZnVsLCBhIG5l
Z2F0aXZlIGVycm9yIGNvZGUgb3RoZXJ3aXNlICAqLyBpbnQNCj4gPiArcGh5X25vdGlmeV9jb25u
ZWN0KHN0cnVjdCBwaHkgKnBoeSwgaW50IHBvcnQpIHsNCj4gPiArICAgICBpbnQgcmV0Ow0KPiA+
ICsNCj4gPiArICAgICBpZiAoIXBoeSB8fCAhcGh5LT5vcHMtPmNvbm5lY3QpDQo+ID4gKyAgICAg
ICAgICAgICByZXR1cm4gMDsNCj4gDQo+IEhvdyBjYW4gcGh5IGJlIG51bGw/DQo+IA0KPiBBbmQg
aXQgaXMgbm90IHN1Y2Nlc3NmdWwgaWYgY29ubmVjdCBpcyBub3QgdmFsaWQsIHNvIHdoeSBub3Qg
cmV0dXJuIGFuIGVycm9yIHRoZXJlPw0KDQpUaGlzIGlzIHBvc3NpYmxlLiBJZiBhIGNhbGxlciBu
byB1c2UgdGhlIGdlbmVyaWMgcGh5IG9yIG5vIGRlZmluZSB0aGUgY29ubmVjdCBjYWxsYmFjay4N
CkFuZCBpZiBubyBkZWZpbmUgY29ubmVjdCBjYWxsYmFjaywgaXQgd2lsbCBkbyBub3RoaW5nLiBT
byBubyBhbnkgZXJyb3IuDQoNCj4gPiArDQo+ID4gKyAgICAgbXV0ZXhfbG9jaygmcGh5LT5tdXRl
eCk7DQo+ID4gKyAgICAgcmV0ID0gcGh5LT5vcHMtPmNvbm5lY3QocGh5LCBwb3J0KTsNCj4gPiAr
ICAgICBtdXRleF91bmxvY2soJnBoeS0+bXV0ZXgpOw0KPiA+ICsNCj4gPiArICAgICByZXR1cm4g
cmV0Ow0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BMKHBoeV9ub3RpZnlfY29ubmVjdCk7
DQo+ID4gKw0KPiA+ICsvKioNCj4gPiArICogcGh5X25vdGlmeV9kaXNjb25uZWN0KCkgLSBwaHkg
ZGlzY29ubmVjdCBub3RpZnkNCj4gPiArICogQHBoeTogdGhlIHBoeSByZXR1cm5lZCBieSBwaHlf
Z2V0KCkNCj4gPiArICogQHBvcnQ6IHRoZSBwb3J0IGluZGV4IGZvciBkaXNjb25uZWN0DQo+ID4g
KyAqDQo+ID4gKyAqIElmIHBoeSBuZWVkIHRoZSBnZXQgZGlzY29ubmVjdGlvbiBzdGF0dXMsIHRo
ZSBjYWxsYmFjayBjYW4gYmUgdXNlZC4NCj4gPiArICoNCj4gPiArICogUmV0dXJuczogJTAgaWYg
c3VjY2Vzc2Z1bCwgYSBuZWdhdGl2ZSBlcnJvciBjb2RlIG90aGVyd2lzZSAgKi8gaW50DQo+ID4g
K3BoeV9ub3RpZnlfZGlzY29ubmVjdChzdHJ1Y3QgcGh5ICpwaHksIGludCBwb3J0KSB7DQo+ID4g
KyAgICAgaW50IHJldDsNCj4gPiArDQo+ID4gKyAgICAgaWYgKCFwaHkgfHwgIXBoeS0+b3BzLT5k
aXNjb25uZWN0KQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIDA7DQo+IA0KPiBTYW1lIGFzIGFi
b3ZlLg0KDQpTYW1lIGFzIGNvbm5lY3QgY2FsbGJhY2suDQoNCj4gPiArDQo+ID4gKyAgICAgbXV0
ZXhfbG9jaygmcGh5LT5tdXRleCk7DQo+ID4gKyAgICAgcmV0ID0gcGh5LT5vcHMtPmRpc2Nvbm5l
Y3QocGh5LCBwb3J0KTsNCj4gPiArICAgICBtdXRleF91bmxvY2soJnBoeS0+bXV0ZXgpOw0KPiA+
ICsNCj4gPiArICAgICByZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BM
KHBoeV9ub3RpZnlfZGlzY29ubmVjdCk7DQo+ID4gKw0KPiA+ICAvKioNCj4gPiAgICogcGh5X2Nv
bmZpZ3VyZSgpIC0gQ2hhbmdlcyB0aGUgcGh5IHBhcmFtZXRlcnMNCj4gPiAgICogQHBoeTogdGhl
IHBoeSByZXR1cm5lZCBieSBwaHlfZ2V0KCkgZGlmZiAtLWdpdA0KPiA+IGEvaW5jbHVkZS9saW51
eC9waHkvcGh5LmggYi9pbmNsdWRlL2xpbnV4L3BoeS9waHkuaCBpbmRleA0KPiA+IGY2ZDYwN2Vm
MGU4MC4uY2Y5OGNiMjlkZGFhIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvcGh5L3Bo
eS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9waHkvcGh5LmgNCj4gPiBAQCAtMTIyLDYgKzEy
Miw4IEBAIHN0cnVjdCBwaHlfb3BzIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgIHVu
aW9uIHBoeV9jb25maWd1cmVfb3B0cyAqb3B0cyk7DQo+ID4gICAgICAgaW50ICAgICAoKnJlc2V0
KShzdHJ1Y3QgcGh5ICpwaHkpOw0KPiA+ICAgICAgIGludCAgICAgKCpjYWxpYnJhdGUpKHN0cnVj
dCBwaHkgKnBoeSk7DQo+ID4gKyAgICAgaW50ICAgICAoKmNvbm5lY3QpKHN0cnVjdCBwaHkgKnBo
eSwgaW50IHBvcnQpOw0KPiA+ICsgICAgIGludCAgICAgKCpkaXNjb25uZWN0KShzdHJ1Y3QgcGh5
ICpwaHksIGludCBwb3J0KTsNCj4gDQo+IFlvdSBmb3Jnb3QgdG8gZG9jdW1lbnQgdGhlc2UgYW5k
IHdvdWxkIGhhdmUgYSB3YXJuaW5nIGZyb20gdGhlDQo+IGRvY3VtZW50YXRpb24gYnVpbGQgaWYg
dGhpcyB3YXMgYXBwbGllZCA6KA0KPiANCkkgd2lsbCBhZGQgYSBkZXNjcmlwdGlvbi4NCg0KPiA+
ICAgICAgIHZvaWQgICAgKCpyZWxlYXNlKShzdHJ1Y3QgcGh5ICpwaHkpOw0KPiA+ICAgICAgIHN0
cnVjdCBtb2R1bGUgKm93bmVyOw0KPiA+ICB9Ow0KPiA+IEBAIC0yNDMsNiArMjQ1LDggQEAgc3Rh
dGljIGlubGluZSBlbnVtIHBoeV9tb2RlIHBoeV9nZXRfbW9kZShzdHJ1Y3QNCj4gPiBwaHkgKnBo
eSkgIH0gIGludCBwaHlfcmVzZXQoc3RydWN0IHBoeSAqcGh5KTsgIGludA0KPiA+IHBoeV9jYWxp
YnJhdGUoc3RydWN0IHBoeSAqcGh5KTsNCj4gPiAraW50IHBoeV9ub3RpZnlfY29ubmVjdChzdHJ1
Y3QgcGh5ICpwaHksIGludCBwb3J0KTsgaW50DQo+ID4gK3BoeV9ub3RpZnlfZGlzY29ubmVjdChz
dHJ1Y3QgcGh5ICpwaHksIGludCBwb3J0KTsNCj4gPiAgc3RhdGljIGlubGluZSBpbnQgcGh5X2dl
dF9idXNfd2lkdGgoc3RydWN0IHBoeSAqcGh5KSAgew0KPiA+ICAgICAgIHJldHVybiBwaHktPmF0
dHJzLmJ1c193aWR0aDsNCj4gPiBAQCAtMzk2LDYgKzQwMCwyMCBAQCBzdGF0aWMgaW5saW5lIGlu
dCBwaHlfY2FsaWJyYXRlKHN0cnVjdCBwaHkgKnBoeSkNCj4gPiAgICAgICByZXR1cm4gLUVOT1NZ
UzsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbmxpbmUgaW50IHBoeV9ub3RpZnlfY29ubmVj
dChzdHJ1Y3QgcGh5ICpwaHksIGludCBpbmRleCkgew0KPiA+ICsgICAgIGlmICghcGh5KQ0KPiA+
ICsgICAgICAgICAgICAgcmV0dXJuIDA7DQo+IA0KPiBXaHkgY2hlY2sgdGhpcz8NCg0KSXQgaXMg
bm9ybWFsIGZvciBwaHkgdG8gYmUgbnVsbC4NCkJ1dCBpZiBwaHkgaXMgbm90IGVtcHR5LCAtRU5P
U1lTIHNob3VsZCBiZSByZXR1cm5lZCB0byBpbmRpY2F0ZSB0aGUgZXJyb3IgIk9wZXJhdGlvbiBu
b3Qgc3VwcG9ydGVkIi4NCk90aGVyIGNhbGxiYWNrcyBhbHNvIGZvbGxvdyB0aGlzIHJ1bGUuDQoN
Cj4gPiArICAgICByZXR1cm4gLUVOT1NZUzsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGlu
bGluZSBpbnQgcGh5X25vdGlmeV9kaXNjb25uZWN0KHN0cnVjdCBwaHkgKnBoeSwgaW50IGluZGV4
KSB7DQo+ID4gKyAgICAgaWYgKCFwaHkpDQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gMDsNCj4g
DQo+IEFnYWluLCB3aHkgY2hlY2sgdGhpcz8NCg0KQXMgYWJvdmUuDQoNClRoYW5rcywNClN0YW5s
ZXkNCg==
