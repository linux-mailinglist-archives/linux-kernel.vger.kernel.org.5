Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312E279F200
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbjIMT1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjIMT1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:27:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE2DB7;
        Wed, 13 Sep 2023 12:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694633226; x=1726169226;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=getsqvkBWu3kcXcFLnVerNsmXgk1UKiCp2q704vi8FE=;
  b=gPmIoZ55TzwKWCqXllaqOznOkTtgYR3NB7omYV3QJC0LsDZM1oFtEjpJ
   wc86roVFWu1mzrp3PEnX0jj6HRhE1MWldEr0ZF5YYO3RTHettYHMCH2bn
   Bh2U5TPsvdm4s8urwYIad9tk7+KliOQnCqVMV1dXaw0PvbWD6XGJHzWXm
   yMhDiFEIUPdjtLHnbnWOqljywfOcLkLj8w+o7e6jLzJh0yoifO5XgtnE6
   HJ0rwApskmvKqM0uiOWdHA/TmSW2TGpDQY+Kcuuh6zmav9Ui2Q6oz+6rq
   7n08/QmgmsHzmpY1p0+7nGmFX1ujL6rW5Scm59bYpuXSGnDNJzamogSoo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="381446963"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="381446963"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 12:27:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="1075064150"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="1075064150"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 12:27:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 12:27:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 12:27:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 12:27:04 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 12:27:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CssORK1k9L2S8UZlqMw5EYkK9ZoT/FOs7LwScjBVcf56b+BQQFzfqPDD11O1Qbsawtsx/TZ4bnHb6kqozReGj07eE66yLcNIyhy3kbqo7Gvx5Bu/q/H09Uk5D3BD08BLxmuZ5CTGoNo5u3VdldHkW4p5Ue4fKgHpmx3CD8Urzy/bdaejGd3zmg3vH9iEuPrEqjftLKv3eBUlLrnKG9UYzIXvnVveWOuWp9fsznuPhiRB2cyYSh1GeyuK9vUXkqL4y/MWWnmT6q0AXzklTMPcapXXa5rHG9ud3TcK7lOv69sO/abRtZg+jVy3TtU35zJFwwJfgNSBQvZlCODmUzSWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7sURWxlykVeVM/YruX4PI2FQVbF7OyRqqvCyhQXErI=;
 b=lmio415mFNPjmMqI+HWdeXOxJjzqT6vc0QLJwIM2clTyrWMxW2A2s3c8Xqmtzqtb7dyL6UIop0iXvoLDslM+Wb64MRftNXj/9ip8LNHPaSEBOgpAybnmXBf+pLeKIiGqv82g3MYqkGfwjVeHc28dZ5lJx+0pvxIQyVRp4TobAOgEWhr8io2Iv6FJeOsmK8IKZl15ZoRyc/fVBgNmbY7IR0O652bEAR7sRjr7drOjJq9MBNJvrg5VHdDxAwHNjFKSw1cOzqKOL9MxWBiSkQYaErmxEAYqjDZDHQ39thaT2W6oL5zLmgcUB2iteb2hoQsmMeWVEJYg+W7d9WtPRLaJHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB5600.namprd11.prod.outlook.com (2603:10b6:a03:3ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 19:27:02 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 19:27:02 +0000
Date:   Wed, 13 Sep 2023 12:26:58 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 14/18] dax/region: Support DAX device creation on
 dynamic DAX regions
