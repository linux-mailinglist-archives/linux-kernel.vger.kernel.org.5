Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904D57929F1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355021AbjIEQa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347822AbjIEEc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 00:32:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A95DCC7;
        Mon,  4 Sep 2023 21:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693888375; x=1725424375;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GeXO9oUqDoCCJAUPxQTKFDJmOVKSEeNtmE0R/2xwhSo=;
  b=PIk2rJCJEn2/S5gkfrPEp7WZVuiBiMAqwu5Pw4zZ7wyjmAx5d7LuPaIa
   XYq99h9nKeSMo+7QdOtNRhn6QN+RZURGvs/AnW9i4kUCDEakUexHmkcAY
   2eareNn2QQQdNngCjJqv0IYACTX47uEwHNXVjyQd/PYgK6bTjNAtuOtmj
   paDHXn4tT1PyH40LOF0VcYLeUwBg2jehR/viIaBzU34pv6zlka4Ug/ohp
   vqHvCUSNEztOLsg9SrIYXfR1dRw1j2cfQkv4vOO7TAvtUSjj/gfGNqqAm
   AVtewbG3cyE8BKdkoKeptEkdp3FE2FAepQxZOHyt08Csva6k9D6WUpAee
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="375590367"
X-IronPort-AV: E=Sophos;i="6.02,228,1688454000"; 
   d="scan'208";a="375590367"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 21:32:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="740977841"
