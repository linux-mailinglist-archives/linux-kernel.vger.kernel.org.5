Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2607F0E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjKTIth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjKTIte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:49:34 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454089F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:49:31 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6cb749044a2so1255442b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 00:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700470171; x=1701074971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pgLFutECwkEd35/vfXgU5PKVj7XQnEmSlifGNNGfLNo=;
        b=GQ6+7gk0NOssGdqtr8g94INLkmz1shoanhfpW5I+pLdT4h/XVA8yFEFgZNJaE4hPFC
         xf87fd0TmRrOJqF+MTzXdpRxuMCW6487FN6hMV8718Ow/vpAoCmSygcNdZz00VcnSyIi
         D8Q2rugI+9ypaHgehmauirJtDrVKwqvfu4GRa7fcfSnXwkYqrjPT0NHNef1RxpZ+kWcD
         aqssFCsN1kNHKUIs0ygTmIQ66N1aAgUmQBmkKDoHrcqtZpG2pjYEX7mapwgQr08p0QIZ
         FtOBzNwHidcEHKIYWq9CmNdJcQQ8BkpPDpzNPHgzng2fP1HnQ2yT1yqxhWG24Bz75DQS
         U2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700470171; x=1701074971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pgLFutECwkEd35/vfXgU5PKVj7XQnEmSlifGNNGfLNo=;
        b=tHlk8SoRZ4ry4UxdCBDFCc2Fts6kNuG/g50lvPbQ8QaRkGan/tNsK1n8qqNiHLHHGT
         1I1qQmGW8aMm5j47j1cwrFWQ+r/uaVWubJnwjArvrlfexVKWJViQ7NwMICNYKTJlmekr
         0eAVAgOscRE3gLzb5MeSEPwWV//o+NmyN2XufkmuJhK5qM/fNCAP5QbaeXqV//dyFo2d
         /QQaq7BCzJVJVaAQBGoDGrqCMFnyN6J4iJFcNsrGuEARkL1wVzZTmpVE5PIp1K0qWp8Z
         qOwE5ffQUw4hc5hPxwV+BsXLXk1laqAtWmghhs68CXk+OAgAYueXP618oJ7JqGv7Osbo
         gClA==
X-Gm-Message-State: AOJu0YzJ4eNg+dHMSkZ+B0kVotmctfatcHsq09ZngT/d8A1RcXxTqDez
        3p1jgVkngKdONXfUPrAYlaKTEQ==
X-Google-Smtp-Source: AGHT+IF9L9pQM6NY1zjQ8+gVJTmo3D05OIYOLVTk8HlxKpXYsU/zmhuAVl42W92IT2cd/BFK96oXZg==
X-Received: by 2002:a05:6a20:b7a7:b0:187:b581:cf45 with SMTP id fh39-20020a056a20b7a700b00187b581cf45mr5850693pzb.36.1700470170718;
        Mon, 20 Nov 2023 00:49:30 -0800 (PST)
Received: from [10.4.27.171] ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id jw24-20020a170903279800b001cf54c7adbasm3365253plb.225.2023.11.20.00.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 00:49:30 -0800 (PST)
Message-ID: <7c223b0c-d39a-4d53-8f00-7fbec6b49b6e@bytedance.com>
Date:   Mon, 20 Nov 2023 16:49:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/eevdf: Avoid NULL in pick_eevdf
To:     Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        xuewen.yan94@gmail.com
References: <20231120073821.1304-1-xuewen.yan@unisoc.com>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20231120073821.1304-1-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xuewen, the pick part has been re-worked, would you please re-test
with the newest branch?

Thanks,
	Abel

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/?h=sched%2Fcore

On 11/20/23 3:38 PM, Xuewen Yan Wrote:
> Now in pick_eevdf function, add the pick_first_entity to prevent
> picking null when using eevdf, however, the leftmost may be null.
> As a result, it would cause oops because the se is NULL.
> 
> Fix this by compare the curr and left, if the left is null, set
> the se be curr.
> 
> Fixes: 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling policy")
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>   kernel/sched/fair.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d7a3c63a2171..10916f6778ac 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -951,12 +951,28 @@ static struct sched_entity *__pick_eevdf(struct cfs_rq *cfs_rq)
>   	return NULL;
>   }
>   
> +/* Just simply choose the se with the smallest vruntime */
> +static struct sched_entity *__pick_cfs(struct cfs_rq *cfs_rq)
> +{
> +	struct sched_entity *curr = cfs_rq->curr;
> +	struct sched_entity *left = __pick_first_entity(cfs_rq);
> +
> +	/*
> +	 * If curr is set we have to see if its left of the leftmost entity
> +	 * still in the tree, provided there was anything in the tree at all.
> +	 */
> +	if (!left || (curr && entity_before(curr, left)))
> +		left = curr;
> +
> +	return left;
> +}
> +
>   static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
>   {
>   	struct sched_entity *se = __pick_eevdf(cfs_rq);
>   
>   	if (!se) {
> -		struct sched_entity *left = __pick_first_entity(cfs_rq);
> +		struct sched_entity *left = __pick_cfs(cfs_rq);
>   		if (left) {
>   			pr_err("EEVDF scheduling fail, picking leftmost\n");
>   			return left;
