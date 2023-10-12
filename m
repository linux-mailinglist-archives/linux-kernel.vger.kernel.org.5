Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A85F7C62CE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjJLCfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbjJLCfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:35:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2CDB6;
        Wed, 11 Oct 2023 19:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697078142; x=1728614142;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zx8y1TkWogXooi/XNCd4qBmG3NrMZh/ueHAbZYcKnsI=;
  b=Sj89ekIJigLDPnb5SpZgZ3azDKxdqXG2/q8wV4tGPyuXHs4hi4Dpwn/D
   crd5y7xzQ3gqfap8LK/rbNfH3S5FgR2gha9WnGcX4a6rRx6mFxO7oc4vx
   O9uTHB3uPPAxc5qem9aVJsiKHrTap/31k9eywzcvLWLNy2Ukxs47n97mL
   GHAgc7qrBRpsRQvf7w7QdCc6798SLNCsXOkEIkEGWeawZtsxNCKWqHWpx
   PVxrSXBsNflsE1sl+/faoOD+6ZWCh79lfbXY4341VHCINxL9+1hHZP3sy
   nC6qaGC2Gt3Zbyc8rwYC/s4XhkvRR5Jy/Iuk0eolzmR32ey7nxwpNTJDT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="365089918"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="365089918"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 19:35:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="897901649"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="897901649"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 19:33:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 19:35:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 19:35:41 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 19:35:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9i6Lsn2xIeaGuivHWqA2G0GDWXoOfnRydsl/+dZU/u5IQv3fD/o8ziIEdkNPBdNdRRSKdVOioLwsCaMcfPdGG6gMOoTfaHmnhYH1m9oSPxhd4othPQ1WJMXK6zM7MO232n/dzPronVPjLbCzW+EW1iN1ZgahrjDBxyk/AbQn9+WkZGxgMM1E31pbod4DzvDiXgPYDdk4R5YnpXaWdKwumz+qG0757l+oNU/Pcek0hse7roCWpSSA7DZ69j75Ss0YGN8dieEC9CV/vnCe5Sta57lt4GmW3iKiSGd0jMVMbreY+/1/MMepzmYiotJxhhT2ASbIoN+YhoLCMEuI8g+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBQc6FNv2YR9zsQBriVapTVstT4DBHIwF8NCwGlSdYU=;
 b=OPF0XqwIp2IUMphr7Az4rdNRGG+1zWIhly/o6XteY6Rxo4mCPJF9w6gMdwjE5RS6EMomIIYPwiYUV540r56+X6R3X7ELutqan1utUaGnfL4u0LdSDLzwyAmKPCrZrAQ6abf7fbKA3oTSun8/UW1qgiojXAUCQ4zfNQ8T17ZldfywlMqDLluMJNCkSOGBp9SDZtKC+F85/EtHPbVrm5Hvpob6wHuJnFR+T+10q/HA4zdUXm4HTaV7C2EhC81CFCERvrEN8YW2vpm2kQDUPEWLhxI/LwzuZvXF3CPMVlbaZGUoNm8TJgaKJq4TzXzCi2xe9lonMoL+Yno/gUuktK8r1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by SA1PR11MB7085.namprd11.prod.outlook.com (2603:10b6:806:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 02:35:39 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::f64:17c0:d3ab:196]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::f64:17c0:d3ab:196%6]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 02:35:39 +0000
Date:   Thu, 12 Oct 2023 10:35:26 +0800
From:   Philip Li <philip.li@intel.com>
To:     Feng Tang <feng.tang@intel.com>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>,
        "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v9 2/3] x86/mce: Add per-bank CMCI storm mitigation
Message-ID: <ZSdbbr7g6SmHhnmd@rli9-mobl>
References: <20231004183623.17067-3-tony.luck@intel.com>
 <202310111637.dee70328-oliver.sang@intel.com>
 <SJ1PR11MB6083D191286779302821A7EAFCCCA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZSbCYt35j20ezT98@feng-clx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZSbCYt35j20ezT98@feng-clx>
