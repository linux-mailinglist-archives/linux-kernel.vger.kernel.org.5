Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F87A809A4B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 04:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbjLHD12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 22:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHD10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 22:27:26 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E8910CA;
        Thu,  7 Dec 2023 19:27:31 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3B83RHyP4577203, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3B83RHyP4577203
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Dec 2023 11:27:17 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 8 Dec 2023 11:27:18 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 8 Dec 2023 11:27:17 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::540c:c8d6:1d0f:ab9f]) by
 RTEXMBS01.realtek.com.tw ([fe80::540c:c8d6:1d0f:ab9f%5]) with mapi id
 15.01.2507.034; Fri, 8 Dec 2023 11:27:17 +0800
From:   Ricky WU <ricky_wu@realtek.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v6 1/3] misc: rtsx: add to support new card reader rts5264 new definition and function
Thread-Topic: [PATCH v6 1/3] misc: rtsx: add to support new card reader
 rts5264 new definition and function
Thread-Index: AQHaIncLHE1XODAr1k6MteWilVyRCrCcmzAAgAIrsxA=
Date:   Fri, 8 Dec 2023 03:27:17 +0000
Message-ID: <6241bf49d5cb40329640e759cecd8f06@realtek.com>
References: <20231129034856.2001223-1-ricky_wu@realtek.com>
 <20231129034856.2001223-2-ricky_wu@realtek.com>
 <2023120715-reenact-repose-906c@gregkh>
In-Reply-To: <2023120715-reenact-repose-906c@gregkh>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.22.81.100]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

PiA+IGluIG9yZGVyIHRvIHN1cHBvcnQgTkVXIGNoaXAgcnRzNTI2NCwgdGhlIGRlZmluaXRpb25z
IG9mIHNvbWUgaW50ZXJuYWwNCj4gPiByZWdpc3RlcnMgYXJlIGRlZmluZSBpbiBuZXcgZmlsZSBy
dHM1MjY0LmgsIGFuZCBzb21lIGNhbGxiYWNrDQo+ID4gZnVuY3Rpb25zIGFuZCB0aGUgd29ya2Zs
b3cgZm9yIHJ0czUyNjQgYXJlIGRlZmluZSBpbiBuZXcgZmlsZQ0KPiA+IHJ0czUyNjQuYw0KPiA+
DQo+ID4gYWxzbyBhZGQgcnRzNTI2NC5vIHRvIE1ha2VmaWxlDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBSaWNreSBXdSA8cmlja3lfd3VAcmVhbHRlay5jb20+DQo+ID4gLS0tDQo+ID4gdjQ6IHNw
bGl0IG5ldyBkZWZpbml0aW9uIHBhcnQgdXAgZnJvbSB2Mw0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L21pc2MvY2FyZHJlYWRlci9NYWtlZmlsZSAgfCAgIDIgKy0NCj4gPiAgZHJpdmVycy9taXNjL2Nh
cmRyZWFkZXIvcnRzNTI2NC5jIHwgODg2DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrICBkcml2ZXJzL21pc2MvY2FyZHJlYWRlci9ydHM1MjY0LmggfA0KPiA+IDI3OCArKysrKysr
KysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTE2NSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pICBjcmVhdGUgbW9kZQ0KPiA+IDEwMDY0NCBkcml2ZXJzL21pc2MvY2FyZHJlYWRlci9ydHM1
MjY0LmMgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IGRyaXZlcnMvbWlzYy9jYXJkcmVhZGVyL3J0
czUyNjQuaA0KPiANCj4gV2hlbiBidWlsZGluZyB3aXRoIHRoaXMgY2hhbmdlIGFwcGxpZWQsIEkg
Z2V0IGxvdHMgb2YgYnVpbGQgZXJyb3JzLiAgSG93IGRpZCB5b3UNCj4gdGVzdCB0aGlzPw0KPiAN
Cj4gTXkgZXJyb3JzIGFyZToNCj4gDQo+ICAgQ0MgW01dICBkcml2ZXJzL21pc2MvY2FyZHJlYWRl
ci9ydHM1MjY0Lm8NCj4gZHJpdmVycy9taXNjL2NhcmRyZWFkZXIvcnRzNTI2NC5jOiBJbiBmdW5j
dGlvbiDigJhydHM1MjY0X3Byb2Nlc3Nfb2Nw4oCZOg0KPiBkcml2ZXJzL21pc2MvY2FyZHJlYWRl
ci9ydHM1MjY0LmM6Mzk4OjQwOiBlcnJvcjog4oCYc3RydWN0IHJ0c3hfcGNy4oCZIGhhcyBubw0K
PiBtZW1iZXIgbmFtZWQg4oCYb3ZwX3N0YXTigJk7IGRpZCB5b3UgbWVhbiDigJhvY3Bfc3RhdOKA
mT8NCj4gICAzOTggfCAgICAgICAgIHJ0czUyNjRfZ2V0X292cHN0YXQocGNyLCAmcGNyLT5vdnBf
c3RhdCk7DQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
Xn5+fn5+fn4NCj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBvY3Bfc3RhdA0KPiBkcml2ZXJzL21pc2MvY2FyZHJlYWRlci9ydHM1MjY0LmM6NDAyOjMxOiBl
cnJvcjog4oCYc3RydWN0IHJ0c3hfcGNy4oCZIGhhcyBubw0KPiBtZW1iZXIgbmFtZWQg4oCYb3Zw
X3N0YXTigJk7IGRpZCB5b3UgbWVhbiDigJhvY3Bfc3RhdOKAmT8NCj4gICA0MDIgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAocGNyLT5vdnBfc3RhdCAmIChSVFM1MjY0X09WUF9OT1cgfA0KPiBS
VFM1MjY0X09WUF9FVkVSKSkpIHsNCj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBefn5+fn5+fg0KPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9j
cF9zdGF0DQo+IGRyaXZlcnMvbWlzYy9jYXJkcmVhZGVyL3J0czUyNjQuYzo0MDg6MjI6IGVycm9y
OiDigJhzdHJ1Y3QgcnRzeF9wY3LigJkgaGFzIG5vDQo+IG1lbWJlciBuYW1lZCDigJhvdnBfc3Rh
dOKAmTsgZGlkIHlvdSBtZWFuIOKAmG9jcF9zdGF04oCZPw0KPiAgIDQwOCB8ICAgICAgICAgICAg
ICAgICBwY3ItPm92cF9zdGF0ID0gMDsNCj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICBe
fn5+fn5+fg0KPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgIG9jcF9zdGF0DQo+IGRyaXZl
cnMvbWlzYy9jYXJkcmVhZGVyL3J0czUyNjQuYzogSW4gZnVuY3Rpb24g4oCYcnRzNTI2NF9leHRy
YV9pbml0X2h34oCZOg0KPiBkcml2ZXJzL21pc2MvY2FyZHJlYWRlci9ydHM1MjY0LmM6NTM0OjM4
OiBlcnJvcjog4oCYUlRTNTI2NF9BVVRPTE9BRF9DRkcy4oCZDQo+IHVuZGVjbGFyZWQgKGZpcnN0
IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKTsgZGlkIHlvdSBtZWFuDQo+IOKAmFJUUzUyNjRfQVVUT0xP
QURfQ0ZHM+KAmT8NCj4gICA1MzQgfCAgICAgICAgIHJ0c3hfcGNpX3dyaXRlX3JlZ2lzdGVyKHBj
ciwgUlRTNTI2NF9BVVRPTE9BRF9DRkcyLA0KPiAgICAgICB8DQo+IF5+fn5+fn5+fn5+fn5+fn5+
fn5+fg0KPiAgICAgICB8DQo+IFJUUzUyNjRfQVVUT0xPQURfQ0ZHMw0KPiBkcml2ZXJzL21pc2Mv
Y2FyZHJlYWRlci9ydHM1MjY0LmM6NTM0OjM4OiBub3RlOiBlYWNoIHVuZGVjbGFyZWQgaWRlbnRp
ZmllciBpcw0KPiByZXBvcnRlZCBvbmx5IG9uY2UgZm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFy
cyBpbg0KPiBkcml2ZXJzL21pc2MvY2FyZHJlYWRlci9ydHM1MjY0LmM6NTM1OjI1OiBlcnJvcjog
4oCYUlRTNTI2NF9DSElQX1JTVF9OX1NFTOKAmQ0KPiB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4g
dGhpcyBmdW5jdGlvbik7IGRpZCB5b3UgbWVhbg0KPiDigJhSVFM1MjY0X05PTl9YVEFMX1NFTOKA
mT8NCj4gICA1MzUgfCAgICAgICAgICAgICAgICAgICAgICAgICBSVFM1MjY0X0NISVBfUlNUX05f
U0VMLCAwKTsNCj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+
fn5+fn5+fn5+DQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgUlRTNTI2NF9OT05f
WFRBTF9TRUwNCj4gZHJpdmVycy9taXNjL2NhcmRyZWFkZXIvcnRzNTI2NC5jOjUzODozODogZXJy
b3I6IOKAmENER1figJkgdW5kZWNsYXJlZCAoZmlyc3QNCj4gdXNlIGluIHRoaXMgZnVuY3Rpb24p
DQo+ICAgNTM4IHwgICAgICAgICBydHN4X3BjaV93cml0ZV9yZWdpc3RlcihwY3IsIENER1csIDB4
RkYsIDB4MDEpOw0KPiAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBefn5+DQo+IGRyaXZlcnMvbWlzYy9jYXJkcmVhZGVyL3J0czUyNjQuYzogSW4gZnVuY3Rpb24g
4oCYcnRzNTI2NF9pbml0X3BhcmFtc+KAmToNCj4gZHJpdmVycy9taXNjL2NhcmRyZWFkZXIvcnRz
NTI2NC5jOjg4Mzo1MTogZXJyb3I6IOKAmFNEX09WUF9JTlRfRU7igJkNCj4gdW5kZWNsYXJlZCAo
Zmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pOyBkaWQgeW91IG1lYW4g4oCYU0RfT0NQX0lOVF9F
TuKAmT8NCj4gICA4ODMgfCAgICAgICAgIGh3X3BhcmFtLT5pbnRlcnJ1cHRfZW4gfD0gKFNEX09D
X0lOVF9FTiB8DQo+IFNEX09WUF9JTlRfRU4pOw0KPiAgICAgICB8DQo+IF5+fn5+fn5+fn5+fn4N
Cj4gICAgICAgfA0KPiBTRF9PQ1BfSU5UX0VODQo+IG1ha2VbNV06ICoqKiBbc2NyaXB0cy9NYWtl
ZmlsZS5idWlsZDoyNDM6IGRyaXZlcnMvbWlzYy9jYXJkcmVhZGVyL3J0czUyNjQub10NCj4gRXJy
b3IgMQ0KPiANCj4gDQo+IA0KPiBSZW1lbWJlciwgZWFjaCBjb21taXQgY2FuIG5vdCBicmVhayB0
aGUgYnVpbGQuICBQbGVhc2UgZml4IHVwIHRoaXMgc2VyaWVzIHRvDQo+IGJ1aWxkIHByb3Blcmx5
IGF0IGVhY2ggY29tbWl0Lg0KPiANCg0KU29ycnkgZm9yIHRoYXQsIEkgc2VudCB0aGUgdjcgdG8g
Zml4IHRoaXMgaXNzdWUsIHNvbWUgZGVmaW5pdGlvbnMgYXJlIGRlZmluZWQgaW4NClBhdGNoIzIs
IEkgbW92ZWQgdGhlIGZpbGUgdG8gUGF0Y2gjMSBpbiB2Nw0KDQpUaGFuayB5b3UNCg0KPiB0aGFu
a3MsDQo+IA0KPiBncmVnIGstaA0K
