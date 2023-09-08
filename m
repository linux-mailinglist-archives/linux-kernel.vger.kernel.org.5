Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5894A7992F0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 01:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345132AbjIHX5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 19:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344805AbjIHX5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 19:57:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738DE18E;
        Fri,  8 Sep 2023 16:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694217458; x=1725753458;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SrURTqA5DSIXWSl2Bvik2uDTQ+AW7tbaZR40gZaHj8I=;
  b=dKHqhJnVvcVcbHRGgSvvRYMK0mTjWplr9ieJOds2nCw8JJoXPRxGyNjp
   pJ5jwieV1h7+yjENPSvQdVA0hnCa65RHjWVcqZJEf6NBJt9dU1zo1RLOr
   1Qcxnm3bFQD+oBJZQ8aWpuc7mcqs8AeLlMhMsHx/dyiTRoTLZ5oQ/YYmr
   S6Ex7Mj+OYfyCCi4Pu/P+32I2yWabFbDjdYxgesjeyoIn3jCPdTuVBJnz
   FnZ0R6X+3NS7W8S2LmUK3ToztL3EdJpPIi8oHrv1HL4rXDwtJvuLoy08u
   7N7yTEqRVH015YcI23yxpRWss2nIZ/is3w48vV38irLsWLgC5u7hZ5mhj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="441784449"
X-IronPort-AV: E=Sophos;i="6.02,238,1688454000"; 
   d="scan'208";a="441784449"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 16:57:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="916360622"
X-IronPort-AV: E=Sophos;i="6.02,238,1688454000"; 
   d="scan'208";a="916360622"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2023 16:57:32 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 16:57:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 8 Sep 2023 16:57:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 8 Sep 2023 16:57:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AePB0+t/nHPG36LsPJRPGCJ9Lv+tdlyiaNc2K+mtMTwloz6dXVPk7CLwow9zl/UdYCEfDfPfXQsVjiAL5HtmEa45w6Y4S0OWV3o9Q/dhzWXw+VX0qCVQz6QPzYEAcehcrFd8fGj09CJeRTCJXVVNmno8niuFSxbelajvteM+8xxheQQPMlxKlx8exA97Oatvkze+3/RJjIYTxpkRyhU2aT1FsS6adoYby+c2ZiOqwX3Gb+BI6moec7wTOdu/PdevcP5CyyvboIH5mlubkqRb5dIEjh2iHaghvb/giNrmxNvN4SrqK3UE5aLt7STBpMradLHgBkAE9xvCZHGQ8/fp1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sROCBrKVf59nCIGJcBYA93WRrU2CveGV1dReUQcDBxQ=;
 b=VbvxQjVSBhkhIy8cQwEm7iKAhDg7YFaNC1mibVpCE6qNbGcHEtUDGeE7oIBQcvIQJFcf4U1CDDmgJAxGqSI8lVNk9JbXQcJZjm/3GFh1QEsFX4fu5WIjI/H76ReRz0qUnRLul+vIa+J6oZq3R5gt+2h98IN2Ijejv0ZzS8Cs1P6J5FxfDadlLsesyw+MhPLlVx6tU3ZkM0ykVex/dLwwkMSC9Z0tOEiOzbdcaPTq3II4t7C3hD7KbdbGAUhkxcfnHwZC5ZrPJV229KdtgnCz+bk2Bh9RJXgbKUvFnjXJod/081qNn7JpcPZ/H99WdhrbodwkVyWzMfzXjDegV0FLTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB6399.namprd11.prod.outlook.com (2603:10b6:8:c8::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.30; Fri, 8 Sep 2023 23:57:24 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 23:57:24 +0000
Date:   Fri, 8 Sep 2023 16:57:20 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 11/18] cxl/region: Expose DC extents on region
 driver load
Message-ID: <64fbb4e04c39c_1e8e7829435@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-11-f740c47e7916@intel.com>
 <f834c62d-bcbc-899b-db72-117c6e7b13af@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f834c62d-bcbc-899b-db72-117c6e7b13af@intel.com>
