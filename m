Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B90E8098B4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjLHBoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:44:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLHBoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:44:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3FE10DA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701999876; x=1733535876;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+Pkn0r5on45yR58DT4wxTRAcPUPO7CXY1DVLo2wCRWA=;
  b=KmiuR70jbInfvgVh9Tkrk6/bV8Vqqx5cGpkapG/BJjRQ5qNAQfWocsgY
   mc4mRIADTMIYnF+hV1UadJV2AIidQED/Ykn2uMQKfFhMXdcxWoa6551y6
   zEusvHE8xn3mbgnd6R9Ag3+5/sqe+u5mkW4aAHsisEa/N1kVjL/WDquPZ
   sBt9KG6FF7rHYHJ8b9msOtcs5wBnUt/UNaPwWHV4W5oxbPCivfvDNA/R2
   vWcGWnEFvqTsuEYhMT30De/y4cVbrEuBpJLdxm+JkKch6ww6Nc71iQhdI
   /08tv1e84q8xRKaVUO7X1XdO66P3uZ9oxp6Jy0KDKTxcWZlUrVP0mgBYi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="458653768"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="458653768"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 17:44:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="806226007"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="806226007"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 17:44:34 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 17:44:34 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 17:44:34 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 17:44:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXBnz/uE+d2RgZ+XH/QYfnsq4fsK7UMsmG3tY73TBOAKoh4N/0fJZQQMS54Z0mChGO7Yoa9anYKhzvomTDXJlktDBgkaxDMca0Z2JiHO91+x5lPKApslggwGsG/rJE6Nv5Q2chgPOrEsauw9LQNoboS1HRetRNOGQSNbVddzijsgZM25Z4oBllYfUjc+oWHUgUsoNcLU587NVOIQp+4RDxqxJvF48Oos4IMVsTj1LGzkqmFDOj4/7vSE90m1kG7qnmJukD9284TIA7zpU7H6DDqzcMFkfGLfh4mbQSccV3fZi1SYcgl7dQ2H/xrAvhJc6bzNRb2W7rAVzGpQOJLTeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMg7ul5n2bpgFo6I9cKPMFv+n0wWcj2nyA4prJJZ5Qs=;
 b=UX9dxtEy4QH5ztW+sNkuG+OPsHP0+TE0S8X1lH5Ti6F9klSpASjLKd75S/HS2MWtEtcvh9QObkO2loRS6O+EsOT6i12VRWZ2Y8YREfm/ORpxSHNZ4ybetKoGvrNC4uwpY8ToQ+09taxtRVFvEnvIC/YukID8huwtoc90CmRU2lgiB8RtIfSaX2j5AveAMhIOhpkHFsil+BSy6IstK3lgUm/Qr18VpZfFagRrIcESMZU2JRS3HYwHVeuormWjYEWP2Finhg+FsKXTo5n/PvO04qSHXi82JbmTK6z3xJCwGQQTYYKgf7ZVDUpjLKR8V6jw6qBQ4sViexWN1ewRmPiM8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH7PR11MB8504.namprd11.prod.outlook.com (2603:10b6:510:2fe::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Fri, 8 Dec
 2023 01:44:32 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 01:44:32 +0000
Message-ID: <0f64e33c-6aae-440c-a76c-de9f87f3f93a@intel.com>
Date:   Fri, 8 Dec 2023 09:44:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 13/39] mm/rmap: factor out adding folio mappings into
 __folio_add_rmap()
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Ryan Roberts" <ryan.roberts@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
 <20231204142146.91437-14-david@redhat.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20231204142146.91437-14-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH7PR11MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: 61171fd1-9db3-4795-09a9-08dbf78f39cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i3XMCMivYRNiYPlDVrFxQJXroDBVGlWPOAamCwFnVpoLHWLaec3g0sOlsQM/m+RnAoZvQkeN+ILbXSGYv/f6BPBoiYuakEaV7PM8YlXviqQKh4W9V+0lByJTvmnSk2/h0WqB8ZslPmJnK5MPRh99Cf01wTWiIwUtf28nNPg9KzeWtKazIahU9uBdH9G30kpy6bOq9nESLnlXC8P03SUG5dUDG+1T68zjKQswctBAsUNnre+J610zKMLG+t1rtVsk0+4k3ieN+jk8A6r0cSOFjpuJ43GDNIQ1mlNlnor7wjrhi09sj0VQFX7T0g2Mgcu9ZDSK30HukwjU/N5En5OWFRwMqKxRIpIoIFOAg7BknJPLgrrGIBhW8MpyJN3XYtNyFJQqMd4ZTnWSajkZQxEfonTdxeH7OhVv/2mmd6CTetXomY0N7nABKfUewXzU/pmIKfNGoZTNY9nK18QaX7f0+zpoQUniT6jdSHkzOYtIiwaYz0UMrMTEQAuHr7Rq651d1qkeO8UujgNe8nOWOy84Tm7PJG4Odvn2DiExO01Ih9DWfXqHyqN8VEBphaAxEk3AjPgf3ZmQYJUQf5Z1/S5Be8I/L8aflMlVq6DC13Ci46Ub0IY7ywYoQT8M6Zz+gCYqV9ba8Ps+ZOwaD0/vl8Ad2xCs4HqgxiwYZZq3POLoPAkCU5NdrnnbcjlidYTQ5FcMa5FGMn1kMj9Xlfums1x4nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(66946007)(66556008)(5660300002)(66476007)(54906003)(478600001)(6486002)(2906002)(8676002)(4326008)(6666004)(7416002)(316002)(31686004)(8936002)(6506007)(53546011)(6512007)(26005)(2616005)(83380400001)(41300700001)(86362001)(38100700002)(36756003)(31696002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmRqR0NlYS90bGMyQTdORC9OTmRmclRJY3JBN0JyRGVJZlF5R1YrM21wTTdB?=
 =?utf-8?B?N29MTUt5Nzl3NURiUEI1U3NRYUxDb2dUcXo5cVE2VE04aHVNNHRMR0V0blZI?=
 =?utf-8?B?MGZpQURxUVhWc0toSytwM3lpV0pOeWZqMksxaWkvaHNwVmVMei9LT1BRVmdQ?=
 =?utf-8?B?YloyTU5Id01aSWw0Yno5clVKcVBaYkxvTDhZMUFQeXJuQUdkODUyclg3b2U5?=
 =?utf-8?B?V3BGNVlqaStnbkZNaW5kNDdRYU8yV1JwS0EydWZOSHVpTHF3azJSUjBta0FT?=
 =?utf-8?B?SmZiTkhDR0RLTHZIU2JncitJU2FvRWQvMk5RdURKbVM2REZlZjk0M2grbXd2?=
 =?utf-8?B?M0toN2doMUk5eTMrRFZCUFJCNGVhZzhrZ0ZBK1VXOGdHaVBGQzkxRExnVzJh?=
 =?utf-8?B?UlIyRVN1UmFoaTR2bSswT0ozdGI4NFZZSVhyMDA0Wm55YUZJMHM5UEcvakhx?=
 =?utf-8?B?N2ViTUpoektqZ3MxYlR2bGpocG1qWm80czd2SXNsL3ZjN3ZnbjZwYS9LNXdl?=
 =?utf-8?B?aGoxc2crcy8vV3dxNWNkTWcyL1RKQVZPVWlsMUFqVGdGTndKK3NWRlJoS2RM?=
 =?utf-8?B?SzJ0RUFocFFGU3MwSURYeVY0QVNoTTZMWGRHZ2JwcWFMYjlaemorZUp5c1F3?=
 =?utf-8?B?QmlqSkJXYjBJMkQrMmw2RHMwQXhzblIwZFZ4QVdKYllFM1dYVkxOTkZjVlNv?=
 =?utf-8?B?ODlsVkgwYURHeTEwUnc4WkZIZzlLMG5vVVU1SmJYa0RjM3BsQnZOc21iOW9V?=
 =?utf-8?B?VUpLRVQ1UGNEbjZaQ1BVbFdMK0ZkV3kzVVJhaXZ5Q3c5eUlTTG5JaHo5UFFw?=
 =?utf-8?B?dVo4OXBqMm94bFp6QUQyazdRUG1LWTV0UVZRVVRMdVhTSjdQWCtoQmgySW0v?=
 =?utf-8?B?SDM0ZlpFUCtqc1BFTlJtWVBjeStlbEpKVUVXVE5YTG1WRGRJdHNVTjIzcEpY?=
 =?utf-8?B?OW02NkxmZWZkOGxEY1h0TFlSSldJRHZydUtJUUJnbUR0Lyt1RVRiYTZxVzBp?=
 =?utf-8?B?cm1UU3lSYzE0bmJaQkpocFNhbVZ1U1VuUUpGa09mTmdjVlJQVzcwdXdCQVFl?=
 =?utf-8?B?NzZmNllKelZYWFhseW9PWnN6NFFvdFN6SVBTTzEwdHN1c0RVTFB1UzBuWjNG?=
 =?utf-8?B?RlAyazNLVWlnV2xWUXByZUY5LzVXTlI4MmQySG9DNFF4a3A2WWd4SlczRTlU?=
 =?utf-8?B?RXFCTTEvL1VRUG4rUm5jYTVhVmJ2MEhQdGZtUjdyNit6NE9ScDEvbFkxZ3Rv?=
 =?utf-8?B?bm16SDMvQzh6allFN2g0ZUZvMndoS1pnb2c1bXJPVVlseXpNY205WXhTem1w?=
 =?utf-8?B?QzEvY3NMOVpyakhuWmhKU2ExVXd1VDczZjZJdy9jbTZaK0FDSnd1ckVrR2dN?=
 =?utf-8?B?aVdHZnRvWnA4ZE9DRFpSVnJ6VzFSckdwekZlTzlHY2ppdlU1L1crUmpIdVA2?=
 =?utf-8?B?N1RCWGQ0MlQxT1VaT3ZMSUh2VGZYenpKTCtmZjQvc01ncnVtMWJERzVCU2xy?=
 =?utf-8?B?Y1lRaG9ZL3RUR3dMQzk3NEN4MC9pV3hJVWVIRkNxRDVBYmFncFFrMU02YnRD?=
 =?utf-8?B?Q0FGcjJoNG16Z0lIWFd3c2dMN3U4OG1ZU0pUemJ6MjVBLzZsOGVFd0lDRTJC?=
 =?utf-8?B?U0F2STk5aGIrd0E3a1ROVVhNN29IMHNNTkVKV05aeEZIUzM1QmhkM0FIcmpO?=
 =?utf-8?B?SVBDZnlaTmQ4ZFJoczcyV2IvMjdpaVpqTVl0YXExWEZhRWRmY3RsMkZaVjJi?=
 =?utf-8?B?MjY4cFVQTDRRVTdnRHBVOXQrYUw4clJTb3NmRjhLNnRnL3hBL00ydVpQNEJy?=
 =?utf-8?B?TEo3andTU0VEU1VJNVM5Tms5TVRyR3NLM2NNRDE2MFBqV1N1azErandURnVU?=
 =?utf-8?B?ZGkvMzd1aGUzbWNhU25rQlRSZG1jMW1BQzRhVTVkZFR2M2hSSEN2REN5OVRD?=
 =?utf-8?B?a3g2R29zOEUxMnRTcHVtOHVQb3JpdjhrTVRDMHZqcVlNdUw2eGxoRitzUDJr?=
 =?utf-8?B?V1lSKzlKb3pYK1IxMFZHRUxXZ3VUcnUyMmh2YWNXMUJ0QmNUVWxCeVdrTk1r?=
 =?utf-8?B?RmFnTjhEejdQV0NpQzE3YXphTDhnNmIrMGNjTjZ5ZGFlaGI5THBwa29HSmdF?=
 =?utf-8?Q?cf5KZbOmGLJ/EMn2F2Rhs9Eeg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 61171fd1-9db3-4795-09a9-08dbf78f39cb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 01:44:32.7767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NslDpMpju+JRRueTEbvXskwbiBmoWF5Gp4rmU59rsY9mQ9b/bae+XTdZMjfSEup9iL5CGrIr+/KpprLWCU1Q8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8504
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/2023 10:21 PM, David Hildenbrand wrote:
> Let's factor it out to prepare for reuse as we convert
> page_add_anon_rmap() to folio_add_anon_rmap_[pte|ptes|pmd]().
> 
> Make the compiler always special-case on the granularity by using
> __always_inline.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>

> ---
>   mm/rmap.c | 75 +++++++++++++++++++++++++++++++------------------------
>   1 file changed, 42 insertions(+), 33 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 53e2c653be99a..c09b360402599 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1127,6 +1127,46 @@ int folio_total_mapcount(struct folio *folio)
>   	return mapcount;
>   }
>   
> +static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
> +		struct page *page, unsigned int nr_pages, enum rmap_mode mode,
> +		int *nr_pmdmapped)
> +{
> +	atomic_t *mapped = &folio->_nr_pages_mapped;
> +	int first, nr = 0;
> +
> +	__folio_rmap_sanity_checks(folio, page, nr_pages, mode);
> +
> +	/* Is page being mapped by PTE? Is this its first map to be added? */
> +	if (likely(mode == RMAP_MODE_PTE)) {
> +		do {
> +			first = atomic_inc_and_test(&page->_mapcount);
> +			if (first && folio_test_large(folio)) {
> +				first = atomic_inc_return_relaxed(mapped);
> +				first = (first < COMPOUND_MAPPED);
> +			}
> +
> +			if (first)
> +				nr++;
> +		} while (page++, --nr_pages > 0);
> +	} else if (mode == RMAP_MODE_PMD) {
> +		first = atomic_inc_and_test(&folio->_entire_mapcount);
> +		if (first) {
> +			nr = atomic_add_return_relaxed(COMPOUND_MAPPED, mapped);
> +			if (likely(nr < COMPOUND_MAPPED + COMPOUND_MAPPED)) {
> +				*nr_pmdmapped = folio_nr_pages(folio);
> +				nr = *nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
> +				/* Raced ahead of a remove and another add? */
> +				if (unlikely(nr < 0))
> +					nr = 0;
> +			} else {
> +				/* Raced ahead of a remove of COMPOUND_MAPPED */
> +				nr = 0;
> +			}
> +		}
> +	}
> +	return nr;
> +}
> +
>   /**
>    * folio_move_anon_rmap - move a folio to our anon_vma
>    * @folio:	The folio to move to our anon_vma
> @@ -1338,42 +1378,11 @@ static __always_inline void __folio_add_file_rmap(struct folio *folio,
>   		struct page *page, unsigned int nr_pages,
>   		struct vm_area_struct *vma, enum rmap_mode mode)
>   {
> -	atomic_t *mapped = &folio->_nr_pages_mapped;
> -	unsigned int nr_pmdmapped = 0, first;
> -	int nr = 0;
> +	unsigned int nr, nr_pmdmapped = 0;
>   
>   	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
> -	__folio_rmap_sanity_checks(folio, page, nr_pages, mode);
> -
> -	/* Is page being mapped by PTE? Is this its first map to be added? */
> -	if (likely(mode == RMAP_MODE_PTE)) {
> -		do {
> -			first = atomic_inc_and_test(&page->_mapcount);
> -			if (first && folio_test_large(folio)) {
> -				first = atomic_inc_return_relaxed(mapped);
> -				first = (first < COMPOUND_MAPPED);
> -			}
> -
> -			if (first)
> -				nr++;
> -		} while (page++, --nr_pages > 0);
> -	} else if (mode == RMAP_MODE_PMD) {
> -		first = atomic_inc_and_test(&folio->_entire_mapcount);
> -		if (first) {
> -			nr = atomic_add_return_relaxed(COMPOUND_MAPPED, mapped);
> -			if (likely(nr < COMPOUND_MAPPED + COMPOUND_MAPPED)) {
> -				nr_pmdmapped = folio_nr_pages(folio);
> -				nr = nr_pmdmapped - (nr & FOLIO_PAGES_MAPPED);
> -				/* Raced ahead of a remove and another add? */
> -				if (unlikely(nr < 0))
> -					nr = 0;
> -			} else {
> -				/* Raced ahead of a remove of COMPOUND_MAPPED */
> -				nr = 0;
> -			}
> -		}
> -	}
>   
> +	nr = __folio_add_rmap(folio, page, nr_pages, mode, &nr_pmdmapped);
>   	if (nr_pmdmapped)
>   		__lruvec_stat_mod_folio(folio, folio_test_swapbacked(folio) ?
>   			NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmapped);
