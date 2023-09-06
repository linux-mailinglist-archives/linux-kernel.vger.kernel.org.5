Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8621793472
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 06:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237530AbjIFEhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 00:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjIFEhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 00:37:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30B3199;
        Tue,  5 Sep 2023 21:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693975023; x=1725511023;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DhdzAmatsrIjaCVe/PJ422kNQY+KJ5M+RIK7/Di8fNo=;
  b=gOZAYgdq6ARH5ogibHaYJdZ4gLIeXkwPLppW5yxFep7tow7mBj3bQ44S
   uTrb644lAiz2d2EhT5xkH6jOeQO54iXn6qsJ5etZmgGw0FcZ+B0h1O44M
   WOtKG1rjJf9+RakBnBKRKe73LuRWN38eMWk0vpRCJoi+27D3biMOVVX8r
   YYHdQX/JbLIvCeiwmdsuYoSy5ir1YlYE/al7SiPnuD0qHU1CIMjhFIhpq
   9GKKuqtXz7PGFhhlExdVorj6LDN+SQkS0AF69YX1PcHf+nEBu77N3OY/y
   yD9gKw7sZJ1T8WDuN6OjlJZS1w0qyJ3iY51I5MDynGDjfGDrU4zOJUASF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="374360119"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="374360119"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 21:37:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="691168977"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="691168977"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 21:37:02 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 21:37:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 21:37:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 21:37:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 21:36:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7pP8f8B5MKTyyVshTQVxe6cmLJtpZvvT+9h172Rfca8wT8eR5LFw6A3JPegnSDkugZq1LXs9Nh/4ok4GmOuwZqGGlEM4KZbkmwNkvVHvbc8FXltQPtQxbzr5o+TSOwsPZAYWvD1J6UOWPp4p60Y3DXe7gQwQyXEJhg+OZwUdgWTTXESTsHped4IYPVyuiOsj6Ux6VBZTxl6AuMf5jWmsfaAPdMATDWR34PjRXJFIaKKylFDklGRkbjTM0WUawGVFcD77yr5fpmb4L+M90D6OSFGgebjefzuzAlA/uDxnxz8j2GHIzVoEPzqs7M+B9lcPA25t0lnfAfA3QL84xP5xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVrr7GyqqBo2J5nJ2SCcGoh8bMr1nKMSwHJkfDz1GPk=;
 b=Bji+a5iKDw5GGN31h0/IrWkdsAD4kzuZYy39UYAuCMWubOtqpfb/iMJ5YGlTWvnZXGy7EaDa/oshSu2OdBZZZDPxgpytMZ91tKf8nIATPdenxpcDsurgs8IgtMXJdsTYo3WDD2qCJDIxOKS0SUlxT6S/ThKHAMhQO/AOXPC5rqj9nGSoD6SuErKpyTM/XAhF9Q2ytj39iUf66YdsxAKz89nTMCXyKo0qWLbrNu7hgiizZ3OowK/F1dogW1dZsebLOg4dsAyLnUjZPM2RmHh7s8wcd5OOrCMkcvRieGEcXUt/EdZS0KK17+TKDw+0KYVHVuoac9co4zwY0e2PfT1qMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS7PR11MB5965.namprd11.prod.outlook.com (2603:10b6:8:70::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 04:36:52 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6da5:f747:ba54:6938%6]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 04:36:52 +0000
Date:   Tue, 5 Sep 2023 21:36:48 -0700
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
Subject: Re: [PATCH RFC v2 08/18] cxl/region: Add Dynamic Capacity CXL region
 support
Message-ID: <64f801e098dd2_234994294d0@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-8-f740c47e7916@intel.com>
 <bb4716e5-5ebf-e818-3c37-7ff2f0cdde23@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bb4716e5-5ebf-e818-3c37-7ff2f0cdde23@intel.com>
