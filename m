Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7092A76868D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 18:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjG3Q4C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 30 Jul 2023 12:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjG3Q4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 12:56:01 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D7A10C2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 09:55:59 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-72-eY2T3pPnPJSSwBaPh9habg-1; Sun, 30 Jul 2023 17:55:53 +0100
X-MC-Unique: eY2T3pPnPJSSwBaPh9habg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 30 Jul
 2023 17:55:52 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 30 Jul 2023 17:55:52 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'kernel test robot' <lkp@intel.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
        'Christoph Hellwig' <hch@infradead.org>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>
CC:     "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "Linux Memory Management List" <linux-mm@kvack.org>
Subject: RE: [PATCH next v2 5/5] minmax: Relax check to allow comparison
 between int and small unsigned constants.
Thread-Topic: [PATCH next v2 5/5] minmax: Relax check to allow comparison
 between int and small unsigned constants.
Thread-Index: AdnBY0Y9GCHZV09FSTWgIDzdl1LkkgAMN6AAAFxzVbA=
Date:   Sun, 30 Jul 2023 16:55:52 +0000
Message-ID: <9b85dfdbf967418a8be605bd0e6a8c52@AcuMS.aculab.com>
References: <b4ce9dad748e489f9314a2dc95615033@AcuMS.aculab.com>
 <202307290538.EtRKfGgC-lkp@intel.com>
In-Reply-To: <202307290538.EtRKfGgC-lkp@intel.com>
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
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kernel test robot
> Sent: 28 July 2023 22:43
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on akpm-mm/mm-everything]
> [also build test WARNING on linus/master crng-random/master v6.5-rc3 next-20230728]
> [cannot apply to next-20230728]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/David-Laight/minmax-Add-min_unsigned-a-b-and-
> max_unsigned-a-b/20230728-225439
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/b4ce9dad748e489f9314a2dc95615033%40AcuMS.aculab.com
> patch subject: [PATCH next v2 5/5] minmax: Relax check to allow comparison between int and small
> unsigned constants.
> config: alpha-randconfig-r024-20230727 (https://download.01.org/0day-
> ci/archive/20230729/202307290538.EtRKfGgC-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230729/202307290538.EtRKfGgC-
> lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202307290538.EtRKfGgC-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/kernel.h:27,
>                     from include/linux/cpumask.h:10,
>                     from include/linux/mm_types_task.h:14,
>                     from include/linux/mm_types.h:5,
>                     from include/linux/buildid.h:5,
>                     from include/linux/module.h:14,
>                     from net/ceph/osdmap.c:5:
>    net/ceph/osdmap.c: In function 'osdmap_decode':
> >> include/linux/minmax.h:26:22: warning: ordered comparison of pointer with null pointer [-Wextra]
>       26 |                 ((x) >= (typeof(x))0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))

I have a cunning plan to fix this (and warnings about testing 'unsigned >= 0').
Basically replace the first test with:
	__builtin_choose_expr(is_signed(x), x, 1) >= 0

(Also fixes the build with clang < 16.)

Hopefully that v3 will keep the build robert happy :-)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

