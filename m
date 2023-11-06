Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01307E1CA9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjKFIyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjKFIyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:54:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5CEDB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699260845; x=1730796845;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WzuG577I4HU51mgEMy0/21unAyOq+c0zQNxydszhXGs=;
  b=Mf7JU9ta8VKn7cHutzbZTWU2I661IP3dJcUOn4dq2xzU2ymmTPSxJD+V
   0nJciYq3fXjK9mIIuzOEH8Uw/TVSEOoUuorUOzI0akP9HwytucEw0Kw09
   nVdpmEU3jvJp30NCGWqLfZLBgjJ4xA9O+6pqT21khJ0hCHEHW8xZMdbtN
   OLg0fx7AkhiMHzpMfgzSeI653qspzy22oxQ07vLZBJ0xUKZW807LL3XfF
   lbri/vTqN4+c10y8x2i93GvyweK4dkm9ZGQYP3yyQbAdaJX/6v3oduk34
   YCXwHK06vNxl9PalZ83M3bX6bIAy6ujPYOIMhAC+FNR/ZsqNzNFlg9Nh9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="386407700"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="386407700"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 00:54:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="797244248"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="797244248"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 00:54:04 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 00:54:03 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 00:54:03 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 00:54:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeOvprQSMZQJGoPEDVKz30obdlHWm0Z4cpl2wwDyKQggHMcSM5ExeMuuGq+er+vGwHfqCIZ+BfI4hz+byTtD2eEtunilbdmPOg9lwN7gcl/ECEjoQmtFeEL0wmwkBu9+XaiEL+8uUDadojc6A9F3Mds/NR4w2ptqm09eZDuc0p+B/8xOMOhXvQM/e0va8avApFu4IdEXr3AOOUed5WFl76NG9BgvrGYM7Ju3dylyjR2hwuF0duiOaWYbw90vgP6DV3qYOpaQ+f32s/iKM0NjT54R0qr9easxeQ0Wx8ns2KNeANQtJHgwJi239c1D4DtkbmMWdfMN9J6aHf2rcO5w8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPakz5swqdJ7QirGEo43qBf7IA69kPm3W7oOdrZ5LN8=;
 b=gZ0/8i0UNRFnLSrZ8LDZ8FpQUWo9oIX7dooDcr7ZwF72E55gjHRs3o4pAN5ssq200i/kmvHwWKxvEUr/uwxTDWkwfR6qTkfQkyWKUVt3L4DUdzs4VaqveUnk8oe1f3Foc125lZiPxg4Bb1ta6erii2ne+eDbQQL41xG+OybzFAX2eOAZOhOyC2nB7iEmWTpsMQDTE4PjWP2h9xD7Q/P6ckKzWuA8Z4QNnppSyDlwsX2cehIGvLwpaIwPwZ2KgK2jE9TYM0L32gF1Zc70zk+guDDspJwnqBYep4x3nXP9L1UO7W7HomNVCeseHX4N2tBrXXIkO5dQg2jMO156uodz4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SA2PR11MB4985.namprd11.prod.outlook.com (2603:10b6:806:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 08:54:00 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.6933.028; Mon, 6 Nov 2023
 08:54:00 +0000
Date:   Mon, 6 Nov 2023 16:49:17 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: drivers/comedi/drivers/tests/../ni_stc.h:1140:35: warning:
 'range_ni_E_ao_ext' defined but not used
Message-ID: <202311060001.aEuf1q9y-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|SA2PR11MB4985:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f9dc28-2f73-4d43-d729-08dbdea5eb60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +zpWsNn7XYtJW7jsI10rO3z1AjPvi4+u9W8yyV1cz9A5KX3KH4QdK6zAxszTTKdfeB30R8YcuwgwlXdcURkpqgYJR1PAOe4IsXlxOL9SLK6LTeQZM67ZEIZnfXjGIi8NsWDGTF3GES4BswkQTtOpceUsvCkt15NFEU3EA1/HL1jk6RahHWHoz+A64X2m4bhwi9I0TK94gIVcfvC8c3mi2hfiADMJgSLsqfE1IxZ295QWiPW8nqaYNRTHR75rmkgbM/wiu4ZBXQl6Qz78iM0coFB3O9KQiXnl5Qb5+3vfDaWFHx9/HnpwTKsnYBhQxvI4S2GMzdr+XrRoV0vnjMr/OGlhgDBxcKa10K0ND6cTZhUao+gJo2BuSMpSZS13o4G8eUX5jNvSI7CaoJ7tvGykbqu3TFHDH3BZAYido66qadtUbjjiBX1E/DK9+ubqYOtkOYw7wBPdE/lKoKDixuInM8IU9ipe2d3OTCahviRa7TVyDlUkTWGBXExffxbvtHAzEjhCuEufLUmCWv/N+vEbwp7eyHlfaptpy3aiPlfNLJXKM/tpOiq4dZVqIZX/CIuURhs5YE4ed3Dc5Z1xSVe7R9ELOI9Q1Q7h330woMDQfsdTpcUC7l9aqlxTohjz8BGlPkgnXy/i+pPu5zUfX00RkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(83380400001)(36756003)(4326008)(8936002)(41300700001)(86362001)(2906002)(8676002)(478600001)(6666004)(6486002)(966005)(6506007)(38100700002)(316002)(6916009)(82960400001)(5660300002)(66556008)(66476007)(2616005)(1076003)(6512007)(26005)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iyhpHSUY7XaZr2t3korVHCqjsEr6evKOq/sPr3HVnRgGXjmsmhd3Lze8EDZY?=
 =?us-ascii?Q?jf6WTpfk0P6AOkjaw70ERwA+FJoqEaV25sZTwysnPSDPCndV8Bbfbz76Lrco?=
 =?us-ascii?Q?x873CRNEPPYb+KuLBd511ckuoV95UMKnGx4ai7HlF+PUMYY36azdUuEyfrbf?=
 =?us-ascii?Q?5T5u7xIf7dGdCMkuDUP3NRe3qfaKQ2eYKFrwwzH1oqEXyZ1nJWL/b0keUnZM?=
 =?us-ascii?Q?Hbo85igWsc7bWI852G5VL9IBqHvLszJ8ar5odkSUNe3E1N+GMRNxVjKXDVzb?=
 =?us-ascii?Q?9UawLmV8KqzApc6UPzIT+43+oIMfywmNB7tUv6MrSWt1dL3ojFz9rkPflJsA?=
 =?us-ascii?Q?zGi0JnDa1rtbcNeeQjVg4myO9rwUI0TapEI4URp0ob4IYwIt3zuOpkWaa6zi?=
 =?us-ascii?Q?gzvFURj7RWE7aIAcokNSwDQ1sNMe7+yUXd8dkV/Qd0nek9cxY+rwpjh3UJNB?=
 =?us-ascii?Q?5Im7oxmtEMsZnMx7RSeQ97kCL4QKN/jMkC2sXpsH3i3qONiH4zcVFSTkKIgD?=
 =?us-ascii?Q?caW5LG4aIRWZMy1rSb3puLFrsQ2nYToY/XxlQdGsTny/Gc1N5G7GSfETUWfp?=
 =?us-ascii?Q?Hp+DkGDfRjZJgdPuqWXkhcxGz7aNB8IJJG59IiUDyxOWtQKEXyYh2kjHcMQP?=
 =?us-ascii?Q?aXCY6V0VtBVukPT6sQTAzYlrsI4r6pHp+yJ4YLmDTh5AbZt2jxkOOJW2xfkA?=
 =?us-ascii?Q?t7RMesi6BKdoM4px+1+6eVPk/5GAiNkt//khSzIBDxySNjwCqxPEZ+Pl5Gw5?=
 =?us-ascii?Q?Irig6qmOXdsYWYxdvNCmT+wVE2xyWXmbh/WT/n1HlJxVEgWXhlProNPsTjm9?=
 =?us-ascii?Q?OvwnMOdh6z+RbzTPusn+BPZrEwyrYD7i7AikDcwqnZcljBcRQp1+8sztWIq/?=
 =?us-ascii?Q?ZZY4OaO3oKsy1KWqzH3F1Dy11Yrx/AMSEKGa/NHPCpLuJ3m/zjxGNRGy6T8C?=
 =?us-ascii?Q?8teM0YjJOomQa2eaPQHcvSTeq9Jat4M7a5HiruJWVF1FlceCXODGew4znPzD?=
 =?us-ascii?Q?uNjf9efJIFzls37hRLnFfj4Pg2YvvUDGhmxr6zM1v58ACPJ/QD7nC1slC1Aw?=
 =?us-ascii?Q?M6ADCNmzoNI0LgDDpltTRkin9brV1uwbn2RrCg9SXWJP/Uss7oRNl6Y8hW+k?=
 =?us-ascii?Q?wQ6BqG43AbDtrK8zk4Qq9qhknR9UzBX+ynQdsejePmTGDWHi1KiZBFj5ffeD?=
 =?us-ascii?Q?IJ4JTiqGT4kgIweGLmeb7LvPSw2vzg87pu2E5MI72iyfanz3eOhM1twgj/LC?=
 =?us-ascii?Q?zg3YNtYyZ2qTO36Xx9DZnAfEC68NB2cDM/EyBTttYuCwdsR+8eGP5pF1PH+E?=
 =?us-ascii?Q?QVezuJvaaTA/P6I/kixRlhXH9bIfDPjdDMGJxVyHK/M/TMOcdcbe5siYBmHF?=
 =?us-ascii?Q?pgauD7HhIfefJKlT4IgWmrE5ohX8PM7gEwuUhUMyZZE8eZcN1ixjo2BkBd5G?=
 =?us-ascii?Q?jw1Utbbe3XF4u/pAfGeLC9lwVVQ+/O929n9DdKa69nrdMTvLByk8tFoBuh0a?=
 =?us-ascii?Q?jNZ50mvETKgkjiA13OfvGPoDdosNAW6IKWSe5FlW+NbhIMFrcFnj2PbcOO9B?=
 =?us-ascii?Q?TJHJMRNvor1/VANcaTsUhEUHrGZefIUONneaddEm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f9dc28-2f73-4d43-d729-08dbdea5eb60
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 08:54:00.3976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oHX2njkQ29PDkoQcUL3lDOZSZlStoU9kB3yNWeH+ybaGRmQqwag6DYaJNM1BJNEdJcUoUAO871KcQKUGlLDxDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4985
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

kernel test robot noticed the following build warnings:

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c41041124bd14dd6610da256a3da4e5b74ce6b1
commit: 8ffdff6a8cfbdc174a3a390b6f825a277b5bb895 staging: comedi: move out of staging directory
date:   2 years, 7 months ago
config: i386-randconfig-013-20231101 (https://download.01.org/0day-ci/archive/20231106/202311060001.aEuf1q9y-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311060001.aEuf1q9y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202311060001.aEuf1q9y-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/comedi/drivers/tests/ni_routes_test.c:23:
>> drivers/comedi/drivers/tests/../ni_stc.h:1140:35: warning: 'range_ni_E_ao_ext' defined but not used [-Wunused-const-variable=]
    1140 | static const struct comedi_lrange range_ni_E_ao_ext;
         |                                   ^~~~~~~~~~~~~~~~~


vim +/range_ni_E_ao_ext +1140 drivers/comedi/drivers/tests/../ni_stc.h

a8b774308dd803 drivers/staging/comedi/drivers/ni_stc.h David Schleef     2009-02-12  1139  
35bb871663ddb0 drivers/staging/comedi/drivers/ni_stc.h H Hartley Sweeten 2015-05-01 @1140  static const struct comedi_lrange range_ni_E_ao_ext;
35bb871663ddb0 drivers/staging/comedi/drivers/ni_stc.h H Hartley Sweeten 2015-05-01  1141  

:::::: The code at line 1140 was first introduced by commit
:::::: 35bb871663ddb06df9d601b32deac5f4f06b65b4 staging: comedi: ni_stc.h: final cleanup

:::::: TO: H Hartley Sweeten <hsweeten@visionengravers.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

