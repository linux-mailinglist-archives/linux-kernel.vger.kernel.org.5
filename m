Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6154177EA52
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345879AbjHPUE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344763AbjHPUER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:04:17 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95215E55
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=wzBDW3Wc5hk0OfboVj+g7WZUiK4x0cKMEeegm+uAsyM=; b=gqhJHlsAmoO07vwPpYb6/uEuTF
        uoSbgT1KYS4PzYsWahJrcfkIU5zaimYAHEK3ppbgIicNiVmegzsPll+TeI2nMSbMzo/74NAfNQfWV
        QQqriFfZoDIWukQmq1Bas/p3a/YULx3DdC5WbbtfgAGW0HskdnJXt9Bu4xT6iIKDlHc/X732ivH7z
        rcYehzhiy5SpNTbZE+QZuQ3tqeADF3OqRBwMdZw8kYNTFbYJaPjMl2c/F52RRN3DBPLkgoOZ9/L9h
        WP0CYIwdMrSmyeoRPDRBrtqxsxagY7MiRVTfaJN94aZH7DR9E20xoXNZQDfFVCd6i+C+H5D1rTmpu
        Jvm7+6sg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qWMkP-00DFa1-2n;
        Wed, 16 Aug 2023 20:04:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4CC2C3001FD;
        Wed, 16 Aug 2023 22:04:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A15D20FCB7B4; Wed, 16 Aug 2023 22:04:05 +0200 (CEST)
Date:   Wed, 16 Aug 2023 22:04:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Galbraith <umgwanakikbuti@gmail.com>
Cc:     Chen Yu <yu.c.chen@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [tip:sched/eevdf] [sched/fair]  e0c2ff903c:
 phoronix-test-suite.blogbench.Write.final_score -34.8% regression
Message-ID: <20230816200405.GA998718@hirez.programming.kicks-ass.net>
References: <202308101628.7af4631a-oliver.sang@intel.com>
 <ZNWKuccyWnS3UJjK@chenyu5-mobl2.bbrouter>
 <ZNWgAeN/EVS/vOLi@chenyu5-mobl2.bbrouter>
 <20230814132935.GK776869@hirez.programming.kicks-ass.net>
 <bd96d883d0d1575ebbee4323f4396596adb0ad09.camel@gmail.com>
 <20230816123716.GI980931@hirez.programming.kicks-ass.net>
 <20230816134059.GC982867@hirez.programming.kicks-ass.net>
 <3d10fbfb0171cc017e19adf39fa97a3160a76206.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d10fbfb0171cc017e19adf39fa97a3160a76206.camel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 05:38:20PM +0200, Mike Galbraith wrote:
> On Wed, 2023-08-16 at 15:40 +0200, Peter Zijlstra wrote:
> > On Wed, Aug 16, 2023 at 02:37:16PM +0200, Peter Zijlstra wrote:
> > > On Mon, Aug 14, 2023 at 08:32:55PM +0200, Mike Galbraith wrote:
> > > 
> > > > --- a/kernel/sched/fair.c
> > > > +++ b/kernel/sched/fair.c
> > > > @@ -875,6 +875,12 @@ static struct sched_entity *pick_eevdf(s
> > > >         if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
> > > >                 curr = NULL;
> > > >  
> > > > +       /*
> > > > +        * Once selected, run the task to parity to avoid overscheduling.
> > > > +        */
> > > > +       if (sched_feat(RUN_TO_PARITY) && curr)
> > > > +               return curr;
> > > > +
> > > >         while (node) {
> > > >                 struct sched_entity *se = __node_2_se(node);
> > > >  
> > > 
> > > So I read it wrong last night... but I rather like this idea. But
> > > there's something missing. When curr starts a new slice it should
> > > probably do a full repick and not stick with it.
> > > 
> > > Let me poke at this a bit.. nice
> > 
> > Something like so.. it shouldn't matter much now, but might make a
> > difference once we start mixing different slice lengths.
> 
> Hm, that stash the deadline trick _seems_ to have cured the reason I
> was inspired to added that XXX hunk.. no 'ew, that's a tad harsh'
> latency penalty in sight <knocks wood>.
> 
> Here's hoping test bots don't have a cow. 

You want to write up a Changelog for this, or should I attempt to write
one?
