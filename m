Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33A77E1A83
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 07:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjKFGxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 01:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjKFGxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 01:53:41 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB69810B;
        Sun,  5 Nov 2023 22:53:37 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A66rNxN53324606, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A66rNxN53324606
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 14:53:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 6 Nov 2023 14:53:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 6 Nov 2023 14:53:23 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Mon, 6 Nov 2023 14:53:23 +0800
From:   =?big5?B?U3RhbmxleSBDaGFuZ1up96h8vHdd?= <stanley_chang@realtek.com>
To:     Stefan Eichenberger <eichest@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: RE: [PATCH] USB: xhci-plat: fix legacy PHY double inity
Thread-Topic: [PATCH] USB: xhci-plat: fix legacy PHY double inity
Thread-Index: AQHaDxyJZpnjRAISQ06Vkn+OQSkmobBsqcjggAAuZtA=
Date:   Mon, 6 Nov 2023 06:53:23 +0000
Message-ID: <5a493e6fedb449bc93f83f31a682e5b9@realtek.com>
References: <20231103164323.14294-1-johan+linaro@kernel.org>
 <ZUY8cGrofUtPOMV8@eichest-laptop> 
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9oYW4sDQoNCj4gPiBPbiBGcmksIE5vdiAwMywgMjAyMyBhdCAwNTo0MzoyM1BNICswMTAw
LCBKb2hhbiBIb3ZvbGQgd3JvdGU6DQo+ID4gPiBDb21taXRzIDdiOGVmMjJlYTU0NyAoInVzYjog
eGhjaTogcGxhdDogQWRkIFVTQiBwaHkgc3VwcG9ydCIpIGFuZA0KPiA+ID4gOTEzNGMxZmQwNTAz
ICgidXNiOiB4aGNpOiBwbGF0OiBBZGQgVVNCIDMuMCBwaHkgc3VwcG9ydCIpIGFkZGVkDQo+ID4g
PiBzdXBwb3J0IGZvciBsb29raW5nIHVwIGxlZ2FjeSBQSFlzIGZyb20gdGhlIHN5c2RldiBkZXZp
Y2V0cmVlIG5vZGUNCj4gPiA+IGFuZCBpbml0aWFsaXNpbmcgdGhlbS4NCj4gPiA+DQo+ID4gPiBU
aGlzIGJyb2tlIGRyaXZlcnMgc3VjaCBhcyBkd2MzIHdoaWNoIG1hbmFnZXMgUEhZcyB0aGVtc2Vs
ZiBhcyB0aGUNCj4gPiA+IFBIWXMgd291bGQgbm93IGJlIGluaXRpYWxpc2VkIHR3aWNlLCBzb21l
dGhpbmcgd2hpY2ggc3BlY2lmaWNhbGx5DQo+ID4gPiBjYW4gbGVhZCB0byByZXNvdXJjZXMgYmVp
bmcgbGVmdCBlbmFibGVkIGR1cmluZyBzdXNwZW5kIChlLmcuIHdpdGgNCj4gPiA+IHRoZSB1c2Jf
cGh5X2dlbmVyaWMgUEhZIGRyaXZlcikuDQo+ID4gPg0KPiA+ID4gQXMgdGhlIGR3YzMgZHJpdmVy
IHVzZXMgZHJpdmVyLW5hbWUgbWF0Y2hpbmcgZm9yIHRoZSB4aGNpIHBsYXRmb3JtDQo+ID4gPiBk
ZXZpY2UsIGZpeCB0aGlzIGJ5IG9ubHkgbG9va2luZyB1cCBhbmQgaW5pdGlhbGlzaW5nIFBIWXMg
Zm9yDQo+ID4gPiBkZXZpY2VzIHRoYXQgaGF2ZSBiZWVuIG1hdGNoZWQgdXNpbmcgT0YuDQo+ID4g
Pg0KPiA+ID4gTm90ZSB0aGF0IGNoZWNraW5nIHRoYXQgdGhlIHBsYXRmb3JtIGRldmljZSBoYXMg
YSBkZXZpY2V0cmVlIG5vZGUNCj4gPiA+IHdvdWxkIGN1cnJlbnRseSBiZSBzdWZmaWNpZW50LCBi
dXQgdGhhdCBjb3VsZCBsZWFkIHRvIHN1YnRsZQ0KPiA+ID4gYnJlYWthZ2VzIGluIGNhc2UgYW55
b25lIGV2ZXIgdHJpZXMgdG8gcmV1c2UgYW4gYW5jZXN0b3IncyBub2RlLg0KPiA+ID4NCj4gPiA+
IEZpeGVzOiA3YjhlZjIyZWE1NDcgKCJ1c2I6IHhoY2k6IHBsYXQ6IEFkZCBVU0IgcGh5IHN1cHBv
cnQiKQ0KPiA+ID4gRml4ZXM6IDkxMzRjMWZkMDUwMyAoInVzYjogeGhjaTogcGxhdDogQWRkIFVT
QiAzLjAgcGh5IHN1cHBvcnQiKQ0KPiA+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcgICAg
ICAjIDQuMQ0KPiA+ID4gQ2M6IE1heGltZSBSaXBhcmQgPG1yaXBhcmRAa2VybmVsLm9yZz4NCj4g
PiA+IENjOiBTdGFubGV5IENoYW5nIDxzdGFubGV5X2NoYW5nQHJlYWx0ZWsuY29tPg0KPiA+ID4g
U2lnbmVkLW9mZi1ieTogSm9oYW4gSG92b2xkIDxqb2hhbitsaW5hcm9Aa2VybmVsLm9yZz4NCj4g
Pg0KPiA+IFRlc3RlZC1ieTogU3RlZmFuIEVpY2hlbmJlcmdlciA8c3RlZmFuLmVpY2hlbmJlcmdl
ckB0b3JhZGV4LmNvbT4NCj4gDQo+IFRlc3RlZC1ieTogU3RhbmxleSBDaGFuZyA8c3RhbmxleV9j
aGFuZ0ByZWFsdGVrLmNvbT4NCj4gDQoNCkkgYW0gc29ycnkgdG8gbm90aWZ5IHlvdSB0aGlzIHBh
dGNoIGlzIHRlc3RlZCBmYWlsLg0KSSB0ZXN0IHRoZSBSZWFsdGVrIHBoeSBkcml2ZXIgYXQgZHJp
dmVycy9waHkvUmVhbHRlay9waHktcnRrLXVzYjIuYyBhZ2Fpbi4NCkJ1dCBJIGNhbid0IGdldCB0
aGUgcGh5IGluIHhoY2kuDQpJdCBpcyBhIGR3YzMgZ2VuZXJpYyBwaHkgZHJpdmVyLCBhbmQgaXQg
aXMgYWxzbyBhIHVzYiBwaHkgZHJpdmVyLiANCg0KQmFzZSBvbiB5b3UgbW9kaWZpZWQsIEkgY2Fu
J3QgcnVuIG9uIGNhbGxiYWNrIA0KcnRrX3BoeS0+cGh5Lm5vdGlmeV9wb3J0X3N0YXR1cyA9IHJ0
a19waHlfbm90aWZ5X3BvcnRfc3RhdHVzOw0KVGhhbmtzLA0KU3RhbmxleS4NCg0K
