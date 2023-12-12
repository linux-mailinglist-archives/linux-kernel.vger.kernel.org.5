Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C8780E862
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346150AbjLLJ7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjLLJ7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:59:19 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615D4F3;
        Tue, 12 Dec 2023 01:59:25 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BC9wimaF3439853, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BC9wimaF3439853
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Dec 2023 17:58:44 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 12 Dec 2023 17:58:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 12 Dec 2023 17:58:44 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Tue, 12 Dec 2023 17:58:44 +0800
From:   =?utf-8?B?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?= <tychang@realtek.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
Subject: RE: [PATCH 2/2] phy: realtek: pcie: Add PCIe PHY support for Realtek DHC RTD SoCs
Thread-Topic: [PATCH 2/2] phy: realtek: pcie: Add PCIe PHY support for Realtek
 DHC RTD SoCs
Thread-Index: AQHaJERyTFu0gi4FU02Z13qPgHtzf7Cj5qMAgAGTrPA=
Date:   Tue, 12 Dec 2023 09:58:44 +0000
Message-ID: <04921605bd834f1f93a290d6350f9d29@realtek.com>
References: <20231201105207.11786-1-tychang@realtek.com>
 <20231201105207.11786-3-tychang@realtek.com>
 <CAL_JsqLg7qRgk_P1FTMVeC3Q-CJHx6WXH4hwnoz_Z2LVO10gTA@mail.gmail.com>
In-Reply-To: <CAL_JsqLg7qRgk_P1FTMVeC3Q-CJHx6WXH4hwnoz_Z2LVO10gTA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.181.166]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcuDQoNCj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3BoeS9yZWFsdGVrL3BoeS1ydGstcGNpZS5jDQo+PiBiL2RyaXZlcnMvcGh5L3JlYWx0
ZWsvcGh5LXJ0ay1wY2llLmMNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAw
MDAwMDAwMDAuLjhlYzg0NTg5MDI3MQ0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvZHJpdmVy
cy9waHkvcmVhbHRlay9waHktcnRrLXBjaWUuYw0KPj4gQEAgLTAsMCArMSw3MzggQEANCj4+ICsv
LyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcg0KPj4gKy8qDQo+PiAr
ICogUmVhbHRlayBESEMgUENJZSBQSFkgZHJpdmVyDQo+PiArICoNCj4+ICsgKiBDb3B5cmlnaHQg
KGMpIDIwMjMgUmVhbHRlayBTZW1pY29uZHVjdG9yIENvcnAuDQo+PiArICovDQo+PiArDQo+PiAr
I2luY2x1ZGUgPGxpbnV4L21mZC9zeXNjb24uaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvbW9kdWxl
Lmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4L252bWVtLWNvbnN1bWVyLmg+DQo+PiArI2luY2x1ZGUg
PGxpbnV4L29mX2FkZHJlc3MuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+DQo+
DQo+WW91IHByb2JhYmx5IGRvbid0IG5lZWQgdGhpcyBoZWFkZXIgYW5kIHRoZSBpbXBsaWNpdCBp
bmNsdWRlcyBpdCBtYWtlcyBhcmUNCj5kcm9wcGVkIG5vdyBpbiBsaW51eC1uZXh0LiBQbGVhc2Ug
Y2hlY2sgd2hhdCB5b3UgYWN0dWFsbHkgbmVlZCBhbmQgbWFrZQ0KPnRoZW0gZXhwbGljaXQuDQo+
DQo+b2ZfYWRkcmVzcy5oIGlzIGxpa2VseSBub3QgbmVlZGVkIGVpdGhlci4gUGxlYXNlIGNoZWNr
Lg0KPg0KPlJvYg0KDQoNCkkgd2lsbCBjaGVjayBhbmQgcmV2aXNlIGl0Lg0KDQpUaGFua3MsDQpU
enV5aSBDaGFuZw0K
