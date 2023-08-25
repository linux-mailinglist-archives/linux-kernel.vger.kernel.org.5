Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A997787CFB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 03:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240400AbjHYBON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 21:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238162AbjHYBNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 21:13:55 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 998B61BFB;
        Thu, 24 Aug 2023 18:13:51 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37P1CkisE019342, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37P1CkisE019342
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Aug 2023 09:12:46 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 25 Aug 2023 09:13:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 25 Aug 2023 09:13:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Fri, 25 Aug 2023 09:13:09 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        =?utf-8?B?SWxnYXogw5ZjYWw=?= <ilgaz@ilgaz.gen.tr>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH] wifi: rtw88: usb: kill and free rx urbs on probe failure
Thread-Topic: [PATCH] wifi: rtw88: usb: kill and free rx urbs on probe failure
Thread-Index: AQHZ1ZZ+7pKENBdpH0qwssJUFHQO4q/6N1RQ
Date:   Fri, 25 Aug 2023 01:13:08 +0000
Message-ID: <8b4b4228bfd140119665417137a087ea@realtek.com>
References: <20230823075021.588596-1-s.hauer@pengutronix.de>
In-Reply-To: <20230823075021.588596-1-s.hauer@pengutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2FzY2hhIEhhdWVyIDxz
LmhhdWVyQHBlbmd1dHJvbml4LmRlPg0KPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAyMywgMjAy
MyAzOjUwIFBNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsu
Y29tPjsgS2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVsLm9yZz47IElsZ2F6DQo+IMOWY2FsIDxpbGdh
ekBpbGdhei5nZW4udHI+OyBrZXJuZWxAcGVuZ3V0cm9uaXguZGUNCj4gU3ViamVjdDogW1BBVENI
XSB3aWZpOiBydHc4ODogdXNiOiBraWxsIGFuZCBmcmVlIHJ4IHVyYnMgb24gcHJvYmUgZmFpbHVy
ZQ0KPiANCj4gQWZ0ZXIgcnR3X3VzYl9hbGxvY19yeF9idWZzKCkgaGFzIGJlZW4gY2FsbGVkIHJ4
IHVyYnMgaGF2ZSBiZWVuDQo+IGFsbG9jYXRlZCBhbmQgbXVzdCBiZSBmcmVlZCBpbiB0aGUgZXJy
b3IgcGF0aC4gQWZ0ZXIgcnR3X3VzYl9pbml0X3J4KCkNCj4gaGFzIGJlZW4gY2FsbGVkIHRoZXkg
YXJlIHN1Ym1pdHRlZCwgc28gdGhleSBhbHNvIG11c3QgYmUga2lsbGVkLg0KPiANCj4gQWRkIHRo
ZXNlIGZvcmdvdHRlbiBzdGVwcyB0byB0aGUgcHJvYmUgZXJyb3IgcGF0aC4NCj4gDQo+IEJlc2lk
ZXMgdGhlIGxvc3QgbWVtb3J5IHRoaXMgYWxzbyBmaXhlcyBhIHByb2JsZW0gd2hlbiB0aGUgZHJp
dmVyDQo+IGZhaWxzIHRvIGRvd25sb2FkIHRoZSBmaXJtd2FyZSBpbiBydHdfY2hpcF9pbmZvX3Nl
dHVwKCkuIEluIHRoaXMNCj4gY2FzZSBpdCBjYW4gaGFwcGVuIHRoYXQgdGhlIGNvbXBsZXRpb24g
b2YgdGhlIHJ4IHVyYnMgaGFuZGxlciBydW5zDQo+IGF0IGEgdGltZSB3aGVuIHdlIGFscmVhZHkg
ZnJlZWQgb3VyIGRhdGEgc3RydWN0dXJlcyByZXN1bHRpbmcgaW4NCj4gYSBrZXJuZWwgY3Jhc2gu
DQo+IA0KPiBmaXhlczogYTgyZGZkMzNkMTIzNyAoIndpZmk6IHJ0dzg4OiBBZGQgY29tbW9uIFVT
QiBjaGlwIHN1cHBvcnQiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBSZXBvcnRl
ZC1ieTogSWxnYXogw5ZjYWwgPGlsZ2F6QGlsZ2F6Lmdlbi50cj4NCj4gU2lnbmVkLW9mZi1ieTog
U2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPg0KDQpBY2tlZC1ieTogUGluZy1L
ZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCg==
