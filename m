Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB6978B5F7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbjH1RGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjH1RGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:06:14 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80726B4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:06:10 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-256-pYhJ4W3RNxO8_bT6JmDMwg-1; Mon, 28 Aug 2023 18:06:07 +0100
X-MC-Unique: pYhJ4W3RNxO8_bT6JmDMwg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 28 Aug
 2023 18:06:11 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 28 Aug 2023 18:06:11 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joshua Hudson' <joshudson@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: System Call trashing registers
Thread-Topic: System Call trashing registers
Thread-Index: AQHZ1qZJOhxdvboJAEStlBKVyiUHUq//9J2w
Date:   Mon, 28 Aug 2023 17:06:10 +0000
Message-ID: <c3b9a46e2cf44ff1a08efadde68248b2@AcuMS.aculab.com>
References: <CA+jjjYQWeqDY3EFQWmVzV2pXyhfRaHm6s-XWYSXfe1CxvkeuEQ@mail.gmail.com>
In-Reply-To: <CA+jjjYQWeqDY3EFQWmVzV2pXyhfRaHm6s-XWYSXfe1CxvkeuEQ@mail.gmail.com>
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

RnJvbTogSm9zaHVhIEh1ZHNvbg0KPiBTZW50OiAyNCBBdWd1c3QgMjAyMyAxNzoxNQ0KPiANCj4g
MSkgQSBsb3Qgb2YgbXkgb2xkIDMyLWJpdCBwcm9ncmFtcyBkb24ndCB3b3JrIG9uIHg2NCBsaW51
eCBhbnltb3JlDQo+IGJlY2F1c2UgaW50IDgwaCBub3cgdHJhc2hlcyBlY3ggYW5kIGVkeC4gVGhp
cyBoYXNuJ3QgYmVlbiBhIHNlcmlvdXMNCj4gcHJvYmxlbSBmb3IgbWUuDQoNCkFyZW4ndCBib3Ro
IGVjeCBhbmQgZWR4IGNhbGxlciBzYXZlZD8NClNvIGlmIHRoZSBjb2RlIGlzIHVzaW5nIGFzbSBz
eXNjYWxsIHdyYXBwZXJzIHByb3ZpZGVkIHRoZSBhc20NCndyYXBwZXJzIGRvbid0IGV4cGVjdCB0
aGUgcmVnaXN0ZXJzIGJlIHNhdmVkICh3aGljaCBpcyB1bmxpa2VseSkNCnRoZW4gaXQgaXMgc2Fm
ZSBmb3IgdGhlIGtlcm5lbCB0byB0cmFzaCB0aGVtLg0KDQpPVE9IIEkgaGF2ZSBzZWVuIGNvZGUg
Y29tcGlsZWQgd2l0aCBpbmxpbmVkIHN5c2NhbGwgY29kZQ0KKGJ1dCBub3QgcmVjZW50bHkpLiBJ
biB0aGF0IGNhc2UgaXQgd2lsbCBtYXR0ZXIuDQoNCkl0IGdldHMgbW9yZSBpbnRlcmVzdGluZyB3
aXRoIGFsbCB0aGUgeG1tL3ltbS96bW0gcmVnaXN0ZXJzLg0KVGhleSBhcmUgYWxzbyBhbGwgY2Fs
bGVyIHNhdmVkLCBzbyBpZiB0aGUgY29tcGlsZXIgYWx3YXlzDQpzZWVzIGEgcmVhbCBmdW5jdGlv
biBjYWxsIHdyYXBwaW5nIGEgc3lzdGVtIGNhbGwgdGhlbiB0aGUga2VybmVsDQpuZWVkIG5vdCBz
YXZlIHRoZW0gYW5kIGNhbiByZXR1cm4gd2l0aCB0aGVtIGFsbCBzZXQgdG8gemVyby4NCg0KSSBk
b24ndCBiZWxpZXZlIHRoYXQgaXMgZG9uZSwgYnV0IGl0IGlzIGxpa2VseSB0byBiZSBhIG1lYXN1
cmFibGUNCnBlcmZvcm1hbmNlIGdhaW4gZm9yIG1vc3QgcHJvZ3JhbXMuDQoNCglEYXZpZA0KDQot
DQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwg
TWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2Fs
ZXMpDQo=

