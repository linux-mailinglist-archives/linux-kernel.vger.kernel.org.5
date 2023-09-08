Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C4679927E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 00:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344350AbjIHWwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 18:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343518AbjIHWwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 18:52:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69B11FF2;
        Fri,  8 Sep 2023 15:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694213543; x=1725749543;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GHCHiXxfnYK261wCTR7MpuONj+/ivrscm5Pcs+oQoog=;
  b=G5+kx5xeZy7/BfG6baHJzU5/7L0abHZiDWLs3q2pODlX1RWpFFvsd32M
   +tWQxXyfQIZp8SPlgRDCUGwijsC7HWa0brr0fr2VIjUiZPWNNIhwFL6v2
   jZG8MfCZS1Uvqs5YKRO/Zc1MBO+NACm0wWNmtguI9oWiGdHxLAg1TRZE7
   LrdgKiO5+Y8LS4x36sBVgIJXVxvefVZTMUxoWnyoivt3Kv1AfiF0xlISk
   jfigmsrjqyd/x93wTHRWiVT4ygpWH5uHtyBRAkbCKMKpJ7j8thY+R9o/t
   OBzRsZbb5gWsLL5yYBrd5wvzUxsMJRUyHQehtuKIJjB/lt+R1xOLQEcLo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="380494744"
X-IronPort-AV: E=Sophos;i="6.02,238,1688454000"; 
   d="scan'208";a="380494744"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 15:52:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="916349241"
X-IronPort-AV: E=Sophos;i="6.02,238,1688454000"; 
   d="scan'208";a="916349241"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2023 15:52:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 15:52:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 15:52:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 8 Sep 2023 15:52:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 8 Sep 2023 15:52:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHcRhTlOpOGW+iUf/p6LzxGiy3o/jNhAif0Qgnqq6rKPS0HDmnTQVwOcbM8Ce+7MzPablqgjmo0XLh3Yd5hwfNJdNX4iiANIt4Diz46V3jsBYGaRBV5SYRcptCZuJgIzULDarhTeHlmxMraYamzpkV2fECaDyyP6o+XqjV3J7qwSjxWjwVWiV4V3kfhSgnjM9IJVEAFOj6AR3uGxRC3vOGlH6z/IhGNrovfZFvLj173syIuD/SEwoOmR3CEqXroMurixYFTDX5Ox3SFdOn9av87VrEDw5e2bb8k7mCO7m6bGuJRrJVYPRoFJdnJfb+CizwsAXI+lPgb2E1UP8rFzNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrbbhb9AtETDVO6W3VTyXZSUQY9QI7M0Oj/QiyKwaCU=;
 b=SWa0EXO712wLDQeorl3KQGh++gYsdhb+1zqnPsbL35BrY2GVueYNx/wWOigJg1AGjy1RuAJ1YogvUkk3AJOV4A4+ZxIEIWp1g/DU6bX73k83dTTTyHkgrTw2ZSVvYGlZpiK1Z73/TSj49LQ0XaVuXlWHu05h5br8WNt9iN8uk5CWO5C3nMTU4AsLKAM+fYjx/WuO6sy55oi4GNTcDAQWA7YO37GjR7Z2DT+vjeMf0v1nxKan+88a+wcH88k8WW3o0Jh23nlE1gtShPLS1Funy6VUk2t/WYuWazeMWooTKtjXLpVlhjbEFJrWxFG4s9+nD7gTa2NGA5ELSAtNpLkeew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB5994.namprd11.prod.outlook.com (2603:10b6:8:5d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Fri, 8 Sep
 2023 22:52:20 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 22:52:20 +0000
Date:   Fri, 8 Sep 2023 15:52:15 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Fan Ni <fan.ni@gmx.us>, <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 03/18] cxl/mem: Read Dynamic capacity
 configuration from the device
Message-ID: <64fba59f73319_1e8e78294e2@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-3-f740c47e7916@intel.com>
 <ZO+4Qql0rOslp0bl@debian>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZO+4Qql0rOslp0bl@debian>
X-ClientProxiedBy: SJ0PR13CA0043.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB5994:EE_
X-MS-Office365-Filtering-Correlation-Id: f63bc40f-aeb8-4a95-68b9-08dbb0be41e5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4DD+bVF9wgPWtgh2zXlLnCa3A4TPJjaKnkabjTvozSEZvUorCBCEOoHRCtGFDm3UBE9MVV4/hAqXSDbCPzTTPS5EHfn3QyR24QOFmGiyo2D/dl2VR9L+XLSfA+IbTSGe/c4IB48DVZQI0VYuQi1KfCLMaHlVzXoQePJPHDcpQifv0nY2n00dJxXAyx22b82c4NQFBwuU3dW0Ufn/CeZWdQ6KQdIiJSB90GfEWpJx5msvh3JkrZeQI5+FHHOT4/xhzm11aJagArps+NQ+k/8qMtqUgFNLGoPPoLzvPhpYjAyjN110r/jxsqj4ZivTnmzTRf33veAfWWzJXStNH8F3fi3Ght7kv0xU8TTzuTPyMEdxNXfjJ/IC6nB2gIIi2oCru39BJjjlaosSyB3YWhz+ESTTsyBVNQc1LcmuPmpowsNGUVbMqtrZxwQ/casuMV+dGeup6IN+VwxedKL0xSvM7Fz+0ffUd/Uf9bWxxDDkvWm6MJTCwSB/ttZHpL3OZOBvOxIs4T7NpEwtOZGIOfLPtw89nHm2D0d9Ea+6Vd8FmUhGO5kISdBoJpUtTLC0fwh8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(136003)(366004)(346002)(1800799009)(186009)(451199024)(38100700002)(41300700001)(86362001)(82960400001)(6666004)(83380400001)(478600001)(26005)(6506007)(6512007)(6486002)(9686003)(66946007)(66476007)(8936002)(54906003)(2906002)(66556008)(316002)(8676002)(5660300002)(44832011)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZwCKWlLwUgJc2TJLaczhEafqLtbjq/xT+ipbLS5WMK5HuHg6lOIkB+IO6RCu?=
 =?us-ascii?Q?R4wdeBQFg1rYIXpLCJjHbDGhZx8UMJcey7Cc07jvhAruupKguHjqNjlkLP0w?=
 =?us-ascii?Q?nOa2nPmdI/X5UeefSt97N5DC6slhzlc7+8uFdEO14RUSO3CtYFD4mme8J4Hn?=
 =?us-ascii?Q?9RSShUDSmuDLmR99VrXwkpehiLzm7MXyJmCktNWTO8gbf/3yVxh3i1ygoATm?=
 =?us-ascii?Q?fSF6tOQ4TNDKZSPeWZAM1GNdm3heANxWLPZ0YP8OjmJvE9rnYBUlSQ5ojXEK?=
 =?us-ascii?Q?rgpyWznDHjXZI4r13lm4UWw6Q3+spNKAI1d8ll4oaNTMka8VvAjgl9/Z2IOF?=
 =?us-ascii?Q?CBIa0x7H0zyoLKKZ0naROiJ1pqwvznduBnH/j3e9FzCHSB0qN8YOEwLaegG7?=
 =?us-ascii?Q?p5DP+4j+RJCwsZ+fSjQ1JQjlo8Sl+iGXBAdE7W9C7/GBPdCAwTqi8RII1P3K?=
 =?us-ascii?Q?iuMs+MxsuUW+Jv4gtu5LK+VbWakbJdEaDVpAazHcGNRTLqYiMGl/ReC3ww4i?=
 =?us-ascii?Q?QSooK7W8M/ZGSTeHi+zvFkFyakqWDS+QXJSvbpK/BGBS41RADFAU8Db2/fJD?=
 =?us-ascii?Q?I9r/BOls1rgzWRi62Lr+yXJt2mpGJggX3iNc9x70EM+nVe0KYLGKP2tGTNo1?=
 =?us-ascii?Q?iHJo3FhHqSX3ssDHUhYTMwFvOjjgqJpQN/eONM9rK0yoPStvq3V6v+QuGQ8m?=
 =?us-ascii?Q?KdcYckTPwrp86snCX8wbWDmp/ElQdpvPlvsKiAfw1xBmkxqZlr85uharLIPF?=
 =?us-ascii?Q?8ibUD4NObaUJCj0+UE7oHI+BYSAsDioZfT6kqNO0MUraiH45ERZiq6+Q5RgR?=
 =?us-ascii?Q?ptkottU3GOMUD8CuH/5IPXdW+SQ/M3njp4j41b1ikPFj+haJG1bx2g/N6CPc?=
 =?us-ascii?Q?GrXb/ughrsWh7ByONOfQIMuFHmsuOYJN+MOWO/RTEiA38HSBWlZ825MZ1zDT?=
 =?us-ascii?Q?U9K0S/3Z27B3FFTipL/nXw4hRJ3nhusauagRkpfBnJFYGZECIka0yOi3WjYQ?=
 =?us-ascii?Q?M8t55BILcQEi2DZOfZE0zUsjHJqGjU/jXhcs/uvzqpL4V6yiItj5UVsbHfIX?=
 =?us-ascii?Q?gCkY8eLGZgmhvy4H+jyADjrK2v/W1anD6xFvrOgdULCveAlIzxaimNt8yLnS?=
 =?us-ascii?Q?jXlvi24Lpfgy86/FlKYDE8YBYaVmhN+aSLBCRuMMcPlDsm4FbUFXyCV0c5Qi?=
 =?us-ascii?Q?tgqXeYaO0V7kq6t7r0KxUdfu6HWedhqciqw9n4/Gl9aGFHmTZNMfJFfZ5t/q?=
 =?us-ascii?Q?ROz1+Z7m0PQRoimF1WKJDUzy22A/onjqORuH3j14DiUrfCoPh6FlVdnUMRur?=
 =?us-ascii?Q?M/q98kF1JAb5jYLTiJ8zEDH3C1NCffEwZG9WhNu1nvBe/DcumIaQA2lomB/Z?=
 =?us-ascii?Q?MPcYF+sYAhHTlID9zNJTv/0qtdjKJbqx20fi76OD10LkL6KfY/OaIGJVZ7oS?=
 =?us-ascii?Q?s/7YUl063OJv8D5z7Y1o7wxJxVNrADZUdJ8RLTGAKpNfZ3AybO6GtH1shbiC?=
 =?us-ascii?Q?OpMMEeqBfr45zD87/2J36ktSBhjxnlcD0QyCGVTBwfv0eYQukszdU52mprcI?=
 =?us-ascii?Q?jT41s4kkEhDEkNxqYvU36UUC4OGRnEd66H6KXwyq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f63bc40f-aeb8-4a95-68b9-08dbb0be41e5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 22:52:20.0371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvisdOH7/vSzN7K6P9bWh/UaXok+lbFi+yKs+xpc9EmK/nTIFJjXJoFkLExLb7iqQAtUgG75jCKlGnBEg1kFKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5994
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

