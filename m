Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3C38098B3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572886AbjLHBnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjLHBnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:43:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65211730
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701999788; x=1733535788;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QjBFgrPbjkIlovSfLw7fyDVAezPg1AjAEjqWzemL81U=;
  b=i3nT/FEeZR99DYLneCOWT1XCDNuEOlLEgcsRqxWnofTfjscQuCsNuddA
   95znc4oRnkC7O21czNrxXINYNNP1f+z7NsV33HU0bQ57gD9qPWqyoNMdJ
   Q9p6Y5VnzTEIjNcjESVuYXmhFS+SJQ/ylesI2u2cabDx9svUQJlhPuc5M
   Fe7/uQZzpZ1yw9sC9VevnfMRkpIRrECtZzGfdwQyDzjjfzy/uvTFMyeH+
   XAVHeaefRk43HPvrrF6GV2jNCit7n316Cs9Nwdvwjmb86JPSj5ZKT8EIE
   hQkpIiTH2IKFfMP0mPGOuMN4pkuaqPd7b0riUF9dGnyuYRXI+wR0OGamX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="394082157"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="394082157"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 17:43:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="748177828"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="748177828"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 17:43:05 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 17:43:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 17:43:04 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 17:43:04 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 17:43:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhPIr7ua/qjA5CxwdyVRovs32PxgsSMItgWOnOo16Yziscnx4RqaIS8knx0mF9iKpiTpuV6iVvYmIeDBGBcQt+307NqKZBDtbXscK7zCNFAkcBP4FxzJ27ZFlqa1z77GilQxwKte/91XRiVFjgexE4sy/TgEnh+NuJpgbTC9qHVc3P3ozIJ2UcLW5YlLOYnpNYRDF0aOZA9aUjjVZg0OPSX5yvcvLkv/MoU2sIBjBtvfjMU79qU7EXuIkjyplsr88Qed7DktuTxHr6qXgWmpsEiIHcWwiZdgalSiRavtNs3DkP/E3ZBuuV4+sUSKWEpCZ0HbpBzMqc4DIwMizwqTJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6R5dLbf3F+L0DA0k77NUpU3Ur5qwCjgS4+otGgwifMg=;
 b=j6ZLuLMtxLAAS3WvzsRn1gTce+XVLL9BMC1IJc+J0QIznuQSrc/MnXJbz/0i/anjB0R+WbzKpq0KOPvcuRuClyhSC+DKdtpBCpBoPE8egrPTHx6dz1PflPutUot9rCnNl2jhmouYSy+syhmjPmG6Rv+sWdAPllKWw+sqDvtGY6lTg4Oa1VxedoL1dhGoFHafvFmjy0y6GzsR2GNdUjxpPprXA4UFNv0vlPV+O+s1PKid7FWBkhMNL/6RXmEWuVyyZo4XNytC5B99ErILB9GD9hMjsTse3CuMOrfyq+n6OqD1VqQjzPBP/rzTtH9/PEWGUUDwSPGwT06i4xm2uRpoaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH7PR11MB8504.namprd11.prod.outlook.com (2603:10b6:510:2fe::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Fri, 8 Dec
 2023 01:42:57 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 01:42:56 +0000
Message-ID: <3a9fa1b7-6bcc-4749-92e7-ef3563a70701@intel.com>
Date:   Fri, 8 Dec 2023 09:42:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 12/39] mm/rmap: remove page_add_file_rmap()
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>
References: <20231204142146.91437-1-david@redhat.com>
 <20231204142146.91437-13-david@redhat.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20231204142146.91437-13-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH7PR11MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: fc864315-f532-42c6-a0ff-08dbf78f00a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fLn5ywrwgxA7kfRLn4MTSweCuZufCMS03B5cXEyPYeQxJ6U2+HM68X5uBflJPph1yAZGkuWuzdTfqYSI0ZeO0BR8zWPNp427ZcfIoul9EqQj82aLo8pUCiqVQGH2+dprAAuK6rg6OX9As8tNdGWWh4GHyYAIHkPfkld1wZ7UnEn9eAkmuOC4sk5KFlBdV5DLnZkOaxE8t3jqJ42jFwoIBhe4PakjWTb2q0mFVd9/wmgfHQJ+ICti/0IXfNXxkLOVf6bG5R7SR9EmShjMsZS1YoVbKRIrwKah1/EUq608L9tvCINNadNlw1ECgCZzRdkGiKFnEIP4nB+b+fsOOp6euSPjeseiDHNU/3KYrzwQg1OWa5Wg5eq4MTa2JPAcBHYG2iC8T62I/9NgYxHqxGYuG6ktiOTR5bxp5usT1l6rpuar+h/voFog5xmRKXqZ7xKlY7ZEZ56g4s76RPR055d5YMJcyRPBnKFFwT8N+zcrp9HDPp8Y4f1l3LzcMbAZ3EKPFdEZ0quyhg6NpPBchDUC6WqrUn6RT2KOHf+820uU+7N6ygqDFki7BbKoUtty3S4SOXZs7k4V0+L4bMZBNxvbnn7sW8dZENUAqj8sCyfKMYbw3Zh0PwldD6ykeolMn1eYIpp2CD6jXuOPhGusepumKIh0SpddPXjGLHgQBoC7lC59Op5SlKi9f9EZInrOuJSmB50fqfZxKGhqT9Tm5MjTtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(376002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(66946007)(66556008)(5660300002)(66476007)(54906003)(478600001)(6486002)(2906002)(8676002)(4326008)(6666004)(7416002)(316002)(31686004)(8936002)(6506007)(53546011)(6512007)(26005)(2616005)(83380400001)(41300700001)(86362001)(38100700002)(36756003)(31696002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFJzWTlzWmZqVkVZcUMrZ01XcXE3b2p0Qi9FZzBqczdhRnpwbEtWTE5XUVBa?=
 =?utf-8?B?UFJnZDEzNkJ1a0ZCbDlSTDJnc1VQZWUzNHI5b2gvYlRqOFRmcmtZQlBuYmtF?=
 =?utf-8?B?bGk5L0tXQTRFUzFLMnQyd0s4Rng2YldwNS83U0dPdWVERytyOWtONE1Nb0No?=
 =?utf-8?B?bmN5UzgyR1hManhFbW1BUzM2V0tnU0RhZDRZVEdScWpmTlJENTNPZjV0dFJs?=
 =?utf-8?B?WXQyUmlIbk8yK0hGVEMrOHJkdzBTbDRsSCs4cGRXZlI4WlFQSVZOandsNE4v?=
 =?utf-8?B?YlI3Rk54dEJackh4OG83ajFORVAweTNCVDJGdWRGTVRmcjZYbGhiQ1BTaTJE?=
 =?utf-8?B?MjVaL1c3UFM3YTM4WFB3b0V3L054M04weU9NTTNIM1ZmSFl1ejNmMjhnYUhB?=
 =?utf-8?B?WVJsc1hBSVNRK2ZCL2tYRDcvRmNLQVlDYjUzSXk4eG10eFdYR2Zqa3dhZGEx?=
 =?utf-8?B?R01LYXQzZGV5Z3paalRMUE1IaVVGbXZ0SFdGcGMvcExFbW96VnY4a1hWNTRT?=
 =?utf-8?B?ODZnazFPcE5zS013c0grRTIxNEU4UTcvMExIMDNGTUZ6OWllUEhKZTdCbDZr?=
 =?utf-8?B?L2FCLzRhT2FZZXd5ejJDTmVGc3hobWFDZC9vSlhFQmsyL3hWQ1poUXZRRlRZ?=
 =?utf-8?B?ekNNZDhOMHhRMGJjZXpKVnhteG5LMFZUaEpxVkloTk9GbjZWeE5hRHJFQlhv?=
 =?utf-8?B?OW9saU1SRWg5bVhQS1A2VUJNdmViL0xiTXZaOC9KTjJRMXBXSE8wNlE2cVQ4?=
 =?utf-8?B?eTN3SDdPS2hiWmZGQWNlbXduejFYNHIzSFczUktGTmx6b2ZMR29PYS81UjR1?=
 =?utf-8?B?M2dqejdGMG5heGVKT3R4U1NQWnRNS3FzQzkwcVU5Sm53bDNTQ3dGblI1Q2Ni?=
 =?utf-8?B?WlBhWit1RjRqcTc3U2ppcURyMVZoeFZPZ0lKa0xTWjJuK3dVcXJ1Y3J3MTg1?=
 =?utf-8?B?VVZpR2lqUVhUUTVmS29sTGxaTU9qRG1RNDVacTh3ZzdkcnF3MC9ZdjFYZy96?=
 =?utf-8?B?WlJlczdMYlNabkZEVGdFN1BmOVVCUkVKM2xPZE9jL2xoZDJXeTNOaWRXaFkr?=
 =?utf-8?B?cHZTSFVEQlV4OXpSOU50S1BRNWEzM0xncGlyZE52VHczdFN0RDdweGVHekti?=
 =?utf-8?B?STFyWmtOTHhvcExZdTRnWVJYOTFpeUhVMWc4bXVUdjdUQndkcGlEVTAveXZM?=
 =?utf-8?B?Y1RyMkVQbG1oeFBxak5YYk5RaUJuWVNpUjgxbWRhZ1dyUThKL0hMaGlaSS9Y?=
 =?utf-8?B?NTM0eUNXbGcxcVQwVXd1djd5ZHpYT1l4T3RVd0JVMkkwY0ZRUWR6cWhVS241?=
 =?utf-8?B?UGN1elRzeS80dHRRTFdvV0JobEZRUmNsV3pMcG8rOXp5R2phQ0hTRFJqbUwy?=
 =?utf-8?B?WTFCWjRLZ3hlSWFGZUd6ZUlNWExZYjNCK29lYW9xTTZCOU84RldVL2NOdHJP?=
 =?utf-8?B?Skt5Q0tETzBENysvUzdVbVlOWnpaekEwZHRaaTJoWHB0V2Z3Tk1vTGdHL0VF?=
 =?utf-8?B?cGtzYTAwQ1lVT2xqVHRJVmFidXVXbTNXNU5HSjFWY1ZOb2g1VWhnb2hETUYw?=
 =?utf-8?B?eUVrOUY5VU9pMm1uTk1HaDE3N1NsUmdtQ21Cc1Q5V2pqWXdHY053SW5NbUJK?=
 =?utf-8?B?VXBWMlN0Tjc5bFhFMTE0eVhmUVJhNUxoS2xSQklWaktUNlEyMjFRTFBxOUhk?=
 =?utf-8?B?VUlXa01VQ3piTU4yUGZpcWJkV0UxQmZUVjFyNVN0aVJsZC9YMnZZcTJPb2dC?=
 =?utf-8?B?L0poMFFncnR6Vi9OenZKL3VGMHN6dHIrc0VjenozQTNuODJUZXo2bE9UMzlK?=
 =?utf-8?B?TDhXNnU0WmF2VHJBcWFVOFFSbUdOWUFrUis5b3JOeWhwMGhUMEpsKzdhREFa?=
 =?utf-8?B?MTNCdGRUdDhYUVhSS3pKajVhc3N4eld5T3ZMM1RxUUl2UXp2TFFKU251ZUlQ?=
 =?utf-8?B?ZVdLckVzSlhkaW94Z29teUpsOEIxWFlFd2ZWV2JjNVp4TEFWaitidmhWaWNR?=
 =?utf-8?B?YkxpVTZoU3U0UFRjdXphdnBqYkc2RUdmcDcyTFo4MlBYZU84Sk1ndnV5N09I?=
 =?utf-8?B?VlJudk13V1hXNmpHRmkyY2xaWlhta3hPYWR1NWhIcjMrM1VqOGdIQ0NKTUx4?=
 =?utf-8?Q?FxsScQpBDO0yNItlUy8X72rU4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc864315-f532-42c6-a0ff-08dbf78f00a9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 01:42:56.8972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /opP/9YZr+bJuePJGm5vSTOqud8S2UCPU+RCOLdNDrbROZsbFbjnlznk4yHPbAgsuOMXgxS6ZQcb4KYxoJYZTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8504
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/2023 10:21 PM, David Hildenbrand wrote:
> All users are gone, let's remove it.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>

> ---
>   include/linux/rmap.h |  2 --
>   mm/rmap.c            | 21 ---------------------
>   2 files changed, 23 deletions(-)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index a4a30c361ac50..95f7b94a70295 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -235,8 +235,6 @@ void page_add_new_anon_rmap(struct page *, struct vm_area_struct *,
>   		unsigned long address);
>   void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>   		unsigned long address);
> -void page_add_file_rmap(struct page *, struct vm_area_struct *,
> -		bool compound);
>   void folio_add_file_rmap_ptes(struct folio *, struct page *, unsigned int nr,
>   		struct vm_area_struct *);
>   #define folio_add_file_rmap_pte(folio, page, vma) \
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 1614d98062948..53e2c653be99a 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1422,27 +1422,6 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
>   #endif
>   }
>   
> -/**
> - * page_add_file_rmap - add pte mapping to a file page
> - * @page:	the page to add the mapping to
> - * @vma:	the vm area in which the mapping is added
> - * @compound:	charge the page as compound or small page
> - *
> - * The caller needs to hold the pte lock.
> - */
> -void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
> -		bool compound)
> -{
> -	struct folio *folio = page_folio(page);
> -
> -	VM_WARN_ON_ONCE_PAGE(compound && !PageTransHuge(page), page);
> -
> -	if (likely(!compound))
> -		folio_add_file_rmap_pte(folio, page, vma);
> -	else
> -		folio_add_file_rmap_pmd(folio, page, vma);
> -}
> -
>   /**
>    * page_remove_rmap - take down pte mapping from a page
>    * @page:	page to remove mapping from
