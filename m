Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AC57EBB16
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 03:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbjKOCHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 21:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKOCHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 21:07:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93CEC7;
        Tue, 14 Nov 2023 18:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700014050; x=1731550050;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=Cm+bjr+YiwMUv5UwbUUc1rG3fmR/GpyzWJGi83JqJ08=;
  b=ZjuzytelpMEbzMizJtwoOtMIAPCFlrlPsJFnFjIfLg4L6E2tpwJSHA3U
   FGTy8jlBKCTriP9qZ2XFlSltYAmZH0GoHaYK1HGujmGn9pSjG9E5c7aCS
   FA+0DlIW7XMuYiu8JeipLo8i6fRbZ9EhPBOot661zE5VVv+3FsgUijb3V
   BV1bRWVEKmaPQi6muKR/y+pAZzNu0GRWNH6MZxyDArq8g9w9rJavBf59F
   rFPYffWdNDttPd1T2ScfOhQ+tldib+wPSlmSdq6qpQM8bCNFAUCgSuuEs
   yp5zl50NXK8H02GQCZ2eeIS5wCiLHl8ppOdNMmhd8GoaTN4sIZDjhFybN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="387957525"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="387957525"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 18:07:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="768447471"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="768447471"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2023 18:07:30 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 18:07:29 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 18:07:29 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 18:07:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3IsTA7txizY9MwYhgxNMpPoSiFipkWaU6ZlCz4rCB61wPjnDEvN9i75215jXHmog+6n+Hbwp4i6TFx+LHWDlIBLLxSHD1GAINARGWK+MiGT3PungVP+SagqfhAwmu1NsF/qcBBDfUiTQvI4nxcCksP2LNGsuDWeCGKymhYGxG7BFbwWMtVCvLJfg4rdUJYnhudAYuc0D5UpQw8Vpet+CKv/3iBzpQD8URja1ZHPGaHKvfF/8AiJoUalYu7f9Cn1IJ7Tg/Qqq39M+T5KKIWKIqfEsdjfZ4NuKgqH8UQ+Yt427+wAedxWXF3oyAl5JHnSiwKrEI6N4O4B9kfzUZ1P+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztyTn8IQYsE9FbFKD35UoinO6XqXr195eO8u4TI42wg=;
 b=XgHEirJ1rWW+9E1I4u09pDIPBN28cP641fPYi/3fws7y91vTYwkHdJT+2dPcv38jEU+bIYaT49ne6mIm6BOa6tECQ1Lb6LUxuI71JVo2Hxcy0xsBCKn0oUT2S03hgk4T9/32cynzEqshhN/tpV1F26r5IMkkP7Zkwa4NkimwwCNJ2VkJuuN+J8piM0hsuOqvpwT0WRc3lyLgtg9XjyBX6khR8wpiY0az0eDiwPdGZrG7n4xLOddybVvkZFKb9FiRsG32zDzV1Vvs5SzCVtSjkCtX/lRoOyDX8SyHqkLLJhUZ2dFhzH7WpK/OGdpDVF6Rd6VB02NimjGIu6lKBRhcKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by LV2PR11MB6045.namprd11.prod.outlook.com (2603:10b6:408:17b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 02:07:27 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.6933.028; Wed, 15 Nov 2023
 02:07:26 +0000
Date:   Wed, 15 Nov 2023 10:02:40 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <oe-kbuild-all@lists.linux.dev>,
        Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] perf: starfive: Add StarLink PMU support
