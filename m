Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A194B80C44E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbjLKJSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbjLKJSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:18:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864E9DF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702286306; x=1733822306;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UX/ENNVkNr22c9d1HqCj8igVtpFE8UecA1ZZ3/H8I2k=;
  b=EANcoS88Y/csO1HpJyseQdxM7DDmhRLshvEixp6RdQvqdW5VEYISVQ1g
   x8jc/GrmZvhX4gpgeUTxOzIcWclw6TuhIl0DvBNG8yMk1Jnp9fiCVMqEU
   ciNwQXkBkkItPeTrAsCsQPPuhoh3T2aOA/1GSabyYHkz7+NnbKEW5r2kq
   vK2J4qnqbbkBqXq18RT17Dqeb9g6JpmWSGPUaFdGxsdzq/K2vVocJ/qYT
   +2+ANaRLd29zmX8zrHyDrMysxbbB5Tb8ZyqkpeDqRxmfLfoANPui3Hrk3
   nWnTI8SCY/nrDh5LLwqTm+ZKSEr9DTmYKPAhIkGSJF4liwJQt87j8yiuY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="379612166"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="379612166"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 01:18:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1104401295"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1104401295"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 01:18:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 01:18:25 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 01:18:25 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 01:18:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUn5/l1w05nSE+GD8VHruUXT1WOta1jzu9Rz1X5ocf6w3Esr0IYeLHBU6qQzaXEPWghCvPfWM0e5LMH5+JIcE9I+7CE4h/0wE6RBEd2/DGbF9h7P41yPiWu2Zc02v+BIdpQLJpQuS/55vTflRAdJW0mwrL8J6uIpYCHpACjI9/m5Ri3V7WZbLRs5cC9GziH6Gh7O5M2mr4W3cPdB+RjyK+C1dMsz9PKHJmffV4MRZeVaLetPs6lNN6VQpD0m+W0/M44BZJGIxAjRDgr8lZd10Il7i4xXxEQvw0WTS1SzZ30KcH+eUuLR77VsnM0e7kM8RBcxM51A+lZxeytK+rFcyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfn97QFP4C2b39waf3YrYgn3Kk5l5L5E7yI54rPLpkk=;
 b=ZsCjDergRwNdA4tDSTU/eZlPKo0CqF0lmhUPor6l7w8FBtq1k360q8U4tMlhLmm8g+vbr+2PfnWarH3tk6MQcrR9HbL8RR2RNWzV/T1mwl39/sz1/KOFrPrLQQ7Jzv6pWAvYQVidzGkyi07Y1vduog0sxPVPtGb7Pb6j9I8ehs/dQA12sUZi+rmDBdnr2NF/N4/g7i6U38O6Meng7DvQ/RPnyqh8IkHe6RzUFKrUUDAWgpWkSw0GG5UOxSc879xez33Tf6vac6MMtiyatUkXEAXYv1SrpsDrVIP7h3kiwolQXOdtd97iMwL2o1OvgySFupXj2YMpzMX0bXetjGgw1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3006.namprd11.prod.outlook.com (2603:10b6:805:d1::24)
 by DM4PR11MB5437.namprd11.prod.outlook.com (2603:10b6:5:398::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 09:18:17 +0000
Received: from SN6PR11MB3006.namprd11.prod.outlook.com
 ([fe80::7f2d:3448:d474:f74e]) by SN6PR11MB3006.namprd11.prod.outlook.com
 ([fe80::7f2d:3448:d474:f74e%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 09:18:16 +0000
Date:   Mon, 11 Dec 2023 17:18:03 +0800
From:   kernel test robot <philip.li@intel.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Takashi Iwai" <tiwai@suse.de>
Subject: include/linux/platform_device.h:91:23: sparse: sparse: incorrect
 type in return expression (different address spaces)
Message-ID: <ZXbTy+2n69UU21DN@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23)
 To SN6PR11MB3006.namprd11.prod.outlook.com (2603:10b6:805:d1::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3006:EE_|DM4PR11MB5437:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d8086d-c092-466f-f5be-08dbfa2a1b63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CFDFG9UaRPOlIVfB5o1uqc0KTBrfKxcXMDWcqBvUWGtHXlydenZ0WbI4BXA8s1c17SzC2IMjEtgloB4Fy9RqebtbaTWSCPKEE1IhJqRC/FOX4KLQzr+kXIvoQZRSoG5tMAg1cnw8bZ4ZOU1uMyKxmgPM7AWFs+1y++cBrkNtoa3gyPL8J/zu8JX6GATqxp6RgKcOFYFPrVoUhSAF7uxOJpM5V5D62pqpFXs5Y82i0d/+llWuTDcUqvssQav1UZBo4v0J9dw9hETt0ErAVksp9cfIyyNLo/0Nl2QUYCVVv6TDNdPlgNSCWhL5XdeA/2n+kbADJ+rbqronMViFoW2GeOT3MFiiA3PMmEXWEi1zgz9WhvDWVNoVJS+oFEF6KTp/Z7FtS5wsteX8GDjs4TEORHB28p7Sp8XFBCvIqPBSj0lohV3BOgVpG828yocQC/hF6H1/C9g7Qd5JHHwuKqjvcdjkD8ZsjT16J48PH62dDSZVb19LhivW5nXG7f/T/3pJhy6o5CuRlHCQxm3FlXN87ib51zEdtGuvgQ5dc5Ho5UCdtiQYZx3jRzhMb1JxyCDENfqJNHD27fE8Avl899Du5iCOVXIEhKxuJJf5dORD19XzSTBPHM7/ZoKtJMTIb9xRWtBEP7vJKDmcxWqCLokzstD1d9G90iObK3gyNBwcDUKNqmI+8jQpATNCAbUVLJ8N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3006.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799012)(64100799003)(186009)(9686003)(6512007)(33716001)(6506007)(5660300002)(26005)(66946007)(6916009)(66476007)(66556008)(6486002)(966005)(2906002)(83380400001)(82960400001)(41300700001)(478600001)(86362001)(8676002)(8936002)(4326008)(316002)(38100700002)(6666004)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UJfi44gOC4ed4KcveaMwY8U4hwIaouaLBsioCT4d2wPtEcfamNXBB41xry9b?=
 =?us-ascii?Q?7h+dEyIRUoxNBH23p023ie6J31vwAN0/0HQhocA+OayUBks6JjPdzDlgD6OH?=
 =?us-ascii?Q?YvZjVTkmLWotLaHSYdB0r+u0T7lVGdlpop9ai8etxSvZ+//N2c0UXrmb+2xi?=
 =?us-ascii?Q?G+zZ9cn32S7HFMjMWZGJtyPEdslrKeU5Z8F9nPrQH4cXmt0Wo3E/jcwDsjp4?=
 =?us-ascii?Q?4QfVAd6OXjHJV0KoQO8TdTGlbt9xSuAluRC25Lb+sFE+Ya88tew/ZaoaFgia?=
 =?us-ascii?Q?arJfyfObYhh2Wk5oh3nygSeAQUF8SC221QvlV+8OkZB6t9nArI+c9Cm35UEs?=
 =?us-ascii?Q?vfDhxK5M1MGNFJaEpJgD7oPMwf0/340mYIbjY9KIMJln0Go9X0od2WPJBavs?=
 =?us-ascii?Q?s1lZ8FfpOQ9B1nigxJzk4oS6t9ib0NsQcIypSRtEh7T9xYEiI/6Kx3BAdof/?=
 =?us-ascii?Q?nrIxc5nPWZa++1hpqquYVvBfgZGe1kMGxsvsa4hD4levGE5JMaWOK8VUChoL?=
 =?us-ascii?Q?7PXUwTq0iZ/IgQ22XfjGTxyqMelhnwtvqoGySoG970hKCl6+OlGaDdnZ9uoX?=
 =?us-ascii?Q?K/oA6vDRt7UYYWyYjd/LuMFT1OzwmaoEYonFjn0vkXzhP0IU8y+JWjx9uTYl?=
 =?us-ascii?Q?dwF2EMC1k4XjhjJcVgRVSkxUr5mh+EtDO1xSbe33n4rHHEEtmyV8mnww4G/I?=
 =?us-ascii?Q?CXs6OoFgn1/uHmIG4iqNK6pFt3BaZK9jQUBvsGzZMP8zilYeKgGr6gRsqoH4?=
 =?us-ascii?Q?odv/3OZAXetkmQTrfv85DqY0BEwPWwaUjwV26nWNs/Qutcx/AAPfYLFSESKl?=
 =?us-ascii?Q?HWonEApobLq0xmG+3Nx5WpCT4FVeNmrUebFSFGljK9HcYw5Y1GLK/x+7wtjQ?=
 =?us-ascii?Q?G81oGXkUUuk7bxj7kSCKr9Cpb2uTscH/YFQ6KQ2dyjX7RQh9IjFd+RIo89Ly?=
 =?us-ascii?Q?xwVXIHWvjHP2T5hTtebEaG5dCbroGxBFV3RYBeCFCKb6qzKWO7yNhXyWZ2MN?=
 =?us-ascii?Q?c7rH0tsbSTN7eyu5iHZUVNovPMpc0DZ8q84RqKHsIyi9IaHxaP701zb/Rvk/?=
 =?us-ascii?Q?vaa9LXfy2DoKMbMHdazNxLrjVL4xYpxrwwmx6J8+Jw6KM+K3nn5jxbWLHpBR?=
 =?us-ascii?Q?zA7o/n7sdUDly7TSv3MmA0UBXP/GELy3jUbglkP2nb5vtmubGiTkzpGuwTvB?=
 =?us-ascii?Q?Jz8wl6EsA8FPVvukjPofLta9R7JFu0CA8cXIKDDi4VmDhzRwAihjsd2oRBT6?=
 =?us-ascii?Q?LlFfkCimfNLLdkFcV33duDoGTKQBf7zcBDYM1VFDbIuhBh1DvbKyom2k+DNd?=
 =?us-ascii?Q?tcUG0D2z0UPpOmtTedVu/GYzliMBWAHShewumYc6Mq3nv7m0CTAk4RgySjfV?=
 =?us-ascii?Q?mr7brZKbf8rTaMnCzMAK4MQvR3Bw33YUHAtgwPvY/Ajgm+WiOMp76Gq1hqlE?=
 =?us-ascii?Q?XNFp3psbBXjMXW/tCKtcncjIoYAK6FqsKID7wztnvik8urijnL63HE8UMWHY?=
 =?us-ascii?Q?zRVr7sb00WQ0PsTzcFIS56OokQYm5yARD0PcAjPOLFkI7sSNYWuw4SHYnpZN?=
 =?us-ascii?Q?1p7Eoa4N4nx3RtiJq7g+xpY0YZMDHdL3Yizg1S51?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d8086d-c092-466f-f5be-08dbfa2a1b63
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3006.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 09:18:16.0966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqITr8gdnv8VxLrAbICc2ixQGLnQ94cqZ20CESWJ5GNlmXDeZmK7pGwYF0BRyqe8n2oGTLyXUwfHPBN0sqQmJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5437
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7475e51b87969e01a6812eac713a1c8310372e8a
commit: 512d092d78823f9813f4af38090b33c454137a4c ALSA: Enable build with UML
date:   4 months ago
:::::: branch date: 12 hours ago
:::::: commit date: 4 months ago
config: um-randconfig-r122-20231117 (https://download.01.org/0day-ci/archive/20231117/202311170948.rDwaXfji-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231117/202311170948.rDwaXfji-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202311170948.rDwaXfji-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   sound/soc/codecs/inno_rk3036.c: note: in included file (through include/sound/soc.h):
>> include/linux/platform_device.h:91:23: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   include/linux/platform_device.h:91:23: sparse:     expected void [noderef] __iomem *
   include/linux/platform_device.h:91:23: sparse:     got void *
--
   sound/soc/codecs/msm8916-wcd-digital.c: note: in included file:
>> include/linux/platform_device.h:91:23: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   include/linux/platform_device.h:91:23: sparse:     expected void [noderef] __iomem *
   include/linux/platform_device.h:91:23: sparse:     got void *
--
   sound/soc/codecs/rk3328_codec.c: note: in included file:
>> include/linux/platform_device.h:91:23: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   include/linux/platform_device.h:91:23: sparse:     expected void [noderef] __iomem *
   include/linux/platform_device.h:91:23: sparse:     got void *
--
   sound/soc/codecs/lpass-wsa-macro.c: note: in included file:
>> include/linux/platform_device.h:91:23: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   include/linux/platform_device.h:91:23: sparse:     expected void [noderef] __iomem *
   include/linux/platform_device.h:91:23: sparse:     got void *
--
   sound/soc/codecs/lpass-va-macro.c: note: in included file (through include/linux/of_device.h, include/linux/of_platform.h):
>> include/linux/platform_device.h:91:23: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   include/linux/platform_device.h:91:23: sparse:     expected void [noderef] __iomem *
   include/linux/platform_device.h:91:23: sparse:     got void *
--
   sound/soc/codecs/lpass-rx-macro.c: note: in included file:
>> include/linux/platform_device.h:91:23: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   include/linux/platform_device.h:91:23: sparse:     expected void [noderef] __iomem *
   include/linux/platform_device.h:91:23: sparse:     got void *

vim +91 include/linux/platform_device.h

a0c74f6c9ea9ce Mark Brown 2023-07-18  85  
a0c74f6c9ea9ce Mark Brown 2023-07-18  86  
a0c74f6c9ea9ce Mark Brown 2023-07-18  87  static inline void __iomem *
a0c74f6c9ea9ce Mark Brown 2023-07-18  88  devm_platform_ioremap_resource(struct platform_device *pdev,
a0c74f6c9ea9ce Mark Brown 2023-07-18  89  			       unsigned int index)
a0c74f6c9ea9ce Mark Brown 2023-07-18  90  {
a0c74f6c9ea9ce Mark Brown 2023-07-18 @91  	return ERR_PTR(-EINVAL);
a0c74f6c9ea9ce Mark Brown 2023-07-18  92  }
a0c74f6c9ea9ce Mark Brown 2023-07-18  93  

:::::: The code at line 91 was first introduced by commit
:::::: a0c74f6c9ea9cebd7a8f38142bf87e7c12c2905d platform: Provide stubs for !HAS_IOMEM builds

:::::: TO: Mark Brown <broonie@kernel.org>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

