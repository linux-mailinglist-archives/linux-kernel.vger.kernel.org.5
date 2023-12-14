Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D5D813072
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573127AbjLNMnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573090AbjLNMnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:43:18 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1D3120;
        Thu, 14 Dec 2023 04:43:23 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BECgwkvF834403, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BECgwkvF834403
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 20:42:58 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 14 Dec 2023 20:42:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 14 Dec 2023 20:42:58 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 14 Dec 2023 20:42:58 +0800
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
Subject: RE: [PATCH net-next v14 01/13] rtase: Add pci table supported in this module
Thread-Topic: [PATCH net-next v14 01/13] rtase: Add pci table supported in
 this module
Thread-Index: AQHaKbuYel8bAsIH20ym2hry1WR2erCk47oAgAPenzA=
Date:   Thu, 14 Dec 2023 12:42:57 +0000
Message-ID: <e8d5a54286e242f6a2caa5ffd7c1a6f3@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
         <20231208094733.1671296-2-justinlai0215@realtek.com>
 <0d8195d3c1aaec85e74d7ae2bf5b1a5b9c1a0b78.camel@redhat.com>
In-Reply-To: <0d8195d3c1aaec85e74d7ae2bf5b1a5b9c1a0b78.camel@redhat.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQWJlbmkgPHBh
YmVuaUByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAxMiwgMjAyMyA1OjM2
IFBNDQo+IFRvOiBKdXN0aW5MYWkwMjE1IDxqdXN0aW5sYWkwMjE1QHJlYWx0ZWsuY29tPjsga3Vi
YUBrZXJuZWwub3JnDQo+IENjOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUu
Y29tOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwu
b3JnOyBhbmRyZXdAbHVubi5jaDsNCj4gUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+
OyBMYXJyeSBDaGl1IDxsYXJyeS5jaGl1QHJlYWx0ZWsuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIG5ldC1uZXh0IHYxNCAwMS8xM10gcnRhc2U6IEFkZCBwY2kgdGFibGUgc3VwcG9ydGVkIGlu
IHRoaXMNCj4gbW9kdWxlDQo+IA0KPiANCj4gRXh0ZXJuYWwgbWFpbC4NCj4gDQo+IA0KPiANCj4g
T24gRnJpLCAyMDIzLTEyLTA4IGF0IDE3OjQ3ICswODAwLCBKdXN0aW4gTGFpIHdyb3RlOg0KPiBb
Li4uXQ0KPiA+ICtzdGF0aWMgdm9pZCBydGFzZV9yZW1vdmVfb25lKHN0cnVjdCBwY2lfZGV2ICpw
ZGV2KSB7DQo+ID4gKyAgICAgc3RydWN0IG5ldF9kZXZpY2UgKmRldiA9IHBjaV9nZXRfZHJ2ZGF0
YShwZGV2KTsNCj4gPiArICAgICBzdHJ1Y3QgcnRhc2VfcHJpdmF0ZSAqdHAgPSBuZXRkZXZfcHJp
dihkZXYpOw0KPiA+ICsgICAgIHN0cnVjdCBydGFzZV9pbnRfdmVjdG9yICppdmVjOw0KPiA+ICsg
ICAgIHUzMiBpOw0KPiA+ICsNCj4gPiArICAgICBmb3IgKGkgPSAwOyBpIDwgdHAtPmludF9udW1z
OyBpKyspIHsNCj4gPiArICAgICAgICAgICAgIGl2ZWMgPSAmdHAtPmludF92ZWN0b3JbaV07DQo+
ID4gKyAgICAgICAgICAgICBuZXRpZl9uYXBpX2RlbCgmaXZlYy0+bmFwaSk7DQo+ID4gKyAgICAg
fQ0KPiANCj4gWW91IG11c3QgdW5yZWdpc3RlciB0aGUgbmV0ZGV2IGJlZm9yZSBuYXBpX2RlbCBv
ciB5b3Ugd2lsbCByaXNrIHJhY2VzLg0KDQpPaywgVGhhbmsgeW91IGZvciB5b3VyIHN1Z2dlc3Rp
b24uDQoNCj4gDQo+IENoZWVycywNCj4gDQo+IFBhb2xvDQo=
