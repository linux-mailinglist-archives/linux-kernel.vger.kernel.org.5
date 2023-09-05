Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38095792801
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbjIEQCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354451AbjIELrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:47:15 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4E61AD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 04:47:11 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7927f241772so96430239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 04:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693914430; x=1694519230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+kMHasHVGTn26MkV0Q3sK5DIWqCalskCsDPU3m7M6q0=;
        b=LC+h8u6cF0c0fLz/EIVeetNf8OEC2QS079RJZ8N9WcXC6VmZ2pYTkzD7WOafMP7Fn+
         GJ6sG4Q66AxRqaNEOAgonm8+2zQAZtlo+QaO2Rk+535guRHEdPp5r4h+jJo8ME0JkFvv
         h52rJZiAXrwfDr7Gnlzg8XeyArkWE02SjP4bU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693914430; x=1694519230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kMHasHVGTn26MkV0Q3sK5DIWqCalskCsDPU3m7M6q0=;
        b=HTR6DhsdmEM4RfrqzoF5Lo1kQu0pFMgssf/xUSqAg9Gq4GlIOWQyMk5OHPTnsoWzK2
         3gwoSu8alqedsLj+EYvdRLp0KyuvPn4+ULOgp2Oa8JI4g5c1KNzfL2J2ZYv/G2sgMQ4L
         0QGlcTLfbAh9I41UPs0BkqIpdaFHEh8KA3phfA/wPH2ZOxkLUCAm+JN8AyYXbeWRlshu
         9M3ibRIvqCFRSy6Q9jqSCU9Agn0xFGtSCBccMpwsCi2qoRQaegEONBS45YnkOgNMFoiM
         Awu0+giMX1Qy0ZH4tGlGplx+1WFXxy6MbGKbQ9lAQdL9yToUOssIthMSHttNcDZyqJNq
         NsIg==
X-Gm-Message-State: AOJu0YxQ9y2TsVeO/RZxxgaELHpSY7KVJzRexQA0Y8/rqUCpRrmGfqcf
        fFSTH/WInD7rdtWeeBBomN4jIw==
X-Google-Smtp-Source: AGHT+IHDwYBN4jbjbJ2InS/JWRLSveg7Bkkv+CFcAJjUWQW7JPDz2+SoDzDcEpMiiPdIjwRdBiw2KQ==
X-Received: by 2002:a5e:dc49:0:b0:785:5917:a35f with SMTP id s9-20020a5edc49000000b007855917a35fmr14731736iop.8.1693914430477;
        Tue, 05 Sep 2023 04:47:10 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id k26-20020a6b401a000000b0077e3566a801sm4266287ioa.29.2023.09.05.04.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 04:47:09 -0700 (PDT)
Date:   Tue, 5 Sep 2023 11:47:09 +0000
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
Message-ID: <20230905114709.GA3881391@google.com>
References: <20230904180806.1002832-1-joel@joelfernandes.org>
 <571d4a4a-0674-4c84-b714-8e7582699e30@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <571d4a4a-0674-4c84-b714-8e7582699e30@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 08:09:16AM +0100, Lorenzo Stoakes wrote:
> On Mon, Sep 04, 2023 at 06:08:04PM +0000, Joel Fernandes (Google) wrote:
> > It is unsafe to dump vmalloc area information when trying to do so from
> > some contexts. Add a safer trylock version of the same function to do a
> > best-effort VMA finding and use it from vmalloc_dump_obj().
> 
> It'd be nice to have more details as to precisely which contexts and what this
> resolves.

True. I was hoping the 'trylock' mention would be sufficient (example hardirq
context interrupting a lock-held region) but you're right.

> > [applied test robot feedback on unused function fix.]
> > [applied Uladzislau feedback on locking.]
> >
> > Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: rcu@vger.kernel.org
> > Cc: Zqiang <qiang.zhang1211@gmail.com>
> > Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Fixes: 98f180837a89 ("mm: Make mem_dump_obj() handle vmalloc() memory")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  mm/vmalloc.c | 26 ++++++++++++++++++++++----
> >  1 file changed, 22 insertions(+), 4 deletions(-)
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 93cf99aba335..2c6a0e2ff404 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -4274,14 +4274,32 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
> >  #ifdef CONFIG_PRINTK
> >  bool vmalloc_dump_obj(void *object)
> >  {
> > -	struct vm_struct *vm;
> >  	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
> > +	const void *caller;
> > +	struct vm_struct *vm;
> > +	struct vmap_area *va;
> > +	unsigned long addr;
> > +	unsigned int nr_pages;
> >
> > -	vm = find_vm_area(objp);
> > -	if (!vm)
> > +	if (!spin_trylock(&vmap_area_lock))
> > +		return false;
> 
> It'd be good to have a comment here explaining why we must trylock here. I am
> also concerned that in the past this function would return false only if the
> address was not a vmalloc one, but now it might just return false due to lock
> contention and the user has no idea which it is?
> 
> I'd want to at least output "vmalloc region cannot lookup lock contention"
> vs. the below cannot find case.

In the patch 2/2 we do print if the address looks like a vmalloc address even
if the vmalloc look up fails.

Also the reporter's usecase is not a common one. We only attempt to dump
information if there was a debug objects failure (example if somebody did a
double call_rcu). In such a situation, the patch will prevent a deadlock and
still print something about the address.

> Under heavy lock contention aren't you potentially breaking the ability to
> introspect vmalloc addresses? Wouldn't it be better to explicitly detect the
> contexts under which acquiring this spinlock is not appropriate?

Yes this is a good point, but there's another case as well: PREEMPT_RT can
sleep on lock contention (as spinlocks are sleeping) and we can't sleep from
call_rcu() as it may be called in contexts that cannot sleep. So we handle
that also using trylock.

Thanks for the review!

 - Joel


> 
> > +	va = __find_vmap_area((unsigned long)objp, &vmap_area_root);
> > +	if (!va) {
> > +		spin_unlock(&vmap_area_lock);
> >  		return false;
> > +	}
> > +
> > +	vm = va->vm;
> > +	if (!vm) {
> > +		spin_unlock(&vmap_area_lock);
> > +		return false;
> > +	}
> > +	addr = (unsigned long)vm->addr;
> > +	caller = vm->caller;
> > +	nr_pages = vm->nr_pages;
> > +	spin_unlock(&vmap_area_lock);
> >  	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
> > -		vm->nr_pages, (unsigned long)vm->addr, vm->caller);
> > +		nr_pages, addr, caller);
> >  	return true;
> >  }
> >  #endif
> > --
> > 2.42.0.283.g2d96d420d3-goog
> >
