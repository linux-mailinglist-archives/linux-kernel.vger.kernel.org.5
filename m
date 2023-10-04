Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C60D7B885E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244034AbjJDSPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244028AbjJDSPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:15:19 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034789E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 11:15:15 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-98377c5d53eso25319366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 11:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696443313; x=1697048113; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1N1m6C2ZJv5jGP2wdjxZsch8T9RQRLRWPKB+sdu5Zw=;
        b=B+nnlbgW3mi4V6w35Kq8ERb8nkRCgmSU05+4rkFRR/7mXsY3YM6LzlLx3rlBGdKqFR
         ssxZUqhDawFf8ae3y4bFMluAHgn1FqdzYJSMpOf1q7y7iqNGzxy+VDqh8NujnfaOITEF
         O7MTOYLalr2xMnxz+DhoJezEXd2WTaRuJmd0KcZXMIn3uq4crrLCGHAkR7PN85stifEn
         XNctOhsXNs5NPjus1KhgNhwWWIJSALtWHFP5K/e2swuqMNHW59UBm6j7J0I9dHCRV3rB
         skrUwd7fqraps4FUFWiD7+jmEnSVA6fEdAuoxd+oYB8YioWHCjfkZxmxDKptnTs/Tyln
         pmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696443313; x=1697048113;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1N1m6C2ZJv5jGP2wdjxZsch8T9RQRLRWPKB+sdu5Zw=;
        b=JEjh4pTuvYdM92jmbqLPKHyzDTh953ZsH/1hn+pnniOIyi3WQ7MUO2q97i3TlsjINY
         cBGrt+wh4ea+TN1JWBVYICXjB8aRUBK9pTjUb5KweIC9qPGRW2uSc/kaNmaDgihmZmWr
         +o9JvdZfV3z7hVOohWJK9r15/A1Lx0G0AQ0E85fL1FcTpKMTYC6fIm02wLUT/79PNb8K
         Lk+Sh/jZvoQKlVrTYA6C/BCDmVk55J0G+ULZ4VhcQKqwHFDKf+0daBU83WqF8tGj0kEb
         V1EysYVz3VakoGlu1/YXrHT8So177WsWf2ZfFzNGo9j3hdWlv/KKv38tTdGpiFHRVej0
         zlRg==
X-Gm-Message-State: AOJu0Yyqv7ojj6og0I9ndtq2VB2eqw/kgtwD2uasFMhLSlgLukZyP2Lf
        E7Cefr7fofIURGcVe0xJlzc=
X-Google-Smtp-Source: AGHT+IEOS6YUN5E3lLEsLCMH3IPbtiYdYNQd/UwGpE8DHCDlh3CUL7d5AK6GfLnMcVj0OSoVACWNjA==
X-Received: by 2002:a17:906:7496:b0:9b2:93f2:71b0 with SMTP id e22-20020a170906749600b009b293f271b0mr2939008ejl.38.1696443313006;
        Wed, 04 Oct 2023 11:15:13 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id mf24-20020a170906cb9800b009ae3d711fd9sm3138223ejb.69.2023.10.04.11.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 11:15:12 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 4 Oct 2023 20:15:10 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: EEVDF and NUMA balancing
Message-ID: <ZR2rrixNEjrYiaYi@gmail.com>
References: <alpine.DEB.2.22.394.2310032059060.3220@hadrien>
 <20231003215159.GJ1539@noisy.programming.kicks-ass.net>
 <alpine.DEB.2.22.394.2310041358420.3108@hadrien>
 <20231004120544.GA6307@noisy.programming.kicks-ass.net>
 <alpine.DEB.2.22.394.2310041822170.3108@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2310041822170.3108@hadrien>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Julia Lawall <julia.lawall@inria.fr> wrote:

> 
> 
> On Wed, 4 Oct 2023, Peter Zijlstra wrote:
> 
> > On Wed, Oct 04, 2023 at 02:01:26PM +0200, Julia Lawall wrote:
> > >
> > >
> > > On Tue, 3 Oct 2023, Peter Zijlstra wrote:
> > >
> > > > On Tue, Oct 03, 2023 at 10:25:08PM +0200, Julia Lawall wrote:
> > > > > Is it expected that the commit e8f331bcc270 should have an impact on the
> > > > > frequency of NUMA balancing?
> > > >
> > > > Definitely not expected. The only effect of that commit was supposed to
> > > > be the runqueue order of tasks. I'll go stare at it in the morning --
> > > > definitely too late for critical thinking atm.
> > >
> > > Maybe it's just randomly making a bad situation worse rather than directly
> > > introduing a problem.  There is a high standard deviatind in the
> > > performance.  Here are some results with hyperfine.  The general trends
> > > are reproducible.
> >
> > OK,. I'm still busy trying to bring a 4 socket machine up-to-date...
> > gawd I hate the boot times on those machines :/
> >
> > But yeah, I was thinking similar things, I really can't spot an obvious
> > fail in that commit.
> >
> > I'll go have a poke once the darn machine is willing to submit :-)
> 
> I tried a two-socket machine, but in 50 runs the problem doesn't show up.
> 
> The commit e8f331bcc270 starts with
> 
> -       if (sched_feat(PLACE_LAG) && cfs_rq->nr_running > 1) {
> +       if (sched_feat(PLACE_LAG) && cfs_rq->nr_running) {
> 
> This seemed like a big change - cfs_rq->nr_running > 1 should be rarely
> true in ua, while cfs_rq->nr_running should always be true.  Adding back
> the > 1 and simply replacing the test by 0 both had no effect, though.

BTW., in terms of statistical reliability, one of the biggest ... 
stochastic elements of scheduler balancing is wakeup-preemption - which 
you can turn off via:

   echo NO_WAKEUP_PREEMPTION > /debug/sched/features

or:

   echo NO_WAKEUP_PREEMPTION > /sys/kernel/debug/sched/features

If you can measure a performance regression with WAKEUP_PREEMPTION turned 
off in *both* kernels, there's likely a material change (regression) in the 
quality of NUMA load-balancing.

If it goes away or changes dramatically with WAKEUP_PREEMPTION off, then 
I'd pin this effect to EEVDF causing timing changes that are subtly 
shifting NUMA & SMP balancing decisions past some critical threshold that 
is detrimental to this particular workload.

( Obviously both are regressions we care about - but doing this test would 
  help categorize the nature of the regression. )

Thanks,

	Ingo
