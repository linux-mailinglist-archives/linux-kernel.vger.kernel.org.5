Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04937E8FB5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 13:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjKLMNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 07:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLMNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 07:13:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608BF2D56
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 04:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699791201; x=1731327201;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jroJkB8/KyT6PuotZc6oTLHJPFpT6X6WelL7zSzYcS0=;
  b=HnIXjd0IlSzVCAUQiidpyq+Z5/ERDyCzJNHIFEzXtmm6kbTzeq1HPAC4
   b+q74V09YmrI1O7u/yBhUe37/jnVEY9QP8Lwc4IGLjW0vxCnz+Af2IrEg
   p0Lf5VSXoprFPlhcvZ2Kq44fVN83iAEphQV1Bc4uotXWc8vjLX1k5sdkE
   zSzn0hRXfHMEIF0Po9HpJjtdPLhf+cG3dLxYYfPjWEtQAkC81NnvuIScD
   HbuD5SOur9JhqOIp5GCVtsbuNZNzhzEp1I/KnaEyPxJ/bRsVyptCuPZ8g
   52m0t2uRGbtuN4sKlYz2WApDvGHGVrcT8Fupaq3P6RjNBF1WoA38LS92U
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="394228944"
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="394228944"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 04:13:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,297,1694761200"; 
   d="scan'208";a="12250284"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Nov 2023 04:13:20 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 12 Nov 2023 04:13:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 12 Nov 2023 04:13:20 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 12 Nov 2023 04:13:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlDIzE3a70ptsEZSxX3JNeL+9OPNSYn1isrlCqHSTyNXTb2Pr5vxS25LHGQfMqqub3/kmfJBnPALaevyF1MduTXphkHL7scyKuf3hhjLpPtnLk6OEWnHFYEplHLiTwODdbIP7nw1TTr7kAktFetV3K4USyLeHZxhniyypCA9FS2iBxh9pJZmssK4pqFwZ3TmEHLWbSM4iB6aUGcvNp/pZ2YYGzA9FWqCaEtluiTiT8dIxU52bkvbOWf+CS03PcsgWaSPZ4v5SiYhGnn6wCvf/CeSJ6wisAvjiUC6mw6U/BAuukPTt1z6322kVCykqThU2Afydz/j8OW3F0050UkyPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAcn8Bq1SCzERWZ8lxLHN+XZbnbX0FXyxsxnr+yklm0=;
 b=aaqZJgn4zVe2jv7w7N0W4v3AfI7Jc1DxjwDsqW4pY5pvPcIs2H6C6QgggQAzEkUbjkF+52xMtvbPPJMv5TxsywETyvdAokisIy+lMbOsiClA3t6hIPJ04p+KWEztyLnPgCc9/yHPkEcXoAzpeBFzXw8KC3CVwjBUOE2meJjptNvTLr4K0b6irzRX/H5QI3QuPIylt3MspAaMZSE1udE/s2gAB8UC+FKNhbTOF/O7mzGR3pOf+OoUY7dh4szW47rxgNRGXMo583Nn7czu1V40DGfF0BeXfEmTSkQkXREHVQc5eXaaiKXvexZcnJEk1MWu2r4wpXX38M85/Cs1I++PEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by SJ2PR11MB8586.namprd11.prod.outlook.com (2603:10b6:a03:56e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.22; Sun, 12 Nov
 2023 12:13:18 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67%5]) with mapi id 15.20.6977.028; Sun, 12 Nov 2023
 12:13:17 +0000
Date:   Sun, 12 Nov 2023 20:13:08 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>
Subject: Re: arch/x86/include/asm/pgtable_32.h:68:5: warning: "PTRS_PER_PMD"
 is not defined, evaluates to 0
