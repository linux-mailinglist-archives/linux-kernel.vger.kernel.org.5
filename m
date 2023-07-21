Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA92675CF4F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjGUQav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjGUQac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:30:32 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E895B4696;
        Fri, 21 Jul 2023 09:28:34 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-345f1e0abf9so10807355ab.3;
        Fri, 21 Jul 2023 09:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689956842; x=1690561642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S3AT9u4QYD/Wmgzx+LQ7tGvuXiSmv6bkSA1iGoHjJQg=;
        b=fjH568Cn0Ae9taITeR/wmXP/KuAtqs93r4wHiEC6pwWin6wWHFPOXIw/PR+zggpgFU
         jFKBIHSIIp3HsAT9zDFuUaJEDtLZ61t7kN8pI3gjRxE6jZtpCIVtF1nYAwjMIt4oBaqm
         UpJOGMIl7+2/ppouWfwKTrdn2ijafiTZJ/Q1KkfFN9okCvhfuBm027ZuVSNqJAM6nHtv
         PEmpFDNJqAHWd2Wf8TzM8uWtCMGIbKalXy7FFPd+asTpKa6nbdFhNlYHgabDEVBqrMIN
         9ZnQAia5FnrGzd5rNZSQbHM8GrIbkCj+5Ee4R/wVfVf2HSwqcBNGiRhSPQMDifdBjTXU
         Mteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689956842; x=1690561642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3AT9u4QYD/Wmgzx+LQ7tGvuXiSmv6bkSA1iGoHjJQg=;
        b=FG1CNtBO+7hs0e7mN6/NFWXaV7JbmZcHJUorqbwlA+QaG+wnrM9bT93mIaZflOV8zS
         ugNU2j7yrUMJV0T+oW6EMTNZIb9OepWyZ1xfyYaHVsTW75TKbnYrJsnNJT9d5awFuTw6
         UDT1RRaVdQ2Hzo2ZjvH2Qnsm27PfvyoK/ZCIJ7fbJFBYA0UMIrsgJlFkvbEAFlIjLceO
         /4nryqAd5Hr4E6+yKooQXXp3oyuw8t4G15uNianHv330AJ+QrV1rWCVZZXyZw3fIAp2D
         N9NL25/usTh4WX8Qg6StAviv7lxrQUPlgZcA5tGF8ofTwT+SMscDsfdQFIS6j6EFwhAH
         5dvw==
X-Gm-Message-State: ABy/qLZB1zIbqnWc1CnLcJtHo4HySdhfSWsBhzdr2x6LPpm9pDd5byue
        0KmG6+q9Ou78M8x0IIZCMKs=
X-Google-Smtp-Source: APBJJlHADgT0H57/m/leaU87Jo7QnmAE3rRRESunjxsKp1ybjsdfDtYMXEUUYSVjIiYJ9goc0GO2oQ==
X-Received: by 2002:a92:c245:0:b0:348:7d72:48cf with SMTP id k5-20020a92c245000000b003487d7248cfmr520290ilo.17.1689956842190;
        Fri, 21 Jul 2023 09:27:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l8-20020a922908000000b003460b697bc0sm1058482ilg.59.2023.07.21.09.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 09:27:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 21 Jul 2023 09:27:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Dimitris Papastamos <dp@opensource.wolfsonmicro.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] regmap: rbtree: Use alloc_flags for memory allocations
