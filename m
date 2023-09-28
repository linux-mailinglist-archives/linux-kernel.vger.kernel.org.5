Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9097B1639
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 10:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjI1Ilj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 04:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjI1Ild (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 04:41:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FB2193
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 01:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695890491; x=1727426491;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0FQJGbWXFcIP1Em3P9B6DCDr/8uj5UOIoKqYQl7Gmx8=;
  b=GiCzv5KCwd6GTRVykNwuA1TMmofiIx8KyEJNQoRPAftILrafP3MgiXba
   AD6+XnUM1bXVlLhRdDLZFKwzdaqs71ZoFgq5HT7f/kLoJZVR7zf8vVibA
   stIIlMwT/QRPJAXYLerh4AF5jcnZDvK8qDa4nP2Wijy6ucih2MQbjs1h7
   PHWJSA/tMwEN34CYvbLPrgv4sUwYTkA6Y6XuPg26W31U3hum6r/ITEy2O
   kGU7uwa3mk/+YcBBYAxm10hzdU0i+DU74xwFa4TEFOpjKML1G631a1/bx
   idAxrpAvxHSQKkQaJlNm0KExOTHRhrJamEURJsvaLdFDbxcCOfnJ98V/3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="361387961"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="361387961"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 01:41:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="892950441"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="892950441"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Sep 2023 01:40:21 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 01:41:30 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 28 Sep 2023 01:41:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 28 Sep 2023 01:41:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQ/UphG75oSfwC7OTLkXMPWeoLdZRYwHQEVPxvimO+7PWjGiu5nAxQN/X9XaDh4l4nEk92xnLF9eIu1blAL1i+oL3g2asXxBB7jn9DaWJeoJl0QwPtViSNBAvJrDXh7Ml8lxGcrCvSR/iGEEJ5CCpDJWzL5PFbqI4eLNKAq7zaqJ5dctrn5D0qw26wuLf97gAdI6rapozXZsMiGnhhgfpHfjkeHJjlh5v5I+z5TpFf0ge2dBz7t37bIM7ahKzXw1lhbGGuebB3JuofIKPuPHe+B8i8jeeoOq5xpiYYo9Y6m1rCZzpe75EHBG45aLiYZGoOiaL9wjEqLwz7ErWeS4jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYqmCHWXFwUS1/Wbg0s+lNGaj5aeUkBKjhryfCj1vro=;
 b=dTFeH5HMam34t89sYKKmPnBA5UqWenwqOfzVN+s+yESCgPLaT7/x1Ok7SLfdxGPenr0u1U7Lx6+Un1aOEb5g0/y9pw60Hzw0FkJo5bEdGqjoZ9cKqDObC/20Fc54T6vzEfoWxgUf55YXVO1iHl5cNmysBEUvDUVMoyJ3jNbh0haiZ/yevcS7QDzksheKPnz9fYXV6udm3m8qntLJ/voxbaQby4lC3SFZnTl2ZWIGV1u6Uw9VbVAzgYnevekOEcHvZk/YPupgbFcoACLecdZDI/cvPi+XZ6XzyHXNWmGtCy3Bvkay2l9gffRpfLW6UKkPLG96YPE+zonGiq4I4uAh5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CY8PR11MB7800.namprd11.prod.outlook.com (2603:10b6:930:72::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 28 Sep
 2023 08:41:27 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::9474:7e9c:c157:4ee9%4]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 08:41:27 +0000
Date:   Thu, 28 Sep 2023 16:41:10 +0800
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
Message-ID: <ZRU8Jt1TzOD2pOxx@chenyu5-mobl2.ccr.corp.intel.com>
References: <31aeb639-1d66-2d12-1673-c19fed0ab33a@amd.com>
 <20230831104508.7619-1-kprateek.nayak@amd.com>
 <20230831104508.7619-4-kprateek.nayak@amd.com>
 <20230831191103.GC531917@maniforge>
 <258c9412-445a-04f5-dd0d-1f6699a257b6@amd.com>
 <ZRPS0cQo0/XcbkOj@chenyu5-mobl2.ccr.corp.intel.com>
 <d755d515-e5d6-b3fc-f7f5-9f8aebcf913a@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d755d515-e5d6-b3fc-f7f5-9f8aebcf913a@amd.com>
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CY8PR11MB7800:EE_
X-MS-Office365-Filtering-Correlation-Id: 51b93546-ddc2-4214-531c-08dbbffeb422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gcgLi7F8Pw4pfIV1VMxSOoLLtd2RqZK89yFvJmYDpTPGvnU5VHeCAuPqBVOuzsvHKQRJB4kl7OtQssEPqWCWGHI/ySY0uk/Nv6dq7NhwKbSTQmouGxvKTCWZYueVrQcy2DBbpDfb5yObd1ykelsFY1BKyqW5kp5cNU9/VRdOpwbkFWjKgwSIJt3ATwtJye1Qs3fOg5qX0G2woJalpt2++srR6qpUunqG5ZW8wFpuKddgJHnFSi6wkXn+QULj72Ojvs9gPP5r+lQVM5frf62Vo89WunaoGMvJqyafOAjp2LhWQuDoQc50QoWu8qVZlywpY61KiTYKzkMOvcYptOFRzehWsTKEzIRpF3Kj/DQzqk1VQI3MCRxDpuWXwZtlTZpys0yPn08Qtt92NuJPl9q2HF0Le8mNvTKJV+RzZkfLRQ+FaHkvacMxIwl3inwheeIhbXEvhhGHCQK/LPiEB7IkQ6kC8GW09VPpB5wGfjlo6x21vYprobk1YgulBiqxSGB8wv+akWEEv6tR9iiax/nii6SUBQ3J+2ufPJXATvD1CNU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(41300700001)(6916009)(316002)(66476007)(66946007)(66556008)(8676002)(4326008)(8936002)(5660300002)(7416002)(53546011)(6666004)(478600001)(6486002)(6506007)(26005)(6512007)(83380400001)(82960400001)(38100700002)(86362001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hesAEWAy70ljHnQRb6eXOCefqcd0ZPFKm6nJVmpDhQB9VHv6yBRdhbRy7K6c?=
 =?us-ascii?Q?GZObxIr3cnmd0CUPy6p1JEUn+YYhACxmyYpBalNFeY1rKmDrpuBvER5UUrjh?=
 =?us-ascii?Q?SiNURL7cFaje0yH3ioFTEpD5cxvIpPiFdIgWEPYQZybXeBFo75hJct0HRAyl?=
 =?us-ascii?Q?bJA7LbZAG6v+pvlu8qsVigf2s5HMT2NPn/Cokz8V3Mm1k2pLWKmUxiphODZ2?=
 =?us-ascii?Q?VuC7MEtYxwRsNkbFrulpEf39IWeE8z4jdXvJUCxq/Jt9oZDqsmCzfuVZnzVz?=
 =?us-ascii?Q?DTy5CIQFno30CNuwl0iYkT5S2b7THx53gugiL0Fsfm8r1+RFVdt5uAN0h4dh?=
 =?us-ascii?Q?KCaeTlVXkDN1OdUUeIZGrnT7hv/+HdR+pRzTCQS2BJdJGhMPgWdw5hNmPC0h?=
 =?us-ascii?Q?7uGle9WAl7HHSx+Bfb5l3H/XA/N/R8Yvwxc0Pj9+fvyaZz5hjWA/j6psjB93?=
 =?us-ascii?Q?teKlXVFFRCDhELrCMhVK1WRNZcsjWeYNwSlB2ERE7sCeBUmBuj4N2mpTEMQ8?=
 =?us-ascii?Q?4KSXLZGZYx61QPBKys14wRbQndiL0C4+N4puFgimdlAWnrKXmU6nGcvhbXqK?=
 =?us-ascii?Q?cHEjdRfe53p63HqRVnmxnNHK8huSoDLRYhp4S6A/3lO3JHaJfgL6plbMud8i?=
 =?us-ascii?Q?Z60ID9858JcSPouAR9y7Ob/Fhgx5FiSjDaSp4XfBhRjDwxI4IeeBhjM5n9kf?=
 =?us-ascii?Q?SUVspNvBFkZHXR8MbQPeam2M+iHGae/WAk/HkMr8BEvkoSyw8xFR2Y5anFDJ?=
 =?us-ascii?Q?RA+9GRvSVR7D0SgXBQbmii24x5k6Q5eqMVWqwRZdM78FiBWvbgeiKgF1QEVd?=
 =?us-ascii?Q?4+wFW1b4M4ccmyqEhcANdNKDPNwz4xF1piIPeh9OG5iVb49pg7/70TsCGk+m?=
 =?us-ascii?Q?UctWYlX/Fq2alDA6crtXBFOUu72OVEwO8QfAuEVOGtOTi7Vah4W/QzfNyQqv?=
 =?us-ascii?Q?8b3O8zka9cC+1PF4n4JnkE80ipgA5MjypoA0zM9NSzZkRemELESL5f00fbqv?=
 =?us-ascii?Q?QuDZMiP1a7wiQnDcp+YejXzKNf/hCK17P2gWH5qKnk9b6MmeOSiRp5XD4Lyw?=
 =?us-ascii?Q?2YQMa2LUB3IfHXlhnIjwvqMuOWlw7ieYebc6puf9eao4IL1Y/rTdZ+nbLiUu?=
 =?us-ascii?Q?Bf2fdHZ9phZwsPaRrLIpW3OG+A3mXUBMMITCDfhQ3dQD7dkA/BwySl83tgIp?=
 =?us-ascii?Q?yfAVXB50iw4do9SAPtc6A8zmXulqag/NGMD9yJTi1/1gaX2+ZMNWimjqDaKw?=
 =?us-ascii?Q?LU+tPlrV/Vc4d9tnfmeRSxfa3KBcIDu2m/SW59DoRIMr7zRGj7NCFlTn79Fr?=
 =?us-ascii?Q?3RCiDiroLDcVoCreLbQEGn9HGLJef52h/LHtntrIEQbj2hsbsap+vVgnuGal?=
 =?us-ascii?Q?KX0E6dBes8ptvYOG9Tfmhni0AZs+wwi0Ei8sRRyFcQnVwj3TGcnm0xSOBZaF?=
 =?us-ascii?Q?FKXv/n2leCjEKDG6UVdkwSxDn5d5HieNzmoszf0kA+rpkReN/bm6yaHgHPWV?=
 =?us-ascii?Q?N099i9Ooi1M9dr+SxqG4Hknm7CEKvP+d9WDsimtvDwSj5eFjmLbAhM+sit8k?=
 =?us-ascii?Q?exjIo4P8m56yksrEMdJM6L3mwnyNEpGq2hBaVvmH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b93546-ddc2-4214-531c-08dbbffeb422
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 08:41:26.9231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLAXmaagKffDRnt+drm+E1DQgv5Yafi5m9fN08Z63F2V+J/iMDqL0wRXcB/bIFgh48R/oAM92kyoxoQqhHZLmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7800
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

On 2023-09-27 at 14:06:41 +0530, K Prateek Nayak wrote:
> Hello Chenyu,
> 
> On 9/27/2023 12:29 PM, Chen Yu wrote:
> > Hi Prateek,
> > 
> > On 2023-09-27 at 09:53:13 +0530, K Prateek Nayak wrote:
> >> Hello David,
> >>
> >> Some more test results (although this might be slightly irrelevant with
> >> next version around the corner)
> >>
> >> On 9/1/2023 12:41 AM, David Vernet wrote:
> >>> On Thu, Aug 31, 2023 at 04:15:08PM +0530, K Prateek Nayak wrote:
> >>>

[snip]

> > This makes me wonder if we can let shared_runq skip the C/S tasks.
> > The question would be how to define C/S tasks. At first thought:
> > A only wakes up B, and B only wakes up A, then they could be regarded as a pair
> > of C/S
> >  (A->last_wakee == B && B->last_wakee == A &&
> >   A->wakee_flips <= 1 && B->wakee_flips <= 1)
> > But for netperf/tbench, this does not apply, because netperf client leverages kernel
> > thread(workqueue) to wake up the netserver, that is A wakes up kthread T, then T
> > wakes up B. Unless we have a chain, we can not detect this wakeup behavior.
> 
> Yup, unless we have a notion of chain/flow, or until we can somehow
> account the wakeup of client using the kthread to the server, this will
> be hard to detect.
> 
> I can give it a try with the SIS_PAIR condition you shared above. Let
> me know.

Thanks Krateek, but I don't think SIS_PAIR could bring benefit to the netperf/tbench
since SIS_PAIR can not detect the chain wakeup.

thanks,
Chenyu
