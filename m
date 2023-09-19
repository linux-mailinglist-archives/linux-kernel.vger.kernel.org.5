Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFB67A6592
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjISNn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 09:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjISNnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:43:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627741BE6;
        Tue, 19 Sep 2023 06:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xF9/8QKvWWkbeOJr21JLbJCynp3yqjzThzTACYbxHTg=; b=haZzJuTZBCZsOTNcMz6ga4dc9s
        gPbmwmK5daZnt7lwf0QPIOwrHm1HLUNltZ5eyE7kwaAHo437epvLvvbzCxKSKbClSjly0J6iO9U3b
        2kE1iDoDjDVteIas0Hrdvw+mKegt5l3ahQOD8ROwy0dNBYdx5nyfI2MgkQbm1ywCSrKpMQQOJ03ry
        fMO9W8zUlfaxtXOtSOifpGhKXDQC78ttaD5wvdJrMOlfoZ6h4lc4Ci+ktx1zVTf3yZSfsmPXvx846
        2ADzJq0jb+18JXgy/PoeRUfMkREC/wv/U6mZE4obztCo1xpba1RDNlGOmFJ0zI1uUNmc+WjwUgXaS
        YwmBv/0Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qiazZ-00De9q-3B;
        Tue, 19 Sep 2023 13:42:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 18E1E300585; Tue, 19 Sep 2023 15:42:19 +0200 (CEST)
Date:   Tue, 19 Sep 2023 15:42:18 +0200
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
Message-ID: <20230919134218.GA39281@noisy.programming.kicks-ass.net>
References: <87zg1u1h5t.fsf@oracle.com>
 <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net>
 <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net>
 <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx>
 <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 03:37:24PM +0200, John Paul Adrian Glaubitz wrote:
> On Tue, 2023-09-19 at 14:00 +0100, Matthew Wilcox wrote:
> > On Tue, Sep 19, 2023 at 02:30:59PM +0200, Thomas Gleixner wrote:
> > > Though it just occured to me that there are dragons lurking:
> > > 
> > > arch/alpha/Kconfig:     select ARCH_NO_PREEMPT
> > > arch/hexagon/Kconfig:   select ARCH_NO_PREEMPT
> > > arch/m68k/Kconfig:      select ARCH_NO_PREEMPT if !COLDFIRE
> > > arch/um/Kconfig:        select ARCH_NO_PREEMPT
> > 
> > Sounds like three-and-a-half architectures which could be queued up for
> > removal right behind ia64 ...
> 
> The agreement to kill off ia64 wasn't an invitation to kill off other stuff
> that people are still working on! Can we please not do this?

If you're working on one of them, then surely it's a simple matter of
working on adding CONFIG_PREEMPT support :-)
