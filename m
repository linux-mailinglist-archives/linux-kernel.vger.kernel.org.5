Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C04479342A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 05:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbjIFDhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 23:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjIFDhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 23:37:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B73A128;
        Tue,  5 Sep 2023 20:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693971435; x=1725507435;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BEhDvMys6aNAZ6aKLz07QUSQiYDm/jAne4aaaqGD91Y=;
  b=nH4/zuXbrgO9AqmdRc+vXvKeJDO+rGFG5ffO+lTwb/WnSma2aLIi8Mgj
   cImUIggJyi8bWRjFegYgnbkYOSgTmvYEwkoo96WUKPTY7RQBm4MqiP7GY
   1RrxsH1uagTrL+Vgzz8UGp5rInnGuj+Pp1RtZTrgDj1vnJiWLiUn54glc
   9d07ynyVEEou4+RpGD8DVLs+Wlz/b2Tr653eAY/QNSpw66qvu4y76QaQc
   kjiWGkWvzh7Rt5mux/+7H7cF4sJrKq5DBjRXy/zkoYavvYzzjhAW7f/OJ
   VU2cH3M45supmJrX+y08T5kryZ9A97l3tXav8+ocycVAT63aa9guyUFSx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="367179210"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="367179210"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 20:37:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="776430874"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="776430874"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 20:36:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 20:36:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 20:36:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 20:36:54 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 20:36:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpOFCAIZJfypNgDAVCQLv85cxKfMQAZYAYXDhvaiaB6At0ng16iIarzFvI3VXSIcPMtV2GDNDzPtFJXpd7t0+t6LzD9Ixz+sA5mWRb+OjiwdohrdZLCgPcWfmfykI0KDrEx7Q3GXS0aCAEvkbkxQGeUMU/3DB7uni/ONkPqoU83nkYNwfTfYUi0tmdNIYFIfvqK1cxNfwPHmmSmwZrRnI6qZFB/shXSCxKFQFGzRZAxmPL/9gkWuEj+2xTT++ek+A5JsQopOPHd24b0OCGZDmvCvMVYQOA0LlUXPRuZA9ad33vNa/ThAkajz9f9GTX3OKp3GmSOrz3W/g23OyEfqlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpFirkmfqh/oZD25egw8vXlVk3DSYmyze2gSrqf/RzY=;
 b=eUU0tgypDdCXYkHC2t4XfcfiO159wog5D+Skgrox+Y8ikmhArciqIErQRa6aanF+IgEezrAtoOCdMC7ng62jOt+Uq6CAuIiCUd25JLpQfs/HULmZgJuUZBZB+weD9Nb7Y+p3fyPNrTH8/EI9DoVRAZXAmimBPaNvJV5WBFawjgwAmZb3jJRu1EQNG/kmyZ4QKt65lSrCftDf1PZFUIp+eULMeC+KC1uVTMIzNnoiNdWvcradk80qBUo1uInKyRvVqrokFigMXJGNZMrkPKCbZ8pE/F+ZXFc+hpPG5KF0b9UlzIIJDiNkk64oku9hBuVJt4+Mr7LdWRm/s/7C6QcigA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH0PR11MB5048.namprd11.prod.outlook.com (2603:10b6:510:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 03:36:52 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 03:36:52 +0000
Date:   Tue, 5 Sep 2023 20:36:47 -0700
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
Subject: Re: [PATCH RFC v2 11/18] cxl/region: Expose DC extents on region
 driver load
Message-ID: <64f7f3cf14b0e_1e8e78294e8@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-11-f740c47e7916@intel.com>
 <20230829172048.000006fb@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230829172048.000006fb@Huawei.com>
X-ClientProxiedBy: BY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::12) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH0PR11MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: 796a443e-9e0d-431f-6dea-08dbae8a825d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0AEAvFqdndqTkde9K566F2Ep0/WTfV/Tem2/aKz1mHi2T/Owl25cvDHN4uB7Xy/yXnNW/k7fZTtgqJ0SbHUGVESDeqaifnp0XBviNDDg9/cvkbg6kyCg8crjuPfE5mTW+KV1A80ZxGg74Dp48VaXEkvcUtq8sdzGg2TEpDMz5QZh6uXlZLxBIULdWcWfmVYrhtMv39VUxnmY5vQ9lNyPthwzrIbto+fofr3c/YQcpn4H1uKtbIlX3cGBsbF0JRVI89dEe7gCUZSxQPUzQOf9pYxCBNwMQ19or2fsOAvyAijNoLeoAt/vSvNVm/vktwxJj1yujxytUwP+l+1yuzpXZDSibgowT6J+f7DSDx1vO9dPj2usmrOhBkrEMyMeoG8YI4lT+VDxdXHRxM0/vk2VzGsyXYukao52viIy1AvjaRI8EyM+m7Zy93IGscQHTIS66dMMdMkxMt16QEpQWqQHAyHw708VLqCm6/Hmki5FOC5RFg4ohagdRVc14HNyAc8GX/h78ODB3C2MBvr/CBn44bb0oGS8F216QphR4P5IXYS7KpvoHBKJtUAk3IHHoveP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(39860400002)(136003)(186009)(1800799009)(451199024)(41300700001)(5660300002)(26005)(2906002)(86362001)(38100700002)(82960400001)(44832011)(8936002)(4326008)(8676002)(6666004)(6512007)(9686003)(6486002)(6506007)(478600001)(110136005)(316002)(66946007)(54906003)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qDP+TbB6XlyKvvfmV29Vo82At7aRgL76Cst991zIpz8YFl8AiWKh0tOynJXl?=
 =?us-ascii?Q?pvzdm53l1jpkoGNfPTo8XfGBblsWa3vMV84mGCLV8mCl1M48cPSlEKPcQH2t?=
 =?us-ascii?Q?H7+9uxEWqNIlShDbMcXAEQIovM7ttOm3/dTSJRVBeiKbsqPWpEkOuZhy4X2R?=
 =?us-ascii?Q?BjmFamtN1namATl4cORP7YNtmVD/oTTOx30jAue6XunOHufm01Nqw/SRdffV?=
 =?us-ascii?Q?8xjK/zvDJ/9HGyYV3sHKFIYTttc48ItFGYy0VhCwqkyOps0MbHYB1c7hEu1c?=
 =?us-ascii?Q?fCEVlCRViO4JqUbmtT2HJvynMvqRvKw+F4qrT4dpsGHcKiRN4fynmlLQggOk?=
 =?us-ascii?Q?+46MDRd4NncMJu3lVQTxQ2CiDVP+FxA3pnzzISFVkJgnLiZM+yZnUhaaaaAC?=
 =?us-ascii?Q?z95W+nKlLEl0Uz7WFTF3FbaVa2kYSpms+poJqMrGdA3N+i8zB5G0JzeIMOso?=
 =?us-ascii?Q?8KIijSedvSTIcZu4QCzjKEfMzDKpQ+z+UzzrvRA5vcsTaweyVTuumX71//3K?=
 =?us-ascii?Q?1fHRCcOQ69MxZ7UAtZ1nT7Kf3oFhZ/vxN6oSJHLqnYhN95L3amn5lAX7hxOd?=
 =?us-ascii?Q?aiRX2AnY993Wuy0Ftt21ey5biID0G5ytcZB31kXVEHd9sHgk50CAOvbj759E?=
 =?us-ascii?Q?kfCpgrkR632+N5UJQrPD9WROmXBF4spNZ+OX3LMdgnDBhY3fWTaxK1LlQkLi?=
 =?us-ascii?Q?JKYFw3OGSCHXOUq3SfrYZKnhvoOZdGAgcIA/+VsHa1Y/fJ/pSyvrfqOAINLo?=
 =?us-ascii?Q?h4UNmX5dMgOyoWQSo/gqSN8uYnUGjqoKFY4T6u7OQPyN4VtsguVAjB1D/owo?=
 =?us-ascii?Q?/LHyYDhyYut2pjaS4oVDiKMKOGROHrZ7PCtL6cA1EIgmGoLUxWsDXtUvAVL1?=
 =?us-ascii?Q?pS5cZYaB0tUh8OyKYgO7+9+gO7OTYaUg3VAGgeiewAW5FO3nGS8kB6jhL0Wx?=
 =?us-ascii?Q?2jhTkGrmyFpaVo18URsVwQAP07iMtxUYXq/ALAWzkkEOwCkYgRvITcUwhQP6?=
 =?us-ascii?Q?FQYVaJxgjn9S0fnYRNtzZ4ryPAurRt+D3PAhTcrWtnJ3vNJqxCg0jk742pYG?=
 =?us-ascii?Q?m5Gz6ll1t0DDxR6fREMA6zbide1ss5ENtExV623hcq68Ni0Uuhk/tRYcr0Fv?=
 =?us-ascii?Q?NunqPbC74QV7t77GCXRinv4XXybfm+pl7cR/CsNjS3K+B+0dUGPiKE9UpKpF?=
 =?us-ascii?Q?GjKtGnMTWLthnG+igZvlWVqLUFBz3HsPatnLc0cxGeboqlK1TuNknXkR5ep5?=
 =?us-ascii?Q?hRiDXCTdelKLov4dvhi1sj3tA0jUhTUt/4eP7tDveNnuLtJ3wNLMIi+7Umxl?=
 =?us-ascii?Q?l130aF3ofZTFuDzrmk/YeNVBsvU0BXMOLTVfjXt+3abtdsX1VAiIUZZb6nae?=
 =?us-ascii?Q?jKdNj0iS1W2u564iUBzZnjVxK6yAtxkom+ig1h/hW7pnH4AFR2cvWIaesI7N?=
 =?us-ascii?Q?nOcQ/mwmigH0b1hVOLeJ89eTXWH4cgth0YOT4ct31J0G5LWzK+uoDrnE6l0y?=
 =?us-ascii?Q?eBhGk1xOX9tIN4ZV2rHWhmMUVCMY6ktM2awG3a4Xe4pcTiOKZBCPbPFhcgZb?=
 =?us-ascii?Q?5dh6ne7kRNtcRnUC75JN5x0MP4PSiBlRJQZQLSYr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 796a443e-9e0d-431f-6dea-08dbae8a825d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 03:36:52.1582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOJ19PE9VKVVFaW73dc1oxSZpJa3iNeiGn00peSobETEHMVFiTJH+yehvdLFUDEhjEbAD6lrXMsNByULcL48Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5048
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

