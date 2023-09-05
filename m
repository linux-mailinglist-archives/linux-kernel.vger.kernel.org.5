Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80C867926B4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238700AbjIEQGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343908AbjIEC5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 22:57:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0B9CC6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 19:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693882625; x=1725418625;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ALhixCyND42H3lmR7lDDk2Xs+6oHlX4T60zfMUC5O+8=;
  b=S1UXsERY3PcqWsJEggOON4lSnkEVNchO3TT5filBOgBTydXHsjbpGJ1R
   37B0w1giVvswiOTjZHQ8oVd8Q9Pk9q/hSjuSOk3Rc4vg9KFVKXb69Dkua
   E4wYzIlYGwKsmRyZZpbB+npknvGKDCN5db/leK/4z/seCh7s3/FfE2IEt
   vuOKo5FgeT0WGR0NoSitwOC7y6lGd0BbHWWEbqBHXzdBkw3q/I6ljPYLb
   DP0HQO8kSrOYA1k47DJrR2QKg8GvhCZKVmkOpgSxYc7SFY1oiKboc4bFm
   ertTb4iBTCq2IPuQrzClTOEtrxGnoQlaIaIJC1F1QDtIcKxXDQ8lTYdBW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="366916711"
X-IronPort-AV: E=Sophos;i="6.02,228,1688454000"; 
   d="scan'208";a="366916711"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 19:57:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="831069088"
