Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3EEA77FD29
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354062AbjHQRmm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Aug 2023 13:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354073AbjHQRmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:42:33 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447412D68;
        Thu, 17 Aug 2023 10:42:32 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-56cae50792fso16353eaf.1;
        Thu, 17 Aug 2023 10:42:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692294151; x=1692898951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbKSS3dbtmxuOxHslNWQ0jBSymfmz4ReQayKmard/fU=;
        b=HtWk63haCpIV6SNB4GdAUIPyCab39m0kbTK3LuFUtZkxv+KrNXmvByUrJ9U09qSt9D
         g0K7+PBFJpCahWcS9keXWGB8Q85rpiukrhcARHbl+Jo+e9+7nPsebGBADClZZotuoLsm
         1NpA5yKRiXidrYi1r0SPa2gUq0GS7NR78POIQ59md4eNfSWkFqZSHx8NLM53/EvwrmXU
         CyMaqval0vdg0EJ8ysV8XKl08FVZG5VgdXM4ikCZjRk80zAgLZJLTybhZ313o5YRarhq
         sWUu25s68Cga28SOnyKnCvZ2WQ1QLV4qrZ3WmTXJs2kHBO2OWFkKyyZXzV+QixK4xk1g
         iu/g==
X-Gm-Message-State: AOJu0YxR7339jl33AUSTaJrNC1lhaj76j0I3Aqj0ywCWACFGEEjKXNbW
        OFHAP88U6nnJWmH0G76zCHs8iyBXzafgaCAYMhyOpB7m
X-Google-Smtp-Source: AGHT+IGt8tO+aZwGEy2r7Ioxzk3ccY4xwluoQTDNQn/dr49mrftA2TviKHvbBAGgENCBk6dlXXMg//68Gn00p/30J5w=
X-Received: by 2002:a4a:e684:0:b0:56d:6bd4:4db5 with SMTP id
 u4-20020a4ae684000000b0056d6bd44db5mr546709oot.0.1692294151461; Thu, 17 Aug
 2023 10:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230802092856.819328-1-lizhijian@cn.fujitsu.com>
In-Reply-To: <20230802092856.819328-1-lizhijian@cn.fujitsu.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Aug 2023 19:42:20 +0200
Message-ID: <CAJZ5v0jY87yCjmFv2HsJ1ZuDF_9bXW0iM5rqGJdY1DhkEuRdfQ@mail.gmail.com>
Subject: Re: [PATCH] acpi,mm: fix typo sibiling -> sibling
To:     Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     akpm@linux-foundation.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org, rafael@kernel.org, lenb@kernel.org,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        aneesh.kumar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 11:30 AM Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
>
> First found this typo as reviewing memory tier code. Fix it by sed like:
> $ sed -i 's/sibiling/sibling/g' $(git grep -l sibiling)
>
> so the acpi one will be corrected as well.
>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>

Please post the ACPI and mm changes as separate patches.

Thanks!

> ---
>  drivers/acpi/acpi_pad.c      |  2 +-
>  include/linux/memory-tiers.h |  2 +-
>  mm/memory-tiers.c            | 10 +++++-----
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
> index 7a453c5ff303..7f073ca64f0e 100644
> --- a/drivers/acpi/acpi_pad.c
> +++ b/drivers/acpi/acpi_pad.c
> @@ -100,7 +100,7 @@ static void round_robin_cpu(unsigned int tsk_index)
>         for_each_cpu(cpu, pad_busy_cpus)
>                 cpumask_or(tmp, tmp, topology_sibling_cpumask(cpu));
>         cpumask_andnot(tmp, cpu_online_mask, tmp);
> -       /* avoid HT sibilings if possible */
> +       /* avoid HT siblings if possible */
>         if (cpumask_empty(tmp))
>                 cpumask_andnot(tmp, cpu_online_mask, pad_busy_cpus);
>         if (cpumask_empty(tmp)) {
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index fc9647b1b4f9..1e6c8ddcaa92 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -22,7 +22,7 @@
>  struct memory_tier;
>  struct memory_dev_type {
>         /* list of memory types that are part of same tier as this type */
> -       struct list_head tier_sibiling;
> +       struct list_head tier_sibling;
>         /* abstract distance for this specific memory type */
>         int adistance;
>         /* Nodes of same abstract distance */
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index a516e303e304..56c22470c96d 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -115,7 +115,7 @@ static __always_inline nodemask_t get_memtier_nodemask(struct memory_tier *memti
>         nodemask_t nodes = NODE_MASK_NONE;
>         struct memory_dev_type *memtype;
>
> -       list_for_each_entry(memtype, &memtier->memory_types, tier_sibiling)
> +       list_for_each_entry(memtype, &memtier->memory_types, tier_sibling)
>                 nodes_or(nodes, nodes, memtype->nodes);
>
>         return nodes;
> @@ -174,7 +174,7 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
>          * If the memtype is already part of a memory tier,
>          * just return that.
>          */
> -       if (!list_empty(&memtype->tier_sibiling)) {
> +       if (!list_empty(&memtype->tier_sibling)) {
>                 list_for_each_entry(memtier, &memory_tiers, list) {
>                         if (adistance == memtier->adistance_start)
>                                 return memtier;
> @@ -218,7 +218,7 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
>         memtier = new_memtier;
>
>  link_memtype:
> -       list_add(&memtype->tier_sibiling, &memtier->memory_types);
> +       list_add(&memtype->tier_sibling, &memtier->memory_types);
>         return memtier;
>  }
>
> @@ -527,7 +527,7 @@ static bool clear_node_memory_tier(int node)
>                 memtype = node_memory_types[node].memtype;
>                 node_clear(node, memtype->nodes);
>                 if (nodes_empty(memtype->nodes)) {
> -                       list_del_init(&memtype->tier_sibiling);
> +                       list_del_init(&memtype->tier_sibling);
>                         if (list_empty(&memtier->memory_types))
>                                 destroy_memory_tier(memtier);
>                 }
> @@ -553,7 +553,7 @@ struct memory_dev_type *alloc_memory_type(int adistance)
>                 return ERR_PTR(-ENOMEM);
>
>         memtype->adistance = adistance;
> -       INIT_LIST_HEAD(&memtype->tier_sibiling);
> +       INIT_LIST_HEAD(&memtype->tier_sibling);
>         memtype->nodes  = NODE_MASK_NONE;
>         kref_init(&memtype->kref);
>         return memtype;
> --
> 2.31.1
>
