Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7AB8064B3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjLFBZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376410AbjLFBZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:25:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E30AD6D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 17:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701825931; x=1733361931;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=24kl+ht2I+qYp7GG0xeTgViSbLjFAlmkkyZ9mRoAePs=;
  b=BJoIEHB/erpJaCJi2swIIDapveLZ9cYw6tbPktpaohhP5PjVXYumhuga
   SlHIS7KawlB3wI2cHXUqZBphAHK5GZBVm8k4BMujiQkDWQCW57HypQAUw
   giuhA+SUr7gais+jUKmEf1uJxxhOQjrY6HeQdtCtpLSF+nZPMniAwrXSO
   yL6YY6zjzCjC9BmwFJciSiqMOlaJDSwK5cN1QzmZYuRi0F9cXyRuStVMV
   X/OGG0ml/Q5KQ2GxuFuTPSahs9fNa4j/eFdpFzq0WHCwjbTBtB9LgXbLQ
   xUlOQov4KEjx1/UdeHA6+PPim3A6QZXxgHarIILYw2KLpTHbWtoPzX4l9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="1051433"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="1051433"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 17:25:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="764528488"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="764528488"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 17:25:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 17:25:27 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 17:25:27 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 5 Dec 2023 17:25:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWJCS1TFSsJ2g+kePxV4vbH6c9uLhntGrMoGaLdVYFfpiQnJSoHHzwOB8xUWHXPYidN0L1PmuJFbDhnWcUen+QLuTdBbYt0iRRL8nwgNm5S0TLEMRmJk5PnyAwKzFoSSnDHxqEL3v8D7i7JXNGR0TwBFsUCPM6Vn93ek/9aKaMiTvDYWxKmFTUTPi/6kmHAptKMCJ4BcGPb4J0RdIF10UFqvgKyM+EPikRM7nZNJ6FUskzrcaClaHN3XHkj8oYIvnDAFNNyIzpuMqDyioYd7NIB8vToA4Eg7zJGYhgjyaEiXP4Nqi9B4Xh6hRFMTARjud6wiCcDc6vbEtj1jJoxQoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKlPMZ0kUsW1juhqdNwbHTg0qMmvghjZzzeYhge6NMc=;
 b=cuDpCtoJXpc0yX/4H75cEsRkLwhhxbDUTxVBQNDlnUt8FyK4NPEZOIysoCFfSf37DtugGHw2Bo2b1l/zNtMN7CsvCGdf9NTD5Ac1MUtGeXwjfMnlTWi7Yd1VG9JoXMSnC/IqdazLDl6XQ0LrcxIo7hFvZPJpHHrpKf9Ov/MbmjXParALKls1M8JxwIUMN5Ij8M/SdRKJj8+AVspSyEVyfd0TOdJciP+yyDMA77fBb/i3l4eS1gbw27oAxV51uzvnzFsTmQSL+PZ4sRM4XA42KoHxi4DZMBsNOq89iMpzZhmWIV1R0cNrqtjWHFEMMF4g7LlZXAQNayveqY8H9mJS4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by CY5PR11MB6440.namprd11.prod.outlook.com (2603:10b6:930:33::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 01:25:25 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 01:25:25 +0000
Message-ID: <83b9a088-eea9-4148-ab3f-72a96f2d0c34@intel.com>
Date:   Wed, 6 Dec 2023 09:23:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 05/39] mm/rmap: introduce and use
 hugetlb_try_share_anon_rmap()
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
 <20231204142146.91437-6-david@redhat.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <20231204142146.91437-6-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:4:197::20) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|CY5PR11MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f85b176-f550-4f48-9ece-08dbf5fa38ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lwf0YvjGVsldrtBCUqu/eHwSsICrJQct1UFmIoCRfOu//1sZsbAtHSvUDEgX9T7V2U2s7AGlSLYGe1TNYp94U5cgKZdX042bxdbjtvAgH/CHIBb7gmah0zRK+UYeA89rWquNEfUUxzgjinwaqStT9EhN3MCljSyzO0NaH5UF9rMaCVBvqO6FJ9/su7/N1h4/7SXWm9KSFgGjDuh/mq7aZjONFyVWbcNMvbb3NIDVrIK0hT044hgQjSST30S4e9oXOoocyvtM9SdfBx/JAc2kylXpvsGob8x7m0g4BBWhTAmQNxkMD8YCjJhWUaLFJtBtkuNpdPhZXdAz5pVkmZ0wK5GXuVY1j3jaok1dTWJFI6ulPlXqLoHhoLZZqWeauCVPZATWKlj8H2J7XwXLarZwW8Q5wVmP6MZeMkTzXmUd23WF3GI2kJhK4NNPaerd1ATp5yNnAtY0CuwmbaM+LUcaaJ7YdeyrBMNy4QY7gTKve3pTq7g3OG6xjKt4CS6DibXmkGSfz3LhFfiW9T/5KkA3ESHPqZb25MUZ9cMgI/sXCNgDH/5gVFleoNypBW4mph8zTWU1QPIcAbWgO88DFBoN4GyPhYKtdSkyDHyx2NKVU1KJLUFEzW3DJXAToVut2AFIrQLhn0sxac6bRZuHH87s/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(7416002)(38100700002)(2906002)(5660300002)(41300700001)(86362001)(82960400001)(31696002)(36756003)(478600001)(6486002)(2616005)(26005)(6666004)(6506007)(53546011)(6512007)(8936002)(8676002)(4326008)(54906003)(66556008)(66946007)(66476007)(83380400001)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWc1SmZ3ZGt1djBCQ1h3aDdNK1FwUVVtZjk0SHNuV29oc3dwb1lVM2VhVEZv?=
 =?utf-8?B?WVdPQ1RudCtRYmtxNzVOYytEU1E1MGl5ekx0YzFsbE5zcTRHaUk1RzI1MUpy?=
 =?utf-8?B?b05pNlM2c296c2E0dVkySWgrQXFWQk12L0dBWS9hVktUbUtSdUl1TDBaYmEw?=
 =?utf-8?B?clRoYVVSb0dWaEpYeVlhRUxwd0tjTzU3Q2ErVmtkaGhvSmkrZEdlNVZDVWZR?=
 =?utf-8?B?V1ptQkFya25heVovK2VkdmZQcDZSN25RQlBMMkQzeHdZNVZNRG41eXhmbUxv?=
 =?utf-8?B?enhiLzlNMkM4VUNmcG1DY1dTbEdvU1pmR291azF0T2ZpeTdxdjJNNlZDVlkz?=
 =?utf-8?B?Q0xaNFhsQlZoaUdmYWFWYXJIYUcvWnA4YTdhTU1QMnBUWGh2d29lbWEzSlF1?=
 =?utf-8?B?eWZxOU5jSWJHSXBzMlYxa0xZNVkrb28rTmh2MTlwcTdlRmxCS3crYnBQREhM?=
 =?utf-8?B?T1MvRlo4YUhtZW9iemZLcGpsSEMxVjA0Z0M2ZTVhbjdRd3phSC8wNW1QUmRp?=
 =?utf-8?B?K2hqRklJdEVYajNtZGMrYkNGa0J4NE1NRk9idEJqZzBTSFlEMXVFWElUZmFB?=
 =?utf-8?B?cVhFZjRvdlJQelBPcURXUGN5clBaNmU1bWl0RGJkbnVSc0VwMFdWOC9WT3F3?=
 =?utf-8?B?YTFrUUxoa2pzMG4xMXRaWS9kVVlMWHB5N3ZkOHJOcDY3Y0lwVTBIdVBZZEYw?=
 =?utf-8?B?UWxRSDloT08zN3RNZVZoY3FCWkMxNUNhYUJ2VHRrUTVJNm9xbWp1dDl1ODMw?=
 =?utf-8?B?RHdvL2d0enFvRDFBMnJvQ2lHYkNib2FTNlc4Sm4yelFnWkxxU1VQUHpOOEJw?=
 =?utf-8?B?dGpsMCtzOTVZQmNWaWlZbWQ5STBNSjZaVDVEN3F0dFRvZC9BU0xoR2NoZzBL?=
 =?utf-8?B?RUo0bS9VMTlNTnEwRGVMOXVGbTFjMTEvd2dka0lFZUJiai9iS3RwMndNYUJt?=
 =?utf-8?B?OFFXazV0bDVhQnkxeGMvRGFJNjdqNjBETjJuYXAzUHc5NmpLVkliMDVVL1Nj?=
 =?utf-8?B?cldjVnFNSm1iR0FxRkVkRTBVamwzSm9rQnh0b0hrNXRyb1M5ZmZrOFBGZ2d1?=
 =?utf-8?B?Z3RwbEVMd0Z5NjZURFBRdC90eGF6YkJaVUJQR0pOdGRMdEVCcHlESkZNSTc5?=
 =?utf-8?B?Zng4OU12VFlDVDRPcW14ck1Tc2pMdk9NRVl0OGYwL1p4MXV6R1MzWDZyTjhI?=
 =?utf-8?B?czFHNVIxcnZsYlplaHFiNjFNdjdpNVNMZ1ppSjZrR2JWLytXM3FYOXlwazRj?=
 =?utf-8?B?ZldnQ1k4eWZNUmFwRmhMRG5taFJPVjRyR2o0bkdpZitnaklBM2RaclgxRXZP?=
 =?utf-8?B?VzcrR2xNVDh0dGw0N25VVnBtWTF0enZiMWZHa1JWMEJDeGt0RUVERmQ5WnZE?=
 =?utf-8?B?aC9uL2JDSFFzVTdkOXRwclVKcko3LzREenFjZThsMVdncCtDa2t5NXlMWWhp?=
 =?utf-8?B?TVRzcXZ2bkRLeHNZemxicUNaVzVzNzFNMkl0YVE2QlU5SnFzOExyRlhkQURE?=
 =?utf-8?B?MVRWakVXRjNZT1dzWnBpWVFyTU5TakJrd3NveXkrUVJ6dmV4ZTdUa2tHbTJF?=
 =?utf-8?B?VVBubHl1SVZxUXI5blg0ek9sR21iNXl6RVBONm1EaEV3bXVCWWsxc2IrTWQv?=
 =?utf-8?B?MzNXeWJGMHg4MmRneE9NTVYzUGRkNEs3Q252RDk3Z3R0a3dYdFFQcW5ycTBH?=
 =?utf-8?B?NVlKa2E2M0t3bkYzcURLOTkyVXBFRURjNnFvWUtEZnpwZjhmUWVpWS9HNGxU?=
 =?utf-8?B?VzN3ZG9OSEE1R2FCSXkyVzgrbkJkd3p1MGFxblExdUh5VGg3K3pSRnAxRDFB?=
 =?utf-8?B?aTIvQjFLQTlTZjN4Ry9vM3NQZ0JQN2NHOTBMN1IzVkVuWm1BWTY0RkhTa21O?=
 =?utf-8?B?bHdWNzNxOURhYlViQkxZaWQ4WWNIaW1HUFhLcHI1ejVIeGhhR2t4bTFzRVBp?=
 =?utf-8?B?d1RpN1pZWjd5V0psaDVBZzJCMXh1SldXTkh0TDZuUG5tdHFMSmhObnlrRzZ2?=
 =?utf-8?B?Q1NEVzkvTzJTc3NwcVZTbmhZYnBSWEdPRnpQcWpaUjNnQXZBVVdkKzZFOG1O?=
 =?utf-8?B?VUF6dy9oSWdyZkxZWjE1aFlkc0NJUGRpeDBRb3huenl4Y1dVcmUybEF3cnY1?=
 =?utf-8?B?ekUvRkpFWjhCeVErWU84TGNpeXBrSFhHcXJxb1gveGNHSDc5MjEzclFoVGFv?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f85b176-f550-4f48-9ece-08dbf5fa38ed
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 01:25:25.2303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSgUO3/TIPlFrg0dVvlG3iSJDIDbCqjge6hvowEmGclYNeK+NKPs83OIU+YDGRJpm84hzFhTcRwiuUKCUxNqUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6440
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
> Note that try_to_unmap_one() does not need care. Easy to spot because
> among all that nasty hugetlb special-casing in that function, we're not
> using set_huge_pte_at() on the anon path -- well, and that code assumes
> that we we would want to swapout.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>

