Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADF7804CD1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344867AbjLEIns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjLEInq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:43:46 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F68D3;
        Tue,  5 Dec 2023 00:43:52 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B58hKGH12733923, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B58hKGH12733923
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Dec 2023 16:43:21 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 5 Dec 2023 16:43:21 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 5 Dec 2023 16:43:20 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3]) by
 RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3%2]) with mapi id
 15.01.2375.007; Tue, 5 Dec 2023 16:43:20 +0800
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
Thread-Index: AQHaGXMHJnbDooY4VkyEcMH4aisPjrCBFAaAgAG3OTCAE2RqMIABC34AgACK6PD//42bAIADJhOw
Date:   Tue, 5 Dec 2023 08:43:20 +0000
Message-ID: <f27cb5d8943e44b597a13d7655edf4d0@realtek.com>
References: <20231117162709.1096585-1-james.tai@realtek.com>
 <20231117162709.1096585-2-james.tai@realtek.com>
 <c3a98e2c-ba62-4798-a0d0-a8bc1fe5bb6b@linaro.org>
 <7959920acf004f3cb8072de1e17439fa@realtek.com>
 <e1490203387d4c48a5f8c4040ece038a@realtek.com>
 <6250c57b-6d38-4085-9a79-58e4e5ed1e3d@linaro.org>
 <cf2f9fd124514cb9832e942e16b8fa6e@realtek.com>
 <5134d2c7-b499-400d-bec8-ae0de1eff7db@linaro.org>
In-Reply-To: <5134d2c7-b499-400d-bec8-ae0de1eff7db@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [101.12.45.26]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+Pj4+Pj4+ICsgIGludGVycnVwdHMtZXh0ZW5kZWQ6DQo+Pj4+Pj4N
Cj4+Pj4+PiBpbnRlcnJ1cHRzIGluc3RlYWQuDQo+Pj4+Pj4NCj4+Pj4+PiBBbnl3YXksIHlvdSBt
dXN0IGRlc2NyaWJlIHRoZSBpdGVtcy4gV2h5IHRoaXMgaXMgbm90IGZpeGVkIGJ1dCBmbGV4aWJs
ZT8NCj4+Pj4+PiBIYXJkd2FyZSBoYXMgZGlmZmVyZW50IG51bWJlciBvZiBwaW5zPyBUaGF0J3Mg
dW5saWtlbHkuDQo+Pj4+Pj4NCj4+Pj4+IEkgd2lsbCByZXBsYWNlIGl0IHdpdGggJ2ludGVycnVw
dHMnLiBTaW5jZSBvdXIgSW50ZXJydXB0IGNvbnRyb2xsZXINCj4+Pj4+IGFyY2hpdGVjdHVyZSBk
b2Vzbid0IGludm9sdmUgbXVsdGlwbGUgaW50ZXJydXB0IHNvdXJjZXMsIHVzaW5nICdpbnRlcnJ1
cHRzJw0KPj4+IHNob3VsZCBzdWZmaWNlLg0KPj4+Pj4NCj4+Pj4NCj4+Pj4gRHVlIHRvIGNoYW5n
ZXMgaW4gaGFyZHdhcmUgZGVzaWduLCBzb21lIHBlcmlwaGVyYWwgaW50ZXJydXB0cyBwaW4NCj4+
Pj4gaW5pdGlhbGx5DQo+Pj4gY29ubmVjdGVkIHRvIHRoZSBSZWFsdGVrIGludGVycnVwdCBjb250
cm9sbGVyIHdlcmUgcmVkaXJlY3RlZCB0byB0aGUgR0lDLg0KPj4+PiBIb3dldmVyLCB0aGUgYXNz
b2NpYXRlZCBmaWVsZHMgYW5kIHN0YXR1c2VzIGluIHRoZSBSZWFsdGVrIGludGVycnVwdA0KPj4+
PiBjb250cm9sbGVyDQo+Pj4gcmVnaXN0ZXJzIHdlcmUgbm90IHJlbW92ZWQuDQo+Pj4+IEFzIGEg
cmVzdWx0LCB0aGVzZSBpbnRlcnJ1cHRzIGNhbm5vdCBiZSBjbGVhcmVkIGJ5IHBlcmlwaGVyYWwN
Cj4+Pj4gcmVnaXN0ZXIsIGFuZCB0aGVpcg0KPj4+IHN0YXR1cyBjbGVhcmluZyBpcyBzdGlsbCBu
ZWVkaW5nIHRoZSBSZWFsdGVrIGludGVycnVwdCBjb250cm9sbGVyIGRyaXZlciB0bw0KPm1hbmFn
ZS4NCj4+Pj4NCj4+Pj4gVGhhdCdzIHdoeSBmbGV4aWJpbGl0eSBpcyBuZWNlc3NhcnkuDQo+Pj4N
Cj4+PiBUaGlzIGRvZXMgbm90IGV4cGxhaW4gd2h5IHRoaXMgaXMgbm90IGZpeGVkIHBlciB2YXJp
YW50Lg0KPj4+DQo+Pg0KPj4gRG9lcyB0aGUgZGVmaW5pdGlvbiBvZiAiZml4ZWQiIHlvdSBtZW50
aW9uZWQgcmVmZXIgdG8gZml4ZWQgaW50ZXJydXB0IHBpbnM/IElmDQo+PiBub3QsIGNvdWxkIHlv
dSBwbGVhc2UgZ2l2ZSBtZSBhbiBleGFtcGxlIGFuZCBsZXQgbWUga25vdyB3aGF0IHlvdSBtZWFu
IGJ5DQo+PiAiZml4ZWQiPw0KPg0KPk51bWJlciBvZiB0aGUgaW50ZXJydXB0cyBwZXIgZWFjaCBk
ZXZpY2Ugb3IgdmFyaWFudCBzaG91bGQgYmUgc3RyaWN0bHkgZGVmaW5lZCwNCj5ub3QgdmFyaWFi
bGUuDQoNClRoYW5rIHlvdSBmb3IgeW91ciBleHBsYW5hdGlvbi4NCg0KVGhlIERIQyBwbGF0Zm9y
bXMgY29udGFpbiB0d28gaW50ZXJydXB0IGNvbnRyb2xsZXJzLCBlYWNoIGhhbmRsaW5nIHBlcmlw
aGVyYWwgZGV2aWNlIGludGVycnVwdHMgaW4gdGhlIHR3byBwb3dlciBkb21haW5zLiANCldoaWxl
IGVhY2ggaGFzIGEgZml4ZWQgSVJRIG51bWJlcnMsIHRoZSBzcGVjaWZpYyBJUlEgdmFyaWVzIGRl
cGVuZGluZyBvbiB0aGUgcGxhdGZvcm0uDQoNCj5QbGVhc2Ugd3JhcCB5b3VyIGVtYWlscyBhY2Nv
cmRpbmcgdG8gbWFpbCBuZXRpcXVldHRlLg0KDQpJIGFwb2xvZ2l6ZSBmb3IgbXkgcnVkZSB3YXkg
b2YgYXNraW5nIHRoZSBxdWVzdGlvbi4gSSB3aWxsIGltcHJvdmUgbXkgZXhwcmVzc2lvbi4NCg0K
VGhhbmsgZm9yIHlvdXIgZmVlZGJhY2suDQoNClJlZ2FyZHMsDQpKYW1lcw0K
