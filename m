Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19A978F3E6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 22:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243974AbjHaUXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 16:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbjHaUXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 16:23:34 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B583CFE
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 13:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETDT6Bf2O0WqzJpbvXNm+GVOZb70yusaelJzaFhMt7ID9r2qjSaadiHB5MT7D+ZzgJbOpAaodYJ0uGRWFvSxXSaRj9JwYQZSKp8brMod49qTEpIobXAePAe0g+3pi2lbV0uiF68HpEFQXUQUi5oJiJGl9mArvY/ejKP3u5h+9HgCI9mSVZBdrp7raDUUIUYfQU1J++9j1QW1v2pBGQP5Z4IefFuEr+0LeAsGOt2YbXtDDS+nTK9Usvqa1H0zaiSOKFYcQ/zDytXGLBzhwuhR41G1dUVhDjMLOkO2I1upQ9GWceOK8XVcfPiDBFnE5rFSPHdGvSKUlT+O84EoeZml0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoDY73X1npkluuBB/M5jH5AvpMQsy8oblIPS/+Z4G8s=;
 b=dRoyo3QBGMcMiWMzZEcpReGyziknkFjLNONGliqAZkqDw2HYmV4wWGhbT9map5mPZkW0IC4sBoY9RJW9RFY3U9yhIk1Tue9v6Lx/uCoJbTlDJyvGeSZSrYNQjwCrm2Y6TFPkQ4WbNS5r6t0lVgZfS2FCHLm7T4cLWPAmoBJzw9743OpIIPdFQnS0u483grMsiQQq0NOecxWAAU+ecbalKv5j5un8aUUmdYPRJJxtqyh5vF1cIZtgR32xMz/CmzovoHfaO8Kogl8UrzO3qf1QxHrrhNvr0BrOum+iqYeDIQXaGhp3gvZyBUpcKHkyGe+BFYYWS+akjr+3tdhGrJCdxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoDY73X1npkluuBB/M5jH5AvpMQsy8oblIPS/+Z4G8s=;
 b=yh0fjLNE57sI77LW9AisdA2jlKL1jZaBZEDplG2SU14p9rgQeUpHooKUsckwTBwB/RX/dAS0CPD9yzm115xLK2Qai/NpAg/pbgLYng7e9AU5iYfx5tqT80wj3Wc3z0v3ZOUtPCPI+4IFNpJ1X0v+pwGGA5j+d2xdnIQ4FicBwwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by MW4PR12MB7483.namprd12.prod.outlook.com (2603:10b6:303:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Thu, 31 Aug
 2023 20:23:28 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb%6]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 20:23:28 +0000
Message-ID: <350639fb-a428-7d94-b13b-7a33e68b7b09@amd.com>
Date:   Fri, 1 Sep 2023 01:53:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC PATCH 3/3] sched/fair: Add a per-shard overload flag
Content-Language: en-US
To:     David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, gautham.shenoy@amd.com,
        aaron.lu@intel.com, wuyun.abel@bytedance.com, kernel-team@meta.com
References: <31aeb639-1d66-2d12-1673-c19fed0ab33a@amd.com>
 <20230831104508.7619-1-kprateek.nayak@amd.com>
 <20230831104508.7619-4-kprateek.nayak@amd.com>
 <20230831191103.GC531917@maniforge>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20230831191103.GC531917@maniforge>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::32) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|MW4PR12MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a996592-9e09-4c6b-e0a3-08dbaa6022a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3f2BgIqmzFsekf6tU761tJt64O0KMRS93KWjnN5T4q32T1LEruYyAGsjMjNt5zStbcsbQMrE5E6fLaAP3nbn6axhpcCwhJbftzAbnxr/nVwCFunVG/so6AGNEuCiPfW3yLXscViSBRXz/8KF8S0Z475Kr59shwL38emdMR7hy6lJTRo+kW1vwxGpEaRiEF30ABiI28nuLCCvtVT7EH6O548XlIYrxkVTm40/pS2g38VYBkMY45CTbElRnPx+N2HMvPTnaWT6WRvGvfuFdCFWk3Gnzs11EeevD0nAZStEPoIRr+iBj/677VJ7zHfnj5xuBo/iTn7TSi8Y5aq0/r5C0Fl69Z5reLcqjBq1C7L40Oc+O9rwWW+p4F5RVnNZNdnQhUSCvSQuTmZ73z0LKoUTMQH+RNIfT9mpv50XFLCfSitqs9ewYnSauxCnEM4EwrzGD4DPG8R80YXY9GQsjulVNjVZid7J7MLKVtxuJCH7m+0Xo3mDAXoiG6p00ipDQ7uFlMIb9/qnZq5TaOy0AhfWbXY0NkF44+Qqo3bitZwkjb49dq+0sl5lceNGVus74Uda8gMcw47h5gvHypb8kJy8ztQNt1CqUX4+aqPmNrv9LByB8+XMXNBCFExkAJ5ZOoK1X5CG433ujWOTIBNOmcb63DdHJlVdKcx8/7XiFRQUCx0ZKVtxY1VDpkRy7YTvQHXK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199024)(186009)(1800799009)(2906002)(6506007)(6512007)(6666004)(6486002)(53546011)(478600001)(6916009)(966005)(26005)(2616005)(5660300002)(66946007)(7416002)(8676002)(316002)(41300700001)(4326008)(66556008)(83380400001)(66476007)(36756003)(31696002)(38100700002)(86362001)(8936002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUJnWnR4Mlc5elVXNXZrVS9pNFpMOUtPZXJXclVOdk1kNUlaUkhVRk9xamFZ?=
 =?utf-8?B?cVo5b3pENG8xWUJkSU5KQmx4SXJMVVJvM1VrTGhNTGkwWWxPWUQzVDNPMjds?=
 =?utf-8?B?VVhha1AxaEtHTmE1OGxhK2pWT2IrbDh6bmNONHBEOHhaN084ZlcxZXhOS25Z?=
 =?utf-8?B?SklHVUtCUGo1eFNadkpsbm5PWXdSUDlUZVQ4ZWc4VmNWMUNtK1VGNncxenhz?=
 =?utf-8?B?R0VFeFJTZktxcFlZTlViWDZ0b2tJUHVlM1lxVEY1RDF0aHk2dWFtODNVMmdn?=
 =?utf-8?B?VEV0eUF6NlJkZDlmNHZpMlgxcTdRM01UUjFmVHV0WGI2Sy9DYzdxVEJiQTRn?=
 =?utf-8?B?SEQ5ZjVQaW9uL2poOVZpdSt6RGRUOFhyRXZhUWphTzJnNFZhNE1YbnZXRUpv?=
 =?utf-8?B?V2JKYUFpQ0p3NlFVYVhtd1pnVTd0Tk9ybGo0NTZtak90ZzBOcFVXT25XcURS?=
 =?utf-8?B?NU9ZUjZLVW4vRWhiQmJFOVZNdWVVRGMxUmxwYzRCc01ldXdNalNkUlVKcEpM?=
 =?utf-8?B?NWxRb2hKeXhvQTdPbkMwM0dlczBPZlB1cGh3amdYZ3p5QnBoZnJBT2ZUNXM1?=
 =?utf-8?B?WXFLL0ZSeWt6cnNRSUpCeDdKNkZEWlZQSEFJcVJoTThxS1dURXE3d25QOWJB?=
 =?utf-8?B?WWZwdU1XNmxmZTcvazErMWRtdjlnZGswYlQ3SHNqVmVieTZPUXVpK0dJdVN4?=
 =?utf-8?B?enZ6c05weXNwYzJuWFVnWklXQjdaVDMzM1VrNEd0VktzS3lXQ3dUK2tzbWR5?=
 =?utf-8?B?eFBOemZMbHI3elh4SHl4TzZUMG9zaUlFdEFWTCsvR3JpbW9DMWthQnVXQkpz?=
 =?utf-8?B?dGlHZmpNNkRqS3ByVHd6dVVZdmQweXoxMVRaMFVnQVBVejU5Nk5Na0xhcU00?=
 =?utf-8?B?bDFvUXFtRDVibUs3enJlUnhIT2U2Yy9XeFQyamZNNDhrMDZxTHVSWTJBbVgv?=
 =?utf-8?B?M1RNWEVOWWE1MzUwVnErYUN0ZjZoRXNQUS9UYlNDU29KdUQyb0ZpMDBPOXo4?=
 =?utf-8?B?ZmJac0NvQjkxaG96YVJiM0V6eWJOaTNjenEwUmxLbUpsbUtzU2VLMmFGMG1D?=
 =?utf-8?B?VDZWR2EwekJFSU1ydWphL3FMcERBM01RNWxDaG0xTkF4RU9hV1Zqa2VjRzBh?=
 =?utf-8?B?eDBONktjMEhvRGw0UGdnc1hXV1l1TmorRFp0TTc1TWhINXVIUFdDWUFFenho?=
 =?utf-8?B?TGcvMDRaZUxVSG1kTjVXWkhWUW53UzlKc25WSnc3TnJlVGgrRG44UkdiMEQ5?=
 =?utf-8?B?M3pvNG5qY3hrYTZVL0YzQ0kxTCtEY2NhRnBQTDRXdHF4c0VoRDFOUUNZejB3?=
 =?utf-8?B?MEtyRzhlczlZTW4wNm9aRmVZdzV0QkNsMmh6MzFCVUpBT2lWMTRqbWNDcmNK?=
 =?utf-8?B?ZjNiWktWQXQvd0c5VGdzdmt4dnpEYklDY2ZEdDdkNDdMNk5XdFZaKzVHckgx?=
 =?utf-8?B?SzhTeGF6eitZWWJITDdReTdvU3crNzY0TGdYU1NsdityODhtTWRYeENuK3Ft?=
 =?utf-8?B?UnNhbUM0OTZFdm80YjFFbDNJUldYZWI2dE1RbTBQRGZ0ZC9INm83elFIdm5k?=
 =?utf-8?B?OE1iaWVXbStMMjNDYnhHb0xWSTBrbDR2bDBxQjFpWVBjbkYrT2tYanZuSVc0?=
 =?utf-8?B?NnI1N2NTSkw2eVF4eUFLbHF4bGxjTjZOQlIvVXpsbTNqMVV5ZmpkWUtmWExn?=
 =?utf-8?B?ZEhqSG8vT3NlY2lEZnQ4eUZoRjlKQ3pUWUxSSUx3bGRKUG9JZzI0UDNFclJK?=
 =?utf-8?B?eE9FZzFUc0ZkY29oV3hxb1gvWlRtelFWMVBjc2xZbjhwZHFqeXlSMTVqWmcv?=
 =?utf-8?B?Qmt5dkZrSmVSWXl4a0NobzhDKzJodkwrNTFMRjhVWENRdVdrMlFzK2RtMWl6?=
 =?utf-8?B?Rkx5aFJEbmdoVEJCWDdWQm1uVlp3R0ozcGkrUU9KQkowY29GUFBBMmRZN2Zo?=
 =?utf-8?B?RjUyVzFidWVrK05sMm9wVlFFamlmUHZaZzRTalB5dytSbi9kSE1HNmd0WkZT?=
 =?utf-8?B?ZU1TZmVSZWhneWtsRWdwZ2dzRGZhYUJZa1ZuVmcycE00T3NtQjVZbFdEalVy?=
 =?utf-8?B?UzAvdldnc2llSVBBdzRSK3IxZTlISCs3UG9MYStURlNvY1FOYXdOWEUxODR2?=
 =?utf-8?Q?S2Wg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a996592-9e09-4c6b-e0a3-08dbaa6022a7
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 20:23:28.2036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xdUgHwu/atc1reQx9bQpE3Iteq+z07O+ElBK7lfKkuz+BnlSaFiP2m5ELs6iS3qB/G17NV8dBnjQVi9jpTc2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7483
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

On 9/1/2023 12:41 AM, David Vernet wrote:
> On Thu, Aug 31, 2023 at 04:15:08PM +0530, K Prateek Nayak wrote:
> 
> Hi Prateek,
> 
>> Even with the two patches, I still observe the following lock
>> contention when profiling the tbench 128-clients run with IBS:
>>
>>   -   12.61%  swapper          [kernel.vmlinux]         [k] native_queued_spin_lock_slowpath
>>      - 10.94% native_queued_spin_lock_slowpath
>>         - 10.73% _raw_spin_lock
>>            - 9.57% __schedule
>>                 schedule_idle
>>                 do_idle
>>               + cpu_startup_entry
>>            - 0.82% task_rq_lock
>>                 newidle_balance
>>                 pick_next_task_fair
>>                 __schedule
>>                 schedule_idle
>>                 do_idle
>>               + cpu_startup_entry
>>
>> Since David mentioned rq->avg_idle check is probably not the right step
>> towards the solution, this experiment introduces a per-shard
>> "overload" flag. Similar to "rq->rd->overload", per-shard overload flag
>> notifies of the possibility of one or more rq covered in the shard's
>> domain having a queued task. shard's overload flag is set at the same
>> time as "rq->rd->overload", and is cleared when shard's list is found
>> to be empty.
> 
> I think this is an interesting idea, but I feel that it's still working
> against the core proposition of SHARED_RUNQ, which is to enable work
> conservation.

I don't think so! Work conservation is possible if there is an
imbalance. Consider the case where we 15 tasks in the shared_runq but we
have 16 CPUs, 15 of which are running these 15 tasks, and one going
idle. Work is conserved. What we need to worry about is tasks being in
the shared_runq that are queued on their respective CPU. This can only
happen if any one of the rq has nr_running >= 2, which is also the point
we are setting "shard->overload".

Now situation can change later and all tasks in the shared_runq might be
running on respective CPUs but "shard->overload" is only cleared when
the shared_runq becomes empty. If this is too late, maybe we can clear
it if periodic load balancing finds no queuing (somewhere around the
time we update nr_idle_scan).

So the window where we do not go ahead with popping a task from the
shared_runq_shard->list is between the list being empty and at least one
of the CPU associated with the shard reporting nr_running >= 2, which is
when work conservation is needed.

> 
>> With these changes, following are the results for tbench 128-clients:
> 
> Just to make sure I understand, this is to address the contention we're
> observing on tbench with 64 - 256 clients, right?  That's my
> understanding from Gautham's reply in [0].
> 
> [0]: https://lore.kernel.org/all/ZOc7i7wM0x4hF4vL@BLR-5CG11610CF.amd.com/

I'm not sure if Gautham saw a contention with IBS but he did see an
abnormal blowup in newidle_balance() counts which he suspected were the
cause for the regression. I noticed the rq lock contention after doing a
fair bit of surgery. Let me go check if that was the case with vanilla
v3 too.

> 
> If so, are we sure this change won't regress other workloads that would
> have benefited from the work conservation?

I don't think we'll regress any workloads as I explained above because
the "overload" flag being 0 almost (since update/access is not atomic)
always indicate a case where the tasks cannot be pulled. However, that
needs to be tested since there is a small behavior change in
shared_runq_pick_next_task(). Where previously if the task is running
on CPU, we would have popped it from shared_runq, did some lock
fiddling before finding out it is running, some more lock fiddling
before the function returned "-1", now with the changes here, it'll
simply return a "0" and although that is correct, we have seen some
interesting cases in past [1] where a random lock contention actually
helps certain benchmarks ¯\_(ツ)_/¯

[1] https://lore.kernel.org/all/44428f1e-ca2c-466f-952f-d5ad33f12073@amd.com/ 

> 
> Also, I assume that you don't see the improved contention without this,
> even if you include your fix to the newidle_balance() that has us skip
> over the <= LLC domain?

No improvements! The lock is still very much contended for. I wonder if
it could be because of the unlocking and locking the rq again in
shared_runq_pick_next_task() even when task is on CPU. Also since it
return -1 for this case, pick_next_task_fair() will return RETRY_TASK
which can have further implications.

> 
> Thanks,
> David
> 
> P.S. Taking off on vacation now, so any replies will be very delayed.
> Thanks again for working on this!

Hope you have a great vacation :)

> 
>>
>> tip				: 1.00 (var: 1.00%)
>> tip + v3 + series till patch 2	: 0.41 (var: 1.15%) (diff: -58.81%)
>> tip + v3 + full series		: 1.01 (var: 0.36%) (diff: +00.92%)
>>
>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> ---
>> [..snip..]
>>

--
Thanks and Regards,
Prateek
