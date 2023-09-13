Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4D179F068
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjIMRbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjIMRbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:31:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDCDC1;
        Wed, 13 Sep 2023 10:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694626257; x=1726162257;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CeY+uqL86X6Cizk49EY9pSJr1OwumcVYxXdXN7aYyo4=;
  b=FMemf+hQNACbzljrNE3ewsOH1vIRtn9cCu3KR9JRLFCzjG6MXxQ/LfOi
   HiBYQxTtMMAYXQ0ZaEmXt9+QjJxR+oPmTPX0rhD7O4xJNl8OmOGAJEJYT
   1A44Hvw24B7I3bYEweaiSLjkStCIe96WKHV5eRsRuxxZO5lzmMw2wfd65
   Z3ej/WIkHgCAqif4weFSFhMilAR7NfjpNOZbQSGy9tmo7yWEwK62649RP
   K1ppepT5pEQB7J9UTzJEDTqkoj624+uCFyELkY35+BABFNDTvy0EXgf3f
   MNn5jMaraiinneqmNMV2876rs3+fSB/u4cCbvBL5ycyHzA6fko7YNG03O
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="445167023"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="445167023"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 10:30:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="834396551"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="834396551"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 10:30:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 10:30:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 10:30:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 10:30:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAlHNU4UFSKeYwzBulXAtLazq6LN5OiVjcQO26V/uqOUC7+v4bklFv7IyDYoLOXve5Pc+r8iuaM5NdytYN4iGx3o5AW2CcVh2Ws7tT1R9e3l4gqpy8Qugp0HepVxOI/06iiKbU7KB6FsbvN6vB9zcZB8dhXn91tH9qPQRWR9mkudvqVHZmkE4TyQchsOqXvhtnuejJPtJnHFCEnJ5n+yRIh4trThJ7prdslZ8yQLiW6lKZ26Y8l2DZEUpHzsHCV5nx2cuNhi+S7TDPRp7rJlkWRA/jOsDV48UweNNIbLir7TIIRDpKTQWVW12WZzmZr9bbhWvFJXMpXgJvnwEUks5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FUFak1FfbgMdHAmMlkQpodS7HixK42KQ2JjDEN4Wsto=;
 b=QIdNWYFbY9KW3SN7cystfCZHiHXrjV0u1EkgYNz/yuraPfL604pXdQJMrliorNiNkq1GaJ/YCE6gl1fhcuEcXJG97rV1UtPR9mjpatOPbQUpMOB1PFCgSRPPjKy6e2MxiVvgAtJyhovoIUw+1h1Dq7Rs1/DiP2WUpCX2HVPqtb020HjQm9ecQLH+gc9LSwONRjhhN/HKUN8ycapzVJ33M3FqaIU6MYBPw5NhdM8SHpVgboBWUQs4yeeEyuItkrKOZIdeuB9Bno0283tSGD2vpVrHWibsqvX6onwPH+BLZTxYMmiP+RtRdwwQJbWYOneu2YuCrNWNBYofqncA+nhjKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB7025.namprd11.prod.outlook.com (2603:10b6:510:208::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 17:30:47 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 17:30:47 +0000
Date:   Wed, 13 Sep 2023 10:30:42 -0700
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
Message-ID: <6501f1c29a2c4_31df46294ec@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-14-f740c47e7916@intel.com>
 <20230830125025.00000fea@Huawei.com>
 <64f80177c2c21_1e8e7829487@iweiny-mobl.notmuch>
 <20230912174904.00005fed@Huawei.com>
 <6500e14a8588c_314b6629439@iweiny-mobl.notmuch>
 <6500e7cdac9dc_71e582945a@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6500e7cdac9dc_71e582945a@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB7025:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c902936-eba7-4e0b-1786-08dbb47f2a91
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/AtXd0RLmvgDoRd3Po+hwzVIQ3ggUaNT0pg8WKIId0EOb18u+oofSvV8HvRxL1VxZ6em2wqa3DeAjbBsZ2ABemVNIMuBjreyJQEOrPGJpucAj/X7yu4VqYWhOL0zd/eovU/5m06ffWV88pdOidRcxD9HJ+KiZgvEGB8nPUu0doK8P+5XiF2MviIGINKRZ5KqY3doKLC4/2DmPFDJpOJ6vEbsWGmUF82GvWL/YC0pIJDcyG/TKXO1S0iAh0w/ub2i2IfDa3xFRwvjHEiIhBMDecCERMGv1KWZqqvOMQTZX/VANOmhcIbHvSTn/EoZ56e02CpfDFmVRJ1ut0A/mBPKD6sIAFL4cM87HFH2TJm/h2KTuayDPxgOJNis2D+32G3xuqur8IHnQe3ut7w6alTO1bC8/YBqRWTlqixYvPBin7U1AU0HPKbvW8oOMOfvEMAxNxZVshk/dBByoFqvEn4PVb8eCF12p2J+1HjKQptfhOZtjWxx51zh+VkWjXL0TgvbV+gX60ZTeT1K6Mz1fuiHXwF99cLopPklYQ9VSssjK8Dycm2eyERHtB0gGAqF6d+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199024)(1800799009)(186009)(86362001)(82960400001)(38100700002)(66899024)(66476007)(54906003)(41300700001)(66946007)(66556008)(8936002)(8676002)(4326008)(316002)(6666004)(26005)(6512007)(478600001)(9686003)(6486002)(6506007)(30864003)(2906002)(110136005)(83380400001)(44832011)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3sa7e5MfjyLqRg5IKmMDjX/no7g5+x/66nwRJlhDJAr9aknodEkQdLjZfFPH?=
 =?us-ascii?Q?eKBPXM2gCOShPg5m4hXIEVf4ghUEBhkAi8EGzYxRj7Qe21RbdYV4g5Tdp9Cq?=
 =?us-ascii?Q?7yj2saxIQfvGsPN1WaTPaW3n7Z8aKxHbv+K/G4AcgzBZqdutzx+Y6m0QuorI?=
 =?us-ascii?Q?01GenA6yQXrdbyvdsTlceHVg6OxN1nfKqY1+0rffoOP8+ecwHVN+Cs9ASx5p?=
 =?us-ascii?Q?oGeiYpKwnOot0Alw9Pj1TXXTFB3SClKas0OgHve+iJUx/L/6wDFVLJo5vULw?=
 =?us-ascii?Q?BCVgzZdvflZUeaVgwEcDL+ag1b1zMriqdCY8d4lrKCknQI8k0xEy0YuqCe5m?=
 =?us-ascii?Q?LA2IbcEDYln71kIDq/XqMATudBaOT9s0f/3TSJdwdQimBWO0tkP3dpuz4YRu?=
 =?us-ascii?Q?V+A04NcJwm92ajGxU8EYZWtKNIznJRVg5IAlemF0VRz1rGZ863vzSHnnVADs?=
 =?us-ascii?Q?iL6vBBqFc+zxYXdJZYqcOQEa+ZHNwlBYcyyGGwOt9MtUCHjsz6+o1A/d6czH?=
 =?us-ascii?Q?VsgriFueadbdZVNvOcisSb0xXNLopd33gqDZvs3ZlEODz+3l5cTNosJ0zYFy?=
 =?us-ascii?Q?3VPxorgCrl67ZBapRe/BbxCbG4hKpVn8lXXMGnsRxqAZ/uaT+UHcVWXUwVMP?=
 =?us-ascii?Q?nrim0pVoY8A6V/KgOWdLbd7a7FxVxEPQ87EA5WxJyq33/YkDuS0XLvB50Wye?=
 =?us-ascii?Q?YfZJpRQm5eOAsa4LanIiFqwlf9Irj5zfirWX3XLSUW4Hsnp0tZLEDe6jsnTk?=
 =?us-ascii?Q?5PK2oLPqfHwiTfZsxwig3FkorGngdZd1nR77ykWDBApjP2y0+TBfjkfNiyrI?=
 =?us-ascii?Q?ZIcun0JNOMUSl7ObUISbQi6mcFjp5smHZNWLOZOPj5htGmc7/hbzQNuN17uA?=
 =?us-ascii?Q?FcAM3AsmKPJETMiWMdeRbztzWpeLGvuaBhBRtTeHNoc+t88owVVz/yflizWn?=
 =?us-ascii?Q?ORDji79DTYqaDqSCmdXMrvhmQu9Ep1no9/QJhNQ3HQjSdBUsTXKIqjvqRI87?=
 =?us-ascii?Q?oEguu/Dj8Oe2MZ0H5sVgKEA1jv17CtAQuOMoFyTyKy6yd5BztE41wUrXcEab?=
 =?us-ascii?Q?BqeVdK9b4zc7/zuodtX2B+fFGobvRNLb4f60ZQMIXBPcwH2WvucizFJEN1ka?=
 =?us-ascii?Q?CUvPPP3DGuB7aIVbsyj8wh9JHqmSVu1RAAbyqiCxP+IpWcRkzoYI+N/57gg6?=
 =?us-ascii?Q?D0Ssz7KAqQucG5qa3Cfo/TucMPCRzBSa2Ka7NzoDc01HqmvmWemlfm0pVfoG?=
 =?us-ascii?Q?mu6h8fdwGSQkhxZUgBWknXv3842ZgvsTSJLLgfEdfDfoAb29R4J0d7QI8YJF?=
 =?us-ascii?Q?etnjXhdeR7tz3zmyPnwN3mBD2gT+am2vop3Vsstrc8SetonbwcObWDqpD/+K?=
 =?us-ascii?Q?zmgbEgOkI52ytuyYsrdCOIrRf0k9eGryaUGfV1TvoIolfnY2ECiOce/J9CdO?=
 =?us-ascii?Q?uXbiv++Wf+nzeUOQ7R27GFf6mbJq4M9VSoP54edqi1iiAVd3/1tQ1R1aUAh5?=
 =?us-ascii?Q?NiAUhp6N0CJMKKNqIt6Q3X4I2MKau453KjqSnwrMiEZ/ltOWLZWQcAyr5Ne0?=
 =?us-ascii?Q?veQE0SfOWFznoRy6d18JpqaUDc5/8Oa0VvQcuchs?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c902936-eba7-4e0b-1786-08dbb47f2a91
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 17:30:47.3772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KkjfEyh+nJg+wYoDF3Z5NtvtFf+v7dk+MIqKdR1dzPI+3E9RUTUJi6v9MTz0Yn0wLC7k3bqMsW01YmfSrkJSvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7025
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
> Ira Weiny wrote:
> > Jonathan Cameron wrote:
> > > On Tue, 5 Sep 2023 21:35:03 -0700
> > > Ira Weiny <ira.weiny@intel.com> wrote:
> > > 
> > > > Jonathan Cameron wrote:
> > > > > On Mon, 28 Aug 2023 22:21:05 -0700
> > > > > Ira Weiny <ira.weiny@intel.com> wrote:
> > > > >   
> > > > > > Dynamic Capacity (DC) DAX regions have a list of extents which define
> > > > > > the memory of the region which is available.
> > > > > > 
> > > > > > Now that DAX region extents are fully realized support DAX device
> > > > > > creation on dynamic regions by adjusting the allocation algorithms
> > > > > > to account for the extents.  Remember also references must be held on
> > > > > > the extents until the DAX devices are done with the memory.
> > > > > > 
> > > > > > Redefine the region available size to include only extent space.  Reuse
> > > > > > the size allocation algorithm by defining sub-resources for each extent
> > > > > > and limiting range allocation to those extents which have space.  Do not
> > > > > > support direct mapping of DAX devices on dynamic devices.
> > > > > > 
> > > > > > Enhance DAX device range objects to hold references on the extents until
> > > > > > the DAX device is destroyed.
> > > > > > 
> > > > > > NOTE: At this time all extents within a region are created equally.
> > > > > > However, labels are associated with extents which can be used with
> > > > > > future DAX device labels to group which extents are used.  
> > > > > 
> > > > > This sound like a bad place to start to me as we are enabling something
> > > > > that is probably 'wrong' in the long term as opposed to just not enabling it
> > > > > until we have appropriate support.  
> > > > 
> > > > I disagree.  I don't think the kernel should be trying to process tags at
> > > > the lower level.
> > > > 
> > > > > I'd argue better to just reject any extents with different labels for now.  
> > > > 
> > > > Again I disagree.  This is less restrictive.  The idea is that labels can
> > > > be changed such that user space can ultimately decided which extents
> > > > should be used for which devices.  I have some work on that already.
> > > > (Basically it becomes quite easy to assign a label to a dax device and
> > > > have the extent search use only dax extents which match that label.)
> > > 
> > > That sounds good - but if someone expects that and uses it with an old
> > > kernel I'm not sure if it is better to say 'we don't support it yet' or
> > > do something different from a newer kernel.
> > 
> > This does provide the 'we don't support that yet' in that dax device
> > creation can't be associated with a label yet.  So surfacing the extents
> > with the tag as a default label and letting those labels change is more
> > informational at this point and not functional.  Simple use cases can use
> > the label (from the tag) to detect that some extent with the wrong tag got
> > in the region but can't correct it without going through the FM.
> > 
> > It is easy enough to remove the label sysfs and defer that until the dax
> > device has a label and this support though.
> 
> Catching up on just this point (still need to go through the whole
> thing).  A Sparse DAX region is one where the extents need not be
> present at DAX region instantiation and may be added/removed later. The
> device-dax allocation scheme just takes a size to do a "first-available"
> search for free capacity in the region.

