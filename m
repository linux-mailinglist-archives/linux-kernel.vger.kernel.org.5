Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EC57EE59A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 17:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343972AbjKPQ6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 11:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjKPQ6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 11:58:45 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D43D49
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 08:58:41 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-195-esXLCCycM-uD2bJcbv0YGQ-1; Thu, 16 Nov 2023 16:58:39 +0000
X-MC-Unique: esXLCCycM-uD2bJcbv0YGQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 16 Nov
 2023 16:58:44 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 16 Nov 2023 16:58:44 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>
CC:     David Howells <dhowells@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "fengwei.yin@intel.com" <fengwei.yin@intel.com>
Subject: RE: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
Thread-Topic: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
Thread-Index: AQHaGKyzFfqMOen5JUCwmbDFX2u0nbB9KiKw
Date:   Thu, 16 Nov 2023 16:58:44 +0000
Message-ID: <ef760f3b926747598051c848ba85c4a8@AcuMS.aculab.com>
References: <202311061616.cd495695-oliver.sang@intel.com>
 <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
 <20231115190938.GGZVUXcuUjI3i1JRAB@fat_crate.local>
 <CAHk-=wh0TcXyGmKHfs+Xe=5Sd5bNn=NNV9CEtOy_tbyHAAmk9g@mail.gmail.com>
 <20231116154406.GDZVY4xmFvRQt0wGGE@fat_crate.local>
 <CAHk-=wjGQh3ucZFmFR0evbKu2OyEuue-bOjsrnCvxSQdj8x6aw@mail.gmail.com>
In-Reply-To: <CAHk-=wjGQh3ucZFmFR0evbKu2OyEuue-bOjsrnCvxSQdj8x6aw@mail.gmail.com>
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

Li4uDQo+IE9mIGNvdXJzZSwgaXQncyBhbHNvIHBvc3NpYmxlIHRoYXQgd2l0aCBhbGwgdGhlIGZ1
bmN0aW9uIGNhbGwgb3ZlcmhlYWQNCj4gaW50cm9kdWNlZCBieSB0aGUgQ1BVIG1pdGlnYXRpb25z
IG9uIG9sZGVyIENQVSdzLCB3ZSBzaG91bGQganVzdCBzYXkNCj4gInJlcCBtb3ZzYiIgaXMgYWx3
YXlzIGNvcnJlY3QgLSBpZiB5b3UgaGF2ZSBhIG5ldyBDUFUgd2l0aCBGU1JNIGl0J3MNCj4gZ29v
ZCwgYW5kIGlmIHlvdSBoYXZlIGFuIG9sZCBDUFUgaXQncyBubyB3b3JzZSB0aGFuIHRoZSBob3Jy
ZW5kb3VzIENQVQ0KPiBtaXRpZ2F0aW9uIG92ZXJoZWFkIGZvciBmdW5jdGlvbiBjYWxsL3JldHVy
bnMuDQoNClVubGVzcyB5b3UgYXJlIHN0dXBpZCBlbm91Z2ggdG8gdXNlIGEgUDQgOi0pDQoNCkkg
YWN0dWFsbHkgZG91YnQgYW55b25lIGNhcmVzIChlc3AuIGZvciA2NGJpdCkgYWJvdXQgYW55DQpj
cHUgdGhhdCBkb24ndCBvcHRpbWlzZSBsb25nICdyZXAgbW92c2InIChwcmUgc2FuZHkgYnJpZGdl
KS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBS
b2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9u
IE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

