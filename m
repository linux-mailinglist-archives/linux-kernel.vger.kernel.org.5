Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AFB78BCBF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbjH2CUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjH2CTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:19:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3DB124
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693275585; x=1724811585;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fUD91dVtBXNW1MrBEmjBQiv4QVx8Uur25Yug4TFDzpQ=;
  b=dP9ZmGVmmtvuYlBhAQcxi6Yq9vr3FSbd9+asfMjuYzEjBjdJe+16M0ji
   98ymwLvbHPBYqDUBWw6XWPHhXDMDshcpkMVdMIlyxZJqUJQzPtw7OgADb
   WrQ7nPNqzIF3dYo2ZGMmg14izQNK0EpRbX7qQlmkaB7IAyaj1lbiCKuFm
   FLMz5Fcr3hQNfWG0jvfY+cCJrdhRGfMt9eT+/PgIxYKPNlX0kNEFjnZkR
   KBZfAqqunX0SJJgD4a27eYTFPTPG3e4p6qdHHQ55FYISdYnOOi99UYHs/
   XESViTecmMMm8n95t5fynfhYnU5YHh8Vz/KJ35NpSjDHijRJPEVdJ2pvr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="355582199"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="355582199"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 19:19:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="767893351"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="767893351"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 28 Aug 2023 19:19:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 19:19:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 19:19:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 19:19:43 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 28 Aug 2023 19:19:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcFV4DA5Z3LW7Wb1k0slkLpnOsv9GyujJO6SgHzx1d3X1ofzP3IWhL2vaciWa1nxAixR/oaVTQbCWd5Nk5NwsFn6qIdpQYcRMPrQh8y4EEffjxplV+lBboaXZfyCRh4f9xqnwNCty69kRzc6aTpo8gCP5027bBPGYMif2H89RnskpLXlIch546igLWUYHjtv/gWpVOPNzXwon51LER5ruTI/YPUwlB31fkMdBRiJxTMlGnImHMBEpRToLK4rSfm+o/q1K08WNEfJ2apEzmpCjOBa18TfP6cW6jRw8ji5Hp72ieShBzvOC72lYXNkJmLF8c2mK6QtbkhErbNn7M3LXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSYn3whiuLcdNWvZAvo9KgM/MadlefYm95S2xwsQbsI=;
 b=KcQnPNRcPhIkY5gGsbnISFB7B63hJZhqE2PP+bKrN85fjPKuZZviO9huLxlFf6sLRiP6lQNRiMjNJWFqJ9I3Jaw+/xT1ISTjFOoo1RldxVZQyRmEkoYGgiOD1TPe/AunH2Yz94Pd+LzuZSjKudTTjmhykxp3YXVQNuIhPn4B8Q2JLlE1TZpRyK1y+7+Tnpfcv9K0POqBmi9yc7ea71LJ4clkTSJWHtSHXBhJGWEnv8P0QWrGwnHMj7ljVh380QHPCxbsCDOD46ynro8Qg0KdnyZclF532k8HICk4ewBQZowuPKSnZS4ILUpvX0v0Jy/Uh9uZ0qtMkXcieATRsfeqfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by CY8PR11MB7315.namprd11.prod.outlook.com (2603:10b6:930:9e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 02:19:39 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::d718:207a:ec74:2556]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::d718:207a:ec74:2556%5]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 02:19:38 +0000
Date:   Tue, 29 Aug 2023 10:19:28 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
CC:     Masahiro Yamada <masahiroy@kernel.org>, <llvm@lists.linux.dev>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: arch/x86/include/asm/pgtable_32.h:68:5: warning: 'PTRS_PER_PMD'
 is not defined, evaluates to 0
