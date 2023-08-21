Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067D4782739
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 12:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbjHUKjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 06:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjHUKjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 06:39:19 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5893E1;
        Mon, 21 Aug 2023 03:39:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZWCJCDjcn9b+J7ZUtLIik+g3DkyaRMMNBmJgFGr1cMiYtECtqG6qriLp32+ordY5VQn8czKgWlkgR6h5z7baatqhPzQdh37yFP0XpXPHqvX28Ink0tipw+aS/gIR/N0eaGQMTpYz+bStVIKIEOXXKK2eC58ydtqc3vMF33Mf+RR+iIDyZBBuhX84F2DBsQkfUcZ0es2RJTfWFZteINTPioZnFpQ7TxMZYbxqc1cLlGS0C7e4vyEMn+y5gV82uHxMHrZW5HFaKtReJMIpjO1OAh/9BHsUHRr8PdhzVQOwKZ7GBTbQHZ86SvWh5p2IlDg8lYjJRfBO0OHfQ5z/fTtbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9bmTYZwmyw5w8jOqPcEoTazIN2pBTDp7+wpYmlq3fc=;
 b=ASiyRjKrUUCEOtFaRvhrBQxC3/ayCA7ksr2V/hKe3hJBCnHFUdFdsliBBlAFs04ClUJcvmKD9xKNggiYSYQzG9FT6KQFo/FQnKfsBTDjpC3g1167ybDYjYNfW2QdqmlBT2JGnSUotV6JuOJdlKUsVSO/9i6SzYmxZFutOhifEjbHOQWri/bwRuG/svmlIleRjDp1RSiUMgnMKbR7EZhO//gsbatfmBjWmF4h9q05NczsHyGvb+qKvVhcN1We0vw1d+FccpQ672hJykqEqoU92j6rOayrggXmrKe+oFpZ9/0wLTMKVf0QkiTDgkrJA1LLfmnS0HVhq+rSwzkgxqBHSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9bmTYZwmyw5w8jOqPcEoTazIN2pBTDp7+wpYmlq3fc=;
 b=zKxHptGyZIdTJX+7uy4+LzLEVFTzeysBhWtMXBCvcaY+x9YX3rSI8LR1aYmQwWWh0tgUhKslrcUOaqE12vu52gzMNSC2V0cgWIgAQDZ4HdgX0qBspV7eL3e+h6cnSIUEsbZlymVjOR37OfrvMf5Eshj3jRnFnfxvi03T6erD6a0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by CH2PR12MB4860.namprd12.prod.outlook.com (2603:10b6:610:6c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 10:39:13 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb%6]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 10:39:13 +0000
Message-ID: <21f3d376-17d6-8fb6-5f35-507ea931c0d3@amd.com>
Date:   Mon, 21 Aug 2023 16:09:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [tip: sched/core] sched/eevdf: Curb wakeup-preemption
Content-Language: en-US
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Mike Galbraith <umgwanakikbuti@gmail.com>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        x86@kernel.org, Chen Yu <yu.c.chen@intel.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>
References: <20230816134059.GC982867@hirez.programming.kicks-ass.net>
 <169228500414.27769.13366308319134164264.tip-bot2@tip-bot2>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <169228500414.27769.13366308319134164264.tip-bot2@tip-bot2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0032.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::7) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|CH2PR12MB4860:EE_
X-MS-Office365-Filtering-Correlation-Id: 129bb5ae-9fd5-4c29-890a-08dba232dbcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2NppT6DaoWTnvik//QH/zt8/ohMOr1Dtf5kB4F0GaDmjd+gOPzdtPgvX9fG0nnhY8CdHJwj4L1XAakEoHhpFC6LFsW68+WUvWf7tVks87QH3Og85U2BsVq+cRJ/nqq98b8w65RU+fqx+16vp0/Q4rJHzEq0K4FtT1HomCg+Csq52xevzs115X+wbjEeqkCpXkAnHl2QziUn5p9kzC+6Zs/o5YlmRivlP71GtHQAGfKJ7h0cIqNV/eOjalLm6hmJJKWg+SfuXteUT44PFePkk9ug4+AVsku1WfsOILdfM1/8mObRIIoWbkNLcr6DagQdGInEF/aJyprFOqIFlvNnbTrnEwtcA1K2rbK9w7HhlSi1XZigEBZcXqy4OaAxhs2Lr3eKGZgowAyhLkcLYr8nUpgDandKbwgOYgywCuvomJMamIIbvlX/uOqZRfuwTcu/UWYfwM+Y8a1pTGW/fvu9Jmxgg9xUJT89VFRwtmtlZDXOybJVzjAE/JiQuMEft7gof6zbZQa8vsnRsWY/9ggYx4lBPuX62092KR/K/jqWN7LgCXlgk4sQw781P4rEq+GYPuL/92bUKtxDuPk6Y27s6LlNpV8Pfpk0V1qCLL6zOA3dzBqopPe5TbG7XrYjCa+AL+OkAHQtqJjBeSmPs1VmIQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199024)(186009)(1800799009)(2906002)(30864003)(83380400001)(53546011)(38100700002)(6506007)(6486002)(5660300002)(26005)(86362001)(31686004)(31696002)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(54906003)(6916009)(66556008)(66476007)(966005)(478600001)(6666004)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3gyUThEUE81eW04MHF5RDN5ajVCdEoyeXUraVRBVW44Z3Y4eStydmVuVkQ3?=
 =?utf-8?B?RWR2VjFVcXdOeXhVUFJJZTN5NnJpcks2WkIyTHo4Rm9jRzV5VTZMUTg0NHA3?=
 =?utf-8?B?Y296R2V5WXlFYmlhTHFoSGhyVXpud21ObDlNOXB0MlRrS3BFMER4SmFoK3pl?=
 =?utf-8?B?UUNVK1RhTEwyVU83STFuTnlic1pnakMrZktMem5lNkRMZXFUR0FvQ2hXMXlz?=
 =?utf-8?B?cVpUVTlLWG5CTG9qTkhEbUpUUDRvTTVLWDdHeUkwcWZMYmdRNXpTaU5UOUN3?=
 =?utf-8?B?TUV1cmlMWXFjNFdYdzlYcnpmUlArYk9xWGVUSGEvN3JndWVqVDJrZStVRWZr?=
 =?utf-8?B?a09pa0dUTVpuVGtYN05rL0pXUE4wWWtiUFZQUk8zdWFHVktVZDZpSnRiRHVX?=
 =?utf-8?B?ZCtBaDlGUHZ3MVZyTzJVeGZKTWp4bVRTR0FhcUlEZ1BGQjNQazViSUdMQ09U?=
 =?utf-8?B?UXhjOFAxWWpxN21ONFEzbXJaTCtONkxlY1hzOC9odEp0MHIrakZnd3lJVlNs?=
 =?utf-8?B?cnRlQ2lmcHVMdjU1eTlLdjlPL3U5UUJKak5sVCszd3g4cm1Gb3lSMWtFbkxN?=
 =?utf-8?B?TTV5Q3ArWjdxdHBJbnFvbndyZmZnTnNoSTBhNTEyLzNuNVN2T3lUeXFkSFlL?=
 =?utf-8?B?WS9IOW82cjI3TzdZRnlxZ0Fhai9uNFZNZ2FzblY3RHM2azczQXpIVVdyNlF2?=
 =?utf-8?B?VXN6TFlaSTA1L1dQaXpTQit2WmVjdkhtMk40eEpxZWVtbUxVWGR0aVQxdFRT?=
 =?utf-8?B?WkZqVHdjTlBoeUhKK3dDNjBlZkNnUVFDeEVhYm9Cbm9lS01SekJpQ1lrOUJU?=
 =?utf-8?B?Vk12alIzNThtbmpSMzZVSFEveitNOW9ELzYwU2tQeE1jWWVNSElEUVpFQ01J?=
 =?utf-8?B?bDNmY2JCN2pqWitTWjhmOU4vVnlRS3ZSRGJKRXVnUGpLNFBvdDR3c3NTSm9V?=
 =?utf-8?B?N2ZFYWhpOXJraWFiRzdOMy9WL1NpdFJ6V05TTTNEay9XQ1dsR2JyRkxHZ0NW?=
 =?utf-8?B?anI2cmtaL245TWt6K0pwYmIxYWU4VmtxSVJlR0lobml6YmhPdEMrUm0yaFYy?=
 =?utf-8?B?MU9paUt4eE82bHRhWE5yQlZjRDlUZnU4cmhXY3Jxc1ZqbkFvUFVmdU54WC84?=
 =?utf-8?B?bXNDVGdNRTRjRUNkRnJaRnRuNDdGSlhOQlVTS3VJSVBlUmpncjlha2M0Rm1l?=
 =?utf-8?B?WHhaYTdzaFM1R0cyWEdjd2l5aUJ4NExGT1l1a1N6NTRnOXlpZ3ArR1p1WEgy?=
 =?utf-8?B?OTRsOXUxVFl4bVI2YUdCOGJKRCtlYUJ2TDgzZmFoNGwwM3BjRXJQRkY2QlAr?=
 =?utf-8?B?YW9PcDhBYnJxbG9IcFc0bTE1SlBTT24zNklRN0ZXN3ErVUpzUkU1cFVpSEVZ?=
 =?utf-8?B?NDgrdmxyTTk4RCtFc1BHQStYK1dXS0VnV2lYTHhGdTcxWTIvSUJVeFBxYUg5?=
 =?utf-8?B?dFhSaEF3L1pLZ2JicGFPSnpWdzFpKzZPeDV4TmlWOXFNLytiV1BlbldjRUVU?=
 =?utf-8?B?RkIvNnNOR05CbUVSQ0VtMkp5akdoZS9iQVd1YTlLTkwzVm03ZTV0T1Q0bE85?=
 =?utf-8?B?Rk9obk4weEJSdWR5aGZsWWljMFRrbjVIME5nZHhWQjhPaTl5RmRPMDArRVRy?=
 =?utf-8?B?UWJrRGx1SXl0cmRHVm9jNUZNOTlVRW9ISVR6OTFHRlNaWVBJcU9Hd0h4aFQ0?=
 =?utf-8?B?ekxVdGlpNXNsM2VmRDNobFVBb2dOd0NoeHQxRjY2cXdETllYUVI3RE1qS3pP?=
 =?utf-8?B?WEVNbFJPUi82WXVHTldmMGp6bU9FaGtFVEdzOHUvTEpRL21MdjVrazlJT3VT?=
 =?utf-8?B?a1A0THFyM0tTV044QzFBQ1VnMmRhUzdYTXBBbjM3MUFMdWVPNVRrelpoNGxi?=
 =?utf-8?B?YU15TEt5VnByS3VDYklQLzlSRXpIQXNJN2lSOFpxeFQ2bkk0M2pqZTF1b0Ny?=
 =?utf-8?B?UnI2R0hsSjRHMTR6Y2xBRVI3SmdxdEZUSFlHbUJFOHQwbGN3UzNDWkpxZXFH?=
 =?utf-8?B?ckdwL0VFd3FxTHBUWlloYk1RRVQ3QkM2UUpaY2VVZnNHYkhWUXZhMTQ3eXJO?=
 =?utf-8?B?d3I0QWVXNXprN3ZZdXBxekFQOVhxQ29sUkQ5RmFwbFF1MnZYOFlLMG1LRmlL?=
 =?utf-8?Q?CFojyY2GjePEZYRDu7ZfSGzXi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 129bb5ae-9fd5-4c29-890a-08dba232dbcf
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 10:39:12.7547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qK9SlUGV0z0XmIw/XfY0Ab1YtBQxtPHBcyoHrJi00Nlk+C95kidu12P+RgW6Q26c6Zq+meg0mW42W0Gjp12htA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4860
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

Sorry for being late to the party but couple of benchmarks are unhappy
(very!) with eevdf, even with this optimization. I'll leave the results
of testing on a dual socket 3rd Generation EPYC System (2 x 64C/128T)
running in NPS1 mode below.

tl;dr

- Hackbench with medium load, tbench when overloaded, and DeathStarBench
  are not a fan of EEVDF so far :(

- schbench, when system overloaded, sees great benefit in 99th%ile
  latency, but that is expected since the deadline is fixed to
  (vruntime + base_slice) but base_slice_ns is equal to the legacy
  min_granularity_ns in all cases. Some cases of unixbench see a good
  benefit too.

- Others seem perf neutral.

On 8/17/2023 8:40 PM, tip-bot2 for Peter Zijlstra wrote:
> The following commit has been merged into the sched/core branch of tip:
> 
> Commit-ID:     63304558ba5dcaaff9e052ee43cfdcc7f9c29e85
> Gitweb:        https://git.kernel.org/tip/63304558ba5dcaaff9e052ee43cfdcc7f9c29e85
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Wed, 16 Aug 2023 15:40:59 +02:00
> Committer:     Peter Zijlstra <peterz@infradead.org>
> CommitterDate: Thu, 17 Aug 2023 17:07:07 +02:00
> 
> sched/eevdf: Curb wakeup-preemption
> 
> Mike and others noticed that EEVDF does like to over-schedule quite a
> bit -- which does hurt performance of a number of benchmarks /
> workloads.
> 
> In particular, what seems to cause over-scheduling is that when lag is
> of the same order (or larger) than the request / slice then placement
> will not only cause the task to be placed left of current, but also
> with a smaller deadline than current, which causes immediate
> preemption.
> 
> [ notably, lag bounds are relative to HZ ]
> 
> Mike suggested we stick to picking 'current' for as long as it's
> eligible to run, giving it uninterrupted runtime until it reaches
> parity with the pack.
> 
> Augment Mike's suggestion by only allowing it to exhaust it's initial
> request.
> 
> One random data point:
> 
> echo NO_RUN_TO_PARITY > /debug/sched/features
> perf stat -a -e context-switches --repeat 10 -- perf bench sched messaging -g 20 -t -l 5000
> 
> 	3,723,554        context-switches      ( +-  0.56% )
> 	9.5136 +- 0.0394 seconds time elapsed  ( +-  0.41% )
> 
> echo RUN_TO_PARITY > /debug/sched/features
> perf stat -a -e context-switches --repeat 10 -- perf bench sched messaging -g 20 -t -l 5000
> 
> 	2,556,535        context-switches      ( +-  0.51% )
> 	9.2427 +- 0.0302 seconds time elapsed  ( +-  0.33% )

o System Details

- 3rd Generation EPYC System
- 2 x 64C/128T
- NPS1 mode

o Kernels

base:		tip:sched/core at commit 752182b24bf4 ("Merge tag
		'v6.5-rc2' into sched/core, to pick up fixes")

eevdf:		tip:sched/core at commit c1fc6484e1fb ("sched/rt:
		sysctl_sched_rr_timeslice show default timeslice after
		reset")

eevdf_curb:	tip:sched/core at commit 63304558ba5d ("sched/eevdf:
		Curb wakeup-preemption")

o Benchmark Results

* - Regression
^ - Improvement

==================================================================
Test          : hackbench
Units         : Normalized time in seconds
Interpretation: Lower is better
Statistic     : AMean
==================================================================
Case:          base[pct imp](CV)         eevdf[pct imp](CV)    eevdf-curb[pct imp](CV)
 1-groups     1.00 [ -0.00]( 2.51)     1.02 [ -1.69]( 1.89)     1.03 [ -2.54]( 2.42)
 2-groups     1.00 [ -0.00]( 1.63)     1.05 [ -4.68]( 2.04)     1.04 [ -3.75]( 1.25)  *
 4-groups     1.00 [ -0.00]( 1.80)     1.07 [ -7.47]( 2.38)     1.07 [ -6.81]( 1.68)  *
 8-groups     1.00 [ -0.00]( 1.43)     1.06 [ -6.22]( 1.52)     1.06 [ -6.43]( 1.32)  *
16-groups     1.00 [ -0.00]( 1.04)     1.01 [ -1.27]( 3.44)     1.02 [ -1.55]( 2.58)


==================================================================
Test          : tbench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:   base[pct imp](CV)         eevdf[pct imp](CV)    eevdf-curb[pct imp](CV)
    1     1.00 [  0.00]( 0.49)     1.01 [  0.97]( 0.18)     1.01 [  0.52]( 0.06)
    2     1.00 [  0.00]( 1.94)     1.02 [  2.36]( 0.63)     1.02 [  1.62]( 0.63)
    4     1.00 [  0.00]( 1.07)     1.00 [ -0.19]( 0.86)     1.01 [  0.76]( 1.19)
    8     1.00 [  0.00]( 1.41)     1.02 [  1.69]( 0.22)     1.01 [  1.48]( 0.73)
   16     1.00 [  0.00]( 1.31)     1.04 [  3.72]( 1.99)     1.05 [  4.67]( 1.36)
   32     1.00 [  0.00]( 5.31)     1.04 [  3.53]( 4.29)     1.05 [  4.52]( 2.21)
   64     1.00 [  0.00]( 3.08)     1.12 [ 12.12]( 1.71)     1.10 [ 10.19]( 3.06)
  128     1.00 [  0.00]( 1.54)     1.01 [  1.02]( 0.65)     0.98 [ -2.23]( 0.62)
  256     1.00 [  0.00]( 1.09)     0.95 [ -5.42]( 0.19)     0.92 [ -7.86]( 0.50)  *
  512     1.00 [  0.00]( 0.20)     0.91 [ -9.03]( 0.20)     0.90 [-10.25]( 0.29)  *
 1024     1.00 [  0.00]( 0.22)     0.88 [-12.47]( 0.29)     0.87 [-13.46]( 0.49)  *


==================================================================
Test          : stream-10
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:          base[pct imp](CV)         eevdf[pct imp](CV)    eevdf-curb[pct imp](CV)
 Copy     1.00 [  0.00]( 3.95)     1.00 [  0.03]( 4.32)     1.02 [  2.26]( 2.73)
Scale     1.00 [  0.00]( 8.33)     1.05 [  5.17]( 5.21)     1.05 [  4.80]( 5.48)
  Add     1.00 [  0.00]( 8.15)     1.05 [  4.50]( 6.25)     1.04 [  4.44]( 5.53)
Triad     1.00 [  0.00]( 3.11)     0.93 [ -6.55](10.74)     0.97 [ -2.86]( 7.14)


==================================================================
Test          : stream-100
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:          base[pct imp](CV)         eevdf[pct imp](CV)    eevdf-curb[pct imp](CV)
 Copy     1.00 [  0.00]( 0.95)     1.00 [  0.30]( 0.70)     1.00 [  0.30]( 1.08)
Scale     1.00 [  0.00]( 0.73)     0.97 [ -2.93]( 6.55)     1.00 [  0.15]( 0.82)
  Add     1.00 [  0.00]( 1.69)     0.98 [ -2.19]( 6.53)     1.01 [  0.88]( 1.08)
Triad     1.00 [  0.00]( 7.49)     1.02 [  2.02]( 6.66)     1.05 [  4.88]( 4.56)


==================================================================
Test          : netperf
Units         : Normalized Througput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:        base[pct imp](CV)         eevdf[pct imp](CV)    eevdf-curb[pct imp](CV)
 1-clients     1.00 [  0.00]( 1.07)     1.00 [  0.42]( 0.46)     1.01 [  1.02]( 0.70)
 2-clients     1.00 [  0.00]( 0.78)     1.00 [ -0.26]( 0.38)     1.00 [  0.40]( 0.92)
 4-clients     1.00 [  0.00]( 0.96)     1.01 [  0.77]( 0.72)     1.01 [  1.07]( 0.83)
 8-clients     1.00 [  0.00]( 0.53)     1.00 [ -0.30]( 0.98)     1.00 [  0.15]( 0.82)
16-clients     1.00 [  0.00]( 1.05)     1.00 [  0.22]( 0.70)     1.01 [  0.54]( 1.26)
32-clients     1.00 [  0.00]( 1.29)     1.00 [  0.12]( 0.74)     1.00 [  0.16]( 1.24)
64-clients     1.00 [  0.00]( 2.80)     1.00 [ -0.27]( 2.24)     1.00 [  0.32]( 3.06)
128-clients    1.00 [  0.00]( 1.57)     1.00 [ -0.42]( 1.72)     0.99 [ -0.63]( 1.64)
256-clients    1.00 [  0.00]( 3.85)     1.02 [  2.40]( 4.44)     1.00 [  0.45]( 3.71)
512-clients    1.00 [  0.00](45.83)     1.00 [  0.12](52.42)     0.97 [ -2.75](57.69) 


==================================================================
Test          : schbench (old)
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers: base[pct imp](CV)       eevdf[pct imp](CV)     eevdf-curb[pct imp](CV)
  1     1.00 [ -0.00]( 2.28)     1.00 [ -0.00]( 2.28)     1.00 [ -0.00]( 2.28)
  2     1.00 [ -0.00](11.27)     1.27 [-27.27]( 6.42)     1.14 [-13.64](11.02)  *
  4     1.00 [ -0.00]( 1.95)     1.00 [ -0.00]( 3.77)     0.93 [  6.67]( 4.22)
  8     1.00 [ -0.00]( 4.17)     1.03 [ -2.70](13.83)     0.95 [  5.41]( 1.63)
 16     1.00 [ -0.00]( 4.17)     0.98 [  2.08]( 4.37)     1.04 [ -4.17]( 3.53)
 32     1.00 [ -0.00]( 1.89)     1.00 [ -0.00]( 8.69)     0.96 [  3.70]( 5.14)
 64     1.00 [ -0.00]( 3.66)     1.03 [ -3.31]( 2.30)     1.06 [ -5.96]( 2.56)
128     1.00 [ -0.00]( 5.79)     0.85 [ 14.77](12.12)     0.97 [  3.15]( 6.76)  ^
256     1.00 [ -0.00]( 8.50)     0.15 [ 84.84](26.04)     0.17 [ 83.43]( 8.04)  ^
512     1.00 [ -0.00]( 2.01)     0.28 [ 72.09]( 5.62)     0.28 [ 72.35]( 3.48)  ^


==================================================================
Test          : Unixbench
Units         : Various, Throughput
Interpretation: Higher is better
Statistic     : AMean, Hmean (Specified)
==================================================================

		                        tip		        eevdf                   eevdf-curb
Hmean     unixbench-dhry2reg-1     41333812.04 (   0.00%)    41248390.97 (  -0.21%)    41576959.80 (   0.59%)
Hmean     unixbench-dhry2reg-512 6244993319.97 (   0.00%)  6239969914.15 (  -0.08%)  6223263669.12 (  -0.35%)
Amean     unixbench-syscall-1       2932426.17 (   0.00%)     2968518.27 *  -1.23%*     2923093.63 *   0.32%*
Amean     unixbench-syscall-512     7670057.70 (   0.00%)     7790656.20 *  -1.57%*     8300980.77 *   8.23%*   ^
Hmean     unixbench-pipe-1          2571551.92 (   0.00%)     2535689.01 *  -1.39%*     2472718.52 *  -3.84%*
Hmean     unixbench-pipe-512      366469338.93 (   0.00%)   361385055.25 *  -1.39%*   363215893.62 *  -0.89%*
Hmean     unixbench-spawn-1            4263.51 (   0.00%)        4506.26 *   5.69%*        4520.53 *   6.03%*   ^
Hmean     unixbench-spawn-512         67782.44 (   0.00%)       69380.09 *   2.36%*       69709.04 *   2.84%*
Hmean     unixbench-execl-1            3829.47 (   0.00%)        3824.57 (  -0.13%)        3835.20 (   0.15%)
Hmean     unixbench-execl-512         11929.77 (   0.00%)       12288.64 (   3.01%)       13096.25 *   9.78%*   ^


==================================================================
Test          : ycsb-mongodb
Units         : Throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================

base			303129.00 (var: 0.68%)
eevdf			309589.33 (var: 1.41%)	(+2.13%)
eevdf-curb		303940.00 (var: 1.09%)	(+0.27%)


==================================================================
Test          : DeathStarBench
Units         : %diff of Throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================

	       base	 eevdf	       eevdf_curb
1CCD		0%      -15.15% 	-16.55%
2CCD		0%      -13.80% 	-16.23%
4CCD		0%      -7.50%  	-10.11%
8CCD		0%      -3.42%  	-3.68%

--

I'll go back to profile hackbench, tbench, and DeathStarBench. Will keep
the thread updated of any findings. Let me know if you have any pointers
for the debug. I plan on using Chenyu's schedstats extension unless IBS
or idle-info show some obvious problems - Thank you Chenyu for sharing
the schedstats patch :)

> 
> Suggested-by: Mike Galbraith <umgwanakikbuti@gmail.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20230816134059.GC982867@hirez.programming.kicks-ass.net
> ---
>  kernel/sched/fair.c     | 12 ++++++++++++
>  kernel/sched/features.h |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f496cef..0b7445c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -873,6 +873,13 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
>  	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
>  		curr = NULL;
>  
> +	/*
> +	 * Once selected, run a task until it either becomes non-eligible or
> +	 * until it gets a new slice. See the HACK in set_next_entity().
> +	 */
> +	if (sched_feat(RUN_TO_PARITY) && curr && curr->vlag == curr->deadline)
> +		return curr;
> +
>  	while (node) {
>  		struct sched_entity *se = __node_2_se(node);
>  
> @@ -5167,6 +5174,11 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  		update_stats_wait_end_fair(cfs_rq, se);
>  		__dequeue_entity(cfs_rq, se);
>  		update_load_avg(cfs_rq, se, UPDATE_TG);
> +		/*
> +		 * HACK, stash a copy of deadline at the point of pick in vlag,
> +		 * which isn't used until dequeue.
> +		 */
> +		se->vlag = se->deadline;
>  	}
>  
>  	update_stats_curr_start(cfs_rq, se);
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index 61bcbf5..f770168 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -6,6 +6,7 @@
>   */
>  SCHED_FEAT(PLACE_LAG, true)
>  SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
> +SCHED_FEAT(RUN_TO_PARITY, true)
>  
>  /*
>   * Prefer to schedule the task we woke last (assuming it failed


--
Thanks and Regards,
Prateek
