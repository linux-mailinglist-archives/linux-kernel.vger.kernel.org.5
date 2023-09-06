Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BFE7944FE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244666AbjIFVP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjIFVP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:15:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96BAE6F;
        Wed,  6 Sep 2023 14:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694034951; x=1725570951;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ODlvg/VJ1uWoKcul6iYtQFdCAZ94gZpvT2gIKHNY9oM=;
  b=nXRGkqpGcWkJf8kRe0UzAtE5NEVjwkG32PDWYi8nRYC8cBh862j3uQC8
   W2V+xOKb/6gGktHp10Yz54NhLRreTx8VrgnMY7QZMZx/yKEbxw41SLHSc
   MY3UTpl8UhxPpML6vEBUKWuxqEcxHvGVxP5IKRzV6355RxWKeqBKVMB9e
   KPd8M7/MxRzbaV16ukeXNAdmWbX6BWhiy4L3gVSnFWgF/xgQZZ+2nz/ZS
   vKV7IHW407QHV2BWlRIzAE3XULTCgmtpmU26oM0Xvc8FADjg3d27NeSnL
   iU5UPKMo327p/yT5QVLDWX2JkorS8LmOWDt1OY5qmsvGaocKl8qSkk/Zn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="374579823"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="374579823"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 14:15:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="741726648"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="741726648"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2023 14:15:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 6 Sep 2023 14:15:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 6 Sep 2023 14:15:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 6 Sep 2023 14:15:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 6 Sep 2023 14:15:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkunV6DfpTH37W2qUpfFV0VB3T76yGD1DYPAc7AFEGZVm3MKmqrso/auQ5FPnQmP+G2zE3GGO5y8SE33/2JvihlF5Nl1bAGl/+ZH9zptv3KGgVZPCr7YbdEvetRTYlRiAWJru/k+ThqmlD9z7KWjlSk5QIAxd1qyGuG25lnwZyFTW+pPp8rqYpshc9kJ+JwQCFQz4mHY7zPHQPw7Y+blY5uDkInTkkBd4yCOyzVjokd6pA6QVIXUyWLS58JJtatmgqejUYjINldmnierSAlpz5GPE0Ff+5F6KdZ6RB10XTOvw3Fx3FxFftdoiTRAN2DJ2J/KqkAv2ypXJt3fqBHpLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ry7d4F47p8bLdrpWVxtya/vQ67FM9C/QJi3hWx536q0=;
 b=X4UfcR/JTQLel63l4GSaXjyAKNl66RlNTwXM/7+566dRrUqrQwFpItZDiX8sMKyFsvuC3Zk6VZzXWQY+t8X6PAcXpZwd5NKXy5+dJyQndk3oCdLIfSoPU3mYArtywJ+h7l2Q2hoKmWgE70VEb+1KBdASHc7ZfRcIevZw3KhUBwZwqnIt1hD6WEXmRoD24GvEfWVI49GrmPA77soUspVsBZ86bdnMYPzNot2BrClU3koAB5FpGvCi5Nxbe4YBs0LgNb3CcsGHrPrl8jVzsG6Nl9KxcEc7urfYItOMPjooGYoRgJLHd08nVR8RepvgRl+vY2U9ifIDVS/tahAT+7WCMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB6726.namprd11.prod.outlook.com (2603:10b6:806:266::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 21:15:33 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 21:15:33 +0000
Date:   Wed, 6 Sep 2023 14:15:28 -0700
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
Subject: Re: [PATCH RFC v2 16/18] tools/testing/cxl: Make event logs dynamic
Message-ID: <64f8ebf0d849a_1e8e782946d@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-16-f740c47e7916@intel.com>
 <20230830131147.000034bc@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230830131147.000034bc@Huawei.com>
X-ClientProxiedBy: BY3PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: 03247137-e2ec-4fb6-4d06-08dbaf1e680b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cl8TSKtAPtCQ/jBmo5JVmmaemER0hOwd1MDZIi+VUurfaKJW9QcAlwYTrlatefuEspZ5FmH+rJgHfJgyfLAQjMS2do+yiFQV4tLkrEFt/Jl/lnCJai/7Yi0IqcSS8bu/EjWafeC3E0t0cZ+CPEbGh3LthcyqpGf9ks1tNtegrXGjRDUpZLyDPRPxgvv8SdPVPlrINOKAeG3X3FLz1Q+onDETN9lTiyW1/7znhfvkjGDixUja4XI+dkSegNHN+2h7Xdy/cMzCydZrkglxGVVh++FvWowUfijPb6uFkwYNKDWXnLvJPrJ5NHy2ke0V8PVj+es+Azh8+zZDoldU685PJS5ThNxFd5SFrv+iI2K0Un8l8DBpqVQdntBr2+tbVxBIi/Bmp95UO6IxxsbjqniTXmUdh1z5X63BFTz7pw5aj8ekgxe6LJW0q4qACUJKZpTMle4tMmBucmfwspmwvwQGx0THbKsJ8tKzNzIjpHaQKdWLVNFF4MfTzh1MEf+yc9IVTSQGCcPlOhNb7HrceJmDScjHoJcIOib7hkBMlKP4angoNjp38DkX4p9Yuv4zD4Xj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199024)(1800799009)(186009)(6506007)(6486002)(6666004)(9686003)(6512007)(478600001)(83380400001)(2906002)(26005)(316002)(54906003)(66946007)(44832011)(66556008)(66476007)(41300700001)(4326008)(110136005)(5660300002)(8936002)(8676002)(38100700002)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r4iM8rSffTUKeL64R1l/fohDhhoH0cJsIPe2pUyYW2XaIn4q5SznvsQjSOlg?=
 =?us-ascii?Q?uRma6ctyDIH9SVCWxRyumYs91KkyABhFyZf2DHWYeZHtaw1pJzqGBKYb/OS8?=
 =?us-ascii?Q?8RToNTcPAv6AegfExzeiRGy1FmNFX98DDiKzIrsDEEIEE3qtm9JBka6S0TXQ?=
 =?us-ascii?Q?Rd4nDHX8qr57VkkYFcKcKzwN5JraFagkgj+U2riZBYRW2T/EaObtZSl2oH3L?=
 =?us-ascii?Q?VDC0yHcWDowNWsyGbfcHBAg5M2Pbp1g9THdIEYiY/o0/CkhSw6oBrRgLdccW?=
 =?us-ascii?Q?mK64jSFIWmQZMBC+o/Kin7jbuRP3yY910zKxI7e8swteX3GBrpY6y6IePZ4Z?=
 =?us-ascii?Q?4pFraV6tvCIgDHIKWXPBAFc+cqSOTVISPOeGXGnIrjupY0oTzfnkX5jACruG?=
 =?us-ascii?Q?A20ogaCA4ddC+WWpE1o8lMEsLuL+PzDoEvZo41on05zwnXed4m90wSESSxSC?=
 =?us-ascii?Q?w4VTHDYyA/5APo7A1kervkk0NDm8gYKZCgg/pXw6bGVmeKr9TwsAFuGkmDyv?=
 =?us-ascii?Q?sZf6m32+PaTcI568oiOpa9EUcQlPOUiNDH1qSLCsvTRZvTxzQfGyb/d9/HRd?=
 =?us-ascii?Q?BSjkwfoGBCrkzEMcgr8Jwbqe1HaXTKJjDCPtugiswfjilEzA2OxskPbVftl9?=
 =?us-ascii?Q?gWBUZYREfPl7XB3RfW/hosx4b4q9bg0zx/SIfc3qO4QYnYzER4BKR8H6ip3G?=
 =?us-ascii?Q?m8LVk7c2hCDF2LksTSd0jwi2MiJjOQykvRKhrilhQ79mbJp7Vqd7YjTYSU7v?=
 =?us-ascii?Q?+OUxMZj1GzQwlMKxV/fodauoMEbA6tXxRNVm6H6Xxdro3W4vj8e61FB37mpN?=
 =?us-ascii?Q?UXsZrwhj0j7D14Qw3KII+tkfJRLjpfCmod43ipytajRmMz3EoNUwdh09b8UC?=
 =?us-ascii?Q?igJBn89wDMy2AUU1atuC73e6a/9aLLBPfDZ0h2DsptHrHtUdZE2o75ttDwQx?=
 =?us-ascii?Q?tkTwj9hdI8jGLZ5wlC3ALvhScbt0qT5jIw6YRroyqO1se54JvF42xF4fwR+O?=
 =?us-ascii?Q?TKDM2YBqlG8TnuVYzG/RFlHFXuXAoXRvVieEtwm4aFQj29QuwJZaaIysFWHT?=
 =?us-ascii?Q?RAxpHFCXeK2HuqAwr9ZvvPjyllS1BzXni4//GjwMPadBXxkb0qyANBorGfFs?=
 =?us-ascii?Q?0UGMUEPOndkIZtPsDDhJ0UP9FAEC9px/+xbzUFT5ApiWFVeMJsMT6K6TtGfO?=
 =?us-ascii?Q?HYo176TbZWCnIALqBTJr6gcS0mm+pSRYz1dkpPTArcAaZvUa+rh5kNm6GXW+?=
 =?us-ascii?Q?way7CgiaCRUb79ACGncq3V262gqawyeWvnHJPHv5QpKWqyGE6xLSyht3+jsf?=
 =?us-ascii?Q?Vaq9/I3K/8jQcwhDSulaBnojWXE3/mu5SjxI7Vu7AsgyEIevehZOlDR5PXs0?=
 =?us-ascii?Q?3Pn9CAvLK/Sy0vgW6ARHFp0hNbUkR8YXPaGbA/8ig3Ic6bx+f84kERl7m6M2?=
 =?us-ascii?Q?zTde056fK3pdQk/AEsKemQqDJtvt1FGogMPFSe8oBJNYddvU1HGXt+LRi+/+?=
 =?us-ascii?Q?0ahZQFTuPuIvyI5+uYHpZ8J3sXlUzAvHVGTcOfWODJdtZ8jT/1NineS9Zsdf?=
 =?us-ascii?Q?gf317J36t+/oh4dXS7JmnwvxTDJco72oylzy51Zn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03247137-e2ec-4fb6-4d06-08dbaf1e680b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 21:15:33.4182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8S/sYfz9OfTPlMafVGoywhvWm/hALaRWVliLj7alftle+ADJ8wsVIb+hEYEG1OicA8orv/p/B2uNKndiw+ydw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6726
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
> On Mon, 28 Aug 2023 22:21:07 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > The test event logs were created as static arrays as an easy way to mock
> > events.  Dynamic Capacity Device (DCD) test support requires events be
> > created dynamically when extents are created/destroyed.
> > 
> > Modify the event log storage to be dynamically allocated.  Thus they can
> > accommodate the dynamic events required by DCD.  Reuse the static event
> > data to create the dynamic events in the new logs without inventing
> > complex event injection through the test sysfs.  Simplify the processing
> > of the logs by using the event log array index as the handle.  Add a
> > lock to manage concurrency to come with DCD extent testing.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Diff did a horrible job on readability of this patch.

