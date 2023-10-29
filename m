Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 143E97DAEA1
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 22:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjJ2Vmh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 29 Oct 2023 17:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjJ2Vmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 17:42:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6267E8E
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 14:42:33 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-278-rnF5RcNAOu2EX7E0tydquQ-1; Sun, 29 Oct 2023 21:42:30 +0000
X-MC-Unique: rnF5RcNAOu2EX7E0tydquQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 29 Oct
 2023 21:42:41 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 29 Oct 2023 21:42:41 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Brian Gerst' <brgerst@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>
Subject: RE: [PATCH v2 00/11] x86-64: Stack protector and percpu improvements
Thread-Topic: [PATCH v2 00/11] x86-64: Stack protector and percpu improvements
Thread-Index: AQHaCCWwM6Gzma9PGEyZRt5JZqLOarBhUF8A
Date:   Sun, 29 Oct 2023 21:42:41 +0000
Message-ID: <a094c7da294a4827994af72249262593@AcuMS.aculab.com>
References: <20231026160100.195099-1-brgerst@gmail.com>
In-Reply-To: <20231026160100.195099-1-brgerst@gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Gerst
> Sent: 26 October 2023 17:01
> 
> Currently, x86-64 uses an unusual percpu layout, where the percpu section
> is linked at absolute address 0.  The reason behind this is that older GCC
> versions placed the stack protector (if enabled) at a fixed offset from the
> GS segment base.  Since the GS segement is also used for percpu variables,
> this forced the current layout.
> 
> GCC since version 8.1 supports a configurable location for the stack
> protector value, which allows removal of the restriction on how the percpu
> section is linked.  This allows the percpu section to be linked
> normally, like most other architectures.  In turn, this allows removal
> of code that was needed to support the zero-based percpu section.

I didn't think the minimum gcc version was anything like 8.1.
I'm using 7.5.0 and I don't think that is the oldest version.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