Message-ID: <202311142041.nSLDeqju-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231114021254.3009799-2-jisheng.teoh@starfivetech.com>
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|LV2PR11MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: db88be32-4fcc-44da-c3f1-08dbe57f9d4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kMa7rtRfW4Kx4kOZRyjX41cHwVST3bc+URO85i3xltVzYy5mA8DckiHZSrLMlUdaiqoIB336hGYtli4ljm9lEYXenq8xecceRCm2zcVLwbG+83s2dsaDIiw6OF/C45mmAsHg3vTj1UiNfnRZmAotPvT7B+sAMVX5iTKHJANqaUug9yte7ZxHzb6djMPj1vau8TXPy02Pwxnulfg8bAadx9sQf79c04V0dzabiclZf2bVOIOEr6lFfza3hZaA+EdCel+XRq/WJYFzy9Eouu3QI67dW890+znUlwZ9BMTLMWEjhz9X1Q827KAVJ1yRvOH5c3eiIEEHTlPMpEgXwKzciWThpCiHlWH/y9kilZHqrhA04Nrb7stqxR2bHhTva4BuHWgMIrD1AHUNLAJEE/fpKyD3/hBLyvMrKwho0rQ7TS2kb/Z09Ot4OcEIt2ASmL4KWqG8Y2aXU0NIoBfLj6ckmTFGVWPCfzdBxIJRY0cK99HTu8NJw/1zCOIvFrCuA/6UgTocoIn+bciBaej0wF8sYERWx4OtX/tyfKqe52IPxqn75Lf5JQLtPOGyLY3Wa/3rxNeCQNc40T0AWpbG58gQtwFMShrkEBClJZQD27lvvEFNS3QxxrCMBW0vN1VmPVp/wZPvjkZBhbZSIZxzcdQ0YQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(396003)(366004)(230273577357003)(230922051799003)(230173577357003)(64100799003)(451199024)(1800799009)(186009)(86362001)(83380400001)(38100700002)(66476007)(82960400001)(66946007)(316002)(66556008)(110136005)(54906003)(8936002)(36756003)(6666004)(6512007)(2616005)(1076003)(26005)(478600001)(6486002)(966005)(41300700001)(4001150100001)(7416002)(2906002)(6506007)(4326008)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BmOBQlV60KNBmkPrWUgnUUXDnpLCc8iwKcYKz63hPiFyz1kXWVF2qciKwnYR?=
 =?us-ascii?Q?lcYzVxPXkdFxIkrZtA2ekB9KpzrYQO/RQrwIg4oCtK5wXU00Ena6ds56lzIt?=
 =?us-ascii?Q?OOyg9FrzARt7KOJjaaXj0Vqqq/kVEX4b4YWY7MeFl1Omhx9kqf82nNyuSXnO?=
 =?us-ascii?Q?vTACtFuCOmn0VBTFkn1AgLgtBEMxi/TQff4ip6A+ctI8zlcQzyq9k1Nhpcvt?=
 =?us-ascii?Q?qorlX3RgZv1Hqty2KJO8JLTm4N4P8U6rpKEpUUI6qpukBgq6Q0PQEA63QQKa?=
 =?us-ascii?Q?SnSxP+tS580DP2JOCPHxBBedTfb/3AHLIti5s+zkSdKRITbHzXye2GSXGbT+?=
 =?us-ascii?Q?/HWk/mGymgbvoXu4LSvgq5gRF+RuGH/OYbByw52U+jnLhIO/57eX2ONMZT78?=
 =?us-ascii?Q?SFcR4MZ2JISa4oL7w+gvkAoliy6U7xCQPjW/C+hyhIWpY/2iPayQ0uCfx4qU?=
 =?us-ascii?Q?mP4otfKwbItkuUqCIjyju0cIGRJCOgSFnb6MT/Gxv/qGHGE9UpokpkI/mKqd?=
 =?us-ascii?Q?kzBKFmdIrNkwF1tgY77A8KnACZ+VAp5OCCVEy9Wpf8eIv4B/Nj+rNQhrZWtO?=
 =?us-ascii?Q?qh8uA6c7gcLzNAAX43y5p5h1WBOppvUaNRnii5V3Cn9UxQZ+fCTIQgiRQ8UF?=
 =?us-ascii?Q?idCyj3pJ3S+BJ+FenN9qOJH5pPxr5PODPflj/1xOr2oAkiL5CPkIOWCg+4Zj?=
 =?us-ascii?Q?6slxvpP1GaHdmGnhOxLBxz/0thkki88eol70cuJ6ZGzuIDumOSwKhDV0MlBm?=
 =?us-ascii?Q?NpJXDrjA7dzgdlq97MMqj4F25KnCzz07TZnQ2CQ3HHGEBy+Dz5JUkrm6ZQG5?=
 =?us-ascii?Q?pMKPt4c4OePIU99nCU033hEhDq6zU2phimvhKGU2kvMr8xpw9X6L8hfQtQ/Z?=
 =?us-ascii?Q?flwwquxwLX4X2jaL1BoPRCH8RwpOH+tXIyY0apNNd7Hkg9kA7tCt5HaRMUKH?=
 =?us-ascii?Q?u+zvUThGM5Hj5nXM8jbqpDSR5uzdRv/mVGDUU33aowkkN7p21XCok86tuhHf?=
 =?us-ascii?Q?kts8Ipf06v7sUgV6a+cyzXpEJXXwKoNcAcNM2KXEaL+Zq/tlAsfGb62rrFG9?=
 =?us-ascii?Q?nSfhK9bImc/WRyjRVn6yFFvaQvHgu5Zuf+Dm+TbXqubIWfzZbPrakXWCCh2Z?=
 =?us-ascii?Q?2Zyitvpo1z0zKALhgsba9x0xUA+S78KiIrs23MrT4/v32sM24nAi3NwM9u3+?=
 =?us-ascii?Q?yjyno0c2bU5aDP6GqdskWMVjM3gcYtc7cEOr/U/pf+i5zRw8yj5XUQ8mkdiK?=
 =?us-ascii?Q?W1D/MUoyrgO6U8TJbGmvOBE1Re3Hc0MOx+CcA+le80ONJmoE15cQcNycVOaM?=
 =?us-ascii?Q?dyPrwJSaoIcgnFI1Y92cr+bwJ86lJ9KtjYiREuytm/z47HtpqsHSZ6hfCArz?=
 =?us-ascii?Q?xl0xEnT27F9e+BdDtIyEm+iXi9Sq2GW/a6VrdmdquBry6Ou1WOKxsjKKlgEk?=
 =?us-ascii?Q?0MDHTae0QtO0IJBbAPwq6mKBXvJbR4XKvV5GaKJOQ2gajeDjBpJagjF8/utr?=
 =?us-ascii?Q?+u850H+rgbYRAV2Gded89IlVA8dmhihEEWg0i7DAfs+AOOJJIPx7xZw0rFkV?=
 =?us-ascii?Q?PorIBEFjZoJW2BwjscrcDfbhOMLKQv6Td2Zseoak?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db88be32-4fcc-44da-c3f1-08dbe57f9d4d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 02:07:26.9153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DyveukWzO06BEl+yoZ6hYGA5c3tLBCfWllb4AmMP8nJP+E1/tHnBcYxVwSbNh3S3CCMCr37gf9SHsVisQnDzCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6045
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ji,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on arm-perf/for-next/perf tip/smp/core linus/master v6.7-rc1 next-20231114]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ji-Sheng-Teoh/perf-starfive-Add-StarLink-PMU-support/20231114-101811
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231114021254.3009799-2-jisheng.teoh%40starfivetech.com
patch subject: [PATCH v2 1/2] perf: starfive: Add StarLink PMU support
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20231114/202311142041.nSLDeqju-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231114/202311142041.nSLDeqju-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202311142041.nSLDeqju-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/perf/starfive_starlink_pmu.c:158:6: warning: no previous prototype for 'starlink_pmu_set_event_period' [-Wmissing-prototypes]
     158 | void starlink_pmu_set_event_period(struct perf_event *event)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/starlink_pmu_set_event_period +158 drivers/perf/starfive_starlink_pmu.c

cff226048d4861 Ji Sheng Teoh 2023-11-14  157  
cff226048d4861 Ji Sheng Teoh 2023-11-14 @158  void starlink_pmu_set_event_period(struct perf_event *event)
cff226048d4861 Ji Sheng Teoh 2023-11-14  159  {
cff226048d4861 Ji Sheng Teoh 2023-11-14  160  	struct starlink_pmu *starlink_pmu = to_starlink_pmu(event->pmu);
cff226048d4861 Ji Sheng Teoh 2023-11-14  161  	struct hw_perf_event *hwc = &event->hw;
cff226048d4861 Ji Sheng Teoh 2023-11-14  162  	int idx = event->hw.idx;
cff226048d4861 Ji Sheng Teoh 2023-11-14  163  
cff226048d4861 Ji Sheng Teoh 2023-11-14  164  	/*
cff226048d4861 Ji Sheng Teoh 2023-11-14  165  	 * Program counter to half of it's max count to handle
cff226048d4861 Ji Sheng Teoh 2023-11-14  166  	 * cases of extreme interrupt latency.
cff226048d4861 Ji Sheng Teoh 2023-11-14  167  	 */
cff226048d4861 Ji Sheng Teoh 2023-11-14  168  	u64 val = STARLINK_PMU_COUNTER_MASK >> 1;
cff226048d4861 Ji Sheng Teoh 2023-11-14  169  
cff226048d4861 Ji Sheng Teoh 2023-11-14  170  	local64_set(&hwc->prev_count, val);
cff226048d4861 Ji Sheng Teoh 2023-11-14  171  	if (hwc->config == CYCLES)
cff226048d4861 Ji Sheng Teoh 2023-11-14  172  		writeq(val, starlink_pmu->pmu_base + STARLINK_PMU_CYCLE_COUNTER);
cff226048d4861 Ji Sheng Teoh 2023-11-14  173  	else
cff226048d4861 Ji Sheng Teoh 2023-11-14  174  		writeq(val, starlink_pmu->pmu_base + STARLINK_PMU_EVENT_COUNTER +
cff226048d4861 Ji Sheng Teoh 2023-11-14  175  		       idx * sizeof(u64));
cff226048d4861 Ji Sheng Teoh 2023-11-14  176  }
cff226048d4861 Ji Sheng Teoh 2023-11-14  177  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