Agreed.  And this is the way things work now.

Also your use of 'Sparse DAX region' seems better than the word 'dynamic'
I have used now.  I know that static regions mean something else but I
could not think of a better word.  I'll make adjustments to the
code/commit messages.

> 
> Given that one of the expected DCD use cases is to provide just in time
> memory for specific jobs the "first-available" search for free capacity
> in a Sparse DAX Region collides with the need to keep allocations
> bounded by tag.

How does it collide?

My attempt here is to leave dax devices 'unlabeled'.  As such they will use
space on a 'first-available' search regardless of extent labels.

Effectively I have defined 'no label' as being 'any label'.  I apologize
for this detail being implicit and not explicit.

My envisioned path would be that older daxctl would continue to work like
this because the kernel would not restrict unlabeled dax device creation.

Newer daxctl could use dax device labels to control the extents used.  But
only when dax device labeling is introduced in a future kernel.  Use of a
newer daxctl on an older DCD kernel could continue to work sans label.

In this way I envisioned a path where the policy is completely dictated by
user space restricted only by the software available.

> 
> I agree with Jonathan that unless and until the allocation scheme is
> updated to be tag aware then there is no reason for allocate by tag to
> exist in the interface.

I will agree that it was perhaps premature to introduce labels on the
extents.  However, I did so to give tags a space to be informationally
surfaced.

