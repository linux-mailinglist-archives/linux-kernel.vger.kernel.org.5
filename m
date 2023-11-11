Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DEC7E87EB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 02:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345390AbjKKBpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 20:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjKKBpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 20:45:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76DD469E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 17:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699667114; x=1731203114;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hoE15GUkBeBlmu+UGbCa6plgbqYe6vQ+rfZohN372jo=;
  b=XLDFUrfAMWsLLhzT9ft+hqzE/TovfH2l4X9o6hwZm6WcdIHHI3rwHIVY
   XQPyBt6hFPbrGWySCgu4lvHAHh+40KR4Jg7XxhHP2lydhrqEFhg1BdbzV
   uhjI+pZcWZIQ3p6df7Q3UonP7qL1j4TGPVSOpk9orwdDy4TG7reXB18iN
   tSkKrFFY9FCQE+ZEVf5m+gHROyZ7fbUJzCFQ1Hq0CRnVqGFJLZcFIZ2Nv
   AEhQX+q0Uy8JgWMoMouITo5Awa0upP/mQG/ta/UJym998FpDhy+JQU1JX
   gPULmePDvVadp/yn/jxWX+CME1q9DRsbpM47jkyI5DQT7Gaxt/5YVUg1e
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="369580971"
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="369580971"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 17:45:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="1011070623"
X-IronPort-AV: E=Sophos;i="6.03,293,1694761200"; 
   d="scan'208";a="1011070623"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Nov 2023 17:45:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 10 Nov 2023 17:45:13 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 10 Nov 2023 17:45:13 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 10 Nov 2023 17:45:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYVrmubKrjokH/8GP+Y84YNORUmMW8A22y5o1pVPSG/eIRqO3+b0Rj8E1eUR8x0NiP5oWk2QsmxTgBY+eGjq3V3HCJOsyxA61LG7C5DqWS8xq3f3458dMBOf1YK5Hn/eFFeIcJTs1H+gdBP6uPUzj5aB9Pnw1dTGhRPlfYg8CowWBUAQLDziJIaRc76jOpGpHRU5dUlwOjURxr09/U9GHHYQt3OQYxcxqlPFlhnHi/wVp4FTei/OOPaRfCWDQ/m/jSZMtu1k2SuVSLpQVkW8zIVwWR3xerjFk5IJeMQJzQeHvCyNEzYmeZCxIWesO5WriSxCqcNpcvZRR2sCmj2x5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMdZ7/kZ09Wpg77XQVm0gAzXMJrwQhyc0ijxPKHeFes=;
 b=ig0ypPQ1VvYCHdC5VYRBUpsVepomToDFJlQcqklIWeo2aEUZKNu2Z64/HjHVXz2MDq8h1Zb5vTJQ0NdcG3YmqoXbQQhMneYZGgh+lMuBKagllFokUiRbH2JXbBNAL83FvFIgKX/X4O+mAtd5L+EVYRAEfHxS5a63FaOVbJRhxJWIHd8ZN4J+TKiaLsKyqSoHDTRUIZ7I1dStjNqySWbHEpHOviSOnNLL40/e+oBHg0oUQ+5QwpNVabQZ4vG0x/hm2birdf1/x7R5mM9wiubfiBC3jb3l8PqRMmyt6h9Mldhr9LQMyky9zFoc/b4m5N7/6jQUbDYbs7nL10qqGosnuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by MN0PR11MB6229.namprd11.prod.outlook.com (2603:10b6:208:3c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Sat, 11 Nov
 2023 01:45:04 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67%4]) with mapi id 15.20.6954.029; Sat, 11 Nov 2023
 01:45:04 +0000
Date:   Sat, 11 Nov 2023 09:44:55 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
CC:     Feng Tang <feng.tang@intel.com>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: ERROR: start_text address is c000000000000900, should be
 c000000000000200
