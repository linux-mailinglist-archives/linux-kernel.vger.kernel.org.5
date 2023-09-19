Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D13B7A57D5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 05:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjISDVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 23:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjISDVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 23:21:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15F095
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 20:21:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26EEC433CA;
        Tue, 19 Sep 2023 03:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695093694;
        bh=2LmdUZ93iSSVlvHPq9dbFfq6CmmQx0dj2FhDOilY2EE=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=T9UqLjel250GdB/Fn2eQngGfDU+//WxgXbilQglPIIbh3xV0GsuoisDdzUJ3ox0vN
         NEb17M//LANRGDt8rLOk5vPOQFLN+WVhr7fPx0707AeU1S4zANOEulyC8nqgyjwUDd
         EUju5t+k5bmhOWx/ty2qF47/xxbPnWjwDTsLLGAtKdrl9mvv1AOxBUb42LYubuKyLS
         XA75B6FgrO6+hriGxOoBGm52bi9wROUdC0WkQv3Z4U9V1XQgfP70mqKV9iYfEL9jXP
         4EpL/POP4nyGe33INfVceyZ75dTGfNoPZ1lY6ux6xLnutnAH3iP10+yd5NaEIATvKh
         K2IaDfz0LRrQQ==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id BC0BA27C005B;
        Mon, 18 Sep 2023 23:21:32 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Mon, 18 Sep 2023 23:21:32 -0400
X-ME-Sender: <xms:uxMJZZvG9pKEDo2RR6Tt5fn4VchqguznfZk9diXapgRu1rFul4WW_g>
    <xme:uxMJZSfuWxKrmFToszHsp55fKyOURWro-udqwGw7jXAE2aN5zmb0hEtaDfe7I1Mmz
    1M1zvjW7QgxqrLGqlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudejledgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdfhuedvtdfhudffhfekkefftefghfeltdelgeffteehueegjeff
    udehgfetiefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:uxMJZczIb77Gypio7HmaUhbBx08ZZkTEmZJnHVtjPP7Hw7e1dtMfeg>
    <xmx:uxMJZQMz88waIY_DIFwFznTCs1CeP30glI2lMHFWKsa2P3x_Rn5Uxw>
    <xmx:uxMJZZ8uaaBhKrGBVqvYJ-4XqbllEU6swLPbgbRKa_rOMGydVe1w8A>
    <xmx:vBMJZQgbKSl3voaX06UACPZvIrxQfl8XHr4f7CJAJySC1jgOzK1dmQ>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 35DA131A0064; Mon, 18 Sep 2023 23:21:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <39998df7-8882-43ae-8c7e-936c24eb4041@app.fastmail.com>
In-Reply-To: <20230830184958.2333078-8-ankur.a.arora@oracle.com>
References: <20230830184958.2333078-1-ankur.a.arora@oracle.com>
 <20230830184958.2333078-8-ankur.a.arora@oracle.com>
Date:   Mon, 18 Sep 2023 20:21:11 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Ankur Arora" <ankur.a.arora@oracle.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, "the arch/x86 maintainers" <x86@kernel.org>
Cc:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, "Ingo Molnar" <mingo@redhat.com>,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>, mgorman@suse.de,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Jon Grimm" <jon.grimm@amd.com>, "Bharata B Rao" <bharata@amd.com>,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 7/9] sched: define TIF_ALLOW_RESCHED
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023, at 11:49 AM, Ankur Arora wrote:
> On preempt_model_none() or preempt_model_voluntary() configurations
> rescheduling of kernel threads happens only when they allow it, and
> only at explicit preemption points, via calls to cond_resched() or
> similar.
>
> That leaves out contexts where it is not convenient to periodically
> call cond_resched() -- for instance when executing a potentially long
> running primitive (such as REP; STOSB.)
>

So I said this not too long ago in the context of Xen PV, but maybe it's time to ask it in general:

Why do we support anything other than full preempt?  I can think of two reasons, neither of which I think is very good:

1. Once upon a time, tracking preempt state was expensive.  But we fixed that.

2. Folklore suggests that there's a latency vs throughput tradeoff, and serious workloads, for some definition of serious, want throughput, so they should run without full preemption.

I think #2 is a bit silly.  If you want throughput, and you're busy waiting for a CPU that wants to run you, but it's not because it's running some low-priority non-preemptible thing (because preempt is set to none or volunary), you're not getting throughput.  If you want to get keep some I/O resource busy to get throughput, but you have excessive latency getting scheduled, you don't get throughput.

If the actual problem is that there's a workload that performs better when scheduling is delayed (which preempt=none and preempt=volunary do, essentialy at random), then maybe someone should identify that workload and fix the scheduler.

So maybe we should just very strongly encourage everyone to run with full preempt and simplify the kernel?
