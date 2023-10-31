Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5E77DC640
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 07:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235413AbjJaGHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 02:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbjJaGHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 02:07:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EDDC0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 23:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698732418; x=1730268418;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iA/dsWjoNxVW71e6mU9dM9nPA3kbfDYVkSXyxVxmEFc=;
  b=HqbpgyTnqMwyjv660XKk7NGyiMpdIdcDllEUmxiOU/JVbEF+/+YgWu3w
   92+KSWJNRttT91I6YC3WczhqJTay5VDrR5HOmPGgT3UsrhEIdmSnOU6Ab
   fAJhp4lw1Eak5N7kn6aBroyjcoD/qjsxf9t1cIlh692inqt/B/FPNAvt1
   dbXRatCmwlt+hO6l2HhiUXcDMN/tqV4vmUJ31GF5+O01LxSoftuEEzwNn
   nQM6d7Qbv1z2Ct6vy3XhZH3oXEtCrGBE2ykLaYRpeQHc1mGzEAKV2Y2r3
   Hm6CQOy5GKk2VT2EfDmyKA/S4eOJbx4yfWI0QUI1Td7kXXgXmOuzcD4P1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="452494197"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="452494197"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 23:00:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="1007671222"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="1007671222"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 23:00:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 23:00:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 23:00:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 23:00:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 22:59:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYP85259sxs/4Q3aMje/duzJqkPHa24Yjy/DPKdAcA8X095I8jOzGOhMBVrXgq2FPG9Z08JTsGmmaIcxlKZoPykkdjJIXEAWdzcrGQBjOjd5TbwOzGG6FJ8377UrV2NtZRulRk/PRq1Vt3Af5nlM780n26TEjV5n5r26cuBEKAHGExJss73aShXfSzLSuupBEcX7c6mijUH5ktaMhCCc8dyWMRnFmMoCAJIvrRNR894PsW0VT8vLC1IyknraUYyh//EF2zh7l+gli+xMxXZA1FoCHVs4F0ceUqh5lgaRFabHgjECFE4i/71ZRp6XiwitJCMH/6vVI4JVZ/AiLRe9dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlGTT/4Ay2qpZjzvR5r7Z0QxdhExl83OtNCQI9J0bgw=;
 b=CIOCJ8wa493Q7hMS1Ju7IWiLmWHFOVeXpBDF4UVji45mAzhFbbZUEJahiAb2Va6MNNU0+VbK3Zf9BWtJvz3QQO5wKVpKJ2FDtvhAocYdQPBOFjk/YFaBTQ+2SvSw2dTWQFkul9K0RwsKItyODy2NfHo7nGyIwh+d8Xkv+4nXkHGUCAlL1OHjPpDKy8Npg8guZe+oCblRtJXCDZNRYDLT57FPTXina7E/7qRKcbjPM9QbLJdxmlZ2uPII7RSNLns9n8gihXuDhreSvSa/umMYfGjzen6N70UB6Kj41OjNYnCKszzbLNd6HXO4ISm8nrREV5hPWhJWvvxSgowo7IIVDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CY8PR11MB7687.namprd11.prod.outlook.com (2603:10b6:930:74::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 05:59:43 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::8c24:7666:7047:d99e]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::8c24:7666:7047:d99e%4]) with mapi id 15.20.6933.024; Tue, 31 Oct 2023
 05:59:42 +0000
