Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328967FDACC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbjK2PIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbjK2PId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:08:33 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49499C9;
        Wed, 29 Nov 2023 07:08:38 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3ATF8C2y82823373, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3ATF8C2y82823373
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Nov 2023 23:08:12 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Wed, 29 Nov 2023 23:08:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 23:08:11 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 29 Nov 2023 23:08:11 +0800
From:   Hau <hau@realtek.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>
CC:     nic_swsd <nic_swsd@realtek.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "grundler@chromium.org" <grundler@chromium.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net 1/2] r8169: enable rtl8125b pause slot
Thread-Topic: [PATCH net 1/2] r8169: enable rtl8125b pause slot
Thread-Index: AQHaIVs7nAWaTecO6Uq8YPeM6D0ejbCOENSAgANXsHA=
Date:   Wed, 29 Nov 2023 15:08:11 +0000
Message-ID: <0a8be0185fe64398b85098cc7259c1c9@realtek.com>
References: <20231127175736.5738-1-hau@realtek.com>
 <20231127175736.5738-2-hau@realtek.com>
 <a5f89071-f93b-4a30-a0c5-f9dfda68367c@gmail.com>
In-Reply-To: <a5f89071-f93b-4a30-a0c5-f9dfda68367c@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
x-originating-ip: [172.22.228.56]
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

