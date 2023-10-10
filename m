Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD1E7BF134
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 05:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441943AbjJJDEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 23:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441902AbjJJDEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 23:04:01 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A261A6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 20:03:45 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-691c05bc5aaso4589034b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 20:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696907025; x=1697511825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYJPot/yVsN2eIMJtsBswpwz3V3PaxdYOrydQnf75Uk=;
        b=fUfWVTREDo3VDLftRaOtJVgW+7y1nTnRLJhVOHyP++shq2aXGmxdri6dmyQIlI+iNF
         7Qt90IZGM+jbEjFKFvuZyi4R85oZRxNzJcb4OJOba/fvy+FFG9CcJhUKI0ky01hYKXKd
         z7zrULa5YezNyfOptHOvWtVoZoq2ABry1VoWetf4uDrZHJDnLiOA043MLaIVZprUAEBH
         1RJC7DzjLh35IaUXa15CpBKKfMa3UBd39WQnDFtwmfH/KuKNDetOj4EmPACG51yxE9PF
         51Loj3hgqqpMONmi7Ulq8pOOHGwPwBj+BFwRKopotvDgLaRWCaRUXcwQwTqHfsoU0xhX
         XfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696907025; x=1697511825;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MYJPot/yVsN2eIMJtsBswpwz3V3PaxdYOrydQnf75Uk=;
        b=wsGUJ4WSUFJSWjS6bvtyWl3BUoSD24ki+oox2kmayglR1VDOBrfh294ulaL5XnBP1R
         vFYEpHM/aI3FpctMgvGAL0mQQ0Wz8y7fKM52spCXqgHxd7t4ltkekRsZyAf6SswzykUF
         UVBY1AYI984PdK6sX7O7FO7Ga2fmiLFH1VTQujnZqUtnbN7K9NSFJG2JvwGQRIDfRXBg
         EgbZL0d3MdSMZXwVy7dGywZuKPGUSHH3y8E5vZvg+vqWBt/5Cm20aMaLOtEJ6R13w0ed
         CACR3FB5c1oFux9Eq9uHsG2HEBtoXPLPGiuUIgtW/zUaMmApVexIuFLWA+vAhoBf4mBN
         oBPA==
X-Gm-Message-State: AOJu0YzWSvsNaj3srDzgp3Pw0bO8P9ePbq/bg6QbBjqs7nDZVjifzQlb
        SnUMWwuehH2zMt/P4YG/O64Stw==
X-Google-Smtp-Source: AGHT+IEbrzbEAva3M0ASlIUW/CtNVe+b9f8Xdj/DAyRa2sO6N+9VQiEKu5D+kuahjHNpAlDkb71Sjg==
X-Received: by 2002:a05:6a21:8cc5:b0:153:63b9:8bf9 with SMTP id ta5-20020a056a218cc500b0015363b98bf9mr17465286pzb.0.1696907025078;
        Mon, 09 Oct 2023 20:03:45 -0700 (PDT)
Received: from [10.254.233.150] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902788400b001c611e9a5fdsm10343207pll.306.2023.10.09.20.03.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 20:03:44 -0700 (PDT)
Message-ID: <d6182b74-5879-4e5a-8605-abd55542215d@bytedance.com>
Date:   Tue, 10 Oct 2023 11:03:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] maple_tree: use preallocations in mas_store_gfp()
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        liam.howlett@oracle.com, zhangpeng.00@bytedance.com,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org
References: <20231009201639.920512-1-sidhartha.kumar@oracle.com>
 <20231009201639.920512-3-sidhartha.kumar@oracle.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20231009201639.920512-3-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/10/10 04:16, Sidhartha Kumar 写道:
> Preallocate maple nodes before call to mas_wr_store_entry(). If a new
> node is not needed, go directly to mas_wr_store_entry(), otherwise
> allocate the needed nodes and set the MA_STATE_PREALLOC flag.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>   lib/maple_tree.c | 22 +++++++++++++++++++---
>   1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index e239197a57fc..25ae66e585f4 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5478,17 +5478,33 @@ int mas_prealloc_calc(struct ma_wr_state *wr_mas)
>   int mas_store_gfp(struct ma_state *mas, void *entry, gfp_t gfp)
>   {
>   	MA_WR_STATE(wr_mas, mas, entry);
> +	int request;
>   
>   	mas_wr_store_setup(&wr_mas);
> -	trace_ma_write(__func__, mas, 0, entry);
> -retry:
> +	wr_mas.content = mas_start(mas);
> +
> +	request = mas_prealloc_calc(&wr_mas);
mas_wr_store_entry() does something similar to mas_prealloc_calc().
Now, making it do it twice would incur additional overhead.
We encountered this issue while optimizing preallocation, but it
hasn't been resolved yet. Previously, this problem only occurred
when using mas_preallocate(). Now, this change would bring this
impact to all write operations on maple tree. What do you think
about it?

Thanks,
Peng
> +	if (!request)
> +		goto store_entry;
> +
> +	mas_node_count_gfp(mas, request, gfp);
> +	if (unlikely(mas_is_err(mas))) {
> +		mas_set_alloc_req(mas, 0);
> +		mas_destroy(mas);
> +		mas_reset(mas);
> +		return xa_err(mas->node);
> +	}
> +	mas->mas_flags |= MA_STATE_PREALLOC;
> +
> +store_entry:
>   	mas_wr_store_entry(&wr_mas);
>   	if (unlikely(mas_nomem(mas, gfp)))
> -		goto retry;
> +		goto store_entry;
>   
>   	if (unlikely(mas_is_err(mas)))
>   		return xa_err(mas->node);
>   
> +	trace_ma_write(__func__, mas, 0, entry);
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(mas_store_gfp);
