Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71AD7C5893
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346940AbjJKPv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbjJKPvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:51:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F35A4;
        Wed, 11 Oct 2023 08:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697039513; x=1728575513;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ac8ady0JrlUmNQl8u/tDpWwRXl1oYefOfLMqcNGjHEY=;
  b=JgN9w7OEBjx+waT/+rRcHBHzfW4+RX7TVrG1LFu1xf14MXxp+s8N3Kxl
   bI7rYc0ab5yJFX4BJZf6upvkEsu8jbCVEPnoBvqRI0ELfbEOLQWieqmD8
   Wk+roAMzpQDSG4JWcfbyowpl94Nx1wI9zHSCUc8OmDT9zNKs49g7ZJAE0
   aXEV0nRsGtYtiGWGOh+u3ZD69T/aQqUDrppdZgMv+pTiEl0QrekYMK4WW
   J5HwD9Uxq6d+hgDYPWN82qQcEeYc1Yhy30K1eqCyOKMzQPxSelyOIzK4E
   zplkFbfRovNn3Jbrt7Z1KcUcKREW7WwMhQ3mTPQQEnRpyi25tHu6zA2OC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="381942487"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="381942487"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 08:51:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="730546109"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="730546109"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 08:51:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 08:51:52 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 08:51:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 08:51:51 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 08:51:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTef0Tfg485LgK4O53u/bIN5DBZAtevPEOsCwCUNGHdpiUBbPmNikpPs2gAvDOTSlumKzkOzkKj9g4cLlBvIktl3Tn1mJHRb/qDu8vvRDYXGWaITwLNwmk4YATxosMlxLkfscCP/VMm7o1hbhuz/VcUvdGiXPf6lpdet8hzuQM2FU+vNPMjeSUfx8r/kuKd/0yVsIv/krN1Uu/13rNbIAFv0BMY9DldL1PCnezHJzy6SU3QkAcluJPzUSTG7jD10VArT4QC/5DZu88Jlg4PTnmYP1Xd0G0CyP9RYJnRctgPH2GQpH73rGJDEHFSm27O065FWLjurU9iC6yV7BFpUYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZPYqk5lntcArUhIvb6BuWTOR8slkOKqTK63b/QL/KI=;
 b=ePgOHcF5AVN20ZMMjH9DBYlPgPe3ahkqUgBvIcnyD+ebPoXFp4N4KL1/gsaOLApXHvxSMtignjLHWQp05laa2YKqYI2RopcHtJh83ujyyDxg8HWSjpV3F+FFdwHTA5rFCdcwnUIhBrUCKu80gu/O4DBptqbJOyaX8uxm3hS5aArLHwiUx9TuDKkaJhTPzfBA+ODEXNMcVTNXocdoq4tmmhetCII+pvw4y7wAg/WSSoMNHyojCMzDLW2C8M3lMmq+0P2mlgXuJSOAca2uVab17vKWDvQdC+Tx4z2l5FXHM2EB8PBQVD/i0GaoRK+gmdADAWs0Adx/AoXCiTX/0ZPd1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CY5PR11MB6282.namprd11.prod.outlook.com (2603:10b6:930:22::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Wed, 11 Oct
 2023 15:51:49 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7edc:de45:7f2d:9ade]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7edc:de45:7f2d:9ade%4]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 15:51:49 +0000