Jonathan Cameron wrote:
> On Mon, 28 Aug 2023 22:21:02 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > Ultimately user space must associate Dynamic Capacity (DC) extents with
> > DAX devices.  Remember also that DCD extents may have been accepted
> > previous to regions being created and must have references held until
> > all higher level regions and DAX devices are done with the memory.
> > 
> > On CXL region driver load scan existing device extents and create CXL
> > DAX region extents as needed.
> > 
> > Create abstractions for the extents to be used in DAX region.  This
> > includes a generic interface to take proper references on the lower
> > level CXL region extents.
> > 
> > Also maintain separate objects for the DAX region extent device vs the
> > DAX region extent.  The DAX region extent device has a shorter life span
> > which corresponds to the removal of an extent while a DAX device is
> > still using it.  In this case an extent continues to exist whilst the
> > ability to create new DAX devices on that extent is prevented.
> > 
> > NOTE: Without interleaving; the device, CXL region, and DAX region
> > extents have a 1:1:1 relationship.  Future support for interleaving will
> > maintain a 1:N relationship between CXL region extents and the hardware
> > extents.
> > 
> > While the ability to create DAX devices on an extent exists; expose the
> > necessary details of DAX region extents by creating a device with the
> > following sysfs entries.
> > 
> > /sys/bus/cxl/devices/dax_regionX/extentY
> > /sys/bus/cxl/devices/dax_regionX/extentY/length
> > /sys/bus/cxl/devices/dax_regionX/extentY/label
> > 
> > Label is a rough analogy to the DC extent tag.  As such the DC extent
> > tag is used to initially populate the label.  However, the label is made
> > writeable so that it can be adjusted in the future when forming a DAX
> > device.
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> 
> Trivial stuff inline.
> 
> 
> 
> > diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> > index 27cf2daaaa79..4dab52496c3f 100644
> > --- a/drivers/dax/dax-private.h
> > +++ b/drivers/dax/dax-private.h
> > @@ -5,6 +5,7 @@
> >  #ifndef __DAX_PRIVATE_H__
> >  #define __DAX_PRIVATE_H__
> >  
> > +#include <linux/pgtable.h>
> >  #include <linux/device.h>
> >  #include <linux/cdev.h>
> >  #include <linux/idr.h>
> > @@ -40,6 +41,58 @@ struct dax_region {
> >  	struct device *youngest;
> >  };
> >  
> > +/*
> /**
> 
> as it's valid kernel doc so no disadvantage really.

Sure. Done.

> 
> > + * struct dax_region_extent - extent data defined by the low level region
> > + * driver.
> > + * @private_data: lower level region driver data
> > + * @ref: track number of dax devices which are using this extent
> > + * @get: get reference to low level data
> > + * @put: put reference to low level data
> 
> I'd like to understand when these are optional - perhaps comment on that?

They are not optional in this implementation.  I got a bit carried away in
extrapolating the dax_region away from the lower levels in thinking that
some other implementation may not need these.

I will still keep the helpers below though.

> 
> > + */
> > +struct dax_region_extent {
> > +	void *private_data;
> > +	struct kref ref;
> > +	void (*get)(struct dax_region_extent *dr_extent);
> > +	void (*put)(struct dax_region_extent *dr_extent);
> > +};
> > +
> > +static inline void dr_extent_get(struct dax_region_extent *dr_extent)
> > +{
> > +	if (dr_extent->get)
> > +		dr_extent->get(dr_extent);
> > +}
> > +
> > +static inline void dr_extent_put(struct dax_region_extent *dr_extent)
> > +{
> > +	if (dr_extent->put)
> > +		dr_extent->put(dr_extent);
> > +}
> > +
> > +#define DAX_EXTENT_LABEL_LEN 64
> 
> blank line here.

Sure.  Done

Ira
