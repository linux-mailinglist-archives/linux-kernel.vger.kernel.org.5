Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D619783C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbjHVJCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbjHVJCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:02:43 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A62CE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:02:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bj2qB5jaft/+jv92SwD7cPV5FRiGKHcWABbHJ4+i4eN1gMNqwBf+0xwE/ejxUBYYXEu1RUaNYISgbSXQAOQHPfrvSCwoCNCxdqXEl1wt0FkwpnBMJ4rYbwC+ceDPlfBF94/jlgFVeTvk7yfCoAjdJMObu4Wi4xxtiDzuTRNMpB1tML8Phvb7OnkumBDITkr0I2eXeEwLu2nXgDDPrM4qnujzzRBWhl6sk9SGoEo+gn3APV8Ohkc7Ko93Zb5858k/8GyG/UBzHcK6xtFCqNceINxiSvaAZO+RWGeVzrQjS3raRGQrgA//9lxTIDV8MI1hUjXGqUuR6QYzi4Q6TLWkfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzVOzcEBTdxrPj0u0nuylBt3NI4+/MEhmQG6j8STia0=;
 b=D6D7OZPD0TgszUfa/Kmsp8DLxEzN5Spgy07U5X8eJ+YqbVyPQ1thCZE3Ia+JfYjOotlGpHXLSyJROG03oJlBw8W8un+/0V9NwArGiYbe5DyXCGnCrfnX/dRV8Ig4tRa6BtEqEPTww2aD5e9uUcMilFR6WGa0Z5UckPHnTj/fWSbbu4bKx0P5mwDGlc8KzEXGVjfhNEvF131Hw4LEY1qxacTNXEnFJVaTYwUl+c7tzWDDCyKrlsjk6BnC83Wt438GSTGhQtz2p/BEYqWgfU8iDcD4ZxVpHhVgSrd5NNY7D1BtyJfV1RYkFOtwghPUAA7SI6reCTtFd1PmLsLeEgZYeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzVOzcEBTdxrPj0u0nuylBt3NI4+/MEhmQG6j8STia0=;
 b=B5aTci0KPt5u25jLqIV4DfQbZbd/5BSvVRjSZ/xaJAQCn9axXf79MEAVvRciVzztaRaTOm631aUoCYT+Wwg3QKtPwPWD1rEGUldsnzx+dkwdTEo9Fgo8b+wrMuta7/BBKyBuuPE1vbwn8gF0NxG/7sydWxBhL9qhj3CE8wpPojg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 by CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 09:02:38 +0000
Received: from IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::17b8:2ba3:147e:b8cd]) by IA1PR12MB6434.namprd12.prod.outlook.com
 ([fe80::17b8:2ba3:147e:b8cd%6]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 09:02:37 +0000
Message-ID: <95d72acc-c4fa-cd71-a27f-113f0c2a8649@amd.com>
Date:   Tue, 22 Aug 2023 14:32:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/4] mm: migrate: move the numamigrate_isolate_page()
 into do_numa_page()
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, shy828301@gmail.com, david@redhat.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1692665449.git.baolin.wang@linux.alibaba.com>
 <9ff2a9e3e644103a08b9b84b76b39bbd4c60020b.1692665449.git.baolin.wang@linux.alibaba.com>
