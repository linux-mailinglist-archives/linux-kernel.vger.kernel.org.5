Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B6079C63D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 07:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjILFVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 01:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjILFVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 01:21:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF6DAA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 22:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694496070; x=1726032070;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=6HAPzzp+WI4hanldbanXXMFxECIt0KxYRSh1hUdSpKs=;
  b=WWbG0ep72srzCFmHcPM/xujouHlPaNPafOe6iUTnOz/v97iu7N5D8vWW
   QzkWwsAUher6OknP2JaaLI18mUPw+tfc5kKphA57zTdIBDkA9HenCxHsD
   RTrmYwhKv08yDQKJ/mCeR7jfKE/iEm/6nxHsjNzaliwsKjIkmhwpL7QmA
   lF7ebaDr4a1Y/CZmpxZRBfn6tuhqoMDnx3lWuZl2xD74MvnVKxcGWU7Fk
   UbT0HRbTnjH+ZizJ2GwPPZlSrQ/zSGgJbWCEIhoIHumykaAqxD+b4AQZW
   OKmp8Ybqfsb23mtSlJW370J0uYRO7euGOIvKAbOUc+OUgEADm8DBT0a66
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378188103"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="378188103"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 22:21:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="772856959"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="772856959"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Sep 2023 22:21:09 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 22:21:09 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 22:21:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 22:21:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 22:21:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lViBslY/x7ETo0XgoNK14FLqH2z8kDGbfYMQqrOlLkywnLLVJGMYyk1e9eYjk1oANXJnMDSnJO0RJiVvNZ91nl/TgvrqKSEO+EAcaAobjhxKWYmi3CQXrxiBBUruXCFyxFEKcAHcExS0P2BoGP0mQe81acSDtfEBlxII54DTdP9TKsgAFoegi9kOIy13BLrGdMIFGyqZfvi63dKwtylCNEzIFOcyOHei6oW4zWr2Njep+fzL1S1vX5SwcfqyaMWdOCx2bMIXhwcpPVN6gKCPHFR0Noo7ucvcWUiZH45gkpKT/n1i74sHhQ2Eg8jsPO+deSxrl/Jne6XtSCHdR4yAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGiRJKuXviff+W0aA2ayxpWjQJZ21fKOdEEPH4nvVKs=;
 b=g4zWg4eH9Vjf5g4ky6myfmS8LWpV8yvRFTLl8SqtctGQgJzOuOgr9/FlAnVlHWmFjafxEVM3Wh48jg1u67Kg5tC1PnNijQmtmRwgM+TDQ+v0uVVmdS3NoAcwwETBW+ES+cwHqEJAqwg2kVCsADxBvi0DkNHe+sbCqtEROhIFYBxpQyv1wzREdoWz70xHauKM+vEd7eHravRWtd6VUyBAKDaDkvlp2BBOPhPsOva1nP+lia/0Gkw/FbF1wideJzOcJGDrmyWnwPuhbHLqeav8eEG/U31609WMNKpEXUFRPxSnR12A6eJC+spuaiNy2qEAIeQ9vKmztVq2A687Xhg4+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by BN9PR11MB5226.namprd11.prod.outlook.com (2603:10b6:408:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 05:21:06 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::73c6:1231:e700:924%4]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 05:21:06 +0000
Date:   Tue, 12 Sep 2023 13:20:55 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Edward AD <eadavis@sina.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-mm@kvack.org>,
        <ltp@lists.linux.it>,
        <syzbot+b591856e0f0139f83023@syzkaller.appspotmail.com>,
        <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <syzkaller-bugs@googlegroups.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH] mm: as the same logic with queue_pages_range
