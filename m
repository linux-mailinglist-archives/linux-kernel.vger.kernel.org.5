Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD6781197F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjLMQbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjLMQbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:31:13 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D42B9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:31:19 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-94-TWjSCv__MdSZiOTVEJBuFQ-1; Wed, 13 Dec 2023 16:31:17 +0000
X-MC-Unique: TWjSCv__MdSZiOTVEJBuFQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 13 Dec
 2023 16:31:02 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 13 Dec 2023 16:31:02 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Chris Rankin' <rankincj@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: Does 6.5 kernel require different userspace to 6.4 kernel?
Thread-Topic: Does 6.5 kernel require different userspace to 6.4 kernel?
Thread-Index: AQHaK5wrGHrOo3OlFUyI8L4BB0O1KrCna98g
Date:   Wed, 13 Dec 2023 16:31:02 +0000
Message-ID: <8203b5a266964ca2a2238faf372a8229@AcuMS.aculab.com>
References: <CAK2bqVLVfBOGcj326grzz2b2PMcTmuj44a5yhWh1H1Z9ch3JCA@mail.gmail.com>
In-Reply-To: <CAK2bqVLVfBOGcj326grzz2b2PMcTmuj44a5yhWh1H1Z9ch3JCA@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQ2hyaXMgUmFua2luDQo+IFNlbnQ6IDEwIERlY2VtYmVyIDIwMjMgMTk6MDgNCj4gDQo+
IEkgaGF2ZSBhIHRydWx5IGFuY2llbnQgaTU4Ni9VUC8zMiBiaXQgUEMgKGZvciBoaXN0b3JpY2Fs
IHJlYXNvbnMpIHRoYXQNCj4gaGFwcGlseSBydW5zIExpbnV4IDYuNC4xNi4gSG93ZXZlciwgd2hl
biBJIHRyaWVkIHRvIHVwZ3JhZGUgaXQgdG9kYXkNCj4gdG8gcnVuIExpbnV4IDYuNS4xMywgSSBk
aXNjb3ZlcmVkIHRoYXQgYm90aCBpdHMgY29uc29sZSBhbmQgaXRzDQo+IG5ldHdvcmtpbmcgZnJv
emUgYWxtb3N0IGltbWVkaWF0ZWx5IGFmdGVyIGl0IGhhZCBib290ZWQuIFRoZXJlIGlzIG5vDQo+
IHNpZ24gb2YgYW55IG9vcHMgaW4gYW55IG9mIHRoZSBsb2dzLiBNeSBmaXJzdCB0aG91Z2h0IHdh
cyB0aGF0IG1lbW9yeQ0KPiBjb3JydXB0aW9uIGhhZCBjcmFzaGVkIHRoZSBrZXJuZWwsIGV4Y2Vw
dCB0aGF0IHRoZSBTeXNScSBpbnRlcmZhY2UNCj4gc3RpbGwgd29ya3MgY29ycmVjdGx5Lg0KDQpJ
ZiB5b3UgY2FuIHJ1biB3aXRoIGEgc2VyaWFsIGNvbnNvbGUgeW91IHNob3VsZCBiZSBhYmxlIHRv
DQpnZXQgYSB0cmFjZWJhY2sgb2YgYWxsIHRoZSBrZXJuZWwgc3RhY2tzLg0KVGhhdCBvdWdodCB0
byBiZSBpbmZvcm1hdGl2ZS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtl
c2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBV
Sw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