Date:   Tue, 31 Oct 2023 13:59:30 +0800
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
Message-ID: <ZUCXwmzaoNbRbNpR@chenyu5-mobl2.ccr.corp.intel.com>
References: <20231030172945.1505532-1-keisuke.nishimura@inria.fr>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231030172945.1505532-1-keisuke.nishimura@inria.fr>
X-ClientProxiedBy: SI2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:194::9) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CY8PR11MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a84238-860a-4490-4243-08dbd9d69388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRmf942fdKAU8DQ/It8VR2+dWwFMqk/7otFg4juulLpgrmOjx6zvaYoN+RGSbLLETyLp2HB8HArEzBGg4Own9QUax273THsgUvdqxFRTBnFrp9upBqcgm6sKRt8DBEWyeQ89oLyuTsu8qJ3ojXEWijxvA8C43WiHN0G3aGTBw1IFQCtlxBnyJvveldiBVL8Jsr8eI6VFpJpagjNIHLQGoj1W/52zeg/6GqqNFAkwbjvag2/f8/wgQ9qRL8oy/KodSm7F3hjUgCbXnGgLKDOyyID719+8qbctcHWtaEYLILZ+Gg8I/n251IIJtW6xaZ7Whehx5GQJ5IyFKIOdjLaLOF9JKdoIy9pfVQnpkLcv0O0LsoNaV4OZo8nLhmYPrJOjrPKbLIqL60GZEElubSvDuLUd+BbNGhHbhNAqqqu6TqZe6rnX50xRfkJpIjLhdmkQeL0J4wgezQUNsYetFuyi1GXI+2I7kVOQq8CjTQs3ZsIM025fPH++df7ZZg3RLosXu8WPtS7zy9YEAGSSWywA6zvaSymVrHJWfC3qxeqrKlp6X2kbnJAcv6X9zpINlLDH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(136003)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6512007)(26005)(4001150100001)(38100700002)(86362001)(82960400001)(316002)(83380400001)(2906002)(6486002)(7416002)(478600001)(6506007)(53546011)(6666004)(4326008)(6916009)(8676002)(8936002)(54906003)(66476007)(66556008)(5660300002)(41300700001)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RVfwN3a71ZVV8spgwbU+AhTP0wetZRzhI8uvfuJSy1q2+sejG2Qsd9jw+CF5?=
 =?us-ascii?Q?4E0bLSQWMv8ktosMjkO6mnb5VEUO2yp4vb4J5RDVCYQzXF4c1tPQPvqmaSBc?=
 =?us-ascii?Q?vAFsopBtjcqU1y332FbGEDqPqRVUyy9YlcFtX4G+6SWtYTOBz35oxFw8F2u2?=
 =?us-ascii?Q?m/ln/uq3L4C54RcfiytIZ7Yh2F5Q1HwKZq+kgMh6iWvRb8ieBEYhQNloBbLL?=
 =?us-ascii?Q?Udkn2ePMAPcHXEjZyPUiBjc2+CoQekL7YTJ19Zq+2sg/NA/Fvl2xwxjfggNI?=
 =?us-ascii?Q?eP7xVhD/0qrRG465EO5xc/MhDSsS/iCw4yqUeHVQus1CTgqYEemWMoNe8j1W?=
 =?us-ascii?Q?BxaZDoonPeg8swlMu61rq1YlQO1dxlyxaUYOQZ/C+s34E8ktnsBwaWX0n72l?=
 =?us-ascii?Q?MmpqbXY9OB2cT0S5iCvTTTutd7wH1Mw8PBn6aLKz4ylyAwyCHqnsTRjnuwsK?=
 =?us-ascii?Q?RJTrHx2h0GbS3S55ZbyGMSf3ADVkKAysyFSbFFeXNlAkFURNFMURZ6ITTeEz?=
 =?us-ascii?Q?05kPaHQdJzoi/onS3Q9jiFdbOKOGvGl9/AqP7/zcNz9O/w7BIUFlzLIo3r7q?=
 =?us-ascii?Q?TQIh/qiUHPdCtwpxoHRfsDUcfYUZo23syYr2tGxClPR/AwKJIao+WferI14P?=
 =?us-ascii?Q?UfJhG2BhoJnofFS9jBz8OT1NLKPpX/fv2AiGsIK4JP/zj6Ecf9lUIFqx7M05?=
 =?us-ascii?Q?v2cF7Kg6cbsdblSxeKx/D/k50Pfm/LG0WFNZudWDNoo5n0FU7dMbQ8h11sNY?=
 =?us-ascii?Q?FXA+SvHLk0yViqngQGpFBLFVs6p32rrPhYnwg77jHxMw4yRaJ3Rgug+2QFFY?=
 =?us-ascii?Q?YkS+MBNsjqBJu1+A92TtRBgb8Vw/l4maUObimHkSeGJZDKmjFgW1xKBo7Mt7?=
 =?us-ascii?Q?aQhoc6ZMfb836nmGW0pm5bOzIPexScGKTduPrcfL/mvPbN2iMAh62rIdmOzW?=
 =?us-ascii?Q?yEA2StRL4wrJ9FEG6e9Cb3QeAuCbUu3vc+Gi7FDOAJa/ho/DNenhsZ5g7sa9?=
 =?us-ascii?Q?CLcz3w+lxxDsEgNwPXdhfYKf58pJ4/gRIFY0dAK3lelRYTxVYU92qRo9pqVw?=
 =?us-ascii?Q?FJa97hIMMKdrxPVQXs38b18OL8QzJwvuo4Xu7WR+JK7nk9oWcW0IWUkCNbv9?=
 =?us-ascii?Q?6YpQXbtV5SEyFq8glyEAlNJYn8XzElBUfBztrEXpLMXKUNsfSfO1PdkHY1DX?=
 =?us-ascii?Q?8cbHd36L96VrHd0F6sz4DpPXauMZFl+jOd2FgAaE37koj3qdPtDzip6cmqnB?=
 =?us-ascii?Q?y00v8fBqsCiI4tD+GTh+693nsCkNA69IdzLzZswPS7tupd8or4b2fYYt2AEb?=
 =?us-ascii?Q?EWHhvL3pRXk47sics7QROH4FHxOnZo9WnbNFQ5fXOEkYxumORmseIAnppQSW?=
 =?us-ascii?Q?/AY/eiU9/AsEJSA7+jNWvqJ8+jWYs1BGU+ClAjlar0qrUXBm8buZabwJvCvb?=
 =?us-ascii?Q?LMIvOirQiICC6AloL4YqO87EPo/ljVOvuT7Bxd4GldQxfGUM78NCnUAdCFq5?=
 =?us-ascii?Q?wqygAQK8cmkskEIV9fBEm14kPw6HO/UiKSxXJsAxWfhInSU1KqlGSHJYjK2G?=
 =?us-ascii?Q?E5YtqGEjv89LhIH1UW32GivFj6U7vMgsMkcsCzWK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a84238-860a-4490-4243-08dbd9d69388
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 05:59:42.6085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qt6dMtFVcR6tHEkVNfO1oE7ntzK68op0Dmr38Uf9ZUR4tv678LitlzRJzFRmtl04U7JkPM9iFL1pZ9RPzB7d6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7687
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-30 at 18:29:46 +0100, Keisuke Nishimura wrote:
> should_we_balance is called for the decision to do load-balancing.
> When sched ticks invoke this function, only one CPU should return
> true. However, in the current code, two CPUs can return true. The
> following situation, where b means busy and i means idle, is an
> example, because CPU 0 and CPU 2 return true.
> 
>         [0, 1] [2, 3]
>          b  b   i  b
> 
> This fix checks if there exists an idle CPU with busy sibling(s)
> after looking for a CPU on an idle core. If some idle CPUs with busy
> siblings are found, just the first one should do load-balancing.
> 
> Fixes: b1bfeab9b002 ("sched/fair: Consider the idle state of the whole core for load balance")
> Signed-off-by: Keisuke Nishimura <keisuke.nishimura@inria.fr>
> ---
>  kernel/sched/fair.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 2048138ce54b..69d63fae34f4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11079,12 +11079,16 @@ static int should_we_balance(struct lb_env *env)
>  			continue;
>  		}
>  
> -		/* Are we the first idle CPU? */
> +		/*
> +		 * Are we the first idle core in a MC or higher domain

It is possible that the Cluster domain is lower than a MC.
cluser domain: CPUs share the same L2
MC domain: CPUs share the same LLC

 grep . domain*/{name,flags}
domain0/name:CLS
domain1/name:MC
domain2/name:NUMA
domain0/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING 
domain1/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING 
domain2/flags:SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SERIALIZE SD_OVERLAP SD_NUMA 

So, maybe:
Are we the first idle core in a non-SMT domain or higher,

thanks,
Chenyu

> +		 * or the first idle CPU in a SMT domain?
> +		 */
>  		return cpu == env->dst_cpu;
>  	}
>  
> -	if (idle_smt == env->dst_cpu)
> -		return true;
> +	/* Are we the first idle CPU with busy siblings? */
> +	if (idle_smt != -1)
> +		return idle_smt == env->dst_cpu;
>  
>  	/* Are we the first CPU of this group ? */
>  	return group_balance_cpu(sg) == env->dst_cpu;
> -- 
> 2.34.1
> 
