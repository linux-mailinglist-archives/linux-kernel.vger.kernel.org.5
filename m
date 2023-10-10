Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264747BEFD6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 02:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379209AbjJJAlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 20:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379141AbjJJAlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 20:41:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8CB9F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 17:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696898492; x=1728434492;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=qBcKw8FBXo5v509mf8VeXAdQ2vqqOIEjBbgt4Z9JSJo=;
  b=ZyoSTlzrh1Pr6PG/RL3HMA+lyF6gX4iiMQxdVr6ly1t0+9rXeZA9AVga
   BpJ/yW12c2echtCyJ/wejyh7LmaRN2e783oMNbfjl/H+/XeZlU+xn5Ylv
   Q0DCzY5ISgrsqwRrn/ELOGE+MbjSLumhlTg+rABBbCVQYM0S6858dby8K
   4HdTCUlyqpUK2UQq1GGW4ta8e7KRIUevogyEBBfJHUyUEkYlfhRVD7XsJ
   RIMpcicBdfrLI15bGQmfNqVXYaMJOA8VdMGSwD93GLpHOPL1xAPWbNJgd
   HvmdrryjJuJuQbvxcGaxVmNyzGfH3X8pfl3CJt0YPCw90UuklCY69As36
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="470540567"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="470540567"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 17:41:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="869464511"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="869464511"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 17:41:32 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 17:41:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 17:41:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 17:41:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZbgP3M4yJxnwa+6RTpirvCKw+2+TfAyiWFWBi+CzeAhy5wVfcsrIB6pwWyPD/vBvgSgZh5Nm/uo7M/fuMne3hoDu6cfjpS678Ewv6qLMjQu/p3YZefKP+NLiu30tkEnauzAtnryOSDaGXA3H0ICaxsg5j0wFIWH0ADpNps+9QlxR8oYrUoPmqybvTuB6Z28OWHktsItz6P98gqfUvqPpv7jK9PJlcZVP2fJ6uso+GVGuZXuTrYn0t39kTCJl+4ZxEEw5IV+vkVzpwmRMFHk+SI2WSd+3LbuVQacJInu2gjlfHDbfLWZLRaRt+E8J/nGojiu0Tt0HFmu0c2ORPMYiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FE6aJBB9pxBGIeH/Ska2KaSq1ToovBGCo5QSgHYEZA=;
 b=UA0uuqUp62s0WxTCkoYeKzUreYCp9BSmNHy/BzuMWZ345rCODZqDpEoKTGbWCya3HkQTAyl20F57U1LhcL2/LVh4dqatJxsvXDA//Qplpcf98okqXQjr38IpwC9wO+vclmT/8NwqR5GYqMcTa78CZxbvf9ozypY/tHhnVl4lEn+PemofDmyKN+63fmDkM+A8Bzj+px5XCmw+Cnmz6WPAm20t6ihk3eq5J0WxbwYxD/MkRAFRwFyiSXk8WUG8mCbrkF/t1VB7enayMxY1v7Akh5ISGzmxtD/ISM8RJlGK1wWWcVIwnV/w2X4i/gaGAINePRBD8x+tTm3MvFXDCRyi+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by SA2PR11MB4905.namprd11.prod.outlook.com (2603:10b6:806:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 00:41:28 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::f64:17c0:d3ab:196]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::f64:17c0:d3ab:196%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 00:41:28 +0000
Date:   Tue, 10 Oct 2023 08:41:19 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: arch/alpha/mm/init.c:265:1: error: no previous prototype for
 'srm_paging_stop'
