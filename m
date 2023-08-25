Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0772788021
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242293AbjHYGmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242594AbjHYGmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:42:15 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A35210D;
        Thu, 24 Aug 2023 23:41:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DirXVBjSBu7d36G+4TLHFwMwnjoDeua4dIRxzfm4ztR2SzbRJUocvXnVlcLyEnlYIF16aW+LCpQMAFMp+UifoqQLMobqc1TQvgV+R4ygh65j7lUnogXu2b15sivRgoEshMQfrxpp0q2FVKPTxInrN2nnxViOqV/2oAab0eFgI7lek9m1X/eIEJVERK+8/4LV7l/XAgErIyR0IdGNKqi+5VsVLecXZxE9cPAKc2+rjfheG4bQRnLFjLteA7oy1pyrEM4Z1nksy6Y+YADAIqeP6BCkDWyN0qxYuVuG+9NtzSuIATOz5r/Ud11cYHtM9bEpB9bqdEc91rX/EQkCMEKSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTJxoBjWU+1lMlDGQx7cJIW2YBTB+7vP61+FLGq6XNY=;
 b=cQLVnO39udDMGY3p1uBb9h9MotSPRMdJ6brtPtJQ/ZXn18X+9ZFsRBuNzUj6AoeI0fB0Kj4dd3AOg26xG+IBri5MwCpRjN7A0OeecFfolfXp3I3AOh6AvgnIOhNMTj9iulSizSqaug3bH7TIY6A7V86aUAf0eMfILwAmvU76Xyc6ahXNiNTlLd2oU6KIutSKzzazIuvJ83aZWOsmtzcQjC4zTuf+ptPa2RpZlxz/le5OnUg6HpZjARSnrUxcJwqtZGgTbIudZllLAAQhW8rgV+nKWjpVeFP0EH/NdAext5ck4CKgmI1T/ddBnu5lb6eZ45rx5z6OGDRiL0uOioVjeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTJxoBjWU+1lMlDGQx7cJIW2YBTB+7vP61+FLGq6XNY=;
 b=cMeayewk8fQH7b4MKH7gOYIk8Yokngtoco/9vtjs739eGyTsu+/iokpjttFhSLLTuam5ddv13WWUwAMu/vDB3eocZl1+eDlG0iC0PzuVlniewHGjyKIuSCnAPrJfqq0HSecPyf98wWEJyG+p6ZfNpYhfEQcM0UvM2b0LdkvsgQ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by BY5PR12MB4967.namprd12.prod.outlook.com (2603:10b6:a03:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 06:41:48 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb%6]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 06:41:47 +0000
Message-ID: <a32c0054-46eb-cce8-7eab-c6f11b6d533d@amd.com>
Date:   Fri, 25 Aug 2023 12:11:34 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [tip: sched/core] sched/eevdf: Curb wakeup-preemption
Content-Language: en-US
To:     Mike Galbraith <efault@gmx.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        x86@kernel.org, Chen Yu <yu.c.chen@intel.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Swapnil Sapkal <swapnil.sapkal@amd.com>
References: <20230816134059.GC982867@hirez.programming.kicks-ass.net>
 <169228500414.27769.13366308319134164264.tip-bot2@tip-bot2>
 <21f3d376-17d6-8fb6-5f35-507ea931c0d3@amd.com>
 <02f6a15f094adb3c8d9957b031941d6bd10c2e43.camel@gmx.de>
 <f0859f35-39ec-e5dc-b77a-79162516de31@amd.com>
 <0e153dd25900af70f91e4a73f960320e6daf3c6a.camel@gmx.de>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <0e153dd25900af70f91e4a73f960320e6daf3c6a.camel@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0142.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::27) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|BY5PR12MB4967:EE_
X-MS-Office365-Filtering-Correlation-Id: ac5a95a1-1e8a-4918-5ea8-08dba5365ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8sf9T8XRl5AwGr1075M6JZeOkBsg+SWRJVdavK2HP3CseUVvQJFIIkUrCVSzMmMfq87VGOWMnKnb51BFOnYx8QJBp+7Ii95DUW180mm2sfpq7nZyz+WA2YdNspQhn7b8DFjCX+79KvXdG/0aAc+6bOUdz+u9vHF0Nr58t7JIUYKd7OYEJL1qrCVPFMRAt74Z49DWa9qvVYS27hbHFVi/n5Ey5hrM8o+4Jvf+iLMGiZ2u3zPY332gbbmAAyZnL6LqmZb771PS9klij/0EGKrT3Y9hY4OOu40vXfT1djiKdRBirkSTZ6NgOmDwVBYDJlrjRAJh9UoA8zrhGxFmvfOpWXJUOfDNR+JDI6vhPKHNEDyfbeKGJFLL4bpOCNR1HfclUgLz8reepnheRUJiDhA/bYaMlI+Ki8iYs9h3uOwqPZ7t+3unEWKhwT2eaaF2eSNxAITxeRfMZ41qR3bvhkuPNkMRD9M6H8buI6M9bEaews1DoJ/T3kRLBszo1KLj/MkCij+OJGANadYYKt0JHSIDp1+o8kAV9h5hyKmZUs79KJWmdU66ekEPvtgoYK7pbmILhkzRA7LwDo9gZ9gCdMhyhb1ZskRkAqCEq8Qn7D36P/T+PEY4BC9fd/+zkqTJ0BE+2J+jyYYtKYeElZVFy6iyGU+zp4n8qi0krGzyI+XFTVA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(39860400002)(366004)(1800799009)(451199024)(186009)(83380400001)(6512007)(26005)(478600001)(2616005)(5660300002)(30864003)(31686004)(2906002)(8936002)(4326008)(8676002)(38100700002)(66476007)(66556008)(110136005)(66946007)(86362001)(41300700001)(31696002)(54906003)(6506007)(53546011)(6486002)(36756003)(316002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDNWVnhudVlYL05sN0dFeDM2MG9LR3RLN3BSUzR4cDdWRUQ0Q1Jmb0p1b3di?=
 =?utf-8?B?MUxldmluY2FyNDdzQ09JK1JOeERXTXJWY1FjS1lsT0laY3dPUTBZNzZzUHBX?=
 =?utf-8?B?Y3cvQXlXUkxLdmwxSWU2RVltbEJLbHVqb2pham10SjhLY1BnZmhwaUs2RFJi?=
 =?utf-8?B?VWxkb2FUL1BDM1pkcGhwL0IzdDNOaWRWbExoNkZscnVGekFrRGlHZjY4dExo?=
 =?utf-8?B?Z2RJRnpNN1ZDZUxjLzJJcExnNGpSS3RjV05pVjZydGEyd2tORkpvMnBsRWh6?=
 =?utf-8?B?ZXdxZXc2VFlKcFBEeTdNOVUrbk1JcUFZdlQzcmdFR2svR1dCaWdtNEp6RDcy?=
 =?utf-8?B?UTB2aCs0WndHVjFYdVhYYi9HVWY5WDkwcWk5Y0FBSnpDcjQrRHRsY1ZIQzdQ?=
 =?utf-8?B?a0U0YUVHTXBlejdUcGZhSzhvZG9rcmVmb2RpVUZJQjVsNkFqWWwzNFBWN1hN?=
 =?utf-8?B?bUFIRWVDbHdMTXUwNGthdVVqclh4SFRHOU5TYnZibWNyc2dJZkwxQ04yQmxv?=
 =?utf-8?B?ZjZwcVVINTlJOXBRUUNLU0MyRWs5UFV6Szd2R3YrejEwZDRPcUZrK0JaMXdo?=
 =?utf-8?B?cUtIaGxnUW5YRXNkSEJpeWIrSTE5MElqRjBpR3c3NktkL3JaMU1adkQwQUJ2?=
 =?utf-8?B?aGFETEczc0JEUUo1RUk3bGIrOHlnWjdtRDFuS1p6VEpWV1JjdEl3Q3d3ZXpn?=
 =?utf-8?B?ek96L3NHQlVYUlV3WTJ1QUlKTXVXQmo3ZXRGbDBTSzhXVkZEQmVpc1V6Y2V2?=
 =?utf-8?B?VW96WTFkcWFINHdkSit4cU9UQllnbFp2NDNDRzdvQ0hBM2VFb3dJMCtNdmJ1?=
 =?utf-8?B?Tmt6RnAvVXUvODdzdTZ1cmVlUTd0WGNRdWFDNFZGN2tIbndsNVdYSWZ6UGUw?=
 =?utf-8?B?bXV4emthbzVnRG1kTlQ4dkc4YWFsYjU5K0d5WXNZam9LdDFjRnozNjh2amFV?=
 =?utf-8?B?Q3hBNjczai82QXhVMDVpYzdyNEdPZjdvR0d0dktTd3l2NzdUaDRiT2ZLZlVy?=
 =?utf-8?B?eUtvdld4ZXBPS2NDZ1BkamNiNFk3VUxMNC8vc0hzNzVMejF5MjJEckFxOGFl?=
 =?utf-8?B?NzBxNFI5RVF2dHc1YVB3Z0M3cEsraUo4TEc4Vm85Nlk4UkhHOGRmMWpSZWZh?=
 =?utf-8?B?QmZHR2dqZHhxVnd4RkFkZkVLK1NwU3BrS2kySFN0d2lJVStkWjRPaHdBUXIx?=
 =?utf-8?B?alRnMTRhY3NYd1lVYkdkZGxSa0dSWVdqVENZcG1MVXpTajRGR2FUbldOWURF?=
 =?utf-8?B?YmRuWDd1YTF2VldMN0trd2hXTjU1UlFhT0FpRUtDc2pzbFd2and4aDQ5VkRs?=
 =?utf-8?B?bmR2dDh5RGVUSC9acjZOeHM2eVArcStHZmJPb3NOUWNOVHJ1ZkxwRXlXYnBo?=
 =?utf-8?B?eFRCOTJ4c0wxVVpPeTN3L2R6Rm53cFo0bGF0RzRQd1N2OXk4Yzg1eVpocE1Z?=
 =?utf-8?B?TTNRQUZDNE9uNlE2VnUxdklZTUd4ODRNeVVCLzVzVHNJSGVmTXBJWWU4dUdq?=
 =?utf-8?B?NDhUWE9mR3l6Y1Nhajk2emtBZ2lJTW5CZWJjRFVlaWh0SGJTTnVPa2xKbE8z?=
 =?utf-8?B?SUZ2bXFtNHRvWXBpbWxBdmNCdi94eFhFUWhkdUxiQWtMUlpqblpCcTBiSXlK?=
 =?utf-8?B?NXM5WTViMmIxcWt6SitDU0JvdmJreFM2VlJmaWEwV3lINHNkL0xFQVJjcU1n?=
 =?utf-8?B?ZitjSDVUV29DRTEzZjExRGZRS0ZidTIyYzdmTWJnd2hvbk1jMVRkbGJBVzgw?=
 =?utf-8?B?emtzcUF6blpPRE5lckxUaHZjZmVsc1J1ellxZk91Y3dXWnhRbTVPSWNjenA0?=
 =?utf-8?B?aFVobXpDc09xMTIxQzBxZ1hBdVdyZVdZbmUwblFudFZPQmFvdUFHdTNPWU1F?=
 =?utf-8?B?RkpXdjY1TzdYZ0dHa1I3TjJZc2hEYmFYL3NUcWJHKzdwYmRHRFR2Tnd6NzlT?=
 =?utf-8?B?NjRORHFPQk5BeGZ0S3NzU2VIYjhXVUJJUmtmclYvVTFnaXg1V3pkVzlPS09I?=
 =?utf-8?B?Y3dSblFER1I0VmoyK29pVzQ2RFpTVWw5QThpRVVwVXZsNXBvV0NONW5BZis3?=
 =?utf-8?B?MnNIUFJ3c3hMT2xRd2hhdW1pVzQ0T0NWRmdEVytmYTdWRDE2cy9EZzl5STYw?=
 =?utf-8?Q?U0jdcySWvnWxRkp9qEXHMwpIz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5a95a1-1e8a-4918-5ea8-08dba5365ae0
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 06:41:47.8719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ea/Bk9NZrDoGAVrQRjAmQEW+jSsTXK4H50aNdxBgqIZ2e6lwJ5qfe9434nlYKPqbDtF/Ynwk0LFSC5jOWg6CsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4967
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

On 8/22/2023 11:39 AM, Mike Galbraith wrote:
> Methinks these shards are due to tbench simply being one of those
> things that happens to like the CFS notion of short term fairness a bit
> better than the EEVDF notion, ie are inevitable fallout tied to the
> very thing that makes EEVDF service less spiky that CFS, and thus will
> be difficult to sweep up.

Ah! That is pretty sad for some of these benchmarks that are not a
fan of large number of context-switches. I went back and tried some
solutions floating in the community (thank you Mathieu and Aaron)

> 
> Too bad I didn't save Peter's test hack to make EEVDF use the same
> notion of fair (not a keeper) as I think that would likely prove it.

More benchmarking with Mathieu's [1] and Aaron's [2] proposed changes
on top of EEVDF + Curb Wakeup-Preemption:

tl;dr

- Hackbench is now happy with Mathieu's and Aaron's patches (I'm not
  looking with CFS baseline for now since Swapnil and Gautham are
  testing those)

- Some unixbench variants are pretty happy in overloaded system.

- schbench is pretty happy throughout.

- tbench and DeathStarBench are still pretty unhappy. Most likely
  because of greater number of context switches but I'll get more
  concrete evidence for this.

- Other micro-benchmarks tested are more or less perf neutral to EEVDF.

o System Details

- 3rd Generation EPYC System
- 2 x 64C/128T
- NPS1 mode

o Kernels

base (updated):			tip:sched/core at commit 88c56cfeaec4 ("sched/fair: Block nohz tick_stop when cfs bandwidth in use")
eevdf:				tip:sched/core at commit c1fc6484e1fb ("sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset")
eevdf_curb:			tip:sched/core at commit 63304558ba5d ("sched/eevdf:Curb wakeup-preemption")
eevdf-curb+mathieu:		eevdf + cheery-pick commit e242aa146918 ("sched/eevdf: Curb wakeup-preemption") + Mathieu's patches [1]
eevdf-curb+mathieu+aaron	eevdf-curb+mathieu + Aaron's patch [2]

[References]

[1] "sched: Skip queued wakeups only when L2 is shared"
    (https://lore.kernel.org/all/20230822113133.643238-1-mathieu.desnoyers@efficios.com/)
[2] "Reduce cost of accessing tg->load_avg"
    (https://lore.kernel.org/lkml/20230823060832.454842-1-aaron.lu@intel.com/)

o Benchmark Results

* - Interesting Regression
^ - Interesting Improvement

==================================================================
Test          : hackbench
Units         : Normalized time in seconds
Interpretation: Lower is better
Statistic     : AMean
==================================================================
Case:          base[pct imp](CV)         eevdf[pct imp](CV)    eevdf-curb[pct imp](CV)  eevdf-curb+mathieu[pct imp](CV)    eevdf-curb+mathieu+aaron[pct imp](CV)
 1-groups     1.00 [ -0.00]( 2.64)     1.02 [ -1.98]( 1.89)     1.03 [ -2.83]( 2.42)     0.95 [  5.10]( 2.65)     		0.94 [  5.67]( 2.07)  ^
 2-groups     1.00 [ -0.00]( 2.97)     1.05 [ -5.18]( 2.04)     1.04 [ -4.24]( 1.25)     0.98 [  1.88]( 1.99)     		0.96 [  3.76]( 2.64)  ^
 4-groups     1.00 [ -0.00]( 1.84)     1.06 [ -6.07]( 2.38)     1.05 [ -5.42]( 1.68)     1.00 [  0.43]( 1.50)     		0.99 [  0.65]( 0.97)
 8-groups     1.00 [ -0.00]( 1.24)     1.07 [ -7.09]( 1.52)     1.07 [ -7.29]( 1.32)     0.91 [  9.11]( 1.63)     		0.93 [  7.49]( 2.43)  ^
16-groups     1.00 [ -0.00]( 3.31)     1.05 [ -4.98]( 3.44)     1.05 [ -5.27]( 2.58)     0.74 [ 26.35]( 1.22)     		0.69 [ 31.04]( 1.90)  ^


==================================================================
Test          : tbench
Units         : Normalized throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:  base[pct imp](CV)         eevdf[pct imp](CV)    eevdf-curb[pct imp](CV)    eevdf-curb+mathieu[pct imp](CV)    eevdf-curb+mathieu+aaron[pct imp](CV)
    1     1.00 [  0.00]( 1.08)     1.00 [  0.42]( 0.18)     1.00 [ -0.03]( 0.06)     	0.99 [ -0.57]( 0.27)     		0.99 [ -0.51]( 0.97)
    2     1.00 [  0.00]( 0.69)     1.00 [ -0.09]( 0.63)     0.99 [ -0.81]( 0.63)     	1.00 [ -0.15]( 0.74)     		0.99 [ -0.76]( 0.76)
    4     1.00 [  0.00]( 0.70)     0.99 [ -1.20]( 0.86)     1.00 [ -0.26]( 1.19)     	0.99 [ -1.08]( 1.03)     		0.99 [ -1.43]( 0.84)
    8     1.00 [  0.00]( 0.85)     1.01 [  0.56]( 0.22)     1.00 [  0.35]( 0.73)     	1.00 [ -0.32]( 0.53)     		1.00 [ -0.22]( 1.45)
   16     1.00 [  0.00]( 2.18)     0.98 [ -1.82]( 1.99)     0.99 [ -0.92]( 1.36)     	0.99 [ -1.19]( 1.54)     		0.97 [ -3.33]( 1.44)
   32     1.00 [  0.00]( 3.84)     0.99 [ -0.88]( 4.29)     1.00 [  0.06]( 2.21)     	0.98 [ -1.92]( 3.60)     		0.96 [ -4.36]( 2.45)
   64     1.00 [  0.00]( 7.06)     1.03 [  3.45]( 1.71)     1.02 [  1.68]( 3.06)     	1.03 [  2.60]( 3.37)     		1.01 [  0.57]( 3.97)
  128     1.00 [  0.00]( 0.88)     1.02 [  1.54]( 0.65)     0.98 [ -1.74]( 0.62)     	0.98 [ -1.63]( 1.85)     		0.97 [ -3.33]( 1.83)
  256     1.00 [  0.00]( 0.88)     0.94 [ -5.67]( 0.19)     0.92 [ -8.10]( 0.50)     	0.95 [ -4.94]( 0.21)     		0.91 [ -8.74]( 1.55)  *
  512     1.00 [  0.00]( 0.07)     0.91 [ -9.17]( 0.20)     0.90 [-10.39]( 0.29)     	0.92 [ -8.37]( 1.51)     		0.90 [ -9.73]( 0.05)  *
 1024     1.00 [  0.00]( 0.30)     0.87 [-12.66]( 0.29)     0.86 [-13.64]( 0.49)     	0.86 [-14.47]( 0.35)     		0.87 [-13.44]( 0.26)  *


==================================================================
Test          : stream-10
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:       base[pct imp](CV)       eevdf[pct imp](CV)     eevdf-curb[pct imp](CV)    eevdf-curb+mathieu[pct imp](CV)    eevdf-curb+mathieu+aaron[pct imp](CV)
 Copy     1.00 [  0.00]( 8.87)     1.03 [  2.94]( 4.32)     1.05 [  5.23]( 2.73)     	    0.96 [ -3.92]( 7.61)     		0.97 [ -3.28]( 5.93)
Scale     1.00 [  0.00]( 6.80)     1.01 [  1.38]( 5.21)     1.01 [  1.03]( 5.48)     	    1.03 [  2.98]( 1.04)     		0.99 [ -1.24]( 7.22)
  Add     1.00 [  0.00]( 7.24)     1.01 [  1.45]( 6.25)     1.01 [  1.39]( 5.53)     	    1.02 [  1.51]( 2.51)     		0.98 [ -2.02]( 6.99)
Triad     1.00 [  0.00]( 5.00)     0.96 [ -3.63](10.74)     1.00 [  0.18]( 7.14)     	    0.99 [ -0.78]( 5.21)     		1.00 [  0.45]( 2.91)


==================================================================
Test          : stream-100
Units         : Normalized Bandwidth, MB/s
Interpretation: Higher is better
Statistic     : HMean
==================================================================
Test:      base[pct imp](CV)         eevdf[pct imp](CV)    eevdf-curb[pct imp](CV)    eevdf-curb+mathieu[pct imp](CV)    eevdf-curb+mathieu+aaron[pct imp](CV)
 Copy     1.00 [  0.00]( 0.45)     1.00 [ -0.27]( 0.70)     1.00 [ -0.27]( 1.08)     	   1.00 [ -0.48]( 1.44)     		0.98 [ -2.02]( 4.84)
Scale     1.00 [  0.00]( 4.40)     0.98 [ -1.86]( 6.55)     1.01 [  1.25]( 0.82)     	   0.99 [ -0.85]( 4.98)     		1.01 [  1.10]( 1.07)
  Add     1.00 [  0.00]( 4.97)     0.99 [ -0.91]( 6.53)     1.02 [  2.20]( 1.08)     	   1.00 [  0.26]( 4.90)     		1.00 [  0.11]( 2.37)
Triad     1.00 [  0.00]( 0.24)     0.95 [ -4.85]( 6.66)     0.98 [ -2.19]( 4.56)     	   0.97 [ -2.80]( 5.56)     		0.98 [ -1.58]( 2.15)


==================================================================
Test          : netperf
Units         : Normalized Througput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Clients:         base[pct imp](CV)       eevdf[pct imp](CV)     eevdf-curb[pct imp](CV)    eevdf-curb+mathieu[pct imp](CV)    eevdf-curb+mathieu+aaron[pct imp](CV)
 1-clients     1.00 [  0.00]( 0.46)     0.99 [ -1.26]( 0.46)     0.99 [ -0.67]( 0.70)     	1.00 [ -0.13]( 0.30)     	      0.99 [ -1.46]( 0.37)
 2-clients     1.00 [  0.00]( 0.75)     0.99 [ -0.87]( 0.38)     1.00 [ -0.21]( 0.92)     	1.00 [  0.13]( 0.32)     	      0.99 [ -1.47]( 1.05)
 4-clients     1.00 [  0.00]( 0.84)     1.00 [ -0.45]( 0.72)     1.00 [ -0.14]( 0.83)     	1.00 [ -0.10]( 0.60)     	      0.99 [ -0.70]( 0.78)
 8-clients     1.00 [  0.00]( 0.78)     0.99 [ -1.07]( 0.98)     0.99 [ -0.63]( 0.82)     	1.00 [ -0.49]( 0.85)     	      0.99 [ -0.83]( 0.81)
16-clients     1.00 [  0.00]( 2.56)     1.00 [ -0.29]( 0.70)     1.00 [  0.03]( 1.26)     	1.00 [  0.17]( 0.66)     	      1.00 [ -0.43]( 0.80)
32-clients     1.00 [  0.00]( 1.03)     0.99 [ -0.76]( 0.74)     0.99 [ -0.73]( 1.24)     	1.00 [ -0.49]( 1.45)     	      0.99 [ -1.29]( 1.88)
64-clients     1.00 [  0.00]( 2.69)     0.98 [ -1.96]( 2.24)     0.99 [ -1.39]( 3.06)     	0.98 [ -1.78]( 3.00)     	      0.98 [ -2.31]( 3.00)
128-clients    1.00 [  0.00]( 1.91)     1.00 [ -0.43]( 1.72)     0.99 [ -0.64]( 1.64)     	0.97 [ -2.72]( 1.34)     	      1.00 [ -0.49]( 1.83)
256-clients    1.00 [  0.00]( 2.21)     1.02 [  2.23]( 4.44)     1.00 [  0.29]( 3.71)     	1.01 [  1.49]( 3.72)     	      1.02 [  2.17]( 2.50)
512-clients    1.00 [  0.00](45.18)     1.00 [  0.10](52.42)     0.97 [ -2.76](57.69)     	0.99 [ -1.14](49.76)     	      0.99 [ -0.58](50.33)


==================================================================
Test          : schbench (old)
Units         : Normalized 99th percentile latency in us
Interpretation: Lower is better
Statistic     : Median
==================================================================
#workers:        base[pct imp](CV)        eevdf[pct imp](CV)     eevdf-curb[pct imp](CV)    eevdf-curb+mathieu[pct imp](CV)    eevdf-curb+mathieu+aaron[pct imp](CV)
  1     	1.00 [ -0.00](12.03)     1.09 [ -8.70]( 2.28)     1.09 [ -8.70]( 2.28)     	0.96 [  4.35](17.83)     		1.13 [-13.04]( 5.95)
  2     	1.00 [ -0.00]( 9.36)     1.08 [ -7.69]( 6.42)     0.96 [  3.85](11.02)     	1.00 [ -0.00]( 2.19)     		0.92 [  7.69]( 0.00)
  4     	1.00 [ -0.00]( 1.95)     1.00 [ -0.00]( 3.77)     0.93 [  6.67]( 4.22)     	1.03 [ -3.33]( 3.81)     		0.93 [  6.67]( 5.52)
  8     	1.00 [ -0.00]( 9.01)     1.03 [ -2.70](13.83)     0.95 [  5.41]( 1.63)     	1.08 [ -8.11]( 2.94)     		1.05 [ -5.41]( 3.01)
 16     	1.00 [ -0.00]( 3.08)     0.94 [  6.00]( 4.37)     1.00 [ -0.00]( 3.53)     	1.06 [ -6.00]( 1.10)     		0.98 [  2.00]( 5.51)
 32     	1.00 [ -0.00]( 0.75)     1.05 [ -5.19]( 8.69)     1.01 [ -1.30]( 5.14)     	1.01 [ -1.30]( 5.14)     		0.95 [  5.19]( 5.36)
 64     	1.00 [ -0.00]( 2.15)     0.96 [  4.29]( 2.30)     0.98 [  1.84]( 2.56)     	0.93 [  7.36](14.38)     		0.90 [  9.82](15.50)
128     	1.00 [ -0.00]( 5.18)     1.01 [ -0.57](12.12)     1.14 [-14.29]( 6.76)     	1.09 [ -9.43]( 8.88)     		1.04 [ -4.29]( 4.46)
256     	1.00 [ -0.00]( 4.18)     0.16 [ 83.86](26.04)     0.18 [ 82.36]( 8.04)     	0.16 [ 83.69](21.07)     		0.19 [ 81.29]( 2.30)  ^
512     	1.00 [ -0.00]( 2.10)     0.29 [ 70.52]( 5.62)     0.29 [ 70.80]( 3.48)     	0.30 [ 70.45]( 1.73)     		0.30 [ 70.17]( 5.31)  ^


==================================================================
Test          : Unixbench
Units         : Various, Throughput
Interpretation: Higher is better
Statistic     : AMean, Hmean (Specified)
==================================================================
		                                base		        eevdf                   eevdf_curb              eevdf-curb+mathieu              eevdf-curb+mathieu+aaron
Hmean     unixbench-dhry2reg-1            41407024.82 (   0.00%)    41248390.97 (  -0.38%)     41576959.80 (   0.41%)     41641988.85 (   0.57%)          40989184.46 (  -1.01%)
Hmean     unixbench-dhry2reg-512        6249629291.88 (   0.00%)  6239969914.15 (  -0.15%)   6223263669.12 (  -0.42%)   6258072789.83 (   0.14%)        6243186854.90 (  -0.10%)
Amean     unixbench-syscall-1              2922580.63 (   0.00%)     2968518.27 *  -1.57%*      2923093.63 (  -0.02%)      2887947.73 *   1.19%*           2921456.17 (   0.04%)
Amean     unixbench-syscall-512            7606400.73 (   0.00%)     7790656.20 *   2.42%*      8300980.77 *   9.13%*      7743306.30 *   1.80%*           8284260.83 *   8.91%*  ^
Hmean     unixbench-pipe-1                 2574942.54 (   0.00%)     2535689.01 *  -1.52%*      2472718.52 *  -3.97%*      2558661.32 *  -0.63%*           2567755.92 *  -0.28%*
Hmean     unixbench-pipe-512             364489246.31 (   0.00%)   361385055.25 *  -0.85%*    363215893.62 *  -0.35%*    368809317.33 *   1.19%*         370896020.69 *   1.76%*
Hmean     unixbench-spawn-1                   4428.94 (   0.00%)        4506.26 (   1.75%)         4520.53 (   2.07%)         4778.12 *   7.88%*              4353.00 (  -1.71%)
Hmean     unixbench-spawn-512                68883.47 (   0.00%)       69380.09 (   0.72%)        69709.04 *   1.20%*        70278.77 *   2.03%*             71187.47 *   3.34%*
Hmean     unixbench-execl-1                   3878.47 (   0.00%)        3824.57 *  -1.39%*         3835.20 *  -1.12%*         3802.46 *  -1.96%*              3830.36 *  -1.24%*
Hmean     unixbench-execl-512                11638.84 (   0.00%)       12288.64 (   5.58%)        13096.25 *  12.52%*        12976.96 *  11.50%*             12468.95 (   7.13%)  ^


==================================================================
Test          : ycsb-mongodb
Units         : Throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================

tip:                            301757.33 (var: 1.63%)  (%diff: +0.00%)
eevdf:                          309589.33 (var: 1.41%)  (%diff: +2.60%)
eevdf_curb;                     303940.00 (var: 1.09%)  (%diff: +0.72%)
eevdf-curb+mathieu:             303055.67 (var: 4.14%)  (%diff: +0.43%)
eevdf-curb+mathieu+aaron:       297810.00 (var: 0.45%)  (%diff: -1.31%)


==================================================================
Test          : DeathStarBench
Units         : %diff of Throughput
Interpretation: Higher is better
Statistic     : AMean
==================================================================
Scaling        base      eevdf         eevdf_curb   eevdf-curb+mathieu   eevdf-curb+mathieu+aaron
 1CCD           0%      -14.95%         -16.35%         -16.67%                 -16.22%	 *
 2CCD           0%      -13.50%         -15.94%         -18.03%                 -17.93%	 *
 4CCD           0%      -8.49%          -11.07%         -13.11%                 -14.57%	 *
 8CCD           0%      -4.61%          -4.87%          -5.72%                  -6.02%	 *

--

I'll go back and dig further.

--
Thanks and Regards,
Prateek