Message-ID: <ZVDBVAFLVK/o6jnk@rli9-mobl>
References: <202311121854.UxxoSqkX-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202311121854.UxxoSqkX-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0164.apcprd04.prod.outlook.com (2603:1096:4::26)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|SJ2PR11MB8586:EE_
X-MS-Office365-Filtering-Correlation-Id: a51e1b0b-5158-45a5-6c5d-08dbe378c03e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cxBshQSGx/6rhu5DIIsXTimTcijvS2Cgn+nioGBZ/Wf39M8FeJNuIHTotrnwUmPRAXqop4J1MnzDjqp4kloHTeEeb/0DSBzi1sOd+6gWR5/DXFs2bQ32rL1zuntBFjkRmmE61KLMUMl0S95Sb6ym8w3NK5Fzp3zuc0xl8Fqpi4D8C/MsNUxfLaJBYy09bwSfxbB6ClMVh5Cavpe3wNg9ysyqFp4AyqjIms1Qh3+cpRlKxJO6n54JAs8+axrbuMFojvqDzTGrLx0xVhyTZRzSnaR/WjZBWyqF55KkGqCicRTXdKxAbIFJIN+6W0ThvOlu2J4gbr6joNTSQDOR/ye//6kfMCefcSaZ4CiPBt8pmSrALNpZHuRIZWnS3IAdTUJacBPOCunnK6CMDnPXSHNFY7o75G3Wa1x2pAEOSwIozCwC2xqJMDgrJLVPbG6o5PYklZcYM2NVE8WsMelK4fqGaNEboNaBdnAtoq6tAwedmq3LV0PYkYeoOTmzc9mRlGb68PsL/AEKkrJEeZlw137PwT6aOsulVO8R0yLC687yItMJC2PitlXxS0Yu+IY/FXPO8lt2p29yopQ0pKYjLwOEvAcxRFmvYSl04X9c71OaaI7RzcTR5ZgsabSb0yVUgCvpaKao+2vuvxiwKZWt9v6hiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(230173577357003)(230273577357003)(451199024)(186009)(1800799009)(64100799003)(2906002)(44832011)(5660300002)(86362001)(41300700001)(33716001)(26005)(4001150100001)(82960400001)(54906003)(66556008)(66946007)(66476007)(6636002)(9686003)(6512007)(316002)(83380400001)(38100700002)(966005)(478600001)(6486002)(6506007)(6666004)(8676002)(6862004)(4326008)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yE2YmgWGhCi3CFLwJUEb+vNLt92OM99lh9InF1FU8Ps0wfzVgW9j6tuc2Ppx?=
 =?us-ascii?Q?rdSRWmw5dYuNKVEhHlO/06p0XP9LC6P+VEetel6wZ8nhgHuYXA2JYHRIZAbF?=
 =?us-ascii?Q?SZSCUd4ZXFBd19aSmC4N6FF8HzoFWJwhrtNNMW8YQSlyoxDJixenCqF7+BYS?=
 =?us-ascii?Q?ACG6nR/SedQjtsPf0p2Ok9nH7WeiiWa4qWyFT7daMXk6T9qDu9yqCXAaqpsz?=
 =?us-ascii?Q?DJrD7YU98V8GKXkd54u5T40rNEa+PAREmNQWWid2EePIBK4Z8ZIGnOr0ROWP?=
 =?us-ascii?Q?LpK+klMNNlUsZxYtR9VDECW5HwHDA9XQtf/H+0ncgPbRfMuVKCFXxUSN/UtQ?=
 =?us-ascii?Q?zLzM8kijied5JGAsqnPpZ4AQhBYY7hYsq0ecFl4U7ccHQ/xYKE8FF/f3vbWi?=
 =?us-ascii?Q?EG4vvDK9ROIhhm3yUtr76Al07LFqAl8V0OCnoe1aKiW/7AZt+KwT44MKnty8?=
 =?us-ascii?Q?hJROxBWw+RReb2wepfewXPCcpMZerh1r2QeT/l7OebMv4MTHGb/Vvmz6auGG?=
 =?us-ascii?Q?DvqxFCTLEQGLWjVIH+EcRcCW26iuUliHeq5j+nQ5a5pVYArstkhTUZAq8Sx2?=
 =?us-ascii?Q?2LKRN0/e+OE2Zzd5TiSyofxxSzNDaSzm+P4vlOqYSZDd+fp+UwGvrbSIIOEF?=
 =?us-ascii?Q?s2nVG8ANNdTkC+hDAfi3j5RGp8eHVg1rV2sWAGFFBNxyuu4OLNkqe+GEcby4?=
 =?us-ascii?Q?tgDE/vNV4t/crwMh6Y5kVOHqSIG3zPLuXHMD0ytaffTOUYYQe9I026FJQ/Bv?=
 =?us-ascii?Q?OX0aiFUx3Q0544WSA43AmSUn4TMC2JMxy+z50TxkMvCmg/DoNemYwbefcQGk?=
 =?us-ascii?Q?FUjFo/jvtqTSxz4XujqQaGOJy9Xlqb01CGi3W3QaIH4D8kLTpgm79QOhTiFZ?=
 =?us-ascii?Q?X+MGdgAFL1klzZnu6HFWg2i/9CDTeoRTHJBbcltC9KWMaeplowSQv2kRHAQh?=
 =?us-ascii?Q?NHTYYbt18x9lkvOw9hERJT/uTZ7vEf24rgGTH//rgCObRkCp/eLw34WHxGJO?=
 =?us-ascii?Q?YxzEY9RWNxU3GN4pKAZAUHaHNOe5CvwCMs/1DW9pa1IX9EuB0q2VBSeAdSnH?=
 =?us-ascii?Q?eFZ+1PbWf+nBA07EI6zhXCo4ybc5v+0K6+tU8sRRWMDmRFRzLNlOntx7diJZ?=
 =?us-ascii?Q?z+hn5W2IegaRuvza5tZrrIoIKzWufecHZTOtpSqGtNZh7g+NKsox1d5WFBeE?=
 =?us-ascii?Q?PGvDDbI6lOiBUjfgZFQitmOLzUe+Z3WUac74aEnyLSVQKGwL87kBaYqH4+OO?=
 =?us-ascii?Q?MlGUOZFLC8tL4Ik+FCmaB2efM70cemt6vAulkQbC/BNBr/yjzR0/Ftjp1GdF?=
 =?us-ascii?Q?dULNzupud0yeKG9n63YCGMKPmEsEYPPxJKkaGF2ekYAhEKm4sf7+MIF1pUDo?=
 =?us-ascii?Q?1CWrVRekygRa8tr3dK2YGcwV9oiH+I3zv2LPYwwcffrOlH11lWD2ce4MT8KO?=
 =?us-ascii?Q?dKeZJlYrgKJgxfPnad6W7BFxcc1MU4o96tqr4mXP2hFnxcBHvFt+PguU9rlU?=
 =?us-ascii?Q?l6fkN5LtbEwyyqnbBdeG4nu3nUIwYc8TMtCy0joC15nuup8KSgUcVXu0ipK5?=
 =?us-ascii?Q?YwomHHUUWYHlDnFsoKSVw30RQIHDdWjpB+yfvuTX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a51e1b0b-5158-45a5-6c5d-08dbe378c03e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2023 12:13:16.6982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w6nKKsRIx0hjJIMQxxV5Koh8L6xkPFUsxpoboIo/CV+4L2gZB1SR8NRQj78q913lWlo7Or5F131DiPXMV1ixvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8586
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2023 at 06:48:47PM +0800, kernel test robot wrote:
> Hi Masahiro,
> 
> FYI, the error/warning still remains.