Message-ID: <dbe99062-6e35-44b1-9e33-5ebc0fed9e6d@roeck-us.net>
References: <58f12a07-5f4b-4a8f-ab84-0a42d1908cb9@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58f12a07-5f4b-4a8f-ab84-0a42d1908cb9@moroto.mountain>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 05:55:33PM +0300, Dan Carpenter wrote:
> The kunit tests discovered a sleeping in atomic bug.  The allocations
> in the regcache-rbtree code should use the map->alloc_flags instead of
> GFP_KERNEL.
> 
> [    5.005510] BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
> [    5.005960] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 117, name: kunit_try_catch
> [    5.006219] preempt_count: 1, expected: 0
> [    5.006414] 1 lock held by kunit_try_catch/117:
> [    5.006590]  #0: 833b9010 (regmap_kunit:86:(config)->lock){....}-{2:2}, at: regmap_lock_spinlock+0x14/0x1c
> [    5.007493] irq event stamp: 162
> [    5.007627] hardirqs last  enabled at (161): [<80786738>] crng_make_state+0x1a0/0x294
> [    5.007871] hardirqs last disabled at (162): [<80c531ec>] _raw_spin_lock_irqsave+0x7c/0x80
> [    5.008119] softirqs last  enabled at (0): [<801110ac>] copy_process+0x810/0x2138
> [    5.008356] softirqs last disabled at (0): [<00000000>] 0x0
> [    5.008688] CPU: 0 PID: 117 Comm: kunit_try_catch Tainted: G                 N 6.4.4-rc3-g0e8d2fdfb188 #1
> [    5.009011] Hardware name: Generic DT based system
> [    5.009277]  unwind_backtrace from show_stack+0x18/0x1c
> [    5.009497]  show_stack from dump_stack_lvl+0x38/0x5c
> [    5.009676]  dump_stack_lvl from __might_resched+0x188/0x2d0
> [    5.009860]  __might_resched from __kmem_cache_alloc_node+0x1dc/0x25c
> [    5.010061]  __kmem_cache_alloc_node from kmalloc_trace+0x30/0xc8
> [    5.010254]  kmalloc_trace from regcache_rbtree_write+0x26c/0x468
> [    5.010446]  regcache_rbtree_write from _regmap_write+0x88/0x140
> [    5.010634]  _regmap_write from regmap_write+0x44/0x68
> [    5.010803]  regmap_write from basic_read_write+0x8c/0x270
> [    5.010980]  basic_read_write from kunit_try_run_case+0x48/0xa0
> 
> Fixes: 28644c809f44 ("regmap: Add the rbtree cache support")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/all/ee59d128-413c-48ad-a3aa-d9d350c80042@roeck-us.net/
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
> This patch is similar to what I sent earlier, but I changed
> regcache_rbtree_init() back to using GFP_KERNEL.
> 
>  drivers/base/regmap/regcache-rbtree.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/regmap/regcache-rbtree.c b/drivers/base/regmap/regcache-rbtree.c
> index fabf87058d80..ae6b8788d5f3 100644
> --- a/drivers/base/regmap/regcache-rbtree.c
> +++ b/drivers/base/regmap/regcache-rbtree.c
> @@ -277,7 +277,7 @@ static int regcache_rbtree_insert_to_block(struct regmap *map,
>  
>  	blk = krealloc(rbnode->block,
>  		       blklen * map->cache_word_size,
> -		       GFP_KERNEL);
> +		       map->alloc_flags);
>  	if (!blk)
>  		return -ENOMEM;
>  
> @@ -286,7 +286,7 @@ static int regcache_rbtree_insert_to_block(struct regmap *map,
>  	if (BITS_TO_LONGS(blklen) > BITS_TO_LONGS(rbnode->blklen)) {
>  		present = krealloc(rbnode->cache_present,
>  				   BITS_TO_LONGS(blklen) * sizeof(*present),
> -				   GFP_KERNEL);
> +				   map->alloc_flags);
>  		if (!present)
>  			return -ENOMEM;
>  
> @@ -320,7 +320,7 @@ regcache_rbtree_node_alloc(struct regmap *map, unsigned int reg)
>  	const struct regmap_range *range;
>  	int i;
>  
> -	rbnode = kzalloc(sizeof(*rbnode), GFP_KERNEL);
> +	rbnode = kzalloc(sizeof(*rbnode), map->alloc_flags);
>  	if (!rbnode)
>  		return NULL;
>  
> @@ -346,13 +346,13 @@ regcache_rbtree_node_alloc(struct regmap *map, unsigned int reg)
>  	}
>  
>  	rbnode->block = kmalloc_array(rbnode->blklen, map->cache_word_size,
> -				      GFP_KERNEL);
> +				      map->alloc_flags);
>  	if (!rbnode->block)
>  		goto err_free;
>  
>  	rbnode->cache_present = kcalloc(BITS_TO_LONGS(rbnode->blklen),
>  					sizeof(*rbnode->cache_present),
> -					GFP_KERNEL);
> +					map->alloc_flags);
>  	if (!rbnode->cache_present)
>  		goto err_free_block;
>  
> -- 
> 2.39.2
> 
