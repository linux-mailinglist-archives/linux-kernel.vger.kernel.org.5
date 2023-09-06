Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DC2793447
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 06:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjIFEA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 00:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIFEA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 00:00:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F800CEE;
        Tue,  5 Sep 2023 21:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693972852; x=1725508852;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aWNqt15lPzq65Ivi2Mo0sr1ynZBbiYzLn+tZznriogk=;
  b=Aez2765WXjFZ95Qej6axHM0PbRqZkdpeipAqSmg6j/BL3BiQ1Dsn6FzO
   F5zlkm2dZ3dkhvoVe4NSMsGAnxr5Zb7okqAKU3yQgQxG3hyXvx/9k+LqX
   HDzZ5ZYl/Txx/hfDUWwQEsO8fQithMDuMw6Tn5vHVaeuMIXEp2nHGTldc
   CJblUze0IqXpqMZ4qxIghXvf0y69tXBgPPie63r+Y+GrK4W083tEb4+Hg
   MjONHoDuIiwRv3k9p4rFEU+rFxI5h994xfv9ovTXIu+popjDGvTvjjbsl
   BgkAe3ij6fvs7b/ctvj/8pCFovHlSppHRiHxvMqwHnW+TvHDgteKSkcjQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="375867204"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="375867204"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 21:00:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="806864895"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="806864895"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 21:00:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 21:00:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 21:00:49 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 21:00:49 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 21:00:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfG9qMnXXXe22kOPOVn3u5QAXcWg1/Ewc64x7TyPD/mR6exOgTSUxDc2ITYMaSmAfjoP7V0v2YDU2/pfYyGsrxsgz63tZETSa10fX4aiea+clp36YHddTy6VsCsaD7FhvbBHN2zCdNtNUZI5xfxeTMJ+LKH2R6mUuDgRx8MM0d8YSZQddINkCQF9Sb6wkrvDULSIKzMsHA9OS1EihPCClEfIE6yZjZzTN5ozM5e31kyvPYPu6Zp5Nrx1nr3HsFv2meozvGSfRzNKM4YjZ5O1JYizzArpNvJGNEHmmJlc49gU6RjLMvUHEjlr4MyPqFHnmyNbBf0A22iziBGZHaliZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1E32rQ5Hjgdh0CYAlLuiT5nyVzf5xbGeOXR3w5k4kA=;
 b=Mpvcyvy5yWqu9jZ14rMnGRsWfTFYx5++hxQlX5db5R+ypRI5abMEkqOdZGW42J5KcsnR8w/NO0QRQa01tjrcn9Oies2CUVjlXnxcLkXtKcZDcQIIHvxBTaXovOqkdCSI9VAp9rEAySoMRxQUy930FZ4OZQkcpuBjzGRORDWBig0F3UsLhWfpoA+FTZ2Wq37xRB/VMn4ATw7AqRqWAEjmAWH7bS3kjH2sTWjZeqVZflB3YvvsmUJNrAjTU2NcRut2ThGg5HfeQdk4G2eanhTYrOWkKHJ/INoh1f81wVJt1vEx3Y4mCDqanc1kuKDS3UNc4cWwdh+eRIsfp3iDEiFwIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB5803.namprd11.prod.outlook.com (2603:10b6:806:23e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 04:00:48 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 04:00:48 +0000
Date:   Tue, 5 Sep 2023 21:00:44 -0700
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
Subject: Re: [PATCH RFC v2 12/18] cxl/region: Notify regions of DC changes
Message-ID: <64f7f96c1850f_1e8e78294a9@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-12-f740c47e7916@intel.com>
 <20230829174053.000008a1@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230829174053.000008a1@Huawei.com>
X-ClientProxiedBy: SJ0PR13CA0078.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::23) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB5803:EE_
X-MS-Office365-Filtering-Correlation-Id: 933d2bce-08bd-4685-fb55-08dbae8dd9da
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5JrXypKJfTqEsyODV3o12blzc77fgEQDdTG71N+QLoJSI9pW0k9IxoO/Ma7aWxuRjS8mWLvAIGBZUVS7tJJDhsELME0GzyYPeigew0ljyD5yp9yXAX6nwAbExOtpPZR4c1sUzmpNqLNK8gwV2H8aaBrdjmcFIbSPb+TuBy9RQ7ohrRaL/87lFurJ3OCfIKcFF0lbkB7bTLfa8XKtZtP6gHLe/pUxUL41yxhEI7c9ulPAeFaTxjaZJBK7s8c3bhpEqCzpYJepnuYtEzidct9Vt5EaE8v2FPizyg0YaXzvjE77W/fePx12uNy5jcWra9t15aWFzz1hvSyn3o7rcSXJVCb7MS2P9rf4oJEdFDwlLAibXjXTK4r4+f6E0lxIChLqfgJsEmQY+4VfR7banqnUGLAVUz9Z07Zb4jYkAULFutweR/bn+jYTPCDR38Uy7CKMsOfaBxTRYEnOqDFJ2p1nVrX5iCITmiQgE0oAoLbpKmb+ANLBwY8NB4gcax1qeJe5RD75W6uXiWniDjAGoY0b+QFVCETwK3KUGAuFIdI2V53av33Axxtba5XibyMCfZw5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(396003)(136003)(186009)(451199024)(1800799009)(2906002)(82960400001)(38100700002)(86362001)(9686003)(41300700001)(6512007)(6506007)(6486002)(54906003)(66476007)(110136005)(66946007)(8936002)(4326008)(8676002)(66556008)(316002)(478600001)(6666004)(44832011)(26005)(5660300002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4GHtuUBvSKF7R4ROSH4/nGQUnMWhqQQ9vYosN2qz8lILgR4kM7OYxfrHPNT9?=
 =?us-ascii?Q?YIoobxN1Z38sIwQ2rhLRmAYfzKtxBXGScWS6l01wn8S9zqsqmwtHKhdN++mk?=
 =?us-ascii?Q?NL2tTgUWtkCmz3LkxyJMUdd9jCT2osx6F7rW9xta3llhTW+NYh2gljhrhbw0?=
 =?us-ascii?Q?n3fxjCT67zoJIykIvoIpR9pKW5hTRH73yeCo3tGWsr956gKg4IyNr9uPTvze?=
 =?us-ascii?Q?dQtsf/KF27zK8sEam44gjwwOJR5ech7i42ih4/FiLqUdtTQMODEPFN4nonlr?=
 =?us-ascii?Q?9zubY7AkEs229gIGgkxL/SFjibt9xMW4FjDMoGY73w/AOUJTReQ5/9Uxt/hp?=
 =?us-ascii?Q?kd3LBgIagehmdc3X1yweiQmquoToQAzp6k53LSGL+DAQtuhX4QDK1K0T9Ca8?=
 =?us-ascii?Q?hS8pi14AEyyIqhgJGx0iwY+anPIBS+rSdZVz14sgzWlS0TNuMZ2PwJZUU86t?=
 =?us-ascii?Q?NdeHIr5Lpebmb7Wa9Uty+9U1pG0uiMktDZB3EN0vsksqv6Xm4xapce1rMpWW?=
 =?us-ascii?Q?XnmTadzAsKjsJMZ7R1UNX82/HztDqPzI8BiouCgRSLlDbzNdgbLifU/A3rek?=
 =?us-ascii?Q?OsR3Tm5/96eIny032klYyXsHC4oG5Mxg6h4kapO69vKMx45C3ge2yPPPMgjE?=
 =?us-ascii?Q?Zt1TZRHjA5tYi6yc0ls2gIxy85zHgcSsO2EXBHYTFoTByUwag8W/OhOksUAV?=
 =?us-ascii?Q?YZdaT06ojRx/KU5mXlInzPWkW4nmFCKvrscM8UuDf3fUwyAtBto0hJmvLAbf?=
 =?us-ascii?Q?YsFHkQZGKvJ+hXUWJJ2G2AaiDaSM3e3FpSMPmvZyuB2vugPar8JLcDZS8mH9?=
 =?us-ascii?Q?IMe9zdtd7XtOhjMOGMuLaZo14MFdE1W4biZfQmutlVAGoL8ex+Kbc9LwXfg3?=
 =?us-ascii?Q?V1Fgfq+efZ19LTt43XaLSvDUNCLU0WJN8W67p2C/igI3308bRrhAWt6Su5do?=
 =?us-ascii?Q?t+zO7dyq6ARRYDrmEhdRq+yxw1Q4wgW+vSKZ35198Uzso0qNLz86EwJxdJ56?=
 =?us-ascii?Q?B6ukVuYdAL3W+UgNI0bXuEWXncg7hX6CY3L9OPoptoFv80GoKTR7HIIHKnls?=
 =?us-ascii?Q?0VM+W8HyYZWMMk4dAIXIxSMBFeiu15dseJBo80qi5u7TCGyNCeCYuMGI4Jd8?=
 =?us-ascii?Q?2aw6gd+RxGatTBB0MOQLCgEigHXcaPpazsAOCHKvdrhEeUtpdUBbGujJtppW?=
 =?us-ascii?Q?U5sBUPmSjGxSBZB6T28/2lzB7oicyUQKHHwVUA1JR3bHU9bY089gyCtyzqQY?=
 =?us-ascii?Q?nZJioziMoZ3UP8l1wnbRez7jn63jP9kpvKZSkLwUmcvwEnwlFraxaLtdZfwl?=
 =?us-ascii?Q?7D2bq7TNhTC/nCtnp1zF+6YHT5g9t5q6RlaHYr/zV6ePi+hE9vKr090lWBzN?=
 =?us-ascii?Q?pwhwaWzj2ksOGzj/PUfcpn9dHPLdq4sBv+OtQSQpE5kXTEdONXhQ3jfoiZLR?=
 =?us-ascii?Q?zPycv0Xs5t9/pfC0lOidK5E/0j1H9JDrMhduN9r3CsNBw9qy+M8z1rAFDxS+?=
 =?us-ascii?Q?7ijDtGaS9Nc24eDOdadrW5Bi2ZS122xIk7kcJBSzwxF5OLLlXHzzXEc21qXO?=
 =?us-ascii?Q?fper1TxbUD01B+I34Q+DcFx/2dHxA4uvKKwDro/F?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 933d2bce-08bd-4685-fb55-08dbae8dd9da
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 04:00:47.6711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m3fg08JmS1BG3oFqgCMNSeVT0h2tDbunTTh3IRF059wm3u2DfOjUIrVsqLq2nlyAeOZXB6bGNWVt1GG0E5oDig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5803
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron wrote:
> On Mon, 28 Aug 2023 22:21:03 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > In order for a user to use dynamic capacity effectively they need to
> > know when dynamic capacity is available.  Thus when Dynamic Capacity
> > (DC) extents are added or removed by a DC device the regions affected
> > need to be notified.  Ultimately the DAX region uses the memory
> > associated with DC extents.  However, remember that CXL DAX regions
> > maintain any interleave details between devices.
> > 
> > When a DCD event occurs, iterate all CXL endpoint decoders and notify
> > regions which contain the endpoints affected by the event.  In turn
> > notify the DAX regions of the changes to the DAX region extents.
> > 
> > For now interleave is handled by creating simple 1:1 mappings between
> > the CXL DAX region and DAX region layers.  Future implementations will
> > need to resolve when to actually surface a DAX region extent and pass
> > the notification along.
> > 
> > Remember that adding capacity is safe because there is no chance of the
> > memory being in use.  Also remember at this point releasing capacity is
> > straight forward because DAX devices do not yet have references to the
> > extents.  Future patches will handle that complication.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> 
> A few trivial comments on this.  Lot here so I'll take a closer look
> at some point after doing a light pass over the rest of the series.
> 

I agree this is a lot.  I thought about splitting the notification into 2
layers.  Notify from device to CXL region then a separate patch from CXL
region to DAX region.  In the end I channeled Dan and kept it all together
because without interleaving there is not much for the CXL region to do
but pass the notification up.  So that patch would have been kind of
awkward.

> 
> 
> 
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index 80cffa40e91a..d3c4c9c87392 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -104,6 +104,55 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
> >  DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
> >  			 cxl_debugfs_poison_clear, "%llx\n");
> >  
> > +static int match_ep_decoder_by_range(struct device *dev, void *data)
> > +{
> > +	struct cxl_dc_extent_data *extent = data;
> > +	struct cxl_endpoint_decoder *cxled;
> > +
> > +	if (!is_endpoint_decoder(dev))
> > +		return 0;
> 
> blank line

Done.

> 
> > +	cxled = to_cxl_endpoint_decoder(dev);
> > +	return cxl_dc_extent_in_ed(cxled, extent);
> > +}
> > +
> > +static struct cxl_endpoint_decoder *cxl_find_ed(struct cxl_memdev_state *mds,
> > +						struct cxl_dc_extent_data *extent)
> > +{
> > +	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
> > +	struct cxl_port *endpoint = cxlmd->endpoint;
> > +	struct device *dev;
> > +
> > +	dev = device_find_child(&endpoint->dev, extent,
> > +				match_ep_decoder_by_range);
> > +	if (!dev) {
> > +		dev_dbg(mds->cxlds.dev, "Extent DPA:%llx LEN:%llx not mapped\n",
> > +			extent->dpa_start, extent->length);
> > +		return NULL;
> > +	}
> > +
> > +	return to_cxl_endpoint_decoder(dev);
> > +}
> > +
> > +static int cxl_mem_notify(struct device *dev, struct cxl_drv_nd *nd)
> > +{
> > +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> > +	struct cxl_endpoint_decoder *cxled;
> > +	struct cxl_dc_extent_data *extent;
> > +	int rc = 0;
> > +
> > +	extent = nd->extent;
> > +	dev_dbg(dev, "notify DC action %d DPA:%llx LEN:%llx\n",
> > +		nd->event, extent->dpa_start, extent->length);
> > +
> > +	cxled = cxl_find_ed(mds, extent);
> > +	if (!cxled)
> > +		return 0;
> Blank line.

Done.

> 
> > +	rc = cxl_ed_notify_extent(cxled, nd);
> > +	put_device(&cxled->cxld.dev);
> > +	return rc;
> > +}
> > +
> >  static int cxl_mem_probe(struct device *dev)
> >  {
> >  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > @@ -247,6 +296,7 @@ __ATTRIBUTE_GROUPS(cxl_mem);
> >  static struct cxl_driver cxl_mem_driver = {
> >  	.name = "cxl_mem",
> >  	.probe = cxl_mem_probe,
> > +	.notify = cxl_mem_notify,
> >  	.id = CXL_DEVICE_MEMORY_EXPANDER,
> >  	.drv = {
> >  		.dev_groups = cxl_mem_groups,
> > diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> > index 057b00b1d914..44cbd28668f1 100644
> > --- a/drivers/dax/cxl.c
> > +++ b/drivers/dax/cxl.c
> > @@ -59,6 +59,29 @@ static int cxl_dax_region_create_extent(struct dax_region *dax_region,
> >  	return 0;
> >  }
> >  
> > +static int cxl_dax_region_add_extent(struct cxl_dax_region *cxlr_dax,
> > +				     struct cxl_dr_extent *cxl_dr_ext)
> > +{
> 
> Why not have this helper in the earlier patch that introduced the code
> this is factoring out?  Will reduce churn in the set whilst not much hurting
> readability of that patch.

Because this logic appeared in only 1 place in that patch.  Here we are
using this same logic 2x so it got factored out.

I see where you are coming from because this is a straight up copy of the
code.  I'll go ahead and do that.

> 
> > +	/*
> > +	 * get not zero is important because this is racing with the
> > +	 * region driver which is racing with the memory device which
> > +	 * could be removing the extent at the same time.
> > +	 */
> > +	if (cxl_dr_extent_get_not_zero(cxl_dr_ext)) {
> > +		struct dax_region *dax_region;
> > +		int rc;
> > +
> > +		dax_region = dev_get_drvdata(&cxlr_dax->dev);
> > +		dev_dbg(&cxlr_dax->dev, "Creating HPA:%llx LEN:%llx\n",
> > +			cxl_dr_ext->hpa_offset, cxl_dr_ext->hpa_length);
> > +		rc = cxl_dax_region_create_extent(dax_region, cxl_dr_ext);
> > +		cxl_dr_extent_put(cxl_dr_ext);
> > +		if (rc)
> > +			return rc;
> > +	}
> > +	return 0;
> Perhaps flip logic
> 	if (!cxl_dr_extent_get_not_zero())
> 		return 0;
> 
> etc to reduce the code indent.

That is ok.  But in this case I do kind of like the indent.  I'll change
it to your way because I think it is slightly better.

Done in the previous patch.


> > +}
> > +
> >  static int cxl_dax_region_create_extents(struct cxl_dax_region *cxlr_dax)
> >  {
> >  	struct cxl_dr_extent *cxl_dr_ext;
> > @@ -66,27 +89,68 @@ static int cxl_dax_region_create_extents(struct cxl_dax_region *cxlr_dax)
> >  
> >  	dev_dbg(&cxlr_dax->dev, "Adding extents\n");
> >  	xa_for_each(&cxlr_dax->extents, index, cxl_dr_ext) {
> > -		/*
> > -		 * get not zero is important because this is racing with the
> > -		 * region driver which is racing with the memory device which
> > -		 * could be removing the extent at the same time.
> > -		 */
> > -		if (cxl_dr_extent_get_not_zero(cxl_dr_ext)) {
> > -			struct dax_region *dax_region;
> > -			int rc;
> > -
> > -			dax_region = dev_get_drvdata(&cxlr_dax->dev);
> > -			dev_dbg(&cxlr_dax->dev, "Found OFF:%llx LEN:%llx\n",
> > -				cxl_dr_ext->hpa_offset, cxl_dr_ext->hpa_length);
> > -			rc = cxl_dax_region_create_extent(dax_region, cxl_dr_ext);
> > -			cxl_dr_extent_put(cxl_dr_ext);
> > -			if (rc)
> > -				return rc;
> > -		}
> > +		int rc;
> > +
> > +		rc = cxl_dax_region_add_extent(cxlr_dax, cxl_dr_ext);
> > +		if (rc)
> > +			return rc;
> >  	}
> >  	return 0;
> >  }
> >  
> > +static int match_cxl_dr_extent(struct device *dev, void *data)
> > +{
> > +	struct dax_reg_ext_dev *dr_reg_ext_dev;
> > +	struct dax_region_extent *dr_extent;
> > +
> > +	if (!is_dr_ext_dev(dev))
> > +		return 0;
> > +
> > +	dr_reg_ext_dev = to_dr_ext_dev(dev);
> > +	dr_extent = dr_reg_ext_dev->dr_extent;
> > +	return data == dr_extent->private_data;
> > +}
> > +
> > +static int cxl_dax_region_rm_extent(struct cxl_dax_region *cxlr_dax,
> > +				    struct cxl_dr_extent *cxl_dr_ext)
> > +{
> > +	struct dax_reg_ext_dev *dr_reg_ext_dev;
> > +	struct dax_region *dax_region;
> > +	struct device *dev;
> > +
> > +	dev = device_find_child(&cxlr_dax->dev, cxl_dr_ext,
> > +				match_cxl_dr_extent);
> > +	if (!dev)
> > +		return -EINVAL;
> 
> blank line.

Done.

> 
> > +	dr_reg_ext_dev = to_dr_ext_dev(dev);
> > +	put_device(dev);
> > +	dax_region = dev_get_drvdata(&cxlr_dax->dev);
> > +	dax_region_ext_del_dev(dax_region, dr_reg_ext_dev);
> blank line

Done.

> 
> > +	return 0;
> > +}
> > +
> > +static int cxl_dax_region_notify(struct device *dev,
> > +				 struct cxl_drv_nd *nd)
> > +{
> > +	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
> > +	struct cxl_dr_extent *cxl_dr_ext = nd->cxl_dr_ext;
> > +	int rc = 0;
> > +
> > +	switch (nd->event) {
> > +	case DCD_ADD_CAPACITY:
> > +		rc = cxl_dax_region_add_extent(cxlr_dax, cxl_dr_ext);
> > +		break;
> 
> Early returns in here will perhaps make this more readable and definitely
> make it more compact.

Yep. done.

Thanks again for the review!
Ira