Message-ID: <ZU7cl10jIY4Mpq49@rli9-mobl>
References: <202311110405.PqH7IcX7-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202311110405.PqH7IcX7-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|MN0PR11MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: f63b23a6-2ced-4050-860c-08dbe257d2f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2mndCtUfOzflziTUvnuQEd7MV3r7TLkmn6ufMj+bBuuzCAyj8Z3FQoVvj1aKIxsMPuOnfe7//1eDYzi+ifKfAYz7MLYUWxLzJwka/qGqHgQ4ig/nTXNVpEq6CTtdZw6vfkZp1TbzcO615MnJijYUYDE93Dg9rviKuD2cfHd05l4Oo74mvFyp/eIlCVMJ0W8BPU1RP/kRx4S75Zy1wurgcYrCpwa/i11QpUAyaRAfS0V57ecM1Pv8aADwvc04aEFtCW331Hfs6ec8iyv7KXWbl+aXT4UYqhhoQnFJctljF1NnAxcLSG+XUPaMJ2lgWCxyubYNaLxUpExXByr5iZ0JWNBIxoB9HwvR4kPXghJKo60omwQTSwY6ipWTRsRBJiKr3m/hN4J3ESB9Vp/t0vJ+6Dz0NonQyWn5OY3Hv3fNGmFkCVuUNJdB9nuoTDxlyuCpfNIny1v3mT2wumN8/s6kQCRbvE55E33WbM7qvZAKZzwk4S8++wWJsZeonUAGbTJHZjJZlI/HhqWY+NFmS0qRft5ELrNGWHxBQZdUobVbzBkNgQ59sCr2/JautG0aO4NiKqr2X1DSW8s0sjCW5Z3l2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(230922051799003)(1800799009)(186009)(451199024)(33716001)(44832011)(4326008)(8676002)(6862004)(8936002)(2906002)(5660300002)(82960400001)(86362001)(6666004)(26005)(6486002)(508600001)(966005)(6506007)(6512007)(83380400001)(38100700002)(9686003)(54906003)(66946007)(66556008)(316002)(6636002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MDlXy59/Vobj5GVex9iBLBY+dFcLJX8zSyEGaWbpINbtEaJyeA161MREvUSa?=
 =?us-ascii?Q?eFXROs0/kpcFqih8ame4si4hE9+1VmRSnlK85zc12JQhDPrHQwQQzluApCay?=
 =?us-ascii?Q?uHQ9bNhSr0hkmBt9XLBPNQRldec5TcO350CnCU+bL0ef2zW+tpZx92exoH2R?=
 =?us-ascii?Q?aadUILLxjgP6e933ipKtvdocpGN2yInfMKIYmhNkZDL6vRvyvP0AHb0JHrAs?=
 =?us-ascii?Q?T2xyhvsfoHDDjZQyEfaDgTSJV74aeh+2plPqJNCt3KkoFjbxPm/xabHDXURM?=
 =?us-ascii?Q?Jz9MjfeI/aLZ1vretIob/rmEv5SnhyzZ44NEq1wA9oMZty0QMiLjwFFQoEzg?=
 =?us-ascii?Q?KrNPmOXgadpZktjQ3Wdur9JHxjvUQvKgdILi9U7odG9AYwTWWPACAIYueWDN?=
 =?us-ascii?Q?rRU6YM15C07S+VzS4Z0o0uYNycJBuUC9jdHGH5a2jvC3BlCwmFkTsWb77nrC?=
 =?us-ascii?Q?HxJK6CO4jtr566L9yrUum3A+JgFDYwXtushQPxIR1D3+rtzlmw7QXwmbqCWR?=
 =?us-ascii?Q?H7X9dItFweR/es01FpGDUULHollBr6/cqxd1KlARkLHw7c8BG4byQzvKsGg/?=
 =?us-ascii?Q?0V+c2q4AoDDLkt5xjJajJt3OXmeIcBf1+SZAhtgXBeCOsdjaFhm+bnfXb9H6?=
 =?us-ascii?Q?ikFxPFuSsCtLtfVoK4rbEW9xSQpV720pce37DpZwBGj9pAQ45GD0YSPXutit?=
 =?us-ascii?Q?PN65eKZO2G7jTG3gqsUbdH5rx6/hYyMUXnSXhtZNyAG77rmhGls8Q7F2k9su?=
 =?us-ascii?Q?DTEp+QP2zwlDiXnONIIljHhLwQT5SU6HTCW2DWfXban6vgvD7fXfEPkPawID?=
 =?us-ascii?Q?09Lm08xC5kmDB8IkZLwx9tyQacgZ/j7qHeSdYe4uA+MxmKifkz2ggQaPglKM?=
 =?us-ascii?Q?uv3cQDyx7++1Q0GGzzVZ6DFfO0X/7o8yFGV0pdX8WVavPPLLPrnOx7ZqJRvX?=
 =?us-ascii?Q?liQhM4ysC35MQJsxbyXPvAwNed4yWutwWicNkIjfsQ2pCBe0WSr1mE30kqQF?=
 =?us-ascii?Q?vevzHExLdas6WQS/K0Os087cBTI9TPKa6VCXB80lsAxDmGcEfm8tHBqTpntW?=
 =?us-ascii?Q?EfAWnD4c102sW7Tzw036iEYm6HFLVLVUoc2BluTF01knX5avHju7KKn+p9m6?=
 =?us-ascii?Q?bo6/QpF1+ycKMyZDGLoYy5/UrYC7SVV07aA23subxV9z25gSXnIs9VGhmhdI?=
 =?us-ascii?Q?k9+E8xZZZziO2UHk9O6c5BSoqTT5v9YQFLSK8lswKV7uzOlxUvQrYdyuPtpv?=
 =?us-ascii?Q?Y7ZNsoBt7OytMMQ0EE2bozoieyGaSeRuExsYlVYPNs3FH4o/mmJ+yU49Wfec?=
 =?us-ascii?Q?/YEFb5xA6M+PaYSwslv+vPlh7M1u3i1SNSwhvJh2PmM6jc9Zqh08UvHvNktQ?=
 =?us-ascii?Q?g0n2mvpNhiyqze1LTfm+xur5qPZrZ1RaKwzM1jyB+mlXE+lkEsMpeJTSLpbw?=
 =?us-ascii?Q?gxEdFNdEgYvcfB0hFhvuzxXaiGLW26Ghkcu5ZDCJ6MtHld0FiI/WWFao6tH7?=
 =?us-ascii?Q?UNNhyzggOGHhvIx/17zll3Vx7b90nJAgatIQQeqmiPTQ/GTdTHoZML7TGXER?=
 =?us-ascii?Q?TGHFnpfwMigfvO4zYudLNTYISqzTAikffKC3EDjX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f63b23a6-2ced-4050-860c-08dbe257d2f8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2023 01:45:03.5964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJBkKbVVkVVKa8YYoedM/dJQqvC54lX+lTm0MNWXdsEJJA9/2XfSh1ZSIXNcDLQJtq7uaPZSf2LbLvUTmtEKQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6229
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 04:52:23AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   89cdf9d556016a54ff6ddd62324aa5ec790c05cc
> commit: cf536e185869d4815d506e777bcca6edd9966a6e Makefile: extend 32B aligned debug option to 64B aligned
> date:   2 years, 6 months ago
> config: powerpc64-buildonly-randconfig-r003-20211118 (https://download.01.org/0day-ci/archive/20231111/202311110405.PqH7IcX7-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311110405.PqH7IcX7-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311110405.PqH7IcX7-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):

Kindly ignore this report, we would try to enable LD_HEAD_STUB_CATCH option.
Sorry for the noise.

> 
> >> ERROR: start_text address is c000000000000900, should be c000000000000200
>    ERROR: try to enable LD_HEAD_STUB_CATCH config option
>    ERROR: see comments in arch/powerpc/tools/head_check.sh
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
