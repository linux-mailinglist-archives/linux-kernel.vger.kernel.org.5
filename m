Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C5F7D574D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343961AbjJXQES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjJXQEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:04:16 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E1F83;
        Tue, 24 Oct 2023 09:04:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anspYxfqad46VwXlp1rlXBQ/147czMHTaHFdCBkmjpyq6LJ7KHhVLpLII4G1dILZq/ZxJUAHzg8tkt4SEZQqeEkq5RpzXnXmQmF0bB3ovDRB2rxfBGaD6XFlmwH1mgLi81UOHH1h0RvUCVwyBgWuNABKyfgkfr/MOTJXzVcXZSJjUq0N1CW1TNgEx3sMU0n/988M0BUM+ZqVfTcW7ScW/5dzopjwmJUQ8K96VJLV55xtoTIFeEpmy96cOspU5n64Jc2KUCy1TEX+eWAggKAl85le2M3c8cVGkSq3XqcNp/NuwVXTv+16p7FVpmVGgQScv8VOCbQ0kY0IS/P/B3639Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHSpquNREt5MhdVa7/W5jIGc6NdaZdaYOBrnDOuVEVU=;
 b=SCyOwJHg13XAdLRuIh3HaWotrooyO2Uc8cEZgHNQJxFSAwsJGQQCKY7YByy3eSWsT/afuJBrCF5qFzmxUcWRKw7w4mqAiYyW3TX+bF757obVnRquQ1ybd0zI1zwndCtKYzxwXDgReGtUWW0ds9PErmvTb863fxPnw2mo28+YFpmHnCFO1UCNizGU0bflvmXgyxUcnbRhJkwxJR+dVp0xik0Ay0Xk7GbHa6DkNnUKw7QZpf5K2rZNW/zVSRak4ZDfI4vFyEWIk9NuXXs6x/NvLw2LN5GLnNBqZJQ4vsjhILu6Wwnbg6mBry4NiVSjzS5QL8pmD62V9Nmk8/mS1b9Ykg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHSpquNREt5MhdVa7/W5jIGc6NdaZdaYOBrnDOuVEVU=;
 b=kHFGB+vzlX+BVeVbGFjHtv8h7oEcjTL2hwzR8jgQl/LWIqjn4CksMWyysLr8LPgoLwG182TUn1UeEdnOQDOF3HNpJjdkeam2b9kfibg2p3FCaqoEh5lEsHAVspVMJ7Ru5uA7iR6P+nhv3N28Gu17m5+UqB8CyCR1YwCTiXm8w8U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BY5PR12MB4949.namprd12.prod.outlook.com (2603:10b6:a03:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 16:04:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%4]) with mapi id 15.20.6907.022; Tue, 24 Oct 2023
 16:04:09 +0000
