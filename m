Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FFD786EBA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 14:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241273AbjHXMI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 08:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjHXMI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 08:08:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0020D10EF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 05:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692878908; x=1724414908;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QSry7qjdl4cLmFSk1vfS309N33pWhiOl+8IHldbaImg=;
  b=BMA75wqiu7ju5WV8qPPoPV4IhnAv30pm93y6njNHB0d0JxVL8UJKu8QC
   7k6sx/4Rz7gJH9gB9QMhJdrAAGs2cm2aSzoM+0sEHhXCJ/G171Z8eMfFn
   p/HJOvu7qALzMh/9ewZW5qctjU4UWBelqwRvMQuihC4lWplW/INiXJVsx
   g4yqjW9fmjgyo1byQOwWi17RL89jHIbqOGbmKM0sxpWaUKG/YV0fOOvGm
   8UvWCQ8gcBKVpn3u6FqcqSZmbEsz0To51RKj91DvE8peSM4xFZln6wr4v
   WKgpeVAGFzb76FViyQ7uHkkWcWYeXZPHMjYl6PKeFaiG3Hexj5JPh2uHC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="359405107"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="359405107"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 05:08:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="1067797402"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="1067797402"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 24 Aug 2023 05:08:25 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 05:08:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 05:08:25 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 05:08:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUanQW9uQnCh3fE2v1i54NIs6scPwHQmxlF/sCHhN02JqKUblPHV5c2T30hypKTxH4duKF3ctd8DlXgFAqxC8HlqXdxbTJI/Vsd75RB3T+xePfyIZSHqcKGhr1f/YZ6y0ZhXRWEPTM4otgSCVDFhanjAHxuV0f6XGpNBBKRzQ2K5XiSxRSFM6+KOOY4gjL2cyXYzge5n4oMsT5Vtj6pvvBk6k8AWcbWcWs/qdNjdFdm1FoiMmRUjQ54J0c6ASOq8R8hBdasxoEhayGil+bI2UFq+o76uNVwZkWITW88owJuEcLDbE37d2S53IYbn+eJrVPRyMErp+pSbCm7NEuD/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pbK77mRYYIkmhA4hoIYaHhPr0parhmP5Exjue0A8Ic=;
 b=EO38u9yRtI6EXVK09frNVORikwzW/2HgCVra2Li7Db7w++BuqqVpPhuzFDidhYJCNo5n/naCOs99/+c9pjpRwluw57VR1HRyXVQjUEmun0uzoCBwtQmXQPKDIHnIjJPV3BmL1iAY+4jjZgQocQVGGZASPNDcA9L8irA72/dYRazeIyfRV0c8xK4qhMhhXU9LYTw6exUVT+cn95AVuoDJabPqVVZdV8FOcwWuniKlZmb1f4r8iunmNtIHJNH1mLb8vMMNYxUZ2LWUt8tcLGzH5rYoq+kxq578dl/rAR0FsWqPS5xu/sSyAPGxsH4lSKNIFhaKS/bbF6B5sKIR2qXF9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DM6PR11MB4755.namprd11.prod.outlook.com (2603:10b6:5:2ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 12:08:21 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::57e7:80ff:c440:c53a]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::57e7:80ff:c440:c53a%5]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 12:08:20 +0000
Date:   Thu, 24 Aug 2023 19:58:42 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>, <x86@kernel.org>,
        kernel test robot <oliver.sang@intel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/fpu: set X86_FEATURE_OSXSAVE feature after enabling
 OSXSAVE in CR4
Message-ID: <ZOdF8vMbrRC12Rvr@feng-clx>
References: <20230823065747.92257-1-feng.tang@intel.com>
 <87r0nsddb5.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87r0nsddb5.ffs@tglx>