X-ClientProxiedBy: SJ0PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::20) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS7PR11MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: a2300ae0-9db9-442c-4295-08dbae92e44c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XHEtGrfhbv+tdr6nnAhkmfBHkMS65Vhy+mL7m5AkQ8LdTDEv68/oUaRc1VEu2NP6SFDGxORB9VnXcrAgGMyHCji10K48pU/BRlBhrKznpH2kKg3G5uaZ2c5JGtE0gLEE+nho6IQFW7Nf2ejLRIpcENqS67FICCI21cLnXVxHgLvcKoV+cmRkG4fcThI3YmlsRsJVIxeWQGVfzgo0K4kM2M+HovOXnNmdghKMvnH8T7CwW00aSPjS+YzLTgmUYw3i3NkgSAFtfQZl/zgaLHp0u+Y/MyNJnOoYBqvwBBsIeyLxZGsueTPjxm5gOE1xNI3fGfLn+s7ZuLlMBW8eUB56iV8DmCpq9I4AP+cDpRPXkhz7ZCWopdAeUdwulq4rorLrDVbj5YwISITxWrTyF/Euqy6ENCKt6bRF20moLHjIlaGKMVPvaEzalD43CYRxjWPhKkphqyuARzRgpHDHZ6DLEddi4NGslE5l2XCw+dhVJMmdhhA7SPaQe0upWEXZs4J5od+YByLdm0ZWLq078KOcvuj6Gic8t+j3DYL7/EPPO4qBZOYcU+FVdQkdha2a+mj8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(1800799009)(186009)(451199024)(8936002)(8676002)(4326008)(83380400001)(478600001)(66946007)(66556008)(66476007)(6636002)(54906003)(110136005)(26005)(6486002)(6506007)(6666004)(53546011)(6512007)(9686003)(41300700001)(2906002)(316002)(38100700002)(82960400001)(5660300002)(44832011)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SDGs2qui0dKjYxQ+E+SwjxBX1yYJ5SaGnYKUfPDhSEz/1sCN/8z9sTMiJ/kX?=
 =?us-ascii?Q?+4FEBH5eVwhSaLHNEWCmfiNOvlJpf6MKjLU4vDjaCtgk8vf6nMfgu28LkADp?=
 =?us-ascii?Q?OryTwPKPEdlXYsd/CdN6DZxoLgXjiTqudrvQzjZEI83RtK8MWAuTAe1GzqfB?=
 =?us-ascii?Q?FEnvKJh8RdWmgEk2Q806yJOj7r8T/qwu8e5X/pQIsMu4sPiSHc/ohAXejkkr?=
 =?us-ascii?Q?oX0dssBaS4virBD04n9O7fAX0TOGb3QhUxg8Wl/O9oUE31nefb7eoQaRnkXM?=
 =?us-ascii?Q?0milAuRnwKZhySWS72qphRRGVQwpWzPq9BpSVrmFtMy/cUxKpRQZkA4o/dSR?=
 =?us-ascii?Q?J79Sdm4oalapAYeJSUWSRSyQe2MEP+kDZ2sepCZx4uofqvdByKxzbS+U03fq?=
 =?us-ascii?Q?xeouPIDDqfUZN++90FpguqqcnRaiDkQA7pRE+CfouTzpt0VCtbracILGYDP8?=
 =?us-ascii?Q?IYjBxz5Euun5zUjmvrXy8oytPpcKKyBsIPhDVVrUhkPLx63WujEMnqsB6La0?=
 =?us-ascii?Q?gGxWbiXQKm8GWZNNokVhkTRtK1jNMCi9Kx5PsMskXhdwA4OyHB/Ki5KV0WXK?=
 =?us-ascii?Q?YfK8XwiTwl0pBh/r3YFXSQXetINIJqKAe6FOG+NBqarYx3kXHZeCbBpueyKK?=
 =?us-ascii?Q?JqzaJxcI1KBpDe0tYKcBkSI5j1u7msVJBfaVQ6cg/8gFEawQhEWlmNKS+vQZ?=
 =?us-ascii?Q?G271ybrMAHBzxYPVGTj0z768uwZdT8dQupwtgubxmY6ywcvdnfOoDL0+vsjk?=
 =?us-ascii?Q?J8FxfFLbQGJlxHKa8taaQHOT+L5gU4IPdMLl9VyiWdUInPcG1E+1+uQ5hFWk?=
 =?us-ascii?Q?1LmVudKjGsvXmu79tHMDQ6F7+/51zcsHQBLsSK+w/++TJ8V6tv0dmaxGnGrZ?=
 =?us-ascii?Q?jAV/22C6jaXl+CtJPT3sEIXiFpublTdjQTc0z2ayQd4e476DssLII138D3Rb?=
 =?us-ascii?Q?sH5XuVpsBH3OGaErbIyBhkMXbkwFBRr3RPF+D6soJF2Yq5b+I5veKampQnMD?=
 =?us-ascii?Q?qWAVJkVfXFUWOS6m4cPGG9fjRx8Kb0cXJxqnUcGPvEuzj7+bh4e7EO9fehVA?=
 =?us-ascii?Q?N3YkdtOSvpwT9BpYsP0PAp/KIJTPX1afxW9SdHAzFUJwPdvZb5U69DekLLPj?=
 =?us-ascii?Q?HGm0OG+tACENDvhfF7Txmgn9h2Czry+QcAKk6MXSceoc8pO9fdPVpgBhss02?=
 =?us-ascii?Q?POPxYavd+yqD8ZgRO6ZyPP9ILpr6O22vfvpo8heNvLy/s9Lb/7udn1YgIPpB?=
 =?us-ascii?Q?fAhKuh2DVrjtsJqhcHQFXPInUh95XI+SeAs/Fm9OknY185T5nqANPxp9RIbv?=
 =?us-ascii?Q?n3h4V1UVDN9JsGDFlXYOWaxrtJyZU3OgLENNdb04QqSFY3m8RZRBRFpaENK0?=
 =?us-ascii?Q?KjLZifqqd4OQBrH+MyKEKXXtq/GtdT9erkLHOPvNQvE7j5LkGl2m53LT+OMR?=
 =?us-ascii?Q?6s6PfTDZ+rFagxbYAlYyv6aVICku23c701EuDUBlnzHKmLsthmQ0MVUpf5rT?=
 =?us-ascii?Q?7u07+eFTbsADH4v94J+O8YXBhbsiQfJBxVsgAR9MXKoDUdUixcvHByILlFqA?=
 =?us-ascii?Q?M7Lpfn1uiZq7AKMa3kmxrg5AAjeCBH3tvGsD5zWl?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2300ae0-9db9-442c-4295-08dbae92e44c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 04:36:52.3381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6F+eX1JefZrchO+TZQ4+ASFKDq9G+2WylanTReUY8n0A9eOL8mwzIDkC12qAIw7LF90W3BsmZWEyR8/wRGDM5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5965
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
> On 8/28/23 22:20, Ira Weiny wrote:
> > CXL devices optionally support dynamic capacity.  CXL Regions must be
> > configured correctly to access this capacity.  Similar to ram and pmem
> > partitions, DC Regions represent different partitions of the DPA space.
> > 
> > Interleaving is deferred due to the complexity of managing extents on
> > multiple devices at the same time.  However, there is nothing which
> > directly prevents interleave support at this time.  The check allows
> > for early rejection.
> > 
> > To maintain backwards compatibility with older software, CXL regions
> > need a default DAX device to hold the reference for the region until it
> > is deleted.
> > 
> > Add create_dc_region sysfs entry to create DC regions.  Share the logic
> > of devm_cxl_add_dax_region() and region_is_system_ram().  Special case
> > DC capable CXL regions to create a 0 sized seed DAX device until others
> > can be created on dynamic space later.
> > 
> > Flag dax_regions to indicate 0 capacity available until dax_region
> > extents are supported by the region.
> > 
> > Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> You probably should update kernel version to v6.7. Otherwise

Done.

> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
