Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F637DE215
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 15:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjKANv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjKANv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:51:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92850A2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 06:51:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 385601F74D;
        Wed,  1 Nov 2023 13:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698846680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wPjzGNA/3MlREK2koxGGUC8WANuq/K6v4Gi0jZO57T0=;
        b=dXfhhc7CzRF/LOmYXJ7j6dWdUoD9mzRp2wGbo1BAqE8fBuraMn5z9Yde70f8iV4v4/CwMB
        Lii171UKBa1YTWOWB97NBd4KElNHDC6cQwC1/CHSNSIjZnsqBP0AkDWCd6cQHMOr74omjP
        PEHHK8+7Oba5fGCO8gPRwMOLMozRIeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698846680;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wPjzGNA/3MlREK2koxGGUC8WANuq/K6v4Gi0jZO57T0=;
        b=N8kRpsVbxzmS7LTxBPWOgkRw64wc8iGeTQxDjbA9tkKL18WUiyYq1nR/ktPuZX0uyAdyaS
        UBeNjqDwX2gqsXBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0157D13460;
        Wed,  1 Nov 2023 13:51:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ulUAO9dXQmUAegAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 01 Nov 2023 13:51:19 +0000
Message-ID: <211ac705-5972-9b39-73f1-a608e65b6de3@suse.cz>
Date:   Wed, 1 Nov 2023 14:51:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v4 9/9] slub: Update frozen slabs documentations in
 the source
Content-Language: en-US
To:     chengming.zhou@linux.dev, cl@linux.com, penberg@kernel.org,
        willy@infradead.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231031140741.79387-1-chengming.zhou@linux.dev>
 <20231031140741.79387-10-chengming.zhou@linux.dev>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231031140741.79387-10-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 15:07, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The current updated scheme (which this series implemented) is:
>  - node partial slabs: PG_Workingset && !frozen
>  - cpu partial slabs: !PG_Workingset && !frozen
>  - cpu slabs: !PG_Workingset && frozen
>  - full slabs: !PG_Workingset && !frozen

It could be useful to put this also to the initial comment description.
Towards the end of the comment, there's a block explaining
"slab->frozen". It could be extended to cover all 4 combination (but not
all of them need such long explanation).

> 
> The most important change is that "frozen" bit is not set for the
> cpu partial slabs anymore, __slab_free() will grab node list_lock
> then check by !PG_Workingset that it's not on a node partial list.
> 
> And the "frozen" bit is still kept for the cpu slabs for performance,
> since we don't need to grab node list_lock to check whether the
> PG_Workingset is set or not if the "frozen" bit is set in __slab_free().
> 
> Update related documentations and comments in the source.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  mm/slub.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index bb7368047103..89d3f7a18a73 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -76,13 +76,22 @@
>   *
>   *   Frozen slabs
>   *
> - *   If a slab is frozen then it is exempt from list management. It is not
> - *   on any list except per cpu partial list. The processor that froze the
> + *   If a slab is frozen then it is exempt from list management. It is
> + *   the cpu slab which is actively allocated from by the processor that
> + *   froze it and it is not on any list. The processor that froze the
>   *   slab is the one who can perform list operations on the slab. Other
>   *   processors may put objects onto the freelist but the processor that
>   *   froze the slab is the only one that can retrieve the objects from the
>   *   slab's freelist.
>   *
> + *   CPU partial slabs
> + *
> + *   The partially empty slabs cached on the CPU partial list are used
> + *   for performance reasons, which speeds up the allocation process.
> + *   These slabs are not frozen, but also exempt from list management,

					^ are also

(otherwise somebody could read it as "also are not")

> + *   by clearing the PG_workingset flag when moving out of the node
> + *   partial list. Please see __slab_free() for more details.
> + *
>   *   list_lock
>   *
>   *   The list_lock protects the partial and full list on each node and
> @@ -2620,8 +2629,7 @@ static void put_partials_cpu(struct kmem_cache *s,
>  }
>  
>  /*
> - * Put a slab that was just frozen (in __slab_free|get_partial_node) into a
> - * partial slab slot if available.
> + * Put a slab into a partial slab slot if available.
>   *
>   * If we did not find a slot then simply move all the partials to the
>   * per node partial list.
