Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6D9813916
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjLNRwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjLNRwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:52:07 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D7ACF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:52:12 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d08fba6a49so1905ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702576331; x=1703181131; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vJ+K4yH8roPh9n2FemElBWDJZk+CgRuv2WPpA5jHSCY=;
        b=f/lW6I15QP1Ilp5PT9w1USMoScPFhbWhryodOtqYeNgGeNSrM+4iTkASaa7vmfaDwT
         XKEXilqEGw5qMF0E36L3qAIQ0BxyFCeStMWOngTIb+aQRXyGvj30GKB386EhbLh/iNXg
         kc3HBjp1YbD34lFY7zcqXDtLLjnl5M8zZNbgWrKDq3lbP073FdPIJv/I6LV0q2cl+KVM
         A24R7Er0nGh/uMhbGlKuKxCrKwnUdbVHusjhjBnBfoI4fuoNCKQbxrSwECXBrnrgClCj
         ZUltkL6nx0FJxjfvaG7ZNT7oxsIiI571vjdDLaKuiRxbfEOJCF9o/CBj38Gd5lBxCG5X
         58YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702576331; x=1703181131;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJ+K4yH8roPh9n2FemElBWDJZk+CgRuv2WPpA5jHSCY=;
        b=n+DaPIS8VuPCTakwadvDYrbBb4pxgVfR6TvwJEEerwGzalKJ8un7ulAdO9yq6p0WVQ
         ybQApVT0+n7WpEx26mK0h6uJYJJQwRFHOoi1zUAnVlKJ2518kk6wHBYhrSSKxLAwJEpm
         y4jqWtlerYQdPLWh3avmyIIpQBp2duZYp9RcrdxekryPNDxvMQsoF++fOxGYS2a5tWHw
         fBJbxH+oFdueWqb3W4YQFfmtQFO6IAuitV4852BF0TB9qNVketrur6pO/9DCjmufQEbg
         V6YdHGfYK1QBQsQ7daDOcMVZL3Mf9oWawT7u/DcGS6xeDyt7eUHRiAWJiWiMp+mSzxA7
         NPVw==
X-Gm-Message-State: AOJu0Yy9PWgbrqIzqzZEwZj/+RAX9uVsyrI31nWI3+nRB70E60WLRP1U
        GK+ITCt5ZMW31j1tTvU6JRLbVCtB6UVzps6Aieeg3w==
X-Google-Smtp-Source: AGHT+IGxl159RUYdXDJxIQ37MRtRUw13DGqHBbx+iofYHjiwsdjJLniJZRjpBKs86lf9MZV8GuaSKg==
X-Received: by 2002:a17:902:b20f:b0:1d3:4091:a993 with SMTP id t15-20020a170902b20f00b001d34091a993mr830163plr.1.1702576331143;
        Thu, 14 Dec 2023 09:52:11 -0800 (PST)
Received: from [2620:0:1008:15:740b:4c24:bdb6:a42a] ([2620:0:1008:15:740b:4c24:bdb6:a42a])
        by smtp.gmail.com with ESMTPSA id c10-20020a170903234a00b001d043588122sm12713661plh.142.2023.12.14.09.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 09:52:10 -0800 (PST)
Date:   Thu, 14 Dec 2023 09:52:09 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        souravpanda@google.com
Subject: Re: [PATCH] vmstat: don't auto expand the sysfs files
In-Reply-To: <20231211154644.4103495-1-pasha.tatashin@soleen.com>
Message-ID: <3d415ab4-e8c7-7e72-0379-952370612bdd@google.com>
References: <20231211154644.4103495-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023, Pasha Tatashin wrote:

> Whenever a new fields are added one of the following: node_stat_item
> numa_stat_item zone_stat_item, the /sys/devices/system/node/nodeX/vmstat
> files are auto expanded.
> 
> This is a problem, as sysfs files should be only one value per file.

Does this patch address the one-value-per-file issue?  (I think that ship 
has sailed for vmstat.)

/sys/devices/system/node/nodeX/vmstat has been documented as a stable ABI 
in Linux for 13 years.

That said, the contents of the file has not been documented so I assume 
it's "whatever stats make sense for the current implementation of the 
Linux VM".

> Also, once a field is exported via vmstat it is hard to remove it as
> there could be user applications that rely on this field. This is why
> we still cary "nr_unstable 0" in /proc/vmstat that is not used.
> 

Implementations change over time, so this would be expected.

I'm assuming, but perhaps incorrectly, that userspace won't crash if 
nr_unstable just don't appear anymore.  That whoever is using it would 
just assume that it's zero if it doesn't appear.

So I think we need to answer the question of: are the *contents* of files 
like vmstat that are heavily dependent on implementation level details 
really part of a stable ABI that people can expect will carry on forever?  

> Also, since vmstat is auto-expanded the fields are not documented, so
> users do not know whether they are counted in bytes/kilobytes/pages,
> and the exact meaning of these fields.
> 

I think that's actually intended since there can also be ones that are 
event counters.  I don't think any fields in vmstat are intended to be 
long-term sacred stable ABIs.

> Modify the code that the new fields do not auto-expand the vmstat in
> sysfs. The new fields can still be exported via their own files in
> sysfs, and be properly documents.
> 
> vmstat values are named using vmstat_text[] array, which contains names
> for zone_stat, numa_stat, node_stat, lru_list, writeback_stat,
> vm_event.
> 
> Change vmstat_text[] to be an array of structs that contain two values:
> name, and flags.  The new flags field contains information whether to
> show stat value in vmstat files in sysfs (VMSTAT_SHOW_SYSFS), and in
> procfs (VMSTAT_SHOW_PROCFS). The comment above VMSTAT_SHOW_SYSFS
> documents that this flag should not be used for new stat values when
> they are added.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  drivers/base/node.c    |  34 ++--
>  include/linux/vmstat.h |  48 ++++--
>  mm/vmstat.c            | 377 +++++++++++++++++++++--------------------
>  3 files changed, 244 insertions(+), 215 deletions(-)
> 
> Examples of the projects that are currently under review and that add new
> fields to the one of the vmstat items:
> 
> [1] mm: report per-page metadata information
> https://lore.kernel.org/all/20231205223118.3575485-1-souravpanda@google.com
> 
> [2] IOMMU memory observability
> https://lore.kernel.org/all/20231130201504.2322355-1-pasha.tatashin@soleen.com
> 
> Greg KH has been requesting for these files not to grow:
> https://lore.kernel.org/all/2023120731-deception-handmade-8d49@gregkh
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 493d533f8375..f139d7ab58f5 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -520,26 +520,34 @@ static ssize_t node_read_vmstat(struct device *dev,
>  	int i;
>  	int len = 0;
>  
> -	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
> -		len += sysfs_emit_at(buf, len, "%s %lu\n",
> -				     zone_stat_name(i),
> -				     sum_zone_node_page_state(nid, i));
> +	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++) {
> +		if (vmstat_text[ZONE_STAT_NAME_IDX(i)].flags & VMSTAT_SHOW_SYSFS) {
> +			len += sysfs_emit_at(buf, len, "%s %lu\n",
> +					     zone_stat_name(i),
> +					     sum_zone_node_page_state(nid, i));
> +		}
> +	}
>  
>  #ifdef CONFIG_NUMA
>  	fold_vm_numa_events();
> -	for (i = 0; i < NR_VM_NUMA_EVENT_ITEMS; i++)
> -		len += sysfs_emit_at(buf, len, "%s %lu\n",
> -				     numa_stat_name(i),
> -				     sum_zone_numa_event_state(nid, i));
> +	for (i = 0; i < NR_VM_NUMA_EVENT_ITEMS; i++) {
> +		if (vmstat_text[NUMA_STAT_NAME_IDX(i)].flags & VMSTAT_SHOW_SYSFS) {
> +			len += sysfs_emit_at(buf, len, "%s %lu\n",
> +					     numa_stat_name(i),
> +					     sum_zone_numa_event_state(nid, i));
> +		}
> +	}
>  
>  #endif
>  	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
> -		unsigned long pages = node_page_state_pages(pgdat, i);
> +		if (vmstat_text[NODE_STAT_NAME_IDX(i)].flags & VMSTAT_SHOW_SYSFS) {
> +			unsigned long pages = node_page_state_pages(pgdat, i);
>  
> -		if (vmstat_item_print_in_thp(i))
> -			pages /= HPAGE_PMD_NR;
> -		len += sysfs_emit_at(buf, len, "%s %lu\n", node_stat_name(i),
> -				     pages);
> +			if (vmstat_item_print_in_thp(i))
> +				pages /= HPAGE_PMD_NR;
> +			len += sysfs_emit_at(buf, len, "%s %lu\n", node_stat_name(i),
> +					     pages);
> +		}
>  	}
>  
>  	return len;
> diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
> index fed855bae6d8..2dd46daf69aa 100644
> --- a/include/linux/vmstat.h
> +++ b/include/linux/vmstat.h
> @@ -495,26 +495,44 @@ static inline void __mod_zone_freepage_state(struct zone *zone, int nr_pages,
>  		__mod_zone_page_state(zone, NR_FREE_CMA_PAGES, nr_pages);
>  }
>  
> -extern const char * const vmstat_text[];
>  
> +/*
> + * Show this stat in /sys/devices/system/node/nodeX/vmstat
> + * IMPORTANT: Don't use this flag for new stats, as the right way to output only
> + * one stat per file in sysfs. Instead, add new individual sysfs files for new
> + * stats, and document them in Documentation/ABI/TYPE/sysfs-new_field_name.
> + */
> +#define VMSTAT_SHOW_SYSFS	BIT(0)
> +
> +/* Show this stat in /proc/vmstat */
> +#define VMSTAT_SHOW_PROCFS	BIT(1)
> +
> +struct vmstat_text {
> +	const char *name;
> +	char flags;
> +};
> +
> +extern const struct vmstat_text vmstat_text[];
> +
> +#define ZONE_STAT_NAME_IDX(item)	((int)(item))
>  static inline const char *zone_stat_name(enum zone_stat_item item)
>  {
> -	return vmstat_text[item];
> +	return vmstat_text[ZONE_STAT_NAME_IDX(item)].name;
>  }
>  
>  #ifdef CONFIG_NUMA
> +#define NUMA_STAT_NAME_IDX(item)	(NR_VM_ZONE_STAT_ITEMS + (int)(item))
>  static inline const char *numa_stat_name(enum numa_stat_item item)
>  {
> -	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
> -			   item];
> +	return vmstat_text[NUMA_STAT_NAME_IDX(item)].name;
>  }
>  #endif /* CONFIG_NUMA */
>  
> +#define NODE_STAT_NAME_IDX(item)	(NR_VM_NUMA_EVENT_ITEMS +	\
> +	NR_VM_ZONE_STAT_ITEMS + (int)(item))
>  static inline const char *node_stat_name(enum node_stat_item item)
>  {
> -	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
> -			   NR_VM_NUMA_EVENT_ITEMS +
> -			   item];
> +	return vmstat_text[NODE_STAT_NAME_IDX(item)].name;
>  }
>  
>  static inline const char *lru_list_name(enum lru_list lru)
> @@ -522,22 +540,20 @@ static inline const char *lru_list_name(enum lru_list lru)
>  	return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>  }
>  
> +#define WRITEBACK_STAT_NAME_IDX(item)	(NR_VM_NODE_STAT_ITEMS +	\
> +	NR_VM_NUMA_EVENT_ITEMS + NR_VM_ZONE_STAT_ITEMS + (int)(item))
>  static inline const char *writeback_stat_name(enum writeback_stat_item item)
>  {
> -	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
> -			   NR_VM_NUMA_EVENT_ITEMS +
> -			   NR_VM_NODE_STAT_ITEMS +
> -			   item];
> +	return vmstat_text[WRITEBACK_STAT_NAME_IDX(item)].name;
>  }
>  
>  #if defined(CONFIG_VM_EVENT_COUNTERS) || defined(CONFIG_MEMCG)
> +#define VM_EVENT_NAME_IDX(item)	(NR_VM_WRITEBACK_STAT_ITEMS +		\
> +	NR_VM_NODE_STAT_ITEMS + NR_VM_NUMA_EVENT_ITEMS +		\
> +	NR_VM_ZONE_STAT_ITEMS + (int)(item))
>  static inline const char *vm_event_name(enum vm_event_item item)
>  {
> -	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
> -			   NR_VM_NUMA_EVENT_ITEMS +
> -			   NR_VM_NODE_STAT_ITEMS +
> -			   NR_VM_WRITEBACK_STAT_ITEMS +
> -			   item];
> +	return vmstat_text[VM_EVENT_NAME_IDX(item)].name;
>  }
>  #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
>  
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 359460deb377..691d8c90b4ac 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1142,278 +1142,281 @@ int fragmentation_index(struct zone *zone, unsigned int order)
>  #if defined(CONFIG_PROC_FS) || defined(CONFIG_SYSFS) || \
>      defined(CONFIG_NUMA) || defined(CONFIG_MEMCG)
>  #ifdef CONFIG_ZONE_DMA
> -#define TEXT_FOR_DMA(xx) xx "_dma",
> +#define TEXT_FOR_DMA(xx) {xx "_dma",	VMSTAT_SHOW_PROCFS},
>  #else
>  #define TEXT_FOR_DMA(xx)
>  #endif
>  
>  #ifdef CONFIG_ZONE_DMA32
> -#define TEXT_FOR_DMA32(xx) xx "_dma32",
> +#define TEXT_FOR_DMA32(xx) {xx "_dma32",	VMSTAT_SHOW_PROCFS},
>  #else
>  #define TEXT_FOR_DMA32(xx)
>  #endif
>  
>  #ifdef CONFIG_HIGHMEM
> -#define TEXT_FOR_HIGHMEM(xx) xx "_high",
> +#define TEXT_FOR_HIGHMEM(xx) {xx "_high",	VMSTAT_SHOW_PROCFS},
>  #else
>  #define TEXT_FOR_HIGHMEM(xx)
>  #endif
>  
>  #ifdef CONFIG_ZONE_DEVICE
> -#define TEXT_FOR_DEVICE(xx) xx "_device",
> +#define TEXT_FOR_DEVICE(xx) {xx "_device",	VMSTAT_SHOW_PROCFS},
>  #else
>  #define TEXT_FOR_DEVICE(xx)
>  #endif
>  
> -#define TEXTS_FOR_ZONES(xx) TEXT_FOR_DMA(xx) TEXT_FOR_DMA32(xx) xx "_normal", \
> -					TEXT_FOR_HIGHMEM(xx) xx "_movable", \
> -					TEXT_FOR_DEVICE(xx)
> +#define TEXT_FOR_NORMAL(xx) {xx "_normal", VMSTAT_SHOW_PROCFS},
> +#define TEXT_FOR_MOVABLE(xx) {xx "_movable", VMSTAT_SHOW_PROCFS},
>  
> -const char * const vmstat_text[] = {
> +#define TEXTS_FOR_ZONES(xx) TEXT_FOR_DMA(xx) TEXT_FOR_DMA32(xx)		\
> +	TEXT_FOR_NORMAL(xx) TEXT_FOR_HIGHMEM(xx) TEXT_FOR_MOVABLE(xx)	\
> +	TEXT_FOR_DEVICE(xx)
> +
> +const struct vmstat_text vmstat_text[] = {
>  	/* enum zone_stat_item counters */
> -	"nr_free_pages",
> -	"nr_zone_inactive_anon",
> -	"nr_zone_active_anon",
> -	"nr_zone_inactive_file",
> -	"nr_zone_active_file",
> -	"nr_zone_unevictable",
> -	"nr_zone_write_pending",
> -	"nr_mlock",
> -	"nr_bounce",
> +	{"nr_free_pages",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_zone_inactive_anon",	VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_zone_active_anon",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_zone_inactive_file",	VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_zone_active_file",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_zone_unevictable",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_zone_write_pending",	VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_mlock",			VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_bounce",			VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
>  #if IS_ENABLED(CONFIG_ZSMALLOC)
> -	"nr_zspages",
> +	{"nr_zspages",			VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
>  #endif
> -	"nr_free_cma",
> +	{"nr_free_cma",			VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
>  #ifdef CONFIG_UNACCEPTED_MEMORY
> -	"nr_unaccepted",
> +	{"nr_unaccepted",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
>  #endif
>  
>  	/* enum numa_stat_item counters */
>  #ifdef CONFIG_NUMA
> -	"numa_hit",
> -	"numa_miss",
> -	"numa_foreign",
> -	"numa_interleave",
> -	"numa_local",
> -	"numa_other",
> +	{"numa_hit",			VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"numa_miss",			VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"numa_foreign",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"numa_interleave",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"numa_local",			VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"numa_other",			VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
>  #endif
> -
>  	/* enum node_stat_item counters */
> -	"nr_inactive_anon",
> -	"nr_active_anon",
> -	"nr_inactive_file",
> -	"nr_active_file",
> -	"nr_unevictable",
> -	"nr_slab_reclaimable",
> -	"nr_slab_unreclaimable",
> -	"nr_isolated_anon",
> -	"nr_isolated_file",
> -	"workingset_nodes",
> -	"workingset_refault_anon",
> -	"workingset_refault_file",
> -	"workingset_activate_anon",
> -	"workingset_activate_file",
> -	"workingset_restore_anon",
> -	"workingset_restore_file",
> -	"workingset_nodereclaim",
> -	"nr_anon_pages",
> -	"nr_mapped",
> -	"nr_file_pages",
> -	"nr_dirty",
> -	"nr_writeback",
> -	"nr_writeback_temp",
> -	"nr_shmem",
> -	"nr_shmem_hugepages",
> -	"nr_shmem_pmdmapped",
> -	"nr_file_hugepages",
> -	"nr_file_pmdmapped",
> -	"nr_anon_transparent_hugepages",
> -	"nr_vmscan_write",
> -	"nr_vmscan_immediate_reclaim",
> -	"nr_dirtied",
> -	"nr_written",
> -	"nr_throttled_written",
> -	"nr_kernel_misc_reclaimable",
> -	"nr_foll_pin_acquired",
> -	"nr_foll_pin_released",
> -	"nr_kernel_stack",
> +	{"nr_inactive_anon",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_active_anon",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_inactive_file",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_active_file",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_unevictable",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_slab_reclaimable",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_slab_unreclaimable",	VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_isolated_anon",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_isolated_file",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"workingset_nodes",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"workingset_refault_anon",	VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"workingset_refault_file",	VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"workingset_activate_anon",	VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"workingset_activate_file",	VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"workingset_restore_anon",	VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"workingset_restore_file",	VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"workingset_nodereclaim",	VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_anon_pages",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_mapped",			VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_file_pages",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_dirty",			VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_writeback",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_writeback_temp",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_shmem",			VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_shmem_hugepages",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_shmem_pmdmapped",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_file_hugepages",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_file_pmdmapped",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_anon_transparent_hugepages", VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_vmscan_write",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_vmscan_immediate_reclaim",	VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_dirtied",			VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_written",			VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_throttled_written",	VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_kernel_misc_reclaimable",	VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_foll_pin_acquired",	VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_foll_pin_released",	VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_kernel_stack",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
>  #if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
> -	"nr_shadow_call_stack",
> +	{"nr_shadow_call_stack",	VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
>  #endif
> -	"nr_page_table_pages",
> -	"nr_sec_page_table_pages",
> +	{"nr_page_table_pages",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"nr_sec_page_table_pages",	VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
>  #ifdef CONFIG_SWAP
> -	"nr_swapcached",
> +	{"nr_swapcached",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
>  #endif
>  #ifdef CONFIG_NUMA_BALANCING
> -	"pgpromote_success",
> -	"pgpromote_candidate",
> +	{"pgpromote_success",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
> +	{"pgpromote_candidate",		VMSTAT_SHOW_PROCFS | VMSTAT_SHOW_SYSFS},
>  #endif
>  
>  	/* enum writeback_stat_item counters */
> -	"nr_dirty_threshold",
> -	"nr_dirty_background_threshold",
> +	{"nr_dirty_threshold",		VMSTAT_SHOW_PROCFS},
> +	{"nr_dirty_background_threshold", VMSTAT_SHOW_PROCFS},
>  
>  #if defined(CONFIG_VM_EVENT_COUNTERS) || defined(CONFIG_MEMCG)
>  	/* enum vm_event_item counters */
> -	"pgpgin",
> -	"pgpgout",
> -	"pswpin",
> -	"pswpout",
> +	{"pgpgin",			VMSTAT_SHOW_PROCFS},
> +	{"pgpgout",			VMSTAT_SHOW_PROCFS},
> +	{"pswpin",			VMSTAT_SHOW_PROCFS},
> +	{"pswpout",			VMSTAT_SHOW_PROCFS},
>  
>  	TEXTS_FOR_ZONES("pgalloc")
>  	TEXTS_FOR_ZONES("allocstall")
>  	TEXTS_FOR_ZONES("pgskip")
>  
> -	"pgfree",
> -	"pgactivate",
> -	"pgdeactivate",
> -	"pglazyfree",
> -
> -	"pgfault",
> -	"pgmajfault",
> -	"pglazyfreed",
> -
> -	"pgrefill",
> -	"pgreuse",
> -	"pgsteal_kswapd",
> -	"pgsteal_direct",
> -	"pgsteal_khugepaged",
> -	"pgdemote_kswapd",
> -	"pgdemote_direct",
> -	"pgdemote_khugepaged",
> -	"pgscan_kswapd",
> -	"pgscan_direct",
> -	"pgscan_khugepaged",
> -	"pgscan_direct_throttle",
> -	"pgscan_anon",
> -	"pgscan_file",
> -	"pgsteal_anon",
> -	"pgsteal_file",
> +	{"pgfree",			VMSTAT_SHOW_PROCFS},
> +	{"pgactivate",			VMSTAT_SHOW_PROCFS},
> +	{"pgdeactivate",		VMSTAT_SHOW_PROCFS},
> +	{"pglazyfree",			VMSTAT_SHOW_PROCFS},
> +
> +	{"pgfault",			VMSTAT_SHOW_PROCFS},
> +	{"pgmajfault",			VMSTAT_SHOW_PROCFS},
> +	{"pglazyfreed",			VMSTAT_SHOW_PROCFS},
> +
> +	{"pgrefill",			VMSTAT_SHOW_PROCFS},
> +	{"pgreuse",			VMSTAT_SHOW_PROCFS},
> +	{"pgsteal_kswapd",		VMSTAT_SHOW_PROCFS},
> +	{"pgsteal_direct",		VMSTAT_SHOW_PROCFS},
> +	{"pgsteal_khugepaged",		VMSTAT_SHOW_PROCFS},
> +	{"pgdemote_kswapd",		VMSTAT_SHOW_PROCFS},
> +	{"pgdemote_direct",		VMSTAT_SHOW_PROCFS},
> +	{"pgdemote_khugepaged",		VMSTAT_SHOW_PROCFS},
> +	{"pgscan_kswapd",		VMSTAT_SHOW_PROCFS},
> +	{"pgscan_direct",		VMSTAT_SHOW_PROCFS},
> +	{"pgscan_khugepaged",		VMSTAT_SHOW_PROCFS},
> +	{"pgscan_direct_throttle",	VMSTAT_SHOW_PROCFS},
> +	{"pgscan_anon",			VMSTAT_SHOW_PROCFS},
> +	{"pgscan_file",			VMSTAT_SHOW_PROCFS},
> +	{"pgsteal_anon",		VMSTAT_SHOW_PROCFS},
> +	{"pgsteal_file",		VMSTAT_SHOW_PROCFS},
>  
>  #ifdef CONFIG_NUMA
> -	"zone_reclaim_failed",
> +	{"zone_reclaim_failed",		VMSTAT_SHOW_PROCFS},
>  #endif
> -	"pginodesteal",
> -	"slabs_scanned",
> -	"kswapd_inodesteal",
> -	"kswapd_low_wmark_hit_quickly",
> -	"kswapd_high_wmark_hit_quickly",
> -	"pageoutrun",
> +	{"pginodesteal",		VMSTAT_SHOW_PROCFS},
> +	{"slabs_scanned",		VMSTAT_SHOW_PROCFS},
> +	{"kswapd_inodesteal",		VMSTAT_SHOW_PROCFS},
> +	{"kswapd_low_wmark_hit_quickly", VMSTAT_SHOW_PROCFS},
> +	{"kswapd_high_wmark_hit_quickly", VMSTAT_SHOW_PROCFS},
> +	{"pageoutrun",			VMSTAT_SHOW_PROCFS},
>  
> -	"pgrotated",
> +	{"pgrotated",			VMSTAT_SHOW_PROCFS},
>  
> -	"drop_pagecache",
> -	"drop_slab",
> -	"oom_kill",
> +	{"drop_pagecache",		VMSTAT_SHOW_PROCFS},
> +	{"drop_slab",			VMSTAT_SHOW_PROCFS},
> +	{"oom_kill",			VMSTAT_SHOW_PROCFS},
>  
>  #ifdef CONFIG_NUMA_BALANCING
> -	"numa_pte_updates",
> -	"numa_huge_pte_updates",
> -	"numa_hint_faults",
> -	"numa_hint_faults_local",
> -	"numa_pages_migrated",
> +	{"numa_pte_updates",		VMSTAT_SHOW_PROCFS},
> +	{"numa_huge_pte_updates",	VMSTAT_SHOW_PROCFS},
> +	{"numa_hint_faults",		VMSTAT_SHOW_PROCFS},
> +	{"numa_hint_faults_local",	VMSTAT_SHOW_PROCFS},
> +	{"numa_pages_migrated",		VMSTAT_SHOW_PROCFS},
>  #endif
>  #ifdef CONFIG_MIGRATION
> -	"pgmigrate_success",
> -	"pgmigrate_fail",
> -	"thp_migration_success",
> -	"thp_migration_fail",
> -	"thp_migration_split",
> +	{"pgmigrate_success",		VMSTAT_SHOW_PROCFS},
> +	{"pgmigrate_fail",		VMSTAT_SHOW_PROCFS},
> +	{"thp_migration_success",	VMSTAT_SHOW_PROCFS},
> +	{"thp_migration_fail",		VMSTAT_SHOW_PROCFS},
> +	{"thp_migration_split",		VMSTAT_SHOW_PROCFS},
>  #endif
>  #ifdef CONFIG_COMPACTION
> -	"compact_migrate_scanned",
> -	"compact_free_scanned",
> -	"compact_isolated",
> -	"compact_stall",
> -	"compact_fail",
> -	"compact_success",
> -	"compact_daemon_wake",
> -	"compact_daemon_migrate_scanned",
> -	"compact_daemon_free_scanned",
> +	{"compact_migrate_scanned",	VMSTAT_SHOW_PROCFS},
> +	{"compact_free_scanned",	VMSTAT_SHOW_PROCFS},
> +	{"compact_isolated",		VMSTAT_SHOW_PROCFS},
> +	{"compact_stall",		VMSTAT_SHOW_PROCFS},
> +	{"compact_fail",		VMSTAT_SHOW_PROCFS},
> +	{"compact_success",		VMSTAT_SHOW_PROCFS},
> +	{"compact_daemon_wake",		VMSTAT_SHOW_PROCFS},
> +	{"compact_daemon_migrate_scanned", VMSTAT_SHOW_PROCFS},
> +	{"compact_daemon_free_scanned",	VMSTAT_SHOW_PROCFS},
>  #endif
>  
>  #ifdef CONFIG_HUGETLB_PAGE
> -	"htlb_buddy_alloc_success",
> -	"htlb_buddy_alloc_fail",
> +	{"htlb_buddy_alloc_success",	VMSTAT_SHOW_PROCFS},
> +	{"htlb_buddy_alloc_fail",	VMSTAT_SHOW_PROCFS},
>  #endif
>  #ifdef CONFIG_CMA
> -	"cma_alloc_success",
> -	"cma_alloc_fail",
> +	{"cma_alloc_success",		VMSTAT_SHOW_PROCFS},
> +	{"cma_alloc_fail",		VMSTAT_SHOW_PROCFS},
>  #endif
> -	"unevictable_pgs_culled",
> -	"unevictable_pgs_scanned",
> -	"unevictable_pgs_rescued",
> -	"unevictable_pgs_mlocked",
> -	"unevictable_pgs_munlocked",
> -	"unevictable_pgs_cleared",
> -	"unevictable_pgs_stranded",
> +	{"unevictable_pgs_culled",	VMSTAT_SHOW_PROCFS},
> +	{"unevictable_pgs_scanned",	VMSTAT_SHOW_PROCFS},
> +	{"unevictable_pgs_rescued",	VMSTAT_SHOW_PROCFS},
> +	{"unevictable_pgs_mlocked",	VMSTAT_SHOW_PROCFS},
> +	{"unevictable_pgs_munlocked",	VMSTAT_SHOW_PROCFS},
> +	{"unevictable_pgs_cleared",	VMSTAT_SHOW_PROCFS},
> +	{"unevictable_pgs_stranded",	VMSTAT_SHOW_PROCFS},
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	"thp_fault_alloc",
> -	"thp_fault_fallback",
> -	"thp_fault_fallback_charge",
> -	"thp_collapse_alloc",
> -	"thp_collapse_alloc_failed",
> -	"thp_file_alloc",
> -	"thp_file_fallback",
> -	"thp_file_fallback_charge",
> -	"thp_file_mapped",
> -	"thp_split_page",
> -	"thp_split_page_failed",
> -	"thp_deferred_split_page",
> -	"thp_split_pmd",
> -	"thp_scan_exceed_none_pte",
> -	"thp_scan_exceed_swap_pte",
> -	"thp_scan_exceed_share_pte",
> +	{"thp_fault_alloc",		VMSTAT_SHOW_PROCFS},
> +	{"thp_fault_fallback",		VMSTAT_SHOW_PROCFS},
> +	{"thp_fault_fallback_charge",	VMSTAT_SHOW_PROCFS},
> +	{"thp_collapse_alloc",		VMSTAT_SHOW_PROCFS},
> +	{"thp_collapse_alloc_failed",	VMSTAT_SHOW_PROCFS},
> +	{"thp_file_alloc",		VMSTAT_SHOW_PROCFS},
> +	{"thp_file_fallback",		VMSTAT_SHOW_PROCFS},
> +	{"thp_file_fallback_charge",	VMSTAT_SHOW_PROCFS},
> +	{"thp_file_mapped",		VMSTAT_SHOW_PROCFS},
> +	{"thp_split_page",		VMSTAT_SHOW_PROCFS},
> +	{"thp_split_page_failed",	VMSTAT_SHOW_PROCFS},
> +	{"thp_deferred_split_page",	VMSTAT_SHOW_PROCFS},
> +	{"thp_split_pmd",		VMSTAT_SHOW_PROCFS},
> +	{"thp_scan_exceed_none_pte",	VMSTAT_SHOW_PROCFS},
> +	{"thp_scan_exceed_swap_pte",	VMSTAT_SHOW_PROCFS},
> +	{"thp_scan_exceed_share_pte",	VMSTAT_SHOW_PROCFS},
>  #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> -	"thp_split_pud",
> +	{"thp_split_pud",		VMSTAT_SHOW_PROCFS},
>  #endif
> -	"thp_zero_page_alloc",
> -	"thp_zero_page_alloc_failed",
> -	"thp_swpout",
> -	"thp_swpout_fallback",
> +	{"thp_zero_page_alloc",		VMSTAT_SHOW_PROCFS},
> +	{"thp_zero_page_alloc_failed",	VMSTAT_SHOW_PROCFS},
> +	{"thp_swpout",			VMSTAT_SHOW_PROCFS},
> +	{"thp_swpout_fallback",		VMSTAT_SHOW_PROCFS},
>  #endif
>  #ifdef CONFIG_MEMORY_BALLOON
> -	"balloon_inflate",
> -	"balloon_deflate",
> +	{"balloon_inflate",		VMSTAT_SHOW_PROCFS},
> +	{"balloon_deflate",		VMSTAT_SHOW_PROCFS},
>  #ifdef CONFIG_BALLOON_COMPACTION
> -	"balloon_migrate",
> +	{"balloon_migrate",		VMSTAT_SHOW_PROCFS},
>  #endif
>  #endif /* CONFIG_MEMORY_BALLOON */
>  #ifdef CONFIG_DEBUG_TLBFLUSH
> -	"nr_tlb_remote_flush",
> -	"nr_tlb_remote_flush_received",
> -	"nr_tlb_local_flush_all",
> -	"nr_tlb_local_flush_one",
> +	{"nr_tlb_remote_flush",		VMSTAT_SHOW_PROCFS},
> +	{"nr_tlb_remote_flush_received", VMSTAT_SHOW_PROCFS},
> +	{"nr_tlb_local_flush_all",	VMSTAT_SHOW_PROCFS},
> +	{"nr_tlb_local_flush_one",	VMSTAT_SHOW_PROCFS},
>  #endif /* CONFIG_DEBUG_TLBFLUSH */
>  
>  #ifdef CONFIG_SWAP
> -	"swap_ra",
> -	"swap_ra_hit",
> +	{"swap_ra",			VMSTAT_SHOW_PROCFS},
> +	{"swap_ra_hit",			VMSTAT_SHOW_PROCFS},
>  #ifdef CONFIG_KSM
> -	"ksm_swpin_copy",
> +	{"ksm_swpin_copy",		VMSTAT_SHOW_PROCFS},
>  #endif
>  #endif
>  #ifdef CONFIG_KSM
> -	"cow_ksm",
> +	{"cow_ksm",			VMSTAT_SHOW_PROCFS},
>  #endif
>  #ifdef CONFIG_ZSWAP
> -	"zswpin",
> -	"zswpout",
> +	{"zswpin",			VMSTAT_SHOW_PROCFS},
> +	{"zswpout",			VMSTAT_SHOW_PROCFS},
>  #endif
>  #ifdef CONFIG_X86
> -	"direct_map_level2_splits",
> -	"direct_map_level3_splits",
> +	{"direct_map_level2_splits",	VMSTAT_SHOW_PROCFS},
> +	{"direct_map_level3_splits",	VMSTAT_SHOW_PROCFS},
>  #endif
>  #ifdef CONFIG_PER_VMA_LOCK_STATS
> -	"vma_lock_success",
> -	"vma_lock_abort",
> -	"vma_lock_retry",
> -	"vma_lock_miss",
> +	{"vma_lock_success",		VMSTAT_SHOW_PROCFS},
> +	{"vma_lock_abort",		VMSTAT_SHOW_PROCFS},
> +	{"vma_lock_retry",		VMSTAT_SHOW_PROCFS},
> +	{"vma_lock_miss",		VMSTAT_SHOW_PROCFS},
>  #endif
>  #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
>  };
> +
>  #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMCG */
>  
>  #if (defined(CONFIG_DEBUG_FS) && defined(CONFIG_COMPACTION)) || \
> @@ -1845,9 +1848,11 @@ static int vmstat_show(struct seq_file *m, void *arg)
>  	unsigned long *l = arg;
>  	unsigned long off = l - (unsigned long *)m->private;
>  
> -	seq_puts(m, vmstat_text[off]);
> -	seq_put_decimal_ull(m, " ", *l);
> -	seq_putc(m, '\n');
> +	if (vmstat_text[off].flags & VMSTAT_SHOW_PROCFS) {
> +		seq_puts(m, vmstat_text[off].name);
> +		seq_put_decimal_ull(m, " ", *l);
> +		seq_putc(m, '\n');
> +	}
>  
>  	if (off == NR_VMSTAT_ITEMS - 1) {
>  		/*
> -- 
> 2.43.0.472.g3155946c3a-goog
> 
> 
> 
