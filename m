Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A7A7805EB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 08:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358039AbjHRGk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 02:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358031AbjHRGkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 02:40:02 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601493A95
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 23:39:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3JPTbJ12NruMEw7Mpmt0bQRZBkN6zPrbDI3DgYGZwESSWUpZRrCv8SkF61+TM1zxxoWjfrL31VJna33f33yQmTzV4sgdAgNBknXKZ//6JoWjioQXQkA/WLl3ut/MAY6sfxaNqTbSobjVAxhVvOel2D2D8rAB1JxKYO77bFmMdZ55/bBZoC5gUO172hO4NLS12Eb5Fk/RjOKpd02yX+DWfVpKO9WjyEHzutSCasxIwMdsQo+9dC254nkrQXh6qPqOrlVfaCx+VOFaTSC1HE3XcHpvq94BEd73iLr0O3IJCBmg5d9eLX3pU6vqxPiXcKZJKSf2bE8DpNjZ8k76iDctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBYePtGsk5qPNklaJYZ2ZOlj99y1RKO+u1ILpgvZSg4=;
 b=cvS1E/dmnoECCle2qTTIajuVIW2wl+PZr63JJXUw4TTnJG3KchvCeHyZBNHpmn/TcdzPLjvqww402XS9FhQqWsgvO/8lsIh0/swGNfrU0o1u3T4kqs+IevUI36yj7kC3yo8SFmYhfiyvadjLD54Rgij4Pf/QOajCsreTPdczJVJOxrUVh8jvkxTn/7g4WvaHooHcfySoWUuO3p/Y07yychNP7Z4XgoIM8+dZyPpEHRRQO2410UeIVICTwJN/bG/oGokLfvN8prIdzEzv5xqny390EytfwvSQbLklBTBGUNYA2+kv4nR0z1pR+cO6EKgKqLvKMwMNrFZSpDsJl+06Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBYePtGsk5qPNklaJYZ2ZOlj99y1RKO+u1ILpgvZSg4=;
 b=gbevGGj7jXmampPTRGcMd840hPZHIWHNCffD6nEA7tVanWPDFUqdRnyDwHnZR3gO0OhGFRe/FIxEaKZZnOhvjMlrSs836PcVy7EsqWZXBIuCICVTJ8S7XZLA9RImVb7NceDAnGFIMbKgYr7LGP8fyWeu3idv1vN2F7RcGtwB8vs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by CY8PR12MB9036.namprd12.prod.outlook.com (2603:10b6:930:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 06:39:55 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb%6]) with mapi id 15.20.6699.020; Fri, 18 Aug 2023
 06:39:55 +0000
Message-ID: <2f9aaf2b-165d-8a98-98af-a3a0ee4c4b2e@amd.com>
Date:   Fri, 18 Aug 2023 12:09:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH 1/1] sched: ttwu_queue_cond: perform queued wakeups
 across different L2 caches
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Aaron Lu <aaron.lu@intel.com>, x86@kernel.org
References: <20230817153515.143932-1-mathieu.desnoyers@efficios.com>
 <CAKfTPtCavFCk+1cJe2=zFa7WfiX4XGMdc5AsA_2r4xqsk+4v7Q@mail.gmail.com>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <CAKfTPtCavFCk+1cJe2=zFa7WfiX4XGMdc5AsA_2r4xqsk+4v7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::14) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|CY8PR12MB9036:EE_
