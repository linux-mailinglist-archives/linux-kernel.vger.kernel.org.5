Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5381E76DFE8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 07:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjHCFyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 01:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjHCFyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 01:54:03 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAF42D49
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 22:54:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJgQmbSozo5qw5Ue+TmYdGfOuhkcm0qaoELx9VjJui03kBcefWo5V1q63g7JEezCc1vMT0aSCIWu3e4zuykBWkAmd0bdBSMFKp/tbSTFVqK9OM/3wgooyp5+VehI2Xks3+ATG+JxeyWRSTsq5s+FCvsA9YyKhFcuS/alp/ZMsFQPPhAUA3TNjKW3zVhS1PwymVPbEBk2T3Kik4JLb39Yv6OCU4M0zole0OPPe8qazTT/4gwN8YdYVFxjO8fmlAjkDPpRw0NJk8YZSggGEE//3XhFOBxu+sAe0/9FFn9mSgzJY6HgdZfhG5beRuYtvCJoDhO1Cic9UMGriPvEOp0B6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfrHNxmnggT5YAKbV07HpKnTdVtRhFtRKqa+AtzN+8U=;
 b=dy8qmrb0Pl6HS7yKnk3WkbtBkO10BVgPNrAQ5YUbyK2D6N9tWhZeBv0u+5G2SU30q7wwQOX2Uk5X4utb3FzkIKt3YwB1O5SaKEP4l6rWgQZgw9OLXAbldv8lw8CTBhjL01Ms9ArcrNKMZevT26xhx/9B9GJUgeziUhQO086BLjylhneq6J/1H2b3SD3/EF/HLK21RQqsPwsnQPtEvvGTGaY9y9dys8v+o0Qw3qsjJB3v96Venit5ywcFVosS2XXSU9qJfRdFOJSUHUAAYBajGtM0AEu3VXBnkCYWEmJd7RFLO+163ARq3MT3YvJ08Q+Nk6p1zYUweqzuiKM68O0RjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfrHNxmnggT5YAKbV07HpKnTdVtRhFtRKqa+AtzN+8U=;
 b=qbuyRzkylqm6xxX71+gi1AFZwD3qHWB0/aSMC51xg3PwUQ7k84afUxffnexWsiUN2jC4iv2N0bS4Vvy6XMuVraspisB7RL+ioWnhqMiuG8wHjfBppPdF74P7mtLeO4bcWEbkVFWUS5I9u8JIoEDSi1KmO2bRNRKT/S0KEIcukks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) by
 CH3PR12MB9220.namprd12.prod.outlook.com (2603:10b6:610:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 05:53:55 +0000
Received: from DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::208c:3910:f2d8:e43a]) by DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::208c:3910:f2d8:e43a%2]) with mapi id 15.20.6609.032; Thu, 3 Aug 2023
 05:53:55 +0000
Message-ID: <18912151-82c0-2936-10b1-f5fe7132287b@amd.com>
Date:   Thu, 3 Aug 2023 11:23:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 1/1] sched: Extend cpu idle state for 1ms
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Aaron Lu <aaron.lu@intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20230725193048.124796-1-mathieu.desnoyers@efficios.com>
 <69076f8e-191b-2e3e-d810-ea72d8ff18bb@linux.vnet.ibm.com>
 <79fa8a62-a74e-2623-9f03-1f1af85b6c07@efficios.com>
 <cab82676-27fd-b4e1-2cd8-3d8d26b44aa0@linux.vnet.ibm.com>
 <447f756c-9c79-f801-8257-a97cc8256efe@efficios.com>
