Return-Path: <linux-kernel+bounces-15039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E57822691
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 013DC283EAB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 01:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD944A21;
	Wed,  3 Jan 2024 01:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TtoQzkUk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3A44A0E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 01:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d42ed4cdc7so73755ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 17:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704245537; x=1704850337; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IqPVmDTLcp0lm6JkLsZ7c/JcNa8c/Le1eOgSpFlwcuI=;
        b=TtoQzkUkBPcwPaUNyOMOpyOUaRGE7hHoqBoD53/vUjkbfr9LX8gJBduCrrQ5BedkB2
         P8Irs6VDWcsDlbQNuXSVjwHLDfgp2z+hvLn6N3M8cf3AfXimkgpNhTbMzfWyE1HCArW6
         k4fxyDUHlNmlfHHNSULIkQYWkZY0B2BDnR3JsrEhzyZyxvOKHV6BEmTZLaCssASo9li6
         EJ6qmi4+ReDNTQ3nwdyt6OEz8X01eH9jZYq/Nsp/sb50wKfatVPc2sNGVdV+BBafYa2W
         jy3cKH59fFL1Ln4yzBGeqLDsGEWXWA87R+Z6oGPAV0ETI00GrMnCeGKZ8hCjmwytRxt8
         a1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704245537; x=1704850337;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IqPVmDTLcp0lm6JkLsZ7c/JcNa8c/Le1eOgSpFlwcuI=;
        b=eO9sKQ5ywSiU+rLaG5Gi9fq91Fokl7gyE9Y22G9LQiovlhy7JLaBjT9I1L5/Lr8CgX
         A3XpJwvd+JPybqWly7+TI8cXCo6t6K1TemH+jVLO2qRS2PhBUAyyEnUa8RRjSFlw/TFk
         Zh//onEUwi1dqj5uj9X3cZcGTBBWG0jGI5f5Bl8vx5j1F4cKYcC9Hr+gYj4CQ+8+RRC/
         q8Reanu00R25qKIAhvJ1ywme7ls2RMilxO4q8/VWpXUIox659amfADkTvKvUidCFpBAH
         wJrmWelIO2xlhihghVAGbPRk3VxYb/DCWzIi3VWE6eQSojiWJUJ+kElgdYuFJ8ctmtdk
         9Q3A==
X-Gm-Message-State: AOJu0Yy6C4o00JkMEwQarMt1mF3Uq6AAGE6BLNZgL+I8GqIv+QAtG47t
	uk/5kF8DvbtF3kAoq+j3ine7K94Oawbu
X-Google-Smtp-Source: AGHT+IG7XtbtkOp8HKw3smQ60PS3HuaDsC6br2LR43feUh9XWs4NZY7BQuSI3RZwcDhAAmIxspxKVQ==
X-Received: by 2002:a17:902:d508:b0:1d3:9d94:3309 with SMTP id b8-20020a170902d50800b001d39d943309mr76340plg.22.1704245536522;
        Tue, 02 Jan 2024 17:32:16 -0800 (PST)
Received: from [2620:0:1008:15:c73b:7876:89ec:9102] ([2620:0:1008:15:c73b:7876:89ec:9102])
        by smtp.gmail.com with ESMTPSA id e15-20020aa7824f000000b006d9879ba6besm20155240pfn.170.2024.01.02.17.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 17:32:15 -0800 (PST)
Date: Tue, 2 Jan 2024 17:32:15 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Gang Li <gang.li@linux.dev>
cc: David Hildenbrand <david@redhat.com>, 
    Mike Kravetz <mike.kravetz@oracle.com>, 
    Muchun Song <muchun.song@linux.dev>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Tim Chen <tim.c.chen@linux.intel.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, ligang.bdlg@bytedance.com
Subject: Re: [PATCH v3 4/7] hugetlb: pass *next_nid_to_alloc directly to
 for_each_node_mask_to_alloc
In-Reply-To: <20240102131249.76622-5-gang.li@linux.dev>
Message-ID: <19b08bb8-1fbd-557b-2684-5c29c5c783e6@google.com>
References: <20240102131249.76622-1-gang.li@linux.dev> <20240102131249.76622-5-gang.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 2 Jan 2024, Gang Li wrote:

> The parallelization of hugetlb allocation leads to errors when sharing
> h->next_nid_to_alloc across different threads. To address this, it's
> necessary to assign a separate next_nid_to_alloc for each thread.
> 
> Consequently, the hstate_next_node_to_alloc and for_each_node_mask_to_alloc
> have been modified to directly accept a *next_nid_to_alloc parameter,
> ensuring thread-specific allocation and avoiding concurrent access issues.
> 
> Signed-off-by: Gang Li <gang.li@linux.dev>
> ---
> This patch seems not elegant, but I can't come up with anything better.
> Any suggestions will be highly appreciated!

Same error as v2:

mm/hugetlb.c:3315:53: warning: variable 'node' is used uninitialized whenever '&&' condition is false [-Wsometimes-uninitialized]
        for_each_node_mask_to_alloc(&h->next_nid_to_alloc, nr_nodes, node, &node_states[N_MEMORY]) {
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mm/hugetlb.c:1501:3: note: expanded from macro 'for_each_node_mask_to_alloc'
                nr_nodes > 0 &&                                         \
                ^~~~~~~~~~~~
mm/hugetlb.c:3342:38: note: uninitialized use occurs here
        list_add(&m->list, &huge_boot_pages[node]);
                                            ^~~~
mm/hugetlb.c:3315:53: note: remove the '&&' if its condition is always true
        for_each_node_mask_to_alloc(&h->next_nid_to_alloc, nr_nodes, node, &node_states[N_MEMORY]) {
                                                           ^
mm/hugetlb.c:3310:7: warning: variable 'node' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                if (!m)
                    ^~
mm/hugetlb.c:3342:38: note: uninitialized use occurs here
        list_add(&m->list, &huge_boot_pages[node]);
                                            ^~~~
mm/hugetlb.c:3310:3: note: remove the 'if' if its condition is always true
                if (!m)
                ^~~~~~~
mm/hugetlb.c:3304:20: note: initialize the variable 'node' to silence this warning
        int nr_nodes, node;
                          ^
                           = 0
2 warnings generated.

> ---
>  mm/hugetlb.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 92448e747991d..a71bc1622b53b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1464,15 +1464,15 @@ static int get_valid_node_allowed(int nid, nodemask_t *nodes_allowed)
>   * next node from which to allocate, handling wrap at end of node
>   * mask.
>   */
> -static int hstate_next_node_to_alloc(struct hstate *h,
> +static int hstate_next_node_to_alloc(int *next_nid_to_alloc,
>  					nodemask_t *nodes_allowed)
>  {
>  	int nid;
>  
>  	VM_BUG_ON(!nodes_allowed);
>  
> -	nid = get_valid_node_allowed(h->next_nid_to_alloc, nodes_allowed);
> -	h->next_nid_to_alloc = next_node_allowed(nid, nodes_allowed);
> +	nid = get_valid_node_allowed(*next_nid_to_alloc, nodes_allowed);
> +	*next_nid_to_alloc = next_node_allowed(nid, nodes_allowed);
>  
>  	return nid;
>  }
> @@ -1495,10 +1495,10 @@ static int hstate_next_node_to_free(struct hstate *h, nodemask_t *nodes_allowed)
>  	return nid;
>  }
>  
> -#define for_each_node_mask_to_alloc(hs, nr_nodes, node, mask)		\
> +#define for_each_node_mask_to_alloc(next_nid_to_alloc, nr_nodes, node, mask)		\
>  	for (nr_nodes = nodes_weight(*mask);				\
>  		nr_nodes > 0 &&						\
> -		((node = hstate_next_node_to_alloc(hs, mask)) || 1);	\
> +		((node = hstate_next_node_to_alloc(next_nid_to_alloc, mask)) || 1);	\
>  		nr_nodes--)
>  
>  #define for_each_node_mask_to_free(hs, nr_nodes, node, mask)		\
> @@ -2350,12 +2350,13 @@ static void prep_and_add_allocated_folios(struct hstate *h,
>   */
>  static struct folio *alloc_pool_huge_folio(struct hstate *h,
>  					nodemask_t *nodes_allowed,
> -					nodemask_t *node_alloc_noretry)
> +					nodemask_t *node_alloc_noretry,
> +					int *next_nid_to_alloc)
>  {
>  	gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
>  	int nr_nodes, node;
>  
> -	for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
> +	for_each_node_mask_to_alloc(next_nid_to_alloc, nr_nodes, node, nodes_allowed) {
>  		struct folio *folio;
>  
>  		folio = only_alloc_fresh_hugetlb_folio(h, gfp_mask, node,
> @@ -3310,7 +3311,7 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
>  		goto found;
>  	}
>  	/* allocate from next node when distributing huge pages */
> -	for_each_node_mask_to_alloc(h, nr_nodes, node, &node_states[N_MEMORY]) {
> +	for_each_node_mask_to_alloc(&h->next_nid_to_alloc, nr_nodes, node, &node_states[N_MEMORY]) {
>  		m = memblock_alloc_try_nid_raw(
>  				huge_page_size(h), huge_page_size(h),
>  				0, MEMBLOCK_ALLOC_ACCESSIBLE, node);
> @@ -3684,7 +3685,7 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
>  	VM_BUG_ON(delta != -1 && delta != 1);
>  
>  	if (delta < 0) {
> -		for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
> +		for_each_node_mask_to_alloc(&h->next_nid_to_alloc, nr_nodes, node, nodes_allowed) {
>  			if (h->surplus_huge_pages_node[node])
>  				goto found;
>  		}
> @@ -3799,7 +3800,8 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  		cond_resched();
>  
>  		folio = alloc_pool_huge_folio(h, nodes_allowed,
> -						node_alloc_noretry);
> +						node_alloc_noretry,
> +						&h->next_nid_to_alloc);
>  		if (!folio) {
>  			prep_and_add_allocated_folios(h, &page_list);
>  			spin_lock_irq(&hugetlb_lock);
> -- 
> 2.20.1
> 
> 

