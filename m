Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B792783843
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 05:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjHVDDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 23:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjHVDDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 23:03:50 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18407184;
        Mon, 21 Aug 2023 20:03:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYC+EL6IRGANf9+FncXoRQi8zt8qX0yy/utMFSikFK29tJJuDNFBFuBi01Y+TTLj63Ai42mII5SX5GP44gmGApv+N/BqnN2j7/B5v/pO4TgBhtw2Xn2RfisGSV0A2y8/+vMZLs/4MXK9tgEGSxl0FcrzlHWs3TozVkRdg0GXRj1h8/flgFbn32KHmvYKjmPlmNAfdmrlgHmrEZ8by71QmNcYhqYrh+PLkrG7YYwMhuDBQHORJftFp/SB/PqGIa9gfBU2+emajBpSbnxpc0GlRjWP+e3fylrrL+AL8GVT4EgRUw9Hm4ZT9v6N3i7X5/cDMyRMDpjh5Aq29Zt0s1rc8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YO9PLFzTg6J/LErCOBxi0tsL/e44ZYaxmnnBoUYQEwY=;
 b=EBg/7gTHu2GSvcYc69ZReDic5QliwgyAnjZnyBjDee+oDtw1NbP2zVGSGk/kiYgGZhIx435xJI5XO7ryP46xPEgNG+K3TMEKppnDhwyz7/yRWPiR85yVY9vbBPYrFJ4Ov/uKGrju+8spf05nTv2oTlKSpI33i4GDuTqzy0h8Ub5QebWpcDfbVbpa0P85JfuT5j0+onjOTRltQPhjJiH4zBdNzzPICdPDhb3bPsfVn2Bx0Vg9nbPlOSwsNn4WXGbDlKyJPi/2izTqXTqoDjn1hPduIS/+mcXxUq6egCObMD98nXNFfy4HykKqgNrgjjqQIokLCCJTl3258EikavKxsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YO9PLFzTg6J/LErCOBxi0tsL/e44ZYaxmnnBoUYQEwY=;
 b=Skya6bzgNSDXuCw4Ew9I7hjdfCDlH4QjjosBIahNeyB8xEZbfn8FuG+OXVFMVXk5PyAu5CSYHHj7MdqO+fDGXjxaN7Yy9pOyKfHLGTxepwDVHDqxc9URb1bj6qN9y2mbFGttxK6D8LwBMXcUPxHEwTii+mgWN/kSgI3BSWjNJ50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 03:03:46 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb%6]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 03:03:46 +0000
