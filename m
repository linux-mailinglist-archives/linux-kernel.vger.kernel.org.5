Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE23C7C5010
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345948AbjJKK1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjJKK1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:27:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3423292
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697020062; x=1728556062;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=C5SkC9qlEbT4zaSlbfQlJ3syqFCneQ+cpbnoLJv77fw=;
  b=XZsBHJ2JqCuNhmGZIs16XytKskh9LCwpMVH/WyvM+GpbdnVSnkjhLkkC
   h8FntWB+BJMjVI5qhaKuj+UOUzbbjVCQyg3hw/4nXtQvR/xemL6PzT5am
   FXCPR7TpU2jU+1ZeQYU55JPHTXZAiEe4TDagAazEe1VGIm/l4S4I99m1l
   AcGiBq4c7HRPzpu6YiY9uypfXVFHeEomudZJzH5YtmfGSl4bQ3/p9REZJ
   w4UGgdJzhIZnvKQeTfNeUYZNwl3PH5DOY9pNNwPkoT6aMFPrOigkp8TxV
   oGG0i3piJ2ZAVLh2QgpR/3fDGG+Od1F/edPRgnBygjamGd/dRiE+7m5rl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="451119759"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="451119759"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:27:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="730445049"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="730445049"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 03:27:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 03:27:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 03:27:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 03:27:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUyS1IHAt7+HdTDiDMbL2Fkb/HvxXVb7XgB0SgQFQTHGfeXTsosQN/r9o/OduY5bL2eVmX6X8G6MOHWh5Bm06NEbKXqAdWsSgT+Qg+k1Rjdzptj5fJoaze8DBtSimY4zQpIzpKrDqZ2Yg9g4t/63E94SjR3qESblyRWPCvPZ4WWhdMDjlQDOOn+Q1tFa7i8gyc39z5Grm8CW8Qp0gUWSw726ZUujXKficxtrphuyIIa8fC6PnbQT9GBkRIy/xwh9GXPhUZG7noMd3vPlhPZ1HBl+yqI9xnp3+G2ioHCMLDTfJbLyGw5ZN1E5jNhmVb2AJ5mfapASfmo7IfZD9Mypwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHKXBn56vdJXaFJLGAN80jH6txZS/dwGZMPIz/9fAKI=;
 b=NypEtgP0WjBYf/+MQs0q8tVHB17dI8usaGBFiCUlAJhVBCJsu072Ort/WBGic7RGTElXWJ4K975u04yu47KZcXZB1NNmFzfU9PakYduafBuAbHr703ID+DZfU373gJiR6c7OEQqwOVx4/NkLL/7z4KA11CoSpvafHYxjSo1qBy7HerHKRvxLi2NIjZUvQ3qE+qb3W9lLgCT6ZXiPUtVd/Ywha/3TzibkKYu32VG6DT89AUNOhTu/5a413+XHoYny4m1VbXGqAtaW26bNavrH1RwOP8askVUHM3+ws9F+k+M38vxLk06ARksxNXLsYmdW0y/jZ1qgU0D7JFaNb4CtDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CH3PR11MB8468.namprd11.prod.outlook.com (2603:10b6:610:1ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 10:27:39 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%5]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 10:27:39 +0000
Date:   Wed, 11 Oct 2023 18:27:28 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Biju Das" <biju.das.jz@bp.renesas.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        <linux-kernel@vger.kernel.org>, Tim Chen <tim.c.chen@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>
Subject: Re: [PATCH] sched/fair: Use printk_deferred instead of printk in
 pick_eevdf()
