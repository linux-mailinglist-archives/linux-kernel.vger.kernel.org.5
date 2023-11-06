Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B537E1940
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 04:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjKFDsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 22:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjKFDsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 22:48:54 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3745B8;
        Sun,  5 Nov 2023 19:48:51 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A63mb2xB3229165, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A63mb2xB3229165
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 11:48:37 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 6 Nov 2023 11:48:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 6 Nov 2023 11:48:38 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Mon, 6 Nov 2023 11:48:37 +0800
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
Thread-Index: AQHaDxyJZpnjRAISQ06Vkn+OQSkmobBsqcjg
Date:   Mon, 6 Nov 2023 03:48:37 +0000
Message-ID: <848aad6777f54fa88ebd4277642853aa@realtek.com>
References: <20231103164323.14294-1-johan+linaro@kernel.org>
 <ZUY8cGrofUtPOMV8@eichest-laptop>
In-Reply-To: <ZUY8cGrofUtPOMV8@eichest-laptop>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
x-kse-antivirus-attachment-filter-interceptor-info: license violation
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
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

DQo+IE9uIEZyaSwgTm92IDAzLCAyMDIzIGF0IDA1OjQzOjIzUE0gKzAxMDAsIEpvaGFuIEhvdm9s
ZCB3cm90ZToNCj4gPiBDb21taXRzIDdiOGVmMjJlYTU0NyAoInVzYjogeGhjaTogcGxhdDogQWRk
IFVTQiBwaHkgc3VwcG9ydCIpIGFuZA0KPiA+IDkxMzRjMWZkMDUwMyAoInVzYjogeGhjaTogcGxh
dDogQWRkIFVTQiAzLjAgcGh5IHN1cHBvcnQiKSBhZGRlZA0KPiA+IHN1cHBvcnQgZm9yIGxvb2tp
bmcgdXAgbGVnYWN5IFBIWXMgZnJvbSB0aGUgc3lzZGV2IGRldmljZXRyZWUgbm9kZSBhbmQNCj4g
PiBpbml0aWFsaXNpbmcgdGhlbS4NCj4gPg0KPiA+IFRoaXMgYnJva2UgZHJpdmVycyBzdWNoIGFz
IGR3YzMgd2hpY2ggbWFuYWdlcyBQSFlzIHRoZW1zZWxmIGFzIHRoZQ0KPiA+IFBIWXMgd291bGQg
bm93IGJlIGluaXRpYWxpc2VkIHR3aWNlLCBzb21ldGhpbmcgd2hpY2ggc3BlY2lmaWNhbGx5IGNh
bg0KPiA+IGxlYWQgdG8gcmVzb3VyY2VzIGJlaW5nIGxlZnQgZW5hYmxlZCBkdXJpbmcgc3VzcGVu
ZCAoZS5nLiB3aXRoIHRoZQ0KPiA+IHVzYl9waHlfZ2VuZXJpYyBQSFkgZHJpdmVyKS4NCj4gPg0K
PiA+IEFzIHRoZSBkd2MzIGRyaXZlciB1c2VzIGRyaXZlci1uYW1lIG1hdGNoaW5nIGZvciB0aGUg
eGhjaSBwbGF0Zm9ybQ0KPiA+IGRldmljZSwgZml4IHRoaXMgYnkgb25seSBsb29raW5nIHVwIGFu
ZCBpbml0aWFsaXNpbmcgUEhZcyBmb3IgZGV2aWNlcw0KPiA+IHRoYXQgaGF2ZSBiZWVuIG1hdGNo
ZWQgdXNpbmcgT0YuDQo+ID4NCj4gPiBOb3RlIHRoYXQgY2hlY2tpbmcgdGhhdCB0aGUgcGxhdGZv
cm0gZGV2aWNlIGhhcyBhIGRldmljZXRyZWUgbm9kZQ0KPiA+IHdvdWxkIGN1cnJlbnRseSBiZSBz
dWZmaWNpZW50LCBidXQgdGhhdCBjb3VsZCBsZWFkIHRvIHN1YnRsZSBicmVha2FnZXMNCj4gPiBp
biBjYXNlIGFueW9uZSBldmVyIHRyaWVzIHRvIHJldXNlIGFuIGFuY2VzdG9yJ3Mgbm9kZS4NCj4g
Pg0KPiA+IEZpeGVzOiA3YjhlZjIyZWE1NDcgKCJ1c2I6IHhoY2k6IHBsYXQ6IEFkZCBVU0IgcGh5
IHN1cHBvcnQiKQ0KPiA+IEZpeGVzOiA5MTM0YzFmZDA1MDMgKCJ1c2I6IHhoY2k6IHBsYXQ6IEFk
ZCBVU0IgMy4wIHBoeSBzdXBwb3J0IikNCj4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZyAg
ICAgICMgNC4xDQo+ID4gQ2M6IE1heGltZSBSaXBhcmQgPG1yaXBhcmRAa2VybmVsLm9yZz4NCj4g
PiBDYzogU3RhbmxleSBDaGFuZyA8c3RhbmxleV9jaGFuZ0ByZWFsdGVrLmNvbT4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBKb2hhbiBIb3ZvbGQgPGpvaGFuK2xpbmFyb0BrZXJuZWwub3JnPg0KPiANCj4g
VGVzdGVkLWJ5OiBTdGVmYW4gRWljaGVuYmVyZ2VyIDxzdGVmYW4uZWljaGVuYmVyZ2VyQHRvcmFk
ZXguY29tPg0KDQpUZXN0ZWQtYnk6IFN0YW5sZXkgQ2hhbmcgPHN0YW5sZXlfY2hhbmdAcmVhbHRl
ay5jb20+DQoNCg0K
