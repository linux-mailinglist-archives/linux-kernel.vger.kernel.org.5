Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A587F182A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjKTQIk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Nov 2023 11:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjKTQIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:08:39 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D16E7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:08:34 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-27-vLVux7jWOF6nLYmEF7DxSQ-1; Mon, 20 Nov 2023 16:08:31 +0000
X-MC-Unique: vLVux7jWOF6nLYmEF7DxSQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 20 Nov
 2023 16:09:02 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 20 Nov 2023 16:09:02 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Howells' <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
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
Thread-Index: AQHaG7YSFfqMOen5JUCwmbDFX2u0nbCDUWGA
Date:   Mon, 20 Nov 2023 16:09:02 +0000
Message-ID: <ade6cd8de43b492589125295c3bc88d5@AcuMS.aculab.com>
References: <CAHk-=wiRQHD5xnB8H9Lwk9fJPDpfVNAwPS4KLnfrcrU3zbMAdQ@mail.gmail.com>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
 <20231115190938.GGZVUXcuUjI3i1JRAB@fat_crate.local>
 <CAHk-=wh0TcXyGmKHfs+Xe=5Sd5bNn=NNV9CEtOy_tbyHAAmk9g@mail.gmail.com>
 <232440.1700153046@warthog.procyon.org.uk>
 <864270.1700230337@warthog.procyon.org.uk>
 <20231117160940.GGZVeQRLgLjJZXBLE1@fat_crate.local>
 <CAHk-=wj33FoGBQ7HkqjLbyOBQogWpYAG7WUTXatcfBF5duijjQ@mail.gmail.com>
 <CAHk-=whLbJ7vvB1ACVC6t44zjihX8w7GMY2y584+Fm83rsmaKg@mail.gmail.com>
 <20231117191243.GHZVe7K4vN9n5M92gb@fat_crate.local>
 <2284219.1700487177@warthog.procyon.org.uk>
In-Reply-To: <2284219.1700487177@warthog.procyon.org.uk>
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
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells 
> Sent: 20 November 2023 13:33
> 
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > So I don't think we should use either of these benchmarks as a "we
> > need to optimize for *this*", but it is another example of how much
> > memcpy() does matter. Even if the end result is then "but different
> > microarchitectrues react so differently that we can't please
> > everybody".
> 
> So what, if anything, should I change?  Should I make it directly call
> __memcpy?  Or should we just leave it to the compiler?  I would prefer to
> leave memcpy_from_iter() and memcpy_to_iter() as __always_inline to eliminate
> the function pointer call we otherwise end up with and to eliminate the return
> value (which is always 0 in this case).

I'd have thought you'd just want to call memcpy() (or xxxx_memcpy())
Anything that matters here is likely to make more difference elsewhere.

I wonder if the kernel ever uses the return value from memcpy().
I suspect it only exists for very historic reasons.

The wrapper:
#define memcpy(d, s, l) {( \
	const void *dd = d; \
	memcpy_void(dd, s, l); \
	dd; \
)}
would save all the asm implementations from saving the result.

I did some more measurements over the weekend.
A quick summary - I've not quite finished (and need to find some
more test systems - newer and amd).
I'm now thinking that the 5k clocks is a TLB miss.
In any case it is a feature of my test not the instruction.
I'm also subtracting off a baseline that has 'nop; nop' not 'rep movsb'.

I'm not entirely certain about the fractional clocks!
I counting 10 operations and getting pretty consistent counts.
I suspect they are end effects.

These measurements are also for 4k aligned src and dest.

An ivy bridge i7-3xxx seems to do:
      0	41.4 clocks
   1-64	31.5 clocks
  65-128	44.3
 129-191	55.1
     192	47.4
 193-255	58.8
then an extra 3 clocks every 64 bytes.

Whereas kaby lake i7-7xxx does:
     0	51.5 clocks
  1-64	22.9
 65-95	25.3
    96	30.5
 97-127	34.1
    128	31.5
then an extra clock every 32 bytes (if dest aligned).

Note that this system is somewhat slower if the destination
is less than (iirc) 48 bytes before the source (mod 4k).
There are several different slow speeds worst is about half
the speed.

I might be able to find a newer system with fsrm.

I was going to measure orig_memcpy() and also see what I can write.
Both those cpu can do a read and write every clock.
So a 64bit copy loop can execute at 8 bytes/clock.
It should be possible to get a 2 clock loop copying 16 bytes.
But that will need a few instructions to setup.
You need to use negative offsets from the end so that only
one register is changed and the 'add' sets Z for the jump.
It can be written in C - but gcc will pessimise it for you.

You also need a conditional branch for short copies (< 16 bytes)
that could easily be mispredicted pretty much 50% of the time.
(IIRC no static prediction on recent x86 cpu.)
And probably a separate test for 0.
It is hard genning a sane clock count for short copies because
the mispredicted branches kill you.
Trouble is any benchmark measurement is likely to train the
branch predictor.
It might actually be hard to reliably beat the ~20 clocks
for 'rep movsb' on kaby lake.

This graph is from the fsrm patch:

Time (cycles) for memmove() sizes 1..31 with neither source nor
destination in cache.

  1800 +-+-------+--------+---------+---------+---------+--------+-------+-+
       +         +        +         +         +         +        +         +
  1600 +-+                                          'memmove-fsrm' *******-+
       |   ######                                   'memmove-orig' ####### |
  1400 +-+ #     #####################                                   +-+
       |   #                          ############                         |
  1200 +-+#                                       ##################     +-+
       |  #                                                                |
  1000 +-+#                                                              +-+
       |  #                                                                |
       | #                                                                 |
   800 +-#                                                               +-+
       | #                                                                 |
   600 +-***********************                                         +-+
       |                        *****************************              |
   400 +-+                                                   *******     +-+
       |                                                                   |
   200 +-+                                                               +-+
       +         +        +         +         +         +        +         +
     0 +-+-------+--------+---------+---------+---------+--------+-------+-+
       0         5        10        15        20        25       30        35

I don't know what that was measured on.
600 clocks seems a lot - could be dominated by loading the cache.
I'd have thought short buffers are actually likely to be in the cache
and/or wanted in it.

There is also the lack of 'rep movsb' on erms (on various cpu).

	David

	

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

