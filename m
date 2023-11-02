Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A1A7DE947
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 01:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbjKBA0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 20:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjKBAZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 20:25:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0640C113;
        Wed,  1 Nov 2023 17:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698884754; x=1730420754;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UXMsHwWgaVoeRUIEDSLAewg5VJbEZjiPsB221wHdp9Y=;
  b=njE9tZVmR4aWRxFS0gfefP4LUD1DSs1pfb/9M+eL3RC3VOokUaanwncI
   6EgHSy9j//DF0e89oStMWNwp7zUbe72e582hEoDtFFTWiwtIgbHVogvIb
   I7VIPIOobbzcxB+PW9jl1KC72sILsr0ImrCVfs71t4uBbYKsI50oaQ17/
   Y4h4buvvT8FeWFDHePxeBV+xqhjiOyk7lcNXvWuOIQXnJv8FNMtV3xKFr
   kUMdViR5sMR8JSGsOLeOXK3f+V1tCZdfkZuWYouNeaL4grKHEA8IvdKaF
   TusFjYbcqej/Y288nPlEBrxkU74scg/H0emMm/kQUp15FR7+jWuhM91Ma
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="1525042"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="1525042"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 17:25:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="934613645"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="934613645"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2023 17:25:42 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 17:25:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 1 Nov 2023 17:25:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 1 Nov 2023 17:25:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCMoI1hpEasMlxeD3AKuf4B2kUCcGV/X6wWPUAo6zwyiZkl71NkCV+XA2nd5ziBnfLiguqcmkhT1INyMh5pXGviFVOB6bi/8rCQMc/fCxE0bSvtMEjYmXO9h/ABztu3kro7u06XR65TMg6ywEUf5XRkj4hpPDWcSL3Ix2eb9QUYH8qmy2fgu/KvNvyNrE9/2M2k2jnxbCASmoHVm5YFi9vjYcQRHVmGaiIwyVOdtnGCIi72vnCF3KNeiTzsft53FokduFupPQpyTESyRlWlFiXF6NqUDkTJNFFRe2QdL7S3/+NATgyRhROZtPKRkNuKPgDimFhYbRdwBPqJI0EIeSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/mOr3AeQGqwCWzIQNqw0tyUYb2/9fhm2S/eE9hDvRU=;
 b=RW3dMEPho/gukVH8MDDu96qQ6T4uXSKmf6jMHoAcFJNtAcgx8shjuGC8XXRy4ou84zsuWQ+Z8RjjcOmbZm5FMgsTcGGAwmgCGobNF93VTepcCp0O31/L82RQ62EBzouI07dTHB+fL2STcxpua/FrESOzl1zxDcQK+szNVgjbD2iOFigAen08rQwUv0cBPrxkZXAUoaiGD1ekkHB4OO42hS9aiMztyzVGQLk0l+AjCVll8MTHRqnbXJeZj8kU49EoKEzSGjX2buDxLABy1F37rSJrn1wCNrzZ08zTKNHpwJ8DXqxaewJuNALGTotPrWdxWI6gT2X0tK+ktzhqH7qoEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL1PR11MB5429.namprd11.prod.outlook.com (2603:10b6:208:30b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 00:25:33 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d3b2:2f2:701e:e8c7]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::d3b2:2f2:701e:e8c7%4]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 00:25:33 +0000
