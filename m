Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642827AE23E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233520AbjIYX2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbjIYX16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:27:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344D2116;
        Mon, 25 Sep 2023 16:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695684472; x=1727220472;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jQcUUiijoO3dsVYjrGr0cEOV8acaU3vKxD0kdu5mJo0=;
  b=JGt6ntof8JUaaLjLt/uQKj5j+V+Dn+PywACzppxzkIn9+HuaKxns2PFJ
   lAuOrNGLOd22cRbAzjeamXTPdy16l6tOPUxYRpnXazFuuDJWmMRhfX31W
   Hb770BoYUmKyCxUp3H1jBMMjw0KpbxW4GfI32DZXiA9y78k9oSUpCknus
   EvttPNPO6G9oVVh2mhlUcgR5MOq2iJKpD2PVgoF/nmyuJTSlmi1XKGTrT
   r9985aGcXntD2PthiI/MuJlZ/rbSRqmehsvBzwcWyYLOap/R/HS2V+xTU
   i15IJdXsYrUetCtcC2GO5+fE4D6Anvq7Aroz7A/w2ochCJhWC0bVDeUtF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="380303499"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="380303499"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 16:27:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="838774290"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="838774290"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 16:27:51 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 16:27:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 16:27:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 16:27:50 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 16:27:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYos9Qits2DRqaP0DCHD1uGF3lp1GladGA8e5MS1MPeOZoXib2H6OhsV/dwrgUyUXYIit4nzk+B8T5Mcd+v2phLga3XhFoMt9i5Wk64K/ZTzkH6LDO4sZfmzeNShcXH4/9mWi5ucapGBNVsBPAqDwHP+q7kMV7IfCmUtRTCSBt6qRY/PX4QtxCtAhaXeIToeF7LY4vlqgnD9kFQZvo+swvxadfEnwto2yrYkpmx/rTEnnV5SWGgckiIq2/T6ESHpMnYNR17Ind9qBsrejIu0J/54QMUFSkSvnLEzpd1fLH6ub/FVbIDv56xQhdDhRqZVjh13OQP0h1PaxzuQTWZwgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggEVj+PtnYYGMWcdf8wGCpWx3voFTTK1++7ecdI9Sr8=;
 b=KhygRB3NZezpZKcu0n6R7JDXwwaqCOA4nm3QhrkgK2OkIjovrIN+YmoXhrp7eUn3eRs4UUMG4ssaJCCPsMh3B3YYD5Hesgc4M7Fw69K7LB9oVTFJjGanxIvvuMMYvv4KSjY1Wvk+OhKcNDUcjJLt64V2y0tw4HlGF+J+Y5St49lv96bfySMwwvAcT5cZ0dDS9ggjMVHFnqTBQ+bY0xT6VUHmLUD7c/R4XUaXwAD5AKNljap3qfKa1pmiSwjPP8tUHJihBk/MWgKDdqFQhivZ4WLRIPqP/Y91c+UaibpnesA36BvWH9ZbC2TcDeq4Y6nE5C0WZ1sJ1PrVpox2r7jilg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7683.namprd11.prod.outlook.com (2603:10b6:8:df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 25 Sep
 2023 23:27:48 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 23:27:48 +0000
Message-ID: <80393c0e-29fd-dd02-75b4-f0640e162c8d@intel.com>
Date:   Mon, 25 Sep 2023 16:27:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v5 5/8] x86/resctrl: Introduce snc_nodes_per_l3_cache
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
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-6-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230829234426.64421-6-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 45710ff6-2bb6-42c8-2635-08dbbe1f0771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 69lggV98W34CZjIrE30Ku7Elvcd/uRvVetw/+lplcqGx6JVBzKSeb/3msnl9BiI5Hrr5CsM64M4kjsIodbmSE+YjUh11QAS3h/X+dqrmsZfcnBarer1US/Z3eL6qCxQTyywV+SNyL6S3DPPC41eD0POglFe2RrAbkMEkhe4FOJt8wMUnFuR/IE9erCKQA/RlIhmtoySa499VXthg2HdghN4XP5QtuBdb46mnGwRG4AqllqT1WuspK/4mqMbPXmmS3FVUpFQ+/Z0840ztALC322KCfsj00kFzNkRgSWbOQqwGSsQOT2J0r9BJyUlL4G/xRoMYkNfLfIRNpJ9pluHugZZoJQbgpw09VzpJOEKrV/2dLXedGjj1FF4gyo5MjzH+07rtANSwxPl+EetRXzohZqCK8kv2IHZFI1aeic91BzAtjjkgZ8WlzxrpIe7uMPo/QniAeq26zOlXVLuZi5HSCl1S8IrtqoFY5QytvU4tKZpfX1241mron/ke0XlKBDFjzPwAeg7GrMssiwqj3wnaMswWlw6jUzDQmhPJ6oGghx6Qf/iirC/s17wBi4VBV5/7+hl5wkEj7vMZH7eBaG1MDavEGDrVljjlaCJx+byZUWjemuqbWVWQbCXZ/CHaiwoDYPBjPjqBsNz3d68ytlcVhA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(478600001)(2616005)(53546011)(6506007)(6512007)(31696002)(66556008)(110136005)(26005)(6486002)(82960400001)(66476007)(38100700002)(36756003)(316002)(2906002)(5660300002)(44832011)(4326008)(6666004)(7416002)(41300700001)(8936002)(66946007)(8676002)(54906003)(86362001)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T21zQ1VCZW9nMDJCZE5HaVZKU0cyQ3VJK0xqTTAyVGZHU1BRSVVmSEo2b2th?=
 =?utf-8?B?N2I0eTdYa0hpMi82K1k1Q3JqME1IUjkwM0wvb052VzlzTUQ5SUNuUnR0a2Vt?=
 =?utf-8?B?TnBPQUxGV1BDU2J0SjNmSHRQSlVnZlgvR2ZkZFZFQmZ2Y1VCMC8xMkxZNGlz?=
 =?utf-8?B?ak9HT09SVjk3bngzYU5Tcy85NnlndVBVWHV5REtMTUxPTStwbUl0cUZOZ2R2?=
 =?utf-8?B?cXJydGdHU202UVh2aW9Yd2l1NEVhT0E2Q29RTG9aamZ5cWVGS1NjNmp6dndh?=
 =?utf-8?B?Qjk1bHVBMFBBdDFXQkZYaEtJcmtwWGsreUcrcG9nd1NwSjlnUVYyOXRzaUdN?=
 =?utf-8?B?K0g5NHgyc3laYytveXFSTDhxbmY4ckwwQ2ZCYjgwUDlaZkI4SXhOTG8zZWdh?=
 =?utf-8?B?RVp1SWIzMUVFK3RZWHZEMWMwaU9mRWNObGE0ZjdPNnZreVpTNmpTaFA0U2N6?=
 =?utf-8?B?VkR1c0FaRXJaQmNmQjlINTNHcWpER0NQV3UrUHBkSzVIcHBsd3RwNkcrMWUw?=
 =?utf-8?B?OFArNS9QNWZ5aWhZMEd6aW5XRG1sUUtsMzlFcGFIbkVTZzhGNDFoQ1AzZnkw?=
 =?utf-8?B?RkZ6WWg4L0ZHSWQzTFZiSndqS2J6OGplejNYNFBCUUd1dnhsMzhPK2RKQk9T?=
 =?utf-8?B?dlhJMDEvck43a1pKL0NaSFJIMm44WDVDdmNaelZPZWRWcFVZVm1sUVd3MzJU?=
 =?utf-8?B?d0dudml0ejlBeFhBNkY4NWtKQlE0bjVsT2VhTE40U1Z6S21ING8vcXp1TGVx?=
 =?utf-8?B?SE1XRlRmQnVzZ09HVkpRV3RGa0d3TmdxMU51bmYwSzl0L21pUTRMaTF0YmxY?=
 =?utf-8?B?SlBrbHRkUCtUbWROcitSdHNhRDQ1a1Q3R3A4M3VQMjBaQVgzU1l5anRDZEJq?=
 =?utf-8?B?YzhxeHp5MGpZYWNMd3ptWTNnMmk3TTZYLzJnM0NQMlZObXc0OVJwTXpTMmhQ?=
 =?utf-8?B?WnQ1Ny9ZemNHUm1pdWdTbzUyeE92YXUrc0YrditLUjR3bG9QMXJJSXhNMlVm?=
 =?utf-8?B?VE02UnVHMllLdTRMWWQyYmdieGo4SkVDSkR6TVlTdnlRWDdWZFI1aDhFK29i?=
 =?utf-8?B?R0lWMkUyTzlpWno2Q0dTWURGdXQwUnlISWdxcm9qMTFNQXFFKzhkUlZVUUVR?=
 =?utf-8?B?Ymh1em5tY04yczNZenF5c2Y0SXRmcXc5YSt0bGRweC9IUFIvRG5oTDFFb0RK?=
 =?utf-8?B?Rys0Q0RNN3hLTTlBVG10S1dVemhaQTJnT3ZQSTdOam5IcGt6VmFvVEo2QS93?=
 =?utf-8?B?SElPNlE5RVJ2UFBFY2pRWWVlNktpYkdEWXlRVVRuWU94NHNYZnYrMitZdEdL?=
 =?utf-8?B?OGsyelQxRzNCZTRDYjRiZmZNM01FU3preG1GQ09Uck9scmcwZnhUcXpXSVBl?=
 =?utf-8?B?Z2tYNXlNbndhRTcxWkVZQU9sSGtOL21aSmFrdzA2em5sV1dXeHY4SHc4ZFNt?=
 =?utf-8?B?MHZoalp0TnprZ3p0d1BtRk1QY2F4SmcxOWU4eXBXS24rMzB5cCtWcVRPT2Y3?=
 =?utf-8?B?SHVpbytORmNpcXVIV041ZStCdEJjRXJlbjhmazNKY0dVU1ZsanJsN3JGeXdQ?=
 =?utf-8?B?a2NFRHlhRG5nWVVEdUdmbGxZd1hWUVdQUmp4bVNtcDlVVGlCRkJlR1BLQXJJ?=
 =?utf-8?B?Njg4ODdlTnZOcncrUnNOS0p3WDl0aTVyeUxERWZiOEozVys5RmkrUjlnTHBE?=
 =?utf-8?B?bEgwcHUyMzQyTkNiQTVSLzV6dVRCRmJnWVN3RFU1WmVQbktCQmVQRTZTM0xx?=
 =?utf-8?B?VzE0UTRPUnhpZjlxbWZaN0M4M2hVZDVZZWw5VCtRbW5vR1J3YkRxdk80L0RX?=
 =?utf-8?B?QzRCeUsybURrQkhBTWJqZmdxRk8yYkViclVnTzM1UzZuVGtjUWo0NE9CQ0Vn?=
 =?utf-8?B?MmhJMGlndThuU0RJQXFuSENPRjduNGVkTnJlRXpqcGlrd3RCb0tjZnNNMnRH?=
 =?utf-8?B?aVh1VGF1ZlAvNzJpRlZwS29SUlFEelJyczJIalhENkR5KzlUOEI1OEZQb1dR?=
 =?utf-8?B?NU1KMkJpY0pLYmlLWGV5T1k4YU5ZTkhLcjk3VFpmYzlBSnpBbkxyS25hRElX?=
 =?utf-8?B?VmFoL0xsNlZsalFjaGs3TTdBRXN1blA3cjRuMUNkM2FXOWxqdS9wQkRVdzds?=
 =?utf-8?B?Zzl4RFlYUVJEZGZZNFd4bE9MRktUVEFheU4rRTlkWDF0LzhGOWNNSTd0MzAw?=
 =?utf-8?B?VlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45710ff6-2bb6-42c8-2635-08dbbe1f0771
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 23:27:48.2341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMcYqaVvFAgOU1g+rqOzQWULTxt+76hbZFU9GHYUdrKInOxHVluYwMHo0iAdoldw+Yhnn/qA2UeVKEDKniiy1aanb+KjIX4AYW6KCGkDRzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7683
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 8/29/2023 4:44 PM, Tony Luck wrote:

Could the commit message please provide a brief overview of what SNC is
before jumping to the things needed to support it?

> Intel Sub-NUMA Cluster mode requires several changes in resctrl

I think the intention is to introduce the acronym here so maybe:
"Intel Sub-NUMA Cluster (SNC) ..."

> behavior for correct operation.
> 
> Add a global integer "snc_nodes_per_l3_cache" that will show how many
> SNC nodes share each L3 cache. When this is "1", SNC mode is either
> not implemented, or not enabled.
> 
> A later patch will detect SNC mode and set snc_nodes_per_l3_cache to
> the appropriate value. For now it remains at the default "1" to
> indicate SNC mode is not active.
> 
> Code that needs to take action when SNC is enabled is:
> 1) The number of logical RMIDs available for use is the number of
>    physical RMIDs divided by the number of SNC nodes.

Could this maybe be "... number of SNC nodes per L3 cache" to be
specific? Even so, this jumps into supporting logical RMIDs and 
physical RMIDs without introducing what logical vs physical means.
Is this something that can be added to the intro of this commit message?

> 2) Likewise the "mon_scale" value must be adjusted for the number
>    of SNC nodes.
> 3) When reading an RMID counter code must adjust from the logical
>    RMID used to the physical RMID value that must be loaded into
>    the IA32_QM_EVTSEL MSR.
> 4) The L3 cache is divided between the SNC nodes. So the value
>    reported in the resctrl "size" file is adjusted.
> 5) The "-o mba_MBps" mount option must be disabled in SNC mode
>    because the monitoring is being done per SNC node, while the
>    bandwidth allocation is still done at the L3 cache scope.