Message-ID: <ZO1VsDyzZdZxjSd6@rli9-mobl>
References: <202308282335.fH9YoGYl-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202308282335.fH9YoGYl-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|CY8PR11MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b23ef88-6804-449d-bab2-08dba836654a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JZ/CBGnPny28nyHe8FkLCpR+J2wa97Uti1cw2kfQXujyNd80HgHADOzYPpFF+YKivfhO9L5UsZuUdU6m+NERk5qg+f6zV7AUQgddcw5iaSlL+eh26tz6604sZJ6RaU7qt+NPr8RZnXzsYseZ5OagIC+ql9Hn67VEhLaxe/VQJWxetuV/LnUm08XT5KW6duHSvmrKtGUFdJXuevXKvgP/EtsTUA+O1ZERAqgyYRLjrxH5LnLWXRKF4ZH/+UsyLe4LvtzNE+xqBDM2zrNd7axL1OgCPVNR/rgwv+gNGYWf8CSSisV51sThV4sq8zlBQkjxx2WUvdEG0Dcqxt5I31M550Z6X0phYcmX6FLOGIQYNCvK+8IrKMPTO77chCZTbTncov93jTtawGP/jsuweGJIKOWOn4SAaRg+keCo4Gatf/J54DuyiaMkcfJn8ZFLPv5Qh0/gdYYujt/4691QXVUl7CrBtnKYkys1TxsWyiiwR60TuU/ys/3JFuhUyzjrZT+FYpxfuFfbKel/qhvTkKNVnKm2Nx8P1u6P87mHYd5oYvzAy9EvlAwIOYcAFB8AG2GlAZOAgTJZLIzExJtbE29CIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(366004)(39860400002)(376002)(396003)(186009)(1800799009)(451199024)(41300700001)(33716001)(38100700002)(6666004)(86362001)(4001150100001)(83380400001)(82960400001)(478600001)(966005)(26005)(9686003)(6512007)(6486002)(6506007)(66946007)(66476007)(54906003)(2906002)(6636002)(316002)(66556008)(5660300002)(4326008)(8676002)(8936002)(6862004)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Je5CTZrejnajw7ftmt+frvgkoAq5Cm8tH18OguD3xuYmUGjEn2S1L/36cRmA?=
 =?us-ascii?Q?gRdGvIvkKIZyYUimGpExOOEHBaVEITDFnlQxagEQZuYfONYoxGcdcYxR2/JI?=
 =?us-ascii?Q?474prHisTzOzXJhgJEt8mO+vIPZXtAAorz4z9+u5LUw/mVgEuYnPLuX4ysOh?=
 =?us-ascii?Q?dkRhvgT0MN3xHadMBJNCb2OzeClmtApWJNJkYRFV75lUq6+iy+38bv9kaVzg?=
 =?us-ascii?Q?f7iaft2oW5ynR7+uaLFa4wprSPRZkNLnj/BCcwA8v4KLMiWb57t7nLLXqEM6?=
 =?us-ascii?Q?6yrWKAlf2SK6CyVYSpAMz/SgxLLSAfmrdsgKuqvzXeuPxaKXB8dakPYp2KCy?=
 =?us-ascii?Q?MU15p+6XOTwO/mkRBW1uhuj55reUtnyNnnHJQQ3J+s4nT3TwNovSWOcGBwdW?=
 =?us-ascii?Q?yNskKU4wMsVAIn8lvQrU97OBhqiQtSXqINCl4tnugok0wrQqUP1g7Wqyqw0K?=
 =?us-ascii?Q?95Q5Ho8sWmdtQee/PDdsS6ZFp3tqkJsCuVVhlHSQ4c/Xl0pIg5aT4Z3/OnKo?=
 =?us-ascii?Q?6qdegGXxqnM7YHuIcW+nKk6+zhQA35FoHtHGH4oOLAuIAOnIORfiSgBJqIDG?=
 =?us-ascii?Q?FTKL9uHYRIKF4GdnYeEvXrjKXLVz9/Sr3on46pGvyiMGTGwyWa5Sq77LDdPH?=
 =?us-ascii?Q?Vg6oU6FTRJJw6XjGM1MZT43ZUwmXG6RIGRhrqy10Y3AYWnFMxkAY9fUxJ3vU?=
 =?us-ascii?Q?rTuiDluy9fhZEyXPgEIIc8UHybPQ7SaB/PBURDLrDZPhzifseRVMSHrVSFik?=
 =?us-ascii?Q?Ov6qyhXKNbE0d1cgaAibAR+m7nwqFsnB9zAMwg3CFSQHbDRmCNoYOg7lTbjg?=
 =?us-ascii?Q?BbbbpkdSVhODhVITJO5PXfwHp4bJiQQsxB6R6d7dShUi+sGLU/6k4WcPeCdG?=
 =?us-ascii?Q?gvDGzm8KY7OVrKkthxmTH4iYg9WgjEbKXFjxMcdKG6SDMqHG7Mz9JBuP2fBX?=
 =?us-ascii?Q?BzmB/UBH41EACeEaB/nEK+OkX9ocyelXrXL8r4YjsFjJQVw0yrnTGfaLFOzw?=
 =?us-ascii?Q?vKzex0kML6hUyJBhEXEVt27cMwQa7bJcJUUZTTVh2ToU8t5IjID7ZL8YFC/0?=
 =?us-ascii?Q?ZqIkElFeySwQbJ+CQwgenDlgiI5w6M7w6TgLackBJSibzwk6rjNaglxtIfWH?=
 =?us-ascii?Q?Y+LegbIGE+1RwWOAkohx2tmsDRfLwzmfrLO+8zjUVw+vcFQ9O14qH7V5363J?=
 =?us-ascii?Q?C0ApjJywqfEX5YY2ZXEC9y0g2rSBTtwzqeJjqyY9UTPt8nfwERFaVb1Pms3z?=
 =?us-ascii?Q?qD+m1QxfNySF32scyohnv+Gkn5RQdcaCMipgUqkFmBtIy2rnFEQAMliQLz7E?=
 =?us-ascii?Q?7DqxRQaedcII2N5NNi48zdGSZ+65kt7gU8pQK3OZGjYsMeTUSTUg2ZklcgBL?=
 =?us-ascii?Q?1GupepIup7ABduRfJ3N2cmDIRq+BRFrc6oBSgu8kppTULFogiVQKqjbLPH49?=
 =?us-ascii?Q?hI1ZTlOv9nJPFzrfHD+ayzgz83cY8WbNmHJqbGmE0wyLyfAlCXtn7IIqN05l?=
 =?us-ascii?Q?0T033OCj23hobDdhrWM7fn19TsHLaIOheU3lWluU56Zetd7sLtw9kRA1nl9E?=
 =?us-ascii?Q?vxq8uD9mtCOGV1UvkJb4ViljBQC6MGTPJMP3kRYu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b23ef88-6804-449d-bab2-08dba836654a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 02:19:38.8022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecxLObGqXg48k58v0Cm0mDoeg1bZqFSqqMPV4FRK7WZler0GmOMGNRo9hZtvOTtL98By3g8KHPZ/v7NzocbyTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7315
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

