Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546A078B5F9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjH1RGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjH1RGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:06:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280D0B4;
        Mon, 28 Aug 2023 10:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693242373; x=1724778373;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=msaPXQB2s2iVe3YMB5Igy3AndNwYaMylQy45adAeVi4=;
  b=AHDjjPw/t7EtpSrYq7JOYKnLpXNjTPylF/gvOu1U5i2kuWdgyOweJS2w
   a/zVjWSchNfKO7/GDyFCYScdUL7KoTcl08wDUN+E9z1d/W+aTx9vVsotu
   Do9BIeFzBdTUli40QKH5zZJB7OVkzATc9dsUsHMqRXb+T4sDo1E5AUQFr
   3Nx6VKqQj2G1be91X7HwYDIXN98jtf5ymWbHlP2IGAv9J9zxNFtsbGw2J
   +XuYsj5t6INa/Nn9e64pJZHbEb5JVa3VFmlR+C0bqtR7k1WOTsHhIMD9z
   R96NZZHKiwkc/gwyr2tsS35h3XnUl//os3Pf8EJGh2JdJUJBXRz6AJNN/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="441502057"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="441502057"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 10:06:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="741475926"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="741475926"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 28 Aug 2023 10:06:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 10:05:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 10:05:55 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 10:05:55 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 28 Aug 2023 10:05:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evwav9ulTn3hHQjAoxkvEHecGDXJW1vu09o4haNiRwgzud9WCGqrJHyVay4/B2Ae9xyWUBV5QaWMmg7i1DituitpCaR9tqsWHZYFmxP1bDf1NYnhLl0xWU7Dxebszatu33nVv/YqFdwvZTga1zXhN7bzOgFLOLwWF4DkIJdy7S9LCgXdfuVXwbHxYVDMm3fRq80666PLZLTB/KMlzXkGkRrnVHDz5pu8PbQwmtvoRk5OY8z2ZiUxhJmhouRa6v/KWRZQEdpsugCsLPe6MAl2LZnZUiz+y/h4XH3SVvc6NdSMT+ar3/RUP9RQjlPhwLkejD6aoTf/AShOXKwNMaYk0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZEt2oy0wV5SlT2cmNKQL6wnAo5Is8Mt+6B1s+iIihQ=;
 b=ShEnxqHCsdLO01JlpGvY11jIXyes1aOTcz5Gn7kM9rif09fnzq7ahxU9+BbKMjK8zO8RpjxmXYP2ja0FGrC6S29Uns+SSUodXd2CI65qUYFifMnGUpIdSTsXAnrm2h3AS9G4h7oJSh1+lbuUX3RNJUFXLdng6Dk2MstYAKp+qw5DLPnZG6D1IoHvkt4gTZDughZeSJ+Njy1f5K/Scm5DFIe9O1zZo1cCdo2ffuMCuIzIhOPstrg/VkOQgYhg6ZI4fQLvkgy8cuG/h9daDbCL01cCDLteAU4+gy/Hn5wM7HzdHf2ehpPshap7CFcXT9KQA/iDnLk6DI0mqFFLYHCx+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA0PR11MB4750.namprd11.prod.outlook.com (2603:10b6:806:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Mon, 28 Aug
 2023 17:05:53 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 17:05:53 +0000
Message-ID: <15b289cd-3e9c-3757-c1b0-7f5f79244564@intel.com>
Date:   Mon, 28 Aug 2023 10:05:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v4 5/7] x86/resctrl: Determine if Sub-NUMA Cluster is
 enabled and initialize.
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230722190740.326190-1-tony.luck@intel.com>
 <20230722190740.326190-6-tony.luck@intel.com>
 <7c8650d5-eb69-dd28-81fc-7a97d45f9bfb@intel.com>
 <ZOjpugXNDVx/cGRl@agluck-desk3>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZOjpugXNDVx/cGRl@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0284.namprd04.prod.outlook.com
 (2603:10b6:303:89::19) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA0PR11MB4750:EE_
