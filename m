Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F1D797BA7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239198AbjIGSY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234379AbjIGSY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:24:26 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33953B2;
        Thu,  7 Sep 2023 11:24:20 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-402c46c49f4so13658275e9.1;
        Thu, 07 Sep 2023 11:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694111058; x=1694715858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8532Pq0Hp+d+66El84szs8ANQmJzGPBQuAp6uqTUXPE=;
        b=mAJIkrPDHO95i1PGUqn4iwjMukLsM8vxnxPdbu3r4Um2e92ktudfa2bL3GJrAgYnGI
         +TCR2BbDNTFl+S41urOLEJwE6yW1k5Oa+C//xZOffNfitaCMw3wH5DAU04IpeLfDftMd
         19fRQHSlNp39AHL3KT0hf2qTlXbvjEoLV10/H7Xw1R+SZcrbgrw/OsRy9z525iPVMRBg
         rLonniCE54chy+zmC/CGlP4I894KTQfpQFNd/2k0fgXTFi6jYCl6hp3FIZSTuFNF2W4i
         9ynKi4CG4VJcmqe1rdbsigbk2qsDzL08I4ghGvjpVOxzRQqVB6zj/KEdFD3nkPgrLjf0
         sHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694111058; x=1694715858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8532Pq0Hp+d+66El84szs8ANQmJzGPBQuAp6uqTUXPE=;
        b=G5G9y7tze59NjeFQrS8X2kqtkjL96VqQyWqrdqdkeWONnCaClyXqJSYdiYSbm/HX98
         m5nO8v3DVIUQurX2lZkomlKccPRfKbArNYoOoYQMjOIvlfpu3gliP4vPFGZbSvJrSbk4
         eNGAFAR1DTW9xG8qdXhfrkgsTeitq+n1c/f5ya6Dr2oEYIG2MD2/w/OL3+MYVLRwv4R/
         iFFLxn/QgT3Oe1NJWAF1f0abS41q82f4FxPEY3Mh1qVID9WnImOoFkXQfF8gjT//SYQU
         foG03XPJg5DGS0HPP2Q6Jo48fCQ/bukTqScBUPHib/iN0o8abHeZUfKWMcQL+CDzRh1i
         OHcg==
X-Gm-Message-State: AOJu0YzxXMqKTMAJwXG67+i7V+z9q56StwoPGwhghYo3DYWWEvCdYw9U
        ZlYopyJJEZGNksqq5dnpGWz6+s6kbUFsaQ==
X-Google-Smtp-Source: AGHT+IE/TUE721ddUKqwc/3UzFPNOXH4kRo+bamMen9urGIi6QHbzH5Mta+NhM9DYk/d01WUxwXhQw==
X-Received: by 2002:ac2:57c5:0:b0:4f8:77db:1d9e with SMTP id k5-20020ac257c5000000b004f877db1d9emr3692746lfo.12.1694078623634;
        Thu, 07 Sep 2023 02:23:43 -0700 (PDT)
Received: from pc636 (host-90-235-20-237.mobileonline.telia.com. [90.235.20.237])
        by smtp.gmail.com with ESMTPSA id c26-20020ac244ba000000b004fe432108aesm3062843lfm.261.2023.09.07.02.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 02:23:43 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 7 Sep 2023 11:23:40 +0200
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org,
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
Message-ID: <ZPmWnGG9b0JXsR54@pc636>
References: <20230904180806.1002832-1-joel@joelfernandes.org>
 <571d4a4a-0674-4c84-b714-8e7582699e30@lucifer.local>
 <20230905114709.GA3881391@google.com>
 <CAA5enKbvrvTx=d6MgLZjupnsEuoCnRN8e9p+ffnJV1rJS+HkXA@mail.gmail.com>
 <20230906224608.GB1646335@google.com>
 <499537a7-3380-4355-ae34-df7f5c0f41bd@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <499537a7-3380-4355-ae34-df7f5c0f41bd@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 08:11:48AM +0100, Lorenzo Stoakes wrote:
