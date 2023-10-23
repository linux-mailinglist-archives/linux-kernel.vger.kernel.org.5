Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25527D27C2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 03:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbjJWBB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 21:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJWBBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 21:01:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8948E8;
        Sun, 22 Oct 2023 18:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698022883; x=1729558883;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=Llelhy1yDetXsf4Lkb/ItT0HrURxTLih6mnPW/hk80Q=;
  b=jwlYI4n7HC6RcwzLcD2nw4EtJ2zQ6MZaT92J3pHOhrqo35r6uG0CqgA/
   i4a/xwCR3Oj43kxDcBpYEPkctL3TVPu1T9BlqutlO9gFooAUnDN+eREaf
   J+NdJrl2MhdqX8IMho1nPSwmHtsRkm2VfTES4VVtrct1FzXftlXNDvY7h
   JBYMRIdMKcAcTCMt9UEYfYbaTspYWPLiGIHztkF5E/GXdRFRHA25uNXiE
   gsFCQG0C2yd2/1pex75A7oMbSKA2aoq6E+DbjnKabKZcRxtWXEctZjf5V
   v+e22dnRxudDZMQOlScE5SKi8R0Z1wlPLLnL5UuLzHw6d9xKo1mnoidmi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="371811742"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="371811742"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 18:01:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="823807416"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="823807416"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2023 18:01:23 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 22 Oct 2023 18:01:22 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 22 Oct 2023 18:01:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 22 Oct 2023 18:01:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 22 Oct 2023 18:01:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSZjkRL4x9cMZehI7N3gELTjeeiaQbfVS7t0bNMlNk8YAKNBRdxVjM71/bgehArCSGvB1x1hHoN5P0ayHiFV3V4aQbd/UhUuTAFYqfGNIvB30pz2BECPTUXtbLxJSAAOovLVUCrkGH+hiXIZRWbtR9U4mnXYWaQ2+TACRtViq/AXrGEx/TztrMGIWAueFKFjQCX4tY25dhzU6TLu5daRsjmQsWZihN1phYLN47gf7ZcsjhkWVd5y2n68H/lB16gzGWv/Vtbitexbj/CAHNl1RIiVCgth46H+HmmQgv26GFvXm9YkX2YChdKiurshXz2LWOkuuMFVUUCRydh0G/7sqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t73esVpXSnwShtn/q76NY0QyphVPGUmQpn/80FceF3o=;
 b=MAYUiyOimQWobtN0XZoZtL/l8OHrRZHP41N0edMmAheI/kzH/FIBJf3U1uv3BiyRiND5ZEjxsU4yrutHksGWQ0deQ7O74vJCpqhsth0ww6m1LvBoqEibpM/QqgrC5agKuDkE0rAYXN8TWMcfOycsdrVbXcej4e2otLC0mFJLFUuLI/zEadZIn0dpxdyIQjCark+D3CHN3x7o7L+JGHELRfYEgvuwujveKJvV/eqpRwcXBCpGc9P/Hu8vP6PsiD4pKqI2pvHW0lSEsyp6l9mAlW+P+cDNqu0zoExlNV8Oa8bCFuogvyB3LyWdjkOy71PH91VC4uAWx0U/1cVb+0zbag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by CH0PR11MB5234.namprd11.prod.outlook.com (2603:10b6:610:e1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Mon, 23 Oct
 2023 01:01:16 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::21f8:775f:a94d:e1c0]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::21f8:775f:a94d:e1c0%4]) with mapi id 15.20.6907.022; Mon, 23 Oct 2023
 01:01:16 +0000
Date:   Mon, 23 Oct 2023 08:56:26 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     <liuchang_125125@163.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <oe-kbuild-all@lists.linux.dev>, <mark.tao@bayhubtech.com>,
        <shaper.liu@bayhubtech.com>, <thomas.hu@bayhubtech.com>,
        <chevron.li@bayhubtech.com>, <charl.liu@bayhubtech.com>,
        Charl Liu <liuchang_125125@163.com>
Subject: Re: [PATCH 5/9] scsi: bht: include: Add the header files related to
 Bayhub specific struct, enum and macro