Date:   Wed, 1 Nov 2023 17:25:30 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: [GIT PULL] NVDIMM for 6.7
Message-ID: <6542ec7ae6233_4dfae294bb@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: BYAPR11CA0054.namprd11.prod.outlook.com
 (2603:10b6:a03:80::31) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL1PR11MB5429:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e16b8cd-2433-44ae-6f62-08dbdb3a3a58
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HhUdu1llsYVgTQHLLFbNHLKdAcOb0cC+t/XX6DtHIlF2u0kVD682f6dVotcCUp5Hx5tEN+5hYTYnQ+lGylH7WExtgbrUn2yIlaRtWkatTh3LE0gc+MUgTmNggltxBTWaHoAvgVjkC0r6cNrM0qRJt+qwxVAaNclnOgaWMiJHblv+RhOL4Nia/4HeHSV0Rjk4+jT9kNG4BCwN9eb/StzTvdR1LF0LES7ZDjhq73yvr6bmFHV1Gb4Us79Tt54xSbjWJb1whVRhv1qBEYLYF7odFtsscOiCbeGq+EuQ71L6dQEJrPPVuKsacPgT0WQ6ch3xHAJGWdDZdHEhyFMbajQieY8h6JZlDvWEu7JNieHAr3/j3AdEqAFz9fsmYiShH/wiizc0CNPKD3MKlJL/eA1I8sK/zxprMWnYHIIMc1jRc2PxikYexBoN2u7oe1yXJcd34XKnHsH6p0YsnNn0lfPQrccXKZ3Ws/1RvfWUNwGKAOZ27/nLt2A8vcJvOkvcrc8JprXeon1SSzQqfThFzgRiI4VooCIClzyUzzRPXMNbpa9cXAYLNe22QS4x6O4qw5Zaau8/IvCrUIBg/NEtpi8nBqPsa5SwpMzvMzqohaA8BhdTSAMX5DSi6dnFrm7/c8GI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(346002)(376002)(366004)(230173577357003)(230273577357003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(9686003)(6512007)(26005)(38100700002)(86362001)(82960400001)(2906002)(4001150100001)(83380400001)(478600001)(6506007)(8676002)(4326008)(6486002)(8936002)(66476007)(66556008)(54906003)(6916009)(316002)(5660300002)(44832011)(41300700001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e702SIlEcBacItQ3sif//duo9OsBSmxo5Q5DqIrxAtrT2BWiV1NxcsQJcjAa?=
 =?us-ascii?Q?EOf6FhZX3YqfIEDGck46VZyA0gn09AR04tijxEsTXa4sy4xmHQkACDquO91F?=
 =?us-ascii?Q?RDd7nALCRShRZZmma0KZH/Du16tkyNOn/QgObf/Onf7Mclyo1ovi/hzN4PAn?=
 =?us-ascii?Q?edg4GJrtGCaBcQDOwntH8kz+Uf8yD0oXKxkIDr9RP6qANhJGFzE7/ZoHF6h2?=
 =?us-ascii?Q?Lf1/jk4VzJYt/c2qs/PCGTHIgALriGqsgOycupUuKuo9iMm0vjyOSQulYzDc?=
 =?us-ascii?Q?puEtvaZPOOWpS6p1/lRk8XOr+FI9GMZs7514izXuPUewgriEfz72hbapl6P+?=
 =?us-ascii?Q?8LveKkA90Y5WfExzt8pYGyHggviQeCF+VNrjebOKhzk6eWbEUothe5A26vGX?=
 =?us-ascii?Q?5bBJTAp15S+snLn9wg1kDdHYaRg1R9QuaBseUQaX9G0lsY/PZwNJ0Y03ZGzk?=
 =?us-ascii?Q?30tT9z5+VLI2RgirzA92Y3OpoEKraEaNgozqmgVRM7jGdt6LW3IOmla7DXQU?=
 =?us-ascii?Q?Wr2y9wV9wTjw7jYTB1a+4AUnOqIsrifYXm4r1di8fTsaHVpEBr6aE8rGMEGS?=
 =?us-ascii?Q?jzZdr3ar1s9JSdGN0mMc5WThPiXJSwAwUKEN2srlJOQhVoEbtVQ9UmeLfIin?=
 =?us-ascii?Q?no4st61dHmBHzYv/BTW3ZTvXHYz4HTwqWZRv0S2MqJzTL2V7LS2hbgR9Swib?=
 =?us-ascii?Q?YI5RAKzAktKNSc45vN7AgPtcKrzBxOc3w5cILrsIg2QI7FaHMqOOmUhJlYk8?=
 =?us-ascii?Q?l6N2cC/wQciAVB8yTz8JWkggEGGrhWZwEUO1uJpMosHwJufdcQ9KD9W2lTyj?=
 =?us-ascii?Q?w1N7gPPpCwicDtopT8Bp6msyk5VXlkKoa0M59wJt2Y3mxjHDEgHwy4bzf1gq?=
 =?us-ascii?Q?ZwcC7Mi21DbYIBHKJ5kdxYPFM1dfZiYQi68A6e0CixaYLRpJiA+pjCeqhla8?=
 =?us-ascii?Q?VDbZNOlsAh64xQfWZ4N1FgZo4ZUp+3CchbAP/33d6p00T6Ed+YTLhJo75lNr?=
 =?us-ascii?Q?yOLZW8iZ1Cklo7vva57yEQBGczZGFJhA0rZgseowvdYjLc85K9a1rucZH0+x?=
 =?us-ascii?Q?BY1l3YSF3EwNr3VlCYyK/LXBNyzuIo9DhJ6TBFkYgGjXxruls48GHfbp6ZVG?=
 =?us-ascii?Q?HrEKsazZJ0Kh/gWE9Jn1AL+UJxulbWcVNQC1nGgpK8RCEvUcvxfbv4HPgon9?=
 =?us-ascii?Q?CNq47yZ8TX71nrSmsMIzCYC2I8Zuv/XuH6khrZHFjOAbsKPMysxmBW0oFDvd?=
 =?us-ascii?Q?4X1wcLmgiPlc1r5UU0PPD4Jn3uW8helq6DpwLqMAkn9HOyRyPX2q5IR0oN9e?=
 =?us-ascii?Q?hPehNmqZjWMePrMgNOFvlU0o85gX4e1NwsXjryFxz7aHRY21iMwNXTnzJ5O/?=
 =?us-ascii?Q?Zviqqw9hZwL3V67UJNnZ/aktJJ20IPDfX0SHYC7RsO6EnnrePHhnp4MijMWD?=
 =?us-ascii?Q?4xs3xjHZxxYUqcvHaDhiYb0QCU7fGjWcVo37+j2wuBmG5bMKQu3yhIp6D58J?=
 =?us-ascii?Q?VxCBhvPMefGwHG8OiLElNe+Z9xMDBAajwfQwKqCwfvvLFtiv/BiSTTcA2JGP?=
 =?us-ascii?Q?iKSlBaINuqavNSmghNGt0iXduQIeBuCwCsGHBaQo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e16b8cd-2433-44ae-6f62-08dbdb3a3a58
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 00:25:33.7954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4RtvzVPq+M1EZ5tP1WzLh7aL58ulxSJeHJPeRku9hALuvG6dRxuePbN7z9vbYQ+ij+IRQMpk7c8NZNVxoLGmzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5429
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git tags/libnvdimm-for-6.7

... to get updates to the nvdimm tree.  They are a mix of bug fixes and updates
to interfaces used by nvdimm.

Bug fixes include:
	Fix a sleep during spinlock in PREEMPT_RT kernels when getting a BTT
		lane
	Check for kstrdup memory failure in region probe
	Use the correct variables in the nvdimm_badblocks_populate() kdoc block

Updates to interfaces include:
	Use devm_kstrdup to manage memory better
	Allow class structures to be declared at build time
	Start using __counted_by to help with bounds checking
	Remove use of the deprecated strncpy

They have all been in -next for more than a week with no reported issues.

---

The following changes since commit 6465e260f48790807eef06b583b38ca9789b6072:

  Linux 6.6-rc3 (2023-09-24 14:31:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git tags/libnvdimm-for-6.7

for you to fetch changes up to 9ea459e477dc09370cdd8ee13b61aefe8cd1f20a:

  libnvdimm: remove kernel-doc warnings: (2023-10-18 09:48:05 -0700)

----------------------------------------------------------------
libnvdimm updates for v6.7

- updates to deprecated and changed interfaces
- bug/kdoc fixes

----------------------------------------------------------------
Chen Ni (1):
      libnvdimm/of_pmem: Use devm_kstrdup instead of kstrdup and check its return value

Greg Kroah-Hartman (1):
      testing: nvdimm: make struct class structures constant

Justin Stitt (1):
      dax: refactor deprecated strncpy

Kees Cook (1):
      libnvdimm: Annotate struct nd_region with __counted_by

Tomas Glozar (1):
      nd_btt: Make BTT lanes preemptible

Zhu Wang (1):
      libnvdimm: remove kernel-doc warnings:

 drivers/dax/bus.c                  |  2 +-
 drivers/nvdimm/badrange.c          |  4 ++--
 drivers/nvdimm/nd.h                |  2 +-
 drivers/nvdimm/of_pmem.c           |  8 +++++++-
 drivers/nvdimm/region_devs.c       | 10 +++++-----
 tools/testing/nvdimm/test/ndtest.c | 17 +++++++++--------
 tools/testing/nvdimm/test/nfit.c   | 14 +++++++-------
 7 files changed, 32 insertions(+), 25 deletions(-)
