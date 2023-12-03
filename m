Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72471802291
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 11:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjLCK5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 05:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLCK5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 05:57:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52407101
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 02:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701601032; x=1733137032;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ht/OSIEOenLtn4MBanfZwPOZWWrw6qStGNuKi7EaDIs=;
  b=Vxzp1WMudhgz3lN/7yk1ZGGbpEAt0TsQyPetctfVXStOz24JOYPutPn+
   O4YC9WeC2rd0A/8IZNXFppfRvoGxeow6TYv5MDUBj7VY6uhy/Ey72XiMp
   T1oSAI5WS95zIpnj1ExVonvLQ/EMXp/NtDtWPehyvfjmgjchwcNLiObPe
   ZYlqdNeIkcyYBwCvUlFTGMqaTfjmxWq/QzUDQPSCmyMoXHaEPq7fZLMOK
   1m4ZUQuoRIeL0imuVeihbcuG9SvfiadubAbQ/BpQvrW5/uaShuPGeobku
   wo5LsSd3XuYCq/K+6zk1JOYXJHwiXf3PbYDUYrA7I7vA8l951l+XEXsDK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="6916847"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="6916847"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2023 02:57:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10912"; a="763655502"
X-IronPort-AV: E=Sophos;i="6.04,247,1695711600"; 
   d="scan'208";a="763655502"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Dec 2023 02:57:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 3 Dec 2023 02:57:08 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 3 Dec 2023 02:57:08 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 3 Dec 2023 02:57:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPGnCAmQtMY/8KS953cGl9Fm5KpPZLaxq3p7GWdFVriimKtYrMr6TzEletcYWIAzpuC9LlpERymWOQYitzcMWzwad6QBKn+7QSn3A42D2xc6zjTMrGrqmgZA2kDgDWkrBjQ9+R2TvTeuhHZ/1RSuwEbZBYO27eusyA4uGc6EA07uSlFQ9fgM2/Z6/dUrgoYOYUAoGNK4BPpgMIsKk0uO09KBFZqeDpXCkwbGnYBqAI5p7TTNwoy2LQgDQGgkKYxUMX7R+mQ//sKFYa3W0xeJni895JoY9VLuqSqWI3EhV6RAmVymwJEkNrqNVKhTqjlxTgewhfabWBuiYkVXmyZCmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rn2PMin62EVhYQ5LEpnzO5Z/22AXLoURxXz1NHTNAbc=;
 b=ERY1mP3Vz9nDd4MMQnYFSk97h1I0/4SMO73mvOwadKICqSg+IR5CUkiMRS0ZUfkSPHJt94ej3mRW3uuFuzAusteNL00zULeGQ+O7gQLqLhQ3DNZe3dVFgjxSbb8hc36qjox0pBnOY1E4IeOscozVQQNUJ4opZeM1m1XICZOkDy1dVWE9DNQYzrFrv5/t+7gpmAeDIInyWDEv76Rb9JrgSrJDqyWEDEnzCJg8TkgTDf+JrKcNkGcu481jxqT4weu+R8cpoPAyMlW7Fc+gFieAULarGTs3dCOR3FmFgC5zYYbV7jvhn7mJKGJLXyhKXwAVm4CeX2dW/hbwa3v7RB1qew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by BL1PR11MB5222.namprd11.prod.outlook.com (2603:10b6:208:313::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.32; Sun, 3 Dec
 2023 10:57:06 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67%5]) with mapi id 15.20.7046.032; Sun, 3 Dec 2023
 10:57:06 +0000