Message-ID: <f0859f35-39ec-e5dc-b77a-79162516de31@amd.com>
Date:   Tue, 22 Aug 2023 08:33:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [tip: sched/core] sched/eevdf: Curb wakeup-preemption
Content-Language: en-US
To:     Mike Galbraith <efault@gmx.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        x86@kernel.org, Chen Yu <yu.c.chen@intel.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>
References: <20230816134059.GC982867@hirez.programming.kicks-ass.net>
 <169228500414.27769.13366308319134164264.tip-bot2@tip-bot2>
 <21f3d376-17d6-8fb6-5f35-507ea931c0d3@amd.com>
 <02f6a15f094adb3c8d9957b031941d6bd10c2e43.camel@gmx.de>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <02f6a15f094adb3c8d9957b031941d6bd10c2e43.camel@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::25) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|MN0PR12MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ecc61e-26d2-4be6-9ade-08dba2bc65f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C6slyGVeQyVCDYvQwO6jA3oVt0m4DFTTGGDJRvdGQ/1wIikmpSwTDH320HSF4/G4E5WooCLI2y9iEUZ8jUH7EB1H1Z2D2JSpPf/yMLzKBjSl2LkeDYPnag6DaVd6S6v2m/NMwk8HowXQPPYrDtu39aTeG4xUw4vTCtkvkcA++EPUiRZqJctdNa4tLMIVsIxco05yrEQDcJ3pU8+yhYwOvE7U1VqSb21bmXunLZ4tn3tb0Lkx+2CfivsJEfJE4+OcJKAlNA5nKm+r51Enuj5o/XmQYMRx1GWSvZVEjitVbzagG0DW1RClAX90XvzHAcWuYmaGwXGbRuEAlqgOJZwdaSBwejDzmKIZLdp2f8NhaKrN/3E/8szBEDv57+QMq/gac8/oHvp2FDri7F7d31MTw5H2UON2ES6uNxiU1FWJ8sZx5i4fGlvnMoeocL951pRGPBzXC573aO4lO6a68bK9TapE8fPr+jBsgvQNQXOYQj40rCaPYYu9K4NBn+D0upcndw9glxRWP+c/7ThXw8qLZcz7ZniFV5NDdzdmv/aoz7HYkVd5QlktqsyIzOQmGfZKlI+r8JQ0I79T/i4lCu43A3/rYuFV7QfM2cObsMzKz3ANMWfmu6TSZouVMnaiaUjp2oPUV8u50fawMDI03qyM397v7SaJ3lzvHbCaUbVIORmN8dHMNb/ZYS5Dtgjvo4+F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(1800799009)(451199024)(186009)(6666004)(8676002)(8936002)(4326008)(316002)(478600001)(31686004)(66556008)(966005)(110136005)(54906003)(66946007)(66476007)(41300700001)(6486002)(6506007)(6512007)(38100700002)(36756003)(26005)(53546011)(5660300002)(2616005)(31696002)(86362001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akk4bjRJeEdndU1OU0VrbzJLMTNhelVRU3lzMkxocThrTGNETjNIbXhmKzBJ?=
 =?utf-8?B?OWkzZHpHeTRrZWNZdW44TTdoVzFmNStpWTJMQkZETG5mZjY5ZEFaUnp4bU1w?=
 =?utf-8?B?V3JPcEdERmdNMHova1I2NUFBbE9wems1OUZoZE1sbFc4RVZlWlNYRjhCKzAv?=
 =?utf-8?B?bHRDWFRITkhSWmVaWWVZR1V2RDFtbjBXUzdndnJGQWRrQXE2NkVZc3IyVGNL?=
 =?utf-8?B?OVlCWm9LbDNJRVRldmdjdThiLzRDVFU3Vml1SGEzNEROOHFHc25Lekpub2cw?=
 =?utf-8?B?c3hnRUZUbTZldkg5bCtzWW1XN0tjZ1czeHhmRExQVW1RRlhDVVlydElhT2FT?=
 =?utf-8?B?bFEycG1mR1UreG96Ui90NG1hQ20rTFFyam43ckkzQnBxZTA5ZDd2T0c3NXhp?=
 =?utf-8?B?bHh6b3h4UUR5QnRmYVpDZE5iQURFbWlOU0FDQVJ1TFFtbFhFaXZsMmFWRzg4?=
 =?utf-8?B?YmtTd2Vhem1uYjl6MHkxQS83akNkTXRZL0lIbENtYjdYbUhqNUd3T3MvejV2?=
 =?utf-8?B?QnBXeStncjdzaXZCRXJvcmcwV3pzZmFBa2VHYUYvdU9KckdGcjJuQ0pDUnFB?=
 =?utf-8?B?K1JjMEMxdUY1aC84YlZ4OFg3TTdaOWZyR2xybk9SbjJ6ZUdyRS95dWYxUTMy?=
 =?utf-8?B?R2YycDBabVVVMTJkaFhXWFVsOTlhanJFQ1pyV29wQ0tnUUlidTdWSkJyTkxa?=
 =?utf-8?B?U1ZhY3N3ODYrNUhvVEQyQkxydnF3eWJ5TTJmeEVhU0RDbE5UY1JmbkJra0to?=
 =?utf-8?B?d2lteVlZazc5ZmcwQzN3eFpSWjlMQ0kwSjhLY2U0cEhnbnlIVk1YQnhtN0NF?=
 =?utf-8?B?emkxaUZZeWpCY3QzUGJsQXRJaDdnN0YrRDdWckRiQUF6Y3dsNzV1dUJHMEZP?=
 =?utf-8?B?NDJPRWYwZFFZQlFMdnAzMTJabFUweXJoYjZEVTZMSUtJTDB0c3Jpemc2azR1?=
 =?utf-8?B?TWtBNG82a05Zc0YyRDl3dkgzZFZ1SW43dGhPYjBOc1JpQlhndmJneVYrWjRn?=
 =?utf-8?B?dHNJRHdHbEJjWSs3SVQxdjFBWU9jUGZVZ2tHY1UrckFJalVLUExUQjIxU3Z2?=
 =?utf-8?B?T1RaRnNPSFZmTlptNUZtZWF5aVZQUnA0WTZEdEI1SzMwQWNEeVpRKzNPajVI?=
 =?utf-8?B?Z0s1Q0JoMThzNDZrN3FhSkhTRXcyQklkQzUxeGFnMlpJME9aR0V0U2pMeWtJ?=
 =?utf-8?B?TENRU1hTa1BpU3BLWHRscUcySDZVdE1DQjhhdHZ0dysrTGJOVnRGL0JJbXNq?=
 =?utf-8?B?d1k4eTFDZEhkcmJacHRwR3JKVm5DOHJ3NzFKRlpCOUJGUytQRjlXd3pwclUw?=
 =?utf-8?B?MzhLVU50SVI1YVhseUNNeENva1pGbkdITW1vUlZJaU9EV3BJMWNsWWZpTEls?=
 =?utf-8?B?dFQyQ3RQVDRnT3gzWlJzZ1NiVTdmbWVuMGh3allEajc4SEtGdzBwOFQwQm85?=
 =?utf-8?B?L2YvblRJSFlkRVRqay9YRmNubnZmcUdKQnE1REVCRElKcjMwcm5pN2thRDJH?=
 =?utf-8?B?MDN3OS9GSWI3QzM2eWdnNHJjMnlXclJtSkE3QnRLZkVJeWpPU3NUcEUrZkxK?=
 =?utf-8?B?blVYeGRxV3JvVGpHWEVqbnhGODQvc1c2b0FnT3dYOGpuMnZEWGZGdnltSjcw?=
 =?utf-8?B?YTgzN0FGMFg0V3Y3Wmg3eFFRQ3YrdmJGZDcwTSs1YzhnRlJPK2lUb3BpcitB?=
 =?utf-8?B?UDNhTHZWaTRHM3JzSmhoTzljNlQ4VDNWL3BHYlFKSFhrQmd1YTU4aUQ5dERZ?=
 =?utf-8?B?SG5tUFgrVzRJWForWE5jWUZIdHZoQXh0UUgrQXZqblBRWWgrTkwydjNEdjY1?=
 =?utf-8?B?NW1IK3RRVW5xTzZNblUxU1BpNjBUL1RvMGhtRGFIbXp2VjNpRFZjRlRCeldT?=
 =?utf-8?B?aFlzV0N6MGlWMWJKL1NUc0JXMWRJY2UwcVEya3VqcCs3MFpXNUhHZW5UNXNH?=
 =?utf-8?B?d2k4TWUyQVBIU3lKZmZvWWJzSUN1T3dmMm9ReGMwRHIyRTh6YkJZM1lOQ2V3?=
 =?utf-8?B?V043VHFpVllBUnNYNEJDTWFrU2JqSGpXUHI5UEhNUmtSZVhjeXJSOHc4WEwr?=
 =?utf-8?B?cjBmbFZqTk1ERXRzM1dnUDJDVitiWFNjU3JacVR5Qk5WWEJmbWhWQnhPdnlR?=
 =?utf-8?Q?V1VcHYRB+AkA5Gm2nhC6Aqcqu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ecc61e-26d2-4be6-9ade-08dba2bc65f7
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 03:03:46.3456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVuO5yWm8zAGsyOkA2QBDLki0tdWNBzUg0TrnnGRI7lED9KWFli7Gsukdxlzv4RNejgEjF26nFpQY2EoaIWYeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mike,

On 8/21/2023 9:00 PM, Mike Galbraith wrote:
> On Mon, 2023-08-21 at 16:09 +0530, K Prateek Nayak wrote:
>> Hello Peter,
>>
>> Sorry for being late to the party but couple of benchmarks are unhappy
>> (very!) with eevdf, even with this optimization. I'll leave the results
>> of testing on a dual socket 3rd Generation EPYC System (2 x 64C/128T)
>> running in NPS1 mode below.
>>
>> tl;dr
>>
>> - Hackbench with medium load, tbench when overloaded, and DeathStarBench
>>   are not a fan of EEVDF so far :(
> 
> FWIW, there are more tbench shards lying behind EEVDF than in front.
> 
> tbench 8 on old i7-4790 box
> 4.4.302      4024
> 6.4.11       3668
> 6.4.11-eevdf 3522
> 

I agree, but on servers, tbench has been useful to identify a variety of
issues [1][2][3] and I believe it is better to pick some shards up than
leave them lying around for others to step on :)

Casting aside tbench, there are still more workloads that have
regression and it'll be good to understand which property of those don't
sit well with EEVDF.

[1] https://lore.kernel.org/lkml/c50bdbfe-02ce-c1bc-c761-c95f8e216ca0@amd.com/
[2] https://lore.kernel.org/lkml/20220921063638.2489-1-kprateek.nayak@amd.com/
[3] https://lore.kernel.org/lkml/80956e8f-761e-b74-1c7a-3966f9e8d934@linutronix.de/

> I went a-hunting once, but it didn't go well.  There were a couple
> identifiable sched related dips/recoveries, but the overall result was
> a useless downward trending mess.
> 
> 	-Mike

--
Thanks and Regards,
Prateek
