Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528D37EF50C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 16:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjKQPUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 10:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjKQPUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 10:20:32 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CDB10C6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 07:20:27 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-281-F94b4dXdPVyEigvX5qO0OA-1; Fri, 17 Nov 2023 15:20:25 +0000
X-MC-Unique: F94b4dXdPVyEigvX5qO0OA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 17 Nov
 2023 15:20:37 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 17 Nov 2023 15:20:37 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     Borislav Petkov <bp@alien8.de>,
        David Howells <dhowells@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Christian Brauner" <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Jens Axboe" <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "fengwei.yin@intel.com" <fengwei.yin@intel.com>,
        linux-toolchains ML <linux-toolchains@vger.kernel.org>
Subject: RE: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
Thread-Topic: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
Thread-Index: AQHaGUtnFfqMOen5JUCwmbDFX2u0nbB+dBTggAAPWYCAABKVEA==
Date:   Fri, 17 Nov 2023 15:20:37 +0000
Message-ID: <451fb3951e504c739d628f3c8b3f7d50@AcuMS.aculab.com>
References: <202311061616.cd495695-oliver.sang@intel.com>
 <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
 <20231115190938.GGZVUXcuUjI3i1JRAB@fat_crate.local>
 <CAHk-=wh0TcXyGmKHfs+Xe=5Sd5bNn=NNV9CEtOy_tbyHAAmk9g@mail.gmail.com>
 <20231116154406.GDZVY4xmFvRQt0wGGE@fat_crate.local>
 <CAHk-=wjGQh3ucZFmFR0evbKu2OyEuue-bOjsrnCvxSQdj8x6aw@mail.gmail.com>
 <20231117114421.GCZVdSFZ7DKtBol821@fat_crate.local>
 <67acdf70c3fd4adf9bc0dddd4b10d4a1@AcuMS.aculab.com>
 <CAHk-=wjjF7tQ4ycPiA4gbYqF-dpTQx+VVHCDqjWR=ogqNUR51g@mail.gmail.com>