Date:   Sun, 3 Dec 2023 18:56:56 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
CC:     Kees Cook <keescook@chromium.org>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <ZWxe+M2RkN+UQ3SN@rli9-mobl>
References: <202312031555.EyyW2riN-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202312031555.EyyW2riN-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|BL1PR11MB5222:EE_
X-MS-Office365-Filtering-Correlation-Id: 840eabb7-1876-4e44-c0c7-08dbf3ee95e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s8XfrCEtATwL1O66k9g78AmwEQS3YeFSwyF8I/ZrxOH9U5C+uwhNbj+/QeVUvBLrphQ530Kze1sOnWLAo2u1jXhFRKLfsVcZ3hc6gYEkRLd3zBz2Rcs0LJwbrKPRkwoptk4zTu/ZNZnz0BNMcjGgRu2Q/0nx5ILdUoyTNPkxuE+LCFaj/KvNqyfEnRmX2dRBv3DUOwVP1/V1leIkXxyfs5Xik4YqEUQcV6gia+CfSIHd00+/nENmhVSeP677fCRFS3YebMveW6MdlhQPrl/y32Kil3kmkI0wX78ivoEoVYd8kCs25J9FocFGtoBAWBuqZwtDzLfoZ7D4Vtt6d22HZu9H0jQXXxhops6H8Xhp5GCFPmZ14hF9AAPGuBwwTwMPQEJPMAOGYjGJJFZUX+sDz9dmXC5C2dE/z8VQl7KtCtsnLK8t/RLEfuN5tX+64iAnqSZ2jK8VBsshFmuBqzL8Q6BzHwNQrC+b8e3OdmiP/pwNXq9QCAtq/Vo8jl+52SVdoQhxoq23YDxpNjfxcK3GQ6BkrAYTlcZMJA9P6gS79N8lcykU0jsEmR84vp+e+NU0MXq9Qfo1oB81DgmKDsIh714/KnyTVs6J54zaZ7PrhMn9SFmzSo7CcZYCUCIyVI5AI9sAEDMkUKGdZiQGIWPkCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(376002)(136003)(396003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(186009)(1800799012)(8936002)(8676002)(6862004)(4326008)(6512007)(9686003)(6506007)(83380400001)(82960400001)(26005)(6486002)(966005)(478600001)(6666004)(66476007)(54906003)(66946007)(66556008)(316002)(6636002)(2906002)(33716001)(41300700001)(38100700002)(44832011)(86362001)(4001150100001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y/vqsJDIS/mEqsK0me+d05W8w+3MpHuXqi4pBfcejD91M9rPcOB6zJ//NDoj?=
 =?us-ascii?Q?w/jM9EKErfV6j3JM2ndYv3xULyjxDjIOgwK7JvC1T1LmayFgSuyvnyddP7sX?=
 =?us-ascii?Q?GGnIwcPrjLcTlEfSxcPmP8phL7bi9YiQFmdkgwRf4kkhy6ZCS2oFV4bhoX+o?=
 =?us-ascii?Q?KmtxudaMos7TX1Ea08IiV0F81Tv0q3EvrGMFs8Qa34M8XlGhdI9ws0j5son5?=
 =?us-ascii?Q?sw49a3H4/aUhwvOhWuU5qAZvGSO1PjrZV636Ixqt9Zz0c9/l70RE5NW0zi4z?=
 =?us-ascii?Q?GaDMvfXE4tsoxvPCubgsg2/gtig0fXTxLa/S5Ik1adQJPZ38s9qmzZfD5aTk?=
 =?us-ascii?Q?tUR0G4VEHrvPw6SlQgG+QVv6DLwoSo7XMv6UlfIB7F5dCDWIn1EG4cU0NUNd?=
 =?us-ascii?Q?iPZxF4Z8BKfx3QYmC1cB67g+3Mgk5dD8+O+5WLOuIRtpKHk7kzsny8eNHAdy?=
 =?us-ascii?Q?fKkTKMio/UKiGRmJlKFZSIfSGIpcsr+Ql6AJ5Jd8SAmw9blT2fTgD8NTvLnB?=
 =?us-ascii?Q?NVvkTSf5sPAHxN4sPB0k7GzNzQ6NPvJBxRMLrmvasTN4TSEBYXDiq89rM/12?=
 =?us-ascii?Q?66BNcMAvOoNQhZCZW3hFdP9oQpuHmY7vWY1deD4xIWinJX7Hn5jRYzkZv7fg?=
 =?us-ascii?Q?p0Xe+EJDMcuC6O8y0rJyQK6QW5XFFYW5Hl/lMBIpwlIEm5FhxCH1snpzicku?=
 =?us-ascii?Q?Q8/eS4ic8IvCne+5G9dRgmwQjlxvwUdw75JjcNJUhtc+VbtAcq+Ye2CGEmlI?=
 =?us-ascii?Q?i0mE8ykdpOURyGqRAS0nc0cYNuqGHFWIUz1pK4DmnLw6T3vHqd9gvYQW3ftI?=
 =?us-ascii?Q?RzZf8BRO+eWs6BXvo/IhOODoN5WWp7pnuu9tgbECVoBRKHEw5OTiAftgPJ4U?=
 =?us-ascii?Q?wuXKoXkLvQBly/PbVlumvQbEPPWF16RxdleSg0FNsq8JYhPRrvcyLJhofEsn?=
 =?us-ascii?Q?QcHXrDXVCfZ51deUxZh/TYPgQDVCbu9crZ+/B/znbxZxj5eYTPjwGvDGLSzP?=
 =?us-ascii?Q?MWds1DFOm1HXtlNNQ+uG0KIMjI4wInLkXjkForZW1ZxnZeDUqiuEFaiTU/e8?=
 =?us-ascii?Q?m5vm3iThegg2PjuV/cGeW+/2NkgkbD8Best9lbRk+wzzDXsoN/fqcULdjN6V?=
 =?us-ascii?Q?pyKnNyEo8i3prH8S8yyoYDsOp8UDmcOeu8qF9RcsRL7RuJ5wGiEyMmbzb6YA?=
 =?us-ascii?Q?vG5h2lFx59Xuw5HSocm35+3Yvj3+bbZOpU1Wr9uL4tw5PH0+T+OEY8vYBCgJ?=
 =?us-ascii?Q?inKrcTRt7sTfvqU4rsnyZjxbXy8Jy73T3SdGIygocbZ2gACk2pP1Bci7fzER?=
 =?us-ascii?Q?KOquIk/oBYLkY2k+Zot/5z+tyHjlQcy1h15VcadU/TMUeBMlPCmiVrOm882G?=
 =?us-ascii?Q?VwDd2YMPFE11QfTeXcobjv0HUi246QrR2y1yAwfH+IGkR/qucvvFKNXZ+QGz?=
 =?us-ascii?Q?wwJuJBLJJ9+LPYUV3qzLsnFIUwDbhPrRa7xT8aHpLB11+bd3yJdrRkZ74md/?=
 =?us-ascii?Q?rRlyzUAPX5fGMlBOhtPFTufIlkBLQUjpu6i+Q7rdzFcREeurATfMoGQhWoRj?=
 =?us-ascii?Q?ViYG7eQK98fhQNfpwDUTGdqn61sG9FGV2tjKKhT5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 840eabb7-1876-4e44-c0c7-08dbf3ee95e5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2023 10:57:04.8866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vu4vJjY3xdozGHBHsYXAKiwBtumnCvB0mCg7A/8I9xNrnP40jz4c+wrdP+HO0+FyFKviEXsrCKgktaR/LwS+vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5222
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

On Sun, Dec 03, 2023 at 03:32:46PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   968f35f4ab1c0966ceb39af3c89f2e24afedf878
> commit: 281d0c962752fb40866dd8d4cade68656f34bd1f fortify: Add Clang support
> date:   1 year, 10 months ago
> config: arm64-randconfig-r131-20231130 (https://download.01.org/0day-ci/archive/20231203/202312031555.EyyW2riN-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce: (https://download.01.org/0day-ci/archive/20231203/202312031555.EyyW2riN-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of

Kindly ignore the report that the found commit is not the cause of
this sparse warning. Sorry for the wrong info.

> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202312031555.EyyW2riN-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *cpu_addr @@
>    drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse:     expected void const *
>    drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse:     got void [noderef] __iomem *cpu_addr
> >> drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *cpu_addr @@
>    drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse:     expected void const *
>    drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse:     got void [noderef] __iomem *cpu_addr
>    drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *cpu_addr @@
>    drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse:     expected void *
>    drivers/remoteproc/ti_k3_r5_remoteproc.c:437:9: sparse:     got void [noderef] __iomem *cpu_addr
>    drivers/remoteproc/ti_k3_r5_remoteproc.c:440:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *cpu_addr @@
>    drivers/remoteproc/ti_k3_r5_remoteproc.c:440:9: sparse:     expected void const *
>    drivers/remoteproc/ti_k3_r5_remoteproc.c:440:9: sparse:     got void [noderef] __iomem *cpu_addr
>    drivers/remoteproc/ti_k3_r5_remoteproc.c:440:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __iomem *cpu_addr @@
>    drivers/remoteproc/ti_k3_r5_remoteproc.c:440:9: sparse:     expected void const *
>    drivers/remoteproc/ti_k3_r5_remoteproc.c:440:9: sparse:     got void [noderef] __iomem *cpu_addr
>    drivers/remoteproc/ti_k3_r5_remoteproc.c:440:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void * @@     got void [noderef] __iomem *cpu_addr @@
>    drivers/remoteproc/ti_k3_r5_remoteproc.c:440:9: sparse:     expected void *
>    drivers/remoteproc/ti_k3_r5_remoteproc.c:440:9: sparse:     got void [noderef] __iomem *cpu_addr
> 
> vim +437 drivers/remoteproc/ti_k3_r5_remoteproc.c
> 
> 6dedbd1d544389 Suman Anna 2020-10-02  378  
> 6dedbd1d544389 Suman Anna 2020-10-02  379  /*
> 6dedbd1d544389 Suman Anna 2020-10-02  380   * The R5F cores have controls for both a reset and a halt/run. The code
> 6dedbd1d544389 Suman Anna 2020-10-02  381   * execution from DDR requires the initial boot-strapping code to be run
> 6dedbd1d544389 Suman Anna 2020-10-02  382   * from the internal TCMs. This function is used to release the resets on
> 6dedbd1d544389 Suman Anna 2020-10-02  383   * applicable cores to allow loading into the TCMs. The .prepare() ops is
> 6dedbd1d544389 Suman Anna 2020-10-02  384   * invoked by remoteproc core before any firmware loading, and is followed
> 6dedbd1d544389 Suman Anna 2020-10-02  385   * by the .start() ops after loading to actually let the R5 cores run.
> ee99ee7c929c3e Suman Anna 2021-03-27  386   *
> ee99ee7c929c3e Suman Anna 2021-03-27  387   * The Single-CPU mode on applicable SoCs (eg: AM64x) only uses Core0 to
> ee99ee7c929c3e Suman Anna 2021-03-27  388   * execute code, but combines the TCMs from both cores. The resets for both
> ee99ee7c929c3e Suman Anna 2021-03-27  389   * cores need to be released to make this possible, as the TCMs are in general
> ee99ee7c929c3e Suman Anna 2021-03-27  390   * private to each core. Only Core0 needs to be unhalted for running the
> ee99ee7c929c3e Suman Anna 2021-03-27  391   * cluster in this mode. The function uses the same reset logic as LockStep
> ee99ee7c929c3e Suman Anna 2021-03-27  392   * mode for this (though the behavior is agnostic of the reset release order).
> 6dedbd1d544389 Suman Anna 2020-10-02  393   */
> 6dedbd1d544389 Suman Anna 2020-10-02  394  static int k3_r5_rproc_prepare(struct rproc *rproc)
> 6dedbd1d544389 Suman Anna 2020-10-02  395  {
> 6dedbd1d544389 Suman Anna 2020-10-02  396  	struct k3_r5_rproc *kproc = rproc->priv;
> 6dedbd1d544389 Suman Anna 2020-10-02  397  	struct k3_r5_cluster *cluster = kproc->cluster;
> 6dedbd1d544389 Suman Anna 2020-10-02  398  	struct k3_r5_core *core = kproc->core;
> 6dedbd1d544389 Suman Anna 2020-10-02  399  	struct device *dev = kproc->dev;
> 7508ea19b20da8 Suman Anna 2020-11-18  400  	u32 ctrl = 0, cfg = 0, stat = 0;
> 7508ea19b20da8 Suman Anna 2020-11-18  401  	u64 boot_vec = 0;
> 7508ea19b20da8 Suman Anna 2020-11-18  402  	bool mem_init_dis;
> 6dedbd1d544389 Suman Anna 2020-10-02  403  	int ret;
> 6dedbd1d544389 Suman Anna 2020-10-02  404  
> 7508ea19b20da8 Suman Anna 2020-11-18  405  	ret = ti_sci_proc_get_status(core->tsp, &boot_vec, &cfg, &ctrl, &stat);
> 7508ea19b20da8 Suman Anna 2020-11-18  406  	if (ret < 0)
> 7508ea19b20da8 Suman Anna 2020-11-18  407  		return ret;
> 7508ea19b20da8 Suman Anna 2020-11-18  408  	mem_init_dis = !!(cfg & PROC_BOOT_CFG_FLAG_R5_MEM_INIT_DIS);
> 7508ea19b20da8 Suman Anna 2020-11-18  409  
> ee99ee7c929c3e Suman Anna 2021-03-27  410  	/* Re-use LockStep-mode reset logic for Single-CPU mode */
> ee99ee7c929c3e Suman Anna 2021-03-27  411  	ret = (cluster->mode == CLUSTER_MODE_LOCKSTEP ||
> ee99ee7c929c3e Suman Anna 2021-03-27  412  	       cluster->mode == CLUSTER_MODE_SINGLECPU) ?
> 6dedbd1d544389 Suman Anna 2020-10-02  413  		k3_r5_lockstep_release(cluster) : k3_r5_split_release(core);
> 34f2653686fecc Suman Anna 2020-10-02  414  	if (ret) {
> 6dedbd1d544389 Suman Anna 2020-10-02  415  		dev_err(dev, "unable to enable cores for TCM loading, ret = %d\n",
> 6dedbd1d544389 Suman Anna 2020-10-02  416  			ret);
> 6dedbd1d544389 Suman Anna 2020-10-02  417  		return ret;
> 6dedbd1d544389 Suman Anna 2020-10-02  418  	}
> 6dedbd1d544389 Suman Anna 2020-10-02  419  
> 7508ea19b20da8 Suman Anna 2020-11-18  420  	/*
> 7508ea19b20da8 Suman Anna 2020-11-18  421  	 * Newer IP revisions like on J7200 SoCs support h/w auto-initialization
> 7508ea19b20da8 Suman Anna 2020-11-18  422  	 * of TCMs, so there is no need to perform the s/w memzero. This bit is
> 7508ea19b20da8 Suman Anna 2020-11-18  423  	 * configurable through System Firmware, the default value does perform
> 7508ea19b20da8 Suman Anna 2020-11-18  424  	 * auto-init, but account for it in case it is disabled
> 7508ea19b20da8 Suman Anna 2020-11-18  425  	 */
> 7508ea19b20da8 Suman Anna 2020-11-18  426  	if (cluster->soc_data->tcm_ecc_autoinit && !mem_init_dis) {
> 7508ea19b20da8 Suman Anna 2020-11-18  427  		dev_dbg(dev, "leveraging h/w init for TCM memories\n");
> 7508ea19b20da8 Suman Anna 2020-11-18  428  		return 0;
> 7508ea19b20da8 Suman Anna 2020-11-18  429  	}
> 7508ea19b20da8 Suman Anna 2020-11-18  430  
> 34f2653686fecc Suman Anna 2020-10-02  431  	/*
> 34f2653686fecc Suman Anna 2020-10-02  432  	 * Zero out both TCMs unconditionally (access from v8 Arm core is not
> 34f2653686fecc Suman Anna 2020-10-02  433  	 * affected by ATCM & BTCM enable configuration values) so that ECC
> 34f2653686fecc Suman Anna 2020-10-02  434  	 * can be effective on all TCM addresses.
> 34f2653686fecc Suman Anna 2020-10-02  435  	 */
> 34f2653686fecc Suman Anna 2020-10-02  436  	dev_dbg(dev, "zeroing out ATCM memory\n");
> 34f2653686fecc Suman Anna 2020-10-02 @437  	memset(core->mem[0].cpu_addr, 0x00, core->mem[0].size);
> 34f2653686fecc Suman Anna 2020-10-02  438  
> 34f2653686fecc Suman Anna 2020-10-02  439  	dev_dbg(dev, "zeroing out BTCM memory\n");
> 34f2653686fecc Suman Anna 2020-10-02  440  	memset(core->mem[1].cpu_addr, 0x00, core->mem[1].size);
> 34f2653686fecc Suman Anna 2020-10-02  441  
> 34f2653686fecc Suman Anna 2020-10-02  442  	return 0;
> 34f2653686fecc Suman Anna 2020-10-02  443  }
> 34f2653686fecc Suman Anna 2020-10-02  444  
> 
> :::::: The code at line 437 was first introduced by commit
> :::::: 34f2653686fecc9bd5a4ee16724768c72953fb57 remoteproc: k3-r5: Initialize TCM memories for ECC
> 
> :::::: TO: Suman Anna <s-anna@ti.com>
> :::::: CC: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