X-ClientProxiedBy: SG2PR04CA0164.apcprd04.prod.outlook.com (2603:1096:4::26)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|SA1PR11MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: 800342b1-11d1-413c-93e9-08dbcacbebfb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FzSX64jTTqV9RhJrK606mccnFYHlMd3W5SHh/9kLTVaVgJsvjy+yyJ6XY+oovoyH16wEEBE1pTCxkadNIqnGJO1a6s76MUrzRP4DlvpUobEQdEXaUp7rXN7cdRKthI7POa//nAdJW3uk4lFab2FvEOu5sArigxpDKBL1xsDFm3Jkc4MCFjwww+5cg3zbRIMW5gZi+BL/Z9jXvRL98/Y7+sMeczgR1FNsM93QboWJ/eAXlkMRJIk1TvRvyu3JVC4GQ2r/fqLJ4wIY1MqhVqbkOjxR+lZ2uTBqBSYOwV8MjixIxeH1kt6rNR7yjC/WauZ6SHE2GXajF/YBWiOufMV09hZJhkstDRpF6asOZ4W6DqOof40xWGkJY44gNfqFtg5iB1LSno+t2WTJvNyB9HWUEhvu9YenETcOKPNi/Dn1f93MtcU6gvIpYJUW9KD6ffVZBy8oA9mTcNWxKk+E3Ia6dsh3+Am/gmKw8H42FWVr3BHjUyA+yMn58c70569YYFzoofSIjpaQxOszwFjg1OLeCK5ro66k9cxCxsRnJ85ast2QSinvSsnS8yIImCTubCbTo6vDoxhuFGJYVKGhZ5GGPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(39860400002)(346002)(366004)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(26005)(6636002)(66946007)(66556008)(66476007)(54906003)(83380400001)(316002)(44832011)(5660300002)(478600001)(86362001)(6506007)(6666004)(6862004)(8676002)(8936002)(4326008)(82960400001)(966005)(6486002)(15650500001)(2906002)(38100700002)(9686003)(6512007)(41300700001)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4y8tkKPydDaJV0boUT/bP6r6EVFVnS1uzbwi2USlQUFUMAL7yfz2rc/mTSPc?=
 =?us-ascii?Q?3+ge6VPmEHyC/IdTN3aKt5NG8jjwjytZkHRfO2m9+qaNEJnITG0tKZrdsWfz?=
 =?us-ascii?Q?GnxgMHhfTmWfXeTsVjD3GatFiZhxN92q1lRW+DrI29YX8ouWRh3LNFOk0Stq?=
 =?us-ascii?Q?MNyDwkXXLS44RnpJkXuFBiThoDu39axTcuOzB07xA3UDEsEEcUpGVgxE5npj?=
 =?us-ascii?Q?FeB+G/WgI3Nya14KOIbw5vPCunLbnIizVx4/iDcePtBmt98kB+Hor5D4LzNh?=
 =?us-ascii?Q?GubgDq0yE4qnuER+O9Vaq9YWEZmY84Dks6AMbF9byCh8/GhZ5JTVqcPoDkxb?=
 =?us-ascii?Q?e49NfLx7m7aS0dYKZClE2BQuW9qJWdZkBNHPicX8ApHG+oxnHoPrW/ywD/N6?=
 =?us-ascii?Q?Cb5yJMHOioMZDrm8rmINp8Glki5ACNodOmVI4OL2vR8wYLtLI0pNKPSbPWn8?=
 =?us-ascii?Q?/gXz8rjDdoGv5T1YOjtznZtMMHKkQpJh8YehRHE6S1JhmDNlFBSy2whNfZ11?=
 =?us-ascii?Q?OkGJefPbgp7xJlye2nyLtYehV1QkXzb/Eod4gatEXkWln/9jDS1qpaHaUlSs?=
 =?us-ascii?Q?eqQdk/nTbtBIvx7meipDtZ0zkVRO55mLA19OBP5FPK8a+5SdbScgyttS5GuK?=
 =?us-ascii?Q?GJquaNnJ/oZ/OwRoqKILcBewgr6y+S8Mf8KtdTsHqFro5E3w1jzqEfEi6gKO?=
 =?us-ascii?Q?thS8a+BRTg4VQf7pcMr18eGYOEvGi/9e8QRXromo3qKNcaRoyePb06fquGMO?=
 =?us-ascii?Q?kXSj1SAYJdSxCkxXFDYNE3cEHgkDfJKGjRZoc68Lj62w3hwUk+gAQaIHS13H?=
 =?us-ascii?Q?PIDxXc3wMhJNOMtPYuHyHZ4zDj6WmU5rZE/F9a2BEDnMM7zn8XFFA/iBCkLl?=
 =?us-ascii?Q?vHHr/Ss0FUd9RDreTpR4pkut20R193iGP2xB0uGpEomjOoSH45XJXgALgCtO?=
 =?us-ascii?Q?/dsRwJMiQJinr8fpzwHhlUgTjhGr34du9abnmTl+dYcq4bHb5QecKFE2iBqj?=
 =?us-ascii?Q?y3peJUL982fKc69IkcElLBmdsDS6ILf3tSDSmkLdoTF8qSVc6J4iG+msWhwc?=
 =?us-ascii?Q?I5HLTJu5ac7TFSJCyBIZkxRfrnJOsP4S1wDDn10vphKPnPcru3tuc1yRL9QY?=
 =?us-ascii?Q?2mXfqu3fRrKJPxsJR98kmEZwu1M+a95k8/AB35EAvRA7CfSTPaQ4VB/G0xZw?=
 =?us-ascii?Q?3ioRmoUd79spmxVYqjGkv6gYS2RV1DzxkBUxu/qbSSPhElneapWiy/rsIo8K?=
 =?us-ascii?Q?OAqDAAibxwiIzjqAjVREMwU5BtM2b2Oko7YUHXgGWYcOYFiqNxuO8Nz4oxi7?=
 =?us-ascii?Q?VziUoMzrj1OKS1VzJ6cVqw4e9+gITGoCttFbeb823M/Hz3jnH6TniXzSQhuK?=
 =?us-ascii?Q?ZLAQOSThjxFTKl9+e1OQpAvyjo+vh5TCaf4hXfnefaVN5w1wRmy/m1Z5qnB/?=
 =?us-ascii?Q?ku/ZkGHmh2jXPUOpC9epxJQUEVaJE/X55gcDJK/RbdDQz6mBBsuSiw1tqRRs?=
 =?us-ascii?Q?yaYVReACMZdkjSONZ/ZmTQAHZc57ntQdhroGQwnRbxHC5lz2ySweojLKdLpP?=
 =?us-ascii?Q?rhn2HrZ9A4huXP98RXz6AzSiunhXGnoRnOT5eUTT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 800342b1-11d1-413c-93e9-08dbcacbebfb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 02:35:39.4158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/earqLsbsfbiaO1GpDNFl/GoTMlvt5g2WDL8PPi4cfaa4jwNO2SkDy/hCKRLRIncM06BDoRwGfVZHCjne0LSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7085
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

On Wed, Oct 11, 2023 at 11:42:26PM +0800, Feng Tang wrote:
> On Wed, Oct 11, 2023 at 11:16:46PM +0800, Luck, Tony wrote:
> > > kernel test robot noticed a -8.8% regression of stress-ng.clock.ops_per_sec on:
> > >
> > >
> > > commit: 26bff7b04b829cccc6a97726d6398391a62e34ef ("[PATCH v9 2/3] x86/mce: Add per-bank CMCI storm mitigation")
> > > url: https://github.com/intel-lab-lkp/linux/commits/Tony-Luck/x86-mce-Remove-old-CMCI-storm-mitigation-code/20231005-024047
> > > patch link: https://lore.kernel.org/all/20231004183623.17067-3-tony.luck@intel.com/
> > > patch subject: [PATCH v9 2/3] x86/mce: Add per-bank CMCI storm mitigation
> > >
> > > testcase: stress-ng
> > > test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> > > parameters:
> > >
> > >       nr_threads: 10%
> > >       disk: 1HDD
> > >       testtime: 60s
> > >       fs: ext4
> > >       class: os
> > >       test: clock
> > >       cpufreq_governor: performance
> > >
> > >
> > >
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > | Closes: https://lore.kernel.org/oe-lkp/202310111637.dee70328-oliver.sang@intel.com
> > 
> > Is the test injecting massive numbers of corrected memory errors? The code in this patch
> > is only executed when handling CMCI interrupts, or polling machine check banks (at most
> > once per second).
> > 
> > I'm guessing this report is just because alignment of some hot path code changed.
> 
> IIRC, CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B was enabled in 0Day's
> kernel config for quite a while, to force each funtion's start
> address aligned on 64 bytes. Don't know if this has been changed
> recently.

yes, the kernel is always built with -falign-functions=64 to test
performance now.

> 
> Also I noticed the patch introduce a new per-cpu variable 'storm_desc",
> if the function address is 64B aligned, then per-cpu data alignment
> may be related.
> 
> Thanks,
> Feng
> 
> > 
> > -Tony
> 