Message-ID: <65020d0264085_321c802941d@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-14-f740c47e7916@intel.com>
 <20230830125025.00000fea@Huawei.com>
 <64f80177c2c21_1e8e7829487@iweiny-mobl.notmuch>
 <20230912174904.00005fed@Huawei.com>
 <6500e14a8588c_314b6629439@iweiny-mobl.notmuch>
 <6500e7cdac9dc_71e582945a@dwillia2-xfh.jf.intel.com.notmuch>
 <6501f1c29a2c4_31df46294ec@iweiny-mobl.notmuch>
 <6501f89c9ef86_12747294bd@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6501f89c9ef86_12747294bd@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR21CA0015.namprd21.prod.outlook.com
 (2603:10b6:a03:114::25) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB5600:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d4eb6c8-3374-45a6-7f3c-08dbb48f684e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x2ag6XPg/c8y0c+v0VnJb3ykps3BPoDkrOhbDyTLzyTh9iLbxu6G5NF1ln85YntUpmQ7b98MsGQyOX50eSKQhiX26fBGhrf+92deSkRgc4a3SXKfCJr7j7LmFUyk487YAkIfqgaHbv0yrBrvAvhCu3TwIKt0ZAilZg5ciNmBeNiZkcVxqpTZsJU45AYm+n8X1V+1WkDF5XM8COO5RRVswxTw1HQ3hqX9Ixd6R5Xndww8iByRLQIYQy6+MqJ7NSynBiaHQbAmmWjlrln9vVKwey9yepJZOc69XY9Dy/WKxqHEO3pKJefn+d0tEAdO0IHZzQQDmFN9B3JuLMESu/nru9XTM1lVgB9X4hrgt5xrpolanBbpsP9S8dnEZxbpY3ntMWXustEyn95gs4zlLI+c4V+1GnKhnuv8I/cuPcjIsRADAUJl4jMqy+phwWYJgFi3M5Fyk6u+uqjcedJGSmg/UgPMbvX6wQXrufiWsK8dMzDC8+GGmWazMTbKMXyXcSs8U4+8mMwyBXpKRzguL7nMmmx4FDksaiYG+Oprg0L2DCcRQHsI4ChI3mr1KaysF+Xj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(186009)(1800799009)(451199024)(6666004)(6506007)(6486002)(6512007)(9686003)(478600001)(83380400001)(2906002)(44832011)(26005)(66476007)(54906003)(66946007)(66556008)(316002)(8676002)(110136005)(4326008)(5660300002)(41300700001)(8936002)(86362001)(82960400001)(38100700002)(66899024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SZ1FR2+PEYk8oNNJQ8bjEHJ4pDO4fIQBqBaVRMMrF0KuC/2gkjYO9nAkMQYk?=
 =?us-ascii?Q?CI0r5CBiZXrA7dx4z+twrj0VEYyVY+NIekLD7fEeYqziOGqVPSCVsXUOw3NT?=
 =?us-ascii?Q?/4plhDIT4ZnkOeT+SUFperopJ4zvSaRObgwENQT8oR8F4nbztlUvRcr7AP0P?=
 =?us-ascii?Q?SpAOIPYITZv/7r4jwFR5tyIsXocD0zIScQ0urVzXNSvKIExESLSqxMQkph5g?=
 =?us-ascii?Q?QzP78Az5zDSf/dhv9nMU0n1N7MKseKurrUX2WTPryXZO1/03Yi9t9/wnWp0E?=
 =?us-ascii?Q?kt/fvhwR+G3Bhfls7onPZmxFI5oVXRiu2Nd8lXCg4z1IJFGtvj0XnXFq3P76?=
 =?us-ascii?Q?2trE0f5LKEUpNqHTQkj8bdNJr6yWjWX7/5N8rVpMxAsUktiQLdN+OwBa7SuF?=
 =?us-ascii?Q?KsKafawPt5UOG6hHK6gKMl9nRNCSfGr//8fZBM3AjhQivZ9IYzGmvybQNk9E?=
 =?us-ascii?Q?W2cEMGp50zj67zKrwMYqOZZFZtatzJPLs7PZDUqPFBXUL3PTyTtPmkjpUH9T?=
 =?us-ascii?Q?jcuhuxJvTxxdqgp4hevd0Z8ZmK0zqcjOOM6PsXzjGOZcPjUFX0TW+XLtb9nm?=
 =?us-ascii?Q?rUhE9Tvr1yE1KFV9xWvlssr/GDceAVnTal9XWnTRq+M5cnrnqb/WXVsXIBa9?=
 =?us-ascii?Q?QnWsEjGdk+OW46+oDbwexZUQicXkqiiQGBj0Uv5Ss/6z/62LwepJR0poiUzF?=
 =?us-ascii?Q?ryjFbF1inMOEHgv33TpkPPIxCZv2VJ1jb+X/AV3mWUqRJQl2d4eESP5NkhF7?=
 =?us-ascii?Q?10gJtSKrwYAxBP5eDGWaeKa+h9cHaPyuIsNZZuPI0fVos7BCcjZCnVOn0Q0m?=
 =?us-ascii?Q?9ZyrgdJRWrISsSM0WQNBPq5byzQIAxuT3SeXrpRO493QOzviDWGE/yjL6aLP?=
 =?us-ascii?Q?vtz079d9/JOWNfbkBK1ahbbQEwJXbAGf2Pga930fKP0P35hDMcqjM+nUqgH+?=
 =?us-ascii?Q?c8s+eqy4AK5GMRu7Dxkxo2Q+mzaj81z2NfGTGqb1AzwIbCUqxWonLtrbLY5G?=
 =?us-ascii?Q?DtkImk0ME8LSs1FiQrkZLYy6NIP0+Mxzc9+B6dBlPo6JQRWeuk5yadc2GEIT?=
 =?us-ascii?Q?SZOAi8qT3ZByMmPuZPuzEH6awjSovUtKlEo4/uu3PXYl9MvfgKxAuFKEy+4q?=
 =?us-ascii?Q?CZjFGVGPX3TCfHzcC/sZ1P6w0hFQAdYATGEY0iOt3t9Gq5Tyxrm3oi3WRwvI?=
 =?us-ascii?Q?C7SdFdTObBvm6XxNM8540nDSVl+04vHlXK5XUdI5SaAAO3iHZiW02CUGw7+7?=
 =?us-ascii?Q?glpOSiCZML9WyQJx/DAPZskiX15TovM4KN9Tm1t7sa47DlIQz0jmRfn5sK7C?=
 =?us-ascii?Q?l9ewwuI6eV4oYnTGNwKKe4WI6XkVQpmfygA6tDPXKYYDNprvppasKms6xnI+?=
 =?us-ascii?Q?LyFd/GnK/3UG5RYAJIx2oxS31gUI5kU8vyHCOGvkTv18Q1D1jxyobmByptCu?=
 =?us-ascii?Q?B00E5Hff5Xoe0yzmmtea7ODbTErRKNvYa0HlqT7qmvBQswo9cONDR7ppJrx5?=
 =?us-ascii?Q?1BtY/oeLZ+ITutyYGWl1ebT/rF8LgcEhbxBwkIYl43o8GwuDGmVysL9FWQim?=
 =?us-ascii?Q?Wf4pCX4N+BvTmOedgQE5EPXE/gFr8rROq3QxIQZP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4eb6c8-3374-45a6-7f3c-08dbb48f684e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 19:27:02.8604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJoqydiLjPkfwX8jbYsjdkfibohUbjyOoAeTuWKnrXFXrrgPaij7hqfGpRzKZrb9IFM966NEJoDGWBIHl8nXqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5600
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
> Ira Weiny wrote:
> [..]
> > > 
> > > Given that one of the expected DCD use cases is to provide just in time
> > > memory for specific jobs the "first-available" search for free capacity
> > > in a Sparse DAX Region collides with the need to keep allocations
> > > bounded by tag.
> > 
> > How does it collide?
> > 
> > My attempt here is to leave dax devices 'unlabeled'.  As such they will use
> > space on a 'first-available' search regardless of extent labels.
> > 
> > Effectively I have defined 'no label' as being 'any label'.  I apologize
> > for this detail being implicit and not explicit.
> > 
> > My envisioned path would be that older daxctl would continue to work like
> > this because the kernel would not restrict unlabeled dax device creation.
> > 
> > Newer daxctl could use dax device labels to control the extents used.  But
> > only when dax device labeling is introduced in a future kernel.  Use of a
> > newer daxctl on an older DCD kernel could continue to work sans label.
> > 
> > In this way I envisioned a path where the policy is completely dictated by
> > user space restricted only by the software available.
> 
> Tags are a core concept in DCD. "Allocate by tag" does not feel like
> something that can come later at least in terms of when the DCD ABI is
> ready for upstream. So, yes, it can remain out of this patchset, but the
> upstream merge of all of DCD would be gated on that facility arriving.

I don't see how this can be left out of this patchset.  Without dax device
support on DCD there is no functionality and this patchset does nothing.

> 
> > > I agree with Jonathan that unless and until the allocation scheme is
> > > updated to be tag aware then there is no reason for allocate by tag to
> > > exist in the interface.
> > 
> > I will agree that it was perhaps premature to introduce labels on the
> > extents.  However, I did so to give tags a space to be informationally
> > surfaced.
> > 
> > IMO we must have a plan forward or wait until that plan is fully formed
> > and implemented.  The size of this set is rather large.  Therefore, I was
> > hoping that a plan would be enough to move forward.
> 
> Leave it out for now to focus on the core mechanisms and then we can
       ^^^^
       it what?
> circle back to it.

Again dax devices need to be created to full test this so I have to create
them in some way.  I'm going to assume you mean 'labelless' and deal with
labels later.

> 
> > > That said, the next question, "is DCD enabling considered a toy until
> > > the ability to allocate by tag is present?" I think yes, to the point
> > > where old daxctl binaries should be made fail to create device instances
> > > by forcing a tag to be selected at allocation time for Sparse DAX
> > > Regions.
> > 
> > Interesting.  I was not considering allocate by label to be a requirement
> > but rather an enhancement.  Labels IMO are a further refinement of the
> > memory space allocation.  I can see a very valid use case (not toy use
> > case) where all the DCD memory allocated to a node is dedicated to a
> > singular job and is done without tags or even ignoring tags.  Many HPC
> > sites run with singular jobs per host.
> 
> Is HPC going to use DCD? My impression is that HPC is statically
> provisioned per node and that DCD is more targeted at Cloud use cases
> where dynamic provisioning is common.

I heard someone mention HPC in a call at some point.

> 
> > > The last question is whether *writable* tags are needed to allow for
> > > repurposing memory allocated to a host without needing to round trip it
> > > through the FM to get it re-tagged. While that is something the host and
> > > orchestrator can figure out on their own, it looks like a nice to have
> > > until the above questions are answered.
> > 
> > Needed?  No.  Of course not.  As you said the orchestrator software can
> > keep iterating with the FM until it gets what it wants.  It was you who
> > had the idea of a writable labels and I agreed.
> 
> Yeah, it was an idea for how to solve the problem of repurposing tag
> without needing to round trip with the FM.
> 
> > "Seemed like a good idea at the time..."  ;-)
> > 
> > As I have reviewed and rewritten this message I worry that writable labels
> > are a bad idea.  Interleaving will most likely depend on grouping extent
> > tags into the CXL/DAX extent.  With this in mind adjusting extents is
> > potentially going to require an FM interaction to get things set up
> > anyway.
> > 
> > 	[Again re-reading my message I thought of another issue.  What
> > 	happens if the user decides to change the label on an extent after
> > 	some dax device with the old label?  That seems like an additional
> > 	complication which is best left out by not allowing extent labels
> > 	to be writable.]
> 
> At least for this point extents can not be relabeled while allocated to
> an instance.

