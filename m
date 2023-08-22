Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDAA783795
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 03:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjHVBry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 21:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjHVBrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 21:47:52 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6705132;
        Mon, 21 Aug 2023 18:47:48 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37M1lEYM1017852, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37M1lEYM1017852
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Aug 2023 09:47:14 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 22 Aug 2023 09:47:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 22 Aug 2023 09:47:35 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 22 Aug 2023 09:47:35 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Sergey Korolev <korolev.sergey@gmail.com>,
        Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: kernel warns about voluntary context switch within RCU critical section in rtw88_usb
Thread-Topic: PROBLEM: kernel warns about voluntary context switch within RCU
 critical section in rtw88_usb
Thread-Index: AQHZ1Du6L7NM3D3q6kaezl/cutgsbq/1i5bg
Date:   Tue, 22 Aug 2023 01:47:34 +0000
Message-ID: <bfaa8714467a4954a045475e062f78b1@realtek.com>
References: <CA+QjRnJ+YMdOM0OzwG+Pz8-mTPo5nZVioCjbz1xY0jVSGXBk7w@mail.gmail.com>
In-Reply-To: <CA+QjRnJ+YMdOM0OzwG+Pz8-mTPo5nZVioCjbz1xY0jVSGXBk7w@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkZyb206IFNlcmdleSBLb3JvbGV2IDxrb3JvbGV2LnNlcmdleUBnbWFpbC5jb20+IA0KU2Vu
dDogTW9uZGF5LCBBdWd1c3QgMjEsIDIwMjMgMTA6MjggUE0NClRvOiBQaW5nLUtlIFNoaWggPHBr
c2hpaEByZWFsdGVrLmNvbT47IEthbGxlIFZhbG8gPGt2YWxvQGtlcm5lbC5vcmc+OyBsaW51eC13
aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNClN1
YmplY3Q6IFBST0JMRU06IGtlcm5lbCB3YXJucyBhYm91dCB2b2x1bnRhcnkgY29udGV4dCBzd2l0
Y2ggd2l0aGluIFJDVSBjcml0aWNhbCBzZWN0aW9uIGluIHJ0dzg4X3VzYg0KPiANCj4gUGxlYXNl
IG5vdGUgSSB1c2UgYW4gdW5tb2RpZmllZCBkcml2ZXIgZnJvbSB0aGUgdXBzdHJlYW3CoDI4YzEx
YzI5NDk0ZjFiMzRlMzk2NDFlZWFkOWM2MGE4YmQyNjE3MGQNCj4gKCJ3aWZpOiBydHc4ODogZml4
IG5vdCBlbnRlcmluZyBQUyBtb2RlIGFmdGVyIEFQIHN0b3BzIikgYnVpbGQgZm9yIDYuMiBrZXJu
ZWwgKFVidW50dSAyMy4wNCkuDQoNCkkgZmVlbCBNYXJ0aW4gaGFzIGJlZW4gYWRkcmVzc2VkIHRo
aXMgcHJvYmxlbSBkdXJpbmcgZGV2ZWxvcG1lbnQgb2YgU0RJTyBhbmQgVVNCDQpieSA4YTFlMmZk
OGUyZGEgKCJ3aWZpOiBydHc4ODogTW92ZSByZWdpc3RlciBhY2Nlc3MgZnJvbSBydHdfYmZfYXNz
b2MoKSBvdXRzaWRlIHRoZSBSQ1UiKQ0KUGxlYXNlIHRha2UgYSBsb29rIGlmIHRoaXMgcGF0Y2gg
aXMgZXhpc3RpbmcgaW4geW91ciBzb3VyY2UuIA0KDQpQaW5nLUtlDQoNCg==
