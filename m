Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9E276EBB8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbjHCOD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236784AbjHCODO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:03:14 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACEF4ED8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691071316; x=1722607316;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZRXN9pTj5tuei+a96iF+EicphR+8wi0EIcDEFX+/S98=;
  b=hSVM9muYqRsHxGpsYhrK4p+3IJhYlmDH0R1RZbW2tG7kBqq+zM52Ghpp
   yFiNKVmSyuDKr3IS60omSpQ4O3Jh/qTFSevzwdUa9bT8zO4sJHJIzOnwb
   kWI+cGoMNdSy+SGOZjTYf29Nw8BRSm3/6yztBvm3dYmMevk+4TvePTIE9
   hBFDh7TSGjsDrexT2MNSKj7ihzyP59N9eYXwNI9PCb6KJeCajJglry1EU
   1Q9HS18tdGEupf2Axt9qYx6aEki9YQiyuzVws/xmLsU6DahErV5S8y0Ah
   nuy5y+UH0eZl291kZhnocFYnLwPZaCtgqXnsJU+sH45Bx6ugdkguZn+zF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="436193774"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="436193774"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 06:41:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="729564694"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="729564694"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 03 Aug 2023 06:41:20 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 06:41:20 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 3 Aug 2023 06:41:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 3 Aug 2023 06:41:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 3 Aug 2023 06:41:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lc0zxHuw+xTZdyhVg77z8vHhl+66sii8x202mFRJK7FQ1BopUWJxzMqa9cnB4c8yEu51Qeo3SOk8Jb0a/hwC652Z+xFn4ZeRxhX0yrtwJ/SqjzeJTDbdQ7ut5xd/4GsCvjxiywUm9ViIGDVW20bLEi99oBzrU5pE1xA8JvHqtbKvGPj4hWcEqGYzGbh+DkTL9fAlSWhh/Y4bWuw8aK9+HYzOlWWQJZi0aAeuQHaTNbWnS5L3yatXA2TlHX06f+Za7nGLenqtXmemsqN0Ie1lD67fNtraeUO24Zccud95ORiZ+aGU9P5wOvHwv7fpRqGcjenW5VxFpoKJ7r0l7QrI0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpoZGdM/K/GjozHlOjzD/Xw/H4KW7SMD6PAihsW5nIc=;
 b=IZUr5dHej+18VC2sr3NG/5R5CZuAxQC2gs0YoaDesejZ7VQgPUXual8NQ3jWhttZhHqe4XhsAkZubinKswTRfldDdTA9+f96PL2Drc8XJckvlZBVCXhZMk91eXLVDpuNIdsqCPBnKhq7TiJj9rscGVsW+HxZ9QaVMKu0KrTPnPpmo+aWprnRU/jEXbKPpeqwnI5Ru7moe2tKwnSCSinxua+B5L8wwcZF93JrRqLJJISUrLq0ruCEaLoC7f3DD0Zs8xCpHUQQN20y0jDFysB16evwZtPEhbzXn/Vlg4RAONIVaR2k37vHc+aVUXcmqq+wjt393Sj5/Ikv3C5vgcS7Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by PH7PR11MB6881.namprd11.prod.outlook.com (2603:10b6:510:200::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 13:41:16 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::7afe:52f8:2d9e:4934]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::7afe:52f8:2d9e:4934%4]) with mapi id 15.20.6631.045; Thu, 3 Aug 2023
 13:41:16 +0000
Date:   Thu, 3 Aug 2023 21:41:06 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Colin Ian King <colin.i.king@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: Fwd: crash/hang in mm/swapfile.c:718 add_to_avail_list when
 exercising stress-ng
Message-ID: <20230803134106.GA130558@ziqianlu-dell>
References: <43765f2d-f486-8b00-7fb9-9eaea5045bfe@gmail.com>
 <20230803060646.GA87850@ziqianlu-dell>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230803060646.GA87850@ziqianlu-dell>
