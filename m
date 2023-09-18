Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581777A3F8D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 05:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbjIRDDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 23:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238080AbjIRDC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 23:02:58 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A206123;
        Sun, 17 Sep 2023 20:02:51 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38I32VPu81517537, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38I32VPu81517537
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 11:02:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 18 Sep 2023 11:02:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 18 Sep 2023 11:02:31 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c]) by
 RTEXMBS04.realtek.com.tw ([fe80::7445:d92b:d0b3:f79c%5]) with mapi id
 15.01.2375.007; Mon, 18 Sep 2023 11:02:31 +0800
From:   =?utf-8?B?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?= <tychang@realtek.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/7] pinctrl: realtek: Add common pinctrl driver for Realtek DHC RTD SoCs
Thread-Topic: [PATCH v2 1/7] pinctrl: realtek: Add common pinctrl driver for
 Realtek DHC RTD SoCs
Thread-Index: AQHZ5I483wqw7fXzOES3iZ0BnYDYkrAf7YUg
Date:   Mon, 18 Sep 2023 03:02:31 +0000
Message-ID: <ae5a5665e11242e49b9b84d54b1d4ac3@realtek.com>
References: <20230824105703.19612-1-tychang@realtek.com>
 <20230824105703.19612-2-tychang@realtek.com>
 <CACRpkda8_nV1UiDO0_qvcc_z8ODQqckwaCGg6A5-Qm0NADi_Ng@mail.gmail.com>
In-Reply-To: <CACRpkda8_nV1UiDO0_qvcc_z8ODQqckwaCGg6A5-Qm0NADi_Ng@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.181.166]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBMaW51cywNCj4NCj5IaSBUenV5aSwNCj4NCj50aGFua3MgZm9yIHRoZSBuZXcgdmVyc2lv
biEgVGhpcyBpcyBzdGFydGluZyB0byBsb29rIHJlYWxseSBnb29kLg0KPg0KPk9uIFRodSwgQXVn
IDI0LCAyMDIzIGF0IDEyOjU34oCvUE0gVHp1eWkgQ2hhbmcgPHR5Y2hhbmdAcmVhbHRlay5jb20+
IHdyb3RlOg0KPg0KPj4gVGhlIFJURCBTb0NzIHNoYXJlIGEgc2ltaWxhciBkZXNpZ24gZm9yIHBp
bm11eCBhbmQgcGluY29uZmlnLg0KPj4gVGhpcyBjb21tb24gcGluY3RybCBkcml2ZXIgc3VwcG9y
dHMgZGlmZmVyZW50IHZhcmlhbnRzIHdpdGhpbiB0aGUgUlREDQo+PiBTb0NzLg0KPj4NCj4+IFNp
Z25lZC1vZmYtYnk6IFR6dXlpIENoYW5nIDx0eWNoYW5nQHJlYWx0ZWsuY29tPg0KPiguLi4pDQo+
PiArc3RhdGljIHZvaWQgcnRkX3BpbmN0cmxfdXBkYXRlX2JpdHMoc3RydWN0IHJ0ZF9waW5jdHJs
ICpkYXRhLCB1bnNpZ25lZCBpbnQgb2Zmc2V0LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdW5zaWduZWQgaW50IG1hc2ssIHVuc2lnbmVkIGludA0KPj4gK3ZhbCkgew0K
Pj4gKyAgICAgICB1bnNpZ25lZCBpbnQgcmVnID0gcmVhZGxfcmVsYXhlZChkYXRhLT5iYXNlICsg
b2Zmc2V0KTsNCj4+ICsNCj4+ICsgICAgICAgcmVnICY9IH5tYXNrOw0KPj4gKyAgICAgICByZWcg
fD0gKG1hc2sgJiB2YWwpOw0KPj4gKyAgICAgICB3cml0ZWxfcmVsYXhlZChyZWcsIGRhdGEtPmJh
c2UgKyBvZmZzZXQpOyB9DQo+DQo+VGhpcyBmdW5jdGlvbiBpcyBlc3NlbnRpYWxseSBhIHJlaW1w
bGVtZW50YXRpb24gb2YgcmVnbWFwX3VwZGF0ZV9iaXRzKCkgdXNpbmcNCj5yZWdtYXBfbW1pbyB3
aXRoIC51c2VyX3JlbGF4ZWRfbW1pbyBwcm9wZXJ0eSBzZXQgaW4gdGhlIGNvbmZpZy4NCj4NCj5I
YXZlIHlvdSBjb25zaWRlcmVkIGp1c3QgdXNpbmcgcmVnbWFwLW1taW8gZm9yIHRoaXM/DQo+DQoN
ClRoYW5rIHlvdSBmb3IgdGhlIHN1Z2dlc3Rpb24uIEknbGwgdXNlIHJlZ21hcF9tbWlvIHRvIHJl
cGxhY2UgaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KPllvdXJzLA0KPkxpbnVzIFdhbGxlaWoN
Cg0KDQpUaGFua3MsDQpUenV5aSBDaGFuZw0K
