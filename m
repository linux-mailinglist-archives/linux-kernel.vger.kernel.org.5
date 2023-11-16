Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76937EDB02
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 06:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344788AbjKPFFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 00:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjKPFFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 00:05:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB5F189
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 21:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700111100; x=1731647100;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=7NldozFnq19wM23n2QCweGBOEeJqtO09t+Ph7O7FlRw=;
  b=lV8LmDHpNpiwNTRivwxjqkU3lVg2F4z6dQuNHwnjV/m43JCMIinjRb3x
   QJEZHCqIFxPl798ICrxBb8bJHMS/gk9OfYzrETbZsl+1oUJU5D91gImce
   vZrpSkxptAECfUx64lwSOO3x0SbKi5ClFBCGib5pBO+ljk/GKPZnQLKRo
   04nVYKOu1KkMkOrcmMv7pqxfIJN3clT4Mnycktoz48ilRjpi/sDvAYUB9
   kPWI27KnSdjwHHtUEe5vfsyxc6H2z/fUIhgV+7f3a29CR7h2HQ6rfpKb2
   LM052RCO0VtocwixZmiphVhuq4PYwjLWiYW7E5NX8paXZ4zjfk+VboIWW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="370372242"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="370372242"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 21:04:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="800066212"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="800066212"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 21:04:36 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 21:04:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 21:04:35 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 21:04:35 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 21:04:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2k1m5Gq7g2A3TNbhsjYrfjlw/W+d0+eLMttCkiFPsiwKS1EnGKKa8w9HMmiJ9Y/5s/lpNdav8NoJkehke40/DsYJNuwC7wxZfsiUndiv5bbF55GMOc5LcfrAOamGQIIdLoAKTm1uBoC9pFj84vIKNnXhlIWtkR2Bi0CmcnE+fccRA1kChgKKn/aeL5fyNoYxtStjoUkpAUAh/+lzslE6LL8TVUTWWXctK5BOav5nkGiuNUV4PT5rk1Zvhu9M1Gsn6d4kmPBREfzj+yM82fjEwHXb+PgctRW/gUaGz1sKDikGUzwHEwkkt49US6aUYt+02vyT47qwhH9XGjDaltilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hA32ZfT0tHpKVkWMc+zS8ojFdohXQjYEpwWtAFd7bI=;
 b=jvainZWiIzfvea8AGzrFyCdpVHFlBCtc4VZdYCZ2et/mQhvkTj1ZWItGzBm1pzbaa1I+y2EXDKeCxlmrXd4x2fvDt0U9Oq4B5Hf795aAaM7aML9S9FKZFWErgXO5S1aA7Jz5HdGk4jss4695DvzAJxLlw3g7c7Tpuiuf6qURcFWt5TMyqhS1QJvas50HDRJmA5wO2C/1K1AMwJK818E1Q1dfbjgjWSY/rQptqwN77MyK5OImH6s6J9tan8dAudjSKWlNhae2/JtzyWzQQRBrqNxeJYNASZF9TNyEM6K24/hbKKQuYAh+6RERaa3rUJ5ibHHYzJBELW34jdZa/rN+DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by CY8PR11MB7730.namprd11.prod.outlook.com (2603:10b6:930:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Thu, 16 Nov
 2023 05:04:34 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7002.019; Thu, 16 Nov 2023
 05:04:34 +0000
Date:   Thu, 16 Nov 2023 12:59:50 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Yicong Yang <yangyicong@huawei.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <sudeep.holla@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <oe-kbuild-all@lists.linux.dev>, <dietmar.eggemann@arm.com>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] arm64: Kconfig: Enable HOTPLUG_SMT
Message-ID: <202311151900.K9xc6Xqz-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231114040110.54590-5-yangyicong@huawei.com>
X-ClientProxiedBy: SGXP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::15)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|CY8PR11MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: d417bc37-3647-40c6-8810-08dbe66185af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oqa1qIoGYHwVnkTqiHthl8bYeKKQdFnGS03RgETqPuEeBMRRKbnESQ+fomHZ8brH3xGplQ+kZay2pMSG7ewbilMuDP5tZXk3C7UELktRIAy87O3RLhcbIHSmYhg5bl/bOx7j+yqiecP+lK64h9qIO/qSVxy1U5CEJbciPM1fy+9LubFvMUEExdwtWYM0mhlMWD5ssCoYAHB0s8wOJ8AiwuLekOcyOavSKb1QFi5o1J79+Zb7nsxsD7GI9Mq1eMYIkBXo6WyuiGtMmshfHXYlrSSCGF+eSEdVnJa8DQ0+EvMCkXufPJCR4nR75ht9jRUeqw5ob5Hw9w9j2+AYr2O15hBxDRjiCoVIgv5npUUC7Wuy+c+qdw4m31DA03AqylGQ5gXPSu5YsA4AfwQHLQrKhNryZsRQyZOdtfKh9PN5TG1fs40FhkKrptRrfz5jIVgJEH6cvKs4iJNQiILZoskjavhyOyJn0ch6f+XCMF3gcengbnw4DG4G8qYUPHMV4c1V2IGRxq70UdSolI9iAVuajD8JAd8wxeLCOszXQ7dNf9q4VLPkuwC4+454jLIBQFVbTssfaNIntGurL2jeh1iw2d5eB+fit5956Qk8pBdXSiwgB3sZUHH8U6eCRxoYyNMe6MN5N42HSOi6L5PA3mA1xQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(136003)(376002)(366004)(230273577357003)(230173577357003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(41300700001)(38100700002)(966005)(6486002)(478600001)(66946007)(36756003)(86362001)(316002)(66476007)(66556008)(1076003)(7416002)(82960400001)(2616005)(5660300002)(2906002)(6512007)(6666004)(6506007)(4326008)(4001150100001)(26005)(8936002)(8676002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F+H5dzDmaEaL4XzRooZljKKp+ROCxTsx7FV8/my8w2fw4zbquJ+8ECUqh893?=
 =?us-ascii?Q?qTLXxb9mrhE3fU2JtQHfP76x6dvoSfCJGI2YhjP3AYyU5WlT/gLfo2PDDFRQ?=
 =?us-ascii?Q?zrVTDQ5uqVdNkvMUMnLWA508awp9hcYKpXc/CVBekzjuBCrx2TJDFYtVI8X9?=
 =?us-ascii?Q?kcG3Xeifr5mY9d4dNMxW8NtDtD6T6t20krurSwg8l2AMziJtMQI4yUA04XB3?=
 =?us-ascii?Q?pjcJNEqLtzDbLczE9Pg5yJzCi5x0ptMlchIulGkldpqdEBoWS97FGJZ/AJRG?=
 =?us-ascii?Q?kurqcomi/oS3ehqjAZxZp4MGAiyHctf2ks5JAqLI2G+NFo/hGFOyyajRkoK3?=
 =?us-ascii?Q?f58HDXPvtbWH07n2MaBZAQbIqXy34kHklEtPmD7HEjz913wG9cmaoFylU19E?=
 =?us-ascii?Q?RTZzjWNw2p/gMtN5BGPQUW3tqEBkNrSuCO50Yn+Y/GwuURxop1YxwRjCq2O3?=
 =?us-ascii?Q?H2mi615mk41jR9YR0147b7ngxbEK8wu7xocqB9uZRFZaAMYnB11Lc7EH/FbJ?=
 =?us-ascii?Q?JBrSn2y6p3hvuv3eVAPF65m5P5TWY3474fyESLeYJySpZYcQtKMAAXaHha9e?=
 =?us-ascii?Q?OmEPZWE+rAdZnH8LPs3GyHR8nLO8pjckYLlpgeGrdaEjlE9huPtlvBPfhkCY?=
 =?us-ascii?Q?gx7NkpM5r9YmCdDm1LBkcWpZepALS2jH6xb23T4xXVBAEzXtH00iO8MaoipQ?=
 =?us-ascii?Q?khjs0eQ31XCauiyVoA6mGmbKYbKxZfn+0/bYoHP54z/Y+FagtHQ96TlBx3i1?=
 =?us-ascii?Q?08WuQJ69usaXzcVDTZ0iA4eS7g+iXFtvb/9GWN5Vq/wD2KX87TwzBQ0j2BTf?=
 =?us-ascii?Q?JCBeWO7pKYsvNpqTgz9RzW0yRQOvZ6cMCFdZQQ06f/aPQabFYlYJOmXI7JjP?=
 =?us-ascii?Q?v7QEBLV5T2F77jVHAhHqa1r5EcknO2tnPb0BUM8EkvBvWo3ZUJWwU7QJNtHI?=
 =?us-ascii?Q?Vlaiig3ZJ3SCB77XpQ7OTxiGWxzKNAYd/3hFDYmAM8nDI0QhSIr1njLZOr2b?=
 =?us-ascii?Q?yQi0/W2bOsgDacv600l/llIYfxUYmahn79jvqX8SLADevfzpXZQtR1JR6j5V?=
 =?us-ascii?Q?9L20PGYFamZ8P4I4I02WrQG+3QmLX8Z4ryLMKzadFzxB1++IXFr1eyh7/bp+?=
 =?us-ascii?Q?9HNCWJ98dMp31WyaICKAWJcGOKnEzfyyYO+eWIL2slGdZ14Go8DFsn9MVOJQ?=
 =?us-ascii?Q?TxLaE1cSWqgja9yzPalDrL1JKcuaiuUiLmtomBRRxqxOkXslPKu4k80Bh1Sz?=
 =?us-ascii?Q?nBKhlz3GsSp64bAwR+bQ9Au3q4EYTLfeIQHeHnr69Ls7IphCUUfpeJmNNUxz?=
 =?us-ascii?Q?f9NgyjlnthPXtjySuV5I3GV9c37aKbvvV95mxqWum9bEDmmwh57InB34d1y/?=
 =?us-ascii?Q?4nTmzTH2et05HsWjC9hUw18O5NXiGlvpNEUrAIDyhx6GPYd5Rq6l+vxNiiWH?=
 =?us-ascii?Q?mLsWnmm4vj10SzqSvdVbvfGcOKP1oW9sWW+7zUoS1cVwI+WN1uCtFgWCfwoL?=
 =?us-ascii?Q?mklrNHQupmWcifnKJAZgd9DEiYbnSw1T89LN8z8XEnmxuma+rPWCv4VfI8cL?=
 =?us-ascii?Q?ioV9yM6t9ZXKBZPIVWjJUF85LSQ3m9Ue4w8Yq9ie?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d417bc37-3647-40c6-8810-08dbe66185af
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 05:04:33.6595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJeOvTuhACLWPh8ljHBciPBE7KqPJ99qG9IKWNzPbef1UZJtTSQlYC2303+YiFfo6g14YkNVfdnU7stHHtMEbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7730
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yicong,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on driver-core/driver-core-testing driver-core/driver-core-next driver-core/driver-core-linus arm/for-next kvmarm/next soc/for-next linus/master arm/fixes v6.7-rc1 next-20231115]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yicong-Yang/arch_topology-Support-basic-SMT-control-for-the-driver/20231114-120544
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20231114040110.54590-5-yangyicong%40huawei.com
patch subject: [PATCH v3 4/4] arm64: Kconfig: Enable HOTPLUG_SMT
config: arm64-randconfig-002-20231115 (https://download.01.org/0day-ci/archive/20231115/202311151900.K9xc6Xqz-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231115/202311151900.K9xc6Xqz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202311151900.K9xc6Xqz-lkp@intel.com/

All errors (new ones prefixed by >>):

   kernel/cpu.c: In function 'cpuhp_smt_disable':
>> kernel/cpu.c:2687:23: error: implicit declaration of function 'cpu_down_maps_locked' [-Werror=implicit-function-declaration]
    2687 |                 ret = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
         |                       ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/cpu_down_maps_locked +2687 kernel/cpu.c

dc8d37ed304eee Arnd Bergmann    2019-12-10  2672  
dc8d37ed304eee Arnd Bergmann    2019-12-10  2673  int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
dc8d37ed304eee Arnd Bergmann    2019-12-10  2674  {
dc8d37ed304eee Arnd Bergmann    2019-12-10  2675  	int cpu, ret = 0;
dc8d37ed304eee Arnd Bergmann    2019-12-10  2676  
dc8d37ed304eee Arnd Bergmann    2019-12-10  2677  	cpu_maps_update_begin();
dc8d37ed304eee Arnd Bergmann    2019-12-10  2678  	for_each_online_cpu(cpu) {
dc8d37ed304eee Arnd Bergmann    2019-12-10  2679  		if (topology_is_primary_thread(cpu))
dc8d37ed304eee Arnd Bergmann    2019-12-10  2680  			continue;
38253464bc821d Michael Ellerman 2023-07-05  2681  		/*
38253464bc821d Michael Ellerman 2023-07-05  2682  		 * Disable can be called with CPU_SMT_ENABLED when changing
38253464bc821d Michael Ellerman 2023-07-05  2683  		 * from a higher to lower number of SMT threads per core.
38253464bc821d Michael Ellerman 2023-07-05  2684  		 */
38253464bc821d Michael Ellerman 2023-07-05  2685  		if (ctrlval == CPU_SMT_ENABLED && cpu_smt_thread_allowed(cpu))
38253464bc821d Michael Ellerman 2023-07-05  2686  			continue;
dc8d37ed304eee Arnd Bergmann    2019-12-10 @2687  		ret = cpu_down_maps_locked(cpu, CPUHP_OFFLINE);
dc8d37ed304eee Arnd Bergmann    2019-12-10  2688  		if (ret)
dc8d37ed304eee Arnd Bergmann    2019-12-10  2689  			break;
dc8d37ed304eee Arnd Bergmann    2019-12-10  2690  		/*
dc8d37ed304eee Arnd Bergmann    2019-12-10  2691  		 * As this needs to hold the cpu maps lock it's impossible
dc8d37ed304eee Arnd Bergmann    2019-12-10  2692  		 * to call device_offline() because that ends up calling
dc8d37ed304eee Arnd Bergmann    2019-12-10  2693  		 * cpu_down() which takes cpu maps lock. cpu maps lock
dc8d37ed304eee Arnd Bergmann    2019-12-10  2694  		 * needs to be held as this might race against in kernel
dc8d37ed304eee Arnd Bergmann    2019-12-10  2695  		 * abusers of the hotplug machinery (thermal management).
dc8d37ed304eee Arnd Bergmann    2019-12-10  2696  		 *
dc8d37ed304eee Arnd Bergmann    2019-12-10  2697  		 * So nothing would update device:offline state. That would
dc8d37ed304eee Arnd Bergmann    2019-12-10  2698  		 * leave the sysfs entry stale and prevent onlining after
dc8d37ed304eee Arnd Bergmann    2019-12-10  2699  		 * smt control has been changed to 'off' again. This is
dc8d37ed304eee Arnd Bergmann    2019-12-10  2700  		 * called under the sysfs hotplug lock, so it is properly
dc8d37ed304eee Arnd Bergmann    2019-12-10  2701  		 * serialized against the regular offline usage.
dc8d37ed304eee Arnd Bergmann    2019-12-10  2702  		 */
dc8d37ed304eee Arnd Bergmann    2019-12-10  2703  		cpuhp_offline_cpu_device(cpu);
dc8d37ed304eee Arnd Bergmann    2019-12-10  2704  	}
dc8d37ed304eee Arnd Bergmann    2019-12-10  2705  	if (!ret)
dc8d37ed304eee Arnd Bergmann    2019-12-10  2706  		cpu_smt_control = ctrlval;
dc8d37ed304eee Arnd Bergmann    2019-12-10  2707  	cpu_maps_update_done();
dc8d37ed304eee Arnd Bergmann    2019-12-10  2708  	return ret;
dc8d37ed304eee Arnd Bergmann    2019-12-10  2709  }
dc8d37ed304eee Arnd Bergmann    2019-12-10  2710  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

