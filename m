Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4766A77FB6D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353428AbjHQQB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353425AbjHQQBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:01:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B5530E9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 09:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692288068; x=1723824068;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R6DpcSMnu2M/Qq6N9v8Y6ui7nK51U4fMYhT/anz3f8U=;
  b=bfrOMPpR75Ev1IcbY7mqb3nbtcTusapRo/udhwupbwPwmeJECsvMxSy5
   cnkDK4UJV7Ei1bWntwIXVanP33aeGCnBXqE7QZ7WjCUH65JdijjG21iMS
   gWrSef2yTqxkLrquTZur87ThZINWEHFIQBkF35MpXR2HeD0zYFvp5Rd6K
   c4i4nNETglBWMoR0dYzq1HiZQkTlURYabANRN6+Cwwjdq4k/FeTQsLHb1
   1SOOuDoOFm+sxSCkVmJPrS9nencwBcPXw6V6ReHE2OaJ2jfROMPHgQWlu
   rdUdjey1DtzA7gQa2mS/v9fOUYQKsA1neFe6KKd4RyMbUgVOSHm/oazgQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="403832640"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="403832640"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 09:00:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="1065303496"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="1065303496"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 17 Aug 2023 09:00:55 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 09:00:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 09:00:55 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 09:00:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCKakZevUqsBEh7xwMWy2XqlVJmYTMjfxdENL3SnsWX0rHLjjGwwXw5wl4XNPpqta2ZugJpY9cSUEuRhKBs9E68vViIZK1mZQyUZlq4P9AXS20duiRiIlhC0gsFu4k9fcFxBS5QOtRZ/sFK4DANym+tm5Cpwsqv086cHFHCMh0801VyFK6RjtqGpGvjsZQZyAssvCLzq5BMxDguNZTpYluYmjLXkG6kF3d5jmLgldudImNsJs0qzwvBFkcPrTtJMRbXYY2gOw7xDerC35diFIDr1AZN/vGLdXb4QfLJ0kdE0lDsf7epwlox0rTLJnSMSf5HShzWE+h31hoN6nNEWxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ci5GtkZ9sVpsGNIRx/iHkLdHHToYsZz/ZhrYDpST8JE=;
 b=KfjszQNLcSLYwNF3lvRZnDm19HmlRbpsX35sqVc7ZyVF4OekrQKNkJABEiYONAjo0lUOWpKBXUCyRIuXGjOL/om+7H9HqlpwfLXgWQQqG9taTRhwgwCZYoBJ6CDEVAVp3JzVpT8+k4W31bFqify5ZjiRdxw+3bqeW9scfjs1JxZZD6LN40hNMOrL17vpbZdGHSEUy562pmM/jwfs9dfUDJ5RFWOvE2DWpkNWWse7bwXgDmxk9YxNiTuEjHHayZ+ZviMvD3aq3EX2zYm0yE7glkQwpHygSJGyxhjnDpV/JIZ1pPjgNnV8bIYSUjr6WXk/CgI29pDrp+mA6rs14E3PKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by BY1PR11MB7982.namprd11.prod.outlook.com (2603:10b6:a03:530::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 16:00:53 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::406a:8bd7:8d67:7efb%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 16:00:53 +0000
Message-ID: <a5d425b0-9a23-e58a-52aa-db380234dc30@intel.com>
Date:   Thu, 17 Aug 2023 09:00:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] drivers: nvdimm: fix memleak
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        <dan.j.williams@intel.com>
CC:     <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <yusongping@huawei.com>, <artem.kuzin@huawei.com>
References: <20230817115945.771826-1-konstantin.meskhidze@huawei.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230817115945.771826-1-konstantin.meskhidze@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::29) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|BY1PR11MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ba5c6b7-6f63-43c5-fbdc-08db9f3b2293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I3MRyfM0Q7FOn4SwCIJcU+uUw2h+rhfEkBBy5QndNpfGRABDhKb1feu4CJec3KKGgjQflGZM43+beCIBRYmr+d0ER5JqvRuXyDSKFG+8klFcZeIVDe5GL7vQT/Dj1mcU+mEsTQaGk5Ev8+KICKph1wl6J3PyGmMDmzrD5ZZ6CyIzETtqLsP9MWRjrwzpRdQjtimcuFHIntGcyPj2Q9Pe1navfMjkCSt28hHcfAbYINoEv4EFF/n6uB2IB73LYRdkNR3khXt2Rl35i/pTmE8Y2j+GssN+2HMa78aCOnZClzfyyhsLsHBfnmjA/fyMIDXYJ16cBLmuFcHFKrOPRP/xd7XSFWn+BxZIlaEnteTpblZZPsX+dafWmteGmigQDB18w8sA7kI094gqrGTo9Wrp1+xAdf57EYOldAYfd8lsYfWoQh51R13oIbQQrowLDSmyxIBRxvmeUxiwsNGVmFzSP86r0rGBIkCgkkdVJnWyVv1ne/Ra+OFnNDSBPPD4CLzS3/mmRBVBcZW95vIem9jyvvkhZhD3PrXKDIQXI8RaaV0+6ODyrNL2ZtnaLxs66AqyIOSS4ciZ2rqg2dCs6neuaQ4RR9Kpsfn0Dw2hRd3rr7BMISeMGJloBU6leMEf1SUEYWcWs/VV+behMTHEDx+jYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199024)(186009)(1800799009)(316002)(6636002)(66946007)(66476007)(66556008)(31686004)(5660300002)(41300700001)(44832011)(38100700002)(8676002)(8936002)(4326008)(82960400001)(26005)(2906002)(31696002)(478600001)(86362001)(53546011)(6512007)(36756003)(6506007)(6486002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmNNYjl0ZFNWYWFpdFZqaTI0RTZ4ZkZiM2d6TzRETVl6UHpBN3hQRnJxTHQ3?=
 =?utf-8?B?UFg3eS9wNTJSMmZvOUdJSEl3N0U2eTlHdkhFQ2N3Mm1ZQzduSEcwYmRzL1Iw?=
 =?utf-8?B?b05QRW01aFp4cGRXdTI0M3JTRTlxS213a2ZqVUEwVkpTczBLNHNzbmdTbGN5?=
 =?utf-8?B?cjJZTVlzRHBlTEwyQ1BkUkRQSmxrNm5BZm1qSEZERlRVblU4cnJ0N3pJbGlO?=
 =?utf-8?B?TVFkSTBIZThOOURNc2l2WHQwNldtaVlGNUJpQ3VoaGhodGJZQVhOY2Fac0p4?=
 =?utf-8?B?ZC9wcHhpUnZRUXgvNHNkUFJqZ3l3L2Q0b3N4UjA5MUV4ZDg5NkJWS2UrTDdH?=
 =?utf-8?B?ZFhhZEkvYWJvWW0vZ3pWL3p4cTZDNXJCUFAva0gxcFdHSjV3ZnE1Q0lXVk1S?=
 =?utf-8?B?emlPeGZmKzF0Y3ZrOXBQL0l4QXhkRFlMT0hOc2VLNWtiV3pwWHpPWW41TFh6?=
 =?utf-8?B?RWpZd3AvWDJhNmRYYVVBcDRPaFRtZDN2enh1VVNoMzVOL2tGU28yODRJSW9G?=
 =?utf-8?B?TXFSZk4vQ1lRQVlLOEl4bVFWUkdkVU5uN05MY1NYcGlpVkZhTnRKY0pocGlP?=
 =?utf-8?B?TnVRZ1NNZ1VoQU5DUkROa1d4SHYzLytaV1VnRVFjTk9WZHZJemZjdWtNelVP?=
 =?utf-8?B?U0RRcEJCamhaMmlSVWhxRnhmdTRhNmJFa2xPd3hrdlpGdm00eUF0MmpEZTMw?=
 =?utf-8?B?TG1TNDYrcS9zenJSZ1JuVy9VblJ2T3prZkwxZDhPTXRIQjkvQzJKamRmMWt1?=
 =?utf-8?B?QTFndDlpaTlwTi9sb09CYVhza1VmVkFHMUtJc25zeE91dXBmSUE4aDZUaUVK?=
 =?utf-8?B?S0w0TkE1NFNRNDFsVWFBS2M1NzhGREtVZVNqYVB2YWtYUlRVZUIzRHVGZ2E2?=
 =?utf-8?B?dGxnU0FEM3Rya1g0d0RjRjREbER0UVJXRTVRdjhjdGxPUXF4UnFLZ3ZYUWJl?=
 =?utf-8?B?S1BiQXIwMVRZV2JrbFN3NGxES29vOFU5VlVzVHJyM2ZPSWF0cmNZcTlDVitw?=
 =?utf-8?B?Y29PUDAvWUhtbzZydU9jZkdOMWlpUVlFek9sOTFOVkRRcTNxZmRQOTgzWkti?=
 =?utf-8?B?dkpteG1FZWJ1WFZuREVUVDhUd2taK0UxL1M1eS9pU0ZqdmUvOExPRGxaTmN1?=
 =?utf-8?B?cThOTXpxenU1cWZ0RDZqdUJsMDJWallQUDUyd1l4THlhSnU2dXBTYnJ1R2N2?=
 =?utf-8?B?Q0d6YlV4WDdUQlVWWCs3MzE1bEh5SHNVcHJVdUxpeGR5Yjc2MWN2cFFTemhM?=
 =?utf-8?B?eDliOXpJL2h0cENoYnBtTHBldlFnUE9rdE5TckJDck9tWU85aTUvYnlMSDJ1?=
 =?utf-8?B?bytxY0Q2MlRBdkN1eHZIL0Frb1ZNV2VHUFAwZFE1Y2QvVU5KY1V2WTJORWZ1?=
 =?utf-8?B?U3JjRVFtd2l0U1RlZHd5RU5FcXBNMXJ1VmwrWE1YaTE4aW4vbmZHSWtqdzEw?=
 =?utf-8?B?T1lSNktqNmdqclEzMHRZeEhMeWY5bEROUHU2bU5IcXluMjNFUk9NM2lGeE5I?=
 =?utf-8?B?VDEyUjMxWTB5eVQ5SXJyWW1NRjc1QnJ2NTlzOTVORTZTQjZoQzhwbzZrUFk0?=
 =?utf-8?B?NWdSdEFkZlI5Zk93UTFTZGZyb3hhOEkzRCt3c0Rkb2VJeXpVMkgyRXE1bGR6?=
 =?utf-8?B?Vlk3RXRJdms1c2xtWU9DSitoZ0c0cHlONTB4OHNaYjh4WFVXcTQyRWlzcU1J?=
 =?utf-8?B?V3lpY2d5OHpQWXFZb0doeFljYUptWDEva0sxMDZSMDRueVFkU2NjU3gyNEsz?=
 =?utf-8?B?ZXdhMitTSGNZUVdzdUh1cHBlRHZmYUtQVHRUNS9RTVdlbTJ4Q2Zta2I4T2V1?=
 =?utf-8?B?WXU4UldlSXJBSlAwanJvZEpHTXh1RXVGNi8zT1p2Wk1QN1ZIdU5BL0lHRHRh?=
 =?utf-8?B?eGxNYXRpYit0TDNORVFTQ2Z0cm5PUkFOb2NGT01rTGcrMS9OOGRtb3dtdkhs?=
 =?utf-8?B?NXFwZzI2cU5FV2ZBQU50STdia0hTNFhNNXlHdmtBZHRHQW5TamNJZHNNNGhn?=
 =?utf-8?B?OXFMUTdURG9hUjAyUXhKeHRUbis3SFRNenc0VXlCUklxc2JseDdtclg0OHJH?=
 =?utf-8?B?QlVLZjR5bTBMSURML0VMRXBsY2hnNU9yS0lDMDkvK1d1UFBPRmVacW4vTThj?=
 =?utf-8?Q?y7YoWXneUBEOtgZoQlACO4iOk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba5c6b7-6f63-43c5-fbdc-08db9f3b2293
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 16:00:53.6660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nfJkdVDPh/8TWpzfz6y2XL+G42Uztimad3cnbYPPYl3HIbH21XQTfdqERa16o+8ir4LiZnmAEb/Ua/IzCHCTWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7982
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/23 04:59, Konstantin Meskhidze wrote:
> Memory pointed by 'nd_pmu->pmu.attr_groups' is allocated in function
> 'register_nvdimm_pmu' and is lost after 'kfree(nd_pmu)' call in function
> 'unregister_nvdimm_pmu'.
> 
> Co-developed-by: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>

Applied and changed subject to:
nvdimm: Fix memleak of pmu attr_groups in unregister_nvdimm_pmu()

Also added fixes tag:
Fixes: 0fab1ba6ad6b ("drivers/nvdimm: Add perf interface to expose 
nvdimm performance stats")


> ---
>   drivers/nvdimm/nd_perf.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvdimm/nd_perf.c b/drivers/nvdimm/nd_perf.c
> index 433bbb68a..14881c4e0 100644
> --- a/drivers/nvdimm/nd_perf.c
> +++ b/drivers/nvdimm/nd_perf.c
> @@ -323,7 +323,8 @@ EXPORT_SYMBOL_GPL(register_nvdimm_pmu);
>   void unregister_nvdimm_pmu(struct nvdimm_pmu *nd_pmu)
>   {
>   	perf_pmu_unregister(&nd_pmu->pmu);
>   	nvdimm_pmu_free_hotplug_memory(nd_pmu);
> +	kfree(nd_pmu->pmu.attr_groups);
>   	kfree(nd_pmu);
>   }
>   EXPORT_SYMBOL_GPL(unregister_nvdimm_pmu);
