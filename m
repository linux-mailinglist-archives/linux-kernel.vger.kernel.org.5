Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4867631BB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjGZJXM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jul 2023 05:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjGZJWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:22:54 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9822525B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:19:54 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-69-R1wwbrKTMx24VHmEivtBvw-1; Wed, 26 Jul 2023 10:19:49 +0100
X-MC-Unique: R1wwbrKTMx24VHmEivtBvw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 26 Jul
 2023 10:19:48 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 26 Jul 2023 10:19:48 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'kernel test robot' <lkp@intel.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
        'Christoph Hellwig' <hch@infradead.org>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        "'maz@kernel.org'" <maz@kernel.org>, Rob Herring <robh@kernel.org>
Subject: RE: [PATCH next resend 2/5] minmax: Allow min()/max()/clamp() if the
 arguments have the same signedness.
Thread-Topic: [PATCH next resend 2/5] minmax: Allow min()/max()/clamp() if the
 arguments have the same signedness.
Thread-Index: Adm+7j8pPhAgcq+TRICTXJcSfHQLRAAL9FKAACBy3mA=
Date:   Wed, 26 Jul 2023 09:19:48 +0000
Message-ID: <6bed42e871e74e898b400a404ec6d142@AcuMS.aculab.com>
References: <a09512c8526b46759669d0b879144563@AcuMS.aculab.com>
 <202307260256.nzImScXA-lkp@intel.com>
In-Reply-To: <202307260256.nzImScXA-lkp@intel.com>
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

> From: kernel test robot <lkp@intel.com>
> Sent: 25 July 2023 19:33
...
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/irqchip/irq-mips-cpu.c:288:1: error: call to undeclared function '__typecheck'; ISO C99 and
> later do not support implicit function declarations [-Wimplicit-function-declaration]
>      288 | IRQCHIP_DECLARE(cpu_intc, "mti,cpu-interrupt-controller", mips_cpu_irq_of_init);
>          | ^
>    include/linux/irqchip.h:37:38: note: expanded from macro 'IRQCHIP_DECLARE'
>       37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
>          |                                             ^
>    include/linux/irqchip.h:24:3: note: expanded from macro 'typecheck_irq_init_cb'
>       24 |         (__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
>          |          ^
> >> drivers/irqchip/irq-mips-cpu.c:288:1: error: initializer element is not a compile-time constant
>      288 | IRQCHIP_DECLARE(cpu_intc, "mti,cpu-interrupt-controller", mips_cpu_irq_of_init);
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/irqchip.h:37:2: note: expanded from macro 'IRQCHIP_DECLARE'
>       37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/of.h:1493:3: note: expanded from macro 'OF_DECLARE_2'
>     1493 |                 _OF_DECLARE(table, name, compat, fn, of_init_fn_2)
>          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/of.h:1481:2: note: expanded from macro '_OF_DECLARE'
>     1481 |         _OF_DECLARE_STUB(table, name, compat, fn, fn_type)
>          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/of.h:1470:16: note: expanded from macro '_OF_DECLARE_STUB'
>     1470 |                      .data = (fn == (fn_type)NULL) ? fn : fn }
>          |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It looks like irqchip.h is using __typecheck() which is really
an internal part of the implementation of min() and max().
The patched version doesn't use it - hence the build fail.
I can re-instate it, but this all looks wrong to me.

The type of typecheck_irq_init_cb is the same as that of fn_type (although
they are defined separately).
Both headers seem to be testing the type - and it must match both.
So if the test in of.h worked the one in irqchip.h wouldn't have been added.
So I suspect it doesn't actually do anything - the RHS is NULL, the type
probably doesn't matter.

Possibly:
		.data = {sizeof ((fn) == (fn_type)(fn)) ? fn : fn }
would actually generate the required compile-time error.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

