Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0510B75457D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 01:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjGNXsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 19:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjGNXs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 19:48:28 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54F23A92
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 16:48:27 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 6D7F75C00F1;
        Fri, 14 Jul 2023 19:48:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 14 Jul 2023 19:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689378504; x=1689464904; bh=teMqNN02RSJ2b
        kTjzb3BWQ6jP2WdqFm/hOsAEhSxC/c=; b=D0jV7YjtYWohs+zi3ANkBfczlK6J4
        MdQVGx/kKvgjR8R5lT0LMjFH1gfZL7MPHcoCvSAto8kkI6MK6PgLKJKAXRh2Obkn
        3XGZE/IPYrusXOUfkBg3v5CPzMmAc53cVn/RGuFxDRdo4hWJcMSWMa3hxzlv/+/S
        3qOHhbLAJ4lxPDf2U3Syz/fvM5AXNtEJN293tZ7bgphqQezhe0K5uHvIeu8BhaWJ
        D9evAT0SpQQoh8BB3k4t+DXqthHA+mpnjBn7bTTxH1xy/zBsH8ZaD1DOB0RSy3VH
        t6LGwutKt7DTt9DNhBCTuU5lweByEMhy20tp02ifjrW3N3T86ZbTda+MA==
X-ME-Sender: <xms:x96xZGPtztdBBx9NI5PCD8wXaqXtsS7qgPCzr0pBJXzniNwhN5yU3Q>
    <xme:x96xZE8hnMV2e93JaY29mgwt2fA8mG10EjwvG3gclZ7U4h0ZErVUaM2SGPImO239P
    b7S5zn4tekgANV53Fc>
X-ME-Received: <xmr:x96xZNSAm5fSSBtQ7b7yeK89C7CHbBb1P0DRGHSAE0kJCyZrK6k78m5dGoQAIw4Elor75PMnVwDSVwTP_NcCA_PoGsQzs4HP3-I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeejgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepleeuheelheekgfeuvedtveetjeekhfffkeeffffftdfgjeevkeegfedvueeh
    ueelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
    hthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:x96xZGu-RyNVnX05zK_h-_z-XSwXuWzcDl8v9PSEXsrt4qWL8-2p3Q>
    <xmx:x96xZOf5hwtL1YOPs6fOUb6Ib2SU3jI7UxBu-dzQr1wTF7ymnTAIGw>
    <xmx:x96xZK2NRUddmavCzg4DLUl9DUHSSLPwiqzHP-Vh6j835rnnyqdvUA>
    <xmx:yN6xZPXTjGp19PiTBlRouucbbit8S_4ESr2oe63xn_-cWTw3A8o8KQ>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jul 2023 19:48:20 -0400 (EDT)
Date:   Sat, 15 Jul 2023 09:48:14 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Frederic Weisbecker <frederic@kernel.org>
cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Optimize in_task() and in_interrupt() a bit
In-Reply-To: <ZLE5bSAy6857cq9B@lothringen>
Message-ID: <e6212d06-821b-f879-862d-fef8090fdde7@linux-m68k.org>
References: <44ad7a7afa1b8b1383426971402d2901361db1c5.1689326311.git.fthain@linux-m68k.org> <ZLE5bSAy6857cq9B@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Frederic,

Thanks for your review.

On Fri, 14 Jul 2023, Frederic Weisbecker wrote:

> On Fri, Jul 14, 2023 at 07:18:31PM +1000, Finn Thain wrote:
> > Except on x86, preempt_count is always accessed with READ_ONCE.
> > Repeated invocations in macros like irq_count() produce repeated loads.
> > These redundant instructions appear in various fast paths. In the one
> > shown below, for example, irq_count() is evaluated during kernel entry
> > if !tick_nohz_full_cpu(smp_processor_id()).
> > 
> > 0001ed0a <irq_enter_rcu>:
> >    1ed0a:       4e56 0000       linkw %fp,#0
> >    1ed0e:       200f            movel %sp,%d0
> >    1ed10:       0280 ffff e000  andil #-8192,%d0
> >    1ed16:       2040            moveal %d0,%a0
> >    1ed18:       2028 0008       movel %a0@(8),%d0
> >    1ed1c:       0680 0001 0000  addil #65536,%d0
> >    1ed22:       2140 0008       movel %d0,%a0@(8)
> >    1ed26:       082a 0001 000f  btst #1,%a2@(15)
> >    1ed2c:       670c            beqs 1ed3a <irq_enter_rcu+0x30>
> >    1ed2e:       2028 0008       movel %a0@(8),%d0
> >    1ed32:       2028 0008       movel %a0@(8),%d0
> >    1ed36:       2028 0008       movel %a0@(8),%d0
> >    1ed3a:       4e5e            unlk %fp
> >    1ed3c:       4e75            rts
> > 
> > This patch doesn't prevent the pointless btst and beqs instructions
> > above, but it does eliminate 2 of the 3 pointless move instructions
> > here and elsewhere.
> > 
> > On x86, preempt_count is per-cpu data and the problem does not arise
> > perhaps because the compiler is free to perform similar optimizations.
> > 
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Fixes: 15115830c887 ("preempt: Cleanup the macro maze a bit")
> 
> Does this optimization really deserves a "Fixes:" tag?
> 

If commit 15115830c887 produced a performance regression then the fixes 
tag is required by Documentation/process/handling-regressions.rst. 

I didn't tackle that question because the m68k port doesn't have high 
resolution timers or hardware instrumentation like those available on say, 
arm64 or ppc64.

Perhaps someone could submit this patch for automated testing on a 
suitable architecture?

> > Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> > ---
> > This patch was tested on m68k and x86. I was expecting no changes
> > to object code for x86 and mostly that's what I saw. However, there
> > were a few places where code generation was perturbed for some reason.
> > ---
> >  include/linux/preempt.h | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> > index 0df425bf9bd7..953358e40291 100644
> > --- a/include/linux/preempt.h
> > +++ b/include/linux/preempt.h
> > @@ -102,10 +102,11 @@ static __always_inline unsigned char interrupt_context_level(void)
> >  #define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
> >  #ifdef CONFIG_PREEMPT_RT
> >  # define softirq_count()	(current->softirq_disable_cnt & SOFTIRQ_MASK)
> > +# define irq_count()		((preempt_count() & (NMI_MASK | HARDIRQ_MASK)) | softirq_count())
> >  #else
> >  # define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
> > +# define irq_count()		(preempt_count() & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_MASK))
> >  #endif
> > -#define irq_count()	(nmi_count() | hardirq_count() | softirq_count())
> 
> Perhaps add a comment as to why you're making these two versions (ie: 
> because that avoids three consecutive reads), otherwise people may be 
> tempted to roll that back again in the future to make the code shorter.
> 

OK.

> >  
> >  /*
> >   * Macros to retrieve the current execution context:
> > @@ -118,7 +119,11 @@ static __always_inline unsigned char interrupt_context_level(void)
> >  #define in_nmi()		(nmi_count())
> >  #define in_hardirq()		(hardirq_count())
> >  #define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
> > -#define in_task()		(!(in_nmi() | in_hardirq() | in_serving_softirq()))
> > +#ifdef CONFIG_PREEMPT_RT
> > +# define in_task()		(!((preempt_count() & (NMI_MASK | HARDIRQ_MASK)) | in_serving_softirq()))
> > +#else
> > +# define in_task()		(!(preempt_count() & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
> > +#endif
> 
> Same here, thanks!
> 

Will do.

> >  
> >  /*
> >   * The following macros are deprecated and should not be used in new code:
> > -- 
> > 2.39.3
> > 
> 
