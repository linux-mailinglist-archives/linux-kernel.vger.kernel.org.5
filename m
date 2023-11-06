Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A537E1AB7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 08:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjKFHHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 02:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjKFHHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 02:07:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44460C6
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 23:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699254434; x=1730790434;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8kG5IPyx8Zm3euhqZQAmwbpPi9+dogbGCWZSIECkneI=;
  b=WTSwLEz6xI3M42IKTs1jdlsPQINbR7m4tmGozOJkkGi7bT0c4L/MTL32
   rpCEidvHaD1s5WB2LlWgAlE9i6Jvd66u5bM+9QPudHY4yogu6fMSHZUfr
   FUIGGLIMVAWl9Ic7TUEAbOuF+uqIaFfFamx1vhffb7drmsdCEXluQ4PTM
   5CcM0Dmx6AoxLN6OxJ2RibcDG0EX2w/eBSUwgln7lpTZQ5MwVQhT8ipMY
   PbVZfLArVcEugDwkT+FiGNQ6yJCmyKCxAVCZkdw71gSvfY1PkwsvbiF93
   rmvERTUdZLQaRn/7bRgF6vJZX7xwEfAezLt5GhEtnt7R/cNK/IFUg8zT8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="420334695"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="420334695"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 23:07:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="755766525"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="755766525"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Nov 2023 23:06:59 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 5 Nov 2023 23:06:59 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 5 Nov 2023 23:06:58 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 5 Nov 2023 23:06:58 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 5 Nov 2023 23:06:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGeFmaDnNKMCy4nHv3LGYLRUmY84vOxjd1V23jXpVqUv+hh0qUmv7SAg2kUE8EZ+U1Vl7R1hwQpU/eXknkyo/GVsH1F7hazdfdDDOxTJWB14vwgSWr+q+E0SSycdUqU1mSsFLT+dUVqBx+tgJOE7uwBvaLXkSVBZnIB0pw+TWX1/NCf9BNDKZIzaSn6tbmnES84FH6s1mjoPO9iUpMQ/ktiIMj54PVL1Ioyh1TobtvGPbH3tiiQsrhzGLlwZ7kDlUY9ELZoy/Hot6+I0QhtHruah+IehL0gUWYzBWT9ng+zvdh/YzHt9I0di0QAOF0VeTMNv8cWa2O6DGiwUVVL0bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExC0kL8TDI/49bmLmBebh9au79R2bbYT9bKq76Ceoxw=;
 b=Z4B7Nd7sEMOh4lHCrDQSef/wCEQ+YcKQas/0qiXRvO+NQjtQQozJqUdAM7K/JA40x6/FyVxmmKif5SbIe0RmXQzt1Ws4nN/w9irnD4CcdXv21ZG9bSNIoJsWqz+wHpP45ITgVCwYl77wf0y/gJMDuMctFJslYq7pQ4J652JylhQLcR9i4KR2sF9OGBOvABv/j8DaxB/c/YM2BzSGhsUf/RcnPBQb4dsmfzjfuE/g9aUeMhUJ1Hjou3N1fMA9ETCV7/ZlgJqcZuorwXmgdPZ8LKtwSfNtiW4/mLRuad2tY09r6F03VCd22IAS0j0gvzWSui40ABAlQk0Smnc9FPcnAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by DM4PR11MB5405.namprd11.prod.outlook.com (2603:10b6:5:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 07:06:56 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.6933.028; Mon, 6 Nov 2023
 07:06:56 +0000
Date:   Mon, 6 Nov 2023 15:02:12 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Jason Hu <jia-cheng.hu@intel.com>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Jin Qian <jinqian@android.com>, Alan Cox <alan@linux.intel.com>
Subject: drivers/platform/goldfish/goldfish_pipe.c:654:36: warning:
 'goldfish_pipe_acpi_match' defined but not used
Message-ID: <202311060705.NthRQ6Om-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SGXP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::26)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|DM4PR11MB5405:EE_
X-MS-Office365-Filtering-Correlation-Id: ff0987dd-a4c0-410c-d393-08dbde96f63f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xz7J91gU8TSSjnYTLp8pQ/xg9+UHu5QUQE3cd5NdDmseDToVRPKHZ2mkHMICS/JU0e/HO/JYnouItSegNydThBeT1v/pEi8aXCaidcjyJbisxYYk/xF19UoI1DAKOsHwXSPtdZI1002dhyHR2m/f4EMZkTLfZIyVfFhI4gVo9hBknHChgG/+Ek0BS69plJ7cGTfKguyj/Z/DKZvRoFI1T9JOXq9gZCsucuZ4vZ36BJFxmRPpgfzN5cbrYmKox4817k+dtpr9kRuwR5cjN6jsEiQppnvvDBX72DY3dK65RfImF3/AMH9wfuJO9b7OLFywmxwJw+HXuCQm93EAOlWs0ecv3pXeaE4T8OWgynBwTL4DLtr4VDbjuzDpbP7vxzfr8UzQiXsb6FXuDyUZwU0JlQhjAOsqBRMMtgGKABzYa0MlhS1XqVqrMeSfAq99ZlAUMsyrb3miKMM9XuxIb/bAWc8sY7+b7dMeJfLGF28Yo6IHb9Avit3Go7JU3giI/LO8tjdxjAtfzxFXdwNDa6ysseDFRJehpgqmJmqG/mCazF8st+H1pa5oAGfXCXYjDZuHhDCavdp8s2LX4BEPThQ8GOGjfdjpa+Vyxwo9uBTiQ1s6fZ/VxojWxvGGAKVzxMmAAtSXts1kHa3S3qmAU/3oVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(376002)(366004)(230173577357003)(230273577357003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2616005)(6512007)(82960400001)(1076003)(26005)(478600001)(6486002)(966005)(8936002)(5660300002)(36756003)(4326008)(6862004)(8676002)(41300700001)(86362001)(2906002)(66946007)(66556008)(66476007)(37006003)(54906003)(316002)(6636002)(6666004)(6506007)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jGhWMdj26mkzzLcSLjuu6pzzpuxbaV1zVtmxLdSqRNS2MQRrsLqoDo/g1PEF?=
 =?us-ascii?Q?QFYuHS0JDVj0da0nTDG952sxlhKAGTm0eqcjqqZVJz4jx64RDkLDfaSlnKJs?=
 =?us-ascii?Q?8A3jy7POeyi/8b6PgGaIYZ68oaBqp3s/wEVnkg6xvOWJZIKUaEK3P8ikV6Ev?=
 =?us-ascii?Q?LIJuIYS8E06R9VV/FqoxzDoINtr6NihebmK5NHd+V/DC8M8GbYV2ugCl3jqy?=
 =?us-ascii?Q?4y3BzrAVKJrMR8BYTzURnVVfaYlXpPtEpNoQYoHu6rq/863UNewCaMy/OYUg?=
 =?us-ascii?Q?l6Y1OibI6uPGNJ1AgaW016CBhkLvffWllQ3XtyxILjTacP6eoq62ip1Fj6+g?=
 =?us-ascii?Q?vL0q82p/uHMoYOQluJfWy0m/eXfLJzJtkRhuPHSJ3zapboDW8h931zcs3e5T?=
 =?us-ascii?Q?4FlJV/YJrQHPMSUZ8euX7RzE9GJgHSbWDoqrYfpNvtS6pV+iyFZpEv6P3aZS?=
 =?us-ascii?Q?TtzIfesA+vCS32gSz/5msHupOtpwBe0W8Hje4zPi6KN5Wp6fmY+hkvCfUKP0?=
 =?us-ascii?Q?3pxbPLndnDjYhCygtQsiN1nzRE0Mg3N/kWeogriQJ8Ay1r/sn3P/esfkLPmC?=
 =?us-ascii?Q?6ebjtrAU5QTgSF0DZPhP1h6H50hWgzYe0ZEjHn8N4Bu/m+QYGZ17suwFbPHr?=
 =?us-ascii?Q?mZa/AbJlvg7ynGEbmvdaiWba0yajMLNH/e7fP7zyVQj8SkMCeYAP/Ij3gNiB?=
 =?us-ascii?Q?WlvzSOjTm1Nh8N+jOwRWiMw5Cea8jEi4y7+jFqxtZ6R4OvYxfal6wC+CjeyC?=
 =?us-ascii?Q?hpy8UwL54l+6tGVubxwK90S4qX5yO8ejSU/F6SW7dvlZOh2iZFGaxMbwxzQb?=
 =?us-ascii?Q?Rq7BPRs3hNq3qV6tueoH6WJLETNzjZc+QFmIxl19bV/DLKrfATh531uj91J2?=
 =?us-ascii?Q?2PwKP052HbbZ1U8yoKnaI7tO8nuwiJj/kpeY9I/g/JK8JWKUHzUkv3TnygCt?=
 =?us-ascii?Q?wD8LcBGd8FnArx1R6Hoc6IMNaCmr1C4MkMmEwwm/lyMC1O+Xw4+ssJ9d01qp?=
 =?us-ascii?Q?sic9UkuOexRuOTOeCDNiaeSs0gfhIf1/HvqJ7/wWNtTrtdcVjtQZ209gJtVK?=
 =?us-ascii?Q?t9UTEm6c0i3zv7RBfqYP8POClgckOaXhBtw9W8ZVZZkWqrWXtnSIMuBLnRLf?=
 =?us-ascii?Q?+uOIHVkr3IDQtdcyNmmVtlJlLTbO+3kt5IkQGqROo2QuEWVU1VyPaVFZGcJ8?=
 =?us-ascii?Q?wQtnX0SpjEgcdVu5KLAyj1z0c5xUzDl31idLCyA9FPgO+JfNZVz3fsQ4SgIT?=
 =?us-ascii?Q?f78lpUXe652L/h/qBfOettyZd7BCzWu2rwLnjXKGY8kTNJMECz7pk5d2Fp44?=
 =?us-ascii?Q?OJsUCIRLmM1aymDk8IdwGlNL89JB56vZZgPQPObHfBdBP7vvPVORuLwHEtgc?=
 =?us-ascii?Q?we9seCZj0h6zmEg3kf1nSAgBsgRl99JAI3HqYkcn8T28s63dMGZs8VHVVnou?=
 =?us-ascii?Q?1OHwBcqu7B7DuZBg4aqickklbh0a9jgzlcJWiOpDw7b/vfZ/GwhJzDCRG+X4?=
 =?us-ascii?Q?LC4bYn/Ki/JlF62HCjPEpI5baL2x7QbU/3KqyuTX0ajMYoxmbFF7e74G1RrH?=
 =?us-ascii?Q?tRBQp64QXRmiq3QoGiXePlKSbwuP7V/5wDR0t9xm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0987dd-a4c0-410c-d393-08dbde96f63f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 07:06:56.4742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCk5bhFfAu+vo85W0gQ+pFV8bB5OPYZvFARtpG+nC3j2qFBP8+IiAIJdoFA8qSXUzqp/7dnwN32g4JEs7VX0yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5405
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   77fa2fbe87fc605c4bfa87dff87be9bfded0e9a3
commit: d62f324b0ac80c3923ebbf897735c7c24ba887b8 goldfish: Enable ACPI-based enumeration for android pipe
date:   8 years ago
config: x86_64-buildonly-randconfig-001-20230831 (https://download.01.org/0day-ci/archive/20231106/202311060705.NthRQ6Om-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202311060705.NthRQ6Om-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/platform/goldfish/goldfish_pipe.c:654:36: warning: 'goldfish_pipe_acpi_match' defined but not used [-Wunused-const-variable=]
     654 | static const struct acpi_device_id goldfish_pipe_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/goldfish_pipe_acpi_match +654 drivers/platform/goldfish/goldfish_pipe.c

c89f2750e9845a David 'Digit' Turner 2013-01-21  653  
d62f324b0ac80c Jason Hu             2016-01-06 @654  static const struct acpi_device_id goldfish_pipe_acpi_match[] = {
d62f324b0ac80c Jason Hu             2016-01-06  655  	{ "GFSH0003", 0 },
d62f324b0ac80c Jason Hu             2016-01-06  656  	{ },
d62f324b0ac80c Jason Hu             2016-01-06  657  };
d62f324b0ac80c Jason Hu             2016-01-06  658  MODULE_DEVICE_TABLE(acpi, goldfish_pipe_acpi_match);
d62f324b0ac80c Jason Hu             2016-01-06  659  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

