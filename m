Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C607A5E8C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjISJuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjISJuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:50:07 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8031F0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:50:00 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-401187f8071so36523945e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695116998; x=1695721798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EhcN/lwEEoB6hHokS07vdHgzChk+CLg70p3seLqswTM=;
        b=M2yVBpBrRekVPq2VUQJa61ThwKXl8xaVB8ql8HxKHvO+0krOUOFHrOmezylLdk4F/G
         1bTLxwjXrTQHF20TiVeVXh5alBb1T4+vLmhyV58nONrA8Kk+xtZL7iAGZl6Lz+vYpgjR
         kj59KmOEMuxRPNRjciFpQVKpeyf0BtnKlRRMPCX+7ZMqTQhO3LpfvrKAokfeVYp9z7NZ
         9UkV9wFWZ2mbfPC8PL+IoNePxVj2Seh4yGvQxTJFdJ/aakHfdjUMkm/IP8pfqhm05PyR
         pwWMdJU2ReQbQ+aiyStmA2Qha6pdhrmlgwuwJY7FdQXcCmYk0o+hH3+64+9WDgx95FYf
         8yrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695116998; x=1695721798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EhcN/lwEEoB6hHokS07vdHgzChk+CLg70p3seLqswTM=;
        b=IWVSYuGckHxdJWtd8VfAhIZKf+do/k3NHlNR2P2ijDgk/WOgv/poW8kwnuTUGG6Bhb
         jfaKHZyOfsPLX/EwyXi31/nJYXjrpJDS7wqXlGFfBRSPBkskjUTzIBCgUs6K4mjuK+43
         DJXXUw0v0YyjcY+0W9JrLjHx+oZvcTYR7NMBNq3Nta+ywJ17zBkeUOWkhqkW6ZhaCMjY
         hTxsWMigFW3cRP32BuMfMe/9T7Zn2IHmMuSHEIwWkIVzLf5K38g3dkOPV+l/afw+oHhc
         iwpmts5jCJXb/1LVJuEM3E40+ctzrwhwtS9viBXQQwWeN36n9dV9nGpy9B7Cv4R0VndW
         Orzw==
X-Gm-Message-State: AOJu0Yxwdd3/+WdGcB3esbPZzOHDmAvbe/EoLfR4OgtV/IgZPb62vPNP
        jue+aHe8imzYRBErquhh37eIQ7A+BMQ=
X-Google-Smtp-Source: AGHT+IESAxiN5Y9yOBY1Na857XazpwqoJPdlaVeSUc6fqY3EB7N3Bi635X8rAsPrIk+tNBFf/wNzDQ==
X-Received: by 2002:a05:600c:3488:b0:400:5962:6aa9 with SMTP id a8-20020a05600c348800b0040059626aa9mr1564056wmq.11.1695116998275;
        Tue, 19 Sep 2023 02:49:58 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600c11ce00b003fee8502999sm17525375wmi.18.2023.09.19.02.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 02:49:57 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 19 Sep 2023 11:49:54 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>, mgorman@suse.de,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jon Grimm <jon.grimm@amd.com>, Bharata B Rao <bharata@amd.com>,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Message-ID: <ZQluwllEnTxvyIgU@gmail.com>
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com>
 <39998df7-8882-43ae-8c7e-936c24eb4041@app.fastmail.com>
 <87pm2ewmcy.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pm2ewmcy.ffs@tglx>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, Sep 18 2023 at 20:21, Andy Lutomirski wrote:
> > On Wed, Aug 30, 2023, at 11:49 AM, Ankur Arora wrote:
> 
> > Why do we support anything other than full preempt?  I can think of
> > two reasons, neither of which I think is very good:
> >
> > 1. Once upon a time, tracking preempt state was expensive.  But we fixed that.
> >
> > 2. Folklore suggests that there's a latency vs throughput tradeoff,
> >    and serious workloads, for some definition of serious, want
> >    throughput, so they should run without full preemption.
> 
> It's absolutely not folklore. Run to completion is has well known 
> benefits as it avoids contention and avoids the overhead of scheduling 
> for a large amount of scenarios.
> 
> We've seen that painfully in PREEMPT_RT before we came up with the 
> concept of lazy preemption for throughput oriented tasks.

Yeah, for a large majority of workloads reduction in preemption increases 
batching and improves cache locality. Most scalability-conscious enterprise 
users want longer timeslices & better cache locality, not shorter 
timeslices with spread out cache use.

There's microbenchmarks that fit mostly in cache that benefit if work is 
immediately processed by freshly woken tasks - but that's not true for most 
workloads with a substantial real-life cache footprint.

Thanks,

	Ingo
