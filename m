Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DF17B15BB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbjI1IKd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Sep 2023 04:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjI1IKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:10:31 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0486398
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:10:28 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-62-3tc3rinCOTiYPv2jxlrRfw-1; Thu, 28 Sep 2023 09:10:10 +0100
X-MC-Unique: 3tc3rinCOTiYPv2jxlrRfw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 28 Sep
 2023 09:10:09 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 28 Sep 2023 09:10:09 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andrew Morton' <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
        'Christoph Hellwig' <hch@infradead.org>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>
Subject: RE: [PATCH next v4 0/5] minmax: Relax type checks in min() and max().
Thread-Topic: [PATCH next v4 0/5] minmax: Relax type checks in min() and
 max().
Thread-Index: AdnqB/CwAvMQ3gkdSO607JUF4aSKdgHV/OwAACCvOXA=
Date:   Thu, 28 Sep 2023 08:10:09 +0000
Message-ID: <0b03cbd61c104b1db0848f3ad900a2ea@AcuMS.aculab.com>
References: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
 <20230927103014.683e41b855cb2cd4ea163fa5@linux-foundation.org>
In-Reply-To: <20230927103014.683e41b855cb2cd4ea163fa5@linux-foundation.org>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton
> Sent: 27 September 2023 18:30
> 
> On Mon, 18 Sep 2023 08:14:40 +0000 David Laight <David.Laight@ACULAB.COM> wrote:
> 
> > A quick grep shows 5734 min() and 4597 min_t().
> > Having the casts on almost half of the calls shows that something
> > is clearly wrong.

Thanks for taking these.
I had a horrid thought they were languishing again.

> My preferred approach to fixing min() warnings is "the types are wrong".
> But often getting the types better is hard.
> 
> Is there a plan afoot to go around existing code doing some
> min_t()->min() conversions?

Could get tedious given there are 4500+ min_t() out there.
Also every one needs looking at just to check it isn't relying
on the cast - a few do,

But they could get reduced slowly.
Not adding more would be a bonus!

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

