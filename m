Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF86E7C6FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378971AbjJLNyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbjJLNyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:54:14 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9676BBE
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:54:11 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-143-1Z-BVDMOMH6eCM4V0M_dXw-1; Thu, 12 Oct 2023 14:54:07 +0100
X-MC-Unique: 1Z-BVDMOMH6eCM4V0M_dXw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 12 Oct
 2023 14:54:06 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 12 Oct 2023 14:54:06 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexey Dobriyan' <adobriyan@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: RE: [PATCH] fs: move and constify sysctl_nr_open_min,
 sysctl_nr_open_max
Thread-Topic: [PATCH] fs: move and constify sysctl_nr_open_min,
 sysctl_nr_open_max
Thread-Index: AQHZ/HAt7Icw5TmRtk6309iepUgEDbBGK5FQ
Date:   Thu, 12 Oct 2023 13:54:06 +0000
Message-ID: <9b23bb6bcabe4f419cb8510e99275085@AcuMS.aculab.com>
References: <02591c1e-936b-46bf-ad2b-402b33338eee@p183>
In-Reply-To: <02591c1e-936b-46bf-ad2b-402b33338eee@p183>
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

RnJvbTogQWxleGV5IERvYnJpeWFuDQo+IFNlbnQ6IDExIE9jdG9iZXIgMjAyMyAxOToyNA0KPiAN
Cj4gc3lzY3RsX25yX29wZW5fbWluLCBzeXNjdGxfbnJfb3Blbl9tYXggdmFyaWFibGVzIGFyZSBy
ZWFsbHkgaGFyZCBsaW1pdHMNCj4gb24gZnMubnJfb3BlbiBzeXNjdGwsIHRoZXkgYXJlbid0IGlu
dGVyZXN0aW5nIHRvIHRoZSByZXN0IG9mIHRoZSBjb2RlDQo+IGFuZCBhcmUgY29uc3RhbnRzIChz
eXNjdGxfbnJfb3BlbiBpcyBub3QgY29uc3RhbnQgb2J2aW91c2x5KS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEFsZXhleSBEb2JyaXlhbiA8YWRvYnJpeWFuQGdtYWlsLmNvbT4NCj4gLS0tDQo+IA0K
PiAgZnMvZmlsZS5jICAgICAgICAgICAgfCAgICA1IC0tLS0tDQo+ICBmcy9maWxlX3RhYmxlLmMg
ICAgICB8ICAgMTAgKysrKysrKystLQ0KPiAgaW5jbHVkZS9saW51eC9maWxlLmggfCAgICAyIC0t
DQo+ICAzIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4g
DQo+IC0tLSBhL2ZzL2ZpbGUuYw0KPiArKysgYi9mcy9maWxlLmMNCj4gQEAgLTI1LDExICsyNSw2
IEBADQo+ICAjaW5jbHVkZSAiaW50ZXJuYWwuaCINCj4gDQo+ICB1bnNpZ25lZCBpbnQgc3lzY3Rs
X25yX29wZW4gX19yZWFkX21vc3RseSA9IDEwMjQqMTAyNDsNCj4gLXVuc2lnbmVkIGludCBzeXNj
dGxfbnJfb3Blbl9taW4gPSBCSVRTX1BFUl9MT05HOw0KPiAtLyogb3VyIG1pbigpIGlzIHVudXNh
YmxlIGluIGNvbnN0YW50IGV4cHJlc3Npb25zIDstLyAqLw0KPiAtI2RlZmluZSBfX2NvbnN0X21p
bih4LCB5KSAoKHgpIDwgKHkpID8gKHgpIDogKHkpKQ0KPiAtdW5zaWduZWQgaW50IHN5c2N0bF9u
cl9vcGVuX21heCA9DQo+IC0JX19jb25zdF9taW4oSU5UX01BWCwgfihzaXplX3QpMC9zaXplb2Yo
dm9pZCAqKSkgJiAtQklUU19QRVJfTE9ORzsNCj4gDQo+ICBzdGF0aWMgdm9pZCBfX2ZyZWVfZmR0
YWJsZShzdHJ1Y3QgZmR0YWJsZSAqZmR0KQ0KPiAgew0KPiAtLS0gYS9mcy9maWxlX3RhYmxlLmMN
Cj4gKysrIGIvZnMvZmlsZV90YWJsZS5jDQo+IEBAIC0xMTEsNiArMTExLDEyIEBAIHN0YXRpYyBp
bnQgcHJvY19ucl9maWxlcyhzdHJ1Y3QgY3RsX3RhYmxlICp0YWJsZSwgaW50IHdyaXRlLCB2b2lk
ICpidWZmZXIsDQo+ICAJcmV0dXJuIHByb2NfZG91bG9uZ3ZlY19taW5tYXgodGFibGUsIHdyaXRl
LCBidWZmZXIsIGxlbnAsIHBwb3MpOw0KPiAgfQ0KPiANCj4gK3N0YXRpYyBjb25zdCB1bnNpZ25l
ZCBpbnQgc3lzY3RsX25yX29wZW5fbWluID0gQklUU19QRVJfTE9ORzsNCj4gKy8qIG91ciBtaW4o
KSBpcyB1bnVzYWJsZSBpbiBjb25zdGFudCBleHByZXNzaW9ucyA7LS8gKi8NCj4gKyNkZWZpbmUg
X19jb25zdF9taW4oeCwgeSkgKCh4KSA8ICh5KSA/ICh4KSA6ICh5KSkNCj4gK3N0YXRpYyBjb25z
dCB1bnNpZ25lZCBpbnQgc3lzY3RsX25yX29wZW5fbWF4ID0NCj4gKwlfX2NvbnN0X21pbihJTlRf
TUFYLCB+KHNpemVfdCkwL3NpemVvZih2b2lkICopKSAmIC1CSVRTX1BFUl9MT05HOw0KDQpJIHRo
aW5rIHlvdSdsbCBmaW5kIHRoYXQgbWluKCkgaXMgZmluZS4NCg0KQWx0aG91Z2ggdGhvc2UgdXBw
ZXIgbGltaXRzIGxvb2sgc3VzcGVjdCB0byBtZS4NCkxvb2tzIGxpa2UgfjAuNUcgb24gMzJiaXQg
YW5kIH4yRyBvbiA2NGJpdCBiYXNlZCBvbiB0aGUgc2l6ZSBvZiBhIGJpdG1hcD8NCkJ1dCB0aGUg
a2VybmVsIHdpbGwgcnVuIG91dCBvZiBhZGRyZXNzIHNwYWNlIG11Y2ggZWFybGllciAtIGVzcCBv
biAzMmJpdC4NCg0KCURhdmlkDQoNCiANCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRl
LCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpS
ZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