Message-ID: <ZSZ4kHnpQa95saJr@chenyu5-mobl2.ccr.corp.intel.com>
References: <20231010032541.339606-1-yu.c.chen@intel.com>
 <20231010075928.GA377@noisy.programming.kicks-ass.net>
 <20231010122600.GA477540@lorien.usersys.redhat.com>
 <20231010141244.GM377@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231010141244.GM377@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: KL1PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::13) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CH3PR11MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fd20192-a0ae-4253-bc8f-08dbca44b19e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5nH+IB7l+9GxjC+C5uHx8jMQ1RBZtbjjjBU6Te2MFDHiNwG7lidJp+80QLyQnXS568LehkTDdBPnu/LiY0r0VWMv4LMQcI+jot8nfl0/UVO1PnMbGTsIn2UcmgQ3nN+RymU8oqL9rmqoBqCG4X9zaEoKPFOuZFFQl+uZSm3NqGN10YlBLnUUxAcgxPMPLCeLO+IexityuXFgtpHquyToYgOvC3pZcDNkcCzwhX/MjO+V7SuOSchMi1J+oYVCqw7ScZ+Eb6lcO7J8rAu/953hhRSPMpmhYWOWtcBlh/3V6ki4XH8iVfaFk89ujoNHCuP5XrbkUIrfqEapzZAC4s2ulGdLdgvKpraB2pzRCLhYkBfPSRyYRksQkke1GxvrE72e3asMD2A3PKxtC6ZBXnwAnHUoD0oAhz/67slAuMdP3O7EYwDNaD5dzE5aOIoCDkcl5g5hOXJY6ra4O33BZIjDZ2TNXkHt40UN+14gToUPZNlQGHNR+LVAC1ErQbkJTh4qL2PQk7GUPYcFhJoxfjjec6rSweKcaoAnZgalqFmaxB8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(316002)(66946007)(66556008)(54906003)(966005)(38100700002)(6486002)(5660300002)(41300700001)(4326008)(8936002)(66476007)(6916009)(8676002)(86362001)(53546011)(2906002)(6506007)(83380400001)(4001150100001)(6512007)(66899024)(6666004)(26005)(478600001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zw4CTNZ9EwHF0tb9iBGisq0iP0RB/EJkx36jl/Wkd7BXfKamTxETakSNOKaK?=
 =?us-ascii?Q?HIR17UmRz71H4ATEUMdDH3/8tIGWmqpQAp3UDUaqA+LvQ0U6kOnVGMPgoM+1?=
 =?us-ascii?Q?uITuRS5EjaZlQty15jz4e1X3QhY5W0rj8iGe7yUcxsaxZHX1wKWhdDupQx6V?=
 =?us-ascii?Q?AhWq5MwGDWW/FPLT0/TBeWk8yf/DDX/5A4vAJYnq8yqptyW2kpwADNEUCRF0?=
 =?us-ascii?Q?pcHVgYWiaJmz+H9vzK7ltV6V0B4catIQkejvNUUbSqylT80tG7rZiuDfsmnD?=
 =?us-ascii?Q?SOVmuLd8wCa63JTslT5zJrIGjHnA9cEeae9YEcP0D9SGlEEXxQ3griX22oFB?=
 =?us-ascii?Q?f6MxTqLrpMT2AiDZGhl0gWjkNFl/EziTZnyVuE8hRF9DUzGGD97UGKTe9Z9b?=
 =?us-ascii?Q?HDqFiTwIHk52oK9iV5Fp0Y8yZcPPAKUh5zTFg10Ema7DPLs4x64V+VWsi5Dz?=
 =?us-ascii?Q?pvY7ApRdjtb+fJ2cTwaXRLUnIP9Hr6i6PadjgFMMrenda+7Sr8IDmlEq5HCF?=
 =?us-ascii?Q?l+VWO5UBO77AoLhBYSVs0q//FksqVwDJ9gxt96Pxe4Ia/k9Jp0v9wtr7Hau5?=
 =?us-ascii?Q?IHNYcVwa4x/PHwmR192XUJp8Ad5kvsf+xQAECZ9pyJkJMbBf7ZGPwqUk/6Ho?=
 =?us-ascii?Q?9H9v6IYxEd8n7Mzer0VfwPmxZVSy2IXiERuU60poSmivfVm8gnwYhjTAgVv2?=
 =?us-ascii?Q?8qZGq3OHfnBHy+fgOwCPjw5jl7yzPmJLZeEpCcRH0FQUS308ckBVWXoUKAN1?=
 =?us-ascii?Q?j4sCmtEGj2Ib1LB8n5xs4SyVVBUbOVa4rtm58gPjmJ92wSr6AbZfSyytadNK?=
 =?us-ascii?Q?CUIQAf6h0ZLlXzIJbPZKmmIQBfESWMTmaglQna0gA0fmzLo9N/toMVcuxc0v?=
 =?us-ascii?Q?pXLwifrZbhj18eFApiZYpwBWZ8BfudCager1ey9q3qSnvgsP2hs5XtQroAFK?=
 =?us-ascii?Q?i7L8PoF9nWjFCZPzI2Vbt1vh+bXowfBwofAf0JpIoqfdKTw/DnAwCy8PjelS?=
 =?us-ascii?Q?eU5dztDw+GVfe147hIxLbKEZ/AbAqKo50lz44v2hguBEHDyf6Bb4w5MSaIzm?=
 =?us-ascii?Q?oVZm+iOagLz9+bW/aEyqwd+G+bAHuhGk1zmI3U3nojQtuwJeAmYCSaWchfAn?=
 =?us-ascii?Q?Ch0TJyI3gubFqUQsZTS0ERlAMR0z8Ot15aNFGc3/Yyly+q/8JUuDb0JA9hgH?=
 =?us-ascii?Q?0ht9BEbPaVpQfPaNX/AXQkFtuvDUzvWcWouzH7RcioEGWhdVVQ9IahRirW55?=
 =?us-ascii?Q?m4ZeNnCqb2TobVxH22+O1VruOIKuXm99Hm4CHA2dpTGPuDQycu2khKKmm9Ky?=
 =?us-ascii?Q?3hh5KOCz9AETH8yyDq5rTM8JbBUfHBLUCkFnm9j0K/kJQ721IaAYeLE0Oh5M?=
 =?us-ascii?Q?2yDVUwImHitjOaGIlTq1AyYYu5K9W3ubf2HegKT9T3zahzVWzqv0WfKIPhu/?=
 =?us-ascii?Q?UAlQ6Pof2oWLtoULQTKjmbGbhpdr1amfOS1BSI1hcWRkEsa2PXJ5LxMOWvk6?=
 =?us-ascii?Q?FLwEEEgF2xLfrFbGuYuEdcKic9dv/vO+HxG/xHm3kYJL1n4JipPSi3FI7dAX?=
 =?us-ascii?Q?7rmrCTOUTtqNyhJGnzZ4THIFNPVSkIGjSazOGYok?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd20192-a0ae-4253-bc8f-08dbca44b19e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 10:27:39.1658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F43FodOUxK0oWpxOkvR9UxssszFQ0GMSB26KbjkzB1q3wTSKAwftQ9AgIrnlTBSGDdilKuMiWLAeWuG2sSwcMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8468
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-10 at 16:12:44 +0200, Peter Zijlstra wrote:
> On Tue, Oct 10, 2023 at 08:26:00AM -0400, Phil Auld wrote:
> 
> > > No.. I detest printk_deferred with a passion. This is effectively a WARN
> > > and we don't do silly buggers for them either.
> > >
> > 
> > Sure, printk_deferred is not ideal, but is getting this message in the right
> > order worth locking up people's machines?  Not sure you get the message at
> > all when that happens.  I have to dig the code location out of the crash
> > dump to find which sched warning fired and took down the (usually virtual)
> > machine.
> 
> Same thing with WARN(), we don't have a silly bugger version of that
> either. Just use a sane printk() / console or whatever.
> 
> Virt stuff has perfectly functional serial consoles that works just fine
> and don't lock up the machine -- mostly. Use my early_printk hacks if
> you want something reliable:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=debug/experimental
> 
> Boot with: "earlyprintk=serial,ttyS0,115200 force_early_printk". And all
> will be well.
> 
> The fact that crashdump is more reliable than printk is a *BIG* problem
> and the only solution is fixing printk() (people are sorta working on
> that). We should not try and work around this problem.
> 
> I fundamentally despise the delayed stuff, I've had countless insteances
> where delaying output means you have no output because the machine is
> dead.

I see, thanks for this information.

thanks,
Chenyu