PiA+IFdoZW4gRklGTyByZWFjaCBuZWFyIGZ1bGwgc3RhdGUsIGRldmljZSB3aWxsIGlzc3VlIHBh
dXNlIGZyYW1lLg0KPiA+IElmIHBhdXNlIHNsb3QgaXMgZW5hYmxlZChzZXQgdG8gMSksIGluIHRo
aXMgdGltZSwgZGV2aWNlIHdpbGwgaXNzdWUNCj4gPiBwYXVzZSBmcmFtZSBvbmNlLiBCdXQgaWYg
cGF1c2Ugc2xvdCBpcyBkaXNhYmxlZChzZXQgdG8gMCksIGRldmljZSB3aWxsDQo+ID4ga2VlcCBz
ZW5kaW5nIHBhdXNlIGZyYW1lcyB1bnRpbCBGSUZPIHJlYWNoIG5lYXIgZW1wdHkgc3RhdGUuDQo+
ID4NCj4gPiBXaGVuIHBhdXNlIHNsb3QgaXMgZGlzYWJsZWQsIGlmIHRoZXJlIGlzIG5vIG9uZSB0
byBoYW5kbGUgcmVjZWl2ZQ0KPiA+IHBhY2tldHMgKGV4LiB1bmV4cGVjdGVkIHNodXRkb3duKSwg
ZGV2aWNlIEZJRk8gd2lsbCByZWFjaCBuZWFyIGZ1bGwNCj4gPiBzdGF0ZSBhbmQga2VlcCBzZW5k
aW5nIHBhdXNlIGZyYW1lcy4gVGhhdCB3aWxsIGltcGFjdCBlbnRpcmUgbG9jYWwNCj4gPiBhcmVh
IG5ldHdvcmsuDQo+ID4NCj4gPiBJbiB0aGlzIHBhdGNoIGRlZmF1bHQgZW5hYmxlIHBhdXNlIHNs
b3QgdG8gcHJldmVudCB0aGlzIGtpbmQgb2YNCj4gPiBzaXR1YXRpb24uDQo+ID4NCj4gQ2FuIHRo
aXMgY2hhbmdlIGhhdmUgYW55IHNpZGUgZWZmZWN0PyBJJ20gYXNraW5nIGJlY2F1c2UgYXBwYXJl
bnRseSB0aGUgaHcNCj4gZW5naW5lZXJzIGhhZCBhIHJlYXNvbiB0byBtYWtlIHRoZSBiZWhhdmlv
ciBjb25maWd1cmFibGUuDQoNCkl0IHNob3VsZCBub3QgaGF2ZSBhbnkgc2lkZSBlZmZlY3QuIFRo
aXMgc2V0dGluZyBpcyBhbHNvIHVzZWQgaW4gUmVhbHRlayBkcml2ZXIuDQoNCj4gPiBGaXhlczog
ZjFiY2U0YWQyZjFjICgicjgxNjk6IGFkZCBzdXBwb3J0IGZvciBSVEw4MTI1IikNCj4gPiBDYzog
c3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+IFNpZ25lZC1vZmYtYnk6IENodW5IYW8gTGluIDxo
YXVAcmVhbHRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0
ZWsvcjgxNjlfbWFpbi5jIHwgNyArKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5X21haW4uYw0KPiA+IGIvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvcmVhbHRlay9yODE2OV9tYWluLmMNCj4gPiBpbmRleCAyOTUzNjZhODVjNjMuLjQ3M2IzMjQ1
NzU0ZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9yZWFsdGVrL3I4MTY5
X21haW4uYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L3JlYWx0ZWsvcjgxNjlfbWFp
bi5jDQo+ID4gQEAgLTE5Niw2ICsxOTYsNyBAQCBlbnVtIHJ0bF9yZWdpc3RlcnMgew0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLyogTm8gdGhyZXNob2xkIGJlZm9y
ZSBmaXJzdCBQQ0kgeGZlciAqLw0KPiA+ICAjZGVmaW5lICAgICAgUlhfRklGT19USFJFU0ggICAg
ICAgICAgICAgICAgICAoNyA8PCBSWENGR19GSUZPX1NISUZUKQ0KPiA+ICAjZGVmaW5lICAgICAg
UlhfRUFSTFlfT0ZGICAgICAgICAgICAgICAgICAgICAoMSA8PCAxMSkNCj4gPiArI2RlZmluZSAg
ICAgIFJYX1BBVVNFX1NMT1RfT04gICAgICAgICAgICAgICAgKDEgPDwgMTEpDQo+IA0KPiBEZXBl
bmRpbmcgb24gdGhlIGNoaXAgdmVyc2lvbiB0aGlzIGJpdCBoYXMgZGlmZmVyZW50IG1lYW5pbmdz
LiBUaGVyZWZvcmUgaXQNCj4gd291bGQgYmUgZ29vZCB0byBhZGQgYSBjb21tZW50IHRoYXQgUlhf
UEFVU0VfU0xPVF9PTiBpcyBzcGVjaWZpYyB0bw0KPiBSVEw4MTI1Qi4NCg0KSSB3aWxsIGRvIHRo
YXQgYW5kIHN1Ym1pdCBhZ2Fpbi4NCg0KPiA+ICAjZGVmaW5lICAgICAgUlhDRkdfRE1BX1NISUZU
ICAgICAgICAgICAgICAgICA4DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAvKiBVbmxpbWl0ZWQgbWF4aW11bSBQQ0kgYnVyc3QuICovDQo+ID4gICNkZWZpbmUgICAg
ICBSWF9ETUFfQlVSU1QgICAgICAgICAgICAgICAgICAgICg3IDw8IFJYQ0ZHX0RNQV9TSElGVCkN
Cj4gPiBAQCAtMjMwNSw5ICsyMzA2LDEzIEBAIHN0YXRpYyB2b2lkIHJ0bF9pbml0X3J4Y2ZnKHN0
cnVjdCBydGw4MTY5X3ByaXZhdGUNCj4gKnRwKQ0KPiA+ICAgICAgIGNhc2UgUlRMX0dJR0FfTUFD
X1ZFUl80MCAuLi4gUlRMX0dJR0FfTUFDX1ZFUl81MzoNCj4gPiAgICAgICAgICAgICAgIFJUTF9X
MzIodHAsIFJ4Q29uZmlnLCBSWDEyOF9JTlRfRU4gfCBSWF9NVUxUSV9FTiB8DQo+IFJYX0RNQV9C
VVJTVCB8IFJYX0VBUkxZX09GRik7DQo+ID4gICAgICAgICAgICAgICBicmVhazsNCj4gPiAtICAg
ICBjYXNlIFJUTF9HSUdBX01BQ19WRVJfNjEgLi4uIFJUTF9HSUdBX01BQ19WRVJfNjM6DQo+ID4g
KyAgICAgY2FzZSBSVExfR0lHQV9NQUNfVkVSXzYxOg0KPiA+ICAgICAgICAgICAgICAgUlRMX1cz
Mih0cCwgUnhDb25maWcsIFJYX0ZFVENIX0RGTFRfODEyNSB8IFJYX0RNQV9CVVJTVCk7DQo+ID4g
ICAgICAgICAgICAgICBicmVhazsNCj4gPiArICAgICBjYXNlIFJUTF9HSUdBX01BQ19WRVJfNjM6
DQo+ID4gKyAgICAgICAgICAgICBSVExfVzMyKHRwLCBSeENvbmZpZywgUlhfRkVUQ0hfREZMVF84
MTI1IHwgUlhfRE1BX0JVUlNUIHwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgUlhfUEFVU0Vf
U0xPVF9PTik7DQo+ID4gKyAgICAgICAgICAgICBicmVhazsNCj4gPiAgICAgICBkZWZhdWx0Og0K
PiA+ICAgICAgICAgICAgICAgUlRMX1czMih0cCwgUnhDb25maWcsIFJYMTI4X0lOVF9FTiB8IFJY
X0RNQV9CVVJTVCk7DQo+ID4gICAgICAgICAgICAgICBicmVhazsNCg0K
