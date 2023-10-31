Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C250B7DC663
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 07:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbjJaGSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 02:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjJaGSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 02:18:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62101130
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 23:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698733118; x=1730269118;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NyEoznET54YCz7kuFt0PNB4G+3M7o3wChdoIcBnHdmU=;
  b=W5pINHLMccrzm0A1eDpePpdprsUqDoTt3bgS1shPeYmdseSpSA570gpu
   Vh4BwIZmyrk0FiGfVcNTdne2uEEP+InZw6G2AJ3kqNNULUrR7tKHUR/i3
   Qk68DTupnE4x3rUJBEdGnsMtw3kCfTomSHMqfbv2Yyntcavjm1yr3UcVC
   B0zBmp2qacpNjeji+0UgVIxQ3ov2uc8LqKwq9rOQWUxlyxKBULBnjl+db
   9komvgUS5znd3feCd4bC+pwY6CzUGCtUuZyC9bNh2R5Y28MfX7TV8UZgj
   TQ8YMBQBjA7Y663pdtUBWdq5Sgl/ljh+3pRrPajvWA4v7PfRLf2xvAsC4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="419333136"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="419333136"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 23:18:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="8216555"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 23:18:37 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 23:18:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 23:18:36 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 23:18:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exBWrkZRmFtDoCqh9d2AMwqZvt8qpaX6oWLNcHpk9u+LXtETZwYLVhmpJlkvBrJ3yx3bT4eadWYzwLJalwPib+hN04wYKEJSPdz2Asyu2VjHioERglxUOO4dd/EbWyg9mfg3tgBSMc/aUvfq/HiWCfo75QXH62K/oDmzWDl1Vr1F3Zf5YaxthyhPw+xRUqGles0e3/EYU3Z6IFugkWdwGnZf/IHrLIcWuF+3wcpvoNvYm/HYJCcZ7+k8utvJUYSBF9v7z5dnaOosBHGMRnGpiXaZ00JJp0/cypPaTaN/IofIzEDzvqJfewIDM7iDdGRfE++vn1K9vAu3nGtQwM0OTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKCtm7YuIJFcqKinU6HNdilKE2DyMf6KTDXHmjJdo1M=;
 b=LZnyMnJsx1VSB4xYg8GQE5cMU/BOFkoX1SYlRRb8hR9iHzLXeFp8E2xCsT5AbDli7mcsUtuPrBzfQDVtbRNPMaMw0LHNx22gnNNgr4zjMHtOxB7IoLyW6y0V1ETJwbgDw4BONNUC0ckn3HU1tRns/OBLhKnyE0FAm/5TH8RrV14w1b/oC5NN/XU7z8RANaMOY5G52q5sglTWp/oo29qBHHTo6yo1YrSZxLzCiRmgEJxgleg0qEzH8On2zY46CpEl6oPsfKOH7ICOMHdIfd1IkE72mUrJ+a7qDVNCvRCz/TzO+FJNRR468L4/KFGlZuK/Bun3vP0/pFulK1NM7xKaeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SA1PR11MB8573.namprd11.prod.outlook.com (2603:10b6:806:3ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 06:18:34 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::8c24:7666:7047:d99e]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::8c24:7666:7047:d99e%4]) with mapi id 15.20.6933.024; Tue, 31 Oct 2023
 06:18:34 +0000
Date:   Tue, 31 Oct 2023 14:18:23 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Keisuke Nishimura <keisuke.nishimura@inria.fr>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH v2] sched/fair: Fix the decision for load balance
Message-ID: <ZUCcL28IrCCiLPx2@chenyu5-mobl2.ccr.corp.intel.com>
References: <20231030172945.1505532-1-keisuke.nishimura@inria.fr>
 <ZUCXwmzaoNbRbNpR@chenyu5-mobl2.ccr.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZUCXwmzaoNbRbNpR@chenyu5-mobl2.ccr.corp.intel.com>
