Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB7C7D5A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344128AbjJXSbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344120AbjJXSbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:31:09 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6EA129;
        Tue, 24 Oct 2023 11:31:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RX8NQ/yzhVOcK6Hs4WvBMosBHcxApIiCZTCGTzRegSVDo9vyu8O/XQHS+xpoNaIOuNJZq7cncwbBNdOiTfMsHf9ySKBczMdLvdQ4jfwsGKYW23hB+PY6lb0Pp0koEorhWYzoJdZhr5bffhr2oKDeJs2nB7sE7H88iJDetA9ITxLXUVmuKqCUjZcIjMx70f88sfSpNMwOp4tMctbQTj3AK7lC06TehlpCv6zbRQ/7SpIj28cLmPS+6H2nWdWr0gupZqeP4fRo+waZ/A1NzdSSuALOy4XShQTGPoUIlAQf8JDf4TuZOk3kXZC3X9QRGi/eH0Z9Rt5UTVSgWnGKhaNLKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iw+x/zAlPQ9632uJkcJFojF3VCQN2SsFx8Nynr9+5iE=;
 b=dx6raeZi7pdz6jS43Sx7xThRBo7/qjWnwnU82A3fJMdUD5EQvOSbDAbiIeeIWIFDmJLl57DTJ+eHpf5Agv0QPvUBvAkCpzsUzyg2liRR1tzYWGbKhLfq07DMdkQ3vCesUTY3rr++K5HeYLFMOKKwO+m4XA0GJIFkntWRGaF0MFWw3++MaERgIOZHUOjTORJk9jOMG8dfXhenegJh6QL8hA36pV/j6Ze24+iXzsVcHXncimnSYn9tj2Ivtv5QzZ9oW49caFaMCkT9NJKqoywjdciXO1qqa0b+cKgBVihGTv4FuIeJ8bQZkgW104pE9kmKWEXO7a027t2QDplVuNnTHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iw+x/zAlPQ9632uJkcJFojF3VCQN2SsFx8Nynr9+5iE=;
 b=g1CEeXOBctyR3mrH0+NTKcERz/qCGEqzHGXxT6/Vzrg/DuXxUlWZHkSfE4y4DixuLiXsFtHkITCNgJmo9M8hZvFhTbzdD0c+hK/57IXZh+a/lt5Gsew/2lYJRKRJUP5Toh/TYtCsKXify8SrMl3+ABMifnScfKauSDcYn/L458w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB5456.namprd12.prod.outlook.com (2603:10b6:a03:3ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Tue, 24 Oct
 2023 18:31:03 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%4]) with mapi id 15.20.6907.022; Tue, 24 Oct 2023
 18:31:03 +0000