From:   Swapnil Sapkal <Swapnil.Sapkal@amd.com>
In-Reply-To: <447f756c-9c79-f801-8257-a97cc8256efe@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0216.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::14) To DS7PR12MB6165.namprd12.prod.outlook.com
 (2603:10b6:8:9a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6165:EE_|CH3PR12MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c6bd896-e1ff-4f1d-d071-08db93e605a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1jV7rIWdirkCsHg2CjBKkfjwDHTzamuDuRoeoCRgn0Mfuj0z+gtWieSbpobKdtLlQbWJ5klJfc60LS+rK/JAQ1/2G6m3VQkLpTKRoQ/9cQAP3v9RK0/ptprj8rlGk/K6Wjmy31fXcUfuxL43MrK0zdq1oiOm1YEnx7IIXlJbhHlfPL6OD6cmrbxZhaJ4zVKmM65OwqOF6V5LJvjiFaaVI15az36NY6XHRE18SJXwIVplU9kJEd5xQ4JygwZC8AF2DXpjEWK0O1GZayAFyFbWGiN9S5UjsaeKllr6VZRNFi6tqZbg7Lzkse0PLlCe6blYNBrznnu0sPf2zLtcvBLFXafoL25R1aq5xUT7SMJORE0sz6U5Yalj+JDFhZUDyW71PVgvQXUNlRN0PSFSRb6xIcMINJW3eUUQHFFLbWQ1qO8qHniNWij3MLAz96j3hcoYJCdHb2I4fjYQZg/X03m8rV6fGs9+svlHJV1B/JwqoO5F2Q9GwqMcVaNABO+s3Wfx9u77YjqtVMsIX83kDaSns/HYVF8fXcI/LoTcARIDEQHZ/RjZd+mo6YQ7n3sc4ye9ZcmgyjYQPxE39yfY+f9oBo412xyBDFXq7W4EOekCc3fUMKO00YUOMklPCnt28wREhyKQBPuVgAIgeK1jV707zQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6165.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199021)(2616005)(53546011)(6506007)(83380400001)(26005)(186003)(316002)(30864003)(2906002)(66946007)(4326008)(66476007)(66556008)(5660300002)(7416002)(41300700001)(8676002)(8936002)(6666004)(6486002)(966005)(6512007)(478600001)(110136005)(54906003)(38100700002)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmxJNXVURk44ekVTZ09WRC9SMFI5R0tsRGZ4UDZZcEtCWUxmYWtZU29aY2Fl?=
 =?utf-8?B?ZlVsUWhXY09IMUJvZ1VxckpqcjdVS2o1MGQ0K25taVlKY3FKS29Hb2RWOWJX?=
 =?utf-8?B?VlhCOEx5MzJxWlVoSEs3UkVmQi95ZFJ6WlN0NFp5NTdrM2hWeUtLRzZ6eFdY?=
 =?utf-8?B?L2V4VlNyRGt1dHY4YnhmajRpejhPdllYc0dzbTZ0MHY2UERHWjBLamlTRWJI?=
 =?utf-8?B?bDNCc0FlWnI0SEtCczVtU3U3ZGpkSWk1Yjl2NXRkTmlHWWFKQk5oV0k3c1pu?=
 =?utf-8?B?dm9PK1JWLzh3SUI2V1ZCdnp3RVJWUDRoZjk0L245SlhJMjVnODY4dHZnTmc2?=
 =?utf-8?B?SnlBcTN3UVBlUFhITndxYjhPMVBEdjRXQ2pmL1krT1MxQ0FpeTZYVDJBMi9V?=
 =?utf-8?B?SjVpYVRiTjRRdTNJZFozOHRsZU1vYnFoeWk5VS9vSFczNmhvY2IrQmxZaHBD?=
 =?utf-8?B?TlhteEYyS1BUMENXbTRaOTFqZ2hDNWZDdlh4MlAycVhMeWlFcllubU0ySXBD?=
 =?utf-8?B?Q1pVMGVUNWgxc0VKdzRJNGUyZW8va3FmU1E5RDMvcU43MU13aVk2VVVDMTRQ?=
 =?utf-8?B?RndQSUExNUJydGROSUtzTGJFY0FxemM3QnF4VU9WUUFyaUVWd015Vkp4UERl?=
 =?utf-8?B?SmhxMWJnQ0ZXWm5ubkFGZGFMR2Uvdlk0ZDhwUlhYWFZZQjl6Z3JVT0dDd2FT?=
 =?utf-8?B?b3lydzdnV3QrYnBZM3poR1lWd0Q3cml6YnVtK3BMUmZYNGhYRDI2WDJMZ0o2?=
 =?utf-8?B?SXZnUHVjbFhscE9OMmUzNnd5dlVvUjk2Yks4cVJtTjZaNUl5eFl1YmEyQ1Nk?=
 =?utf-8?B?dEhWR3pxZTlQdWhKSENuYTN2Y0lEdVR4RWVFbElKbk5hRUJma3pwbkJJVlFq?=
 =?utf-8?B?UmNyeWJ1TTNzeG1KZHVRRWVEbks3TmhWN2laK0JWcXQwdnVyWU8zbjVYanpj?=
 =?utf-8?B?Nys5dTA3RmNkVWZ0TDlSWGR2MUU5UEQ2Si9NMXpWTGJiUWU5SnoxVEd2NFYy?=
 =?utf-8?B?Ty9VcU5WQ3FWamxvNzRjTXp3dDNGS0NhOUtWb29mcUdaQUJGR0JGcEJrQXpR?=
 =?utf-8?B?cUViTmlDeGkyZzZtTWYvOTRFMjRsbENwU1ppN0tpTFZ1Q3U4Rmw3RWRtZ1Q4?=
 =?utf-8?B?a0JiZkdpbVRHbHNOd1BOVjhldFlVdjRUWXZGUkdNZVJoc1JGYzVEOWM5bnVI?=
 =?utf-8?B?eTNyYjJSbjFxV3hVMmg4dkMzSXdPNDFZQ1cvZzJNWTdSK3hnNDJWVyszTHM0?=
 =?utf-8?B?dFFVeHFnOHJrT29GN3FjWUdRR3FDUjM2eGdBVk16RnRKM3EwTUtsTkR5aWdX?=
 =?utf-8?B?MVdKOHVrT2lEbHl4TjJkU2NNYlNHZklpb0MrS25NT05QaUJvS0NXK2xZU2Uv?=
 =?utf-8?B?WjE2STRaT2JuYXZzOTAyb2h3MUJLWGxJQVhxNm5MOFpqZitLcDhHeTlOZnRh?=
 =?utf-8?B?TGtwTkE2c0dJcy9mTmRRUGhWcFpWanhXVUhzeXA3WjBjaGVKbUEyTWdCNURv?=
 =?utf-8?B?QUZwLzVoMzFSMlpsWHFKVkcyak9Vb0Q2cm1IUi9mSnh5dWpPMDNaYlM5aG5k?=
 =?utf-8?B?QlZYWFJxT2RjWnRyeHRhUm5jSWlZZi9Wd2RYMU1pM21yQTVQZWxCRCtrdlFl?=
 =?utf-8?B?anNwUXdjbnJDbWpoem8zakJTVUNibE1Gd0R6SGpUWTIvY3BnREtiTWFzTVNY?=
 =?utf-8?B?YXoxUUdSL0tDNVpSMG4zTkxCNlcyYmNjL1BtWUowejZvRUdyTGtVbVpaNWF5?=
 =?utf-8?B?VVRSampicEZBSFJUN3lTRFcyb3ZCU1ZoN3FqRlJZcDVOTEVLbHVrTTZCejZI?=
 =?utf-8?B?YlFDZm5oOVZwMDRnaFZscjA1dENYSmQyYSttM2FGUmx4UllsdmJoMXVZV0g3?=
 =?utf-8?B?dTN1WXNQM3JZVDUvZ0RYbEJYV1BKamJ4VS9CYTg5ZWxNNlh0YmxjTGt4RnhW?=
 =?utf-8?B?bng1bDFsT1hldTdZOXRmWmtUWFJMVlBNWFpGdUVMOUpMcTNHYmhxZTUzK2M2?=
 =?utf-8?B?blRmYlA4NXlpc0ZrckRMNkcvNUVHOXdQNGJzMXB4d0ZmYmJNZ1pxcHlFTzVh?=
 =?utf-8?B?Z1VGU1pwWTNFang5YjRUM1A0ME4rZVRSaXVmcEVkY0h5WlJKc1p5TXBBeHJV?=
 =?utf-8?Q?a2cqJ2RYxZL2xxFQwPiPOmegb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6bd896-e1ff-4f1d-d071-08db93e605a2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 05:53:55.2649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VM6gAahGPUPCEsBVIc7T9CQrKQdw/UtAvYGfDLriZ+I18PQZg1pTYs74F8Gg5bk8jG5N/cXy5PaqjFgkgcoSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9220
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mathieu,

