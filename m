Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4CB806417
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 02:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376362AbjLFBZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjLFBZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:25:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640AB1A4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 17:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701825909; x=1733361909;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xY2Oc5DudgRNHGT/50zZKi1BPq8z8KdFBLPor5hcmaA=;
  b=K+W60OTh1LQQkwQeVhLBPeeia9jRHL3i53X+OBjjFs7Uj4EGapjW2ISX
   MYRJn7RFtn1uQPYceBxsp1D3Z0OtpcgcORAFVy3XVpfcUGWUDyYHQYVr6
   vqPPMiYUooQfBRRoFAeDzokeoVmBHg6iBzNGJ7WNL2qdROV0TS2ttQudz
   z1FVrx9VeuN2Nz8HBJS7Ef+PPC96PqiyMyPJbxcXYtfk5YUHtvAYd/XIo
   yYMQzFK9QiazZwlfPGV4CCoGxUaaFzCRqWq2P+pyR306f2eqRDlte/eOA
   jysfd9OJ87xyVkFgY8sG50g9MH7LklSx/UyjE5lFoM89oYXyJDUHJzqlD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="391155139"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="391155139"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 17:24:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="771123401"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="771123401"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 17:24:53 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 17:24:52 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 17:24:51 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 17:24:51 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 17:24:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IL1b48PRPUgIQPgG/u1dty0bfdzmnNoPor2G2vWN01NWbZfJEGc8E97Xi8LTMCvOTaC/hX+4FKA2S6SnYXcANpF0mRxMFASVgbdtY9ZXvDZvD+NRiQ11Ebcyxm5rag+/JGqaBibxPw/PFtM/tEY+McQOrUXSR16kBEDJlgzUiQsY8d0PqE6q/ONpMiGCF7X6us7uVVZ6DHAwRKahj10IV4ERHMW0NXOVNeWBJz4abZO+OPd309MKSD/mQmLv8FLuMpD3QkUP57ZbWbXHN6+PrUB3t7t9LeMSnii1nVi7KhVoC1Up4Zy9LO5Hn3iaX1LKRN3I3RCyE2XG08qmjiZb7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZli0VxWg8Rbm7A27KHitBYjN/A7dJzul9w+aYiZXD8=;
 b=gfo6sc+7F6szNfdVDE1cPQFN+2appbC3BAqeUaM79ghfzcughF3GkYE0j3pfxx+ae++Q1wfIuwm6+5I6gG6Ut0Rl8cYEM6mOILvbafISfcyYGpDVi/jfIzV2KZXBfhnTLHMW6Y+AJqVSgk9/WK4T/TeN3JX2TtzsFBo1J3MDANpmxnCspA40opPFbDpkPWGvpAMPuuhsbgoEm+Ufs2YR9c0VtrjUt2cbhe+zUJMXtwXOIjotLBZJRw/QfZ8TWRx+vpcZ1tyLnHrmlTELb8fpGtnz8RiGqVhn7zna7Y2TwfnwdUl16IOjmJopwlIbyYUk03+SFYzVDVyhEyAJqd44jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY5PR11MB6440.namprd11.prod.outlook.com (2603:10b6:930:33::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 01:24:32 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 01:24:32 +0000
Message-ID: <ac9a63ab-e83b-41d5-8a59-c4a137cdebd4@intel.com>
Date:   Wed, 6 Dec 2023 09:22:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 02/39] mm/rmap: introduce and use
 hugetlb_remove_rmap()
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
 <20231204142146.91437-3-david@redhat.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20231204142146.91437-3-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY5PR11MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 223151f6-48cf-4116-79ef-08dbf5fa18f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uVdzRvMoWILNHnn2xVFGgYG0GWURoxrOzR0LZlbYUZIPiZUJmtEJuyq6wq7tG9EO4skB1mos/rm8q+/1Ay53IkyhIWJEjteRheTiDnKnjsHz2CTFMedhERxmMWssYtPrm1SOcrp4Y03y8e9jbxZQukAYf3frwFv6TQpBCquOoUkdWHo/1csTDU3iOw5eUrjqRB6wL7LLZCr//5D4zMhMJmNR6cccNgfwe7+P3WamqjuLTo0VXPuBK+grVkuDczf2ZNbT0i/OGY4KEu0qxemE/jjquKaWlw5S1VHNyCb0PD9cslFTQ/2YOSatZICjtwJLMoppoTFJVxK71euvDj2gDAorHGiI/WSR8svp0d3Xzzd8DPMzGrjX66O03amLj7wfa9SYO421K683nevqgSERSGZ2yVeACsK9MjSeC3c/N3mWzeGpSmCk2eOqa38Pv3nvR4ZMZH0+AhjDaeeScHVoGuwGU5cnVwxgkLdI/ctVizZiIW/BnPUlz7meJWNYHlHM75Wzdzc6lYEMcO4RdH1hKlWk+7baRYKvquZmDm3jZ/TGOwmMCggwpCEbWAbxc0XLVmKuqj/lvBVOkOTDT5tIpbmwRgLFZLODCixx1hhLqm0qLwd/qg4TZ8pABGghct4cV9zoj7Jw359jgEw6A01VPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(7416002)(38100700002)(2906002)(5660300002)(41300700001)(86362001)(82960400001)(31696002)(36756003)(478600001)(6486002)(2616005)(26005)(6666004)(6506007)(53546011)(6512007)(8936002)(8676002)(4326008)(54906003)(66556008)(66946007)(66476007)(83380400001)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a09sVnZqbmltUWhDN01sMUhBMDVVdko2K2NzTnZmdDNKQUtJUUlLQU83SmVI?=
 =?utf-8?B?bUUrV0MzSXdzNCtBdkZLMnFSQ1Q5K1BNcmNGbyt2TmFiQ1ROamN2cSsrNUVS?=
 =?utf-8?B?Y2l6aVd2aURQUGVkcnorMThPZEtCcjVDS1lmS1BMWkFIUDFRWGI3VU8wUjRB?=
 =?utf-8?B?ZXg4VEh1TVl6Sm5NOHpSZmFlaUo3K3NPcncyNVRwQjlBdE5BdUhaSms2aXFG?=
 =?utf-8?B?QjBqbTA3OXNnNVpBTzg4UFFncU42VU1jL2krT0V6YkdxU05RS2FKajFZRkJC?=
 =?utf-8?B?OU53Y0xrR295TWtzWGgrTnZ5bTRQM0FqMmVUSm8wRk9xRHNjT1NsVEFOTmR4?=
 =?utf-8?B?ZEFtdUV3TnI2a094WGJITGdMeFkzclJpK0FjczNneFBHLzZzaytIZ0N6TnBi?=
 =?utf-8?B?d3VEOWVVdk81WVQ4Y0RkV0RPdzJTU2dLWGVQRFJNQUhseWFkc0UxVkV2TVl6?=
 =?utf-8?B?N0lHUnRKQ3BHbjRaM1d1VGlpc0ZLOXFxMmhhaDVzVmNZZWpEeDlvaGVjaDMz?=
 =?utf-8?B?VFFEb2pVeGI1QTI5d2lzelZ0K25xYTJtYTNjejFSaDZhNEhlZUNYZ2d3ZmFY?=
 =?utf-8?B?TXFYK3V5UmFBN0MySi9tUzNIQ0M5WnkwY0xaaFpJOHJHMWU4SzgyeDV5eU0v?=
 =?utf-8?B?cVBBYy9vTnJQc2JHRzIreGZDMzM2UmFTRVZ2TEZPY2k0YWlGeERyaXRHelFV?=
 =?utf-8?B?SGFRTUhMYXBydlN2OW5udUFMVmhCYk5Oa2lBTWhRTXBQZ2NISGl4aSt6djBo?=
 =?utf-8?B?T2xLdnpENkVQU29BL2d3QitPR0dWY0VMN1I1Rm0yOWJQa2w3VjRKWlpjTWpP?=
 =?utf-8?B?L0poTGdZY2VSUU1KU05meDF4K0YyS2ZRMGtDMDdTWVA1bFprZ3ZGY3Ixd01G?=
 =?utf-8?B?ai8ydzlPRDN4aWFHcnMwdEorMzJBbzd1VDB1RXZrNlFQYkdDSVREN3lzZHVB?=
 =?utf-8?B?S1B5UTEySVY1NzBzcS9SZFdVei82VGVGdUI0SDgrM1lBc1FFU0duT1RLVU40?=
 =?utf-8?B?cDdLQ2tvNWFNc0RIejBkUml0R1ZsRDRpbjg5eGd6SUpkUnA5S2ZsWS9lb2kv?=
 =?utf-8?B?RVcwQno4dUxUa1ZwQkNRZXFtZXByeFQ3NVdFSSttQ01OWXdlSWVEaTc5TE1r?=
 =?utf-8?B?MklVdSt2MTNQNUk5R25nZ1F0dE1ua0VVTnpwKy9ETHZPa1JTZTRBWmQxdWFO?=
 =?utf-8?B?aXJxbldJRjJnV1h2T0hCcHZDMWN6Nmp5L0dmc1ZLZUZRUmtKM3RmNkFta2Q3?=
 =?utf-8?B?dTVDdmFJRG1NdExRYkVqam1DOEtSeE55MTd4Zzl0M3FMV1F4RmVUL0tHRm1s?=
 =?utf-8?B?TVBhZlMzZU1xWkVDQnFwdGM2dGs1QllxQTVMNXRaSzI5WWZ5cTUyRHJ0YW1C?=
 =?utf-8?B?RWJDZEcvcFJEQm84cjlFckdRU2hUTHd0cUZ6M0ZQaXJ0MG1USjVkVXJBL0po?=
 =?utf-8?B?ZjBCZDNrUkJFeTB5aE5BUHZXbEliNllEVnlET2E1MEMzQWpjem91cUhSNVFp?=
 =?utf-8?B?T2pPYUgwT1RCTUtnSzZ6NVp0VkQvZXJuS1c4RmhqNkVvQ2xKSWNjZDMyVXpq?=
 =?utf-8?B?VTdCVFJBV0U4OW9IQWxSK2ZDaDBqanp3OUVPWm43YkpSNTF3UWxvYkZ3YlRk?=
 =?utf-8?B?ZlNtVTBhdWNWUjJuVUZkMlZueG1ocUdTVkN6MzVPMTZxVHE1YmtvRUJ2elVt?=
 =?utf-8?B?S3FkTWxWY3gvZFhnTWVwZ25yQVBpbi8vcWN4RnZNTFFucElIRjZXblJTdUFQ?=
 =?utf-8?B?Q2V2ZjRua3B6dVRTcUt1TlBhN0VlWGxwejVpc2NIWFd2aGdDYXh0dmloaGJz?=
 =?utf-8?B?Y1hRNS9NSVpRVk45V3BQY01qdGR2a0UwRnNsVlN4VE0wRklFMUNMS3gvWTVW?=
 =?utf-8?B?ejVOWUliU1FSRklaTk1ERmFkMlVHZHVYRk8vYldpOUxHMHZSUjRUekRKa0hq?=
 =?utf-8?B?NGZvcjBENGY1ZG5YSW0yaUR3TkY1bFY2MVZFWDRuRlRZdHFYa1lpaUI5WnN4?=
 =?utf-8?B?b1JDd0o2dS9EQm1HdkdPRDNJTVNvbkRYY0ZsUU5lNnFHdjRFYThYYmFEeHZD?=
 =?utf-8?B?aXBza3VZL2hlUFIzSU9TR0x3YTRnTWdtaUs0NTNVVFBkbzUzNHl6SWR1aWpM?=
 =?utf-8?B?SXFSM3I2RGVONy9OcnVHQmp4ZDVRR1ZTck9oc3FLMjhZRGNzc0tGTHFRL3hH?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 223151f6-48cf-4116-79ef-08dbf5fa18f4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 01:24:32.0481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+LduDQe+RqYwjcUeLmnACPa3D07//YkRFFEiMQE17xXtRII9doetL3yxpLoqtAm9+fVBtJ6SeTy1wjRpgoWeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6440
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



