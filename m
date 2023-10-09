Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3B97BD2BB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 07:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345050AbjJIFO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 01:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjJIFO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 01:14:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86E9A4
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 22:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696828495; x=1728364495;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TQStMqmzdbC9AIHVK/MvJ6jNECmxdNqdvFV2uRjcZwE=;
  b=Gifz7rmDA7uyBztiT/jA5t3M8786kloy5G6CUTLOTPZZgH5cR4ngNPbo
   eeNWGL1cHQjeSnyg0SwDzBO57mIVpRFmy70N+OysPiPh+DC5/vuOSgIC+
   WxjiRCKdyeeEAQp9taj44DG+ucZA+o5vUqCdKBocTdjQShVQBN3ZLZlNi
   D8TVxXuPH8O+FJUzbu+vyagjCR4ChgUCJHiwP7PtZ2R9BaVkq9owTRxCK
   tQMnUd36aFoCjCvT4RueMDOGSYx5RuPXmGes9gQAVIRbHamcXIVLP2xu9
   uI37zyXENzde/5J+gm3B8q3H4wJNkuEnSulVY9pJShuAHfm7A6LAixXFi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="383948841"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="383948841"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 22:14:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="702766488"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="702766488"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2023 22:14:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 22:14:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 22:14:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 8 Oct 2023 22:14:54 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 8 Oct 2023 22:14:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQvNEM1H8WVUYpwnkP2fzVzVEUJl1wP1u437G9p2iqzNVnW3xbPGsWjEVx6gjvcWXq14NlSuNrLjZn4MJKG8QwVdCrlIFATL1dMuj+nv6icQF41ZIUWrBAFcCr4hi4KThYfW0DYMq6TY2CI5BAP3ob7i5jmNWtUypLLTcEfUMEOTjwRyxOsxMxFU1r2J9oOVicF9CFaYPYlipjsduIDsgbvkFWOk9QFVcxzu3rnY/u2e6x95PpFk5Etaurzd/LyxrLuAqnu5FAhA4N1ebeMbgBRXnLNmWVbNgiuecCj6y5iiCLWLAjAdBdqqFDoYv3UBqf2tnw5lU9cFQcbjjDj9+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xc9+s5HFLwc4oLDO60amdgvSmTeZp1VhVM1gp+S6Nw=;
 b=Dkx/5E2Bx6FCHSocjSgMdy6fTkOAq+sIfFAxRp+hme3H3u+0EyWUHN1hGlsaMGZuKPQ2t7khWIGNBixIbXvOAkQZFGWBFbjQPgqjBom6KK2Ct3yFDAVkafB2EuoRNmFYHEptKzXuT1aXXf5BcMm37dllg8dgYhSqdpmmMbtU2ps/6d2wXIhSmyT4ZZFrvTA085ADuiyqFI5H7EsRkYZtli2YrnWzpyCDaov7RjBOukW6T1XW67oGLxyOQmu0+isbCYHe+aWIlLY23DTNIt9pgz/s90wYUaFy+wX2/NTgfRKrL3AwX4iKW6OrXvH63F0BwtPWtLekKlEiMRGoG+1/wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6211.namprd11.prod.outlook.com (2603:10b6:930:25::6)
 by SA3PR11MB7609.namprd11.prod.outlook.com (2603:10b6:806:319::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Mon, 9 Oct
 2023 05:14:51 +0000
Received: from CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::413:a622:bff4:bdd6]) by CY5PR11MB6211.namprd11.prod.outlook.com
 ([fe80::413:a622:bff4:bdd6%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 05:14:51 +0000
Date:   Mon, 9 Oct 2023 13:14:34 +0800
From:   Chen Yu <yu.c.chen@intel.com>
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
        Aaron Lu <aaron.lu@intel.com>, Tim Chen <tim.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>, <x86@kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Bias runqueue selection towards almost
 idle prev CPU
Message-ID: <ZSOMOhhkPIFmvz97@chenyu5-mobl2.ccr.corp.intel.com>
References: <20230929183350.239721-1-mathieu.desnoyers@efficios.com>
 <ZRfKKxBzfu+kf0tM@chenyu5-mobl2.ccr.corp.intel.com>
 <0f3cfff3-0df4-3cb7-95cb-ea378517e13b@efficios.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0f3cfff3-0df4-3cb7-95cb-ea378517e13b@efficios.com>
X-ClientProxiedBy: KU1PR03CA0046.apcprd03.prod.outlook.com
 (2603:1096:802:19::34) To CY5PR11MB6211.namprd11.prod.outlook.com
 (2603:10b6:930:25::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6211:EE_|SA3PR11MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: 07502bf9-8f1b-4b8d-d0aa-08dbc886aa3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: alH5VwXRoAv7/FysiFyvCBysdx3fFeoOXQmltuLbIaHbQ7DPORvwZAx683xAmeFamyCzBvK4F1HsGBouMbLIgwvw2sJ5uHEkICuXDbsGSlnw5AeovgKvFkpdcrW1Ec+ru0VKkfDuF9kxkEDvFzSrwG4OJ1CRcPrASBIZtuNnbj6n8MDAwH3CcJcOHMmMfkFcXdjl+Y2O46L0GDWpk2M2hWcIBahgIvORXDfNEelyUhpLuomK3fhS+k/djKEaAcmCtVU4LQ/NjPoq54USyzW6GUr3OdJE11IUnSWCcg6dBuJ5dqAcq21w3gb4Mp24g4aTnyy0Ld31YMaYnWCCCzjb3uilJJGQOm8k7iRHkjEJZUgBnP7TwdTwIaawndx+XxY7153MH0tJknh5IA0wH4qK2RCEP86f9ntjJ6Ywu5AD04NowEXaIji5OvpTk1tZJdMH3GOKUL/2S8RC9G4Bd4SBu0r1skGJs2LbzEtWPSmYOuUGJF1pSLfw9t6H8k1ioOVGIuN7MDTemJANiXYN/lwodI1eRWdFXjN00DAz74KOML/3FUH+V211s5khMvKdjloJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6211.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(82960400001)(86362001)(38100700002)(6666004)(6506007)(8936002)(7416002)(41300700001)(53546011)(8676002)(5660300002)(6512007)(478600001)(2906002)(6486002)(4326008)(83380400001)(54906003)(6916009)(66476007)(66946007)(66556008)(316002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9xB/TJoIL4NP54SHBXsOr3u6WUKlPXmhV9ryHUZVpznzP9/bFhRBMaInfgjj?=
 =?us-ascii?Q?1AuvUYRFsA0kcdAPLAbBp3HjNeYxsWYDkogkY3Qx23VZ58gUPZR+vyvZQGRl?=
 =?us-ascii?Q?qd/JfsgT+bn0fyMsakNejBhW0/4Thy0Zr+x4OHyYAGITb46zJtuuiy3aMWTq?=
 =?us-ascii?Q?p5gkFgvyO6eWTbuCAUlWCSOmzZy8MPh/3UzIltXUNcoIHxyjQGwx3c4ocWWz?=
 =?us-ascii?Q?LsLQATF0i/zDCuBWxGMRNQxeQ19i8SjFhJFxbsgUudW5bcaDaiAsUtxGqXVR?=
 =?us-ascii?Q?xAJ5mAxE4ZqZhT5VuYfQxrQgvqMJ/LhbKFyNrsRddiHCgKkf/R+BZXz5pm45?=
 =?us-ascii?Q?GyvqnijpGHrEgHnHHMlcvY3uiQ08xGFVQUnueXRT8yYyIinlfG6ec65naLbO?=
 =?us-ascii?Q?liVciLnH73d+uT0fggOiGseb+YY+GtDrIv9wj0zs8dui68+zgpzE9Qd4jZU4?=
 =?us-ascii?Q?DEpg67WntoMMDGYnnW6PLigZ1hik1wvC+iiBmA9g52q0Nfw0bdMVMHy21peD?=
 =?us-ascii?Q?8vE6/pAISEvwE6at8r1V6HaFRwm1gGhBr/+P2//0+4TLeS+8bOJmxNohzGMf?=
 =?us-ascii?Q?61C6h1T/M6cRe/PB0iEZFwidoe84NC/SdID6ABx5lVQSt3Pw3uHe5AkiAZKT?=
 =?us-ascii?Q?nHSS9LUQ8uJphPCtSARG6P0FmMrcJDJsDUHyiEdga8Z2/BtQzWVmijOreGYx?=
 =?us-ascii?Q?dnmQWsuuSFl6MLcowkq6O8Wd8cddTDGtqc08oJapGWUi6cy0fJWQceFy+H6T?=
 =?us-ascii?Q?JZtqN9dcD90J2CzJQ85COp/egQz3lXbr9vINtKJzFK64sW3k3gm9oCl9pIol?=
 =?us-ascii?Q?NDW4d2goDwb1YV0Ln5FAPF2SFZxHlwjJmPXwqSdALshnCRe5fNPIOJP3vuDW?=
 =?us-ascii?Q?q8OW3kNc4o682U+sNab4RsPoJxCEswkietdxf2K4/YO0hspCkCmJ/keOiGiq?=
 =?us-ascii?Q?QCYLoLdRotUO7aAd5N26BhwEiVNRJ9hzJT7pP5kUIesge3uqYxhnRAitzT1t?=
 =?us-ascii?Q?PeMqISdUJP5mAQWW4bbswG/DqlhvINdyddPO/BleoPmAFaYmDcV2MupeXInW?=
 =?us-ascii?Q?kKNNL1MZpxPfi53oDe/xyBA7ImAVcE5QrW0NMgDIGPrLktP24TIRHYYqOWUC?=
 =?us-ascii?Q?GEu18tLBR35zSXxJsQquiJ/EhHe5Z5wzBSjhXi47tGOlYtW6A0O42i9i2jDH?=
 =?us-ascii?Q?kfhQDF3kmbsS9bnW0eZSl9Jdm7YEdRdOlaUhiFfFoQDTo53YmGvthL6rBRyr?=
 =?us-ascii?Q?ccDnKhxEmLkM+9ORbMIQbocxptl0U+gCwNLwM8KolAJkI/IC+FMH3arnamke?=
 =?us-ascii?Q?B7ncII4dBCm7sqQt18KcIUB/JzecQLo9bKQdeJ1fV2KMWoVUGFf2sKmnMC8g?=
 =?us-ascii?Q?ettPoDFuINWubxaPprgoxbnYU6bdqwEzhWPLC3f/wxoADvXKXP2uTlDozdf9?=
 =?us-ascii?Q?Q5pX1O2KEjDMgmb9aDIEwQWyjwo1JdZxqtJwVKPGBlwEyvDHUs0twg6LOfgw?=
 =?us-ascii?Q?vkjKU6ebSdx+XUl+D1jcqLFofH+tOhGOcjW4eHajxx4J40mU7WpMsuFU++T9?=
 =?us-ascii?Q?sRQ15ZvsI8x/cUhcgMZBsVoKnEcLlVm0Deq/TbQX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07502bf9-8f1b-4b8d-d0aa-08dbc886aa3f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6211.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 05:14:51.4933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AS+onfQ5CnUydFBmraM70xM4o17+CmLf/vLhpRACx5Y4dFCPjlfBdKsJvLTTEMrcsGwZvJFCkWMz4YjlrhrBFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7609
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-30 at 07:45:38 -0400, Mathieu Desnoyers wrote:
> On 9/30/23 03:11, Chen Yu wrote:
> > Hi Mathieu,
> > 
> > On 2023-09-29 at 14:33:50 -0400, Mathieu Desnoyers wrote:
> > > Introduce the WAKEUP_BIAS_PREV_IDLE scheduler feature. It biases
> > > select_task_rq towards the previous CPU if it was almost idle
> > > (avg_load <= 0.1%).
> > 
> > Yes, this is a promising direction IMO. One question is that,
> > can cfs_rq->avg.load_avg be used for percentage comparison?
> > If I understand correctly, load_avg reflects that more than
> > 1 tasks could have been running this runqueue, and the
> > load_avg is the direct proportion to the load_weight of that
> > cfs_rq. Besides, LOAD_AVG_MAX seems to not be the max value
> > that load_avg can reach, it is the sum of
> > 1024 * (y + y^1 + y^2 ... )
> > 
> > For example,
> > taskset -c 1 nice -n -20 stress -c 1
> > cat /sys/kernel/debug/sched/debug | grep 'cfs_rq\[1\]' -A 12 | grep "\.load_avg"
> >    .load_avg                      : 88763
> >    .load_avg                      : 1024
> > 
> > 88763 is higher than LOAD_AVG_MAX=47742
> 
> I would have expected the load_avg to be limited to LOAD_AVG_MAX somehow,
> but it appears that it does not happen in practice.
> 
> That being said, if the cutoff is really at 0.1% or 0.2% of the real max,
> does it really matter ?
> 
> > Maybe the util_avg can be used for precentage comparison I suppose?
> [...]
> > Or
> > return cpu_util_without(cpu_rq(cpu), p) * 1000 <= capacity_orig_of(cpu) ?
> 
> Unfortunately using util_avg does not seem to work based on my testing.
> Even at utilization thresholds at 0.1%, 1% and 10%.
> 
> Based on comments in fair.c:
> 
>  * CPU utilization is the sum of running time of runnable tasks plus the
>  * recent utilization of currently non-runnable tasks on that CPU.
> 
> I think we don't want to include currently non-runnable tasks in the
> statistics we use, because we are trying to figure out if the cpu is a
> idle-enough target based on the tasks which are currently running, for the
> purpose of runqueue selection when waking up a task which is considered at
> that point in time a non-runnable task on that cpu, and which is about to
> become runnable again.
>

Although LOAD_AVG_MAX is not the max possible load_avg, we still want to find
a proper threshold to decide if the CPU is almost idle. The LOAD_AVG_MAX
based threshold is modified a little bit:

The theory is, if there is only 1 task on the CPU, and that task has a nice
of 0, the task runs 50 us every 1000 us, then this CPU is regarded as almost
idle.

The load_sum of the task is:
50 * (1 + y + y^2 + ... + y^n)
The corresponding avg_load of the task is approximately
NICE_0_WEIGHT * load_sum / LOAD_AVG_MAX = 50.
So:

/* which is close to LOAD_AVG_MAX/1000 = 47 */
#define ALMOST_IDLE_CPU_LOAD   50

static bool
almost_idle_cpu(int cpu, struct task_struct *p)
{
       if (!sched_feat(WAKEUP_BIAS_PREV_IDLE))
               return false;
       return cpu_load_without(cpu_rq(cpu), p) <= ALMOST_IDLE_CPU_LOAD;
}

Tested this on Intel Xeon Platinum 8360Y, Ice Lake server, 36 core/package,
total 72 core/144 CPUs. Slight improvement is observed in hackbench socket mode:

socket mode:
hackbench -g 16 -f 20 -l 480000 -s 100

Before patch:
Running in process mode with 16 groups using 40 file descriptors each (== 640 tasks)
Each sender will pass 480000 messages of 100 bytes
Time: 81.084

After patch:
Running in process mode with 16 groups using 40 file descriptors each (== 640 tasks)
Each sender will pass 480000 messages of 100 bytes
Time: 78.083


pipe mode:
hackbench -g 16 -f 20 --pipe  -l 480000 -s 100

Before patch:
Running in process mode with 16 groups using 40 file descriptors each (== 640 tasks)
Each sender will pass 480000 messages of 100 bytes
Time: 38.219

After patch:
Running in process mode with 16 groups using 40 file descriptors each (== 640 tasks)
Each sender will pass 480000 messages of 100 bytes
Time: 38.348

It suggests that, if the workload has larger working-set/cache footprint, waking up
the task on its previous CPU could get more benefit.

thanks,
Chenyu