Kindly ignore this report, as the commit is not the cause of the warning itself.
Sorry for the false positive.

> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   1b907d0507354b74a4f2c286380cd6059af79248
> commit: 80b6093b55e31c2c40ff082fb32523d4e852954f kbuild: add -Wundef to KBUILD_CPPFLAGS for W=1 builds
> date:   11 months ago
> config: i386-allnoconfig (https://download.01.org/0day-ci/archive/20231112/202311121854.UxxoSqkX-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231112/202311121854.UxxoSqkX-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311121854.UxxoSqkX-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from arch/x86/kernel/head_32.S:29:
> >> arch/x86/include/asm/pgtable_32.h:68:5: warning: "PTRS_PER_PMD" is not defined, evaluates to 0 [-Wundef]
>       68 | #if PTRS_PER_PMD > 1
>          |     ^~~~~~~~~~~~
> 
> 
> vim +/PTRS_PER_PMD +68 arch/x86/include/asm/pgtable_32.h
> 
> ^1da177e4c3f41 include/asm-i386/pgtable.h        Linus Torvalds  2005-04-16  58  
> 1e620f9b23e598 arch/x86/include/asm/pgtable_32.h Boris Ostrovsky 2016-12-08  59  /*
> ea3186b9572a1b arch/x86/include/asm/pgtable_32.h Arvind Sankar   2020-10-29  60   * This is used to calculate the .brk reservation for initial pagetables.
> ea3186b9572a1b arch/x86/include/asm/pgtable_32.h Arvind Sankar   2020-10-29  61   * Enough space is reserved to allocate pagetables sufficient to cover all
> ea3186b9572a1b arch/x86/include/asm/pgtable_32.h Arvind Sankar   2020-10-29  62   * of LOWMEM_PAGES, which is an upper bound on the size of the direct map of
> ea3186b9572a1b arch/x86/include/asm/pgtable_32.h Arvind Sankar   2020-10-29  63   * lowmem.
> 1e620f9b23e598 arch/x86/include/asm/pgtable_32.h Boris Ostrovsky 2016-12-08  64   *
> ea3186b9572a1b arch/x86/include/asm/pgtable_32.h Arvind Sankar   2020-10-29  65   * With PAE paging (PTRS_PER_PMD > 1), we allocate PTRS_PER_PGD == 4 pages for
> ea3186b9572a1b arch/x86/include/asm/pgtable_32.h Arvind Sankar   2020-10-29  66   * the PMD's in addition to the pages required for the last level pagetables.
> 1e620f9b23e598 arch/x86/include/asm/pgtable_32.h Boris Ostrovsky 2016-12-08  67   */
> 1e620f9b23e598 arch/x86/include/asm/pgtable_32.h Boris Ostrovsky 2016-12-08 @68  #if PTRS_PER_PMD > 1
> 1e620f9b23e598 arch/x86/include/asm/pgtable_32.h Boris Ostrovsky 2016-12-08  69  #define PAGE_TABLE_SIZE(pages) (((pages) / PTRS_PER_PMD) + PTRS_PER_PGD)
> 1e620f9b23e598 arch/x86/include/asm/pgtable_32.h Boris Ostrovsky 2016-12-08  70  #else
> 1e620f9b23e598 arch/x86/include/asm/pgtable_32.h Boris Ostrovsky 2016-12-08  71  #define PAGE_TABLE_SIZE(pages) ((pages) / PTRS_PER_PGD)
> 1e620f9b23e598 arch/x86/include/asm/pgtable_32.h Boris Ostrovsky 2016-12-08  72  #endif
> 1e620f9b23e598 arch/x86/include/asm/pgtable_32.h Boris Ostrovsky 2016-12-08  73  
> 
> :::::: The code at line 68 was first introduced by commit
> :::::: 1e620f9b23e598ab936ece12233e98e97930b692 x86/boot/32: Convert the 32-bit pgtable setup code from assembly to C
> 
> :::::: TO: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> :::::: CC: Ingo Molnar <mingo@kernel.org>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
