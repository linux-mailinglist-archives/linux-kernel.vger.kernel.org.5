Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6FF78DDEF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343919AbjH3S4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242768AbjH3JdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:33:04 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54AB95
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:33:01 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-401b3ea0656so48376625e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693387980; x=1693992780; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/pN5Sj2lXQgLLmHsNhZTE0RFeJiDl6tBaSGS7xws0g=;
        b=DilbzasIYtUUGqKLrd7KKfPVa62FopFrdmlA/GpH8t6G25JZquXMtp1/go3EDCQAM9
         u0Ju43m8O320YR+hLwGy7M0lyPrbA+1sbOD3EgekHaconxFQE60CnzN1t+STIhu7GWCy
         D2oyitZma6Ne1Z3eiwTCVvk+73Vz6I8JteqXkrc6TpUSVKOfKBRDIHdd7DcGLJgTkWa7
         IfqWj1XoE/6yxWfx9XkfabZt92H7tRsmIoOzJ65Dsgs7ma29SkZY9rHT9U71PeN4JyHD
         Ktg8xUCH3PNnWETH7YyoRo7NZv4A/6GJ9b5IQZWSmoPtcXwEXgikPm3SMZj7wH4Jdof2
         LojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693387980; x=1693992780;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/pN5Sj2lXQgLLmHsNhZTE0RFeJiDl6tBaSGS7xws0g=;
        b=aHKwgLQFhEt3/9akGJnrsMgnjRF+I9sUv0FZ5YWicGJ1m30IFmlxznEOTaInekODG2
         K33aMsuB5vshNJkp9LGfuima0LTeqTVeT7xBmzQncpZKqlhqcPLVau76LkakPORJaoqt
         BRcgnupls1pJBrZtpIbBXmzt6lqbQG1/qUUMgtVCcQALrefYNzFMs3ibfyJGz6+Ef1DP
         aviJXTHgr3s/lRPI0HAcZmcVOgRWBcsyN/tt7Ye3WEt8hyl8KgifK9rv1x2eb/J03jzV
         x5XwLVH9hRzbMIbU+6iFcSCPqvO1Bm11naNu7z5tYerOqNzMZ46+OuZ2Awpq65aIQnwg
         3Jcg==
X-Gm-Message-State: AOJu0Yzs0pPoMlPUAy30r5GpbwtiX7KZ6Ce5fU+Y5iiZ/lgiLJ/IUSM0
        h9/pvyf8yAMIhkZqaeF7XC1OEw==
X-Google-Smtp-Source: AGHT+IH+QVH/eBfvEpQp78cWzC0C2VRwqkKX01uSV/Po75AljOi0NmK2kL/E5Yu0gp+Jvbv7DSfigQ==
X-Received: by 2002:a1c:7217:0:b0:401:b53e:6c57 with SMTP id n23-20020a1c7217000000b00401b53e6c57mr1358749wmc.9.1693387979964;
        Wed, 30 Aug 2023 02:32:59 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:3380:af04:1905:46a])
        by smtp.gmail.com with ESMTPSA id m18-20020a7bce12000000b00401dc20a070sm1668612wmc.43.2023.08.30.02.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 02:32:59 -0700 (PDT)
Date:   Wed, 30 Aug 2023 11:32:53 +0200
From:   Marco Elver <elver@google.com>
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 12/15] stackdepot: add refcount for records
Message-ID: <ZO8MxUqcL1dnykcl@elver.google.com>
References: <cover.1693328501.git.andreyknvl@google.com>
 <306aeddcd3c01f432d308043c382669e5f63b395.1693328501.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <306aeddcd3c01f432d308043c382669e5f63b395.1693328501.git.andreyknvl@google.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 07:11PM +0200, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Add a reference counter for how many times a stack records has been added
> to stack depot.
> 
> Do no yet decrement the refcount, this is implemented in one of the
> following patches.
> 
> This is preparatory patch for implementing the eviction of stack records
> from the stack depot.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  lib/stackdepot.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index 5ad454367379..a84c0debbb9e 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -22,6 +22,7 @@
>  #include <linux/mutex.h>
>  #include <linux/percpu.h>
>  #include <linux/printk.h>
> +#include <linux/refcount.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/stacktrace.h>
> @@ -60,6 +61,7 @@ struct stack_record {
>  	u32 hash;			/* Hash in hash table */
>  	u32 size;			/* Number of stored frames */
>  	union handle_parts handle;
> +	refcount_t count;
>  	unsigned long entries[DEPOT_STACK_MAX_FRAMES];	/* Frames */
>  };
>  
> @@ -348,6 +350,7 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
>  	stack->hash = hash;
>  	stack->size = size;
>  	/* stack->handle is already filled in by depot_init_pool. */
> +	refcount_set(&stack->count, 1);
>  	memcpy(stack->entries, entries, flex_array_size(stack, entries, size));
>  
>  	/*
> @@ -452,6 +455,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>  	/* Fast path: look the stack trace up without full locking. */
>  	found = find_stack(*bucket, entries, nr_entries, hash);
>  	if (found) {
> +		refcount_inc(&found->count);

If someone doesn't use stack_depot_evict(), and the refcount eventually
overflows, it'll do a WARN (per refcount_warn_saturate()).

I think the interface needs to be different:

	stack_depot_get(): increments refcount (could be inline if just
	wrapper around refcount_inc())

	stack_depot_put(): what stack_depot_evict() currently does

Then it's clear that if someone uses either stack_depot_get() or _put()
that these need to be balanced. Not using either will result in the old
behaviour of never evicting an entry.

>  		read_unlock_irqrestore(&pool_rwlock, flags);
>  		goto exit;
>  	}
> -- 
> 2.25.1
> 
