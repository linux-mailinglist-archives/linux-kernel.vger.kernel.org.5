Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8621C7EE985
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 23:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345553AbjKPWxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 17:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjKPWxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 17:53:47 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E65A120
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 14:53:43 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-65-mtqKR3EKMBK8ro9nsESItw-1; Thu, 16 Nov 2023 22:53:39 +0000
X-MC-Unique: mtqKR3EKMBK8ro9nsESItw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 16 Nov
 2023 22:53:47 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 16 Nov 2023 22:53:47 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>
CC:     David Howells <dhowells@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
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
        "fengwei.yin@intel.com" <fengwei.yin@intel.com>
Subject: RE: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
Thread-Topic: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
Thread-Index: AQHaGDzAFfqMOen5JUCwmbDFX2u0nbB9JNQQgAAOVwCAAEjLIA==
Date:   Thu, 16 Nov 2023 22:53:47 +0000
Message-ID: <a35af815280f4dd0b5db7f4920ab6a13@AcuMS.aculab.com>
References: <202311061616.cd495695-oliver.sang@intel.com>
 <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
 <4097023.1700084620@warthog.procyon.org.uk>
 <CAHk-=wgR3Mw2-8k2O3S10T-f4oz8FNfg7aziLU_6pbx0qowxew@mail.gmail.com>
 <42895.1700089191@warthog.procyon.org.uk>
 <CAHk-=wi7gdgFM4tnLXfE4cj2XiKNARbGY-N2aF5h9CMaN6JUbA@mail.gmail.com>
 <4cfd4808cc694f169aa8b83547ebc74d@AcuMS.aculab.com>
 <CAHk-=whuKOMn73oinrTQCcNwhXNOw5eksSBiCSzxycZ--asp4Q@mail.gmail.com>