X-MS-Office365-Filtering-Correlation-Id: fc0b53a8-2a89-48c1-d735-08db9fb5ee8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ZBYhr7GWWpvK1V9V2s/jfnqo5hAq89o68u0y48jCY7LZw4SE1ZSupw76SL3B2xDpz+63WHJpGqldTQtTW2AKaNL+F7TWbUfBXyBm7ZtkevevhqfT0LjZOJnXKoCxiuwyCybTSVkgRAmhAryEsOIaaf/M2al09VQIDDbtG3YCBupyM1qJA8MbWIoQ/CEVwhbJRXgAWG6xyU++IbaT96Ua+0ERf0GLdR1VlhyhzeaS8cvfIK6AIsYTqCR1nXTetSpkFpGUCnjzN0fq18zI8YKkrN15hQR9WojP5qHiIZKVq8zJcpT2gl0ZiXh12qL9DyQBzNWYCVpfSsRT9YWOpcRJ4IXwsG3bbss9vm9gcQGoGPcYsQePRTyjM2WBN8laDf0ONgQCkgEZKuI+PiasRb8+TnOwjg7nl4pZpwyh7MFD/q8htBe6x0nRErPub7m2fLnWhbA6X3JCrNrVvTvRjWqUB1SvcTZFhNf7pLkBKA+ROPXq0OiwbYWgBc0YJleKejqgMBSvwhbb/FyOOqKueWza+mrjLJP4XgPYowhSBic0PJTflGX1/KLgyRz1eJrbr3WuqTcjO6ec4OljOlZ3741oO+Gd8SgNUqMv69n9cQ69yjmOF0LsOz3DHg1Am6ChClLFpt7LMHk9VbLGuVK/9QrHVRKVfV/9Qs0RAisyaHZ2fjURajgunZaxeDB+zUHeNo8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(376002)(396003)(186009)(1800799009)(451199024)(6666004)(6486002)(6506007)(38100700002)(6512007)(53546011)(86362001)(31696002)(26005)(83380400001)(36756003)(2616005)(2906002)(54906003)(66946007)(66476007)(66556008)(316002)(41300700001)(110136005)(5660300002)(7416002)(31686004)(8676002)(4326008)(8936002)(478600001)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1FFUFpBRFNoUlRzRnhLRkovbVkzeFlUVEVkVWZYM0RFeURzWVpjTVRtY1VT?=
 =?utf-8?B?NEZNUkdwTTNpRjVUV0szWXhPbGZId3ZmRWZhWkFPdkIzZXk5OXphd0ZFc3NH?=
 =?utf-8?B?TzduQTdaOGd3VlE4ZGFVaEY1anBpSnFpb2tla1M5bDBaZ1VHWXc0dnJVRVFY?=
 =?utf-8?B?emhHWTg3dkxGWWNDcFNuU0tRK2ZuZnRNcnRlMWJLU0xTY2FrdytYSS9mYU5k?=
 =?utf-8?B?bDhkSVowdnBIQjNQbERHelBkT1VqeGRxU3dYaXVMUXJXMUxjNmt2cXh3bmhR?=
 =?utf-8?B?eXB6TzU4VEoweEgyUkcrSHdBWHpVaHhURVhhZGRCMkJndFhYdmk4a3NRWXhy?=
 =?utf-8?B?aVJoalUvcTRuM1dRUk9tWDJqYUM2K0FIWjVtTUJrK3JidXladXlINGVndFRW?=
 =?utf-8?B?ZzBPZjg0VVVzdHc3ZDBJdC9HcGwxTGRvMldrKzVKeGpuSStramo1VFlOc3VD?=
 =?utf-8?B?VDJKQ2tRNFlIMC9Wc2VqdU95QXhDdTFEQVhuNDNHUjliZklxdjZzS0hHZmtD?=
 =?utf-8?B?RDZRU214WFpxMlMyMUY1VWkxdG9nWG5EbUpoY2MvaWo2b2x3NXNQL0tBV1JO?=
 =?utf-8?B?dFZ4clVNRmtpUzJ5NCtmOXg0Uk5sa2lhMFlCT1djekM0VVFkZFRGRFlpajFU?=
 =?utf-8?B?SExsY0wxMFJINmt4cC9DTU5pWFdDRmRKdXlvTCtCeFJUYk9JK3ZMQWExcExV?=
 =?utf-8?B?emh2aGNTWXRITUNRL3FvS3huK3Q4WWg3UTFCMStrTXZZVDF5ck5DZzM1TEYv?=
 =?utf-8?B?WnpYSnU1eHBKQVY0V0tDVFdEMU83azNma2xaU0lKU1huVmVkRSs5QTZtczdU?=
 =?utf-8?B?cU1HOVpEZS93bS9qZ25Ka2p5UG90YzJzd1k4cXBBbSt0ck9qMFZlQ0ZDT2xa?=
 =?utf-8?B?K0FsOVR4SHlzQlFKcStYNWh4R0JKOUNlM01iY3dLcEhXR2N4QVA2WlIyc012?=
 =?utf-8?B?dGxkMEZqQ0puaWZBZ2FvZmE1dk96NS9ReWk5blpBREF3VDNqQThzSjg3Nkoy?=
 =?utf-8?B?K3JFTkdUaVYxRy9INlpFcW9lTDYzTjBqd1Iwemc2Z0tMYmU3bkF6dGphZzNh?=
 =?utf-8?B?c3lRVkVBSjRnMGdpMWNVeEdjb2c2YTNUSEpWb0lhRVFTSStNa2hydXVQaDNQ?=
 =?utf-8?B?WDFhRFRsQ1A2QkhaeTRzYUJFUGRrRzhDbktyWXpzUXhpQzZPQ1lSaXdwME9z?=
 =?utf-8?B?VDJBTjlYT1B3REliSU0wQ0tkOFlWQlhrWEFUb3hUeWlCVzRtTzhxOUpiSGNX?=
 =?utf-8?B?aUJtY2h2ZFJvcTlPQUl4eTVyTlZLRzFSL09LdnZJdkRSMlBnNXBWNDdYVE5z?=
 =?utf-8?B?N0Q1QWV3Nndac0VFSWo5YUIxUUtTdDcrQlc1ZWlaRGlZMWZzeVpUNldaSGR2?=
 =?utf-8?B?bldBV2RQM283YlV3aS84NzNHeVVJZEwrNGhzdTFJYlY4Lzl6V0VSZ3JEeWNW?=
 =?utf-8?B?WlpJSnJhcEw4THErUXFsbE9qM2ZBQ1pydk9MSXcrRUZxRlhoY1RrUkR4aTIw?=
 =?utf-8?B?ZWFFNDlFejFIU1A3VWhPMno3dzNNR1F1VVdLbGNhL3RjekhCWlhEd3JnditT?=
 =?utf-8?B?MFEwbCtNelVaZlZzNWJJUVlvSlV2NXFjNEtZWlZOdGJRc0VmRmhlUXhVMFQv?=
 =?utf-8?B?VSs5SG9JelZqaXo2a1RZb1ZrYmRERmxYWXB6V2dMRjRQczNGWk1CcUMwRzZO?=
 =?utf-8?B?U0NEMklYc3NJS0NQMC80RCtkQ28yTjNuSWJvMzVEZ2VDYlE0UE0ybGpjUGpF?=
 =?utf-8?B?WUhxTmNxNHVwdWhGZkhMV0RrOUs3VnloTUcwTzJ2cm9pU0h0Qm42SlNNNjQr?=
 =?utf-8?B?NnZZbjRQRTZKZWpQTjlFVVdXcTdiQTZtREZYKzI1UUVrZWtjZ0diN2M4NUF3?=
 =?utf-8?B?OU5DakVPbDhIM1RLUHRraEZ3TDQ5Zk1veWlHbVhYNkluNG94am92cFZGZVlu?=
 =?utf-8?B?SVVEc2NhY29DL2RDbWZBVkFtZTl3SnRIQTY1UzU3RFR5WC94YkhjZEJybDJG?=
 =?utf-8?B?UjZaTWxSbkNPUnhvZGdtYm9SV1pYbDU1bTk3czFPMFM3RGZPc09pRzNCeUFt?=
 =?utf-8?B?Mmk1R3lDcFJ1SnlSWEYrLzhQUTJVb0FBWnB6WXRwb2Y3UWxpSkloSURzSGVx?=
 =?utf-8?Q?bJyzRcfvRG01nqmWzCIslI/6n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0b53a8-2a89-48c1-d735-08db9fb5ee8a
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 06:39:54.9216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvrTVM74caFzECfXpdIeRB+2oedr8eiubtpN5Kx9KlE+EuQ13l4btLS8mTC3rOaYydx0exzJC129KUGzUTEnSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9036
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vincent, Mathieu,

