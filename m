Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B068579D848
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbjILSDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbjILSDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:03:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89012C1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694541808; x=1726077808;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=zPt7q2syp3f7MxA8dQb1if3ecWYo5O2s8uuJUzpQr48=;
  b=n7LXKyUpWHGQoiBPrbB3u6RFDP3QhQWsbef/lXuBSMBYhJw5ow2eEPJ3
   n8bB9S7vbSLbMph+BsAw2SARDuiaJ/EHQDHyXLU8Qe1WGYSiNLRz0veQM
   RQW7YJBbSf8jBfVyC923STJeL+VxdYaTX9OIvztZGXukZdlRhJ43NYgl7
   bApZdSAUSii9hqByWndi8FuhRp2PYtuhpumTS7gP31jFuVyrUf6ZOyH/U
   vXsgVNdHZQdk+PvJ9D2fzY6lbn9zC0VPSM2SUib0GWjY9HJgq9NjwXAUE
   HF/cMaz7BATpWPIz40g2HNqzCgpqee0ClfJzDI9UP4a9K4vvQV6OMs+AB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="377367189"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="377367189"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 11:03:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="778899344"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="778899344"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 11:03:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 11:03:22 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 11:03:21 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 11:03:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 11:03:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ag5sOz9GObKbbo3koWjqV2OHS6zN19plixsJg+fXYSSSqaHx6BWroY1lYTc1P0n+qw/Wh9cOLxU1f6ZThwNGlkaKEGa54aJ73mQDNXNmIarJ6hgADLD0hzBz4P3gk7hC9OJtNcJLrvoXNtesgkfpPq4YJC5+rkT30h9lCpaoh+ts26jjWVCoamM0zUGbW38eNZpxToad5pCfkYeKX8TpIhzy+qrealzERFXQH3YNpeOHiyBJzWquvkBfuq4ZJNjRa6Jfp4887zWSTSpxb+YVEJASmlJGV38AbOnXWgobbnwnht2Xi/p7zXX/34CB88LY0KYZfomevMuGy44vqJ2fLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oqej35KyO03bGWQN+AZPj5K9MjWtpeShgoRlOSD+c0Q=;
 b=YKOkCBokajZPM+z00VN7mjrasPlgf65rwJZJlMYD1q5jN1H8EeWOt2M86YqIM8PNag3Z1j3GY5Mo1beFMCKR1iGfen0PKKGUKgDqcAwcP1KZZNJkqxWwGJ9obsdVsj6lmGmMx2IA1ivPNDJz6EzmN2DxfAU7/1QLKZXJu1nK1s5jofj7DVhoEoAXjqCBBSmVFItB74yheRvgmMM524sbX1gXPySt7DopR9HCWGkhQ4cfjN3fBPWbJsSCRq/XBuwpPnPtAyMQ4HTo7hDYn35uJ9Ml7GI+WfYpWNhXPwxjHdrYQTnHW/OQjIia/9Y/Yf6pC1mbtVxH6msdVWc5nMKgAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH0PR11MB5595.namprd11.prod.outlook.com (2603:10b6:510:e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 18:03:20 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::d35:d16b:4ee3:77e5]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::d35:d16b:4ee3:77e5%7]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 18:03:19 +0000
Date:   Wed, 13 Sep 2023 01:58:14 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Jiexun Wang <wangjiexun@tinylab.org>
CC:     <oe-kbuild-all@lists.linux.dev>, <akpm@linux-foundation.org>,
        <brauner@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <falcon@tinylab.org>,
        Jiexun Wang <wangjiexun@tinylab.org>
Subject: Re: [PATCH 1/1] mm/madvise: add cond_resched() in
 madvise_cold_or_pageout_pte_range()
