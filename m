Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA7D770286
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjHDOEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjHDOEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:04:33 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1936E4221
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 07:04:25 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-110-pUaHoMmYOE-KUdavETQCrg-1; Fri, 04 Aug 2023 15:04:23 +0100
X-MC-Unique: pUaHoMmYOE-KUdavETQCrg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 4 Aug
 2023 15:04:21 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 4 Aug 2023 15:04:21 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Shrikanth Hegde' <sshegde@linux.vnet.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: RE: [RFC PATCH 1/1] sched: Extend cpu idle state for 1ms
Thread-Topic: [RFC PATCH 1/1] sched: Extend cpu idle state for 1ms
Thread-Index: AQHZv5lMP2TpQMbAnUKiWApLX9OqVa/aMadg
Date:   Fri, 4 Aug 2023 14:04:21 +0000
Message-ID: <f7627afa58294c4480d8f507ee792c2f@AcuMS.aculab.com>
References: <20230725193048.124796-1-mathieu.desnoyers@efficios.com>
 <69076f8e-191b-2e3e-d810-ea72d8ff18bb@linux.vnet.ibm.com>
In-Reply-To: <69076f8e-191b-2e3e-d810-ea72d8ff18bb@linux.vnet.ibm.com>
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

RnJvbTogU2hyaWthbnRoIEhlZ2RlDQo+IFNlbnQ6IDI2IEp1bHkgMjAyMyAwOTowNQ0KLi4uDQo+
ID4gKwlpZiAoc2NoZWRfY2xvY2soKSA8IFJFQURfT05DRShycS0+aWRsZV9lbmRfdGltZSkgKyBJ
RExFX0NQVV9ERUxBWV9OUykNCj4gDQo+IA0KPiBXb3VsZG4ndCB0aGlzIGh1cnQgdGhlIGxhdGVu
Y3kgYmFkbHk/IFNwZWNpYWxseSBvbiBhIGxvYWRlZCBzeXN0ZW0gd2l0aA0KPiBhIHdvcmtsb2Fk
IHRoYXQgZG9lcyBhIGxvdCBvZiB3YWtldXAuDQoNCkhhdmluZyBzcG90dGVkIHRoaXMgSSdtIGFs
c28gcmF0aGVyIHdvcnJpZWQgYWJvdXQgc3lzdGVtcw0KdGhhdCBhcmUgZG9pbmcgKGVnKSByZWFs
IHRpbWUgYXVkaW8gYW5kIG5lZWQgdG8gd2FrZXVwIGENCmxvdCBvZiB0aHJlYWRzIChsZXNzIHRo
YW4gdGhlIG51bWJlciBvZiBjcHUpIGV2ZXJ5IChzYXkpIDEwbXMuDQoNCkl0IGlzIGhhcmQgZW5v
dWdoIHdha2luZyB1cCBhIGxvdCBvZiB0aHJlYWRzIHF1aWNrbHkgd2l0aG91dA0KYW5vdGhlciAx
bXMgZGVsYXkgYmVpbmcgYWRkZWQuDQooSSdtIG9ubHkgdGFsa2luZyBhYm91dCAzMCB0aHJlYWRz
IGFzIHdlbGwsIG5vdCAzMDAuKQ0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExh
a2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQs
IFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