X-IronPort-AV: E=Sophos;i="6.02,228,1688454000"; 
   d="scan'208";a="740977841"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Sep 2023 21:32:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 21:32:53 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 21:32:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 4 Sep 2023 21:32:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 4 Sep 2023 21:32:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W3ffjQo2mH9piglIEeZ5Cb0vUTIm6cGiwETuXpl3Azj4PdA/nmtsOzYG/loZ0dXxCW5RzqCQswKo6XEml9ty2+UZrDiDctbSjBaW/hFpwOvktAn+NX7hsekzh4lx0RKaj3dGFQxhFfp0sVEKOYUgB7qf5R5pQ09bJv/CpxyUkMwetbDWC7iK6J7M2PTTpoBahiNPqHhjiOVHtbdtf2NlnIMrw5njYt7O6MRvdB5/PGD4iYbUHehU7KEMn/tbUnbMPq/kQA8fTYB5FYzp2t3e0OWqyVbkrD6aJjohVxVfe7HDLFnkJKk2/fmej0ZvBFh70uFa1W0HfBdQRBI4912vlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9yvn5TJ+H6OEM6BbXniIe4hKvfx9og6I2U7pT3XYSQ=;
 b=dA/HcDVL5P2QGA1kRWVEgPDcMtUZweyF3CT9sgZ6SEhS7lCi9Q/e12yTKwe5LPDzFxwRbD3rJ/i7lEiVMOv/nD2t7dQTC4fCK/TgIItBPM9B6dw2JhC47fqSx0h/gFAXXMtQVZEqA5gKTl5Z+LXcv9mqgB9hsHmgSb0bj0TUPRtPZVE4nF09i6recCpNh3MceYp6WZOyLf2fUgKy0LDVEDooV+r9PnUGcuObVQCi289jX5PSL2GuqXIauDZquyGqhBNq3AIgEHOUzwfvajjXcXxL28vHkvA+ROcI74g/h/6oYPC338/U6tzgtUHJzj+cYR0Qb2Rnba8hqjg8/JxC3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA0PR11MB4542.namprd11.prod.outlook.com (2603:10b6:806:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 04:32:51 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 04:32:51 +0000
Date:   Mon, 4 Sep 2023 21:32:46 -0700
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
Subject: Re: [PATCH RFC v2 06/18] cxl/port: Add Dynamic Capacity size support
 to endpoint decoders
Message-ID: <64f6af6e9316f_1e8e78294d4@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-6-f740c47e7916@intel.com>
 <20230829160919.00007f69@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230829160919.00007f69@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0229.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::24) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA0PR11MB4542:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f851165-9f95-47a0-b8ab-08dbadc92a15
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4LBgBtldhf0aWHff5Lazwz40d8bxt3FJYmNXLSe8O+sZd9lD902ijzRhhDTWdOknUlKcC8pLPcekpymDSE455Qy2ZSlVQp1efm2cIj/8wY3uyRi5Eoqk6WvcxIoOuifDo1QMkpgPbFNd9EB8hpmJAWq75sEfSZQfLhJUKAhPyOn3OhEmQA082fnPpf+o9P8vaObDJ1OioAPMTc6C/aEoEiygpFuC+Dw2RPIL3r2R+0Q4OnjadWYs/Mh8MvshUrZe7QyeoQdNJfOrQMaqfqlQmrziPmEFGO3C02dj7oHOIfK97+IBTQsIwdeb/cTzWbeaB9s9UeSUPqtEf5dzlybUwwmZMmuAN5v9MXpfTHLsKZtpC78gTPFSza1aa7/WZCOOugHAFQQYXtyBFsShn8oiRgSW+98i7nxhp/lC67gUVXgtaf6Pn3vW8pbsAyQXYEK3mc2XTwzLEG9PplsD/BaeKSs/78s5B8VNYsdJwuUSZyNgm1SvQEMSk/qOATX2jrA+W3PCujXSy0B4+i8kQAi6k1S8dr/dA9YPziLMsStkZh1psUa2PRwTXIQA6D15Ul0T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39860400002)(1800799009)(186009)(451199024)(2906002)(82960400001)(38100700002)(86362001)(6506007)(6512007)(41300700001)(9686003)(6486002)(54906003)(316002)(66476007)(110136005)(66556008)(66946007)(4326008)(8676002)(8936002)(478600001)(6666004)(83380400001)(44832011)(5660300002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K7vi8RZQfC22Ik7AOCdsuVl0g3j83j59dWjsZl7qiOS/0WbVSoTAmiEqwuPM?=
 =?us-ascii?Q?+9N6iLux4T2bCv6Tm2pEkfHFlO0bP5jQviB4T/98Wxr2WL7s+I8cK6bsZF5N?=
 =?us-ascii?Q?qR3BRKh1hV7VgIUBFmSeemk7O2OF57pUuZcuJyzG2jYLbzEEm6AVQS/qoJ1f?=
 =?us-ascii?Q?8y6lQeIboR+0One7dZXXw5tDuH3A+OhyMQN/8G+upmqk5i/lLtQ2Sl1eHpoU?=
 =?us-ascii?Q?Kl99pWGtPHIxPXUze7rjw3iVsM5/JDGNLAHrWyzYTg6e8gOqfqq7kZN7Upil?=
 =?us-ascii?Q?qcXI9NbvyAsEHXSci5v52v1pU6gml40GiddlD/RP/x3rUw9L5j6MWt9A9k5t?=
 =?us-ascii?Q?E4UAvtTFguiPEz5pMeSDf9/NkkRPC3BLGMb82+11jyD59ztgsrF+cJeVCJpE?=
 =?us-ascii?Q?R3LL85xy2ReZf/1u3i+8ajS4b1dr7NEqaftdZ9bFa0bRTm4/+4ZdfOHzSN5T?=
 =?us-ascii?Q?6PoqnTY51KduG9MpUdZ77WIZg3w+DH3Rh2aCcMs18m6zvVSPX9AWjCOyBe2I?=
 =?us-ascii?Q?ONCCCF5d5Kj45QlA6eqcimAPbRnPMdDjEY2U2lWMD/J7ewFMg9LIyI3ttEXE?=
 =?us-ascii?Q?P2ofATLH2xsvCtu1XO7zQkumbyD+izgLqLk3vUrCFu1ssAxpokv7Yp1jgnad?=
 =?us-ascii?Q?3ULUXplMC4h+UI5+QA9Ooi8htu5QCf6omujtOm/TgC3WY1pfYgjUtjw8MJb2?=
 =?us-ascii?Q?3NP/j84d7vMvnKI7TRxZOqFAlL/vQdx2qAWkODONz3e4FV7Gtwm5LUVSUIn6?=
 =?us-ascii?Q?hC/vz3mdx4AyDhXhkhVVToLs0BInOlNatrlBCCTEaTmcevCZx9ZnnatQ1P3j?=
 =?us-ascii?Q?EaG7oht4X8xkDTdHLA0WyoK3UdCDFKF+fJrp7OoYfIwhVFY5YylR/PNDmMrA?=
 =?us-ascii?Q?JeFUrMHeRtxEPn3rJ4KPJLTIlKjRXUjVXVdqsuwRzoZ5uiFFhTNb91bpssAL?=
 =?us-ascii?Q?u5QummnqlheTRBJNUCYs1wI/p9GrmceWjvSBMtmgoSJM4d2+vbM2p5HyxCYp?=
 =?us-ascii?Q?xytWJA4Voykt7InAVyIwqCOj8qj3mWwmCi+UnHVdZU5IeSbg6/d9AHhVK4cc?=
 =?us-ascii?Q?//ZjExXeQQ8Wt9j2mTai7yLkd3itbABXMTsGls/Xdje48kiwit23ThuPEhKQ?=
 =?us-ascii?Q?AQbrzTRGtJelEN9rknWmKEOVXlM63SEgsFka+82b755OkIc2eyOAXu/S2mXf?=
 =?us-ascii?Q?q9DTUydC2V+lBBLaTHCTUR+dypBVYrgWjgwz3q+JLKjiLFI+JIxzdmyJXXAy?=
 =?us-ascii?Q?2krwTzN4iwwEQvdcemBdKSMqKIPvriQGsyouU6MrGlBZVX5wgugyx8SVjzX4?=
 =?us-ascii?Q?mp/bCyXucubB4UMcSDuSs1UrDp8Rd3KqnuRvPvJtUnPRZdOnpg5KRJmxHEew?=
 =?us-ascii?Q?8KwUXTgMMT4qdMqkc2E83sp5iI3Vf1nXMG+dqX+Wdc4Y27EUg2GXNzVAwAVe?=
 =?us-ascii?Q?0r4kIvf/f32YHNH9B2GeyV+MQwR0GzwUqshz6pIeVAIzrJmeCOCAiZM5sknJ?=
 =?us-ascii?Q?Y+VmlAahsEJw1lNVKoxJzs60B0pICOmhTzMtLQvfWS68Ie77lFr4gK21wedR?=
 =?us-ascii?Q?w8BpOALmpElDAzHDE2HgPqlxOxNaigX811tu9Xe0?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f851165-9f95-47a0-b8ab-08dbadc92a15
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 04:32:51.1662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbKq1WjciXKKeOBjW/UHpGv23uhlImf77Fs42EtVag18GD42zLfmrwHTkIZgcVvzE+dWjxSrl09UlK+9m9sg5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4542
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
> On Mon, 28 Aug 2023 22:20:57 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 

[snip]

> > 
> > Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Various minor things noticed inline.

Thanks!

[snip]

> 
> > +
> > +static int cxl_reserve_dpa_skip(struct cxl_endpoint_decoder *cxled,
> > +				resource_size_t base, resource_size_t skipped)
> > +{
> > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	struct cxl_port *port = cxled_to_port(cxled);
> > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +	resource_size_t skip_base = base - skipped;
> > +	resource_size_t size, skip_len = 0;
> > +	struct device *dev = &port->dev;
> > +	int rc, index;
> > +
> > +	size = resource_size(&cxlds->ram_res);
> > +	if (size && skip_base <= cxlds->ram_res.end) {
> 
> This size only used in this if statement I'd just put it inline.

And in the pmem case...

>  
> > +		skip_len = cxlds->ram_res.end - skip_base + 1;
> > +		rc = cxl_request_skip(cxled, skip_base, skip_len);
> > +		if (rc)
> > +			return rc;
> > +		skip_base += skip_len;
> > +	}
> > +
> > +	if (skip_base == base) {
> > +		dev_dbg(dev, "skip done!\n");
> 
> Not sure that dbg is much help as other places below where skip also done...

Ok.

> 
> > +		return 0;
> > +	}
> > +
> > +	size = resource_size(&cxlds->pmem_res);
> > +	if (size && skip_base <= cxlds->pmem_res.end) {
> 
> size only used in this if statement. I'd just put
> the resource_size() bit inline.

Ah ok.  I think the line length was the issue here.

I'm ok taking the variable out.

> 
> > +		skip_len = cxlds->pmem_res.end - skip_base + 1;
> > +		rc = cxl_request_skip(cxled, skip_base, skip_len);
> > +		if (rc)
> > +			return rc;
> > +		skip_base += skip_len;
> > +	}
> > +
> > +	index = dc_mode_to_region_index(cxled->mode);
> > +	for (int i = 0; i <= index; i++) {
> > +		struct resource *dcr = &cxlds->dc_res[i];
> > +
> > +		if (skip_base < dcr->start) {
> > +			skip_len = dcr->start - skip_base;
> > +			rc = cxl_request_skip(cxled, skip_base, skip_len);
> > +			if (rc)
> > +				return rc;
> > +			skip_base += skip_len;
> > +		}
> > +
> > +		if (skip_base == base) {
> > +			dev_dbg(dev, "skip done!\n");
> 
> As above - perhaps some more info?

Sure.

> 
> > +			break;
> > +		}
> > +
> > +		if (resource_size(dcr) && skip_base <= dcr->end) {
> > +			if (skip_base > base)
> > +				dev_err(dev, "Skip error\n");
> 
> Not return ?  If there is a reason to carry on, I'd like a comment to say what it is.

Looks like a bug I missed.  thanks!

> 
> > +
> > +			skip_len = dcr->end - skip_base + 1;
> > +			rc = cxl_request_skip(cxled, skip_base, skip_len);
> > +			if (rc)
> > +				return rc;
> > +			skip_base += skip_len;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> 
> 
> > @@ -492,11 +607,13 @@ static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,
> >  					 resource_size_t *start_out,
> >  					 resource_size_t *skip_out)
> >  {
> > +	resource_size_t free_ram_start, free_pmem_start, free_dc_start;
> >  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > -	resource_size_t free_ram_start, free_pmem_start;
> >  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +	struct device *dev = &cxled->cxld.dev;
> 
> There is one existing (I think) call to dev_dbg(cxled_dev(cxled) ...
> in this function.  So both should use that here, and should convert that one
> case to using dev.

I think the type 2 stuff is lower priority than this series.  The main reason I
had this series based on that work was due to the split of the memdev state
from the device state.  Because that patch has landed I've rebased this
series on master in hopes of it landing in 6.7 without the type 2
dependency.

As such this code got moved to __cxl_dpa_reserve().

> 
> >  	resource_size_t start, avail, skip;
> >  	struct resource *p, *last;
> > +	int index;
> >  
> >  	lockdep_assert_held(&cxl_dpa_rwsem);
> >  
> > @@ -514,6 +631,20 @@ static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,
> >  	else
> >  		free_pmem_start = cxlds->pmem_res.start;
> >  
> > +	/*
> > +	 * Limit each decoder to a single DC region to map memory with
> > +	 * different DSMAS entry.
> > +	 */
> > +	index = dc_mode_to_region_index(cxled->mode);
> > +	if (index >= 0) {
> > +		if (cxlds->dc_res[index].child) {
> > +			dev_err(dev, "Cannot allocate DPA from DC Region: %d\n",
> > +				index);
> > +			return -EINVAL;
> > +		}
> > +		free_dc_start = cxlds->dc_res[index].start;
> > +	}
> > +
> >  	if (cxled->mode == CXL_DECODER_RAM) {
> >  		start = free_ram_start;
> >  		avail = cxlds->ram_res.end - start + 1;
> > @@ -535,6 +666,29 @@ static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,
> >  		else
> >  			skip_end = start - 1;
> >  		skip = skip_end - skip_start + 1;
> > +	} else if (cxl_decoder_mode_is_dc(cxled->mode)) {
> > +		resource_size_t skip_start, skip_end;
> > +
> > +		start = free_dc_start;
> > +		avail = cxlds->dc_res[index].end - start + 1;
> > +		if ((resource_size(&cxlds->pmem_res) == 0) || !cxlds->pmem_res.child)
> 
> Previous patch used !resource_size()
> I prefer compare with 0 like you have here, but which ever is chosen, things should
> be consistent.
> 
> ...
> 

Yea good point.  I audited the series for this and made the change.

Ira
