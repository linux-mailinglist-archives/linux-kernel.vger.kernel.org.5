Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF1975863B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 22:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjGRUpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 16:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjGRUpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 16:45:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A828198C;
        Tue, 18 Jul 2023 13:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689713107; x=1721249107;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gCYzhuclPqL7GumJ3YdsxPULQDl4+V8NeL3mLESdecg=;
  b=gVrk3kTaBSGGUxoRRh+p21V0LEDdoYrBJI1YfSVsvtH3DwZ+Y9wzr/ty
   qlR0j+PLtkS5O5bgPV678l+yv22UPRbYo2Ft7KIskPuMBrwdAxiAbn7rr
   ujiLYn/jGZXM+o5TdCbAyNqxHHH5MzmLoas44zVIxtK8MajFFQeixzxx0
   JF7TeE1k2omLY4Jylc6vg16eoyOMY0Xbq9ZyVAwH9PfRpOHTm2RIGZ6/j
   PujEY/qOzJdQvC5gtCn5R9ocpLsIOdv1nUt58LwtuM3RyuZJcTnhZtQ7x
   4rzGkuf7FVm5KTS93bjOrWHfFZkLsebo9cTmCsoQRSGuGX3qC9kmYvqYp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="356256644"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="356256644"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 13:45:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="674051241"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="674051241"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 18 Jul 2023 13:45:06 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 13:45:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 13:45:05 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 13:45:05 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 13:45:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fh642t3cov9l98dRdxu17rNnbIe+1GOygFMj9QcxT+mmGiHh6ZQ5d+U4rzHZ8qip0BmvSeFTxGUJ4QyKduS7AZhdBZxGnYGKHA80xUhsgegmhOglaJWE9EqfbdKoubc6TXlWE2Iuq2jS1p9gsdtij9IdMFDW8lC2M4YjgaFwv1yWhpZufjJQyddGRy49s4B7s/FG7v2c91p5ePUrm01vSd/5AnV0+25+cfO2KFoZOR0wsN+n9nmvN5+x3zIVrlPrvk+Z6AkBmvAXj4C0HW/wSBcdosTHhNcWlsGFWhkNgXenefF3RhRAs2qIZD6qnUITbNmdDPh8wMPW/sdvr2x+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKVQvHkVkZOhozHaPRVD8TVWTLJ19vV+dk1g5zarH4M=;
 b=JVPoZ3LCbza7B6PUK0pwRK4hnZFLSxuCqbpT98+sjviKyshgmZamCwy5msgew0hYkw7dFp4e4GPQlRi66xsCAK86ItoYy6qdusAZWV7Z/IKnm9VhewAc7sUMFWG3GdOyA12wJVAfPRHj1/16jD05ws87lPXRN/rkynEivOzpHwXuGvYhCFXam8jP22Hzw5m+SruGYzNdIZX0d63DuQVjWBG+fF0AcyyLW1wBrOH91B8mBvT/Z0dQ/CYEmjwiQ6s9zakMZh/6lFQpIjDk6TdJbb4Zaue85GXGYQy2GrzaIjB7NvxGKpT0T88D6r06Omt7SQFcnioi5FscaV4uTsH33w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6346.namprd11.prod.outlook.com (2603:10b6:208:38a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 20:45:03 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28%5]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 20:45:02 +0000
