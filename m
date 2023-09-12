Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8939D79DB9F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 00:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbjILWIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 18:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjILWIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 18:08:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07F310D9;
        Tue, 12 Sep 2023 15:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694556497; x=1726092497;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VgfTeRHOaXeKq7GIXd4n1dbiMam+mhX7PrYOlYKyfas=;
  b=UET1boJgRlcA7IWQSGpe7V9mb9ag2ENOpSJ3MhMYicqhKj/3wqiWE3vL
   uJD30aQy27GjiaMLz8TjDIOwBk5WUz82NLN/RkdtPLvEjwky6DUz0VVUh
   wDQlf+VLLbKAq3IQlYLKLiSLHe3RD7+Ukm6WLwEXglCrbQqjeB7LqjZe5
   1//MLF8yCT2ESbBY7LUBFdjDJP4q8lKF7EZKPMiiXg46aaMYKVvXcovhH
   sbsxyjzAVAY1obbRa/QwjvuYCLjQtk2FfxPBTz50RWrL1lnHvXliuEtaP
   XbfGPh/a0tnDcQQUNivXG2WrJttaG2zsePFiRFl/T0HvNea+YtyH8/d6u
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="368770836"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="368770836"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 15:08:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="773206479"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="773206479"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 15:08:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 15:08:17 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 15:08:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 15:08:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 15:08:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axZpCt8sEcwlvcPSToBx4kLDfHnp1f5pAhhsIc/2VXdKcpSfD5EifiBGFxuFrE6wYEg6p13QJjXKoL9t+84En7cRzcQl0vNxszlEzq7iGAp25wYPM0SA0ds7KqBdKzkPVyASRsHyb67EXKCejXtdr9JW0gljL3ZUmXwdD3Q+FgDBcUHC0bGkefqB/mKORGNQPVdpCsjjUazB8oRaLBQ6JxWBu4OPrwUuirl2PTdt73hcOjfSUaXEeDmLsK0Gn/qHskH7M9MpM5RKlaFTv//T8zKgGw8DN93mHdk1pp+HtM7RsbJMXTdiZxvX5daBby3YY4zo36FtolBRbTy//oS0NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ss04s1as/ZnlVqVCVi9GdC0RIXdpAAub5+AcQjprQAg=;
 b=LhkSe0estXZr/pqtuAJ2P7szKhf+qc3j/L9sP+RiIyzDcDSCqr+2E7gBxmgaba5umF+e4ND+54eqifVxlOCOSnOVjDJGj3dtEbjEDQs8D5SyDHWKFZ4MagMgjUumpa8ydbS4aXTh2wsgF0cgjKMdroNffX3Wes9hQzOZJAZINRQIhP/XdiOD2Fym+Ecgzi6/rrgT5slS199u5gwGuNqZIr9ymXH4be2u3kMeXPY9hQJNIbOSwyNk0CRX/LHx/Uei1raFPn/e8fuyM96gDgYDvCW/xYU6G3JfTPN0POk8NrZ+nT67xnw12n22rmvmCh5JLBHYtNHLmKnOBq6VofClow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BN9PR11MB5273.namprd11.prod.outlook.com (2603:10b6:408:132::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Tue, 12 Sep
 2023 22:08:14 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 22:08:14 +0000
Date:   Tue, 12 Sep 2023 15:08:10 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>
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
Message-ID: <6500e14a8588c_314b6629439@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-14-f740c47e7916@intel.com>
 <20230830125025.00000fea@Huawei.com>
 <64f80177c2c21_1e8e7829487@iweiny-mobl.notmuch>
 <20230912174904.00005fed@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230912174904.00005fed@Huawei.com>
X-ClientProxiedBy: BY5PR17CA0006.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BN9PR11MB5273:EE_
X-MS-Office365-Filtering-Correlation-Id: f55b5564-78f6-4092-d99b-08dbb3dcc288
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /BQzUWmT+d+Ei5Ocb3QrRlPY7wv1hGI/FhnwIEz1F/hdqR+oS/I96VNsampm0f6rDKfMbHjB7iQkYPyRx1rfSSfVtYHnCfBufnvdWtdS6P3XVRG3lJ4FrwUMjlrcr3M+Ir2BU/fAAdaksS8ejSTKmOWAOJviShe7X4fI/AqNnmn01cZIqWnKtfG4PWi3PP1NxphZfavOcD46lVdecxjR6visVqgMNXDp1zFBhjqJFxsIywX5v5bRK660NDvaWp8QOs0tkthUD/PNsO2PhGAeekUa15M+rrGS4PRYHA1JidK7JWf5z5Isr8toYuLzOTG/ez1UGVcMv4SdsB679JZYJ6AXJBXfE4ojp6hwDHR0d7FJkVCVmFVVowZmX0AwyfrGlTQKVES/uLVvAcQhRDfq3alLUTm41O8v9ALBI48PCuTsP0phzBkaR+whMHbOoFugiogE3h5VbFipY2NoAgglaGSyycgiwBSuPpRQHFxcPEMnvAXdpU7tc86AzM4j1jnCYLaiNvICe+yNJkBPFHDqSbh4ijD2FnxcQypYXXg3ABd7o97kapUAqDLNEM7GapUG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199024)(1800799009)(186009)(8676002)(8936002)(86362001)(4326008)(5660300002)(44832011)(2906002)(6666004)(38100700002)(83380400001)(82960400001)(6506007)(6512007)(9686003)(6486002)(26005)(478600001)(316002)(110136005)(54906003)(66476007)(66556008)(66946007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yHvKTDcRO691EVl9nWo7+xXbZVoDKb1ZbOTl4IDuU1gB1GZqXE60QCCykuSs?=
 =?us-ascii?Q?/kmlr+l/j534zz4Z3MsYkP4gnLMNQ6IV0gn4P+2+u+8/9RU5C+PY/EP1tt0R?=
 =?us-ascii?Q?JmDGHhbBnBPDMw4tPHCIVInrT00DZr00d6eldpEtHwi12CTk9nThGKt2gDR1?=
 =?us-ascii?Q?yEWj4aXxu3J7GrBGyt1VvI8+0r4nNDwe9r6lqO/lzJTAolDufLDHpkIbuFgJ?=
 =?us-ascii?Q?KxECewUZI+SqMnwMpPMiuXFOfsyxp1HtkV73mGzvLFhVUweR6NNXxLwD7MGw?=
 =?us-ascii?Q?yQLDziZ5uVU6goceyzi3V9OJ8iVU8pUvNJzIpVDyBGLfPtajeIRP2mXYflJd?=
 =?us-ascii?Q?qnSgI60ELys3gdSfSsAC/42tz4fcyE6JYCtiKZg1XkxhF+ij5x+5IFQW8Ybc?=
 =?us-ascii?Q?O5EtD7kSFUnZSNcW5lLXdiMSPcaHxFxgT1t766J3uUVGJlYi1KraXaDKY8O2?=
 =?us-ascii?Q?YsUDm8j29p9K1c40Tn402yZC+n9fNIUW4t4Hgn4oneJ07nie79eNoK9AkvbG?=
 =?us-ascii?Q?3qAE90C42R6DuXJ9BxAkrM+cytprpDGAEK43NKOAwb4HhnWJzIl6r/VmfcF0?=
 =?us-ascii?Q?pQYsG9MDvGryxgTqbvhGYvmw0iH76i0CPTLxONLTRGRENtF4ZgtuK1qcHHeC?=
 =?us-ascii?Q?cOabshlS66BWH4xZ5tLlieB3aqyXxtv1rZzganZSGVLBA3rHfpiAr4IJd3QZ?=
 =?us-ascii?Q?Ocrxt1/GskM5r/fYGnNnyjxxqXXp2UTcl2lUfvJ12tNS+W+rPTFLcy/vkurk?=
 =?us-ascii?Q?uiiRpR2kZqjOAUKg8byxTGCS7Kyv2t2Z8nKzlKKMwhi9tEbbIKMqszmrRVM1?=
 =?us-ascii?Q?syqGRoKcsmJJKByf5pB87dVHFMpd62Go653iBEmBZXLmRwyDyLnTi44xdxic?=
 =?us-ascii?Q?lo4bCH3VJasNI8AtrT06As1tXMoFj+PGNCOdJWyJAYTBCgfZsDh+8+zrdd3m?=
 =?us-ascii?Q?DDzKbt0yqCZu1r66q6sxlDMq/vZ/1Pq0li2Td63DpkoJBaw6pLCOLYrANffL?=
 =?us-ascii?Q?4xemOy8VkxtZcQ3v/xL4Evx65tfw9LrvMkQVBT/5tNG9JYOQ4pMqu/PTy5fQ?=
 =?us-ascii?Q?vmLb+cnT4QJzOzwk6H03CcXwSxnPQaYr8G4w/Bx50c4lKeFQofEFDD8tbgUg?=
 =?us-ascii?Q?Lgu+6c5s0PzPi40h0Mim47OiHult2nw7YSqYbQ8I07+5OoKMLapnEexNkHl6?=
 =?us-ascii?Q?mN92itU3G1FXLbS2y7PdadqyNF+CW/fCFHR0+KAn5CnoNagucnuEWWDSH/7O?=
 =?us-ascii?Q?e73IM53bo3WT1eKMR6p/9syuNa0SUd9+j+7hYw5tpvdvgdLwneK/w38ZuHoS?=
 =?us-ascii?Q?1LUiaS7sfmRF3E5S8nivXdeMc9w78PvUNWTvqyLu/OpB9A6V0/CV6PzsklUe?=
 =?us-ascii?Q?ep8Z0KCQzhVkNPeqc1ntJqU4+kQoZpm+BKd7JaPQiA2a8AThVr+k6XMY3Nn5?=
 =?us-ascii?Q?feskwBlEQ1WtTlbBw5RuQdwPGHLfUKdBv4Bp6hC1DlnMBX92/413vgAxTKr5?=
 =?us-ascii?Q?R34yE+7M/4LlawPlHjdysS9gotzBDeKTfxK45YdjqYMYGmI6L1X18qoAmC/N?=
 =?us-ascii?Q?QNdIQrPOkgaC55P5JHgoBie3p3hWXn4QmGwhCytM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f55b5564-78f6-4092-d99b-08dbb3dcc288
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 22:08:14.2789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZ2D6kAQHhKk1Ms8pl3NVQnpJSfGahjKSdIdYI4lAQry4vzZBImybxpHiRAAmH4NQFU1n7+YEyOFrP4a6l0Gxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5273
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron wrote:
> On Tue, 5 Sep 2023 21:35:03 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > Jonathan Cameron wrote:
> > > On Mon, 28 Aug 2023 22:21:05 -0700
> > > Ira Weiny <ira.weiny@intel.com> wrote:
> > >   
> > > > Dynamic Capacity (DC) DAX regions have a list of extents which define
> > > > the memory of the region which is available.
> > > > 
> > > > Now that DAX region extents are fully realized support DAX device
> > > > creation on dynamic regions by adjusting the allocation algorithms
> > > > to account for the extents.  Remember also references must be held on
> > > > the extents until the DAX devices are done with the memory.
> > > > 
> > > > Redefine the region available size to include only extent space.  Reuse
> > > > the size allocation algorithm by defining sub-resources for each extent
> > > > and limiting range allocation to those extents which have space.  Do not
> > > > support direct mapping of DAX devices on dynamic devices.
> > > > 
> > > > Enhance DAX device range objects to hold references on the extents until
> > > > the DAX device is destroyed.
> > > > 
> > > > NOTE: At this time all extents within a region are created equally.
> > > > However, labels are associated with extents which can be used with
> > > > future DAX device labels to group which extents are used.  
> > > 
> > > This sound like a bad place to start to me as we are enabling something
> > > that is probably 'wrong' in the long term as opposed to just not enabling it
> > > until we have appropriate support.  
> > 
> > I disagree.  I don't think the kernel should be trying to process tags at
> > the lower level.
> > 
> > > I'd argue better to just reject any extents with different labels for now.  
> > 
> > Again I disagree.  This is less restrictive.  The idea is that labels can
> > be changed such that user space can ultimately decided which extents
> > should be used for which devices.  I have some work on that already.
> > (Basically it becomes quite easy to assign a label to a dax device and
> > have the extent search use only dax extents which match that label.)
> 
> That sounds good - but if someone expects that and uses it with an old
> kernel I'm not sure if it is better to say 'we don't support it yet' or
> do something different from a newer kernel.

This does provide the 'we don't support that yet' in that dax device
creation can't be associated with a label yet.  So surfacing the extents
with the tag as a default label and letting those labels change is more
informational at this point and not functional.  Simple use cases can use
the label (from the tag) to detect that some extent with the wrong tag got
in the region but can't correct it without going through the FM.

It is easy enough to remove the label sysfs and defer that until the dax
device has a label and this support though.

> 
> 
> > > > @@ -1400,8 +1507,10 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
> > > >  	device_initialize(dev);
> > > >  	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
> > > >  
> > > > +	dev_WARN_ONCE(parent, is_dynamic(dax_region) && data->size,
> > > > +		      "Dynamic DAX devices are created initially with 0 size");  
> > > 
> > > dev_info() maybe more appropriate?  
> > 
> > Unless I'm mistaken this can happen from userspace but only if something
> > in the code changes later.  Because the dax layer is trying to support
> > non-dynamic regions (which dynamic may be a bad name), I was worried that
> > the creation with a size might slip through...
> 
> Fair enough - if strong chance userspace will control it at somepoitn then
> ONCE seems fine.
> 
> > 
> > > Is this common enough that we need the
> > > _ONCE?  
> > 
> > once is because it could end up spamming a log later if something got
> > coded up wrong.
> 
> I'm not sure I care about bugs spamming the log.   Only things that
> are userspace controlled or likely hardware failures etc.
> 

Understood.  Let me trace them again but I think these can be triggered by
user space.  If not I'll remove the ONCE.

Thanks again,
Ira
