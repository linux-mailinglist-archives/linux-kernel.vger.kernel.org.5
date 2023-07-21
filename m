Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58FC75CCE7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 17:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjGUP74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 11:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjGUP7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 11:59:48 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4101359D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 08:59:42 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-255-XYwML9_NPc6-LFPMycNl4g-1; Fri, 21 Jul 2023 16:59:40 +0100
X-MC-Unique: XYwML9_NPc6-LFPMycNl4g-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 21 Jul
 2023 16:59:39 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 21 Jul 2023 16:59:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joel Fernandes' <joel@joelfernandes.org>,
        Alan Huang <mmpgouride@gmail.com>
CC:     Eric Dumazet <edumazet@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>
Subject: RE: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
Thread-Topic: Question about the barrier() in hlist_nulls_for_each_entry_rcu()
Thread-Index: AQHZu+cDW9UBwZmf30GL9p6MGC4yBq/EWe3Q
Date:   Fri, 21 Jul 2023 15:59:38 +0000
Message-ID: <962bb2b940e64e7da7b71d11b307defc@AcuMS.aculab.com>
References: <E9CF24C7-3080-4720-B540-BAF03068336B@gmail.com>
 <1E0741E0-2BD9-4FA3-BA41-4E83315A10A8@joelfernandes.org>
 <1AF98387-B78C-4556-BE2E-E8F88ADACF8A@gmail.com>
 <cc9b292c-99b1-bec9-ba8e-9c202b5835cd@joelfernandes.org>
In-Reply-To: <cc9b292c-99b1-bec9-ba8e-9c202b5835cd@joelfernandes.org>
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Li4uLg0KPiBSaWdodCwgaXQgc2hvdWxkbid0IG5lZWQgdG8gY2FjaGUuIFRvIEVyaWMncyBwb2lu
dCBpdCBtaWdodCBiZSByaXNreSB0byByZW1vdmUNCj4gdGhlIGJhcnJpZXIoKSBhbmQgc29tZW9u
ZSBuZWVkcyB0byBleHBsYWluIHRoYXQgaXNzdWUgZmlyc3QgKG9yIElNTyB0aGVyZSBuZWVkcw0K
PiB0byBiZSBhbm90aGVyIHRhbmdpYmxlIHJlYXNvbiBsaWtlIHBlcmZvcm1hbmNlIGV0YykuIEFu
eXdheSwgRldJVyBJIHdyb3RlIGENCj4gc2ltcGxlIHByb2dyYW0gYW5kIEkgYW0gbm90IHNlZWlu
ZyB0aGUgaGVhZC0+Zmlyc3QgY2FjaGVkIHdpdGggdGhlIHBhdHRlcm4geW91DQo+IHNoYXJlZCBh
Ym92ZToNCj4gDQo+ICNpbmNsdWRlIDxzdGRsaWIuaD4NCj4gDQo+ICNkZWZpbmUgUkVBRF9PTkNF
KHgpICgqKHZvbGF0aWxlIHR5cGVvZih4KSAqKSYoeCkpDQo+ICNkZWZpbmUgYmFycmllcigpIF9f
YXNtX18gX192b2xhdGlsZV9fKCIiOiA6IDoibWVtb3J5IikNCj4gDQo+IHR5cGVkZWYgc3RydWN0
IGxpc3RfaGVhZCB7DQo+ICAgICAgaW50IGZpcnN0Ow0KPiAgICAgIHN0cnVjdCBsaXN0X2hlYWQg
Km5leHQ7DQo+IH0gbGlzdF9oZWFkOw0KPiANCj4gaW50IG1haW4oKSB7DQo+ICAgICAgbGlzdF9o
ZWFkICpoZWFkID0gKGxpc3RfaGVhZCAqKW1hbGxvYyhzaXplb2YobGlzdF9oZWFkKSk7DQo+ICAg
ICAgaGVhZC0+Zmlyc3QgPSAxOw0KPiAgICAgIGhlYWQtPm5leHQgPSAwOw0KPiANCj4gICAgICBS
RUFEX09OQ0UoaGVhZC0+Zmlyc3QpOw0KPiAgICAgIGJhcnJpZXIoKTsNCj4gICAgICBSRUFEX09O
Q0UoaGVhZC0+Zmlyc3QpOw0KPiANCj4gICAgICBmcmVlKGhlYWQpOw0KPiAgICAgIHJldHVybiAw
Ow0KPiB9DQoNCllvdSBwcm9iYWJseSBuZWVkIHRvIHRyeSBoYXJkZXIgdG8gZ2VuZXJhdGUgdGhl
IGVycm9yLg0KSXQgcHJvYmFibHkgaGFzIHNvbWV0aGluZyB0byBkbyBjb2RlIHN1cnJvdW5kaW5n
IHRoZQ0Kc2tfbnVsbHNfZm9yX2VhY2hfcmN1KCkgaW4gdGhlIGNhMDY1ZDBjXiB2ZXJzaW9uIG9m
IHVkcC5jLg0KDQpUaGF0IHBhdGNoIHJlbW92ZXMgdGhlIHJldHJ5IGxvb3AgLSBhbmQgcHJvYmFi
bHkgYnJlYWtzIHVkcCByZWNlaXZlLg0KVGhlIGlzc3VlIGlzIHRoYXQgc29ja2V0cyBjYW4gYmUg
bW92ZWQgYmV0d2VlbiB0aGUgJ2hhc2gyJyBjaGFpbnMNCihlZyBieSBjb25uZWN0KCkpIHdpdGhv
dXQgYmVpbmcgZnJlZWQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNp
ZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsN
ClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

