Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CAA7A665E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjISORI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbjISORF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:17:05 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CAAF1;
        Tue, 19 Sep 2023 07:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=umXyPhqUhgAa/i7oZDEoLO+OY12DhrXYf7b1iez55DA=; b=S8Yyhj6JzhXJmoAwhs9b2qBktW
        fJkjw962R22KizD1SPZA6XyfLVfg+wxDfeyqXE/qEzvzBbAOB0JWJH//8CZCPxjiIEGIhQgdHdQ5A
        kGjcyLQCnV5P6UMmmGVM11jwFbT4Wv9ktgTd9HBewq4Nmx/jNT8q+hUrefFMjapXmG8GusMzqkNj6
        tHrNwPiNaq5/zTsX//Ipcjt6B59N1SKwf8J2lXnVBG3e3pPa9EdK+WSuaebSS/RAaWRT/B6c0t9Co
        jicMyJ60XWmWzfmF4HbA9MU7TD3bBgj7+/utf/2imNYSgV7I/4G7VVWP3rtJmKPASr/9YGRlK1yTB
        hGxidcNQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qibWc-00DegS-0S;
        Tue, 19 Sep 2023 14:16:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3C68C300585; Tue, 19 Sep 2023 16:16:27 +0200 (CEST)
Date:   Tue, 19 Sep 2023 16:16:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
        rostedt@goodmis.org, jon.grimm@amd.com, bharata@amd.com,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, jgross@suse.com, andrew.cooper3@citrix.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Brian Cain <bcain@quicinc.com>,
        linux-hexagon@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: Re: Arches that don't support PREEMPT
Message-ID: <20230919141627.GB39281@noisy.programming.kicks-ass.net>
References: <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx>
 <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net>
 <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 03:48:09PM +0200, John Paul Adrian Glaubitz wrote:
> On Tue, 2023-09-19 at 15:42 +0200, Peter Zijlstra wrote:
> > > The agreement to kill off ia64 wasn't an invitation to kill off other stuff
> > > that people are still working on! Can we please not do this?
> > 
> > If you're working on one of them, then surely it's a simple matter of
> > working on adding CONFIG_PREEMPT support :-)
> 
> As Geert poined out, I'm not seeing anything particular problematic with the
> architectures lacking CONFIG_PREEMPT at the moment. This seems to be more
> something about organizing KConfig files.

The plan in the parent thread is to remove PREEMPT_NONE and
PREEMPT_VOLUNTARY and only keep PREEMPT_FULL.

> I find it a bit unfair that maintainers of architectures that have huge companies
> behind them use their manpower to urge less popular architectures for removal just
> because they don't have 150 people working on the port so they can keep up with
> design changes quickly.

PREEMPT isn't something new. Also, I don't think the arch part for
actually supporting it is particularly hard, mostly it is sticking the
preempt_schedule_irq() call in return from interrupt code path.

If you convert the arch to generic-entry (a much larger undertaking)
then you get this for free.
