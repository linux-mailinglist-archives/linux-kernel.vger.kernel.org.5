Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAAC3798ABC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 18:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244456AbjIHQhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 12:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjIHQhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:37:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C5F199F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 09:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694191062; x=1725727062;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kZT1v5ON3mWMRXJl1UWG7DUFqTCDg1QgSuM8SSc9gMk=;
  b=Wp8UkuyGeAz+poVV46rznqwwWgCtHnHEeDXSlGROdGRJyP3jvr8LTaUG
   dwyptyRXRneEiiJUP7uTHc8baKMODiQFJTRsEqb2z/YZb0B9yK7IX1kuq
   519nDQx7CO/32qG6Uv1z9JTSmZP0cbhcwGmRoosTVGo/RnlW15M4Pd3cK
   qAICix1M6wJpglM6WuF6oFvsoj7ZhposX6c/8ku4rqzBRXve2vZ77DsVw
   JQ+ujA9DFVWcXS1jFLcaNgF5GsadAywcpkE5Jto14kEGOs4vTLD+Ny9Ul
   YnG2u7DW3NokgplJY0ZA0dBnJPDvs2TxBXTXY8VNcF59ZeoKAqwF3gucy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="377600458"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="377600458"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 09:36:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="832716370"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="832716370"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2023 09:36:51 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 09:36:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 8 Sep 2023 09:36:50 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 8 Sep 2023 09:36:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=meZuEUb4wJ7YTjeTvmlWO9kvQ3qOXClcUA31YguQtZXW0bXFL+L2SoTs8HPDjG3UxNDpJCMLXso1TZuCVmUDuY4eP7qFyZeWKiFJEFlhMpBEBgw+Lcob1eAhHsJxRqZkwLiJ69iHKPMQp+EylT4wgOlH3igGKuyhJkQjRJXmYtbzjOXJzlvsQ8bZ8k1QcEye/GcOovfrQmxdnYwigeEPADJolT6RlwZJfDSVizPEKZ23AIFkHbkNlcUqjXL6xXwJce8CZN7xeU7QJrGiHpYbLvjTxulv212XYWIp+7De/yUN6YDD4BUFnw2BEx2YpsHkrDuEPn9G+HXIY9R7yqgBlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OU8XhECTyhqpn5k41qDBagQZslth6CsMz2nExV8VY+I=;
 b=ZZur2KIm7IbxG6qdystplvF1MGcn4sJ3SzZhf6tSHH+CE0GjZ79ccMDOx+1HQ6POMNH/+jyZFsuYOnpJOSfOhwZbe3MxmncRG8zd5W5etSFUtypghhqAaVhhfQHcY3SyjJG0xaoD8hT3DeYHUWDfH+QpG3N/mfW7IvCPpqG/Drlm+aWW1qDdfPT4taRCj81JLVz5i739EV4fuSQhBeUqsuYBqAbXFACmdjyl0vd0BSTxUXWcyw7abmYECfdOvkgkjoEAp5iAAkujoUGx5F6veKacpmIBG1Yt44bOOEVw0aD5su+qm02L/KnQZtRJ9CD3T8ZPYTIQlFZRVs0NDpY9nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SN7PR11MB6701.namprd11.prod.outlook.com (2603:10b6:806:26b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 16:36:48 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 16:36:48 +0000
Message-ID: <43f5f3db-fe67-eb88-fc36-635d0ff63638@intel.com>
Date:   Fri, 8 Sep 2023 09:36:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] drivers: nvdimm: fix possible memory leak
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        <dan.j.williams@intel.com>
CC:     <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <peterz@infradead.org>, <kjain@linux.ibm.com>, <maddy@in.ibm.com>,
        <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <yusongping@huawei.com>, <artem.kuzin@huawei.com>
