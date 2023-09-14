Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE067A0EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 22:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjINURq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 16:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjINURo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 16:17:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9575026BC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 13:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694722660; x=1726258660;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=M2l/YwODPIjB1epbLBOG9IiC1NLMLxrL7eBtFiIw1ok=;
  b=NTvGSG04YLa1kaDaOV3RChV3/3WhjjwH6HNaKU4MH0gwBTcTfXATjMxO
   ociANb0INGDYGCZgLNtaxK/kRJfCs+a3DAW9MnikJnsvsXAsINnTE4lD6
   83P2RbcFIJBA99hBy5Amri53kdQpsWxEc3yv5BKiWCzzSWRYRrvFGbjEQ
   KZi3a+mvafqhEIj52MXeB5hdcr0E1sbVnaFAfxQYB6EKpCC0o61vf5Tbt
   aQ2DlNS57/kkW8IhZIIjOzXB8cxpzlwI11c/SIWg4b0LsEAs+viIJQ7lC
   2Ik/912gV5mBln++KsIOhbpp4pN9YZzN5pogGRMRphqtRm/yowGE0XtTq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="465433518"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="465433518"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 13:17:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="918367256"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="918367256"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 13:17:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 13:17:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 13:17:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 13:17:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 13:17:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ntq3YCP3Ql/fLkOejIqdsog/qOtD8ANG5/V+mMwhGkgKcVKUfhCPE+bbLBYoW8+cwrnLYrCwsqo99+AtoOxdlgdvuDjaa/Qf+ioYhNp9XBIj/N/gveumX1HfHjumWvsJgw21LB2Dx+kDtdcWYKPEKiY4tWgWdpLEMs4QwCSnW3XSf/IKectoWV6moaSw03eyy4ErEUVpoDzoKuIunrkPgQHLu/mMfSUGLnJgry+uSWRXWcQV3KRlGWbMQdNRVGcppv1lT1Qe1QMP9lP+3UqFeiOkoQbLVJIlWonJoWAigBg0IZMUuYeUFhk1xyGTjIDqd5hGg+PqQYEzMlAVooKx7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXQ2yohcMmanp166flj2UfoO7ynRe6doPSJ7B8PLBTM=;
 b=FXZX8/Nk2KXIzLU1dSWsuoQJeXQUSdE9fXZE08k3lxR8GpFQoKpmANZjorRv8zYKzxl7JybR9YDmeY6Q9VmY+PkfsT8eSguEN1zDC0Bd5cW+aKEOHuyI2J33clPNICgzNajZTsVfykDQJHmSZItJc6LnAaud8Ffb9Z5rMWhLrvvgYQz57Zz+YPK7rGBYCEN988S84QeeABmXXkG/ixVsJvtd0nxzhFIQ3LxsXyNAvkIRtn17xem27ZScda+R2k73UZUznU7bQ82iSpsPoMH5lFRltTR0vYKRmgB6Qv2RpnJvTyckQw1TgVlVqL4mj2vHT6VLNXb2um6JlYgZb1Q0gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA0PR11MB7282.namprd11.prod.outlook.com (2603:10b6:208:43a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 20:17:30 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 20:17:30 +0000
Date:   Thu, 14 Sep 2023 13:17:27 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     =?utf-8?B?VG9tw6HFoQ==?= Glozar <tglozar@gmail.com>,
        <nvdimm@lists.linux.dev>
CC:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <linux-kernel@vger.kernel.org>, Tomas Glozar <tglozar@redhat.com>
Subject: Re: [PATCH] nd_btt: Make BTT lanes preemptible
Message-ID: <65036a57ea900_35db10294ec@iweiny-mobl.notmuch>
References: <20230912082440.325189-1-tglozar@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230912082440.325189-1-tglozar@gmail.com>
X-ClientProxiedBy: BYAPR06CA0025.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::38) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA0PR11MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: e5eea614-4555-4013-dd58-08dbb55f9f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3vW9U3ViD7bFE4i//1vfj6Yqk1iaLX+8coXxx7pSP8QB20ENiNIxgRPMy0pzVBJ8OVldtNrxrfUeFyRuzfYWOGDKU9df6cFf3mgDJD+JMt9r07ET7YF6hB8CQj6EqP1lhGQRhCLw3LKEVe2wOReSTQx+WdStWqx8CDQMzLMlfmeUS3bjclUEwpTIVrD9T9NRmfgYnyUOPobA9GgpbRaAYEZ4qFBuKV/k2iB3PBQUbU7DhIXZ8IQ7FHJ1keYVwzy7nwZtEWMNZSgZASiMq6QW+Bv4DByvv4Wo3FHr9uXt1b3KQbvarr0ZHkwb5ox83zlwjmCON/1IUJ/3rAM/Ua+TIp/LPIMiEekhsnFWNZETYCk0faWNw5QacDzgFQOH8SfI+LHIZi28pymr3akn4I5XGj4yKmGioTP+A2FQqBuue2pE+lanDP8qmOCRYRpTDuWPr1JS3eU8oPvEenJSa8isip6T8Tr391sL66r51XYHWEknUDZKswV5dctPkQUtpPJP0hW4KtQUsjGG2h3hMPHcOrVVJA8rULXZYxSGNtECUSVgcSXl9jzFV1vqcbOHVmWL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199024)(186009)(1800799009)(44832011)(8936002)(66476007)(8676002)(6506007)(5660300002)(6486002)(316002)(66556008)(41300700001)(66946007)(6512007)(478600001)(9686003)(2906002)(4326008)(6666004)(26005)(83380400001)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmZNNUFFV1lmSjZoZ1dJTGVKcjkzdU5ZVGlQenRKSFhuSGs5SzdicExzazR6?=
 =?utf-8?B?WlhBRmxkZUU2VzM0WWFCSmJURHJxYnkwVGs3QllOclRmV083UTJESVhHREJp?=
 =?utf-8?B?dmgwbXRTa0lSOXFhbm5aM2wybjBKUGExb2M3a3hCQUxRRWpDbVdWeko4Qytt?=
 =?utf-8?B?NVF2YkdTWW1xQTRGQUhMbTdtczhJTzJnbmtDV251QXpUemliNUFwaUFCcjR0?=
 =?utf-8?B?a0ExYk1SVG1mOUVibkVXZHZqL2luMUZ5VDR5L0IybzZIejFpNUMvcE4zcGFM?=
 =?utf-8?B?VWU2bjRsYVg1dlYxWUoxRHlHZVFrdXhPYzdlU2NuQmhCZ21vUnlYelJUZjMv?=
 =?utf-8?B?eS9RUTM1RTNpSXZ0RnN2SWd4ZnB1dXZNbVlIZ3MwQUZFdU1oZXViZlJ3dnE4?=
 =?utf-8?B?b1pwZTUzR0doa0hvRG5NUkZITDNieER3WFVQa1lydllUNTgwWmpDOCs2RE5G?=
 =?utf-8?B?c2MvMkNrWHlvQ1ZrbGVUT2hlVnZnUm83SktuVy9RUHpuSktCdTZEcVFxYURn?=
 =?utf-8?B?M1JRaXo1bVF0blpNRG1XMjRDTlp2Y0Y4ajNoYTlMd0xxa1E5WDUzdzZlemNm?=
 =?utf-8?B?TmtZMnF4SldSaENmb2dDR1BTNkFZS3hXZTJycDNHM0VDOFpqZFJxc21SRjd2?=
 =?utf-8?B?bEk3ZUU4Zlk5dTczM1N6dHRFa0JXdkJhbE11VmNiK2x6SG5WNUxWYzVCdmpB?=
 =?utf-8?B?b1BOSmxSMEN1UFdqekhaOFY2SVV6bTZ3UGZxanRYUmtScnpiZFI1Nng2Rk5a?=
 =?utf-8?B?SFNDWGJ3VVVzUXVDZDZoUWdxM1VJd2hleFFUNThveWVpaU5Gc0JXeHp6NGVi?=
 =?utf-8?B?TmVQUzJIV1JoWHZGOTM0Qy9JTTliTS95MllSZ0trZllGWUUxR2cxZ29ENCtt?=
 =?utf-8?B?MWpmczhzZkMvRWlSUVd2eDh2Vm5RYS9HUFgvZmczN0h4M2MvYktJQk5pS2Fu?=
 =?utf-8?B?bHRQcmJ1N1hrKzBkcS9USlJlK1RTWW1heWxPNy91YmY1Mk9JeDNQdmxqS0RP?=
 =?utf-8?B?aFV1akMyMk9yS21aTHRCT2xlRnVZdGJVZTluQ0M3d09MQXN4UGswOUJoREVN?=
 =?utf-8?B?KzVzcjdGbjZiQ20waUw2SldkTlUxS3NlUTBPOXZadnhzZVlNNXlvWE9IMWRz?=
 =?utf-8?B?ckRYZXZlcjVWeDNVNTJVRWU4L29SMU5JbmtEbUFqVXFIbEtCV3JhZnk3SHM0?=
 =?utf-8?B?R2ViMGVNV0dVSEJra2pkS2FkMi9DdlJGRi84SEY1UW1vUkw5RldMSlZERitY?=
 =?utf-8?B?Q0Vjcm5PRFFOZkZmOU9zWDZkMlFnd21FUmF4MnZSTXNJRU9sZUdGM1gwcnFU?=
 =?utf-8?B?NTdvczhjYUh2cG5yTnVUWCtsYXdHMEJlOWJLOWR3bXZOZHExeWdhMHJNOC9K?=
 =?utf-8?B?bC9YV292QXNWQVhyTjJPaU9ta1dmYkxrZ1FSTkU0Q3N2ZEJVU0dIT1NIZHR6?=
 =?utf-8?B?UWJ5aG1rYXFWb3NuU1ArOW5YZUVxSCtZOWlYaDNqUzhHZ3c2RGw5ajhaZDFB?=
 =?utf-8?B?RFFNMzhHckNXOGl0RWN5TkpTUlJINkk5dWp5RTN1ZHQyYTJsWEF2Vk9QOThK?=
 =?utf-8?B?aGRiZXJiNHltNW9UaWxzZVJSS3l4Z1BuYjVnNG1nbCs3YW9jdDNlQ1FZWksz?=
 =?utf-8?B?c2QwaGkwL0F0OWw1SVR1VnhQRk5odXVRaWdHcHNBanBlcHV5a1ZGdHNXT3Bv?=
 =?utf-8?B?RGV6SVZVK1BNdnRXQ0kvYUt5VFlzRlJQQ2dLTWNXT0hXMVNwSTBEbFJhclpN?=
 =?utf-8?B?UUcxaDByUmNCNVBGN0xvbHdadXNseDNyc1ZOVVFqMmtxWjgvUC8yVDJBUkp6?=
 =?utf-8?B?QnhpWlpYa3BDMnhJUkMzZmNxbE1CMmRESXNLNjJlQVZVS05tTkJJdnA5SXZP?=
 =?utf-8?B?MTFORWFnYTRTdDg4SSs3ODRlYVpiQnZHcjZSbi80RzJubmpkaERyeEJUUzZj?=
 =?utf-8?B?bGxkYWVGd2ZYcEI4OENzYUJ0VDRCWWI1M1ljTWVyMnZJYzRIVWEvbHZ2NHJw?=
 =?utf-8?B?VSt5d0R6OENRdWpvMU83UE90MzhFaFVDWVhxMUxmdW41MmE1RnJRN3RCcFB5?=
 =?utf-8?B?TE5tVzV3VktpTStCdFlyandyNzRxblptMnZ5aG0yeHlCS29TZUJkcTNSdDNv?=
 =?utf-8?Q?vWGjDlEq+wstag3f6CIoIVdtn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e5eea614-4555-4013-dd58-08dbb55f9f82
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 20:17:30.8013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XuSp5pBiRdumfd5gVcpFiHFOQevL/4v2Cr+JdpyVXtIGvEwQ4PboTZU4hexNDYfehqehkPQv6+/qdRNPIK58gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7282
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tomáš Glozar wrote:
> From: Tomas Glozar <tglozar@redhat.com>
> 
> nd_region_acquire_lane uses get_cpu, which disables preemption. This is
> an issue on PREEMPT_RT kernels, since btt_write_pg and also
> nd_region_acquire_lane itself take a spin lock, resulting in BUG:
> sleeping function called from invalid context.

Is the bug in 1 of 2 places?

1) When btt_write_pg()->lock_map() (when the number of lanes is < number
   of cpus) and the lane is acquired is called?

*or*

2) When nd_region_acquire_lane() internally trys to take it's lock?

A copy/paste of the BUG observed would have been more clear I think.

Regardless I *think* this is ok but I'm worried I don't fully understand
what the problem is.

Ira

> 
> Fix the issue by replacing get_cpu with smp_process_id and
> migrate_disable when needed. This makes BTT operations preemptible, thus
> permitting the use of spin_lock.
> 
> Fixes: 5212e11fde4d ("nd_btt: atomic sector updates")
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  drivers/nvdimm/region_devs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index 0a81f87f6f6c..e2f1fb99707f 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -939,7 +939,8 @@ unsigned int nd_region_acquire_lane(struct nd_region *nd_region)
>  {
>  	unsigned int cpu, lane;
>  
> -	cpu = get_cpu();
> +	migrate_disable();
> +	cpu = smp_processor_id();
>  	if (nd_region->num_lanes < nr_cpu_ids) {
>  		struct nd_percpu_lane *ndl_lock, *ndl_count;
>  
> @@ -958,16 +959,15 @@ EXPORT_SYMBOL(nd_region_acquire_lane);
>  void nd_region_release_lane(struct nd_region *nd_region, unsigned int lane)
>  {
>  	if (nd_region->num_lanes < nr_cpu_ids) {
> -		unsigned int cpu = get_cpu();
> +		unsigned int cpu = smp_processor_id();
>  		struct nd_percpu_lane *ndl_lock, *ndl_count;
>  
>  		ndl_count = per_cpu_ptr(nd_region->lane, cpu);
>  		ndl_lock = per_cpu_ptr(nd_region->lane, lane);
>  		if (--ndl_count->count == 0)
>  			spin_unlock(&ndl_lock->lock);
> -		put_cpu();
>  	}
> -	put_cpu();
> +	migrate_enable();
>  }
>  EXPORT_SYMBOL(nd_region_release_lane);
>  
> -- 
> 2.39.3
> 


