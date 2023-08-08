Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43ED6774341
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbjHHR74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbjHHR7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:59:24 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DE22CC4C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:26:53 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d2b8437d825so5808664276.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691511979; x=1692116779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzvjGxgEq+LtZZdyPTPHKgoOYqzBn/ItwHuccLXsw3U=;
        b=fBE3x/l+C3VKo8FO3fVS/iF/fhcHbbEsdOdaGoNacCkajhWuI4HnRWX3Ogne/9fXwS
         a7i7rTxroNcwMYX+3cngO8f1nOM7zbBEJeDAfzEPc649RLSEsaXWDaRX2dkpNGrkKhBO
         G5Kdxj/omgychPGrm17b11KB3pzbChkm/9ZBEtB1mBGASfURxAzkLfWpJI4hnbIZ4ISR
         kH+kikx1KlgERen42bkEPu371Isj82R/4UOZUCz/z6vFfjcATK2KE1/+RgzLXsgVDfjx
         MoKgNmGcsshlTR7OQgubYKJyQ5hQLGEu54e69okkfdHSmMDZ4H8SKOG75snAXknO1Chl
         Ma2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511979; x=1692116779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rzvjGxgEq+LtZZdyPTPHKgoOYqzBn/ItwHuccLXsw3U=;
        b=cemtXYuLaAOlzsy4gzwbDwVVPwKFKz/uh6O0zCaEi1qucUB04G33nRgeVRH4sDiThy
         hfk/4ggR6mTpU/QkyWpls4YMY2bRN7TNtGtOfBO5zAzuLar2Qn/Odu3teSuBGlbvb8eV
         3EuT+EQI7JZ93dAiA95PJIa3YgLMutWixJJK8Bg1gL8TbhP8MGaX7ZfXJu+ts2/f8sOM
         YcwuJ1t8DVF0DisPu34ODDTDKDDjnIYDOjRSUzDpp6hDV0fi2ATIT+ag7ZNUlPvfp3FZ
         OJyLIAQ8VMME1u5iY5NpdVeJHlOOenU9VjA/qkEiuJ9E45uoqChQsCPsUe5ZGu17FUhi
         qO3A==
X-Gm-Message-State: AOJu0Yx/kRvyKXJlR32T8hRIVh6lySr+JjsDfn4a0DuFJOrcv8VOlOo7
        gRLl5jT4y6W79WU1MPeYixF8cx3zMz4GR5q4SrY=
X-Google-Smtp-Source: AGHT+IF/38k+mHYDsiCV9q5ja1BmiVsvVPQRkz7QNU8NMvABvumJfQv6Cb+Dkh3TgtDABWaEDoiMaQ==
X-Received: by 2002:a05:6808:f8d:b0:3a7:3ea1:b5a0 with SMTP id o13-20020a0568080f8d00b003a73ea1b5a0mr14696027oiw.47.1691493459612;
        Tue, 08 Aug 2023 04:17:39 -0700 (PDT)
Received: from [10.90.34.137] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a005e00b0025023726fc4sm11179299pjb.26.2023.08.08.04.17.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 04:17:39 -0700 (PDT)
Message-ID: <853af8fa-0cef-b00b-3fd6-9780a2008050@bytedance.com>
Date:   Tue, 8 Aug 2023 19:17:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [RFC v1 4/5] maple_tree: avoid bulk alloc/free to use percpu
 array more
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Matthew Wilcox <willy@infradead.org>
References: <20230808095342.12637-7-vbabka@suse.cz>
 <20230808095342.12637-11-vbabka@suse.cz>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <20230808095342.12637-11-vbabka@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/8 17:53, Vlastimil Babka 写道:
> Using bulk alloc/free on a cache with percpu array should not be
> necessary and the bulk alloc actually bypasses the array (the prefill
> functionality currently relies on this).
> 
> The simplest change is just to convert the respective maple tree
> wrappers to do a loop of normal alloc/free.
> ---
>   lib/maple_tree.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 1196d0a17f03..7a8e7c467d7c 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -161,12 +161,19 @@ static inline struct maple_node *mt_alloc_one(gfp_t gfp)
>   
>   static inline int mt_alloc_bulk(gfp_t gfp, size_t size, void **nodes)
>   {
> -	return kmem_cache_alloc_bulk(maple_node_cache, gfp, size, nodes);
> +	int allocated = 0;
> +	for (size_t i = 0; i < size; i++) {
> +		nodes[i] = kmem_cache_alloc(maple_node_cache, gfp);
> +		if (nodes[i])
If the i-th allocation fails, node[i] will be NULL. This is wrong. We'd
better guarantee that mt_alloc_bulk() allocates completely successfully,
or returns 0. The following cases are not allowed:
nodes: [addr1][addr2][NULL][addr3].
> +			allocated++;
> +	}
> +	return allocated;
>   }
>   
>   static inline void mt_free_bulk(size_t size, void __rcu **nodes)
>   {
> -	kmem_cache_free_bulk(maple_node_cache, size, (void **)nodes);
> +	for (size_t i = 0; i < size; i++)
> +		kmem_cache_free(maple_node_cache, nodes[i]);
>   }
>   
>   static void mt_free_rcu(struct rcu_head *head)
