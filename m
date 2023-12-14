Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE75281307F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573134AbjLNMsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573117AbjLNMsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:48:00 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51950A3;
        Thu, 14 Dec 2023 04:48:07 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BECln8A3840085, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BECln8A3840085
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 20:47:49 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 14 Dec 2023 20:47:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 14 Dec 2023 20:47:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 14 Dec 2023 20:47:49 +0800
From:   JustinLai0215 <justinlai0215@realtek.com>
To:     Paolo Abeni <pabeni@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v14 08/13] rtase: Implement net_device_ops
Thread-Topic: [PATCH net-next v14 08/13] rtase: Implement net_device_ops
Thread-Index: AQHaKbudgjZAnPM3HUiDY8gfOkMKhbCk7P8AgAPWfZA=
Date:   Thu, 14 Dec 2023 12:47:49 +0000
Message-ID: <be8a2a6a965f4dfca61febdaff556e63@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
         <20231208094733.1671296-9-justinlai0215@realtek.com>
 <955d390c57a93406d40985fbd1856bd1c500d75c.camel@redhat.com>
In-Reply-To: <955d390c57a93406d40985fbd1856bd1c500d75c.camel@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.210.185]
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

PiANCj4gT24gRnJpLCAyMDIzLTEyLTA4IGF0IDE3OjQ3ICswODAwLCBKdXN0aW4gTGFpIHdyb3Rl
Og0KPiA+ICtzdGF0aWMgbmV0ZGV2X2ZlYXR1cmVzX3QgcnRhc2VfZml4X2ZlYXR1cmVzKHN0cnVj
dCBuZXRfZGV2aWNlICpkZXYsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgbmV0ZGV2X2ZlYXR1cmVzX3QNCj4gZmVhdHVyZXMpDQo+ID4gK3sNCj4gPiArICAg
ICBuZXRkZXZfZmVhdHVyZXNfdCBmZWF0dXJlc19maXggPSBmZWF0dXJlczsNCj4gPiArDQo+ID4g
KyAgICAgaWYgKGRldi0+bXR1ID4gTVNTX01BWCkNCj4gPiArICAgICAgICAgICAgIGZlYXR1cmVz
X2ZpeCAmPSB+TkVUSUZfRl9BTExfVFNPOw0KPiA+ICsNCj4gPiArICAgICBpZiAoZGV2LT5tdHUg
PiBFVEhfREFUQV9MRU4pDQo+ID4gKyAgICAgICAgICAgICBmZWF0dXJlc19maXggJj0gfk5FVElG
X0ZfQUxMX1RTTzsNCj4gDQo+IFRoaXMgbGF0dGVyIGNvbmRpdGlvbiBpcyBzdHJpY3RseSBtb3Jl
IHJlc3RyaWN0aXZlIHRoYW4gdGhlIHByZXZpb3VzIG9uZSwgeW91IGNhbg0KPiBkcm9wIHRoZSBs
YXR0ZXIuIEFsc28gY291bGQgeW91IHBsZWFzZSBkcm9wIGEgbm90ZSBhYm91dCB0aGUgd2h5IG9m
IGl0Pw0KDQpXZSBkb24ndCBzdXBwb3J0IFRTTyBmb3IganVtYm8gZnJhbWVzLCBzbyBJIHdpbGwg
cmVtb3ZlIHRoZSBNU1NfTUFYIHBhcnQuDQo+IA0KPiBDaGVlcnMsDQo+IA0KPiBQYW9sbw0KDQo=