X-IronPort-AV: E=Sophos;i="6.02,228,1688454000"; 
   d="scan'208";a="831069088"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2023 19:57:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 19:57:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 19:57:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 4 Sep 2023 19:57:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 4 Sep 2023 19:57:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYdLEfUy/l1Ddr9wTIzXEts3tLLQ4CYq519KX/gYS7sj9uGiPVz1PPf4z1CeuRqu7N1CWGueoLaftQBUTv5KafgpWMtbgsE49HGzvjsHrrEdXrRxouc8GrsBhLrXKx2vmIfd0I7VfNQ5XoeTNpjQ9rZBrB1MU1xMNBPsD4ERqpGXiD76ATsnWc9p7DGaB+G+ah+bwHY+kCk2S7kEYgTgE6NZurcW8Vc92MtXau96v8uLHZYENXbFdGxel6b+hO3zrfzCyLef16Rbw04Q1tslwmbdulwu4Zt84/owb41c2R1iHlM70gb4s7btE9cX1gFDj30eqA1ZJmXKovKgdh50cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mcxcJdoKowvjs7Pw+ZKuIjtQZ4UfgkK0w6Zb4/g5zk=;
 b=libki5uC42HKxW9AmxhkM1ILygdYtc/nKYSXVOIcIIkukjMRCIs29ulY5VNDIIKUEbdj3rs3Vp7tREu5yZ8heHJuzjsESGB1I0YQLV7jwlM1WXyLejphNunhXhhfN5W2BrxzKmpDKQy5RrasD74qwBMplqrEfcomOn/K8bkvgAxeQrGoNfdQDK6CpXEgDdg2lDj04NKY1kKJMvpRIBx86Sk+8tHpVVVjaJQgziI76bGxWtzrWTTyKawBvm85JtVfYp9RPz9Rebrjtibe6pcpbKzR3EJUzvAYKZWsab9sfA/kshrQiDdTCOOuWSIzSwd/V5ZhSe6RgA1K4x+IGUW4qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by DS0PR11MB7880.namprd11.prod.outlook.com (2603:10b6:8:f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Tue, 5 Sep
 2023 02:57:01 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::2846:e5f8:b2e8:1da6%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 02:57:01 +0000
Message-ID: <1d5fc255-c02c-b21d-2c4e-841c4ee8fb94@intel.com>
Date:   Tue, 5 Sep 2023 10:56:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [linus:master] [mm] c1753fd02a: stress-ng.madvise.ops_per_sec
 -6.5% regression
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        kernel test robot <oliver.sang@intel.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <yujie.liu@intel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Olivier Dion <odion@efficios.com>,
        Feng Tang <feng.tang@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
        <ying.huang@intel.com>
References: <202307181511.8643eac7-oliver.sang@intel.com>
 <3b4ab51b-e3e9-a504-ee07-82326e9ee1e9@intel.com>
 <c5983185-5bdc-b703-1600-6e44c49d6442@efficios.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <c5983185-5bdc-b703-1600-6e44c49d6442@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0018.apcprd04.prod.outlook.com
 (2603:1096:4:197::9) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|DS0PR11MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aab6b79-45e0-42b7-a226-08dbadbbc6f1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XywSBbq3tvjLz54i44X5UJGO9wb2WSDblwBqCLDyDWL59dFwe08lz4dcqIyCKGm5BV+NmJ82xwbjHhNuYl/DJ/CbWnPZQCA4AGmA0OfHEdak8caOor/wWJB2I0B8WWdkxbhQFyFzHfODareAPDVfzx/zXSM9Krot/BH1uZMVDyI0F3nrRHcro29JOEZGEj0QSR06qXKA87H5leTtfEoZ5w8y40i5ShflMRmFF42WggHl7osIaTsd7FQ4Rc7BrvQmjvpGLWzMCVoMAt6xmVMUWitW0q160En+fghrqOu0ZkbjBY/qzaTdrWVLSPblhErb+mWBcwmA9XFrFsLQWmd1nAjyODiBgUKANS7wM/UzdNEcYB5oEZzw9ejqHL4PrUn2arX/iY+cJ24+vF0HA/Gtj5Nl/hcmO+tW87VpKFqvMApLx9f0K2mgqvgxw+hhuEGIXnShwT7QnuMb6YPPmR4B94Lysf/e2y23g2UQd4/JY2wLBy2gnOqn2dYWn3abk3+0KLWSI6UqA7HH8x30gHR2rqY7ecH+JLBjT8mh1JL174xeVJtUgLtg2TV2h5aTsLoWB8oSyrZFbyWYVAdkmCnSETsco27FlUuiD6WBvIWV7g6wptwOGyPM7n3NPG3PfMlo+9e8sTCaCOwkZWPU3WxQ+gqMPbG4Tz6zK410oCQc4OhUA2waROO6tFLc8RJJBFD9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(136003)(346002)(186009)(451199024)(1800799009)(5660300002)(41300700001)(107886003)(2616005)(26005)(2906002)(86362001)(82960400001)(31696002)(38100700002)(36756003)(4326008)(8936002)(8676002)(83380400001)(53546011)(6666004)(6512007)(6506007)(31686004)(6486002)(478600001)(966005)(110136005)(316002)(6636002)(66946007)(66556008)(54906003)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTV4STAzRTdpOWo4bkhCWWQ1OXBvdUgyaDJ1ZktHdjJYUWdHbjh2WkV4elFv?=
 =?utf-8?B?d0QvVEhUcUhUY29jcm5YajNXclZGaTN5cmhvNzFIRUc1R00ycVp0cXJ3QjYx?=
 =?utf-8?B?SUgxKzd6L1RBQ1dDN0Fldk1yaldxUnQxR3FqemVjUzFjQkpVZ0cwZVZab0Ur?=
 =?utf-8?B?eWJ3cnZEVlBKeTgvelVxNTlvT2k5YWxBZVRuS1VTT1J1K1FORWIyLzlhOXVP?=
 =?utf-8?B?dHhMeFp3TFVjMjNxOVQ0Sk1pVUI0UWtkeXZ0U00xUE5BQXFBdUNxMGxRTVRE?=
 =?utf-8?B?V1BQNEU0RDdwSkR0YVo3bktuei9DQU1LWDdkanpzSFpkVTJsNlVMSUhuUnEx?=
 =?utf-8?B?bUVZOG5keDh5RGppNncyMVFiUmdnUUc4cm5tVVNGOW1MRHVYZkttVVBDMzdB?=
 =?utf-8?B?Z0Yxb202UWUzbkZMNTFaS1VXY1Y2azh0RmVVMmFhY0cyZTBkOXZRL2dwNS83?=
 =?utf-8?B?d1J4Wm1xa1RTbFU0aG8xaEJnckc3c0VaUXh4dFpPUVRkd2pGd3RoWUFGWmIz?=
 =?utf-8?B?d3p6eDZ1UWZNWFZlenozRzFMMExxVlUwWXVSanVieXZTU3p0dllWT2k0cWxG?=
 =?utf-8?B?MFFUYW1tbDkxbXVIdEhjbDZkN2duQjhGdkt3MGZjUUJqVDJja3ZJVmFMVlNo?=
 =?utf-8?B?Y3VPV01GSzlEL3FGWmJlUisxUlpBNzliVXZZejJ4OXFDaW1CbEw2N2R2UGpo?=
 =?utf-8?B?eUpKTjd6Qi9weDRDUWZybDZIVGgxcENzTnlpWWRGd2ZMa0NjZ0lCbStoTEZR?=
 =?utf-8?B?QlhEYWpUSTlWQWRRN2hhOHZaOThqVFVDNmRoYjBsVmpzMjB5S21sTzJiYkpk?=
 =?utf-8?B?NmJqblZ3VXRWcjNBZ0JTa3hkb04yMUNwQmp6ejF6NlJjU2htMDQ1eTZJYzFl?=
 =?utf-8?B?TjRzR2x6Mml2NU1rVGc4alBWQTJudDNmTnN0U3ZJWnNOTzJyVEQ3TXlZQllI?=
 =?utf-8?B?YjBVK1I5NWdlbXQyRk5adW16LzMrVW9NNlRVUyt3eEplNXNJQUJBVlh2U0FZ?=
 =?utf-8?B?U3d3ei9NZ0xMWUR4Tk1kT0VXWGgwem1lbWhaSEJsMG5iZ2tnNkMzdENWQy9r?=
 =?utf-8?B?MThkZ2lSbW1vSFpiNFBKREV2RmhKaHEycW8wMzcrS1EySVZleWFQZ0RoeVJO?=
 =?utf-8?B?WUZ4cEJ3TGdjSU1YS0R3dTcxMnZ3QkwrN0tlc1owUW04K1lBeFRoK3AzVlVX?=
 =?utf-8?B?TDZmaDZHcHFDWklxTXhBazROZDZsUlhjUVl0VzlmZmdyTmdsWEJISW5MaHhv?=
 =?utf-8?B?c1oyMmtpN0I0dFRJamNnbXA5VTZ6UUNBYTE3OFVrVWFremFQTU5pUzVGVit3?=
 =?utf-8?B?MTNkRnpnK01pUURGcDdad25YVnJGT0JyY2ZnR3FpK3FEN1NWa1dPUTczSmNt?=
 =?utf-8?B?a1ZsbnZLNjI5UjB5WmdWdG1rRXhsWGxvYlR4Vk50VFVRRHVNcXVkVmxsVmlD?=
 =?utf-8?B?YjlCNW1HRVhIejgyM1ZsZ1ZvWlVXbmkyREt0NW1XeXJlMDcxSW9CS24va0VE?=
 =?utf-8?B?THRUTUxaTW9Gb2JnVTdWNEl5WjJnVkZPZjkzWVdycXdNZWc4cU5HNjhwclVV?=
 =?utf-8?B?YndhVzh0NXI3eFk1Y3h3RGR0ZWQvbXZEUElQQjdUQk1Tc2haMjB5N2FUejlB?=
 =?utf-8?B?Q3lYYmg2QXZSMEMvSkhNZy9zclR0cTdWWEFCMUNxYmEyaVRkQnlIaVl6T0Mr?=
 =?utf-8?B?Ry9wOVZ3eEZxaTZPakJDNXJKcWdYcW1oSlJrNzNhNGFZVjh0TWtGTHZHRFVp?=
 =?utf-8?B?WVhCWmN2V3MzNDFrUWZHSnpzSDR6MmtIbXQ2aWE0U29NN0llTkJOd1UrcUFS?=
 =?utf-8?B?dlZPSWREeStTNk8wYVBvOXl4TXEzTUp6VTRiWEFaVUowRjlUTDNYNTF6UUhK?=
 =?utf-8?B?S1dnbG5WRHYvRWI0TkZMTU1UMlBNcVhMQnJKL2tHeUhSUXFmZjNpTjlnWWlR?=
 =?utf-8?B?dUNxZlhYNGFjMisvcWlkWWZ5QlBxY3ludDhMS2xaQ2tSYSs2OG1nbXBGMTRw?=
 =?utf-8?B?Ty9QandJV0NhU2lleE5ueEJTMHhFYzN4bzk0dnBvMFNjQldQMWx1THhBWUYy?=
 =?utf-8?B?N0ZiZDFGY2VCMkx5ZHRBbnh5RFN0YjhWZFZuOVRoVG1lODFKWjg5SGVkNGgv?=
 =?utf-8?Q?UTOh0qUXsBuCzdMUS4ZalhQ0t?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aab6b79-45e0-42b7-a226-08dbadbbc6f1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 02:57:01.2539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9k1sPW8BPP3V+vEPtdnOXZnP8AxHjddvJZBSw3iGLHkGeQ6fOdMA9HhmrDuYfZGKrhjkkuH9N68GLF47eaS2Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7880
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/23 18:04, Mathieu Desnoyers wrote:
> On 9/4/23 01:32, Yin Fengwei wrote:
>>
>>
>> On 7/19/23 14:34, kernel test robot wrote:
>>>
>>> hi, Mathieu Desnoyers,
>>>
>>> we noticed that this commit addressed issue:
>>>    "[linus:master] [sched] af7f588d8f: will-it-scale.per_thread_ops -13.9% regression"
>>> we reported before on:
>>>    https://lore.kernel.org/oe-lkp/202305151017.27581d75-yujie.liu@intel.com/
>>>
>>> we really saw a will-it-scale.per_thread_ops 92.2% improvement by this commit
>>> (details are as below).
>>> however, we also noticed a stress-ng regression.
>>>
>>> below detail report FYI.
>>>
>>>
>>> Hello,
>>>
>>> kernel test robot noticed a -6.5% regression of stress-ng.madvise.ops_per_sec on:
>>>
>>>
>>> commit: c1753fd02a0058ea43cbb31ab26d25be2f6cfe08 ("mm: move mm_count into its own cache line")
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>> I noticed that the struct mm_struct has following layout change after this patch.
>> Without the patch:
>>                  spinlock_t         page_table_lock;      /*   124     4 */
>>                  /* --- cacheline 2 boundary (128 bytes) --- */
>>                  struct rw_semaphore mmap_lock;           /*   128    40 */   ----> in one cache line
>>                  struct list_head   mmlist;               /*   168    16 */
>>                  int                mm_lock_seq;          /*   184     4 */
>>
>> With the patch:
>>                  spinlock_t         page_table_lock;      /*   180     4 */
>>                  struct rw_semaphore mmap_lock;           /*   184    40 */   ----> cross to two cache lines
>>                  /* --- cacheline 3 boundary (192 bytes) was 32 bytes ago --- */
>>                  struct list_head   mmlist;               /*   224    16 */
> 
> If your intent is just to make sure that mmap_lock is entirely contained
> within a cache line by forcing it to begin on a cache line boundary, you
> can do:
> 
> struct mm_struct {
> [...]
>     struct rw_semaphore mmap_lock ____cacheline_aligned_in_smp;
>     struct list_head mmlist;
> [...]
> };
> 
> The code above keeps mmlist on the same cache line as mmap_lock if
> there happens to be enough room in the cache line after mmap_lock.
> 
> Otherwise, if your intent is to also eliminate false sharing by making
> sure that mmap_lock sits alone in its cache line, you can do the following:
> 
> struct mm_struct {
> [...]
>     struct {
>         struct rw_semaphore mmap_lock;
>     } ____cacheline_aligned_in_smp;
>     struct list_head mmlist;
> [...]
> };
> 
> The code above keeps mmlist in a separate cache line from mmap_lock;
My patch is only to demonstrate where this regression come from. It's not
target for fixing. Thanks.


Regards
Yin, Fengwei

> 
> Depending on the usage, one or the other may be better. Comparative
> benchmarks of both approaches would help choosing the best way forward
> here.
> 
> Thanks,
> 
> Mathieu
> 
