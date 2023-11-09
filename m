Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E89C7E704B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344581AbjKIRaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjKIRaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:30:07 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFC993;
        Thu,  9 Nov 2023 09:30:04 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A9HTiD721689371, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A9HTiD721689371
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 01:29:44 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 10 Nov 2023 01:29:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 10 Nov 2023 01:29:43 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Fri, 10 Nov 2023 01:29:43 +0800
From:   Hau <hau@realtek.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
CC:     nic_swsd <nic_swsd@realtek.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net v3 1/2] r8169: add handling DASH when DASH is disabled
Thread-Topic: [PATCH net v3 1/2] r8169: add handling DASH when DASH is
 disabled
Thread-Index: AQHaEyvgH17lAjTkmESMChUjvulwm7BxtAcAgACKA7A=
Date:   Thu, 9 Nov 2023 17:29:43 +0000
Message-ID: <51b3bbff47ff4e8dafeaeff647979d4e@realtek.com>
References: <20231109164327.3577-1-hau@realtek.com>
 <20231109164327.3577-2-hau@realtek.com>
 <a1f703f4-a0da-4f88-9c1c-e5f6b6e2ce50@gmail.com>
In-Reply-To: <a1f703f4-a0da-4f88-9c1c-e5f6b6e2ce50@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
x-originating-ip: [172.22.228.56]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICAgICAgIGlmICghbmV0aWZfcnVubmluZyh0cC0+ZGV2KSB8fCAhbmV0aWZfY2Fycmllcl9v
ayh0cC0+ZGV2KSkgQEANCj4gPiAtNDg5Niw3ICs0OTA5LDcgQEAgc3RhdGljIHZvaWQgcnRsX3No
dXRkb3duKHN0cnVjdCBwY2lfZGV2ICpwZGV2KQ0KPiA+ICAgICAgIHJ0bF9yYXJfc2V0KHRwLCB0
cC0+ZGV2LT5wZXJtX2FkZHIpOw0KPiA+DQo+ID4gICAgICAgaWYgKHN5c3RlbV9zdGF0ZSA9PSBT
WVNURU1fUE9XRVJfT0ZGICYmDQo+ID4gLSAgICAgICAgIHRwLT5kYXNoX3R5cGUgPT0gUlRMX0RB
U0hfTk9ORSkgew0KPiA+ICsgICAgICAgICAhdHAtPmRhc2hfZW5hYmxlZCkgew0KPiANCj4gV2h5
IGJyZWFrIHRoZSBsaW5lIGF0IGFsbD8gTm93IHRoZSBjaGVjayBmaXRzIHRoZSA4MCBjaGFyIGxp
bmUgbGltaXQuDQoNCkkgd2lsbCBjb3JyZWN0IHRoaXMuIFRoYW5rcy4NCg==
