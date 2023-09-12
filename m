Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D5B79DBEC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237775AbjILWgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 18:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbjILWgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:36:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7E010E9;
        Tue, 12 Sep 2023 15:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694558166; x=1726094166;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sMSLUWElC9WPmskoHvvVV3ua9cCuoHJeKgSVi6zcn7o=;
  b=T1MvtE2ySkDPHA2MkKTOy2aVApgNxE9JxPjobrsoAt8lvKRKtg6L0Xaw
   KUCiy7I8q0zCb1D8/0RbC7/tEV0OeylAruI8hp5+epPD7FBuAkiMYgx5s
   vwOCWivbnQpWSgmX+0hJHBr4+t226uxbAwfBZShrNXboG6l673jxitCzL
   4lSGAlgt4fTKXuY31mJoXSBE0eV9C09g3H0AUufCcsoNCfwQxwDdkQp6M
   R8q2Ful+2Mx6si25bBIQONQ8FG6sxJHOEEZu1Gppqs/JMLnh74GgO2bE0
   ln4eZHaD/dZYZS008sjUKd25FgsylE4MzudiGMh6UIGyqjB+7KNS+mXzS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="409461634"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="409461634"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 15:36:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="1074712688"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="1074712688"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 15:36:03 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 15:36:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 15:36:03 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 15:36:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2Iw1gFzM9OcTTKSmpzC6vFkPgfF+FSE5OkI3jt4erpVFpQB9tLdC2EHdH5nA7cm5wa1Qgu5mrL0wZx271h3AX6CmEBpK+8DeT7q05Ly721648rfmQWgwpEv11Q+CjwYvZNuQK57opMQlpA6qwc+8tmCTghOyLGRGuSFrP0n0fNX6rwlR/ZG9pGM8U/6PNQmx8RUYl/lPmbqq+gr4yNXE3VVwrT1MNZMsz1+a6b84IuEaNu8Rrfb1Q3qpp3lgArMDnqScZPbrtI1rhrcSxRkcmXt/siG2HRekudFDGB0tX+N04gOG3xsnBV9ZVSJZ4RqzEgSEw1ycTk0aBvznT/YVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/T3JICfy76CGeMDgjTsWgmPfes8nSDzXEiQ0lVYx9s=;
 b=gAvxvUnoJoHLfqB8cIkN9oRi4wmQ1xKxf7AcJewkNjJUpGRm3YRlGUnmHxbFLoqe3ZPlJgWm4o3pKyQhzpYeHeIX4tuaCAgjoWTx6E2jOr6taM0R5x3uUi5vFi7T+64oYIwq8mBxAP6MJ7p01QtVlEZpJWVU0cihJCudWAmsQmh+6ZmgGd2nEb4HeTKUvOSxboid6tKixWqHIy1QYtZfvdS9LqdNfp4FRf/9ZFPavYBYk0JbsX2YgsQVZCaoUvx905suDoA0W6rr1/ECYKrp7R6mjtPeQILVY4KUdrr0kujIEAJzTYz43stQITEQIQOKlifPpE9Q+/Lvmvf9kKkyMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CYXPR11MB8755.namprd11.prod.outlook.com (2603:10b6:930:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Tue, 12 Sep
 2023 22:36:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 22:36:01 +0000
Date:   Tue, 12 Sep 2023 15:35:57 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
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
Message-ID: <6500e7cdac9dc_71e582945a@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-14-f740c47e7916@intel.com>
 <20230830125025.00000fea@Huawei.com>
 <64f80177c2c21_1e8e7829487@iweiny-mobl.notmuch>
 <20230912174904.00005fed@Huawei.com>
 <6500e14a8588c_314b6629439@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6500e14a8588c_314b6629439@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW3PR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:303:2a::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CYXPR11MB8755:EE_
X-MS-Office365-Filtering-Correlation-Id: 52fcc82e-f76f-427e-8c22-08dbb3e0a40d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wKh9w5PpkT9hYcF5uSGT4stoj8m4AobZiPwe8JnjyUjRN8ZaX/ytgTnE2/X7FZhiDyoDN1xdF1crOyvcROgf/gM/uWkheaXUwGVblPJhiw82t5tCJ/2CiiR8KucXAciP1YmPsyH/QFe1JQ+oOi+tbUmmUQK62eyAoz3eMbLDZwaQHUhE1fm9RVvXzECc/RC+VXZH214iQyTXFawrx/KGlMh+E3DrHEOyeZJUWe6sX+tVYF6epx/Jt7pV1AEowk7pdsyiB4Wicv5aQ10acINh2LTs9uqYHQSJZRkwomFB/wjQzhmY5brGzqn/Sztc93oZk4D8fam+xLgInlagTe2sPtXU8u1VlVBmu2uh2/rgUiYtN9cPZzLZjrVkG2irPVMaF/tLv0ZSbs8uEHzYqDnwwqVD47x8gDTnrd/nc8tTdGW/nJkZ09OuD7FL78iMwsZsWfm/qcElaf9lUSLFwWDMOOJT7kiFNa8C4+u5XiyThwBrYry0UYd1DCKxus7gCV0bv3fb66ng6d8He2jCzK5ZuPQAPm/DgVP6FiEf5AWh39E52KQvySDe9y9prbLKCgo3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199024)(186009)(1800799009)(8936002)(4326008)(26005)(8676002)(83380400001)(5660300002)(9686003)(6512007)(41300700001)(6506007)(6486002)(66476007)(54906003)(66556008)(66946007)(110136005)(82960400001)(6666004)(38100700002)(316002)(86362001)(2906002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ONQFvymT33HR9POmei3E6yLV+SjdvdaPaNky4giBjqMzHfZdwE3e1NqGwi/w?=
 =?us-ascii?Q?yvmvEUeTfKdnlZbMrK+FKXbcyH2oDMDivIG9sLpLcFQF82EMEg3pRmX9XKEk?=
 =?us-ascii?Q?Opqr6pVqyBQzbG+/ZPtGwuBXCT4Z1c+bXjYX9zOXVYVq8s0HPUWlR/39khlz?=
 =?us-ascii?Q?kFz4/k0I16ab2lGVAVK0rABZNdYQuiLPMfb9mIfXbZzs1l/64oC2dcyeyed6?=
 =?us-ascii?Q?I3C9LDgNDxipDbjfbjOC1BU1R9zCjYtIpr3xM6l1rNSFAXMulUltK/KfZzJi?=
 =?us-ascii?Q?npoF4FjwpdLM1+MWCY9YCqGBwhihLS9mms3j/SAhiuVob/WvHLgwKNEAqOMz?=
 =?us-ascii?Q?zAkkipON/49ys7SmIoBY31VPGvtHbS+XJsSErqmXpBjVC/fo5NzJYUq9yJtV?=
 =?us-ascii?Q?wlk+xn2MuHyJGdeXA49yNN8n0zCkSbIh+55lv76GfwdJLEsLMPJRQ2eqQ+bs?=
 =?us-ascii?Q?pXTjr5aH17s4wjGXFhWtZLifivS1b46QGNJraegzwPtiqcr8zQvTG4EHOzv8?=
 =?us-ascii?Q?9EtuCkz1D8m6voLlWQa8WzGMyapSRyE0cKDs+3OmRS0lmvbbycU7lqA/DggQ?=
 =?us-ascii?Q?MhxlsTMtx1jci8Q8QMew+lu5oV6NtG83mJ0We7csH3egqPdZJhCdPhXf+TNH?=
 =?us-ascii?Q?MxXuYvgZJvzyCV2nJ3YVjzCSyBio5X12qGw4xd/o6+6FsrbjRuFzXIErhAqh?=
 =?us-ascii?Q?9qtsaq8CfF8tWsPw3cHJYnO+F4iRfbY2Pj/ws+uOTCNVpEEFrFU4Xt5g9lZ0?=
 =?us-ascii?Q?p6p6367KRbY0r0/+DinOmVQ5XlA/lhIu0EvNSuy/9Pe2uLRO1BM0l+lkkwVS?=
 =?us-ascii?Q?tH+pDNIG+sqC4B6qTBiMCKQOuZuJpfG/A41jKVtj5MLx+mXE5iJDSorZR8KH?=
 =?us-ascii?Q?V2Ga8WhSNw0VVFkFbETp05I1fnWnXOe3TfmxQ+Qp0Ou1hyIlYY/pwU7diJtE?=
 =?us-ascii?Q?ckg4pGPV+mAuXGYqxUl/Gwey/7IcYDeTGmxVUzxj8ZLKJYzcpi6XL0yDiBJo?=
 =?us-ascii?Q?dCWWp9c3b1pBmV5LyX898ZaktWFv42xcJbj3GPLo8rm57J4RDbhs6IPbYZ6B?=
 =?us-ascii?Q?DbPdPPSsaGhQI5XtHrBlM5KAsvlEXnYSML9DzBtKzD9/pBkgKS/Pq/V4kKlq?=
 =?us-ascii?Q?m0cFlmOZMlPu3x/0AdFQt5gYt21UltKWBO+PzbDUadjc7UouYivpsOht4OyR?=
 =?us-ascii?Q?qc4xbA/gtbGuYyzSGXPUALuOInkK5fknpUiG+UPxOQea4/CGQS++Axt8rb4d?=
 =?us-ascii?Q?C+jlSFoH/dSLgriGyFH/ivOqgMBKyMSVdmHqlbWRLpKIE6w8EvOsHwFbKpqP?=
 =?us-ascii?Q?3+yy00vH2ApzTt2ZGA5fdc7ZmeMYgsyJIwZesQ+1VZnNqIUlCeg1+nRSJpI3?=
 =?us-ascii?Q?tA46XZK2JHL2iLvSj4Sz3U4s8p9VfO7pRGKYKuek+0dvk9E+I8t3G3q+nFqm?=
 =?us-ascii?Q?FbkMcAwW4uozHWEfeNI+bmyKv6YSfd94SIcDi6HFxNBkNIaialSrHfY4lKF2?=
 =?us-ascii?Q?HVPbIcrWPeYwVPRYCY5OUwN4+qDl3QW4dHrN2GRJMHYGMtCILfGLxcx/6ccO?=
 =?us-ascii?Q?qcq/jidMRcJ8w5A7/1S1hJS4Kg4iicc/o5I5lU2T+i7RUTBy5Z7rYV/xed3X?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52fcc82e-f76f-427e-8c22-08dbb3e0a40d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 22:36:01.1456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vj1gzVtCpK9zjMqpRTHJC+NCrDGfrHttcPc2Wt6K4jpzWdY7FZjq7FvTp4/X8zo2BhsVN7p2npVJlbzbgXmiq7IUiJzBPnuvL06k6WL8waA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8755
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ira Weiny wrote:
> Jonathan Cameron wrote:
> > On Tue, 5 Sep 2023 21:35:03 -0700
> > Ira Weiny <ira.weiny@intel.com> wrote:
> > 
> > > Jonathan Cameron wrote:
> > > > On Mon, 28 Aug 2023 22:21:05 -0700
> > > > Ira Weiny <ira.weiny@intel.com> wrote:
> > > >   
> > > > > Dynamic Capacity (DC) DAX regions have a list of extents which define
> > > > > the memory of the region which is available.
> > > > > 
> > > > > Now that DAX region extents are fully realized support DAX device
> > > > > creation on dynamic regions by adjusting the allocation algorithms
> > > > > to account for the extents.  Remember also references must be held on
> > > > > the extents until the DAX devices are done with the memory.
> > > > > 
> > > > > Redefine the region available size to include only extent space.  Reuse
> > > > > the size allocation algorithm by defining sub-resources for each extent
> > > > > and limiting range allocation to those extents which have space.  Do not
> > > > > support direct mapping of DAX devices on dynamic devices.
> > > > > 
> > > > > Enhance DAX device range objects to hold references on the extents until
> > > > > the DAX device is destroyed.
> > > > > 
> > > > > NOTE: At this time all extents within a region are created equally.
> > > > > However, labels are associated with extents which can be used with
> > > > > future DAX device labels to group which extents are used.  
> > > > 
> > > > This sound like a bad place to start to me as we are enabling something
> > > > that is probably 'wrong' in the long term as opposed to just not enabling it
> > > > until we have appropriate support.  
> > > 
> > > I disagree.  I don't think the kernel should be trying to process tags at
> > > the lower level.
> > > 
> > > > I'd argue better to just reject any extents with different labels for now.  
> > > 
> > > Again I disagree.  This is less restrictive.  The idea is that labels can
> > > be changed such that user space can ultimately decided which extents
> > > should be used for which devices.  I have some work on that already.
> > > (Basically it becomes quite easy to assign a label to a dax device and
> > > have the extent search use only dax extents which match that label.)
> > 
> > That sounds good - but if someone expects that and uses it with an old
> > kernel I'm not sure if it is better to say 'we don't support it yet' or
> > do something different from a newer kernel.
> 
> This does provide the 'we don't support that yet' in that dax device
> creation can't be associated with a label yet.  So surfacing the extents
> with the tag as a default label and letting those labels change is more
> informational at this point and not functional.  Simple use cases can use
> the label (from the tag) to detect that some extent with the wrong tag got
> in the region but can't correct it without going through the FM.
> 
> It is easy enough to remove the label sysfs and defer that until the dax
> device has a label and this support though.

Catching up on just this point (still need to go through the whole
thing).  A Sparse DAX region is one where the extents need not be
present at DAX region instantiation and may be added/removed later. The
device-dax allocation scheme just takes a size to do a "first-available"
search for free capacity in the region.

Given that one of the expected DCD use cases is to provide just in time
memory for specific jobs the "first-available" search for free capacity
in a Sparse DAX Region collides with the need to keep allocations
bounded by tag.

I agree with Jonathan that unless and until the allocation scheme is
updated to be tag aware then there is no reason for allocate by tag to
exist in the interface.

That said, the next question, "is DCD enabling considered a toy until
the ability to allocate by tag is present?" I think yes, to the point
where old daxctl binaries should be made fail to create device instances
by forcing a tag to be selected at allocation time for Sparse DAX
Regions.

The last question is whether *writable* tags are needed to allow for
repurposing memory allocated to a host without needing to round trip it
through the FM to get it re-tagged. While that is something the host and
orchestrator can figure out on their own, it looks like a nice to have
until the above questions are answered.

> > > > > @@ -1400,8 +1507,10 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
> > > > >  	device_initialize(dev);
> > > > >  	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
> > > > >  
> > > > > +	dev_WARN_ONCE(parent, is_dynamic(dax_region) && data->size,
> > > > > +		      "Dynamic DAX devices are created initially with 0 size");  
> > > > 
> > > > dev_info() maybe more appropriate?  
> > > 
> > > Unless I'm mistaken this can happen from userspace but only if something
> > > in the code changes later.  Because the dax layer is trying to support
> > > non-dynamic regions (which dynamic may be a bad name), I was worried that
> > > the creation with a size might slip through...
> > 
> > Fair enough - if strong chance userspace will control it at somepoitn then
> > ONCE seems fine.
> > 
> > > 
> > > > Is this common enough that we need the
> > > > _ONCE?  
> > > 
> > > once is because it could end up spamming a log later if something got
> > > coded up wrong.
> > 
> > I'm not sure I care about bugs spamming the log.   Only things that
> > are userspace controlled or likely hardware failures etc.
> > 
> 
> Understood.  Let me trace them again but I think these can be triggered by
> user space.  If not I'll remove the ONCE.

Unless this is an unequivocal kernel bug if it fires, and there is a
significant potential for active development to do the wrong thing,
don't leave a panic_on_warn land mine.
