Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE7E7EA790
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 01:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjKNAha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 19:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjKNAh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 19:37:28 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C24D53;
        Mon, 13 Nov 2023 16:37:20 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AE0bB4V1435553, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AE0bB4V1435553
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 08:37:11 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 14 Nov 2023 08:37:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 14 Nov 2023 08:37:11 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Tue, 14 Nov 2023 08:37:11 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kalle Valo <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH][next] wifi: rtw89: coex: Fix -Wstringop-overflow warnings in _append_tdma()
Thread-Topic: [PATCH][next] wifi: rtw89: coex: Fix -Wstringop-overflow
 warnings in _append_tdma()
Thread-Index: AQHaFmih5UyHqrARN0yPsbYpsf5i2LB4+ECQ
Date:   Tue, 14 Nov 2023 00:37:11 +0000
Message-ID: <fd0d79048efa47868173c5fd8950b956@realtek.com>
References: <ZVJ6lRCRaywGktxJ@work>
In-Reply-To: <ZVJ6lRCRaywGktxJ@work>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-originating-ip: [172.21.69.94]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VzdGF2byBBLiBSLiBT
aWx2YSA8Z3VzdGF2b2Fyc0BrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAx
NCwgMjAyMyAzOjM2IEFNDQo+IFRvOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT47
IEthbGxlIFZhbG8gPGt2YWxvQGtlcm5lbC5vcmc+DQo+IENjOiBsaW51eC13aXJlbGVzc0B2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEd1c3Rhdm8gQS4gUi4g
U2lsdmENCj4gPGd1c3Rhdm9hcnNAa2VybmVsLm9yZz47IGxpbnV4LWhhcmRlbmluZ0B2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIXVtuZXh0XSB3aWZpOiBydHc4OTogY29leDogRml4
IC1Xc3RyaW5nb3Atb3ZlcmZsb3cgd2FybmluZ3MgaW4gX2FwcGVuZF90ZG1hKCkNCj4gDQo+IENv
cHkgYSBjb3VwbGUgb2Ygc3RydWN0dXJlcyBkaXJlY3RseSwgaW5zdGVhZCBvZiB1c2luZyBgbWVt
Y3B5KClgLg0KPiANCg0Kd2lyZWxlc3MtbmV4dCBoYXMgdGFrZW4gbXkgcGF0Y2ggWzFdIHRoYXQg
aXMgaWRlbnRpY2FsIHRvIHlvdXJzLg0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxs
LzIwMjMxMTAyMDAzNzE2LjI1ODE1LTEtcGtzaGloQHJlYWx0ZWsuY29tLw0KDQoNCg==
