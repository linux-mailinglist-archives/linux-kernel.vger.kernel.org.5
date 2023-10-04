Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B41F7B7A00
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 10:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241670AbjJDI06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 04:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbjJDI04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 04:26:56 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D71883
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 01:26:53 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-113-q5QtC5zAO-CR-mafjpfTEQ-1; Wed, 04 Oct 2023 09:26:50 +0100
X-MC-Unique: q5QtC5zAO-CR-mafjpfTEQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 4 Oct
 2023 09:26:49 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 4 Oct 2023 09:26:49 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     =?utf-8?B?J0Nsw6ltZW50IEzDqWdlcic=?= <cleger@rivosinc.com>,
        Conor Dooley <conor@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?utf-8?B?QmrDtnJuIFRvcGVs?= <bjorn@rivosinc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>
Subject: RE: [PATCH 0/7] Add support to handle misaligned accesses in S-mode
Thread-Topic: [PATCH 0/7] Add support to handle misaligned accesses in S-mode
Thread-Index: AQHZ9QOtGOYrq2j5KUyBiWVh/MP2XrA5TUKA
Date:   Wed, 4 Oct 2023 08:26:49 +0000
Message-ID: <eb9dcaaf313642b096d68df4b92e7466@AcuMS.aculab.com>
References: <20230926150316.1129648-1-cleger@rivosinc.com>
 <20230930-patchy-curdle-ef5ee6e1a17c@spud>
 <8ce6cd97-6d63-4174-a290-40690c81e205@rivosinc.com>
In-Reply-To: <8ce6cd97-6d63-4174-a290-40690c81e205@rivosinc.com>
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

RnJvbTogQ2zDqW1lbnQgTMOpZ2VyDQo+IFNlbnQ6IDAyIE9jdG9iZXIgMjAyMyAwODo0MA0KPiAN
Cj4gT24gMzAvMDkvMjAyMyAxMToyMywgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiA+IE9uIFR1ZSwg
U2VwIDI2LCAyMDIzIGF0IDA1OjAzOjA5UE0gKzAyMDAsIENsw6ltZW50IEzDqWdlciB3cm90ZToN
Cj4gPj4gU2luY2UgY29tbWl0IDYxY2FkYjkgKCJQcm92aWRlIG5ldyBkZXNjcmlwdGlvbiBvZiBt
aXNhbGlnbmVkIGxvYWQvc3RvcmUNCj4gPj4gYmVoYXZpb3IgY29tcGF0aWJsZSB3aXRoIHByaXZp
bGVnZWQgYXJjaGl0ZWN0dXJlLiIpIGluIHRoZSBSSVNDLVYgSVNBDQo+ID4+IG1hbnVhbCwgaXQg
aXMgc3RhdGVkIHRoYXQgbWlzYWxpZ25lZCBsb2FkL3N0b3JlIG1pZ2h0IG5vdCBiZSBzdXBwb3J0
ZWQuDQo+ID4+IEhvd2V2ZXIsIHRoZSBSSVNDLVYga2VybmVsIHVBQkkgZGVzY3JpYmVzIHRoYXQg
bWlzYWxpZ25lZCBhY2Nlc3NlcyBhcmUNCj4gPj4gc3VwcG9ydGVkLg0KLi4uDQoNClRoYXQgaXQg
anVzdCByZWFsbHkgaG9ycmlkLg0KSWYgdGhlIGNwdSBpcyBnb2luZyB0byB0cmFwIG1pc2FsaWdu
ZWQgYWNjZXNzZXMgdGhlbiB5b3Ugd2FudA0KVGhlIGNvbXBpbGVyIGdlbmVyYXRlZCBjb2RlIChp
ZSBwYWNrZWQgZGF0YSkgbm90IHRvIGdlbmVyYXRlDQptaXNhbGlnbmVkIGFjY2Vzc2VzLg0KU28g
eW91IGhhdmUgdG8gY2hhbmdlIHRoZSBrZXJuZWwgdUFCSS4NCg0KT1RPSCBpZiB5b3Uga25vd24g
dGhhdCBzdWNoIGFjY2Vzc2VzIHdvbid0IGZhdWx0IGFuZCB3aWxsIGJlDQpub3QgcmVhbGx5IHNs
b3dlciB0aGFuIGFsaWduZWQgYWNjZXNzZXMgdGhlbiBvcHRpbWlzZWQgdmVyc2lvbnMNCm9mIHNv
bWUgZnVuY3Rpb25zIChsaWtlIG1lbWNweSBhbmQgY2hlY2tzdW1zKSBjYW4gdXNlIG1pc2FsaWdu
ZWQNCmFjY2Vzc2VzLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRl
LCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpS
ZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

