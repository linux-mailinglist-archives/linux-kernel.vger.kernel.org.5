Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42D675808A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjGRPOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbjGRPOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:14:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D12E171E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689693218; x=1721229218;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MaGwkwhWhkAM196Mhzx39CIMyfZucisjMEQakRv+G8o=;
  b=aTUIhXHt4yFR/J8pNHaoXRcTFH0KMBCvMAOECtCYLfS+5RdqTE6VaTHY
   uxad/VgHwusCbipcekyjSSttngohd1qBwIbz62RIlxNuZYGPlHVMi0bSz
   FepaMQGkqacFU7pO/Xq2c5tSklS3V9b3dxl8a3o5kgJgpI4FPXDRbP8SI
   nQcRN/RK4SabcA4ijShGo1RcD4x+qf/dB+zNeSGwnhzgXXyRDNfP05NYo
   R7RfLPykCIgGPqD8R9wRgyG5V7Tc5aqKkwNxD7+ggzu/ExVPitP3agKF6
   HnQQEzYipXYqD0E+pU4rwBT7yb8dQhyGk556vEmMjiIjrmuGjEzirX0wQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="346532450"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="346532450"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 08:13:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="700945062"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="700945062"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 18 Jul 2023 08:13:36 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 08:13:35 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 08:13:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 08:13:35 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 08:13:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgVRLXRvcTR9mtRYqQRd9+K3BBba3HsYsADveTu7IklLpxdhAb0K2SpCCCI76PnqCQjwLWOEWfdVTdcs/4cffMPRa05tEpKDhrd/NkbpUNaEUyJw+Tdk5Hy7V6gQ98ZJ2KV5T0RDWNPVfcv8O+Xv2nna+NQhpYegLBPAePpcdr1ma6S69Oi0Xr9+WqHpVT8Z0XITRJo33GVBPBGFAjJBkVHc06ahlExSpmtZcyKJBMiZiQfbPymQRghCMXVTjJwrtXEzR+W0z3DE/aLW8/xsN6ov1U5eJYUopIbd4sUQEW6Yo5jV8rP+cXddVbZiGvAGkdoViTctGNLAGMdgYfeF7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJjSrFPPXCoNAWldcxqRvNwN3KfCqtfTsb+V7Y+g/Ig=;
 b=SlY67+1F8PT0cbK3zv5wY4I8Wdxch78U5tL5G/51MRPNi4lXs59bQC/9Pz3ExFW7lyVcW5o/EWSEr3SOk0Q4UZDjpUkeswzcXD62U/l194l3NxpK6wDLpf3dZorcueiL8qanSXxRTNxQ5Wth3QRedqa9iGtjzmIJriB5HO9gSSHVljntMA0aupc6PUh4EMTBnhjlObGBAeTM54pTkAuJzMm7gopUJz/4D8AQ6yg7w8IOPiR86PrQRkL4SYGLCIIBZSJ3rvoT6zA29AhgSOk8UGcLpWbGAe8BzvQG6bbNdUhr+uN3SZnrSbGx2FFjjqdQQrEvXQSwaGoBLM0WH4n5/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ0PR11MB5054.namprd11.prod.outlook.com (2603:10b6:a03:2d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 15:13:33 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 15:13:33 +0000
Date:   Tue, 18 Jul 2023 23:13:12 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Aaron Lu <aaron.lu@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Valentin Schneider" <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Nitin Tekchandani" <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] sched/fair: free allocated memory on error in
 alloc_fair_sched_group()