X-MS-Office365-Filtering-Correlation-Id: 41918d47-9161-43ad-2b51-08dba7e909a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a6kno0wJ+aRQMGLGzJ6PWTtHuvn3irlMzgXZgn1myfvDORiDDfhjiPqTz2Me+4adi+DaYjvNQsYCfdEGoSjclNIMNEBnguAb6dZ7WX8dVkkioyruXHtuLvA/mawU++m1rYTxC8aVp8MeuG8MEftMEzpeA5p5zErnghJWG13vMDGfIl0YbWyQA2b5Pqc5uNJOHbzNLdCiNEz3M6zKZ+Y9ES6bHnCJnpsyd4yA/cVQFcKAwhhzrEhVi7XMLmQ/G5hnlfhE9WzcSKUY/9THgNoK132MN7tQNn/8aXaN1//rlL7rzIw08tjFFrwklpNdbenirA/fTaMsgfQC6gveoqGjkPOMXuRmAZiljxqjd4ZuRrKhJ3fWcd0mJrn6bzCnHPfIVCEl5dFJqsgFZP84ogLNcPnrxccHKEiXw8Eeu1mTCPpscCt7Q2kfxTjwbIVnYBmDVO3lpe0qOm8fOTtz5kLQAoZe2/p2+f4eJ68CwQy9BWX03XZC25gTBKjAl6zWUH3yCUZxgkOqEat0Jq0aRrSIelqH4f9GcVygcyFNGpClaf7lU3bZWGezjg8AFkxA5i/SdheNx3hDLihg78kpzZJLcLwL9zY+5dgT5IHGZPtXekPDMaLIeMxRtI0NoMhuWlo3BXIi/FfpiVQ92WIcHxHysQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(366004)(346002)(39860400002)(1800799009)(186009)(451199024)(31686004)(6506007)(6486002)(6512007)(36756003)(86362001)(82960400001)(38100700002)(31696002)(83380400001)(2906002)(26005)(53546011)(478600001)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(4326008)(6862004)(44832011)(5660300002)(2616005)(7416002)(6636002)(54906003)(316002)(37006003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWNtRDd0ZTJSaENwUDdOSG9SbGVaUTNNcUh6SXhPRVQwSWZGYzZVVmExdHI1?=
 =?utf-8?B?eFExUUtPUFVOaTMwWEdQTm5jRWhSVUNhRWRKZ1ZMQnROVExRV1N2clArNnp2?=
 =?utf-8?B?dHhnclVxdkhWemtSK1gxYVdpdkE5NGtCK2xTeUNaVlJOV25wRXZqdGxBN3Rh?=
 =?utf-8?B?TG10YkRTbk9ZZVNGQ2ZPMW9jcDhZczZjTkRGVTU2ZEQxZHkyTXNaN2puNElx?=
 =?utf-8?B?MWQ1SERQbjBVNktkZWdVS3FORmlka1VvL01HZU1BOVVOY3lVMDhkLzZGRXJX?=
 =?utf-8?B?OHBEWWFOQlYyVVJLZ0JWNUR1S282SlBYNlZ6V0pZZU91bXprcDNXUm5kaysv?=
 =?utf-8?B?RVc5R2pVZWpOL00xRHBraG94L1pOaU5HK2srbzUwZjVMZ0hsOGE3QVZZOXBO?=
 =?utf-8?B?NlVDdUhMZnV2Z3RoYlJ6bHpxY1FMZ0RidG5sd0tkOHJQeVhWdFM1YjBHRHI2?=
 =?utf-8?B?dkFaV0NCRUtaeDFqalNoeDgyMC96NVNZZUpvSyt3eStBMmh3Qll0U0p2R05k?=
 =?utf-8?B?bUJLcE9pOHFHUC9TUXplNkJGN1RicGZJb3l2UjZYVWE2MTRGWVRRN0plZS9z?=
 =?utf-8?B?R1lMMUhBeGhrRGVtclMvVGNmVWZPZW1LdkVoSTBOTEJBTUxiajBUdlBsNExE?=
 =?utf-8?B?dTdyUUhDbG5LMVJmMzFrVmxjTTRvd1BBRSs0SkF4TEdzbHpOZFpPSEdHRzR3?=
 =?utf-8?B?QkpiYjlTMmtEY3NZNEc3S0hTU2dsbHJJYXdGTGg1dEVzcnVLTXQ2LzY5dFUy?=
 =?utf-8?B?dytJUUdSazl3bjlneXlrakVvY3Vra1lrRExhL0FZQ0dFTURxZTZRTXFhRzFC?=
 =?utf-8?B?T1Bxb3pyZ3kwZVpCNjhjem9pcHcxMlBzaUpxM0dtQkVIYzhqODNPUFFRS0w4?=
 =?utf-8?B?SGdJb1A3NmJYaDdUNGdGaVlJZjlPd3dvQU53QmUxSm5QSWZKM2ljR0taTmNa?=
 =?utf-8?B?UitNVGFwdURHZjBMOVdnL0VVamMwTGxDeWNGNTlGZ1ZIRDJZZzhsKzNUWll5?=
 =?utf-8?B?ckh5RFVwMURxTG1TK3dWb2NUY2pYeDB4cnkrUmdJOS9ST0pHTHkwaEVEcWFX?=
 =?utf-8?B?dzFhSHFwUmtJcGhsVW1HdHoycnVYVDY0ejRBcnFEa1VBR3luQUhWdk96cWNJ?=
 =?utf-8?B?VlRxcEp1ME41aU4rMG5sQjVIRXFzS2VqQXZLcW5zR09SWVNWais3VlJ3VkNC?=
 =?utf-8?B?VVlrMzhBMExGZVdKL0Rha3pOV2ZhRndpS3ZTTklXZkRxZndNdkxGcWZlMTVK?=
 =?utf-8?B?K2M0eE4yM1MrazA2VVVNZ28vOFlvcnpkN1hPdVdMc0JvenBQWHF6VUdHSDIr?=
 =?utf-8?B?OVBCSFZxazN0b1ViWjRqaTZwWkZwZkR6d0xXOFY0UVF2YkNvcWdQZWZISEtD?=
 =?utf-8?B?QzA5eHNmeXBHdmxRYWM5SW9id1prRmxrWjdheE53bjNRSEJQaEN2MUM1Q2xJ?=
 =?utf-8?B?d1ZFSTNBTEkvZkFINXd5T09MUGdHREdwdkdheEZZWnpVVnBhSGpKU2VSUjVW?=
 =?utf-8?B?NkZDNktlYzVRUUFhMGJhMWNUSFVzYkFhcWZDRDNmOEhPK0FiNTY5TnMwNWNl?=
 =?utf-8?B?QWxjZTFrQldoYVJWQ0R3L0kwUFBCNjRVUUJ0RGdKeTUzWVhRQkR5REdMbGZm?=
 =?utf-8?B?Z1RIbFFDSFJBdnAxNjV5aTUyM1pENktzTDB6OUpJSVBEQm92VTlyWkFTaDBv?=
 =?utf-8?B?YWNHemdTZDlYMzM2SmxPTjQvcWQyZ1VpZWJGdU9XYVZjbjhMTDFjQitPNWJT?=
 =?utf-8?B?WXhBNGZCRGZBZzg0Y2lWU3lESnUrdGNVZGdSN0NaSE9uKzFtR2tkdzRMWUxU?=
 =?utf-8?B?WlhEYlF2ajRVVGpBYkkzUTlSSUZLOGUzSVlQeTZ4d0IxTDhjTnlWTkFINGlz?=
 =?utf-8?B?TnZwSkgvTTR0YVZacmc4UlJjTkhwUVFBek5KTjJKT2xtRGQxcEhTSFdJQlpx?=
 =?utf-8?B?NnZkQzRkVzcvMFFPeTlhNGVQbVhjc3ZUY20rSWpORmZqbGl2MWY3emVlVHZ5?=
 =?utf-8?B?WmowSGh3eTkwcklvWUM5RzZRdkswVUk3ZU5SL2xMaGEyellpdkFCWDdQR2dC?=
 =?utf-8?B?YXZKM1l0YmViTVROY1lVVXR1QVZmSk5acGQ4bDhaczZqU2hVcGVFNkNrVHla?=
 =?utf-8?B?eTBRN0c4bkkyWFNldFRzNThHQ0gwMUQwVGlhWmtISUlZaXEwcjFabHN3ZGpr?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41918d47-9161-43ad-2b51-08dba7e909a7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 17:05:53.5739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dit0RIDiPMbpJeae5jEjtnZ4I9Jja4VjIZeszS1a/Jqga/85rccdoGPoHdRgPwEF6VgRCLyEJ5KRc5G+F1B7drLCU0KdjdC/CaVIKMVMDnc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4750
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 8/25/2023 10:49 AM, Tony Luck wrote:
> On Fri, Aug 11, 2023 at 10:32:29AM -0700, Reinette Chatre wrote:
>> On 7/22/2023 12:07 PM, Tony Luck wrote:

...

>>> +static const struct x86_cpu_id snc_cpu_ids[] __initconst = {
>>> +	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X, 0),
>>> +	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, 0),
>>> +	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X, 0),
>>> +	{}
>>> +};
>>> +
>>> +/*
>>> + * There isn't a simple enumeration bit to show whether SNC mode
>>> + * is enabled. Look at the ratio of number of NUMA nodes to the
>>> + * number of distinct L3 caches. Take care to skip memory-only nodes.
>>> + */
>>> +static __init int get_snc_config(void)
>>> +{
>>> +	unsigned long *node_caches;
>>> +	int mem_only_nodes = 0;
>>> +	int cpu, node, ret;
>>> +
>>> +	if (!x86_match_cpu(snc_cpu_ids))
>>> +		return 1;
>>> +
>>> +	node_caches = kcalloc(BITS_TO_LONGS(nr_node_ids), sizeof(*node_caches), GFP_KERNEL);
>>> +	if (!node_caches)
>>> +		return 1;
>>> +
>>> +	cpus_read_lock();
>>> +	for_each_node(node) {
>>> +		cpu = cpumask_first(cpumask_of_node(node));
>>> +		if (cpu < nr_cpu_ids)
>>> +			set_bit(get_cpu_cacheinfo_id(cpu, 3), node_caches);
>>> +		else
>>> +			mem_only_nodes++;
>>> +	}
>>> +	cpus_read_unlock();
>>
>> I am not familiar with the numa code at all so please correct me
>> where I am wrong. I do see that nr_node_ids is initialized with __init code
>> so it should be accurate at this point. It looks to me like this initialization
>> assumes that at least one CPU per node will be online at the time it is run.
>> It is not clear to me that this assumption would always be true. 
> 
> Resctrl initialization is kicked off as a late_initcall(). So all CPUs
> and devices are fully initialized before this code runs.
> 
> Resctrl can't be moved to an "init" state before CPUs are brought online
> because it makes a call to cpuhp_setup_state() to get callbacks for
> online/offline CPU events ... that call can't be done early.

Apologies but this is not so obvious to me. From what I understand a
system need not be booted with all CPUs online. CPUs can be brought
online at any time.

>>> +
>>> +	ret = (nr_node_ids - mem_only_nodes) / bitmap_weight(node_caches, nr_node_ids);
>>> +	kfree(node_caches);
>>> +
>>> +	if (ret > 1)
>>> +		rdt_resources_all[RDT_RESOURCE_L3].r_resctrl.mon_scope = MON_SCOPE_NODE;
>>> +
>>> +	return ret;
>>> +}
>>> +


Reinette
