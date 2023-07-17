Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F26175596D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 04:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjGQCPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 22:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGQCPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 22:15:34 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551A5EC;
        Sun, 16 Jul 2023 19:15:33 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b9c434fe75so1770511a34.0;
        Sun, 16 Jul 2023 19:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689560132; x=1692152132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lNQbt3k7OUiyhlvCY96Ti6Uo2A9qHSR3IWBIJolmaRg=;
        b=m27bZ6AD9qEGWSVKagr7X6NmJRVWunWSnyZv2WnVw20OY/qjYcHfMpwqA1gLnSDqdP
         UXkjHyraMTCiRzzs6s7E9B5YBZ3gEwqhwn6eKAu9F3Lq2oV6Qg245jmrzkY5SdGw86d4
         KxK0+V9REHJnPGEJXk/wvgw3n6GjsrxS/ujqVj8lDy+1vnbDg0k5LCqJuKltlXd8m8iQ
         7EBSyKs3X7iZylmHROiqDBF5qPN2wxkUW9baqBz8IpLnn0kixVH9JH9ny2sPY5xTnN9l
         gP36oTyWBjcadTi+786PxilA+XXnPXbcjbKY7QgDeqGEtOncP53NsrkpxXmweZuINL+0
         /WxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689560132; x=1692152132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNQbt3k7OUiyhlvCY96Ti6Uo2A9qHSR3IWBIJolmaRg=;
        b=OAcwZ5fJdRoZk93wu6EtLM/SmXw9y674OwpZ1Y9MoqzCSaBCU5YC4kBwSGwqPQduGF
         ukJudgVmQi0Z+HZbLl4N9DA6op0VMK+aGnl0KWiTvZ2V5L1zF7CgI6hUECaU5kVP9nwF
         i8CjQr4bPE3hVc9Er8ndGnCBZna1XPYmVM5vaE4zQ0aUxYayW2MuwWzPzvXRp88pWbSL
         P89bLdgoXgiqms4kIeAbBsP4A7lHBWeb3SfKqpeaJ9JKGcM+WX0y/8IetzMw52wXp3aZ
         BKHjPqXALVmWIZ1z3M1tE1j5pVvnveBLOPXbua/nZJ4fmqfdJCtZjmm8hw40xR6MCJMO
         P6Gw==
X-Gm-Message-State: ABy/qLadX5rZ5eR9yDvXsh9wBWGjKbl2otqeZ9/GMaF61O0MUkxgrR5V
        AKNua4qBhKk1pH+jXMGmHNY=
X-Google-Smtp-Source: APBJJlHSEesL2DuVDv5OgTzc8m6uSiHgEmehAvc6lWejbo6F6WsSdA8zl6ZOq++u3Z7YI047t7b2OA==
X-Received: by 2002:a05:6358:2906:b0:135:4003:7841 with SMTP id y6-20020a056358290600b0013540037841mr6356958rwb.13.1689560132380;
        Sun, 16 Jul 2023 19:15:32 -0700 (PDT)
Received: from [30.221.131.241] ([47.246.101.49])
        by smtp.gmail.com with ESMTPSA id q26-20020a63981a000000b005439aaf0301sm11406343pgd.64.2023.07.16.19.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 19:15:31 -0700 (PDT)
Message-ID: <1522806a-ee51-04d5-0c78-6cf0e1c0eaf3@gmail.com>
Date:   Mon, 17 Jul 2023 10:15:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] ocfs2: Use flexible array in 'struct
 ocfs2_recovery_map'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        akpm <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        ocfs2-devel@lists.linux.dev,
        Joseph Qi <joseph.qi@linux.alibaba.com>
References: <c645911ffd2720fce5e344c17de642518cd0db52.1689533270.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From:   Joseph Qi <jiangqi903@gmail.com>
In-Reply-To: <c645911ffd2720fce5e344c17de642518cd0db52.1689533270.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/23 2:48 AM, Christophe JAILLET wrote:
> Turn 'rm_entries' in 'struct ocfs2_recovery_map' into a flexible array.
> 
> The advantages are:
>    - save the size of a pointer when the new undo structure is allocated
>    - avoid some always ugly pointer arithmetic to get the address of
>     'rm_entries'
>    - avoid an indirection when the array is accessed
> 
> While at it, use struct_size() to compute the size of the new undo
> structure.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Looks fine.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>


> ---
>  fs/ocfs2/journal.c | 5 +----
>  fs/ocfs2/journal.h | 2 +-
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
> index 25d8072ccfce..2f7e70109020 100644
> --- a/fs/ocfs2/journal.c
> +++ b/fs/ocfs2/journal.c
> @@ -178,16 +178,13 @@ int ocfs2_recovery_init(struct ocfs2_super *osb)
>  	osb->recovery_thread_task = NULL;
>  	init_waitqueue_head(&osb->recovery_event);
>  
> -	rm = kzalloc(sizeof(struct ocfs2_recovery_map) +
> -		     osb->max_slots * sizeof(unsigned int),
> +	rm = kzalloc(struct_size(rm, rm_entries, osb->max_slots),
>  		     GFP_KERNEL);
>  	if (!rm) {
>  		mlog_errno(-ENOMEM);
>  		return -ENOMEM;
>  	}
>  
> -	rm->rm_entries = (unsigned int *)((char *)rm +
> -					  sizeof(struct ocfs2_recovery_map));
>  	osb->recovery_map = rm;
>  
>  	return 0;
> diff --git a/fs/ocfs2/journal.h b/fs/ocfs2/journal.h
> index 41c382f68529..41c9fe7e62f9 100644
> --- a/fs/ocfs2/journal.h
> +++ b/fs/ocfs2/journal.h
> @@ -29,7 +29,7 @@ struct ocfs2_dinode;
>  
>  struct ocfs2_recovery_map {
>  	unsigned int rm_used;
> -	unsigned int *rm_entries;
> +	unsigned int rm_entries[];
>  };
>  
>  