Message-ID: <436375fe-92a4-648d-6e6c-649eacc320b8@intel.com>
Date:   Tue, 18 Jul 2023 13:45:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v3 7/8] x86/resctrl: Determine if Sub-NUMA Cluster is
 enabled and initialize.
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Shuah Khan" <skhan@linuxfoundation.org>, <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230713163207.219710-8-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230713163207.219710-8-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:303:8c::35) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6346:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b69557f-18bb-4f97-34c2-08db87cfdc4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B5evV3j0VHDelmW+DG6Wpku2Sqx0rlhIHs1f7DjM8CKoYmFQoBuXaBz4xj+yHwehh0xL6/cYZDKmlqrMuG5dV1ftPp/Wbs9uVZSGva1E9+4SwUUYI9fuQkb9/yVUvmb5PqtVF7PwqSncObD/ZHVkLZ9o5BBoL2yf8gT4LFN4HVvHizPqtpqdtzCBB8PqS7IwV85PvBDgYR/qnIqLh6U4Vv7Al0UgFj1zddhGVBKQnXt3/qwpr6HrWOMogzdIRzA/ELnkClNCziv9DTknAoTKO4tfWkngXRRGWyxYeZl9mja5nj47B7lcYn84mJiVJvllByn+MXy8JIw0/CqpD8POj3h2eEQapyCw/1HDeLG3t2u1N01/th9YweT0bowEG/qepQUz3fHeZRSbw49Y9D9EQYvymOWN/e7Nr9Q5Kv53NvrSCLzPCQT44EitwxVUGRhhpfiz9gKhISEJ1Kcj6XZC9gDCto8JMgf3okIRhV/oRbqn3INn/HA5ZNoOotUJWptPCj3ACIs0UvRYR+EvubP6CuvN/1Ps+fK162zgAaz1/4Uh5VffQWRfIP0p3QA9KNCf9ZLNLRyVbxfDGvH4swIM2Shz9t2QAGAu6pgD7j7WuY4z3Rvssq20T2K4t6dN3PHHxjPLO1GbgO5QiqBQJ095Bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(346002)(39860400002)(376002)(451199021)(110136005)(478600001)(6486002)(54906003)(53546011)(6506007)(186003)(6512007)(26005)(2906002)(44832011)(4326008)(316002)(66556008)(66946007)(41300700001)(7416002)(36756003)(8676002)(5660300002)(8936002)(82960400001)(38100700002)(66476007)(86362001)(31696002)(2616005)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2p6YTJDalBvaHdHU0JIcmxLOVFrYXp0dTNnTVhXeXFCSG42S21sVllDbDNk?=
 =?utf-8?B?ODAzb1ZGanpBMnZVb3pUVTIxN1lzMjB0VEhMR04rTnFvRW5WcVUxS2RENzc3?=
 =?utf-8?B?cGlWYlN6a1oxT2VIZEI0STZHaWFaZDVqZUhQa1A3Rk83b3QvcFI0ZFNnZmR1?=
 =?utf-8?B?ZjZOSXVtR3dtdTJYVW5JcTRhOCs4UUh5YlR5U24vN09WbmlkVUM1cnNtckxm?=
 =?utf-8?B?U1hOU25uYUY2TVBsbXRvaHhhTlFkRzgwVWJxUVNLblpqUGZJZ3N3NGpCS3Ns?=
 =?utf-8?B?cVRyajhOcEZSb1FUdld4clRZMUF6anVnVEhXNVNsVi9VQ3pZVzhYaElsdmJn?=
 =?utf-8?B?TGNQdmVndm16c3NPS205Nkc4Qk0xaVhQeXFyUmY2d1ZDeTZUY2FCa0RUcERO?=
 =?utf-8?B?VDJmTmhlcStRdkZ4bUUxT0pqemFSUWFBL1FsYURxbXdqVnJYbE9NVDY5c040?=
 =?utf-8?B?c201OWFEQlBtSER5YTVhQWpQOTJGZzlwcFU4UmFJcGVITHc2NzF4c1A4aGhN?=
 =?utf-8?B?YkNnUG1zc1Z2emE3MWt5YVEzNTJ4blRuQnJRQTZlNzdWL1NKdWI0Uk44NWZL?=
 =?utf-8?B?alEvZXBXclF6b3R5bFVKb0hGSlpYanJ4QVh4Sm1rRWF4aTZIQ0xtLzdVaHd1?=
 =?utf-8?B?REo0S3IyRlI0SmljMFlTSVlFTU5CL0hxdjNPd2JlRWQ4UXdkL1NFUHNPOUFl?=
 =?utf-8?B?MUp4ZGg2SnZkQnlnamxZVWVPN3B4bmdUb3ZGTTE3NC9ldEZ4dzk3a0lQdW5F?=
 =?utf-8?B?N3pySlRGUnNWRHovdWFBbjZCL0FhZDd1dVVyMmVhVk9reGc1U09DM0JjL292?=
 =?utf-8?B?TU5YZXlFOFNsSzB3K3d1NDF0M092OHAvS3U3OVdjaS81VEhpdjZrd0JibDVx?=
 =?utf-8?B?U3NBY0ljRk5QQTBTcUwveDBZeGswWDI5SE5qVGE1SCtSaFZTWHpyUHRVa0xs?=
 =?utf-8?B?VjdDZk1MMnJ2RzZ2ekMyWmxmVXN0Z1FaaU0wSnRxUFJnNWdMTWMwY213MHFS?=
 =?utf-8?B?RUYyQUhiRmNpUXdsMk5UWG5CRzkrblBlSTZ2ZGI1dDBUNmcvQ0xFR2g0TThv?=
 =?utf-8?B?MlBiTDdPbmc4U0s5SFBpS001SG1xVHNkbW1FSlU5RVpuTDU1aTMyanBWQVVW?=
 =?utf-8?B?eUpLWHV3VHpzdWY0TDc2aVIxNW1OSzlLTDBaQ01oTE1xbE5UV09rTjNDU3RP?=
 =?utf-8?B?Y3k4QTlYbkFkYzcvVXQwM3N4ekwrSWh6b3B1YS84d0dnYVNTcS93Mjd3QTMv?=
 =?utf-8?B?cElraVV1QkdaZmxCQzRjRDhjYkdXbzRXNjNzZTRFd0w5ekhDdjk2V1RObm9t?=
 =?utf-8?B?Rmk2SWFlcjRlSkx4YWNIYnF1SWhTczZYekFSb3crUk1oU0FLNVFWNnA5STNK?=
 =?utf-8?B?MUNoTlgrWkZNWFA4bXg0aTdFRDFuWnRpaVU3cGZERTFQdTRXcVcxNzN0SXND?=
 =?utf-8?B?SWd5TmplOVZnSVNFTTRXZ0dGNHJpVk1lNkE4bUxZZkFEZW0xREVRMjRBWDAz?=
 =?utf-8?B?blM3UWZjenlyOEpXMW13U3NTQ3RpSDRHQi80MUsyakg3LzZGbTNkcjJ1MGhs?=
 =?utf-8?B?Zm50Tmc0aVcxekZERFlLUCtRQWJ3OE1ibFh0ZkNXcHhpTFkxTUl6M2E5ZHpx?=
 =?utf-8?B?WDBnQXZiZE9HN2FONVZGdEJQOG5iTytmRnUvNDJaT3g0SnEyVk9mY0FpVXRs?=
 =?utf-8?B?SUlVRzlTcmlJbjBtUFZxL05oa3hYdis5U0RSMXFGaDNUZWViSEIzSmNxZldC?=
 =?utf-8?B?ZHdZMk5BcmNhSi9GOFJ6eWpLaWRjRHppUDZvWnZhVU5zN0ZheFFzRWRNNnF2?=
 =?utf-8?B?dlNXNXdLQWovQ2NvYmczOVNCcDUwLzNwMjZQb1R6MUt5RkFvLzRsWTd4aVVL?=
 =?utf-8?B?K0V1VlRUc2p2c1U3YmdIcmZGMVk2eUVxYWZISVFCM3FjaDQ4dEpJek4yR3U0?=
 =?utf-8?B?SFdIWUlCZXRDbWlZRHU4Wms3WS9HdjZid1NDUXd1SjRET1FLTzVPSisxYzk5?=
 =?utf-8?B?bkgyNnJLNWxRYU1QdmlLVHFrZ0NjajRMbmVkeEpaYW1YaDB1NmJZaVNMTFJh?=
 =?utf-8?B?MUVSY3hPQkkyaDYxTmtpYmlzTzVkakNZaWNIMmQ1empvMjRNVUJXTzBFdnYx?=
 =?utf-8?B?d3VlZE5wRUJJbFVaMjRwNjlXblUwZS9ZZVJJeWJXekJsVTZLZFh2dkxHS2I5?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b69557f-18bb-4f97-34c2-08db87cfdc4b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 20:45:02.8260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UVcF3AVwHhA0JuxKGqfko0Kzj6uTmpRO366umaYbndfzHqVgQz4UNIeXIo6ZtF6hVef+VXcRCYoBhJZzV4vAsYhk+w4twqxDhwr+8VYVtg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6346
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 7/13/2023 9:32 AM, Tony Luck wrote:
> There isn't a simple hardware enumeration to indicate to software that
> a system is running with Sub-NUMA Cluster enabled.

