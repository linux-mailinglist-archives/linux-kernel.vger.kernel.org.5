Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B77876DF89
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 07:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbjHCFGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 01:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjHCFGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 01:06:11 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C76210C1;
        Wed,  2 Aug 2023 22:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691039169; x=1722575169;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VjLVOAzhMVxWr6S5Yihin6eSHq02XvBbY07d87fA3H4=;
  b=DT6vxZCJW4cFF1gCB8wVrR97NkDIXHb3Bi02DKDHUqwxrs0yK1VBccTk
   hZo/cY+9Yajs2M9xEzVnUMYmmFNJzzhCxssXrDVJ+NKUehP2/KyVPzdXG
   pRwkTNxiItCY1jSEgYr8H6qbElpsETxpU4wTR4suNK3PMmSwxItdMD4V0
   Ealov1uhnidFAoGsnSqH8HaFBnPZPsEDtbS3+U3yzEul5pb4bTILo3z/h
   IYkuj9eIrCGrC/VYcBSZkVRXi+kvOCMNNl9ylh9XhTmhLwvzGg4AUNvGi
   P6py1WHEIZJ12Wr3CwNICkmTkCV86TxcUeYaxht7YXrOkpAs5BO9HNg8f
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="436082955"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="436082955"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 22:06:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="794851477"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="794851477"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 02 Aug 2023 22:06:03 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 22:06:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 22:06:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 22:06:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqGWxJYbA1IHyPj68MyvrYnK7ikgieCUeh6b0V/RcBdbUC3gyW5c+ey3jBzkCvRzPWerl5cA5vU+GAVX+qLAgeT7GD2+amKIeQ3aWOAmwe26OtPHoziErAu4AWrAv7IO6eDrtV0ciDxHojy5eICwXahlKYRE9ttVUoKnOZTv30vO/XIh62jPWdl56rnVqJHV1h1w8tLhG7gOz93shskYVlYVn8yzTGlokWG0h+WeZb0zwYzZSVPS338ZWgelDKliBqR/G7lJBheu584eNUbudBFqCSKtDj0jP6XdEyh+rUNiU/k+p2uwIal56BNUkEcOjHuRskoOsmoxOXXCK5sjlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ohv45FO6plsCnGX0sPuYPx4g6xaRBXgzldBz5O9fx5Q=;
 b=P0KzIcylzlI+RwGqqjJ9MKbbCMOeAhzG/OvYmDu2CkOK0aM4en89pqyijdmnZBMiDv73p43FUUMIGNIGJDYhtVsZ1+FJMz4mn6AJUt6WH2pXaF3U30fkjRkECNeYb4dw3zbtSY9eSYgT0x3K2ooddA1Z+Kw7RfozUkjyGQYhq+6EolYbBdida+WR/P9Gakrge1/I1s+SpXyt1nkLmknHioghRC/sErPgFzdXLiKvZbYuOufP7/Y2q4SIuwCZgoPa3K4jQNHLrA69fCkGwZKjO0FCuS/Gq1WznDRXP1XEI0ipVbuUaixggYk1YT7J+qeXZc3DeacLnapMh0kVUgYZvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO1PR11MB4915.namprd11.prod.outlook.com (2603:10b6:303:93::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 05:06:00 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 05:06:00 +0000
Date:   Wed, 2 Aug 2023 22:05:56 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] cxl/mbox: Add handle to event processing debug
Message-ID: <64cb35b4ef5cc_9473e29411@iweiny-mobl.notmuch>
References: <20230731-cxl-fix-clear-event-debug-print-v2-0-9bdd08d386e9@intel.com>
 <20230731-cxl-fix-clear-event-debug-print-v2-2-9bdd08d386e9@intel.com>
 <ZMqEY2qj8s8uKZlN@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZMqEY2qj8s8uKZlN@aschofie-mobl2>