Message-ID: <202310230123.kYU8vEt2-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231013083358.10313-1-liuchang_125125@163.com>
X-ClientProxiedBy: SI2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:195::11) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|CH0PR11MB5234:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d99cf8-adf5-4760-67f0-08dbd3638f63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bAshULCwvcyz6Y8m3UWkbjcMIvB2ZqBo/YLZRy/TqQ5/LMYgvoeycZ1BikPSBMH52wzWC13NZsVpWg2+7Chf8xFp23dl1D1jKZtyFTe8nEzKPnB869vnGnakVKR7mZTqUGp5kqKveJuxGOI3fGaseJ8BJ0RUqJ/PlwMl6Ddc4ZUAU2f7c37cN1wq8nx6E265Sn1yNEvizwG5YhyNF9xotT0D1MXwvu9Nh2oQh1O9VeZyV9VzxU/xJaK+xos/z4GC4H2sdccGQAR0MbBoPkhK5Vg4oDY43qxOYWbrOlBd7EohcsX1t0ZS711x5VURdQPlPuXJLed9hprq04lOzPELXof7GMV7XYf6S2ms5NBox5jJ0jIsGo7a/egMGalrjB4XtJqmuT/pTz7KFbexLZIhjCB7wCm5CoXGMg9dy2PpDNitVnY8mcX38n+Kj61u6J532MCVJMFPkAV0o/ocPwMhmAkmyPgqQU7WpIFxCITipFd26/C+lQ/WpAswKwgN6TxA6MaQCGsWqPnZhYrNOsPQyYyDoro1fVSYRXdFI4YfJlxr6tZ2bkYq70S/+9Xuz5EJ12DVuVAJZUukVeWu59DZMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(396003)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(83380400001)(66556008)(66476007)(6486002)(966005)(316002)(66946007)(478600001)(82960400001)(86362001)(36756003)(2906002)(5660300002)(7416002)(8676002)(4326008)(8936002)(41300700001)(6506007)(6512007)(38100700002)(2616005)(6666004)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kVW0GAm5fCjZP7BX4nchJO//CpqGsRypUdwcfZPB6iR1p4Rf6VvC7O/mnxaz?=
 =?us-ascii?Q?ZBp0X4gIKQksyi4qMIDc9hbRMCiGRuwpxIT0M0pFGh4EavqRZXdWqIE7GnFx?=
 =?us-ascii?Q?UtnaUT9EnzbdLZKG/KCMwZ7xooTZDgy6d9ZRh6e0fCWnRv8hyCzWVLIDbGpV?=
 =?us-ascii?Q?m5xIO/h8x0b4UBb2+9bNm4wT8OTmvNT2HhEnfpd7Zkk/hZhyUsKKAMFqbYBb?=
 =?us-ascii?Q?iph4wSC+XrloxUXUjDxaCdBvP7Ffogz2robgU2jFx1snudkslqYDTkTbHT/m?=
 =?us-ascii?Q?f+9T1mxkKmPq/KDu5Jjo7OjfEqflKhOqyAAu2DIax17iyNQbaYMlE4wIHg6j?=
 =?us-ascii?Q?wPo4ZLnmgdHQY45RNuKhSnP8R9ls/0vdO8yTkCXvZb0HKodII7fIqNAM1a4U?=
 =?us-ascii?Q?Kj+PidSgoXcy71OOUBHO860Ilmep0pHjrJkiKhDf4Oc9meLwawNFA7UC/VVb?=
 =?us-ascii?Q?4DWoC9JXOolm915OlHU1W2QCF4c4TeAAa3S3CA9XwQvP5AeoIfurfKvtr191?=
 =?us-ascii?Q?y8JNXNI/nXBK+EhQUU81C2LHjQ9MDH+NdTksncf6iq31ZLi//VHSkjDJeGvj?=
 =?us-ascii?Q?EAbogZgdJUHwYe8LSetWu+wBhjUS0UnEtYUaUQAc9peL0aFjFtnG17mzA0nD?=
 =?us-ascii?Q?UHYSVCPB3wtANtBb1Dbs0qbHFLYIEARLJINhIsf/DeTIaQ2Gj16MeG7gHPyb?=
 =?us-ascii?Q?a1kINfCG9/8ObskxXyrsKDBGt7K2BRb212ULw1itj9asxgRNqD8ZeoW2mPn+?=
 =?us-ascii?Q?0Rn+H+hD4tHDTLo7OC78oBj1zX1dJrWP8/tbA4nbUYrjNp/swatDm6ueyuqb?=
 =?us-ascii?Q?lX2KwzNVfpd43H2Z5Q4q0uPUxEnt5j9eUV6n4Qqv7Jr9yTtGT4a1/es/tsQu?=
 =?us-ascii?Q?Hthc7bC2Mpk7b2MntSjBFRblVCgxCSgXZBjo+bXTscYgJIyUAT5JZQCPgn8t?=
 =?us-ascii?Q?iPT0zQLJ/Qio4EXY9K0pCpWiDn1dipCJXc8wKqFPT2wkXO0FQf7x+NwsneEn?=
 =?us-ascii?Q?+SWw2cbaqdHgpzHGulZqd8GOuuneX7X9PjQ8f/6qNltQ668HhVkR2BaZfMp9?=
 =?us-ascii?Q?fjvm3Se8MwTVA5U6mQHlVZU2E5mJnZOSz9lvduQOSOgpLBZ+YJ8vMUsXwc1o?=
 =?us-ascii?Q?lXDNkeg3LZ0nu8zVRmI3LOOWAd/chDYpsioQ5APt4k71pMgJ14e4xC5/5G7J?=
 =?us-ascii?Q?Nq3MDqhwRO5c3zv3lsJE4u9O6chfG4aiXpDZpKRjVVvp1z7nPcBoi0IaxuPM?=
 =?us-ascii?Q?Ri9ua23ygMFbfFPHQrnqRtpNzvO1iYdJG6quT+NELAjAasYQQALRCZA/jI3F?=
 =?us-ascii?Q?CO4MjSm+ri0Q8bOyQM4Y+F88cw7YrbKUYOf8rHROJ/NLJqinJfNmw8U0zER0?=
 =?us-ascii?Q?SUWg/yTIIi8XT2P1lVJNrzScQ38xJS4qXi0RPOI4VeuWpddJR7EefbSWldjk?=
 =?us-ascii?Q?et3dCkuVFebFy6NYVtW7Kw6PNiu5vg2u/cN867+mo2wcn1r+rtOohAOttK4t?=
 =?us-ascii?Q?dZkbwvUnpDDKMQjmMHWX+tsUOjek7gEqZcSjJASo4JJQ4QRfK2NkTMmen9dM?=
 =?us-ascii?Q?NtxLSGCvrvBjf8Mv3snLIPkRlZePV5RJF9j6bNAU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d99cf8-adf5-4760-67f0-08dbd3638f63
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 01:01:16.6638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cv6VQzgV988TedpZNtSXaQPQRA/1wX2eh3zOfPp73IGtfcN1F5NHSl0/GMkfzJ3sPrzDupOvSm40UcampTOFJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5234
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 401644852d0b2a278811de38081be23f74b5bb04]