This changelog appears to _almost_ be identical to the cover letter. There
is no problem with changelog and cover letter being identical but it makes
things confusing when there are slight differences between the text.
For example, "Sub-NUMA Cluster" vs "Sub-NUMA Clustering". With this difference
between the two the reader is left wondering what behind the difference is.

> 
> Compare the number of NUMA nodes with the number of L3 caches to calculate
> the number of Sub-NUMA nodes per L3 cache.
> 
> When Sub-NUMA cluster mode is enabled in BIOS setup the RMID counters
> are distributed equally between the SNC nodes within each socket.
> 
> E.g. if there are 400 RMID counters, and the system is configured with
> two SNC nodes per socket, then RMID counter 0..199 are used on SNC node
> 0 on the socket, and RMID counter 200..399 on SNC node 1.
> 
> A model specific MSR (0xca0) can change the configuration of the RMIDs
> when SNC mode is enabled.
> 
> The MSR controls the interpretation of the RMID field in the
> IA32_PQR_ASSOC MSR so that the appropriate hardware counters
> within the SNC node are updated.
> 
> Also initialize a per-cpu RMID offset value. Use this
> to calculate the value to write to the IA32_QM_EVTSEL MSR when
> reading RMID event values.
> 
> N.B. this works well for well-behaved NUMA applications that access
> memory predominantly from the local memory node. For applications that
> access memory across multiple nodes it may be necessary for the user
> to read counters for all SNC nodes on a socket and add the values to
> get the actual LLC occupancy or memory bandwidth. Perhaps this isn't
> all that different from applications that span across multiple sockets
> in a legacy system.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Peter Newman <peternewman@google.com>
> Tested-by: Peter Newman <peternewman@google.com>
> ---
>  arch/x86/include/asm/resctrl.h         |  2 +
>  arch/x86/kernel/cpu/resctrl/core.c     | 99 +++++++++++++++++++++++++-
>  arch/x86/kernel/cpu/resctrl/monitor.c  |  2 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  2 +-
>  4 files changed, 100 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.h
> index 255a78d9d906..f95e69bacc65 100644
> --- a/arch/x86/include/asm/resctrl.h
> +++ b/arch/x86/include/asm/resctrl.h
> @@ -35,6 +35,8 @@ DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
>  DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
>  DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>  
> +DECLARE_PER_CPU(int, rmid_offset);
> +
>  /*
>   * __resctrl_sched_in() - Writes the task's CLOSid/RMID to IA32_PQR_MSR
>   *
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index af3be3c2db96..a03ff1a95624 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -16,11 +16,14 @@
>  
>  #define pr_fmt(fmt)	"resctrl: " fmt
>  
> +#include <linux/cpu.h>
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/cacheinfo.h>
>  #include <linux/cpuhotplug.h>
> +#include <linux/mod_devicetable.h>
>  
> +#include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
>  #include <asm/resctrl.h>
>  #include "internal.h"
> @@ -524,6 +527,39 @@ static int get_domain_id(int cpu, enum resctrl_scope scope)
>  	}
>  }
>  
> +DEFINE_PER_CPU(int, rmid_offset);
> +
> +static void set_per_cpu_rmid_offset(int cpu, struct rdt_resource *r)
> +{
> +	this_cpu_write(rmid_offset, (cpu_to_node(cpu) % snc_ways) * r->num_rmid);
> +}

Does this mean that per-cpu data is used as a way to keep "per SNC node" data?
Why is it required for this to be per-cpu data instead of, for example, the
offset computed when it is needed?

> +
> +/*
> + * This MSR provides for configuration of RMIDs on Sub-NUMA Cluster
> + * systems.
> + * Bit0 = 1 (default) For legacy configuration
> + * Bit0 = 0 RMIDs are divided evenly between SNC nodes.
> + */
> +#define MSR_RMID_SNC_CONFIG   0xCA0

