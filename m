Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879BD7DA53A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 07:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjJ1FoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 01:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjJ1FoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 01:44:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A24E3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 22:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698471860; x=1730007860;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nMFU4r/wKhWuzhIuYGUvQzJ5r1Vk15euosJUHP/gyec=;
  b=CNkdzpJYjSa00vf0Na+M6Q2yT6YiP3aT9W9s3gDuqEj4GDWMDwKi1A1w
   CS8UPgMpSRj3S2bJGbDQYtlmWhdF7yTfB9hu+2SET2pl+gzhExChx+6Gq
   XIPQ65v2P0KoAHCOSWNchEyS8ma9WFchkhu1G11UPSFduX2DiXcB67IAd
   kqgqvTppkAXrbmS9xdGTodfzk73tlpp/09eDjd+fLfzQc+K0QncjqrlbQ
   PB02+ovCrnIVgPJI+eu0q7F2J3iLXLE299PuOuikxGZE7LhNGSJ8uVINy
   UmXsuw5pNwwt07eFujbwIlrvGLgWSiKPFONI2II6qpzHFiO87fuz06LXH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="452127607"
X-IronPort-AV: E=Sophos;i="6.03,258,1694761200"; 
   d="scan'208";a="452127607"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 22:44:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,258,1694761200"; 
   d="scan'208";a="1053913"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 22:44:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 22:44:18 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 22:44:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 22:44:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHiWECEKud/LuDhI1UPzoaV9rMrrWhfiXHGCaLVHj35UgRbq6RFTRNZdmJWcGLmLQ+xbXPqyD+2WNLMty/l9cebroTjJKPiSL+Y8s2KW/sas/mJEI8+wEzzJjyhSCTuW5hDvyJFOMpCKWKflPLzaqYYU1BjQvOmEEyts+z8CXebUKa/3ZvjekmI7GY0CFvb/pvaE1GebgpWNwzmkQLHARDLTZG09Z5Dr/A8R+GdtFDulv7L4GQg5A66DtRZp895EBIUdWvylO3s230FStJolhYLsZ5vA8lvtbApmLXBM8nOeEbXRS+LeNY9tq3HlWzDYinclUG65O8ic/Es5RRQL+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnGllHnZWcq8yEsTpxY6Arld8cXCN+7faMkcEkkD1OQ=;
 b=TC+1+JLxqmQElBj8Ku7D1l8UBBqQhZqmkTQaexcAjIUiXM3fSLVzvB8qu+kTDg67WTi8KResb/nCkf0YrP/3j/pHv7vXR2MtmXuI1R0MrGEOQ/A9vICJPTa+ZOWgMiiFJL6RWV1rQNaaWFbvmCUWKKvQ+QdoZZ6PnbSPuderkTm92dr9S8mlSEFFHw0tnmXgufIn+F6s+zWvSlXfK7i9IUUiSv50MJ2pXzDTrI3qFKD0gAGwxKzDeLwngg645/gaYRKZXjnFOlNoji+JMb1F+2nHnSgolPGVpYGGClVa4uvk084jaFjoo8UbyDyTh/tfi6Jxk7MWq1f/Lh5O+b/t3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH0PR11MB4936.namprd11.prod.outlook.com (2603:10b6:510:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Sat, 28 Oct
 2023 05:44:16 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::8c24:7666:7047:d99e]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::8c24:7666:7047:d99e%4]) with mapi id 15.20.6933.024; Sat, 28 Oct 2023
 05:44:16 +0000
