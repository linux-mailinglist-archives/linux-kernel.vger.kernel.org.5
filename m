Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEEA80C3EC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 10:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjLKJD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 04:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjLKJD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 04:03:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97ADD9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 01:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702285442; x=1733821442;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2jW52o4qb9S4AI2mxXBCjt65TyOoc1THxKjE/qpIUwA=;
  b=KdS0ukt1kVurWtlBJnFLkymTrbGbYa0ltpwpKv0V5YH5iX12YXDJQOhi
   kou6fZWrT6M1jCQwsugmTsgdYywmnpcCcdz+z3tNkd24gBZVRAmspkjfR
   wpRj+Y37c/yNUN3zhDCA//w2eF/x3+eZgs2zQoLwQLhN5qdLC1rVoB8qE
   II+spx2PUhwUfuN+C72bfkkb2TVw+S+8X+ykSyHzUjFrM4PO4sKipGo6H
   6Ubf7+5X+lQR7lrqJMNvPNEyf8pzKEEGfUgrq3yIcztwWsk9rhBS683F2
   0fnIZMzD+aMDR91VGuWkfLC3vEFkdeiNpPxFobIa9jDl9lhliYmDb6/40
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="458927068"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="458927068"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 01:03:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="772970600"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="772970600"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 01:03:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 01:03:44 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 01:03:44 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 01:03:44 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 01:03:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1gTitn5X76YVDCXYPVUvNgQsFJ4a17fYtRVSpdy0UG7MCQlXba3dTJW+oL3i3yNUfidR7yaO2ccupXAoFufdex59teRI34uON6g8SCtiJ8++Ii1uSc7LMl0866Vpcm/2kO5nRLczPKzF/R1GUA8tnrmO9s+pTQ9Sx0h1phMpTvKhAvlr3z0sRLuY82VBWVThEi1iJSQgMPLnbEm4wN0tW+rD0rzLXgEIjl46XH8w2ko0wQdaGzTlL+TMEx1r6xy/XOrHYDpIK/s4genRMxnmi/JEEW2iDdJMi4iujinKlMgeEgIWCyBNTcwsc2l33QvUMqMDYbXRQDIl1EPIFf91g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyDP0L876p6qkw3CHBVpLYCdDm4IQHBGugfVAIUwXl0=;
 b=Kkpm+GcqfiKtTvRkXQkeb9oCm2PUVCS8PH14AkZvwF0kdmVtIr6h7n28RIQ+atV4m6V/rkVZAc2c8ISACfP3hzh82iyL+uK8tR/s5T6dqr8h7Zv2+35djuy9153ZcLF4uSHxy8Z5Hos57N3zjOK68TQ+el82E5ptZvAbaIXNFaDhtW5fGsYs1f5byhtV8ihUl2+ioSE/QAcQnXiULW/S22eCO4BjaWVN5P3T40fYTHreUCm80LCKabeLeUnuEH8hBuJV8iAfjCYWXIo23hGBqLkSLw7TBkfOosDz/I8hSqRzh4sezwRT/ltjOaV8sA7gG/IGt6SvxgUxZKmKz3gZyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3006.namprd11.prod.outlook.com (2603:10b6:805:d1::24)
 by SJ0PR11MB5167.namprd11.prod.outlook.com (2603:10b6:a03:2d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 09:03:40 +0000
Received: from SN6PR11MB3006.namprd11.prod.outlook.com
 ([fe80::7f2d:3448:d474:f74e]) by SN6PR11MB3006.namprd11.prod.outlook.com
 ([fe80::7f2d:3448:d474:f74e%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 09:03:40 +0000
Date:   Mon, 11 Dec 2023 17:03:24 +0800
From:   kernel test robot <philip.li@intel.com>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Palmer Dabbelt" <palmer@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: drivers/cpufreq/cpufreq.c:475:17: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <ZXbQXCXVh8uK4JGc@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR04CA0154.apcprd04.prod.outlook.com (2603:1096:4::16)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3006:EE_|SJ0PR11MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: e62d43d3-1d54-4dfc-a4c8-08dbfa280c44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LGEGZClIwNgBsE+wZZvkmHlsbXo03OlBu6tkqhIgWlokYMS8/C/adi5jq+Q4/mU51vCtuzrF1Bus92uT7Lu93Fpahz5rdnRbIviK2zy9ySph4Wu04KECO5NCThEKA3hIRhTP1NVMGsTErQiW3VE0cQdHTKCVtv0LTgiihUNAqRQBVbGrx/8KEDpDgceC2kR55CejsBho1hhgshW7iUZgyak957fkq74wkDA4Bn3lygA1AhYpJ/Zbfl+2EETu0p//8Ep8ld5wFhL16FrrOhtkFoQ8JBu5DJIlpR9MtGfbncDOyHPShT1oZvZC2vSai6+0x2Hw87K6Jfm5TUjYgvXY6PKRg3L8cfX6ikq4LhbVmrM5XLVoI/ef7et8v0S2bhvQAmlG3pNq4f2k5qr4hxcQ+UolCsq36vefY4QWIXjFFJ7zipw/oMmKkR9X+8qhzl8KYFoPMxV8K47KHEq/0goMVH0c0alpuDG7TKNuolvHr7Y+ymBj2JdsmI730OJHya0RXzCGSLhmHyP+nzQymx92KM1KsYLxmXfSL8C5z6lmw5YNM6HjgtUaocbZg+AyUKFCj6lR16fy6d4uEzWsLFTQv+V9qF+jIKgnGzhEDMcSnoqFpXg/IbaZG+Z8lrQkv2k/zgVWENT/yF5wEBB98HQC05+h6KOiBlSvmNn+bDAdII0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3006.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(136003)(346002)(39860400002)(396003)(230173577357003)(230922051799003)(230273577357003)(451199024)(186009)(64100799003)(1800799012)(33716001)(41300700001)(26005)(83380400001)(82960400001)(86362001)(38100700002)(5660300002)(316002)(8936002)(8676002)(4326008)(2906002)(6666004)(6512007)(6506007)(9686003)(66946007)(66556008)(66476007)(54906003)(6916009)(478600001)(6486002)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/77sTkSfzMhoD4+jJ5j0uPmaMMpDTy8msD22ZbJroofx8dZ0PLI/6Rx/scoy?=
 =?us-ascii?Q?VaHjsQtHt5jfuSvBggdy0cWi0P2wdJevvcRn5TKdk4eq/mqM9tEySqhL5keX?=
 =?us-ascii?Q?NTWBP4pIhlYpxC0eSVia8Z2QzyXeiZ1A4QFTxbk9/JqV7ebGA6ZanB2mpwR8?=
 =?us-ascii?Q?ixEouANincAngrbm0mtcQor+tuDHeE/UORMJY2YV53jSW0LEmpPb/THQjh56?=
 =?us-ascii?Q?zp1EJstqr4NEBg6pWKTu4T53ezNDdP6F9PC81Jizp4jEz9uBvCa2xF8UFvzC?=
 =?us-ascii?Q?4d67un3tove356uLtJ5sLEnFv51bHmgFT6w3nZ6EIPyXT0Vo9jQMn/m//0gb?=
 =?us-ascii?Q?GqJHCA3XLrV2WHz8Ztr2jQO2DZei0eNqyRfHOGTCbhXT52sVomltTphogqKJ?=
 =?us-ascii?Q?Qo08jear/Ap5ciZ4SZBJruNCO/ErKJxpZzAljcTYSz46xw9LkvmDbCE6/mNa?=
 =?us-ascii?Q?M3QoZ+nhUS0Eao1yxNuTn6Iu2ta3gWsw0IYgoVuOOB15X2GFb/ta3jHblLxq?=
 =?us-ascii?Q?EpFKn67Rz+oNgKN7nIv50wXi7gdpR+169pkK6UqIBrRQCMhYKeyVQKWkrOjQ?=
 =?us-ascii?Q?mAughfYoxhpSUWWugLdCIBQOe9JKmHwrBRQFXscnYRkivlXsi2LvHjJYDzEs?=
 =?us-ascii?Q?8CrvqTdXOueqs04KdXHyc+wifhysiGlW6Ql8PGLTAoETEKqdnxXXxrRl1HbJ?=
 =?us-ascii?Q?mfZbMIxpxnQHUJAifjoIJLqq9LP0pWIVkdLVYj7uw+QEwP0p7CK2Z0qzObuv?=
 =?us-ascii?Q?J21BgRXdA8EhUycaI/kWPU738yTq+fXmgXDgoVeYdI8J8scwn/W/kQF42dhk?=
 =?us-ascii?Q?OJB/N+kUGc2Ebe47eE3+7T65iSMLiU460KPYvOq/ygfTKV6oGYyrgWMzZWab?=
 =?us-ascii?Q?5fs5Ugn6QybiPonKejwxpCLwCGv6z9O+tnY7/NRaagKEXwxv8DpgV23zv84v?=
 =?us-ascii?Q?vsHS3Kb1AAbtjDGBatVbE7SdZ7/FwLB7PMl3z0vbwXkFGe8TRsWRIZIFjWZZ?=
 =?us-ascii?Q?UNkPpsSYssKeXcL+tiNmAKbjbcENXchD8QSsXC20F/ckWmQgG4P6OE/dF9La?=
 =?us-ascii?Q?twYRXHpyPOdwWjgsiaGDUVk0sEQEdL7IBa1SwvBQxPtYDItWqptoV7gVqoCd?=
 =?us-ascii?Q?8vD6E2MmwvdEkHOlMFqUnbCs7Roj99uEpzOIohmp5I4h41aP95ggGoIs7U+V?=
 =?us-ascii?Q?9ImS6TnoQAWJxw/PfuAyr85U2px0erBh4w0OWpss3O5sfjFGCRSBKNDQturt?=
 =?us-ascii?Q?cvyc8ZNRrfZG4BTjsDaaa8ZcOfRK7SjDV6f7XJNuVzclKyVduLrcC7HSOwXf?=
 =?us-ascii?Q?5+sX76WCIXIY4MpZ6pCbTeyQRKP7pq9upGt4GlhnEVirB+pp/CNmXdSCe3Pa?=
 =?us-ascii?Q?v9othr1x1DvPiBguqkMFizn2dcw89Td6CA0LlGi1h7JgbdFCiN3FOjE7hT/y?=
 =?us-ascii?Q?IA726KhaGG03cbD6dLrzsFXMHau2AR+zYQ0VYGFf3otBjOPhR+QcEFcxcban?=
 =?us-ascii?Q?kjHfGcalxKjNecjnER2msGe3jS8Agp85vShHjrmkPSGrTHSxcs8bVWmUsFni?=
 =?us-ascii?Q?whWzlY84y8UizhkNYvI92CdG1VZzTnrsBGeSLpFY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e62d43d3-1d54-4dfc-a4c8-08dbfa280c44
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 09:03:40.6404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uahPmtkhQYL6gB+V6Rmwzqf/ezGLNRtNwB0oFUQjux6N3nuC0SHuUw28/Nmq2wmq1z5PupM8fHFJhlkMwLclkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5167
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

Hi Lad,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3b47bc037bd44f142ac09848e8d3ecccc726be99
commit: effae0e3d9e1139d583e9b5d050f4f948825b8a3 riscv: Kconfig: Enable cpufreq kconfig menu
date:   1 year ago
:::::: branch date: 26 hours ago
:::::: commit date: 1 year ago
config: riscv-randconfig-r031-20230608 (https://download.01.org/0day-ci/archive/20231201/202312010059.MQ446XMR-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231201/202312010059.MQ446XMR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202312010059.MQ446XMR-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   WARNING: invalid argument to '-march': '_zicbom_zihintpause'
>> drivers/cpufreq/cpufreq.c:475:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct notifier_block *nb @@     got struct notifier_block [noderef] __rcu *static [addressable] [toplevel] head @@
   drivers/cpufreq/cpufreq.c:475:17: sparse:     expected struct notifier_block *nb
   drivers/cpufreq/cpufreq.c:475:17: sparse:     got struct notifier_block [noderef] __rcu *static [addressable] [toplevel] head
>> drivers/cpufreq/cpufreq.c:475:65: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct notifier_block *nb @@     got struct notifier_block [noderef] __rcu *next @@
   drivers/cpufreq/cpufreq.c:475:65: sparse:     expected struct notifier_block *nb
   drivers/cpufreq/cpufreq.c:475:65: sparse:     got struct notifier_block [noderef] __rcu *next

vim +475 drivers/cpufreq/cpufreq.c

b7898fda5bc7e7 Rafael J. Wysocki 2016-03-30  466  
b7898fda5bc7e7 Rafael J. Wysocki 2016-03-30  467  static void cpufreq_list_transition_notifiers(void)
b7898fda5bc7e7 Rafael J. Wysocki 2016-03-30  468  {
b7898fda5bc7e7 Rafael J. Wysocki 2016-03-30  469  	struct notifier_block *nb;
b7898fda5bc7e7 Rafael J. Wysocki 2016-03-30  470  
b7898fda5bc7e7 Rafael J. Wysocki 2016-03-30  471  	pr_info("Registered transition notifiers:\n");
b7898fda5bc7e7 Rafael J. Wysocki 2016-03-30  472  
b7898fda5bc7e7 Rafael J. Wysocki 2016-03-30  473  	mutex_lock(&cpufreq_transition_notifier_list.mutex);
b7898fda5bc7e7 Rafael J. Wysocki 2016-03-30  474  
b7898fda5bc7e7 Rafael J. Wysocki 2016-03-30 @475  	for (nb = cpufreq_transition_notifier_list.head; nb; nb = nb->next)
d75f773c86a2b8 Sakari Ailus      2019-03-25  476  		pr_info("%pS\n", nb->notifier_call);
b7898fda5bc7e7 Rafael J. Wysocki 2016-03-30  477  
b7898fda5bc7e7 Rafael J. Wysocki 2016-03-30  478  	mutex_unlock(&cpufreq_transition_notifier_list.mutex);
b7898fda5bc7e7 Rafael J. Wysocki 2016-03-30  479  }
b7898fda5bc7e7 Rafael J. Wysocki 2016-03-30  480  

:::::: The code at line 475 was first introduced by commit
:::::: b7898fda5bc7e786e76ce24fbd2ec993b08ec518 cpufreq: Support for fast frequency switching

:::::: TO: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

