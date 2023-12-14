Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558B48129DB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbjLNH6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbjLNH6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:58:14 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D2F126;
        Wed, 13 Dec 2023 23:58:15 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BE7vucY7703674, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BE7vucY7703674
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 15:57:56 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 14 Dec 2023 15:57:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 14 Dec 2023 15:57:55 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 14 Dec 2023 15:57:55 +0800
From:   =?utf-8?B?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?= <tychang@realtek.com>
To:     Andy Shevchenko <andy@kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] Add GPIO support for Realtek DHC(Digital Home Center) RTD SoCs.
Thread-Topic: [PATCH v3 2/2] Add GPIO support for Realtek DHC(Digital Home
 Center) RTD SoCs.
Thread-Index: AQHaKPU79lITdFvfw06smVDh+ZvZWbCdTzKAgAeXZrCAAdUdAIABjNeA
Date:   Thu, 14 Dec 2023 07:57:55 +0000
Message-ID: <23574204547646779d02f0109c20b3ff@realtek.com>
References: <20231207100723.15015-1-tychang@realtek.com>
 <20231207100723.15015-3-tychang@realtek.com>
 <ZXHMbZRXLXGa_tq8@smile.fi.intel.com>
 <989146448858478b975c66899b8f3fed@realtek.com>
 <ZXm0MIub8X2q_lnp@smile.fi.intel.com>
In-Reply-To: <ZXm0MIub8X2q_lnp@smile.fi.intel.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.181.166]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keSwNCg0KVGhhbmsgeW91IGZvciB0aGUgc3VnZ2VzdGlvbnMuDQoNCj5PbiBUdWUsIERl
YyAxMiwgMjAyMyBhdCAwOTo1NTo1OUFNICswMDAwLCBUWV9DaGFuZ1vlvLXlrZDpgLhdIHdyb3Rl
Og0KPj4gPk9uIFRodSwgRGVjIDA3LCAyMDIzIGF0IDA2OjA3OjIzUE0gKzA4MDAsIFRZIENoYW5n
IHdyb3RlOg0KPg0KPi4uLg0KPg0KPj4gPj4gVGhpcyBkcml2ZXIgZW5hYmxlcyBjb25maWd1cmF0
aW9uIG9mIEdQSU8gZGlyZWN0aW9uLCBHUElPIHZhbHVlcywNCj4+ID4+IEdQSU8gZGVib3VuY2Ug
c2V0dGluZ3MgYW5kIGhhbmRsZXMgR1BJTyBpbnRlcnJ1cHRzLg0KPj4gPg0KPj4gPldoeSBncGlv
LXJlZ21hcCBjYW4ndCBiZSB1c2VkPw0KPj4NCj4+IEkgd2lsbCB0cnkgdG8gdXNlIGdwaW8tcmVt
YXAgaW4gdGhlIG5leHQgdmVyc2lvbi4NCj4NCj5JZiBpdCBhcHBlYXJzIHRoYXQgaXQgbWFrZXMg
Y29kZSB1Z2xpZXIgLyBjb21wbGljYXRlZCwgcGxlYXNlIGFkZCB0aGUgbm90ZQ0KPnNvbWV3aGVy
ZSB0byBhbnN3ZXIgdGhlIGFib3ZlIHF1ZXN0aW9uLg0KPg0KDQpJJ3ZlIHRyYWNlZCB0aGUgZ3Bp
by1yZWdtYXAuYyBmaWxlLiBJdCBhcHBlYXJzIHRoYXQgZm9yIHRoZSBkcml2ZXIgdG8gcmVnaXN0
ZXINCmdwaW9faXJxX2NoaXAsIGl0IG11c3QgY3JlYXRlIHRoZSBpcnFfZG9tYWluIGFuZCBhZGQg
aXQgaW50byBncGlvX3JlZ21hcF9jb25maWcuDQpBZGRpdGlvbmFsbHksIHRoZSBkcml2ZXIgbmVl
ZHMgdG8gcmVnaXN0ZXIgdGhlIGlycSBoYW5kbGVyIGJ5IGl0c2VsZi4NCkhvd2V2ZXIsIHRoaXMg
cHJvY2VzcyBjYW4gYmUgbWFuYWdlZCBieSB0aGUgZ3Bpb2xpYiBpZiB0aGUgZHJpdmVyIGZpbGxz
IGluIHRoZSBzdHJ1Y3QNCmdwaW9faXJxX2NoaXAgaW5zaWRlIHN0cnVjdCBncGlvX2NoaXAgYmVm
b3JlIGludm9raW5nIGdwaW9jaGlwX2FkZF9kYXRhLg0KDQpNb3Jlb3ZlciwgYXBhcnQgZnJvbSBt
YW5hZ2luZyB0aGUgcmVnaXN0ZXJzIGZvciBncGlvIGRpcmVjdGlvbiBhbmQgdmFsdWUsIHRoZXJl
DQphcmUgc2V2ZXJhbCBvdGhlciByZWdpc3RlcnMgdGhhdCByZXF1aXJlIGFjY2VzcyhpbnRlcnJ1
cHQgZW5hYmxlLCBkZWJvdW5jZS4uLikuDQpUaGUgR1BJTyBJUlEgc3RhdHVzIHJlZ2lzdGVycyBh
cmUgbG9jYXRlZCBhdCBkaWZmZXJlbnQgYmFzZSBhZGRyZXNzZXMgYW5kIGFyZQ0Kbm90IGNvbnRp
Z3VvdXMuIEl0IG1heSBuZWVkIHRvIGNyZWF0ZSBhbiBhZGRpdGlvbmFsIHJlZ21hcCBhbmQgYXNz
aWduIHRoZSBhY2Nlc3MNCnRhYmxlIHRvIHRoaXMgcmVnbWFwLg0KDQpXaXRoIHRoZSBhYm92ZSBj
b25zaWRlcmF0aW9uLCBJIHRlbmQgdG8ga2VlcCB1c2luZyB0aGUgZXhpc3RpbmcgbWV0aG9kLg0K
DQo+Li4uDQo+DQo+PiA+PiArICAgICBpZiAoaW5kZXggPiBkYXRhLT5pbmZvLT5udW1fZGlyKQ0K
Pj4gPj4gKyAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4+ID4NCj4+ID5XaGVuIHRoaXMg
Y29uZGl0aW9uYWwgY2FuIGJlIHRydWU/DQo+PiA+U2FtZSBRIHRvIHRoZSBzaW1pbGFyIGNoZWNr
cyBvdmVyIHRoZSBjb2RlLg0KPj4NCj4+IEl0IGlzIG9ubHkgdG8gY2hlY2sgaWYgdGhlIG9mZnNl
dCB2YWx1ZSBpcyBtaXNzaW5nIGluIHRoZSBydGRfZ3Bpb19pbmZvLg0KPj4gSSdtIHVuY2VydGFp
biBhYm91dCB0aGUgbmVjZXNzaXR5IG9mIHRoZXNlIGNoZWNrcy4gSWYgdGhleSBhcmUgbm90DQo+
PiBuZWNlc3NhcnksIEkgd2lsbCByZW1vdmUgdGhlIG51bV8qIG1lbWJlcnMgaW4gdGhlIHJ0ZF9n
cGlvX2luZm8NCj4+IHN0cnVjdHVyZSBhbG9uZyB3aXRoIHRoZXNlIGNoZWNrcy4NCj4NCj5NeSB1
bmRlcnN0YW5kaW5nIHRoYXQgdGhlc2UgY2hlY2tzIGFyZSBlcXVpdmFsZW50IHRvIHRoZQ0KPg0K
PiAgICAgICAgaWYgKG9mZnNldCA+PSBuZ3BpbykNCj4NCj5vbmUsIHdoaWNoIGlzIHBlcmZvcm1l
ZCBieSBHUElPIGxpYnJhcnksIGkuby53LiB5b3Ugd2lsbCBuZXZlciBnZXQgYW4gb2Zmc2V0DQo+
b3V0c2lkZSB0aGUgcmFuZ2Ugb2Ygc3VwcG9ydGVkIEdQSU8gbGluZXMuDQo+DQo+SWYgbXkgdW5k
ZXJzdGFuZGluZyBpcyB3cm9uZywgdGhlc2UgY2hlY2tzIG5lZWQgYSBjb21tZW50IHdoeS4NCj4N
Cg0KSSBhZ3JlZSB3aXRoIHlvdS4gSSB3aWxsIHJlbW92ZSB0aGVzZSBjaGVja3MuDQoNCj4uLi4N
Cj4NCj4+ID4+ICsgICAgIGlmIChpcnEgPT0gZGF0YS0+aXJxc1swXSkNCj4+ID4+ICsgICAgICAg
ICAgICAgZ2V0X3JlZ19vZmZzZXQgPSAmcnRkX2dwaW9fZ3BhX29mZnNldDsNCj4+ID4+ICsgICAg
IGVsc2UgaWYgKGlycSA9PSBkYXRhLT5pcnFzWzFdKQ0KPj4gPj4gKyAgICAgICAgICAgICBnZXRf
cmVnX29mZnNldCA9ICZydGRfZ3Bpb19ncGRhX29mZnNldDsNCj4+ID4NCj4+ID5DYW4ndCBpdCBi
ZSBkb25lIGJlZm9yZSBlbnRlcmluZyBpbnRvIGNoYWluZWQgSVJRIGhhbmRsZXI/DQo+Pg0KPj4g
SSB3aWxsIHJldmlzZSBpdC4NCj4NCj5UaGlua2luZyBhYm91dCB0aGlzIG1vcmUsIHBlcmhhcHMg
eW91IGNhbiByZWdpc3RlciB0d28gSVJRIGNoaXBzIHdpdGggZGlmZmVyZW50DQo+ZnVuY3Rpb25z
LCBzbyB0aGlzIHdvbid0IGJlIHBhcnQgb2YgdGhlIHZlcnkgY3JpdGljYWwgaW50ZXJydXB0IGhh
bmRsZXIgKGFzIHdlIGFsbA0KPndhbnQgdG8gcmVkdWNlIG92ZXJoZWFkIGluIGl0IGFzIG11Y2gg
YXMgcG9zc2libGUpLg0KPkFueXdheSwgdGhpbmsgYWJvdXQgdGhpcyBhbmQgdHJ5IGRpZmZlcmVu
dCBvcHRpb25zLCBjaG9vc2UgdGhlIG9uZSB5b3UgdGhpbmsgdGhlDQo+YmVzdC4NCj4NCg0KSW4g
dGhlIHByZXZpb3VzIHBhdGNoICh2MSksIEkgaGFkIHJlZ2lzdGVyZWQgdHdvIElSUSBjaGlwcyB3
aXRoIGRpZmZlcmVudCBoYW5kbGVycy4gDQpIb3dldmVyLCB0aGVzZSB0d28gaGFuZGxlcnMgYXBw
ZWFyZWQgcXVpdGUgc2ltaWxhciBhbmQgdGhlIGdwaW9faXJxX2NoaXAgb25seSBhbGxvd3MNCnRo
ZSByZWdpc3RyYXRpb24gb2YgYSBzaW5nbGUgaGFuZGxlci4gVGhlcmVmb3JlLCBJIGVuZGVkIHVw
IHJlZ2lzdGVyaW5nIG9uZSBoYW5kbGVyDQpmb3IgYm90aCBJUlFzIGFuZCBpbmNsdWRlZCBjb25k
aXRpb25hbCBjaGVja3Mgd2l0aGluIHRoZSBoYW5kbGVyIHRvIGRpZmZlcmVudGlhdGUNCmJldHdl
ZW4gdGhlIHR3by4NCg0KPi0tDQo+V2l0aCBCZXN0IFJlZ2FyZHMsDQo+QW5keSBTaGV2Y2hlbmtv
DQoNClRoYW5rcywNClR6dXlpIENoYW5nDQo=
