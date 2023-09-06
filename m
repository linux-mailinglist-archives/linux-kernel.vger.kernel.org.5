Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9447079344D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 06:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbjIFEJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 00:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIFEJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 00:09:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3101B3;
        Tue,  5 Sep 2023 21:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693973373; x=1725509373;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lI3+11216xNrB37tkRrnEFrn2zPXSIwi6UTWOkuv6Is=;
  b=dTS/CmTPnKkrZWW99k0zYgTTuJc2dODMfB68DXkyrtd25PoBAHfor67d
   ZPl4bbY+Xn0GJj1sIKXl3J4DSsf7nZWaH8AVmrZsaEujz828W7FQMjtOo
   ma0+lGJvDluFpbceKQGryRzMb72HlIPpqUPH5EzfWUbOVgqq065UMjQ5I
   kn4osdVtacFVXeGM6KL5aoXCacEZWuLM79+m7bvtPuz9gQCp6M5pk8yoZ
   DiSzGNMMkbJYIHKHCvcwNFpMgXmIcDmobgBRLskUhwcSjPJhNu4zDZ4ou
   gDP9AXMGhD90qGQAbqjSbqS5vY/pE4kgoOpp410VUs0M80UJpDBBwo6jk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="361995251"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="361995251"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 21:08:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="884541269"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="884541269"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 21:07:49 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 21:07:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 21:07:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 21:07:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzqvgTjIkyqJluo6ieqYee1ENvX+k+j10j37tGQNagFeihHxbISamG9EW6JXgnt6v6v0QLdsY9WqCf62m5p4k9oPnFezpoYuPQRtCx6yVHxN9ezq9elnh9TD2q0MLY0go0NajnWvf7pwroIA/Ttvud6aZiXpTvP5h+DK6BqK9oHie0xprMPVv+SVZ9qcM/wWw5GTjpXTqZuouXw2tzp3Y7a/jzqrB2SEOzG6PWsvVu7/pUytEBH2hswnMIZSSTI8/uNF9qWB2PPbqYg5+2ScN/RPWSTc11s6+Sq5tW/ae6FV+9Ep0MqA9pcEeY5LI7yIfY4OyowzYxfltDygN6IJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWwftGQRA9NK45pY3vVfH9OteqttS5/eUit5G1/Fm+Y=;
 b=gVJ2c7zDurNq9/XvurZCKsA/Sq0c89e9n95Q93OxEOOEFWi0MBVLceoJGfGWja7IV20aSG1bRXOOCVeohA/q+/rTOi9bqCIQW12cO11ry4l1o03RcV+PCcpJ89XFC9ztcjbP8YK/CvOMU6fj5LoNSjlX0hlQNh6Dcr3Yz91eN8n7sIBlhzU+Ucqeu2IZgPDxJY9r3obhKGnjY7m2AFLEd1OmkVj0+PLUiRDfq3A+43/6if8DHK+Fyx6BjP21EMoVEVsuwQxhmYVeb+nLm3rg9LW6G8+lkJTnQldZHl+nBMZP4h3YMpv+D0707/AdzwQ9xQNf3AiusKPbAF8Jx44tHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB7049.namprd11.prod.outlook.com (2603:10b6:510:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Wed, 6 Sep
 2023 04:07:51 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 04:07:51 +0000
Date:   Tue, 5 Sep 2023 21:07:48 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 15/18] cxl/mem: Trace Dynamic capacity Event Record
Message-ID: <64f7fb141d719_1e8e7829412@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-15-f740c47e7916@intel.com>
 <20230829174635.00004371@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230829174635.00004371@Huawei.com>
