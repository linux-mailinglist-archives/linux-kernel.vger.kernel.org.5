Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8F37DC3F6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 02:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjJaBoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 21:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJaBoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 21:44:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47E4C6;
        Mon, 30 Oct 2023 18:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698716646; x=1730252646;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IIuVeGWprfq3VCuVfxahdPUFqQAabEMjDhoi4ZjKmo4=;
  b=YDFf3w2VAOAAYZYIgGgrHjhogztYUohyJgBdj1a8gMGUm80DK6/rxuV0
   YPc7FiM+tBrj3NGvmsKUKPjm4W1nH8lKxdZTJvE/sSf+PgAcqJAYPHww/
   oxdb+4ZwUjvn0zIO38bSzaKnF6+wLW17eM4Gq4jBIDHlE4clpzl0gKanq
   YpeK+yPkYkwgjFtQWrLAWFrtQY9iFUOXpOrkLz7jat54gy8gn6QIdR3Rh
   23x/oDfa/gSMkCCOAcpj5/238Qe0z3h3wvh7m3/L/qljeCqfdnnfsmChQ
   UBE9C7WGw3CD/UNWEgnO+ua3n0g1piAHni5eRmSzqEdzZ+ZfGmxbNDTE7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="392056336"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="392056336"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 18:44:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="877332168"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="877332168"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 18:44:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 18:43:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 18:43:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 18:43:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 18:43:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRUq9IVdbgI1tq278bGV3PdBaVJF1LouciAIHRn4cudbE8MrnrjfC9mlt+UTIRSg0su9hw4yhhn61i+K/k+UYq4xJF5pkyamP5x7RvBP/MF7YSsLZi1TEaoV2iM1FFm1fFv2KfsXmfGDs1yLJuO8na7e9Fc60vrrrrpYm+EyWROCqPGW2DU2+0D9DmsXCP0LH57xTjlZVgghr464ISE4Zzw/sDhnvMCw5PTqSGu6ep42Spqfmom/jL95ASttC3tROthtHsXXsJkD+Y642xnazuEkb51Tznw1a5MNwf8eejb/UZg9UrVWoesTFmFwEEnX0SLA+iKuAkfKN7nh9Zd5PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dz8nKEkl2xpXabxmIK+V4ghf9k7cHXugVHrp3EOoA04=;
 b=cYiloLZxQWFUSVF3qMqWsb4XIgMLFxzZIyktQcOr81NzXK0Zyb+KIewijJ/DAot1NHqxg6sy1ZqMNwDoMsEMmkWoh+7brghkRYO4dt50f3WqxVMftx6Yk0faq4jjq5P/0qBevzgacmpuD6PFHnIldx4tjOqUwV2fVnbWxI5+Q2lQKHaxju5+RpH+SPI4AhEH5GWSLxY0fnYdhz9fjpOBLmdZSAhwVNOYyT9kRnCmVRLCTUqkViMBbRUpH0PSnqP5/+chjUs1qK07XrhlEcKYJ2+URKkiaX7ugMtUw/oRf7RCqVoU2+mC6tVva8JBO9rRsnkI2M3xx7KRgTHTLw65TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 01:43:57 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.6933.028; Tue, 31 Oct 2023
 01:43:56 +0000
Date:   Tue, 31 Oct 2023 09:39:10 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        <linux-sh@vger.kernel.org>
Subject: Re: arch/sh/boot/compressed/misc.c:118:6: warning: no previous
 prototype for 'arch_ftrace_ops_list_func'
Message-ID: <ZUBavpdmbsMvbHrr@yujie-X299>
References: <202310310611.5RteDpO7-lkp@intel.com>
 <20231030183722.21712d18@gandalf.local.home>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231030183722.21712d18@gandalf.local.home>
X-ClientProxiedBy: KL1PR01CA0088.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::28) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|DS0PR11MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc9f114-e2c5-4105-de9f-08dbd9b2d857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jKNdOT6WjUNqhxZDtwp0/aVxnCEuyjH7GEbDW2TeYeNh99CXJDDWJ41ps+fD8SlCRvWAHce0UGjUqB/K2N6LNhFb8hnLfC53PvScRROoOs5fGoEJwUHGw9nEXNHLSC20Awk3VA7WMddZbGNvepGZAWm+MLOYWDL9RFwhuC5lr5WJu9G5bq6WuLPJQZBFaqwlQmhbknpkUvqSuIPnd9lPsGFvhubswLu6Zm2yylDnONtCrP3cgA1lt6m8LQefsP3dfIduryVlRhnqiu9dXMUyElW4Sm/33IqEHZCoNDV3hL6sJL3XCJDSrbPEj12dG0GuZXHYoXbEVvvDqA/zkrADT9cCRH98j0k2zJRSHRn73r5ro/pm4r10iWzaI3cPN7YDopbMOHsNJEo4YnQKrHtHHU58UZY1poWZFoxqOWzIYElcMHdXO0YzXOeWwmSpvDAiA3+Zesf7FVdVj7t8mfb1PI0RrKq49Dl2vvdK8vXkv6yvyqMffHL5R43Mbvbf/J3n3u4/jkCRv+DqxUMcWgw9bhxldSziEdh1xmSJqN+U9DZuJU6YSkmE7T5plW5WPeqd5/AjnhbJ4bjMNVR8jVdCARIZAtZHBOuWW/vbUqwutenYKBEEX8ElNHo3W48zHmZ5MqI+b/StdNsBFdZ4sMbkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(366004)(346002)(376002)(136003)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799009)(186009)(64100799003)(6512007)(9686003)(26005)(6506007)(478600001)(6666004)(83380400001)(2906002)(33716001)(44832011)(41300700001)(66946007)(66556008)(66476007)(966005)(6486002)(8936002)(8676002)(316002)(54906003)(6916009)(5660300002)(4326008)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YscuTze1MhexXMiJTZgKHMtN9Ww+RHucAoeGhD02+bkM2k3wYX4E2TlPTEhY?=
 =?us-ascii?Q?3qQHF5WaTM7GJN3gOYGMWBvG7VJVbo3Rvp1Ef70X7H23U12pZwkBSAOZrB6H?=
 =?us-ascii?Q?BYyiv5riMY6Zf0jKkx3Vdv1YLGiLMXGI31VKBog/vP3CoPa3Siu3N/Bn5T6q?=
 =?us-ascii?Q?epAxpYaITznYA/BYJkQ3d5l/D2brC8SvHzh6NBaiyIWw7XrtVB10u2nD4BUG?=
 =?us-ascii?Q?HvQo7CliwysFLYIGWi5hsUv0XiiOrYKWnPLPLTu6fT45jHxAlBorO8gfZVqK?=
 =?us-ascii?Q?cII3HSFWYAtkD13zKAmLbuFBdudasU3OYlOsuFh7XFszCH6VMiVcfu9hGl9E?=
 =?us-ascii?Q?Pa8MD2NUcFfZbEfGSebxFdw2l1PskOtzhZC8+3pfzkf8LI3xOTFCj96hFDT0?=
 =?us-ascii?Q?yP2u6zwBEYXBbAgEVCjb5UOc2lOBOKMqYbPQP+y+2BkcAJm0lp4++pfFp+BG?=
 =?us-ascii?Q?+5W/Cz7mywP/bBG1tNvjD42uZHXv9ACqOPwvskXsTNo29W8qkqjuR+5FC/vt?=
 =?us-ascii?Q?LPyOPJAuvSheVK5n/rGujPuBxZHcJg84z4XZiSSJBLcVhkHmiy2MMTGsYCH7?=
 =?us-ascii?Q?SfyHQHNIU773vBzjXdi+VBKGJnkFt0dVR8PFVUsx4vN5Kk8IpoIdZXn+VBAD?=
 =?us-ascii?Q?tL29iJy1u7nIpvDfhCHK1I5Z+T4X0j1Ov+kRXRqIXIsPTs1VPfv2gk7LW86p?=
 =?us-ascii?Q?zIoc4j8EbMMGAXLGtjCLPxRvhGha6v2fF0o0yia/GusfSEC8NnGa8Wrml7nS?=
 =?us-ascii?Q?/6L5+ibx/BcypAl8eNcGdPf1XEeSySAeOyVePgg8venE3UdpVdb/4zi0oAP2?=
 =?us-ascii?Q?XVQluLK5wmksA9Rmuam1kCkqVvwejcditQ2PYUXg7vytgzYsycKlK+OJZUaa?=
 =?us-ascii?Q?S0CGKhltrvvGk4N8HJELnnoYHRsHtOVgPyqZWlBjigC9s9rJJrfNntsmJT2Q?=
 =?us-ascii?Q?e2ZaTIov45iASXXrhMACQOen0xHkIEtgNJNn3/BshgZEdPZ7WT1ymmmQYO+Q?=
 =?us-ascii?Q?fdtBFONVVzg8CvfEnqDxZD4kDnmBXtgiTRBAQXMEShFjZGZ3mMn2FH0h7kXJ?=
 =?us-ascii?Q?eeoTNP9/OgBVE7av3jctuSXQQv+gw0qp/TxmUvKrR7PgvI+YGjhlrMfo5XIR?=
 =?us-ascii?Q?ONID3+z5tF10+b9liPB7Z8oTPcDf7qUPy6IbtvNhzmTqMv2aO27HvZ5O/Wme?=
 =?us-ascii?Q?VK1TFEA6rtVXLSK+B8LVEAO2LoP0lphfeOPaoz4RE1ta0FJBiNTOernlMs/8?=
 =?us-ascii?Q?TK56an5X/UbmEdphSMNz0z1Ys2a5n3pMMEhR2KD2ZkLSoucq5YISsq3iaLKa?=
 =?us-ascii?Q?hp9x9bD24o88NUR79F6N1FdMX/UNQhIgAsiBwpY21wx52lswxdQ5WYwgykE0?=
 =?us-ascii?Q?83CV/wzqm6ZC2mZJGEPKMqHtGJgnMbSx/kCAH/jdFvAIJxX9tVym2rFsCDtN?=
 =?us-ascii?Q?mnj32Hltk4IdjIB45L4kXtqqsnmTz7Dxa3IiZx1raFvgqTmWgHyC2ypVPfBI?=
 =?us-ascii?Q?cxXU6exI1XDW54Aip5aUyHg7NhE2y8vmj/gbFzia1TPqt9Lu0NzDcIpMh7dZ?=
 =?us-ascii?Q?BmPPDGrqZX/PeA69BWrIy9WhV4dO576upBERjtDg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc9f114-e2c5-4105-de9f-08dbd9b2d857
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 01:43:56.9130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6DAXn7bRjLa7YMljz9tQ3TOI1BukdIIYpbfag0L6VSJgwf8VnS0/1wK6YN65rPYXp8T9nK7y+sKdP5lUNNlUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8230
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 06:37:22PM -0400, Steven Rostedt wrote:
> On Tue, 31 Oct 2023 06:15:04 +0800
> kernel test robot <lkp@intel.com> wrote:
> 
> > Hi Steven,
> > 
> > FYI, the error/warning still remains.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   14ab6d425e80674b6a0145f05719b11e82e64824
> > commit: 17b251a290ba84a0c2c5c82df9596cb2e7207ca6 ftrace/sh: Add arch_ftrace_ops_list_func stub to have compressed image still link
> > date:   2 years ago
> > config: sh-allnoconfig (https://download.01.org/0day-ci/archive/20231031/202310310611.5RteDpO7-lkp@intel.com/config)
> > compiler: sh4-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231031/202310310611.5RteDpO7-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202310310611.5RteDpO7-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    arch/sh/boot/compressed/misc.c:109:6: warning: no previous prototype for '__stack_chk_fail' [-Wmissing-prototypes]
> >      109 | void __stack_chk_fail(void)
> >          |      ^~~~~~~~~~~~~~~~
> >    arch/sh/boot/compressed/misc.c:115:6: warning: no previous prototype for 'ftrace_stub' [-Wmissing-prototypes]
> >      115 | void ftrace_stub(void)
> >          |      ^~~~~~~~~~~
> > >> arch/sh/boot/compressed/misc.c:118:6: warning: no previous prototype for 'arch_ftrace_ops_list_func' [-Wmissing-prototypes]  
> >      118 | void arch_ftrace_ops_list_func(void)
> >          |      ^~~~~~~~~~~~~~~~~~~~~~~~~
> 
> As the comment states, this is needed only because the linker script
> vmlinux.lds.h references them, and it will not build without it.
> 
> If someone really cares, they could simply add a header to quiet these
> warnings, but seriously, these functions are just stubs to allow the sh
> boot portion use the vmlinux.lds.h linker script. These stubs are only for
> satisfying linker references and are not used. I'm not going to be the one
> to bother "fixing" it.

Thanks a lot for the details. We've configured the bot to ignore this on
the reported commit.

Best Regards,
Yujie

> 
> -- Steve
> 
> 
> >    arch/sh/boot/compressed/misc.c:128:6: warning: no previous prototype for 'decompress_kernel' [-Wmissing-prototypes]
> >      128 | void decompress_kernel(void)
> >          |      ^~~~~~~~~~~~~~~~~
> > 
> > 
> > vim +/arch_ftrace_ops_list_func +118 arch/sh/boot/compressed/misc.c
> > 
> >    113	
> >    114	/* Needed because vmlinux.lds.h references this */
> >    115	void ftrace_stub(void)
> >    116	{
> >    117	}
> >  > 118	void arch_ftrace_ops_list_func(void)  
> >    119	{
> >    120	}
> >    121	
> > 
> 
> 
