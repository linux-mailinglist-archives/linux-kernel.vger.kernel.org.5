Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90448085EE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbjLGKo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 05:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjLGKo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 05:44:57 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EBDD57;
        Thu,  7 Dec 2023 02:45:02 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B7AhtFP3094699, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B7AhtFP3094699
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Dec 2023 18:43:55 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 7 Dec 2023 18:43:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 7 Dec 2023 18:43:54 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 7 Dec 2023 18:43:54 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Vinod Koul <vkoul@kernel.org>, Johan Hovold <johan@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Roy Luo <royluo@google.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        =?utf-8?B?UmljYXJkbyBDYcOxdWVsbw==?= 
        <ricardo.canuelo@collabora.com>,
        "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH v3 RESEND 4/4] usb: core: add phy notify connect and disconnect
Thread-Topic: [PATCH v3 RESEND 4/4] usb: core: add phy notify connect and
 disconnect
Thread-Index: AQHaKODLBXJBQe+0iUGdjxaPpl61frCdEqmAgACL4zA=
Date:   Thu, 7 Dec 2023 10:43:54 +0000
Message-ID: <6556cc86a350493fbf9f127cd558d76b@realtek.com>
References: <20231207074022.14116-1-stanley_chang@realtek.com>
 <20231207074022.14116-4-stanley_chang@realtek.com>
 <2023120730-mouth-jolt-0170@gregkh>
In-Reply-To: <2023120730-mouth-jolt-0170@gregkh>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.190.159]
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

SGkgR3JlZywNCg0KPiA+ICtpbnQgdXNiX3BoeV9yb290aHViX25vdGlmeV9jb25uZWN0KHN0cnVj
dCB1c2JfcGh5X3Jvb3RodWINCj4gPiArKnBoeV9yb290aHViLCBpbnQgcG9ydCkgew0KPiA+ICsg
ICAgIHN0cnVjdCB1c2JfcGh5X3Jvb3RodWIgKnJvb3RodWJfZW50cnk7DQo+ID4gKyAgICAgc3Ry
dWN0IGxpc3RfaGVhZCAqaGVhZDsNCj4gPiArICAgICBpbnQgZXJyOw0KPiA+ICsNCj4gPiArICAg
ICBpZiAoIXBoeV9yb290aHViKQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIDA7DQo+IA0KPiBI
b3cgY2FuIHBoeV9yb290aHViIGV2ZXIgYmUgTlVMTD8NCj4gDQpUaGlzIGlzIHBvc3NpYmxlLiBJ
ZiB0aGUgaG9zdCBubyB1c2UgZ2VuZXJpYyBwaHksIHRoZW4gdXNiX3BoeV9yb290aHViX2FsbG9j
IHdpbGwgcmV0dXJuIE5VTEwuDQpBbmQgb3RoZXIgY2FsbGJhY2tzIGFsc28gZm9sbG93IHRoaXMg
cnVsZS4NCg0KPiA+ICsNCj4gPiArICAgICBoZWFkID0gJnBoeV9yb290aHViLT5saXN0Ow0KPiA+
ICsNCj4gPiArICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KHJvb3RodWJfZW50cnksIGhlYWQsIGxp
c3QpIHsNCj4gPiArICAgICAgICAgICAgIGVyciA9IHBoeV9ub3RpZnlfY29ubmVjdChyb290aHVi
X2VudHJ5LT5waHksIHBvcnQpOw0KPiA+ICsgICAgICAgICAgICAgaWYgKGVycikNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgcmV0dXJuIGVycjsNCj4gPiArICAgICB9DQo+ID4NCj4gDQo+IFlv
dSB3YWxrIGEgbGlzdCB3aXRoIG5vIGxvY2tpbmcgYXQgYWxsPyAgVGhhdCBkb2VzIG5vdCBzZWVt
IHJpZ2h0IGF0IGFsbC4NCg0KVGhlIGxvY2sgc2VlbXMgdW5uZWNlc3NhcnkuDQpBbmQgb3RoZXIg
c2ltaWxhciBBUElzIGFsc28gZG9uJ3QgdXNlIGFueSBsb2Nrcy4NCg0KPiBBbHNvLCB0aGlzIGlz
IGEgbmV3IGZ1bmN0aW9uIHRoYXQgaXMgZXhwb3J0ZWQgd2l0aCBubyBkb2N1bWVudGF0aW9uPw0K
PiBQbGVhc2UgZml4Lg0KPiANCk9rYXksIEkgd2lsbCBhZGQuDQoNClRoYW5rcywNClN0YW5sZXkN
Cg==
