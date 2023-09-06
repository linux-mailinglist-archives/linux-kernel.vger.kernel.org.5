Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10090793452
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 06:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjIFEMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 00:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIFEMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 00:12:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD921B3;
        Tue,  5 Sep 2023 21:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693973565; x=1725509565;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ttcaR02VbTbi7xk9rfwPd2bxEaqzYEThyKCJOZQj2/U=;
  b=bXJBvYd7iD0hR+uQOH/QZ49q2YQql3bCC/LE/myHupcf+p1efYzgBMB/
   VrOOD99RYcb/kQvyWiAJyRsxk47kOJz1H3ueR1AZWSJ26jwFBO8rlpDUc
   4yxeeakYHzfdNXCVdGS0Q2ZmnvM/D1PtN7ZunXq2PwrP1ws2hFa+ELDA0
   mZQttE/jkCQJ1cTs7ow3ko96bheW03gHMtgNGQThLNcBavPM8N+FtRFKs
   UoFLwBjqYOmhkOYHrdMM14NMezcoHeVlwxC4D4NNtdcpw69soGDY4ZymA
   NE0Hoh4ZMuM0LsyhecsmFOet+cRDrqSxJqlbXzd5ribZ1lwqyCJy9EjxL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="357275637"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="357275637"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 21:12:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="884542203"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="884542203"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 21:12:35 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 21:12:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 21:12:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 21:12:44 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 21:12:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JvdCb/EvWrcPFUyHSbPy8lnttq+o28l0QbKcOeFsBTqv3kGorWg81kNAffO2127KIJ7t1tYfGAoWwCru8YwlsVm5crfFoBjNSjH4GGS1FMazpxFZSrp6Le5+7is+XcAWD+UoUzzdhrkB0RpqSR5ba1ED24UqPCmfAUrAajeEiDVCXaZVDPn0eiSIuXcBVIloonQKiuiuqXtHvpy/pye/qe2KqQpua68FJrFIpAYN159XvxrzyvqC7Bdz9nR9U3sObFfJx/o6dB0gZCnVPqznB4mx+3saflGi/zmefox44+nv2asBqAKB8lt6X73b6e8u5QamwQ+j5JR+Uxvw1evUpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKumtsLS5SGQx7avUspj0UWXIUmdzi1b7CAqAW0NbiE=;
 b=SmAKwKhwbQhYvPqrE8jgPJKs2NdQGEFyACfXTPIbzzMA/NI3zLBPuDKJPFySmDRdbzNM7skKSJjQ2rXgzbPaijnURaS+Kn2Ubc1u7ZK94ty4qwvmWzlK9V6RKLQDoffyj0uqexvG42p0gT4UThjE1zoU89ssGx/Yw7SWoX+luzP1xla5PPb4pkZXpu870EULov1/uhLm2NXnPYSyPMtDo2NMeKZ18JD7lhq4Zuydx6HKHNveEj4qqYca3NelmpoRX9Ua85rehlOcYyh4PTW8hYhMfANtVIyyIiCH25G4Cx7PDL6DMR/VvhNKn5ylYx5mK2sJ9s9rr1QAfZetugCBiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB7049.namprd11.prod.outlook.com (2603:10b6:510:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Wed, 6 Sep
 2023 04:12:42 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 04:12:42 +0000
Date:   Tue, 5 Sep 2023 21:12:38 -0700
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
Subject: Re: [PATCH RFC v2 13/18] dax/bus: Factor out dev dax resize logic
Message-ID: <64f7fc36a911a_1e8e78294b9@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-13-f740c47e7916@intel.com>
 <20230830122741.00007628@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230830122741.00007628@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0158.namprd03.prod.outlook.com
 (2603:10b6:a03:338::13) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: a5fb5a4b-0116-4192-1ceb-08dbae8f83e3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OB0d88kGbzHKzp/mwL0LULVcV/V2LLZ2Gazo0bgYtoV2hvVF1JVONLSlH8hz/YtsiFmqu93b8HKKHoSPhB2Vv2Tc0kGL2/H8tR32G152SHMEZw/PV3MZ57dxpakAFb6dcmDIEaIv7nfrMDHLpK0z7Sr3p9GDUANV0grQEo3ZqLajsti/BlLStNRIE+BdpxmNtSTCLt+gYSOsxhxbkMbMHESvbKydYzZXz1ytsyZ8L0AfawXG9F7UVWHI5RD7wg8QDOAzPLOX1vduYElKkRxISLct/Jz+yfFvRzyhzKQl5EjuAbNdEfa9sTlIXkcMY7+jjJiGDwoL7IWnob7NXAo2hsuUnzp07DJjqUDQHN9efhZh/YGm3tn+piADarToIcFez7N3h1OlgOgz+OrDUyoHsAyTVoCpnKgioGa309zztkk2DxVNOWDG0Xey7VTmlsmI0tUHtEdFmgzANAreWbba1Xvifq2xGaPgptGNBETjUG494dxvB2nHQq8Jz/KCI4cqXfHXJXfD2g7JfxgbDLGYvshr/MRtQ3ZDBVT4xOdW6enrcJVKp9NTjeeDfdZeWkDV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(136003)(39860400002)(1800799009)(186009)(451199024)(26005)(6506007)(6486002)(6512007)(9686003)(66899024)(38100700002)(86362001)(82960400001)(83380400001)(8936002)(44832011)(41300700001)(66556008)(316002)(4326008)(110136005)(66476007)(54906003)(5660300002)(66946007)(8676002)(2906002)(6666004)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kH7J/6i/ZMzoesh+mbogkyVpCR3p+C5NGH2PHxWgyJnsxZwSqwna1L6SIvJB?=
 =?us-ascii?Q?b5/bJ6a26Ziord8S/EFfc2Yw8JjlqC/Yb0fXulRn3/dva6jGpvABbChqXehQ?=
 =?us-ascii?Q?FTCBvj3U5anSzXOCGqFKmFslDLkbY9PuLcicqRVV3WVbnDKBjMSWfnmDaldQ?=
 =?us-ascii?Q?RalU4TNKMY4T4pyu2nM6Tv/cqFQQQ1Nr5xsdEhPVxrkssMkLHzpYSLvNuX0c?=
 =?us-ascii?Q?zusUirg/q6CtMJ7oa7Z8UrkO8zCDpxcpjNODB7DZWsrBzcTru/0/sQEBVmf0?=
 =?us-ascii?Q?4Sk6ysJHfZ7N1XRFSTOp3otpA/QutCFrXcyQTtyevuKQ+wS+CwHScH6iG8iG?=
 =?us-ascii?Q?Hqjpcxw1VJUu8Bw7wSTwlz+Rdh9/86hkrFrOuREZHOsVjmsyXBzLg34nR59V?=
 =?us-ascii?Q?qh592eEr9FuHxQ5v2btNMM7/wFEnSChGatpKNlw0rowcMebW1rQB594AzVd9?=
 =?us-ascii?Q?J6knaW8J0m7i+znE2NtHLhpABFm+Kgx4+aYkZHMZQniG52cI3/M9B4lz+kaX?=
 =?us-ascii?Q?0v0sOSKCQHSGJRFL9ZYR7+gwUfyT0Q3HqdLHqLQ0Mx9TSn1FJKW3HTJY1Cx8?=
 =?us-ascii?Q?nVYnMUEgJAovYwa7bUUMgMFKXqv26o6HlFlApPZ2aBTjvXUi1o2qMZ5YFCSA?=
 =?us-ascii?Q?+MYAHpq/tBTUasdZ+DntoDKccjabgVpkffp4JPvpTUpkxrp3z0n/KbgY0eYy?=
 =?us-ascii?Q?o9eetrd230JErQbtDDfJpBjKrfQsTxpsHVzQnuNFjZMB435h3NyOPHtFFt2R?=
 =?us-ascii?Q?8RcHPwAN+DghZKtDpTiSEv82ZkIkY5ZzVhs1G3hD60EbAhES+XnwW5ZIZokJ?=
 =?us-ascii?Q?pl65psjALC3/Iej4Z88QWkEn1SUUKVftJ4jte5HOT3OCjNkT751lEm6ZZDHg?=
 =?us-ascii?Q?d4+0xIop2giqTecwzFl66jIiaPnt5o+AjTQetgr3d0IMGQRH1ciWlcDewcIh?=
 =?us-ascii?Q?1szV2HbZDG+oimiA1Vy+3FQIjVLnB85ctrrVzC41B4zGTX63vOwkyxRELRAY?=
 =?us-ascii?Q?0VzBmokmCaOgc3hh6aYhqudlKHqEpKVoLvugMqrmFV8FyVIB6N6LWYPZ6GaI?=
 =?us-ascii?Q?YbmUbvhtC92RC3VnhGtxuiJlFS2G/5vlD+BgAupYiU5mnL0LHXOSnYG14VMj?=
 =?us-ascii?Q?VMS0q5YRI+1JY7MPe4K2J9qp+pcSMEfV6Ib+7lYcvI1BuUgQPRKi1KauZ/yY?=
 =?us-ascii?Q?R2dDR1QtQTIkSC5TQM0Y48W+2DBeoQEFZ+Wl/M7uxC8vYDXIsfbhD2SKqAlP?=
 =?us-ascii?Q?WtPdR8WytsGMrowP7x2FTADC9R7deHDJWzgq41BXhJjWWAARBamxxIjdnUmS?=
 =?us-ascii?Q?buCu8G/jB5tp3wTeE4WvK0HwLlutkLaeDZ9SP7QoF4muWJc7J+eSH8haRCnD?=
 =?us-ascii?Q?WfMoss0WYG51OzYIUas4HwByKsy+nOoTtMG19W5feAOjglv3/R/n+FAxUvV+?=
 =?us-ascii?Q?5WCbzQakinImg9pcvUBlZyc5Ma2YZdvIpKNeeuF0+aS0ZmU2dCxXNtafReO8?=
 =?us-ascii?Q?4ox/5YY1QFXoN3i16VDMv8HQnNc1JdzTLS2DNZsG9owf3jo809dd916EFM7Z?=
 =?us-ascii?Q?TlrgmSGpihraRh0xaLq8CjLDEsFHGKVFDooEqfuZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5fb5a4b-0116-4192-1ceb-08dbae8f83e3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 04:12:42.1131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QIPE9qnQC+Oz7vfoE8yhLw9dXSHCiWbgUl1ESl6SDYB4XRQ+nLOWEwAHe7zFIs5ozv3h2tAlLgRGW5Rs1zMIjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7049
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

Jonathan Cameron wrote:
> On Mon, 28 Aug 2023 22:21:04 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > Dynamic Capacity regions must limit dev dax resources to those areas
> > which have extents backing real memory.  Four alternatives were
> > considered to manage the intersection of region space and extents:
> > 
> > 1) Create a single region resource child on region creation which
> >    reserves the entire region.  Then as extents are added punch holes in
> >    this reservation.  This requires new resource manipulation to punch
> >    the holes and still requires an additional iteration over the extent
> >    areas which may already have existing dev dax resources used.
> > 
> > 2) Maintain an ordered xarray of extents which can be queried while
> >    processing the resize logic.  The issue is that existing region->res
> >    children may artificially limit the allocation size sent to
> >    alloc_dev_dax_range().  IE the resource children can't be directly
> >    used in the resize logic to find where space in the region is.
> > 
> > 3) Maintain a separate resource tree with extents.  This option is the
> >    same as 2) but with a different data structure.  Most ideally we have
> >    some unified representation of the resource tree.
> > 
> > 4) Create region resource children for each extent.  Manage the dax dev
> >    resize logic in the same way as before but use a region child
> >    (extent) resource as the parents to find space within each extent.
> > 
> > Option 4 can leverage the existing resize algorithm to find space within
> > the extents.
> > 
> > In preparation for this change, factor out the dev_dax_resize logic.
> > For static regions use dax_region->res as the parent to find space for
> > the dax ranges.  Future patches will use the same algorithm with
> > individual extent resources as the parent.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Hi Ira,
> 
> Some trivial comments on comments, but in general this indeed seems to be doing what you
> say and factoring out the static allocation part.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks!

> 
> 
> > ---
> >  drivers/dax/bus.c | 128 +++++++++++++++++++++++++++++++++---------------------
> >  1 file changed, 79 insertions(+), 49 deletions(-)
> > 
> > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > index b76e49813a39..ea7ae82b4687 100644
> > --- a/drivers/dax/bus.c
> > +++ b/drivers/dax/bus.c
> > @@ -817,11 +817,10 @@ static int devm_register_dax_mapping(struct dev_dax *dev_dax, int range_id)
> >  	return 0;
> >  }
> >  
> 
> > -static ssize_t dev_dax_resize(struct dax_region *dax_region,
> > -		struct dev_dax *dev_dax, resource_size_t size)
> > +/*
> 
> /**
> 
> Suitable builds will then check this doc matches the function etc
> even if this is never included into any of the docs build.

Done.

> 
> > + * dev_dax_resize_static - Expand the device into the unused portion of the
> > + * region. This may involve adjusting the end of an existing resource, or
> > + * allocating a new resource.
> > + *
> > + * @parent: parent resource to allocate this range in.
> > + * @dev_dax: DAX device we are creating this range for
> 
> Trivial: Doesn't seem to be consistent on . or not

That is because my brain has a real consistency issue on this...  ;-)

'.' removed.

Thanks again,
Ira
