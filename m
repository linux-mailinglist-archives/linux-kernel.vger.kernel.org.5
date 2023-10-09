Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096FA7BD854
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346103AbjJIKQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346061AbjJIKQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:16:35 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592A09F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 03:16:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3296a998234so2502046f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 03:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696846592; x=1697451392; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4BbKsqKlQLHMSNY1pU1xD6CYGPW9vVmTSsJ1wdl4ZU=;
        b=jjUnfsOgKjwFcuRkapv/Jq7xfR3RHgS5Q+2NQdJOFwDlX4ydWDZPRRY8axpit7B7/N
         opYbDy6TcODZapeHd4i/WD7wb4VfJN1FgHGixh3wVTQRto+1VzPG0TDwnJjdROdo0ICM
         pjL7pNV1z2uDcvNVkM63FEgD7y8gfIz/CeI5Dr0KDcYASYVfGYaVLCNFVa41Oyz9WCgR
         5jE7mgeWggSI7/PLufl/QfMUJEMQjSqkqxDKs3GEtAwp8u820YyxN7gO29LZxtKnpaA4
         tWN5t07mye5nHrGeGXi7exTbivs4FdCVav8rTnc6UdDFV2CZVIQIOnqDBFLCn4xnpH2I
         9MsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696846592; x=1697451392;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4BbKsqKlQLHMSNY1pU1xD6CYGPW9vVmTSsJ1wdl4ZU=;
        b=jcqK77SUTRv2LJxDVX6dPQWwYvGPBR3CbHPvNTqulXMhkfhtkNOh475nTvvy9XIG/a
         D/15mVi49O7qnSVM0vdtZKpQfLxD2nJNQfnK2Wo5n8yMLXHSgVHC1S5uMdNVynUNXqnG
         MukZaHUyesAq2uGxQLsTpRdqE1ScIn++ROKFfZhgl032Szwl4y4yrJn72Cu+VDT1eGPE
         LWGI/Fafolki1331hB488HtwcgXJHhZBDYBuo9PDJqxIDWBEXH8dP6/Da+LqJ+hN8Kcw
         z9Z3pJXKsMqkrEx/2gdIh2dM0urLbNN6lINwN+gAUdHvc1bEoXeFd8dbDJ8r8S6itH12
         CJkg==
X-Gm-Message-State: AOJu0YwTwboSTZc7Y3E8jPWIXoY5kpTZmnY0d0CmtLrqfdwOTYhEcaRP
        rbRiq8NtUPAIqBvEZUnD2t66LDV2vow=
X-Google-Smtp-Source: AGHT+IGYUHiHQMWZ0vZDGSrw9CQX6YvOWNgzgw2UNkCYznS6/wkL0c8uPOIn4UqKEMTEy36CVjnQ/A==
X-Received: by 2002:a5d:6e85:0:b0:317:50b7:2ce3 with SMTP id k5-20020a5d6e85000000b0031750b72ce3mr12231386wrz.51.1696846591473;
        Mon, 09 Oct 2023 03:16:31 -0700 (PDT)
Received: from gmail.com (1F2EF237.nat.pool.telekom.hu. [31.46.242.55])
        by smtp.gmail.com with ESMTPSA id d9-20020adff2c9000000b00324887a13f7sm9239728wrp.0.2023.10.09.03.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 03:16:28 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 9 Oct 2023 12:16:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/rt: Move sched_rt_entity::back to under the
 CONFIG_RT_GROUP_SCHED block
Message-ID: <ZSPS+jMcJEd+ZR28@gmail.com>
References: <20231005162317.3343678-1-yajun.deng@linux.dev>
 <20231005162317.3343678-3-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005162317.3343678-3-yajun.deng@linux.dev>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Yajun Deng <yajun.deng@linux.dev> wrote:

> The member back in struct sched_rt_entity only related to RT_GROUP_SCHED,
> So move sched_rt_entity::back to under the CONFIG_RT_GROUP_SCHED block. It
> will save a few bytes.
> 
> Also, init child when parent isn't NULL in init_tg_rt_entry().
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
>  include/linux/sched.h |  2 +-
>  kernel/sched/rt.c     | 18 +++++++++---------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 292c31697248..d0fe56603e60 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -597,8 +597,8 @@ struct sched_rt_entity {
>  	unsigned short			on_rq;
>  	unsigned short			on_list;
>  
> -	struct sched_rt_entity		*back;
>  #ifdef CONFIG_RT_GROUP_SCHED
> +	struct sched_rt_entity		*back;
>  	struct sched_rt_entity		*parent;
>  	/* rq on which this entity is (to be) queued: */
>  	struct rt_rq			*rt_rq;

Title claims this change - the rest of the changes should be in a separate 
patch:

> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 642edbd24ffb..7b3105b875f1 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -233,8 +233,10 @@ void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
>  
>  	if (!parent)
>  		rt_se->rt_rq = &rq->rt;
> -	else
> +	else {
>  		rt_se->rt_rq = parent->my_q;
> +		parent->back = rt_se;
> +	}
>  
>  	rt_se->my_q = rt_rq;
>  	rt_se->parent = parent;
> @@ -1441,23 +1443,21 @@ static void __dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flag
>   */
>  static void dequeue_rt_stack(struct sched_rt_entity *rt_se, unsigned int flags)
>  {
> -	struct sched_rt_entity *back = NULL;
> +	struct sched_rt_entity *root = NULL;
>  	unsigned int rt_nr_running;
>  
> -	for_each_sched_rt_entity(rt_se) {
> -		rt_se->back = back;
> -		back = rt_se;
> -	}
> +	for_each_sched_rt_entity(rt_se)
> +		root = rt_se;
>  
> -	rt_nr_running = rt_rq_of_se(back)->rt_nr_running;
> +	rt_nr_running = rt_rq_of_se(root)->rt_nr_running;
>  
> -	rt_se = back;
> +	rt_se = root;
>  	for_each_sched_rt_entity_back(rt_se) {
>  		if (on_rt_rq(rt_se))
>  			__dequeue_rt_entity(rt_se, flags);
>  	}
>  
> -	dequeue_top_rt_rq(rt_rq_of_se(back), rt_nr_running);
> +	dequeue_top_rt_rq(rt_rq_of_se(root), rt_nr_running);
>  }
>  
>  static void enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
> -- 
> 2.25.1

Thanks,

	Ingo