X-ClientProxiedBy: SG2PR04CA0179.apcprd04.prod.outlook.com
 (2603:1096:4:14::17) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|PH7PR11MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: c757d516-5cc4-48bd-f2b9-08db94274f2b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: awMgHEqNoQxmVtZlGwYf/if9B8DNJkeaSMdMKMS5WEzuRAqGpHGfTRdlX3ig+4lKHuj3UsSvcnSmJnJmQhRTWt+qMiQ0rpvlivPoJ1CA1Binzf4XVVxFd81mfxpoQkBcAB80sIPqV6NYb7QckeuWnwlYPxfgHxDQv2jHTY6O7KqfDHwM8Z83X5/474N5+Rk6A+Arrq5yB8UwBS8us3BGcU4ZPHfZIy27R5+2FBs4Sfig5tgWm1yQ78plSE/+T3dAK24nsXfQ5fyBzRtx1SGrTO0z/a5rTDukCWiMLUV8lsHaX/1hK5MVLZEv6xIp5YHiHYHQzgBkyWWw4e28x1T/Z8Penfu5ZdXrwgAKXa9wYRkLagEvPba9bBvH+kJvap45BhX+UscEKRl5Q96UrRwHrNxOme0BzLxkgiNA9l3KBuUV7i+8ARlKK3g6ALRY/j/2vBWH09u8Tpq4BqcksRhjzZrM/x2pmKgnwyoReSZCZABrPGsSH+/2M4zG62TPaoi1eXO3cgIoE9DeelWvl6gSPHG+0luQ5z2S+JNq8fIHDMY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(33716001)(86362001)(33656002)(54906003)(478600001)(110136005)(38100700002)(82960400001)(1076003)(6506007)(186003)(26005)(83380400001)(8676002)(8936002)(6666004)(44832011)(41300700001)(966005)(9686003)(6512007)(6486002)(316002)(66476007)(66556008)(5660300002)(4326008)(66946007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SacaI+bGUYa8Rh90S3rXPLatcnHSZziU3zPvf9SbiuwpVPa2MMg+3kSEOoRg?=
 =?us-ascii?Q?lEmZnljei9Vh/1++AUnGl6Ki0VWGGsDpx3nObuyyIVUveXymGuGiNCedh5Bb?=
 =?us-ascii?Q?z6dwSYX2TpOtpelawBKX7XO2HtfVb5RHDBbtoZQYBCSdvES0ZKqrJ0L1Ma6o?=
 =?us-ascii?Q?ldwG49r4Fh/u8VSnpm8a/YHVp+zmCnIZZfIoRK846yLzpzbDLDNg4GAHjYKH?=
 =?us-ascii?Q?Krq7HSk3v3UAUaKjkDKUUDqFc7GFzay7t2znkxt6VTlzPQinKK7UWNauZNNR?=
 =?us-ascii?Q?VJVdSz03sAiTkfI0OpOyNdQ0ZVueqL1A24JkaE8L9gHwCrbvSNv3loHJ+kN/?=
 =?us-ascii?Q?aWCJJrstL7Sj5esEmXp0h+5wyUNIC4GqEGlScPh9iivth8dDea6dvYdY53U3?=
 =?us-ascii?Q?hAyN3kFZxSvuIT68oEXoISzutuWOkg93KthCu44Ca4yeighEIJw7czIDKeBb?=
 =?us-ascii?Q?tLU3S5M3Cw1rrJn8EDk87P3u0IRi/AKm2Oz9LwYKfx3uhi/W00VpT2UuL6Sy?=
 =?us-ascii?Q?00ujEem/AULuTML+DzDkVxHEN1PMMWFvjfePOJmHapY2Y4EX39vKpQGsFhsn?=
 =?us-ascii?Q?xM3Hcv1hkx6WbjBOKsICHx+iHoZ2/K+ET4SNx+1S6+PrLqZUuRHZgBox9FLw?=
 =?us-ascii?Q?zuLMDBnAsg8Sn8l0tUqz/5OwCGzI73WX5wqZJBMsTWNJfT565BsUDnILGpsC?=
 =?us-ascii?Q?iwVGT/X8ULMa5362X514jeNmqBjP6u7ef2tYde+lCgbest/O0V46H+1+uTxD?=
 =?us-ascii?Q?pb2A6cq406hUgpXT0vuGygUPCISIQkE5OuvTIsCOOOif8iMXNPAFazJyi0Ap?=
 =?us-ascii?Q?IWzqfKFEhtUHdAoy+/9UnmcDbyb7h5hXQUmYYgymcn7nIY+otQiLJjS6XyCP?=
 =?us-ascii?Q?ssPwzxa9awW71aBXaHR6fLId5o0oB+6XHrxiYj/y/uuVp19ThTsY9t0C+IlP?=
 =?us-ascii?Q?UpRCg0+F7i29duT9KIM0b01VNZ7eh/G/G+J67i+mGg3+7XdScGexK72GfznG?=
 =?us-ascii?Q?ancYcEdoF0UlDlO7F+0iJUmejo2u9pKZQlhEOCWKIdw1AtifiQHlC3nwk7Tm?=
 =?us-ascii?Q?nKK8ZqZ9j+90QyuMerrXlX1aTOA/h2axjCVyjVCcBOnbnVeYEq16lAXbJl5g?=
 =?us-ascii?Q?T/NXQpdV3AEJULnfseoRQHkQNuf0DppHA/PgvTV4etnGXBu9E/pMM0IGASk4?=
 =?us-ascii?Q?NcmCs1prkUnQgg9aR4lVBCLyLh0Qh6xOpK1iWED9f3LaBTKElM5edtPjE5LY?=
 =?us-ascii?Q?8BVmA0+YSqmK6UoP/H/C/mzUqlIOJ15uHkB8D2g1isG4sC4NIjyz3qa56E+w?=
 =?us-ascii?Q?UvhGmYLC5juUP4yNKtJfHxsx9u3+eZ27fGDAB18pGgfAXp4URwFGqdiE8pNC?=
 =?us-ascii?Q?JVs4dDapLlk4aK4sUe/pJjk96Ub7GGoF0W2LpiXk353h13Z1AQu2yhEP/vnU?=
 =?us-ascii?Q?kh8S7NP1eQ7NY1uRWCgXz4BvaieMHTNYPxA2Vt13xy1CqtLt5EJ5xWFjrO/B?=
 =?us-ascii?Q?N7DCEQRjeCXJUtGj+eKjIn3aczX8g9uD44OTIPzcGKS+5y9vGopuzRd0ZM0k?=
 =?us-ascii?Q?JhcBA3gzMIGuc4l5CJBC6MjC9hYWYslkskTb3SAv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c757d516-5cc4-48bd-f2b9-08db94274f2b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 13:41:16.4176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiDJLjHBWaCjlZ/LZ+iYKAwjK3yC7FltpxWj+nSmf29eg/DSNQ5yePkMlR3My6NiizxLF/39gOdDfeDssIzvkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6881
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 02:06:46PM +0800, Aaron Lu wrote:
> On Wed, Aug 02, 2023 at 07:54:38PM +0700, Bagas Sanjaya wrote:
> > Hi,
> > 
> > I notice a bug report on Bugzilla [1]. Quoting from it:
> >
> > > How to reproduce:
> > > 
> > > Had 24 CPU Alderlake 16GB debian12 system running with default kernel (from makecondig) on 6.5-rc4, exercised with no swap to start with.
> > > 
> > > using stress-ng tip commit 0f2ef02e9bc5abb3419c44be056d5fa3c97e0137
> > > (see https://github.com/ColinIanKing/stress-ng )
> > > 
> > > build and run stress-ng for say 60 minutes:
> > > 
> > > ./stress-ng --cpu-online 50 --brk 50 --swap 50 --vmstat 1 -t 60m
> > > 
> > > Will hang in mm/swapfile.c:718 add_to_avail_list+0x93/0xa0
> > > 
> > > See attached file for an image of the console on the hang (I'm trying to get the full stack dump).
> > 
> > See Bugzilla for the full thread and attached console image.
> > 
> > FWIW, I have to forward this bug report to the mailing lists because
> > Thorsten noted that many developers don't take a look on Bugzilla
> > (see the BZ thread).
> 
> Thanks.
> 
> I can reproduce this issue using below cmdline:
> $ sudo ./stress-ng --brk 50 --swap 5 --vmstat 1 -t 60m
> 
> I'll investigate what is happening.

Hi Colin,

Can you try the below diff on top of v6.5-rc4? It works for me here
although I got the warn in a different place in get_swap_pages(): 

                        WARN(!si->highest_bit,
                             "swap_info %d in list but !highest_bit\n",
                             si->type);

I think the warn you got in add_to_avail_list() due to the swap device
is already in the list is similar, see below explanation.

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 8e6dde68b389..cb7e93ec1933 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2330,7 +2330,8 @@ static void _enable_swap_info(struct swap_info_struct *p)
 	 * swap_info_struct.
 	 */
 	plist_add(&p->list, &swap_active_head);
-	add_to_avail_list(p);
+	if (p->highest_bit)
+		add_to_avail_list(p);
 }
 
 static void enable_swap_info(struct swap_info_struct *p, int prio,

The finding is, if a swap device failed to be swapoff, then it will be
reinsert_swap_info() -> _enable_swap_info() -> add_to_avail_list(). The
problem is, this swap device may run out of space with its highest_bit
being 0 and shouldn't be added to avail list. In your case, once its
highest_bit becomes non-zero, it will go through add_to_avail_list()
and since it's already in the list, thus the warn.

If it works for you, I'll prepare a patch. Thanks.