Please move to msr-index.h. For reference:
97fa21f65c3e ("x86/resctrl: Move MSR defines into msr-index.h")

> +
> +static void snc_add_pkg(void)
> +{
> +	u64	msrval;
> +
> +	rdmsrl(MSR_RMID_SNC_CONFIG, msrval);
> +	msrval &= ~BIT_ULL(0);
> +	wrmsrl(MSR_RMID_SNC_CONFIG, msrval);
> +}
> +
> +static void snc_remove_pkg(void)
> +{
> +	u64	msrval;
> +
> +	rdmsrl(MSR_RMID_SNC_CONFIG, msrval);
> +	msrval |= BIT_ULL(0);
> +	wrmsrl(MSR_RMID_SNC_CONFIG, msrval);
> +}
> +
>  /*
>   * domain_add_cpu - Add a cpu to a resource's domain list.
>   *
> @@ -555,6 +591,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  		cpumask_set_cpu(cpu, &d->cpu_mask);
>  		if (r->cache.arch_has_per_cpu_cfg)
>  			rdt_domain_reconfigure_cdp(r);
> +		if (r->mon_capable)
> +			set_per_cpu_rmid_offset(cpu, r);
>  		return;
>  	}
>  
> @@ -573,11 +611,17 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  		return;
>  	}
>  
> -	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
> -		domain_free(hw_dom);
> -		return;
> +	if (r->mon_capable) {
> +		if (arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
> +			domain_free(hw_dom);
> +			return;
> +		}
> +		set_per_cpu_rmid_offset(cpu, r);
>  	}
>  
> +	if (r->pkg_actions)
> +		snc_add_pkg();
> +

This seems unnecessary use of a resctrl resource.


>  	list_add_tail(&d->list, add_pos);
>  
>  	err = resctrl_online_domain(r, d);
> @@ -613,6 +657,9 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  			d->plr->d = NULL;
>  		domain_free(hw_dom);
>  
> +		if (r->pkg_actions)
> +			snc_remove_pkg();
> +
>  		return;
>  	}
>  
> @@ -899,11 +946,57 @@ static __init bool get_rdt_resources(void)
>  	return (rdt_mon_capable || rdt_alloc_capable);
>  }
>  
> +static const struct x86_cpu_id snc_cpu_ids[] __initconst = {
> +	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X, 0),
> +	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, 0),
> +	X86_MATCH_INTEL_FAM6_MODEL(EMERALDRAPIDS_X, 0),
> +	{}
> +};
> +
> +/*
> + * There isn't a simple enumeration bit to show whether SNC mode
> + * is enabled. Look at the ratio of number of NUMA nodes to the
> + * number of distinct L3 caches. Take care to skip memory-only nodes.
> + */
> +static __init int find_snc_ways(void)

