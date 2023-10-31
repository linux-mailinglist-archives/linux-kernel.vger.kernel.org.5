Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120B57DD5F9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 19:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjJaSXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 14:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjJaSXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 14:23:32 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB010DF;
        Tue, 31 Oct 2023 11:23:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBA52b7PftBFhd+nGC8yspb74YtBoRgSzyCs1vFQvs/1JmcREkVEDJ4CQlves4Qt/0c1n1FzSS66zti39B02P6/6nto73o9Idn5UJ+3I2Sd1G8Wgxm5S4r6xeT9PTkBJEXThpm5pfW6CNvGXq7AMqX58MpjdFuFT8Ace8WLeNe3KsvAqemkBKn+DgzdvQ6l3pCjtJNzKdDP3okq9Z3BY4wZXBSyM5VaPeyb6rMsh33jE3RQs87ic1Apa3ZWJDckiKa6VGfx/1hAE02TOGZsRduMAwKBKwT0Ox5kRh+JvzyCqRBLxpxdWHjeLm+TDRFCqzx4WgrEfwWrjL7cj2ouNUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuQcHvV45ELogRD91hv58OOfdpla0se7TJgA+vNUQeU=;
 b=VS2fnEyzPbdWuMLBWX7E7Cr/SJAllTr2rP+nP33TEaEYrO15AozeACA1e8GVSZgF5RFbM3cinNLP8h55D5/rVRTfzkUa9/npLD5zUCPyyeFngfYD5t7opZtOWS5918igdEh2Kf6VUtki80vwVu11kMm+Yu7tQgxDK5HiASyYrh8EQ+/43RwtiaxkxG+jTaz648u8is0ustIMdZutKmwt7KLVwWdTX4aZHrXbaqA9vWtvJeZlU+dgpaisVcxACAN2PFBzeXCGLOCOUX8E5Pg3Hc0qqi959HDCIcI5zfp7FD2w+lqYbVAyHLT+OgAq7jUitx3HBSWKN03eSZ9ept3XAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.201.242.130) smtp.rcpttodomain=gmail.com smtp.mailfrom=micron.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=micron.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuQcHvV45ELogRD91hv58OOfdpla0se7TJgA+vNUQeU=;
 b=fS0S7c8uxhf+YzgiGUoR+aOPhRD24IfvmbzoQbtYWYfMAGLs0tALbtmFGtBWyylvNJe56sjNCdRkKkdehBsJRN2Mrsc9UhFzhFiaSfeUyy2m2dZDPYx7NXqNm5s+bKI083ZJs/q/ha247h+CMurgQOu/4j0obrqX8jdVXR+XLXrIEC0faR1cCvSzuVSXBWQjnMCjOpuOAaG25UbCej3/00aaJwRqPqPyLYfjsIcRq2kncV8YB/YEDgEu78g8ehp9/EJxnF351Es6cP7GgowUkRcT1t8gCcjJxc2PQas3SosVoImQSsp9kGVa7fMwlXi7rJSvSh4n5FjmjPVcD7KwAg==
Received: from MW2PR16CA0024.namprd16.prod.outlook.com (2603:10b6:907::37) by
 PH0PR08MB8228.namprd08.prod.outlook.com (2603:10b6:510:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 18:23:23 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:907:0:cafe::78) by MW2PR16CA0024.outlook.office365.com
 (2603:10b6:907::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Tue, 31 Oct 2023 18:23:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 137.201.242.130)
 smtp.mailfrom=micron.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=micron.com;
Received-SPF: Pass (protection.outlook.com: domain of micron.com designates
 137.201.242.130 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.201.242.130; helo=mail.micron.com; pr=C
Received: from mail.micron.com (137.201.242.130) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.19 via Frontend Transport; Tue, 31 Oct 2023 18:23:22 +0000
Received: from [10.3.79.254] (137.201.84.68) by BOW36EX19A.micron.com
 (137.201.85.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 31 Oct
 2023 12:23:15 -0600
Message-ID: <d1c30b1f-1628-4092-acee-2b0980a3d888@micron.com>
Date:   Tue, 31 Oct 2023 23:53:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] [RFC PATCH v3 4/4] mm/mempolicy: modify interleave
 mempolicy to use node weights
Content-Language: en-US
To:     Gregory Price <gourry.memverge@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-cxl@vger.kernel.org>, <linux-mm@kvack.org>,
        <ying.huang@intel.com>, <akpm@linux-foundation.org>,
        <aneesh.kumar@linux.ibm.com>, <weixugc@google.com>,
        <apopple@nvidia.com>, <hannes@cmpxchg.org>, <tim.c.chen@intel.com>,
        <dave.hansen@intel.com>, <mhocko@kernel.org>,
        <shy828301@gmail.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>, Gregory Price <gregory.price@memverge.com>
References: <20231031003810.4532-1-gregory.price@memverge.com>
 <20231031003810.4532-5-gregory.price@memverge.com>
From:   Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
In-Reply-To: <20231031003810.4532-5-gregory.price@memverge.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BOW17EX19B.micron.com (137.201.21.219) To
 BOW36EX19A.micron.com (137.201.85.33)
X-MT-Whitelisted: matched
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|PH0PR08MB8228:EE_
X-MS-Office365-Filtering-Correlation-Id: b3fb78cf-2e2c-4de1-55f6-08dbda3e775e
X-EXT-ByPass: 1
X-MT-RULE-Whitelisted: Triggered
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dN7tSLMFCoiUfqoK0U2Y1HNSOfMGlszfEDg/lZ93/7J0BVCm4XOdeTqaARtwoITY4kE7O0OO6nFo5LzxrXUeMt22yQUm7kLs4ZtdQ5TA24pPxqjMrboQWviB9C9kY3hpbQKpBdxa0wdudUWrwLkrTw10XHUEfHEVneine4sa0dpUOBDSwXY4d7aSjJVzJTy4nA8Cm8WCkEfmNWJGRtd/tbZDc8/1pAN8kN0p9Zo2DD4coa5tf6JS/eYBNEns6qVNWK35MhSQU/d3eo9neu0Jw+TUaDvUt7vaPX2t6CiL06uiE8vvwuvhgY8syiD+YmF8YXE+/lzMbyZCbvFV+u+8hINQdycMgjd4Jd2EI3IF2X3lItv3FWRdLKaIkzB+aFLTYC1UIfBHriDtVvgeBXqER+l2dRJQ7UsQQ/kqbvq93rwkBbxDDW1QN3dcgWDsWiJIFAaJiK/JTGZ4TMV+TvSKUUZfVGz677bXvA/ByV1Q5MyKOlIlDAbYA0IxV9ajqVfAm5Nj1J+NeFQYxWg/KTxGE5KP1/w2owM+8BDzaA1n9mZ/eJz+cqv3/MGCPopI7pYU0QYkcWAh0FOoSjOmhPe3+XtnyrJcusZwkYcxz+56ayFhSrp6+ImDktAOiOPKCeJ+4eeaDypNk9J70omAumMRxN/ertHB9Vl8Gy3VfJxIISQEn0B3fBW2VIGCjkV/ePftrlnqgyl6RZxyuDoIoVS+Y+x4w5e/9iBIrZNuc2k29ewXfrsJNjMUpH3WX+A2zCVKtdp/6kHKShTPoAa3f7ZJklWW9abfxpE7ObS4KBMLEZ8=
X-Forefront-Antispam-Report: CIP:137.201.242.130;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.micron.com;PTR:masquerade.micron.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(336012)(83380400001)(956004)(26005)(2616005)(47076005)(356005)(426003)(36860700001)(7636003)(70586007)(70206006)(7416002)(16576012)(54906003)(316002)(5660300002)(110136005)(4326008)(8676002)(8936002)(53546011)(2906002)(478600001)(41300700001)(36756003)(86362001)(31696002)(82740400003)(31686004)(40480700001)(16393002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 18:23:22.7618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fb78cf-2e2c-4de1-55f6-08dbda3e775e
X-MS-Exchange-CrossTenant-Id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f38a5ecd-2813-4862-b11b-ac1d563c806f;Ip=[137.201.242.130];Helo=[mail.micron.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR08MB8228
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/31/2023 6:08 AM, Gregory Price wrote:
>
>
> The node subsystem implements interleave weighting for the purpose
> of bandwidth optimization.  Each node may have different weights in
> relation to each compute node ("access node").
>
> The mempolicy MPOL_INTERLEAVE utilizes the node weights to implement
> weighted interleave.  By default, since all nodes default to a weight
> of 1, the original interleave behavior is retained.
>
> Examples
>
> Weight settings:
> echo 4 > node0/access0/il_weight
> echo 1 > node0/access1/il_weight
>
> echo 3 > node1/access0/il_weight
> echo 2 > node1/access1/il_weight
>
> Results:
>
> Task A:
>     cpunode:  0
>     nodemask: [0,1]
>     weights:  [4,3]
>     allocation result: [0,0,0,0,1,1,1 repeat]
>
> Task B:
>     cpunode:  1
>     nodemask: [0,1]
>     weights:  [1,2]
>     allocation result: [0,1,1 repeat]
>     Weights are relative to access node
>
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
Thank you Gregory for the collaboration.
Signed-off-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
> ---
>   include/linux/mempolicy.h |   4 ++
>   mm/mempolicy.c            | 138 +++++++++++++++++++++++++++++---------
>   2 files changed, 112 insertions(+), 30 deletions(-)
>
> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> index d232de7cdc56..240468b669fd 100644
> --- a/include/linux/mempolicy.h
> +++ b/include/linux/mempolicy.h
> @@ -48,6 +48,10 @@ struct mempolicy {
>          nodemask_t nodes;       /* interleave/bind/perfer */
>          int home_node;          /* Home node to use for MPOL_BIND and MPOL_PREFERRED_MANY */
>
> +       /* weighted interleave settings */
> +       unsigned char cur_weight;
> +       unsigned char il_weights[MAX_NUMNODES];
> +
>          union {
>                  nodemask_t cpuset_mems_allowed; /* relative to these nodes */
>                  nodemask_t user_nodemask;       /* nodemask passed by user */
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 29ebf1e7898c..d62e942a13bd 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -102,6 +102,7 @@
>   #include <linux/mmu_notifier.h>
>   #include <linux/printk.h>
>   #include <linux/swapops.h>
> +#include <linux/memory-tiers.h>
>
>   #include <asm/tlbflush.h>
>   #include <asm/tlb.h>
> @@ -300,6 +301,7 @@ static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
>          policy->mode = mode;
>          policy->flags = flags;
>          policy->home_node = NUMA_NO_NODE;
> +       policy->cur_weight = 0;
>
>          return policy;
>   }
> @@ -334,6 +336,7 @@ static void mpol_rebind_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
>                  tmp = *nodes;
>
>          pol->nodes = tmp;
> +       pol->cur_weight = 0;
>   }
>
>   static void mpol_rebind_preferred(struct mempolicy *pol,
> @@ -881,8 +884,11 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
>
>          old = current->mempolicy;
>          current->mempolicy = new;
> -       if (new && new->mode == MPOL_INTERLEAVE)
> +       if (new && new->mode == MPOL_INTERLEAVE) {
>                  current->il_prev = MAX_NUMNODES-1;
> +               new->cur_weight = 0;
> +       }
> +
>          task_unlock(current);
>          mpol_put(old);
>          ret = 0;
> @@ -1903,12 +1909,21 @@ static int policy_node(gfp_t gfp, struct mempolicy *policy, int nd)
>   /* Do dynamic interleaving for a process */
>   static unsigned interleave_nodes(struct mempolicy *policy)
>   {
> -       unsigned next;
> +       unsigned int next;
> +       unsigned char next_weight;
>          struct task_struct *me = current;
>
>          next = next_node_in(me->il_prev, policy->nodes);
> -       if (next < MAX_NUMNODES)
> +       if (!policy->cur_weight) {
> +               /* If the node is set, at least 1 allocation is required */
> +               next_weight = node_get_il_weight(next, numa_node_id());
> +               policy->cur_weight = next_weight ? next_weight : 1;
> +       }
> +
> +       policy->cur_weight--;
> +       if (next < MAX_NUMNODES && !policy->cur_weight)
>                  me->il_prev = next;
> +
>          return next;
>   }
>
> @@ -1967,25 +1982,37 @@ unsigned int mempolicy_slab_node(void)
>   static unsigned offset_il_node(struct mempolicy *pol, unsigned long n)
>   {
>          nodemask_t nodemask = pol->nodes;
> -       unsigned int target, nnodes;
> -       int i;
> +       unsigned int target, nnodes, il_weight;
> +       unsigned char weight;
>          int nid;
> +       int cur_node = numa_node_id();
> +
>          /*
>           * The barrier will stabilize the nodemask in a register or on
>           * the stack so that it will stop changing under the code.
>           *
>           * Between first_node() and next_node(), pol->nodes could be changed
>           * by other threads. So we put pol->nodes in a local stack.
> +        *
> +        * Additionally, place the cur_node on the stack in case of a migration
>           */
>          barrier();
>
>          nnodes = nodes_weight(nodemask);
>          if (!nnodes)
> -               return numa_node_id();
> -       target = (unsigned int)n % nnodes;
> +               return cur_node;
> +
> +       il_weight = nodes_get_il_weights(cur_node, &nodemask, pol->il_weights);
> +       target = (unsigned int)n % il_weight;
>          nid = first_node(nodemask);
> -       for (i = 0; i < target; i++)
> -               nid = next_node(nid, nodemask);
> +       while (target) {
> +               weight = pol->il_weights[nid];
> +               if (target < weight)
> +                       break;
> +               target -= weight;
> +               nid = next_node_in(nid, nodemask);
> +       }
> +
>          return nid;
>   }
>
> @@ -2319,32 +2346,83 @@ static unsigned long alloc_pages_bulk_array_interleave(gfp_t gfp,
>                  struct mempolicy *pol, unsigned long nr_pages,
>                  struct page **page_array)
>   {
> -       int nodes;
> -       unsigned long nr_pages_per_node;
> -       int delta;
> -       int i;
> -       unsigned long nr_allocated;
> +       struct task_struct *me = current;
>          unsigned long total_allocated = 0;
> +       unsigned long nr_allocated;
> +       unsigned long rounds;
> +       unsigned long node_pages, delta;
> +       unsigned char weight;
> +       unsigned long il_weight;
> +       unsigned long req_pages = nr_pages;
> +       int nnodes, node, prev_node;
> +       int cur_node = numa_node_id();
> +       int i;
>
> -       nodes = nodes_weight(pol->nodes);
> -       nr_pages_per_node = nr_pages / nodes;
> -       delta = nr_pages - nodes * nr_pages_per_node;
> -
> -       for (i = 0; i < nodes; i++) {
> -               if (delta) {
> -                       nr_allocated = __alloc_pages_bulk(gfp,
> -                                       interleave_nodes(pol), NULL,
> -                                       nr_pages_per_node + 1, NULL,
> -                                       page_array);
> -                       delta--;
> -               } else {
> -                       nr_allocated = __alloc_pages_bulk(gfp,
> -                                       interleave_nodes(pol), NULL,
> -                                       nr_pages_per_node, NULL, page_array);
> +       prev_node = me->il_prev;
> +       nnodes = nodes_weight(pol->nodes);
> +       /* Continue allocating from most recent node */
> +       if (pol->cur_weight) {
> +               node = next_node_in(prev_node, pol->nodes);
> +               node_pages = pol->cur_weight;
> +               if (node_pages > nr_pages)
> +                       node_pages = nr_pages;
> +               nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
> +                                                 NULL, page_array);
> +               page_array += nr_allocated;
> +               total_allocated += nr_allocated;
> +               /* if that's all the pages, no need to interleave */
> +               if (req_pages <= pol->cur_weight) {
> +                       pol->cur_weight -= req_pages;
> +                       return total_allocated;
>                  }
> -
> +               /* Otherwise we adjust req_pages down, and continue from there */
> +               req_pages -= pol->cur_weight;
> +               pol->cur_weight = 0;
> +               prev_node = node;
> +       }
> +
> +       il_weight = nodes_get_il_weights(cur_node, &pol->nodes,
> +                                        pol->il_weights);
> +       rounds = req_pages / il_weight;
> +       delta = req_pages % il_weight;
> +       for (i = 0; i < nnodes; i++) {
> +               node = next_node_in(prev_node, pol->nodes);
> +               weight = pol->il_weights[node];
> +               node_pages = weight * rounds;
> +               if (delta > weight) {
> +                       node_pages += weight;
> +                       delta -= weight;
> +               } else if (delta) {
> +                       node_pages += delta;
> +                       delta = 0;
> +               }
> +               /* The number of requested pages may not hit every node */
> +               if (!node_pages)
> +                       break;
> +               /* If an over-allocation would occur, floor it */
> +               if (node_pages + total_allocated > nr_pages) {
> +                       node_pages = nr_pages - total_allocated;
> +                       delta = 0;
> +               }
> +               nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
> +                                                 NULL, page_array);
>                  page_array += nr_allocated;
>                  total_allocated += nr_allocated;
> +               prev_node = node;
> +       }
> +
> +       /*
> +        * Finally, we need to update me->il_prev and pol->cur_weight
> +        * If the last node allocated on has un-used weight, apply
> +        * the remainder as the cur_weight, otherwise proceed to next node
> +        */
> +       if (node_pages) {
> +               me->il_prev = prev_node;
> +               node_pages %= weight;
> +               pol->cur_weight = weight - node_pages;
> +       } else {
> +               me->il_prev = node;
> +               pol->cur_weight = 0;
>          }
>
>          return total_allocated;
> --
> 2.39.1
>
>
