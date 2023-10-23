Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F3C7D27ED
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 03:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjJWBZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 21:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJWBZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 21:25:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36386C2;
        Sun, 22 Oct 2023 18:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698024332; x=1729560332;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=GDJdAETLIziNh4cN75SjZvyOEmTfC2IC1ifXLGk9wgo=;
  b=YP5ouhkbuITdC8mhB64jsmRFI/KE911ZhXLQiuXT2JMsFzvllb96yaQt
   O+rjjbVFIjBl6PNa6Nnndsaz6Mn9ins2hXrngX6UyB2nDOtb6H5g3mKuM
   BcAdIEdBipOV40Ks7ZawfLHK6THuWK2kO82KRdxOwb4azFL9QPRuMVvH9
   Y/nqrOmg0gyB8m0bEJvuiOkgYZcUOorUiHoFIpBa2SNONdgY9CsA0BRnP
   vbLF6M571pVmN4KOop9z6wNc+qZCwE9DqbGUyPV/0EWDz5pLtHHXBly8g
   1cwi+a7AcUS0NRSwSrA+kM1Qkxa6RG3/98800BvMo8pZrh7pAYXwypnZW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="371814012"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="371814012"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 18:25:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="734501810"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="734501810"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2023 18:25:31 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 22 Oct 2023 18:25:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 22 Oct 2023 18:25:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 22 Oct 2023 18:25:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGxJ03fVfNS/ZzJG9Dea1EacTPMxAg/BFm90hKHqvO4zvVti38JioSGxwy/7Rm8rMfWBFb4elKRu/r1pdJpFvW8O9o/v6j8qymDWhltSwMoeCfXTiMVZ1Q6iyJOmLLEPV4/A2v/9ZrMvp9dsMAY85btmEBSGJGv3eVgrge1jkPxGJ7UtSgxBOqDLcG74L1hfA4s5fUHN3rLZJeM3Z5dT4SPM1PJtqSopoYJ1ovYUeLWKe/njCndLb8bHsMe2lzCDmgWrmnwQMJDjI9TKT4wmmb0+flwpPEU2bPZCOAqWYSLwP30O5xpN/MnmwUtMqNOSdH7bWCdTmssBDXBzNtJHuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kulXsPvd4iFVK9rLsugiRvs6vHTuT5ROUaUaqOBG4pY=;
 b=f3FWZoDzootGx2eRh0vgKL6QpQvD8G5bXYiSNE45BdhkfVdFp1N6HtTritTUyyUdkHaCOH6NzV2y5KcW0ScsedgQcDLaofebBCjSDvwzCVq55fVpzC3Nw+dhN3Y3XBJh2JE25Xyyhu4XmTiTlwju2i/113pVThACunn6mFIbrD6+M5IHlqhb3NUOUHYRzNbA5yMpLXbg9F5iAxWq4ba/8FUCJo9zFAtyhgQQzoYIpui4srOaJzAwRJi4K/96sZEhMECHWaMWPmYx0AW4ljvxyIKxFfcE5OwKNO+orpMm6SLQ5xeOiQr4ncP2Zp0pL4iIPxTJvLHePXiWwLC4eZR8kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by MN0PR11MB6301.namprd11.prod.outlook.com (2603:10b6:208:3c3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 01:25:28 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::21f8:775f:a94d:e1c0]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::21f8:775f:a94d:e1c0%4]) with mapi id 15.20.6907.022; Mon, 23 Oct 2023
 01:25:28 +0000
Date:   Mon, 23 Oct 2023 09:20:37 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Frank Li <Frank.Li@nxp.com>, <miquel.raynal@bootlin.com>,
        <conor.culhane@silvaco.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <corbet@lwn.net>, <joe@perches.com>,
        <linux-i3c@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC:     <oe-kbuild-all@lists.linux.dev>, <gregkh@linuxfoundation.org>,
        <imx@lists.linux.dev>, <jirislaby@kernel.org>,
        <linux-serial@vger.kernel.org>
Subject: Re: [PATCH 1/5] i3c: add slave mode support
Message-ID: <202310211527.TeVTMxA7-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231018215809.3477437-2-Frank.Li@nxp.com>
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|MN0PR11MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 39b9ca45-6a22-48c8-c6f6-08dbd366f0d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q1Y4PtFlzmofhO4WMBCoZ+INaR8u4BldBOlYWgVy+taEjhY5A6cYM2cinjNoDp9RZDi8y8NRLtAgBYzHTnt83ArPL7FbCGQzgWMWkFegrMER35mGOHBXkDa6KGBqIERZGAjvZ8DAuEFYg7JDfo7ITzo7XCwf08OJiYFuP9bPtyfQpXTqaLWf34/zA98c4/Yjy/YvMeH8HNv/2FWGwAJa15PiwNnErIdscf6xbgKSspimLuUSCA0dtHepgYtYRkDgEJLQsSMrEiMNLfgmvIGGlzBb1lymim6saiv8d/r7iNNMQeed+1MGZkT2ADxXnMnBBqDZNv0BjLPisy/gLnpqOBqc/KwiMrqxAo3y01UbsN5XMFSLMBylp09z8XcV8OTm1MJPiwQ7stg8476XV3Leu+qE0Kv8ll3fev7zetS4uJR2FVMZcoVjGt4KOFIONzrS456/uG4JU7PkHIBUfVMNsniTNpMfkO7cu1AGzmN/MEjkPo9CPPQj7gb3YSvPSnane/t/x/UqRGYUbtpwqI6jTu1svGGsS/isoerl1/zgvB++9vfwRRic6uC0fS0PL0U0DjhrHY5T5xBVHDfzAHiSgVRcuDktR2161AAu/zIHLITHuV9IsnFdPFh0x4UuecyL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(921008)(4001150100001)(38100700002)(2906002)(41300700001)(86362001)(5660300002)(7416002)(36756003)(4326008)(8676002)(8936002)(6506007)(478600001)(6666004)(26005)(1076003)(82960400001)(66476007)(2616005)(66946007)(316002)(66556008)(83380400001)(966005)(6486002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QssNjupezd39zV/EJaZgtKC81+U4SIYOLH7AV9FOpGTGBk5msu1MpByDGXY/?=
 =?us-ascii?Q?oIdW3+qQDF81Bk6t1wOBjVKPLPjGs+m8g5J+Ke1d9OwfWM74qI7Btrw4uxMO?=
 =?us-ascii?Q?Mlr4V2VkhSEa4FcWvlYT8R+MbMNF1KAT4qMU2L6KOUZMUEhoRblJ1p9Piru/?=
 =?us-ascii?Q?6II1lpR/sg6qIN/L40TdHVPKDDE0S8cKgSw8fQa1DkNrSZsfSyj5GNZFvtAv?=
 =?us-ascii?Q?EF3AsF+OMUNatlzrsI51xNOrw6k9zH5R1mZ4IEsLK81WTY/uRR8Y+takbO/Z?=
 =?us-ascii?Q?TaDHbgJyUlIrBZmXZD35UbP2WW060D8r08hZig+HNMX+t1BYNjkFSCHaMVxz?=
 =?us-ascii?Q?3Ktq5TnozFIROa9dkAYTCwkBfcz4VDREFq3EHgDpkcLX8PFTYpLdfKHRNgIj?=
 =?us-ascii?Q?dfKIoEl+retVeejZ4bE8jMIwXw26Lo1sIy1WfgrUdhH14V2uBh8iLr/D2qb0?=
 =?us-ascii?Q?3a2wlOHryfifeh0+CZcx8aJinSyIih3BdRKAS3wZTNYtHfqK+IxnEEuC0CnY?=
 =?us-ascii?Q?GQ2bUVVvf+q4DofM5qYSWV7MlzprnnfInyT3V8yCjm5Bb2JcaHInhzW2ph/c?=
 =?us-ascii?Q?9vdxtS20u+8vA9C2LRmJcFd9+rEY3pxxbDr97PJd2jtKQzKzE3p9N2CMDt1b?=
 =?us-ascii?Q?a+2zY4EVYpe10vPyX8RAhjs8LPGXcDkcA6lvXUoJW1Kr9eD0RLjfvmW2dPLj?=
 =?us-ascii?Q?721+/men03HqF7kHUnD0ig8PAeI/Zh4eNsWxTkFSXlc1nUXbi6Hf0BklmWhl?=
 =?us-ascii?Q?AOowZiQeItPTqi/f0QIHk6De11u54dn49+7h6VO7u8Gl2O0iD+8s/dUoZov9?=
 =?us-ascii?Q?nqvKdlcmcA0RQv6rMp14VwzATsFr9FDX+5NNy3juZoivREoiy+HsBEs7kD1r?=
 =?us-ascii?Q?Cw6Qasy5msqO+3GD25oJip3mQkguMFQG0tKIS9s+XAM51s0IyNSolYo+JoHh?=
 =?us-ascii?Q?P0dhSQncel73CleBCNoGu+wAFdfsuRfeGYm+WMEGknmjOU7ti7NLjKiAVzJ+?=
 =?us-ascii?Q?YBEuP2nq6k0c5CVGV2326/atR8cNhkCwqc4K5s6cNuvarTM6t0W7hzSZJGSd?=
 =?us-ascii?Q?I8td5VsZ784hKnG/Q7edX6ZuCm8LI0G//JW5DTnEpTCjYbg8FitV53thvuQa?=
 =?us-ascii?Q?qXiLbEnf1Lov88RcRfXFuOygjo0Ea6QlNvMyooeV2U7dO0pJBZNKDN4vh1iL?=
 =?us-ascii?Q?71wNNMOKG/efQQ7kn+AR9lqwlfk8hfMrUpFCVKF98EWBFdqPPZGrDkUKYS6h?=
 =?us-ascii?Q?spTo9VMroDuxdtDp5f2npIjxGPkPQJHgp+lA+uuvDrBpUrfu1ARt0dxp+f/R?=
 =?us-ascii?Q?4nrQwRj/vXjiEv4SQc5ySUv8fhG+L/ic1KG/YfBzHUFy0VV2X6dPvWGkf10Z?=
 =?us-ascii?Q?ncIe1euC7M/Q08t8ZQ0ZHSzpF1DpQttyVjI2Qd4Q69KIXLR9arrqIN9jT/3j?=
 =?us-ascii?Q?rDl8io5n5OYTM5PVajOOtzSmMNfmFZIfxkPi2cXssiDQOXZ1iJhyNCr7VrXl?=
 =?us-ascii?Q?8M8B7UPlzMVmMmZxFZw7oXJnzFGH8LyGZlKuUTz4rnQV9SRHBq4Ohdjxf5lV?=
 =?us-ascii?Q?wr0arViQ/nnMph8noGY37GLBi/F4q4bI9VcPV+Ou?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b9ca45-6a22-48c8-c6f6-08dbd366f0d1
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 01:25:28.4581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WBAXut9NTahCMu8OBjpWyrnmVtIDE3o4iDLbeo28JzYFTl90u3+UjrNjQGr5EuRtWAm9zZThXvDCBXT83XwQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6301
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.6-rc6 next-20231020]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/i3c-add-slave-mode-support/20231019-055940
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231018215809.3477437-2-Frank.Li%40nxp.com
patch subject: [PATCH 1/5] i3c: add slave mode support
config: microblaze-allyesconfig (https://download.01.org/0day-ci/archive/20231021/202310211527.TeVTMxA7-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231021/202310211527.TeVTMxA7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202310211527.TeVTMxA7-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/i3c/slave.c:11:
   include/linux/i3c/slave.h: In function 'i3c_slave_ctrl_alloc_request':
   include/linux/i3c/slave.h:272:23: error: implicit declaration of function 'kzalloc' [-Werror=implicit-function-declaration]
     272 |                 req = kzalloc(sizeof(*req), gfp_flags);
         |                       ^~~~~~~
>> include/linux/i3c/slave.h:272:21: warning: assignment to 'struct i3c_request *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     272 |                 req = kzalloc(sizeof(*req), gfp_flags);
         |                     ^
   include/linux/i3c/slave.h: In function 'i3c_slave_ctrl_free_request':
   include/linux/i3c/slave.h:298:17: error: implicit declaration of function 'kfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]
     298 |                 kfree(req);
         |                 ^~~~~
         |                 kvfree
   In file included from drivers/i3c/slave.c:13:
   include/linux/slab.h: At top level:
>> include/linux/slab.h:227:6: warning: conflicting types for 'kfree'; have 'void(const void *)'
     227 | void kfree(const void *objp);
         |      ^~~~~
   include/linux/i3c/slave.h:298:17: note: previous implicit declaration of 'kfree' with type 'void(const void *)'
     298 |                 kfree(req);
         |                 ^~~~~
   include/linux/slab.h:718:37: error: conflicting types for 'kzalloc'; have 'void *(size_t,  gfp_t)' {aka 'void *(unsigned int,  unsigned int)'}
     718 | static inline __alloc_size(1) void *kzalloc(size_t size, gfp_t flags)
         |                                     ^~~~~~~
   include/linux/i3c/slave.h:272:23: note: previous implicit declaration of 'kzalloc' with type 'int()'
     272 |                 req = kzalloc(sizeof(*req), gfp_flags);
         |                       ^~~~~~~
   cc1: some warnings being treated as errors


vim +272 include/linux/i3c/slave.h

a63b2858bd837d Frank Li 2023-10-18  256  
a63b2858bd837d Frank Li 2023-10-18  257  /**
a63b2858bd837d Frank Li 2023-10-18  258   * i3c_slave_ctrl_alloc_request() - Alloc an I3C transfer
a63b2858bd837d Frank Li 2023-10-18  259   * @ctrl: I3C slave controller device
a63b2858bd837d Frank Li 2023-10-18  260   * gfp_flags: additional gfp flags used when allocating the buffers
a63b2858bd837d Frank Li 2023-10-18  261   *
a63b2858bd837d Frank Li 2023-10-18  262   * Returns: Zero for success, or an error code in case of failure
a63b2858bd837d Frank Li 2023-10-18  263   */
a63b2858bd837d Frank Li 2023-10-18  264  static inline struct i3c_request *
a63b2858bd837d Frank Li 2023-10-18  265  i3c_slave_ctrl_alloc_request(struct i3c_slave_ctrl *ctrl, gfp_t gfp_flags)
a63b2858bd837d Frank Li 2023-10-18  266  {
a63b2858bd837d Frank Li 2023-10-18  267  	struct i3c_request *req = NULL;
a63b2858bd837d Frank Li 2023-10-18  268  
a63b2858bd837d Frank Li 2023-10-18  269  	if (ctrl && ctrl->ops && ctrl->ops->alloc_request)
a63b2858bd837d Frank Li 2023-10-18  270  		req = ctrl->ops->alloc_request(ctrl, gfp_flags);
a63b2858bd837d Frank Li 2023-10-18  271  	else
a63b2858bd837d Frank Li 2023-10-18 @272  		req = kzalloc(sizeof(*req), gfp_flags);
a63b2858bd837d Frank Li 2023-10-18  273  
a63b2858bd837d Frank Li 2023-10-18  274  	if (req)
a63b2858bd837d Frank Li 2023-10-18  275  		req->ctrl = ctrl;
a63b2858bd837d Frank Li 2023-10-18  276  
a63b2858bd837d Frank Li 2023-10-18  277  	return req;
a63b2858bd837d Frank Li 2023-10-18  278  }
a63b2858bd837d Frank Li 2023-10-18  279  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

