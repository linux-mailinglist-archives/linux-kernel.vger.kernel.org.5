Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D9179101C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 04:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350908AbjIDC1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 22:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350904AbjIDC1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 22:27:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D018310C
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 19:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693794417; x=1725330417;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ILw+oFkbBxAo5rYPD9xRIS4FqyeG4bI9aa7ZuqNqdXM=;
  b=StFOPQcjB5Obfjafgg+fLlCZ1CrzZHfvSuFH+haew9jcoLYrw6XPEdIz
   Pq75lsa0stro695LdNR33DG41aY6joZjeaQw8h/6fDF3NEyHiToaFIm3h
   UGgXhN9ojHKCjs/S7ino3vK+NO4VHoYxueRIAyfDS4vUAfgd2EHxOqQNw
   K95vxkuZpC21X1nN9jksOojntI57/y+nP5QX0H6iJ9leJUchWkej4a56a
   AQbUhoXqVvfkv8ytUEhZRYkkezHHvRp1YkRglS2/xF5YCHewK3Kr+fEeB
   F1EwB/ThfQ+9ux+r0RBqeQO2hdRb0YoAnDibgVJeAVRIuigtMoYTt7SyW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="355998376"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="355998376"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 19:26:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="769828898"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="769828898"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2023 19:26:44 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 3 Sep 2023 19:26:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 3 Sep 2023 19:26:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 3 Sep 2023 19:26:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 3 Sep 2023 19:26:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4HPVai5zC/Ku1Y+VwelQj27g/aNiC9wimGcoUiNeM0UqoBx3isDRbywAKkZW6OshaRvbIPpf3fPqqY6ECPhfamphzBAGWVPXFtK4ohuN+Ho3ywdzd3WD4Vh6b9GkG7V7cu2hKxWNk8C53/ljahyW/slfonjuKEYouWYGhhT675kcGheHdYsv+IHm78z1gcQFgxzMAgmvFAYykbsuEGVxTVZzDPyDFvJPDmzvg+6UxLiX5xsktPP28IIqr8y6IXXKYx4LoO9EEXHFh+QawOr6lhwLPAHbmrqOE+807bbcBouMdZGIJqGmmVBOvxGvrk/MjCEJpTw7GynM9GbZTrtaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySZFOXNa3O8eeleBOs0MHwpboGS2ibnQktHU04p8KZk=;
 b=XdDM1AGSyzS1Pi3e8ZUK8Ut5qS3hBQN9P2+zmXorAUwXaieCqlmn1wL3Jxn2dmUYxMYCTL5K1mgTTKXO1Ye+mOeOPuXsVDd320PkV3YsoNQIoSqWU4R3CDAigoEuI1Z0wIfzIpKmhykRBiFJUSoWk8dbudC5hlfCG4KLNxbbwYS7hGHDPg86fHZHOk/qZIwblYbMh4i+RRsiSXVeZVs11w4lBrPGxDha9lGT078Ig/rl0VTeZu+rklDNyDqbBgONUgpSKKaX512FE6Dv5IEjwdpjLvxj061NmzcvEz54Nd7LAvez/Sxih+Ur7naQxEZqygeOENd0/NtpNHJc0LMPUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 4 Sep
 2023 02:26:41 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 02:26:40 +0000
