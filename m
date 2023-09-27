Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43117AFEBF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjI0Ihb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjI0IhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:37:03 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212CDCE2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 01:37:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtWJ29UReJxAFi1ZYvCy8nNprM4gVYjWpjuFgp8FqSpzeGzHKJab/3BBFNzxwF4ANPlOHyltb+1K0939oGdQn0YvsqKLPS0LQR0QqZHqTkiEH0J5oFuG0O9Nav72MMKmGjU7bX54QWh47zsHmoo1bDu+/P9aQ0eP9Ke4m2xsdYeNPYE1wX4ZMH43Ovskcm3rKPCkZ7CdzR6X1zZL+8vUDnXFBHzWjPhGa9eP7OLdgpShAgmHH0vym73WCSIdB8nwN86iNii5Mv4q8cdg9q5CMwCQIbUKa3+O6pvdonOsLH1flQoP1mC3veuShp+3/JiMVMISALd5PYDjhgHVGES9ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwfP4SQ3OSuxjP/c8//itzxno7fIrxPTky1hc7GQCho=;
 b=EwcSfMNpxL/KQ/q0EtOwF1yhU5zWVZbGe2qBYI8hhnOsUbLnmJZgXQSWXsykS6AY6i2P+vm4uo2yX9r5D4BKM6EmTJI+VynMKPqBxOxaE9wkY2zeyrpVwXdEGdweo/UA+wLU6jCFbnC5cwXiU/cKvL4QBN9ZKH2sDToaDK4Wld6O9NLlZ9Fg7fOxGZypm6vwV3BfZGXKoxJeXsC8SY0u44IxA5knxi73H/2pCfhe9fronOTPFB8nSsNnXnGQS6LlAT0LQpWEyMplgHRqmO6EFYUvM5xLlqUxLGsOB3vgUevMvUsdUN/SJtWFwNcui6pwvl6+l8hF9Vk7UN5YUWbRoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwfP4SQ3OSuxjP/c8//itzxno7fIrxPTky1hc7GQCho=;
 b=Y34zocygzMH6mMMRPuH49oavTsXQBElOMmwDU/tk+bNQlebPV/jalMf8tRbUa4wj9j54pALRx8kLtgHQkDQx2B5zScRPOpYMzn8IN2EZwcjELXjgia0OOQ7pWaH4d+aWx81+Q+MpkrpWm2DDd68DemEaUobYwXcayMTJ22k/Qjw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by CH2PR12MB4056.namprd12.prod.outlook.com (2603:10b6:610:a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 27 Sep
 2023 08:36:58 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::6f68:739f:be07:cb78]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::6f68:739f:be07:cb78%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 08:36:58 +0000
Message-ID: <d755d515-e5d6-b3fc-f7f5-9f8aebcf913a@amd.com>
Date:   Wed, 27 Sep 2023 14:06:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH 3/3] sched/fair: Add a per-shard overload flag
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, gautham.shenoy@amd.com,
        aaron.lu@intel.com, wuyun.abel@bytedance.com, kernel-team@meta.com
References: <31aeb639-1d66-2d12-1673-c19fed0ab33a@amd.com>
 <20230831104508.7619-1-kprateek.nayak@amd.com>
 <20230831104508.7619-4-kprateek.nayak@amd.com>
 <20230831191103.GC531917@maniforge>
 <258c9412-445a-04f5-dd0d-1f6699a257b6@amd.com>
 <ZRPS0cQo0/XcbkOj@chenyu5-mobl2.ccr.corp.intel.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <ZRPS0cQo0/XcbkOj@chenyu5-mobl2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0136.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::21) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|CH2PR12MB4056:EE_
