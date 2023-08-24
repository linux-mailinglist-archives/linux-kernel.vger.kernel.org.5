Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBA078658D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 04:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239509AbjHXCrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 22:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239475AbjHXCrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 22:47:36 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C44C198
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 19:47:34 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37O2jDucD024472, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37O2jDucD024472
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Aug 2023 10:45:13 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 24 Aug 2023 10:44:53 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 24 Aug 2023 10:44:52 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b]) by
 RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b%5]) with mapi id
 15.01.2375.007; Thu, 24 Aug 2023 10:44:52 +0800
From:   Ricky WU <ricky_wu@realtek.com>
To:     Genes Lists <lists@sapience.com>, Keith Busch <kbusch@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>, "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: Possible nvme regression in 6.4.11
Thread-Topic: Possible nvme regression in 6.4.11
Thread-Index: AQHZ0Otwxcnf+XYUokSPBeX1qZBAw6/3qhuAgAAtxICAAOyCoA==
Date:   Thu, 24 Aug 2023 02:44:52 +0000
Message-ID: <180a2bbd2c314ede8f6c4c16cc4603bf@realtek.com>
References: <5f968b95-6b1c-4d6f-aac7-5d54f66834a8@sapience.com>
 <ZN050TFnKZ54LJ5v@kbusch-mbp.dhcp.thefacebook.com>
 <30b69186-5a6e-4f53-b24c-2221926fc3b4@sapience.com>
 <570d465a-7500-4b58-98f0-fd781c8740cc@sapience.com>
 <ZOZEwafA8+tknJNT@kbusch-mbp.dhcp.thefacebook.com>
 <7cf188d0-77b4-4e80-8da6-2045a7f29866@sapience.com>