Date:   Mon, 4 Sep 2023 10:26:20 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <bristot@redhat.com>, <vschneid@redhat.com>, <tglx@linutronix.de>
Subject: Re: [PATCH] sched/smt: fix unbalance sched_smt_present dec/inc
Message-ID: <ZPVATM5xfmiFKWtk@chenyu5-mobl2>
References: <20230902074609.1757507-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230902074609.1757507-1-yangyingliang@huawei.com>
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CH3PR11MB8383:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e8d010c-db51-4f4f-429c-08dbacee5ef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HxggZeWxHiM/fxYyE1o40cxwOoFs6fpcuXOd5cdvzQkxlyD8ZiLD++LON4lpcZme6ZRgYnkJjnmiX7+AP04mDzFAYWNQ99hMKmoE7l38H4v87XwvGEbiaE9II8jUd9F7alP7E4xnPsItuU3uM/uovcc5H4jBDLoUjSMs1TUrKx8duuMjYE/3e+qinlgllO2u9QPUGI33KEvY8++uzs1MkEf060HadE7Xlm5B70cQCXnphDZF+4T4NHWIMYW0bnaogU5A1V7I6kDMKuX2ed++gvMQsQ8S+jZGx9riIjf6Xsyku8MWCymWInb5iH/0IU1vX60Ff8X6SyfqP/db5UlvHFucgRajbLInGHNcNfn0PN/2Z2BPlO5EItBfDsG23T6NJSikYBkjxR2THcO2GTlvf4f39J/8daVMDf4211q6+Mbp7n54i+ntnljYmlOqLcOQZc1sCqo8xIbdE5pOqjU3loANBP2fWAodyUHgCyKjkBALF4TYj3yxM+AQ78abVDWm5ZwvLeYSl/ZaCgnGRdR72n+A/6fk8pW3O9xN3p+XzN0vDgjRd9tFmU2dJwQv+y4P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(366004)(39860400002)(136003)(346002)(186009)(1800799009)(451199024)(41300700001)(7416002)(6666004)(6506007)(6486002)(53546011)(478600001)(33716001)(82960400001)(38100700002)(83380400001)(26005)(6512007)(9686003)(66946007)(2906002)(66556008)(316002)(66476007)(6916009)(86362001)(5660300002)(8936002)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nxF4U1v63gFUy/SPqkuUU2SUv2uVYJuhC/rjwQK2wB1255DmY2lcjH8D+u8Z?=
 =?us-ascii?Q?b9967MUKZuY2r/zjrpOFhLCC/4iA489E9QwyMYoPKmwombY3uqvpvUaFKWZ1?=
 =?us-ascii?Q?CgQMEuzFfD8+b7HQs6ztlgV4Woiz1uVh8kd6sYs3fB2XJ5CB57/CUfGuRtNY?=
 =?us-ascii?Q?1VRpI2vl1bvQMB/JyIr18M1rlSAPYMVg96Jx8iKVB/YzdZXbDFD/JRxas9l/?=
 =?us-ascii?Q?n13aOI306MsWIEmN+tQeH1Y0RqDN1RU0hZ/9clbdzzATinkOznqofjChs4FI?=
 =?us-ascii?Q?uxVWLxh/33z20esae07CUNy0okUPklIsVAiO3rtjcVoTlSsT4ji4dppfR6Uf?=
 =?us-ascii?Q?ZrlJhTklKF8s9chFD84dWgudTwUrRu9DGdS4W1bQLJHj4OdyD1IjpgY9W3cb?=
 =?us-ascii?Q?NbVxEdDXboJIfwIBSEs+V6g9beNCM5q+I/Fj89Ci1ST5/hA/NiBf8vSxHjQx?=
 =?us-ascii?Q?fVaXBbwRb3ymxZqX4SkPgdXpnhsJzhhyIzpAACt6N5nMslOS1qxye39SWswl?=
 =?us-ascii?Q?4a5Ihc3zSeIxDvcDF9Rso67p9Ute92+2JYXrSrxZCL9HA2FpNaxrXl4Le7zr?=
 =?us-ascii?Q?7YtPfW7FEMa/wqpM2cvTUSYT9aq8WoQd2qtIluR6PExivycL6imBsOD4aDXP?=
 =?us-ascii?Q?Kfagi/WRsxyJwXLQvr9M3o8LOzu4yjRL9Y9Dazng7FrY8VeICB/q3T9DFnEI?=
 =?us-ascii?Q?48xPax6BN17TKb3xx++/c7IyKWR8FzLCCdSxTTU4iK3WeAibCMyoPsxgHf1F?=
 =?us-ascii?Q?1OCuF+OHBLCRtVo8EVLIah5dHTltinL7BUi/RKkbxlp6/MMWcu8cZVtwkyKQ?=
 =?us-ascii?Q?v23MaJ/uO164qTJY+ydqdUaf8QaJXTgWZod+kdRAoUm7A1FjnIxsUbtLDJQ+?=
 =?us-ascii?Q?IHu1XAt9lhx4Q/0M/cME5/h8rp6+JooBqOc80rIuVXfYL9WgXKU2C4PBcO00?=
 =?us-ascii?Q?nLpzy4wjRDb6+aFj189sjPGBSiEXM+n4ekqjdU21nI/7UHBYLo48ZFEwySav?=
 =?us-ascii?Q?kxaLymqcrxnIgbgOLfZJc56LA9Zf75cVvaFtzzwA1pkZfnYaDFYVal6knwBz?=
 =?us-ascii?Q?GR/2KlvLRPJVcKqGUW8LHE7vYQH1/6+ayySfi1x4YtsG/OjcI1hshgGTioLe?=
 =?us-ascii?Q?Gb8ujNvrtaaJxKqSyJI1S7F/NbP42Mt88yMT60YGVYj9TmFUo6EjVubIlG3u?=
 =?us-ascii?Q?oXuVcx7Jc+E51wO2iiEZt2astqKpv9aHTsnxsfaeOZc6TERxgoQq0CMnmuZR?=
 =?us-ascii?Q?yR4llSfKh0FcAXxT+P/tcUbFdUwSMI0+0xQWlvh4WlZWTFCzDIZE0+oC1UP8?=
 =?us-ascii?Q?YwfiRGQLkM0tyB8rJdzPeCwQAUD/xWrPa4ou9slnO18/4AhHHQG6zRuGfvzR?=
 =?us-ascii?Q?veWPiRO5UXPHehUBDJ7O0fRJbXkt2CnRB3iOBsUozAFVCiViWP9sto7kIYak?=
 =?us-ascii?Q?mnkQe8iKv96/Dar6qwb2L5vN333yxm3uIr5tkAIurHp4cq19yrLlwqlIS87P?=
 =?us-ascii?Q?D1SWaszUy7GoMB/nTYBGnwRLMDmSDs/j4b/3SVT4wJdeKezAX8b3NVag3yIe?=
 =?us-ascii?Q?yGv5zMIkwXaT+rjcOE9Un/tXfJpQeFQWe5Ptcezn?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e8d010c-db51-4f4f-429c-08dbacee5ef4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 02:26:40.0536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRyZ5EFnGrvEHaEpofnT8Cyc8snL+/G+rkmf75wCnKqlS3p+uBUoss835ST8sgYjBPs70d+oMWYYngxh9bzWNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8383
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