X-MS-Office365-Filtering-Correlation-Id: e4090be5-abc4-4bed-aa44-08dbbf34e872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CuOKbb3M7f9j6X3vjImwx4Sp8Z2nU10xN4JuThsRfkEIkY9bDZS8iNjzohevyk6OQ1ZbWfP9KfWOefOrsHyItIUjqhPYr2j+ZdIQ2eohzyR8ncmW+rJqIellnkpmSZoZ9KiWX9JcEhq1RWb3F+mNTXjrqEBj6hQuiD9WAf6nMOrRjtHGJn3rALcl++Oz2Kw39k4R8az+uABMkh5zuVKOLM8HZcRlxQxEx+zQjJ/RzjsNKx5geFWp2SOPb7uYUOE44i7IdZ8E4RcriNF4OsmBn2qfkS2sZNX5E8cF4Tg4zTVPKzzMqF85x/wXHCY/h2NK/jQNTuQ79CWWrUjZIP98zpolDrYBkSxMZNqoEThBuB3C7ssdcwWzdlj/b/1TCFdn8hKeagLP9jY3DD0niIqp0w3B9JLcJUPHzaoWZvN4jLEmzng7t9S4oVpH2lSnyw15N6/I/jeDzuNmajATuJcQ6n6RAqQkc9CdTbQ5YcBtcjx2ReGeVC50nS70MDafPKGahis5M2sGW0L3VuuSqn+2h7YmQkcJryN5A8ogrTyG4K1+w8IGCCWCj4Z+hnO4OttgysvKeasLrU49J0O64H6vtG9CJmyAyjXbw4WMm3bPbS7rVGnZ6Be7wbV9H4E7V8w3pgwAuESRv+PXoFn4jEJL5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(6512007)(6506007)(86362001)(53546011)(26005)(66946007)(6486002)(2616005)(7416002)(2906002)(8676002)(31696002)(5660300002)(4326008)(41300700001)(66556008)(66476007)(8936002)(316002)(36756003)(6916009)(6666004)(38100700002)(478600001)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVB0TDFVYS9hRnZjaytkaDllZmJ0Nk50UFJEenBBdFRyT0pHd1BCb2FOKzN6?=
 =?utf-8?B?cFRpRE1aT3cydmhHK3JUaGJiNTNUckdPVWlvcHoxUGVhOUpCUzIzcTRPUXpG?=
 =?utf-8?B?cU9nV1BrT2VRdnlhVlpoSCtaVFdVd2lvSitjOVNreTcxcGF6enYwRGZjQXFY?=
 =?utf-8?B?V0thT1NKQVE4OU9oSVZLYklEOUdsTGk4bE5PMjJuQUdmeG1oS1JkQ1dPeU9V?=
 =?utf-8?B?YnBvUmdtWHBENlQvSFIyV3RXK3pJUlV5YWt0V05pb085Zlp4Y0k0eWt5N2dS?=
 =?utf-8?B?VTBJbHdmUFB1SVBEMWJwYitQZi9VSW9sUHpzbDdCTXZ0U3NZNlhxZ3U5TGhY?=
 =?utf-8?B?dXpXT0ZoUTFveHhPTUFpV25LNDZnaC8rVDNYakpvNG4wTGJ4T2FBVXVtSE5S?=
 =?utf-8?B?Z0JRNk1Kb1Z0OXZxV3ZVUkIyVWpRM0t2UmRuMWppbTczNkhZZ3V2NDd3WUlJ?=
 =?utf-8?B?Ukk5K0xYYmppcHBUdk14OS85MWlPL2FYemR6NzljVnlqY3NKUmc5TDdlTlJu?=
 =?utf-8?B?djVrSGRDaUN5VFY3citkZ0daRDRxZWJJYjhScmV4bWNkeUZpVkNPQks5cTBE?=
 =?utf-8?B?a2U0MXd4RUV3U1picmVnUGc1Z2VYL0JXRkxtaWZTZUdEYUYyL0VacVhORmdP?=
 =?utf-8?B?RFE2TmJON01YemRqeE5YUHhBVU91eUdrQXVNOXB6VXhtNG9xVVZVYlY1Wlhp?=
 =?utf-8?B?cjY5azJvRTVhNzhJRlJIckxaVEF6S2JONEZCR0pkbWVTbHlNRUxFRTFPempE?=
 =?utf-8?B?Vjd1RmtZMVp4cCtQcHAyMDAzeWdpcHRnSms1Y2lPa0tmTVpYcFdSY1dHM2gz?=
 =?utf-8?B?RnBuTHZJb2s2T2MyR2Z3RE9pS2xTU3NWWERwdXN2OUtwbkZQL0lLaE45eHpp?=
 =?utf-8?B?VWZtWWFKd3FPNnlkWEF1eWFGaUFNbndEYTBBT2YwVVB1dFlIb3lPdWxHQjhW?=
 =?utf-8?B?UzhJSG5QWXRLcTZSZXpqR3BzK0lmdHJOeUdpaXBxUlpWRTZqTlg1MnI2T3M3?=
 =?utf-8?B?VEFaaWNnMGhNZDdqL3FmaUVwemFNdzNpUHYvUHdMSUpsR09IeDhjell4UE14?=
 =?utf-8?B?TGtETCtpNnFCWVE1WTlMN3g5ZVBzbnBwSHFvY3hFK0tHL1F4akZ6cXU0YnZX?=
 =?utf-8?B?VWN3d0s5YTNXNWpaWVd4WFlHT1EyRmEvekdDOS9RNGp6ODY5TVoyZS9JREcx?=
 =?utf-8?B?QmhQdWJUMHBKMExocjlzdHZBV2VPa3Y1NVAxeVUxNEIzTFdmWHpUeG1XSVRT?=
 =?utf-8?B?b2hzZ29YRm1TcTYzbHpjdGFYdDJza1hJT3puNWpTOWpST041K3BVOTRQeEVo?=
 =?utf-8?B?UCtteThBRk9YM0xyb2VPdmJkUWxLMERJQ0FoNjk3WVZNYjdvNGlGQWhmSThR?=
 =?utf-8?B?cVQyaW1TWTFvYjRNLyt4em5HUWV2UEVtK3pPbm1KaVlzY3J1bjdzdzVQNGFR?=
 =?utf-8?B?dlFsWElyOENZR1FTNUxzbUZPcFRzUE5NSm8ySmFESXdDV2IyRHBVMm5UZEs5?=
 =?utf-8?B?aWU0U0poM3lyOUhSVWU1KzREQ0FCTWw4dCt2ZmR6VVY1NklGRjQyMEc2MDRD?=
 =?utf-8?B?dVFDU09hL1lrUm5MU3piTGZudG1wZEtXd1NTbTl1Wk56QkRxRkxwbVEvSnBX?=
 =?utf-8?B?NER1azZEZ1hDZW0xRlpYUFFuakJDUVVWRDExRktrQUhrdDlpY0VyWHg1Q1ps?=
 =?utf-8?B?cFdqbUwwTUdUbkxyRm9YeHRNdS9zQy93R0N1dFB6bERGNlZWWGV6SGxRNUR4?=
 =?utf-8?B?cGFzNzhwZmxQM0lWVElPaFJtdmUzOE1NdFdmSG1EUE5NNnppSDl1UXV4Y0Fh?=
 =?utf-8?B?VmlvZnk4SElIbHIrQ0pkYVk0R0R5VEVpRDFBQ1pHZW1XTWNsM2xtc1owQk16?=
 =?utf-8?B?a3pKNG9wWlR4bldXQ3FqSHJWOHAzOUVHbnJJMDh2OHdoYkhEdmR1Q0J6YzZ0?=
 =?utf-8?B?QWx1enp0YlBLQWgwV2RYU3F6Qm42bVVtZml2VFV3Q3g0NVpQQnFzSEhUUnZG?=
 =?utf-8?B?MXNOcHBEQlJJUndNWXBiWXB1ZjJ1ZnpZZTgvZTVHeWZaVWwwN004aG42YjFG?=
 =?utf-8?B?Vkx4NjEyY0sxa1BhRGxKOEJoMUtvUzhkNnV1TkZ4bnd4R2pTT3d4cEtFVklT?=
 =?utf-8?Q?KHIuOUVn1svYWm/JVgCUos83G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4090be5-abc4-4bed-aa44-08dbbf34e872
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 08:36:56.6046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87hZpClkhfBNVY8G9n8ikYU+OT7Rylolb0tpw8QfkJNK/3+bV/QWHjdZZVODg1mLWmNcrPRz2Kc0BhqL+IXWfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4056
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chenyu,