X-ClientProxiedBy: BYAPR07CA0096.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::37) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO1PR11MB4915:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a79b15-ab2d-4b08-651c-08db93df53ac
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GNH+yOqLwfHEAUDJCHbuFh8GfS+23j1hU1sAoj+a0TwmxHFL+4/f3QSLGBKYg660DjYshS+oEMj15FHVhLE8ZbNC8gA/Uri7yeSwoLiHyqBFSoR6HC7bMWIsXnJs+h2ny/UdVhKicjUICoRPM9oSyVKVdt6r8s4AMMHzDD3a5FGyzHD8B9/SV2dKJZutyQsaegnX1R6aFneWwWvGDjRNEXzbUiBBJsncqtY1J23LOyzSeLoTUTQ7S889LEbc2YkjHkSHj+44UBqsUWY25YSsjuBZk0s914AEjX5ifR3ZH8zTd0JK8ErSYieWedqwMKt06q+cf9OUmoTJZBOOB4ZkJXT2u4dRYzUzTJGz2euiaHtiLL1+xwYiVX2O2wN57V/2WrwEpnjogk1RRLf6xo5MLBtVx2j22D1wW3puWYLUoQK1ZB75Xemaw316SuQl6H1mVvfoFJuZZ05belfQJ7KtgIYxvkoyNZW98SEz/DjMyQpxf6rNbeL7VSHDRtq/kO084s5iStxAWw26eRpQVvSmW2WFhs8LMx8r4BxoEF/Ie3E1wpZR/ukpuHclqsHfWEWC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199021)(6506007)(83380400001)(26005)(186003)(316002)(2906002)(66946007)(4326008)(66476007)(66556008)(5660300002)(44832011)(41300700001)(8676002)(8936002)(6666004)(6486002)(6512007)(9686003)(478600001)(110136005)(54906003)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WJyjSKtf75Djd6oJkWWnLZacJczTpkDyR6nmpsySY7I3ue1zUJKWRwzwbo0n?=
 =?us-ascii?Q?UXhgSu94HtU5N3aOyUJOrnrhfMduWv7iLuHbaKzz1Fd9tuP3u33rv0Va1yNG?=
 =?us-ascii?Q?0zNb0bQ9bGFZOhRrr2GC4IGZIamFOHoINUGLHxEXqw5KLzQqYym2Tmv9JCkq?=
 =?us-ascii?Q?dL0EKUBByhZUGGe198+cgOT2tNUglN4KzdrRn1TuOGQbJ9qvzUsnd6MYGKj8?=
 =?us-ascii?Q?5czPl1nmFBvhs6yR23RmqfczR+KujmW98A/AAzciF8nAdpW1/Le1+zfN4Zr4?=
 =?us-ascii?Q?zPE+Tiwy+2KrCsAS+dag8n6wGuPtz3Prb3+TZX8lzIVjU4e1ozt7uvhmQ50V?=
 =?us-ascii?Q?9VSEGuMSHuedB9ucANAUUzBOhxXVQYpjpmJ8qhhgJ1Uz7ghFEFJ2JPaJ+NlT?=
 =?us-ascii?Q?c8R/KDMJ9W9bTsm5A9jcvp/jwffP9jZtsurdMOno0XOR/7EyPw/iANovvLEZ?=
 =?us-ascii?Q?46nLBixBXrzdt540/s0HDlpK9z+jTc35SeZTrSBIFq4QSqHCm+C/aJhTXYFm?=
 =?us-ascii?Q?Ls7XD4t/TcV1SnmLn2ojL9WwR6qLm1RWgrI6p0pdOMh33+r9ZqxMChO7aMKO?=
 =?us-ascii?Q?QsuT9RS60fkMdhANLWVGw2WxUOJcCCLsU9/9WjlXx5CHP6ZcSjRwgkYy8oh4?=
 =?us-ascii?Q?TT/njdgy6fGNTuKMIwUT2h7JBA9qdgj4F0G2lIq659ky4aa4wTEZnaODyNIT?=
 =?us-ascii?Q?9dCswPx8hh5iDXuKrlsmxHrOnWzu33XxKvDfYGkfhTTnq3N/cdFg1IqHkEp2?=
 =?us-ascii?Q?QrVdaelX2HPRosDmqcJQayUOaLmE7yOdoYNCQ35cAWJi2YKQafRwOekUdvRN?=
 =?us-ascii?Q?7WGR+W5wtpT+ZpM8EfNK4dNr3S2J+ccL851rORga6WiwcGocMe1FzU4Fzusp?=
 =?us-ascii?Q?pOXIJ2hlxUixVz+3Wc6478Vea7e/I1xWStdy5jHZ9m948gnyFPPsmW3VfPz6?=
 =?us-ascii?Q?wIXAFPV8JIA4oc9nCJfJF2siADeIvofchyFfaxiDNrEc9w1HhDMAl+AvR3o7?=
 =?us-ascii?Q?xIkg2PNgCSKWZjZttA4kGl3LDuSmyHe6dushYZZsK462nvw33liT8Ud1CTQj?=
 =?us-ascii?Q?aNO2cnz4GTmYv6ibRw+Ul1OJq0gwCd8/pZdZPawWJWj/UGdoI5SbOf7G0GlJ?=
 =?us-ascii?Q?NJ2vnV0Nla938IZCRHaQtCHSDdRdbg8qdOPwvBuznLL62j1wPJC5uVeTABvR?=
 =?us-ascii?Q?rmVwoosY/wxf4P6FszSdwkAHK0Poaulqwh/dgcjIfM7aTQ3Qy92xTqaRiPm9?=
 =?us-ascii?Q?BRXgOYIKhuvX3BDWsVEX1ATLyoq4IqP2v+F4Tskw8ffUypB6kBgRY9h29S7E?=
 =?us-ascii?Q?/3NrvqL5l/7D4r5wOddOzSLZgRMbwo2Z4mH6Vsn1Q8bSvTvwVC9zlTMdCTob?=
 =?us-ascii?Q?FjmO6NNbskS0wo3kPjHb23vQGpq4VJYVuMxrU4s2ugvfoA2ZEfyfVahh7aBP?=
 =?us-ascii?Q?iSh2+TNiBvmLwN0WWe6YdXY/WMvFkJ0hz55MW8n06knpXrjd6YUrlchNddix?=
 =?us-ascii?Q?lgBWjn2hQNH7Z6A+Yr+CqyvSwUKKjv0xFuq4pbhehT/vAnnOr3DVmKkjNX4n?=
 =?us-ascii?Q?tKobFbU/2GAznERXx+0TgtLipuP6NU0unTps2cI+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a79b15-ab2d-4b08-651c-08db93df53ac
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 05:05:59.6699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HbYrgVrAcVdo8QeuXtXGrl60mqds3CwxiBlNLL8uCZKZtCdm0kX1I4aZBzjxSPX2i6rrPtKtxFMBYSxic/vwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4915
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alison Schofield wrote:
> On Tue, Aug 01, 2023 at 01:13:29PM -0700, Ira Weiny wrote:
> > Knowing which handle is being processed helped in debugging new event
> > code.  Add a dev_dbg() message with this information.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> >  drivers/cxl/core/mbox.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index a1c490f66bbf..f052d5f174ee 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -947,9 +947,13 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> >  		if (!nr_rec)
> >  			break;
> >  
> > -		for (i = 0; i < nr_rec; i++)
> > +		for (i = 0; i < nr_rec; i++) {
> > +			dev_dbg(dev, "Event log %d: processing handle %u\n",
> > +				type,
> > +				le16_to_cpu(payload->records[i].hdr.handle));
> >  			cxl_event_trace_record(cxlmd, type,
> >  					       &payload->records[i]);
> > +		}
> 
> Is dev_dbg() overkill when the info is in the trace event?

The trace event will not happen if tracing is not turned on.

This was all part of my testing the DCD events which don't have to, and
likely will not, have tracing on.  So this helped to track which handles
were being processed from the cxl-test and qemu layers.

Ira

> 
> >  
> >  		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
> >  			trace_cxl_overflow(cxlmd, type, payload);
> > 
> > -- 
> > 2.41.0
> > 


