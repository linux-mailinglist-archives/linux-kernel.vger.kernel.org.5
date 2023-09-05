Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB757929E1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354237AbjIEQ3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353664AbjIEHJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:09:23 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D960D1B4;
        Tue,  5 Sep 2023 00:09:19 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-401da71b7c5so21746475e9.2;
        Tue, 05 Sep 2023 00:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693897758; x=1694502558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9EkFXVhb7l8seeMvEs227a8hKeXNE+yg3rnGUe+wdzY=;
        b=hjET8OsUE9oYwgDsf34tQMxG6pIOKu4swCcGBzqw+n55lNjmCGnwMffFY3hLl1qQ3n
         8mW7rFFBOQ64G7Sv0isG2G3+NVD7+cdJOUCiZYTb3QOQdGchPj4Rj/TkQYLzDUDD427P
         ybi6lK3d9eqNB6XlLnPvZAbJ3WaTLjPZ5k0quxGBvDNRvqzJ8+QAbNG8ln8DXYHVaDhK
         wf0iHt3GbfW3dU5G7A38/M9hfrfZvNsS5zMqT6azZ4UmAtrBYtN1ehZqBTkF4qU4O+Jf
         0SfhKw4UNLyyZSi2OuSe5ml7oRoawdI+zCw20+22+t1scGRTUu2EAbSkzpaJtHphk6Uk
         p7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693897758; x=1694502558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EkFXVhb7l8seeMvEs227a8hKeXNE+yg3rnGUe+wdzY=;
        b=fZWmXwhVuW9RqUYtaoOYYGUNqVg+7J9U6uNyvFlZBNMPBJTJSARyoSD8xnxBkUA2W4
         WeApKdUXYr6PKKLXVaNGayHRctJtt+CPDU9KPjPuVGxpJv/eyawOeWCenHKo18aXPls0
         vWgGTPydxt8ZqPy1AlsbPUOBDPnj+/H7V4qgG9eYVsnhi/MrGVkMcp2NqkNd0WaDNxlP
         Tz5PAyzkfzUzmopt2bvJfr7/lfsfryt9KARTtWLy2d2MkmIVaP58N4zn8O+BZap7b0QC
         u+f/cb8UK1MNWAoBfLqCCkiWA7bICajBtw5AChVIRsVBvUBYXhbIU1ZM0ffrJ9HB46LQ
         JUjQ==
X-Gm-Message-State: AOJu0YznjMODF+YEwCPbgVyN+Vx+NToDlk0nY5W4qKawcHtOdhQjH2Re
        YfGwxpqL1gZNgrzeTaq2iD8=
X-Google-Smtp-Source: AGHT+IEfTqNOZjPICJomY8nLIu9YJ5nBcAfu1xIgEX8N4KNWkLjQi/7KkTSjdA9RqJI3eLIva8UBaw==
X-Received: by 2002:a1c:6a19:0:b0:401:bf56:8bb2 with SMTP id f25-20020a1c6a19000000b00401bf568bb2mr8200417wmc.10.1693897758167;
        Tue, 05 Sep 2023 00:09:18 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id l3-20020a1ced03000000b003feae747ff2sm19385673wmh.35.2023.09.05.00.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 00:09:16 -0700 (PDT)
Date:   Tue, 5 Sep 2023 08:09:16 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
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
Message-ID: <571d4a4a-0674-4c84-b714-8e7582699e30@lucifer.local>
References: <20230904180806.1002832-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904180806.1002832-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 06:08:04PM +0000, Joel Fernandes (Google) wrote:
> It is unsafe to dump vmalloc area information when trying to do so from
> some contexts. Add a safer trylock version of the same function to do a
> best-effort VMA finding and use it from vmalloc_dump_obj().

It'd be nice to have more details as to precisely which contexts and what this
resolves.

>
> [applied test robot feedback on unused function fix.]
> [applied Uladzislau feedback on locking.]
>
> Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: rcu@vger.kernel.org
> Cc: Zqiang <qiang.zhang1211@gmail.com>
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Fixes: 98f180837a89 ("mm: Make mem_dump_obj() handle vmalloc() memory")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  mm/vmalloc.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
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

It'd be good to have a comment here explaining why we must trylock here. I am
also concerned that in the past this function would return false only if the
address was not a vmalloc one, but now it might just return false due to lock
contention and the user has no idea which it is?

I'd want to at least output "vmalloc region cannot lookup lock contention"
vs. the below cannot find case.

Under heavy lock contention aren't you potentially breaking the ability to
introspect vmalloc addresses? Wouldn't it be better to explicitly detect the
contexts under which acquiring this spinlock is not appropriate?

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
> --
> 2.42.0.283.g2d96d420d3-goog
>