Message-ID: <202309111456.SBqOkY0h-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <95d610623363009a71024c7a473d6895f39f3caf.1694219361.git.wangjiexun@tinylab.org>
X-ClientProxiedBy: SG2PR03CA0106.apcprd03.prod.outlook.com
 (2603:1096:4:7c::34) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH0PR11MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: 85980270-eddc-4e4b-dccf-08dbb3ba8bf4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wvB5c5bTRUDxvXtL5l9JqvEQoJzXmmrhF61N/D1P4RDHuMqQvpf+BZSuO+vXOySUa8KcGwk3yJnnhcXQs6FlTN2fWOT53ajz4Ks2s2vaSR4ipjad0IO+LxZfrqRyDnPsJ75X9gPHov0B4Gn/Oy3aVyfs2Q2przvCxdV4hD8cEL28I5Gu54CgPoqetDF/oqiQAp5tYjwbreYg5j1umVlrVOuBeHmigCkzQMBn/4NJQriSaGR6Mr4Tso18jTezFuVcvzUePSWptuIzSBul4+iVHKxzgqnKgdD3IMsNmae5M7a8ieI7VE3UxZod3ymhLS2+NVtF5ho2utP+8HGcMOgYN/FI5r5934IRGwLHDRmgNvD4iSRAa5zvLKDVAnH2pQ7cd5Kbwe/uJGkeE2G8Dg7Jyfu2YfRFr1PW4m+VCBoC9CDHr5gTMmQ6KLLYMQuKVKrHv2SEsgUIpmIeWkPCrlQnwJtgQJoDrE7J624KuPz3nSzGM3ut8bYhxwdIZy+LwOu0kRVdssi28FNGczTaVdhWRyc8e01nLPIbOdF5sY6NnLj+eVjZo9zCLYbKGioGU+EJ+AYpaaVJthCuO/ZCJjfbag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(136003)(346002)(366004)(1800799009)(186009)(451199024)(36756003)(86362001)(82960400001)(38100700002)(6666004)(26005)(966005)(478600001)(1076003)(6486002)(316002)(66556008)(66946007)(6506007)(66476007)(6916009)(5660300002)(4326008)(41300700001)(6512007)(8676002)(8936002)(2616005)(2906002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SzjTaFn6kh5DK7WxnemjYoD71zsSxFvFvyMAk73SKuIoymARJTtedEXTeBls?=
 =?us-ascii?Q?dn0BLN0BNgG9gv4KdBpSQa9WlWBodHnQ4YbUk7H+Kd4gnRBcozm6mpXhPL0r?=
 =?us-ascii?Q?Qh59ToaVVBYjPfUGrnrgjlLSZ1PyXKw1Q9xo+pnqECyYCefkFESXvwHOQYSx?=
 =?us-ascii?Q?XCiZ6GM/78qoZeikQcUOW92mcQk03SRuzjfl1m4JEx2lLBxRZhTARtLJ6Op0?=
 =?us-ascii?Q?M+p8ajbnMKxyCuvcTZLPxdogHWqn7G6Pay+JuK+YHYnvQ/x8Sm3SqG1p05+C?=
 =?us-ascii?Q?q+tghHpi1qlGT5LZyib9pj4oJamS3sm7usW0enj9kjWU04HnZ1qQaDj/s1Pk?=
 =?us-ascii?Q?PBX/KBzSsjHow8nyG9sYGEQHjC5Mx5OHdOjadkcFHGgAH9sCqRftjtKsKh5O?=
 =?us-ascii?Q?n8i1owj39tgx3pni3fKEWzshpKGULwXAf5EZngqKsKh40ToW9LByfOW7DjYM?=
 =?us-ascii?Q?XQ6nUaP2LJU4ywH0Bmu5DwIAgDsCVTInD2lrLbnMlB1FjnpnSh5OC2YuGZf2?=
 =?us-ascii?Q?SZgsJb7NACxF3SPudGUt93GtdSvJYfvXwZ4wfR4+EVq8LLyiJSlLdetPKCp+?=
 =?us-ascii?Q?PbJgrHWQ4jvu73E5DRqOuibbukZjXMdq3si+iPU6EU2oXMM4HOK7Pn3EBAs6?=
 =?us-ascii?Q?hEGNLftEnP7L3f8aZU75MxUN9ulEApaymGYSEJ7zYIGwN5AhqXxw0XgNt9Y+?=
 =?us-ascii?Q?mb9IxFhr+hTxymCCuT1AZG+aJuOG6GqT1+gWLkakmLCSRkO2WbUN8IoR/O0X?=
 =?us-ascii?Q?ro60sckV3WvjIFNLb//BFIF21KI5O0kNXj892/lW9rjsh9NeqUIJigdswi09?=
 =?us-ascii?Q?3XBVy42f6MYFsDUPzWZ+yHAQYdVRfBvjNar91E2dEVYOwx5HZ38eTaKduUFM?=
 =?us-ascii?Q?zN9bFrMJfWTJ3CjuSGg9g4yYeeY4L2go9q5f+6nImTG8ZGDxvXpvK9sWKRK2?=
 =?us-ascii?Q?otLXz5ORF9831wZ0lBIw4G/KayUZOdYU1LwsRtoSZRxS/zgvjQv7+iUWfDGk?=
 =?us-ascii?Q?4qchfPkQ1z7y5YEsg+GnEpsNpUgROZK8GwC0v9hNr93/pnRpPi8GjVw6/nd1?=
 =?us-ascii?Q?PcgVyG8ndEp54Y+5ZdauBXwDDcpkWQ1YeFvyb8q3299SGjWsEs0gb1tTJjrQ?=
 =?us-ascii?Q?m0mIA/KiWr3MnuGCI0Npv2M+x2GvAS08ryaMOONKchIyYbshjsM/5/A+29mw?=
 =?us-ascii?Q?NAXGUvLZ5eap0P9UWah5ZwpWZYa9PmJ9gCJlzVWy3nX+/IWFzTCIcLqmROhh?=
 =?us-ascii?Q?+3wucnmZWTilbpkBfYIPJL2RBPH8hOaY1GXsGZ5K1YwegFcsHH6qLQVQC0ZT?=
 =?us-ascii?Q?L8wL7GTrga348ew55hdi8YY0ydbw8qvFRwR/PYHKOODIfuo3VKoCw0jOWuDq?=
 =?us-ascii?Q?I8vRqNPZQ6t0+95OLi2Sa3BMP/R0VN9jHVPryF+2D/8KtdHPsRABKYh1m224?=
 =?us-ascii?Q?Rxh8kfQK0L2AYQ53CSZQBFHMKenNGA8Cd9iG0jtnSNV61ysX4oCvQp+bDh4i?=
 =?us-ascii?Q?emBpmbjXjt937VszXWmjEqAPfEOKU6MfEPoep3PjM6ZxRRhfkJ6uI+49KcQd?=
 =?us-ascii?Q?NwhB7EDq/yTpIYeWevlgXNItCaF7q6cyps3S3S/q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85980270-eddc-4e4b-dccf-08dbb3ba8bf4
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 18:03:19.8186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtYGHdi0uO01keSgg+BubYhbEVlsxVPMDeIxcDxv9XNqXDOG1yPjYN8ecLb+GTMjyUBItIUU1/d/+4OCK3omeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5595
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiexun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiexun-Wang/mm-madvise-add-cond_resched-in-madvise_cold_or_pageout_pte_range/20230909-133707
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/95d610623363009a71024c7a473d6895f39f3caf.1694219361.git.wangjiexun%40tinylab.org
patch subject: [PATCH 1/1] mm/madvise: add cond_resched() in madvise_cold_or_pageout_pte_range()
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202309111456.SBqOkY0h-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> mm/madvise.c: linux/swap.h is included more than once.

vim +30 mm/madvise.c

  > 30	#include <linux/swap.h>
    31	#include <linux/swapops.h>
    32	#include <linux/shmem_fs.h>
    33	#include <linux/mmu_notifier.h>
  > 34	#include <linux/swap.h>
    35	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