Hi Yingliang,

On 2023-09-02 at 15:46:09 +0800, Yang Yingliang wrote:
> I got the following warn report while doing stress test:
> 

May I know if the test is to run many deadline tasks while offline the CPUs,
so as to trigger the failing case that removing one CPU gets us below the total
allocated bandwidth?

> jump label: negative count!
> WARNING: CPU: 3 PID: 38 at kernel/jump_label.c:263 static_key_slow_try_dec+0x9d/0xb0
> Call Trace:
>  <TASK>
>  __static_key_slow_dec_cpuslocked+0x16/0x70
>  sched_cpu_deactivate+0x26e/0x2a0
>  cpuhp_invoke_callback+0x3ad/0x10d0
>  cpuhp_thread_fun+0x3f5/0x680
>  smpboot_thread_fn+0x56d/0x8d0
>  kthread+0x309/0x400
>  ret_from_fork+0x41/0x70
>  ret_from_fork_asm+0x1b/0x30
>  </TASK>
> 
> Becaus when cpuset_cpu_inactive() fails in sched_cpu_deactivate(),

s/Becaus/Because/

> the cpu offline failed, but sched_smt_present is decreased before
> calling sched_cpu_deactivate, it leads unbalance dec/inc, so fix

s/calling sched_cpu_deactivate/calling cpuset_cpu_inactive() ?

> it by increasing sched_smt_present in the error path.
> 
> Fixes: c5511d03ec09 ("sched/smt: Make sched_smt_present track topology")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  kernel/sched/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2299a5cfbfb9..b7ef2df36b75 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9745,6 +9745,10 @@ int sched_cpu_deactivate(unsigned int cpu)
>  	sched_update_numa(cpu, false);
>  	ret = cpuset_cpu_inactive(cpu);
>  	if (ret) {
> +#ifdef CONFIG_SCHED_SMT
> +		if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
> +			static_branch_inc_cpuslocked(&sched_smt_present);
> +#endif

While checking the code, it seems that the core scheduling also missed
the error path, maybe we should also invoke sched_core_cpu_starting() to
restore the context. I'll have a check.

Other than above typo, it looks good to me,

Reviewed-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu
