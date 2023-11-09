Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8F57E66EC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjKIJjv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Nov 2023 04:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjKIJjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:39:49 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240662702
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 01:39:46 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-311-kWHIacAcNKmgzdDrFlUTzQ-1; Thu, 09 Nov 2023 09:39:43 +0000
X-MC-Unique: kWHIacAcNKmgzdDrFlUTzQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 9 Nov
 2023 09:39:33 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 9 Nov 2023 09:39:33 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>
CC:     Ankur Arora <ankur.a.arora@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "jon.grimm@amd.com" <jon.grimm@amd.com>,
        "bharata@amd.com" <bharata@amd.com>,
        "raghavendra.kt@amd.com" <raghavendra.kt@amd.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "bristot@kernel.org" <bristot@kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        "krypton@ulrich-teichert.org" <krypton@ulrich-teichert.org>,
        "richard@nod.at" <richard@nod.at>,
        "mjguzik@gmail.com" <mjguzik@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Thomas Graf <tgraf@suug.ch>
Subject: RE: [RFC PATCH 71/86] treewide: lib: remove cond_resched()
Thread-Topic: [RFC PATCH 71/86] treewide: lib: remove cond_resched()
Thread-Index: AQHaEnua2nCaMITSyEySoaHbkNrcGbBxukcg
Date:   Thu, 9 Nov 2023 09:39:33 +0000
Message-ID: <3ad1798407144171b3e82e90d6b0565c@AcuMS.aculab.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
        <20231107230822.371443-1-ankur.a.arora@oracle.com>
        <20231107230822.371443-15-ankur.a.arora@oracle.com>
        <202311081114.0F15C1FB9@keescook>
 <20231108144144.3d257286@gandalf.local.home>
In-Reply-To: <20231108144144.3d257286@gandalf.local.home>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt
> Sent: 08 November 2023 19:42
> 
> On Wed, 8 Nov 2023 11:15:37 -0800
> Kees Cook <keescook@chromium.org> wrote:
> 
> > FOr the memcpy_kunit.c cases, I don't think there are preemption
> > locations in its loops. Perhaps I'm misunderstanding something? Why will
> > the memcpy test no longer produce softlockup splats?
> 
> This patchset will switch over to a NEED_RESCHED_LAZY routine, so that
> VOLUNTARY and NONE preemption models will be forced to preempt if its in
> the kernel for too long.
> 
> Time slice is over: set NEED_RESCHED_LAZY
> 
> For VOLUNTARY and NONE, NEED_RESCHED_LAZY will not preempt the kernel (but
> will preempt user space).
> 
> If in the kernel for over 1 tick (1ms for 1000Hz, 4ms for 250Hz, etc),
> if NEED_RESCHED_LAZY is still set after one tick, then set NEED_RESCHED.

Delaying the reschedule that long seems like a regression.
I'm sure a lot of the cond_resched() calls were added to cause
pre-emption much earlier than 1 tick.

I doubt the distibutions will change from VOLUTARY any time soon.
So that is what most people will be using.

	David.

> 
> NEED_RESCHED will now schedule in the kernel once it is able to regardless
> of preemption model. (PREEMPT_NONE will now use preempt_disable()).
> 
> This allows us to get rid of all cond_resched()s throughout the kernel as
> this will be the new mechanism to keep from running inside the kernel for
> too long. The watchdog is always longer than one tick.
> 
> -- Steve

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

