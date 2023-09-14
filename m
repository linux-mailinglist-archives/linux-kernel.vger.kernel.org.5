Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024D77A0BCD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239456AbjINRcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239402AbjINRcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:32:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BFA2102
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694712726; x=1726248726;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7Xk0zT0EziXnUTiT2gf/zH3/Ph3X0ew0dMKDe5fFlnE=;
  b=OfFVVMk88BDKh5Sy8Ft9cBKVpWL0n+s6P66Ap615N5f+Dx8z6UKz9dsf
   u2DUBVDQgGGiSic6lqhYzlbtLfi8+sdRCwMNk0VnrVU8kx5yoJzoI9nSY
   YyS3HtnUCw8JnFkAd/AgbVu5q/1GEhp+wgRNkWenvysZOSAnF3kJyuwrX
   GHbwBH9X225gpPvqoDYN7zau3uK/0JXCirpiXSCdm9LsEW3hTCSWZzYpM
   WZNf5pBcxAru851PcegP/FhztwqOAIfTeMbL4nRxgVXwR6g+8hG208GEw
   QOjLDv99RpSW8v76XeEfZ1h5R2YnGKlf+qW5g/NpwiAYfWMvxwsVDV+3E
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="376359904"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="376359904"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 10:31:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="887898715"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="887898715"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 10:31:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 10:31:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 10:31:50 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 10:31:50 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 10:31:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y299hhri+xoHvfAc9YHCtYF6wF0HnWdTcMixm7tlCYStxv8FZhYg90VTm2/32m9ezEWoQdaC0O6sv3bqrUVFi4zl1bRTNVF+n/l5BVK73TumRomZ3fGhTD1QsXcgUs4xgvPZdEPDIWcXL75k2n0TGUzu6zkrCKFZ89u3flwYAm/qM+FWo7mrgu90kuy85b3c0FTE53GSGWMa19jakb5LyfvQpoE6s31iauaWiTCItVjIFgRy9e9XY0x1Xu7NFpvOtXe+6QJ98O8VyFaC6U7LmtSGkkqXzwHe1xUhjQU5KBTXbecVj7WBzCxJc08cKvUuw2n1g4Kg+G4KcBJHtNuk/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ERpHi3/xgaP15u8zoA7RT/n4IxdBKg5jXgVI9tL+24=;
 b=WfafXwKl3PzVDwQmkc73TBiyS6Zp+9remaMos223E9ahze/Ez7VrzgszxPuhamJBoeG+0vFQ6ySmDAmxbpo49FN1ZRRul27PA4w/1M56C6HA6yjZtzSgBf+Btuz2cZ6hb7HJoratXhsFVkqYVX98fGOdwu1VzcojEYt9fqKwAPScozzVl4aV4R6IZEMM8nUSv2RyRAUJBsedqIH1Exb27NNX4awCJz2+yBeuIQyfGxHELZ+LR35eFwmmwEQzmVL2TlSI5R3mXZdZBT9Tmpjyjcw/NsoW2CtOJzxG+Pvx7eE6vnc+zGjupgXbNSPxtkGQVMYhUULWpGsj0VVMoI0zuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH7PR11MB6476.namprd11.prod.outlook.com (2603:10b6:510:1f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 17:31:47 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 17:31:46 +0000
Message-ID: <a9e80092-ade3-cbbd-ea52-bf1d591897ea@intel.com>
Date:   Thu, 14 Sep 2023 10:31:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH -V3 4/4] dax, kmem: calculate abstract distance with
 general interface
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Bharata B Rao <bharata@amd.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
References: <20230912082101.342002-1-ying.huang@intel.com>
 <20230912082101.342002-5-ying.huang@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230912082101.342002-5-ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::18) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH7PR11MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: 392843a1-8f5a-4971-26c4-08dbb5487871
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aOsHzH6q1DAbb8OqgRl/Ccp2XWNY7vqRNWr5gtxbiupANeZZ2feuzqSH2x2/Nos9H3XoJO8EJ4r0BGbp0xSY/gHZ2GEu9j+7nnADpeCcnZvnf8Rpzmxv2jY+oRFbry6i8fb9ABciminPJ6LiKGozx8ayEQYAhyCVfUPabbJ4D9lwxORpR6z2fOhkbNpiprsk1714t2LAIuJo7fkvUdXE0Nh1esCld6ntKWPDTHftO/2p6697/UGGObuDgzhyEtsYVm/X8bSwXuOqkQwDSlbpiu5YSV9+ZF/om8eUIrFhxl/uBFs32B/H3JKHVNQsIsbSX2/t8hQ0S8dewE20eEMyojN0e1yMfLF1RL5y/2afv8L2wdyK1eug9I/ilIocpRVPHqR/WJ+YnyaSmo3mPBHZxuv6cC83mdH4PdZ0AUFvre4JJLhh011GGYDiVQ/lq9FGBIyvmU4ahDw/9U2oDq7gHaCWyclop5E4CAgncwUE3x6HCz+VGvYx8rwu4yd5UC0dlBAYdEPlduWQhF92ECcRS2Bw+mgj5J1Ry8GUnHbJDk3bclutpUPzp/l6DZcpk5FQmotn2dJdwi/Ey8jKIZbas4XFBqbc7lpE4zMV3RlhhPHrZV8i3AJbU04y8HWm+7cxaC1cnCUS6y1KcnYURC/Tbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(346002)(396003)(136003)(186009)(451199024)(1800799009)(7416002)(2906002)(36756003)(86362001)(38100700002)(31696002)(82960400001)(8676002)(4326008)(8936002)(2616005)(66946007)(5660300002)(26005)(31686004)(53546011)(107886003)(6486002)(6506007)(66476007)(66556008)(54906003)(110136005)(316002)(6512007)(6666004)(41300700001)(478600001)(83380400001)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUpiaXVJWTZVZ0NKVC9xOVZEMGlWVUlPSURhYStRMENKNWo1d1ZjNzZsaDdG?=
 =?utf-8?B?aW5NUVErd3AxYjRLUklRbG9IQUc4citheUtZN1hyWng0dzNRSG53YmRieVEy?=
 =?utf-8?B?SHJ5N2Eyc0t2UXVHc3VRR2RSb3lYM1dRUTRXSDNTR3I3ampUWjQ3ZE41eDZS?=
 =?utf-8?B?OW96MXM5SkQ3Y1VPYzFvcUh3Uk10UEp2OFVhdjIwcDlxeXpPZ0hGZGFJeFpz?=
 =?utf-8?B?Nkk1bS82aGZqRE9XSkhzVnBuSXlwbkMyakw1MlJPYVlCcWk1b0lMUTVYQXpV?=
 =?utf-8?B?bVFHWGlpcW9IK0tnaEpibCt6TUh2bHlLTHAyamEzMVlQSlVNZnJxN3dpVnIz?=
 =?utf-8?B?YzVtb1FVSTlBOEt1ZHBGYTRPM1lNOWNkUzl5eWI5dzVYN2NnNGRlVGNFWUE1?=
 =?utf-8?B?ei9hVm5zM2tkayt4bCtjWmY1aEhGeFR5UWdvR2orUXBJS1orb3ZvSEFlZUww?=
 =?utf-8?B?SEN5TnVMSllhbmI1eWd4TFBPVlNIY3o1Y0ZsSU1tODgrMUo2Q3dxWGNFa3N0?=
 =?utf-8?B?QTBPeHQxRmJhYmE3UjB5eFgvSDRYZ1YwUnNTK2o5eUF6R0pmb3JIV3pzYzh3?=
 =?utf-8?B?MlVSK1NSSjQ5eGpVUW40WFNiOHlNNXJ6VjlFaEpCUkNGUStsdTBrRmFDWmxz?=
 =?utf-8?B?ZW51R0hlb3lnZlAvdnNsbHdTeFBFekNjd3JhamtzYnZzLzdtY0EwZmh3cHNK?=
 =?utf-8?B?OEd4Q3BUZHRFbEpiYjZxbXBWMmdhWXlUSU80WjROaUY3Sk96Y0h5OXNJSDFG?=
 =?utf-8?B?ZGg5OUwxM2laWkdCU3dDTWRkTDdHN1hFbDVkSHRuU2ZJOFMzNkdDWmlpeUc5?=
 =?utf-8?B?Ni9HWkdZSzNMTHcrQkhNbnBZOTVMdzk5WkJpU09KRlZka2l3RGhIRDRzaDFx?=
 =?utf-8?B?dHErWHdBdGw5eitJVElEWTB2Ni9JN2NsbEtZV2EvazV5dDkrR1YzQTlXYnJ4?=
 =?utf-8?B?UmF5MnRZY3NDeVVsc1pFZXlHbjh0N2RSWk96TjRab0tMV0JCa1o4RGVjdStX?=
 =?utf-8?B?YndJSnh4MTVpTFVJSmd5R3ZlM2Jpak9FQnhRZ3pKSEdBK3JOREdPbmhGUmts?=
 =?utf-8?B?TFk0NlV5SFYzMmd2cFRnK1c4Ky9PMHBBK1VaRkFiTXpIQktBSHdURkJnRDJJ?=
 =?utf-8?B?RW5YTVZmZ3FGNEg1dEovQjNlTFB5alN6WVd4QzZpYk5QVFgyZ3dGdHViRmMr?=
 =?utf-8?B?VTBCKzBvNkV1bHFDWUV1SzBveVJOcklqQVZBTXprMDBBWlRvblNqSStLVnlL?=
 =?utf-8?B?dXUzeE9BbERpM1gyaXF6ajJiTnhLOCt3cnNkYUpRLzk3VmQ0MWlZK005Z25S?=
 =?utf-8?B?OXNhQm5NTGNObGY4eHVEY21nWVlpNm1pTVBrUnZ6c3UycUVrNmw2N1Q4WDRG?=
 =?utf-8?B?K09TK1ZiVjAwMU1FNEhwOEZjVU9nNzhzNU1pYnlGRjRnOTJML0p5WTNNYkVE?=
 =?utf-8?B?d3czZlBBczVkT0gvZ0RHQnBkWkxEWlBOcGR3ZUQ2UExiakRpQmRBbno0NzBx?=
 =?utf-8?B?Z3hEVEZlUGZxMFQ0VFlCWVhlVGJkMkloRzVLV0dvVnVKMHdPcDFNb0R3L1VQ?=
 =?utf-8?B?cHlPZnVRTThSeGl0Q2N5UUlDU0wzRmRKOG5Ma09heDJ5RHNEazVDYU1ZYW1H?=
 =?utf-8?B?djBLTCtRcHIzZGU5L2RyVDcwa2xkOXkvbnhuZmNkWjBNNzRFRlpHSk9Vc3JW?=
 =?utf-8?B?NE5DRGNDcUREcWpzV2IxbSttN1VYNUNxS2tVKytJN045alFvdVFUM29HQk92?=
 =?utf-8?B?SnF2OU84dWd0eU50QkVHN0JOYWRkb0V0WUxVay9FdnlTWkkzNlRmZzhuYzMx?=
 =?utf-8?B?V0Jra3hzWnU3U2NpUG9vYXEzSGhhVlpURGVoQUZPdG5DM0FURGhTTU9mYmtu?=
 =?utf-8?B?U3FsdTJGODAxd1d0WWg3M1dCbDF0L3dHOVpTTFllakphQlNjL3ZVd2JsSjVD?=
 =?utf-8?B?ODMvU09IWEpuK1FZMVluTGxmeFVmMFA5a0NuRnNFK2RPdklGRmkvUnIzNUxq?=
 =?utf-8?B?L0QxRzhmME02QUtMbDRVbGJsdkVMODNpOHUyZWtCbU5ZYVJxT05xOEVJc05B?=
 =?utf-8?B?dWJCWi9Oc1p2TTV5WUoyTmJkTUtobkc2MDUyZjJnZGlSR0RrZUlvemxPU3li?=
 =?utf-8?B?alJrUDU4N0lLVmZDS0VlQUdXZWx0VnVpZnA1T21GOVo0em94SVBYNkdlUWdB?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 392843a1-8f5a-4971-26c4-08dbb5487871
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 17:31:46.7623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASmN57I54iqk9GIJcbn8lQGDoRg/ZuEdtbLwCZATtDKS4GMnRFBZB2NW8f5K5HucC4jIjlsoCxkgmkBrGbJGbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6476
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/23 01:21, Huang Ying wrote:
> Previously, a fixed abstract distance MEMTIER_DEFAULT_DAX_ADISTANCE is
> used for slow memory type in kmem driver.  This limits the usage of
> kmem driver, for example, it cannot be used for HBM (high bandwidth
> memory).
> 
> So, we use the general abstract distance calculation mechanism in kmem
> drivers to get more accurate abstract distance on systems with proper
> support.  The original MEMTIER_DEFAULT_DAX_ADISTANCE is used as
> fallback only.
> 
> Now, multiple memory types may be managed by kmem.  These memory types
> are put into the "kmem_memory_types" list and protected by
> kmem_memory_type_lock.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Tested-by: Bharata B Rao <bharata@amd.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Rafael J Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dax/kmem.c           | 62 ++++++++++++++++++++++++++++--------
>  include/linux/memory-tiers.h |  2 ++
>  mm/memory-tiers.c            |  2 +-
>  3 files changed, 52 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index c57acb73e3db..369c698b7706 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -49,14 +49,52 @@ struct dax_kmem_data {
>  	struct resource *res[];
>  };
>  
> -static struct memory_dev_type *dax_slowmem_type;
> +static DEFINE_MUTEX(kmem_memory_type_lock);
> +static LIST_HEAD(kmem_memory_types);
> +
> +static struct memory_dev_type *kmem_find_alloc_memory_type(int adist)
> +{
> +	bool found = false;
> +	struct memory_dev_type *mtype;
> +
> +	mutex_lock(&kmem_memory_type_lock);
> +	list_for_each_entry(mtype, &kmem_memory_types, list) {
> +		if (mtype->adistance == adist) {
> +			found = true;
> +			break;
> +		}
> +	}
> +	if (!found) {
> +		mtype = alloc_memory_type(adist);
> +		if (!IS_ERR(mtype))
> +			list_add(&mtype->list, &kmem_memory_types);
> +	}
> +	mutex_unlock(&kmem_memory_type_lock);
> +
> +	return mtype;
> +}
> +
> +static void kmem_put_memory_types(void)
> +{
> +	struct memory_dev_type *mtype, *mtn;
> +
> +	mutex_lock(&kmem_memory_type_lock);
> +	list_for_each_entry_safe(mtype, mtn, &kmem_memory_types, list) {
> +		list_del(&mtype->list);
> +		put_memory_type(mtype);
> +	}
> +	mutex_unlock(&kmem_memory_type_lock);
> +}
> +
>  static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  {
>  	struct device *dev = &dev_dax->dev;
>  	unsigned long total_len = 0;
>  	struct dax_kmem_data *data;
> +	struct memory_dev_type *mtype;
>  	int i, rc, mapped = 0;
>  	int numa_node;
> +	int adist = MEMTIER_DEFAULT_DAX_ADISTANCE;
>  
>  	/*
>  	 * Ensure good NUMA information for the persistent memory.
> @@ -71,6 +109,11 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  		return -EINVAL;
>  	}
>  
> +	mt_calc_adistance(numa_node, &adist);
> +	mtype = kmem_find_alloc_memory_type(adist);
> +	if (IS_ERR(mtype))
> +		return PTR_ERR(mtype);
> +
>  	for (i = 0; i < dev_dax->nr_range; i++) {
>  		struct range range;
>  
> @@ -88,7 +131,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  		return -EINVAL;
>  	}
>  
> -	init_node_memory_type(numa_node, dax_slowmem_type);
> +	init_node_memory_type(numa_node, mtype);
>  
>  	rc = -ENOMEM;
>  	data = kzalloc(struct_size(data, res, dev_dax->nr_range), GFP_KERNEL);
> @@ -167,7 +210,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  err_res_name:
>  	kfree(data);
>  err_dax_kmem_data:
> -	clear_node_memory_type(numa_node, dax_slowmem_type);
> +	clear_node_memory_type(numa_node, mtype);
>  	return rc;
>  }
>  
> @@ -219,7 +262,7 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
>  		 * for that. This implies this reference will be around
>  		 * till next reboot.
>  		 */
> -		clear_node_memory_type(node, dax_slowmem_type);
> +		clear_node_memory_type(node, NULL);
>  	}
>  }
>  #else
> @@ -251,12 +294,6 @@ static int __init dax_kmem_init(void)
>  	if (!kmem_name)
>  		return -ENOMEM;
>  
> -	dax_slowmem_type = alloc_memory_type(MEMTIER_DEFAULT_DAX_ADISTANCE);
> -	if (IS_ERR(dax_slowmem_type)) {
> -		rc = PTR_ERR(dax_slowmem_type);
> -		goto err_dax_slowmem_type;
> -	}
> -
>  	rc = dax_driver_register(&device_dax_kmem_driver);
>  	if (rc)
>  		goto error_dax_driver;
> @@ -264,8 +301,7 @@ static int __init dax_kmem_init(void)
>  	return rc;
>  
>  error_dax_driver:
> -	put_memory_type(dax_slowmem_type);
> -err_dax_slowmem_type:
> +	kmem_put_memory_types();
>  	kfree_const(kmem_name);
>  	return rc;
>  }
> @@ -275,7 +311,7 @@ static void __exit dax_kmem_exit(void)
>  	dax_driver_unregister(&device_dax_kmem_driver);
>  	if (!any_hotremove_failed)
>  		kfree_const(kmem_name);
> -	put_memory_type(dax_slowmem_type);
> +	kmem_put_memory_types();
>  }
>  
>  MODULE_AUTHOR("Intel Corporation");
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index 9d27ca3b143e..ab6651402d7e 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -24,6 +24,8 @@ struct memory_tier;
>  struct memory_dev_type {
>  	/* list of memory types that are part of same tier as this type */
>  	struct list_head tier_sibiling;
> +	/* list of memory types that are managed by one driver */
> +	struct list_head list;
>  	/* abstract distance for this specific memory type */
>  	int adistance;
>  	/* Nodes of same abstract distance */
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index fa1a8b418f9a..ca68ef17554b 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -586,7 +586,7 @@ EXPORT_SYMBOL_GPL(init_node_memory_type);
>  void clear_node_memory_type(int node, struct memory_dev_type *memtype)
>  {
>  	mutex_lock(&memory_tier_lock);
> -	if (node_memory_types[node].memtype == memtype)
> +	if (node_memory_types[node].memtype == memtype || !memtype)
>  		node_memory_types[node].map_count--;
>  	/*
>  	 * If we umapped all the attached devices to this node,
