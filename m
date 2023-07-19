Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E119675981C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjGSOYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjGSOYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:24:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10B61986
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689776619; x=1721312619;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zHlHpxEklNtVHi8zaxu6DQD5fptiq8BycOi5SkO9gT4=;
  b=BBFLF19aDsjRiYzqXGlYyxRN0kcciXUYJI4zHY/yPROgf8JxTW+dPqiR
   ZnzVEUXpEZQLKuVCt7x5/U/+3DnmnC0rm9hQr6lQwiPWe6SzJxeP08oEA
   MAeLnm/y4exd7WUbEEoE026HGYR16MlnTmNZtO/pqmdyuivAnMqMxvcbd
   JS88T8BQ1AjTdeVpSKRA0oCe3ZOhk0HgFho3G5ZpQoavEKd/slwD+NZia
   g3g55rMfSbOo3WIGuMA7sTl8gBPy99uItLKfjpzexrbDlde/4pM7w/Ffe
   BrZtsdif9dfSSQFFJWyLVIOwnu7DFF4PVZTbBuc2sPnnk4Efq8RVMXClQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="397338601"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="397338601"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 07:22:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="848063114"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="848063114"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 19 Jul 2023 07:22:57 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 07:22:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 19 Jul 2023 07:22:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 19 Jul 2023 07:22:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSKgiekb5fAN5Q5q9fvGVGlB3ItbkrKmO6+8Y2rKCb+PsvE2O4LeGqmsp8Sdj5gFjlVl5nx+463qGQTwxv1wGhAX2/oB0sosQ89DzdJIcBBRSGYIKYOxWDbHAgI6dg9Xu7ubliIQw8CMfgZ2aKvsEMamrP9BKB0wMNRM721EnK93XNujeB/fUnmubWHA/gqoKY+EwrUVVi175W2Yr/geht/ERQj4qgRzhl6hRGsdN3QSD5+lTvpjiECHXFzANxt1PQwIROLL2awrHpHX/VWXCVNYJn+Hpfh+3OiC1L0pcLNFNIYRoC6sKjM/nNhrKW6dAeC8rU65v4S2GnzaET+okA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4erQHh7YIrWLh9cGM/gjMicwV5JVSnB8VSA6TNePwM=;
 b=SENCgQdZcekijquKXgRh/3e4NQzuBmphvjQbboEVYBbufV03vFhjKI6EcbI1aOjPgsnW1ZVmGuQAtT+cPudh5Yd4O7PFdpupGK3Tw+mXQIn4mAtswFSujn3yL2KfzmpM0Yjr/RKjx8s0zyrSqhfSNj45DFa8HaI+1OGtroWo8fDB9aMwqjyeZgUwmeFqggkX9NwHqEhwSlHCmW/Dlf6LPzwsALyREgR0umQQMgCgFCQogn39sxkYofR7gm0uqy8wrKV+R6Xgde7ztpClycCylYzmS49u4yjm6nw8PuPjaY6M1QJqzrbrpVlNM6JOSI3FRAoBMiI/YPCGC4X+8X2iKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB3060.namprd11.prod.outlook.com (2603:10b6:208:72::24)
 by SA1PR11MB6823.namprd11.prod.outlook.com (2603:10b6:806:2b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 14:22:54 +0000
Received: from BL0PR11MB3060.namprd11.prod.outlook.com
 ([fe80::7196:1728:580c:9eec]) by BL0PR11MB3060.namprd11.prod.outlook.com
 ([fe80::7196:1728:580c:9eec%5]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 14:22:54 +0000
Date:   Wed, 19 Jul 2023 22:22:35 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Waiman Long <longman@redhat.com>,
        <linux-kernel@vger.kernel.org>, <yury.norov@gmail.com>,
        <andriy.shevchenko@linux.intel.com>, <linux@rasmusvillemoes.dk>,
        <rppt@kernel.org>
Subject: Re: [RFC PATCH 2/4] sched/fair: Make tg->load_avg per node
Message-ID: <20230719142235.GA94215@ziqianlu-dell>
References: <20230718134120.81199-1-aaron.lu@intel.com>
 <20230718134120.81199-3-aaron.lu@intel.com>
 <20230719115358.GB3529734@hirez.programming.kicks-ass.net>
 <20230719134500.GB91858@ziqianlu-dell>
 <20230719135305.GC3529734@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230719135305.GC3529734@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To BL0PR11MB3060.namprd11.prod.outlook.com
 (2603:10b6:208:72::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB3060:EE_|SA1PR11MB6823:EE_
X-MS-Office365-Filtering-Correlation-Id: dee805bc-bc9c-4bfb-4471-08db8863a457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVoh2TguvbdgQYM/uUC6PkuRD+Ach/IcZ0SNr2Xn5lw1JKufKv/PAIPWvB+E0gGc4gTntTpUnAQZIaHXNYNKEbaBJLxZ0EwNlMDptw7qpoZ8D3E/ulMeXd02vx/KsNcYg2rKSL7hNfCCQdhKaKKwMnCFbxyYeYpOdmgoEaBCYTgUHLJ4T+7eWcjj8wVC9OHwbNOXBpLgdwYvNE7gVWuVjq81L8/ATlRiGLvdjs0TBwO/rh1lQkFZ8nLWN+GHvQAGn+oQnrUWVYDNY4EAq14+N0KrceNJKMkuWZycN7thhWxg2lecsaL7tABMpkrKmgzBucrMlRHX0UEx7p6+mwz88QCg3Zco1crWypTX+EccMhPTaJA+iDa+/ELlMLJLQMU7YM22Bt45JoO2vnur9GcNmithuCoEIWgiGGkH0xU5SoeP7ba97xLHuLoAOpisAA8ijp0M3uZQHAVfM5YRfaBugD4/ZRHgMLYDKhlruQol45lG/xC5FAmsm1KjQvHS2cuW5qOXYVa7bOrUDkLu4dbMvfFFF40TZ7OCpv54ghIROmwr0pszNKWvEfJigO6P31wa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3060.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(136003)(396003)(39860400002)(366004)(346002)(451199021)(6916009)(33716001)(66946007)(4326008)(316002)(86362001)(38100700002)(9686003)(82960400001)(6512007)(6666004)(478600001)(54906003)(8936002)(44832011)(41300700001)(66556008)(7416002)(8676002)(66476007)(5660300002)(1076003)(26005)(6506007)(186003)(33656002)(2906002)(6486002)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lb9D98PKflKjJ0gTyukuBNUwHW2jb1yWlYrJbLP1RmZ9M8cMnMepCUB/GNuc?=
 =?us-ascii?Q?f39GLKl67HrKHDevf9HgFV86/u9UbnETnLqbUpb7myM+t0s4epvzezLt3DxK?=
 =?us-ascii?Q?M34JHckBPi0O5NOz5yhx0+MdsnDSa9/FhahJTY+zTGYKcU8X+ORdis/FBzng?=
 =?us-ascii?Q?1zfDsIj5lxc5t3xiWeHEnDQpQu/07Am4FnqXDKlDm72wZ39y18OLOFr7icIB?=
 =?us-ascii?Q?qjqoN72JD+PTcu7pgb0mrG5biWBI0u58FoMf1TA/p+tlU+VuTe/BC8AtZe3w?=
 =?us-ascii?Q?ddGx4Exod9v2NgO5DlobEfDjVpEkzBnjqcSKXHM1VGc+Kb8GIOD6YZrF5NM7?=
 =?us-ascii?Q?jVd3wxrom4C63OeHPmK5t6/dC049SBqnnBXIpvrPBDrf5yGYMa9h0LrdnWfF?=
 =?us-ascii?Q?PtTuc+41PsSbOOY+d4PWc3HcmxX0ZpLb3Qv6Gzmkp/nD12r2w+T8gp1TAylo?=
 =?us-ascii?Q?VceyRYl87tgO0qdIaoDpKNibP6gHy0mmxT0vYEY1q7/ilV/QERLUYMauHLbY?=
 =?us-ascii?Q?J6b2H2MYQA+KHbgPy+BH8j1ltpLsDXOvNlPmgpWX47rmcC8uI7KRpHnGTdqa?=
 =?us-ascii?Q?kQXIvjvMM+9/M081HXds9AWpFINn8f2Si3ypwjPhlb05ZyeXuUqzfLaU4T8z?=
 =?us-ascii?Q?UbarNGqwzMdkfUbE9MxqoUwauC11w7VNtT+8fRnqpkIu0iElnllzNJwFYaqt?=
 =?us-ascii?Q?1JIOGyytJ2uxXZHxSzc41x+6VVw8qyETcl6gb9POE1+WRPF7uXa7EiGDEaW4?=
 =?us-ascii?Q?/JDnUqtzoR8B3IaqshZ9Gm1G0mTyxCzpq126wyS933u09b7mcxokxx1mDjf8?=
 =?us-ascii?Q?zlDeyTG1paL/I+w7U91iDdiHTuNPefNvnZiyAaxlMusZHPGoeei9WSobMdb4?=
 =?us-ascii?Q?C8uaZM/o4+hIUk5LT5TSpwVulpIiOwFaVea0h3qpw2qF3rPJgcIjKhTinRNg?=
 =?us-ascii?Q?gw6KxoYQfGXZmud3ewBmysDegCktfuKEF8/51zVA07zqQ/qBKXMeP1E94PGS?=
 =?us-ascii?Q?SMVUjYEsdgzFM3E5LS0tA9KbGeZ2qqAdlTfP6X+cACnssW8AwyM1XuZk4I75?=
 =?us-ascii?Q?Jx8kRhduVck+dVET2eHyDAKvq0F8jXW4Lf1ywSwO95IIo05Wv1epLuLVos88?=
 =?us-ascii?Q?2RQdXDrQgPKR86UFXU52YdZWtRebsgyEkQjqaFJEcl1nKXIIEmhwE8aG8vGa?=
 =?us-ascii?Q?U2GtZk7+Og3e9a5WM09PBAt4B/22wU44Nso+SBKMeL5spmHteSv0P9LgVFzV?=
 =?us-ascii?Q?Z2myd3XDjndbYI43+EUXNy0quevueBhkewripP8YT+IwUhklfETuQdN3vl8S?=
 =?us-ascii?Q?UyjueTkMoTn/Vdj76Ot96GI0Yc4hAhpaBIScGFKEszMfy0pQ547P9OAD/7q9?=
 =?us-ascii?Q?Vc3AGfR9vxStCC8KAengeNoXuq68JefxnAm/mkl5sNKhQVc6OYDx3qniU7YW?=
 =?us-ascii?Q?t6tm2fzaYsqKGvtQXrlbt/iuDpJGtmuP6EEBNejS/Vn6+pULYVYScl4j3dmr?=
 =?us-ascii?Q?PD+qOLv+f099wZbZvdVJFNexGcWl76ruaY+tf0U1tJe3SULT5Thvdbez0Lc3?=
 =?us-ascii?Q?WlqE5AfGyjRVrsESeHx/iJ8kMpKjR1XTL8QRrf78?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dee805bc-bc9c-4bfb-4471-08db8863a457
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3060.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 14:22:54.4795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCAM/JbXliqwlOAwRHmMKhJRM8M0p90CcMA4hKgiq7Ni03y/DF5oxjdEjtQ9AK6QiXTzIbwpq98IihuKogeljg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6823
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 03:53:05PM +0200, Peter Zijlstra wrote:
> On Wed, Jul 19, 2023 at 09:45:00PM +0800, Aaron Lu wrote:
> > I'll rebase this per-node patch on top of below diff.
> 
> Oh, please double check I didn't wreck anything. I skipped 'converting'
> the find_*_bit() functions because the users of those iterators might be
> expecting NR_MAXNODES when not found.
>

Sounds more work than I had expected :)

> But perhaps there's more I overlooked.

Got it, will see if I can make it work.
