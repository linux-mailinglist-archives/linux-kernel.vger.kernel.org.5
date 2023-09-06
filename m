Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2DD79467F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 00:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbjIFWqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 18:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjIFWqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 18:46:14 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DF819AE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 15:46:10 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7926b7f8636so8096939f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 15:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694040370; x=1694645170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Omk8h6qAI8/QBggIcV1LJ4IashJ7NgP8xYw8aRJySEM=;
        b=wBLGQYfYnStAMjWybLWIuTKmyEVxrVrNb+Fu4BQt7bOBO27XqhdYLEzaG1dH/nMGgE
         GAMYU7fvyM0cdp2c/ByVRaWGXCwps83zryfdwaa8a/3c4T3iyMjLRtUgyodQRq2RG9Ff
         iMdvUrRRu8NQKLFwEU1DDw/TKZlVOe6rvonkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694040370; x=1694645170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Omk8h6qAI8/QBggIcV1LJ4IashJ7NgP8xYw8aRJySEM=;
        b=ignly76jv+rg5327vbQhBEqRNsnGyq/87p5fwGl3T0C8z5ILlXswlNTkziSL7x0g0R
         0EkjQtD/2Odl2pP/K38PCJU5a0CrFVVxMmTD6pOKSXXLrG9XfP76BJlKiYC4PkO428ZR
         5a9sxahvDLYx1Rkxt+eaM7tSD6uYJ3YxQquP2/Tc8Mqzn1LPVq6MGEP8p9w1P0sazmR3
         iHugjaNrfn/3ignzvikEAFk0J9PtQExbIQ3PGJoiQ9uB/5z5nQEu0FhZ4jQvu3PiD6De
         XQUMlP8Yb/ZqfbtxHlaQZKe1jnIhJ5g1u98autCWJuF7YXK+gewqJWs5tmB0WUYLt5Ed
         6jvg==
X-Gm-Message-State: AOJu0YzC3U7RTqNHrvaCq+HR1u+JYDZHlpSYVb1+P0keEtqysEpwi+VA
        enmzkXnCB9FLfcihySHcsIEZeA==
X-Google-Smtp-Source: AGHT+IHp8evXSLOC7rntt6cZ3sHD+jrdtq6uVSsSZMx3E8qry9hjqQhqNWKp8kFBoRxi1VB+KVux7w==
X-Received: by 2002:a05:6602:70f:b0:790:aed5:d0b0 with SMTP id f15-20020a056602070f00b00790aed5d0b0mr1178474iox.0.1694040370078;
        Wed, 06 Sep 2023 15:46:10 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id s17-20020a6bd311000000b00790d72848efsm5210392iob.15.2023.09.06.15.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 15:46:09 -0700 (PDT)
Date:   Wed, 6 Sep 2023 22:46:08 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        rcu@vger.kernel.org, Zqiang <qiang.zhang1211@gmail.com>,
        stable@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/2] mm/vmalloc: Add a safer version of find_vm_area()
 for debug
Message-ID: <20230906224608.GB1646335@google.com>
References: <20230904180806.1002832-1-joel@joelfernandes.org>
 <571d4a4a-0674-4c84-b714-8e7582699e30@lucifer.local>
 <20230905114709.GA3881391@google.com>
 <CAA5enKbvrvTx=d6MgLZjupnsEuoCnRN8e9p+ffnJV1rJS+HkXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA5enKbvrvTx=d6MgLZjupnsEuoCnRN8e9p+ffnJV1rJS+HkXA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 08:23:18PM +0100, Lorenzo Stoakes wrote:
> On Tue, 5 Sept 2023 at 12:47, Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Tue, Sep 05, 2023 at 08:09:16AM +0100, Lorenzo Stoakes wrote:
> > > On Mon, Sep 04, 2023 at 06:08:04PM +0000, Joel Fernandes (Google) wrote:
> > > > It is unsafe to dump vmalloc area information when trying to do so from
> > > > some contexts. Add a safer trylock version of the same function to do a
> > > > best-effort VMA finding and use it from vmalloc_dump_obj().
> > >
> > > It'd be nice to have more details as to precisely which contexts and what this
> > > resolves.
> >
> > True. I was hoping the 'trylock' mention would be sufficient (example hardirq
> > context interrupting a lock-held region) but you're right.
> >
> > > > [applied test robot feedback on unused function fix.]
> > > > [applied Uladzislau feedback on locking.]
> > > >
> > > > Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
> > > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > > Cc: rcu@vger.kernel.org
> > > > Cc: Zqiang <qiang.zhang1211@gmail.com>
> > > > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > Fixes: 98f180837a89 ("mm: Make mem_dump_obj() handle vmalloc() memory")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > ---
> > > >  mm/vmalloc.c | 26 ++++++++++++++++++++++----
> > > >  1 file changed, 22 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index 93cf99aba335..2c6a0e2ff404 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -4274,14 +4274,32 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
> > > >  #ifdef CONFIG_PRINTK
> > > >  bool vmalloc_dump_obj(void *object)
> > > >  {
> > > > -   struct vm_struct *vm;
> > > >     void *objp = (void *)PAGE_ALIGN((unsigned long)object);
> > > > +   const void *caller;
> > > > +   struct vm_struct *vm;
> > > > +   struct vmap_area *va;
> > > > +   unsigned long addr;
> > > > +   unsigned int nr_pages;
> > > >
> > > > -   vm = find_vm_area(objp);
> > > > -   if (!vm)
> > > > +   if (!spin_trylock(&vmap_area_lock))
> > > > +           return false;
> > >
> > > It'd be good to have a comment here explaining why we must trylock here. I am
> > > also concerned that in the past this function would return false only if the
> > > address was not a vmalloc one, but now it might just return false due to lock
> > > contention and the user has no idea which it is?
> > >
> > > I'd want to at least output "vmalloc region cannot lookup lock contention"
> > > vs. the below cannot find case.
> >
> > In the patch 2/2 we do print if the address looks like a vmalloc address even
> > if the vmalloc look up fails.
> 
> No, you output exactly what was output before, only changing what it
> means and in no way differentiating between couldn't find vmalloc
> area/couldn't get lock.

2/2 does this:
                         -     if (virt_addr_valid(object))
                         +     if (is_vmalloc_addr(object))
                         +             type = "vmalloc memory";
                         +     else if (virt_addr_valid(object))
                                       type = "non-slab/vmalloc memory";

This code is executed only if vmalloc_dump_obj() returns false. The
is_vmalloc_addr() was added by 2/2 which is newly added right?

You are right we are not differentiating between trylock failure and failure to
find the vmalloc area. I was just saying, even though we don't differentiate,
we do print "vmalloc memory" right? That wasn't being printed before.

> > Also the reporter's usecase is not a common one. We only attempt to dump
> > information if there was a debug objects failure (example if somebody did a
> > double call_rcu). In such a situation, the patch will prevent a deadlock and
> > still print something about the address.
> 
> Right, but the function still purports to do X but does Y.
> 
> >
> > > Under heavy lock contention aren't you potentially breaking the ability to
> > > introspect vmalloc addresses? Wouldn't it be better to explicitly detect the
> > > contexts under which acquiring this spinlock is not appropriate?
> >
> > Yes this is a good point, but there's another case as well: PREEMPT_RT can
> > sleep on lock contention (as spinlocks are sleeping) and we can't sleep from
> > call_rcu() as it may be called in contexts that cannot sleep. So we handle
> > that also using trylock.
> 
> Right so somebody now has to find this email to realise that. I hate
> implicit knowledge like this, it needs a comment. It also furthers the
> point that it'd be useful to differentiate between the two.

This is a valid point, and I acknowledged it in last email. A code comment could
indeed be useful.

So I guess from an agreement standpoint, I agree:

1/2 could use an additional comment explaining why we need trylock (sighting
the RT sleeping lock issue).

2/2 could update the existing code to convert "non-slab/vmalloc" to
"non-slab/non-vmalloc". Note: that's an *existing* issue.

The issue in 2/2 is not a new one so that can certainly be a separate patch.
And while at it, we could update the comment in that patch as well.

But the whole differentiating between trylock vs vmalloc area lookup failure
is not that useful -- just my opinion fwiw! I honestly feel differentiating
between trylock vs vmalloc area lookup failure complicates the code because
it will require passing this information down from vmalloc_dump_obj() to the
caller AFAICS and I am not sure if the person reading the debug will really
care much. But I am OK with whatever the -mm community wants and I am happy
to send out a new patch on top with the above that I agree on since Andrew
took these 2 (but for the stuff I don't agree, I would appreciate if you
could send a patch for review and I am happy to review it!).

As you mentioned, this series is a stability fix and we can put touch-ups on
top of it if needed, and there is also plenty of time till the next merge
window. Allow me a few days and I'll do the new patch on top (I'd say dont
bother to spend your time on it, I'll do it).

thanks,

 - Joel


> 
> 
> -- 
> Lorenzo Stoakes
> https://ljs.io