Sure but is having writeable labels worth this extra complexity?

> 
> [..]
> > My current view is:
> > 	1) No.  Current dax devices can be defined as 'no label'
> > 	2) I'm not sure.  I can see both ways having benefits.
> > 	3) No I think the ROI is not worth it.
> > 	4) The use of 'any extent label' in #2 means that available size
> > 	   retains it's meaning for no label dax devices.  Labeled dax
> > 	   devices would require a future enhancement to size information.
> 
> If the ABI is going to change in the future I don't want every debug
> session to start with "which version of daxctl were you using", or "do
> your scripts comprehend Sparse DAX Regions?".

Well then we are stuck.  Because at a minimum they will have to understand
Sparse DAX regions.  cxl create-region needs a new type to create such
regions.

I envisioned an ABI *extension* not change.  The current ABI supports dax
devices without a tag.  Even with DCD no tag is possible.  Unless you want
to restrict it, which it sounds like you do?

I'm ok with that but I know of at least 1 meeting where it was
emphatically mentioned that tags are _not_ required.  So I'd like some
community members to chime in here if requiring tags is ok.

>
> This stance is motivated
> by having seen the problems that the current ABI causes for people that want
> to do things like mitigate the "noisy neighbor" phenomenon in memory
> side caches.

Does a dax device need specific placement within the region?  That sounds
like control at the extent layer when the extent is mapped into the
region.

The mapping store interface does need to be resolved for DCD.  I could
envision the ability for user space to create extents...  Are you thinking
the same thing?

Conceptually from a top down approach _any_ dax region could be a sparse
dax region if I get what you are driving at?  Not just DCD?  In that case
extent creation is even more complicated in the DCD case.

> The allocation ABI is too simple and DCD seems to need
> more.

Are you advocating for an ABI which requires dax devices to be labeled?
It sounds like you don't want the current tool set to work on sparse dax
regions.  Is that correct?  I'm ok with that but I don't think a specific
check in the kernel is the proper way to do that.  Current dax devices are
unlabled.  So I envisioned them being supported with the current ABI.

> 
> The kernel enforced requirement for Sparse DAX Region aware tooling just
> makes it easier on us to maintain. If it means waiting until we ahve
> agreement on the allocation ABI I think that's a simple release valve.

These statements imply to me you have additional requirements for this ABI
beyond what DCD does.  I've tried to make the dax layer DCD/CXL agnostic.
But beyond having the concept of region extents which are labeled and
matched to dax devices based on that label; what other requirements on dax
to region space allocations are there?

> 
> The fundamental mechanisms can be reviewed in the meantime.

Sure,
Ira
