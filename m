Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098137F7293
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345806AbjKXLUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345395AbjKXLUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:20:41 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6792BD67;
        Fri, 24 Nov 2023 03:20:45 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AOBJODR03677396, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AOBJODR03677396
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Nov 2023 19:19:24 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 24 Nov 2023 19:19:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 24 Nov 2023 19:19:23 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 24 Nov 2023 19:19:23 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "kvalo@kernel.org" <kvalo@kernel.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "suhui@nfschina.com" <suhui@nfschina.com>,
        "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
        "trix@redhat.com" <trix@redhat.com>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linville@tuxdriver.com" <linville@tuxdriver.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lizetao1@huawei.com" <lizetao1@huawei.com>
Subject: Re: [PATCH v2 2/2] wifi: rtlwifi: rtl8821ae: phy: fix an undefined bitwise shift behavior
Thread-Topic: [PATCH v2 2/2] wifi: rtlwifi: rtl8821ae: phy: fix an undefined
 bitwise shift behavior
Thread-Index: AQHaHnqh3ek0X9cmrkSIvDKQ0v3B9rCJKRKA//+Pj4CAABQ4gA==
Date:   Fri, 24 Nov 2023 11:19:23 +0000
Message-ID: <02f0a505b3a02a3c5e29ac1e327acd1fc946188c.camel@realtek.com>
References: <cb551005-eff0-1391-92a0-d956b3d2b930@nfschina.com>
In-Reply-To: <cb551005-eff0-1391-92a0-d956b3d2b930@nfschina.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-originating-ip: [125.224.74.9]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <73149C689BB72D4CB2935FF1489D3537@realtek.com>
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

T24gRnJpLCAyMDIzLTExLTI0IGF0IDE4OjA2ICswODAwLCBTdSBIdWkgd3JvdGU6DQo+IA0KPiBP
biAyMDIzLzExLzI0IDE2OjUxLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gU3ViamVjdDogW1BB
VENIIHYyIDIvMl0gd2lmaTogcnRsd2lmaTogcnRsODgyMWFlOiBwaHk6IGZpeCBhbiB1bmRlZmlu
ZWQgYml0d2lzZSBzaGlmdCBiZWhhdmlvcg0KPiA+IA0KPiA+IFsuLi5dDQo+ID4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDg4MjFhZS9waHku
Yw0KPiA+ID4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvcnRsODgyMWFl
L3BoeS5jDQo+ID4gPiBpbmRleCA2ZGYyNzBlMjllNjYuLjUyYWIxYjA3NjFjMCAxMDA2NDQNCj4g
PiA+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9ydGw4ODIxYWUv
cGh5LmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9y
dGw4ODIxYWUvcGh5LmMNCj4gPiA+IEBAIC0zMSw3ICszMSwxMiBAQCBzdGF0aWMgdTMyIF9ydGw4
ODIxYWVfcGh5X2NhbGN1bGF0ZV9iaXRfc2hpZnQodTMyIGJpdG1hc2spDQo+ID4gPiAgIHsNCj4g
PiA+ICAgICAgICAgIHUzMiBpID0gZmZzKGJpdG1hc2spOw0KPiA+ID4gDQo+ID4gPiAtICAgICAg
IHJldHVybiBpID8gaSAtIDEgOiAzMjsNCj4gPiA+ICsgICAgICAgaWYgKCFpKSB7DQo+ID4gPiAr
ICAgICAgICAgICAgICAgV0FSTl9PTl9PTkNFKDEpOw0KPiA+ID4gKyAgICAgICAgICAgICAgIHJl
dHVybiAwOw0KPiA+ID4gKyAgICAgICB9DQo+ID4gPiArDQo+ID4gPiArICAgICAgIHJldHVybiBp
IC0gMTsNCj4gPiA+ICAgfQ0KPiA+IFBlcnNvbmFsbHksIEkgcHJlZmVyIHRvIHVzZSBfX2Zmcygp
LCBiZWNhdXNlIGluIG5vcm1hbCBjYXNlIG5vIG5lZWQgYWRkaXRpb25hbCAnLTEnLA0KPiA+IGFu
ZCBhYm5vcm1hbCBjYXNlcyBzaG91bGQgbm90IGhhcHBlbi4NCj4gDQo+IEhpLCAgUGluZy1LZQ0K
PiANCj4gUmVwbGFjZSBfcnRsODgyMWFlX3BoeV9jYWxjdWxhdGVfYml0X3NoaWZ0KCkgYnkgX19m
ZnMoYml0bWFzaykgaXMgYmV0dGVyLA0KPiBidXQgSSdtIG5vdCBzdXJlIHdoYXQgY2FsbGVycyBz
aG91bGQgZG8gd2hlbiBjYWxsZXJzIGNoZWNrIGJpdG1hc2sgaXMgMCBiZWZvcmUgY2FsbGluZy4N
Cj4gTWF5YmUgdGhpcyBjaGVjayBpcyB1c2VsZXNzPw0KPiANCj4gSSBjYW4gc2VuZCBhIHYzIHBh
dGNoIGlmIHVzaW5nICBfX2ZmcyhiaXRtYXNrKSBhbmQgbm8gY2hlY2sgZm9yIGJpdG1hc2sgaXMg
ZmluZS4NCj4gT3IgY291bGQgeW91IHNlbmQgdGhpcyBwYXRjaCBpZiB5b3UgaGF2ZSBhIGJldHRl
ciBpZGVhPw0KPiBUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbiENCj4gDQoNCkNhbiB0aGlzIHdv
cmsgdG8geW91PyANCg0Kc3RhdGljIHUzMiBfcnRsODgyMWFlX3BoeV9jYWxjdWxhdGVfYml0X3No
aWZ0KHUzMiBiaXRtYXNrKQ0Kew0KCWlmIChXQVJOX09OX09OQ0UoIWJpdG1hc2spKQ0KCQlyZXR1
cm4gMDsNCg0KCXJldHVybiBfX2ZmcyhiaXRtYXNrKTsNCn0NCg0KDQo=