Fan Ni wrote:
> On Mon, Aug 28, 2023 at 10:20:54PM -0700, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> >

[snip]

> >
> > +static int cxl_dc_save_region_info(struct cxl_memdev_state *mds, int index,
> > +				   struct cxl_dc_region_config *region_config)
> > +{
> > +	struct cxl_dc_region_info *dcr = &mds->dc_region[index];
> > +	struct device *dev = mds->cxlds.dev;
> > +
> > +	dcr->base = le64_to_cpu(region_config->region_base);
> > +	dcr->decode_len = le64_to_cpu(region_config->region_decode_length);
> > +	dcr->decode_len *= CXL_CAPACITY_MULTIPLIER;
> > +	dcr->len = le64_to_cpu(region_config->region_length);
> > +	dcr->blk_size = le64_to_cpu(region_config->region_block_size);
> > +	dcr->dsmad_handle = le32_to_cpu(region_config->region_dsmad_handle);
> > +	dcr->flags = region_config->flags;
> > +	snprintf(dcr->name, CXL_DC_REGION_STRLEN, "dc%d", index);
> > +
> > +	/* Check regions are in increasing DPA order */
> > +	if (index > 0) {
> > +		struct cxl_dc_region_info *prev_dcr = &mds->dc_region[index - 1];
> > +
> > +		if ((prev_dcr->base + prev_dcr->decode_len) > dcr->base) {
> > +			dev_err(dev,
> > +				"DPA ordering violation for DC region %d and %d\n",
> > +				index - 1, index);
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	/* Check the region is 256 MB aligned */
> > +	if (!IS_ALIGNED(dcr->base, SZ_256M)) {
> > +		dev_err(dev, "DC region %d not aligned to 256MB: %#llx\n",
> > +			index, dcr->base);
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Check Region base and length are aligned to block size */
> > +	if (!IS_ALIGNED(dcr->base, dcr->blk_size) ||
> > +	    !IS_ALIGNED(dcr->len, dcr->blk_size)) {
> > +		dev_err(dev, "DC region %d not aligned to %#llx\n", index,
> > +			dcr->blk_size);
> > +		return -EINVAL;
> > +	}
> 
> Based on on cxl 3.0 spec: Table 8-126, we may need some extra checks
> here:
> 1. region len <= decode_len
> 2. region block size should be power of 2 and a multiple of 40H.

Thanks for pointing these additional checks out!  I've added these.

> 
> Also, if region len or block size is 0, it mentions that DC will not be
> available, we may also need to handle that.

I've just added checks for 0 in region length, length and block size.

I don't think we need to handle this in any special way.  Any of these
checks will fail the device probe.  From my interpretation of the spec
reading these values as 0 would indicate an invalid device configuration.

That said I think the spec is a bit vague here.  On the one hand the
number of DC regions should reflect the number of valid regions.

Table 8-125 'Number of Available Regions':
	"This is the number of valid region configurations returned in
	this payload."

But it also says:
	"Each region may be unconfigured or configured with a different
	block size and capacity."

I don't believe that a 0 in the Region Decode Length, Region Length, or
Region Block Size is going to happen with the code structured the way it
is.  I believe these values are used if the host specifically requests the
configuration of a region not indicated by 'Number of Available Regions'
through the Starting Region Index in Table 8-163.  This code does not do
that.

Would you agree with this?

Thanks again,
Ira
