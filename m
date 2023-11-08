Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB037E5B31
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjKHQ3w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Nov 2023 11:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKHQ3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:29:51 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204A0131
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:29:48 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-202-TeiFwQDsO6-x3H0sA3xebA-1; Wed, 08 Nov 2023 16:29:45 +0000
X-MC-Unique: TeiFwQDsO6-x3H0sA3xebA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 8 Nov
 2023 16:29:40 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 8 Nov 2023 16:29:40 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>
CC:     'Ankur Arora' <ankur.a.arora@oracle.com>,
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
        "mjguzik@gmail.com" <mjguzik@gmail.com>
Subject: RE: [RFC PATCH 00/86] Make the kernel preemptible
Thread-Topic: [RFC PATCH 00/86] Make the kernel preemptible
Thread-Index: AQHaEcV0+BoURT5JbUqhFq41r7bm+rBwJNlwgABkiACAAAiUQA==
Date:   Wed, 8 Nov 2023 16:29:40 +0000
Message-ID: <19a53508f44049a39272e5bd89ade4ab@AcuMS.aculab.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
        <f97b7506a84e43ea82eb0b947324e835@AcuMS.aculab.com>
 <20231108101552.7ebbb52d@gandalf.local.home>
In-Reply-To: <20231108101552.7ebbb52d@gandalf.local.home>
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
> Sent: 08 November 2023 15:16
> 
> On Wed, 8 Nov 2023 09:43:10 +0000
> David Laight <David.Laight@ACULAB.COM> wrote:
> 
> > > Policies:
> > >
> > > A - preemption=none: run to completion
> > > B - preemption=voluntary: run to completion, unless a task of higher
> > >     sched-class awaits
> > > C - preemption=full: optimized for low-latency. Preempt whenever a higher
> > >     priority task awaits.
> >
> > If you remove cond_resched() then won't both B and C require an extra IPI.
> > That is probably OK for RT tasks but could get expensive for
> > normal tasks that aren't bound to a specific cpu.
> 
> What IPI is extra?

I was thinking that you wouldn't currently need an IPI if the target cpu
was running in-kernel because nothing would happen until cond_resched()
was called.

> > I suspect C could also lead to tasks being pre-empted just before
> > they sleep (eg after waking another task).
> > There might already be mitigation for that, I'm not sure if
> > a voluntary sleep can be done in a non-pre-emptible section.
> 
> No, voluntary sleep can not be done in a preemptible section.

I'm guessing you missed out a negation in that (or s/not/only/).

I was thinking about sequences like:
	wake_up();
	...
	set_current_state(TASK_UNINTERRUPTIBLE)
	add_wait_queue();
	spin_unlock();
	schedule();

Where you really don't want to be pre-empted by the woken up task.
For non CONFIG_RT the lock might do it - if held long enough.
Otherwise you'll need to have pre-emption disabled and enable
it just after the set_current_state().
And then quite likely disable again after the schedule()
to balance things out.

So having the scheduler save the pre-empt disable count might
be useful.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

