Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E234B7AFB91
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjI0HAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjI0HA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:00:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46186121
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695798025; x=1727334025;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6qdoHHVQvkPFndAfC60jnm/aAzdnxJ+8cd+wew8jx70=;
  b=M7sYsy+GENsOdcXKgZwJVb7/Br7f/ipfiZqi/YFmH/7oxaQWy1fycA+v
   ra9RWKF20dI+R2+RFynv2uAN3BjqbyN3V4GmrwF+oSreThJyVo5c/DDo2
   MP5b0gjDkKLsVW5hu2lOEBn6sLxCNwNVKHdXpI1hRybhaOaz/Ed1uOwhm
   7vcR8cPkKAUCyfYc4OwZxXfU85fF/vcmh1F6jv61XvlKaNjj9wUByP06F
   xBH/lRpnKfksfqxd57QzPnonIESX5CNrbHNqzzhvSLk8Oj3xgBz9N9Z3x
   woCCqVapgTcgamDlEM8Qv7p8Targr3WZtGzObuC4t18u6Ly3F4XhyMr99
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="372084240"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="372084240"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 00:00:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="892490710"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="892490710"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 23:58:50 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 23:59:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 23:59:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 23:59:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+hciKx9KqvhsT4bfdM5bT5CpxMTR62Fme5OFlxugoV4ja1EQ9l/C9XbCZ3UvBtFLL+Z71C+7XhtGFWCzbFpZlpPvJlmKqUW5sojg5eIqaZ7i5GiYgDvhI1ZNX7QEADNX4zSzpRiOAfH3pEYKRFQOJPj1rL/BROiQlXc9TmeAcHSOJaqWKXhYBuY4DCnHAo6mgqEJYdlBnIQu/8xFvWmdhOM7EOPs8bC51O09veLT+lqT3/J3xRavKyDXqSR8OMbnbTswC2KbGbqsJipXtBAg5JyxySBs7GWF9AitJgXmCCwdz15aEZIIcl6oB+XBolR0u9XWgTcCXUw381ySjL6ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiimW5T0tdunDUu/IPgsWWstPkREh3zwXDdNjdbVpGk=;
 b=VoWYznIF59g73wndpCwlmvFPcUvUyNwN6dnC1Wa2EEGpD2iICA1v4vBmaH8q9xEJDDWrA4VSDirv6w8dvOJsyawsctosjgqcJ9BRuG/FzzJfivv70y7nBDrQUuZ03IHzLunrjKL4PU87OOr1fB5Czx4MaOJxfVtejX2jRtkA6+ucPsxRZ6P0ZNZiH03e+7mGmKmaoVJEPdw1I4f7WXOHls+2BmCQ2UjZbdAT9ygWhOi4oY0Fj/5FOPFDzm8p17PfnVan0LSwCcVdPDn9ejuIqde/NMd/8kOCLiWBbfNpaihDTls/OZfvclfHnX7H0V07h5nIFBSihHM/7uNV649bEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH7PR11MB8454.namprd11.prod.outlook.com (2603:10b6:510:30c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.27; Wed, 27 Sep
 2023 06:59:48 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%4]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 06:59:48 +0000
Date:   Wed, 27 Sep 2023 14:59:29 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
CC:     David Vernet <void@manifault.com>, <linux-kernel@vger.kernel.org>,
        <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <tj@kernel.org>, <roman.gushchin@linux.dev>,
        <gautham.shenoy@amd.com>, <aaron.lu@intel.com>,
        <wuyun.abel@bytedance.com>, <kernel-team@meta.com>
Subject: Re: [RFC PATCH 3/3] sched/fair: Add a per-shard overload flag
Message-ID: <ZRPS0cQo0/XcbkOj@chenyu5-mobl2.ccr.corp.intel.com>
References: <31aeb639-1d66-2d12-1673-c19fed0ab33a@amd.com>
 <20230831104508.7619-1-kprateek.nayak@amd.com>
 <20230831104508.7619-4-kprateek.nayak@amd.com>
 <20230831191103.GC531917@maniforge>
 <258c9412-445a-04f5-dd0d-1f6699a257b6@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <258c9412-445a-04f5-dd0d-1f6699a257b6@amd.com>
