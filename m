Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4955D787BC1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 00:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239921AbjHXW64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 18:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjHXW6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 18:58:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F8D1BD8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 15:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692917901; x=1724453901;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y809Gyp8yNoGOHARhIHgZieNyZ24HLBw+HKlv25zVCA=;
  b=V2b+FJD6WNqZzQprkMbuWTt5VwQT2AYxfLbIUg/yR4vwJ3GTJNqfEStO
   0sqVEBg5IyhM2nXY9bDaTKoZVNArVIawm4Hw6X/KP78sdqpRmfJZJNKT5
   zromtf5bc/U5YLhNSfKMX1nIESuqN8lgM5TY89RwC/BksLyPFtGK09I6Q
   yl+FzQgAjebfAa9Gazu6+AdesgNUNV4jNwOclDJ0HTRjNCNsEAK7ayNVy
   TzGQdWClHqRk57ovM81rS52GNpy/nbukTifzehjUXktPa1nuvzjZ2vZGm
   gz0K8WZwntOQ1GJHbwdVTbWlv4dB4bdkS6kvm2aXfGvrYNoAXY7ezcuuc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="374555838"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="374555838"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 15:58:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="802732605"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="802732605"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 24 Aug 2023 15:58:19 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 15:58:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 15:58:18 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 15:58:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daMpphbEqKW2VuFTZxz8SGzNp/XD7czNgMOkXLDP8EJUYrHXv1pGhsATSNWKFfDWFf7k2ytO8TasX5q/BLEvhsbA+Z64LsfyCI4D+B4r6DAJw98RUQNRy68GcMzpur3LE9FThm9BjPrTHqJ49fDP0CjQ6ZRZIX3x1J49lditwrLw30kcmaqrri3j/VA56jATU3+qwJ85QKOxq6dd0RcBJpphSSQJUBk3ijhFGFhw/BjOkP/Kp2RaGJPZdS09dfctVN1f3IVLgT2k/K9J5QiDnurbSiFfcYRdJKAT672KoOh1Qj+C/w2ZJ8DqJ/SRmWRoAnUtGGb3zbpDirOa3zNAeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSbdsueUAv4Yl8AyMXCfyRkQdhvMzT9E5SEc4NnOZvY=;
 b=e3o1k4/nYGMR7vb4vOTtgsjrNKbH/0e8jFS9j/SwbqyNEdzAYdUqXQksFqqGVV6f9j3StMQ3ym3NbaTTB56s9V5QhNn7XzMfacgn6t50KBqp0ZBh4ehBss5P49RW6/GSyQr5+Gc/2KoiLSQWVz6fppJt2Uu9kTsXoT2YR3f093WvmreBhpSmyrzHzTJZzb2ACdejMtDU7/eRrvTUo+w5ahAum34jwNSUbbRlvt3P3NKYfVH165N6kb3yF2CiBC7Cq54rLXRs50ME30oNjN8YIzpHrIpOzPL5///l8zuAUgZ+AU5UAx08CN0ZVsuroAOT814puQDbXKV0NOeepYOioQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7137.namprd11.prod.outlook.com (2603:10b6:806:2a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 24 Aug
 2023 22:58:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 22:58:16 +0000