In-Reply-To: <7cf188d0-77b4-4e80-8da6-2045a7f29866@sapience.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.81.100]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VuZSwNCg0KSSBjYW4ndCByZXByb2R1Y2UgdGhpcyBpc3N1ZSBvbiBteSBzaWRlLi4uDQoN
ClNvIGlmIHlvdSBvbmx5IHJldmVydCB0aGlzIHBhdGNoICg2OTMwNGM4ZDI4NWI3N2M5YTU2ZDY4
ZjVkZGIyNTU4ZjI3YWJmNDA2KSBjYW4gd29yayBmaW5lPw0KVGhpcyBwYXRjaCBvbmx5IGRvIGlz
IHB1bGwgb3VyIGNsb2NrIHJlcXVlc3QgdG8gSElHSCBpZiBIT1NUIG5lZWQgYWxzbyBjYW4gcHVs
bCB0byBMT1csIGFuZCB0aGlzIG9ubHkgZG8gb24gb3VyIGRldmljZQ0KSSBkb27igJl0IHRoaW5r
IHRoaXMgd2lsbCBhZmZlY3Qgb3RoZXIgcG9ydHMuLi4NCg0KQlIsDQpSaWNreQ0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEdlbmVzIExpc3RzIDxsaXN0c0BzYXBpZW5j
ZS5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMjQsIDIwMjMgNDoyNSBBTQ0KPiBUbzog
S2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgYXhib2VAa2VybmVsLmRrOyBzYWdpQGdyaW1iZXJnLm1lOw0KPiBsaW51eC1u
dm1lQGxpc3RzLmluZnJhZGVhZC5vcmc7IGhjaEBsc3QuZGU7IGFybmRAYXJuZGIuZGU7IFJpY2t5
IFdVDQo+IDxyaWNreV93dUByZWFsdGVrLmNvbT47IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3Jn
DQo+IFN1YmplY3Q6IFJlOiBQb3NzaWJsZSBudm1lIHJlZ3Jlc3Npb24gaW4gNi40LjExDQo+IA0K
PiANCj4gRXh0ZXJuYWwgbWFpbC4NCj4gDQo+IA0KPiANCj4gT24gOC8yMy8yMyAxMzo0MSwgS2Vp
dGggQnVzY2ggd3JvdGU6DQo+ID4gT24gVGh1LCBBdWcgMTcsIDIwMjMgYXQgMDU6MTY6MDFBTSAt
MDQwMCwgR2VuZXMgTGlzdHMgd3JvdGU6DQo+ID4+PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4+PiA2OTMwNGM4ZDI4
NWI3N2M5YTU2ZDY4ZjVkZGIyNTU4ZjI3YWJmNDA2IGlzIHRoZSBmaXJzdCBiYWQgY29tbWl0DQo+
ID4+PiBjb21taXQgNjkzMDRjOGQyODViNzdjOWE1NmQ2OGY1ZGRiMjU1OGYyN2FiZjQwNg0KPiA+
Pj4gQXV0aG9yOiBSaWNreSBXVSA8cmlja3lfd3VAcmVhbHRlay5jb20+DQo+ID4+PiBEYXRlOiAg
IFR1ZSBKdWwgMjUgMDk6MTA6NTQgMjAyMyArMDAwMA0KPiA+Pj4NCj4gPj4+ICAgICAgIG1pc2M6
IHJ0c3g6IGp1ZGdlIEFTUE0gTW9kZSB0byBzZXQgUEVUWENGRyBSZWcNCj4gPj4+DQo+ID4+PiAg
ICAgICBjb21taXQgMTAxYmQ5MDdiNDI0NGE3MjY5ODBlZTY3Zjk1ZWQ5Y2FmYWI2ZmY3YSB1cHN0
cmVhbS4NCj4gPj4+DQo+ID4+PiAgICAgICBBU1BNIE1vZGUgaXMgQVNQTV9NT0RFX0NGRyBuZWVk
IHRvIGp1ZGdlIHRoZSB2YWx1ZSBvZg0KPiBjbGtyZXFfMA0KPiA+Pj4gICAgICAgdG8gc2V0IEhJ
R0ggb3IgTE9XLCBpZiB0aGUgQVNQTSBNb2RlIGlzIEFTUE1fTU9ERV9SRUcNCj4gPj4+ICAgICAg
IGFsd2F5cyBzZXQgdG8gSElHSCBkdXJpbmcgdGhlIGluaXRpYWxpemF0aW9uLg0KPiA+Pj4NCj4g
Pj4+ICAgICAgIENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4+PiAgICAgICBTaWduZWQt
b2ZmLWJ5OiBSaWNreSBXdSA8cmlja3lfd3VAcmVhbHRlay5jb20+DQo+ID4+PiAgICAgICBMaW5r
Og0KPiA+Pj4NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci81MjkwNmM2ODM2Mzc0YzhjYjA2
ODIyNTk1NGM1NTQzYUByZWFsdGVrLmNvbQ0KPiA+Pj4gICAgICAgU2lnbmVkLW9mZi1ieTogR3Jl
ZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gPj4+DQo+ID4+
PiAgICBkcml2ZXJzL21pc2MvY2FyZHJlYWRlci9ydHM1MjI3LmMgIHzCoCAyICstDQo+ID4+PiAg
ICBkcml2ZXJzL21pc2MvY2FyZHJlYWRlci9ydHM1MjI4LmMgIHwgMTggLS0tLS0tLS0tLS0tLS0t
LS0tDQo+ID4+PiAgICBkcml2ZXJzL21pc2MvY2FyZHJlYWRlci9ydHM1MjQ5LmMgIHzCoCAzICst
LQ0KPiA+Pj4gICAgZHJpdmVycy9taXNjL2NhcmRyZWFkZXIvcnRzNTI2MC5jICB8IDE4IC0tLS0t
LS0tLS0tLS0tLS0tLQ0KPiA+Pj4gICAgZHJpdmVycy9taXNjL2NhcmRyZWFkZXIvcnRzNTI2MS5j
ICB8IDE4IC0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+Pj4gICAgZHJpdmVycy9taXNjL2NhcmRyZWFk
ZXIvcnRzeF9wY3IuYyB8wqAgNSArKysrLQ0KPiA+Pj4gICAgNiBmaWxlcyBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKyksIDU4IGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4+IC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+Pj4NCj4gPj4+IEFu
ZCB0aGUgbWFjaGluZSBkb2VzIGhhdmUgdGhpcyBoYXJkd2FyZToNCj4gPj4+DQo+ID4+PiAwMzow
MC4wIFVuYXNzaWduZWQgY2xhc3MgW2ZmMDBdOiBSZWFsdGVrIFNlbWljb25kdWN0b3IgQ28uLCBM
dGQuDQo+ID4+PiBSVFM1MjVBIFBDSSBFeHByZXNzIENhcmQgUmVhZGVyIChyZXYgMDEpDQo+ID4+
PiAgICAgICAgICAgU3Vic3lzdGVtOiBEZWxsIFJUUzUyNUEgUENJIEV4cHJlc3MgQ2FyZCBSZWFk
ZXINCj4gPj4+ICAgICAgICAgICBQaHlzaWNhbCBTbG90OiAxDQo+ID4+PiAgICAgICAgICAgRmxh
Z3M6IGJ1cyBtYXN0ZXIsIGZhc3QgZGV2c2VsLCBsYXRlbmN5IDAsIElSUSAxNDENCj4gPj4+ICAg
ICAgICAgICBNZW1vcnkgYXQgZWQxMDAwMDAgKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3Np
emU9NEtdDQo+ID4+PiAgICAgICAgICAgQ2FwYWJpbGl0aWVzOiBbODBdIFBvd2VyIE1hbmFnZW1l
bnQgdmVyc2lvbiAzDQo+ID4+PiAgICAgICAgICAgQ2FwYWJpbGl0aWVzOiBbOTBdIE1TSTogRW5h
YmxlKyBDb3VudD0xLzEgTWFza2FibGUtIDY0Yml0Kw0KPiA+Pj4gICAgICAgICAgIENhcGFiaWxp
dGllczogW2IwXSBFeHByZXNzIEVuZHBvaW50LCBNU0kgMDANCj4gPj4+ICAgICAgICAgICBLZXJu
ZWwgZHJpdmVyIGluIHVzZTogcnRzeF9wY2kNCj4gPj4+ICAgICAgICAgICBLZXJuZWwgbW9kdWxl
czogcnRzeF9wY2kNCj4gPj4+DQo+ID4+Pg0KPiA+Pj4NCj4gPj4NCj4gPj4NCj4gPj4gQWRkaW5n
IHRvIENDIGxpc3Qgc2luY2UgYmlzZWN0IGxhbmRlZCBvbg0KPiA+Pg0KPiA+PiAgICAgZHJpdmVy
cy9taXNjL2NhcmRyZWFkZXIvcnRzeF9wY3IuYw0KPiA+Pg0KPiA+PiBUaHJlYWQgc3RhcnRzIGhl
cmU6IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIzLzgvMTYvMTE1NA0KPiA+DQo+ID4gSSByZWFs
aXplIHlvdSBjYW4gd29yayBhcm91bmQgdGhpcyBieSBibGFja2xpc3RpbmcgdGhlIHJ0c3hfcGNp
LCBidXQNCj4gPiB0aGF0J3Mgbm90IGEgcGxlYXNhbnQgc29sdXRpb24uIFdpdGggb25seSBhIGZl
dyBkYXlzIGxlZnQgaW4gNi41LA0KPiA+IHNob3VsZCB0aGUgY29tbWl0IGp1c3QgYmUgcmV2ZXJ0
ZWQ/DQo+IA0KPiBLZWl0aCAtIHRoYW5rcyBmb3IgcmVtaW5kZXIuDQo+IA0KPiBUaGUgY2FyZCBy
ZWFkZXIgZGV2aWNlIGl0c2VsZiBpcyBub24tY3JpdGljYWwgYW5kIHZlcnkgbG93IHByaW9yaXR5
Lg0KPiANCj4gV2hhdCBwZXJoYXBzIGlzIGEgbGl0dGxlIG1vcmUgd29ycmlzb21lIGlzIHRoZSBj
aGFuZ2UgaW4gcnRzeCBzb21laG93DQo+IHByZXZlbnRlZCBudm1lIGZyb20gZnVuY3Rpb25pbmcg
bm9ybWFsbHkgYW5kIHRoZSBtYWNoaW5lIHRoZW4gbm90IGJvb3RpbmcNCj4gKGF0IGxlYXN0IGZv
ciBzb21lIGNvbWJpbmF0aW9uKHMpIG9mIGhhcmR3YXJlKS4NCj4gDQo+IElmIHRoZXJlIGlzIGEg
c2ltcGxlIGZpeCB0byBwcmV2ZW50IG52bWUgZnJvbSBiZWluZyBpbXBhY3RlZCBieSB0aGUgcnRz
eCBkcml2ZXINCj4gdGhhdCB3b3VsZCBiZSBtb3JlIHRoYW4gc3VmZmljaWVudD8NCj4gDQo+IE9u
IHRoZSBvdGhlciBoYW5kIDYuNC4xMSBpcyBvdXQsIGFuZCBJJ20gZ3Vlc3NpbmcgdGhlcmUgaXNu
J3QgYSBsb3Qgb2Ygbm9pc2Ugb24NCj4gdGhpcyBlaXRoZXIuIEZyb20gd2hhdCBJJ3ZlIHNlZW4s
IDEgb3RoZXIgdXNlciB3aXRoIHNhbWUgcHJvYmxlbSBbMV0gYW5kIDEgd2l0aA0KPiBzYW1lIGNh
cmQgcmVhZGVyIG5vdCBoYXZpbmcgYSBwcm9ibGVtYSBbMl0uDQo+IEFuZCBubyAnbWUtdG9vJ3Mg
aW4gdGhlIGtlcm5lbCBidWd6aWxsYSBbM10gZWl0aGVyLg0KPiANCj4gDQo+IEdlbmUNCj4gDQo+
IA0KPiBbMV0gaHR0cHM6Ly9iYnMuYXJjaGxpbnV4Lm9yZy92aWV3dG9waWMucGhwP2lkPTI4ODA5
NQ0KPiBbMl0gaHR0cHM6Ly9idWdzLmFyY2hsaW51eC5vcmcvdGFzay83OTQzOQ0KPiBbM10gaHR0
cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTc4MDINCj4gDQo+IA0K
PiANCj4gDQo+IC0tLS0tLVBsZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHBy
aW50aW5nIHRoaXMgZS1tYWlsLg0K
