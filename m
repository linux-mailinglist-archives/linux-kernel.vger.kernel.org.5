Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6057B30F5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbjI2K60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbjI2K6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:58:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2D71726;
        Fri, 29 Sep 2023 03:57:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07BBC433C9;
        Fri, 29 Sep 2023 10:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695985076;
        bh=tBcW+9T0Szmsb/1uixa8Q/j6hm71o84nD60FwoEkhH8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VfED/xp0larnQprtl8/AJHIjIQ5WKq8CituNwRnF/ciSa1IXFip6G0sL55biLGAPX
         phgZ1SBF2Mvp1nVHidSZH/yXV2mXqIY4ocGPwCoaUxBIwv8Ko3PS0YgUanPE8L/N81
         YPsAFDouUVolZMv5A4STCfndiNg/Mn5rxIbS/Awt5hTP/oyk1P05QYTScO+bVZccrl
         rFZZRI+Sxw4Cr5kd4xo2jaV5ERjDeOF3mtCxYcFUbfRDtzooXcQN1h+Z+QEaV2rV1f
         fUiiNeD8hYMXqQBAcpCyii+rc6Kk0tsVnQQVz2EUIi4nULPbHooaa93slA1Jgy2ja3
         5cfVAKnTQwaMA==
Date:   Fri, 29 Sep 2023 12:57:53 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-tip-commits@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] tick/nohz: Update comments some more
Message-ID: <ZRatsTz1mQRFJ0sW@lothringen>
References: <20230912104406.312185-3-frederic@kernel.org>
 <169582689118.27769.11953848930688373230.tip-bot2@tip-bot2>
 <ZRVCNeMcSQcXS36N@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRVCNeMcSQcXS36N@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 11:07:01AM +0200, Ingo Molnar wrote:
> > + * infrastructure actually relies on the tick itself as a backend in
> > + * low-resolution mode (see hrtimer_run_queues()).
> > + *
> > + * This low-resolution handler still makes use of some hrtimer APIs meanwhile
> > + * for commodity with expiration calculation and forwarding.
> 
> commodity?

I meant 'convenience', my usual frenglish issues...

> 
> >   */
> >  static void tick_nohz_lowres_handler(struct clock_event_device *dev)
> >  {
> 
> As well-deserved penace for my nitpicking, I've fixed these on top of
> tip:timers/core, and have also done a full scan of kernel/time/tick-sched.c
> for spelling, consistency of style and readability of comments - see
> the patch below.
> 
> Thanks,
> 
> 	Ingo
> 
> ===========================>
> From: Ingo Molnar <mingo@kernel.org>
> Date: Thu, 28 Sep 2023 10:45:54 +0200
> Subject: [PATCH] tick/nohz: Update comments some more
> 
> Inspired by recent enhancements to comments in kernel/time/tick-sched.c,
> go through the entire file and fix/unify its comments:
> 
>  - Fix over a dozen typos, spelling mistakes & cases of bad grammar.
> 
>  - Re-phrase sentences that I needed to read three times to understand.
> 
>     [ I used the following arbitrary rule-of-thumb:
>        - if I had to read a comment twice, it was usually my fault,
>        - if I had to read it a third time, it was the comment's fault. ]
> 
>  - Comma updates:
> 
>     - Add commas where needed
> 
>     - Remove commas where not needed
> 
>     - In cases where a comma is optional, choose one variant and try to
>       standardize it over similar sentences in the file.   
> 
>  - Standardize on standalone 'NOHZ' spelling in free-flowing comments:
> 
>       s/nohz/NOHZ
>       s/no idle tick/NOHZ
> 
>    Still keep 'dynticks' as a popular synonym.
> 
>  - Standardize on referring to variable names within free-flowing
>    comments with the "'var'" nomenclature, and function names as
>    "function_name()".
> 
>  - Standardize on '64-bit' and '32-bit':
>      s/32bit/32-bit
>      s/64bit/64-bit
> 
>  - Standardize on 'IRQ work':
>      s/irq work/IRQ work
> 
>  - A few other tidyups I probably missed to list.
> 
> No change in functionality intended - other than one small change to
> a syslog output string.
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>

Looks good, thanks!
