Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC0AD813077
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573125AbjLNMo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573090AbjLNMo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:44:28 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1441A3;
        Thu, 14 Dec 2023 04:44:34 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BECiES91836202, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BECiES91836202
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 20:44:14 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 14 Dec 2023 20:44:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 14 Dec 2023 20:44:14 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 14 Dec 2023 20:44:14 +0800
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
Subject: RE: [PATCH net-next v14 02/13] rtase: Implement the .ndo_open function
Thread-Topic: [PATCH net-next v14 02/13] rtase: Implement the .ndo_open
 function
Thread-Index: AQHaKbuYHC4DvgtvsEWfjB+XS7f+RLCk54uAgAPbZrA=
Date:   Thu, 14 Dec 2023 12:44:14 +0000
Message-ID: <0f5269c041624dbbae3c70892eab8a6d@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
         <20231208094733.1671296-3-justinlai0215@realtek.com>
 <a18c5b93b9732575048c551268a92935db4dbf48.camel@redhat.com>
In-Reply-To: <a18c5b93b9732575048c551268a92935db4dbf48.camel@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.210.185]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQWJlbmkgPHBh
YmVuaUByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAxMiwgMjAyMyA1OjUw
IFBNDQo+IFRvOiBKdXN0aW5MYWkwMjE1IDxqdXN0aW5sYWkwMjE1QHJlYWx0ZWsuY29tPjsga3Vi
YUBrZXJuZWwub3JnDQo+IENjOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29nbGUu
Y29tOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwu
b3JnOyBhbmRyZXdAbHVubi5jaDsNCj4gUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+
OyBMYXJyeSBDaGl1IDxsYXJyeS5jaGl1QHJlYWx0ZWsuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIG5ldC1uZXh0IHYxNCAwMi8xM10gcnRhc2U6IEltcGxlbWVudCB0aGUgLm5kb19vcGVuDQo+
IGZ1bmN0aW9uDQo+IA0KPiANCj4gRXh0ZXJuYWwgbWFpbC4NCj4gDQo+IA0KPiANCj4gT24gRnJp
LCAyMDIzLTEyLTA4IGF0IDE3OjQ3ICswODAwLCBKdXN0aW4gTGFpIHdyb3RlOg0KPiA+ICtzdGF0
aWMgaW50IHJ0YXNlX29wZW4oc3RydWN0IG5ldF9kZXZpY2UgKmRldikgew0KPiA+ICsgICAgIHN0
cnVjdCBydGFzZV9wcml2YXRlICp0cCA9IG5ldGRldl9wcml2KGRldik7DQo+ID4gKyAgICAgc3Ry
dWN0IHJ0YXNlX2ludF92ZWN0b3IgKml2ZWMgPSAmdHAtPmludF92ZWN0b3JbMF07DQo+ID4gKyAg
ICAgY29uc3Qgc3RydWN0IHBjaV9kZXYgKnBkZXYgPSB0cC0+cGRldjsNCj4gPiArICAgICBpbnQg
cmV0Ow0KPiA+ICsgICAgIHUxNiBpOw0KPiA+ICsNCj4gPiArICAgICBydGFzZV9zZXRfcnhidWZz
aXplKHRwKTsNCj4gPiArDQo+ID4gKyAgICAgcmV0ID0gcnRhc2VfYWxsb2NfZGVzYyh0cCk7DQo+
ID4gKyAgICAgaWYgKHJldCkNCj4gPiArICAgICAgICAgICAgIGdvdG8gZXJyX2ZyZWVfYWxsX2Fs
bG9jYXRlZF9tZW07DQo+ID4gKw0KPiA+ICsgICAgIHJldCA9IHJ0YXNlX2luaXRfcmluZyhkZXYp
Ow0KPiA+ICsgICAgIGlmIChyZXQpDQo+ID4gKyAgICAgICAgICAgICBnb3RvIGVycl9mcmVlX2Fs
bF9hbGxvY2F0ZWRfbWVtOw0KPiA+ICsNCj4gPiArICAgICBydGFzZV9od19jb25maWcoZGV2KTsN
Cj4gPiArDQo+ID4gKyAgICAgaWYgKHRwLT5zd19mbGFnICYgU1dGX01TSVhfRU5BQkxFRCkgew0K
PiA+ICsgICAgICAgICAgICAgcmV0ID0gcmVxdWVzdF9pcnEoaXZlYy0+aXJxLCBydGFzZV9pbnRl
cnJ1cHQsIDAsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkZXYtPm5hbWUs
IGl2ZWMpOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgIC8qIHJlcXVlc3Qgb3RoZXIgaW50ZXJy
dXB0cyB0byBoYW5kbGUgbXVsdGlxdWV1ZSAqLw0KPiA+ICsgICAgICAgICAgICAgZm9yIChpID0g
MTsgaSA8IHRwLT5pbnRfbnVtczsgaSsrKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGlm
IChyZXQpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+ID4g
Kw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBpdmVjID0gJnRwLT5pbnRfdmVjdG9yW2ldOw0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICBpZiAoaXZlYy0+c3RhdHVzICE9IDEpDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+ID4gKw0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICBzbnByaW50ZihpdmVjLT5uYW1lLCBzaXplb2YoaXZlYy0+bmFtZSksDQo+
ICIlc19pbnQlaSIsIHRwLT5kZXYtPm5hbWUsIGkpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICByZXQgPSByZXF1ZXN0X2lycShpdmVjLT5pcnEsIHJ0YXNlX3FfaW50ZXJydXB0LCAwLA0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpdmVjLT5uYW1lLCBpdmVj
KTsNCj4gDQo+IEl0IGxvb2tzIGxpa2UgdGhhdCBpZiB0aGUgYWJvdmUgcmVxdWVzdF9pcnEgZmFp
bHMgeW91IHdpbGwgbmV2ZXIgZnJlZQ0KPiB0cC0+aW50X3ZlY3RvclswXS5pcnEgKGFuZCBhbGwg
dHAtPmludF92ZWN0b3Jbal0uaXJxLCBmb3IgaiA8IGkpDQo+IA0KVGhhbmtzIGZvciB0aGUgcmVt
aW5kZXIsIEkgd2lsbCBmaXggaXQuDQo+IA0KPiBDaGVlcnMsDQo+IA0KPiBQYW9sbw0K
