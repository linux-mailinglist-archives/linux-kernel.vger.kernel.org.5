Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78E47C486B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 05:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345019AbjJKDXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 23:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344915AbjJKDXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 23:23:09 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ED894;
        Tue, 10 Oct 2023 20:23:06 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39B3MfmeE3435122, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 39B3MfmeE3435122
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Oct 2023 11:22:41 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 11 Oct 2023 11:22:42 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 11 Oct 2023 11:22:41 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b]) by
 RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b%5]) with mapi id
 15.01.2375.007; Wed, 11 Oct 2023 11:22:41 +0800
From:   Ricky WU <ricky_wu@realtek.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] misc: rtsx: Fix an error access Page fault
Thread-Topic: [PATCH] misc: rtsx: Fix an error access Page fault
Thread-Index: AQHZ4Jftyjh/fSClKUGC38rBdS0qobAZ7X2AgBLgYwCADw7QgIAIQ/1w
Date:   Wed, 11 Oct 2023 03:22:41 +0000
Message-ID: <39a288879fa34b329356a9e19384f6fe@realtek.com>
References: <2ce258f371234b1f8a1a470d5488d00e@realtek.com>
 <CAPDyKFoCHtN9jK3A9YkoQC+e_3XNKJNp7-w1WkNMFBp6n-PH=g@mail.gmail.com>
 <CAPDyKFp6cFnpWRA=iGZFr94UdjFbjtMbcTJORfFKQ-izdtX8bQ@mail.gmail.com>
 <CAAd53p5+ngpAB+J_Hshug61bCCCoec=LveeAUSrtAd_UP6gSoQ@mail.gmail.com>
In-Reply-To: <CAAd53p5+ngpAB+J_Hshug61bCCCoec=LveeAUSrtAd_UP6gSoQ@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.22.81.100]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
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

