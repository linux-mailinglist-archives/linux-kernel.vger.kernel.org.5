Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269747EBE56
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 09:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343496AbjKOICl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 03:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbjKOICi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 03:02:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF60FA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 00:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700035355; x=1731571355;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eQn+EA5wMVHhUeorJndzofZlEQZA7GwQ6zF5zGYu2oY=;
  b=P6EfqVIzRWs7KwJmjSlph9I0daYyuHrkZXSMmgcDdhZKWNxkwC3u/u9V
   2vN17eE872cct/dpXUf8bFwaVWnYw0g/gXoAWaG2FCFIXjyttq19q/+/9
   sXhSKYLBQKkYcwCuu6I7xsY5tQoPn25MGagIy0AZlygnkFXMbou32FYkn
   VMv2Xdbj9nAYAMv1q6+eW57lYI+Zo0WSXnF+8mBcj905FSIBmhlmChctg
   VfaxaI3l1V0k1Itne6uctgChwR0vr8oUB47Jp7LwDMMX+3nlB8K+PEZUH
   rCiDPzqjziGjTbXbSZB1jxjgJoyvpWQLjcquKyjfwXktc+8CscAO7V+x6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="3946840"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="3946840"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 00:02:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="741361996"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="741361996"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 00:02:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 00:02:32 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 00:02:31 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 00:02:31 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 00:02:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FA46If/wiKzm71D1K8ZT/1RQQkxJSPnm1abG5kcOhqJGjNvVMgE+yFj0YXBdjdbqNtGnJIiSRNB4NqwZQJH+zDM6pb6G0ba37HoX2bWlBckb+6vcxmKQbpVmTRitSJux7jf47YKILShSm8jINrih5IuzY9hZLglgkOxTCpti2eHUKb54YdQ6e1/7iwJGyiO2oQwMOwuyId/mLXll5zO+iQeN+JTxXsjhhVh7vqGzvkIAYBG0zwBDAGlaxFCS8BkaMaSi4ur9FkvrygbDsdQ4cgmm1LufRBM6sMPn9PCSxWfljzLwC9kTfYPsKu+kV/Q6snEG5adhAAPWIgTCUbdwRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYX7gpGcrPDUO1sTo2JTCSsdNEj6h6XnhCvCuOPtY5o=;
 b=ji+TBq5BZRoKZJNMxz11r5CdMnVOA1CJz35F2j2/a2xkltpEL0rG131bUKQ+F2egsBovG9MY3VIv2s16d0WNmZdiEgn9ht7OJTuY4e163ltRKQop5EA45MJWUdqCB2fqixF/6qj4cFw+SurS4T4kZ277/P/CL3BogMRcy2sn57RYdIKBtF9jA7xVldHJv6A8/7GOc1q+FA3qjO7lG7SpCFD43O7JIFqYOdmwVrPPl9sjSHzMe5xvHEhiOKVtWA2ixbM7x9Js9UZ7m2pIBGNe4upJoW7Qv1jslEy6+2wnji+dHRKrm4ADGmuCDBP4t3z4gMQxjK8MN6GAhLeBEUHy+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH8PR11MB6562.namprd11.prod.outlook.com (2603:10b6:510:1c1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.34; Wed, 15 Nov
 2023 08:02:27 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.6933.028; Wed, 15 Nov 2023
 08:02:26 +0000
Date:   Wed, 15 Nov 2023 15:57:46 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: drivers/gpu/drm/loongson/lsdc_benchmark.c:27:35: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202311150710.PphxDBhJ-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH8PR11MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: 083b2fa1-9241-4c8e-72c4-08dbe5b134e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3KcVW9WC+tai2+Sk2Q0iTy5LTIEMuqMNED6jvaGVa7HiqVUVamGhQKXoao/vwC+82/3aU2tmaCG5u3zozlE5RNTkRvL2NLf7DKQoQPQ8jc0ng2o1g21H5TRhcBo2G3tlkLdIf+qO5QcwP2ePZCuH3P9uUZwHaw6xhWAQlxGkAOYI0L4aVIioCUTSVfcsMpXaCdcBV4G2IcOO4uN0SCq7yoWtX1spsHuTuuXmjGjoF73kdr4/zjSNHkjVy6+wUmdVkFM5zgIZy2tfpo6ou602i+mIV7pP1OAqv6qdvM4wTF4Y0uGvpjRbdjO5LCoeEu/71OMiwgLr1VSY20JYPnRtsEdN+EVMLIQw2G1Da7IP91VjBImQkmhQIfd96nzb5LxA5xEh2QFLavuKlpXCSpbCO/KW/8WjHElzqxw67R49CtDYG5QNosxOX2pO+UaMbGmIAxziwFC4a3tq0hKyzyCzDjLVl5uuzaTFxs129ayE4iVlPNF8HU/4Kf5TKWn62FKnxVrnoX0oFtrJo92berNfNUVjb2bzU24sx1ngm1c4fu5cu86s12yi4TWS6Cpx7eaEXrdNneqPi8pPekI7KDkC0RCDULpvzdk7ojXwzzgg7J6SzXovCfnHMMg2l/iClqRxYTX0gVFI4HsJvL9g7zIowA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(1800799009)(186009)(451199024)(2616005)(1076003)(6916009)(316002)(66476007)(66556008)(66946007)(8936002)(8676002)(4326008)(83380400001)(26005)(82960400001)(36756003)(478600001)(966005)(6486002)(6666004)(6506007)(6512007)(41300700001)(38100700002)(5660300002)(86362001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xY15H+dDkUW/n+eupFdh7qzfCWcvAKke8wYOS/xAd6cmFUyBgdEkzba6BK2r?=
 =?us-ascii?Q?3l5Hb33wr0ZijLdRe5d+SaZ8G2nkjkFg5JqxYxuNnsD+MOi9E2XvfHYa1IBN?=
 =?us-ascii?Q?mqvyxY6W35GGWRbzSB6aMN+7wcngISYLgUEd9t07PehSf4EORsUunB476ykg?=
 =?us-ascii?Q?ZldGY2pXTGeBpa9XtuphQhWR53icn/IF5I7FgfLstWQw46l5FpaFZspZuB4o?=
 =?us-ascii?Q?Zn6To75Ig+IlUzWtIJIRN23OS4sC5M3y3jLNMpTo5WBRhdTUk4uIQNFMsqSl?=
 =?us-ascii?Q?ORY3nt40qFMQ4VHCHfXjxxcaAPM3yEJIfTS9pYS4gLYi7b6LHKsVutdiZTeB?=
 =?us-ascii?Q?bwnLRHEjW1QMZZg2YvlO7NZuKNqaMwgliVfXq0sGUREXp87709ThxYQm8ODx?=
 =?us-ascii?Q?XUWKO2UvOrG0IrL8/vjySsefmo7IRve4m0KkP6bnp7f2mC/+4MT/Mv5vSO7U?=
 =?us-ascii?Q?myacehigOZMHYni7X+C7yFEMNo2+CDt7uGWba44CdMICLhljKHUsFqaIxcav?=
 =?us-ascii?Q?qMdX1Uz8SvhbWU15c1JnYh4qQdquHoEctifSe9+xz9N9VoVQ1NjBv3F3C1th?=
 =?us-ascii?Q?Xxsyl7wSnf+5QjK+WBWhIvfBxBMgYcJgbdRTYsRpE6FwtDfiIxa2HKyeKg/l?=
 =?us-ascii?Q?6YqZAfNL8R5rw0EWqbIaHhBkZqQMyYCDH6XlfmebidUwpxCkJ07uFVROhJ/3?=
 =?us-ascii?Q?fbQehuY9zV3Pn0Q0jDNGtqQRuCR5RjlBmkEPcSSPlYsG7D4W57yoCbikhmLb?=
 =?us-ascii?Q?p/dQxQ6gxDHoC8mO7iF6M1dabbJ3IHqWo1TRHSsyTyHUDLPQb89gpmbuiT2f?=
 =?us-ascii?Q?u3n41VBWzv0K/212zAScQ5Rz84P5OqMoLMdDDmRZM+XY+++NP81oLDMLCr6A?=
 =?us-ascii?Q?tgyjtGwHSHH7lz8uzP9l8XhYlRsQNvKvE4BKAlxq2W+vrcn/a+Xcz75gvoDc?=
 =?us-ascii?Q?Z+OjF4g+izQilNK3juf+vryoWx6p5mJvcdMc/rU5jRFsb4ax2+CyU7Xn6Zxo?=
 =?us-ascii?Q?BAs8A5mMScfXEtIBGBq9bi4OFMRkOtWRQ9VwPVX4tzauDJeeHRbOsG7koMKb?=
 =?us-ascii?Q?PqLLkz95Gk2e+ZGmBRpOSIPJoXxKdURBgg90B085EDAWhvlVkwS73aAuXtLf?=
 =?us-ascii?Q?9mDyUnJkZTpcyqtUpCSusUPQJveLuEMDy4RgcemCq2mBYnXICE50KLODAikL?=
 =?us-ascii?Q?AuuzOLzxPF/SLKYNwiuEORC9R5GOfkOB4zOoq4bYFWRVaaHbNixkLwMdlyor?=
 =?us-ascii?Q?KJSROWvfkhyD/v7QNZe/RJM5I5P68wGghRMV68iXXbq6/l/dWGP4qFpesXvB?=
 =?us-ascii?Q?N5RPidKhT4h6GCHRZX3+8Y0ayp1xdtgXDynOD7MhCar4pGOWoC3xUDPqv4o6?=
 =?us-ascii?Q?Mh1RoGJzXH1Wmpyyz3FIzQqSkfJgc1IGbON8UfEovZ1W/HXPt0ZxWPobuWdE?=
 =?us-ascii?Q?jJ/HBTvrEzyXAYdmOHYq0gNZkZ4yHpqSZsbhj+bKfHpPhIyj443KG/L0wOVm?=
 =?us-ascii?Q?oiYTDg7LXOr28s/wEnypMGXv8kEHk9E+kMhz7y+/FIaz+muOKv4g8SWtPhaY?=
 =?us-ascii?Q?ur90Jnyb06LCxUbwBYVZ3XEnGvm3fpp1pK6VyN8C?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 083b2fa1-9241-4c8e-72c4-08dbe5b134e7
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 08:02:26.5840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruIWAKPHQXkXJx9SB+IIgovR9j9l4Do9iS+NV+kckdMMEh2h3F2Gm42BW3MtbaFyDs5DQZPucbsHZ4Y6h+zOyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6562
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9bacdd8996c77c42ca004440be610692275ff9d0
commit: f39db26c54281da6a785259498ca74b5e470476f drm: Add kms driver for loongson display controller
date:   4 months ago
config: powerpc-randconfig-r113-20231106 (https://download.01.org/0day-ci/archive/20231115/202311150710.PphxDBhJ-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231115/202311150710.PphxDBhJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202311150710.PphxDBhJ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/loongson/lsdc_benchmark.c:27:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *d @@     got void *kptr @@
   drivers/gpu/drm/loongson/lsdc_benchmark.c:27:35: sparse:     expected void volatile [noderef] __iomem *d
   drivers/gpu/drm/loongson/lsdc_benchmark.c:27:35: sparse:     got void *kptr
>> drivers/gpu/drm/loongson/lsdc_benchmark.c:42:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *s @@     got void *kptr @@
   drivers/gpu/drm/loongson/lsdc_benchmark.c:42:51: sparse:     expected void const volatile [noderef] __iomem *s
   drivers/gpu/drm/loongson/lsdc_benchmark.c:42:51: sparse:     got void *kptr

vim +27 drivers/gpu/drm/loongson/lsdc_benchmark.c

f39db26c54281d Sui Jingfeng 2023-06-15  12  
f39db26c54281d Sui Jingfeng 2023-06-15  13  typedef void (*lsdc_copy_proc_t)(struct lsdc_bo *src_bo,
f39db26c54281d Sui Jingfeng 2023-06-15  14  				 struct lsdc_bo *dst_bo,
f39db26c54281d Sui Jingfeng 2023-06-15  15  				 unsigned int size,
f39db26c54281d Sui Jingfeng 2023-06-15  16  				 int n);
f39db26c54281d Sui Jingfeng 2023-06-15  17  
f39db26c54281d Sui Jingfeng 2023-06-15  18  static void lsdc_copy_gtt_to_vram_cpu(struct lsdc_bo *src_bo,
f39db26c54281d Sui Jingfeng 2023-06-15  19  				      struct lsdc_bo *dst_bo,
f39db26c54281d Sui Jingfeng 2023-06-15  20  				      unsigned int size,
f39db26c54281d Sui Jingfeng 2023-06-15  21  				      int n)
f39db26c54281d Sui Jingfeng 2023-06-15  22  {
f39db26c54281d Sui Jingfeng 2023-06-15  23  	lsdc_bo_kmap(src_bo);
f39db26c54281d Sui Jingfeng 2023-06-15  24  	lsdc_bo_kmap(dst_bo);
f39db26c54281d Sui Jingfeng 2023-06-15  25  
f39db26c54281d Sui Jingfeng 2023-06-15  26  	while (n--)
f39db26c54281d Sui Jingfeng 2023-06-15 @27  		memcpy_toio(dst_bo->kptr, src_bo->kptr, size);
f39db26c54281d Sui Jingfeng 2023-06-15  28  
f39db26c54281d Sui Jingfeng 2023-06-15  29  	lsdc_bo_kunmap(src_bo);
f39db26c54281d Sui Jingfeng 2023-06-15  30  	lsdc_bo_kunmap(dst_bo);
f39db26c54281d Sui Jingfeng 2023-06-15  31  }
f39db26c54281d Sui Jingfeng 2023-06-15  32  
f39db26c54281d Sui Jingfeng 2023-06-15  33  static void lsdc_copy_vram_to_gtt_cpu(struct lsdc_bo *src_bo,
f39db26c54281d Sui Jingfeng 2023-06-15  34  				      struct lsdc_bo *dst_bo,
f39db26c54281d Sui Jingfeng 2023-06-15  35  				      unsigned int size,
f39db26c54281d Sui Jingfeng 2023-06-15  36  				      int n)
f39db26c54281d Sui Jingfeng 2023-06-15  37  {
f39db26c54281d Sui Jingfeng 2023-06-15  38  	lsdc_bo_kmap(src_bo);
f39db26c54281d Sui Jingfeng 2023-06-15  39  	lsdc_bo_kmap(dst_bo);
f39db26c54281d Sui Jingfeng 2023-06-15  40  
f39db26c54281d Sui Jingfeng 2023-06-15  41  	while (n--)
f39db26c54281d Sui Jingfeng 2023-06-15 @42  		memcpy_fromio(dst_bo->kptr, src_bo->kptr, size);
f39db26c54281d Sui Jingfeng 2023-06-15  43  
f39db26c54281d Sui Jingfeng 2023-06-15  44  	lsdc_bo_kunmap(src_bo);
f39db26c54281d Sui Jingfeng 2023-06-15  45  	lsdc_bo_kunmap(dst_bo);
f39db26c54281d Sui Jingfeng 2023-06-15  46  }
f39db26c54281d Sui Jingfeng 2023-06-15  47  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