Message-ID: <47518940-2803-4a6b-88fd-8cfc872b4219@amd.com>
Date:   Tue, 24 Oct 2023 11:04:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf/x86/amd: Don't allow pre-emption in
 amd_pmu_lbr_reset()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org,
        pavel@ucw.cz, linux-perf-users@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20231023160018.164054-1-mario.limonciello@amd.com>
 <20231023160018.164054-3-mario.limonciello@amd.com>
 <ZTd6BYr17ycdHR2a@gmail.com> <38ea48b4-aaba-4ba4-84a1-e88d6cb9df94@amd.com>
 <20231024155939.GF33965@noisy.programming.kicks-ass.net>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231024155939.GF33965@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR18CA0028.namprd18.prod.outlook.com
 (2603:10b6:806:f3::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BY5PR12MB4949:EE_
X-MS-Office365-Filtering-Correlation-Id: b89e2414-cab7-4da0-67fe-08dbd4aadb3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: imxh6DoLnH7L/tCNjiC6p0lHD+SBgxFzaWA819bpsqg1XRRHbMWl2JKvK+QRdyZxTjJxbpf0VVPqleD1ESFOvgCgRWB19GeQOv3AANnplzM4xNt6OOeI40HlChJwD25KSbNQDYDxE/cHHRO5IlnXu5XKoO/coUQ8P5Ipc3klje3seiJ059tCmDIW6o83S9LzmONnx8XLFUcLW+l0kNMPfDuahIayiC55rnqX7AWZj8Z2nvVkK5QeKO2YmoZhBeWpvs6uOPLUcvs76i27DiUHoOsMIJUL17G9E6eGMSEn8pyAs9AYwyFvubIp5AzwWIIJaj1ChrW1RmYtwQZFv5E2+4j0m9pgvMeiN1sHeGmq51kzWSTBcppBIGX4z2ya3rzPoEe0uUaOXu0VS//Q2jgeQQiPYH943CmdUYKlh6I7Jj+6tYJOfcBZOi9+tWz3qLw38rZz1HNZAx5T5RQXtmQs3aYdDSTqLk2TQ6EThpCf+hic+XwE/ncNMzDVcToKLost0o0IXrSc+gHoerpF6jXHmTklcpgR9BGecCbKNcR3g8WHIVaXUy2RpGI/8RShvDAemTZ1usBqbHUGZpDPRlNavGn8rtmcwnynI5uACW/1W9cxKu0MHhA9nZOwdR5z4bXXGD8tWuRPCFnuYd84pjTHSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(31686004)(6512007)(53546011)(6506007)(6666004)(478600001)(6486002)(38100700002)(31696002)(86362001)(36756003)(2906002)(7416002)(54906003)(83380400001)(2616005)(26005)(66476007)(316002)(66946007)(6916009)(44832011)(5660300002)(66556008)(4326008)(41300700001)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVlkUUZ4RE53M25sV3hJazZWUStmTjA1SDFvRzFyMnZzRk8zTndZa2I2TnFX?=
 =?utf-8?B?VE1MMlpCVGprNiswTDhnU2l2bU9HdkpkclowTUg3ZDdRbEg5YnB6RGN1TVpI?=
 =?utf-8?B?elpScHlTMWFIWG9ZNGNNbDJoZDJEcmkwQmtGWDA0QWtHUng5UDc5WDY3ZGZ6?=
 =?utf-8?B?c29zSkJCMWEvVVFUcUpSZUpHV1RPOUpCL0VaMGFEeFF6YUg4QlBzS29tYThi?=
 =?utf-8?B?bHVTTTY3eWxmaVMxNXhMc3kyd3QrQzUzNkVmZUNIT2QyWDcxNDBRR2xrVUNn?=
 =?utf-8?B?NE1NWFJSeWp6dUlDUng2UUZRU3hYRFJlZzBPa3RuaFFSZXBXdXlWMytHVXY0?=
 =?utf-8?B?YjFOK2p4NGdxQ3RJQkRQejI2bmhWam1uOXJvV3kwMGlTNGJlajdwejJwcElP?=
 =?utf-8?B?N0h0T0hJRUVBUjVhNk1UTXhqMmJUb1RjODgvSUNlWXo0MnRpVjdtQVNKLzdP?=
 =?utf-8?B?VHJpWTJtR1FKNFNCL0x0RWxXQ1AvUHpTZUJqL2Z2QWZLQzRuY21FVUtCSGFq?=
 =?utf-8?B?YTUzSkxUdDlPYnREeitlUlB6Z3QxZTVZRHUwKzc5aldLOHNmYUs1d2lYaHFw?=
 =?utf-8?B?eU1nUEs2YkpzaEVIeUZaMHhpbWN6Qjkzb0pxeXAxdkZ0ekRzV3lrUkU0dC9m?=
 =?utf-8?B?dE1TeXgvcm84N1RsTjZSWDdRZWQycEhibXI3aVVyc1BBb01McW9odnRzV1lO?=
 =?utf-8?B?Q2VaM2VZajNNRk1GakcvZWJNbmNUcXM4bmswMjhoVFJaYS9OOE9LYWk3dHUv?=
 =?utf-8?B?OXNjS2laVzUxMlFpZWcxenRQQ2NCZ25yNjBnSW9GYnk3Y0VxTlBOTzFZbTB1?=
 =?utf-8?B?Y3pVZkNSR2o3SHRXdmJvTjNhZmhBVFVRbUVwUU5FeXU5MTlmUWx3ZHkybE5i?=
 =?utf-8?B?eUhsRVJRN0lnMWYvM1hsVHJQbDRBMTlTOTdDdHd1TVFzRDc1b3M1Y2lyQTY5?=
 =?utf-8?B?aHlDNjVsZHJ3VVQyVVNJYm5uR2tMbFg0bU5aS0ZrMlIxcU1EZ1hmQTJVd2dh?=
 =?utf-8?B?M0xtRHNDVDJmVWNCSkhxajlaZjRnclgzdk01cHRtVjZLeFpmdWFBYmo3UGov?=
 =?utf-8?B?ME43VGFOdFErLzhBUmxWUVlxS2VJVmk2S0IrVDBna2R1dnB0SHZ6SnJscnox?=
 =?utf-8?B?R3dISnczaGRvbU5zMWVmR0g2SWdvL1pKdUZyeG1qdmh6bHNPeUlrb2pFUjJM?=
 =?utf-8?B?Q25LYndOWEVCNisvdHByMmMzYjE2T3hhQXJhbmpNY2x2RHFRYlI2L3ZLRlgz?=
 =?utf-8?B?NEN1aWNBS3V2SW5EM2w0TS9CRGNsRlczOXd4K21hU2k0aHBvT0t0ZGl2SXRG?=
 =?utf-8?B?S0pVcDYxK280SElIZmtTUlhDYmlYaVRseGFHZFhNbk5vUXgrNmlvaVJ5eUdV?=
 =?utf-8?B?YThFYk00dzFBSFlkQXQySElKYWNBRWlPUmYvbEdNYjE1TGFFZG5EdHYycGpY?=
 =?utf-8?B?K0NDTnhBaG1kRTVDd2N6a0VmNUVVNEVsbEl6T1p4ZjBMVXRSRVVhNGY5bGNG?=
 =?utf-8?B?R3oxZGR5T1pTTnhuTEZCSGwrTk90NXNpYVlQOVoweHNDcDhZQVBiY2VtUFpU?=
 =?utf-8?B?SjkzMzlFOFpoNGFqRmRubFg0QVVML2VTSzR2bUtnTmtzOS8xbnlxaHZpd3Zq?=
 =?utf-8?B?NW51N0x2czdKQS82U3BlOWt5UWZwOFBTaklCYnRkb1ZYekR4cVBvbTFCelB1?=
 =?utf-8?B?NDJuL1FjODVVKzlndGhRMkk5RzRIYXpjZk9PcUJYSjQyNThVWFBBQytkYWV1?=
 =?utf-8?B?bzRDNEczOWlYMVBZanRDU2tQUEk2VW9hR2ZObEd3VEMyQkwzQ2NZdU1Hais1?=
 =?utf-8?B?OURrRm5Ra0tEalhCQUhZc0loQnAxRTh3TUZtaVRtdzJ0Z3Bac3YzNE9ZVkFt?=
 =?utf-8?B?R3JPandkdW4zL1lCRE5GRFBpdndJUkFyc2ZIN0NrS01JOGNSOFNpK2ppaGk2?=
 =?utf-8?B?QWl4K1Qwa1R5WVdWUHFiRER2TjgrcFRYR2V6UDRudTh5dFEyd1gwMk90MHg4?=
 =?utf-8?B?bmpIcld0VldjMmJ3bGRhY2VNbVNwOHIrZkhBbzh4TEswajVQTkppVUJyZXlN?=
 =?utf-8?B?Sll3ZzQ1ZGI5ZEh2dU1BZGVtdEdQMUVlMTRwcGlRazE3N1hDei9NR1RHVDFU?=
 =?utf-8?Q?l4c0nt6YRLvoh+2Fbyx44JbKq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89e2414-cab7-4da0-67fe-08dbd4aadb3a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 16:04:09.2182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtHlTIS0POFwMhtHE9McETHpX9rrHqqG9mLafU3jpbW3LSJgAvbfTsNCFK1BzDXH2LiDVx8aFLb3K1xZZXyHgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4949
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/2023 10:59, Peter Zijlstra wrote:
> On Tue, Oct 24, 2023 at 10:32:27AM -0500, Mario Limonciello wrote:
>> On 10/24/2023 03:02, Ingo Molnar wrote:
>>>
>>> * Mario Limonciello <mario.limonciello@amd.com> wrote:
>>>
>>>> Fixes a BUG reported during suspend to ram testing.
>>>>
>>>> ```
>>>> [  478.274752] BUG: using smp_processor_id() in preemptible [00000000] code: rtcwake/2948
>>>> [  478.274754] caller is amd_pmu_lbr_reset+0x19/0xc0
>>>> ```
>>>>
>>>> Cc: stable@vger.kernel.org # 6.1+
>>>> Fixes: ca5b7c0d9621 ("perf/x86/amd/lbr: Add LbrExtV2 branch record support")
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>    arch/x86/events/amd/lbr.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
>>>> index eb31f850841a..5b98e8c7d8b7 100644
>>>> --- a/arch/x86/events/amd/lbr.c
>>>> +++ b/arch/x86/events/amd/lbr.c
>>>> @@ -321,7 +321,7 @@ int amd_pmu_lbr_hw_config(struct perf_event *event)
>>>>    void amd_pmu_lbr_reset(void)
>>>>    {
>>>> -	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>>> +	struct cpu_hw_events *cpuc = get_cpu_ptr(&cpu_hw_events);
>>>>    	int i;
>>>>    	if (!x86_pmu.lbr_nr)
>>>> @@ -335,6 +335,7 @@ void amd_pmu_lbr_reset(void)
>>>>    	cpuc->last_task_ctx = NULL;
>>>>    	cpuc->last_log_id = 0;
>>>> +	put_cpu_ptr(&cpu_hw_events);
>>>>    	wrmsrl(MSR_AMD64_LBR_SELECT, 0);
>>>>    }
>>>
>>> Weird, amd_pmu_lbr_reset() is called from these places:
>>>
>>>     - amd_pmu_lbr_sched_task(): during task sched-in during
>>>       context-switching, this should already have preemption disabled.
>>>
>>>     - amd_pmu_lbr_add(): this gets indirectly called by amd_pmu::add
>>>       (amd_pmu_add_event()), called by event_sched_in(), which too should have
>>>       preemption disabled.
>>>
>>> I clearly must have missed some additional place it gets called in.
>>>
>>> Could you please cite the full log of the amd_pmu_lbr_reset() call that
>>> caused the critical section warning?
>>>
>>> Thanks,
>>>
>>> 	Ingo
>>
>> Below is the call trace in case you think it's better to disable preemption
>> by the caller instead.  If you think it's better to keep it in
>> amd_pmu_lbr_reset() I'll add this trace to the commit message.
> 
> You cut too much; what task is running this?
> 
> IIRC this is the hotplug thread running a teardown function on that CPU
> itself. It being a strict per-cpu thread should not trip
> smp_processor_id() wanrs.
> 

BUG: using smp_processor_id() in preemptible [00000000] code: rtcwake/2960
caller is amd_pmu_lbr_reset+0x19/0xc0
CPU: 104 PID: 2960 Comm: rtcwake Not tainted 
6.6.0-rc6-00002-g3e2c7f3ac51f #1025
Call Trace:
  <TASK>
  dump_stack_lvl+0x44/0x60
  check_preemption_disabled+0xce/0xf0
  ? __pfx_x86_pmu_dead_cpu+0x10/0x10
  amd_pmu_lbr_reset+0x19/0xc0
  ? __pfx_x86_pmu_dead_cpu+0x10/0x10
  amd_pmu_cpu_reset.constprop.0+0x51/0x60
  amd_pmu_cpu_dead+0x3e/0x90
  x86_pmu_dead_cpu+0x13/0x20
  cpuhp_invoke_callback+0x169/0x4b0
  ? __pfx_virtnet_cpu_dead+0x10/0x10
  __cpuhp_invoke_callback_range+0x76/0xe0
  _cpu_down+0x112/0x270
  freeze_secondary_cpus+0x8e/0x280
  suspend_devices_and_enter+0x342/0x900
  pm_suspend+0x2fd/0x690
  state_store+0x71/0xd0
  kernfs_fop_write_iter+0x128/0x1c0
  vfs_write+0x2db/0x400
  ksys_write+0x5f/0xe0
  do_syscall_64+0x59/0x90
  ? srso_alias_return_thunk+0x5/0x7f
  ? count_memcg_events.constprop.0+0x1a/0x30
  ? srso_alias_return_thunk+0x5/0x7f
  ? handle_mm_fault+0x1e9/0x340
  ? srso_alias_return_thunk+0x5/0x7f
  ? preempt_count_add+0x4d/0xa0
  ? srso_alias_return_thunk+0x5/0x7f
  ? up_read+0x38/0x70
  ? srso_alias_return_thunk+0x5/0x7f
  ? do_user_addr_fault+0x343/0x6b0
  ? srso_alias_return_thunk+0x5/0x7f
  ? exc_page_fault+0x74/0x170
  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
RIP: 0033:0x7f32f8d14a77
Code: 10 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e 
fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 
f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
RSP: 002b:00007ffdc648de18 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f32f8d14a77
RDX: 0000000000000004 RSI: 000055b2fc2a5670 RDI: 0000000000000004
RBP: 000055b2fc2a5670 R08: 0000000000000000 R09: 000055b2fc2a5670
R10: 00007f32f8e1a2f0 R11: 0000000000000246 R12: 0000000000000004
R13: 000055b2fc2a2480 R14: 00007f32f8e16600 R15: 00007f32f8e15a00
  </TASK>

>>
>> Call Trace:
>>   <TASK>
>>   dump_stack_lvl+0x44/0x60
>>   check_preemption_disabled+0xce/0xf0
>>   ? __pfx_x86_pmu_dead_cpu+0x10/0x10
>>   amd_pmu_lbr_reset+0x19/0xc0
>>   ? __pfx_x86_pmu_dead_cpu+0x10/0x10
>>   amd_pmu_cpu_reset.constprop.0+0x51/0x60
>>   amd_pmu_cpu_dead+0x3e/0x90
>>   x86_pmu_dead_cpu+0x13/0x20
>>   cpuhp_invoke_callback+0x169/0x4b0
>>   ? __pfx_virtnet_cpu_dead+0x10/0x10
>>   __cpuhp_invoke_callback_range+0x76/0xe0
>>   _cpu_down+0x112/0x270
>>   freeze_secondary_cpus+0x8e/0x280
>>   suspend_devices_and_enter+0x342/0x900
>>   pm_suspend+0x2fd/0x690
>>   state_store+0x71/0xd0
>>   kernfs_fop_write_iter+0x128/0x1c0
>>   vfs_write+0x2db/0x400
>>   ksys_write+0x5f/0xe0
>>   do_syscall_64+0x59/0x90
>>

