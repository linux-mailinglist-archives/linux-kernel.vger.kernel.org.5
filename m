Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F857D916C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 10:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbjJ0I01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 04:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbjJ0I0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 04:26:22 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F2F1B4;
        Fri, 27 Oct 2023 01:26:19 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39R8P6iN43843206, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39R8P6iN43843206
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 16:25:06 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 27 Oct 2023 16:25:06 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 27 Oct 2023 16:25:06 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b]) by
 RTEXMBS01.realtek.com.tw ([fe80::9cb8:8d5:b6b3:213b%5]) with mapi id
 15.01.2375.007; Fri, 27 Oct 2023 16:25:06 +0800
From:   Ricky WU <ricky_wu@realtek.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "yangyingliang@huawei.com" <yangyingliang@huawei.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] misc: rtsx: add to support new card reader rts5264
Thread-Topic: [PATCH v3 1/2] misc: rtsx: add to support new card reader
 rts5264
Thread-Index: AQHaAynsmhTs26pH702PHG8h5layhrBUNdwAgAJ4IRCAAyS4gIADgQuA
Date:   Fri, 27 Oct 2023 08:25:06 +0000
Message-ID: <ff32ebcd6a1b41d5bd23a028f1a3f88b@realtek.com>
References: <121ced554a9e4f4791018e8f6a72d586@realtek.com>
 <2023102153-paramedic-washboard-29e3@gregkh>
 <b31f74462ce240a18652643224e285dd@realtek.com>
 <2023102514-unleash-italics-37ae@gregkh>
In-Reply-To: <2023102514-unleash-italics-37ae@gregkh>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.22.81.100]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="big5"
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

PiBPbiBNb24sIE9jdCAyMywgMjAyMyBhdCAwMzozMToyNEFNICswMDAwLCBSaWNreSBXVSB3cm90
ZToNCj4gPiA+ID4gSW4gb3JkZXIgdG8gc3VwcG9ydCBuZXcgY2hpcCBydHM1MjY0LCB0aGUgZGVm
aW5pdGlvbnMgb2Ygc29tZQ0KPiA+ID4gPiBpbnRlcm5hbCByZWdpc3RlcnMgYW5kIHdvcmtmbG93
IGhhdmUgdG8gYmUgbW9kaWZpZWQuDQo+ID4gPg0KPiA+ID4gVGhhdCBpcyBmaW5lLCBidXQgdGhh
dCBzaG91bGQgYmUgYSBzaW5nbGUgcGF0Y2gsIHJpZ2h0Pw0KPiA+ID4NCj4gPg0KPiA+IFNvcnJ5
IG1heWJlIGFib3V0IG1pc3VuZGVyc3RhbmQsIFRoZSBtb2RpZmljYXRpb25zIG1lbnRpb25lZCBo
ZXJlLCBpdA0KPiA+IHRhbGsgYWJvdXQgc29tZSBqdWRnbWVudCBleHByZXNzaW9ucyBhZGQgIlBJ
RCA1MjY0IiB0byBtYWtlIGp1ZGdlbWVudA0KPiA+IGluIHJ0c3hfcGNyLmMsIHNvIG9ubHkgYWJv
dXQgMzAgbGluZSBtb2RpZmllZCBpbiBydHN4X3Bjci5jDQo+ID4NCj4gPiA+ID4gQWRkZWQgcnRz
NTI2NC5jIHJ0czUyNjQuaCBmb3IgaW5kZXBlbmRlbnQgZnVuY3Rpb25zIG9mIHRoZSBuZXcNCj4g
PiA+ID4gY2hpcCBydHM1MjY0DQo+ID4gPg0KPiA+ID4gQW5kIHRoZW4gYWRkIG5ldyBzdXBwb3J0
IGluIGEgbmV3IHBhdGNoLCB0aGlzIGlzIHN0aWxsIHRvbyBiaWcgYXMNCj4gPiA+IG9uZSBwYXRj
aCB0byBhdHRlbXB0IHRvIHJldmlldyBpdCBwcm9wZXJseS4gIFdvdWxkIHlvdSBsaWtlIHRvDQo+
ID4gPiByZXZpZXcgdGhpcyBhcy1pcz8NCj4gPiA+DQo+ID4NCj4gPiBZZXMsIHRoYW5rIHlvdQ0K
PiA+IEJlY2F1c2UgcnRzNTI2NC5jIHJ0czUyNjQuaCBvbmx5IGZvciBydHM1MjY0IChuZXcgY2hp
cCkuDQo+ID4gVGhlIHBhc3QgYXJjaGl0ZWN0dXJlIG9mIHRoaXMgZHJpdmVyIHdhcyBsaWtlIHRo
aXMsIGFuZCBpdCB3aWxsIGdvb2QNCj4gPiBmb3IgdXMgdG8gbWFpbnRhaW4gdGhlIGRyaXZlciBk
aWZmZXJlbnQgY2hpcCBtYXliZSBoYXMgZGlmZmVyZW50DQo+ID4gZnVuY3Rpb25zIGFuZCByZWdp
c3RlciBkZWZpbml0aW9ucyB3ZSB1c2VkIHRvIHNlcGFyYXRlIGRpZmZlcmVudCAuYyAuaA0KPiAN
Cj4gU29ycnksIEkgZG9uJ3QgdGhpbmsgSSB3YXMgY2xlYXIsIHRoaXMgbmVlZHMgdG8gYmUgYnJv
a2VuIHVwIGludG8gc21hbGxlciBwaWVjZXMgdG8NCj4gYmUgYWJsZSBmb3IgdXMgdG8gcmV2aWV3
IGl0IHByb3Blcmx5LiAgUGxlYXNlIGRvIHNvIGFuZCByZXNlbmQgYSBuZXcgdmVyc2lvbiBvZg0K
PiB0aGUgcGF0Y2ggc2VyaWVzLg0KPiANCg0KSGkgR3JlZyBrLWihQQ0KDQpJIHdhbnQgdG8gY29u
ZmlybSB3aXRoIHlvdSBmaXJzdA0KSSB3aWxsIGhhdmUgYSBuZXcgdmVyc2lvbiBmb3IgdGhpcyBw
YXRjaCwgc2VwYXJhdGUgaXQgaW50bzoNCjEuIDIgbmV3IGZpbGUgYW5kIE1ha2VmaWxlIGZvciBu
ZXcgY2hpcCBmdW5jdGlvbiBhbmQgZGVmaW5pdGlvbiANCjIuIHJ0c3hfcGNyLmMgYW5kIHJ0c3hf
cGNyLmggZm9yIGRyaXZlciBqdWRnZW1lbnQgdG8gY2FsbCBuZXcgY2hpcCBmdW5jdGlvbiAgDQoz
LiBtbWMgcGFydA0KDQpJdCBpcyBvayBmb3IgeW91Pw0KDQpUaGFuayB5b3UNClJpY2t5DQoNCj4g
dGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg==