On 12/4/23 22:21, David Hildenbrand wrote:
> hugetlb rmap handling differs quite a lot from "ordinary" rmap code.
> For example, hugetlb currently only supports entire mappings, and treats
> any mapping as mapped using a single "logical PTE". Let's move it out
> of the way so we can overhaul our "ordinary" rmap.
> implementation/interface.
> 
> Let's introduce and use hugetlb_remove_rmap() and remove the hugetlb
> code from page_remove_rmap(). This effectively removes one check on the
> small-folio path as well.
> 
> Note: all possible candidates that need care are page_remove_rmap() that
>       pass compound=true.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>


> ---
>  include/linux/rmap.h |  5 +++++
>  mm/hugetlb.c         |  4 ++--
>  mm/rmap.c            | 17 ++++++++---------
>  3 files changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 4c5bfeb054636..e8d1dc1d5361f 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -208,6 +208,11 @@ void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
>  void hugetlb_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>  		unsigned long address);
>  
> +static inline void hugetlb_remove_rmap(struct folio *folio)
> +{
> +	atomic_dec(&folio->_entire_mapcount);
> +}
> +
>  static inline void __page_dup_rmap(struct page *page, bool compound)
>  {
>  	if (compound) {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 4cfa0679661e2..d17bb53b19ff2 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5669,7 +5669,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  					make_pte_marker(PTE_MARKER_UFFD_WP),
>  					sz);
>  		hugetlb_count_sub(pages_per_huge_page(h), mm);
> -		page_remove_rmap(page, vma, true);
> +		hugetlb_remove_rmap(page_folio(page));
>  
>  		spin_unlock(ptl);
>  		tlb_remove_page_size(tlb, page, huge_page_size(h));
> @@ -5980,7 +5980,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
>  
>  		/* Break COW or unshare */
>  		huge_ptep_clear_flush(vma, haddr, ptep);
> -		page_remove_rmap(&old_folio->page, vma, true);
> +		hugetlb_remove_rmap(old_folio);
>  		hugetlb_add_new_anon_rmap(new_folio, vma, haddr);
>  		if (huge_pte_uffd_wp(pte))
>  			newpte = huge_pte_mkuffd_wp(newpte);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 112467c30b2c9..5037581b79ec6 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1440,13 +1440,6 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
>  
>  	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
>  
> -	/* Hugetlb pages are not counted in NR_*MAPPED */
> -	if (unlikely(folio_test_hugetlb(folio))) {
> -		/* hugetlb pages are always mapped with pmds */
> -		atomic_dec(&folio->_entire_mapcount);
> -		return;
> -	}
> -
>  	/* Is page being unmapped by PTE? Is this its last map to be removed? */
>  	if (likely(!compound)) {
>  		last = atomic_add_negative(-1, &page->_mapcount);
> @@ -1804,7 +1797,10 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  			dec_mm_counter(mm, mm_counter_file(&folio->page));
>  		}
>  discard:
> -		page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
> +		if (unlikely(folio_test_hugetlb(folio)))
> +			hugetlb_remove_rmap(folio);
> +		else
> +			page_remove_rmap(subpage, vma, false);
>  		if (vma->vm_flags & VM_LOCKED)
>  			mlock_drain_local();
>  		folio_put(folio);
> @@ -2157,7 +2153,10 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  			 */
>  		}
>  
> -		page_remove_rmap(subpage, vma, folio_test_hugetlb(folio));
> +		if (unlikely(folio_test_hugetlb(folio)))
> +			hugetlb_remove_rmap(folio);
> +		else
> +			page_remove_rmap(subpage, vma, false);
>  		if (vma->vm_flags & VM_LOCKED)
>  			mlock_drain_local();
>  		folio_put(folio);
