Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD4A78F24F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245393AbjHaSLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237210AbjHaSLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:11:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AEDE64;
        Thu, 31 Aug 2023 11:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693505507; x=1725041507;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=anrZGe+fzBnc/nPXGR4u93hTlurg8I2k+hAgJjxDSTg=;
  b=XViZFxYhrRxkLMUrUGPORF/Vg2wnMIyjgilFMZwELksLVt5Ci98t9YSa
   jQrVFvmQw6wg/9gCxSVOWVnKB+xeZrZ94iIS1wfnx62ywrBlDkxCPdyfj
   FBWhrmjLVxwGxKAZg792s7yEOtN4qDYK0R/4uKcp0vXPjjTLAWxXW5N6E
   qnmSJ+wJhlv+5JA58yrMABVxQHn0j4tBpYqM7oqMKXWh9SEugICMTrv8G
   RgkpMipgMNGkYuQsJyANC0KGPaldDxvofmdZkf/dfXprS8Ro6jxmVE8Cv
   HXbZDF7eLmXzGvmzcBuMVCErRsKxKJQwtkX0hcimw4d5P4DGiDZbGCniE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="361046984"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="361046984"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 11:11:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="739623273"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="739623273"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Aug 2023 11:11:46 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 11:11:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 31 Aug 2023 11:11:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 31 Aug 2023 11:11:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBRl5PgSIjL4qoy7kWjkAhZyDVg7xpW7h/O0c8PZul3XY0KmLqu1Ey6c2/Xw/jnTN4mkNlXVsbl2yoaktN6ezg1dJbHkU7yaBvqXbS6Hu/pTVRYQGwgqA+Dqggytb8fgoZWzyFZxkLQlAky5Op3EnbgYVjcciaJ1gzVkQq/k8VXpBYgSbF86i6FGicxsRevksZQ2+VPVmaP7ipSCQOHHx6qEAbnt+blKwayRpDupVL1g3cN7G0z46Fcpq5x3ReKv3CR0Z3Hy+wkJRlPNCZIvr4Vmp9RZVfw66Pa0+bmac+Qb/dsX+MZA02CFr6ZxLhlt6g47ySfFRX3jVlht5Z3TzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ly12Z0BZESKYKjoZiuF/BGJfZu0CHf+0kvYirXXMsQ=;
 b=IYrRHLDEuG5/s2+MgSHnG9PxCutdn+ntoLw7nnbqaf/dPiHlMXKh1L+B9pF9WxBTYa51HtopaZkvPLT+p2nDp6u/J9nU9k8/HZ5K0eXhOZuJs2ElT0mRxHtV9URcS/DTNAP7B2bqy0WenYER8dcghbkst3JL+DS0Ooqi7K2t7NmlsDy/upiO0Up2xwVdpKca2l/tTqJyCKiTPnJUfglLJO5qlcoVkxgmfELNUvr5wkRW5eXxO9BzvKicoDK/nTh4mYBbrxDsBtR3gZOIACyRoz4mlGNX2HIfB4V7mVNS6Za6DGY39Hw1GIwwKm6O9F+XZ6UBTnw9UKn3IseD1h/K5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Thu, 31 Aug
 2023 18:11:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6745.020; Thu, 31 Aug 2023
 18:11:43 +0000
Date:   Thu, 31 Aug 2023 11:11:40 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Terry Bowman <terry.bowman@amd.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <dave.jiang@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <terry.bowman@amd.com>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: RE: [PATCH v9 02/15] cxl/regs: Prepare for multiple users of
 register mappings
Message-ID: <64f0d7dbf05f6_31c2db2948e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230825233211.3029825-1-terry.bowman@amd.com>
 <20230825233211.3029825-3-terry.bowman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230825233211.3029825-3-terry.bowman@amd.com>
