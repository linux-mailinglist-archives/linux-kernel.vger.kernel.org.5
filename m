Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F46776C2D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjHIWcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjHIWcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:32:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60A8E2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691620370; x=1723156370;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=572F/OvIBcX3oo5+1ULhZIFUaYM9MCuxRF/jDTilvBk=;
  b=Yo94GewIFKwDrIDHGwaBEJthLfNSqke0ZX0mUqp23Owx3YO2mGg4P/ok
   dOm11lYkW0wfquwocscbmdnVPF5lUbV2E7drGDeJXXdE7kQzi5nNVon4J
   eWpOLHutEtLNFfn3t144D7cDDdD9BU9jBlelJQQ3PRXxu42DckUCMj1yh
   0k3Z31gWrcQQkbrmqyuucapkdPF7KXn2kXdYvKG+gb+I+HzllrkUL4BSr
   aR59LAFOKgFgK4MUe2cihV1Z7hs8tpskjIGBMnxEZUQp3QcWUY8mA54A5
   bJzD6ogdwVlz7b+tiBffC6mbg4n0OazKGs6mK9etL+Ni4M46/bo9dIiCJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="356212152"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="356212152"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 15:32:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="797364731"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="797364731"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 09 Aug 2023 15:32:49 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 15:32:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 15:32:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 15:32:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRdxgFAHWrKzr8BeRPy1JYPTKTUqPKAdobcF4su0KD8FRCZKw78A63gmV34BPgsDeirLdMgabDmGeWUsnjUPuHZipbHjfRir27+xmGN5Ae3ZVzn1qRZ5Wf63RzMjZPbleHF7JWljrzQM1R8YuVoMYo2P73bS4Qemr0UM5Rke1VPoLplqEYGyD82oRJlCVm56xIF9OmbDFdB1A9T0m785sNvuRZ3JSrAujvJKN32pzsKxk7FaaswVHYxFXGNbxXOF2cgRqHlonDJqPvCmpSjeloAsYTB73FtLO4k1PJFKym4/5t7HUDuuurb7b1RQ9ipKsrF/j9O95PYd1f/v+mARmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7AL8/SyIItkN13ZrK4K6jcKszqFYS3bZz1NawX0D6A=;
 b=Xl5b8npveN/Zjijxfgy4H9onawzwn6jRPrWOLXiuzBB7li5l8pitWXyG6DqMin4nk8+AyuYfimATXtZkQK0U1oaT82Fsdew+IXGUGT9vjd5142GseNlo71rcjJwxw9vr/25Q9py7NNvNWlSUg8w734zTDngaZ88pnBtxM/4lhL6mi9CGGrGAdmpdJUo/jWx9vql2mqhBxBJNe4s8M9cgkfddhWj41ufO6fJV8gyVESvOETw6VGRp3Gm+yBlI5FsiXZwCXg41O3xO4m/ZZUcKsfMkzFwZ98aXskXqV+h5Jmt2hYavtnHz2ewJyfXDuA39XCRn38SMvUW9ikqXOgexCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA3PR11MB7413.namprd11.prod.outlook.com (2603:10b6:806:31a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 22:32:45 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 22:32:45 +0000
Message-ID: <d93950f3-1ceb-9652-f223-f6e550f8a818@intel.com>
Date:   Wed, 9 Aug 2023 15:32:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH v5 02/24] x86/resctrl: Access per-rmid structures by index
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
 <20230728164254.27562-3-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230728164254.27562-3-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:303:8f::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA3PR11MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d3057e-bea3-4413-9471-08db99288d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7r+2C38Iog14o0/9IvkUdmWWzlEv18KM2959dwM7TGXZH/bx1FhY4S0fkigdELZNJPx5XqV0HAYVT8MmNPzEDbhIGlLWnX6/HZuBtQ3ePgKqj+V9Ek5WDRdIDUSGYLVzGErOGRarxqBc+/tXxHn3AxqkujXHjm2+ngSmIGCE4xvF5eSWw9JTlNv8ltMVT44aZ8TIclZTC5oCAAGH8t1XzIOhPUhwMwp6TcR/e8svpd1aHWZ0lWrSdVRBZXuIJeH5Zs6gGneKx+lM3zDr/5Ca76V1ZrxpzA3UBjXOLc5dty6wZ6tdYutwYhmgD2lQh34Qs0FKQEPdb0zVFbI9+Z2IO6fDBp3YXzZf6zJWo/V8p8dO3GZww7yMo445aQSYLZNVcUxbUFFmEUibkLqbT3KxZxXl26fnoi0biwrQSHsXMRaZBzp4B6/kq0BDCrvma2gIDtJJe47/FN+fPLFOjK/PADIHCRlIg6lif+wdYIk3DBeXYRSIpZFfwC0hMMnBu+owJMKUYGDS7BqVJ8NCitCgHNe5SbyWQ6DPsra7CUaqZ83+tAGZH7OIm1YhnEwZhzaQXgiVNRYlISkdYwtfKgPx8C4sfCddLchxOLEtL9D8fMvx8jZkRF2lu/Ha4cwqf4rFJwGwRlwiyFnaioXM+Rai/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(366004)(136003)(186006)(1800799006)(451199021)(26005)(8936002)(41300700001)(2906002)(44832011)(5660300002)(31686004)(7416002)(83380400001)(8676002)(2616005)(38100700002)(316002)(53546011)(478600001)(31696002)(86362001)(66556008)(6506007)(6486002)(54906003)(82960400001)(66946007)(6666004)(66476007)(6512007)(4326008)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?KzlUU3RadlZUY2RlWC9odERvVTVRbTNOVUlDcUdQa2lEMlFsKy8zSnF4aFls?=
 =?utf-8?B?djFqWWtmS1VrQWpad1lnaXdQN096cDkxd1JlODBCSU5xRWNSMVNYeXd4dE1s?=
 =?utf-8?B?eklXNVpKVU1jN2liRjBZNzFVWjdkb3E1SXVBWjIvNy80VXZZU0FNK240Sitw?=
 =?utf-8?B?aTlGNzZ4Mzc1eTRlaE82YUtTdmFNSUZkdkcydHg5eUNoVmxIWlB5S3k2VTI4?=
 =?utf-8?B?OWJGdWlvYXFNV1E1bmM4cERjdm1qakQvZ0dFVW9JUGkxblRkamhYd2diMk9U?=
 =?utf-8?B?RXlIMFVRSS9PVGhjaUZzYkVQWmo3cHBvR0d1b0xZR1ArZE1NRnBUejdwNmVo?=
 =?utf-8?B?MnVlbG9abEdOU0JvQlM5OG1SV3V3VVF3NU83TTVQckdSY2NtTVZrVHhTS0Rj?=
 =?utf-8?B?NEhSL2dsRU85MWFadi9UMzZzdGk2ZUV5RFBtMlJCa3JsZjE1aUZBYm5RUTRk?=
 =?utf-8?B?MmZhdkhvQXZ0eFIwbHRQeDdIRDg0a1V4MS94Wkg4eUhyQkRidWlLaGJuTVNP?=
 =?utf-8?B?eDJjMC9SSnMvZ3VvTUZPVUdnRGRINWlWbTBJUDVGd2V5bDRZTC9BQ1ovMVdo?=
 =?utf-8?B?NW0xNkRibEtiT0V2aVpiSnR6d21LR3N0UlZscW1DM1JrMTdWU0x4VUVhYjd1?=
 =?utf-8?B?WGQxQ2F2VXhUS3B3MmRTWGluaXIxZXovTE9HcjZDMXZDVDZUSHI2ZkxLYVBh?=
 =?utf-8?B?aEMweUZnWXFhRHBEdWl5V1pzb0hMR3B5STNSSmIvcFJQYWU3Tks5VW83QmFM?=
 =?utf-8?B?a1VQa2tKRFg0L2g2b0ZSQjl4ZUQwNjhJWXk3anBnOCtWNnJXWFJLb1VtN2w0?=
 =?utf-8?B?U1V5WUJKVWNFZmtacHEyYVZJNGpUdzJTdkQ1S1lMaktTMUJFLzhWb21VS251?=
 =?utf-8?B?Z2lUQ0VCNHNReUxtREJFR1ZFRk9mdGVTbmpjekw1TjdOZ3VvM0MrUG9vei9C?=
 =?utf-8?B?UzlOU25PWnZIaXRHOTl6SzQxSEdrS3FMMCtHNTdhanVoMFI2cHNxU0NVUE1l?=
 =?utf-8?B?Yll3d3dkRXZHd0Q0eS9Wa1N3cTg4cW1yRmVOcUxCZDZlczFNUFljWWpzZ21o?=
 =?utf-8?B?clNmOGZKNnVNNC9tSGJzRjBnZ2xVeUNLRk5ieHliWUlENThOWkZQTGMzbHFD?=
 =?utf-8?B?MmxjOVZDSXNMV1NOVUpQWFVoMDVyM2tqNW96cFJnOGJVMjBaSjhKbnBRdm5k?=
 =?utf-8?B?UG92cEp3RHZDcDdlMExLem9ZdTVaKzk2VTZMOFJ3bHFpcDYzZjc1djVUTG9K?=
 =?utf-8?B?cXAvVlZOeWs4ZzV3RjFUdXFVcnlSUjlqUFhJSDcrNzBNalNuK0FtZGVkV2la?=
 =?utf-8?B?Q1d0R3pvTjl0SG1tM2lndlRISER1bGJNQ0FndzFIU3hTWSs3dTJWZmhvNU1u?=
 =?utf-8?B?cWp0M2Q0YlBWa2JtTGFWWGc5NGdLUUZ5clNrYktOOTlTcWpwb0QyMWp4TTl5?=
 =?utf-8?B?RnJYd0Urb3hwOGd6ajMyQktNNnRxYVd0d0crSHExNHB2aGE3UzFkSHBDc0wy?=
 =?utf-8?B?V0tISS96bi80ZzRrY0ZPRWM1Wkg1Q3NsYjhDYU5Mdk1RTE91Z1M5d2ZrZ0VT?=
 =?utf-8?B?SmhyalQvMVB0SmpoM3BWdzlLSU11YzZYdGxLd2hoOWRkQzUySHBPb1NGV2hN?=
 =?utf-8?B?RDhBOEZNdEZDUDRrc2Q3QTQyRWhrVlkvbSt3R0ptNS9XM3JyOERpNUxjVVZ1?=
 =?utf-8?B?L3ZuWVp6RGpwRWlqUlJqclorKzVIeVZ0bWFXcnZkdWp0TnAyWTdER0RaTldH?=
 =?utf-8?B?SVQyMWsvVlVWd1VWOXRkbW9acjEwSnlHRVpDVWg4QWVXdEJMeVROdWlWaVg2?=
 =?utf-8?B?Ty9YMDdGMlJ5NkdoV3FPaHZWTVlkdTdJemgxcUMyMDE5cWdUMHBIY0wvQkY3?=
 =?utf-8?B?QXhNYldKOW9TL0pTR3krU0hGQU1ndmwrL2ErSXJDcEgzVEdkNTUzcHpCZURL?=
 =?utf-8?B?UnFLeXErNzJLRnNSNEdBL3BYaElpc0dhV3lVQkdIRGJjVlRsQVppM29oTGc2?=
 =?utf-8?B?M3FpN2VFNElyUE9XaGd2ZEN5YlNqUWcxTUFBSmdMdDJYWUdxVFJCcFE5bE1Y?=
 =?utf-8?B?V2d4UXpabEFjVWpyM2NDU28wOXF5UFErVkVRMFNoRUs3aitZdjVzQnZwNENr?=
 =?utf-8?B?a040YjdDdW1iVEhGQzRpRkR0TW9HYk1jRzI0RUxsWk5qajZYa09JdFFHaDBD?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d3057e-bea3-4413-9471-08db99288d58
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 22:32:45.3888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+aaDCNLo/s7crp/citO7FFtNqn+6eLVJ33UAHxWkPYAvgMY1oBndEh+jDZ1Z610f5hd8hysN6m2WPbF/82sgq9WnQRF68Hs+Lt98rP2IAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7413
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 7/28/2023 9:42 AM, James Morse wrote:


> @@ -600,7 +600,7 @@ static void clear_closid_rmid(int cpu)
>  	state->default_rmid = 0;
>  	state->cur_closid = 0;
>  	state->cur_rmid = 0;
> -	wrmsr(MSR_IA32_PQR_ASSOC, 0, 0);
> +	wrmsr(MSR_IA32_PQR_ASSOC, 0, RESCTRL_RESERVED_CLOSID);
>  }

Can the remaining "0" be replaced with RESCTRL_RESERVED_RMID?


...

> @@ -377,14 +399,17 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  
>  void free_rmid(u32 closid, u32 rmid)
>  {
> +	u32 idx = resctrl_arch_rmid_idx_encode(closid, rmid);
>  	struct rmid_entry *entry;
>  
> -	if (!rmid)
> -		return;
> -
>  	lockdep_assert_held(&rdtgroup_mutex);
>  
> -	entry = __rmid_entry(closid, rmid);
> +	/* do not allow the default rmid to be free'd */
> +	if (idx == resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
> +						RESCTRL_RESERVED_RMID))
> +		return;
> +

Why is this encoding necessary? Can the provided function parameters
not be tested directly against RESCTRL_RESERVED_CLOSID and
RESCTRL_RESERVED_RMID ?

> +	entry = __rmid_entry(idx);
>  
>  	if (is_llc_occupancy_enabled())
>  		add_rmid_to_limbo(entry);

Reinette
