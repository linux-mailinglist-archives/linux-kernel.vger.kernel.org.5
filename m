Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BDC78FDB8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238349AbjIAMtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbjIAMtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:49:20 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA8110E9;
        Fri,  1 Sep 2023 05:48:47 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-500cfb168c6so3315222e87.2;
        Fri, 01 Sep 2023 05:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693572497; x=1694177297; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eGOXW07GjMYn5LTraXxTz7P1J4B8hc0PWiBAI2yKczI=;
        b=Brw8Oi95epfDLELGuLJqSs8KI5b0xozrpXxTQUm6nfWUtzZrdIl/8a0JjBmzsOZ+bg
         5b0p2F43mHNiW/V+m2XkAvYN8zwWuymUV4gY5EUzbu0EydzyqIYot6Py8CsCwmIA0WsB
         6MF84hnUwuYTah1Z1i4t+NH76uONpWMO9ZQrT6KgigFCPQlP3DRruJd2GO2hN5EU3T4C
         ENPo+r+CZhxHy+IgSJb9SebIuIQEVhN3QkAeU2TQiYkBIFWY6FUD0ikBzyLcbimnFdhT
         Jq0++Tnaeyg0FjRJLM3FYk6OFsx9Qfuqetl2+Ca/Hl8sxBaOuO8ujl84u81vszvUNfas
         dwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693572497; x=1694177297;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGOXW07GjMYn5LTraXxTz7P1J4B8hc0PWiBAI2yKczI=;
        b=aR4QmxauZ/KkGPQj17PV9/gHoYQWIowpnlNSAugHn3ZBPdJQHkqivKUcmh5cuZ9qTJ
         ls5zR1aa4jnoK8R6F05FtE09i72UjLtbG6ER8tgjo6Q+86zaJ0odXvipblnCq87CLAOK
         0FSyh2M+cEan7CqvG40NVPCZdkru/e0FGssDwVVYamYfIiRL2gXIUERKCRvYib21XsWn
         6/Qx/zMxXXQJk4JDIqcSMJ6DDiKUuXTN7nDDv9hZ1Iu+iB6qfM+8Nwhzq4ETAJL30bQg
         UaLe+34+wNDlHtwSFGlOEiSRM3c5o4nfT1/8MuM6aDAyk6xd8hUdmKRKL/xFrwUG4e2Y
         1Xfg==
X-Gm-Message-State: AOJu0YyRudWeDJYz7QZkWCeGp9TXlBF6DBT6IaaartHSbu+JEpJPeBqY
        p+9VmgXCCX0mz9jsdV3h/Co=
X-Google-Smtp-Source: AGHT+IHgGEx64XHT9liHgSNAqotT+BxSq3/EKTJhW0vZg/JjPNnjhpHtMddphgYnIs8ztDR+zSEkIw==
X-Received: by 2002:a05:6512:3a83:b0:500:b7ed:1055 with SMTP id q3-20020a0565123a8300b00500b7ed1055mr1865540lfu.56.1693572496905;
        Fri, 01 Sep 2023 05:48:16 -0700 (PDT)
Received: from pc636 (host-90-235-3-170.mobileonline.telia.com. [90.235.3.170])
        by smtp.gmail.com with ESMTPSA id q4-20020ac25a04000000b004fdfd931888sm640741lfn.293.2023.09.01.05.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 05:48:16 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 1 Sep 2023 14:48:14 +0200
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
Message-ID: <ZPHdjvFwvtzXO/6z@pc636>
References: <20230831171827.2625016-1-joel@joelfernandes.org>
 <ZPDuaI2kTTKCivXa@pc636>
 <20230901001917.GA2723108@google.com>
 <20230901003321.GA3389909@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901003321.GA3389909@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 12:33:21AM +0000, Joel Fernandes wrote:
> On Fri, Sep 01, 2023 at 12:19:17AM +0000, Joel Fernandes wrote:
> > On Thu, Aug 31, 2023 at 09:47:52PM +0200, Uladzislau Rezki wrote:
> > > On Thu, Aug 31, 2023 at 05:18:25PM +0000, Joel Fernandes (Google) wrote:
> > > > It is unsafe to dump vmalloc area information when trying to do so from
> > > > some contexts. Add a safer trylock version of the same function to do a
> > > > best-effort VMA finding and use it from vmalloc_dump_obj().
> > > > 
> > > > [apply test robot feedback on unused function fix.]
> > > > 
> > > > Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
> > > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > > Cc: rcu@vger.kernel.org
> > > > Cc: Zqiang <qiang.zhang1211@gmail.com>
> > > > Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > ---
> > > > v1->v2: Apply review tags and test robot feedback.
> > > > 
> > > >  mm/vmalloc.c | 39 ++++++++++++++++++++++++++++++++++++++-
> > > >  1 file changed, 38 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index 93cf99aba335..f09e882ae3b8 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -1865,6 +1865,20 @@ struct vmap_area *find_vmap_area(unsigned long addr)
> > > >  	return va;
> > > >  }
> > > >  
> > > > +#ifdef CONFIG_PRINTK
> > > > +static struct vmap_area *find_vmap_area_trylock(unsigned long addr)
> > > > +{
> > > > +	struct vmap_area *va;
> > > > +
> > > > +	if (!spin_trylock(&vmap_area_lock))
> > > > +		return NULL;
> > > > +	va = __find_vmap_area(addr, &vmap_area_root);
> > > > +	spin_unlock(&vmap_area_lock);
> > > > +
> > > > +	return va;
> > > > +}
> > > > +#endif
> > > > +
> > > >  static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
> > > >  {
> > > >  	struct vmap_area *va;
> > > > @@ -2671,6 +2685,29 @@ struct vm_struct *find_vm_area(const void *addr)
> > > >  	return va->vm;
> > > >  }
> > > >  
> > > > +/**
> > > > + * try_to_find_vm_area - find a continuous kernel virtual area
> > > > + * @addr:	  base address
> > > > + *
> > > > + * This function is the same as find_vm_area() except that it is
> > > > + * safe to call if vmap_area_lock is already held and returns NULL
> > > > + * if it is. See comments in find_vmap_area() for other details.
> > > > + *
> > > > + * Return: the area descriptor on success or %NULL on failure.
> > > > + */
> > > > +#ifdef CONFIG_PRINTK
> > > > +static struct vm_struct *try_to_find_vm_area(const void *addr)
> > > > +{
> > > > +	struct vmap_area *va;
> > > > +
> > > > +	va = find_vmap_area_trylock((unsigned long)addr);
> > > > +	if (!va)
> > > > +		return NULL;
> > > > +
> > > > +	return va->vm;
> > > > +}
> > > > +#endif
> > > > +
> > > >  /**
> > > >   * remove_vm_area - find and remove a continuous kernel virtual area
> > > >   * @addr:	    base address
> > > > @@ -4277,7 +4314,7 @@ bool vmalloc_dump_obj(void *object)
> > > >  	struct vm_struct *vm;
> > > >  	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
> > > >  
> > > > -	vm = find_vm_area(objp);
> > > > +	vm = try_to_find_vm_area(objp);
> > > >  	if (!vm)
> > > >  		return false;
> > > >  	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
> > 
> > Hi Vlad,
> > Thanks for taking a look.
> > 
> > > I am not sure if this patch makes a lot of sense. I agree, this is a
> > > problem and it mitigates it. But it is broken in terms of once you drop
> > > the lock, the VA should not be accessed.
> > 
> > Just to note the lockless-access issue you are referring to is not introduced
> > by this patch but is rather in the existing code. Also just to note this is
> > debug code.
> > 
> > > Is that a real issue or it gets triggered due to some syntetic test case?
> > 
> > It is a real issue. See 2/2.
> > 
> > > If i were you, i would go with open-coded version of trylock. Because
> > > there is only one user so far.
> > 
> > Taking your open coding and locking suggestions, I came up with the below
> > which actually results in a smaller patch. Does it look good to you?
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 93cf99aba335..aaf6bad997a7 100644
> 
> And with some trivial compiler errors fixed (sorry should have build tested
> but wanted to just share the idea earlier):
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 93cf99aba335..2c6a0e2ff404 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4274,14 +4274,32 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
>  #ifdef CONFIG_PRINTK
>  bool vmalloc_dump_obj(void *object)
>  {
> -	struct vm_struct *vm;
>  	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
> +	const void *caller;
> +	struct vm_struct *vm;
> +	struct vmap_area *va;
> +	unsigned long addr;
> +	unsigned int nr_pages;
>  
> -	vm = find_vm_area(objp);
> -	if (!vm)
> +	if (!spin_trylock(&vmap_area_lock))
> +		return false;
> +	va = __find_vmap_area((unsigned long)objp, &vmap_area_root);
> +	if (!va) {
> +		spin_unlock(&vmap_area_lock);
>  		return false;
> +	}
> +
> +	vm = va->vm;
> +	if (!vm) {
> +		spin_unlock(&vmap_area_lock);
> +		return false;
> +	}
> +	addr = (unsigned long)vm->addr;
> +	caller = vm->caller;
> +	nr_pages = vm->nr_pages;
> +	spin_unlock(&vmap_area_lock);
>  	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
> -		vm->nr_pages, (unsigned long)vm->addr, vm->caller);
> +		nr_pages, addr, caller);
>  	return true;
>  }
>  #endif
>
Looks good to me and thank you for fixing a locking issue :)
I think you will re-spin and resend it one more time?

--
Uladzislau Rezki
