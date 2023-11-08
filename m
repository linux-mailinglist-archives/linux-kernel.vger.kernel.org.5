Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093B17E5C41
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 18:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjKHRSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 12:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjKHRSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 12:18:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783AB1FDF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 09:18:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85959C433C8;
        Wed,  8 Nov 2023 17:18:12 +0000 (UTC)
Date:   Wed, 8 Nov 2023 12:18:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, David.Laight@aculab.com,
        richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 00/86] Make the kernel preemptible
Message-ID: <20231108121816.28eebfd5@gandalf.local.home>
In-Reply-To: <20231108164916.GR8262@noisy.programming.kicks-ass.net>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
        <20231108085156.GD8262@noisy.programming.kicks-ass.net>
        <87bkc4lfxp.fsf@oracle.com>
        <20231108101330.GK3818@noisy.programming.kicks-ass.net>
        <877cmsgsrg.ffs@tglx>
        <20231108112227.62f0c5a8@gandalf.local.home>
        <20231108164916.GR8262@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2023 17:49:16 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Nov 08, 2023 at 11:22:27AM -0500, Steven Rostedt wrote:
> 
> > Peter, how can you say we can get rid of cond_resched() in NONE when you  
> 
> Because that would fix none to actually be none. Who cares.

Well, that would lead to regressions with PREEMPT_NONE and the watchdog
timer.

> 
> > > Look at my PoC: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/  
> > 
> > And I've been saying that many times already ;-)  
> 
> Why should I look at random patches on the interweb to make sense of
> these patches here?

I actually said it to others, this wasn't really supposed to be addressed
to you.

> 
> That just underlines these here patches are not making sense.

It's a complex series, and there's a lot of room for improvement. I'm happy
to help out here.

-- Steve
