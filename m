Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A9E7EDB55
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 06:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjKPFye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 00:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjKPFyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 00:54:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90236C2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 21:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700114068; x=1731650068;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sT/gZMCdlOer6v0a2WuCxh/NPa+Vg/T6IVcXNfW5Q6I=;
  b=FJvWLaZKRsIhiHwZYHsknaWkOwXRgBkPxsDQFy1ChJ6g3vUFho47Oxh7
   V601PP22qL+fOu9BxAw8vMvwhOb4Edi+JMm2N+4Oke71BnMnjIxaGj5cZ
   IstYJAS3IfaADKet+EsfOhdxmRYSEK/MuOW1Lp2EzKZvF3F2rKeqgY55A
   pxRMA4NuTl/mNwmQqqozo0ffT3KK6Tqg5B+x1bsHhYpSqFzUcmLe2OzYf
   yXo0pyLBdoV3P5AZbelfsitPJYLoebGA3ynMYCSEse9vMLoIoptRHy6UG
   6ZGcWJd5IzH5wQ6wn3MuI5ZDpfGHR2oKYDmeDVRt2x1ajlcutxTLdOOks
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="389878693"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="389878693"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 21:54:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="909010039"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="909010039"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 21:54:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 21:54:28 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 21:54:28 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 21:54:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsVi6glB70Gfc+Uzh2p/2Pgzr+KaW1THf2zx2a9CgyYnkGSboo5bghD1jFh9lW6s5PvJ76XBS2Z/zoI684FAwwW+ajQvV4EsikqBKN3e2SCaYPGqHVTG28oVrxBWGLOeqcNTXaREUY+Xgg43d/gUib13dMb288/zKt0fjkn1yPIcAAUDjgcOX2hYVRZoD9eiUGbQX+aUfMls76m2L2cj9hxn77+NhbKQmai5Pg3dKsZY1GGDjPrJwXKbLa28K13nz7r72lI1ybs35maOCXTlYG52tJn9k4PHLDqnqlF2fdWyVMmy9s2mw2SUnVaJqPyAnpIO5JL0JUDnaRWyd+Mk5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEcVtkB1y7a2OwQKdpKQSpo4a/sEbNHfww6zHsPlxn8=;
 b=BgubTNiG+HYgbex9xvluAHF3mVFsgwehz8AjSl2O3Qhl+PPvYJWhwl+S8ouQmgtFyNaQqz7vddsD1yuJhSjgGydatC38P4saKpUtpEoVd9dTlefhPSKv9u2Qx87aQVIa+sSg8banGvmSKlkYQnkUhYZ3rMMbHUI13vVCNc9Gbv4WWftrU2FuTIxb1og+18dU3HWgkRQu9SA1MD8KR+ie2uNbeIb4yzeGJFo0Qf4Id0nOiftmy3eqAzKVx4TdqmcGqOryguhd1np+esP0Rl7wvWNHYkslQt2aIIuOhkJa4aCajpKHtzl3aVQOS6cZt0rgFSzjtQFUFYZL5IHGc1Sl3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by MW4PR11MB6837.namprd11.prod.outlook.com (2603:10b6:303:221::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Thu, 16 Nov
 2023 05:54:20 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 05:54:20 +0000
Date:   Thu, 16 Nov 2023 13:49:39 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Nick Hu <nick.hu@sifive.com>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: drivers/tty/serial/sifive.c:1036:1: sparse: sparse: symbol
 'sifive_uart_pm_ops' was not declared. Should it be static?
Message-ID: <ZVWtc40wfzY09u35@yujie-X299>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::10) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|MW4PR11MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: dacbcfb4-e41e-45ab-5b4c-08dbe66879f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DdjpqOy3eqcfLF4HO1HlESjvwjiAGqHBjSyYNXOaLQxxAcoFWZ2HWU6yfVHEU377XiTjYRSslcALDs4N9plFmSGRQtZ3eykvJuCI5oTtPuXA8BkL8I15e4d7P9BGlpYlrKFGjs1zKt39nb1BPHsHAKlQoqyU0gRsm+9rdi4yjfgKHVlZ3brq9nBl6uoiknZDv3j7FlM31zyx6AvU45rV6bOAmku0yJY7HTNvwWVR2epLbMw59zPzNk/MpWrrD6CShSK7Ym9o4D23BMSpfl1JKEND2b6sOU0D3cmQGRYeCZfCby6gTXxvXiEth0SI+RTAqwd9M+50+RXC7+3hd3ruiYlMDPZW9sCTlcTINRGXILCMYuoJ2X31vc4265IshNAovA35U9OW2RhZ/J9uIJETZwDqLS0Fc4j1lpKlTQpFhAEUIDNkTy1lguqt0pp5OFHfDve6ZwYikXi3o0rs41TPjFtAsBSvCXoP47UKXofXfDoJs8J+v4J372rYfBjYT8IIIptH9xbCTdCcZeeIG9qQSYWb67LRJqnVy6f8E0THi9WOdBk7pZgX/WNe6NV7bYwGWDG4aYQxX+CjWwbvX88wVF8oHvWHlgrDCjCTHvQ+aGw3rO555AYnIAi55A20DAWSc5X/2n5X6p5iN2GAb6ckLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(376002)(396003)(366004)(346002)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(186009)(1800799009)(66556008)(33716001)(6666004)(26005)(9686003)(6512007)(83380400001)(4326008)(8936002)(5660300002)(8676002)(41300700001)(2906002)(966005)(6506007)(6486002)(316002)(478600001)(6916009)(66476007)(66946007)(86362001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SoSR50IKKFKy+fK6Vc3HFtVV1zNZwcDXtRGe7r/1qLz6YrMx0r62BG9EUirq?=
 =?us-ascii?Q?Rp/5UqRV1n6fb7kpW6WdZ++3WvgcxsjUHVsW5Wg7085jiENyMbJh8aMVhCqC?=
 =?us-ascii?Q?Vt36uJdsLvuFFCff86rbZK371QXmke91zruyKdhKm+1QE1v08mtO3Au42PlV?=
 =?us-ascii?Q?UrAVwfNyEBC0tFJwecmHylpBOWkL3CMzmn4vCSq103jfsINxymFC0qoPZbj1?=
 =?us-ascii?Q?Kq6+LtCgBoXKK7bBQOs4GknZFzDMM/P6jpvaxANy4MqNpyAQSXBqPABH9jKT?=
 =?us-ascii?Q?82nM/feSxLaZhPzxYZUdB8CAwOqTmCGzfWYUJtP8PLGGFZA85qNIxsxjHhWe?=
 =?us-ascii?Q?4YsG4zaJHFsJh0vO4lw6yJkdVHbxUB/oslVVgzFqi1A37WNJ0Uw6Pyljl4S4?=
 =?us-ascii?Q?O/Qmk3C0Xm1MZ+IU9XApRRtO11ZQv+lHe26WhrwVvkhajDv58aY37P0YG8rL?=
 =?us-ascii?Q?eEJ0RGn4j9Y6fNzE+SMfOYdZrQBrtXU7UgfYGwMtQvjmdBNA4O/VAfC6892J?=
 =?us-ascii?Q?wROISVO4RruSWix2EBlST74GhHANvF8C0bJC3U1dCt8m3NYBnoiPUEbSY60u?=
 =?us-ascii?Q?R9+OpPEC2ws94lQR2L9LJBF8MTayhNeXwQ3Q6HhDSOg79/sr3tdI16tS7GPv?=
 =?us-ascii?Q?9Fonrxyj3+xY9nLyaNiy39MpKWd6P9tfziM2jRv88N2JxjPrqNPcMxVM8eUl?=
 =?us-ascii?Q?KYPJF71jzvPkgFDY9fqe9krMAKHP4dxN8H+bP7JjRHWPkGqNJZ393GX1V2GZ?=
 =?us-ascii?Q?wyN4qGEuOZ5IF/+GP5cm4nsU3urQSdq9TegscbLXYHHkv+JbxXAZYA19ngUf?=
 =?us-ascii?Q?ua0zspVVP4ztHldpKpV+T5s4SUV3SkdGp//E33/N74NjVtlh8od26AZ54kcD?=
 =?us-ascii?Q?F7SNR+xtwGVjDJUpjADnT7/SgXRScvVuHPkdUJQ/iIbHIewMZSG8UakxmyRU?=
 =?us-ascii?Q?5vt0fsKPCyPTsxxjVZKdEjrLKG6/IzjUvHSY6EXqw4auo6rYlZr+JFD4IVRu?=
 =?us-ascii?Q?vkYj5+xOmKKPAYJCCEosp0NCYbcmhnOggl2+Qd38q5cQC6qta6gxAR+JWCoN?=
 =?us-ascii?Q?npX6nE7Zuc7vnChbLVA+Ee/j0yqWW1UtXpJK4JAhfTHZpTH1RVJeV4mXUtVq?=
 =?us-ascii?Q?rx/yGms+mRfGxibzC651ktikot52mQI2MRSFW4agchR28/MSdPZruuhrdWlc?=
 =?us-ascii?Q?rwPgd12LZ0SURIp1m+dncJBW9qxSnyVQo/f2p2pSi4OZfYYkOmGQZnQ+oHzY?=
 =?us-ascii?Q?FMV9cfhFcCB1+LxeKQQDao1FoFI5407imosyb0l3t1FctEGNUhrNQ3VH58iJ?=
 =?us-ascii?Q?uwgtmmiW7ensodadpOiB8yfqVgl5OPRK868mkKPUzSqU9y1meL0VpkJcEGrX?=
 =?us-ascii?Q?hiZ8k+PRO/eyy8nHbpW84UrHdugyuEi5p6ZRi0xw5T0y8VwtnaixH+HNj+pV?=
 =?us-ascii?Q?8Xt2fGT9d8hXzcyceDcgHG2oOpakUUCDnvpAWn1m0gGFg6WAMny+HOfatJ2U?=
 =?us-ascii?Q?PheF4D/x+fZHVDTG8p44c3TzzTHdM+yZKuE/oFLjm/eXSZNIdVfdr6JA73Td?=
 =?us-ascii?Q?RZfjih6UyCTfsBYjmLwRUdAlhjqvvFbU3V274NPV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dacbcfb4-e41e-45ab-5b4c-08dbe66879f2
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 05:54:20.0726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pqDsXNV6sU/wM7QAid5baiIZokGP4oxYKzh6V4LcFgNzVj00280bMZJ86sFvibyRuW6Y+GlV9T7Rcl0VVRa3Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6837
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
commit: 8a6498f2b94333f1793bc912b11830655f975470 serial: sifive: Add suspend and resume operations
config: sparc-randconfig-r021-20230427 (https://download.01.org/0day-ci/archive/20231116/202311161318.pH043qET-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231116/202311161318.pH043qET-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202311161318.pH043qET-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/tty/serial/sifive.c:1036:1: sparse: sparse: symbol 'sifive_uart_pm_ops' was not declared. Should it be static?
   drivers/tty/serial/sifive.c: note: in included file (through include/linux/mmzone.h, include/linux/topology.h, include/linux/irq.h):
   include/linux/page-flags.h:240:46: sparse: sparse: self-comparison always evaluates to false

vim +/sifive_uart_pm_ops +1036 drivers/tty/serial/sifive.c

8a6498f2b94333 Nick Hu 2023-08-15  1035  
8a6498f2b94333 Nick Hu 2023-08-15 @1036  DEFINE_SIMPLE_DEV_PM_OPS(sifive_uart_pm_ops, sifive_serial_suspend,
8a6498f2b94333 Nick Hu 2023-08-15  1037  			 sifive_serial_resume);
8a6498f2b94333 Nick Hu 2023-08-15  1038  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

