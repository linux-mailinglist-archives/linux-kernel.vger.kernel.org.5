Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C218806105
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346119AbjLEVsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLEVsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:48:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DC3B9;
        Tue,  5 Dec 2023 13:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701812893; x=1733348893;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jgJBYJeIFATkuDPVTN9p3WxQBg4tDRLqMgeuZifRs+s=;
  b=l5JR0mXt96t4xM6GrP7/qkCNo9lkOgeHnwbQEgeMv/bLwnoAnS+W7rV3
   PvaQH+4pLaF4Dy+rJ939jKJwznV8lhs1Og2lJ/LjeLQ+ED2UM/V+qXXn/
   rBgNvUwtBnLsHRsxCTWGbwQibebdZtqNHBgvOpxbPQ4peO7jOHX0OIvoG
   9LsX/vt4DoTN1fcmPbr7wwXnBynM4woEsN2bAvIlvBuee2Z5xSyb+8DSO
   jbPalZqWPc89uh2auUoq/U+Qbi4/YV+XeZBllcJM0RkgXOCh7uKLy1uur
   FmVjuBk64k+cgPHXoQfUQDxnEk4+mFVN+mNr9j5lEt0nFO1TmsmqfUPPn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="378984941"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="378984941"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 13:48:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="1018347500"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="1018347500"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 13:48:13 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 13:48:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 13:48:12 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 13:48:12 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Dec 2023 13:48:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVvZfxBYXgUhhRZcGQAtdsO9OuT2RjgBppJB0t8OA5CY5LfwcaPR2KQ5Wmu2di3rIuCa6YS9AApxMSJw+GYGqL9WTlbOz+OtbaRTVKCYcuHqlpvNbWjedNizb/oxwREMr508u0a4aScBdQ4+cba3FowMcXbusjAY7hf3UgSlmGve0wJ7rUm3nmyDBpVpM1UfNxouhN9sqF8sfBmhJ9W4PmfAwbsEhoUPvBlePqbdA6svNsKp7aX0mj/jNbGUvEYB1yFKeuiL67JlUHb+K2tQBXBB9tnJ/AYGcgaD+g1Wmz6glSaPoc5XmM541hbEl8c6PzZFpsZnTmGf5GbR0IWeZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6P2eWWqk1VZ5rRU74+B4fWghz+tYSrZAGiAuWq7LPRY=;
 b=Iid9n9ufPYNScPjVKYH6zAhsf1TKqMECJSqwrZYYNxEPnhS80bEHMrR7gp74W6qOQr+2UbHiVXZfeF3EpOB5A8RAlKXGtKuznVgIOYwOGmzaeUdjDepf/bSZLRZmTGrruiBdWwe/6DeIf1hT5hSGyz9G+k0DzPX2e8dL70jB80tRBkGoZ91eKQIM39hwAPf88SefCRjzuikrHr7mtqyI6cxeiNOhHba8rK53kAQ94DZLIngq1O5fIKd8xa4UWoDu7OvfCbpMKXAOg5SoI97jvNhZ5bAfcEVN8cnbMy0nQrXqfI5dYvLk8pBE2Ek67L60/8YtD+t+TeiUdiosl736kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SN7PR11MB6655.namprd11.prod.outlook.com (2603:10b6:806:26d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 21:48:08 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 21:48:08 +0000
Date:   Tue, 5 Dec 2023 13:48:04 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Huaisheng Ye <huaisheng.ye@intel.com>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Huaisheng Ye <huaisheng.ye@intel.com>
Subject: Re: [PATCH] cxl/core/mbox: get next_persistent_bytes by
 next_persistent_cap
Message-ID: <656f9a94d9b48_18297729452@iweiny-mobl.notmuch>
References: <20231201164005.135912-1-huaisheng.ye@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231201164005.135912-1-huaisheng.ye@intel.com>
X-ClientProxiedBy: SJ0PR03CA0388.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SN7PR11MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: dff2c351-215e-4bd3-4f7e-08dbf5dbde54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qYC1i9MvnYhPkT5/kBEEjStKcZheTsa1R4Yhi4XyZPafRBrIO//y0p6MJo3JtmwIjcDFEW8Eu+c+voHARbBL8Dr8AT6d9wa1orPjjWysHUCcDgdiFJb8s3T8PCC474d6eDkxMKsjKH5bdAnQrzXXt7je88wITzq8ibXZXLvsp8DhJESjyXkMptXrMlW0hzE8NDBCP6ltSk7E5aSPNTGN3Saboj53cjXEg1UnXP0gIDq/yHJl9c4piQYQYXSEhzODVqjMc4dNYKiYz+oEMQyaG2iVhXdkjhMF4zbBBWpPp7fG/l7CQVlFaii+YHBDtpxV8sfatuVgKNGSWBPZ8PcL8/QnRzEtEUGe7gbltulTTv+GQ1T3vObVJErZSCw/nnXM+0jIjgEOvkb8+iWvV7KcgxinHXAQt0eXRGcvHl3IBfbIVvIMMlJ/vvm8TgPa2o4dt+rgJD0fxlrmHaeoaWR4WHz9mF/hWzsWHxAQaN0Uv8kDz1m/ajT1uriKtlUYiM0ajjPbNMeThfz90tWxZpuaINdH6zGO5SFIyNFl0OyAudmXPp71C4IjPxCBpQ3Xs7MX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(44832011)(82960400001)(2906002)(5660300002)(4744005)(41300700001)(86362001)(6506007)(6666004)(6486002)(9686003)(6512007)(478600001)(38100700002)(83380400001)(107886003)(26005)(8676002)(4326008)(8936002)(66556008)(66476007)(66946007)(450100002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zt/XmRIDNk6FfHrmwCa1MAhoWSXDmQ5ejIThYl9vcvVaDjPNSPdIf3ADryin?=
 =?us-ascii?Q?mmNga0QOBKGkJjf3VLQfmnShr4C7QGkSkSWnDJvlspuUanpYkQFIBjsRNIs5?=
 =?us-ascii?Q?YhN4AGdfAOn97G/zyURuRZ8aRro67fvQfvsk9M7GV0VTt6Ozvt+r102YOaYU?=
 =?us-ascii?Q?Clzc2elrsDbr3lWoKztTb8ki2TYnw75X8692Kt55da48PPkkXBfGf68uO8BE?=
 =?us-ascii?Q?qmc/YtiWQFwLLB3ltMi9i31UkDq+vd19SWnu4/WHji+lcztppdp+ACeatIEe?=
 =?us-ascii?Q?adyTobgYKDCknk4aZ+GPDBvUjxcOpdLltYnqcOaGpwXI4OACeJb1HGB1zrSK?=
 =?us-ascii?Q?hRZVnZX+qQrW6dSclmV5xNk9K7B6mz3XkPZjLr5dPStw7TVgweyI2r1gLFcv?=
 =?us-ascii?Q?rCSFsTT9aDus1nxSjpNw5R2l1UvqqZg3OmSMO7ibvkV8IlychRb7PeMlBPcG?=
 =?us-ascii?Q?KHWGQs2YBryU2auaMrIrRYgUQSoyUm3mMguwnM5TQBHSZlwDpcA3XqWVOw95?=
 =?us-ascii?Q?ujq6gldnmq8Y2ruSmDBAnZlP7dK+gjoC8HvD6gxlffgV7CljUzCJoioikthB?=
 =?us-ascii?Q?D2RHjWLzQgrF4zFfsWxVICpPgDrNHoyOGWB1FPaxFbtEhyw5rCqrg6V3kxYD?=
 =?us-ascii?Q?2djzLGKsq5NbpVTR81s69y+rKLHYMNC9U8N8+4xi3rVZNzngbT7+hEhXOpwD?=
 =?us-ascii?Q?QP5wZpEUiOz+yPaXCukKFVx32Le3C7JxCj6scdbNGDK8NpcogSb9Wmqud2Tx?=
 =?us-ascii?Q?ELzyPJSkChAvz4SqomnQFt9l3gh6k24IOkvwALg0X8QDiigGJjk+rydsoDNt?=
 =?us-ascii?Q?qCi2bs+el1E8J/+hpz4iQAuDxbkhe8OihizNY6nfGQiJWvuJ3iofyOc5IQ+y?=
 =?us-ascii?Q?3ZGxLnXyXEkAOy41iyFZz0P5F959nBbap82CpbCb/R84bVoR8QlqltteVE6p?=
 =?us-ascii?Q?Tt4HliuraI4fPzC7LJ+DPMjOA24XDhnQpUKRY/Z96eoIJO7Rx+GAY4v85qMW?=
 =?us-ascii?Q?VUCR9pYhup5Go6JzF/rg5RHyZ16MzFcjjs+TakNypRTAjFLUh1J3zQRTdQSW?=
 =?us-ascii?Q?vMosg6r13QpPpQ5huafp1X8gD0h4W70oxq0FLsZvyIICYmljECPdHEiG7iRP?=
 =?us-ascii?Q?jiG1hYeHN0s/Htg77Ma0JpftsRVtnttxKkTyVCi3GK2hiywkdx34hY/gKs8K?=
 =?us-ascii?Q?Mos9RngVF8CqAbavjKCIn+Nn6x84iMOWmj2X6oaW2ycI+j5ZL7dOX++sNtXM?=
 =?us-ascii?Q?dSKOFnWqZLpyZd8ph4re26lCgRQW7+i0tf9QUWWPd4p3ut5P5ho7MCgwd1m4?=
 =?us-ascii?Q?Ne6vwzogchCNblO5m4wkt6CWkfRDvhN6vHJEdikF4zrBHl7kPAN6onGxb7HM?=
 =?us-ascii?Q?lJkey99n2NIThl4YnBuPfk3a+ra6une14d4qvQr99N7GASoA898qPJQTxjKY?=
 =?us-ascii?Q?fxzvc6uDMsmYDvkwV7TUXNOT7csTWpRjddqG0PrsJDFt7KqoyuD9+QZXIkss?=
 =?us-ascii?Q?DGz5YEzHctiRjBz3RxF3C62DMgkCzFb+pqoEIU43+6Yg7WTxA2Zb4ruMmnXo?=
 =?us-ascii?Q?WMo4Js8EE5VnIvhijFn+xLJsT9wt9+fN56v5oOg5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dff2c351-215e-4bd3-4f7e-08dbf5dbde54
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 21:48:08.1023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /X+l4qbIf34xxHSSmTD4BpUyWYQvNdf6h2npEpqp8dA2EoMmEPQcMroIsIDDCo7B9JT948aq47lKvx2EPycLqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6655
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huaisheng Ye wrote:
> According to CXL 2.0 8.2.9.5.2.1 table 176, the next Persistent
> Bytes should be calculated by next Persistent Capacity.
> 
> Signed-off-by: Huaisheng Ye <huaisheng.ye@intel.com>

Do we have a fixes tag for this?  Was there a bug associated with this
find?

Ira

> ---
>  drivers/cxl/core/mbox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 36270dcfb42e..7b8ec73ca37f 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1069,7 +1069,7 @@ static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
>  	mds->next_volatile_bytes =
>  		le64_to_cpu(pi.next_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
>  	mds->next_persistent_bytes =
> -		le64_to_cpu(pi.next_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
> +		le64_to_cpu(pi.next_persistent_cap) * CXL_CAPACITY_MULTIPLIER;
>  
>  	return 0;
>  }
> -- 
> 2.39.0
> 