From:   Bharata B Rao <bharata@amd.com>
In-Reply-To: <9ff2a9e3e644103a08b9b84b76b39bbd4c60020b.1692665449.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0193.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::22) To IA1PR12MB6434.namprd12.prod.outlook.com
 (2603:10b6:208:3ae::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6434:EE_|CH3PR12MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: 66df8e74-962c-4efc-a5f8-08dba2ee87eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: syzOdNh6uIZdyxjypgN/GlVG5j5c7f3D06O9OrgtQyia6JedMQeaPUr3MHjIPGdD8u7NmFGaVa/3KE9oxjxG/3S2t3rUqDkIc3QFf/m3DQ3b5lEbIRMIc8SUOkBypgI9qsL/sFmWXWvtiljN47Iirl9nwIpFFL92psi/qYfkTvMSkZsO8m4Z36Iq4AxD5W6CYFmqsA0ISxxj/QibxZxLIJSb3eKox7kVQRKcPOCaVO4Fc1JMYE7oe1Ok/QvFaABFN7KVkSXhBlz2FhBscHKYR6VR3EKCtH/IRrbWgoR/kf+aM9vcENsmUoTBpWgPoWGm7Hx8uNnZWrRx25miY87DmeZPcRs0JOoRh4OygWF/vZsfdPsWyRef4v+3nepVXVTV/Y8xiOrtF/8Ri0AgEMT0rEDhzID4cb4UXytfMEaSDFw5uEPA9m/uiLQck/BgWkJDo4CH5xfxveE8g8mohL02o/bPtseng3PAJNYsAOmF2W8tLXYtZsIdV6NgnjPenmI+chkSBnkS/NSufyTEeCbPONILq3qX6bvc8fsS93dTH64rglI6ZBsMGn/8p72YtwmylDgw6TNg7hfWoNvSPUAhpDiDREsCATf98+lnBTOWm4vF/PI9TAAE0ln2D4jg8ghJIVmD9D/nA/5+baOpJo6Nww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6434.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(376002)(366004)(1800799009)(186009)(451199024)(66476007)(66556008)(316002)(66946007)(6512007)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(478600001)(6666004)(38100700002)(53546011)(6506007)(6486002)(83380400001)(2906002)(86362001)(31686004)(31696002)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2lMRkNjWGlpWERHcEo0K1BGV2tzSjFIUFlReGNNcERaUUlOM3h2ZThGOXFj?=
 =?utf-8?B?TzZkSzZmUlpnNWVUdW1ocEZNZzhvcjJtU1JVcTNRYkh0TjFtdWFpblh4R2RY?=
 =?utf-8?B?ZUpKSVpYdXJ5ZXdmN3lUSjkzYXM3SGxYWVdpaUt4OHNTcFZQYkVoRklvMUZv?=
 =?utf-8?B?ZzRHZWpMamhiTW9OL3VIVVlTdXBjamZ5N3FndC9zdHFOeXJid0t3ci9xN04v?=
 =?utf-8?B?VEdGOEo5UUV1VnprSmR4VjZWUGlMTllEaUpOVjNRUHNjazZaNG5pNjBaKzll?=
 =?utf-8?B?d1lOSjlrRDNTdzB1aWdrMVVZSlFwOEtoaFlTN3RuZmZPY0dyZlhHQXlGeTcw?=
 =?utf-8?B?YW1Ib250YktjNUxXRnc3cmNLUGVOOW00S1RudVhVbzhpUG01dmh2WUY3WWdE?=
 =?utf-8?B?MjN5d3pYZWZCRW95ald4bUNaVmdZUDFnclN2bHIrakJxcnpLTW1wN3Z2M2Vt?=
 =?utf-8?B?Z0Z1UWNpdUJvdUFWRkxKL0pqcCtsOUhLQjd4RmI5WkMyT2h4WUlQSnloNkpa?=
 =?utf-8?B?K0xqVWtiSytxKzRiN1plam16M3B4L2s2bHZvNTNNKzdiK3ZiNkQxbzF5bkRz?=
 =?utf-8?B?RDN6NFlvZDRIelJsU3FyaFpMdXBMT01IQ3RRWm1ORGoyVUZFajNmOHFwVUFp?=
 =?utf-8?B?OHJkU1FiQ0RpSkVYcHRaUy9SNzF0TTFOQXJwbDhkcTNvMGJhZ0dncFhUSE9u?=
 =?utf-8?B?eWxuS2prZTRuWU5yV21rZE5sOGJMWUhteUFlQUpJUlF0c1NWZDNuaXVpSncw?=
 =?utf-8?B?RUNQYWthZ1dYdzBHQkJPNUcyZ2Q0alR3aDVxS0JmTEdyMlVoU1B4aGZjcGU1?=
 =?utf-8?B?RTgvdDhtM0FLSmpicnVMT3ZIamlhZnFmYXdaVGtZOTQzblg3QngvdkFsVzFw?=
 =?utf-8?B?M2p5dDhSWjJyWWxjZDczL0p4UE9ORCt6bFdaaVR5Tys4cGZHMkh2MUs5blZ3?=
 =?utf-8?B?ZVg2dS9vVm0xUWtBWHBxYytMOVY0eCswcW1zUktRaDJ1dEZZQlpIaTN6NytX?=
 =?utf-8?B?T3VGS0syeHNQOFVZRTFVMmRObmxKVEdRdzZkWWhGdGxLTjlqNHVDb1Arcml2?=
 =?utf-8?B?M1ZDWFEzaEsrSUE4RjRUU0xLVW9WZzdqQUZWZDY0amVTZTJpamh2b1lLb2Vw?=
 =?utf-8?B?aGhNdHlDc3VPUFBRUTRsWm5BMEl2cEZxNDIwaFRaTFcwNy9zdlNoZ2szVWpP?=
 =?utf-8?B?WnVZK294TW5TZ0ZNUDh4ZHUwYXdLN3VSVjJPOGk5dXQvSWFud0RqN21JTmFE?=
 =?utf-8?B?UXhFREJyalRCeE40QytjalgzKzQ1M28wNlRZZG5OWkxhWDBwajd4QjM4SFcx?=
 =?utf-8?B?Tk4xcTNMcnlFQ1NsdGgrRGhBWWVDQUdDeUZ2K2QvRWJMVlRrcER2QVc5ekhL?=
 =?utf-8?B?N3FYN3JqV0NQcW9CYjl0VzQ5bUUxMlhnbFZHNTk5UHNLMDd0QTlvNVJVUUlU?=
 =?utf-8?B?REtlS0Yya2d5V3JiQjhyODVlbnVRVk5vcitUTU9xZWZOOGZRV29YUlBIblIr?=
 =?utf-8?B?ekxEMkxDOUlSbzJ6UDN4aExlaVZhVTljdW9ZSVVKNEh1WlZtTVRQVm5UajY1?=
 =?utf-8?B?Y0ZDc3lWODgyQ2duL0owTGF6cWxGZXo0VW5LeWh6ZjBZZEZWdGkxak5Uc0RR?=
 =?utf-8?B?REw3VjUyYU5HRk45V2NRT0FTQStHaFFIc3RHZ0ltcU9YSDZvSm5JWmRKOVJC?=
 =?utf-8?B?VTRJSlNrYzA2SEFxdTJxYVlheWlySms3ZkVjRUwvNW5pRmtrS1R4YzZ6SW5X?=
 =?utf-8?B?aXJjMXRQejVQaGVNcjFEQm4xZ2xGNGwxczgzYXB2bXNodHJyUlVBaW5JbURZ?=
 =?utf-8?B?T3lRSUZ5WU0zS3dHejFKSE9BcTIveC93V0VSeDV4dUZwVjhIY1F6ZzBLcEdo?=
 =?utf-8?B?Y1Aya0NJK3B1UnYrMVFCV0hmMnpHYTBERkhSa0cyNkc0eWRCZUV1ZHFSRmN4?=
 =?utf-8?B?WHJoTE9UOHpPMEQ3UHRvK2VVekFFdFpUWEliT3JvNHd2YUt2Y3B2aHNMOXN0?=
 =?utf-8?B?eWFFakk1eW84bkUyL3RsRkh0TFNqRzFwYzZQSEFkNHpWYVV5cnowRC9ZYzBE?=
 =?utf-8?B?ZVdnOW9ZMWVjZmp5UElXNFgvUmwwN053K1ZjejlML01SSklicHNEVnJXZSto?=
 =?utf-8?Q?ASTsQQCsd8PvyL8/QX4Li0NAg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66df8e74-962c-4efc-a5f8-08dba2ee87eb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6434.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 09:02:37.8277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMhGjtqMTcg2/HlhaXn2Gm9OVoqIlGbBK3UD8rCFd0zs0uJe2H2V5fJmoqz67qWlwd1ow4p6hdbyWPguxsCkxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-Aug-23 6:23 AM, Baolin Wang wrote:
> Move the numamigrate_isolate_page() into do_numa_page() to simplify the
> migrate_misplaced_page(), which now only focuses on page migration, and
> it also serves as a preparation for supporting batch migration for
> migrate_misplaced_page().
> 
> While we are at it, change the numamigrate_isolate_page() to boolean
> type to make the return value more clear.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  include/linux/migrate.h |  6 ++++++
>  mm/huge_memory.c        |  7 +++++++
>  mm/memory.c             |  7 +++++++
>  mm/migrate.c            | 22 +++++++---------------
>  4 files changed, 27 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 711dd9412561..ddcd62ec2c12 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -144,12 +144,18 @@ const struct movable_operations *page_movable_ops(struct page *page)
>  #ifdef CONFIG_NUMA_BALANCING
>  int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>  			   int node);
> +bool numamigrate_isolate_page(pg_data_t *pgdat, struct page *page);
>  #else
>  static inline int migrate_misplaced_page(struct page *page,
>  					 struct vm_area_struct *vma, int node)
>  {
>  	return -EAGAIN; /* can't migrate now */
>  }
> +
> +static inline bool numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_NUMA_BALANCING */
>  
>  #ifdef CONFIG_MIGRATION
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 4a9b34a89854..07149ead11e4 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1496,6 +1496,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>  	int target_nid, last_cpupid = (-1 & LAST_CPUPID_MASK);
>  	bool migrated = false, writable = false;
>  	int flags = 0;
> +	pg_data_t *pgdat;
>  
>  	vmf->ptl = pmd_lock(vma->vm_mm, vmf->pmd);
>  	if (unlikely(!pmd_same(oldpmd, *vmf->pmd))) {
> @@ -1545,6 +1546,12 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
>  		goto migrate_fail;
>  	}
>  
> +	pgdat = NODE_DATA(target_nid);
> +	if (!numamigrate_isolate_page(pgdat, page)) {
> +		put_page(page);
> +		goto migrate_fail;
> +	}
> +
>  	migrated = migrate_misplaced_page(page, vma, target_nid);
>  	if (migrated) {
>  		flags |= TNF_MIGRATED;
> diff --git a/mm/memory.c b/mm/memory.c
> index fc6f6b7a70e1..4e451b041488 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4769,6 +4769,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	int target_nid;
>  	pte_t pte, old_pte;
>  	int flags = 0;
> +	pg_data_t *pgdat;
>  
>  	/*
>  	 * The "pte" at this point cannot be used safely without
> @@ -4844,6 +4845,12 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  		goto migrate_fail;
>  	}
>  
> +	pgdat = NODE_DATA(target_nid);
> +	if (!numamigrate_isolate_page(pgdat, page)) {
> +		put_page(page);
> +		goto migrate_fail;
> +	}
> +
>  	/* Migrate to the requested node */
>  	if (migrate_misplaced_page(page, vma, target_nid)) {
>  		page_nid = target_nid;
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 9cc98fb1d6ec..0b2b69a2a7ab 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2478,7 +2478,7 @@ static struct folio *alloc_misplaced_dst_folio(struct folio *src,
>  	return __folio_alloc_node(gfp, order, nid);
>  }
>  
> -static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
> +bool numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>  {
>  	int nr_pages = thp_nr_pages(page);
>  	int order = compound_order(page);
> @@ -2496,11 +2496,11 @@ static int numamigrate_isolate_page(pg_data_t *pgdat, struct page *page)
>  				break;
>  		}

There is an other s/return 0/return false/ changed required here for this chunk:

if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING))
                        return 0;

>  		wakeup_kswapd(pgdat->node_zones + z, 0, order, ZONE_MOVABLE);
> -		return 0;
> +		return false;
>  	}

Looks like this whole section under "Avoiding migrating to a node that is nearly full"
check could be moved to numa_page_can_migrate() as that can be considered as one more
check (or action to) see if the page can be migrated or not. After that numamigrate_isolate_page()
will truly be about isolating the page.

Regards,
Bharata.
