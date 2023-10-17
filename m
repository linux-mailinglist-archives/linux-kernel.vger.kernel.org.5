Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E482A7CCA27
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343969AbjJQRup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjJQRun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:50:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262FF90;
        Tue, 17 Oct 2023 10:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697565040; x=1729101040;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Tmxa5c+IoCGcxeGCPqQVKtGwKF2k/B0dQO+7UApIa7k=;
  b=IchFiplsheadTC4w4z8Cj7hT94pFgQ17uQQogaUKJN6eQLEMAxTCo/NU
   H5E+x/1LBS/ncALbbR25SEWROS2/bi0Wpc92/2JmhBY+fzQ4anY01ooip
   qh14svyjI55m0opyKhvRr1nME/GVb6KBaB/QKGrVcAKkFWW51Hn96ic0l
   Z2ZTgoEMyWEGgcy5uoVOPLeY7eFxuu4rKEUBq2lITTJSK2CJiAF3e+azL
   +lzWK6on7ryRz8YK/+CwVicGcqXVAsT1BoYyXwh7sZvPnLRV6Q7F9/7nR
   0+Ayjc1lre3aTisXS40CKlXIHYnbNeYbupUP7wmufTWbtSEhkd2jsjGbC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="384726223"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="384726223"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 10:50:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="759911719"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="759911719"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 10:50:16 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 10:50:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 10:50:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 10:50:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1rjbtaRUhotP64mNlB0NXGnk2dEqEZK4LJ9HkO+WCpjVOgVageJkGDSCeYiZSdrfZSTzxfuIS7LlM9GhDPM5Kx7kyIP7y0Mde1YRmvkA1/67fvgBVB6id9gSHu51wucI1qWRyEamha5YlGvO/avqgC6KD7mIQdTJi9rjwovo25fQjfRtpLIwfYGDoUzDJnEhrswcvy6MNmrt0GxjKjECDcCw0+ZcPf0NKpT6/opFF3YzoW0+eTXnHPisG6wd82/WhmJ+qLMFsY9NduzQqEAJezY6SjVKgQlFIBW2VjYmkHkwXRbZbfjjJgKPAhXwX/qbJCUAqkcsVyobykUNYocNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulnhoy3Q7O6oL4DxU/hRLAiMX9cqNsI+3PR5ZiV5Rmk=;
 b=jRqRBNvkjl33csHpoSq6PKBwN6Bs1z7z6XxpaT7qIDrI/HmpVdaP1yG9ulIwn7O0StgwY4DqM7pZUYFG62fzK00FH7u75/qETnXZKcGodeC0wws7nU0RpqqrmfowT4aMDDG9DHgJBhEw5xKTHnMpI7u6eYnZK92KLIgrYBNw9qABur6SksGEdQBo1xkiewAf6eZBXJyv/ulTpIFbvWT1Zd8X3VqUWkqJ3mOb0R+S1ku/TQE1It+5DHmwr2NcrPpAqVO3+/HZevH2vb143o6Wac6C9//i57gneHDfwTV/wlPrTMqkdAF0a28gnsHrox1UxoCUELsPC/EfWCkYyUyAEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by DM4PR11MB8178.namprd11.prod.outlook.com (2603:10b6:8:18f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Tue, 17 Oct
 2023 17:50:13 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::c228:5055:b7da:d0bf]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::c228:5055:b7da:d0bf%6]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 17:50:13 +0000
Date:   Tue, 17 Oct 2023 12:50:15 -0500
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Michal Suchanek <msuchanek@suse.de>
CC:     <linux-modules@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
        "Lucas De Marchi" <lucas.de.marchi@gmail.com>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH kmod v5 5/5] libkmod, depmod, modprobe: Make directory
 for kernel modules configurable
