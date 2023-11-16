Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E999C7EE42E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbjKPPZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjKPPZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:25:55 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582EF19D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:25:50 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AGFPJqL42493435, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AGFPJqL42493435
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Nov 2023 23:25:19 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 16 Nov 2023 23:25:20 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 16 Nov 2023 23:25:19 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3]) by
 RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3%2]) with mapi id
 15.01.2375.007; Thu, 16 Nov 2023 23:25:19 +0800
From:   =?big5?B?SmFtZXMgVGFpIFvAuafTrnBd?= <james.tai@realtek.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
CC:     Marc Zyngier <maz@kernel.org>
Subject: RE: [PATCH 2/6] irqchip: Add interrupt controller support for Realtek DHC SoCs
Thread-Topic: [PATCH 2/6] irqchip: Add interrupt controller support for
 Realtek DHC SoCs
Thread-Index: AQHaEKS4z5qABbyTp0Oos88YK3fZDbB9FzyA
Date:   Thu, 16 Nov 2023 15:25:19 +0000
Message-ID: <7d6211e66d4942c785ada6bd1d46c0b5@realtek.com>
References: <20231102142731.2087245-1-james.tai@realtek.com>
 <20231102142731.2087245-3-james.tai@realtek.com> <87wmuvgluc.ffs@tglx>
In-Reply-To: <87wmuvgluc.ffs@tglx>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [114.25.87.77]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="big5"
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