This motivation for disabling is not clear to me. Why is only
mba_MBps impacted? MBA is also at the L3 scope and it is not
disabled. Neither is cache allocation that remains at L3
scope with its monitoring moving to node scope.


> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
>  arch/x86/kernel/cpu/resctrl/core.c     |  7 +++++++
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 16 +++++++++++++---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 ++--
>  4 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index c61fd6709730..326ca6b3688a 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -446,6 +446,8 @@ DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
>  
>  extern struct dentry *debugfs_resctrl;
>  
> +extern int snc_nodes_per_l3_cache;
> +
>  enum resctrl_res_level {
>  	RDT_RESOURCE_L3,
>  	RDT_RESOURCE_L2,
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 9fcc264fac6c..ed4f55b3e5e4 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -48,6 +48,13 @@ int max_name_width, max_data_width;
>   */
>  bool rdt_alloc_capable;
>  
> +/*
> + * Number of SNC nodes that share each L3 cache.
> + * Default is 1 for systems that do not support
> + * SNC, or have SNC disabled.
> + */

There is some extra space available to make the lines longer.

> +int snc_nodes_per_l3_cache = 1;
> +
>  static void
>  mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
>  		struct rdt_resource *r);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 42262d59ef9b..b6b3fb0f9abe 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -148,8 +148,18 @@ static inline struct rmid_entry *__rmid_entry(u32 rmid)
>  
>  static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
>  {
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +	int cpu = smp_processor_id();
> +	int rmid_offset = 0;
>  	u64 msr_val;
>  
> +	/*
> +	 * When SNC mode is on, need to compute the offset to read the
> +	 * physical RMID counter for the node to which this CPU belongs
> +	 */

Please end sentence with a period.

> +	if (snc_nodes_per_l3_cache > 1)
> +		rmid_offset = (cpu_to_node(cpu) % snc_nodes_per_l3_cache) * r->num_rmid;
> +
>  	/*
>  	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
>  	 * with a valid event code for supported resource type and the bits
> @@ -158,7 +168,7 @@ static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
>  	 * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
>  	 * are error bits.
>  	 */
> -	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
> +	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid + rmid_offset);
>  	rdmsrl(MSR_IA32_QM_CTR, msr_val);
>  
>  	if (msr_val & RMID_VAL_ERROR)
> @@ -783,8 +793,8 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  	int ret;
>  
>  	resctrl_rmid_realloc_limit = boot_cpu_data.x86_cache_size * 1024;
> -	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale;
> -	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
> +	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale / snc_nodes_per_l3_cache;
> +	r->num_rmid = (boot_cpu_data.x86_cache_max_rmid + 1) / snc_nodes_per_l3_cache;
>  	hw_res->mbm_width = MBM_CNTR_WIDTH_BASE;
>  
>  	if (mbm_offset > 0 && mbm_offset <= MBM_CNTR_WIDTH_OFFSET_MAX)
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 5feec2c33544..a8cf6251e506 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1367,7 +1367,7 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
>  		}
>  	}
>  
> -	return size;
> +	return size / snc_nodes_per_l3_cache;
>  }
>  
>  /**
> @@ -2600,7 +2600,7 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  		ctx->enable_cdpl2 = true;
>  		return 0;
>  	case Opt_mba_mbps:
> -		if (!supports_mba_mbps())
> +		if (!supports_mba_mbps() || snc_nodes_per_l3_cache > 1)
>  			return -EINVAL;
>  		ctx->enable_mba_mbps = true;
>  		return 0;


Reinette
