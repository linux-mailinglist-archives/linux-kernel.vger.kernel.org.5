Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F1979E0DE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 09:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbjIMHet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 03:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjIMHer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:34:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C86C1727
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 00:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694590483; x=1726126483;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YhMX5mGBU7eeJiHS1WfpMcJHyMNJYdsigNlM+cIbm4o=;
  b=TROv3mCUHEVphkqFf57jTpZp3vh3JI+BzzVjW1M5L9Ko3NmSlv/7K/F9
   AinlgZINZaMyzIv/E/yeNiTTX4YaFm6FjQDda0tBKoVKueEKz6BpLFuxC
   yDCAMDORAxSdpTCueRNpYJETxQFeGMYEZHHEP+BoPOO1a0RYkY7hQ5TZC
   kMTpF3O3wqA1c7Xw6tyNnWbSSJzIMFQvNJduN7V731D1yh42GH9Xbk4ZU
   XxstYZkdyvw6NrqxGGVfWPBh/34PlZSgZPG9C9LxYmgC3e1u9H11KAuPs
   ziaz3P8n5Z3hmwShi75jMFFf0/fc7OWm12Jbv2N2MS2j2Ba4q3v5e+xRg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="382397891"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="382397891"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 00:34:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="887224351"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="887224351"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 00:34:12 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 00:34:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 00:34:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 00:34:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pd3JosuvFjwbeFku0R4Np3xy19rBMylGL95boToKRNOJVdh8K9BS9B5mVwrAJwBifjwWVJjbtwh0OpmArVMD1dTceG946c0fIghw7sVWAs4FdEK1xEf8FXv4A1Tf3Cf5znQEUSFvIdskFe6Yv6T+QrqjAe1HHmovuR816lgBFDAPp2tRTY8MZHUGD/2nh9btUyWftb0UGZtKVJcpSascLxEDIPZfTFRT0+Fxej83cmah5ZI+fa/RF24/PBIY0kA8REn0uN4FqsfC4TWdD9q70adWViGsJ3E7t51yTeeyUhy+l8GrTNPMQipKeP8TEYt6Y6P6Srdy90qWNo/JzFUzrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLarBNrKuB9DGkhdW3e6Oernp6m0aGpqAxN+nCBN1ZA=;
 b=hAMmarj9FNuK7XILxfpN5oUZKyVhlHz9JeptZnRU/kQ8epjP0VDMHFvv2XqvkJU9cz26ABRHfj1Ek+yQAgiQE2bAy448u/504ZdWWgjuqOsLXUY4v1AG7OPlzColKjK8B8uxCDqP5voEARJpL5eSlBXkkNtRVe89Hc1tLO7k6tgmJ6itcHadctukyFn6B6PIy0TFA3yx/KG1WCtoCZFJeQJHdubdv/KgbsdR2CAAiF6CgM6LMRKCV+FzAxpz7sJ1PP2lvQ7ILiHlEEAphOaGaud47LoL8ENt8S6Pe3IcyY7NQut6MDi06Keb1qJFqppTUxmpEZHbIRPQMNG5/PFRnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by IA0PR11MB7211.namprd11.prod.outlook.com (2603:10b6:208:43f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 13 Sep
 2023 07:34:38 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 07:34:38 +0000
Date:   Wed, 13 Sep 2023 15:34:24 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Raghavendra K T <raghavendra.kt@amd.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <ying.huang@intel.com>,
        <feng.tang@intel.com>, <fengwei.yin@intel.com>,
        <aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, <rppt@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@amd.com>,
        "Aithal Srikanth" <sraithal@amd.com>,
        Sapkal Swapnil <Swapnil.Sapkal@amd.com>,
        "K Prateek Nayak" <kprateek.nayak@amd.com>, <oliver.sang@intel.com>
Subject: Re: [RFC PATCH V1 4/6] sched/numa: Increase tasks' access history
Message-ID: <ZQFmAP5ydscmmTAq@xsang-OptiPlex-9020>
References: <202309122114.b9e08a43-oliver.sang@intel.com>
 <ccd04a6b-20fb-9cac-ad59-215a552df81f@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ccd04a6b-20fb-9cac-ad59-215a552df81f@amd.com>
X-ClientProxiedBy: SG2PR01CA0157.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::13) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|IA0PR11MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d3bbed6-6884-4fec-484f-08dbb42be29c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HXRjnN52RsvLVXxOhmBP/mAMC+ZFbvP3Us2t2297ZlUrBhkMt8Bju7geujQQqMTSwlY1jxhcbCcM568sAJlLWtkgV+93xtR2h5jahhyUnLGXF52kzu+yDlXWRtH1LT+TIcS5laljUzl1gfwztvxIv1zDFImb3kNey1NYf6EdxybYScmE32Mib+eBXCilq11nVSwwggVzmm7Eq4SOjMhyIZdvmWdFg/vxH10PU9n610YrZJ4CY6k9RzbpgntNFaDMZEVeivvqK/9gaBKmiwaKCFNESRdQwgr6PMHXwLsykK1NRsg55W65cot2Ig2aSLkIei5YQt6zHYxKBy+gFlpWcBO/zIfOlV36uPrf3nWhWF7UbTRKMwVCiMwtBHvgA0+8MN5iqumdjwwscU3yIit6RpdVF3QP2iEIZz6Udtwq/Tm0pT8qJm6cjxCP84Bb8cIrDEddUB0PE1JtUD9wrW3tbAyLx37GdKqBmwbjwupjtfBoCIbx3reB442mLcFV+eXqXQn9v6Tp8SOjF6kwM+7/+XcSXhVE6vv5me3a+pRtuvwBESDzSjAGwgf+sSrBgYTR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(39860400002)(396003)(136003)(376002)(186009)(451199024)(1800799009)(6506007)(53546011)(6486002)(9686003)(6512007)(6666004)(83380400001)(33716001)(38100700002)(82960400001)(86362001)(7416002)(26005)(6916009)(41300700001)(316002)(66946007)(66556008)(4326008)(2906002)(66476007)(8676002)(44832011)(478600001)(5660300002)(54906003)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y3D6CJVAri27qxtNplDvsrB5XPXU6SHkotL0ed3+bhbgOwlPI/VNik5gssay?=
 =?us-ascii?Q?sKIG6Ptsv44tSENOsvfjF1axrWtH0THF6RcRzm78AJc8jMFd4QXLZG3wuaa6?=
 =?us-ascii?Q?xY/5LTIupSIHPAVAlVBlsXRm4PNs/qBMRjYqdOvJjcdTEQAe/5sztEA/6Op/?=
 =?us-ascii?Q?tN+mgMTV6l3MmL2/pKj+Cnl4mjLRkrJo42hP5DqArCN44uqFIvgOU7vwCtZK?=
 =?us-ascii?Q?l+P5ao7bi6HOmgbLeDsJI63ZSsA3NLzuEtQIgue2WpiM83g/J0iw/vBoBHvn?=
 =?us-ascii?Q?JRJyrphYeD07ozbEGi5l59R8OHICM19saNrVKPm5F63vD/yMiUN+NssYB4Qs?=
 =?us-ascii?Q?FQs+/c6JkwuHsK4MQGqy5qKRnImY/U6J0GEzDivsyj9epZiQa82OWyCO4DWJ?=
 =?us-ascii?Q?U9Uvr+mgTO7VjDM1lvbMLZeCK3OgQEVMMcQucsU86BM/CzbxtY+z9N7u4tmU?=
 =?us-ascii?Q?3uxjxqO6g06FJqUjy0V83cB/eZ2WrL1wWqlm+ZXF3n1/lX0cnlfx/fknkCNR?=
 =?us-ascii?Q?VPsNDS2Jdsrx37qpBytVSo79Bcp/tkZt9Wyc/idp87KVbcdIXe67whJ7iVKp?=
 =?us-ascii?Q?lXbmqJF2oulZUsf6Konx1LxRNyX8RF5ZXJyR8l2cUcA6kk04wVwbpZPiUyCA?=
 =?us-ascii?Q?rAd7Q3zib7ZSUSdfjbfFWdu24W8Kr/cgeKJyn6lm8DhmkRdXbKSWpulzC6Uv?=
 =?us-ascii?Q?qW4Jrt2lZul5ldDdKdzdUILRPa1/9jtZ8JPnKKJDAcyu9SzTCBBBit9aEeY3?=
 =?us-ascii?Q?OaDCHT/sbvgspbtO0W6Pa3W42HfOgOPkKXG20JQ4Pr1JDAkTugbfxIdaTG/j?=
 =?us-ascii?Q?hRczGgjv/D9eKb6eO8iRAEchbtO3EXLW/NeYm0rkJouIBMw+72CkonHq41fe?=
 =?us-ascii?Q?pTo9lyGI0wexVYm6AF/Fc/FuxFiTn2dz22JD0M9ysSz/nYIXdZ+q7IXaJtzQ?=
 =?us-ascii?Q?qFhNhHUP5ifPKy4fduLUchIrRPi18YE9y9ZYM0rP3emjYBL1RF+HT1qNE1bu?=
 =?us-ascii?Q?nwwKd2aCfbHgUeqLwdIQDOWciK6uhZefx2pU0sk1nrmPDPJ7OY7Hrtc0zC3f?=
 =?us-ascii?Q?GVeA7MekSuMzBWYq0BHy1dEaJBu5fzHGS2pxh4EfPHL5MWm0tZp7U2nAgQpB?=
 =?us-ascii?Q?y34Ji5Cy5pGlasfDkzBF+jWFzNU8q6MrRi+6E4qrDFiLPfaYkpxw4eVguuNa?=
 =?us-ascii?Q?Q8s9oXSacA+OCFYfmasDDrIv1aJS+SGwJIpJKUD4AXqL02+g48ZtCXWhdh3d?=
 =?us-ascii?Q?fTdry9QaDthssbwwFOgb66GzUCbLlbCLrsTw5GHipADXYMCzR7LSVK3qve2i?=
 =?us-ascii?Q?baMJNvAS1MsJ9nFKauO7sSpEzvroapHh8F072wWNwwiPKNegLv5ZGYGuT+pc?=
 =?us-ascii?Q?rQuyAwMDPqvjXs14O9HsFgM4FvpU0qd63Jw2lrpfMNSt4GIF77MnPL+Rj0HP?=
 =?us-ascii?Q?peZQsGPZ+Aq6W7inIvv8p2PTmA5vVRUlAmo1ong1lOYogErexXH4trhce8O3?=
 =?us-ascii?Q?Tau2QwPNo2SnUCOMgnkdwKRpejpZ/FE6wfVSOcA2buDv04nJbC9XBvXAtrMr?=
 =?us-ascii?Q?0cz+TsnocLrEvlYECAsftiXwktHS2ixTIQPC6bI8UFsB7wlN016NJqPHZ5vF?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3bbed6-6884-4fec-484f-08dbb42be29c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 07:34:38.3197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWLyX+TrH+ti3dPo3DgAj2xjs433nyZrsQACmT0ufeqOf111eJ4zxvDZBJFT0yWmCKA7TR6e7cMXUpwb7o/ofw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7211
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi, Raghu,

On Wed, Sep 13, 2023 at 11:45:18AM +0530, Raghavendra K T wrote:
> On 9/12/2023 7:54 PM, kernel test robot wrote:
> > 
> > 
> > hi, Raghu,
> > 
> > hope this third performance report for same one patch-set won't annoy you,
> > and better, have some value to you.
> 
> Not at all. But thanks a lot and am rather more happy to see this
> exhaustive results.
> 
> Because: It is easy to show see that patchset is increasing readability
> of code or maintainance of code etc.,
> while I try my best to see regressions are within noise level for some
> corner cases and some benchmarks have improved noticeably, there is
> always a room to miss something.
> Reports like this, helps to boost confidence on patchset.
> 
> Also your cumulative (bisection) report also helped to evaluate
> importance of each patch too..

ok, will keep sending report if any :)

> > 
> > 
> I hope I can add your tested-by if I need to REBASE the patch for -mm
> tree depending on the feedback I get any further with any minor changes.

sure!

Tested-by: kernel test robot <oliver.sang@intel.com>

> 
> 
> 