Message-ID: <ZLasCKO4KA5Pgvdd@chenyu5-mobl2>
References: <20230718134120.81199-1-aaron.lu@intel.com>
 <20230718134120.81199-2-aaron.lu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230718134120.81199-2-aaron.lu@intel.com>
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SJ0PR11MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d0edb74-3555-45c8-0129-08db87a18d57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MROYdPG8I/ODvLJAcBInpftDM6cg+JJBBbBVknDg6L0Yg/Q6w2N5Y9LKeRj/m330ZbiCExGcZagt4al3QGvAe9KXEhWy3J9jrSUA63CwSWIB/rbSN2ahKiYJgwMer51yvJIdPKzQMSp5fr3oNn1onHCirQwBAnweVw3sTAw/+n7ZYglsRdu4vLrhmSyuxYqaP4p2aM1EMR/IyatzhnfdD7aXDpD3RRacbo2HN6yk7N3UqmZWNiAbHdgRYm8UOdXbHTfIRTwAsg3p9TYEISruLyNuaTAw+w2yeburCd4+KdkgFeOk0RJa+CF2Ed7F/xOrnZemaz2qc6zIA5SwnpmpNMJm5533iIIGqic95wTOFOwr8SQG0/OCPp6a3DO6XHZGnj9WFVVn2E5ICbPzIyH93IglHm2wzDk5G6lXCJo2Sc94ohXNXtApSocjKAWoTnVddGsRXvfqmfakG3FRa9P1h/9LNDeOLidocyOxnI0ifY84sXFqEokvWYyzXOVlfqwPz612CeCzV98zshhBo5bBs96hoeRIeJWr7YYXn+RPRY1l9pk3kcZ4YkgF+PGJbGwh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(346002)(396003)(366004)(39860400002)(376002)(451199021)(478600001)(6486002)(6666004)(54906003)(53546011)(186003)(6506007)(6512007)(26005)(9686003)(33716001)(2906002)(4326008)(6636002)(316002)(66946007)(66556008)(41300700001)(7416002)(8676002)(8936002)(5660300002)(6862004)(82960400001)(38100700002)(66476007)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qwes7L/bIhVzfzirFObRWCQFC/Ku4rW7QP82+qaHnLB2trO++0Ff96AGgyul?=
 =?us-ascii?Q?gapvcrjZ8IK1YOxIVd+GTft9prPaT87LBUx3Ejz2z9Q6UFLcIW4s+pxut2l5?=
 =?us-ascii?Q?A9IJ7XSRNg13xRI4zQ8diUZsVw8YSx6ZtpVvFYuM9Yv+ppYiOtz8hhDzaDAw?=
 =?us-ascii?Q?Ur0dOCff6wPd58CE68Tqqjylu+LKZR0M/7BQF4m4CjXsU5sO/9vVfbYDGbyh?=
 =?us-ascii?Q?KbQMREfX43vWzsxaJelD5hY7GPeeEec5Ilh3/7PPzOUH1Hf1BLJ2VTHSBmYO?=
 =?us-ascii?Q?fU6MCDaMwQnaOGXbsdBt9UqA4F3wtcZ3antjLbStEnZcPYdNOuk463MBQqm0?=
 =?us-ascii?Q?3/JSvm/cl0X8UDEX2oXviIJRhx+pG84L5dEhlc7eG0ZqXkkueXY3BSTTE4QR?=
 =?us-ascii?Q?RLHjyArTfLt5+DIhXwfCgYBdFvgCDOIgYu+iXTQpnHS2L/l3w5LkcEjpDtFy?=
 =?us-ascii?Q?XW0MYnlR69/PegvaMvyjKdTKbxvLrqA6YoBaYTxfO2J+0RtWXrvTUAaNVeQk?=
 =?us-ascii?Q?6u+ySi1GiZVmgH/S2k9/wLX07t3feZYRdLNT7ZFGHb3b9uW44jw9+0AGtdTC?=
 =?us-ascii?Q?a9Ja65OlVLinEpkJKetlB6nVMQBgGx7XN7pNknNFutDmwAUXG1XWs0Rb0ntA?=
 =?us-ascii?Q?M0axBuQsu5aW0H16npPPg6NHy6xRzuppCLtfB+oS43/oR/D8eOXh7pXsvWEg?=
 =?us-ascii?Q?NlM4Ya9hFc1URALDprz+u1X2VP3d5Fpc7lYqPolXnvOv8rRIU7Dspak/Sdno?=
 =?us-ascii?Q?ErRwZE0hcTfXoTi/ymUMAovaQEWJ/W9c77RsayHpJFkyncZvdtdEj8zIoFzp?=
 =?us-ascii?Q?ueQmyxBBFv/33Bb5yk5KUto5slB0LEnLNh0uDBxED/+ddh7IqB4Sd8ySUKgt?=
 =?us-ascii?Q?5hg71KpFMt6z6ARlJcRUnNYvyXezs34umFs2qml9qnyjPNgXIvEsDeBQP7dP?=
 =?us-ascii?Q?1kNXBR2kAKfl7pvd3YdXTfAnKKzOCc5p9Q0Ixox/XykTnou2+WBXR+IRwDRX?=
 =?us-ascii?Q?vzr/wdZEXWm/SCnAMHlE8ssrGomaQpvSQ0j/I5n8MAgPzYmUwRHzEGmcNAgG?=
 =?us-ascii?Q?7Uyk0MHJflo0KIK2BHvD+5WhGAvssNeTUXVWggNNG2pPigW3sBU4OHdiJmBP?=
 =?us-ascii?Q?J5rKaQ8lZLA3iAQDKZVfIdbWrB5izJEOywBqY7w2atHyf6bwul/AIOf18P2Y?=
 =?us-ascii?Q?7en8p0T5hYCOZBFLqrGADLRuIhDRzf0mWRjlzbN7/No8TlJ4EmXmErPbqVAV?=
 =?us-ascii?Q?4v3/ANrhNEROiZZSMB7pK6Fi5mlC1VjdM2lOiOaH9GC6cmxgXZkSvD2895Zt?=
 =?us-ascii?Q?RdDuxeX4Oq1SGrZ6n51mTPaj4HOh9xW/MCGfdhWrJs050bO8LnW9KXYD7Zcc?=
 =?us-ascii?Q?p18fZfyUnzyMn8h0IGy+FYOX8LjO477kjuzkTcyQCfpr4qER6oM6qjWeUtV/?=
 =?us-ascii?Q?kHas+S5yuYhNAHUL7Z+jJz/ZnGL8uSuAyOH7oyidx8+eNd10pJpBZCMFdFN2?=
 =?us-ascii?Q?dKAbr4vjJs/MBcFt3vJog1mOFArSuqpUK+7Pt89w6Tg9NC0eoz96Jii7ALiQ?=
 =?us-ascii?Q?RyLm6zrNSnljhzaMxRIQnazLBeKpjNe8xed4HpfI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0edb74-3555-45c8-0129-08db87a18d57
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 15:13:33.5177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SZxcMW6wIMm0yw5NpaB6OCCF6EZ9lQFLMPc7xRek7cWfSxF8C+mWOqPmjIL0dOpUwE2qPORoWjVRqNAzFGkr4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5054
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-18 at 21:41:17 +0800, Aaron Lu wrote:
> There is one struct cfs_rq and one struct se on each cpu for a taskgroup
> and when allocation for tg->cfs_rq[X] failed, the already allocated
> tg->cfs_rq[0]..tg->cfs_rq[X-1] should be freed. The same for tg->se.
> 
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> ---
>  kernel/sched/fair.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a80a73909dc2..0f913487928d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -12443,10 +12443,10 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
>  
>  	tg->cfs_rq = kcalloc(nr_cpu_ids, sizeof(cfs_rq), GFP_KERNEL);
>  	if (!tg->cfs_rq)
> -		goto err;
> +		return 0;
>  	tg->se = kcalloc(nr_cpu_ids, sizeof(se), GFP_KERNEL);
>  	if (!tg->se)
> -		goto err;
> +		goto err_free_rq_pointer;
>  
>  	tg->shares = NICE_0_LOAD;
>  
> @@ -12456,12 +12456,12 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
>  		cfs_rq = kzalloc_node(sizeof(struct cfs_rq),
>  				      GFP_KERNEL, cpu_to_node(i));
>  		if (!cfs_rq)
> -			goto err;
> +			goto err_free;
>  
>  		se = kzalloc_node(sizeof(struct sched_entity_stats),
>  				  GFP_KERNEL, cpu_to_node(i));
>  		if (!se)
> -			goto err_free_rq;
> +			goto err_free;
>  
>  		init_cfs_rq(cfs_rq);
>  		init_tg_cfs_entry(tg, cfs_rq, se, i, parent->se[i]);
> @@ -12470,9 +12470,18 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
>  
>  	return 1;
>  
> -err_free_rq:
> -	kfree(cfs_rq);
> -err:
> +err_free:
> +	for_each_possible_cpu(i) {
> +		kfree(tg->cfs_rq[i]);
> +		kfree(tg->se[i]);
> +
> +		if (!tg->cfs_rq[i] && !tg->se[i])
> +			break;
> +	}
> +	kfree(tg->se);
> +err_free_rq_pointer:
> +	kfree(tg->cfs_rq);
> +
Not sure if I overlooked, if alloc_fair_sched_group() fails in sched_create_group(),
would sched_free_group()->free_fair_sched_group() do the cleanup?

thanks,
Chenyu
