Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EE080699E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377179AbjLFI2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377123AbjLFI2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:28:30 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36453AB;
        Wed,  6 Dec 2023 00:28:36 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cf7a8ab047so28451665ad.1;
        Wed, 06 Dec 2023 00:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701851315; x=1702456115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0OhTf7i4X5voZ/FZ2Ct3sZZmvFDR7n3hZqKxzvAgYhg=;
        b=I5vbxrlzj5PFDDy8u2DgGHIpByZFVPxWd1Xu2SVy39yVL2uRlls2vBxwYSRAzWnvEc
         fYx9itRaeFSvMI1TLcgNY1VRNWZt2TMM0eWC5Xomv5U/dBfONawZdvqjVK1/7VzfnYYS
         9sVxAvGdjFQNeH2dHhYZjKJNZj2+rIEwdjJ/Z2Rupqm9u/diaD+PSYexO94sGUVniqPX
         IJWGfj+e82NT/39ss+utARdXjUPQdBaeDnskN7wCukjSMwOWMwMrlbv/yI20e9yx/tDk
         vb3xhdyytyn6Ee4H5LbzQe4v0c7Hd6cAoUax0B68m/RywHCEcdsO7yrm92netG7GqRHk
         az4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701851315; x=1702456115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OhTf7i4X5voZ/FZ2Ct3sZZmvFDR7n3hZqKxzvAgYhg=;
        b=TlFkWdV2Z+sDDAtea7wUgZ5mc2VtBVgM7YwLHGjsDD5MJ2hLAY+qZflex/x71bng3u
         nM9wjrwkVn1aFoMtSIVlofEdfLUzfcXr9NAO0FfjL6g3I63aqkDjAsRtcKP+WLHozd/Q
         wepVqTKRpuJKDJR9XD3IdTBimLx/yMNUpVHN8vlgQcfwOq+OFUbWVyZdDvd/kl/Zk5n7
         +iNBjv7jhxXyVuNCyZsegEe9I6E1xVOR/doPULCk/hO/7VxtfoagNBQs88I9NkRUIBeo
         UeVAMOaB32MffWP5A6R+/LqpB39tSApJB3UtS/6exy6VeSdMc7ovt2Bl4lOA/jomJKp6
         A50g==
X-Gm-Message-State: AOJu0YzUETJmycadqbqMjyZE09DbdPzvW4lTxKvKQKFYM/jft3eGADz6
        dld0MBkZOaPw/dcABBOCw19SuAxSkio=
X-Google-Smtp-Source: AGHT+IFqRZUz1wHsOZhDAuhXNdehT7gk/BqvAG1rf2oPqt3ua1QklOCxKxn+QGSG4okcERsqIR4NEg==
X-Received: by 2002:a17:902:7b84:b0:1d0:6ffd:836b with SMTP id w4-20020a1709027b8400b001d06ffd836bmr260600pll.118.1701851315542;
        Wed, 06 Dec 2023 00:28:35 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902e89100b001cfc2e0a82fsm11474978plg.26.2023.12.06.00.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 00:28:34 -0800 (PST)
Date:   Wed, 6 Dec 2023 17:28:18 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marco Elver <elver@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 06/21] cpu/hotplug: remove CPUHP_SLAB_PREPARE hooks
Message-ID: <ZXAwomfWa6fdcPQ+@localhost.localdomain>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <20231120-slab-remove-slab-v2-6-9c9c70177183@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-slab-remove-slab-v2-6-9c9c70177183@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 07:34:17PM +0100, Vlastimil Babka wrote:
> The CPUHP_SLAB_PREPARE hooks are only used by SLAB which is removed.
> SLUB defines them as NULL, so we can remove those altogether.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/cpuhotplug.h | 1 -
>  include/linux/slab.h       | 8 --------
>  kernel/cpu.c               | 5 -----
>  3 files changed, 14 deletions(-)
> 
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index d305db70674b..07cb8f7030b6 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -108,7 +108,6 @@ enum cpuhp_state {
>  	CPUHP_X2APIC_PREPARE,
>  	CPUHP_SMPCFD_PREPARE,
>  	CPUHP_RELAY_PREPARE,
> -	CPUHP_SLAB_PREPARE,
>  	CPUHP_MD_RAID5_PREPARE,
>  	CPUHP_RCUTREE_PREP,
>  	CPUHP_CPUIDLE_COUPLED_PREPARE,
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index d6d6ffeeb9a2..34e43cddc520 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -788,12 +788,4 @@ size_t kmalloc_size_roundup(size_t size);
>  
>  void __init kmem_cache_init_late(void);
>  
> -#if defined(CONFIG_SMP) && defined(CONFIG_SLAB)
> -int slab_prepare_cpu(unsigned int cpu);
> -int slab_dead_cpu(unsigned int cpu);
> -#else
> -#define slab_prepare_cpu	NULL
> -#define slab_dead_cpu		NULL
> -#endif
> -
>  #endif	/* _LINUX_SLAB_H */
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 9e4c6780adde..530b026d95a1 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2125,11 +2125,6 @@ static struct cpuhp_step cpuhp_hp_states[] = {
>  		.startup.single		= relay_prepare_cpu,
>  		.teardown.single	= NULL,
>  	},
> -	[CPUHP_SLAB_PREPARE] = {
> -		.name			= "slab:prepare",
> -		.startup.single		= slab_prepare_cpu,
> -		.teardown.single	= slab_dead_cpu,
> -	},
>  	[CPUHP_RCUTREE_PREP] = {
>  		.name			= "RCU/tree:prepare",
>  		.startup.single		= rcutree_prepare_cpu,

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> 
> -- 
> 2.42.1
> 
> 