IMO we must have a plan forward or wait until that plan is fully formed
and implemented.  The size of this set is rather large.  Therefore, I was
hoping that a plan would be enough to move forward.

> 
> That said, the next question, "is DCD enabling considered a toy until
> the ability to allocate by tag is present?" I think yes, to the point
> where old daxctl binaries should be made fail to create device instances
> by forcing a tag to be selected at allocation time for Sparse DAX
> Regions.

Interesting.  I was not considering allocate by label to be a requirement
but rather an enhancement.  Labels IMO are a further refinement of the
memory space allocation.  I can see a very valid use case (not toy use
case) where all the DCD memory allocated to a node is dedicated to a
singular job and is done without tags or even ignoring tags.  Many HPC
sites run with singular jobs per host.

> 
> The last question is whether *writable* tags are needed to allow for
> repurposing memory allocated to a host without needing to round trip it
> through the FM to get it re-tagged. While that is something the host and
> orchestrator can figure out on their own, it looks like a nice to have
> until the above questions are answered.

Needed?  No.  Of course not.  As you said the orchestrator software can
keep iterating with the FM until it gets what it wants.  It was you who
had the idea of a writable labels and I agreed.

"Seemed like a good idea at the time..."  ;-)

As I have reviewed and rewritten this message I worry that writable labels
are a bad idea.  Interleaving will most likely depend on grouping extent
tags into the CXL/DAX extent.  With this in mind adjusting extents is
potentially going to require an FM interaction to get things set up
anyway.

	[Again re-reading my message I thought of another issue.  What
	happens if the user decides to change the label on an extent after
	some dax device with the old label?  That seems like an additional
	complication which is best left out by not allowing extent labels
	to be writable.]