SGkgVGhvbWFzLA0KDQo+PiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBUYWkgPGphbWVzLnRhaUByZWFs
dGVrLmNvbT4NCj4+IENoYW5nZS1JZDogSTFlNzExYzcwNDE0Yzk3YzJjODQ5N2JkNGFjOWU4YmJk
OTY0MjI1YzMNCj4NCj5QbGVhc2UgcmVtb3ZlIHRoZXNlIGludGVybmFsIGNoYW5nZSBpZHMuIFRo
ZXkgYXJlIG5vdCB1c2VmdWwgZm9yIGFueW9uZSBvdXRzaWRlDQo+cmVhbHRlay4NCj4NCkkgd2ls
bCBmaXggaXQgaW4gdGhlIG5leHQgcGF0Y2hlcy4NCg0KPg0KPj4gK3N0YXRpYyB1bnNpZ25lZCBp
bnQgcmVhbHRla19pbnRjX2dldF9pbnRzKHN0cnVjdCByZWFsdGVrX2ludGNfZGF0YQ0KPj4gKypk
YXRhKQ0KPg0KPnN0YXRpYyBpbmxpbmUgcGVyaGFwcz8NCj4NClllcy4gSSB3aWxsIHVzZSAnc3Rh
dGljIGlubGluZScgdG8gcmVwbGFjZSBpdC4NCg0KPj4gK3N0YXRpYyB1bnNpZ25lZCBpbnQgcmVh
bHRla19pbnRjX2dldF9pbnRlKHN0cnVjdCByZWFsdGVrX2ludGNfZGF0YQ0KPj4gKypkYXRhKSB7
DQo+PiArICAgICB1bnNpZ25lZCBpbnQgdmFsOw0KPj4gKyAgICAgdW5zaWduZWQgbG9uZyBmbGFn
czsNCj4NCj4gICAgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICAgICAgICB1bnNpZ25lZCBp
bnQgdmFsOw0KPg0KPmh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L3Byb2Nl
c3MvbWFpbnRhaW5lci10aXAuaHRtbA0KPg0KPlBsZWFzZSBmaXggdGhlIHZhcmlhYmxlIGRlY2xh
cmF0aW9ucyBhbGwgb3ZlciB0aGUgcGxhY2UuDQo+DQpJIHdpbGwgZml4IGl0IGluIHRoZSBuZXh0
IHBhdGNoZXMuDQoNCj4+ICsgICAgIHNwaW5fbG9ja19pcnFzYXZlKCZkYXRhLT5sb2NrLCBmbGFn
cyk7DQo+DQo+VGhpcyBuZWVkcyB0byBiZSBhIHJhdyBzcGlubG9jay4NCj4NCkkgd2lsbCBmaXgg
aXQgaW4gdGhlIG5leHQgcGF0Y2hlcy4NCg0KPg0KPg0KPj4gK3N0YXRpYyB2b2lkIHJlYWx0ZWtf
aW50Y19lbmFibGVfaXJxKHN0cnVjdCBpcnFfZGF0YSAqZGF0YSkgew0KPj4gKyAgICAgc3RydWN0
IHJlYWx0ZWtfaW50Y19kYXRhICppbnRjX2RhdGEgPQ0KPmlycV9kYXRhX2dldF9pcnFfY2hpcF9k
YXRhKGRhdGEpOw0KPj4gKyAgICAgdW5zaWduZWQgbG9uZyBmbGFnczsNCj4+ICsgICAgIHUzMiBz
Y3B1X2ludF9lbiwgbWFzazsNCj4NCj5TZWUgYWJvdmUuDQo+DQpJIHdpbGwgZml4IGl0IGluIHRo
ZSBuZXh0IHBhdGNoZXMuDQoNCj4NCj5TbyB5b3UgdXBkYXRlIHRoZSBlZmZlY3RpdmUgYWZmaW5p
dHkgZXZlbiBpZiBpdCBjYW5ub3QgYmUgc2V0IG9yIGlmIHRoZSBwYXJlbnQgaXJxDQo+cmV0dXJu
cyBhbiBlcnJvciBjb2RlPw0KPg0KPkFzaWRlIG9mIHRoYXQgc2V0dGluZyBpdCB0byBjcHVfb25s
aW5lIG1hc2sgaXMganVzdCB3cm9uZy4gVGhpcyBpcyBfTk9UXyB0aGUNCj5lZmZlY3RpdmUgYWZm
aW5pdHkgYmVjYXVzZSB0aGUgdW5kZXJseWluZyBHSUMgc2VsZWN0cyBhIHNpbmdsZSB0YXJnZXQg
Q1BVIG91dCBvZg0KPnRoZSBjYWxsZXIgcHJvdmlkZXMgY3B1IG1hc2suDQo+DQo+VGhhdCBzYWlk
LCB0aGlzIGlzIGFsc28gY29tcGxldGVseSBpbmNvbnNpc3RlbnQgdnMuIHRoZSBvdGhlciBpbnRl
cnJ1cHRzIHdoaWNoDQo+c2hhcmUgdGhhdCBHSUMgaW50ZXJydXB0IGluc3RhbmNlLiBJLmUuIC9w
cm9jL2lycS8kTi9hZmZpbml0eSBhbmQgZWZmZWN0aXZlX2FmZmluaXR5DQo+YmVjb21lIHJhbmRv
bSBudW1iZXIgZ2VuZXJhdG9ycy4gVGhhdCdsbCBjb25mdXNlIGV4aXN0aW5nIHVzZXJzcGFjZSB0
b29scy4NCj4NCj5IYXZpbmcgYW4gYWZmaW5pdHkgc2V0dGVyIGZvciBkZW11bHRpcGxleGVzIGlu
dGVycnVwdHMgaXMgc2ltcGx5IHdyb25nLg0KPg0KSSB3aWxsIHVzZSB0aGUgJ2lycV9jaGlwX3Nl
dF9hZmZpbml0eV9wYXJlbnQnIHJlcGxhY2UgdGhlICdyZWFsdGVrX2ludGNfc2V0X2FmZmluaXR5
Jy4NCg0KPj4gK3N0YXRpYyBzdHJ1Y3QgaXJxX2NoaXAgcmVhbHRla19pbnRjX2NoaXAgPSB7DQo+
PiArICAgICAubmFtZSA9ICJyZWFsdGVrLWludGMiLA0KPj4gKyAgICAgLmlycV9tYXNrID0gcmVh
bHRla19pbnRjX21hc2tfaXJxLA0KPj4gKyAgICAgLmlycV91bm1hc2sgPSByZWFsdGVrX2ludGNf
dW5tYXNrX2lycSwNCj4+ICsgICAgIC5pcnFfZW5hYmxlID0gcmVhbHRla19pbnRjX2VuYWJsZV9p
cnEsDQo+PiArICAgICAuaXJxX2Rpc2FibGUgPSByZWFsdGVrX2ludGNfZGlzYWJsZV9pcnEsDQo+
PiArICAgICAuaXJxX3NldF9hZmZpbml0eSA9IHJlYWx0ZWtfaW50Y19zZXRfYWZmaW5pdHksDQo+
DQo+U2VlIGRvY3MgdnMuIGZvcm1hdHRpbmcgb2Ygc3RydWN0IGluaXRpYWxpemVycy4NCj4NCkkg
d2lsbCBmaXggaXQgaW4gdGhlIG5leHQgcGF0Y2hlcy4NCg0KPj4gK307DQo+PiArDQo+PiArDQo+
PiArICAgICBkYXRhLT5zdWJzZXRfZGF0YV9udW0gPSBpbmZvLT5jZmdfbnVtOw0KPj4gKyAgICAg
Zm9yIChpID0gMDsgaSA8IGluZm8tPmNmZ19udW07IGkrKykgew0KPj4gKyAgICAgICAgICAgICBy
ZXQgPSByZWFsdGVrX2ludGNfc3Vic2V0KG5vZGUsIGRhdGEsIGkpOw0KPj4gKyAgICAgICAgICAg
ICBXQVJOKHJldCwgImZhaWxlZCB0byBpbml0IHN1YnNldCAlZDogJWQiLCBpLCByZXQpOw0KPg0K
PklmIHRoaXMgZmFpbHMsIHRoZW4geW91IHN0aWxsIGV4cG9zZSB0aGUgYWZmZWN0ZWQgaW50ZXJy
dXB0cyBhcyBmdW5jdGlvbmFsPw0KDQpJIHdpbGwgbW9kaWZ5IHRoZSBjb2RlIHRvIHJldHVybiBh
biBlcnJvciBjb2RlIGFuZCBzdG9wIHRoZSBkcml2ZXIgaW5pdGlhbGl6YXRpb24uDQoNCj4NCj4+
ICsvKioNCj4+ICsgKiByZWFsdGVrX2ludGNfc3Vic2V0X2NmZyAtIHN1YnNldCBpbnRlcnJ1cHQg
bWFzaw0KPj4gKyAqIEBpbnRzX21hc2s6IGluZXRycnVwdCBtYXNrDQo+PiArICovDQo+PiArc3Ry
dWN0IHJlYWx0ZWtfaW50Y19zdWJzZXRfY2ZnIHsNCj4+ICsgICAgIHVuc2lnbmVkIGludCBpbnRz
X21hc2s7DQo+PiArfTsNCj4+ICsNCj4+ICsvKioNCj4+ICsgKiByZWFsdGVrX2ludGNfaW5mbyAt
IGludGVycnVwdCBjb250cm9sbGVyIGRhdGEuDQo+PiArICogQGlzcl9vZmZzZXQ6IGludGVycnVw
dCBzdGF0dXMgcmVnaXN0ZXIgb2Zmc2V0Lg0KPj4gKyAqIEB1bXNrX2lzcl9vZmZzZXQ6IHVubWFz
ayBpbnRlcnJ1cHQgc3RhdHVzIHJlZ2lzdGVyIG9mZnNldC4NCj4+ICsgKiBAc2NwdV9pbnRfZW5f
b2Zmc2V0OiBpbnRlcnJ1cHQgZW5hYmxlIHJlZ2lzdGVyIG9mZnNldC4NCj4+ICsgKiBAY2ZnOiBj
Zmcgb2YgdGhlIHN1YnNldC4NCj4+ICsgKiBAY2ZnX251bTogbnVtYmVyIG9mIGNmZy4NCj4+ICsg
Ki8NCj4+ICtzdHJ1Y3QgcmVhbHRla19pbnRjX2luZm8gew0KPj4gKyAgICAgdW5zaWduZWQgaW50
IGlzcl9vZmZzZXQ7DQo+PiArICAgICB1bnNpZ25lZCBpbnQgdW1za19pc3Jfb2Zmc2V0Ow0KPj4g
KyAgICAgdW5zaWduZWQgaW50IHNjcHVfaW50X2VuX29mZnNldDsNCj4+ICsgICAgIGNvbnN0IHUz
MiAqaXNyX3RvX3NjcHVfaW50X2VuX21hc2s7DQo+PiArICAgICBjb25zdCBzdHJ1Y3QgcmVhbHRl
a19pbnRjX3N1YnNldF9jZmcgKmNmZzsNCj4+ICsgICAgIGludCBjZmdfbnVtOw0KPg0KPlNlZSBm
b3JtYXR0aW5nIGRvYy4NCg0KSSB3aWxsIGZpeCBpdCBpbiB0aGUgbmV4dCBwYXRjaGVzLg0KDQo+
PiArDQo+PiArI2RlZmluZSBJUlFfQUxXQVlTX0VOQUJMRUQgICgtMSkNCj4NCj5VMzJfTUFYID8N
Cj4NCkkgd2lsbCB1c2UgJ1UzMl9NQVgnIHRvIHJlcGxhY2UgJy0xJy4NCg0KPj4gKyNkZWZpbmUg
RElTQUJMRV9JTlRDICgwKQ0KPj4gKyNkZWZpbmUgQ0xFQU5fSU5UQ19TVEFUVVMgKDB4ZmZmZmZm
ZmUpDQo+DQo+VGhhdCdzIHdoYXQgR0VOTUFTSygpIGlzIGZvci4NCj4NCkkgd2lsbCB1c2UgJyBH
RU5NQVNLKDMxLCAxKSAnIHRvIHJlcGxhY2UgJzB4ZmZmZmZmZmUgJy4NCg0KVGhhbmsgeW91IGZv
ciB5b3VyIGZlZWRiYWNrLg0KDQpSZWdhcmRzLA0KSmFtZXMNCg0KDQo=
