Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CA1798A13
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244676AbjIHPgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbjIHPgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:36:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FF21BFF;
        Fri,  8 Sep 2023 08:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694187365; x=1725723365;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=z8+OgtB6PsW2OCqnA/aFlOPL5hdeI/O9/ahIRx2dXf0=;
  b=FLoVWWKZcsVbPvd2KbpBxRnSWi6u98YVh28mFP+Kv3ypAqNKLhUhU3PE
   FkIFT9k0OjJZRvGxTv8ZBh7bEcOlHXOK1W8Z1fNQhFHHh9cy4WfFAEguu
   6BCBVF3uJ9azfzn7OgRcW3ZddkVqf9Jdqk2xzpSq4SZGvH6JbBYnn8uWt
   O5CyM5VC3fOzqS8iQw41mHMBOM8QVBxdgqHQDYk6cyK7hc3wj25eQoFXn
   u5QK9EurKxuMmOvXl4LtT1HlvjYxBS2u2WWzUza+Eu848+P6tJomu9sxa
   1AK3Ql9Agxvw7wpQaOxTGjlWsgbl21bkRUJ1Wy7jbDJ4CkV0K4NXe9Grs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="357978802"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="357978802"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 08:36:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="832695267"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="832695267"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Sep 2023 08:36:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 08:36:04 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 8 Sep 2023 08:36:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 8 Sep 2023 08:36:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 8 Sep 2023 08:36:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQwzolUSMXdxPN7T+22BsrQJ+GYm15RWkyZ2gurvmXqE7XOyuclDc/5+H/Ug2hRoEw+zLceZceW5opG9s0s3sH4Hyt1/TmRPXkXTkMg+cF1cBhnNd/MbgaWcTlloAZfbzB4i1SIi8hzeysBdDqXM+eikzNz9hTTbrTvoDZUhcJHzRIVkrZvSS++PuXNJ2r610ee1Q8oHiVLb5CgomQnw7Bko1ejJmdDomJ/iTLr1NBCpw60xtQTbSbUVgkLNdgdU4EclgVgBWzOSjFmieBR1c+b5eSJlADvtlwWXyRv/a2+fJ8CgwX6m2DS2OnFmRWnwrKRypVA5l3zb0eOYxNLF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58anqLNTxzKzUGCm2Ndb/PtuVSElxyPqteXUNulTXPM=;
 b=aOFn2CmNeP4ZDwiL2+cAuan6uqatFErxIfuwWwSGkE5u3jmgX09D2mtjq7UAY1OAsPAjO39+yZ2BfnKQjBP5TlTXBkwuu64eJ/GBZwmpoho3QXSPX+rnDy+SK+NOstRP9u9KN9Rf+Pn+2D/zR39B6q1ng7WIgUQGKZ2M1ODPdHkaLc95HyqowUGZIoStJY/4XotGtb1P0oxgE44+kGRzIIuoPosaG4CUVrmShOOvvCWUHLP4pfgdbDijuwe0FNvHGtk5tMGwSRklVCyo2yOytaEkpQrdL+qdNNdCh/K8cRzgszu5dUCPrJ5S14qYpwPCaPErY4uZEpCjieKj+GUFeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ2PR11MB7547.namprd11.prod.outlook.com (2603:10b6:a03:4cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 15:35:54 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 15:35:54 +0000
Date:   Fri, 8 Sep 2023 08:35:49 -0700
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
Subject: Re: [PATCH RFC v2 10/18] cxl/mem: Handle DCD add and release
 capacity events.
Message-ID: <64fb3f55b9392_1e8e7829433@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-10-f740c47e7916@intel.com>
 <3546729d-d67d-fc93-5c03-fc864fd23b4e@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3546729d-d67d-fc93-5c03-fc864fd23b4e@intel.com>
X-ClientProxiedBy: BYAPR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:40::36) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ2PR11MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: e75dd36a-b639-486d-ebc4-08dbb08149fc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zUU2qHJjtU5ECVH2KtOMUgYyorsKaTeW2AZnugT47KNYtIGFME9wyxZ5eq9v3n5XMNBMJOdhcR7OhoSQH/9VGGkbd02VPM2PYLEriqo/k87Xe/S6Atlk5EYDDdcvyCCfI8cgbxzwPSvOi5ytvUKa5QsOIRzA57Edv614pDFXUdfHm++XZeTyyq72frlv+Zdbtn1M4zZoaiXB0FLLW0IeNUXrSZ0FftENI69WwtTyrCye96VAsz2HKzivnpsj6o8s2DRDEZ2MhK9kNLZ+2Tlzb23J+Lz0+gZuFGz0D2kTbbyTPQAbGDMUabuWApxjzZvx8bxHpLRL1/7xpzzI8lxKtHcowkqk2qTHgEtdJpwlaFBM9OHRhi80j2IqUngrcJngk4PGglzDoZXAZaalzTmNyWF8aDUI50TIy95fuNwuJ/7MZW6zsJe9lNlWPCK6oz+pfSrQI0ma3UM+lakksJRPjtaJtnAckiUaeewPDRboDS2J50tIS6vT7OqylsI/vR8jtLuVNN31Vr0VX2Mvn+/th8/J1GO/duijzHRH9jLCh/FJVu6sg3Kzq/9wIbmQCBHQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199024)(186009)(1800799009)(8936002)(4326008)(8676002)(4744005)(478600001)(5660300002)(66476007)(110136005)(66556008)(44832011)(66946007)(83380400001)(2906002)(41300700001)(54906003)(316002)(86362001)(6636002)(6666004)(6486002)(53546011)(6506007)(9686003)(6512007)(26005)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5jCV7QgJTScwwpcWaz/yNVxhEuk3vxdpEpYm9J0hDMz6/OPt4vQQ8klip+/j?=
 =?us-ascii?Q?5BDkHDBNzlOhNcCz0yfkDyZ3APu++kh24yG6eOSeTpuSu2xIH3c+Zbd1CI+4?=
 =?us-ascii?Q?0tCv9JAN0W38r0nExfv1DeqrgBkhhzCZA8RdjDHkj0M7XF3E0uUD555JT6ws?=
 =?us-ascii?Q?Xaq+vbXn1wESbJ4yGfD8k8kpN0c/jCkn5SHatNOhYJOIUW+pdh6YA0pIaM9F?=
 =?us-ascii?Q?4a9dfWu1lRS7oBR6YHBsqFymfT0rAdTDuDlsKdvdHjqCQhIc40iuKmBmE2wd?=
 =?us-ascii?Q?0+NhNUYb71zuVC/ZQ5gc8VyhyrekGFR5V5ljg0bTATxrBLX8Blm6CcDwuIJP?=
 =?us-ascii?Q?zCaGwKffk1SSiy0IMOb2qi0huqJaTQ1oR0QzCXUcQ4kv/7BoEhCatP4ZwpnT?=
 =?us-ascii?Q?Czk5ZQ9eVwjoSlLYAg5kT/rjwuMd5bDPLHkz7iVBXCEdEUH7fZ91vWCfkhKi?=
 =?us-ascii?Q?Hj7/qc6PEc5j+arqGJTW036WiOlcb5wJIWawQEvlBvt735+dL19AbCDvqelT?=
 =?us-ascii?Q?cwXrFI0xb2ox8mhVRDewHjOAnLERQ7NRea3nw/Sw+2hpil6Fd0D/UiuGVwc4?=
 =?us-ascii?Q?LqcMtmiSMN8Gov76a8DsV0rRzIHi3IY2IFG3CV0wiZaUsrqC9eENAe3j7q/7?=
 =?us-ascii?Q?L+XxgSPEopoqvyVta4dVOQTUXhNhqesU1Vo7SyMHYDPb722MvWxkZ6uMEJRw?=
 =?us-ascii?Q?vxN0/QdOvT8Mrz7PoTRroEge5YRhBzzjtInGcpCNKH9B5GbDXcrEVDvpLalA?=
 =?us-ascii?Q?bJd4t/4k3PVdzkroInu6tAevg014N/jrOztEFGuIHPrv6Z1jehnJi5BeEIXv?=
 =?us-ascii?Q?fQDnQAXrzXFkYh3UPnodecEj7dpd4oJnS+L2hYzsKlAd4YDeR6qG/t4ttY6d?=
 =?us-ascii?Q?UDqWKeCUXvo4nOkuiTcy2nAjLEIvB49XDA44zoBGVKYcLrUzJBIld8q8ffx3?=
 =?us-ascii?Q?3hlROhZQd9N5/Xk2DscUssOTW3gZVztPOuXUEZu28VJsO9ASC0M9jCeullVY?=
 =?us-ascii?Q?Gno1izYWFaek71wIEgeU3CBoCV7QHsukbc52lKv8ruoqqCYwK3qOGX9Er9YC?=
 =?us-ascii?Q?HKIKEFDSGk/8ZlBEwZkWb+cZG1xxUCe9WCG0kaGQ3cXPdr1IR0mI248YUXs1?=
 =?us-ascii?Q?RzmFO5ob+MducHB7hDCpc82MCryIyOKAtrWvix4NosFq5p8NKadTR8kbXGDR?=
 =?us-ascii?Q?SW+ygX4y478TouheK1liVm5Ih8eaTPF47ZVNYDoFPQTDzPcLOQmDLKG848yM?=
 =?us-ascii?Q?OI7r6RS0rfLbdKwGL/vvN9tGU3pqGgSQtafOqxN3IUFb9Nx702NDqWDzl/tQ?=
 =?us-ascii?Q?eu8i2hRIdGqxwgwnP5i+LbpOJ9pECWmFblPDhbZATXc9UwEurhZ6rQo+aNP1?=
 =?us-ascii?Q?7LUSflrApaBxNbPwgNjDSosuidKGZPKQ6h+rsXwk7EPt+rOIEJeNZlqXPcAm?=
 =?us-ascii?Q?sZnnn86rbS5fcOBvx4fJDkrXwSbKOQhgKUrL1bylhmT/KH8lUfRWPVsxzsmi?=
 =?us-ascii?Q?BQBz1R29bOja2jusjWToCXqAX6HhgsEe3WbFOiJqWF5auZfhpns3JWowg5qN?=
 =?us-ascii?Q?V/Wd6syX2Erged/7YuUphbzz6ImJc31OTmuHAAPo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e75dd36a-b639-486d-ebc4-08dbb08149fc
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 15:35:54.4195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tNRnOG8RxP+7O1R+Vi7iLhv59sKr7mzr8IOjS5OHvv2iOO2L9bZ4hD2aNUWuUUAJBo8n3vC/xLDJqroAYAKRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7547
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

Dave Jiang wrote:
> 
> 
> On 8/28/23 22:21, Ira Weiny wrote:

[snip]

> > +
> > +/* Returns 0 if the event was handled successfully. */
> Is this comment necessary?

Not really, deleted.

> 
> > +static int cxl_handle_dcd_event_records(struct cxl_memdev_state *mds,
> > +					struct cxl_event_record_raw *rec)
> > +{
> > +	struct dcd_event_dyn_cap *record = (struct dcd_event_dyn_cap *)rec;
> > +	uuid_t *id = &rec->hdr.id;
> > +	int rc;
> > +
> > +	if (!uuid_equal(id, &dc_event_uuid))
> > +		return -EINVAL;
> > +
> > +	switch (record->data.event_type) {
> > +	case DCD_ADD_CAPACITY:
> > +		rc = cxl_handle_dcd_add_event(mds, &record->data.extent);
> 
> Just return?

Fixed from Jonathans comments

> > +		break;
> > +	case DCD_RELEASE_CAPACITY:
> > +        case DCD_FORCED_CAPACITY_RELEASE:
> 
> Extra 2 spaces of indentation?

This was a checkpatch issues.  Fixed.

> 
> > +		rc = cxl_handle_dcd_release_event(mds, &record->data.extent);
> 
> Same here about return.

Fixed from Jonathans comments

Thanks for the review!

Ira