SGkgS2FpLUhlbmcsDQoNCkkgZmluaXNoZWQgdGVzdGluZyB0aGlzIHBhdGNoIGl0J3Mgd29ya2lu
ZyBmaW5lLCByZS1wbHVnIGNhcmQgbWFueSB0aW1lIGRvbid0IHNlZSB0aGUgaXNzdWUgcmVwcm9k
dWNlDQpJIHRoaW5rIHRoaXMgcGF0Y2ggY2FuIGZpeCB0aGUgcHJvYmxlbQ0KdGhhbmsgeW91DQoN
ClRlc3RlZC1ieTogUmlja3kgV3UgPHJpY2t5X3d1QHJlYWx0ZWsuY29tPg0KIA0KPiBSaWNreSwN
Cj4gDQo+IE9uIFR1ZSwgU2VwIDI2LCAyMDIzIGF0IDExOjA04oCvUE0gVWxmIEhhbnNzb24gPHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IHdyb3RlOg0KPiA+DQo+ID4gT24gVGh1LCAxNCBTZXB0
IDIwMjMgYXQgMTY6NDcsIFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPiB3cm90
ZToNCj4gPiA+DQo+ID4gPiBPbiBXZWQsIDYgU2VwdCAyMDIzIGF0IDEwOjAzLCBSaWNreSBXVSA8
cmlja3lfd3VAcmVhbHRlay5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBhbiBlcnJvciBv
Y2N1cnMgb24gaW5zZXJ0IFNENy4wIGNhcmQuDQo+ID4gPiA+IFRoZSBwY2kgc2xvdCBvZiBydHN4
X3BjaSB3aWxsIExpbmsgRG93biB3aGVuIHRoZSBTRDcuMCBjYXJkDQo+ID4gPiA+IGluc2VydGVk
LCBidXQgdGhlIHJ0c3hfcGNpIG5vdCBleGl0IGZyb20gcnVudGltZV9pZGxlIGF0IHRoYXQNCj4g
PiA+ID4gdGltZSwgdGhlbiBkbyB0aGUgcG93ZXJfc2F2aW5nIGZ1bmN0aW9uIHRvIGFjY2VzcyB0
aGUgd3JvbmcNCj4gPiA+ID4gcmVzb3VyY2UNCj4gPiA+ID4NCj4gPiA+ID4gRml4ZXM6IDU5NzU2
OGU4ZGYwNCAoIm1pc2M6IHJ0c3g6IFJld29yayBydW50aW1lIHBvd2VyIG1hbmFnZW1lbnQNCj4g
PiA+ID4gZmxvdyIpDQo+ID4gPiA+IENjOiBLYWktSGVuZyBGZW5nIDxrYWkuaGVuZy5mZW5nQGNh
bm9uaWNhbC5jb20+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2t5IFd1IDxyaWNreV93dUBy
ZWFsdGVrLmNvbT4NCj4gPiA+DQo+ID4gPiBBcHBsaWVkIGZvciBmaXhlcywgdGhhbmtzIQ0KPiA+
DQo+ID4gVGhpcyB3YXMgbm90IHJlYWR5IHRvIGJlIGFwcGxpZWQsIG15IGJhZCEgRm9ydHVuYXRl
bHksIEkgaGF2ZW4ndA0KPiA+IHN1Ym1pdHRlZCBhIHB1bGwtcmVxdWVzdCB3aXRoIHRoaXMgeWV0
LCBzbyBJIGFtIHNpbXBseSBkcm9wcGluZyB0aGUNCj4gPiBwYXRjaCBmb3Igbm93LCB0byBtYWtl
IHN1cmUgd2UgZmluZCB0aGUgcHJvcGVyIHNvbHV0aW9uLg0KPiANCj4gQ2FuIHlvdSBwbGVhc2Ug
c2VlIGlmIHRoZSBmb2xsb3dpbmcgY2hhbmdlIGhlbHBzOg0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGNpL2hvdHBsdWcvcGNpZWhwX3BjaS5jIGIvZHJpdmVycy9wY2kvaG90cGx1Zy9wY2ll
aHBfcGNpLmMNCj4gaW5kZXggYWQxMjUxNWE0YTEyMS4uODk0ODBlMzFjMjI2NiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9wY2kvaG90cGx1Zy9wY2llaHBfcGNpLmMNCj4gKysrIGIvZHJpdmVycy9w
Y2kvaG90cGx1Zy9wY2llaHBfcGNpLmMNCj4gQEAgLTE4LDkgKzE4LDE4IEBADQo+ICAjaW5jbHVk
ZSA8bGludXgva2VybmVsLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4NCj4gICNpbmNs
dWRlIDxsaW51eC9wY2kuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+DQo+ICAj
aW5jbHVkZSAiLi4vcGNpLmgiDQo+ICAjaW5jbHVkZSAicGNpZWhwLmgiDQo+IA0KPiAraW50IHBj
aWVocF9wbV9ydW50aW1lX2JhcnJpZXIoc3RydWN0IHBjaV9kZXYgKnBkZXYsIHZvaWQgKnVudXNl
ZCkgew0KPiArICAgICAgIHBtX3J1bnRpbWVfYmFycmllcigmcGRldi0+ZGV2KTsNCj4gKyAgICAg
ICBwY2lfZGV2X3NldF9kaXNjb25uZWN0ZWQocGRldiwgTlVMTCk7DQo+ICsNCj4gKyAgICAgICBy
ZXR1cm4gMDsNCj4gK30NCj4gKw0KPiAgLyoqDQo+ICAgKiBwY2llaHBfY29uZmlndXJlX2Rldmlj
ZSgpIC0gZW51bWVyYXRlIFBDSSBkZXZpY2VzIGJlbG93IGEgaG90cGx1Zw0KPiBicmlkZ2UNCj4g
ICAqIEBjdHJsOiBQQ0llIGhvdHBsdWcgY29udHJvbGxlcg0KPiBAQCAtOTgsNyArMTA3LDcgQEAg
dm9pZCBwY2llaHBfdW5jb25maWd1cmVfZGV2aWNlKHN0cnVjdCBjb250cm9sbGVyICpjdHJsLA0K
PiBib29sIHByZXNlbmNlKQ0KPiAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBwY2lfZG9tYWlu
X25yKHBhcmVudCksIHBhcmVudC0+bnVtYmVyKTsNCj4gDQo+ICAgICAgICAgaWYgKCFwcmVzZW5j
ZSkNCj4gLSAgICAgICAgICAgICAgIHBjaV93YWxrX2J1cyhwYXJlbnQsIHBjaV9kZXZfc2V0X2Rp
c2Nvbm5lY3RlZCwgTlVMTCk7DQo+ICsgICAgICAgICAgICAgICBwY2lfd2Fsa19idXMocGFyZW50
LCBwY2llaHBfcG1fcnVudGltZV9iYXJyaWVyLCBOVUxMKTsNCj4gDQo+ICAgICAgICAgcGNpX2xv
Y2tfcmVzY2FuX3JlbW92ZSgpOw0KPiANCj4gDQo+ID4NCj4gPiBbLi4uXQ0KPiA+DQo+ID4gS2lu
ZCByZWdhcmRzDQo+ID4gVWZmZQ0K