> ---
>  include/linux/rmap.h | 20 ++++++++++++++++++++
>  mm/rmap.c            | 15 ++++++++++-----
>  2 files changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 8068c332e2ce5..3f38141b53b9d 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -223,6 +223,26 @@ static inline int hugetlb_try_dup_anon_rmap(struct folio *folio,
>  	return 0;
>  }
>  
> +/* See page_try_share_anon_rmap() */
> +static inline int hugetlb_try_share_anon_rmap(struct folio *folio)
> +{
> +	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
> +	VM_WARN_ON_FOLIO(!PageAnonExclusive(&folio->page), folio);
> +
> +	/* See page_try_share_anon_rmap() */
> +	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
> +		smp_mb();
> +
> +	if (unlikely(folio_maybe_dma_pinned(folio)))
> +		return -EBUSY;
> +	ClearPageAnonExclusive(&folio->page);
> +
> +	/* See page_try_share_anon_rmap() */
> +	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP))
> +		smp_mb__after_atomic();
> +	return 0;
> +}
> +
>  static inline void hugetlb_add_file_rmap(struct folio *folio)
>  {
>  	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 5037581b79ec6..2f1af3958e687 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2105,13 +2105,18 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>  				       !anon_exclusive, subpage);
>  
>  			/* See page_try_share_anon_rmap(): clear PTE first. */
> -			if (anon_exclusive &&
> -			    page_try_share_anon_rmap(subpage)) {
> -				if (folio_test_hugetlb(folio))
> +			if (folio_test_hugetlb(folio)) {
> +				if (anon_exclusive &&
> +				    hugetlb_try_share_anon_rmap(folio)) {
>  					set_huge_pte_at(mm, address, pvmw.pte,
>  							pteval, hsz);
> -				else
> -					set_pte_at(mm, address, pvmw.pte, pteval);
> +					ret = false;
> +					page_vma_mapped_walk_done(&pvmw);
> +					break;
> +				}
> +			} else if (anon_exclusive &&
> +				   page_try_share_anon_rmap(page)) {
> +				set_pte_at(mm, address, pvmw.pte, pteval);
>  				ret = false;
>  				page_vma_mapped_walk_done(&pvmw);
>  				break;