Date:   Wed, 11 Oct 2023 23:42:26 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     "Sang, Oliver" <oliver.sang@intel.com>,
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
Message-ID: <ZSbCYt35j20ezT98@feng-clx>
References: <20231004183623.17067-3-tony.luck@intel.com>
 <202310111637.dee70328-oliver.sang@intel.com>
 <SJ1PR11MB6083D191286779302821A7EAFCCCA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083D191286779302821A7EAFCCCA@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: KL1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:820:c::8) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CY5PR11MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d453856-9f2d-4f75-9b79-08dbca71faba
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 27Vvpm2OB2K4iFJChYbdJKc05WrYs49BrU6ELPTAtiN2ziywEBqJ2kvkYTktmkfg/k0R1zlllQBCoBY9STMD/tNbPGzvIvAPPGSUQ3luyUPXjrEmr2ONfnEQJsSSwSaNYFe6DvC0/rP3c7UU4xj+dPit/9B7RQWbveb10LP8nnyqvCSEqRFXy/K1EW+SE0sBIok2/ZceealGT7yaiQwoyORDavWXWJpef3qWtc3AJCr4Qhs/f6aGWVHzdQkHaoLKTl9qhneMvLIwFmJtiXfjMOkEr4CG3TsK/aE6f5a/FwYbIl9It/vY6oPGfg1rLAh7G1LL7ibPKTG+Wvxk6o7VS6ejWGmq/65VthP0hlNwRe9A+/r4gY3ztOnpB+G4Cr5yPcngz05fQfwYK9BrBCTL2z+MKrofsSDGjYdJHCfDLTnczRWo7/9zdA2WyDDNuB9w9Lx9aH/ZgEzBiURk+B1zTpK3j3iak5nN0iifAPqqZwfMCN9Hxpg1VifwrpEy1yAXXMfVfJDPXRoWYQWI5P7DnlQODwaxc81q2AKpoSQKzpq6RnTDV8LOD6XuqoQ8yFy4rPeqUn9ImdLX1B9ktUP9DA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(26005)(316002)(6636002)(66476007)(66556008)(66946007)(54906003)(82960400001)(8936002)(8676002)(6862004)(4326008)(15650500001)(6512007)(2906002)(9686003)(6506007)(6666004)(83380400001)(86362001)(33716001)(38100700002)(5660300002)(478600001)(966005)(6486002)(44832011)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mLNGXOgX33oxArMJuX67wiGlHqXS48Yj1B1GUEiD4NIc+elRmJ65OSexuEzl?=
 =?us-ascii?Q?m0MucVNQ8jYjj+CVCBf6lI0ReVxs3hicuf15m+5dDRcj2aNgQGdP5Sr3MA8f?=
 =?us-ascii?Q?XYFjvzz+MkvioWLwHk4TzTheS5grEz4tWZuaLsjkKcBzszDiLrdXOTi9PKts?=
 =?us-ascii?Q?JrwxOLjCBkANNoz51i2K+S/fvzmTjaKc4/4c5GK5iH8jEu0s7YL2l3geqnbM?=
 =?us-ascii?Q?TR2mT43rsS/2NypVBgq0n0RlODTAZGawXKiTz2G+iy5oC7vKeExVhDV8r8xk?=
 =?us-ascii?Q?6dZjYVxrUd1LVrxaT+531Pjmyd8PVd8AfwcMOQxT+le0yVk37OmM+S3YvZz5?=
 =?us-ascii?Q?ak7c9DwAE0KMadyCAMC3xSFKvpGluXPP0tQL2Z1+HXjDDiqz//WmX6nlVBuS?=
 =?us-ascii?Q?BZvjr+dakxiqtmPCsD/m4hhAeClR2aYD+J/+Xb8Vc3PDf680DZ4dsfiyHl1k?=
 =?us-ascii?Q?tL8jGcfuc4/hfqW6D5j9FXtTyNJs6PGcTy2vpO2/lpmR9xiBRoom9w5rzJ62?=
 =?us-ascii?Q?42v3tMkQbEN81d/12ni8K5SwlQJJ/yRlj+PlGVST4IXYDRJe9ttUjnfFys7f?=
 =?us-ascii?Q?vgloff59CCyTLyX8XTBhmR5/YtCqlEoEIm7HGa/u4/XaUgYgeiQUA9bVjCPx?=
 =?us-ascii?Q?Jk6v8HNCzcNupOaTsmsJUe+mxiTLPiT/bXOeLGX2sxYq8uUwzuy93Vbmdddl?=
 =?us-ascii?Q?utsY6v+pX3IcuOA+wjk1NhILSdW+ytTGBrVCgXnmRgxwCHnCSYQwk4Nhm4Tt?=
 =?us-ascii?Q?XvpaQnuVfz+XuYoj1SrHJ+a+zgLl+QCenstS5rigfUgGbzOhT6+t7eKyBum8?=
 =?us-ascii?Q?tUXEPVcFwfCABE6AlcahY/DQS01leREMG67jrWLUMNS54ax7ABtgIfKXnrkR?=
 =?us-ascii?Q?+6O64amI9PxoIrmJRKCVFUZUKy7MeAqG+wZ2w3Uu8IcwwsYGhdfcgfz+enTJ?=
 =?us-ascii?Q?S1OTtd0cSKNm6vPVFsZeZPRDOJKxpeEostqNjmp6CX4ZavGle4PDNvRrF2yq?=
 =?us-ascii?Q?K6fd438ciaBfAqYJzPHFYnJ3anOfftW0qGuaUqom7Y9YsOZj6+XGtePciS9O?=
 =?us-ascii?Q?Fi0Vhf1Lua9zvAZFZ8M4Kq7LisEMUp5bG4sUACNq3SLEZLSHTqQDlJqjy/Bw?=
 =?us-ascii?Q?es39QjkI64CLDJrj/C/IaZPnr0B6WBWekO9zSR5Kf0tUUGfR+kJA9XxY96mn?=
 =?us-ascii?Q?ZlMC9kWRcyBSa5+9iQ+Oj9SD7NpdLt4X5w4S+TC+p1AazcI2jxswsoe2JfdW?=
 =?us-ascii?Q?Pth01zpJBgVJTvQGLaNwGKccAbVfSfBBjPNH6lfTt1N1ysxdlNOxZFGTwQ0Z?=
 =?us-ascii?Q?xDAYTfB0fOF1S6mSwHk2JcqrDSKBgjhDG5/7KcFdijbBjEgV3Grinrel88hj?=
 =?us-ascii?Q?ER/X69fMis4dlTH7CbmjsJjF4dvybiCAQAw6CMF8rHLZE66I2m8ccmhiss4T?=
 =?us-ascii?Q?5uEuF3Q3n8Pz9Re/gfj7FLyPUdEVFTtafHvOk6wVMvSU7Prdhlne+fwK6lPL?=
 =?us-ascii?Q?9EhfHSgHnpt1XWtAHyInjRh0ASZ9RgLvUKU62ezsYs3J+P66rqVP+i2xXGXS?=
 =?us-ascii?Q?LgqHroqmTBCogrTW0pidrPCpriEdTG1X0u7h4+ye?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d453856-9f2d-4f75-9b79-08dbca71faba
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 15:51:49.1591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pisBfV9kHmAAtAZ4Su4km6d2hP+eLbscNaW+1NbysPQFPzv3dahKzHHbZCqE/7r811HjhNHPIsC6sFTkT4+thA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6282
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 11:16:46PM +0800, Luck, Tony wrote:
> > kernel test robot noticed a -8.8% regression of stress-ng.clock.ops_per_sec on:
> >
> >
> > commit: 26bff7b04b829cccc6a97726d6398391a62e34ef ("[PATCH v9 2/3] x86/mce: Add per-bank CMCI storm mitigation")
> > url: https://github.com/intel-lab-lkp/linux/commits/Tony-Luck/x86-mce-Remove-old-CMCI-storm-mitigation-code/20231005-024047
> > patch link: https://lore.kernel.org/all/20231004183623.17067-3-tony.luck@intel.com/
> > patch subject: [PATCH v9 2/3] x86/mce: Add per-bank CMCI storm mitigation
> >
> > testcase: stress-ng
> > test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> > parameters:
> >
> >       nr_threads: 10%
> >       disk: 1HDD
> >       testtime: 60s
> >       fs: ext4
> >       class: os
> >       test: clock
> >       cpufreq_governor: performance
> >
> >
> >
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202310111637.dee70328-oliver.sang@intel.com
> 
> Is the test injecting massive numbers of corrected memory errors? The code in this patch
> is only executed when handling CMCI interrupts, or polling machine check banks (at most
> once per second).
> 
> I'm guessing this report is just because alignment of some hot path code changed.

IIRC, CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B was enabled in 0Day's
kernel config for quite a while, to force each funtion's start
address aligned on 64 bytes. Don't know if this has been changed
recently.

Also I noticed the patch introduce a new per-cpu variable 'storm_desc",
if the function address is 64B aligned, then per-cpu data alignment
may be related.

Thanks,
Feng

> 
> -Tony
