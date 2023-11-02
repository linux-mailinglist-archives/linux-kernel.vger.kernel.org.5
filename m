Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0257DEF8C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 11:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346100AbjKBKK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 06:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345606AbjKBKKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 06:10:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56CD136
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 03:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698919846; x=1730455846;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mWZF2PaCvovjtWnGJC2a3VakdkfjcqDq6VN+TErQpB4=;
  b=KOqHmhdT7iD1ur5ivg7TWeOazE2DH38h442yYcW9nbC85AbXsJJ67Vow
   fIZEq7+HRBHOjlCBkxD94lS0sw8osqq5JQM1EjGWVE0R6O7UfM3Pibhb4
   ECaB0cXuM0zKa/jXn2FRW6iYbbmh2BStsSDp0KcW5IOwSYodT1NmlNrV0
   2p138xbAKgA6jZklZ/G/rpf0h0HvWV6I5m41ZzqKZYmo9M2Ir6WIrbtag
   4Ob933DJkaLT+WgnFSrjYg/IR7gp4AN77k0hPNeGrGMTbH5aoIEj42enz
   7GezDAbKhwm+gP73NIvxhdnejnIia4eQl0Vmb+rCdcszBqrE/t1N7WhuB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="1550037"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="1550037"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 03:10:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="737707668"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="737707668"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2023 03:10:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 03:10:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 03:10:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 2 Nov 2023 03:10:45 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 2 Nov 2023 03:10:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TF6ICEH5gO9AQVEgTj3UofgEUMbUxXblSJMSPzPLzkE1AfEMNlcVD18PTV1Oi9k9lTkipp1S4aTesufRFy+Aphw83wlPHtwO9Qdy7jKq49ftbXWjcW3b9an8NTbs1PC4GTGUH437SY6O8kj8wxxJmRSgv1OuEe8En83/A+pVukjLDehYjt28kelmFYAG0zuTqtHZo+K1FKjwz7MPYqCTIS1qlouWvl80L4DBdocda8efVEdQtf2QAu+Nw2wlyDb53lqi4UCO08oVfDH3UTn0AD4B6fKudnkbMiLR85ADgqJq8QJqQABfYx5ciKrpE9VvsoFRXdNiZldsJExCap52bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejsO25kmyukPtVV0gwbdGQ1b6xdAtiFwc8ippsgWe9w=;
 b=hI7dva6OJiwk0dcBnCJIv2jpKL3RBLGNDPRIIHZQMRukoITQ1w/OHGllOvn+FwppREUKajjqoHO3xh2MilV90Qp+w28RpJPhSZ2Mn3iQUI6Sbvsorzy3i5RXSP4Ks+IFNYiV7TeiZrBtR5WqUQCKnnka+7HHgPVFSWNp6fKCNIhNvmsMTZjiIVIOytwFpI5SBEkCm72nTDHSB7PmoGypvNmqu9iDOlYRuIeEyv4MLQ861hLQXG33hFBQtqvIPXJtFe0BCww7BNYb7PPkmzFGgedbrG/TOQZdBdlJNnLGZFKM362XAAHX1EmfQyTh1qsnGz1o/XgFLoqTt0JW3MkYJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by SA1PR11MB6758.namprd11.prod.outlook.com (2603:10b6:806:25d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Thu, 2 Nov
 2023 10:10:31 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::2f1a:e62e:9fff:ae67%4]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 10:10:31 +0000
Date:   Thu, 2 Nov 2023 18:10:21 +0800
From:   Philip Li <philip.li@intel.com>
To:     kernel test robot <lkp@intel.com>
CC:     Daan De Meyer <daan.j.demeyer@gmail.com>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: net/core/filter.c:11773:17: warning: no previous declaration for
 'bpf_sock_addr_set_sun_path'