X-ClientProxiedBy: SG2PR01CA0153.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::33) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DM6PR11MB4755:EE_
X-MS-Office365-Filtering-Correlation-Id: 4834a556-e3b2-4452-d2df-08dba49aceb1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TbgVwTyn+lVJr7+2STXauyGewTyN5NiPEgq0H8RcpyYQIvXACOHwUam3ZWdDjJfD12lcA1LEUQTus5/ec9az7h541hwdrg/Hsvz4kpfYu+7qP90Lzr2zeq0Zw2CpxkMRWVthLuQ3+IcFTpBSBmZMZaugsv7KB6rgaqQG9BsaFNb8wcDhTcZKxSaooyRpTGNyCgcfO/zY0IwrkPGgDuANYfSwbg6xfxS2E2n92UKSAg7qjdD4fi2ChXFzy4MmSDtMyZKnPd4MCDPST9WCNMjDbnZ36EHHol0plu6uYjboqTzrZi/QKyVuF71vVldfIsVUk1wEEyozILiUJ6NVKmS+sz/UmzG7QC4CwvdKXqxchMbkx2qOMPrSrDX7dPPo9L0gd/rMGRU1SsH7Hkh6SU4AmJ/CWER49xXM+SMsrBzwzHMMhncYhxe2zHwmfVOsZ69+YvVPbhL1pD40AS9cQnF26lFBsgiLLgFujNoKzSLZHTYmMLk99rUjwC6MjVJn8vX7VjyE+sANf4T7oqgricH9Wx8m/bxFMTug+1Lye4LfTagC03UOlXjPqBR4z6X4aq9z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199024)(186009)(1800799009)(54906003)(33716001)(66946007)(66476007)(66556008)(316002)(6916009)(82960400001)(478600001)(26005)(44832011)(38100700002)(6666004)(41300700001)(86362001)(9686003)(6486002)(6512007)(2906002)(6506007)(8676002)(8936002)(4326008)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3MJAktDjhb02XsiKqW524Y9pfvKxHfSVjF3bDlNfe8qkExYQdgfR5KWG8g+5?=
 =?us-ascii?Q?soI8zqC4ySEuwBj4H1DefkUDqt8DQzQA+QUGMEKypiElMXXUHlTyWkbiSGsA?=
 =?us-ascii?Q?jOC5zuu7JqLCWhLsOcXuW70p1mqkNwk0T0HllOuD5fFjV+x7L0WR+eUvzkQ+?=
 =?us-ascii?Q?nTM6cWGNvrUJNBj2GUkLVcwMZcA6qqigr+PWRRQcbhBqp/OjxTNO3hxqnUhv?=
 =?us-ascii?Q?MbYA1UVne/iD089WlWo3DrQ5k37ZFZ584BoJw4bcH0mOrZKPOKKGUnZVoyCR?=
 =?us-ascii?Q?fw16F5e51sMORh70e9wyYda9FHI7aJSuq3+OMuSQlxbG6KXn2cGig4ZzZDoZ?=
 =?us-ascii?Q?dKBmtEL6SUQbHnJlHYnxDheZBaaowkoCLpRqI/L0AnZqgDrywNHZoRSKUrWn?=
 =?us-ascii?Q?BkhdYo+E7jlZlfu1FVazGW++6ztDvCZ5CPhgVldO7B8Rck9q7upFjFsMv+mV?=
 =?us-ascii?Q?4pE50x0ivleVyDUnT7v+XpF8kho0qHHNjw9WtHb9VnyJHJG2ihQCJRZIUZYu?=
 =?us-ascii?Q?6kl8h8afc3RmSaF3dB3ZdVKwnkgR96FzhRwQthU0ljPVhyqObEg3/PPXGro+?=
 =?us-ascii?Q?wb4ywdWzToTPsGld+28YIYLz7vr1GpvwTvsJQ0bAWoZUQWwi2ucZmg4kYRaa?=
 =?us-ascii?Q?i/Yj6rlmoIqYhOhJEskaJN86ZwOZRqmu1HO2ju2VuDwR/5WghNlXUKrdpr82?=
 =?us-ascii?Q?fH156U0lW71x+JVExQQ2A7bfKmZZvkVg3O6U6VsR3e6P5CgaMxOFWrdwpt8F?=
 =?us-ascii?Q?Dg3NSdCkYhyfBt2Wn0KwijpEN3NnkD1qd1NU2cWWJRPy67LN0oqhTr/PZI0F?=
 =?us-ascii?Q?M1mK7za43uh0eJwEhyd6LACfsTlfnuK4ygb9O5oCkImBFRuW5fTqSOlxKK++?=
 =?us-ascii?Q?sYXkwY4vvaW/z2tPZC+1AfeIZz/StWTWWxSXeLMviLLIzQpRHPq08Qh+7a4g?=
 =?us-ascii?Q?p10RAVCClrXKbBpeLdAtZ4KnfNmQNn3iUT21ueJKaWupNitaPwNp/3vP0xr6?=
 =?us-ascii?Q?990xVk/b+mHVVLaNogtX6BmcVQwmlEk94L/7j7+dhjFwVRmHeC6gMqJlPwLa?=
 =?us-ascii?Q?7Few+38j3S0m8wkA4Y6f1cDfsJwYLuUxfqDKEZ0zClxcYcMyASEBUdEvgx2V?=
 =?us-ascii?Q?qnQZh1DYSXHkj37r9Muala77aAp0IKKFK4IQX6Oi/su/kB044IlO4RXILiku?=
 =?us-ascii?Q?5eb5vMfQZdogA3AIp3HPiPmG3CR16t9JWRS339V18kWa+sSuZSZF8glZ0kjK?=
 =?us-ascii?Q?IJCdMEGU64zjNdy2hevgqVYAo1YwoTa5mifYhY15NodkzgOkRAeUfMiBcmoT?=
 =?us-ascii?Q?aYysz1O8tQ8N646Wg5OrloINU0wo6jIkvWQeziwSYdT6fqZYX0nKL1PTdPmd?=
 =?us-ascii?Q?jKzCwPFGBsC1NGt8PxUPbpuHFSI1vqONF+G9DQYMrvAxlQIxG6kHKNf2g97L?=
 =?us-ascii?Q?wu4MOAWAGGVDdfWItvhEyaG9D97VxharV9D2qZlDkM00xM2ymudy8rPJcTB3?=
 =?us-ascii?Q?1V6ZRXiuhPJtijylgdQiW+33WtoBmo2CudIqxRlv7tZE1EDK4XJg/OEbkpOq?=
 =?us-ascii?Q?JIu9iTLoBJWtDSJ2YVyDThZaaMlLRejJCltWD3mw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4834a556-e3b2-4452-d2df-08dba49aceb1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 12:08:20.4957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rq/2W35QM2ccBIl+y+K83WteLDJoNEwaIDZvJPdApiWMQHEM74zvvmwFEI1hbm7WAE01Al9omj7Q7ai/682ggA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4755
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

Hi Thomas,

On Thu, Aug 24, 2023 at 11:01:18AM +0200, Thomas Gleixner wrote:
> On Wed, Aug 23 2023 at 14:57, Feng Tang wrote:
> > diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> > index 0bab497c9436..8ebea0d522d2 100644
> > --- a/arch/x86/kernel/fpu/xstate.c
> > +++ b/arch/x86/kernel/fpu/xstate.c
> > @@ -173,6 +173,9 @@ void fpu__init_cpu_xstate(void)
> >  
> >  	cr4_set_bits(X86_CR4_OSXSAVE);
> >  
> > +	if (!boot_cpu_has(X86_FEATURE_OSXSAVE))
> > +		setup_force_cpu_cap(X86_FEATURE_OSXSAVE);
> 
> This is wrong in several aspects:
> 
>      1) You force the feature bit _before_ XSAVE is completely
>         initialized. fpu__init_system_xstate() has error paths which
>         disable XSAVE.

Yes, I missed the error path in BSP fpu initialization code.

>      2) This conditional should have been a red flag for you simply
>         because fpu__init_cpu_xstate() is invoked on all CPUs not only
>         on the BSP.

Indeed. when I worked on the patch, I even thought about ugly thing like: 

    if (raw_smp_processor_id() == 0)
	setup_force_cpu_cap(X86_FEATURE_OSXSAVE);
 
> I fixed it up and added a proper comment explaining it.

Thanks for fixing it up and improving the comments!

- Feng
