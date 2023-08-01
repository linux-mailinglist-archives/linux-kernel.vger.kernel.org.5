Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE4E76B55B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjHANDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjHANDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:03:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A194AD3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 06:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=3Jp1nAS8lr6cvH4lf9wAiqTT6XGFaU7dhZ2y07kKl9g=; b=P3wtg3SPuogxLb1PBsY3EYwJqR
        BKSM4iRfxPMTBXocWmvKenZRumo9ql6b0rccKW+5h2QiDEtmbvuup6bh3pgZKCD6lf/RYM5IOVHQF
        nHdAvr2jmpJFCQXksiNhYN7JKmkb1E98f6kDC0RsOfhoA7yeHdL/duh+3oSUwJJhpXaVg1qjtiGTE
        ATZOcP2cUhGz67V5HUnlM3NaQQ9RBFyo7zAxZrnBQ9he4jX1lqRIS9+yFb7d6qKD/A2d+YIQWjqL9
        7nSyw5RgkPwjsOL0V6463MxXwvTdqdzObag2/mGXgA6OeJQwuPcRg/dHFASkgfCI/upOs3bEIVdzh
        2+kJBjGA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qQp1i-008w7N-G1; Tue, 01 Aug 2023 13:03:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 24FB8300134;
        Tue,  1 Aug 2023 15:03:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AD9E220A9524A; Tue,  1 Aug 2023 15:03:01 +0200 (CEST)
Date:   Tue, 1 Aug 2023 15:03:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Ramazan Safiullin <ram.safiullin2001@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add documentation to PSI section
Message-ID: <20230801130301.GB11704@hirez.programming.kicks-ass.net>
References: <20230728120909.234244-1-ram.safiullin2001@gmail.com>
 <CAJuCfpGyV5nM+4t_RTxDgvgZ_VhjpdoZ4TJZBn7RgxSHC6+Hyw@mail.gmail.com>
 <CAJuCfpEjozCfqfPPttcnWdzhQBCGnr+MzWGN8FT40YObZf_mGA@mail.gmail.com>
 <20230801103936.GA79828@hirez.programming.kicks-ass.net>
 <CAKXUXMwJk2bB-mPpeAj8dU3DVhdX-TRRV6eXSjMVO16Xsivj3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKXUXMwJk2bB-mPpeAj8dU3DVhdX-TRRV6eXSjMVO16Xsivj3g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 01:07:09PM +0200, Lukas Bulwahn wrote:
> On Tue, Aug 1, 2023 at 12:39 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Jul 31, 2023 at 04:12:00PM -0700, Suren Baghdasaryan wrote:
> > > On Mon, Jul 31, 2023 at 4:10 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > On Fri, Jul 28, 2023 at 5:09 AM Ramazan Safiullin
> > > > <ram.safiullin2001@gmail.com> wrote:
> > > > >
> > > > > While creating a patch for the psi documentation I noticed that
> > > > > MAINTENERS was missing an entry in psi.
> > > > >
> > > > > Add entry for psi documentation.
> > > > >
> > > > > Signed-off-by: Ramazan Safiullin <ram.safiullin2001@gmail.com>
> > > >
> > > > Acked-by: Suren Baghdasaryan <surenb@google.com>
> > >
> > > CC'ing Peter to pick up into his tree.
> >
> > Well, I'd need the actual patch email, otherwise I can't apply. Either
> > bounce the thread or have it be resent.
> >
> 
> Speaking on behalf of Ramazan, who I am working with:
> 
> Suren, Peter, should we actually better just add you, Peter, as a
> reviewer to PSI in MAINTAINERS, so that you get all the patches to psi
> stuff in your mailbox and you just need to wait for an Ack from Suren
> or Johannes?

Well, mostly psi patches touch kernel/sched/psi.c and then I should get
it anyway (throught the kernel/sched/ glob). But sure, one more copy of
my email address in that file isn't going to hurt..