X-ClientProxiedBy: SG2PR02CA0074.apcprd02.prod.outlook.com
 (2603:1096:4:90::14) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH7PR11MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: d1272379-51dc-4539-2640-08dbbf2756ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7oefXFtoqxk+WsBLrGjee3AF0+9g2GSPmJoZs46E6md7lxPJ9ff9aoio5X/YSEOX+cys9Ynd7ChABapj5i3UC3d6+oqMG0mR9JZ/92RtYH3kXgLVEp78zKyl/J2WUKVgHcleyUtdcbqb5w8agsq8n0hHeKA4i1dzjbmKdtSXJ36p0UAPP9Nhcb2kdETF0KogsSGJ6amjdIjXwNmTd/H7ONvnqtDav9oIxcxH/vsTirEFJVNodbkjkr3SrPUBhapz46GIWbjHV9IFqDfD9tgkommka1ah33s7iSeOzctOg/O4h62A35hoAngFO0sc3xTwudGfZfQZjLmro2b9moFYtSQEVT2sYkCkG23UdKeiffCs10Dp9JUVIdR5QExbnsAHHI9NpFyhaCCx04ZFL6ZX1zM8uZV8ULKiF7EOrCEDA7XThv6VFGxx4WAk7qZ3kf0aeRWVX3Mhiw+7bNbBgB98x4mZrjBhpsF8oQfgqbhN65XoDivjAe+icUi+nJvV0e+C4evlN0CxzsclcZnVUaIz6/MICOP+eML0jyqY2JkJJ9Ahv7JINzpg9I1FehaVW31z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(366004)(396003)(230922051799003)(451199024)(1800799009)(186009)(7416002)(6486002)(83380400001)(8936002)(26005)(6666004)(8676002)(478600001)(4326008)(5660300002)(6916009)(2906002)(66476007)(38100700002)(86362001)(316002)(66556008)(41300700001)(66946007)(53546011)(82960400001)(6506007)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZBpQ0AnFdtwGkTvN70UOkDXdJxRVL4MBzTEzL1NZOzUE7GRLoK7l/86zYynA?=
 =?us-ascii?Q?5jUyMA1Eatq8VNwxgI4cO/pD7xLWDid/7S5SI4Or1hs8aXCMnNYxMoLaXwd0?=
 =?us-ascii?Q?UWEFSQk8RTPI+61tTPOxhAHWoe3BZTUcmx5MC8JU0SSBc6FPN3MMR0Bc1PU4?=
 =?us-ascii?Q?5COIaYbPlMnv6m3zA7e6wgLHN7nmTY/6HRkd5gVR6OWtbgcs/EYQDAjNnbsV?=
 =?us-ascii?Q?blLpvFxdANB8X5QNYF3Mg77RucKAWkD4G0fjKHnMcz6CAeop3aA7ZeISZ5uH?=
 =?us-ascii?Q?PbYtUhRbkK8x554Q7AeBmK2uuyWRPfsxt6Q2U32o5o8wJExAPI0JgAmWMGZ7?=
 =?us-ascii?Q?n7i6rlNC/anJM9SBxbCReCgkcDc1iUOvPEu+JwmXnYOvSXWnmwMtMXyOAfmx?=
 =?us-ascii?Q?nI3lNePNV/trZb8t5Yc7sYiBR+yCiA02TTX2Rl36oQJOVLdgM6BVhMxSbSis?=
 =?us-ascii?Q?1KyhSLqN+LWOu76Kft6TxVPvpcGULcngAisbxB2wnIuUyy3mcATc1wBYFLUS?=
 =?us-ascii?Q?m653y37mHAimfYrC7Uj/K86C6D4zCXb7nxplf4nJPMZBLGVIoc0tafGCSgCs?=
 =?us-ascii?Q?A0d7D2Of10lxxWmo4QIEjRyr7ykU+i0+rJ8WU+G5al37qtm7azo/VUCRj5XJ?=
 =?us-ascii?Q?ZIqlk4njAqxvWfnpPsCsxZg8XTvJ2FIsd/R5RLo4G32h2pGDp25pBkRs0bNc?=
 =?us-ascii?Q?x3G11klBj5bc0h6M6wLZJl62UFLe/OP8XO0rU2RWOjS0qOUDitcypTU69xVJ?=
 =?us-ascii?Q?odmwgX6COpWGQVFkFOs3YzlO93ND641hDIXgWs4hb6GNe576Wrfhw4QbicSe?=
 =?us-ascii?Q?UWNI7sz11/rbBqr0/KpjOb8sD5wa/JXH11XHlZI2UN0FP0B/4uCGNWGMi7Aj?=
 =?us-ascii?Q?3LgsbRWofhUrUFzLxSiKAwMbBnRzS1mXWQNQTRUrWRAjMnS9f+pE5ZKH2lNo?=
 =?us-ascii?Q?xOTE1d6f4dLDfPugwHQDs9+DbIA/nvXK5W8eNi9N1FYOUNy0F7k8TiJf4Ngy?=
 =?us-ascii?Q?vgMwrEaVNrt4iVVtg4DQCU1+XQ5uiQBwySHXbxxGLTXSb74ObgTLpiaz+6Mo?=
 =?us-ascii?Q?5oKuhq3cE5m8BP7mB88uggKEH2f5+aJUhYTKtIH7D1MjHQl06Qy7xMQLg3gD?=
 =?us-ascii?Q?4Bt8fTWU4hhip0iGxrX1IxXobUfWUGPGpqxsV2MHIF5PdV/FZQnzX7HLBcnl?=
 =?us-ascii?Q?zAzY7q0yZpjCzhpg5smZdo0ngKH6hPaxLl2IH4TJw1bbL57KnK+X/EAxlevT?=
 =?us-ascii?Q?7OePKbb36PMUnYhWdmDYRNLbfswH+huQqB4ZQgGDd7o2aQjqSnNsYvW0a6pU?=
 =?us-ascii?Q?mjyb7FuzmoXU8KuD/HLMWcRJH2wan9O9FL+nad21trdhleZ8BfGnCbGLiPQT?=
 =?us-ascii?Q?3zngh/nbgiiP5WhTOD0YIHQJFYZ7BALZd+XhqdYRQMMqBsQpEXZM8oqtQc3m?=
 =?us-ascii?Q?kWwLqOl043KbiKa+rTop+vjv6RknhX2lWaGm060tnXw4N5GKIotvD5DvBKwa?=
 =?us-ascii?Q?YXjM7Mp+t30Eiq892nkFEuiU4Vp9MdrQrbjgl+4AVcqkND/feMlRs3boIGqH?=
 =?us-ascii?Q?HMZNH+pvivOb8x+fSPCntuPQZhePesSUqgkg5aqG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1272379-51dc-4539-2640-08dbbf2756ae
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 06:59:48.4231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79PPUQC1BKvkglvJ1qXprJfpldN2zxkacrmDl/S5zPJXchJfmKijJrPQaIrnUL+du6freqwGQEbkDoip5+VLJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8454
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prateek,

