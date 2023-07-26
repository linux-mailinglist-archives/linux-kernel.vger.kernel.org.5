Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4769D763225
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbjGZJbS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jul 2023 05:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjGZJaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:30:39 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3049B97
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:29:20 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-278-BHox4q11P9-e6xJhB7caqw-1; Wed, 26 Jul 2023 10:29:17 +0100
X-MC-Unique: BHox4q11P9-e6xJhB7caqw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 26 Jul
 2023 10:29:15 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 26 Jul 2023 10:29:15 +0100
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
Subject: RE: [PATCH next resend 5/5] minmax: Relax check to allow comparison
 between int and small unsigned constants.
Thread-Topic: [PATCH next resend 5/5] minmax: Relax check to allow comparison
 between int and small unsigned constants.
Thread-Index: Adm+7rJ87D8nFkT9Rp6d+7ZLnF7rBgAODzmAAB8QSKA=
Date:   Wed, 26 Jul 2023 09:29:15 +0000
Message-ID: <4520ae6dc8b447cbaa77be0cdea79986@AcuMS.aculab.com>
References: <48c2cd0407f14859919d4fcbe526234a@AcuMS.aculab.com>
 <202307260303.3ftEpZRU-lkp@intel.com>
In-Reply-To: <202307260303.3ftEpZRU-lkp@intel.com>
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
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kernel test robot <lkp@intel.com>
> Sent: 25 July 2023 20:37
> 
...
>    drivers/gpu/drm/drm_modes.c: In function 'drm_mode_parse_command_line_for_connector':
> >> include/linux/minmax.h:23:22: warning: ordered comparison of pointer with integer zero [-Wextra]
>       23 |                 ((x) >= 0 && (x) <= (typeof((x) + 0))(long)__INT_MAX__))
>          |                      ^~
...
>    drivers/gpu/drm/drm_modes.c:2474:29: note: in expansion of macro 'max'
>     2474 |                 extra_ptr = max(bpp_end_ptr, refresh_end_ptr);
>          |                             ^~~

There are a handful of annoying uses of min/max with pointers.
I'll fix this in v2 by adding a cast to the 0.
(I was expecting an error for unsigned types.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

