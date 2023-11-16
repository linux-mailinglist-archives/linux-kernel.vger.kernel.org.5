Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5CC7EE596
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 17:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345332AbjKPQ4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 11:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjKPQ4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 11:56:01 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C0C19D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 08:55:58 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-83-dfelu8lQMMeuj6lgW5XekA-1; Thu, 16 Nov 2023 16:55:49 +0000
X-MC-Unique: dfelu8lQMMeuj6lgW5XekA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 16 Nov
 2023 16:55:33 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 16 Nov 2023 16:55:33 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>
CC:     Borislav Petkov <bp@alien8.de>,
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
Thread-Index: AQHaGDzAFfqMOen5JUCwmbDFX2u0nbB9JNQQ
Date:   Thu, 16 Nov 2023 16:55:33 +0000
Message-ID: <4cfd4808cc694f169aa8b83547ebc74d@AcuMS.aculab.com>
References: <202311061616.cd495695-oliver.sang@intel.com>
 <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
 <4097023.1700084620@warthog.procyon.org.uk>
 <CAHk-=wgR3Mw2-8k2O3S10T-f4oz8FNfg7aziLU_6pbx0qowxew@mail.gmail.com>
 <42895.1700089191@warthog.procyon.org.uk>
 <CAHk-=wi7gdgFM4tnLXfE4cj2XiKNARbGY-N2aF5h9CMaN6JUbA@mail.gmail.com>
In-Reply-To: <CAHk-=wi7gdgFM4tnLXfE4cj2XiKNARbGY-N2aF5h9CMaN6JUbA@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTYgTm92ZW1iZXIgMjAyMyAwMzoyNw0KPiAN
Cj4gT24gV2VkLCAxNSBOb3YgMjAyMyBhdCAxODowMCwgRGF2aWQgSG93ZWxscyA8ZGhvd2VsbHNA
cmVkaGF0LmNvbT4gd3JvdGU6DQouLi4NCj4gPiBBIGRpc2Fzc2VtYmx5IG9mIF9jb3B5X2Zyb21f
aXRlcigpIGZvciB0aGUgbGF0dGVyIGlzIGF0dGFjaGVkLiAgTm90ZSB0aGF0IHRoZQ0KPiA+IFVC
VUYvSU9WRUMgc3RpbGwgdXNlcyAicmVwIG1vdnNiIg0KPiANCj4gV2VsbCwgeWVzIGFuZCBuby4N
Cj4gDQo+IFVzZXIgY29waWVzIGRvIHRoYXQgWDg2X0ZFQVRVUkVfRlNSTSBhbHRlcm5hdGl2ZXMg
ZGFuY2UsIHNvIHRoZSBjb2RlDQo+IGdldHMgZ2VuZXJhdGVkIHdpdGggInJlcCBtb3ZzIiwgYnV0
IHlvdSdsbCBub3RlIHRoYXQgdGhlcmUgYXJlIHNldmVyYWwNCj4gJ25vcHMnIGFmdGVyIGl0Lg0K
PiANCj4gU29tZSBvZiB0aGUgbm9wcyBhcmUgYmVjYXVzZSB3ZSdsbCBiZSBpbnNlcnRpbmcgU1RB
Qy9DTEFDICh0aHJlZSBieXRlcw0KPiBlYWNoLCBJIHRoaW5rKSBpbnN0cnVjdGlvbnMgYXJvdW5k
IHVzZXIgYWNjZXNzZXMgZm9yIFNNQVAtY2FwYWJsZQ0KPiBDUFUncy4NCj4gDQo+IEJ1dCBzb21l
IG9mIHRoZSBub3BzIGFyZSBiZWNhdXNlIHdlJ2xsIGJlIHJld3JpdGluZyB0aGF0ICJyZXAgc3Rv
c2IiDQo+ICh0d28gYnl0ZXMsIGlpcmMpIGFzICJjYWxsIHJlcF9zdG9zX2FsdGVybmF0aXZlIiAo
NSBieXRlcykgb24gQ1BVJ3MNCj4gdGhhdCBkb24ndCBkbyBGU1JNIGxpa2UgeW91cnMuIFNvIHlv
dXIgQ1BVIHdvbid0IGFjdHVhbGx5IGJlIGV4ZWN1dGluZw0KPiB0aGF0ICdyZXAgc3Rvc2InIHNl
cXVlbmNlLg0KDQpJIHByZXN1bWUgbGFjayBvZiBjb2ZmZWUgaXMgcmVzcG9uc2libGUgZm9yIHRo
ZSBzL21vdnMvc3Rvcy8gOi0pDQoNCkhvdyBtdWNoIGRpZmZlcmVuY2UgZG9lcyBGU1JNIGFjdHVh
bGx5IG1ha2U/DQpFc3BlY2lhbGx5IHdoZW4gY29tcGFyZWQgdG8gdGhlIGNvc3Qgb2YgYSBmdW5j
dGlvbiBjYWxsIChldmVuDQp3aXRob3V0IHRoZSBob3JyaWQgcmV0dXJuIHRodW5rKS4NCg0KRm9y
IHNtYWxsICVjeCBJIHRoaW5rIG5vbi1GU1JNIG1vZGVybiBjcHUgYXJlIH4yIGNsb2Nrcy9ieXRl
DQoobm8gZml4ZWQgb3ZlcmhlYWQpLg0KV2hpY2ggbWVhbnMgJ3JlcCBtb3ZzYicgd2lucyBmb3Ig
Ym90aCBzaG9ydCBhbmQgbG9uZyBjb3BpZXMuDQpJIHdvbmRlciB3aGF0IHNpemVzIHRoZSBmdW5j
dGlvbiBjYWxsICh3aXRoIGFsbCBpdHMgc2l6ZQ0KYmFzZWQgY29tcGFyZXMgYXQgdGhlIHRvcCkg
aXMgYWN0dWFsbHkgYSB3aW4uDQoNClRoZXJlIGhhcyB0byBiZSBzb21lIG1pbGVhZ2UgaW4gZ2V0
dGluZyB0aGUgY29tcGxpZXIgdG8gZ2VuZXJhdGUNCidjYWxsIG1lbWNweScgKGZvciBub24tY29u
c3RhbnQgc2l6ZXMpIGFuZCB0aGVuIHJ1bi10aW1lIHBhdGNoaW5nDQp0aGUgNSBieXRlICdjYWxs
IG9mZnNldCcgaW50byAnbW92ICVlZHgsJWVjeDsgcmVwIG1vdnNiJy4NCg0KCURhdmlkDQoNCi0N
ClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBN
aWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxl
cykNCg==