On 2023-09-27 at 09:53:13 +0530, K Prateek Nayak wrote:
> Hello David,
> 
> Some more test results (although this might be slightly irrelevant with
> next version around the corner)
> 
> On 9/1/2023 12:41 AM, David Vernet wrote:
> > On Thu, Aug 31, 2023 at 04:15:08PM +0530, K Prateek Nayak wrote:
> > 
> -> With EEVDF
> 
> o tl;dr
> 
> - Same as what was observed without EEVDF  but shared_runq shows
>   serious regression with multiple more variants of tbench and
>   netperf now.
> 
> o Kernels
> 
> eevdf			: tip:sched/core at commit b41bbb33cf75 ("Merge branch 'sched/eevdf' into sched/core")
> shared_runq		: eevdf + correct time accounting with v3 of the series without any other changes
> shared_runq_idle_check	: shared_runq + move the rq->avg_idle check before peeking into the shared_runq
> 			  (the rd->overload check still remains below the shared_runq access)
>

I did not see any obvious regression on a Sapphire Rapids server and it seems that
the result on your platform suggests that C/S workload could be impacted
by shared_runq. Meanwhile some individual workloads like HHVM in David's environment
(no shared resource between tasks if I understand correctly) could benefit from
shared_runq a lot. This makes me wonder if we can let shared_runq skip the C/S tasks.
The question would be how to define C/S tasks. At first thought:
A only wakes up B, and B only wakes up A, then they could be regarded as a pair
of C/S
 (A->last_wakee == B && B->last_wakee == A &&
  A->wakee_flips <= 1 && B->wakee_flips <= 1)
But for netperf/tbench, this does not apply, because netperf client leverages kernel
thread(workqueue) to wake up the netserver, that is A wakes up kthread T, then T
wakes up B. Unless we have a chain, we can not detect this wakeup behavior.

thanks,
Chenyu
