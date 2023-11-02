Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1497DF0BE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 11:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346832AbjKBK6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 06:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346098AbjKBK6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 06:58:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83146DE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 03:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698922723; x=1730458723;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sjFQDrmlxzzcgmIPT6ZY3hOo2s33DZ2FnKPJSro8K1Q=;
  b=VssHmupEb8jhnMBbJ7Y/dX1BdIxmlp306oXyqSxI/Wd9+c/c1ES+SuNR
   7PtRCHza/i0hqoLOb9+sxvukOkqS3McbML1NDj4WIwP0X7PykjClIKT8u
   UQ0V2Vy4wSTglGvsh2QY9iIoA+Y7AOpA9Q0YbJjERYWsV0CtvuxK6smXG
   9CxKpLPhicK9XITZsbbtVPmfquDjluRbL0iWq4R/yWFMbgTGscpaoPvAF
   ZhftRZIx3aYnRsK7o1WMgwsuPSmwo+cmFUdpPAbiBrS6hPiTnYlOl51kz
   vJqKiIPAraMwZe70b/j8V3ah0aAYEB+z+lpZkUb6H2Ew+ahFcHontCs27
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452989189"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="452989189"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 03:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="764876301"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="764876301"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 03:58:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 03:58:42 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 03:58:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 03:58:41 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 03:58:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUAPCgv1G63hbF49uorh47XyGOGOT8sfecnulRqJq77VFAxQ1JiAd9ZvIC8BwXqk9PIGzjPXphuyw0GosnXRmXcUQl1Ng7RxadjeWm98fgPAM+wWpDV5qFZpXUmr3H20F7m/PYY6c5sF8HNdLl5OKSozE+pLC6JEVy40OBfkwasczfBSQxw66S+79PqggYV3c+/bzXq8ljA7TG5MsKl7A+WBghvp/sC/o0cx47Zs1iE51doJmtA+EUnTkKz8UXgr6RaiM118TTVS/pkWYn0AQ8NzgYIlFSScXMgCmTgH44DTN2yNiJmuPFr3UcuZeENcV+BERN/w20wh2G8POLM5fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAk+dHo6I9nWH+fX63S5ZWteYbNV9JPhMe8fQp5XXko=;
 b=Rvob8oLFDdTNu3v17FEAaCHNnM50jMNjTbJiwG7ZS3HnfllAPQ1OuEdqZhb6Qn6AWPS83HhVDkPuGwKYBSny3GEIqY0uRHGHUFVgN2FFjj+AYmjvGaQbv9eRpTvfX3ojJcQE4DyR7yf3rxAqEJJt00BRdmgYoEPhtKdUwazo8M1vX3O+1c4VooiFvwyp4aaMpmMn/iBA3kA3nedP0x38uCEW1y6kyWqx/KYRDxvhyNFtr8Pcno+xLaUMcSY0LrmNlk7vjIIhNfrcCAPdCraRGpEfCUDkx+qADviO3TL1XsMeKk7Kjib5HNWLBOpLNxk8UoQOxrbVE8rZ+XXdmW6vrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by IA1PR11MB7755.namprd11.prod.outlook.com (2603:10b6:208:420::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 10:58:39 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67%4]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 10:58:39 +0000
Date:   Thu, 2 Nov 2023 18:58:30 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
CC:     Yosry Ahmed <yosryahmed@google.com>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Hao Luo <haoluo@google.com>
Subject: Re: kernel/cgroup/rstat.c:166:22: warning: no previous declaration
 for 'bpf_rstat_flush'
