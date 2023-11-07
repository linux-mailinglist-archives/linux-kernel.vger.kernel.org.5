Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F607E361D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjKGHzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 02:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKGHzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 02:55:22 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8552DED;
        Mon,  6 Nov 2023 23:55:17 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A77sj7W34057066, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3A77sj7W34057066
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Nov 2023 15:54:45 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 7 Nov 2023 15:54:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 7 Nov 2023 15:54:45 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Tue, 7 Nov 2023 15:54:45 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: RE: [PATCH 0/3] Revert "usb: phy: add usb phy notify port status API"
Thread-Topic: [PATCH 0/3] Revert "usb: phy: add usb phy notify port status
 API"
Thread-Index: AQHaEKFYYUMOc04m8UWBbMSA7W5TDrBsnd2AgAACc4CAAcfbIP//gVOAgACUP4A=
Date:   Tue, 7 Nov 2023 07:54:45 +0000
Message-ID: <52875bf017ae4b8f841caf91b08fb315@realtek.com>
References: <20231106110654.31090-1-johan+linaro@kernel.org>
 <2023110623-pointing-stump-643d@gregkh> <ZUjM/VEliT5c8H4C@matsya>
 <28e77cbc531248bf913ceedba6425cf6@realtek.com>
 <2023110713-morphine-mortuary-337e@gregkh>
In-Reply-To: <2023110713-morphine-mortuary-337e@gregkh>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.190.159]
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

SGkgR3JlZywNCg0KPiBPbiBUdWUsIE5vdiAwNywgMjAyMyBhdCAwNjo0NDoyNkFNICswMDAwLCBT
dGFubGV5IENoYW5nW+aYjOiCsuW+t10gd3JvdGU6DQo+ID4gSGkgSm9oYW4gYW5kIFZpbm9kLA0K
PiA+DQo+ID4gSSBtb2RpZmllZCB0aGUgUmVhbHRlayBwaHkgdG8gc29sdmUgdGhpcyBpc3N1ZSBh
bmQgb25seSB1c2UgdGhlIGdlbmVyaWMgUEhZLg0KPiA+IEFuZCBzdWJtaXR0ZWQgdGhlc2UgcGF0
Y2hlcyB0b2RheSBhcyBmb2xsb3dzDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
dXNiLzIwMjMxMTA3MDYzNTE4LjI3ODI0LTEtc3RhbmxleV9jaGFuZw0KPiA+IEByZWFsdGVrLmNv
bS8NCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC11c2IvMjAyMzExMDcwNjM1MTgu
Mjc4MjQtMi1zdGFubGV5X2NoYW5nDQo+ID4gQHJlYWx0ZWsuY29tLw0KPiA+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LXVzYi8yMDIzMTEwNzA2MzUxOC4yNzgyNC0zLXN0YW5sZXlfY2hh
bmcNCj4gPiBAcmVhbHRlay5jb20vDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
dXNiLzIwMjMxMTA3MDYzNTE4LjI3ODI0LTQtc3RhbmxleV9jaGFuZw0KPiA+IEByZWFsdGVrLmNv
bS8NCj4gPg0KPiA+IEkgZG9uJ3QgdGhpbmsgdGhpcyBwYXRjaCBpcyBuZWVkZWQgdG8gcmV2ZXJ0
IGEwODc5OWNmMTdjMiAoInVzYjpwaHk6IE5ldyB1c2INCj4gcGh5IG5vdGlmaWNhdGlvbiBwb3J0
IHN0YXR1cyBBUEkiKS4NCj4gDQo+IEkgaGFkIGFscmVhZHkgYXBwbGllZCB0aG9zZSByZXZlcnRz
IHllc3RlcmRheSwgYnV0IGZvcmdvdCB0byBwdXNoIHRoZW0gb3V0DQo+IChzb3JyeSBhYm91dCB0
aGF0LCBub3cgZml4ZWQuKSAgTGV0J3Mgc3RhcnQgb3ZlciBoZXJlIGFuZCB5b3UgY2FuIHJlYmFz
ZSB5b3VyDQo+IG5ldyBzZXJpZXMgb24gdGhlIDYuNy1yYzEuDQoNCk9rYXksIEkgd2lsbCByZXN1
Ym1pdCBsYXRlci4NCg0KVGhhbmtzLA0KU3RhbmxleQ0KDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcg
ay1oDQo=
