Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2817EEF3B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345765AbjKQJtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbjKQJsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:48:41 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761D61BE4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:47:21 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AH9ieRO33041301, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AH9ieRO33041301
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 17:44:40 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 17 Nov 2023 17:44:40 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 17 Nov 2023 17:44:40 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3]) by
 RTEXMBS03.realtek.com.tw ([fe80::5510:ad08:5390:1ed3%2]) with mapi id
 15.01.2375.007; Fri, 17 Nov 2023 17:44:40 +0800
From:   =?big5?B?SmFtZXMgVGFpIFvAuafTrnBd?= <james.tai@realtek.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
CC:     Marc Zyngier <maz@kernel.org>
Subject: RE: [PATCH 2/6] irqchip: Add interrupt controller support for Realtek DHC SoCs
Thread-Topic: [PATCH 2/6] irqchip: Add interrupt controller support for
 Realtek DHC SoCs
Thread-Index: AQHaEKS4z5qABbyTp0Oos88YK3fZDbB9FzyAgAE4jeA=
Date:   Fri, 17 Nov 2023 09:44:40 +0000
Message-ID: <73e99dabe6d64d2baffb2107e42c9e0c@realtek.com>
References: <20231102142731.2087245-1-james.tai@realtek.com>
 <20231102142731.2087245-3-james.tai@realtek.com> <87wmuvgluc.ffs@tglx>
 <7d6211e66d4942c785ada6bd1d46c0b5@realtek.com>
In-Reply-To: <7d6211e66d4942c785ada6bd1d46c0b5@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [49.216.22.4]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="big5"
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

DQo+PlNvIHlvdSB1cGRhdGUgdGhlIGVmZmVjdGl2ZSBhZmZpbml0eSBldmVuIGlmIGl0IGNhbm5v
dCBiZSBzZXQgb3IgaWYgdGhlDQo+PnBhcmVudCBpcnEgcmV0dXJucyBhbiBlcnJvciBjb2RlPw0K
Pj4NCj4+QXNpZGUgb2YgdGhhdCBzZXR0aW5nIGl0IHRvIGNwdV9vbmxpbmUgbWFzayBpcyBqdXN0
IHdyb25nLiBUaGlzIGlzDQo+Pl9OT1RfIHRoZSBlZmZlY3RpdmUgYWZmaW5pdHkgYmVjYXVzZSB0
aGUgdW5kZXJseWluZyBHSUMgc2VsZWN0cyBhDQo+PnNpbmdsZSB0YXJnZXQgQ1BVIG91dCBvZiB0
aGUgY2FsbGVyIHByb3ZpZGVzIGNwdSBtYXNrLg0KPj4NCj4+VGhhdCBzYWlkLCB0aGlzIGlzIGFs
c28gY29tcGxldGVseSBpbmNvbnNpc3RlbnQgdnMuIHRoZSBvdGhlcg0KPj5pbnRlcnJ1cHRzIHdo
aWNoIHNoYXJlIHRoYXQgR0lDIGludGVycnVwdCBpbnN0YW5jZS4gSS5lLg0KPj4vcHJvYy9pcnEv
JE4vYWZmaW5pdHkgYW5kIGVmZmVjdGl2ZV9hZmZpbml0eSBiZWNvbWUgcmFuZG9tIG51bWJlciBn
ZW5lcmF0b3JzLg0KPlRoYXQnbGwgY29uZnVzZSBleGlzdGluZyB1c2Vyc3BhY2UgdG9vbHMuDQo+
Pg0KPj5IYXZpbmcgYW4gYWZmaW5pdHkgc2V0dGVyIGZvciBkZW11bHRpcGxleGVzIGludGVycnVw
dHMgaXMgc2ltcGx5IHdyb25nLg0KPj4NCj5JIHdpbGwgdXNlIHRoZSAnaXJxX2NoaXBfc2V0X2Fm
ZmluaXR5X3BhcmVudCcgcmVwbGFjZSB0aGUNCj4ncmVhbHRla19pbnRjX3NldF9hZmZpbml0eScu
DQoNCkkgd2lsbCByZW1vdmUgdGhlIGNhcGFiaWxpdHkgdG8gc2V0IENQVSBhZmZpbml0eS4NCg0K
UmVnYXJkcywNCkphbWVzDQoNCg0K
