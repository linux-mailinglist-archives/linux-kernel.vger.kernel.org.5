Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65D17E1B18
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 08:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjKFHZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 02:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjKFHZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 02:25:13 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B4D112;
        Sun,  5 Nov 2023 23:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699255508; x=1730791508;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kb21lGeqBDXBGEqOzCkkgHJ0cuGvBe3llh4KX3hb0r0=;
  b=QNJR5sfePwpDK40iFElm5kE/ua0beEGw+VJ4Blkc4UOHBkv1tANdQoL5
   duloKXyL6sYfnk/FsOX2XxwGT+qJO8d7d/UNefStyCzDBd6FhKHm5vegW
   tiluKJ1XKR+8+vBnipDYy1f8LXogARJV0BTXi5vhhPgjFKWNg8XJvgItw
   BlhRqRupy9RmorZJfUvYWraOGXcutO19nihvpluKhZMlO96vGnf/nExD2
   QNueGA/QQy2oWQZEsSA8GB2bEdmF1XZPlMVBuAR/UAUfy+q0OlZwhvsfZ
   WmCKOBEE8LbUrQnYb/Mq6XCL+IYfP6m6hRBT5XA8tnxk21fKEZMkUUatS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="388104742"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="388104742"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 23:25:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="1009447561"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="1009447561"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Nov 2023 23:25:08 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 5 Nov 2023 23:25:07 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 5 Nov 2023 23:25:06 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 5 Nov 2023 23:25:06 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 5 Nov 2023 23:25:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z85izwv3Hczjv9Two0NGluVAk7OMmtF2yhO4V3SrVUVOh9OeGAiZRjbysXoX8BhIbibuqm44xYOWHkVFMtdx934ShVDSE8jrEBm1gELpgmat2nk8JqgHaKzLohTtserqm/viNbAGf1G5KBDtGdY7A0frM5H+Ds2Eoe0rEWxRH9gIyDna/albEU0L0pfnDUnoBHD5gHTsuHEvD8tv+0Z4siAJQoyDpzAFX26dnmOfFc5TA352tYsWb1OGI5j2+6TGWSP1+J06o0yGTYXo1AlrHxv+g9mb3A+jfDM7XMs2ugtyZYQN5pAtkNopE4gQo6IqvOoIWPj9QLFO2OQaXeyFIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SrVe1yTNI3UEjRSIUS5rMiPSfoEhBHUYr1lMU46h/c=;
 b=mUF6n00sTnY8B97o6fmFahDRCK0smJ6Mq669aTowI74r2zkprliHZ6vPbvdjaqQgdTPIlXMOMkQxa77APDYeJofKtpbgrL9E5Dp4pAct/0UIqSQe1gbSDX8dSQHKakqZqyAjLP2+PMxalnE5/b1kWceYCmx9w5fzCuTsotzQXA4OYmc2Vky7OEPBEam4t8bQu07cnHryac0vakJHbTvEiBIsTQgrMuUW8mLY6PCOSEzpwLpmysKvcAncVTNfM15XdQq3uAqfXNsw81gyL2/5see7OdmIPRpGZieFC/JRua+6hFShgg36lUIwHGrAk5AB8FnD/q8bQ5P/M4VwmQNoZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by DS0PR11MB8762.namprd11.prod.outlook.com (2603:10b6:8:1a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 07:24:58 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67%4]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 07:24:57 +0000
Date:   Mon, 6 Nov 2023 15:24:49 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
CC:     Arnd Bergmann <arnd@arndb.de>, <llvm@lists.linux.dev>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        <linux-media@vger.kernel.org>, "Hans Verkuil" <hverkuil@xs4all.nl>
Subject: Re: drivers/media/pci/sta2x11/sta2x11_vip.c:1053:6: warning: cast
 from 'irqreturn_t (*)(int, struct sta2x11_vip *)' (aka 'enum irqreturn
 (*)(int, struct sta2x11_vip *)') to 'irq_handler_t' (aka 'enum irqreturn
 (*)(int, void *)') converts to incompatible funct...
Message-ID: <ZUiUwUmo2N0czAJ3@rli9-mobl>
References: <202311061401.8TDz7c7d-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202311061401.8TDz7c7d-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|DS0PR11MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e0124dc-25f4-4e6d-15ae-08dbde997ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0S5NvpEVx3pB2xtFg5L1sRfGrPQRPM/Qq5r2xW5iPklaN/fTduUVJFHQbW0Ofz2bc75SLmf62pInzOtX1MQxo3YI2Pm0FqZnvbg+TT9oYiKv8hqnVItK/+GkKR1mVc6Uaw95nCvuJMYcmQhn+6dWBET327HRy//ukOvkPWZ98XpNzMUiU4qmhU59zQ+IUHPPHoC8oMILPayppBhethVFkWFWCqrwnhjH7ELoaptFIF4Au4HrzU65YmZGPDa/9zF1dy0JUw3tUflt+S0fnfc/py7bHDJqf2gtXF0e99PuNijjRFHiEV1zwcbC3G+JOIM7Be+XSjNDgs04XCgGPaGMzk/q+6H4jKHJxHsz+g72GOJ/iJRKtylFKW12rkjKDT50wfFxJw6ciFw86Ibq7PYUeAIgkVK03timM0cKFQu2WUxTCb+Meu4Z8sfRsfffNdOsvWqKUtNmYO/O1YK+hBDnKSVYNF5wt2P/NhPVdoq05yyB+1sENaB3pkWTBogYKhlLTIOSvc2ZBvDw7WO5ZYyLtDKa1jOZQSBl81fy1jkjT87LGi6H+VVVw1IYlub/sB4kXfTHron0ImWBEU8ZBzVrnJyOX/iMBhf4tNBh4p+nyEflz4ItTCiT0b7KotXD2T3Isk+F975An711ydjFN4cli9EJ5uua1HWt0CxTZtzIG78+Q0ebb5XRoc1qG3MhVuHm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(39860400002)(346002)(366004)(396003)(230173577357003)(230922051799003)(230273577357003)(186009)(451199024)(64100799003)(1800799009)(6506007)(44832011)(86362001)(8936002)(8676002)(38100700002)(966005)(6486002)(6862004)(478600001)(4326008)(33716001)(6666004)(30864003)(5660300002)(9686003)(6512007)(66476007)(54906003)(66946007)(66556008)(6636002)(316002)(2906002)(26005)(4001150100001)(83380400001)(41300700001)(82960400001)(219693005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JcTQOL8SlNYhssnthjMnj0Lo7jCSRUTZXy58GtwYbQhf76DAr6ADQzGc0eBY?=
 =?us-ascii?Q?/WRqIjH4V/GLzsyGOvEq7f2pkWmt3KUVAEUyWcpVffzk3C9m472DdEZiwYdN?=
 =?us-ascii?Q?gQk9g/TppQzoG6c87T8QocJ+mgim/yWg/DYqvkt4j7YXK7f8K81+NU1W1jFi?=
 =?us-ascii?Q?p7+oX2HWsNA6gMGUJaxGqrYhc2iXUFOvnP6+ISp9cTypLjF9KfMjwFcCmQ1Q?=
 =?us-ascii?Q?lPE+I92zBwhLqKdWds2zIfSflBEBYPYQYbHUuwJUJv6PmtIN6RS5WHGbdYTL?=
 =?us-ascii?Q?N98+TvP8jxl7qGYL9IUa9ryUXHHALHjC4eXDGC5XLhOUoD8+68AagrzhFQiy?=
 =?us-ascii?Q?BUmeOWzDbjeAZWQvhLA61TH1pSlzWkMoRFrzlnhmhOoR1dnoTsma+gE/u0Fr?=
 =?us-ascii?Q?utvShW/mhtk2GNdGqQjiDhFG8DhhDTJF6ag56GF7fWQuez5D7AStc8Z62dVz?=
 =?us-ascii?Q?NriPEm+OMvcOYIYCpcrDWbGPGuOaxWfYdgqqeTgT6p/R2nPaMoY2PPAom+KB?=
 =?us-ascii?Q?tmgku2flYO0Q4odVpz2HWvQJmAzjoDMMxKQHjxYJAvUASAPTqzeyQgi+622s?=
 =?us-ascii?Q?xi3WvzNVlgtMAE2eUHnZVykwHrKIIdCWtbdl/A5uZmGbl4tG4QhJ+IAIMhJN?=
 =?us-ascii?Q?BWJS4oQybvnksL3uaI7JqVYOBYsRHfTULGlrdk6M8tOJUv8r76SxSvL1IuUM?=
 =?us-ascii?Q?/In0naLuwwtfj/B/P8teu+J75hfhpuTVb0f2pS9rqZWrAONB4s5495i6w6DE?=
 =?us-ascii?Q?Gg/UN18xhSja1j+ZFxS/M9eyvXC9E9+6p3jQ1PfxnswTfI3JropJwZTspZF+?=
 =?us-ascii?Q?fHNS5InFT46WU4VVq2fbm01Mqc+5qTKGKvhniodrnoNWAKgMeF8oHwZK+zZG?=
 =?us-ascii?Q?SsA9DGUVln0/2kTTNdsETOTiqCXZjXKTswYwYK0XOsP4E9PpTyJZzdGKu233?=
 =?us-ascii?Q?FH2fiw+VayGdUrRXkMALH4zv8AUcF6FLXSlYLz01Bxvf05nP980DP57N3owA?=
 =?us-ascii?Q?2qknjlneg9qdn09OwZDlCor1T/d4L/3O+6EeLPHF+qYzgB7y8OyyrtSUOOvk?=
 =?us-ascii?Q?sKCQcuGCDENAaVjxS6ljL3Tky4BG6/ZzkG7yvm4Q9BHVqO/exckKBu5J+jOr?=
 =?us-ascii?Q?PRKJYUj3pxgkZUPCna0Qpl+81okaZEOhYEvcM4kWBQn0f7DkHeetUFaOFE5g?=
 =?us-ascii?Q?LOnH5NqXmVH6QBPcTp7ARYGMfh9lHaLXFndLFgTNUC95Zi7Jfp17wyqk3SQ/?=
 =?us-ascii?Q?gP0eBHPdp+0H2hEHGTuHDrp9raEsbl/DmA6imxUxwMe4/EdexAebq2XfVanw?=
 =?us-ascii?Q?CeDDx6I1OKoZ+4gtWEWPwj9vBcOIKy8mbSjd+atCXWirYTa2CulNPaKuN64s?=
 =?us-ascii?Q?91wP483DXj5cK0zoSAU4lA5Q4rWUWhI+Xt/B053W9yEWPmoB4cEqzUG2SwMu?=
 =?us-ascii?Q?HlTLUd6dzLSsbCG1Dl9KNBXXK8J9Mpg5bMFgEn3SGRzl3gFVvdJQ08I6OU/O?=
 =?us-ascii?Q?I1EyK1pAU78Q/bx+VklYl4UV8hswwQWBsavlfcGX19Q8tJFFSX/kfNNBIdor?=
 =?us-ascii?Q?KRKqlYk1dqcjZ0QmPvivNPxpcugqXa+zRc74+guf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0124dc-25f4-4e6d-15ae-08dbde997ae0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 07:24:57.9181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GT8fT9PzQ0xzQpNjPhwPYfympQd8x6B/TvFtKzhJpqeQVWWgUw7R0aPMIcfpFa87EiAhMKiUAfcoJHrWPyel2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8762
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 02:59:24PM +0800, kernel test robot wrote:
> Hi Arnd,
> 
> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

Sorry Arnd for this false report, kindly ignore it as it is not
the initial cause of the warning.

> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d2f51b3516dade79269ff45eae2a7668ae711b25
> commit: a157802359f7451ed8046b2b6dbaca187797e062 media: sta2x11: remove VIRT_TO_BUS dependency
> date:   1 year, 4 months ago
> config: powerpc64-allyesconfig (https://download.01.org/0day-ci/archive/20231106/202311061401.8TDz7c7d-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311061401.8TDz7c7d-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311061401.8TDz7c7d-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/media/pci/sta2x11/sta2x11_vip.c:1053:6: warning: cast from 'irqreturn_t (*)(int, struct sta2x11_vip *)' (aka 'enum irqreturn (*)(int, struct sta2x11_vip *)') to 'irq_handler_t' (aka 'enum irqreturn (*)(int, void *)') converts to incompatible function type [-Wcast-function-type-strict]
>     1053 |                           (irq_handler_t) vip_irq,
>          |                           ^~~~~~~~~~~~~~~~~~~~~~~
>    1 warning generated.
> 
> 
> vim +1053 drivers/media/pci/sta2x11/sta2x11_vip.c
> 
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   936  
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   937  /**
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   938   * sta2x11_vip_init_one - init one instance of video device
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   939   * @pdev: PCI device
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   940   * @ent: (not used)
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   941   *
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   942   * allocate reset pins for DAC.
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   943   * Reset video DAC, this is done via reset line.
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   944   * allocate memory for managing device
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   945   * request interrupt
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   946   * map IO region
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   947   * register device
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   948   * find and initialize video DAC
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   949   *
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   950   * return value: 0, no error
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   951   *
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   952   * -ENOMEM, no memory
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   953   *
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   954   * -ENODEV, device could not be detected or registered
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   955   */
> 4c62e9764ab403 drivers/media/pci/sta2x11/sta2x11_vip.c Greg Kroah-Hartman 2012-12-21   956  static int sta2x11_vip_init_one(struct pci_dev *pdev,
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   957  				const struct pci_device_id *ent)
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   958  {
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   959  	int ret;
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   960  	struct sta2x11_vip *vip;
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   961  	struct vip_config *config;
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   962  
> 8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05   963  	/* Check if hardware support 26-bit DMA */
> 8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05   964  	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(26))) {
> 8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05   965  		dev_err(&pdev->dev, "26-bit DMA addressing not available\n");
> 8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05   966  		return -EINVAL;
> 8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05   967  	}
> 8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05   968  	/* Enable PCI */
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   969  	ret = pci_enable_device(pdev);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   970  	if (ret)
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   971  		return ret;
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   972  
> 8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05   973  	/* Get VIP platform data */
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   974  	config = dev_get_platdata(&pdev->dev);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   975  	if (!config) {
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   976  		dev_info(&pdev->dev, "VIP slot disabled\n");
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   977  		ret = -EINVAL;
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   978  		goto disable;
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   979  	}
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   980  
> 8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05   981  	/* Power configuration */
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   982  	ret = vip_gpio_reserve(&pdev->dev, config->pwr_pin, 0,
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   983  			       config->pwr_name);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   984  	if (ret)
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   985  		goto disable;
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   986  
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   987  	ret = vip_gpio_reserve(&pdev->dev, config->reset_pin, 0,
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   988  			       config->reset_name);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   989  	if (ret) {
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   990  		vip_gpio_release(&pdev->dev, config->pwr_pin,
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   991  				 config->pwr_name);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   992  		goto disable;
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   993  	}
> 0bade8b5439520 drivers/media/pci/sta2x11/sta2x11_vip.c Arvind Yadav       2018-04-27   994  
> 0bade8b5439520 drivers/media/pci/sta2x11/sta2x11_vip.c Arvind Yadav       2018-04-27   995  	if (gpio_is_valid(config->pwr_pin)) {
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   996  		/* Datasheet says 5ms between PWR and RST */
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   997  		usleep_range(5000, 25000);
> 0bade8b5439520 drivers/media/pci/sta2x11/sta2x11_vip.c Arvind Yadav       2018-04-27   998  		gpio_direction_output(config->pwr_pin, 1);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12   999  	}
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1000  
> 0bade8b5439520 drivers/media/pci/sta2x11/sta2x11_vip.c Arvind Yadav       2018-04-27  1001  	if (gpio_is_valid(config->reset_pin)) {
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1002  		/* Datasheet says 5ms between PWR and RST */
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1003  		usleep_range(5000, 25000);
> 0bade8b5439520 drivers/media/pci/sta2x11/sta2x11_vip.c Arvind Yadav       2018-04-27  1004  		gpio_direction_output(config->reset_pin, 1);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1005  	}
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1006  	usleep_range(5000, 25000);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1007  
> 8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1008  	/* Allocate a new VIP instance */
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1009  	vip = kzalloc(sizeof(struct sta2x11_vip), GFP_KERNEL);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1010  	if (!vip) {
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1011  		ret = -ENOMEM;
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1012  		goto release_gpios;
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1013  	}
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1014  	vip->pdev = pdev;
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1015  	vip->std = V4L2_STD_PAL;
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1016  	vip->format = formats_50[0];
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1017  	vip->config = config;
> cd63c0288fd760 drivers/media/pci/sta2x11/sta2x11_vip.c Ezequiel Garcia    2018-06-15  1018  	mutex_init(&vip->v4l_lock);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1019  
> 8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1020  	ret = sta2x11_vip_init_controls(vip);
> 8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1021  	if (ret)
> 8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1022  		goto free_mem;
> d017650b40b4cb drivers/media/pci/sta2x11/sta2x11_vip.c Wei Yongjun        2013-05-13  1023  	ret = v4l2_device_register(&pdev->dev, &vip->v4l2_dev);
> d017650b40b4cb drivers/media/pci/sta2x11/sta2x11_vip.c Wei Yongjun        2013-05-13  1024  	if (ret)
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1025  		goto free_mem;
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1026  
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1027  	dev_dbg(&pdev->dev, "BAR #0 at 0x%lx 0x%lx irq %d\n",
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1028  		(unsigned long)pci_resource_start(pdev, 0),
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1029  		(unsigned long)pci_resource_len(pdev, 0), pdev->irq);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1030  
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1031  	pci_set_master(pdev);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1032  
> 8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1033  	ret = pci_request_regions(pdev, KBUILD_MODNAME);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1034  	if (ret)
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1035  		goto unreg;
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1036  
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1037  	vip->iomem = pci_iomap(pdev, 0, 0x100);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1038  	if (!vip->iomem) {
> 8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1039  		ret = -ENOMEM;
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1040  		goto release;
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1041  	}
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1042  
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1043  	pci_enable_msi(pdev);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1044  
> 8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1045  	/* Initialize buffer */
> 8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1046  	ret = sta2x11_vip_init_buffer(vip);
> 8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1047  	if (ret)
> 8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1048  		goto unmap;
> 8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1049  
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1050  	spin_lock_init(&vip->slock);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1051  
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1052  	ret = request_irq(pdev->irq,
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12 @1053  			  (irq_handler_t) vip_irq,
> 8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1054  			  IRQF_SHARED, KBUILD_MODNAME, vip);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1055  	if (ret) {
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1056  		dev_err(&pdev->dev, "request_irq failed\n");
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1057  		ret = -ENODEV;
> 8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1058  		goto release_buf;
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1059  	}
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1060  
> 4db4ca7450f97c drivers/media/pci/sta2x11/sta2x11_vip.c Hans Verkuil       2015-03-09  1061  	/* Initialize and register video device */
> 4db4ca7450f97c drivers/media/pci/sta2x11/sta2x11_vip.c Hans Verkuil       2015-03-09  1062  	vip->video_dev = video_dev_template;
> 4db4ca7450f97c drivers/media/pci/sta2x11/sta2x11_vip.c Hans Verkuil       2015-03-09  1063  	vip->video_dev.v4l2_dev = &vip->v4l2_dev;
> 4db4ca7450f97c drivers/media/pci/sta2x11/sta2x11_vip.c Hans Verkuil       2015-03-09  1064  	vip->video_dev.queue = &vip->vb_vidq;
> cd63c0288fd760 drivers/media/pci/sta2x11/sta2x11_vip.c Ezequiel Garcia    2018-06-15  1065  	vip->video_dev.lock = &vip->v4l_lock;
> 4db4ca7450f97c drivers/media/pci/sta2x11/sta2x11_vip.c Hans Verkuil       2015-03-09  1066  	video_set_drvdata(&vip->video_dev, vip);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1067  
> 3e30a927af3ca8 drivers/media/pci/sta2x11/sta2x11_vip.c Hans Verkuil       2020-02-03  1068  	ret = video_register_device(&vip->video_dev, VFL_TYPE_VIDEO, -1);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1069  	if (ret)
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1070  		goto vrelease;
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1071  
> 8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1072  	/* Get ADV7180 subdevice */
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1073  	vip->adapter = i2c_get_adapter(vip->config->i2c_id);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1074  	if (!vip->adapter) {
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1075  		ret = -ENODEV;
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1076  		dev_err(&pdev->dev, "no I2C adapter found\n");
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1077  		goto vunreg;
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1078  	}
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1079  
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1080  	vip->decoder = v4l2_i2c_new_subdev(&vip->v4l2_dev, vip->adapter,
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1081  					   "adv7180", vip->config->i2c_addr,
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1082  					   NULL);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1083  	if (!vip->decoder) {
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1084  		ret = -ENODEV;
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1085  		dev_err(&pdev->dev, "no decoder found\n");
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1086  		goto vunreg;
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1087  	}
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1088  
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1089  	i2c_put_adapter(vip->adapter);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1090  	v4l2_subdev_call(vip->decoder, core, init, 0);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1091  
> 8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1092  	sta2x11_vip_init_register(vip);
> 8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1093  
> 8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1094  	dev_info(&pdev->dev, "STA2X11 Video Input Port (VIP) loaded\n");
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1095  	return 0;
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1096  
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1097  vunreg:
> 4db4ca7450f97c drivers/media/pci/sta2x11/sta2x11_vip.c Hans Verkuil       2015-03-09  1098  	video_set_drvdata(&vip->video_dev, NULL);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1099  vrelease:
> 11788d9b7e916f drivers/media/pci/sta2x11/sta2x11_vip.c Hans Verkuil       2020-07-13  1100  	vb2_video_unregister_device(&vip->video_dev);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1101  	free_irq(pdev->irq, vip);
> 8dc97ea20c2bdf drivers/media/pci/sta2x11/sta2x11_vip.c Federico Vaga      2013-02-05  1102  release_buf:
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1103  	pci_disable_msi(pdev);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1104  unmap:
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1105  	pci_iounmap(pdev, vip->iomem);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1106  release:
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1107  	pci_release_regions(pdev);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1108  unreg:
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1109  	v4l2_device_unregister(&vip->v4l2_dev);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1110  free_mem:
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1111  	kfree(vip);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1112  release_gpios:
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1113  	vip_gpio_release(&pdev->dev, config->reset_pin, config->reset_name);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1114  	vip_gpio_release(&pdev->dev, config->pwr_pin, config->pwr_name);
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1115  disable:
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1116  	/*
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1117  	 * do not call pci_disable_device on sta2x11 because it break all
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1118  	 * other Bus masters on this EP
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1119  	 */
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1120  	return ret;
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1121  }
> efeb98b4e2b2ce drivers/media/video/sta2x11_vip.c       Federico Vaga      2012-04-12  1122  
> 
> :::::: The code at line 1053 was first introduced by commit
> :::::: efeb98b4e2b2ce50e008affce4c493e58167144a [media] STA2X11 VIP: new V4L2 driver
> 
> :::::: TO: Federico Vaga <federico.vaga@gmail.com>
> :::::: CC: Mauro Carvalho Chehab <mchehab@redhat.com>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