In-Reply-To: <CAHk-=whuKOMn73oinrTQCcNwhXNOw5eksSBiCSzxycZ--asp4Q@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTYgTm92ZW1iZXIgMjAyMyAxNzoyNQ0KLi4u
DQo+ID4gSG93IG11Y2ggZGlmZmVyZW5jZSBkb2VzIEZTUk0gYWN0dWFsbHkgbWFrZT8NCj4gPiBF
c3BlY2lhbGx5IHdoZW4gY29tcGFyZWQgdG8gdGhlIGNvc3Qgb2YgYSBmdW5jdGlvbiBjYWxsIChl
dmVuDQo+ID4gd2l0aG91dCB0aGUgaG9ycmlkIHJldHVybiB0aHVuaykuDQo+IA0KPiBJdCBjYW4g
YmUgYSBiaWcgZGVhbC4gIFRoZSBzdWJqZWN0IGxpbmUgaGVyZSBpcyBhbiBleGFtcGxlLiBPbiB0
aGF0DQo+IG1hY2hpbmUsIHVzaW5nIHRoZSBjYWxsIHRvICdtZW1jcHlfb3JpZycgY2xlYXJseSBw
ZXJmb3JtcyAqbm90aWNlYWJseSoNCj4gYmV0dGVyLiBTbyB0aGF0IDE2JSByZWdyZXNzaW9uIHdh
cyJmYXN0ICBhcHBhcmVudGx5IGF0IGxlYXN0IHBhcnRseQ0KPiBiZWNhdXNlIG9mDQo+IA0KPiAg
IC0xMS4wICBwZXJmLXByb2ZpbGUuc2VsZi5jeWNsZXMtcHAubWVtY3B5X29yaWcNCj4gICArMTQu
NyAgcGVyZi1wcm9maWxlLnNlbGYuY3ljbGVzLXBwLmNvcHlfcGFnZV9mcm9tX2l0ZXJfYXRvbWlj
DQo+IA0KPiB3aGVyZSB0aGF0IGlubGluZWQgY29weSAodGhhdCB1c2VkICdyZXAgbW92c3EnIGFu
ZCBvdGhlciB0aGluZ3MgYXJvdW5kDQo+IGl0KSB3YXMgbm90aWNlYWJseSB3b3JzZSB0aGFuIGp1
c3QgY2FsbGluZyBtZW1jcHlfb3JpZyB0aGF0IGRvZXMgYQ0KPiBiYXNpYyB1bnJvbGxlZCBsb29w
Lg0KDQpXYXNuJ3QgdGhhdCB0aGUgc3R1cGlkIFBvUyBpbmxpbmVkIG1lbWNweSB0aGF0IHdhcyBh
YnNvbHV0ZWx5DQpob3JyZW5kb3VzPw0KSSd2ZSBhbHNvIG5vdCBzZWVuIGFueSBvYnZpb3VzIHN0
YXRlbWVudCBhYm91dCB0aGUgbGVuZ3RocyBvZiB0aGUNCmNvcGllcy4NCg0KPiBOb3csICp3aHkq
IGl0IG1hdHRlcnMgYSBsb3QgaXMgdW5jbGVhci4gU29tZSBtYWNoaW5lcyBsaXRlcmFsbHkgaGF2
ZQ0KPiB0aGUgImZhc3QgcmVwIHN0cmluZyIgY29kZSBkaXNhYmxlZCwgYW5kIHRoZW4gInJlcCBt
b3ZzYiIgaXMganVzdA0KPiBob3JyZW5kb3VzLiBUaGF0J3MgYXJndWFibHkgYSBtYWNoaW5lIHNl
dHVwIGlzc3VlLCBidXQgcGVvcGxlIGhhdmUNCj4gYmVlbiBrbm93biB0byBkbyB0aG9zZSB0aGlu
Z3MgYmVjYXVzZSBvZiBwcm9ibGVtcyAobW9zdCByZWNlbnRseQ0KPiAicmVwdGFyIikuDQoNClRo
ZXkgZ2V0IHdoYXQgdGhleSBkZXNlcnZlIDotKQ0KDQpJJ3ZlIGp1c3QgZG9uZSBzb21lIG1lYXN1
cmVtZW50cyBvbiBhbiBpNy03NzAwLg0KY3B1aW5mbzpmbGFncyBoYXMgZXJtcyBidXQgbm90IGZy
bXMgKGFzIEknZCBleHBlY3QpLg0KDQpUaGUgdGVzdCBjb2RlIHBhdGggaXM6DQoJcmRwbWMNCgls
ZmVuY2UNCnRoZW4gMTAgY29waWVzIG9mOg0KCW1vdgklcjEzLCVyZGkNCgltb3YJJXIxNCwlcnNp
DQoJbW92CSVyMTUsJXJjeA0KCXJlcCBtb3ZzYg0KZm9sbG93ZWQgYnk6DQoJbGZlbmNlDQoJcmRw
bWMNCg0Kd2hpY2ggSSBydW4gdGhyb3VnaCA1IHRpbWVzLg0KVGhlIGZpcnN0IHBhc3MgaXMgY29s
ZC1jYWNoZSBhbmQgZXhwZWN0ZWQgdG8gYmUgc2xvdy4NClRoZSBvdGhlciA0IHByZXR0eSBtdWNo
IHRha2UgdGhlIHNhbWUgbnVtYmVyIG9mIGNsb2Nrcy4NCihXaGljaCBpcyB3aGF0IEkndmUgc2Vl
biBiZWZvcmUgdXNpbmcgdGhlIHNhbWUgYmFzaWMgcHJvZ3JhbQ0KdG8gdGltZSB0aGUgaXAtY2hl
Y2tzdW0gY29kZS4pDQoNCkF0IGZpcnN0IHNpZ2h0IGl0IGFwcGVhcnMgdGhhdCBlYWNoICdyZXAg
bW92c2InIHRha2VzIGFib3V0DQozMiBjbG9ja3MgZm9yIHNob3J0IGNvcGllcyBhbmQgb25seSBz
dGFydHMgaW5jcmVhc2luZyBhYm92ZQ0KKGFib3V0KSAzMiBieXRlcyAtIGFuZCB0aGVuIGluY3Jl
YXNlcyB2ZXJ5IHNsb3dseS4NCg0KQnV0IHNvbWV0aGluZyB2ZXJ5IG9kZCBpcyBnb2luZyBvbi4N
CkZvciBsZW5ndGggMSAodG8gfjMyKSB0aGUgZmlyc3QgcGFzcyBpcyB+NDUwMCBjbG9ja3MgYW5k
IHRoZSBvdGhlcnMgfjMyMC4NCkZvciBsb25nZXIgbGVuZ3RoIHRoZSBjbG9jayBjb3VudCBpbmNy
ZWFzZXMgc2xvd2x5Lg0KQnV0IGxlbmd0aCAwIHJlcG9ydHMgfjYwMCBmb3IgYWxsIDUgcGFzc2Vz
Lg0KDQpUaGUgY2FjaGUgc2hvdWxkIGJlIHRoZSBzYW1lIGluIGJvdGggY2FzZXMuDQpTbyB0aGUg
ZWZmZWN0IG11c3QgYmUgYW4gYXJ0aWZhY3Qgb2YgdGhlIGluc3RydWN0aW9uIGRlY29kZXIuDQpU
aGUgbG9vcCBpc24ndCBsb25nIGVub3VnaCB0byBub3QgZml0IGluIHRoZSBjcHUgbG9vcCBidWZm
ZXINCihvZiBkZWNvZGVkIHUtb3BzKSAtIGNvdWxkIHRyeSBwYWRkaW5nIGl0IHdpdGggbG90cyBv
ZiBub3BzLg0KDQpUaGlzIHJhdGhlciBpbXBsaWVzIHRoYXQgdGhlIGRlY29kZSBvZiAncmVwIG1v
dnMnIGlzIHRha2luZw0Kc29tZXRoaW5nIGhvcnJpZCBsaWtlIDQ1MCBjbG9ja3MsIGJ1dCBpdCBn
ZXRzIHNhdmVkIHNvbWV3aGVyZS4NCk9UT0ggaWYgdGhlIGNvdW50IGlzIHplcm8gdGhlIGRlY29k
ZStleGVjdXRlIGlzIG9ubHkgfjYwIGNsb2Nrcw0KYnV0IGl0IGlzbid0IHNhdmVkLg0KDQpJZiB0
aGF0IGlzIHRydWUgKGFuZCBJIGRvdWJ0IEludGVsIHdvdWxkIGFkbWl0IGl0KSB5b3UgcHJldHR5
DQptdWNoIG5ldmVyIHdhbnQgdG8gdXNlICdyZXAgbW92cycgaW4gYW55IGZvcm0gdW5sZXNzIHlv
dSBhcmUNCmdvaW5nIHRvIGV4ZWN1dGUgdGhlIGluc3RydWN0aW9uIG11bHRpcGxlIHRpbWVzIG9y
IHRoZQ0KbGVuZ3RoIGlzIHNpZ25pZmljYW50Lg0KDQpUaGlzIHdhc24ndCB0aGUgY29uY2x1c2lv
biBJIGV4cGVjdGVkIHRvIGNvbWUgdG8uLi4NCg0KSXQgYWxzbyBtZWFucyB0aGF0IHdoaWxlICdy
ZXAgbW92cycgd2lsbCBjb3B5IGF0IDE2IGJ5dGVzL2Nsb2NrDQoob3IgMzIgaWYgdGhlIGRlc3Rp
bmF0aW9uIGlzIGFsaWduZWQpIGl0IGlzIHBvc3NpYmxlIHRoYXQgaXQNCndpbGwgYWx3YXlzIGJl
IHNsb3dlciB0aGFuIGEgcmVnaXN0ZXIgY29weSBsb29wICg4IGJ5dGVzL2Nsb2NrKQ0KdW5sZXNz
IHRoZSBjb3B5IGlzIHNpZ25pZmljYW50bHkgbG9uZ2VyIHRoYW4gbW9zdCBvZiB0aGUga2VybmVs
DQptZW1jcHkoKSBjYW4gZXZlciBiZS4NCg0KLi4uDQo+IEkgaGF2ZSB0aGlzIG1lbW9yeSBmcm9t
IG15ICJwdXNoIGZvciAtT3MiICh3aGljaCBpcyBmcm9tIG92ZXIgYSBkZWNhZGUNCj4gYWdvLCB0
byB0YWtlIG15IG1lbW9yeSB3aXRoIGEgcGluY2ggb2Ygc2FsdCkgb2Ygc2VlaW5nICJyZXAgbW92
c2IiDQo+IGZvbGxvd2VkIGJ5IGEgbG9hZCBvZiB0aGUgcmVzdWx0IGNhdXNpbmcgYSBob3JyaWQg
c3RhbGwgb24gdGhlIGxvYWQuDQoNCkkgYWRkZWQgc29tZSAodW5yZWxhdGVkKSBtZW1vcnkgYWNj
ZXNzZXMgYmV0d2VlbiB0aGUgJ3JlcCBtb3ZzYicuDQpEaWRuJ3Qgc2VlIGFueSBzaWduaWZpY2Fu
dCBkZWxheXMuDQoNClRoZSBzeXN0ZW1zIHlvdSB3ZXJlIHVzaW5nIGEgZGVjYWRlIGFnbyB3ZXJl
IGxpa2VseSB2ZXJ5IGRpZmZlcmVudA0KdG8gdGhlIGN1cnJlbnQgb25lcyAtIGVzcGVjaWFsbHkg
aWYgdGhleSB3ZXJlIEludGVsIGFuZCBwcmUtZGF0ZWQNCnNhbmR5IGJyaWRnZS4NCg0KPiBBIHJl
Z3VsYXIgbG9hZC1zdG9yZSBsb29wIHdpbGwgaGF2ZSB0aGUgc3RvcmUgZGF0YSBmb3J3YXJkZWQg
dG8gYW55DQo+IHN1YnNlcXVlbnQgbG9hZCwgYnV0ICJyZXAgbW92cyIgbWlnaHQgbm90IGRvIHRo
YXQgYW5kIGlmIGl0IHdvcmtzIG9uIGENCj4gY2FjaGVsaW5lIGxldmVsIHlvdSBtaWdodCBsb3Nl
IG91dCBvbiB0aG9zZSBraW5kcyBvZiB0aGluZ3MuDQoNClRoYXQgcHJvYmFibHkgZG9lc24ndCBt
YXR0ZXIgZm9yIGRhdGEgYnVmZmVyIGNvcGllcy4NCllvdSBhcmUgdW5saWtlbHkgdG8gYWNjZXNz
IHRoZW0gYWdhaW4gdGhhdCBxdWlja2x5Lg0KDQo+IERvbid0IGdldCBtZSB3cm9uZyAtIEkgcmVh
bGx5IGxpa2UgdGhlIHJlcCBzdHJpbmcgaW5zdHJ1Y3Rpb25zLCBhbmQNCj4gd2hpbGUgdGhleSBo
YXZlIGlzc3VlcyBJJ2QgKmxvdmUqIGZvciBDUFUncyB0byBiYXNpY2FsbHkgZG8gIm1lbWNweSIN
Cj4gYW5kICJtZW1zZXQiIHdpdGhvdXQgYW55IGxpYnJhcnkgY2FsbCBvdmVyaGVhZC4gVGhlIHNl
Y3VyaXR5DQo+IG1pdGlnYXRpb25zIGhhdmUgbWFkZSBpbmRpcmVjdCBjYWxscyBtdWNoIHdvcnNl
LCBidXQgdGhleSBoYXZlIG1hZGUNCj4gcmVndWxhciBmdW5jdGlvbiBjYWxsIG92ZXJoZWFkIHdv
cnNlIHRvbyAoYW5kIHRoZXJlJ3MgdGhlIEkkIGZvb3RwcmludA0KPiB0aGluZyBldGMgZXRjKS4N
Cj4gDQo+IFNvIEkgbGlrZSAicmVwIG1vdnMiIGEgbG90IHdoZW4gaXQgd29ya3Mgd2VsbCwgYnV0
IGl0IG1vc3QgZGVmaW5pdGVseQ0KPiBkb2VzIG5vdCB3b3JrIHdlbGwgZXZlcnl3aGVyZS4NCg0K
WWVzLCBpdCBpcyBhIHJlYWwgc2hhbWUgdGhhdCBldmVyeXRoaW5nIHNpbmNlIChwcm9iYWJseSkg
dGhlIDQ4Ng0KaGFzIGV4ZWN1dGUgJ3JlcCBhbnl0aGluZycgcmF0aGVyIHNsb3dlciB0aGFuIHlv
dSBtaWdodCBleHBlY3QuDQoNCkludGVsIGFsc28gZipja2VkIHVwIHRoZSAnbG9vcCcgKGRlYyAl
Y3gsIGpueikgaW5zdHJ1Y3Rpb24uDQpFdmVuIG9uIGNwdSB3aXRoIGFkY3ggYW5kIGFkb3ggeW91
IGNhbid0IHVzZSAnbG9vcCcuDQoNCi4uLg0KPiBUaGUgcHJvYmxlbSB3aXRoIGNvZGUgZ2VuZXJh
dGlvbiBhdCB0aGlzIGxldmVsIGlzIHRoYXQgeW91IHdpbiBzb21lLA0KPiB5b3UgbG9zZSBzb21l
LiBZb3UgY2FuIHNlbGRvbSBtYWtlIGV2ZXJ5Ym9keSBoYXBweS4NCg0KVHJ5aW5nIHRvIHNlY29u
ZCBndWVzcyBhIHdvcmthYmxlIG1vZGVsIGZvciB0aGUgeDg2IGNwdSBpcyBoYXJkLg0KRm9yIGFy
aXRobWV0aWMgaW5zdHJ1Y3Rpb25zIHRoZSByZWdpc3RlciBkZXBlbmRlbmN5IGNoYWlucyBzZWVt
DQp0byBnaXZlIGEgcmVhc29uYWJsZSBtb2RlbC4NCklmIHRoZSBjb2RlIGZsb3cgZG9lc24ndCBk
ZXBlbmQgb24gdGhlIGRhdGEgdGhlbiB0aGUgJ291dCBvZiBvcmRlcicNCmV4ZWN1dGUgd2lsbCBw
cm9jZXNzIGRhdGEgKGZyb20gY2FjaGUpIHdoZW4gdGhlIHJlbGV2YW50IG1lbW9yeQ0KaW5zdHJ1
Y3Rpb25zIGZpbmFsbHkgY29tcGxldGUuDQpTbyBJIGFjdHVhbGx5IGdvdCBwcmV0dHkgbXVjaCB0
aGUgZXhwZWN0ZWQgdGltaW5ncyBmb3IgbXkgaXAtY3N1bQ0KY29kZSBsb29wcyAoc29tZXdoYXQg
YmV0dGVyIHRoYW4gdGhlIGN1cnJlbnQgdmVyc2lvbikuDQoNCkJ1dCBnaXZlIG1lIGEgbmljZSBz
aW1wbGUgY3B1IGxpa2UgdGhlIE5pb3NJSSBzb2Z0IGNwdS4NClRoZSBpbnN0cnVjdGlvbiBhbmQg
bG9jYWwgbWVtb3J5IHRpbWluZ3MgYXJlIGFic29sdXRlbHkNCndlbGwgZGVmaW5lZCAtIGFuZCB5
b3UgY2FuIGxvb2sgYXQgdGhlIGZwZ2EgaW50ZXJuYWxzIGFuZA0KY2hlY2shDQoNCglEYXZpZA0K
DQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFy
bSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAo
V2FsZXMpDQo=

