Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B6178F38D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347251AbjHaTsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjHaTsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:48:03 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980D6E7F;
        Thu, 31 Aug 2023 12:47:56 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5009969be25so2141451e87.3;
        Thu, 31 Aug 2023 12:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693511275; x=1694116075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SP7TySB2lx9oeTcWR9xzk9DZs28Uo52pxRwlR9h0oYE=;
        b=boer5GdvChbwk5y4PcriBl7oZq7io7wgKIkOMLwNPUoGrP7pg3QjZgjve9BbfkqY+R
         ErGsd99CEVt4fILbtzGK11RGWRtZh6XfOds01XdFswchDZkTQXIh3u0ZzyqFz32mWfO/
         6E6eJ9SORvencWPxLCBPFLc1K/L5CrhirAUPoXyawHeFefpgvYS43GdxMy+UJZL8rTKA
         aOFgLwOA+cwIRjQlDPZXFjE3eeoG6ORij3tScnNBDS+0E8VKK6xzxWtOkNVZHQL79v4q
         EhhMcMO822PF2Q1Mhq6dVhaSZnrAyfmsTtO2X4GuJB3COjwUREyzyvfjCFRguyYeKM3t
         gL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693511275; x=1694116075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SP7TySB2lx9oeTcWR9xzk9DZs28Uo52pxRwlR9h0oYE=;
        b=gmBB/luhY4caxasrbXEFok5y1T/SFMB6ZEDZCj1N6p2FDyF23XQJK2zodcBCQlGDdA
         CUar0yCbGuRNWhlqUb4Ew4z2wzImNDIiC2RVfZQpjxDzrnFA+NBcga2ntjm0NuAFJa3i
         ZobQxbmbtiuEMszGl0/mCIUEVaM8Y2hoP3QpBSmw5NMLpqkZBlpOee3pCSlxuuoS3ndi
         AqJu8+798pGbIvuuhJocM/ir1BWy0NShtngfCvZKwkO+MTPpbSvaOBwIQu5bhvW/+ODm
         /9+/4h+irmQHUSgxGUr0XFTGkOjk0Beq33yb6dPHg08NxlJY922sI+lUwjHtvDcRRcdK
         AItA==
X-Gm-Message-State: AOJu0Yw5nF+u6lZwLJ9oRAr+Esjq55VgODLoG9Bc8XiNRW/kvgOlPO3U
        yLER4MvvoU95dBD12r9Vtm8=
X-Google-Smtp-Source: AGHT+IFEJkN5eVx2umhjiyHxQLqR70bhX744axFi5IzfUINZasMrBF4W8Gt6ZSafIP6tcdqLKEDfrg==
X-Received: by 2002:a05:6512:3994:b0:500:b64f:afbe with SMTP id j20-20020a056512399400b00500b64fafbemr226655lfu.19.1693511274531;
        Thu, 31 Aug 2023 12:47:54 -0700 (PDT)
Received: from pc636 ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id t6-20020a19ad06000000b004fe2e94f8fdsm386459lfc.236.2023.08.31.12.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 12:47:54 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Thu, 31 Aug 2023 21:47:52 +0200
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Zqiang <qiang.zhang1211@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] mm/vmalloc: Add a safer version of find_vm_area()
 for debug
Message-ID: <ZPDuaI2kTTKCivXa@pc636>
References: <20230831171827.2625016-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831171827.2625016-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 05:18:25PM +0000, Joel Fernandes (Google) wrote:
> It is unsafe to dump vmalloc area information when trying to do so from
> some contexts. Add a safer trylock version of the same function to do a
> best-effort VMA finding and use it from vmalloc_dump_obj().
> 
> [apply test robot feedback on unused function fix.]
> 
> Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: rcu@vger.kernel.org
> Cc: Zqiang <qiang.zhang1211@gmail.com>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> v1->v2: Apply review tags and test robot feedback.
> 
>  mm/vmalloc.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 93cf99aba335..f09e882ae3b8 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1865,6 +1865,20 @@ struct vmap_area *find_vmap_area(unsigned long addr)
>  	return va;
>  }
>  
> +#ifdef CONFIG_PRINTK
> +static struct vmap_area *find_vmap_area_trylock(unsigned long addr)
> +{
> +	struct vmap_area *va;
> +
> +	if (!spin_trylock(&vmap_area_lock))
> +		return NULL;
> +	va = __find_vmap_area(addr, &vmap_area_root);
> +	spin_unlock(&vmap_area_lock);
> +
> +	return va;
> +}
> +#endif
> +
>  static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
>  {
>  	struct vmap_area *va;
> @@ -2671,6 +2685,29 @@ struct vm_struct *find_vm_area(const void *addr)
>  	return va->vm;
>  }
>  
> +/**
> + * try_to_find_vm_area - find a continuous kernel virtual area
> + * @addr:	  base address
> + *
> + * This function is the same as find_vm_area() except that it is
> + * safe to call if vmap_area_lock is already held and returns NULL
> + * if it is. See comments in find_vmap_area() for other details.
> + *
> + * Return: the area descriptor on success or %NULL on failure.
> + */
> +#ifdef CONFIG_PRINTK
> +static struct vm_struct *try_to_find_vm_area(const void *addr)
> +{
> +	struct vmap_area *va;
> +
> +	va = find_vmap_area_trylock((unsigned long)addr);
> +	if (!va)
> +		return NULL;
> +
> +	return va->vm;
> +}
> +#endif
> +
>  /**
>   * remove_vm_area - find and remove a continuous kernel virtual area
>   * @addr:	    base address
> @@ -4277,7 +4314,7 @@ bool vmalloc_dump_obj(void *object)
>  	struct vm_struct *vm;
>  	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
>  
> -	vm = find_vm_area(objp);
> +	vm = try_to_find_vm_area(objp);
>  	if (!vm)
>  		return false;
>  	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
>
I am not sure if this patch makes a lot of sense. I agree, this is a
problem and it mitigates it. But it is broken in terms of once you drop
the lock, the VA should not be accessed.

Is that a real issue or it gets triggered due to some syntetic test case?

If i were you, i would go with open-coded version of trylock. Because
there is only one user so far.

--
Uladzislau Rezki
