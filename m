Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84397C453B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 01:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbjJJXII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 19:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjJJXIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 19:08:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5489D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 16:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696979239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qkGehZf05dSaZaQ9Zw15qdPyYFyDKIe1tlJJ6Hrr4eM=;
        b=fZSXJY8XU+M+5yBbi5R0Tw7B2uzscDRbE3p3fWNa9eSnEd8bfqEwNruVj8vNfR/EAOtZ3A
        WKQk7RbCSETAXbGT6559RM/bvlIcSAUMY7xcxpYUZfQEpasbkYAUslH1swh8b5UwOf+lNQ
        So3aXdbgg9LSaTlBPT3o0PsjnMtEFis=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-466-zdL2oxNmOvmaPHdlur2yng-1; Tue, 10 Oct 2023 19:07:06 -0400
X-MC-Unique: zdL2oxNmOvmaPHdlur2yng-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 907018007A4;
        Tue, 10 Oct 2023 23:07:05 +0000 (UTC)
Received: from [10.22.9.34] (unknown [10.22.9.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43856492B04;
        Tue, 10 Oct 2023 23:07:05 +0000 (UTC)
Message-ID: <535dd61c-8e3e-103c-e970-2c8514af5596@redhat.com>
Date:   Tue, 10 Oct 2023 19:07:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] locking/osq: remove spin node definition from header
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org
References: <20231010-osq-header-v1-1-d68fbc1bf1cf@weissschuh.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20231010-osq-header-v1-1-d68fbc1bf1cf@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/10/23 05:53, Thomas Weißschuh wrote:
> This structure is an implementation detail of osq_lock.c, and there are
> no external users.
>
> Also drop the redundant overview comment from osq_lock.c.
>
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>   include/linux/osq_lock.h  | 5 -----
>   kernel/locking/osq_lock.c | 9 ++++++---
>   2 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/osq_lock.h b/include/linux/osq_lock.h
> index 5581dbd3bd34..ea8fb31379e3 100644
> --- a/include/linux/osq_lock.h
> +++ b/include/linux/osq_lock.h
> @@ -6,11 +6,6 @@
>    * An MCS like lock especially tailored for optimistic spinning for sleeping
>    * lock implementations (mutex, rwsem, etc).
>    */
> -struct optimistic_spin_node {
> -	struct optimistic_spin_node *next, *prev;
> -	int locked; /* 1 if lock acquired */
> -	int cpu; /* encoded CPU # + 1 value */
> -};

It is probably better to drop the MCS like lock comment here as it is 
not relevant without the optimistic_spin_node struct.


>   
>   struct optimistic_spin_queue {
>   	/*
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index d5610ad52b92..918866edbc30 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -3,10 +3,13 @@
>   #include <linux/sched.h>
>   #include <linux/osq_lock.h>
>   
> +struct optimistic_spin_node {
> +	struct optimistic_spin_node *next, *prev;
> +	int locked; /* 1 if lock acquired */
> +	int cpu; /* encoded CPU # + 1 value */
> +};
> +
>   /*
> - * An MCS like lock especially tailored for optimistic spinning for sleeping
> - * lock implementations (mutex, rwsem, etc).
> - *
>    * Using a single mcs node per CPU is safe because sleeping locks should not be
>    * called from interrupt context and we have preemption disabled while
>    * spinning.

We should keep the MCS comment here. My other suggestion is to put the 
structure definition after the comment.

Other than these minor nits, it is a worthwhile cleanup patch.

Cheers,
Longman