X-ClientProxiedBy: SJ0PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: ff7d6428-0f62-432a-fe19-08dbb0c758df
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gfFQPFCOt+4INi1rbHSqaLKY1RayhB5GiTkOAPCJLOoFp3gelRIB59I0T2Qb+CnAJTBTq8pSfs3yDN1zAh7qypzrTfYfSVA5UyFRWxhH6OFT69nKdQ3XcostDJCODAZtNYXFhXsdCcgEgssKz/KW4bOVp1MMYW1jqF9R6YStMdmRaSTGbj+Po5iDLfSth9uFL3IQRiZyE496Cf5jaxba/0AlmwsVJw9WMV3AHvb86hktkeizLhBSNQDkQ9h8D4bL392guIKhCWY/nlPFDXhuzLcoCowNytSWmamdb9VD+r1FiqsNSKppn9oyHD0Pd6nrHsmkJ3ggy2WCyjV7OgNsqlKvHWJv2CMgEMy21xz383jm0IOjswjzM7GPqw70+/r72kFGm9DBrSRyNdwervzBtbCDURbs7cdoT/8ly+FaweMOHaXO7qMlNBTwKJ/yYYj0UqvRMMA84CYBM3nkkb6so3j/QAu6hj6FgNLtcc3YShTty4BtY8avKL2S3sSj2SnZi7qRp5FdxZoJw0zpq0EFEbTHSqDh9Pqfp43sysHQ2W73Ny0yXmYQ3tWyaH+kmOPH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199024)(186009)(1800799009)(5660300002)(44832011)(4326008)(8676002)(6486002)(6636002)(6506007)(8936002)(41300700001)(66556008)(66476007)(54906003)(66946007)(316002)(2906002)(478600001)(6666004)(53546011)(9686003)(6512007)(26005)(83380400001)(82960400001)(110136005)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aDXsgthuOCeqzEq5LxieGJ3Ch6fQNQY6AbL52NlyxV5MnRuh40MdPHF7azE9?=
 =?us-ascii?Q?P4Fg2NBlH5lMaznpUAjD71FQSMIxtM4SkzDzfZSFUENGtjcsc33yeJpc4KTj?=
 =?us-ascii?Q?e4doF9otKpn6GiERhVsIG8fXQqs5Ny/H3E0vQ82j3bzdfp+xEZVONq2YEYOh?=
 =?us-ascii?Q?1jK+zKPwzkqgbKefuR8YZ7xQgQwSCnjllY1vKJeB1pdQfueuxOyKP0Ybm2XV?=
 =?us-ascii?Q?iQ+M+2G+u6CUwSMqgjKh8qVAIZuSxN6gjLzOhBArVXwbPA2ZuXV+tmQOA/vJ?=
 =?us-ascii?Q?gCMRAVRtPdZyIZMiN9pToyvhgmteanVqLyalKm3KzhSAta75TzQKssBZMYv+?=
 =?us-ascii?Q?Hcb2Ah/bdAYGUDOxVT9gNwLPGBLhG/BuhAUbRqcDxNOWsYgWwbnS2q66fz1o?=
 =?us-ascii?Q?0tHJQCs8dkA8NrR3JMQ00X6d0Y7Ir5JuHeDmfpb5ptdzorBWspyCuswYoDkF?=
 =?us-ascii?Q?9dXexTvw5DqzRY0F2IPdByoJAJoP11zE230zlofC8UYWvMJ77gf0ryTwCzfX?=
 =?us-ascii?Q?VL8NVB5pJXumj2UUKb9IXfBuEhFyjMk1IbTAKrcH8sJOsfAi7ztZbsWIoRdO?=
 =?us-ascii?Q?jtXT9ieg3WIwD00TF0kBRnnvN/paRcFNGxpgRTcsy3Ng9kzkBwS4jsjoy2fx?=
 =?us-ascii?Q?C7pcDS1NjadxBwdDIIiz+UUevqRpkKU4tHaGglgB+9ri2XyNC0Z+yVh6o2yp?=
 =?us-ascii?Q?4xjZiLITH006XSR+ZWjgCF0xCIF7lCTA58R+qD5TXIieyEz2Q4ITo2MJVrnA?=
 =?us-ascii?Q?QVKy6eCCj80CYu1dSuojboZ9wswvt7y4Ks4S6vRq8qGiPp9lA8exQpPd3Pxu?=
 =?us-ascii?Q?5yN+tHKVtuRQKMSY4I1Xg2GjMrt8esTOZoe4yEk7YG5orko4uyXCOuFGsuif?=
 =?us-ascii?Q?uA9ef11VCZUf0WZ+qSXJaoHqkmJaSf3o9E0KSQwpJTmhHp08qsNAbD74BEYf?=
 =?us-ascii?Q?eBJYjNNeLtLuJNh0phDhAo2KtT3R80mb3E5yjwFCOMbajeE31MIaNORKTxwg?=
 =?us-ascii?Q?Hn9Ny2LXNPcnFfuc+/cGS2ey4KXfjGAbQ74SjqrfQjgZlNJnrNe51zYnEEm+?=
 =?us-ascii?Q?WpnPNnoIM7lOMOhQr8gGE8iRcB5ZD2BGEW+ULk5AF85EhfBOcyXk7caVOuV+?=
 =?us-ascii?Q?P6WA3shAysq+kx83raT/cqZvmygf8kAcMaMZezGnHosjBYym8n0p3iXZFMP6?=
 =?us-ascii?Q?l4HFM1p1Xiz9g+icbA59Apn3nRJdiNIyeA/AfGhkx1mJI63djTBtvcOIF3Bx?=
 =?us-ascii?Q?nAKnotDNz+aUVVHoQ/61MYHRur83zrY55xq73329Uj54RfN9E0F4bwzqCmjx?=
 =?us-ascii?Q?1THN8Hs6K5KWzgDNdbP/nNe0dp1ITTrR9eMjbq2thsPwkITD+sLM5p6N2MTk?=
 =?us-ascii?Q?bQodzdHUxNq5cTzBzirU5jqyrBqBjwjt+xdz3Qvm0cglY06ubnbeQAnTGOH3?=
 =?us-ascii?Q?NUH+e5Xsfz53wjM4f+FzsCktPDB/GTsjav+D3Pl9yRLpo7lqWZyont27Belb?=
 =?us-ascii?Q?Pn8GtZs5X6wIGMKZ54o4vTeSN7ZRlErYnpGtNX93Y1YjGo8W9BtWFS1is35K?=
 =?us-ascii?Q?7LJOBEw6pHQLMBRZaOrstMJIkwZQPUz/K+ztCuFv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7d6428-0f62-432a-fe19-08dbb0c758df
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 23:57:24.1464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nK+tjrAVBNr7IFzS7QUJ3MpZIaGQP+6c4s4kmM4JgfuCtpZz/38gIRvd/kwhOK/Stv1xD1W4xDuAxyfF8vBjEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6399
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jiang wrote:
> 
> 
> On 8/28/23 22:21, Ira Weiny wrote:
> >   