I think writable labels are orthogonal to the kernel behavior though.
Allowing labels to change after the fact is a policy matter which is not
something the kernel needs to manage.

The kernel does need to manage how it allocates a dax device across the
extents available.  Assigning a dax label and allocating to the extents
matching that label is very straight forward.  The real issue is how to
deal with the 'no label' case.

As a path forward, I made a couple of assumptions.  First was the idea of
'no dax device label' == 'any extent label'.  Second, was that current dax
device creation was done as 'no dax device label'.

In this way I did not see a requirement to fully implement label
restriction on dax devices.  Labels are simply a nice to have thing to
group extents later.  Also, if you want dax devices created with specific
extents you have to assign them a label.  Otherwise they are allocated
'first-available' like they have been in the past.

I see a few ways forward.

One is to define 'no dax device label' as 'any extent label' as I have it
now.  IMO this provides the most backwards compatible dax device creation.
The ndctl region code additions are minimal and there are no daxctl
modifications required at all.

A second is to define 'no dax device label' as 'no extent label' and go
forward with this series but add a restriction on dax device creation to
only extents without a label.  This is still pretty compatible but if tags
are used then some extents would not be available without additional
daxctl modifications.

A third way forward is to fully implement label enabled dax device
creation.  In this case I feel like the direction is to make 'no label' ==
'no label'.  This is not hard but will take a couple more weeks to get the
daxctl code and all the testing.

