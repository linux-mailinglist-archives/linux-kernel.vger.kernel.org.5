Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827F77A0BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239269AbjINRat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235226AbjINRar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:30:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927071FF1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694712643; x=1726248643;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TGECX17ZjjlnaattN6bf6I1cp5wGfbZxVdI+ySe+QDs=;
  b=F08lR5fpxeEyLE+irZuunFBUULwBYE+YtYZENDEMJspU7GiHSkPko3X6
   1a+KoF8GosMkFFnKlP8sxjOf/NcP13TTm8JBRiVg+q9fvBIGfr9uZAQhj
   mr9x1MoneEbsDDpUVTfHuVzAwULgau8QhOfTeF6P6iILgrP9wlN3gKA4x
   9qGseTkJjyn51Y2FGVx0dVKRElig4q2xyLAPPVDYL9q+r8VZ9ijSSPdIq
   xbBAtka1akMMXD9Swk1ZmE400/A6u6mq+7aVS6Pzw5YIjUgF/iRYpgVuw
   P/ckqy7GedYQ/phuGPghIzdukCBO8urLrZZRJ4MIjr0oI+9X1hZbeY5Pk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="381738775"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="381738775"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 10:30:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="834823070"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="834823070"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 10:30:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 10:30:37 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 10:30:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 10:30:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 10:30:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BP5DJQ3Vpr+GIjPEFAsEr6Bi+aoUXj7BiKIb+9romQKbSbJqao4WUImAdDjDAkKg24HJju47U2qkmA8gnvL4eG1EsanS/y/yKDk5MpLIIa+2P9uXkqtXfetIz5JnBNw719en3hmp2AfDQtl/SY0mEugaBH3F18oSLsqCiK6D1dM1gksPJqP7e0ZeHNcDFDFvpLVNlcXgORiaJybD2PmLGAOqp5ULIXoVwhnNb4EOAgaprYbdsGO/TIQjhmnYjuk67tqKDQJYZgEWoTNpSxkZKCd3GdR/KrHzKWm4XuTtz0If+hcVbbqdGoR1VSjfgoAdfqxF0skzBznSnWEGVyOVxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8IpajMHtnHSqqfZkhb3Ksbiy8HvOHZy1bUhnJhDHjA=;
 b=P7WvLFWG88pKBDAcRbbG+mUDvc+5yreEUrTTcDP4rPR0G1CdKpuFUuKFyJVaWTRvpFs13+Nqu1qY8auHKzgJZAJcv9NWJktVzaGwY5yagrwPtcRuBjOTqAbaZM+pt7BF0W7EkiyUewOd8pG1K+XHSoH2rhSDjDJ+kRbwnFoMQpCibV5NBW3vlTB8jNa93AGdB1FZi323jn9SwDSdpRFAEUfJUYXkqVDhWJZpKhhjv2UbJCZYWlwZgzWFI90bKzb4gSRQg8UyL792Ey7SiZA1QjqSqQ18u1dZhr5CJdOzomB5QPsa5n4jmuKQip9bGE6MvPjfty+y0Jv27E2WLFDJHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM4PR11MB7325.namprd11.prod.outlook.com (2603:10b6:8:107::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 14 Sep
 2023 17:30:29 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 17:30:28 +0000
Message-ID: <3789af53-959e-1c55-c6c1-175bbd7e349e@intel.com>
Date:   Thu, 14 Sep 2023 10:30:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH -V3 2/4] acpi, hmat: refactor
 hmat_register_target_initiators()
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Bharata B Rao <bharata@amd.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
References: <20230912082101.342002-1-ying.huang@intel.com>
 <20230912082101.342002-3-ying.huang@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230912082101.342002-3-ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::26) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM4PR11MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: 614a854e-1a31-4ac0-6232-08dbb54849cf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mtwxl7gjSmgf0g1WHRM9rjKPQ6FPHpnqfmxglexIn/7iOsSWq9R1YSBL9xS0yH6guw4/BKtrnBbFGCMA8CRiwgLGqCgYWrKHlAG9esSXMrPLSkwfcxSgsJs5nhZNDT3bVqnis9c8vcRXTuRoPnnrWZTpKbnsN9CHKxi8Lx6UVIzn+JaaU3fCsymi2ccrvTUDKFYwItjPIsxgz5uLYbT8isuFppdASK+IcfHa+qgbib2AKEOOb9lL4Z0JkT5B8I3tWKT3406KqRR0paeC0H5KKW1aAVHr/9EpGYPNEn04hxDnpru8cgevnq2wPDc1yIhV6Qiql7YtuEhiFk66CJ1JTRpkLsz1kYmUYOnDAvqAUY2cDU7EQjelFHku7AfyRCM5IhydcYM/xl81V8fpdMMNsmoMggqvDarZZbu/3NWy3C1YgmdX2Y6GXyYIvxDNkL03BMsv6VWLNOJ/7uvCGoAdltIicH4+agigMoKueJluhg0sKV8bXyVOwR2gCKPQjxa0/WXxy2MFi6w4buJbtTfgWbUIglTu/+nhpV5uUH2vO64aTfn3ZhYmdCv4ziGoZMb6LKGK4Nm/SG1kypnyIyBDg6fI4zEG9jjQazeldeeToeyuCfYiWWbSFu9SUXi5nVH0UvvGgJEeJMxsQKKSny+x9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(136003)(346002)(366004)(186009)(1800799009)(451199024)(2906002)(316002)(41300700001)(26005)(107886003)(7416002)(31686004)(66556008)(66476007)(66946007)(44832011)(478600001)(8936002)(54906003)(8676002)(4326008)(110136005)(5660300002)(53546011)(6666004)(6506007)(6486002)(6512007)(36756003)(2616005)(31696002)(38100700002)(83380400001)(82960400001)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1BGQnZOdkJmZWpxUzhxeU1qQWVQNU9vaHQrRzJGOFk1U0hTU0xuQzdCVzQr?=
 =?utf-8?B?TTZIUWdHZ0t0Y0RmRFhaSkN1VGpuYVhENUZaQWVOTml6WS9kVUhjM1A2czcy?=
 =?utf-8?B?aEg2Q2F4c1g5Rk9aTEloTHM5dy85U1VIQnF1dzZmMExtUnV6RHpvVFlhWnNR?=
 =?utf-8?B?MktMSFMrWGVFVUt4VWhTRTV0d0gxN1FuV2hUUWtNSi85YlZrNXVvbk1oRXVt?=
 =?utf-8?B?cjdBVExqbHF1SWNMSm0rMmxTNUVDc0JnYXB2OWFySWRmbXVHaHc0MGJQRjRD?=
 =?utf-8?B?ZTVSMjZOZ0twY2wrY2hwQjNhd3hzU2QvenJMb2RpcWk0ZU4yNDVsZzdDYzdP?=
 =?utf-8?B?cUc1amFiUWZybnBpMDlGZFA0Qjk3N0M0VTAvdzBGaEtacS8vcHNBeW9xVk56?=
 =?utf-8?B?NHhHMmRjMGQ4ZXNiNmgzQzUrYmlYY0tWSkN5dE5ZWURKRVE1K2UxdVdoQkVY?=
 =?utf-8?B?T3o3WUV5SXdvMXhxWHRyQTNjakhOOGlFdjRyOHRXVzBtU1VXTzVTM3FPVGFa?=
 =?utf-8?B?ZVRtclJtaXFZa0FwczNxN1NXU21maTVGM2prTHQwVzZiYzBDNTBKSVA4dWRC?=
 =?utf-8?B?RGxmVlJUSVVmWDMyUmxkMVB0alV1eXQ2UFByZU00b3lyWFBHUU1CWlpPbFBq?=
 =?utf-8?B?TlMwZVJ5KytKRFJzSHMzNjBNQjFybDRxQXNNY0kxazJua0VjeW12Y2FJdGE4?=
 =?utf-8?B?Q2NjZndQbkdNeDRqdWFBSFl5NkVzTnliRGNMU3YxUUdhRHBQdUV2ekZEZkxm?=
 =?utf-8?B?YVhhd2gxODRTVURWQlI5NWhBMVlLUnByK0pQQTdRVk9wV3BXZTg3YXVqQWt3?=
 =?utf-8?B?dmFYV3JwYmhNczBFRlZTUHpLS0hhOXN1YWJWay80dW9LclV2cUl0TStwZFdM?=
 =?utf-8?B?RXR0Nkg1VHdjdGc5SGFpUjZNemdRSTMyQVI2MnR2aU9oMS9mZDc3bUZEMmU3?=
 =?utf-8?B?cjBKNlYxQWhmRzZCVEhwOTVVVEhOazNvSFIySExIMEpobDNRSkFjOWxxdHFa?=
 =?utf-8?B?WXkrSnd4TGF0MGtqdjkrVVYxZGt5UE00cjgrVjVmNXk5czk1eTN1S0l3L2I3?=
 =?utf-8?B?aXY3Ung5d0lKMHhuRnJ5dmowRGxUZmFWNC9TZTRpMGo3bFV2YWhuWXZVN1Yz?=
 =?utf-8?B?Zkp1TXJ0RUZha1hXcWd1U1I4a3dkanVXUXFLRDJhZFpjUUZ1bVR0Q3Jxcm9X?=
 =?utf-8?B?UEhHS3ZQQ2dtUnpvSEI0V0dDSmdrSWcySVp6Uk5jSStmSDhyOGNlM04vUE8x?=
 =?utf-8?B?bGlqblBpL3JNcXp4ZjRCVlBIYkNhWEFxc2lOZ0hGcWovZVA1WEI3cG44L3Rv?=
 =?utf-8?B?WFk4SGNZdmFjcmZvbGIzK3lrTGFHbWQvYXZiR3QwSHp6UTUrS2pDN2tRSFc1?=
 =?utf-8?B?b01kdVJDeHFrT0tidDlFdWgrOTdFQlRJeVY2a2dYSE8xeTBDdktiRnJHc0p2?=
 =?utf-8?B?eEJXTjJRQ2E3MnZEN29LeDI2WUVIcklmZUV0bkVoQllCTTg1UGFnVVJxZzFt?=
 =?utf-8?B?OVVDR0MySjU1ZDJqUFRlVHVKUkRkVnRkZ1g5TnhkMVJoc3ExNzI0alRyK0lt?=
 =?utf-8?B?NCtEbUJnT2ZoQ1ZmTU00NkU3Q012TGRHVEVBUWQ1ZXhkM3ptWXpHL21MOGVQ?=
 =?utf-8?B?SGZWekc2c0NWTEZaTktmSGhwQ0tUT2V3MGh6dXZNNHU4bFR6MDhCNUhnRUNp?=
 =?utf-8?B?Zm5ERHVvSC9IN2EwS09naHl1dnZqTHpOZFhXdlp4ck1zajJKVHBwY0htUFpk?=
 =?utf-8?B?SFMrL1A1MXhxKzFRTkhFdnVUQjV2T1pJalNwNjY1d3pUcDM5cldjN3RndFFo?=
 =?utf-8?B?bW1rNU5EcWlaUm5sZXZrcTJuSWRZeGcwNFltQlQ3VVh2K3RIVEZ4bUQ0UWF1?=
 =?utf-8?B?T0xKTGJxNGlVdlpESmZZMDZvMWpsRWdMc1NWdG5QcXJ4UzNLMWpxYmpKdUZr?=
 =?utf-8?B?UTlGdHRaMTFybUlkKzJUUTN3S1pGOXd0QzZObVBBTlhRQ243cFBqZUdUdFhD?=
 =?utf-8?B?amRJUXFQekc4c3FZM1NtbEE4bGdrOUhSVjY3UEx5bEJOcGoyamFreWkzc25L?=
 =?utf-8?B?WHFDL1JIZ0lZV2lsVFRJWTFHaGpzVEMydE1TdVJVYmM2YU4zRkV6bjJtME9X?=
 =?utf-8?Q?UxtHHq+3ybHkIrL9nGlXnBGDC?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 614a854e-1a31-4ac0-6232-08dbb54849cf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 17:30:28.5317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ow2Zfl89uUJLceIgPme2kRF1i5VqUhTYnQfgy3oHTS+zt5aPXPS7e2rDqQIiZpBIEL7k1uqcu2snsb4lB8kjyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7325
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/23 01:20, Huang Ying wrote:
> Previously, in hmat_register_target_initiators(), the performance
> attributes are calculated and the corresponding sysfs links and files
> are created too.  Which is called during memory onlining.
> 
> But now, to calculate the abstract distance of a memory target before
> memory onlining, we need to calculate the performance attributes for
> a memory target without creating sysfs links and files.
> 
> To do that, hmat_register_target_initiators() is refactored to make it
> possible to calculate performance attributes separately.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> Tested-by: Alistair Popple <apopple@nvidia.com>
> Tested-by: Bharata B Rao <bharata@amd.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Wei Xu <weixugc@google.com>
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
>  drivers/acpi/numa/hmat.c | 81 +++++++++++++++-------------------------
>  1 file changed, 30 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index bba268ecd802..2dee0098f1a9 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -582,28 +582,25 @@ static int initiators_to_nodemask(unsigned long *p_nodes)
>  	return 0;
>  }
>  
> -static void hmat_register_target_initiators(struct memory_target *target)
> +static void hmat_update_target_attrs(struct memory_target *target,
> +				     unsigned long *p_nodes, int access)
>  {
> -	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
>  	struct memory_initiator *initiator;
> -	unsigned int mem_nid, cpu_nid;
> +	unsigned int cpu_nid;
>  	struct memory_locality *loc = NULL;
>  	u32 best = 0;
> -	bool access0done = false;
>  	int i;
>  
> -	mem_nid = pxm_to_node(target->memory_pxm);
> +	bitmap_zero(p_nodes, MAX_NUMNODES);
>  	/*
> -	 * If the Address Range Structure provides a local processor pxm, link
> +	 * If the Address Range Structure provides a local processor pxm, set
>  	 * only that one. Otherwise, find the best performance attributes and
> -	 * register all initiators that match.
> +	 * collect all initiators that match.
>  	 */
>  	if (target->processor_pxm != PXM_INVAL) {
>  		cpu_nid = pxm_to_node(target->processor_pxm);
> -		register_memory_node_under_compute_node(mem_nid, cpu_nid, 0);
> -		access0done = true;
> -		if (node_state(cpu_nid, N_CPU)) {
> -			register_memory_node_under_compute_node(mem_nid, cpu_nid, 1);
> +		if (access == 0 || node_state(cpu_nid, N_CPU)) {
> +			set_bit(target->processor_pxm, p_nodes);
>  			return;
>  		}
>  	}
> @@ -617,47 +614,10 @@ static void hmat_register_target_initiators(struct memory_target *target)
>  	 * We'll also use the sorting to prime the candidate nodes with known
>  	 * initiators.
>  	 */
> -	bitmap_zero(p_nodes, MAX_NUMNODES);
>  	list_sort(NULL, &initiators, initiator_cmp);
>  	if (initiators_to_nodemask(p_nodes) < 0)
>  		return;
>  
> -	if (!access0done) {
> -		for (i = WRITE_LATENCY; i <= READ_BANDWIDTH; i++) {
> -			loc = localities_types[i];
> -			if (!loc)
> -				continue;
> -
> -			best = 0;
> -			list_for_each_entry(initiator, &initiators, node) {
> -				u32 value;
> -
> -				if (!test_bit(initiator->processor_pxm, p_nodes))
> -					continue;
> -
> -				value = hmat_initiator_perf(target, initiator,
> -							    loc->hmat_loc);
> -				if (hmat_update_best(loc->hmat_loc->data_type, value, &best))
> -					bitmap_clear(p_nodes, 0, initiator->processor_pxm);
> -				if (value != best)
> -					clear_bit(initiator->processor_pxm, p_nodes);
> -			}
> -			if (best)
> -				hmat_update_target_access(target, loc->hmat_loc->data_type,
> -							  best, 0);
> -		}
> -
> -		for_each_set_bit(i, p_nodes, MAX_NUMNODES) {
> -			cpu_nid = pxm_to_node(i);
> -			register_memory_node_under_compute_node(mem_nid, cpu_nid, 0);
> -		}
> -	}
> -
> -	/* Access 1 ignores Generic Initiators */
> -	bitmap_zero(p_nodes, MAX_NUMNODES);
> -	if (initiators_to_nodemask(p_nodes) < 0)
> -		return;
> -
>  	for (i = WRITE_LATENCY; i <= READ_BANDWIDTH; i++) {
>  		loc = localities_types[i];
>  		if (!loc)
> @@ -667,7 +627,7 @@ static void hmat_register_target_initiators(struct memory_target *target)
>  		list_for_each_entry(initiator, &initiators, node) {
>  			u32 value;
>  
> -			if (!initiator->has_cpu) {
> +			if (access == 1 && !initiator->has_cpu) {
>  				clear_bit(initiator->processor_pxm, p_nodes);
>  				continue;
>  			}
> @@ -681,14 +641,33 @@ static void hmat_register_target_initiators(struct memory_target *target)
>  				clear_bit(initiator->processor_pxm, p_nodes);
>  		}
>  		if (best)
> -			hmat_update_target_access(target, loc->hmat_loc->data_type, best, 1);
> +			hmat_update_target_access(target, loc->hmat_loc->data_type, best, access);
>  	}
> +}
> +
> +static void __hmat_register_target_initiators(struct memory_target *target,
> +					      unsigned long *p_nodes,
> +					      int access)
> +{
> +	unsigned int mem_nid, cpu_nid;
> +	int i;
> +
> +	mem_nid = pxm_to_node(target->memory_pxm);
> +	hmat_update_target_attrs(target, p_nodes, access);
>  	for_each_set_bit(i, p_nodes, MAX_NUMNODES) {
>  		cpu_nid = pxm_to_node(i);
> -		register_memory_node_under_compute_node(mem_nid, cpu_nid, 1);
> +		register_memory_node_under_compute_node(mem_nid, cpu_nid, access);
>  	}
>  }
>  
> +static void hmat_register_target_initiators(struct memory_target *target)
> +{
> +	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
> +
> +	__hmat_register_target_initiators(target, p_nodes, 0);
> +	__hmat_register_target_initiators(target, p_nodes, 1);
> +}
> +
>  static void hmat_register_target_cache(struct memory_target *target)
>  {
>  	unsigned mem_nid = pxm_to_node(target->memory_pxm);
