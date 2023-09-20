Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCDC7A79F5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbjITLDU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Sep 2023 07:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjITLDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:03:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CDB9E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 04:03:10 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-262-EgUX-j8ZPY-PRUixsIQ3Pw-1; Wed, 20 Sep 2023 12:02:56 +0100
X-MC-Unique: EgUX-j8ZPY-PRUixsIQ3Pw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 20 Sep
 2023 12:02:52 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 20 Sep 2023 12:02:51 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: RE: Buggy __free(kfree) usage pattern already in tree
Thread-Topic: Buggy __free(kfree) usage pattern already in tree
Thread-Index: AQHZ6zB0ngjqcerR/0+SR8HlhTcAlbAji3Fg
Date:   Wed, 20 Sep 2023 11:02:51 +0000
Message-ID: <a0ba32c892654a2bb60327e103d181fb@AcuMS.aculab.com>
References: <CACMJSevrJ5KSPAZVheXkNaYj8KQFD8ck55kU_E4vEj4vzR8wnQ@mail.gmail.com>
 <CAHk-=wicfvWPuRVDG5R1mZSxD8Xg=-0nLOiHay2T_UJ0yDX42g@mail.gmail.com>
 <20230915210851.GA23174@noisy.programming.kicks-ass.net>
 <CAHk-=whvOGL3aNhtps0YksGtzvaob_bvZpbaTcVEqGwNMxB6xg@mail.gmail.com>
 <20230915213231.GB23174@noisy.programming.kicks-ass.net>
 <CAHk-=wi08ZUguV_n88h=bP6X01-tah29RtB0t9TmXtyuEJev-Q@mail.gmail.com>
 <20230915221332.GC23174@noisy.programming.kicks-ass.net>
 <20230919125752.GA39346@noisy.programming.kicks-ass.net>
 <20230919125954.GB39346@noisy.programming.kicks-ass.net>
 <20230919131038.GC39346@noisy.programming.kicks-ass.net>
 <20230919193516.GA20937@noisy.programming.kicks-ass.net>
In-Reply-To: <20230919193516.GA20937@noisy.programming.kicks-ass.net>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If this stuff is so hard to get right for non-trivial cases
perhaps it should all be ripped out?

The trivial cases are pretty easy to eve-ball check and
static analysis tools do a reasonable job.

Maybe I'm 'old-school' but I'd much rather see explicit
unlock() and free() than have 'some compiler magic' do
it for you.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

