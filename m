Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904A57EE026
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345125AbjKPLxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjKPLw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:52:58 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2290D187
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:52:32 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc2fc281cdso6001595ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700135551; x=1700740351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HpXM7umLkp8ggmdEvermO/1ufULZGrPSR7DJdYQ70f0=;
        b=JpUd2QSBLtkg6IgG/AcyhSlc90IAF2+J20ixpgOOIU0yJEjSA0cOVE0G3Z0mYwfVp4
         aEc5SCO6b1sXnYs8S7/oO/CmAfwI3rJtVYTENIu0cVXPGQDVeMJBqyoriM6GG8yNm2h3
         +Xm/M32MTsWnABlw/6vWF1CVB+WC6Iqmg1eaZDNqY00SEtR0SziG/M+U/OgW37Q22isE
         XgZHYtCcIRPg8TGZVeQu/ckamWGXZ3iN+820aKy51mG8K/M3mmmv0JxF3m1WyQolr/13
         kxyT+8TrMY2qZnQX86lrwcA6WKuLM7DTarLKjAJrBkDXJ1chihHP0y/4dXel3juEs+Bl
         bRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700135551; x=1700740351;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpXM7umLkp8ggmdEvermO/1ufULZGrPSR7DJdYQ70f0=;
        b=bDLBHtLrvLGNcbmCWkaOgXzyPd7Yf2mOWA6bcuvs6XrnSDgmPgJk2Nnc1aF4/8yIUi
         al/vHcBVKUAh6WPzZ/rs78ylUgUTaRL8gG3qlksZ+IHh0IEseE7LzbfMjpNE0U1C9vWJ
         A+LJ421vT9agGjQxGTrNfQiIt4wctM9HbGhewvHfU4zZj8fuWfgXrQ9XKcIvR72O6MU5
         NqPMmLBDA73BQX/LU8Ug3p/+xnMZCnvWqzjEqPB2NtWeH7rnJG3RelmV34kmALE40lqN
         oQrs6raEjwxvW01wOfae7eJFl0cH/dgLeGGboEqJCjwv87lyWEgvdUqBhHQIgmgFSujP
         r97g==
X-Gm-Message-State: AOJu0YySqWW72abpBOIEodTHvjr1ip2TngY7P2RLJm59rxetS6XQZIVO
        zrFGLcyB96q2c7kzl04Q9efWgw==
X-Google-Smtp-Source: AGHT+IEtpw0yNBDVJg9fCbsTN542ENyUqeMIPRcam0ytEcyM+RbOI8tN/+Z5g4efHJJAjhr5WP1mjg==
X-Received: by 2002:a17:902:e84b:b0:1cc:787f:fd2 with SMTP id t11-20020a170902e84b00b001cc787f0fd2mr9340446plg.49.1700135551598;
        Thu, 16 Nov 2023 03:52:31 -0800 (PST)
Received: from [10.254.46.51] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id a17-20020a170902ecd100b001c9cb2fb8d8sm9051160plh.49.2023.11.16.03.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 03:52:31 -0800 (PST)
Message-ID: <30fa2ed2-dfee-4dbf-bb44-1b0374877706@bytedance.com>
Date:   Thu, 16 Nov 2023 19:52:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Update min_vruntime for reweight_entity()
 correctly
Content-Language: en-US
To:     Yiwei Lin <s921975628@gmail.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org
References: <20231116114217.90553-1-s921975628@gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20231116114217.90553-1-s921975628@gmail.com>
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

Please add a Fix tag like this:

Fixes: eab03c23c2a1 ("sched/eevdf: Fix vruntime adjustment on reweight")

On 11/16/23 7:42 PM, Yiwei Lin Wrote:
> Since reweight_entity() may have chance to change the weight of
> cfs_rq->curr entity, we should also update_min_vruntime() if
> this is the case
> 
> Signed-off-by: Yiwei Lin <s921975628@gmail.com>
> ---
>   kernel/sched/fair.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 07f555857..6fb89f4a3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3815,17 +3815,17 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
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
> +
> +		/*
> +		 * The entity's vruntime has been adjusted, so let's check
> +		 * whether the rq-wide min_vruntime needs updated too. Since
> +		 * the calculations above require stable min_vruntime rather
> +		 * than up-to-date one, we do the update at the end of the
> +		 * reweight process.
> +		 */
> +		update_min_vruntime(cfs_rq);
>   	}
>   }
>   

LGTM, thanks!
