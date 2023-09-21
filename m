Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65277AA1A0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjIUVE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjIUVDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:03:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB7086104
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:37:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA6F6C4E74D;
        Thu, 21 Sep 2023 13:58:28 +0000 (UTC)
Date:   Thu, 21 Sep 2023 09:59:06 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <20230921095906.3dad00be@gandalf.local.home>
In-Reply-To: <87wmwkcga6.fsf@oracle.com>
References: <20230830184958.2333078-8-ankur.a.arora@oracle.com>
        <20230908070258.GA19320@noisy.programming.kicks-ass.net>
        <87zg1v3xxh.fsf@oracle.com>
        <CAHk-=whagwHrDxhjUVrRPhq78YC195KrSGzuC722-4MvAz40pw@mail.gmail.com>
        <87edj64rj1.fsf@oracle.com>
        <CAHk-=wi0bXpgULVVLc2AdJcta-fvQP7yyFQ_JtaoHUiPrqf--A@mail.gmail.com>
        <87zg1u1h5t.fsf@oracle.com>
        <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
        <20230911150410.GC9098@noisy.programming.kicks-ass.net>
        <87h6o01w1a.fsf@oracle.com>
        <20230912082606.GB35261@noisy.programming.kicks-ass.net>
        <87cyyfxd4k.ffs@tglx>
        <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
        <87led2wdj0.ffs@tglx>
        <8734z8v1lo.ffs@tglx>
        <87edisibrp.fsf@oracle.com>
        <87ttrothbb.ffs@tglx>
        <87wmwkcga6.fsf@oracle.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2023 21:16:17 -0700
Ankur Arora <ankur.a.arora@oracle.com> wrote:

> > On Wed, Sep 20 2023 at 17:57, Ankur Arora wrote:  
> >> Thomas Gleixner <tglx@linutronix.de> writes:  
> >>> Find below a PoC which implements that scheme. It's not even close to
> >>> correct, but it builds, boots and survives lightweight testing.  
> >>
> >> Whew, that was electric. I had barely managed to sort through some of
> >> the config maze.
> >> From a quick look this is pretty much how you described it.  
> >


> > What's electric about that?  
> 
> Hmm, so I /think/ I was going for something like electric current taking
> the optimal path, with a side meaning of electrifying.
> 
> Though, I guess electron flow is a quantum mechanical, so that would
> really try all possible paths, which means the analogy doesn't quite
> fit.
> 
> Let me substitute greased lightning for electric :D.

"It's electrifying!" ;-)

  https://www.youtube.com/watch?v=7oKPYe53h78

-- Steve
