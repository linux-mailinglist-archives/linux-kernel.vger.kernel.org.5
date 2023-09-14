Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492F47A0BC2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239126AbjINRaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjINRaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:30:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1265D1FF1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694712607; x=1726248607;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MQuDSTYRc6Y90Y/PAV3+emteSzjJVjZNOJ8/9DuwrAs=;
  b=gTv9D88XHd7LEGSMS62abfXC0ZrqWt1ibGmZH04ZldCZefJOha5LN432
   wfgHEXDHc6J/aQEtiWpgNLTTm0Tc8z1FRCOpouj50CNgEznxN6rz1W47S
   Vgv4VuULLjsFhH2QDu3aSllcKa99zv9BBzkWeBs9CZLDMFbtkqxWTJVGW
   Pk0CcUk7jOo059k9sIXg3LVKx5PgXmFQyKMJAFDM5R8BZ2wF7Wbuns52Z
   SMaRjL5Gf1n/lll6ieyBZNJN6fOS9xJpwlgZ4uRTzfptgS/mE1PzEM/gv
   QwPg2PGkGDgxzvDL14RnldDgOYfy0w5o0dtEG4T3t7E6CUg8Qv17OuZXm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="369322298"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="369322298"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 10:30:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="773962178"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="773962178"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 10:30:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 10:30:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 10:30:05 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 10:30:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzM+Ux5lQvQtKYK7lhBI8ZYISEWBCboNv84NKqh0cWi0HrjBxPzCqV4Y079mtLwX1HdzzhSB+6bO/VKUgbb9QsTj1uf2M1eU8CN/aOGOVmOYIdqfcVM5WPNunoOdSD0ovATDC6lAvk0FgN3bWR2+XAg6jFhYuvzt6Ycw3n8G8BTOVUA6mMqQfw+xQMu8LWe7m1x72vVbM9HQu7MSCU29AwA/Um/wJ9kHgDXCxGbHdOgao59FfTHSZCdoZqLajGIFXCt9J7znO6Ta64sqzpKrVvTlIRjVt+Amdu2u7GaBy7HOXUL+gDhdxaERum2EALqFw+iODW/B++o21TBO16b6Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1jz2pT9NG2BdqdRzlF9xMJNWvxXNFRloEB0rT5jUqk=;
 b=cfNF9JjnL1uUwX4dhQndndHazjyko1wb3Ex14sdhDyApH4aN+IW2IupJBKx6hkkjlVi3uGT7wmLyZgsSXBXJmo8KOx54Nh733zXFa25gi4Aqbe2yMOZkclcjFxbiQIJ/9jezX61RGcArXw8gSyKNBxIWiOIX8R9GtKEigokpQp7U2vy4vuDLDJTjtWMskzyC4W2kvITa9mKvIrjKto91DfLEhGwCzrqpTNYvJ7Cc37lgWJ3/YWYRlk1FMf2sn82lVNYMlhWGcF964aRH+FUpn/85Y/WwH/Vg2F/Mx3afZ07H6t1ofjUvYidwF5HecIu4UYLxQopuQQEzdqgXNRSDAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM4PR11MB7325.namprd11.prod.outlook.com (2603:10b6:8:107::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 14 Sep
 2023 17:30:03 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 17:30:02 +0000
Message-ID: <138395ff-1ff0-bcbd-3636-a1b8cfbabd13@intel.com>
Date:   Thu, 14 Sep 2023 10:29:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH -V3 1/4] memory tiering: add abstract distance calculation
 algorithms management
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
        "Yang Shi" <shy828301@gmail.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