Message-ID: <1ccd6be5-1dbd-c4a5-659f-ae20761dcce7@intel.com>
Date:   Thu, 24 Aug 2023 15:58:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v5 06/24] x86/resctrl: Track the number of dirty RMID a
 CLOSID has
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>
References: <20230728164254.27562-1-james.morse@arm.com>
 <20230728164254.27562-7-james.morse@arm.com>
 <03cd7ac4-b58d-c7a8-7cb9-ebcc770d21f0@intel.com>
 <20b566d9-448b-5367-b4db-593466e7a2f8@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20b566d9-448b-5367-b4db-593466e7a2f8@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0144.namprd04.prod.outlook.com
 (2603:10b6:303:84::29) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e423034-e177-4e23-39cf-08dba4f599c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f3BL7osGOvVRQ7BcKqyQwCRemi6yvXKUThakCDo9JfHVOO1EEtT1X/396Yiti7c81VXE0S0DjyDcgwMWGhC82s+nVxPQsLjXD21c7ajIdTuWBoQbnFUlHIgEEkJTnT5ZrzXfzoXO7tWBwfTqsRFe4ouhCOdmFp/y+Mf57nsLvqfqzYe8/OEKp7FaV1J64EAWtYYOz511pSnYBM/3S5yeyTowVd98h6QdrDrt9zFJMkXPiZx6dAq3OtdcZfZqt6uxBeSQ7mf9rJHfzmOWLykqnizLJgVTONkg5XVz/KVxdICQEJyGFegItfWlpTFldhCmu7V93wlzI2ceXFLHl9BisaxvFP458la3KFOum+mSWQX0YVEUvYbzk+8VcXUIUwCZRGcJKIk9aKw9aKOuKlfBMQZo04i7ixZ/CPDvKYs8bWopB6MO0e1CEwWAGrmCDTa3HS9SycqKpeMiKC++MFACkLD9X9Mu8Sgea2av4dEK9PlRdmlTiwVjOaH5InKZZy6W0mto4NIMOqP97iIMnYHRBcF/Q/oUwx3iAoDrLD5jssFrP8aOgpngHmbug6vu2QCxvb/v5L+mBecjisM0Egdid00hKU3HQ5spsMl+LtveDsSw1SHl3jwraycgXyIc6h11D6eSxg9/f/KUPVU6Uc+kLdOBMK1SmZFAih5CYyeewsM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199024)(1800799009)(186009)(36756003)(86362001)(31686004)(31696002)(38100700002)(82960400001)(44832011)(54906003)(66476007)(6666004)(6506007)(66556008)(6486002)(4326008)(5660300002)(53546011)(26005)(316002)(41300700001)(6512007)(8676002)(8936002)(2616005)(478600001)(83380400001)(66946007)(7416002)(2906002)(14143004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cU1SZ2tjUStBQmJITmp4T0lWeHNxa0FVNW9vRDFkclZac1BqWFhaaWlFeHpK?=
 =?utf-8?B?dU8yMFBpS1NqWUJJL1lBYVEvc0FoUTFjNk10YXdwU0x3ZGFkTjR1OU8wWDJQ?=
 =?utf-8?B?U2ZEd0lvcCtJRUhtR2xaT1hlajM0blpmZlh2VUx1d2xGanVwR3JSUXA5Z1Bu?=
 =?utf-8?B?VFBTT3NrZzdnb3ZJcGJPWTVyVzhQODMvU1NIbXJia2RKNGExNm8ranI0RkhL?=
 =?utf-8?B?SnFjTEhGVzU1dWF1Y3ppcXp2ZCtMT0dkTWxramkwNXAwRWRCZDA3WVVubjAy?=
 =?utf-8?B?NExnN21aWmx6YU1laS9aaDl4YVc5U2tGVFBpUmVhcUJrTFR2RzZLMjlFSlFy?=
 =?utf-8?B?dUVTOEJ1aWQraEIyeEoyWmJvcDdxOVIzM3BhaXlDWmhsMUR3SDd2UTFuOFFJ?=
 =?utf-8?B?VnA5ZlpTcnpLOWZHNmJnVHpaRE16cm5VZlBKcGw3eU5wNitRV0k1ZUxYeXI1?=
 =?utf-8?B?bHFUU3hhSk03UGRtYy9URGFiVEdFb3JpRDBsL2Myd05TL3Z6VlcvREJxdWpr?=
 =?utf-8?B?STE3QndGanpNbDEzci9vN3VvWFIvODNmM0djZkN3YldvTXp0aDJqNHlGNWhj?=
 =?utf-8?B?UldoMUdNNXFFcmNaS0RrVGQ4REpFcFlQU0RhQkIvK3BBUUxmVW5SVnNEcHZ3?=
 =?utf-8?B?dE9NSjNCSzR4TElkYzdjdEc5eHdicUx3RUlWQXZRcURpaGtETDhjKzc5YWt3?=
 =?utf-8?B?ZW52MUFqSVJiVzIvbWpuTm5IbGVwbTVDcWZ2TWsydzlVWlh1Nkc1OVpFeS9Q?=
 =?utf-8?B?dkw2QjlQNG5wSEtCTWFsZEhWMzgvMVNMbGVRc0VNaXBmL1JiNzEwa0g1V21O?=
 =?utf-8?B?anZqaWVaL0pIK2FHQ0psUDB2RmI1enBXRDlyKzRJRDVLZnFQQStXMEpBbExl?=
 =?utf-8?B?UEpLamFDV3NSanRSalByVFo2cloxRmFMbzBTbGU0aTJUTDNKaWliUUJlbzk2?=
 =?utf-8?B?UHduSkxrQ1NqeUNBdm9NRFBVVndKUTNWMHhaYkhrS3V1UksycmN1MG9WVzFx?=
 =?utf-8?B?MG1NTTlaMXI2TlkzbkZ1TTRlUXVXSCtYZmRJUkY2QUhVMEJuK2RONWdOVGtv?=
 =?utf-8?B?MjJCZDRxYzNGNElBY3dpcDVlQkpUWDNsb0JXUk1LQTU2aWR6dXlYWGl3Vi9y?=
 =?utf-8?B?aDlBWW9DMXUycWVuUWdhSVhPclhoSmp5OUpKQWNab1hBYm5pUVdQTEw3ajZl?=
 =?utf-8?B?S05LZVhHcTV5QkhFZDJZTml3K2JDRFBMTWVEdEFVR1dzSk5EV2Y2RWRjN2hp?=
 =?utf-8?B?VDhBcHVaQzE2azIzaldrN3B5Z0VqeFBJSEJ1cDEyRnVOb1o4ZzU2OC95U1Vk?=
 =?utf-8?B?YVpkYXFlQW90YmwrTFE5OWY4aHlMTDY2K1NiWHh5a2hRSEhNTFEwQXYwMGdm?=
 =?utf-8?B?Q0lZeFlNcjVGckVOSXBjaXQ2YVMrZUcvR1N2ZzZBd3VhaFZLY3dVc1luVmpL?=
 =?utf-8?B?SndzclRsWnc1NEk2bHZ6NVlkVzk2M2JEaGoyNzZYVThHVWlmOVhUUFo2N2ZV?=
 =?utf-8?B?OFozZHpjVjlVTkZkVUlRdUhMR2EvWmNQTm1pcnVhL21VbUVFMktpVDBLc2x5?=
 =?utf-8?B?MXZiMVlGT2Q4cXJMUkkyV2tkZ2tuZTRxU1VpbmFsd3JqMlFTN0QxTzJFcDlj?=
 =?utf-8?B?YUU0WnJZL2VObk1UT1g5QkFGMldRVDBIZzdDZXc1bmxYNG0xYVdMUEFlRlBp?=
 =?utf-8?B?NXZCVGMxS0h3ZW1XaDZtK1BETlQyVHgyZXdoS1pmNkdLNVRoZGtlbHRXR3pI?=
 =?utf-8?B?SFhsa1RGbXBBWXlNMGFjbm4yaS9zV3dCdW1PTTNwaUN6aTBsTHA3SkZKdmNT?=
 =?utf-8?B?YnA1KzFRNnNuLzJreEU0UFRpVHJwREVxNmc1ay82L1l1M2Z0Zy93Z0M2Q0Ft?=
 =?utf-8?B?OFVUeU1Sei9wMnhQZHg1d1k5OHZNb3l1YjRtTFdvblpZbm9EUFpTRTBIS21T?=
 =?utf-8?B?UHpqVWJHMTN3WHFXVDBqMW1aanMvaU13Z0h2cFptdThHMTZFTEtuTWMrRTNS?=
 =?utf-8?B?ZnBxTkMxOGc2RitZbkg5K1JoSmZsRXJFb0svVnZqeFgrWTQ4RGY4aU9Kbit1?=
 =?utf-8?B?M0MvTXkwbjNWRVgxNE9iVVpGZzNnT0Zqc2tER0dqakh1bGZNSFl2b3I4OFI1?=
 =?utf-8?B?dVpSMkcvSVlCaUZudHJTblJCY3N6clFkcUk5LzNNZE9UVmpjeForelgvRVp3?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e423034-e177-4e23-39cf-08dba4f599c2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 22:58:15.9943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXOVWPYdq5GTNQ+veFQLtQNxFgaDV4cSJ1s+jN2Ymz3bC5Zly6eZTJKH/he7pPOWYlVVs8fLq8Yn9HdGscBUGzwmozvpaV+ucN1oiYE5tGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7137
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 8/24/2023 9:53 AM, James Morse wrote:
> Hi Reinette,
> 
> On 09/08/2023 23:33, Reinette Chatre wrote:
>> On 7/28/2023 9:42 AM, James Morse wrote:
>>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> index de91ca781d9f..44addc0126fc 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>>> @@ -43,6 +43,13 @@ struct rmid_entry {
>>>   */
>>>  static LIST_HEAD(rmid_free_lru);
>>>  
>>> +/**
>>> + * @closid_num_dirty_rmid    The number of dirty RMID each CLOSID has.
>>> + * Only allocated when CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID is defined.
>>> + * Indexed by CLOSID. Protected by rdtgroup_mutex.
>>> + */
>>> +static int *closid_num_dirty_rmid;
>>> +
>>
>> Will the values ever be negative?
> 
> Nope, int is just fewer keystrokes. I'll change it to unsigned int.
> 
> 
>>>  /**
>>>   * @rmid_limbo_count     count of currently unused but (potentially)
>>>   *     dirty RMIDs.
> 
> 
>>> @@ -782,13 +802,28 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>>>  static int dom_data_init(struct rdt_resource *r)
>>>  {
>>>  	u32 idx_limit = resctrl_arch_system_num_rmid_idx();
>>> +	u32 num_closid = resctrl_arch_get_num_closid(r);
>>>  	struct rmid_entry *entry = NULL;
>>>  	u32 idx;
>>>  	int i;
>>>  
>>> +	if (IS_ENABLED(CONFIG_RESCTRL_RMID_DEPENDS_ON_CLOSID)) {
>>> +		int *tmp;
>>> +
>>> +		tmp = kcalloc(num_closid, sizeof(int), GFP_KERNEL);
>>> +		if (!tmp)
>>> +			return -ENOMEM;
>>> +
>>> +		mutex_lock(&rdtgroup_mutex);
>>> +		closid_num_dirty_rmid = tmp;
>>> +		mutex_unlock(&rdtgroup_mutex);
>>> +	}
>>> +
>>
>> It does no harm but I cannot see why the mutex is needed here. 
> 
> It's belt-and-braces to ensure that all accesses to that global variable are protected by
> that lock. This avoids giving me a memory ordering headache.
> rmid_ptrs and the call to __rmid_entry() that dereferences it should probably get the same
> treatment.

This is fair.

> I'll move the locking to the caller as the least-churny way of covering both.

This is not clear to me. From what I can tell all the sites you mention
are in dom_data_init() so keeping the locking there (but covering the
additional sites) seem appropriate?

> 
>>>  	rmid_ptrs = kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);
>>> -	if (!rmid_ptrs)
>>> +	if (!rmid_ptrs) {
>>> +		kfree(closid_num_dirty_rmid);
>>>  		return -ENOMEM;
>>> +	}
>>>  
>>>  	for (i = 0; i < idx_limit; i++) {
>>>  		entry = &rmid_ptrs[i];
>>
>> How will this new memory be freed? Actually I cannot find where
>> rmid_ptrs is freed either .... is a "dom_data_free()" needed?
> 
> Oh that's not deliberate? :P
> 
> rmid_ptrs has been immortal since the beginning. The good news is resctrl_exit() goes in
> the exitcall section, which is in the DISCARDS section of the linker script as resctrl
> can't be built as a module. It isn't possible to tear resctrl down, so no-one will notice
> this leak.
> 
> Something on my eternal-todo-list is to make the filesystem parts of resctrl a loadable
> module (if Tony doesn't get there first!). That would flush this sort of thing out.
> Last time I triggered resctrl_exit() manually not all of the files got cleaned up - I
> haven't investigated it further.
> 
> 
> I agree it should probably have a kfree() call somewhere under rdtgroup_exit(), as its
> only the L3 that needs any of this, I'll add resctrl_exit_mon_l3_config() for
> rdtgroup_exit() to call.

I'd prefer that allocation and free are clearly symmetrical. Doing so helps
to make the code easier to understand. rdtgroup_exit() is intended to clean
up after rdtgroup_init(). Since this allocation does not occur within rdtgroup_init()
I do not think rdtgroup_exit() is the best place for this cleanup. resctrl_exit() looks
more appropriate to me. Having a dom_data_free() to clean up after a dom_data_init() also
seems like an addition that will help to make the code easier to understand but that
is without a clear understanding about what you have in mind for
resctrl_exit_mon_l3_config().

> 
> Another option is to rip out all the __exit text as its discarded anyway. But if loadable
> modules is the direction of travel, it probably make more sense to fix it.

My preference is to do the cleanup properly.

Reinette