[snip]

> > +static bool cxl_dc_extent_in_ed(struct cxl_endpoint_decoder *cxled,
> > +				struct cxl_dc_extent_data *extent)
> > +{
> > +	struct range dpa_range = (struct range){
> > +		.start = extent->dpa_start,
> > +		.end = extent->dpa_start + extent->length - 1,
> > +	};
> > +	struct device *dev = &cxled->cxld.dev;
> > +
> > +	dev_dbg(dev, "Checking extent DPA:%llx LEN:%llx\n",
> > +		extent->dpa_start, extent->length);
> > +
> > +	if (!cxled->cxld.region || !cxled->dpa_res)
> > +		return false;
> > +
> > +	dev_dbg(dev, "Cxled start:%llx end:%llx\n",
> > +		cxled->dpa_res->start, cxled->dpa_res->end);
> 
> Just use %pr?

Yep!

> 
> > +	return (cxled->dpa_res->start <= dpa_range.start &&
> > +		dpa_range.end <= cxled->dpa_res->end);
> 
> I may be easier to read for some if you have (dpa_range.start > 
> cxled->dpa_res->start && ...) instead.

<sigh>  I think about checks like this visually.

Resource
	As                        Ae
	|-------------------------|
Check
	   Bs                   Be
	   |--------------------|

	As <= Bs && Be <= Ae

I know this is odd for some but I like seeing B 'inside' A.

If others feel strongly like you I can change it but I'm inclined to leave
it.

[snip]

> > +
> > +#define DAX_EXTENT_LABEL_LEN 64
> > +/**
> > + * struct dax_reg_ext_dev - Device object to expose extent information
> > + * @dev: device representing this extent
> > + * @dr_extent: reference back to private extent data
> > + * @offset: offset of this extent
> > + * @length: size of this extent
> > + * @label: identifier to group extents
> > + */
> > +struct dax_reg_ext_dev {
> > +	struct device dev;
> > +	struct dax_region_extent *dr_extent;
> > +	resource_size_t offset;
> > +	resource_size_t length;
> > +	char label[DAX_EXTENT_LABEL_LEN];
> > +};
> > +
> > +int dax_region_ext_create_dev(struct dax_region *dax_region,
> > +			      struct dax_region_extent *dr_extent,
> > +			      resource_size_t offset,
> > +			      resource_size_t length,
> > +			      const char *label);
> > +#define to_dr_ext_dev(dev)	\
> > +	container_of(dev, struct dax_reg_ext_dev, dev)
> > +
> >   struct dax_mapping {
> >   	struct device dev;
> >   	int range_id;
> 
> 
> This is a rather large patch. Can the code below be broken out to a 
> separate patch?

Possibly.  The issue was that the natural split was to implement extents
at the CXL region level.  Then implement the dax region extents.  But
without the 2nd patch the CXL region code does not do anything.  This is
because the CXL region driver load triggers this patch to do something.
It made more sense to have the code which triggers the extent processing
bundled with the extent processing.

To split it as you suggest would still be a very large patch with this new
extent file being pretty small.  So I just combined them.

Ira
