Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1E0754F03
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 16:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjGPOSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 10:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjGPOS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 10:18:29 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7281E10CC
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 07:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689517104; x=1721053104;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=iLEwhhub/F45vcnqkVWXYGdnsevRiN3g3IQLC+spgNE=;
  b=F3ZgFVKI97gJ9dhUmN6TIFYzs51+48o4kMJgND4i8ad58ZNWYQnmA59z
   KxrMZcIvtbebWoKHgPBHxLUBJHfIqYEcTSeGQAyQ89sYDzUjwtqxnCWTn
   3ryeFQayMAYl9hwRzNf9YG8qQwx36dzkfTYiteutWXEo634n139SfIOnR
   LpnGJSUgjvgadzTbIoJQNBL/Vg5hzzS4D279o0cVDlxuM5RbLhFaN/q3X
   dK5gKlTHzSnYN2HqSDwGkiLXHLRUFd3HFpRB3kwoBwkYlyrDHDDZEs7IP
   PinmX+JovazIlb4s0l95RqC/B9MY2RIHE+GS/HquMtLG9EhWvOFInkyy8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="363223078"
X-IronPort-AV: E=Sophos;i="6.01,210,1684825200"; 
   d="scan'208";a="363223078"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2023 07:18:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="813025710"
X-IronPort-AV: E=Sophos;i="6.01,210,1684825200"; 
   d="scan'208";a="813025710"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jul 2023 07:18:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 16 Jul 2023 07:18:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 16 Jul 2023 07:18:20 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 16 Jul 2023 07:18:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZATJH0nj0HwPzGl8P2zWLTHhaowDTcQdKLGayLjvy8TBikXMPNsGD7cVLwsxG/qCrWyK3M5d4RPSa9o6JF3J8qcWCBsNzCsX1M6qKF2Xe4Spo5EuPjm3ETRFu3Z0W5m1VVHgpFrDYfnX3lSBtSyIn/WrlhZ9bPrl4ANnGaN1K39eBGjTFt0LlDQWuE2Gpi+V8ve/1HI/ELMc+yKMG5+7RyNOhD4/H1TmdWiHV1T7EZgsElqiigsE4bbyKJtXIcVuuThtrWoHbqNg1g4l5a8AOUkKEfnqqvIzoJv4HYo9pQPCPR2Nrh6PJXzlXLDe9srup6kPeTjD/emIcPsFWxw+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TO0+e+cF5vV2ih9NNQjX0GtveHuX97/QYVPSmlOJ9q0=;
 b=m0rpcgu6K/jgQ52kLWqOgo3vhaAoj75WaphVXjBiBRs5sJxBMjfjBo7xT7veZ+i8KGf1ruV9+3SvmmXX+zsWZB+GVhvKQOaz1s9YT5doxwmd9Tw95mMUjhMvRlTzx+tekZB+xSjMpryuBsUXco8dsGihJBC+7L/W1Fb7RfgQrcZohFY1ILDxkedDTlDRU08tqyerAD8AI6ACnt6sbzfqoCYxdn4gKiZmDi5txO/yjXRlfKJ6AGW5DgxNJxIi29VsvdryZi8wvcRB1iNf52xhynWcQJTKfuibYDe72S5xrhsT88r8PW4NwaA/hOHbSkx5u+2Gs2OHVyiXXuvwW5k8Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by PH7PR11MB6858.namprd11.prod.outlook.com (2603:10b6:510:1ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Sun, 16 Jul
 2023 14:18:12 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b2e3:de01:2d96:724e]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b2e3:de01:2d96:724e%5]) with mapi id 15.20.6588.031; Sun, 16 Jul 2023
 14:18:12 +0000
Date:   Sun, 16 Jul 2023 22:17:59 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Raghavendra K T <raghavendra.kt@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David Hildenbrand" <david@redhat.com>, <rppt@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@amd.com>,
        Aithal Srikanth <sraithal@amd.com>, <oliver.sang@intel.com>,
        <fengwei.yin@intel.com>
Subject: Re: [RFC PATCH V3 1/1] sched/numa: Fix disjoint set vma scan
 regression
Message-ID: <ZLP8F001a+Shp8DD@xsang-OptiPlex-9020>
References: <cover.1685506205.git.raghavendra.kt@amd.com>
 <8581ca937d4064b3cd138845d5bd418580d177da.1685506205.git.raghavendra.kt@amd.com>
 <88d0c858-586b-bf59-8d57-d31ec63a9e35@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88d0c858-586b-bf59-8d57-d31ec63a9e35@amd.com>
X-ClientProxiedBy: SI2PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::14) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|PH7PR11MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 35533acb-b707-4b57-1ad8-08db86077bf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TRUzZbxGOq146dvPE07EvRXZOXZw1nk4OgJ5frktryyOq38MoOuDf3C+A1Lm1XGo9BTmBcVsjboycVmqAr5j0xMAgMHkyB/pc5+CUCMkTmEVsC5EIl+WtEzQrbhkX92y+S3hlIw9sg69RokiKQamMd7gGmLLfkKo2rFmhm1qQe2UTeScLZHFTEF8qA/faNCAk29gTKp/swrpxrAdm4qd/djf08MiHGZZOuhkygzJnbCy4Kf6WiJsKasl0ZVDpphsjcKyl7NHpEccOJO0b8Q9OFnuyBdDRVtUJZbiWzavQGP4CZU+uusGiSIGmM2WwJRrPiBOJOq8Ueti8hLgpfFQYuQ/kKTOOhk3s3xqA8ShpeIHSldISMoPzE49GOOKkp8ZIJkXLERThR+MEbUlllkssjw6Vc+8XfnugRDZBnRAJ5o6NA4p9YduI+TK5uQbUVcTzv4l6bWPupb6nqKa2Fi06SKpsdbWJIVsXCm7ov4d/71Dnbi8LFcYg+nehFx62uDKJ2uj5ZuHHEnJaq05/BVl25u9mAWoj6+Pa37lhJUn2PjS4axgJUs2r4qlbz8iuDYv75y6ZsNz8v/OShoIyytmx8S9sxybBdantF+extGi2MkHY1eqkMHUalZujWPqTmlFHAKnqEgZj6cklUXlr6V/4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199021)(38100700002)(82960400001)(86362001)(33716001)(6512007)(186003)(44832011)(26005)(6666004)(5660300002)(8936002)(7416002)(41300700001)(8676002)(53546011)(6506007)(54906003)(19627235002)(30864003)(2906002)(66574015)(83380400001)(107886003)(4326008)(6916009)(316002)(966005)(9686003)(6486002)(478600001)(66946007)(66476007)(66556008)(67856001)(579004)(559001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Tgg3ff/VU2AQqu0aXemfwtno8rigJzJR7Km4HsDU0NUE7dLQIIyW74wnKX?=
 =?iso-8859-1?Q?5Vs2Gs+yU3Sy9bVJc1W/Ej9DLTxU3WUl+AMrrorlS4eYqrqWRWucRjN8h1?=
 =?iso-8859-1?Q?whQutIYydeuwBeBGMggpJBRO7rUOFFqgqu6xMqCUz/f0njV3l0FVNDtXRI?=
 =?iso-8859-1?Q?fu9ZSlm+lM9CKIbuZCxJy9PhMdyPveeOpPMy+zwTwWB2B+mMDLRqc2t7os?=
 =?iso-8859-1?Q?7f80QdBbiUXcqJVbeWj/FbpxyK7njyzHrejSqCN8B7fi6S0tVN60fxGrtv?=
 =?iso-8859-1?Q?nrSMGWimR/hbCFNlxATJbzEKexO4qPHE8TvFBC0iO35GrlpUSuQpblLAd7?=
 =?iso-8859-1?Q?bSio+YV9CwKidlWdjdF/DYlBWK/R+iPRqnH/fjhhBz1S5oY1awHuEDPHEC?=
 =?iso-8859-1?Q?EWyEd23meEIVINGQax4uAExYSluKIophxPGBrp2kCg8gs/uglFPxrlede4?=
 =?iso-8859-1?Q?Os6WuHDHmhCWdBy07t6LkjtvBXi66hXzouD3B9jOyAuNrvfqwtDtWjrx2X?=
 =?iso-8859-1?Q?NRGEntOUw+FG6vpz/2mHXLbMkk2g34wsQ3JomFxIe3Ru5xa9NrOnHe00+O?=
 =?iso-8859-1?Q?QLu++kaSBkL+sM2dBcYt2gEIE9hEmHP1+gS8npdaDX37Wp1mgqwKxwLDQH?=
 =?iso-8859-1?Q?bh5ILrRHRirQDQVENFrzkBgQMrbZ99xdnD/QNUBl7j6Xmjaf0cg7GJ0sm4?=
 =?iso-8859-1?Q?/iNNu8rwDjhp4vZvNijAHLago2e+bJQgYZchUAHDXRBjQUK49YiBDs2GLX?=
 =?iso-8859-1?Q?PJrC8QRZTG0qzCVbb/fR7y2ioaVQOlsjEwOrLxG/AuUffvciBLUj0nY7Py?=
 =?iso-8859-1?Q?GhiwdjBlTMaDMSdOd8EuANa+Y4Dxv7U3+pLVNC2mt5OwqukYilIdw5kM/A?=
 =?iso-8859-1?Q?VdME3odNaoLrc4rvJqFT+n68vyIEa6iwn5J/EXKKU7oZuVYZypJpoAomQ5?=
 =?iso-8859-1?Q?8UJkcsu6qHgQqJAHCJ+TfLqX0qCpEI1w5ejfx8n9tZ1YxtIRUe7Qnjr5Od?=
 =?iso-8859-1?Q?rDUtbThVQ5/tbPsUW0L7nAZuLr1zI8EjSEZCxxfZgZDrxJdueFszXA7/MB?=
 =?iso-8859-1?Q?zhkPZI8nUB45tacOvIVI0sw0p73fTECPKYgLTyIAZDqlQLDAELsZ+acXvz?=
 =?iso-8859-1?Q?iB/Su80QBrDux5WttR1fuwm6KX9FjgSRGjgeVf5FcQRY3WSC5tiKN0yZov?=
 =?iso-8859-1?Q?KgG4ELzaj6z6KmUiYvlOxbLNZZjF6gw/ubYmS0QDcne9SXJqjzbH6Z+u+F?=
 =?iso-8859-1?Q?heZpCByuVXx3iIR/xxfJoq1dfDd6Fn+0Y072cL3UsYJ3ZuViJBAEFoLiS/?=
 =?iso-8859-1?Q?TNIoiWVvdFE+oK2AHhBUXjQ8v4XqqyD1E+JuGGN6vFQ+6NKIPFmGMC/L8L?=
 =?iso-8859-1?Q?msfI1ByboSkwgZUPsPJlsMbCyNalb7dXGyJRzad0vU1WROKuEHY4chWUik?=
 =?iso-8859-1?Q?RbshpA6o2KgEGkntJztWOrI/TLvM99Xjr3CVRIcY00bx7ZRAf5YDCFXkDy?=
 =?iso-8859-1?Q?g95ZJA1f92eBnt0oEezrJDWw0mTYzDxgYb9hgFvmC4B8JMCfe/badvAtiw?=
 =?iso-8859-1?Q?AiHiF1NlhrgS8QWDiByAorJ7Aw+Tj7NJndTvmCsdSp/tUXozMqwHYdh425?=
 =?iso-8859-1?Q?N9Lkd1xBT+mvGYKTiL+CC4FQ3hAZDKSpep?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35533acb-b707-4b57-1ad8-08db86077bf2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2023 14:18:11.5122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHSr7+Kr0DbtKFmd2HNmw6CPG+BdxpOJLiHb/jdgI9lTLo4ZkbMw2SxitjLwI72hEf1CR8KK4u1YXswyEPSVDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6858
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

hi, Raghavendra K T,

On Wed, Jul 05, 2023 at 11:18:37AM +0530, Raghavendra K T wrote:
> On 5/31/2023 9:55 AM, Raghavendra K T wrote:
> >   With the numa scan enhancements [1], only the threads which had previously
> > accessed vma are allowed to scan.
> > 
> > While this had improved significant system time overhead, there were corner
> > cases, which genuinely need some relaxation. For e.g.,
> > 
> > 1) Concern raised by PeterZ, where if there are N partition sets of vmas
> > belonging to tasks, then unfairness in allowing these threads to scan could
> > potentially amplify the side effect of some of the vmas being left
> > unscanned.
> > 
> > 2) Below reports of LKP numa01 benchmark regression.
> > 
> > Currently this is handled by allowing first two scanning unconditional
> > as indicated by mm->numa_scan_seq. This is imprecise since for some
> > benchmark vma scanning might itself start at numa_scan_seq > 2.
> > 
> > Solution:
> > Allow unconditional scanning of vmas of tasks depending on vma size. This
> > is achieved by maintaining a per vma scan counter, where
> > 
> > f(allowed_to_scan) = f(scan_counter <  vma_size / scan_size)
> > 
> > Result:
> > numa01_THREAD_ALLOC result on 6.4.0-rc2 (that has numascan enhancement)
> >                  	base-numascan	base		base+fix
> > real    		1m1.507s	1m23.259s	1m2.632s
> > user    		213m51.336s	251m46.363s	220m35.528s
> > sys     		3m3.397s	0m12.492s	2m41.393s
> > 
> > numa_hit 		5615517		4560123		4963875
> > numa_local 		5615505		4560024		4963700
> > numa_other 		12		99		175
> > numa_pte_updates 	1822797		493		1559111
> > numa_hint_faults 	1307113		523		1469031
> > numa_hint_faults_local 	612617		488		884829
> > numa_pages_migrated 	694370		35		584202
> > 
> > Summary: Regression in base is recovered by allowing scanning as required.
> > 
> > [1] https://lore.kernel.org/lkml/cover.1677672277.git.raghavendra.kt@amd.com/T/#t
> > 
> > Fixes: fc137c0ddab2 ("sched/numa: enhance vma scanning logic")
> > regression.
> > Reported-by: Aithal Srikanth <sraithal@amd.com>
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/lkml/db995c11-08ba-9abf-812f-01407f70a5d4@amd.com/T/
> > Signed-off-by: Raghavendra K T <raghavendra.kt@amd.com>
> 
> Hello kernel test robot,
> 
> Gentle ping to check if the patch has helped your regression report.

sorry for late.

previously we found a 118.9% regression of autonuma-benchmark.numa01.seconds
on a Cascade Lake, which happened to be converted for other test purposes, so
we cannot test your patch on it again.

however, we also found a 39.3% regression on a Sapphire Rapids test machine:

=========================================================================================
compiler/cpufreq_governor/iterations/kconfig/rootfs/tbox_group/test/testcase:
  gcc-11/performance/4x/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-spr-r02/numa02_SMT/autonuma-benchmark

ef6a22b70f6d9044 fc137c0ddab29b591db6a091dc6
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
    193.14           +39.2%     268.84        autonuma-benchmark.numa01.seconds
      8.14            -0.7%       8.09        autonuma-benchmark.numa02.seconds


now we tested your v3 patch on it, found regression mostly recovered
(55fd15913b18d6a790c17d947df is just [RFC PATCH V3 1/1] sched/numa: Fix disjoint set vma scan regression)

=========================================================================================
compiler/cpufreq_governor/iterations/kconfig/rootfs/tbox_group/test/testcase:
  gcc-11/performance/4x/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-spr-r02/numa01_THREAD_ALLOC/autonuma-benchmark

ef6a22b70f6d9044 55fd15913b18d6a790c17d947df
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
    193.14            +5.8%     204.37 ±  3%  autonuma-benchmark.numa01.seconds
      8.14            -0.9%       8.06        autonuma-benchmark.numa02.seconds

detail comparison as below:


=========================================================================================
compiler/cpufreq_governor/iterations/kconfig/rootfs/tbox_group/test/testcase:
  gcc-11/performance/4x/x86_64-rhel-8.3/debian-11.1-x86_64-20220510.cgz/lkp-spr-r02/numa01_THREAD_ALLOC/autonuma-benchmark

ef6a22b70f6d9044 55fd15913b18d6a790c17d947df
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
 1.185e+10 ±  6%     +43.9%  1.705e+10 ±  6%  cpuidle..time
  12184642 ±  6%     +44.0%   17542134 ±  6%  cpuidle..usage
      5.00 ±100%    -100.0%       0.00        dmesg.bootstage:last
    189.35 ± 11%     +32.1%     250.07 ± 20%  dmesg.timestamp:last
      1021           +12.6%       1149 ±  3%  uptime.boot
     21665 ±  6%     +50.5%      32596 ± 22%  uptime.idle
     47.15 ± 16%     +84.9%      87.19 ± 53%  boot-time.boot
     42.12 ± 17%     +88.2%      79.25 ± 58%  boot-time.dhcp
      9448 ± 18%     +60.5%      15162 ± 51%  boot-time.idle
      6.93          +267.2%      25.45 ± 76%  boot-time.smp_boot
      5.43 ±  5%      +1.8        7.21 ±  5%  mpstat.cpu.all.idle%
      0.02 ± 15%      -0.0        0.01 ± 10%  mpstat.cpu.all.iowait%
      1.08            -0.1        1.03        mpstat.cpu.all.irq%
      0.06 ±  2%      +0.0        0.08 ±  2%  mpstat.cpu.all.soft%
      1.99            -0.2        1.81 ±  2%  mpstat.cpu.all.sys%
     91.41            -1.6       89.86        mpstat.cpu.all.usr%
      0.00          -100.0%       0.00        numa-numastat.node0.interleave_hit
   1912287 ±  6%      -3.9%    1837158 ± 13%  numa-numastat.node0.local_node
   2592838 ±  5%      -9.8%    2338452 ± 13%  numa-numastat.node0.numa_hit
    680538 ±  6%     -26.3%     501281 ± 30%  numa-numastat.node0.other_node
      0.00          -100.0%       0.00        numa-numastat.node1.interleave_hit
   1890172 ±  6%     +11.2%    2101474 ± 14%  numa-numastat.node1.local_node
   2436852 ±  5%     +15.4%    2811758 ± 13%  numa-numastat.node1.numa_hit
    546653 ±  6%     +29.9%     710290 ± 23%  numa-numastat.node1.other_node
    970.73            +9.1%       1059 ±  2%  time.elapsed_time
    970.73            +9.1%       1059 ±  2%  time.elapsed_time.max
    624931            +4.9%     655561 ±  2%  time.involuntary_context_switches
     25.00 ± 21%      +8.7%      27.17 ± 19%  time.major_page_faults
   3150370            +0.0%    3150530        time.maximum_resident_set_size
   2514815            -0.6%    2498715 ±  2%  time.minor_page_faults
      4096            +0.0%       4096        time.page_size
     20893            -1.9%      20499        time.percent_of_cpu_this_job_got
      3931            -0.8%       3899        time.system_time
    198882            +7.2%     213298 ±  2%  time.user_time
     37974 ± 13%     -21.0%      29982 ±  7%  time.voluntary_context_switches
      5.17 ±  7%     +35.5%       7.00 ±  8%  vmstat.cpu.id
      2.50 ± 20%     -20.0%       2.00        vmstat.cpu.sy
     90.83            -1.8%      89.17        vmstat.cpu.us
      0.00          -100.0%       0.00        vmstat.cpu.wa
      1.67 ± 44%     -40.0%       1.00 ±100%  vmstat.io.bi
      4.00            +0.0%       4.00        vmstat.memory.buff
   3256207 ±  3%      +3.6%    3373341        vmstat.memory.cache
 2.524e+08            -0.0%  2.523e+08        vmstat.memory.free
      0.00          -100.0%       0.00        vmstat.procs.b
    212.17            -1.6%     208.83        vmstat.procs.r
      2330 ±  7%      -7.8%       2148        vmstat.system.cs
    233033            -1.3%     229952        vmstat.system.in
    193.14            +5.8%     204.37 ±  3%  autonuma-benchmark.numa01.seconds
     40.49 ±  3%     +27.3%      51.53 ±  4%  autonuma-benchmark.numa01_THREAD_ALLOC.seconds
      8.14            -0.9%       8.06        autonuma-benchmark.numa02.seconds
    970.73            +9.1%       1059 ±  2%  autonuma-benchmark.time.elapsed_time
    970.73            +9.1%       1059 ±  2%  autonuma-benchmark.time.elapsed_time.max
    624931            +4.9%     655561 ±  2%  autonuma-benchmark.time.involuntary_context_switches
     25.00 ± 21%      +8.7%      27.17 ± 19%  autonuma-benchmark.time.major_page_faults
   3150370            +0.0%    3150530        autonuma-benchmark.time.maximum_resident_set_size
   2514815            -0.6%    2498715 ±  2%  autonuma-benchmark.time.minor_page_faults
      4096            +0.0%       4096        autonuma-benchmark.time.page_size
     20893            -1.9%      20499        autonuma-benchmark.time.percent_of_cpu_this_job_got
      3931            -0.8%       3899        autonuma-benchmark.time.system_time
    198882            +7.2%     213298 ±  2%  autonuma-benchmark.time.user_time
     37974 ± 13%     -21.0%      29982 ±  7%  autonuma-benchmark.time.voluntary_context_switches
      2737            -1.8%       2687        turbostat.Avg_MHz
     94.39            -1.7       92.66        turbostat.Busy%
      2900            +0.0%       2900        turbostat.Bzy_MHz
     12957 ± 36%     +15.9%      15015 ± 25%  turbostat.C1
   5540462 ±  6%     +46.1%    8093574 ±  6%  turbostat.C1E
      2.48 ±  5%      +0.8        3.30 ±  6%  turbostat.C1E%
   6453445 ±  6%     +43.6%    9265716 ±  6%  turbostat.C6
      2.92 ±  5%      +0.9        3.84 ±  6%  turbostat.C6%
      5.61 ±  5%     +30.8%       7.34 ±  5%  turbostat.CPU%c1
     43.17 ±  7%      +6.2%      45.83 ±  5%  turbostat.CoreTmp
 2.307e+08            +6.0%  2.446e+08 ±  2%  turbostat.IRQ
      7.90 ± 31%      +5.7       13.56 ± 32%  turbostat.PKG_%
     28989 ± 36%     -32.3%      19619 ± 11%  turbostat.POLL
     43.17 ±  7%      +6.6%      46.00 ±  6%  turbostat.PkgTmp
    666.52            -0.1%     665.80        turbostat.PkgWatt
     70.96            -2.9%      68.89        turbostat.RAMWatt
      2000            +0.0%       2000        turbostat.TSC_MHz
    237031 ± 49%     +47.9%     350630 ±  3%  meminfo.Active
    236935 ± 49%     +47.9%     350502 ±  3%  meminfo.Active(anon)
     96.00 ± 33%     +33.3%     128.00        meminfo.Active(file)
   6155451            +1.0%    6215315        meminfo.AnonHugePages
   6257767            +0.4%    6284278        meminfo.AnonPages
      4.00            +0.0%       4.00        meminfo.Buffers
   3088930 ±  3%      +4.0%    3211320        meminfo.Cached
 1.318e+08            -0.0%  1.318e+08        meminfo.CommitLimit
   8554815            +1.6%    8690945        meminfo.Committed_AS
 2.567e+08            -0.1%  2.566e+08        meminfo.DirectMap1G
  10951680 ±  3%     +17.0%   12811605 ±  5%  meminfo.DirectMap2M
   2437198           -69.1%     752036 ± 14%  meminfo.DirectMap4k
      2048            +0.0%       2048        meminfo.Hugepagesize
   6294588            +0.5%    6326486        meminfo.Inactive
   6294432            +0.5%    6326322        meminfo.Inactive(anon)
    156.00 ±  5%      +5.0%     163.83        meminfo.Inactive(file)
    167387            -3.1%     162160        meminfo.KReclaimable
     39732            +0.0%      39751        meminfo.KernelStack
     87203 ±  6%     +12.8%      98392 ± 14%  meminfo.Mapped
 2.514e+08            -0.0%  2.513e+08        meminfo.MemAvailable
 2.524e+08            -0.0%  2.523e+08        meminfo.MemFree
 2.637e+08            -0.0%  2.637e+08        meminfo.MemTotal
  11248567            +0.8%   11333611        meminfo.Memused
      1604            +4.3%       1673        meminfo.Mlocked
     16758            +0.3%      16803        meminfo.PageTables
    110655            -7.3%     102584        meminfo.Percpu
    167387            -3.1%     162160        meminfo.SReclaimable
    430222            -0.4%     428319        meminfo.SUnreclaim
    273371 ± 42%     +43.6%     392445        meminfo.Shmem
    597610            -1.2%     590480        meminfo.Slab
   2815544            +0.1%    2818830        meminfo.Unevictable
 1.374e+13            +0.0%  1.374e+13        meminfo.VmallocTotal
    338296           -17.2%     280268        meminfo.VmallocUsed
  12911235            -0.2%   12891540        meminfo.max_used_kB
     29565 ±175%     +18.3%      34976 ±214%  numa-meminfo.node0.Active
     29522 ±175%     +18.3%      34912 ±214%  numa-meminfo.node0.Active(anon)
     42.67 ±111%     +49.6%      63.83 ±100%  numa-meminfo.node0.Active(file)
   3202041 ±  2%      -8.3%    2935773 ± 10%  numa-meminfo.node0.AnonHugePages
   3256105 ±  2%      -8.9%    2967039 ± 10%  numa-meminfo.node0.AnonPages
   6450186            -0.6%    6408448        numa-meminfo.node0.AnonPages.max
   2728164 ±  2%     -13.5%    2360218 ± 41%  numa-meminfo.node0.FilePages
   3266857 ±  2%      -8.9%    2976525 ± 10%  numa-meminfo.node0.Inactive
   3266783 ±  2%      -8.9%    2976443 ± 10%  numa-meminfo.node0.Inactive(anon)
     74.00 ±100%     +10.6%      81.83 ± 93%  numa-meminfo.node0.Inactive(file)
    101285 ±  9%      -9.0%      92138 ± 27%  numa-meminfo.node0.KReclaimable
     20573 ±  3%      -2.1%      20149 ±  8%  numa-meminfo.node0.KernelStack
     51364 ±  7%      -5.0%      48807 ± 35%  numa-meminfo.node0.Mapped
 1.246e+08            +0.7%  1.254e+08        numa-meminfo.node0.MemFree
 1.316e+08            +0.0%  1.316e+08        numa-meminfo.node0.MemTotal
   7033196 ±  2%     -11.9%    6193901 ± 15%  numa-meminfo.node0.MemUsed
      1487 ±  7%      -6.6%       1388 ± 37%  numa-meminfo.node0.Mlocked
      9628 ± 12%     -26.6%       7070 ± 36%  numa-meminfo.node0.PageTables
    101285 ±  9%      -9.0%      92138 ± 27%  numa-meminfo.node0.SReclaimable
    237810 ±  7%      -6.4%     222602 ±  5%  numa-meminfo.node0.SUnreclaim
     39839 ±139%     +11.9%      44566 ±194%  numa-meminfo.node0.Shmem
    339095 ±  5%      -7.2%     314741 ± 10%  numa-meminfo.node0.Slab
   2688324 ±  2%     -13.9%    2315704 ± 41%  numa-meminfo.node0.Unevictable
    207469 ± 53%     +52.2%     315756 ± 25%  numa-meminfo.node1.Active
    207416 ± 53%     +52.2%     315692 ± 25%  numa-meminfo.node1.Active(anon)
     53.33 ±107%     +20.0%      64.00 ±100%  numa-meminfo.node1.Active(file)
   2949624 ±  3%     +11.1%    3278227 ±  9%  numa-meminfo.node1.AnonHugePages
   2997887 ±  2%     +10.6%    3315853 ±  9%  numa-meminfo.node1.AnonPages
   6474808            +0.0%    6477523        numa-meminfo.node1.AnonPages.max
    360720 ± 40%    +136.0%     851138 ±114%  numa-meminfo.node1.FilePages
   3024066 ±  2%     +10.7%    3348368 ±  9%  numa-meminfo.node1.Inactive
   3023983 ±  2%     +10.7%    3348286 ±  9%  numa-meminfo.node1.Inactive(anon)
     82.00 ± 93%      -0.2%      81.83 ± 93%  numa-meminfo.node1.Inactive(file)
     66102 ± 14%      +5.9%      70021 ± 36%  numa-meminfo.node1.KReclaimable
     19151 ±  3%      +2.3%      19600 ±  8%  numa-meminfo.node1.KernelStack
     35805 ± 13%     +38.0%      49423 ± 17%  numa-meminfo.node1.Mapped
 1.278e+08            -0.7%  1.269e+08        numa-meminfo.node1.MemFree
  1.32e+08            -0.0%   1.32e+08        numa-meminfo.node1.MemTotal
   4211780 ±  6%     +22.0%    5137530 ± 18%  numa-meminfo.node1.MemUsed
    116.67 ±100%    +145.4%     286.33 ±183%  numa-meminfo.node1.Mlocked
      7122 ± 16%     +36.6%       9729 ± 27%  numa-meminfo.node1.PageTables
     66102 ± 14%      +5.9%      70021 ± 36%  numa-meminfo.node1.SReclaimable
    192408 ±  9%      +6.9%     205718 ±  5%  numa-meminfo.node1.SUnreclaim
    233482 ± 47%     +49.0%     347910 ± 24%  numa-meminfo.node1.Shmem
    258511 ±  6%      +6.7%     275740 ± 11%  numa-meminfo.node1.Slab
    127219 ± 57%    +295.5%     503125 ±189%  numa-meminfo.node1.Unevictable
      7390 ±175%     +18.1%       8730 ±214%  numa-vmstat.node0.nr_active_anon
     10.67 ±111%     +48.4%      15.83 ±100%  numa-vmstat.node0.nr_active_file
    812998 ±  2%      -8.8%     741650 ± 10%  numa-vmstat.node0.nr_anon_pages
      1560 ±  2%      -8.2%       1432 ± 10%  numa-vmstat.node0.nr_anon_transparent_hugepages
    682054 ±  2%     -13.5%     590056 ± 41%  numa-vmstat.node0.nr_file_pages
  31146566            +0.7%   31355317        numa-vmstat.node0.nr_free_pages
    815598 ±  2%      -8.8%     744048 ± 10%  numa-vmstat.node0.nr_inactive_anon
     18.50 ±100%      +9.9%      20.33 ± 94%  numa-vmstat.node0.nr_inactive_file
     40.50 ± 14%     -62.1%      15.33 ± 39%  numa-vmstat.node0.nr_isolated_anon
     20572 ±  3%      -2.1%      20150 ±  8%  numa-vmstat.node0.nr_kernel_stack
     12953 ±  7%      -4.8%      12333 ± 35%  numa-vmstat.node0.nr_mapped
    371.33 ±  7%      -6.6%     346.67 ± 37%  numa-vmstat.node0.nr_mlock
      2406 ± 12%     -26.6%       1767 ± 36%  numa-vmstat.node0.nr_page_table_pages
      9973 ±139%     +11.7%      11143 ±194%  numa-vmstat.node0.nr_shmem
     25321 ±  9%      -9.0%      23034 ± 27%  numa-vmstat.node0.nr_slab_reclaimable
     59452 ±  7%      -6.4%      55651 ±  5%  numa-vmstat.node0.nr_slab_unreclaimable
    672080 ±  2%     -13.9%     578925 ± 41%  numa-vmstat.node0.nr_unevictable
      7390 ±175%     +18.1%       8730 ±214%  numa-vmstat.node0.nr_zone_active_anon
     10.67 ±111%     +48.4%      15.83 ±100%  numa-vmstat.node0.nr_zone_active_file
    815599 ±  2%      -8.8%     744047 ± 10%  numa-vmstat.node0.nr_zone_inactive_anon
     18.50 ±100%      +9.9%      20.33 ± 94%  numa-vmstat.node0.nr_zone_inactive_file
    672080 ±  2%     -13.9%     578925 ± 41%  numa-vmstat.node0.nr_zone_unevictable
   2593013 ±  5%      -9.8%    2338261 ± 13%  numa-vmstat.node0.numa_hit
      0.00          -100.0%       0.00        numa-vmstat.node0.numa_interleave
   1912463 ±  6%      -3.9%    1836967 ± 13%  numa-vmstat.node0.numa_local
    680538 ±  6%     -26.3%     501281 ± 30%  numa-vmstat.node0.numa_other
     51877 ± 53%     +52.2%      78947 ± 25%  numa-vmstat.node1.nr_active_anon
     13.33 ±107%     +20.0%      16.00 ±100%  numa-vmstat.node1.nr_active_file
    750017 ±  2%     +10.6%     829613 ±  9%  numa-vmstat.node1.nr_anon_pages
      1440 ±  3%     +11.1%       1601 ±  9%  numa-vmstat.node1.nr_anon_transparent_hugepages
     90208 ± 40%    +135.9%     212803 ±114%  numa-vmstat.node1.nr_file_pages
  31957700            -0.7%   31726112        numa-vmstat.node1.nr_free_pages
    756559 ±  2%     +10.7%     837739 ±  9%  numa-vmstat.node1.nr_inactive_anon
     20.50 ± 93%      -0.8%      20.33 ± 93%  numa-vmstat.node1.nr_inactive_file
     37.00 ±  9%     -26.6%      27.17 ± 26%  numa-vmstat.node1.nr_isolated_anon
     19147 ±  3%      +2.3%      19596 ±  8%  numa-vmstat.node1.nr_kernel_stack
      9012 ± 13%     +37.6%      12401 ± 17%  numa-vmstat.node1.nr_mapped
     29.00 ±100%    +146.6%      71.50 ±184%  numa-vmstat.node1.nr_mlock
      1779 ± 16%     +36.7%       2433 ± 27%  numa-vmstat.node1.nr_page_table_pages
     58399 ± 47%     +49.0%      86996 ± 24%  numa-vmstat.node1.nr_shmem
     16525 ± 14%      +5.9%      17505 ± 36%  numa-vmstat.node1.nr_slab_reclaimable
     48100 ±  9%      +6.9%      51428 ±  5%  numa-vmstat.node1.nr_slab_unreclaimable
     31804 ± 57%    +295.5%     125781 ±189%  numa-vmstat.node1.nr_unevictable
     51877 ± 53%     +52.2%      78946 ± 25%  numa-vmstat.node1.nr_zone_active_anon
     13.33 ±107%     +20.0%      16.00 ±100%  numa-vmstat.node1.nr_zone_active_file
    756560 ±  2%     +10.7%     837741 ±  9%  numa-vmstat.node1.nr_zone_inactive_anon
     20.50 ± 93%      -0.8%      20.33 ± 93%  numa-vmstat.node1.nr_zone_inactive_file
     31804 ± 57%    +295.5%     125781 ±189%  numa-vmstat.node1.nr_zone_unevictable
   2436786 ±  5%     +15.4%    2811280 ± 13%  numa-vmstat.node1.numa_hit
      0.00          -100.0%       0.00        numa-vmstat.node1.numa_interleave
   1890106 ±  6%     +11.2%    2100996 ± 14%  numa-vmstat.node1.numa_local
    546653 ±  6%     +29.9%     710290 ± 23%  numa-vmstat.node1.numa_other
      1159           -70.9%     336.83 ± 15%  proc-vmstat.direct_map_level2_splits
      6.17 ± 17%      -2.7%       6.00 ± 19%  proc-vmstat.direct_map_level3_splits
     59245 ± 49%     +48.0%      87655 ±  3%  proc-vmstat.nr_active_anon
     24.00 ± 33%     +33.3%      32.00        proc-vmstat.nr_active_file
   1562608            +0.5%    1570691        proc-vmstat.nr_anon_pages
      3001            +1.1%       3033        proc-vmstat.nr_anon_transparent_hugepages
   6272807            -0.0%    6270545        proc-vmstat.nr_dirty_background_threshold
  12560952            -0.0%   12556422        proc-vmstat.nr_dirty_threshold
    772234 ±  3%      +4.0%     802849        proc-vmstat.nr_file_pages
  63104657            -0.0%   63082004        proc-vmstat.nr_free_pages
   1571739            +0.6%    1581204        proc-vmstat.nr_inactive_anon
     39.00 ±  5%      +4.7%      40.83        proc-vmstat.nr_inactive_file
     77.67 ±  6%     -50.9%      38.17 ± 15%  proc-vmstat.nr_isolated_anon
     39726            +0.1%      39748        proc-vmstat.nr_kernel_stack
     21963 ±  6%     +12.8%      24764 ± 14%  proc-vmstat.nr_mapped
    400.67            +4.4%     418.33        proc-vmstat.nr_mlock
      4186            +0.3%       4199        proc-vmstat.nr_page_table_pages
     68343 ± 42%     +43.6%      98129        proc-vmstat.nr_shmem
     41846            -3.1%      40539        proc-vmstat.nr_slab_reclaimable
    107554            -0.4%     107079        proc-vmstat.nr_slab_unreclaimable
    703885            +0.1%     704707        proc-vmstat.nr_unevictable
     59245 ± 49%     +48.0%      87655 ±  3%  proc-vmstat.nr_zone_active_anon
     24.00 ± 33%     +33.3%      32.00        proc-vmstat.nr_zone_active_file
   1571739            +0.6%    1581204        proc-vmstat.nr_zone_inactive_anon
     39.00 ±  5%      +4.7%      40.83        proc-vmstat.nr_zone_inactive_file
    703885            +0.1%     704707        proc-vmstat.nr_zone_unevictable
    200540 ±  6%     -18.2%     164021 ±  7%  proc-vmstat.numa_hint_faults
    120494 ±  5%     -10.8%     107425 ± 10%  proc-vmstat.numa_hint_faults_local
   5032020            +2.4%    5152018        proc-vmstat.numa_hit
    112746 ±  2%     -46.1%      60803 ±  4%  proc-vmstat.numa_huge_pte_updates
      0.00          -100.0%       0.00        proc-vmstat.numa_interleave
   3804791            +3.6%    3940440        proc-vmstat.numa_local
   1227192            -1.3%    1211572 ±  2%  proc-vmstat.numa_other
  11866841 ±  4%     -40.8%    7027448 ±  2%  proc-vmstat.numa_pages_migrated
  57894552 ±  2%     -45.9%   31298933 ±  4%  proc-vmstat.numa_pte_updates
     74510 ± 14%     +10.3%      82160 ± 18%  proc-vmstat.pgactivate
      0.00          -100.0%       0.00        proc-vmstat.pgalloc_dma32
 4.537e+08            -1.7%  4.462e+08        proc-vmstat.pgalloc_normal
   4907690            +3.1%    5060927        proc-vmstat.pgfault
 4.537e+08            -1.7%  4.461e+08        proc-vmstat.pgfree
     86.17 ±221%     -94.6%       4.67 ± 91%  proc-vmstat.pgmigrate_fail
  11866841 ±  4%     -40.8%    7027448 ±  2%  proc-vmstat.pgmigrate_success
      2376 ± 44%     -40.0%       1426 ±100%  proc-vmstat.pgpgin
    172880            +8.8%     188160 ±  2%  proc-vmstat.pgreuse
     98.67 ± 18%     +24.8%     123.17 ±  9%  proc-vmstat.thp_collapse_alloc
     14.67 ± 35%      +0.0%      14.67 ± 28%  proc-vmstat.thp_deferred_split_page
     26654            +0.0%      26654        proc-vmstat.thp_fault_alloc
      0.17 ±223%    -100.0%       0.00        proc-vmstat.thp_migration_fail
     23128 ±  4%     -40.8%      13682 ±  2%  proc-vmstat.thp_migration_success
     14.67 ± 35%      +0.0%      14.67 ± 28%  proc-vmstat.thp_split_pmd
      0.00          -100.0%       0.00        proc-vmstat.thp_zero_page_alloc
      1005 ± 12%     -12.2%     883.33        proc-vmstat.unevictable_pgs_culled
    607.00            -0.1%     606.67        proc-vmstat.unevictable_pgs_mlocked
      4.00 ± 14%      -8.3%       3.67 ± 20%  proc-vmstat.unevictable_pgs_munlocked
      3.83 ± 17%     -13.0%       3.33 ± 14%  proc-vmstat.unevictable_pgs_rescued
   7602432            +8.8%    8273408 ±  3%  proc-vmstat.unevictable_pgs_scanned
   1459346          -100.0%       0.00        proc-vmstat.vma_lock_abort
      2043 ± 47%    -100.0%       0.00        proc-vmstat.vma_lock_retry
   1755990          -100.0%       0.00        proc-vmstat.vma_lock_success
     54.87 ± 10%     -28.5%      39.24 ±  5%  perf-stat.i.MPKI
 4.041e+08            -4.1%  3.877e+08        perf-stat.i.branch-instructions
      0.62            -0.0        0.61        perf-stat.i.branch-miss-rate%
   1799541            -2.6%    1752689        perf-stat.i.branch-misses
     29.53 ±  2%      -3.0       26.50 ±  2%  perf-stat.i.cache-miss-rate%
  52797131 ± 10%     -27.3%   38359610 ±  4%  perf-stat.i.cache-misses
 1.172e+08 ±  6%     -20.3%   93439529 ±  2%  perf-stat.i.cache-references
      2294 ±  7%      -7.8%       2116        perf-stat.i.context-switches
    541.44            -2.3%     529.18        perf-stat.i.cpi
    224169            -0.0%     224149        perf-stat.i.cpu-clock
  6.06e+11            -1.7%  5.954e+11        perf-stat.i.cpu-cycles
    233.65            -1.7%     229.68        perf-stat.i.cpu-migrations
     94785 ±  2%     +16.9%     110768 ±  3%  perf-stat.i.cycles-between-cache-misses
      0.07 ±  9%      +0.0        0.10 ±  8%  perf-stat.i.dTLB-load-miss-rate%
    224367 ± 12%     +51.5%     339894 ±  8%  perf-stat.i.dTLB-load-misses
 4.949e+08            -3.1%  4.795e+08        perf-stat.i.dTLB-loads
      0.60            -0.0        0.58        perf-stat.i.dTLB-store-miss-rate%
   1041912            -1.8%    1022937        perf-stat.i.dTLB-store-misses
 1.832e+08            +0.6%  1.844e+08        perf-stat.i.dTLB-stores
 1.893e+09            -3.3%   1.83e+09        perf-stat.i.instructions
      0.00 ±  3%      -4.0%       0.00        perf-stat.i.ipc
      0.11 ± 19%     -22.4%       0.09 ± 12%  perf-stat.i.major-faults
      2.70            -1.7%       2.66        perf-stat.i.metric.GHz
      1516 ±  2%      +0.7%       1526        perf-stat.i.metric.K/sec
      3.79 ±  2%      -6.3%       3.56        perf-stat.i.metric.M/sec
      5088            -5.0%       4834 ±  2%  perf-stat.i.minor-faults
     49.22            -1.9       47.29        perf-stat.i.node-load-miss-rate%
    965573 ±  3%     -25.0%     724436 ±  3%  perf-stat.i.node-load-misses
    740879 ±  8%      -2.0%     725851 ±  9%  perf-stat.i.node-loads
      5088            -5.0%       4835 ±  2%  perf-stat.i.page-faults
    224169            -0.0%     224149        perf-stat.i.task-clock
     59.37 ±  5%     -17.5%      48.98        perf-stat.overall.MPKI
      0.45            +0.0        0.46        perf-stat.overall.branch-miss-rate%
     44.29 ±  4%      -3.9       40.39 ±  2%  perf-stat.overall.cache-miss-rate%
    332.08            +1.9%     338.53        perf-stat.overall.cpi
     12720 ± 10%     +34.7%      17135 ±  4%  perf-stat.overall.cycles-between-cache-misses
      0.05 ± 18%      +0.0        0.07 ±  7%  perf-stat.overall.dTLB-load-miss-rate%
      0.57            -0.0        0.56        perf-stat.overall.dTLB-store-miss-rate%
      0.00            -1.9%       0.00        perf-stat.overall.ipc
     55.05 ±  6%      -6.7       48.39 ±  4%  perf-stat.overall.node-load-miss-rate%
 3.897e+08            -4.4%  3.726e+08        perf-stat.ps.branch-instructions
   1760709            -2.7%    1713424        perf-stat.ps.branch-misses
  48311108 ±  9%     -27.6%   34960590 ±  4%  perf-stat.ps.cache-misses
 1.089e+08 ±  5%     -20.5%   86529746        perf-stat.ps.cache-references
      2280 ±  7%      -7.7%       2105        perf-stat.ps.context-switches
    223740            +0.0%     223765        perf-stat.ps.cpu-clock
 6.088e+11            -1.8%   5.98e+11        perf-stat.ps.cpu-cycles
    230.49            -1.6%     226.70        perf-stat.ps.cpu-migrations
    223824 ± 18%     +49.2%     333910 ±  7%  perf-stat.ps.dTLB-load-misses
   4.8e+08            -3.4%  4.638e+08        perf-stat.ps.dTLB-loads
   1041413            -2.0%    1020849        perf-stat.ps.dTLB-store-misses
 1.812e+08            +0.6%  1.823e+08        perf-stat.ps.dTLB-stores
 1.833e+09            -3.6%  1.767e+09        perf-stat.ps.instructions
      0.11 ± 18%     -21.9%       0.08 ± 13%  perf-stat.ps.major-faults
      4861            -5.2%       4608 ±  2%  perf-stat.ps.minor-faults
    971538 ±  5%     -25.0%     728715 ±  5%  perf-stat.ps.node-load-misses
    795675 ± 10%      -1.8%     781081 ± 10%  perf-stat.ps.node-loads
      4861            -5.2%       4608 ±  2%  perf-stat.ps.page-faults
    223740            +0.0%     223765        perf-stat.ps.task-clock
 1.781e+12            +5.2%  1.873e+12        perf-stat.total.instructions
     32005 ± 86%     +12.8%      36117 ±135%  sched_debug.cfs_rq:/.MIN_vruntime.avg
   6653945 ± 94%     +15.2%    7664854 ±135%  sched_debug.cfs_rq:/.MIN_vruntime.max
      0.00            +0.0%       0.00        sched_debug.cfs_rq:/.MIN_vruntime.min
    456998 ± 91%     +14.7%     524024 ±135%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
      0.92 ±  2%      -1.1%       0.91 ±  5%  sched_debug.cfs_rq:/.h_nr_running.avg
      1.90 ±  4%      -6.2%       1.78 ±  3%  sched_debug.cfs_rq:/.h_nr_running.max
      0.67 ± 18%      -5.0%       0.64 ± 20%  sched_debug.cfs_rq:/.h_nr_running.min
      0.15 ± 12%      +0.4%       0.15 ± 24%  sched_debug.cfs_rq:/.h_nr_running.stddev
      5652 ±  6%      -3.0%       5483 ± 13%  sched_debug.cfs_rq:/.load.avg
    250428 ± 13%     -14.4%     214489 ± 49%  sched_debug.cfs_rq:/.load.max
      1548 ± 26%      -8.3%       1420 ± 20%  sched_debug.cfs_rq:/.load.min
     18136 ± 14%     -12.5%      15867 ± 46%  sched_debug.cfs_rq:/.load.stddev
      7.26 ±  9%      -0.6%       7.22 ± 12%  sched_debug.cfs_rq:/.load_avg.avg
    215.19 ± 20%      +3.0%     221.67 ± 22%  sched_debug.cfs_rq:/.load_avg.max
      1.55 ± 18%      -9.0%       1.41 ± 21%  sched_debug.cfs_rq:/.load_avg.min
     22.20 ± 15%      +1.2%      22.46 ± 13%  sched_debug.cfs_rq:/.load_avg.stddev
     32005 ± 86%     +12.8%      36117 ±135%  sched_debug.cfs_rq:/.max_vruntime.avg
   6653945 ± 94%     +15.2%    7664854 ±135%  sched_debug.cfs_rq:/.max_vruntime.max
      0.00            +0.0%       0.00        sched_debug.cfs_rq:/.max_vruntime.min
    456998 ± 91%     +14.7%     524024 ±135%  sched_debug.cfs_rq:/.max_vruntime.stddev
 1.203e+08 ±  5%     +11.8%  1.345e+08 ±  2%  sched_debug.cfs_rq:/.min_vruntime.avg
 1.231e+08 ±  5%     +12.5%  1.385e+08 ±  2%  sched_debug.cfs_rq:/.min_vruntime.max
  99360296 ±  6%      +9.4%  1.087e+08 ±  4%  sched_debug.cfs_rq:/.min_vruntime.min
   2529598 ±  9%     +32.7%    3357930 ± 15%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.91 ±  2%      -0.9%       0.90 ±  5%  sched_debug.cfs_rq:/.nr_running.avg
      1.10 ±  7%      -3.8%       1.06 ±  6%  sched_debug.cfs_rq:/.nr_running.max
      0.67 ± 18%      -5.0%       0.64 ± 20%  sched_debug.cfs_rq:/.nr_running.min
      0.08 ± 39%     +16.1%       0.09 ± 51%  sched_debug.cfs_rq:/.nr_running.stddev
      1.68 ± 48%      -5.5%       1.59 ± 64%  sched_debug.cfs_rq:/.removed.load_avg.avg
     76.51 ± 34%      -0.4%      76.20 ± 34%  sched_debug.cfs_rq:/.removed.load_avg.max
     10.52 ± 17%      -6.9%       9.79 ± 26%  sched_debug.cfs_rq:/.removed.load_avg.stddev
      0.82 ± 50%      -7.1%       0.76 ± 65%  sched_debug.cfs_rq:/.removed.runnable_avg.avg
     37.12 ± 24%      +1.1%      37.52 ± 31%  sched_debug.cfs_rq:/.removed.runnable_avg.max
      5.08 ± 19%      -7.5%       4.70 ± 28%  sched_debug.cfs_rq:/.removed.runnable_avg.stddev
      0.81 ± 52%      -7.1%       0.76 ± 66%  sched_debug.cfs_rq:/.removed.util_avg.avg
     35.30 ± 14%      +1.5%      35.83 ± 30%  sched_debug.cfs_rq:/.removed.util_avg.max
      4.96 ± 22%      -7.5%       4.59 ± 30%  sched_debug.cfs_rq:/.removed.util_avg.stddev
    944.71 ±  2%      -1.1%     934.57 ±  5%  sched_debug.cfs_rq:/.runnable_avg.avg
      1881 ±  3%      -6.7%       1755 ±  6%  sched_debug.cfs_rq:/.runnable_avg.max
    643.11 ± 13%      -3.7%     619.05 ± 23%  sched_debug.cfs_rq:/.runnable_avg.min
    141.77 ± 13%      +3.3%     146.48 ± 25%  sched_debug.cfs_rq:/.runnable_avg.stddev
      0.00 ±100%     +78.5%       0.00 ±153%  sched_debug.cfs_rq:/.spread.avg
      0.38 ±100%     +78.5%       0.68 ±153%  sched_debug.cfs_rq:/.spread.max
      0.03 ±100%     +78.5%       0.05 ±153%  sched_debug.cfs_rq:/.spread.stddev
   8911395 ± 18%     +77.5%   15821663 ± 33%  sched_debug.cfs_rq:/.spread0.avg
  11635928 ± 17%     +70.0%   19782673 ± 27%  sched_debug.cfs_rq:/.spread0.max
 -12145667           -17.2%  -10050665        sched_debug.cfs_rq:/.spread0.min
   2510183 ± 10%     +33.3%    3345922 ± 15%  sched_debug.cfs_rq:/.spread0.stddev
    934.78 ±  2%      -1.1%     924.53 ±  5%  sched_debug.cfs_rq:/.util_avg.avg
      1278 ±  5%      -6.2%       1198 ±  2%  sched_debug.cfs_rq:/.util_avg.max
    515.26 ± 12%      -5.7%     485.68 ± 22%  sched_debug.cfs_rq:/.util_avg.min
     95.53 ± 24%     +10.5%     105.53 ± 40%  sched_debug.cfs_rq:/.util_avg.stddev
    441.09 ±  8%     -21.8%     345.05 ± 11%  sched_debug.cfs_rq:/.util_est_enqueued.avg
      1272 ±  6%     -10.8%       1135 ±  9%  sched_debug.cfs_rq:/.util_est_enqueued.max
    280.15 ±  9%     +14.2%     319.98 ±  9%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
   1308353 ±  3%     +22.3%    1600451 ±  3%  sched_debug.cpu.avg_idle.avg
   2922459 ±  2%     +10.5%    3230277 ±  5%  sched_debug.cpu.avg_idle.max
    448661 ± 15%     +36.4%     611757 ± 13%  sched_debug.cpu.avg_idle.min
    412548 ±  5%     +38.1%     569757 ±  7%  sched_debug.cpu.avg_idle.stddev
    505223 ±  4%     +20.0%     606292 ±  5%  sched_debug.cpu.clock.avg
    505890 ±  4%     +20.0%     606955 ±  5%  sched_debug.cpu.clock.max
    504409 ±  4%     +20.1%     605556 ±  5%  sched_debug.cpu.clock.min
    415.73 ± 25%      -4.3%     397.71 ± 28%  sched_debug.cpu.clock.stddev
    499837 ±  4%     +19.8%     598837 ±  5%  sched_debug.cpu.clock_task.avg
    501130 ±  4%     +19.9%     600703 ±  5%  sched_debug.cpu.clock_task.max
    478575 ±  4%     +12.9%     540404 ±  2%  sched_debug.cpu.clock_task.min
      1619 ± 20%    +150.3%       4053 ± 73%  sched_debug.cpu.clock_task.stddev
     17029 ±  6%      +5.7%      17999 ±  7%  sched_debug.cpu.curr->pid.avg
     19932 ±  3%      +7.9%      21502        sched_debug.cpu.curr->pid.max
      9932 ± 24%      +3.7%      10302 ± 27%  sched_debug.cpu.curr->pid.min
      1540 ± 44%     +20.8%       1861 ± 55%  sched_debug.cpu.curr->pid.stddev
    591935 ±  2%     +13.8%     673677 ±  4%  sched_debug.cpu.max_idle_balance_cost.avg
   1240997 ±  5%     +12.9%    1400895 ±  4%  sched_debug.cpu.max_idle_balance_cost.max
    500000            +0.0%     500000        sched_debug.cpu.max_idle_balance_cost.min
    143032 ±  7%     +41.5%     202328 ±  5%  sched_debug.cpu.max_idle_balance_cost.stddev
      4295            +0.0%       4295        sched_debug.cpu.next_balance.avg
      4295            +0.0%       4295        sched_debug.cpu.next_balance.max
      4295            +0.0%       4295        sched_debug.cpu.next_balance.min
      0.00 ± 25%      -4.1%       0.00 ± 27%  sched_debug.cpu.next_balance.stddev
      0.91 ±  3%      -2.1%       0.89 ±  6%  sched_debug.cpu.nr_running.avg
      1.92 ±  5%      -5.3%       1.82 ±  2%  sched_debug.cpu.nr_running.max
      0.68 ± 16%      -5.2%       0.64 ± 19%  sched_debug.cpu.nr_running.min
      0.16 ± 16%      +4.0%       0.16 ± 26%  sched_debug.cpu.nr_running.stddev
      5837 ±  5%      +4.8%       6118        sched_debug.cpu.nr_switches.avg
     49744 ± 20%     +13.8%      56608 ± 24%  sched_debug.cpu.nr_switches.max
      2002 ±  6%     +14.9%       2301 ±  2%  sched_debug.cpu.nr_switches.min
      5880 ± 11%      -1.9%       5769 ± 10%  sched_debug.cpu.nr_switches.stddev
 2.039e+09 ±  3%    -100.0%       0.00 ± 76%  sched_debug.cpu.nr_uninterruptible.avg
 4.295e+09          -100.0%      46.24 ± 39%  sched_debug.cpu.nr_uninterruptible.max
      0.00       -6.3e+103%     -63.50        sched_debug.cpu.nr_uninterruptible.min
  2.14e+09          -100.0%       8.63 ± 48%  sched_debug.cpu.nr_uninterruptible.stddev
    504394 ±  4%     +20.1%     605544 ±  5%  sched_debug.cpu_clk
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.avg
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.max
    996147            +0.0%     996147        sched_debug.dl_rq:.dl_bw->bw.min
 4.295e+09            +0.0%  4.295e+09        sched_debug.jiffies
    499768 ±  4%     +20.9%     604335 ±  5%  sched_debug.ktime
      0.00 ± 19%      -4.0%       0.00 ±  2%  sched_debug.rt_rq:.rt_nr_migratory.avg
      0.12 ± 19%      -4.0%       0.11 ±  2%  sched_debug.rt_rq:.rt_nr_migratory.max
      0.01 ± 19%      -4.0%       0.01 ±  2%  sched_debug.rt_rq:.rt_nr_migratory.stddev
      0.00 ± 19%      -4.0%       0.00 ±  2%  sched_debug.rt_rq:.rt_nr_running.avg
      0.12 ± 19%      -4.0%       0.11 ±  2%  sched_debug.rt_rq:.rt_nr_running.max
      0.01 ± 19%      -4.0%       0.01 ±  2%  sched_debug.rt_rq:.rt_nr_running.stddev
    950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runtime.avg
    950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runtime.max
    950.00            +0.0%     950.00        sched_debug.rt_rq:.rt_runtime.min
      0.00        +4.1e+97%       0.00 ±223%  sched_debug.rt_rq:.rt_throttled.avg
      0.00        +9.3e+99%       0.01 ±223%  sched_debug.rt_rq:.rt_throttled.max
      0.00        +6.2e+98%       0.00 ±223%  sched_debug.rt_rq:.rt_throttled.stddev
      0.20 ± 55%     +57.2%       0.31 ± 35%  sched_debug.rt_rq:.rt_time.avg
     44.78 ± 55%     +57.2%      70.39 ± 35%  sched_debug.rt_rq:.rt_time.max
      2.99 ± 55%     +57.2%       4.69 ± 35%  sched_debug.rt_rq:.rt_time.stddev
    505282 ±  3%     +11.1%     561614 ±  2%  sched_debug.sched_clk
      1.00            +0.0%       1.00        sched_debug.sched_clock_stable()
  58611259            +0.0%   58611259        sched_debug.sysctl_sched.sysctl_sched_features
      0.75            +0.0%       0.75        sched_debug.sysctl_sched.sysctl_sched_idle_min_granularity
     24.00            +0.0%      24.00        sched_debug.sysctl_sched.sysctl_sched_latency
      3.00            +0.0%       3.00        sched_debug.sysctl_sched.sysctl_sched_min_granularity
      1.00            +0.0%       1.00        sched_debug.sysctl_sched.sysctl_sched_tunable_scaling
      4.00            +0.0%       4.00        sched_debug.sysctl_sched.sysctl_sched_wakeup_granularity
     11.97 ± 60%      -8.6        3.38 ± 66%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
     11.86 ± 60%      -8.6        3.27 ± 68%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
     11.84 ± 60%      -8.6        3.25 ± 69%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     11.59 ± 61%      -8.5        3.08 ± 71%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
     11.58 ± 64%      -8.4        3.17 ± 67%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      9.33 ± 69%      -8.3        1.06 ±191%  perf-profile.calltrace.cycles-pp.do_huge_pmd_numa_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      9.19 ± 69%      -8.2        1.01 ±192%  perf-profile.calltrace.cycles-pp.migrate_misplaced_page.do_huge_pmd_numa_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      9.19 ± 69%      -8.2        1.01 ±192%  perf-profile.calltrace.cycles-pp.migrate_pages.migrate_misplaced_page.do_huge_pmd_numa_page.__handle_mm_fault.handle_mm_fault
      9.18 ± 69%      -8.2        1.01 ±192%  perf-profile.calltrace.cycles-pp.migrate_pages_batch.migrate_pages.migrate_misplaced_page.do_huge_pmd_numa_page.__handle_mm_fault
      8.62 ± 69%      -7.7        0.93 ±191%  perf-profile.calltrace.cycles-pp.move_to_new_folio.migrate_pages_batch.migrate_pages.migrate_misplaced_page.do_huge_pmd_numa_page
      8.61 ± 69%      -7.7        0.93 ±191%  perf-profile.calltrace.cycles-pp.migrate_folio_extra.move_to_new_folio.migrate_pages_batch.migrate_pages.migrate_misplaced_page
      8.59 ± 69%      -7.7        0.93 ±191%  perf-profile.calltrace.cycles-pp.folio_copy.migrate_folio_extra.move_to_new_folio.migrate_pages_batch.migrate_pages
      8.48 ± 69%      -7.6        0.92 ±191%  perf-profile.calltrace.cycles-pp.copy_page.folio_copy.migrate_folio_extra.move_to_new_folio.migrate_pages_batch
      4.67 ±111%      -3.8        0.88 ±223%  perf-profile.calltrace.cycles-pp.perf_session__process_user_event.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
      4.66 ±111%      -3.8        0.88 ±223%  perf-profile.calltrace.cycles-pp.__ordered_events__flush.perf_session__process_user_event.reader__read_event.perf_session__process_events.record__finish_output
      3.99 ±113%      -3.3        0.71 ±223%  perf-profile.calltrace.cycles-pp.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event.reader__read_event.perf_session__process_events
      2.20 ± 53%      -2.2        0.00        perf-profile.calltrace.cycles-pp.copy_user_enhanced_fast_string.copy_page_from_iter_atomic.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      2.72 ±109%      -2.2        0.55 ±223%  perf-profile.calltrace.cycles-pp.evlist__parse_sample.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event.reader__read_event
      1.40 ± 28%      -1.4        0.00        perf-profile.calltrace.cycles-pp.drm_fbdev_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread
      1.00 ±131%      -0.9        0.14 ±223%  perf-profile.calltrace.cycles-pp.build_id__mark_dso_hit.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event.reader__read_event
      0.90 ±108%      -0.8        0.12 ±223%  perf-profile.calltrace.cycles-pp.evsel__parse_sample.evlist__parse_sample.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event
      0.85 ± 53%      -0.6        0.26 ±142%  perf-profile.calltrace.cycles-pp.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll.__cmd_record
      0.85 ± 53%      -0.6        0.26 ±142%  perf-profile.calltrace.cycles-pp.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll
      0.86 ± 52%      -0.6        0.28 ±142%  perf-profile.calltrace.cycles-pp.__poll.__cmd_record.cmd_record.run_builtin.main
      0.85 ± 53%      -0.6        0.27 ±142%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__poll.__cmd_record.cmd_record.run_builtin
      0.85 ± 53%      -0.6        0.27 ±142%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__poll.__cmd_record.cmd_record
      7.65 ± 55%      -0.6        7.09 ± 57%  perf-profile.calltrace.cycles-pp.__cmd_record.cmd_record.run_builtin.main.__libc_start_main
      7.65 ± 55%      -0.6        7.09 ± 57%  perf-profile.calltrace.cycles-pp.cmd_record.run_builtin.main.__libc_start_main
      0.53 ± 49%      -0.5        0.00        perf-profile.calltrace.cycles-pp.__fxstat64
      0.52 ± 49%      -0.5        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__fxstat64
      0.51 ± 49%      -0.5        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__fxstat64
      1.90 ± 23%      -0.5        1.41 ± 13%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork
      0.66 ± 52%      -0.5        0.21 ±144%  perf-profile.calltrace.cycles-pp.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.44 ±223%      -0.4        0.00        perf-profile.calltrace.cycles-pp.thread__find_map.build_id__mark_dso_hit.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event
      0.43 ± 76%      -0.4        0.00        perf-profile.calltrace.cycles-pp.drm_atomic_helper_dirtyfb.drm_fbdev_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread
      0.43 ±223%      -0.4        0.00        perf-profile.calltrace.cycles-pp.map__load.thread__find_map.build_id__mark_dso_hit.perf_session__deliver_event.__ordered_events__flush
      0.43 ±223%      -0.4        0.00        perf-profile.calltrace.cycles-pp.dso__load.map__load.thread__find_map.build_id__mark_dso_hit.perf_session__deliver_event
      1.50 ± 54%      -0.4        1.07 ±103%  perf-profile.calltrace.cycles-pp.cmd_stat
      1.50 ± 54%      -0.4        1.07 ±103%  perf-profile.calltrace.cycles-pp.dispatch_events.cmd_stat
      1.49 ± 55%      -0.4        1.06 ±103%  perf-profile.calltrace.cycles-pp.process_interval.dispatch_events.cmd_stat
      0.43 ±223%      -0.4        0.00        perf-profile.calltrace.cycles-pp.__dso__load_kallsyms.dso__load.map__load.thread__find_map.build_id__mark_dso_hit
      5.41 ± 57%      -0.4        5.00 ± 58%  perf-profile.calltrace.cycles-pp.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64
      0.41 ± 76%      -0.4        0.00        perf-profile.calltrace.cycles-pp.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_fb_dirty.drm_fb_helper_damage_work.process_one_work
      5.37 ± 56%      -0.4        4.96 ± 58%  perf-profile.calltrace.cycles-pp.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.vfs_write.ksys_write
      5.44 ± 56%      -0.4        5.04 ± 58%  perf-profile.calltrace.cycles-pp.generic_file_write_iter.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      5.51 ± 57%      -0.4        5.11 ± 58%  perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write
      1.41 ± 55%      -0.4        1.01 ±104%  perf-profile.calltrace.cycles-pp.read_counters.process_interval.dispatch_events.cmd_stat
      5.56 ± 57%      -0.4        5.16 ± 58%  perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write.writen
      5.57 ± 57%      -0.4        5.20 ± 58%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_write.writen.record__pushfn
      0.56 ±165%      -0.4        0.19 ±223%  perf-profile.calltrace.cycles-pp.evlist__parse_sample_timestamp.process_simple.reader__read_event.perf_session__process_events.record__finish_output
      5.58 ± 57%      -0.4        5.20 ± 58%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_write.writen.record__pushfn.perf_mmap__push
      5.60 ± 57%      -0.4        5.24 ± 58%  perf-profile.calltrace.cycles-pp.__libc_write.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist
      1.94 ± 23%      -0.4        1.58 ± 21%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
      0.72 ± 57%      -0.3        0.41 ± 71%  perf-profile.calltrace.cycles-pp.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      1.40 ± 28%      -0.3        1.08 ± 15%  perf-profile.calltrace.cycles-pp.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread.ret_from_fork
      0.31 ±105%      -0.3        0.00        perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_fb_dirty.drm_fb_helper_damage_work
      0.31 ±103%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__do_sys_newfstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__fxstat64
      0.30 ±103%      -0.3        0.00        perf-profile.calltrace.cycles-pp.irq_work_run_list.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work
      0.30 ±103%      -0.3        0.00        perf-profile.calltrace.cycles-pp.irq_work_single.irq_work_run_list.irq_work_run.__sysvec_irq_work.sysvec_irq_work
      0.30 ±103%      -0.3        0.00        perf-profile.calltrace.cycles-pp._printk.irq_work_single.irq_work_run_list.irq_work_run.__sysvec_irq_work
      0.30 ±103%      -0.3        0.00        perf-profile.calltrace.cycles-pp.vprintk_emit._printk.irq_work_single.irq_work_run_list.irq_work_run
      0.30 ±103%      -0.3        0.00        perf-profile.calltrace.cycles-pp.console_unlock.vprintk_emit._printk.irq_work_single.irq_work_run_list
      0.30 ±103%      -0.3        0.00        perf-profile.calltrace.cycles-pp.console_flush_all.console_unlock.vprintk_emit._printk.irq_work_single
      0.30 ±103%      -0.3        0.00        perf-profile.calltrace.cycles-pp.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit._printk
      0.40 ±154%      -0.3        0.13 ±223%  perf-profile.calltrace.cycles-pp.machine__findnew_thread.build_id__mark_dso_hit.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event
      0.28 ±100%      -0.3        0.00        perf-profile.calltrace.cycles-pp.sched_setaffinity.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity
      0.27 ±100%      -0.3        0.00        perf-profile.calltrace.cycles-pp.cpu_stopper_thread.smpboot_thread_fn.kthread.ret_from_fork
      1.03 ± 68%      -0.3        0.77 ± 78%  perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.26 ±100%      -0.3        0.00        perf-profile.calltrace.cycles-pp.__sched_setaffinity.sched_setaffinity.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.26 ±100%      -0.3        0.00        perf-profile.calltrace.cycles-pp.migration_cpu_stop.cpu_stopper_thread.smpboot_thread_fn.kthread.ret_from_fork
      1.05 ± 69%      -0.3        0.79 ± 78%  perf-profile.calltrace.cycles-pp.shmem_write_begin.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.vfs_write
      5.76 ± 58%      -0.3        5.50 ± 61%  perf-profile.calltrace.cycles-pp.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record
      0.35 ±103%      -0.3        0.10 ±223%  perf-profile.calltrace.cycles-pp.perf_poll.do_poll.do_sys_poll.__x64_sys_poll.do_syscall_64
      0.24 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.kallsyms__parse.__dso__load_kallsyms.dso__load.map__load.thread__find_map
      0.24 ±150%      -0.2        0.00        perf-profile.calltrace.cycles-pp.evsel__parse_sample_timestamp.process_simple.reader__read_event.perf_session__process_events.record__finish_output
      0.82 ± 31%      -0.2        0.58 ± 45%  perf-profile.calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.44 ± 75%      -0.2        0.20 ±141%  perf-profile.calltrace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.__mmput.exit_mm
      5.88 ± 57%      -0.2        5.65 ± 61%  perf-profile.calltrace.cycles-pp.record__pushfn.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record
      0.44 ± 75%      -0.2        0.20 ±141%  perf-profile.calltrace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.__mmput
      2.83 ± 29%      -0.2        2.60 ± 21%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.23 ±142%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.23 ±142%      -0.2        0.00        perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.32 ±100%      -0.2        0.09 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next.read_counters.process_interval
      0.32 ±100%      -0.2        0.09 ±223%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next.read_counters
      0.31 ±100%      -0.2        0.09 ±223%  perf-profile.calltrace.cycles-pp.__x64_sys_sched_setaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe.sched_setaffinity.evlist_cpu_iterator__next
      0.22 ±142%      -0.2        0.00        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read
      0.22 ±144%      -0.2        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_call_function
      0.22 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.perf_session__delete.__cmd_record
      3.04 ± 37%      -0.2        2.84 ± 21%  perf-profile.calltrace.cycles-pp.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64
      0.20 ±141%      -0.2        0.00        perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.19 ±141%      -0.2        0.00        perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
      0.52 ± 80%      -0.2        0.32 ±103%  perf-profile.calltrace.cycles-pp.__percpu_counter_init.mm_init.alloc_bprm.do_execveat_common.__x64_sys_execve
      0.19 ±141%      -0.2        0.00        perf-profile.calltrace.cycles-pp.drm_gem_vmap_unlocked.drm_client_buffer_vmap.drm_fbdev_fb_dirty.drm_fb_helper_damage_work.process_one_work
      0.19 ±141%      -0.2        0.00        perf-profile.calltrace.cycles-pp.drm_gem_vmap.drm_gem_vmap_unlocked.drm_client_buffer_vmap.drm_fbdev_fb_dirty.drm_fb_helper_damage_work
      0.19 ±141%      -0.2        0.00        perf-profile.calltrace.cycles-pp.drm_gem_shmem_vmap.drm_gem_vmap.drm_gem_vmap_unlocked.drm_client_buffer_vmap.drm_fbdev_fb_dirty
      0.19 ±141%      -0.2        0.00        perf-profile.calltrace.cycles-pp.drm_client_buffer_vmap.drm_fbdev_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread
      0.19 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__open64
      0.55 ± 47%      -0.2        0.36 ± 70%  perf-profile.calltrace.cycles-pp.sched_setaffinity.evlist_cpu_iterator__next.read_counters.process_interval.dispatch_events
      0.19 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__open64
      0.19 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64
      2.24 ± 53%      -0.2        2.05 ± 57%  perf-profile.calltrace.cycles-pp.copy_page_from_iter_atomic.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.vfs_write
      0.18 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64
      0.18 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__open64
      0.87 ± 57%      -0.2        0.70 ± 18%  perf-profile.calltrace.cycles-pp.do_fault.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.26 ±145%      -0.2        0.09 ±223%  perf-profile.calltrace.cycles-pp.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      0.26 ±145%      -0.2        0.09 ±223%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      0.25 ±145%      -0.2        0.08 ±223%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn
      0.25 ±145%      -0.2        0.08 ±223%  perf-profile.calltrace.cycles-pp.rcu_core.__do_softirq.run_ksoftirqd.smpboot_thread_fn.kthread
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.cmd_record
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.evlist__delete.cmd_record
      0.16 ±223%      -0.2        0.00        perf-profile.calltrace.cycles-pp.migrate_folio_unmap.migrate_pages_batch.migrate_pages.migrate_misplaced_page.do_huge_pmd_numa_page
      1.21 ± 30%      -0.2        1.05 ± 19%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exit_mm.do_exit.do_group_exit
      0.35 ±103%      -0.2        0.19 ±141%  perf-profile.calltrace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap
      1.22 ± 30%      -0.2        1.06 ± 20%  perf-profile.calltrace.cycles-pp.__mmput.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group
      0.97 ± 69%      -0.1        0.82 ± 77%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write.__generic_file_write_iter
      1.24 ± 30%      -0.1        1.09 ± 20%  perf-profile.calltrace.cycles-pp.exit_mm.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64
      0.14 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.io__get_hex.kallsyms__parse.__dso__load_kallsyms.dso__load.map__load
      0.14 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__ordered_events__flush.perf_session__process_events.record__finish_output.__cmd_record
      0.23 ±146%      -0.1        0.08 ±223%  perf-profile.calltrace.cycles-pp.perf_evsel__read.read_counters.process_interval.dispatch_events.cmd_stat
      0.14 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.select_task_rq_fair.wake_up_new_task.kernel_clone.__x64_sys_vfork.do_syscall_64
      0.14 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.find_idlest_cpu.select_task_rq_fair.wake_up_new_task.kernel_clone.__x64_sys_vfork
      0.31 ±104%      -0.1        0.17 ±141%  perf-profile.calltrace.cycles-pp.__close_nocancel
      6.66 ± 58%      -0.1        6.52 ± 62%  perf-profile.calltrace.cycles-pp.record__mmap_read_evlist.__cmd_record.cmd_record.run_builtin.main
      0.14 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.rmap_walk_anon.try_to_migrate.migrate_folio_unmap.migrate_pages_batch.migrate_pages
      0.14 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.try_to_migrate.migrate_folio_unmap.migrate_pages_batch.migrate_pages.migrate_misplaced_page
      0.14 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.try_to_migrate_one.rmap_walk_anon.try_to_migrate.migrate_folio_unmap.migrate_pages_batch
      0.54 ± 57%      -0.1        0.41 ± 72%  perf-profile.calltrace.cycles-pp.vmstat_start.seq_read_iter.proc_reg_read_iter.vfs_read.ksys_read
      6.37 ± 58%      -0.1        6.24 ± 62%  perf-profile.calltrace.cycles-pp.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record.run_builtin
      0.22 ±145%      -0.1        0.09 ±223%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.perf_session__do_write_header.__cmd_record
      0.22 ±145%      -0.1        0.09 ±223%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.13 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.find_idlest_group.find_idlest_cpu.select_task_rq_fair.wake_up_new_task.kernel_clone
      0.12 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.update_sg_wakeup_stats.find_idlest_group.find_idlest_cpu.select_task_rq_fair.wake_up_new_task
      0.12 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work
      0.12 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work
      0.12 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work
      0.12 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work
      0.12 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_read.io__get_hex.kallsyms__parse.__dso__load_kallsyms
      0.12 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read.io__get_hex.kallsyms__parse
      0.12 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__libc_read.io__get_hex.kallsyms__parse.__dso__load_kallsyms.dso__load
      0.82 ± 70%      -0.1        0.70 ± 79%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.fault_in_readable.fault_in_iov_iter_readable
      0.12 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read.io__get_hex
      0.12 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.12 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.dup_mmap.dup_mm.copy_process.kernel_clone.__do_sys_clone
      0.39 ±103%      -0.1        0.27 ±100%  perf-profile.calltrace.cycles-pp.walk_component.link_path_walk.path_openat.do_filp_open.do_sys_openat2
      1.30 ± 33%      -0.1        1.18 ±  9%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork
      0.12 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.machine__exit.perf_session__delete.__cmd_record
      0.12 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode
      0.12 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.readn.perf_evsel__read.read_counters.process_interval.dispatch_events
      0.12 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__libc_read.readn.perf_evsel__read.read_counters.process_interval
      0.12 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.wait_for_lsr.serial8250_console_write.console_flush_all.console_unlock.vprintk_emit
      3.05 ± 37%      -0.1        2.93 ± 16%  perf-profile.calltrace.cycles-pp.do_filp_open.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.12 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.seq_read_iter.seq_read.proc_reg_read.vfs_read.ksys_read
      0.12 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.seq_read.proc_reg_read.vfs_read.ksys_read.do_syscall_64
      0.12 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.proc_reg_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.12 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_read.readn.perf_evsel__read.read_counters
      0.12 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read.readn.perf_evsel__read
      0.12 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_read.readn
      0.38 ±103%      -0.1        0.27 ±100%  perf-profile.calltrace.cycles-pp.lookup_fast.walk_component.link_path_walk.path_openat.do_filp_open
      0.12 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.dso__delete.machine__exit.perf_session__delete.__cmd_record
      0.12 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.gather_pte_stats.walk_pmd_range.walk_pud_range.walk_p4d_range.walk_pgd_range
      0.12 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.migration_entry_wait_on_locked.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.11 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.evlist__close.evlist__delete.cmd_record
      0.11 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__schedule.schedule.io_schedule.migration_entry_wait_on_locked.__handle_mm_fault
      0.11 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.schedule.io_schedule.migration_entry_wait_on_locked.__handle_mm_fault.handle_mm_fault
      0.11 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.exit_to_user_mode_loop.exit_to_user_mode_prepare
      0.11 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.io_schedule.migration_entry_wait_on_locked.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      0.11 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_fb_dirty
      0.11 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb
      0.55 ± 53%      -0.1        0.44 ± 75%  perf-profile.calltrace.cycles-pp.seq_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.11 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.machine__process_fork_event.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event.reader__read_event
      0.11 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.perf_session__deliver_event.__ordered_events__flush.perf_session__process_events.record__finish_output.__cmd_record
      0.11 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.set_pmd_migration_entry.try_to_migrate_one.rmap_walk_anon.try_to_migrate.migrate_folio_unmap
      0.11 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.rb_erase.symbols__delete.dso__delete.machine__exit.perf_session__delete
      0.11 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.symbols__delete.dso__delete.machine__exit.perf_session__delete.__cmd_record
      0.11 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.next_uptodate_page.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault
      0.11 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.io_schedule.migration_entry_wait_on_locked
      0.11 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.proc_fill_cache.proc_pid_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64
      0.11 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.setlocale
      0.11 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.perf_evsel__close_cpu.evlist__close.evlist__delete.cmd_record
      0.11 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.io_schedule
      0.11 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.drm_fbdev_damage_blit_real.drm_fbdev_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread
      0.11 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.pid_revalidate.lookup_fast.walk_component.link_path_walk.path_openat
      0.20 ±144%      -0.1        0.10 ±223%  perf-profile.calltrace.cycles-pp.__collapse_huge_page_copy.collapse_huge_page.hpage_collapse_scan_pmd.khugepaged_scan_mm_slot.khugepaged
      0.11 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__mmdrop.finish_task_switch.__schedule.schedule.exit_to_user_mode_loop
      0.11 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.memcpy_erms.drm_fbdev_damage_blit_real.drm_fbdev_fb_dirty.drm_fb_helper_damage_work.process_one_work
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close.perf_evsel__close_cpu.evlist__close.evlist__delete
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close.perf_evsel__close_cpu.evlist__close
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__close.perf_evsel__close_cpu.evlist__close.evlist__delete.cmd_record
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.proc_pid_cmdline_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.flush_tlb_mm_range.pmdp_invalidate.set_pmd_migration_entry.try_to_migrate_one.rmap_walk_anon
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.pmdp_invalidate.set_pmd_migration_entry.try_to_migrate_one.rmap_walk_anon.try_to_migrate
      0.84 ± 70%      -0.1        0.74 ± 78%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.write_cache.perf_session__do_write_header.__cmd_record
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.get_mm_cmdline.proc_pid_cmdline_read.vfs_read.ksys_read.do_syscall_64
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.dispatch_events
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.process_interval.dispatch_events
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.smp_call_function_many_cond.on_each_cpu_cond_mask.flush_tlb_mm_range.pmdp_invalidate.set_pmd_migration_entry
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.on_each_cpu_cond_mask.flush_tlb_mm_range.pmdp_invalidate.set_pmd_migration_entry.try_to_migrate_one
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.vfs_fstat.__do_sys_newfstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__fxstat64
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.all_vm_events.vmstat_start.seq_read_iter.proc_reg_read_iter.vfs_read
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.machine__delete_threads.perf_session__delete.__cmd_record
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.sysvec_call_function.asm_sysvec_call_function
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close.perf_evsel__close_cpu
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__fput.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close_nocancel
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit.drm_atomic_commit
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail.drm_atomic_helper_commit
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail.commit_tail
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm.ast_mode_config_helper_atomic_commit_tail
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.memcpy_toio.drm_fb_memcpy.ast_primary_plane_helper_atomic_update.drm_atomic_helper_commit_planes.drm_atomic_helper_commit_tail_rpm
      0.48 ± 75%      -0.1        0.39 ± 72%  perf-profile.calltrace.cycles-pp.unmap_vmas.exit_mmap.__mmput.exit_mm.do_exit
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.thread__delete.machine__delete_threads.perf_session__delete.__cmd_record
      0.10 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.read_counters.process_interval.dispatch_events
      0.96 ± 32%      -0.1        0.86 ± 21%  perf-profile.calltrace.cycles-pp.seq_read_iter.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64
      0.96 ± 32%      -0.1        0.86 ± 21%  perf-profile.calltrace.cycles-pp.proc_reg_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__folio_alloc.vma_alloc_folio.shmem_alloc_folio.shmem_alloc_and_acct_folio.shmem_get_folio_gfp
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp._dl_addr
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.shmem_add_to_page_cache.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.__generic_file_write_iter
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.____machine__findnew_thread.machine__process_fork_event.perf_session__deliver_event.__ordered_events__flush.perf_session__process_user_event
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.perf_release.__fput.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.perf_event_release_kernel.perf_release.__fput.task_work_run.exit_to_user_mode_loop
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.copy_page.__collapse_huge_page_copy.collapse_huge_page.hpage_collapse_scan_pmd.khugepaged_scan_mm_slot
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__alloc_pages.__folio_alloc.vma_alloc_folio.shmem_alloc_folio.shmem_alloc_and_acct_folio
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.select_task_rq_fair.wake_up_new_task.kernel_clone.__do_sys_clone.do_syscall_64
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.find_idlest_cpu.select_task_rq_fair.wake_up_new_task.kernel_clone.__do_sys_clone
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.walk_component.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.do_mprotect_pkey.__x64_sys_mprotect.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.rb_next.symbols__fixup_end.__dso__load_kallsyms.dso__load.map__load
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.rb_erase.__dso__load_kallsyms.dso__load.map__load.thread__find_map
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.symbols__fixup_end.__dso__load_kallsyms.dso__load.map__load.thread__find_map
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__set_cpus_allowed_ptr.__sched_setaffinity.sched_setaffinity.__x64_sys_sched_setaffinity.do_syscall_64
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__check_object_size.get_mm_cmdline.proc_pid_cmdline_read.vfs_read.ksys_read
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.__virt_addr_valid.__check_object_size.get_mm_cmdline.proc_pid_cmdline_read
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.__virt_addr_valid.__check_object_size.get_mm_cmdline
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__virt_addr_valid.__check_object_size
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.__virt_addr_valid
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__virt_addr_valid.__check_object_size.get_mm_cmdline.proc_pid_cmdline_read.vfs_read
      0.09 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.diskstats_show.seq_read_iter.proc_reg_read_iter.vfs_read.ksys_read
      0.08 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.move_queued_task.migration_cpu_stop.cpu_stopper_thread.smpboot_thread_fn.kthread
      0.08 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.rb_free.rcu_do_batch.rcu_core.__do_softirq.run_ksoftirqd
      0.08 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.asm_sysvec_irq_work.queue_event.ordered_events__queue.process_simple.reader__read_event
      0.08 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.sysvec_irq_work.asm_sysvec_irq_work.queue_event.ordered_events__queue.process_simple
      0.08 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.queue_event.ordered_events__queue
      0.08 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.irq_work_run.__sysvec_irq_work.sysvec_irq_work.asm_sysvec_irq_work.queue_event
      0.08 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.task_dump_owner.pid_revalidate.lookup_fast.walk_component.link_path_walk
      0.08 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.shmem_get_folio_gfp.shmem_read_mapping_page_gfp.drm_gem_get_pages.drm_gem_shmem_get_pages_locked.drm_gem_shmem_vmap
      0.08 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.filemap_get_entry.shmem_get_folio_gfp.shmem_read_mapping_page_gfp.drm_gem_get_pages.drm_gem_shmem_get_pages_locked
      0.08 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.drm_gem_shmem_get_pages_locked.drm_gem_shmem_vmap.drm_gem_vmap.drm_gem_vmap_unlocked.drm_client_buffer_vmap
      0.08 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.drm_gem_get_pages.drm_gem_shmem_get_pages_locked.drm_gem_shmem_vmap.drm_gem_vmap.drm_gem_vmap_unlocked
      0.08 ±223%      -0.1        0.00        perf-profile.calltrace.cycles-pp.shmem_read_mapping_page_gfp.drm_gem_get_pages.drm_gem_shmem_get_pages_locked.drm_gem_shmem_vmap.drm_gem_vmap
      1.57 ± 30%      -0.1        1.49 ± 12%  perf-profile.calltrace.cycles-pp.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.57 ± 30%      -0.1        1.49 ± 12%  perf-profile.calltrace.cycles-pp.do_exit.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.57 ± 30%      -0.1        1.49 ± 12%  perf-profile.calltrace.cycles-pp.do_group_exit.__x64_sys_exit_group.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.50 ± 80%      -0.1        0.42 ± 74%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.28 ±151%      -0.1        0.20 ±144%  perf-profile.calltrace.cycles-pp.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write.__generic_file_write_iter
      0.70 ± 37%      -0.1        0.63 ± 47%  perf-profile.calltrace.cycles-pp.sched_exec.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.23 ±149%      -0.1        0.18 ±141%  perf-profile.calltrace.cycles-pp.wake_up_new_task.kernel_clone.__x64_sys_vfork.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.84 ± 40%      -0.1        0.79 ± 18%  perf-profile.calltrace.cycles-pp.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newstat
      0.66 ± 37%      -0.1        0.61 ± 47%  perf-profile.calltrace.cycles-pp.select_task_rq_fair.sched_exec.bprm_execve.do_execveat_common.__x64_sys_execve
      2.88 ± 30%      -0.0        2.84 ± 18%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      2.89 ± 30%      -0.0        2.84 ± 18%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.13 ±223%      -0.0        0.09 ±223%  perf-profile.calltrace.cycles-pp.pcpu_alloc.__percpu_counter_init.mm_init.alloc_bprm.do_execveat_common
      0.85 ± 40%      -0.0        0.80 ± 18%  perf-profile.calltrace.cycles-pp.filename_lookup.vfs_statx.vfs_fstatat.__do_sys_newstat.do_syscall_64
      2.98 ± 30%      -0.0        2.94 ± 18%  perf-profile.calltrace.cycles-pp.open64
      0.87 ± 40%      -0.0        0.83 ± 17%  perf-profile.calltrace.cycles-pp.vfs_statx.vfs_fstatat.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.91 ± 30%      -0.0        2.88 ± 18%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
      2.91 ± 30%      -0.0        2.87 ± 18%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
      0.40 ± 77%      -0.0        0.37 ± 71%  perf-profile.calltrace.cycles-pp.show_numa_map.seq_read_iter.seq_read.vfs_read.ksys_read
      0.33 ±107%      -0.0        0.29 ±100%  perf-profile.calltrace.cycles-pp.filemap_map_pages.do_read_fault.do_fault.__handle_mm_fault.handle_mm_fault
      0.12 ±223%      -0.0        0.09 ±223%  perf-profile.calltrace.cycles-pp.step_into.path_lookupat.filename_lookup.vfs_statx.vfs_fstatat
      0.13 ±223%      -0.0        0.09 ±223%  perf-profile.calltrace.cycles-pp.shmem_alloc_folio.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin.generic_perform_write
      0.98 ± 39%      -0.0        0.94 ± 17%  perf-profile.calltrace.cycles-pp.__xstat64
      0.96 ± 39%      -0.0        0.93 ± 17%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__xstat64
      0.12 ±223%      -0.0        0.09 ±223%  perf-profile.calltrace.cycles-pp.pick_link.step_into.path_lookupat.filename_lookup.vfs_statx
      0.12 ±223%      -0.0        0.08 ±223%  perf-profile.calltrace.cycles-pp.walk_p4d_range.walk_pgd_range.__walk_page_range.walk_page_vma.show_numa_map
      0.12 ±223%      -0.0        0.08 ±223%  perf-profile.calltrace.cycles-pp.walk_pud_range.walk_p4d_range.walk_pgd_range.__walk_page_range.walk_page_vma
      0.95 ± 40%      -0.0        0.92 ± 17%  perf-profile.calltrace.cycles-pp.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      0.96 ± 39%      -0.0        0.92 ± 17%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      0.12 ±223%      -0.0        0.08 ±223%  perf-profile.calltrace.cycles-pp.walk_pmd_range.walk_pud_range.walk_p4d_range.walk_pgd_range.__walk_page_range
      0.93 ± 39%      -0.0        0.91 ± 17%  perf-profile.calltrace.cycles-pp.vfs_fstatat.__do_sys_newstat.do_syscall_64.entry_SYSCALL_64_after_hwframe.__xstat64
      0.11 ±223%      -0.0        0.09 ±223%  perf-profile.calltrace.cycles-pp.vma_alloc_folio.shmem_alloc_folio.shmem_alloc_and_acct_folio.shmem_get_folio_gfp.shmem_write_begin
      0.12 ±223%      -0.0        0.10 ±223%  perf-profile.calltrace.cycles-pp.wp_page_copy.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.39 ±114%      -0.0        0.37 ±103%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.fault_in_readable
      0.24 ±143%      -0.0        0.22 ±141%  perf-profile.calltrace.cycles-pp.khugepaged.kthread.ret_from_fork
      0.22 ±144%      -0.0        0.20 ±141%  perf-profile.calltrace.cycles-pp.collapse_huge_page.hpage_collapse_scan_pmd.khugepaged_scan_mm_slot.khugepaged.kthread
      1.58 ± 57%      -0.0        1.56 ± 59%  perf-profile.calltrace.cycles-pp.fault_in_iov_iter_readable.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.vfs_write
      0.23 ±144%      -0.0        0.21 ±141%  perf-profile.calltrace.cycles-pp.hpage_collapse_scan_pmd.khugepaged_scan_mm_slot.khugepaged.kthread.ret_from_fork
      0.23 ±144%      -0.0        0.21 ±141%  perf-profile.calltrace.cycles-pp.khugepaged_scan_mm_slot.khugepaged.kthread.ret_from_fork
      0.45 ± 75%      +0.0        0.45 ± 71%  perf-profile.calltrace.cycles-pp.lookup_fast.open_last_lookups.path_openat.do_filp_open.do_sys_openat2
      5.79 ± 27%      +0.0        5.80 ± 15%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.47 ± 75%      +0.0        0.47 ± 71%  perf-profile.calltrace.cycles-pp.open_last_lookups.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.64 ± 48%      +0.0        0.65 ±  7%  perf-profile.calltrace.cycles-pp.evlist_cpu_iterator__next.read_counters.process_interval.dispatch_events.cmd_stat
      5.74 ± 27%      +0.0        5.75 ± 15%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.68 ± 58%      +0.0        0.69 ± 47%  perf-profile.calltrace.cycles-pp.kernel_clone.__x64_sys_vfork.do_syscall_64.entry_SYSCALL_64_after_hwframe.__vfork
      0.68 ± 58%      +0.0        0.69 ± 47%  perf-profile.calltrace.cycles-pp.__x64_sys_vfork.do_syscall_64.entry_SYSCALL_64_after_hwframe.__vfork
      1.45 ± 57%      +0.0        1.47 ± 60%  perf-profile.calltrace.cycles-pp.fault_in_readable.fault_in_iov_iter_readable.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.57 ± 59%      +0.0        0.60 ± 47%  perf-profile.calltrace.cycles-pp.find_idlest_cpu.select_task_rq_fair.sched_exec.bprm_execve.do_execveat_common
      0.50 ± 77%      +0.0        0.53 ± 44%  perf-profile.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      0.08 ±223%      +0.0        0.12 ±223%  perf-profile.calltrace.cycles-pp.schedule.smpboot_thread_fn.kthread.ret_from_fork
      0.50 ± 77%      +0.0        0.54 ± 44%  perf-profile.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      0.09 ±223%      +0.0        0.13 ±223%  perf-profile.calltrace.cycles-pp.__percpu_counter_sum.__mmdrop.finish_task_switch.__schedule.schedule
      0.49 ± 77%      +0.0        0.53 ± 44%  perf-profile.calltrace.cycles-pp.proc_pid_readdir.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.50 ± 77%      +0.0        0.54 ± 45%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getdents64
      0.50 ± 77%      +0.0        0.54 ± 45%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents64
      0.50 ± 77%      +0.0        0.54 ± 45%  perf-profile.calltrace.cycles-pp.getdents64
      0.91 ± 34%      +0.0        0.95 ± 13%  perf-profile.calltrace.cycles-pp.do_open.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.55 ± 58%      +0.0        0.60 ± 47%  perf-profile.calltrace.cycles-pp.find_idlest_group.find_idlest_cpu.select_task_rq_fair.sched_exec.bprm_execve
      3.33 ± 32%      +0.0        3.38 ± 13%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.78 ± 39%      +0.0        0.83 ± 20%  perf-profile.calltrace.cycles-pp.__vfork
      0.12 ±223%      +0.1        0.17 ±141%  perf-profile.calltrace.cycles-pp.walk_page_vma.show_numa_map.seq_read_iter.seq_read.vfs_read
      0.12 ±223%      +0.1        0.17 ±141%  perf-profile.calltrace.cycles-pp.__walk_page_range.walk_page_vma.show_numa_map.seq_read_iter.seq_read
      0.12 ±223%      +0.1        0.17 ±141%  perf-profile.calltrace.cycles-pp.walk_pgd_range.__walk_page_range.walk_page_vma.show_numa_map.seq_read_iter
      3.32 ± 32%      +0.1        3.38 ± 13%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.12 ±223%      +0.1        0.17 ±141%  perf-profile.calltrace.cycles-pp.exit_mmap.__mmput.exec_mmap.begin_new_exec.load_elf_binary
      0.12 ±223%      +0.1        0.17 ±141%  perf-profile.calltrace.cycles-pp.__mmput.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler
      0.13 ±223%      +0.1        0.18 ±141%  perf-profile.calltrace.cycles-pp.mmap_region.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64
      7.93 ± 55%      +0.1        7.99 ± 51%  perf-profile.calltrace.cycles-pp.__libc_start_main
      7.92 ± 55%      +0.1        7.98 ± 51%  perf-profile.calltrace.cycles-pp.main.__libc_start_main
      7.92 ± 55%      +0.1        7.98 ± 51%  perf-profile.calltrace.cycles-pp.run_builtin.main.__libc_start_main
      3.54 ± 26%      +0.1        3.60 ± 15%  perf-profile.calltrace.cycles-pp.seq_read_iter.seq_read.vfs_read.ksys_read.do_syscall_64
      0.15 ±223%      +0.1        0.22 ±146%  perf-profile.calltrace.cycles-pp.shmem_write_end.generic_perform_write.__generic_file_write_iter.generic_file_write_iter.vfs_write
      5.95 ± 27%      +0.1        6.02 ± 15%  perf-profile.calltrace.cycles-pp.read
      3.55 ± 26%      +0.1        3.62 ± 15%  perf-profile.calltrace.cycles-pp.seq_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.08 ±223%  perf-profile.calltrace.cycles-pp.copy_mc_enhanced_fast_string.__collapse_huge_page_copy.collapse_huge_page.hpage_collapse_scan_pmd.khugepaged_scan_mm_slot
      5.87 ± 27%      +0.1        5.95 ± 16%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      0.00            +0.1        0.08 ±223%  perf-profile.calltrace.cycles-pp.mm_init.dup_mm.copy_process.kernel_clone.__do_sys_clone
      5.85 ± 27%      +0.1        5.94 ± 16%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.00            +0.1        0.09 ±223%  perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.pipe_read
      0.00            +0.1        0.09 ±223%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.pipe_read.vfs_read
      0.00            +0.1        0.09 ±223%  perf-profile.calltrace.cycles-pp.show_stat.seq_read_iter.vfs_read.ksys_read.do_syscall_64
      0.00            +0.1        0.09 ±223%  perf-profile.calltrace.cycles-pp.__schedule.schedule.pipe_read.vfs_read.ksys_read
      0.00            +0.1        0.09 ±223%  perf-profile.calltrace.cycles-pp.schedule.pipe_read.vfs_read.ksys_read.do_syscall_64
      0.00            +0.1        0.09 ±223%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.find_busiest_group.load_balance.rebalance_domains
      0.00            +0.1        0.09 ±223%  perf-profile.calltrace.cycles-pp.__memset.pcpu_alloc.__percpu_counter_init.mm_init.alloc_bprm
      2.63 ± 26%      +0.1        2.72 ± 15%  perf-profile.calltrace.cycles-pp.proc_single_show.seq_read_iter.seq_read.vfs_read.ksys_read
      2.61 ± 27%      +0.1        2.70 ± 15%  perf-profile.calltrace.cycles-pp.do_task_stat.proc_single_show.seq_read_iter.seq_read.vfs_read
      0.00            +0.1        0.10 ±223%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__x64_sys_vfork.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.10 ±223%  perf-profile.calltrace.cycles-pp.perf_mux_hrtimer_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +0.1        0.10 ±223%  perf-profile.calltrace.cycles-pp.pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.68 ± 59%      +0.1        0.78 ± 22%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__vfork
      0.68 ± 59%      +0.1        0.78 ± 22%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__vfork
      0.09 ±223%      +0.1        0.20 ±141%  perf-profile.calltrace.cycles-pp.do_anonymous_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      0.00            +0.1        0.11 ±223%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.rebalance_domains.__do_softirq
      0.63 ± 55%      +0.1        0.74 ± 12%  perf-profile.calltrace.cycles-pp.do_dentry_open.do_open.path_openat.do_filp_open.do_sys_openat2
      0.00            +0.1        0.11 ±223%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.rebalance_domains.__do_softirq.__irq_exit_rcu
      1.12 ± 36%      +0.1        1.23 ± 19%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__libc_fork
      1.12 ± 36%      +0.1        1.23 ± 19%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      1.12 ± 36%      +0.1        1.23 ± 19%  perf-profile.calltrace.cycles-pp.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      1.12 ± 36%      +0.1        1.23 ± 19%  perf-profile.calltrace.cycles-pp.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe.__libc_fork
      0.00            +0.1        0.11 ±223%  perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.worker_thread
      0.00            +0.1        0.11 ±223%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.worker_thread.kthread
      0.00            +0.1        0.12 ±223%  perf-profile.calltrace.cycles-pp.__schedule.schedule.smpboot_thread_fn.kthread.ret_from_fork
      0.80 ± 36%      +0.1        0.92 ± 17%  perf-profile.calltrace.cycles-pp.copy_process.kernel_clone.__do_sys_clone.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.12 ±223%  perf-profile.calltrace.cycles-pp.update_process_times.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt
      0.00            +0.1        0.12 ±223%  perf-profile.calltrace.cycles-pp.task_mm_cid_work.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode
      0.00            +0.1        0.12 ±223%  perf-profile.calltrace.cycles-pp.__schedule.schedule.worker_thread.kthread.ret_from_fork
      0.00            +0.1        0.12 ±223%  perf-profile.calltrace.cycles-pp.schedule.worker_thread.kthread.ret_from_fork
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.__pthread_disable_asynccancel.writen.record__pushfn.perf_mmap__push.record__mmap_read_evlist
      0.46 ± 80%      +0.1        0.59 ± 47%  perf-profile.calltrace.cycles-pp.update_sg_wakeup_stats.find_idlest_group.find_idlest_cpu.select_task_rq_fair.sched_exec
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.tick_sched_handle.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt
      0.00            +0.1        0.13 ±223%  perf-profile.calltrace.cycles-pp.__mmdrop.finish_task_switch.__schedule.schedule.do_wait
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.finish_task_switch.__schedule.schedule.do_wait.kernel_wait4
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.load_balance.rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt
      0.14 ±223%      +0.1        0.28 ±100%  perf-profile.calltrace.cycles-pp.do_mmap.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.14 ±223%      +0.1        0.28 ±100%  perf-profile.calltrace.cycles-pp.vm_mmap_pgoff.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.14 ±223%      +0.1        0.28 ±101%  perf-profile.calltrace.cycles-pp.ksys_mmap_pgoff.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.1        0.14 ±223%  perf-profile.calltrace.cycles-pp.task_work_run.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      3.77 ± 23%      +0.1        3.91 ± 35%  perf-profile.calltrace.cycles-pp.ret_from_fork
      3.77 ± 23%      +0.1        3.91 ± 35%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      0.00            +0.1        0.15 ±223%  perf-profile.calltrace.cycles-pp.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2.__x64_sys_openat
      0.00            +0.1        0.15 ±223%  perf-profile.calltrace.cycles-pp.__alloc_file.alloc_empty_file.path_openat.do_filp_open.do_sys_openat2
      0.00            +0.1        0.15 ±223%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.00            +0.2        0.15 ±223%  perf-profile.calltrace.cycles-pp.__schedule.schedule.do_wait.kernel_wait4.do_syscall_64
      0.00            +0.2        0.15 ±223%  perf-profile.calltrace.cycles-pp.schedule.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.2        0.16 ±223%  perf-profile.calltrace.cycles-pp.tick_sched_timer.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.14 ±223%      +0.2        0.30 ±146%  perf-profile.calltrace.cycles-pp.ring_buffer_read_head.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist.__cmd_record
      0.14 ±223%      +0.2        0.30 ±146%  perf-profile.calltrace.cycles-pp.perf_mmap__read_head.perf_mmap__push.record__mmap_read_evlist.__cmd_record.cmd_record
      0.11 ±223%      +0.2        0.28 ±223%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.2        0.17 ±141%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_commit.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work
      0.00            +0.2        0.17 ±223%  perf-profile.calltrace.cycles-pp.rebalance_domains.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.2        0.17 ±141%  perf-profile.calltrace.cycles-pp.drm_atomic_commit.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work
      0.00            +0.2        0.17 ±223%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init
      0.56 ± 61%      +0.2        0.74 ± 18%  perf-profile.calltrace.cycles-pp.dup_mm.copy_process.kernel_clone.__do_sys_clone.do_syscall_64
      0.00            +0.2        0.18 ±223%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init
      0.00            +0.2        0.19 ±141%  perf-profile.calltrace.cycles-pp.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.2        0.19 ±223%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations
      0.00            +0.2        0.19 ±223%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.arch_call_rest_init.start_kernel
      0.00            +0.2        0.19 ±223%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +0.2        0.19 ±223%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +0.2        0.19 ±223%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +0.2        0.19 ±223%  perf-profile.calltrace.cycles-pp.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.secondary_startup_64_no_verify
      0.00            +0.2        0.19 ±223%  perf-profile.calltrace.cycles-pp.rest_init.arch_call_rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
      0.00            +0.2        0.19 ±141%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      1.18 ± 36%      +0.2        1.37 ± 19%  perf-profile.calltrace.cycles-pp.__libc_fork
      0.66 ± 28%      +0.2        0.90 ± 25%  perf-profile.calltrace.cycles-pp.exec_mmap.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm
      0.32 ±107%      +0.3        0.58 ± 13%  perf-profile.calltrace.cycles-pp.do_sys_openat2.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.32 ±108%      +0.3        0.58 ± 14%  perf-profile.calltrace.cycles-pp.__x64_sys_openat.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.3        0.26 ±100%  perf-profile.calltrace.cycles-pp.drm_atomic_helper_dirtyfb.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread
      0.00            +0.3        0.27 ±148%  perf-profile.calltrace.cycles-pp.do_wait.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.74 ± 30%      +0.3        1.01 ± 24%  perf-profile.calltrace.cycles-pp.begin_new_exec.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve
      0.62 ± 59%      +0.3        0.91 ± 24%  perf-profile.calltrace.cycles-pp.mm_init.alloc_bprm.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.55 ± 84%      +0.3        0.84 ± 48%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.55 ± 84%      +0.3        0.84 ± 48%  perf-profile.calltrace.cycles-pp.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      1.65 ± 33%      +0.3        1.95 ± 22%  perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      1.65 ± 34%      +0.3        1.96 ± 22%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      1.64 ± 33%      +0.3        1.94 ± 22%  perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
      0.67 ± 59%      +0.3        0.97 ± 24%  perf-profile.calltrace.cycles-pp.alloc_bprm.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.3        0.30 ±223%  perf-profile.calltrace.cycles-pp.__do_softirq.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +0.3        0.32 ±223%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.00            +0.3        0.32 ±151%  perf-profile.calltrace.cycles-pp.queue_event
      0.00            +0.3        0.33 ±223%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      0.00            +0.3        0.34 ±223%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      0.09 ±223%      +0.3        0.43 ±110%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.09 ±223%      +0.3        0.43 ±109%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.wait4
      0.09 ±223%      +0.3        0.43 ±110%  perf-profile.calltrace.cycles-pp.wait4
      2.44 ± 35%      +0.3        2.78 ± 21%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +0.3        0.34 ±223%  perf-profile.calltrace.cycles-pp.intel_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +0.4        0.36 ±110%  perf-profile.calltrace.cycles-pp.kernel_wait4.do_syscall_64.entry_SYSCALL_64_after_hwframe.wait4
      0.09 ±223%      +0.4        0.48 ±223%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance
      0.09 ±223%      +0.4        0.49 ±223%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair.__schedule
      0.09 ±223%      +0.4        0.49 ±223%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair
      0.30 ±146%      +0.4        0.75 ± 48%  perf-profile.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.irqentry_exit_to_user_mode.asm_sysvec_apic_timer_interrupt
      0.00            +0.4        0.45 ±223%  perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.schedule_timeout
      0.00            +0.4        0.45 ±223%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_timeout.rcu_gp_fqs_loop
      0.00            +0.5        0.46 ±223%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread
      0.00            +0.5        0.46 ±223%  perf-profile.calltrace.cycles-pp.schedule.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread
      0.00            +0.5        0.46 ±223%  perf-profile.calltrace.cycles-pp.schedule_timeout.rcu_gp_fqs_loop.rcu_gp_kthread.kthread.ret_from_fork
      0.00            +0.5        0.48 ±100%  perf-profile.calltrace.cycles-pp.evsel__read_counter.read_counters.process_interval.dispatch_events.cmd_stat
      0.00            +0.5        0.49 ±223%  perf-profile.calltrace.cycles-pp.rcu_gp_fqs_loop.rcu_gp_kthread.kthread.ret_from_fork
      0.11 ±223%      +0.5        0.64 ±223%  perf-profile.calltrace.cycles-pp.load_balance.newidle_balance.pick_next_task_fair.__schedule.schedule
      0.00            +0.5        0.54 ±223%  perf-profile.calltrace.cycles-pp.rcu_gp_kthread.kthread.ret_from_fork
      3.57 ± 36%      +0.5        4.11 ± 22%  perf-profile.calltrace.cycles-pp.execve
      3.55 ± 36%      +0.5        4.10 ± 22%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      3.56 ± 36%      +0.6        4.11 ± 22%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      3.56 ± 36%      +0.6        4.11 ± 22%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      3.56 ± 35%      +0.6        4.11 ± 22%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.00            +0.6        0.57 ±223%  perf-profile.calltrace.cycles-pp.intel_idle_xstate.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.25 ±223%      +0.6        0.84 ±106%  perf-profile.calltrace.cycles-pp.read_counters.process_interval.dispatch_events.cmd_stat.run_builtin
      0.27 ±223%      +0.6        0.89 ±107%  perf-profile.calltrace.cycles-pp.process_interval.dispatch_events.cmd_stat.run_builtin.main
      0.27 ±223%      +0.6        0.90 ±107%  perf-profile.calltrace.cycles-pp.cmd_stat.run_builtin.main.__libc_start_main
      0.27 ±223%      +0.6        0.90 ±107%  perf-profile.calltrace.cycles-pp.dispatch_events.cmd_stat.run_builtin.main.__libc_start_main
      0.00            +0.6        0.63 ± 14%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.queue_event.ordered_events__queue.process_simple.reader__read_event
      0.00            +0.8        0.80 ±223%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.00            +1.0        0.98 ±223%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00            +1.1        1.08 ± 15%  perf-profile.calltrace.cycles-pp.drm_fbdev_generic_helper_fb_dirty.drm_fb_helper_damage_work.process_one_work.worker_thread.kthread
      0.10 ±223%      +1.8        1.93 ±209%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      0.10 ±223%      +1.9        2.00 ±210%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.00            +2.0        2.02 ± 57%  perf-profile.calltrace.cycles-pp.copyin.copy_page_from_iter_atomic.generic_perform_write.__generic_file_write_iter.generic_file_write_iter
      0.11 ±223%      +2.1        2.21 ±198%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.15 ±223%      +2.2        2.37 ±191%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.15 ±223%      +2.2        2.37 ±191%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.15 ±223%      +2.2        2.37 ±191%  perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
      0.16 ±223%      +2.5        2.63 ±188%  perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
     45.48 ± 45%      +6.5       51.98 ±  8%  perf-profile.calltrace.cycles-pp.__cmd_record
     45.08 ± 45%      +6.9       51.98 ±  8%  perf-profile.calltrace.cycles-pp.record__finish_output.__cmd_record
     45.07 ± 45%      +6.9       51.98 ±  8%  perf-profile.calltrace.cycles-pp.perf_session__process_events.record__finish_output.__cmd_record
     44.86 ± 45%      +7.1       51.95 ±  8%  perf-profile.calltrace.cycles-pp.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
     39.39 ± 47%     +11.2       50.61 ± 10%  perf-profile.calltrace.cycles-pp.process_simple.reader__read_event.perf_session__process_events.record__finish_output.__cmd_record
     38.05 ± 48%     +11.6       49.63 ± 11%  perf-profile.calltrace.cycles-pp.queue_event.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events
     38.22 ± 48%     +11.6       49.86 ± 11%  perf-profile.calltrace.cycles-pp.ordered_events__queue.process_simple.reader__read_event.perf_session__process_events.record__finish_output
     14.24 ± 54%      -8.8        5.45 ± 40%  perf-profile.children.cycles-pp.asm_exc_page_fault
     13.84 ± 55%      -8.8        5.07 ± 42%  perf-profile.children.cycles-pp.do_user_addr_fault
     13.89 ± 55%      -8.8        5.14 ± 42%  perf-profile.children.cycles-pp.exc_page_fault
     13.27 ± 56%      -8.7        4.62 ± 47%  perf-profile.children.cycles-pp.handle_mm_fault
     12.85 ± 57%      -8.5        4.32 ± 51%  perf-profile.children.cycles-pp.__handle_mm_fault
      9.37 ± 68%      -8.2        1.21 ±161%  perf-profile.children.cycles-pp.do_huge_pmd_numa_page
      9.28 ± 68%      -8.1        1.18 ±159%  perf-profile.children.cycles-pp.migrate_misplaced_page
      9.27 ± 68%      -8.1        1.17 ±159%  perf-profile.children.cycles-pp.migrate_pages
      9.26 ± 68%      -8.1        1.17 ±159%  perf-profile.children.cycles-pp.migrate_pages_batch
      9.01 ± 66%      -7.8        1.18 ±147%  perf-profile.children.cycles-pp.copy_page
      8.65 ± 68%      -7.6        1.07 ±160%  perf-profile.children.cycles-pp.move_to_new_folio
      8.65 ± 68%      -7.6        1.07 ±160%  perf-profile.children.cycles-pp.migrate_folio_extra
      8.63 ± 68%      -7.6        1.07 ±160%  perf-profile.children.cycles-pp.folio_copy
      4.81 ±112%      -3.9        0.88 ±223%  perf-profile.children.cycles-pp.__ordered_events__flush
      4.67 ±111%      -3.8        0.88 ±223%  perf-profile.children.cycles-pp.perf_session__process_user_event
      4.11 ±113%      -3.4        0.71 ±223%  perf-profile.children.cycles-pp.perf_session__deliver_event
      2.40 ± 50%      -2.4        0.00        perf-profile.children.cycles-pp.copy_user_enhanced_fast_string
      2.81 ±110%      -2.3        0.55 ±223%  perf-profile.children.cycles-pp.evlist__parse_sample
      1.40 ± 28%      -1.4        0.00        perf-profile.children.cycles-pp.drm_fbdev_fb_dirty
      1.02 ±130%      -0.9        0.14 ±223%  perf-profile.children.cycles-pp.build_id__mark_dso_hit
      0.92 ±109%      -0.8        0.12 ±223%  perf-profile.children.cycles-pp.evsel__parse_sample
     30.39 ± 33%      -0.8       29.60 ± 15%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     30.33 ± 33%      -0.8       29.56 ± 15%  perf-profile.children.cycles-pp.do_syscall_64
      7.81 ± 54%      -0.7        7.09 ± 57%  perf-profile.children.cycles-pp.cmd_record
      0.55 ± 34%      -0.6        0.00        perf-profile.children.cycles-pp.memcpy_erms
      0.51 ±191%      -0.5        0.01 ±223%  perf-profile.children.cycles-pp.thread__find_map
      1.90 ± 23%      -0.5        1.41 ± 13%  perf-profile.children.cycles-pp.process_one_work
      0.49 ± 34%      -0.5        0.00        perf-profile.children.cycles-pp.drm_gem_shmem_vmap
      0.44 ± 43%      -0.4        0.00        perf-profile.children.cycles-pp.memset_erms
      0.43 ±223%      -0.4        0.00        perf-profile.children.cycles-pp.map__load
      0.43 ±223%      -0.4        0.00        perf-profile.children.cycles-pp.dso__load
      0.43 ±223%      -0.4        0.00        perf-profile.children.cycles-pp.__dso__load_kallsyms
      1.06 ± 28%      -0.4        0.64 ± 31%  perf-profile.children.cycles-pp.do_sys_poll
      1.06 ± 28%      -0.4        0.65 ± 31%  perf-profile.children.cycles-pp.__x64_sys_poll
      5.43 ± 56%      -0.4        5.02 ± 58%  perf-profile.children.cycles-pp.__generic_file_write_iter
      5.38 ± 56%      -0.4        4.98 ± 58%  perf-profile.children.cycles-pp.generic_perform_write
      5.46 ± 56%      -0.4        5.05 ± 58%  perf-profile.children.cycles-pp.generic_file_write_iter
      0.53 ± 49%      -0.4        0.13 ± 79%  perf-profile.children.cycles-pp.smp_call_function_many_cond
      0.47 ± 56%      -0.4        0.08 ±138%  perf-profile.children.cycles-pp.on_each_cpu_cond_mask
      1.07 ± 28%      -0.4        0.68 ± 30%  perf-profile.children.cycles-pp.__poll
      5.73 ± 55%      -0.4        5.34 ± 56%  perf-profile.children.cycles-pp.vfs_write
      5.79 ± 55%      -0.4        5.40 ± 56%  perf-profile.children.cycles-pp.ksys_write
      0.50 ±128%      -0.4        0.13 ±223%  perf-profile.children.cycles-pp.machine__findnew_thread
      5.64 ± 56%      -0.4        5.27 ± 58%  perf-profile.children.cycles-pp.__libc_write
      1.94 ± 23%      -0.4        1.58 ± 21%  perf-profile.children.cycles-pp.worker_thread
      0.50 ± 59%      -0.3        0.15 ± 82%  perf-profile.children.cycles-pp.flush_tlb_mm_range
      0.34 ± 42%      -0.3        0.00        perf-profile.children.cycles-pp.drm_fbdev_damage_blit_real
      0.39 ± 77%      -0.3        0.06 ±223%  perf-profile.children.cycles-pp.migrate_folio_unmap
      0.41 ± 55%      -0.3        0.08 ±106%  perf-profile.children.cycles-pp.asm_sysvec_call_function
      0.83 ± 27%      -0.3        0.52 ± 31%  perf-profile.children.cycles-pp.do_poll
      1.40 ± 28%      -0.3        1.08 ± 15%  perf-profile.children.cycles-pp.drm_fb_helper_damage_work
      0.36 ± 74%      -0.3        0.06 ±189%  perf-profile.children.cycles-pp.rmap_walk_anon
      0.34 ± 74%      -0.3        0.05 ±223%  perf-profile.children.cycles-pp.try_to_migrate
      0.66 ± 26%      -0.3        0.37 ± 11%  perf-profile.children.cycles-pp.__fxstat64
      1.43 ± 53%      -0.3        1.14 ± 41%  perf-profile.children.cycles-pp.shmem_get_folio_gfp
      0.34 ± 74%      -0.3        0.05 ±223%  perf-profile.children.cycles-pp.try_to_migrate_one
      0.57 ± 24%      -0.3        0.30 ± 11%  perf-profile.children.cycles-pp.__do_sys_newfstat
      1.42 ± 31%      -0.3        1.15 ± 12%  perf-profile.children.cycles-pp.link_path_walk
      0.71 ±119%      -0.3        0.45 ± 67%  perf-profile.children.cycles-pp.evlist__parse_sample_timestamp
      5.78 ± 58%      -0.3        5.52 ± 61%  perf-profile.children.cycles-pp.writen
      0.29 ± 70%      -0.3        0.04 ±223%  perf-profile.children.cycles-pp.set_pmd_migration_entry
      0.24 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.kallsyms__parse
      0.31 ± 60%      -0.2        0.06 ±107%  perf-profile.children.cycles-pp.sysvec_call_function
      0.28 ± 69%      -0.2        0.04 ±223%  perf-profile.children.cycles-pp.pmdp_invalidate
      0.63 ± 28%      -0.2        0.39 ± 36%  perf-profile.children.cycles-pp.perf_poll
      0.24 ±148%      -0.2        0.00        perf-profile.children.cycles-pp.rb_erase
      5.88 ± 57%      -0.2        5.65 ± 61%  perf-profile.children.cycles-pp.record__pushfn
      1.71 ± 31%      -0.2        1.48 ± 15%  perf-profile.children.cycles-pp.lookup_fast
      5.27 ± 26%      -0.2        5.05 ± 17%  perf-profile.children.cycles-pp.seq_read_iter
      0.24 ± 93%      -0.2        0.02 ±223%  perf-profile.children.cycles-pp.migration_entry_wait_on_locked
      0.22 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.evlist__delete
      0.24 ± 94%      -0.2        0.02 ±223%  perf-profile.children.cycles-pp.io_schedule
      0.22 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.perf_session__delete
      3.71 ± 30%      -0.2        3.49 ± 15%  perf-profile.children.cycles-pp.do_filp_open
      3.69 ± 30%      -0.2        3.48 ± 15%  perf-profile.children.cycles-pp.path_openat
      1.08 ± 63%      -0.2        0.86 ± 62%  perf-profile.children.cycles-pp.shmem_write_begin
      1.18 ± 32%      -0.2        0.97 ±  7%  perf-profile.children.cycles-pp.sched_setaffinity
      1.35 ± 32%      -0.2        1.14 ± 18%  perf-profile.children.cycles-pp.do_read_fault
      3.89 ± 30%      -0.2        3.69 ± 15%  perf-profile.children.cycles-pp.do_sys_openat2
      3.90 ± 31%      -0.2        3.70 ± 15%  perf-profile.children.cycles-pp.__x64_sys_openat
      1.28 ± 32%      -0.2        1.08 ± 13%  perf-profile.children.cycles-pp.walk_component
      1.58 ± 33%      -0.2        1.38 ± 18%  perf-profile.children.cycles-pp.do_fault
      0.54 ± 56%      -0.2        0.35 ± 21%  perf-profile.children.cycles-pp.__fput
      0.19 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.__open64
      0.64 ± 46%      -0.2        0.45 ± 23%  perf-profile.children.cycles-pp._raw_spin_lock
      1.67 ± 28%      -0.2        1.49 ± 19%  perf-profile.children.cycles-pp.__mmput
      1.66 ± 29%      -0.2        1.48 ± 19%  perf-profile.children.cycles-pp.exit_mmap
      0.24 ± 57%      -0.2        0.06 ±106%  perf-profile.children.cycles-pp.__sysvec_call_function
      0.72 ± 25%      -0.2        0.54 ± 12%  perf-profile.children.cycles-pp.serial8250_console_write
      0.72 ± 26%      -0.2        0.54 ± 12%  perf-profile.children.cycles-pp.console_unlock
      0.72 ± 26%      -0.2        0.54 ± 12%  perf-profile.children.cycles-pp.console_flush_all
      0.44 ± 25%      -0.2        0.26 ± 14%  perf-profile.children.cycles-pp.vfs_fstat
      0.24 ± 54%      -0.2        0.06 ±104%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      2.24 ± 53%      -0.2        2.06 ± 58%  perf-profile.children.cycles-pp.copy_page_from_iter_atomic
      6.39 ± 27%      -0.2        6.22 ± 15%  perf-profile.children.cycles-pp.vfs_read
      0.73 ± 25%      -0.2        0.56 ± 12%  perf-profile.children.cycles-pp.vprintk_emit
      0.94 ± 27%      -0.2        0.77 ± 20%  perf-profile.children.cycles-pp.unmap_vmas
      0.72 ± 24%      -0.2        0.56 ± 12%  perf-profile.children.cycles-pp.irq_work_run_list
      0.72 ± 24%      -0.2        0.56 ± 12%  perf-profile.children.cycles-pp.irq_work_single
      0.72 ± 23%      -0.2        0.56 ± 12%  perf-profile.children.cycles-pp.sysvec_irq_work
      0.72 ± 23%      -0.2        0.56 ± 12%  perf-profile.children.cycles-pp.__sysvec_irq_work
      0.72 ± 23%      -0.2        0.56 ± 12%  perf-profile.children.cycles-pp.irq_work_run
      0.72 ± 23%      -0.2        0.56 ± 12%  perf-profile.children.cycles-pp._printk
      0.72 ± 23%      -0.2        0.56 ± 12%  perf-profile.children.cycles-pp.asm_sysvec_irq_work
      0.85 ± 29%      -0.2        0.68 ± 21%  perf-profile.children.cycles-pp.unmap_page_range
      0.70 ± 40%      -0.2        0.54 ± 22%  perf-profile.children.cycles-pp.__libc_read
      0.81 ± 30%      -0.2        0.65 ± 20%  perf-profile.children.cycles-pp.zap_pte_range
      0.82 ± 30%      -0.2        0.66 ± 21%  perf-profile.children.cycles-pp.zap_pmd_range
      0.16 ±223%      -0.2        0.00        perf-profile.children.cycles-pp.evlist__close
      0.93 ± 22%      -0.2        0.78 ± 19%  perf-profile.children.cycles-pp.filemap_map_pages
      0.18 ± 92%      -0.2        0.03 ±223%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      6.51 ± 27%      -0.2        6.36 ± 16%  perf-profile.children.cycles-pp.ksys_read
      0.16 ± 39%      -0.1        0.01 ±223%  perf-profile.children.cycles-pp.security_inode_getattr
      0.22 ±149%      -0.1        0.07 ± 49%  perf-profile.children.cycles-pp.__close
      0.15 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.io__get_hex
      1.24 ± 30%      -0.1        1.09 ± 20%  perf-profile.children.cycles-pp.exit_mm
      0.22 ± 66%      -0.1        0.08 ± 87%  perf-profile.children.cycles-pp.task_numa_work
      0.20 ± 79%      -0.1        0.06 ± 88%  perf-profile.children.cycles-pp.change_prot_numa
      0.14 ± 27%      -0.1        0.00        perf-profile.children.cycles-pp.__mem_cgroup_flush_stats
      0.14 ± 27%      -0.1        0.00        perf-profile.children.cycles-pp.cgroup_rstat_flush_irqsafe
      0.66 ± 22%      -0.1        0.52 ± 23%  perf-profile.children.cycles-pp.next_uptodate_page
      1.09 ± 35%      -0.1        0.95 ± 16%  perf-profile.children.cycles-pp.path_lookupat
      0.21 ± 48%      -0.1        0.07 ± 34%  perf-profile.children.cycles-pp.free_unref_page
      1.09 ± 35%      -0.1        0.95 ± 17%  perf-profile.children.cycles-pp.__xstat64
      0.50 ± 48%      -0.1        0.36 ± 27%  perf-profile.children.cycles-pp.tlb_finish_mmu
      1.10 ± 35%      -0.1        0.96 ± 15%  perf-profile.children.cycles-pp.filename_lookup
      6.66 ± 58%      -0.1        6.52 ± 62%  perf-profile.children.cycles-pp.record__mmap_read_evlist
      1.11 ± 36%      -0.1        0.98 ± 16%  perf-profile.children.cycles-pp.__do_sys_newstat
      1.01 ± 37%      -0.1        0.88 ± 16%  perf-profile.children.cycles-pp.vfs_statx
      0.13 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.perf_session__do_write_header
      0.13 ±190%      -0.1        0.00        perf-profile.children.cycles-pp.machine__process_fork_event
      6.37 ± 58%      -0.1        6.24 ± 62%  perf-profile.children.cycles-pp.perf_mmap__push
      0.88 ± 38%      -0.1        0.76 ± 24%  perf-profile.children.cycles-pp.__percpu_counter_init
      0.80 ± 30%      -0.1        0.68 ±  6%  perf-profile.children.cycles-pp.evlist_cpu_iterator__next
      0.30 ±109%      -0.1        0.18 ± 59%  perf-profile.children.cycles-pp.evsel__parse_sample_timestamp
      0.12 ± 44%      -0.1        0.00        perf-profile.children.cycles-pp.common_perm_cond
      0.48 ± 44%      -0.1        0.36 ± 25%  perf-profile.children.cycles-pp.perf_evsel__read
      0.12 ± 20%      -0.1        0.00        perf-profile.children.cycles-pp.update_rq_clock
      0.49 ± 34%      -0.1        0.37 ± 29%  perf-profile.children.cycles-pp.drm_gem_vmap_unlocked
      0.49 ± 34%      -0.1        0.37 ± 29%  perf-profile.children.cycles-pp.drm_gem_vmap
      0.12 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.perf_evsel__close_cpu
      1.09 ± 35%      -0.1        0.97 ± 16%  perf-profile.children.cycles-pp.vfs_fstatat
      1.30 ± 33%      -0.1        1.18 ±  9%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.12 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.machine__exit
      0.12 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.proc_reg_read
      0.12 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.dso__delete
      0.58 ± 27%      -0.1        0.47 ± 14%  perf-profile.children.cycles-pp.drm_atomic_helper_dirtyfb
      0.13 ± 40%      -0.1        0.01 ±223%  perf-profile.children.cycles-pp.llist_add_batch
      0.11 ±190%      -0.1        0.00        perf-profile.children.cycles-pp.____machine__findnew_thread
      0.13 ± 26%      -0.1        0.02 ±142%  perf-profile.children.cycles-pp.cp_new_stat
      0.14 ± 53%      -0.1        0.03 ±111%  perf-profile.children.cycles-pp.free_unref_page_prepare
      0.38 ± 27%      -0.1        0.27 ± 12%  perf-profile.children.cycles-pp.__fget_light
      0.11 ±185%      -0.1        0.00        perf-profile.children.cycles-pp.rb_next
      0.11 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.symbols__delete
      0.15 ± 69%      -0.1        0.04 ±113%  perf-profile.children.cycles-pp.task_numa_fault
      0.16 ± 80%      -0.1        0.06 ± 56%  perf-profile.children.cycles-pp.vmstat_shepherd
      0.18 ± 89%      -0.1        0.08 ± 46%  perf-profile.children.cycles-pp.do_numa_page
      0.38 ± 38%      -0.1        0.28 ± 33%  perf-profile.children.cycles-pp.drm_client_buffer_vmap
      0.10 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.write_cache
      0.77 ± 35%      -0.1        0.67 ± 16%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.38 ± 43%      -0.1        0.28 ± 21%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.24 ± 60%      -0.1        0.14 ± 18%  perf-profile.children.cycles-pp.mutex_lock
      0.10 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.machine__delete_threads
      0.34 ± 40%      -0.1        0.24 ± 21%  perf-profile.children.cycles-pp.___perf_sw_event
      0.22 ± 33%      -0.1        0.12 ± 40%  perf-profile.children.cycles-pp.poll_freewait
      0.57 ± 32%      -0.1        0.47 ±  8%  perf-profile.children.cycles-pp.__x64_sys_sched_setaffinity
      0.55 ± 26%      -0.1        0.45 ± 13%  perf-profile.children.cycles-pp.drm_atomic_commit
      0.10 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.rb_free
      0.10 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.perf_release
      0.10 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.perf_event_release_kernel
      0.22 ± 83%      -0.1        0.12 ± 23%  perf-profile.children.cycles-pp.get_mm_cmdline
      0.12 ± 83%      -0.1        0.03 ±155%  perf-profile.children.cycles-pp.task_numa_migrate
      0.10 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.thread__delete
      0.96 ± 32%      -0.1        0.86 ± 21%  perf-profile.children.cycles-pp.proc_reg_read_iter
      0.21 ± 27%      -0.1        0.12 ± 25%  perf-profile.children.cycles-pp.task_tick_fair
      0.14 ± 35%      -0.1        0.05 ± 47%  perf-profile.children.cycles-pp.prepare_task_switch
      0.55 ± 26%      -0.1        0.46 ± 21%  perf-profile.children.cycles-pp.__close_nocancel
      0.46 ± 50%      -0.1        0.37 ± 27%  perf-profile.children.cycles-pp.run_ksoftirqd
      0.51 ± 47%      -0.1        0.42 ± 18%  perf-profile.children.cycles-pp.wait_for_lsr
      0.45 ± 41%      -0.1        0.36 ± 28%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.45 ± 74%      -0.1        0.36 ± 67%  perf-profile.children.cycles-pp.shmem_alloc_and_acct_folio
      0.37 ± 24%      -0.1        0.28 ± 22%  perf-profile.children.cycles-pp._dl_addr
      0.53 ± 25%      -0.1        0.44 ± 14%  perf-profile.children.cycles-pp.drm_atomic_helper_commit
      0.20 ± 95%      -0.1        0.11 ± 19%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.09 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.symbols__fixup_end
      0.50 ± 28%      -0.1        0.41 ± 21%  perf-profile.children.cycles-pp.fold_vm_numa_events
      0.09 ±189%      -0.1        0.00        perf-profile.children.cycles-pp.thread__new
      0.30 ± 44%      -0.1        0.21 ± 26%  perf-profile.children.cycles-pp.__perf_sw_event
      0.09 ±223%      -0.1        0.00        perf-profile.children.cycles-pp._free_event
      0.21 ± 72%      -0.1        0.12 ± 15%  perf-profile.children.cycles-pp.task_dump_owner
      0.27 ± 28%      -0.1        0.18 ± 15%  perf-profile.children.cycles-pp.do_readlinkat
      0.27 ± 24%      -0.1        0.19 ± 14%  perf-profile.children.cycles-pp.sysfs_kf_seq_show
      0.27 ± 31%      -0.1        0.18 ± 76%  perf-profile.children.cycles-pp.io_serial_out
      0.78 ± 32%      -0.1        0.70 ± 10%  perf-profile.children.cycles-pp.io_serial_in
      0.08 ±188%      -0.1        0.00        perf-profile.children.cycles-pp.machine__process_mmap2_event
      0.08 ± 27%      -0.1        0.00        perf-profile.children.cycles-pp.__mod_memcg_state
      0.27 ± 21%      -0.1        0.18 ± 14%  perf-profile.children.cycles-pp.dev_attr_show
      1.63 ± 31%      -0.1        1.55 ± 11%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.44 ± 29%      -0.1        0.36 ± 19%  perf-profile.children.cycles-pp.cpu_stopper_thread
      0.08 ±187%      -0.1        0.00        perf-profile.children.cycles-pp.nsinfo__new
      0.42 ± 26%      -0.1        0.34 ± 23%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.24 ± 56%      -0.1        0.16 ± 24%  perf-profile.children.cycles-pp.__vm_munmap
      0.24 ± 76%      -0.1        0.16 ± 23%  perf-profile.children.cycles-pp.proc_pid_cmdline_read
      0.27 ± 28%      -0.1        0.19 ± 16%  perf-profile.children.cycles-pp.__x64_sys_readlink
      1.63 ± 31%      -0.1        1.55 ± 11%  perf-profile.children.cycles-pp.do_group_exit
      0.09 ±106%      -0.1        0.02 ±223%  perf-profile.children.cycles-pp.delay_halt
      0.42 ± 29%      -0.1        0.34 ± 14%  perf-profile.children.cycles-pp.ast_mode_config_helper_atomic_commit_tail
      0.46 ± 41%      -0.1        0.39 ± 18%  perf-profile.children.cycles-pp.filemap_get_entry
      0.14 ± 42%      -0.1        0.06 ± 76%  perf-profile.children.cycles-pp.flush_tlb_func
      0.33 ± 60%      -0.1        0.25 ± 15%  perf-profile.children.cycles-pp.__check_object_size
      1.62 ± 31%      -0.1        1.55 ± 12%  perf-profile.children.cycles-pp.do_exit
      0.42 ± 29%      -0.1        0.34 ± 17%  perf-profile.children.cycles-pp.migration_cpu_stop
      0.52 ± 35%      -0.1        0.44 ± 21%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.39 ± 36%      -0.1        0.31 ± 29%  perf-profile.children.cycles-pp.drm_gem_shmem_get_pages_locked
      0.17 ± 33%      -0.1        0.10 ± 39%  perf-profile.children.cycles-pp.remove_wait_queue
      0.13 ± 68%      -0.1        0.05 ± 76%  perf-profile.children.cycles-pp.free_pcppages_bulk
      0.42 ± 29%      -0.1        0.35 ± 13%  perf-profile.children.cycles-pp.commit_tail
      0.67 ± 30%      -0.1        0.60 ± 17%  perf-profile.children.cycles-pp.pid_revalidate
      0.54 ± 34%      -0.1        0.46 ± 21%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.38 ± 36%      -0.1        0.31 ± 29%  perf-profile.children.cycles-pp.drm_gem_get_pages
      0.38 ± 36%      -0.1        0.31 ± 29%  perf-profile.children.cycles-pp.shmem_read_mapping_page_gfp
      0.15 ± 13%      -0.1        0.08 ± 24%  perf-profile.children.cycles-pp.__lock_task_sighand
      0.07 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.cpu_cache_level__read
      0.20 ± 55%      -0.1        0.13 ± 19%  perf-profile.children.cycles-pp.unmap_region
      0.09 ±155%      -0.1        0.02 ±146%  perf-profile.children.cycles-pp.__munmap
      0.07 ± 83%      -0.1        0.00        perf-profile.children.cycles-pp.task_numa_find_cpu
      0.24 ± 27%      -0.1        0.17 ± 14%  perf-profile.children.cycles-pp.readlink
      0.07 ±192%      -0.1        0.00        perf-profile.children.cycles-pp.map__new
      0.27 ± 26%      -0.1        0.20 ± 19%  perf-profile.children.cycles-pp.update_load_avg
      0.07 ± 82%      -0.1        0.00        perf-profile.children.cycles-pp.task_numa_compare
      0.07 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.maps__put
      0.78 ± 40%      -0.1        0.72 ± 26%  perf-profile.children.cycles-pp.wake_up_new_task
      0.60 ± 37%      -0.1        0.54 ± 23%  perf-profile.children.cycles-pp.vmstat_start
      0.47 ± 34%      -0.1        0.40 ± 11%  perf-profile.children.cycles-pp.__sched_setaffinity
      0.11 ± 30%      -0.1        0.05 ± 75%  perf-profile.children.cycles-pp.__get_vm_area_node
      0.11 ± 28%      -0.1        0.04 ± 75%  perf-profile.children.cycles-pp.alloc_vmap_area
      0.06 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.sw_perf_event_destroy
      0.16 ± 85%      -0.1        0.09 ± 33%  perf-profile.children.cycles-pp.__x64_sys_munmap
      0.60 ± 37%      -0.1        0.53 ± 17%  perf-profile.children.cycles-pp.step_into
      0.38 ± 30%      -0.1        0.32 ± 17%  perf-profile.children.cycles-pp.move_queued_task
      0.44 ± 35%      -0.1        0.38 ± 13%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr
      0.06 ± 79%      -0.1        0.00        perf-profile.children.cycles-pp.from_kuid_munged
      0.06 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.swevent_hlist_put_cpu
      0.14 ± 33%      -0.1        0.08 ± 64%  perf-profile.children.cycles-pp.add_wait_queue
      0.08 ± 85%      -0.1        0.02 ±142%  perf-profile.children.cycles-pp.terminate_walk
      0.32 ± 49%      -0.1        0.26 ± 57%  perf-profile.children.cycles-pp.shmem_add_to_page_cache
      0.06 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.map__process_kallsym_symbol
      0.06 ± 93%      -0.1        0.00        perf-profile.children.cycles-pp.llist_reverse_order
      0.06 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.queue_delayed_work_on
      0.16 ± 27%      -0.1        0.10 ± 40%  perf-profile.children.cycles-pp.drm_gem_vunmap_unlocked
      0.07 ± 63%      -0.1        0.01 ±223%  perf-profile.children.cycles-pp.generic_permission
      0.06 ± 75%      -0.1        0.00        perf-profile.children.cycles-pp.map_id_up
      0.06 ±223%      -0.1        0.00        perf-profile.children.cycles-pp.__free_pages
      0.16 ± 28%      -0.1        0.10 ± 40%  perf-profile.children.cycles-pp.drm_gem_shmem_vunmap
      0.21 ± 48%      -0.1        0.15 ± 24%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.16 ± 28%      -0.1        0.10 ± 39%  perf-profile.children.cycles-pp.drm_gem_vunmap
      0.12 ± 55%      -0.1        0.06 ± 51%  perf-profile.children.cycles-pp.folio_add_lru
      0.76 ± 29%      -0.1        0.70 ± 18%  perf-profile.children.cycles-pp.__d_lookup_rcu
      0.22 ± 29%      -0.1        0.17 ± 34%  perf-profile.children.cycles-pp.__count_memcg_events
      0.25 ± 30%      -0.1        0.20 ± 13%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.08 ± 43%      -0.1        0.02 ±142%  perf-profile.children.cycles-pp.folio_unlock
      0.22 ± 43%      -0.1        0.16 ± 18%  perf-profile.children.cycles-pp.vsnprintf
      0.35 ± 34%      -0.1        0.29 ± 12%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_planes
      0.34 ± 36%      -0.1        0.28 ± 13%  perf-profile.children.cycles-pp.memcpy_toio
      0.34 ± 36%      -0.1        0.28 ± 13%  perf-profile.children.cycles-pp.drm_fb_memcpy
      0.08 ± 35%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.irqtime_account_irq
      0.35 ± 34%      -0.1        0.30 ± 11%  perf-profile.children.cycles-pp.drm_atomic_helper_commit_tail_rpm
      0.10 ± 29%      -0.1        0.05 ± 47%  perf-profile.children.cycles-pp.vmap
      0.34 ± 36%      -0.1        0.29 ± 13%  perf-profile.children.cycles-pp.ast_primary_plane_helper_atomic_update
      0.27 ± 36%      -0.1        0.22 ± 21%  perf-profile.children.cycles-pp.mod_objcg_state
      0.28 ± 36%      -0.0        0.23 ± 18%  perf-profile.children.cycles-pp.affine_move_task
      0.32 ± 37%      -0.0        0.27 ± 23%  perf-profile.children.cycles-pp.tlb_batch_pages_flush
      0.18 ± 14%      -0.0        0.13 ± 29%  perf-profile.children.cycles-pp.single_release
      1.39 ± 38%      -0.0        1.34 ± 23%  perf-profile.children.cycles-pp.find_idlest_cpu
      0.28 ± 37%      -0.0        0.23 ± 19%  perf-profile.children.cycles-pp.release_pages
      1.44 ± 38%      -0.0        1.40 ± 22%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.47 ± 34%      -0.0        0.42 ± 19%  perf-profile.children.cycles-pp.inode_permission
      0.30 ± 35%      -0.0        0.25 ± 17%  perf-profile.children.cycles-pp.__d_lookup
      0.05 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.sysfs__read_int
      2.98 ± 30%      -0.0        2.94 ± 18%  perf-profile.children.cycles-pp.open64
      0.10 ± 34%      -0.0        0.05 ± 77%  perf-profile.children.cycles-pp.acpi_ps_parse_loop
      0.11 ± 57%      -0.0        0.07 ± 50%  perf-profile.children.cycles-pp.__mod_node_page_state
      0.05 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.s_next
      0.06 ± 86%      -0.0        0.02 ±223%  perf-profile.children.cycles-pp.change_pmd_range
      0.13 ± 78%      -0.0        0.08 ± 20%  perf-profile.children.cycles-pp.seq_printf
      0.07 ± 64%      -0.0        0.02 ±152%  perf-profile.children.cycles-pp.change_protection_range
      0.34 ± 38%      -0.0        0.29 ± 22%  perf-profile.children.cycles-pp.all_vm_events
      3.67 ± 26%      -0.0        3.62 ± 15%  perf-profile.children.cycles-pp.seq_read
      0.56 ± 26%      -0.0        0.51 ± 14%  perf-profile.children.cycles-pp.show_numa_map
      0.38 ± 34%      -0.0        0.33 ± 25%  perf-profile.children.cycles-pp.setlocale
      0.11 ± 38%      -0.0        0.07 ± 50%  perf-profile.children.cycles-pp.acpi_os_execute_deferred
      0.04 ±148%      -0.0        0.00        perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.06 ± 84%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.change_pte_range
      0.12 ± 39%      -0.0        0.07 ± 50%  perf-profile.children.cycles-pp.__perf_event_read_value
      0.46 ± 26%      -0.0        0.41 ± 18%  perf-profile.children.cycles-pp.walk_pud_range
      0.13 ± 19%      -0.0        0.09 ± 21%  perf-profile.children.cycles-pp.node_read_vmstat
      0.26 ± 28%      -0.0        0.22 ± 27%  perf-profile.children.cycles-pp.__mod_lruvec_page_state
      0.31 ± 33%      -0.0        0.27 ± 59%  perf-profile.children.cycles-pp.scheduler_tick
      0.14 ± 27%      -0.0        0.10 ± 32%  perf-profile.children.cycles-pp.flush_memcg_stats_dwork
      0.14 ± 27%      -0.0        0.10 ± 32%  perf-profile.children.cycles-pp.cgroup_rstat_flush_locked
      0.11 ± 35%      -0.0        0.06 ± 53%  perf-profile.children.cycles-pp.acpi_ns_evaluate
      0.04 ±151%      -0.0        0.00        perf-profile.children.cycles-pp.thread__get
      0.06 ± 14%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.need_update
      0.16 ± 26%      -0.0        0.12 ± 25%  perf-profile.children.cycles-pp.dput
      0.20 ± 26%      -0.0        0.16 ± 27%  perf-profile.children.cycles-pp.lock_vma_under_rcu
      0.19 ± 37%      -0.0        0.15 ± 17%  perf-profile.children.cycles-pp.cpu_stop_queue_work
      0.20 ± 33%      -0.0        0.15 ± 24%  perf-profile.children.cycles-pp.shift_arg_pages
      0.46 ± 25%      -0.0        0.42 ± 17%  perf-profile.children.cycles-pp.walk_page_vma
      0.46 ± 25%      -0.0        0.42 ± 17%  perf-profile.children.cycles-pp.__walk_page_range
      0.46 ± 25%      -0.0        0.42 ± 17%  perf-profile.children.cycles-pp.walk_pgd_range
      0.46 ± 26%      -0.0        0.42 ± 17%  perf-profile.children.cycles-pp.walk_p4d_range
      0.46 ± 25%      -0.0        0.41 ± 18%  perf-profile.children.cycles-pp.walk_pmd_range
      0.11 ± 35%      -0.0        0.06 ± 52%  perf-profile.children.cycles-pp.acpi_ev_asynch_execute_gpe_method
      0.06 ± 14%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.memchr_inv
      0.07 ±101%      -0.0        0.03 ±101%  perf-profile.children.cycles-pp.__free_one_page
      0.10 ± 36%      -0.0        0.06 ± 52%  perf-profile.children.cycles-pp.acpi_ps_execute_method
      0.10 ± 36%      -0.0        0.06 ± 52%  perf-profile.children.cycles-pp.acpi_ps_parse_aml
      0.08 ± 29%      -0.0        0.04 ± 75%  perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.16 ± 35%      -0.0        0.12 ± 15%  perf-profile.children.cycles-pp.wake_up_q
      0.10 ± 43%      -0.0        0.06 ± 51%  perf-profile.children.cycles-pp.__vmalloc_node_range
      0.65 ± 34%      -0.0        0.61 ± 11%  perf-profile.children.cycles-pp.iterate_dir
      0.44 ± 26%      -0.0        0.40 ± 17%  perf-profile.children.cycles-pp.gather_pte_stats
      0.04 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.update_iter
      0.07 ± 21%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.drm_atomic_helper_cleanup_planes
      0.07 ± 21%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.drm_gem_fb_vunmap
      0.04 ± 79%      -0.0        0.00        perf-profile.children.cycles-pp._compound_head
      0.06 ± 47%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.scnprintf
      0.04 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.s_show
      0.09 ± 23%      -0.0        0.05 ± 51%  perf-profile.children.cycles-pp.vfs_readlink
      0.04 ±104%      -0.0        0.00        perf-profile.children.cycles-pp.vunmap
      0.04 ± 72%      -0.0        0.00        perf-profile.children.cycles-pp.complete_walk
      0.06 ± 83%      -0.0        0.02 ±152%  perf-profile.children.cycles-pp.change_p4d_range
      0.19 ± 34%      -0.0        0.15 ± 24%  perf-profile.children.cycles-pp.vma_interval_tree_remove
      0.07 ± 16%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.proc_pid_readlink
      0.04 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.io__get_char
      0.04 ±112%      -0.0        0.00        perf-profile.children.cycles-pp.rw_verify_area
      0.05 ± 87%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.lru_add_fn
      0.07 ± 83%      -0.0        0.04 ± 73%  perf-profile.children.cycles-pp.security_vm_enough_memory_mm
      0.08 ± 26%      -0.0        0.04 ±103%  perf-profile.children.cycles-pp.check_move_unevictable_pages
      0.20 ± 14%      -0.0        0.16 ± 19%  perf-profile.children.cycles-pp.sync_regs
      0.22 ± 36%      -0.0        0.18 ± 21%  perf-profile.children.cycles-pp.setup_arg_pages
      0.10 ± 39%      -0.0        0.07 ± 52%  perf-profile.children.cycles-pp.free_unref_page_list
      0.65 ± 34%      -0.0        0.62 ± 11%  perf-profile.children.cycles-pp.__x64_sys_getdents64
      0.20 ± 27%      -0.0        0.17 ± 23%  perf-profile.children.cycles-pp.vma_prepare
      0.11 ± 22%      -0.0        0.08 ± 62%  perf-profile.children.cycles-pp.drm_gem_shmem_put_pages_locked
      0.11 ± 22%      -0.0        0.08 ± 62%  perf-profile.children.cycles-pp.drm_gem_put_pages
      0.04 ±109%      -0.0        0.00        perf-profile.children.cycles-pp.percpu_counter_destroy
      0.04 ±152%      -0.0        0.00        perf-profile.children.cycles-pp.alloc_misplaced_dst_page
      0.12 ± 29%      -0.0        0.08 ± 29%  perf-profile.children.cycles-pp.mem_cgroup_css_rstat_flush
      0.08 ± 24%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.dentry_kill
      0.03 ± 70%      -0.0        0.00        perf-profile.children.cycles-pp.get_cpu_idle_time_us
      0.16 ± 48%      -0.0        0.13 ± 48%  perf-profile.children.cycles-pp.do_set_pte
      0.12 ± 34%      -0.0        0.09 ± 28%  perf-profile.children.cycles-pp.node_read_numastat
      0.65 ± 34%      -0.0        0.62 ± 11%  perf-profile.children.cycles-pp.getdents64
      0.11 ± 44%      -0.0        0.08 ± 49%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.03 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.machine__findnew_vdso
      0.08 ± 29%      -0.0        0.05 ± 71%  perf-profile.children.cycles-pp.__dentry_kill
      0.09 ± 66%      -0.0        0.06 ± 48%  perf-profile.children.cycles-pp.perf_exclude_event
      0.03 ±155%      -0.0        0.00        perf-profile.children.cycles-pp.machines__deliver_event
      0.03 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.kernfs_fop_open
      0.12 ± 58%      -0.0        0.08 ± 29%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.09 ± 28%      -0.0        0.06 ± 47%  perf-profile.children.cycles-pp.fput
      0.21 ± 31%      -0.0        0.18 ± 22%  perf-profile.children.cycles-pp.switch_fpu_return
      0.18 ± 34%      -0.0        0.15 ± 21%  perf-profile.children.cycles-pp.kmalloc_trace
      0.07 ± 10%      -0.0        0.04 ± 73%  perf-profile.children.cycles-pp.set_task_cpu
      0.03 ±105%      -0.0        0.00        perf-profile.children.cycles-pp.get_vm_area_caller
      0.03 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.kernfs_dop_revalidate
      0.10 ± 23%      -0.0        0.07 ± 16%  perf-profile.children.cycles-pp.__switch_to
      0.79 ± 30%      -0.0        0.76 ± 16%  perf-profile.children.cycles-pp.open_last_lookups
      0.13 ± 83%      -0.0        0.10 ± 52%  perf-profile.children.cycles-pp.finish_fault
      0.10 ± 53%      -0.0        0.07 ± 26%  perf-profile.children.cycles-pp.lru_add_drain
      0.08 ± 26%      -0.0        0.05 ± 80%  perf-profile.children.cycles-pp.kstat_irqs_usr
      0.04 ±156%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.page_vma_mapped_walk
      0.03 ±158%      -0.0        0.00        perf-profile.children.cycles-pp.sysvec_call_function_single
      0.07 ± 56%      -0.0        0.04 ± 72%  perf-profile.children.cycles-pp.get_obj_cgroup_from_current
      0.37 ± 30%      -0.0        0.34 ± 20%  perf-profile.children.cycles-pp.free_pgtables
      0.32 ± 29%      -0.0        0.29 ± 24%  perf-profile.children.cycles-pp.__open64_nocancel
      0.04 ±102%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.update_numa_stats
      0.07 ± 31%      -0.0        0.04 ± 75%  perf-profile.children.cycles-pp.mas_next_entry
      0.63 ± 34%      -0.0        0.60 ± 11%  perf-profile.children.cycles-pp.proc_pid_readdir
      0.38 ± 38%      -0.0        0.35 ± 15%  perf-profile.children.cycles-pp.proc_fill_cache
      0.13 ± 40%      -0.0        0.10 ± 23%  perf-profile.children.cycles-pp.alloc_thread_stack_node
      0.02 ± 99%      -0.0        0.00        perf-profile.children.cycles-pp.alloc_fd
      0.02 ± 99%      -0.0        0.00        perf-profile.children.cycles-pp.perf_swevent_event
      0.02 ± 99%      -0.0        0.00        perf-profile.children.cycles-pp.task_prio
      0.06 ± 50%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp._copy_to_user
      0.02 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.proc_ns_get_link
      0.02 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.ns_get_path
      0.02 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.kallsyms_expand_symbol
      0.02 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__ns_get_path
      0.02 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.sysfs__read_str
      0.24 ± 32%      -0.0        0.21 ± 13%  perf-profile.children.cycles-pp.xas_load
      0.17 ± 24%      -0.0        0.14 ± 14%  perf-profile.children.cycles-pp.user_path_at_empty
      0.10 ± 31%      -0.0        0.07 ± 50%  perf-profile.children.cycles-pp.move_page_tables
      0.10 ± 46%      -0.0        0.08 ± 48%  perf-profile.children.cycles-pp.free_swap_cache
      0.12 ± 27%      -0.0        0.09 ± 23%  perf-profile.children.cycles-pp.__d_alloc
      0.40 ± 30%      -0.0        0.38 ± 68%  perf-profile.children.cycles-pp.update_process_times
      0.26 ± 18%      -0.0        0.23 ± 21%  perf-profile.children.cycles-pp.vma_interval_tree_insert
      0.14 ± 58%      -0.0        0.11 ± 47%  perf-profile.children.cycles-pp.aa_file_perm
      0.03 ±108%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.acpi_ns_search_and_enter
      0.03 ±108%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.acpi_ns_lookup
      0.03 ±103%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.close_fd
      0.02 ±143%      -0.0        0.00        perf-profile.children.cycles-pp.release_pte_folio
      0.13 ± 37%      -0.0        0.11 ± 23%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.14 ± 38%      -0.0        0.12 ± 25%  perf-profile.children.cycles-pp.vm_area_dup
      0.12 ± 30%      -0.0        0.09 ± 24%  perf-profile.children.cycles-pp.seq_open
      0.06 ± 28%      -0.0        0.04 ± 72%  perf-profile.children.cycles-pp.arch_irq_stat_cpu
      0.05 ± 80%      -0.0        0.03 ±102%  perf-profile.children.cycles-pp.vmap_pages_pud_range
      0.03 ±157%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.tlb_is_not_lazy
      0.32 ± 74%      -0.0        0.29 ± 64%  perf-profile.children.cycles-pp.shmem_alloc_folio
      0.30 ± 36%      -0.0        0.28 ± 25%  perf-profile.children.cycles-pp.get_user_pages_remote
      0.20 ± 25%      -0.0        0.17 ± 29%  perf-profile.children.cycles-pp.blk_mq_in_flight
      0.20 ± 25%      -0.0        0.17 ± 29%  perf-profile.children.cycles-pp.blk_mq_queue_tag_busy_iter
      0.38 ± 40%      -0.0        0.36 ± 18%  perf-profile.children.cycles-pp.dup_mmap
      0.19 ± 28%      -0.0        0.16 ± 20%  perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.18 ± 30%      -0.0        0.16 ± 22%  perf-profile.children.cycles-pp.pid_nr_ns
      0.17 ± 54%      -0.0        0.15 ± 55%  perf-profile.children.cycles-pp.perf_mmap_fault
      0.02 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__dsos__find
      0.04 ±107%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.remove_vm_area
      0.15 ± 36%      -0.0        0.13 ± 23%  perf-profile.children.cycles-pp.unlink_file_vma
      0.02 ±146%      -0.0        0.00        perf-profile.children.cycles-pp.find_unlink_vmap_area
      0.02 ±142%      -0.0        0.00        perf-profile.children.cycles-pp.acpi_ds_exec_end_op
      0.02 ±146%      -0.0        0.00        perf-profile.children.cycles-pp.acpi_ps_get_next_namepath
      0.05 ± 80%      -0.0        0.03 ±101%  perf-profile.children.cycles-pp.__vmap_pages_range_noflush
      0.02 ±142%      -0.0        0.00        perf-profile.children.cycles-pp.mntput_no_expire
      0.02 ±142%      -0.0        0.00        perf-profile.children.cycles-pp.folio_putback_lru
      0.02 ±142%      -0.0        0.00        perf-profile.children.cycles-pp.mem_cgroup_from_task
      0.50 ± 36%      -0.0        0.48 ± 29%  perf-profile.children.cycles-pp.khugepaged
      0.37 ± 58%      -0.0        0.35 ± 28%  perf-profile.children.cycles-pp.rmqueue
      0.13 ± 40%      -0.0        0.11 ± 10%  perf-profile.children.cycles-pp.__do_set_cpus_allowed
      0.13 ± 26%      -0.0        0.11 ± 26%  perf-profile.children.cycles-pp.unlink_anon_vmas
      0.12 ± 37%      -0.0        0.10 ± 45%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.02 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.update_iter_mod
      0.02 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.module_get_kallsym
      0.05 ± 77%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.handle_pte_fault
      0.02 ±144%      -0.0        0.00        perf-profile.children.cycles-pp.readdir64
      0.02 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.02 ±144%      -0.0        0.00        perf-profile.children.cycles-pp.follow_page_pte
      0.02 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.map__put
      0.02 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.perf_trace_destroy
      0.02 ±144%      -0.0        0.00        perf-profile.children.cycles-pp.do_pipe2
      0.02 ±144%      -0.0        0.00        perf-profile.children.cycles-pp.__x64_sys_pipe
      0.02 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__x2apic_send_IPI_mask
      0.03 ±101%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.__vm_enough_memory
      0.04 ±223%      -0.0        0.02 ±223%  perf-profile.children.cycles-pp.delay_halt_tpause
      0.12 ± 43%      -0.0        0.10 ± 14%  perf-profile.children.cycles-pp.__x64_sys_close
      0.11 ± 21%      -0.0        0.09 ± 27%  perf-profile.children.cycles-pp.drm_gem_fb_vmap
      0.33 ± 28%      -0.0        0.31 ± 20%  perf-profile.children.cycles-pp.diskstats_show
      0.29 ± 36%      -0.0        0.27 ± 25%  perf-profile.children.cycles-pp.__get_user_pages
      0.46 ± 31%      -0.0        0.44 ± 78%  perf-profile.children.cycles-pp.tick_sched_timer
      0.11 ± 34%      -0.0        0.09 ± 26%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.19 ± 31%      -0.0        0.18 ± 30%  perf-profile.children.cycles-pp.copy_strings
      0.09 ± 81%      -0.0        0.07 ± 81%  perf-profile.children.cycles-pp.folio_mark_accessed
      0.08 ± 35%      -0.0        0.07 ± 14%  perf-profile.children.cycles-pp.__switch_to_asm
      0.08 ± 33%      -0.0        0.06 ± 45%  perf-profile.children.cycles-pp.unmap_single_vma
      0.03 ±147%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.cap_vm_enough_memory
      0.02 ±142%      -0.0        0.00        perf-profile.children.cycles-pp.hrtimer_active
      0.06 ± 52%      -0.0        0.04 ± 76%  perf-profile.children.cycles-pp.do_notify_parent
      0.03 ±100%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.mutex_unlock
      0.03 ±102%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.mas_store
      0.02 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.write_cpu_topology
      0.02 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.perf_trace_event_unreg
      0.02 ±142%      -0.0        0.00        perf-profile.children.cycles-pp.mntput
      0.02 ±142%      -0.0        0.00        perf-profile.children.cycles-pp.__tlb_remove_page_size
      0.10 ± 27%      -0.0        0.08 ± 19%  perf-profile.children.cycles-pp.select_task_rq
      0.42 ± 31%      -0.0        0.40 ± 72%  perf-profile.children.cycles-pp.tick_sched_handle
      0.47 ± 36%      -0.0        0.45 ± 29%  perf-profile.children.cycles-pp.collapse_huge_page
      0.16 ± 38%      -0.0        0.14 ± 15%  perf-profile.children.cycles-pp.__set_cpus_allowed_ptr_locked
      0.18 ± 37%      -0.0        0.16 ± 17%  perf-profile.children.cycles-pp.__cond_resched
      0.02 ±152%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.events_stats__inc
      0.02 ±141%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.security_file_free
      0.02 ±141%      -0.0        0.00        perf-profile.children.cycles-pp.__get_vma_policy
      0.02 ±141%      -0.0        0.00        perf-profile.children.cycles-pp.folio_add_lru_vma
      0.02 ±141%      -0.0        0.00        perf-profile.children.cycles-pp.proc_exe_link
      0.02 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.trace_event_reg
      0.02 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.tracepoint_probe_unregister
      0.02 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.text_poke_bp_batch
      0.02 ±141%      -0.0        0.00        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.02 ±141%      -0.0        0.00        perf-profile.children.cycles-pp._copy_from_user
      0.12 ± 39%      -0.0        0.11 ± 18%  perf-profile.children.cycles-pp.perf_event_read
      0.11 ± 21%      -0.0        0.09 ± 26%  perf-profile.children.cycles-pp.drm_atomic_helper_prepare_planes
      0.06 ± 94%      -0.0        0.04 ±105%  perf-profile.children.cycles-pp.workingset_activation
      0.08 ± 42%      -0.0        0.07 ± 13%  perf-profile.children.cycles-pp.filp_close
      1.58 ± 57%      -0.0        1.56 ± 59%  perf-profile.children.cycles-pp.fault_in_readable
      1.58 ± 57%      -0.0        1.57 ± 59%  perf-profile.children.cycles-pp.fault_in_iov_iter_readable
      0.48 ± 36%      -0.0        0.47 ± 29%  perf-profile.children.cycles-pp.hpage_collapse_scan_pmd
      0.48 ± 36%      -0.0        0.47 ± 29%  perf-profile.children.cycles-pp.khugepaged_scan_mm_slot
      0.29 ± 44%      -0.0        0.28 ± 30%  perf-profile.children.cycles-pp.__do_fault
      0.23 ± 29%      -0.0        0.21 ± 17%  perf-profile.children.cycles-pp.single_open
      0.22 ± 36%      -0.0        0.20 ± 21%  perf-profile.children.cycles-pp.perf_event_mmap
      0.05 ±109%      -0.0        0.03 ±101%  perf-profile.children.cycles-pp.__do_sys_brk
      0.07 ± 85%      -0.0        0.05 ± 74%  perf-profile.children.cycles-pp.__mod_lruvec_state
      0.02 ±152%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.alloc_inode
      0.04 ±165%      -0.0        0.02 ±145%  perf-profile.children.cycles-pp.smp_call_function
      0.02 ±143%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.__mem_cgroup_uncharge_list
      0.02 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.new_inode_pseudo
      0.05 ±111%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.cfree
      0.07 ± 16%      -0.0        0.05 ± 51%  perf-profile.children.cycles-pp.___slab_alloc
      0.07 ± 33%      -0.0        0.05 ± 51%  perf-profile.children.cycles-pp.file_ra_state_init
      0.03 ±101%      -0.0        0.02 ±223%  perf-profile.children.cycles-pp.__list_add_valid
      0.02 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.sched_ttwu_pending
      0.02 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.kernfs_fop_release
      0.02 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.proc_single_open
      0.47 ± 43%      -0.0        0.46 ± 17%  perf-profile.children.cycles-pp.pick_link
      0.02 ±152%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.18 ± 40%      -0.0        0.16 ± 20%  perf-profile.children.cycles-pp.proc_pid_get_link
      0.12 ± 45%      -0.0        0.11 ± 18%  perf-profile.children.cycles-pp.copy_p4d_range
      0.04 ±116%      -0.0        0.03 ±103%  perf-profile.children.cycles-pp.brk
      0.04 ±104%      -0.0        0.02 ±146%  perf-profile.children.cycles-pp.string
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.symbol__is_idle
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__dsos__findnew_link_by_longname_id
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.rb_insert_color
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.s_start
      0.03 ±100%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.native_sched_clock
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.machines__for_each_thread
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.rb_first
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.kernfs_iop_permission
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.mmap__munmap
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.perf_mmap__munmap
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.kfree
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.do_huge_pmd_wp_page
      0.10 ± 34%      -0.0        0.08 ± 18%  perf-profile.children.cycles-pp.xas_find
      0.21 ± 35%      -0.0        0.20 ± 21%  perf-profile.children.cycles-pp.perf_event_mmap_event
      0.10 ± 61%      -0.0        0.08 ± 82%  perf-profile.children.cycles-pp.__perf_mmap__read_init
      0.13 ± 43%      -0.0        0.12 ± 21%  perf-profile.children.cycles-pp.copy_page_range
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.path_put
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.maps__clone
      0.02 ±144%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.format_decode
      0.02 ±144%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.slab_pre_alloc_hook
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.dsos__findnew_id
      0.02 ±144%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.strlen
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.get_kthread_comm
      0.02 ±146%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.meminfo_proc_show
      0.02 ±144%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.rcu_all_qs
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.ZSTD_freeDCtx
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.comm__free
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.access_error
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.mpol_shared_policy_lookup
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.fclose
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.lockref_put_or_lock
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.folio_lruvec_lock_irqsave
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.sched_move_task
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.xyarray__entry
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.get_user_cpu_mask
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.perf_event_ctx_lock_nested
      0.04 ±111%      -0.0        0.03 ±101%  perf-profile.children.cycles-pp.__perf_session__process_decomp_events
      0.05 ± 91%      -0.0        0.04 ± 72%  perf-profile.children.cycles-pp.anon_vma_clone
      0.15 ± 70%      -0.0        0.14 ± 80%  perf-profile.children.cycles-pp.find_vma
      0.12 ± 26%      -0.0        0.10 ± 22%  perf-profile.children.cycles-pp.__access_remote_vm
      0.56 ± 55%      -0.0        0.56 ± 22%  perf-profile.children.cycles-pp.get_page_from_freelist
      0.30 ± 28%      -0.0        0.29 ± 17%  perf-profile.children.cycles-pp.__kmem_cache_alloc_node
      0.15 ± 28%      -0.0        0.14 ± 28%  perf-profile.children.cycles-pp.mas_walk
      0.20 ± 41%      -0.0        0.20 ± 33%  perf-profile.children.cycles-pp.get_arg_page
      0.12 ± 40%      -0.0        0.11 ± 27%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.07 ± 48%      -0.0        0.06 ± 73%  perf-profile.children.cycles-pp.evsel__compute_deltas
      0.05 ± 47%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.07 ± 60%      -0.0        0.06 ± 55%  perf-profile.children.cycles-pp.page_add_file_rmap
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__rblist__findnew
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.number
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.save_fpregs_to_fpstate
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.try_to_unmap_flush
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.inode_init_always
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.arch_tlbbatch_flush
      0.02 ±142%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.xas_store
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__mutex_lock
      0.02 ±144%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.apparmor_file_free_security
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.uncharge_batch
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.perf_env__arch
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.cpu_topology__new
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.check_move_unevictable_folios
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.getopt_long
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__irqentry_text_end
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__check_heap_object
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.check_preempt_wakeup
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__sysconf
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__vmalloc_area_node
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.create_pipe_files
      0.10 ± 39%      -0.0        0.09 ± 15%  perf-profile.children.cycles-pp._copy_to_iter
      0.16 ± 45%      -0.0        0.15 ± 74%  perf-profile.children.cycles-pp.perf_mmap__read_init
      0.10 ± 34%      -0.0        0.09 ± 22%  perf-profile.children.cycles-pp.pid_task
      0.06 ± 54%      -0.0        0.06 ± 50%  perf-profile.children.cycles-pp.exit_notify
      0.03 ±102%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp.alloc_new_pud
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__comm_str__findnew
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.access
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__static_call_update
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.static_key_disable
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.arch_static_call_transform
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.static_key_disable_cpuslocked
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__static_call_transform
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.arch_jump_label_transform_apply
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.text_poke_bp
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.text_poke_finish
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.perf_trace_sched_migrate_task
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.can_change_pte_writable
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__get_task_ioprio
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.maps__find
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.set_cpus_allowed_common
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.do_write
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__update_load_avg_se
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.perf_tp_event
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.acpi_ex_system_memory_space_handler
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.task_h_load
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.update_cfs_group
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.fdarray__filter
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.apparmor_file_alloc_security
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.page_get_link
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__alloc_pages_bulk
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.generic_file_mmap
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.acpi_ex_field_datum_io
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.acpi_ex_access_region
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.acpi_ev_address_space_dispatch
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.simple_lookup
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.stop_one_cpu
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.migrate_task_rq_fair
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp._IO_file_close_it
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.cpu__max_cpu
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.balance_dirty_pages_ratelimited_flags
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.security_mmap_file
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.__put_anon_vma
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.pcpu_memcg_post_alloc_hook
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.perf_event_comm
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.acpi_ds_evaluate_name_path
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.acpi_ex_resolve_node_to_value
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.acpi_ex_read_data_from_field
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.copy_creds
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.devkmsg_write
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.devkmsg_emit
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.lru_add_drain_per_cpu
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.remove_migration_pte
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.vm_memory_committed
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.wake_affine
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.memmove
      0.01 ±223%      -0.0        0.00        perf-profile.children.cycles-pp.malloc@plt
      0.10 ± 30%      -0.0        0.09 ± 25%  perf-profile.children.cycles-pp.page_remove_rmap
      0.10 ± 44%      -0.0        0.09 ± 14%  perf-profile.children.cycles-pp.seq_puts
      0.04 ±112%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.__folio_throttle_swaprate
      0.05 ±119%      -0.0        0.04 ± 73%  perf-profile.children.cycles-pp.anon_vma_fork
      0.24 ± 33%      -0.0        0.24 ± 25%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.23 ± 36%      -0.0        0.22 ± 17%  perf-profile.children.cycles-pp.d_hash_and_lookup
      0.20 ± 28%      -0.0        0.20 ± 18%  perf-profile.children.cycles-pp.vfs_getattr_nosec
      0.02 ± 99%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.rcu_report_qs_rdp
      0.09 ± 34%      -0.0        0.09 ± 21%  perf-profile.children.cycles-pp.aa_get_task_label
      0.09 ± 32%      -0.0        0.08 ± 14%  perf-profile.children.cycles-pp.__legitimize_path
      0.11 ± 41%      -0.0        0.11 ± 15%  perf-profile.children.cycles-pp.errseq_sample
      0.02 ±141%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.__evlist__disable
      0.02 ±141%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.kthread_data
      0.02 ±141%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.kmem_cache_free_bulk
      0.03 ±161%      -0.0        0.02 ±149%  perf-profile.children.cycles-pp.zero_user_segments
      0.36 ± 30%      -0.0        0.36 ± 16%  perf-profile.children.cycles-pp.memcg_slab_post_alloc_hook
      0.20 ± 30%      -0.0        0.19 ± 16%  perf-profile.children.cycles-pp.generic_fillattr
      0.10 ± 39%      -0.0        0.09 ± 11%  perf-profile.children.cycles-pp.try_to_unlazy
      0.06 ± 70%      -0.0        0.06 ± 88%  perf-profile.children.cycles-pp.perf_mmap_to_page
      0.10 ± 51%      -0.0        0.09 ± 58%  perf-profile.children.cycles-pp.perf_stat_process_counter
      0.07 ± 54%      -0.0        0.06 ± 53%  perf-profile.children.cycles-pp.gather_stats
      0.10 ± 37%      -0.0        0.10 ± 30%  perf-profile.children.cycles-pp.create_elf_tables
      0.07 ± 33%      -0.0        0.07 ± 47%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.02 ± 99%      -0.0        0.02 ±144%  perf-profile.children.cycles-pp.prepend_path
      0.03 ±103%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.mas_push_data
      0.03 ±108%      -0.0        0.03 ±147%  perf-profile.children.cycles-pp.expand_downwards
      0.02 ±142%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp.m_next
      0.10 ± 14%      -0.0        0.09 ± 17%  perf-profile.children.cycles-pp.__kmem_cache_free
      0.21 ± 32%      -0.0        0.20 ± 18%  perf-profile.children.cycles-pp.d_alloc_parallel
      0.03 ±103%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.remove_vma
      0.02 ±144%      -0.0        0.02 ±141%  perf-profile.children.cycles-pp._find_next_bit
      0.05 ± 71%      -0.0        0.04 ± 71%  perf-profile.children.cycles-pp.fsnotify_perm
      0.01 ±223%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.perf_event_mmap_output
      0.01 ±223%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.proc_invalidate_siblings_dcache
      0.01 ±223%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.ptep_clear_flush
      0.03 ±152%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.blk_cgroup_congested
      0.16 ± 32%      -0.0        0.16 ± 19%  perf-profile.children.cycles-pp.apparmor_ptrace_access_check
      0.14 ± 36%      -0.0        0.14 ± 25%  perf-profile.children.cycles-pp.__wake_up_common
      0.20 ± 32%      -0.0        0.20 ± 20%  perf-profile.children.cycles-pp.d_alloc
      0.20 ± 26%      -0.0        0.20 ± 18%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.21 ± 36%      -0.0        0.21 ± 21%  perf-profile.children.cycles-pp.may_open
      0.10 ± 69%      -0.0        0.10 ± 30%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.13 ± 56%      -0.0        0.12 ± 28%  perf-profile.children.cycles-pp.pte_alloc_one
      0.06 ± 75%      -0.0        0.06 ±139%  perf-profile.children.cycles-pp.clockevents_program_event
      0.01 ±223%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.alloc_cpumask_var_node
      0.02 ±144%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.inode_to_bdi
      0.02 ±144%      -0.0        0.02 ±142%  perf-profile.children.cycles-pp.free_percpu
      0.01 ±223%      -0.0        0.01 ±223%  perf-profile.children.cycles-pp.put_prev_task_stop
      0.12 ± 43%      -0.0        0.12 ± 27%  perf-profile.children.cycles-pp.copy_string_kernel
      0.10 ± 52%      -0.0        0.10 ± 59%  perf-profile.children.cycles-pp.process_counters
      0.07 ± 58%      -0.0        0.07 ± 17%  perf-profile.children.cycles-pp.__anon_vma_prepare
      0.03 ±111%      -0.0        0.03 ±103%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.04 ±149%      -0.0        0.04 ±106%  perf-profile.children.cycles-pp.workingset_age_nonresident
      0.10 ± 34%      +0.0        0.10 ± 23%  perf-profile.children.cycles-pp.__entry_text_start
      0.08 ± 49%      +0.0        0.08 ± 16%  perf-profile.children.cycles-pp.smp_call_function_single
      0.08 ± 47%      +0.0        0.08 ± 12%  perf-profile.children.cycles-pp.generic_exec_single
      0.07 ± 67%      +0.0        0.07 ± 50%  perf-profile.children.cycles-pp.__pte_alloc
      0.06 ± 92%      +0.0        0.06 ± 17%  perf-profile.children.cycles-pp.copy_pte_range
      0.04 ± 73%      +0.0        0.04 ± 72%  perf-profile.children.cycles-pp.__pud_alloc
      0.05 ± 74%      +0.0        0.05 ± 71%  perf-profile.children.cycles-pp.d_path
      0.02 ±141%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.dup_fd
      0.02 ±223%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.do_wp_page
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.mas_next_nentry
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.__anon_vma_interval_tree_remove
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.syscall_enter_from_user_mode
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.mas_mab_cp
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.perf_event_task
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.copy_page_to_iter
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.mas_store_b_node
      0.04 ±106%      +0.0        0.04 ± 73%  perf-profile.children.cycles-pp.do_brk_flags
      0.26 ± 51%      +0.0        0.26 ± 24%  perf-profile.children.cycles-pp.perf_read
      0.07 ± 47%      +0.0        0.07 ± 49%  perf-profile.children.cycles-pp.find_extend_vma
      0.04 ±107%      +0.0        0.04 ± 72%  perf-profile.children.cycles-pp.__legitimize_mnt
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.mas_wr_store_entry
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.mas_wmb_replace
      0.03 ±101%      +0.0        0.03 ±102%  perf-profile.children.cycles-pp._IO_setvbuf
      0.02 ±145%      +0.0        0.03 ±100%  perf-profile.children.cycles-pp.lookup_open
      0.04 ±104%      +0.0        0.04 ± 71%  perf-profile.children.cycles-pp.xas_start
      0.24 ± 30%      +0.0        0.25 ± 15%  perf-profile.children.cycles-pp.next_tgid
      0.21 ± 34%      +0.0        0.21 ± 19%  perf-profile.children.cycles-pp.wq_worker_comm
      0.13 ± 32%      +0.0        0.13 ± 17%  perf-profile.children.cycles-pp.part_stat_read_all
      0.56 ± 28%      +0.0        0.56 ± 39%  perf-profile.children.cycles-pp.alloc_empty_file
      0.21 ± 57%      +0.0        0.22 ± 29%  perf-profile.children.cycles-pp.apparmor_file_permission
      0.14 ± 30%      +0.0        0.14 ± 29%  perf-profile.children.cycles-pp.strnlen_user
      0.13 ± 62%      +0.0        0.13 ± 28%  perf-profile.children.cycles-pp.vm_area_alloc
      0.04 ± 76%      +0.0        0.05 ± 73%  perf-profile.children.cycles-pp.__p4d_alloc
      0.06 ± 60%      +0.0        0.06 ± 50%  perf-profile.children.cycles-pp.current_time
      0.02 ±141%      +0.0        0.02 ±149%  perf-profile.children.cycles-pp.ui_progress__update
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.children.cycles-pp.idle_cpu
      0.12 ± 27%      +0.0        0.12 ± 26%  perf-profile.children.cycles-pp.padzero
      0.09 ± 31%      +0.0        0.09 ± 20%  perf-profile.children.cycles-pp.clock_gettime
      0.06 ± 76%      +0.0        0.06 ± 49%  perf-profile.children.cycles-pp.folio_add_new_anon_rmap
      0.10 ± 29%      +0.0        0.11 ± 20%  perf-profile.children.cycles-pp.num_to_str
      0.05 ± 78%      +0.0        0.05 ±105%  perf-profile.children.cycles-pp.atomic_read
      0.05 ± 77%      +0.0        0.05 ±105%  perf-profile.children.cycles-pp.refcount_read
      0.06 ± 78%      +0.0        0.06 ± 63%  perf-profile.children.cycles-pp._raw_spin_trylock
      0.55 ± 28%      +0.0        0.55 ± 40%  perf-profile.children.cycles-pp.__alloc_file
      0.24 ± 55%      +0.0        0.24 ± 25%  perf-profile.children.cycles-pp.security_file_permission
      0.14 ± 32%      +0.0        0.14 ± 13%  perf-profile.children.cycles-pp.dequeue_entity
      0.09 ± 19%      +0.0        0.09 ± 19%  perf-profile.children.cycles-pp.getenv
      0.04 ±104%      +0.0        0.04 ± 72%  perf-profile.children.cycles-pp.check_preempt_curr
      0.25 ± 34%      +0.0        0.26 ± 18%  perf-profile.children.cycles-pp.security_ptrace_access_check
      0.14 ± 38%      +0.0        0.14 ± 19%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.01 ±223%      +0.0        0.02 ±223%  perf-profile.children.cycles-pp._find_next_and_bit
      0.02 ±146%      +0.0        0.03 ±102%  perf-profile.children.cycles-pp.printk_get_next_message
      0.03 ±108%      +0.0        0.04 ± 72%  perf-profile.children.cycles-pp.prepare_creds
      0.02 ±144%      +0.0        0.03 ±100%  perf-profile.children.cycles-pp.cap_ptrace_access_check
      0.17 ± 73%      +0.0        0.18 ± 55%  perf-profile.children.cycles-pp.mt_find
      0.53 ± 45%      +0.0        0.54 ± 22%  perf-profile.children.cycles-pp.readn
      0.48 ± 54%      +0.0        0.49 ± 28%  perf-profile.children.cycles-pp.__folio_alloc
      0.41 ± 25%      +0.0        0.42 ± 21%  perf-profile.children.cycles-pp.kmem_cache_free
      0.10 ± 36%      +0.0        0.10 ± 21%  perf-profile.children.cycles-pp.get_zeroed_page
      0.02 ±152%      +0.0        0.03 ±103%  perf-profile.children.cycles-pp.mas_destroy
      0.07 ± 53%      +0.0        0.08 ± 25%  perf-profile.children.cycles-pp.vmf_insert_pfn_prot
      0.03 ±150%      +0.0        0.04 ± 71%  perf-profile.children.cycles-pp.__get_obj_cgroup_from_memcg
      0.02 ±146%      +0.0        0.03 ±101%  perf-profile.children.cycles-pp.vma_expand
      0.01 ±223%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.__fsnotify_parent
      0.01 ±223%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.mas_find
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.strtoll
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.sched_mm_cid_remote_clear
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.hrtimer_update_next_event
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.timerqueue_add
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.__bitmap_and
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.rcu_gp_cleanup
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.pm_qos_read_value
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.pgd_ctor
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.strnlen
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp._IO_file_open
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.make_child
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.free_pgd_range
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.lockref_get_not_dead
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.free_p4d_range
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.free_pud_range
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.swake_up_one
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.xas_create
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.generic_write_checks
      0.06 ± 61%      +0.0        0.06 ± 47%  perf-profile.children.cycles-pp._exit
      0.06 ± 55%      +0.0        0.07 ± 21%  perf-profile.children.cycles-pp.security_file_alloc
      0.19 ± 17%      +0.0        0.20 ± 21%  perf-profile.children.cycles-pp.update_curr
      0.28 ± 40%      +0.0        0.29 ± 22%  perf-profile.children.cycles-pp.do_mprotect_pkey
      0.38 ± 46%      +0.0        0.39 ± 27%  perf-profile.children.cycles-pp.__collapse_huge_page_copy
      0.13 ± 25%      +0.0        0.14 ± 13%  perf-profile.children.cycles-pp.__task_pid_nr_ns
      0.06 ± 58%      +0.0        0.07 ± 26%  perf-profile.children.cycles-pp.track_pfn_insert
      0.02 ±149%      +0.0        0.03 ±106%  perf-profile.children.cycles-pp.file_update_time
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.snprintf
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.get_next_timer_interrupt
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.vfree
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.schedule_hrtimeout_range_clock
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.enqueue_hrtimer
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.update_rt_rq_load_avg
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.timerqueue_del
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.uptime_proc_show
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.strscpy_pad
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.irqentry_enter_from_user_mode
      0.06 ± 63%      +0.0        0.07 ± 29%  perf-profile.children.cycles-pp.thread_group_cputime
      0.06 ± 58%      +0.0        0.07 ± 23%  perf-profile.children.cycles-pp.lookup_memtype
      0.06 ± 58%      +0.0        0.07 ± 23%  perf-profile.children.cycles-pp.pat_pagerange_is_ram
      0.06 ± 58%      +0.0        0.07 ± 23%  perf-profile.children.cycles-pp.walk_system_ram_range
      0.06 ± 58%      +0.0        0.07 ± 23%  perf-profile.children.cycles-pp.find_next_iomem_res
      0.05 ± 49%      +0.0        0.06 ± 54%  perf-profile.children.cycles-pp.__pmd_alloc
      0.28 ± 40%      +0.0        0.29 ± 21%  perf-profile.children.cycles-pp.__x64_sys_mprotect
      0.22 ± 33%      +0.0        0.23 ± 18%  perf-profile.children.cycles-pp.__lookup_slow
      0.18 ± 38%      +0.0        0.19 ± 32%  perf-profile.children.cycles-pp.pipe_write
      0.04 ±105%      +0.0        0.05 ± 74%  perf-profile.children.cycles-pp.security_file_open
      0.02 ±141%      +0.0        0.03 ±100%  perf-profile.children.cycles-pp.__send_signal_locked
      0.01 ±223%      +0.0        0.02 ±223%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.01 ±223%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.__vm_area_free
      0.01 ±223%      +0.0        0.02 ±141%  perf-profile.children.cycles-pp.set_next_entity
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.irqtime_account_process_tick
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.tcp_orphan_count_sum
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.tcp_orphan_update
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.irqentry_enter
      0.02 ±223%      +0.0        0.03 ±100%  perf-profile.children.cycles-pp.proc_pid_permission
      0.10 ± 36%      +0.0        0.12 ± 24%  perf-profile.children.cycles-pp.mas_split
      0.05 ± 52%      +0.0        0.06 ± 23%  perf-profile.children.cycles-pp.aa_may_ptrace
      0.16 ± 22%      +0.0        0.18 ± 16%  perf-profile.children.cycles-pp.perf_iterate_sb
      0.12 ± 34%      +0.0        0.13 ± 22%  perf-profile.children.cycles-pp.seq_put_decimal_ull_width
      0.03 ±143%      +0.0        0.04 ± 72%  perf-profile.children.cycles-pp.vma_link
      0.01 ±223%      +0.0        0.03 ±100%  perf-profile.children.cycles-pp.do_faccessat
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.read_tsc
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.tick_irq_enter
      0.00            +0.0        0.01 ±223%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.10 ± 48%      +0.0        0.12 ± 33%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.01 ±223%      +0.0        0.02 ± 99%  perf-profile.children.cycles-pp.acct_collect
      0.08 ± 52%      +0.0        0.10 ± 17%  perf-profile.children.cycles-pp.perf_trace_sched_wakeup_template
      0.12 ± 22%      +0.0        0.13 ± 24%  perf-profile.children.cycles-pp.__kmalloc_node
      0.36 ± 15%      +0.0        0.38 ± 13%  perf-profile.children.cycles-pp.try_to_wake_up
      0.15 ± 33%      +0.0        0.17 ± 24%  perf-profile.children.cycles-pp.__fdget_pos
      0.14 ± 40%      +0.0        0.16 ± 26%  perf-profile.children.cycles-pp.enqueue_entity
      0.04 ±101%      +0.0        0.05 ± 46%  perf-profile.children.cycles-pp.arch_dup_task_struct
      0.06 ± 74%      +0.0        0.08 ± 15%  perf-profile.children.cycles-pp.__perf_event_read
      0.06 ± 60%      +0.0        0.08 ± 30%  perf-profile.children.cycles-pp.thread_group_cputime_adjusted
      0.00            +0.0        0.02 ±223%  perf-profile.children.cycles-pp.arch_cpu_idle_enter
      0.00            +0.0        0.02 ±223%  perf-profile.children.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.0        0.02 ±223%  perf-profile.children.cycles-pp.run_posix_cpu_timers
      0.70 ± 37%      +0.0        0.71 ± 21%  perf-profile.children.cycles-pp.sched_exec
      0.23 ± 40%      +0.0        0.24 ± 19%  perf-profile.children.cycles-pp.mprotect_fixup
      0.06 ± 86%      +0.0        0.08 ± 22%  perf-profile.children.cycles-pp.__get_free_pages
      0.15 ± 39%      +0.0        0.17 ± 25%  perf-profile.children.cycles-pp.atime_needs_update
      0.04 ±106%      +0.0        0.06 ± 47%  perf-profile.children.cycles-pp.insert_vm_struct
      0.00            +0.0        0.02 ±141%  perf-profile.children.cycles-pp.get_sigframe
      0.00            +0.0        0.02 ±223%  perf-profile.children.cycles-pp.get_cpu_device
      0.00            +0.0        0.02 ±223%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.00            +0.0        0.02 ±223%  perf-profile.children.cycles-pp.tick_sched_do_timer
      0.01 ±223%      +0.0        0.03 ±102%  perf-profile.children.cycles-pp.show_map_vma
      0.01 ±223%      +0.0        0.03 ±102%  perf-profile.children.cycles-pp.show_map
      0.21 ± 42%      +0.0        0.23 ± 21%  perf-profile.children.cycles-pp.do_cow_fault
      0.76 ± 37%      +0.0        0.78 ± 21%  perf-profile.children.cycles-pp.__x64_sys_vfork
      0.52 ± 52%      +0.0        0.54 ± 28%  perf-profile.children.cycles-pp.vma_alloc_folio
      1.12 ± 31%      +0.0        1.14 ± 10%  perf-profile.children.cycles-pp.do_open
      0.88 ± 31%      +0.0        0.90 ±  9%  perf-profile.children.cycles-pp.do_dentry_open
      0.02 ±144%      +0.0        0.04 ± 71%  perf-profile.children.cycles-pp.__pipe
      0.04 ±112%      +0.0        0.06 ± 14%  perf-profile.children.cycles-pp.__install_special_mapping
      0.00            +0.0        0.02 ±142%  perf-profile.children.cycles-pp.vm_unmapped_area
      0.00            +0.0        0.02 ±142%  perf-profile.children.cycles-pp.x64_setup_rt_frame
      0.00            +0.0        0.02 ±142%  perf-profile.children.cycles-pp._IO_setb
      0.00            +0.0        0.02 ±142%  perf-profile.children.cycles-pp.__exit_signal
      0.00            +0.0        0.02 ±142%  perf-profile.children.cycles-pp.down_read_trylock
      0.00            +0.0        0.02 ±223%  perf-profile.children.cycles-pp.timekeeping_max_deferment
      0.00            +0.0        0.02 ±142%  perf-profile.children.cycles-pp.delayed_vfree_work
      0.00            +0.0        0.02 ±142%  perf-profile.children.cycles-pp.strscpy
      0.02 ±141%      +0.0        0.04 ± 71%  perf-profile.children.cycles-pp._IO_link_in
      0.03 ±158%      +0.0        0.05 ± 75%  perf-profile.children.cycles-pp.ktime_get_coarse_real_ts64
      0.15 ± 37%      +0.0        0.17 ± 19%  perf-profile.children.cycles-pp.load_elf_interp
      0.10 ± 45%      +0.0        0.12 ± 29%  perf-profile.children.cycles-pp.clear_page_erms
      0.13 ± 34%      +0.0        0.15 ± 24%  perf-profile.children.cycles-pp.__wake_up_common_lock
      0.04 ±114%      +0.0        0.06 ± 11%  perf-profile.children.cycles-pp.map_vdso
      0.01 ±223%      +0.0        0.03 ±100%  perf-profile.children.cycles-pp.handle_signal
      0.00            +0.0        0.02 ±144%  perf-profile.children.cycles-pp._IO_getc
      0.00            +0.0        0.02 ±223%  perf-profile.children.cycles-pp.__run_timers
      0.00            +0.0        0.02 ±223%  perf-profile.children.cycles-pp.rcu_pending
      0.00            +0.0        0.02 ±223%  perf-profile.children.cycles-pp.call_timer_fn
      0.02 ±223%      +0.0        0.04 ±109%  perf-profile.children.cycles-pp.__kmalloc
      1.31 ± 35%      +0.0        1.33 ± 22%  perf-profile.children.cycles-pp.find_idlest_group
      0.28 ± 28%      +0.0        0.30 ± 39%  perf-profile.children.cycles-pp.show_stat
      0.79 ± 49%      +0.0        0.81 ± 21%  perf-profile.children.cycles-pp.__alloc_pages
      0.32 ± 44%      +0.0        0.34 ± 22%  perf-profile.children.cycles-pp.elf_map
      0.18 ± 33%      +0.0        0.20 ±  5%  perf-profile.children.cycles-pp.malloc
      0.05 ±119%      +0.0        0.08 ± 20%  perf-profile.children.cycles-pp.__libc_calloc
      0.04 ±112%      +0.0        0.06 ± 79%  perf-profile.children.cycles-pp.kcpustat_cpu_fetch
      0.03 ±100%      +0.0        0.05 ± 48%  perf-profile.children.cycles-pp.filemap_read
      0.01 ±223%      +0.0        0.04 ±101%  perf-profile.children.cycles-pp.rcu_nocb_try_bypass
      0.01 ±223%      +0.0        0.03 ±103%  perf-profile.children.cycles-pp._IO_file_doallocate
      0.01 ±223%      +0.0        0.03 ±101%  perf-profile.children.cycles-pp.mas_store_gfp
      0.03 ±143%      +0.0        0.05 ± 49%  perf-profile.children.cycles-pp.devkmsg_read
      0.06 ± 49%      +0.0        0.08 ± 28%  perf-profile.children.cycles-pp.memcg_account_kmem
      0.09 ± 33%      +0.0        0.12 ±  9%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.00            +0.0        0.02 ±223%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.00            +0.0        0.02 ±223%  perf-profile.children.cycles-pp.force_qs_rnp
      0.01 ±223%      +0.0        0.04 ± 71%  perf-profile.children.cycles-pp.cpuacct_charge
      0.01 ±223%      +0.0        0.04 ± 71%  perf-profile.children.cycles-pp.get_pid_task
      0.10 ± 34%      +0.0        0.13 ± 22%  perf-profile.children.cycles-pp.__ptrace_may_access
      0.39 ± 32%      +0.0        0.41 ± 11%  perf-profile.children.cycles-pp.ptrace_may_access
      0.02 ±141%      +0.0        0.04 ±107%  perf-profile.children.cycles-pp.__perf_read_group_add
      0.02 ±149%      +0.0        0.05 ± 80%  perf-profile.children.cycles-pp.pgd_alloc
      0.14 ± 34%      +0.0        0.16 ± 24%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      0.58 ± 34%      +0.0        0.60 ± 22%  perf-profile.children.cycles-pp.wp_page_copy
      0.13 ± 34%      +0.0        0.15 ± 33%  perf-profile.children.cycles-pp.__call_rcu_common
      0.04 ± 71%      +0.0        0.06 ± 19%  perf-profile.children.cycles-pp.put_dec_trunc8
      0.39 ± 61%      +0.0        0.42 ± 46%  perf-profile.children.cycles-pp.shmem_write_end
      0.15 ± 37%      +0.0        0.18 ± 27%  perf-profile.children.cycles-pp.mas_wr_bnode
      1.28 ± 36%      +0.0        1.31 ± 22%  perf-profile.children.cycles-pp.update_sg_wakeup_stats
      0.05 ± 84%      +0.0        0.08 ± 22%  perf-profile.children.cycles-pp.release_task
      0.03 ±102%      +0.0        0.06 ± 49%  perf-profile.children.cycles-pp.touch_atime
      0.00            +0.0        0.03 ±223%  perf-profile.children.cycles-pp.rcu_sched_clock_irq
      0.22 ± 36%      +0.0        0.25 ± 57%  perf-profile.children.cycles-pp.dup_task_struct
      0.08 ± 47%      +0.0        0.12 ± 25%  perf-profile.children.cycles-pp.do_open_execat
      0.03 ±100%      +0.0        0.06 ± 50%  perf-profile.children.cycles-pp.path_init
      0.06 ± 66%      +0.0        0.09 ± 19%  perf-profile.children.cycles-pp.wait_task_zombie
      0.00            +0.0        0.03 ±103%  perf-profile.children.cycles-pp.open_exec
      0.06 ± 50%      +0.0        0.10 ±143%  perf-profile.children.cycles-pp.__intel_pmu_enable_all
      0.10 ± 31%      +0.0        0.13 ± 17%  perf-profile.children.cycles-pp.down_write
      0.38 ± 34%      +0.0        0.41 ± 20%  perf-profile.children.cycles-pp.__split_vma
      0.00            +0.0        0.03 ±100%  perf-profile.children.cycles-pp.__collapse_huge_page_copy_succeeded
      0.00            +0.0        0.03 ±223%  perf-profile.children.cycles-pp.cpuidle_governor_latency_req
      0.26 ± 37%      +0.0        0.30 ± 29%  perf-profile.children.cycles-pp.write
      0.14 ± 57%      +0.0        0.17 ± 24%  perf-profile.children.cycles-pp.perf_evlist__poll
      0.00            +0.0        0.04 ± 71%  perf-profile.children.cycles-pp.memset@plt
      0.31 ± 35%      +0.0        0.35 ± 19%  perf-profile.children.cycles-pp.proc_task_name
      0.02 ±144%      +0.0        0.06 ± 47%  perf-profile.children.cycles-pp.get_unmapped_area
      0.08 ± 81%      +0.0        0.12 ±172%  perf-profile.children.cycles-pp.ktime_get
      0.10 ± 35%      +0.0        0.14 ± 28%  perf-profile.children.cycles-pp.file_free_rcu
      0.28 ± 24%      +0.0        0.32 ± 25%  perf-profile.children.cycles-pp.__mmap
      0.08 ± 48%      +0.0        0.12 ±122%  perf-profile.children.cycles-pp.perf_rotate_context
      0.16 ± 62%      +0.0        0.20 ± 28%  perf-profile.children.cycles-pp.start_thread
      0.16 ± 62%      +0.0        0.20 ± 28%  perf-profile.children.cycles-pp.perf_evlist__poll_thread
      0.01 ±223%      +0.0        0.05 ± 49%  perf-profile.children.cycles-pp.arch_get_unmapped_area_topdown
      0.23 ± 30%      +0.0        0.27 ± 17%  perf-profile.children.cycles-pp.getname_flags
      0.02 ±142%      +0.0        0.06 ±223%  perf-profile.children.cycles-pp.kmem_cache_alloc_node
      0.20 ± 32%      +0.0        0.25 ± 35%  perf-profile.children.cycles-pp.charge_memcg
      0.08 ± 17%      +0.0        0.12 ± 20%  perf-profile.children.cycles-pp.mas_preallocate
      0.13 ± 17%      +0.0        0.18 ± 16%  perf-profile.children.cycles-pp.strncpy_from_user
      0.00            +0.0        0.04 ± 73%  perf-profile.children.cycles-pp.sscanf
      0.00            +0.0        0.04 ± 73%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.03 ± 70%      +0.0        0.08 ± 48%  perf-profile.children.cycles-pp.get_idle_time
      0.00            +0.0        0.05 ±159%  perf-profile.children.cycles-pp.wait_for_completion_state
      0.00            +0.0        0.05 ±223%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.78 ± 39%      +0.0        0.83 ± 20%  perf-profile.children.cycles-pp.__vfork
      0.08 ± 16%      +0.0        0.13 ± 21%  perf-profile.children.cycles-pp.mas_alloc_nodes
      0.01 ±223%      +0.0        0.06 ±112%  perf-profile.children.cycles-pp.wait_for_partner
      0.10 ± 45%      +0.1        0.14 ± 23%  perf-profile.children.cycles-pp.vma_complete
      0.09 ± 56%      +0.1        0.14 ± 67%  perf-profile.children.cycles-pp.__wait_for_common
      0.24 ± 33%      +0.1        0.29 ± 17%  perf-profile.children.cycles-pp.__slab_free
      0.04 ±104%      +0.1        0.09 ±160%  perf-profile.children.cycles-pp.balance_fair
      0.73 ± 31%      +0.1        0.78 ± 21%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.07 ± 37%      +0.1        0.12 ±109%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.00            +0.1        0.06 ± 78%  perf-profile.children.cycles-pp.drm_gem_check_release_pagevec
      0.00            +0.1        0.06 ± 65%  perf-profile.children.cycles-pp.get_cpu_sleep_time_us
      0.01 ±223%      +0.1        0.07 ± 90%  perf-profile.children.cycles-pp.fifo_open
      0.13 ± 23%      +0.1        0.19 ± 59%  perf-profile.children.cycles-pp.try_charge_memcg
      7.93 ± 55%      +0.1        7.99 ± 51%  perf-profile.children.cycles-pp.__libc_start_main
      7.92 ± 55%      +0.1        7.98 ± 51%  perf-profile.children.cycles-pp.main
      7.92 ± 55%      +0.1        7.98 ± 51%  perf-profile.children.cycles-pp.run_builtin
      0.00            +0.1        0.06 ±223%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.12 ± 33%      +0.1        0.19 ±123%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.14 ± 41%      +0.1        0.20 ± 28%  perf-profile.children.cycles-pp.get_mem_cgroup_from_mm
      0.18 ± 27%      +0.1        0.25 ±  8%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.03 ±102%      +0.1        0.10 ± 24%  perf-profile.children.cycles-pp.kmem_cache_alloc_bulk
      0.01 ±223%      +0.1        0.08 ±141%  perf-profile.children.cycles-pp.schedule_tail
      0.00            +0.1        0.07 ± 53%  perf-profile.children.cycles-pp.__snprintf_chk
      5.97 ± 27%      +0.1        6.04 ± 15%  perf-profile.children.cycles-pp.read
      0.01 ±223%      +0.1        0.09 ± 22%  perf-profile.children.cycles-pp.__kmem_cache_alloc_bulk
      0.07 ±134%      +0.1        0.15 ± 90%  perf-profile.children.cycles-pp.schedule_idle
      0.00            +0.1        0.08 ±168%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.00            +0.1        0.08 ± 17%  perf-profile.children.cycles-pp.copyout
      0.65 ± 30%      +0.1        0.74 ± 86%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.00            +0.1        0.08 ± 20%  perf-profile.children.cycles-pp._IO_fread
      0.00            +0.1        0.08 ±193%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      1.87 ± 37%      +0.1        1.96 ± 24%  perf-profile.children.cycles-pp.process_interval
      0.14 ±112%      +0.1        0.23 ±128%  perf-profile.children.cycles-pp.__pthread_disable_asynccancel
      0.00            +0.1        0.09 ±165%  perf-profile.children.cycles-pp.update_blocked_averages
      1.87 ± 37%      +0.1        1.96 ± 24%  perf-profile.children.cycles-pp.dispatch_events
      2.63 ± 26%      +0.1        2.72 ± 15%  perf-profile.children.cycles-pp.proc_single_show
      2.62 ± 26%      +0.1        2.71 ± 15%  perf-profile.children.cycles-pp.do_task_stat
      0.75 ± 42%      +0.1        0.85 ± 14%  perf-profile.children.cycles-pp.rcu_do_batch
      1.75 ± 37%      +0.1        1.85 ± 24%  perf-profile.children.cycles-pp.read_counters
      0.00            +0.1        0.10 ± 32%  perf-profile.children.cycles-pp.cgroup_rstat_flush
      0.04 ±168%      +0.1        0.14 ±169%  perf-profile.children.cycles-pp.find_busiest_queue
      0.91 ± 33%      +0.1        1.01 ± 20%  perf-profile.children.cycles-pp.mmap_region
      0.00            +0.1        0.10 ± 35%  perf-profile.children.cycles-pp.get_signal
      0.82 ± 38%      +0.1        0.93 ± 14%  perf-profile.children.cycles-pp.rcu_core
      0.35 ± 34%      +0.1        0.46 ±  9%  perf-profile.children.cycles-pp.__mem_cgroup_charge
      1.00 ± 34%      +0.1        1.11 ± 19%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.63 ± 39%      +0.1        0.74 ± 18%  perf-profile.children.cycles-pp.dup_mm
      1.12 ± 36%      +0.1        1.23 ± 19%  perf-profile.children.cycles-pp.__do_sys_clone
      0.35 ± 65%      +0.1        0.46 ± 84%  perf-profile.children.cycles-pp.perf_mmap__read_head
      0.35 ± 66%      +0.1        0.46 ± 83%  perf-profile.children.cycles-pp.ring_buffer_read_head
      0.01 ±223%      +0.1        0.12 ±126%  perf-profile.children.cycles-pp.do_task_dead
      0.04 ± 89%      +0.1        0.16 ± 16%  perf-profile.children.cycles-pp.mas_wr_modify
      0.97 ± 34%      +0.1        1.09 ± 19%  perf-profile.children.cycles-pp.do_mmap
      0.79 ± 28%      +0.1        0.91 ± 83%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.02 ±223%      +0.1        0.14 ± 19%  perf-profile.children.cycles-pp.mas_wr_node_store
      0.02 ±146%      +0.1        0.15 ± 33%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
      1.87 ± 36%      +0.1        2.00 ± 18%  perf-profile.children.cycles-pp.kernel_clone
      0.81 ± 28%      +0.1        0.94 ± 82%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.12 ± 51%      +0.1        0.25 ± 63%  perf-profile.children.cycles-pp.evlist__id2evsel
      0.22 ± 46%      +0.1        0.36 ± 21%  perf-profile.children.cycles-pp.mas_store_prealloc
      0.47 ± 32%      +0.1        0.61 ± 19%  perf-profile.children.cycles-pp.do_anonymous_page
      1.06 ± 33%      +0.1        1.20 ± 19%  perf-profile.children.cycles-pp.copy_process
      0.00            +0.1        0.14 ± 36%  perf-profile.children.cycles-pp.update_rq_clock_task
      3.77 ± 23%      +0.1        3.91 ± 35%  perf-profile.children.cycles-pp.kthread
      0.16 ± 43%      +0.2        0.32 ± 49%  perf-profile.children.cycles-pp.pipe_read
      0.80 ± 44%      +0.2        0.96 ± 24%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.00            +0.2        0.16 ± 18%  perf-profile.children.cycles-pp.check_heap_object
      0.66 ± 46%      +0.2        0.82 ± 35%  perf-profile.children.cycles-pp.finish_task_switch
      0.65 ± 39%      +0.2        0.82 ± 34%  perf-profile.children.cycles-pp.__percpu_counter_sum
      0.71 ± 38%      +0.2        0.89 ± 32%  perf-profile.children.cycles-pp.__mmdrop
      0.00            +0.2        0.18 ±185%  perf-profile.children.cycles-pp.menu_select
      0.00            +0.2        0.19 ± 29%  perf-profile.children.cycles-pp.mm_account_fault
      1.77 ± 27%      +0.2        1.96 ± 24%  perf-profile.children.cycles-pp.cmd_stat
      1.18 ± 36%      +0.2        1.37 ± 19%  perf-profile.children.cycles-pp.__libc_fork
      3.79 ± 23%      +0.2        4.00 ± 37%  perf-profile.children.cycles-pp.ret_from_fork
      0.75 ± 38%      +0.2        0.97 ± 24%  perf-profile.children.cycles-pp.alloc_bprm
      0.00            +0.2        0.22 ± 39%  perf-profile.children.cycles-pp.mm_init_cid
      0.00            +0.2        0.24 ± 28%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.23 ± 39%      +0.2        0.48 ± 60%  perf-profile.children.cycles-pp.kernel_wait4
      0.01 ±223%      +0.2        0.26 ±164%  perf-profile.children.cycles-pp.arch_call_rest_init
      0.01 ±223%      +0.2        0.26 ±164%  perf-profile.children.cycles-pp.start_kernel
      0.01 ±223%      +0.2        0.26 ±164%  perf-profile.children.cycles-pp.rest_init
      0.66 ± 28%      +0.2        0.90 ± 25%  perf-profile.children.cycles-pp.exec_mmap
      0.23 ± 40%      +0.2        0.48 ± 60%  perf-profile.children.cycles-pp.do_wait
      0.00            +0.3        0.26 ±164%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.00            +0.3        0.26 ±164%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.00            +0.3        0.26 ± 30%  perf-profile.children.cycles-pp.mtree_range_walk
      0.87 ± 38%      +0.3        1.15 ± 21%  perf-profile.children.cycles-pp.pcpu_alloc
      0.74 ± 30%      +0.3        1.01 ± 24%  perf-profile.children.cycles-pp.begin_new_exec
      0.00            +0.3        0.28 ± 19%  perf-profile.children.cycles-pp.drm_fbdev_generic_damage_blit_real
      0.00            +0.3        0.29 ± 21%  perf-profile.children.cycles-pp.activate_task
      1.66 ± 34%      +0.3        1.96 ± 22%  perf-profile.children.cycles-pp.exec_binprm
      1.65 ± 34%      +0.3        1.95 ± 22%  perf-profile.children.cycles-pp.search_binary_handler
      0.29 ± 57%      +0.3        0.60 ± 61%  perf-profile.children.cycles-pp.evsel__read_counter
      0.25 ± 71%      +0.3        0.56 ± 72%  perf-profile.children.cycles-pp.rebalance_domains
      1.64 ± 33%      +0.3        1.94 ± 22%  perf-profile.children.cycles-pp.load_elf_binary
      0.00            +0.3        0.31 ± 29%  perf-profile.children.cycles-pp.drm_gem_shmem_get_pages
      0.00            +0.3        0.32 ± 22%  perf-profile.children.cycles-pp.__wp_page_copy_user
      0.33 ± 39%      +0.3        0.66 ± 23%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      2.48 ± 35%      +0.3        2.82 ± 21%  perf-profile.children.cycles-pp.bprm_execve
      0.28 ± 41%      +0.3        0.62 ± 50%  perf-profile.children.cycles-pp.wait4
      0.94 ± 39%      +0.4        1.28 ± 22%  perf-profile.children.cycles-pp.mm_init
      0.00            +0.4        0.36 ± 28%  perf-profile.children.cycles-pp.drm_gem_shmem_vmap_locked
      0.00            +0.4        0.37 ± 29%  perf-profile.children.cycles-pp.drm_gem_shmem_object_vmap
      0.03 ±223%      +0.4        0.40 ±198%  perf-profile.children.cycles-pp.intel_idle
      0.00            +0.5        0.48 ± 11%  perf-profile.children.cycles-pp.__memcpy
      0.92 ± 38%      +0.5        1.41 ± 22%  perf-profile.children.cycles-pp.irqentry_exit_to_user_mode
      1.14 ± 34%      +0.5        1.66 ± 34%  perf-profile.children.cycles-pp.__do_softirq
      3.57 ± 36%      +0.5        4.11 ± 22%  perf-profile.children.cycles-pp.execve
      3.57 ± 36%      +0.5        4.12 ± 22%  perf-profile.children.cycles-pp.do_execveat_common
      3.58 ± 36%      +0.6        4.13 ± 22%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.01 ±223%      +0.6        0.60 ±175%  perf-profile.children.cycles-pp.rcu_gp_fqs_loop
      0.72 ± 36%      +0.6        1.32 ± 50%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.01 ±223%      +0.6        0.62 ±169%  perf-profile.children.cycles-pp.schedule_timeout
      0.29 ± 42%      +0.6        0.92 ± 20%  perf-profile.children.cycles-pp.__memset
      0.02 ±223%      +0.6        0.66 ±201%  perf-profile.children.cycles-pp.intel_idle_xstate
      0.02 ±146%      +0.6        0.67 ±172%  perf-profile.children.cycles-pp.rcu_gp_kthread
      1.68 ± 32%      +0.7        2.35 ± 21%  perf-profile.children.cycles-pp.exit_to_user_mode_prepare
      1.43 ± 33%      +0.7        2.14 ± 22%  perf-profile.children.cycles-pp.exit_to_user_mode_loop
      0.89 ± 43%      +0.8        1.69 ± 20%  perf-profile.children.cycles-pp.task_work_run
      1.54 ± 26%      +0.8        2.35 ± 63%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.50 ± 40%      +0.9        2.43 ± 67%  perf-profile.children.cycles-pp.schedule
      0.42 ± 69%      +0.9        1.35 ±143%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.39 ± 72%      +1.0        1.35 ±154%  perf-profile.children.cycles-pp.newidle_balance
      0.52 ± 72%      +1.0        1.52 ±126%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.54 ± 72%      +1.1        1.59 ±126%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.54 ± 73%      +1.1        1.60 ±126%  perf-profile.children.cycles-pp.find_busiest_group
      0.00            +1.1        1.08 ± 15%  perf-profile.children.cycles-pp.drm_fbdev_generic_helper_fb_dirty
      1.68 ± 41%      +1.1        2.79 ± 68%  perf-profile.children.cycles-pp.__schedule
      4.06 ± 25%      +1.1        5.18 ± 27%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.00            +1.1        1.13 ± 20%  perf-profile.children.cycles-pp.task_mm_cid_work
      0.63 ± 72%      +1.2        1.84 ±126%  perf-profile.children.cycles-pp.load_balance
      0.21 ± 94%      +2.0        2.26 ±192%  perf-profile.children.cycles-pp.cpuidle_enter_state
      0.00            +2.0        2.05 ± 58%  perf-profile.children.cycles-pp.copyin
      0.21 ± 94%      +2.1        2.26 ±192%  perf-profile.children.cycles-pp.cpuidle_enter
      0.31 ± 89%      +2.1        2.42 ±187%  perf-profile.children.cycles-pp.start_secondary
      0.23 ± 91%      +2.3        2.48 ±191%  perf-profile.children.cycles-pp.cpuidle_idle_call
      0.33 ± 87%      +2.3        2.67 ±184%  perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      0.33 ± 87%      +2.3        2.67 ±184%  perf-profile.children.cycles-pp.cpu_startup_entry
      0.33 ± 87%      +2.3        2.67 ±184%  perf-profile.children.cycles-pp.do_idle
     53.13 ± 31%      +5.9       59.07 ± 11%  perf-profile.children.cycles-pp.__cmd_record
     45.08 ± 45%      +6.9       51.98 ±  8%  perf-profile.children.cycles-pp.record__finish_output
     45.07 ± 45%      +6.9       51.98 ±  8%  perf-profile.children.cycles-pp.perf_session__process_events
     44.88 ± 45%      +7.1       51.95 ±  8%  perf-profile.children.cycles-pp.reader__read_event
     39.40 ± 47%     +11.2       50.62 ± 10%  perf-profile.children.cycles-pp.process_simple
     38.23 ± 48%     +11.6       49.86 ± 11%  perf-profile.children.cycles-pp.ordered_events__queue
     38.12 ± 48%     +11.9       50.04 ± 10%  perf-profile.children.cycles-pp.queue_event
      8.95 ± 66%      -7.8        1.16 ±147%  perf-profile.self.cycles-pp.copy_page
      2.34 ± 51%      -2.3        0.00        perf-profile.self.cycles-pp.copy_user_enhanced_fast_string
      1.88 ±111%      -1.4        0.42 ±223%  perf-profile.self.cycles-pp.evlist__parse_sample
      0.92 ±109%      -0.8        0.12 ±223%  perf-profile.self.cycles-pp.evsel__parse_sample
      0.67 ±105%      -0.5        0.17 ±223%  perf-profile.self.cycles-pp.__ordered_events__flush
      0.49 ± 31%      -0.5        0.00        perf-profile.self.cycles-pp.memcpy_erms
      0.44 ± 43%      -0.4        0.00        perf-profile.self.cycles-pp.memset_erms
      0.44 ±128%      -0.3        0.12 ±223%  perf-profile.self.cycles-pp.machine__findnew_thread
      0.60 ±124%      -0.3        0.31 ± 59%  perf-profile.self.cycles-pp.reader__read_event
      0.70 ±120%      -0.3        0.44 ± 67%  perf-profile.self.cycles-pp.evlist__parse_sample_timestamp
      1.52 ± 22%      -0.3        1.26 ± 17%  perf-profile.self.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.30 ± 47%      -0.2        0.06 ±118%  perf-profile.self.cycles-pp.smp_call_function_many_cond
      0.21 ±144%      -0.2        0.00        perf-profile.self.cycles-pp.rb_erase
      0.62 ± 27%      -0.2        0.43 ± 12%  perf-profile.self.cycles-pp.io_serial_in
      0.17 ± 73%      -0.2        0.01 ±223%  perf-profile.self.cycles-pp.mt_find
      0.36 ± 33%      -0.1        0.21 ± 36%  perf-profile.self.cycles-pp.perf_poll
      0.17 ± 90%      -0.1        0.03 ±223%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.65 ± 23%      -0.1        0.52 ± 23%  perf-profile.self.cycles-pp.next_uptodate_page
      0.15 ± 28%      -0.1        0.01 ±223%  perf-profile.self.cycles-pp.mas_walk
      0.64 ± 27%      -0.1        0.51 ± 22%  perf-profile.self.cycles-pp.zap_pte_range
      0.12 ± 45%      -0.1        0.00        perf-profile.self.cycles-pp.common_perm_cond
      0.29 ±109%      -0.1        0.16 ± 59%  perf-profile.self.cycles-pp.evsel__parse_sample_timestamp
      0.38 ± 27%      -0.1        0.26 ± 12%  perf-profile.self.cycles-pp.__fget_light
      0.13 ± 40%      -0.1        0.01 ±223%  perf-profile.self.cycles-pp.llist_add_batch
      0.10 ±195%      -0.1        0.00        perf-profile.self.cycles-pp.rb_next
      0.14 ± 58%      -0.1        0.03 ±111%  perf-profile.self.cycles-pp.free_unref_page_prepare
      0.38 ± 42%      -0.1        0.27 ± 19%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.23 ± 61%      -0.1        0.13 ± 18%  perf-profile.self.cycles-pp.mutex_lock
      0.45 ± 41%      -0.1        0.36 ± 28%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.50 ± 28%      -0.1        0.41 ± 21%  perf-profile.self.cycles-pp.fold_vm_numa_events
      0.08 ± 22%      -0.1        0.00        perf-profile.self.cycles-pp.update_rq_clock
      0.09 ± 17%      -0.1        0.01 ±223%  perf-profile.self.cycles-pp.handle_mm_fault
      0.34 ± 23%      -0.1        0.26 ± 22%  perf-profile.self.cycles-pp._dl_addr
      0.40 ± 24%      -0.1        0.33 ± 23%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.07 ± 82%      -0.1        0.00        perf-profile.self.cycles-pp.task_numa_compare
      0.06 ± 65%      -0.1        0.00        perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.06 ± 47%      -0.1        0.00        perf-profile.self.cycles-pp.__lock_task_sighand
      0.06 ±133%      -0.1        0.00        perf-profile.self.cycles-pp.find_idlest_cpu
      0.31 ± 42%      -0.1        0.25 ± 26%  perf-profile.self.cycles-pp.filemap_get_entry
      0.06 ± 94%      -0.1        0.00        perf-profile.self.cycles-pp.llist_reverse_order
      0.06 ±223%      -0.1        0.00        perf-profile.self.cycles-pp.__free_pages
      0.47 ± 34%      -0.1        0.41 ± 14%  perf-profile.self.cycles-pp._raw_spin_lock
      0.22 ± 27%      -0.1        0.17 ± 15%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.06 ± 76%      -0.1        0.00        perf-profile.self.cycles-pp.map_id_up
      0.08 ± 43%      -0.1        0.02 ±142%  perf-profile.self.cycles-pp.folio_unlock
      0.18 ± 29%      -0.1        0.13 ± 33%  perf-profile.self.cycles-pp.__count_memcg_events
      0.73 ± 30%      -0.1        0.67 ± 18%  perf-profile.self.cycles-pp.__d_lookup_rcu
      0.07 ± 39%      -0.1        0.02 ±142%  perf-profile.self.cycles-pp.alloc_vmap_area
      0.08 ± 60%      -0.1        0.03 ±101%  perf-profile.self.cycles-pp.vsnprintf
      0.06 ±145%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.thread__find_map
      0.06 ±107%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.flush_tlb_func
      0.21 ± 36%      -0.0        0.16 ± 31%  perf-profile.self.cycles-pp.___perf_sw_event
      0.33 ± 38%      -0.0        0.29 ± 22%  perf-profile.self.cycles-pp.all_vm_events
      0.04 ±151%      -0.0        0.00        perf-profile.self.cycles-pp.thread__get
      0.11 ± 60%      -0.0        0.07 ± 50%  perf-profile.self.cycles-pp.__mod_node_page_state
      0.06 ± 14%      -0.0        0.02 ±142%  perf-profile.self.cycles-pp.memchr_inv
      0.05 ± 84%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.change_pte_range
      0.08 ± 29%      -0.0        0.04 ± 75%  perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.26 ± 33%      -0.0        0.22 ± 17%  perf-profile.self.cycles-pp.__alloc_file
      0.24 ± 30%      -0.0        0.20 ± 12%  perf-profile.self.cycles-pp.__d_lookup
      0.29 ± 24%      -0.0        0.25 ± 19%  perf-profile.self.cycles-pp.memcpy_toio
      0.06 ± 84%      -0.0        0.02 ±142%  perf-profile.self.cycles-pp.vma_alloc_folio
      0.06 ± 47%      -0.0        0.02 ±146%  perf-profile.self.cycles-pp.fput
      0.17 ± 32%      -0.0        0.13 ± 25%  perf-profile.self.cycles-pp.update_load_avg
      0.18 ± 32%      -0.0        0.15 ± 25%  perf-profile.self.cycles-pp.vma_interval_tree_remove
      0.06 ± 49%      -0.0        0.02 ±141%  perf-profile.self.cycles-pp.lock_vma_under_rcu
      0.04 ± 71%      -0.0        0.00        perf-profile.self.cycles-pp.__mod_memcg_state
      0.05 ± 75%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.__perf_event_read
      0.06 ± 51%      -0.0        0.03 ±102%  perf-profile.self.cycles-pp.__check_object_size
      0.20 ± 14%      -0.0        0.16 ± 19%  perf-profile.self.cycles-pp.sync_regs
      0.16 ± 44%      -0.0        0.12 ± 19%  perf-profile.self.cycles-pp.lookup_fast
      0.14 ± 29%      -0.0        0.10 ± 15%  perf-profile.self.cycles-pp.io_serial_out
      0.04 ±101%      -0.0        0.00        perf-profile.self.cycles-pp.ttwu_do_activate
      0.07 ± 31%      -0.0        0.04 ±107%  perf-profile.self.cycles-pp.kstat_irqs_usr
      0.35 ± 32%      -0.0        0.31 ± 15%  perf-profile.self.cycles-pp.gather_pte_stats
      0.12 ± 29%      -0.0        0.08 ± 29%  perf-profile.self.cycles-pp.mem_cgroup_css_rstat_flush
      0.03 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.io__get_char
      0.03 ±100%      -0.0        0.00        perf-profile.self.cycles-pp.prepare_task_switch
      0.03 ±108%      -0.0        0.00        perf-profile.self.cycles-pp._compound_head
      0.03 ±108%      -0.0        0.00        perf-profile.self.cycles-pp.step_into
      0.09 ± 67%      -0.0        0.06 ± 47%  perf-profile.self.cycles-pp.perf_exclude_event
      0.05 ±121%      -0.0        0.02 ±141%  perf-profile.self.cycles-pp.__free_one_page
      0.10 ± 23%      -0.0        0.07 ± 15%  perf-profile.self.cycles-pp.__switch_to
      0.03 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.map__process_kallsym_symbol
      0.03 ±146%      -0.0        0.00        perf-profile.self.cycles-pp.generic_permission
      0.35 ± 35%      -0.0        0.32 ± 18%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.19 ± 26%      -0.0        0.16 ± 16%  perf-profile.self.cycles-pp.xas_load
      0.03 ±144%      -0.0        0.00        perf-profile.self.cycles-pp.perf_session__process_events
      0.03 ±100%      -0.0        0.00        perf-profile.self.cycles-pp.irqtime_account_irq
      0.26 ± 18%      -0.0        0.23 ± 20%  perf-profile.self.cycles-pp.vma_interval_tree_insert
      0.04 ±105%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.handle_pte_fault
      0.03 ±100%      -0.0        0.00        perf-profile.self.cycles-pp.read
      0.03 ±100%      -0.0        0.00        perf-profile.self.cycles-pp.proc_pid_readlink
      0.03 ±100%      -0.0        0.00        perf-profile.self.cycles-pp.get_obj_cgroup_from_current
      0.08 ± 56%      -0.0        0.06 ± 48%  perf-profile.self.cycles-pp.vfs_read
      0.02 ± 99%      -0.0        0.00        perf-profile.self.cycles-pp.perf_swevent_event
      0.02 ± 99%      -0.0        0.00        perf-profile.self.cycles-pp.get_cpu_idle_time_us
      0.02 ±152%      -0.0        0.00        perf-profile.self.cycles-pp.events_stats__inc
      0.02 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.kallsyms_expand_symbol
      0.02 ±145%      -0.0        0.00        perf-profile.self.cycles-pp.exit_to_user_mode_prepare
      0.10 ± 47%      -0.0        0.08 ± 48%  perf-profile.self.cycles-pp.free_swap_cache
      0.04 ±104%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.update_numa_stats
      0.03 ±108%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.acpi_ns_search_and_enter
      0.02 ±149%      -0.0        0.00        perf-profile.self.cycles-pp.lru_add_drain_cpu
      0.02 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.kernfs_dop_revalidate
      0.14 ± 37%      -0.0        0.12 ± 24%  perf-profile.self.cycles-pp.mod_objcg_state
      0.06 ± 28%      -0.0        0.04 ± 72%  perf-profile.self.cycles-pp.arch_irq_stat_cpu
      0.05 ± 80%      -0.0        0.03 ±102%  perf-profile.self.cycles-pp.vmap_pages_pud_range
      0.03 ±157%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.tlb_is_not_lazy
      0.27 ± 58%      -0.0        0.25 ± 83%  perf-profile.self.cycles-pp.record__mmap_read_evlist
      0.10 ± 68%      -0.0        0.07 ± 76%  perf-profile.self.cycles-pp.perf_mmap_fault
      0.19 ± 28%      -0.0        0.16 ± 20%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.02 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.__dsos__find
      0.10 ± 58%      -0.0        0.08 ± 49%  perf-profile.self.cycles-pp.get_page_from_freelist
      0.02 ±142%      -0.0        0.00        perf-profile.self.cycles-pp.security_vm_enough_memory_mm
      0.02 ±142%      -0.0        0.00        perf-profile.self.cycles-pp.mntput_no_expire
      0.02 ±142%      -0.0        0.00        perf-profile.self.cycles-pp.mem_cgroup_from_task
      0.07 ± 78%      -0.0        0.05 ±114%  perf-profile.self.cycles-pp.generic_perform_write
      0.02 ±144%      -0.0        0.00        perf-profile.self.cycles-pp.readdir64
      0.13 ± 57%      -0.0        0.11 ± 47%  perf-profile.self.cycles-pp.aa_file_perm
      0.18 ± 29%      -0.0        0.16 ± 25%  perf-profile.self.cycles-pp.__kmem_cache_alloc_node
      0.12 ± 43%      -0.0        0.10 ± 21%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.08 ± 35%      -0.0        0.07 ± 14%  perf-profile.self.cycles-pp.__switch_to_asm
      0.03 ±147%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.cap_vm_enough_memory
      0.02 ±142%      -0.0        0.00        perf-profile.self.cycles-pp.hrtimer_active
      0.02 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.map__put
      0.02 ±142%      -0.0        0.00        perf-profile.self.cycles-pp.mntput
      0.17 ± 30%      -0.0        0.15 ± 20%  perf-profile.self.cycles-pp.pid_nr_ns
      0.12 ± 39%      -0.0        0.10 ± 48%  perf-profile.self.cycles-pp.do_user_addr_fault
      0.03 ±155%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.blk_cgroup_congested
      0.02 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.____machine__findnew_thread
      0.02 ±141%      -0.0        0.00        perf-profile.self.cycles-pp.__get_vma_policy
      0.02 ±141%      -0.0        0.00        perf-profile.self.cycles-pp.task_prio
      0.02 ±141%      -0.0        0.00        perf-profile.self.cycles-pp.schedule
      0.02 ±141%      -0.0        0.00        perf-profile.self.cycles-pp.task_tick_fair
      0.02 ±141%      -0.0        0.00        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.13 ± 50%      -0.0        0.11 ± 17%  perf-profile.self.cycles-pp.proc_fill_cache
      0.07 ± 69%      -0.0        0.05 ±102%  perf-profile.self.cycles-pp.__perf_mmap__read_init
      0.18 ± 25%      -0.0        0.17 ± 29%  perf-profile.self.cycles-pp.blk_mq_queue_tag_busy_iter
      0.02 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.__x2apic_send_IPI_mask
      0.02 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.proc_single_open
      0.03 ±100%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.__list_add_valid
      0.12 ± 21%      -0.0        0.10 ± 24%  perf-profile.self.cycles-pp.try_charge_memcg
      0.06 ± 48%      -0.0        0.05 ± 74%  perf-profile.self.cycles-pp.evsel__compute_deltas
      0.08 ± 35%      -0.0        0.07 ± 50%  perf-profile.self.cycles-pp.__mod_lruvec_page_state
      0.05 ± 87%      -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.03 ±108%      -0.0        0.02 ±142%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.kallsyms__parse
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.module_get_kallsym
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.__dsos__findnew_link_by_longname_id
      0.03 ±100%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.native_sched_clock
      0.02 ±142%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.exit_to_user_mode_loop
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.perf_event_read
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.kfree
      0.04 ± 75%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.charge_memcg
      0.03 ±103%      -0.0        0.02 ±144%  perf-profile.self.cycles-pp.string
      0.04 ± 72%      -0.0        0.02 ± 99%  perf-profile.self.cycles-pp.unlink_anon_vmas
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.rb_insert_color
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.format_decode
      0.02 ±144%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.strlen
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.get_kthread_comm
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.rb_first
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.perf_evsel__read
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.__perf_sw_event
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.__cond_resched
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.anon_vma_clone
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.rw_verify_area
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.access_error
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.mpol_shared_policy_lookup
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.fclose
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.xyarray__entry
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.perf_event_ctx_lock_nested
      0.04 ±111%      -0.0        0.03 ±101%  perf-profile.self.cycles-pp.__perf_session__process_decomp_events
      0.11 ± 40%      -0.0        0.10 ± 14%  perf-profile.self.cycles-pp.release_pages
      0.11 ± 28%      -0.0        0.10 ± 16%  perf-profile.self.cycles-pp.update_curr
      0.06 ± 58%      -0.0        0.06 ± 45%  perf-profile.self.cycles-pp.unmap_single_vma
      0.05 ± 47%      -0.0        0.04 ± 71%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.io__get_hex
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.map__new
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.number
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.save_fpregs_to_fpstate
      0.02 ±144%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.apparmor_file_free_security
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.perf_env__arch
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.getname_flags
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.shmem_alloc_and_acct_folio
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.filp_close
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.__irqentry_text_end
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.put_prev_task_stop
      0.12 ± 29%      -0.0        0.12 ± 16%  perf-profile.self.cycles-pp.task_dump_owner
      0.11 ± 57%      -0.0        0.10 ± 33%  perf-profile.self.cycles-pp.process_simple
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.update_iter
      0.02 ±141%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.kmem_cache_alloc_lru
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.__vm_enough_memory
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.__comm_str__findnew
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.may_open
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.obj_cgroup_uncharge_pages
      0.02 ±141%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.mutex_unlock
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.perf_trace_sched_migrate_task
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.m_next
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.__update_load_avg_se
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.asm_exc_page_fault
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.ksys_read
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.do_mmap
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.finish_task_switch
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.asm_sysvec_call_function
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.try_to_wake_up
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.perf_event_mmap_event
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.do_set_pte
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.kmalloc_trace
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.add_wait_queue
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.__do_set_cpus_allowed
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.select_task_rq
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.vfs_readlink
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.file_ra_state_init
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.lockref_put_or_lock
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.rcu_all_qs
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.__check_heap_object
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.check_preempt_wakeup
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.acpi_ex_system_memory_space_handler
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.task_h_load
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.update_cfs_group
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.fdarray__filter
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.apparmor_file_alloc_security
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.migrate_task_rq_fair
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp._IO_file_close_it
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.cpu__max_cpu
      0.01 ±223%      -0.0        0.00        perf-profile.self.cycles-pp.malloc@plt
      0.09 ± 35%      -0.0        0.08 ± 22%  perf-profile.self.cycles-pp.pid_task
      0.06 ± 82%      -0.0        0.05 ± 46%  perf-profile.self.cycles-pp.wq_worker_comm
      0.11 ± 43%      -0.0        0.10 ± 15%  perf-profile.self.cycles-pp.errseq_sample
      0.02 ± 99%      -0.0        0.02 ±142%  perf-profile.self.cycles-pp.seq_read_iter
      0.02 ±149%      -0.0        0.02 ±141%  perf-profile.self.cycles-pp.folio_batch_move_lru
      0.02 ±141%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.kthread_data
      0.02 ±223%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.shmem_get_folio_gfp
      0.04 ±105%      -0.0        0.03 ±103%  perf-profile.self.cycles-pp.page_remove_rmap
      0.06 ± 70%      -0.0        0.06 ± 88%  perf-profile.self.cycles-pp.perf_mmap_to_page
      0.10 ± 39%      -0.0        0.10 ± 26%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.09 ± 36%      -0.0        0.09 ± 21%  perf-profile.self.cycles-pp.aa_get_task_label
      0.07 ± 53%      -0.0        0.06 ± 55%  perf-profile.self.cycles-pp.gather_stats
      0.11 ± 25%      -0.0        0.10 ± 18%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.04 ± 79%      -0.0        0.04 ± 75%  perf-profile.self.cycles-pp.thread_group_cputime
      0.12 ± 38%      -0.0        0.11 ± 25%  perf-profile.self.cycles-pp.do_syscall_64
      0.07 ± 35%      -0.0        0.07 ± 47%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.02 ±142%      -0.0        0.02 ±142%  perf-profile.self.cycles-pp.vfs_write
      0.01 ±223%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.num_to_str
      0.01 ±223%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.___slab_alloc
      0.05 ± 79%      -0.0        0.05 ± 86%  perf-profile.self.cycles-pp._raw_spin_trylock
      0.03 ±108%      -0.0        0.03 ±100%  perf-profile.self.cycles-pp.security_ptrace_access_check
      0.02 ±144%      -0.0        0.02 ±142%  perf-profile.self.cycles-pp.inode_to_bdi
      0.01 ±223%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp.rcu_nocb_try_bypass
      0.01 ±223%      -0.0        0.01 ±223%  perf-profile.self.cycles-pp._find_next_bit
      0.22 ± 54%      -0.0        0.21 ± 35%  perf-profile.self.cycles-pp.read_counters
      0.04 ±149%      -0.0        0.04 ±106%  perf-profile.self.cycles-pp.workingset_age_nonresident
      0.04 ± 73%      -0.0        0.04 ±102%  perf-profile.self.cycles-pp.check_move_unevictable_pages
      0.13 ± 32%      +0.0        0.13 ± 15%  perf-profile.self.cycles-pp.part_stat_read_all
      0.10 ± 36%      +0.0        0.10 ± 16%  perf-profile.self.cycles-pp.filemap_map_pages
      0.04 ±105%      +0.0        0.04 ± 71%  perf-profile.self.cycles-pp.vm_area_dup
      0.02 ±142%      +0.0        0.02 ±142%  perf-profile.self.cycles-pp.cfree
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.self.cycles-pp.mas_next_nentry
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.self.cycles-pp.shmem_write_begin
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.self.cycles-pp.switch_fpu_return
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.self.cycles-pp.__anon_vma_interval_tree_remove
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.self.cycles-pp.kmem_cache_free_bulk
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.self.cycles-pp.syscall_enter_from_user_mode
      0.14 ± 30%      +0.0        0.14 ± 31%  perf-profile.self.cycles-pp.strnlen_user
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.self.cycles-pp.mmap_region
      0.04 ±109%      +0.0        0.04 ± 73%  perf-profile.self.cycles-pp.__legitimize_mnt
      0.03 ±106%      +0.0        0.04 ± 71%  perf-profile.self.cycles-pp.xas_start
      0.18 ± 27%      +0.0        0.19 ± 15%  perf-profile.self.cycles-pp.generic_fillattr
      0.02 ±141%      +0.0        0.03 ±100%  perf-profile.self.cycles-pp.enqueue_entity
      0.02 ±141%      +0.0        0.02 ±149%  perf-profile.self.cycles-pp.ui_progress__update
      0.01 ±223%      +0.0        0.01 ±223%  perf-profile.self.cycles-pp.idle_cpu
      0.05 ± 77%      +0.0        0.05 ±105%  perf-profile.self.cycles-pp.atomic_read
      0.05 ± 85%      +0.0        0.05 ± 13%  perf-profile.self.cycles-pp.perf_read
      0.01 ±223%      +0.0        0.02 ±141%  perf-profile.self.cycles-pp.cap_ptrace_access_check
      0.33 ± 33%      +0.0        0.33 ± 19%  perf-profile.self.cycles-pp.inode_permission
      0.20 ± 52%      +0.0        0.21 ± 37%  perf-profile.self.cycles-pp.__handle_mm_fault
      0.10 ± 27%      +0.0        0.11 ±  4%  perf-profile.self.cycles-pp.malloc
      0.08 ± 59%      +0.0        0.09 ± 47%  perf-profile.self.cycles-pp.__alloc_pages
      0.01 ±223%      +0.0        0.02 ±223%  perf-profile.self.cycles-pp._find_next_and_bit
      0.05 ±104%      +0.0        0.05 ± 71%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.03 ±111%      +0.0        0.04 ± 70%  perf-profile.self.cycles-pp.pick_link
      0.06 ± 58%      +0.0        0.07 ± 19%  perf-profile.self.cycles-pp.find_next_iomem_res
      0.03 ±148%      +0.0        0.04 ± 72%  perf-profile.self.cycles-pp.__get_obj_cgroup_from_memcg
      0.01 ±223%      +0.0        0.02 ±141%  perf-profile.self.cycles-pp.__fsnotify_parent
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.free_percpu
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp._IO_setb
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.strtoll
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.sched_mm_cid_remote_clear
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.set_task_cpu
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.newidle_balance
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.sysvec_apic_timer_interrupt
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.__do_softirq
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.update_process_times
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.__bitmap_and
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.do_anonymous_page
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.down_read_trylock
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.pgd_ctor
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.strnlen
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp._IO_file_open
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.lockref_get_not_dead
      0.18 ± 19%      +0.0        0.19 ± 11%  perf-profile.self.cycles-pp.memcg_slab_post_alloc_hook
      0.13 ± 25%      +0.0        0.14 ± 13%  perf-profile.self.cycles-pp.__task_pid_nr_ns
      0.01 ±223%      +0.0        0.02 ±142%  perf-profile.self.cycles-pp.strncpy_from_user
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.open64
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.cpuidle_idle_call
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.__irq_exit_rcu
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.rcu_sched_clock_irq
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.update_rt_rq_load_avg
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.irqentry_enter_from_user_mode
      0.10 ± 42%      +0.0        0.11 ± 28%  perf-profile.self.cycles-pp.atime_needs_update
      0.03 ±101%      +0.0        0.04 ± 71%  perf-profile.self.cycles-pp.fsnotify_perm
      0.01 ±223%      +0.0        0.02 ±223%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.01 ±223%      +0.0        0.02 ±141%  perf-profile.self.cycles-pp.path_init
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.__hrtimer_run_queues
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.tsc_verify_tsc_adjust
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.irqtime_account_process_tick
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.tcp_orphan_count_sum
      0.09 ± 86%      +0.0        0.10 ± 58%  perf-profile.self.cycles-pp.evlist_cpu_iterator__next
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.read_tsc
      0.00            +0.0        0.01 ±223%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.02 ±142%      +0.0        0.03 ±103%  perf-profile.self.cycles-pp.smpboot_thread_fn
      0.03 ±103%      +0.0        0.05 ± 74%  perf-profile.self.cycles-pp.link_path_walk
      0.08 ± 50%      +0.0        0.09 ± 31%  perf-profile.self.cycles-pp.__call_rcu_common
      0.10 ± 17%      +0.0        0.11 ± 19%  perf-profile.self.cycles-pp.perf_iterate_sb
      0.00            +0.0        0.02 ±223%  perf-profile.self.cycles-pp.tick_sched_do_timer
      0.00            +0.0        0.02 ±223%  perf-profile.self.cycles-pp.run_posix_cpu_timers
      0.01 ±223%      +0.0        0.03 ±100%  perf-profile.self.cycles-pp.get_pid_task
      0.09 ± 30%      +0.0        0.10 ± 16%  perf-profile.self.cycles-pp.next_tgid
      0.00            +0.0        0.02 ±141%  perf-profile.self.cycles-pp._IO_link_in
      0.00            +0.0        0.02 ±223%  perf-profile.self.cycles-pp.rcu_pending
      0.00            +0.0        0.02 ±223%  perf-profile.self.cycles-pp.get_cpu_device
      0.05 ±117%      +0.0        0.07 ± 19%  perf-profile.self.cycles-pp.__libc_calloc
      0.12 ± 48%      +0.0        0.14 ± 71%  perf-profile.self.cycles-pp.record__pushfn
      0.10 ± 45%      +0.0        0.12 ± 30%  perf-profile.self.cycles-pp.clear_page_erms
      0.04 ±100%      +0.0        0.06 ± 50%  perf-profile.self.cycles-pp.__entry_text_start
      0.03 ±150%      +0.0        0.05 ± 49%  perf-profile.self.cycles-pp.__fput
      0.01 ±223%      +0.0        0.03 ±102%  perf-profile.self.cycles-pp.security_file_open
      0.00            +0.0        0.02 ±142%  perf-profile.self.cycles-pp.vprintk_emit
      0.00            +0.0        0.02 ±223%  perf-profile.self.cycles-pp.timekeeping_max_deferment
      0.00            +0.0        0.02 ±142%  perf-profile.self.cycles-pp.strscpy
      0.02 ±141%      +0.0        0.04 ± 71%  perf-profile.self.cycles-pp.perf_trace_sched_wakeup_template
      0.03 ±158%      +0.0        0.05 ± 75%  perf-profile.self.cycles-pp.ktime_get_coarse_real_ts64
      0.04 ±112%      +0.0        0.06 ± 77%  perf-profile.self.cycles-pp.kcpustat_cpu_fetch
      0.00            +0.0        0.02 ±223%  perf-profile.self.cycles-pp.rebalance_domains
      0.00            +0.0        0.02 ±223%  perf-profile.self.cycles-pp.scheduler_tick
      0.04 ± 77%      +0.0        0.06 ± 23%  perf-profile.self.cycles-pp.aa_may_ptrace
      0.10 ± 34%      +0.0        0.12 ± 21%  perf-profile.self.cycles-pp.__ptrace_may_access
      0.01 ±223%      +0.0        0.03 ±105%  perf-profile.self.cycles-pp._IO_file_doallocate
      0.06 ± 46%      +0.0        0.08 ± 23%  perf-profile.self.cycles-pp.getenv
      0.06 ± 60%      +0.0        0.08 ± 27%  perf-profile.self.cycles-pp.__memcg_kmem_charge_page
      0.03 ±101%      +0.0        0.05 ± 47%  perf-profile.self.cycles-pp.__kmem_cache_free
      0.35 ± 34%      +0.0        0.37 ± 23%  perf-profile.self.cycles-pp.pid_revalidate
      0.01 ±223%      +0.0        0.04 ± 71%  perf-profile.self.cycles-pp.cpuacct_charge
      0.07 ±104%      +0.0        0.09 ± 32%  perf-profile.self.cycles-pp.ordered_events__queue
      0.09 ± 34%      +0.0        0.12 ±  9%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      1.28 ± 36%      +0.0        1.30 ± 22%  perf-profile.self.cycles-pp.update_sg_wakeup_stats
      0.04 ±110%      +0.0        0.07 ± 57%  perf-profile.self.cycles-pp.rmqueue
      0.09 ± 31%      +0.0        0.12 ± 17%  perf-profile.self.cycles-pp.down_write
      0.07 ± 97%      +0.0        0.10 ± 30%  perf-profile.self.cycles-pp.apparmor_file_permission
      0.04 ± 71%      +0.0        0.06 ± 19%  perf-profile.self.cycles-pp.put_dec_trunc8
      0.00            +0.0        0.03 ±223%  perf-profile.self.cycles-pp.tick_nohz_next_event
      0.30 ± 30%      +0.0        0.33 ± 19%  perf-profile.self.cycles-pp.kmem_cache_free
      0.06 ± 50%      +0.0        0.10 ±143%  perf-profile.self.cycles-pp.__intel_pmu_enable_all
      0.07 ± 83%      +0.0        0.10 ±170%  perf-profile.self.cycles-pp.ktime_get
      0.00            +0.0        0.04 ± 71%  perf-profile.self.cycles-pp.memset@plt
      0.00            +0.0        0.04 ± 71%  perf-profile.self.cycles-pp.check_heap_object
      0.00            +0.0        0.04 ± 72%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.10 ± 35%      +0.0        0.14 ± 28%  perf-profile.self.cycles-pp.file_free_rcu
      0.29 ± 60%      +0.0        0.33 ± 43%  perf-profile.self.cycles-pp.shmem_write_end
      0.01 ±223%      +0.0        0.05 ± 72%  perf-profile.self.cycles-pp.exc_page_fault
      0.00            +0.0        0.04 ±223%  perf-profile.self.cycles-pp.__update_blocked_fair
      0.15 ± 29%      +0.0        0.19 ± 20%  perf-profile.self.cycles-pp.__schedule
      0.00            +0.0        0.04 ±105%  perf-profile.self.cycles-pp.__snprintf_chk
      0.00            +0.0        0.04 ± 73%  perf-profile.self.cycles-pp.mm_account_fault
      0.00            +0.0        0.04 ±128%  perf-profile.self.cycles-pp.load_balance
      0.00            +0.0        0.04 ± 74%  perf-profile.self.cycles-pp.memcg_account_kmem
      0.00            +0.0        0.04 ±171%  perf-profile.self.cycles-pp.update_sd_lb_stats
      0.05 ± 78%      +0.0        0.10 ± 83%  perf-profile.self.cycles-pp.evsel__read_counter
      0.23 ± 34%      +0.1        0.28 ± 17%  perf-profile.self.cycles-pp.__slab_free
      0.26 ± 29%      +0.1        0.32 ± 17%  perf-profile.self.cycles-pp.do_dentry_open
      0.00            +0.1        0.05 ±223%  perf-profile.self.cycles-pp.menu_select
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.copyout
      0.00            +0.1        0.05 ± 84%  perf-profile.self.cycles-pp.mm_init
      0.00            +0.1        0.06 ± 61%  perf-profile.self.cycles-pp.get_cpu_sleep_time_us
      0.18 ± 27%      +0.1        0.24 ±  6%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.13 ± 44%      +0.1        0.20 ± 28%  perf-profile.self.cycles-pp.get_mem_cgroup_from_mm
      1.38 ± 27%      +0.1        1.45 ± 16%  perf-profile.self.cycles-pp.do_task_stat
      0.00            +0.1        0.07 ± 23%  perf-profile.self.cycles-pp._IO_fread
      0.56 ± 56%      +0.1        0.63 ± 67%  perf-profile.self.cycles-pp.fault_in_readable
      0.01 ±223%      +0.1        0.09 ± 20%  perf-profile.self.cycles-pp.__kmem_cache_alloc_bulk
      0.01 ±223%      +0.1        0.09 ± 13%  perf-profile.self.cycles-pp.mas_wr_node_store
      0.64 ± 39%      +0.1        0.72 ± 19%  perf-profile.self.cycles-pp.__percpu_counter_sum
      0.14 ±110%      +0.1        0.23 ±129%  perf-profile.self.cycles-pp.__pthread_disable_asynccancel
      0.00            +0.1        0.09 ± 27%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.04 ±168%      +0.1        0.13 ±169%  perf-profile.self.cycles-pp.find_busiest_queue
      0.45 ± 41%      +0.1        0.55 ± 22%  perf-profile.self.cycles-pp.pcpu_alloc
      0.33 ± 70%      +0.1        0.45 ± 85%  perf-profile.self.cycles-pp.ring_buffer_read_head
      0.12 ± 53%      +0.1        0.24 ± 63%  perf-profile.self.cycles-pp.evlist__id2evsel
      0.00            +0.1        0.14 ±223%  perf-profile.self.cycles-pp.cpuidle_enter_state
      0.00            +0.2        0.22 ± 39%  perf-profile.self.cycles-pp.mm_init_cid
      0.00            +0.3        0.25 ± 29%  perf-profile.self.cycles-pp.mtree_range_walk
      0.33 ± 39%      +0.3        0.65 ± 23%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      0.03 ±223%      +0.4        0.40 ±198%  perf-profile.self.cycles-pp.intel_idle
      0.00            +0.4        0.45 ± 13%  perf-profile.self.cycles-pp.__memcpy
      0.00            +0.6        0.60 ± 23%  perf-profile.self.cycles-pp.__memset
      0.02 ±223%      +0.6        0.66 ±200%  perf-profile.self.cycles-pp.intel_idle_xstate
      0.52 ± 72%      +1.0        1.51 ±125%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.00            +1.1        1.11 ± 21%  perf-profile.self.cycles-pp.task_mm_cid_work
      0.00            +2.0        2.04 ± 58%  perf-profile.self.cycles-pp.copyin
     37.64 ± 48%     +11.6       49.20 ± 10%  perf-profile.self.cycles-pp.queue_event


> 
> Thanks
> - Raghu
> 
> 
> 
