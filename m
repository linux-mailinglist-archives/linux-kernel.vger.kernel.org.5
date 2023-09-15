Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B1B7A1D30
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 13:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjIOLNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 07:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjIOLNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 07:13:35 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B43101;
        Fri, 15 Sep 2023 04:13:29 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40434d284f7so19388295e9.3;
        Fri, 15 Sep 2023 04:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694776408; x=1695381208; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CisjoQlNizklEH7NF94JE2kh7VYoSvf5CMxswh9s23k=;
        b=CrovmuKDfcGvk1Z+vUZq/D/vOlpZDxA1pYFZxOI+JScnxzuaERA4/k2BQZOCJEXeO/
         qswprGpDtHuotwjcln8lXhOXUaeP2PuW/kAvGnHlJk0PvYnGaT05kvpq59Q3vGs65Em9
         vU0z0Qm6t3fkzFdMb2sqQAYF5ZFoYNxk1sE8L5fnIbKrsFg28DRaDYp5K4X2dldMAtSw
         Rw9JDcjxAfNGzSmQCOZVXhn6/xCl8sWQ8JjwC+dKr0tfxr+3/dlaUEu68Ed5CP0SlvXR
         qDq4qeuVkKJkWSlRXn+wC7SKQRfqLHNfGFef7gqQkZLMfgPJGRvYm8lcOZ0VmQJZl3NZ
         nyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694776408; x=1695381208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CisjoQlNizklEH7NF94JE2kh7VYoSvf5CMxswh9s23k=;
        b=LBSny7Fa2N37g0eLecV7u1+ffNxrUSCkl5yIumN+u4wGnd0UeIND2xv/Jjeuo+P+an
         wzViOfGGmukZazVuw4H8Y2Jpx6e5WLsU/bh9NVW68U6a37gmrFwWh7zmvTzFxMRvCNnS
         L2tVXo4PriXAOLLaiGecSq6QMtCcnG7Cxicw8uHAUfRj7Nk9CQquvKFl3sZeFZAJiv/F
         7R1117jcSUqjgEeVV3BKCPsbKSXlKzyhkOCEBAQZ9WUAGZPVJq4VwzqUKclhI03896EO
         AVxIf2N5s12Fu95vPwjy+x7KYb79HO444Vve73b5erht3X/ncQnsKr7uabOcwy7vFlNt
         BODQ==
X-Gm-Message-State: AOJu0Yyti9o+MnkQpbVavJdCc+Mgdohx6WT7sn8uezuKy6Y3ukSEeYEP
        OuGPTDxOmL831EGCi2M3ycxdMPbduGw=
X-Google-Smtp-Source: AGHT+IHpu14WW2T1XA6i7u/lcJ4jYs2usVWQ211sZQoOlaktsYXUhgfJpwoFShR10D2go/1ilQoh1Q==
X-Received: by 2002:a05:600c:287:b0:402:bcac:5773 with SMTP id 7-20020a05600c028700b00402bcac5773mr1257018wmk.38.1694776407984;
        Fri, 15 Sep 2023 04:13:27 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c0b5500b003fbe791a0e8sm4357737wmr.0.2023.09.15.04.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 04:13:27 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 15 Sep 2023 13:13:25 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [tip: core/urgent] panic: Reenable preemption in WARN slowpath
Message-ID: <ZQQ8VZdWbj9U/AuB@gmail.com>
References: <3ec48fde01e4ee6505f77908ba351bad200ae3d1.1694763684.git.lukas@wunner.de>
 <169477058360.27769.17772363826818333894.tip-bot2@tip-bot2>
 <ZQQnnjzxbTwpn61F@gmail.com>
 <20230915103512.GC6721@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915103512.GC6721@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> > > panic: Reenable preemption in WARN slowpath
> > > 
> > > Commit:
> > > 
> > >   5a5d7e9badd2 ("cpuidle: lib/bug: Disable rcu_is_watching() during WARN/BUG")
> > > 
> > > amended warn_slowpath_fmt() to disable preemption until the WARN splat
> > > has been emitted.
> > > 
> > > However the commit neglected to reenable preemption in the !fmt codepath,
> > > i.e. when a WARN splat is emitted without additional format string.
> > > 
> > > One consequence is that users may see more splats than intended.  E.g. a
> > > WARN splat emitted in a work item results in at least two extra splats:
> > > 
> > >   BUG: workqueue leaked lock or atomic
> > >   (emitted by process_one_work())
> > > 
> > >   BUG: scheduling while atomic
> > >   (emitted by worker_thread() -> schedule())
> > > 
> > > Ironically the point of the commit was to *avoid* extra splats. ;)
> > > 
> > > Fix it.
> > 
> > > diff --git a/kernel/panic.c b/kernel/panic.c
> > > index 07239d4..ffa037f 100644
> > > --- a/kernel/panic.c
> > > +++ b/kernel/panic.c
> > > @@ -697,6 +697,7 @@ void warn_slowpath_fmt(const char *file, int line, unsigned taint,
> > >  	if (!fmt) {
> > >  		__warn(file, line, __builtin_return_address(0), taint,
> > >  		       NULL, NULL);
> > > +		warn_rcu_exit(rcu);
> > >  		return;
> > 
> > BTW., one more thing we might want to consider here is to re-enable 
> > preemption in warn_rcu_exit() a bit more gently, without forcing a
> > pending reschedule, ie. preempt_enable_no_resched() or so?
> 
> nah, it's a warn, if that triggers you get to keep the pieces.

But but ... my overall point is that since we just WARN()ed, we are facing 
some sort of kernel bug, and scheduling policies are only a secondary 
concern, debuggability & getting the bug fixed is the primary concern.

So the scheduler should switch to a debugging-friendlier behavior:

  'Schedule tasks around as little as possible, to keep the debug output 
   tidy & to keep things working a bit better even if it's all broken 
   already'.

... or so. My suggestion was a small subset of that principle.

> [...] Also preempt_enable_no_resched() isn't exported because its a 
> horribly dangerous function.

Special exception for RCU debugging only, or so - it's a core kernel 
facility after all.

No strong feelings either way though.

Thanks,

	Ingo