Date:   Sat, 28 Oct 2023 13:44:00 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Keisuke Nishimura <keisuke.nishimura@inria.fr>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH] sched/fair: Fix the decision for load balance
Message-ID: <ZTyfoIBpm3lxd8Dy@chenyu5-mobl2.ccr.corp.intel.com>
References: <20231027171742.1426070-1-keisuke.nishimura@inria.fr>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231027171742.1426070-1-keisuke.nishimura@inria.fr>
X-ClientProxiedBy: TYCP301CA0025.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::12) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH0PR11MB4936:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a5cc292-08a6-4252-78b1-08dbd778ea76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7uRHhRlITFdJAlwiRmoCtoKwqHJF9KNJZ7oNsb0laXVOSYM9NCOBGLLwBoTAaLo0POMGtv7jGiiK8PdjK7pgXvRMckm+1g8ZyeR7hUr3RuBeI2U36rB4SmE78wk1RFKGAu/+WgJGnw1/1JY77vu9Qwfqsgoe0mrmG8MoNdvO3T7gSMg7lg8Gzlr44sg6IvxTxbYkVxNrpSOPYSnnzwnyI4bX3KE8ZV+cOcYdG5HzWfjdRQ31EDZPhblvzKmR7dlnCNyYuN1XGhYPuxSwCMwBGp3shj82Ds2m64MCeBtcPVk9/+mhLHVArEM5C7QQC3y8zVRVwNYUUoRYssNBIJOQ2+9m9WLgjdz6GLbTfWkqsuVucG5SMn9fGm9/OWTDkFjYBUJQRUdlwVPXzEWPgSVMq5UZ43PcEJ2BDTocXEenD7MrIfYu1PX/lGh/s/U8DLYbKQs9Jz31HWAUJyeOD78zv3zsWi4bfvHLxeKCWnAzzZqLwUPID00GmMn0RyT//72j0BRK0gYwIXyxD3kOQQmsYlwzb7f/+Pkoyhih6AmK7br5rb6BDI3/sy5mqU10mTfT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(26005)(6512007)(2906002)(82960400001)(86362001)(38100700002)(83380400001)(6486002)(7416002)(5660300002)(6506007)(478600001)(6666004)(4326008)(8936002)(66476007)(53546011)(8676002)(54906003)(6916009)(66946007)(316002)(4001150100001)(41300700001)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QphEze354RTm5ZugO/DOnH7PpkpVbl+FjP7+c7DJ+SBAed4cIrlFRvpw4YML?=
 =?us-ascii?Q?IXgd2VVhh7ZM8VSLXpefB/YzF31OBm9ft+4aQyqt1WQiWVUgenI5IQuaotvk?=
 =?us-ascii?Q?iUz5Fuqr5ooWdBthUi0IqNdDol50hApzEOjFMoWfKr6gOYdEwNLDhFE0YtFs?=
 =?us-ascii?Q?H9Eq9zibYbvZ1qC8btaxHhs4eDj4sJKAxmfOtILVGTLq3F3vF09PMZ4OyfFI?=
 =?us-ascii?Q?GifxyEvzfDME43qRH6L86apiTnVt22y9iMwqV/YelLeeaj+usNfiw3sfiTMx?=
 =?us-ascii?Q?cG24f6ESn12cXCXJm3y0CW7R+Q8ax7gLCrO9SHvH95FolL0rWT2+kH+45i3F?=
 =?us-ascii?Q?RU/o9ZZaXIHmgZGIlTB7N9+QDDpyS0Hu8sqAUum58eIFdEozZKdIfSmt7ZJz?=
 =?us-ascii?Q?6nSa9rzuEU2lIwy8k2ErfY04KktwNWk94eo9wxH0Ey2Jr0N/h6gRvI7b0iTx?=
 =?us-ascii?Q?D/v+77abFcnASJXAlfAKo87kUk1aA1JWBnEpvoHdSvr/rTcSGOt5ygpBVzFW?=
 =?us-ascii?Q?1yg5ctj4pndtapr8zw37/U0cRL0iwYM22cCIpm/Ti/MnW/dvrWiubaxBQ6fF?=
 =?us-ascii?Q?iK/8zVnWxpWgiGMrEwK8VwH0tQrG1HX/hg5zZ/m/ucCeMmvFWxBxwV5exSKv?=
 =?us-ascii?Q?d8CbHgwqAUwMrN2G80hELWAdy6PrxJpoQkmwnHA53GzjM6wpcTbEMhKFpiPh?=
 =?us-ascii?Q?0kUktvzcNT/AfwCIUOsIS3cY2xyyBFQ0JQiSAYVk01HNgjqRkhSa3FG0+YaW?=
 =?us-ascii?Q?Kco2uNqDqieVDMtiKJ8gj5PbDFXeI4wgkojdC69vH/LsSuZC04ozW18D39/H?=
 =?us-ascii?Q?yJaUTbChgCNO6ShauVjOq2AI/B42i92ZuiD1+k/pdZ2aUk2A4D4vbYyq9Z8Q?=
 =?us-ascii?Q?FMHipPkhF2DT+LAerG7ARGNt9Y2HhuCM5d6Pxdn+zHgac2bvQ86kyn9vtg1/?=
 =?us-ascii?Q?ZVb5DqBWNHjBJ6dz0UmlOyvbpnc9GJfwL9oLcfG9eucX7oAbtK+FbHS6g3gx?=
 =?us-ascii?Q?w9WkHrGKDDHMcuAwbHFm0/dXFlsP/G3SEzdWLIQVJGdvMwmlRBT2VKPIQNOX?=
 =?us-ascii?Q?UsAmaZWlRdxGi/v4//Rn2167xkot/U/VtRizcl4h9dwtzpze1v4GPXEy103y?=
 =?us-ascii?Q?o+zISVVBtaF/OJiTBA8Es1fw1QkS76AC5ZLiJCekdfyWdGAxypBkKe4gdvW/?=
 =?us-ascii?Q?oYZj0Wr6E1uagrNpKFGzn8+pygpzoXSdjsOA1bBnP+M/00i0zoN3e2vRfE0s?=
 =?us-ascii?Q?K6axHj9B/Ang+Wxduo01iSqRe0rYn+YiJ7TpJpgcQu0kZszR9up577fOaDfe?=
 =?us-ascii?Q?SYLiWGs/bUZJoKUEEU51P90930fxMGPV2xULS8mJmxWD3thjAF/64W48RGF0?=
 =?us-ascii?Q?arjwlMXe0t7abuhHBs9S9fsYr3ewA5LfrjK0kYNiLRdJAxjylZpojsWG0o7x?=
 =?us-ascii?Q?ehGc6qS1UDcd7YR8uPpuwgi7BMV8hQV7lK8+NTN0lGKLNdK7Zg0eJpSdaj0r?=
 =?us-ascii?Q?msKv62laNUEBtXNjzg/1QrMfyJfByPEr7ATO6Q2NXZObxKMFuGgWfKmftg90?=
 =?us-ascii?Q?E6vS77egkqofY4ouE/pLDeRMgUuiJTTqjYlXTZ0O?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5cc292-08a6-4252-78b1-08dbd778ea76
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2023 05:44:14.2922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HoGuhjMTXQFRF1PNCgAiGo3tt20GoOx9vFWYfoYVPR98CIJVta9N+bOzrECwS10nSA4BHqKKl9uYLmKYJ+4+Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4936
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-27 at 19:17:43 +0200, Keisuke Nishimura wrote:
> should_we_balance is called for the decision to do load-balancing.
> When sched ticks invoke this function, only one CPU should return
> true. However, in the current code, two CPUs can return true. The
> following situation, where b means busy and i means idle, is an
> example because CPU 0 and CPU 2 return true.
> 
>         [0, 1] [2, 3]
>          b  b   i  b
> 
> This fix checks if there exists an idle CPU with busy sibling(s)
> after looking for a CPU on an idle core. If some idle CPUs with busy
> siblings are found, just the first one should do load-balancing.
> 
> Fixes: b1bfeab9b002 ("sched/fair: Consider the idle state of the whole core for load balance")
> Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
> ---
>  kernel/sched/fair.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2048138ce54b..eff0316d6c7d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11083,8 +11083,9 @@ static int should_we_balance(struct lb_env *env)
>  		return cpu == env->dst_cpu;
>  	}
>  
> -	if (idle_smt == env->dst_cpu)
> -		return true;
> +	/* Is there an idle CPU with busy siblings? */
> +	if (idle_smt != -1)
> +		return idle_smt == env->dst_cpu;
>  
>  	/* Are we the first CPU of this group ? */
>  	return group_balance_cpu(sg) == env->dst_cpu;

Looks reasonable to me, if there is other idle SMT(from half-busy core)
in the system, we should leverage that SMT to do the periodic lb.
Per my understanding,

Reviewed-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu
