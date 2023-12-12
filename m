Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA70B80E0A8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 02:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345632AbjLLBDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 20:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345624AbjLLBDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 20:03:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4246DB5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 17:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702343031; x=1733879031;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5iLtWqMxanRF7yyoKaUzi7PdhtK2tIIGN/HhQfI/hLg=;
  b=HEBaG6w336T0NPhtAPe24oATCg2XXJ8kLOFIhLXSK8zJRkw8Z7/bVxiD
   pDHZzPo6D9C0gdYmhW+/lDYyosbHE5LfShLc2plro8eZfLSAJG5fUisNv
   wydU/fRH+nIVkETw9sbhRLp7Ed97Ns6zdSu69g4fCFMJFQS+CPabKUcoh
   xAdv1Hgmku1uM5fu2t4Ias21ncN1uZ3f1IPvU7fv6cz1jqEaE+nszAwQU
   iJSvUsv99vdDBaIIbe6KCS4oTXIn1RJEn1SgVWhptQibs/kqWuBWZyhdT
   V93BgL9CJxfhE7YQoHAZpauaveiJEtUDLY4uv84AspSXIHnbIpN49OgnU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="459047255"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="459047255"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 17:03:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="917078451"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="917078451"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 17:03:48 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 17:03:48 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 17:03:48 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 17:03:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2i8P+KrZIk1Sauf3D/L2MeSD5j6F1jHHStVhvzU7vjNVWqsVu/2Y74NeYSf2OhB/ai2SGnjYAWLnMxJW/XerhZRNaLNbGbwwdrcNDfjPbM7qfOUMhvNaBKHF8EWg0YMGNAnUc2J934+8+rBOv37dXfYS5+Dy8wwZt2OGAHG1C5XQqkvzRqZ5yvDcN/FqiMRa1rwEvU8itsaV8PNNfplDk8DIoMkUJLORFIJb7/xI3QKoZs0XGZixIAd7JDDUvnKwgiYgiYCzpOje9zOpzTmmnhEo7MT1aL4eHPmpakfspfHWmri0OtvJYDz5JCk4mqTzF12JbaS3FGzxDz6qGEDag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzS121qrGCEt28wWw1gYXt7RWq9FyHm/ccJnDIwDBCA=;
 b=TL9KXA6hAkcAsXYITN1wy0tdBYAzKxhcRmxT6OxUk7tgp12lsXCHDr9SA5OX7JmUbYRRry3FeA1pcU0P0hthqG61TipLXb0PqmNGpFgcSGh5B01W+zfanDOmCLAZlZ9o5uerFF/7nagCHl8l6xk+TYjsqPFi81NJs+5yBmE1bFf73cEnZF2/nGRoQurRsBDnukQviQ4JmINdUr8DVKzoY4VjH0mXIwhJDhZZOt8UbPGNZf4EwJLXshk4ZBklKesAHKGI7DUQfO8txSEqutUFWaAubQImlxwEdhYMFnzASN7k5xj/eh9sbFiTODRb0UgiCXBN0hdixsfZy3d8j7p38A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by PH8PR11MB6731.namprd11.prod.outlook.com (2603:10b6:510:1c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 01:03:44 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67%5]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 01:03:44 +0000
Date:   Tue, 12 Dec 2023 09:03:36 +0800
From:   Philip Li <philip.li@intel.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
CC:     kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Luca Abeni <luca.abeni@santannapisa.it>
Subject: Re: drivers/video/fbdev/amifb.c:3375:32: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <ZXexaBTvLH9Espqn@rli9-mobl>
References: <202312051741.BVXr9CRP-lkp@intel.com>
 <b139b275-ee57-4026-83d3-7d49ae04ef49@suswa.mountain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b139b275-ee57-4026-83d3-7d49ae04ef49@suswa.mountain>
X-ClientProxiedBy: SG2PR04CA0155.apcprd04.prod.outlook.com (2603:1096:4::17)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|PH8PR11MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a969241-cdba-480d-eb47-08dbfaae2ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: liU41ZhU4AWM56drR5vwRCxXYwFSuRyxluEJKk6skFanIlx1i8gThqRsBKOmUBVUCvGztBC61QR3bIUIlLxHH9qahiatHObMJnMKPd+6tMod+UTTAy86JjFMd934TODDY/qH+z+lHuUfHwVl3RvjUHQ0lPnHoqXwlBoh/wgbAGHihwRgGYd2fHJ62CoVk44WICvEb4jxtZctlDuy6As794G1thgY9SzHbFt1Cjo7dQDAef/LHg2VrqTHZQpiWRXrbhMhbk8LME/Zk3z7lgmsKXTAyn2drPO3I/Q0sAQMvCDuG3SHmiqtsDxgMJBHCf/5Z2qKfCz2izUYBIZfwnLL/E7nqfHFuHlsrqUDjzxK1hQcP6syn192qHQA7wHhqGXK1Yboyn6w70NOSqVx5iaTGLVorMaYCw4WzW/UH4nHJl4NJ/5UVeiSMFr9IDDruCpMrkwsVVZooBMpQU06x4IguNVj7NyDgN5M5j/dsfBAN2ad4QvxXsdAJRNTTk1YwO9ooghRPxtlhrvvDQ4LJn1Jf9/QQxSIT5D0ty72AaqnlAwlSAqGXYCiul6oRECbwKWud8Jkl+RzhLLudF5pUo4K5gxCsgDqHpf+my2/7G5o8ZZZxgIjPsEYEgEg6SCD3n/6IPcn3oJZaC8p4W5Jte5fwKihOCBio6+WOX61hbgubJ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(366004)(396003)(376002)(136003)(230273577357003)(230922051799003)(230173577357003)(451199024)(1800799012)(64100799003)(186009)(6512007)(9686003)(33716001)(6506007)(26005)(5660300002)(44832011)(4001150100001)(6486002)(66946007)(66556008)(6916009)(54906003)(66476007)(30864003)(966005)(2906002)(83380400001)(82960400001)(86362001)(41300700001)(478600001)(8936002)(8676002)(4326008)(316002)(38100700002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gn03ijSQ+m/Vn/e+hAzXL+9m1zGfhjU1AsAspLqy7WpNAe6NqacOI+Ae84zK?=
 =?us-ascii?Q?4tDgm/fOCIeC5B5TUHmmgNMWFUmUPacxs1hZRjd0uZvq8OGQlMK/ZhRJGzoT?=
 =?us-ascii?Q?iS9rJt8AyFdC+/khz6ShJnOgvt4rN4LEjqIXsWp+AVmEmhSiN/44BulVHF8C?=
 =?us-ascii?Q?wNwiPe0L3I1ZayxvuUM1RSbGqz0l5y0LGKNiXAHaBHrhRO36Da87fYuK9t4l?=
 =?us-ascii?Q?uxnhy0K2iNR4wcqod1JnxXXws4sxkwvbHUHxUN8/pSczLUYZ7uuYOT4I1Sch?=
 =?us-ascii?Q?u7RZRoVyUZCfUdtQFtCXuZ/Mb3FLtIvfA9Cp/d1+iFmkBP+BQER5SSnlATS/?=
 =?us-ascii?Q?l0Ngmr6eg2DTTXv5CUzVDZL8Khs37gWFcDIvOk+2Upnw/98ae9cDEoqUuTBj?=
 =?us-ascii?Q?IgS1fai81itcZFyVoUIoN06WVT4ByttREBFGZvJUTfAxvwUdmM0m97pIlfsP?=
 =?us-ascii?Q?ijIZkMIQV0UjDa6Sm5wwuzforxfxjiz4midNh0BZJItvoqACSF8edfSlI+Gh?=
 =?us-ascii?Q?febxWrtbVTuSbSltyDRIRj6OqO2q/wKo4Wq2dw8YeRqrLS/udMckywBFcCvV?=
 =?us-ascii?Q?xUgysL5HE3CkOOE8OLXicVRQsSYBf1tQyw2B7WPYHC7hrUSwq1pREqMowS+V?=
 =?us-ascii?Q?e8EPHepQ3gYDTtEKQgG+QRG4Pwv6WkA1KCZJgflj9RNobLYAxyQ++d7Ksz7I?=
 =?us-ascii?Q?gc4kxwmb/A/Knz3yb4NLuvmCRAVr8elMHEE7FDL/oLOCpIBsb/43va63TyFc?=
 =?us-ascii?Q?qQMI0KoO0CGO/szygqfBA6TidVa+TLiE9c57X2paE0U0jLSft70Z84COPaVz?=
 =?us-ascii?Q?AwJlv1TjbCHF0y6x8iYxLk2sqeVupAGvgEjEooIdtmFuo7v0rGR8XOJtIiMn?=
 =?us-ascii?Q?XHzDir8lkE145Bqa1PIhGiRtxmeA8LELTzINkFe41J4ezpGY4KUt0DS9hg0d?=
 =?us-ascii?Q?mhMbo6Or4LJ6dsk9gV+vgl462cwcLyOz/0hMZSua6D9N2ljATrBeAtMvzWwn?=
 =?us-ascii?Q?+IfamYfceOW4jfh9dFTa8P1FB3eV6eZ8H7ufE3sjkwYDShwbXATok5n2WmxJ?=
 =?us-ascii?Q?go2yaH1SUlPq9IHr2H2TrETvSXaIWNJSXF+YtJklDGVs1E7+0oD6oUMQj4N4?=
 =?us-ascii?Q?6q23r+xHO27OGmI+puVd5bgJj5vz5I4MHYqoe0nzfGAYaYvqMU2od5/WHYLU?=
 =?us-ascii?Q?s0l6VnQudRhPky+fy+jO0Wfd52VVV5IU/HNvg7HjdQbhIX7Yd1auWDB4AHif?=
 =?us-ascii?Q?kTNjL/D2x9dUZ7kucRsatouf7677XV6rXrpZtgWH9kHlKK7EEZSyMhVguzN7?=
 =?us-ascii?Q?sAKB5IkEbEwXsXDzTPcpaPGCqdwsdbKpXGESFZTpOvifwJ72WOyoWFOS9Gxs?=
 =?us-ascii?Q?WMp6OlPQhxehhNila0ABDQWk4jHU77dUVVwmkvAEGDksr3qYTfunCvohcp22?=
 =?us-ascii?Q?bYyOX2WAdw/gXL38UY3v2wcyvOhbxDg3S+tssxRHcs4q5D6XHPjKczlgeStg?=
 =?us-ascii?Q?Dyx0Wo/ldLgUUm9ODjvpT7DIAWuD8NhBscfEjSFLgXE6/ZjHvT9uQPSFfiQT?=
 =?us-ascii?Q?pqwrUc+BVQZcqCP8VKLD3UiiH0DY2ozPFOXhVgiz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a969241-cdba-480d-eb47-08dbfaae2ff5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 01:03:44.2457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uR27jHfocS7y3amQK0xp6HZb34cmP69mE/a1iRwvHv/Ojk5T0h8YxAAzRtt19T7XoTlhXEPs2wmQWGjkSZeS4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6731
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 01:06:45PM +0300, Dan Carpenter wrote:
> Something went wrong with this git bisect.  The Sparse warning predates
> git.  The file was renamed at some point so I would have thought the
> bisect would point to that.

Got it, Dan, we will investigate why several reports are bisected to this commit.
Sorry about the false reports.

> 
> regards,
> dan carpenter
> 
> On Tue, Dec 05, 2023 at 05:50:23PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
> > commit: aa5222e92f8000ed3c1c38dddf11c83222aadfb3 sched/deadline: Don't use dubious signed bitfields
> > date:   6 years ago
> > config: m68k-randconfig-r131-20231129 (https://download.01.org/0day-ci/archive/20231205/202312051741.BVXr9CRP-lkp@intel.com/config)
> > compiler: m68k-linux-gcc (GCC) 13.2.0
> > reproduce: (https://download.01.org/0day-ci/archive/20231205/202312051741.BVXr9CRP-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202312051741.BVXr9CRP-lkp@intel.com/
> > 
> > sparse warnings: (new ones prefixed by >>)
> > >> drivers/video/fbdev/amifb.c:3375:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *dst @@     got char [noderef] __iomem *screen_base @@
> >    drivers/video/fbdev/amifb.c:3375:32: sparse:     expected void *dst
> >    drivers/video/fbdev/amifb.c:3375:32: sparse:     got char [noderef] __iomem *screen_base
> > >> drivers/video/fbdev/amifb.c:3713:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *screen_base @@     got char * @@
> >    drivers/video/fbdev/amifb.c:3713:35: sparse:     expected char [noderef] __iomem *screen_base
> >    drivers/video/fbdev/amifb.c:3713:35: sparse:     got char *
> > >> drivers/video/fbdev/amifb.c:3755:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
> >    drivers/video/fbdev/amifb.c:3755:26: sparse:     expected void [noderef] __iomem *addr
> >    drivers/video/fbdev/amifb.c:3755:26: sparse:     got void *
> >    drivers/video/fbdev/amifb.c:3772:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void * @@
> >    drivers/video/fbdev/amifb.c:3772:26: sparse:     expected void [noderef] __iomem *addr
> >    drivers/video/fbdev/amifb.c:3772:26: sparse:     got void *
> >    In file included from include/linux/workqueue.h:9,
> >                     from include/linux/srcu.h:34,
> >                     from include/linux/notifier.h:16,
> >                     from include/linux/memory_hotplug.h:7,
> >                     from include/linux/mmzone.h:780,
> >                     from include/linux/gfp.h:6,
> >                     from include/linux/umh.h:4,
> >                     from include/linux/kmod.h:22,
> >                     from include/linux/module.h:13,
> >                     from drivers/video/fbdev/amifb.c:43:
> >    include/linux/timer.h: In function 'timer_setup':
> >    include/linux/timer.h:159:30: warning: cast between incompatible function types from 'void (*)(struct timer_list *)' to 'void (*)(long unsigned int)' [-Wcast-function-type]
> >      159 |         __setup_timer(timer, (TIMER_FUNC_TYPE)callback,
> >          |                              ^
> >    include/linux/timer.h:126:39: note: in definition of macro '__setup_timer'
> >      126 |                 (_timer)->function = (_fn);                             29-      |                                       ^~~
> >    include/linux/timer.h: In function 'timer_setup_on_stack':
> >    include/linux/timer.h:167:39: warning: cast between incompatible function types from 'void (*)(struct timer_list *)' to 'void (*)(long unsigned int)' [-Wcast-function-type]
> >      167 |         __setup_timer_on_stack(timer, (TIMER_FUNC_TYPE)callback,
> >          |                                       ^
> >    include/linux/timer.h:133:39: note: in definition of macro '__setup_timer_on_stack'
> >      133 |                 (_timer)->function = (_fn);                             36-      |                                       ^~~
> >    drivers/video/fbdev/amifb.c: In function 'ami_decode_var':
> >    drivers/video/fbdev/amifb.c:1127:23: warning: variable 'vtotal' set but not used [-Wunused-but-set-variable]
> >     1127 |         u_int htotal, vtotal;
> >          |                       ^~~~~~
> >    drivers/video/fbdev/amifb.c:1127:15: warning: variable 'htotal' set but not used [-Wunused-but-set-variable]
> >     1127 |         u_int htotal, vtotal;
> >          |               ^~~~~~
> >    drivers/video/fbdev/amifb.c: In function 'ami_get_var_cursorinfo':
> >    drivers/video/fbdev/amifb.c:1848:19: warning: variable 'alloc' set but not used [-Wunused-but-set-variable]
> >     1848 |         int size, alloc;
> >          |                   ^~~~~
> >    drivers/video/fbdev/amifb.c: In function 'amifb_pan_display':
> >    drivers/video/fbdev/amifb.c:2540:34: warning: comparison of unsigned expression in '< 0' is always false [-Wtype-limits]
> >     2540 |                 if (var->yoffset < 0 ||
> >          |                                  ^
> >    drivers/video/fbdev/amifb.c: At top level:
> >    include/linux/module.h:131:13: warning: 'init_module' specifies less restrictive attribute than its target 'amifb_driver_init': 'cold' [-Wmissing-attributes]
> >      131 |         int init_module(void) __attribute__((alias(#initfn)));
> >          |             ^~~~~~~~~~~
> >    include/linux/platform_device.h:251:1: note: in expansion of macro 'module_init'
> >      251 | module_init(__platform_driver##_init); 58-      | ^~~~~~~~~~~
> >    drivers/video/fbdev/amifb.c:3786:1: note: in expansion of macro 'module_platform_driver_probe'
> >     3786 | module_platform_driver_probe(amifb_driver, amifb_probe);
> >          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    In file included from drivers/video/fbdev/amifb.c:53:
> >    drivers/video/fbdev/amifb.c:3786:30: note: 'init_module' target declared here
> >     3786 | module_platform_driver_probe(amifb_driver, amifb_probe);
> >          |                              ^~~~~~~~~~~~
> >    include/linux/platform_device.h:246:19: note: in definition of macro 'module_platform_driver_probe'
> >      246 | static int __init __platform_driver##_init(void) 68-      |                   ^~~~~~~~~~~~~~~~~
> >    include/linux/module.h:137:14: warning: 'cleanup_module' specifies less restrictive attribute than its target 'amifb_driver_exit': 'cold' [-Wmissing-attributes]
> >      137 |         void cleanup_module(void) __attribute__((alias(#exitfn)));
> >          |              ^~~~~~~~~~~~~~
> >    include/linux/platform_device.h:256:1: note: in expansion of macro 'module_exit'
> >      256 | module_exit(__platform_driver##_exit);
> >          | ^~~~~~~~~~~
> >    drivers/video/fbdev/amifb.c:3786:1: note: in expansion of macro 'module_platform_driver_probe'
> >     3786 | module_platform_driver_probe(amifb_driver, amifb_probe);
> >          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    drivers/video/fbdev/amifb.c:3786:30: note: 'cleanup_module' target declared here
> >     3786 | module_platform_driver_probe(amifb_driver, amifb_probe);
> >          |                              ^~~~~~~~~~~~
> >    include/linux/platform_device.h:252:20: note: in definition of macro 'module_platform_driver_probe'
> >      252 | static void __exit __platform_driver##_exit(void) 83-      |                    ^~~~~~~~~~~~~~~~~
> >    drivers/video/fbdev/amifb.c:2344:19: warning: 'amifb_setup' defined but not used [-Wunused-function]
> >     2344 | static int __init amifb_setup(char *options)
> >          |                   ^~~~~~~~~~~
> > 
> > vim +3375 drivers/video/fbdev/amifb.c
> > 
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3334  
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3335  
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3336  static void amifb_imageblit(struct fb_info *info, const struct fb_image *image)
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3337  {
> > 423a53086ce409 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3338  	struct amifb_par *par = info->par;
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3339  	int x2, y2;
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3340  	unsigned long *dst;
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3341  	int dst_idx;
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3342  	const char *src;
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3343  	u32 dx, dy, width, height, pitch;
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3344  
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3345  	/*
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3346  	 * We could use hardware clipping but on many cards you get around
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3347  	 * hardware clipping by writing to framebuffer directly like we are
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3348  	 * doing here.
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3349  	 */
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3350  	x2 = image->dx + image->width;
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3351  	y2 = image->dy + image->height;
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3352  	dx = image->dx;
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3353  	dy = image->dy;
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3354  	x2 = x2 < info->var.xres_virtual ? x2 : info->var.xres_virtual;
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3355  	y2 = y2 < info->var.yres_virtual ? y2 : info->var.yres_virtual;
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3356  	width  = x2 - dx;
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3357  	height = y2 - dy;
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3358  
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3359  	if (image->depth == 1) {
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3360  		dst = (unsigned long *)
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3361  			((unsigned long)info->screen_base & ~(BYTES_PER_LONG - 1));
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3362  		dst_idx = ((unsigned long)info->screen_base & (BYTES_PER_LONG - 1)) * 8;
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3363  		dst_idx += dy * par->next_line * 8 + dx;
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3364  		src = image->data;
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3365  		pitch = (image->width + 7) / 8;
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3366  		while (height--) {
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3367  			expand_one_line(info->var.bits_per_pixel,
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3368  					par->next_plane, dst, dst_idx, width,
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3369  					src, image->bg_color,
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3370  					image->fg_color);
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3371  			dst_idx += par->next_line * 8;
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3372  			src += pitch;
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3373  		}
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3374  	} else {
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21 @3375  		c2p_planar(info->screen_base, image->data, dx, dy, width,
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3376  			   height, par->next_line, par->next_plane,
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3377  			   image->width, info->var.bits_per_pixel);
> > ^1da177e4c3f41 drivers/video/amifb.c Linus Torvalds     2005-04-16  3378  	}
> > ^1da177e4c3f41 drivers/video/amifb.c Linus Torvalds     2005-04-16  3379  }
> > f1cbb17ac73993 drivers/video/amifb.c Geert Uytterhoeven 2011-11-21  3380  
> > 
> > :::::: The code at line 3375 was first introduced by commit
> > :::::: f1cbb17ac73993225402d7e40a0694c502570876 fbdev/amifb: Reorder functions to remove forward declarations
> > 
> > :::::: TO: Geert Uytterhoeven <geert@linux-m68k.org>
> > :::::: CC: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 
