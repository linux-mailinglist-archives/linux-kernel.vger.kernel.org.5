Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4C480B058
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 00:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbjLHXB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 18:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLHXB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 18:01:26 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBE010C7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 15:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702076492; x=1733612492;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=e00Pl3VZV8Jdf04+UX6lZ/TsV0orO6ArH7PrDZ580o0=;
  b=fVt5ycmeUeyqhP1fTCrnOhbfUKje0t9NkZMKECITHNUQF46GoOkLLy+F
   CEsGd4h0093Vql5K9gKlYpHuVfL4We4FkmxgFHiDbWqbfUoWSLnSpwrvQ
   s8RUS2oNfB4Uw7uvwSwwhHCt55t/P5SzV7Vrm5VI++WPT2SsXSmrbBqZG
   5tzBFmvpsjT9spgBxmt//EyY9o6Uph93Iir5z/Jf9lWgSUXWSRt1XJErB
   nK79kzU1J8JgBBOKiGNAxeltAP8I8UZDC4/rKTJ7R1B/T04S2VQO/e+aw
   c9IEgQEm4qK3Cn297iIJrjdiwoszqvlwCGtHon1l59OUPjErr7GwjyhUs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="374636808"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="374636808"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 15:01:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="772284430"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="772284430"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2023 15:01:31 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 15:01:31 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Dec 2023 15:01:30 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 8 Dec 2023 15:01:30 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 8 Dec 2023 15:01:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knsVvos+Vg5sssNWvXjXIEqwVHd55EwStqPtOXrapgcXs2tgUTMuCBJtAsyWMdQ1/3n3M/sJAZ1xcDueVo1bLJJg0e7FnnnwY1DzpddB+X+Rt5gR86bhjISRBwTR71E6205/ErC4l6W4bL1fzSovumbwnr9vdXauCicf0DltQC8uj5p406oRXJHFMpARHN8t6LRbj+1/A5VL6vN4aYb1HStnsE4ZGLcOR0hkWiLu2vzuClX93eddRt66OhUXy8RTH1BYxkJKkBtQRNo5QGzIQ/PUKpPAb4TxFYr6vaofbiirBszwCRebzVCNdasbfa3ivFbSC2IwVzc7xVe7aH2Jlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XJsMPrOQ5uc4OrjAeLdr2vUKOw/ZAr9kVzIJDstukc=;
 b=VdyswR052i1DaavIml3Pr0vSEDFz4au5Ls30Z1KPhsXeQExYkp+gINuUBaS8dOip3tMpdE5a8U+yA44rZmPJ3pVoOec08+kURWnYO1FkeCXQA4VzdDJH2+Kx7S7Ix48S2pwfrebUu5ho4eIXkYqQDXpSDXQOGdAcinxTKBT9BXvbpxFOJ0RjsQZUfKk/uNrgB92Moa9QyOaAdO5W7YCQFAu5yc1snEz368YWymBquKXK3AvMuEKV5Dl1Jc8GrrE+pgGF8iJI4wUtNDhCXe0/qDQL3/tAKicREkB+4Dx1UNVbLYMbu0/46U7VscrU/CAWEUzRTbWTCSSKzzP8xmELWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM6PR11MB4659.namprd11.prod.outlook.com (2603:10b6:5:2a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 23:01:28 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 23:01:28 +0000
Date:   Fri, 8 Dec 2023 15:01:25 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     <dinghao.liu@zju.edu.cn>, Ira Weiny <ira.weiny@intel.com>
CC:     Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvdimm-btt: fix a potential memleak in btt_freelist_init
Message-ID: <6573a0451c4b7_1e7d27294ea@iweiny-mobl.notmuch>
References: <20231207034332.24107-1-dinghao.liu@zju.edu.cn>
 <23a91617-4562-4399-a8c6-df2f3f28c7a9@intel.com>
 <65722f2a94d68_1c7b6229452@iweiny-mobl.notmuch>
 <7205fcd5.258f3.18c48233162.Coremail.dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7205fcd5.258f3.18c48233162.Coremail.dinghao.liu@zju.edu.cn>
X-ClientProxiedBy: BY5PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::38) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM6PR11MB4659:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc53a5a-0654-46b1-66a0-08dbf8419be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8iadfEFjyxJuYS0Dvq+ZVOGPXxGoNjI/GlGep9Ea7UBzJBBiXrzTy6FY2fF5dPZmEBFfqu8BxgD7bnUumRUeu6J65mz2o2gGefHo+TH7jkGK4ufjqp/kSKxla/Y1iUah+qBf07i438as+TDa2IoohOP52x2LBkB/dgMP9yJ+F62pNWp2HTmPDdfm0IzqIjuOWSe2q+Uci90GQ7Flt64hKw+5ibDgSvag3dqjDVl+cn0cQmy9OsE1gOMD2cTUGlBaeaowDyfl1vGRqyMwcehbm1Yr1sjbJrc4IwwzvzmCiJ0hGL8CAIMVQ6yCAYh/ErBmvzjsilmtgyPvcd5rtImPjzmaD+iR0Hnvx0CBvtPzgy8jNz9yU/XVGcUQ30nSMcu4qi3vSXHCh4szZ8xmex/gFgJgFX9yvs6uV6xNGp5PRLzFu2m6P38BEbAc8NDbVAInE497EFTSwLVZvxA8tCNhqxqIxBotyNl6SF1LlpQbRzQzZTm+It1cJiR+54gLcm4oTPv+4B2wkHfdhbVmmL5nBTZecBcFShC3m1jkTQmga1qUq3WSWcFLZV8YjTvvsmaq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6666004)(9686003)(6512007)(6506007)(6486002)(478600001)(83380400001)(26005)(2906002)(6200100001)(5660300002)(41300700001)(316002)(66556008)(66476007)(66946007)(54906003)(4326008)(6862004)(8676002)(8936002)(44832011)(86362001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KP0h3jVYvk8yfFqqjArtpdBCkSjRPBWbSzkDW4UQ+SgtCf1pUNeC56/+/v4q?=
 =?us-ascii?Q?vxDl4aS4XwpMZsjHvijppL6fgvmbFTromU3/mOUL8QGYjVFJwDcJ2ZHmFjvE?=
 =?us-ascii?Q?yA0z4hRfC5fmsof5Cz2VUvA9Myo6cPKr9MLIOTSbemaLYzKSIrYn4EaGWUfk?=
 =?us-ascii?Q?lxh+7MmPYBzUNzt5Us94OW4hOqntmThq/wfCw9TB2li70JkGsyA2LWQ35N5j?=
 =?us-ascii?Q?YScjUaM9sS7wmr7B2n6hCbQk4iVZrBu+z10j4egOTEXDan3zjjR3/A0jHniO?=
 =?us-ascii?Q?uhx1cqXmh56d2Y3GzETi0tKaNPcUJl/xJnurorZLezsnA9PL/mAELMkbuAG9?=
 =?us-ascii?Q?UmaobFAQHCDWCfioq7qbgWXN4fkJaPvxhVJkwQZFRo9BSlfOd57RcM6JB2gv?=
 =?us-ascii?Q?Sy/tXvQA2qEB8oUNuB+gl2aIzbj8OMddADfGSZP8UfKYbDDd72EWq6WgEGCx?=
 =?us-ascii?Q?lbVD/zAdFqe3yrD9+BVLPG2BMBI5pwMIhUrII9igdUWpvfbyge/zfTdZ5Ala?=
 =?us-ascii?Q?4H9ow+yS7ZUZmujoluzA7Zy+OZBV4ZDRoKxjMguGGvvf1Z/e135K0UbGhhz6?=
 =?us-ascii?Q?r4TdZ6T8cgv62ACIEImVnKy/Ikztq7q1r5NfNFyV6QYVYQUIfWPuZ0fqi2Hw?=
 =?us-ascii?Q?5DBz1GQei1rUgKgtN1LgZ5KCkuIn6T1W8xklWo8EYugi3kvsx6kDKmNGpGMt?=
 =?us-ascii?Q?3AUMe6iIBj0idYT1T/rUm2fC+/Z0bqpwl1QaQzu0GpXut2C/Xd2yoHdRIRod?=
 =?us-ascii?Q?6eQqmnH+y89VS7gRsbJ6TJ78i5qZWw4882DQ57+V9KymzUrEvviPtclsf3rb?=
 =?us-ascii?Q?JRYE7vBEH2MgN77r2JBwsRnpapy8QbH10MccAXxH3jupeF7S4mr+9nIjD2gT?=
 =?us-ascii?Q?bmAbHhqod7Jpbq+4kFtqjzsj3/iKImOMszAMt4muyKH0qIui+CL7kQDVDCS9?=
 =?us-ascii?Q?hSxoMWGpJn2OnsoytH1zvQUyCGTkKFkfXgKlcfzXSBH6xGlHvlMXLea9IopM?=
 =?us-ascii?Q?MLMQ2qabHPgMVF/1dOYBEnc9I230CgjyOgxWqOzybOJUihloToUZwTWUixWz?=
 =?us-ascii?Q?Z4LC16ZRYlFnRKiLNcDaK37RlMUOmdU42Yg3IYwqwZzXcQS2lYYkuhX1BTPm?=
 =?us-ascii?Q?4CZ10tXlpQ0AQAGj9b8La1aQ2bQakCHWWMxox4u95qbft/D2nZlcPaG3RewS?=
 =?us-ascii?Q?HkjjHFG+9Vpa6bSoTj4803w8bvUrpBcP0E7LLu75y6CwqR8aqnGQ5HhOw5/h?=
 =?us-ascii?Q?TTCewKPLFevBGxEahD1kaFL6SzKUAyxFKVFOnl5o0zStaU2UFFfyZSFx4Dge?=
 =?us-ascii?Q?B/Zuo0yzSG3BI6d6xXoIMqbT8O3LzPFQ4Ob8eSW1pO0fwluQtqNCmEVzLpdl?=
 =?us-ascii?Q?d09D53IYlJJImCtV98nE19QHswbBmV9w3rdOeVb38DAgUer0bHmLSRNm/oAw?=
 =?us-ascii?Q?o86rdQWV3VM6FSH2CFZWMyiWn8EW7WePQXhj03wpFTNG7QuMHMHrlaOYO3ow?=
 =?us-ascii?Q?DSEysDeIvDUMWxFFu5MxAFgE2MViRYFUG40ESRG0oXE26Tock3shRhL+N5o+?=
 =?us-ascii?Q?HjXPr36S7rrsgpXARwoak4/jkAWSnoGWMMIUkwkm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc53a5a-0654-46b1-66a0-08dbf8419be9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 23:01:27.7894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgOBmxG1VuIO/t43/cy+iw63Joqpt0JeZDY1KgeesoStBLWE7ujJPhLpNdKr8ObYzCYXX9DtRQS/AidARyjkHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4659
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dinghao.liu@ wrote:
> > Dave Jiang wrote:

[snip]

> > That said, this patch does not completely fix freelist from leaking in the
> > following error path.
> > 
> > 	discover_arenas()
> > 		btt_freelist_init() -> ok (memory allocated)
> > 		btt_rtt_init() -> fail
> > 			goto out;
> > 			(leak because arena is not yet on btt->arena_list)
> > 		OR
> > 		btt_maplocks_init() -> fail
> > 			goto out;
> > 			(leak because arena is not yet on btt->arena_list)
> > 
> 
> Thanks for pointing out this issue! I rechecked discover_arenas() and found
> that btt_rtt_init() may also trigger a memleak for the same reason as
> btt_freelist_init(). Also, I checked another call trace:
> 
>     btt_init() -> btt_meta_init() -> btt_maplocks_init()
> 
> I think there is a memleak if btt_maplocks_init() succeeds but an error
> happens in btt_init() after btt_meta_init() (e.g., when btt_blk_init()
> returns an error). Therefore, we may need to fix three functions.

Yea I think we need to trace this code better.  This is why devm_ is nice for
memory allocated for the life of the device.

> 
> > This error could be fixed by adding to arena_list earlier but devm_*()
> > also takes care of this without having to worry about that logic.
> > 
> > On normal operation all of this memory can be free'ed with the
> > corresponding devm_kfree() and/or devm_add_action_*() calls if arenas come
> > and go.  I'm not sure off the top of my head.
> > 
> > In addition, looking at this code.  discover_arenas() could make use of
> > the scoped based management for struct btt_sb *super!
> > 
> > Dinghao would you be willing to submit a series of 2 or 3 patches to fix
> > the above issues?
> > 
> 
> Sure. Currently I plan to send 2 patches as follows:
> 1. Using devm_kcalloc() to replace kcalloc() in btt_freelist_init(), 
>    btt_rtt_init(), and btt_maplocks_init(), and removing the corresponding
>    kfree in free_arenas(). I checked some uses of devm_kcalloc() and it
>    seems that we need not to call devm_kfree(). The memory is automatically
>    freed on driver detach, right?

On device put yes.  So if these allocations are scoped to the life of the
device there would be no reason to call devm_kfree() on them at all.  I was not
sure if they got reallocated at some point or not.

> 2. Using the scoped based management for struct btt_sb *super (not a bug,
>    but it could improve the code).

Good!

> 
> I'm not quite sure whether my understanding or bug fixing plan is correct.
> If there are any issues, please correct me, thanks!

The above sounds right.
Ira
