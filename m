Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9CB7EA861
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 02:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjKNBvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 20:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNBvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 20:51:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F78D43;
        Mon, 13 Nov 2023 17:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699926693; x=1731462693;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=3ID4rrwdWAeS80sFWnAxXxHh+jePKbvmqPRZeH/XTME=;
  b=mLnjDK215z9W1iXyFp6XGl8WpVkRVt7NaFFPbxu5ywbGvzSZ/YCvC7r9
   XlqpEKjyFf1tMIrSwP13AHvf+CwMpMQKpZom8d5NtFtHtnP+nmi65bEKq
   DeikFjXNHetXBhg96rxn0xmuOsu0fxS136wxHbjuwU8XlFExJL57rLSeg
   K3kc1l+0hfvsoM0AkNeP/Go2BVoEwTne0xIJuanlMtcUN8FTTBb2a/8f6
   rXPZdcDI9wyQ1gchSGW6RZoscmdQTC1VyDXItW8F9uCR/SOmBtM5jxYNa
   Pc69tbRBaTrM+bs2twyaj8oL/Zg8xvXW8yPHdmNOIWktmaphOfE30DtPj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="389409202"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="389409202"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP; 13 Nov 2023 17:50:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="757995408"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="757995408"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 17:50:57 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 17:50:56 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 17:50:56 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 17:50:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nivHqOElgQfGpNL7ve0HuvQGUwMRs4lsCvneVnIccxj+Rc9eP+25ncNIkVdC6U6PgIg74GTbrPKHkAjf0JSW66Vt3GJY2a8+npIBa07486aUDvnN6TUMpXhmfE2kCtCfGH1n1Fm36eWidLbCTAplqQU/s7UVapVqkHOvn9RXAB7exl7Pl/QctEdJ2cpSbQbg6n9p60JC5MTLg0LhKDcqcpZrUnFYGdWqJ8Bd9fZ2ggTEme8fnKmDwNltlsYodxOAFRVuyPetPCxKt9XHXjRSbmcOJOY7iGs/fFX+GtzAy93nFUQyimmoM2yvQeRK9a8dW8yPS8BWCh2KmBayLC+WWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UoCr5jGAHrdMab+9lzwvK0qE3mlLRa46A3570XQkYPw=;
 b=Pnkt1FPZdjugWoM94YgDnC797pWEqmJGhq/p1sz4A7R+0+3NtQzCIxG6gJ3DFr5UK6ms9Dk/KqID2NTf996xKHCke52AFEFCgk752DQyuRQSAV9DL6ZDFBCXSW4wz8NjnYB01Zoh+rL+joFoxR+3OelQes3jk2Sc8aKALFB5j3Usyi5HmzHlP0NtisGOax2HCopQi36AULZng4K5AKY/WBCt6QkeNFCAGCTZPfDqs0KAiHGfs+fd9Zetq1dAZaSl+MJk7aCrMHUDw7S5DYEFxUT96Hgo583Xl9CjaKZgmRU4RGibVocOA9v9eOrN1/kDijSW9YTxozs+mWhZzO6j7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SA1PR11MB7699.namprd11.prod.outlook.com (2603:10b6:806:338::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Tue, 14 Nov
 2023 01:50:49 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.6933.028; Tue, 14 Nov 2023
 01:50:49 +0000
Date:   Tue, 14 Nov 2023 09:46:07 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Raag Jadav <raag.jadav@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC:     <oe-kbuild-all@lists.linux.dev>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/2] pinctrl: intel: Add a generic Intel pin control
 platform driver