Message-ID: <ZUN1je8hduANA0KQ@rli9-mobl>
References: <202311021257.nD9pHYSn-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202311021257.nD9pHYSn-lkp@intel.com>
X-ClientProxiedBy: SG2PR04CA0159.apcprd04.prod.outlook.com (2603:1096:4::21)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|SA1PR11MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: dbda67e4-f9ae-47fa-4d6d-08dbdb8bf187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: onwzO0lz5IasP/8AMpran6ECPqdXrQ2anMsxGnlxyJBda5AmymQIY2mJacTrgojHh0/IXfrZiIZxDeesu94alLSkKs55hCtBUJE7nvf+JZTxcBIpV/EedwLHI38KGbGfHgscbVAYR0MwLl7GdrbrFOBXUV7HqurTRRA8zlkg1D4SDJgUSjploYhGAHzsebxKTQ4u8PjV3Jw6vIc6K7xZQ4zGdDFTaTe450aKUkYFWR+ndL3gxyeCAt0uHSdrH4MZT+b7iV+SFZJzCtV0GHR168HAb/jE1rpa7MgkwAFTrimLzsIQ/VLzCYv7dNHRI6CcRoKCzPqVGtgOFNf+Mvykb3wr7jS9Evpfku488vfkrjogYOyXEdnFKzmOvMZss5KQ3uWkcER8qB0sMSkcR0suZhcFqDiipVGKGCLEdBv0iiv0ZZf6h512z8CIPnNlugkCrAfJ1dOKUInSUAq/lupriwqGc7Gxq/oWYs70UVeG/G86Wucdiha2HnUi0gV+sXm5a64LLydYyTsbTfKbRh1J5T8XfAMJBQ8MyLBGqarkJ+bi/OSxoIp3QMI5FKQV+Gm/B//856fv8AskO2wfy4XKLPlc1aLS7Lss/fzMRbhx+pfhwGW2tlPteHNasYa1al5+KOSl0RNt/LNsoNOqiOtp2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(1800799009)(186009)(6862004)(6512007)(26005)(9686003)(8936002)(83380400001)(6666004)(4326008)(478600001)(6506007)(66476007)(66946007)(44832011)(41300700001)(33716001)(66556008)(5660300002)(316002)(966005)(8676002)(6636002)(54906003)(38100700002)(82960400001)(86362001)(6486002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IVR9bSpygXByxwFYIoqn7iq39ei3aVYfvK3MI9xDJZZ3ETw8FAd77/ynEejM?=
 =?us-ascii?Q?OCyK+3fWKovCVvJJAzMNqgPNl9YTWRMXmAuDO3aud8j2vGDE1zPdfoSRVnhn?=
 =?us-ascii?Q?8vrVNz9CBiCoLkapt/XDKLQ9LcNu177HfnMoz35svTVqbcPxvlBPqJoz++i2?=
 =?us-ascii?Q?9lGNSCsoIwwk0c2T9Yp9NQWwK7Ba464dILbHXvhBjvt/VhAs1Qtxbuc7XzCd?=
 =?us-ascii?Q?RQUwJdhUsRRkN+JNwuZ0Zl9JKA9t2PpCqmUzDMFSy2BPCZUGiUCI4stOwQW2?=
 =?us-ascii?Q?DfitWt9XccESXV1xoD2EuVZst12wfGy9Jviz8C2bKbSIzhkL64y3mVLk8gIL?=
 =?us-ascii?Q?xMTKutQQKFeklKMbLBZ+xmPca8ctqyBb7cOsMXlXWqePRxXCCAnayICZM7g+?=
 =?us-ascii?Q?BzT0a7/eiSHo8d4dUGGq2XPnqwtDj/5uul7MJ12ZhZmkCPPDJCp23cMtiarD?=
 =?us-ascii?Q?xwGp+tp0AK43qo2Ldv2hRiblgfLctXnx9ybvT671Yr+Xd4NC/puW+uGWIyKl?=
 =?us-ascii?Q?a37ybW8NFovLogOV1V1eCOrtYnuMO916y7h8gZfp9UaIuYNKNbWm06GuMo/3?=
 =?us-ascii?Q?dzAuRHXp3AMWGofw+xk5aeQBQAkdVkoWooyvN3UNmfKvJLi/0IOZi2es6njY?=
 =?us-ascii?Q?qRH7JNvaUQds7wnpeMGINpFXUDeAjEjwalypZ76AQhdA+kkCl0T2zgK/LpaV?=
 =?us-ascii?Q?dADl16T+2lMaAXZ48/QvpbG3DqhQMKqr7p0Pklf/icuOp7bAY4aP52mdL31l?=
 =?us-ascii?Q?dKnNmnShj2XHNMzaDNNUopaQBenLHC250qZ1oVS6MUFRM1GFiY2/kjOS8Vi4?=
 =?us-ascii?Q?h2mLYIjkUSv9p7YDAb4FpVJ1HzfrSPX9+LgJTEK8cVUEq6sbLhSzoLlEHDOG?=
 =?us-ascii?Q?234IIlVieoLHPg2g+8ZRsNkyzkwzYTgRFJ/NhFTV1R2Xp7h1HCUy50kIjsuz?=
 =?us-ascii?Q?R7mNbiS0EhDyemx8VuhBzXjxEs1b1k9Po9G18+938vvTbRi3GG1cE1u5nJDI?=
 =?us-ascii?Q?O3xSw6yd0uI4/cZE1x2HRDtgxuJgg/oFFtdN8rakdJ1Ulx7oakJez0qMN0zD?=
 =?us-ascii?Q?Dzp4YkjidwT/ucdDI9SWhMJ0r3bSKMfPkWy9sI10qzO9s2v1DTdMFOKgygFj?=
 =?us-ascii?Q?xpV52mXuymtU3gZdLRU7ySLHOek+ZjgHEPnZugjdtP9FoNfqpkX6xf+in0BK?=
 =?us-ascii?Q?09JnO1A1IUjQwUKeTtFK95N/gIMplvn977ZyfTZyVSUCffPGfq4ZyuLtIT1Q?=
 =?us-ascii?Q?/GjNXYntTvNQl5/tQhu3nAfk1moCEiIuONb+OcMckbvT7959n7NOHpPj8qVH?=
 =?us-ascii?Q?XW/qREAT4EE/zFkeFg1LvH1L5n16Cxy3VCkjQbJ6srCYn2n6e/hU8/mmUVln?=
 =?us-ascii?Q?XTPhxqkTd3ul5MK4Z6+GcX9FjpuXIzsVEbaAant6JN+4lmJhPpFkhG3eMyNm?=
 =?us-ascii?Q?EkLsEhsSi79h1FdNVXMiUmTYHAo5WaEUjV3hYamWsYl6s9ANcZfNYV2g3Z76?=
 =?us-ascii?Q?TwVUE5efXUDga6kml8dJ3YcdZPJPuOyD6l5gKLEWm9YwkoKRpmhJdxxQYOnm?=
 =?us-ascii?Q?Iso26GMgdffXga/vM/3EslcAzM6TpZbw5UnLacp4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dbda67e4-f9ae-47fa-4d6d-08dbdb8bf187
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 10:10:30.5630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mu6gUAm2KSWxrYKFs1vmdYF9Fb7rZbB8a7Fd3naZ92HIMalcBjnV1hKvMwM1FFszn7E0u997fiZGgczQCbC5Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6758
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