On 8/17/2023 9:31 PM, Vincent Guittot wrote:
> On Thu, 17 Aug 2023 at 17:34, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> Skipping queued wakeups for all logical CPUs sharing an LLC means that
>> on a 192 cores AMD EPYC 9654 96-Core Processor (over 2 sockets), groups
>> of 8 cores (16 hardware threads) end up grabbing runqueue locks of other
>> runqueues within the same group for each wakeup, causing contention on
>> the runqueue locks.
>>
>> Improve this by only considering hardware threads sharing an L2 cache as
>> candidates for skipping use of the queued wakeups.
>>
>> This results in the following benchmark improvements:
>>
>>     hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100
>>
>> from 49s to 34s. (30% speedup)
>>
>> And similarly with perf bench:
>>
>>     perf bench sched messaging -g 32 -p -t -l 100000
>>
>> from 10.9s to 7.4s (32% speedup)
>>
>> This was developed as part of the investigation into a weird regression
>> reported by AMD where adding a raw spinlock in the scheduler context
>> switch accelerated hackbench. It turned out that changing this raw
>> spinlock for a loop of 10000x cpu_relax within do_idle() had similar
>> benefits.
>>
>> This patch achieves a similar effect without busy waiting nor changing
>> anything about runqueue selection on wakeup. It considers that only
>> hardware threads sharing an L2 cache should skip the queued
>> try-to-wakeup and directly grab the target runqueue lock, rather than
>> allowing all hardware threads sharing an LLC to do so.
>>
>> I would be interested to hear feedback about performance impact of this
>> patch (improvement or regression) on other workloads and hardware,
>> especially for Intel CPUs. One thing that we might want to empirically
>> figure out from the topology is whether there is a maximum number of
>> hardware threads within an LLC below which it would make sense to use
>> the LLC rather than L2 as group within which queued wakeups can be
>> skipped.
>>
>> [ Only tested on AMD CPUs so far. ]
>>
>> Link: https://lore.kernel.org/r/09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com
>> Link: https://lore.kernel.org/lkml/20230725193048.124796-1-mathieu.desnoyers@efficios.com/
>> Link: https://lore.kernel.org/lkml/20230810140635.75296-1-mathieu.desnoyers@efficios.com/
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Valentin Schneider <vschneid@redhat.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Ben Segall <bsegall@google.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
>> Cc: Aaron Lu <aaron.lu@intel.com>
>> Cc: x86@kernel.org
>> ---
>>  arch/Kconfig                   |  6 ++++++
>>  arch/x86/Kconfig               |  1 +
>>  drivers/base/Kconfig           |  1 +
>>  include/linux/sched/topology.h |  3 ++-
>>  kernel/sched/core.c            | 26 +++++++++++++++++++++++---
>>  5 files changed, 33 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 205fd23e0cad..e5aac1741712 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -340,6 +340,12 @@ config HAVE_ASM_MODVERSIONS
>>           <asm/asm-prototypes.h> to support the module versioning for symbols
>>           exported from assembly code.
>>
>> +config HAVE_CLUSTERGROUP
>> +       bool
>> +       help
>> +         This symbol should be selected by an architecture if it
>> +         implements CPU clustergroup.
>> +
>>  config HAVE_REGS_AND_STACK_ACCESS_API
>>         bool
>>         help
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index cb1031018afa..07813a1a9a58 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -299,6 +299,7 @@ config X86
>>         select FUNCTION_ALIGNMENT_4B
>>         imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>>         select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>> +       select HAVE_CLUSTERGROUP
>>
>>  config INSTRUCTION_DECODER
>>         def_bool y
>> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
>> index 2b8fd6bb7da0..408aaf7a4bd1 100644
>> --- a/drivers/base/Kconfig
>> +++ b/drivers/base/Kconfig
>> @@ -218,6 +218,7 @@ config DMA_FENCE_TRACE
>>
>>  config GENERIC_ARCH_TOPOLOGY
>>         bool
>> +       select HAVE_CLUSTERGROUP
>>         help
>>           Enable support for architectures common topology code: e.g., parsing
>>           CPU capacity information from DT, usage of such information for
>> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
>> index 816df6cc444e..714386070463 100644
>> --- a/include/linux/sched/topology.h
>> +++ b/include/linux/sched/topology.h
>> @@ -178,7 +178,8 @@ extern void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>>  cpumask_var_t *alloc_sched_domains(unsigned int ndoms);
>>  void free_sched_domains(cpumask_var_t doms[], unsigned int ndoms);
>>
>> -bool cpus_share_cache(int this_cpu, int that_cpu);
>> +bool cpus_share_cluster(int this_cpu, int that_cpu);   /* Share L2. */
>> +bool cpus_share_cache(int this_cpu, int that_cpu);     /* Share LLC. */
> 
> I think that Yicong is doing what you want with
> cpus_share_lowest_cache() which points to cluster when available or
> LLC otherwise
> https://lore.kernel.org/lkml/20220720081150.22167-1-yangyicong@hisilicon.com/t/#m0ab9fa0fe0c3779b9bbadcfbc1b643dce7cb7618
Please correct me if I'm wrong, but with Yicong's latest version
(https://lore.kernel.org/lkml/20230719092838.2302-2-yangyicong@huawei.com/)
"sd_share_id" will follow "sd_llc_id" if the SD_CLUSTER domain is
degenerated, which is the case with any system where CLUSTER domain is
same as SMT domain.

On logging the cpu and sd_share_id on my 3rd Gen EPYC system I see,

    CPU(0) sd_share_id(0)
    CPU(1) sd_share_id(0)
    CPU(2) sd_share_id(0)
    CPU(3) sd_share_id(0)
    CPU(4) sd_share_id(0)
    CPU(5) sd_share_id(0)
    CPU(6) sd_share_id(0)
    CPU(7) sd_share_id(0)
    CPU(8) sd_share_id(8)
    CPU(9) sd_share_id(8)
    ...
    CPU(127) sd_share_id(120)
    CPU(128) sd_share_id(0)
    CPU(129) sd_share_id(0)
    CPU(130) sd_share_id(0)
    CPU(131) sd_share_id(0)
    CPU(132) sd_share_id(0)
    CPU(133) sd_share_id(0)
    CPU(134) sd_share_id(0)
    CPU(135) sd_share_id(0)
    CPU(136) sd_share_id(8)
    ...

"sd_share_id" follows the "sd_llc_id" since CLUSTER domain is
degenerated.

    # echo Y > /sys/kernel/debug/sched/verbose
    # cat /sys/kernel/debug/sched/domains/cpu0/domain*/flags
    SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_CPUCAPACITY SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING # SMT Domain
    SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SHARE_PKG_RESOURCES SD_PREFER_SIBLING # MC Domain
    SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_PREFER_SIBLING # DIE Domain
    SD_BALANCE_NEWIDLE SD_BALANCE_EXEC SD_BALANCE_FORK SD_WAKE_AFFINE SD_SERIALIZE SD_OVERLAP SD_NUMA # NUMA Domain

But I believe Mathieu's case would require falling back to "core_id" if
the cluster domain has degenerated.

--
Thanks and Regards,
Prateek