Message-ID: <ZSSdrzTJgMgvd/4A@rli9-mobl>
References: <202310100311.WYXC5S24-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202310100311.WYXC5S24-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|SA2PR11MB4905:EE_
X-MS-Office365-Filtering-Correlation-Id: 459d3516-9593-4e43-1fc1-08dbc929a3b2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NAhtYiawZUYneD8SWbWH748FwPQQvANp96/K62pXna3UKadRmt/Du02R/caln8v+fTxi8fSett6WwjKkA+wKHBRbGz99VwfhpBAd3dzsjs88nJHeta9ppzE4XVxwTCevWEVLWUT006GfuGD7GqBDemhsGzMnsvTDgCO4sdyP+tg8Dmx9k9h2p31ale5yyZR9QROR1NZllPYK6SbdAjzK77/dJtx3gg/T3EN/5cOIK7sEHq1LH20SkjT+uVXHq4gIucVTpBDsGBuRaHmOMVd3vDWl1y5lrA4LSYzC3uOF1yUWXrnYjS6GKJudYvdKIuYf1xbyRGvw1OPTGdXbzakbVlXalhGjC6eiwN4ylOQpYNjRRv0Uv+dLZLMiIVN/JsbUNDpWsb12QfA3QnkM4TpmSTfTbIIe5kPy+eHIYrLQl/opo6Ja4pzM3D8iGArRXTBGU8UTrElmx7b0RfX8vCUQ3qqtaeGK5eSkp6Zoh5pmIHd9zahFrtCYHwh1QjJib6ojALJJBbEqRlMGI458gmSVHPKxx7kmHgKqVrjFHC1baxaz+d7f1JcOe3DMRvVwHTVIJOSLU6S0qWW5tjNslXsVjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(346002)(376002)(396003)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(83380400001)(316002)(26005)(66556008)(66476007)(6636002)(66946007)(4326008)(6862004)(8936002)(44832011)(5660300002)(41300700001)(6506007)(6512007)(9686003)(966005)(6486002)(478600001)(8676002)(6666004)(33716001)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Fi1dDUwok7bvcr/Ee6wRUqeL9D1G9TKCL/QCRQn7PEN5YqDghopnQk6LjAm?=
 =?us-ascii?Q?wpoPfA1TfsHiqt3gZ1ROQ+gnlBmWacmLe7xb3jsQRrOv3W0Ub2GitqF6Em8l?=
 =?us-ascii?Q?d/vQjKoYcpLR7N2pjCcfCHXXx8B32/UM0H8/yeBi7cPikOqa4o9c/0Pk0pdf?=
 =?us-ascii?Q?/UFs80evSsB2IylerspS2jKLMW41gAjqs77Bhcy7XPh4FXWJrEF77wAbdCSa?=
 =?us-ascii?Q?wkggzLm6WOMksWTKFdX4wBXG7npXqwBHWj4PPeiBR4uspOcBY3CNBKpoohT0?=
 =?us-ascii?Q?HJrvXEgeTdA36Scng4jRg1i+zx4LAjaHEtG/AQQnCIncPo23Y1j3v2QT4QRy?=
 =?us-ascii?Q?moD3j90EfzYYIDMt+4FyqYWq6InhO30waEPTQ+JNlxpalHLtNN92VmhO5zfM?=
 =?us-ascii?Q?u/ZixX92lIyXuM1tcVC4JwjJ28hoEB4Y8Uneq+ufpvaXoeZNok/M8dvUy13e?=
 =?us-ascii?Q?LQgyTVPtO7p6O/ssauWKVkdwMuJAavw62QvJ3J+m/mXf+LRgDXT4L4h1ciee?=
 =?us-ascii?Q?a+kJW7TvAmdMgOLApqHL2QeNRpXghlZokBku+9i121yV1/F/+tEkNXmq33g6?=
 =?us-ascii?Q?2fyc1N0rv90dDKiRMaNZ42sHYJeQq3rHo+8GC32ItE6ysmZ2NhMxZIgDFKbd?=
 =?us-ascii?Q?Cc7T3ZiuTnANlBPG9ZOMAsGhpuE0Fvt0YV4KyPo6K5Xr/t2iKMRR0g/rTpnq?=
 =?us-ascii?Q?92lvhX9i3txNcwUpAs67qaeo1DEVmippS+DpRjOziTA8dcPtHc9xQlOgiPdf?=
 =?us-ascii?Q?qbJ8tXaM3UH3UoEo//qrpFiC2bj8ffklM3kuE2CITh+ggbnrtkAoIoPvXssJ?=
 =?us-ascii?Q?XUyM/rib7mV6bU+JEwCgrqZcIg1EyuDbQm/Fx2n5tW50VaqKhcxvz5LHJE3C?=
 =?us-ascii?Q?M2RboJP/pdC1IluxHAhhf2o4HzB6RW0/y2zeTo9quSIs5HlN2QT0BE/CtuW1?=
 =?us-ascii?Q?kmzuU22Y/yjk9zHs455M3zvEKNMgHE62ekroWEl0QbgX4gyLw6tL0XlW1NSB?=
 =?us-ascii?Q?ITxtROzMgwOtu/OCpZJwfRh1EGgYz/Qu2tJYv6I2SJWhLJi4Y38urq5TezIV?=
 =?us-ascii?Q?WD/Cr6c62umGlPFDVIXIuGxG4FO+Q9+9zDQgW4l1cX+onzE+qsZho1CqFAa7?=
 =?us-ascii?Q?/A57ofdtWwX+Z+NA9sj03MAHFOajiK/sNSe8O1YDLSs6acVHYLdS+DKB37ER?=
 =?us-ascii?Q?cXQvv+fOFHfPgoygdYLMjetr1pabtbl+ucvqDrsXIejwbQhg1lvZa/cBKsQO?=
 =?us-ascii?Q?S9a5U23a926z+ITTgVC9t1ZlNSP+tA63Cn+zXP8xv/I8uKn6gxC1wn10xzbN?=
 =?us-ascii?Q?jT6iv01Ca7uueAwwNqipnyNCCT+QjzdZzZDXSAFqNotU7mwSkizYlc/UlRRL?=
 =?us-ascii?Q?nYIkywyEYCmp5JgDlygNj1sirmvpd6nz0uw6Ob8sUrkLIsRm8vNo5bks0Edv?=
 =?us-ascii?Q?jHXdTJepA1UsTlGXhk7vaj+cQdr/EF9QqST9Xsf0Lnwe7butSAg6ER3YS+6f?=
 =?us-ascii?Q?yrE770s6IgGIE/ofesc9dURCvChdOqqoKHMC0Hn0kxE3I6pDompvhzmldE89?=
 =?us-ascii?Q?N0ZsXLzbLPUbA3Xw3cvcbEkACZFAMWXxh3zL+abl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 459d3516-9593-4e43-1fc1-08dbc929a3b2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 00:41:28.3732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPR96Y2Ip2k12uiTF5yK0FyChlGXcvGl5fzeNwHSQB9MbNgaA92WJCb82xhoEgju9wwTfNK8srk4bL7IxJo7zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4905
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 03:25:25AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   94f6f0550c625fab1f373bb86a6669b45e9748b3
> commit: b1fbfcb4a20949df08dd995927cdc5ad220c128d kbuild: make single target builds even faster
> date:   3 years, 11 months ago
> config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20231010/202310100311.WYXC5S24-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231010/202310100311.WYXC5S24-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310100311.WYXC5S24-lkp@intel.com/
> 
> All error/warnings (new ones prefixed by >>):