Message-ID: <ZUOA1khPp/G67uNG@rli9-mobl>
References: <202311021859.z3HikNTw-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202311021859.z3HikNTw-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|IA1PR11MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: 9342baed-9bd9-4d23-4b1f-08dbdb92aafa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ASZl/OQNH3qOQTIFXNboIAdLOSXZgWiufrIijydsvgjobAsIwVVgroKrxGugl0eBNb54boyoRYkCwKd7ehNie2qUF36pqIJo6BmMScbWg/KY6QXEXzKkjb/qyYkMD7A1b6ueZUKUUZdJ69rU1ju7Fz1LZJy4YCuvUs1VDoY57EkSc/TZOAazzZs4OukrXnjVah4f6BXL3hM3LS+TlKUAao0/tNT0PU8f+iCpKgizei0rWCPz/1OpmO3OOvmNoMehGXQwztNKhxEd2kgoLBvPB213yfET6I/AOd3jW1CA03Z9n/yir6KpRkPh04M+qzPvVAunDNMKxX/LwgXYM6OAyAxXmO8jb8HBdYSVI3PSEx9cVHqXebcPuph+8+1MJScph0QPWxPK1g4saqEA1w1n3LsCKq3CNyrh4OJ50DY0j2AecBHEci2FQLlN+hVYDNs6gu4AWetZdu+cs1p3S/kMWArhohPIsjxKr58zyi/Cr3IkMcQ1gYZVkGcHH2IXGxOHxraViEOmGzReulchp5PwPVV6Ia7g+8PBkfLoV0uE9EzU7EWEdpPSLx2OpSUEG0pZ4/ZF0J9Xd2KrPImp1ZrwdYarqOm2RFaAqCziul132yhEqaPeuw2zfz5ccvTmP/ASYeJDXX0R+oAV+LulVKRZAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(366004)(39860400002)(136003)(346002)(230173577357003)(230922051799003)(230273577357003)(64100799003)(186009)(451199024)(1800799009)(83380400001)(26005)(38100700002)(66476007)(66556008)(54906003)(66946007)(5660300002)(6636002)(8936002)(4326008)(6862004)(8676002)(44832011)(41300700001)(316002)(6666004)(6506007)(6512007)(9686003)(966005)(6486002)(2906002)(478600001)(33716001)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F5h6ZeNa533bTjUvfGajvyFPvzOsxuTUGKQW5w5d/lXUHmSQE2XJBauS9mJ2?=
 =?us-ascii?Q?Zq/hx9dcsiT71gueGUhW9UbeAmPgzHhhcUx3Ylk3xl+RkrKpC/vCG9l8vxXl?=
 =?us-ascii?Q?zKP7jDDDqcAqwra2/IfuvhI0ebWeimnH+V3+O5gsgYBbxQ5DzDiVmSIKIRQ3?=
 =?us-ascii?Q?81ru27XOZhpxOvEDUi6ovEVKXa4RwtnyNQausWpk7YeehMLgE9yYQ2UXSi42?=
 =?us-ascii?Q?ySuDtJvGBjQElXZp6Zqx5t2TKDgfxD39tAisJT2gRt4+C0QaMQBkvqsXTQ7r?=
 =?us-ascii?Q?/hofV7RDGXylISoOvCc43hMHlwon5Rz2l4msMAv5kDj3XOMWt2InCJSd3cfj?=
 =?us-ascii?Q?2wGKMoNNOryv4o6op8na4yLOctfkmUeNRlFEYdKKNIzq/T1nB1PB9k8pdlIJ?=
 =?us-ascii?Q?cItux0yS1m5Qr9SZrGDJSDszqpX0CKoUVdEOiLIDQmRu+6xqoIN+1n6Iqs+Y?=
 =?us-ascii?Q?7ARA4eZNsHfNCe1hS/Kdq7w8rMwWE1cSi4vwgsLjkj/PMLST8mI4LZHrReLY?=
 =?us-ascii?Q?BHiplhlv2LF8ESd0RwGnVzZ+WNAVzj9bauK465/1vFVv6DkLaW2EL5+3MxE1?=
 =?us-ascii?Q?nr0U/TSbI9BBw/lWPaZD0HbGS1AUhIR5BP4+yZZ8JdlqPSx2S4DESSQXEQb7?=
 =?us-ascii?Q?Ba+F2TlLRzlWpj5CC8yKRz3e4Kt6nGfXjCPjEayyb0Nb7a3m5UsO+z7EcRPF?=
 =?us-ascii?Q?ilU2tLT0wmN7meeN7Z3b3uu9/8LiiIYCIhZ4KKhyJNGS56X8wEGY58DSMed4?=
 =?us-ascii?Q?qjQhawz4m7CWUWn+QsF2cJdpRbV9+qV0+lI6wjFoNSfD0H0UUIElfEcpfS4P?=
 =?us-ascii?Q?XQWb0CgE3Plwam2BbVEzmQSd//pIQ5a5wSRuDI+hqx8IW8QlfsfPshZvxGrc?=
 =?us-ascii?Q?hLgOXpnk5l9PzStw+t8hsq5b0hC+osQ3II2ROW1JdIn+Qn9YUTN/STJkRtWZ?=
 =?us-ascii?Q?lNCewDZS6JC/rSBljROlLu9myEuRX+Tb4O8uA/Gpwq9lzek6EzYdCtLulsOT?=
 =?us-ascii?Q?ZV9kt8wMvc0Ta+Md9J7GY4Jvv4pPf5aRUZ3ob8cgsgCYeGvek1wYRPG4UJVE?=
 =?us-ascii?Q?Pvf72bbkXFeu5DLoZMiAtkNSeH3YqVqkC689f0dLdk7iZE12fjSJ1V1Llx0M?=
 =?us-ascii?Q?FW3E9MNPtmsUQPWgpqSYbaYyOXb1xDy+5rWRupTLPTozrbwn87TwoNj4ojIk?=
 =?us-ascii?Q?SpFzC2aJOoP33odlHkCRxrOu18u32d43SmdgDjE830lil7yiXbPPKlajNx0Q?=
 =?us-ascii?Q?/qDBy2K/rpEw3bZdHyuBCBtzoWgjqhdHAnZa00KjRyzLPk8UZXedq4UAIfH4?=
 =?us-ascii?Q?ibexn7tm8X2Vbayndupje0yafLZMUKgBAC76tEmtZpPrUJ2O39k4oH0YSH/T?=
 =?us-ascii?Q?0rzlZJEnwQAnCzZ4Nxv0ruUE++5SlhDbSSx1Q1kT86zwQgDXdF910hQUCRe1?=
 =?us-ascii?Q?iTFiiZPxNkf+ZIpR7C1O8g4JPp9/bCHenYuzIkXstRE4KI5NITygiq4MdAbV?=
 =?us-ascii?Q?wfiz8Wq6NvJnyPAEM/aXHuEeHFS0rXuTRPXqPB/91lOiIAD9v/EW/U+dfjRK?=
 =?us-ascii?Q?ecUXMEb1ABfu/MprsbmUpPxNvyaYKhA7DJE214rB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9342baed-9bd9-4d23-4b1f-08dbdb92aafa
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 10:58:38.6570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gmLPriepOh/uQx0hL6uWw42UHBnri7giZgLc/lbshVtqinVuTXoyPmkQ53ZcxWi+kkKwuDApuIhID8Cr3j5+Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7755
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 06:13:13PM +0800, kernel test robot wrote:
> Hi Yosry,

Sorry for the false report, kindly ignore this one. We will resolve the
problem shortly.

> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   21e80f3841c01aeaf32d7aee7bbc87b3db1aa0c6
> commit: a319185be9f5ad13c2a296d448ac52ffe45d194c cgroup: bpf: enable bpf programs to integrate with rstat
> date:   1 year, 2 months ago
> config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20231102/202311021859.z3HikNTw-lkp@intel.com/config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231102/202311021859.z3HikNTw-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311021859.z3HikNTw-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> kernel/cgroup/rstat.c:166:22: warning: no previous declaration for 'bpf_rstat_flush' [-Wmissing-declarations]
>     __weak noinline void bpf_rstat_flush(struct cgroup *cgrp,
>                          ^~~~~~~~~~~~~~~
> 
> 
> vim +/bpf_rstat_flush +166 kernel/cgroup/rstat.c
> 
>    147	
>    148	/*
>    149	 * A hook for bpf stat collectors to attach to and flush their stats.
>    150	 * Together with providing bpf kfuncs for cgroup_rstat_updated() and
>    151	 * cgroup_rstat_flush(), this enables a complete workflow where bpf progs that
>    152	 * collect cgroup stats can integrate with rstat for efficient flushing.
>    153	 *
>    154	 * A static noinline declaration here could cause the compiler to optimize away
>    155	 * the function. A global noinline declaration will keep the definition, but may
>    156	 * optimize away the callsite. Therefore, __weak is needed to ensure that the
>    157	 * call is still emitted, by telling the compiler that we don't know what the
>    158	 * function might eventually be.
>    159	 *
>    160	 * __diag_* below are needed to dismiss the missing prototype warning.
>    161	 */
>    162	__diag_push();
>    163	__diag_ignore_all("-Wmissing-prototypes",
>    164			  "kfuncs which will be used in BPF programs");
>    165	
>  > 166	__weak noinline void bpf_rstat_flush(struct cgroup *cgrp,
>    167					     struct cgroup *parent, int cpu)
>    168	{
>    169	}
>    170	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