Yea apologies.  I'm not sure if b4 can use --patience or not but I tried
patience by hand and it did not do any better.

> 
> Ah well. Comments superficial only.
> 
> Jonathan
> 
> > ---
> >  tools/testing/cxl/test/mem.c | 276 ++++++++++++++++++++++++++-----------------
> >  1 file changed, 170 insertions(+), 106 deletions(-)
> > 
> > diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> > index 51be202fabd0..6a036c8d215d 100644
> > --- a/tools/testing/cxl/test/mem.c
> > +++ b/tools/testing/cxl/test/mem.c
> > @@ -118,18 +118,27 @@ static struct {
> >  
> >  #define PASS_TRY_LIMIT 3
> >  
> > -#define CXL_TEST_EVENT_CNT_MAX 15
> > +#define CXL_TEST_EVENT_CNT_MAX 17
> >  
> >  /* Set a number of events to return at a time for simulation.  */
> >  #define CXL_TEST_EVENT_CNT 3
> >  
> > +/*
> > + * @next_handle: next handle (index) to be stored to
> > + * @cur_handle: current handle (index) to be returned to the user on get_event
> > + * @nr_events: total events in this log
> > + * @nr_overflow: number of events added past the log size
> > + * @lock: protect these state variables
> > + * @events: array of pending events to be returned.
> > + */
> >  struct mock_event_log {
> > -	u16 clear_idx;
> > -	u16 cur_idx;
> > +	u16 next_handle;
> > +	u16 cur_handle;
> >  	u16 nr_events;
> >  	u16 nr_overflow;
> > -	u16 overflow_reset;
> > -	struct cxl_event_record_raw *events[CXL_TEST_EVENT_CNT_MAX];
> > +	rwlock_t lock;
> > +	/* 1 extra slot to accommodate that handles can't be 0 */
> > +	struct cxl_event_record_raw *events[CXL_TEST_EVENT_CNT_MAX+1];
> 
> Spaces around +

Done.

> 
> >  };
> >  
> 
> ...
> 
> 
> >  
> > -static void cxl_mock_add_event_logs(struct mock_event_store *mes)
> > +/* Create a dynamically allocated event out of a statically defined event. */
> > +static void add_event_from_static(struct mock_event_store *mes,
> > +				  enum cxl_event_log_type log_type,
> > +				  struct cxl_event_record_raw *raw)
> > +{
> > +	struct device *dev = mes->mds->cxlds.dev;
> > +	struct cxl_event_record_raw *rec;
> > +
> > +	rec = devm_kzalloc(dev, sizeof(*rec), GFP_KERNEL);
> > +	if (!rec) {
> > +		dev_err(dev, "Failed to alloc event for log\n");
> > +		return;
> > +	}
> > +
> > +	memcpy(rec, raw, sizeof(*rec));
> 
> devm_kmemdup()?

Yea!  Thanks!

Ira