Sorry for the false report, kindly ignore this one which bisects to the wrong first bad commit.

> 
> >> init/main.c:494:20: warning: no previous prototype for 'arch_post_acpi_subsys_init' [-Wmissing-prototypes]
>      494 | void __init __weak arch_post_acpi_subsys_init(void) { }
>          |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >> init/main.c:506:20: warning: no previous prototype for 'mem_encrypt_init' [-Wmissing-prototypes]
>      506 | void __init __weak mem_encrypt_init(void) { }
>          |                    ^~~~~~~~~~~~~~~~
> >> init/main.c:508:20: warning: no previous prototype for 'poking_init' [-Wmissing-prototypes]
>      508 | void __init __weak poking_init(void) { }
>          |                    ^~~~~~~~~~~
> --
> >> init/calibrate.c:261:37: warning: no previous prototype for 'calibrate_delay_is_known' [-Wmissing-prototypes]
>      261 | unsigned long __attribute__((weak)) calibrate_delay_is_known(void)
>          |                                     ^~~~~~~~~~~~~~~~~~~~~~~~
> --
> >> arch/alpha/mm/init.c:265:1: error: no previous prototype for 'srm_paging_stop' [-Werror=missing-prototypes]
>      265 | srm_paging_stop (void)
>          | ^~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors
> --
> >> arch/alpha/mm/fault.c:84:1: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]
>       84 | do_page_fault(unsigned long address, unsigned long mmcsr,
>          | ^~~~~~~~~~~~~
>    cc1: all warnings being treated as errors
> --
> >> kernel/fork.c:160:13: warning: no previous prototype for 'arch_release_task_struct' [-Wmissing-prototypes]
>      160 | void __weak arch_release_task_struct(struct task_struct *tsk)
>          |             ^~~~~~~~~~~~~~~~~~~~~~~~
> >> kernel/fork.c:752:20: warning: no previous prototype for 'arch_task_cache_init' [-Wmissing-prototypes]
>      752 | void __init __weak arch_task_cache_init(void) { }
>          |                    ^~~~~~~~~~~~~~~~~~~~
> >> kernel/fork.c:841:12: warning: no previous prototype for 'arch_dup_task_struct' [-Wmissing-prototypes]
>      841 | int __weak arch_dup_task_struct(struct task_struct *dst,
>          |            ^~~~~~~~~~~~~~~~~~~~
> --
> >> kernel/exit.c:1732:13: warning: no previous prototype for 'abort' [-Wmissing-prototypes]
>     1732 | __weak void abort(void)
>          |             ^~~~~
>    In file included from include/linux/preempt.h:11,
>                     from include/linux/spinlock.h:51,
>                     from include/linux/mmzone.h:8,
>                     from include/linux/gfp.h:6,
>                     from include/linux/mm.h:10,
>                     from kernel/exit.c:8:
>    In function '__list_add',
>        inlined from 'list_add' at include/linux/list.h:79:2,
>        inlined from 'exit_notify' at kernel/exit.c:677:3:
>    include/linux/list.h:65:19: warning: storing the address of local variable 'dead' in '((struct list_head *)tsk)[44].prev' [-Wdangling-pointer=]
>       65 |         new->prev = prev;
>          |         ~~~~~~~~~~^~~~~~
>    kernel/exit.c: In function 'exit_notify':
>    kernel/exit.c:653:19: note: 'dead' declared here
>      653 |         LIST_HEAD(dead);
>          |                   ^~~~
>    include/linux/list.h:24:26: note: in definition of macro 'LIST_HEAD'
>       24 |         struct list_head name = LIST_HEAD_INIT(name)
>          |                          ^~~~
>    kernel/exit.c:649:45: note: 'tsk' declared here
>      649 | static void exit_notify(struct task_struct *tsk, int group_dead)
>          |                         ~~~~~~~~~~~~~~~~~~~~^~~
> --
> >> kernel/kallsyms.c:450:12: warning: no previous prototype for 'arch_get_kallsym' [-Wmissing-prototypes]
>      450 | int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
>          |            ^~~~~~~~~~~~~~~~
> --
> >> kernel/iomem.c:9:22: warning: no previous prototype for 'ioremap_cache' [-Wmissing-prototypes]
>        9 | __weak void __iomem *ioremap_cache(resource_size_t offset, unsigned long size)
>          |                      ^~~~~~~~~~~~~
> --
> >> fs/open.c:870: warning: Excess function parameter 'opened' description in 'finish_open'
> >> fs/open.c:912: warning: Excess function parameter 'cred' description in 'vfs_open'
> --
> >> fs/read_write.c:88: warning: Function parameter or member 'maxsize' not described in 'generic_file_llseek_size'
> >> fs/read_write.c:88: warning: Excess function parameter 'size' description in 'generic_file_llseek_size'
> --
> >> fs/d_path.c:311:7: warning: no previous prototype for 'simple_dname' [-Wmissing-prototypes]
>      311 | char *simple_dname(struct dentry *dentry, char *buffer, int buflen)
>          |       ^~~~~~~~~~~~
> ..
> 
> 
> vim +/srm_paging_stop +265 arch/alpha/mm/init.c
> 
> ^1da177e4c3f4152 Linus Torvalds 2005-04-16  262  
> ^1da177e4c3f4152 Linus Torvalds 2005-04-16  263  #if defined(CONFIG_ALPHA_GENERIC) || defined(CONFIG_ALPHA_SRM)
> ^1da177e4c3f4152 Linus Torvalds 2005-04-16  264  void
> ^1da177e4c3f4152 Linus Torvalds 2005-04-16 @265  srm_paging_stop (void)
> ^1da177e4c3f4152 Linus Torvalds 2005-04-16  266  {
> ^1da177e4c3f4152 Linus Torvalds 2005-04-16  267  	/* Move the vptb back to where the SRM console expects it.  */
> ^1da177e4c3f4152 Linus Torvalds 2005-04-16  268  	swapper_pg_dir[1] = swapper_pg_dir[1023];
> ^1da177e4c3f4152 Linus Torvalds 2005-04-16  269  	tbia();
> ^1da177e4c3f4152 Linus Torvalds 2005-04-16  270  	wrvptptr(0x200000000UL);
> ^1da177e4c3f4152 Linus Torvalds 2005-04-16  271  	hwrpb->vptb = 0x200000000UL;
> ^1da177e4c3f4152 Linus Torvalds 2005-04-16  272  	hwrpb_update_checksum(hwrpb);
> ^1da177e4c3f4152 Linus Torvalds 2005-04-16  273  
> ^1da177e4c3f4152 Linus Torvalds 2005-04-16  274  	/* Reload the page tables that the console had in use.  */
> ^1da177e4c3f4152 Linus Torvalds 2005-04-16  275  	load_PCB(&original_pcb);
> ^1da177e4c3f4152 Linus Torvalds 2005-04-16  276  	tbia();
> ^1da177e4c3f4152 Linus Torvalds 2005-04-16  277  }
> ^1da177e4c3f4152 Linus Torvalds 2005-04-16  278  #endif
> ^1da177e4c3f4152 Linus Torvalds 2005-04-16  279  
> 
> :::::: The code at line 265 was first introduced by commit
> :::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2
> 
> :::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
> :::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
