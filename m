Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D0B7EDF65
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345088AbjKPLRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344985AbjKPLRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:17:04 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A34DB2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:16:36 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6c32a20d5dbso594471b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700133396; x=1700738196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9rxV9jSjXl7UIKX/RtrX90SVibWex0zp+H4SVafAco8=;
        b=eeZwHGpqHMRH8T8VVrlqOSMGfvhA/9e4/8OzUL7n8KU4nzjFhHBI8yuPWn6bES030l
         vCA8LSh7RFk8vaJjMPHjiLcDcqCqR2woZgl5ju1t0Bs6Z/qJHRA9TD80XX8toN5tOtzL
         ahrtVLqspIx6h6Br/e2ePvFHtUfT/e/gJepk200YQTX5WcsjboDiOzsaAOuDmXvJZTQO
         Kr6s1d49HKo2eDWcsE0lOeXh392sK07126Tmo8vhD1xIrTzGvQVrkOaLKC9Rxcg4AkcS
         mzQdAlOZk9+ejIM0BYW1ZwCN5DHeX/yUoJdPnOCyUbOb4iB5UL2yIRh/Wlq7ey67t/8S
         CkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700133396; x=1700738196;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rxV9jSjXl7UIKX/RtrX90SVibWex0zp+H4SVafAco8=;
        b=EOgzohIaMye9E7d3cdyde4ECB3j1TFKGgo0vY7G1CLgU/RrtZdOsGs9wqetPbBD+GA
         6QDWnAu+h1VDlCIePV3pM0aKNT55lFfx3ZlP55ED1CNQougV+VUsm/4cphM/oUKbMK6D
         gsyvbTMv8lw7STzKCNVy+s+B4PFV/Ac63Ra92sSEaUS8k7RPY0l5DQ+bfzw38gVZLC6q
         YIQaltGO8DflwTvqqx5tKSTSlfwRfHwkdYSamts+Y32fax3Y5C61VsUAMrtcXVi9nvfb
         PaP0q4SEVeAS1lheAUydP+3Bx6LNQUmLPesZvy89B4GsRcS3GOK5oeCkNHPQBQCgQZaJ
         C3gg==
X-Gm-Message-State: AOJu0YzAM/qWrFMbetgzqxh+Rt4bI2Q8KKQZc5a4uKj9YckkAJRez42F
        KPMEUNiXWfWImtW8YjaJCtU2lA==
X-Google-Smtp-Source: AGHT+IGOKwiGHV3jMSpNPPaHDahL4f0ICzvYBkCZkrxUGlt0MmioWbiat6P7E0UL6B4FoJxqI7NccA==
X-Received: by 2002:a05:6a00:148c:b0:6be:4228:6970 with SMTP id v12-20020a056a00148c00b006be42286970mr17374228pfu.21.1700133396006;
        Thu, 16 Nov 2023 03:16:36 -0800 (PST)
Received: from [10.254.46.51] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id o136-20020a62cd8e000000b006c8b14f3f0asm3932073pfg.117.2023.11.16.03.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 03:16:35 -0800 (PST)
Message-ID: <377e0f71-80f9-4d83-a09d-e86bd61ce9ae@bytedance.com>
Date:   Thu, 16 Nov 2023 19:16:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] sched/fair: Update min_vruntime in more relaxed way
Content-Language: en-US
To:     Yiwei Lin <s921975628@gmail.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org
References: <20231116105425.84773-1-s921975628@gmail.com>
 <20231116105425.84773-2-s921975628@gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20231116105425.84773-2-s921975628@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/23 6:54 PM, Yiwei Lin Wrote:
> As EEVDF adopts lag-based solution which is irrespective of
> min_vruntime like CFS before, min_vruntime is only used as
> an offset to avoid overflow on evaluation of avg_vruntime now.
> Rely on the fact we will always update_curr() before change
> to cfs_rq, it seems to make sense if we just
> update_min_vruntime() with update_curr() to reduce the cost.
> 
> Signed-off-by: Yiwei Lin <s921975628@gmail.com>
> ---
>   kernel/sched/fair.c | 20 +-------------------
>   1 file changed, 1 insertion(+), 19 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 07f555857..5c40adfae 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3815,17 +3815,8 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>   	enqueue_load_avg(cfs_rq, se);
>   	if (se->on_rq) {
>   		update_load_add(&cfs_rq->load, se->load.weight);
> -		if (!curr) {
> -			/*
> -			 * The entity's vruntime has been adjusted, so let's check
> -			 * whether the rq-wide min_vruntime needs updated too. Since
> -			 * the calculations above require stable min_vruntime rather
> -			 * than up-to-date one, we do the update at the end of the
> -			 * reweight process.
> -			 */
> +		if (!curr)
>   			__enqueue_entity(cfs_rq, se);
> -			update_min_vruntime(cfs_rq);
> -		}
>   	}
>   }
>   
> @@ -5347,15 +5338,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>   
>   	update_cfs_group(se);
>   
> -	/*
> -	 * Now advance min_vruntime if @se was the entity holding it back,
> -	 * except when: DEQUEUE_SAVE && !DEQUEUE_MOVE, in this case we'll be
> -	 * put back on, and if we advance min_vruntime, we'll be placed back
> -	 * further than we started -- ie. we'll be penalized.
> -	 */
> -	if ((flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)) != DEQUEUE_SAVE)
> -		update_min_vruntime(cfs_rq);
> -
>   	if (cfs_rq->nr_running == 0)
>   		update_idle_cfs_rq_clock_pelt(cfs_rq);
>   }

For now, core pick of core scheduling relies on min_vruntime to be fresh,
so please just fix commit eab03c23c2a1 to preserve its original behavior
by moving update_min_vruntime() to proper position. And behavior change
can be posted separated.

BTW it seems unnecessary to include a cover-letter for a single patch.

Thanks,
	Abel
