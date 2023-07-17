Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F35756453
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjGQNTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjGQNTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:19:07 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697EF26A5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:17:45 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-310-MKii5FwAMlKdoCNe_Twzww-1; Mon, 17 Jul 2023 14:17:35 +0100
X-MC-Unique: MKii5FwAMlKdoCNe_Twzww-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 17 Jul
 2023 14:17:34 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 17 Jul 2023 14:17:34 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     =?utf-8?B?J0phc29uLUpIIExpbiAo5p6X552/56WlKSc=?= 
        <Jason-JH.Lin@mediatek.com>,
        =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: RE: [PATCH v3 3/4] drm/mediatek: Add casting before assign
Thread-Topic: [PATCH v3 3/4] drm/mediatek: Add casting before assign
Thread-Index: AQHZpCpze4o/ajTsOEOlfRNPyXn/w6+45FuAgAAQ54CABSNGEA==
Date:   Mon, 17 Jul 2023 13:17:34 +0000
Message-ID: <df87b66cc9de4f4c8e3b555278533b0d@AcuMS.aculab.com>
References: <20230621102247.10116-1-jason-jh.lin@mediatek.com>
         <20230621102247.10116-4-jason-jh.lin@mediatek.com>
         <f8a838524f0ce324495fcf2994488d76768cae2f.camel@mediatek.com>
 <9d2e3526bd30e9f307eab32b67f487fa4ab102eb.camel@mediatek.com>
In-Reply-To: <9d2e3526bd30e9f307eab32b67f487fa4ab102eb.camel@mediatek.com>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSmFzb24tSkggTGluDQo+IFNlbnQ6IDE0IEp1bHkgMjAyMyAwNzo0Ng0KPiANCj4gSGkg
Q0ssDQo+IA0KPiBUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KPiANCj4gT24gRnJpLCAyMDIzLTA3
LTE0IGF0IDA1OjQ1ICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90ZToNCj4gPiBIaSwgSmFz
b246DQo+ID4NCj4gPiBPbiBXZWQsIDIwMjMtMDYtMjEgYXQgMTg6MjIgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gPiA+IDEuIEFkZCBjYXN0aW5nIGJlZm9yZSBhc3NpZ24gdG8gYXZvaWQg
dGhlIHVuaW50ZW50aW9uYWwgaW50ZWdlcg0KPiA+ID4gICAgb3ZlcmZsb3cgb3IgdW5pbnRlbmRl
ZCBzaWduIGV4dGVuc2lvbi4NCj4gPiA+IDIuIEFkZCBhIGludCB2YXJyaWFibGUgZm9yIG11bHRp
cGxpZXIgY2FsY3VsYXRpb24gaW5zdGVhZCBvZg0KPiA+ID4gY2FsY3VsYXRpbmcNCj4gPiA+ICAg
IGRpZmZlcmVudCB0eXBlcyBtdWx0aXBsaWVyIHdpdGggZG1hX2FkZHJfdCB2YXJyaWFibGUgZGly
ZWN0bHkuDQo+ID4NCj4gPiBJIGFncmVlIHdpdGggdGhlc2UgbW9kaWZpY2F0aW9uLCBidXQgdGhl
IHRpdGxlIGRvZXMgbm90IG1hdGNoIHRoZQ0KPiA+IG1vZGlmaWNhdGlvbi4NCj4gPg0KPiA+IFJl
Z2FyZHMsDQo+ID4gQ0sNCj4gDQo+IEknbGwgY2hhbmdlIHRoZSB0aXRsZSBhbmQgY29tbWl0IG1z
ZyBhdCB0aGUgbmV4dCB2ZXJzaW9uIGJlbG93Og0KPiANCj4gRml4IHVuaW50ZW50aW9uYWwgaW50
ZWdlciBvdmVyZmxvdyBpbiBtdWx0aXBseWluZyBkaWZmZXJlbnQgdHlwZXMNCj4gDQo+IDEuIElu
c3RlYWQgb2YgbXVsdGlwbHlpbmcgMiB2YXJpYWJsZSBvZiBkaWZmZXJlbnQgdHlwZXMuIENoYW5n
ZSB0bw0KPiBhc3NpZ24gYSB2YWx1ZSBvZiBvbmUgdmFyaWFibGUgYW5kIHRoZW4gbXVsdGlwbHkg
dGhlIG90aGVyIHZhcmlhYmxlLg0KPiANCj4gMi4gQWRkIGEgaW50IHZhcmlhYmxlIGZvciBtdWx0
aXBsaWVyIGNhbGN1bGF0aW9uIGluc3RlYWQgb2YgY2FsY3VsYXRpbmcNCj4gZGlmZmVyZW50IHR5
cGVzIG11bHRpcGxpZXIgd2l0aCBkbWFfYWRkcl90IHZhcmlhYmxlIGRpcmVjdGx5Lg0KDQpJJ20g
cHJldHR5IHN1cmUgdGhlIHBhdGNoIG1ha2VzIGFic29sdXRlbHkgbm8gZGlmZmVyZW5jZS4NCklu
IEMgYWxsIGFyaXRobWV0aWMgaXMgZG9uZSB3aXRoIGNoYXIvc2hvcnQgKGluYy4gdW5zaWduZWQp
DQpwcm9tb3RlZCB0byBpbnQuDQoNClNvIHRoZSBvbmx5IGxpa2VseSBvdmVyZmxvdyBpcyBpZiB0
aGUgdmFsdWVzIGV4Y2VlZCAyXjMxLg0KU2luY2UgdGhlIHRlbXBvcmFyaWVzIHlvdSBhcmUgdXNp
bmcgYXJlICdpbnQnIHRoaXMgaXNuJ3QgdHJ1ZS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQg
QWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVz
LCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