In-Reply-To: <CAHk-=wjjF7tQ4ycPiA4gbYqF-dpTQx+VVHCDqjWR=ogqNUR51g@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTcgTm92ZW1iZXIgMjAyMyAxMzozNg0KPiAN
Cj4gT24gRnJpLCAxNyBOb3YgMjAyMyBhdCAwODowOSwgRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWln
aHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBaZXJvIGxlbmd0aCBjb3BpZXMgYXJlIGRp
ZmZlcmVudCwgdGhleSBhbHdheXMgdGFrZSB+NjAgY2xvY2tzLg0KPiANCj4gVGhhdCB6ZXJvLWxl
bmd0aCB0aGluZyBpcyBzb21lIG9kZCBtaWNyb2NvZGUgaW1wbGVtZW50YXRpb24gaXNzdWUsIGFu
ZA0KPiBJIHRoaW5rIGludGVsIGFjdHVhbGx5IG1hZGUgYSBGWlJNIGNwdWlkIGJpdCBhdmFpbGFi
bGUgZm9yIGl0ICgiRmFzdA0KPiBaZXJvLXNpemUgUmVwIE1vdnMiKS4NCj4gDQo+IEkgZG9uJ3Qg
dGhpbmsgd2UgY2FyZSBpbiB0aGUga2VybmVsLCBidXQgc29tZWJvZHkgZWxzZSBkaWQgKG9yIG1h
eWJlDQo+IEludGVsIGFkZGVkIGEgZmxhZyBmb3IgIndlIGZpeGVkIGl0IiBqdXN0IGJlY2F1c2Ug
dGhleSBub3RpY2VkKQ0KDQpJIHdhc24ndCByZWFsbHkgd29ycmllZCBhYm91dCBpdCAtIGJ1dCBp
dCB3YXMgYW4gb2RkaWR5Lg0KDQo+IEkgYXQgc29tZSBwb2ludCBkaWQgc29tZSBwcm9maWxpbmcs
IGFuZCB3ZSBkbyBoYXZlIHplcm8tbGVuZ3RoIG1lbWNweQ0KPiBjYXNlcyBvY2Nhc2lvbmFsbHkg
KGF0IGxlYXN0IGZvciB1c2VyIGNvcGllcywgd2hpY2ggd2FzIHdoYXQgSSB3YXMNCj4gbG9va2lu
ZyBhdCksIGJ1dCB0aGV5IGFyZW4ndCBjb21tb24gZW5vdWdoIHRvIHdvcnJ5IGFib3V0IHNvbWUg
c21hbGwNCj4gZXh0cmEgc3RyYW5nZSBvdmVyaGVhZC4NCg0KRm9yIHVzZXIgY29waWVzIGF2b2lk
aW5nIHRoZSBzbGFjL3N0YWMgbWlnaHQgbWFrZSBpdCB3b3J0aHdoaWxlLg0KQnV0IEkgZG91YnQg
eW91J2Qgd2FudCB0byBhZGQgdGhlICdqY3h6IC4rbicgaW4gdGhlIGNvcHkgY29kZQ0KaXRzZWxm
IGJlY2F1c2UgdGhlIG1pc3ByZWRpY3RlZCBicmFuY2ggbWlnaHQgbWFrZSBhIGJpZ2dlcg0KZGlm
ZmVyZW5jZS4NCg0KSSBoYXZlIHRlc3RlZCB3cml0ZXYoKSB3aXRoIGxvdHMgb2YgemVybyBsZW5n
dGggZnJhZ21lbnRzLg0KQnV0IHRoYXQgaXNuJ3QgYSBub3JtYWwgY2FzZS4NCg0KPiAoSW4gY2Fz
ZSB5b3UgY2FyZSwgaXQgd2FzIGZvciB0aGluZ3MgbGlrZSBhbiBpb2N0bCBkb2luZyAiY29weSB0
aGUNCj4gYmFzZSBwYXJ0IG9mIHRoZSBpb2N0bCBkYXRhLCB0aGVuIGNvcHkgdGhlIHJlc3Qgc2Vw
YXJhdGVseSIuICBXaGVyZQ0KPiAidGhlIHJlc3QiIHdhcyB0aGVuIG9mdGVuIG5vdGhpbmcgYXQg
YWxsKS4NCg0KVGhhdCBzcGVjaWZpYyBjb2RlIHdoZXJlIGEgemVybyBsZW5ndGggY29weSBpcyBx
dWl0ZSBsaWtlbHkNCndvdWxkIHByb2JhYmx5IGJlbmVmaXQgZnJvbSBhIHRlc3QgaW4gdGhlIHNv
dXJjZS4NCg0KPiA+IE15IGN1cnJlbnQgZ3Vlc3MgZm9yIHRoZSA1MDAwIGNsb2NrcyBpcyB0aGF0
IHRoZSBsb2dpYyB0bw0KPiA+IGRlY29kZSAncmVwIG1vdnNiJyBpcyBsb2FkZWQgaW50byBhIGJ1
ZmZlciB0aGF0IGlzIGFsc28gdXNlZA0KPiA+IHRvIGRlY29kZSBzb21lIG90aGVyIGluc3RydWN0
aW9ucy4NCj4gDQo+IFVubGlrZWx5Lg0KPiANCj4gSSB3b3VsZCBndWVzcyBpdCdzIHRoZSAicG93
ZXIgdXAgdGhlIEFWWDIgc2lkZSIuIFRoZSBtZW1vcnkgY29weSB1c2VzDQo+IHRob3NlIHNhbWUg
cmVzb3VyY2VzIGludGVybmFsbHkuDQoNClRoYXQgd291bGQgbWFrZSBtb3JlIHNlbnNlIC0gYW5k
IGhhdmUgbXVjaCB0aGUgc2FtZSBlZmZlY3QuDQpJZiB0aGUga2VybmVsIHVzZWQgJ3JlcCBtb3Zz
YicgaW50ZXJuYWxseSBhbmQgZm9yIHVzZXIgY29waWVzDQppdCBwcmV0dHkgbXVjaCB3b3VsZG4n
dCBldmVyIGdldCBwb3dlcmVkIGRvd24uDQoNCj4gWW91IGNvdWxkIHRyeSB0byBzZWUgaWYgImZp
cnN0IEFWWCBtZW1vcnkgYWNjZXNzIiAob3Igc2ltaWxhcikgaGFzIHRoZQ0KPiBzYW1lIGV4dHJh
IGluaXRpYWwgY3B1IGN5Y2xlIGlzc3VlLg0KDQpTcG90IG9uLg0KCXZwYnJvYWRjYXN0ICV4bW0x
LCV4bW0yDQpkb2VzIHRoZSB0cmljayBhcyB3ZWxsLg0KDQo+IEFueXdheSwgdGhlIENQVSB5b3Ug
YXJlIHRlc3RpbmcgaXMgbmV3IGVub3VnaCB0byBoYXZlIEVSTVMgLSB0aGF0J3MNCj4gdGhlICJ3
ZSBkbyBwcmV0dHkgd2VsbCBvbiBzdHJpbmcgaW5zdHJ1Y3Rpb25zIiBmbGFnLiBJdCBkb2VzIGlu
ZGVlZCBkbw0KPiBwcmV0dHkgd2VsbCBvbiBzdHJpbmcgaW5zdHJ1Y3Rpb25zLCBidXQgaGFzIGEg
ZmV3IG9kZGl0aWVzIGluIGFkZGl0aW9uDQo+IHRvIHRoZSB6ZXJvLXNpemVkIHRoaW5nLg0KDQpG
cm9tIHdoYXQgSSBsb29rZWQgYXQgcHJldHR5IG11Y2ggZXZlcnl0aGluZyBhbnlvbmUgY2FyZXMg
YWJvdXQNCnByb2JhYmx5IGhhcyBFUk1TLg0KWW91IG5lZWQgdG8gYmUgcnVubmluZyBvbiBzb21l
dGhpbmcgb2xkZXIgdGhhbiBzYW5keSBicmlkZ2UuDQpTbyBiYXNpY2FsbHkgJ2NvcmUgMicgb3Ig
J2NvcmUgMiBkdW8nIChvciBQNCBuZXRidXJzdCkuDQpUaGUgYW1kIGNwdXMgYXJlIHNpbWlsYXJs
eSBvbGQuDQoNCj4gVGhlIG90aGVyIGJhZCBjYXNlcyB0ZW5kIHRvIGJlIGFsb25nIHRoZSBsaW5l
IG9mICJpdCBmYWxscyBmbGF0IG9uIGl0cw0KPiBmYWNlIHdoZW4gdGhlIHNvdXJjZSBhbmQgZGVz
dGluYXRpb24gYWRkcmVzcyBhcmUgbm90IG11dHVhbGx5IGFsaWduZWQsDQo+IGJ1dCB0aGV5IGFy
ZSB0aGUgc2FtZSB2aXJ0dWFsIGFkZHJlc3MgbW9kdWxvIDQwOTYiLg0KDQpUaGVyZSBpcyBhIHNp
bWlsYXIgY29uZGl0aW9uIHRoYXQgdmVyeSBvZnRlbiBzdG9wIHRoZSBjcHUgZXZlcg0KYWN0dWFs
bHkgZG9pbmcgdHdvIG1lbW9yeSByZWFkcyBpbiBvbmUgY2xvY2suDQpDb3VsZCBlYXNpbHkgYmUg
cmVsYXRlZC4NCg0KPiBPciBzb21ldGhpbmcgbGlrZSB0aGF0LiBJIGZvcmdldCB0aGUgZXhhY3Qg
ZGV0YWlscy4gVGhlIGRldGFpbHMgZG8NCj4gZXhpc3QsIGJ1dCBJIGZvcmdldCB3aGVyZSAoSSBz
dXNwZWN0IGVpdGhlciBBZ25lciBGb2cgb3Igc29tZSBmb290bm90ZQ0KPiBpbiBzb21lIEludGVs
IGFyY2hpdGVjdHVyZSBtYW51YWwpLg0KDQpJZiBJbnRlbCBoYXZlIHB1Ymxpc2hlZCBpdCwgaXQg
d2lsbCBiZSBpbiBhbiB1bmxpdCBiYXNlbWVudA0KYmVoaW5kIGEgbG9ja2VkIGRvb3IgYW5kIGEg
YnJva2VuIHN0YWlyY2FzZSENCg0KVW5sZXNzICdwYWdlIGNvcHknIGhpdHMgaXQgSSB3b25kZXIg
aWYgaXQgcmVhbGx5IG1hdHRlcnMNCmZvciBhIG5vcm1hbCB3b3JrbG9hZC4NClllcywgeW91IGNh
biBjb25zcGlyZSB0byBoaXQgaXQsIGJ1dCBtb3N0bHkgeW91IHdvbnQuDQoNCldhc24ndCBpdCBv
bmUgb2YgdGhlIGF0b21zIHdoZXJlIHRoZSBkYXRhIGNhY2hlIHByZWZldGNoDQptYW5hZ2VkIHRv
IGNvbXBsZXRlbHkgZGVzdHJveSBmb3J3YXJkcyBkYXRhIGNvcHkuDQpUbyB0aGUgcG9pbnQgd2hl
cmUgaXMgd2FzIHdvcnRoIHRha2luZyB0aGUgaGl0IG9mIGENCmJhY2t3YXJkcyBjb3B5Pw0KDQo+
IFNvIGl0J3MgdmVyeSBtdWNoIG5vdCBhcyBzaW1wbGUgYXMgImZpeGVkIGluaXRpYWwgY29zdCBh
bmQgdGhlbiBhDQo+IGZhaXJseSBmaXhlZCBjb3N0IHBlciAzMkIiLCBldmVuIGlmIHRoYXQgaXMg
Km9uZSogcGF0dGVybi4NCg0KVHJ1ZSwgYnV0IGl0IGlzIHRoZSBtb3N0IGNvbW1vbiBvbmUuDQpB
bmQgaWYgaXQgaXMgYmFkIHRoZSB3aG9sZSB0aGluZyBpc24ndCB3b3J0aCB1c2luZyBhdCBhbGwu
DQoNCkknbGwgdHJ5IG15IHRlc3Qgb24gYSBpdnkgYnJpZGdlIGxhdGVyLg0KKEkgZG9uJ3QgaGF2
ZSBhbnl0aGluZyBvbGRlciB0aGF0IGFjdHVhbGx5IGJvb3RzLikNCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==