Message-ID: <202309121302.8864096c-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230906061902.591996-1-eadavis@sina.com>
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|BN9PR11MB5226:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e91ba84-27c4-4a37-a794-08dbb35010f8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vUIqxJj5NaHXk2c4BUvlA35X43I9mBfb9FJpAaUvF6ABE1fyC2ppGxPLjEi4tQ+VD3qq4t2WZfONhtqFGvp4xZNcNSQc+ybL8iYI+P3D7i9z14YeuB/0HbUkYptIG1T/5+YamDboZHn9CUWA9tJcQuuZ1PHjlzQwjk2ymuVKslbJxJHZ4z4jM/nXTgVfs54tr9xKpwzA5g70jLA1jiY+i6+PU1Io7xmzQEhzcs84wgmlE3rQfld4sbj7zWAU7IhvX2mRuM3I6xIGadyA2i3O2sYRkdCNIo2FJ+uzxIqxYKm0wHtk36GhGdqvdw0AHs3fF+RIWVO5JgfDwE+pIjo4MGgL0iyRVV4Ib9MrDzb3+iVxrXj+nZ509YuliG4tkiifbz30DegXdgSn56rgMPm++xpHtaGexCQogObXrGN99LTkwiiLsQIrLibZpyUjqJno194Bh3gP6oIfSohKbeyLRw84YJejVDaftWvdpqsf+SHMHjMQ/CHHfnshriXfQ20ip7009+IAbxZVvQoq2GPoIzsIdur5SNSvSqvsfA823Ocfnb57YXrZ6Ybq1KcSZP2nawFef8wN5j5EKpHIBLcAQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(366004)(136003)(39860400002)(1800799009)(186009)(451199024)(26005)(2906002)(83380400001)(6486002)(86362001)(6506007)(107886003)(2616005)(6512007)(6666004)(82960400001)(38100700002)(1076003)(966005)(478600001)(36756003)(5660300002)(4326008)(8676002)(8936002)(66476007)(66556008)(316002)(6916009)(66946007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+DX5M2Im76JYoAUL+XJ+3nnDJTI45X8tG5+LwuTRedS1mHt5ty/XcZElX1Ww?=
 =?us-ascii?Q?lbxFrAmgIJgqmo82U+RuB+cpj2WlgQsz1kKICZJjgxE3A7kWbVTPkfAnMB+2?=
 =?us-ascii?Q?yKE5t7KnbKDxakhdnkNjFpdp0DmwEsoTqrFEDVzNu6rvh6CMw3fYN0DvMNWc?=
 =?us-ascii?Q?ADwyiALohmsoJpaEqrHeTEFZQXKi/c9U0q5J3PbX7T11TS55apQkfHI///b/?=
 =?us-ascii?Q?3QtnRAIGJZ46SR+shwl0RjJiR5JXM3sOggc++XrMXO2SjcQfnS+O3mBG0ZYE?=
 =?us-ascii?Q?uatd6MgSNmA36UpYeTlir8rDAAXch56ZGEh288XnyU0A8dRiTIzcqufF2jmr?=
 =?us-ascii?Q?AfgBZFhhO92ifTvh++XZ9cWCmg8dM1buJXV2nzE/GMv8/Rt8CeOvHRJACTMT?=
 =?us-ascii?Q?mB2BzPkdHPTwmlHYNONqdC4KHTU7G6LGx5C9WXCYqlc4bzzlLDFcunNUunmj?=
 =?us-ascii?Q?ChYvbZK/ij4dyJ/8uq/+RSO4rOji+l35Q7xu8y8aMgY0XYLoOAJNOjqmYwor?=
 =?us-ascii?Q?QAzbmdinr3j5KqTCd+gG9QmZKnJzzneOPqFi7bjTaEuQFrO7SJCeuWnsuSq0?=
 =?us-ascii?Q?l6coezk4j7LrHGwdIk87/thIvi0ar+HeDtC9FL8NczhPBPfTs9pWO7xolCUh?=
 =?us-ascii?Q?dyuR9VOj5h6IwLJu5KB4196zgPGu5fNPe2M29rnofHcGhEr/9asCDoDFb4VR?=
 =?us-ascii?Q?xHK6vu0Q8u9w49jl22kf9Q063WbhGqjaqqtYWN9vtije/JKQfQtw3rN8dskI?=
 =?us-ascii?Q?HD/VVA4SHZeTY/tWrQB2DbfCLlvXdKsp6rux9QK0iq77gIub8fyQ022PjX2K?=
 =?us-ascii?Q?A5DCb6gwWACu3jfkvWmSM4CWxSWxKDmwIgRhrl3MBQDibvEIPo4ns0xf2sJy?=
 =?us-ascii?Q?GdlXpLOR4AUlZLj8A3siu09WngrLd2kREEpVV8RBUc1ZgeYsaA+hl5rk4kFr?=
 =?us-ascii?Q?oNfZWez3iYg3OxcnQWz3AwMDcxcAqBpB5neUKlJwhQzWl7VkHeH56ztpIvHB?=
 =?us-ascii?Q?5NJ4Qzo9I6Es8LY+MZNlk+AZ9e74OI3qAB+IPoGj8aQ4gTqpJLDlv1pV4YwK?=
 =?us-ascii?Q?Iyk1PAw2g5OvW0bzst8HGnoy8IvMT0Iv3qxoRPFzA+TC0M0D5mk+XgcyAO+G?=
 =?us-ascii?Q?vhZ9ilOFotdrFBjoUIl/VD5XgueEapzKPV1YlYO7b+SmJSOVyteAXKg7QMgk?=
 =?us-ascii?Q?UmXRyycJ6d1zfVu5H/A8Kydlnz7S6b/BHbsqb71Rh0Ut7Vh6gi+OdGBNqYYn?=
 =?us-ascii?Q?4jEpBawOl+XIP1h3LHNBRWvuC9EEXTjpQEZjHokxw/dK86OLFLSqCW5sEUbZ?=
 =?us-ascii?Q?KfmGcuu4ks3twqNaaqAoxJ+wOUDHCBuORuHPl+mFlLHxw/fz75u1iVa19QXA?=
 =?us-ascii?Q?kABMCYX0nP+dVmnfcBcld+HRWiUw911xv63mt39qWGMxyqL8sxIt/a/dCy8O?=
 =?us-ascii?Q?GIYR9hIbW8iVXB7Ewke3NHOedUmTBKltzD0P2yzZlU9s1xsibEpQaELno56+?=
 =?us-ascii?Q?ojpzhkHIZDKrvINPyfn9b5jLG8+AOAyoXDln8sTjviEWfiWrMKJxGbF6m/QE?=
 =?us-ascii?Q?frKdx2Ad7K9lt2on84YHZ6zQ5GPPEIU0TRWK4klhaS4he2HlyJ8xy4yDm5bk?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e91ba84-27c4-4a37-a794-08dbb35010f8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 05:21:06.7651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awq3kra8p3o/Y6HBa+fDo7tnQTesVVMLj7bltgrUOMhNeOUGhwFRDckADJDOqVugjSrzo05rz7kNh3zCjY7jXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5226
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "ltp.vma02.fail" on:

commit: 8dfdaf99160833af1a0a4ffef60c94627c77025b ("[PATCH] mm: as the same logic with queue_pages_range")
url: https://github.com/intel-lab-lkp/linux/commits/Edward-AD/mm-as-the-same-logic-with-queue_pages_range/20230906-142110
base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-everything
patch link: https://lore.kernel.org/all/20230906061902.591996-1-eadavis@sina.com/
patch subject: [PATCH] mm: as the same logic with queue_pages_range

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20230715
with following parameters:

	disk: 1HDD
	test: mm-00/vma02



compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (Kaby Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202309121302.8864096c-oliver.sang@intel.com



Running tests.......
<<<test_start>>>
tag=vma02 stime=1694438526
cmdline="vma02"
contacts=""
analysis=exit
<<<test_output>>>
vma02       0  TINFO  :  pid = 3639 addr = 0x7f5202dd6000
vma02       0  TINFO  :  start = 0x7f5202dd6000, end = 0x7f5202dd7000
vma02       0  TINFO  :  start = 0x7f5202dd7000, end = 0x7f5202dd8000
vma02       0  TINFO  :  start = 0x7f5202dd8000, end = 0x7f5202dd9000
vma02       1  TFAIL  :  vma02.c:144: >1 unmerged VMAs.
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=7
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20230516-75-g2e582e743

       ###############################################################

            Done executing testcases.
            LTP Version:  20230516-75-g2e582e743
       ###############################################################




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20230912/202309121302.8864096c-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

