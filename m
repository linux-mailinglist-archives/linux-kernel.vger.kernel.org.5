Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BA67F91EA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 10:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjKZJFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 04:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZJFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 04:05:53 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2306B4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 01:05:59 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 900CB3F6EF
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 09:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1700989557;
        bh=NOf8nwqrRIShmOg3ETfBHRni0LDjvujlBEtnlkJfS4I=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=JtVbkIvc5Smt37YKIfRSd+qVL4J9x7SrPD+Amp4oO/nHGa/Df+iruhGnVKXYkCQdV
         ySPR9unYoZ1Sqi/FSGPIR2EN3cuMtAcYNeLt8Ndc8PQOBdbesxiD0NkaKGSehEn6Vh
         AiBFOQTg9WKWGQ40fp/oV3kO5lxNm8w6E7Lwv6OG60HuUztDRbWm/riJWMl2XoE1dC
         a6Y9N17r005aQbzabh89GyQ55cMdSqSN6LHyNMcv04DMsjeFchJA7lu0TZ7orCSTTR
         Y61Xdjhqf8LFyPDDgMWNRxaHGS9n4cWJxxTkARoHtyF7WkpY2gqFwY1YMhS2Puj790
         Wb4mbu4cKDvMw==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a0bdc9cefedso107188266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 01:05:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700989557; x=1701594357;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NOf8nwqrRIShmOg3ETfBHRni0LDjvujlBEtnlkJfS4I=;
        b=g9IBPPYb1W8ZFvCLAiyDIAK9EvSGHgzAZhiLhQw3JeQM2ClHlQ7HjYAkJxjopOMv4p
         7FKJhlcwz69/OGvHxX6ggq8UcVIdc+wLPeIliw8YKydAaDfoLFAHTK6EJ1P3fozAJTXQ
         bctpdoZ1tDzBPKK9BCFt4sAYxwSiDa9AbXZ28mfUo8AGOsc5zTvxQ96eR3F7HOQI/9aB
         6y0Mb+7n0KpVaQvTJNCYorxcV5J3ZlwaXX60B3hxe7Jk6Abv9El/mLdIvWGDBSv5gUYk
         E3IcoHIfTklHW04iAvdNXuREbsw9yS6mHo6ULIg7a+whOAoRqVshHQgauY6vH/AbkF5x
         Ajmw==
X-Gm-Message-State: AOJu0YwbR8aomX1frWGypZPPQ8GWi8IDvUoWztxv8dD6NmxI6Y9QdoiU
        1VBOiJofM8tKeXMMa89DyS3qFYr4ZZoPbD/P41eLDQBqrkx7zSDIeSI0iBo1NeZBi5z9fv+w/H6
        TI52BWU8+tUJsXvnS/VemaEt9rzSvi2jGhtNHxk260A==
X-Received: by 2002:a17:906:7494:b0:a01:d701:2f1d with SMTP id e20-20020a170906749400b00a01d7012f1dmr7321334ejl.14.1700989557224;
        Sun, 26 Nov 2023 01:05:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHN59pkxh3dfTCg77E/TXP5hk7Zi5T6bnJILCygsLlXQXG428gwl2nuC8774LYguLMSolYBfw==
X-Received: by 2002:a17:906:7494:b0:a01:d701:2f1d with SMTP id e20-20020a170906749400b00a01d7012f1dmr7321297ejl.14.1700989556648;
        Sun, 26 Nov 2023 01:05:56 -0800 (PST)
Received: from localhost (fi-19-199-248.service.infuturo.it. [151.19.199.248])
        by smtp.gmail.com with ESMTPSA id j24-20020a170906411800b009a193a5acffsm4359673ejk.121.2023.11.26.01.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 01:05:56 -0800 (PST)
Date:   Sun, 26 Nov 2023 10:05:52 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH 12/36] sched_ext: Implement BPF extensible scheduler class
Message-ID: <ZWMKcPXIAuJ22Q+i@gpd>
References: <20231111024835.2164816-1-tj@kernel.org>
 <20231111024835.2164816-13-tj@kernel.org>
 <ZV8IR/w4IaxJ2vPA@gpd>
 <ZWJSL15eCe0aXnZe@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWJSL15eCe0aXnZe@mtj.duckdns.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 09:59:43AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Thu, Nov 23, 2023 at 09:07:35AM +0100, Andrea Righi wrote:
> > On Fri, Nov 10, 2023 at 04:47:38PM -1000, Tejun Heo wrote:
> ...
> > > +#ifdef CONFIG_SCHED_CLASS_EXT
> > > +	p->scx.dsq		= NULL;
> > > +	INIT_LIST_HEAD(&p->scx.dsq_node);
> > > +	p->scx.flags		= 0;
> > > +	p->scx.weight		= 0;
> > > +	p->scx.sticky_cpu	= -1;
> > > +	p->scx.holding_cpu	= -1;
> > > +	p->scx.kf_mask		= 0;
> > > +	atomic64_set(&p->scx.ops_state, 0);
> > 
> > We probably need atomic_long_set() here or in 32-bit arches (such as
> > armhf) we get this:
> > 
> > kernel/sched/core.c:4564:22: error: passing argument 1 of ‘atomic64_set’ from incompatible pointer type [-Werror=incompatible-pointer-types]
> >  4564 |         atomic64_set(&p->scx.ops_state, 0);
> >       |                      ^~~~~~~~~~~~~~~~~
> >       |                      |
> >       |                      atomic_long_t * {aka atomic_t *}
> > 
> ...
> > > +static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
> > > +{
> > > +	if (p->scx.flags & SCX_TASK_QUEUED) {
> > > +		WARN_ON_ONCE(atomic64_read(&p->scx.ops_state) != SCX_OPSS_NONE);
> > 
> > Ditto. Even if this line is replaced later by
> > "[PATCH 31/36] sched_ext: Implement core-sched support"
> > 
> > > +		dispatch_dequeue(&rq->scx, p);
> > > +	}
> > > +
> > > +	p->se.exec_start = rq_clock_task(rq);
> > > +}
> 
> Sorry about that. I updated them and will include the changes in the next
> iteration. Will test 32bit build too next time.
> 
> Thanks.

No problem, if you don't I'll test it for you. :)

-Andrea