On Thu, Nov 02, 2023 at 12:14:31PM +0800, kernel test robot wrote:
> Hi Daan,
> 
> FYI, the error/warning still remains.

sorry for the false report, kindly ignore this. We will resolve the problem
in short time.

> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   babe393974de0351c0e6cca50f5f84edaf8d7fa1
> commit: 53e380d21441909b12b6e0782b77187ae4b971c4 bpf: Add bpf_sock_addr_set_sun_path() to allow writing unix sockaddr from bpf
> date:   3 weeks ago
> config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20231102/202311021257.nD9pHYSn-lkp@intel.com/config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231102/202311021257.nD9pHYSn-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311021257.nD9pHYSn-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    net/core/filter.c:11747:17: warning: no previous declaration for 'bpf_dynptr_from_skb' [-Wmissing-declarations]
>     __bpf_kfunc int bpf_dynptr_from_skb(struct sk_buff *skb, u64 flags,
>                     ^~~~~~~~~~~~~~~~~~~
>    net/core/filter.c:11760:17: warning: no previous declaration for 'bpf_dynptr_from_xdp' [-Wmissing-declarations]
>     __bpf_kfunc int bpf_dynptr_from_xdp(struct xdp_buff *xdp, u64 flags,
>                     ^~~~~~~~~~~~~~~~~~~
> >> net/core/filter.c:11773:17: warning: no previous declaration for 'bpf_sock_addr_set_sun_path' [-Wmissing-declarations]
>     __bpf_kfunc int bpf_sock_addr_set_sun_path(struct bpf_sock_addr_kern *sa_kern,
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    net/core/filter.c:11877:17: warning: no previous declaration for 'bpf_sock_destroy' [-Wmissing-declarations]
>     __bpf_kfunc int bpf_sock_destroy(struct sock_common *sock)
>                     ^~~~~~~~~~~~~~~~
> 
> 
> vim +/bpf_sock_addr_set_sun_path +11773 net/core/filter.c
> 
>  11772	
>  11773	__bpf_kfunc int bpf_sock_addr_set_sun_path(struct bpf_sock_addr_kern *sa_kern,
>  11774						   const u8 *sun_path, u32 sun_path__sz)
>  11775	{
>  11776		struct sockaddr_un *un;
>  11777	
>  11778		if (sa_kern->sk->sk_family != AF_UNIX)
>  11779			return -EINVAL;
>  11780	
>  11781		/* We do not allow changing the address to unnamed or larger than the
>  11782		 * maximum allowed address size for a unix sockaddr.
>  11783		 */
>  11784		if (sun_path__sz == 0 || sun_path__sz > UNIX_PATH_MAX)
>  11785			return -EINVAL;
>  11786	
>  11787		un = (struct sockaddr_un *)sa_kern->uaddr;
>  11788		memcpy(un->sun_path, sun_path, sun_path__sz);
>  11789		sa_kern->uaddrlen = offsetof(struct sockaddr_un, sun_path) + sun_path__sz;
>  11790	
>  11791		return 0;
>  11792	}
>  11793	__diag_pop();
>  11794	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
