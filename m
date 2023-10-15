Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA1A7C9872
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 11:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjJOJRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 05:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjJOJRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 05:17:00 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4649CD8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 02:16:58 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-180-Twob8sPuO7K597X-Wl0xZw-1; Sun, 15 Oct 2023 10:16:55 +0100
X-MC-Unique: Twob8sPuO7K597X-Wl0xZw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 15 Oct
 2023 10:16:54 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 15 Oct 2023 10:16:54 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexey Dobriyan' <adobriyan@gmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: RE: [PATCH] fs: move and constify sysctl_nr_open_min,
 sysctl_nr_open_max
Thread-Topic: [PATCH] fs: move and constify sysctl_nr_open_min,
 sysctl_nr_open_max
Thread-Index: AQHZ/HAt7Icw5TmRtk6309iepUgEDbBGK5FQgALK0wCAAaDLoA==
Date:   Sun, 15 Oct 2023 09:16:54 +0000
Message-ID: <42f1dc15162141acb5931bb628c56866@AcuMS.aculab.com>
References: <02591c1e-936b-46bf-ad2b-402b33338eee@p183>
 <9b23bb6bcabe4f419cb8510e99275085@AcuMS.aculab.com>
 <261b7728-a9f3-4ceb-8325-b8ad1fae993c@p183>
In-Reply-To: <261b7728-a9f3-4ceb-8325-b8ad1fae993c@p183>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQWxleGV5IERvYnJpeWFuDQo+IFNlbnQ6IDE0IE9jdG9iZXIgMjAyMyAxMDoyMw0KPiAN
Cj4gT24gVGh1LCBPY3QgMTIsIDIwMjMgYXQgMDE6NTQ6MDZQTSArMDAwMCwgRGF2aWQgTGFpZ2h0
IHdyb3RlOg0KPiA+IEZyb206IEFsZXhleSBEb2JyaXlhbg0KPiA+ID4gU2VudDogMTEgT2N0b2Jl
ciAyMDIzIDE5OjI0DQo+IA0KPiA+ID4gKy8qIG91ciBtaW4oKSBpcyB1bnVzYWJsZSBpbiBjb25z
dGFudCBleHByZXNzaW9ucyA7LS8gKi8NCj4gPiA+ICsjZGVmaW5lIF9fY29uc3RfbWluKHgsIHkp
ICgoeCkgPCAoeSkgPyAoeCkgOiAoeSkpDQo+ID4gPiArc3RhdGljIGNvbnN0IHVuc2lnbmVkIGlu
dCBzeXNjdGxfbnJfb3Blbl9tYXggPQ0KPiA+ID4gKwlfX2NvbnN0X21pbihJTlRfTUFYLCB+KHNp
emVfdCkwL3NpemVvZih2b2lkICopKSAmIC1CSVRTX1BFUl9MT05HOw0KPiA+DQo+ID4gSSB0aGlu
ayB5b3UnbGwgZmluZCB0aGF0IG1pbigpIGlzIGZpbmUuDQo+IA0KPiBNYWlubGluZSBtaW4oKSBz
dGlsbCBjYW4ndCBkbw0KPiANCj4gCXN0YXRpYyBjb25zdCB4ID0gbWluKDEsIDIpOw0KDQpUaGVy
ZSBoYXMgYmVlbiBhIHdob2xlIGxvYWQgb2Ygc3R1ZmYgdGhhdCBpcyBzdXBwb3NlZCB0byBkbyB0
aGF0DQpmb3IgYWdlcyAtIG15IGNoYW5nZXMgZG9uJ3QgYWZmZWN0IGl0Lg0KDQpJIHByZXN1bWUg
dGhleSB3b3JrIC0gYmVjYXVzZSB0aGV5IG1ha2UgaXQgaG9ycmlibHkgY29tcGxpY2F0ZWQuDQoN
CglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwg
TW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzog
MTM5NzM4NiAoV2FsZXMpDQo=

