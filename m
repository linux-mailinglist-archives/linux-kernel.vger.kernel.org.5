Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D66F786B1B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240543AbjHXJFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240643AbjHXJFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:05:34 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDA21994
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 02:05:32 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-33-YnruvqDKO-W6zw-UTGc5mg-1; Thu, 24 Aug 2023 10:05:30 +0100
X-MC-Unique: YnruvqDKO-W6zw-UTGc5mg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 24 Aug
 2023 10:05:28 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 24 Aug 2023 10:05:28 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: RE: [PATCH next v3 0/5] minmax: Relax type checks in min() and max().
Thread-Topic: [PATCH next v3 0/5] minmax: Relax type checks in min() and
 max().
Thread-Index: AdnGwQ6IGYkn0IjZSjuTaOSyeQI0UwIK8m4AABl1+KABQGc+AAAmLwYwADhjV4AAJn/WkA==
Date:   Thu, 24 Aug 2023 09:05:28 +0000
Message-ID: <bcf2fcad28c048058c808ec9e749da80@AcuMS.aculab.com>
References: <01e3e09005e9434b8f558a893a47c053@AcuMS.aculab.com>
 <202308141416.89AC5C2@keescook>
 <2dd09c4033644239a314247e635fa735@AcuMS.aculab.com>
 <202308211113.4F49E73109@keescook>
 <acf8a7389d1f47a5ac55390b7ea76692@AcuMS.aculab.com>
 <CAHk-=wh1SFzTM1nWwC30t55jzZradQmJ4942CDD1pM_umhU_Vw@mail.gmail.com>
In-Reply-To: <CAHk-=wh1SFzTM1nWwC30t55jzZradQmJ4942CDD1pM_umhU_Vw@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMjMsIDIwMjMg
NDozMiBQTQ0KLi4uDQo+IFRoYXQgbWlnaHQgZ2V0IHJpZCBvZiBhIG51bWJlciBvZiB0aGUgbW9y
ZSBhbm5veWluZyBjYXNlcy4NCg0KVGhlIG9uZSBpdCBsZWF2ZXMgaXMgY29kZSBsaWtlOg0KDQoJ
aW50IGxlbmd0aCA9IGdldF9sZW5ndGgoLi4uKTsNCglpZiAobGVuZ3RoIDw9IDApDQoJCXJldHVy
biBlcnJvcjoNCglkbyB7DQoJCWZyYWdfbGVuID0gc29tZV9taW5fZnVuY3Rpb24obGVuZ3RoLCBQ
QUdFX1NJWkUpOw0KCQkuLi4NCgl9IHdoaWxlICgobGVuZ3RoIC09IGZyYWdfbGVuKSAhPSAwKTsN
Cg0KQXMgd3JpdHRlbiBpdCBpcyBvayBmb3IgYWxsIHJlYXNvbmFibGUgc29tZV9taW5fZnVuY3Rp
b24oKS4NCg0KQnV0IGlmIHRoZSAobGVuZ3RoIDw9IDApIHRlc3QgaXMgbWlzc2luZyBpdCByZWFs
bHkgZG9lc24ndA0KbWF0dGVyIHdoYXQgc29tZV9taW5fZnVuY3Rpb24oKSByZXR1cm5zIGJlY2F1
c2UgdGhlIGNvZGUNCmlzbid0IGdvaW5nIHRvIGRvIGFueXRoaW5nIHNlbnNpYmxlIC0gYW5kIG1h
eSBqdXN0IGxvb3AuDQoNCkFib3V0IHRoZSBvbmx5IHRoaW5nIHlvdSBjb3VsZCBkbyBpcyBhZGQg
YSBydW4tdGltZSBjaGVjaw0KYW5kIHRoZW4gQlVHKCkgaWYgbmVnYXRpdmUuDQpCdXQgdGhhdCBp
cyBob3JyaWQuLi4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