On Mon, Aug 28, 2023 at 11:56:09PM +0800, kernel test robot wrote:
> Hi Masahiro,
> 
> FYI, the error/warning still remains.

Sorry for the wrong report, kindly ignore this.

> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> commit: 80b6093b55e31c2c40ff082fb32523d4e852954f kbuild: add -Wundef to KBUILD_CPPFLAGS for W=1 builds
> date:   9 months ago
> config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20230828/202308282335.fH9YoGYl-lkp@intel.com/config)
> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230828/202308282335.fH9YoGYl-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308282335.fH9YoGYl-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from arch/x86/kernel/head_32.S:29:
> >> arch/x86/include/asm/pgtable_32.h:68:5: warning: 'PTRS_PER_PMD' is not defined, evaluates to 0 [-Wundef]
>    #if PTRS_PER_PMD > 1
>        ^
>    1 warning generated.
> 
> 
> vim +/PTRS_PER_PMD +68 arch/x86/include/asm/pgtable_32.h
> 
> ^1da177e4c3f41 include/asm-i386/pgtable.h        Linus Torvalds  2005-04-16  58  
> 1e620f9b23e598 arch/x86/include/asm/pgtable_32.h Boris Ostrovsky 2016-12-08  59  /*
> ea3186b9572a1b arch/x86/include/asm/pgtable_32.h Arvind Sankar   2020-10-29  60   * This is used to calculate the .brk reservation for initial pagetables.
> ea3186b9572a1b arch/x86/include/asm/pgtable_32.h Arvind Sankar   2020-10-29  61   * Enough space is reserved to allocate pagetables sufficient to cover all
> ea3186b9572a1b arch/x86/include/asm/pgtable_32.h Arvind Sankar   2020-10-29  62   * of LOWMEM_PAGES, which is an upper bound on the size of the direct map of
> ea3186b9572a1b arch/x86/include/asm/pgtable_32.h Arvind Sankar   2020-10-29  63   * lowmem.
> 1e620f9b23e598 arch/x86/include/asm/pgtable_32.h Boris Ostrovsky 2016-12-08  64   *
> ea3186b9572a1b arch/x86/include/asm/pgtable_32.h Arvind Sankar   2020-10-29  65   * With PAE paging (PTRS_PER_PMD > 1), we allocate PTRS_PER_PGD == 4 pages for
> ea3186b9572a1b arch/x86/include/asm/pgtable_32.h Arvind Sankar   2020-10-29  66   * the PMD's in addition to the pages required for the last level pagetables.
> 1e620f9b23e598 arch/x86/include/asm/pgtable_32.h Boris Ostrovsky 2016-12-08  67   */
> 1e620f9b23e598 arch/x86/include/asm/pgtable_32.h Boris Ostrovsky 2016-12-08 @68  #if PTRS_PER_PMD > 1
> 1e620f9b23e598 arch/x86/include/asm/pgtable_32.h Boris Ostrovsky 2016-12-08  69  #define PAGE_TABLE_SIZE(pages) (((pages) / PTRS_PER_PMD) + PTRS_PER_PGD)
> 1e620f9b23e598 arch/x86/include/asm/pgtable_32.h Boris Ostrovsky 2016-12-08  70  #else
> 1e620f9b23e598 arch/x86/include/asm/pgtable_32.h Boris Ostrovsky 2016-12-08  71  #define PAGE_TABLE_SIZE(pages) ((pages) / PTRS_PER_PGD)
> 1e620f9b23e598 arch/x86/include/asm/pgtable_32.h Boris Ostrovsky 2016-12-08  72  #endif
> 1e620f9b23e598 arch/x86/include/asm/pgtable_32.h Boris Ostrovsky 2016-12-08  73  
> 
> :::::: The code at line 68 was first introduced by commit
> :::::: 1e620f9b23e598ab936ece12233e98e97930b692 x86/boot/32: Convert the 32-bit pgtable setup code from assembly to C
> 
> :::::: TO: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> :::::: CC: Ingo Molnar <mingo@kernel.org>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