On 7/27/2023 12:26 AM, Mathieu Desnoyers wrote:
> On 7/26/23 13:40, Shrikanth Hegde wrote:
>>
>>
>> On 7/26/23 7:37 PM, Mathieu Desnoyers wrote:
>>> On 7/26/23 04:04, Shrikanth Hegde wrote:
>>>>
>>>>
>>>> On 7/26/23 1:00 AM, Mathieu Desnoyers wrote:
>>>>> Allow select_task_rq to consider a cpu as idle for 1ms after that cpu
>>>>> has exited the idle loop.
>>>>>
>>>>> This speeds up the following hackbench workload on a 192 cores AMD EPYC
>>>>> 9654 96-Core Processor (over 2 sockets):
>>>>>
>>>>> hackbench -g 32 -f 20 --threads --pipe -l 480000 -s 100
>>>>>
>>>>> from 49s to 34s. (30% speedup)
>>>>>
>>>>> My working hypothesis for why this helps is: queuing more than a single
>>>>> task on the runqueue of a cpu which just exited idle rather than
>>>>> spreading work over other idle cpus helps power efficiency on systems
>>>>> with large number of cores.
>>>>>
>>>>> This was developed as part of the investigation into a weird regression
>>>>> reported by AMD where adding a raw spinlock in the scheduler context
>>>>> switch accelerated hackbench.
>>
>> Do you have SMT here? What is the system utilization when you are running
>> this workload?
> 
> Yes, SMT is enabled, which brings the number of logical cpus to 384.
> 
> CPU utilization (through htop):
> 
> * 6.4.4:                                           27500%
> * 6.4.4 with the extend-idle+nr_running<=4 patch:  30500%
> 
>>
>>>>>
>>>>> It turned out that changing this raw spinlock for a loop of 10000x
>>>>> cpu_relax within do_idle() had similar benefits.
>>>>>
>>>>> This patch achieve a similar effect without the busy-waiting by
>>>>> introducing a runqueue state sampling the sched_clock() when exiting
>>>>> idle, which allows select_task_rq to consider "as idle" a cpu which has
>>>>> recently exited idle.
>>>>>
>>>>> This patch should be considered "food for thoughts", and I would be glad
>>>>> to hear feedback on whether it causes regressions on _other_ workloads,
>>>>> and whether it helps with the hackbench workload on large Intel system
>>>>> as well.
>>>>>
>>>>> Link:
>>>>> https://lore.kernel.org/r/09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com
>>>>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>>> Cc: Ingo Molnar <mingo@redhat.com>
>>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>>> Cc: Valentin Schneider <vschneid@redhat.com>
>>>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>>>> Cc: Ben Segall <bsegall@google.com>
>>>>> Cc: Mel Gorman <mgorman@suse.de>
>>>>> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
>>>>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>>>>> Cc: Juri Lelli <juri.lelli@redhat.com>
>>>>> Cc: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
>>>>> Cc: Aaron Lu <aaron.lu@intel.com>
>>>>> Cc: x86@kernel.org
>>>>> ---
>>>>>    kernel/sched/core.c  | 4 ++++
>>>>>    kernel/sched/sched.h | 3 +++
>>>>>    2 files changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>>>> index a68d1276bab0..d40e3a0a5ced 100644
>>>>> --- a/kernel/sched/core.c
>>>>> +++ b/kernel/sched/core.c
>>>>> @@ -6769,6 +6769,7 @@ void __sched schedule_idle(void)
>>>>>         * TASK_RUNNING state.
>>>>>         */
>>>>>        WARN_ON_ONCE(current->__state);
>>>>> +    WRITE_ONCE(this_rq()->idle_end_time, sched_clock());
>>>>>        do {
>>>>>            __schedule(SM_NONE);
>>>>>        } while (need_resched());
>>>>> @@ -7300,6 +7301,9 @@ int idle_cpu(int cpu)
>>>>>    {
>>>>>        struct rq *rq = cpu_rq(cpu);
>>>>>    +    if (sched_clock() < READ_ONCE(rq->idle_end_time) +
>>>>> IDLE_CPU_DELAY_NS)
>>>>
>>>>
>>>> Wouldn't this hurt the latency badly? Specially on a loaded system with
>>>> a workload that does a lot of wakeup.
>>>
>>> Good point !
>>>
>>> Can you try your benchmark replacing the if () statement above by:
>>>
>>> +       if (sched_clock() < READ_ONCE(rq->idle_end_time) +
>>> IDLE_CPU_DELAY_NS &&
>>> +           READ_ONCE(rq->nr_running) <= 4)
>>> +               return 1;
>>
>>
>> Tried with this change. I think it does help in reducing latency compared to
>> earlier specially till 95th percentile.
> 
> For the records, I also tried with nr_running <= 2 and still had decent performance
> (32s with nr_running <= 2 instead of 30s for nr_running <= 4). It did drop with
> nr_running <= 1 (40s). nr_running <= 5 was similar to 4, and performances start
> degrading with nr_running <= 8 (31s).
> 
> So it might be interesting to measure the latency with nr_running <= 2 as well.
> Perhaps nr_running <= 2 would be a good compromise between throughput and tail
> latency.
> 
>>                  6.5-rc3      6.5-rc3+RFC_Patch     6.5-rc3_RFC_Patch
>>                                                       + nr<4
>> 4 Groups
>> 50.0th:          18.00                18.50           18.50
>> 75.0th:          21.50                26.00           23.50
>> 90.0th:          56.00                940.50          501.00
>> 95.0th:          678.00               1896.00         1392.00
>> 99.0th:          2484.00              3756.00         3708.00
>> 99.5th:          3224.00              4616.00         5088.00
>> 99.9th:          4960.00              6824.00         8068.00
>> 8 Groups
>> 50.0th:          23.50                25.50           23.00
>> 75.0th:          30.50                421.50          30.50
>> 90.0th:          443.50               1722.00         741.00
>> 95.0th:          1410.00              2736.00         1670.00
>> 99.0th:          3942.00              5496.00         4032.00
>> 99.5th:          5232.00              7016.00         5064.00
>> 99.9th:          7996.00              8896.00         8012.00
>> 16 Groups
>> 50.0th:          33.50                41.50           32.50
>> 75.0th:          49.00                752.00          47.00
>> 90.0th:          1067.50              2332.00         994.50
>> 95.0th:          2093.00              3468.00         2117.00
>> 99.0th:          5048.00              6728.00         5568.00
>> 99.5th:          6760.00              7624.00         6960.00
>> 99.9th:          8592.00              9504.00         11104.00
>> 32 Groups
>> 50.0th:          60.00                79.00           53.00
>> 75.0th:          456.50               1712.00         209.50
>> 90.0th:          2788.00              3996.00         2752.00
>> 95.0th:          4544.00              5768.00         5024.00
>> 99.0th:          8444.00              9104.00         10352.00
>> 99.5th:          9168.00              9808.00         12720.00
>> 99.9th:          11984.00             12448.00        17624.00
> 
> [...]
> 
>>>>>    @@ -1010,6 +1012,7 @@ struct rq {
>>>>>          struct task_struct __rcu    *curr;
>>>>>        struct task_struct    *idle;
>>>>> +    u64            idle_end_time;
>>
>> There is clock_idle already in the rq. Can that be used for the same?
> 
> Good point! And I'll change my use of "sched_clock()" in idle_cpu() for a
> proper "sched_clock_cpu(cpu_of(rq))", which will work better on systems
> without constant tsc.
> 
> The updated patch:
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a68d1276bab0..1c7d5bd2968b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7300,6 +7300,10 @@ int idle_cpu(int cpu)
>   {
>       struct rq *rq = cpu_rq(cpu);
> 
> +    if (READ_ONCE(rq->nr_running) <= IDLE_CPU_DELAY_MAX_RUNNING &&
> +        sched_clock_cpu(cpu_of(rq)) < READ_ONCE(rq->clock_idle) + IDLE_CPU_DELAY_NS)
> +        return 1;
> +
>       if (rq->curr != rq->idle)
>           return 0;
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 81ac605b9cd5..57a49a5524f0 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -97,6 +97,9 @@
>   # define SCHED_WARN_ON(x)      ({ (void)(x), 0; })
>   #endif
> 
> +#define IDLE_CPU_DELAY_NS        1000000        /* 1ms */
> +#define IDLE_CPU_DELAY_MAX_RUNNING    4
> +
>   struct rq;
>   struct cpuidle_state;

I have run some standard micro-benchmarks to test this patch on a 2 Socket Bergamo System
which has 256C/512T (2 X 128C/Socket). The following are the results:

base                            : 6.5.0-rc4
base + extend-idle              : base + Original patch which has change to to extend idle state by 1ms.
base + extend-idle + nr_running : base + updated patch which contains both extend idle and nr_running limit.

========================= hackbench  =========================
Test:             6.5.0-rc4 (base)        base + extend-idle   base + extend-idle + nr_running<=4
  1-groups:        19.95 (0.00 pct)        15.92  (20.20 pct)      15.30  (23.30 pct)
  2-groups:        21.33 (0.00 pct)        23.00  (-7.82 pct)      19.70   (7.64 pct)
  4-groups:        22.57 (0.00 pct)        30.02 (-33.00 pct)      26.74 (-18.47 pct)
  8-groups:        24.68 (0.00 pct)        32.54 (-31.84 pct)      28.27 (-14.54 pct)
16-groups:        31.20 (0.00 pct)        32.47  (-4.07 pct)      27.70  (11.21 pct)

Observation: Hackbench shows improvement with lower and higher number of groups still
it shows dip in performance for middle order.

========================= new_schbench =========================
Metric: wakeup_lat_summary
#workers:  6.5.0-rc4 (base)     base + extend-idle     base + extend-idle + nr_running<=4
   1:      30.00 (0.00 pct)        33.00 (-10.00 pct)      33.00 (-10.00 pct)
   2:      26.00 (0.00 pct)        32.00 (-23.07 pct)      33.00 (-26.92 pct)
   4:      26.00 (0.00 pct)        32.00 (-23.07 pct)      32.00 (-23.07 pct)
   8:       9.00 (0.00 pct)        10.00 (-11.11 pct)       9.00   (0.00 pct)
  16:       8.00 (0.00 pct)        10.00 (-25.00 pct)       9.00 (-12.50 pct)
  32:       8.00 (0.00 pct)         9.00 (-12.50 pct)      10.00 (-25.00 pct)
  64:       8.00 (0.00 pct)        10.00 (-25.00 pct)      10.00 (-25.00 pct)
128:       8.00 (0.00 pct)        11.00 (-37.50 pct)      12.00 (-50.00 pct)
256:     102.00 (0.00 pct)        48.00  (52.94 pct)       50.00 (50.98 pct)
512:   20704.00 (0.00 pct)     23200.00 (-12.05 pct)   23200.00 (-12.05 pct)

Metric: request_lat_summary
#workers: 6.5.0-rc4 (base)       base + extend-idle     base + extend-idle + nr_running<=4
   1:      6712.00 (0.00 pct)      6744.00 (-0.47 pct)      6760.00 (-0.71 pct)
   2:      6792.00 (0.00 pct)      6840.00 (-0.70 pct)      6872.00 (-1.17 pct)
   4:      6792.00 (0.00 pct)      6840.00 (-0.70 pct)      6856.00 (-0.94 pct)
   8:      6776.00 (0.00 pct)      6824.00 (-0.70 pct)      6872.00 (-1.41 pct)
  16:      6760.00 (0.00 pct)      6792.00 (-0.47 pct)      6872.00 (-1.65 pct)
  32:      6808.00 (0.00 pct)       6776.00 (0.47 pct)      6872.00 (-0.94 pct)
  64:      6808.00 (0.00 pct)       6776.00 (0.47 pct)      6872.00 (-0.94 pct)
128:     12208.00 (0.00 pct)      11856.00 (2.88 pct)     12784.00 (-4.71 pct)
256:     13264.00 (0.00 pct)     13296.00 (-0.24 pct)     13680.00 (-3.13 pct)
512:     84096.00 (0.00 pct)   100992.00 (-20.09 pct)   110208.00 (-31.05 pct)

Metric: rps_summary
#workers: 6.5.0-rc4 (base)     base + extend-idle     base + extend-idle + nr_running<=4
   1:       305.00 (0.00 pct)        302.00 (0.98 pct)         296.00 (2.95 pct)
   2:       607.00 (0.00 pct)        601.00 (0.98 pct)         593.00 (2.30 pct)
   4:      1214.00 (0.00 pct)       1202.00 (0.98 pct)        1190.00 (1.97 pct)
   8:      2436.00 (0.00 pct)       2420.00 (0.65 pct)        2372.00 (2.62 pct)
  16:      4888.00 (0.00 pct)       4872.00 (0.32 pct)        4808.00 (1.63 pct)
  32:      9776.00 (0.00 pct)       9744.00 (0.32 pct)        9680.00 (0.98 pct)
  64:     19616.00 (0.00 pct)      19488.00 (0.65 pct)       19360.00 (1.30 pct)
128:     38592.00 (0.00 pct)      38720.00(-0.33 pct)       38080.00 (1.32 pct)
256:     41024.00 (0.00 pct)      40896.00 (0.31 pct)       38976.00 (4.99 pct)
512:     36800.00 (0.00 pct)      35776.00 (2.78 pct)       33728.00 (8.34 pct)

Observation: new_schbench is showing regression in wakeup latencies while request
latencies and rps latencies shows no change except for highly loaded case in request
latency.

========================= schbench =========================
#workers: 6.5.0-rc4 (base)       base + extend-idle   base + extend-idle + nr_running<=4
   1:      185.00 (0.00 pct)        181.00 (2.16 pct)       181.00 (2.16 pct)
   2:      191.00 (0.00 pct)       192.00 (-0.52 pct)       189.00 (1.04 pct)
   4:      191.00 (0.00 pct)       192.00 (-0.52 pct)      194.00 (-1.57 pct)
   8:      218.00 (0.00 pct)        198.00 (9.17 pct)       200.00 (8.25 pct)
  16:      226.00 (0.00 pct)        225.00 (0.44 pct)       224.00 (0.88 pct)
  32:      537.00 (0.00 pct)        537.00 (0.00 pct)      539.00 (-0.37 pct)
  64:      605.00 (0.00 pct)       621.00 (-2.64 pct)      619.00 (-2.31 pct)
128:      765.00 (0.00 pct)       795.00 (-3.92 pct)      781.00 (-2.09 pct)
256:     1122.00 (0.00 pct)      1150.00 (-2.49 pct)     1150.00 (-2.49 pct)
512:     2276.00 (0.00 pct)      2476.00 (-8.78 pct)     2404.00 (-5.62 pct)

========================= tbench =========================
Clients:     6.5.0-rc4 (base)     base + extend-idle     base + extend-idle + nr_running<=4
     1       386.07 (0.00 pct)         390.13 (1.05 pct)       463.49 (20.05 pct)
     2       718.40 (0.00 pct)        856.37 (19.20 pct)       799.31 (11.26 pct)
     4      1399.34 (0.00 pct)        1514.03 (8.19 pct)       1482.01 (5.90 pct)
     8      2716.56 (0.00 pct)       3000.02 (10.43 pct)       2823.23 (3.92 pct)
    16      5275.97 (0.00 pct)        5468.17 (3.64 pct)       5430.77 (2.93 pct)
    32     10534.37 (0.00 pct)      10442.13 (-0.87 pct)     10386.92 (-1.39 pct)
    64     22079.03 (0.00 pct)     19161.30 (-13.21 pct)    16773.73 (-24.02 pct)
   128     41051.13 (0.00 pct)     29923.57 (-27.10 pct)    22510.13 (-45.16 pct)
   256     55603.43 (0.00 pct)     43203.67 (-22.30 pct)    40343.17 (-27.44 pct)
   512    130673.33 (0.00 pct)     76581.40 (-41.39 pct)    69152.47 (-47.07 pct)
  1024    133323.67 (0.00 pct)    114910.67 (-13.81 pct)   107728.67 (-19.19 pct)
  2048    143674.33 (0.00 pct)    123842.67 (-13.80 pct)   107202.00 (-25.38 pct)

  Observation: tbench is showing dip in throughput for 64 clients and onwards.

  ====================== stream 10 RUNS ======================
Test:     6.5.0-rc4 (base)        base + extend-idle   base + extend-idle + nr_running<=4
  Copy:   354190.51 (0.00 pct)    356650.82 (0.69 pct)    353287.34 (-0.25 pct)
Scale:   355427.44 (0.00 pct)    356686.34 (0.35 pct)    354406.79 (-0.28 pct)
   Add:   373800.46 (0.00 pct)    376610.56 (0.75 pct)    374609.00  (0.21 pct)
Triad:   374697.25 (0.00 pct)    377635.98 (0.78 pct)    375343.44  (0.17 pct)

====================== stream 100 RUNS  ======================
Test:     6.5.0-rc4 (base)        base + extend-idle   base + extend-idle + nr_running<=4
  Copy:   357922.89 (0.00 pct)    356560.50 (-0.38 pct)    356507.22 (-0.39 pct)
Scale:   358118.38 (0.00 pct)    357435.86 (-0.19 pct)    358033.29 (-0.02 pct)
   Add:   375307.34 (0.00 pct)    376046.70  (0.19 pct)    375586.33  (0.07 pct)
Triad:   375656.40 (0.00 pct)    376674.43  (0.27 pct)    376581.95  (0.24 pct)

========================== netperf  ==========================
  Clients:         6.5.0-rc4 (base)     base + extend-idle     base + extend-idle + nr_running<=4
  1-clients:      114299.07 (0.00 pct)    110695.40  (-3.15 pct)   111533.30 (-2.41 pct)
  2-clients:      114130.01 (0.00 pct)    110192.51  (-3.45 pct)   111682.01 (-2.14 pct)
  4-clients:      109126.45 (0.00 pct)    107275.60  (-1.69 pct)   109574.77  (0.41 pct)
  8-clients:      111209.21 (0.00 pct)    104360.40  (-6.15 pct)   106518.41 (-4.21 pct)
16-clients:      102955.20 (0.00 pct)    100968.38  (-1.92 pct)   101897.25 (-1.02 pct)
32-clients:       98537.18 (0.00 pct)    103018.09  ( 4.54 pct)   103917.70  (5.46 pct)
64-clients:      103619.68 (0.00 pct)    100376.37  (-3.13 pct)   102651.24 (-0.93 pct)
128-clients:      98536.55 (0.00 pct)     77845.69 (-20.99 pct)    98566.87  (0.03 pct)
256-clients:      51934.45 (0.00 pct)     52844.10   (1.75 pct)    53562.99  (3.13 pct)

I have also tried the same experiment on one socket Genoa system with 96C/192T. On that
system also I am seeing similar behavior.

Can you share your build config just in case I am missing something.

> 
> And using it now brings the hackbench wall time at 28s :)
> 
> Thanks,
> 
> Mathieu
> 
>>
>>>>>        struct task_struct    *stop;
>>>>>        unsigned long        next_balance;
>>>>>        struct mm_struct    *prev_mm;
>>>
> 
--
Thanks and regards,
Swapnil