References: <20230905091507.1672987-1-konstantin.meskhidze@huawei.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230905091507.1672987-1-konstantin.meskhidze@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0056.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::33) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SN7PR11MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: 21581715-468c-4210-2301-08dbb089cba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QSnTDQ3A1YxkKVIoMHxPraK0XA7/haTqY6I9fFWh6LFInMFT96Iah/8qp4elZ60xuEsP4FYGI56qeN6MdTj+ct5VBa2q0I0tjYN6sgE439yC2EsoppZFRYYwGKlUsirEnlyed9+G+WVJo+W+jumsl9DMM00KCutfMwOVWPFbaxo3hZm9yzWqN3FTnK7118gsliItAYA4f4vQu8ORCQMuFydsj8Brv9EdkRPoEI+Gg9lVBI+Sxsi3vrpGL4LJQFdA5YIK3slzzHx23GLoZFxGM3fnRNpzmvwqPKrTy6ebHqpEvZb0HzZHiQsUAk1HwkkyjgbswThV+qQ4Jye+gEG098QMyEKg4Lta+yk5pO3hlijLZ+kYTkp1IglwULjGSE6kZ5p8tAr557uaPq3P+lpZnpelBOK6O1FkBzCbLMW6Zy9IO4VHKEdYgPho/K09FRVDinWfH2B8fGVVp4Z/0g52q1wKALu/wpRqJDCgrLONA6kZKUO56z3MLEK9GZinSzr6zhaQirMgf6fZ5zN9K9k4kWYkmYeWk/BekqLaCPPevfey7rC+r8TIYw4JG3P+XvrTo3N+xAvcCYiV6PcDmmBinGnbBqWyhSdE8kRbcGMbuNX8iA7cBGYV0gmjLnFS9m9mJNMgJhv9RjVQXx7b3GVkcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(366004)(396003)(376002)(186009)(1800799009)(451199024)(38100700002)(82960400001)(26005)(2616005)(53546011)(6486002)(6506007)(6512007)(36756003)(83380400001)(31686004)(4326008)(8676002)(478600001)(8936002)(66946007)(44832011)(66556008)(66476007)(5660300002)(316002)(86362001)(6636002)(31696002)(6666004)(41300700001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmhFQ0hHVUdZc21BTVpPKzQybHRFSzhzTERYRnI3SUN6czhKNXlsR3JnOW1v?=
 =?utf-8?B?ZmxlS3dQa3Q4a0Uxd3BMQWIwbXJqcFkzQVhnaUpUS0NkYXZNWmtoNHZJYWJD?=
 =?utf-8?B?Uyt0b1lTZVJJOGQwWWpNaUQ2cXJ2UC9CMHFteG5jeUpxTEduQ3ZnbjZEZm1S?=
 =?utf-8?B?Y1JJV3pmVmpucWFWY0o2ejRzckl1cXJrNjhkQkY4V09nOEJqdEk2UW80TGJ6?=
 =?utf-8?B?NGh6ck1CUFl3TzgzNHRpNjZXaEo5QXZ2ZzVRYzd6cFJBTTVYU0JjVWVqU2lq?=
 =?utf-8?B?MnZzMHN2RFpEVUkyVElSd3NyMFVoejluNWFqczBRdTNiUlZnc0ZTREl5b3Ir?=
 =?utf-8?B?bFVTVVVJdWIrYmh3ZEtzcXVEUkMrOU1mQ2VUYldtVmg1UlhLMmJGVFJ5Rllx?=
 =?utf-8?B?bXBrdDFKOVl4VEQ2QXJlY29zS3ZFUmlRZkdIamZZRllKQzN3anYvUHZkVkFw?=
 =?utf-8?B?NmkxaXNaZ0dWdzlyN1ZlTndOMHRRU3FGZXJ5c1lzY3g0WjAvRC9DWVhRQzVO?=
 =?utf-8?B?VGdpaXBSQWErZW01RFpOY092aldVQlljblJwMzFRTlRJVmFNMWw1OS93T1c1?=
 =?utf-8?B?U0V6cy9RT0oxWVZGbHI1WWhjbmlsSkd1ZTBsMUlXUXdOQ2FVV0VCNFVYQkFJ?=
 =?utf-8?B?STBQQ0FWZjI3NzdDd2xVSXBMZUtLYjN2dXA0Z2NscE1YYzhBNGVOVmlmSFVs?=
 =?utf-8?B?djJSZ0hwSzNIN2tlWVlmN1p2V21DdDU0eUsxMzdzdmxzN0RwQ09PRWc0ODNM?=
 =?utf-8?B?OS9hSHAxamtSK3JseXVkMHNrd20yY0FDcjlNT2gxUkduQmpCNVRHTW05N1ZY?=
 =?utf-8?B?YjlUSTZGMkZSbHdUSHNUSnFiQjRXejhkYWdaemdlZjdXSTJNZzJwcGQxZCt6?=
 =?utf-8?B?NDRNN1h2LzQxdFBCZnZXekNnU3JMeS9xZXJ6TnNqK3JMK0FOeDU5RHY5czJ0?=
 =?utf-8?B?aDlpRVkyZVNnMldRMlBnbUFxV3lKMU9ZYzkvdFh3RStDeXlOVVJ2VDFNOVlt?=
 =?utf-8?B?emF3OEd0ejNBU05QNGtKM3huZ001cGlGTHZFQVpGR05jaW03MTlOSU0ra3pH?=
 =?utf-8?B?NWczc0k5VU1ZbytYTGVtU2swMnJjYnJBaDRRenVVZ3ExY2l3UC82bmhrWlB1?=
 =?utf-8?B?OVpNelc3S1VQL3Q1Ly91OEt5Vndhc01yWnRTTGgxK01QZnQ3WHh0aEZlR3ZT?=
 =?utf-8?B?NjJqTW9MV0NwbzlvemhGSUNhM1M4TUJGTEtHQzl0YUtISVNXRGE0WjBucG9G?=
 =?utf-8?B?cng2TE9OQjEwaDBUcHhJYktneTJ0TzZBU2ljcE9BNTAwSFdsOUJZbFMyeXMy?=
 =?utf-8?B?cnNFVjFxNFJ5ZzdVU3g2bVZGdWhuWkZSaXNRazIwU0FzK3hTVjBOWkN2aXgw?=
 =?utf-8?B?QnBVc3luNHF4Tk0wWHhMcjg5aHpCOXJMQXdXVmJqZGYwaDJLU1dyTThhY1pi?=
 =?utf-8?B?c2dKQWNlTjM2VnJLeDN0Yk9XeGI5bjl3cFFnbUh5UXZNNWR2bWVtU2tVdTNX?=
 =?utf-8?B?TEw0S3daVktOQS9IRmdrSk9GZHF5YjJQMDJzbW9pbnZkTnhxV3RaNVJ1TStD?=
 =?utf-8?B?cUM0NHdLd3luUVJCVHpveGcvcTlmR2xHdDFmLzFHL0RETjlsNW5GTlpyRnpv?=
 =?utf-8?B?bXJFTDZWNk9pUzNqcUNxUGFDTyswZkVDbEMrcDdZdkJUc0UxeWQyY2UyNkxF?=
 =?utf-8?B?eHY2YVh0aGk1bFVFQjZhSi9VSjVnaVNTK2hJL2MvQ1NQVTZUVU9ucXJWbVE2?=
 =?utf-8?B?bG1nM0dyY2FPTUtPVUw0anRpeEN4Wnh4bFRkYlBubkNNMjN0OG1MNUFJcmZD?=
 =?utf-8?B?SVlNZWo3Q01tUUpSNFBVZUdRbXcxUUpNWE1VWllhT0pWcWZNMmd2NnM4UzRu?=
 =?utf-8?B?NUJ4TTIzWlJWdW1OVkw2UEVIVERwd2o4d1g3UzVBRU5CbFg5Tjl0NnRjN003?=
 =?utf-8?B?RVlqNEJJdXo3bVNpenI2NDJjZUNtOFdJSXJlT2RLZzdTNjNYam80em9oREZU?=
 =?utf-8?B?MXRiNjFyRnlnY0hGTmgveTNuVTlGbVEwN1VHOUtTY1haUzgxRktIT0JrbHVj?=
 =?utf-8?B?SmttenE5dzgza05QQ3FWVWRRL1hmK3FBeTNaS2tJRkNFQTV5eFc5Tnh2Rytq?=
 =?utf-8?Q?tE/Mt/yF8wPahkbL6iL8OR4bA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 21581715-468c-4210-2301-08dbb089cba3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 16:36:47.9101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0am8VPoGNS/YMJYQLVDEYQw8XHNGiocp0VQ1iZg6Xb49M5po4tw9OAEsqWF0oLPwh1OPzvQSop8dc0S+T2ROQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6701
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/5/23 02:15, Konstantin Meskhidze wrote:
> Memory pointed by 'nd_pmu->pmu.attr_groups[NVDIMM_PMU_CPUMASK_ATTR]->attrs[0]'
> is allocated in function 'nvdimm_pmu_cpu_hotplug_init' via
> 'create_cpumask_attr_group' call. But not released in function
> 'nvdimm_pmu_free_hotplug_memory' or anywhere else before memory pointed by
> 'nd_pmu->pmu.attr_groups[NVDIMM_PMU_CPUMASK_ATTR]->attrs' will be freed.
> 
> Fixes: 0fab1ba6ad6b ("drivers/nvdimm: Add perf interface to expose nvdimm performance stats")
> Co-developed-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>

Please change subject to something like below. It needs to be a bit more 
descriptive. Thank you!

nvdimm: Fix possible memory leak in nd_perf hotplug release


> ---
>   drivers/nvdimm/nd_perf.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvdimm/nd_perf.c b/drivers/nvdimm/nd_perf.c
> index 2b6dc80d8..ecfa1f635 100644
> --- a/drivers/nvdimm/nd_perf.c
> +++ b/drivers/nvdimm/nd_perf.c
> @@ -264,10 +264,14 @@ static void nvdimm_pmu_free_hotplug_memory(struct nvdimm_pmu *nd_pmu)
>   {
>   	cpuhp_state_remove_instance_nocalls(nd_pmu->cpuhp_state, &nd_pmu->node);
>   	cpuhp_remove_multi_state(nd_pmu->cpuhp_state);
>   
> -	if (nd_pmu->pmu.attr_groups[NVDIMM_PMU_CPUMASK_ATTR])
> +	if (nd_pmu->pmu.attr_groups[NVDIMM_PMU_CPUMASK_ATTR]) {
> +		if (nd_pmu->pmu.attr_groups[NVDIMM_PMU_CPUMASK_ATTR]->attrs)
> +			kfree(nd_pmu->pmu.attr_groups[NVDIMM_PMU_CPUMASK_ATTR]->attrs[0]);
> +
>   		kfree(nd_pmu->pmu.attr_groups[NVDIMM_PMU_CPUMASK_ATTR]->attrs);
> +	}
>   	kfree(nd_pmu->pmu.attr_groups[NVDIMM_PMU_CPUMASK_ATTR]);
>   }
>   
>   int register_nvdimm_pmu(struct nvdimm_pmu *nd_pmu, struct platform_device *pdev)