Message-ID: <202311140345.etMnKZeR-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231113123147.4075203-3-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|SA1PR11MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ba1f74-f8bc-478e-e35a-08dbe4b42063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5FMrlUsIKDb4KL8eKanL4Spi8duir7JsQZC/nW6dYL+JvcDtQcSIZlprM67vLql5yUbLrckE5ggPCfeskJJxPrZIy8ir2pmoJcX+lfSGTBfrybjQf3NqvrXMgljTxgGHwyZ7++VSPC2DrrmU4ebUPv3OjvOJ6AJ8Rf7BAvNXc3MAb6u9vboymf0lOzZCd7IOzx3UeGVKcvmrO7v+6+qfaGczwRW+dDmPDlc70NXnWwyte5hxa2jCYjDEYZJ3IBWw1nEeH/nmjukCHutKh2gQgK2Q3J5ollqKyF3RwybLbksgQo1FWBHeAqusvT77jeuyZ8lCY17FW8yg40jmWJAMHxKPPob12zFf/IDuwCKPzMCbCbMRujmhthCB7bEQ0Rcc8i8JbcyMhRSL60+EEqXZsyySugN4y2RtmQ9jGwy0D3XZHqrAqT9dtnTXmGmdhAAbnZ4v0qBQrvBqDxYOlD6ATPwGiidD0hI5+srnBjfu6MXkwPYakJcnsv25jX1/Z/nq1iXTwMiI+zAJTLh+EyShdNfwBh4vlHfn9lvurL3hkDbz9UWGzRKfu3Ck8cK2vJ/IovAk1Ie96qj0p9Ds5kl5Us8cWHRUR5eaA1zIph1fX2/0LdE1nrSxAjE7bktnT8gmzkODzO+ukvY4/q5UC5JpwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(136003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(8676002)(4326008)(8936002)(66946007)(316002)(66556008)(66476007)(110136005)(4001150100001)(41300700001)(86362001)(5660300002)(83380400001)(2616005)(82960400001)(1076003)(26005)(38100700002)(478600001)(6486002)(36756003)(6666004)(966005)(6512007)(6506007)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N1v3jZnVqWK/GTtoRcJ5u5Z7reegq2ovuI1ATRCuoTYob/Nv4QgTRBszFmQF?=
 =?us-ascii?Q?ZEmNOflntE2zauflVYlda3fe7HKUeMnO0bj88EhXk46qWeQ/c8F8qIBZ8oYX?=
 =?us-ascii?Q?ON1eQOXivwT44lh8iQrlAuFqweLOIvzmB+Flbof79fU3YnSlN1iV1gLzTgw7?=
 =?us-ascii?Q?Rpy6GBOGdXdC14sx1gtlwh4MIEHX6hQIe55ReYr9Od+EIpvqQvRyQoigDQ0f?=
 =?us-ascii?Q?ykTfnBBtzWdaZiCL065U78xNGtLziA430Rz5UJ74vOhY5SHqBuREOww9fkh4?=
 =?us-ascii?Q?suJ5IMZvEICkWd8/gW5ZfkNlOgxfqbMPtfzHm0+cPkzrrPYby7J85Z1oSFVr?=
 =?us-ascii?Q?kZM2EF1YQGKX/b8hYr5Bhlei5d7L3t6iCyNtU2mhQgFN9cFVETl7vJI5AvKd?=
 =?us-ascii?Q?lXNHpSmCUvzXI+rVdJJR1kiBZD2I07XHB8zXWBgRBoHogAOr2+vLzMAnP2tZ?=
 =?us-ascii?Q?O7k2nlac7lipPI5kFq2978NO7Hj8jpJkwPk7WE+yZL0KlLOl2To4k6sexrw/?=
 =?us-ascii?Q?kuXya/OZORc38WsJJOW1HfJ1PHzcpi8ORkr6ZcYw5h5qXALQkP/0HojpFC/d?=
 =?us-ascii?Q?3HLcsjKe9FjOrsJ90owrpi3KaEz0Ph3t4TcF1mDVylntCH/1LfsjV3qBd/uK?=
 =?us-ascii?Q?RMTdRQ3DPG8Dd17WPQp9y44xZbyhzVwJJFI7lvj8MX093OB1TlYebsLD1WE+?=
 =?us-ascii?Q?/ZgTqPSN+ETJBjdttWSeq8VE+fSqPs+nq4sWr2Ne5a3MktXDFIX4w9eJpiL9?=
 =?us-ascii?Q?kMSjrXXf8Z6DNgozeBQTHYGDhJXLSCLrus7K0yf2nkk/qA++QRe8dGXTqthb?=
 =?us-ascii?Q?TGq+5d5wewWpWhNkvL46KmbpWvzKOXvRHGCB8yiw+nyQMWozKgOADxskAH3v?=
 =?us-ascii?Q?Gj8/POFwFf/jMXAJXSyXAnj6mXVyusj4dNXT/LHcOK7+ZNsGQtxPMrz5Z+tz?=
 =?us-ascii?Q?oVf7Eq14B9qCfSRG3OrepnLunojoFJdKW8nS+2fSwrHJ1X+T8+HVSU9K7R5I?=
 =?us-ascii?Q?VJxacq456+ciddk/SgPhWRwpRYVlN6wHoTe4a/YJ7ynCbEZvS6oaRk5bGGhv?=
 =?us-ascii?Q?oVdZTiL7JHJJRyQUrK6EW2r+8wKM0KthHITqE+I7D8JKMUiQzAH1BvBYp0Hr?=
 =?us-ascii?Q?BZ6nvyca8mrKLVrp7UQ1KKv7njbSDhik3i2axlXFBE34K+RUcGPSN8fKyEbj?=
 =?us-ascii?Q?Xv4kRdNWqqxD813A8afjeYIzf2YwVcb/vdIsgAqTGA+B1hcwsqbaO2kKWfLS?=
 =?us-ascii?Q?yEeqcaCJSdNuT9A8OUufdk5JbgpY6FB+7LNDh+GRYd7DPZBLo6o5+ysMfFMB?=
 =?us-ascii?Q?HcFpONM5Ao9j8+p1BVJHy+1YGhWc0KkNaxf1XcnU0nS6f0MBrn9JbWJSjDrX?=
 =?us-ascii?Q?c/DxpG/ULwMBZ2RchTJUU0MfdsuqTi1ShOSFxRO59BLoTrGQbf3WCYbCXlaV?=
 =?us-ascii?Q?kYSFzfbDgzRFHPmjsBExy2yjO7Qx/dH474iiTQdqshCUu/OlF4FNCjnlNbOZ?=
 =?us-ascii?Q?yGuE0y7TnrEFvceYXYTkJ0WdRzIUnlf7swAJ4ysl2PAU0CbUg19j+iJlEuCq?=
 =?us-ascii?Q?E+AxDetFyKEZocNCIRUxjDspoft8AmccRDe8ZjqG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ba1f74-f8bc-478e-e35a-08dbe4b42063
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 01:50:49.5335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqJ7TDJfyKFp+znpfiPkVrBfs5l6PCGQLSKbEFWcKrwtc0tuzf7D9jtcx4yyMYpTiO0WEeJmjdDRgJeHAPzHdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7699
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

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on linusw-pinctrl/devel]
[also build test ERROR on linusw-pinctrl/for-next linus/master v6.7-rc1 next-20231113]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/pinctrl-intel-Revert-Unexport-intel_pinctrl_probe/20231113-204318
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20231113123147.4075203-3-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v2 2/2] pinctrl: intel: Add a generic Intel pin control platform driver
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231114/202311140345.etMnKZeR-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231114/202311140345.etMnKZeR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202311140345.etMnKZeR-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/nospec-branch.h:14,
                    from arch/x86/include/asm/paravirt_types.h:27,
                    from arch/x86/include/asm/ptrace.h:97,
                    from arch/x86/include/asm/math_emu.h:5,
                    from arch/x86/include/asm/processor.h:13,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:67,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from drivers/pinctrl/intel/pinctrl-intel-platform.c:10:
>> drivers/pinctrl/intel/pinctrl-intel-platform.c:217:37: error: 'intel_pinctrl_pm_ops' undeclared here (not in a function); did you mean 'intel_pinctrl_probe'?
     217 |                 .pm = pm_sleep_ptr(&intel_pinctrl_pm_ops),
         |                                     ^~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:54:44: note: in definition of macro 'PTR_IF'
      54 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   drivers/pinctrl/intel/pinctrl-intel-platform.c:217:23: note: in expansion of macro 'pm_sleep_ptr'
     217 |                 .pm = pm_sleep_ptr(&intel_pinctrl_pm_ops),
         |                       ^~~~~~~~~~~~


vim +217 drivers/pinctrl/intel/pinctrl-intel-platform.c

5dacd710dc5f8ca8 Andy Shevchenko 2023-11-13  211  
5dacd710dc5f8ca8 Andy Shevchenko 2023-11-13  212  static struct platform_driver intel_platform_pinctrl_driver = {
5dacd710dc5f8ca8 Andy Shevchenko 2023-11-13  213  	.probe = intel_platform_pinctrl_probe,
5dacd710dc5f8ca8 Andy Shevchenko 2023-11-13  214  	.driver = {
5dacd710dc5f8ca8 Andy Shevchenko 2023-11-13  215  		.name = "intel-pinctrl",
5dacd710dc5f8ca8 Andy Shevchenko 2023-11-13  216  		.acpi_match_table = intel_platform_pinctrl_acpi_match,
5dacd710dc5f8ca8 Andy Shevchenko 2023-11-13 @217  		.pm = pm_sleep_ptr(&intel_pinctrl_pm_ops),
5dacd710dc5f8ca8 Andy Shevchenko 2023-11-13  218  	},
5dacd710dc5f8ca8 Andy Shevchenko 2023-11-13  219  };
5dacd710dc5f8ca8 Andy Shevchenko 2023-11-13  220  module_platform_driver(intel_platform_pinctrl_driver);
5dacd710dc5f8ca8 Andy Shevchenko 2023-11-13  221  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

