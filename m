Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE83C806410
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 02:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376462AbjLFBZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376405AbjLFBZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:25:19 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05652D5B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 17:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701825921; x=1733361921;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hwDm1zR2LSd71/qFJ8tuLupYHtI1TX+1YiM8Kn67Cqs=;
  b=P7GcYfd5cA6wNbvh3U+W0K9DmIoml2qTcV8lDSH9fC+IohoamMd2/UOm
   OWc56dtm/qEcS9NvWECuEAI+zetvSLO/E5mWxU6Y7bQ0gLTryGunA0S3M
   2Ny0jCDa4BW3UyPvr0Mv9xtj07ZuhLhxUyTiMnks5Bc9K/lMyfb/bwbAN
   +EH2/2AvGKYoNqIJ1N/DXNovPe/xSK/yagY0TNhEPbXzlLZIyV2862bO5
   1bmPeOdyCBKZ7l59dnqIJhTzsPkv1eySk3AeG0aPZm+Ra/2QWnXfydMry
   wQG7mB8pFoLDuGJ0fPM3H5d1Vfiilmdt0TBKmDJZhPGTNHBVcQ+tPuDZt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="391155202"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="391155202"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 17:25:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="771123662"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="771123662"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 17:25:19 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 17:25:19 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 17:25:19 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 17:25:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LV8aLEi4lTu7Vf/Ui+JV2NBxxOSK6q8sgD140YvSfUpqzQ0cYdjU9wsy4wVE7MIDJIEVpMSiRvVwS/RtEe+WK7I1QHoLOZFtE03GeCFQmVLhi+lhVbg/CqZP16bICiTArOjxk+NK97nOzMpnpU5UnlGJu2SND/tngi6q2Z7W+VggCaop6RKt8kInVZysiuCoyZZO25EYQdqXFV/+YoQ/+GhKkOWl5HJyWTbGsyoSF/bmIJewjGz8F9CYhzdaZoXWD64mJp0AB+U7JoKE0VoLofIkzGgLUpDVVt+/Xx6wH3aXvyNwUw2/tV516IY29wlelHbqmQErFiGlikmKxTHxdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haosy1542ehhxkAgvKY1s8rM+MHNWwhmHRqnWZkZRX0=;
 b=Xc/bxttuDh/1K1AdGM1h09cylGCDQlxrH8/jOEa7s3TD5jxP1sfkGbjzPSoKeDDo1XE/BEuMBbaoU1yftOw2k829Qtryexf6f+NMXIPXbMrTLREYbZ849fOYgVejLIk819ymmsOZQyvXVoX2W6PFzCvIWzM2AwWbvOvQ4EgQulLzT+G1IYGGF85ll+ehpno+ojB4TzKfgCN9l3W2d+QwWHaHkCgVVhgmamNdqs938M3b3KB3V7Mk2Y0PIero+mXZF3xjZPD5q0PIeG2vmvnt9ivxdqZEGCy4OJV4fwvVutVy74L7WU5nlu1F40g5gfQ43mHwPBIq7REE4KFOPUUJUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY5PR11MB6440.namprd11.prod.outlook.com (2603:10b6:930:33::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 01:25:08 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 01:25:08 +0000
Message-ID: <a057ee0b-23ce-41b1-a923-80805c860af5@intel.com>
Date:   Wed, 6 Dec 2023 09:22:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 04/39] mm/rmap: introduce and use
 hugetlb_try_dup_anon_rmap()
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
 <20231204142146.91437-5-david@redhat.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20231204142146.91437-5-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY5PR11MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc48532-96d5-4ecc-dba3-08dbf5fa2ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nd7RYf8Kx6r4N0dpBv1Nm6rJJdn/llYbAyoYZlF/HJXctIvyFMKf7CCrqPXX+I7A2Yu6AmLStCzjL17sewO/Pzv55FNV2K3m1BxqiXckFQRV1vBIMyQKxH1tRlks/dnEp3SwVxwCMYmfMFUTM6eOP/rkKu76kp/6uZ6B26IbU2PMdLX5eGRMhkOv1nNQQNFZqAS+UsE+2z21dzPlmqMrURqjF1RA8/5rLpi6dSs9a8ULRtPBw1T0qHp4AWOcSDKAssS8/pmU/7mk3wmA7Y0b5Hw6cTY7STmwE3QfOq3JHqbyCDX7YK+pZaPUVytk/DLHLqst74fqmqaapxfQ5cXO++PBiWZ2TgGxnbbnYDuYEHt/mURcTl+VkZ7cWs9Nbpqpkr7/0IACq/Bd4BgZfA64sqWOf+24FSXJlZ7VyVs79pZSmRtE5QGj1xKhtfA0hBUca40HeWJmt0/EeoD5uIsdNCllnqMZY+4FRqrldcwXKQsxZTbmuMqOU7lSW/eZcF3JJDcy6N53uKFBl5iwLlKcm94H9ILj/Pmvg24wnRtXaNOSJeFI4RPyBojYm9dn/VfX6Wn6q/PbCld8QNZuO3/PqVLSn13Cm2Nx/Bndq/poZoiEf8CRAzjCdMomndvQtEhAaNuzv6ddeMt95fHnhhuEKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(7416002)(38100700002)(2906002)(5660300002)(41300700001)(86362001)(82960400001)(31696002)(36756003)(478600001)(6486002)(2616005)(26005)(6666004)(6506007)(53546011)(6512007)(8936002)(8676002)(4326008)(54906003)(66556008)(66946007)(66476007)(83380400001)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czFMM0czOVc4RFNMdTNpZWZPRjcyVVN2aFY5bVFGK2hXR1lxNjJ3QnlJaldv?=
 =?utf-8?B?VmFCZ2RkcHBoWUhMOHFFSlNOYWJMSHNOTUcySjZPQWg2Y3NIQ3NxN3dBYU9x?=
 =?utf-8?B?aHVrQU9uKzJaaXhhRHZDVml3S2NsTU5LbWQ2enJqWWtPcDRJdE92UXE4aGc5?=
 =?utf-8?B?NFJwS0pwSTdMVTJJR1JSUVN5MGdza2RvZmtkeHpUOS9aaUV5VjlBRWptZ0NN?=
 =?utf-8?B?Y1BZOFJDYmVSZm11eEduVUlnNHc2ZzY4bHFOdEswOG1tcnRBZ3JHdWFaRSt6?=
 =?utf-8?B?YnA2UDRTN0xRREFBblpLVDlGVmRwRzN0VjdZZ1lpZVRBeFg4YUtKbHptVjBh?=
 =?utf-8?B?MEtWRUpMUHM5S09TbFZLNGVhRjY2WUhrMnlPTlZQUFVUdkI1K1VVUkYydkxX?=
 =?utf-8?B?M0pXVzlObUE2YmRYdmd6Wm5ielg4Q21ubWFScDJCNXJ2bkJOclJJSlhmNEha?=
 =?utf-8?B?UzJRMFlPcVpTTkFHc3g1b3J6YlFqaW0ycUNLUDhPL081ZDhkLytSQlo4SDdk?=
 =?utf-8?B?cDFPa0pVTUF6UUNLc3BPVjF2Zk84Vk1RdHdWMFg5ZmlRZTFyTFh4dmhFaHFr?=
 =?utf-8?B?WmtsQ3luL0xHRXhVUDNpWUZVcGM3NWlmeFlsZ25OaStXSHpRaFlqQTdBRVpZ?=
 =?utf-8?B?ZSs2MVRqejY0cXlpSkN5S3FyVU8zWUUwYzlXYWxiN3ByRGJZQ3g4VXRyeHV2?=
 =?utf-8?B?UXZPcnNYMzlYWURLM0VPNW1nTTBaVkk3SHVpMFIvT0JLSFFDeFBCVno0aVlr?=
 =?utf-8?B?UDJwdWdVTXVMVUVaMHBZeCtJbUNlODI0Q3VaejBucUFqcm9ZSkZselRiQUZj?=
 =?utf-8?B?ckRzK3NyK2dFWk13OWF2bFh2ZnZGVGlyazByeURabktUdEhyc0dZWHNENHRX?=
 =?utf-8?B?YUhUdnYxSUtxdHQyK3BHcjVNVmdvc0o1SWMvbUg3Um41RGRjL2JxRWVydGtV?=
 =?utf-8?B?Zzhkak42RTZCR2hCQ1ZJQ2N5aFJ6KzAzdXRubE5HN0haUWV6MDN3ZERucGNF?=
 =?utf-8?B?MGcwNmRLRG85OG5WcXhJbGhsZEU5ekwrTVVLSk54Nlg1VWtmUkp3dGZ1MmFv?=
 =?utf-8?B?UXRWaUt3NlZGZWpXV1p2TEZQd1hGWDk4elVhRXdDclk0MmJ5OXQ5dUpCRnY4?=
 =?utf-8?B?NHU5Nk1BN0dTajcrUTZPVlp3dUFkdWp3Q0VEaFpIL01ZOGR4N2ZCSXZHY3oz?=
 =?utf-8?B?ZjBsWW9hVThuMUxtWS9DR28xcXFxbG82S2xXRU4xNDJoZUZJNytEbGRjeDR6?=
 =?utf-8?B?Vld6ZnE3WUhOQnlhQ2liNHZXdGg1MEtXTUFMbFFCR0xMY0FIMVU2SlVTTTh3?=
 =?utf-8?B?cWpjeVBhdFQ3TlgxWmk4RGZ5eVJFbUdxUGlJeEZjaklJWUl3YXM0bGJnS3Bm?=
 =?utf-8?B?bU5aUGhCOG9IcWVhUTkweFdreXJpclhiQkNwbS9wRnYwOVRIZlJPYi9pWiti?=
 =?utf-8?B?bENCNDlZc2RoSkFUUnNjWDNQSThOVHEyYzdBL1VmUEI4MWk5VWN2d2lPaVJp?=
 =?utf-8?B?M25wMzhoWUVKNDVTN1NNQzR4cENRR3NHQXNmYzlkUUNwU0NuN0tvQ3dyU2ZC?=
 =?utf-8?B?ZnU0eCs2Ti80bUpkdmV2eVhEUkRZVElDdGR5cHR1cDNQcWNhNkI3MWxuRHVC?=
 =?utf-8?B?ZXRkUEVxN1UvempWbWVxa1dyc3NJaVR1MkhoRi9rQ2dtcjBhejdveWpuTThs?=
 =?utf-8?B?RXE5bjEwTUV4ZkQrTmE0RUZEQ1kzNk43NzhQV2VxaUNyQjY1T051VGRXakU4?=
 =?utf-8?B?U0JqelB4ejczaUdKTWJOWDBhU25URERmYlVhMWZVMXZ6UWtkenQxVGZDUzZ4?=
 =?utf-8?B?c1hCaE5tOHluenE4N3l1Zi9mcTQ1QTB1NlU1K0tLRDYzQ2tHYUJvcm9kK1Zl?=
 =?utf-8?B?eXpKOHFPQS9EanF5d0FSaXRaaXMzcmJTY1N3T2k0RTRvLzhIU0lkWHlxZFZi?=
 =?utf-8?B?M3BxZlJqb1JYM3YybVhLL0tVaFh0SUZUMFBvQXBhUzZzMTY4OXNpTmZ4MU8z?=
 =?utf-8?B?ZHZ3VDNtb2Zqbm53bzJYQjNSNGJTcTU3c1M3K0ozTGRtc1RQMkZXcXFvT0NW?=
 =?utf-8?B?QktYTVBrdzZMN2hWdzNTcytqU0VLT2U5SW1SNm1qazY3OFlKY1VkMXNEaU9s?=
 =?utf-8?B?Zlk3WHM3RUZ1UU1TekVkZzZ0c1FVdlJQWE02bE5FeGN2YXlNTjdUYzFpOW9x?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc48532-96d5-4ecc-dba3-08dbf5fa2ed9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 01:25:08.2216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RyFHdv6xVdtzoUEIPakkM/6mPc3yAa+VaPupcSdK840PN4ile2/dsmjPrHx67oaAsLD3Qmnd8IqlrLkxfomSZg==
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
> So let's introduce and use hugetlb_try_dup_anon_rmap() to make all
> hugetlb handling use dedicated hugetlb_* rmap functions.
> 
> Note that is_device_private_page() does not apply to hugetlb.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>