url:    https://github.com/intel-lab-lkp/linux/commits/liuchang_125125-163-com/scsi-Update-Kconfig-and-Makefile-for-supporting-Bayhub-s-SD-MMC-Card-interface-driver/20231017-123349
base:   401644852d0b2a278811de38081be23f74b5bb04
patch link:    https://lore.kernel.org/r/20231013083358.10313-1-liuchang_125125%40163.com
patch subject: [PATCH 5/9] scsi: bht: include: Add the header files related to Bayhub specific struct, enum and macro
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202310230123.kYU8vEt2-lkp@intel.com/

includecheck warnings: (new ones prefixed by >>)
>> drivers/scsi/bht/include/basic.h: linux/delay.h is included more than once.

vim +35 drivers/scsi/bht/include/basic.h

    24	
    25	#include <asm/io.h>
    26	#include <asm/uaccess.h>
    27	#include <asm/page.h>
    28	#include <asm/byteorder.h>
    29	#include <linux/stddef.h>
    30	#include <linux/string.h>
    31	#include <linux/errno.h>
    32	#include <linux/kernel.h>
    33	#include <linux/ioport.h>
    34	#include <linux/slab.h>
  > 35	#include <linux/delay.h>
    36	#include <linux/pci.h>
    37	#include <linux/proc_fs.h>
    38	#include <linux/reboot.h>
    39	#include <linux/interrupt.h>
    40	#include <linux/types.h>
    41	#include <scsi/sg.h>
    42	#include <linux/stat.h>
    43	#include <linux/spinlock.h>
    44	#include <linux/sched.h>
    45	#include <linux/spinlock_types.h>
    46	#include <linux/semaphore.h>
    47	#include <linux/completion.h>
  > 48	#include <linux/delay.h>
    49	#include <linux/kdev_t.h>
    50	#include <linux/highmem.h>
    51	#include <linux/export.h>
    52	#include <linux/wait.h>
    53	#include <scsi/scsi_host.h>
    54	#include <scsi/scsi_cmnd.h>
    55	#include <scsi/scsi_device.h>
    56	#include <scsi/scsi.h>
    57	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