X-ClientProxiedBy: KL1PR0401CA0009.apcprd04.prod.outlook.com
 (2603:1096:820:f::14) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SA1PR11MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 181d1857-efdf-46b2-3bce-08dbd9d93662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++nQPQGwpJzuY0Z7hzdBawOhF6TFREPBkEjxS66iTg/q2lMkO8A+KENqNi187m9fPHOK0DvWrVfkpNot5B17D99RrU/eikcbu3fqMTaC+TeUuGBsgxikZ8ebkIYowIdPCOivpyR+ObYugG6EmzVy4mkVSuhGnKvs8e14MElwdVKZrt1P4I3BBG48rowl8BPpYVhvq6B0z/vPbKml2BLrFakxZvNN5BcIg903idqfNimbzdKBJw8vARKsxjvzFWEgdQEjQQbwAH85CL+zGDfmpGlVaICT+4VGTJzPpBowBXYR3QF3Ccw9+s3/DATEd0o8UVg5NLTUWAveBXDuxLYEvOW77WhK/zRzW5ukiF+SGMBxBmUK2M35He8wWxkLsFepqCFnLYPvOMNKbU/UO//wJtH8BJJskvNyoaFjdAlpg2hPmpNJ5qctWYiSzcWm7TJZ/5dQ8oFuQK5xxhWzXOP0EGeRGbfHy6yg3zqnqehasVETaA2vX2zm3BrRewjXnuVQqqQjNwodV27mo8Pt/XpUKaHzKchFyQd08JrXeNMb8r+UafAqamEN42sSRmjgbbxp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(366004)(346002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(478600001)(66946007)(6666004)(6506007)(6486002)(82960400001)(83380400001)(38100700002)(66556008)(4001150100001)(66476007)(86362001)(2906002)(41300700001)(26005)(53546011)(6512007)(54906003)(5660300002)(8676002)(7416002)(6916009)(8936002)(316002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r2mqWEWFihKEvavcZdQUdCdR/aUY6ZKOA5vxpMRMTu8kwNxPf/nb90tK0yH7?=
 =?us-ascii?Q?EX5/cfa/sobbXLJRhlQxeEpBymy3ex1kg9Rh4VNiw0nbgIZhJOk3ObBlAbv0?=
 =?us-ascii?Q?gQ2GjabEbDdB6ZPVjerctmuoaSVFpfQK0bIhbLQpmQ3gdiYSmTh8N/MzlJCc?=
 =?us-ascii?Q?bIdDT4C0h/8B/RECZLOI7BwMz7Fmnt+Np0Rg+OMiSTHETPLaZUv0NR/5Bday?=
 =?us-ascii?Q?s/fk8QNxK1Y2C4CX5HsN4raODpH4mYgyGALA4WJluDz/4C9reN6rzJta5Ncf?=
 =?us-ascii?Q?XW/VRUi2uy0ocIet6kQG09IQxrlb9b0BIHqVPFu04OfvB8A5H3UP9VXWKmXw?=
 =?us-ascii?Q?uhy1tKiM1oMPqOcryLWSpJOGuN542JN58uqBUyCEVWrOMcQ6+UPAGxb+L/3t?=
 =?us-ascii?Q?UD9RYioFjnPFza+2lUYFXcxfpcTJfjuEqJ58B/tbqqdaIP8b6vsyw38c2ZYa?=
 =?us-ascii?Q?cHi4/vRo8Z6kjoFyeykZsZVQegKVQpME+tXiT8gg4iOnNDDOJ8u3oLt0luXv?=
 =?us-ascii?Q?mhGy0i3IFB+puOBa5mX+R54O5M14gZ5gdK2sbrmqur9M7qT5gRU3ZkY2yc5D?=
 =?us-ascii?Q?vWHzI2GaTJHY2BjlRklRf7dsuqrTnd/CSti7gAiKL4YcJOqe74PQS0GW5T19?=
 =?us-ascii?Q?RXz+nGZocTeSdlip83NiSFLX+FmaalzlMirjgr6yAIJ7yOXIzoBnm8kKAsYu?=
 =?us-ascii?Q?COQl+AvG/r+sAKSve/xxe75LcN9xfaLSsaAUKxPnQLYLAfWvN/1xrE8qqmXf?=
 =?us-ascii?Q?eUn9pTyA2CJI2SN8RK4ZM34ef5AbeZXcugG7HdPD7NgR4SXH9eZl39aOUl0R?=
 =?us-ascii?Q?bQNeWljqi0kJ2yP8TlCA+h5uW6inI0QTtDzLLgig8L5PTYUHeq9o8GCiWd6x?=
 =?us-ascii?Q?BkiBsijtmX1g5ejJyZGny6iaYSb1PdyinbR8PMLgYxRR+PB/4OSbGxNWQOgC?=
 =?us-ascii?Q?YJZUGTPpcBST+DmRBYrcEKX+lwKD0QicNUX4Pb+WhO2qTql4DlXlHC485/q3?=
 =?us-ascii?Q?Pemea6ckeOK0+2l8P06z4bQJj8Hp42nWEuMbqkMwCSwanzDkb4cySq27l1Gh?=
 =?us-ascii?Q?QsxSeFz3pcbaWEjF+qxgb/hZ+2zVAJJ53Eji15VJn/1wzkewP7K9F8dlZuux?=
 =?us-ascii?Q?W1rcEheMpUO4hrTOBEZphQtkhuSl0DHp7ZtkiBRkuhAOdGDsBT1njSCupJWT?=
 =?us-ascii?Q?Tw7DY6lG+bTbAW5eXeavUbH8DwKHyG4wTwQkGd7qi6KrvAMXOo2rd3fcDSic?=
 =?us-ascii?Q?Lz+/jZgFUwD4stY88swc8f01BSfeRavfPq6lHpCc3ZTYiaug51+cJPHYqos8?=
 =?us-ascii?Q?wVBhrmRmPCUHkKDFT1fdLLiGOgDd3Bj97gqd5yTkGSQHFw+oykA/YyltFXNy?=
 =?us-ascii?Q?2jvyngaMfSrg1GCTucRKq7ZtHviyxnIVr/ASXIX8+0QTXjpTdfhHt7ZHkSFx?=
 =?us-ascii?Q?oQCgONrn02mz6Gda+15hNe/K2iy2oa0GFH/rvBv7HyzlH8AYdSFH8CoFAJ8J?=
 =?us-ascii?Q?2fqz08nUo12jZcAZGT47uhrLhnOZBhwFhEm+WS/hnC6WzTn0FqwMRkSqh0Fz?=
 =?us-ascii?Q?MBamOL5UVvN33I2K51nwpK1ZJgeWMqF8plMfe6RX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 181d1857-efdf-46b2-3bce-08dbd9d93662
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 06:18:34.7874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ADVgxPVSrO+i16phMx+txucl7IaITlgAeJYGqXYlYrUg69ESjyZfq7/pb7R9jj8Bd1t1zBFTZkDM9MyfFJ/wMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8573
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-31 at 13:59:30 +0800, Chen Yu wrote:
> On 2023-10-30 at 18:29:46 +0100, Keisuke Nishimura wrote:
> > should_we_balance is called for the decision to do load-balancing.
> > When sched ticks invoke this function, only one CPU should return
> > true. However, in the current code, two CPUs can return true. The
> > following situation, where b means busy and i means idle, is an
> > example, because CPU 0 and CPU 2 return true.
> > 
> >         [0, 1] [2, 3]
> >          b  b   i  b
> > 
> > This fix checks if there exists an idle CPU with busy sibling(s)
> > after looking for a CPU on an idle core. If some idle CPUs with busy
> > siblings are found, just the first one should do load-balancing.
> > 
> > Fixes: b1bfeab9b002 ("sched/fair: Consider the idle state of the whole core for load balance")
> > Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
> > ---
> >  kernel/sched/fair.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 2048138ce54b..69d63fae34f4 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -11079,12 +11079,16 @@ static int should_we_balance(struct lb_env *env)
> >  			continue;
> >  		}
> >  
> > -		/* Are we the first idle CPU? */
> > +		/*
> > +		 * Are we the first idle core in a MC or higher domain
> 
> It is possible that the Cluster domain is lower than a MC.
> cluser domain: CPUs share the same L2
> MC domain: CPUs share the same LLC
> 
>  grep . domain*/{name,flags}
> domain0/name:CLS
> domain1/name:MC
> domain2/name:NUMA
> domain0/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING 
> domain1/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING 
> domain2/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SERIALIZE SD_OVERLAP SD_NUMA 
> 
> So, maybe:
> Are we the first idle core in a non-SMT domain or higher,
>

I suppose you can also carry the Reviewed-by tags in V1(Shrikanth and Vincent's)
as there is no code change.

Reviewed-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu
