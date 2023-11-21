Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99807F2E57
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbjKUNbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKUNbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:31:36 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0E6188
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 05:31:33 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-59b5484fbe6so58196547b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 05:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700573492; x=1701178292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9usdIpBjCJHeynkV+8WUdrjvYefsD/jjuy6YO3+DQ/0=;
        b=nbgmEp3IgJDyGsGkoIqzrr0FczWfZVk8aR+w+82TT0nYIjSvzbW4h8uS/2ewhDIyIg
         JPOIyYLUksfueSQmWAklFbW3+gjgwUmPXvkcLtrUniSH8DQBqoAgV4IkiFkORCPuhN0P
         oH1f6QpvkpIPOVsvaE5vDwQXS3iIXR8qfwF8Dk3/xTWeE4SPmnm/2dLcz6/LPDS+GwLy
         IciVPEKyg5ofY0D7XwjmGUg+FKOcJmE+nM7G2ojADlPFpOpbpGFiA7Vqaqv/YGB/tU02
         FpEoe4LeAp99SYRvI85oADFRxkHJHHOq0JL0V2ox5NrXct802jmarxfiXMvB0uVx+8UG
         4i9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700573492; x=1701178292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9usdIpBjCJHeynkV+8WUdrjvYefsD/jjuy6YO3+DQ/0=;
        b=DWXAVHDsgDYgCR/UPKwpRISQsZfxrSn/2WIkZELYZ1jPA7g2mpeah57OIXITPe6ihf
         1MA+UGNw1bA1QowZTGO6DwB9t1eswXH7X5N8Hw8eibl7r8ms9kVtUoKP5acXmksC4XI/
         QdPSJtj+wZBSQ3NWMsruVqC4Cxx4LdymAigsOqEWHE/I+m/Z+9r8rLSfTT8hAWkL6cRW
         IoQmT2S6ycVQSBwdNYyaOhrtSedOUzPkoCbizdVSqxeyBzXenu4Os4LYPVw6mWLv4EIp
         OzJ7pSlp5icT92vNKUttKPEz85vPdsLhBQYPbZM1Na8qQnW7QXamP4Gxsd9k6qw41NNo
         Z1Gw==
X-Gm-Message-State: AOJu0Ywd44xLNoT9vukDGofYMi/jGVjwFSSnYOYfeJrjwn1L9ioAS1xE
        XATRMslWFkxkBBXeDmmEovc=
X-Google-Smtp-Source: AGHT+IG47s8LftppWHMec7ePdmuAozSSEfMiMLQvU9iH4MQ2h9QpBe0ksOH429+IH4UQP034/gLn/g==
X-Received: by 2002:a0d:c786:0:b0:5a7:b557:6595 with SMTP id j128-20020a0dc786000000b005a7b5576595mr11413439ywd.21.1700573492117;
        Tue, 21 Nov 2023 05:31:32 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:e005:b808:45e:1b60])
        by smtp.gmail.com with ESMTPSA id s185-20020a0dd0c2000000b005b03d703564sm3052908ywd.137.2023.11.21.05.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 05:31:31 -0800 (PST)
Date:   Tue, 21 Nov 2023 05:31:30 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: [PATCH 04/34] sched: add cpumask_find_and_set() and use it in
 __mm_cid_get()
Message-ID: <ZVyxMrisyuBtQ+2Y@yury-ThinkPad>
References: <20231118155105.25678-1-yury.norov@gmail.com>
 <20231118155105.25678-5-yury.norov@gmail.com>
 <20231120113105.GR8262@noisy.programming.kicks-ass.net>
 <1eb9435a-aa1c-4c30-ab1a-9167b73d1b83@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1eb9435a-aa1c-4c30-ab1a-9167b73d1b83@efficios.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 11:17:32AM -0500, Mathieu Desnoyers wrote:

...

> > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > index 2e5a95486a42..b2f095a9fc40 100644
> > > --- a/kernel/sched/sched.h
> > > +++ b/kernel/sched/sched.h
> > > @@ -3345,28 +3345,6 @@ static inline void mm_cid_put(struct mm_struct *mm)
> > >   	__mm_cid_put(mm, mm_cid_clear_lazy_put(cid));
> > >   }
> > > -static inline int __mm_cid_try_get(struct mm_struct *mm)
> > > -{
> > > -	struct cpumask *cpumask;
> > > -	int cid;
> > > -
> > > -	cpumask = mm_cidmask(mm);
> > > -	/*
> > > -	 * Retry finding first zero bit if the mask is temporarily
> > > -	 * filled. This only happens during concurrent remote-clear
> > > -	 * which owns a cid without holding a rq lock.
> > > -	 */
> > > -	for (;;) {
> > > -		cid = cpumask_first_zero(cpumask);
> > > -		if (cid < nr_cpu_ids)
> > > -			break;
> > > -		cpu_relax();
> > > -	}
> > > -	if (cpumask_test_and_set_cpu(cid, cpumask))
> > > -		return -1;
> 
> This was split in find / test_and_set on purpose because following
> patches I have (implementing numa-aware mm_cid) have a scan which
> needs to scan sets of two cpumasks in parallel (with "and" and
> and_not" operators).
> 
> Moreover, the "mask full" scenario only happens while a concurrent
> remote-clear temporarily owns a cid without rq lock. See
> sched_mm_cid_remote_clear():
> 
>         /*
>          * The cid is unused, so it can be unset.
>          * Disable interrupts to keep the window of cid ownership without rq
>          * lock small.
>          */
>         local_irq_save(flags);
>         if (try_cmpxchg(&pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
>                 __mm_cid_put(mm, cid);
>         local_irq_restore(flags);
> 
> The proposed patch here turns this scenario into something heavier
> (setting the use_cid_lock) rather than just retrying. I guess the
> question to ask here is whether it is theoretically possible to cause
> __mm_cid_try_get() to fail to have forward progress if we have a high
> rate of sched_mm_cid_remote_clear. If we decide that this is indeed
> a possible progress-failure scenario, then it makes sense to fallback
> to use_cid_lock as soon as a full mask is encountered.
> 
> However, removing the __mm_cid_try_get() helper will make it harder to
> integrate the following numa-awareness patches I have on top.
> 
> I am not against using cpumask_find_and_set, but can we keep the
> __mm_cid_try_get() helper to facilitate integration of future work ?
> We just have to make it use cpumask_find_and_set, which should be
> easy.

Sure, I can. Can you point me to the work you mention here?