Message-ID: <0022df64-b7f5-43b4-87ed-5df5d47c5c6a@amd.com>
Date:   Tue, 24 Oct 2023 13:30:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf/x86/amd: Don't allow pre-emption in
 amd_pmu_lbr_reset()
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
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
 <ZTd6BYr17ycdHR2a@gmail.com> <ZTf2IxAVPUFq91F4@gmail.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZTf2IxAVPUFq91F4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS0PR17CA0013.namprd17.prod.outlook.com
 (2603:10b6:8:191::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB5456:EE_
X-MS-Office365-Filtering-Correlation-Id: 2577aea7-c0e7-41d7-9e83-08dbd4bf60c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Fj4X0Xyi2uGeoAxj/GeRoY149kJeKR48cQXBsuF7VX/TkDAtTUu252Seicz5HKgNwPFdwj4XEl/UpwxsqAAhNbazpGWgPyqjzIMwvgB/oRv7O/+Jz6fjyf5JhuU1udB2OE1/dY5hJjDQp47MvqJ+xoKyIsoSxnofDgbTlni4hRzuzpiGFO00lQPqazKBjjnMAaCQ9O+uBGkmXdQxyrSmxgANSSdetgdbjhRUOO4ChNfxwvUvvr6Le788pVGUAYUkOpNqG3eX4mRrJ6EmgQgHZQwBIRfZxijh58vXP6KAEMFIxNPuQgy6hkIfhEpaBbHjx8C2UqyZPUUsk64sPauu3OdNEpQnpJlJiIhOYzpX/e7Qg59miLdopfgI0avwBsc+63H/iCyd7KDf8FV+uke2b+yqPn2PgziwGniERoW0aC/NvW3h32rXBPiGaqWbWibb93PVAh8F3nbJnKz2WISBIxO7K/3AdCSxLlXXk1YYwuEs+OmcbjGfMsKdVdwHeE0lqJMd/Ip4iET6L5ssVI1/W7PGw4h9DS8IFrF5kF6I/e+7l9EOgjL/qfDpmjEa2z197vJOIonxn3qHd7gD/HE9YA1goZMQ3lhrQYyjLg2zM3s0oS4Ounp5BjR5eQwevkIgK8BZay9xMGRIruhVVCJ3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(7416002)(2906002)(4326008)(8936002)(44832011)(8676002)(83380400001)(6486002)(53546011)(31696002)(31686004)(41300700001)(5660300002)(6666004)(6512007)(6506007)(86362001)(6916009)(316002)(26005)(478600001)(2616005)(38100700002)(36756003)(66946007)(54906003)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFU0bnFLMVB1RnpJZHc2V2QvczJlS21VS1RvZElBNnMzRzdKb0Uvayt5OWJa?=
 =?utf-8?B?R0dJbkN0VEJIcko1WFJ4RWFXVG1JeXN1dW5vcHluRnY5VWhidk1Lbm1IOEMw?=
 =?utf-8?B?b1Y0eFFnazMwVmlVWkwrTGxiL25wODAySmt0OS9URmpaTmNHV2hvOTdkTElJ?=
 =?utf-8?B?Mm1sSEhuTWo5UHNYczFCdjhhcFl0TzZEekcvZmlFdWh0YmMwa2JVZVFxVXFn?=
 =?utf-8?B?ekZrSUVQd3NKY2pQY2dmTGdHczZQVmdUNHdFSjFHcys1cjVRVnoyRW96YmVa?=
 =?utf-8?B?SFpuQUVDcklMU2QreUJOTkRScHZvVFlJUTN5OUM1SFZqZzdPajE5MVU3TSs2?=
 =?utf-8?B?c1VNMXlnMHBveEtNTnp1em5Dc1Z1VDEyMTBFRTNyazYwTkx6RHMxYjdiRnJV?=
 =?utf-8?B?K2xKOVQ2NS96UzdZcXZhWEZUWDJyRjhvRDdEN08xbXBXcmhOY0YrR09RMzRL?=
 =?utf-8?B?SDZKU1kwNUZTOC94TVBTMEpERmZJNk04WWQ4cVVIeDFJVVF1UDJpNVZGTkNW?=
 =?utf-8?B?N2tPK3k5TVNKT09LTDZRbjFydkx6K3J3WGRCd21kWGdUcEw1NXpmUFBXQTJE?=
 =?utf-8?B?b1hOM1Y3LzM3TkJ1UWJkemFGSk1JTVJSUnlobGdaek9MQzBjWVBoNmV4K0FB?=
 =?utf-8?B?SVU4VUtxSlFjb29SMHdLZGNnWHJWWFZUMWE5bkdRSVhnMGpRZkFxcnIwekh2?=
 =?utf-8?B?bW42NzF2NjU0OGJEb2JCNTRyelQ1M3FBeE91Sld3YUNJUndLYnRlaTMrVVFm?=
 =?utf-8?B?THZxcHQ0VW5LU3RkTjF3ZFg2aUNKblFCTlRxSFNJY3pxcXJOWGgrZ25iN0pJ?=
 =?utf-8?B?OGdlMEpab1JTZ3Q2QTIrZ3NKUlpHMWpvcXJ0cFJRZUxaY2VpNlZXaTlmYWp0?=
 =?utf-8?B?MjNsK1Y0S3lZbS9vU2ZMdHJoMmJPSG1EcVNYcGFsRzV6SXpYVFV0NXI1emUz?=
 =?utf-8?B?YzdqdGppZTQ1ZVA2ZktnR2JmVlRReFlDaFlIcHFHSnVNZitvWGF1SENGUDF2?=
 =?utf-8?B?YWRiaUtTNjdlK2FueElJVGxXOXc3QUhnZ1MzcjZPdXR4TnN1WCsxSmZZOEc2?=
 =?utf-8?B?VWZad3VqcTdwcHBTclJnNE80SFd3RGFzRU5sd1JTYmcwR0xUckxMckdjbGlm?=
 =?utf-8?B?QUR0c2pNY2J3S05Rc1dsUEJKalgwQlFwaVpUYjdGVzBKUFJCU21LTzlPQXNY?=
 =?utf-8?B?L1l6SW5Pb0pOUFNEOWVCMS9MQ3RwVEtOcHZXamVrOURUQk8vZXVTb2lMdXpt?=
 =?utf-8?B?dEpuS0p1SkFwRFh6MzZTVWpNYjNYVSs3Z0x4cXZHc2s4eGpmY1FhODVNY21Q?=
 =?utf-8?B?WnV6V1dPcEJ0d3VQb21uS0ZxNEsrZ3BjQzBIYm5TbjIrSWxsdlpRcnp3M1VY?=
 =?utf-8?B?RHNlYkpSV3Q0Vngrajl2S0lDRlZoeFhsSXFkS3REQVp5QnRvcnllZjZSQ0tl?=
 =?utf-8?B?UktTSk5SZzZIcC9vbnNycGE0SlhmeTZiVjFKVSs0cFkzaldTNmczbWY0R25Q?=
 =?utf-8?B?NndWc2Q3QmVlR0FhSHB1a0lsMFdVbko4SUtNOHZFazRDZnVpaDRUdWlvak0z?=
 =?utf-8?B?QTNpVXVrd29kdWNuWHFyZ0R1eGpobVEvcFBab3dyN1d3LzE2UkpJWnM0N1o1?=
 =?utf-8?B?NlQ0L2RzQ29INlpkVzI0Y2kwUmx5T2hZcE9WOEpBV2E3YkVHYldUTzdBaFJp?=
 =?utf-8?B?L2ViTXl4WUovRUJodkNKanVLb083aXd0czJQeDB4TjRRTUNmV3NoQngxaW1o?=
 =?utf-8?B?RVlRQ29RalJlbTVXeS85RnBYOU9mZlhmc250MitaRlNGOHpSK3ZrK2RLZjVE?=
 =?utf-8?B?NEw1NDh2YUh4ekZOYVd1MWtEOUdFT0tFUU1zSk1qeWxrc2k5VFVkZFlBeDEw?=
 =?utf-8?B?Q21mUWh5cG90WVJRWFYwdHR4TzhNUGl6RjhzQXhCN0h2QmpEMzc3UytyRGVw?=
 =?utf-8?B?UmpnT1dzd1VhUjdqUG1OdEpOTE1aMUVISTBiUXZIb1JzTEhBK29XMGpBaWFY?=
 =?utf-8?B?djlNVUFPdFVJWUt1UkdLQVd3OExWUm5kVndZbk1rd3NTM0pyZ0Z1TWx5dW5R?=
 =?utf-8?B?VVpYVm9lY0RqQkJLKy9XVmRyQnFyWW1xV1FHYmlKeUFCSStvQm5aRGdiUmE1?=
 =?utf-8?Q?S+N0p6dXC37xGipGCn59ZC5+v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2577aea7-c0e7-41d7-9e83-08dbd4bf60c1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 18:31:03.2449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbdfaiaaVur5ldaNSoihWHbwEHVGW0nuEPXlfm5IEKrXxv3sgKMaoMNdMWuWIl1yq6xHmFc5fYSkVaoXnwPJlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5456
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/2023 11:51, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
>>
>> * Mario Limonciello <mario.limonciello@amd.com> wrote:
>>
>>> Fixes a BUG reported during suspend to ram testing.
>>>
>>> ```
>>> [  478.274752] BUG: using smp_processor_id() in preemptible [00000000] code: rtcwake/2948
>>> [  478.274754] caller is amd_pmu_lbr_reset+0x19/0xc0
>>> ```
>>>
>>> Cc: stable@vger.kernel.org # 6.1+
>>> Fixes: ca5b7c0d9621 ("perf/x86/amd/lbr: Add LbrExtV2 branch record support")
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   arch/x86/events/amd/lbr.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
>>> index eb31f850841a..5b98e8c7d8b7 100644
>>> --- a/arch/x86/events/amd/lbr.c
>>> +++ b/arch/x86/events/amd/lbr.c
>>> @@ -321,7 +321,7 @@ int amd_pmu_lbr_hw_config(struct perf_event *event)
>>>   
>>>   void amd_pmu_lbr_reset(void)
>>>   {
>>> -	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>> +	struct cpu_hw_events *cpuc = get_cpu_ptr(&cpu_hw_events);
>>>   	int i;
>>>   
>>>   	if (!x86_pmu.lbr_nr)
>>> @@ -335,6 +335,7 @@ void amd_pmu_lbr_reset(void)
>>>   
>>>   	cpuc->last_task_ctx = NULL;
>>>   	cpuc->last_log_id = 0;
>>> +	put_cpu_ptr(&cpu_hw_events);
>>>   	wrmsrl(MSR_AMD64_LBR_SELECT, 0);
>>>   }
>>
>> Weird, amd_pmu_lbr_reset() is called from these places:
>>
>>    - amd_pmu_lbr_sched_task(): during task sched-in during
>>      context-switching, this should already have preemption disabled.
>>
>>    - amd_pmu_lbr_add(): this gets indirectly called by amd_pmu::add
>>      (amd_pmu_add_event()), called by event_sched_in(), which too should have
>>      preemption disabled.
>>
>> I clearly must have missed some additional place it gets called in.
> 
> Just for completeness, the additional place I missed is
> amd_pmu_cpu_reset():
> 
>                  static_call(amd_pmu_branch_reset)();
> 
> ... and the amd_pmu_branch_reset static call is set up with
> amd_pmu_lbr_reset, which is why git grep missed it.
> 
> Anyway, amd_pmu_cpu_reset() is very much something that should run
> non-preemptable to begin with, so your patch only papers over the real
> problem AFAICS.
> 
> Thanks,
> 
> 	Ingo

In that case - should preemption be disabled for all of 
x86_pmu_dying_cpu() perhaps?

For good measure x86_pmu_starting_cpu() too?