Based on the function comment and function name it is not clear what
this function is intended to do. In cache "ways" have a particular meaning,
what does "ways" mean in this context? 

> +{
> +	unsigned long *node_caches;
> +	int mem_only_nodes = 0;
> +	int cpu, node, ret;
> +
> +	if (!x86_match_cpu(snc_cpu_ids))
> +		return 1;
> +
> +	node_caches = kcalloc(BITS_TO_LONGS(nr_node_ids), sizeof(*node_caches), GFP_KERNEL);
> +	if (!node_caches)
> +		return 1;
> +
> +	cpus_read_lock();
> +	for_each_node(node) {
> +		cpu = cpumask_first(cpumask_of_node(node));
> +		if (cpu < nr_cpu_ids)
> +			set_bit(get_cpu_cacheinfo_id(cpu, 3), node_caches);
> +		else
> +			mem_only_nodes++;
> +	}
> +	cpus_read_unlock();
> +
> +	ret = (nr_node_ids - mem_only_nodes) / bitmap_weight(node_caches, nr_node_ids);
> +	kfree(node_caches);
> +
> +	if (ret > 1)
> +		rdt_resources_all[RDT_RESOURCE_PKG].r_resctrl.pkg_actions = true;
> +
> +	return ret;
> +}
> +
>  static __init void rdt_init_res_defs_intel(void)
>  {
>  	struct rdt_hw_resource *hw_res;
>  	struct rdt_resource *r;
>  
> +	snc_ways = find_snc_ways();
> +
>  	for_each_rdt_resource(r) {
>  		hw_res = resctrl_to_arch_res(r);
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index da3f36212898..74db99d299e1 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -160,7 +160,7 @@ static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
>  	 * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
>  	 * are error bits.
>  	 */
> -	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
> +	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid + this_cpu_read(rmid_offset));
>  	rdmsrl(MSR_IA32_QM_CTR, msr_val);
>  
>  	if (msr_val & RMID_VAL_ERROR)
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index d037f3da9e55..1a9c38b018ba 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1354,7 +1354,7 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
>  		}
>  	}
>  
> -	return size;
> +	return size / snc_ways;
>  }
>  
>  /**

The last hunk does not seem to be covered in the changelog.

Reinette