> ---
>  include/linux/mm.h   | 12 +++++++++---
>  include/linux/rmap.h | 15 +++++++++++++++
>  mm/hugetlb.c         |  3 +--
>  3 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 418d26608ece7..24c1c7c5a99c0 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1953,15 +1953,21 @@ static inline bool page_maybe_dma_pinned(struct page *page)
>   *
>   * The caller has to hold the PT lock and the vma->vm_mm->->write_protect_seq.
>   */
> -static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
> -					  struct page *page)
> +static inline bool folio_needs_cow_for_dma(struct vm_area_struct *vma,
> +					  struct folio *folio)
>  {
>  	VM_BUG_ON(!(raw_read_seqcount(&vma->vm_mm->write_protect_seq) & 1));
>  
>  	if (!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags))
>  		return false;
>  
> -	return page_maybe_dma_pinned(page);
> +	return folio_maybe_dma_pinned(folio);
> +}
> +
> +static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
> +					  struct page *page)
> +{
> +	return folio_needs_cow_for_dma(vma, page_folio(page));
>  }
>  
>  /**
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 0a81e8420a961..8068c332e2ce5 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -208,6 +208,21 @@ void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
>  void hugetlb_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>  		unsigned long address);
>  
> +/* See page_try_dup_anon_rmap() */
> +static inline int hugetlb_try_dup_anon_rmap(struct folio *folio,
> +		struct vm_area_struct *vma)
> +{
> +	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
> +
> +	if (PageAnonExclusive(&folio->page)) {
> +		if (unlikely(folio_needs_cow_for_dma(vma, folio)))
> +			return -EBUSY;
> +		ClearPageAnonExclusive(&folio->page);
> +	}
> +	atomic_inc(&folio->_entire_mapcount);
> +	return 0;
> +}
> +
>  static inline void hugetlb_add_file_rmap(struct folio *folio)
>  {
>  	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 541a8f38cfdc7..d927f8b2893c0 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5402,8 +5402,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  			 */
>  			if (!folio_test_anon(pte_folio)) {
>  				hugetlb_add_file_rmap(pte_folio);
> -			} else if (page_try_dup_anon_rmap(&pte_folio->page,
> -							  true, src_vma)) {
> +			} else if (hugetlb_try_dup_anon_rmap(pte_folio, src_vma)) {
>  				pte_t src_pte_old = entry;
>  				struct folio *new_folio;
>  