It warrants mentioning that tags are an optional feature.  I feel like
there is momentum in the community to not use tags initially.  And so I
was targeting an initial implementation which really did not need tags at
all.  Perhaps I am wrong in that assumption?  Or perhaps I was short
sighted (possibly because interleaving becomes more straight forward)?

To summarize I see the following fundamental questions.

	1) Do we require DCD support to require dax device label
	   management?
	2) What does 'no dax device label' mean?
		a) any extent label
		b) no extent label
	3) Should writable labels be allowed on extents?
		a) this is more flexible
		b) security issues?
		c) does it just confuse things with interleaving?
		d) nice to change the tag name to something easy to read?
		e) other issues?
	4) How should the available size for labels be communicated to the
	   user?
	   	a) currently available size reflects an 'any extent label'
		   behavior when there is no label on the dax device.
		b) this becomes an issue if labelless dax devices are
		   restricted to labelless extents.

My current view is:
	1) No.  Current dax devices can be defined as 'no label'
	2) I'm not sure.  I can see both ways having benefits.
	3) No I think the ROI is not worth it.
	4) The use of 'any extent label' in #2 means that available size
	   retains it's meaning for no label dax devices.  Labeled dax
	   devices would require a future enhancement to size information.

> 
> > > > > > @@ -1400,8 +1507,10 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
> > > > > >  	device_initialize(dev);
> > > > > >  	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
> > > > > >  
> > > > > > +	dev_WARN_ONCE(parent, is_dynamic(dax_region) && data->size,
> > > > > > +		      "Dynamic DAX devices are created initially with 0 size");  
> > > > > 
> > > > > dev_info() maybe more appropriate?  
> > > > 
> > > > Unless I'm mistaken this can happen from userspace but only if something
> > > > in the code changes later.  Because the dax layer is trying to support
> > > > non-dynamic regions (which dynamic may be a bad name), I was worried that
> > > > the creation with a size might slip through...
> > > 
> > > Fair enough - if strong chance userspace will control it at somepoitn then
> > > ONCE seems fine.
> > > 
> > > > 
> > > > > Is this common enough that we need the
> > > > > _ONCE?  
> > > > 
> > > > once is because it could end up spamming a log later if something got
> > > > coded up wrong.
> > > 
> > > I'm not sure I care about bugs spamming the log.   Only things that
> > > are userspace controlled or likely hardware failures etc.
> > > 
> > 
> > Understood.  Let me trace them again but I think these can be triggered by
> > user space.  If not I'll remove the ONCE.
> 
> Unless this is an unequivocal kernel bug if it fires, and there is a
> significant potential for active development to do the wrong thing,
> don't leave a panic_on_warn land mine.

Indeed.  I forgot about those panic on warn users.  I'll remove the warn
altogether.

Thanks,
Ira