> On Wed, Sep 06, 2023 at 10:46:08PM +0000, Joel Fernandes wrote:
> > On Wed, Sep 06, 2023 at 08:23:18PM +0100, Lorenzo Stoakes wrote:
> > > On Tue, 5 Sept 2023 at 12:47, Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >
> > > > On Tue, Sep 05, 2023 at 08:09:16AM +0100, Lorenzo Stoakes wrote:
> > > > > On Mon, Sep 04, 2023 at 06:08:04PM +0000, Joel Fernandes (Google) wrote:
> > > > > > It is unsafe to dump vmalloc area information when trying to do so from
> > > > > > some contexts. Add a safer trylock version of the same function to do a
> > > > > > best-effort VMA finding and use it from vmalloc_dump_obj().
> > > > >
> > > > > It'd be nice to have more details as to precisely which contexts and what this
> > > > > resolves.
> > > >
> > > > True. I was hoping the 'trylock' mention would be sufficient (example hardirq
> > > > context interrupting a lock-held region) but you're right.
> > > >
> > > > > > [applied test robot feedback on unused function fix.]
> > > > > > [applied Uladzislau feedback on locking.]
> > > > > >
> > > > > > Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
> > > > > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > > > > Cc: rcu@vger.kernel.org
> > > > > > Cc: Zqiang <qiang.zhang1211@gmail.com>
> > > > > > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > > Fixes: 98f180837a89 ("mm: Make mem_dump_obj() handle vmalloc() memory")
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > ---
> > > > > >  mm/vmalloc.c | 26 ++++++++++++++++++++++----
> > > > > >  1 file changed, 22 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > > > index 93cf99aba335..2c6a0e2ff404 100644
> > > > > > --- a/mm/vmalloc.c
> > > > > > +++ b/mm/vmalloc.c
> > > > > > @@ -4274,14 +4274,32 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
> > > > > >  #ifdef CONFIG_PRINTK
> > > > > >  bool vmalloc_dump_obj(void *object)
> > > > > >  {
> > > > > > -   struct vm_struct *vm;
> > > > > >     void *objp = (void *)PAGE_ALIGN((unsigned long)object);
> > > > > > +   const void *caller;
> > > > > > +   struct vm_struct *vm;
> > > > > > +   struct vmap_area *va;
> > > > > > +   unsigned long addr;
> > > > > > +   unsigned int nr_pages;
> > > > > >
> > > > > > -   vm = find_vm_area(objp);
> > > > > > -   if (!vm)
> > > > > > +   if (!spin_trylock(&vmap_area_lock))
> > > > > > +           return false;
> > > > >
> > > > > It'd be good to have a comment here explaining why we must trylock here. I am
> > > > > also concerned that in the past this function would return false only if the
> > > > > address was not a vmalloc one, but now it might just return false due to lock
> > > > > contention and the user has no idea which it is?
> > > > >
> > > > > I'd want to at least output "vmalloc region cannot lookup lock contention"
> > > > > vs. the below cannot find case.
> > > >
> > > > In the patch 2/2 we do print if the address looks like a vmalloc address even
> > > > if the vmalloc look up fails.
> > >
> > > No, you output exactly what was output before, only changing what it
> > > means and in no way differentiating between couldn't find vmalloc
> > > area/couldn't get lock.
> >
> > 2/2 does this:
> >                          -     if (virt_addr_valid(object))
> >                          +     if (is_vmalloc_addr(object))
> >                          +             type = "vmalloc memory";
> >                          +     else if (virt_addr_valid(object))
> >                                        type = "non-slab/vmalloc memory";
> >
> > This code is executed only if vmalloc_dump_obj() returns false. The
> > is_vmalloc_addr() was added by 2/2 which is newly added right?
> >
> > You are right we are not differentiating between trylock failure and failure to
> > find the vmalloc area. I was just saying, even though we don't differentiate,
> > we do print "vmalloc memory" right? That wasn't being printed before.
> >
> > > > Also the reporter's usecase is not a common one. We only attempt to dump
> > > > information if there was a debug objects failure (example if somebody did a
> > > > double call_rcu). In such a situation, the patch will prevent a deadlock and
> > > > still print something about the address.
> > >
> > > Right, but the function still purports to do X but does Y.
> > >
> > > >
> > > > > Under heavy lock contention aren't you potentially breaking the ability to
> > > > > introspect vmalloc addresses? Wouldn't it be better to explicitly detect the
> > > > > contexts under which acquiring this spinlock is not appropriate?
> > > >
> > > > Yes this is a good point, but there's another case as well: PREEMPT_RT can
> > > > sleep on lock contention (as spinlocks are sleeping) and we can't sleep from
> > > > call_rcu() as it may be called in contexts that cannot sleep. So we handle
> > > > that also using trylock.
> > >
> > > Right so somebody now has to find this email to realise that. I hate
> > > implicit knowledge like this, it needs a comment. It also furthers the
> > > point that it'd be useful to differentiate between the two.
> >
> > This is a valid point, and I acknowledged it in last email. A code comment could
> > indeed be useful.
> 
> Thanks, yeah this may seem trivial, but I am quite sensitive about things
> being added to the code base that are neither described in commit msg nor
> in a comment or elsewhere and become 'implicit' in a sense.
> 
> So just a simple comment here would be helpful, and I'm glad we're in
> agreement on that, will leave to you to do a follow up patch.
> 
> >
> > So I guess from an agreement standpoint, I agree:
> >
> > 1/2 could use an additional comment explaining why we need trylock (sighting
> > the RT sleeping lock issue).
> >
> > 2/2 could update the existing code to convert "non-slab/vmalloc" to
> > "non-slab/non-vmalloc". Note: that's an *existing* issue.
> 
> Yeah sorry this whole thing was rather confusing, it did indeed (unclearly)
> specify non-/non- in the past (on assumption dumping function would work),
> addition of vmalloc check now makes that correct again, the phrasing is the
> issue.
> 
> You can leave this as-is as yeah, you're right, this was a pre-existing issue.
> 
> virt_addr_valid() returns true for a slab addr, but kmem_valid_obj() is
> checked above so already been ruled out, now you ruled out vmalloc.
> 
> Just a bit tricksy.
> 
> >
> > The issue in 2/2 is not a new one so that can certainly be a separate patch.
> > And while at it, we could update the comment in that patch as well.
> >
> > But the whole differentiating between trylock vs vmalloc area lookup failure
> > is not that useful -- just my opinion fwiw! I honestly feel differentiating
> > between trylock vs vmalloc area lookup failure complicates the code because
> > it will require passing this information down from vmalloc_dump_obj() to the
> > caller AFAICS and I am not sure if the person reading the debug will really
> > care much. But I am OK with whatever the -mm community wants and I am happy
> > to send out a new patch on top with the above that I agree on since Andrew
> > took these 2 (but for the stuff I don't agree, I would appreciate if you
> > could send a patch for review and I am happy to review it!).
> 
> Ah right, I think maybe I wasn't clear, all I meant to suggest is to output
> log output rather than feed anything back to caller, something like:-
> 
> if (!spin_trylock(&vmap_area_lock)) {
>         pr_cont(" [couldn't acquire vmap lock]\n");
> 	...
> }
> 
> My concern is that in the past this function would only return false if it
> couldn't find the address in a VA, now it returns false also if you happen
> to call it when the spinlock is locked, which might be confusing for
> somebody debugging this.
> 
> HOWEVER, since you now indicate that the address is vmalloc anyway, and you
> _absolutely cannot_ give any further details safely, perhaps this
> additional information is indeed not that usful.
> 
> My concern was just feeling antsy that we suddenly don't do something
> because a lock happens to be applied but as you say that cannot be helped
> in certain contexts.
> 
> So actually, leave this.
> 
> >
> > As you mentioned, this series is a stability fix and we can put touch-ups on
> > top of it if needed, and there is also plenty of time till the next merge
> > window. Allow me a few days and I'll do the new patch on top (I'd say dont
> > bother to spend your time on it, I'll do it).
> 
> Ack, I was just a little frustrated we didn't reach a resolution on review
> (either deciding things could be deferred or having changes) before
> merge. Obviously fine to prioritise, but would be good to have that
> explicitly stated.
> 
> >
> > thanks,
> >
> >  - Joel
> >
> >
> > >
> > >
> 
> Anyway, so TL;DR:-
> 
> 1. As we both agree, add a comment to explain why you need the spin trylock.
> (there are no further steps :P)
> 
> And I don't believe this actually needs any further changes after this
> discussion*, so if you fancy doing a follow up to that effect that will
> suffice for me thanks!
> 
For PREEMPT_RT kernels we are not allowed to use "vmap parts" in non
slepable context, this is just reality, because we use a sleep type of
spinlock.

I am not sure how urgent we need this fix. But to me it looks like
debuging and corner case. Probably i am wrong and miss something.
But if it is correct, i would just bailout for RT kernel and rework
later in a more proper way. For example implement a safe way of RCU
scan but this is also another story.

--
Uladzislau Rezki
