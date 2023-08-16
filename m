Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B6677DD32
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243336AbjHPJVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243292AbjHPJVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:21:04 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4E91BF8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:21:02 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-7-tOIxv-NvMECBkHxU2QaG3g-1; Wed, 16 Aug 2023 10:20:00 +0100
X-MC-Unique: tOIxv-NvMECBkHxU2QaG3g-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 16 Aug
 2023 10:18:03 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 16 Aug 2023 10:18:03 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jiri Slaby' <jirislaby@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>
Subject: RE: [PATCH 34/36] tty: gdm724x: convert counts to size_t
Thread-Topic: [PATCH 34/36] tty: gdm724x: convert counts to size_t
Thread-Index: AQHZ0A2Smc/5XT+NnUuSfmLwyiVGwq/smYqg///1V4CAABGqoA==
Date:   Wed, 16 Aug 2023 09:18:03 +0000
Message-ID: <9c4a831ae5284aec887ea60d4dda2b8c@AcuMS.aculab.com>
References: <20230810091510.13006-1-jirislaby@kernel.org>
 <20230810091510.13006-35-jirislaby@kernel.org>
 <20230815172247.GA1690054@dev-arch.thelio-3990X>
 <937e14c1-d884-0b6e-595a-e8aaa3d09025@kernel.org>
 <bdbdfdaad3a842d2837ac9d15ef2ab25@AcuMS.aculab.com>
 <00de3273-9433-138d-b659-826457e6a008@kernel.org>
In-Reply-To: <00de3273-9433-138d-b659-826457e6a008@kernel.org>
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

RnJvbTogSmlyaSBTbGFieQ0KPiBTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAxNiwgMjAyMyA5OjU5
IEFNDQouLi4NCj4gPiAnVm90ZSB1cCcgbXkgcGF0Y2hlcyB0byBtaW5tYXguaCB0aGF0IG1ha2Ug
dGhpcyBhbGwgd29yay4NCj4gPiBUaGVuIGl0IHdvbid0IGNhcmUgcHJvdmlkZWQgYm90aCB2YWx1
ZXMgaGF2ZSB0aGUgc2FtZSBzaWduZWRuZXNzLg0KPiA+IChvciwgd2l0aCBwYXRjaCA1LCBhcmUg
bm9uLW5lZ2F0aXZlIDMxYml0IGNvbXBpbGUgdGltZSBjb25zdGFudHMuKQ0KPiANCj4gT2ggeWVh
aCwgdGhhdCBbMV0gbG9va3MgZ3JlYXQuIFdoeSBzaG91bGQgb25lIGNhcmUgaW4gbWluKDQwOTYs
DQo+IHNpemVvZigpKSBhZnRlciBhbGzigKYNCj4gDQo+IFNvIHdoYXQncyB0aGUgY3VycmVudCBz
dGF0dXMgb2YgdGhvc2U/DQoNCldhaXRpbmcuLi4gOi0oDQoNClRoZSBvbmx5IGNvbW1lbnQgaXMg
ZnJvbSBMaW51cyB3aG8gcmVhbGx5IGRvZXNuJ3QgbGlrZSB0aGUgaWRlYQ0KdGhhdCBtaW4oc2ln
bmVkX3ZhciwgNHUpIHNob3VsZCBiZSB0aGUgc2FtZSBhcyBtaW4oc2lnbmVkX3ZhciwgNCkuDQpJ
IHRoaW5rIGhlIGlzIG9rIHdpdGggbWluKHVuc2lnbmVkX3ZhciwgNCkgdGhvdWdoLg0KDQpUaGUg
bWluX3QodTE2LC4uLikgSSBxdW90ZWQgZnJvbSB0aGUgY29uc29sZSBidWZmZXIgY29kZSBpcw0K
YSByZWFsIGJ1ZyB0aGF0IHdhcyBpZGVudGlmaWVkIGJ5IHNvbWVvbmUgZWxzZSBsYXN0IHdlZWsu
DQoNClJlYWxseSBtaW5fdCgpIGlzIGp1c3QgYW4gYWNjaWRlbnQgd2FpdGluZyB0byBoYXBwZW4u
DQoNCglEYXZpZA0KDQo+IA0KPiBbMV0NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2I0
Y2U5ZGFkNzQ4ZTQ4OWY5MzE0YTJkYzk1NjE1MDMzQEFjdU1TLmFjdWxhYi5jb20vDQo+IA0KPiB0
aGFua3MsDQo+IC0tDQo+IGpzDQo+IHN1c2UgbGFicw0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3Mg
TGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQ
VCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

