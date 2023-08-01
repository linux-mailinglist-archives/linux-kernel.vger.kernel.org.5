Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B5876B209
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjHAKjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjHAKjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:39:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654F9A1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=gIm9BTepRGaVg8RMzFqvTWH+eL42gbFxAN1A8f353RQ=; b=P8ywmTTz4hKeV41FpyIjPwdH6E
        5IdymQnFMENu0zroz7w9q/RUVfkT2WbdoA7LyC9olWNosJZklL8c0L+67smrwMr+y61ia5W632GWx
        vEfdIRnlXyT09g62hehdhqnWj9MS3J/EHQ6R/mgC+cWwyN2W2btQ8hMSosPLOBZ7MRQdz7QpC3t2q
        3a0eCtRcXHTHOBA5D3q8R1c6blaPWbMhgOKu+bHgH3DiZwaVfpbzcIFVQtbOr5zQsh/43weXE1XfN
        7HDZEcr/nDvWWTQ8TWHpOBEPhMgJ8aaKLZeMjPWf7iVjNL0ajUdVmXdiKu++KgbqruCTtaxb0vEGn
        BMWCf68w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qQmmx-0084tC-0p; Tue, 01 Aug 2023 10:39:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 62995300235;
        Tue,  1 Aug 2023 12:39:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E7922119E820; Tue,  1 Aug 2023 12:39:36 +0200 (CEST)
Date:   Tue, 1 Aug 2023 12:39:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Ramazan Safiullin <ram.safiullin2001@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add documentation to PSI section
Message-ID: <20230801103936.GA79828@hirez.programming.kicks-ass.net>
References: <20230728120909.234244-1-ram.safiullin2001@gmail.com>
 <CAJuCfpGyV5nM+4t_RTxDgvgZ_VhjpdoZ4TJZBn7RgxSHC6+Hyw@mail.gmail.com>
 <CAJuCfpEjozCfqfPPttcnWdzhQBCGnr+MzWGN8FT40YObZf_mGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEjozCfqfPPttcnWdzhQBCGnr+MzWGN8FT40YObZf_mGA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 04:12:00PM -0700, Suren Baghdasaryan wrote:
> On Mon, Jul 31, 2023 at 4:10 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Fri, Jul 28, 2023 at 5:09 AM Ramazan Safiullin
> > <ram.safiullin2001@gmail.com> wrote:
> > >
> > > While creating a patch for the psi documentation I noticed that
> > > MAINTENERS was missing an entry in psi.
> > >
> > > Add entry for psi documentation.
> > >
> > > Signed-off-by: Ramazan Safiullin <ram.safiullin2001@gmail.com>
> >
> > Acked-by: Suren Baghdasaryan <surenb@google.com>
> 
> CC'ing Peter to pick up into his tree.

Well, I'd need the actual patch email, otherwise I can't apply. Either
bounce the thread or have it be resent.

> >
> > > ---
> > >  MAINTAINERS | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index a5c16bb92fe2..2da6643b9488 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -17103,6 +17103,7 @@ PRESSURE STALL INFORMATION (PSI)
> > >  M:     Johannes Weiner <hannes@cmpxchg.org>
> > >  M:     Suren Baghdasaryan <surenb@google.com>
> > >  S:     Maintained
> > > +F:     Documentation/accounting/psi.rst
> > >  F:     include/linux/psi*
> > >  F:     kernel/sched/psi.c
> > >
> > > --
> > > 2.25.1
> > >
