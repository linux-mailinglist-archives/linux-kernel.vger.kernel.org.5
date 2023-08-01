Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398B776BCDE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjHASqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjHASqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:46:12 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C10358E;
        Tue,  1 Aug 2023 11:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690915549; x=1722451549;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wHHHBRQldCeoTitZ6rlOL14VuNopCqWQ3rXxgNBbB5c=;
  b=cPkAQXfkYPwVdUtSESGZ4bonErMuiA1o+YUhmJZh9fm/4VypvQICcVgo
   CC0Uj/N7/dEH429/P+uPA1e5eo2r8XSBh8FUC7Kv5N/2tdqOLIzEfQXUW
   Pz/Mn52AgepEH8jPmZq1ppfccbXKqN2HzDO3Z6JkXgQiEwY0NsCbGP5G3
   LG2nrh3VLOjVj/YhfvEENQNVDcczuYG7R1GXbvUql1iXngvartfCzhBXu
   c2oi6aaARbLIh+qGtk/iitFL4ZnOZ18AqbGR1lwwqWOoMphLkaBW3xnYU
   Y76HlImgF8u0U4TyEabG9S/z/qxychQ+/Af8N533IfYh3rdNaY3/W0tQj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="359428459"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="359428459"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 11:45:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="818898592"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="818898592"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Aug 2023 11:45:17 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 11:45:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 11:45:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 11:45:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFYMXuneGpGbP/bYLFXj8QKYjkKKOMg78mII1hPbzr9FoEp7pxjNY+8vrlLqnTBgCWmIjAbmTj0Vm8JFWdUCFvS0qEDGYbQvwxaVX11xpPv0SKzVBweboejZCRee2GY0IGayfIPfXGVXgATW8m7MktjSk+h5nuaGqBYiDPCCRT0R6sr4ZCqnYK6FmkmcwtTCyPKZFaeFAtQmXzJoHpkznYEW/36gmViGh8ggS6Cjo1tx6rSw6mzLcVXlJVQssTdlEvQZ7zRR1Qc9hNJjBliy4/3VgL8WCIkm1wdZYN+bIuOkm7/SRRUIZbkVnPtYS5wCC47uTeVZ65JR91Qb36lWdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QYo/GWx8lqmjnZ1bYOIlDLHuMEZRn2ui5/1RxP7byk=;
 b=G8CAeALDX9rg7xtvyYt7chvSJXiwrjjkoJtXB9m/HZYpqN0Dzrj4+k8egVmx5Xm0VqPnP6ZtFp8G/rNTS8/VB8uJzM5EaNkSdftdmnlcc64NAo1l3IOr5EaelHZk5DJ+9TW726Pc9sddc/NDtsyg2gYGJVH7/9M91UsBXcX3SdTCksDzvl6hk9pS65OjNcIpvwVZ/yMmW45wIJfVEu3Ihg0pnr+BtGk1BbA+U0PgIoxyKSz6p3NJ04Uiz6c6ft1ecvP1qmFO1yex+Xr/6Z/frEUFSDhYRRXUczg2KVBgub6Zj9YqwDEuuwNo951szBaxu6Lcc6Ga3APyCzq+0CMtVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB6994.namprd11.prod.outlook.com (2603:10b6:806:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Tue, 1 Aug
 2023 18:45:09 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 18:45:09 +0000
Date:   Tue, 1 Aug 2023 11:45:05 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Subject: RE: [PATCH] cxl/mbox: Fix debug message print
Message-ID: <64c952b14b4e8_26168294af@iweiny-mobl.notmuch>
References: <20230731-cxl-fix-clear-event-debug-print-v1-1-42c068f500d1@intel.com>
 <64c831da6af64_52483294fb@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <64c831da6af64_52483294fb@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::15) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: a5d1ccb5-a749-4475-f12f-08db92bf6e6f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jj6XZ0xPm0XCXzQiCYeUpkadrU+pHA03wweAVAab5lxiLE03J/LJ5/pE0AdexkjcDIkI3aspujXXMtMX6TvMj1fmRK4tM1nKpo2+thWty7NHdFvwLgfs21lRN+iLFBEih07BfGbeuckfwhq3HsX97QUvFmdgOosigQUfeUEpMgCg/FQp7xmhUVBNaQt5/8Jxc9M+fX/Iac5dEYGw+qSu8YNYF7Tgi2lp98DXiEwJOtiublBDoqOkhUapkNMh+vBIP0kHzUG/Dnhg/pLbEdpxrnyWya2Cq5oXst/Ofs+Aqf/T5tAHXYCRuWoFpogZ+lcazmMsbtsUHS3JhSKkjQwWohNa+9pPyY3UnCgkPu9nMeXdDKMUW6lMSA/Qds+JRxIFLhKujnFApUXo3uRcfPmnfk1ltfItonf5mVRwULKaEysisNFo+kvZ5ca9e9GRZNeR65+fO3YJ3osyiuakcwF3/f5hNi1IQPUQ5MHdxhvSNMrqdZPyzoM8Wa2PjV7oAn6nkt5K5qiuxtwsO4CybtvbbCC1WQZBUXlkCPHa8XYgOja6ejdVSY/4ZK3ko0efmPm8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199021)(2906002)(8676002)(8936002)(5660300002)(41300700001)(316002)(86362001)(15650500001)(44832011)(6512007)(9686003)(107886003)(6506007)(26005)(478600001)(6486002)(82960400001)(6666004)(83380400001)(186003)(4326008)(110136005)(66476007)(66556008)(66946007)(54906003)(6636002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OknOI5+YTFw5/ZVogdIysLgpS+oGCswFWH+l6hLduOzBVVW0xN7CGIhSfhA3?=
 =?us-ascii?Q?1Rj94zubd3XpgRnrYHeEGe1gT/bzu6mf7enXFv29rbsDr24E/NCKLk1Uzw/Y?=
 =?us-ascii?Q?84u2e64Ljw4ACPxpH7u/MAN5IRZHQUnt4aaklw4Iqtcik6PkSkCxm2Xo7XMU?=
 =?us-ascii?Q?jTj6Oh76iasmmhgJVNouBnGErNxKmCTRQOqWoxcZHzemDY+SrDMCUmHZ1+x8?=
 =?us-ascii?Q?DcZxfLuYHI9XPrh58DChHd9J9cMYLiSyHBWqfrpE1QiegDyiMldXhRg2VwsU?=
 =?us-ascii?Q?bzFHUZXAMNajopIWrVJu3ih31v8/ROVL8qXREtcDznCab4tizuTMnJBUjZY5?=
 =?us-ascii?Q?P9ySqbofwK4p2YD7Fly4OAcrgfm44suHe4fa8Df5ZLQZ8i9uHtX6KFKoAJu3?=
 =?us-ascii?Q?JZELRk2f4zcjjY3I/8SzQmWaVJlbQPrWD3Kuneo/iLa1PE0uXJ9/L9cUplwb?=
 =?us-ascii?Q?5ybh3pPGrK2l00YQ4BXMnkGfxCc6sMGEuojj7shx1Jt3ASipCcuSvtCOrJvp?=
 =?us-ascii?Q?e29zz4nZAYz4dOklyPXPFCmTtsRGZ8LRRoTmOWo7pLfKd14/fSweT0jH60fD?=
 =?us-ascii?Q?uxRJIfKdK2YP6V3+NK/6KfDiNrc8s3owjvtxKpG+4KwzgzX7wkFFUkKJcu+C?=
 =?us-ascii?Q?Czj+cEQM+VH295TKZvWf+dlKkLem68iPMIvLUkJaQnrdVqTkiy9ZNdFOFp/u?=
 =?us-ascii?Q?LO9unAi4CES5BZw1NQZ+iM80H3+YBcK5ExB25mRb7OU6amVqTo90hP6zchQ4?=
 =?us-ascii?Q?x7PwFM4eIAdmihFIBhTqHrMO+oe8RytKcYawd/kYfvN+detBP5RsyIhTFrE1?=
 =?us-ascii?Q?coLQiuURAcjydU1Fz/rMB1axK4g7BQpiIRSTXmKnRAfPpNj6lXrASL3O06ls?=
 =?us-ascii?Q?aP0fGohjbcitxphez18kWlZhw6gNHh+1VtYwi851PgOUX5RBwARhHmwDd77o?=
 =?us-ascii?Q?kQrV9I3/OR5GyNoKNGi1v4WGEcD3fbjKLK6vv9NX4nd8GvrTCK+0/65ID8hN?=
 =?us-ascii?Q?aS1E+Qo79hBjDQ/kVOBULVSm/LCUw9gaCruZpTuSMtLDbnNCPcxANIjLnTBr?=
 =?us-ascii?Q?ULUOvqxsgRt0B5SNblxB8lk7ooK1ORI7VumeZPnUWGmx3ISMVbRA6/C+8oks?=
 =?us-ascii?Q?hamQyES1M0Pv7a0SvPAnuHjjy+wM7Y+jmVrDW2TPnG2ybT6qweAHwqTbeSpD?=
 =?us-ascii?Q?BiIalInJYhCPzpZAZOy/VWgDmGo7L0PCEnuhdoVZP9gI3ucmJSQgU28pxE3M?=
 =?us-ascii?Q?KSNpeAaYl9FrWHZDtudhDAZJh1gGMs+CyjSREpd5U50x7Tx2OSN15wG62A3q?=
 =?us-ascii?Q?0VO5aoWPaiT46g7hli6AawL7nii5HzwU55nBZV0Ew30MQjC8LA3/kvLTyJpG?=
 =?us-ascii?Q?z18B6/SnopqKaWEfbFMf1Dh+AyhBf6JW44BE3Pk3w0j9QbQjeihIgKviWUxM?=
 =?us-ascii?Q?E6mW1Lc1NRnDaqONz11mw2fuYHFSMtxFOh+d0N5hNM6RHZVKmP6XjItnZcnU?=
 =?us-ascii?Q?GvCAyVpMmByCXSC9tvXVdB1V6Jy70wc8/AJ/dTvbOOnIGoyJatkC3uUdeUn5?=
 =?us-ascii?Q?VWGzwWUQket/tMbcRqvAABm9M2hkElKc4/g9LvPW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d1ccb5-a749-4475-f12f-08db92bf6e6f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 18:45:09.4897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z493UtZfKREs41u4RcTgO9GtaxVziEAYuEs8biKHf30/J8ZrM7PgkDhWjpzXtqJNkvLo4UmTl51H6lfi1XucVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6994
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
> Ira Weiny wrote:
> > The handle value used to report an event being cleared by dev_dbg() is
> > incorrect due to a post increment of the payload handle index.
> > 
> > Delay the increment of the index until after the print.  Also add the
> > debugging for event processing which was useful in finding this bug.
> > 
> > To: Davidlohr Bueso <dave@stgolabs.net>
> > To: Jonathan Cameron <jonathan.cameron@huawei.com>
> > To: Dave Jiang <dave.jiang@intel.com>
> > To: Alison Schofield <alison.schofield@intel.com>
> > To: Vishal Verma <vishal.l.verma@intel.com>
> > To: Dan Williams <dan.j.williams@intel.com>
> 
> Is this some new process recommendation to use "To:", I would only
> expect Cc: for maintainers.

It is just what b4 does because all those folks are listed as maintainers.

> 
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Jonathan gets listed twice because?

That is odd.  I did not notice that.

> 
> > Cc: linux-cxl@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> 
> I assume this is because b4 takes its address from the patch itself?
> 
> It just feels a bit too noisy.

Yea b4 generated the list and I just copied it here.  Vishal is correct
that this is automatically put in the tracking cover letter commit b4 uses
but I copied it here because it was not a series.  I'll skip this in the
future.

> 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > ---
> > NOTE: This does fix a bug in the patch referenced below.  However, I
> > don't think that warrants back porting because this is only a debug
> > print.
> 
> I don't think that's a reason not to flag for backport. Smaller things
> than this have been backported, and if it saves someone getting confused
> in the field its worth it.

Ok.

> 
> > 
> > Fixes: 6ebe28f9ec72 ("cxl/mem: Read, trace, and clear events on driver load")
> > ---
> >  drivers/cxl/core/mbox.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index d6d067fbee97..f052d5f174ee 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -882,9 +882,10 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
> >  	 */
> >  	i = 0;
> >  	for (cnt = 0; cnt < total; cnt++) {
> > -		payload->handles[i++] = get_pl->records[cnt].hdr.handle;
> > +		payload->handles[i] = get_pl->records[cnt].hdr.handle;
> >  		dev_dbg(mds->cxlds.dev, "Event log '%d': Clearing %u\n", log,
> >  			le16_to_cpu(payload->handles[i]));
> > +		i++;
> >  
> >  		if (i == max_handles) {
> >  			payload->nr_recs = i;
> > @@ -946,9 +947,13 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
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
> 
> This looks unrelated to the fix.

It helped me to debug the issue.  Since you want this marked as a fix for
backport I will split this out.  Potentially just squash it into some
other patch or make it stand alone.

Ira