On 9/27/2023 12:29 PM, Chen Yu wrote:
> Hi Prateek,
> 
> On 2023-09-27 at 09:53:13 +0530, K Prateek Nayak wrote:
>> Hello David,
>>
>> Some more test results (although this might be slightly irrelevant with
>> next version around the corner)
>>
>> On 9/1/2023 12:41 AM, David Vernet wrote:
>>> On Thu, Aug 31, 2023 at 04:15:08PM +0530, K Prateek Nayak wrote:
>>>
>> -> With EEVDF
>>
>> o tl;dr
>>
>> - Same as what was observed without EEVDF  but shared_runq shows
>>   serious regression with multiple more variants of tbench and
>>   netperf now.
>>
>> o Kernels
>>
>> eevdf			: tip:sched/core at commit b41bbb33cf75 ("Merge branch 'sched/eevdf' into sched/core")
>> shared_runq		: eevdf + correct time accounting with v3 of the series without any other changes
>> shared_runq_idle_check	: shared_runq + move the rq->avg_idle check before peeking into the shared_runq
>> 			  (the rd->overload check still remains below the shared_runq access)
>>
> 
> I did not see any obvious regression on a Sapphire Rapids server and it seems that
> the result on your platform suggests that C/S workload could be impacted
> by shared_runq. Meanwhile some individual workloads like HHVM in David's environment
> (no shared resource between tasks if I understand correctly) could benefit from
> shared_runq a lot.

Yup that would be my guess too since HHVM seems to benefit purely from
more aggressive work conservation. (unless it leads to some second order
effect)

> This makes me wonder if we can let shared_runq skip the C/S tasks.
> The question would be how to define C/S tasks. At first thought:
> A only wakes up B, and B only wakes up A, then they could be regarded as a pair
> of C/S
>  (A->last_wakee == B && B->last_wakee == A &&
>   A->wakee_flips <= 1 && B->wakee_flips <= 1)
> But for netperf/tbench, this does not apply, because netperf client leverages kernel
> thread(workqueue) to wake up the netserver, that is A wakes up kthread T, then T
> wakes up B. Unless we have a chain, we can not detect this wakeup behavior.

Yup, unless we have a notion of chain/flow, or until we can somehow
account the wakeup of client using the kthread to the server, this will
be hard to detect.

I can give it a try with the SIS_PAIR condition you shared above. Let
me know.

> 
> thanks,
> Chenyu

--
Thanks and Regards,
Prateek
