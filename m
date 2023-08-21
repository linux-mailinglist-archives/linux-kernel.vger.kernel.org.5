Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDDD78253A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjHUIQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjHUIQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:16:41 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9939993
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:16:39 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-113-9_BOF_yAPvOdY0vZpb4dPw-1; Mon, 21 Aug 2023 09:16:28 +0100
X-MC-Unique: 9_BOF_yAPvOdY0vZpb4dPw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 21 Aug
 2023 09:16:17 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 21 Aug 2023 09:16:17 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alejandro Colomar' <alx@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: RE: struct_size() using sizeof() vs offsetof()
Thread-Topic: struct_size() using sizeof() vs offsetof()
Thread-Index: AQHZ0KEzXPZ5QWstfUGUK20udA0j8K/0arpg
Date:   Mon, 21 Aug 2023 08:16:17 +0000
Message-ID: <55bb7e4f633340db9a9c013b91afedd6@AcuMS.aculab.com>
References: <74e8cf91-d095-33e3-c548-34d80b691089@kernel.org>
In-Reply-To: <74e8cf91-d095-33e3-c548-34d80b691089@kernel.org>
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

RnJvbTogQWxlamFuZHJvIENvbG9tYXINCj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAxNywgMjAy
MyAxOjIzIEFNDQo+IA0KPiBIaSBLZWVzLCBHdXN0YXZvLA0KPiANCj4gSSd2ZSBiZWVuIGRpc2N1
c3Npbmcgd2l0aCBhIGZyaWVuZCBhYm91dCB0aGUgYXBwcm9wcmlhdGVuZXNzIG9mIHNpemVvZigp
DQo+IHZzIG9mZnNldG9mKCkgZm9yIGNhbGN1bGF0aW5nIHRoZSBzaXplIG9mIGEgc3RydWN0dXJl
IHdpdGggYSBmbGV4aWJsZQ0KPiBhcnJheSBtZW1iZXIgKEZBTSkuDQo+IA0KPiBBZnRlciByZWFk
aW5nIEplbnMgR3VzdGVkdCdzIGJsb2cgcG9zdCBhYm91dCBpdFsxXSwgd2UgdHJpZWQgc29tZSB0
ZXN0cywNCj4gYW5kIHdlIGdvdCBzb21lIGludGVyZXN0aW5nIHJlc3VsdHMgdGhhdCBkaXNjb3Vy
YWdlZCBtZSBmcm9tIHVzaW5nIHNpemVvZigpLg0KPiBTZWUgYmVsb3cuDQo+IA0KPiBCdXQgdGhl
biwgc2FpZCBmcmllbmQgcG9pbnRlZCB0byBtZSB0aGF0IHRoZSBrZXJuZWwgdXNlcyBzaXplb2Yo
KSBpbg0KPiBzdHJ1Y3Rfc2l6ZSgpLCBhbmQgd2Ugd29uZGVyZWQgd2h5IHlvdSB3b3VsZCBoYXZl
IGNob3NlbiBpdC4gIEl0J3Mgc2FmZQ0KPiBhcyBsb25nIGFzIHlvdSBfa25vd18gdGhhdCB0aGVy
ZSdzIG5vIHBhZGRpbmcsIG9yIHRoYXQgdGhlIGFsaWdubWVudCBvZg0KPiB0aGUgRkFNIGlzIGFz
IGxhcmdlIGFzIHRoZSBwYWRkaW5nICh3aGljaCB5b3UgcHJvYmFibHkga25vdyBpbiB0aGUga2Vy
bmVsKSwNCj4gYnV0IGl0IHNlZW1zIHNhZmVyIHRvIHVzZQ0KPiANCj4gCU1BWChzaXplb2Yocyks
IG9mZnNldG9mKHMsIGZhbSkgKyBzaXplb2ZfbWVtYmVyKHMsIGZhbSkgKiBjb3VudCkNCj4gDQo+
IFRoZSB0aGluZyBpcywgaWYgdGhlcmUncyBhbnkgdHJhaWxpbmcgcGFkZGluZyBpbiB0aGUgc3Ry
dWN0LCB0aGUgRkFNIG1heQ0KPiBvdmVybGFwIHRoZSBwYWRkaW5nLCBhbmQgdGhlIGNhbGN1bGF0
aW9uIHdpdGggc2l6ZW9mKCkgd2lsbCB3YXN0ZSBhIGZldw0KPiBieXRlcywgYW5kIGlmIG1pc3Vz
ZWQgdG8gZ2V0IHRoZSBsb2NhdGlvbiBvZiB0aGUgRkFNLCB0aGUgcHJvYmxlbSB3aWxsIGJlDQo+
IGJpZ2dlciwgYXMgeW91J2xsIGdldCBhIHdyb25nIGxvY2F0aW9uLg0KPiANCj4gU28sIEkganVz
dCB3YW50ZWQgdG8gcHJ5IHdoYXQgYW5kIGVzcGVjaWFsbHkgd2h5IHRoZSBrZXJuZWwgY2hvc2Ug
dG8gcHJlZmVyDQo+IGEgc2ltcGxlIHNpemVvZigpLg0KPiANCj4gQ2hlZXJzLA0KPiBBbGV4DQo+
IA0KPiAtLS0NCi4uLi4uDQo+IAlzdHJjcHkocy0+ZmFtLCAiSGVsbG8sIHNpemVvZiEiKTsNCj4g
CXAgPSAoY2hhciAqKSBzICsgc2l6ZW9mKHN0cnVjdCBzKTsNCj4gCXB1dHMocCk7DQoNCldoeSBv
biBlYXJ0aCB3b3VsZCB5b3UgZXhwZWN0IHRoZSBhYm92ZSB0byBkbyBhbnl0aGluZyBzZW5zaWJs
ZT8NCg0KSXQgaXMgYSBzaGFtZSB5b3UgY2FuIGp1c3QgdXNlIG9mZnNldG9mKHR5cGUsIG1lbWJl
cltjb3VudCArIDFdKS4NClRoYXQgaXMgZmluZSBmb3IgY29uc3RhbnRzLCBidXQgdGhlIEMgbGFu
Z3VhZ2UgcmVxdWlyZXMgb2Zmc2V0b2YoKQ0KdG8gYmUgYSBjb21waWxlLXRpbWUgY29uc3RhbnQg
LSBJIGNhbid0IGhlbHAgZmVlbGluZyB0aGUgc3RhbmRhcmRzDQpib2R5IGRpZG4ndCBjb25zaWRl
ciBub24tY29uc3RhbnQgYXJyYXkgb2Zmc2V0cy4NCihUaGUgY29tcGlsZXIgZm9yIGEgd2VsbCBr
bm93biBPUyB3b24ndCBjb21waWxlIHRoYXQgKG9yIGFueXRoaW5nDQp0aGF0IGxvb2tzIGxpa2Ug
aXQpIGV2ZW4gZm9yIGEgY29uc3RhbnQgYXJyYXkgc3Vic2NyaXB0ISkNCg0KVGhlIGFjdHVhbCBw
cm9ibGVtIHdpdGggdXNpbmcgb2Zmc2V0b2YoKSBpcyB0aGF0IHlvdSBtaWdodCBlbmQNCnVwIHdp
dGggc29tZXRoaW5nIHNtYWxsZXIgdGhhbiB0aGUgc3RydWN0dXJlIHNpemUuDQooV2hlbiB0aGUg
dmFyaWFibGUgc2l6ZWQgYXJyYXkgaXMgc21hbGxlciB0aGFuIHRoZSBwYWRkaW5nLikNCg0KV2hp
bGUgbWF4KCkgd2lsbCBnZW5lcmF0ZSBhIGNvbnN0YW50IGZvciBjb25zdGFudCBpbnB1dCwgaXQN
CndpbGwgYmUgYSByZWFsIGNvbXBhcmUgZm9yIG5vbi1jb25zdGFudCBpbnB1dC4NCg0KCURhdmlk
DQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBG
YXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2
IChXYWxlcykNCg==

