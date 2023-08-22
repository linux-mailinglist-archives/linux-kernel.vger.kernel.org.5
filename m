Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE067783B49
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjHVH6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233673AbjHVH6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:58:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C9BCF1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692691101; x=1724227101;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jQ96+wXBG45jOISvIOpx3EoNxU4Owg/uOYng4MurLnM=;
  b=fGUpC4JkXHyJYYhAiR1F9wXT9iiLfyonKUM7SaVYDS0L3HhbTH73PNwX
   Q3kigF1uE/Hivu61BW26Us/UnNHMbS4sRhBlONdRGyraxwNwv0QDntoMq
   CnvGLzAgzomMeFK1fl6ErGwRD5jvG1ZTqG4mC9lZmF6w4Z+hL9iuOOVHa
   xjZwPpFSwuFaa99aUZuwIWyusJmLCry76xd3WfsNggIwtRTlZLO2WTUmO
   L1ReKApj2Qt0ZmR7bqOqJ9089pUltxsIn9u/LBs3u/DQFrXc/PrRlCQQ1
   PPygjvhEv/4E1oOFiecDQwDapZfN5deyPJwYz8Px36AdQjK6I6SerhnE3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="358803773"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="358803773"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 00:58:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="736115552"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="736115552"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 22 Aug 2023 00:58:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 00:58:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 22 Aug 2023 00:58:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 22 Aug 2023 00:58:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7bybaXOjnM5yuRthsQ+3QJyck0RmlmsA/elrogjxh3JGM+ho5s4hfeT+WaZugBThjxg9jF3YMt1OCes4cpU4eQ82yBN9ComwnuHdp5Ak6aBAv1yFd1IsHvo6zKpcI4gPE8EZOuITis0e8EwYWhNgMEjEF9njqQiPWh1l7tGkbmemt3Hp9FBMhZ2Of+UiOb2Ynh7mNdLPRg5LcsS5InX8y/DcSHHs64LbePNMh7gCzVbaU++NdwwwQ1Gjzrs6Xoa4TFT5q+qwXe8hFM1TNvazKKe6NTWQrmJmeKK6uXfa3hyrVssHgfW7Jta7NbF2NHjWqnYzU1IqiXBFjTPswqkuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NLhRk3PhK0LhDrZukwlWqWZiyqemmkvjaqI/vqH7UE=;
 b=DScSCzB1xnK6k+ZLSLxuydrQdiaK+DbHyWV/lJbR1EUJ9olfhNUXPc+emGKUMo9r3SsjcNtdYfrrVdace0ZYBNViOOtfUfNjPQgBueykagMW/8/m40G5EmjC1n2OZJDOWInj/keuSAuS/Lj58G7lyWQOb9LKyVvtFlgt4FV5qwxGS6s/plGghXCWWlB6nx8878GrLQ0YtvGHjjPiJ3kyzxXLFXzMdbZWywX+khdRIyASo4MY9MD+xp9ZwdD3V/u4ojwt1kLRuSkrVD5lU9lCGdPbQTtWcqQmjA2k71Wck0KadXRFo+K5XhMJzsBJXNKJ3/rn51rCy1O7Dfm5UUcqhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by MN0PR11MB6112.namprd11.prod.outlook.com (2603:10b6:208:3cc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 07:58:17 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9a8d:9d34:4af2:f2e5]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9a8d:9d34:4af2:f2e5%7]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 07:58:16 +0000
Date:   Tue, 22 Aug 2023 15:58:01 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "Mel Gorman" <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        "Julien Desfossez" <jdesfossez@digitalocean.com>, <x86@kernel.org>
Subject: Re: [RFC PATCH v2 2/3] sched: Introduce cpus_share_l2c
Message-ID: <20230822075801.GA76894@ziqianlu-dell>
References: <20230818153027.202017-2-mathieu.desnoyers@efficios.com>
 <20230819123155.275094-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230819123155.275094-1-mathieu.desnoyers@efficios.com>
X-ClientProxiedBy: SGBP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::23)
 To BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|MN0PR11MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: 35d7da7b-81a5-4e57-5103-08dba2e589c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TOvy73q7XGa9f1pntW7crph9qiVy/EUXnI+ypE5e6e10YlSM5n1dy0rz5OBe9xRJzb/HdgYLcpFTzbyY3pk5fjSG9uWqqErpdLcAqEcmNN1XYbKFifbW978LgJAg2MoqeGqb0JfLJ0d5Zik1WsPbOGG1RDbmAtA9DmnqjOGgRFx2JS6n8atKomZMgtaLh35T+16hUJpPwuvUskqc7zQQrEezq9KapJFQezLTGMQWNXqPhdYeZ8cezVRBZJ4eMJzerXvq2Wx8lWfrQeyJ+D0TDFKnzmvMRY9sDn0CHMKCCctL/Zb7EfuK+BYkHXAKAknR6LC2fINhN7fKdHOt6l7uM5YZ62c8c2eAuCAtpzhAtS58UT50gU5fZCAhPCkcKlRRi2TmCkLTaSBstkKHRle+/tOgsGS7fb2Bfq8PuYtt/ytklw/FRJOwHNQEZGMMU79ZoOQj+8+rER/Z8FGO2Ma3Fnvb3xRWc47yuQ7i2p7ncreuy9l74FSLb3yMJL7pjQ46wx+Ri+QZsWXo2b5AaxKseUE165pjH0J16eeMwyNlU3wXRcG0/YNwHVKY+zWNG+/j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(39860400002)(346002)(376002)(366004)(1800799009)(186009)(451199024)(54906003)(6916009)(66476007)(66556008)(316002)(66946007)(6512007)(9686003)(82960400001)(8676002)(8936002)(4326008)(33716001)(41300700001)(1076003)(478600001)(6666004)(38100700002)(6506007)(6486002)(83380400001)(2906002)(7416002)(86362001)(44832011)(5660300002)(33656002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DZospE63kgybCv+gGAIjzeCfcN5bGC76L1jyYckCR4GgIwj6sHjnWY/LV8Z3?=
 =?us-ascii?Q?HxVFDpXAGhkCjjxfUh77t+E8caAjHaxQv4YSjY1AQa7UkIWzEn1PywE9CaQF?=
 =?us-ascii?Q?vNKgugli7lR7LRTTHhAoroBmOOhSoqVVkMgVSMyc3icX0R2r9udVeBADfx8w?=
 =?us-ascii?Q?w9u9bRS0UfZkW2DyRcxb4G1c23q9RGHfHZvzPmED3xgveUahmqYvDAvHX38U?=
 =?us-ascii?Q?unpC7c7wxDAwN9ZGCRG4occPRxFCztebbvIEEquzs4duqkUUS05YMuZ8Et8k?=
 =?us-ascii?Q?uEwfZKgMa7D/tJRRl6bRXuYAtd5N3NBnKUB2AGhP2BrDPzh3DJ9RsHEmsTFa?=
 =?us-ascii?Q?Eb6keK1VF7hrdPeRESQU1l/8EznMgADhaZU+WzOHlycmajFn+ZqXdIbrwTI7?=
 =?us-ascii?Q?VVXv7UCRa0AfGEsdiwWV5I2afDjN7mH6sYmScm4vXl3UoDeHQAr1v/tQePvP?=
 =?us-ascii?Q?aKdSnDwAO78HKcDZ6q4yFtP3o80FqVPCWnUs953nLzqDLxFgBf82YR0gHsMS?=
 =?us-ascii?Q?3ETIEtjdn2JXLjvihyKknYKXgoL6UHazidr4T++BpXNj+4D7/FeAQ6sbv6Ve?=
 =?us-ascii?Q?V7pCmgwPv86RnnS3ftaA+GikVZhd+5CTwNg1gQLnmljpqR6Vs/WomBmBFyeg?=
 =?us-ascii?Q?vQXtViBquuWvzUZHZ/KBudksgIzGqq2aV/z/PBQDQCs9gVvTlGNinapdzwLm?=
 =?us-ascii?Q?KP6cJ/yuhBd6VLj0dSxGELJlRMDxoQ4CwVdwskl2xdeC43LARXImHQjP09hq?=
 =?us-ascii?Q?pODf/IH68OpkvBSfInFGeQOKavFy3AhE9RQKsWoeW3pCsCT4ppm/ZLvsmkiW?=
 =?us-ascii?Q?s5OXfMdfNW/c1YLsRii+BrDg+N5nQM88KYDjX3mqIRrdcKsiC3KnlU2xU684?=
 =?us-ascii?Q?PAIpu/ylt4tkugwQj2WmBEdQP1IGh+5DaMZKCN98Rr1qFPy1YzUlwnmLYxyz?=
 =?us-ascii?Q?/F3dC54DnhjXblj6slkyXHsVlINfs5PARBolH+N6is33qhquFYjCmDF2eOvt?=
 =?us-ascii?Q?bWShSPHFFG/GmTcDuPgXw3UoPY/RGtKPX75SPTWQ2mrCohbcVAMwU5s1U9R0?=
 =?us-ascii?Q?C6FcocDTlptbgVj7DUyHatE9xgKqPcbEELdCCPSsCEAWG6+oFwiFntVU/tK5?=
 =?us-ascii?Q?7Jh0xkp3BK/JJbF+3LGcb2cfGCQkvJk0S73+FPS3bs4iiJhv6+nfw+o+0cn8?=
 =?us-ascii?Q?BdAgmL7FoCD/e5DyigWrGeFr6Id51D0gBQMt4TJW3oJIkiiI6YqwaO2GUWFs?=
 =?us-ascii?Q?b3ZJdRKElZ/fEzNMSZEJUY5VUsNVM0kZm4T9ExE/ikIFpvHDHg7HCxp+9H2u?=
 =?us-ascii?Q?TDaEeMh+s3rwVHKoqi2R7s7yn0bdjM2LYRagmTtpx2bKjZKhhxkY85UBG7Eq?=
 =?us-ascii?Q?m2g4RtVhRHu8z1YrhgKUT2g/GOaDImDCjkAs45VXWTxnx9rm6Cqm97TmpNEs?=
 =?us-ascii?Q?JAmsR5H16/eRSr5jlUKheUQJ8WQqD5gIrCfITin0iBxJ/f2bdkgOuoiiQXgL?=
 =?us-ascii?Q?hfMAUW1HqY80JuOAPJqIg6YDnSf/62xf+7TlDpt88X+VBRSilX2F8jTQwQAX?=
 =?us-ascii?Q?BApU9URisYs72yNcRd41HrfbP3nJ2jEWRxFf8Zk9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d7da7b-81a5-4e57-5103-08dba2e589c4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 07:58:16.1964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FGg01pTlhPzuh8lDZqr3eVT6GdwxlJvXYqDYuG/OWH3QUEteI2ZYk4KokFGOKxBADwBBG4CKjcIfm+XmVNzgGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6112
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 08:31:55AM -0400, Mathieu Desnoyers wrote:
> +#ifdef TOPOLOGY_CLUSTER_SYSFS
> +static int cpu_get_l2c_info(int cpu, int *l2c_size, int *l2c_id)
> +{
> +	const struct cpumask *cluster_mask = topology_cluster_cpumask(cpu);
> +
> +	*l2c_size = cpumask_weight(cluster_mask);
> +	*l2c_id = cpumask_first(cluster_mask);
> +	return 0;
> +}
> +#else
> +static int cpu_get_l2c_info(int cpu, int *l2c_size, int *l2c_id)
> +{
> +	return -1;
> +}
> +#endif
> +
>  static void update_top_cache_domain(int cpu)
>  {
>  	struct sched_domain_shared *sds = NULL;
>  	struct sched_domain *sd;
> -	int id = cpu;
> -	int size = 1;
> +	int id = cpu, size = 1, l2c_id, l2c_size;
>  
>  	sd = highest_flag_domain(cpu, SD_SHARE_PKG_RESOURCES);
>  	if (sd) {
> @@ -686,6 +704,14 @@ static void update_top_cache_domain(int cpu)
>  		sds = sd->shared;
>  	}
>  
> +	if (cpu_get_l2c_info(cpu, &l2c_id, &l2c_size)) {

Should be:  cpu_get_l2c_info(cpu, &l2c_size, &l2c_id)

> +		/* Fallback on using LLC. */
> +		l2c_size = size;
> +		l2c_id = id;
> +	}
> +	per_cpu(sd_l2c_size, cpu) = l2c_size;
> +	per_cpu(sd_l2c_id, cpu) = l2c_id;
> +
>  	rcu_assign_pointer(per_cpu(sd_llc, cpu), sd);
>  	per_cpu(sd_llc_size, cpu) = size;
>  	per_cpu(sd_llc_id, cpu) = id;
> -- 
> 2.39.2
> 
