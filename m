Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93540769792
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjGaN1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbjGaN1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:27:46 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD3319A3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 06:27:24 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-29-J0C5Am00Mue96-CayWZXzA-1; Mon, 31 Jul 2023 14:26:55 +0100
X-MC-Unique: J0C5Am00Mue96-CayWZXzA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 31 Jul
 2023 14:26:54 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 31 Jul 2023 14:26:54 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Andy Shevchenko'" <andriy.shevchenko@linux.intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
        'Christoph Hellwig' <hch@infradead.org>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>
CC:     'Nathan Chancellor' <nathan@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [PATCH next v2 5/5] minmax: Relax check to allow comparison
 between int and small unsigned constants.
Thread-Topic: [PATCH next v2 5/5] minmax: Relax check to allow comparison
 between int and small unsigned constants.
Thread-Index: AQHZwWNPMLQeS+3oD0yU5qzbmq+nnq/T3YRw
Date:   Mon, 31 Jul 2023 13:26:54 +0000
Message-ID: <9c14002108ff49e1a54819133fe9e2a3@AcuMS.aculab.com>
References: <bde3d2dc933848bbaceeb9b7102f6f4c@AcuMS.aculab.com>
 <b4ce9dad748e489f9314a2dc95615033@AcuMS.aculab.com>
In-Reply-To: <b4ce9dad748e489f9314a2dc95615033@AcuMS.aculab.com>
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
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QnkgdGhlIHRpbWUgSSd2ZSBkb25lOg0KDQojZGVmaW5lIF9faXNfbm9uZWdfaW50KHgpCQkJCQlc
DQoJX19idWlsdGluX2Nob29zZV9leHByKCFfX2lzX2NvbnN0ZXhwcih4KSwgZmFsc2UsIAlcDQoJ
CSgoeCkgPj0gKHR5cGVvZih4KSkwICYmICh4KSA8PSAodHlwZW9mKCh4KSArIDApKShsb25nKV9f
SU5UX01BWF9fKSkNCg0KI2RlZmluZSBfX2lzX3NpZ25lZCh4KSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAgICBfX2J1aWx0aW5f
Y2hvb3NlX2V4cHIoX19pc19jb25zdGV4cHIoaXNfc2lnbmVkX3R5cGUodHlwZW9mKHgpKSksICAg
ICAgICBcDQogICAgICAgICAgICAgICBpc19zaWduZWRfdHlwZSh0eXBlb2YoeCkpLCAwKQ0KDQoj
ZGVmaW5lIF9fdHlwZXNfb2soeCwgeSkgCQkJCQlcDQoJKF9faXNfc2lnbmVkKHgpID09IF9faXNf
c2lnbmVkKHkpIHx8CQkJXA0KCQlfX2lzX3NpZ25lZCgoeCkgKyAwKSA9PSBfX2lzX3NpZ25lZCgo
eSkgKyAwKSB8fAlcDQoJCV9faXNfbm9uZWdfaW50KHgpIHx8IF9faXNfbm9uZWdfaW50KHkpKQ0K
DQp0aGUgZXJyb3IgbWVzc2FnZSBmb3INCg0KPiAgCXN0YXRpY19hc3NlcnQoX190eXBlc19vayh4
LCB5KSwJCQlcDQo+ICAJCSNvcCAiKCIgI3ggIiwgIiAjeSAiKSBzaWduZWRuZXNzIGVycm9yLCBm
aXggdHlwZXMgb3IgY29uc2lkZXIgIiAjb3AgIl91bnNpZ25lZCgpIGJlZm9yZSAiICNvcCAiX3Qo
KSIpOyBcDQoNCmdlbmVyYXRlZCBieSBjbGFuZyA4LjAuMCBhbmQgbGF0ZXIgaXMgc2ltaWxhciB0
byAoc2VlIGh0dHBzOi8vZ29kYm9sdC5vcmcvei9qcTYxM0duc2EpOg0KDQo8c291cmNlPjo0OTox
MjogZXJyb3I6IHN0YXRpYyBhc3NlcnRpb24gZmFpbGVkIGR1ZSB0byByZXF1aXJlbWVudCAnX19i
dWlsdGluX2Nob29zZV9leHByKChzaXplb2YoaW50KSA9PSBzaXplb2YgKCooOCA/ICgodm9pZCAq
KSgobG9uZykoKCgoaW50KSgtMSkpIDwgKGludCkxKSkgKiAwTCkpIDogKGludCAqKTgpKSksICgo
KGludCkoLTEpKSA8IChpbnQpMSksIDApID09IF9fYnVpbHRpbl9jaG9vc2VfZXhwcigoc2l6ZW9m
KGludCkgPT0gc2l6ZW9mICgqKDggPyAoKHZvaWQgKikoKGxvbmcpKCgoKHVuc2lnbmVkIGludCko
LTEpKSA8ICh1bnNpZ25lZCBpbnQpMSkpICogMEwpKSA6IChpbnQgKik4KSkpLCAoKCh1bnNpZ25l
ZCBpbnQpKC0xKSkgPCAodW5zaWduZWQgaW50KTEpLCAwKSB8fCBfX2J1aWx0aW5fY2hvb3NlX2V4
cHIoKHNpemVvZihpbnQpID09IHNpemVvZiAoKig4ID8gKCh2b2lkICopKChsb25nKSgoKChpbnQp
KC0xKSkgPCAoaW50KTEpKSAqIDBMKSkgOiAoaW50ICopOCkpKSwgKCgoaW50KSgtMSkpIDwgKGlu
dCkxKSwgMCkgPT0gX19idWlsdGluX2Nob29zZV9leHByKChzaXplb2YoaW50KSA9PSBzaXplb2Yg
KCooOCA/ICgodm9pZCAqKSgobG9uZykoKCgodW5zaWduZWQgaW50KSgtMSkpIDwgKHVuc2lnbmVk
IGludCkxKSkgKiAwTCkpIDogKGludCAqKTgpKSksICgoKHVuc2lnbmVkIGludCkoLTEpKSA8ICh1
bnNpZ25lZCBpbnQpMSksIDApIHx8IChfX2J1aWx0aW5fY2hvb3NlX2V4cHIoIShzaXplb2YoaW50
KSA9PSBzaXplb2YgKCooOCA/ICgodm9pZCAqKSgobG9uZykoYSkgKiAwTCkpIDogKGludCAqKTgp
KSksIDAsIF9fYnVpbHRpbl9jaG9vc2VfZXhwcihfX2J1aWx0aW5fY2hvb3NlX2V4cHIoKHNpemVv
ZihpbnQpID09IHNpemVvZiAoKig4ID8gKCh2b2lkICopKChsb25nKSgoKChpbnQpKC0xKSkgPCAo
aW50KTEpKSAqIDBMKSkgOiAoaW50ICopOCkpKSwgKCgoaW50KSgtMSkpIDwgKGludCkxKSwgMCks
IGEsIDApID49IDAgJiYgKGEpIDw9IChpbnQpKGxvbmcpMjE0NzQ4MzY0NykpIHx8IChfX2J1aWx0
aW5fY2hvb3NlX2V4cHIoIShzaXplb2YoaW50KSA9PSBzaXplb2YgKCooOCA/ICgodm9pZCAqKSgo
bG9uZykoMjE0NzQ4MzY0OFUgLSAwKSAqIDBMKSkgOiAoaW50ICopOCkpKSwgMCwgX19idWlsdGlu
X2Nob29zZV9leHByKF9fYnVpbHRpbl9jaG9vc2VfZXhwcigoc2l6ZW9mKGludCkgPT0gc2l6ZW9m
ICgqKDggPyAoKHZvaWQgKikoKGxvbmcpKCgoKHVuc2lnbmVkIGludCkoLTEpKSA8ICh1bnNpZ25l
ZCBpbnQpMSkpICogMEwpKSA6IChpbnQgKik4KSkpLCAoKCh1bnNpZ25lZCBpbnQpKC0xKSkgPCAo
dW5zaWduZWQgaW50KTEpLCAwKSwgMjE0NzQ4MzY0OFUgLSAwLCAwKSA+PSAwICYmICgyMTQ3NDgz
NjQ4VSAtIDApIDw9ICh1bnNpZ25lZCBpbnQpKGxvbmcpMjE0NzQ4MzY0NykpJzogbWluKGEsIDB4
ODAwMDAwMDB1IC0gMCkgc2lnbmVkbmVzcyBlcnJvciwgZml4IHR5cGVzIG9yIGNvbnNpZGVyIG1p
bl91bnNpZ25lZCgpIGJlZm9yZSBtaW5fdCgpDQoNClJlcGVhdGluZyB0aGUgZXhwcmVzc2lvbiBz
ZWVtcyBzb21ld2hhdCBzdWItb3B0aW1hbCENClN1cmVseSBpdCBzaG91bGRuJ3QgYmUgb3V0cHV0
dGluZyB0aGUgZXhwYW5zaW9uIG9mIHRoZQ0KaW5wdXQgd2hlbiBhbiBlcnJvciBtZXNzYWdlIGlz
IHN1cHBsaWVkPw0KDQpJcyB0aGVyZSBhbnkgKHNhbmUpIHdheSB0byBzdG9wIGl0IGJlaW5nIHRo
YXQgdmVyYm9zZT8NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