X-ClientProxiedBy: BYAPR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:74::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: a91c8551-4249-4200-da30-08dbae8ed6e0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A8xn+aM16Y2aYdEYQ27N5XE0+ApvFvy8s4LVA8V8yIj4jpAwW3LGe+3IrAiNwAN9h01JiWDRtqtMIYMOJpEkrYvOOxWNg7b5zwajxjCHdMgP/xivJecRmltMV3uq0HxEd3xvG0J49Y34gfLHnjRKJjRfJBPLxdabRCsRPxEdG822G8EAftReA0dtgfscZB6jK4oru3j/6tFyd2v1T2a7Y58CUcZuyHqX0JR5fm/Riw8MgOEtkEl29OO6GmDm+tqdxsFMaPhSBu62jz+HAOapYBNDZicYRttRY9sGjq+lavt0nG2xwccogMX0JrbqjaWBgXNNaATD9xhPkaz1lfFa3e7mX1RqvOwP65n55zFLhUgsAbgBxb53Xkd+66uLXxpcai2WQruIhr7D9idMrsDO90q1A0g1sL/nv2BLv2PyxqbGUTQmuXRDYx4IsMpg8P+pGhxImPG4u8mG17qNpu3+MAwAw7F+TxGdMIuSMQ6+OGLC+mP3naV+Eq2jY5zsWS61ZxjQZLtVqf6o91fzsf1WIHNYU7K+wafu328k/whlH2xdzZnp/9+Qokkyt2rAtnoZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(136003)(39860400002)(1800799009)(186009)(451199024)(26005)(6506007)(6486002)(6512007)(9686003)(38100700002)(86362001)(82960400001)(83380400001)(8936002)(44832011)(4744005)(41300700001)(66556008)(316002)(4326008)(66476007)(54906003)(5660300002)(66946007)(8676002)(2906002)(6666004)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z53xVZKi3BXSxZ9k7gn6Ijw97eKUFpkrV2/pKPPlONO7SpOJn9YYLQxjzymg?=
 =?us-ascii?Q?qwJYKlWF7XYGmLrtD4R38kpZl0aopHt4BS9XfVQl1stxUC8l8yLkEK6XUUv3?=
 =?us-ascii?Q?ilZHwy+HfaIoIEhHcC3mjyKwBsnuXnx9J/VXN0jNAH5CCW8eZ1Y0o5pEKBma?=
 =?us-ascii?Q?1mnqqQzxeYYDcJqpMfzQh/tUWrlYHmRHsDzHrYCfj43B0MTwaSg7MtdfoAHm?=
 =?us-ascii?Q?wCNnL5I+pDsGjlW2m0phd90RgZczc//fop328vdSa1c6sJFSLUljrwHr1xo5?=
 =?us-ascii?Q?gBeHp4pYMHnKirLl3cyVBxTjt7+vW3ALN9tTCPFiNa3A+jTThqW7Z4THPQ/0?=
 =?us-ascii?Q?iztQlmv3UorDDlEwKVuIFSO2s79KLxMwbOK90Sj2+5xZwQS0rcJDslAA9S0L?=
 =?us-ascii?Q?AWg9qxngY8/UaNxR0f4Xyd8sy7pcnEqkBnO1hoBErU4kxC8b/jllOEVwhMhe?=
 =?us-ascii?Q?v/y9/o46M6A5YQlZ5hkAlyckM4l59hWVVzuHx20vTyjhCMP9Z/gG66mwpuqG?=
 =?us-ascii?Q?seUfr9LD46KryeOMTNwFH3+0B1GaHpihoMbKvrwvA+m8m+wr1x0YFQ9SOqgF?=
 =?us-ascii?Q?h3ChKG3DKuEbh+suEpcgAeixRaO9lIfJnaUMdZyua27ToLx4W5+oH8fPbuhO?=
 =?us-ascii?Q?M7o8Z6YzAfoaO4U9l+BER0GtMRIFa7aqfEgPyNey7Juez7WJnX7xsYn6a7Gc?=
 =?us-ascii?Q?+MrAJqr0H2qb8wsb3R0cLoIebRID/NcFmrDPY7omcop4Fd+fc/qrZsidFXv8?=
 =?us-ascii?Q?x3GMCmmZVrjIeDkSxJI8SHGg6Z2MWFQp0PC7MOFArobLP2ucVbwP2yzRqxPC?=
 =?us-ascii?Q?AyLR9C+JyDmjVVa6JHu4LisyFnFCl/SR4uaFP/cjuWFV+LYrrs0HKhRIRhJ6?=
 =?us-ascii?Q?jHlisNutoc3s1EZryqYgp0ha+NZMrjSc/xgD/9zCf+wYn2TLWI9k83ZxNKu3?=
 =?us-ascii?Q?lpXBn7maks2Q8jvgkxt6zn89+MATsIbnVPEWQvi9FY9U1mxVE17oluabROb8?=
 =?us-ascii?Q?+c3xkInTvclX+ajinyzwEkBA8SfXAvKGQ1B24YIaYxJjz465KNKadgXC1z+z?=
 =?us-ascii?Q?K0JIc8FQy+Fg4aXN2swPnF5izugqPmd1MNYKs/YzOIM8MaNH9PjK1ljnGyxc?=
 =?us-ascii?Q?OhBm0MvtbvbIzeunOTLGhz9St2FelaSSL/zD5aWMVbQ07SKlEdPctd6rftI6?=
 =?us-ascii?Q?IT+4vB/ziUtOj2guiV2OtjKadaxBAG+nDwYVSDQksEAxrkSSSBNtHoffbKdM?=
 =?us-ascii?Q?JsThf03aUqiJxqZrCmjCdJfgWEADdZWA6TvPVO9CUDVXAwV+jxhNdudczGH5?=
 =?us-ascii?Q?eWWTEGU4guci6GAr8snWrwaQUZ34HylzihF5LoELEWNXPpFrX/7VxZjNS6IX?=
 =?us-ascii?Q?umvcnrMZB9wWx3pVQ91gM60YKYuGuY1au2cSPZHwXJeG0S3NFp2Ok8/3LUen?=
 =?us-ascii?Q?owjFD26n6eC78HbLTOf2qQfS3LrjKW/6OlhQ1f9+dwqWXnxqgLYaqhLGor0N?=
 =?us-ascii?Q?+6k9Sg3aB2whoNYumsL1Lg8FxCJHDoRIQM2M1TMKGNXEjQ3NB9BWMDkpM1Qa?=
 =?us-ascii?Q?Fhx2mWWlC4/kR5rFuomV56wVtNoDTU2c+eAQu5Z9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a91c8551-4249-4200-da30-08dbae8ed6e0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 04:07:51.8399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /SDUySUmxHKG3a1/s/xmkRoN2XQXnSNm3IdxAlDjJ7v3ix3rm1vVs8J0LIbPkMgJQAZ3vy06u0DMh1R8eyhZKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7049
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron wrote:
> On Mon, 28 Aug 2023 22:21:06 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > CXL rev 3.0 section 8.2.9.2.1.5 defines the Dynamic Capacity Event Record
> > Determine if the event read is a Dynamic capacity event record and
> > if so trace the record for the debug purpose.
> > 
> > Add DC trace points to the trace log.
> 
> Probably should say why these might be useful...
> 

Its kind of hidden.

	"... for the debug purpose."

I suppose this could be used to react to new extents coming online to
create new dax devices in the future.  But that should really be done
through udev when dax extent devices surface not these events.

I'll clarify the commit message.

Thanks,
Ira
