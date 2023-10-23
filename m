Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94C47D3A1C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233343AbjJWO5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjJWO5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:57:49 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3D99C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:57:46 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-308-3pLvqLSeP_udmDxl4FG2aQ-1; Mon, 23 Oct 2023 15:57:44 +0100
X-MC-Unique: 3pLvqLSeP_udmDxl4FG2aQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 23 Oct
 2023 15:57:43 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 23 Oct 2023 15:57:43 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Heiner Kallweit' <hkallweit1@gmail.com>,
        "Jia, Fang" <fang.jia@windriver.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: phy: fixed link 1000 or 100 set with autoneg off
Thread-Topic: phy: fixed link 1000 or 100 set with autoneg off
Thread-Index: AQHaBYXegqY/W6MRuUap0Hi2E4wGs7BXdZJA
Date:   Mon, 23 Oct 2023 14:57:43 +0000
Message-ID: <1fc7704bfd664746bf93c65591efa071@AcuMS.aculab.com>
References: <d7aa45f8-adf8-ff9a-b2c4-04b0f2cc3c06@windriver.com>
 <c23dcdb0-f493-453d-82b9-b498f4d3c88b@gmail.com>
In-Reply-To: <c23dcdb0-f493-453d-82b9-b498f4d3c88b@gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSGVpbmVyIEthbGx3ZWl0DQo+IFNlbnQ6IDIzIE9jdG9iZXIgMjAyMyAwODo1Mg0KPiAN
Cj4gT24gMjMuMTAuMjAyMyAwOTowMSwgSmlhLCBGYW5nIHdyb3RlOg0KPiA+IEhpIEV4cGVydHMs
DQo+ID4NCj4gPiBXZSB1c2UgTlhQIExTMTA0NiBib2FyZCBhbmQgZmFjZSBhbiBpc3N1ZSBhYm91
dCB0aGUgZXRoIGludGVyZmFjZSBzcGVlZC4NCj4gPg0KPiA+IDEpIFNjZW5hcmlvDQo+ID4NCj4g
PiB3ZSBzZXQgZml4ZWQgbGluayAxMDAwTWIvcyBpbiBkZXZpY2UgdHJlZS4NCj4gPg0KPiA+IEhv
d2V2ZXIsIGFmdGVyIHdlIHNldCB0aGUgYXV0by1uZWcgb2ZmLCB0aGVuIHRoZSBldGgxJ3Mgc3Bl
ZWQgY2hhbmdlZCB0byAxME0gYW5kIER1cGxleCBjaGFuZ2VkIHRvIEhhbGYuDQo+ID4gVGhlIHZh
bHVlIG9mIC9zeXMvY2xhc3MvbmV0L2V0aDEvc3BlZWQgaXMgMTAgYW5kIC9zeXMvY2xhc3MvbmV0
L2V0aDEvZHVwbGV4IGlzIGhhbGYNCj4gPg0KPiBXaHkgZG8geW91IHNldCBhbmVnIHRvIG9mZj8g
TGVhdmUgYW5lZyBvbiwgdGhhdCdzIHRoZSBvbmx5IHN1cHBvcnRlZA0KPiBtb2RlIGluIHN3cGh5
LiAxMDAwTWJwcyByZXF1aXJlcyBhbmVnIGFueXdheSBwZXIgc3RhbmRhcmQuDQoNCkxpbWl0aW5n
IHRoZSBhZHZlcnRpc2VkIG1vZGVzIGhhcyBhbHdheXMgd29ya2VkIGJldHRlciB0aGFuDQp0cnlp
bmcgdG8gc2V0IGEgZml4ZWQgbW9kZS4NCkFsdGhvdWdoIGNvbm5lY3QgdG8gYSAxME0gaHViICh0
aGF0IHNlbmRzIG91dCBzaW5nbGUgbGluayB0ZXN0IHB1bHNlcykNCmFuZCB5b3UnbGwgZW5kIHVw
IDEwTS9IRFggcmVnYXJkbGVzcyBvZiB0aGUgQU5BUiByZWdpc3Rlci4gDQoNCk5vdCBsZWFzdCBv
ZiB0aGUgcHJvYmxlbXMgaXMgdGhhdCB5b3UgbmVlZCB0byBnZXQgdGhlIGZhciBlbmQNCnRvIHVz
ZSBleGFjdGx5IHRoZSBzYW1lIG1vZGUuDQoNCk90aGVyd2lzZSBpdCBpcyB2ZXJ5IGVhc3kgdG8g
Z2V0IGEgbWlzbWF0Y2guDQpJbiB0aGUgJ29sZCBkYXlzJyBhIEhEWC9GRFggbWlzbWF0Y2ggd2Fz
IGVhc3kgdG8gZ2V0IGFuZCB2ZXJ5IGNvbmZ1c2luZy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVy
ZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5
bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

