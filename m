Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1B3757082
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjGQXar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjGQXap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:30:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A698210CA
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689636586; x=1721172586;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qbt/k0pJr8y4TLBiUTioDRoH3XCbSib6ZF4KtG8f5WU=;
  b=A9aH9OyIYsQzU9D+I3ckPUL8nWbbYdrpaoD7H70DE1yEBhGhM+y/mu8H
   bPXkxx6QOAvqN//DpR9HMpPCkCAANTQp/ZbonC4ODvJqXk8RCcRJdaqIs
   G0sTVzohaaw7JP0gQtEapem/SaE0TU6xijFA6nBCwFWme7vmADDpH98o0
   YANZ/ho4QE62201BfN0gJlgMdnnEwnq8G+PF2v2eeiCNed1ds+kPVupU2
   PbAjTmXTcC4cI130tkiJkKH+BVV5ztiLtA/jjEMaR4vXj8K0Ht2OcjbAE
   nNccOhQepGYjo6xzPIhK0GdVqbQNYPn6IZ6qDwlS3WkC3sR4IT3Vx7mUk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="366103472"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="366103472"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 16:27:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="897355839"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="897355839"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 17 Jul 2023 16:27:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 16:27:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 16:27:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 16:27:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yje0Pa9Tx044llDl7gitLgL7WqHNbx/N7zlJxK89qs13SsmGXbKf8T2D/+cQ2H3efWwm2ceqmdcSqm6qM6+PrzCJOUAxcPcbMsFLsfX5QDnme5xNe1HgjTB225Ar0eDVanpGvWBL7e4n8WqR76zn8CEEAO6pFt3IPKbbnrXtXGCw5qjzNkUB+Sfifcs9qAJIjcdAvJBMh41ejEN+7evKuFoTlQkmRTsE3ouWh+ZmQQoY4GlgPE+nIg6cn09pQRvk2IIlNJ1pC45pDMMZeAQ4VLcZMuFy1WbY0WhM9BZ64xpGfbcm9NKPSNEvWRN7MygEROvZPg46fMAQoxwj3J4/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tECi6409ORnROxwAa2ZIfn3VNwd0CMRot7Qa0ckXFZw=;
 b=lQab/BXEUmxpUJ4n9DGF8sc9VAwH52f+Hd2zNtEJ63nZUz4klS6wD1Iqyb8tRF1fubPYJjaTIdbuRv7WlFI3zeiFfW86fbxoNJNTolhtlhm9OIww9aZxr2yha26V+LLFIpBQFF9Bm0ttzSG9Iwx1RRgVxMl2AEOExl+uXHuYobS2qKCY7kRKE34skNuwiefaSMHf+YnNB9ulhGyVAvVthwyGs0isVy3Hz1Decx4UPjH5PRrDowtpgxFj+kGstlTDq0FxY/rBDsS1cV8zKVSPgb2W13G64FaYG8zLq6Lco5Ny/rCTXbbRnT0c5OhYcYK+AxaOO88MZosouOBusyHL2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SA1PR11MB5803.namprd11.prod.outlook.com (2603:10b6:806:23e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Mon, 17 Jul
 2023 23:27:38 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::f4df:c85c:6300:880e%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 23:27:38 +0000
Message-ID: <b3c20fd8-3835-517a-a055-cd796fa7f733@intel.com>
Date:   Tue, 18 Jul 2023 07:27:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v1 3/3] mm: Batch-zap large anonymous folio PTE mappings
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "David Hildenbrand" <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20230717143110.260162-1-ryan.roberts@arm.com>
 <20230717143110.260162-4-ryan.roberts@arm.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20230717143110.260162-4-ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0005.apcprd04.prod.outlook.com
 (2603:1096:4:197::16) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SA1PR11MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: fc6bab64-7394-42ea-66e8-08db871d685f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ux2nqN+3ahfMWvndo+SDV0ol7xuw+Pr1StN+ldwIQNc1In0IufuFBZbpgFF+oAalB3aQBpTJIOr1sRJSCodOI/jaMXmy0j1yBbuUso5WLp0ysxwlMf0TWXz774xmOvJU98nWHVPewyhbU6m/yh7qnB/kL96Zs1SYcZRV+EsyPRZQNiQysDCIA3hr2xarrE34oYVq77b8yyo7V5JIXmsiQSexcML9mQoJLn+Kw94JtIzIEMHlbvG/qjBTInfvltYL/GPluHSXwJX33j/KfjiuQUK+zkrqegH7nllj+nYFfPBQU7h5nhzpuQ0WGRmiCdMGihHpg4VWKlveK8jNk4W8qJPbe2MElFbpq6a10TIOksow6I22NLgoEVW0dCYhMb4rY3qqsTJ3KxNCR7wdY3+xUuftbobbgbDXHbSGF4KeIzY9O5VRIPL0/qSDrz+xYAv25OWFBGZHq3EBQuCEp2TsReCA4UqJWavylhybc3V6IwVKY/1UUeQ1A75ur3cxM0m07eyLFNJLxbQcuw86+rMa/2iCkLs6BMW7ILp71nprvZGdk5olirMhS54T6TXCmhYOrR5zQtixxOGq/r25AOJ/EuKT8ZIFnj5YJUEm2v1ftqBuZXor3iOPcb0qJS/Ja8PdEDx3SruA0JiOWzJLpT7CKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199021)(110136005)(2616005)(6486002)(478600001)(31696002)(82960400001)(8676002)(86362001)(53546011)(36756003)(26005)(6506007)(8936002)(316002)(41300700001)(66476007)(5660300002)(2906002)(4326008)(38100700002)(66946007)(6512007)(186003)(66556008)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REU4dW53MU5jVGd6VzJWdHl4UUM5QUhvV0JCcjRFelB1QXZ5aHlhVDFiVFlY?=
 =?utf-8?B?UzdabXVpT1NlT2JwcmlLSzJ4ZUhGQzRaNlpoMHF0NTFCN1E4L3NtYWRUQzdo?=
 =?utf-8?B?TEdGQ0FMOTdGRDdUalUwMTF4TTJvT1hCSlBHWDdSQTdpeDVLY0UrRno5djZR?=
 =?utf-8?B?cWplM2ZUT1Z1VDY0bmJrbm9odjE1SnlCaVk5MUhjV1FUVURGQVZDRmxrSStn?=
 =?utf-8?B?Y0x2MFBuN1BOa1E1a1FkdGZPdUoxeHlwMFlkNXlicTNYTmZseEhib3cwSnR4?=
 =?utf-8?B?cWw3SGxSak1BS0V1TVBTVC9MUllEOWdCeWZqcmdYcG15Y21oYVJScmpkZjl4?=
 =?utf-8?B?QVhSS0thVCs1ZjdQd3poa0d1d0QwWmFtTHNGKzJzQ2Y5YXZCNnRpYzBMTjRu?=
 =?utf-8?B?NWQ4VjZhY3hmL1FmSURjaW1GKzRzbFdwTzh4NEJPN1E2SDQwSytUWWZHaEZF?=
 =?utf-8?B?MHdwTkluVktqcGpoYXF1TzhQQmhteWtxMTN4N1YzVzJZSHdrU1Z2cjFHTU5U?=
 =?utf-8?B?WDU4SDh6T0hKU1c3eGRtaXYxeklJUks4UzR4bmJPc3JSQXpaWVppaHp2dWs1?=
 =?utf-8?B?SHl6YUlYbGFzSUpZdmlXbEVUV2xES0dBWHlQNy9DRUZ2SDMvK0c2OUgxVTU3?=
 =?utf-8?B?Mmt1b1NhVHJ3M1p6dzBaMkZCdDlwR1VrL3pvSlRDZkJnOU5JUkRYV1BzUHRC?=
 =?utf-8?B?ZTlDTDZidzErOVpDdkgyYkFibGJ4NkM0Z3g1aGl6YWpuOE5GZDBaSm9iSEJH?=
 =?utf-8?B?U3d5TThnb3BMUmxZNjY4SG94UFhTcGdubFlOOW5XRjNSRkNzTHhGMlR6bEl3?=
 =?utf-8?B?cUR1R2xKU0pYL28zTDVPZkdENHhTL2lvRTlyZ21hYzNoWXRuUzVxSzRSbmky?=
 =?utf-8?B?OXUwM2QzNTR6dnFxaEFGdVRSTEphTEFrSnFZcVRRZnk4UEdLc2N0c0dVenYr?=
 =?utf-8?B?S1ZEb2YzaHlid0R6VEQ4cW03WFc2U0NGdUlsU2lHaG1WN1ZvNW16dnJTeFhZ?=
 =?utf-8?B?NGs0Q0hjQTNxL1MxdWJNSGdXV0poNDlPc004YjhHZjdLc0hPenEvYnpLaTd4?=
 =?utf-8?B?d01pZUhtaHVtTVRaaU12YjN6Zjk0aGtiSzdBbXRBTkpnZ1hNS0FKL2tGN0NM?=
 =?utf-8?B?dythU050cy9rK1dPem5jRkY0MU9IVWVFdy82L1IvaWFJR2RFcFZkTGFsOGVr?=
 =?utf-8?B?L09xVklrVHUrU3V1dmo5OHFlNGExMmZPTXRieVp4SWV1MW9LWGNTN1ZKTjhL?=
 =?utf-8?B?ZEZYcTJ5ZDI0Q1BJNFFLVFhPdmNYZ1Uxb01BUkdhU3hPMGhrekF6dWwvNnBs?=
 =?utf-8?B?K3dxdWsvaDZYTnNlcEJRR3ZZc1MrVHdnOGdtcXp5R1JqYjdoMEw5dGk0ejU4?=
 =?utf-8?B?bi9JQ0lUOUVTSTVJS2lzMEJxNmFDZUhRU1o3TVN3SlVuRTBKN1pMNTZ0dDRl?=
 =?utf-8?B?UVc1YnF4WUZjV3FPWGtEMVlPc1kzSCt1cDcxZnNWV05ESWpzVHdBM01kUk03?=
 =?utf-8?B?RS9rd3dtcFlDOXh5cjZ4QUJwTmRBMGpOdDVjUUl0VTlkT1JpYXVyQitPcklq?=
 =?utf-8?B?WnpNc3lpbXFOSjd3TnFXaDMzZ1pLT1hxUmFCbHFZRERQSXZjMDVCeDA2R0k4?=
 =?utf-8?B?cm5FR29rb1N3UlNFdHA0emFYMUkwR0s1cVlzT3J0YXlzM2V1ZEFmUkpUamxv?=
 =?utf-8?B?YnVDRjdtUlhKSXYzTGdyWGh3YXV3cVRaU0V6bVBoeGtnOC9Tc3NvRzJYV2VQ?=
 =?utf-8?B?Wm9UZ2tMcTBGRUZaZmhNOXlwa244RSt3d0d6UzYzQ0UwY1pzUVJYZ0c0RnVH?=
 =?utf-8?B?czB6SzQwVDZPb2JyZytpanM3NEN6Wk1CTHhwWHFGM3FjcUJZeW9mVmc4Y1hP?=
 =?utf-8?B?VlpmWDMzZFRQUm5ENE5ybUQ1MGJWa3ZzOVV4U0NXVXJZaEEyOUtUZ0FvTmlT?=
 =?utf-8?B?c1pRbm1mWUkydXNsQndXVG1ZNEozSGpsVXNLb2NIQzBJZzA4aUZZV0pUVzI1?=
 =?utf-8?B?WVJpSVhiSUJlUzEzRDVTeVV6cm1XRG00bWN6cVRUdmhodE9NUmM5cXVldG0y?=
 =?utf-8?B?SVV5Q2RxWlhDcDBaTlBaZ3B3RDFyb2dwR2RKbTVTb3lvWUFGOXBuMzhtZm9X?=
 =?utf-8?Q?Fo+0AcL/evakqksb2KA3f/qvd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6bab64-7394-42ea-66e8-08db871d685f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 23:27:37.9166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0uIIFUUKjwp3T9rawJ8MI1MkNJgbKell1LLjg+3GMOaVgxeEVDWuybVzRSB8vaKmKKe7xNvIda5LYmpgi6dhiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5803
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/23 22:31, Ryan Roberts wrote:
> This allows batching the rmap removal with folio_remove_rmap_range(),
> which means we avoid spuriously adding a partially unmapped folio to the
> deferrred split queue in the common case, which reduces split queue lock
> contention.
> 
> Previously each page was removed from the rmap individually with
> page_remove_rmap(). If the first page belonged to a large folio, this
> would cause page_remove_rmap() to conclude that the folio was now
> partially mapped and add the folio to the deferred split queue. But
> subsequent calls would cause the folio to become fully unmapped, meaning
> there is no value to adding it to the split queue.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  mm/memory.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 01f39e8144ef..6facb8c8807a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1391,6 +1391,95 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
>  	pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
>  }
>  
> +static inline unsigned long page_addr(struct page *page,
> +				struct page *anchor, unsigned long anchor_addr)
> +{
> +	unsigned long offset;
> +	unsigned long addr;
> +
> +	offset = (page_to_pfn(page) - page_to_pfn(anchor)) << PAGE_SHIFT;
> +	addr = anchor_addr + offset;
> +
> +	if (anchor > page) {
> +		if (addr > anchor_addr)
> +			return 0;
> +	} else {
> +		if (addr < anchor_addr)
> +			return ULONG_MAX;
> +	}
> +
> +	return addr;
> +}
> +
> +static int calc_anon_folio_map_pgcount(struct folio *folio,
> +				       struct page *page, pte_t *pte,
> +				       unsigned long addr, unsigned long end)
> +{
> +	pte_t ptent;
> +	int floops;
> +	int i;
> +	unsigned long pfn;
> +
> +	end = min(page_addr(&folio->page + folio_nr_pages(folio), page, addr),
> +		  end);
> +	floops = (end - addr) >> PAGE_SHIFT;
> +	pfn = page_to_pfn(page);
> +	pfn++;
> +	pte++;
> +
> +	for (i = 1; i < floops; i++) {
> +		ptent = ptep_get(pte);
> +
> +		if (!pte_present(ptent) ||
> +		    pte_pfn(ptent) != pfn) {
> +			return i;
> +		}
> +
> +		pfn++;
> +		pte++;
> +	}
> +
> +	return floops;
> +}
> +
> +static unsigned long zap_anon_pte_range(struct mmu_gather *tlb,
> +					struct vm_area_struct *vma,
> +					struct page *page, pte_t *pte,
> +					unsigned long addr, unsigned long end,
> +					bool *full_out)
> +{
> +	struct folio *folio = page_folio(page);
> +	struct mm_struct *mm = tlb->mm;
> +	pte_t ptent;
> +	int pgcount;
> +	int i;
> +	bool full;
> +
> +	pgcount = calc_anon_folio_map_pgcount(folio, page, pte, addr, end);
> +
> +	for (i = 0; i < pgcount;) {
> +		ptent = ptep_get_and_clear_full(mm, addr, pte, tlb->fullmm);
> +		tlb_remove_tlb_entry(tlb, pte, addr);
> +		full = __tlb_remove_page(tlb, page, 0);
> +
> +		if (unlikely(page_mapcount(page) < 1))
> +			print_bad_pte(vma, addr, ptent, page);
> +
> +		i++;
> +		page++;
> +		pte++;
> +		addr += PAGE_SIZE;
> +
> +		if (unlikely(full))
> +			break;
> +	}
> +
> +	folio_remove_rmap_range(folio, page - i, i, vma);
> +
> +	*full_out = full;
> +	return i;
> +}
> +
>  static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  				struct vm_area_struct *vma, pmd_t *pmd,
>  				unsigned long addr, unsigned long end,
> @@ -1428,6 +1517,36 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			page = vm_normal_page(vma, addr, ptent);
>  			if (unlikely(!should_zap_page(details, page)))
>  				continue;
> +
> +			/*
> +			 * Batch zap large anonymous folio mappings. This allows
> +			 * batching the rmap removal, which means we avoid
> +			 * spuriously adding a partially unmapped folio to the
> +			 * deferrred split queue in the common case, which
> +			 * reduces split queue lock contention. Require the VMA
> +			 * to be anonymous to ensure that none of the PTEs in
> +			 * the range require zap_install_uffd_wp_if_needed().
> +			 */
> +			if (page && PageAnon(page) && vma_is_anonymous(vma)) {
Why this is only for anonymous page? I suppose it can support file mapping also.


Regards
Yin, Fengwei

> +				bool full;
> +				int pgcount;
> +
> +				pgcount = zap_anon_pte_range(tlb, vma,
> +						page, pte, addr, end, &full);
> +
> +				rss[mm_counter(page)] -= pgcount;
> +				pgcount--;
> +				pte += pgcount;
> +				addr += pgcount << PAGE_SHIFT;
> +
> +				if (unlikely(full)) {
> +					force_flush = 1;
> +					addr += PAGE_SIZE;
> +					break;
> +				}
> +				continue;
> +			}
> +
>  			ptent = ptep_get_and_clear_full(mm, addr, pte,
>  							tlb->fullmm);
>  			tlb_remove_tlb_entry(tlb, pte, addr);