References: <20230912082101.342002-1-ying.huang@intel.com>
 <20230912082101.342002-2-ying.huang@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230912082101.342002-2-ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::24) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM4PR11MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: f0fa7330-1111-4c6d-ef6e-08dbb5483a25
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9jSAGbnw320bxHfOwuIgkLrV08aWpxwsBq/0VC8eaTNeD0EeybC+6FIp5B9f/Cy5FEq8mP1ED1p6HiFKiz0w3Ur0TexltcCl6n80A0f7ExTrfjCMC0aOja/dBkKTsEV0UXC3ZZGy27CL+TL7fuh716WCstB9yI+7l6ugi3G1OvlhtCjUEaK6//f1DiLyZhB5i0darbN6OUjz3M2UZono23sjJxNANpnRAjBSXzvvM2oi/JhtL7q81+2LX49YE0iIJWw7LVqE8Hg37AU+bLIBH8Z/v8283ecuC/GUlSqp9xO8L19gWwQ8va5TQDiDjQwGc9Gc3SuyxhmtlGY48nLmk0aLpwNcvwagL2p1FzA+vVTig9Sgh0afQr8kOB0JLi03OhFN1j50zjlDmGwIngyAaoJMrjaEoz7emjAgaklcdgQEI0WlHI8zq3xWzBlQhzeOAk547wiI761MwXHnScBTRfnqo06Rtz2PDXLZ3sVdgQbg4ExXW2ZOA0ssZ0spchhZ9YlEzJaL6fr2T6ziuSPGkoK7gj1aERsNGwE3NuW7bowv9bRCNQITV92cmzXA4BxxqDznKGxcFhaxfVKl9Y9F4RiurpMz5DFrQOww/bYKokV6kc91+sO5ysE9v6VTrZ8GeS1Syld2nrdQIie5odrndg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(346002)(366004)(186009)(1800799009)(451199024)(2906002)(316002)(41300700001)(26005)(107886003)(7416002)(31686004)(66556008)(66476007)(66946007)(44832011)(478600001)(8936002)(54906003)(8676002)(4326008)(110136005)(5660300002)(53546011)(6666004)(6506007)(6486002)(6512007)(36756003)(2616005)(31696002)(38100700002)(83380400001)(82960400001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUhkVHBsU2ZHWTF3VGp6NDBhQXU5L1RkZXcyY3JtdWtmcTlIWW81QUdJekFZ?=
 =?utf-8?B?RHBONW9JdXd4UVI4aDRMQjBNR2E3MklGUlh2TlRMQ1UwUHo1VTdQaS9TTzZJ?=
 =?utf-8?B?UHR6ZkdNSlAzeHU0czgyWWhXSVA3UlpyekZLczVWV1RKb243NFF4ZGZ6Y1k3?=
 =?utf-8?B?K1hER1ZsQlhkNXdzWnZSeFVzbU42MTZaNkJWVUxCQm5mbGF5Zk5iQ0FCVE1R?=
 =?utf-8?B?SlBTUU8xamxnMElCMzJOZWFwOFZTTndKZEIwNlVHdWhqSEtpSm13YVhydVFt?=
 =?utf-8?B?UXB2SStFZ1pZWFo2Qys3dWJST0kyczhiZmd1cWI5YzNxaHlhOGppNTZCV1Mz?=
 =?utf-8?B?Yi9YM1F2dnZEalZDdWYwUXNuMGZ1bjRJNWRHZ2pMZC8wc1J6NDE5Q1NjWHFR?=
 =?utf-8?B?YTNlOGFSWmJyWEl6bFRkalpqQXZmYVRodDdtbjlUbFdQMnUzMGxsZFAyZ2JJ?=
 =?utf-8?B?Yy9HdkswYnNtTmJFZWVOOGQ5TEc4bSs5OW10bllHUjF3WUkrVkNMRzEzTXlI?=
 =?utf-8?B?blAxL1ZqWEl4VTNvdGxmTFp4MHIxdHNZcDRpN3pYUGVHTFY5ajdyMXFMdnBT?=
 =?utf-8?B?eHc5S1BHMW13WDc4WUVTWmQ4eHc0SXRKN2ZEZjlGcVg5ZWpocENKNmRLY3M0?=
 =?utf-8?B?VFhFRGwxcEJPaFVmWmp6M3VQaDRWeXBGWGhwMUpnTG1maGFBNGtwN1FaK3dP?=
 =?utf-8?B?aGxQMUUrVVphb1RNWlFweENNc3lMb0dFaGVCL01Cc2ZPOHZ0RVJEbGdsNE8x?=
 =?utf-8?B?ak16UlRxb0JCOXVUdEdWL3NwMElLMnlJYWU3b2UxY1o2TjR6cnpEdUVFeGlk?=
 =?utf-8?B?WTBFczdaVS9iYTQ0VGp0ZWJjZzN2S1BadGlJenJUQjJzQnl5UzlSbnBvdDFI?=
 =?utf-8?B?L2VCWmRxMFp5T1dURmZJVC9GUHNCWGRraXdQSUVxYXVqWEFxMWl6bDdNdnNl?=
 =?utf-8?B?UGpYb2FRcjUvMC8zalV4WjQxbHMwcXpFTzg5OUNqTWpvSzFmblF1YmJUdlFa?=
 =?utf-8?B?RVNlMVF6M0luc29nZ0FKVmZmT0t0VGJtQTZJeWlBUUQ0ZmJVWXQybGtOMFdX?=
 =?utf-8?B?em9WK3l4aEZuQUpvRHQ4bkJBSnFGckxGK2FLQUkxQTMvMW5FNUJKT2RkRVhu?=
 =?utf-8?B?aHR4cExuQi80UG1TNHM1SWhCaitxWDk1aG05L2xOMkNvdnNHUHZWY2xmMktz?=
 =?utf-8?B?NlFoVjZsbW14YjhDNExMajNXTWx3M3hlMUhkT3FNMEV0YVJxQ25iRi9zVXFn?=
 =?utf-8?B?WDk2ckFqbFNPMXBiaGE0R3Z0SEFDOWUvYjBselRjV0Z0RXhCeGhTRTdKcW0z?=
 =?utf-8?B?Y28rSktHK2tLRDlCT3Yxc0wySTR1NlNsN202SWIzeDZlYzF3MkZpemYrVk9i?=
 =?utf-8?B?c0lVaEJwUUJTVFRJZHFSaE9JeVhBeXpQZ21KUS9XRTlBSWxQTUNEMG9DYUp5?=
 =?utf-8?B?RkJDdEZnSkJaSVZCdk1WQ2x5YmRNUEVNajVUVUlTNURCaFpxMk9FMWFvb2RC?=
 =?utf-8?B?bTY0Z0lueG5UakwxRXVuTUNiRkxaa2VMUENVOWhhOEp2S1ZaK0xKRzNMZXE1?=
 =?utf-8?B?SWVuN1ZmcjN1MUFMalJDdGd0OGlRcU5mWnVpSisrVTdZQ0JZZTNEK1psOUFV?=
 =?utf-8?B?dGhDWWUxVG5NRXZkUm55YXFkaWR1Z3F3TzhiRC9qOFpMSUVLVTBOamdTdlk0?=
 =?utf-8?B?UzFOUDRENkdkbkxYcnU3b1ZqUnBMRGh1KzcxVCthUnNLWlNwTUhBRHNmbjdr?=
 =?utf-8?B?VDlVSDRTWlFYNTh3Q29DNDlnbDJZQktsU2ZXNW56WUNwUVVWbGlWUHN6aHdS?=
 =?utf-8?B?WU1DWGkxUFhSek1vNGJIcGtuQ3lCVklEc0h5L1FUT1lGNmJ0WVF3Wk1EOWYv?=
 =?utf-8?B?MlNzQU1CVTFmUU96dVRubmdnbmNGNnJSRGQ2aTdCY0xDREpreHdIay9nL3Jk?=
 =?utf-8?B?NENDa3BmbGZ1c24vUUh5T2FEWENwcEFaakc1bHF2NlFYUENOc0tzNkpuOVdC?=
 =?utf-8?B?dW1XRHFCank1V2ZJTk8rUHZMaFlQd1pGa29iNGhheDZmU0NpdFRZbGcxWVo5?=
 =?utf-8?B?ckRRWCtSdDdOWHdEcitHMFlRencraDlKckRnQ2puYkd0UE51QTN5MUtZbEN3?=
 =?utf-8?Q?SZRxYi/f1fZUQ7URWpalIkk/l?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fa7330-1111-4c6d-ef6e-08dbb5483a25
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 17:30:02.5307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bSwvHTxQcVhuK0XQwnxTovL1als7jl4D7vYWHDm2fE7eL2nkaTdtptbVAJYujbT400T0o9pqE++ieuS8xSXBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7325
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/23 01:20, Huang Ying wrote:
> The abstract distance may be calculated by various drivers, such as
> ACPI HMAT, CXL CDAT, etc.  While it may be used by various code which
> hot-add memory node, such as dax/kmem etc.  To decouple the algorithm
> users and the providers, the abstract distance calculation algorithms
> management mechanism is implemented in this patch.  It provides
> interface for the providers to register the implementation, and
> interface for the users.
> 
> Multiple algorithm implementations can cooperate via calculating
> abstract distance for different memory nodes.  The preference of
> algorithm implementations can be specified via
> priority (notifier_block.priority).
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
>  include/linux/memory-tiers.h | 19 ++++++++++++
>  mm/memory-tiers.c            | 59 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)
> 
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index 437441cdf78f..c8382220cced 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -6,6 +6,7 @@
>  #include <linux/nodemask.h>
>  #include <linux/kref.h>
>  #include <linux/mmzone.h>
> +#include <linux/notifier.h>
>  /*
>   * Each tier cover a abstrace distance chunk size of 128
>   */
> @@ -36,6 +37,9 @@ struct memory_dev_type *alloc_memory_type(int adistance);
>  void put_memory_type(struct memory_dev_type *memtype);
>  void init_node_memory_type(int node, struct memory_dev_type *default_type);
>  void clear_node_memory_type(int node, struct memory_dev_type *memtype);
> +int register_mt_adistance_algorithm(struct notifier_block *nb);
> +int unregister_mt_adistance_algorithm(struct notifier_block *nb);
> +int mt_calc_adistance(int node, int *adist);
>  #ifdef CONFIG_MIGRATION
>  int next_demotion_node(int node);
>  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
> @@ -97,5 +101,20 @@ static inline bool node_is_toptier(int node)
>  {
>  	return true;
>  }
> +
> +static inline int register_mt_adistance_algorithm(struct notifier_block *nb)
> +{
> +	return 0;
> +}
> +
> +static inline int unregister_mt_adistance_algorithm(struct notifier_block *nb)
> +{
> +	return 0;
> +}
> +
> +static inline int mt_calc_adistance(int node, int *adist)
> +{
> +	return NOTIFY_DONE;
> +}
>  #endif	/* CONFIG_NUMA */
>  #endif  /* _LINUX_MEMORY_TIERS_H */
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 37a4f59d9585..76c0ad47a5ad 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -5,6 +5,7 @@
>  #include <linux/kobject.h>
>  #include <linux/memory.h>
>  #include <linux/memory-tiers.h>
> +#include <linux/notifier.h>
>  
>  #include "internal.h"
>  
> @@ -105,6 +106,8 @@ static int top_tier_adistance;
>  static struct demotion_nodes *node_demotion __read_mostly;
>  #endif /* CONFIG_MIGRATION */
>  
> +static BLOCKING_NOTIFIER_HEAD(mt_adistance_algorithms);
> +
>  static inline struct memory_tier *to_memory_tier(struct device *device)
>  {
>  	return container_of(device, struct memory_tier, dev);
> @@ -592,6 +595,62 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
>  }
>  EXPORT_SYMBOL_GPL(clear_node_memory_type);
>  
> +/**
> + * register_mt_adistance_algorithm() - Register memory tiering abstract distance algorithm
> + * @nb: The notifier block which describe the algorithm
> + *
> + * Return: 0 on success, errno on error.
> + *
> + * Every memory tiering abstract distance algorithm provider needs to
> + * register the algorithm with register_mt_adistance_algorithm().  To
> + * calculate the abstract distance for a specified memory node, the
> + * notifier function will be called unless some high priority
> + * algorithm has provided result.  The prototype of the notifier
> + * function is as follows,
> + *
> + *   int (*algorithm_notifier)(struct notifier_block *nb,
> + *                             unsigned long nid, void *data);
> + *
> + * Where "nid" specifies the memory node, "data" is the pointer to the
> + * returned abstract distance (that is, "int *adist").  If the
> + * algorithm provides the result, NOTIFY_STOP should be returned.
> + * Otherwise, return_value & %NOTIFY_STOP_MASK == 0 to allow the next
> + * algorithm in the chain to provide the result.
> + */
> +int register_mt_adistance_algorithm(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&mt_adistance_algorithms, nb);
> +}
> +EXPORT_SYMBOL_GPL(register_mt_adistance_algorithm);
> +
> +/**
> + * unregister_mt_adistance_algorithm() - Unregister memory tiering abstract distance algorithm
> + * @nb: the notifier block which describe the algorithm
> + *
> + * Return: 0 on success, errno on error.
> + */
> +int unregister_mt_adistance_algorithm(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&mt_adistance_algorithms, nb);
> +}
> +EXPORT_SYMBOL_GPL(unregister_mt_adistance_algorithm);
> +
> +/**
> + * mt_calc_adistance() - Calculate abstract distance with registered algorithms
> + * @node: the node to calculate abstract distance for
> + * @adist: the returned abstract distance
> + *
> + * Return: if return_value & %NOTIFY_STOP_MASK != 0, then some
> + * abstract distance algorithm provides the result, and return it via
> + * @adist.  Otherwise, no algorithm can provide the result and @adist
> + * will be kept as it is.
> + */
> +int mt_calc_adistance(int node, int *adist)
> +{
> +	return blocking_notifier_call_chain(&mt_adistance_algorithms, node, adist);
> +}
> +EXPORT_SYMBOL_GPL(mt_calc_adistance);
> +
>  static int __meminit memtier_hotplug_callback(struct notifier_block *self,
>  					      unsigned long action, void *_arg)
>  {
