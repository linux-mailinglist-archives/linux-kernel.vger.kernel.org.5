Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B3879136E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 10:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345417AbjIDI3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 04:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjIDI3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:29:50 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC15CD8;
        Mon,  4 Sep 2023 01:29:46 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-500c7796d8eso1805157e87.1;
        Mon, 04 Sep 2023 01:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693816185; x=1694420985; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FSQN7fQrN24zOcl+Pz1ofkIl/DUjbLFfNjlnwngy+q8=;
        b=VFI2ZCkWpshMA/bgcw+6fT6xeQR9E5ukBNl4C1gD46UwHP/VxaitvuKXLcRlp2+ny8
         8CTDiWMraeVxk2ZdSMJ1CCKJO2Jee3BEwoNVCU7zXfQp/SRKSJtm0CEeusixm++2sqdD
         pBt0orqiFcqv2paqEKWQZ2ddh+TKYBtYTjBOdJRd8NbnrmW1J72iQpG8SsYAGxuklmIe
         HPn2DJ20TU19mUs91kN4Q/mHyaUSKg31RmG4mOmwbKgL7wq4go9vsywYDCkD989bQzub
         4nAYyKJ0R4FLXr4O/h07mbqjOpJnGjgm2Amp/1jxrPzdNNlp7cfx7fNT0wNOHoj1LPUA
         s2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693816185; x=1694420985;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSQN7fQrN24zOcl+Pz1ofkIl/DUjbLFfNjlnwngy+q8=;
        b=FdaLYIjjiUpWJEW4qx6mM3iyh2lpA7kdJyOAbj4NZaeu42pTmXrEFBOMUgLXFdP5W9
         g7zEkvmdXfTsSdv4Qjnu9DigktsDrGb1+y3aAOxjVDjZBuqxUjtLcEPR+OZ9Q6hrOxgb
         Q2R9sDpwTOGjCpeBvLMU1naz4IWAJwuzDKPk2Az6j1HeUMeBEWlZpeRstOtCnuquDGOg
         /wAO9+VoMA47T70oEtjsfJ2u6LW0O/y/hLG+GX2DCWAWEJs8f7Uo2W+FU+cHZhD1sqX+
         oaixBY2307uxRafbZAvklQ7TG1iKxlknVcUJ1++32RFz9MlJN5eGeuLG4u6VYAA8+noi
         jj6Q==
X-Gm-Message-State: AOJu0YxgO7f8Dz9ghIv6AtB8QBdcYXTqkl7QtIKvdafOH+/mUMt+iFgP
        n4g098mGjhzNUIUvv/KDNQ1i8l3/8aM=
X-Google-Smtp-Source: AGHT+IElqWJcui3EeYMMBUsZPvO53t34k8zy+aGUzwGn20FizbdtafmlhAUIwiHLVvPxfX8faVTnyQ==
X-Received: by 2002:ac2:4f0a:0:b0:500:ca0f:605e with SMTP id k10-20020ac24f0a000000b00500ca0f605emr6690362lfr.6.1693816184732;
        Mon, 04 Sep 2023 01:29:44 -0700 (PDT)
Received: from pc636 (host-90-235-20-237.mobileonline.telia.com. [90.235.20.237])
        by smtp.gmail.com with ESMTPSA id c19-20020ac244b3000000b005008b5191aesm1604815lfm.284.2023.09.04.01.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 01:29:44 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 4 Sep 2023 10:29:41 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Zqiang <qiang.zhang1211@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] mm/vmalloc: Add a safer version of find_vm_area()
 for debug
Message-ID: <ZPWVdYvoAPdIBTyt@pc636>
References: <ZPHdjvFwvtzXO/6z@pc636>
 <AF34FDF1-CAD9-43FD-B97D-F6A7439F310A@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AF34FDF1-CAD9-43FD-B97D-F6A7439F310A@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 12:41:24PM -0400, Joel Fernandes wrote:
> 
> 
> > On Sep 1, 2023, at 8:48 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > 
> > ﻿On Fri, Sep 01, 2023 at 12:33:21AM +0000, Joel Fernandes wrote:
> >>> On Fri, Sep 01, 2023 at 12:19:17AM +0000, Joel Fernandes wrote:
> >>> On Thu, Aug 31, 2023 at 09:47:52PM +0200, Uladzislau Rezki wrote:
> >>>> On Thu, Aug 31, 2023 at 05:18:25PM +0000, Joel Fernandes (Google) wrote:
> >>>>> It is unsafe to dump vmalloc area information when trying to do so from
> >>>>> some contexts. Add a safer trylock version of the same function to do a
> >>>>> best-effort VMA finding and use it from vmalloc_dump_obj().
> >>>>> 
> >>>>> [apply test robot feedback on unused function fix.]
> >>>>> 
> >>>>> Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
> >>>>> Cc: Paul E. McKenney <paulmck@kernel.org>
> >>>>> Cc: rcu@vger.kernel.org
> >>>>> Cc: Zqiang <qiang.zhang1211@gmail.com>
> >>>>> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> >>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >>>>> ---
> >>>>> v1->v2: Apply review tags and test robot feedback.
> >>>>> 
> >>>>> mm/vmalloc.c | 39 ++++++++++++++++++++++++++++++++++++++-
> >>>>> 1 file changed, 38 insertions(+), 1 deletion(-)
> >>>>> 
> >>>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> >>>>> index 93cf99aba335..f09e882ae3b8 100644
> >>>>> --- a/mm/vmalloc.c
> >>>>> +++ b/mm/vmalloc.c
> >>>>> @@ -1865,6 +1865,20 @@ struct vmap_area *find_vmap_area(unsigned long addr)
> >>>>>    return va;
> >>>>> }
> >>>>> 
> >>>>> +#ifdef CONFIG_PRINTK
> >>>>> +static struct vmap_area *find_vmap_area_trylock(unsigned long addr)
> >>>>> +{
> >>>>> +    struct vmap_area *va;
> >>>>> +
> >>>>> +    if (!spin_trylock(&vmap_area_lock))
> >>>>> +        return NULL;
> >>>>> +    va = __find_vmap_area(addr, &vmap_area_root);
> >>>>> +    spin_unlock(&vmap_area_lock);
> >>>>> +
> >>>>> +    return va;
> >>>>> +}
> >>>>> +#endif
> >>>>> +
> >>>>> static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
> >>>>> {
> >>>>>    struct vmap_area *va;
> >>>>> @@ -2671,6 +2685,29 @@ struct vm_struct *find_vm_area(const void *addr)
> >>>>>    return va->vm;
> >>>>> }
> >>>>> 
> >>>>> +/**
> >>>>> + * try_to_find_vm_area - find a continuous kernel virtual area
> >>>>> + * @addr:      base address
> >>>>> + *
> >>>>> + * This function is the same as find_vm_area() except that it is
> >>>>> + * safe to call if vmap_area_lock is already held and returns NULL
> >>>>> + * if it is. See comments in find_vmap_area() for other details.
> >>>>> + *
> >>>>> + * Return: the area descriptor on success or %NULL on failure.
> >>>>> + */
> >>>>> +#ifdef CONFIG_PRINTK
> >>>>> +static struct vm_struct *try_to_find_vm_area(const void *addr)
> >>>>> +{
> >>>>> +    struct vmap_area *va;
> >>>>> +
> >>>>> +    va = find_vmap_area_trylock((unsigned long)addr);
> >>>>> +    if (!va)
> >>>>> +        return NULL;
> >>>>> +
> >>>>> +    return va->vm;
> >>>>> +}
> >>>>> +#endif
> >>>>> +
> >>>>> /**
> >>>>>  * remove_vm_area - find and remove a continuous kernel virtual area
> >>>>>  * @addr:        base address
> >>>>> @@ -4277,7 +4314,7 @@ bool vmalloc_dump_obj(void *object)
> >>>>>    struct vm_struct *vm;
> >>>>>    void *objp = (void *)PAGE_ALIGN((unsigned long)object);
> >>>>> 
> >>>>> -    vm = find_vm_area(objp);
> >>>>> +    vm = try_to_find_vm_area(objp);
> >>>>>    if (!vm)
> >>>>>        return false;
> >>>>>    pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
> >>> 
> >>> Hi Vlad,
> >>> Thanks for taking a look.
> >>> 
> >>>> I am not sure if this patch makes a lot of sense. I agree, this is a
> >>>> problem and it mitigates it. But it is broken in terms of once you drop
> >>>> the lock, the VA should not be accessed.
> >>> 
> >>> Just to note the lockless-access issue you are referring to is not introduced
> >>> by this patch but is rather in the existing code. Also just to note this is
> >>> debug code.
> >>> 
> >>>> Is that a real issue or it gets triggered due to some syntetic test case?
> >>> 
> >>> It is a real issue. See 2/2.
> >>> 
> >>>> If i were you, i would go with open-coded version of trylock. Because
> >>>> there is only one user so far.
> >>> 
> >>> Taking your open coding and locking suggestions, I came up with the below
> >>> which actually results in a smaller patch. Does it look good to you?
> >>> 
> >>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> >>> index 93cf99aba335..aaf6bad997a7 100644
> >> 
> >> And with some trivial compiler errors fixed (sorry should have build tested
> >> but wanted to just share the idea earlier):
> >> 
> >> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> >> index 93cf99aba335..2c6a0e2ff404 100644
> >> --- a/mm/vmalloc.c
> >> +++ b/mm/vmalloc.c
> >> @@ -4274,14 +4274,32 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
> >> #ifdef CONFIG_PRINTK
> >> bool vmalloc_dump_obj(void *object)
> >> {
> >> -    struct vm_struct *vm;
> >>    void *objp = (void *)PAGE_ALIGN((unsigned long)object);
> >> +    const void *caller;
> >> +    struct vm_struct *vm;
> >> +    struct vmap_area *va;
> >> +    unsigned long addr;
> >> +    unsigned int nr_pages;
> >> 
> >> -    vm = find_vm_area(objp);
> >> -    if (!vm)
> >> +    if (!spin_trylock(&vmap_area_lock))
> >> +        return false;
> >> +    va = __find_vmap_area((unsigned long)objp, &vmap_area_root);
> >> +    if (!va) {
> >> +        spin_unlock(&vmap_area_lock);
> >>        return false;
> >> +    }
> >> +
> >> +    vm = va->vm;
> >> +    if (!vm) {
> >> +        spin_unlock(&vmap_area_lock);
> >> +        return false;
> >> +    }
> >> +    addr = (unsigned long)vm->addr;
> >> +    caller = vm->caller;
> >> +    nr_pages = vm->nr_pages;
> >> +    spin_unlock(&vmap_area_lock);
> >>    pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
> >> -        vm->nr_pages, (unsigned long)vm->addr, vm->caller);
> >> +        nr_pages, addr, caller);
> >>    return true;
> >> }
> >> #endif
> >> 
> > Looks good to me and thank you for fixing a locking issue :)
> > I think you will re-spin and resend it one more time?
> 
> Yes. May I add your Reviewed-by tag to both patches after re-spinning as mentioned above?
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
