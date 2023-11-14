Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1F57EAEA2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbjKNLMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNLMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:12:23 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A72E18C;
        Tue, 14 Nov 2023 03:12:19 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AEBC2hxC876665, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AEBC2hxC876665
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 19:12:02 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 14 Nov 2023 19:12:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 14 Nov 2023 19:12:01 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Tue, 14 Nov 2023 19:12:01 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] usb: dwc3: add missing of_node_put and platform_device_put
Thread-Topic: [PATCH v2] usb: dwc3: add missing of_node_put and
 platform_device_put
Thread-Index: AQHaFuOsQKeGinqqjkaAFJG885kOeLB5GLOAgACPhzA=
Date:   Tue, 14 Nov 2023 11:12:01 +0000
Message-ID: <c528787cd608476980a9c07123366c92@realtek.com>
References: <20231114101645.20065-1-stanley_chang@realtek.com>
 <e1686031-aa5a-5692-50c3-0382d32641e6@omp.ru>
In-Reply-To: <e1686031-aa5a-5692-50c3-0382d32641e6@omp.ru>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
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

SGkgU2VyZ2V5LA0KDQo+IE9uIDExLzE0LzIzIDE6MTYgUE0sIFN0YW5sZXkgQ2hhbmcgd3JvdGU6
DQo+IA0KPiA+IG9mX2dldF9jb21wYXRpYmxlX2NoaWxkIHBlcmZvcm1zIGFuIG9mX25vZGVfZ2V0
LCBzbyBhbiBvZl9ub2RlX2dldCBpcw0KPiANCj4gICAgWW91IG1lYW4gb2Zfbm9kZV9wdXQgaXMg
cmVxdWlyZWQ/DQoNClJpZ2h0LCBpdCBpcyBvZl9ub2RlX3B1dC4NCkknbSBzb3JyeSBmb3IgdGhl
IHR5cG8uDQoNClRoYW5rcywNClN0YW5sZXkNCg0KPiA+IHJlcXVpcmVkLiBBZGQgcGxhdGZvcm1f
ZGV2aWNlX3B1dCB0byBtYXRjaCB3aXRoIG9mX2ZpbmRfZGV2aWNlX2J5X25vZGUuDQo+ID4NCj4g
PiBGaXhlczogMzRjMjAwNDgzNTY5ICgidXNiOiBkd2MzOiBhZGQgUmVhbHRlayBESEMgUlREIFNv
QyBkd2MzIGdsdWUgbGF5ZXINCj4gZHJpdmVyIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBTdGFubGV5
IENoYW5nIDxzdGFubGV5X2NoYW5nQHJlYWx0ZWsuY29tPg0KPiA+IEFja2VkLWJ5OiBUaGluaCBO
Z3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQo+ID4gLS0tDQo+ID4gdjEgdG8gdjIg
Y2hhbmdlOg0KPiA+ICAgICAxLiBNb2RpZnkgdGhlIGNvbW1pdCBtZXNzYWdlLg0KPiA+ICAgICAy
LiBBZGQgb2Zfbm9kZV9nZXQgaW4gdGhlIG9mX3Byb3BlcnR5X3JlYWRfc3RyaW5nKCkgZXJyb3Ig
cGF0aC4NCj4gWy4uLl0NCj4gDQo+IE1CUiwgU2VyZ2V5DQo=
