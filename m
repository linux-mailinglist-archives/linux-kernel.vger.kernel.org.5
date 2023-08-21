Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C927825A6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbjHUIjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbjHUIjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:39:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B19DE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:39:00 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-219-jEAS19mCMs2MDf8c5jt4Eg-1; Mon, 21 Aug 2023 09:38:54 +0100
X-MC-Unique: jEAS19mCMs2MDf8c5jt4Eg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 21 Aug
 2023 09:38:43 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 21 Aug 2023 09:38:43 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alejandro Colomar' <alx@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: struct_size() using sizeof() vs offsetof()
Thread-Topic: struct_size() using sizeof() vs offsetof()
Thread-Index: AQHZ0ToJGRMQ8qLPnk+BhbrlQvigaK/0cK8g
Date:   Mon, 21 Aug 2023 08:38:43 +0000
Message-ID: <d3c4c953c9a742ae98ae9b9036561b38@AcuMS.aculab.com>
References: <74e8cf91-d095-33e3-c548-34d80b691089@kernel.org>
 <202308161913.91369D4A@keescook>
 <09b4a2ce-da74-3a19-6961-67883f634d98@kernel.org>
 <f12c6f14-66c4-6afb-e768-fa7abcfd1bbc@embeddedor.com>
 <df8fdd4a-490f-6b2a-03b6-0333e3302dce@kernel.org>
In-Reply-To: <df8fdd4a-490f-6b2a-03b6-0333e3302dce@kernel.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQWxlamFuZHJvIENvbG9tYXIgPGFseEBrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2Rh
eSwgQXVndXN0IDE3LCAyMDIzIDc6MzggUE0NCj4gDQo+IEhpIEd1c3Rhdm8sDQo+IA0KPiBPbiAy
MDIzLTA4LTE3IDE4OjA1LCBHdXN0YXZvIEEuIFIuIFNpbHZhIHdyb3RlOg0KPiA+DQo+ID4+IC0g
ICAgICAgICAgICAgICB0cF9jID0ga3phbGxvYyhzaXplb2YoKnRwX2MpLCBHRlBfS0VSTkVMKTsN
Cj4gPj4gKyAgICAgICAgICAgICAgIHRwX2MgPSBremFsbG9jKHN0cnVjdF9zaXplKHRwX2MsIGhs
aXN0LT5odCwgMSksIEdGUF9LRVJORUwpOw0KPiA+DQo+ID4gSSBqdXN0IHNlbnQgYSBmaXhbMV0u
DQo+ID4NCj4gPiBUaGFua3MgZm9yIHJlcG9ydGluZyB0aGlzISA6KQ0KDQpQZXJoYXBzIHN0cnVj
dF9zaXplKCkgc2hvdWxkIGluY2x1ZGUgYW4gYXNzZXJ0aW9uIHRoYXQ6DQoJKG9mZnNldG9mKHR5
cGUsIGZpZWxkWzhdKSA+IHNpemVvZiAodHlwZSkpDQpUaGF0IHdpbGwgZW5zdXJlIHRoYXQgZmll
bGQgaXMgYW4gYXJyYXkgbWVtYmVyIGFuZCByZWFzb25hYmx5DQpuZWFyIHRoZSBlbmQgb2YgdGhl
IHN0cnVjdHVyZS4NCg0KQSBtb3JlIGNvbXBsZXggY2FsY3VsYXRpb24gKHVzaW5nIF9BbGlnbm9m
KHR5cGUpIGFuZCB0aGUgb2Zmc2V0L3NpemUNCm9mIGZpZWxkKSBjb3VsZCBiZSB1c2VkLg0KQnV0
IEkgZG9uJ3QgdGhpbmsgeW91IGNhbiBhY3R1YWxseSBkZXRlY3QgaXQgaXMgZmllbGRbXSAob3Ig
ZXZlbiB0aGUNCmxhc3QgbWVtYmVyKS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVz
cyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEg
MVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

