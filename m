Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556847D0A8C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbjJTIbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbjJTIbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:31:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C5D126
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:31:12 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9bdf5829000so86122066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 01:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697790671; x=1698395471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=63XdKJFlE3XHdWbx77/cPD/Bou+LzOjSKYnLfRl/Zic=;
        b=B3x9DvfmFQjCabKzUcadJl//AmmYu/FErCA4Oklf1UqhUmZMWRdZcn6X2HDNeflYIL
         OeztCJg/KEXkqNFKykmeCNFdRoxrHvLYG9hWi5AQ5A11h0CrNcDM5VfjE2l0cmPXphx4
         rq2eu10iNJUXjLr2PvyHxf0s4yQQ2lYLM7u3DYpjrRP5AENcMvV9jKsedASW2yCcfUjl
         dxRO6bdpPOI6ofeWtP9ZETxcVyvTqlPYYLly/fvQMxZ+aepQe3h2XguDSqGTUlPsINKd
         ivNqXUQZvOCk3M+J5pQtpC8EQj6YDUwoO03RT5RSO8FuroDKr0TuWxY15wP4Dg5hydO8
         M+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697790671; x=1698395471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=63XdKJFlE3XHdWbx77/cPD/Bou+LzOjSKYnLfRl/Zic=;
        b=aZVphAoxScYM4wpQuWe/Bcvcnb21SdTPgKA3VryU7866IL/JeKuqI3Dv/Chuc5Ra+e
         8z+1qyfuNyVbW82pJjYQFy8RKovNEYb9Ss3Dp0r+eibof4flX/NurpEiuDAsiL4iwRqW
         X3X02n17Ht/Vqf7jWf62TyDMvHnJSQac5YN3HVfG7w/8ZiYCly9hiXVUfHdmekE7YCfb
         clO/Juw2cGBuPT9qsQDmu6bSqGlJ4K8AIAehhK2FSw4oiNV99rmvCzciLd6O19f9IM9h
         n/W4IA2r0n+4ka753L0SS9U1ihvcnsnesKkEaPTqAzUFMpar9W2HjQn4DarfwgUtWqMr
         5cHQ==
X-Gm-Message-State: AOJu0Yz6zlAapZyEp6BA6gMLN77sSPvcdPKzfhFZg74N3STIWl2nsxpv
        LIywt0pOc0al/oQWHfZB6PY=
X-Google-Smtp-Source: AGHT+IFOoBm3a2bQ11qHvOxPwlByvO21gJun8M21VkOUysgZc4U8IwN/X2ZMG/fH+O83Zum+sV4Y0A==
X-Received: by 2002:a17:907:9815:b0:9bf:792:d696 with SMTP id ji21-20020a170907981500b009bf0792d696mr697889ejc.46.1697790671041;
        Fri, 20 Oct 2023 01:31:11 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090657d100b0099bc8bd9066sm1029882ejr.150.2023.10.20.01.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 01:31:10 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 20 Oct 2023 10:31:08 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, rppt@kernel.org, david@redhat.com,
        vbabka@suse.cz, mhocko@suse.com, willy@infradead.org,
        mgorman@techsingularity.net, aneesh.kumar@linux.ibm.com,
        ying.huang@intel.com, hannes@cmpxchg.org, osalvador@suse.de,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 1/2] mm: page_alloc: skip memoryless nodes entirely
Message-ID: <ZTI6zM0MUlfglkD+@gmail.com>
References: <cover.1697711415.git.zhengqi.arch@bytedance.com>
 <157013e978468241de4a4c05d5337a44638ecb0e.1697711415.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157013e978468241de4a4c05d5337a44638ecb0e.1697711415.git.zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Qi Zheng <zhengqi.arch@bytedance.com> wrote:

> In find_next_best_node(), We skipped the memoryless nodes

s/We
 /we

s/the memoryless nodes
 /memoryless nodes

> when building the zonelists of other normal nodes (N_NORMAL),
> but did not skip the memoryless node itself when building
> the zonelist. This will cause it to be traversed at runtime.
> 
> For example, say we have node0 and node1, node0 is memoryless
> node, then the fallback order of node0 and node1 as follows:
> 
> [    0.153005] Fallback order for Node 0: 0 1
> [    0.153564] Fallback order for Node 1: 1
> 
> After this patch, we skip memoryless node0 entirely, then
> the fallback order of node0 and node1 as follows:

s/fallback
 /fall back

> 
> [    0.155236] Fallback order for Node 0: 1
> [    0.155806] Fallback order for Node 1: 1
> 
> So it becomes completely invisible, which will reduce runtime
> overhead.
> 
> And in this way, we will not try to allocate pages from memoryless
> node0, then the panic mentioned in [1] will also be fixed. Even though
> this problem has been solved by dropping the NODE_MIN_SIZE constrain
> in x86 [2], it would be better to fix it in core MM as well.

s/in core MM
 /in the core MM

> [1]. https://lore.kernel.org/all/20230212110305.93670-1-zhengqi.arch@bytedance.com/
> [2]. https://lore.kernel.org/all/20231017062215.171670-1-rppt@kernel.org/
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Acked-by: David Hildenbrand <david@redhat.com>

> +	/*
> +	 * Use the local node if we haven't already. But for memoryless local
> +	 * node, we should skip it and fallback to other nodes.

s/fallback
 /fall back

s/already. But
 /already, but

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
