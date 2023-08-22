Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F53783974
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 07:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjHVFrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 01:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjHVFrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 01:47:13 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4C68133;
        Mon, 21 Aug 2023 22:47:10 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37M5kWoaD025861, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37M5kWoaD025861
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Aug 2023 13:46:32 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 22 Aug 2023 13:46:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 22 Aug 2023 13:46:53 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 22 Aug 2023 13:46:53 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     Sergey Korolev <korolev.sergey@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: kernel warns about voluntary context switch within RCU critical section in rtw88_usb
Thread-Topic: PROBLEM: kernel warns about voluntary context switch within RCU
 critical section in rtw88_usb
Thread-Index: AQHZ1Du6L7NM3D3q6kaezl/cutgsbq/1i5bggABCY6yAAACHgA==
Date:   Tue, 22 Aug 2023 05:46:53 +0000
Message-ID: <cf3ca98d6c18482eb63e3713f67e44e6@realtek.com>
References: <CA+QjRnJ+YMdOM0OzwG+Pz8-mTPo5nZVioCjbz1xY0jVSGXBk7w@mail.gmail.com>
        <bfaa8714467a4954a045475e062f78b1@realtek.com> <87pm3fws4m.fsf@kernel.org>
In-Reply-To: <87pm3fws4m.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2FsbGUgVmFsbyA8a3Zh
bG9Aa2VybmVsLm9yZz4NCj4gU2VudDogVHVlc2RheSwgQXVndXN0IDIyLCAyMDIzIDE6NDIgUE0N
Cj4gVG86IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBDYzogU2VyZ2V5IEtv
cm9sZXYgPGtvcm9sZXYuc2VyZ2V5QGdtYWlsLmNvbT47IGxpbnV4LXdpcmVsZXNzQHZnZXIua2Vy
bmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
UFJPQkxFTToga2VybmVsIHdhcm5zIGFib3V0IHZvbHVudGFyeSBjb250ZXh0IHN3aXRjaCB3aXRo
aW4gUkNVIGNyaXRpY2FsIHNlY3Rpb24gaW4gcnR3ODhfdXNiDQo+IA0KPiBQaW5nLUtlIFNoaWgg
PHBrc2hpaEByZWFsdGVrLmNvbT4gd3JpdGVzOg0KPiANCj4gPiBGcm9tOiBTZXJnZXkgS29yb2xl
diA8a29yb2xldi5zZXJnZXlAZ21haWwuY29tPg0KPiA+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDIx
LCAyMDIzIDEwOjI4IFBNDQo+ID4gVG86IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29t
PjsgS2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVsLm9yZz47IGxpbnV4LXdpcmVsZXNzQHZnZXIua2Vy
bmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+IFN1YmplY3Q6IFBS
T0JMRU06IGtlcm5lbCB3YXJucyBhYm91dCB2b2x1bnRhcnkgY29udGV4dCBzd2l0Y2ggd2l0aGlu
IFJDVSBjcml0aWNhbCBzZWN0aW9uIGluIHJ0dzg4X3VzYg0KPiA+Pg0KPiA+PiBQbGVhc2Ugbm90
ZSBJIHVzZSBhbiB1bm1vZGlmaWVkIGRyaXZlciBmcm9tIHRoZSB1cHN0cmVhbSAyOGMxMWMyOTQ5
NGYxYjM0ZTM5NjQxZWVhZDljNjBhOGJkMjYxNzBkDQo+ID4+ICgid2lmaTogcnR3ODg6IGZpeCBu
b3QgZW50ZXJpbmcgUFMgbW9kZSBhZnRlciBBUCBzdG9wcyIpIGJ1aWxkIGZvciA2LjIga2VybmVs
IChVYnVudHUgMjMuMDQpLg0KPiA+DQo+ID4gSSBmZWVsIE1hcnRpbiBoYXMgYmVlbiBhZGRyZXNz
ZWQgdGhpcyBwcm9ibGVtIGR1cmluZyBkZXZlbG9wbWVudCBvZiBTRElPIGFuZCBVU0INCj4gPiBi
eSA4YTFlMmZkOGUyZGEgKCJ3aWZpOiBydHc4ODogTW92ZSByZWdpc3RlciBhY2Nlc3MgZnJvbSBy
dHdfYmZfYXNzb2MoKSBvdXRzaWRlIHRoZSBSQ1UiKQ0KPiA+IFBsZWFzZSB0YWtlIGEgbG9vayBp
ZiB0aGlzIHBhdGNoIGlzIGV4aXN0aW5nIGluIHlvdXIgc291cmNlLg0KPiANCj4gQ29tbWl0IDhh
MWUyZmQ4ZTJkYSB3YXMgbWVyZ2VkIHRvIHY2LjMtcmMxIHNvIHY2LjIgd29uJ3QgaGF2ZSBpdC4N
Cj4gDQoNClNlcmdleSBzYWlkIGhlIHVzZXMgZHJpdmVyIGZyb20gMjhjMTFjMjk0OTRmIHRoYXQg
aXMgdjYuNC1yYzUgb3IgdjYuNSwgc28NCnNlZW1pbmdseSBpdCBzaG91bGQgaW5jbHVkZSBNYXJ0
aW4ncyBwYXRjaC4gTm90IHN1cmUgd2hhdCBpcyB3cm9uZy4NCg0KUGluZy1LZQ0KDQo=