Message-ID: <e3yow7ih6af2hxzkmjay2oan3jypmo4hda64vxvpfco66ajcew@i3zewn4nbklf>
References: <cover.1689589902.git.msuchanek@suse.de>
 <cover.1689681454.git.msuchanek@suse.de>
 <b878a01f09e250bb24dbaede71cc776217a8f862.1689681454.git.msuchanek@suse.de>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <b878a01f09e250bb24dbaede71cc776217a8f862.1689681454.git.msuchanek@suse.de>
X-ClientProxiedBy: BYAPR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:40::19) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|DM4PR11MB8178:EE_
X-MS-Office365-Filtering-Correlation-Id: e1c5ec52-5f5f-4fdc-2dee-08dbcf398395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bcWmBPkDGxNtvR18xWXRPL1nbAr6hhYCCEZJdw9HJQNCkW7+FPbBllT2UCNaoV9ZPpOS4PmRF5QrhtR7T6/AJppGNSZp3g8mkkw/IQmdExwVHrCCWUgE68gJ5r+u9OZ/qL5C9L1+iEXlbubI+F7thwUvt8mLc1txojTJAltselMCAyF/OuhZAknNo6L+UosRn2/OCPqv532Ng5p5+mwvpf7uFptZbiy/4v/V1kfC1oqzK7PWBCeCWBl4/nfVScrx92eMwPWx1tV8kTYcT67ukP7aITpvp001BUTczBgEm8V2vxWFznn/m5cU+X8pFtQ0S0WvJs+mrIw3NR93d/6qkTHZiUz6hLIJXYENigId+hV6pJO/CII0RoCYK2TpJt3uSUZPCGqmf4t049RDamS761yKjHN65T5VAS6IwiFyeVmyBL9+702+0EUhpBh3qGT3ywi1c7yqmBRypep2r3XU0VKStmjQIjAE2aVTvqN6xYAsj45wQR5mq2VWtT1fiS1zoi99iEfLs0DGOVTog3pTXffFr7cSkVB2ToPWgILhpFB/B5CluMxz1z2al33rpz5Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(346002)(39860400002)(366004)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6486002)(66556008)(478600001)(66946007)(66476007)(33716001)(54906003)(6916009)(30864003)(82960400001)(26005)(6506007)(4326008)(2906002)(6512007)(8936002)(8676002)(5660300002)(41300700001)(86362001)(9686003)(7416002)(316002)(83380400001)(38100700002)(66899024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0opbyutF1cMcNjK9ZG+4ZxOjLRaPo6KJwB8U7Wi+UBNmHcPqJk2mL/KHkXzb?=
 =?us-ascii?Q?Cw0v9xF2RGxgKVet2CrUo9pGq3plWbc0lNqbYrRQvyHEHStBhjud7M2tCFpL?=
 =?us-ascii?Q?9K53huzqIALUshcGl61HZIeAE6Wd/H/dr+JClLkUYKr1/b2y8OVya6ysKKfc?=
 =?us-ascii?Q?uE46PFPcLLACfv6wegqpbBotoJd5AX5dWXasLS7sZd3et/hSmF8tAqtVdUrs?=
 =?us-ascii?Q?8Mq5v6HmXPwclDmN1wI5bakOqMlrXWgezxuDLmwIME6D6xI7M3Y2EOhpfXTL?=
 =?us-ascii?Q?hUvbS4wroF1o6tT7syUu7z+bmpIrKFIAvQaMc6NGLKmikv5ISRbzG0YxzFAA?=
 =?us-ascii?Q?cFigqfRbVv/Hcw08bYxsmdwcPL7IMz/JDkCT3UvEkqGaAJGd1wcmMHjkY5B4?=
 =?us-ascii?Q?b+VQtGw1b2vk0bFvTOdO8ZwMlhnnSE05ilmO6/cXzmTnxcIf5owHHuB9Z54A?=
 =?us-ascii?Q?Dp6HSmgrPapBs0MTEithTuwGDiBRoAiysbf6AEvcBsftqhxazJt6+IoJH4+0?=
 =?us-ascii?Q?kDVdpaMzVWMPPKNMMCBemy2r5vMsvcQST8ihL4DfTYihx+Jrz2TbulkUyiI7?=
 =?us-ascii?Q?+INHuMmpNP7dfS6CELERRPnnKHmtPeKUNiM+WsAEoep6DADhfLiUig2m2hB1?=
 =?us-ascii?Q?BzhHz32OMk+JhXwfriEal6V0pNSpbhzGWbzzSZ0vgoeufE2XSg1EijFZe5E2?=
 =?us-ascii?Q?Jmk7XtS9p7E6s7dyRuAI61P5ZVAC92ab9rnZCQ/KkwImXdmT3jaMQ1RoCcfq?=
 =?us-ascii?Q?2pKNNn8fenefdwvJCjKk5FdjDCXUlQBXN/TfIZkwSABiTTPp+YO8GywEGqTK?=
 =?us-ascii?Q?QKxf/LEZarqaAM3DSB6eWQZZDfIncKv0cwF8aJHUWHaLbIa4/2iepyZeHqO2?=
 =?us-ascii?Q?Gc0K3++WNnoar6Ocy/oWGnGGdiuHkevcNsKvBXbvGwFIGx6XIrVBq85YCnXP?=
 =?us-ascii?Q?dQMMlPrfLGI8T9umspBF8t9XYQvhmNXINPfrVj8PiB3cD6VP2NvY5S6ah9Px?=
 =?us-ascii?Q?AtBThWOe7/qkklUfhPXH3MhDCMl5B2H0P3HVKox7GbjSzgs3tmmMVgb8Zl1o?=
 =?us-ascii?Q?lmbbvkzqO3Zy8yuOJi+wFDflgfOKc9LOF29yd+gyrwbbRyIV4MvuFn7l78Mh?=
 =?us-ascii?Q?EdMczDWaCimI7/rfvAyES/WtJa5Y/1zTM4/iOK1oS4wSf31ptzU6xByh8JCS?=
 =?us-ascii?Q?aHeqOFvCN8wtGKG7jGW3ReX+fQRQ8ubdL1McZgMDJW1D28SHznNVOlgq9rEZ?=
 =?us-ascii?Q?oOfaW0YnMgNUisl3seT7wFVCfOhVz2qhI+Nhvva7b/qS+vRi0c85ZNhV62kn?=
 =?us-ascii?Q?H57tRmx2n/VgAne/VVvrN79OfFQhEGpGG0dbsxRFpLlQ0pbo3v3brJsG0hIi?=
 =?us-ascii?Q?sPY/85pyS944q6EVnNR5psAnwGzNdnt8majQfDisOS1h1iWxHEB+GLpsQhjk?=
 =?us-ascii?Q?cwnhy+vXh52SWkZs+77eFPlurxBDPXwivTWIF9AAPffWsrCJBTn0bm0/MOEz?=
 =?us-ascii?Q?HgJq61fe3caqFPUWYoDjKC1aQ/GdF8NVQfqZGyGvVnlO+NU9A2zAj/xqtlzn?=
 =?us-ascii?Q?DvnPWPRZOeo2e7PLFmluwPrjYMMQZC4vz2fw4g77/KfQjK8CRHDJLaEF7zYS?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c5ec52-5f5f-4fdc-2dee-08dbcf398395
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 17:50:13.4552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PL/EbsU/GaTqp6JhqtPyOV4olHLaJeGiAwkp1oRRVyg4ZpY3mfKCYmm/5gBzrG4VuxeBWvLPepxi3IYhYtE3uzIRVne00xpJmJffQO2ObKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8178
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 02:01:56PM +0200, Michal Suchanek wrote:
>Now that modprobe.d is searched under ${prefix}/lib, allow a complete
>transition to files only under ${prefix} by adding a ${module_directory}
>configuration. This specifies the directory where to search for kernel
>modules and should match the location where the kernel/distro installs
>them.
>
>With this distributions that do not want to ship files in /lib can also
>move kernel modules to /usr while others can keep them in /lib.
>
>Signed-off-by: Michal Suchanek <msuchanek@suse.de>
>---
>v4: Make the whole path configurable
>v5: More verbose commit message
>---
> Makefile.am                          |   3 +-
> configure.ac                         |   7 ++
> libkmod/libkmod.c                    |   4 +-
> man/Makefile.am                      |   1 +
> man/depmod.d.xml                     |   6 +-
> man/depmod.xml                       |   4 +-
> man/modinfo.xml                      |   2 +-
> man/modprobe.xml                     |   2 +-
> man/modules.dep.xml                  |   6 +-
> testsuite/module-playground/Makefile |   2 +-
> testsuite/setup-rootfs.sh            | 109 +++++++++++++++------------
> testsuite/test-depmod.c              |  16 ++--
> testsuite/test-testsuite.c           |   8 +-
> tools/depmod.c                       |   6 +-
> tools/kmod.pc.in                     |   1 +
> tools/modinfo.c                      |   4 +-
> tools/modprobe.c                     |   4 +-
> tools/static-nodes.c                 |   6 +-
> 18 files changed, 107 insertions(+), 84 deletions(-)
>
>diff --git a/Makefile.am b/Makefile.am
>index 6d0b2decfef3..019aa749fdf1 100644
>--- a/Makefile.am
>+++ b/Makefile.am
>@@ -20,6 +20,7 @@ AM_CPPFLAGS = \
> 	-I$(top_srcdir) \
> 	-DSYSCONFDIR=\""$(sysconfdir)"\" \
> 	-DDISTCONFDIR=\""$(distconfdir)"\" \
>+	-DMODULE_DIRECTORY=\""$(module_directory)"\" \
> 	${zlib_CFLAGS}
>
> AM_CFLAGS = $(OUR_CFLAGS)
>@@ -220,7 +221,7 @@ EXTRA_DIST += testsuite/setup-rootfs.sh
> MODULE_PLAYGROUND = testsuite/module-playground
> ROOTFS = testsuite/rootfs
> ROOTFS_PRISTINE = $(top_srcdir)/testsuite/rootfs-pristine
>-CREATE_ROOTFS = $(AM_V_GEN) $(top_srcdir)/testsuite/setup-rootfs.sh $(ROOTFS_PRISTINE) $(ROOTFS) $(MODULE_PLAYGROUND) $(top_builddir)/config.h $(sysconfdir)
>+CREATE_ROOTFS = $(AM_V_GEN) MODULE_DIRECTORY=$(module_directory) $(top_srcdir)/testsuite/setup-rootfs.sh $(ROOTFS_PRISTINE) $(ROOTFS) $(MODULE_PLAYGROUND) $(top_builddir)/config.h $(sysconfdir)
>
> build-module-playground:
> 	$(AM_V_GEN)if test "$(top_srcdir)" != "$(top_builddir)"; then \
>diff --git a/configure.ac b/configure.ac
>index b4584d6cdc67..4051dc9249e2 100644
>--- a/configure.ac
>+++ b/configure.ac
>@@ -91,6 +91,12 @@ AC_ARG_WITH([rootlibdir],
>         [], [with_rootlibdir=$libdir])
> AC_SUBST([rootlibdir], [$with_rootlibdir])
>
>+# Ideally this would be $prefix/lib/modules but default to /lib/modules for compatibility with earlier versions
>+AC_ARG_WITH([module_directory],
>+        AS_HELP_STRING([--with-module-directory=DIR], [directory in which to look for kernel modules - typically '/lib/modules' or '${prefix}/lib/modules']),
>+        [], [with_module_directory=/lib/modules])
>+AC_SUBST([module_directory], [$with_module_directory])

we will probably have "fun" results if we accept a relative path here.

>+
> AC_ARG_WITH([zstd],
> 	AS_HELP_STRING([--with-zstd], [handle Zstandard-compressed modules @<:@default=disabled@:>@]),
> 	[], [with_zstd=no])
>@@ -326,6 +332,7 @@ AC_MSG_RESULT([
> 	$PACKAGE $VERSION
> 	=======
>
>+	module_directory:	${module_directory}
> 	prefix:			${prefix}
> 	sysconfdir:		${sysconfdir}
> 	distconfdir:		${distconfdir}
>diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
>index 09e6041461b0..63719e886de8 100644
>--- a/libkmod/libkmod.c
>+++ b/libkmod/libkmod.c
>@@ -209,7 +209,7 @@ static int log_priority(const char *priority)
> 	return 0;
> }
>
>-static const char *dirname_default_prefix = "/lib/modules";
>+static const char *dirname_default_prefix = MODULE_DIRECTORY;
>
> static char *get_kernel_release(const char *dirname)
> {
>@@ -231,7 +231,7 @@ static char *get_kernel_release(const char *dirname)
> /**
>  * kmod_new:
>  * @dirname: what to consider as linux module's directory, if NULL
>- *           defaults to /lib/modules/`uname -r`. If it's relative,
>+ *           defaults to ${module_prefix}/lib/modules/`uname -r`. If it's relative,

module_prefix?  did you mean to use $MODULE_DIRECTORY/`uname -r`?

>  *           it's treated as relative to the current working directory.
>  *           Otherwise, give an absolute dirname.
>  * @config_paths: ordered array of paths (directories or files) where
>diff --git a/man/Makefile.am b/man/Makefile.am
>index 2fea8e46bf2f..f550091a216a 100644
>--- a/man/Makefile.am
>+++ b/man/Makefile.am
>@@ -22,6 +22,7 @@ CLEANFILES = $(dist_man_MANS)
> 	else \
> 		sed -e '/@DISTCONFDIR@/d' $< ; \
> 	fi | \
>+	sed -e 's|@MODULE_DIRECTORY@|$(module_directory)|g' | \
> 	$(XSLT) \
> 		-o $@ \
> 		--nonet \
>diff --git a/man/depmod.d.xml b/man/depmod.d.xml
>index f282a39cc840..b07e6a2bd4fe 100644
>--- a/man/depmod.d.xml
>+++ b/man/depmod.d.xml
>@@ -70,7 +70,7 @@
>         </term>
>         <listitem>
>           <para>
>-            This allows you to specify the order in which /lib/modules
>+            This allows you to specify the order in which @MODULE_DIRECTORY@
>             (or other configured module location) subdirectories will
>             be processed by <command>depmod</command>. Directories are
>             listed in order, with the highest priority given to the
>@@ -101,7 +101,7 @@
>             <command>depmod</command> command. It is possible to
>             specify one kernel or all kernels using the * wildcard.
>             <replaceable>modulesubdirectory</replaceable> is the
>-            name of the subdirectory under /lib/modules (or other
>+            name of the subdirectory under @MODULE_DIRECTORY@ (or other
>             module location) where the target module is installed.
>           </para>
>           <para>
>@@ -110,7 +110,7 @@
>             specifying the following command: "override kmod * extra".
>             This will ensure that any matching module name installed
>             under the <command>extra</command> subdirectory within
>-            /lib/modules (or other module location) will take priority
>+            @MODULE_DIRECTORY@ (or other module location) will take priority
>             over any likenamed module already provided by the kernel.
>           </para>
>         </listitem>
>diff --git a/man/depmod.xml b/man/depmod.xml
>index 3b0097184fd7..fce2a4a67a89 100644
>--- a/man/depmod.xml
>+++ b/man/depmod.xml
>@@ -80,7 +80,7 @@
>     </para>
>     <para> <command>depmod</command> creates a list of module dependencies by
>       reading each module under
>-      <filename>/lib/modules/</filename><replaceable>version</replaceable> and
>+      <filename>@MODULE_DIRECTORY@/</filename><replaceable>version</replaceable> and
>       determining what symbols it exports and what symbols it needs.  By
>       default, this list is written to <filename>modules.dep</filename>, and a
>       binary hashed version named <filename>modules.dep.bin</filename>, in the
>@@ -141,7 +141,7 @@
>         <listitem>
>           <para>
>             If your modules are not currently in the (normal) directory
>-            <filename>/lib/modules/</filename><replaceable>version</replaceable>,
>+            <filename>@MODULE_DIRECTORY@/</filename><replaceable>version</replaceable>,
>             but in a staging area, you can specify a
>             <replaceable>basedir</replaceable> which is prepended to the
>             directory name.  This <replaceable>basedir</replaceable> is
>diff --git a/man/modinfo.xml b/man/modinfo.xml
>index 9fe0324a2527..b6c4d6045829 100644
>--- a/man/modinfo.xml
>+++ b/man/modinfo.xml
>@@ -54,7 +54,7 @@
>       <command>modinfo</command> extracts information from the Linux Kernel
>       modules given on the command line.  If the module name is not a filename,
>       then the
>-      <filename>/lib/modules/</filename><replaceable>version</replaceable>
>+      <filename>@MODULE_DIRECTORY@/</filename><replaceable>version</replaceable>
>       directory is searched, as is also done by
>       <citerefentry><refentrytitle>modprobe</refentrytitle><manvolnum>8</manvolnum></citerefentry>
>       when loading kernel modules.
>diff --git a/man/modprobe.xml b/man/modprobe.xml
>index 91f9e27997cd..4d1fd59c000b 100644
>--- a/man/modprobe.xml
>+++ b/man/modprobe.xml
>@@ -78,7 +78,7 @@
>       is no difference between _ and - in module names (automatic
>       underscore conversion is performed).
>       <command>modprobe</command> looks in the module directory
>-      <filename>/lib/modules/`uname -r`</filename> for all
>+      <filename>@MODULE_DIRECTORY@/`uname -r`</filename> for all
>       the modules and other files, except for the optional
>       configuration files in the
>       <filename>/etc/modprobe.d</filename> directory
>diff --git a/man/modules.dep.xml b/man/modules.dep.xml
>index ed633694ec9e..8ef6d8b3536e 100644
>--- a/man/modules.dep.xml
>+++ b/man/modules.dep.xml
>@@ -34,8 +34,8 @@
>   </refnamediv>
>
>   <refsynopsisdiv>
>-    <para><filename>/lib/modules/modules.dep</filename></para>
>-    <para><filename>/lib/modules/modules.dep.bin</filename></para>
>+    <para><filename>@MODULE_DIRECTORY@/modules.dep</filename></para>
>+    <para><filename>@MODULE_DIRECTORY@/modules.dep.bin</filename></para>
>   </refsynopsisdiv>
>
>   <refsect1><title>DESCRIPTION</title>
>@@ -43,7 +43,7 @@
>       <filename>modules.dep.bin</filename> is a binary file generated by
>       <command>depmod</command> listing the dependencies for
>       every module in the directories under
>-      <filename>/lib/modules/</filename><replaceable>version</replaceable>.
>+      <filename>@MODULE_DIRECTORY@/</filename><replaceable>version</replaceable>.
>       It is used by kmod tools such as <command>modprobe</command> and
>       libkmod.
>     </para>
>diff --git a/testsuite/module-playground/Makefile b/testsuite/module-playground/Makefile
>index e6045b0dd932..a7ab09bea2bf 100644
>--- a/testsuite/module-playground/Makefile
>+++ b/testsuite/module-playground/Makefile
>@@ -47,7 +47,7 @@ endif
>
> else
> # normal makefile
>-KDIR ?= /lib/modules/`uname -r`/build
>+KDIR ?= $(module_prefix)/lib/modules/`uname -r`/build
> KVER ?= `uname -r`
> ifeq ($(FAKE_BUILD),)
>     FAKE_BUILD=0
>diff --git a/testsuite/setup-rootfs.sh b/testsuite/setup-rootfs.sh
>index 4440ddcd6b4d..a780f9381b3c 100755
>--- a/testsuite/setup-rootfs.sh
>+++ b/testsuite/setup-rootfs.sh
>@@ -16,6 +16,19 @@ create_rootfs() {
> 	cp -r "$ROOTFS_PRISTINE" "$ROOTFS"
> 	find "$ROOTFS" -type d -exec chmod +w {} \;
> 	find "$ROOTFS" -type f -name .gitignore -exec rm -f {} \;
>+	if [ "$MODULE_DIRECTORY" != "/lib/modules" ] ; then
>+		sed -i -e "s|/lib/modules|$MODULE_DIRECTORY|g" $(find "$ROOTFS" -name \*.txt -o -name \*.conf -o -name \*.dep)
>+		sed -i -e "s|$MODULE_DIRECTORY/external|/lib/modules/external|g" $(find "$ROOTFS" -name \*.txt -o -name \*.conf -o -name \*.dep)
>+		for i in "$ROOTFS"/*/lib/modules/* "$ROOTFS"/*/*/lib/modules/* ; do
>+			version="$(basename $i)"
>+			[ $version != 'external' ] || continue
>+			mod="$(dirname $i)"
>+			lib="$(dirname $mod)"
>+			up="$(dirname $lib)$MODULE_DIRECTORY"
>+			mkdir -p "$up"
>+			mv "$i" "$up"
>+		done
>+	fi
>
> 	if [ "$SYSCONFDIR" != "/etc" ]; then
> 		find "$ROOTFS" -type d -name etc -printf "%h\n" | while read -r e; do
>@@ -32,57 +45,57 @@ feature_enabled() {
>
> declare -A map
> map=(
>-    ["test-depmod/search-order-simple/lib/modules/4.4.4/kernel/crypto/"]="mod-simple.ko"
>-    ["test-depmod/search-order-simple/lib/modules/4.4.4/updates/"]="mod-simple.ko"
>-    ["test-depmod/search-order-same-prefix/lib/modules/4.4.4/foo/"]="mod-simple.ko"
>-    ["test-depmod/search-order-same-prefix/lib/modules/4.4.4/foobar/"]="mod-simple.ko"
>-    ["test-depmod/detect-loop/lib/modules/4.4.4/kernel/mod-loop-a.ko"]="mod-loop-a.ko"
>-    ["test-depmod/detect-loop/lib/modules/4.4.4/kernel/mod-loop-b.ko"]="mod-loop-b.ko"
>-    ["test-depmod/detect-loop/lib/modules/4.4.4/kernel/mod-loop-c.ko"]="mod-loop-c.ko"
>-    ["test-depmod/detect-loop/lib/modules/4.4.4/kernel/mod-loop-d.ko"]="mod-loop-d.ko"
>-    ["test-depmod/detect-loop/lib/modules/4.4.4/kernel/mod-loop-e.ko"]="mod-loop-e.ko"
>-    ["test-depmod/detect-loop/lib/modules/4.4.4/kernel/mod-loop-f.ko"]="mod-loop-f.ko"
>-    ["test-depmod/detect-loop/lib/modules/4.4.4/kernel/mod-loop-g.ko"]="mod-loop-g.ko"
>-    ["test-depmod/detect-loop/lib/modules/4.4.4/kernel/mod-loop-h.ko"]="mod-loop-h.ko"
>-    ["test-depmod/detect-loop/lib/modules/4.4.4/kernel/mod-loop-i.ko"]="mod-loop-i.ko"
>-    ["test-depmod/detect-loop/lib/modules/4.4.4/kernel/mod-loop-j.ko"]="mod-loop-j.ko"
>-    ["test-depmod/detect-loop/lib/modules/4.4.4/kernel/mod-loop-k.ko"]="mod-loop-k.ko"
>-    ["test-depmod/search-order-external-first/lib/modules/4.4.4/foo/"]="mod-simple.ko"
>-    ["test-depmod/search-order-external-first/lib/modules/4.4.4/foobar/"]="mod-simple.ko"
>+    ["test-depmod/search-order-simple$MODULE_DIRECTORY/4.4.4/kernel/crypto/"]="mod-simple.ko"
>+    ["test-depmod/search-order-simple$MODULE_DIRECTORY/4.4.4/updates/"]="mod-simple.ko"
>+    ["test-depmod/search-order-same-prefix$MODULE_DIRECTORY/4.4.4/foo/"]="mod-simple.ko"
>+    ["test-depmod/search-order-same-prefix$MODULE_DIRECTORY/4.4.4/foobar/"]="mod-simple.ko"
>+    ["test-depmod/detect-loop$MODULE_DIRECTORY/4.4.4/kernel/mod-loop-a.ko"]="mod-loop-a.ko"
>+    ["test-depmod/detect-loop$MODULE_DIRECTORY/4.4.4/kernel/mod-loop-b.ko"]="mod-loop-b.ko"
>+    ["test-depmod/detect-loop$MODULE_DIRECTORY/4.4.4/kernel/mod-loop-c.ko"]="mod-loop-c.ko"
>+    ["test-depmod/detect-loop$MODULE_DIRECTORY/4.4.4/kernel/mod-loop-d.ko"]="mod-loop-d.ko"
>+    ["test-depmod/detect-loop$MODULE_DIRECTORY/4.4.4/kernel/mod-loop-e.ko"]="mod-loop-e.ko"
>+    ["test-depmod/detect-loop$MODULE_DIRECTORY/4.4.4/kernel/mod-loop-f.ko"]="mod-loop-f.ko"
>+    ["test-depmod/detect-loop$MODULE_DIRECTORY/4.4.4/kernel/mod-loop-g.ko"]="mod-loop-g.ko"
>+    ["test-depmod/detect-loop$MODULE_DIRECTORY/4.4.4/kernel/mod-loop-h.ko"]="mod-loop-h.ko"
>+    ["test-depmod/detect-loop$MODULE_DIRECTORY/4.4.4/kernel/mod-loop-i.ko"]="mod-loop-i.ko"
>+    ["test-depmod/detect-loop$MODULE_DIRECTORY/4.4.4/kernel/mod-loop-j.ko"]="mod-loop-j.ko"
>+    ["test-depmod/detect-loop$MODULE_DIRECTORY/4.4.4/kernel/mod-loop-k.ko"]="mod-loop-k.ko"
>+    ["test-depmod/search-order-external-first$MODULE_DIRECTORY/4.4.4/foo/"]="mod-simple.ko"
>+    ["test-depmod/search-order-external-first$MODULE_DIRECTORY/4.4.4/foobar/"]="mod-simple.ko"
>     ["test-depmod/search-order-external-first/lib/modules/external/"]="mod-simple.ko"

why didn't you change it here?

>-    ["test-depmod/search-order-external-last/lib/modules/4.4.4/foo/"]="mod-simple.ko"
>-    ["test-depmod/search-order-external-last/lib/modules/4.4.4/foobar/"]="mod-simple.ko"
>+    ["test-depmod/search-order-external-last$MODULE_DIRECTORY/4.4.4/foo/"]="mod-simple.ko"
>+    ["test-depmod/search-order-external-last$MODULE_DIRECTORY/4.4.4/foobar/"]="mod-simple.ko"
>     ["test-depmod/search-order-external-last/lib/modules/external/"]="mod-simple.ko"

and here...


Otherwise looks good to me.

Pushed the first 4 patches.

thanks
Lucas De Marchi
