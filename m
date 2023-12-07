Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7921808071
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 07:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjLGF7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 00:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLGF7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 00:59:47 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0E1D44;
        Wed,  6 Dec 2023 21:59:50 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B75xY9L14146789, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B75xY9L14146789
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Dec 2023 13:59:34 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 7 Dec 2023 13:59:34 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 7 Dec 2023 13:59:34 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3]) by
 RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3%2]) with mapi id
 15.01.2375.007; Thu, 7 Dec 2023 13:59:34 +0800
From:   =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 1/6] dt-bindings: interrupt-controller: Add support for Realtek DHC SoCs
Thread-Topic: [PATCH v2 1/6] dt-bindings: interrupt-controller: Add support
 for Realtek DHC SoCs
Thread-Index: AQHaGXMHJnbDooY4VkyEcMH4aisPjrCBFAaAgAG3OTCAE2RqMIABC34AgACK6PD//42bAIADJhOw//98noCAAgAXEIAAKXGAgAERTZA=
Date:   Thu, 7 Dec 2023 05:59:33 +0000
Message-ID: <caa94d5b82f14c168fd3cfda88664623@realtek.com>
References: <20231117162709.1096585-1-james.tai@realtek.com>
 <20231117162709.1096585-2-james.tai@realtek.com>
 <c3a98e2c-ba62-4798-a0d0-a8bc1fe5bb6b@linaro.org>
 <7959920acf004f3cb8072de1e17439fa@realtek.com>
 <e1490203387d4c48a5f8c4040ece038a@realtek.com>
 <6250c57b-6d38-4085-9a79-58e4e5ed1e3d@linaro.org>
 <cf2f9fd124514cb9832e942e16b8fa6e@realtek.com>
 <5134d2c7-b499-400d-bec8-ae0de1eff7db@linaro.org>
 <f27cb5d8943e44b597a13d7655edf4d0@realtek.com>
 <3356a35c-0c50-4539-a955-01d2e67b4eca@linaro.org>
 <612d61f5fae0415f9c8eb93b12f49645@realtek.com>
 <7f0c906c-9b36-4b29-bb8a-d65621e9e08b@linaro.org>
In-Reply-To: <7f0c906c-9b36-4b29-bb8a-d65621e9e08b@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [49.216.16.144]
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

SGkgS3J6eXN6dG9mLA0KDQo+Pg0KPj4gICAgIG1pc2NfaXJxX211eDogbWlzY19pcnFfbXV4QDgw
IHsNCj4+ICAgICAgIGNvbXBhdGlibGUgPSAicmVhbHRlayxydGQxNjE5Yi1pbnRjLW1pc2MiOw0K
Pj4gICAgICAgcmVnID0gPDB4MDAgMHg4MD47DQo+PiAgICAgICBpbnRlcnJ1cHRzLWV4dGVuZGVk
ID0gPCZnaWMgR0lDX1NQSSA0MCBJUlFfVFlQRV9MRVZFTF9ISUdIPiwNCj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgIDwmZ2ljIEdJQ19TUEkgODkgSVJRX1RZUEVfTEVWRUxfSElHSD4sDQo+PiAg
ICAgICAgICAgICAgICAgICAgICAgICA8JmdpYyBHSUNfU1BJIDkwIElSUV9UWVBFX0xFVkVMX0hJ
R0g+LA0KPj4gICAgICAgaW50ZXJydXB0LWNvbnRyb2xsZXI7DQo+PiAgICAgICAjYWRkcmVzcy1j
ZWxscyA9IDwwPjsNCj4+ICAgICAgICNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47DQo+PiAgICAgfTsN
Cj4NCj5TbyB5b3UgaGF2ZSBzdHJpY3RseSBkZWZpbmVkIG51bWJlciBvZiBpbnRlcnJ1cHRzIGFu
ZCB0aGUgYWN0dWFsIGludGVycnVwdHMgcGVyDQo+dmFyaWFudC4NCj4NClllcywgSSBoYXZlIGRl
ZmluZWQgdGhlbS4NCg0KPj4NCj4+Pg0KPj4+IExvb2sgYXQgYWxsIG90aGVyIGJpbmRpbmdzIGNv
dmVyaW5nIG11bHRpcGxlIGRldmljZXMgYW5kIHRoZWlyDQo+Pj4gY2xvY2tzL2ludGVycnVwdHMv
aW50ZXJjb25uZWN0cy9yZWcgZXRjLg0KPj4NCj4+IE1heSBJIGFkb3B0IHRoZSBhcHByb2FjaCB1
c2VkIGluIHRoaXMgWUFNTCBmb3IgbXkgY2FzZT8NCj4+IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcv
ZG9jL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aW1lci9hbGwNCj4+IHdpbm5l
ciUyQ3N1bjRpLWExMC10aW1lci55YW1sDQo+DQo+DQo+SSBhbSBhc2tpbmcgZm9yIHRoaXMgc2lu
Y2UgZmV3IGVtYWlscy4NCj4NCj5Mb29rOg0KPiJBbnl3YXksIHlvdSBtdXN0IGRlc2NyaWJlIHRo
ZSBpdGVtcy4gV2h5IHRoaXMgaXMgbm90IGZpeGVkIGJ1dCBmbGV4aWJsZT8NCj5IYXJkd2FyZSBo
YXMgZGlmZmVyZW50IG51bWJlciBvZiBwaW5zPyBUaGF0J3MgdW5saWtlbHkuIg0KPg0KSXQgaXMg
Zml4ZWQsIGFuZCB0aGUgaGFyZHdhcmUgaGFzIHRoZSBzYW1lIG51bWJlciBvZiBwaW5zLg0KDQpS
ZWdhcmRzLA0KSmFtZXMNCg0K