X-ClientProxiedBy: MW4P223CA0025.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 7986049b-d751-4cd3-63aa-08dbaa4dbb13
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LLfLNCCz57UfMuAIQQ85DR2ox3X1uR77jIX9nz+vGnslZu9BtJHZjI1Eg+UnXxp0QOE0CNYWau9nXnVEG23/8VgE+xbKJqZn56LiiarsxDVWThIPhQd+mckrZKkVTOHN7A1cDz/SqAru9mIg+S/m6F+C3Q45vIWgKPDDOGLZ5odDdvTEb/V2wZo5+moNc3nyBebQj3DNCUbmypkY2r8bI43qzl/BmmzAzxP0JfX58TOJjWElxHXsPsukbsiK6DF20hLIziW3e+PPM7+H1e+WKF6P+Z16/rWwXiCLPvazPVlCCotCbmpqGWW07Y7YSICKV+qDjesdM8wf325jJ0kAd00HM4q4aUSb1l/AQcU0npxd5BpnyXkO/ooX9oSIOYQ/wcfNP/+xU0czPWkNV6tBknVOQn7LVgOFkXtVIJSkyrDDgYzD44FUCoSb6c6BplLGfIHIwEqja5mQotUkMvVydf0DXH/tS2aVJflLlryY0fuvAz/exHdnc0XwF7lDuDoINGYV08CR8iFn/sDhk3KhtiF0FYhFCN3yJoZ8VFfrvwjp9XA7vYMZqtGkagyfbpBr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(366004)(376002)(1800799009)(186009)(451199024)(66946007)(6506007)(9686003)(6486002)(6512007)(82960400001)(86362001)(38100700002)(2906002)(26005)(83380400001)(478600001)(8936002)(66476007)(8676002)(4326008)(5660300002)(66556008)(41300700001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r+Ool/KZbwQ3it3Y9L+QQ0nZmcfSS/B01gHqK3S8tP6GPEcjLINUpvvaLpwN?=
 =?us-ascii?Q?1d/4ZuAQvnLKvP4u37m9KwQCg4nBy9lC0RcaNgbxOVXLvAnyb+/ToZ5MJ/RM?=
 =?us-ascii?Q?OCfUoKsPHfQhx4t9W0OgvALGMh5UNWdoHUM1sJUyAVjiw4xHn9VwIYyJcLEo?=
 =?us-ascii?Q?DIrLRc909uJ6RJj3/9YhaAEWxNG3myMfKMWPOnI1BrXsdDZfu3x5Syo8lCM/?=
 =?us-ascii?Q?z0PhcltBBwux9en0ptbuEGrsp0lDMe47C32wtN4fcKmzPN1NZUXIrug0lnEk?=
 =?us-ascii?Q?AaEbhjiRUJF750qoEWt/+ZQ0Aqo0/wToO/eBCJnITdkq3FUy7QH8egJzqNvn?=
 =?us-ascii?Q?lTCpRBvzbqe9X5QyMTvHNFsCZL31mytZba1O6wYKVQVCLlL+72VCnURV2u+s?=
 =?us-ascii?Q?Isd4R2zfk/m1K8H1/PcAzsDg5bf1lKzqWcQuk9QiCBx6mC/Xsg8vPrdCEom9?=
 =?us-ascii?Q?fvm3xGz/vmLQMdHjgX1VYEnaMgsOXzAUcFeJY9bQliZ9szeRDZScxtT27l28?=
 =?us-ascii?Q?XTzRzl63gzzsdsPRMMmGhUySzI4Yu/Vm9PUqgHV85JXez9aM1iW3Ut0UCQd6?=
 =?us-ascii?Q?ToNX+tsGJHKoB4PmQw34mPc6MV0jt4jcGNrbzOgY/GuI3ztBW8mKcTCs1Y7/?=
 =?us-ascii?Q?kUfxCqAmHVzH6OCG16KoElRFu1G26g93M8wmcZ94jfQ1PPvRBInRfdLFhImv?=
 =?us-ascii?Q?tx6gmxvFzSrlcEQ2hmZTcCBsWSWmwIvoQ6teL/6bneGTjIsIwvmf+2Ayq0E0?=
 =?us-ascii?Q?Z9mXrYguoOcMtvOesuwxvxbquzUW5DGf98Jr3j2L00Hc7GwpqXv4fe7pgd56?=
 =?us-ascii?Q?RJiiRrZZgu2CRrq+OkKCI1oHm/RDyLq21W7J49j9B52xkjWKrFzp7k45aiO8?=
 =?us-ascii?Q?KCHv9G7/ykITTm5+pLHaRGK9dKcDN4hpHIm13uCVvomYkSEYOd2FsB9fM+2F?=
 =?us-ascii?Q?whc3ZIor1h4E0jgv9JqKapXmCiy7HTOJTMqDcgb4qKIPDEYXjxv2w9OtJHKm?=
 =?us-ascii?Q?ZBpuiS/xipktNPJcb74KG4JKsJ1wOZezKu7DFOs3Q72tm5DuwbmZQxGy7OOO?=
 =?us-ascii?Q?InrdUbKo0JJ6XBqXi1woUfs4gkV/Gbr/SMtNiHHcOHN3dVWOupUebYM9LSPD?=
 =?us-ascii?Q?YOESkKB/pfelPXX97YSi1yuf4DKyveZVyjY++p7zPGGU2L6V0o7GZEl7pKmR?=
 =?us-ascii?Q?HmqKUxX/vQVFbM6xWgSzCvJDz6GMeJFOrdc3/FEbcztjotpekuclxCBAwukp?=
 =?us-ascii?Q?wC7LQuFY5yjOShlpZ9c1+2Vat8WXrRmI6hUgyuZJh8CKV5CLeKcxRsq6zbCu?=
 =?us-ascii?Q?wSsp8vYq3SPIRBF7xxFroeugKGiWJ/1HUaaTO2XWcc/6d36ispefbOjaagHs?=
 =?us-ascii?Q?E1PPtfqcVnPqVPLbIxy8D9c0qhQLZQb/X0O0U0nV6LuB7z2Oze8ggCKy1peT?=
 =?us-ascii?Q?D5/9LV8koOKuL9btlpc9Vvjr9/APF0gXT+35LKNyFhpaLgtMR8U9OrYdJkj9?=
 =?us-ascii?Q?Hr+nSL8jCcZcjdsRxTIPkxU3v7fjIMOfv9fWwUAeY1khc0ASnWOWFGC5SolP?=
 =?us-ascii?Q?BUmoRaZWUp8l7CFEtcSA0XlmB2S3GYfAkOPvJgDUZXfObmDC2v1lWL5ntb/H?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7986049b-d751-4cd3-63aa-08dbaa4dbb13
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 18:11:43.2699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q21vdLvtsTxuc/viVHfPWN/aSOH5Ov9nYfv4KBvXADzWUZ/wpG3yqUhG8RLCIbTM7sV5oMNRuLnjSrlOwSJpDhuT5HOJ7QTOTCqN/ny6Qqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6304
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Bowman wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> The function devm_cxl_iomap_block() is used to map register mappings
> of CXL component or device registers. A @dev is used to unmap the IO
> regions during device removal.
> 
> Now, there are multiple devices using the register mappings. E.g. the
> RAS cap of the Component Registers is used by cxl_pci, the HDM cap
> used in cxl_mem. This could cause IO blocks not being freed and a
> subsequent reinitialization to fail if the same device is used for
> both.
> 
> To prevent that, expand cxl_map_component_regs() to pass a @dev to be
> used with devm to IO unmap. This allows to pass the device that
> actually is creating and using the IO region.
> 
> For symmetry also change the function i/f of cxl_map_device_regs().

I think @dev is too ambiguous as a name. I.e. when does @dev refer to
the 'struct device *' instance that the registers belong, and when does
@dev refer to the 'struct device *' instance hosting the mapping for
devm operations?

One of the ways I have tried to disambiguate that distinction is using
the name @host to explicitly refer to the context of devm operations,
and @dev is only for context for dev_dbg() operations. Can you clarify
this patch by using @host everywhere that the devm context is being
handled?

This would also satisfy Jonathan's concern. I think it needs to be the
case that @map is explicit about when it is conveying some @dev context for
dev_dbg() messages and when it is conveying the @host for devm
operations because those are 2 different concepts.

It looks like @dev argument you are plumbing here is for when @map->dev
cannot be used for devm operations, so at a minimum use @host as the
variable name to make that clear...

...or always make it the case that @map carries an @host parameter which
would mean that ports would need their own copy of the comp_map versus
directly reusing the one in the cxlds since those 2 mapping instances
need different @host parameters. That feels cleaner to me then
"sometimes map->dev can be used for devm and sometimes not". @map->host
is always the devm context.
